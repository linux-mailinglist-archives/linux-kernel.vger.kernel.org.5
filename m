Return-Path: <linux-kernel+bounces-24514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 086BA82BDA6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 10:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B09141F26B9A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 09:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577016168E;
	Fri, 12 Jan 2024 09:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JgameZ7Q"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D59360EE9;
	Fri, 12 Jan 2024 09:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705052812;
	bh=gL9dBZTGnU9IkMRPqj3ewg2fNvV9dpUlTIdwuTp/HeU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JgameZ7Qfy0yT8alx2+YKNEednVHANfwOvPmh9XyzJpaRvDVfl7mNGFizFGxgZlqr
	 +sljUdc6UkzHSpUgDEgnOoTObIgshFnxILuxih0/Lg8RHIztL+IXyqjJkweN7J0h2A
	 48neMrJYNXFvRbHlTkRVseZ4/n5wxp3gmyRZvY4c9VQBq+LqhLKy2UZERh53VOlLxk
	 LHMrkGCnd8duiyb9AdrBfQ7/P77NMtWW+i62CZ5217BIvAMFwI72fPCd2CVtcKNx16
	 4Hjr6PJw6CAaHp5GX8jZBdSLUAqAZUzyD9ypwEF7gghkoNri9Fkdy6tY4NSX3WFNyk
	 lzbW0PqEiO2uA==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0D9443782035;
	Fri, 12 Jan 2024 09:46:52 +0000 (UTC)
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
Subject: [PATCH 14/15] arm64: dts: mediatek: radxa-nio-12l: Enable UART1 for 40pin header
Date: Fri, 12 Jan 2024 10:46:31 +0100
Message-ID: <20240112094632.66310-15-angelogioacchino.delregno@collabora.com>
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

Enable the secondary UART port, exposed on the 40pins header.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../boot/dts/mediatek/mt8395-radxa-nio-12l.dts     | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts b/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
index 191c059f5c97..b0d66fa139b5 100644
--- a/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
@@ -609,6 +609,13 @@ pins-bus {
 		};
 	};
 
+	uart1_pins: uart1-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO102__FUNC_UTXD1>,
+				 <PINMUX_GPIO103__FUNC_URXD1>;
+		};
+	};
+
 	wifi_vreg_pins: wifi-vreg-pins {
 		pins-wifi-pmu-en {
 			pinmux = <PINMUX_GPIO65__FUNC_GPIO65>;
@@ -707,6 +714,13 @@ &uart0 {
 	status = "okay";
 };
 
+&uart1 {
+	/* Exposed at 40 pin connector */
+	pinctrl-0 = <&uart1_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
 &xhci0 {
 	vusb33-supply = <&mt6359_vusb_ldo_reg>;
 	vbus-supply = <&otg_vbus_regulator>;
-- 
2.43.0


