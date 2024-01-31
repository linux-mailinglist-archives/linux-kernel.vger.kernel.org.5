Return-Path: <linux-kernel+bounces-46516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8AE8440CF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A7E01F2BC35
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9083C83CBE;
	Wed, 31 Jan 2024 13:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWOWLa7W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE50F83CB8;
	Wed, 31 Jan 2024 13:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706708348; cv=none; b=TKNP84yrKJWvPRaqy0S55R8K5Vc6Y5mxJBz4SiAEgSsGi/OS/mCFAw2H8gPXaZ1eBzsY7ZzyA7xCPsbg4RsbMSWB2/laVQp9wBKT9ytLhz0kE5DGfvjXTYmBBCPM1p019qfSsYAgf1J7BPrDi02expgNjMndWjQ5aT+KXr1EEP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706708348; c=relaxed/simple;
	bh=TEoBcq07sKA3KFqE6Y9J+f8ZeVl1OlpAdt/o3ypscuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U9y9HRzKZ67/keC/xB2DTMlH+batj+Eoj91OwmZJsDWGrkuk5SsTKmNtk+OMsLKfXoQ7AvWMuAZhc1Bk+6Fwj8Eieb2sngqi3N8q9SFyLuHqP3cnWhot30n+w1GE76wtCSzk4MjF/gHbn7Oj5Cj5sCogeFYAClvEKgZ0pbpwpYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWOWLa7W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F90C43394;
	Wed, 31 Jan 2024 13:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706708348;
	bh=TEoBcq07sKA3KFqE6Y9J+f8ZeVl1OlpAdt/o3ypscuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mWOWLa7WXNfP1YOMkESI+rwFi+vG5JrXK+27N1W7D82vzATNcbM+rd7sEvct75LdN
	 Z4h/5yWfBGzeXGEbSV9uNqHRubMWPDhrAorFYh7TDaKYqA64mOH9w89KxaCnu/QdVI
	 4XorwyCRCdPOFX7vNbnzg5+gpo/0L3+lO0gyhtcG1gQS20BAhprkphv4y5m9fK9sqf
	 5uD4BY2g38tJgACQ6aLU+Luhyt47+QryIJ0XAq6wnkQSXQiC9REo5utXbCZ48N5pFd
	 GnoAepkaw71YmsY/7S8lKn9rB8D0IUw/s3zFvUeJ4YvE0NxiLoQQ2es+n1HjkHeQIB
	 q3pjaSbgZRSSg==
From: Jisheng Zhang <jszhang@kernel.org>
To: Conor Dooley <conor@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Emil Renner Berthing <kernel@esmil.dk>
Cc: linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/6] riscv: dts: starfive: add Milkv Mars board device tree
Date: Wed, 31 Jan 2024 21:26:00 +0800
Message-ID: <20240131132600.4067-7-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131132600.4067-1-jszhang@kernel.org>
References: <20240131132600.4067-1-jszhang@kernel.org>
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
 .../boot/dts/starfive/jh7110-milkv-mars.dts   | 35 +++++++++++++++++++
 2 files changed, 36 insertions(+)
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
index 000000000000..de600e799e7d
--- /dev/null
+++ b/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
+ */
+
+/dts-v1/;
+#include "jh7110-visionfive2-mars-common.dtsi"
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
+
+&mmc1 {
+	disable-wp;
+	cd-gpios = <&sysgpio 41 GPIO_ACTIVE_LOW>;
+};
-- 
2.43.0


