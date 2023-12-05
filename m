Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB008062CF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 00:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbjLEXQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 18:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjLEXQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 18:16:21 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6B8D7F
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 15:16:20 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 9BBA33200ADA;
        Tue,  5 Dec 2023 18:16:19 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 05 Dec 2023 18:16:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1701818179; x=
        1701904579; bh=g87UGPn1eU4AoTaT2s2jVXV+I8zvuughjKi3FJl/6ng=; b=f
        goSTBGDI9VCcGy1AMaXBrxF5LXjRqQv9JBrsahGdOc2K/IZPOvoI6mZ4l7MJ3GV9
        HyPWm2Q//Py4zEzaGuG3WorTSlXtGfrrK8GzeLlntzuplPcPnPFX1Ya8DQ8ccu40
        qKbvzMT+PUHPQW5R9a1oPz1dEoMlpHwYBgA+5Vq4kngdVl8opI+0q2TeggFOe3u2
        8TDS8omT2Bphrx3hnR8KJIaqW+Rk2XFSVD9oNYdin2rBoQMdB5JTLt5BfX61NxEa
        fkZHglVx3FmtEjw/2Pf57ySOa4A8Bm2a9YCzMSaMU1F4BHyOT8brmEVvIVr7BPqN
        lBaPiJzifukseJ+zT21eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1701818179; x=
        1701904579; bh=g87UGPn1eU4AoTaT2s2jVXV+I8zvuughjKi3FJl/6ng=; b=C
        waAKx7FySiW5XY3++EMqJqxnK0rfGAWwL7K2Bod0lw1hoAu9ZcyRCUbYG2LwiOf2
        pUovK4W/TAJCIaV8+eEAhuvN18RWTw1J1uPSG7KwW6eOwIodlKFwEF3IBFDGEHOl
        /mSdwoC5q68WKl67bw9TZkjzoUhNcTAQ97X0eSEmNnZhbFPmN/y55/NM288vnO7+
        vyBwOB73bBjBVBeMauQse6+K+wpSb7YGC/vanBU71kp49vytU59lxfPPMCopiISL
        WdRooATuHtqHT9ZTPcBAI52aiu+Bm2OlqehaXxUKNQwk9/dFTZaAlpjx5XxuY2vC
        N3HK8jWOPJOiptAH49BEw==
X-ME-Sender: <xms:Qq9vZR0XHjwLPTkE_uwnqmRUzCNvDuipMcL3e4a--tFnmJdeIJj7Zg>
    <xme:Qq9vZYEBRl52mEO-rXYBPcgVqkNXhbbPkmlZ27M5TLECrU5BRE5rRPRiN_Sxviuzr
    Rx74NiunMYbWah0Viw>
X-ME-Received: <xmr:Qq9vZR7idEFhBRphuQ31GTQ-dIdkKKASQkDyChTQVkNK5aoxHtcZ8m4rOCnbC0OcndJS55FeNzqE-EpMNbB14n-ox-4Riqe_vd4Co6FYA1Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudejledgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgr
    rhgusehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepkeeuvdffueduke
    egieeuffejhefgkeetfeehueelfeduuefgveellefhfefgjedvnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghgrrhihrhhoohhkrghrugesfh
    grshhtmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:Q69vZe2mdp4TbrjrWDZE6LKHFriGExGsEfXvho08cJTyT59Zp1qzJg>
    <xmx:Q69vZUHFPbc877LCDzxi5Mz8m0cRd5PiYXogUj4E_vaT0itQ0-_Uuw>
    <xmx:Q69vZf_-VzvJ0q5ct3UH1n8TVO9dBEbCuxCEUlsayozt2b0lcYtdCg>
    <xmx:Q69vZYClO2_mrob5jBsLd2CyKKKC0WNOs205bYr317zsFTLQsSXHlg>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Dec 2023 18:16:18 -0500 (EST)
From:   Gary Rookard <garyrookard@fastmail.org>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH 4/5] staging: rtl8192e: renamed variable bRegSuppCCK
Date:   Tue,  5 Dec 2023 18:16:22 -0500
Message-ID: <20231205231623.23070-5-garyrookard@fastmail.org>
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
rename it bRegSuppCCK -> reg_supp_cck

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
 drivers/staging/rtl8192e/rtl819x_HT.h     | 2 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index ef88d7d713fb..c3efff2873d4 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -100,7 +100,7 @@ struct rt_hi_throughput {
 	u8 bCurShortGI40MHz;
 	u8 reg_short_gi_20mhz;
 	u8 bCurShortGI20MHz;
-	u8 bRegSuppCCK;
+	u8 reg_supp_cck;
 	u8 bCurSuppCCK;
 	enum ht_spec_ver ePeerHTSpecVer;
 	struct ht_capab_ele SelfHTCap;
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 68ad082d41be..910f8e9c9394 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -77,9 +77,9 @@ void ht_update_default_setting(struct rtllib_device *ieee)
 	ht_info->reg_bw_40mhz = 1;
 
 	if (ht_info->reg_bw_40mhz)
-		ht_info->bRegSuppCCK = 1;
+		ht_info->reg_supp_cck = 1;
 	else
-		ht_info->bRegSuppCCK = true;
+		ht_info->reg_supp_cck = true;
 
 	ht_info->nAMSDU_MaxSize = 7935UL;
 	ht_info->bAMSDU_Support = 0;
@@ -286,7 +286,7 @@ void HTConstructCapabilityElement(struct rtllib_device *ieee, u8 *posHTCap,
 	pCapELE->RxSTBC			= 0;
 	pCapELE->DelayBA		= 0;
 	pCapELE->MaxAMSDUSize = (MAX_RECEIVE_BUFFER_SIZE >= 7935) ? 1 : 0;
-	pCapELE->DssCCk = ((pHT->reg_bw_40mhz) ? (pHT->bRegSuppCCK ? 1 : 0) : 0);
+	pCapELE->DssCCk = ((pHT->reg_bw_40mhz) ? (pHT->reg_supp_cck ? 1 : 0) : 0);
 	pCapELE->PSMP = 0;
 	pCapELE->LSigTxopProtect = 0;
 
@@ -485,7 +485,7 @@ void HTOnAssocRsp(struct rtllib_device *ieee)
 				     ((pPeerHTCap->ShortGI40Mhz == 1) ?
 				     true : false) : false);
 
-	ht_info->bCurSuppCCK = ((ht_info->bRegSuppCCK) ?
+	ht_info->bCurSuppCCK = ((ht_info->reg_supp_cck) ?
 			       ((pPeerHTCap->DssCCk == 1) ? true :
 			       false) : false);
 
-- 
2.41.0

