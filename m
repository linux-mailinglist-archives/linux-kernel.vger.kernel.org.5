Return-Path: <linux-kernel+bounces-60413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F05C85048F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 14:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BBF5283781
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 13:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B87753E05;
	Sat, 10 Feb 2024 13:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/LOb8fd"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3387A18030;
	Sat, 10 Feb 2024 13:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707573421; cv=none; b=Q9mfdXmBGbcRRcCxakpoKKttjoION6F4q5f2R7HaUmd8Vfp7CjSTswgblhfJgo5+uQMJDKXhiAoHzbLirt50YsTwZdXBORhbIhrXJCNDPptZgQ/18sfQkWWdZC+Y36fBHz3CH3L7+Jv7LQ3zrfnuP2ETwbLgmcMrZmFPYo2+Sbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707573421; c=relaxed/simple;
	bh=J5gGJEiIqMol4yIrOUFaU9U5R4nSp1pWKYYg0o8rrws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fvV1dXFoGJiC+u08gCCpUchsTcZrBNmk4DGjixjvG45WVuQy+umIeTOnRmFRtLODKp9QyGqjqZFZMWHjV/l5Ni8/wJCwXH8aj+Sd4RDqg350Mo+7ZpcsWAAOI8w/ZUQR1xYBOtx4FA2MNRi+C1BzYkQkF4PAoT8MBa+XnzSuqcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L/LOb8fd; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51147d0abd1so2067521e87.1;
        Sat, 10 Feb 2024 05:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707573417; x=1708178217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9fhWtYpfymANfot3JqjSdnuIUdsO9jeTpicjwmlALWY=;
        b=L/LOb8fdYj9R8MISazwO19XxdQaT/Bv6MOP+KOsSSSykNcu4VLNZ2i1C7vGjP1qlZ8
         0rzklMi+mNuMitQqVeP6GMt3AciFnEd3K0XvKrxdott+yd9aqoibNLA5SqwTNShFFp8a
         BG0FLZ/t7tQljzIcfCNqZSQFP8NYIIgKMja5N1I1Wuc8942MNwoT5ILOyUNH4JjhyabQ
         JASE6gle0nHjtfHElMYi2fd78iKdqUPbOHyppviYhSx277MMgxOJ1DVxYj1JkM/+bYHz
         ecKW+W5mkGFt2HWGPsrO2rZnmcv37FTzJwMe9Bqp4ZLdUSw+7V8nWgJsk0SFds00xi83
         kCww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707573417; x=1708178217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9fhWtYpfymANfot3JqjSdnuIUdsO9jeTpicjwmlALWY=;
        b=YrrpwXM563kYlSaZdSTn4kp8UigR2jyKbAjByfEQts5dA12asxt+PnIo41g5WG5F1v
         zj0cyXXVqXsGD+wgcVqhnZqGzzQgUWmSJamtSzTPC9aLVmqSA2kJZXpU9bme6b8Ixzqt
         61rT2B6BU3Ew3UFnDPRxSxG4CYnKj5xPzHj4HkRAmTkJohV+yISzfwoCnSR1fnZcUbRH
         /O/7EKWQb6INydO4AswTk/Xo+tJM0tDyfkR6cnPaLpThIomE1o43FRBjv+booP0xsR9o
         BbYJZwULyNku2p+vLGAuTW4I8N+GaCJp2B7UcvNQ92aRLBabtWYtXI2Rs7PVLdSS6D27
         s6pQ==
X-Forwarded-Encrypted: i=1; AJvYcCUY2dftdbkS3CMdTUgxGsoGn7Ly/OwQZznzubY4FoxHKqNTwV/Wg+rdyGn0xs6ETw7+An5l6TB1V/hOnoViEHPixPSGSANzAFh7D27zDZ2Yye33JxnEcgZv2rXYKGE6JIdzIQex
X-Gm-Message-State: AOJu0Yw3TlNBSdpST6L/c2tEyr46nWGCfjAr7Ux7tIbc8mY8TfsWvRBO
	s+CAQA1NznEpIMsZP07HAdTe2E+4GdK0kOuei1unajEnD8h6ouk7
X-Google-Smtp-Source: AGHT+IGRC3cIJc/7R2MEgtLFrXKsS3qw5bXtGPio0PSjgExpduspr3MJ25f4nBrFpFhtgLrQc8bEKg==
X-Received: by 2002:ac2:47e3:0:b0:511:42b5:5616 with SMTP id b3-20020ac247e3000000b0051142b55616mr1200169lfp.17.1707573416892;
        Sat, 10 Feb 2024 05:56:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUk4JjOxxVWxaUjQ4JegCIbWsSOYu7te2bY2+ieTviyZT/g2YTEUxmbyY/1BhABNj2Jf25CjqpJqNSsd+Xg4a6WHWNhXBENQb/HEOCBTzMneGAkwyUvyG2RBVM4Ai1JGZHYZ+yHIseWYWIgDF/Je3U7xopeJVZ5exEI8lMp26Mve8AwfJM5qH1XnLdTO9JMEvNZqvsUJv97KeodfAhkXL7+J1TzEFZQzxOGboPLkZVr4hoWnizb1q0Dl0BhA8BosfclGue8cpPTgTb+7uKEZfL2v96Q/9GkCIoR0DxWkRHhFpNK6qubREt/EUqt6k1Un7MrAwDcZWF22YgZpDvDOB9zWJ3Bc63cgxN4G//qnKODS7a2x03dtIXq6yaVuSbJzXD2KNz+PgwTPk/Uq3A72GJQR+qcSgUSe8JFd/YXQ+IQSO5iJZ8AYvNAggOn+36UqSFcL7emqEs3tm4+l3r64y5FruwFMRBZlQoxaywK0PUW0mcAciMpKxLk5Hy8UfiGA6UkkQHMPeM7KOU50r7ci5eUCFsgljQFo0pX4jmVISHLm9Uenm1mcRH0
Received: from localhost.localdomain ([176.230.105.209])
        by smtp.gmail.com with ESMTPSA id w16-20020a05651234d000b005117502e3bbsm246300lfr.300.2024.02.10.05.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 05:56:56 -0800 (PST)
From: Elad Yifee <eladwf@gmail.com>
To: 
Cc: eladwf@gmail.com,
	Felix Fietkau <nbd@nbd.name>,
	Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next v3] net: ethernet: mtk_eth_soc: ppe: add support for multiple PPEs
Date: Sat, 10 Feb 2024 15:56:07 +0200
Message-ID: <20240210135620.28368-1-eladwf@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <Zcdtb-eyvxzX9yPe@makrotopia.org>
References: <Zcdtb-eyvxzX9yPe@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the missing pieces to allow multiple PPEs units, one for each GMAC.
mtk_gdm_config has been modified to work on targted mac ID,
the inner loop moved outside of the function to allow unrelated
operations like setting the MAC's PPE index.

Signed-off-by: Elad Yifee <eladwf@gmail.com>
---
v3: applied changes suggested by Daniel Golle
v2: fixed CI warnings
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c   | 86 +++++++++++--------
 drivers/net/ethernet/mediatek/mtk_eth_soc.h   | 15 +++-
 .../net/ethernet/mediatek/mtk_ppe_offload.c   |  6 +-
 3 files changed, 68 insertions(+), 39 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index a6e91573f8da..5d5cf73a5d5a 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -2010,6 +2010,7 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
 	struct mtk_rx_dma_v2 *rxd, trxd;
 	int done = 0, bytes = 0;
 	dma_addr_t dma_addr = DMA_MAPPING_ERROR;
+	u8 ppe_index = 0;
 
 	while (done < budget) {
 		unsigned int pktlen, *rxdcsum;
@@ -2053,6 +2054,7 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
 			goto release_desc;
 
 		netdev = eth->netdev[mac];
+		ppe_index = eth->mac[mac]->ppe_idx;
 
 		if (unlikely(test_bit(MTK_RESETTING, &eth->state)))
 			goto release_desc;
@@ -2176,7 +2178,7 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
 		}
 
 		if (reason == MTK_PPE_CPU_REASON_HIT_UNBIND_RATE_REACHED)
-			mtk_ppe_check_skb(eth->ppe[0], skb, hash);
+			mtk_ppe_check_skb(eth->ppe[ppe_index], skb, hash);
 
 		skb_record_rx_queue(skb, 0);
 		napi_gro_receive(napi, skb);
@@ -3267,37 +3269,27 @@ static int mtk_start_dma(struct mtk_eth *eth)
 	return 0;
 }
 
-static void mtk_gdm_config(struct mtk_eth *eth, u32 config)
+static void mtk_gdm_config(struct mtk_eth *eth, u32 id, u32 config)
 {
-	int i;
+	u32 val;
 
 	if (MTK_HAS_CAPS(eth->soc->caps, MTK_SOC_MT7628))
 		return;
 
-	for (i = 0; i < MTK_MAX_DEVS; i++) {
-		u32 val;
-
-		if (!eth->netdev[i])
-			continue;
-
-		val = mtk_r32(eth, MTK_GDMA_FWD_CFG(i));
+	val = mtk_r32(eth, MTK_GDMA_FWD_CFG(id));
 
-		/* default setup the forward port to send frame to PDMA */
-		val &= ~0xffff;
+	/* default setup the forward port to send frame to PDMA */
+	val &= ~0xffff;
 
-		/* Enable RX checksum */
-		val |= MTK_GDMA_ICS_EN | MTK_GDMA_TCS_EN | MTK_GDMA_UCS_EN;
+	/* Enable RX checksum */
+	val |= MTK_GDMA_ICS_EN | MTK_GDMA_TCS_EN | MTK_GDMA_UCS_EN;
 
-		val |= config;
+	val |= config;
 
-		if (netdev_uses_dsa(eth->netdev[i]))
-			val |= MTK_GDMA_SPECIAL_TAG;
+	if (eth->netdev[id] && netdev_uses_dsa(eth->netdev[id]))
+		val |= MTK_GDMA_SPECIAL_TAG;
 
-		mtk_w32(eth, val, MTK_GDMA_FWD_CFG(i));
-	}
-	/* Reset and enable PSE */
-	mtk_w32(eth, RST_GL_PSE, MTK_RST_GL);
-	mtk_w32(eth, 0, MTK_RST_GL);
+	mtk_w32(eth, val, MTK_GDMA_FWD_CFG(id));
 }
 
 
@@ -3358,6 +3350,8 @@ static int mtk_open(struct net_device *dev)
 	struct mtk_mac *mac = netdev_priv(dev);
 	struct mtk_eth *eth = mac->hw;
 	int i, err;
+	struct mtk_mac *target_mac;
+	const u8 ppe_num = mtk_get_ppe_num(eth);
 
 	err = phylink_of_phy_connect(mac->phylink, mac->of_node, 0);
 	if (err) {
@@ -3381,18 +3375,38 @@ static int mtk_open(struct net_device *dev)
 		for (i = 0; i < ARRAY_SIZE(eth->ppe); i++)
 			mtk_ppe_start(eth->ppe[i]);
 
-		gdm_config = soc->offload_version ? soc->reg_map->gdma_to_ppe
-						  : MTK_GDMA_TO_PDMA;
-		mtk_gdm_config(eth, gdm_config);
+		for (i = 0; i < MTK_MAX_DEVS; i++) {
+			if (!eth->netdev[i])
+				break;
+
+			target_mac = netdev_priv(eth->netdev[i]);
+			if (!soc->offload_version) {
+				target_mac->ppe_idx = 0;
+				gdm_config = MTK_GDMA_TO_PDMA;
+			} else if (ppe_num >= 3 && target_mac->id == 2) {
+				target_mac->ppe_idx = 2;
+				gdm_config = MTK_GDMA_TO_PPE2;
+			} else if (ppe_num >= 2 && target_mac->id == 1) {
+				target_mac->ppe_idx = 1;
+				gdm_config = MTK_GDMA_TO_PPE1;
+			} else {
+				target_mac->ppe_idx = 0;
+				gdm_config = soc->reg_map->gdma_to_ppe;
+			}
+			mtk_gdm_config(eth, target_mac->id, gdm_config);
+		}
+		/* Reset and enable PSE */
+		mtk_w32(eth, RST_GL_PSE, MTK_RST_GL);
+		mtk_w32(eth, 0, MTK_RST_GL);
 
 		napi_enable(&eth->tx_napi);
 		napi_enable(&eth->rx_napi);
 		mtk_tx_irq_enable(eth, MTK_TX_DONE_INT);
 		mtk_rx_irq_enable(eth, soc->txrx.rx_irq_done_mask);
 		refcount_set(&eth->dma_refcnt, 1);
-	}
-	else
+	} else {
 		refcount_inc(&eth->dma_refcnt);
+	}
 
 	phylink_start(mac->phylink);
 	netif_tx_start_all_queues(dev);
@@ -3469,7 +3483,8 @@ static int mtk_stop(struct net_device *dev)
 	if (!refcount_dec_and_test(&eth->dma_refcnt))
 		return 0;
 
-	mtk_gdm_config(eth, MTK_GDMA_DROP_ALL);
+	for (i = 0; i < MTK_MAX_DEVS; i++)
+		mtk_gdm_config(eth, i, MTK_GDMA_DROP_ALL);
 
 	mtk_tx_irq_disable(eth, MTK_TX_DONE_INT);
 	mtk_rx_irq_disable(eth, eth->soc->txrx.rx_irq_done_mask);
@@ -4945,23 +4960,24 @@ static int mtk_probe(struct platform_device *pdev)
 	}
 
 	if (eth->soc->offload_version) {
-		u32 num_ppe = mtk_is_netsys_v2_or_greater(eth) ? 2 : 1;
+		u8 num_ppe = mtk_get_ppe_num(eth);
 
-		num_ppe = min_t(u32, ARRAY_SIZE(eth->ppe), num_ppe);
+		num_ppe = min_t(u8, ARRAY_SIZE(eth->ppe), num_ppe);
 		for (i = 0; i < num_ppe; i++) {
-			u32 ppe_addr = eth->soc->reg_map->ppe_base + i * 0x400;
+			u32 ppe_addr = eth->soc->reg_map->ppe_base;
 
+			ppe_addr += (i == 2 ? 0xc00 : i * 0x400);
 			eth->ppe[i] = mtk_ppe_init(eth, eth->base + ppe_addr, i);
 
 			if (!eth->ppe[i]) {
 				err = -ENOMEM;
 				goto err_deinit_ppe;
 			}
-		}
+			err = mtk_eth_offload_init(eth, i);
 
-		err = mtk_eth_offload_init(eth);
-		if (err)
-			goto err_deinit_ppe;
+			if (err)
+				goto err_deinit_ppe;
+		}
 	}
 
 	for (i = 0; i < MTK_MAX_DEVS; i++) {
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
index 9ae3b8a71d0e..9ff0d6951688 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.h
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
@@ -124,6 +124,8 @@
 #define MTK_GDMA_UCS_EN		BIT(20)
 #define MTK_GDMA_STRP_CRC	BIT(16)
 #define MTK_GDMA_TO_PDMA	0x0
+#define MTK_GDMA_TO_PPE1	0x4444
+#define MTK_GDMA_TO_PPE2	0xcccc
 #define MTK_GDMA_DROP_ALL       0x7777
 
 /* GDM Egress Control Register */
@@ -1286,7 +1288,7 @@ struct mtk_eth {
 
 	struct metadata_dst		*dsa_meta[MTK_MAX_DSA_PORTS];
 
-	struct mtk_ppe			*ppe[2];
+	struct mtk_ppe			*ppe[3];
 	struct rhashtable		flow_table;
 
 	struct bpf_prog			__rcu *prog;
@@ -1311,6 +1313,7 @@ struct mtk_eth {
 struct mtk_mac {
 	int				id;
 	phy_interface_t			interface;
+	u8			ppe_idx;
 	int				speed;
 	struct device_node		*of_node;
 	struct phylink			*phylink;
@@ -1421,6 +1424,14 @@ static inline u32 mtk_get_ib2_multicast_mask(struct mtk_eth *eth)
 	return MTK_FOE_IB2_MULTICAST;
 }
 
+static inline u8 mtk_get_ppe_num(struct mtk_eth *eth)
+{
+	if (!eth->soc->offload_version)
+		return 0;
+
+	return eth->soc->version;
+}
+
 /* read the hardware status register */
 void mtk_stats_update_mac(struct mtk_mac *mac);
 
@@ -1432,7 +1443,7 @@ int mtk_gmac_sgmii_path_setup(struct mtk_eth *eth, int mac_id);
 int mtk_gmac_gephy_path_setup(struct mtk_eth *eth, int mac_id);
 int mtk_gmac_rgmii_path_setup(struct mtk_eth *eth, int mac_id);
 
-int mtk_eth_offload_init(struct mtk_eth *eth);
+int mtk_eth_offload_init(struct mtk_eth *eth, u8 id);
 int mtk_eth_setup_tc(struct net_device *dev, enum tc_setup_type type,
 		     void *type_data);
 int mtk_flow_offload_cmd(struct mtk_eth *eth, struct flow_cls_offload *cls,
diff --git a/drivers/net/ethernet/mediatek/mtk_ppe_offload.c b/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
index fbb5e9d5af13..1079c20bc049 100644
--- a/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
+++ b/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
@@ -570,7 +570,7 @@ mtk_eth_setup_tc_block_cb(enum tc_setup_type type, void *type_data, void *cb_pri
 	if (type != TC_SETUP_CLSFLOWER)
 		return -EOPNOTSUPP;
 
-	return mtk_flow_offload_cmd(eth, cls, 0);
+	return mtk_flow_offload_cmd(eth, cls, mac->ppe_idx);
 }
 
 static int
@@ -633,7 +633,9 @@ int mtk_eth_setup_tc(struct net_device *dev, enum tc_setup_type type,
 	}
 }
 
-int mtk_eth_offload_init(struct mtk_eth *eth)
+int mtk_eth_offload_init(struct mtk_eth *eth, u8 id)
 {
+	if (!eth->ppe[id] || !eth->ppe[id]->foe_table)
+		return 0;
 	return rhashtable_init(&eth->flow_table, &mtk_flow_ht_params);
 }
-- 
2.43.0


