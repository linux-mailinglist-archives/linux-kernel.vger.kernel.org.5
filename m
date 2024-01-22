Return-Path: <linux-kernel+bounces-34050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 484B783729E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DABDEB2F755
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C98541203;
	Mon, 22 Jan 2024 19:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b="iTM7P/Xg"
Received: from mail.systec-electronic.com (mail.systec-electronic.com [77.220.239.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FD7405EE;
	Mon, 22 Jan 2024 19:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.220.239.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705951461; cv=none; b=VuSOu4qGGahYAATVp1pppr4UBfxtZMvGkgkg+askNywP8DlUzYO+V6ooo3/Y2LYqa6TvtpRIn0K52pJdoZbpF6SdLVw75D8EuJPygW1zIjlXy40APC4gbSf244Viov97q7Y8khhuzM5Zik0IWPzMqiJdeP+g4tclUGB2aMIGHC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705951461; c=relaxed/simple;
	bh=C7ED0YFMfngV6TLDyUhwMv6dkN7P2bIDcDODkYH1lqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l13UOC/Y9AcWgR8qpsBvByuOGnMaoRyPqTeRETK102mSv8D7R0Ut6hcBrFtVJkYED7a1YFdWmbqfsT3yKkD55VltpQ+HkY2Q8Mg+7xuhqCQvmKj6DE1jtn72X7ejRDqHlNEqL5cd5z8yiRvHYlDFGJMy/HoRRpQtRaqOR4fDXDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=systec-electronic.com; spf=pass smtp.mailfrom=systec-electronic.com; dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b=iTM7P/Xg; arc=none smtp.client-ip=77.220.239.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=systec-electronic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=systec-electronic.com
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id 7426D940010B;
	Mon, 22 Jan 2024 20:24:16 +0100 (CET)
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id FV1Q_8zrO4mP; Mon, 22 Jan 2024 20:24:16 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id 4F695941A5CE;
	Mon, 22 Jan 2024 20:24:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.systec-electronic.com 4F695941A5CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=systec-electronic.com; s=B34D3B04-5DC7-11EE-83E3-4D8CAB78E8CD;
	t=1705951456; bh=mW08HNSPy56HL8/Wc/HNt69swvBgRv/uYpr/mOogiqk=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=iTM7P/XgxsQC7eC/71RricBfuVa4P+e8OFpkViAJYMxDC+ZAKPcmEezNjpeLu3PZf
	 AB1weJs7o/8sfFlaC+WVPKJosuYDKxQzXG3X0qcTmP7z7KA1lzS7qgzBok/gV6h+w2
	 IJF3RlhO1xtVNFEOe7vtXaHdcf97XjKHqVI1rgTfGRfTjHDah00hdfMu+JqSakUzpA
	 9+AOLFm5vOQIomgwNW8CtahHJCPEfbM5Xur73pGpr/PKVjbq8m1RgNEZ/exLFIqSv2
	 GLnq6++tWufmzYzZRO6pYWf2vBUWhj6kDvS6cRtuxA+KK9DbQwAB6epP2nXCnGhKKq
	 AbXObUORwk4MA==
X-Virus-Scanned: amavis at systec-electronic.com
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id HmfUjs_cKSmL; Mon, 22 Jan 2024 20:24:16 +0100 (CET)
Received: from ws-565760.systec.local (unknown [212.185.67.148])
	by mail.systec-electronic.com (Postfix) with ESMTPSA id 04D42940010B;
	Mon, 22 Jan 2024 20:24:16 +0100 (CET)
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
Subject: [RFC net-next v5 1/2] net: phy: phy_device: Prevent nullptr exceptions on ISR
Date: Mon, 22 Jan 2024 20:17:15 +0100
Message-ID: <20240122192401.26836-2-andre.werner@systec-electronic.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122192401.26836-1-andre.werner@systec-electronic.com>
References: <20240122192401.26836-1-andre.werner@systec-electronic.com>
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


