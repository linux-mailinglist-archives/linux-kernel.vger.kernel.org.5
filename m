Return-Path: <linux-kernel+bounces-52180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D542E849508
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 146BF1C23380
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6318C125A3;
	Mon,  5 Feb 2024 08:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ofqlXtQk"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0469C1119B;
	Mon,  5 Feb 2024 08:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707120257; cv=none; b=BKAKaDoK3pRj1w+8k981ZEWnJZyIOznrw3zUsp0l9sjUhCRW34/Xjfg7NyLxWNptVyZkMaO9n2Kub+lcpjtOIZt+RWi2qN6KQOBg+G5PeVcwrDDSaPIICw6wB0HIfDnnThmBzvSskqRKdW5HuPUnK+Kmbwzn5xHTKON0hPemr6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707120257; c=relaxed/simple;
	bh=b8LBr+HkRiGbiofvmfhN7/Z+LuPQPfSgtATjkS2qEdA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h9QZW1RE/XWpzIqjvav0w5QpfHTCDxgQrRV8YbIODG0bWxD2zLtE0oSOv1SdPAAoESLbFuXqeYlmfbwR+/rXOR3TEljLy/2z3a46gPcdx+61nvr4H9M8Ck5Ykk4vJ0oBbpj8T+GMy3lnAzenwiNF3IZUe51BXPPVqoYYQ5sB2ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ofqlXtQk; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707120256; x=1738656256;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b8LBr+HkRiGbiofvmfhN7/Z+LuPQPfSgtATjkS2qEdA=;
  b=ofqlXtQk4Rco57oLqYPbGp0wC1LEdgyHTyHTeVM36oiWayfvElmzHCRC
   z3ZnH5+TGaHf7gaRhyQ91algJpdkqvVc5JZ+mStvXaHGCE0uIqGxPWVZQ
   6K9Wea1q8eypD/ojKsP5NQCrYFKloYWCQD0xi3w0kVL0fwWvycE9JFCsd
   l1z1T2W+U+L7RRdebEOtcDBJZDEQMZxMarq548/7biB7duqi0d8Zcj6jY
   imvBUxc54QMOgjTWLWVkQ/dX5Cu4+73R9P9i/r1+DhK8V3KpR5NrPKrPK
   dKgukiI+u6EN5wMsEA0EHt+dLwGCAv+hViz8cHN8MbooB2C1V8Ayp3rnK
   g==;
X-CSE-ConnectionGUID: /sWzmiszTQ2ztYFgEFabog==
X-CSE-MsgGUID: O4rHOnRGQkCrExiFbwDAxQ==
X-IronPort-AV: E=Sophos;i="6.05,242,1701154800"; 
   d="scan'208";a="16278233"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Feb 2024 01:01:00 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 01:00:39 -0700
Received: from virtualbox.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 5 Feb 2024 01:00:37 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH v2 3/8] ARM: dts: microchip: sama5d27_som1_ek: Add power-supply properties for sdmmc nodes
Date: Mon, 5 Feb 2024 10:00:21 +0200
Message-ID: <20240205080027.4565-4-mihai.sain@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240205080027.4565-1-mihai.sain@microchip.com>
References: <20240205080027.4565-1-mihai.sain@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The sdmmc0 and sdmmc1 controllers are powered from 3.3V regulator.
Add vmmc-supply and vqmmc-supply properties to sdmmc nodes.
The sdmmc controller from SAMA5D2 MPU has support for IO voltage signaling/switching required by the UHS sd-card.
In order to avoid the issues from the tuning procedure required by the UHS cards,
keep the vqmmc at 3V3 to use the sd high-speed mode.

Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
---
 arch/arm/boot/dts/microchip/at91-sama5d27_som1_ek.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/at91-sama5d27_som1_ek.dts b/arch/arm/boot/dts/microchip/at91-sama5d27_som1_ek.dts
index f3ffb8f01d8a..255ee0640133 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d27_som1_ek.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama5d27_som1_ek.dts
@@ -56,6 +56,8 @@ sdmmc0: sdio-host@a0000000 {
 			bus-width = <8>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_sdmmc0_default>;
+			vmmc-supply = <&vddin_3v3>;
+			vqmmc-supply = <&vddin_3v3>;
 			status = "okay";
 		};
 
@@ -63,6 +65,8 @@ sdmmc1: sdio-host@b0000000 {
 			bus-width = <4>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_sdmmc1_default>;
+			vmmc-supply = <&vddin_3v3>;
+			vqmmc-supply = <&vddin_3v3>;
 			status = "okay";
 		};
 
-- 
2.43.0


