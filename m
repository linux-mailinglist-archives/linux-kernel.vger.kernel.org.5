Return-Path: <linux-kernel+bounces-143873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 032DA8A3E96
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 23:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9832CB21624
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 21:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD3955C33;
	Sat, 13 Apr 2024 21:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQvzQMyP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0874623BE;
	Sat, 13 Apr 2024 21:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713042507; cv=none; b=tJMlLKyy65hG+9s+apM1GRg3meLw4JI5/CMS7sbyPlD1TFq3TKU0thdYs+p1JDycsWqtU8niaeemXtahnpn2VnfRx8mQ7CziLSea9l1hrBQkvZKEN4gfE+94dLvanSvNzDL4+7In43vlh+MH6jh2LZCGzG/oyx4FoGGcVQSV144=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713042507; c=relaxed/simple;
	bh=8ftN+AozV8xrqm48t4mfEg6N/gXxQI8jvRXOIlRjc5s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HV9ADmzQpKUcXONF/tnvgROSRkfmKHscH802ilAx06hmPfzYCoz6lhhmcY8Dqt0MW69xVhIKgOuWIiU1iH/vf2l+Ny14vPhfZyL9EqybsbGbXaniXysInWP4krE9yLCtmflhy3x+PdycuImlKH5uVAts75fujzHqzJyscLFr2LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQvzQMyP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6C12FC113CD;
	Sat, 13 Apr 2024 21:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713042506;
	bh=8ftN+AozV8xrqm48t4mfEg6N/gXxQI8jvRXOIlRjc5s=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=AQvzQMyPsr0JldqzqNIGUFOjwCMRLj5SDBbzz57DAPtPKdG241YGxFecrrnPk+EEn
	 T73fdmN33X4gLPiX3xDuh4K6rE+BjW6VYBCESKz4/Wz1IO39ZZEDKdSrh6JMAnqQPx
	 +TMS8l5VAiNVJnxMeDF225u/4uuMm1MB/3sidZevb2mD+Ypiu3v0X1R12ajQc9DDi9
	 k2iIUmAQU91joHGlTOL/37/HvPZ22uBbLLmFKoWJjjAoHLL+cfCDsyw/LvFVplacvO
	 lKPuY6+0nX1XQ6BIXqGtMyfFdlXtQyyvZp76uNiJwwkjWFWzOOryZAABVB5w5b92QW
	 87kGKO1K2dmOQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55312C4345F;
	Sat, 13 Apr 2024 21:08:26 +0000 (UTC)
From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL_via_B4_Relay?= <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Sun, 14 Apr 2024 00:08:13 +0300
Subject: [PATCH net-next] net: phy: mediatek-ge: do not disable EEE
 advertisement
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240414-for-netnext-mediatek-ge-do-not-disable-eee-adv-v1-1-2fefd63c990b@arinc9.com>
X-B4-Tracking: v=1; b=H4sIADz0GmYC/x3N2wrCMBCE4Vcpe+1CE4unV5FepNmJLmoiSSiF0
 nc39fKH4ZuVCrKi0K1bKWPWoim2MIeO/NPFB1ilNdneDv3RGg4pc0SNWCp/IOoqXtxmkjimyqL
 FTW8wAHYy83Q6S/A+XC/GUEO/GUGX/+GdmsM7ROO2/QBWJbCvigAAAA==
To: Daniel Golle <daniel@makrotopia.org>, Qingfang Deng <dqfext@gmail.com>, 
 SkyLake Huang <SkyLake.Huang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: mithat.guner@xeront.com, erkin.bozoglu@xeront.com, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713042497; l=1262;
 i=arinc.unal@arinc9.com; s=arinc9-patatt; h=from:subject:message-id;
 bh=3+tGyLYc9tR5wwy3EghRPXT4LZ9a92aLjvNesVkpu9o=;
 b=W1Dn4HFVHIUCOJTQtcShYgKgcG7Ck+OXjRDh/mAj+PHLqe0nx8zL743Qod1CUINXYtPSl+N4t
 1RNaO8X4jOcCOCKSeamjbRPXGI3W7B8FkPtIlDoQG0kl4AFu1DlEgDG
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=VmvgMWwm73yVIrlyJYvGtnXkQJy9CvbaeEqPQO9Z4kA=
X-Endpoint-Received: by B4 Relay for arinc.unal@arinc9.com/arinc9-patatt
 with auth_id=115
X-Original-From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
Reply-To: arinc.unal@arinc9.com

From: Arınç ÜNAL <arinc.unal@arinc9.com>

The mediatek-ge PHY driver already disables EEE advertisement on the switch
PHYs but my testing [1] shows that it is somehow enabled afterwards.
Disabling EEE advertisement before the PHY driver initialises keeps it off.
Therefore, remove disabling EEE advertisement here as it's useless.

Link: https://lore.kernel.org/netdev/d286ea27-e911-4dcb-9037-b75f22b437b8@arinc9.com/ [1]
Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/net/phy/mediatek-ge.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/phy/mediatek-ge.c b/drivers/net/phy/mediatek-ge.c
index a493ae01b267..54ea64a37ab3 100644
--- a/drivers/net/phy/mediatek-ge.c
+++ b/drivers/net/phy/mediatek-ge.c
@@ -23,9 +23,6 @@ static int mtk_gephy_write_page(struct phy_device *phydev, int page)
 
 static void mtk_gephy_config_init(struct phy_device *phydev)
 {
-	/* Disable EEE */
-	phy_write_mmd(phydev, MDIO_MMD_AN, MDIO_AN_EEE_ADV, 0);
-
 	/* Enable HW auto downshift */
 	phy_modify_paged(phydev, MTK_PHY_PAGE_EXTENDED, 0x14, 0, BIT(4));
 

---
base-commit: 32affa5578f0e6b9abef3623d3976395afbd265c
change-id: 20240321-for-netnext-mediatek-ge-do-not-disable-eee-adv-b67dfccf9811

Best regards,
-- 
Arınç ÜNAL <arinc.unal@arinc9.com>



