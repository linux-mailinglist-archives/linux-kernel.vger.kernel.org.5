Return-Path: <linux-kernel+bounces-17786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A5B8252BC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 12:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 584C6B215C7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 11:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF3A2C680;
	Fri,  5 Jan 2024 11:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ndrAdB69"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B0E28E17
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 11:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3367a304091so1148900f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 03:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1704453936; x=1705058736; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9uSeWtY0wnhX9keEMP05THAP/X9456BnCzirYEeQ0zA=;
        b=ndrAdB69AKZ7pUoiKKW4q7o/udQUjErF8rFcq8oYeCRwnv4JBYnWkC3lspajIt8OTT
         5ETO5/iScjket6PsFGGin2uAVp3IpL2DZ7Juii0vmLRQb/E2xu8ZheIi2YMA2Au5o2Ii
         ZBBMAalEiES+dkTMKd/1I1pi5QDY3LEkcZEwBQpqt02Zi3ZxQKIVSfKucNJuN18rpx7/
         Prnc+5ILP+3XdFVNR1PT2yAbxVl3x9G12kjm8AwS+QvCmNFxUwXf0lMMl0igzfPZ1ty6
         JkR045OY0tEPKLpTIe1eI4tVvFxfccjW+vzjmdYhRJfON56pSuhvTSaEADgPzdPNcQeo
         NPVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704453936; x=1705058736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9uSeWtY0wnhX9keEMP05THAP/X9456BnCzirYEeQ0zA=;
        b=Pcl5ruXC4eVY15ECqVqBvy7P+GC0keZeoqC+iETkVLO6VMrpq1dXmFnLvF7PfSzYo5
         HTaO+subhv3HejCVoMrhZ2UJ83NgnnwuNTGCjbz62p5No7k+PEl/hUpku54gLw3KGVr5
         E/QkTmpo1IOZsryqrQzKbQHIiuAK8iFaPhEv9ArzXAMwf7QFA7Zrrf4s5QQThr7yKCwY
         L18Pw32DxpVcEs5pdiWUOajDas9+qlptMsN3W0GYX2bugJgmMNryM5qbUIq/T/HJWGEp
         1ro8r+PH/62zqMrvcZqKmzZCljvaGcNuwSmb8pUWzei1eeOrlxhU0J8Sm87ELBuKrSCU
         2kAw==
X-Gm-Message-State: AOJu0YwTOMvVMamCRco9orF4bp+3u+gEB1LNqO9AhJHtGS4UN2Qcm57K
	cyrGfpsIQ4akGOz8DvkN5OdROm6LXXJvvg==
X-Google-Smtp-Source: AGHT+IHLlmUmzXr2kluK9OzrH9ILjTDJueaA7yDG3ZJ/OUcOWH977e5F1fyfaY2i/If7FjD6BWg00A==
X-Received: by 2002:a5d:4447:0:b0:337:1612:9938 with SMTP id x7-20020a5d4447000000b0033716129938mr791720wrr.107.1704453935818;
        Fri, 05 Jan 2024 03:25:35 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id b1-20020a5d4d81000000b00337405c06a6sm1214823wru.48.2024.01.05.03.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 03:25:35 -0800 (PST)
Date: Fri, 5 Jan 2024 12:25:34 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	"open list:STMMAC ETHERNET DRIVER" <netdev@vger.kernel.org>,
	"moderated list:ARM/STM32 ARCHITECTURE" <linux-stm32@st-md-mailman.stormreply.com>,
	"moderated list:ARM/STM32 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:ARM/Allwinner sunXi SoC support" <linux-sunxi@lists.linux.dev>
Subject: Re: [PATCH] net: stmmac: protect statistics updates with a spinlock
Message-ID: <ZZfnLqvm0TZstOLy@nanopsycho>
References: <20240105091556.15516-1-petr@tesarici.cz>
 <ZZfP0_WHWZ8LFqXX@nanopsycho>
 <20240105112538.319cd522@meshulam.tesarici.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240105112538.319cd522@meshulam.tesarici.cz>

Fri, Jan 05, 2024 at 11:25:38AM CET, petr@tesarici.cz wrote:
>On Fri, 5 Jan 2024 10:45:55 +0100
>Jiri Pirko <jiri@resnulli.us> wrote:
>
>> Fri, Jan 05, 2024 at 10:15:56AM CET, petr@tesarici.cz wrote:
>> >Add a spinlock to fix race conditions while updating Tx/Rx statistics.
>> >
>> >As explained by a comment in <linux/u64_stats_sync.h>, write side of struct
>> >u64_stats_sync must ensure mutual exclusion, or one seqcount update could
>> >be lost on 32-bit platforms, thus blocking readers forever.
>> >
>> >Such lockups have been actually observed on 32-bit Arm after stmmac_xmit()
>> >on one core raced with stmmac_napi_poll_tx() on another core.
>> >
>> >Signed-off-by: Petr Tesarik <petr@tesarici.cz>
>> >---
>> > drivers/net/ethernet/stmicro/stmmac/common.h  |  2 +
>> > .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c |  4 +
>> > .../net/ethernet/stmicro/stmmac/dwmac4_lib.c  |  4 +
>> > .../net/ethernet/stmicro/stmmac/dwmac_lib.c   |  4 +
>> > .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    |  4 +
>> > .../net/ethernet/stmicro/stmmac/stmmac_main.c | 80 +++++++++++++------
>> > 6 files changed, 72 insertions(+), 26 deletions(-)
>> >
>> >diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
>> >index e3f650e88f82..9a17dfc1055d 100644
>> >--- a/drivers/net/ethernet/stmicro/stmmac/common.h
>> >+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
>> >@@ -70,6 +70,7 @@ struct stmmac_txq_stats {
>> > 	u64 tx_tso_frames;
>> > 	u64 tx_tso_nfrags;
>> > 	struct u64_stats_sync syncp;
>> >+	spinlock_t lock;	/* mutual writer exclusion */
>> > } ____cacheline_aligned_in_smp;
>> > 
>> > struct stmmac_rxq_stats {
>> >@@ -79,6 +80,7 @@ struct stmmac_rxq_stats {
>> > 	u64 rx_normal_irq_n;
>> > 	u64 napi_poll;
>> > 	struct u64_stats_sync syncp;
>> >+	spinlock_t lock;	/* mutual writer exclusion */
>> > } ____cacheline_aligned_in_smp;
>> > 
>> > /* Extra statistic and debug information exposed by ethtool */
>> >diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
>> >index 137741b94122..9c568996321d 100644
>> >--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
>> >+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
>> >@@ -455,9 +455,11 @@ static int sun8i_dwmac_dma_interrupt(struct stmmac_priv *priv,
>> > 
>> > 	if (v & EMAC_TX_INT) {
>> > 		ret |= handle_tx;
>> >+		spin_lock(&txq_stats->lock);
>> > 		u64_stats_update_begin(&txq_stats->syncp);
>> > 		txq_stats->tx_normal_irq_n++;
>> > 		u64_stats_update_end(&txq_stats->syncp);
>> >+		spin_unlock(&txq_stats->lock);
>> > 	}
>> > 
>> > 	if (v & EMAC_TX_DMA_STOP_INT)
>> >@@ -479,9 +481,11 @@ static int sun8i_dwmac_dma_interrupt(struct stmmac_priv *priv,
>> > 
>> > 	if (v & EMAC_RX_INT) {
>> > 		ret |= handle_rx;
>> >+		spin_lock(&rxq_stats->lock);
>> > 		u64_stats_update_begin(&rxq_stats->syncp);
>> > 		rxq_stats->rx_normal_irq_n++;
>> > 		u64_stats_update_end(&rxq_stats->syncp);
>> >+		spin_unlock(&rxq_stats->lock);
>> > 	}
>> > 
>> > 	if (v & EMAC_RX_BUF_UA_INT)
>> >diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
>> >index 9470d3fd2ded..e50e8b07724b 100644
>> >--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
>> >+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
>> >@@ -201,15 +201,19 @@ int dwmac4_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
>> > 	}
>> > 	/* TX/RX NORMAL interrupts */
>> > 	if (likely(intr_status & DMA_CHAN_STATUS_RI)) {
>> >+		spin_lock(&rxq_stats->lock);
>> > 		u64_stats_update_begin(&rxq_stats->syncp);
>> > 		rxq_stats->rx_normal_irq_n++;
>> > 		u64_stats_update_end(&rxq_stats->syncp);
>> >+		spin_unlock(&rxq_stats->lock);
>> > 		ret |= handle_rx;
>> > 	}
>> > 	if (likely(intr_status & DMA_CHAN_STATUS_TI)) {
>> >+		spin_lock(&txq_stats->lock);
>> > 		u64_stats_update_begin(&txq_stats->syncp);
>> > 		txq_stats->tx_normal_irq_n++;
>> > 		u64_stats_update_end(&txq_stats->syncp);
>> >+		spin_unlock(&txq_stats->lock);
>> > 		ret |= handle_tx;
>> > 	}
>> > 
>> >diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
>> >index 7907d62d3437..a43396a7f852 100644
>> >--- a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
>> >+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
>> >@@ -215,16 +215,20 @@ int dwmac_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
>> > 			u32 value = readl(ioaddr + DMA_INTR_ENA);
>> > 			/* to schedule NAPI on real RIE event. */
>> > 			if (likely(value & DMA_INTR_ENA_RIE)) {
>> >+				spin_lock(&rxq_stats->lock);
>> > 				u64_stats_update_begin(&rxq_stats->syncp);
>> > 				rxq_stats->rx_normal_irq_n++;
>> > 				u64_stats_update_end(&rxq_stats->syncp);
>> >+				spin_unlock(&rxq_stats->lock);
>> > 				ret |= handle_rx;
>> > 			}
>> > 		}
>> > 		if (likely(intr_status & DMA_STATUS_TI)) {
>> >+			spin_lock(&txq_stats->lock);
>> > 			u64_stats_update_begin(&txq_stats->syncp);
>> > 			txq_stats->tx_normal_irq_n++;
>> > 			u64_stats_update_end(&txq_stats->syncp);
>> >+			spin_unlock(&txq_stats->lock);
>> > 			ret |= handle_tx;
>> > 		}
>> > 		if (unlikely(intr_status & DMA_STATUS_ERI))
>> >diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
>> >index 3cde695fec91..f4e01436d4cc 100644
>> >--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
>> >+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
>> >@@ -367,15 +367,19 @@ static int dwxgmac2_dma_interrupt(struct stmmac_priv *priv,
>> > 	/* TX/RX NORMAL interrupts */
>> > 	if (likely(intr_status & XGMAC_NIS)) {
>> > 		if (likely(intr_status & XGMAC_RI)) {
>> >+			spin_lock(&rxq_stats->lock);
>> > 			u64_stats_update_begin(&rxq_stats->syncp);
>> > 			rxq_stats->rx_normal_irq_n++;
>> > 			u64_stats_update_end(&rxq_stats->syncp);
>> >+			spin_unlock(&rxq_stats->lock);
>> > 			ret |= handle_rx;
>> > 		}
>> > 		if (likely(intr_status & (XGMAC_TI | XGMAC_TBU))) {
>> >+			spin_lock(&txq_stats->lock);
>> > 			u64_stats_update_begin(&txq_stats->syncp);
>> > 			txq_stats->tx_normal_irq_n++;
>> > 			u64_stats_update_end(&txq_stats->syncp);
>> >+			spin_unlock(&txq_stats->lock);
>> > 			ret |= handle_tx;
>> > 		}
>> > 	}
>> >diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> >index 37e64283f910..82d8db04d0d1 100644
>> >--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> >+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> >@@ -2515,9 +2515,11 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
>> > 		tx_q->cur_tx = STMMAC_GET_ENTRY(tx_q->cur_tx, priv->dma_conf.dma_tx_size);
>> > 		entry = tx_q->cur_tx;
>> > 	}
>> >-	flags = u64_stats_update_begin_irqsave(&txq_stats->syncp);
>> >+	spin_lock_irqsave(&txq_stats->lock, flags);
>> >+	u64_stats_update_begin(&txq_stats->syncp);
>> > 	txq_stats->tx_set_ic_bit += tx_set_ic_bit;
>> >-	u64_stats_update_end_irqrestore(&txq_stats->syncp, flags);
>> >+	u64_stats_update_end(&txq_stats->syncp);
>> >+	spin_unlock_irqrestore(&txq_stats->lock, flags);
>> > 
>> > 	if (tx_desc) {
>> > 		stmmac_flush_tx_descriptors(priv, queue);
>> >@@ -2721,11 +2723,13 @@ static int stmmac_tx_clean(struct stmmac_priv *priv, int budget, u32 queue,
>> > 	if (tx_q->dirty_tx != tx_q->cur_tx)
>> > 		*pending_packets = true;
>> > 
>> >-	flags = u64_stats_update_begin_irqsave(&txq_stats->syncp);
>> >+	spin_lock_irqsave(&txq_stats->lock, flags);
>> >+	u64_stats_update_begin(&txq_stats->syncp);
>> > 	txq_stats->tx_packets += tx_packets;
>> > 	txq_stats->tx_pkt_n += tx_packets;
>> > 	txq_stats->tx_clean++;
>> >-	u64_stats_update_end_irqrestore(&txq_stats->syncp, flags);
>> >+	u64_stats_update_end(&txq_stats->syncp);
>> >+	spin_unlock_irqrestore(&txq_stats->lock, flags);
>> > 
>> > 	priv->xstats.tx_errors += tx_errors;
>> > 
>> >@@ -4311,13 +4315,15 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
>> > 		netif_tx_stop_queue(netdev_get_tx_queue(priv->dev, queue));
>> > 	}
>> > 
>> >-	flags = u64_stats_update_begin_irqsave(&txq_stats->syncp);
>> >+	spin_lock_irqsave(&txq_stats->lock, flags);
>> >+	u64_stats_update_begin(&txq_stats->syncp);
>> > 	txq_stats->tx_bytes += skb->len;
>> > 	txq_stats->tx_tso_frames++;
>> > 	txq_stats->tx_tso_nfrags += nfrags;
>> > 	if (set_ic)
>> > 		txq_stats->tx_set_ic_bit++;
>> >-	u64_stats_update_end_irqrestore(&txq_stats->syncp, flags);
>> >+	u64_stats_update_end(&txq_stats->syncp);
>> >+	spin_unlock_irqrestore(&txq_stats->lock, flags);
>> > 
>> > 	if (priv->sarc_type)
>> > 		stmmac_set_desc_sarc(priv, first, priv->sarc_type);
>> >@@ -4560,11 +4566,13 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
>> > 		netif_tx_stop_queue(netdev_get_tx_queue(priv->dev, queue));
>> > 	}
>> > 
>> >-	flags = u64_stats_update_begin_irqsave(&txq_stats->syncp);
>> >+	spin_lock_irqsave(&txq_stats->lock, flags);
>> >+	u64_stats_update_begin(&txq_stats->syncp);
>> > 	txq_stats->tx_bytes += skb->len;
>> > 	if (set_ic)
>> > 		txq_stats->tx_set_ic_bit++;
>> >-	u64_stats_update_end_irqrestore(&txq_stats->syncp, flags);
>> >+	u64_stats_update_end(&txq_stats->syncp);
>> >+	spin_unlock_irqrestore(&txq_stats->lock, flags);
>> > 
>> > 	if (priv->sarc_type)
>> > 		stmmac_set_desc_sarc(priv, first, priv->sarc_type);
>> >@@ -4831,9 +4839,11 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
>> > 		unsigned long flags;
>> > 		tx_q->tx_count_frames = 0;
>> > 		stmmac_set_tx_ic(priv, tx_desc);
>> >-		flags = u64_stats_update_begin_irqsave(&txq_stats->syncp);
>> >+		spin_lock_irqsave(&txq_stats->lock, flags);
>> >+		u64_stats_update_begin(&txq_stats->syncp);
>> > 		txq_stats->tx_set_ic_bit++;
>> >-		u64_stats_update_end_irqrestore(&txq_stats->syncp, flags);
>> >+		u64_stats_update_end(&txq_stats->syncp);
>> >+		spin_unlock_irqrestore(&txq_stats->lock, flags);
>> > 	}
>> > 
>> > 	stmmac_enable_dma_transmission(priv, priv->ioaddr);
>> >@@ -5008,10 +5018,12 @@ static void stmmac_dispatch_skb_zc(struct stmmac_priv *priv, u32 queue,
>> > 	skb_record_rx_queue(skb, queue);
>> > 	napi_gro_receive(&ch->rxtx_napi, skb);
>> > 
>> >-	flags = u64_stats_update_begin_irqsave(&rxq_stats->syncp);
>> >+	spin_lock_irqsave(&rxq_stats->lock, flags);
>> >+	u64_stats_update_begin(&rxq_stats->syncp);
>> > 	rxq_stats->rx_pkt_n++;
>> > 	rxq_stats->rx_bytes += len;
>> >-	u64_stats_update_end_irqrestore(&rxq_stats->syncp, flags);
>> >+	u64_stats_update_end(&rxq_stats->syncp);
>> >+	spin_unlock_irqrestore(&rxq_stats->lock, flags);
>> > }
>> > 
>> > static bool stmmac_rx_refill_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
>> >@@ -5248,9 +5260,11 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
>> > 
>> > 	stmmac_finalize_xdp_rx(priv, xdp_status);
>> > 
>> >-	flags = u64_stats_update_begin_irqsave(&rxq_stats->syncp);
>> >+	spin_lock_irqsave(&rxq_stats->lock, flags);
>> >+	u64_stats_update_begin(&rxq_stats->syncp);
>> > 	rxq_stats->rx_pkt_n += count;
>> >-	u64_stats_update_end_irqrestore(&rxq_stats->syncp, flags);
>> >+	u64_stats_update_end(&rxq_stats->syncp);
>> >+	spin_unlock_irqrestore(&rxq_stats->lock, flags);
>> > 
>> > 	priv->xstats.rx_dropped += rx_dropped;
>> > 	priv->xstats.rx_errors += rx_errors;
>> >@@ -5541,11 +5555,13 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
>> > 
>> > 	stmmac_rx_refill(priv, queue);
>> > 
>> >-	flags = u64_stats_update_begin_irqsave(&rxq_stats->syncp);
>> >+	spin_lock_irqsave(&rxq_stats->lock, flags);
>> >+	u64_stats_update_begin(&rxq_stats->syncp);
>> > 	rxq_stats->rx_packets += rx_packets;
>> > 	rxq_stats->rx_bytes += rx_bytes;
>> > 	rxq_stats->rx_pkt_n += count;
>> >-	u64_stats_update_end_irqrestore(&rxq_stats->syncp, flags);
>> >+	u64_stats_update_end(&rxq_stats->syncp);
>> >+	spin_unlock_irqrestore(&rxq_stats->lock, flags);
>> > 
>> > 	priv->xstats.rx_dropped += rx_dropped;
>> > 	priv->xstats.rx_errors += rx_errors;
>> >@@ -5564,9 +5580,11 @@ static int stmmac_napi_poll_rx(struct napi_struct *napi, int budget)
>> > 	int work_done;
>> > 
>> > 	rxq_stats = &priv->xstats.rxq_stats[chan];
>> >-	flags = u64_stats_update_begin_irqsave(&rxq_stats->syncp);
>> >+	spin_lock_irqsave(&rxq_stats->lock, flags);
>> >+	u64_stats_update_begin(&rxq_stats->syncp);
>> > 	rxq_stats->napi_poll++;
>> >-	u64_stats_update_end_irqrestore(&rxq_stats->syncp, flags);
>> >+	u64_stats_update_end(&rxq_stats->syncp);
>> >+	spin_unlock_irqrestore(&rxq_stats->lock, flags);
>> > 
>> > 	work_done = stmmac_rx(priv, budget, chan);
>> > 	if (work_done < budget && napi_complete_done(napi, work_done)) {
>> >@@ -5592,9 +5610,11 @@ static int stmmac_napi_poll_tx(struct napi_struct *napi, int budget)
>> > 	int work_done;
>> > 
>> > 	txq_stats = &priv->xstats.txq_stats[chan];
>> >-	flags = u64_stats_update_begin_irqsave(&txq_stats->syncp);
>> >+	spin_lock_irqsave(&txq_stats->lock, flags);
>> >+	u64_stats_update_begin(&txq_stats->syncp);
>> > 	txq_stats->napi_poll++;
>> >-	u64_stats_update_end_irqrestore(&txq_stats->syncp, flags);
>> >+	u64_stats_update_end(&txq_stats->syncp);
>> >+	spin_unlock_irqrestore(&txq_stats->lock, flags);
>> > 
>> > 	work_done = stmmac_tx_clean(priv, budget, chan, &pending_packets);
>> > 	work_done = min(work_done, budget);
>> >@@ -5627,14 +5647,18 @@ static int stmmac_napi_poll_rxtx(struct napi_struct *napi, int budget)
>> > 	unsigned long flags;
>> > 
>> > 	rxq_stats = &priv->xstats.rxq_stats[chan];
>> >-	flags = u64_stats_update_begin_irqsave(&rxq_stats->syncp);
>> >+	spin_lock_irqsave(&rxq_stats->lock, flags);
>> >+	u64_stats_update_begin(&rxq_stats->syncp);
>> > 	rxq_stats->napi_poll++;
>> >-	u64_stats_update_end_irqrestore(&rxq_stats->syncp, flags);
>> >+	u64_stats_update_end(&rxq_stats->syncp);
>> >+	spin_unlock(&rxq_stats->lock);  
>> 
>> Nitpick:
>> I know that the original code does that, but any idea why
>> u64_stats_update_end_irqrestore() is called here when
>> u64_stats_update_begin_irqsave() is called 2 lines below?
>> IIUC, this could be one critical section. Could you perhaps merge these
>> while at it? Could be a follow-up patch.
>
>I have merged the interrupt disable/enable, but there are two separate
>spinlocks for rxq_stats (added to struct stmmac_txq_stats) and for
>txq_stats (added to struct stmmac_rxq_stats), so they cannot be merged.

Ah, that's what I overlooked. Thanks.

>
>Alternatively, I could use the channel lock to protect stats updates,
>but that could increase contention of that lock. I believe more
>granularity is better, especially if it does not cost anything: There
>is plenty of unused space in struct stmmac_txq_stats and struct
>stmmac_rxq_stats (they are both cache-aligned).
>
>Petr T
>
>> 
>> Rest of the patch looks fine to me.
>> 
>> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>> 
>> 
>> > 
>> > 	txq_stats = &priv->xstats.txq_stats[chan];
>> >-	flags = u64_stats_update_begin_irqsave(&txq_stats->syncp);
>> >+	spin_lock(&txq_stats->lock);
>> >+	u64_stats_update_begin(&txq_stats->syncp);
>> > 	txq_stats->napi_poll++;
>> >-	u64_stats_update_end_irqrestore(&txq_stats->syncp, flags);
>> >+	u64_stats_update_end(&txq_stats->syncp);
>> >+	spin_unlock_irqrestore(&txq_stats->lock, flags);
>> > 
>> > 	tx_done = stmmac_tx_clean(priv, budget, chan, &tx_pending_packets);
>> > 	tx_done = min(tx_done, budget);
>> >@@ -7371,10 +7395,14 @@ int stmmac_dvr_probe(struct device *device,
>> > 	priv->device = device;
>> > 	priv->dev = ndev;
>> > 
>> >-	for (i = 0; i < MTL_MAX_RX_QUEUES; i++)
>> >+	for (i = 0; i < MTL_MAX_RX_QUEUES; i++) {
>> > 		u64_stats_init(&priv->xstats.rxq_stats[i].syncp);
>> >-	for (i = 0; i < MTL_MAX_TX_QUEUES; i++)
>> >+		spin_lock_init(&priv->xstats.rxq_stats[i].lock);
>> >+	}
>> >+	for (i = 0; i < MTL_MAX_TX_QUEUES; i++) {
>> > 		u64_stats_init(&priv->xstats.txq_stats[i].syncp);
>> >+		spin_lock_init(&priv->xstats.txq_stats[i].lock);
>> >+	}
>> > 
>> > 	stmmac_set_ethtool_ops(ndev);
>> > 	priv->pause = pause;
>> >-- 
>> >2.43.0
>> >
>> >  
>

