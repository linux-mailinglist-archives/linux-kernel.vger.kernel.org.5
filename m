Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1DBD8098E2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 02:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1572958AbjLHBzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 20:55:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572946AbjLHBzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 20:55:12 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20451AD
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 17:55:18 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 487975C01E3;
        Thu,  7 Dec 2023 20:55:18 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 07 Dec 2023 20:55:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1702000518; x=
        1702086918; bh=M2ugF1mMML6CeGQhvv70X0VCy0pl6yNILhGXIyFtxGI=; b=L
        zhm8SL4zd+3kPubJoOuETE7d+Aw3OF6jdGmOod+qw75KvLpVnptd6PRZYZI5o+Jj
        kT+wfmg0/TJIG1p9cYDFd9y23QnraXtc39VIVQ2ccg0kSa5RdYh0I1akjHvf6Q73
        ouXXxqKvf2b7Cu9GtWbDOh/2JLnb9dkPEpqyMCFEgK6RjOvxRQrjj9Pgemz3LzBz
        6EEtyTIjvFQSyLfiB+eBFBJn5S81W0eYdcCFcu83C/uOKbUEVgbHai+sKAjj8zyr
        5JIc/xsezmkjhND0cFaRKwl6rKjw3NPLvN86EzdAS8LUI5vxuE2B/AYbV9nQlwPq
        JINA/PmvT1/9pBSJVHUEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1702000518; x=
        1702086918; bh=M2ugF1mMML6CeGQhvv70X0VCy0pl6yNILhGXIyFtxGI=; b=U
        /Kd/X9GbdDyX0uHfoAzQ4+WeZSelNt/sMr/ktgG2n2M71Qg87vTstrpxmqYhZnbO
        oSJGxC4V2ORbKFLxGN6joE2/FCln1eTHxvkOYX3LTAd01G7M3RnIZJrRp1Za4ctJ
        1SmI+cJlXoU8MfuNqjjx1X0znbYC68i/kBlUb2QSy/QWDxtbh4yQl7MKtzXtbcLO
        +ndtPCpOFBKexScTCE+An/MrAHz2heMgSF2fl3NeSOTesMHjmGO8QEv+Grfy0dn/
        qvbyMDQ5A3nSNlapmbVhkVx0RrZoTCZhbaLTV62xiuFhh/axlmIz61pcgYJBQH+C
        O0wzQx4gz43jePweNKwRw==
X-ME-Sender: <xms:hndyZRVBdR1m4zavwABt6oUWA-kFseJ6y6g21-ilf0cI6w4PNe-J1w>
    <xme:hndyZRmwt2AIYsSQVmQBl7b1EgBI31nIS9RUDj6HzRjVdMAHk73hwYWExZYLJebHn
    Axi2WxHosyH0fydP1c>
X-ME-Received: <xmr:hndyZdbI2DIJPB4tpeMRtEB6gPciqacD_swYnChErlfxZBqQikCYwYXnF6ypHyDK9VrcGkPEap5UZFh6dULi99Rv5gigoolebQDbdBRvzik>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekgedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgr
    rhgusehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepkeeuvdffueduke
    egieeuffejhefgkeetfeehueelfeduuefgveellefhfefgjedvnecuvehluhhsthgvrhfu
    ihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepghgrrhihrhhoohhkrghrugesfh
    grshhtmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:hndyZUUz6WgcNl-nX9qeRC7kSUAO1jYEGBxBdD7dOzP27qvK8FWjbw>
    <xmx:hndyZbmWOoVZyX22dlDWikp-AdLzTUCrhtQ5rLo8elRSAIA4iZ9jpQ>
    <xmx:hndyZRf_zj6yKuoLBEHqk5Xg7ciheQK8QUah0gwr_UFGavoTTu3Y4Q>
    <xmx:hndyZZiQGbZavkt-7zYvQstaxvqxhz5QWn1bUNCkIxhkvcMtZIzmdQ>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Dec 2023 20:55:17 -0500 (EST)
From:   Gary Rookard <garyrookard@fastmail.org>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH 2/5] staging: rtl8192e: renamed variable bCurShortGI20MHz
Date:   Thu,  7 Dec 2023 20:55:33 -0500
Message-ID: <20231208015536.21013-3-garyrookard@fastmail.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231208015536.21013-1-garyrookard@fastmail.org>
References: <20231208015536.21013-1-garyrookard@fastmail.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coding style issue, checkpatch Avoid CamelCase,
rename it. bCurShortGI20MHz -> cur_short_gi_20mhz

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 2 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c     | 2 +-
 drivers/staging/rtl8192e/rtl819x_HT.h          | 2 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c      | 6 +++---
 drivers/staging/rtl8192e/rtllib_tx.c           | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index f01240f7e514..e6d51abd0d01 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1766,7 +1766,7 @@ void rtl92e_update_ratr_table(struct net_device *dev)
 	    ieee->ht_info->cur_short_gi_40mhz)
 		ratr_value |= 0x80000000;
 	else if (!ieee->ht_info->cur_tx_bw40mhz &&
-		  ieee->ht_info->bCurShortGI20MHz)
+		  ieee->ht_info->cur_short_gi_20mhz)
 		ratr_value |= 0x80000000;
 	rtl92e_writel(dev, RATR0 + rate_index * 4, ratr_value);
 	rtl92e_writeb(dev, UFWP, 1);
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index c73d2ac910d5..e2828d57d1fd 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -289,7 +289,7 @@ static void _rtl92e_dm_check_rate_adaptive(struct net_device *dev)
 		bshort_gi_enabled = (ht_info->cur_tx_bw40mhz &&
 				     ht_info->cur_short_gi_40mhz) ||
 				    (!ht_info->cur_tx_bw40mhz &&
-				     ht_info->bCurShortGI20MHz);
+				     ht_info->cur_short_gi_20mhz);
 
 		pra->upper_rssi_threshold_ratr =
 				(pra->upper_rssi_threshold_ratr & (~BIT(31))) |
diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index f89b618f71a5..77f28d87d3c0 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -99,7 +99,7 @@ struct rt_hi_throughput {
 	u8 reg_short_gi_40mhz;
 	u8 cur_short_gi_40mhz;
 	u8 reg_short_gi_20mhz;
-	u8 bCurShortGI20MHz;
+	u8 cur_short_gi_20mhz;
 	u8 reg_supp_cck;
 	u8 bCurSuppCCK;
 	enum ht_spec_ver ePeerHTSpecVer;
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index f9c76aaf8791..633f735bdab1 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -110,7 +110,7 @@ static u16 ht_mcs_to_data_rate(struct rtllib_device *ieee, u8 mcs_rate)
 	u8	is40MHz = (ht_info->cur_bw_40mhz) ? 1 : 0;
 	u8	isShortGI = (ht_info->cur_bw_40mhz) ?
 			    ((ht_info->cur_short_gi_40mhz) ? 1 : 0) :
-			    ((ht_info->bCurShortGI20MHz) ? 1 : 0);
+			    ((ht_info->cur_short_gi_20mhz) ? 1 : 0);
 	return MCS_DATA_RATE[is40MHz][isShortGI][(mcs_rate & 0x7f)];
 }
 
@@ -478,7 +478,7 @@ void HTOnAssocRsp(struct rtllib_device *ieee)
 	ht_info->cur_tx_bw40mhz = ((pPeerHTInfo->RecommemdedTxWidth == 1) ?
 				 true : false);
 
-	ht_info->bCurShortGI20MHz = ((ht_info->reg_short_gi_20mhz) ?
+	ht_info->cur_short_gi_20mhz = ((ht_info->reg_short_gi_20mhz) ?
 				    ((pPeerHTCap->ShortGI20Mhz == 1) ?
 				    true : false) : false);
 	ht_info->cur_short_gi_40mhz = ((ht_info->reg_short_gi_40mhz) ?
@@ -562,7 +562,7 @@ void HTInitializeHTInfo(struct rtllib_device *ieee)
 	ht_info->cur_bw_40mhz = false;
 	ht_info->cur_tx_bw40mhz = false;
 
-	ht_info->bCurShortGI20MHz = false;
+	ht_info->cur_short_gi_20mhz = false;
 	ht_info->cur_short_gi_40mhz = false;
 	ht_info->forced_short_gi = false;
 
diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index 041520e6c28d..ed264fc75457 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -364,7 +364,7 @@ static void rtllib_query_HTCapShortGI(struct rtllib_device *ieee,
 
 	if (ht_info->cur_bw_40mhz && ht_info->cur_short_gi_40mhz)
 		tcb_desc->bUseShortGI = true;
-	else if (!ht_info->cur_bw_40mhz && ht_info->bCurShortGI20MHz)
+	else if (!ht_info->cur_bw_40mhz && ht_info->cur_short_gi_20mhz)
 		tcb_desc->bUseShortGI = true;
 }
 
-- 
2.41.0

