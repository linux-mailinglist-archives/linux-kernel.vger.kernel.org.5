Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD17811B9F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 18:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbjLMRys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 12:54:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233643AbjLMRy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 12:54:29 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C267128
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 09:54:36 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 914D75C03F5;
        Wed, 13 Dec 2023 12:54:35 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 13 Dec 2023 12:54:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to; s=fm1; t=1702490075; x=
        1702576475; bh=RRJC+HdOSAtLKZ1tfbLXPJklfXKvB6O/n536R+XKUYg=; b=i
        G8N+EJ6x+T4ml59XjFOuXm57KzjFKlH3qEfjT/whpVmd/PHK08DGw3rkiBkPsPMu
        ycZ37H+kgTlHsp0D3tHGif1sK+LFPaJ8tiQ5vgj/l1qEUFO3PLTEzOHr83NStlCT
        mVXwV4sCFPd5Rk4h6C2dwCUi8yaSts2IsHF/4EQA4Vi87U2ITPOiPH49tpyLYG66
        ZvlabOBI3sl4yjA4hv0f56kJPkWR71DhIzVzOiuTGu43j+f7PESZQqzUNAbloqYi
        oUxNBfYo/FTkGcQUzSWuwRQb5cJ9VXMqGBbLr8HhkVqLp0C9DG4txrigXLoKsjhI
        P7aoM9O9HZHEHx4Cydx0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1702490075; x=
        1702576475; bh=RRJC+HdOSAtLKZ1tfbLXPJklfXKvB6O/n536R+XKUYg=; b=o
        p+szTeXumDNUM5dpSMbUm2WhsyQqKR40pfl6Su8kcgEh/yWcQmkFfN0ch88iE1fJ
        yRS2i0IDWfFM0RDA4Aw3F2+JRTmeCcEwlHvgFMDV8xPY8fszwieSmAdDwYgRmHc3
        R1UNYkV+k2/8ltLO+cRYuD0SN+Rbc5oAzSpKzt5q6YJOHsEqux7F4FWAumyA9gdK
        9f1lsun6RtqNrYLu5tQgnGWKZUryuvqn6qcNcvmrHSxdiAdrgAmSUQd68PmoxdBG
        37hbI1HUQOKHlG3IhAj8vJ7A8YHWAB3TnkTqsDz3afWLmhMPW7ywz2lBcn5Q5295
        AzJmOonHnyVgPTa4VE0dQ==
X-ME-Sender: <xms:2-95ZbPuep1r7XjPIYqklLV_wP56dpueMHu7zgDaNCJZ0DGmJJUxXA>
    <xme:2-95ZV-Qxg5hJb_ZaD1Frh0Kg-bRxUASudO8qKiK2IBoOlPqFRiRUryfHTKVoXO0N
    I4YZblTZWUjXF0Idfw>
X-ME-Received: <xmr:2-95ZaQqNSHaKEl5icurbc6d2kdEA3B6V7HpyH9NshJDIoM-WEoHiXRSfxUeEXVrLRqJmwqSO7-c9D9-_gPJhS3FAgCM7dot08NVEfJC7M0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeljedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgr
    rhgusehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepkeeuvdffueduke
    egieeuffejhefgkeetfeehueelfeduuefgveellefhfefgjedvnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghgrrhihrhhoohhkrghrugesfh
    grshhtmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:2-95ZfvrBbTUmXbKeJLQF2iRKjjHOM4_AVeTUAOQ3oriZ3GGm-MUOQ>
    <xmx:2-95ZTfAMGqoQginvMyKlMTKM-3KEYcV1FXPi9p0_9tDDxpmjOfJ_g>
    <xmx:2-95Zb3dDWnS7Lr15cLLo1tzvfWoARAe2InSuc6gv4-iz4YiIFYobw>
    <xmx:2-95Zf5de3xY7esnUjj40fFZEvOOx4mv23p-Y1Q9d-3ZEhnkOLjcNA>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Dec 2023 12:54:35 -0500 (EST)
From:   Gary Rookard <garyrookard@fastmail.org>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH 5/5] staging: rtl8192e: rename variable HTInitializeHTInfo
Date:   Wed, 13 Dec 2023 12:54:59 -0500
Message-ID: <20231213175459.5425-6-garyrookard@fastmail.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231213175459.5425-1-garyrookard@fastmail.org>
References: <20231213175459.5425-1-garyrookard@fastmail.org>
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
rename it. HTInitializeHTInfo -> ht_initialize_ht_info

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 drivers/staging/rtl8192e/rtllib_module.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 8d07e5caa2b8..8af980619b99 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -553,7 +553,7 @@ void ht_on_assoc_rsp(struct rtllib_device *ieee)
 	ht_info->current_op_mode = pPeerHTInfo->OptMode;
 }
 
-void HTInitializeHTInfo(struct rtllib_device *ieee)
+void ht_initialize_ht_info(struct rtllib_device *ieee)
 {
 	struct rt_hi_throughput *ht_info = ieee->ht_info;
 
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index f756395b9bed..dbc894259477 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1761,7 +1761,7 @@ void ht_construct_capability_element(struct rtllib_device *ieee,
 void ht_construct_rt2rt_agg_element(struct rtllib_device *ieee,
 				u8 *posRT2RTAgg, u8 *len);
 void ht_on_assoc_rsp(struct rtllib_device *ieee);
-void HTInitializeHTInfo(struct rtllib_device *ieee);
+void ht_initialize_ht_info(struct rtllib_device *ieee);
 void HTInitializeBssDesc(struct bss_ht *pBssHT);
 void HTResetSelfAndSavePeerSetting(struct rtllib_device *ieee,
 				   struct rtllib_network *pNetwork);
diff --git a/drivers/staging/rtl8192e/rtllib_module.c b/drivers/staging/rtl8192e/rtllib_module.c
index 95b6d6b9429c..e7af4a25b0be 100644
--- a/drivers/staging/rtl8192e/rtllib_module.c
+++ b/drivers/staging/rtl8192e/rtllib_module.c
@@ -123,7 +123,7 @@ struct net_device *alloc_rtllib(int sizeof_priv)
 		goto free_softmac;
 
 	ht_update_default_setting(ieee);
-	HTInitializeHTInfo(ieee);
+	ht_initialize_ht_info(ieee);
 	rtllib_ts_init(ieee);
 	for (i = 0; i < IEEE_IBSS_MAC_HASH_SIZE; i++)
 		INIT_LIST_HEAD(&ieee->ibss_mac_hash[i]);
-- 
2.41.0

