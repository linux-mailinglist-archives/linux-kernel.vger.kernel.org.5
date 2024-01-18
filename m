Return-Path: <linux-kernel+bounces-30012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C368316D2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 11:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C898B1C221E0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 10:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AB323746;
	Thu, 18 Jan 2024 10:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b="jweTdpNd"
Received: from mail.systec-electronic.com (mail.systec-electronic.com [77.220.239.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6218022F06;
	Thu, 18 Jan 2024 10:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.220.239.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705575022; cv=none; b=uePK3Mg5xV6eRNlUYBMi1bqFR9C5VFBC6pLfmBDqHu+9rB+UudS+cwEQMx45l+YSeNI255IKJtlydtymN4hJOk4p9j0G9l1K3uDmY17KPloki20Ri5wQZ7J9NcvpvGwJ4/bWhai8Q0tUUWLqPVgTzQUdtGWEr5cLlSqo5fACyqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705575022; c=relaxed/simple;
	bh=hDDXvdoNu8vOBXyjictCiicouiBYP0yBck+Nijapc7A=;
	h=Received:Received:Received:DKIM-Filter:DKIM-Signature:
	 X-Virus-Scanned:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding; b=kTc/bUcpr5BBREXWoSNSZkHkIt6CwWiEMhA88OmVuBYdNIyWm0Av6aVMHsEtUHDrhLX/Sv0tDV6iQca/oC5OY+eDniuIQ+LzWrxZUTEv7H0vo5r3z+aN+igEnG0XOentxXCDG38id6EDkEMEaJpIEgePR7TRXQCtnW8eOSUqEKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=systec-electronic.com; spf=pass smtp.mailfrom=systec-electronic.com; dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b=jweTdpNd; arc=none smtp.client-ip=77.220.239.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=systec-electronic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=systec-electronic.com
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id 0935B9400107;
	Thu, 18 Jan 2024 11:43:46 +0100 (CET)
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id kmPasBcjk7Jn; Thu, 18 Jan 2024 11:43:45 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id D50E0941A5CF;
	Thu, 18 Jan 2024 11:43:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.systec-electronic.com D50E0941A5CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=systec-electronic.com; s=B34D3B04-5DC7-11EE-83E3-4D8CAB78E8CD;
	t=1705574625; bh=WxeGf6vaj1r+8COYX0/cdjukb0tx7B8JYxC+WAtqHa0=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=jweTdpNdDn+ajwP/fyZNxaw16T2I+A0f+HsXVCiLa0RmlDN5BV7ZKJJEojjIdF2i/
	 3h9eSv7UAOOQmPSeCmz37EClt4Urbt8H/JKY8cLjL6+yxMuzBZ1aVXG+ZZ0cdgC7X+
	 HvX0n+m0UtTlSq17Jb3IpZUUDWGFv+TnVmXdZRf+b7XCXvkN9EoYRRfsACnVJoIaUV
	 +nblJVNJQ6QxuQ1GR0yt4WV0E4fjY8b279Gpfe1CYOSX4yUV0AuZ7pMpycUFf3adN0
	 t5xsOZ8fzm/GJIPl8CB56tTlmm39Q8QzY+93gLz99AT68jFU6J+mVbB6JyObmCqyw0
	 kgSv2fffF1GYQ==
X-Virus-Scanned: amavis at systec-electronic.com
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id km2frKiTSdy9; Thu, 18 Jan 2024 11:43:45 +0100 (CET)
Received: from ws-565760.systec.local (unknown [212.185.67.148])
	by mail.systec-electronic.com (Postfix) with ESMTPSA id 822909400107;
	Thu, 18 Jan 2024 11:43:45 +0100 (CET)
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
Subject: [PATCH] net: phy: adin1100: Fix nullptr exception for phy interrupts
Date: Thu, 18 Jan 2024 11:43:41 +0100
Message-ID: <20240118104341.10832-1-andre.werner@systec-electronic.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If using ADIN1100 as an external phy, e.g. in combination with
"smsc95xx", we ran into nullptr exception by creating a link.

In our case the "smsc95xx" does not check for an available interrupt hand=
ler
on external phy driver to use poll instead of interrupts if no handler is
available. So we decide to implement a small handler in the phy driver
to support other MACs as well.

I update the driver to add an interrupt handler because libphy
does not check if their is a interrupt handler available either.

There are several interrupts maskable at the phy, but only link change in=
terrupts
are handled by the driver yet.

We tested the combination "smsc95xx" and "adin1100" with Linux Kernel 6.6=
9
and Linux Kernel 6.1.0, respectively.

Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
---
 drivers/net/phy/adin1100.c | 58 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/net/phy/adin1100.c b/drivers/net/phy/adin1100.c
index 7619d6185801..ed8a7e6250cf 100644
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
@@ -136,6 +142,56 @@ static int adin_config_aneg(struct phy_device *phyde=
v)
 	return genphy_c45_config_aneg(phydev);
 }
=20
+static int adin_phy_ack_intr(struct phy_device *phydev)
+{
+	/* Clear pending interrupts */
+	int rc =3D phy_read_mmd(phydev, MDIO_MMD_VEND2, ADIN_PHY_SUBSYS_IRQ_STA=
TUS);
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
+	regval =3D phy_read_mmd(phydev, MDIO_MMD_VEND2, ADIN_PHY_SUBSYS_IRQ_MAS=
K);
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
+	irq_status =3D phy_read_mmd(phydev, MDIO_MMD_VEND2, ADIN_PHY_SUBSYS_IRQ=
_STATUS);
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
@@ -275,6 +331,8 @@ static struct phy_driver adin_driver[] =3D {
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


