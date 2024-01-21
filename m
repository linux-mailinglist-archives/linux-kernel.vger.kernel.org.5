Return-Path: <linux-kernel+bounces-32176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9458357B0
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 21:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53F951F21822
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 20:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51AA38DFA;
	Sun, 21 Jan 2024 20:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b="LWx6bbWE"
Received: from mail.systec-electronic.com (mail.systec-electronic.com [77.220.239.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8B8364A4;
	Sun, 21 Jan 2024 20:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.220.239.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705868128; cv=none; b=rAsGuWA6J3qwAajOORGvnZWHligb/RWzq7r3TzvQ5YGc8YnjHUZIl7v96lc1bdMgSxL2wGVJ1pyXIRZ+rhirEpzH/O96WIQn+nY6yZTAX1cUNg0FZMUrhK38Sr28oYVIQX9iP8mm1cpiMLSyTIG1hreqMnkIhNKOuvbtqPbNikM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705868128; c=relaxed/simple;
	bh=r7Mad+18u+jwnU/YF4L3AU0sCRqVEO0/VeJu9ihAzqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CKEjnAyASMveEL72IXI4W7oPqxba3Ho8rYFHbg7izC7kw5c5FSenrGaPZpahO4hHoCxLV0OcirxUx0kIzh+dfj3sKSDf9B4fLZH5Q3zw8LX5SkXZpkxXF7ZMC7a2T4dDDiX1jSog6Akbv/Bu7z6pcoqb2n0jrdPNF3P9j0JUiu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=systec-electronic.com; spf=pass smtp.mailfrom=systec-electronic.com; dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b=LWx6bbWE; arc=none smtp.client-ip=77.220.239.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=systec-electronic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=systec-electronic.com
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id DD7DB941A5D0;
	Sun, 21 Jan 2024 21:15:15 +0100 (CET)
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id VBdqbwpY4LHf; Sun, 21 Jan 2024 21:15:15 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id 3AEB7941A5CF;
	Sun, 21 Jan 2024 21:15:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.systec-electronic.com 3AEB7941A5CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=systec-electronic.com; s=B34D3B04-5DC7-11EE-83E3-4D8CAB78E8CD;
	t=1705868115; bh=0fVqfQUXQoF1AGoP7P+W4Vw6CmKt77YMbNYaAqbRPvo=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=LWx6bbWEcje9I+A8Vak4nT5lrpVEA7eRTY6tIzJf/DrH2erUNq1PdayYL08MOC9k1
	 nzsQhTJrAiVRn4t0xdvNyJ/DDSPHb5kGLE9EY7wSuSBwhHYc4gfUDD9b+m1t+eSYGM
	 9AleKwOQEOYiLHNSAK3SuUBJMl+UIBZUwegRiIaiYaHQLnnr5s26KJAH87U2zSZ1Sb
	 xo4tLsoZX5IpE30ATIThdKh+bO3XHc4w/eZJ/DRxuO/suG0e7eE6m2pGhBeEOfn4iM
	 xO0n2uEMuxGsJo8sYgHeVLEnqmnddKubxFAmIA5usSUgpmPQ5lBEz57rW6kZueJDik
	 2IRVgtpo4Z6wA==
X-Virus-Scanned: amavis at systec-electronic.com
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id SyEDDzDb2M5X; Sun, 21 Jan 2024 21:15:15 +0100 (CET)
Received: from ws-565760.systec.local (unknown [212.185.67.148])
	by mail.systec-electronic.com (Postfix) with ESMTPSA id E6733940168B;
	Sun, 21 Jan 2024 21:15:14 +0100 (CET)
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
Subject: [RFC net-next v4 1/2] net: phy: phy_device: Prevent nullptr exceptions on ISR
Date: Sun, 21 Jan 2024 20:54:48 +0100
Message-ID: <20240121201511.8997-2-andre.werner@systec-electronic.com>
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

If phydev->irq is set unconditionally, check
for valid interrupt handler or fall back to polling mode to prevent
nullptr exceptions in interrupt service routine.

Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
---
v4:
- Delete phydev_warn and comment as suggested.
---
 drivers/net/phy/phy_device.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 3611ea64875e..7cbe7c714177 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1413,6 +1413,11 @@ int phy_sfp_probe(struct phy_device *phydev,
 }
 EXPORT_SYMBOL(phy_sfp_probe);
=20
+static bool phy_drv_supports_irq(struct phy_driver *phydrv)
+{
+	return phydrv->config_intr && phydrv->handle_interrupt;
+}
+
 /**
  * phy_attach_direct - attach a network device to a given PHY device poi=
nter
  * @dev: network device to attach
@@ -1527,6 +1532,9 @@ int phy_attach_direct(struct net_device *dev, struc=
t phy_device *phydev,
 	if (phydev->dev_flags & PHY_F_NO_IRQ)
 		phydev->irq =3D PHY_POLL;
=20
+	if (!phy_drv_supports_irq(phydev->drv) && phy_interrupt_is_valid(phydev=
))
+		phydev->irq =3D PHY_POLL;
+
 	/* Port is set to PORT_TP by default and the actual PHY driver will set
 	 * it to different value depending on the PHY configuration. If we have
 	 * the generic PHY driver we can't figure it out, thus set the old
@@ -2992,11 +3000,6 @@ s32 phy_get_internal_delay(struct phy_device *phyd=
ev, struct device *dev,
 }
 EXPORT_SYMBOL(phy_get_internal_delay);
=20
-static bool phy_drv_supports_irq(struct phy_driver *phydrv)
-{
-	return phydrv->config_intr && phydrv->handle_interrupt;
-}
-
 static int phy_led_set_brightness(struct led_classdev *led_cdev,
 				  enum led_brightness value)
 {
--=20
2.43.0


