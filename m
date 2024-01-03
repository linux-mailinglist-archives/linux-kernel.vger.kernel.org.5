Return-Path: <linux-kernel+bounces-15446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE2E822C19
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05B70B22B71
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C722B1947D;
	Wed,  3 Jan 2024 11:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="Z17oWNrR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2082.outbound.protection.outlook.com [40.107.21.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5E21944B;
	Wed,  3 Jan 2024 11:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E+Z09DMBeT3WMABPJaWmOkzK7lqW17R3Rx8TJ9T/w37yp50B0GyxEPiEMKmoyK5008F2O+l9YH7cYoWHDEH51tTi4ElVjODJpQdA23lu+ElwA7tPqp2IEjn/pzkUyrAE/H+7R7udjnwcH4hj8JCivonuau1pjOwwmBk70LhV+6Ie7wNQguo413aFHEC7C3HKjXEb3KY4PRG7n1cniqjSSiKuld1VQOnju7oWomLLmPGzJqudYYYfkaDT8L9PUoDK/L0kQcM/AOQZw3J+Wsz3MiLlK3xeoN0gVZv+QUsFWiU+/DsnNTn5WwAL7DNpIAElL+FFNfVh5h/wZ+btrc4fJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2tUMe/qVtRJndtosiXQ0Vl6Z4n0LNC/O18yMoBKt++I=;
 b=JbnQqjjnM72fywIGpH2Ph4gXNtQFe+9K7SKSPFoFAnP7PQIbtmoGiyKChJZ5kpN29LHsl36kzVOMPplFVKTXrGM/yZTvZJTeEctH6eobkUnPehiZ4Pklqeylso2Fs4o7ZEJQDkxhNBtWua6dGHoLjfQ9mhwoi1Yg2JIT1TL3yH4zf/71CzNeuFU4D5OYEULLsy+slTkqLdxr3LakGsK4V1WaUWDi210iLDNB9qmOQc9CTHwxe7MeeQ0GnKawlIvycmmZbdkE/jh9niMCbDVvNgPikXoj+ODsfb+8vgfyLCBgD00GTxDxZVpnXAs3QpvtAtGzqoxAHzgWun4oYmjsGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2tUMe/qVtRJndtosiXQ0Vl6Z4n0LNC/O18yMoBKt++I=;
 b=Z17oWNrRvRfxvfVPz3PaWw33rDYhRuKFWRyZ4+kyH4ROhhN1mEJNONXZSQAd7A2c/0Zhh7cWbUUeYxLfZxTNjJeeoz8Z/n2e05EomXGP4hHYK1+3Agd8DM7EVGJnf3ANMjMOBgZspjvcA1kstJ6z82R2cQrfwm7erA8z0+PgEgU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by GV1PR04MB9136.eurprd04.prod.outlook.com (2603:10a6:150:27::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Wed, 3 Jan
 2024 11:27:20 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::4db1:aae8:c643:2e73]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::4db1:aae8:c643:2e73%6]) with mapi id 15.20.7135.023; Wed, 3 Jan 2024
 11:27:20 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Wed, 03 Jan 2024 12:27:13 +0100
Subject: [PATCH 3/5] arm64: dts: ti: hummingboard-t: add descriptions for
 m.2 pci-e and usb-3
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240103-add-am64-som-v1-3-dda1f9227aef@solid-run.com>
References: <20240103-add-am64-som-v1-0-dda1f9227aef@solid-run.com>
In-Reply-To: <20240103-add-am64-som-v1-0-dda1f9227aef@solid-run.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR0P281CA0232.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::16) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|GV1PR04MB9136:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f4eeace-8f56-4992-0b3c-08dc0c4ef302
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	F1Jn1n9oFXMaHLJgRxd3Ss6OELv74Dh6LaILMNuo+7yx0/Z1QWmA1cDRAHGtjxpZS0Za3/OCMWgurzzb0Ub64Xka3j5N0d+8nT0LZtxeKvGDjS3ZvrqRazE0erVR2F2XewrAuZG7Etmh3UnBLugvxGyigEd2FFhjKBNaNT8GJeN/DipdDlke1Jkkl2mXomfkwBkoClJv8CldtquuTTLT/jCIGj5+JOKdT06jCfHQ5zxZTmtm8m7k1y+33L0w/aO7zrQz5pVKegb5RNlOUbuFHK+yhSP3VH3hrtfgLhEQU8qxbsaURHhPvVNwelZMumJPK63W4TPW3X1gDi2rUd9Zn85bJ3CXL9i9y2gOBV/KfgMplUMgTsxtRfjX5CcAZdVrXKUdVnZ0uUdhE2O1YzGqf1xkLKkN9GeAzPy9ol3dio+oS/TZYMk5gBfhQj25zGiVvAliJYc98hJ+8qHdWsj+yNZEnUi9dT0AsEQF34z899BQartpT8f3boKfC+zUh4G7w7/78zNdmJ6bAkczcP6IEvrolzkfw8UfeOVPqz/F5TZb1xfwxgh6/HnWyI13i8fQbfukJpA4Pn1CR/Aqn+Q9YjuygkQWRpjkZNwr8EiVlTHGQ5vUEcYAnpPjkWC61BLa
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(376002)(136003)(39840400004)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(2906002)(5660300002)(6486002)(38100700002)(26005)(107886003)(478600001)(2616005)(41300700001)(36756003)(86362001)(52116002)(66556008)(110136005)(38350700005)(316002)(66946007)(6506007)(6512007)(66476007)(8936002)(4326008)(6666004)(8676002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVk0R1NyTWhnbC9GNUJHaDRoS2ROM1lacG1NUEtxRkVqVjNtekpKZjlldVhM?=
 =?utf-8?B?UUMwNzAzaVNpZzNtRE80VEJIYXhoTWNjWjRuRVhQU0tXK05WZE15ckdIY25x?=
 =?utf-8?B?U1dJVjRVQXVrcTIvb3ZNY3VGcFM3UmZ1OGl5b3YySGNzM2FTa2dVS2xwT0to?=
 =?utf-8?B?N0xpd29FSzJvcmc3ankvTU1TK2dBaXc3KzlGSHVXbkhvWjZGU0p0R2lIZ3Vl?=
 =?utf-8?B?UU52L3o3RUhacEtBd2JBY2QveG9hVGhiQnMvaEdEazVSSVMwOEpJVHdYNUt2?=
 =?utf-8?B?RGRlOWtROC8yZlpTckFTdUs1L0hPN1ZJQ3c1ZytSL3pFYmluWklzbW9OV3dK?=
 =?utf-8?B?UzFCdHYvMStXbG9oYjlTVGZMZDBDMlIxZ2EvdENLMGFhV01VZmdSdE5sZ0g3?=
 =?utf-8?B?Q0pGRkxORUhnSFVPZnFIUlIwQk0yZys1Zm9CTXFVbHlUTCtINWxyaW9tTmJ1?=
 =?utf-8?B?eTAyaElQUWRGU001Z2VhQmlBWXYzTkxZbEw2QzJjR0tjR3BmT1hKR2tibTNL?=
 =?utf-8?B?aEVyNDVBNzJ6TXFOTHM3OG92S1EyZmYraktLSzIvNHd6bEF4ZmlPTVRBUk1j?=
 =?utf-8?B?WXZMbFRpQ09wcUVxRVNLbkhIa3ZndzFkbU1wbUJYMG1reXBsRTBrRTFTaENF?=
 =?utf-8?B?RTlXNWpKMyt2MFN6R2szSDhObU0rdnFYR05pTE9iK01JTnRXRnJmK2QvSGZR?=
 =?utf-8?B?Vi9RcVo5My9waVhEVUQwREZ2c0FDR21nYysyUW1EcFVVUEd2NFIzaHdXNlFD?=
 =?utf-8?B?bTVZU0UydDZDYldxcm9uNEhlWXpnQXE3eWNQZGhDbnJWSEp3UnlRdEk5dWNM?=
 =?utf-8?B?eVJOckRiejlXaS91bUc3TTAxeXhxaUh6L0kreC9QUEhIendXSlZ2N3VtRldN?=
 =?utf-8?B?bEhOVmp1WXpISkc1UzZHRDE4OEFzUFpnTFloNkNuQVRRM1dJS1pJZnYvSlJ3?=
 =?utf-8?B?cTBSQStkWkoxR2UrZkE4VncvSndxK1o5VGhDUVhjZFdLY2VPSHBOUlgyMThx?=
 =?utf-8?B?WFVTdzMrZmlETjF2d01vK3doWXZ0dWo2ZGppVVlyOFRXaEQ1TTJSVWxZWllm?=
 =?utf-8?B?NlB4endNaG1oS212SHFHZ1hlTXNGNGlJWGhaTHhZRVhrWm44VURHSk9UckhD?=
 =?utf-8?B?S2Rsc0w5V0dLK3ZJR2hXczBrOSthY3hrQ1NEd3I5c0JQVFFLS2Z0TkVkY05R?=
 =?utf-8?B?K2hNRXkyMzZqWnNRdVluM0F3T3FMRTVjditFL3QrbzZNN2dvdzYwNklRRzVT?=
 =?utf-8?B?M0lHT1V2czZJdUxWVE1Wa2RXbDFjaDVDQTBmT2o2R1RkSk93VklFYWpqVGlS?=
 =?utf-8?B?L3o4eHlyUDBhaHExNEFVWll3cVFnY29rUGowZjAvZlVpUkNiTkNlL0R6elpX?=
 =?utf-8?B?NmdHWkg2dXAxamJjV1oyamVlakVWYTVOZFVFSzhHTTRyR0w2cEtXbU5OOFQ1?=
 =?utf-8?B?MlVlNElmK0FYQ3lsVjZGQTRYSzhYZWw3dytzWDlsdWQ5SWp5YUFJV3I5dlRE?=
 =?utf-8?B?WHJVUFVlNDF4UHQ2d3YwU0FvTzVZc21XVXVXaVZBdUU4MFdZemRTTDY1V1BX?=
 =?utf-8?B?enhDaGhleE1NbU9ERXF2YTRpeVJpRkhxVU1nT093S296MFVpU3Z3NlFlaTRs?=
 =?utf-8?B?dWVJN2ZlM2RMd3UyUVA3VjBKSWg3Q0ZHcWYwWlIwYjNSdVpIekZ1TVFnVURG?=
 =?utf-8?B?WGRTcEJMaXpGcm9sQko2aTBvYStBaVJzN01majBuL01aY3lnS1RoMVdzdk5J?=
 =?utf-8?B?SWl2ckJmK2RYMk51Y2RlRnBSemxORU9RMjVoZkxUbklvZGlZQVRJKzFUYlhY?=
 =?utf-8?B?NkdtM1FVWnlKdXFPQVZiSGdCNUFHU092Rk5RZjE3cnVPN3V1emtJTDRRTEIw?=
 =?utf-8?B?UUZBbURmYngvUlJnaGVaQTR4cUQwS0VXVkl3YlhkMThrcXJmNk9jNWRBZjFO?=
 =?utf-8?B?QTJ2czFXVHA0cEJ4dkJyTzZnYURqdHg2NzZ3S0pwYlptcmZzTjVVeVpxS3kr?=
 =?utf-8?B?UlR4VWYrQ1huSDZLeElDNWsxSjZtRmhSellpcUtGY1U4Z1ErUmU5TjhRT2gx?=
 =?utf-8?B?N3h3U3l4Smo0ZUtlWnRGRm5IZ0RyakdNc3BtMkdEUjdNanpGaFdCZElONzdj?=
 =?utf-8?Q?bAWZolMEo/n1ppyi1sZ+tdTxx?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f4eeace-8f56-4992-0b3c-08dc0c4ef302
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 11:27:20.4728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lRAupnFOP9XcOVliVl+hEX/LKYj6e0jsyYJgE48WpL9b6u53W3e0dSg7QXEnsEnbTCxqa9efr4z33n98QmnWVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9136

HummingBoard-T features two M.2 connectors labeled "M1" and "M2".
The single SerDes lane of the SoC can be routed to either M1 pci-e
signals, or M2 usb-3 signals by a gpio-controlled mux.

Add dedicated dts for each configuration.
- k3-am642-hummingboard-t.dts enables neither configuration
- k3-am642-hummingboard-t-pcie.dts (new)
  configures serdes mux and pci-e controller for M1
- k3-am642-hummingboard-t-usb3.dts (new)
  configures serdes mux and usb-3 controller for M2

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 arch/arm64/boot/dts/ti/Makefile                    |  2 ++
 .../boot/dts/ti/k3-am642-hummingboard-t-pcie.dts   | 31 ++++++++++++++++++
 .../boot/dts/ti/k3-am642-hummingboard-t-usb3.dts   | 37 ++++++++++++++++++++++
 3 files changed, 70 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 041c3b71155e..0e408555edf1 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -33,6 +33,8 @@ dtb-$(CONFIG_ARCH_K3) += k3-am62p5-sk.dtb
 # Boards with AM64x SoC
 dtb-$(CONFIG_ARCH_K3) += k3-am642-evm.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-hummingboard-t.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-am642-hummingboard-t-pcie.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-am642-hummingboard-t-usb3.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-phyboard-electra-rdk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-sk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-tqma64xxl-mbax4xxl.dtb
diff --git a/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-pcie.dts b/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-pcie.dts
new file mode 100644
index 000000000000..5ba0029fcfb9
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-pcie.dts
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2023 Josua Mayer <josua@solid-run.com>
+ *
+ * DTS for SolidRun AM642 HummingBoard-T,
+ * running on Cortex A53, with PCI-E.
+ *
+ */
+
+#include "k3-am642-hummingboard-t.dts"
+#include "k3-serdes.h"
+
+/ {
+	model = "SolidRun AM642 HummingBoard-T with PCI-E";
+};
+
+&pcie0_rc {
+	status = "okay";
+};
+
+&serdes0_link {
+	cdns,phy-type = <PHY_TYPE_PCIE>;
+};
+
+&serdes_ln_ctrl {
+	idle-states = <AM64_SERDES0_LANE0_PCIE0>;
+};
+
+&serdes_mux {
+	idle-state = <1>;
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-usb3.dts b/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-usb3.dts
new file mode 100644
index 000000000000..12b0fedcd2bc
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-usb3.dts
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2023 Josua Mayer <josua@solid-run.com>
+ *
+ * DTS for SolidRun AM642 HummingBoard-T,
+ * running on Cortex A53, with USB-3.1 Gen 1.
+ *
+ */
+
+#include "k3-am642-hummingboard-t.dts"
+#include "k3-serdes.h"
+
+/ {
+	model = "SolidRun AM642 HummingBoard-T with USB-3.1 Gen 1";
+};
+
+&serdes0_link {
+	cdns,phy-type = <PHY_TYPE_USB3>;
+};
+
+&serdes_ln_ctrl {
+	idle-states = <AM64_SERDES0_LANE0_USB>;
+};
+
+&serdes_mux {
+	idle-state = <0>;
+};
+
+&usbss0 {
+	/delete-property/ ti,usb2-only;
+};
+
+&usb0 {
+	maximum-speed = "super-speed";
+	phys = <&serdes0_link>;
+	phy-names = "cdns3,usb3-phy";
+};

-- 
2.35.3


