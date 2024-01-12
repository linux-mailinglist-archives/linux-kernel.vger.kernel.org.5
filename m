Return-Path: <linux-kernel+bounces-24510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A756882BD9D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 10:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43023287A42
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 09:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323BC60B8B;
	Fri, 12 Jan 2024 09:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="D3x/KrQG"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6835FEE0;
	Fri, 12 Jan 2024 09:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705052808;
	bh=PBInGRQ7u56PJ5kAhJgP+h9Q1n6mnFxfoN7YCdPzwaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D3x/KrQGs5mZR32NTRZBSUZgSKwCRsHUE9HUveVzAwgj70HdsQHEyI9Tqr9PtweLH
	 4FI4pfF5uIvFCDjABr+efx7uhxfy8H5umrSm2ZLXGAGqkSQRucs8S+KIf5TuF/lZd7
	 LVRfsZeguGmQ/RKItOhwtFJoivbUVRuutEuOkfPuEzpxrVm6wlJWj8pbmstl5jwPql
	 3LaVtJeWUUatUFQHxC7/L5BW2trHj81nmUfsqZ6ZhyVg/Tf4bcLgMFqSMyhsBjLvX3
	 1m9TQSJSoj8EeZqX6Q9w1NA0HRlUJDM3wmIc5E9DSWqymdYYgdxBPAmFv25VZv59CP
	 MPeZ/K1gmfJmQ==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E61713781FCF;
	Fri, 12 Jan 2024 09:46:47 +0000 (UTC)
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
Subject: [PATCH 10/15] arm64: dts: mediatek: radxa-nio-12l: Enable PCI-Express 0 for USB HUB
Date: Fri, 12 Jan 2024 10:46:27 +0100
Message-ID: <20240112094632.66310-11-angelogioacchino.delregno@collabora.com>
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

Enable the PCIe0 controller, providing part of the USB connectivity
found on this board through a USB HUB connected over PCI-Express.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../boot/dts/mediatek/mt8395-radxa-nio-12l.dts    | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts b/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
index 5a9e33013209..dbde2c7b3c64 100644
--- a/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
@@ -564,6 +564,15 @@ pins-irq {
 		};
 	};
 
+	pcie0_default_pins: pcie0-default-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO19__FUNC_WAKEN>,
+				 <PINMUX_GPIO20__FUNC_PERSTN>,
+				 <PINMUX_GPIO21__FUNC_CLKREQN>;
+			bias-pull-up;
+		};
+	};
+
 	uart0_pins: uart0-pins {
 		pins-bus {
 			pinmux = <PINMUX_GPIO98__FUNC_UTXD0>,
@@ -583,6 +592,12 @@ pins-wifi-vreg-en {
 	};
 };
 
+&pcie0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie0_default_pins>;
+	status = "okay";
+};
+
 &pmic {
 	interrupts-extended = <&pio 222 IRQ_TYPE_LEVEL_HIGH>;
 };
-- 
2.43.0


