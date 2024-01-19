Return-Path: <linux-kernel+bounces-30956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 863008326CB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3988284B8C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 09:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4003C460;
	Fri, 19 Jan 2024 09:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b="GllQGoyl"
Received: from mail.systec-electronic.com (mail.systec-electronic.com [77.220.239.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F21A3C068;
	Fri, 19 Jan 2024 09:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.220.239.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705656914; cv=none; b=o52LmaHP25RtoOy0xZ1HNOWTIrvFpe4rDD1mLWDMQUWTydyedXEqZsbTl9Msg5ZtfuRs/H7TPtw/Viy5OeuJaMxnfUAbT8VI0oWkmvL3DxyZR9SrJ8By6XpGYmillgf/Tz7d0/8ZJuTQVccEG3CsmA5fhjqQ2vIDmCdOR0prE9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705656914; c=relaxed/simple;
	bh=0YMvfGZcQmvcq65wZ2XEdm0xWU66Inkuxy0qUZM42kM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=irruGzqSTXTPdqJNbFluNvlQsLM4lj+wJ/YsBAyrERcFIrNyD6A3AKds20IwiT0mz/U1+vlRjDYp9G1qbbSPQCCeYFZLll8CofzWphGJqkg+v7Go6s7x4tSCc9xuNQcasJLeNiuafTkiG/CufI5NL6KQxKCaFoFqCj//w9t1qys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=systec-electronic.com; spf=pass smtp.mailfrom=systec-electronic.com; dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b=GllQGoyl; arc=none smtp.client-ip=77.220.239.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=systec-electronic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=systec-electronic.com
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id 234AD9400107;
	Fri, 19 Jan 2024 10:35:07 +0100 (CET)
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id NFsGSF9ZCjXb; Fri, 19 Jan 2024 10:35:07 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id DF14C9400115;
	Fri, 19 Jan 2024 10:35:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.systec-electronic.com DF14C9400115
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=systec-electronic.com; s=B34D3B04-5DC7-11EE-83E3-4D8CAB78E8CD;
	t=1705656906; bh=pU5zLdBie6WD4BylU5Qe/JyBc1oOisnlYg2DtaUpCgU=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=GllQGoylb58VxeaP7hUICFJUWq8QTpuO94oY2HCutywZ/BEB9EC3mTTHwFuC2l59y
	 oSsoveUBOV5ujtbAbT8rMV2amiGHV0EEzoX8lGtW8yZJkRwwm22n+HsoPP3ULzJ4KD
	 aPeYnNgAEVPZaYgITEo0rTMF7ABt9oWKp0sfntp5AP8QLLhRWiu3CsZ7lM8/txfRYe
	 sdpa/BHPjxs3cnmK3j3lVE3Tt/NFaKOPy8bfTVcLl0gLnE+EJHAj46kerohI6FhHVU
	 jCgFmp/h9yyBamN9T2+/7HPOmskVyxTlIOZmHuZubgcCVa8AAfD1dp9mzmhlIrbmtL
	 KyLhHosm6Mqww==
X-Virus-Scanned: amavis at systec-electronic.com
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id Jj0hHIiFsOaP; Fri, 19 Jan 2024 10:35:06 +0100 (CET)
Received: from ws-565760.systec.local (unknown [212.185.67.148])
	by mail.systec-electronic.com (Postfix) with ESMTPSA id 8CC8B9400107;
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
Subject: [RFC net-next v3 1/2] net: phy: phy_device Prevent nullptr exceptions on ISR
Date: Fri, 19 Jan 2024 10:32:25 +0100
Message-ID: <20240119093503.6370-1-andre.werner@systec-electronic.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If phydev->irq is set unconditionally by MAC drivers, check
for valid interrupt handler or fall back to polling mode to prevent
nullptr exceptions.

Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
---
v3:
- No changes to v2. Just to complete the series.
---
 drivers/net/phy/phy_device.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 3611ea64875e..3986e103d25e 100644
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
@@ -1527,6 +1532,18 @@ int phy_attach_direct(struct net_device *dev, stru=
ct phy_device *phydev,
 	if (phydev->dev_flags & PHY_F_NO_IRQ)
 		phydev->irq =3D PHY_POLL;
=20
+	/*
+	 * Some drivers may add IRQ numbers unconditionally to a phy device tha=
t does
+	 * not implement an interrupt handler after phy_probe is already done.
+	 * Reset to PHY_POLL to prevent nullptr exceptions in that case.
+	 */
+	if (!phy_drv_supports_irq(phydev->drv) && phy_interrupt_is_valid(phydev=
)) {
+		phydev_warn(phydev,
+			    "No handler for IRQ=3D%d available. Falling back to polling mode\=
n",
+			    phydev->irq);
+		phydev->irq =3D PHY_POLL;
+	}
+
 	/* Port is set to PORT_TP by default and the actual PHY driver will set
 	 * it to different value depending on the PHY configuration. If we have
 	 * the generic PHY driver we can't figure it out, thus set the old
@@ -2992,11 +3009,6 @@ s32 phy_get_internal_delay(struct phy_device *phyd=
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


