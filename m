Return-Path: <linux-kernel+bounces-16532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1197D823FC6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B0911F2196D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6522224CC;
	Thu,  4 Jan 2024 10:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="IYEFe8ci"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2048.outbound.protection.outlook.com [40.107.6.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0F920DDE;
	Thu,  4 Jan 2024 10:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kKPAu8J2wowPDiR9G4kHLkwJDHAHwWLDNemZGHlhjmsLPlK/ZRmdkzNHcMEUhQsbLoliLZUQGyDqgYFUyC4s+fpdaeULw7BRwVAJ6d7UKgA859C3Sk4gfcHW+PP6S9LuRcFRW6qqqfWTtKbmYpeiFHznUMYGRarH5OD1opd1ShtDchNnBeDzVQe4WF6sQnVc7DcDPJOC2jh1EDve/D3Iz0JzTfLrqP7jQKXfjIabuc5OqDSyIKJ9o86RUY1JUI6paALSRqi/Mf4mlazFUBu81kgDTTxenHRFL0dDaW6mWszzMiDiTtfLr/pYLtn/J5Ih1lY54qzkjLtrQs3FyeEk9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TBrv5grZuXi9ZKLBAqWKbI2ffwa3ut4ZwXFNS5mOLI8=;
 b=Q7oZ+Li8RbzM8zMUa9kUinnsCQ/U5clKNcr2FNyx0WzzVyw5g4NN5x1J3brRorzCZrMigEtwQ/Ea6mHPW61jfaeWaZT072e6UetaI9z0MRJGoIcRGprXHfMsUrwv5HAGCZqjnvn5VKIBmAerEzmK4wEuPHYDyDziOkRefciyqEGL6ncY+O5E7iCkQwOpuvsHn04RHe2MG0YwgZ04qusVPFbGcQJIklflf10TB64AfB+p0LvdTPy6bamfbWVxXEi4b4hj71fVr2ZSqf2O/9YqM/z0xZ/rEzZHoc4yzoaYtJQczYLGDPyFmtA5AO4tTHNv+ciaDnPrNzcMFfTng/AQaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TBrv5grZuXi9ZKLBAqWKbI2ffwa3ut4ZwXFNS5mOLI8=;
 b=IYEFe8ci4MrgJRJsaxXRKQnThdQiIrwUldBv7AIPI1t/hLaLFkOjXtQ8DWzM6MkSMdATF0BW0gecsai26zkvQDwbvNFIftK8feEvN9m9LIVmV0pkUNtg7FNVFbElCx6RP40F8Qx2eFTqzVQHV6iThYQOOO+VvvzzhRq77GKkSuU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB7994.eurprd04.prod.outlook.com (2603:10a6:10:1ea::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15; Thu, 4 Jan
 2024 10:45:17 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ff06:bbb2:c068:5fb3]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ff06:bbb2:c068:5fb3%7]) with mapi id 15.20.7135.023; Thu, 4 Jan 2024
 10:45:17 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 04 Jan 2024 18:48:50 +0800
Subject: [PATCH NOT APPLY v2 6/6] pinctrl: scmi: implement
 pinctrl_scmi_imx_dt_node_to_map
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240104-pinctrl-scmi-v2-6-a9bd86ab5a84@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704365357; l=7141;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=UNtnAacrD3p6okC7/cMkcE6UWw1ah8KQZQ8RD/XuU/k=;
 b=GOZgKd/GkYX7pMK64yjn1d0EAU+PVNhTMg1f+mLIolo8VAHyleMZxffiIFVksVFsOiaJ2cuGh
 xWRhzaSy0DtBgooNFr4GO3CxP3Voyseju3pWtLJs2pbActjsSKcAB3q
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
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DBBPR04MB7994:EE_
X-MS-Office365-Filtering-Correlation-Id: 606560c9-afb2-4428-b17a-08dc0d123daf
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Rl5N3EZQM4u7OQ3GnxEVX6HihkvCV94CwXO/CWbJuUY3YX5PR/wUchg7izm7IL2f2n+8970QE6n1ppG/hm+QQ2nA8MxPr8zcd4t4BCqIS8IGpZ3nvGmJphB1K8FRyvuNeAYF19oWGmYfud2HGBnSbzZtc0/t/CPQ3Dap8hRkyAiZ296eg/KYin8nQOhj3lpnv3fDJkxlF7DTRt1eD9ES6PZb3Sj9+IZZnAyWYcQ345TdO96xdPDVYa+v2dmiXMhVFHCLqgT1C6/W3xwmrwtd6B6q7dkWMLiLxGAESNqw9yuxUWb9fznRjPfF4xpnFVpzKwQQhRdgR5f3y+d85fdlNLADcrB4P73yHJd2Ai4mnknQpEOQBTbF26FlL3WZng5fXv8uIQKPOGkiISqPylHdgJw0sRf9oOcUoqQoiDz/CmgyaD2DhDke5+tnXENG3GgWIOj6ShHPjYbEnc1b7SP0IYn/wqwhkiFCD1RMuT7upojkYrSqail5Lm2Ol2jI8SMZkCphbiR7tTSDT8xAnfhn7vsoWIpzVbmKEhswhcjLVyv3CM0Zohnhfgo/1RG7EuZIO3Z9haNlCp1kZ/PmtaMhUitkY/HNAr4ttmdS8wufwMySjvJZfwjNE07e/CIDfp/RPTOISzSm8qy8ZNsh6fmbMQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(396003)(39860400002)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(26005)(38100700002)(83380400001)(41300700001)(8676002)(8936002)(110136005)(54906003)(5660300002)(2906002)(7416002)(316002)(4326008)(6666004)(66946007)(478600001)(9686003)(6512007)(6506007)(66556008)(52116002)(66476007)(921011)(6486002)(38350700005)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dzBENkFueCtjaGNnMmtha0dwengwYzJ1V3BWdVFtbTZOUFQyM2Z1L0lIUTY5?=
 =?utf-8?B?cUFXUHdTYUU4d0lvZ3dzbEg1VXJmMWhldHNYNGtNSUppZ0dSUHZKWnFFZTJw?=
 =?utf-8?B?Q2ErOVFhNmRpc0ZtZHR2Wkg4UmhGTHZhelc2QUt1NVkyRS90dHpaMTdFa1Rl?=
 =?utf-8?B?NFphZjh1RFZCVlJIdWt5Vyt3VEU1b1NpN3BWWHlhUG51enZyL0hLS3BqZ0hy?=
 =?utf-8?B?U0RJVm9leEtySkx4WGJpcnUyWGYwYm9yd0ZxYmg1aDJFSVFZQzI5ZENWREw0?=
 =?utf-8?B?eTdVY0srRGJaajR3Q214MVgvanFEZTFMT21ONEZrMjZqWWxoRkpHYWd3TmJC?=
 =?utf-8?B?aEFtOE9JN0ZQdTYrT25WYnZVSEI3d282bE9pWDhvNGlmQkhBTnFramFzL2kx?=
 =?utf-8?B?cWZCSWh3b2kvV0s0YjJMckRhWmp2U0tjbFZ2VVI4dlRDRk9UT2NnTStsVlhn?=
 =?utf-8?B?K21YYXJKK0R0ODJYY0dXdHp2RHhqYVBFU2Z5K0JEWFJKaVd0dFRMUjg0dWhD?=
 =?utf-8?B?UkpROGR4SzloaUlCMktwOVIzWlVYWGdqbGdPT0xyWWo0K3NuNzk5ZkJ1U2FN?=
 =?utf-8?B?WGVHdVhBSit2S2laVVRKSjRDRG05ZWN6TU8wS1I5WlpJOHlTQnR3S2FOTDRE?=
 =?utf-8?B?UWxrcXBvVVMxUVByenZaQU5NWnRZMjhJYXp6TTdOQ1ZuUVJlazdSdzRKclor?=
 =?utf-8?B?eVN4bEJURE5zWE8zK21RN2UyOHB6MW13eGVtaGZhTXZDZkYvWlhiQmtEazM4?=
 =?utf-8?B?d2xIMjdRTmxCNThHNEJIS1hEZVA0aFpLSzZaMGcweTE4KzRUM2xyeGsyVDNx?=
 =?utf-8?B?cEp5dmQwMjVxS1pjVFNwd3Y2UGVlS0swMTk4YUtqbHJjSUZjVUdTZVFTVWxB?=
 =?utf-8?B?SFRiZzF1L3J0MEU0eUkzYVZTRGtGVk9kU2UzNUtvYllQMExwcXZUY01veDE1?=
 =?utf-8?B?ajMxU1VJTGdXNWMrMk5YWWdLL3o4M0xib1Y1elc2WWlkWHZ1dW5nOWVXQ1ZT?=
 =?utf-8?B?UnNjTnZVTXRsclNSMDR0K1JCY0lzM0hXa1p4VElTaWQvcTl6VnRyOFd6WnRn?=
 =?utf-8?B?R2dlczMyRk5PTk9IVllsVUJrbDdyWkM2dWk3QWFxUzlZYlFiZzdVV1hLQ1hv?=
 =?utf-8?B?WnFFTm9PZmQyTUtRdzd3ZUJlaloyc1kwTDh2QkppdlJha2JjMjNZUmJsaEdw?=
 =?utf-8?B?Rk9UTHFnZ09VakljdmEyNTltc1JqWGUwZCtCOHVaeE40aHI1Z3ZmNjl0YjRl?=
 =?utf-8?B?MkdUaEJkL1A3Z0I4a0VCN05uK2xvRHBGeURENW82UFpRcmNWTm43cjhWUUps?=
 =?utf-8?B?YS9uS1VuK1NzaEZXaDc4R21ySFRqR1hkaUM5dEltUjI0b1NDR0h4NVg3OS94?=
 =?utf-8?B?WDNHeVB5Rm8rV25WSlZUWGN4eVh6bjNZWTMyYXZDbUJ3blFXem5Sb1ZkQTQ4?=
 =?utf-8?B?RmJCK3RiMEJ6RzBHbUxpUk45NW9oMzZuRVp4cndMQzVsU0J0UHJpZWNjWHR1?=
 =?utf-8?B?RzQ2MXdUZmdvdGcrNkxjUjJoSXFCL2x1dmdrdDhCSTFvb0ovenYreUZjSTVm?=
 =?utf-8?B?VjZNczdUY3dvWE1xVFkrR2NqRXNmKzFKeldybXFSdEFPUms0Mm5uMjlxSi9C?=
 =?utf-8?B?MGZDejJSUUc0cjlZWm8zZ2c1MWNWRTFtNmtNZDJzZ0xPdEZ1bVpXS0hQdWRl?=
 =?utf-8?B?aVlteWxaTS9DK1VXTUZnTVB1dUwwWEVla1lac0RBbnBiU3lhSC9ZZmdkT2lD?=
 =?utf-8?B?WldzUmNTTGd2MEJZNjU5TmRYRGdSWDRnaTZMZ0pjeGdrUVNXV0pmeUd3Q29n?=
 =?utf-8?B?T1c4dWJ1cyt1VlgzU0hLN2dVckUxdVRsN0c5UkExYXBXaTByQi9LRHMyVkRY?=
 =?utf-8?B?QUV6U1ZGaUtMenJWVEV3WDFQVktPa0JCZldhM0RpcUR0ZVU4dURMMjhZNWVN?=
 =?utf-8?B?RnFiT1JnaFJXSHN4VHFWUzdxTFJnU3NzajdMT3hLUzA5anpKOE5xNUx6UTcz?=
 =?utf-8?B?aFgzNzBYdzhWWlU3UVhLaU5KWmo5elFNRDNkeTUyL3JIcUlkUHFjMVFWK1Vs?=
 =?utf-8?B?T2ZJY3ZVaDliTjFYeE44NFJhdkJaMEYrdnZhUERGKzFWRnRuOEQ5ZUpNQXU2?=
 =?utf-8?Q?GadPDFjp0FzWhF6TCpGbd/Ezc?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 606560c9-afb2-4428-b17a-08dc0d123daf
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 10:45:17.6746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M819BMnj+cTa7uayhto4iA5nUrHzUECxk7EOHFN8Nr5bQCdPOLWOiHmnyJiPLcbh6gJ+B0vWLkQnPrVNdsOI2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7994

From: Peng Fan <peng.fan@nxp.com>

i.MX95 System Manager FW supports SCMI PINCTRL protocol, but uses
OEM Pin Configuration type, so need i.MX specific dt_node_to_map.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pinctrl/Makefile           |   2 +-
 drivers/pinctrl/pinctrl-scmi-imx.c | 117 +++++++++++++++++++++++++++++++++++++
 drivers/pinctrl/pinctrl-scmi.c     |  16 +++++
 drivers/pinctrl/pinctrl-scmi.h     |  12 ++++
 4 files changed, 146 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index ba755ed2d46c..d96b7ede1355 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -44,7 +44,7 @@ obj-$(CONFIG_PINCTRL_PIC32)	+= pinctrl-pic32.o
 obj-$(CONFIG_PINCTRL_PISTACHIO)	+= pinctrl-pistachio.o
 obj-$(CONFIG_PINCTRL_RK805)	+= pinctrl-rk805.o
 obj-$(CONFIG_PINCTRL_ROCKCHIP)	+= pinctrl-rockchip.o
-obj-$(CONFIG_PINCTRL_SCMI)	+= pinctrl-scmi.o
+obj-$(CONFIG_PINCTRL_SCMI)	+= pinctrl-scmi.o pinctrl-scmi-imx.o
 obj-$(CONFIG_PINCTRL_SINGLE)	+= pinctrl-single.o
 obj-$(CONFIG_PINCTRL_ST) 	+= pinctrl-st.o
 obj-$(CONFIG_PINCTRL_STMFX) 	+= pinctrl-stmfx.o
diff --git a/drivers/pinctrl/pinctrl-scmi-imx.c b/drivers/pinctrl/pinctrl-scmi-imx.c
new file mode 100644
index 000000000000..e9d02e4c2cc1
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-scmi-imx.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2023 NXP
+ */
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/of.h>
+#include <linux/slab.h>
+
+#include <linux/pinctrl/pinconf.h>
+#include <linux/pinctrl/pinconf-generic.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinmux.h>
+
+#include "pinctrl-scmi.h"
+#include "pinctrl-utils.h"
+#include "core.h"
+#include "pinconf.h"
+
+/* SCMI pin control types, aligned with SCMI firmware */
+#define IMX_SCMI_PIN_TYPE_MUX		192
+#define IMX_SCMI_PIN_TYPE_CONFIG	193
+#define IMX_SCMI_PIN_TYPE_DAISY_ID	194
+#define IMX_SCMI_PIN_TYPE_DAISY_CFG	195
+
+#define IMX_SCMI_NO_PAD_CTL		BIT(31)
+#define IMX_SCMI_PAD_SION		BIT(30)
+#define IMX_SCMI_IOMUXC_CONFIG_SION	BIT(4)
+
+#define IMX_SCMI_NUM_CFG	4
+#define IMX_SCMI_PIN_SIZE	24
+
+int pinctrl_scmi_imx_dt_node_to_map(struct pinctrl_dev *pctldev, struct device_node *np,
+				    struct pinctrl_map **map, unsigned int *num_maps)
+{
+	struct pinctrl_map *new_map;
+	const __be32 *list;
+	unsigned long *configs = NULL;
+	unsigned long cfg[IMX_SCMI_NUM_CFG];
+	int map_num, size, pin_size, pin_id, num_pins;
+	int mux_reg, conf_reg, input_reg, mux_val, conf_val, input_val;
+	int i, j;
+	uint32_t ncfg;
+	static uint32_t daisy_off;
+
+	if (!daisy_off) {
+		if (of_machine_is_compatible("fsl,imx95"))
+			daisy_off = 0x408;
+		else
+			dev_err(pctldev->dev, "platform not support scmi pinctrl\n");
+	}
+
+	list = of_get_property(np, "fsl,pins", &size);
+	if (!list) {
+		dev_err(pctldev->dev, "no fsl,pins property in node %pOF\n", np);
+		return -EINVAL;
+	}
+
+	pin_size = IMX_SCMI_PIN_SIZE;
+
+	if (!size || size % pin_size) {
+		dev_err(pctldev->dev, "Invalid fsl,pins or pins property in node %pOF\n", np);
+		return -EINVAL;
+	}
+
+	num_pins = size / pin_size;
+	map_num = num_pins;
+
+	new_map = kmalloc_array(map_num, sizeof(struct pinctrl_map),
+				GFP_KERNEL);
+	if (!new_map)
+		return -ENOMEM;
+
+	*map = new_map;
+	*num_maps = map_num;
+
+	/* create config map */
+	for (i = 0; i < num_pins; i++) {
+		j = 0;
+		ncfg = IMX_SCMI_NUM_CFG;
+		mux_reg = be32_to_cpu(*list++);
+		conf_reg = be32_to_cpu(*list++);
+		input_reg = be32_to_cpu(*list++);
+		mux_val = be32_to_cpu(*list++);
+		input_val = be32_to_cpu(*list++);
+		conf_val = be32_to_cpu(*list++);
+		if (conf_val & IMX_SCMI_PAD_SION)
+			mux_val |= IMX_SCMI_IOMUXC_CONFIG_SION;
+
+		pin_id = mux_reg / 4;
+
+		cfg[j++] = pinconf_to_config_packed(IMX_SCMI_PIN_TYPE_MUX, mux_val);
+
+		if (!conf_reg || (conf_val & IMX_SCMI_NO_PAD_CTL))
+			ncfg--;
+		else
+			cfg[j++] = pinconf_to_config_packed(IMX_SCMI_PIN_TYPE_CONFIG, conf_val);
+
+		if (!input_reg) {
+			ncfg -= 2;
+		} else {
+			cfg[j++] = pinconf_to_config_packed(IMX_SCMI_PIN_TYPE_DAISY_ID,
+							    (input_reg - daisy_off) / 4);
+			cfg[j++] = pinconf_to_config_packed(IMX_SCMI_PIN_TYPE_DAISY_CFG, input_val);
+		}
+
+		configs = kmemdup(cfg, ncfg * sizeof(unsigned long), GFP_KERNEL);
+
+		new_map[i].type = PIN_MAP_TYPE_CONFIGS_PIN;
+		new_map[i].data.configs.group_or_pin = pin_get_name(pctldev, pin_id);
+		new_map[i].data.configs.configs = configs;
+		new_map[i].data.configs.num_configs = ncfg;
+	}
+
+	return 0;
+}
diff --git a/drivers/pinctrl/pinctrl-scmi.c b/drivers/pinctrl/pinctrl-scmi.c
index 146308d27f54..b49cbfbddbc9 100644
--- a/drivers/pinctrl/pinctrl-scmi.c
+++ b/drivers/pinctrl/pinctrl-scmi.c
@@ -9,6 +9,7 @@
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/seq_file.h>
 #include <linux/scmi_protocol.h>
 #include <linux/slab.h>
@@ -19,6 +20,7 @@
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinmux.h>
 
+#include "pinctrl-scmi.h"
 #include "pinctrl-utils.h"
 #include "core.h"
 #include "pinconf.h"
@@ -89,6 +91,16 @@ static const struct pinctrl_ops pinctrl_scmi_pinctrl_ops = {
 #endif
 };
 
+static const struct pinctrl_ops pinctrl_scmi_imx_pinctrl_ops = {
+	.get_groups_count = pinctrl_scmi_get_groups_count,
+	.get_group_name = pinctrl_scmi_get_group_name,
+	.get_group_pins = pinctrl_scmi_get_group_pins,
+#ifdef CONFIG_OF
+	.dt_node_to_map = pinctrl_scmi_imx_dt_node_to_map,
+	.dt_free_map = pinconf_generic_dt_free_map,
+#endif
+};
+
 static int pinctrl_scmi_get_functions_count(struct pinctrl_dev *pctldev)
 {
 	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
@@ -439,6 +451,7 @@ static int pinctrl_scmi_get_pins(struct scmi_pinctrl *pmx,
 
 static const struct scmi_device_id scmi_id_table[] = {
 	{ SCMI_PROTOCOL_PINCTRL, "pinctrl" },
+	{ SCMI_PROTOCOL_PINCTRL, "pinctrl-scmi-imx", "fsl,imx95-scmi-pinctrl" },
 	{ }
 };
 MODULE_DEVICE_TABLE(scmi, scmi_id_table);
@@ -481,6 +494,9 @@ static int scmi_pinctrl_probe(struct scmi_device *sdev)
 	pmx->pctl_desc.pmxops = &pinctrl_scmi_pinmux_ops;
 	pmx->pctl_desc.confops = &pinctrl_scmi_pinconf_ops;
 
+	if (device_is_compatible(dev, "fsl,imx95-scmi-pinctrl"))
+		pmx->pctl_desc.pctlops = &pinctrl_scmi_imx_pinctrl_ops;
+
 	ret = pinctrl_scmi_get_pins(pmx, &pmx->pctl_desc.npins,
 				    &pmx->pctl_desc.pins);
 	if (ret)
diff --git a/drivers/pinctrl/pinctrl-scmi.h b/drivers/pinctrl/pinctrl-scmi.h
new file mode 100644
index 000000000000..25863b4428fe
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-scmi.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2023 NXP
+ */
+
+#ifndef __DRIVERS_PINCTRL_SCMI_H
+#define __DRIVERS_PINCTRL_SCMI_H
+
+int pinctrl_scmi_imx_dt_node_to_map(struct pinctrl_dev *pctldev, struct device_node *np,
+				    struct pinctrl_map **map, unsigned int *num_maps);
+
+#endif /* __DRIVERS_PINCTRL_SCMI_H */

-- 
2.37.1


