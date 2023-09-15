Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5EE7A234A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 18:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234575AbjIOQKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 12:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235214AbjIOQKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 12:10:00 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B2B2D56
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 09:09:15 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-4046f7d49a9so5753285e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 09:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694794154; x=1695398954; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ynNGGR9H6zG8yLsSBpLmUzc6/oMQYAcAQhe/UbEO7W0=;
        b=GTb3ni+dZP6WY/DMQHbbKhY4nG+nnfXuuGWUVrrkyxbCNpru4qsfD6rHRHqiHcd1la
         M6e+eGVpGOZQOAydjV+HjxoRdfQtiZ5KLZkAsQWjkIE8lxnUrA9kJl9gAeRjVbZhZqXF
         U57mZ414sEAAFPgvILQf16Mbyjz/Imc4acfIJEVqbMrjSBzg3G0s0LUBBDTm+9TbcKQw
         B21RvhCooqoc/asjzlQNdSzNUDuh2MusynR2BKaIUGhAaOEsrEINkEomXi8+VJsZpMmZ
         DrvJqnq/+vt4msf6ibA8ic/clrGnhxj8vFvWIAJQ0EHpGRWF7KnUxqjsGeKCtr0hga38
         OE4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694794154; x=1695398954;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ynNGGR9H6zG8yLsSBpLmUzc6/oMQYAcAQhe/UbEO7W0=;
        b=fXZhr0h1qdg9r6cXcoWE8IV+i6eZuQsGEfsSjT9mUYkn1gcPcEiaLeymwAzrjEFa5D
         i+aAoeBedMygWFc31WIcrPB/WnK72vPn7dYjJKDHJV1fqeZsCtc9sNdLr1Wdlb9ZgGh+
         xhBQYOgOi6iX68pWh7Manygla0wsPKUFomd1eRl3pQnHoUz19mLkPan6IDJVzpecEopM
         X9tTzO+Fb+WEgBJOCzzrweyC9rPXhcGGH+VRTWWQQaWioeylESHFy5dqOeI7f/tI3G2Y
         FbpbmXstV7jEAFxVGVTPmRQoM9H85Wf+WbEF367IvUr+oR7fjkVB+80DWzmkAr4uE3qt
         sNSA==
X-Gm-Message-State: AOJu0Yy8x1hHSTlqF8VMZ7jKp8lfgdS1eoIWPHYp8dpOMIeVENrGYwl1
        tA+tbS2BKV+DkNe6iu56loE=
X-Google-Smtp-Source: AGHT+IHlhzwicHUW+AXzqmirR8SvviBjkS9KRug3YgBmK/c6b0ccV0WDVAI3fHG9R991lE/qqSOvfg==
X-Received: by 2002:a05:600c:500c:b0:401:b53e:6c3e with SMTP id n12-20020a05600c500c00b00401b53e6c3emr2080082wmr.1.1694794153826;
        Fri, 15 Sep 2023 09:09:13 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id y6-20020a7bcd86000000b003fee6e170f9sm4990117wmj.45.2023.09.15.09.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 09:09:13 -0700 (PDT)
Date:   Fri, 15 Sep 2023 18:09:12 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 09/16] staging: rtl8192e: Remove struct rtllib_hdr_4addr
Message-ID: <532a589e017bb6edefe60fc2ea402f541eb237ed.1694792595.git.philipp.g.hortmann@gmail.com>
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

Replace struct rtllib_hdr_4addr with struct ieee80211_hdr to avoid
proprietary code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtllib.h    | 11 ----
 drivers/staging/rtl8192e/rtllib_rx.c | 96 ++++++++++++++--------------
 2 files changed, 48 insertions(+), 59 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 717b74dc005d..dfdc45d06365 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -679,17 +679,6 @@ struct rtllib_pspoll_hdr {
 	u8 ta[ETH_ALEN];
 } __packed;
 
-struct rtllib_hdr_4addr {
-	__le16 frame_ctl;
-	__le16 duration_id;
-	u8 addr1[ETH_ALEN];
-	u8 addr2[ETH_ALEN];
-	u8 addr3[ETH_ALEN];
-	__le16 seq_ctl;
-	u8 addr4[ETH_ALEN];
-	u8 payload[];
-} __packed;
-
 struct rtllib_hdr_3addrqos {
 	__le16 frame_ctl;
 	__le16 duration_id;
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 0c2135431f5b..05d1d47bed47 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -85,11 +85,11 @@ rtllib_frag_cache_find(struct rtllib_device *ieee, unsigned int seq,
 /* Called only as a tasklet (software IRQ) */
 static struct sk_buff *
 rtllib_frag_cache_get(struct rtllib_device *ieee,
-			 struct rtllib_hdr_4addr *hdr)
+			 struct ieee80211_hdr *hdr)
 {
 	struct sk_buff *skb = NULL;
-	u16 fc = le16_to_cpu(hdr->frame_ctl);
-	u16 sc = le16_to_cpu(hdr->seq_ctl);
+	u16 fc = le16_to_cpu(hdr->frame_control);
+	u16 sc = le16_to_cpu(hdr->seq_ctrl);
 	unsigned int frag = WLAN_GET_SEQ_FRAG(sc);
 	unsigned int seq = WLAN_GET_SEQ_SEQ(sc);
 	struct rtllib_frag_entry *entry;
@@ -115,7 +115,7 @@ rtllib_frag_cache_get(struct rtllib_device *ieee,
 	if (frag == 0) {
 		/* Reserve enough space to fit maximum frame length */
 		skb = dev_alloc_skb(ieee->dev->mtu +
-				    sizeof(struct rtllib_hdr_4addr) +
+				    sizeof(struct ieee80211_hdr) +
 				    8 /* LLC */ +
 				    2 /* alignment */ +
 				    8 /* WEP */ +
@@ -156,10 +156,10 @@ rtllib_frag_cache_get(struct rtllib_device *ieee,
 
 /* Called only as a tasklet (software IRQ) */
 static int rtllib_frag_cache_invalidate(struct rtllib_device *ieee,
-					   struct rtllib_hdr_4addr *hdr)
+					   struct ieee80211_hdr *hdr)
 {
-	u16 fc = le16_to_cpu(hdr->frame_ctl);
-	u16 sc = le16_to_cpu(hdr->seq_ctl);
+	u16 fc = le16_to_cpu(hdr->frame_control);
+	u16 sc = le16_to_cpu(hdr->seq_ctrl);
 	unsigned int seq = WLAN_GET_SEQ_SEQ(sc);
 	struct rtllib_frag_entry *entry;
 	struct rtllib_hdr_3addrqos *hdr_3addrqos;
@@ -233,14 +233,14 @@ static int rtllib_is_eapol_frame(struct rtllib_device *ieee,
 {
 	struct net_device *dev = ieee->dev;
 	u16 fc, ethertype;
-	struct rtllib_hdr_4addr *hdr;
+	struct ieee80211_hdr *hdr;
 	u8 *pos;
 
 	if (skb->len < 24)
 		return 0;
 
-	hdr = (struct rtllib_hdr_4addr *)skb->data;
-	fc = le16_to_cpu(hdr->frame_ctl);
+	hdr = (struct ieee80211_hdr *)skb->data;
+	fc = le16_to_cpu(hdr->frame_control);
 
 	/* check that the frame is unicast frame to us */
 	if ((fc & (RTLLIB_FCTL_TODS | RTLLIB_FCTL_FROMDS)) ==
@@ -273,7 +273,7 @@ static inline int
 rtllib_rx_frame_decrypt(struct rtllib_device *ieee, struct sk_buff *skb,
 			struct lib80211_crypt_data *crypt)
 {
-	struct rtllib_hdr_4addr *hdr;
+	struct ieee80211_hdr *hdr;
 	int res, hdrlen;
 
 	if (crypt == NULL || crypt->ops->decrypt_mpdu == NULL)
@@ -289,8 +289,8 @@ rtllib_rx_frame_decrypt(struct rtllib_device *ieee, struct sk_buff *skb,
 			tcb_desc->bHwSec = 0;
 	}
 
-	hdr = (struct rtllib_hdr_4addr *)skb->data;
-	hdrlen = rtllib_get_hdrlen(le16_to_cpu(hdr->frame_ctl));
+	hdr = (struct ieee80211_hdr *)skb->data;
+	hdrlen = rtllib_get_hdrlen(le16_to_cpu(hdr->frame_control));
 
 	atomic_inc(&crypt->refcnt);
 	res = crypt->ops->decrypt_mpdu(skb, hdrlen, crypt->priv);
@@ -313,7 +313,7 @@ static inline int
 rtllib_rx_frame_decrypt_msdu(struct rtllib_device *ieee, struct sk_buff *skb,
 			     int keyidx, struct lib80211_crypt_data *crypt)
 {
-	struct rtllib_hdr_4addr *hdr;
+	struct ieee80211_hdr *hdr;
 	int res, hdrlen;
 
 	if (crypt == NULL || crypt->ops->decrypt_msdu == NULL)
@@ -328,8 +328,8 @@ rtllib_rx_frame_decrypt_msdu(struct rtllib_device *ieee, struct sk_buff *skb,
 			tcb_desc->bHwSec = 0;
 	}
 
-	hdr = (struct rtllib_hdr_4addr *)skb->data;
-	hdrlen = rtllib_get_hdrlen(le16_to_cpu(hdr->frame_ctl));
+	hdr = (struct ieee80211_hdr *)skb->data;
+	hdrlen = rtllib_get_hdrlen(le16_to_cpu(hdr->frame_control));
 
 	atomic_inc(&crypt->refcnt);
 	res = crypt->ops->decrypt_msdu(skb, keyidx, hdrlen, crypt->priv);
@@ -347,10 +347,10 @@ rtllib_rx_frame_decrypt_msdu(struct rtllib_device *ieee, struct sk_buff *skb,
 /* this function is stolen from ipw2200 driver*/
 #define IEEE_PACKET_RETRY_TIME (5 * HZ)
 static int is_duplicate_packet(struct rtllib_device *ieee,
-				      struct rtllib_hdr_4addr *header)
+				      struct ieee80211_hdr *header)
 {
-	u16 fc = le16_to_cpu(header->frame_ctl);
-	u16 sc = le16_to_cpu(header->seq_ctl);
+	u16 fc = le16_to_cpu(header->frame_control);
+	u16 sc = le16_to_cpu(header->seq_ctrl);
 	u16 seq = WLAN_GET_SEQ_SEQ(sc);
 	u16 frag = WLAN_GET_SEQ_FRAG(sc);
 	u16 *last_seq, *last_frag;
@@ -880,8 +880,8 @@ static size_t rtllib_rx_get_hdrlen(struct rtllib_device *ieee,
 				   struct sk_buff *skb,
 				   struct rtllib_rx_stats *rx_stats)
 {
-	struct rtllib_hdr_4addr *hdr = (struct rtllib_hdr_4addr *)skb->data;
-	u16 fc = le16_to_cpu(hdr->frame_ctl);
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+	u16 fc = le16_to_cpu(hdr->frame_control);
 	size_t hdrlen;
 
 	hdrlen = rtllib_get_hdrlen(fc);
@@ -902,19 +902,19 @@ static size_t rtllib_rx_get_hdrlen(struct rtllib_device *ieee,
 static int rtllib_rx_check_duplicate(struct rtllib_device *ieee,
 				     struct sk_buff *skb, u8 multicast)
 {
-	struct rtllib_hdr_4addr *hdr = (struct rtllib_hdr_4addr *)skb->data;
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	u16 fc, sc;
 	u8 frag;
 
-	fc = le16_to_cpu(hdr->frame_ctl);
-	sc = le16_to_cpu(hdr->seq_ctl);
+	fc = le16_to_cpu(hdr->frame_control);
+	sc = le16_to_cpu(hdr->seq_ctrl);
 	frag = WLAN_GET_SEQ_FRAG(sc);
 
 	if (!ieee->ht_info->cur_rx_reorder_enable ||
 		!ieee->current_network.qos_data.active ||
 		!IsDataFrame(skb->data) ||
 		IsLegacyDataFrame(skb->data)) {
-		if (!ieee80211_is_beacon(hdr->frame_ctl)) {
+		if (!ieee80211_is_beacon(hdr->frame_control)) {
 			if (is_duplicate_packet(ieee, hdr))
 				return -1;
 		}
@@ -939,10 +939,10 @@ static int rtllib_rx_check_duplicate(struct rtllib_device *ieee,
 }
 
 static void rtllib_rx_extract_addr(struct rtllib_device *ieee,
-				   struct rtllib_hdr_4addr *hdr, u8 *dst,
+				   struct ieee80211_hdr *hdr, u8 *dst,
 				   u8 *src, u8 *bssid)
 {
-	u16 fc = le16_to_cpu(hdr->frame_ctl);
+	u16 fc = le16_to_cpu(hdr->frame_control);
 
 	switch (fc & (RTLLIB_FCTL_FROMDS | RTLLIB_FCTL_TODS)) {
 	case RTLLIB_FCTL_FROMDS:
@@ -1026,8 +1026,8 @@ static int rtllib_rx_data_filter(struct rtllib_device *ieee, u16 fc,
 static int rtllib_rx_get_crypt(struct rtllib_device *ieee, struct sk_buff *skb,
 			struct lib80211_crypt_data **crypt, size_t hdrlen)
 {
-	struct rtllib_hdr_4addr *hdr = (struct rtllib_hdr_4addr *)skb->data;
-	u16 fc = le16_to_cpu(hdr->frame_ctl);
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+	u16 fc = le16_to_cpu(hdr->frame_control);
 	int idx = 0;
 
 	if (skb->len >= hdrlen + 3)
@@ -1060,14 +1060,14 @@ static int rtllib_rx_decrypt(struct rtllib_device *ieee, struct sk_buff *skb,
 		      struct rtllib_rx_stats *rx_stats,
 		      struct lib80211_crypt_data *crypt, size_t hdrlen)
 {
-	struct rtllib_hdr_4addr *hdr;
+	struct ieee80211_hdr *hdr;
 	int keyidx = 0;
 	u16 fc, sc;
 	u8 frag;
 
-	hdr = (struct rtllib_hdr_4addr *)skb->data;
-	fc = le16_to_cpu(hdr->frame_ctl);
-	sc = le16_to_cpu(hdr->seq_ctl);
+	hdr = (struct ieee80211_hdr *)skb->data;
+	fc = le16_to_cpu(hdr->frame_control);
+	sc = le16_to_cpu(hdr->seq_ctrl);
 	frag = WLAN_GET_SEQ_FRAG(sc);
 
 	if ((!rx_stats->Decrypted))
@@ -1081,7 +1081,7 @@ static int rtllib_rx_decrypt(struct rtllib_device *ieee, struct sk_buff *skb,
 		return -1;
 	}
 
-	hdr = (struct rtllib_hdr_4addr *)skb->data;
+	hdr = (struct ieee80211_hdr *)skb->data;
 	if ((frag != 0 || (fc & RTLLIB_FCTL_MOREFRAGS))) {
 		int flen;
 		struct sk_buff *frag_skb = rtllib_frag_cache_get(ieee, hdr);
@@ -1133,7 +1133,7 @@ static int rtllib_rx_decrypt(struct rtllib_device *ieee, struct sk_buff *skb,
 		 * delivered, so remove skb from fragment cache
 		 */
 		skb = frag_skb;
-		hdr = (struct rtllib_hdr_4addr *)skb->data;
+		hdr = (struct ieee80211_hdr *)skb->data;
 		rtllib_frag_cache_invalidate(ieee, hdr);
 	}
 
@@ -1146,7 +1146,7 @@ static int rtllib_rx_decrypt(struct rtllib_device *ieee, struct sk_buff *skb,
 		return -1;
 	}
 
-	hdr = (struct rtllib_hdr_4addr *)skb->data;
+	hdr = (struct ieee80211_hdr *)skb->data;
 	if (crypt && !(fc & RTLLIB_FCTL_WEP) && !ieee->open_wep) {
 		if (/*ieee->ieee802_1x &&*/
 		    rtllib_is_eapol_frame(ieee, skb, hdrlen)) {
@@ -1272,7 +1272,7 @@ static int rtllib_rx_InfraAdhoc(struct rtllib_device *ieee, struct sk_buff *skb,
 		 struct rtllib_rx_stats *rx_stats)
 {
 	struct net_device *dev = ieee->dev;
-	struct rtllib_hdr_4addr *hdr = (struct rtllib_hdr_4addr *)skb->data;
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	struct lib80211_crypt_data *crypt = NULL;
 	struct rtllib_rxb *rxb = NULL;
 	struct rx_ts_record *ts = NULL;
@@ -1286,10 +1286,10 @@ static int rtllib_rx_InfraAdhoc(struct rtllib_device *ieee, struct sk_buff *skb,
 	bool bToOtherSTA = false;
 	int ret = 0, i = 0;
 
-	fc = le16_to_cpu(hdr->frame_ctl);
+	fc = le16_to_cpu(hdr->frame_control);
 	type = WLAN_FC_GET_TYPE(fc);
 	stype = WLAN_FC_GET_STYPE(fc);
-	sc = le16_to_cpu(hdr->seq_ctl);
+	sc = le16_to_cpu(hdr->seq_ctrl);
 
 	/*Filter pkt not to me*/
 	multicast = is_multicast_ether_addr(hdr->addr1);
@@ -1375,7 +1375,7 @@ static int rtllib_rx_InfraAdhoc(struct rtllib_device *ieee, struct sk_buff *skb,
 		goto rx_exit;
 
 	/* Get TS for Rx Reorder  */
-	hdr = (struct rtllib_hdr_4addr *)skb->data;
+	hdr = (struct ieee80211_hdr *)skb->data;
 	if (ieee->current_network.qos_data.active && IsQoSDataFrame(skb->data)
 		&& !is_multicast_ether_addr(hdr->addr1)
 		&& (!bToOtherSTA)) {
@@ -1443,8 +1443,8 @@ static int rtllib_rx_InfraAdhoc(struct rtllib_device *ieee, struct sk_buff *skb,
 static int rtllib_rx_Monitor(struct rtllib_device *ieee, struct sk_buff *skb,
 		 struct rtllib_rx_stats *rx_stats)
 {
-	struct rtllib_hdr_4addr *hdr = (struct rtllib_hdr_4addr *)skb->data;
-	u16 fc = le16_to_cpu(hdr->frame_ctl);
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+	u16 fc = le16_to_cpu(hdr->frame_control);
 	size_t hdrlen = rtllib_get_hdrlen(fc);
 
 	if (skb->len < hdrlen) {
@@ -2634,13 +2634,13 @@ static void rtllib_rx_mgt(struct rtllib_device *ieee,
 			  struct sk_buff *skb,
 			  struct rtllib_rx_stats *stats)
 {
-	struct rtllib_hdr_4addr *header = (struct rtllib_hdr_4addr *)skb->data;
+	struct ieee80211_hdr *header = (struct ieee80211_hdr *)skb->data;
 
-	if (!ieee80211_is_probe_resp(header->frame_ctl) &&
-	    (!ieee80211_is_beacon(header->frame_ctl)))
+	if (!ieee80211_is_probe_resp(header->frame_control) &&
+	    (!ieee80211_is_beacon(header->frame_control)))
 		ieee->last_rx_ps_time = jiffies;
 
-	if (ieee80211_is_beacon(header->frame_ctl)) {
+	if (ieee80211_is_beacon(header->frame_control)) {
 		netdev_dbg(ieee->dev, "received BEACON\n");
 		rtllib_process_probe_response(
 				ieee, (struct rtllib_probe_response *)header,
@@ -2650,11 +2650,11 @@ static void rtllib_rx_mgt(struct rtllib_device *ieee,
 		    ieee->iw_mode == IW_MODE_INFRA &&
 		    ieee->link_state == MAC80211_LINKED))
 			schedule_work(&ieee->ps_task);
-	} else if (ieee80211_is_probe_resp(header->frame_ctl)) {
+	} else if (ieee80211_is_probe_resp(header->frame_control)) {
 		netdev_dbg(ieee->dev, "received PROBE RESPONSE\n");
 		rtllib_process_probe_response(ieee,
 			      (struct rtllib_probe_response *)header, stats);
-	} else if (ieee80211_is_probe_req(header->frame_ctl)) {
+	} else if (ieee80211_is_probe_req(header->frame_control)) {
 		netdev_dbg(ieee->dev, "received PROBE REQUEST\n");
 		if ((ieee->softmac_features & IEEE_SOFTMAC_PROBERS) &&
 		    (ieee->iw_mode == IW_MODE_ADHOC &&
-- 
2.42.0

