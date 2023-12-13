Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C018B811A13
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377387AbjLMQvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:51:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235180AbjLMQvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:51:42 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE2EB9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:51:49 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50c0b80ca9cso1816255e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702486307; x=1703091107; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kpLILZybMq8C7TrSiZZZTJ8Dy9Fx0ctVyqk92THT1n4=;
        b=AWdW/78L0+WuWRd24JrYofK3/xjjTBnWdoBWhigLYscBtH3mw9slY6R3HAUZkNFhm2
         MtsO1pUvgXNE6e7DZqRMsmYWirEibE9zplshqwqHS5zNNRgdFJ50LQ/ShWRSFp0S4ODW
         /G0T2lvdaIj2Vn28rpC0TAe58FwEkwRTYVSPQQUImqULGnlcmtFR9oTLFDMX8/8oOis7
         nkY6WbpQC1zlRltO/KA8smqjNIhoFztXw2+1cuswq0HB1gEq91fZVqpizU8fWIVdbqwE
         MuF3QFETmovexyL3L88uJaLE3bN6Yp2q8tIqhwjBhcvXFrfTObkLxdYou8Yj05cb3ckp
         7JVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702486307; x=1703091107;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kpLILZybMq8C7TrSiZZZTJ8Dy9Fx0ctVyqk92THT1n4=;
        b=UCxR0BqF73oaoq7EH9LBg8llbB3qhExCVKgK5rF/+QvdZZ/Fp0IQDhEdHDPK+7j/Hj
         zYkfVSYgywIfq1GPA952cL43nO9s50dUeZOX2HSPBItZk4/t56DJB801WhRXKEOtcL8B
         LgjrWHKYff+yGDFTT7TPmDX+yiq16TfgYFMDsw1hqFCtZ8giWtn8PxamDe5CUhzAtcvA
         UuOx9P/77tHRq/ITZrS04E20N1jqU0C+AIQDWyvafklKFoC1U40EYDJZWn11Mn4bmzMv
         wPg7K1dgVcwjU1zVIwLxK8VHxsZ5CnJbOR9ZGXHBpERJ2wQ1UXVbVjfXnlXynwzO5Bnv
         XCew==
X-Gm-Message-State: AOJu0YyWFIKWWAb+l6ScBu1VdJkBKgOJkUu6UmNRSQHaeHjFCmrUaTf9
        0aiEHIw9G+qrHd8HK16Yw+A=
X-Google-Smtp-Source: AGHT+IHegFYCIVbFE9geK7mbBeYfgRPIjFQzEeqpn4vOr5F8BpRRP1ziLsP6Pyc0LaeWlqJduRfhrg==
X-Received: by 2002:a19:4f0a:0:b0:50c:1bc:33e3 with SMTP id d10-20020a194f0a000000b0050c01bc33e3mr6387897lfb.2.1702486307057;
        Wed, 13 Dec 2023 08:51:47 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id sk13-20020a170906630d00b00a1d232b39b3sm8172682ejc.145.2023.12.13.08.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 08:51:46 -0800 (PST)
Date:   Wed, 13 Dec 2023 17:51:45 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 02/10] staging: rtl8192e: Remove unused variable nMaxAMSDUSize
Message-ID: <4df74fda70535ddbdfc90ba7c98e9d4a773f944d.1702406712.git.philipp.g.hortmann@gmail.com>
References: <cover.1702406712.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1702406712.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused variables nMaxAMSDUSize and amsdu_max_size.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl819x_HT.h     | 1 -
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 4 ----
 2 files changed, 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index bf87106dd784..ff0eb0d01022 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -102,7 +102,6 @@ struct rt_hi_throughput {
 	u8 PeerHTCapBuf[32];
 	u8 PeerHTInfoBuf[32];
 	u8 amsdu_support;
-	u16 amsdu_max_size;
 	u8 ampdu_enable;
 	u8 current_ampdu_enable;
 	u8 ampdu_factor;
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index cb8150137858..379934a71f87 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -71,7 +71,6 @@ void ht_update_default_setting(struct rtllib_device *ieee)
 {
 	struct rt_hi_throughput *ht_info = ieee->ht_info;
 
-	ht_info->amsdu_max_size = 7935UL;
 	ht_info->amsdu_support = 0;
 
 	ht_info->ampdu_enable = 1;
@@ -436,7 +435,6 @@ void HTOnAssocRsp(struct rtllib_device *ieee)
 	struct rt_hi_throughput *ht_info = ieee->ht_info;
 	struct ht_capab_ele *pPeerHTCap = NULL;
 	struct ht_info_ele *pPeerHTInfo = NULL;
-	u16 nMaxAMSDUSize = 0;
 	u8 *pMcsFilter = NULL;
 
 	static const u8 EWC11NHTCap[] = { 0x00, 0x90, 0x4c, 0x33 };
@@ -471,8 +469,6 @@ void HTOnAssocRsp(struct rtllib_device *ieee)
 	ht_info->cur_short_gi_20mhz = ((pPeerHTCap->ShortGI20Mhz == 1) ? true : false);
 	ht_info->cur_short_gi_40mhz = ((pPeerHTCap->ShortGI40Mhz == 1) ? true : false);
 
-	nMaxAMSDUSize = (pPeerHTCap->MaxAMSDUSize == 0) ? 3839 : 7935;
-
 	ht_info->current_ampdu_enable = ht_info->ampdu_enable;
 	if (ieee->rtllib_ap_sec_type &&
 	    (ieee->rtllib_ap_sec_type(ieee) & (SEC_ALG_WEP | SEC_ALG_TKIP))) {
-- 
2.43.0

