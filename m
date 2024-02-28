Return-Path: <linux-kernel+bounces-84562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FAA86A854
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 07:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF9811F261E8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 06:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E0E23757;
	Wed, 28 Feb 2024 06:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="bUbpqgpy"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8781EB27;
	Wed, 28 Feb 2024 06:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709101840; cv=none; b=H9fHu5lX+jdq8eIcsUhIuzUc0z6n7l0ec76ntrSXFtG2rELVXfRyQiVbbi0W//HSVx9sdwRyDYfjMNvQHIuixD2XLdXf1MhmBsBZW01RofrEcFKrzw7c9+gpoxqYy6xVPqjRXKghP8PhKbsgxa7zRcxAAkaZrW6Y2Ax6s5woPWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709101840; c=relaxed/simple;
	bh=yykHRE1Z1DG58ITzYPSAjX+1Z8DC7NCPRqkZBbJG4/A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LTF/IIaA1c9ii7rfwpE/7sy/TewLfqhqY7Kvv/B8n9L4+hiOHKN57LhAWoeeGEuQLEXeFFycUFCamQ5zmQJjc4pn7QczFhJVodJ0gxt0sqv0GQ9cCbTzeKpT+DsuT37nhJZQDFxGw6Oqrp/7tdmUtYMwemJ42mc1kgY3thZSNaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=bUbpqgpy; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709101839; x=1740637839;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yykHRE1Z1DG58ITzYPSAjX+1Z8DC7NCPRqkZBbJG4/A=;
  b=bUbpqgpySHTZ2jutG5hDq1C+u24QmsS5+Vxr7WYV14bRWV8DnQWd+/il
   i6ymwhWew07Ra/yj4uQjj6b1VDFferyrR7iRb7c9pL/2kbJzQrQ1B5zsC
   vZD8hmT/hCtqH1srsMYXTX+5HC7/FFLfHJ1J7J04/m2Lv+2QVyC6BIeBb
   w/HjHlBF3JuhRyWu9IAwPhbfi7UgyoNC1AhysGwxeDqFTCyam5T9PtLwT
   8NWWCFaDD6KrszfrMhWF++huQ2SNLSn5NLf4xhzFgK/CqRckBWym/1L8X
   3sd8TMLejkkCClUVEUoCMpnDZXVet7gltCIri/Yv2VE2Kg6xt3B6vKVfs
   A==;
X-CSE-ConnectionGUID: WwtfXDcGT3ekg/b+aiH4Eg==
X-CSE-MsgGUID: jGD6Xd8wRRq4FYvG5xft5w==
X-IronPort-AV: E=Sophos;i="6.06,190,1705388400"; 
   d="scan'208";a="247685635"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Feb 2024 23:30:36 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 23:30:08 -0700
Received: from DEN-DL-M31836.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 27 Feb 2024 23:30:06 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH net-next 2/2] net: phy: micrel: lan8814 cable improvement errata
Date: Wed, 28 Feb 2024 07:28:13 +0100
Message-ID: <20240228062813.1007138-3-horatiu.vultur@microchip.com>
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
 drivers/net/phy/micrel.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 5a0cc89eaebdd..1e3b0436e161e 100644
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
@@ -3302,6 +3306,12 @@ static void lan8814_errata_fixes(struct phy_device *phydev)
 	val = lanphy_read_page_reg(phydev, 2, LAN8814_EEE_STATE);
 	val &= ~LAN8814_EEE_STATE_MASK2P5P;
 	lanphy_write_page_reg(phydev, 2, LAN8814_EEE_STATE, val);
+
+	/* Improve cable reach beyond 100m */
+	val = lanphy_read_page_reg(phydev, 1, LAN8814_PD_CONTROLS);
+	val &= ~LAN8814_PD_CONTROLS_PD_MEAS_TIME_MASK_;
+	val |= LAN8814_PD_CONTROLS_PD_MEAS_TIME_VAL_;
+	lanphy_write_page_reg(phydev, 1, LAN8814_PD_CONTROLS, val);
 }
 
 static int lan8814_probe(struct phy_device *phydev)
-- 
2.34.1


