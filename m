Return-Path: <linux-kernel+bounces-148334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 608578A8115
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1922F2819FE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE6113C67F;
	Wed, 17 Apr 2024 10:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="YE4sxQ9s";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="XNRSWQ0O"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0154013AD25;
	Wed, 17 Apr 2024 10:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713350279; cv=none; b=oDuRkpjBI2mM5Ehyfe4jCb/tqhNzWWVydKVOxxeNHrao2u+OBB9s1cxVn/DgmdLzSy1fK/hfVY/xh4OdstJrk1rY456nXF0/7bY4BrZ0pMsN5lzGc0fSA36y6F76LISerJmbrqwJHAfQWbqOSkITpI5GYuv14nwwYl7MWbIIJsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713350279; c=relaxed/simple;
	bh=D8QRemH30gl7Dx0jkJVKi6TU6cwZ0jVUfI7KwoD5GGE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Yq4MT/BGR8T0VIBHkmm8rbIkkIjoTVBt//lOIjB26wVAG5Zupy8wayjilAvZsjarI0bhbsswCZbCtP6Z+5oY1YFINUIbu26SE98+whmCWBq8B9fwERgJuvLVYirNLRgvhj8OYTPiBtP/dOk/Y4gr+7u9GZH8xxC0uCvgNigIDuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=YE4sxQ9s; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=XNRSWQ0O reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1713350276; x=1744886276;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=48A9qXlHYbdLR6pAymipmKQX31M+zjp12feMhPewqe8=;
  b=YE4sxQ9s7sF4F48+QDzes77EjpHlDlJjS/WU4SQnTpQwQw2WNbBBLstX
   LUOoBYnnvzNI0+LdyafZppL1LNmpNisjOYAyhG01gFAnK8nhbxOzD2HXJ
   Z3Ob6M38i1KhNjKlqVzsGyDx6/0pkaA/wgj3lv5EfoOyw163IkS1dDLac
   5bQS6KcMs9hTZgkOuorHC6lSelW1W/Tsj0c6EIhtV7sFAcKGo2EveHWnf
   0bWitGKYc/PGDof7wXp8Qetp//wNkDV9J7fOBlFfaQG5H674ggO/43JKj
   4e4ZlWg/iXpPjWE8NhqmCniyxO2xM+nraknKRgyrV+uD+nuGXMti+rX1p
   g==;
X-IronPort-AV: E=Sophos;i="6.07,209,1708383600"; 
   d="scan'208";a="36465195"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 17 Apr 2024 12:37:52 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 776081724B0;
	Wed, 17 Apr 2024 12:37:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1713350268;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=48A9qXlHYbdLR6pAymipmKQX31M+zjp12feMhPewqe8=;
	b=XNRSWQ0OB91gwNGE4JCIVrZlHZqzXsTrIap/Ev3xLBK1UuLG+IvD7bARjPJ1efxw2QxytO
	Dav944IpaCp4vxPvDbuHhf1Q26E+/7Dy+bue3Wb0TiyIPOLbp1ekgWQ1US/hJgJnL8P4EY
	lIT/gdcJIJ1o71hiL9VVrHwGwmlpolp60bJcJeFnfC+dqFxydWZHRhgF4fhvpIJ6e4Mp8k
	8cgkhknxWSqE+lgH9jXIdnVS0CA4Da0uWe5hWoeX+62Paf/FZfgEB0E4xGChJQaVH1O75x
	fdjMA/CJmgvsspiIGR9AhNJy68ZuHPZnQhfTyRjcKLeLo2P24Kaa9eMD3HimPg==
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@ew.tq-group.com,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH net v2] net: dsa: mv88e6xx: fix supported_interfaces setup in mv88e6250_phylink_get_caps()
Date: Wed, 17 Apr 2024 12:37:37 +0200
Message-ID: <20240417103737.166651-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

With the recent PHYLINK changes requiring supported_interfaces to be set,
MV88E6250 family switches like the 88E6020 fail to probe - cmode is
never initialized on these devices, so mv88e6250_phylink_get_caps() does
not set any supported_interfaces flags.

Instead of a cmode, on 88E6250 we have a read-only port mode value that
encodes similar information. There is no reason to bother mapping port
mode to the cmodes of other switch models; instead we introduce a
mv88e6250_setup_supported_interfaces() that is called directly from
mv88e6250_phylink_get_caps().

Fixes: de5c9bf40c45 ("net: phylink: require supported_interfaces to be filled")
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---

Changelog:

v2: Replace mv88e6250_port_get_mode() with
    mv88e6250_setup_supported_interfaces(), make sure we don't set
    PHY_INTERFACE_MODE_NA in the bitmap

 drivers/net/dsa/mv88e6xxx/chip.c | 56 +++++++++++++++++++++++++++++---
 drivers/net/dsa/mv88e6xxx/port.h | 23 ++++++++++---
 2 files changed, 71 insertions(+), 8 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index c95787cb90867..59b5dd0e2f41d 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -566,13 +566,61 @@ static void mv88e6xxx_translate_cmode(u8 cmode, unsigned long *supported)
 		phy_interface_set_rgmii(supported);
 }
 
-static void mv88e6250_phylink_get_caps(struct mv88e6xxx_chip *chip, int port,
-				       struct phylink_config *config)
+static void
+mv88e6250_setup_supported_interfaces(struct mv88e6xxx_chip *chip, int port,
+				     struct phylink_config *config)
 {
 	unsigned long *supported = config->supported_interfaces;
+	int err;
+	u16 reg;
 
-	/* Translate the default cmode */
-	mv88e6xxx_translate_cmode(chip->ports[port].cmode, supported);
+	err = mv88e6xxx_port_read(chip, port, MV88E6XXX_PORT_STS, &reg);
+	if (err) {
+		dev_err(chip->dev, "p%d: failed to read port status\n", port);
+		return;
+	}
+
+	switch (reg & MV88E6250_PORT_STS_PORTMODE_MASK) {
+	case MV88E6250_PORT_STS_PORTMODE_MII_10_HALF_PHY:
+	case MV88E6250_PORT_STS_PORTMODE_MII_100_HALF_PHY:
+	case MV88E6250_PORT_STS_PORTMODE_MII_10_FULL_PHY:
+	case MV88E6250_PORT_STS_PORTMODE_MII_100_FULL_PHY:
+		__set_bit(PHY_INTERFACE_MODE_REVMII, supported);
+		break;
+
+	case MV88E6250_PORT_STS_PORTMODE_MII_HALF:
+	case MV88E6250_PORT_STS_PORTMODE_MII_FULL:
+		__set_bit(PHY_INTERFACE_MODE_MII, supported);
+		break;
+
+	case MV88E6250_PORT_STS_PORTMODE_MII_DUAL_100_RMII_FULL_PHY:
+	case MV88E6250_PORT_STS_PORTMODE_MII_200_RMII_FULL_PHY:
+	case MV88E6250_PORT_STS_PORTMODE_MII_10_100_RMII_HALF_PHY:
+	case MV88E6250_PORT_STS_PORTMODE_MII_10_100_RMII_FULL_PHY:
+		__set_bit(PHY_INTERFACE_MODE_REVRMII, supported);
+		break;
+
+	case MV88E6250_PORT_STS_PORTMODE_MII_DUAL_100_RMII_FULL:
+	case MV88E6250_PORT_STS_PORTMODE_MII_10_100_RMII_FULL:
+		__set_bit(PHY_INTERFACE_MODE_RMII, supported);
+		break;
+
+	case MV88E6250_PORT_STS_PORTMODE_MII_100_RGMII:
+		__set_bit(PHY_INTERFACE_MODE_RGMII, supported);
+		break;
+
+	default:
+		dev_err(chip->dev,
+			"p%d: invalid port mode in status register: %04x\n",
+			port, reg);
+	}
+}
+
+static void mv88e6250_phylink_get_caps(struct mv88e6xxx_chip *chip, int port,
+				       struct phylink_config *config)
+{
+	if (!mv88e6xxx_phy_is_internal(chip, port))
+		mv88e6250_setup_supported_interfaces(chip, port, config);
 
 	config->mac_capabilities = MAC_SYM_PAUSE | MAC_10 | MAC_100;
 }
diff --git a/drivers/net/dsa/mv88e6xxx/port.h b/drivers/net/dsa/mv88e6xxx/port.h
index 86deeb347cbc1..ddadeb9bfdaee 100644
--- a/drivers/net/dsa/mv88e6xxx/port.h
+++ b/drivers/net/dsa/mv88e6xxx/port.h
@@ -25,10 +25,25 @@
 #define MV88E6250_PORT_STS_PORTMODE_PHY_100_HALF	0x0900
 #define MV88E6250_PORT_STS_PORTMODE_PHY_10_FULL		0x0a00
 #define MV88E6250_PORT_STS_PORTMODE_PHY_100_FULL	0x0b00
-#define MV88E6250_PORT_STS_PORTMODE_MII_10_HALF		0x0c00
-#define MV88E6250_PORT_STS_PORTMODE_MII_100_HALF	0x0d00
-#define MV88E6250_PORT_STS_PORTMODE_MII_10_FULL		0x0e00
-#define MV88E6250_PORT_STS_PORTMODE_MII_100_FULL	0x0f00
+/* - Modes with PHY suffix use output instead of input clock
+ * - Modes without RMII or RGMII use MII
+ * - Modes without speed do not have a fixed speed specified in the manual
+ *   ("DC to x MHz" - variable clock support?)
+ */
+#define MV88E6250_PORT_STS_PORTMODE_MII_DISABLED		0x0000
+#define MV88E6250_PORT_STS_PORTMODE_MII_100_RGMII		0x0100
+#define MV88E6250_PORT_STS_PORTMODE_MII_DUAL_100_RMII_FULL_PHY	0x0200
+#define MV88E6250_PORT_STS_PORTMODE_MII_200_RMII_FULL_PHY	0x0400
+#define MV88E6250_PORT_STS_PORTMODE_MII_DUAL_100_RMII_FULL	0x0600
+#define MV88E6250_PORT_STS_PORTMODE_MII_10_100_RMII_FULL	0x0700
+#define MV88E6250_PORT_STS_PORTMODE_MII_HALF			0x0800
+#define MV88E6250_PORT_STS_PORTMODE_MII_10_100_RMII_HALF_PHY	0x0900
+#define MV88E6250_PORT_STS_PORTMODE_MII_FULL			0x0a00
+#define MV88E6250_PORT_STS_PORTMODE_MII_10_100_RMII_FULL_PHY	0x0b00
+#define MV88E6250_PORT_STS_PORTMODE_MII_10_HALF_PHY		0x0c00
+#define MV88E6250_PORT_STS_PORTMODE_MII_100_HALF_PHY		0x0d00
+#define MV88E6250_PORT_STS_PORTMODE_MII_10_FULL_PHY		0x0e00
+#define MV88E6250_PORT_STS_PORTMODE_MII_100_FULL_PHY		0x0f00
 #define MV88E6XXX_PORT_STS_LINK			0x0800
 #define MV88E6XXX_PORT_STS_DUPLEX		0x0400
 #define MV88E6XXX_PORT_STS_SPEED_MASK		0x0300
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/


