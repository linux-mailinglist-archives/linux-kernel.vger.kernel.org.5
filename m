Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0528062D0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 00:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376257AbjLEXQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 18:16:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbjLEXQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 18:16:24 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E336196
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 15:16:23 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 4610632000D7;
        Tue,  5 Dec 2023 18:16:22 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 05 Dec 2023 18:16:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1701818181; x=
        1701904581; bh=zcthwmDi/kwf3FaO008HcZBaNi9LArBnUS4kxfvngzg=; b=E
        qaflv0pDEW8KG0qidNpqAEkEar3XazSE66BabUHqUBKRNJM1oMeCtQDjOk1wuD2f
        WYbKKy5jLbklUKRtUEQHDUrI9SDTk96BrZm+7W9npy/CdPzSM64xmLbtDGvSuRFD
        GVJmsK1NBfFOVVOGsjWKCZmpMnqFuUwUHftzVG+CphgtlXu4GNL2ZovEGyNpvZXQ
        vH2PCcsBd5gWO+TRgC/dQu2h37WCMJVsv1RJEs3iYa4nuJPWUgaanfACIZjXHNAO
        CEBwDco8KZ7aoEifahDnMJA8Yp0rguj5dhLHeNEHmaavjxM9/9XwuoTvG+cChGpJ
        7vHYdZZJ4koWFYD+WYtPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1701818181; x=
        1701904581; bh=zcthwmDi/kwf3FaO008HcZBaNi9LArBnUS4kxfvngzg=; b=o
        d2NiV7WvSyNSWfEGTA7f7I/bqukG5DTxKA9AmHr+ZHuPXE5EJ9JfqK81hovMlZ9W
        kuTV+tYlfUNnrGyKjq81zx7/Nl18sil244r4KKrGLXfpjVxs0Whl03hkA+y0h+RF
        P1UfkztF6U1cZXLlsmJ6YSCBJM391Jb1eOc2tgiglsUlNY5Amenuq96cSoSewguX
        J/F9T6EyB7cqoObkUfzh93joNBLk65O/PKfMAtp1/6Cb80A6NzzmpK4NijevATZ/
        GR8NzVCHM4M0Vc0vGtysO4vNOTJHC+6JIFEC2HgcnCKF6/Njr4DEoe8hv3mBa8vo
        8ibyk31znDZ3D7BD5QxjA==
X-ME-Sender: <xms:Ra9vZVyQsl9_F7OapNb7_4n1U2Irc6zjQ-TU1XXHfhTcd6mzYv9puQ>
    <xme:Ra9vZVQ7gFFwMTo-nd-K2YYFHIgm0bCO6O-RqTLquvtfS2I5WqeMfU0Ed2Q2VC3mH
    JgfoOIlfFdbbJzSg8E>
X-ME-Received: <xmr:Ra9vZfUSt2mHMkp29jwpE11fX8EyQucQWI0nHovhnR99FjFcpY7JbipGHFpTEEVNrq6xWJ8GAnniDrEkM3qbLgcFSypH8nmubCMd5E8H24c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudejledgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgr
    rhgusehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepkeeuvdffueduke
    egieeuffejhefgkeetfeehueelfeduuefgveellefhfefgjedvnecuvehluhhsthgvrhfu
    ihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepghgrrhihrhhoohhkrghrugesfh
    grshhtmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:Ra9vZXicurIyGE9L6PUYXILh5XAfjbenxmzeIdTaCBRwus63QUahJQ>
    <xmx:Ra9vZXAz7EyBUtyz1nQkG17vaDPM3Y79eZfq746VZ186ZMVBOGYY7Q>
    <xmx:Ra9vZQIj7wJtBun1iKppsO1Ja5cD_PZ1I6N3x_ov1SDwpGqhd8vb6g>
    <xmx:Ra9vZeMmhBpC_x8YbhYsD1p6wmBOLrZPFofPbfj3085z_B_6bz9q1A>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Dec 2023 18:16:21 -0500 (EST)
From:   Gary Rookard <garyrookard@fastmail.org>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH 5/5] staging: rtl8192e: renamed variable nAMSDU_MaxSize
Date:   Tue,  5 Dec 2023 18:16:23 -0500
Message-ID: <20231205231623.23070-6-garyrookard@fastmail.org>
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
rename it nAMSDU_MaxSize -> amsdu_max_size

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
 drivers/staging/rtl8192e/rtl819x_HT.h     | 2 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index c3efff2873d4..5018c3905be8 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -108,7 +108,7 @@ struct rt_hi_throughput {
 	u8 PeerHTCapBuf[32];
 	u8 PeerHTInfoBuf[32];
 	u8 bAMSDU_Support;
-	u16 nAMSDU_MaxSize;
+	u16 amsdu_max_size;
 	u8 bCurrent_AMSDU_Support;
 	u16 nCurrent_AMSDU_MaxSize;
 	u8 bAMPDUEnable;
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 910f8e9c9394..6475832f23f6 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -81,7 +81,7 @@ void ht_update_default_setting(struct rtllib_device *ieee)
 	else
 		ht_info->reg_supp_cck = true;
 
-	ht_info->nAMSDU_MaxSize = 7935UL;
+	ht_info->amsdu_max_size = 7935UL;
 	ht_info->bAMSDU_Support = 0;
 
 	ht_info->bAMPDUEnable = 1;
@@ -493,10 +493,10 @@ void HTOnAssocRsp(struct rtllib_device *ieee)
 
 	nMaxAMSDUSize = (pPeerHTCap->MaxAMSDUSize == 0) ? 3839 : 7935;
 
-	if (ht_info->nAMSDU_MaxSize > nMaxAMSDUSize)
+	if (ht_info->amsdu_max_size > nMaxAMSDUSize)
 		ht_info->nCurrent_AMSDU_MaxSize = nMaxAMSDUSize;
 	else
-		ht_info->nCurrent_AMSDU_MaxSize = ht_info->nAMSDU_MaxSize;
+		ht_info->nCurrent_AMSDU_MaxSize = ht_info->amsdu_max_size;
 
 	ht_info->current_ampdu_enable = ht_info->bAMPDUEnable;
 	if (ieee->rtllib_ap_sec_type &&
@@ -569,7 +569,7 @@ void HTInitializeHTInfo(struct rtllib_device *ieee)
 	ht_info->bCurSuppCCK = true;
 
 	ht_info->bCurrent_AMSDU_Support = false;
-	ht_info->nCurrent_AMSDU_MaxSize = ht_info->nAMSDU_MaxSize;
+	ht_info->nCurrent_AMSDU_MaxSize = ht_info->amsdu_max_size;
 	ht_info->current_mpdu_density = ht_info->MPDU_Density;
 	ht_info->CurrentAMPDUFactor = ht_info->AMPDU_Factor;
 
-- 
2.41.0

