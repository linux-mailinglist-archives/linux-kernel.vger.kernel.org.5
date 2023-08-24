Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4892878759F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 18:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242589AbjHXQkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 12:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242596AbjHXQjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 12:39:51 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2085.outbound.protection.outlook.com [40.107.241.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36114199D;
        Thu, 24 Aug 2023 09:39:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b4BTRXQL0iwlyAsDpdcHuJH5YJnIb93cr27GDv/xjM5ovVSCoUgT9QB44f/wWFocn+TTXEF56VIfGz7HOuvKpu4epWSA5s9D80wdgNC/dcZzQ+sHU/KqVN42APpMZaBl0bo8YqLxN4wXm8/WMX9VgefU2d0O46BYvcEaBW9Icu+mWuzISwpmzZGboRdjntaiJY33uT2pZJt2BIQomNDWeYJLehLpmt/l4aTM5b20wHS0iATfXSoPyJZ09O9Sa+ODBPOt4w3ffa9+kJaQ3L6MkDJtveNi/V/Hk/dwRFcqsi7/obRn38exhIVoNOl2NnvRf3vVI3Ozv7p/sX4OQlsHgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/G8Ox8ogwahe94uvel8LseFWm+oPQsmV8yeGtdKUdk8=;
 b=RAzrSM82WI0msZ5lZ5bbEejlgbj1l9QRhpjus8xy2zNcLDxPQUtTza77C8pvXT6+pnWSEcKzKBA8svdZqg72tKfkifjeNmlmMBuJbQ42K1pLwwq7JGYzB+Sp6k+df/3ZGy4owUMF/bnpk1TIQxD9pc1vjRi2btlY7OD3i6D2ULZbv5s4An3guVn+QKb84li3dbe1OKtIr3mT8gZRALEkyTQsvILMClrZojlrb4jqJy+zLiuDrSSc2mTY2c2pm9ILJBwBEwkJ78/7DzMtwyFxA4d7WM/413zxfSsMC3SepsxKyet4ar31c8QyYbghFhZ6T8p0P8HCu6UUsP33G+KQOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/G8Ox8ogwahe94uvel8LseFWm+oPQsmV8yeGtdKUdk8=;
 b=pjd6hszvq7lD2ZkM1XDN5gFO4t0dKj445h3EOSJZvFwahTlam7wiI+yqdKzpvpE8pEoEHQeyGTjBArIDOB2HipP6orUhid/lfdY2PFpjd77xwHScnRZpXQLrkts9NXsNH7Nv2x7wciWfWpr66fogVsHGcJC1z2i+k4U4gAIPDII=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PA4PR04MB7517.eurprd04.prod.outlook.com (2603:10a6:102:e0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 16:39:46 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8%3]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 16:39:46 +0000
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
Subject: [PATCH v2 1/3] arm64: dts: imx93: add edma1 and edma2
Date:   Thu, 24 Aug 2023 12:39:18 -0400
Message-Id: <20230824163922.2952403-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824163922.2952403-1-Frank.Li@nxp.com>
References: <20230824163922.2952403-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0198.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::23) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PA4PR04MB7517:EE_
X-MS-Office365-Filtering-Correlation-Id: afee0aa2-8eec-40ea-9218-08dba4c0ba0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2U39D5lP4xp8qwt5DTBuWI+CILo7W42kSeMckIZwsb8k66unJ1K6EHO0L1zK7ZhBdvOlLE9ponnXqWc9TSNX6PoW6ttML2M5fkwcyVSeWLuoIw0LFg8TBdmy3DoRczfxxc6Q5IC22YsqeqOYgD/QrYgIXOZ/+gUqGUvYEQznHIxfLVE/Srm5GQha0c+NTgiYn14gYQaAJtFvGLZIiNLAipLxqm562NuJG2XYjAgbzMGS+rsRP3Lc7TxuXJA3i3ve1hOY7E7kH0PrBBq153EQftscAdmAL+gyoG/D0uUjFSnJCp8dQ7uyWgLQT5MXjYmA9rZjrpXjf96u5JvPbqdw/LyAOySeeaGOVNPJVm1Prx0LEomdzvZFl+BdlBiBp/wg//dNnax/DKS0bYAtAcBmw7PhYmzgygBu2qeWI+CodrEfbTqIAiAIWgeAplX9w0Zej+7fHm3c24Vvnt3qfgHXNPvBGJbCOLePoVMYzOIjCEvP+FDxQRdfELG8rPJcVgg3J34mUlEMgq1M9fyeqEahtI/sIBCxTbCPVL1tebtdNFUnITkBQuFXg09kKYObxFgohH39UMfAGSYhzwW5N4aSik01L2DWO6NTjYl3HLpJ+zhkc7OB7moYt7tiTw3C86eU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(396003)(136003)(346002)(186009)(1800799009)(451199024)(1076003)(2616005)(5660300002)(4326008)(8676002)(8936002)(36756003)(83380400001)(7416002)(26005)(38350700002)(6666004)(38100700002)(66556008)(66946007)(66476007)(6916009)(316002)(478600001)(41300700001)(6512007)(6506007)(2906002)(86362001)(52116002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f8eI19Uo3cQfi/7P504VCmYmnwueeb0kAMasP27HX547iod8fMKzyRjac76l?=
 =?us-ascii?Q?l2wg66h0GF4gCdcZxLYFn5aLIZO8ygWvLccBk6ilHLJHrd9sYMcBtMQWdJ/l?=
 =?us-ascii?Q?gdRslv3/RGgHhvQRHoaPC9+hzlIoenTaVfE6lL3rj2ZTIn8SJHid+Gk9ZZcO?=
 =?us-ascii?Q?6xicJdPg8Z2RhugXLZrqS0w5wUDl6eTDkRF+ItVTEa+WER1pjTE89v7fVTf+?=
 =?us-ascii?Q?BJGIzmAqEcg7T60Zquit4q8NFUJdBbfPdB9lzbqF5s6pnYhViKyKIyRqMmth?=
 =?us-ascii?Q?a/iqvqWBKDa6pLtSmRbstc/t+c9PB0yPgGXx42/nzvl5Y+NnpJJbtpYnYwPi?=
 =?us-ascii?Q?T/vEYxO4guvzW/qfO40BN/zmJcAaPI+R3LZEEpgdUOcODAupju5UXYrExr4N?=
 =?us-ascii?Q?w4EPNSAn0eZdQue1bTRUzFBTwIzmVV4GznaAT1Upt/r3CCRyl9VVLaLPvvtW?=
 =?us-ascii?Q?1cVLOwrWqiwohnTb601Y97L+we32SzlFJtawi06x/t2Ar46fYQQr11/s2KpG?=
 =?us-ascii?Q?TnRzUbCaWCH2Y4VwcdrjXMmtHN/TqbEiwZMZEHYzFAKvtZR1a6csbD3wBpZc?=
 =?us-ascii?Q?SpFPjACTgxk9HOPXGhn8XCztt/IRpyhekWKgYY/ATCM8trR0yXDxsS/o6Uve?=
 =?us-ascii?Q?PLR5VoJz+i/S6TLOIKDz/0PBb0f8q+/1/jH7f+/WCIOHfALhdbCthCcVpfLd?=
 =?us-ascii?Q?a9m5FBKifhJQsA/C1U4MzISlcKHJlPe1TFGd5OUIv6o/KhAdssJLj01QpW6u?=
 =?us-ascii?Q?oGKB9Z7sY2e/Oge96Lo8vpwp0KNPgALzUbcbubiho7fXo6/8YdEeXimbXQKu?=
 =?us-ascii?Q?HAQXC5o2XEu59in+siPLkQx8DiW+84FTz9BIz0/BiAr4q5Uj/jZIpmaMtc/q?=
 =?us-ascii?Q?WD8q9nLzOMckW49daDICbkbEGYc4K63hfjmLbiIVrI2Lh2SXs4u8Q0/slgu/?=
 =?us-ascii?Q?BC5+YuShvSK5frlwqkCAEH9h2zWLXutXR+HtAGpUjGwryIGxIt2qWKVwUqVe?=
 =?us-ascii?Q?U9JAqnNezKW2nXGiNr+XZBto88SpF7pNeDWcYTgFPhXThbmvvJn+4/7rPa6k?=
 =?us-ascii?Q?+RKjVrrJpI6rb0Ae9mm+NzUkOtW/PNkHsVRK3K9l5VoZ7mwhb+R+Vo257Gbu?=
 =?us-ascii?Q?0xYtvK/uvMFe9w+ybEHkEvEqWjkuBzlTpXn5BcfPVSi5wguT9AHIP1z+ntaf?=
 =?us-ascii?Q?FL2/WmYsJd6V0kHD9ntGCjfpsZJzmNWcQdA9fxA9rSVuSEQ9mDPtUhVLnEGk?=
 =?us-ascii?Q?FIIbXYZrH2dF/Niynks4w38m7YliWGjO4AccasI/YraQWOj3TOG/AZ5Q6P4B?=
 =?us-ascii?Q?qX57JIigBGWih1AqPRgO/r1odz/InATKHY7EZ6nhv0qlLLlS8148WY7+iY0S?=
 =?us-ascii?Q?Y74KwQ674fEKPrfRUzCJWCJ5BVYx5Z5Yyvltg8m9q6PRZw8E/JMqCtcrISRZ?=
 =?us-ascii?Q?6h/Ex5jawc2olvBZ8XtughBYqGD/efEDaiKP/NUFbJNqNKGckg5fgE2JnJFa?=
 =?us-ascii?Q?ShtMQIR+nc4pUkQVtTQsGo1WAxb6KiIJTQWa4ErsFfoALbEeH9s7QdWFun4b?=
 =?us-ascii?Q?YgLpog+kKzPyxgSCWcAVFzHnIyraEmdTp77xir5q?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afee0aa2-8eec-40ea-9218-08dba4c0ba0d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 16:39:46.7442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lPWt1APhrj6Ku1LQVvzXN1rDmSRIgQBDpT4BrHB3skmeC/Flq62aAUUQy/0RXen/K3/i3f5RTsdgx9mQNGYNHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7517
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

