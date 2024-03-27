Return-Path: <linux-kernel+bounces-120656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CC488DB15
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0340AB23733
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5B54BA94;
	Wed, 27 Mar 2024 10:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="pTlNnbc1"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4835C4AED3;
	Wed, 27 Mar 2024 10:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711534703; cv=none; b=rLBvps+8FHMVxWQ5iSY9Ve4p26KZiZkB6PpyzY2pfFKWBjVxmv91tdsDuFWq5cW+Iup7Jf7pQeumj4o+/mczjozwbT8EHfJNu3EEGkZguNHzgaC5sxuJjcPWSkFhphABNPgKUKvdmgPJV8hfUcDT8Uorn0yXepmngDsZ2LgQCo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711534703; c=relaxed/simple;
	bh=mrpZq+2IhH09H8vRJkafUX3lwv1PhGwDbdtVPupkg30=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KxidoE50diKHGeqlmJ97gQlL3eaWZPySGBfgDJJMxf7dhiy1PE7T5ckZCuKxdfria9q5Qsgxqv0QLINm7XjyjPhpf9p8Z4GuF7Jk7yUtHQogphgwO1Z6ha3jMut7NplBNYv3NS7FFBXELpS4eo3p9buX3QJ5o2mjfh1afTbXM1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=pTlNnbc1; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1711534703; x=1743070703;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mrpZq+2IhH09H8vRJkafUX3lwv1PhGwDbdtVPupkg30=;
  b=pTlNnbc1JlHnoQ10UX6L+D7rxu6YDYpTm7ZXs+Vk0HBAh0Fbu6jW00mb
   cqKKlVk6ObYFoIYKvw1vOx+1KrNVLUf7DKLPuRiUgV7uO/mKT6c7eUIdd
   3BTBZMXiBwBMFcJkUhkVdmOruverH5yd+LHBbpIDl8g9u2ahtJJdReQx7
   c+rxKiJqK6T9hs+AZR+4Y+hXkYfQb8uSzN/SceTwR7FvV+wTsSuBB0g1E
   n3e/wxFuReeWYLtrDCUZLL5AI7afADDDMyYUg0mPTXqoTRYQun0QJFK1k
   yDk7tWzFJT1TRxWfzackYfFSJmw3bwNliezY3RIoLQgsVJ7UmNaQvxaM3
   w==;
X-CSE-ConnectionGUID: calzwGTlQgCl6fVaUG6ALA==
X-CSE-MsgGUID: s35crSE5TBi9xcUt4CFXNA==
X-IronPort-AV: E=Sophos;i="6.07,158,1708412400"; 
   d="scan'208";a="18378689"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Mar 2024 03:18:22 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Mar 2024 03:17:44 -0700
Received: from archlinux.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 27 Mar 2024 03:17:41 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<lgirdwood@gmail.com>, <broonie@kernel.org>, <andrei.simion@microchip.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH 2/7] ARM: dts: microchip: sama5d29_curiosity: Update the node names from pmic-regulators
Date: Wed, 27 Mar 2024 12:17:19 +0200
Message-ID: <20240327101724.2982-3-mihai.sain@microchip.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240327101724.2982-1-mihai.sain@microchip.com>
References: <20240327101724.2982-1-mihai.sain@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Update the node names from pmic-regulators in order to match
the datasheet and driver namings for buck regulators.
Using BUCK1-4 as node names is consistent with the node naming rules.

Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
---
 arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts b/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts
index 6b02b7bcfd49..b1874ae8dfc2 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts
@@ -148,7 +148,7 @@ mcp16502@5b {
 		lpm-gpios = <&pioBU 0 GPIO_ACTIVE_LOW>;
 
 		regulators {
-			vdd_3v3: VDD_IO {
+			vdd_3v3: BUCK1 {
 				regulator-name = "VDD_IO";
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
@@ -167,7 +167,7 @@ regulator-state-mem {
 				};
 			};
 
-			vddio_ddr: VDD_DDR {
+			vddio_ddr: BUCK2 {
 				regulator-name = "VDD_DDR";
 				regulator-min-microvolt = <1200000>;
 				regulator-max-microvolt = <1200000>;
@@ -190,7 +190,7 @@ regulator-state-mem {
 				};
 			};
 
-			vdd_core: VDD_CORE {
+			vdd_core: BUCK3 {
 				regulator-name = "VDD_CORE";
 				regulator-min-microvolt = <1250000>;
 				regulator-max-microvolt = <1250000>;
@@ -209,7 +209,7 @@ regulator-state-mem {
 				};
 			};
 
-			vdd_ddr: VDD_OTHER {
+			vdd_ddr: BUCK4 {
 				regulator-name = "VDD_OTHER";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
-- 
2.44.0


