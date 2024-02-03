Return-Path: <linux-kernel+bounces-51081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5D084863E
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 13:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BECC282CDC
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 12:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD1C2AF17;
	Sat,  3 Feb 2024 12:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LOQSSMyP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73834384;
	Sat,  3 Feb 2024 12:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706963881; cv=none; b=gBz4h7YdtUzPz6JWF+J3M23sYv96JUUqGBtCAxYn9Zn/BjXi8yB2h+fjqdHkGHESBro+kwwxqnRMfc/uVGRWUp+hwFi0kKzvuYqOAzTY3xFqG3sOOzSZ0cOUnC/SDWfEYtBhQQHKbjCuPPsQKrgon3Lk3FSWg3llajZeGPMTWBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706963881; c=relaxed/simple;
	bh=Ry8SP/OpV6N0TsgPYkBd/xIsbggogFR8RhqfHiLkaC0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CkRgqHXoTLPimUsRdhIJ3g3X5yiCvUg8OBSvBhUkaHlhRXvgd21aGpYoaNuLOhrQIGHpqVBsDZdb5+WwkB3vYDy9Dpq6o68LmO2l3bnCa9nE/uk9cSFpj0B48t7V2CVAtR3gRg1JmybsZyKfN1GDTsxgplO2f+HwMe+Gh/OfzpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LOQSSMyP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CCE3C43390;
	Sat,  3 Feb 2024 12:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706963880;
	bh=Ry8SP/OpV6N0TsgPYkBd/xIsbggogFR8RhqfHiLkaC0=;
	h=From:To:Cc:Subject:Date:From;
	b=LOQSSMyPReMCQHK9FEk70qVJLRqmoOVAcCMtTqsUCwJoY68Bkmc4zOqHZLzZbQw7p
	 aC1MVB3u4Mwu38xuVJTkaEkpzx+0Jo5ybsGIX4ZBOzCf7UTI+USUk6vkprfm3+THnl
	 0JlhBZYlz9fgpUfE8d7DSCMYBYt313uFW6fe1pxcQ375X83P9iBgaS51JiRkSWvYdE
	 LsgP215md0KkMYZaF2FZNIgeLXprzjtuBXVsD9QKUZE6Dt+M9kOQ0tVOW/EgpB0LQN
	 QaV4RHpdHzS/SZbcRVS3yNuPrfLJRPW/qS3ATNOFumgAlNJjXfJs3GAF97ACCLmZo/
	 WkNXAg/acfkcQ==
From: Jisheng Zhang <jszhang@kernel.org>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Andre Przywara <andre.przywara@arm.com>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] arm64: dts: allwinner: h618: Add Sipeed Longan SoM 3H and Pi 3H board
Date: Sat,  3 Feb 2024 20:24:59 +0800
Message-ID: <20240203122502.1259-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Sipeed Longan SoM 3H and Longan Pi 3H board support.

The Sipeed Longan SoM 3H is a system on module based on the Allwinner
H618 SoC. The SoM features:

- Four ARM Cortex-A53 cores, Mali-G31 MP2 GPU
- 2/4 GiB LPDDR4 DRAM SoMs
- AXP313a PMIC
- eMMC

The Sipeed Longan PI 3H is a development board based on the above SoM.
The board features:
- Longan SoM 3H
- Raspberry-Pi-1 compatible GPIO header
- 2 USB 2.0 host port
- 1 USB 2.0 type C port (power supply + OTG)
- MicroSD slot
- 1Gbps Ethernet port (via RTL8211 PHY)
- HDMI port
- WiFi/BT chip

Since v1:
  - Use const rather than enum for "sipeed,longan-pi-3h" dt-binding
  - remove dts-v1, model and compatible from SoM dtsi
  - add interrupt related properties to axp313 dt node
  - use "vcc-1v8-pll" and "vcc-3v3-io" as regulator name
  - add dt node for board's discrete 5V->3.3V regulator and use it for
    eth\tfcard 3.3v supply
  - add usb2_vbus-supply property

Jisheng Zhang (2):
  dt-bindings: arm: sunxi: Add Sipeed Longan Module 3H and Longan Pi 3H
  arm64: dts: allwinner: h616: Add Sipeed Longan SoM 3H and Pi 3H board
    support

 .../devicetree/bindings/arm/sunxi.yaml        |   6 +
 arch/arm64/boot/dts/allwinner/Makefile        |   1 +
 .../sun50i-h618-longan-module-3h.dtsi         |  77 ++++++++++
 .../dts/allwinner/sun50i-h618-longanpi-3h.dts | 143 ++++++++++++++++++
 4 files changed, 227 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h618-longan-module-3h.dtsi
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h618-longanpi-3h.dts

-- 
2.43.0


