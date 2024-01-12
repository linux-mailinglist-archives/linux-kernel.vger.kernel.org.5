Return-Path: <linux-kernel+bounces-24503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE16C82BD8E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 10:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E395B25BF3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 09:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326C95DF0D;
	Fri, 12 Jan 2024 09:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FKWxU0tL"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD275C917;
	Fri, 12 Jan 2024 09:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705052802;
	bh=tcjP/leN4XCKBtnz42PrTROUO/R9BBYO3TR0UYOJr+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FKWxU0tLKPRq7PUUfGwWOYH1GFrkkrHM6458oM5xWZ/GeXhV8ZlYbykzaS0XpRyYc
	 HE7XSNoF4UbofLzNrGwd+nIfXM1JItfGv4hUqCBa3lyF0ZH75DxOfSOZV+RZi140Sa
	 YMEcOUXlIitOvtODF+fMna2y/I+Nuy8rJdNZ00Sm3Bh0MD1MpV8M1f+sOvgPO669/Q
	 uNY7uNR1PCuhXmyPGdQu913U629lv6PuHGBBTw8gKCLUxYZcYnBIr6JHoWH7k2heIS
	 Jais5HX7BxjOZDWGtiN+njkMcoPsT9DocQoVbger90Vg3sJmJ/QD820GvGquEXlU9j
	 O4SagNXw/95bQ==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id BA8FF3782033;
	Fri, 12 Jan 2024 09:46:41 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-mediatek@lists.infradead.org
Cc: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	wenst@chromium.org,
	hsinyi@chromium.org,
	nfraprado@collabora.com,
	macpaul.lin@mediatek.com,
	sean.wang@mediatek.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH 04/15] arm64: dts: mediatek: radxa-nio-12l: Add external MT6360 PMIC on I2C6
Date: Fri, 12 Jan 2024 10:46:21 +0100
Message-ID: <20240112094632.66310-5-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240112094632.66310-1-angelogioacchino.delregno@collabora.com>
References: <20240112094632.66310-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for adding the power tree for this board, add a node for
the MT6360 PMIC, connected to I2C6.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../dts/mediatek/mt8395-radxa-nio-12l.dts     | 20 ++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts b/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
index 79358e1a3e60..281847b8f022 100644
--- a/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
@@ -8,6 +8,7 @@
  */
 
 #include "mt8195.dtsi"
+#include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/pinctrl/mt8195-pinfunc.h>
 
 / {
@@ -109,7 +110,15 @@ &i2c6 {
 	pinctrl-names = "default";
 	status = "okay";
 
-	/* MT6360 PMIC at 0x34 */
+	mt6360: pmic@34 {
+		compatible = "mediatek,mt6360";
+		reg = <0x34>;
+		interrupts-extended = <&pio 101 IRQ_TYPE_EDGE_FALLING>;
+		interrupt-names = "IRQB";
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		pinctrl-0 = <&mt6360_pins>;
+	};
 };
 
 &pio {
@@ -140,6 +149,15 @@ pins {
 		};
 	};
 
+	mt6360_pins: mt6360-pins {
+		pins-irq {
+			pinmux = <PINMUX_GPIO100__FUNC_GPIO100>,
+				 <PINMUX_GPIO101__FUNC_GPIO101>;
+			input-enable;
+			bias-pull-up;
+		};
+	};
+
 	uart0_pins: uart0-pins {
 		pins-bus {
 			pinmux = <PINMUX_GPIO98__FUNC_UTXD0>,
-- 
2.43.0


