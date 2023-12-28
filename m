Return-Path: <linux-kernel+bounces-12738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0F381F97D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 16:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F2CD1C22932
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 15:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C49F51A;
	Thu, 28 Dec 2023 15:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lyeXkaFp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AD5F4F0;
	Thu, 28 Dec 2023 15:09:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A99C433CA;
	Thu, 28 Dec 2023 15:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703776179;
	bh=jCI/YMfr+NrtHxo3qHYZpBjBqghFPe+6yiDfEv5LI1s=;
	h=From:To:Cc:Subject:Date:From;
	b=lyeXkaFpTNlQ8A459Cp2D3+Mwy+bf2puUUc4xFDxB2odlSXM93Y+D6YBDw+BT8Jsk
	 JryFCU4yiriOFCQqYIMScdhFTb7e/Qfr9jkTL+Hjsg9+sQGYlABZpI3cR6qymWfdaI
	 rzRuCg7uIAwWSzUa9gHTu16fhm/009B7VcgKSPxkq2o2pIin+hO7LKju2O0xJ3PFr1
	 +nqTsv8lVK01XPSJsTslTYjoIsbxQFIuKGFUaCDvoNPhQXhLbAz2juxWFk7Fo7OFSh
	 F/BSyr/QNdbVmiyHi2NeNgGhrs1lGQDcTNJ8TYJOfaAfQdZrrLB3Mqi3a5/YJS5z5G
	 5t/wud5LAAnSA==
From: Jisheng Zhang <jszhang@kernel.org>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Andre Przywara <andre.przywara@arm.com>,
	Icenowy Zheng <uwu@icenowy.me>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] arm64: dts: allwinner: h618: Add Sipeed Longan SoM 3H and Pi 3H board
Date: Thu, 28 Dec 2023 22:56:45 +0800
Message-Id: <20231228145647.1470-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
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

NOTE: I know it's too late for v6.8-rc1, but I want to send out this
series so that the board users can easily get mainline support with two
additional patches. I will send out v2 once v6.8-rc1 is out.

Jisheng Zhang (2):
  dt-bindings: arm: sunxi: Add Sipeed Longan Module 3H and Longan Pi 3H
  arm64: dts: allwinner: h618: Add Sipeed Longan SoM 3H and Pi 3H board
    support

 .../devicetree/bindings/arm/sunxi.yaml        |   7 +
 arch/arm64/boot/dts/allwinner/Makefile        |   1 +
 .../sun50i-h618-longan-module-3h.dtsi         |  82 +++++++++++
 .../dts/allwinner/sun50i-h618-longanpi-3h.dts | 133 ++++++++++++++++++
 4 files changed, 223 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h618-longan-module-3h.dtsi
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h618-longanpi-3h.dts

-- 
2.40.0


