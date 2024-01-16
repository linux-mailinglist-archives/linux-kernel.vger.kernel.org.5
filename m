Return-Path: <linux-kernel+bounces-27428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F8C82EFE4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 14:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 728C01F23EC6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 13:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D839E1BF3C;
	Tue, 16 Jan 2024 13:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Ce6j5P/j"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87EB1BF29;
	Tue, 16 Jan 2024 13:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40GDfn7v071425;
	Tue, 16 Jan 2024 07:41:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1705412509;
	bh=aZhgKfvmpDmT/vHDRDphJaSYdogh+5E+fwDnTAIZayE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Ce6j5P/jyUuCFkwCdU7HutsJCyiCGK8AUBMRQaEtQ5Blj0HiFLNdWKEwtdblKOBSF
	 IudktK+XbGQrTkw1NpBHyjWHGBjxK52Kb3BoYaImyxCFn5E0iAY8Kg+/NnOPo055XB
	 D8Kur2Pwkx44nVk3T+yQTmPI+HaRU5RCnN1JUPA8=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40GDfnIA027046
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 16 Jan 2024 07:41:49 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 16
 Jan 2024 07:41:48 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 16 Jan 2024 07:41:48 -0600
Received: from localhost (ti.dhcp.ti.com [172.24.227.95] (may be forged))
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40GDfmRo063370;
	Tue, 16 Jan 2024 07:41:48 -0600
From: Devarsh Thakkar <devarsht@ti.com>
To: <jyri.sarha@iki.fi>, <tomi.valkeinen@ideasonboard.com>,
        <airlied@gmail.com>, <daniel@ffwll.ch>,
        <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>
CC: <praneeth@ti.com>, <a-bhatia1@ti.com>, <j-luthra@ti.com>,
        <devarsht@ti.com>
Subject: [RFC PATCH 3/3] arm64: dts: ti: k3-am62x: Add overlay to use DSS in display sharing mode
Date: Tue, 16 Jan 2024 19:11:42 +0530
Message-ID: <20240116134142.2092483-4-devarsht@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240116134142.2092483-1-devarsht@ti.com>
References: <20240116134142.2092483-1-devarsht@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

This overlay needs to be used with display sharing supported device
manager firmware only.

Remote core running this firmware has write access to "common" register
space, VIDL pipeline, OVR1 overlay and VP1 videoport.

The processing core running Linux is provided write access to VID
pipeline and "common1" register space.

The VP1 video port is shared between Linux and remote core with remote
core configuring the overlay manager to set Zorder 1 for VID pipeline
and Zorder 2 for VIDL pipeline.

Add reserved memory region for framebuffer region used by remote core in
dss shared mode overlay file so that Linux does not re-use the same
while allocating memory.

Also add a label for reserved memory region in base device-tree file so
that it can be referred back in overlay file.

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
 arch/arm64/boot/dts/ti/Makefile               |  1 +
 .../arm64/boot/dts/ti/k3-am62x-sk-common.dtsi |  2 +-
 .../dts/ti/k3-am62x-sk-dss-shared-mode.dtso   | 33 +++++++++++++++++++
 3 files changed, 35 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62x-sk-dss-shared-mode.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 52c1dc910308..ff832741b367 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -35,6 +35,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am62x-sk-csi2-ov5640.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am62x-sk-csi2-tevi-ov5640.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am62x-sk-csi2-imx219.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am62x-sk-hdmi-audio.dtbo
+dtb-$(CONFIG_ARCH_K3) += k3-am62x-sk-dss-shared-mode.dtbo
 
 # Boards with AM64x SoC
 dtb-$(CONFIG_ARCH_K3) += k3-am642-evm.dtb
diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
index 33768c02d8eb..8b55ca10102f 100644
--- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
@@ -34,7 +34,7 @@ memory@80000000 {
 		reg = <0x00000000 0x80000000 0x00000000 0x80000000>;
 	};
 
-	reserved-memory {
+	reserved_memory: reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges;
diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-dss-shared-mode.dtso b/arch/arm64/boot/dts/ti/k3-am62x-sk-dss-shared-mode.dtso
new file mode 100644
index 000000000000..02153748a5c2
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-dss-shared-mode.dtso
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+/**
+ * DT overlay to enable display sharing mode for AM62P DSS0
+ * This is compatible with custom AM62 Device Manager firmware
+ *
+ * Copyright (C) 2023 Texas Instruments Incorporated - http://www.ti.com/
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+&dss0 {
+	ti,dss-shared-mode;
+	ti,dss-shared-mode-vp = "vp1";
+	ti,dss-shared-mode-vp-owned = <0>;
+	ti,dss-shared-mode-common = "common1";
+	ti,dss-shared-mode-planes = "vid";
+	ti,dss-shared-mode-plane-zorder = <0>;
+	interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&reserved_memory {
+	#address-cells = <2>;
+	#size-cells = <2>;
+	rtos_framebuffer_memory_region: rtos-framebuffer-memory@94800000 {
+		compatible = "shared-dma-pool";
+		reg = <0x00 0x94800000 0x00 0x08000000>;
+		no-map;
+	};
+};
-- 
2.34.1


