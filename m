Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9DA774B4A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234737AbjHHUoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjHHUny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:43:54 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136D34224;
        Tue,  8 Aug 2023 13:19:01 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 378KIrJx108284;
        Tue, 8 Aug 2023 15:18:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691525933;
        bh=zXt4ju4JGytOC6ILenT99BtVykmjoVNKbJjShS+7HAI=;
        h=From:To:Subject:Date:In-Reply-To:References;
        b=icWYJnXBAOJpqQZCvkse2gQNYuu6a0tLynN23m7l/4bpr/gDsj+iAQueaGQDC83dl
         3jMcCw/s9Xbu4fBH5QPjXoJ/ITu7EmKkCFo4e1CvwpwxGmp5XUKAaIDpyhc8NVooOn
         aI2+JNNl2DvBTHvsudjPAeAuKkvEykeom8fdw+Cg=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 378KIr66127012
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Aug 2023 15:18:53 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 8
 Aug 2023 15:18:53 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 8 Aug 2023 15:18:53 -0500
Received: from TI.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 378KIgrg028651;
        Tue, 8 Aug 2023 15:18:50 -0500
From:   Apurva Nandan <a-nandan@ti.com>
To:     Apurva Nandan <a-nandan@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Udit Kumar <u-kumar1@ti.com>, Hari Nagalla <hnagalla@ti.com>
Subject: [PATCH v2 2/3] arm64: dts: ti: k3-j721s2-main: Add R5F and C7x remote processsor nodes
Date:   Wed, 9 Aug 2023 01:48:41 +0530
Message-ID: <20230808201842.292911-3-a-nandan@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808201842.292911-1-a-nandan@ti.com>
References: <20230808201842.292911-1-a-nandan@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hari Nagalla <hnagalla@ti.com>

The J721S2 SoCs have 2 dual-core Arm Cortex-R5F processor (R5FSS)
subsystems/clusters in MAIN voltage domain. Each of these can be
configured at boot time to be either run in a LockStep mode or in an
Asymmetric Multi Processing (AMP) fashion in Split-mode. These
subsystems have 64 KB each Tightly-Coupled Memory (TCM) internal
memories for each core split between two banks - ATCM and BTCM
(further interleaved into two banks). The TCMs of both Cores are
combined in LockStep-mode to provide a larger 128 KB of memory, but
otherwise are functionally similar to those on J721E SoCs.

Add the DT nodes for the MAIN domain R5F cluster/subsystems, the two
R5F cores are added as child nodes to each of the R5F cluster nodes.
The clusters are configured to run in LockStep mode by default, with
the ATCMs enabled to allow the R5 cores to execute code from DDR
with boot-strapping code from ATCM. The inter-processor communication
between the main A72 cores and these processors is achieved through
shared memory and Mailboxes.

The following firmware names are used by default for these cores, and
can be overridden in a board dts file if desired:
        MAIN R5FSS0 Core0: j721s2-main-r5f0_0-fw (both in LockStep & Split modes)
        MAIN R5FSS0 Core1: j721s2-main-r5f0_1-fw (needed only in Split mode)
        MAIN R5FSS1 Core0: j721s2-main-r5f1_0-fw (both in LockStep & Split modes)
        MAIN R5FSS1 Core1: j721s2-main-r5f1_1-fw (needed only in Split mode)

The K3 J721S2 SoCs have two C71x DSP subsystems in MAIN voltage domain. The
C71x DSPs are 64 bit machine with fixed and floating point DSP operations.
Similar to the R5F remote cores, the inter-processor communication
between the main A72 cores and these DSP cores is achieved through
shared memory and Mailboxes.

The following firmware names are used by default for these DSP cores,
and can be overridden in a board dts file if desired:
        MAIN C71_0 : j721s2-c71_0-fw
        MAIN C71_1 : j721s2-c71_1-fw

Signed-off-by: Hari Nagalla <hnagalla@ti.com>
Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 104 +++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
index dc7920a35237..c428a2b624fb 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
@@ -1688,4 +1688,108 @@ dss: dss@4a00000 {
 		dss_ports: ports {
 		};
 	};
+
+	main_r5fss0: r5fss@5c00000 {
+		compatible = "ti,j721s2-r5fss";
+		ti,cluster-mode = <1>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x5c00000 0x00 0x5c00000 0x20000>,
+			 <0x5d00000 0x00 0x5d00000 0x20000>;
+		power-domains = <&k3_pds 277 TI_SCI_PD_EXCLUSIVE>;
+
+		main_r5fss0_core0: r5f@5c00000 {
+			compatible = "ti,j721s2-r5f";
+			reg = <0x5c00000 0x00010000>,
+			      <0x5c10000 0x00010000>;
+			reg-names = "atcm", "btcm";
+			ti,sci = <&sms>;
+			ti,sci-dev-id = <279>;
+			ti,sci-proc-ids = <0x06 0xff>;
+			resets = <&k3_reset 279 1>;
+			firmware-name = "j721s2-main-r5f0_0-fw";
+			ti,atcm-enable = <1>;
+			ti,btcm-enable = <1>;
+			ti,loczrama = <1>;
+		};
+
+		main_r5fss0_core1: r5f@5d00000 {
+			compatible = "ti,j721s2-r5f";
+			reg = <0x5d00000 0x00010000>,
+			      <0x5d10000 0x00010000>;
+			reg-names = "atcm", "btcm";
+			ti,sci = <&sms>;
+			ti,sci-dev-id = <280>;
+			ti,sci-proc-ids = <0x07 0xff>;
+			resets = <&k3_reset 280 1>;
+			firmware-name = "j721s2-main-r5f0_1-fw";
+			ti,atcm-enable = <1>;
+			ti,btcm-enable = <1>;
+			ti,loczrama = <1>;
+		};
+	};
+
+	main_r5fss1: r5fss@5e00000 {
+		compatible = "ti,j721s2-r5fss";
+		ti,cluster-mode = <1>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x5e00000 0x00 0x5e00000 0x20000>,
+			 <0x5f00000 0x00 0x5f00000 0x20000>;
+		power-domains = <&k3_pds 278 TI_SCI_PD_EXCLUSIVE>;
+
+		main_r5fss1_core0: r5f@5e00000 {
+			compatible = "ti,j721s2-r5f";
+			reg = <0x5e00000 0x00010000>,
+			      <0x5e10000 0x00010000>;
+			reg-names = "atcm", "btcm";
+			ti,sci = <&sms>;
+			ti,sci-dev-id = <281>;
+			ti,sci-proc-ids = <0x08 0xff>;
+			resets = <&k3_reset 281 1>;
+			firmware-name = "j721s2-main-r5f1_0-fw";
+			ti,atcm-enable = <1>;
+			ti,btcm-enable = <1>;
+			ti,loczrama = <1>;
+		};
+
+		main_r5fss1_core1: r5f@5f00000 {
+			compatible = "ti,j721s2-r5f";
+			reg = <0x5f00000 0x00010000>,
+			      <0x5f10000 0x00010000>;
+			reg-names = "atcm", "btcm";
+			ti,sci = <&sms>;
+			ti,sci-dev-id = <282>;
+			ti,sci-proc-ids = <0x09 0xff>;
+			resets = <&k3_reset 282 1>;
+			firmware-name = "j721s2-main-r5f1_1-fw";
+			ti,atcm-enable = <1>;
+			ti,btcm-enable = <1>;
+			ti,loczrama = <1>;
+		};
+	};
+
+	c71_0: dsp@64800000 {
+		compatible = "ti,j721s2-c71-dsp";
+		reg = <0x00 0x64800000 0x00 0x00080000>,
+		      <0x00 0x64e00000 0x00 0x0000c000>;
+		reg-names = "l2sram", "l1dram";
+		ti,sci = <&sms>;
+		ti,sci-dev-id = <8>;
+		ti,sci-proc-ids = <0x30 0xff>;
+		resets = <&k3_reset 8 1>;
+		firmware-name = "j721s2-c71_0-fw";
+	};
+
+	c71_1: dsp@65800000 {
+		compatible = "ti,j721s2-c71-dsp";
+		reg = <0x00 0x65800000 0x00 0x00080000>,
+		      <0x00 0x65e00000 0x00 0x0000c000>;
+		reg-names = "l2sram", "l1dram";
+		ti,sci = <&sms>;
+		ti,sci-dev-id = <11>;
+		ti,sci-proc-ids = <0x31 0xff>;
+		resets = <&k3_reset 11 1>;
+		firmware-name = "j721s2-c71_1-fw";
+	};
 };
-- 
2.34.1

