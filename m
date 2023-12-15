Return-Path: <linux-kernel+bounces-879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FED814767
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1E811F24172
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D472E3F8;
	Fri, 15 Dec 2023 11:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HN1R+7jO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2089.outbound.protection.outlook.com [40.107.104.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B54B288DD;
	Fri, 15 Dec 2023 11:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+f7/92zLz2Gy1qtWS2VOshMzNEDdRTnF/Y29FNwl3m6hjCX+U4+eBsCBZovgHBPtHGHiJOjaUHDOsRX3UbVWS6nKJswd0FtyknJIE3BKwSjUcSOo3uMTk0DaZGCxc1UqoWdBONWHR/iIgiyR+PVHJKYbsxRg1C3yc53OJfn6ENCIj0TFFK2chQaFbOuOivUlNuYS4tRNazQgOJ02hUDlFN2zRtbRSNte4y2be93XClQ++kbx9iFW/kevBSsUTi5YtqiRc9jjPRrTqzEt+yfrvGa1cSiAakQqRur5x4ZpTWuD3xFrEt57tWTXXtqwUMZShec+C7AuB7Pus6FLlUDhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w400vpSvNS+U5c73CplisVthuWRbvuufr2i2TaLWMM4=;
 b=iVnOcghg2Ofs+kgoQ8do0e5CUBa0E86IDG7PN6XZgA5uivJC03rRnRRz0ZyBv2WBkdtZZToLiG43D8HF9szRqkheCfdv/M0lkS7QWnvflFI+g8OEfvh57sXZj6LpfiQFFIL5n9fTGf6YhUq2+2EGYlqzkqpO87TNzQsG2jy1EJeaj7UZ00gmkhlIrXKy8CUy4eP/M+lEajMn/B7XbIjj/4z3P23VQHePH9GBFzkUtpNosFUqEkF0wbYQwGg/R2cTEXS4l9uqdsqpUSaVnsq7+aUcGzeHq1bBn8EjdpLijmZZQOLEsndl5nitv1sSj+ZmlFfVcaFWm/6vVI4Uf/eeug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w400vpSvNS+U5c73CplisVthuWRbvuufr2i2TaLWMM4=;
 b=HN1R+7jOU699yK16aZtFoMhep7as0JKFNw8cmSKU8SdsJSooaFd3LmxDM+pCuvWVCsNTjziDipXeoK9uCNlHuIScsU31CMJ4dNu5LJJI7s6g3G31p2j2VADbVgwtP5qT8lneSmGQAJX6q6GkHPDlk6Q7ZzgqFFmB7JroBrH2uFA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PR3PR04MB7435.eurprd04.prod.outlook.com (2603:10a6:102:88::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 11:52:43 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ff06:bbb2:c068:5fb3]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ff06:bbb2:c068:5fb3%7]) with mapi id 15.20.7046.015; Fri, 15 Dec 2023
 11:52:42 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 15 Dec 2023 19:56:34 +0800
Subject: [PATCH 6/7] pinctrl: Implementation of the generic scmi-pinctrl
 driver
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231215-pinctrl-scmi-v1-6-0fe35e4611f7@nxp.com>
References: <20231215-pinctrl-scmi-v1-0-0fe35e4611f7@nxp.com>
In-Reply-To: <20231215-pinctrl-scmi-v1-0-0fe35e4611f7@nxp.com>
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
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702641405; l=13845;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=bB/Yc1qeeyh55WgW/F1hUmthHXez0iet66z/QkZPgMw=;
 b=AMFE/XVx7opjmgpXLSvhu8DniyfTgtC5T+aeS/uT75MYK7zKyg1/aHc38+6A32ohm/OcHU1fB
 B5rMNWel198CnYFVPf/FEsy45GgAWdmtk0OCCd6PQIWpBWbE3ulsAY8
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR02CA0138.apcprd02.prod.outlook.com
 (2603:1096:4:188::12) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PR3PR04MB7435:EE_
X-MS-Office365-Filtering-Correlation-Id: 34ffab1e-624e-49c8-fa4f-08dbfd645896
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TXzZAd8X2wKbJPYYUoSdL/TkUxxn5BCB5tlQzHUtjqv1Fwd64WDpmiS28JBD9igsa8kNO2Jd1YLrq9IqgBCl406m6F8Q7cX6SlMJDugV8iHwdE0coKmiKU7fzofY+pIeaCthTH0NSvlKAUZ77IAMh3BU0JBzI0kNlhMPp4HXDfcTMAWrieK6gNWzYfzPS9Uw4BERb7FTRTkMVMepe0aCOQYrZukhXcnbfzLoO1ihsH37lftm/eqjXdXJr6RbhFAeoDFwbW4TXKP2u2e8rmZkmMZECoO59+LYmN4yCFwooRu0TgtmMBzq6VzqzjdpWeDqrLMIFNNLiO/glNvqjkDeSLluyIRc9LhCkgl28L9vl6rL7Gco3SlMJ3NNr1Vt8azHGJ3RM3opJjL6rsmOmrmKEHdb+EnrTl0DnzlJ03aHd5uNi2FmYhDPJfCCCcQZEL71+s1SPFy7RiMCytR80fEvdznuIoGBbL/xyEqX5DxCtNMmRf/2K0ScB6JrCO1QsJJDZXQhRhYn0u9al9BRCGEhF0ShjhgFmrExedGLE3S7Q/Tpia6XDRw/HGRKqcFGw1Z8LupxmbYo2J+gIAOjUVlzA8tFPhq6QMGltbyzP8aTqZrpmAiCGhgmdIuvIaqY4tgkVtkShz5MZ0oUP7EDgQ3MsxY70dcNrLUWU/QTfCCsl34=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(366004)(396003)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(2906002)(30864003)(86362001)(4326008)(8676002)(8936002)(5660300002)(7416002)(921008)(38350700005)(41300700001)(36756003)(478600001)(6486002)(83380400001)(26005)(6512007)(9686003)(6666004)(52116002)(6506007)(110136005)(66946007)(38100700002)(66556008)(66476007)(316002)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0JibWJQWGRib1RpUmJoMUtyeUtSemNTSHE2bTFDd0R2RTR1OCtKR2FKYjJI?=
 =?utf-8?B?TUV0NVJFckdPdTFQVXFKSmowRkdVQnFBL3FuWkdkN05wT0FObWZrbSs1OEdQ?=
 =?utf-8?B?ZW1yR2pjRm9sOUJzajRLV01xczloN2lWK0ZCQmFseU5FQ1hGYXh5MnhtdE4r?=
 =?utf-8?B?K0ZWbUFKcHlGc0F2d2Q4V3E0OGVCYkJYZURndTdrT1ZaTkVCems0cHRjTTZO?=
 =?utf-8?B?cHRibXRNbFJQRHdSSGsyTDJaeVhFL3lTVlNjL0FIcWY5Vm9WeGRBSWZzNlJN?=
 =?utf-8?B?VTFMZzZBZm4xanl4YUdNd0RLeUJjOGlzNWF1RVZ4Y0JObW96VUozOW82eEJH?=
 =?utf-8?B?UkR5TWpkMGpPK1h1VTFEem4zcUFwZGR4UzlkSVdmZDdlTUowWXRNV2FTSGVX?=
 =?utf-8?B?R3NPN2FxcnY4alBybHpId0pDdXhrMXlSaUlPRU9Fc1YzSlZ1NkV5SGNaLzNO?=
 =?utf-8?B?cWtuWURQb2l1ZGhRYU9JeS9Ec3pWWUYyWHdzdm9SV2xpN0hIOFRFQlY0MjNo?=
 =?utf-8?B?M3FnbHlQbHdDSnIyS0ZyV0w4Y1AxOS9UZHQ1cktaaW14T2RvU2FLanpRc3ZZ?=
 =?utf-8?B?dHFySVlKczY1UzdFOUp6b0l5Q1pqVW5jL3U1UTdNZXpxTzF6Nm5JMVg5VFVP?=
 =?utf-8?B?M3k3NDhxNEhPcGRCc3RXeXIzNzk2U2FUTlBYbmJZZ1U2aHZMMjhMUFJBK1Q5?=
 =?utf-8?B?TlEyb09WVFNuMzN0YWRoRkRWTlV6TmRsc0hiSEliRWZMR0NqZ1Q3UVRiM2pB?=
 =?utf-8?B?VlJ0MTlteWJuaUJvYzVsT290aG5uVWlaRVdUR0xEOHNPYythc2pyMkdCVElz?=
 =?utf-8?B?VFZXUm5FSDVWTWJ6RXY0eWNmOTBXQXBkbTFKektMK2hjSXFIZW0xaWp3aVZw?=
 =?utf-8?B?dFRaeTZwYzRpMHllME8wZ1FrdjRRRS9ta2xvZ2lweFBQZGtEeXBLVWZVMUxl?=
 =?utf-8?B?ek9XUlptN0RyVWxuT3pnVHF0N25xRUV2a3lSWEFFYVNtb3o5K0R0OWtpOHhq?=
 =?utf-8?B?YzIvVWM5RFRramkrQys0cEZPNDVBOUJyb0t2dDF0b2cvTFdrdnFqcjl3VE5u?=
 =?utf-8?B?a2IwUFdmWklXbkQwSmN6UUNkZlpJSGZmWCt6YnJWUFBzRG13WUpkekVIZHcv?=
 =?utf-8?B?MG1nL3ZPRkcwMG9RQ3h5ZXBMYkplRDJ3Vk1OUS9DQVZGUWU0WDR1QmE0aHBO?=
 =?utf-8?B?bWhNOVVvY0FKVU5xL3Ztb1pva1R0M2gxVEgxQm82WDJuTTZKdFVRNjdURDY1?=
 =?utf-8?B?U210UkFGRXdtczJLUHFFakh3SnQ3UWg2UDR0WCt6YXd1V1VLNjRpbDVwNDkx?=
 =?utf-8?B?NER2bGFwRlNSYk93L0VzOGhVSkFUN0J5SndjVGF0eWZGOFRmek1xQWJNayt4?=
 =?utf-8?B?UWxnZmVUYWFZQXdhdVBJZWUxYmFBQnIyZEt4QW41ZnNVQ3dPeVVEQ0JDUm5z?=
 =?utf-8?B?cWM0QkhBMTRoamo3eXQ3OGJ4VXRsakV0R2FzRjNuSGxQYitIeTlyVjRJQTg2?=
 =?utf-8?B?c3BZZEt5S3dlN3VYYWl4bCs1dHpLSnRnYURrdERvMG1EVzlpUWJoSmdiZjVD?=
 =?utf-8?B?YlpvVHFMVHgrKzZnY3RzSER3d0Q5dmZFYlR2K3EydklFUW4rOGFLa0J1dDB6?=
 =?utf-8?B?NVFSVzUyUCtmMHlLZWZmd2Fzbm83TWx1aTA3dXdyU2VEVk9oOU5MUmhZVm1u?=
 =?utf-8?B?dVdFL3k1a2pBYldaTDhWaXNhYzdESUNqSUlJR2pHQVk0RFhtSHh1algwS1VD?=
 =?utf-8?B?cWFrZ1Q5bUU2K0xNcFZwYnF4QmwxeEs5S1FGVEFadU9VajdyNUlrTjduejFV?=
 =?utf-8?B?aXI2OXNMcmVEdk9zZkEzeTBmNHZJUUwxUzRHeVdGZkRnd0VEekhHOXJ2c1Fs?=
 =?utf-8?B?c2FzNEF0N1k1bmw4M1JSZzdwU29Fc24yNWxRcFVMR2pPb0JJZnN3SnIrZXNJ?=
 =?utf-8?B?NkU3djYrV2NObCsvSHcvNyt2MG9xdWNmdTg2S1cvZHppM0pTczhNN0VqRDl4?=
 =?utf-8?B?QkQ5SE1heVF3emVQTEwyV2U5UnZ4cXQvQjIrbmtCMkhyS28wdEV1VjlnVVcv?=
 =?utf-8?B?eUN0QnpWRHlROHNZNHc4RXNjblZjRnZqUTZFQlBUa3Q4dDNDRXRzMEdVSVVy?=
 =?utf-8?Q?Ib74awOZDaNaI53EWF7EEFQYQ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34ffab1e-624e-49c8-fa4f-08dbfd645896
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 11:52:42.9078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BhHI0iVMWh6wHdY6zQAw/H+Em9BV83dlxf7Yck2A5o8dirDC37gquPkeYyDFqVkxG93daZVQDbHQ/oISJpzRPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7435

From: Peng Fan <peng.fan@nxp.com>

scmi-pinctrl driver implements pinctrl driver interface and using
SCMI protocol to redirect messages from pinctrl subsystem SDK to
SCMI platform firmware, which does the changes in HW.

Co-developed-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 MAINTAINERS                    |   1 +
 drivers/pinctrl/Kconfig        |  11 ++
 drivers/pinctrl/Makefile       |   1 +
 drivers/pinctrl/pinctrl-scmi.c | 403 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 416 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d971adeee22..0ca47b9c9f55 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21172,6 +21172,7 @@ F:	drivers/clk/clk-sc[mp]i.c
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
index 000000000000..0710ce9a1b42
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-scmi.c
@@ -0,0 +1,403 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * System Control and Power Interface (SCMI) Protocol based pinctrl driver
+ *
+ * Copyright (C) 2023 EPAM
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
+static int pinctrl_scmi_pinconf_get(struct pinctrl_dev *pctldev, unsigned int _pin,
+				    unsigned long *config)
+{
+	int ret;
+	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
+	enum pin_config_param config_type;
+	unsigned long config_value;
+
+	if (!config)
+		return -EINVAL;
+
+	config_type = pinconf_to_config_param(*config);
+
+	ret = pinctrl_ops->config_get(pmx->ph, _pin, PIN_TYPE, config_type, &config_value);
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
+	int ret;
+	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
+
+	if (!configs || !num_configs)
+		return -EINVAL;
+
+	ret = pinctrl_ops->config_set(pmx->ph, _pin, PIN_TYPE, configs, num_configs);
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
+	int ret;
+	struct scmi_pinctrl *pmx =  pinctrl_dev_get_drvdata(pctldev);
+
+	if (!configs || !num_configs)
+		return -EINVAL;
+
+	ret = pinctrl_ops->config_set(pmx->ph, group, GROUP_TYPE, configs, num_configs);
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
+	unsigned long config_value;
+
+	if (!config)
+		return -EINVAL;
+
+	config_type = pinconf_to_config_param(*config);
+
+	ret = pinctrl_ops->config_get(pmx->ph, group, GROUP_TYPE, config_type, &config_value);
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
+MODULE_DESCRIPTION("ARM SCMI pin controller driver");
+MODULE_LICENSE("GPL");

-- 
2.37.1


