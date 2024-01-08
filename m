Return-Path: <linux-kernel+bounces-19222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 534A28269F8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05DB51F23044
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 08:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7F910799;
	Mon,  8 Jan 2024 08:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="P47oQnId"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2146ADDBD;
	Mon,  8 Jan 2024 08:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8D8BBC00BE;
	Mon,  8 Jan 2024 09:51:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1704703869; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=0IdpHLyl1+XSHRQ75JlBqb+9DOnBIyez2WRhDvjB19c=;
	b=P47oQnIdWjURm8Pnz721t7dGSTkr8e6lHe0UrT9BiULjriWTu65lAi3wh1fAHRc6Pvp8wz
	4raCz3EOybm/PA9E3FiGoQLlUb9hbHtL2fFiYmGeCltD4AMLVKztQSbVFJgYezlMEvwIpG
	PeCBZMUmHnIeJXFwUZZhuw1AVCW9JvELR+hcnm8g9IQcV/lXxem/7vFaB/j091wXOLoNNO
	SHBZ1CPcaG8lKiCOoV0RvyTmjYpRUoLXtwKl1+oY5Nwxij80llzdOnoHx/j8YHCR2N26uh
	jaYklz1bHaBYdAv4E/nuazNyJaOjVrSIhskztmzOgzUzIIeu9Tiy1LQyC50q7A==
From: Frieder Schrempf <frieder@fris.de>
To: Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	NXP Linux Team <linux-imx@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v4 00/12] arm64: dts: imx8mm-kontron: DT updates
Date: Mon,  8 Jan 2024 09:48:57 +0100
Message-ID: <20240108084945.75356-1-frieder@fris.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Frieder Schrempf <frieder.schrempf@kontron.de>

This patchset contains several improvements and updates for the devicetrees
for the i.MX8MM modules and boards by Kontron Electronics GmbH.

* Misc cleanups and small fixes
* OSM-S i.MX8MM module refactoring and update to latest HW revision

Changes in v4:
* Rebase to Shawn's imx/dt64 branch
* Drop patches 1 and 2 (display support) as there are unresolved DTC warnings
  and I am not sure how to resolve them at the moment.

Changes in v3:
* Address Shawn's review comments for patch 1, 2 and 14 (thanks!)

Changes in v2:
* Rework DSI mux GPIO logic to be compatible with overlay
* Switch from 4 to 2 DSI lanes for LVDS bridge to fix non-working display

Frieder Schrempf (12):
  arm64: dts: imx8mm-kontron: Disable pullups for I2C signals on OSM-S
    i.MX8MM
  arm64: dts: imx8mm-kontron: Disable pullups for I2C signals on SL/BL
    i.MX8MM
  arm64: dts: imx8mm-kontron: Disable pullups for onboard UART signals
    on BL OSM-S board
  arm64: dts: imx8mm-kontron: Disable pullups for onboard UART signals
    on BL board
  arm64: dts: imx8mm-kontron: Disable pull resistors for SD card signals
    on BL OSM-S board
  arm64: dts: imx8mm-kontron: Disable pull resistors for SD card signals
    on BL board
  arm64: dts: imx8mm-kontron: Fix interrupt for RTC on OSM-S i.MX8MM
    module
  arm64: dts: imx8mm-kontron: Fix OSM-S devicetrees to match latest
    hardware
  arm64: dts: imx8mm-kontron: Disable uneffective PUE bit in SDIO IOMUX
  arm64: dts: imx8mm-kontron: Remove useless trickle-diode-disable from
    RTC node
  arm64: dts: imx8mm-kontron: Add I2C EEPROM on OSM-S Kontron i.MX8MM
  arm64: dts: imx8mm-kontron: Refactor devicetree for OSM-S module and
    board

 .../dts/freescale/imx8mm-kontron-bl-osm-s.dts | 295 +++------
 .../boot/dts/freescale/imx8mm-kontron-bl.dts  |  38 +-
 .../dts/freescale/imx8mm-kontron-osm-s.dtsi   | 567 +++++++++++++++++-
 .../boot/dts/freescale/imx8mm-kontron-sl.dtsi |   4 +-
 4 files changed, 670 insertions(+), 234 deletions(-)

-- 
2.43.0

