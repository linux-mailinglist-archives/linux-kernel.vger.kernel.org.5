Return-Path: <linux-kernel+bounces-152450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 957368ABEA5
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 07:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E16A281138
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 05:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9B8DDC5;
	Sun, 21 Apr 2024 05:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QFQZOs1/"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577DADDDA;
	Sun, 21 Apr 2024 05:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713679061; cv=none; b=e2AFN2BPGigvqJKNT/0pMvbmkOouEo9NoWTjas5FL92O3hrVJme6xkjFDHtdEyFv0zY1OpHN5ByQCt6xWINJqAruzNQi0ARpbEac6ogyO3pM5Cg2vP9qMTUUpteI19fbBW/Vj6ocMfvnrxT0UErXw4rePXWkfXEwr70fFdDWwGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713679061; c=relaxed/simple;
	bh=RmjcRZSDfh0uEbK8YVPspP9K4yuWY0Nqm5oshNAFFAI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZYoMlIAERQpeIlRtoFNAmtMxYW45TkFsOQ2w+Del7dkAcebNf7SZSzXOyPpphSRSVg1OmfOCAOxP2GY/2T/TLR3awZYOIxB440J3efRRsu8dNkV7OtArR1xVAnzUaZ/ayhYHSuhBQ/XoTCE1LfTMlXeznliiRQln4CgBv48d7ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QFQZOs1/; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E5DF7E0002;
	Sun, 21 Apr 2024 05:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713679052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ALRgEqg1EmSyQ1bclqTiV+s3lMvYL3j/L/5ogb0OnCU=;
	b=QFQZOs1/Fi8ooM3ZMCBTv6RAaFwxqBWsbcNZhKq2GmokE8kGOOlcFkhaXNksADpD6EFarB
	FOPa5CXuLVmPIRzX9jr6ZARfBBN0z42pENX8/pIh0fK+VOyNlb3bXgrNO2JYI5aTURA3bC
	dXCWyF6T51BELDdbXUmw7eq6rgtbQS1J8Jd4WSuiPuraGIqB5Ksj5yjag/0s+GZvadMdzi
	y68xJJLAh6esp2czwYkYOKZgVgQ0i9CSI9fvkoSJoPgGaT7fn7YF0LPStf+coW0S9twWfj
	S5xjhNPVxPLJX/cJpY1cDoZNsadn4OMv0Y1zqP+WNxADtx11fs7+DpVdgvhfAA==
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
Subject: [PATCH v6 2/2] riscv: dts: sophgo: add initial Milk-V Duo S board support
Date: Sun, 21 Apr 2024 07:57:10 +0200
Message-Id: <20240421055710.143617-3-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240421055710.143617-1-michael.opdenacker@bootlin.com>
References: <20240421055710.143617-1-michael.opdenacker@bootlin.com>
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
 .../boot/dts/sophgo/cv1812h-milkv-duo-s.dts   | 33 +++++++++++++++++++
 2 files changed, 34 insertions(+)
 create mode 100644 arch/riscv/boot/dts/sophgo/cv1812h-milkv-duo-s.dts

diff --git a/arch/riscv/boot/dts/sophgo/Makefile b/arch/riscv/boot/dts/sophgo/Makefile
index 57ad82a61ea6..a410f6af03fc 100644
--- a/arch/riscv/boot/dts/sophgo/Makefile
+++ b/arch/riscv/boot/dts/sophgo/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_ARCH_SOPHGO) += cv1800b-milkv-duo.dtb
 dtb-$(CONFIG_ARCH_SOPHGO) += cv1812h-huashan-pi.dtb
+dtb-$(CONFIG_ARCH_SOPHGO) += cv1812h-milkv-duo-s.dtb
 dtb-$(CONFIG_ARCH_SOPHGO) += sg2042-milkv-pioneer.dtb
diff --git a/arch/riscv/boot/dts/sophgo/cv1812h-milkv-duo-s.dts b/arch/riscv/boot/dts/sophgo/cv1812h-milkv-duo-s.dts
new file mode 100644
index 000000000000..0f2991d8c8f5
--- /dev/null
+++ b/arch/riscv/boot/dts/sophgo/cv1812h-milkv-duo-s.dts
@@ -0,0 +1,33 @@
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
+	compatible = "milkv,duo-s", "sophgo,cv1812h";
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


