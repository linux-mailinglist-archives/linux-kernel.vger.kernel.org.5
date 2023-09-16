Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E7E7A2D39
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 04:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238307AbjIPCAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 22:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233487AbjIPCAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 22:00:02 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2084.outbound.protection.outlook.com [40.107.6.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3541BF2;
        Fri, 15 Sep 2023 18:59:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTn/VVzbDQ6aKOFCg+B+c5As2Dn9PFGRUcQBRCjtAWu8XLON/hT8I8GwecVNxLjUxRMJpr3XYiT2Q2S6kWWxTaeNI3U4v78YlCyY2828xgG05Bf/61rPPwFL9rvadFajzBbvUbVlgzpdzXNGntWEhxpyZ5dUwVPcurQuTZovVGqp9uCflNahV+s3CpQpTrbbQa2hIzjO+YiYXNvDRITMfIRB3cD9VuKv+BnHNI74Mphub93tLrseRk58yq8tAQD1n9LS5bEu2+xRU+fsNer/luBbCPZfmYyOG+CS+JRZkzPQq0I1+Ufm2ShCfqBGCXAz1lOx5RJadAY52NmzQXF0SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/6l8BjjpvZnbK39bBK0MViMiPxXJ4e6DWmQIufYxyAc=;
 b=lLdSRFkILSkV1qBHNbx0Qy1pLY2iTKM4MNgarcuWEIBC9qhNg2xDo8hmXlcdbi4z/5/SNETxybckBp8/kFD6gl5hjct4W8oPWXZVqIiisSCVgVxqjwNHyjNUT5sc1+w7fQkeq3cXpgZknCfMArX57RVGq/OiLHRLm09C83Yesu091+IAjaPguqDm5Ia0UT0AY+nB/O5+5A1jMZ2ykuqig/KclBQYYWDj8sG6xRDU6BZrgE+kXu8RcREO1F9apmLvrea7pJ7gGhLyEqEMav35Po+rclP47SurMQNKTMQ9QMKPrjjJ3KbrIIKbqoZud79SFFtzwVoZz4XmXcvc7ZZSAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6l8BjjpvZnbK39bBK0MViMiPxXJ4e6DWmQIufYxyAc=;
 b=Tny/6/0Alue/w1j6CQAuQemw/fBjp+FIuzU8CMx7PsBYENGE3rxsfo9U0ibqw1kzJIbf8oSDVk7i4sfE1Lh/wKTPhFGa8+EDxTVzMdiw4PLnB5lKJZ+GZsDghCjJpLpEcgQvd560MD4Mw2AdCufgYWGSku2zQLWiXPFTYQLIf7o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB9142.eurprd04.prod.outlook.com (2603:10a6:20b:449::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.23; Sat, 16 Sep
 2023 01:59:55 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6792.023; Sat, 16 Sep 2023
 01:59:55 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date:   Sat, 16 Sep 2023 10:04:01 +0800
Subject: [PATCH v2 5/6] arm64: dts: imx8ulp: update gpio node
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230916-vf610-gpio-v2-5-40823da788d7@nxp.com>
References: <20230916-vf610-gpio-v2-0-40823da788d7@nxp.com>
In-Reply-To: <20230916-vf610-gpio-v2-0-40823da788d7@nxp.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694829858; l=2288;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=lzRXiFYkdfGJBIDYtusOh652f89MdWCnQmwolWuIjWA=;
 b=sdx+X+6H7RcevX4cln5Mexd2qzgQVNwTOHL0+K6CXieFZN5PpxnoQOLF2HrisaUny9WfPzfp9
 jXYXEKpqDzPBwjTD5LwnQuKPPWAoBrfpUiphAaY5wluL+tljj+ZPHi4
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR06CA0004.apcprd06.prod.outlook.com
 (2603:1096:4:186::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB9142:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cb369df-36e8-489e-f1c7-08dbb6589f5d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6g28VpTYk6t40CHSXpm7lSqbeJUldcJ91TFLykpNU/fUW6JYJ94kkQvd7/tZL+F4A5yEDxL1KN/K2sW7Vp7CwEhCiOCZWlIL85Nr5UU8Ntry0wKeI7YvXgGjnSb5foSLpuTOhnJ1I4VaozuIOPKtKSWl4Oljlmze8T/P9bpiiYEa9dIdg7G0F7HYMooo73lfwwU8Nvilis8Omg+pDpBeoSnLyUyZFO6giNus96On46Qm+O3Ya//cZauPIum3R37ErSM0RxsCU2M7YUADg0WQjZr1M6MNQfBz8ncG6qjm8a8C/p4Rl2/9YSqXuE5VKlwQAHhR++uxKWMciDMredd2FkR/DKVb9jtNX+gRbBErdIudf4z1UAXtkT1yqhANhIStHFkDvADGa7e+/2LaK+CrNwwSJ1wsjWBzm1otQvzLCLs8HRt50tv+LYLzIAA3jyuUt/u8Cufil/B6P112PZRBN+XVYYKhTvCKd3QSdBtEnq+xgIkFBj1W9PKZZigG1S4we2bB9mOqWuB6ORemhoR8kcMN2y5O6k/8UYnDE1BwyJcOHPSa0esh0PiyOxtqBalV3UZDMnPNjhgGXCgNXYGMg4fxAVt2ZajXpf6FVPPm5ujBG2ZTrFTwFk1ZlSF3GkE+sNJ3HxevgN009eQBWg5xTzpB3MPQ6MXzp2Ab7Mq+Oyg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(136003)(346002)(39860400002)(451199024)(186009)(1800799009)(6666004)(6512007)(6506007)(6486002)(5660300002)(66476007)(66556008)(66946007)(110136005)(316002)(26005)(52116002)(9686003)(41300700001)(921005)(8936002)(8676002)(4326008)(478600001)(83380400001)(15650500001)(2906002)(86362001)(7416002)(36756003)(38100700002)(38350700002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1E1ak9vVTRKeFRjR0V4M2JpYlUvK082MkNheEcvNitzT0s2OHdqVWRsNDJG?=
 =?utf-8?B?Z2JlSURFQklNc3RhR0p2dWxBTDlJdzJwUmZHMXZLOVJ1WTFqWFpMSFFibzJi?=
 =?utf-8?B?eFJQa1pCczZsVFYrYWIxZFhKYmJqMzJpVkhDTHdMVGlFeW1oTDFLRDBUU3dp?=
 =?utf-8?B?MndkZnRuNkU5bDk4RlZpTnNocVp1S1hjcjF4OEZyS3poMmE2M1FqKzRqSldU?=
 =?utf-8?B?czVJdUMvVEJUZW51SC9oMkx1RDNTbkxHUWowdnRpeHgwLytrbkhkVndYN0Zo?=
 =?utf-8?B?Mnc5TEFQWlpBcDI0Q2ZiTEJISWFoUlRjU3BoSG91ZWhvWmxKUEJXTXVCRXdp?=
 =?utf-8?B?V0paQ3JEQitoQ1hxUS82MmhRY01SOVJyR3FpV2NMNmYwNmNMZkRTVVJuWitO?=
 =?utf-8?B?K2c0c0hIUFdMZUxrYXhIclU5cEJCb1IxcHJHaFB2UHp1ZUtXRFNTR0JlSjhC?=
 =?utf-8?B?ZGtFYWVQdURvTXNLUkx1MG1ucGpQNUhFTTNCaGh5dnFZZlNXK1lJU3g0RHpZ?=
 =?utf-8?B?Z01vTU5xcnljYTd4cmppZDl2Z3BZcVkxcjJuRnlJZUdTa2NaeUNoV1VWdVVC?=
 =?utf-8?B?MGwxQ3FyMGkwRldWcjRCNHIrU3RDR29Hd2pMbkZHdlJvNTBSemVubTNxMkxQ?=
 =?utf-8?B?TTNlcW4rVUl1QktzS3dKcG9WRHYxL2JXdTRzOWtHY0xYVDJMVlZwa1g2Y2hC?=
 =?utf-8?B?bStlZXB5OXlTZDlJcDBoUTFnSVBnQkdWSFRRZ3VLUjRlTG82R2lJQndlRkJz?=
 =?utf-8?B?ZGNuQk1LdUFoNkdidHZxblFKdnlMU3V6WUhiSjgveXZBN2NBTnhYbTJZbGlS?=
 =?utf-8?B?Vi9vZU0wSDlDRmdGV3A3MWhETXJkZVBKMGUyaWFsbjlVN1FoT3FSLzErMkli?=
 =?utf-8?B?Y0N6UUZ1UUt6MXViR2tHZmM3RC9sK0YxMENQSUhlSndLbVFBNi9iM1I3YjZy?=
 =?utf-8?B?ek5PMExQNjhHdzBES1pSN1RKd29yNFEvS3VJUWQxY3poMkgrVTNWVXU4ZGZE?=
 =?utf-8?B?UXNLdGZ6WTJJbmE1L0lFK3BiRVZpZ2tEMkpsTC9yNlZqbldNWjUyenlDS2RT?=
 =?utf-8?B?Q3dQaTlnTlpSR1VMVnJ1U2NMVGFyUzNBOWpHMzdWK0VidE9rbWpURlF3YTZT?=
 =?utf-8?B?UXU2ZWNrTWF0bFVYNkhIeGxLaWJIbGZYK1NvVnc4b2JZaFcrUDhyRDAwdndS?=
 =?utf-8?B?TDUvWnlYenJ4VEw3N2NzNm1GNVY3UjZFNmxSdjAybGk5ZDNUQXlQME52OUd1?=
 =?utf-8?B?a2tNRllsVnR3MDNmZmtFTzBWaDd2TndLdUJVR1ZPazFBVk42VWN6aVY5dEcv?=
 =?utf-8?B?TkVoZ2Q0d0YwcUNzUUVBcWIwbHB4NW9VMmE5VFdSTnBwQWxZMkpwUmowaVI2?=
 =?utf-8?B?bmYxbEFQaFNhYTlhUTA3VGNuY3VOYjdXRTlxY2pwOUFnaU0rL01vc2R3WmV5?=
 =?utf-8?B?VWd5ZkdLalpXNWdvemNBR0ZSeS9sMzJUdHRPTFFmZVlpbGhaK3hYL2IwNmRB?=
 =?utf-8?B?a2NXVnB6TFBTS2lueENoN214QzYwYXNWYm42T2VVMU9aSG9HRXpWVW82djBm?=
 =?utf-8?B?MG52dFF3K2E1eVFGTUtXcS9TSHJDcmd3YWhmMDVrUmg1eDczZnk3aGVPbmcr?=
 =?utf-8?B?TWNkOHZ4Q1JKZktYaUhWUTBXUDZxNExvQkxYVW95ZDJoUnI0amliZ0VKVXNO?=
 =?utf-8?B?c3FXOXJrTUx0c1lmVWR3SVdicUZab2swUGx5OFFuL001R05ZVlpxRGh2ZjEy?=
 =?utf-8?B?NFBJR2dVQThCc1VtNlQzdmhsU20yd3k2R3d3OXlhSVdpb2twclB1Q0ZtZXhi?=
 =?utf-8?B?SCszWDJubzdZNlNITjd3amg0S255SWNUTWNPYUs2YWZzOVJMOCt5NDBtMmxJ?=
 =?utf-8?B?SUhid3hxZ3lBeFN1SU5sQ0dzdmxvdDVLeVNTRGQ0SDNoZGQyQktHZGpaMFph?=
 =?utf-8?B?a0svTzhiSkFZQ2h3NkQySmVsVWVHZCtkNWFOQXhMWnJYY0puZmp3cXBzekhy?=
 =?utf-8?B?L0hPb013QW1wZjJTbEpFY2c5cUYvTEwyR20veDNBcEl4SXpkY0NkTjFJcWlE?=
 =?utf-8?B?RmgrVmFHU0doSi9nalI3NDkwczFoTDdCZUFxQzBobFA4d3ZRY2RrUUM5ZVNl?=
 =?utf-8?Q?9ZsAmxLAE3PvOvUsADOkkV/HH?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cb369df-36e8-489e-f1c7-08dbb6589f5d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2023 01:59:55.1155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PYiH3zjhLBwfwSDiPJrCBZDu0g4uXVZup8a3NxX/+ir4Go+CkfQsuDM/pN+iwdORKByDIF6uZVOcUAVNEbns5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9142
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The i.MX8ULP GPIO supports two interrupts and one register base, and not
compatible with i.MX7ULP. Update the node following dt-binding doc.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index 8a6596d5a581..3921fdace792 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -484,11 +484,12 @@ fec: ethernet@29950000 {
 		};
 
 		gpioe: gpio@2d000080 {
-				compatible = "fsl,imx8ulp-gpio", "fsl,imx7ulp-gpio";
-				reg = <0x2d000080 0x1000>, <0x2d000040 0x40>;
+				compatible = "fsl,imx8ulp-gpio";
+				reg = <0x2d000000 0x1000>;
 				gpio-controller;
 				#gpio-cells = <2>;
-				interrupts = <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				clocks = <&pcc4 IMX8ULP_CLK_RGPIOE>,
@@ -498,11 +499,12 @@ gpioe: gpio@2d000080 {
 		};
 
 		gpiof: gpio@2d010080 {
-				compatible = "fsl,imx8ulp-gpio", "fsl,imx7ulp-gpio";
-				reg = <0x2d010080 0x1000>, <0x2d010040 0x40>;
+				compatible = "fsl,imx8ulp-gpio";
+				reg = <0x2d010000 0x1000>;
 				gpio-controller;
 				#gpio-cells = <2>;
-				interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				clocks = <&pcc4 IMX8ULP_CLK_RGPIOF>,
@@ -533,11 +535,12 @@ pcc5: clock-controller@2da70000 {
 		};
 
 		gpiod: gpio@2e200080 {
-			compatible = "fsl,imx8ulp-gpio", "fsl,imx7ulp-gpio";
-			reg = <0x2e200080 0x1000>, <0x2e200040 0x40>;
+			compatible = "fsl,imx8ulp-gpio";
+			reg = <0x2e200000 0x1000>;
 			gpio-controller;
 			#gpio-cells = <2>;
-			interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			clocks = <&pcc5 IMX8ULP_CLK_RGPIOD>,

-- 
2.37.1

