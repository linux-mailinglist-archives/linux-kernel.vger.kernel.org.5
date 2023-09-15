Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98BEE7A2343
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 18:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236207AbjIOQHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 12:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236440AbjIOQHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 12:07:20 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870F01FCE
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 09:07:06 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-401e6ce2d9fso6716985e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 09:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694794025; x=1695398825; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n2PHM1eEcsGJe5Q3fmJzIu7/A4Sy54TXuvy1bSnpta0=;
        b=feBnv3c/OqhTgfe/K0EJbFOS1eMcrzsFF4XXuui5PYouNF+56flKYXMeOwzl+XRzRR
         sSEtGSosMOdAjuZpeCxpI1jUulI6eCPscr4zAVpskvPQD2QrrMi2Q2+p8gLeKoB1k3zr
         Dr5oB8r0iJcOnYlTwB5jK81j52sZHE++9carnU/A1X3XqSREbmm/TQCevRsYNHceJqNA
         1DqfND1kI6TnPkjgEE0b9rwLVetCQEVCfF7i7kNzNvhxeaShsZUyqBVybLMtxD8vMrtt
         h+M3P1Znh96ISQlX/vZ9mpO6oy4R8I6VaE8lND/M37mKaoRQl4g1NO5ApurVXIJEIu+g
         caDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694794025; x=1695398825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n2PHM1eEcsGJe5Q3fmJzIu7/A4Sy54TXuvy1bSnpta0=;
        b=wP+f9jZMnFCIH/hRWT5du0JUVxhijTFmDcVPWcQasUz44ep8SQ5MZ72IfS3hL7rYiv
         xd4y2hjTSCXQU8tWMjkNaptZI5wftTYiPFxScZ5RZJbtrgk24KyRxxWzIOHtdkIbQnbW
         Auxzr9RYHy4RKrRR78p64avHLgxK+8uSffW4YaCzBrkaV6iiwOM8VM0cGhuJTxsDnsUG
         KvNA/UToKBpa1i8ian9mKLH5BWiPxlScFpTaHDLFTS7WGkuotlQfrhGs5hAgFyLowBcJ
         DrtSotxtZL7rIF+OMIvOt9GZhzU9rPWxmGsxANkNvW1lZqWjrv6si1uqS1SAqhwM4ZFc
         Q1dQ==
X-Gm-Message-State: AOJu0YzResmYS/NTxk6+frHbMoTuaqNxYUWvUe4r6tvUpr8LlJE/whIG
        JUCTMpu9grL8BTRUbSqhRMw=
X-Google-Smtp-Source: AGHT+IF/ijfQPAUagQMR9utW7X9u3hMyteF1L/EmpYSHvLiidP3LzggjkFTr7qZE13hRNbBkeUFYiA==
X-Received: by 2002:a05:600c:1da9:b0:404:72f9:d59a with SMTP id p41-20020a05600c1da900b0040472f9d59amr1957402wms.0.1694794024864;
        Fri, 15 Sep 2023 09:07:04 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id s24-20020a7bc398000000b003feee8d8011sm7943810wmj.41.2023.09.15.09.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 09:07:04 -0700 (PDT)
Date:   Fri, 15 Sep 2023 18:07:03 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 04/16] staging: rtl8192e: Replace struct rtllib_hdr_3addr in
 rtllib_softmac.c
Message-ID: <8e385d0810132086ce44d295c47d3798960a391b.1694792595.git.philipp.g.hortmann@gmail.com>
References: <cover.1694792595.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1694792595.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace struct rtllib_hdr_3addr with struct ieee80211_hdr_3addr to avoid
proprietary struct.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_softmac.c | 50 +++++++++++------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 904be0ef867f..e3b15fa0edcb 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -187,8 +187,8 @@ inline void softmac_mgmt_xmit(struct sk_buff *skb, struct rtllib_device *ieee)
 {
 	unsigned long flags;
 	short single = ieee->softmac_features & IEEE_SOFTMAC_SINGLE_QUEUE;
-	struct rtllib_hdr_3addr  *header =
-		(struct rtllib_hdr_3addr  *)skb->data;
+	struct ieee80211_hdr_3addr  *header =
+		(struct ieee80211_hdr_3addr  *)skb->data;
 
 	struct cb_desc *tcb_desc = (struct cb_desc *)(skb->cb + 8);
 
@@ -197,7 +197,7 @@ inline void softmac_mgmt_xmit(struct sk_buff *skb, struct rtllib_device *ieee)
 	/* called with 2nd param 0, no mgmt lock required */
 	rtllib_sta_wakeup(ieee, 0);
 
-	if (ieee80211_is_beacon(header->frame_ctl))
+	if (ieee80211_is_beacon(header->frame_control))
 		tcb_desc->queue_index = BEACON_QUEUE;
 	else
 		tcb_desc->queue_index = MGNT_QUEUE;
@@ -213,7 +213,7 @@ inline void softmac_mgmt_xmit(struct sk_buff *skb, struct rtllib_device *ieee)
 		if (ieee->queue_stop) {
 			enqueue_mgmt(ieee, skb);
 		} else {
-			header->seq_ctl = cpu_to_le16(ieee->seq_ctrl[0] << 4);
+			header->seq_ctrl = cpu_to_le16(ieee->seq_ctrl[0] << 4);
 
 			if (ieee->seq_ctrl[0] == 0xFFF)
 				ieee->seq_ctrl[0] = 0;
@@ -230,7 +230,7 @@ inline void softmac_mgmt_xmit(struct sk_buff *skb, struct rtllib_device *ieee)
 		spin_unlock_irqrestore(&ieee->lock, flags);
 		spin_lock_irqsave(&ieee->mgmt_tx_lock, flags);
 
-		header->seq_ctl = cpu_to_le16(ieee->seq_ctrl[0] << 4);
+		header->seq_ctrl = cpu_to_le16(ieee->seq_ctrl[0] << 4);
 
 		if (ieee->seq_ctrl[0] == 0xFFF)
 			ieee->seq_ctrl[0] = 0;
@@ -264,12 +264,12 @@ softmac_ps_mgmt_xmit(struct sk_buff *skb,
 		     struct rtllib_device *ieee)
 {
 	short single = ieee->softmac_features & IEEE_SOFTMAC_SINGLE_QUEUE;
-	struct rtllib_hdr_3addr  *header =
-		(struct rtllib_hdr_3addr  *)skb->data;
+	struct ieee80211_hdr_3addr  *header =
+		(struct ieee80211_hdr_3addr  *)skb->data;
 	u16 fc, type, stype;
 	struct cb_desc *tcb_desc = (struct cb_desc *)(skb->cb + 8);
 
-	fc = le16_to_cpu(header->frame_ctl);
+	fc = le16_to_cpu(header->frame_control);
 	type = WLAN_FC_GET_TYPE(fc);
 	stype = WLAN_FC_GET_STYPE(fc);
 
@@ -287,7 +287,7 @@ softmac_ps_mgmt_xmit(struct sk_buff *skb,
 	tcb_desc->tx_use_drv_assinged_rate = 1;
 	if (single) {
 		if (type != RTLLIB_FTYPE_CTL) {
-			header->seq_ctl = cpu_to_le16(ieee->seq_ctrl[0] << 4);
+			header->seq_ctrl = cpu_to_le16(ieee->seq_ctrl[0] << 4);
 
 			if (ieee->seq_ctrl[0] == 0xFFF)
 				ieee->seq_ctrl[0] = 0;
@@ -300,7 +300,7 @@ softmac_ps_mgmt_xmit(struct sk_buff *skb,
 
 	} else {
 		if (type != RTLLIB_FTYPE_CTL) {
-			header->seq_ctl = cpu_to_le16(ieee->seq_ctrl[0] << 4);
+			header->seq_ctrl = cpu_to_le16(ieee->seq_ctrl[0] << 4);
 
 			if (ieee->seq_ctrl[0] == 0xFFF)
 				ieee->seq_ctrl[0] = 0;
@@ -912,21 +912,21 @@ static struct sk_buff *rtllib_probe_resp(struct rtllib_device *ieee,
 static struct sk_buff *rtllib_null_func(struct rtllib_device *ieee, short pwr)
 {
 	struct sk_buff *skb;
-	struct rtllib_hdr_3addr *hdr;
+	struct ieee80211_hdr_3addr *hdr;
 
-	skb = dev_alloc_skb(sizeof(struct rtllib_hdr_3addr) + ieee->tx_headroom);
+	skb = dev_alloc_skb(sizeof(struct ieee80211_hdr_3addr) + ieee->tx_headroom);
 	if (!skb)
 		return NULL;
 
 	skb_reserve(skb, ieee->tx_headroom);
 
-	hdr = skb_put(skb, sizeof(struct rtllib_hdr_3addr));
+	hdr = skb_put(skb, sizeof(struct ieee80211_hdr_3addr));
 
 	ether_addr_copy(hdr->addr1, ieee->current_network.bssid);
 	ether_addr_copy(hdr->addr2, ieee->dev->dev_addr);
 	ether_addr_copy(hdr->addr3, ieee->current_network.bssid);
 
-	hdr->frame_ctl = cpu_to_le16(RTLLIB_FTYPE_DATA |
+	hdr->frame_control = cpu_to_le16(RTLLIB_FTYPE_DATA |
 		RTLLIB_STYPE_NULLFUNC | RTLLIB_FCTL_TODS |
 		(pwr ? RTLLIB_FCTL_PM : 0));
 
@@ -1311,7 +1311,7 @@ static void rtllib_auth_challenge(struct rtllib_device *ieee, u8 *challenge,
 			   "Sending authentication challenge response\n");
 
 		rtllib_encrypt_fragment(ieee, skb,
-					sizeof(struct rtllib_hdr_3addr));
+					sizeof(struct ieee80211_hdr_3addr));
 
 		softmac_mgmt_xmit(skb, ieee);
 		mod_timer(&ieee->associate_timer, jiffies + (HZ / 2));
@@ -1620,11 +1620,11 @@ static short probe_rq_parse(struct rtllib_device *ieee, struct sk_buff *skb,
 	u8 *skbend;
 	u8 *ssid = NULL;
 	u8 ssidlen = 0;
-	struct rtllib_hdr_3addr   *header =
-		(struct rtllib_hdr_3addr   *)skb->data;
+	struct ieee80211_hdr_3addr   *header =
+		(struct ieee80211_hdr_3addr   *)skb->data;
 	bool bssid_match;
 
-	if (skb->len < sizeof(struct rtllib_hdr_3addr))
+	if (skb->len < sizeof(struct ieee80211_hdr_3addr))
 		return -1; /* corrupted */
 
 	bssid_match =
@@ -1637,7 +1637,7 @@ static short probe_rq_parse(struct rtllib_device *ieee, struct sk_buff *skb,
 
 	skbend = (u8 *)skb->data + skb->len;
 
-	tag = skb->data + sizeof(struct rtllib_hdr_3addr);
+	tag = skb->data + sizeof(struct ieee80211_hdr_3addr);
 
 	while (tag + 1 < skbend) {
 		if (*tag == 0) {
@@ -1953,8 +1953,8 @@ rtllib_rx_assoc_resp(struct rtllib_device *ieee, struct sk_buff *skb,
 	int aid;
 	u8 *ies;
 	struct rtllib_assoc_response_frame *assoc_resp;
-	struct rtllib_hdr_3addr *header = (struct rtllib_hdr_3addr *)skb->data;
-	u16 frame_ctl = le16_to_cpu(header->frame_ctl);
+	struct ieee80211_hdr_3addr *header = (struct ieee80211_hdr_3addr *)skb->data;
+	u16 frame_ctl = le16_to_cpu(header->frame_control);
 
 	netdev_dbg(ieee->dev, "received [RE]ASSOCIATION RESPONSE (%d)\n",
 		   WLAN_FC_GET_STYPE(frame_ctl));
@@ -2092,7 +2092,7 @@ rtllib_rx_auth(struct rtllib_device *ieee, struct sk_buff *skb,
 static inline int
 rtllib_rx_deauth(struct rtllib_device *ieee, struct sk_buff *skb)
 {
-	struct rtllib_hdr_3addr *header = (struct rtllib_hdr_3addr *)skb->data;
+	struct ieee80211_hdr_3addr *header = (struct ieee80211_hdr_3addr *)skb->data;
 	u16 frame_ctl;
 
 	if (memcmp(header->addr3, ieee->current_network.bssid, ETH_ALEN) != 0)
@@ -2104,7 +2104,7 @@ rtllib_rx_deauth(struct rtllib_device *ieee, struct sk_buff *skb)
 	if ((ieee->softmac_features & IEEE_SOFTMAC_ASSOCIATE) &&
 	    ieee->link_state == MAC80211_LINKED &&
 	    (ieee->iw_mode == IW_MODE_INFRA)) {
-		frame_ctl = le16_to_cpu(header->frame_ctl);
+		frame_ctl = le16_to_cpu(header->frame_control);
 		netdev_info(ieee->dev,
 			    "==========>received disassoc/deauth(%x) frame, reason code:%x\n",
 			    WLAN_FC_GET_STYPE(frame_ctl),
@@ -2128,13 +2128,13 @@ inline int rtllib_rx_frame_softmac(struct rtllib_device *ieee,
 				   struct rtllib_rx_stats *rx_stats, u16 type,
 				   u16 stype)
 {
-	struct rtllib_hdr_3addr *header = (struct rtllib_hdr_3addr *)skb->data;
+	struct ieee80211_hdr_3addr *header = (struct ieee80211_hdr_3addr *)skb->data;
 	u16 frame_ctl;
 
 	if (!ieee->proto_started)
 		return 0;
 
-	frame_ctl = le16_to_cpu(header->frame_ctl);
+	frame_ctl = le16_to_cpu(header->frame_control);
 	switch (WLAN_FC_GET_STYPE(frame_ctl)) {
 	case RTLLIB_STYPE_ASSOC_RESP:
 	case RTLLIB_STYPE_REASSOC_RESP:
-- 
2.42.0

