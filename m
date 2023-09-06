Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8FD793B0E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 13:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbjIFLZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 07:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239512AbjIFLY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 07:24:57 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BAAA9;
        Wed,  6 Sep 2023 04:24:50 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 386BObXu118522;
        Wed, 6 Sep 2023 06:24:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1693999478;
        bh=iYfpbYWbsQUxthoFyroQPV6dxq8YgjjluKrOmBOfroA=;
        h=From:To:Subject:Date:In-Reply-To:References;
        b=SF5gQu+Kzr3Ppl9rqgp4XcdNc67087YlQGstCYm/fFNSXcl1KBrR8YzlDiOaAXztp
         d0aD2RNiygHF46KSj4g/WF221x2SZv0cx1cVGvtFWOe4VqWJE9TsTrb+aPVYyAGCsb
         QmX1MASGMQ/2s0cbtJ7a9It6wZcjdMsBpJCwdFlk=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 386BObC2108264
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 Sep 2023 06:24:37 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 6
 Sep 2023 06:24:37 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 6 Sep 2023 06:24:37 -0500
Received: from TI.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 386BON7s099810;
        Wed, 6 Sep 2023 06:24:34 -0500
From:   Apurva Nandan <a-nandan@ti.com>
To:     Apurva Nandan <a-nandan@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Hari Nagalla <hnagalla@ti.com>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH v4 3/9] arm64: dts: ti: k3-j721s2-main: Add C7x remote processsor nodes
Date:   Wed, 6 Sep 2023 16:54:16 +0530
Message-ID: <20230906112422.2846151-4-a-nandan@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230906112422.2846151-1-a-nandan@ti.com>
References: <20230906112422.2846151-1-a-nandan@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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
Reviewed-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
index a8e23b5c6fd5..303e9f124b02 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
@@ -1768,4 +1768,30 @@ main_r5fss1_core1: r5f@5f00000 {
 			ti,loczrama = <1>;
 		};
 	};
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
+		status = "disabled";
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
+		status = "disabled";
+	};
 };
-- 
2.34.1

