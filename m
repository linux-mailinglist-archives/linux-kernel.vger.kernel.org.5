Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A548002D5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 06:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377475AbjLAFKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 00:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377396AbjLAFJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 00:09:54 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082C51724;
        Thu, 30 Nov 2023 21:10:00 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B159mO5049913;
        Thu, 30 Nov 2023 23:09:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1701407388;
        bh=6ItgAaMkCxt60XJc1WHuFhFNITAxxpb0vOwKj0LoWdI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=O5dHj2eU8ymR8pMM2OFKbPWglEZ1HcaHCpqVQBriKN1NuKh9/oPn6SAySGZN8tKv6
         zJaXU3BcBhiNO+QbzXdeR8cTrKQN6UBoXNbule3aDfmG/LQ/dAbtHDJNAUOoNindrw
         7X1Dv4wzL/saF9yFufLesb9LCNAtAhnj6Dsnf4gg=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B159m2p101906
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 30 Nov 2023 23:09:48 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 30
 Nov 2023 23:09:47 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 30 Nov 2023 23:09:48 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B159ldW023598;
        Thu, 30 Nov 2023 23:09:47 -0600
From:   Jai Luthra <j-luthra@ti.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Jai Luthra <j-luthra@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Aradhya Bhatia <a-bhatia1@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Julien Massot <julien.massot@collabora.com>,
        Martyn Welch <martyn.welch@collabora.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH RESEND v3 3/9] arm64: dts: ti: Enable CSI-RX on AM62A
Date:   Fri, 1 Dec 2023 10:39:18 +0530
Message-ID: <20231201-csi_dts-v3-3-9f06f31080fe@ti.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231201-csi_dts-v3-0-9f06f31080fe@ti.com>
References: <20231201-csi_dts-v3-0-9f06f31080fe@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3544; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=UdyZV1rZtSB6XPR1HDnodj8ZtnvMZqzU69UiUMbOr4Y=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBlaWXqkHU63MRWNdEE0pJJpyGiJT+nsYCBSDFxh
 kBPdMzuLcuJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZWll6gAKCRBD3pH5JJpx
 RfWRD/oCHu+epO3boPy2mt0/GhYJPIHCqb7rbd87iyocx9tHJ6CU06gfvLNLreCNxSDwwtruAC+
 mlJEqzWycW3M3Ne5eKVT6YzzdDyUVP8xtSq6iw67Bvv8qt0qeRopgdXDk0sHL8HOBf2QYkIoG3e
 kveHAVKsXv55LbDCVVWHKAw/RH0/vct/T6UjDIrlDGg+9Lq/pwJewD51hl7kdQBVrjS5RfEnDvM
 1YifkpQ0VAmp8FgyAble+p1hUZzla4j4CY/BK4TDsl0kGgRQRDiVFq94ZqzshZBLdCqxduUeXS1
 vswO7rI+jGEqmMHyxr/kVDBV8EpfAyxajJKjgAkYQcfAny5wen9YHUsrEh21Wss30lG9YsAeJpE
 zh1Ol9NtF4jBXsTmd1YTVFMNbSAGP7csGZvg8mi+/edtefqIhpcniVXcyudGZIexCxCBM0hEbbq
 Gk6LJzYEsfM4RqnvNk9UqoBGFaM4UGduCCui07lipz9BjNo+NsUlhk52kdyoQsXAl/rtCGLsEiY
 UY3/uzVxhBg2zwaNJXaqNbSZ0dYyv97UXXTsipAHQU/j1zBr71UUmykwYCpfE23NDd0FIPDkomu
 Mg43I+F0V8ypr3ByavTsU1hnKexGAFZkLNCLa3ZGsRMK7bz4VJbFy1Hqq41/V2T4maXibSEQMqD
 hMHKArkk/vKS6jQ==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp; fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nodes for Cadence DPHY, CSI2RX and TI's pixel-grabbing wrapper.
AM62A uses a dedicated BCDMA instance for CSI-RX traffic, so enable that
as well.

Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 99 +++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
index 4ae7fdc5221b..ea70d78eb132 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
@@ -144,6 +144,44 @@ main_pktdma: dma-controller@485c0000 {
 		};
 	};
 
+	dmss_csi: bus@4e000000 {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		dma-ranges;
+		ranges = <0x00 0x4e000000 0x00 0x4e000000 0x00 0x300000>;
+
+		ti,sci-dev-id = <198>;
+
+		inta_main_dmss_csi: interrupt-controller@4e0a0000 {
+			compatible = "ti,sci-inta";
+			reg = <0x00 0x4e0a0000 0x00 0x8000>;
+			#interrupt-cells = <0>;
+			interrupt-controller;
+			interrupt-parent = <&gic500>;
+			msi-controller;
+			ti,sci = <&dmsc>;
+			ti,sci-dev-id = <200>;
+			ti,interrupt-ranges = <0 237 8>;
+			ti,unmapped-event-sources = <&main_bcdma_csi>;
+			power-domains = <&k3_pds 182 TI_SCI_PD_EXCLUSIVE>;
+		};
+
+		main_bcdma_csi: dma-controller@4e230000 {
+			compatible = "ti,am62a-dmss-bcdma-csirx";
+			reg = <0x00 0x4e230000 0x00 0x100>,
+			      <0x00 0x4e180000 0x00 0x8000>,
+			      <0x00 0x4e100000 0x00 0x10000>;
+			reg-names = "gcfg", "rchanrt", "ringrt";
+			msi-parent = <&inta_main_dmss_csi>;
+			#dma-cells = <3>;
+			ti,sci = <&dmsc>;
+			ti,sci-dev-id = <199>;
+			ti,sci-rm-range-rchan = <0x21>;
+			power-domains = <&k3_pds 182 TI_SCI_PD_EXCLUSIVE>;
+		};
+	};
+
 	dmsc: system-controller@44043000 {
 		compatible = "ti,k2g-sci";
 		reg = <0x00 0x44043000 0x00 0xfe0>;
@@ -876,4 +914,65 @@ mcasp2: audio-controller@2b20000 {
 		power-domains = <&k3_pds 192 TI_SCI_PD_EXCLUSIVE>;
 		status = "disabled";
 	};
+
+	ti_csi2rx0: ticsi2rx@30102000 {
+		compatible = "ti,j721e-csi2rx-shim";
+		dmas = <&main_bcdma_csi 0 0x5000 0>;
+		dma-names = "rx0";
+		reg = <0x00 0x30102000 0x00 0x1000>;
+		power-domains = <&k3_pds 182 TI_SCI_PD_EXCLUSIVE>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		status = "disabled";
+
+		cdns_csi2rx0: csi-bridge@30101000 {
+			compatible = "ti,j721e-csi2rx", "cdns,csi2rx";
+			reg = <0x00 0x30101000 0x00 0x1000>;
+			clocks = <&k3_clks 182 0>, <&k3_clks 182 3>, <&k3_clks 182 0>,
+				<&k3_clks 182 0>, <&k3_clks 182 4>, <&k3_clks 182 4>;
+			clock-names = "sys_clk", "p_clk", "pixel_if0_clk",
+				"pixel_if1_clk", "pixel_if2_clk", "pixel_if3_clk";
+			phys = <&dphy0>;
+			phy-names = "dphy";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				csi0_port0: port@0 {
+					reg = <0>;
+					status = "disabled";
+				};
+
+				csi0_port1: port@1 {
+					reg = <1>;
+					status = "disabled";
+				};
+
+				csi0_port2: port@2 {
+					reg = <2>;
+					status = "disabled";
+				};
+
+				csi0_port3: port@3 {
+					reg = <3>;
+					status = "disabled";
+				};
+
+				csi0_port4: port@4 {
+					reg = <4>;
+					status = "disabled";
+				};
+			};
+		};
+	};
+
+	dphy0: phy@30110000 {
+		compatible = "cdns,dphy-rx";
+		reg = <0x00 0x30110000 0x00 0x1100>;
+		#phy-cells = <0>;
+		power-domains = <&k3_pds 185 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
 };

-- 
2.42.1

