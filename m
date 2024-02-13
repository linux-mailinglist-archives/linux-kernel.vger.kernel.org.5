Return-Path: <linux-kernel+bounces-64169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FCA853B0B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 20:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23C931F22064
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2168E6089E;
	Tue, 13 Feb 2024 19:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bAHFe5L7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA0C60263;
	Tue, 13 Feb 2024 19:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707852910; cv=none; b=U+wFv3M1ZQRZbedM83cQvho7GzUlaEz8I3OeEx6rhyNtWqAimcsHq70DZ8k7aAoxMYFRFNV1Kj5gwmwhVpqUwnEUZ/YbfNl5GcagRudQmozAQGD6f2+Nx7evh/+lOByN35fSliDeRxlO/Fke4b9guB7VJ8pJo5l9PLPKJPKWbjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707852910; c=relaxed/simple;
	bh=O2rijBlETPV1mvIsb2fGr/xbJahLcxzbFbT0uIUHBKg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rz95cV8kqQJLIcHoqzfCO82OWzq7lFnxGeRPbk5gbCGZDkGCcnPji+It01tnnqHwcogxj8g5Omv6SGZbDcWiASg9VF8qW1WNZz0FwpmVKaaRTGlMNaCvddFQqcIS1/22ebNanA5qX0z8g53idsUqd0PCIuhlTT/hSKEhj62B0r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bAHFe5L7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A66C433F1;
	Tue, 13 Feb 2024 19:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707852909;
	bh=O2rijBlETPV1mvIsb2fGr/xbJahLcxzbFbT0uIUHBKg=;
	h=From:Subject:Date:List-Id:To:Cc:From;
	b=bAHFe5L7UR7xP/kCitee/iv9eS0lpinKuT9Yamt03CiuUYMC7YJ8S4Mo8zhHyvvXy
	 smFxcN0KVo8KGPSRn74E/DsZvyDbmiOw9J/sMQczNXr1h5eq06vGIQiQ323cA/mjOD
	 AIURazkAWZvo+DmAwMndDAtePLjU7O+a1JwaRdMswSLa8kkV8Wgnnqs61BPbbm8W4S
	 nx4RoBLQByL4sGoYmlGrGvVSTBTl2O8sOskTgzgaAn+sk0Gwid6QOtaxruZKGNBVYx
	 3JKFh3NMw7YVWEgSHzVc/H2bHWxr8Yk82Rih7f0/OmBlzs1hXYaWV6p4YCKCR0A8dm
	 bDrQYULSGpk5Q==
From: Rob Herring <robh@kernel.org>
Subject: [PATCH 0/6] dts: Fix dtc interrupt warnings
Date: Tue, 13 Feb 2024 13:34:24 -0600
Message-Id: <20240213-arm-dt-cleanups-v1-0-f2dee1292525@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEDEy2UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDI0Nj3cSiXN2UEt3knNTEvNKCYl1zs6QkcyOzlFRLEwsloK6CotS0zAq
 widGxtbUANsZJ1WEAAAA=
To: soc@kernel.org, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Tsahee Zidenberg <tsahee@annapurnalabs.com>, 
 Antoine Tenart <atenart@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Ray Jui <rjui@broadcom.com>, 
 Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Stefan Agner <stefan@agner.ch>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 =?utf-8?q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, 
 Tony Lindgren <tony@atomide.com>, Chanho Min <chanho.min@lge.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linusw@kernel.org>, 
 Imre Kaloz <kaloz@openwrt.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
 openbmc@lists.ozlabs.org, linux-tegra@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, linux-omap@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kbuild@vger.kernel.org
X-Mailer: b4 0.13-dev

I had a branch with most of these changes sitting in my tree for some 
time. Geert's asking about some errors not getting found prompted me to 
clean it up and send it out. This series fixes all* interrupt related 
warnings and enables the check by default. 

SoC maintainers, Can you please take this series directly. 

Rob

*There's a few Renesas warnings still Geert said he would fix.

Signed-off-by: Rob Herring <robh@kernel.org>
---
Rob Herring (6):
      arm64: dts: freescale: Disable interrupt_map check
      arm: dts: Fix dtc interrupt_provider warnings
      arm64: dts: Fix dtc interrupt_provider warnings
      arm: dts: Fix dtc interrupt_map warnings
      arm64: dts: qcom: Fix interrupt-map cell sizes
      dtc: Enable dtc interrupt_provider check

 arch/arm/boot/dts/amazon/alpine.dtsi                  |  1 -
 arch/arm/boot/dts/aspeed/aspeed-g4.dtsi               | 14 --------------
 arch/arm/boot/dts/aspeed/aspeed-g5.dtsi               | 15 +--------------
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi               | 18 ++----------------
 arch/arm/boot/dts/broadcom/bcm-cygnus.dtsi            |  3 +++
 arch/arm/boot/dts/broadcom/bcm-hr2.dtsi               |  1 +
 arch/arm/boot/dts/broadcom/bcm-nsp.dtsi               |  2 ++
 .../boot/dts/intel/ixp/intel-ixp42x-gateway-7001.dts  |  2 ++
 .../dts/intel/ixp/intel-ixp42x-goramo-multilink.dts   |  2 ++
 arch/arm/boot/dts/marvell/kirkwood-l-50.dts           |  2 ++
 arch/arm/boot/dts/nuvoton/nuvoton-wpcm450.dtsi        |  2 ++
 arch/arm/boot/dts/nvidia/tegra30-apalis-v1.1.dtsi     |  1 -
 arch/arm/boot/dts/nvidia/tegra30-apalis.dtsi          |  1 -
 arch/arm/boot/dts/nvidia/tegra30-colibri.dtsi         |  1 -
 arch/arm/boot/dts/nxp/imx/imx6q-b850v3.dts            |  3 ---
 arch/arm/boot/dts/nxp/imx/imx6q-bx50v3.dtsi           |  2 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi         |  1 -
 arch/arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi        |  1 -
 arch/arm/boot/dts/nxp/imx/imx6qdl-emcon.dtsi          |  1 -
 arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-pfla02.dtsi  |  1 +
 .../boot/dts/nxp/imx/imx6qdl-phytec-phycore-som.dtsi  |  1 +
 arch/arm/boot/dts/nxp/imx/imx7d-pico-dwarf.dts        |  1 +
 arch/arm/boot/dts/nxp/vf/vf610-zii-dev-rev-b.dts      |  1 +
 arch/arm/boot/dts/qcom/qcom-sdx55.dtsi                |  8 ++++----
 arch/arm/boot/dts/st/stm32429i-eval.dts               |  1 -
 arch/arm/boot/dts/st/stm32mp157c-dk2.dts              |  1 -
 arch/arm/boot/dts/ti/omap/am5729-beagleboneai.dts     |  1 -
 arch/arm64/boot/dts/amazon/alpine-v2.dtsi             |  1 -
 arch/arm64/boot/dts/amazon/alpine-v3.dtsi             |  1 -
 arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi      |  1 +
 arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi   |  1 +
 arch/arm64/boot/dts/freescale/Makefile                | 19 +++++++++++++++++++
 arch/arm64/boot/dts/lg/lg1312.dtsi                    |  1 -
 arch/arm64/boot/dts/lg/lg1313.dtsi                    |  1 -
 arch/arm64/boot/dts/marvell/armada-ap80x.dtsi         |  1 -
 arch/arm64/boot/dts/mediatek/mt8195-demo.dts          |  1 +
 arch/arm64/boot/dts/qcom/ipq6018.dtsi                 |  8 ++++----
 arch/arm64/boot/dts/qcom/ipq8074.dtsi                 | 16 ++++++++--------
 arch/arm64/boot/dts/renesas/ulcb-kf.dtsi              |  4 ++++
 scripts/Makefile.lib                                  |  3 +--
 40 files changed, 65 insertions(+), 81 deletions(-)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240213-arm-dt-cleanups-76bb726de948

Best regards,
-- 
Rob Herring <robh@kernel.org>


