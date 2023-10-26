Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB847D7C6C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 07:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344111AbjJZFok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 01:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344280AbjJZFoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 01:44:06 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E066419B
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 22:44:02 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9bfbc393dfaso12039666b.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 22:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698299041; x=1698903841; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=avBMhTQILI4e6+6heKlFl4WenhKlgtCr5qfdN9CAMvo=;
        b=A9sgZmAcVOe40V3fI2znJzna6yxZr4zSrxjV/i3KkiN130cAlArb6jJzKBESXgNeid
         YM+uYToNo/L7G2DUXBOPRkA1qt8pguO4uyl1SKaojNgZZtuFiV+1eBZMgnEeYQn1I2Ay
         VLPIE7vjD+ZdKhYDwUEE6X9s2qUrN7f3R3P67TFo0NSCZiR4Lu51T3Bvmz13m9NmKy3F
         m+7ysw0EyznXoIiD97YC0yEu+7pUoa5EJ2IwX5PzcyWdp+0XTTFp4G3i6JrOwLDQydiY
         bhR8S2gy/lewlCKOR1b8SZnJ1yGmFCGucK5muq5u9VZTpN3ttVbSZLDuKDIdcPgoXlsW
         FTGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698299041; x=1698903841;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=avBMhTQILI4e6+6heKlFl4WenhKlgtCr5qfdN9CAMvo=;
        b=LVGBcifnfZr9QgSjVmFVlp7aFFxDgedibTib5D2TEZBfSa/G1du4qkYPByl80AIwin
         S3BGj98YQG2gSouY/QQosQIYXEMmQ4rH3FY2HZp2LpUwMCyxB22zT23YOhMIgnucFz8/
         cMV628lc7dXeRmzVqU/Mi7unYdHd/NLK33NcGkiF/G//+ylyMSfld+R546PCVCGHe+g8
         Ji7L+6aXmf7kA8KD/eXE6LU4APKfKwYzqutlIaC52sjqPgBPspruoktzIQTcu/Muyw5R
         z/tYeYZNNtkg5Bmk3nlk20xKwp0vV1PrKTOZyefm1KJGSoyGxVV7pjPdfBUrL6mfaVVu
         qIYw==
X-Gm-Message-State: AOJu0YwF4UX8pTRaQTSXMRfuW9RSx6wk+MpfnFk24HLa2P2ePB0jKyYA
        ljmhupN39xJsFgcFnjMJFPM=
X-Google-Smtp-Source: AGHT+IEEzgom6mUp2yUfo9xYoRFpn+T5Mb10i99mbJrjpR95Hr8MtlWpnJhzqpwT1m9pnoOxb/NGuA==
X-Received: by 2002:a17:906:51ce:b0:9ae:2f35:442a with SMTP id v14-20020a17090651ce00b009ae2f35442amr10465695ejk.5.1698299041064;
        Wed, 25 Oct 2023 22:44:01 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id o14-20020a17090611ce00b009b29553b648sm10907859eja.206.2023.10.25.22.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 22:44:00 -0700 (PDT)
Date:   Thu, 26 Oct 2023 07:43:59 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 05/10] staging: rtl8192e: Remove loops with constant
 MAX_RX_QUEUE
Message-ID: <8bc9d3c15fba082a928ea2c0916a6aef5f76f456.1698295861.git.philipp.g.hortmann@gmail.com>
References: <cover.1698295861.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1698295861.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MAX_RX_QUEUE is set to 1. All loops with MAX_RX_QUEUE run only one cycle.
Remove loops.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 120 +++++++++----------
 1 file changed, 58 insertions(+), 62 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index ba35ae4a21fa..2f0fc7c0f216 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -1141,28 +1141,26 @@ void rtl92e_tx_enable(struct net_device *dev)
 static void _rtl92e_free_rx_ring(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
-	int i, rx_queue_idx;
-
-	for (rx_queue_idx = 0; rx_queue_idx < MAX_RX_QUEUE;
-	     rx_queue_idx++) {
-		for (i = 0; i < priv->rxringcount; i++) {
-			struct sk_buff *skb = priv->rx_buf[rx_queue_idx][i];
+	int i;
+	int rx_queue_idx = 0;
 
-			if (!skb)
-				continue;
+	for (i = 0; i < priv->rxringcount; i++) {
+		struct sk_buff *skb = priv->rx_buf[rx_queue_idx][i];
 
-			dma_unmap_single(&priv->pdev->dev,
-					 *((dma_addr_t *)skb->cb),
-					 priv->rxbuffersize, DMA_FROM_DEVICE);
-			kfree_skb(skb);
-		}
+		if (!skb)
+			continue;
 
-		dma_free_coherent(&priv->pdev->dev,
-				  sizeof(*priv->rx_ring[rx_queue_idx]) * priv->rxringcount,
-				  priv->rx_ring[rx_queue_idx],
-				  priv->rx_ring_dma[rx_queue_idx]);
-		priv->rx_ring[rx_queue_idx] = NULL;
+		dma_unmap_single(&priv->pdev->dev,
+				 *((dma_addr_t *)skb->cb),
+				 priv->rxbuffersize, DMA_FROM_DEVICE);
+		kfree_skb(skb);
 	}
+
+	dma_free_coherent(&priv->pdev->dev,
+			  sizeof(*priv->rx_ring[rx_queue_idx]) * priv->rxringcount,
+			  priv->rx_ring[rx_queue_idx],
+			  priv->rx_ring_dma[rx_queue_idx]);
+	priv->rx_ring[rx_queue_idx] = NULL;
 }
 
 static void _rtl92e_free_tx_ring(struct net_device *dev, unsigned int prio)
@@ -1353,47 +1351,46 @@ static short _rtl92e_alloc_rx_ring(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
 	struct rx_desc *entry = NULL;
-	int i, rx_queue_idx;
-
-	for (rx_queue_idx = 0; rx_queue_idx < MAX_RX_QUEUE; rx_queue_idx++) {
-		priv->rx_ring[rx_queue_idx] = dma_alloc_coherent(&priv->pdev->dev,
-								 sizeof(*priv->rx_ring[rx_queue_idx]) * priv->rxringcount,
-								 &priv->rx_ring_dma[rx_queue_idx],
-								 GFP_ATOMIC);
-		if (!priv->rx_ring[rx_queue_idx] ||
-		    (unsigned long)priv->rx_ring[rx_queue_idx] & 0xFF) {
-			netdev_warn(dev, "Cannot allocate RX ring\n");
-			return -ENOMEM;
-		}
-
-		priv->rx_idx[rx_queue_idx] = 0;
+	int i;
+	int rx_queue_idx = 0;
+
+	priv->rx_ring[rx_queue_idx] = dma_alloc_coherent(&priv->pdev->dev,
+							 sizeof(*priv->rx_ring[rx_queue_idx]) * priv->rxringcount,
+							 &priv->rx_ring_dma[rx_queue_idx],
+							 GFP_ATOMIC);
+	if (!priv->rx_ring[rx_queue_idx] ||
+	    (unsigned long)priv->rx_ring[rx_queue_idx] & 0xFF) {
+		netdev_warn(dev, "Cannot allocate RX ring\n");
+		return -ENOMEM;
+	}
 
-		for (i = 0; i < priv->rxringcount; i++) {
-			struct sk_buff *skb = dev_alloc_skb(priv->rxbuffersize);
-			dma_addr_t *mapping;
+	priv->rx_idx[rx_queue_idx] = 0;
 
-			entry = &priv->rx_ring[rx_queue_idx][i];
-			if (!skb)
-				return 0;
-			skb->dev = dev;
-			priv->rx_buf[rx_queue_idx][i] = skb;
-			mapping = (dma_addr_t *)skb->cb;
-			*mapping = dma_map_single(&priv->pdev->dev,
-						  skb_tail_pointer(skb),
-						  priv->rxbuffersize, DMA_FROM_DEVICE);
-			if (dma_mapping_error(&priv->pdev->dev, *mapping)) {
-				dev_kfree_skb_any(skb);
-				return -1;
-			}
-			entry->BufferAddress = *mapping;
+	for (i = 0; i < priv->rxringcount; i++) {
+		struct sk_buff *skb = dev_alloc_skb(priv->rxbuffersize);
+		dma_addr_t *mapping;
 
-			entry->Length = priv->rxbuffersize;
-			entry->OWN = 1;
+		entry = &priv->rx_ring[rx_queue_idx][i];
+		if (!skb)
+			return 0;
+		skb->dev = dev;
+		priv->rx_buf[rx_queue_idx][i] = skb;
+		mapping = (dma_addr_t *)skb->cb;
+		*mapping = dma_map_single(&priv->pdev->dev,
+					  skb_tail_pointer(skb),
+					  priv->rxbuffersize, DMA_FROM_DEVICE);
+		if (dma_mapping_error(&priv->pdev->dev, *mapping)) {
+			dev_kfree_skb_any(skb);
+			return -1;
 		}
+		entry->BufferAddress = *mapping;
 
-		if (entry)
-			entry->EOR = 1;
+		entry->Length = priv->rxbuffersize;
+		entry->OWN = 1;
 	}
+
+	if (entry)
+		entry->EOR = 1;
 	return 0;
 }
 
@@ -1455,19 +1452,18 @@ static short _rtl92e_pci_initdescring(struct net_device *dev)
 void rtl92e_reset_desc_ring(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
-	int i, rx_queue_idx;
+	int i;
+	int rx_queue_idx = 0;
 	unsigned long flags = 0;
 
-	for (rx_queue_idx = 0; rx_queue_idx < MAX_RX_QUEUE; rx_queue_idx++) {
-		if (priv->rx_ring[rx_queue_idx]) {
-			struct rx_desc *entry = NULL;
+	if (priv->rx_ring[rx_queue_idx]) {
+		struct rx_desc *entry = NULL;
 
-			for (i = 0; i < priv->rxringcount; i++) {
-				entry = &priv->rx_ring[rx_queue_idx][i];
-				entry->OWN = 1;
-			}
-			priv->rx_idx[rx_queue_idx] = 0;
+		for (i = 0; i < priv->rxringcount; i++) {
+			entry = &priv->rx_ring[rx_queue_idx][i];
+			entry->OWN = 1;
 		}
+		priv->rx_idx[rx_queue_idx] = 0;
 	}
 
 	spin_lock_irqsave(&priv->irq_th_lock, flags);
-- 
2.42.0

