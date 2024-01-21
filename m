Return-Path: <linux-kernel+bounces-32175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1468357AF
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 21:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 737271F21B1E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 20:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349C938DE4;
	Sun, 21 Jan 2024 20:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b="eRcrZ4Fj"
Received: from mail.systec-electronic.com (mail.systec-electronic.com [77.220.239.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8F538396;
	Sun, 21 Jan 2024 20:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.220.239.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705868127; cv=none; b=iqTXG8NqDrcZjLdNJhy/fQmVYjNc6iHJUIf9VQI9AePE/EkQ68GBpNdHGRImofMhgQSfDShIPJ3w3ebd7KTgSNeBg+qmNtmNBNZMV4s8gDb/a+YBzvGFbKoGzu0qKEGA0a7O5Qu2LTVBd6bDVtuboahDxp0+0ZezEAoRqf+o430=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705868127; c=relaxed/simple;
	bh=DdaAMfAqRKaoKK0URN081uvxzjr0aE5O73JQyc3Qw08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JeYASHo5YUabT3KKpGJbznUjsRcKDCXAgsyalN7/ngegQ1wKv5moh+Rqtvkf+BOwGayTBNMq9P65LdD5AAFXUtD2B18JJhoKQuDsaA7ymQRFEaajs5PguXpsd9XOoEa4lCOXWW+6LpHCT1lv1d6clo7vkR9h/4TCQH18mfLNrxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=systec-electronic.com; spf=pass smtp.mailfrom=systec-electronic.com; dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b=eRcrZ4Fj; arc=none smtp.client-ip=77.220.239.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=systec-electronic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=systec-electronic.com
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id 19AFA9400107;
	Sun, 21 Jan 2024 21:15:16 +0100 (CET)
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id YYmRd1COwZLT; Sun, 21 Jan 2024 21:15:16 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id E7FD9941A5D1;
	Sun, 21 Jan 2024 21:15:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.systec-electronic.com E7FD9941A5D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=systec-electronic.com; s=B34D3B04-5DC7-11EE-83E3-4D8CAB78E8CD;
	t=1705868115; bh=I79RkeIuOJntt4ag+ghEKT/mdW6n3a9EF+d3EcXI4Ps=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=eRcrZ4FjS6XsZnr8ZpUS539S9iKhucY2fzUOmXCLR/Dfyy9Hxyl/a+d/1piE41GeO
	 C+9Jewp/EYruNpRgSaoHF++tJbkYrnC3UAa6j64hbWbM/kttl1h6kOyQn0fi7ly1s4
	 ybnG7uw4kd5ph3vf0X/n2uk3NgnVpoSQU+kkuZqX3f5ZI8SK31kwC1jr7lY+MViJ6o
	 5J12bW5mwYQmw/GwIwHaP1UapPapYVNlFDHA/GrUx6h4T7O+VOifKU1jYDYwSjcjFY
	 xPxV2g13OPHuxVHhMg4tWun+yBFXuXzCWB78jArsxVJ+S8fHZquz1Qv8M/ZMxYBpzJ
	 LQGCZDz/GEeLQ==
X-Virus-Scanned: amavis at systec-electronic.com
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 8APQRCsXv_pK; Sun, 21 Jan 2024 21:15:15 +0100 (CET)
Received: from ws-565760.systec.local (unknown [212.185.67.148])
	by mail.systec-electronic.com (Postfix) with ESMTPSA id 338D59400107;
	Sun, 21 Jan 2024 21:15:15 +0100 (CET)
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
Subject: [RFC net-next v4 2/2] net: phy: adin1100: Add interrupt support for link change
Date: Sun, 21 Jan 2024 20:54:49 +0100
Message-ID: <20240121201511.8997-3-andre.werner@systec-electronic.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240121201511.8997-1-andre.werner@systec-electronic.com>
References: <20240121201511.8997-1-andre.werner@systec-electronic.com>
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
v4:
- Change read-modify-write behavior as suggested to phy_modify_mmd.
---
 drivers/net/phy/adin1100.c | 56 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/net/phy/adin1100.c b/drivers/net/phy/adin1100.c
index 7619d6185801..7c82384e5d30 100644
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
@@ -136,6 +142,54 @@ static int adin_config_aneg(struct phy_device *phyde=
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
+	int ret;
+	u16 irq_mask;
+
+	ret =3D adin_phy_ack_intr(phydev);
+
+	if (ret)
+		return ret;
+
+	if (phydev->interrupts =3D=3D PHY_INTERRUPT_ENABLED)
+		irq_mask =3D ADIN_LINK_STAT_CHNG_IRQ_EN;
+	else
+		irq_mask =3D 0;
+
+	return phy_modify_mmd(phydev, MDIO_MMD_VEND2,
+			      ADIN_PHY_SUBSYS_IRQ_MASK,
+			      ADIN_LINK_STAT_CHNG_IRQ_EN, irq_mask);
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
@@ -275,6 +329,8 @@ static struct phy_driver adin_driver[] =3D {
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


