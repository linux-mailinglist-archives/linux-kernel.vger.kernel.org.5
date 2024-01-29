Return-Path: <linux-kernel+bounces-42850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA138407B0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF072288A71
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C88A664C0;
	Mon, 29 Jan 2024 13:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b="joSwU/ud"
Received: from mail.systec-electronic.com (mail.systec-electronic.com [77.220.239.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C693C65BC1;
	Mon, 29 Jan 2024 13:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.220.239.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706536665; cv=none; b=Pmbu/5Oe3QaYK5D0+HULRJQPe5fNl/Yichjbt+5FqQ1DMN+5heG0ir4tqgQfgpZIl2sLB/FDy77HCac2qPy7+2knMMiVzLrYJ6mnLeoKPvD8fYvoj3emPBQfEafqlYgtO6zpTPA0TuCeVEPbWLP9abWfZ0Iz2xYUbeFWv0TW5xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706536665; c=relaxed/simple;
	bh=UMJfFUGL5hSKpcaLyoAlFXOxYOstCOE9Bj+KlKW0jB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o+tFcwVtM/tOBfIToxQpVCVG2VXO0nbDbrKfzTboihHMNfGVvwNsRs5JkHGcADM62XbyL3ZsDNYUPthu4x/6lANosGKINcnA3OKPq97huA1WzVdGxVnKtdNB6cZ2H2VO3kvszP6ac1daStMwlIkDtMLdsMHInDm7m6gdYrHHoOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=systec-electronic.com; spf=pass smtp.mailfrom=systec-electronic.com; dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b=joSwU/ud; arc=none smtp.client-ip=77.220.239.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=systec-electronic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=systec-electronic.com
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id 08AEF941A5D4;
	Mon, 29 Jan 2024 14:57:40 +0100 (CET)
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id J_rKWW5O-2Ds; Mon, 29 Jan 2024 14:57:39 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id D739A941A5D7;
	Mon, 29 Jan 2024 14:57:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.systec-electronic.com D739A941A5D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=systec-electronic.com; s=B34D3B04-5DC7-11EE-83E3-4D8CAB78E8CD;
	t=1706536659; bh=oZtabn9a4o/r0XaHKQFRL1aLV2Wi+F8tuHdV9IBDvBk=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=joSwU/ud2Nm/3IIaEXsyLC42ZXDiFSaQD95b1W/FlEFwJuEL+aMvvsA65a9Ux4fpu
	 V4jXpMqTsyZhuQ4JUgxsCida0JqUVBi6vw7qUm6vQR75nxbyWstUTENejrWXhNJtef
	 APWXQfPELTicMlhttQ3qrGQSSrt8/SJ3Lyx2EIIWK0Xke3Z+mIx26TdXwxmEBjDr8Q
	 hONqEh+/UfcsvyrIb20VHA0NGxf9fRXsBwRZKL9rqqwHML5kuJ7Jsyap9MQyX4s+Qb
	 f8F6jIU9pYF5fXlY0mkvUI+BHwHL8e8pq/9eWiLmdTLDqWHY5G9WhQlmmaNmydllp6
	 BToilcpZCv+fA==
X-Virus-Scanned: amavis at systec-electronic.com
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id NHV68fuSjWCQ; Mon, 29 Jan 2024 14:57:39 +0100 (CET)
Received: from ws-565760.systec.local (unknown [212.185.67.148])
	by mail.systec-electronic.com (Postfix) with ESMTPSA id 8A384941A5D4;
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
Subject: [net-next v5 1/2] net: phy: phy_device: Prevent nullptr exceptions on ISR
Date: Mon, 29 Jan 2024 14:55:04 +0100
Message-ID: <20240129135734.18975-2-andre.werner@systec-electronic.com>
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

If phydev->irq is set unconditionally, check
for valid interrupt handler or fall back to polling mode to prevent
nullptr exceptions in interrupt service routine.

Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
v5:
- No functional changes. Add Reviewed-by tag.

v4:
- Delete phydev_warn and comment as suggested.

v3:
- No changes to v2. Just to complete the series.

v2:
- Add changes suggested in discussion about adin1100.c driver to
  phy_attach_direct.
---
 drivers/net/phy/phy_device.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index dd778c7fde1d..52828d1c64f7 100644
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


