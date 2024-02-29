Return-Path: <linux-kernel+bounces-86641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 024F886C843
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A317228887D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79DC7CF1B;
	Thu, 29 Feb 2024 11:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="NNZbJ/9t"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5427C6D2;
	Thu, 29 Feb 2024 11:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709206909; cv=none; b=KofrE2jrrCmYZ92Uislh7UXlB22n554Xf7OSw0MxGqygyO0iwzh+2Rk6qbM8wspkOAQcPKXzF+pyaAydDjqsyxI/iHDY9EMaqkECRkiSsk5nFOFv2DGaRMVqKW5gipubb2qeBmAEefIv7Wt8YI43cqHiopNEhsK4B+WDT0+ujNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709206909; c=relaxed/simple;
	bh=okvhTFBRLW4R7YsUbijePM2TCWLMQsafMS/zHyX7gbA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Ir1aIxx8J0uv2xAwVhgGuSdT+xZJ49pFIGEAHvwiagghPnpRpoGggflh7BUJNCxGyaxBsTWWaCluxvUfiZC6t35jdJdmmcfHk/oHc/aw2WxJkeIvY7zNtdD/0cWy/xf1QQst1X0MYzildbfARRL4Tsr9s2/6P0dXoAMyhktQHQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=NNZbJ/9t; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709206907; x=1740742907;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=okvhTFBRLW4R7YsUbijePM2TCWLMQsafMS/zHyX7gbA=;
  b=NNZbJ/9tpJFaweG7svxcVdENvn41ZCv0vaB1MQzAuSftp44ksAiNJiEY
   XMsovhp8vctBs7zEZTxxHAZnWQ2B7GISEVzQVrnjrP6YMNJtLZglKolQp
   ge8L63NMlt8eGJdOc6UF3HeAMB6TWM8PH5PlcOxurypvNPOzn1XgzUcav
   tHd0H8zqLGdyxEthESpXPGf3Uc59DE+3qQbHBVx332ev9CbThXCflHVIU
   oiyhIHT5YlJMMfNws7oyx28sV6H1PRhLJTIEjFEjOpmyge1qrdz3Jl79Q
   Umc1nhb2u0Ne9tROwYGkmVrvcsTKV3LUnnKGJ14/NyV014F2C1Gge+JiY
   g==;
X-CSE-ConnectionGUID: 3CkcnVRnRlyAYMMQwYqwlA==
X-CSE-MsgGUID: EU6h/PGDTPyePZNLbNrRIg==
X-IronPort-AV: E=Sophos;i="6.06,194,1705388400"; 
   d="scan'208";a="17008186"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Feb 2024 04:41:42 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 29 Feb 2024 04:41:37 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 29 Feb 2024 04:41:33 -0700
From: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Date: Thu, 29 Feb 2024 17:09:30 +0530
Subject: [PATCH 1/3] ARM: dts: microchip: sama5d2: Move pinfunc.h headers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240229-pio4-pinctrl-yaml-v1-1-c4d8279c083f@microchip.com>
References: <20240229-pio4-pinctrl-yaml-v1-0-c4d8279c083f@microchip.com>
In-Reply-To: <20240229-pio4-pinctrl-yaml-v1-0-c4d8279c083f@microchip.com>
To: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Linus Walleij <linus.walleij@linaro.org>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>, "Balakrishnan
 Sambath" <balakrishnan.s@microchip.com>
X-Mailer: b4 0.13.0

Move sama5d2-pinfunc.h into include/dt-bindings/pinctrl so that we can
include it in yaml dt-binding examples.

Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>
---
 arch/arm/boot/dts/microchip/at91-kizbox3_common.dtsi                    | 2 +-
 arch/arm/boot/dts/microchip/at91-sama5d27_som1.dtsi                     | 2 +-
 arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1.dtsi                   | 2 +-
 arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts                 | 2 +-
 arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts                        | 2 +-
 arch/arm/boot/dts/microchip/at91-sama5d2_ptc_ek.dts                     | 2 +-
 arch/arm/boot/dts/microchip/at91-sama5d2_xplained.dts                   | 2 +-
 .../dts/microchip => include/dt-bindings/pinctrl}/sama5d2-pinfunc.h     | 0
 8 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/microchip/at91-kizbox3_common.dtsi b/arch/arm/boot/dts/microchip/at91-kizbox3_common.dtsi
index 465664628419..30a0119d260e 100644
--- a/arch/arm/boot/dts/microchip/at91-kizbox3_common.dtsi
+++ b/arch/arm/boot/dts/microchip/at91-kizbox3_common.dtsi
@@ -11,7 +11,7 @@
  */
 /dts-v1/;
 #include "sama5d2.dtsi"
-#include "sama5d2-pinfunc.h"
+#include <dt-bindings/pinctrl/sama5d2-pinfunc.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/mfd/atmel-flexcom.h>
 #include <dt-bindings/pinctrl/at91.h>
diff --git a/arch/arm/boot/dts/microchip/at91-sama5d27_som1.dtsi b/arch/arm/boot/dts/microchip/at91-sama5d27_som1.dtsi
index 95ecb7d040a8..6c8f658ec51c 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d27_som1.dtsi
+++ b/arch/arm/boot/dts/microchip/at91-sama5d27_som1.dtsi
@@ -7,7 +7,7 @@
  *                2017 Claudiu Beznea <claudiu.beznea@microchip.com>
  */
 #include "sama5d2.dtsi"
-#include "sama5d2-pinfunc.h"
+#include <dt-bindings/pinctrl/sama5d2-pinfunc.h>
 #include <dt-bindings/gpio/gpio.h>
 
 / {
diff --git a/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1.dtsi b/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1.dtsi
index 4617805c7748..6b8e688bb98a 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1.dtsi
+++ b/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1.dtsi
@@ -8,7 +8,7 @@
  * Author: Eugen Hristev <eugen.hristev@microcihp.com>
  */
 #include "sama5d2.dtsi"
-#include "sama5d2-pinfunc.h"
+#include <dt-bindings/pinctrl/sama5d2-pinfunc.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/mfd/atmel-flexcom.h>
 #include <dt-bindings/pinctrl/at91.h>
diff --git a/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts b/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts
index 6b02b7bcfd49..944cc68784a4 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts
@@ -9,7 +9,7 @@
  */
 /dts-v1/;
 #include "sama5d29.dtsi"
-#include "sama5d2-pinfunc.h"
+#include <dt-bindings/pinctrl/sama5d2-pinfunc.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/mfd/atmel-flexcom.h>
diff --git a/arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts b/arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts
index 999adeca6f33..62d331db8dd5 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts
@@ -10,7 +10,7 @@
  */
 /dts-v1/;
 #include "sama5d2.dtsi"
-#include "sama5d2-pinfunc.h"
+#include <dt-bindings/pinctrl/sama5d2-pinfunc.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/mfd/atmel-flexcom.h>
diff --git a/arch/arm/boot/dts/microchip/at91-sama5d2_ptc_ek.dts b/arch/arm/boot/dts/microchip/at91-sama5d2_ptc_ek.dts
index 200b20515ab1..28df6bc7b28f 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d2_ptc_ek.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama5d2_ptc_ek.dts
@@ -8,7 +8,7 @@
  */
 /dts-v1/;
 #include "sama5d2.dtsi"
-#include "sama5d2-pinfunc.h"
+#include <dt-bindings/pinctrl/sama5d2-pinfunc.h>
 #include <dt-bindings/mfd/atmel-flexcom.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
diff --git a/arch/arm/boot/dts/microchip/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/microchip/at91-sama5d2_xplained.dts
index 6680031387e8..60adaae39c83 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama5d2_xplained.dts
@@ -7,7 +7,7 @@
  */
 /dts-v1/;
 #include "sama5d2.dtsi"
-#include "sama5d2-pinfunc.h"
+#include <dt-bindings/pinctrl/sama5d2-pinfunc.h>
 #include <dt-bindings/mfd/atmel-flexcom.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
diff --git a/arch/arm/boot/dts/microchip/sama5d2-pinfunc.h b/include/dt-bindings/pinctrl/sama5d2-pinfunc.h
similarity index 100%
rename from arch/arm/boot/dts/microchip/sama5d2-pinfunc.h
rename to include/dt-bindings/pinctrl/sama5d2-pinfunc.h

-- 
2.25.1


