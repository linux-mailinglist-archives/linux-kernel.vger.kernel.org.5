Return-Path: <linux-kernel+bounces-27657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B34B682F3C6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67C961F21DC5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2115F1CD38;
	Tue, 16 Jan 2024 18:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="ZwV73gzm"
Received: from mail.fris.de (unknown [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75431CF80;
	Tue, 16 Jan 2024 18:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fris.de
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705428694; cv=none; b=SKbCJHJuMn/5s+xjiMqCPfX3Smo9oa8ZDgc1sch6VkkolbQAIfL5dV3RXvW1uldAk6ftn6YPlCNBGsX9bbcdpPIGVTIZOiITwWs5F+cwZilJbBuHST6AnvIixHP5cq1MpmscZSIEPIfcsUymuUUP0WSq6S6d5VN8xf9iVxNzON4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705428694; c=relaxed/simple;
	bh=GXTCt2puEC8n4+KVjswTePXCWATNvAVVWhSqZSB21Qo=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	b=hANarosFW1zRrR3KGWRmfiyZk0r5mzk+NwyRLA65J+pEUuso8Wiglz5LA3U2xc5DhacoYw3itboSWa0oPI1SFktNIqbrMf1m4QYOYQHu2tBB3T+xhymW488ZuMvTUozqTLMKzz/KeinPfZFZJjxD5FmSBLwSRQRK+YMfLhfuf5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=ZwV73gzm; arc=none smtp.client-ip=116.203.77.234
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 55B54C0354;
	Tue, 16 Jan 2024 19:11:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1705428688; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=8F+jBEwJoQNU4CLdgGATObLnvkE7jK0zgOw0cTlpNEM=;
	b=ZwV73gzmZ1RhRnjO0kp4qkFsvxRqrX9mOe0piUCiPEDu/AF5mMv+ScRHfSmgnGI3Uyp0mH
	hSLtiCKHrjohrIx3PGgNg5nPG+P3s2Rfv2jf1dxrRv5inE6CrTH/oAuMjbIldTxaw6hgZU
	aJ1NG/+GjcuoRN76bmxeRrJ6T6YOAURkUU0yhNHhFXmxK/eaSwbCd0TSE0+1j+ewUvBIEv
	MMHJfdplajEs4gxiny8fU89Pw6a5onltdH1INn00Ntusd8Ol7BYhRKoI6LPQ9Nr127Vvbi
	TheONUNZ9e9UrURkQ/Gw0rmAFXYHo7TImGUckDVaEql99VLkVlh2dspXszOU+w==
From: Frieder Schrempf <frieder@fris.de>
To: Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Li Yang <leoyang.li@nxp.com>,
	netdev@vger.kernel.org,
	Richard Cochran <richardcochran@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
	Andre Przywara <andre.przywara@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Christoph Niedermaier <cniedermaier@dh-electronics.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Fabio Estevam <festevam@gmail.com>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Heiko Stuebner <heiko@sntech.de>,
	James Hilliard <james.hilliard1@gmail.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Marcel Ziswiler <marcel.ziswiler@toradex.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Marek Vasut <marex@denx.de>,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	=?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Stefan Wahren <stefan.wahren@chargebyte.com>,
	Tim Harvey <tharvey@gateworks.com>,
	Yang Xiwen <forbidden405@foxmail.com>,
	Yannic Moog <y.moog@phytec.de>
Subject: [PATCH v2 0/3] ARM: dts: imx6dl: Add support for Sielaff i.MX6 Solo board
Date: Tue, 16 Jan 2024 19:10:25 +0100
Message-ID: <20240116181100.382388-1-frieder@fris.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Frieder Schrempf <frieder.schrempf@kontron.de>

This series adds upstream support for the Sielaff i.MX6 Solo board.
It is used as controller and user interface in vending machines. It
is based on the i.MX6 Solo SoC and features the following
peripherals and interfaces:

* 512 MB DDR3 RAM
* 512 MB NAND Flash
* 1 MB NOR Flash
* SD card
* Debug LED
* Debug UART
* Key Inputs
* RTC
* RS232
* 100 MBit Ethernet
* USB Hub
* USB OTG
* HDMI
* 7" LVDS IPS panel
* PWM Backlight
* Optional Extension Board with USB Ethernet NIC

Patch 1 adds the vendor prefix, patch 2 adds the DT bindings and
patch 3 adds the DT.

Changes in v2:
* Add Acked-by from Conor (Thanks!)
* Fix touchscreen node names (Thanks Fabio!)

Frieder Schrempf (3):
  dt-bindings: vendor-prefixes: Add Sielaff
  dt-bindings: arm: fsl: Add Sielaff i.MX6 Solo board
  ARM: dts: imx6dl: Add support for Sielaff i.MX6 Solo board

 .../devicetree/bindings/arm/fsl.yaml          |   1 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm/boot/dts/nxp/imx/Makefile            |   1 +
 arch/arm/boot/dts/nxp/imx/imx6dl-sielaff.dts  | 533 ++++++++++++++++++
 4 files changed, 537 insertions(+)
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6dl-sielaff.dts

-- 
2.43.0


