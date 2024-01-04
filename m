Return-Path: <linux-kernel+bounces-16529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3841F823FBC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB152282010
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE9021A01;
	Thu,  4 Jan 2024 10:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="KEcEJ8VY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2047.outbound.protection.outlook.com [40.107.241.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6E421376;
	Thu,  4 Jan 2024 10:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dpSte67HKY5PcKV7jBjd2j3hlBKXp/c57AoC9Oki84gtu1ybmyM0WKS+5rcFnGSOjIusC9H5l5WAG0uH3bIr+839LrEX0w0mzXQ86+vmzzuwBvqPmL4sc/fxUmvfmhudYW2vh7Feqt+1486imlWC9kX0UhUmwP2Xc/pZHs9YyzYvxMMf4djZn4Yv/zND9pIiegdnSabzBd5i9F9PjN3nsjEZaVGOigsWM/npNLsUMGXSC+sh9gNY6Om66JFqCfCChzsnGn1pJcGVHOzWCDfn8xgYKV5oO2/+52c3UM83Hz+DbQKx56Zzqn7wHRE0+Kt6iW8nltjHJCSQYUGftfftkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9RB2NHo/fYiKMwFb0jNvCwZrzOOaa97W60fFoi29rg8=;
 b=IAOCsPV3fSKm3ZFPI9NiRx88wLrdFp1ajsIFf+DfHUzk4jnsXdHyRxt5GpMG1vSLCFDezPn8IepOJsfqAcp+bclHRuQoTTKa+8MMTBxJ9JuRH4BeFjVQELaHlL9iQPzeEWFp9WcIkvkXNe7Vozt9axTlUveFfd3RpMqmU+SEalKgIIIa2kq1VKIoWJkuwyc/Ii1Fg4DreZtdEWxXmbcpj6w3bAs2XS4ycFCrse4gVqyMJ4Tb6tlOArGvWhYLdQvwSmHxFMvA1FJkYI2N+pInxXCe+SukJr7rObA6M7msy30Fs5QkAQ7X2D4bth+yzP/nIQgeKJiB9Dgkl4eiYZaDXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9RB2NHo/fYiKMwFb0jNvCwZrzOOaa97W60fFoi29rg8=;
 b=KEcEJ8VY0OKl7D8jMn/VjKYJnFQC59A37+kt8i2tCkdrTFiB3L7cPkhidEaCfsrghfoSrIEuQ6m9awZef4ybDOzmcSF9N6VqMyh1dA2INKXVXz7R8C7EgI2WbSEn9B6roNHhua9uT1vcgcGZJtfRZp0S2z8wb/nWCu47wPwz0no=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8847.eurprd04.prod.outlook.com (2603:10a6:102:20e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Thu, 4 Jan
 2024 10:45:07 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ff06:bbb2:c068:5fb3]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ff06:bbb2:c068:5fb3%7]) with mapi id 15.20.7135.023; Thu, 4 Jan 2024
 10:45:07 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 04 Jan 2024 18:48:48 +0800
Subject: [PATCH v2 4/6] pinctrl: Implementation of the generic scmi-pinctrl
 driver
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240104-pinctrl-scmi-v2-4-a9bd86ab5a84@nxp.com>
References: <20240104-pinctrl-scmi-v2-0-a9bd86ab5a84@nxp.com>
In-Reply-To: <20240104-pinctrl-scmi-v2-0-a9bd86ab5a84@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Oleksii Moisieiev <oleksii_moisieiev@epam.com>, 
 Linus Walleij <linus.walleij@linaro.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
 AKASHI Takahiro <takahiro.akashi@linaro.org>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704365357; l=17128;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=sieGniu0UyEJ3MN5HvOjYsYbKv/d/KecFgmaODuXpu8=;
 b=LQ6ET6szHpOH2rga2Kgo+H8jYOaRPvBWbd0QbHZpZ6/leboz10a3SZ1jQ0xrnczqKDNJV1p0k
 t1Y3UDL9GURB0Rg62Ilc5F9GXGLuU4YwrY1IS7e1ZMHyLBhcJgZ5XQU
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG3P274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::16)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8847:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aca705a-cda5-4ad4-b772-08dc0d123787
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	duU+4g8LeqW1zVm2GQsmgXtZMWq6aqpHMQKeT/Jj/hNz2DVdijWcHXgIbjPnUMqP/0gM8joV4IXfxkCPtAEwvNH//+G76CNDfIFxgWEtH/BtHcaZKoOr71NCPk9k+hE8Gl+KqNRmNbYd2bf5ZbuwL/J904h1lUI1FfpbTj6ckxn79c1hAdQ287+AVJlxR5T9QYmsUDA3evUJW2w47AlpbWjje4daJIZq6C95Q3tC/kq3koXKtytRb+hd2GZl9awk1OHkj90dF30HF/0loyA+q9smMjIEg5DlyWZ8CQO4EZR475E5GfhGBiEj4A3CruvGG1kseV+J9ogazX+HwpdGgzRYS/Izx//5mMoyckZw4LNeXQG+N3J+rDP3V37vxWiQPWDD8644XYUKou6batwNffQB6lMk09gj8rRcz9DjjohaXOtQAS6PD9/FW61DftDwabm5xyyan+Q4ut0kTPnVsf5NLj1frUnBYSYUAftik6M1Qzca072LE9r+PLBbcMq8ScGyzBOOFcSY4d8TP5UcPWhvPfX5Wjxx/lnk0K5oxxxEnob0IY3sikAMTqivo8q2jFhqTouJSHBELET4l+Fa8LLmrP7eY3dFIABfXNAoDKbcPQmj/oJoxcQM3ZzfkYREYIh45Bu1DF2/vj8BBqB151mgwpOB3lYVNEi/YzjsC0w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(39860400002)(396003)(136003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(66476007)(66946007)(66556008)(6486002)(4326008)(8936002)(8676002)(26005)(54906003)(110136005)(316002)(83380400001)(6666004)(478600001)(52116002)(5660300002)(41300700001)(30864003)(2906002)(7416002)(6506007)(6512007)(9686003)(38350700005)(921011)(36756003)(38100700002)(86362001)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0JHckozMDhoK1dRQi9MY1RPaXF5andZcCttb3ZaTlhKQWoxUXNHYUJxdlkw?=
 =?utf-8?B?aDl0VTdzK3pxUjFIRGxPOHBrWERkZCtFTE8reDc1QUoweEVpdTZIZWQzQzFo?=
 =?utf-8?B?VWZNMUJKQkJ3NXhZWFUwUHdZSE9GaWdreUtJVFlBRFRla3NoM3NLRGhrM1pL?=
 =?utf-8?B?R3ltTDNJakdRK0RSam1GZVNjN00xSWloZ0dlVHY3Q1d1MUdXa0IrQ3NaSldp?=
 =?utf-8?B?RlFFU25aK3VPd3FLYVpHYXNhaHRLMmJHS1laVkxNZHNNSzVDb2FrSHNNdGpY?=
 =?utf-8?B?ZmlNQ0RUUFVaRWY3TkhRUzlRdHdqZ2FSaXJ2NDhIVzVNeGR1dWVqcVpldTBH?=
 =?utf-8?B?UXNYQlFxaGhUeW9jOUlMZUZ0Y3NTTDlQbGpPZDlaTEJRMFBJTVBJMzZRVWpP?=
 =?utf-8?B?ZENrMS96c0RNOFlNRzFiMVJONFVEVlpSZlJsTHZsZWRZcGphd0dDYmZQcnZh?=
 =?utf-8?B?N2hrb241d2Q4SWJyeU9BSzM4T0N5bUptejF6a3dsUVl0Y2hrZUp5OWZuUWFF?=
 =?utf-8?B?SG9OT1Y5a1VYU2FEUHVCU1ppb29qckhnT2s0Z2NmeXk2OUxHQVRFdmVNOFJm?=
 =?utf-8?B?Z0VJbVNqaithUzRDMnhMN2ZyZ3lIamx0eEZjWE90NzcxbnNGOXN5ZVUwODg5?=
 =?utf-8?B?Q0NtSEluamM3OVV1NENQU0xHUXhJL1BZRjN0dFBMWG9ha2FEbHZnL0tES2Js?=
 =?utf-8?B?dnA1QkVoazB6dDNqVVJCUjhaOEJsbG9WQmJuTm5uREFNanQwRlEwdWNmbjRB?=
 =?utf-8?B?dkt2eGp2NEo1QXJjcmphNzE2Z2VBMkprS1JHNWZmWUFzeUZvVEJtYTMybFgy?=
 =?utf-8?B?ZnVvVDNJdk9ZZ0duK25QTGU1SHRlMlhsUmM1eklibWFocGFIeW1jSGJPblFo?=
 =?utf-8?B?SW1NaVYzekE0dzhBZERDN1hreFZ2Z2tHMEJYbnVjR3NsZWdlOTlsZDhuOWg5?=
 =?utf-8?B?d3Y2NVM2RjZOTEx1OGdvSFlIL01vOTgvMVhmQjhVdy80VmZhaFlnTjdQV2lk?=
 =?utf-8?B?d0pZemZJZG9BS20rZHdiTy9BZk4rRTNuOGp2NEwybk9kd1ZNYWI2RjRlOGNo?=
 =?utf-8?B?ajVnTkEvSkd4UUp4OE5SOWhvWENRcEhQSVM2NnJWengzTzFuR1hka3YwaVVv?=
 =?utf-8?B?U1d2bU5MN0Q1K2tOZ1hLQmNxZUFtTzQ5T0JNSXZ6TGZQVExtMlJuamx1a29Y?=
 =?utf-8?B?YitwLzVlbXhmaHJiM3B1eGxZRnh0aGp1SGl4NFVlK29KYVN6dlIxZnVUaFZt?=
 =?utf-8?B?WUpNMFJqUGpqbXdXSllmUUNYMERzbHExRDB3dzl2Z0o1Z3VZUDk4ZndNT2k1?=
 =?utf-8?B?dEd3dFhUUmVQV1Q3ejh4ZUp6Qy96aC9oL1NiK3N5SHEzVlNGU2VqbVNDenhG?=
 =?utf-8?B?emZzaUpOQjJGeHNYSlcyYk5PdWNtdHVuSmMrVDRseURwMWVudlM3Uzlmc0Zz?=
 =?utf-8?B?cEZHRnlNRHloTkttUmhnTTcyL1ZScjM1L0Y1NVFZTVQ2d0JyZVdKTVFLVUk1?=
 =?utf-8?B?MGJpRDRWVVhCenhvdGNNK1VHa1VzTXB5dndkbE5JQkxXUHVNQ3FJNjFpMC95?=
 =?utf-8?B?T3YyeDhPMUU1Vk5DUVgyZ2ZUQ24vL0V6YW9TVlkzc2VBaTRlYVlsT0hqbFA0?=
 =?utf-8?B?YlQyV3VuSmtUR2JrdkZOSmZEUlNmS3FTVXl4Q05YYSsxUHFoS1JOQkpjbnhq?=
 =?utf-8?B?M1BFakhDUno1d2VheUFNTUlRRTFkSzRQM1RqaytJbE14WERNdE5WcXppL3dv?=
 =?utf-8?B?Qjl3bnFzWjdjNjZ1Z01CMlpDSmJ0eUtIeDFsTlE0aEluZllmVDkvUU5Cd2VC?=
 =?utf-8?B?b2haU0JIWkdyaitGcVVoeGpycmY3cFEwbnM5aEJDSCt5SG1YVG04dms2cXls?=
 =?utf-8?B?Tmgvd0loQVdjUm8rNHduU3J4NnpPMFVhTlVVTFNZUTZJRk9adHZYTDdVcHI2?=
 =?utf-8?B?RWNxTWk0WnplV08yMENWdzhNTUNjVE5ZWXdvdmJzZkJaRUZoSHZ4UjF4M3Bo?=
 =?utf-8?B?QllMOEx3T0hkeWZMYkpsM2xKdGkrZ0hYMG83MXZlZm1GaTQ2NFN0bTA0T1hN?=
 =?utf-8?B?MlU3bit5U1dSdmNXV2I4ZC94MnBLUHd1WFl1WXZ4aDRvUGtNK29GaTNYZ25E?=
 =?utf-8?Q?tWjztxTfsFHivYQI1Ykrg0dwB?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aca705a-cda5-4ad4-b772-08dc0d123787
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 10:45:07.3224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Py0zFD1LbGcSINm6EsSVWopqPg62PerQoMXEyQ04e1+kv0pVQ3h8jVGB0osxK4sHzQn0lEIXupvTU4xVfpbIUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8847

From: Peng Fan <peng.fan@nxp.com>

scmi-pinctrl driver implements pinctrl driver interface and using
SCMI protocol to redirect messages from pinctrl subsystem SDK to
SCMI platform firmware, which does the changes in HW.

Co-developed-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 MAINTAINERS                    |   1 +
 drivers/pinctrl/Kconfig        |  11 +
 drivers/pinctrl/Makefile       |   1 +
 drivers/pinctrl/pinctrl-scmi.c | 524 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 537 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 487bff0d44c0..3fe790e90834 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21314,6 +21314,7 @@ F:	drivers/clk/clk-sc[mp]i.c
 F:	drivers/cpufreq/sc[mp]i-cpufreq.c
 F:	drivers/firmware/arm_scmi/
 F:	drivers/firmware/arm_scpi.c
+F:	drivers/pinctrl/pinctrl-scmi.c
 F:	drivers/pmdomain/arm/
 F:	drivers/powercap/arm_scmi_powercap.c
 F:	drivers/regulator/scmi-regulator.c
diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 8163a5983166..27b26e428f60 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -432,6 +432,17 @@ config PINCTRL_ROCKCHIP
 	help
           This support pinctrl and GPIO driver for Rockchip SoCs.
 
+config PINCTRL_SCMI
+	tristate "Pinctrl driver using SCMI protocol interface"
+	depends on ARM_SCMI_PROTOCOL || COMPILE_TEST
+	select PINMUX
+	select GENERIC_PINCONF
+	help
+	  This driver provides support for pinctrl which is controlled
+	  by firmware that implements the SCMI interface.
+	  It uses SCMI Message Protocol to interact with the
+	  firmware providing all the pinctrl controls.
+
 config PINCTRL_SINGLE
 	tristate "One-register-per-pin type device tree based pinctrl driver"
 	depends on OF
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index 1071f301cc70..ba755ed2d46c 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -44,6 +44,7 @@ obj-$(CONFIG_PINCTRL_PIC32)	+= pinctrl-pic32.o
 obj-$(CONFIG_PINCTRL_PISTACHIO)	+= pinctrl-pistachio.o
 obj-$(CONFIG_PINCTRL_RK805)	+= pinctrl-rk805.o
 obj-$(CONFIG_PINCTRL_ROCKCHIP)	+= pinctrl-rockchip.o
+obj-$(CONFIG_PINCTRL_SCMI)	+= pinctrl-scmi.o
 obj-$(CONFIG_PINCTRL_SINGLE)	+= pinctrl-single.o
 obj-$(CONFIG_PINCTRL_ST) 	+= pinctrl-st.o
 obj-$(CONFIG_PINCTRL_STMFX) 	+= pinctrl-stmfx.o
diff --git a/drivers/pinctrl/pinctrl-scmi.c b/drivers/pinctrl/pinctrl-scmi.c
new file mode 100644
index 000000000000..146308d27f54
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-scmi.c
@@ -0,0 +1,524 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * System Control and Power Interface (SCMI) Protocol based pinctrl driver
+ *
+ * Copyright (C) 2023 EPAM
+ * Copyright 2023 NXP
+ */
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/seq_file.h>
+#include <linux/scmi_protocol.h>
+#include <linux/slab.h>
+
+#include <linux/pinctrl/machine.h>
+#include <linux/pinctrl/pinconf.h>
+#include <linux/pinctrl/pinconf-generic.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinmux.h>
+
+#include "pinctrl-utils.h"
+#include "core.h"
+#include "pinconf.h"
+
+#define DRV_NAME "scmi-pinctrl"
+
+static const struct scmi_pinctrl_proto_ops *pinctrl_ops;
+
+struct scmi_pinctrl_funcs {
+	unsigned int num_groups;
+	const char **groups;
+};
+
+struct scmi_pinctrl {
+	struct device *dev;
+	struct scmi_protocol_handle *ph;
+	struct pinctrl_dev *pctldev;
+	struct pinctrl_desc pctl_desc;
+	struct scmi_pinctrl_funcs *functions;
+	unsigned int nr_functions;
+	char **groups;
+	unsigned int nr_groups;
+	struct pinctrl_pin_desc *pins;
+	unsigned int nr_pins;
+	u8 *config_type;
+	u32 *config_value;
+};
+
+static int pinctrl_scmi_get_groups_count(struct pinctrl_dev *pctldev)
+{
+	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
+
+	return pinctrl_ops->count_get(pmx->ph, GROUP_TYPE);
+}
+
+static const char *pinctrl_scmi_get_group_name(struct pinctrl_dev *pctldev, unsigned int selector)
+{
+	int ret;
+	const char *name;
+	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
+
+	ret = pinctrl_ops->name_get(pmx->ph, selector, GROUP_TYPE, &name);
+	if (ret) {
+		dev_err(pmx->dev, "get name failed with err %d", ret);
+		return NULL;
+	}
+
+	return name;
+}
+
+static int pinctrl_scmi_get_group_pins(struct pinctrl_dev *pctldev,
+				       unsigned int selector,
+				       const unsigned int **pins,
+				       unsigned int *num_pins)
+{
+	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
+
+	return pinctrl_ops->group_pins_get(pmx->ph, selector, pins, num_pins);
+}
+
+static const struct pinctrl_ops pinctrl_scmi_pinctrl_ops = {
+	.get_groups_count = pinctrl_scmi_get_groups_count,
+	.get_group_name = pinctrl_scmi_get_group_name,
+	.get_group_pins = pinctrl_scmi_get_group_pins,
+#ifdef CONFIG_OF
+	.dt_node_to_map = pinconf_generic_dt_node_to_map_all,
+	.dt_free_map = pinconf_generic_dt_free_map,
+#endif
+};
+
+static int pinctrl_scmi_get_functions_count(struct pinctrl_dev *pctldev)
+{
+	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
+
+	return pinctrl_ops->count_get(pmx->ph, FUNCTION_TYPE);
+}
+
+static const char *pinctrl_scmi_get_function_name(struct pinctrl_dev *pctldev,
+						  unsigned int selector)
+{
+	int ret;
+	const char *name;
+	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
+
+	ret = pinctrl_ops->name_get(pmx->ph, selector, FUNCTION_TYPE, &name);
+	if (ret) {
+		dev_err(pmx->dev, "get name failed with err %d", ret);
+		return NULL;
+	}
+
+	return name;
+}
+
+static int pinctrl_scmi_get_function_groups(struct pinctrl_dev *pctldev,
+					    unsigned int selector,
+					    const char * const **groups,
+					    unsigned int * const num_groups)
+{
+	const unsigned int *group_ids;
+	int ret, i;
+	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
+
+	if (!groups || !num_groups)
+		return -EINVAL;
+
+	if (selector < pmx->nr_functions &&
+	    pmx->functions[selector].num_groups) {
+		*groups = (const char * const *)pmx->functions[selector].groups;
+		*num_groups = pmx->functions[selector].num_groups;
+		return 0;
+	}
+
+	ret = pinctrl_ops->function_groups_get(pmx->ph, selector,
+					       &pmx->functions[selector].num_groups,
+					       &group_ids);
+	if (ret) {
+		dev_err(pmx->dev, "Unable to get function groups, err %d", ret);
+		return ret;
+	}
+
+	*num_groups = pmx->functions[selector].num_groups;
+	if (!*num_groups)
+		return -EINVAL;
+
+	pmx->functions[selector].groups =
+		devm_kcalloc(pmx->dev, *num_groups, sizeof(*pmx->functions[selector].groups),
+			     GFP_KERNEL);
+	if (!pmx->functions[selector].groups)
+		return -ENOMEM;
+
+	for (i = 0; i < *num_groups; i++) {
+		pmx->functions[selector].groups[i] =
+			pinctrl_scmi_get_group_name(pmx->pctldev,
+						    group_ids[i]);
+		if (!pmx->functions[selector].groups[i]) {
+			ret = -ENOMEM;
+			goto err_free;
+		}
+	}
+
+	*groups = (const char * const *)pmx->functions[selector].groups;
+
+	return 0;
+
+err_free:
+	devm_kfree(pmx->dev, pmx->functions[selector].groups);
+
+	return ret;
+}
+
+static int pinctrl_scmi_func_set_mux(struct pinctrl_dev *pctldev, unsigned int selector,
+				     unsigned int group)
+{
+	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
+
+	return pinctrl_ops->mux_set(pmx->ph, selector, group);
+}
+
+static int pinctrl_scmi_request(struct pinctrl_dev *pctldev, unsigned int offset)
+{
+	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
+
+	return pinctrl_ops->pin_request(pmx->ph, offset);
+}
+
+static int pinctrl_scmi_free(struct pinctrl_dev *pctldev, unsigned int offset)
+{
+	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
+
+	return pinctrl_ops->pin_free(pmx->ph, offset);
+}
+
+static const struct pinmux_ops pinctrl_scmi_pinmux_ops = {
+	.request = pinctrl_scmi_request,
+	.free = pinctrl_scmi_free,
+	.get_functions_count = pinctrl_scmi_get_functions_count,
+	.get_function_name = pinctrl_scmi_get_function_name,
+	.get_function_groups = pinctrl_scmi_get_function_groups,
+	.set_mux = pinctrl_scmi_func_set_mux,
+};
+
+static int pinctrl_scmi_map_pinconf_type(enum pin_config_param param, u8 *type)
+{
+	u8 arg = param;
+
+	switch (arg) {
+	case PIN_CONFIG_BIAS_BUS_HOLD:
+		*type = SCMI_PIN_BIAS_BUS_HOLD;
+		break;
+	case PIN_CONFIG_BIAS_DISABLE:
+		*type = SCMI_PIN_BIAS_DISABLE;
+		break;
+	case PIN_CONFIG_BIAS_HIGH_IMPEDANCE:
+		*type = SCMI_PIN_BIAS_HIGH_IMPEDANCE;
+		break;
+	case PIN_CONFIG_BIAS_PULL_DOWN:
+		*type = SCMI_PIN_BIAS_PULL_DOWN;
+		break;
+	case PIN_CONFIG_BIAS_PULL_PIN_DEFAULT:
+		*type = SCMI_PIN_BIAS_PULL_DEFAULT;
+		break;
+	case PIN_CONFIG_BIAS_PULL_UP:
+		*type = SCMI_PIN_BIAS_PULL_UP;
+		break;
+	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
+		*type = SCMI_PIN_DRIVE_OPEN_DRAIN;
+		break;
+	case PIN_CONFIG_DRIVE_OPEN_SOURCE:
+		*type = SCMI_PIN_DRIVE_OPEN_SOURCE;
+		break;
+	case PIN_CONFIG_DRIVE_PUSH_PULL:
+		*type = SCMI_PIN_DRIVE_PUSH_PULL;
+		break;
+	case PIN_CONFIG_DRIVE_STRENGTH:
+		*type = SCMI_PIN_DRIVE_STRENGTH;
+		break;
+	case PIN_CONFIG_DRIVE_STRENGTH_UA:
+		*type = SCMI_PIN_DRIVE_STRENGTH;
+		break;
+	case PIN_CONFIG_INPUT_DEBOUNCE:
+		*type = SCMI_PIN_INPUT_DEBOUNCE;
+		break;
+	case PIN_CONFIG_INPUT_ENABLE:
+		*type = SCMI_PIN_INPUT_MODE;
+		break;
+	case PIN_CONFIG_INPUT_SCHMITT:
+		*type = SCMI_PIN_INPUT_SCHMITT;
+		break;
+	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
+		*type = SCMI_PIN_INPUT_MODE;
+		break;
+	case PIN_CONFIG_MODE_LOW_POWER:
+		*type = SCMI_PIN_LOW_POWER_MODE;
+		break;
+	case PIN_CONFIG_OUTPUT:
+		*type = SCMI_PIN_OUTPUT_VALUE;
+		break;
+	case PIN_CONFIG_OUTPUT_ENABLE:
+		*type = SCMI_PIN_OUTPUT_MODE;
+		break;
+	case PIN_CONFIG_OUTPUT_IMPEDANCE_OHMS:
+		*type = SCMI_PIN_OUTPUT_VALUE;
+		break;
+	case PIN_CONFIG_POWER_SOURCE:
+		*type = SCMI_PIN_POWER_SOURCE;
+		break;
+	case PIN_CONFIG_SLEW_RATE:
+		*type = SCMI_PIN_SLEW_RATE;
+		break;
+	case SCMI_PIN_OEM_START ... SCMI_PIN_OEM_END:
+		*type = param;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int pinctrl_scmi_pinconf_get(struct pinctrl_dev *pctldev, unsigned int _pin,
+				    unsigned long *config)
+{
+	int ret;
+	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
+	enum pin_config_param config_type;
+	u32 config_value;
+	u8 type;
+
+	if (!config)
+		return -EINVAL;
+
+	config_type = pinconf_to_config_param(*config);
+
+	ret = pinctrl_scmi_map_pinconf_type(config_type, &type);
+	if (ret) {
+		dev_err(pmx->dev, "Error map pinconf_type %d\n", ret);
+		return ret;
+	}
+
+	ret = pinctrl_ops->config_get(pmx->ph, _pin, PIN_TYPE, type, &config_value);
+	if (ret)
+		return ret;
+
+	*config = pinconf_to_config_packed(config_type, config_value);
+
+	return 0;
+}
+
+static int pinctrl_scmi_pinconf_set(struct pinctrl_dev *pctldev,
+				    unsigned int _pin,
+				    unsigned long *configs,
+				    unsigned int num_configs)
+{
+	int i, ret;
+	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
+
+	if (!configs || !num_configs)
+		return -EINVAL;
+
+	for (i = 0; i < num_configs; i++) {
+		ret = pinctrl_scmi_map_pinconf_type(pinconf_to_config_param(configs[i]),
+						    &pmx->config_type[i]);
+		if (ret) {
+			dev_err(pmx->dev, "Error map pinconf_type %d\n", ret);
+			return ret;
+		}
+		pmx->config_value[i] = pinconf_to_config_argument(configs[i]);
+	}
+
+	ret = pinctrl_ops->config_set(pmx->ph, _pin, PIN_TYPE, num_configs,
+				      pmx->config_type,  pmx->config_value);
+	if (ret)
+		dev_err(pmx->dev, "Error parsing config %d\n", ret);
+
+	return ret;
+}
+
+static int pinctrl_scmi_pinconf_group_set(struct pinctrl_dev *pctldev,
+					  unsigned int group,
+					  unsigned long *configs,
+					  unsigned int num_configs)
+{
+	int i, ret;
+	struct scmi_pinctrl *pmx =  pinctrl_dev_get_drvdata(pctldev);
+
+	if (!configs || !num_configs)
+		return -EINVAL;
+
+	for (i = 0; i < num_configs; i++) {
+		ret = pinctrl_scmi_map_pinconf_type(pinconf_to_config_param(configs[i]),
+						    &pmx->config_type[i]);
+		if (ret) {
+			dev_err(pmx->dev, "Error map pinconf_type %d\n", ret);
+			return ret;
+		}
+		pmx->config_value[i] = pinconf_to_config_argument(configs[i]);
+	}
+
+	ret = pinctrl_ops->config_set(pmx->ph, group, GROUP_TYPE, num_configs,
+				      pmx->config_type, pmx->config_value);
+	if (ret)
+		dev_err(pmx->dev, "Error parsing config %d", ret);
+
+	return ret;
+};
+
+static int pinctrl_scmi_pinconf_group_get(struct pinctrl_dev *pctldev,
+					  unsigned int group,
+					  unsigned long *config)
+{
+	int ret;
+	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
+	enum pin_config_param config_type;
+	u32 config_value;
+	u8 type;
+
+	if (!config)
+		return -EINVAL;
+
+	config_type = pinconf_to_config_param(*config);
+	ret = pinctrl_scmi_map_pinconf_type(config_type, &type);
+
+	ret = pinctrl_ops->config_get(pmx->ph, group, GROUP_TYPE, type, &config_value);
+	if (ret)
+		return ret;
+
+	*config = pinconf_to_config_packed(config_type, config_value);
+
+	return 0;
+}
+
+static const struct pinconf_ops pinctrl_scmi_pinconf_ops = {
+	.is_generic = true,
+	.pin_config_get = pinctrl_scmi_pinconf_get,
+	.pin_config_set = pinctrl_scmi_pinconf_set,
+	.pin_config_group_set = pinctrl_scmi_pinconf_group_set,
+	.pin_config_group_get = pinctrl_scmi_pinconf_group_get,
+	.pin_config_config_dbg_show = pinconf_generic_dump_config,
+};
+
+static int pinctrl_scmi_get_pins(struct scmi_pinctrl *pmx,
+				 unsigned int *nr_pins,
+				 const struct pinctrl_pin_desc **pins)
+{
+	int ret, i;
+
+	if (!pins || !nr_pins)
+		return -EINVAL;
+
+	if (pmx->nr_pins) {
+		*pins = pmx->pins;
+		*nr_pins = pmx->nr_pins;
+		return 0;
+	}
+
+	*nr_pins = pinctrl_ops->count_get(pmx->ph, PIN_TYPE);
+
+	pmx->nr_pins = *nr_pins;
+	pmx->pins = devm_kmalloc_array(pmx->dev, *nr_pins, sizeof(*pmx->pins), GFP_KERNEL);
+	if (!pmx->pins)
+		return -ENOMEM;
+
+	for (i = 0; i < *nr_pins; i++) {
+		pmx->pins[i].number = i;
+		ret = pinctrl_ops->name_get(pmx->ph, i, PIN_TYPE, &pmx->pins[i].name);
+		if (ret) {
+			dev_err(pmx->dev, "Can't get name for pin %d: rc %d", i, ret);
+			pmx->nr_pins = 0;
+			return ret;
+		}
+	}
+
+	*pins = pmx->pins;
+	dev_dbg(pmx->dev, "got pins %d", *nr_pins);
+
+	return 0;
+}
+
+static const struct scmi_device_id scmi_id_table[] = {
+	{ SCMI_PROTOCOL_PINCTRL, "pinctrl" },
+	{ }
+};
+MODULE_DEVICE_TABLE(scmi, scmi_id_table);
+
+static int scmi_pinctrl_probe(struct scmi_device *sdev)
+{
+	int ret;
+	struct device *dev = &sdev->dev;
+	struct scmi_pinctrl *pmx;
+	const struct scmi_handle *handle;
+	struct scmi_protocol_handle *ph;
+
+	if (!sdev || !sdev->handle)
+		return -EINVAL;
+
+	handle = sdev->handle;
+
+	pinctrl_ops = handle->devm_protocol_get(sdev, SCMI_PROTOCOL_PINCTRL, &ph);
+	if (IS_ERR(pinctrl_ops))
+		return PTR_ERR(pinctrl_ops);
+
+	pmx = devm_kzalloc(dev, sizeof(*pmx), GFP_KERNEL);
+	if (!pmx)
+		return -ENOMEM;
+
+	pmx->config_type = devm_kzalloc(dev, SZ_4K, GFP_KERNEL);
+	if (!pmx->config_type)
+		return -ENOMEM;
+
+	pmx->config_value = devm_kzalloc(dev, SZ_4K, GFP_KERNEL);
+	if (!pmx->config_value)
+		return -ENOMEM;
+
+	pmx->ph = ph;
+
+	pmx->dev = dev;
+	pmx->pctl_desc.name = DRV_NAME;
+	pmx->pctl_desc.owner = THIS_MODULE;
+	pmx->pctl_desc.pctlops = &pinctrl_scmi_pinctrl_ops;
+	pmx->pctl_desc.pmxops = &pinctrl_scmi_pinmux_ops;
+	pmx->pctl_desc.confops = &pinctrl_scmi_pinconf_ops;
+
+	ret = pinctrl_scmi_get_pins(pmx, &pmx->pctl_desc.npins,
+				    &pmx->pctl_desc.pins);
+	if (ret)
+		return ret;
+
+	ret = devm_pinctrl_register_and_init(dev, &pmx->pctl_desc, pmx, &pmx->pctldev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to register pinctrl\n");
+
+	pmx->nr_functions = pinctrl_scmi_get_functions_count(pmx->pctldev);
+	pmx->nr_groups = pinctrl_scmi_get_groups_count(pmx->pctldev);
+
+	if (pmx->nr_functions) {
+		pmx->functions =
+			devm_kcalloc(dev, pmx->nr_functions, sizeof(*pmx->functions),
+				     GFP_KERNEL);
+		if (!pmx->functions)
+			return -ENOMEM;
+	}
+
+	if (pmx->nr_groups) {
+		pmx->groups =
+			devm_kcalloc(dev, pmx->nr_groups, sizeof(*pmx->groups), GFP_KERNEL);
+		if (!pmx->groups)
+			return -ENOMEM;
+	}
+
+	return pinctrl_enable(pmx->pctldev);
+}
+
+static struct scmi_driver scmi_pinctrl_driver = {
+	.name = DRV_NAME,
+	.probe = scmi_pinctrl_probe,
+	.id_table = scmi_id_table,
+};
+module_scmi_driver(scmi_pinctrl_driver);
+
+MODULE_AUTHOR("Oleksii Moisieiev <oleksii_moisieiev@epam.com>");
+MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
+MODULE_DESCRIPTION("ARM SCMI pin controller driver");
+MODULE_LICENSE("GPL");

-- 
2.37.1


