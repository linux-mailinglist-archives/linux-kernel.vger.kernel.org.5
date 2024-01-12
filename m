Return-Path: <linux-kernel+bounces-24502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11AE182BD8C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 10:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 325B21C253A8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 09:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BFA5D904;
	Fri, 12 Jan 2024 09:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Kbqici4F"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F334457328;
	Fri, 12 Jan 2024 09:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705052801;
	bh=zq877pNGDNR9QpP0tnh0GOjiJi6f38kNnwjwlSPV6gE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kbqici4FvY55mGW4HoF+8HYjWOjjAZL1Dj0IvISss/jPXd+lauI9xo3RiMV8AoBGx
	 ybU2U/UB/ADjB2Wo6jZxFrP435np0ECk5fijdNm/4QaPkz9P8k1JF8Jugw2TZLCCeS
	 XOLlbI+pmmSp0DwzBZQ7rgsbnWWL/Ay6ieAFTj1F7SUV2RORF3lUzJCmMhEbxbCyOP
	 ZPCkyNQwej12I59W7rD6rly+MJZLrahmAYCQfk6VGKbsrXqGx+hDj+nBxQOXmw8J1y
	 pBRLTpL8blyn07PzXRuQVhrGxxyY8Ql7MMy3taTWcnnziWYsTudo3cw+xwz00HzmFA
	 nmskGKFke9tFQ==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B00813782032;
	Fri, 12 Jan 2024 09:46:40 +0000 (UTC)
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
Subject: [PATCH 03/15] arm64: dts: mediatek: radxa-nio-12l: Enable I2C 2/4/6 busses
Date: Fri, 12 Jan 2024 10:46:20 +0100
Message-ID: <20240112094632.66310-4-angelogioacchino.delregno@collabora.com>
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

Properly configure and enable the three i2c controllers that have
devices attached and/or have pins exposed on the board connectors.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../dts/mediatek/mt8395-radxa-nio-12l.dts     | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts b/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
index 2c4d6805b668..79358e1a3e60 100644
--- a/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
@@ -85,7 +85,61 @@ apu_mem: memory@62000000 {
 	};
 };
 
+&i2c2 {
+	clock-frequency = <400000>;
+	pinctrl-0 = <&i2c2_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	/* iTE IT5205FN Type-C 3:2 Alt. mode passive MUX at 0x48 */
+};
+
+&i2c4 {
+	clock-frequency = <400000>;
+	pinctrl-0 = <&i2c4_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	/* I2C4 exposed at 39-pins MIPI-LCD connector */
+};
+
+&i2c6 {
+	clock-frequency = <400000>;
+	pinctrl-0 = <&i2c6_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	/* MT6360 PMIC at 0x34 */
+};
+
 &pio {
+	i2c2_pins: i2c2-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO12__FUNC_SDA2>,
+				 <PINMUX_GPIO13__FUNC_SCL2>;
+			bias-pull-up = <MTK_PULL_SET_RSEL_111>;
+			drive-strength = <6>;
+			drive-strength-microamp = <1000>;
+		};
+	};
+
+	i2c4_pins: i2c4-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO16__FUNC_SDA4>,
+				 <PINMUX_GPIO17__FUNC_SCL4>;
+			bias-pull-up = <MTK_PULL_SET_RSEL_111>;
+			drive-strength-microamp = <1000>;
+		};
+	};
+
+	i2c6_pins: i2c6-pins {
+		pins {
+			pinmux = <PINMUX_GPIO25__FUNC_SDA6>,
+				 <PINMUX_GPIO26__FUNC_SCL6>;
+			bias-pull-up = <MTK_PULL_SET_RSEL_111>;
+		};
+	};
+
 	uart0_pins: uart0-pins {
 		pins-bus {
 			pinmux = <PINMUX_GPIO98__FUNC_UTXD0>,
-- 
2.43.0


