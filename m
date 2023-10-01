Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F4D7B4638
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 10:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234592AbjJAIXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 04:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234576AbjJAIXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 04:23:48 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2065.outbound.protection.outlook.com [40.107.21.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E9911B;
        Sun,  1 Oct 2023 01:23:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l3Za+OfG33BffKw7MNF01hVeVC4mPnK2z73Bv9p2E6pPPqS/CsIp+f7g9nccKhi3j58/LVI3fjotIkOEFZtGLG73iyXBof8ajR34hNEMMad3FEE1FTiDn5+LbYCizkbwzXie4pN6PCrBI8c6wcgNpkrR0GqLe/EflAhh3N+bAG+dHEkRFua++a9nKwLYw9i5vSyGal7vWoXSBcBv4aVeYt9lq36r6Gs0k3Z2LD5cIRaXPadGn9wR+jDElKo8j+T5/u9QQTlOFUW9rdnleeh8bgLDJnMf82nxtNQgoZKCkWfXISeC63BYf5rGQXacUTNUsxOEXqcQLugvt3KDVIz2iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mr7sQz1yoHoDuwKLC2NruYcIIU1j0vmnjyNrB72diAQ=;
 b=DGUJNp8VD+e+09cU1R6fT8AOJW50rh8RvoFV36m5yYV6IS2xFluvTibbCajKtG3amrhR5ZraZvkFZnzN4rXME6J739rn/Q9UVdnhmNtcHU1BEXOHd7JnlIR+4K/FBCt28l2foZ/cZThyb6AwY6jZFmO6yTysI7fxYYZ+0wzEGYxMi7BZnGyoIbLHamPzd0sA46D1A7jJsGZRg0BvsmaMoU4R/EQI+Kd1Y+04V6721ggbNfvnv2QrGN8icaZ4SrotGkZoDxuxQF0845l0I456bhxWQN8/xEe2oUo8miuqo3yIVHpPgn3u0gWa/+aFNyxvFQGEpLGE2CFPrIkEEgb1Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mr7sQz1yoHoDuwKLC2NruYcIIU1j0vmnjyNrB72diAQ=;
 b=TemXA3fwm0L0NDzSUnu3wOsguaL6tGUtcXmX8Mi109NXCMIx4Hb4nuLBSB9m/v/D/VB1c0bbF93nCSm5L8bK47dZKsd/6VorOyTM9nidmFJ/JyTAl2v4OApVruu+q3dpX+OM2KBqZqRVPTHMmvkXtPB4OamgOfDYToj2NfuvOh8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PR3PR04MB7417.eurprd04.prod.outlook.com (2603:10a6:102:8e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Sun, 1 Oct
 2023 08:23:38 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6838.024; Sun, 1 Oct 2023
 08:23:38 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date:   Sun, 01 Oct 2023 16:27:55 +0800
Subject: [PATCH v5 4/7] gpio: vf610: add i.MX8ULP of_device_id entry
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231001-vf610-gpio-v5-4-8d873a8f224a@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696148883; l=3444;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=F3ztsSlGWjYD7DS0l/EdF5KdUwt2G4UpUATZtl+c9F4=;
 b=KegxZZA5ODS4A6WjEfyRVj6thifs1w4UZjMjP9asJG7GUhUggfSs/8EIHD/jtC54xnc/YlAc9
 uQAdHW//zQCBMrr9QjeUWr9c99ON7nCFdUl7zJGdUr/Aqia1aGegznk
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR02CA0131.apcprd02.prod.outlook.com
 (2603:1096:4:188::6) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PR3PR04MB7417:EE_
X-MS-Office365-Filtering-Correlation-Id: 36104f56-5653-4af9-5dfe-08dbc257b6b5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RX2//Lzc2NGi/TYjs+cALM9CzWWfqEj+PGBLwP2q2M3Ytlh59HXSVOJuJh/n/tGqijUcvj3eEgY9r8QU7ULBmZRnOmGaehR1Ewsa1rUajdMjYBdgMdiWzZPwpOREOdhnx/H78V4wszl5JnxPPSDQh1RwUAd1VvVTYeQPsnzofjBZQKGznNOrqJ4wOCV1WUjE/FTrTE0JpX/Y5QRBn5fISMSvB/CQo4HBqYvOOqnvaaeklU3jd9yja4WxkvGjkAsiQWusbB1cjQw4ey695qrMdhPPd7UfS2TFCUUlpu9sK2uBGBE8rO2NVdMkz28ZoNt43Rd/x5GylX7m+cH/aDOAd80hcjmWzo9ZYtqSosnX/hev4hBbjiIiKPYIakvtNNo2XfxTT7fbvUzESD9pGnAfvb1CyFdFkJdprmFbW3V6vO4g24O392KB2t2GK2OLSf+z4BicWz6PIeEMlf38846iRgc2nmXVz4+sT6R4iwT+7tIapIMduSCRrdJlAhZz+EM2J0w3qNUTGhDg1p/nF6nJrPudUeAVYAjxxiRfECpSdvxZgZrIy/L3NIyWlAj+1LyOBkX+bOA3Dy2/JpuXeFq+xsAGtHBPC8QxR1antwqwBWiqv/okcWtFG4Mm9vcJQUSW0ztuzApH82LhM2ddwCbdNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(396003)(376002)(136003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(41300700001)(316002)(26005)(2906002)(110136005)(7416002)(8676002)(5660300002)(66556008)(66476007)(66946007)(8936002)(4326008)(478600001)(6666004)(6486002)(52116002)(6506007)(9686003)(6512007)(36756003)(86362001)(83380400001)(38100700002)(38350700002)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L21JNDZqQjkrSDBJWXh6THB4emFJdWs4T2g5Wi8rZmNMMW5yWlNYanVobC95?=
 =?utf-8?B?OFMvWjJPRWpQTEVUaW95MktHVHNkRUEyWExackpSQWlOeG1raTlzR2NrSWsy?=
 =?utf-8?B?cG0xYWExOWRhcko5SFRxQktZREgwR2p2MUJQWk5FMkkzMXdGL1F5U1paWnlu?=
 =?utf-8?B?bEY1bTZrUWFQS2JVYXMrMHV3UGw2SEYyb0pwbU5weHM0R2NQU1ZQM0hlNDNu?=
 =?utf-8?B?Qi9CMDZZemdsejlvNEkvMUloN1ZNSVY4VHNRL2U1dlRoWGlkemNhZG9jM1dS?=
 =?utf-8?B?bjk0MmcvRHNoYVN2L1IrQm5BTHM2Q05MbldQZmtmRWVRdTJKTk04ZFpKWExX?=
 =?utf-8?B?QmZKWU55a0c0UjRPQ0NoeVRqOFNvSUdpRXBienVYNHhkcW92aFozSUVpSEZR?=
 =?utf-8?B?aTJtNjRmS0hreE93Q1VSSVdQQ1h5UnRyQ0pMbmY1UDVlTURRK2FiMTZwUFA0?=
 =?utf-8?B?RzY3VUFyYTFoOGR2Nkd4dUpnUGdUY3ZkVmMvdUNtZ05WOGhwRWtWRVdQSjdD?=
 =?utf-8?B?ZjZUWDlIYkxEVEJQSFppQm0yUndKcHYzMVEyQ0E3MnZQWWl1TGl1Q0tuUTdP?=
 =?utf-8?B?a3VjRzN5N1c0dGI3L2VWTlpoSE1JcVpab3l5ZGVEVWRoRGJPT1FvRk1lNmF6?=
 =?utf-8?B?WkFPd3NEQlRYemRtOUFrTzFuSjJKaWZKbmRiNDJtR0VkUEhZRlcyYkJRamZn?=
 =?utf-8?B?MWpKSGdpeUUwdCtnQkZPMFJaQSs2aEVRdW5jTU1pTVFDN1FNVDhsWTFIY1pH?=
 =?utf-8?B?UVFmR205WDk5bCtmU3FlQzlPYnBrcTl1TG83dmRWQ0UwUWV1Z1lJQzcvazJr?=
 =?utf-8?B?eHpFaTQ0K011aXRBaHp4ZDhJOWZjc2QveHJNVnZDdFowZGRDRmtMcHRlaUcy?=
 =?utf-8?B?R1hvS0lWVlJLcS9LZk0rSU10UGg3a2l4RmphSVFIYTgvVUsxbTJ2UFVuMTZl?=
 =?utf-8?B?MHNLOVpJWFVwVFlUcmdsUHROdTF0a05vZENPWDJsYW1NRnVkL2g1YmlaeTlx?=
 =?utf-8?B?MDY3T3pTV0RlR3VQZHRwS1laZk1idjhmc2ZXZGJkNzRFb3dpMDFYYnJoRXFL?=
 =?utf-8?B?d2VQV095ZmExZGtheU1kQUZNbVRzZ1VTdXFyUkxzS1dkWDBEUXU2aWJLRjVu?=
 =?utf-8?B?Q2pTTWRsQ0JNZTdNd3VJQUd1M1JzU05XT2RUWXdGMTZ2SWNwOTVyZEtQb2lk?=
 =?utf-8?B?cjFROUNET2pmUTlMd2FUT0FRM0h0dHVRZVdJVE91N3oxajgzL3dxb1krNG80?=
 =?utf-8?B?SGxBczFBaTU3N1FqL1JYbDdBcGFDR2dhL1ZsMHkwSVhEMS9jNXBZMU1xR2Vw?=
 =?utf-8?B?U0FtamVzOTFiMmlOU0FVWndMR24vWmhlWUI3U0VGUUpDMlFIK1hGUko0bStV?=
 =?utf-8?B?T0xpcURydEdvdEUzUEM5d2xJckdyeHhHYnE3aFViSWtTMXppaXgxRWhoRGEv?=
 =?utf-8?B?TmJWSGw4TDJHcXByemloZmpuakVBUms5UjE2Z2hmbnJzQlA2SEV2WExaQ01J?=
 =?utf-8?B?eXVza1R3MWdhRUt5QXZXdndzVDFXNE9DNTlTNExBbGNETCs2NHlsSFpmOTQ4?=
 =?utf-8?B?aWJKb1B2ZE55MEsxVjhRZTNJc1M2OXFoVjAxVGFVS3JqQllKTjVvSHI4T3NM?=
 =?utf-8?B?Z3B4czl1Lyt6bEFqeSttUDVWcElsdko3d21ZRDFNOXNuV3lJZ25CQU5wRTV6?=
 =?utf-8?B?ZVNqOUNzSHJPaVllNHFQQjRRVWMySlVJTFV1VmE5RTJ6bGczU3ZWVS9CR1cx?=
 =?utf-8?B?MzNMb1RydFJCZ2hvZzVhTi8rVmVrcjlwN1Q4OXJvMWhZLzM1NE41RnlFV3oy?=
 =?utf-8?B?K1NaWE4rYkpyQW4wa3Rla2NtL2RUQXFKVmJ5NmpkenVxUzY2V0pmV1RqcGtr?=
 =?utf-8?B?b0s1bDVSWHJmU2Q3T3duZWpvSFBrRnRQWUR4M0RadVFEcTNneHdPbUloSUdv?=
 =?utf-8?B?VzdrclRicU5iVSt2Z3o2ZStZWG5hTjZaRXlKaDZpWDNWSkVWdFBBblhmTG1v?=
 =?utf-8?B?MFFDRmFhdGJ3aVF2L1U0WitmdmpnZUZQYWVseXQ1UVY1NDhTU24xcmpBZmRQ?=
 =?utf-8?B?ekRpZ1E5N1FHWExiZld4MU1kM2haaytSSUlIUVhDdGJubEJOYkpuQXJJbG0x?=
 =?utf-8?Q?rxbCwNFkKRS0x3rQ+4ATe7iiQ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36104f56-5653-4af9-5dfe-08dbc257b6b5
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2023 08:23:38.7723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6nAJ7SA4rjCwjNgleYgipbcvFzeocv7SPUBGsTXTNG08qelmKityjSXhlTF6Rv128ytyw5TZi+3GJaf359vNuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7417
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX8ULP/93 GPIO supports similar feature as i.MX7ULP GPIO, but i.MX8ULP is
actually not hardware compatible with i.MX7ULP. i.MX8ULP only has one
register base, not two bases. i.MX8ULP and i.MX93 actually has two
interrupts for each gpio controller, one for Trustzone non-secure world,
one for secure world.

Although the Linux Kernel driver gpio-vf610.c could work with
fsl,imx7ulp-gpio compatible, it is based on some tricks did in device tree
with some offset added to base address.

Add a new of_device_id entry for i.MX8ULP. But to make the driver could
also support old bindings, check the compatible string first, before
check the device data.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/gpio/gpio-vf610.c | 47 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 40 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
index dbc7ba0ee72c..8e12706c0b22 100644
--- a/drivers/gpio/gpio-vf610.c
+++ b/drivers/gpio/gpio-vf610.c
@@ -25,6 +25,7 @@
 struct fsl_gpio_soc_data {
 	/* SoCs has a Port Data Direction Register (PDDR) */
 	bool have_paddr;
+	bool have_dual_base;
 };
 
 struct vf610_gpio_port {
@@ -60,13 +61,26 @@ struct vf610_gpio_port {
 #define PORT_INT_EITHER_EDGE	0xb
 #define PORT_INT_LOGIC_ONE	0xc
 
+#define IMX8ULP_GPIO_BASE_OFF	0x40
+#define IMX8ULP_BASE_OFF	0x80
+
+static const struct fsl_gpio_soc_data vf610_data = {
+	.have_dual_base = true,
+};
+
 static const struct fsl_gpio_soc_data imx_data = {
 	.have_paddr = true,
+	.have_dual_base = true,
+};
+
+static const struct fsl_gpio_soc_data imx8ulp_data = {
+	.have_paddr = true,
 };
 
 static const struct of_device_id vf610_gpio_dt_ids[] = {
-	{ .compatible = "fsl,vf610-gpio",	.data = NULL, },
+	{ .compatible = "fsl,vf610-gpio",	.data = &vf610_data },
 	{ .compatible = "fsl,imx7ulp-gpio",	.data = &imx_data, },
+	{ .compatible = "fsl,imx8ulp-gpio",	.data = &imx8ulp_data, },
 	{ /* sentinel */ }
 };
 
@@ -263,19 +277,38 @@ static int vf610_gpio_probe(struct platform_device *pdev)
 	struct gpio_irq_chip *girq;
 	int i;
 	int ret;
+	bool dual_base;
 
 	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
 	if (!port)
 		return -ENOMEM;
 
 	port->sdata = of_device_get_match_data(dev);
-	port->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(port->base))
-		return PTR_ERR(port->base);
 
-	port->gpio_base = devm_platform_ioremap_resource(pdev, 1);
-	if (IS_ERR(port->gpio_base))
-		return PTR_ERR(port->gpio_base);
+	dual_base = port->sdata->have_dual_base;
+
+	/* support old compatible strings */
+	if (device_is_compatible(dev, "fsl,imx7ulp-gpio") &&
+	    (device_is_compatible(dev, "fsl,imx93-gpio") ||
+	    (device_is_compatible(dev, "fsl,imx8ulp-gpio"))))
+		dual_base = true;
+
+	if (dual_base) {
+		port->base = devm_platform_ioremap_resource(pdev, 0);
+		if (IS_ERR(port->base))
+			return PTR_ERR(port->base);
+
+		port->gpio_base = devm_platform_ioremap_resource(pdev, 1);
+		if (IS_ERR(port->gpio_base))
+			return PTR_ERR(port->gpio_base);
+	} else {
+		port->base = devm_platform_ioremap_resource(pdev, 0);
+		if (IS_ERR(port->base))
+			return PTR_ERR(port->base);
+
+		port->gpio_base = port->base + IMX8ULP_GPIO_BASE_OFF;
+		port->base = port->base + IMX8ULP_BASE_OFF;
+	}
 
 	port->irq = platform_get_irq(pdev, 0);
 	if (port->irq < 0)

-- 
2.37.1

