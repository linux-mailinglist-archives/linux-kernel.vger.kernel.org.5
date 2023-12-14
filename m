Return-Path: <linux-kernel+bounces-27-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE4D813AF6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 20:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 223751F21EC7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E724F6A01C;
	Thu, 14 Dec 2023 19:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OGwKmt4B"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2058.outbound.protection.outlook.com [40.107.20.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9840F69790;
	Thu, 14 Dec 2023 19:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YWhucMffIgCL/JPMnEU/MW9COEtrVOZYzKqp4sMe6mzJ6ylgN/JmZG8l6fw5OtQE6TBO8FgGIurJlrU7kpOJJjnRNFNw7B83+ZuTmhiC81ajxvWs7c0WSlqnKlA1ljlR+vU8glnhgPayOUo6v84Cosb5FtvEisAwyWQFF7N2+LXJ41mgOjegFPJiwlvFUcb9qzIp2IxjbTVcsC5Z/O+xKTVf4P98bjkiWFnwUZ/pY72bqZe5QE+W/dvnHQas785yptkAVLAPsqUmapp2GPi/ud1Kji97DGT48wxJLccUw3AnRJbWxw/mVKyhs7cbnQX/gkmf5J3Y63Uxb51h6RNoLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nGscB5pCZbhbIRTaQUZNrVZvtgcAKnF1yz33Ey65KFU=;
 b=CsAUA9QYXiHeTjHTcOOWaUdm4cLOQQ/jQn808yOqUWZe/vuiE3E5zupPp2AkwLIhGnWXT6tVgNUuo7ERvNrtuWbczD2n9yoeXmqh6sF39uPV7EtdS0MO0xcgcYF4XGxD+420GSP53GmiJbFMrDJQ1v5ejWnzRLMBJblmkzvzVpG11PPgj9y20hoh/MPUCixMkI3RzzV7siKYfGDsyu4zAY9XOZASMKcOH/I9EvNJBEahXGxUhqunY+Yrg+eIAfKDamVQq0qJA8LZh8v+g1aOKCxDs5Cn9WhQiIe1JNqrImM09DJ673uo8cY/WIKokKCWNXv7eS1cRMU/LkvTExeRkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGscB5pCZbhbIRTaQUZNrVZvtgcAKnF1yz33Ey65KFU=;
 b=OGwKmt4BgyrVZXF8u+J4isGIRXloYMhNf27GcB37U654qqK2wZKGgo8weRfD4j7Av8XvpF4zM6cPerWE7nifamIFlO6DRHw1c+6gbZK1cu1BSspRTg3CD1Vs0RMrRslAzuWndOHnoid8chnPNXPWsEFGtUwa4i5d8K2D/+4peo0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB7688.eurprd04.prod.outlook.com (2603:10a6:20b:29d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 19:47:13 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 19:47:13 +0000
From: Frank Li <Frank.Li@nxp.com>
To: shawnguo@kernel.org,
	xiaolei.wang@windriver.com
Cc: Frank.li@nxp.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	festevam@gmail.com,
	imx@lists.linux.dev,
	kernel@pengutronix.de,
	krzysztof.kozlowski+dt@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-imx@nxp.com,
	linux-kernel@vger.kernel.org,
	marcel.ziswiler@toradex.com,
	qiangqing.zhang@nxp.com,
	robh+dt@kernel.org,
	s.hauer@pengutronix.de
Subject: [PATCH 1/2] arm64: dts: imx8qm: Align edma3 power-domains resources indentation
Date: Thu, 14 Dec 2023 14:46:54 -0500
Message-Id: <20231214194655.608902-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0024.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::37) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB7688:EE_
X-MS-Office365-Filtering-Correlation-Id: 14a327c7-d3e4-4b46-66e2-08dbfcdd77ce
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
 KVJggMDfY72qEM56mJ/Hwan2/HqjpSmE1+dTZTokjs2eDZjupQyMpkKRxq+g+saT1Dh061BKIJihIo7JN87BX0Z6PqdC/6jKInR/ICGQ/pYRTYymu90IaqgzkreiDHEAj/ifnASTFlimwLYGhULs0i45ZPOgTcngdR1Unyynt22QKVVOCvhrhlwSHApX2eWD32mAStmc52S9dXVmk/ryfVDrFxOf+Qw+5tVgSUmQ8OHLow7M3oNPQbkYxax4enNgQMffFVOiYCbsi8DDVY8WcWG41kUcDSEZDp2Q180xWTHL861emuaTx+FfiF3h3OmGPhTMxiFQRa8F719ZwcxpwYy/TObMUc20CHPpnrKlgEabtSKtpRNCkNR82w7zhhuTESrFCySmzOOwzn3rpGGCTLNegK9YHNFnwYnf4eqEcjbPCROEz0JrO45V2aHCbDOoewG8e0dBXnzsMj6pIJCv+KrF9vjRyc93We8/8v0U75UeFv0RTp9/8fLntBhl+1UOhV5yV0oICHkccIO3kWHfl0w1b76SOyo8PzBjmIIPpoFO3V9c5OcQ+NAbpQEGv0RKDWWrtHaC5yqyQakiEN/WKFNZ784lyDhNNeJpdWQShVIF45jIDR1OKc0sv1CtxlQKDBoMi1dc57xqFqlE95wcFg==
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(136003)(396003)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(83380400001)(316002)(4326008)(8676002)(8936002)(6512007)(52116002)(6506007)(66946007)(478600001)(66556008)(86362001)(5660300002)(7416002)(6486002)(66476007)(6666004)(41300700001)(36756003)(2906002)(38100700002)(26005)(2616005)(1076003)(38350700005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?WptTNYFkg3J8ciQz5OZYVIr6tWV6XqueVsVmBV6j8W8j++nYhGhc2pxMhRd8?=
 =?us-ascii?Q?xUm9JCzXL6vvfDGmq6cpl9gzlHSFzSq/xcxP7O/E5zPxz6K9XSXcdBTUM8kd?=
 =?us-ascii?Q?u8C61Ttxg7FRGhYtc2CADhptNgPhjLrISLnKeaqKVdKbk4eRlr1ew6zBYyYf?=
 =?us-ascii?Q?E0Awe/g+6mGzBnUyLpEfWU4oth8uPkRFjGiktH14svD00+bs8Pqg4NPAhOnI?=
 =?us-ascii?Q?r5Dw+DAaIAQL25FKeCi9oy+xMIdE9ZlVYPXItL8aQoDeWfezgjqEiL6hTh3x?=
 =?us-ascii?Q?l97b12qsD5p8kFh7wMK3e8x2u/oQlOSpHK4N6f64Xnu1rq94v8UH4s0KRnx7?=
 =?us-ascii?Q?1y1NINDBSAfCR6Dw+6YlySu/93yppr7DeSQMAElXYWMwqRiKIckmWIbYs4Pu?=
 =?us-ascii?Q?6ZUZARJfWtqncy808hDWh5pRuhx500H3e7ZPfqc4LEmr7g4/ZzGRqLSs6KrK?=
 =?us-ascii?Q?8TejCbixdlVk/K+1RmHx3BWnGmYEhBLy4Orjgm9E4woVcMj83BSpRwsJRoVV?=
 =?us-ascii?Q?vxBrWHo/nRdxY6FMM/saKv5ft6eitaavdkthgga9d4/XLs6PnlyfdHMM4qQ3?=
 =?us-ascii?Q?N2xtwzGZBbOhKUUHrz0rS3ohywLYhFKqJ7iH6Kf8okuG3VOfby+R6EPnzq3h?=
 =?us-ascii?Q?ap1vx3Km2T+gYWIjysPZ8t3MRCceDuQjBOZBXAZUWzp60GCosB4YliliQBK1?=
 =?us-ascii?Q?2UVOzKycsQTB2g9PSlKO6rRdnjj+sNAcAkMLHQPKiVYS7/0scDKYaZFEh23s?=
 =?us-ascii?Q?Jm1L9WAqIGU+pLTMRAfhlmU3vhH03NQN925YnTYNTXc/szuDDF+Bdc4QvfE9?=
 =?us-ascii?Q?6tbWmqEWO10tbMhci6HXvxEZr7p3cQPNrSPNu0stjFjE6TRy5QqAr21h+6Dj?=
 =?us-ascii?Q?AU65HR3tcve5CJFhRqPiYBDwnbvx38YH4mHWSrFeey0AT4jmjdcue94g260p?=
 =?us-ascii?Q?J8Plolz2h6fqmXxpERXE3U0kIiwXVNTV0MgPzRsIM70Lh8YGFrkyNQprlrcs?=
 =?us-ascii?Q?Rgk2mjaQRZIaSeu0qMQ/33o83MxHIBGKCP38tlNzJhF/UtCmszb2h1qcBi58?=
 =?us-ascii?Q?Y3EF+ZYZBVMl31+N+eE5/J0DWl3CBvgA+kP/M3sBhGQCkYhBUzFrFA1QZDWb?=
 =?us-ascii?Q?J84XKoR/6mcsckGyNzjL/6o2GirPyJwdnpLveLZwuwcBawugMTcKe5+sStQr?=
 =?us-ascii?Q?+xuEYXNTm60Qr3feplsaA/1ZGslMJrW8/IZdGMxqXOdSjigFIKfzn25zigMx?=
 =?us-ascii?Q?zcPkfBl2ns06G77sivNEMjM0gJ8GYt+7H2R6GhG8d8kDn5VCF8EnYJ4GlUhq?=
 =?us-ascii?Q?1R5ygPii/FHoAPEzmAsxA36mg6NDi86AwhBUPr9OivlVlvU8ThL2xgFnjq4I?=
 =?us-ascii?Q?xMDrtlcHePDrNhHceegAcQzviudo9s1uy5l0ZR7GdfR7ooj3OEV7Q/dQi5Gu?=
 =?us-ascii?Q?rICKnXllZJxFUyfdasJLzZ0M1oC6cn7O54Ze1+RTFnu/oSEw8m9sMlZ2vH4V?=
 =?us-ascii?Q?VFYdENSbkwaEoWtUrSwPcpcNVr3Aocf0/2dwkW+8FXgalIBkodZjJxwfLL6R?=
 =?us-ascii?Q?RR0Lc5uv6lNBn4hntuA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14a327c7-d3e4-4b46-66e2-08dbfcdd77ce
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 19:47:13.4847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Sr6ZuSLZlWEhTyspI64BVz8ZbRMOszhJSqpI5G36lCN04JlZF8brEbQLigSIztB5wrxgIbK0l4RRvBIThCpEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7688

<&pd IMX_SC_R_DMA_1_CH*> is now properly aligned with the previous line
for improved code readability.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi
index 69cb8676732ea..453fabfd17b81 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi
@@ -98,13 +98,13 @@ &edma2 {
 
 &edma3 {
 	power-domains = <&pd IMX_SC_R_DMA_1_CH0>,
-		     <&pd IMX_SC_R_DMA_1_CH1>,
-		     <&pd IMX_SC_R_DMA_1_CH2>,
-		     <&pd IMX_SC_R_DMA_1_CH3>,
-		     <&pd IMX_SC_R_DMA_1_CH4>,
-		     <&pd IMX_SC_R_DMA_1_CH5>,
-		     <&pd IMX_SC_R_DMA_1_CH6>,
-		     <&pd IMX_SC_R_DMA_1_CH7>;
+			<&pd IMX_SC_R_DMA_1_CH1>,
+			<&pd IMX_SC_R_DMA_1_CH2>,
+			<&pd IMX_SC_R_DMA_1_CH3>,
+			<&pd IMX_SC_R_DMA_1_CH4>,
+			<&pd IMX_SC_R_DMA_1_CH5>,
+			<&pd IMX_SC_R_DMA_1_CH6>,
+			<&pd IMX_SC_R_DMA_1_CH7>;
 };
 
 &flexcan1 {
-- 
2.34.1


