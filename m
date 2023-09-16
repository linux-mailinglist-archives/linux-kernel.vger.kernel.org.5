Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 648A27A2D3A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 04:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238133AbjIPCAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 22:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232867AbjIPB77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 21:59:59 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2040.outbound.protection.outlook.com [40.107.6.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047D61BF8;
        Fri, 15 Sep 2023 18:59:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nmGpvWn1xEeye6q9ricAS9ztOWfCtypDHeUiHkk4hROaJ5aNvOOe2X43zBEitaCZ56C2hnleswa5wMedB6UT/72rvosefCZsOsUrhLfpuHKjbDuJl76g8U6f2B9wpSn39ttxoP4z7O3biUMcqD8G3EEAZGDynd/tUHAM6uuw+FRQqUWHOpzSyHoYATX4qA+NVXxF5ejyFPFH60z0pbLKptH7qB3B/qpQ2HyHiT7AJVaw5Y42CCbft8FAlPoGERxM+6f0pts7KwFKTHbT2fI0nnGY7Fv9uC6V9CnDT31EwHk6sAscBKUd/qU9QZwNvlx470cjKFMrVFeraWgh8WTQww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U44AIPwM+ReyZbAGkQOUHn8DaaTMrFWFFP3j5j+CWfk=;
 b=BBR7Mbnac71K5Y9dB1dqKhvwGG9gydrOE9gUC/kP0tfUDY//14+wBvqtZZp8+WzGUIP4RC0N73pk5MXrVeGbRU4kUM9HLsO4S6Yr+HCzwuYIeWTKYgC0pzoh8ckCd/zWuG/ycrxu929yqOATi/xpGI9FXotkKMaJJWU19tcS6WPWTk7kvXcMymjHiaZxUdPUExxa2eZiR3nTo8mDE2osx1/om/ycPF6N4zrztZSBcgOEfyC1d2GxN8xADyhxI9oFuNK/QzEkq873v+5f15B2zZuQLQviMUYoQBQY86akzH0aDbfk7yruLmX2Uyod0S9NxOrvuWpwvM1H0AkPMF2b/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U44AIPwM+ReyZbAGkQOUHn8DaaTMrFWFFP3j5j+CWfk=;
 b=Rphp4F5bRq9lnmuOpbU17rYxqFh0SOzA4VTJooaGKZ5QIxWZd2F2mC5PWI6SgkNNGX1bQIh0XobHU9wW+ifxEDSY4dfDA1OjMUicQPfn6TBHxorwdceyq/oQcmFaVlzf8zWB56U2DIOjVvU3mqhmxdH6ORLnXkuIMXv8DOUHnfg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB9142.eurprd04.prod.outlook.com (2603:10a6:20b:449::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.23; Sat, 16 Sep
 2023 01:59:50 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6792.023; Sat, 16 Sep 2023
 01:59:50 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date:   Sat, 16 Sep 2023 10:04:00 +0800
Subject: [PATCH v2 4/6] gpio: vf610: add i.MX8ULP of_device_id entry
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230916-vf610-gpio-v2-4-40823da788d7@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694829858; l=3349;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=KIwUQXLlZAXkxFxtSdDA1eXGhBoOZN8UxphNKaoctdo=;
 b=rsPREGTFgFZ7Oo3ugxbzuQ6T6Xj503wa60wt9WnseGHdql8z6Sb9KCXpo0Ny8ZXps/oEK8dwh
 UOPxaXqWg78CqXUEDOGMWzFxUj5Q/An/f2JOEOH8YSUVV7KOix8SWEV
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR06CA0004.apcprd06.prod.outlook.com
 (2603:1096:4:186::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB9142:EE_
X-MS-Office365-Filtering-Correlation-Id: c44f3632-2eff-491b-4d98-08dbb6589c6a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dAD2HTMcq30kOiwhR+Xbu7AXhdW+/YT/UWrWGk99VPUfVBkMVSNtzSYvkDgYIkYlDSuQkTtKWl7+IvOeVutJHb43zHFR1W4whjDFYgx6gh4szSkUUKX1haXU7k0X6gZqWM6EIrSfwBvH67bGggLbrCC85C9tEr9sfzOkolmQq13Tge7M59gdEQT+LrOSbde4LPbiH+Bwi5+qPxa66yuVGeKiFb5dpp7mf5pkuH8ntSzdD2roWYdJ2ylsaB3gAixfZx40jKySppu9dXPNP4obDfJiS34SBZARtVpr5hqG04fmOkZiq4A1XeZsD51Uc2zyxTQgouufWW0c6ZY0ZN2w1twXf++OuXwwd6w1ekQMrXDVuwcEyeL+hXx7N/E4prxna12WcKJ/kZ42uIXoGccT9d9fb8sQlMVFG5MW+NseNpkd9dcM+/J0HW7QFMqF9Uo4SMEPbMMgI0bHgM6yH2rihnKw62YJNGjpmwQjBBTUquy1r8nYTxsSCfTk1/uF5/hScpzgFaCf9GwIbOtqCFXdZ1wuhYThLb3zcJCbBZq/a87M0HYmItyiuNH682DJXAqdO4QR9nhoU592i/l7LOOyBaTzPJjVQKfFD0Jrji23k5K14RIq8iNcNTX6K7GECXruZm9n+neIfXdsTcYGabWsnw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(136003)(346002)(39860400002)(451199024)(186009)(1800799009)(6666004)(6512007)(6506007)(6486002)(5660300002)(66476007)(66556008)(66946007)(110136005)(316002)(26005)(52116002)(9686003)(41300700001)(921005)(8936002)(8676002)(4326008)(478600001)(83380400001)(2906002)(86362001)(7416002)(36756003)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHZOQ2hlQ0lmYlgxSmdiSUExa3dERE9WWDNyTWxTMW5WZVFkZmVxMDdFamZH?=
 =?utf-8?B?aE9jTVpJbjBlcGN6NUdxblQvVWdEMVZwcDVwTVNRUENQdmVMQ254bDh2T1hQ?=
 =?utf-8?B?aFJBQmdhQ0NDS1ZGSEZFY2R4WFljck5Mb05FdkhHSkJFY0J3OXhqamEzOGpW?=
 =?utf-8?B?d3F6NkNsdVoreHlSRlNaZWk0OFpBNVpaa1JaUGxMekRBWS9haEdGZTZPN0NS?=
 =?utf-8?B?R1oxeVJpK29FZUhXLzNROGVWcC9KWjdQTm1QRVJEOHdra0pubExLRkpUSENs?=
 =?utf-8?B?R1czY2FqUDB6Vk1VdGhRWVNQQ1pocXBSYWdUcDU5T3R0b0J5a0hNNjNOYlJD?=
 =?utf-8?B?TmtCWklsZ0RERjIvd1kxYlBhV0JuR2RQSDBIeHIzOTBXVTkwRkh0Z0hIRng0?=
 =?utf-8?B?a1l4b0VncmloSkM5VmdrS0hQMjhsQmFhcWJCMTB1Qk5UWVJQZVkzM2xJaXpT?=
 =?utf-8?B?YzlCdGNjbTYvNnVDKzhBd1ZENEtBR3J1aGJxZE1UcXFjeC9OOXQzM09STVN6?=
 =?utf-8?B?MkJpYmorOW5IM3BSS1Z3UGtzZVVxNFNuWUs1aXZRZ2NlQ2dMWTFER000WklT?=
 =?utf-8?B?b1B5NEwrVnZKUURjL2ZwcEdtQkVnZFVaenJ1YzcwaTdRVE5xb2FaTkhhYjE3?=
 =?utf-8?B?U3BLZ2V6b0YyVGhYRk9IU1owUTVmdGFOcVR0dHdxNDAweHNGZUR0TWhRbXBp?=
 =?utf-8?B?VmluNjFoVWRZdVRQN1BJN2E3VTdLb0F6Z1dQbndGL1c1cXZVZXdaUXNoYmpv?=
 =?utf-8?B?MDV4bFl6d0YyR2xEalNMcGpCblNhT05nTE5Xc2ttdnowNjVJQXRWYmJZcEtZ?=
 =?utf-8?B?WnJNeWcxbWVyQjc2djNJTm9FU2xVT3FOUnFYUzl6NGNIR3pIQ0N2QlpCV2lJ?=
 =?utf-8?B?TUhwWUZPOHpoV0VOT3NRSCtPd1BaV0dBcXZEZGZuMndXYjN5UU4vWkYvSmxr?=
 =?utf-8?B?OHNCNW8yNHNEbGtFeGNLNWNCVVVZdzRMcEsvS2loTWg4cFZ2ZUVwaDN3N3A0?=
 =?utf-8?B?ODZoMnBqazhtQTdNaUNEb1F0Z1FwZGxGaW5BYUc5dHp6NDU0T09INEFPanVl?=
 =?utf-8?B?NXhkcDFieU9rcytTL3Y2YjFOM1lXdVlQeWtOcSt2RmtkK0xOUVFPWEFEb3NX?=
 =?utf-8?B?WmVGRWE3RzJOUFhEVVkwTG9vWTR1dFVvQjZuM1FLVmV4QWprMDZGa1U1Q1lU?=
 =?utf-8?B?ckJ5Vy92T1Yrd25Ga0tXSUhvNU9KeGY3cW9uQ3dDalUvNk1rQzJXZlJIc1Uw?=
 =?utf-8?B?S0c1eWc1c3hEQncwNEhTVjY3Qkttai85Um03U0lKNC9kZXh2c1pwWlJ1Yzgv?=
 =?utf-8?B?YmIwQ3RRZGw4eDZXSEx5NkxsYzZSWGN5UkFkcXA3Lzd0VEg0MVJKd29ZdUc2?=
 =?utf-8?B?Z21xMEkxL3Iya1FQbDJUMmxJeGthVm9UUDdJcTVOR2w5eTNkRytBeHV4djZZ?=
 =?utf-8?B?VzJuV2xqdVVnV01ZaXQzczdjWllsbS9KRzZ1R1VuUXozeXRWdU1oTTFHamxo?=
 =?utf-8?B?bys0Qi9Rd2VlRmkzTnZHQ1N0U1pVVzRBc2xnRHdJN0F5S3RFdm95YUpDU1Zv?=
 =?utf-8?B?R3hhc0RuSGNRQU83eUJOamcvWGFMaVZXb2hIYmQ0SHNTQTJKSWdXek52MVJ2?=
 =?utf-8?B?WkswTVdEZkVWd2ZZb0kzOXg1dThhNWhETnFvY0wwR3VrWko1NTNCd1Bacno2?=
 =?utf-8?B?VzF5KzE5QmRvU0NyZmFFcU0zelpMM0ovUVZhSU1EWnJUam9DOW90MTI3UnZl?=
 =?utf-8?B?aERjeHM4Q3NlT3pQSVNJUnJlNGhHOXVWbGhsWFgvcmNCWnA5S2cwVG9aalND?=
 =?utf-8?B?RDhPQmdQeUFkdlNYcGVTNDBremtQWkptSjdybEgzckhscXVQa0NlTzQyUlNC?=
 =?utf-8?B?L2Z3SUZ6OE5PVzBzbE9tdDFBK3h3NTVJVmtMU1RZRUt5VHZ5TEZtMDJJWXcz?=
 =?utf-8?B?b1NjdUwzQnRmdGllOExHYkltZVZLQ3Z4a2NzeExDQ0pmenRSVzNuOTJIWUk5?=
 =?utf-8?B?cWhQYmRZKzBjUzlXY1k5L3gwUG1WUjFaWXFhb3NOT012ZGRFTExEZllka0Fx?=
 =?utf-8?B?RFZzazBCbVZEazl0S29sK0gyUFBGaGhPdTA0MzVuV1VudU1HOFNGL2xLTTc4?=
 =?utf-8?Q?5QsEjdYAvw3jsdpIwvAfmvq9i?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c44f3632-2eff-491b-4d98-08dbb6589c6a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2023 01:59:50.1871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xgp6Qu7M4iSJPUGvgLdW6Cq90xfiFenC0Fmj+i/phLa2PJfniaiogVu5S/zIJ5vuWYLViKBXCIsLabTPwlsfqg==
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

i.MX8ULP GPIO supports similar feature as i.MX7ULP GPIO, but i.MX8ULP is
not compatible with i.MX7ULP per binding doc. i.MX8ULP only has one
register base, not two base.

Add a new of_device_id entry for i.MX8ULP. But to make the driver could
also support old bindings, check the compatible string first, before
check the device data.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/gpio/gpio-vf610.c | 55 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 49 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
index dbc7ba0ee72c..ef2455093708 100644
--- a/drivers/gpio/gpio-vf610.c
+++ b/drivers/gpio/gpio-vf610.c
@@ -25,6 +25,7 @@
 struct fsl_gpio_soc_data {
 	/* SoCs has a Port Data Direction Register (PDDR) */
 	bool have_paddr;
+	bool is_imx8ulp;
 };
 
 struct vf610_gpio_port {
@@ -60,13 +61,22 @@ struct vf610_gpio_port {
 #define PORT_INT_EITHER_EDGE	0xb
 #define PORT_INT_LOGIC_ONE	0xc
 
+#define IMX8ULP_GPIO_BASE_OFF	0x40
+#define IMX8ULP_BASE_OFF	0x80
+
 static const struct fsl_gpio_soc_data imx_data = {
 	.have_paddr = true,
 };
 
+static const struct fsl_gpio_soc_data imx8ulp_data = {
+	.have_paddr = true,
+	.is_imx8ulp = true,
+};
+
 static const struct of_device_id vf610_gpio_dt_ids[] = {
 	{ .compatible = "fsl,vf610-gpio",	.data = NULL, },
 	{ .compatible = "fsl,imx7ulp-gpio",	.data = &imx_data, },
+	{ .compatible = "fsl,imx8ulp-gpio",	.data = &imx8ulp_data, },
 	{ /* sentinel */ }
 };
 
@@ -255,6 +265,42 @@ static void vf610_gpio_disable_clk(void *data)
 	clk_disable_unprepare(data);
 }
 
+static int vf610_gpio_map_base(struct platform_device *pdev, struct vf610_gpio_port *port)
+{
+	struct device *dev = &pdev->dev;
+	bool dual_base;
+
+	/* support old compatible strings */
+	if (device_is_compatible(dev, "fsl,imx7ulp-gpio") &&
+	    (device_is_compatible(dev, "fsl,imx93-gpio") ||
+	    (device_is_compatible(dev, "fsl,imx8ulp-gpio")))) {
+		dual_base = true;
+	} else if (port->sdata && port->sdata->is_imx8ulp) {
+		dual_base = false;
+	} else {
+		dual_base = true;
+	};
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
+
+	return 0;
+}
+
 static int vf610_gpio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -269,13 +315,10 @@ static int vf610_gpio_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	port->sdata = of_device_get_match_data(dev);
-	port->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(port->base))
-		return PTR_ERR(port->base);
 
-	port->gpio_base = devm_platform_ioremap_resource(pdev, 1);
-	if (IS_ERR(port->gpio_base))
-		return PTR_ERR(port->gpio_base);
+	ret = vf610_gpio_map_base(pdev, port);
+	if (ret)
+		return ret;
 
 	port->irq = platform_get_irq(pdev, 0);
 	if (port->irq < 0)

-- 
2.37.1

