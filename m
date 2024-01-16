Return-Path: <linux-kernel+bounces-27282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D0C82ED40
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C29601C23108
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031111A714;
	Tue, 16 Jan 2024 10:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="nq382OCs"
Received: from mail.fris.de (unknown [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075741A711;
	Tue, 16 Jan 2024 10:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 98DCCC0307;
	Tue, 16 Jan 2024 11:53:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1705402415; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=H6HXW36t66rC6youCTbv8zF7oQnyFZiT5vVPj7yQdkI=;
	b=nq382OCs/cCX1l9apT3dE4VHNziQ2tG/E5wSwRGqAPukcJEhrEO2TuMAjIqFJAIyTxXE+w
	Q139O3XNK2KfAGZLp2Cio0ohSKu2D5nW7u4/pWKUfg6zd8/BGTc0tOA6sL7ebRGKXRfoQu
	72LP+E9HQS7xcai9WONnD1O3kppHY9vqhBEb6N3F8qoF3CS/yKnf4QuGW7TMePV/ioQ2gx
	lt8c7cwnv71qv7uKSr/NQHwP3tuHp+7jtZot4og7kZen/3b69qnmG5U/Fne7m9jy1VpqJJ
	PSU6NHQoj8e07GLDZX9l8gf0w9tJgZJQ1E7lA+3m7+KjNQ/46u1To9h01i50KA==
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
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Josua Mayer <josua@solid-run.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Marcel Ziswiler <marcel.ziswiler@toradex.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Marek Vasut <marex@denx.de>,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Stefan Wahren <stefan.wahren@chargebyte.com>,
	Tim Harvey <tharvey@gateworks.com>,
	Wei Xu <xuwei5@hisilicon.com>,
	Yang Xiwen <forbidden405@foxmail.com>,
	Yannic Moog <y.moog@phytec.de>
Subject: [PATCH 0/3] ARM: dts: imx6dl: Add support for Sielaff i.MX6 Solo board
Date: Tue, 16 Jan 2024 11:51:54 +0100
Message-ID: <20240116105317.267525-1-frieder@fris.de>
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


