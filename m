Return-Path: <linux-kernel+bounces-148644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5AF8A8578
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCB1A1F21592
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539A01422AB;
	Wed, 17 Apr 2024 14:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWKOhTWw"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECBB140E34;
	Wed, 17 Apr 2024 14:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713362422; cv=none; b=eIDDWWa4rsxEcs+ZeVqI5vcQzkq4WpAnRX0VPJ63nK22XhtB96VYh/DK/tnA7EhSMCOUwBarhR9M4LRAKkqfL+cNJIa81sdxqt5F49Hrps6E6IbIr41x5VokXs4DN5pEVHQkGL65H7Oqap2puMalzzqLvWwvBqRcfKuxvXleM9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713362422; c=relaxed/simple;
	bh=TWD2L2Zr8UYsDCfzmnyou73DVYZGAWwGKJBxOFNqDtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qOiAb5tchxBsCN4dCjcwGH+nTVpAwUIQvzjp0iQJCSgAp4dn7iAAAaz2FLqd2L/C2TM3aXC6CsnrHUz7eaQSDVjiyYRslZ4rWasLZsvKBJ1Z0+V4ZCijB4JQaulOubjtu9iObEAaCmd86l6/Kj5OfSnW8tBgm+8ZV7eGgxjvUr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UWKOhTWw; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-516d487659bso6825206e87.2;
        Wed, 17 Apr 2024 07:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713362419; x=1713967219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8KnMWOMZl4OlIeWKfyhTeTgh6nDBj0ThrZdjCpvV0rs=;
        b=UWKOhTWwUe4opv3Yxmrb+h5eO3f5BnUPW5lfuKYjgfj7L4rSz1ACL/QWP8G04H/maS
         qtxPTjqRQEnw4sAs0c4KqnsFXudc08AYrgf1qsiVo/mv/Oj26zPM2VFeWiOIwvmkck9r
         /NoixLOYQOu03jjTQBHbUTChX7a6BNntUd/sYbjd8PltiuUwpm2dOsJt56AMBg1SOX2U
         e7suSZU9L1PUzgCuXFj2BI+4+B9uXrhPBe4KDLSD/ZYvWFDnwMaj4GXWw+sJOqb0i7mK
         jNsY8pMmnDp0YrHgACZcJ035mvf/8D0VuNI4WbWQBHnmighAY8b7kFiAZPh3AAMGVgPy
         0YTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713362419; x=1713967219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8KnMWOMZl4OlIeWKfyhTeTgh6nDBj0ThrZdjCpvV0rs=;
        b=XNvVIvoH0q4dgqCNh03Neym3l09hm0gQvjh1sz9xdg+tvQFwZCcff/JOk8QN9y0KoJ
         1vkR1ev1XEPt1LK1c0Hl0wYa5EL0TZ5vkh5R5OV9kFhHp11c+I6h2r6dgzYHEWk22bLS
         Qv1hiDP4qoXlMo+VVWA/ROK24baoeCjuSA9BSfUMRorxRpdphCYFHkCrW9L3XR6UjapJ
         RT5I0dUG7WC+2m4Fu+73rTgdotwPcnzqQsy0X7WDv917i/QZ2Wpu/gNiHLBIRswJn8/H
         d6qg98L4My/1/ZnYGmbaGcbXvfOACQnAbkllbeAQ2nqZBmEy/fefiS78uM4+M9eYHdRn
         PdQA==
X-Forwarded-Encrypted: i=1; AJvYcCWx+ZYFqC1JFzQMogCHm4FHA4GIXJRl1jw6ooXCFSFNjtz86qpnGfAYoY3iDdqJEmbZZTZaeXn1L3D4q5C81zVlZt6kSAu6/lhHcIaWr7/Xlb+tBeZhyqWrGOKPeSnFC0eBE6jD
X-Gm-Message-State: AOJu0YwkQOUuIkC6kpYn3bZDvAn2ZgYwNieAWQDz1ZdgegHOIfmeXbrU
	RNB42re9XwatZo6XuVSCbE8FN7yEdYVVeIPsFGs+GimHOaKIxzGY
X-Google-Smtp-Source: AGHT+IEFwpS1qE+a87B7Ubcokq+jSyQu+NQX48mgWo7d9MJK3BT85N5w69dYy1tGNwmTeX2J7BN2jw==
X-Received: by 2002:ac2:4d9b:0:b0:516:d33a:7571 with SMTP id g27-20020ac24d9b000000b00516d33a7571mr10745339lfe.8.1713362418928;
        Wed, 17 Apr 2024 07:00:18 -0700 (PDT)
Received: from localhost ([94.125.187.42])
        by smtp.gmail.com with ESMTPSA id g20-20020a19ee14000000b00515b0706b95sm1971640lfb.17.2024.04.17.07.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 07:00:18 -0700 (PDT)
From: Serge Semin <fancer.lancer@gmail.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Yanteng Si <siyanteng@loongson.cn>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 2/2] net: stmmac: Move MAC caps init to phylink MAC caps getter
Date: Wed, 17 Apr 2024 17:00:08 +0300
Message-ID: <20240417140013.12575-3-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240417140013.12575-1-fancer.lancer@gmail.com>
References: <20240417140013.12575-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After a set of recent fixes the stmmac_phy_setup() and
stmmac_reinit_queues() methods have turned to having some duplicated code.
Let's get rid from the duplication by moving the MAC-capabilities
initialization to the PHYLINK MAC-capabilities getter. The getter is
called during each network device interface open/close cycle. So the
MAC-capabilities will be initialized in generic device open procedure and
in case of the Tx/Rx queues re-initialization as the original code
semantics implies.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---

Link: https://lore.kernel.org/netdev/20240412180340.7965-5-fancer.lancer@gmail.com/
Changelog v2:
- Resubmit the patch to net-next separately from the main patchset (Paolo)
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 36 +++++++++----------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index b810f6b69bf5..0d6cd1704e6a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -936,6 +936,22 @@ static void stmmac_mac_flow_ctrl(struct stmmac_priv *priv, u32 duplex)
 			priv->pause, tx_cnt);
 }
 
+static unsigned long stmmac_mac_get_caps(struct phylink_config *config,
+					 phy_interface_t interface)
+{
+	struct stmmac_priv *priv = netdev_priv(to_net_dev(config->dev));
+
+	/* Refresh the MAC-specific capabilities */
+	stmmac_mac_update_caps(priv);
+
+	config->mac_capabilities = priv->hw->link.caps;
+
+	if (priv->plat->max_speed)
+		phylink_limit_mac_speed(config, priv->plat->max_speed);
+
+	return config->mac_capabilities;
+}
+
 static struct phylink_pcs *stmmac_mac_select_pcs(struct phylink_config *config,
 						 phy_interface_t interface)
 {
@@ -1105,6 +1121,7 @@ static void stmmac_mac_link_up(struct phylink_config *config,
 }
 
 static const struct phylink_mac_ops stmmac_phylink_mac_ops = {
+	.mac_get_caps = stmmac_mac_get_caps,
 	.mac_select_pcs = stmmac_mac_select_pcs,
 	.mac_config = stmmac_mac_config,
 	.mac_link_down = stmmac_mac_link_down,
@@ -1204,7 +1221,6 @@ static int stmmac_phy_setup(struct stmmac_priv *priv)
 	int mode = priv->plat->phy_interface;
 	struct fwnode_handle *fwnode;
 	struct phylink *phylink;
-	int max_speed;
 
 	priv->phylink_config.dev = &priv->dev->dev;
 	priv->phylink_config.type = PHYLINK_NETDEV;
@@ -1225,15 +1241,6 @@ static int stmmac_phy_setup(struct stmmac_priv *priv)
 		xpcs_get_interfaces(priv->hw->xpcs,
 				    priv->phylink_config.supported_interfaces);
 
-	/* Refresh the MAC-specific capabilities */
-	stmmac_mac_update_caps(priv);
-
-	priv->phylink_config.mac_capabilities = priv->hw->link.caps;
-
-	max_speed = priv->plat->max_speed;
-	if (max_speed)
-		phylink_limit_mac_speed(&priv->phylink_config, max_speed);
-
 	fwnode = priv->plat->port_node;
 	if (!fwnode)
 		fwnode = dev_fwnode(priv->device);
@@ -7327,7 +7334,6 @@ int stmmac_reinit_queues(struct net_device *dev, u32 rx_cnt, u32 tx_cnt)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
 	int ret = 0, i;
-	int max_speed;
 
 	if (netif_running(dev))
 		stmmac_release(dev);
@@ -7341,14 +7347,6 @@ int stmmac_reinit_queues(struct net_device *dev, u32 rx_cnt, u32 tx_cnt)
 			priv->rss.table[i] = ethtool_rxfh_indir_default(i,
 									rx_cnt);
 
-	stmmac_mac_update_caps(priv);
-
-	priv->phylink_config.mac_capabilities = priv->hw->link.caps;
-
-	max_speed = priv->plat->max_speed;
-	if (max_speed)
-		phylink_limit_mac_speed(&priv->phylink_config, max_speed);
-
 	stmmac_napi_add(dev);
 
 	if (netif_running(dev))
-- 
2.43.0


