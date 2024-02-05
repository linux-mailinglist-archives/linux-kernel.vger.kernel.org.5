Return-Path: <linux-kernel+bounces-52178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F7A849502
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3011F1F238F8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F415D11198;
	Mon,  5 Feb 2024 08:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="LVz6LSBS"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6CE1118F;
	Mon,  5 Feb 2024 08:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707120255; cv=none; b=JRlnDvlMw+jao8cMQfsFu7mbsr+dnJrs1WoBO4jm3aloKqn+ag6cbSKrtTjgmRWcMP+mV4QPHFZTEmVwy6fjTb/Fj6+dN+q5qzLXSZpKEeOXDUyEgfPCoth1biPEL78Iv8ve7gvRdThCxE1pjAe0wKsfdUhGgw5ox8MUgbss4Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707120255; c=relaxed/simple;
	bh=0G42BUGboCGoo34pO1Db6WnsOP+8JX9KsFZBc11vQE4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p/g+84xT3aTPHL+PDMpT6M31VfUxQI7tfs6UVRp6wz2vaxpZ6Bv8vT8QkEBPK9sKfh5l8rGJIYQhfEuQEYVbNyaRRA2bdj2t9jSmCh5g/Fhx+vBEktdE/fOkPad3ylYUR5QIcdAN3ywWbV9sRMfPfWGMT1DjRGmKPz55oExE//Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=LVz6LSBS; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707120253; x=1738656253;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0G42BUGboCGoo34pO1Db6WnsOP+8JX9KsFZBc11vQE4=;
  b=LVz6LSBSXR3sv9rWH65q2KMwPib75cF5Q5l5+soureR6UjwJkOQ+0aJH
   8p4lhApkT0nB6dDI7Am5K65qROW2OzCKHAs8MFeiYTrwYu84zzuqRHLw9
   Z2G1llWoDSa7zTQ5gSHz0m5/x/EvcchX4XO58Xx8Wh2jP1t9/oCtx1mvk
   wqqd5IG+mMimnAuWLjGnqbYERvwKw887FUm9psxN5Tu7PTVRmQ+XWQAsh
   4LM5AF7MGDcJcSF2UO2jTsyJd9l9cbjSqM4sypnzO6pWu9lYk4KkJvUP9
   LqkUJi2V2sCN63cPqKHrcPZPUj6X6v2ami5z6omPGZeAzos2ZJcBA6MxE
   A==;
X-CSE-ConnectionGUID: /sWzmiszTQ2ztYFgEFabog==
X-CSE-MsgGUID: XMXmmH8QTtuZ15kYF9VAMg==
X-IronPort-AV: E=Sophos;i="6.05,242,1701154800"; 
   d="scan'208";a="16278226"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Feb 2024 01:00:58 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 01:00:34 -0700
Received: from virtualbox.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 5 Feb 2024 01:00:32 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH v2 1/8] ARM: dts: microchip: sam9x60_curiosity: Add power-supply properties for sdmmc nodes
Date: Mon, 5 Feb 2024 10:00:19 +0200
Message-ID: <20240205080027.4565-2-mihai.sain@microchip.com>
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
The sdmmc controller from SAM9X60 MPU doesn't support the IO voltage signaling/switching required by the UHS sd-card.
In order to use the sd high-speed mode, keep vqmmc at 3V3.

Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
---
 arch/arm/boot/dts/microchip/at91-sam9x60_curiosity.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/at91-sam9x60_curiosity.dts b/arch/arm/boot/dts/microchip/at91-sam9x60_curiosity.dts
index c6fbdd29019f..457c54dde0b7 100644
--- a/arch/arm/boot/dts/microchip/at91-sam9x60_curiosity.dts
+++ b/arch/arm/boot/dts/microchip/at91-sam9x60_curiosity.dts
@@ -452,6 +452,8 @@ &sdmmc0 {
 	pinctrl-0 = <&pinctrl_sdmmc0_default &pinctrl_sdmmc0_cd>;
 	cd-gpios = <&pioA 25 GPIO_ACTIVE_LOW>;
 	disable-wp;
+	vmmc-supply = <&vdd1_3v3>;
+	vqmmc-supply = <&vdd1_3v3>;
 	status = "okay";
 };
 
@@ -460,6 +462,8 @@ &sdmmc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sdmmc1_default>;
 	disable-wp;
+	vmmc-supply = <&vdd1_3v3>;
+	vqmmc-supply = <&vdd1_3v3>;
 	status = "okay";
 };
 
-- 
2.43.0


