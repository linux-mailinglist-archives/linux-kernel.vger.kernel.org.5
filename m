Return-Path: <linux-kernel+bounces-34187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE797837556
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 22:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E74B28827F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3CB4B5AA;
	Mon, 22 Jan 2024 21:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KkyEDavk"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A3C4A9AA;
	Mon, 22 Jan 2024 21:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705958991; cv=none; b=mLiDWe6adf4u5qxH0/xg306XrHip51j6AJDTmVR3Da45xDG/0QOSiKrp5pXTbfCMtbFgiwNaa73u2b0obNKjeVYBmxT2bSvdnA7fGsH+4CLKsUyhAFXNi4D5w9v8mN5WRnr4OscgXIP8JA2fF6latUx1Jwgrbfl2XOwIbvFjoYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705958991; c=relaxed/simple;
	bh=empQ3LvAwMaJ7DP+J7cSMWEuZ1rtZVbVlJMnfV1nn4E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oCob3hkeasWMJSXDPwKis0O4Wb+6myVh1wuYabPa7Jaaiq5uIQfim9LJtIDWXgqmrXSEseybAU8H5Ahw0VfaGTV8L6EOr2mpYTOc6clnY+ezKy5POXKnNiUrHkZmOzFTUYmh6/36A4LXiBAJ0GwvGl0b7qpGoD1UEjmLm5jWamM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KkyEDavk; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a29c4bbb2f4so344062366b.1;
        Mon, 22 Jan 2024 13:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705958988; x=1706563788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pq7F2QXM+Z3rbkxOOhdRgWEWlMLJsaG+hMpsyBwHh1o=;
        b=KkyEDavknb1EQLMhMJfJLqUF+BLSkUIvju5xp6wmzR60BAwBFE2du7fgk6cSsT1zgZ
         6XLs9McqZPAFDWYLKVIVu+w7dNv5pFs/wDysqmDMgOEPkrEKGndt6nGs4YvZbCjrZNr0
         52dnVwNGm2YJZ1/gVHUnQ6Co9nPzMxXBm+1IBnpWfAyqUDltiRATRgJwYwpgaswFY+4h
         Eh2PqrpYHzLXn4wXMh8lL4FVvGHYAEfpIZZwSL4X0jZzHrZ40sAjjVlykX7+QUdIsctB
         7LVVrgLsCuFUpYrEX1ZQE916jytRT6w+x5tAP1Ygib92Eh0W2Y9/N8jrLwYoe4tKwghM
         UmJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705958988; x=1706563788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pq7F2QXM+Z3rbkxOOhdRgWEWlMLJsaG+hMpsyBwHh1o=;
        b=OvOwQL5krTr1yN9bf5Ior/XBN27gQVjR6dpMjj0FZd5RpHywnMBZaiAmEpGKFluE7R
         LWAGjNKYT72xX0J6runTNCAbImejLqK/Ps2Z8NCpbv2Uh08HsXGpJmwNalMHyQ4SJhNE
         iXibCM1fJES8z2Q5Iz9nTjysZi66BK1M3ExKjaElRkLLxgiLB2dFOx6Nf/4uc6oJPekG
         zje3lHZPK6bIOh8JmRdj7oopBR8ogz4y+g+wZRUqnx3eFRTxVVAHvdSofptYfeFv7cK+
         3nHBCM45hECjdJUG5K7H5OSN39Gz/c3juy7BglM5TFpmo/ZC1vZdLzBgxEXTRCLL8hg3
         YDmg==
X-Gm-Message-State: AOJu0YxjZiC/gTwd1wj1RaYUIe33U9l2hUVNgxTXPe7Yhuhl7uvi8+Kn
	G7SN1ch7jvsu0X/Qizw9Wrg42XNV/22lc02ZuM2R4BBvh+whguyJ
X-Google-Smtp-Source: AGHT+IG5lbFSWmSJLtA3/pHYR37+yxVvYkDCrVJHw/dmfbDMRNj00ahYu0dQ9sAWfK77xIs6+kY+9g==
X-Received: by 2002:a17:907:970a:b0:a30:4251:ec7 with SMTP id jg10-20020a170907970a00b00a3042510ec7mr1452060ejc.138.1705958987938;
        Mon, 22 Jan 2024 13:29:47 -0800 (PST)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id j25-20020a1709066dd900b00a26af4d96c6sm13823336ejt.4.2024.01.22.13.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 13:29:47 -0800 (PST)
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
Subject: [PATCH v5 net-next 06/13] net: phy: marvell-88q2xxx: add interrupt support for link detection
Date: Mon, 22 Jan 2024 22:28:39 +0100
Message-Id: <20240122212848.3645785-7-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240122212848.3645785-1-dima.fedrau@gmail.com>
References: <20240122212848.3645785-1-dima.fedrau@gmail.com>
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

Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 drivers/net/phy/marvell-88q2xxx.c | 123 +++++++++++++++++++++++++++++-
 1 file changed, 119 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
index 637ef4821e35..635827b4a692 100644
--- a/drivers/net/phy/marvell-88q2xxx.c
+++ b/drivers/net/phy/marvell-88q2xxx.c
@@ -20,6 +20,19 @@
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
@@ -34,6 +47,12 @@
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
@@ -95,13 +114,15 @@ static int mv88q2xxx_read_link_gbit(struct phy_device *phydev)
 
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
@@ -141,7 +162,18 @@ static int mv88q2xxx_read_link_100m(struct phy_device *phydev)
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
@@ -352,6 +384,79 @@ static int mv88q2xxx_get_sqi_max(struct phy_device *phydev)
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
@@ -418,6 +523,14 @@ static int mv88q222x_revb0_config_init(struct phy_device *phydev)
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
 
@@ -444,6 +557,8 @@ static struct phy_driver mv88q2xxx_driver[] = {
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


