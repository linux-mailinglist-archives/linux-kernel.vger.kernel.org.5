Return-Path: <linux-kernel+bounces-24902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9AF82C477
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 18:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87F6D1C222C8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 17:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B1017C86;
	Fri, 12 Jan 2024 17:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="AIFepDPm"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2047.outbound.protection.outlook.com [40.107.15.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E361757F;
	Fri, 12 Jan 2024 17:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bnyl1xaMQtnjcogyi0yTin9Fh3ATLIp1y4NxmtgeLz1Q9/euKaQF02LC2AWno3zERN7PtIHWVvneMRsGdMyN8YXglz8khU40KBtjIr8aAsl3JdMDKqXZRB7QEI3w+QVSg5+v2tpACs3D6y0zTtjy+3D+GStJYm/Bb5E8kSRWk+DJbWODuUSD81i2dIXp5D6CycAK73fG4C/FN8dN2eUJZeAIuV67cQOC15Yw2mtDuB7HW3PLA2Ebjk1kPG4Jp+a5AVRZG3YbDp8T2yZw69bYxO0napnBmNJCgnffMpf8O294zT6dtYsvEXjYNtAnVX9rT0Sgh5omqIj0MnhE7IDDlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2tUMe/qVtRJndtosiXQ0Vl6Z4n0LNC/O18yMoBKt++I=;
 b=ZwG9yO4ndzvqDxe7s1pdeJiQ//uCjNsGndaUlUPUESGTt75OcDv+kLIn4fulfO3Ma3ZvdJTiTdNxRj2vH2aXe517hcFiHbpYQIhVEh4giu7tObwzZsNND22awYr5bzYsqxF5HbfH53qzNpkGG9SQKCS4995JDcgreO3vf5EVt6ZUC9LLdajA86Q+fYCw6eE2XQh5p2fGYoM05g2+EpTPQ0wTpN07AM3N6Rc+cCVitYoqsnMMJppguyYm00ZxtIZ4M5TnOLf+Wz8G4O212HXyWAeCkDWojUIGMd1VaBvHEmuJWMXUP4s/Fi3Rkcuya01xlybyKvG1eSZFmWQPq0L40w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2tUMe/qVtRJndtosiXQ0Vl6Z4n0LNC/O18yMoBKt++I=;
 b=AIFepDPmLWci7a4HGZMpPL+xLVr/Jc/mGi6xOqw9hli4VEvqgmVWkC5RUae11dV7/nkNo+D6/7OP+880KpXWXswW04wD3lvD2H2+pwc8hcpM6EzWryg7A4VHz6YGYRo2ztkHf9hNTgDKaOsn7ogL72jSjnpy4COgMBINYasfUqY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by DU2PR04MB9524.eurprd04.prod.outlook.com (2603:10a6:10:2f7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Fri, 12 Jan
 2024 17:12:42 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d%7]) with mapi id 15.20.7181.020; Fri, 12 Jan 2024
 17:12:42 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Fri, 12 Jan 2024 18:12:30 +0100
Subject: [PATCH v2 5/5] arm64: dts: ti: hummingboard-t: add descriptions
 for m.2 pci-e and usb-3
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240112-add-am64-som-v2-5-1385246c428c@solid-run.com>
References: <20240112-add-am64-som-v2-0-1385246c428c@solid-run.com>
In-Reply-To: <20240112-add-am64-som-v2-0-1385246c428c@solid-run.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org, 
 Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR0P281CA0098.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::8) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|DU2PR04MB9524:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bc58579-954d-43c7-cda2-08dc1391b027
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lFz5QOq/aOHF7Wnw5eEPzeVDjxIW1hzqkOrPCK9oQsHCDchsR4c4BCHLzOohar0IIzQ6K+CqkAZzr696jV/+KpXTsDgAiJ1YjFk0MPQIiT7Qq/smSANG6vUPTStHFS+31ukHELlhx/9fgbwsDhqbVZbskbjjXc3ytmMACWpmpRmV5U+OgZbjq0LqBATwXV9W06a8n1j6yriTic+oVZA3TI9RcTIqctB2lRJvoJ19xh1xxBRw0CcnSpS38biW4DXD9Z55QcT4wOSaoBjVOaJ3ujh93J6f+zEudJ0N/UZbDmIBbJz5v9KIdejcRj/Iek8mFZVbAkjDes4A24SHSqdOoNI6uav6eNGd6GG9KVk27PrKigmcWJAkCB6ZodDbKCu9oeBDndkc/MdciRbpfwNutLTq+L0wEuBPgs5SYLsc7vUyvZxI2uxJ/OIJp4JBjPPxclBthftvoRM4wn6ArkDfkGS+jJyxoCbHWKk7mwGlR+aRdAAhRIy0oMwYfjUdZWimT0KygQbDnvrmYmXOlpjUdbj5JtCrjkJ2mxF8PX0b0fNdjQI4Hlb/oRi2B7nhr+lffG/FjuvdnEjZAPWOE6Z1I04Rl0SxR4hNh0XJoNn7WhboOMI4dj1kEV35jT1mNY9o
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(346002)(39830400003)(136003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(5660300002)(4326008)(7416002)(41300700001)(2906002)(38100700002)(38350700005)(86362001)(36756003)(316002)(6486002)(478600001)(66946007)(110136005)(66476007)(66556008)(8676002)(54906003)(8936002)(6666004)(2616005)(107886003)(83380400001)(26005)(6512007)(6506007)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V2xiWmVaTlVSd0tJNXZ5Z0J2Umg1elR1ektuc2VNV3ZoUjBJWG1RRnFlN3JM?=
 =?utf-8?B?ZDk1Z2NWUEx1aExaanJvMkVNcWlDcExxeXIrVFpkVi8yOXpJYWVNUjZYbVg3?=
 =?utf-8?B?MlNYTXZWdTZBM3VxNy9KUnJtYUtEc2g5dmZKazR6VWFrRUZYR21WSFJ3MWp2?=
 =?utf-8?B?MU1tNXlHK0VsK3RaUzRQNno3Y0pBU3YvbUx3ZlhVZ0dRV21KcncrdkZ3OEJo?=
 =?utf-8?B?MDJGbk4zWWk1NFZqTm5sK05uMjhTVGZ6bUlSZkUrT0RDQTV6SU9CckI4SHpp?=
 =?utf-8?B?Zk1JdDljNnRIWGZURGtPeWcvVkVDaVYyNm4zNFJUVWgwRHNCWWd0OVZ2Lzdr?=
 =?utf-8?B?S2J0VjE1blo0R0VmbXAvcFBtcTVJY0tJczVJTnp5bFN6L1JNMExUVldBTEtu?=
 =?utf-8?B?WVA5R2tlS2o5ZlhpT2hxSXdjWnVVSjRYTHdXSkphQ1FRQ3pETTVnVWl5WFdo?=
 =?utf-8?B?UStreGZ1cVZtWnlxTmQwNXAzNk9WR3ZzL1dxL2NvaXVLaGp2VVRLcFQvZlNU?=
 =?utf-8?B?ZWFQQ3JpOTZIMTZxWFRzTlRwQkVLUlZKU1hpN2lhaUdKRC9NWWk0OGx2VUQ5?=
 =?utf-8?B?T1BSSkRUd0lMU1ViNDlacU95d1NrV0cyeEhJZ1dNWUtyeWw3UjR1ZnF2ZjB2?=
 =?utf-8?B?eTBtOXdoWWc1K2ZCa2hxRnFwUnkvSW10YzY4V0JTYis2Zzhrbjk3OXg5Nmd3?=
 =?utf-8?B?T2xjaFhiQ05QZkhEOUFjaW1OQzJMU0pSNGZLd3JoVzNhZTczZE5xTGYrb0Fi?=
 =?utf-8?B?aEFGMk8wRFpVRk9yMkNIYXpJTUFKeGNvcGFFMXYxOXhaN0psUU1vR2htbkpn?=
 =?utf-8?B?ZVNDcHZHT2UrcjRKb0RPVFhDQVFkQkM3WkJPaVB6SlNUb1ZvYzZTaWxGd3Qx?=
 =?utf-8?B?MlBTVzloMHFWUkxQSWt3blg4R1ZEMmR1RkRFMU8vMit3bmtKU0htOHF4eS9y?=
 =?utf-8?B?UHI1M3MvdnB5aUx3RlZWMGZabmhYOUUwR25ySnloSlplVFpxay9zYXIwOVpG?=
 =?utf-8?B?SHhtUDF6SlUyK2lISG9hOG42ODE2bmEwK2JQWVJGWll4bDAvaE8xbndoMVQ5?=
 =?utf-8?B?cmlHUEtDU1JWck1tVUxHZ3prSERpb2xUdVArQ3VzaVU4OEpNcGNkRk91MXlx?=
 =?utf-8?B?YjI0SXh2SFV3SHpja3BRdmJRN3JDSHVVcE96NmhsdGhkVERjNVBlTFRWN25C?=
 =?utf-8?B?TkkyRmtPb3pGbzg4dnpYRFJtQzZUSmMwNjhPT1BpZk5aYUtCMm9aUkRJZFlz?=
 =?utf-8?B?UExaVTNCMnYwcTNIczNvanlUMkEwV2dTTE1Od1BueXZaSGVrNytsSjhOeGdW?=
 =?utf-8?B?d3FEZ2NBUFg4SnJ2QzdWeVRuMkVLdmFuTGwxUXc1NVp5NlpvNzlmd3FMdXlZ?=
 =?utf-8?B?YzJ2YnYvajBZZHdSTWhGbFFNSm03TEo0VmN0UUZnWlZScXJKSUYwNHBpZUMy?=
 =?utf-8?B?eTd4YnhLbnUyb0ZuSWx1TUk1ck1ySm5WR2Q2TjhuWTErcTRobUU0dXlkQU1R?=
 =?utf-8?B?aHZyN0FXaCtqSTZ3ekJqWWM0Z2pCUlZBVzhTemVSWXVWZlFJUVJ6YUFZRThz?=
 =?utf-8?B?ZGJvdzkrYy8xSDFBNjl3U2dmaGF5dzJEOFkzYzFLcWJTSFpsb05CaTlaUi9j?=
 =?utf-8?B?dGdpK3RiSlNMcUx4Kzg1aUtHUnFmQTJNa013RHFCck4xY3N2TnRtL0R0UDAy?=
 =?utf-8?B?UFNHYWE5eS9ZS29QNXNYeTFaaStVTHVaQWlRWFZCMFNXNzF0Tk8vbWR3VHpB?=
 =?utf-8?B?MUpNYVV2emFPeVRkWXdXdHFORGsyRURqOWlGdDJYTzllekx3KzhOVE81dUpJ?=
 =?utf-8?B?emZ0VDU1Sy92anlqdGt1dVpUcUJaY0R6c3ZSTHNFSFV1ei9yK29KVVhvSE1Q?=
 =?utf-8?B?TXVjTVNNUFFFU01MWGJ6Y1pQczRFOTJmVVNpbmZNS1NqdEdWZkRJN3NGM1hS?=
 =?utf-8?B?VkZQQ09aZmdUSUxLWDhpd2JYYmhKVzZUZE1KdCtPakR0OFNOaC9kaGwvV1JO?=
 =?utf-8?B?THNPUVV3ZDZleC9sTVRCQm9SZkFtbk9BdVBQb0lMaXV0ME15VG1NZHk3TXJR?=
 =?utf-8?B?Z2taQXlDd0RzNWtXa3k2MjZZRzVuZi9VT09vNFJ2eWh4bDA0SGhvWXlISGox?=
 =?utf-8?Q?NWYKZrBR7V6A5CWqQ7B849dDV?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bc58579-954d-43c7-cda2-08dc1391b027
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 17:12:42.7181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hxn5Mb7DQJK4OpOph5NcCzFbXT3NO4gQdrTCbGFvtHdYDGgKq33lpGXvLZnkc6K3tWU/uj7bsFx6EfPFgZHnlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9524

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


