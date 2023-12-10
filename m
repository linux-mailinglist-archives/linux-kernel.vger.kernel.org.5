Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D1B80BBF1
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 16:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbjLJP0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 10:26:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbjLJP0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 10:26:08 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8599C4
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 07:26:13 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40c2655da63so5702935e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 07:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702221972; x=1702826772; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IXZChcAWYyXJ3xwEo34Bj3n8r/lOSA4PWuJHfRPgZ7U=;
        b=B2Lfq/RiuXh36LmwWl+Xvk9UMq1OIFpOnW4LB4Rn6qLzLTgmdY8TOTtbHn9AFb865T
         p9IELjOhMO1TILYEKfOnkxjVC0Z2OPJba/H997X69tZvVGsngB0PEF8MwPCY0Le0Ylhz
         EsmItVlxB/ZGxrsC99ElurTQ9aXIqRLnpbenEC/5HprAIPKElc3j0kYKq6eYrfDq4XDh
         JxkEotB3J/Jp/E0lxy7w9LUmH5MkekkMADlgWOuN9HHOSIg9IjnF9Gt4KDfCSchakgeX
         qF2jPgqTXWALigBL+1lJcyZGiKGwZk3OLAEHG6UEHdrnA2tkeQd9E5/22TaaSdAcqjzj
         tNSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702221972; x=1702826772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IXZChcAWYyXJ3xwEo34Bj3n8r/lOSA4PWuJHfRPgZ7U=;
        b=SqMglXy/rzspOlszVhehrVjXOWqk2eRC3YVZQcHbTtph2Az8VH41oODWKL2ER4BF32
         IruUyhqUicm3qoXYJj6JDSj6HH+k1xfgBoP8k4gm24dqvIQIvgBOBmTXugXPRnLN0Gk0
         30kG9arRfUnZQP0UgcEZE27cvDsFpyeIdiueu1JoGR2x1ZEz0B3/wHFPqJA3slcKMMYA
         hcJKVmriZ75obfdquWRVLvL9X7mXVxj4LU0VWgKbNKfRlUZ1cPI6UNlI8AmCcaIrOYrR
         dwqz++k4EXPfiRg92zdFTWYHAJcqTnuKH8B81tFOjghV+sTzxz8dB/FyXg3JCg4tPKbk
         eVaw==
X-Gm-Message-State: AOJu0Yw2nPOecG9zdz9KfmZEm/XtQ7ARn2/ed51kLsn2sVehTIhyLtwD
        hZKhsnyeHQjedd9tkIEi3Yw=
X-Google-Smtp-Source: AGHT+IGqLnNPjUYQ+YdfgFxcsr4GPTxHvUrBPwPPACa9RwN6TVPv8JLz4sYFmXnX/YuMpO+AmBVXKg==
X-Received: by 2002:a05:600c:35d6:b0:405:358c:ba75 with SMTP id r22-20020a05600c35d600b00405358cba75mr4025647wmq.0.1702221971674;
        Sun, 10 Dec 2023 07:26:11 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id k40-20020a05600c1ca800b0040b45356b72sm12132495wms.33.2023.12.10.07.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 07:26:11 -0800 (PST)
Date:   Sun, 10 Dec 2023 16:26:10 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 02/10] staging: rtl8192e: Remove variable
 ht_info->reg_bw_40mhz
Message-ID: <4ff7afdc2ada8095c95f053381834cea9f5796bf.1702212003.git.philipp.g.hortmann@gmail.com>
References: <cover.1702212003.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1702212003.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ht_info->reg_bw_40mhz is set to 1 and unchanged. Therefore all equations
result accordingly and ht_info->reg_bw_40mhz can be removed.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl819x_HT.h     |  1 -
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 14 +++-----------
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index c004020099e3..bbfdfb79c6f2 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -94,7 +94,6 @@ enum ht_aggre_mode {
 struct rt_hi_throughput {
 	u8 enable_ht;
 	u8 current_ht_support;
-	u8 reg_bw_40mhz;
 	u8 cur_bw_40mhz;
 	u8 reg_short_gi_40mhz;
 	u8 cur_short_gi_40mhz;
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 99626be899fd..f81d9ba9c9f5 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -74,12 +74,7 @@ void ht_update_default_setting(struct rtllib_device *ieee)
 	ht_info->reg_short_gi_20mhz = 1;
 	ht_info->reg_short_gi_40mhz = 1;
 
-	ht_info->reg_bw_40mhz = 1;
-
-	if (ht_info->reg_bw_40mhz)
-		ht_info->reg_supp_cck = 1;
-	else
-		ht_info->reg_supp_cck = true;
+	ht_info->reg_supp_cck = 1;
 
 	ht_info->amsdu_max_size = 7935UL;
 	ht_info->amsdu_support = 0;
@@ -275,7 +270,7 @@ void HTConstructCapabilityElement(struct rtllib_device *ieee, u8 *posHTCap,
 	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev))
 		pCapELE->ChlWidth = 0;
 	else
-		pCapELE->ChlWidth = (pHT->reg_bw_40mhz ? 1 : 0);
+		pCapELE->ChlWidth = 1;
 
 	pCapELE->MimoPwrSave		= pHT->self_mimo_ps;
 	pCapELE->GreenField		= 0;
@@ -286,7 +281,7 @@ void HTConstructCapabilityElement(struct rtllib_device *ieee, u8 *posHTCap,
 	pCapELE->RxSTBC			= 0;
 	pCapELE->DelayBA		= 0;
 	pCapELE->MaxAMSDUSize = (MAX_RECEIVE_BUFFER_SIZE >= 7935) ? 1 : 0;
-	pCapELE->DssCCk = ((pHT->reg_bw_40mhz) ? (pHT->reg_supp_cck ? 1 : 0) : 0);
+	pCapELE->DssCCk = (pHT->reg_supp_cck ? 1 : 0);
 	pCapELE->PSMP = 0;
 	pCapELE->LSigTxopProtect = 0;
 
@@ -734,9 +729,6 @@ void HTSetConnectBwMode(struct rtllib_device *ieee,
 {
 	struct rt_hi_throughput *ht_info = ieee->ht_info;
 
-	if (!ht_info->reg_bw_40mhz)
-		return;
-
 	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev))
 		bandwidth = HT_CHANNEL_WIDTH_20;
 
-- 
2.43.0

