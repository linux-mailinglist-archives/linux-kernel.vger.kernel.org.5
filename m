Return-Path: <linux-kernel+bounces-60821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA5A8509E7
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 16:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77734B21747
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 15:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302CB5D8ED;
	Sun, 11 Feb 2024 15:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="jXS4kxg9"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2109.outbound.protection.outlook.com [40.107.247.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059B75CDF6;
	Sun, 11 Feb 2024 15:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707664090; cv=fail; b=iVEE0vpTwggrwtJLGFnN4oddoPrNfhwxpAFUSyVNnsEhxtuAfH+z8A1uDwsHxhIMxRMWvL9L5up84DewKXk1E0IM9eQuvPzzx6AcYw5jhxQXUXv4fS5omfbOAcHF7wophV8LRIKnLcpGW6G7/o0PRSCDGzo2Z2WF0wkb26ueno8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707664090; c=relaxed/simple;
	bh=975YAxxCro1jfpU8erW/GETtnfhVb+kjCzitEli6D5w=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=jM4eXw5oHLlEetk0ZRxcz0YydHImISZ66mHY4D7hXzJdBTZyD/s2LbtqeiCkSPWLvXcFLqqRQkrQizJY24cPILiU1aQ/tWhR0F8hkyGNvoyxfOYkepjX6K/KK5lu9THtxX/CuIyWU4jcVBFzt0fMUIEXoCd29Dx/SyZ1o+1sA/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=jXS4kxg9; arc=fail smtp.client-ip=40.107.247.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V9S3mKwqDJdrN7v7NZI6qBmVXgk/IOoAvNbj6XoKtKEeKBhplc9kHpHArOEv+w6mBRrRCcoJK6eAMC+uXaGENtb+4YMOHbBwF3TglIIusGJNMFaKxpGtfwB258ribpjO3YEe7J5VQFqRQ+qcYKwk076JGpQEvbvkoHgfgnr+vvfjL4j9Wvf4SSwTIGuJeuZPzilC5F1SPsN0habnKG+72X294I/niO9i+p/taH4yCiQztkF23dg6Ekvh0LETME9zIxJ6rwYmoO5INathsb/OT18vv+HOWmzVef6Ig5s3zzPx/m03YmwRy7DBx6i3hehGnUVVGNfYqNbYcQSGjD7gKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0y20Xpmo++YdlqcSfC8IB24XwOkpHPr68mDqUCQP1D0=;
 b=U8y9Ka+cENuKgBUeiMyANSSW1VcqZdiUxDlnFBOGZV71Gsh099xziQFabygoeRBPzn/JkZXcJL3gkA8sAa9jawe1m+Sw1k+NCeZKDIW2IY5/d/RQCrSHy78yrCG2KmGws8e2NZY4mGg4DJ8i3qN+mziECQGn6oSJQ+mgwvrSI3CTvzxed7Jz5ztvEsfCE4m+7CEYUL33PyisCDc7IVIi1JCck/AX63PJnXzE+/Wxn+pCy3qPI+gzPLePOOqeLnGX3YB+wiilfRdUL7ZSQoXohuQ//nH7mRSFxJlaKGuB09VBlMN+MOCNyTrHM4bhGID1Zym8iWLlo96EN5Po2r6gOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0y20Xpmo++YdlqcSfC8IB24XwOkpHPr68mDqUCQP1D0=;
 b=jXS4kxg9cOOyEUq0a6nATW6Tadi4RkY6ka/1dRy0sARQHgiJaSdKTVegNcSYeWY4UbSpMPvgQMt2BZgrHN9mB0VCDpgTXmkaHhwi5siNs1OixFIImMB2D/L2YkFeQ4FAZ9B7pXtB+6bp4Cz/8QGGAZbB3XmsN0OAMgEzgX4SFH0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by DU2PR04MB8725.eurprd04.prod.outlook.com (2603:10a6:10:2dc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.39; Sun, 11 Feb
 2024 15:08:00 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c%7]) with mapi id 15.20.7249.039; Sun, 11 Feb 2024
 15:08:00 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Sun, 11 Feb 2024 16:07:59 +0100
Subject: [PATCH v5 4/5] arm64: dts: add description for solidrun am642 som
 and evaluation board
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240211-add-am64-som-v5-4-790ed7121249@solid-run.com>
References: <20240211-add-am64-som-v5-0-790ed7121249@solid-run.com>
In-Reply-To: <20240211-add-am64-som-v5-0-790ed7121249@solid-run.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org, 
 Josua Mayer <josua@solid-run.com>, Andrew Davis <afd@ti.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR0P281CA0264.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::19) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|DU2PR04MB8725:EE_
X-MS-Office365-Filtering-Correlation-Id: f9ba0fd9-e553-4069-916a-08dc2b133ca6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iDm8Ume+N/bPcRK6tjvS+yIXaeLoAWfRoQDWdP/chR38eIJ1Ple1aJ7RJU/PLmfEHQTRGh8DSsyyKGsH9SvKTHSTGBnuLMr/gRrBUlTvbS/YYHEi8O5D4lHsC2YoSbps+R+PdPaxclNlbQbkn4Bb2robB+pKTfujXxVdBPJBeM0J3wkMKd4+saXvLp6bFb11Mukqbd76Ll2BCIgj5eGMdoPATonCoI8KvS4AbpJSWqXAkaEpQfmPfEw3Mhwyql2wfJWQ6+AMvrDogIIF3GRdZXYSYBjA7AwrzalppX0u4uYERbw61MXVY+lUn23mRo0tElUed+y3HL2l6SBh6JYwrpiCLBxtv1eXbWD17v7cOLhh/T6VySWIgvqktBBgoE0HDP1GuwQMz98pE6xdPCsog6GYuH8yR+L9snSKjwDiK7kBm/WszxNNWvboSP0cQ1/ZijyiQLJPxxBOpHhH0WPW4PXZ2Fnmde1pUsa6XA0+11TnudlHqdNC6ZFSRP36GmVeisea3UayRE2UC4/DffZQbbLph6f8x/JseJZ37/yNJBDRFoEdALatP59S4hgqtzq5vUjjxIUTT10NodI8VE6cmFNLffuIxQsCtOn0WhghZwpmWloSHIf/BJw2z+FLEH1z
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(366004)(136003)(396003)(376002)(346002)(230922051799003)(230273577357003)(64100799003)(451199024)(186009)(1800799012)(83380400001)(41300700001)(2616005)(316002)(36756003)(6512007)(19627235002)(6486002)(66476007)(66946007)(8676002)(54906003)(478600001)(52116002)(6506007)(66556008)(38350700005)(4326008)(8936002)(86362001)(38100700002)(110136005)(26005)(5660300002)(30864003)(2906002)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UzAwK2VJQmF5Szlnc1lFNU5RYkxLa2hpZGZITUFYWStJRm9ONVJKRlRtZFc3?=
 =?utf-8?B?MTBiYVExUldoWXBvam13ckJObS9CZ3FadTRJWEg4TmJkaThFS0JCNUUrWGFu?=
 =?utf-8?B?V3JkVU1VY2plWjhhSDAzS2tneG5OTkVNMUE2RS9pNHY5QSs4Ym9LWHM4aThO?=
 =?utf-8?B?T2pBRkZGTnE0ek94YzJHdTl1OXpiYlpLZDNsZ0ZCQVJoK1NaY3FLSGlCeWJE?=
 =?utf-8?B?clZsWGk0UVZmd0F5a3lueWlWQjg5OUxDTWR0cWZxUE9QTlIyR3BFUmh4a25q?=
 =?utf-8?B?Y2szSVQyNnlQdTR5ZWhQV2ZKN210K2ptSUdHNEQ1b2dMaGt2ZVl6bFRKSmNF?=
 =?utf-8?B?cFFTeS8zTEFKUlM4NEt5aU5qdFRsZE04aHhSR0FwSXhscks0OW5SN2NidTFN?=
 =?utf-8?B?MVlYaTljeHRPbDcvd0ViZ3RjbzI4R3ZCVUpwNlB4Z3p2OHU0OGw4VHUwTTZW?=
 =?utf-8?B?c2piYjhZRkM1T2YyRWkzQnZiMVN3dkNOUU91U0ZGMzlIYmlYSE5wOHFTNFNV?=
 =?utf-8?B?Q2lPWXhaeHkxUTBkKy83bktidjlmRzR5c3JzcHRRTkdVa3ZLUGhDU05Nb2Vh?=
 =?utf-8?B?dzNsTXZ4aEFheGlBUmFDb0ZWMTV0akUwMkdISXlubzJ2Tmcya1EzajZXbUJl?=
 =?utf-8?B?UkEvQUVLejZNYVBBVmhkem5XUmlMVkJFSHN1cVNVajhjUzJkOVlBZ3F5ekx2?=
 =?utf-8?B?b1Y0QmtrV3NSdnZqc2U4Q3hEQUk0MHdvK0lzcC8rQ1RFV1Vmcnh4L1RpVFo1?=
 =?utf-8?B?T3NWTEo5L1NpdFNZaTJIYnJxcE5CME02WnpaTWRDWnlPcDVDcUphUmtYTVV1?=
 =?utf-8?B?YWV5MUg2ZXhxd0pDZnNValprWTROeVFNVjEwNkgwK0xSVXBXNndMM2picVoz?=
 =?utf-8?B?aUwybW91c2t2K0Z3c1ZOTUx3dTczNm83U0cwOW5LakZXYmtaczdWczNEd2o5?=
 =?utf-8?B?TFFKakUyQjZVUjBvY1E3bXJldk1FYzJNRFIxbFptZHB6YmV3alBUN0pXcmpM?=
 =?utf-8?B?eGZ1TTF1N1hZM2szdE1nVVU0ZjhSVG9udHBhNmJMMndWZ1JWVC9CNXA5NUF0?=
 =?utf-8?B?a0sxZGxkMmp0UGxjYU1SQ0wxM21US3Y1dHRTSVZodEJ4dXNadktrdTIzdSs0?=
 =?utf-8?B?UHkxbFFycnA1bDdZd3kzRVJmRXlNTmM3amtJOVlUNXY2cnRaMElzb2QzNXVH?=
 =?utf-8?B?c1A3aHMxcGVBcUxBSTBUWFRuKytWT2pjWjlsNjVtMzNRWS92U3d3dlRjRWJX?=
 =?utf-8?B?d0toYk5MVDBYMzJ1b3FBMjFhcjA2dXM0Y0dIZFNZT21DSERNUU9hMllvbHBt?=
 =?utf-8?B?WmVSQkNnUEFEYUViY1Y1eDQwYUwzdlQvNVBZM2o0Zk84WWtoZDlicjUrSE8v?=
 =?utf-8?B?Z2dYVUNtSTYram1BclFXUkNtNE15S08yN0tUYkU5SzY0ZXdUdDNUZEJ5bnh1?=
 =?utf-8?B?dW41dVYyZUxxeEFwaU93V3NFaUNCL1BIRUhVY3ZReVBvdHBjRlJqYktoZ2hx?=
 =?utf-8?B?a29YbWJsNzBsV0lkRVVTKzVrMHVrYlFna3o3ZktjSjF2TUg1cHZmeUhDTUJJ?=
 =?utf-8?B?dmMxc0lCVXNmRFJFVnZKYk1SRGlLaERiOWFYTHFFWGdPVTFkNTRPUm5qcWgr?=
 =?utf-8?B?dllOM2pCcTJkZUZ4OExoMVcxU3J2bW1KVHBuUzNJZ2cxUlA0UVdlUTFMN1pO?=
 =?utf-8?B?SnpNUGt0WGkxUUUvTCtOK3FFRXpXbHExQUV1bW9GOGNxQnJrNGxBQjU1dmlV?=
 =?utf-8?B?RlpCZk1zS08vTkV5NnB2Q1kwTmtHNnRKdUtSWHlPUFlkM014NGh3S1VDZHVh?=
 =?utf-8?B?Z2ZiUmk3WEZuOVlQaGlEdm1ER05WejlmaXJCalB6Nys0OE1LN0NqempiT2Y5?=
 =?utf-8?B?MHhMc0szR01FSEVvNzhBQnVMNXV1MFJaallPV1dhLzlQcVFPRFhyL3VPaHdz?=
 =?utf-8?B?cW5ZbWo4YzZYWVdQSmlMOGQzUU9ZbDVBUi8vdXRYV2pIcXlxRkxhaEhBTUZa?=
 =?utf-8?B?bUNTdVZrM0h3eTJjemtCczFXVVFDWFN6MENadEQwR3drTDdnMVpraXIvZjM2?=
 =?utf-8?B?QmE3NElkL0JlVyttditkQUpoK0Fyd2dKcCtjMG1mVGJCS0lLcjJzK3FaRTZC?=
 =?utf-8?Q?qmtDR6q6gOXfEYtz0t470L5W/?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9ba0fd9-e553-4069-916a-08dc2b133ca6
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2024 15:08:00.2449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6CCzelqNn5e9PDK3HONmEOEUi9CZ0qPB0MZMzw2Y4AJ/9VmXhJQI5UpXsmJhEHtXuw1Ez/0WpPy7Vb65sC3vJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8725

Add description for the SolidRun AM642 SoM, and HummingBoard-T
evaluation board.

The SoM features:
- 1x cpsw ethernet with phy
- 2x pru ethernet with phy
- eMMC
- spi flash (assembly option)

Additionally microSD and usb-2.0 otg are included in the SoM
description as they are supported boot sources for the SOC boot-rom.

The Carrier provides:
- 3x RJ45 connector
- 2x M.2 connector
- USB-2.0 Hub
- USB-A Connector
- LEDs
- 2x CAN transceiver
- 1x RS485 transceiver
- sensors

The M.2 connectors support either USB-3.1 or PCI-E depending on status
of a mux. By default the mux is switched off.

Signed-off-by: Josua Mayer <josua@solid-run.com>
Reviewed-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/Makefile                    |   1 +
 arch/arm64/boot/dts/ti/k3-am642-hummingboard-t.dts | 292 ++++++++++
 arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi        | 594 +++++++++++++++++++++
 3 files changed, 887 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 77a347f9f47d..041c3b71155e 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -32,6 +32,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am62p5-sk.dtb
 
 # Boards with AM64x SoC
 dtb-$(CONFIG_ARCH_K3) += k3-am642-evm.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-am642-hummingboard-t.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-phyboard-electra-rdk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-sk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-tqma64xxl-mbax4xxl.dtb
diff --git a/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t.dts b/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t.dts
new file mode 100644
index 000000000000..ebaf281e1e1e
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t.dts
@@ -0,0 +1,292 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2023 Josua Mayer <josua@solid-run.com>
+ *
+ * DTS for SolidRun AM642 HummingBoard-T,
+ * running on Cortex A53.
+ *
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/phy/phy.h>
+
+#include "k3-am642.dtsi"
+#include "k3-am642-sr-som.dtsi"
+
+/ {
+	model = "SolidRun AM642 HummingBoard-T";
+	compatible = "solidrun,am642-hummingboard-t", "solidrun,am642-sr-som", "ti,am642";
+
+	aliases {
+		serial5 = &main_uart3;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&leds_pins_default>;
+
+		/* D24 */
+		led1: led-1 {
+			label = "led1";
+			gpios = <&main_gpio0 29 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_GREEN>;
+		};
+
+		/* D25 */
+		led2: led-2 {
+			label = "led2";
+			gpios = <&main_gpio0 30 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_GREEN>;
+		};
+
+		/* D26 */
+		led3: led-3 {
+			label = "led3";
+			gpios = <&main_gpio0 33 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_GREEN>;
+		};
+	};
+
+	regulator-m2-3v3 {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&regulator_pcie_3v3_pins_default>;
+		regulator-name = "m2-3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&main_gpio1 17 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-always-on;
+	};
+
+	regulator-vpp-1v8 {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&regulator_vpp_1v8_pins_default>;
+		regulator-name = "vpp-1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		gpio = <&main_gpio1 78 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	serdes_mux: mux-controller {
+		compatible = "gpio-mux";
+		pinctrl-names = "default";
+		pinctrl-0 = <&serdes_mux_pins_default>;
+		#mux-control-cells = <0>;
+		/*
+		 * Mux has 2 IOs:
+		 * - select: 0 = USB-3 (M2); 1 = PCIE (M1)
+		 * - shutdown: 0 = active; 1 = disabled (high impedance)
+		 */
+		mux-gpios = <&main_gpio1 40 GPIO_ACTIVE_HIGH>, <&main_gpio1 41 GPIO_ACTIVE_HIGH>;
+		/* default disabled */
+		idle-state = <2>;
+	};
+};
+
+&main_gpio0 {
+	m2-reset-hog {
+		gpio-hog;
+		gpios = <12 GPIO_ACTIVE_LOW>;
+		output-low; /* deasserted */
+		line-name = "m2-reset";
+	};
+
+	m1-m2-w-disable1-hog {
+		gpio-hog;
+		gpios = <32 GPIO_ACTIVE_LOW>;
+		output-low; /* deasserted */
+		line-name = "m1-m2-pcie-w-disable1";
+	};
+
+	m1-m2-w-disable2-hog {
+		gpio-hog;
+		gpios = <34 GPIO_ACTIVE_LOW>;
+		output-low; /* deasserted */
+		line-name = "m1-m2-pcie-w-disable2";
+	};
+};
+
+&main_gpio1 {
+	m1-pcie-clkreq0-hog {
+		gpio-hog;
+		gpios = <11 GPIO_ACTIVE_LOW>;
+		input;
+		line-name = "m1-pcie-clkreq0";
+	};
+
+	m2-pcie-clkreq-hog {
+		gpio-hog;
+		gpios = <35 GPIO_ACTIVE_LOW>;
+		input;
+		line-name = "m2-pcie-clkreq";
+	};
+};
+
+&main_i2c0 {
+	pinctrl-0 = <&main_i2c0_pins_default>, <&main_i2c0_int_pins_default>;
+
+	humidity-sensor@41 {
+		compatible = "ti,hdc2010";
+		reg = <0x41>;
+		interrupt-parent = <&main_gpio0>;
+		interrupts = <37 IRQ_TYPE_EDGE_FALLING>;
+	};
+
+	light-sensor@44 {
+		compatible = "ti,opt3001";
+		reg = <0x44>;
+		interrupt-parent = <&main_gpio0>;
+		interrupts = <37 IRQ_TYPE_EDGE_FALLING>;
+	};
+
+	/* charger@6a */
+};
+
+&main_i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c1_pins_default>;
+	status = "okay";
+
+	rtc@69 {
+		compatible = "abracon,abx80x";
+		reg = <0x69>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&rtc_int_pins_default>;
+		abracon,tc-diode = "schottky";
+		abracon,tc-resistor = <3>;
+		interrupt-parent = <&main_gpio0>;
+		interrupts = <44 IRQ_TYPE_EDGE_FALLING>;
+	};
+};
+
+&main_mcan0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mcan0_pins_default>;
+	status = "okay";
+
+	can-transceiver {
+		max-bitrate = <8000000>;
+	};
+};
+
+&main_mcan1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mcan1_pins_default>;
+	status = "okay";
+
+	can-transceiver {
+		max-bitrate = <8000000>;
+	};
+};
+
+&main_pmx0 {
+	leds_pins_default: leds-pins-default {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x0074, PIN_OUTPUT, 7)	/* GPMC0_AD14.GPIO0_29 */
+			AM64X_IOPAD(0x0078, PIN_OUTPUT, 7)	/* GPMC0_AD15.GPIO0_30 */
+			AM64X_IOPAD(0x0088, PIN_OUTPUT, 7)	/* GPMC0_OEn_REn.GPIO0_33 */
+		>;
+	};
+
+	main_i2c0_int_pins_default: main-i2c0-pins-int-default {
+		pinctrl-single,pins = <
+			/* external pull-up on Carrier */
+			AM64X_IOPAD(0x0098, PIN_INPUT, 7)	/* GPMC0_WAIT0.GPIO0_37 */
+		>;
+	};
+
+	main_i2c1_pins_default: main-i2c1-pins-default {
+		pinctrl-single,pins = <
+			/* external pull-up on SoM */
+			AM64X_IOPAD(0x0268, PIN_INPUT, 0)	/* I2C1_SCL.I2C1_SCL */
+			AM64X_IOPAD(0x026c, PIN_INPUT, 0)	/* I2C1_SDA.I2C1_SDA */
+		>;
+	};
+
+	main_mcan0_pins_default: main-mcan0-pins-default {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x0254, PIN_INPUT, 0)	/* MCAN0_RX.MCAN0_RX */
+			AM64X_IOPAD(0x0250, PIN_OUTPUT, 0)	/* MCAN0_TX.MCAN0_TX */
+		>;
+	};
+
+	main_mcan1_pins_default: main-mcan1-pins-default {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x025c, PIN_INPUT, 0)	/* MCAN1_RX.MCAN1_RX */
+			AM64X_IOPAD(0x0258, PIN_OUTPUT, 0)	/* MCAN1_TX.MCAN1_TX */
+		>;
+	};
+
+	main_uart3_pins_default: main-uart3-pins-default {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x016c, PIN_INPUT, 10)	/* PRG0_PRU0_GPO3.UART3_CTSn */
+			AM64X_IOPAD(0x0170, PIN_OUTPUT, 10)	/* PRG0_PRU0_GPO4.UART3_TXD */
+			AM64X_IOPAD(0x0174, PIN_OUTPUT, 10)	/* PRG0_PRU0_GPO5.UART3_RTSn */
+			AM64X_IOPAD(0x01ac, PIN_INPUT, 10)	/* PRG0_PRU0_GPO19.UART3_RXD */
+		>;
+	};
+
+	pcie0_pins_default: pcie0-pins-default {
+		pinctrl-single,pins = <
+			/* connector M2 RESET */
+			AM64X_IOPAD(0x0030, PIN_OUTPUT, 7)	/* OSPI0_CSn1.GPIO0_12 */
+			/* connectors M1 & M2 W_DISABLE1 */
+			AM64X_IOPAD(0x0084, PIN_OUTPUT, 7)	/* GPMC0_ADVN_ALE.GPIO0_32 */
+			/* connectors M1 & M2 W_DISABLE2 */
+			AM64X_IOPAD(0x008c, PIN_OUTPUT, 7)	/* GPMC0_WEN.GPIO0_34 */
+			/* connectors M1 & M2 PERST0 (PCI Reset) */
+			AM64X_IOPAD(0x019c, PIN_OUTPUT, 7)	/* PRG0_PRU0_GPO15.GPIO1_15 */
+			/* connector M1 CLKREQ0 */
+			AM64X_IOPAD(0x018c, PIN_INPUT, 7)	/* PRG0_PRU0_GPO11.GPIO1_11 */
+			/* connector M2 CLKREQ0 */
+			AM64X_IOPAD(0x01ec, PIN_INPUT, 7)	/* PRG0_PRU1_GPO15.GPIO1_35 */
+		>;
+	};
+
+	regulator_pcie_3v3_pins_default: regulator-pcie-3v3-pins-default {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x01a4, PIN_OUTPUT, 7)	/* PRG0_PRU0_GPO17.GPIO1_17 */
+		>;
+	};
+
+	regulator_vpp_1v8_pins_default: regulator-vpp-1v8-pins-default {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x029c, PIN_OUTPUT, 7)	/* MMC1_SDWP.GPIO1_78 */
+		>;
+	};
+
+	rtc_int_pins_default: rtc-int-pins-default {
+		pinctrl-single,pins = <
+			/* external pull-up on Carrier */
+			AM64X_IOPAD(0x00b4, PIN_INPUT, 7)	/* GPMC0_CSn3.GPIO0_44 */
+		>;
+	};
+
+	serdes_mux_pins_default: serdes-mux-pins-default {
+		pinctrl-single,pins = <
+			/* SEL, 10k pull-down on carrier, 2.2k pullup on SoM */
+			AM64X_IOPAD(0x0200, PIN_OUTPUT, 7)	/* PRG0_MDIO0_MDIO.GPIO1_40 */
+			/* EN */
+			AM64X_IOPAD(0x0204, PIN_OUTPUT, 7)	/* PRG0_MDIO0_MDC.GPIO1_41 */
+		>;
+	};
+};
+
+&main_uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_uart3_pins_default>;
+	uart-has-rtscts;
+	rs485-rts-active-low;
+	linux,rs485-enabled-at-boot-time;
+	status = "okay";
+};
+
+&usb0 {
+	dr_mode = "host";
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi b/arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi
new file mode 100644
index 000000000000..1602c3321165
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi
@@ -0,0 +1,594 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2023 Josua Mayer <josua@solid-run.com>
+ *
+ */
+
+#include <dt-bindings/net/ti-dp83869.h>
+
+/ {
+	model = "SolidRun AM642 SoM";
+	compatible = "solidrun,am642-sr-som", "ti,am642";
+
+	aliases {
+		ethernet0 = &cpsw_port1;
+		ethernet1 = &icssg1_emac0;
+		ethernet2 = &icssg1_emac1;
+		mmc0 = &sdhci0;
+		mmc1 = &sdhci1;
+		serial2 = &main_uart0;
+	};
+
+	chosen {
+		/* SoC default UART console */
+		stdout-path = "serial2:115200n8";
+	};
+
+	/* PRU Ethernet Controller */
+	ethernet {
+		compatible = "ti,am642-icssg-prueth";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pru_rgmii1_pins_default>, <&pru_rgmii2_pins_default>;
+
+		sram = <&oc_sram>;
+		ti,prus = <&pru1_0>, <&rtu1_0>, <&tx_pru1_0>, <&pru1_1>, <&rtu1_1>, <&tx_pru1_1>;
+		firmware-name = "ti-pruss/am65x-sr2-pru0-prueth-fw.elf",
+				"ti-pruss/am65x-sr2-rtu0-prueth-fw.elf",
+				"ti-pruss/am65x-sr2-txpru0-prueth-fw.elf",
+				"ti-pruss/am65x-sr2-pru1-prueth-fw.elf",
+				"ti-pruss/am65x-sr2-rtu1-prueth-fw.elf",
+				"ti-pruss/am65x-sr2-txpru1-prueth-fw.elf";
+
+		/* configure internal pinmux for mii mode */
+		ti,pruss-gp-mux-sel = <2>, <2>, <2>, <2>, <2>, <2>;
+
+		ti,mii-g-rt = <&icssg1_mii_g_rt>;
+		ti,mii-rt = <&icssg1_mii_rt>;
+		ti,iep = <&icssg1_iep0>, <&icssg1_iep1>;
+
+		/*
+		 * Configure icssg interrupt controller to map pru-internal
+		 * interrupts 8/9 via channels 0/1 to host interrupts 0/1.
+		 *
+		 * For details see interrupt controller documentation:
+		 * Documentation/devicetree/bindings/interrupt-controller/ti,pruss-intc.yaml
+		 */
+		interrupt-parent = <&icssg1_intc>;
+		interrupts = <24 0 2>, <25 1 3>;
+		interrupt-names = "tx_ts0", "tx_ts1";
+
+		dmas = <&main_pktdma 0xc200 15>, /* egress slice 0 */
+		       <&main_pktdma 0xc201 15>, /* egress slice 0 */
+		       <&main_pktdma 0xc202 15>, /* egress slice 0 */
+		       <&main_pktdma 0xc203 15>, /* egress slice 0 */
+		       <&main_pktdma 0xc204 15>, /* egress slice 1 */
+		       <&main_pktdma 0xc205 15>, /* egress slice 1 */
+		       <&main_pktdma 0xc206 15>, /* egress slice 1 */
+		       <&main_pktdma 0xc207 15>, /* egress slice 1 */
+		       <&main_pktdma 0x4200 15>, /* ingress slice 0 */
+		       <&main_pktdma 0x4201 15>; /* ingress slice 1 */
+		dma-names = "tx0-0", "tx0-1", "tx0-2", "tx0-3",
+			    "tx1-0", "tx1-1", "tx1-2", "tx1-3",
+			    "rx0", "rx1";
+
+		ethernet-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			icssg1_emac0: port@0 {
+				reg = <0>;
+				ti,syscon-rgmii-delay = <&main_conf 0x4110>;
+				/* Filled in by bootloader */
+				local-mac-address = [00 00 00 00 00 00];
+				phy-handle = <&ethernet_phy2>;
+				phy-mode = "rgmii-id";
+			};
+
+			icssg1_emac1: port@1 {
+				reg = <1>;
+				ti,syscon-rgmii-delay = <&main_conf 0x4114>;
+				/* Filled in by bootloader */
+				local-mac-address = [00 00 00 00 00 00];
+				phy-handle = <&ethernet_phy1>;
+				phy-mode = "rgmii-id";
+			};
+		};
+	};
+
+	/* DDR16SS0:
+	 * - Bank 1 @ 0x080000000-0x0FFFFFFFF: max. 2GB in 32-bit address space
+	 * - Bank 2 @ 0x880000000-0x9FFFFFFFF: max. 6GB in 64-bit address space
+	 */
+	memory@80000000 {
+		reg = <0x00000000 0x80000000 0x00000000 0x80000000>,
+		      <0x00000008 0x80000000 0x00000001 0x80000000>;
+		device_type = "memory";
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		secure_ddr: optee@9e800000 {
+			reg = <0x00 0x9e800000 0x00 0x01800000>; /* for OP-TEE */
+			no-map;
+		};
+
+		main_r5fss0_core0_dma_memory_region: r5f-dma-memory@a0000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa0000000 0x00 0x100000>;
+			no-map;
+		};
+
+		main_r5fss0_core0_memory_region: r5f-memory@a0100000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa0100000 0x00 0xf00000>;
+			no-map;
+		};
+
+		main_r5fss0_core1_dma_memory_region: r5f-dma-memory@a1000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa1000000 0x00 0x100000>;
+			no-map;
+		};
+
+		main_r5fss0_core1_memory_region: r5f-memory@a1100000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa1100000 0x00 0xf00000>;
+			no-map;
+		};
+
+		main_r5fss1_core0_dma_memory_region: r5f-dma-memory@a2000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa2000000 0x00 0x100000>;
+			no-map;
+		};
+
+		main_r5fss1_core0_memory_region: r5f-memory@a2100000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa2100000 0x00 0xf00000>;
+			no-map;
+		};
+
+		main_r5fss1_core1_dma_memory_region: r5f-dma-memory@a3000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa3000000 0x00 0x100000>;
+			no-map;
+		};
+
+		main_r5fss1_core1_memory_region: r5f-memory@a3100000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa3100000 0x00 0xf00000>;
+			no-map;
+		};
+	};
+
+	vdd_mmc0: regulator-vdd-mmc0 {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd-mmc0";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+};
+
+&cpsw3g {
+	pinctrl-names = "default";
+	pinctrl-0 = <&rgmii1_pins_default>;
+};
+
+&cpsw3g_mdio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mdio0_pins_default>;
+	status = "okay";
+
+	ethernet_phy0: ethernet-phy@0 {
+		compatible = "ethernet-phy-id2000.a0f1";
+		reg = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&ethernet_phy0_pins_default>;
+		ti,clk-output-sel = <DP83869_CLK_O_SEL_REF_CLK>;
+		ti,op-mode = <DP83869_RGMII_COPPER_ETHERNET>;
+		/*
+		 * Disable interrupts because ISR never clears 0x0040
+		 *
+		 * interrupt-parent = <&main_gpio1>;
+		 * interrupts = <70 IRQ_TYPE_LEVEL_LOW>;
+		 */
+		/*
+		 * Disable HW Reset because clock signal is daisy-chained
+		 *
+		 * reset-gpios = <&main_gpio0 84 GPIO_ACTIVE_LOW>;
+		 * reset-assert-us = <1>;
+		 * reset-deassert-us = <30>;
+		 */
+	};
+};
+
+&cpsw_port1 {
+	phy-mode = "rgmii-id";
+	phy-handle = <&ethernet_phy0>;
+};
+
+&cpsw_port2 {
+	status = "disabled";
+};
+
+&icssg1_mdio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pru1_mdio0_pins_default>;
+	status = "okay";
+
+	ethernet_phy1: ethernet-phy@3 {
+		compatible = "ethernet-phy-id2000.a0f1";
+		reg = <3>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&ethernet_phy1_pins_default>;
+		ti,clk-output-sel = <DP83869_CLK_O_SEL_REF_CLK>;
+		ti,op-mode = <DP83869_RGMII_COPPER_ETHERNET>;
+		/*
+		 * Disable interrupts because ISR never clears 0x0040
+		 *
+		 * interrupt-parent = <&main_gpio1>;
+		 * interrupts = <70 IRQ_TYPE_LEVEL_LOW>;
+		 */
+		/*
+		 * Disable HW Reset because clock signal is daisy-chained
+		 *
+		 * reset-gpios = <&main_gpio0 20 GPIO_ACTIVE_LOW>;
+		 * reset-assert-us = <1>;
+		 * reset-deassert-us = <30>;
+		 */
+	};
+
+	ethernet_phy2: ethernet-phy@f {
+		compatible = "ethernet-phy-id2000.a0f1";
+		reg = <0xf>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&ethernet_phy2_pins_default>;
+		ti,op-mode = <DP83869_RGMII_COPPER_ETHERNET>;
+		/*
+		 * Disable interrupts because ISR never clears 0x0040
+		 *
+		 * interrupt-parent = <&main_gpio1>;
+		 * interrupts = <70 IRQ_TYPE_LEVEL_LOW>;
+		 */
+		/*
+		 * Disable HW Reset because clock signal is daisy-chained
+		 *
+		 * reset-gpios = <&main_gpio0 52 GPIO_ACTIVE_LOW>;
+		 * reset-assert-us = <1>;
+		 * reset-deassert-us = <30>;
+		 */
+	};
+};
+
+&mailbox0_cluster2 {
+	status = "okay";
+
+	mbox_main_r5fss0_core0: mbox-main-r5fss0-core0 {
+		ti,mbox-rx = <0 0 2>;
+		ti,mbox-tx = <1 0 2>;
+	};
+
+	mbox_main_r5fss0_core1: mbox-main-r5fss0-core1 {
+		ti,mbox-rx = <2 0 2>;
+		ti,mbox-tx = <3 0 2>;
+	};
+};
+
+&mailbox0_cluster4 {
+	status = "okay";
+
+	mbox_main_r5fss1_core0: mbox-main-r5fss1-core0 {
+		ti,mbox-rx = <0 0 2>;
+		ti,mbox-tx = <1 0 2>;
+	};
+
+	mbox_main_r5fss1_core1: mbox-main-r5fss1-core1 {
+		ti,mbox-rx = <2 0 2>;
+		ti,mbox-tx = <3 0 2>;
+	};
+};
+
+&main_i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c0_pins_default>;
+	status = "okay";
+
+	som_eeprom: eeprom@50 {
+		compatible = "atmel,24c01";
+		reg = <0x50>;
+		pagesize = <8>;
+	};
+};
+
+&main_pmx0 {
+	/* hog global functions */
+	pinctrl-names = "default";
+	pinctrl-0 = <&ethernet_phy_pins_default>;
+
+	ethernet_phy_pins_default: ethernet-phy-pins-default {
+		pinctrl-single,pins = <
+			/* interrupt / power-down, external pull-up on SoM */
+			AM64X_IOPAD(0x0278, PIN_INPUT, 7)	/* EXTINTn.GPIO1_70 */
+		>;
+	};
+
+	ethernet_phy0_pins_default: ethernet-phy0-pins-default {
+		pinctrl-single,pins = <
+			/* reset */
+			AM64X_IOPAD(0x0154, PIN_OUTPUT, 7)	/* PRG1_PRU1_GPO19.GPIO0_84 */
+			/* reference clock */
+			AM64X_IOPAD(0x0274, PIN_OUTPUT, 5)	/* EXT_REFCLK1.CLKOUT0 */
+		>;
+	};
+
+	ethernet_phy1_pins_default: ethernet-phy1-pins-default {
+		pinctrl-single,pins = <
+			/* reset */
+			AM64X_IOPAD(0x0150, PIN_OUTPUT, 7)	/* PRG1_PRU1_GPO18.GPIO0_20 */
+			/* led0, external pull-down on SoM */
+			AM64X_IOPAD(0x0128, PIN_INPUT, 7)	/* PRG1_PRU1_GPO8.GPIO0_73 */
+			/* led1/rxer */
+			AM64X_IOPAD(0x011c, PIN_INPUT, 7)	/* PRG1_PRU1_GPO5.GPIO0_70 */
+		>;
+	};
+
+	ethernet_phy2_pins_default: ethernet-phy2-pins-default {
+		pinctrl-single,pins = <
+			/* reset */
+			AM64X_IOPAD(0x00d4, PIN_OUTPUT, 7)	/* PRG1_PRU0_GPO7.GPIO0_52 */
+			/* led0, external pull-down on SoM */
+			AM64X_IOPAD(0x00d8, PIN_INPUT, 7)	/* PRG1_PRU0_GPO8.GPIO0_53 */
+			/* led1/rxer */
+			AM64X_IOPAD(0x00cc, PIN_INPUT, 7)	/* PRG1_PRU0_GPO5.GPIO0_50 */
+		>;
+	};
+
+	main_i2c0_pins_default: main-i2c0-pins-default {
+		pinctrl-single,pins = <
+			/* external pull-up on SoM */
+			AM64X_IOPAD(0x0260, PIN_INPUT, 0)	/* I2C0_SCL.I2C0_SCL */
+			AM64X_IOPAD(0x0264, PIN_INPUT, 0)	/* I2C0_SDA.I2C0_SDA */
+		>;
+	};
+
+	/*
+	 * main_mmc0_pins_default: main-mmc0-pins-default
+	 *
+	 * MMC0_CMD: no padconfig
+	 * MMC0_CLK: no padconfig, external pull-up on SoM
+	 * MMC0_DAT0: no padconfig
+	 * MMC0_DAT1: no padconfig
+	 * MMC0_DAT2: no padconfig
+	 * MMC0_DAT3: no padconfig
+	 * MMC0_DAT4: no padconfig
+	 * MMC0_DAT5: no padconfig
+	 * MMC0_DAT6: no padconfig
+	 * MMC0_DAT7: no padconfig
+	 * MMC0_DS: no padconfig, external pull-down on SoM
+	 */
+
+	main_mmc1_pins_default: main-mmc1-pins-default {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x0294, PIN_INPUT_PULLUP, 0)	/* (J19) MMC1_CMD */
+			AM64X_IOPAD(0x028c, PIN_INPUT, 0)		/* MMC1_CLK.MMC1_CLK */
+			AM64X_IOPAD(0x0288, PIN_INPUT_PULLUP, 0)	/* MMC1_DAT0.MMC1_DAT0 */
+			AM64X_IOPAD(0x0284, PIN_INPUT_PULLUP, 0)	/* MMC1_DAT1.MMC1_DAT1 */
+			AM64X_IOPAD(0x0280, PIN_INPUT_PULLUP, 0)	/* MMC1_DAT2.MMC1_DAT2 */
+			AM64X_IOPAD(0x027c, PIN_INPUT_PULLUP, 0)	/* MMC1_DAT3.MMC1_DAT3 */
+			/* external pull-down on SoM & Carrier */
+			AM64X_IOPAD(0x0298, PIN_INPUT_PULLUP, 0)	/* MMC1_SDCD.MMC1_SDCD */
+			AM64X_IOPAD(0x0290, PIN_INPUT, 0)		/* MMC1_CLKLB: clock loopback */
+		>;
+	};
+
+	main_uart0_pins_default: main-uart0-pins-default {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x0230, PIN_INPUT, 0)		/* UART0_RXD.UART0_RXD */
+			AM64X_IOPAD(0x0234, PIN_OUTPUT, 0)		/* UART0_TXD.UART0_TXD */
+		>;
+	};
+
+	mdio0_pins_default: mdio0-pins-default {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x01fc, PIN_OUTPUT, 4)		/* PRG0_PRU1_GPO19.MDIO0_MDC */
+			AM64X_IOPAD(0x01f8, PIN_INPUT, 4)		/* PRG0_PRU1_GPO18.MDIO0_MDIO */
+		>;
+	};
+
+	ospi0_pins_default: ospi0-pins-default {
+		pinctrl-single,pins = <
+			/* external pull-down on SoM */
+			AM64X_IOPAD(0x0000, PIN_OUTPUT, 0)		/* OSPI0_CLK.OSPI0_CLK */
+			AM64X_IOPAD(0x0008, PIN_OUTPUT, 0)		/* OSPI0_DQS.OSPI0_DQS */
+			/* external pull-up on SoM */
+			AM64X_IOPAD(0x002c, PIN_OUTPUT, 0)		/* OSPI0_CSn0.OSPI0_CSn0 */
+			AM64X_IOPAD(0x000c, PIN_INPUT, 0)		/* OSPI0_D0.OSPI0_D0 */
+			AM64X_IOPAD(0x0010, PIN_INPUT, 0)		/* OSPI0_D1.OSPI0_D1 */
+			AM64X_IOPAD(0x0014, PIN_INPUT, 0)		/* OSPI0_D2.OSPI0_D2 */
+			AM64X_IOPAD(0x0018, PIN_INPUT, 0)		/* OSPI0_D3.OSPI0_D3 */
+			AM64X_IOPAD(0x001c, PIN_INPUT, 0)		/* OSPI0_D4.OSPI0_D4 */
+			AM64X_IOPAD(0x0020, PIN_INPUT, 0)		/* OSPI0_D5.OSPI0_D5 */
+			AM64X_IOPAD(0x0024, PIN_INPUT, 0)		/* OSPI0_D6.OSPI0_D6 */
+			AM64X_IOPAD(0x0028, PIN_INPUT, 0)		/* OSPI0_D7.OSPI0_D7 */
+		>;
+	};
+
+	ospi0_flash0_pins_default: ospi0-flash0-pins-default {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x0034, PIN_OUTPUT, 7)		/* OSPI0_CSn2.GPIO0_13 */
+			AM64X_IOPAD(0x0038, PIN_INPUT, 7)		/* OSPI0_CSn3.GPIO0_14 */
+		>;
+	};
+
+	pru1_mdio0_pins_default: pru1-mdio0-pins-default {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x015c, PIN_OUTPUT, 0)		/* PRG1_MDIO0_MDC.PRG1_MDIO0_MDC */
+			AM64X_IOPAD(0x0158, PIN_INPUT, 0)		/* PRG1_MDIO0_MDIO.PRG1_MDIO0_MDIO */
+		>;
+	};
+
+	pru_rgmii1_pins_default: pru-rgmii1-pins-default {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x00b8, PIN_INPUT, 2)		/* (Y7) PRG1_PRU0_GPO0.PRG1_RGMII1_RD0 */
+			AM64X_IOPAD(0x00bc, PIN_INPUT, 2)		/* (U8) PRG1_PRU0_GPO1.PRG1_RGMII1_RD1 */
+			AM64X_IOPAD(0x00c0, PIN_INPUT, 2)		/* (W8) PRG1_PRU0_GPO2.PRG1_RGMII1_RD2 */
+			AM64X_IOPAD(0x00c4, PIN_INPUT, 2)		/* (V8) PRG1_PRU0_GPO3.PRG1_RGMII1_RD3 */
+			AM64X_IOPAD(0x00d0, PIN_INPUT, 2)		/* (AA7) PRG1_PRU0_GPO6.PRG1_RGMII1_RXC */
+			AM64X_IOPAD(0x00c8, PIN_INPUT, 2)		/* (Y8) PRG1_PRU0_GPO4.PRG1_RGMII1_RX_CTL */
+			AM64X_IOPAD(0x00e4, PIN_OUTPUT, 2)		/* (AA8) PRG1_PRU0_GPO11.PRG1_RGMII1_TD0 */
+			AM64X_IOPAD(0x00e8, PIN_OUTPUT, 2)		/* (U9) PRG1_PRU0_GPO12.PRG1_RGMII1_TD1 */
+			AM64X_IOPAD(0x00ec, PIN_OUTPUT, 2)		/* (W9) PRG1_PRU0_GPO13.PRG1_RGMII1_TD2 */
+			AM64X_IOPAD(0x00f0, PIN_OUTPUT, 2)		/* (AA9) PRG1_PRU0_GPO14.PRG1_RGMII1_TD3 */
+			AM64X_IOPAD(0x00f8, PIN_INPUT, 2)		/* (V9) PRG1_PRU0_GPO16.PRG1_RGMII1_TXC */
+			AM64X_IOPAD(0x00f4, PIN_OUTPUT, 2)		/* (Y9) PRG1_PRU0_GPO15.PRG1_RGMII1_TX_CTL */
+		>;
+	};
+
+	pru_rgmii2_pins_default: pru-rgmii2-pins-default {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x0108, PIN_INPUT, 2)		/* PRG1_PRU1_GPO0.RGMII2_RD0 */
+			AM64X_IOPAD(0x010c, PIN_INPUT, 2)		/* PRG1_PRU1_GPO1.RGMII2_RD1 */
+			AM64X_IOPAD(0x0110, PIN_INPUT, 2)		/* PRG1_PRU1_GPO2.RGMII2_RD2 */
+			AM64X_IOPAD(0x0114, PIN_INPUT, 2)		/* PRG1_PRU1_GPO3.RGMII2_RD3 */
+			AM64X_IOPAD(0x0120, PIN_INPUT, 2)		/* PRG1_PRU1_GPO6.RGMII2_RXC */
+			AM64X_IOPAD(0x0118, PIN_INPUT, 2)		/* PRG1_PRU1_GPO4.RGMII2_RX_CTL */
+			AM64X_IOPAD(0x0134, PIN_OUTPUT, 2)		/* PRG1_PRU1_GPO11.RGMII2_TD0 */
+			AM64X_IOPAD(0x0138, PIN_OUTPUT, 2)		/* PRG1_PRU1_GPO12.RGMII2_TD1 */
+			AM64X_IOPAD(0x013c, PIN_OUTPUT, 2)		/* PRG1_PRU1_GPO13.RGMII2_TD2 */
+			AM64X_IOPAD(0x0140, PIN_OUTPUT, 2)		/* PRG1_PRU1_GPO14.RGMII2_TD3 */
+			AM64X_IOPAD(0x0148, PIN_INPUT, 2)		/* PRG1_PRU1_GPO16.RGMII2_TXC */
+			AM64X_IOPAD(0x0144, PIN_OUTPUT, 2)		/* PRG1_PRU1_GPO15.RGMII2_TX_CTL */
+		>;
+	};
+
+	rgmii1_pins_default: rgmii1-pins-default {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x01cc, PIN_INPUT, 4)		/* PRG0_PRU1_GPO7.RGMII1_RD0 */
+			AM64X_IOPAD(0x01d4, PIN_INPUT, 4)		/* PRG0_PRU1_GPO9.RGMII1_RD1 */
+			AM64X_IOPAD(0x01d8, PIN_INPUT, 4)		/* PRG0_PRU1_GPO10.RGMII1_RD2 */
+			AM64X_IOPAD(0x01f4, PIN_INPUT, 4)		/* PRG0_PRU1_GPO17.RGMII1_RD3 */
+			AM64X_IOPAD(0x0188, PIN_INPUT, 4)		/* PRG0_PRU0_GPO10.RGMII1_RXC */
+			AM64X_IOPAD(0x0184, PIN_INPUT, 4)		/* PRG0_PRU0_GPO9.RGMII1_RX_CTL */
+			AM64X_IOPAD(0x0124, PIN_OUTPUT, 4)		/* PRG1_PRU1_GPO7.RGMII1_TD0 */
+			AM64X_IOPAD(0x012c, PIN_OUTPUT, 4)		/* PRG1_PRU1_GPO9.RGMII1_TD1 */
+			AM64X_IOPAD(0x0130, PIN_OUTPUT, 4)		/* PRG1_PRU1_GPO10.RGMII1_TD2 */
+			AM64X_IOPAD(0x014c, PIN_OUTPUT, 4)		/* PRG1_PRU1_GPO17.RGMII1_TD3 */
+			AM64X_IOPAD(0x00e0, PIN_INPUT, 4)		/* PRG1_PRU0_GPO10.RGMII1_TXC */
+			AM64X_IOPAD(0x00dc, PIN_OUTPUT, 4)		/* PRG1_PRU0_GPO9.RGMII1_TX_CTL */
+		>;
+	};
+
+	usb0_pins_default: usb0-pins-default {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x02a8, PIN_OUTPUT, 0)		/* USB0_DRVVBUS.USB0_DRVVBUS */
+		>;
+	};
+};
+
+&main_r5fss0_core0 {
+	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core0>;
+	memory-region = <&main_r5fss0_core0_dma_memory_region>,
+			<&main_r5fss0_core0_memory_region>;
+};
+
+&main_r5fss0_core1 {
+	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core1>;
+	memory-region = <&main_r5fss0_core1_dma_memory_region>,
+			<&main_r5fss0_core1_memory_region>;
+};
+
+&main_r5fss1_core0 {
+	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core0>;
+	memory-region = <&main_r5fss1_core0_dma_memory_region>,
+			<&main_r5fss1_core0_memory_region>;
+};
+
+&main_r5fss1_core1 {
+	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core1>;
+	memory-region = <&main_r5fss1_core1_dma_memory_region>,
+			<&main_r5fss1_core1_memory_region>;
+};
+
+/* SoC default UART console */
+&main_uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_uart0_pins_default>;
+	status = "okay";
+};
+
+&ospi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&ospi0_pins_default>;
+	num-cs = <1>;
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&ospi0_flash0_pins_default>;
+		spi-tx-bus-width = <8>;
+		spi-rx-bus-width = <8>;
+		spi-max-frequency = <200000000>;
+		cdns,tshsl-ns = <50>;
+		cdns,tsd2d-ns = <50>;
+		cdns,tchsh-ns = <4>;
+		cdns,tslch-ns = <4>;
+		cdns,read-delay = <0>;
+		interrupt-parent = <&main_gpio0>;
+		interrupts = <14 IRQ_TYPE_LEVEL_LOW>;
+		reset-gpios = <&main_gpio0 13 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&sdhci0 {
+	/* mmc0 pins have no padconfig */
+	bus-width = <8>;
+	ti,driver-strength-ohm = <50>;
+	disable-wp;
+	non-removable;
+	cap-mmc-hw-reset;
+	no-sd;
+	/*
+	 * MMC controller supports switching between 1.8V and 3.3V signalling.
+	 * However MMC0 (unlike MMC1) does not integrate an LDO.
+	 * Explicitly link a regulator node for indicating to the driver which
+	 * voltages are actually usable.
+	 */
+	vqmmc-supply = <&vdd_mmc0>;
+	status = "okay";
+};
+
+/*
+ * microSD is on carrier - however since SoC can boot from it,
+ * configure it just in case.
+ */
+&sdhci1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mmc1_pins_default>;
+	bus-width = <4>;
+	ti,driver-strength-ohm = <50>;
+	disable-wp;
+	status = "okay";
+};
+
+/*
+ * USB settings are a carrier choice - however since SoC can boot from it,
+ * configure as USB-2.0 OTG here, keeping USB-3 serdes disabled.
+ */
+&usb0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb0_pins_default>;
+	dr_mode = "otg";
+	maximum-speed = "high-speed";
+};
+
+&usbss0 {
+	ti,vbus-divider;
+	ti,usb2-only;
+};

-- 
2.35.3


