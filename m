Return-Path: <linux-kernel+bounces-64358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5C7853D70
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 339CAB2A23B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09943633FF;
	Tue, 13 Feb 2024 21:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXtoKxsV"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5106313F;
	Tue, 13 Feb 2024 21:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707860432; cv=none; b=eLrQrcIF4NoqAqL9CGYrk5m2OeVr4Rm45UOfVvT8CdWayQJiAi1wC8syeI1wOML+4HxaVhTz27BQ3TUDvBpiuJrCsSac1niWc1SIKP+F2Y2vZ3zouPuA7LFQ77Viw8MX9lVbTV5y8Dku/LeRsLfekUiDt4ekI/6wwUtJ7z1aRWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707860432; c=relaxed/simple;
	bh=APHd53FETp7bMcTra6Q2uekzr3ZPbBpRLKIx89mhIt0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ts8BWz1x3D4xelRtqjFop8WySHkyTIQz6POxht2dcJjDaPgHVpddSb/askCOMCuBNMvt8GrAjLoov50vpAtFXCw0u7Ymtg/Uma/DJrjc21RXibzE/n7RLCiL6u6ilFf+23D1R3F0MfdlxDeybiBSPJ3eKSkIRMo5dvPrQ2AXvzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MXtoKxsV; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5621f7c86c9so381533a12.0;
        Tue, 13 Feb 2024 13:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707860428; x=1708465228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOctRdMaVKvlxxQLiZyj1BX0A6EczB9hIAIpTNelg5c=;
        b=MXtoKxsVpNyhaUpj05lt7yBw+SO27dChph5lKtK0kB/r1h/59C68VzwS6hAY2qWLtR
         gZMMv92UCVd//17klB90YP4m6ww1fFtVMWar48u52fMI2ma24Ft3a3c4sIolgFR6R7Y+
         I+KvqRc1xb3Zux7/hH5N3KkWWOKWBX877jyWCTCaYgWeThAkfDbRmaM63xKCWO+jeq5Q
         iFsUvD9LNEvNNR2GX2R2ItsSEDSJ5bUQIK9aVwdV2H65StoKpsCO+aPONPXoCIhEGSTs
         J5kdYAdlwyDUHCijenRMTZru7D1B5LmJn1gKnbAcEPsA+K3Ujf4nx9FAqEaOq09Wg992
         +QvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707860428; x=1708465228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YOctRdMaVKvlxxQLiZyj1BX0A6EczB9hIAIpTNelg5c=;
        b=ihfHhuEeN524hFkC4PMtOYzCoUA85dGcVW9O7qpSrRtGm4dk9XE10qpAVNKcJJ11wF
         Ie2EA5RWMU+R4Mtj4+uCrUmRYiFf8EPhnbQc5u2u7Lm86+5GVW7lfwSSdoaAzX5QEfYi
         bERDcy2bEYSAnOUvSMElcRWQlh6GyLy958KD4mGfRxkXWLvy5OXJpdKearSDO+KagvFO
         J92qFTZHX08N4n/IF1KCMMcCkU8iil/5RbzyBuWcZ3OE/Aorqm1lHMZ0kyv7NNDZ64wX
         C0FtligZCKizjpg2SalYNpzmueKeq9TYnnD+CuaLJzQBQQoshLN9CElFDmZTOevmQPGm
         jFqA==
X-Forwarded-Encrypted: i=1; AJvYcCW4ldT2ZNE+hXn7IDgPxaS3NrCNk091kT7mmqQPTG2cYeVDviil8F41reEdCHygfkjMqcblEPCGSOm4ZZCkzHNXR7zt0PE62OxoiDS7r4hPdUa4K3+sr7fvp10Mosee5sD0GaUW
X-Gm-Message-State: AOJu0YxKvI6GPA9oGE4h0m6x5Nn77SOsj1rz9DSFhjSYJo5AKjk85qJc
	gEh+M1Vrlk6b7/zV4SosQaie6UgTFdfG7S4m4qWfj5+MUrWvMTIv9KMj0FEb
X-Google-Smtp-Source: AGHT+IEsiw9LiakDKx+HE8gNQekXad/bmbRJ7dPbAItqMXlU9UyC8KM/Eco+tRBt0xQjzvo+Apk0jg==
X-Received: by 2002:aa7:d3cc:0:b0:561:f533:b7bb with SMTP id o12-20020aa7d3cc000000b00561f533b7bbmr70738edr.16.1707860428463;
        Tue, 13 Feb 2024 13:40:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXWjK6YYtbMEeAL+xQdpQymfXAu2FqNMF5xG39c84xiidTC6kOlZM/zJ/oTTzP4cH2FqHm+Y4kucXD9dsnlUmPkwG+ZEf4NPx11wfBs86PiCsTFOT2/wj9DTSrXoNpgOx0S0gn0ihsP9PzCyp/CI4ZLM86hUkj8O8sI6iU0XK19uf25uO/xbU4ASbWzLdWUXK3G5+GhG7wYk+Za6Z8XG9LxA6vyyGQw4NMDhiMwCjFboYVp5j+5Cwl5pI+z1iqkodd9NpabkjU9Yay4ZbhWCcrj8xcJR7kIkYZotEJtV7Qeg22+0YY+PDdUbuUL+aYQ/s2RzkYChtX9ZAGiwW/goNA1IGI=
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id k23-20020a05640212d700b005612987a525sm4003913edx.89.2024.02.13.13.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 13:40:28 -0800 (PST)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: 
Cc: Dimitri Fedrau <dima.fedrau@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Stefan Eichenberger <eichest@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 net-next 06/14] net: phy: marvell-88q2xxx: add interrupt support for link detection
Date: Tue, 13 Feb 2024 22:39:45 +0100
Message-Id: <20240213213955.178762-7-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213213955.178762-1-dima.fedrau@gmail.com>
References: <20240213213955.178762-1-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added .config_intr and .handle_interrupt callbacks. Whenever the link
goes up or down an interrupt will be triggered. Interrupts are configured
separately for 100/1000BASET1.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 drivers/net/phy/marvell-88q2xxx.c | 123 +++++++++++++++++++++++++++++-
 1 file changed, 119 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
index 9829facde253..7c7517af346b 100644
--- a/drivers/net/phy/marvell-88q2xxx.c
+++ b/drivers/net/phy/marvell-88q2xxx.c
@@ -24,6 +24,19 @@
 #define MDIO_MMD_AN_MV_STAT2_100BT1		0x2000
 #define MDIO_MMD_AN_MV_STAT2_1000BT1		0x4000
 
+#define MDIO_MMD_PCS_MV_INT_EN			32784
+#define MDIO_MMD_PCS_MV_INT_EN_LINK_UP		0x0040
+#define MDIO_MMD_PCS_MV_INT_EN_LINK_DOWN	0x0080
+#define MDIO_MMD_PCS_MV_INT_EN_100BT1		0x1000
+
+#define MDIO_MMD_PCS_MV_GPIO_INT_STAT			32785
+#define MDIO_MMD_PCS_MV_GPIO_INT_STAT_LINK_UP		0x0040
+#define MDIO_MMD_PCS_MV_GPIO_INT_STAT_LINK_DOWN		0x0080
+#define MDIO_MMD_PCS_MV_GPIO_INT_STAT_100BT1_GEN	0x1000
+
+#define MDIO_MMD_PCS_MV_GPIO_INT_CTRL			32787
+#define MDIO_MMD_PCS_MV_GPIO_INT_CTRL_TRI_DIS		0x0800
+
 #define MDIO_MMD_PCS_MV_100BT1_STAT1			33032
 #define MDIO_MMD_PCS_MV_100BT1_STAT1_IDLE_ERROR		0x00ff
 #define MDIO_MMD_PCS_MV_100BT1_STAT1_JABBER		0x0100
@@ -38,6 +51,12 @@
 #define MDIO_MMD_PCS_MV_100BT1_STAT2_LINK	0x0004
 #define MDIO_MMD_PCS_MV_100BT1_STAT2_ANGE	0x0008
 
+#define MDIO_MMD_PCS_MV_100BT1_INT_EN			33042
+#define MDIO_MMD_PCS_MV_100BT1_INT_EN_LINKEVENT		0x0400
+
+#define MDIO_MMD_PCS_MV_COPPER_INT_STAT			33043
+#define MDIO_MMD_PCS_MV_COPPER_INT_STAT_LINKEVENT	0x0400
+
 #define MDIO_MMD_PCS_MV_RX_STAT			33328
 
 struct mmd_val {
@@ -99,13 +118,15 @@ static int mv88q2xxx_read_link_gbit(struct phy_device *phydev)
 
 	/* Read vendor specific Auto-Negotiation status register to get local
 	 * and remote receiver status according to software initialization
-	 * guide.
+	 * guide. However, when not in polling mode the local and remote
+	 * receiver status are not evaluated due to the Marvell 88Q2xxx APIs.
 	 */
 	ret = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_MMD_AN_MV_STAT);
 	if (ret < 0) {
 		return ret;
-	} else if ((ret & MDIO_MMD_AN_MV_STAT_LOCAL_RX) &&
-		   (ret & MDIO_MMD_AN_MV_STAT_REMOTE_RX)) {
+	} else if (((ret & MDIO_MMD_AN_MV_STAT_LOCAL_RX) &&
+		   (ret & MDIO_MMD_AN_MV_STAT_REMOTE_RX)) ||
+		   !phy_polling_mode(phydev)) {
 		/* The link state is latched low so that momentary link
 		 * drops can be detected. Do not double-read the status
 		 * in polling mode to detect such short link drops except
@@ -145,7 +166,18 @@ static int mv88q2xxx_read_link_100m(struct phy_device *phydev)
 	 * the link was already down. In case we are not polling,
 	 * we always read the realtime status.
 	 */
-	if (!phy_polling_mode(phydev) || !phydev->link) {
+	if (!phy_polling_mode(phydev)) {
+		phydev->link = false;
+		ret = phy_read_mmd(phydev, MDIO_MMD_PCS,
+				   MDIO_MMD_PCS_MV_100BT1_STAT2);
+		if (ret < 0)
+			return ret;
+
+		if (ret & MDIO_MMD_PCS_MV_100BT1_STAT2_LINK)
+			phydev->link = true;
+
+		return 0;
+	} else if (!phydev->link) {
 		ret = phy_read_mmd(phydev, MDIO_MMD_PCS,
 				   MDIO_MMD_PCS_MV_100BT1_STAT1);
 		if (ret < 0)
@@ -356,6 +388,79 @@ static int mv88q2xxx_get_sqi_max(struct phy_device *phydev)
 	return 15;
 }
 
+static int mv88q2xxx_config_intr(struct phy_device *phydev)
+{
+	int ret;
+
+	if (phydev->interrupts == PHY_INTERRUPT_ENABLED) {
+		/* Enable interrupts for 1000BASE-T1 link up and down events
+		 * and enable general interrupts for 100BASE-T1.
+		 */
+		ret = phy_write_mmd(phydev, MDIO_MMD_PCS,
+				    MDIO_MMD_PCS_MV_INT_EN,
+				    MDIO_MMD_PCS_MV_INT_EN_LINK_UP |
+				    MDIO_MMD_PCS_MV_INT_EN_LINK_DOWN |
+				    MDIO_MMD_PCS_MV_INT_EN_100BT1);
+		if (ret < 0)
+			return ret;
+
+		/* Enable interrupts for 100BASE-T1 link events */
+		return phy_write_mmd(phydev, MDIO_MMD_PCS,
+				     MDIO_MMD_PCS_MV_100BT1_INT_EN,
+				     MDIO_MMD_PCS_MV_100BT1_INT_EN_LINKEVENT);
+	} else {
+		ret = phy_write_mmd(phydev, MDIO_MMD_PCS,
+				    MDIO_MMD_PCS_MV_INT_EN, 0);
+		if (ret < 0)
+			return ret;
+
+		return phy_write_mmd(phydev, MDIO_MMD_PCS,
+				     MDIO_MMD_PCS_MV_100BT1_INT_EN, 0);
+	}
+}
+
+static irqreturn_t mv88q2xxx_handle_interrupt(struct phy_device *phydev)
+{
+	bool trigger_machine = false;
+	int irq;
+
+	/* Before we can acknowledge the 100BT1 general interrupt, that is in
+	 * the 1000BT1 interrupt status register, we have to acknowledge any
+	 * interrupts that are related to it. Therefore we read first the 100BT1
+	 * interrupt status register, followed by reading the 1000BT1 interrupt
+	 * status register.
+	 */
+
+	irq = phy_read_mmd(phydev, MDIO_MMD_PCS,
+			   MDIO_MMD_PCS_MV_COPPER_INT_STAT);
+	if (irq < 0) {
+		phy_error(phydev);
+		return IRQ_NONE;
+	}
+
+	/* Check link status for 100BT1 */
+	if (irq & MDIO_MMD_PCS_MV_COPPER_INT_STAT_LINKEVENT)
+		trigger_machine = true;
+
+	irq = phy_read_mmd(phydev, MDIO_MMD_PCS, MDIO_MMD_PCS_MV_GPIO_INT_STAT);
+	if (irq < 0) {
+		phy_error(phydev);
+		return IRQ_NONE;
+	}
+
+	/* Check link status for 1000BT1 */
+	if ((irq & MDIO_MMD_PCS_MV_GPIO_INT_STAT_LINK_UP) ||
+	    (irq & MDIO_MMD_PCS_MV_GPIO_INT_STAT_LINK_DOWN))
+		trigger_machine = true;
+
+	if (!trigger_machine)
+		return IRQ_NONE;
+
+	phy_trigger_machine(phydev);
+
+	return IRQ_HANDLED;
+}
+
 static int mv88q222x_soft_reset(struct phy_device *phydev)
 {
 	int ret;
@@ -422,6 +527,14 @@ static int mv88q222x_revb0_config_init(struct phy_device *phydev)
 	 */
 	phydev->pma_extable = MDIO_PMA_EXTABLE_BT1;
 
+	/* Configure interrupt with default settings, output is driven low for
+	 * active interrupt and high for inactive.
+	 */
+	if (phy_interrupt_is_valid(phydev))
+		return phy_set_bits_mmd(phydev, MDIO_MMD_PCS,
+					MDIO_MMD_PCS_MV_GPIO_INT_CTRL,
+					MDIO_MMD_PCS_MV_GPIO_INT_CTRL_TRI_DIS);
+
 	return 0;
 }
 
@@ -448,6 +561,8 @@ static struct phy_driver mv88q2xxx_driver[] = {
 		.config_init		= mv88q222x_revb0_config_init,
 		.read_status		= mv88q2xxx_read_status,
 		.soft_reset		= mv88q222x_soft_reset,
+		.config_intr		= mv88q2xxx_config_intr,
+		.handle_interrupt	= mv88q2xxx_handle_interrupt,
 		.set_loopback		= genphy_c45_loopback,
 		.get_sqi		= mv88q2xxx_get_sqi,
 		.get_sqi_max		= mv88q2xxx_get_sqi_max,
-- 
2.39.2


