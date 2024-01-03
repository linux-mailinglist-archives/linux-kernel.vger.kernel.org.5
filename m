Return-Path: <linux-kernel+bounces-15856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9E182345B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 428731C23F01
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 18:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02751D54A;
	Wed,  3 Jan 2024 18:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="lTB6xqf9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A28E1C6BD
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 18:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20240103181227ed3c3e29cfde8bd91e
        for <linux-kernel@vger.kernel.org>;
        Wed, 03 Jan 2024 19:12:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=lZ1Cv4I82IjrNQxqXJm5ReePt00Huq/NrgvU4k4cYLU=;
 b=lTB6xqf9ux7jIdMRft8n4BODLmcyq4LxIy0lyYXfIQEb8VVPX8UDkeRzxW+pEZvuEaiTNs
 gdptJ+A/ZPYodq3QrcnTDImj/Kjktwwe73KavKZnZJ9uxAFiheZwotG6hxPMmTqTdUZ5Yhr9
 mcErT3EVi3gvSzBUa07sj+e2xRutU=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Bao Cheng Su <baocheng.su@siemens.com>
Subject: [PATCH v2 6/7] arm64: dts: ti: iot2050: Annotate LED nodes
Date: Wed,  3 Jan 2024 19:12:23 +0100
Message-Id: <7161f18b049e57c36b21cbe0e0caf046bf6b318e.1704305544.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1704305544.git.jan.kiszka@siemens.com>
References: <cover.1704305544.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

Add function and color properties and use the common scheme for the node
name. We can't change the user-visible labels, though, due to existing
userspace relying on the current format.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../boot/dts/ti/k3-am65-iot2050-common.dtsi   | 31 +++++++++++++++----
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
index 3ecdd63760e5..46de685cd0f2 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
@@ -10,6 +10,7 @@
  */
 
 #include "k3-am654.dtsi"
+#include <dt-bindings/leds/common.h>
 #include <dt-bindings/phy/phy.h>
 #include <dt-bindings/net/ti-dp83867.h>
 
@@ -83,28 +84,46 @@ leds {
 		pinctrl-names = "default";
 		pinctrl-0 = <&leds_pins_default>;
 
-		status-led-red {
+		led-0 {
+			color = <LED_COLOR_ID_RED>;
+			function = LED_FUNCTION_STATUS;
+			label = "status-led-red";
 			gpios = <&wkup_gpio0 32 GPIO_ACTIVE_HIGH>;
 			panic-indicator;
 		};
 
-		status-led-green {
+		led-1 {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_STATUS;
+			label = "status-led-green";
 			gpios = <&wkup_gpio0 24 GPIO_ACTIVE_HIGH>;
 		};
 
-		user-led1-red {
+		led-2 {
+			color = <LED_COLOR_ID_RED>;
+			function = LED_FUNCTION_INDICATOR;
+			label = "user-led1-red";
 			gpios = <&pcal9535_3 14 GPIO_ACTIVE_HIGH>;
 		};
 
-		user-led1-green {
+		led-3 {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_INDICATOR;
+			label = "user-led1-green";
 			gpios = <&pcal9535_2 15 GPIO_ACTIVE_HIGH>;
 		};
 
-		user-led2-red {
+		led-4 {
+			color = <LED_COLOR_ID_RED>;
+			function = LED_FUNCTION_INDICATOR;
+			label = "user-led2-red";
 			gpios = <&wkup_gpio0 17 GPIO_ACTIVE_HIGH>;
 		};
 
-		user-led2-green {
+		led-5 {
+			color = <LED_COLOR_ID_RED>;
+			function = LED_FUNCTION_INDICATOR;
+			label = "user-led2-green";
 			gpios = <&wkup_gpio0 22 GPIO_ACTIVE_HIGH>;
 		};
 	};
-- 
2.35.3


