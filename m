Return-Path: <linux-kernel+bounces-90289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2B786FCF4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BAAB1C2131C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEACA224C2;
	Mon,  4 Mar 2024 09:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="QvkwNkGu"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6498C1B97C;
	Mon,  4 Mar 2024 09:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709543812; cv=none; b=TJKsLvpQRUUxbHMqonRZcZeOymCETSONn9AGNtBvccYl7HgI/m1mrsyVy4Pb9sf68TvarZdgcbIQRC66a4SjmxpXIIMGXlP9uiNOVEZ+mwSW8T+WBOEr4Lm1fx58ERlcnqmVtUtvBTMkzkre6pFiWTjrRZaypudk7mIt9Opt4w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709543812; c=relaxed/simple;
	bh=zseSRa6wXr7QVJKhGnqeZU4nSAnBMOPbW06T7r7hqZw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qas0n5fo4IK9YC7KM/BZn4yMfVeDpMm8LzbwKkzbAPL0Yl8C3BYj9786iL8C78aAO+tEAHAN2Nw8G/97QsEjJikQM//+2Zo3B70m9nZZ+KWAzen3JoaryVfAAuHZEdyBQVvkdBwNR2W+wCx07y/UPtUVovmcgWUqqGmQBMz75fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=QvkwNkGu; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709543811; x=1741079811;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zseSRa6wXr7QVJKhGnqeZU4nSAnBMOPbW06T7r7hqZw=;
  b=QvkwNkGuRbKij7tWpMWBRrJK5PW52YJua5frFAg5xXHMXvES0O9yqo7d
   PKSLtEo0P+F/1rBRsmNy9+9zlKaXshoLb8ScoHEJ7j3ZLYq6dF4sqKJUM
   J9EswjXS0dYr5xaoNp5OuJ5rRHbf0HLTLR2j6SalXcLpk2N+OHhjIMTbA
   ST44RSIjlsEilyaHUunBfWwBH+KZ0p/pxSgmPhFWTB4bC2o5PFFkpWuwU
   XSfVd1JPymYniATXurTFuJgcj88G5+55h2YCyDiEr090AO3svsEgK1kR2
   aOMPN3Esf0ms+I/1DOUzoJjWNJICqOIAz9hL1qCUQ5BAHHBy8AfDQbkHf
   w==;
X-CSE-ConnectionGUID: 7oblNlVzTXGpgkVkuiMXRA==
X-CSE-MsgGUID: ViKNQmJISyi7R0WCPHQlsA==
X-IronPort-AV: E=Sophos;i="6.06,203,1705388400"; 
   d="scan'208";a="247914620"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Mar 2024 02:16:48 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 02:16:28 -0700
Received: from DEN-DL-M31836.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 4 Mar 2024 02:16:25 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <wojciech.drewek@intel.com>,
	<arun.ramadoss@microchip.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH net-next v3 2/2] net: phy: micrel: lan8814 cable improvement errata
Date: Mon, 4 Mar 2024 10:15:48 +0100
Message-ID: <20240304091548.1386022-3-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240304091548.1386022-1-horatiu.vultur@microchip.com>
References: <20240304091548.1386022-1-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

When the length of the cable is more than 100m and the lan8814 is
configured to run in 1000Base-T Slave then the register of the device
needs to be optimized.

Workaround this by setting the measure time to a value of 0xb. This
value can be set regardless of the configuration.

This issue is described in 'LAN8814 Silicon Errata and Data Sheet
Clarification' and according to that, this will not be corrected in a
future silicon revision.

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/net/phy/micrel.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 88cc03982bb78..8b8634600c519 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -117,6 +117,10 @@
 #define LAN8814_EEE_STATE			0x38
 #define LAN8814_EEE_STATE_MASK2P5P		BIT(10)
 
+#define LAN8814_PD_CONTROLS			0x9d
+#define LAN8814_PD_CONTROLS_PD_MEAS_TIME_MASK	GENMASK(3, 0)
+#define LAN8814_PD_CONTROLS_PD_MEAS_TIME_VAL	0xb
+
 /* Represents 1ppm adjustment in 2^32 format with
  * each nsec contains 4 clock cycles.
  * The value is calculated as following: (1/1000000)/((2^-32)/4)
@@ -3304,6 +3308,20 @@ static void lan8814_clear_2psp_bit(struct phy_device *phydev)
 	lanphy_write_page_reg(phydev, 2, LAN8814_EEE_STATE, val);
 }
 
+static void lan8814_update_meas_time(struct phy_device *phydev)
+{
+	u16 val;
+
+	/* By setting the measure time to a value of 0xb this will allow cables
+	 * longer than 100m to be used. This configuration can be used
+	 * regardless of the mode of operation of the PHY
+	 */
+	val = lanphy_read_page_reg(phydev, 1, LAN8814_PD_CONTROLS);
+	val &= ~LAN8814_PD_CONTROLS_PD_MEAS_TIME_MASK;
+	val |= LAN8814_PD_CONTROLS_PD_MEAS_TIME_VAL;
+	lanphy_write_page_reg(phydev, 1, LAN8814_PD_CONTROLS, val);
+}
+
 static int lan8814_probe(struct phy_device *phydev)
 {
 	const struct kszphy_type *type = phydev->drv->driver_data;
@@ -3342,6 +3360,7 @@ static int lan8814_probe(struct phy_device *phydev)
 
 	/* Errata workarounds */
 	lan8814_clear_2psp_bit(phydev);
+	lan8814_update_meas_time(phydev);
 
 	return 0;
 }
-- 
2.34.1


