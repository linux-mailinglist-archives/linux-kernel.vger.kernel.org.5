Return-Path: <linux-kernel+bounces-152856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 833F88AC548
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3807C1F222C7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FB75FBBA;
	Mon, 22 Apr 2024 07:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gp5i4Wjb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE884F60D;
	Mon, 22 Apr 2024 07:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713770131; cv=none; b=rwdJPdSe1AAmry+0Xr4Hk5pJvDSC2MqGqW66LeefSrAVB/nZoQb/IyTUXaVOdABp378ELmHblEfD7txFhLpA1dpTZm0Jq5i1bKKJG58KsR9MC/76WHsPNLG5vGx9uKWYfajLMSSt7Qk+2MfTSCoDC0FU5HZlj144Y1re+hwMZSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713770131; c=relaxed/simple;
	bh=cg3WzltntgM9sJaif7yixpNGnhWKABN+vYsiEpkpVJs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZF1z/LQh1xJWtIPXNziJJv37NeML3Yhagd1ftGRjuj8sj0NDJubhM6NUaKPQodCX7zb3wpkaldqJcoy5FceZv5+CycLp6pa9LXh7L3qglLkJ3S/robWl4H+9n49vO6iuuHkGldPsbsgcIoAmyMQgSw/FnJQf6D3mCSXkFsawXhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gp5i4Wjb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B10DC3277B;
	Mon, 22 Apr 2024 07:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713770131;
	bh=cg3WzltntgM9sJaif7yixpNGnhWKABN+vYsiEpkpVJs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gp5i4WjbIb/VLanMYMuvzox2mfHc+rqg2JLUGYzBW3vM8FOOZSjpaEPCRZj54LfrN
	 NeOqrI8oDN2FR8AbX9uNdTv9jygAqNYOcy8tdni3vhwQXP7AkmacEwxBhspFC7W3jL
	 8ijXWOmfBtcpiEEqBMj4/6Sik7rNnSku6YumbSFxjTMnE+1EQ2wDojf2Es4v6FJBqw
	 Y8NdbOpEcE6kPJO6Ep7fc/rxM1fBDWkv2xIJ3GAvlmR6ZhPBjJ5oa7ge/IcyN7POPN
	 lDPuwRI0eQG2aiUx4iBY2xhp8uTPuNwbJOplNUlDHld+TGx554eA7A8Dq3l4bXCo6L
	 kYAjJdInQhL3w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608C2C4345F;
	Mon, 22 Apr 2024 07:15:31 +0000 (UTC)
From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL_via_B4_Relay?= <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Mon, 22 Apr 2024 10:15:22 +0300
Subject: [PATCH net-next v2 15/15] net: dsa: mt7530: explain exposing MDIO
 bus of MT7531AE better
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240422-for-netnext-mt7530-improvements-4-v2-15-a75157ba76ad@arinc9.com>
References: <20240422-for-netnext-mt7530-improvements-4-v2-0-a75157ba76ad@arinc9.com>
In-Reply-To: <20240422-for-netnext-mt7530-improvements-4-v2-0-a75157ba76ad@arinc9.com>
To: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>, 
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Bartel Eerdekens <bartel.eerdekens@constell8.be>, 
 mithat.guner@xeront.com, erkin.bozoglu@xeront.com, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713770127; l=1109;
 i=arinc.unal@arinc9.com; s=arinc9-Xeront; h=from:subject:message-id;
 bh=vLvtlbHMBxKy/N+5hO2kjs9XkvkZFD7LvDK5jmVwOt0=;
 b=rrMcStwgZhwRYkv1smaK4/6fyCCBXYnzMSeDeY5COCE0JpnpNyuwBmAa+EH2zLbVYygTr8jEZ
 xmxYYbP6SFjBC2xJ1TKMAKURIjla8Ln7p8UXbk0E9eIB0v4YTX21ANp
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=z49tLn29CyiL4uwBTrqH9HO1Wu3sZIuRp4DaLZvtP9M=
X-Endpoint-Received: by B4 Relay for arinc.unal@arinc9.com/arinc9-Xeront
 with auth_id=137
X-Original-From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
Reply-To: arinc.unal@arinc9.com

From: Arınç ÜNAL <arinc.unal@arinc9.com>

Unlike MT7531BE, the GPIO 6-12 pins are not used for RGMII on MT7531AE.
Therefore, the GPIO 11-12 pins are set to function as MDC and MDIO to
expose the MDIO bus of the switch. Replace the comment with a better
explanation.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/net/dsa/mt7530.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 1f6cd24de4b7..2b9f904a98f0 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2635,7 +2635,10 @@ mt7531_setup(struct dsa_switch *ds)
 	if (!priv->p5_sgmii) {
 		mt7531_pll_setup(priv);
 	} else {
-		/* Let ds->user_mii_bus be able to access external phy. */
+		/* Unlike MT7531BE, the GPIO 6-12 pins are not used for RGMII on
+		 * MT7531AE. Set the GPIO 11-12 pins to function as MDC and MDIO
+		 * to expose the MDIO bus of the switch.
+		 */
 		mt7530_rmw(priv, MT7531_GPIO_MODE1, MT7531_GPIO11_RG_RXD2_MASK,
 			   MT7531_EXT_P_MDC_11);
 		mt7530_rmw(priv, MT7531_GPIO_MODE1, MT7531_GPIO12_RG_RXD3_MASK,

-- 
2.40.1



