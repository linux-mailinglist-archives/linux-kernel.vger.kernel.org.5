Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC127B47A6
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 15:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235012AbjJANoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 09:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbjJANoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 09:44:06 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913A1B0
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 06:44:02 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-523029050d0so3835532a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 06:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696167841; x=1696772641; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tpJqPIVcZcjgtPzZR6Y1+bljvbB1Yn2y5DRCpOzZBaw=;
        b=iTQ5YB3sdeKxQhtEGCLDmo8/6kHs3kQi47YYSmGrWB2BO+6+ORqAVNMuAxNjhbFUcZ
         JOrqvLq86J8ht2t3rGOOpf9MPvQRcOW1n/PM6ZOTxQV64GjgRgzYxt5kQG45sgDw6qfT
         WI+eiJNZkaVvpsP+K6ZPX882IYKU+7oKLgtCqof1E1apWdrUerNeLVueNFNpkiLvF1mm
         Xo5hNgkViXEOUENsXVFqn2jJPDNqsNUlw8NE7BCplnSw24vkmDlAb7z4RgVJGPwuCo0e
         +OWo5O6gN55Qg0S2MvEUx0QDD6xvi7ctlJu98NihCrVAa9PiGxWu9+xzMXuDeqVNqzHc
         1xYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696167841; x=1696772641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tpJqPIVcZcjgtPzZR6Y1+bljvbB1Yn2y5DRCpOzZBaw=;
        b=M1ti0ezW26+wWrVKUiRTAPZsSyxURMoztPsFxLlWflmuwQTBl7FbOhN8K52nbq1mmN
         pUShanWI12H+1Eb4NVVoJYONvVh3QK7RgjqzDdJdYUQt+58ypR38dBSP3r3ICNmCY/FE
         Ym0Ha728B8zqfiry2LSANW1baKxwSoIJ6Pauo7oaVMtUyj4D23mWH26RKokVILCnhARj
         iQ7npxjCdrQoo55v6eg1AuGDbfoBD65YQ6vxMZyLZ8hBBlPOgJLLApCNE4BPCazldUPH
         vAxuq7xUazpgjCE7FWUHXaDEtN/5D2klKMlNM1hmINKHqBxgOFxITWBbETvr+ThBCR+q
         d4SA==
X-Gm-Message-State: AOJu0YxArfsPqcxu7K8J3GhNp6t3VjsDGJbzg1JH5ezhIyElWScpr4Bl
        eit37biuYLSr1i6x/O50iJ8=
X-Google-Smtp-Source: AGHT+IF5OXRGF43i9gacuTZV4oRdQf2af9FFA391ivlSZkh5dYNLjj+RmPxYqv/6QsIHztrK8uwkdw==
X-Received: by 2002:a05:6402:2790:b0:52f:bedf:8ef1 with SMTP id b16-20020a056402279000b0052fbedf8ef1mr8458721ede.3.1696167841055;
        Sun, 01 Oct 2023 06:44:01 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id d15-20020aa7d68f000000b005333922efb0sm14083826edr.78.2023.10.01.06.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 06:44:00 -0700 (PDT)
Date:   Sun, 1 Oct 2023 15:43:59 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] staging: rtl8192e: Remove ibss_maxjoin_chal
Message-ID: <7c5d512a69e5832263a0a2e8f4ea3608fe286a09.1696165351.git.philipp.g.hortmann@gmail.com>
References: <cover.1696165351.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696165351.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove ibss_maxjoin_chal as it is just set and never evaluated.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/dot11d.c | 3 ---
 drivers/staging/rtl8192e/rtllib.h | 1 -
 2 files changed, 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/dot11d.c b/drivers/staging/rtl8192e/dot11d.c
index 82c11caeee7a..d0b7332645be 100644
--- a/drivers/staging/rtl8192e/dot11d.c
+++ b/drivers/staging/rtl8192e/dot11d.c
@@ -73,19 +73,16 @@ void dot11d_channel_map(u8 channel_plan, struct rtllib_device *ieee)
 		for (i = 12; i <= 14; i++)
 			GET_DOT11D_INFO(ieee)->channel_map[i] = 2;
 		ieee->bss_start_channel = 10;
-		ieee->ibss_maxjoin_chal = 11;
 		break;
 
 	case COUNTRY_CODE_WORLD_WIDE_13:
 		for (i = 12; i <= 13; i++)
 			GET_DOT11D_INFO(ieee)->channel_map[i] = 2;
 		ieee->bss_start_channel = 10;
-		ieee->ibss_maxjoin_chal = 11;
 		break;
 
 	default:
 		ieee->bss_start_channel = 1;
-		ieee->ibss_maxjoin_chal = 14;
 		break;
 	}
 }
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index bdbd27e382b9..aa198983cb3c 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1339,7 +1339,6 @@ struct rtllib_device {
 	u8 active_channel_map[MAX_CHANNEL_NUMBER+1];
 
 	u8   bss_start_channel;
-	u8   ibss_maxjoin_chal;
 
 	int rate;       /* current rate */
 	int basic_rate;
-- 
2.42.0

