Return-Path: <linux-kernel+bounces-161642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B33B8B4EF3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 02:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 195621C20AD1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 00:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABF012E5E;
	Mon, 29 Apr 2024 00:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nrHLlhOP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD03111A3;
	Mon, 29 Apr 2024 00:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714350428; cv=none; b=NZC9NdF7gqvKgQEIgI8p1P8H/u+B6RCUUo+99OfTQLRI7JqYxoBk/xhsOTZPxyRRFFO38oGEtwzwlC2OlzPEsmmFqF+NFIWs0vILTj6SBgJdS+uOMSbsYE10PDtoqoxV5e4bPkCnFPmW8nNtU5XHJINo2RMYvOQXctF/6S5C7Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714350428; c=relaxed/simple;
	bh=Me6kV0m1Pfmm/VqxiWspxINMuSUzJ8rjhLb86dLUq5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WFhD+QK96ZT1n35FuhZf/5FH1AK78KIrzbJYoJvNin19bac8G05EP6DV0p2DJBV6w8BwbC5aoB+DYErmp/mYCENSCMvn0o6PBX78P6FZ/yaFT159bOhyP2dWKqnGiOw708UYdtEe7SEq9CBsyl5C2RBt2hZvegEo3bpopoNMess=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nrHLlhOP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B201C4AF1B;
	Mon, 29 Apr 2024 00:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714350428;
	bh=Me6kV0m1Pfmm/VqxiWspxINMuSUzJ8rjhLb86dLUq5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nrHLlhOPF9845cevx6RTVszjP9xR769xlV9mNn5CNFexjwSTOVuh78FztRGyk8szx
	 xcvRWUmMcbDokAHnt9EsBeBFHE0Zfp8IzDnrJ5DqhfPI9GizymFU/rX+VOxrVqXbIo
	 FN8iYSmKdv3JngOQ8X7WXjrlD8pdrLgdMFs3dZIg8GyJOB8QBbB7dt7aI4gspgbZEc
	 XQljSieLVHSmPsYiWinlaQYD4NdItDTyC9rGlnfsVKYPD4ZdAPgv3PV5cBO96IJD+3
	 HKeWsVsp4KkYJtOM28uU6bniF4uXwI3kU0SoWiO0RxTPNc7IjZ1q9PJuNz+gxmd/RJ
	 Nl0ZCHM1rWaTw==
From: Jisheng Zhang <jszhang@kernel.org>
To: Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Emil Renner Berthing <kernel@esmil.dk>
Cc: linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 8/8] riscv: dts: starfive: add Milkv Mars board device tree
Date: Mon, 29 Apr 2024 08:13:17 +0800
Message-ID: <20240429001317.432-9-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240429001317.432-1-jszhang@kernel.org>
References: <20240429001317.432-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Milkv Mars is a development board based on the Starfive JH7110 SoC.
The board features:

- JH7110 SoC
- 1/2/4/8 GiB LPDDR4 DRAM
- AXP15060 PMIC
- 40 pin GPIO header
- 3x USB 3.0 host port
- 1x USB 2.0 host port
- 1x M.2 E-Key
- 1x eMMC slot
- 1x MicroSD slot
- 1x QSPI Flash
- 1x 1Gbps Ethernet port
- 1x HDMI port
- 1x 2-lane DSI and 1x 4-lane DSI
- 1x 2-lane CSI

Add the devicetree file describing the currently supported features,
namely PMIC, UART, I2C, GPIO, SD card, QSPI Flash, eMMC and Ethernet.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/boot/dts/starfive/Makefile         |  1 +
 .../boot/dts/starfive/jh7110-milkv-mars.dts   | 30 +++++++++++++++++++
 2 files changed, 31 insertions(+)
 create mode 100644 arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts

diff --git a/arch/riscv/boot/dts/starfive/Makefile b/arch/riscv/boot/dts/starfive/Makefile
index 0141504c0f5c..2fa0cd7f31c3 100644
--- a/arch/riscv/boot/dts/starfive/Makefile
+++ b/arch/riscv/boot/dts/starfive/Makefile
@@ -8,5 +8,6 @@ DTC_FLAGS_jh7110-starfive-visionfive-2-v1.3b := -@
 dtb-$(CONFIG_ARCH_STARFIVE) += jh7100-beaglev-starlight.dtb
 dtb-$(CONFIG_ARCH_STARFIVE) += jh7100-starfive-visionfive-v1.dtb
 
+dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-milkv-mars.dtb
 dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-starfive-visionfive-2-v1.2a.dtb
 dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-starfive-visionfive-2-v1.3b.dtb
diff --git a/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts b/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts
new file mode 100644
index 000000000000..fa0eac78e0ba
--- /dev/null
+++ b/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
+ */
+
+/dts-v1/;
+#include "jh7110-common.dtsi"
+
+/ {
+	model = "Milk-V Mars";
+	compatible = "milkv,mars", "starfive,jh7110";
+};
+
+&gmac0 {
+	starfive,tx-use-rgmii-clk;
+	assigned-clocks = <&aoncrg JH7110_AONCLK_GMAC0_TX>;
+	assigned-clock-parents = <&aoncrg JH7110_AONCLK_GMAC0_RMII_RTX>;
+};
+
+
+&phy0 {
+	motorcomm,tx-clk-adj-enabled;
+	motorcomm,tx-clk-10-inverted;
+	motorcomm,tx-clk-100-inverted;
+	motorcomm,tx-clk-1000-inverted;
+	motorcomm,rx-clk-drv-microamp = <3970>;
+	motorcomm,rx-data-drv-microamp = <2910>;
+	rx-internal-delay-ps = <1500>;
+	tx-internal-delay-ps = <1500>;
+};
-- 
2.43.0


