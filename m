Return-Path: <linux-kernel+bounces-42849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 500C08407AF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B557288A27
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956DB65BD9;
	Mon, 29 Jan 2024 13:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b="W16Xs31P"
Received: from mail.systec-electronic.com (mail.systec-electronic.com [77.220.239.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52AD65BC0;
	Mon, 29 Jan 2024 13:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.220.239.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706536664; cv=none; b=qZOAFyiYKHJxTz4vIS+LoFPRn3sMRP5/RnCivYzBNmxWGaOYaTNuoKfslbp5eEIC/anSrdzHeOqHIuW/PuHMEIFyj9ckkTo3Yfs9TbuEsvdhceG6pQ5nmaKbRlvcseEKKKJx06dUhtAo7XtK7Al/+UWXH3kc1EWiFKId1IwB9OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706536664; c=relaxed/simple;
	bh=Ai3CARrEENYU4ep+MOW7EaLMr7eb+dJKM7gjFW62Ec0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N4iGmDpPiWMPHWiHDG4lhDrlJShwwbOXX9JQqal4/pwO6wgMLP+/qYkPbxiN9uFDEsBLUSM+zaLnEDePshZsMHDn4W5kc/8Sb8q34dlJnJwzr4+nrRBOwtyLPK84uvthE6rbwNai3ejhlNSLZm9MpG6GoMZ340GYJ5+LmDHVxVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=systec-electronic.com; spf=pass smtp.mailfrom=systec-electronic.com; dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b=W16Xs31P; arc=none smtp.client-ip=77.220.239.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=systec-electronic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=systec-electronic.com
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id 49E37941A5CF;
	Mon, 29 Jan 2024 14:57:40 +0100 (CET)
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id z1Fsjbw-VISF; Mon, 29 Jan 2024 14:57:40 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id 24587941A5D5;
	Mon, 29 Jan 2024 14:57:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.systec-electronic.com 24587941A5D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=systec-electronic.com; s=B34D3B04-5DC7-11EE-83E3-4D8CAB78E8CD;
	t=1706536660; bh=BLVBSipavZztTYx8CwSVW5BhkEJvYHjdnvg38MQ/MRg=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=W16Xs31Phn0uLjZewKehKQq3Xgw6cOXveXd3Q2fcJua8zWKfqyRQYs0zXF3hCnuix
	 oOZbc7Y08flzfNCqkSrVbJm38LGbI7bUrKJBj1kAdcP4rgNWgGYqEZ+4GnJGuzbMs2
	 gBGXvOkaBTT/gmmuUGEca3BuS5jPPCGmOW4T9KXmcQFg7U1FOt+NVR9nU4zshZrfED
	 LW58r9B/r7iO4J7pV70v280SD4F2Cg22GKnNUWkUD+VURgC2QcoiXT9s2LhnHRL9Ht
	 6Inucs3Wtsdpf906N8YIqEhS+80gJp0FbESxka6HjfmwE0XtwNZzey1vfGHkNFPGH3
	 0/I8tklEqEjmw==
X-Virus-Scanned: amavis at systec-electronic.com
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id Heug1LM32S_s; Mon, 29 Jan 2024 14:57:40 +0100 (CET)
Received: from ws-565760.systec.local (unknown [212.185.67.148])
	by mail.systec-electronic.com (Postfix) with ESMTPSA id CB609941A5CF;
	Mon, 29 Jan 2024 14:57:39 +0100 (CET)
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
Subject: [net-next v5 2/2] net: phy: adin1100: Add interrupt support for link change
Date: Mon, 29 Jan 2024 14:55:05 +0100
Message-ID: <20240129135734.18975-3-andre.werner@systec-electronic.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129135734.18975-1-andre.werner@systec-electronic.com>
References: <20240129135734.18975-1-andre.werner@systec-electronic.com>
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
v5:
- Add reversed-x-max-notation to variables in adin_config_intr.
- Delete empty line between function call and if statement.

v4:
- Change read-modify-write behavior as suggested to phy_modify_mmd.

v3:
- Correct rashly format error that was reported by checker.

v2:
- Clean format and reword commit message as suggested by reviewer of
  first patch submission
---
 drivers/net/phy/adin1100.c | 55 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/net/phy/adin1100.c b/drivers/net/phy/adin1100.c
index 7619d6185801..85f910e2d4fb 100644
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
@@ -136,6 +142,53 @@ static int adin_config_aneg(struct phy_device *phyde=
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
+	u16 irq_mask;
+	int ret;
+
+	ret =3D adin_phy_ack_intr(phydev);
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
@@ -275,6 +328,8 @@ static struct phy_driver adin_driver[] =3D {
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


