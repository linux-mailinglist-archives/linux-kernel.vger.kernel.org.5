Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16EB77B4914
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 20:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235292AbjJASOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 14:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235283AbjJASOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 14:14:40 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC48D9;
        Sun,  1 Oct 2023 11:14:37 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 391IEPiO030688;
        Sun, 1 Oct 2023 13:14:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1696184065;
        bh=IKeupgA5tvjWYyzOsDPKR2V51oGEo0c7E6VVbODIbh4=;
        h=From:To:Subject:Date:In-Reply-To:References;
        b=t2KRRbnKK2dSdgyitxAGNfKugV1GjI35m9eeHYA+LpiVmRcILQCDWi4Tafd75a6N6
         LmgfvVPkfhkIDxBdei7teLrrrvWKSbDdZFm62AQNehzE9ASG2kB/oaKXPa8xGZPWky
         a2F4tS14akAmBA2+QJ4x+ZqeB8q0lCoganhiFNv4=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 391IEP1w042030
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 1 Oct 2023 13:14:25 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 1
 Oct 2023 13:14:25 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 1 Oct 2023 13:14:25 -0500
Received: from TI.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 391IEHto063395;
        Sun, 1 Oct 2023 13:14:21 -0500
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
Subject: [PATCH v5 1/9] arm64: dts: ti: k3-j721s2-mcu: Add MCU R5F cluster nodes
Date:   Sun, 1 Oct 2023 23:44:09 +0530
Message-ID: <20231001181417.743306-2-a-nandan@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231001181417.743306-1-a-nandan@ti.com>
References: <20231001181417.743306-1-a-nandan@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The J721S2 SoCs have a dual-core Arm Cortex-R5F processor (R5FSS)
subsystems/cluster in MCU voltage domain. It can be configured at boot
time to be either run in a LockStep mode or in an Asymmetric Multi
Processing (AMP) fashion in Split-mode. These subsystems have 64 KB
each Tightly-Coupled Memory (TCM) internal memories for each core
split between two banks - ATCM and BTCM (further interleaved into
two banks). The TCMs of both Cores are combined in LockStep-mode to
provide a larger 128 KB of memory, but otherwise are functionally
similar to those on J721E SoCs.

Add the DT nodes for the MCU domain R5F cluster/subsystem, the two R5F
cores are added as child nodes to each of the R5F cluster nodes. The
clusters are configured to run in LockStep mode by default, with the
ATCMs enabled to allow the R5 cores to execute code from DDR with
boot-strapping code from ATCM. The inter-processor communication between
the main A72 cores and these processors is achieved through shared memory
and Mailboxes.

The following firmware names are used by default for these cores, and
can be overridden in a board dts file if desired:
  MCU R5FSS0 Core0: j721s2-mcu-r5f0_0-fw (both in LockStep and Split mode)
  MCU R5FSS0 Core1: j721s2-mcu-r5f0_1-fw (needed only in Split mode)

Signed-off-by: Hari Nagalla <hnagalla@ti.com>
Signed-off-by: Apurva Nandan <a-nandan@ti.com>
Reviewed-by: Andrew Davis <afd@ti.com>
---
 .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
index 2ddad9318554..56504578c464 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
@@ -655,4 +655,44 @@ wkup_vtm0: temperature-sensor@42040000 {
 		power-domains = <&k3_pds 154 TI_SCI_PD_SHARED>;
 		#thermal-sensor-cells = <1>;
 	};
+
+	mcu_r5fss0: r5fss@41000000 {
+		compatible = "ti,j721s2-r5fss";
+		ti,cluster-mode = <1>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x41000000 0x00 0x41000000 0x20000>,
+			 <0x41400000 0x00 0x41400000 0x20000>;
+		power-domains = <&k3_pds 283 TI_SCI_PD_EXCLUSIVE>;
+
+		mcu_r5fss0_core0: r5f@41000000 {
+			compatible = "ti,j721s2-r5f";
+			reg = <0x41000000 0x00010000>,
+			      <0x41010000 0x00010000>;
+			reg-names = "atcm", "btcm";
+			ti,sci = <&sms>;
+			ti,sci-dev-id = <284>;
+			ti,sci-proc-ids = <0x01 0xff>;
+			resets = <&k3_reset 284 1>;
+			firmware-name = "j721s2-mcu-r5f0_0-fw";
+			ti,atcm-enable = <1>;
+			ti,btcm-enable = <1>;
+			ti,loczrama = <1>;
+		};
+
+		mcu_r5fss0_core1: r5f@41400000 {
+			compatible = "ti,j721s2-r5f";
+			reg = <0x41400000 0x00010000>,
+			      <0x41410000 0x00010000>;
+			reg-names = "atcm", "btcm";
+			ti,sci = <&sms>;
+			ti,sci-dev-id = <285>;
+			ti,sci-proc-ids = <0x02 0xff>;
+			resets = <&k3_reset 285 1>;
+			firmware-name = "j721s2-mcu-r5f0_1-fw";
+			ti,atcm-enable = <1>;
+			ti,btcm-enable = <1>;
+			ti,loczrama = <1>;
+		};
+	};
 };
-- 
2.34.1

