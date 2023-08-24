Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD1A787646
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 19:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242826AbjHXQ7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 12:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242740AbjHXQ7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 12:59:04 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2064.outbound.protection.outlook.com [40.107.249.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B07DB;
        Thu, 24 Aug 2023 09:59:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AsJVrZVhAdSPnoJ9CQb/O0mfmfxkVQhUjQWn62q5medNzk9qXHJGFCJJpBNJphhNkgWxvneCUCxtMkXdYR/XCHCpm3wrjYg2XMtkRYUvigLcBbYsudPBxwU0opqzn++D/9x4aQT+E+lUHXybMQZTOJx8BkRRCXo9lfRkuQ6gMdc4Hb3+OzEOyCkOFr/optr7X56qnFGMp9PGhFzUMarCNnj1cEgn84u1dMkuGpzQOMai4V3+dDHt+OYfrLEv3LKZZcd3p2jG6Gn0ZQPkrCqa3w+bOx+DBJOa0pAS5g/RVJaG9dOS2YjlUZVxkJwJvfHK8JjehRwh0xH1R/FFJvjXGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GNHt9j0QipvXYt2hdFba2fOhwk6FrCj+3C04Yh/fvhw=;
 b=HjnLDZHk6Jy24usStUHRmL+S2I1bTfQoaSGM64nf/0bUAZ/BMwIXiFKm64yhz4QvpkTs6BYTZEOpTfJ3ptpKNIXehHsSxAGMXUG4XPgYy2po2yQ3/68oIgMB4vFRfnaeYvu1BdeXKXKsph8GUmsqpDIZub+MN6gkTwugoHPmVzVQk6dC/6y5VsRcqq4fX3h8GzWDz31Y+Xjg2+GOV6wF6jJ9dc8RgfVUvGBM95nT7RY3c6RNmNuRlTdCWW4wFro+I713Bj+2akPao+oSUPKrzswq16VxRb21EMq9wKeD7B9k66+ikiMtaIlZAwPLVZ3FVpvx75E5RIG0p6M4BVpggw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNHt9j0QipvXYt2hdFba2fOhwk6FrCj+3C04Yh/fvhw=;
 b=j4V/qP/QV3pBX7RGt9FO5NqcgqXLQYdroXy+GXPtpRffZH+vhv8+KUnJtLLAsheJXYktESTo5R8cKCt4AVZTSLXUM4hXfJfSymHKRqhgptqXKNUHhspKtNpS+wdW12FzuI1uqZ00CfSHnC9vkPLiDP7l+HvWJdAa1u/Naioyyc4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DU2PR04MB8582.eurprd04.prod.outlook.com (2603:10a6:10:2d9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 16:58:37 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8%3]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 16:58:37 +0000
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
Subject: [PATCH v3 3/3] arm64: dts: imx93-evk: add uart5
Date:   Thu, 24 Aug 2023 12:57:53 -0400
Message-Id: <20230824165753.2953431-4-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: cbb99c84-455b-48c0-3d1f-08dba4c35c01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pmipq0+LBcg3/K/UAYSlaX2zDJzxr9PRl03iJSHCWWlbK+usQGNpq6xppkZfWQ02DtcF7yuyvdfZwlhqw9JrQHfhiNEYUVEcFrL3HcI/MAufMT4WsKqKaFLKFeszxFHsaCXWO+J9253J0oYzfxZTRH/UxtDVbtzsg+zGY6ccad1s0O/LiUOCSK2oskP4tLbd8iFV2hkJpqKqk7Nfw04Q7a8JeqlFtEvNU5kMJaP3oaQqn8lJZprw3NRjxyLY3x9IglREizIBOTI1fzeS1WmAqijylZWETz+R+51Xb0NxDhNFwCD+cXILI3/ztAsUIb0/TxBwWOqyNeLN1Cwm4V+SiKn7XndHpfl0TK3lLM4fSc3gym8RaULrogH6jKvqoD1ysD23c3XgHRDxwZlVKhtupNNhqENkcTikWB/LZTI89rgmlC7JPzt5l1VuZVboucKAyDWwENpVpjl+1J5I11V75J6MPGevRAg3l3+cAJUPaCWIiALBY3GgqtbEy9qOGfu2Mk2TYrnkIgen3weuxlzdNerzykBmrP4sLPdH4nO/+crmCd4xBgy4G5/pzjMss2c4v5oVouDXw92PqA/5EvUbkre8RaZIEugfNKfdfoNrNNfuIQ/pqKv5xTwLq61KDJErMVHbvjEKF9OokilUwpQEVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(396003)(136003)(346002)(186009)(1800799009)(451199024)(1076003)(2616005)(5660300002)(4326008)(8676002)(8936002)(36756003)(7416002)(26005)(38350700002)(6666004)(38100700002)(66556008)(66946007)(66476007)(6916009)(316002)(478600001)(41300700001)(6512007)(6506007)(2906002)(86362001)(52116002)(6486002)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o1uTJpypudoFArwSYqftSujFyS7eLYjXq63r/2FX+MIPQ+Ypbfii4eNGQygF?=
 =?us-ascii?Q?wpMSk9NmjqMwFDOnQIWUhb2w81untDshvpqwOeTRF7j9ZShC8SR9uHJB3uGC?=
 =?us-ascii?Q?hV4X4towDqbRUk1Wa7DGQEQsqYuzNBnx9T3hNmfdqpaQrsfuVWMw5ZJpQs5g?=
 =?us-ascii?Q?fGaWW8z6J3KlAYUEmisp/mXQlWjgwgs8Hh6XPZnRobwlWZ3VDHOY09/mJN9r?=
 =?us-ascii?Q?Xuka9PVr/xH4DwLmxXdCENy8Iqw4R0QSgxYZebXdid/m6xninXLZ1286GIJD?=
 =?us-ascii?Q?6P27LXLC2ENrLkiU6ebNSCQR6v37/5QT0kAcxSHU5fAHMQvMR2SGzpvTt38r?=
 =?us-ascii?Q?oCybw4GFIdcIwtcMapV8oruHtW5VqXkHLOLrTInUve9L7CVXUidxscun6mlL?=
 =?us-ascii?Q?AhtTc2e2tjWDWtTqgMtpuRHYhMf0H0Og6ggL/FfwVQA83SNjdsV+BF/yEh7L?=
 =?us-ascii?Q?GY5ur3qH7icG8znVm2DUfT7jqzQVTsFjGayt6Gs0Jths41a0vUqLqW2slgq7?=
 =?us-ascii?Q?1oCuuj9li3KkI6WXB7+XCCvfxJ+8zXNLMPW/ZqBNA6wICD6YbuMq/vQuDwQP?=
 =?us-ascii?Q?G3SqKK4U9FpPtVHpgrm6Xubqpi+j32CwvO/AHcVlbJ1Xxyy6Xfe5L65GsyK9?=
 =?us-ascii?Q?8hUgN4pTcOPWOt5dkOj/IM/LhG4n+qWGUwb+/qWvSeOaFlfpoIXakXhV6G0X?=
 =?us-ascii?Q?bXLBJVHmfXDQsC+dWenZmLRf9bxlVTwLiUnMKoEhtCib7SGEfi9GVypf5mQd?=
 =?us-ascii?Q?pxSIE8UkkPjmVPPOZ0lLWfk4om7wJapnMGXEh7X7FZIAw1QzRqEkDRHA7p8k?=
 =?us-ascii?Q?J9ZL6I+gjjRCMZUfLSWkhweAwtOvBt9m8GSktbJ7eTiVLaBFri3b8Fyi5Dh9?=
 =?us-ascii?Q?ejCqnsSvHEDPgt2vw6JBgA2LWp4jktPlkcp5QF+a8+gs4ZOwHY3mhwoKR+J3?=
 =?us-ascii?Q?G5AqIB0HUpm8QSq/kdU2p4XsWKfoe5au9HzhaCiW1rSUhNB2V02vbXNPlpEJ?=
 =?us-ascii?Q?Phycx2iUaERksBF0Tv2VMyoV38V5IvG9cSa9m51PlezkCsZ9sHsGHWk1w6Pi?=
 =?us-ascii?Q?+V5YkaqyMX+NFZhTWFHLLEAA2zkH/7K7ujmDGlIawIKwMnjHJeA6FfGLrrhz?=
 =?us-ascii?Q?2spgu2/gu1aKz/8j7AmzJIX8MwmS5/ckBLWDkrh6Za1GGybsYhQVXtRYyj88?=
 =?us-ascii?Q?aU/qLIypdztBbNMmIgyO/3Y2UigUCp+vaAgV7yAG+nM8rzMPIn22F/5AUp1P?=
 =?us-ascii?Q?ZL3bkWjnJkfVTUWa+4RMteZhCU22gAdzSMigw8AT9VWBXH7S/9DwsYrjnQvs?=
 =?us-ascii?Q?mEuDEEqdQKKO/tkYxbNkO+kMGijUrg1/lNFbvWYd0awWP9M68ryMDIhHXeoZ?=
 =?us-ascii?Q?hFNise7X7uZe0boLdzcmpi+MqgLE4nXo3Uo0t1Fj3vo3DhlQGLOlHlvJ1lKW?=
 =?us-ascii?Q?rcMZ8GG+q/jtC3xu6+eJYe7TKVz+buHnH+w0FHtsnP3WlIQo70i5/D/cKZ45?=
 =?us-ascii?Q?AO6fq/O731F0Cjpn8GGh338LE5ldZkQfKUqjUTprrOEpPYXut2Ncil3jNbjy?=
 =?us-ascii?Q?NYfZpX21HKkw9+mA0Yg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbb99c84-455b-48c0-3d1f-08dba4c35c01
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 16:58:37.5338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xYi/fE3ob+phFB6mCXLQey8KhhAygznhwkJJYgDii6cqX0qdCY9FMljQjUqeO8p3Ar6IJi7hQeAUXX49+2PGKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8582
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable uart5 for imx93-evk board.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index cafd39130eb8..2b9d47716f75 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -149,6 +149,12 @@ &lpuart1 { /* console */
 	status = "okay";
 };
 
+&lpuart5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart5>;
+	status = "okay";
+};
+
 &usdhc1 {
 	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 = <&pinctrl_usdhc1>;
@@ -222,6 +228,15 @@ MX93_PAD_UART1_TXD__LPUART1_TX			0x31e
 		>;
 	};
 
+	pinctrl_uart5: uart5grp {
+		fsl,pins = <
+			MX93_PAD_DAP_TDO_TRACESWO__LPUART5_TX		0x31e
+			MX93_PAD_DAP_TDI__LPUART5_RX			0x31e
+			MX93_PAD_DAP_TMS_SWDIO__LPUART5_RTS_B		0x31e
+			MX93_PAD_DAP_TCLK_SWCLK__LPUART5_CTS_B		0x31e
+		>;
+	};
+
 	pinctrl_usdhc1: usdhc1grp {
 		fsl,pins = <
 			MX93_PAD_SD1_CLK__USDHC1_CLK		0x15fe
-- 
2.34.1

