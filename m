Return-Path: <linux-kernel+bounces-44902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9858428DA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D80D728A1FE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455CB86AD2;
	Tue, 30 Jan 2024 16:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZ3HiJGH"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6157B86AC9;
	Tue, 30 Jan 2024 16:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706630974; cv=none; b=GhWXYTULUWKdBgy1RGHqF04cQ5DzaKtVWEivUERl+RyutidNTqgAnEBLulRPaG9t1qehPlN4ROsfjMCmv3Dgd5qqk257JfVyyXWsM8uojuq2qp8ovlUgkulpb8uwKyO50KakD31SLJBJoJ4N9EBQqjBzcyQa/j+mih0IctI8PhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706630974; c=relaxed/simple;
	bh=qgYFI1B3Pdjuc0Arvki6y0tzVdOLmU/7dKfsCaUoa8s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RYvLHS7+YJGhvmxAfvVXShyDXSUxO1mhPw9ESXOMv4zm6ZjRSOxMHYaLfIQolVyo33E6xbGePefJzWYgQ+PiZrGaXp6SkKE6dSpSHobRYGkJ/jJ9zVkHAOv27/uNYjwRILMsLFfqNXm55Jabekr4tNPhVznMSj76l63CCteX0iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WZ3HiJGH; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40e5afc18f5so44468655e9.3;
        Tue, 30 Jan 2024 08:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706630970; x=1707235770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uGdpIQ3h7USVCYzxg0c4UgIyLi+Uz0SXFUiMKfQCYHM=;
        b=WZ3HiJGHn3sV636PVkLzFmjmblg9Bg5NCuzbo7vpvlSWMLj0S9mbLV+v1cpRa4IDNX
         EJDjjD3fOY8Wajh3S21ZH1Ne0uDjOd2nN043OB6TwI2w8UBhEOfN/KbIHrN7NSgf5AVD
         0V9RJzW/KSRsX0WZTYs7qghkPXcElZTUTI0ZFvw7TDH0Wv2SpaF5mvZRR4MZ4YSkSUF0
         QbN6Iybuca4Z971cU7QHLWC7rh9bDZfXozAg9GZZRQS6x3RwysUT6Slcv7QBJueAdnev
         YvUn2RqXe6Uvfm45xF2QBX8ZJ/EfR0mDg4viBUYW8eUxVm1bkZvBDG1gtZUn7YIoyxR/
         QtxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706630970; x=1707235770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uGdpIQ3h7USVCYzxg0c4UgIyLi+Uz0SXFUiMKfQCYHM=;
        b=gcJ8jLAeZEO45pT39ZpjZV138I+0SeddEZWrBYPR6jPksy+T/wtISJJb8/+WGPtqvZ
         2khDCu3LFFrh5DSVdyKkkXWXq1XshY+JDkxJhiBwh4xq5DsJjfdapWI4mmALymenfsfN
         BMvepG4nWitCjDXwAHYpHtS0KU7myLAIGVYBHNEdU0a2cAFhN7Bn/jalTMQzr+pjgObd
         aipYiqwFnq3Hkb/y2JuoEHlLIZLE+5HzV1syuhWqOmp1NJCoa8769mY9AAsSVL9WM+mv
         8N4ALz+c7gAxPH5giZAEXPj5KQ86fKWH/yL336lw9o83pM307ZqmvMX71F0G+EIIYToG
         18cg==
X-Gm-Message-State: AOJu0YwS+ZHr1o2y1dK9/u6nZjq3FA856mlQCkgnERffp/mAViE7ijfk
	2a7LwqRJCQGbZ9XdU1XpvxzMhojWxv/tzDkl/tlDHJJfatM9Yo+y
X-Google-Smtp-Source: AGHT+IGWFnJrRxLBHumfHhI1WBj7sgb0ex91I19YCMtOUFEnhpMWS9ZsJLWMPQLIEI5GPzONDB11wA==
X-Received: by 2002:a1c:4b19:0:b0:40e:46b6:bc48 with SMTP id y25-20020a1c4b19000000b0040e46b6bc48mr7040329wma.41.1706630970210;
        Tue, 30 Jan 2024 08:09:30 -0800 (PST)
Received: from localhost.localdomain ([176.230.105.209])
        by smtp.gmail.com with ESMTPSA id n4-20020a5d4c44000000b0033aeda49732sm5725756wrt.33.2024.01.30.08.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 08:09:29 -0800 (PST)
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
Subject: [PATCH RFC] net: ethernet: mtk_eth_soc: ppe: add support for multiple PPEs
Date: Tue, 30 Jan 2024 18:08:49 +0200
Message-ID: <20240130160854.5221-1-eladwf@gmail.com>
X-Mailer: git-send-email 2.43.0
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
 drivers/net/ethernet/mediatek/mtk_eth_soc.c   | 79 +++++++++++--------
 drivers/net/ethernet/mediatek/mtk_eth_soc.h   | 15 +++-
 .../net/ethernet/mediatek/mtk_ppe_offload.c   |  6 +-
 3 files changed, 62 insertions(+), 38 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index a6e91573f8da..ba4e54977f34 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -2176,7 +2176,7 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
 		}
 
 		if (reason == MTK_PPE_CPU_REASON_HIT_UNBIND_RATE_REACHED)
-			mtk_ppe_check_skb(eth->ppe[0], skb, hash);
+			mtk_ppe_check_skb(eth->ppe[eth->mac[mac]->ppe_idx], skb, hash);
 
 		skb_record_rx_queue(skb, 0);
 		napi_gro_receive(napi, skb);
@@ -3267,37 +3267,27 @@ static int mtk_start_dma(struct mtk_eth *eth)
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
+	val = mtk_r32(eth, MTK_GDMA_FWD_CFG(id));
 
-		val = mtk_r32(eth, MTK_GDMA_FWD_CFG(i));
+	/* default setup the forward port to send frame to PDMA */
+	val &= ~0xffff;
 
-		/* default setup the forward port to send frame to PDMA */
-		val &= ~0xffff;
+	/* Enable RX checksum */
+	val |= MTK_GDMA_ICS_EN | MTK_GDMA_TCS_EN | MTK_GDMA_UCS_EN;
 
-		/* Enable RX checksum */
-		val |= MTK_GDMA_ICS_EN | MTK_GDMA_TCS_EN | MTK_GDMA_UCS_EN;
+	val |= config;
 
-		val |= config;
+	if (eth->netdev[id] && netdev_uses_dsa(eth->netdev[id]))
+		val |= MTK_GDMA_SPECIAL_TAG;
 
-		if (netdev_uses_dsa(eth->netdev[i]))
-			val |= MTK_GDMA_SPECIAL_TAG;
-
-		mtk_w32(eth, val, MTK_GDMA_FWD_CFG(i));
-	}
-	/* Reset and enable PSE */
-	mtk_w32(eth, RST_GL_PSE, MTK_RST_GL);
-	mtk_w32(eth, 0, MTK_RST_GL);
+	mtk_w32(eth, val, MTK_GDMA_FWD_CFG(id));
 }
 
 
@@ -3369,6 +3359,7 @@ static int mtk_open(struct net_device *dev)
 	/* we run 2 netdevs on the same dma ring so we only bring it up once */
 	if (!refcount_read(&eth->dma_refcnt)) {
 		const struct mtk_soc_data *soc = eth->soc;
+		const u32 ppe_num = mtk_get_ppe_num(eth);
 		u32 gdm_config;
 		int i;
 
@@ -3381,17 +3372,36 @@ static int mtk_open(struct net_device *dev)
 		for (i = 0; i < ARRAY_SIZE(eth->ppe); i++)
 			mtk_ppe_start(eth->ppe[i]);
 
-		gdm_config = soc->offload_version ? soc->reg_map->gdma_to_ppe
-						  : MTK_GDMA_TO_PDMA;
-		mtk_gdm_config(eth, gdm_config);
+		for (i = 0; i < MTK_MAX_DEVS; i++) {
+			if (!eth->netdev[i])
+				break;
+			struct mtk_mac *target_mac = netdev_priv(eth->netdev[i]);
+
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
+	} else
 		refcount_inc(&eth->dma_refcnt);
 
 	phylink_start(mac->phylink);
@@ -3469,7 +3479,8 @@ static int mtk_stop(struct net_device *dev)
 	if (!refcount_dec_and_test(&eth->dma_refcnt))
 		return 0;
 
-	mtk_gdm_config(eth, MTK_GDMA_DROP_ALL);
+	for (i = 0; i < MTK_MAX_DEVS; i++)
+		mtk_gdm_config(eth, i, MTK_GDMA_DROP_ALL);
 
 	mtk_tx_irq_disable(eth, MTK_TX_DONE_INT);
 	mtk_rx_irq_disable(eth, eth->soc->txrx.rx_irq_done_mask);
@@ -4945,11 +4956,11 @@ static int mtk_probe(struct platform_device *pdev)
 	}
 
 	if (eth->soc->offload_version) {
-		u32 num_ppe = mtk_is_netsys_v2_or_greater(eth) ? 2 : 1;
+		u32 num_ppe = mtk_get_ppe_num(eth);
 
 		num_ppe = min_t(u32, ARRAY_SIZE(eth->ppe), num_ppe);
 		for (i = 0; i < num_ppe; i++) {
-			u32 ppe_addr = eth->soc->reg_map->ppe_base + i * 0x400;
+			u32 ppe_addr = eth->soc->reg_map->ppe_base + (i == 2 ? 0xC00 : i * 0x400);
 
 			eth->ppe[i] = mtk_ppe_init(eth, eth->base + ppe_addr, i);
 
@@ -4957,11 +4968,11 @@ static int mtk_probe(struct platform_device *pdev)
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
index 9ae3b8a71d0e..7654fa74e7fc 100644
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
+	unsigned int			ppe_idx;
 	int				speed;
 	struct device_node		*of_node;
 	struct phylink			*phylink;
@@ -1421,6 +1424,14 @@ static inline u32 mtk_get_ib2_multicast_mask(struct mtk_eth *eth)
 	return MTK_FOE_IB2_MULTICAST;
 }
 
+static inline u32 mtk_get_ppe_num(struct mtk_eth *eth)
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
+int mtk_eth_offload_init(struct mtk_eth *eth, int id);
 int mtk_eth_setup_tc(struct net_device *dev, enum tc_setup_type type,
 		     void *type_data);
 int mtk_flow_offload_cmd(struct mtk_eth *eth, struct flow_cls_offload *cls,
diff --git a/drivers/net/ethernet/mediatek/mtk_ppe_offload.c b/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
index fbb5e9d5af13..220685f6daaa 100644
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
+int mtk_eth_offload_init(struct mtk_eth *eth, int id)
 {
+	if (!eth->ppe[id] || !eth->ppe[id]->foe_table)
+		return 0;
 	return rhashtable_init(&eth->flow_table, &mtk_flow_ht_params);
 }
-- 
2.43.0


