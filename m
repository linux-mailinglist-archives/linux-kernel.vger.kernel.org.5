Return-Path: <linux-kernel+bounces-28-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46853813AF9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 20:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C44F2283151
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DCA6A335;
	Thu, 14 Dec 2023 19:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ArcJ/5xY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2058.outbound.protection.outlook.com [40.107.20.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF966A008;
	Thu, 14 Dec 2023 19:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gv1YqlHF93//BQAR62UnyC5cIJYvNVmRXs0X59KJXhn1N+8me0ACMYvYt04ub5cRgEdT1fidJibueh2/Vpv4vroMPuzGzGPKqOknIhSvHVKOEQTDGxXeW4868yskRS0TQAlspkzgAaCM3cvbS24Tb4fxA1ZZPgOr/S58gSgSb2tAZsDLIRfwkgWTwiDstGYy2WNvhkuYLCJqvRSwMPsJi5V9AL+nBxtWojbwACMtzoJG9dXGIbuoWVvfxzSWbnvSBh5fd2rwNX8UlLQcvhPdNd50vmuIOuhhlAPqtYX1MfAUaGuH+b+4+sXfeqB36XLILFDIRasb/VwvjaXN/vsqHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SMJ/SYq2xgdNsdWVEDuvaK7MGok/qWL7VOslVxBsHLA=;
 b=WIDL26+RbS8TNbxAkblN7B3am4Oa1bKxppztoWEiwzzK+fGmuuLs2lEDs1os4NSF7w7vTXXiIsdt7rO7QsF8jCovANwELDpFi52v5unfOUd4Mz8D1vr1kVBtYJN2Cu+4u535nfii2aji6kRjkho7E17X6geBk2gcoVezx+xokX2DMHXX9/4rt51VkwHwYamBX8YZqyFtFIH8+ZqrumPPx4E2yr7fxLi1SJ5+jldN9GpcgMnjbVqIU5T0irUX1tSvsRDXp2PnGimH5g5gzBAhcmyKn/kUlP73PibXmlst+0ANoWyhCor2aVcSJn2YdEWpN4loton8lNS7SxSuqLo2ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMJ/SYq2xgdNsdWVEDuvaK7MGok/qWL7VOslVxBsHLA=;
 b=ArcJ/5xY49Yii9HxUWFg7KgPw/iRxf3oOfg1xSUfVj9gaKUjToMm05bbQS9HGDcU9m9Cnc952YFdLCoWWA7pjKIgacdMNDiynHxpYaRHt75SpyeHw1DyMUbJyfElMntErv1UqpDbrmSaYrhx+9LTN587HdHy7cYCxH4EBTvtHMI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB7688.eurprd04.prod.outlook.com (2603:10a6:20b:29d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 19:47:17 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 19:47:17 +0000
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
Subject: [PATCH 2/2] arm64: dts: imx8qm: Correct edma3 power-domains and interrupt numbers
Date: Thu, 14 Dec 2023 14:46:55 -0500
Message-Id: <20231214194655.608902-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214194655.608902-1-Frank.Li@nxp.com>
References: <20231214194655.608902-1-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: f956f697-ff2c-4ced-ac22-08dbfcdd7a3c
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
 ARt0NuIfW6FqkSEEaIWZDt2KRoqC7EFmWojnO71CoTAYI1+EERrwh7rurflcNFmASlpy+95DuirTcBWcPwIwTDtpzGqkyXjUiL173NhkdmWw5nai0LYaAVqMIkU4sdl9NRzCRLb3hTYZpzU/LH0gzSJgALAq/hGHUXsQgxy04ORylBm3DpWY7nQ/2UZJa3N+mi0JnM2MqYGVqqZY8x2lgnD/vtLpMpsGqpqhRyaBFgWSY9Er366KEJY+NNiPPA0KBij4Y2UfTvDbFlS1A+cb85rzwoOUYGIKIjcoQAvkvxzujDELLmlsaG97FMcodfSMPeo9CcKuQg8RcLalZc8Yw1zBImZw/COQar7efSBD+eVfE7F5/TaSvuhSSsr4A0CW0HoXQnCwSWyQY+mn+iZVXI3yS/VO63dnJWTJuVE9wCPRmqel9Ruab8AU4IgH26Y59e0O7UjTIq1E1mvKnIzSek4DQBTfUmyBYIlTVOmmDRy6gv4BBo7mItI6ThSMr3fRWCswl5N2oFceBqQjoiLr5YJbfGCLsNTYvbyDuGcWZMXiAi97z1iQ4qsJCQKyqqFa18bsS4eXJmMcetXXHg6am9B7qfLDYgO5pZMGglkFmuXjWwA41OnHYYM/7uJxK6X8L9MwE6EH/PLOE4X57tSMuA==
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(136003)(396003)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(83380400001)(316002)(4326008)(8676002)(8936002)(6512007)(52116002)(6506007)(66946007)(478600001)(66556008)(86362001)(5660300002)(7416002)(6486002)(66476007)(6666004)(41300700001)(36756003)(2906002)(38100700002)(26005)(2616005)(1076003)(38350700005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?24evbQW541rN0z1AaXgm+j7CGzghF/kb4iygZ4Ruu8A2MQpfx7fOT1srpHen?=
 =?us-ascii?Q?djVSXlFcXXCl+6sP5f+J91aYxrx/uxwyhV6gft+mDsTlPAIT/fL8qgkMErXe?=
 =?us-ascii?Q?CVvc7xum7HJGti/onmrnTGIRhKmCqe++ppr3UTTGBwbEEfZEYsLKa7H+DwYs?=
 =?us-ascii?Q?PVx6RRvqCmSecVQK9BBOzeZIsKngw8ZBLJRlKUnS5tBHotDYVF0zbC2bZACK?=
 =?us-ascii?Q?LrDc959NIqXXJi5S0UGJmWFufowpbG3PqyvWe9OOmkT/HELon6BiCJZR5jFR?=
 =?us-ascii?Q?Pg9pBXlfLYk6+7hziuZEIY2ZoPc/2qXIRqsyEAAYJvZyVTORf6gZ1CYN4eC2?=
 =?us-ascii?Q?Pj6mIvF76AQ59ShdAtkY063oPIodWa+OhTvJBuISEnbd7ZmO1i1J5xSCMm9c?=
 =?us-ascii?Q?XXpLICwE2DqRQYwTARFX4LI3Hr71IHCaUlJq4GAb1K8IzwD+IhFwCftdsHJJ?=
 =?us-ascii?Q?t5c4dC3UvmqGKTNrx12D7xlO3DtwW/7UXfxOo5HawSGGU1z82fYaMkU0QWQD?=
 =?us-ascii?Q?FHtifvMZcZEcAhLYn06RlZ3Ec5zywUvu4yRFqd0QhXU411znj6/7XnGQkKqP?=
 =?us-ascii?Q?LYozkUoHZAbf1xJSZM/DbRyDHKVTUawOudHaPUiM2IICD9JEIPsMYCEIDI4s?=
 =?us-ascii?Q?tVSE6iXy+uIFtQ2BSv98f0Y57P4vKPchqVWmZQOp1NkqBzx/ww23JEZRU2zF?=
 =?us-ascii?Q?fZqx/4hrePTtt0A4cMt2NjtCFtgyYIz8zAWM1qxNGcMwSwr+HQXjZMd/9S5J?=
 =?us-ascii?Q?1WiX4jBVi8BcEyVVFm/qpvGBQ/U68+IgfZxtjAzLY131NBrZgYE1UuA02Sx2?=
 =?us-ascii?Q?Uu8KjAlWnzD5VdV0qvVJs8Hxm69xwrkr2c/AiElXacHvEAKM3MTz/jCQVES9?=
 =?us-ascii?Q?+dVl70B3o9gS2v/SZK07ZtZtUV5MV6m17E1f0aHgLTsHVql7DrtM1wvFfFX5?=
 =?us-ascii?Q?L3WiXF4/wdCGG4YOXaPSCVMk3IHUliyctRUlwhohZPW60hPHc4bXDTXvsVL2?=
 =?us-ascii?Q?wuNFW6be3d0MOG63BviCWVuJ6hlqrUCKlrx65mNDQq+o5MiH2Qd2UySTVkHZ?=
 =?us-ascii?Q?L/hWJft3oyRste6KcV3MdHjoMKr5cSZ9COPuF1yN4VbD4wVfF4B5Ya4+t+9r?=
 =?us-ascii?Q?o0EjA72z383Tboh/a8LxvE+Xzl/P5cBUgCeQFUNJen0A8pxjMPomaEp2qCCY?=
 =?us-ascii?Q?HPz655ct2XZbz+0PgYL/TqPzmgKD5nvmBQfpgv/rz6RjozpWSP/F8ca96m4e?=
 =?us-ascii?Q?VOzCBQrmYIzVn5WZxjrkmBS9A0v5gWAyEF8BwZnUXNTrMBhsYwCjTTeaKp89?=
 =?us-ascii?Q?KNhWeLtBNN6xu9zvsyZ+y7NisCnkCdeNMTJW2an5hAcpCg5aI9elPH4zKe6S?=
 =?us-ascii?Q?L2tzJmKMp8MezQERvFvj/dxhYrKlhoZB5yv1xktuyQJ6rhCnvwUlBTmWexiW?=
 =?us-ascii?Q?Gwms/4JhcPAxg+CQ0sraBM6Y/ls5WOA1JDPfQJmr4bDSUIlETBIS5sgoNqzg?=
 =?us-ascii?Q?jI8nw7B+E6PcYQrkmWop2kkIykinS/qpeRhc7u8jaES6xSsiDP5plUvMWmxj?=
 =?us-ascii?Q?qfYg7QVItt+co8WLvy0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f956f697-ff2c-4ced-ac22-08dbfcdd7a3c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 19:47:17.3888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ebsMaeKNky7qONs2xd+SE1B47EdoKrib7vN5jIK34eMG6a7Mbw9bI5blmp98bjWpAwcOUGjF3BQpL1uZn81OPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7688

It is eDMA1 at QM, which have the same register with eDMA3 at qxp.

The below commit fix panic problem.
commit b37e75bddc35 ("arm64: dts: imx8qm: Add imx8qm's own pm to avoid panic during startup")

This fixes the IRQ and DMA channel numbers. While QM eDMA1 technically has
32 channels, only 10 channels are likely used for I2C. The exact IRQ
numbers for the remaining channels were unclear in the reference manual.

Fixes: e4d7a330fb7a ("arm64: dts: imx8: add edma[0..3]")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi
index 453fabfd17b81..cafc1383115ab 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi
@@ -96,7 +96,20 @@ &edma2 {
 	status = "okay";
 };
 
+/* It is eDMA1 in 8QM RM, but 8QXP it is eDMA3 */
 &edma3 {
+	reg = <0x5a9f0000 0x210000>;
+	dma-channels = <10>;
+	interrupts = <GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 426 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 427 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 428 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 429 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 430 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 431 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 432 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 433 IRQ_TYPE_LEVEL_HIGH>;
 	power-domains = <&pd IMX_SC_R_DMA_1_CH0>,
 			<&pd IMX_SC_R_DMA_1_CH1>,
 			<&pd IMX_SC_R_DMA_1_CH2>,
@@ -104,7 +117,9 @@ &edma3 {
 			<&pd IMX_SC_R_DMA_1_CH4>,
 			<&pd IMX_SC_R_DMA_1_CH5>,
 			<&pd IMX_SC_R_DMA_1_CH6>,
-			<&pd IMX_SC_R_DMA_1_CH7>;
+			<&pd IMX_SC_R_DMA_1_CH7>,
+			<&pd IMX_SC_R_DMA_1_CH8>,
+			<&pd IMX_SC_R_DMA_1_CH9>;
 };
 
 &flexcan1 {
-- 
2.34.1


