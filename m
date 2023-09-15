Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0587A234B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 18:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236174AbjIOQK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 12:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235229AbjIOQKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 12:10:00 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32FA92703
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 09:09:22 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-404800222d2so1274345e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 09:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694794160; x=1695398960; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ABHro1WbVSv9M1mp1iSF234oY2ZCcRBRXlCCIHJK3dU=;
        b=XsbyEOSxEMt0yzsQZwlir5nDBPxXbA72fEmNZgwyLqplm39MLBOF9R/G6ob24ufKn0
         NKcVwOJQMNXDxL1vaAvbmFpH67vFxk1pDlGr6AewIKSC37Vn97te6+8KIy/TTPXfXe5k
         JwtXPyxBKB9TCdBTRKY9qVlBp0BYolj8g4Bf3922QlOOGI8Gjo4NX92cwvoa2eP5UkaB
         0Z5uYJCZ+UMErV0oG/0TcOMP4h4ZgamN+sQ09dMgbnWSoDSsfdUkghU12FVdz9g6E/+K
         9tCsngWaLAWzMIxUWYsVKG8Xj1aRTR8E6cm1oAczJQnJOUOl7djh3ZKfn/7eb5zYfLip
         yxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694794160; x=1695398960;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ABHro1WbVSv9M1mp1iSF234oY2ZCcRBRXlCCIHJK3dU=;
        b=HnSyOZGvciUbDU9z5hFbMUjWlDDHsrZn4rJY1cgIhEvWiw2ybpcSmOHsJIwDm/8Avz
         SkvUeN3wlddgPdluaX4eKpISpXPgOqc2dBAZzy+0TeUYU1aqUod8eMXuHep+cMZfPZ+i
         2MCjxz5/WspAkiLGHgxyjSVlmPsp69DLMAlKUUPXbZKlpXNJtXKLOt0xFxbA5lIx89wg
         ToVk1HVubw/k/ChO65T6ObNIjmiDi1RnERXjACq2Dy7DUoUeWye9lHV+w1o3Q27Nq2hl
         /OZiLBtsC7GnAftXN/U8pA2zzODgcBFLTSEsN3qcszlsdGA+pXLX8t8ihtqfJI5IVrtY
         IDpg==
X-Gm-Message-State: AOJu0Yz9/f6UomAzA4LJL1AZz1Ra5Dqf4NZjZDa8+Y8EhA3UWIA6VAS7
        ED9HNSx5rptnbODNT1iMt/8=
X-Google-Smtp-Source: AGHT+IHCEiDjU07u0tGx9Pyzk8I6wtgw2o7MegPhc89b8M2XnCyb0Aa32kumf3Tk5DNm3vYcpxXEFw==
X-Received: by 2002:a05:600c:5106:b0:3fe:d637:7b25 with SMTP id o6-20020a05600c510600b003fed6377b25mr2002791wms.0.1694794160276;
        Fri, 15 Sep 2023 09:09:20 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id n7-20020a7bcbc7000000b003fef3180e7asm7827085wmi.44.2023.09.15.09.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 09:09:20 -0700 (PDT)
Date:   Fri, 15 Sep 2023 18:09:18 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 10/16] staging: rtl8192e: Remove struct rtllib_hdr_3addrqos
Message-ID: <f9c52f9822075476d491b2f1061af51a4b818f3a.1694792595.git.philipp.g.hortmann@gmail.com>
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

Replace struct rtllib_hdr_3addrqos with struct ieee80211_qos_hdr to avoid
proprietary code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtllib.h    | 11 -----------
 drivers/staging/rtl8192e/rtllib_rx.c | 18 +++++++++---------
 drivers/staging/rtl8192e/rtllib_tx.c | 22 +++++++++++-----------
 3 files changed, 20 insertions(+), 31 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index dfdc45d06365..e73292201e3a 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -679,17 +679,6 @@ struct rtllib_pspoll_hdr {
 	u8 ta[ETH_ALEN];
 } __packed;
 
-struct rtllib_hdr_3addrqos {
-	__le16 frame_ctl;
-	__le16 duration_id;
-	u8 addr1[ETH_ALEN];
-	u8 addr2[ETH_ALEN];
-	u8 addr3[ETH_ALEN];
-	__le16 seq_ctl;
-	__le16 qos_ctl;
-	u8 payload[];
-} __packed;
-
 struct rtllib_hdr_4addrqos {
 	__le16 frame_ctl;
 	__le16 duration_id;
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 05d1d47bed47..265a718a20a4 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -93,7 +93,7 @@ rtllib_frag_cache_get(struct rtllib_device *ieee,
 	unsigned int frag = WLAN_GET_SEQ_FRAG(sc);
 	unsigned int seq = WLAN_GET_SEQ_SEQ(sc);
 	struct rtllib_frag_entry *entry;
-	struct rtllib_hdr_3addrqos *hdr_3addrqos;
+	struct ieee80211_qos_hdr *hdr_3addrqos;
 	struct rtllib_hdr_4addrqos *hdr_4addrqos;
 	u8 tid;
 
@@ -104,8 +104,8 @@ rtllib_frag_cache_get(struct rtllib_device *ieee,
 		tid = UP2AC(tid);
 		tid++;
 	} else if (RTLLIB_QOS_HAS_SEQ(fc)) {
-		hdr_3addrqos = (struct rtllib_hdr_3addrqos *)hdr;
-		tid = le16_to_cpu(hdr_3addrqos->qos_ctl) & RTLLIB_QCTL_TID;
+		hdr_3addrqos = (struct ieee80211_qos_hdr *)hdr;
+		tid = le16_to_cpu(hdr_3addrqos->qos_ctrl) & RTLLIB_QCTL_TID;
 		tid = UP2AC(tid);
 		tid++;
 	} else {
@@ -162,7 +162,7 @@ static int rtllib_frag_cache_invalidate(struct rtllib_device *ieee,
 	u16 sc = le16_to_cpu(hdr->seq_ctrl);
 	unsigned int seq = WLAN_GET_SEQ_SEQ(sc);
 	struct rtllib_frag_entry *entry;
-	struct rtllib_hdr_3addrqos *hdr_3addrqos;
+	struct ieee80211_qos_hdr *hdr_3addrqos;
 	struct rtllib_hdr_4addrqos *hdr_4addrqos;
 	u8 tid;
 
@@ -173,8 +173,8 @@ static int rtllib_frag_cache_invalidate(struct rtllib_device *ieee,
 		tid = UP2AC(tid);
 		tid++;
 	} else if (RTLLIB_QOS_HAS_SEQ(fc)) {
-		hdr_3addrqos = (struct rtllib_hdr_3addrqos *)hdr;
-		tid = le16_to_cpu(hdr_3addrqos->qos_ctl) & RTLLIB_QCTL_TID;
+		hdr_3addrqos = (struct ieee80211_qos_hdr *)hdr;
+		tid = le16_to_cpu(hdr_3addrqos->qos_ctrl) & RTLLIB_QCTL_TID;
 		tid = UP2AC(tid);
 		tid++;
 	} else {
@@ -355,7 +355,7 @@ static int is_duplicate_packet(struct rtllib_device *ieee,
 	u16 frag = WLAN_GET_SEQ_FRAG(sc);
 	u16 *last_seq, *last_frag;
 	unsigned long *last_time;
-	struct rtllib_hdr_3addrqos *hdr_3addrqos;
+	struct ieee80211_qos_hdr *hdr_3addrqos;
 	struct rtllib_hdr_4addrqos *hdr_4addrqos;
 	u8 tid;
 
@@ -366,8 +366,8 @@ static int is_duplicate_packet(struct rtllib_device *ieee,
 		tid = UP2AC(tid);
 		tid++;
 	} else if (RTLLIB_QOS_HAS_SEQ(fc)) {
-		hdr_3addrqos = (struct rtllib_hdr_3addrqos *)header;
-		tid = le16_to_cpu(hdr_3addrqos->qos_ctl) & RTLLIB_QCTL_TID;
+		hdr_3addrqos = (struct ieee80211_qos_hdr *)header;
+		tid = le16_to_cpu(hdr_3addrqos->qos_ctrl) & RTLLIB_QCTL_TID;
 		tid = UP2AC(tid);
 		tid++;
 	} else {
diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index a244a072e551..4b730b2c9fef 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -544,17 +544,17 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 	struct rtllib_device *ieee = (struct rtllib_device *)
 				     netdev_priv_rsl(dev);
 	struct rtllib_txb *txb = NULL;
-	struct rtllib_hdr_3addrqos *frag_hdr;
+	struct ieee80211_qos_hdr *frag_hdr;
 	int i, bytes_per_frag, nr_frags, bytes_last_frag, frag_size;
 	unsigned long flags;
 	struct net_device_stats *stats = &ieee->stats;
 	int ether_type = 0, encrypt;
 	int bytes, fc, qos_ctl = 0, hdr_len;
 	struct sk_buff *skb_frag;
-	struct rtllib_hdr_3addrqos header = { /* Ensure zero initialized */
+	struct ieee80211_qos_hdr header = { /* Ensure zero initialized */
 		.duration_id = 0,
-		.seq_ctl = 0,
-		.qos_ctl = 0
+		.seq_ctrl = 0,
+		.qos_ctrl = 0
 	};
 	int qos_activated = ieee->current_network.qos_data.active;
 	u8 dest[ETH_ALEN];
@@ -689,7 +689,7 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 
 		bIsMulticast = is_multicast_ether_addr(header.addr1);
 
-		header.frame_ctl = cpu_to_le16(fc);
+		header.frame_control = cpu_to_le16(fc);
 
 		/* Determine fragmentation size based on destination (multicast
 		 * and broadcast are not fragmented)
@@ -716,7 +716,7 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 			}
 
 			qos_ctl |= skb->priority;
-			header.qos_ctl = cpu_to_le16(qos_ctl & RTLLIB_QOS_TID);
+			header.qos_ctrl = cpu_to_le16(qos_ctl & RTLLIB_QOS_TID);
 
 		} else {
 			hdr_len = RTLLIB_3ADDR_LEN;
@@ -798,7 +798,7 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 			 * MOREFRAGS bit to the frame control
 			 */
 			if (i != nr_frags - 1) {
-				frag_hdr->frame_ctl = cpu_to_le16(fc |
+				frag_hdr->frame_control = cpu_to_le16(fc |
 								  RTLLIB_FCTL_MOREFRAGS);
 				bytes = bytes_per_frag;
 
@@ -807,13 +807,13 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 				bytes = bytes_last_frag;
 			}
 			if ((qos_activated) && (!bIsMulticast)) {
-				frag_hdr->seq_ctl =
+				frag_hdr->seq_ctrl =
 					 cpu_to_le16(rtllib_query_seqnum(ieee, skb_frag,
 									 header.addr1));
-				frag_hdr->seq_ctl =
-					 cpu_to_le16(le16_to_cpu(frag_hdr->seq_ctl) << 4 | i);
+				frag_hdr->seq_ctrl =
+					 cpu_to_le16(le16_to_cpu(frag_hdr->seq_ctrl) << 4 | i);
 			} else {
-				frag_hdr->seq_ctl =
+				frag_hdr->seq_ctrl =
 					 cpu_to_le16(ieee->seq_ctrl[0] << 4 | i);
 			}
 			/* Put a SNAP header on the first fragment */
-- 
2.42.0

