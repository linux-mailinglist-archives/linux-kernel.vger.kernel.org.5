Return-Path: <linux-kernel+bounces-87386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBD886D3B8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6D49284F33
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C471428E3;
	Thu, 29 Feb 2024 19:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="rOLcLMbC"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D13C13C9F7;
	Thu, 29 Feb 2024 19:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709236388; cv=none; b=kTVzi4Xiqi75V3LnHIPnnPW7ytFY90q164Cguce8For0orvMKviVIjLlWBQT8Fpzc/lVJvtpYuCQ3PpXPpWhoY9Y3Z3cIpbNmw7mNiEQv3NITAi0TfAUSv/Ck67pxS/GUdZaz7sdPvdvpINQCsjUNT/aAQcCBPX+j5ySENIp7bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709236388; c=relaxed/simple;
	bh=gmYPlJjIF0Hbvmzz48jcajCXOb7Cc/tg1xpCPkEClkE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fFhGzkAutTXYiavy/YQWPL03hgcl/vlEsHJQaa1iffpLagXplLBT2zRi539LeOtko8QwOErm9On2wS7myB+YA8rVxmdX8M+23ql+R0SYtMT5AERBLEWOu+EinRSQEfYmmDkOQPgJYWtpBCS/Wfgqs6c7iqRXtGe4Ju1i29ydrQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=rOLcLMbC; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709236386; x=1740772386;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gmYPlJjIF0Hbvmzz48jcajCXOb7Cc/tg1xpCPkEClkE=;
  b=rOLcLMbCAyfFte8NE+e0TgGVNjNk7iKCeCHCTwPFHKdv1RnqUouBtNng
   OhbqooJYbFe76NY+o41rTtJomBeFcH3yDSVB/1SxbGUlEUdG7o+nD0M5p
   Qjduh5KFOvVCvIhhNI+rVrNraR6uo5/d3Wglxhs8Uepfa+VTaMOOEO2MB
   ZaIR63e1Aq3jv3eEss1fU9lQjXevVmfw0TXUBInFfBD2fHW57MRuk2hkh
   0PVU3XTPSOs41FPJ8QMdZqwzVqPLYumTEKBiiED+L+eiGCHSNBr4oxKEV
   DEe2K+1dHEkTkjSWYHR80c3myutabCQBuVbT3Ifb1qd+/xpRlLFVwx8Zy
   Q==;
X-CSE-ConnectionGUID: lxx6YzUCRQKZ1uyD65VsbA==
X-CSE-MsgGUID: CRFUDg9/QKWC5e255Mix+g==
X-IronPort-AV: E=Sophos;i="6.06,194,1705388400"; 
   d="scan'208";a="184305290"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Feb 2024 12:53:05 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 29 Feb 2024 12:52:40 -0700
Received: from DEN-DL-M31836.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 29 Feb 2024 12:52:38 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <wojciech.drewek@intel.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH net-next v2 1/2] net: phy: micrel: lan8814 led errata
Date: Thu, 29 Feb 2024 20:52:19 +0100
Message-ID: <20240229195220.2673049-2-horatiu.vultur@microchip.com>
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

Lan8814 phy led behavior is not correct. It was noticed that the led
still remains ON when the cable is unplugged while there was traffic
passing at that time.

The fix consists in clearing bit 10 of register 0x38, in this way the
led behaviour is correct and gets OFF when there is no link.

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


