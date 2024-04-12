Return-Path: <linux-kernel+bounces-143167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 309858A354E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7981B2309A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C302614E2F2;
	Fri, 12 Apr 2024 18:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFJl4j63"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6228914E2EF;
	Fri, 12 Apr 2024 18:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712945047; cv=none; b=KjpSyclwpviI4mlfBbJtNAKoj3dZOlaJuDBlN7FYiQ28VSgP1Q5GmQzEnXfva7mAqDOUxqSDvRcRIlE5+l8CaM12tKs+iX0kLEOQnaElmg6I57p7SPt0yjsQZhF1rLLwMxKEAQeJ8plYod/RSvofZ1CpBVI+jKMLiQowdqqGNdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712945047; c=relaxed/simple;
	bh=acuEN0Mam8ygiQBR73EoAgExddMuyxMA+FsHhdYx23Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ag84/2JrMGM1lQ7IfIIu01NHASfY++ZlbRAlGpal4DSUmNrOHppkipRdvTju+dZAhzvCRsKSq2QlhdOko3cpE4heBhXwS7+4c86TT/RhXc5V9WTffx7q3sBCUN7XIwyJjrUeHAinIlDliRRJ4DAt7A8DznVg0CUbKeFT9/X6xCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFJl4j63; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d094bc2244so12438531fa.1;
        Fri, 12 Apr 2024 11:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712945043; x=1713549843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CCp+O5zf1XAzEa7QvAx53sYKNLIL8eSplg5NSTorigk=;
        b=QFJl4j63VKZAY6x/EkZWzOJ1stOxMAw2wr2mfAG9MQ6GdXkyMpgb+TOIb2P89c2nLO
         Hdw0hlqyWakrgbVElbuvCs8rA/JcuutQ2hmRwXCodwlrs1KTdkJLlsH5Xv/w2eTw3wL+
         nH/VRhP6Hf55u7FZnRTJiRPLmxkC6cRLey1B71XwllcJF27ZKhuM92fW/Fw5BpmsbZ9R
         eDXdVgghIqTPSW3xDGcvbXJNNllH4npO9MVRST53kWturIDWLmrEE5yEFkegcZpuj7+t
         4NZEtU3MgznNNGFWceWLgCcDwLWw0T3TWQThPhnaPaqvWycHkZ993TMdiXGTqx20yXsO
         zTZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712945043; x=1713549843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CCp+O5zf1XAzEa7QvAx53sYKNLIL8eSplg5NSTorigk=;
        b=SbWV61jazi2MYstMNu4VSuykpaEFcr+7L1T2R7xwrFfjWay0cjamIMZW87JviCWiiI
         jNyVnB0+iOEiVKApwxL46CJlT8W3r+GxYMvcFI6MDKnsC031Z/nicsJzsS5Ei4RAfA9F
         ulMxIsdc5JU24ZM6nZgmBSNOhv1OEab0fyKH358+7SMUEZGLnOTBP9N6GtjyrGK+RacH
         QF+W8Fn+J30UhKb7Cw3UKjRDGbjANqkuDZ/ov6zFWdP5MyqRP/upfGoSGGJgueA++wxA
         0HGjg9MITU2w+YyE2snHL/XeentVJ1ebJg90bsh9VGNkWxujK14oZ0aG+yG0TveOpA4u
         /ZRQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8V4A2wojIzaFgfFMgA3Dhru3XU3qUh2EARegOBAXmUGlQCtuGBE/9281URnCAMW6hW2Xji9XBoPwGPEmD04Ck0AQjIttzRzIvdLcFW5ZdkM2BD/8co6kwI4eaiClEpVMH7oHT
X-Gm-Message-State: AOJu0YyHegoixUcjfKES+irdDJ1ET7t5g0HnPOK0ExBpU3q/rtKwMooR
	uJBcM/UHGLWb7J1J5SRNDhHIxIwsrcxU+rrtaDrMyjRc2zf8FPuX
X-Google-Smtp-Source: AGHT+IHENBuTlxLf/6N97dtbn3xcV+Dq/EI4bigipZaf5nXjIl76R7vPSnhcP7MwSAR0x+L4seiNwQ==
X-Received: by 2002:a05:651c:33c:b0:2d9:fe84:a485 with SMTP id b28-20020a05651c033c00b002d9fe84a485mr2395294ljp.29.1712945043444;
        Fri, 12 Apr 2024 11:04:03 -0700 (PDT)
Received: from localhost ([95.79.241.172])
        by smtp.gmail.com with ESMTPSA id by43-20020a05651c1a2b00b002d88d978484sm547676ljb.132.2024.04.12.11.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 11:04:03 -0700 (PDT)
From: Serge Semin <fancer.lancer@gmail.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Yanteng Si <siyanteng@loongson.cn>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Bhadram Varka <vbhadram@nvidia.com>
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
Subject: [PATCH net 1/4] net: stmmac: Apply half-duplex-less constraint for DW QoS Eth only
Date: Fri, 12 Apr 2024 21:03:14 +0300
Message-ID: <20240412180340.7965-2-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240412180340.7965-1-fancer.lancer@gmail.com>
References: <20240412180340.7965-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are three DW MAC IP-cores which can have the multiple Tx/Rx queues
enabled:
DW GMAC v3.7+ with AV feature,
DW QoS Eth v4.x/v5.x,
DW XGMAC/XLGMAC
Based on the respective HW databooks, only the DW QoS Eth IP-core doesn't
support the half-duplex link mode in case if more than one queues enabled:

"In multiple queue/channel configurations, for half-duplex operation,
enable only the Q0/CH0 on Tx and Rx. For single queue/channel in
full-duplex operation, any queue/channel can be enabled."

The rest of the IP-cores don't have such constraint. Thus in order to have
the constraint applied for the DW QoS Eth MACs only, let's move the it'
implementation to the respective MAC-capabilities getter and make sure the
getter is called in the queues re-init procedure.

Fixes: b6cfffa7ad92 ("stmmac: fix DMA channel hang in half-duplex mode")
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac4_core.c |  7 +++++++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 19 +++----------------
 2 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index cef25efbdff9..ec6a13e644b3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -71,6 +71,13 @@ static void dwmac4_core_init(struct mac_device_info *hw,
 static void dwmac4_phylink_get_caps(struct stmmac_priv *priv)
 {
 	priv->phylink_config.mac_capabilities |= MAC_2500FD;
+
+	if (priv->plat->tx_queues_to_use > 1)
+		priv->phylink_config.mac_capabilities &=
+			~(MAC_10HD | MAC_100HD | MAC_1000HD);
+	else
+		priv->phylink_config.mac_capabilities |=
+			(MAC_10HD | MAC_100HD | MAC_1000HD);
 }
 
 static void dwmac4_rx_queue_enable(struct mac_device_info *hw,
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 24cd80490d19..dd58c21b53ee 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1198,17 +1198,6 @@ static int stmmac_init_phy(struct net_device *dev)
 	return ret;
 }
 
-static void stmmac_set_half_duplex(struct stmmac_priv *priv)
-{
-	/* Half-Duplex can only work with single tx queue */
-	if (priv->plat->tx_queues_to_use > 1)
-		priv->phylink_config.mac_capabilities &=
-			~(MAC_10HD | MAC_100HD | MAC_1000HD);
-	else
-		priv->phylink_config.mac_capabilities |=
-			(MAC_10HD | MAC_100HD | MAC_1000HD);
-}
-
 static int stmmac_phy_setup(struct stmmac_priv *priv)
 {
 	struct stmmac_mdio_bus_data *mdio_bus_data;
@@ -1237,10 +1226,7 @@ static int stmmac_phy_setup(struct stmmac_priv *priv)
 				    priv->phylink_config.supported_interfaces);
 
 	priv->phylink_config.mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
-						MAC_10FD | MAC_100FD |
-						MAC_1000FD;
-
-	stmmac_set_half_duplex(priv);
+						MAC_10 | MAC_100 | MAC_1000;
 
 	/* Get the MAC specific capabilities */
 	stmmac_mac_phylink_get_caps(priv);
@@ -7355,7 +7341,8 @@ int stmmac_reinit_queues(struct net_device *dev, u32 rx_cnt, u32 tx_cnt)
 			priv->rss.table[i] = ethtool_rxfh_indir_default(i,
 									rx_cnt);
 
-	stmmac_set_half_duplex(priv);
+	stmmac_mac_phylink_get_caps(priv);
+
 	stmmac_napi_add(dev);
 
 	if (netif_running(dev))
-- 
2.43.0


