Return-Path: <linux-kernel+bounces-90287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E061F86FCEF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DB88B21F45
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E642620310;
	Mon,  4 Mar 2024 09:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="AIZiYfau"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2931B801;
	Mon,  4 Mar 2024 09:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709543810; cv=none; b=PNwpm/+5pAsFFnQCmPOn+1xQPo7W4TW4ENjokzbv2j0DSqyS3iXbjuC1onz0Z6TC7xdDifn0DjziwPup2pF4r/IkVP0i6e7Zx/TIeQOmtgyuzQd8GZEYXQ3Jo2Jlbd7BCQseYFx3iYmhvhiJEHU6sWUZGMrzkWWnlV8cWmWnbh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709543810; c=relaxed/simple;
	bh=BkrF617xwkwNY1RZs7y/Blv4nDks9Xbe6MUsFO6cYPw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ky8R3lh4/0fXkzE595pBY40t2JOHEwbcdEWYHpiAwLNGI5d1jlf6caMy7OuIjxweMLyoi8LIv0Grz15XBpDcYAb785bjZxNZ4IZhkwJrNV0TzUq3e1j7nD5/SxgULtJGTHFrbGsxWcJ+EB8gMhag8Lib5Ey8okGjWci8OhdBTDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=AIZiYfau; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709543809; x=1741079809;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BkrF617xwkwNY1RZs7y/Blv4nDks9Xbe6MUsFO6cYPw=;
  b=AIZiYfauVX+i0n5mql7KF4nf8zPog2AD+XlhJPzhmBpbzzNmpUbEWE/w
   2+228BvgWFG9QzUgMwIWeUptqPSg6n705E3OAi2A+MIGYrF5yo0JMgkyZ
   wyylXXOn9Wa+ZCfkZfD20m1A5N4Yn93iMWu3S6i7uf0vOFhnjXV1dct0C
   42WxE8epnC6oz7rnzsOig+KsU3xaUZbMc6U8FyrGpb9FL631p85vcmHcZ
   xF2CaNLnIXwhTVV6v4vj6LUXPbGgS1eI2Nr8LegY9iFO2WLLfBRPMo6fB
   cFKwTbvp7JXMD7MNQYw4wSly/7F/qhh7v+4q4IpP1xz5VPLzocLyOrIhP
   g==;
X-CSE-ConnectionGUID: UAxa/GSoQIW4jsMaPoMz9g==
X-CSE-MsgGUID: wI874TKgQ2+tNzKPW9CC6g==
X-IronPort-AV: E=Sophos;i="6.06,203,1705388400"; 
   d="scan'208";a="247914611"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Mar 2024 02:16:47 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 02:16:25 -0700
Received: from DEN-DL-M31836.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 4 Mar 2024 02:16:22 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <wojciech.drewek@intel.com>,
	<arun.ramadoss@microchip.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH net-next v3 1/2] net: phy: micrel: lan8814 led errata
Date: Mon, 4 Mar 2024 10:15:47 +0100
Message-ID: <20240304091548.1386022-2-horatiu.vultur@microchip.com>
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

Lan8814 phy led behavior is not correct. It was noticed that the led
still remains ON when the cable is unplugged while there was traffic
passing at that time.

The fix consists in clearing bit 10 of register 0x38, in this way the
led behaviour is correct and gets OFF when there is no link.

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/net/phy/micrel.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 9b69735819896..88cc03982bb78 100644
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
 
+static void lan8814_clear_2psp_bit(struct phy_device *phydev)
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
@@ -3324,6 +3340,9 @@ static int lan8814_probe(struct phy_device *phydev)
 
 	lan8814_ptp_init(phydev);
 
+	/* Errata workarounds */
+	lan8814_clear_2psp_bit(phydev);
+
 	return 0;
 }
 
-- 
2.34.1


