Return-Path: <linux-kernel+bounces-28844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCEC8303A7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E46AB24D06
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3041F940;
	Wed, 17 Jan 2024 10:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="odZPxLwN"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DC81F5E4;
	Wed, 17 Jan 2024 10:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705487370; cv=none; b=LxS0++HTPFpRaivkMto1/2ZWiC46LOWw2mzx8Q/xWjieLNCMh1MSzE13TuSA+9fWLFU6U069BkNzQ6uK6MSkOJV/aDD0YJxq7J479uca189UTKh9kWkgWN2QvAnwIdI3d5uPbNLPl/8OHP3jONA61VIy3aPm7+Gu3c7RAfMCiVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705487370; c=relaxed/simple;
	bh=zibi+CeC2wCZfnWMWFljfdRRLPyrlidazTLAzNP54qg=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-GND-Sasl; b=WH9Lj/GU/QwpC0h/OddOU6/YTidu8VnABwl8B+qcRDzaOBDvaVDoy6qbsASZUvptpf2eW5MgktChIAOeF0OzeU/x3LlY0HiQmgGhlqnY9bylim4aSn5rd+2Iwp4UW3FONCoKcHc4ah/kxWc04Edj0q0x4k5QojgFUaZu1ug3cTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=odZPxLwN; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A70BF40013;
	Wed, 17 Jan 2024 10:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1705487366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yjRrjFO9xzMYnUQXRfFaph+4p0OC+506r/Lr0Ehs5Xc=;
	b=odZPxLwNS/O8C6jXnSxhhJ60JjgkngWQQ/eY5wexZSegMJ5Nx0yav2PY8coodDxnMs/Eq2
	47HXYcrYmnjjuFkHXKRn7TOsXmFldfzWWGkYqoEH7WUp+If83CbHWjCvqBmSiwKaOSU0LR
	msuhE0QcwhVqkFxGViwLveh6Iy8JyanXNXbotbGuuDXFeywUBpZwYLWXjzOoe2mzRFoEz0
	OrCziaahxCiGyGuKYpsbP9jqSSyh7LY/FepZEIZeyG1+fT6g7N7FtUrJBTar4/AnAAhUzx
	71u4tLme7PHMS8TFXl5L1QBCKyzFk89cy13IH+gjH5AtJh07Ei1ik2mesgOLzA==
From: =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
To: Daniel Golle <daniel@makrotopia.org>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>
Cc: =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	mithat.guner@xeront.com,
	erkin.bozoglu@xeront.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [RFC PATCH net-next 8/8] net: dsa: mt7530: simplify link operations and force link down on all ports
Date: Wed, 17 Jan 2024 13:28:38 +0300
Message-Id: <20240117102838.57445-9-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240117102838.57445-1-arinc.unal@arinc9.com>
References: <20240117102838.57445-1-arinc.unal@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

Currently, the link operations for switch MACs are scattered across
port_enable, port_disable, phylink_mac_config, phylink_mac_link_up, and
phylink_mac_link_down.

port_enable and port_disable clears the link settings. Move that to
mt7530_setup() and mt7531_setup_common() which set up the switches. This
way, the link settings are cleared on all ports at setup, and then only
once with phylink_mac_link_down() when a link goes down.

Force link down on all ports at setup as well. This ensures that only
active ports will have their link up.

Now that the bit for setting the port on force mode is done on
mt7530_setup() and mt7531_setup_common(), get rid of PMCR_FORCE_MODE_ID()
which helped determine which bit to use for the switch model.

The "MT7621 Giga Switch Programming Guide v0.3", "MT7531 Reference Manual
for Development Board v1.0", and "MT7988A Wi-Fi 7 Generation Router
Platform: Datasheet (Open Version) v0.1" documents show that these bits are
enabled at reset:

PMCR_IFG_XMIT(1) (not part of PMCR_LINK_SETTINGS_MASK)
PMCR_MAC_MODE (not part of PMCR_LINK_SETTINGS_MASK)
PMCR_TX_EN
PMCR_RX_EN
PMCR_BACKOFF_EN (not part of PMCR_LINK_SETTINGS_MASK)
PMCR_BACKPR_EN (not part of PMCR_LINK_SETTINGS_MASK)
PMCR_TX_FC_EN
PMCR_RX_FC_EN

Remove the setting of the bits not part of PMCR_LINK_SETTINGS_MASK on
phylink_mac_config as they're already set.

Suggested-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/net/dsa/mt7530.c | 30 +++++++++++++++++-------------
 drivers/net/dsa/mt7530.h |  2 --
 2 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index e565406d3314..53a9210513e2 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -1017,7 +1017,6 @@ mt7530_port_enable(struct dsa_switch *ds, int port,
 	priv->ports[port].enable = true;
 	mt7530_rmw(priv, MT7530_PCR_P(port), PCR_MATRIX_MASK,
 		   priv->ports[port].pm);
-	mt7530_clear(priv, MT7530_PMCR_P(port), PMCR_LINK_SETTINGS_MASK);
 
 	mutex_unlock(&priv->reg_mutex);
 
@@ -1037,7 +1036,6 @@ mt7530_port_disable(struct dsa_switch *ds, int port)
 	priv->ports[port].enable = false;
 	mt7530_rmw(priv, MT7530_PCR_P(port), PCR_MATRIX_MASK,
 		   PCR_MATRIX_CLR);
-	mt7530_clear(priv, MT7530_PMCR_P(port), PMCR_LINK_SETTINGS_MASK);
 
 	mutex_unlock(&priv->reg_mutex);
 }
@@ -2240,6 +2238,14 @@ mt7530_setup(struct dsa_switch *ds)
 	mt7530_mib_reset(ds);
 
 	for (i = 0; i < MT7530_NUM_PORTS; i++) {
+		/* Clear link settings, make all ports operate in force mode,
+		 * and force link down on all ports. PMCR_FORCE_LNK must be
+		 * unset to force link down. It is not modified here as it comes
+		 * unset after reset.
+		 */
+		mt7530_clear(priv, MT7530_PMCR_P(i), PMCR_LINK_SETTINGS_MASK);
+		mt7530_set(priv, MT7530_PMCR_P(i), PMCR_FORCE_MODE);
+
 		/* Disable forwarding by default on all ports */
 		mt7530_rmw(priv, MT7530_PCR_P(i), PCR_MATRIX_MASK,
 			   PCR_MATRIX_CLR);
@@ -2342,6 +2348,14 @@ mt7531_setup_common(struct dsa_switch *ds)
 		     UNU_FFP_MASK);
 
 	for (i = 0; i < MT7530_NUM_PORTS; i++) {
+		/* Clear link settings, make all ports operate in force mode,
+		 * and force link down on all ports. PMCR_FORCE_LNK must be
+		 * unset to force link down. It is not modified here as it comes
+		 * unset after reset.
+		 */
+		mt7530_clear(priv, MT7530_PMCR_P(i), PMCR_LINK_SETTINGS_MASK);
+		mt7530_set(priv, MT7530_PMCR_P(i), MT7531_FORCE_MODE);
+
 		/* Disable forwarding by default on all ports */
 		mt7530_rmw(priv, MT7530_PCR_P(i), PCR_MATRIX_MASK,
 			   PCR_MATRIX_CLR);
@@ -2640,23 +2654,13 @@ mt753x_phylink_mac_config(struct dsa_switch *ds, int port, unsigned int mode,
 			  const struct phylink_link_state *state)
 {
 	struct mt7530_priv *priv = ds->priv;
-	u32 mcr_cur, mcr_new;
 
 	if ((port == 5 || port == 6) && priv->info->mac_port_config)
 		priv->info->mac_port_config(ds, port, mode, state->interface);
 
-	mcr_cur = mt7530_read(priv, MT7530_PMCR_P(port));
-	mcr_new = mcr_cur;
-	mcr_new &= ~PMCR_LINK_SETTINGS_MASK;
-	mcr_new |= PMCR_IFG_XMIT(1) | PMCR_MAC_MODE | PMCR_BACKOFF_EN |
-		   PMCR_BACKPR_EN | PMCR_FORCE_MODE_ID(priv->id);
-
 	/* Are we connected to external phy */
 	if (port == 5 && dsa_is_user_port(ds, 5))
-		mcr_new |= PMCR_EXT_PHY;
-
-	if (mcr_new != mcr_cur)
-		mt7530_write(priv, MT7530_PMCR_P(port), mcr_new);
+		mt7530_set(priv, MT7530_PMCR_P(port), PMCR_EXT_PHY);
 }
 
 static void mt753x_phylink_mac_link_down(struct dsa_switch *ds, int port,
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index caae48703547..beda61263e0d 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -304,8 +304,6 @@ enum mt7530_vlan_port_acc_frm {
 					 MT7531_FORCE_DPX | \
 					 MT7531_FORCE_RX_FC | \
 					 MT7531_FORCE_TX_FC)
-#define  PMCR_FORCE_MODE_ID(id)		((((id) == ID_MT7531) || ((id) == ID_MT7988)) ?	\
-					 MT7531_FORCE_MODE : PMCR_FORCE_MODE)
 #define  PMCR_LINK_SETTINGS_MASK	(PMCR_TX_EN | PMCR_FORCE_SPEED_1000 | \
 					 PMCR_RX_EN | PMCR_FORCE_SPEED_100 | \
 					 PMCR_TX_FC_EN | PMCR_RX_FC_EN | \
-- 
2.40.1


