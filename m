Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF807D7C70
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 07:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234894AbjJZFoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 01:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344194AbjJZFoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 01:44:34 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E19F195
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 22:44:28 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9c14313eb1cso12811966b.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 22:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698299067; x=1698903867; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I7zJ5qciR0a1yJaFSt2HKre85R/60luQy84wqPr6HdY=;
        b=Y0Wzf9VDObOSyO+oVqvnU7Vxzi0rBIeQJCjboKDhWuX0/dbTIDpN9cB5ipJ464AZyW
         SPVj23r/ok1GEe5X9K5647rAWKHmakGuv0FzbMyuX1Des1xTkI8TPlGg0kFdOjMCk0Sp
         Upm8TEz3PnqPsUNlv7aO0VaGajj8dlk63nmKlWNX/XWKnTG7ACpDB3btA6u0T0dzhCGU
         sO0LjCQI54IkhESZ/1Fg78kCidTDFMzwP+7giFTygbY4v+YJS6vROq2w2hepURPbUvvv
         YvIHCwa7m1aCqD1XPiLdKE7V2qe6ybP13moGs7JOAlFCOyrCHlZSYPpPA7YfYUx1rQ/a
         XJZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698299067; x=1698903867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I7zJ5qciR0a1yJaFSt2HKre85R/60luQy84wqPr6HdY=;
        b=chnO34jFAOh3fhPEKylMimev2mWJfKQU4NVEPuTXW/wB8q9iYqleANBP99JmHxUqLU
         xA0BtIxd1p0rZAOEiTZsxC6AmBuM+J4uiRRtLth6ZRPLlsQ/A/Ry3Ap6wtYRwXuAeDir
         bo/niXs5nkV1b5pratm/Qx8HxMPn22gJfBgVb7hLvHMBPY5Nyv+t6ut7GnyW/xa+vpvp
         en7688Hg1kxNPLQ7sO/A5B0+pDi7hqHCbETtcdkUWyT2N2RtTDRZUese+9gbfdthG52C
         C5gWJB38WIpY1cAWlifiAlBvGLBG6szDNLDy2slXRJIy+m2Ohs5uynAM8nyzuhwuMaLT
         cEaA==
X-Gm-Message-State: AOJu0YzDxZcBS8zY30utej4lb2fA/8HNi6ue9g4XCU+Gax5u40zM89gV
        jUe+slQVvHKSNKNl+QpwSAw=
X-Google-Smtp-Source: AGHT+IHV6G3U8Ei6EOu/OCLtkRiBF8d/MORMapHftlJzMU92/7VuVDsYg8oqia1NozyCxV+whorzvw==
X-Received: by 2002:a17:906:74d1:b0:9bf:5696:9154 with SMTP id z17-20020a17090674d100b009bf56969154mr11621970ejl.2.1698299066717;
        Wed, 25 Oct 2023 22:44:26 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id gs26-20020a170906f19a00b0099ddc81903asm11076722ejb.221.2023.10.25.22.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 22:44:26 -0700 (PDT)
Date:   Thu, 26 Oct 2023 07:44:24 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 09/10] staging: rtl8192e: Convert array rx_idx[] to variable
 rx_idx
Message-ID: <f9e3ee95cdc2de810687a9c71f1a9f8d8fdbeac1.1698295861.git.philipp.g.hortmann@gmail.com>
References: <cover.1698295861.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1698295861.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert array rx_idx[] to variable rx_idx as index is always 0. Remove
unused rx_queue_idx as well. This increases readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 18 +++++++-----------
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h |  2 +-
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 8af732870ddf..d2a8a9543579 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -1142,7 +1142,6 @@ static void _rtl92e_free_rx_ring(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
 	int i;
-	int rx_queue_idx = 0;
 
 	for (i = 0; i < priv->rxringcount; i++) {
 		struct sk_buff *skb = priv->rx_buf[i];
@@ -1352,7 +1351,6 @@ static short _rtl92e_alloc_rx_ring(struct net_device *dev)
 	struct r8192_priv *priv = rtllib_priv(dev);
 	struct rx_desc *entry = NULL;
 	int i;
-	int rx_queue_idx = 0;
 
 	priv->rx_ring = dma_alloc_coherent(&priv->pdev->dev,
 					   sizeof(*priv->rx_ring) * priv->rxringcount,
@@ -1363,7 +1361,7 @@ static short _rtl92e_alloc_rx_ring(struct net_device *dev)
 		return -ENOMEM;
 	}
 
-	priv->rx_idx[rx_queue_idx] = 0;
+	priv->rx_idx = 0;
 
 	for (i = 0; i < priv->rxringcount; i++) {
 		struct sk_buff *skb = dev_alloc_skb(priv->rxbuffersize);
@@ -1452,7 +1450,6 @@ void rtl92e_reset_desc_ring(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
 	int i;
-	int rx_queue_idx = 0;
 	unsigned long flags = 0;
 
 	if (priv->rx_ring) {
@@ -1462,7 +1459,7 @@ void rtl92e_reset_desc_ring(struct net_device *dev)
 			entry = &priv->rx_ring[i];
 			entry->OWN = 1;
 		}
-		priv->rx_idx[rx_queue_idx] = 0;
+		priv->rx_idx = 0;
 	}
 
 	spin_lock_irqsave(&priv->irq_th_lock, flags);
@@ -1561,7 +1558,6 @@ static void _rtl92e_rx_normal(struct net_device *dev)
 	struct ieee80211_hdr *rtllib_hdr = NULL;
 	bool unicast_packet = false;
 	u32 skb_len = 0;
-	int rx_queue_idx = RX_MPDU_QUEUE;
 
 	struct rtllib_rx_stats stats = {
 		.signal = 0,
@@ -1574,9 +1570,9 @@ static void _rtl92e_rx_normal(struct net_device *dev)
 
 	while (count--) {
 		struct rx_desc *pdesc = &priv->rx_ring
-					[priv->rx_idx[rx_queue_idx]];
+					[priv->rx_idx];
 		struct sk_buff *skb = priv->rx_buf
-				      [priv->rx_idx[rx_queue_idx]];
+				      [priv->rx_idx];
 		struct sk_buff *new_skb;
 
 		if (pdesc->OWN)
@@ -1614,7 +1610,7 @@ static void _rtl92e_rx_normal(struct net_device *dev)
 		skb = new_skb;
 		skb->dev = dev;
 
-		priv->rx_buf[priv->rx_idx[rx_queue_idx]] =
+		priv->rx_buf[priv->rx_idx] =
 								 skb;
 		*((dma_addr_t *)skb->cb) = dma_map_single(&priv->pdev->dev,
 							  skb_tail_pointer(skb),
@@ -1627,9 +1623,9 @@ static void _rtl92e_rx_normal(struct net_device *dev)
 		pdesc->BufferAddress = *((dma_addr_t *)skb->cb);
 		pdesc->OWN = 1;
 		pdesc->Length = priv->rxbuffersize;
-		if (priv->rx_idx[rx_queue_idx] == priv->rxringcount - 1)
+		if (priv->rx_idx == priv->rxringcount - 1)
 			pdesc->EOR = 1;
-		priv->rx_idx[rx_queue_idx] = (priv->rx_idx[rx_queue_idx] + 1) %
+		priv->rx_idx = (priv->rx_idx + 1) %
 					      priv->rxringcount;
 	}
 }
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index b3ebff2df62a..a6c47388d72c 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -235,7 +235,7 @@ struct r8192_priv {
 	struct rx_desc *rx_ring;
 	struct sk_buff	*rx_buf[MAX_RX_COUNT];
 	dma_addr_t	rx_ring_dma;
-	unsigned int	rx_idx[MAX_RX_QUEUE];
+	unsigned int	rx_idx;
 	int		rxringcount;
 	u16		rxbuffersize;
 
-- 
2.42.0

