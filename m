Return-Path: <linux-kernel+bounces-60655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F184385081B
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 09:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC8F0283C61
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 08:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03736481AD;
	Sun, 11 Feb 2024 08:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgvUBFtb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3542747A67;
	Sun, 11 Feb 2024 08:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707640237; cv=none; b=DDKA23G6S+ug/zl203xEwbQ7VZChW7blNHYxu4IOG9uyfDI8xzRaiA38AZ9fHAa9eAvsW4GbWzha4M98E8T5VngpvvsLUNnoOQe39Wv03JTc/VyrRJ+dmxf+aq2eVCgDadVwTW+gWzkckdpUNZ8Tt3EzAALXHlAmwxcrOi/CyEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707640237; c=relaxed/simple;
	bh=GhzMVGJSxEftKc4QVl/zjhW+60RgOc/AYDpBzCJgt5I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ocA+0aBd+8S5VC65BWZmcX+/8LNRLTMskLwzvnshfIuCO1nmyMrBzs6CAmsTXoFA8mfY9iiRU8yeq7zaQkNTRdUKJ9njeF7yhwYqhUSwMciivnq8705AE4RnSLnRCL0OOhZrixKluGhD6gX/kqegWLFR55hVlT3nGzzik2P7FPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hgvUBFtb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54B47C433C7;
	Sun, 11 Feb 2024 08:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707640236;
	bh=GhzMVGJSxEftKc4QVl/zjhW+60RgOc/AYDpBzCJgt5I=;
	h=From:To:Cc:Subject:Date:From;
	b=hgvUBFtbnVRZFQ3hQYtwKtombd9PvdZTsDRF59IxALceNkOeflXSEI25xbNWU21PH
	 UBkePsmGsg+PYeo86YqtAFacSCnUcz+lgoV/3kKYovlC53Qbef9djNjCBVeVVmKBYW
	 jWXoQ0KZvVVoetUdZoVGkBue9JLpdoyXeE38RMaNC6xOt6nOfunwcX9CkBVQvsjRyw
	 XbOcDrnvODmpLT/t+Lej0tAp/P4TcN2SiY7ptzEWoNxNyd/IpYYBYDPc/xiBBAw8G5
	 HcH5eb9WLP+rMoxGMdkkEU76Z+e87CRnbN+muxW5inwwiAioVS4H2mj46RUjg6DrHI
	 hN5omoDTMLjTw==
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
Subject: [PATCH v3 0/2] arm64: dts: allwinner: h618: Add Sipeed Longan SoM 3H and Pi 3H board
Date: Sun, 11 Feb 2024 16:17:37 +0800
Message-ID: <20240211081739.395-1-jszhang@kernel.org>
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

Since v2:
  - collect Reviewed-by tag
  - add vin-supply property to reg_vcc3v3
  - fix reg_vcc3v3 voltage value
  - remove "interrupt-parent" and "interrupts" properties from axp313
    node

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
 .../sun50i-h618-longan-module-3h.dtsi         |  75 +++++++++
 .../dts/allwinner/sun50i-h618-longanpi-3h.dts | 144 ++++++++++++++++++
 4 files changed, 226 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h618-longan-module-3h.dtsi
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h618-longanpi-3h.dts

-- 
2.43.0


