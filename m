Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E44A8062CE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 00:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346638AbjLEXQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 18:16:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346607AbjLEXQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 18:16:18 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26754D50
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 15:16:17 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id B60DB3200AD7;
        Tue,  5 Dec 2023 18:16:16 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 05 Dec 2023 18:16:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1701818176; x=
        1701904576; bh=dEEod0DePXSazwGj2wk28U/n46ayXATcrF5/D6Y7f5k=; b=T
        qdkktG6ySDg9CiX687Kt8l/FJlXkYlFXOk6mcmXPmNpmlYEDCvV8wQdivVylvU7E
        1U3VTm2p6UnB30G1bXr9Kp3eriv76u+9Z7mqi7FkrDvsRmtX6GFKdaF1fGaGxR9H
        +rkTLpAW+x0UUujOLdF4qp9dL9erN/dw+MWJqj1IeYGmRz46wqNauqZS3qG3c79g
        OmgFkHufvpN7wfSvd5oXpR+kcuHJKRZveCVVtEcx/iDp7Q2r3RwrqapkskQXond9
        YxQ2Bk4SVUGI2pKjm3nuVkYxwvo1lxkUoYlnj8KHg5gb91Jj4DJWwCSWaCYS3I2F
        UucivT+AMHK8EtrHl/v+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1701818176; x=
        1701904576; bh=dEEod0DePXSazwGj2wk28U/n46ayXATcrF5/D6Y7f5k=; b=z
        tuz+cTUwgKV4/+rjW/tfFNJ7PRdc877EniRLFvptNYXjWgPPgYim8Gz+2h96yXwF
        nN8QEMQYLSF1RJ6ew9EtN15V7Uyj0VEmopjpY5dvb3wCYC8g5ch3M4IePrxlUVTF
        rRJ/5p2K5d56AWVl/ABlTmkS1BR9xG/xZ/zy4Y5ZhPpb4PvIJtzQkb0jO7PNPQB/
        AxdcSenJrha3L19kHI+NyYQ92SaLuhHOxgq9oVPesy901ohlwywZYfZ1ycMLpdfZ
        4+5bJ9w49107s8zbAwwnRu+Gki6na05X7fMS38lEBIXVjd4xmdP/FvsX1Ofx04W6
        YcnzorgTMTcqQUOczZDVQ==
X-ME-Sender: <xms:QK9vZV68r8LWxodn7AqL8XAml2Ux2ypD9ql53WKtfWQ2xSO-Ocrldg>
    <xme:QK9vZS7ErToe7PZiX3Vd_s8ED-cf7EEANjOqbWBHcv0z2zjZoHrU1Sd5lPgW9zIp-
    -0cSFffG8oL21HCXvw>
X-ME-Received: <xmr:QK9vZcczBtCmiXuy0cWG-JyzXsaU0g_6w7SB36VOhJa2qVHwhxiT_Yu_S_gBBOCH8Yta49ubOKgnWeHftT3wTIGD7gxAnK_xTRWVysDNkxI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudejledgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgr
    rhgusehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepkeeuvdffueduke
    egieeuffejhefgkeetfeehueelfeduuefgveellefhfefgjedvnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghgrrhihrhhoohhkrghrugesfh
    grshhtmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:QK9vZeJBgLenYFvDNDlZacKXvECM1ARHgNpRYlsa5S7_bekAOR7wrA>
    <xmx:QK9vZZLdaFEjfPvjKcFJABh_TQ1EA5-vQR3NAMUtBv5Z4baRAxyW6Q>
    <xmx:QK9vZXwfNkDrXGhs2K3UmvcqoN2l7n2qcgtu6TdLf4LdR_E6juYwJg>
    <xmx:QK9vZZ14HFufDkOISLLY2Zlb5fomPHqdNDRODNKovCFC48XLGghR7w>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Dec 2023 18:16:15 -0500 (EST)
From:   Gary Rookard <garyrookard@fastmail.org>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH 3/5] staging: rtl8192e: renamed variable bRegBW40MHz
Date:   Tue,  5 Dec 2023 18:16:21 -0500
Message-ID: <20231205231623.23070-4-garyrookard@fastmail.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231205231623.23070-1-garyrookard@fastmail.org>
References: <20231205231623.23070-1-garyrookard@fastmail.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coding style issue, checkpatch Avoid CamelCase,
rename it bRegBW40MHz -> reg_bw_40mhz

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
 drivers/staging/rtl8192e/rtl819x_HT.h     |  2 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index 825c60cbcacb..ef88d7d713fb 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -94,7 +94,7 @@ enum ht_aggre_mode {
 struct rt_hi_throughput {
 	u8 enable_ht;
 	u8 current_ht_support;
-	u8 bRegBW40MHz;
+	u8 reg_bw_40mhz;
 	u8 cur_bw_40mhz;
 	u8 reg_short_gi_40mhz;
 	u8 bCurShortGI40MHz;
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 580b1423c46b..68ad082d41be 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -74,9 +74,9 @@ void ht_update_default_setting(struct rtllib_device *ieee)
 	ht_info->reg_short_gi_20mhz = 1;
 	ht_info->reg_short_gi_40mhz = 1;
 
-	ht_info->bRegBW40MHz = 1;
+	ht_info->reg_bw_40mhz = 1;
 
-	if (ht_info->bRegBW40MHz)
+	if (ht_info->reg_bw_40mhz)
 		ht_info->bRegSuppCCK = 1;
 	else
 		ht_info->bRegSuppCCK = true;
@@ -275,7 +275,7 @@ void HTConstructCapabilityElement(struct rtllib_device *ieee, u8 *posHTCap,
 	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev))
 		pCapELE->ChlWidth = 0;
 	else
-		pCapELE->ChlWidth = (pHT->bRegBW40MHz ? 1 : 0);
+		pCapELE->ChlWidth = (pHT->reg_bw_40mhz ? 1 : 0);
 
 	pCapELE->MimoPwrSave		= pHT->self_mimo_ps;
 	pCapELE->GreenField		= 0;
@@ -286,7 +286,7 @@ void HTConstructCapabilityElement(struct rtllib_device *ieee, u8 *posHTCap,
 	pCapELE->RxSTBC			= 0;
 	pCapELE->DelayBA		= 0;
 	pCapELE->MaxAMSDUSize = (MAX_RECEIVE_BUFFER_SIZE >= 7935) ? 1 : 0;
-	pCapELE->DssCCk = ((pHT->bRegBW40MHz) ? (pHT->bRegSuppCCK ? 1 : 0) : 0);
+	pCapELE->DssCCk = ((pHT->reg_bw_40mhz) ? (pHT->bRegSuppCCK ? 1 : 0) : 0);
 	pCapELE->PSMP = 0;
 	pCapELE->LSigTxopProtect = 0;
 
@@ -734,7 +734,7 @@ void HTSetConnectBwMode(struct rtllib_device *ieee,
 {
 	struct rt_hi_throughput *ht_info = ieee->ht_info;
 
-	if (!ht_info->bRegBW40MHz)
+	if (!ht_info->reg_bw_40mhz)
 		return;
 
 	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev))
-- 
2.41.0

