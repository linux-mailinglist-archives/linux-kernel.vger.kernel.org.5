Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B2378763F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 18:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242818AbjHXQ7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 12:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242928AbjHXQ66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 12:58:58 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2064.outbound.protection.outlook.com [40.107.249.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6893D19BE;
        Thu, 24 Aug 2023 09:58:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sv+fwJW3OJ0tJjoRdRX3xFbmBIpZwCKujsktRT5nu6nE4+GV+27gG3StS5++NKKa0i26IUNru4yVVCnP+Dolp0e0w39MM7N53asLDl75fy0GBq+b/40EkT5maM2Elz9dX3tQYSFj/se77VhXA0RS9ZFocAvgR9fu1VaciyXnFThwaWInSjChc1WaTMiYcKoa5ujxDStxhdyq1kwRZXeP9vKodAlpEnY9Jc5mTmOBDVd2ZseXvY9BUkefXW8K0RH/L49DUAJ2b5/xBzs/vyvwQoI5ZOdGjE2oHAfEf07OtxhX8Z8UEsP7pf8x7tr2xdgJumhUZH65XxRdTWWlB073jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kr6KN3WuxY6apVm5sO4ELb9ssobql0lKFuAnPbCezCw=;
 b=XPvTxwjJWUUw/Bq33gqlZizD0em8rbsCvCcIO8aANeqnHz7Dxu6eBc0Km/mQ97atjThcXWQOElp4iMdmWXjqodKXKowIMkoKFYYJ27CnIxgd6vQ0mMbEKsRYFlh+0o8ApF1ckmrii/ZtGkTo6ad1911uS1dha5t3gczpKEMlrrmfb2O4Aoz5+BkXycyNKmDDnHU2SYgdzt9kT/z0/s4O2p7IJDGbzxCK1D7p2wvikTfw/w1sgAHza0TtDbFsQIwP3L1tmxTG8Lu3LBDdpZT+/mWGKEu0bIHiYQEj94Pp7EexP31bH548hJpb5YEqRaSBwgsTARsjNk+jDu3RbA+RlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kr6KN3WuxY6apVm5sO4ELb9ssobql0lKFuAnPbCezCw=;
 b=k5IzyED6gWFfMjvzF0AH2Q1VajkHZM5ZY6lVrxKf1nHiCM28cemZEmwWXM6drkwBjje49Qde2ePXquyIMml0XNzRlOtAmgQqneSWqS/5g1gmhxyETlrYHVjNdq9GWbvDrImKe6GhkAIDVNIrdkW6dXv5EibzKZ17MrlKCc4jwmQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DU2PR04MB8582.eurprd04.prod.outlook.com (2603:10a6:10:2d9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 16:58:27 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8%3]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 16:58:27 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     festevam@gmail.com
Cc:     Frank.Li@nxp.com, clin@suse.com, conor+dt@kernel.org,
        devicetree@vger.kernel.org, eagle.zhou@nxp.com,
        imx@lists.linux.dev, joy.zou@nxp.com, kernel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, pierre.gondois@arm.com,
        robh+dt@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org,
        shenwei.wang@nxp.com, sherry.sun@nxp.com
Subject: [PATCH v3 1/3] arm64: dts: imx93: add edma1 and edma2
Date:   Thu, 24 Aug 2023 12:57:51 -0400
Message-Id: <20230824165753.2953431-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824165753.2953431-1-Frank.Li@nxp.com>
References: <20230824165753.2953431-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0052.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::27) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DU2PR04MB8582:EE_
X-MS-Office365-Filtering-Correlation-Id: 877bff7a-72f7-4884-12b1-08dba4c35628
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YcYT/8lYlMoh0aNNZXAX6Lq+AIBx36LulUbTBThmsz/POj6dvcdABIKBT93YnYZJzeAEU8ZG+70vNZHbB5iyGJqkNECwqxa8dvyMKNQzxifnxqFr7Dl4rf6Tk8+vWXJqLZc0NGhbCymyi8/rN1gCAvgJUgb2R64i9nWtmUG5Ayw/oQydkleAT3LhdgqBmft3mARN71XNMuw+v2c6MEAs//4fkyNABfBlZINOa3sz0SA2QrrX8ZFwQMZU6aNN7yP89hwaErKjhq7DAHCKGUwe04sLU0xxuBnueMPW7Y7a3gVYlgKkY/3MDTh1D7HTfH5fdNosAlD2t3TDXJi8DCYVd3aL7oVsaHbeNjkkydfRbv5F20ubIF4DJPVURXQfCRBHYX4Tdupz0U8pPSDf+3jDchqEOqgi0SLIxqgPQkiaZ6RgtwW/t2bH5gdKoZrg04HegyOr1d/TQPxyZFntxR/YfEbROzAwwcmjnQIa2vwL0/uEAk3W+fUHqvdA7yzwpgs+G7yl8NRA8cT8KGx15g9BjBDsPrr+Kosjrksc36/+sl81nfKm4B1l+MAgvZhWgN8jpBbEyxVQz8qzxJ+6Gclmaq8po7weNReIbiMGLxCmA0I6Kw2DcZzYx/4D5hd1thjo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(396003)(136003)(346002)(186009)(1800799009)(451199024)(1076003)(2616005)(5660300002)(4326008)(8676002)(8936002)(36756003)(83380400001)(7416002)(26005)(38350700002)(6666004)(38100700002)(66556008)(66946007)(66476007)(6916009)(316002)(478600001)(41300700001)(6512007)(6506007)(2906002)(86362001)(52116002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JtEMJj1TRpyfpzcpIWQ9J6ma2EIBKfls0Z37lDb4MZaWOVm6VtAK+x4Roltj?=
 =?us-ascii?Q?8w8vuqpGlLE682PiiPUW9GwCthc1EsO8m2KzIaQ9V1MUcWQ7GRKKJ5HZROPH?=
 =?us-ascii?Q?9Na6fDvlDq65/optfFvbaP9e0dK4JHhyHdWRfoDDlztZH5xNTaBqfepdOa0s?=
 =?us-ascii?Q?vYICkLJECh4zOPn+k/WG4iSJN+hLXIpMe7btijq4ISn2uu4IP8/GFOR9xjvG?=
 =?us-ascii?Q?tuShnOYLt5mwWpfE/DmjxJc7APZRQzZBYelSEwHG3dXRpgzFm302wk7FHvZI?=
 =?us-ascii?Q?xxLajfI3zNFcTbFXy00i4admSlDbNJv8SGh49KuIW8eaxVA2H3mi0tL/fM9k?=
 =?us-ascii?Q?l6lkkxUCRCBX474IDjACVrPKClIPzbQrp9i7+/XMQk0BB4lVo8ic9dfzpne5?=
 =?us-ascii?Q?H787kcajeZ6onuIhpUrwkBGV+kXl8EG17v42N/f5yXN482675G6rHfNYLEwS?=
 =?us-ascii?Q?hlLjKsVDAMErH4TbSkIZpWpj3LsnzEGWYYXL+oIaV1ySL4tCjHFupQkWhfA+?=
 =?us-ascii?Q?D1dvKsMUw3MfPLstSngePVylfoLZ6qSJ8uKZ3pus21xM9bIWxfyo64eubSNT?=
 =?us-ascii?Q?4oLk5Gf30t9gwab9LNOfGE6araWK4CaLVroQsERTzNijPD2HpOauqWitg4+p?=
 =?us-ascii?Q?1cR5eOJA2+MgJX1ybKiBY6ViocBLd4hSW/nQkn3bwHG8Pl3aKTV8hUByT/Db?=
 =?us-ascii?Q?xDGbQ0c15YbD1Sx72/3dGi8Kb9CB90h9BrxJZpS0hfJZzxasv8gBM4r0ddsP?=
 =?us-ascii?Q?lqaUCQJMmFgeNuDzie84Xb07ocopUaZgkmg/3paXyVIYxAhrJN0C9Oj6nf4P?=
 =?us-ascii?Q?hoOItUeCYfO+sowT85E6KrVcBARHNNW7KzJL2IWpeA93MGvBvgxY2ZgmV6Ke?=
 =?us-ascii?Q?LKxkjIBNkgkewAUWjiw//OQIDnhqvOcC8XrxD2Cit8HW/E/FNU0zfXutGp1B?=
 =?us-ascii?Q?f5bVJyaSi0D2V+o80NOAzJIzOVS1jTJiDINKRwoy7KAuqlshwzeDxJTpoCqg?=
 =?us-ascii?Q?4RPI4QDffsAMfHCi6EyCVczaK+lpD501kjMkk/sDJA3HIwQI+nD52USh7xh0?=
 =?us-ascii?Q?Wj8Wit+vpGm3NTcoq1yWGGpqNCWIzK7rQGLh/jYpH59BQmsmBZxN44F88L+z?=
 =?us-ascii?Q?rHhXoaj98JX6OjDYicD8G47hc2wGWc1h/+mpGy+j7i81Gg+0mmIuz2TWMBRe?=
 =?us-ascii?Q?ZAbbFFR89f4DEKva4Ly0rTvfxAtOfwhgYPOZtNsmDBiohuTyjz1QuTMdZJdO?=
 =?us-ascii?Q?QrCUyZIkHCYeTP8+oiJfJ52xve6B0cm+MzPC2dJelK/fdnkFJikSBuWnHl2p?=
 =?us-ascii?Q?i3d4UJQUd0UiaiSbWVRxvAnu8ZYIa21l0JlicW8+rDuhyBcXCBdOINpgS1ut?=
 =?us-ascii?Q?Shn035LeaX+b9idCOzPdjVWcnX2ej38+7E49TALPA9B7d0RUCAng8Rp0iLol?=
 =?us-ascii?Q?hXeER939HGWXje4BsBnPVwAuHw4OsCjITahHVg8iduCzvoC6xINVFJak9LOm?=
 =?us-ascii?Q?tYsqME7R4YHdPfVolxdU9Ur3l/2a9BbnRZ+WPRi22rsmRj6BipvyqsxYamoR?=
 =?us-ascii?Q?6KPNjW8X+UMRlushYMU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 877bff7a-72f7-4884-12b1-08dba4c35628
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 16:58:27.7780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AD7OZZKx9ocFnH9EhoN9OLAxtUYshaEkXG175ohArrfsLUVAj/Up4STR0BanVy07C5Z+5KK5QmHOxBcW6odTcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8582
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,UPPERCASE_50_75 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add edma<n> nodes.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 114 +++++++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 6f85a05ee7e1..22f09203c767 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -185,6 +185,46 @@ aips1: bus@44000000 {
 			#size-cells = <1>;
 			ranges;
 
+			edma1: dma-controller@44000000 {
+				compatible = "fsl,imx93-edma3";
+				reg = <0x44000000 0x200000>;
+				#dma-cells = <3>;
+				dma-channels = <31>;
+				interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>,  //  0: Reserved
+					     <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,  //  1: CANFD1
+					     <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,  //  2: Reserved
+					     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,  //  3: GPIO1 CH0
+					     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,  //  4: GPIO1 CH1
+					     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>, //  5: I3C1 TO Bus
+					     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>, //  6: I3C1 From Bus
+					     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>, //  7: LPI2C1 M TX
+					     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>, //  8: LPI2C1 S TX
+					     <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>, //  9: LPI2C2 M RX
+					     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>, // 10: LPI2C2 S RX
+					     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>, // 11: LPSPI1 TX
+					     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>, // 12: LPSPI1 RX
+					     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>, // 13: LPSPI2 TX
+					     <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>, // 14: LPSPI2 RX
+					     <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>, // 15: LPTMR1
+					     <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>, // 16: LPUART1 TX
+					     <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>, // 17: LPUART1 RX
+					     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>, // 18: LPUART2 TX
+					     <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>, // 19: LPUART2 RX
+					     <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>, // 20: S400
+					     <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>, // 21: SAI TX
+					     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>, // 22: SAI RX
+					     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>, // 23: TPM1 CH0/CH2
+					     <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>, // 24: TPM1 CH1/CH3
+					     <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>, // 25: TPM1 Overflow
+					     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>, // 26: TMP2 CH0/CH2
+					     <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>, // 27: TMP2 CH1/CH3
+					     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>, // 28: TMP2 Overflow
+					     <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>, // 29: PDM
+					     <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>; // 30: ADC1
+				clocks = <&clk IMX93_CLK_EDMA1_GATE>;
+				clock-names = "dma";
+			};
+
 			anomix_ns_gpr: syscon@44210000 {
 				compatible = "fsl,imx93-aonmix-ns-syscfg", "syscon";
 				reg = <0x44210000 0x1000>;
@@ -423,6 +463,80 @@ aips2: bus@42000000 {
 			#size-cells = <1>;
 			ranges;
 
+			edma2: dma-controller@42000000 {
+				compatible = "fsl,imx93-edma4";
+				reg = <0x42000000 0x210000>;
+				#dma-cells = <3>;
+				shared-interrupt;
+				dma-channels = <64>;
+				interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX93_CLK_EDMA2_GATE>;
+				clock-names = "dma";
+			};
+
 			wakeupmix_gpr: syscon@42420000 {
 				compatible = "fsl,imx93-wakeupmix-syscfg", "syscon";
 				reg = <0x42420000 0x1000>;
-- 
2.34.1

