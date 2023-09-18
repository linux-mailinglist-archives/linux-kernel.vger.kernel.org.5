Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72AF87A443A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 10:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240681AbjIRINL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 04:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240860AbjIRIM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 04:12:59 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2084.outbound.protection.outlook.com [40.107.7.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40D710F5;
        Mon, 18 Sep 2023 01:12:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mnfE5nw7zygBx3kdmVc8p7ZE/kDiOMjgDQN7I2SItKb1V2rfxIgwSbg7mjLsl661qDi5F6ark5txn4AW4hfVCafVsIfMRYvsuHiue5YI4/9tMluhq9iF1fKnROV68U03b77ldL/lG3f3qnz8wgWy/MBZ1YhdJL5WnzTVYsDeBVZj/fR5vYC0T85Yxq/WD2+6zIDoahsk7C20mjUPBNIQK5YO3mPQu1ZgCU+aEt0aaSQ4SJhIRsn5mBLkaK+y13lB4jvDtyl0WuMotTLl9D+Zm5zBECxU47wkpWUtq9pHftAvboe0SIYICDvG1jUs7SG8dOu95uYsD8lHOMz/UbyGpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fHFXluGVzWt02RyFWyPuMFSCqz5Y1oXytkU5t9k+fKI=;
 b=afog3tQWXYGE2TU4bx5qetrGxquJRh4iH4GnzRKNlWicuR3XuLqmnbUqTt7oPJO5/MkR9drIFA6+IV42NiOJItDDGXTuFQEAp01xUqhEAiaOHDhTzL7AwNB5O1gNWx5i+jvI8W/Odp8UxEWO98cEcWMwNIGey+onPWRX99ICpK9t4T6ke4OxwbXNrfFRBcbe6LfCOvv+ow7eNrGDJr+7VQ2oyfkBB9VUKlKpnRuuZKOn094+ZnNlXEYSzz2utV9Tbgc5wTJn6wKSjgwH4X+/FiNyKCy98B51tu3yt2+j6lWqWbgqQCekfUj5BAIDMc9VQABCSeUrcgBeE+Bak5WLwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fHFXluGVzWt02RyFWyPuMFSCqz5Y1oXytkU5t9k+fKI=;
 b=YSNH9xJTQ8dmvIbGqSVJ5QD8skzxKTq8WAb++HCU6mUuqUDOmBI6ksg8XEiSKgt3NDqRAxIfaJ6S4WrakLiYtiVdqNb98Fz3cWu2XE0Bjic14lHNTn+4WJwNvSKVNADvm2ZJLBwSoG8/zudxz9b9l7mbF4bkeiLS3ESMzI19Q0g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Mon, 18 Sep
 2023 08:12:09 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 08:12:09 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date:   Mon, 18 Sep 2023 16:16:09 +0800
Subject: [PATCH v3 5/6] arm64: dts: imx8ulp: update gpio node
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230918-vf610-gpio-v3-5-ada82a17adc5@nxp.com>
References: <20230918-vf610-gpio-v3-0-ada82a17adc5@nxp.com>
In-Reply-To: <20230918-vf610-gpio-v3-0-ada82a17adc5@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695024993; l=2557;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=OBv9Fl8cAe6WZDwRqWWAbBALhbody3v57Vb/+6bcRug=;
 b=V+BDZtzeXS4Lhv+TC2EFSuS2z2j2nkC5mNA9qW8QOi+nx2bkW+ACqW4b37BjhMuqgBMJSTBBR
 kmPfGX8WCNVD48TPDK5PDnFd5duia514kYin8V+HloVqb2ldj0JCC1U
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG3P274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::22)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|VI1PR04MB7104:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c3c1e91-7b0e-41b4-5cea-08dbb81ef44b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +IRDiJ3I6P7XI4S7+DIwjyFIgfknd5x+DPMjGMaOcVOAgYXdSEII+bjDRDTRh2oXB7FnTM4Ny8dIgv8YTJWL6+qCZl20lADB+woKwNG/Fi5RfXJfoVXjznkSs7bpBD5B/jVVIitxGtTz7lbslKeZ7ysOZW7AcrBi2AxicCN5JhKB6OB7cPUui+pWn2RYxsNMWS/tqxEPcudEbzCt4Mk28+SlMlDle/5+i4gboYmKf8ONztLs+mVPnfDAWsTnoNjIjxcFeid313PwJyrBpRvKP2svZz7T2Qz2/45Y3qx3L5VkvmN9Dz6X/PNTHWcllGkZiOz7gQps5CGTFbqzC/ilmCgyK4KIJe3gKEigDkFplAOPk3Qkuu1K8wS9GgTHza58gas9zLsy14rzAMZkfv5yuTHehr75TTmD0ol8KABvnpy9raCuW7ivjzUkFpqWZOawjSpXmPL76jpyyoPG54JlyTqKTaJjqLwY/+ozdXXCqvFGn36VefHktMMXYK2540AgSWWXEheFGBnhuPkIYsVoiRnp4rC9C3955uTSursn/vibny0O5YrAqrcB0/aR1cRkCGcQIVoCQWwkIIHa856WO+LS2fob2h5hNT8QJNbLcX/uHm7ZqEvZ9dzc2GZuQB2/ssVuPMqzS3iCEX940gvqfBQF1Vxzx1oqkoioZGo2Cng=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(396003)(376002)(366004)(451199024)(1800799009)(186009)(6506007)(6486002)(52116002)(38350700002)(86362001)(38100700002)(36756003)(921005)(26005)(2906002)(6512007)(9686003)(83380400001)(478600001)(5660300002)(4326008)(316002)(110136005)(8676002)(8936002)(41300700001)(7416002)(66556008)(66946007)(66476007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmZPdU1KN2ZyMklieFNiRVp6NnFhVzgxUEkwUHExUHlQYlluREg2SndFZ3Bp?=
 =?utf-8?B?QzF6aVVXaDQrQ1dYZ2pWNllIaGg0OGlGWElhZjFwNDM1OVN0amsxcEhSSUZl?=
 =?utf-8?B?dnlsMC9vU0VVNXFNbi9NTUVYNkZXOVNjbXRNZjYwcTBNb1RBV0xIbG5nNS9O?=
 =?utf-8?B?aDZnTU40Kzg5emgrMFVMYXlqdzdVeC9qN25TWXJJY29MaVh5c1pJdUlqeEI4?=
 =?utf-8?B?bkxOVmM1NUhNZHFCUFF5UGxIQmhKQ3ZEOHpBYmdQbzl0ajN2bXJrdkM2SGlZ?=
 =?utf-8?B?NGR4bXB5emhha05Nbm1IaW9OM3J3VURGeEN5L3NuOHJyZHdveEt2R1NtTmRz?=
 =?utf-8?B?ZWcyaXBZVTd2YmpHU21Bc093Wi80ZlBXSkxVaUNHVlVRT1NjV1FqamZQN2Rn?=
 =?utf-8?B?QW9zVDViWENMSnZHc2w2MUorMnlwWnM3VlhuVkREaDdGRjVEZnk4RnBsdDhs?=
 =?utf-8?B?Q21PRHc3TVl3L2V1NkliSnZZeS9GN2lvQ0FTSjJTcDg0K29nQ1ZJZVJvMTV3?=
 =?utf-8?B?OTVnblRWdldjNE9pVURibm9Ca2JlakRNUEliZmkzWXJkbDZGeWtaTmFJK09W?=
 =?utf-8?B?aWhheG9xUnhjWHNLeEZSQTVMcnRkNUdiRDlGblFZVFpDTWN3M0xuakp3RDFG?=
 =?utf-8?B?MU0rb2hnNWpWZFBLRHg0OHZNbHh0SWZON0ZZWDFjYTUzeU9FazFEc3IzRzRj?=
 =?utf-8?B?b3BRWE9mZHJVdHBpOUNza0FGYTRwZE5hTTVBeW9yNEVnZmpCditOTFlXYUd5?=
 =?utf-8?B?dzN1OStjdWFhY25iQmVvejRHa01veTRHVHV2RkpTM1RsWktYMUVDekdBUUVV?=
 =?utf-8?B?Y2VKcHV5R0dhNWJXc21oMDJ4ZXhFZDQzWlFLQWI3cC9xd1VMK3FiMXhPb0tB?=
 =?utf-8?B?SXYzeHN1eEdDSHJzSGlpNmUvVnN6VmFCWkt3WUdqV3BqU29pOG1GQzFEUHNO?=
 =?utf-8?B?NzhHVmVWL0djU2lDa0lXWk4xYW4yZXRaUFpyYXBGNkMyckRXeGlMbC9UV1dU?=
 =?utf-8?B?L2FialRLQndudHR0ZW15SW5lRnBxNkdNdkt3RDV0UHBKZ3ZkMGpSK3hocTBV?=
 =?utf-8?B?K2o0R3dIUWs2N2tpVHlWRlQwV3h5T2l0eVFoT0Z0RWxaV2lWRXpZMUxNeFdY?=
 =?utf-8?B?Wjl5N1RyMk9janZVbVJkOS9KMHpsVVlLSVFqWWp5S1FNNXBwQUk3VWM0Zzg4?=
 =?utf-8?B?eFZQd3RQMDZKNTR2UWpFcVhpN2xJYzRsU0ROTklhRmNtem95Ykd5aDBtNERR?=
 =?utf-8?B?VFFzUzAxRmtoWHR1aFY1eTJ1cjl3M0VPejRQcSs3NFhDNHJSdGVvOEV6cEQw?=
 =?utf-8?B?eDFGbm42YXcvRlN6eXZIaTVjb2hOdGhhQndEVUUvUy9hQXVNbnBVeXpuVDlv?=
 =?utf-8?B?OUJ0azZYUk0xdmRCUWkvVHVlaVFaQ3I1ZXdkdk1oRDFUMlMweXUxbWJOVGoy?=
 =?utf-8?B?ZHhKK2YzKysxLzhxS3RqZVRMNmM5Z3lCakJrSDRiTE1qa0s1NDZwcW9OYU1z?=
 =?utf-8?B?ZTlmMGhvTnpYcjAwU2VPUHNXdWliakc0V0t3SzdDdmlLMjZQN1ZFclNTSFV3?=
 =?utf-8?B?LzJ0UThUZlQ4NS9IL25SaURxYWgwRUt5Q3A4SEVZbUhQNHladWtjTHgxbFVG?=
 =?utf-8?B?SGJvS1pjNXNUb3NhdEZON2RKS0RoN0VjcjYwM0syU2QyYURqb25INzY5SkdX?=
 =?utf-8?B?QkJXTElXNjlCS3AyUmtyVUtJVFdTb3hzU0FuMERVNkJCT0ZmRXRrSHBaZUc4?=
 =?utf-8?B?U0ptaFQvQ0lNakZiSHdTM3hlSGRkUEVDY2VVcEFXam12ckZrR0pSTXdiK3ov?=
 =?utf-8?B?b1ZxSStaR05RYm44SGZDcUgxRkZOcXhwZzI0ZXMrcmpiQW03SEc5WW01Qm8z?=
 =?utf-8?B?SUtyMHpnQ2Q0Vk54Q3BUVzdVRytSN0RWNS9hNWtXUGJsbVZkakdJZm5KRER0?=
 =?utf-8?B?eWs5dThIMjIxekRpMER6WHk1aTN0YjBoaHdrZXIzRmtvRU5GNWY0MzArclY1?=
 =?utf-8?B?L2xWSzFKai8rd0lhUTlpQ0I5ZUJKeXFKUm9ZWDNFbzdzcEVvL2h6amFXRUxX?=
 =?utf-8?B?SjJpeEJLSUlLUU9PL0txQXQ4YkxIYTMwQ3IxYWl0b1R1UXp5Wjh0NDdqL0VJ?=
 =?utf-8?Q?vT8+EyHx44AuELNCTou44Cv06?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c3c1e91-7b0e-41b4-5cea-08dbb81ef44b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 08:12:09.1268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v0abeyVsgqxb2D4QDsme42DtyhwSkWzX6bVE6ncoFAmlePlgjX9KgeoiMPu2T+/12Dh4bsth2x0F8yAKhkGtQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7104
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The i.MX8ULP GPIO supports two interrupts and one register base,
the current fsl,imx7ulp-gpio compatible could work for i.MX8ULP in
gpio-vf610.c driver, it is based on the base address are splited
into two with offset added in device tree node. Now following
hardware design, using one register base in device tree node.

This may break users who use compatible fsl,imx7ulp-gpio to enable
i.MX8ULP GPIO.

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

