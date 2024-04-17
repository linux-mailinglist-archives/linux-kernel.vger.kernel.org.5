Return-Path: <linux-kernel+bounces-148013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F38B48A7C99
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DAE91F21B53
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 06:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C6E6A356;
	Wed, 17 Apr 2024 06:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KobxSWXE"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B24657DE;
	Wed, 17 Apr 2024 06:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713336812; cv=none; b=giQEcOLaFI/CKXvaI34x7ezJw35HbTv1GLfxAatHLg/l+MsbiFHf4bFPWQJ76doQlrrPHH3Ig7QV3l3gAUOZrtpJkBX0PonrGqLfTha64x0lEJFF9CBcreSKhS0MmYaXcreFdeBkohuO4B3kCL8RUJgN3+iWb9B4QHXoEosvnYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713336812; c=relaxed/simple;
	bh=6ii3AfRuA3sPBb951dxEXqbfa4ijMl3yiXbKuoGNAsw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R55iR02ZdK3Zz1LkDlvPLlVK8EtuEf7yA4Gxp7idlfVbmX3i6M57tbHuUhgvRK8HqfG16cQcxMm9kV2PwiUMWQnbNaOF7kpxHZct/89/cJxgEpS2UWC7xGmB5tghAkgcB7cnpyYIGEq1/4Av0blcAyGxZtZf5g12Ehxr4iTZxmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KobxSWXE; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B3039240008;
	Wed, 17 Apr 2024 06:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713336803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/b/Bao1n++Z1U5an6jjhD+dXCmOsGr+liOlM7nOxZvM=;
	b=KobxSWXEW6BiPs+AYecBL9IdtQJL8BhOcLZAYA+zlTOlDBkErRWan0EAHw5n2vLWvTFZSC
	QTWMGSCAH8Jq6tNsRss/Au19gEeDJ69/QxnLj1P2opvUpK88aHT4ZRIpU0q6pdzDf6Nfdp
	t9ryniF5JK8Xb7BsdVKg+noEAnVb1MjCByLmcY4p3u3OLIdThH5RQmHbHbGIalYTqYXzZQ
	dr62GOd3LOzu/853nw5422qaQr0LMi/oVbGaUoX59Id1knA1T+bp02R3akYMT1XIIw2RKX
	zOUu42gWcTI2c2Tajik951NU/GsMT8gLgTiD4mtmqygCtyDsr4dgsqZFOZAszA==
From: michael.opdenacker@bootlin.com
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
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
Subject: [PATCH v5 2/2] riscv: dts: sophgo: add initial Milk-V Duo S board support
Date: Wed, 17 Apr 2024 08:53:11 +0200
Message-Id: <20240417065311.3881023-3-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240417065311.3881023-1-michael.opdenacker@bootlin.com>
References: <20240417065311.3881023-1-michael.opdenacker@bootlin.com>
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
(https://milkv.io/duo-s), enabling the serial port,
making it possible to boot Linux to the command line.

Link: https://lore.kernel.org/linux-riscv/171266958507.1032617.9460749136730849811.robh@kernel.org/T/#t

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
---
 arch/riscv/boot/dts/sophgo/Makefile           |  1 +
 .../boot/dts/sophgo/sg2000-milkv-duos.dts     | 34 +++++++++++++++++++
 2 files changed, 35 insertions(+)
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
index 000000000000..c1ecf97d5e93
--- /dev/null
+++ b/arch/riscv/boot/dts/sophgo/sg2000-milkv-duos.dts
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2024 Michael Opdenacker <michael.opdenacker@bootlin.com>
+ */
+
+/dts-v1/;
+
+#include "cv1812h.dtsi"
+
+/ {
+	model = "Milk-V Duo S";
+	compatible = "milkv,duos", "sophgo,cv1812h";
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
+&uart0 {
+	status = "okay";
+};
-- 
2.34.1


