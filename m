Return-Path: <linux-kernel+bounces-147157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 486FB8A7036
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF7831F22C06
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473B613174B;
	Tue, 16 Apr 2024 15:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="EX0isN24";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="hKs61Q4c"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B341311AF;
	Tue, 16 Apr 2024 15:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713282694; cv=none; b=SOALQywGkiYlwTmtazWwiHiC7uYyq78vmIhJaRWeXHC2zk//E8cOEZT4DQXRsXTu0EimWBmZRQkmOgMhe2XfSwCYX3wKv5SeitoFQy4AfL1xADvbDTwTTZoSGExWtBWCXE+cDgcC7n6Mn9/nUD0IqrrQP/uYfscXWf3tZ5BAf+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713282694; c=relaxed/simple;
	bh=5oTLXSg9VThA0XmuLIPgX+kAVJpFfEndfwdGLIxq7u8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JgY4b+t5RbghQQTmuHwcIU4Xvxy5eq/4Ww7Y23en6hWr0rU0RG3OtI+INmiJdoP7N7frbyyAeag2CLABQ9egAdqiChaOS5bFMYnu9e8GogVGL2kpd6RxffEDakGNVhKFDs6MCVyyc2YdgqOFDL3/pjl3gHccdhW5NjldDOyUJuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=EX0isN24; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=hKs61Q4c reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1713282690; x=1744818690;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ValPnQMCccu24ZWqvid4D2T9VS9AWOgVRjH4jCPZzCg=;
  b=EX0isN244pQr3uFeIflEiU0AVQCb3YJZVQeSHz/F2PXaSy30UgNuIlvI
   jqyTXjeXsNB857TuY0wbwtr4KeuzfK5xWMXPWBsCbqgGGbcw7iJhX8gN5
   7/uvI15GoPKGolht5iddCR9RD4B65yL9o1ouImr0o35T5/HhaihGzyH2G
   5w5RsDbrQ8tty/z4Fre9TOxnIbmwZyh++iy+Bjy5NBaN41xPvPR6IHYmo
   vAsodIHtku8mWxdtmAFwf3o/E37Ibb3EVDc2VN27EfUJBQnRU9rc4v8ve
   xyG5ut6+ho5b7fj97Eox8GKRnUoptsFLjZSFFIIhRb0/HvtTQ0GN13Srs
   Q==;
X-IronPort-AV: E=Sophos;i="6.07,206,1708383600"; 
   d="scan'208";a="36448115"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 16 Apr 2024 17:51:27 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9698A16FB53;
	Tue, 16 Apr 2024 17:51:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1713282683;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=ValPnQMCccu24ZWqvid4D2T9VS9AWOgVRjH4jCPZzCg=;
	b=hKs61Q4cXTorjWWyPQKyrm8TsJD8EmMXOEEn0PpjKRD6xRHJ0/AKWO1gmvD0P2ePPIoDXR
	i5R9Vk+OlxGN15UlR0sl0BsIiGkLnaZbPo36xRvI/GT4SPCs3MEsDuI9G7X33DDSI1bzoW
	uI+flvknnSNIC2uKmt4tA4KTl8MLxwhaNnR8xw0sg0IvLGFlSPu+3pmlM6POaV70B6uonU
	F9fpXXc/QI4zTZVDPgHwC6Rk43l/eJzZXcVF1QEzQl/SypFjo5Ho+9hsUXiAU8MR38oxkS
	TKV0gdJMxMLK7qXrk6N94eP4Mbzpp8F/NFzrxLdcmnIdwH7JPjMTyaCh9FQK4A==
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
Subject: [PATCH net] net: dsa: mv88e6xx: fix supported_interfaces setup in mv88e6250_phylink_get_caps()
Date: Tue, 16 Apr 2024 17:50:54 +0200
Message-ID: <20240416155054.3650354-1-matthias.schiffer@ew.tq-group.com>
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
mv88e6250_port_get_mode() that is called directly from
mv88e6250_phylink_get_caps().

Fixes: de5c9bf40c45 ("net: phylink: require supported_interfaces to be filled")
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 11 +++++--
 drivers/net/dsa/mv88e6xxx/port.c | 51 ++++++++++++++++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/port.h | 25 +++++++++++++---
 3 files changed, 81 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index c95787cb90867..76040b63a5c33 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -570,9 +570,16 @@ static void mv88e6250_phylink_get_caps(struct mv88e6xxx_chip *chip, int port,
 				       struct phylink_config *config)
 {
 	unsigned long *supported = config->supported_interfaces;
+	phy_interface_t mode;
+	int err;
 
-	/* Translate the default cmode */
-	mv88e6xxx_translate_cmode(chip->ports[port].cmode, supported);
+	err = mv88e6250_port_get_mode(chip, port, &mode);
+	if (err) {
+		dev_err(chip->dev, "p%d: failed to get port mode\n", port);
+		return;
+	}
+
+	__set_bit(mode, supported);
 
 	config->mac_capabilities = MAC_SYM_PAUSE | MAC_10 | MAC_100;
 }
diff --git a/drivers/net/dsa/mv88e6xxx/port.c b/drivers/net/dsa/mv88e6xxx/port.c
index 5394a8cf7bf1d..d58060e94250e 100644
--- a/drivers/net/dsa/mv88e6xxx/port.c
+++ b/drivers/net/dsa/mv88e6xxx/port.c
@@ -740,6 +740,57 @@ int mv88e6352_port_get_cmode(struct mv88e6xxx_chip *chip, int port, u8 *cmode)
 	return 0;
 }
 
+int mv88e6250_port_get_mode(struct mv88e6xxx_chip *chip, int port,
+			    phy_interface_t *mode)
+{
+	int err;
+	u16 reg;
+
+	if (port < 5) {
+		*mode = PHY_INTERFACE_MODE_INTERNAL;
+		return 0;
+	}
+
+	err = mv88e6xxx_port_read(chip, port, MV88E6XXX_PORT_STS, &reg);
+	if (err)
+		return err;
+
+	switch (reg & MV88E6250_PORT_STS_PORTMODE_MASK) {
+	case MV88E6250_PORT_STS_PORTMODE_MII_10_HALF_PHY:
+	case MV88E6250_PORT_STS_PORTMODE_MII_100_HALF_PHY:
+	case MV88E6250_PORT_STS_PORTMODE_MII_10_FULL_PHY:
+	case MV88E6250_PORT_STS_PORTMODE_MII_100_FULL_PHY:
+		*mode = PHY_INTERFACE_MODE_REVMII;
+		break;
+
+	case MV88E6250_PORT_STS_PORTMODE_MII_HALF:
+	case MV88E6250_PORT_STS_PORTMODE_MII_FULL:
+		*mode = PHY_INTERFACE_MODE_MII;
+		break;
+
+	case MV88E6250_PORT_STS_PORTMODE_MII_DUAL_100_RMII_FULL_PHY:
+	case MV88E6250_PORT_STS_PORTMODE_MII_200_RMII_FULL_PHY:
+	case MV88E6250_PORT_STS_PORTMODE_MII_10_100_RMII_HALF_PHY:
+	case MV88E6250_PORT_STS_PORTMODE_MII_10_100_RMII_FULL_PHY:
+		*mode = PHY_INTERFACE_MODE_REVRMII;
+		break;
+
+	case MV88E6250_PORT_STS_PORTMODE_MII_DUAL_100_RMII_FULL:
+	case MV88E6250_PORT_STS_PORTMODE_MII_10_100_RMII_FULL:
+		*mode = PHY_INTERFACE_MODE_RMII;
+		break;
+
+	case MV88E6250_PORT_STS_PORTMODE_MII_100_RGMII:
+		*mode = PHY_INTERFACE_MODE_RGMII;
+		break;
+
+	default:
+		*mode = PHY_INTERFACE_MODE_NA;
+	}
+
+	return 0;
+}
+
 /* Offset 0x02: Jamming Control
  *
  * Do not limit the period of time that this port can be paused for by
diff --git a/drivers/net/dsa/mv88e6xxx/port.h b/drivers/net/dsa/mv88e6xxx/port.h
index 86deeb347cbc1..43d69c8f74a8b 100644
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
@@ -442,6 +457,8 @@ int mv88e6393x_port_set_cmode(struct mv88e6xxx_chip *chip, int port,
 			      phy_interface_t mode);
 int mv88e6185_port_get_cmode(struct mv88e6xxx_chip *chip, int port, u8 *cmode);
 int mv88e6352_port_get_cmode(struct mv88e6xxx_chip *chip, int port, u8 *cmode);
+int mv88e6250_port_get_mode(struct mv88e6xxx_chip *chip, int port,
+			    phy_interface_t *mode);
 int mv88e6xxx_port_drop_untagged(struct mv88e6xxx_chip *chip, int port,
 				 bool drop_untagged);
 int mv88e6xxx_port_set_map_da(struct mv88e6xxx_chip *chip, int port, bool map);
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/


