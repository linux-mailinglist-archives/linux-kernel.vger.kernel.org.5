Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7A97AE070
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 22:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbjIYUud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 16:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbjIYUu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 16:50:29 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2042.outbound.protection.outlook.com [40.107.105.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A186413A;
        Mon, 25 Sep 2023 13:50:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hryn3dIzvhqiAKer7pUPLar2ZJB5LMCpvZc2Jfi5feSx6HXBxRMItOFvMybwAOIp4bhhADRZNHkc2/1L2fQK2aK4tz48e70i438hjXFUtpj6IRywDmD0E9mZAooLtp98WRCR0DuY0FFRozBicHHBZ1sLb3MVD8xL3mf5pXfHCm0KSPSe69K9CZ2wC3NhKS1Gcgk2wBXg2a5HTApJynqkjAq5j1wNo/8oXVGmaENIU/9EN9GpthTse55gbZxvSArpnvFhA9oOkGGmjduXMTm3nOpFsmHl2ILpeazfWhAKbxx5WOYlGVrsQd0irsckPnNK6XCpXI4TngFML0wXLJZX+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FOUjphlgeIv1L/dweak150OvX41e5sdXKdof8TyU/w0=;
 b=Zit4cSJnVWH+DHFKMbqdKeJ4H04gDH5Nl1HU4GpqbWkRpas3wU4FSxuj2S/fb5HitLYr9c6fDB+MhlL8TLb0wrhnXGs20B56yMUztCspTsTDdNacKdI4QNrq0m7obTq/BizuvixsVgsBbwox24cv2xJritMHr+Iisq0l7raLMLDsopjDkaykNNY4X86eGWgFdkDmr5WtW3VRiP/pF5rIn+cStWPJU0/6mPcZR7RpxVqR0AzCs3LaztFyW+56vyvppTKQVx0UHGNomfNl+LGHJ8tu8KJy1BcfZqgz3p++sXvZZEDhnsB3j2q0KzvVfLe+k0+il0F/QhAknBLmhG3spA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FOUjphlgeIv1L/dweak150OvX41e5sdXKdof8TyU/w0=;
 b=DYdv+P1is5xAM5gBHb6XKkaV/mkw5AOiBuylpChTukC/WgZD76VlfpAb/EmsIxKFJjfyBhwSIRoctMn1rtYRWDcHEnrgOIovUH9XwrfyEvRf+mf9UgybHOfq7s40chmh2/DU+cIdtnZdjWVYWQp+Z6ViWZvqLf2ijU7cHQZBpuY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM8PR04MB7809.eurprd04.prod.outlook.com (2603:10a6:20b:242::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 20:50:06 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 20:50:06 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com, shawnguo@kernel.org
Cc:     clin@suse.com, conor+dt@kernel.org, devicetree@vger.kernel.org,
        eagle.zhou@nxp.com, festevam@gmail.com, imx@lists.linux.dev,
        joy.zou@nxp.com, kernel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, pierre.gondois@arm.com,
        robh+dt@kernel.org, s.hauer@pengutronix.de, shenwei.wang@nxp.com,
        sherry.sun@nxp.com
Subject: [PATCH v2 7/7] arm64: dts: imx8qm-mek: enable 8qm lpuart2 and lpuart3
Date:   Mon, 25 Sep 2023 16:49:13 -0400
Message-Id: <20230925204913.3776656-8-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925204913.3776656-1-Frank.Li@nxp.com>
References: <20230925204913.3776656-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR07CA0045.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::14) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM8PR04MB7809:EE_
X-MS-Office365-Filtering-Correlation-Id: 8054994f-3e14-4331-a0b2-08dbbe08ffb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vKTiIGVVxuYUCmPfyMr+Ay1PES1KPS+jMJDZpnb2Oa2wigXEUbE74Yd+IgWGEiSlfSiFXolQ1uCmNAWfF8pTOduDqw0TCqKg6GPu4gPsmq4zqe1aWFJiZKTtDn+lxhFC70HT5QcRXgs9eERzYbhjcWT4TriWBZwSHbBs7ToHA+3e7C2zGw54rLiCkF1rZNjFsuo1nmpYsOqYqzBP/Hw3h9BManUBEpConQifH9gWzWF3eq5MzA07dJyL7bfhKFZ3mK5sDcNQYeTCaoNaRVotfCTpt5bRN61ZhkroKGCCzSvPrjFzVwgJ+GlEN2qpZwzS1F3DL/SrDD87tyAM6T/hx3bSwV0Lyh7nzFzO3MCxYXEoh6CGhtzBrghAqcgQfKBHGUilsqjxs0HWD6XJhYzk8dueqD4xkBzroJa9twcdiny/XYgUwwLqfU2Ix1Nvb9i+MjA4aLngLBID4wEJ1viZxxcr+4b3ZedLqW4TbpsfhW8eZeYvw8K58V69WNViIiUKCwUmsR2CTp+EZYLA9tIWYv1X17n4OJNHWQFpZ55D/Anlf7GxfHlIL9VhoZDY8PQ4d5qbtGyt58wr18eSgSAQb8OsWdYEQTNZuFL5piy8cSsUAM+NwFGh+ad4y9O6fwtRYCtQto8jL9RBwBAIYVJPjkUj9mDX7XDW0z72ulxBGA0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(346002)(39860400002)(396003)(230922051799003)(451199024)(1800799009)(186009)(5660300002)(2906002)(316002)(41300700001)(8676002)(7416002)(8936002)(36756003)(4326008)(2616005)(86362001)(66476007)(66556008)(66946007)(1076003)(6486002)(52116002)(6512007)(6666004)(6506007)(26005)(38100700002)(38350700002)(478600001)(32563001)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GrlHadu2Y8l63kr2PzGZ19qrz519vOvt6rdv+4zK1tgmmf8s149MrI+Oho/p?=
 =?us-ascii?Q?lv0dl00bMn+M2fFSbzBsU91GroMSlw5n153Tex77dlSrQFI5nA8zKMD+dXAI?=
 =?us-ascii?Q?H4h+ehozjK47Q2ICQ6360zxIWm1g4XWOWNrhJeMUnjkxExuestqIrXfZRTCu?=
 =?us-ascii?Q?ybMfCt3BhKP9gIgrMnTXC4Xt50YayF/RZm5laNBPLEuB8Qg9kR8J6/Up6UTr?=
 =?us-ascii?Q?o0sXd/nfsmZNmXaybZii+pIp4OGASHtcGAujRm2cSHRkScymPLx35y20naJt?=
 =?us-ascii?Q?aEwWl5xzURLpamsVRmkz0kTYd+RA7QhNrHErYov5ykXknjluXTBt7dtt1nhu?=
 =?us-ascii?Q?YUIhzOhrhGZtFEWtcpSJigHbY32Sh3UT4udIW/zyEkUF1g7LCg7LQv5pXH0O?=
 =?us-ascii?Q?MkwdieGXshUMhtRVZ88g0AMLL5DZLlkrHKcX7qx5wU6EfjyPNR0c7irypurF?=
 =?us-ascii?Q?yfvAecWaSEQ5rhsI3lFkr5wD+1MeTMLQh5+diXdXQlXSWZOKngEayoq+HEVr?=
 =?us-ascii?Q?CAdhGkYPhUxf+1idtsFDXPwtGQ40aN8+vouqHdsQrYsdgWJ98bD8TtTfI0Pb?=
 =?us-ascii?Q?iM+2GdMnNlun+3ck4W0YH/BqXpefup0ComA5u6mDyjYhQXgfqNPYTfZVF0N4?=
 =?us-ascii?Q?nAL+ycmrHx82zSuMJyVWf/H1UmyD+N0UOWyauP2+gsNeqh+xXF5H+8PH3IwH?=
 =?us-ascii?Q?e09j8p+P40XoXJsb5qdaQX9KHobNhYKzfCa8e2Ay16F1GOkLa2Aq88HXz7qI?=
 =?us-ascii?Q?+tq4RTiCvXtCs4tjFxGBSsr99cUdY5y4zLeyFzNtREF+PvErjGTjCIEpiL26?=
 =?us-ascii?Q?7Ywo1U/+g+WJxW/MZwg3SQkOCOTcy5OTVKuJHWvcsFUldWeYDZd6Jcs6L3VF?=
 =?us-ascii?Q?8vxniI1UsorPVMxC0mwaRz3p6pDWRop/SI66eV1Su+XyGM7Qe9tQCBi5X/1r?=
 =?us-ascii?Q?whFZy/q3BMdrdD424P8F83l0K98/SQD5eJXnzfByWBxXm3oWx3xqCyqB7qr8?=
 =?us-ascii?Q?+ooPqLkOz+ASYaNvKG1aF7TA9z55v2CVgcBkMlhfQEPH+KlEdXPwpLJKipzJ?=
 =?us-ascii?Q?62jjVDs4U3xIFPmnszq99MOwR2KrC7prHfnql30Vl6xhftOIpk9IhoWKXvKv?=
 =?us-ascii?Q?b9Jc3/6HH9wMj9Toi6Bux9iRU/DZ7h8d3EyAKyR0m6mFnJQlWOLW9BVhO7AQ?=
 =?us-ascii?Q?6DZln9aGxAdmi0xEYZaQovtz8jZhSZhLQwcSz4McV3v6cjjz30smD1Y11pHx?=
 =?us-ascii?Q?atyKfACEm+IBNdaemGc9x99bD8ggm4qgKBlxQYlfWlXQ4B9rS2lKYneOiHrZ?=
 =?us-ascii?Q?Xz4jpaNVqqBL+OoMIhe2HbIZtoMILdPtV9/vnxhck9GKVqR86Vglh9seYMli?=
 =?us-ascii?Q?tj7CzwZbbgtncX2KPCDKMktIlLzWMvzU5lu0M4xZouh7nA8+1t+tjEbaF7f4?=
 =?us-ascii?Q?Q7OJ/KUQbJWdegQ1YhsJJM3M2upDY8AlBLJZ905sz1loM9/gLBib/0ZCFPkw?=
 =?us-ascii?Q?zZWYWCyCIbjvdBKcapEs1pBWyNP/OEZONqEFPc8HZrLfS32gX8wuLsc1J+OP?=
 =?us-ascii?Q?NcNe72Su6VHoAT78Z88=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8054994f-3e14-4331-a0b2-08dbbe08ffb3
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 20:50:06.5838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /bYy2czq60MyDyeJAWMR3wPQtY+qlBkPAxtBiDffz6ww104eiDQuw3JbNSoGbzpMlNm/m+1ro+0oz1FFUwy2JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7809
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable uart2 and uart3 for imx8qm-mek board.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 26 ++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index 0b34cc2250e1..6d50838ad17d 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -47,6 +47,18 @@ &lpuart0 {
 	status = "okay";
 };
 
+&lpuart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpuart2>;
+	status = "okay";
+};
+
+&lpuart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpuart3>;
+	status = "okay";
+};
+
 &fec1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_fec1>;
@@ -118,6 +130,20 @@ IMX8QM_UART0_TX_DMA_UART0_TX				0x06000020
 		>;
 	};
 
+	pinctrl_lpuart2: lpuart2grp {
+		fsl,pins = <
+			IMX8QM_UART0_RTS_B_DMA_UART2_RX				0x06000020
+			IMX8QM_UART0_CTS_B_DMA_UART2_TX				0x06000020
+		>;
+	};
+
+	pinctrl_lpuart3: lpuart3grp {
+		fsl,pins = <
+			IMX8QM_M41_GPIO0_00_DMA_UART3_RX			0x06000020
+			IMX8QM_M41_GPIO0_01_DMA_UART3_TX			0x06000020
+		>;
+	};
+
 	pinctrl_usdhc1: usdhc1grp {
 		fsl,pins = <
 			IMX8QM_EMMC0_CLK_CONN_EMMC0_CLK				0x06000041
-- 
2.34.1

