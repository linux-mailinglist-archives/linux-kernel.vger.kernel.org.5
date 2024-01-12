Return-Path: <linux-kernel+bounces-24512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3638182BDA2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 10:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FD891C25008
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 09:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8008660EF1;
	Fri, 12 Jan 2024 09:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="s7j+MtAA"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B96760B99;
	Fri, 12 Jan 2024 09:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705052810;
	bh=ooNGEFPL+gUVRid3mWpdeLiRnX9gOyT+28DJWB37x2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s7j+MtAA2wKznnHtgaCCVdL9MMIzIDL35gK5ovR2oytf+x3+qEOy4Mgor9NnL+EaB
	 4gE7uzIxbbM3aWcvgFzQRN9+CoYv5rBpj4Ue9ucTLBWhC0aC0F7eT1xKZ+GIC5FtL8
	 IarcnCOn3wseHA8uxDffMUh6OQqehAcrp+z44pYvMYstRjg0kr2scO25AQn5aW70Cb
	 +0CzMagVdrzhnJZLXJyIxOrTJQ+glhRfdeWnAL16xthFCsgCJZaS1H4aIrLfpNVMpw
	 JeU/XOjmuAxxnMM/66RkoxVS738a/wLmaIh2YUZzG/U2vozP8gNa/83LZs6CWSTf1K
	 x72lkUSq4BRWA==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 058EB3782021;
	Fri, 12 Jan 2024 09:46:49 +0000 (UTC)
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
Subject: [PATCH 12/15] arm64: dts: mediatek: radxa-nio-12l: Enable PCI-Express 1 for WiFi
Date: Fri, 12 Jan 2024 10:46:29 +0100
Message-ID: <20240112094632.66310-13-angelogioacchino.delregno@collabora.com>
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

This board has a MT7921E combo chip connected through USB for Bluetooth
and PCI-Express for WiFi.
Add the PCIe1 controller to enable WiFi connectivity.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../boot/dts/mediatek/mt8395-radxa-nio-12l.dts    | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts b/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
index eafce9cb2598..be2094b8fe3c 100644
--- a/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
@@ -573,6 +573,15 @@ pins-bus {
 		};
 	};
 
+	pcie1_default_pins: pcie1-default-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO0__FUNC_PERSTN_1>,
+				 <PINMUX_GPIO1__FUNC_CLKREQN_1>,
+				 <PINMUX_GPIO2__FUNC_WAKEN_1>;
+			bias-disable;
+		};
+	};
+
 	uart0_pins: uart0-pins {
 		pins-bus {
 			pinmux = <PINMUX_GPIO98__FUNC_UTXD0>,
@@ -598,6 +607,12 @@ &pcie0 {
 	status = "okay";
 };
 
+&pcie1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie1_default_pins>;
+	status = "okay";
+};
+
 &pmic {
 	interrupts-extended = <&pio 222 IRQ_TYPE_LEVEL_HIGH>;
 };
-- 
2.43.0


