Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00DD87BCE1D
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 13:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344716AbjJHLRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 07:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344717AbjJHLRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 07:17:02 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2027.outbound.protection.outlook.com [40.92.19.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE4010F;
        Sun,  8 Oct 2023 04:16:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OwlRX53DmE8UyF3bXZReqNdMXbu5I2KDF5aoE622rzUKoSTzpvdj1XjuZWHpUO29lnHUBHiynxDySMpLvgGas4fbB943LC3t7thfUqt8LmK+yKCzw3j7JHp2+0vBxUgqeuxEaCZjjMXsW72YILLe2lU04R9FmPmx3FdN2Bv/K/laaAURLTfU0+xlQJQISgH6+8Zu0fsrhk/mSoWEDVtIZqMkXo25DsqAVc+OSm5mr6trc2p8iho8taG9kXeWe08/HflaZ2D0JlN8LUbHlMnMMir7Zl7KLS9pyCKOv3HzjcSn5fqqYDFirQggOCbTkqBFSXoD6qDJONF/lg6uhPwn0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IHOK6Y8z58Se4VB4gJL+hdcLlDPn5ohwYbS4+7SMtuk=;
 b=EJASZAypYeLVrWOeZBAMuoslvK5YhN7PGXrcdEHY8PuvpDa+XP94D/N0//0Q9E9r06FZH/7M3/bA+LViPP/ZMJ5O++dDLy+fV5dWO2IcTXJ+21FcV2PXwevC0bYi5Xwqrg9AmVUGhZIcf+I0BsZn+A1WCDa+DByci/q2FFgBd0doCJ9auHLkDuPyQ4gXYWPnUwyxbqngQ2thWEBB7QnQK7xD+BGEmiT80W7qr/Iu94LYbpb1+YdgKlYQOkdYxmW+NLigNw6kZjLCmmy7Dyvdau1N29n3achLoySCpjqRsOvLl6Gtrn4j3/ABz3mQP1tm8CSgZvmg3gZ8VQsazoyyNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHOK6Y8z58Se4VB4gJL+hdcLlDPn5ohwYbS4+7SMtuk=;
 b=oGS5qnXlIuAIagzOY4rBI0Eh+gQJKQE7C4yQWNO2GAu3mgCa5JOdZPVDBCKMvAcHaJwfs9GR0y2stUeq326Ill1RtmF4VuuX8Gt4cGDuDxjMGEu2L6kC3kC52hOWjeQWpzyjPLDgsXQF9YjWcULsjk8RkHbE0Q9f8hi1dqL/3Zud6u17auLr5Rr912+x2CEQkuuI9NNGW4iVyxQMHoCi4XaTGjmRSmgdjEtH/UMN79rEbAt4oH7TU5yLHcPX54L7VxefQD+s3GfZnWWwADdBD6P1N1oV8aB4yOHyVCxHd4PQ5KHpSbQrVcd1YToTKD3LhkRr+yZQJcUhMOeaFa0CVg==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH7PR20MB6969.namprd20.prod.outlook.com (2603:10b6:510:2fc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Sun, 8 Oct
 2023 11:16:56 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263%5]) with mapi id 15.20.6838.040; Sun, 8 Oct 2023
 11:16:56 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Chao Wei <chao.wei@sophgo.com>,
        Chen Wang <unicorn_wang@outlook.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Inochi Amaoto <inochiama@outlook.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] riscv: dts: sophgo: add initial CV1812H SoC device tree
Date:   Sun,  8 Oct 2023 19:16:22 +0800
Message-ID: <IA1PR20MB495360B632D106BBB833D82ABBCFA@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231008111627.325468-1-inochiama@outlook.com>
References: <IA1PR20MB495337659E69ADA1A8B1596BBBCFA@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20231008111627.325468-1-inochiama@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [W5sF2P5/QSqMHp8JjAEFfPP7Q/NHkEYzB2zPOOk3+K0=]
X-ClientProxiedBy: TY2PR02CA0060.apcprd02.prod.outlook.com
 (2603:1096:404:e2::24) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231008111627.325468-4-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH7PR20MB6969:EE_
X-MS-Office365-Filtering-Correlation-Id: aa70241c-d7e0-4061-b59a-08dbc7f0143a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aAY0CFI6TSGQXCpAvPcHCDfSc5AYd2UMzanmVKucSm/jKKt5UPYg/xUMOg/6uVuKRKy0kl6NKxqAoYiLvV5PurBmZO0LvINtgc2/XTNoRNYx3fdChQ9T6THhny2Hq4w16o7/2k9DeGaDWPbX7BhGC9zqtiu/N70MJdI2JkNX08T28YXGhSldwHQ7MiIUcIDWhuHl6XFmwwJhVu5yMbtsMn7TwxIUBL0WCv2Se33C9l1TZxMi8uBFd1pmXLTJomtsa/e+fzTI0cuvnPJb2pvcIQbZ6jf3LCkDKpznMgAhCzFJlOw1njYwpykehroITx7qWgl1w9mXWtirP5eWmdvQpkUSFm32nNWQ8+uCp/RsH3k3gJXnBHj7n7dTOcAuRZyiOgjDo+FdBtDH7ai5uRpREsQGZE9iTDP8+mnjCU/Yq/8z6WZib9MMgOAyWbGnlPWXKQ0rcNqNvNPxvXSNrZDUTop0JBCLasSYVqLaHK/NZN5mkF8oLvWBD4QT6z0ZC05oELvp9EtbPorunz/r9b9QdKVr7mJbBut4QuyqdjVJMbPqjF1PDRNLxqmouRi4nu5w30TDRDBiz6deKPidLoUvCPI+tRXVW/iKyqNwSdpIYOSYLIpYYDSlXHTAXuWRYN+N
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5c3bZD+ToancgZF6RCq7rqXN5WZ48KTgWJnGqjg/oj3jqhu+fvP/eg1Ci6ER?=
 =?us-ascii?Q?PuT4TGo6qq0JQosNcAqFJizfVwpYFEY8BOcdeDsA4ooeWWP+zI5jrVVlWnoE?=
 =?us-ascii?Q?XwKP1TtIiIMq7BvOzNZ7M5+WF6L91OEtq8sydaLHRlo4x+MFTeF7abYZ4OXc?=
 =?us-ascii?Q?9qRX2FxJ4kMx+uY0uyohJ5J81Xlorq6L/oJWdhWGBSK8gB5o+pXt+XQewWrP?=
 =?us-ascii?Q?nyV4NryJnIgQFXky7cfjws2CTbd0Tba7C//rOaxZSUc+kQAXTH2D3kKX9W3O?=
 =?us-ascii?Q?Ve76XczYYbILpzyTADnycxqXUTXTpcqql2fociwwR+ZUdiR/HfGPvc6u1WjG?=
 =?us-ascii?Q?7s8fxOLA846aJMn1nJ2TfWdixZYFfFHi4lEp8UqBnLprnbY3/ChrMiokpFsM?=
 =?us-ascii?Q?b0GNKPMMtgn/kE7KPF3DMS1wJqziQGXKW4MY3IrSFmUJhLIQHHhX3pwPPL5/?=
 =?us-ascii?Q?yxDqYqVO4wmSaQrVcx3DdKfx2XLgOlglr5CUVAl0DDkClT+sI3b8xn4bjFF3?=
 =?us-ascii?Q?kZT0zSrJTOsZbjgpRc3AeOmUIh/gJGFrYNsQgsYB/L2rJojrp2Awt1UNI6Ti?=
 =?us-ascii?Q?0rOLk/6tK+PjZIpRPv+x6pW0ue7NPbclKPCbio5C10PUxYmbJIcBNGm9zqt9?=
 =?us-ascii?Q?DFe/K2UrrqX9jBYLVfU2ajVKnvX/+UczjFumZJvjPsWAR+s5YwmkKgvSnHcs?=
 =?us-ascii?Q?BuofQrVsortYkg3ge9FuDtymhxbJiODf2l76l4fxh+j25n+A4yzU8yN+0PYh?=
 =?us-ascii?Q?5ckjg48Ma+XOX8IemioogvIaAXALUQXS7zCDQNw1miLd4Xu+O4jFE/MMw/ae?=
 =?us-ascii?Q?SlBLdxJ/mKqhfR63DM79IqY8MINrCDkVt0jTURYj3/Fe/IV222Ap2WqHL3fs?=
 =?us-ascii?Q?t3IFy8nxs8SkJDUrSBNO5Iu4E68UZpqzzF2tn79u/vCIZFFi1xwOeXFCeaZg?=
 =?us-ascii?Q?YyTj+iHDM+8z8wl0/XtaPTjbtvTQyxeF0oDXmJkzfO5Gq0/t/DpU1RD87UzS?=
 =?us-ascii?Q?p2ZJ4Ok7DcJdjJj71s4eW2ixqbxw3hhdilnnt86daDvO8n/JdjhOKhz55FdV?=
 =?us-ascii?Q?N3BzwFZSv+uDk+u60irCobJ3fka7zJ0P9UNjnWgjnDkN1T7wYXtEqQIs6kXt?=
 =?us-ascii?Q?R6ZjeWn3eXKtffkQdNt0U4mHyHnveuP6xlwmwxD90i4a/Icn4P5qpiVU0tk3?=
 =?us-ascii?Q?ZTns7boO7WZtkgohYBFd0t3hHOIcKlENFJdoR5EYGWDIG5RaqJvUIhoprTs?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa70241c-d7e0-4061-b59a-08dbc7f0143a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2023 11:16:56.0766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR20MB6969
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial device tree for the CV1812H RISC-V SoC by SOPHGO.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
 arch/riscv/boot/dts/sophgo/cv1800b.dtsi |  95 +------------
 arch/riscv/boot/dts/sophgo/cv180x.dtsi  | 178 ++++++++++++++++++++++++
 arch/riscv/boot/dts/sophgo/cv1812h.dtsi |  36 +++++
 3 files changed, 215 insertions(+), 94 deletions(-)
 create mode 100644 arch/riscv/boot/dts/sophgo/cv180x.dtsi
 create mode 100644 arch/riscv/boot/dts/sophgo/cv1812h.dtsi

diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
index df40e87ee063..0904154f9829 100644
--- a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
@@ -3,106 +3,13 @@
  * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
  */

-#include <dt-bindings/interrupt-controller/irq.h>
+#include "cv180x.dtsi"

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

 	soc {
-		compatible = "simple-bus";
 		interrupt-parent = <&plic>;
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

 		plic: interrupt-controller@70000000 {
 			compatible = "sophgo,cv1800b-plic", "thead,c900-plic";
diff --git a/arch/riscv/boot/dts/sophgo/cv180x.dtsi b/arch/riscv/boot/dts/sophgo/cv180x.dtsi
new file mode 100644
index 000000000000..64ffb23d3626
--- /dev/null
+++ b/arch/riscv/boot/dts/sophgo/cv180x.dtsi
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
+ * Copyright (C) 2023 Inochi Amaoto <inochiama@outlook.com>
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
+		#address-cells = <1>;
+		#size-cells = <1>;
+		dma-noncoherent;
+		ranges;
+
+		gpio0: gpio@3020000 {
+			compatible = "snps,dw-apb-gpio";
+			reg = <0x3020000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			porta: gpio-controller@0 {
+				compatible = "snps,dw-apb-gpio-port";
+				gpio-controller;
+				#gpio-cells = <2>;
+				ngpios = <32>;
+				reg = <0>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <60 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
+		gpio1: gpio@3021000 {
+			compatible = "snps,dw-apb-gpio";
+			reg = <0x3021000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			portb: gpio-controller@0 {
+				compatible = "snps,dw-apb-gpio-port";
+				gpio-controller;
+				#gpio-cells = <2>;
+				ngpios = <32>;
+				reg = <0>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <61 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
+		gpio2: gpio@3022000 {
+			compatible = "snps,dw-apb-gpio";
+			reg = <0x3022000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			portc: gpio-controller@0 {
+				compatible = "snps,dw-apb-gpio-port";
+				gpio-controller;
+				#gpio-cells = <2>;
+				ngpios = <32>;
+				reg = <0>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <62 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
+		gpio3: gpio@3023000 {
+			compatible = "snps,dw-apb-gpio";
+			reg = <0x3023000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			portd: gpio-controller@0 {
+				compatible = "snps,dw-apb-gpio-port";
+				gpio-controller;
+				#gpio-cells = <2>;
+				ngpios = <32>;
+				reg = <0>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <63 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
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
+	};
+};
diff --git a/arch/riscv/boot/dts/sophgo/cv1812h.dtsi b/arch/riscv/boot/dts/sophgo/cv1812h.dtsi
new file mode 100644
index 000000000000..3864d34b0100
--- /dev/null
+++ b/arch/riscv/boot/dts/sophgo/cv1812h.dtsi
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2023 Inochi Amaoto <inochiama@outlook.com>
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include "cv180x.dtsi"
+
+/ {
+	compatible = "sophgo,cv1812h";
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x10000000>;
+	};
+
+	soc {
+		interrupt-parent = <&plic>;
+
+		plic: interrupt-controller@70000000 {
+			compatible = "sophgo,cv1812h-plic", "thead,c900-plic";
+			reg = <0x70000000 0x4000000>;
+			interrupts-extended = <&cpu0_intc 11>, <&cpu0_intc 9>;
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			riscv,ndev = <101>;
+		};
+
+		clint: timer@74000000 {
+			compatible = "sophgo,cv1812h-clint", "thead,c900-clint";
+			reg = <0x74000000 0x10000>;
+			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>;
+		};
+	};
+};
--
2.42.0

