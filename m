Return-Path: <linux-kernel+bounces-30831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA288324CB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 07:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BC94B229D8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 06:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BB1D2E0;
	Fri, 19 Jan 2024 06:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b="iM314C9W"
Received: from mail.systec-electronic.com (mail.systec-electronic.com [77.220.239.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37A6184E;
	Fri, 19 Jan 2024 06:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.220.239.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705647358; cv=none; b=Rsbm4lV0ZKtCxkCpZRC4i3w3nUogEkaX1t6wSvXbRBgL00F95TN1ZAvgbjjAxlEqeBgwkO/f83lxyFpTVhGpHCz0wpJakY6nUFFdZsHtZLQbE8owDwS9wRho1+fpqspEyUhSOyZ7i3TJhKsY505fXV7fMrGpJuQu58JJVBIhgjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705647358; c=relaxed/simple;
	bh=fzZ9PqYrfw2bV7Rfs2G/n0BHJjQaonVjoKgOKh5vznc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F0tAFVSkwtjziy0J5GR/R8prgUR5k+XMF10kFkQQFEuFhGZy0FYf+6dTsG5SXZW0/RjCjLobbZ41NxuN2ws1bEZEP//l9x9JivMR6hR44ri2sW7qE+8q/6m/j8ppvN4wSMAqpzhg2YHkL6X3FNX7NVtyCDBQ2GwYa4QyGCO24fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=systec-electronic.com; spf=pass smtp.mailfrom=systec-electronic.com; dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b=iM314C9W; arc=none smtp.client-ip=77.220.239.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=systec-electronic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=systec-electronic.com
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id 01CCF940010D;
	Fri, 19 Jan 2024 07:55:55 +0100 (CET)
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id Q8OpYxjlMZbe; Fri, 19 Jan 2024 07:55:54 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id BDA089400115;
	Fri, 19 Jan 2024 07:55:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.systec-electronic.com BDA089400115
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=systec-electronic.com; s=B34D3B04-5DC7-11EE-83E3-4D8CAB78E8CD;
	t=1705647354; bh=R2H+wxpHRJ7ij8BQv9/AjquxQAEYGY9PEXxh3X7nW18=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=iM314C9WPLk/qprc7zek/T3vwG/ee4kK4VD4Q7avuTkfBvoHAFhH+3OSGE3ttQGxh
	 zPj3QEh0pcNeBs5GUmVAO5lQff7Idtq+5Kv40kb5GFhJxsV5cDYh396OCgA8Ju8j1v
	 UnJPVK9Qq4/L6reEqVhyd4SvbRVwMubpnZI0nfjWpxUqPGvtIzMel3587UzK6m12yY
	 XmYAe033xaLMPNSAPRk+c5bdhtRecjEoPhC/2M0AhN+kJNEk4M8zUDHTZKEkjQ52uT
	 d5XqJKhxMnKX4k9VpumoG3cRYsdfTcfGaDPQxrnt237MtZP6lASbQ+gzsmLsbyA4Zc
	 x9bNEfRTSqzPg==
X-Virus-Scanned: amavis at systec-electronic.com
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id XjM1_v4EJDbj; Fri, 19 Jan 2024 07:55:54 +0100 (CET)
Received: from ws-565760.systec.local (unknown [212.185.67.148])
	by mail.systec-electronic.com (Postfix) with ESMTPSA id 724CF940010D;
	Fri, 19 Jan 2024 07:55:54 +0100 (CET)
From: Andre Werner <andre.werner@systec-electronic.com>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andre Werner <andre.werner@systec-electronic.com>
Subject: [RFC net-next v2 2/2] net: phy: adin1100: Add interrupt support for link change
Date: Fri, 19 Jan 2024 07:51:14 +0100
Message-ID: <20240119065542.30279-2-andre.werner@systec-electronic.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240119065542.30279-1-andre.werner@systec-electronic.com>
References: <20240119065542.30279-1-andre.werner@systec-electronic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

An interrupt handler was added to the driver as well as functions
to enable interrupts at the phy.

There are several interrupts maskable at the phy, but only link change
interrupts are handled by the driver yet.

Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
---
v2:
- Clean format and reword commit message as suggested by reviewer of
  first patch submission
---
 drivers/net/phy/adin1100.c | 61 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/net/phy/adin1100.c b/drivers/net/phy/adin1100.c
index 7619d6185801..fb1146cf881a 100644
--- a/drivers/net/phy/adin1100.c
+++ b/drivers/net/phy/adin1100.c
@@ -18,6 +18,12 @@
 #define PHY_ID_ADIN1110				0x0283bc91
 #define PHY_ID_ADIN2111				0x0283bca1
=20
+#define ADIN_PHY_SUBSYS_IRQ_MASK		0x0021
+#define   ADIN_LINK_STAT_CHNG_IRQ_EN		BIT(1)
+
+#define ADIN_PHY_SUBSYS_IRQ_STATUS		0x0011
+#define   ADIN_LINK_STAT_CHNG			BIT(1)
+
 #define ADIN_FORCED_MODE			0x8000
 #define   ADIN_FORCED_MODE_EN			BIT(0)
=20
@@ -136,6 +142,59 @@ static int adin_config_aneg(struct phy_device *phyde=
v)
 	return genphy_c45_config_aneg(phydev);
 }
=20
+static int adin_phy_ack_intr(struct phy_device *phydev)
+{
+	/* Clear pending interrupts */
+	int rc =3D phy_read_mmd(phydev, MDIO_MMD_VEND2,
+			      ADIN_PHY_SUBSYS_IRQ_STATUS);
+
+	return rc < 0 ? rc : 0;
+}
+
+static int adin_config_intr(struct phy_device *phydev)
+{
+	int ret, regval;
+
+	ret =3D adin_phy_ack_intr(phydev);
+
+	if (ret)
+		return ret;
+
+	regval =3D phy_read_mmd(phydev, MDIO_MMD_VEND2,
+			      ADIN_PHY_SUBSYS_IRQ_MASK);
+	if (regval < 0)
+		return regval;
+
+	if (phydev->interrupts =3D=3D PHY_INTERRUPT_ENABLED)
+		regval |=3D ADIN_LINK_STAT_CHNG_IRQ_EN;
+	else
+		regval &=3D ~ADIN_LINK_STAT_CHNG_IRQ_EN;
+
+	ret =3D phy_write_mmd(phydev, MDIO_MMD_VEND2,
+			    ADIN_PHY_SUBSYS_IRQ_MASK,
+			    regval);
+	return ret;
+}
+
+static irqreturn_t adin_phy_handle_interrupt(struct phy_device *phydev)
+{
+	int irq_status;
+
+	irq_status =3D phy_read_mmd(phydev, MDIO_MMD_VEND2,
+			          ADIN_PHY_SUBSYS_IRQ_STATUS);
+	if (irq_status < 0) {
+		phy_error(phydev);
+		return IRQ_NONE;
+	}
+
+	if (!(irq_status & ADIN_LINK_STAT_CHNG))
+		return IRQ_NONE;
+
+	phy_trigger_machine(phydev);
+
+	return IRQ_HANDLED;
+}
+
 static int adin_set_powerdown_mode(struct phy_device *phydev, bool en)
 {
 	int ret;
@@ -275,6 +334,8 @@ static struct phy_driver adin_driver[] =3D {
 		.probe			=3D adin_probe,
 		.config_aneg		=3D adin_config_aneg,
 		.read_status		=3D adin_read_status,
+		.config_intr		=3D adin_config_intr,
+		.handle_interrupt	=3D adin_phy_handle_interrupt,
 		.set_loopback		=3D adin_set_loopback,
 		.suspend		=3D adin_suspend,
 		.resume			=3D adin_resume,
--=20
2.43.0


