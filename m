Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098E57875A9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 18:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242673AbjHXQkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 12:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242255AbjHXQkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 12:40:12 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2054.outbound.protection.outlook.com [40.107.241.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9969E5E;
        Thu, 24 Aug 2023 09:40:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n5r+DTMnwWXVBaFGho/pydu/bA06G5bpUi3UZzNWkHLERXDfxnW+aOFOeH1gpftcEWuag+Ip9rswAlOnsB7dRs2gxkLRI3X55UqdGv4iOhts9RiZB7MDtayI1Ala2rT4p24nialWptDJd+ea2AwAb3RRVDLwYv/oQPq0bkoVWCJCmoGOybi5GHY1ZAdJ0J1j5aOSnIhYtdn+0PBnROJdgjc1dN0XCIxvXHRV9tmxzJ/QBz9Q9lAlo7rX7tUHE91X58/dfioQSgeAXohNFU8qzd8ytDIdmiLfjgN0zTBtc8gohq0k5bKremJrfCSUM+hF+vJOxcMwRhx5zwi2h8vnTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GNHt9j0QipvXYt2hdFba2fOhwk6FrCj+3C04Yh/fvhw=;
 b=CVm1f9KdaUy+PUBq1Ll9MDP7mtJzPzl+wFPikBAnIWQCdnN/xdrpQNZKi7rlhm1NRj5nmkB4iECMt0JUS9PK6eN5FGmVv30CMAP/LeOVJpnbrWqb9wI0BSWm+opiX0/jj4EW66c0dWM8YyaxDjcUvo5aDr7PXMvcJT98+35pPbCM71yybHo09BIcnGDith5O5b6/bawtS3Ax3n543bj+XZq6/k/lJ6TGEQ9XT7AeICV6ReIma41rPCfXu3KA8Chwompos1O1Ai43tjl7vEtndioTO7emazl+4L2bu3/iFX5Q//5nYMVmRysf03O17jbrc3aDltB8Zwe7u0pAv6jzig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNHt9j0QipvXYt2hdFba2fOhwk6FrCj+3C04Yh/fvhw=;
 b=Nqs38K2zz3v1tUMwzLaG12/9a9+aKa2eliVK1RNQ86/84KmRAbib3wsAZslJrWKzAcuTzCwvfHyyhpzKfyxHOdkCt8JXaNbXHe8UCPm6qY9J1qK3qJpxXgrS7ZL/np20YDj6rbU05y5fT74+Xuv9qYPwOYvVaUvlu7tKSxCbEAA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PA4PR04MB7517.eurprd04.prod.outlook.com (2603:10a6:102:e0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 16:40:06 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8%3]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 16:40:05 +0000
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
Subject: [PATCH v2 3/3] arm64: dts: imx93-evk: add uart5
Date:   Thu, 24 Aug 2023 12:39:22 -0400
Message-Id: <20230824163922.2952403-6-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: a9bb16f2-21c1-4f09-b04c-08dba4c0c567
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xtyv6yxvIK4MY4E3Q057n1UjQronZIYOMoyhVv1ifigpqe0zy/X80fFJbjy32Msn58C0NQRfILFDAEnlRuN+Cn7JIGc/vmV8NIF5rXi27tc3LU0ZqWfHJNVlckVpIIF0Ee3USwWN588aA5P6MxA11o3lX9z1QzeCLW1U7aw5DNhO/L4s0jb4phBidDCF+IWwTOuA6nf/aOYKwoJ0I4HlsSEJwHUYvokrP13ESl0NsJtjCO+Wwj+mxQcKuUDgOJbzJBX2+AFsY6HuFiN6WB9ZTMWNbR+M0BdFHcTGg7Nv/sEDC2x6g5LTkj3zJT1719q/dpAcXDi+DZau8HGuKQYFOinCGvjImunGP3G8ceYknkmGrUJ6zYDzaGQQytaaq3htWVbLcagZQOa3bAnWxV0KckAqYU1O7D+14y2DwCkt2ad9I76LEQ+4fg4NfAg6uxEObPbp362UWR0S9aYorLgtHmz2VX+W+PFkD6kW4bas0Mjqb9aGEx0VMKdgsl1S7ZapHJPgBk+A1PHImiWRxoWmwPYXYwB7taNY/d1ktvFdNHf0J8TFBcDfhv6JdYol6XOgmAxDh+eLwOUllxN2IipHf6YFTMWOy18wDgW0fNpKA0jI/tLb/jXyR5PFffQJp4aj5TEx/UZsi8DL1VqEEjV2kg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(396003)(136003)(346002)(186009)(1800799009)(451199024)(1076003)(2616005)(5660300002)(4326008)(8676002)(8936002)(36756003)(7416002)(26005)(38350700002)(6666004)(38100700002)(66556008)(66946007)(66476007)(6916009)(316002)(478600001)(41300700001)(6512007)(6506007)(2906002)(86362001)(52116002)(6486002)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+PrPjlUfdwzKfe7vSkVEri9z8T44AgJTar7OGQe/uFhfrzlIinVnqOHVKJgx?=
 =?us-ascii?Q?eS5SruE3tsCo4TZYzSv8ekNZFfR8qTlIIn44g33NswASRyi4zmqnWc8F1njk?=
 =?us-ascii?Q?skoNfZBc+LdUMdQHi2H1PfNi2agCoZGMV3BadbcEgV6jQTCkbT0hukgoS/jv?=
 =?us-ascii?Q?fzrW4/K+uejuNhmqNE45Le9bVoHh7QrjKmAaS4OWI9gLVEA7Q8aRAIx1EJfS?=
 =?us-ascii?Q?D3y8CfBom++ju+y/dOiiUSwlYIhnWrolTb0qaYjF1kWU6kXjsU3YRuBjwYxH?=
 =?us-ascii?Q?8166lZqNvPFRFHdTdiVvXfBkC/jofEayqApzEckrUnswxzFkptGxCpJogX7x?=
 =?us-ascii?Q?pCmJKyu4u5WjTILW/cxrAw5prFZA0u4uw8vBSyR3hi+zymEyxHKELBj7IswP?=
 =?us-ascii?Q?AXjAP/pi7Vg1EZQv8MuiW7qpplJzFI8SXsett8RNrBY3On77A3dzvL6/zOCq?=
 =?us-ascii?Q?/pND18MqP1sjfqNrlIkk8Hvj6ki1r1SHTQ5zG7GPkdQ5PA0DQ1o/MNYn2Dr3?=
 =?us-ascii?Q?LdMN4N7klDEHEG2RK7rIgUB5YHtM/cn3VZRVfJ8a96RsNRBFeQ/71CQQoxc4?=
 =?us-ascii?Q?GvygWnaZRHKdsBwT1eS0szvOGrPsegDUrnUTYGOQII7C2V8GQgGIcW8qZGya?=
 =?us-ascii?Q?IXTyKQAH23JvhnSRS4mDglW5e3nDAZow/XeZkzrLIFAlxC41zimTm+VUBNlz?=
 =?us-ascii?Q?SyBaaAtGC+KmSlhkSIS+/QBdC6Snwq5itcbUFpA8pyu5GERLQrDSpBu8L8Cx?=
 =?us-ascii?Q?wHtmAtLbfmBoa/rqPnVn8QwN95eeB67taBChxsYUN0L+/9AftvhDqkILZEh9?=
 =?us-ascii?Q?1oSUpOHr5/BOc7xGK943ws60g0Xg3HHPjn4TeMkLS6J5YBdOfKCl+rbmbP6K?=
 =?us-ascii?Q?iP5kgf3hrMWSFGVMfBv2p/WFjLTTq5XUC7XlFAL49ZZTC3nKLugBZd4yGD7C?=
 =?us-ascii?Q?8KAEkMSEQuyKL72jT1gRJ+4Jd9xXQlGW9cc2Y9L1034aaCC+zPn1kdu4Qit9?=
 =?us-ascii?Q?bpMRciQL4L2PfOSu32qoNmI/HPU4f7q32IduVOC8T3DMCHWxYFO1AAebeDhb?=
 =?us-ascii?Q?MgUU7DdBepdTeDXBGIIJqldn9WLtj3peoveceFpzdC+On/k0tPhaUVi1zh4N?=
 =?us-ascii?Q?Uh1nMuXXWK7LXgPHX4dV0Pabkgl4GyNTSWg8a7MUVm3f9i38OFYDOfZWNJ8Y?=
 =?us-ascii?Q?776Xo+kthjVAu0x+IbyPIUbLzPGDD0PhVBzjMaBt0ZWTPlcxkWBjbjmz557Z?=
 =?us-ascii?Q?1EK1udRJyt03RwUTzSndke8uGCL6AZ8cEUqGMkEs4G3UNBJihmHynSwYINaf?=
 =?us-ascii?Q?GExoWEU/9Z2QAzxoDidC1y6zfgSuxUJHY7Uba3Rx6PL2Vy0ajgVleHxd09nI?=
 =?us-ascii?Q?ljI9juOdNXwGJbt8uRU5FrIfLrfm1dHyU6nfErIfm0S/aWhI2aB9JHCBIEvo?=
 =?us-ascii?Q?UpeKvmhADiSEMw7NS3MImc4003ylozjqlEq7cjqr7QcbgbPcajIKaMpucYPD?=
 =?us-ascii?Q?61aVry/PL4oO3UKnR0mGIFA8vce7LxegWYWTiNsNBj+vqppJ12kz0h6uOkUO?=
 =?us-ascii?Q?orX4+3wcbsJD1+G2PXmuYNJ0jR3EXMEi4faXGBf3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9bb16f2-21c1-4f09-b04c-08dba4c0c567
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 16:40:05.8747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x5K6tQ/E8diDDw5bLMUgYIdJCBCQa+UmeymN5NRtXrJG/DT3NEjEP8nD+0rrGzg0mAa7wTIs1mkKzy2LyUMI7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7517
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

