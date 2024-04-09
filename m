Return-Path: <linux-kernel+bounces-136324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6550E89D2AA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 935D51C214DE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 06:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF727605D;
	Tue,  9 Apr 2024 06:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="E5uSnUx7"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C39679CC;
	Tue,  9 Apr 2024 06:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712645219; cv=none; b=NHoUhM0g077DiNHvPTpopyxiq3G65vwaPCLPitLX8dSlGuDCjzrfZe7lJIeWR7kGh/f9suder2+VUHbLyFYq6k44Zs9Fm/DZJDBpGmKurXUzRGpEnGqZ5M/NGpCjLb8c6OV3uEiBB6Dnojtr3mF7ocDOZ09wR56cEbmYKcR00VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712645219; c=relaxed/simple;
	bh=6B0Ymq5uRpwiiFS6gQ99BSAtE8O9TZ3H8I3TtZjcVoo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jpQj9pD7347FQNVJyAO2M4Cy8o96kl7Gd9NzWxsN//YHaHT5A466VRjbhA0af4Lfllc2qv/CU1Qp5Mt68mxQ9+pkym6bhQVUOf62dSJLVbcJpYQ4IcpW+Mzdyj8jBQQlgu8RYHkaDRJoDbIc0xgohYePYJWdLbT0fZLHLROL8Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=E5uSnUx7; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 04B2AFF807;
	Tue,  9 Apr 2024 06:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712645214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6ryoNB5XpSfloz/6q8pX2eMqwyZYr/QlxtN0Gg+K+v4=;
	b=E5uSnUx7BqUopQsp6ozzcgkCtcsjKkTgQQQyQ+wBwuE+uj9lHySZO1iUQ9b2o7+P0u89PH
	2LAX5RZvUhgIPKEeIC2EvxuLYCV3/90NsUohDmxPZvqhkn7nxzg0awuHEH9kegMILNnSyO
	+t2xm2w4BKEqiCH1CRYK20/rxyLsdySXXt+GwZ9g6b3ARfxAe1KNlG0U8mdY0hT3ufcVeu
	AuyLZ9uHy5IRCOwNL9hB7kkYIeELzK1ASZ5CLUwjH6VJtY6bDqgJbPT9RHJHDQD6tqRdRP
	G+2jGiHTCyDKiINh/P7U+q7ibBdpbCbO/eLKygVyjYM8b7XnON+2NGJEqn8e4w==
From: michael.opdenacker@bootlin.com
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Michael Opdenacker <michael.opdenacker@bootlin.com>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: dts: sophgo: add initial Milk-V Duo S board device tree
Date: Tue,  9 Apr 2024 08:45:04 +0200
Message-Id: <20240409064504.4010353-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: michael.opdenacker@bootlin.com

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

This adds initial support for the Milk-V Duo S board
(https://milkv.io/duo-s), enabling the serial port and
read-only SD card support, allowing to boot Linux to the
command line.

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>

---

Tested with linux-next as of Apr 9, 2024,
using the risc-v "defconfig" configuration.
---
 arch/riscv/boot/dts/sophgo/Makefile           |  1 +
 .../boot/dts/sophgo/sg2000-milkv-duos.dts     | 38 +++++++++++++++++++
 2 files changed, 39 insertions(+)
 create mode 100644 arch/riscv/boot/dts/sophgo/sg2000-milkv-duos.dts

diff --git a/arch/riscv/boot/dts/sophgo/Makefile b/arch/riscv/boot/dts/sophgo/Makefile
index 57ad82a61ea6..e008acb5240f 100644
--- a/arch/riscv/boot/dts/sophgo/Makefile
+++ b/arch/riscv/boot/dts/sophgo/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_ARCH_SOPHGO) += cv1800b-milkv-duo.dtb
 dtb-$(CONFIG_ARCH_SOPHGO) += cv1812h-huashan-pi.dtb
+dtb-$(CONFIG_ARCH_SOPHGO) += sg2000-milkv-duos.dtb
 dtb-$(CONFIG_ARCH_SOPHGO) += sg2042-milkv-pioneer.dtb
diff --git a/arch/riscv/boot/dts/sophgo/sg2000-milkv-duos.dts b/arch/riscv/boot/dts/sophgo/sg2000-milkv-duos.dts
new file mode 100644
index 000000000000..cf2cec3cc369
--- /dev/null
+++ b/arch/riscv/boot/dts/sophgo/sg2000-milkv-duos.dts
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2024 Michael Opdenacker <michael.opdenacker@bootlin.com>
+ */
+
+/dts-v1/;
+
+#include "cv1800b.dtsi"
+
+/ {
+	model = "Milk-V Duo S";
+	compatible = "milkv,duos", "sophgo,sg2000";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x20000000>;
+	};
+};
+
+&osc {
+	clock-frequency = <25000000>;
+};
+
+&sdhci0 {
+	status = "okay";
+};
+
+&uart0 {
+	status = "okay";
+};
-- 
2.34.1


