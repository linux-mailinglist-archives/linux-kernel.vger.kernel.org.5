Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9CE785F15
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 20:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237978AbjHWSBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 14:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237968AbjHWSBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 14:01:23 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2064.outbound.protection.outlook.com [40.107.104.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B117E9;
        Wed, 23 Aug 2023 11:01:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=klJxk9MM+HEAzXZrX5T2aBwaMvW0XCG7gYzi7eOuk/7vOGQwi7qLMqNeqtDDrPc4S2IsYIWDkE8ng4nuowCwsdAVns0lfi/UfQxH2HC3BEzSLCw22hgOwd/gp9KeHQ+HatejI3zM+kFU0gRjlyxL0rPbpBP4tjdkBlDaUQutr3vrV/sNn3uG5VJI/d76Ble1GjtbQQvrw8XFzahPDCAVBIXQrsIqM3cOsG8kesdqoDq2xPFdYeFq/Nc5U53R/ckeWW8AINuRgMoMmwoIU6zsrrOyMsi9e1+RoOec28gtIuDCCyX2o8wHYyGOKNUCzGJod9gREr/NEOwTefGlolC5VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/G8Ox8ogwahe94uvel8LseFWm+oPQsmV8yeGtdKUdk8=;
 b=H9JDP4d2elG3pL3A3vYvqR8XjnOv7LoVbCvUU54rrV2gHAXkdrz2qkaP1+ekGjHm+MaFXttMAGoXo+8ScSKSd5QraBYbJ0y9aGLao1IKLCibDEyVOREZ3dEjw8bpku8eu8YDgADfyihMqrDamI48BwBm4alRJMtIRbHAPJZMZSwH+MAwl3dqNkrqCYuBMdB1+xEK85A9IaHB6nr4ICT7ctDyRrFZyuBuCJL2TflTVKLDrnjEuvN9d0NCx7NisWblXgpEovXPQgOX+MbLas9C5bEIR8Uidj/JZZaTQ+U1JmolthJM5IAzmUkfimR4p7U46dTdC3N8wx+eclDdM1wigQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/G8Ox8ogwahe94uvel8LseFWm+oPQsmV8yeGtdKUdk8=;
 b=fcLXZZsXUTblG5U9VL4/BPxsyAvKkfJDnQUaZs3F3+UvmRgWz2GIkEC+x5g3qxJ+2UB/cdUC+V9VGdNMKRp2cY9M2lkwhsq6WXYiG3lY9rLUF53oActBMlBnoOTRzAFLH47gr5XWX6xI/PMOBs/aKhlA/StfAOnEA1IPIdh0GtM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PA4PR04MB7502.eurprd04.prod.outlook.com (2603:10a6:102:ef::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 18:01:19 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8%3]) with mapi id 15.20.6699.022; Wed, 23 Aug 2023
 18:01:18 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com
Cc:     clin@suse.com, conor+dt@kernel.org, devicetree@vger.kernel.org,
        eagle.zhou@nxp.com, festevam@gmail.com, imx@lists.linux.dev,
        joy.zou@nxp.com, kernel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, pierre.gondois@arm.com,
        robh+dt@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org,
        shenwei.wang@nxp.com, sherry.sun@nxp.com
Subject: [PATCH 1/3] arm64: dts: imx93: add edma1 and edma2
Date:   Wed, 23 Aug 2023 14:00:53 -0400
Message-Id: <20230823180055.2605191-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823180055.2605191-1-Frank.Li@nxp.com>
References: <20230823180055.2605191-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0051.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::26) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PA4PR04MB7502:EE_
X-MS-Office365-Filtering-Correlation-Id: 682807af-9217-45d1-843d-08dba402f39c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tRjpvhgAovLVbcw27jrBbkxe+MbDeRuWyuu2FAfpgqkkER+Ioa3Hkus56ZOWr0jQK0W6eU5IngHpPYjnxmGTbPPafK6n3IogtdfRktgz1cdwHCg6XOPYzShAQhrq244vBpypGQOhXwoCqfbNJFdxs/y+QueYAtou7s0LOiJHEdgW8ercps1IMk7CmBiOOO7+bN3HqNnZZV1K+Y3UKkX/zjb7tyG51tUg/KDgMJqSCDCign7QeJxDUMiaIiY3MaoNRn+sBZrCbQXn+fqybAyj4t6fkf8wqnNgBLXHB5d88HvdBkKDdtCTjK27gWhe/pXEOSf2DCWsAZb1Ht2LKLTCcmXB3T1Y8h1/TGS0aWvrvtalVLYnRz7tAZzehBssqdfLdcaFE/7yQyE5kzXD2mXAKHEwf8MvPn27JE1wd273MkhZ2Kuc3YIBWB3KkzJFoxnVCNFjj4JkqylaSra71SX5NW5YeRQlhAoKeyp+/5ToGqlMS8LIXuOac12UiwJogpdJTzMQLmjSjq1T0sss1IBflu+olwXcWesBlFF0KFFFYp33s9ZKpgCjac3L8fTkbRicgfU6bG6IAgCPjeWUiETQGHitkzfeZIzHMaHijQ1g82jenBOirZRWu2suH4Ae+SEe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(136003)(396003)(376002)(451199024)(1800799009)(186009)(2906002)(7416002)(83380400001)(6506007)(6486002)(52116002)(38350700002)(38100700002)(5660300002)(26005)(86362001)(34206002)(8676002)(2616005)(8936002)(4326008)(37006003)(66946007)(316002)(6512007)(66476007)(66556008)(478600001)(6666004)(36756003)(1076003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OGVVXKdQluF63KwWXmgop6XfRSEJWJNscWJ8sa9+CM1ASQF4anW315hSTB5U?=
 =?us-ascii?Q?3APiYP/c4YmWu2ruKZmbDDJw4dQwMwqPiEo7RZNVj+HcDcKyPk4OKqlxcLeY?=
 =?us-ascii?Q?08NaecrAuC/U1vnZM076uEL+tBpzYtLL7UxIEqqADE+qdcHtNV5kUOA9F5Ei?=
 =?us-ascii?Q?WDXhYwf4y7puXjm/C1d8sTgD0bJFsODe+Jsy9phkIWeLNzBw5SGEPVbj+jx9?=
 =?us-ascii?Q?MdATgXPi41KMUF9r3VP5+kvHbchscG88DLuTwGh+abcg9Wf+m3SeJdr2AsbX?=
 =?us-ascii?Q?JpmxWMlRSesh0FarLf6tVGNjZRqcN6PXnuLJ/LrqCaHLpk0Yl9/OF+RzJP47?=
 =?us-ascii?Q?y0c628v3ba/gnYbrrkPCjkbeyqF4YmshCF7Lj33S9JuhmyEKhnrQy3t9afJ6?=
 =?us-ascii?Q?qgxWhKNED0GQTv4Am30OyjZwL9uqAJtxFJUWyPcktQeyLRfodQjcbtcyymEd?=
 =?us-ascii?Q?66TIseq0JE/rueHXRQ2V3VNQqjwoZmB2S5Teywb1WnCj2BT7ObKaTeOZz6vO?=
 =?us-ascii?Q?pmOIbfdqDcFr1c+IFVvKNS3rQxm/FBB9p+sHKQFk+zVHYHB6+8DbTIVMkB79?=
 =?us-ascii?Q?5lPB8J7uMSM5vj3dKG0xk5lNIo+d6NRSd5kdwzw8H91N2QNvHAfoijoyeI8U?=
 =?us-ascii?Q?FhoKSq0gz/YevUFfl6uq4XJrMo/+DDMXLvXRrpYZ/k6wiE7KTvAkzn12+Dg1?=
 =?us-ascii?Q?RME3X4tBIVCOT98OqYC/om7tJHVh7AVYH6Mv0JTomJmiZsDIMXuOnScyIFNF?=
 =?us-ascii?Q?wIZ5D4HQiu9FUasOCOixlIy/Z1G7biz07H2kUSeRMY+QcwyK3DVoj41dkNOL?=
 =?us-ascii?Q?cM3wKYQCLCOxYvFR6OMMnzF7dWqMha5MKh2FUFKfXE1zthz/iLzaGxjKdn/2?=
 =?us-ascii?Q?aa2uwoiE8iYs19s6jUgS6rnaeCZ2uJcWtKbJcm8lv79xWghbR1tfjZpCOCSC?=
 =?us-ascii?Q?C1Pwp1s0oiI94kdJvZfbrKM8x69MV4PE+5eWzTQEk93UzA8JkJCzqvQQ+oEK?=
 =?us-ascii?Q?vRE6s47+2yFG0SblF76EGKlldo/+sXiZbhUlwmYTJlOpwEcZywLT0lKW4DpA?=
 =?us-ascii?Q?t9OQt4wSZ1IGwdH1kEggFPE06jSnnl9BQsdNFQnQ88LDopVpHgHeSj/H2l9q?=
 =?us-ascii?Q?Q6fbFNQFfJc6YpHsOKtdsDgqkhURPMOa8qiIikDEoY5+O6za3RLhTz5griE6?=
 =?us-ascii?Q?NaUc78vEvcCKicPpTaGla6ZZ7qua2c0jAX4yN+IMJp/EI5nS+8fHQakJ677x?=
 =?us-ascii?Q?e3BMeIlhoaGLs4frTpJMu+95YIjHudqo+nKz9uZ18ErddNbp1n5M+UldEwfi?=
 =?us-ascii?Q?vf6hKgl0fIZwxlqXxA0jU0Vbricn3rNRDEWkRHU7/l8dsLzXaA1RihOPq0F2?=
 =?us-ascii?Q?TBgbMQe71GM8NYs08EKa26TR6ppFORy33cDTo1qCYcvzm9nBOUBAsmVsetS2?=
 =?us-ascii?Q?WoMav1yEZMofOAOAPPdK7Lu8lHHYayqhAFdmROAeQ9Rl4iscUgH37LruMMWm?=
 =?us-ascii?Q?oR9cdcvC1neetsU2hDK8PirD1aTNKAO7y63YRuKa5JdpqkBO8ptx9gYkzmKR?=
 =?us-ascii?Q?Wu2xN+t3O+4lqiZtTQA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 682807af-9217-45d1-843d-08dba402f39c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 18:01:18.8812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oQ+ZLEsqtPFGmm9MwCEiARuTyW5U4vmuhZiN764aSSpHSst8dI4sr072hxOcf/udl85d4g2R6ydFvFn2R+uoPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7502
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add edma<n> nodes.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 116 +++++++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 6f85a05ee7e1..acdca18673b7 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -185,6 +185,46 @@ aips1: bus@44000000 {
 			#size-cells = <1>;
 			ranges;
 
+			edma1: dma-controller@44000000{
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
@@ -423,6 +463,82 @@ aips2: bus@42000000 {
 			#size-cells = <1>;
 			ranges;
 
+			edma2: dma-controller@42000000{
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
+				fsl,edma-axi;
+				status = "okay";
+			};
+
 			wakeupmix_gpr: syscon@42420000 {
 				compatible = "fsl,imx93-wakeupmix-syscfg", "syscon";
 				reg = <0x42420000 0x1000>;
-- 
2.34.1

