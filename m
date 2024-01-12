Return-Path: <linux-kernel+bounces-24513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 532A182BDA4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 10:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E42F61F21C69
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 09:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EE361675;
	Fri, 12 Jan 2024 09:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="h32px89D"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948D760EC7;
	Fri, 12 Jan 2024 09:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705052811;
	bh=45PTVpu/MLu2XZLF4j9xTan9RiiNLjDK7dk9hPp3Oa4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h32px89Di+MFxlU4WfgB9Ae9JEHxh0IupX7Upv6vnZxdkdRucyxJFba76WXCH3o8H
	 3hc1V6jW5JIsW/bN3t2kPvFEciK08WNpZauxW0Q59JIOHk2UsVvh8c0Eql32QnDiEz
	 JUPgbLF2TX0Oh43I6EgGRC9kLjA7em93mvnwWckmkdCVz4ayd+YFvK0N0h3RXQayox
	 VhakFOtsGUaDyOLfSGz7g6nHMVlSvQ7WUgdKn5EXEo0PemN+ca3oUhhNzheCIhvgyD
	 GOQYzfeu5V3i7R33ZlWcnDTdyOauesNI+UhxC7amsZTN4aza+7meH3c4FszDbYpNVr
	 MyoSxa/EeNy0g==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0F41A3782051;
	Fri, 12 Jan 2024 09:46:51 +0000 (UTC)
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
Subject: [PATCH 13/15] arm64: dts: mediatek: radxa-nio-12l: Enable SPI1/2 for 40pin header
Date: Fri, 12 Jan 2024 10:46:30 +0100
Message-ID: <20240112094632.66310-14-angelogioacchino.delregno@collabora.com>
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

Enable the SPI1 and SPI2 controllers as pins for those are exposed on
the 40pins header.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../dts/mediatek/mt8395-radxa-nio-12l.dts     | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts b/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
index be2094b8fe3c..191c059f5c97 100644
--- a/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
@@ -582,6 +582,26 @@ pins-bus {
 		};
 	};
 
+	spi1_pins: spi1-default-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO136__FUNC_SPIM1_CSB>,
+				 <PINMUX_GPIO137__FUNC_SPIM1_CLK>,
+				 <PINMUX_GPIO138__FUNC_SPIM1_MO>,
+				 <PINMUX_GPIO139__FUNC_SPIM1_MI>;
+			bias-disable;
+		};
+	};
+
+	spi2_pins: spi2-default-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO140__FUNC_SPIM2_CSB>,
+				 <PINMUX_GPIO141__FUNC_SPIM2_CLK>,
+				 <PINMUX_GPIO142__FUNC_SPIM2_MO>,
+				 <PINMUX_GPIO143__FUNC_SPIM2_MI>;
+			bias-disable;
+		};
+	};
+
 	uart0_pins: uart0-pins {
 		pins-bus {
 			pinmux = <PINMUX_GPIO98__FUNC_UTXD0>,
@@ -622,6 +642,26 @@ &scp {
 	status = "okay";
 };
 
+&spi1 {
+	/* Exposed at 40 pin connector */
+	pinctrl-0 = <&spi1_pins>;
+	pinctrl-names = "default";
+	mediatek,pad-select = <0>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+};
+
+&spi2 {
+	/* Exposed at 40 pin connector */
+	pinctrl-0 = <&spi2_pins>;
+	pinctrl-names = "default";
+	mediatek,pad-select = <0>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+};
+
 &spmi {
 	#address-cells = <2>;
 	#size-cells = <0>;
-- 
2.43.0


