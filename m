Return-Path: <linux-kernel+bounces-30957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8908326CD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57F961C22F81
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 09:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30AEA3C47B;
	Fri, 19 Jan 2024 09:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b="ic+Y+WSh"
Received: from mail.systec-electronic.com (mail.systec-electronic.com [77.220.239.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1EC3C064;
	Fri, 19 Jan 2024 09:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.220.239.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705656914; cv=none; b=dsYClYp1/hpMz96YiDgFfklulg7v2W0UxXJ/UjeJmEtGk8SpHJ+JzleYmKINNNH4dKJmYiyBoEY76tSqksF2wOn6daSn1/HUQHmsVHdzRkgKH7ERDtX7qf68vxD3KADqAuXaGahWOqzy0vensfJeZJZXQBnclqVfUmkouB8gDjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705656914; c=relaxed/simple;
	bh=bSZg78YFLl5BAM4tDcveDpHKCzqi35Xitbywtzj/TzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bxc6nCS5/dU8WQPEivSA3VOVWch9gJ9qrXmH5FKXLlNmPXY9fqJSD9D8/UZ/Fv+riqb0rzC7mjn5gcwzQjCPCFFvD27y/W/uHEUiJvUecanT8GJqxi4vbJ+vl/54WK4LILcdveTFx699j0bpvAXeDJQIoYEQpNKEnFU3zagsi2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=systec-electronic.com; spf=pass smtp.mailfrom=systec-electronic.com; dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b=ic+Y+WSh; arc=none smtp.client-ip=77.220.239.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=systec-electronic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=systec-electronic.com
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id 60C9B940010D;
	Fri, 19 Jan 2024 10:35:07 +0100 (CET)
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id BqlB-VJgbLlM; Fri, 19 Jan 2024 10:35:07 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id 374269400115;
	Fri, 19 Jan 2024 10:35:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.systec-electronic.com 374269400115
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=systec-electronic.com; s=B34D3B04-5DC7-11EE-83E3-4D8CAB78E8CD;
	t=1705656907; bh=MTKWH6m4my9WXHOKN9l10Su/eSbqGp9VEHgcHaprZdI=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=ic+Y+WSh3a6qyxugTBTDCRUWeMFXox7Nyf4qJ0JAWApiwd4e5cWhQiNNSwbqWAJgc
	 O3tUWLS6RTIoM9i0qFk6Nu6jnGzLwN6LzGJl5iQZoHLiRh3dBCDBJX/n4IPOvsQHgi
	 N18ilCmBVaywNWn1xV6+i3WeOIOt7PojhCf5xP0JsC4S3Nqkx1RAk2aWIcHQx+2Wu6
	 fHX7wPNe7/7sntYrtrBwc6pKmxT+MabBdoIvl9eOMsL796leM3PRquQRdwwa0FDO+V
	 yhBmSbM8a+2wjsWB4xvGdnQkQfmNRDLmB3V9NEcEg1XqkDToA6Wp6sOoDVCIugkuwd
	 IeYSnKKETVdPw==
X-Virus-Scanned: amavis at systec-electronic.com
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id hfwp1lJeY7RI; Fri, 19 Jan 2024 10:35:07 +0100 (CET)
Received: from ws-565760.systec.local (unknown [212.185.67.148])
	by mail.systec-electronic.com (Postfix) with ESMTPSA id D3D6B940010D;
	Fri, 19 Jan 2024 10:35:06 +0100 (CET)
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
Subject: [RFC net-next v3 2/2] net: phy: adin1100: Add interrupt support for link change
Date: Fri, 19 Jan 2024 10:32:26 +0100
Message-ID: <20240119093503.6370-2-andre.werner@systec-electronic.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240119093503.6370-1-andre.werner@systec-electronic.com>
References: <20240119093503.6370-1-andre.werner@systec-electronic.com>
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
v3:
- Correct rashly format error that was reported by checker.
---
 drivers/net/phy/adin1100.c | 61 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/net/phy/adin1100.c b/drivers/net/phy/adin1100.c
index 7619d6185801..32700b44e486 100644
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
+				  ADIN_PHY_SUBSYS_IRQ_STATUS);
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


