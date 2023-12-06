Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC38807C0C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 00:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379773AbjLFXEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 18:04:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379605AbjLFXEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 18:04:11 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF60510D0
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 15:04:10 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id BC161320046F;
        Wed,  6 Dec 2023 18:04:09 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 06 Dec 2023 18:04:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1701903849; x=
        1701990249; bh=Mm75jhAU+R+QBXvtKe+xPbE4DurHNwnJG+cmVen0I7w=; b=c
        I6TCiFIbzbngY7jRHwCV67QDgspnGZpvAOPQtrUMJE5hu9GJg7zLm10dbowjVL+C
        i80kbZS+snY/bwcdL7Zw7UGipAxYJoi9dhRLHdUN19y+9Qye2BGuOhlaw6VrbeFp
        /M6DyZVRGgqPgiJK7CB6nga4SB7rgprPr7ZQDb6zJPLFtSnVW3swWwY5TAz2FFcl
        EltNxEMHOGrzHPlh0+7CegJRZu7X0OtP+FDD+5GejVr3NGlhgOcbrQ7RsCWK0cws
        vOZqHHGLbmaswBJbaGmNF2w/T1+Yfsv7JBAosg7FkZHnv27FMVFc5cAVmVfJ0rEC
        7/RfmrfPZjv9riN6NHnQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1701903849; x=
        1701990249; bh=Mm75jhAU+R+QBXvtKe+xPbE4DurHNwnJG+cmVen0I7w=; b=k
        Csvfyi/IQ6Qpg7nCNdDgtDBpesjFur5bZD3e7NH/oLbi3kaTsav538zdbBK8CzjD
        0BBI+RZZ5iv7eJT1droobwXbGTw5U+H2yHddhL7gESbDmK+kzRu4qyJNGBgUsTAt
        43zB2+FpcMuvXQ/PmY2TXObAmezVVhJltR6Oo8CtP3ZuHMtcdWu8vjlcH1Cq9ihf
        pEJ3Ea0igO89G9lOxqgEebAPA9FBSv6N3wzKmDR7LvvGAwZXxPutuazcj8WB7JBx
        6KP3BYXKG9zutKYsP30C8PNa2k9UcjdxM9sulnkx3Z7XlJkpH5rlOZmLkFT3D3Io
        EE9Jj2/090oIZ4l7vmCzg==
X-ME-Sender: <xms:6f1wZegiGfMHBYD9yc0lh1GU8luvB8EOWwPdcduvNGXzZneLFymCpA>
    <xme:6f1wZfBo5rxXiPmjT03G5erPlcVSQqZoI5qA8VwdiQrAT6Am2EF8J8C2hcQPZu6ex
    Cz4IAknEty-JxMVzEI>
X-ME-Received: <xmr:6f1wZWGmAkUZc1G_-A3UFQtVgN9QQ6qW5bdXhBKqoQEqE571_2B-epXJsqSmgjwsRNDCne7rnxcNUffFVjCQToDVk06Pab74DyUrb11zmgQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekuddgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgr
    rhgusehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepkeeuvdffueduke
    egieeuffejhefgkeetfeehueelfeduuefgveellefhfefgjedvnecuvehluhhsthgvrhfu
    ihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepghgrrhihrhhoohhkrghrugesfh
    grshhtmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:6f1wZXRp64ceygM01lUHYoRv4exiiBMB3icEWPW_AAeS0xHSUuyoVQ>
    <xmx:6f1wZbziLWtl-utsBE1s0-c2L1GrWKJUUCc43UFsTgLZnYnPNaNujQ>
    <xmx:6f1wZV4OdWpJ8rBYooPQ0T3uq-Ts8AuGYM5Kfghes1961kvM1W7NcQ>
    <xmx:6f1wZb-hQcj15GpM2v6ofSkyAoCwN2j7MJ5YcqwlwIbNwV6k85e88Q>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Dec 2023 18:04:08 -0500 (EST)
From:   Gary Rookard <garyrookard@fastmail.org>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH 5/5] staging: rtl8192e: renamed variable bTxEnableFwCalcDur
Date:   Wed,  6 Dec 2023 18:04:04 -0500
Message-ID: <20231206230404.1721-6-garyrookard@fastmail.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231206230404.1721-1-garyrookard@fastmail.org>
References: <20231206230404.1721-1-garyrookard@fastmail.org>
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
rename it. bTxEnableFwCalcDur -> tx_enable_fw_calc_dur

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 2 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c   | 2 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c      | 2 +-
 drivers/staging/rtl8192e/rtllib.h              | 4 ++--
 drivers/staging/rtl8192e/rtllib_tx.c           | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index fe48cc6b7132..39fa5f60db45 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -879,7 +879,7 @@ void  rtl92e_fill_tx_desc(struct net_device *dev, struct tx_desc *pdesc,
 	memset(pTxFwInfo, 0, sizeof(struct tx_fwinfo_8190pci));
 	pTxFwInfo->TxHT = (cb_desc->data_rate & 0x80) ? 1 : 0;
 	pTxFwInfo->TxRate = _rtl92e_rate_mgn_to_hw(cb_desc->data_rate);
-	pTxFwInfo->EnableCPUDur = cb_desc->bTxEnableFwCalcDur;
+	pTxFwInfo->EnableCPUDur = cb_desc->tx_enable_fw_calc_dur;
 	pTxFwInfo->Short = _rtl92e_query_is_short(pTxFwInfo->TxHT,
 						  pTxFwInfo->TxRate, cb_desc);
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index bad34221d8b7..1f45b6b00d1b 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -1189,7 +1189,7 @@ static int _rtl92e_hard_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	tcb_desc->ratr_index = 7;
 	tcb_desc->tx_dis_rate_fallback = 1;
 	tcb_desc->tx_use_drv_assinged_rate = 1;
-	tcb_desc->bTxEnableFwCalcDur = 1;
+	tcb_desc->tx_enable_fw_calc_dur = 1;
 	skb_push(skb, priv->rtllib->tx_headroom);
 	ret = _rtl92e_tx(dev, skb);
 	if (ret != 0)
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 72b30d4df5f7..a421c56af9e2 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -94,7 +94,7 @@ void ht_update_default_setting(struct rtllib_device *ieee)
 	ieee->tx_dis_rate_fallback = 0;
 	ieee->tx_use_drv_assinged_rate = 0;
 
-	ieee->bTxEnableFwCalcDur = 1;
+	ieee->tx_enable_fw_calc_dur = 1;
 
 	ht_info->reg_rt2rt_aggregation = 1;
 
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 6bad7d410075..85b922bda7ec 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -117,7 +117,7 @@ struct cb_desc {
 	u8 bRTSEnable:1;
 	u8 bUseShortGI:1;
 	u8 bUseShortPreamble:1;
-	u8 bTxEnableFwCalcDur:1;
+	u8 tx_enable_fw_calc_dur:1;
 	u8 ampdu_enable:1;
 	u8 bRTSSTBC:1;
 	u8 RTSSC:1;
@@ -1223,7 +1223,7 @@ struct rtllib_device {
 	u8	HTHighestOperaRate;
 	u8	tx_dis_rate_fallback;
 	u8	tx_use_drv_assinged_rate;
-	u8	bTxEnableFwCalcDur;
+	u8	tx_enable_fw_calc_dur;
 	atomic_t	atm_swbw;
 
 	struct list_head		Tx_TS_Admit_List;
diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index 5a69f4c6d0c9..e2dd2772bbeb 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -847,7 +847,7 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 	if (txb) {
 		tcb_desc = (struct cb_desc *)
 				(txb->fragments[0]->cb + MAX_DEV_ADDR_SIZE);
-		tcb_desc->bTxEnableFwCalcDur = 1;
+		tcb_desc->tx_enable_fw_calc_dur = 1;
 		tcb_desc->priority = skb->priority;
 
 		if (ether_type == ETH_P_PAE) {
-- 
2.41.0

