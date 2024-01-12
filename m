Return-Path: <linux-kernel+bounces-24499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C9E82BD86
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 10:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A64D1C253F0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 09:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A076E5730F;
	Fri, 12 Jan 2024 09:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ur+3HXno"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A52356B99;
	Fri, 12 Jan 2024 09:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705052798;
	bh=HqzPxaHeFCyZfYh2e01L+xQeMw072rSkCaHc++QlYdQ=;
	h=From:To:Cc:Subject:Date:From;
	b=ur+3HXnozCFZCBDVPEloAp4tOGWzuYqHUeQqBNucoBZKkCLYf48oCaxuLKH3FBgl8
	 Tks7oB8WPXocfxErw6gaDvsiwIz57UElYZt+s8J0kvLjNZd2OS1C4AG5WE/TeLrE6C
	 NDhvPKkxTS59bcT0eBH+Pz0mEE8ZreeTQWB8NCkM6/K0Ut9GEANxi6EHPT4P+299v5
	 vsOn661GzfO9RgqONhMM4/VRTR1lMh3b9uNYEKKbGs31cGVb4mBLtPQpGpp1nJUUyz
	 Iq4O196KG+f5HG7KMQnz1iX5YI17yjErN3O3Ieb+75lceTZWAdcIyV9Ow4/QhZMIOn
	 q8r2qIj1Z9xgw==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8E8F33781FCF;
	Fri, 12 Jan 2024 09:46:37 +0000 (UTC)
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
Subject: [PATCH 00/15] MediaTek: Introduce MT8395 Radxa NIO 12L devicetree
Date: Fri, 12 Jan 2024 10:46:17 +0100
Message-ID: <20240112094632.66310-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds a device tree for the Radxa NIO 12L SBC, powered by
the MediaTek Genio 1200 (MT8395).
Not all features of this board are included in this first series but
it's already quite usable, as the eMMC internal storage works and can
be used to boot the system (as much as MicroSD external storage), the
connectivity via ethernet and WiFi (PCI-Express) are working as well.

The two I2C, two SPI and the two UART ports are also ok.

What is missing (and what's next...!):
 - UFS storage is not working yet (but eMMC works)
 - Type-C role switching is not yet implemented, driver is there but
   mt8195.dtsi has no MTU3 yet, needs some research to avoid breaking
   compatibility with MT8195 Chromebooks
 - HDMI Input port: no driver yet
 - HDMI Output (from SoC HDMI IP): no driver yet
 - Audio (sound card driver needs some love)
 - MIPI Camera
 - System LEDs
 - "F15" Button

This series depends on the MT6360 TCPC series at [1].

[1]: https://lore.kernel.org/all/20240112094538.65639-1-angelogioacchino.delregno@collabora.com

Cheers,
Angelo

AngeloGioacchino Del Regno (15):
  dt-bindings: arm64: mediatek: Add MT8395 Radxa NIO 12L board
    compatible
  arm64: dts: mediatek: Introduce the MT8395 Radxa NIO 12L board
  arm64: dts: mediatek: radxa-nio-12l: Enable I2C 2/4/6 busses
  arm64: dts: mediatek: radxa-nio-12l: Add external MT6360 PMIC on I2C6
  arm64: dts: mediatek: radxa-nio-12l: Configure board regulators
  arm64: dts: mediatek: radxa-nio-12l: Add Ethernet controller and
    Xceiver
  arm64: dts: mediatek: radxa-nio-12l: Add MT6360 battery charger
  arm64: dts: mediatek: radxa-nio-12l: Add support for eMMC and MicroSD
  arm64: dts: mediatek: radxa-nio-12l: Enable System Companion Processor
  arm64: dts: mediatek: radxa-nio-12l: Enable PCI-Express 0 for USB HUB
  arm64: dts: mediatek: radxa-nio-12l: Enable the USB XHCI controllers
  arm64: dts: mediatek: radxa-nio-12l: Enable PCI-Express 1 for WiFi
  arm64: dts: mediatek: radxa-nio-12l: Enable SPI1/2 for 40pin header
  arm64: dts: mediatek: radxa-nio-12l: Enable UART1 for 40pin header
  arm64: dts: mediatek: radxa-nio-12l: Enable Panfrost for Mali GPU

 .../devicetree/bindings/arm/mediatek.yaml     |   1 +
 arch/arm64/boot/dts/mediatek/Makefile         |   1 +
 .../dts/mediatek/mt8395-radxa-nio-12l.dts     | 747 ++++++++++++++++++
 3 files changed, 749 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts

-- 
2.43.0


