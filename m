Return-Path: <linux-kernel+bounces-84561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E1E86A852
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 07:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC99C287DE6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 06:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C60225D6;
	Wed, 28 Feb 2024 06:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="XY3v6iB3"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76D21E501;
	Wed, 28 Feb 2024 06:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709101838; cv=none; b=gwyGag/1KCEapp7mwXiT8nIcVylW1P/E+WVwrpssfM+Pc3maKnFS9ia19Rm9vJgEHnQf9MOBy2HhD5/JsQMFSTkJQS6ClB280bBpzipKHCo+rATMzd+ODsY4Gpsxq324oq7yF71Lkvg0gK23YbJ5h5HOA6A+gs2vfFCXCmGta/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709101838; c=relaxed/simple;
	bh=5zgtvBb7ybGOTydt2Y9kLwJt/b4q5aA+RidLp5++cRE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KdRguY0WBiceU7pVyOKGKvmTVNQUsizagCVAEzIotmFc3AizIYGBW73VqVSRfPkEP9n5Qf/GHzX3pXwwNqmn3tOy4EEq5+Kgcste+/wd8KKz+ngJfFqKh/X/a3A7cVHkWL7KjVi0aABVZbGufa2O0n6Yyvb3HYGF5uBTvhPE4N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=XY3v6iB3; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709101837; x=1740637837;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5zgtvBb7ybGOTydt2Y9kLwJt/b4q5aA+RidLp5++cRE=;
  b=XY3v6iB3THpVPlwDcG2WiRyYL8JhtEhSa8CEx8MVpATCxtdjQbJ9uk/5
   g4QqtiqIsT6PGOnR9uj/TiaNnPFA4H+ZkGU9Y6AGaCNxSEcae5A6ocA/H
   A8h5LIgazX/tDZ8lh+u4Yg1Cl1aytrrfAtJfAs5PS20ktFKwJT21oQPS8
   yOIJR/CkOb6Bh9VQdqIz09cAdegYM6nH+CJE1YEpzemQ3Iu7sZaGwWiI3
   WvX4vl5K09KbujUuI+cX1cuOX3vh4TQobLcu79E4pftDxa1pkBa/zU0dx
   d7lYs6KtOxKXYtM0S8WdGc+a6Eoc56V+eTP8zidUv2Tbly9n9fzekT0kE
   g==;
X-CSE-ConnectionGUID: WwtfXDcGT3ekg/b+aiH4Eg==
X-CSE-MsgGUID: vk/89F6YQJOYQKdIPkjbaA==
X-IronPort-AV: E=Sophos;i="6.06,190,1705388400"; 
   d="scan'208";a="247685634"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Feb 2024 23:30:35 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 23:30:06 -0700
Received: from DEN-DL-M31836.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 27 Feb 2024 23:30:04 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH net-next 1/2] net: phy: micrel: lan8814 led errata
Date: Wed, 28 Feb 2024 07:28:12 +0100
Message-ID: <20240228062813.1007138-2-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228062813.1007138-1-horatiu.vultur@microchip.com>
References: <20240228062813.1007138-1-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Lan8814 phy led behavior is not correct. It was noticed that the led
still remains ON when the cable is unplugged while there was traffic
passing at that time.

The fix consists in clearing bit 10 of register 0x38, in this way the
led behaviour is correct and gets OFF when there is no link.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/net/phy/micrel.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 9b69735819896..5a0cc89eaebdd 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -114,6 +114,9 @@
 #define LAN8814_INTR_CTRL_REG_POLARITY		BIT(1)
 #define LAN8814_INTR_CTRL_REG_INTR_ENABLE	BIT(0)
 
+#define LAN8814_EEE_STATE			0x38
+#define LAN8814_EEE_STATE_MASK2P5P		BIT(10)
+
 /* Represents 1ppm adjustment in 2^32 format with
  * each nsec contains 4 clock cycles.
  * The value is calculated as following: (1/1000000)/((2^-32)/4)
@@ -3288,6 +3291,19 @@ static int lan8814_release_coma_mode(struct phy_device *phydev)
 	return 0;
 }
 
+static void lan8814_errata_fixes(struct phy_device *phydev)
+{
+	u16 val;
+
+	/* It was noticed that when traffic is passing through the PHY and the
+	 * cable is removed then the LED was still one even though there is no
+	 * link
+	 */
+	val = lanphy_read_page_reg(phydev, 2, LAN8814_EEE_STATE);
+	val &= ~LAN8814_EEE_STATE_MASK2P5P;
+	lanphy_write_page_reg(phydev, 2, LAN8814_EEE_STATE, val);
+}
+
 static int lan8814_probe(struct phy_device *phydev)
 {
 	const struct kszphy_type *type = phydev->drv->driver_data;
@@ -3323,6 +3339,7 @@ static int lan8814_probe(struct phy_device *phydev)
 	}
 
 	lan8814_ptp_init(phydev);
+	lan8814_errata_fixes(phydev);
 
 	return 0;
 }
-- 
2.34.1


