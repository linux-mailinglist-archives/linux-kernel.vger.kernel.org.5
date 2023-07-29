Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C239B767CF6
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 09:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjG2HyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 03:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjG2Hxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 03:53:53 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DB73592
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 00:53:38 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99bded9d93dso67273066b.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 00:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690617217; x=1691222017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vBQvA7PidF0G5yJQQDU0VXGO4IEZc5NbIaIsAqJ7tbs=;
        b=Dp27GgGxBiNTmPkOQnVqGdr5F9RxNvkQ5/GOds9VxvAA5B77Gz/abPY0pFNhJlzKf9
         TLMA3+pF0vDCmdEEDUR/4EcelyeSmeA2LCtoPbSqazaRX56QXynyfXyWoHkjd0L8zZXg
         mw3qGcVhmPDKYENZo5HosFNbltgp+bqcFjj/vmVMYgv2VQ02mjWRVZABlYqGeHNNLbEA
         Im7dYI99T6/BwX2uDWe++/uEvMzU3fKEkQEc5ZgsMzSnWdnX7+gWhziRWTNUTnlfKbgg
         yKioxPKEa8G1dfwvTo5UFMK/d1BXKdzEUkjJl+f8UvMtxo1u5eeQvbcpIUEk1dhEmupS
         yV0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690617217; x=1691222017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vBQvA7PidF0G5yJQQDU0VXGO4IEZc5NbIaIsAqJ7tbs=;
        b=bZEaWiFhRFKOq/JOFQUYE9eCB47LcB3NpDGbs9fYlzaSpCXCapvIQ9mNAwnJE4H77Y
         mi219UaBosFiArC/DioFq4ptf6aqsEqt45qPCdKYKUMThnr6jv9im6NxLO85pcdFvnVj
         T+Mb/ZneNMYOsRyNoO8QQBOJ390cd7frsTOok1yGJAOu/ZQef9tcfc9tEAsqHC4af3+p
         515V1/Vcnt5z11aQEgIvFfuyi5s6iJxU9nF+WjU2kCo8xxfvy4KuMZ0IFIt5JF3GJ8si
         QNQdzOajrajJj9gbo5sUfq6JyeB01IIWEPoXJ8b6UsLYtLtw9kfwJjU5zCtNx4/M3PIa
         7JNg==
X-Gm-Message-State: ABy/qLYI/YgOrRhHN0HSUsV+9Oc7geCUryO2KPCLShqEog9ue40h56Wh
        JLT70EiJ5b5v3z9Vsa+kp5I=
X-Google-Smtp-Source: APBJJlHnz/pKlZ3uSK8sTzQwjoUEr9DWV7dXYRLLKsBz2TJlaMtBlL8BlZJMyYHQ7mFXqDLDQW6uxw==
X-Received: by 2002:a17:906:5303:b0:99b:4670:aca9 with SMTP id h3-20020a170906530300b0099b4670aca9mr1233266ejo.1.1690617217146;
        Sat, 29 Jul 2023 00:53:37 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2e0b.dip0.t-ipconnect.de. [87.186.46.11])
        by smtp.gmail.com with ESMTPSA id w23-20020a170906481700b009927d4d7a6bsm2987619ejq.53.2023.07.29.00.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jul 2023 00:53:36 -0700 (PDT)
Date:   Sat, 29 Jul 2023 09:53:34 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 08/10] staging: rtl8192e: Remove is_mesh from
 rtllib_softmac_scan_syncro
Message-ID: <9fcd1193c155ef992493af3526442fb84032166f.1690615475.git.philipp.g.hortmann@gmail.com>
References: <cover.1690615475.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1690615475.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function rtllib_softmac_scan_syncro() has unused parameter is_mesh.
Remove dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_softmac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 7b866b3a46ef..0e52b207942d 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -478,7 +478,7 @@ static void rtllib_update_active_chan_map(struct rtllib_device *ieee)
 /* this performs syncro scan blocking the caller until all channels
  * in the allowed channel map has been checked.
  */
-static void rtllib_softmac_scan_syncro(struct rtllib_device *ieee, u8 is_mesh)
+static void rtllib_softmac_scan_syncro(struct rtllib_device *ieee)
 {
 	union iwreq_data wrqu;
 	short ch = 0;
@@ -715,7 +715,7 @@ void rtllib_start_scan_syncro(struct rtllib_device *ieee)
 	}
 	ieee->sync_scan_hurryup = 0;
 	if (ieee->softmac_features & IEEE_SOFTMAC_SCAN)
-		rtllib_softmac_scan_syncro(ieee, 0);
+		rtllib_softmac_scan_syncro(ieee);
 }
 EXPORT_SYMBOL(rtllib_start_scan_syncro);
 
-- 
2.41.0

