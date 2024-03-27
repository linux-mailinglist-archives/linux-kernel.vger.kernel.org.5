Return-Path: <linux-kernel+bounces-120655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A5688DB12
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A874E1F29CB0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD4E4E1C3;
	Wed, 27 Mar 2024 10:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ncz0CEkz"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16994AED8;
	Wed, 27 Mar 2024 10:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711534679; cv=none; b=ltdCwKAT524ORI3Q3/s0CbruLaKBdRNHBisdm5rLd6T4sdrNivh0STsifahwTsixPI1uiwxOsNw6aV0udYW18muOOTW/zKunh7V1p5rjvqobUtBN/yODd72DTBGQ8FVKuzstaK/dn4bnGzlBnQbjGK2hWjnF/LsatsCDAq1Uxnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711534679; c=relaxed/simple;
	bh=TEkABNFse8CcnU3kgDIEffeA978im7yo/OMpcupmA/E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KCaZmZROIfUHxyStVvcOSAqT4kIVmf8dLbHtEoqIlpPOXEjljoNG/XPT+JEKB8y+JQG5FSFzA43ask+ZqG6nPtruYjcMR2mkUkunVGu4Bhi1UVRc5pwTB4bxIdG6C0VE2wG/XwczLD6RTNKPIjhptuSQaX1VWLMeZnuLSqTqCGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ncz0CEkz; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1711534678; x=1743070678;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TEkABNFse8CcnU3kgDIEffeA978im7yo/OMpcupmA/E=;
  b=ncz0CEkzZuZFQAYVdz+tLNQKF5d66mHq6z90lEurASm2NJrJfEcYv56N
   KbICpoRYziz2dADkYVemA7iqX05cOmIFO+/iQIK32OEfqfhzFRe/rUMBS
   LqeAFkKkRWNqk1QptEDv+zv0vloVqS8Qo2CpeDLO2RM8zKGgZhpJGXOqZ
   SLRtBakBQp4Hr6fh7ms5seEZQSWLO0JnGy2ZWznxGTWopRyM6kuKsCffM
   7TSoQjxzaxNvlYXbZJAqI3tlgT/yQAi/+m2cvs1iHkVm91eumCl8t9czB
   BRIlzywddGqlKe4wiE5RAzFJLg+BhFvW+WhNxQHUUzeWEmfDPhEflVEcq
   w==;
X-CSE-ConnectionGUID: kMW5/4znTW21czammyzWAw==
X-CSE-MsgGUID: MuiZtMkFTq+IA/MVCghvXg==
X-IronPort-AV: E=Sophos;i="6.07,158,1708412400"; 
   d="scan'208";a="249155938"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Mar 2024 03:17:52 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Mar 2024 03:17:41 -0700
Received: from archlinux.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 27 Mar 2024 03:17:38 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<lgirdwood@gmail.com>, <broonie@kernel.org>, <andrei.simion@microchip.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH 1/7] ARM: dts: microchip: sama5d27_wlsom1: Update the node names from pmic-regulators
Date: Wed, 27 Mar 2024 12:17:18 +0200
Message-ID: <20240327101724.2982-2-mihai.sain@microchip.com>
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
 arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1.dtsi b/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1.dtsi
index 4617805c7748..228382f630cc 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1.dtsi
+++ b/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1.dtsi
@@ -74,7 +74,7 @@ mcp16502@5b {
 		lpm-gpios = <&pioBU 0 GPIO_ACTIVE_LOW>;
 
 		regulators {
-			vdd_3v3: VDD_IO {
+			vdd_3v3: BUCK1 {
 				regulator-name = "VDD_IO";
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
@@ -93,7 +93,7 @@ regulator-state-mem {
 				};
 			};
 
-			vddio_ddr: VDD_DDR {
+			vddio_ddr: BUCK2 {
 				regulator-name = "VDD_DDR";
 				regulator-min-microvolt = <1200000>;
 				regulator-max-microvolt = <1200000>;
@@ -116,7 +116,7 @@ regulator-state-mem {
 				};
 			};
 
-			vdd_core: VDD_CORE {
+			vdd_core: BUCK3 {
 				regulator-name = "VDD_CORE";
 				regulator-min-microvolt = <1250000>;
 				regulator-max-microvolt = <1250000>;
@@ -135,7 +135,7 @@ regulator-state-mem {
 				};
 			};
 
-			vdd_ddr: VDD_OTHER {
+			vdd_ddr: BUCK4 {
 				regulator-name = "VDD_OTHER";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
-- 
2.44.0


