Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75537D7C6A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 07:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234772AbjJZFog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 01:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234939AbjJZFoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 01:44:13 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D40D64
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 22:44:08 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9bfbc393dfaso12044966b.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 22:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698299046; x=1698903846; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NK++5DiuxJTPHibT8VaHHf3bgG67tMPkAr+ypnICuHE=;
        b=gCkyU0fa34H0m/gUycvSu4zu3udHzb0DUOmGHq5YDjsM+pZx4F10FXbKVXBM9DvhKr
         RYFihMbGxXS0H/uUuDOh64/e7T+wMegcHcX3aXDOQ975Viz7S+hfE2Er7cikDblGsuxb
         HY9FuqXlJLmND8zFVJ+OD5LkiaWWJc8saJFZ3R13z0kmEBHnNWeuYqEAID1cWPuPXMv4
         6z29WoPpvBdUMzU7DUMQCqYTFr+NI++0tnxlM5WLBoxqet7tDsLE7YMUhRBjOPHZyb7O
         43FxOXxLNsFG34mjBDUzVL4LXCzJtaVYef4vD2EzTMLMHKDqnNhauPM4ZgVOQK2UJYKA
         TKzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698299046; x=1698903846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NK++5DiuxJTPHibT8VaHHf3bgG67tMPkAr+ypnICuHE=;
        b=n7hvOQenpBF3i7Eg6Y20JTYUd4LLU1/FnLddCJ3S8+OG23pk81IXz9ome8kKfQ4lqr
         YwdwoKqHlUUBpcolc+wNBhlE5J7WPrdgTBED/l2BrbVmMx3TQ4N5yUfBj6IJ5FdYcswQ
         WgRJy6S4hsSha/xAUEcGnp7h4vYpxNn03zRTbG4hf4y4L4AIeNZ2dsB/fHXfUQlJ7ry3
         5lVju9CdH0UKfEEFuYvKlzBBrU40uRCImuVtFw7GqDcjbsY57BmIPx5K1xwXnCQxPm5+
         btcvdmCwjS2seN2pRhYXGJv+bFMiYXT0AW4I5nccVnL7ttyLJ/ICl9EH19R/SIu6z1nt
         cCnA==
X-Gm-Message-State: AOJu0YzB8cYrp8K6WyVu3XNO9WsU+Z1IKvLQuMcOO+SM8R5R8G+Cj4EZ
        zsHlCAzSYvvHCrdyScblUzM=
X-Google-Smtp-Source: AGHT+IEZPodmVtixZvoF2A3QU5hK55l0bYHD13t2+/vkydpXb90IeMLaHJf/MEIjQBudDR2pVP5mCg==
X-Received: by 2002:a17:906:29c:b0:9c4:950:92b5 with SMTP id 28-20020a170906029c00b009c4095092b5mr12732010ejf.6.1698299046699;
        Wed, 25 Oct 2023 22:44:06 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id c2-20020a170906694200b0099bc80d5575sm10951258ejs.200.2023.10.25.22.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 22:44:06 -0700 (PDT)
Date:   Thu, 26 Oct 2023 07:44:05 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 06/10] staging: rtl8192e: Convert array rx_ring[] to variable
 rx_ring
Message-ID: <c53ff4251eba0adae6d8279a918c8ab4914b4780.1698295861.git.philipp.g.hortmann@gmail.com>
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

Convert array rx_ring[] to variable rx_ring as index is always 0. This
increases readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 25 ++++++++++----------
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h |  2 +-
 2 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 2f0fc7c0f216..d0d5b1dfff48 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -1157,10 +1157,10 @@ static void _rtl92e_free_rx_ring(struct net_device *dev)
 	}
 
 	dma_free_coherent(&priv->pdev->dev,
-			  sizeof(*priv->rx_ring[rx_queue_idx]) * priv->rxringcount,
-			  priv->rx_ring[rx_queue_idx],
+			  sizeof(*priv->rx_ring) * priv->rxringcount,
+			  priv->rx_ring,
 			  priv->rx_ring_dma[rx_queue_idx]);
-	priv->rx_ring[rx_queue_idx] = NULL;
+	priv->rx_ring = NULL;
 }
 
 static void _rtl92e_free_tx_ring(struct net_device *dev, unsigned int prio)
@@ -1354,12 +1354,11 @@ static short _rtl92e_alloc_rx_ring(struct net_device *dev)
 	int i;
 	int rx_queue_idx = 0;
 
-	priv->rx_ring[rx_queue_idx] = dma_alloc_coherent(&priv->pdev->dev,
-							 sizeof(*priv->rx_ring[rx_queue_idx]) * priv->rxringcount,
-							 &priv->rx_ring_dma[rx_queue_idx],
-							 GFP_ATOMIC);
-	if (!priv->rx_ring[rx_queue_idx] ||
-	    (unsigned long)priv->rx_ring[rx_queue_idx] & 0xFF) {
+	priv->rx_ring = dma_alloc_coherent(&priv->pdev->dev,
+					   sizeof(*priv->rx_ring) * priv->rxringcount,
+					   &priv->rx_ring_dma[rx_queue_idx],
+					   GFP_ATOMIC);
+	if (!priv->rx_ring || (unsigned long)priv->rx_ring & 0xFF) {
 		netdev_warn(dev, "Cannot allocate RX ring\n");
 		return -ENOMEM;
 	}
@@ -1370,7 +1369,7 @@ static short _rtl92e_alloc_rx_ring(struct net_device *dev)
 		struct sk_buff *skb = dev_alloc_skb(priv->rxbuffersize);
 		dma_addr_t *mapping;
 
-		entry = &priv->rx_ring[rx_queue_idx][i];
+		entry = &priv->rx_ring[i];
 		if (!skb)
 			return 0;
 		skb->dev = dev;
@@ -1456,11 +1455,11 @@ void rtl92e_reset_desc_ring(struct net_device *dev)
 	int rx_queue_idx = 0;
 	unsigned long flags = 0;
 
-	if (priv->rx_ring[rx_queue_idx]) {
+	if (priv->rx_ring) {
 		struct rx_desc *entry = NULL;
 
 		for (i = 0; i < priv->rxringcount; i++) {
-			entry = &priv->rx_ring[rx_queue_idx][i];
+			entry = &priv->rx_ring[i];
 			entry->OWN = 1;
 		}
 		priv->rx_idx[rx_queue_idx] = 0;
@@ -1574,7 +1573,7 @@ static void _rtl92e_rx_normal(struct net_device *dev)
 	stats.nic_type = NIC_8192E;
 
 	while (count--) {
-		struct rx_desc *pdesc = &priv->rx_ring[rx_queue_idx]
+		struct rx_desc *pdesc = &priv->rx_ring
 					[priv->rx_idx[rx_queue_idx]];
 		struct sk_buff *skb = priv->rx_buf[rx_queue_idx]
 				      [priv->rx_idx[rx_queue_idx]];
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index d4e998cfbefc..caa8a00cc922 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -232,7 +232,7 @@ struct r8192_priv {
 
 	u8 (*rf_set_chan)(struct net_device *dev, u8 ch);
 
-	struct rx_desc *rx_ring[MAX_RX_QUEUE];
+	struct rx_desc *rx_ring;
 	struct sk_buff	*rx_buf[MAX_RX_QUEUE][MAX_RX_COUNT];
 	dma_addr_t	rx_ring_dma[MAX_RX_QUEUE];
 	unsigned int	rx_idx[MAX_RX_QUEUE];
-- 
2.42.0

