Return-Path: <linux-kernel+bounces-129348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF958968DD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B41A22824D9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978996BFC2;
	Wed,  3 Apr 2024 08:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gj1GCpjE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D989926286;
	Wed,  3 Apr 2024 08:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712133501; cv=none; b=Hv6zSGvYPk23NNvNC9bbS3+tg7gOqisYm9m2Fe7YiaARJNNcoSEXI1zCkgwmOTseqO/nRfA3sjN9Ei2EqcQ4hP/MjOJn4S69VSUwXiUjeKChiSXAmWgIfLCU1Vs3Ll4NdYVGz/p80UpztAVqaiV8QZj5x6WTMV1R41kKxK8QWxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712133501; c=relaxed/simple;
	bh=Ra75WPCtHvHR+qYIxgcoyt3//sMNrTmSWmOF780LOxs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hIgRvxcaSbMdah3ucAxZl1k8kzTK4U5t4sShbvfAXtCp/EauDTZTGyWZn5GZAigYIlchXIVXVWB5f6wfqxJ2gjL38W+R1tCTHAY8RDy0VM6HO5vcmHggCKfoEiYhzYzRF2t09lJZzq7TPfrORHKScMsHbrVa0IJ4RIBlBrYZfUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gj1GCpjE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D9A4C43390;
	Wed,  3 Apr 2024 08:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712133501;
	bh=Ra75WPCtHvHR+qYIxgcoyt3//sMNrTmSWmOF780LOxs=;
	h=From:To:Cc:Subject:Date:From;
	b=gj1GCpjEhNNbfqlAWm+yPDHbxxj9q0tcDP2Gv4VRpaqtI7mpqI8UyWYq+F66R8CDe
	 IUbC0QZEB9TCeZds27kp4+zCKpDMPbN6XX2436BEQDjz5uqGzr5ChVKu8zrQW32o2R
	 nUHvWkkchKop31sPNNKFRa9Bix61cb5JE/fzrFjei4t8rRzUZy7zXpvK2TlnAAPmc4
	 k5RVYwHWKQhBFADyah1f4Hu3xhp0Lcaz/712SH/rsQt4xiqSdB3csTZhXsCX2v8t5w
	 yFS1b7GLx/GTrJgLeYh1cDM+GeCVeVI/y4bEpWJgxwTiHL2tBhM+BaGuxA2iczOsn/
	 T98J6Bdr0a7OA==
From: Michael Walle <mwalle@kernel.org>
To: Shawn Guo <shawnguo@kernel.org>,
	Li Yang <leoyang.li@nxp.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH] arm64: dts: ls1028a: sl28: split variant 3/ads2 carrier
Date: Wed,  3 Apr 2024 10:38:12 +0200
Message-Id: <20240403083812.3898480-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The devicetree files can be (re-)used in u-boot now, they are imported
on a regular basis (see OF_UPSTREAM option) there. Up until now, it
didn't matter for linux and there was just a combined devicetree
"-var3-ads2" (with ads2 being the carrier board). But if the devicetree
files are now reused in u-boot, we need to have an individual "-var3"
variant, because the bootloader is just using the bare "varN" devicetree
files. Split the "var3" off of the "-var3-ads2" devicetree.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 arch/arm64/boot/dts/freescale/Makefile         |  1 +
 .../fsl-ls1028a-kontron-sl28-var3-ads2.dts     |  2 +-
 .../fsl-ls1028a-kontron-sl28-var3.dts          | 18 ++++++++++++++++++
 3 files changed, 20 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 045250d0a040..9319791f298c 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -9,6 +9,7 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-kontron-kbox-a-230-ls.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-kontron-sl28.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-kontron-sl28-var1.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-kontron-sl28-var2.dtb
+dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-kontron-sl28-var3.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-kontron-sl28-var3-ads2.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-kontron-sl28-var4.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-qds.dtb
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts
index ed4e69e87e30..195bdbafdf7c 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts
@@ -10,7 +10,7 @@
 /dts-v1/;
 
 #include <dt-bindings/clock/fsl,qoriq-clockgen.h>
-#include "fsl-ls1028a-kontron-sl28.dts"
+#include "fsl-ls1028a-kontron-sl28-var3.dts"
 
 / {
 	model = "Kontron SMARC-sAL28 (Single PHY) on SMARC Eval 2.0 carrier";
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dts
new file mode 100644
index 000000000000..08851ca407a8
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3.dts
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Device Tree file for the Kontron SMARC-sAL28 board.
+ *
+ * This is for the network variant 3 which has one ethernet ports.
+ *
+ * Copyright (C) 2024 Michael Walle <michael@walle.cc>
+ *
+ */
+
+/dts-v1/;
+
+#include "fsl-ls1028a-kontron-sl28.dts"
+
+/ {
+	model = "Kontron SMARC-sAL28 (Single PHY)";
+	compatible = "kontron,sl28-var3", "kontron,sl28", "fsl,ls1028a";
+};
-- 
2.39.2


