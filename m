Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0828D79CFBF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 13:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234507AbjILLV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 07:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234565AbjILLVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 07:21:07 -0400
Received: from m-r1.th.seeweb.it (m-r1.th.seeweb.it [5.144.164.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0845410DC;
        Tue, 12 Sep 2023 04:20:56 -0700 (PDT)
Received: from [192.168.2.137] (bband-dyn191.178-41-225.t-com.sk [178.41.225.191])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 0309020311;
        Tue, 12 Sep 2023 13:20:54 +0200 (CEST)
From:   Martin Botka <martin.botka@somainline.org>
Date:   Tue, 12 Sep 2023 13:20:50 +0200
Subject: [PATCH v6 4/4] arm64: dts: allwinner: h616: Add BigTreeTech Pi
 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230912-b4-cb1-v6-4-bb11238f3a9c@somainline.org>
References: <20230912-b4-cb1-v6-0-bb11238f3a9c@somainline.org>
In-Reply-To: <20230912-b4-cb1-v6-0-bb11238f3a9c@somainline.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev,
        Andre Przywara <andre.przywara@arm.com>,
        Alan Ma <tech@biqu3d.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Martin Botka <martin@biqu3d.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rogerio Goncalves <rogerlz@gmail.com>,
        Martin Botka <martin.botka@somainline.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694517652; l=2588;
 i=martin.botka@somainline.org; s=20230811; h=from:subject:message-id;
 bh=03FaITy9sLqnZR2l9y2cXQq7M8YyDzN2TA0+GbBYgco=;
 b=is4jnH9gWwrXRLkOQPkvB9tWstUQMBd98dqrVy00Rx8gv8Rw4eC0Dg4RzUTUX9TMrUDIFYcFp
 VJL1GwD6PS5C410TE2aNazjB5yTZBj48bLmr8hAzXGUOzmbg1PSv+yX
X-Developer-Key: i=martin.botka@somainline.org; a=ed25519;
 pk=aTCd3jmwU8GrJidWg3DSKLpdVMcpFzXzCSLXLR6NtWU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Botka <martin@biqu3d.com>

The BigTreeTech Pi is an H616 based board based on CB1.
Just in Rpi format board.

It features the same internals as BTT CB1 but adds:
    - Fan port
    - IR receiver
    - ADXL345 Accelerometer connector via SPI
    - 24V DC power supply via terminal plugs
    - USB to CAN module connector (External Module)

List of currently working things is same as BTT CB1 but also:
    - IR receiver
    - ADXL345 connector

Signed-off-by: Martin Botka <martin@biqu3d.com>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm64/boot/dts/allwinner/Makefile             |  1 +
 .../dts/allwinner/sun50i-h616-bigtreetech-pi.dts   | 63 ++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
index 42e525b9d4b9..3aca6787a167 100644
--- a/arch/arm64/boot/dts/allwinner/Makefile
+++ b/arch/arm64/boot/dts/allwinner/Makefile
@@ -39,6 +39,7 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64-model-b.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6-mini.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-bigtreetech-cb1-manta.dtb
+dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-bigtreetech-pi.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-orangepi-zero2.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-x96-mate.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h618-orangepi-zero3.dtb
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-pi.dts b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-pi.dts
new file mode 100644
index 000000000000..832f08b2b260
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-pi.dts
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+/*
+ * Copyright (C) 2023 Martin Botka <martin@biqu3d.com>.
+ */
+
+/dts-v1/;
+
+#include "sun50i-h616-bigtreetech-cb1.dtsi"
+
+/ {
+	model = "BigTreeTech Pi";
+	compatible = "bigtreetech,pi", "allwinner,sun50i-h616";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&ehci2 {
+	status = "okay";
+};
+
+&ehci3 {
+	status = "okay";
+};
+
+&ir {
+	status = "okay";
+};
+
+&ohci0 {
+	status = "okay";
+};
+
+&ohci1 {
+	status = "okay";
+};
+
+&ohci2 {
+	status = "okay";
+};
+
+&ohci3 {
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_ph_pins>;
+	status = "okay";
+};

-- 
2.42.0

