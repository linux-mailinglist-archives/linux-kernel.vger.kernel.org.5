Return-Path: <linux-kernel+bounces-159311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 451DE8B2CDE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 00:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEAC2288091
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A3B1836C4;
	Thu, 25 Apr 2024 22:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+I2ecut"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9137181CFD;
	Thu, 25 Apr 2024 22:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714082857; cv=none; b=EQamzB10VeX8Ez2hU4+RJv/JSSddq4ZjRXN0kaSeUGNcPRSruVAHrIvQGM2MD1/d/l8DHXj0Zg3Gmw5nGJXvlqzanG5guNR3I1Dosqp4ykGbfqGqA87enjN/UfynQNzTuRkKX9RCPnNiyJKgV1eVesV0R+KyQH9vP8lAHc5TD5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714082857; c=relaxed/simple;
	bh=TIHi716ql6W7JkAg87hK+/NlxNNTNr3j5+ozLhVFT40=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ciVf+fipTpcTRCj/Eq54R7RdgHrqsneK5+LBff+I0PHozR3FmAfJLyNROd/FtslE7DJ3nZkq0AfohlLSt2+8KrV/CyRN3ndHcOHYIQs3CSkZagPXIHoVUQZ3SLuG9L0AHIGIBBmuOMOZpqqY2ke3/JDPy9C+JYRHlwM5/2ehIOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+I2ecut; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5ad2a15374eso955121eaf.3;
        Thu, 25 Apr 2024 15:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714082855; x=1714687655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0OvkLf2eq0KdJa5mTu/U97lc17pEWUvnY93iweSl7Ps=;
        b=b+I2ecut4wdlaxfXPBY9ZousR1jFcXyGkHi9670HjpmNlFnATkiKkA9p5wgt5Yalyu
         H+T2N7zBmwKNoRb7/g/4eIZuOFldomAOPr8TVSozQ/EGci6Jd9LnjfA4bUBc5hSdbf7e
         xwqFTl118Qci59XQ3nyLD1kpDd4EnLyotJcjehWwgvdBzKzsToQzivLj3ox/4unBC3tV
         Hi6t3gpWi/AA4Gd/k7gLBiAKuz3Vg/moH9KY0g9bM3zanaXzdoqtH3rx+88NzDqG27Jm
         l4oTYMPwIn3xL1e6jtUg58uGSR85651guiuLly4+s6C+Z95iIdMxNFC4GhzXeMwWFXXr
         s/0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714082855; x=1714687655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0OvkLf2eq0KdJa5mTu/U97lc17pEWUvnY93iweSl7Ps=;
        b=azeycAd0BQNLFm3We2qOGZqho+mXQVXn09OEo8MEUcP/uXMCFI/Fb/BuP5VeIMNwKw
         cpcTJAZSQTOrai00+0w3/MwaTQ4/dIc/sdjF1qjDf442KcpnvZFL3VWwT8OOrho4+vad
         ViUE44YfWibf3Xi9FubbndzwHmt8NhsJqcXaqBjTslsGI281ZYb3+62IdcLT/uhuKjzQ
         zYqbNcDvWYzwm7Jo44sfPmmX9DbBMphcgXD6wsBF8DzHx3KAu51VnF2two1m5O7og3ay
         AL61sdbD9schFyzVevn+HRYKSVDvxgQGArOecUmvFNNDwYssjU7q8jp9/jKzR3xXocsa
         ZllA==
X-Forwarded-Encrypted: i=1; AJvYcCWZLA2mNfVrOZL6o0gLKSZTs16Z4yeUdh93kYlEmGMGfE99MWDkNxZnVuI6995xhGEyeitG6jasBYvwVEsDWrpjDcxi9HYkNRyzqQQrHXq0eGXiGaQa216GSycdjE4GoBa5IjgN
X-Gm-Message-State: AOJu0YwpOZJheRI01QtCaEXVHNOFCkoK8cOPlXMgGWvxbFWT5M93LO1h
	B0xDyyNpC59DPBH/PdY9Hch5+zvAyKzz4+j4h9S9VvTcXd9M6PqL
X-Google-Smtp-Source: AGHT+IGwtIYE1j2gkvCBnH9ulv88xgj/4SUdqGmkPBOUvYoQ9E4djFEQmXkk+R1I8hnxTGct03Jb4A==
X-Received: by 2002:a05:6358:16c7:b0:189:8b22:b95 with SMTP id r7-20020a05635816c700b001898b220b95mr982210rwl.29.1714082854774;
        Thu, 25 Apr 2024 15:07:34 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id q2-20020a0c9a42000000b006a044503615sm4692891qvd.72.2024.04.25.15.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 15:07:34 -0700 (PDT)
From: Doug Berger <opendmb@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	netdev@vger.kernel.or,
	linux-kernel@vger.kernel.org,
	Doug Berger <opendmb@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/3] net: bcmgenet: synchronize UMAC_CMD access
Date: Thu, 25 Apr 2024 15:06:50 -0700
Message-Id: <20240425220650.2138801-4-opendmb@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425220650.2138801-1-opendmb@gmail.com>
References: <20240425220650.2138801-1-opendmb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The UMAC_CMD register is written from different execution
contexts and has insufficient synchronization protections to
prevent possible corruption. Of particular concern are the
acceses from the phy_device delayed work context used by the
adjust_link call and the BH context that may be used by the
ndo_set_rx_mode call.

A spinlock is added to the driver to protect contended register
accesses (i.e. reg_lock) and it is used to synchronize accesses
to UMAC_CMD.

Fixes: 1c1008c793fa ("net: bcmgenet: add main driver file")
Cc: stable@vger.kernel.org
Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     | 12 +++++++++++-
 drivers/net/ethernet/broadcom/genet/bcmgenet.h     |  4 +++-
 drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c |  8 +++++++-
 drivers/net/ethernet/broadcom/genet/bcmmii.c       |  2 ++
 4 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 5452b7dc6e6a..c7e7dac057a3 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -2467,14 +2467,18 @@ static void umac_enable_set(struct bcmgenet_priv *priv, u32 mask, bool enable)
 {
 	u32 reg;
 
+	spin_lock_bh(&priv->reg_lock);
 	reg = bcmgenet_umac_readl(priv, UMAC_CMD);
-	if (reg & CMD_SW_RESET)
+	if (reg & CMD_SW_RESET) {
+		spin_unlock_bh(&priv->reg_lock);
 		return;
+	}
 	if (enable)
 		reg |= mask;
 	else
 		reg &= ~mask;
 	bcmgenet_umac_writel(priv, reg, UMAC_CMD);
+	spin_unlock_bh(&priv->reg_lock);
 
 	/* UniMAC stops on a packet boundary, wait for a full-size packet
 	 * to be processed
@@ -2490,8 +2494,10 @@ static void reset_umac(struct bcmgenet_priv *priv)
 	udelay(10);
 
 	/* issue soft reset and disable MAC while updating its registers */
+	spin_lock_bh(&priv->reg_lock);
 	bcmgenet_umac_writel(priv, CMD_SW_RESET, UMAC_CMD);
 	udelay(2);
+	spin_unlock_bh(&priv->reg_lock);
 }
 
 static void bcmgenet_intr_disable(struct bcmgenet_priv *priv)
@@ -3597,16 +3603,19 @@ static void bcmgenet_set_rx_mode(struct net_device *dev)
 	 * 3. The number of filters needed exceeds the number filters
 	 *    supported by the hardware.
 	*/
+	spin_lock(&priv->reg_lock);
 	reg = bcmgenet_umac_readl(priv, UMAC_CMD);
 	if ((dev->flags & (IFF_PROMISC | IFF_ALLMULTI)) ||
 	    (nfilter > MAX_MDF_FILTER)) {
 		reg |= CMD_PROMISC;
 		bcmgenet_umac_writel(priv, reg, UMAC_CMD);
+		spin_unlock(&priv->reg_lock);
 		bcmgenet_umac_writel(priv, 0, UMAC_MDF_CTRL);
 		return;
 	} else {
 		reg &= ~CMD_PROMISC;
 		bcmgenet_umac_writel(priv, reg, UMAC_CMD);
+		spin_unlock(&priv->reg_lock);
 	}
 
 	/* update MDF filter */
@@ -4005,6 +4014,7 @@ static int bcmgenet_probe(struct platform_device *pdev)
 		goto err;
 	}
 
+	spin_lock_init(&priv->reg_lock);
 	spin_lock_init(&priv->lock);
 
 	/* Set default pause parameters */
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
index 7523b60b3c1c..43b923c48b14 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * Copyright (c) 2014-2020 Broadcom
+ * Copyright (c) 2014-2024 Broadcom
  */
 
 #ifndef __BCMGENET_H__
@@ -573,6 +573,8 @@ struct bcmgenet_rxnfc_rule {
 /* device context */
 struct bcmgenet_priv {
 	void __iomem *base;
+	/* reg_lock: lock to serialize access to shared registers */
+	spinlock_t reg_lock;
 	enum bcmgenet_version version;
 	struct net_device *dev;
 
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c b/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c
index 7a41cad5788f..1248792d7fd4 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c
@@ -2,7 +2,7 @@
 /*
  * Broadcom GENET (Gigabit Ethernet) Wake-on-LAN support
  *
- * Copyright (c) 2014-2020 Broadcom
+ * Copyright (c) 2014-2024 Broadcom
  */
 
 #define pr_fmt(fmt)				"bcmgenet_wol: " fmt
@@ -151,6 +151,7 @@ int bcmgenet_wol_power_down_cfg(struct bcmgenet_priv *priv,
 	}
 
 	/* Can't suspend with WoL if MAC is still in reset */
+	spin_lock_bh(&priv->reg_lock);
 	reg = bcmgenet_umac_readl(priv, UMAC_CMD);
 	if (reg & CMD_SW_RESET)
 		reg &= ~CMD_SW_RESET;
@@ -158,6 +159,7 @@ int bcmgenet_wol_power_down_cfg(struct bcmgenet_priv *priv,
 	/* disable RX */
 	reg &= ~CMD_RX_EN;
 	bcmgenet_umac_writel(priv, reg, UMAC_CMD);
+	spin_unlock_bh(&priv->reg_lock);
 	mdelay(10);
 
 	if (priv->wolopts & (WAKE_MAGIC | WAKE_MAGICSECURE)) {
@@ -203,6 +205,7 @@ int bcmgenet_wol_power_down_cfg(struct bcmgenet_priv *priv,
 	}
 
 	/* Enable CRC forward */
+	spin_lock_bh(&priv->reg_lock);
 	reg = bcmgenet_umac_readl(priv, UMAC_CMD);
 	priv->crc_fwd_en = 1;
 	reg |= CMD_CRC_FWD;
@@ -210,6 +213,7 @@ int bcmgenet_wol_power_down_cfg(struct bcmgenet_priv *priv,
 	/* Receiver must be enabled for WOL MP detection */
 	reg |= CMD_RX_EN;
 	bcmgenet_umac_writel(priv, reg, UMAC_CMD);
+	spin_unlock_bh(&priv->reg_lock);
 
 	reg = UMAC_IRQ_MPD_R;
 	if (hfb_enable)
@@ -256,7 +260,9 @@ void bcmgenet_wol_power_up_cfg(struct bcmgenet_priv *priv,
 	}
 
 	/* Disable CRC Forward */
+	spin_lock_bh(&priv->reg_lock);
 	reg = bcmgenet_umac_readl(priv, UMAC_CMD);
 	reg &= ~CMD_CRC_FWD;
 	bcmgenet_umac_writel(priv, reg, UMAC_CMD);
+	spin_unlock_bh(&priv->reg_lock);
 }
diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
index 86a4aa72b3d4..c4a3698cef66 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -76,6 +76,7 @@ static void bcmgenet_mac_config(struct net_device *dev)
 	reg |= RGMII_LINK;
 	bcmgenet_ext_writel(priv, reg, EXT_RGMII_OOB_CTRL);
 
+	spin_lock_bh(&priv->reg_lock);
 	reg = bcmgenet_umac_readl(priv, UMAC_CMD);
 	reg &= ~((CMD_SPEED_MASK << CMD_SPEED_SHIFT) |
 		       CMD_HD_EN |
@@ -88,6 +89,7 @@ static void bcmgenet_mac_config(struct net_device *dev)
 		reg |= CMD_TX_EN | CMD_RX_EN;
 	}
 	bcmgenet_umac_writel(priv, reg, UMAC_CMD);
+	spin_unlock_bh(&priv->reg_lock);
 
 	active = phy_init_eee(phydev, 0) >= 0;
 	bcmgenet_eee_enable_set(dev,
-- 
2.34.1


