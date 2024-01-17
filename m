Return-Path: <linux-kernel+bounces-28841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 620AF83039F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD7DE289964
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D0F1EA7F;
	Wed, 17 Jan 2024 10:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="ef5N6e9Q"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D502A1EA6F;
	Wed, 17 Jan 2024 10:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705487361; cv=none; b=MlqwbFDd3RO32UMucZTpCjyLS2jfluRTaqac/FqYl3/wNNhDV1+V36lELzrJC92f7OmU6Wkv4uXtjmUNfgwNsndUQ6pvzivtw4k4K9loxXEM6xjylNjBuVxHSWvPivhv8CJlrkpsuvVUA4FgBvPw6j4AfDuLRjCzixJrUh++9qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705487361; c=relaxed/simple;
	bh=xIQosJ+6UVarhez/5hqrfFABPbGJMJaNy9tQ1jVdHEU=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-GND-Sasl; b=HHTV6p4ckk7Lunj3Eq8a55geTBSBaWH4hs6G/uQPJ+O+RVqa74VfmfHDUUlLatJOjq7izQna9qLQh49u13Z3N9gRLW3VgHHcJZQ//bB1UudOgoMBWJ3gixIHty67qNgXGe6LODDtds6IOOFg9DXHzNvFH3ZP27w2GX+0o48wINU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=ef5N6e9Q; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E126D40008;
	Wed, 17 Jan 2024 10:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1705487358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TZlYkCBl1Y6CdrhayBhNxw2p07BMxLVRsxuvs4s82bo=;
	b=ef5N6e9QwFxk3EUuXBHTv99i4fDQfzfVUoA33JgLMIGamg7c6cDSk2inSFTfGUyl1gwiF1
	11EPF30H13+8ZkF6qaN5vmPsO9j/dUMUQ0QVzxvvRlC1U/iXc+oGyANi32WHNDl7cekCr2
	B5mQz6YFXqwo+oym/KfX4Q6xqgnxldvIXzSuum5SCjCPTcpA3Iwyoc1qR5+KOarVfnF0IE
	rw5E1LbYkGiQIIkijBsnFBQ5hSqxsQXzgnrX8hRmr0MzFMOhzGIb7nCjIw2AivihbsD5k1
	JiI9nZZBOp/O49sGbPc9RxXMEEjm+Y1R3mtfOOOnktG4KWq/oIKEf7+YNv/IqQ==
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
Subject: [RFC PATCH net-next 6/8] net: dsa: mt7530: get rid of mt753x_mac_config()
Date: Wed, 17 Jan 2024 13:28:36 +0300
Message-Id: <20240117102838.57445-7-arinc.unal@arinc9.com>
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

There is no need for a separate function to call
priv->info->mac_port_config(). Call it from mt753x_phylink_mac_config()
instead and remove mt753x_mac_config().

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/net/dsa/mt7530.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 76b304f8fb87..680e59732d94 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2617,16 +2617,6 @@ mt7531_mac_config(struct dsa_switch *ds, int port, unsigned int mode,
 	}
 }
 
-static void
-mt753x_mac_config(struct dsa_switch *ds, int port, unsigned int mode,
-		  const struct phylink_link_state *state)
-{
-	struct mt7530_priv *priv = ds->priv;
-
-	if (priv->info->mac_port_config)
-		priv->info->mac_port_config(ds, port, mode, state->interface);
-}
-
 static struct phylink_pcs *
 mt753x_phylink_mac_select_pcs(struct dsa_switch *ds, int port,
 			      phy_interface_t interface)
@@ -2652,8 +2642,8 @@ mt753x_phylink_mac_config(struct dsa_switch *ds, int port, unsigned int mode,
 	struct mt7530_priv *priv = ds->priv;
 	u32 mcr_cur, mcr_new;
 
-	if (port == 5 || port == 6)
-		mt753x_mac_config(ds, port, mode, state);
+	if ((port == 5 || port == 6) && priv->info->mac_port_config)
+		priv->info->mac_port_config(ds, port, mode, state->interface);
 
 	mcr_cur = mt7530_read(priv, MT7530_PMCR_P(port));
 	mcr_new = mcr_cur;
-- 
2.40.1


