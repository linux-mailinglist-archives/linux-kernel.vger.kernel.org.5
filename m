Return-Path: <linux-kernel+bounces-51103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A901F848681
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 14:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A515B26609
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 13:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8185358206;
	Sat,  3 Feb 2024 13:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osasysteme.de header.i=@osasysteme.de header.b="rL9qRFRt"
Received: from secondary.pambor.com (secondary.pambor.com [46.38.233.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70E24F20C;
	Sat,  3 Feb 2024 13:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.38.233.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706966504; cv=none; b=rDYpI4WBXZDivCdMSnjQq1/WI76ZbnO9o7nvyB6Ve6TozLH7voTaVmIFl7A7sVxL6GWD7c52Oy+yGgRf7269vComLVS2QUvdPqPu8n09pkqWf8wKXzdWA6fX09KK0hYUFgFTu2vXaXPMM7sQCTpeq1dd5L7dJGXR8SvU8LNs+zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706966504; c=relaxed/simple;
	bh=DKL9b3icrAnYHUAIyTMERLKYVfDCo69laJyU52r8+hE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xu//NxB9oIv2w+UXsKtszrUVLIXnSV0zeZ7ZlVlKQuY/lLYtbgu25Z0+oaUhx3TgEz+Rz/zc1A9ElkBIuL8RR++IeAAYGByK8lOcXqf2fo0IsHzAcGvhKZ4hVO+amwLUrrSq+xKVa4K29QDJVFDmzf3gr7+A6rghTmMpTCaJxsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osasysteme.de; spf=pass smtp.mailfrom=osasysteme.de; dkim=pass (2048-bit key) header.d=osasysteme.de header.i=@osasysteme.de header.b=rL9qRFRt; arc=none smtp.client-ip=46.38.233.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osasysteme.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=osasysteme.de
Received: from localhost (localhost [127.0.0.1])
	by secondary.pambor.com (Postfix) with ESMTP id 2D6326EFF5E;
	Sat,  3 Feb 2024 14:12:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=osasysteme.de;
	s=19022017; t=1706965974;
	bh=DKL9b3icrAnYHUAIyTMERLKYVfDCo69laJyU52r8+hE=;
	h=From:To:Cc:Subject:Date:From;
	b=rL9qRFRtTjPbGId30HzVsjzKPVd2dZ+fTgzPAk+cPcN5NZmgWvqCRIFDO3uOv5utI
	 PmkJQEPOpxTkRm2syjaZqXpBqzlimnmcZHJagunTrYEAqr3C2Bw+blrvcLPhr7gRnx
	 8iEh/A0MRAZiTtGeY6x3S/m3OIQYKZY/USDVtA/lMECQOu3StkDuNssBj+phy+Rwu5
	 3vytXYY6W3Q5HzVk/0ZQKMvD6ERkT8mbW1V9FNlt3Ke6z7s1rsITmnklW+PD41HUkx
	 G3k1PMiI0vMXoIdqtONGsrDLfRo2LVb6/4Gmq69I8EtpCezLnnrtPXDnPrXhURPsny
	 XYEKl7umiyscQ==
X-Virus-Scanned: Debian amavisd-new at secondary.pambor.com
Received: from secondary.pambor.com ([127.0.0.1])
	by localhost (secondary.pambor.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id wwGa7QVwNd2p; Sat,  3 Feb 2024 14:12:51 +0100 (CET)
Received: from chromebook.fritz.box (dynamic-2a01-0c23-79b1-ee00-489e-3931-3658-2abd.c23.pool.telefonica.de [IPv6:2a01:c23:79b1:ee00:489e:3931:3658:2abd])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.osasysteme.de (Postfix) with ESMTPSA id 52D406EFF0F;
	Sat,  3 Feb 2024 14:12:51 +0100 (CET)
From: Tim Pambor <tp@osasysteme.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Dan Murphy <dmurphy@ti.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tim Pambor <tp@osasysteme.de>
Subject: [PATCH] net: phy: dp83822: Fix RGMII TX delay configuration
Date: Sat,  3 Feb 2024 14:11:51 +0100
Message-ID: <20240203131152.61958-1-tp@osasysteme.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The logic for enabling the TX clock shift is inverse of enabling the RX
clock shift. The TX clock shift is disabled when DP83822_TX_CLK_SHIFT is
set. Correct the current behavior and always write the delay configuration
to ensure consistent delay settings regardless of bootloader configuration.

Reference: https://www.ti.com/lit/ds/symlink/dp83822i.pdf p. 69

Fixes: 8095295292b5 ("net: phy: DP83822: Add setting the fixed internal delay")
Signed-off-by: Tim Pambor <tp@osasysteme.de>
---
 drivers/net/phy/dp83822.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
index b7cb71817780..b061036f654a 100644
--- a/drivers/net/phy/dp83822.c
+++ b/drivers/net/phy/dp83822.c
@@ -398,16 +398,15 @@ static int dp83822_config_init(struct phy_device *phydev)
 		tx_int_delay = phy_get_internal_delay(phydev, dev, NULL, 0,
 						      false);
 		if (tx_int_delay <= 0)
-			rgmii_delay &= ~DP83822_TX_CLK_SHIFT;
-		else
 			rgmii_delay |= DP83822_TX_CLK_SHIFT;
+		else
+			rgmii_delay &= ~DP83822_TX_CLK_SHIFT;
 
-		if (rgmii_delay) {
-			err = phy_set_bits_mmd(phydev, DP83822_DEVADDR,
-					       MII_DP83822_RCSR, rgmii_delay);
-			if (err)
-				return err;
-		}
+		err = phy_modify_mmd(phydev, DP83822_DEVADDR, MII_DP83822_RCSR,
+				     DP83822_RX_CLK_SHIFT | DP83822_TX_CLK_SHIFT, rgmii_delay);
+
+		if (err < 0)
+			return err;
 
 		phy_set_bits_mmd(phydev, DP83822_DEVADDR,
 					MII_DP83822_RCSR, DP83822_RGMII_MODE_EN);
-- 
2.43.0


