Return-Path: <linux-kernel+bounces-165970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3478B940A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 06:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8747B22F17
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 04:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB43208A5;
	Thu,  2 May 2024 04:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="DogIRlYN"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181FE12E75;
	Thu,  2 May 2024 04:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714625810; cv=none; b=tDD1G3znFZfhj/jsNLBMZY6vNygG457mf9i3hRInAYUopRrmjRXDv/Q+NLMyWtH6D4TuE3p6M9BhfiBJtH1RaFpGlKWlBBcQxQRnFgkQzMvBlN8iAW2jWTlfkk+CAbrWLC2C9Ku5RLEihPuzZJNVL6uBYcJX49lqqMAoExvvNoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714625810; c=relaxed/simple;
	bh=aMc1DcexrNSbYD0gGOeCecVJQ5h18eOGSg+fip6ng+M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a7Z3pReY7S1x2W0GNUYCQ3jxaEGVdZ5eJBut5WU+VHMb+M5CCFTlvW4y1280/Skm7vkuBGdwB8pkoejtP9fJFNdVbtfAG9oe/MFSrzP6UWeftzmDfdQ79kZLns+eyMnW9ZK0DqVF/2P6sS3eN1NF3LT0QeRlj8y0FFrBtxeB7EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=DogIRlYN; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1714625808; x=1746161808;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aMc1DcexrNSbYD0gGOeCecVJQ5h18eOGSg+fip6ng+M=;
  b=DogIRlYNTHQJdCyNUIyu1IL7YKRKfrE9NgggpYJQoZeLIzaM7DazlpEY
   i1e7Vb3mqBUF1gSGHpO/WRHLiFe2vthGZF/xgZWNHNLcicBqvnT1eNYGX
   Mj/RxJqsMOgYq7cPaARXKyfQ/6ZeGLAfm5kUVo/760Jqr4Fn68WeWwDRW
   qIAtY4nyxXSo1kaFfV9aOkQyBMZ5heVjIA+ceFID+/zuzAHeI0k+X92GS
   y4f3NHH3ZJF7M55SuYm4LfSAhWD1Q2vSkP51vnuI85y9dhWYFnpGn1OWJ
   bkxnKULxdzPP0fkYmMRb/iBuJfTP6QNnwTd7gGj56HvA8Pc60AV5Qkza6
   g==;
X-CSE-ConnectionGUID: glLAAHjaSwuU7iD71V4gfQ==
X-CSE-MsgGUID: YN21cNs8SPC6eSu8G+HnbA==
X-IronPort-AV: E=Sophos;i="6.07,247,1708412400"; 
   d="scan'208";a="23362395"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 May 2024 21:56:41 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 1 May 2024 21:56:17 -0700
Received: from che-ld-unglab06.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 1 May 2024 21:56:13 -0700
From: Rengarajan S <rengarajan.s@microchip.com>
To: <woojung.huh@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <rengarajan.s@microchip.com>
Subject: [PATCH net-next v1] lan78xx: Enable 125 MHz CLK and Auto Speed configuration for LAN7801 if NO EEPROM is detected
Date: Thu, 2 May 2024 10:25:03 +0530
Message-ID: <20240502045503.36298-1-rengarajan.s@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The 125MHz and 25MHz clock configurations are done in the initialization
regardless of EEPROM (125MHz is needed for RGMII 1000Mbps operation). After
a lite reset (lan78xx_reset), these contents go back to defaults(all 0, so
no 125MHz or 25MHz clock and no ASD/ADD). Also, after the lite reset, the
LAN7800 enables the ASD/ADD in the absence of EEPROM. There is no such
check for LAN7801.

Signed-off-by: Rengarajan S <rengarajan.s@microchip.com>
---
 drivers/net/usb/lan78xx.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index ba6c8ac2a736..62dbfff8dad4 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2944,6 +2944,8 @@ static int lan78xx_reset(struct lan78xx_net *dev)
 		return ret;
 
 	buf |= HW_CFG_MEF_;
+	buf |= HW_CFG_CLK125_EN_;
+	buf |= HW_CFG_REFCLK25_EN_;
 
 	ret = lan78xx_write_reg(dev, HW_CFG, buf);
 	if (ret < 0)
@@ -3032,8 +3034,11 @@ static int lan78xx_reset(struct lan78xx_net *dev)
 		return ret;
 
 	/* LAN7801 only has RGMII mode */
-	if (dev->chipid == ID_REV_CHIP_ID_7801_)
+	if (dev->chipid == ID_REV_CHIP_ID_7801_) {
 		buf &= ~MAC_CR_GMII_EN_;
+		/* Enable Auto Duplex and Auto speed */
+		buf |= MAC_CR_AUTO_DUPLEX_ | MAC_CR_AUTO_SPEED_;
+	}
 
 	if (dev->chipid == ID_REV_CHIP_ID_7800_ ||
 	    dev->chipid == ID_REV_CHIP_ID_7850_) {
-- 
2.25.1


