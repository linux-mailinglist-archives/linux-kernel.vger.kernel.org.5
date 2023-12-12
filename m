Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3EE580F3BD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbjLLQ5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:57:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235125AbjLLQ4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:56:04 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102BAE3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:56:09 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 8E6D03200A0F;
        Tue, 12 Dec 2023 11:56:08 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 12 Dec 2023 11:56:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to; s=fm1; t=1702400168; x=
        1702486568; bh=bBi+M/BPgj1IfpVblsWubMsCCFJ3nZ0KD2Xl/FWBwdU=; b=H
        V7WBwMnopwuBm9xc7Gh7pYQZNTxhCExGNczofrjirbtJxtYvJIzvcVfwh1FJgpfP
        3Cv6+VfGLFr6sFQAPHs/8+WVmQN4sxeNh1avmhUW2r79JyWRaCl3Nj9FYFWajBVM
        x02Lu5zKx1qQARGgwXpOPJycqq2/ooWA03vp3Um8pDvOtjvlRsflX023B7XsjzM9
        oNSpTikkpiNHnhRKdr0vIgcUht9sqbcD2J6az0bR+VtCeKjI80a913tBP3qcQRP1
        7YY5D4TNWeZWZUbPxOxSJzhC1btvIfCQCQoPQorekrRl61DteuIUYe5abB+jnt0u
        PGiEOh49ag9zc81tp/uew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1702400168; x=
        1702486568; bh=bBi+M/BPgj1IfpVblsWubMsCCFJ3nZ0KD2Xl/FWBwdU=; b=K
        ee54Y+wTdDJG4iKIhKIQQMziLaNHRAs/R6WIGldw0AzWF5AO5L9D3dnqCaCatHyP
        lNiVqP+Bk43z2cxhOaFBAqrdsRtuz+pLJkPbJnJsVMGU9IYisXzpdirvmbqK3L71
        n2j/2PF7g6S0XgG5iFap931anu0Q9m7EOOiCoX1t0SG/55hdGHpgIwRFLEYQ/roF
        Jp5XTZUZoHvmB3GjcwF4o4tWrwcbUDeY9x6/FLy1y1lAw1zOy9nGkVnCcNLqb/Kn
        kYMj7GX9PVtqY/OThA9kv2rt+xUDHYckTWeKteoEtL6iojs8LpcRIGqxxyKKDSH8
        erKT6nIdqD7crUHTeFxbw==
X-ME-Sender: <xms:p5B4ZYxzXtG653v0Z5c0PWvPlH3Qjy0Ccpcyj4b85q_N5VsmDXT4_A>
    <xme:p5B4ZcQWDTa-A6WKiuJRC7Kmpx-mkz-_U9BSdQ0Wy8JLeKT_2Csm4ppcRmgEYkMnu
    591MswzFoi8jq43PQw>
X-ME-Received: <xmr:p5B4ZaUhF7LAASEFaQ10M9vd9gl9o1Nu43vw3uhDB868EWP2J4FBYCG3J_hnMwf63uxBhwDfnwvn1rLByi2qJCb4Cbc7FG4DI-cAdCRh_3Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelgedgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgr
    rhgusehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepkeeuvdffueduke
    egieeuffejhefgkeetfeehueelfeduuefgveellefhfefgjedvnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghgrrhihrhhoohhkrghrugesfh
    grshhtmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:qJB4ZWj9EvvW8uHpSh4NeXFc851zmXbbA45VaQ6vDvZhlbrihzH7aQ>
    <xmx:qJB4ZaAZ5f5MEFv2Sywz5UK_PfiSBEcRG0eS6mgEH2Cvp5tOPr1GxA>
    <xmx:qJB4ZXJF-DxVcexsZYyBdjZ8pIn1pzIlc-CddgSVy-II6rKzyBIXDA>
    <xmx:qJB4ZVMnRcxCM7tOVxjPs_RljghXA427sv4JgTRI3YHqdjs0e-tiqw>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Dec 2023 11:56:07 -0500 (EST)
From:   Gary Rookard <garyrookard@fastmail.org>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH 1/5] staging: rtl8192e: rename variable posHTCap
Date:   Tue, 12 Dec 2023 11:56:33 -0500
Message-ID: <20231212165637.17618-2-garyrookard@fastmail.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231212165637.17618-1-garyrookard@fastmail.org>
References: <20231212165637.17618-1-garyrookard@fastmail.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coding style issue, checkpatch Avoid CamelCase,
rename it. posHTCap -> pos_ht_cap

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 14e25f87c1bf..eb798a3a9052 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -247,27 +247,27 @@ void ht_reset_iot_setting(struct rt_hi_throughput *ht_info)
 	ht_info->iot_ra_func = 0;
 }
 
-void ht_construct_capability_element(struct rtllib_device *ieee, u8 *posHTCap,
+void ht_construct_capability_element(struct rtllib_device *ieee, u8 *pos_ht_cap,
 				  u8 *len, u8 IsEncrypt, bool bAssoc)
 {
 	struct rt_hi_throughput *pHT = ieee->ht_info;
 	struct ht_capab_ele *pCapELE = NULL;
 
-	if (!posHTCap || !pHT) {
+	if (!pos_ht_cap || !pHT) {
 		netdev_warn(ieee->dev,
 			    "%s(): posHTCap and ht_info are null\n", __func__);
 		return;
 	}
-	memset(posHTCap, 0, *len);
+	memset(pos_ht_cap, 0, *len);
 
 	if ((bAssoc) && (pHT->ePeerHTSpecVer == HT_SPEC_VER_EWC)) {
 		static const u8	EWC11NHTCap[] = { 0x00, 0x90, 0x4c, 0x33 };
 
-		memcpy(posHTCap, EWC11NHTCap, sizeof(EWC11NHTCap));
-		pCapELE = (struct ht_capab_ele *)&posHTCap[4];
+		memcpy(pos_ht_cap, EWC11NHTCap, sizeof(EWC11NHTCap));
+		pCapELE = (struct ht_capab_ele *)&pos_ht_cap[4];
 		*len = 30 + 2;
 	} else {
-		pCapELE = (struct ht_capab_ele *)posHTCap;
+		pCapELE = (struct ht_capab_ele *)pos_ht_cap;
 		*len = 26 + 2;
 	}
 
-- 
2.41.0

