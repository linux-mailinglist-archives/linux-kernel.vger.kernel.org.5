Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42B47D7C64
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 07:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344043AbjJZFoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 01:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344159AbjJZFnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 01:43:53 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1646196
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 22:43:49 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9c14313eb1cso12794166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 22:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698299028; x=1698903828; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=88V44OaMqzEfkeGrh8z6B90RbiCDqgJggaF2dntJGPk=;
        b=K8wf96H4LRc6QjOiLRrG6e9mvnzp4xVJeLv/171VS7PHbHd4utsTJvlQQL+oSYe/qX
         MmI+9jAvaIktuhwyQtNUXoAVCdVqhyhA+/JD7TfdW8SeQ0p1jXKVksVyMM990oCRGHSk
         Qa1q9OEoOi1nKmTr7LLBX4z/w8s3ZCC8Pb+hE/xqk6ikHuLvtd0JIZf2iV/tRx5EW/RM
         i1ByMcOCYQRGGzvGGeFT9UpxKzQcnJrcTXmbGygBSauT+AMJKDe1BdV+aGDTT7kRaswg
         tHqars/5r9VE0WMm/po4yWoR8YTPpUHto4S23ZAkYdOgdXneT/u9jB7B0kS0+syJ8r6X
         zGKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698299028; x=1698903828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=88V44OaMqzEfkeGrh8z6B90RbiCDqgJggaF2dntJGPk=;
        b=FLXIX3/vdMykXP3sOywb6mManNa68NeacL3i+L26XfPOBYQ02QQYM0CJY2hB402/nz
         N+8mvzRaNAvCsSoy2yCAPLloNT1TTnH1dw4MMn7Uym8UGqosABLcKp1QOpqhNKG6c1R9
         wn6DxtEfdRdXq0Hg4S5+EJg6jyfpHQli8M7CWcEbQK6lcQHrEdFzw1pfnEisvfQvUdAs
         PUVzE6anJ6Xl5nxNklce0Bz1SRzXBYXiPu/sfQF9SonUmH/J1LMJ9jeiQE8ZULid6qyj
         dNHXCdLglwL3hPIK4hOC1Z+Qiz3OSzZ/F9WlGRAaW7ON6afPhGzMfBseWrW0xERdZWFX
         3Tcw==
X-Gm-Message-State: AOJu0Yw1LCB74gRGCRhZMaZ3/tj5w4mMEKKWm/PnQnmViryCV52eAP+Y
        yEvqTkuadDdi4pzFMqJLw70=
X-Google-Smtp-Source: AGHT+IEh+u4jpdjbIJqbo2Ldz4i9wPwoXV0a9R2mNz6qXxFITxd6hw61qP7e1ejbDjR3G/RPhadrMA==
X-Received: by 2002:a17:906:ac7:b0:9cb:b7d3:bcf0 with SMTP id z7-20020a1709060ac700b009cbb7d3bcf0mr5815415ejf.1.1698299027935;
        Wed, 25 Oct 2023 22:43:47 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id t11-20020a1709066bcb00b009be14e5cd54sm10978154ejs.57.2023.10.25.22.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 22:43:47 -0700 (PDT)
Date:   Thu, 26 Oct 2023 07:43:46 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 03/10] staging: rtl8192e: Remove
 HTIOTActIsDisableMCSTwoSpatialStream()
Message-ID: <a446837ff1107c81f52d3cf9e727d6ef4e2678af.1698295861.git.philipp.g.hortmann@gmail.com>
References: <cover.1698295861.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1698295861.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove HTIOTActIsDisableMCSTwoSpatialStream() as it always returns false
which leads to one evaluation that is always false. Remove dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index ea01cfce77d8..3cbadd6a0aef 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -207,11 +207,6 @@ static void HTIOTPeerDetermine(struct rtllib_device *ieee)
 	netdev_dbg(ieee->dev, "IOTPEER: %x\n", ht_info->IOTPeer);
 }
 
-static bool HTIOTActIsDisableMCSTwoSpatialStream(struct rtllib_device *ieee)
-{
-	return false;
-}
-
 static u8 HTIOTActIsDisableEDCATurbo(struct rtllib_device *ieee,
 				     u8 *PeerMacAddr)
 {
@@ -686,10 +681,6 @@ void HTResetSelfAndSavePeerSetting(struct rtllib_device *ieee,
 		HTIOTPeerDetermine(ieee);
 
 		ht_info->iot_action = 0;
-		bIOTAction = HTIOTActIsDisableMCSTwoSpatialStream(ieee);
-		if (bIOTAction)
-			ht_info->iot_action |= HT_IOT_ACT_DISABLE_ALL_2SS;
-
 		bIOTAction = HTIOTActIsDisableEDCATurbo(ieee, pNetwork->bssid);
 		if (bIOTAction)
 			ht_info->iot_action |= HT_IOT_ACT_DISABLE_EDCA_TURBO;
-- 
2.42.0

