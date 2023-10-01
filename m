Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7457B463F
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 10:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234567AbjJAIYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 04:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234596AbjJAIYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 04:24:06 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2088.outbound.protection.outlook.com [40.107.7.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3F7CC9;
        Sun,  1 Oct 2023 01:23:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SSwsLOzHM6Qj/LmkJbyaSh8yHlj3Fr2XxSMU0IIQIM0UOWOsoHUekTT+K7yfR+E4C89JpWpgDpHfODcDU77vMYL3tgYkufC8pd73h/AcGVg7V7Gw5ijJGd2H3Uy1Md6dQJ3lrsP2KlWEiSgMbo/OKOyskMAPF1inERW/0vKE8PY9KqdauyvBGvLJ+HKOFrAIbdiv0A76kGn7NnWuiK6VfCutMriDJc7PPxdx8njXjgQz/iG00zpDIeYQVlmyQYHbS4GCEX7pexXvOBzwcvkKXisTiat8L5WVZNmDvliamN4a8/P+McuBmIuBx605YtmrfqfKmP7hwubE/np3Kguwig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fHFXluGVzWt02RyFWyPuMFSCqz5Y1oXytkU5t9k+fKI=;
 b=adVvmJmKUJmb6ueqQ9rliXeVWGp/lXVsVB/F0Tiis24QJLnhXiivEt7+zflY1Bve3mGMWYBk0v9s1cCHsAB14Dvnmz0GMmQLb9XKyCH5Neqh+ufg/b3pom2vaXhS0YC+zqSYVEAHERJsLFdUu2RbDTt7fzqCUSaD/CNlKLIeFVWyAtvZydFPnSLYIVFvnWwW4ljqPonSHmQcxEwXhAz2tjWK22W/tM7ezIiJ9UWJA71UbS4FemPiRThyTyqSN5Z1SvAsosccbZl4kKty/jwRkBccM1/Qj2uc7trQxnFekuCS/WzzE3kJAdKlGj3tcqYlIsI9MKsEwE9TiUBwesfPQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fHFXluGVzWt02RyFWyPuMFSCqz5Y1oXytkU5t9k+fKI=;
 b=LBBTSS4i8ocg1gLLMUrWaVNr1yY51zafoikkF2x05ynN9ppcv4Xc2olnNwDvLSYI/U1zmSyuWH74qLC1twvzGiu7a6dveojkKfTMOhvtHq7PEvyOlWNsY8WUd7lIM6bgiwz3W5iEFFRfEEkt/sQnCa9XJXcRrNxgsKsK6Mu5yTA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM8PR04MB7473.eurprd04.prod.outlook.com (2603:10a6:20b:1d0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Sun, 1 Oct
 2023 08:23:49 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6838.024; Sun, 1 Oct 2023
 08:23:49 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date:   Sun, 01 Oct 2023 16:27:57 +0800
Subject: [PATCH v5 6/7] arm64: dts: imx8ulp: update gpio node
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231001-vf610-gpio-v5-6-8d873a8f224a@nxp.com>
References: <20231001-vf610-gpio-v5-0-8d873a8f224a@nxp.com>
In-Reply-To: <20231001-vf610-gpio-v5-0-8d873a8f224a@nxp.com>
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
        NXP Linux Team <linux-imx@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696148883; l=2557;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=OBv9Fl8cAe6WZDwRqWWAbBALhbody3v57Vb/+6bcRug=;
 b=qUBhzgbcESUxVsJMqTiG2BKo7c9kaHDruHLUQEHOTgZ2hW3lJUkWrFO3YkfnZWLhpphD+F/rU
 23GCAefGPdUCFqxdVwewQ3z2LEYN7lWnl9vv0udSDmhmImmxDVEj6M8
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR02CA0131.apcprd02.prod.outlook.com
 (2603:1096:4:188::6) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM8PR04MB7473:EE_
X-MS-Office365-Filtering-Correlation-Id: efbcae37-bec4-49e9-0852-08dbc257bcdd
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PffIW0Qq1DyvYoPBRC8ll6Nfnk6FabBBRJr7v5AS3gf0lIsdpKHDjqDuSyjSfEN+C2p5Td1pzw3HzHgowl2oKV6f1NbR55eVfqsIsa2kB5OgC2xWdpWPAJn5Xo/NxHs/YoF8fQ010c2ZAdqWNFDT1AbOaR1g4Zoc+htOdm6Ke/pq9GDiQ5kqZ7aQ0sbWdZfIzM4MXZQ7wPhUnsUevZFgtxTKH972InIXIdf66JS+ZN+RgngCZMtuxGi4cIEoYMPLZfCptQAz18cx71UayYBEqTHalJiDPiSBYmUhnaG6xuU0EUZ0NZ5g9/boJaasZKJH5HcmFY6locqy9n5GC3Lek/rm/zAcl5QWzJTpwJdm3j5YtDRteofJQpggx0tl4zaH+KJahHeywmOL0lEQWcVZw6/e3RbmKjmeGgA6iTNa8eru+5Ay2FT2Xok2VZNe3ac7thI1t3HexF5tg1NqdU9NyCIdED0fJ0DT0THhTF2cGTGm0o+94KwCFQEg9OT8NkeXgJ0fbFPa0diglDJlAd9Hk05aArhUZA9SIqcBYMiPn0aE61LI0ixRZm7f+/6p5AHEr+x52k+WgtsILy4Ec55ff6lGid1QMczNJmY0JqsYWkXU+R26CWeCK5hHpWFgjGmhpuTeDPUYAG75jnGkCIBzli5mBMp6C2R+jRat31jxEKs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(376002)(366004)(396003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(6512007)(9686003)(26005)(921005)(38350700002)(86362001)(36756003)(38100700002)(83380400001)(478600001)(66476007)(7416002)(316002)(8676002)(8936002)(4326008)(5660300002)(66556008)(66946007)(6486002)(110136005)(6506007)(6666004)(41300700001)(52116002)(2906002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2w4TlBkRklidExDWWpIeWh6b1dsZzRhSmpSWnc1TzJMQlA4c3VZTXFYRTI5?=
 =?utf-8?B?TEExSWprVExrcFVjUW96N05EOUxYbG13U3BGeW41TGtZaWFpU3NmMEJ5THJz?=
 =?utf-8?B?M3dxZkhWZFhoUGhxcjZLYXZNTjMveFFTUUhjSmpMeUZHVmJCODZCYTQzSkFJ?=
 =?utf-8?B?WVZYcXVqbmNySndVckIxZzRTNGNncWZtbUFpeUo0YWtNZ2Z4aXdOdzZHOUVC?=
 =?utf-8?B?cjdIWjE5NmFTMUQzUzE0OU1BN3V6U3FLbUltM3RaUkorZUhyRk5NRy82dXI5?=
 =?utf-8?B?Q0RUUDVKNFZYL2hFeTJQL3pOTGh2YUxwOUt5Z01ueStxaGhJUG1zS2ZiYkJM?=
 =?utf-8?B?eWtuRENzSFg0NFZvUmhqejBCSTVtcWZad2NnVmcwR21LQTgyUlp3THRhQW1I?=
 =?utf-8?B?NmdUTTh5NEZEejRrbFZvV0lNM1VRa1luSDgvR0tjVjZWN1VkdHhMNk5XSHlI?=
 =?utf-8?B?ZjkzSXBROGRENUhPL0V4YlFuWHBSZStsTEcrVDVmSHZJWjVOQTk3T3d2d253?=
 =?utf-8?B?TCsrQ1gxSXhKazc1cCs5YlMya0MydkprOEIwSFlOQXNEbDhtSzFpb1Uvc1JF?=
 =?utf-8?B?bjhqMnEraVJWVFhhTXJnVjdod3V4d1lOTWVrRkFaZnR5NXh2VUxmdldGQk5Y?=
 =?utf-8?B?MTVRcFhRc21Dc25OZG1aaHpDeUtSVERRanUyeEhUZDR6UWhJOUtmOEtmd000?=
 =?utf-8?B?YXJ6bndWZXp6N2tNcDRkVDk2TjRDUVpjS2dlOU9WMmhjWktGVmtDR2pCbThP?=
 =?utf-8?B?SEJia0M5ckZLTU5YMGhqQmtPU3Nsdjhickt0SzFoOGU1d0ljWVJWcnJoZENt?=
 =?utf-8?B?YUtoQ2pIVWZGNDAxbzBPdmpwVklEV1U0UXlqQ3Z1WllFV25ua2FaOEZLUlVq?=
 =?utf-8?B?TFhsejc0bFZoTmNOKytXaHB5czNCaUNvOU5OUWI1VzlTbmk2UUN4VFM0bVpv?=
 =?utf-8?B?blBhczRYRVMwcWhlbFUyV2FMaGdYZUN3eVBUakdoZERPcnFZY2NJb1RNUEtU?=
 =?utf-8?B?Q1BtbituM3Y5Qks4ODB5NmVHQ1o2bHVtWFZ3eDBLRHNTMjRqY0JTZm5TMzZx?=
 =?utf-8?B?TzFHN2swY0hJNzZXelYzcGpvcFNhUjVDaW9DaFBCNDNzZWpROUl2d0trTk5h?=
 =?utf-8?B?SXoramtUYlZrd1hGWGIwVUVTUWN6RGJaZmJFdXU0cDNsOENXbGZZbzBLYUpT?=
 =?utf-8?B?NGQyK3dDMU04QjFuTDg3QUlwQ2NXOU1YMzBUTjRJcVlCNHZhcjFETTYrUm1W?=
 =?utf-8?B?MFVrZmdpWEJCRUxKWTc3c3Bxc1hSWW10ZXJqVDZMemZWNmF2WDdESTRlUm1p?=
 =?utf-8?B?RTV1Q0VxZm16TXlqSFEvb1ZjelRGYi90VVpkSllKaUpwVEVLSXRpZHpVZHpD?=
 =?utf-8?B?NGxBSmU0ZitMVm90TkNlUFJCRG85NGhZK2lvb3FzUjNsbUxzU2VjeWhRdi9l?=
 =?utf-8?B?M2dYcFFOZjdYbTBXNXdqeDJVQ3ZjZnlrT0RWR09LMFdOSzl2S3dQcWZlbVNj?=
 =?utf-8?B?R2RjSHViYnBPOUNDOUEyRFlRcFk0TTgxM0w4SXdKYld5RElScW1vNm1nSlhG?=
 =?utf-8?B?VERYRllkaEJKNjhEVTVBWVlMUmUzLzdnQnh6WXAwd1QwVEJSNGNHQm4yT2hO?=
 =?utf-8?B?YWtjanNNbDBMTGlrZUxIb09vcGlJSGtnU0wyMlJMSkdsdjVKdG94bkdzY3BP?=
 =?utf-8?B?Y2RJU2c3R3hlRmhLOTArZEVhNHJjMXdNSnZpUi9mNklOVUx2TUh1Q0tRWnVi?=
 =?utf-8?B?TEEvbU4zNTdqUWViM3ZGajdhT1dOMUdqYStsanRqUWJKTDBuaXBFdXJndWJM?=
 =?utf-8?B?c2ttWDdmOTBSZHNsb282TmIxOTA2NENkSFFwekNVUExvNjc4LzlPNTlhUjMy?=
 =?utf-8?B?NzN2dExPbnFBWWd2VElqMVdyTkxPME56Uk8wbzZYSis3RW5wN1Vwd0JJQ2xy?=
 =?utf-8?B?a241VDlUYU1RYW9QenhQODI4QlhCenZ1TXBnMUhYNExyRVBXWkhrOEh2c3NM?=
 =?utf-8?B?SUZHTHpRZGN4bFpPNFVZYkZmYWZCVmhXOU1JZWQxSVA0WEtiM2RYZ1Fkb2Ns?=
 =?utf-8?B?bXY0OEV0aUhhR3RBdlgrVUJXcjNwSHRwTXZrNlhqeTFST25YL3E0dmFGeFFs?=
 =?utf-8?Q?a//1C53rMoSh+KgRXPosi4SVH?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efbcae37-bec4-49e9-0852-08dbc257bcdd
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2023 08:23:49.0624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hxE/BgsSo0ub/+4tt5kc85pwrgEOHnVYjPPEVG4i6hSWDNAvo0bpljvcgih7bQ18e/uLoJf/zWagpURPjeH+gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7473
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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

