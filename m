Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00827CEBDB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 01:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbjJRXUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 19:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbjJRXU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 19:20:29 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02olkn2103.outbound.protection.outlook.com [40.92.15.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8105D68;
        Wed, 18 Oct 2023 16:19:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PSu7biGIQ12z6UZ5ktxJ1MywvbwTPirUet9S0n89ZSiWT3mrhf+yXNjBAlSCne9bl+lGZ2sLJSzNnaBD6VtINQzwIuuQ/sT4nZoMcAibwkGWVHgrdv+ffO5P17LHXnwzdA9+sOTWiZA41gs2I7g3HcYsRZ+zEI1QHgSRd6MKZjP9BkBzYOFLuQkQVkdGZhtatm34i9/UU+vDjDVCMgFuw3WF3sH6ajJyAgNhz+FdmRDFOedAQxVzcM2OjKfu/VL8KMEpemAugdUsQ/J+FrwZWoLe8t24sM8pbCrJTM44vp05z7BDbLSxHMGqxlKsc0PvlEe7+8vnivo5dr3Gi7xyxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ndkk0zNLuRzhXI9J7ATcjm1Eti7mSm6Qk3vViwryehk=;
 b=W1OZCV0Gy7JI3/Nqw/wpT0x99ToRnPrk5+W6P2vr2/ZwLqS75nGKPQu4dyZamqD7pFu6FAwqoVitOont7tYdFy+ibxudBunOJLsvbBXQK0+cdd0GCpkq7fIsjy7nSXuvh9kfzACk3FymFmBBvK6Zf4fG3nobLjdLkyQMUFUDpWoaAMM5cOyBUP3yKNXVhQck8KCXpm9rX55bDeASPSvMn0XeHoYfL7lSN4xZBSEVCVCtO07agjDNttClBrUcKD9HCpodDE0nQwGT18dyvxvitweJvzC7983HDK162D3PprCyDR6uhirfaveYQQPvb21sle6xg6ETURtWK9mPQ/lo+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ndkk0zNLuRzhXI9J7ATcjm1Eti7mSm6Qk3vViwryehk=;
 b=kxQMq33oKkwjaSctSpBesOmrKab+o6ldTVC4X6YHjuQH2LKvjAhpOJC4H+EigCzahe7t9clhOIEtAmlSOoDxc1zVx3uAPQ/hzW3tihspx8KPyiGOZy0xTCZ+usAtH3VNoUZrGhmxdn3Bc2cVAjSqcJg19JrFi0QnxBcuJQx4xVch7TlrHhuOlLUSpD7fP+YwXHrAnkw32Us8VIzkXSPMT7wqcQhraAabYT+14GEk9s9lD2w2R1uGYf4sqbfCKolUMM9K0jqneBRmIejMWGwIGXNyopw/bmIwW/IWpyMNfHxfT3IDW8DCFFItnalMwb1ZIRhrsZyUj2oz9rOH6q3PbA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by DM4PR20MB5087.namprd20.prod.outlook.com (2603:10b6:8:8d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.37; Wed, 18 Oct
 2023 23:18:54 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263%5]) with mapi id 15.20.6907.021; Wed, 18 Oct 2023
 23:18:54 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Chao Wei <chao.wei@sophgo.com>,
        Chen Wang <unicorn_wang@outlook.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Inochi Amaoto <inochiama@outlook.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/7] riscv: dts: sophgo: Separate compatible specific for CV1800B soc
Date:   Thu, 19 Oct 2023 07:18:51 +0800
Message-ID: <IA1PR20MB4953C128FDDE7A2249669213BBD5A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <IA1PR20MB495399CAF2EEECC206ADA7ABBBD5A@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB495399CAF2EEECC206ADA7ABBBD5A@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [3uzAu3jYS2COcaHVvtN6QcvsWi+5/1Lfo1W8zkEPw4c=]
X-ClientProxiedBy: BYAPR07CA0084.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::25) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231018231855.28472-4-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|DM4PR20MB5087:EE_
X-MS-Office365-Filtering-Correlation-Id: e38dc7f4-3002-43d4-4028-08dbd03098d0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fJAaQEmJ1w1d/l4zeir1rsf9+j2jLycIEbsZRn1aMq7GEbE8+LFevMor4gUuuLzhAYn0tkeyNziHSAT2ueFvi2UuEQuE+sQv0WFjgZB1pT8JhkkQWweQBzRhiMrAz5n5kA9YM9rW8oxX1LaJzAB6qySf0RRk0h06MbznKKDIDCZq5fhVSOnHyWOePDjqywIySDxJT1nOdwxpQ+LpxB4HCpbMWlUfxclWV7gF/LNKXESMNZbtvbfHUPjNIHg+Z3Y42czrUJ3is29Z/egDZweEjcyv3pRM02BI5JLN997MottggLJWI+dRzqhkkMUMLrC37M920fZQnaJwkROmQpP0K9BoFNONoarC+tmo0DKWEFm0LaEbkhBoBBYehuqroCS14dPQATu7gB0pMmGEBt88avLZo/l2kN56odqaPHJXVLGzDRCy23O2JRE5vcugHkSwY0HEiqxNwEsQzweygetSRyabsAdMl6YmewyNyEaNUl83hZ5akRjebK7zf65mpgrapxkRsPJGHuONxdAUDq3EHTWLGcygOwBByVNQ6+dlnA8jJZMLcz/TVm01vxELu9utRdphrGd6OsWyZZMzL6WHavRbb8LHZYCEjbZltPU3JQm6H5pltz8Bp6sKJNxj2owG
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZGzpKBZqtJTjeHOLEBFv3mI5El1i9crWaleCFVXK2HPCmry3mQy8UViCauY6?=
 =?us-ascii?Q?ECWnBLvZT1TAfduVNxI5iTFxeFPWGViO8vimsbJRu9+/jjjFKqycT+pkNrV4?=
 =?us-ascii?Q?F7/b/osS1UjeDELeRYZowlNS2V+i5OCHz/9il539UmuhXhvhT35fajl0e2ET?=
 =?us-ascii?Q?DYDJTk+B3th0e2eJ1oWcjvrJuiqmJ63rI11cCMaEwUWpTuFo4iDpP620P1y5?=
 =?us-ascii?Q?mIUQtcRxxVLhLnZCHJ+vtQZo7+5zD+0VwytwyOvI3n7i1az3ZYQaaINSWBDe?=
 =?us-ascii?Q?N0hOSrwX0uwAWHPbijlX/uJLxiwSS0kZjnj7+KhUzWoubkKL4OPy4K6+vXTx?=
 =?us-ascii?Q?R3Vk2oMVWNSH1AtmeyP5Q985lyRezvw9RLNBJfROvbUAO+Otmd9OiOQLpVjx?=
 =?us-ascii?Q?IZir+7LOrdAG7VGsqVaJNPHJF9Bnw2C787khN6BqQyks9jPZ1JZqAVxMe2KL?=
 =?us-ascii?Q?+q8kO9y3o9PEKPlcx+P/hlks5fhFjVmQvJx49skCefcwXTbak61FAblFZPk+?=
 =?us-ascii?Q?1OnIOAPKbEMHakDVdni0zTMIHqPYP1K+Ell7iUQKwH3HNx8ZWoZkL2w3w0Xu?=
 =?us-ascii?Q?tGZhGBJqBmG1iwqsZ1ceB8jRvluy863JACxaWbunTx2V8uGjaVa8Qtv4L+Dt?=
 =?us-ascii?Q?zQzawaGfqzX+i22ym1/Hv+OHNi7YbTZmX5wP3KY1JVQlOW4TUXKOymkatVYo?=
 =?us-ascii?Q?7YSUJtAHpX5JYiVCXmQePlWSc9prDVHLy2wdi7nazU7mDh99Ai5iuEYjqpqG?=
 =?us-ascii?Q?VKryvVFEsgqjnbBFgHlm13+O2HXrxvqHMaOicAobEZsXsPcnOOOwDpJl5Ewq?=
 =?us-ascii?Q?Tii3jPBIjdKUhxK7r593hlb76gMnqc8Kp8fimWOgjOFvgGnpDYoTaFVbsD/m?=
 =?us-ascii?Q?IL0aI9uc3Dd8Q/HyozebSwxkJI6qZNT2KTQoSKmDbyqAsfKSSwsHlUQ67Vnr?=
 =?us-ascii?Q?p7WEuLrVCwKzj5JRFGvDccAJ7Z5OrE/derLhybYdC7HnnKWviEQNhWp3mopM?=
 =?us-ascii?Q?IFO0ghheWNtpY7N2KBE6tTOuLk8JTQ2rC26YNxOBgErOyI3aCHZ/L4T0z7bq?=
 =?us-ascii?Q?Y5VBSec7NCYOqVArO1NNSli9unOqgAaJQxYXZ8StliUZ5jCeU9ad6AYD2w7V?=
 =?us-ascii?Q?mLDV3/UQLvLNF8vmY7/8KJLfrtHYBPL0GvxSuTcn/LukwmoTB0spdNBSrPUd?=
 =?us-ascii?Q?67ewvmIq82DeavN2a2HKMvfCP3wG0ftFuPIkSEqkZCgN5bAlIyZ/lnIagdk?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e38dc7f4-3002-43d4-4028-08dbd03098d0
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 23:18:54.5918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR20MB5087
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As CV180x and CV181x have the identical layouts, it is OK to use the
cv1800b basic device tree for the whole series.
For CV1800B soc specific compatible, just move them out of the common
file.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
 arch/riscv/boot/dts/sophgo/cv1800b.dtsi | 119 ++---------------------
 arch/riscv/boot/dts/sophgo/cv18xx.dtsi  | 120 ++++++++++++++++++++++++
 2 files changed, 127 insertions(+), 112 deletions(-)
 create mode 100644 arch/riscv/boot/dts/sophgo/cv18xx.dtsi

diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
index df40e87ee063..165e9e320a8c 100644
--- a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
@@ -3,121 +3,16 @@
  * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
  */

-#include <dt-bindings/interrupt-controller/irq.h>
+#include "cv18xx.dtsi"

 / {
 	compatible = "sophgo,cv1800b";
-	#address-cells = <1>;
-	#size-cells = <1>;
-
-	cpus: cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		timebase-frequency = <25000000>;
-
-		cpu0: cpu@0 {
-			compatible = "thead,c906", "riscv";
-			device_type = "cpu";
-			reg = <0>;
-			d-cache-block-size = <64>;
-			d-cache-sets = <512>;
-			d-cache-size = <65536>;
-			i-cache-block-size = <64>;
-			i-cache-sets = <128>;
-			i-cache-size = <32768>;
-			mmu-type = "riscv,sv39";
-			riscv,isa = "rv64imafdc";
-			riscv,isa-base = "rv64i";
-			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "zicntr", "zicsr",
-					       "zifencei", "zihpm";
-
-			cpu0_intc: interrupt-controller {
-				compatible = "riscv,cpu-intc";
-				interrupt-controller;
-				#address-cells = <0>;
-				#interrupt-cells = <1>;
-			};
-		};
-	};
-
-	osc: oscillator {
-		compatible = "fixed-clock";
-		clock-output-names = "osc_25m";
-		#clock-cells = <0>;
-	};
-
-	soc {
-		compatible = "simple-bus";
-		interrupt-parent = <&plic>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		dma-noncoherent;
-		ranges;
-
-		uart0: serial@4140000 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0x04140000 0x100>;
-			interrupts = <44 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&osc>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			status = "disabled";
-		};
-
-		uart1: serial@4150000 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0x04150000 0x100>;
-			interrupts = <45 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&osc>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			status = "disabled";
-		};
-
-		uart2: serial@4160000 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0x04160000 0x100>;
-			interrupts = <46 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&osc>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			status = "disabled";
-		};
-
-		uart3: serial@4170000 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0x04170000 0x100>;
-			interrupts = <47 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&osc>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			status = "disabled";
-		};
-
-		uart4: serial@41c0000 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0x041c0000 0x100>;
-			interrupts = <48 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&osc>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			status = "disabled";
-		};
+};

-		plic: interrupt-controller@70000000 {
-			compatible = "sophgo,cv1800b-plic", "thead,c900-plic";
-			reg = <0x70000000 0x4000000>;
-			interrupts-extended = <&cpu0_intc 11>, <&cpu0_intc 9>;
-			interrupt-controller;
-			#address-cells = <0>;
-			#interrupt-cells = <2>;
-			riscv,ndev = <101>;
-		};
+&plic {
+	compatible = "sophgo,cv1800b-plic", "thead,c900-plic";
+};

-		clint: timer@74000000 {
-			compatible = "sophgo,cv1800b-clint", "thead,c900-clint";
-			reg = <0x74000000 0x10000>;
-			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>;
-		};
-	};
+&clint {
+	compatible = "sophgo,cv1800b-clint", "thead,c900-clint";
 };
diff --git a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
new file mode 100644
index 000000000000..55d4bc84faa0
--- /dev/null
+++ b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus: cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		timebase-frequency = <25000000>;
+
+		cpu0: cpu@0 {
+			compatible = "thead,c906", "riscv";
+			device_type = "cpu";
+			reg = <0>;
+			d-cache-block-size = <64>;
+			d-cache-sets = <512>;
+			d-cache-size = <65536>;
+			i-cache-block-size = <64>;
+			i-cache-sets = <128>;
+			i-cache-size = <32768>;
+			mmu-type = "riscv,sv39";
+			riscv,isa = "rv64imafdc";
+			riscv,isa-base = "rv64i";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "zicntr", "zicsr",
+					       "zifencei", "zihpm";
+
+			cpu0_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+				#address-cells = <0>;
+				#interrupt-cells = <1>;
+			};
+		};
+	};
+
+	osc: oscillator {
+		compatible = "fixed-clock";
+		clock-output-names = "osc_25m";
+		#clock-cells = <0>;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		interrupt-parent = <&plic>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		dma-noncoherent;
+		ranges;
+
+		uart0: serial@4140000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x04140000 0x100>;
+			interrupts = <44 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&osc>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		uart1: serial@4150000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x04150000 0x100>;
+			interrupts = <45 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&osc>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		uart2: serial@4160000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x04160000 0x100>;
+			interrupts = <46 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&osc>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		uart3: serial@4170000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x04170000 0x100>;
+			interrupts = <47 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&osc>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		uart4: serial@41c0000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x041c0000 0x100>;
+			interrupts = <48 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&osc>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		plic: interrupt-controller@70000000 {
+			reg = <0x70000000 0x4000000>;
+			interrupts-extended = <&cpu0_intc 11>, <&cpu0_intc 9>;
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			riscv,ndev = <101>;
+		};
+
+		clint: timer@74000000 {
+			reg = <0x74000000 0x10000>;
+			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>;
+		};
+	};
+};
--
2.42.0

