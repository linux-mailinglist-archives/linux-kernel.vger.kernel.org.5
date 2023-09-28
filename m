Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076C37B174F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 11:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbjI1J0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 05:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbjI1JZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 05:25:23 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD27CF9;
        Thu, 28 Sep 2023 02:25:18 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38S9P3fd069043;
        Thu, 28 Sep 2023 04:25:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1695893103;
        bh=P9o4tq79uA35dbYJVQYuXuuWplStgOw/NJTItLt8iuk=;
        h=From:Date:Subject:References:In-Reply-To:To:CC;
        b=H0cHi6ePX9OIo9v4qddocyrXGHv0MMp8MFMueJvJY5wqOdRCx5rqnauhcJDdkYeCX
         1Kx2mL4qAXqgW3v9OtIxDo7YTjTWiN06SuvTTUxwkfOjtm/NSxLQCO+Rs+ve84APEn
         l+A7yhOC646SU+IrLBPTzLb/pv5BviP2ouvfyCZg=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38S9P3DD013012
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 Sep 2023 04:25:03 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 28
 Sep 2023 04:25:03 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 28 Sep 2023 04:25:02 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38S9P1pY090139;
        Thu, 28 Sep 2023 04:25:02 -0500
From:   Jai Luthra <j-luthra@ti.com>
Date:   Thu, 28 Sep 2023 14:54:26 +0530
Subject: [PATCH v2 1/6] arm64: dts: ti: k3-am62a-main: Add nodes for McASP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230928-mcasp_am62a-v2-1-ce9f0e1ba22b@ti.com>
References: <20230928-mcasp_am62a-v2-0-ce9f0e1ba22b@ti.com>
In-Reply-To: <20230928-mcasp_am62a-v2-0-ce9f0e1ba22b@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devarsht@ti.com>, <a-bhatia1@ti.com>,
        Jai Luthra <j-luthra@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2715; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=W0CFJHzCWlZGY7NHNntLX4dpZnlqu3OOkzLG1IBCpRA=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBlFUZhnLmWY1gkdjpYkGupilQzHrolEFlysUCQb
 8/fHYwcHOuJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZRVGYQAKCRBD3pH5JJpx
 RXAtD/9zAhbKwGEn+nq21jbBkrSD3LKHFqKhjLZVcFOU7QaA/d0y1BdjJSzZzu4fIZg5J1RAga4
 Rvfw4GSJ2FVzBZR7M+KDLoNdhECiAxSUKolXt6hKGtv7ql8lfVCfXqdvS20kpiby/LerHhX5cyp
 j1tbUXy/zt01CqbYK8hH6VHgh16WC8rwFURpWA8TlGLExamfH+TgQA4iCsaJ+suHbZQbhg73ENe
 sfMjeJf1fJDsM7tS8qtCYtJkEhrhYNL+cWQ/H7BT0tOJ9TKLy2EhI5djOvARj71LIpZ3ps5nRGj
 /tvwUaVcRljWiA2pRCSu1xZ4nfy4cTh96CfcNMy0P6HqFqcZvY1JJfxHsvh68fdNjntyqtwG6Xg
 cjG7hHlqBZWoMg1aUi/0mg8UA4bW5bn5hlKnw+n6hpIc49wHPAnSvLMh1ywuEygibEcqdsUBO2E
 syomPS8Yq0FiwoNkDv9WoWx6f/l04Wda/EA1p7wZdJ94xX4oBY25rQ0Kxb6qM/Pxo2ip/yITrsr
 f8O06KDjWLO73YUzXTSIG39DpcXEOXTLkGB1uFV+8Ld6G/aVZpczxG/xlNMlm4cZrflouKOBqe9
 SzKvOSRohGcSAlHhZROP2RNGtttoK5mZSzZMNdn1ZDrEloP5XbDeoiQURuhDAUP5K+klgAJ2cjj
 ZriXtYHE83a2OAw==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Same as AM62, AM62A has three instances of McASP which can be used for
transmitting or receiving digital audio in various formats.

Reviewed-by: Jayesh Choudhary <j-choudhary@ti.com>
Reviewed-by: Devarsh Thakkar <devarsht@ti.com>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 60 +++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
index 3198af08fb9f..4ae7fdc5221b 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
@@ -816,4 +816,64 @@ ecap2: pwm@23120000 {
 		clock-names = "fck";
 		status = "disabled";
 	};
+
+	mcasp0: audio-controller@2b00000 {
+		compatible = "ti,am33xx-mcasp-audio";
+		reg = <0x00 0x02b00000 0x00 0x2000>,
+		      <0x00 0x02b08000 0x00 0x400>;
+		reg-names = "mpu", "dat";
+		interrupts = <GIC_SPI 236 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 235 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "tx", "rx";
+
+		dmas = <&main_bcdma 0 0xc500 0>, <&main_bcdma 0 0x4500 0>;
+		dma-names = "tx", "rx";
+
+		clocks = <&k3_clks 190 0>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 190 0>;
+		assigned-clock-parents = <&k3_clks 190 2>;
+		power-domains = <&k3_pds 190 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	mcasp1: audio-controller@2b10000 {
+		compatible = "ti,am33xx-mcasp-audio";
+		reg = <0x00 0x02b10000 0x00 0x2000>,
+		      <0x00 0x02b18000 0x00 0x400>;
+		reg-names = "mpu", "dat";
+		interrupts = <GIC_SPI 238 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 237 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "tx", "rx";
+
+		dmas = <&main_bcdma 0 0xc501 0>, <&main_bcdma 0 0x4501 0>;
+		dma-names = "tx", "rx";
+
+		clocks = <&k3_clks 191 0>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 191 0>;
+		assigned-clock-parents = <&k3_clks 191 2>;
+		power-domains = <&k3_pds 191 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	mcasp2: audio-controller@2b20000 {
+		compatible = "ti,am33xx-mcasp-audio";
+		reg = <0x00 0x02b20000 0x00 0x2000>,
+		      <0x00 0x02b28000 0x00 0x400>;
+		reg-names = "mpu", "dat";
+		interrupts = <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 239 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "tx", "rx";
+
+		dmas = <&main_bcdma 0 0xc502 0>, <&main_bcdma 0 0x4502 0>;
+		dma-names = "tx", "rx";
+
+		clocks = <&k3_clks 192 0>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 192 0>;
+		assigned-clock-parents = <&k3_clks 192 2>;
+		power-domains = <&k3_pds 192 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
 };

-- 
2.42.0

