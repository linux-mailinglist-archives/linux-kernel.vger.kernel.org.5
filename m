Return-Path: <linux-kernel+bounces-87387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2487F86D3BB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8260286CB7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D30E142908;
	Thu, 29 Feb 2024 19:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="w4v0zCMO"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9682E13D2ED;
	Thu, 29 Feb 2024 19:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709236390; cv=none; b=p7lWibFepr4gQ4vYg/uarjpfolJvx+UJ5a6uVyuxq/G0cGberXIbIYh0mqSpvNVuL4zDMYYnu2skROqI9zJxvoubI2gwBGE7+q+75Xcd6/BDQl0NL+mKEqLFWvfTRC/VcESfd70dOnnfTwpocu3Ed+3nsHInn4cdOmaMvwf1IOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709236390; c=relaxed/simple;
	bh=e3ssywAqf1JTE2bsPBxD0CbekMQX8/goeW7QMUsDhkU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ha5tMPI+ncXNeCx+h4RhvLxCE7s6NYtMde3AX60K574C4+aYyjDjQ746b57uVGECfWR2xIyR9Q/2r1RSt03z2QB5zDHWDa21h102YnOk0Cp5DKY64nRl5kaZFqDKxgUIparPbbEHO/cJyTZrubSQ54g4pIsR5CSVHSqG9aVg3g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=w4v0zCMO; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709236388; x=1740772388;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e3ssywAqf1JTE2bsPBxD0CbekMQX8/goeW7QMUsDhkU=;
  b=w4v0zCMOnJKa9FzMVB119PA2YVqejUOXD3fdes9X9unKdL2LqJF27VEd
   /lHqhofMfBZ+0n0CL8lB+2sxQZ8NRCppaom4lF219ZjW5/0GjO//0htJB
   qLRCCUicBG85wcGPUjhvW4oojHO+TModfcLBIJQwTYmoImcRG5SQfc8nB
   9H2D01Lath1Cw67PmAlZ2zbCNAMLcfSGD7p7MzK3fdbVfRthT/LfVVzQ9
   yPUYt4dsFknyyi/PUd9n704mAp7QXyZqiL06d7A6j9lWjZZyh+eSBHbRC
   2O7qGU+dKB2GFqcLsxfmO5+6i8OSpHvJMTXVy9WWhhR5qhYhnqyOhUm80
   A==;
X-CSE-ConnectionGUID: lxx6YzUCRQKZ1uyD65VsbA==
X-CSE-MsgGUID: 03tnWxpGSbiXi9OrHFSHMw==
X-IronPort-AV: E=Sophos;i="6.06,194,1705388400"; 
   d="scan'208";a="184305291"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Feb 2024 12:53:05 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 29 Feb 2024 12:52:43 -0700
Received: from DEN-DL-M31836.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 29 Feb 2024 12:52:40 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <wojciech.drewek@intel.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH net-next v2 2/2] net: phy: micrel: lan8814 cable improvement errata
Date: Thu, 29 Feb 2024 20:52:20 +0100
Message-ID: <20240229195220.2673049-3-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240229195220.2673049-1-horatiu.vultur@microchip.com>
References: <20240229195220.2673049-1-horatiu.vultur@microchip.com>
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

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/net/phy/micrel.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 88cc03982bb78..788fdd54fd22d 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -117,6 +117,10 @@
 #define LAN8814_EEE_STATE			0x38
 #define LAN8814_EEE_STATE_MASK2P5P		BIT(10)
 
+#define LAN8814_PD_CONTROLS			0x9d
+#define LAN8814_PD_CONTROLS_PD_MEAS_TIME_MASK_	GENMASK(3, 0)
+#define LAN8814_PD_CONTROLS_PD_MEAS_TIME_VAL_	0xb
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
+	val &= ~LAN8814_PD_CONTROLS_PD_MEAS_TIME_MASK_;
+	val |= LAN8814_PD_CONTROLS_PD_MEAS_TIME_VAL_;
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


