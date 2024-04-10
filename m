Return-Path: <linux-kernel+bounces-137929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4355889E9B0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F38D3285BD5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 05:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79AA17552;
	Wed, 10 Apr 2024 05:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DKJGJ4TU"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9431614AA3;
	Wed, 10 Apr 2024 05:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712726775; cv=none; b=lFjrNdtGNziwCw/CiHnA8g1oW7E8arwApWuUYAdYunMoIa+Ic7sTfQoVjKT341bbUmmcbZ+fTWzltWUMw9fqpevrUFSNaWttUKv0S7ir3GZdv+i+k0wHbXGON1QRFLY9iQ3IugP4V6/ocnkjilDjDxJL51V2IFlOwhj8WqbJOKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712726775; c=relaxed/simple;
	bh=Bmrmn+Z1e0QZcIQKtRBnRnegyNa+yT2pHcOA0yj1fKI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VaBlfnmPDh9ZJSP+yEuj84uyTIKQe/MAEIbMBWdsxxeQNigoT09aXqeyQgVe7o2A8X7bEzdSAXhS06VGS2pcvA4aiux0QZFWMuF0oAOvtG/FkX0CQCCmhtvrlovvqSo5fGfxkn43G41hai2Ms79269gg47DhaialUsFmWEjqPPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DKJGJ4TU; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1D39F40004;
	Wed, 10 Apr 2024 05:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712726765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Um4WIpNb1+UQMrQR3QwYZbAFwR55RaRCf7rvIeJqRyQ=;
	b=DKJGJ4TUpnK07O1tTxfbOo9Jn8xpVTX6kkZmlkw00Sk6w32AukkU75a+BZNFF3UIb4lUCn
	xio1pN0aJjZhkrosFz8LwK1uxNOIIc4KfIeJJUKEmu2XZWVnwJ5/JVD57couggLOZ5uKvv
	yA+X/UBKjnSwBajOr/NDc45wqbg1LZIR/oYW58Jel8PHi1wz4CYYHtkgg6m8C299V8uBeg
	8vCRjeLn8JKgi6SQ0hQiSavczaBeG/8O+zh4PfXkAY1uKjjmtnTzJNR8TDbccGzWRVW2vx
	foF/5dSDWVn2cuswImvQ/z7sHzbfSmzmT7QHfApy4C76BU04asG/iPyBuXygMw==
From: michael.opdenacker@bootlin.com
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>
Cc: Michael Opdenacker <michael.opdenacker@bootlin.com>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] riscv: dts: sophgo: add initial Milk-V Duo S board support
Date: Wed, 10 Apr 2024 07:25:18 +0200
Message-Id: <20240410052518.2945789-3-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240410052518.2945789-1-michael.opdenacker@bootlin.com>
References: <20240410052518.2945789-1-michael.opdenacker@bootlin.com>
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
SD card support, allowing to boot Linux to the command line.

Link: https://lore.kernel.org/linux-riscv/171266958507.1032617.9460749136730849811.robh@kernel.org/T/#t

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
---
 arch/riscv/boot/dts/sophgo/Makefile           |  1 +
 .../boot/dts/sophgo/sg2000-milkv-duos.dts     | 39 +++++++++++++++++++
 2 files changed, 40 insertions(+)
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
index 000000000000..679d2854938a
--- /dev/null
+++ b/arch/riscv/boot/dts/sophgo/sg2000-milkv-duos.dts
@@ -0,0 +1,39 @@
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
+	compatible = "milkv,duos", "sophgo,cv1800b";
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
+	disable-wp;
+};
+
+&uart0 {
+	status = "okay";
+};
-- 
2.34.1


