Return-Path: <linux-kernel+bounces-141742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 410DA8A22D9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 02:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A8121C21E6F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 00:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDB59443;
	Fri, 12 Apr 2024 00:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Fx5tt33A"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2059.outbound.protection.outlook.com [40.107.15.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B225BD299;
	Fri, 12 Apr 2024 00:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712880816; cv=fail; b=QMzVaXFitMzKE6rkdjqR6CUz59G1ven9k7VoDm4Cx7CvosatZV5uMMZ1hBI4ANKTYRXji4ZnIAv7dDugcNM4MLLsLd8UnKHYmaELVgaJ2vLYbg4+mCw5zXHb15/9RKAqUY6PeowKMQJ8d9oesmSOD9wFv59Cpuh5HSmia4Kenv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712880816; c=relaxed/simple;
	bh=YlwrH+eQS9F7MOeVCzzuGup799W4C6ZI78AJteK4rKw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=eVqdfUE1PGGucerfkprxgdFb9XMB9d1ScY0gb1W2G+QSKelvVon5YbfERUk4RMm27SW3DJseLJn8tnfnP4xFcO2CjC1EBveEhnNIEm6QMEyHRLOCn6648X4+Fo7XmoXFxRFMWNo5I1pcovfehNTS2nfZFVk0zwNkU/TZsRj3yEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Fx5tt33A; arc=fail smtp.client-ip=40.107.15.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l9Pdi2wW5Ob+yg5uT08YwW6vEwYoqoYDNRhWM4jBQGKfy0XWb/ADD4JqFFYg05WMS6kZmdpBOXi826xfDj6NTJWp/VrkN6yGnodKFnu3C1kqD3XQ32ihKJvQeFPL1hmxtcXn9OK/qbXIbt7fF0Mw3tESw7AuaEMjPLU3D0ujyrhMEzZTKa1UkxNpaexoSdMvrp2EywMbvUW0d8BSVitFdpjPS4I689i44qRt08A+dBm1RO+1DdNjeMeeXM5ObjLiN4jnLRpwwNvQvdfvcYARYnyliUIBF19igTO/e1Ur7ThZlNxp464qPI2+M4kmsCxNTEzzkXMwhedut/2Yacm8Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6cSrPxrT85E+2sEoi3YYX8D8I3wXNefinoNnLyn7Qk=;
 b=DKVtCMzO0+h4p705bMKHehNQaC+m8p4iwCRQ9KwVQvHrs1ulQRFY0dZ4jkid7pjKHm4iKCQDC8KLLfoVX/6oHQHNoE/4g0uHrlba5T30QFfg0am/LsX5+0yeLKRRitt3umeowNY4ah/gJGp7DQ9klFz1e2lqUkDqdr4cdLwOBjy4l604Xc6qotSNRNySyzwA1Wrm+ztDnpNjD7SZSakeGtcbSd6nt5vBd2JXZa0rBA4jxskfULPF4kKQpxqxjI3dX2eWuPFJMq96fo5x2e5nYxKcStmPdmQYQcaSL5yLfXfhu72p/8eyAj0pXaNbRO8Wok6usMQGKOOWnLRxSfKmFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6cSrPxrT85E+2sEoi3YYX8D8I3wXNefinoNnLyn7Qk=;
 b=Fx5tt33AvvLBgLDicdtmV0HYTgeA5T0eohz5gZ7FSsgTIDwAuXZ9TqrZ3SuwRpXWgBK7g4KrQUffqT//wECO2FksQRRBRlKYtt93PauNgfxtX0RxcnvBOfrTtf6o8cloqHZfC1+BjnL+4pvThLqYUlzkAhP7DUUI0KjVHV0xYEQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM8PR04MB7970.eurprd04.prod.outlook.com (2603:10a6:20b:24f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 00:13:30 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Fri, 12 Apr 2024
 00:13:30 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 12 Apr 2024 08:21:21 +0800
Subject: [PATCH v9 3/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240412-pinctrl-scmi-v9-3-b817344d3a9a@nxp.com>
References: <20240412-pinctrl-scmi-v9-0-b817344d3a9a@nxp.com>
In-Reply-To: <20240412-pinctrl-scmi-v9-0-b817344d3a9a@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Dhruva Gole <d-gole@ti.com>, 
 Andy Shevchenko <andy.shevchenko@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>, Oleksii Moisieiev <oleksii_moisieiev@epam.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712881290; l=30412;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=YuGhTXxfU5NKLJFYyDuKKzadNTpWoQRGvlpy5+5N94w=;
 b=nXaqq1WOyi9hvVNFDrBpaor/qtrR7jcm1HideVW6i3z/5szg02fiwdQAsuhh8CP0H1EKCGHWQ
 YBjAaEWO0X/AwglAT4xYZJmh4GETGDNNOB/nS0YzfihfHnT4VUDA7Ef
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM8PR04MB7970:EE_
X-MS-Office365-Filtering-Correlation-Id: b4a39407-1ca9-4265-d20a-08dc5a85621a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HnNrpKKDqR3qRixgerXO6N3wfp2MFsmE2zA77geEVfHnmxNNdFg1Js3qO5gMqs6FTp9fruV7P0VKXIyfOZXj+I5ixW5BCuOnQMVpodZfloLTnEcQoCkrjeyVJmK21FLzhZbv7HcvsSZFVdVg60S6VmxxHpPRvEaMvbqzNKyeAV/jv2Pa0tc552XWAB4PHjp8bGg95iuiI3fENbakcqMmEOjbe9SPB3PlfOiIZ/8IrfdooxlXM1Kxs6yPvPyFqQ7naGPheWFBTJUoJnzt7H81HVS7rkTaLMTf+fZPhKcte1Ayo0//2gQnVM6cEMLK506Ig8vRKNp+cPjcNzdM+/gtxrEmzaEZQcp53Ja+z6E/XcIZSk8M3OAG/+NdT46YbwaL2xxYx3byRVdeO8n5HOJO8FXdYdR1NBND2sf1tH8xHWnlwomiTtMx83gS8KGkcP/rLAYX4GkfkC/KbAWk3Rk0hHifpt+B+NOJNdtZe45x2NErG1RDiB5vWzNpt5NvL+lZpumR4KqOoIk4EGi8pNPRo4bu+GPSeY1yq6bTySGmjiz3d39ArrO6hvlvH3llDredPxZUtd1jHLkM0xupY29vudtWO+Ezh8IjW85C1ZjjQO+UmUFeajJJF+E7h7wLaneoX7KEPyqAykP1ELWaLYR6249e9eVXUlasL5sy03yB0eVC4POeByA3n8JChw68GQUk4/A0WbaSSQa9cBcl2ZJwBAGTtXE52LdSskoQ2UEUMjI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(52116005)(7416005)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjJ6bTY0WVVMcDhxMDBXTFMyRVpDQ3pubmg0eWl5Y3ZQZkNaQ01lWTBNYXgy?=
 =?utf-8?B?MEtjaUF6SjRhOUQ2blZxK21jOGF1QlhMMEs5ZXEwdkFobnFjRXF3L2U4QkR4?=
 =?utf-8?B?dEh0djljQWZNRFF0LzhMeklNbDE3V2J1aU8xS1M5Smdyb2pycXREV29VNml1?=
 =?utf-8?B?NzBtVUQ0SFR2dWk1V2tQTUVDZzIyNkFSR1Q0U2lNYS9rUkNpTjhEcnhmZEFO?=
 =?utf-8?B?bVNFejd5ZnI2V0JIOERnVHhwQUpnMEkrT2RoWG9SRFdpUkxSRytEMUFOTGpp?=
 =?utf-8?B?N2Zad1ByN1RNWE9MRTRVdS9GT0Y1THZrOGlHb3F2QUx5Zk94S3JENGVXTUty?=
 =?utf-8?B?TktkZnY5YmNNT01maDVnZGd1SnB1cU9kaFB2dkNnTXlxTW5mdnFtaEVqa0FH?=
 =?utf-8?B?ZmZhWVkzTmk5UVZMY216QytWbWVSbkFqaXFlY0tJUnIxeW5vU1VHcm55Q0Rl?=
 =?utf-8?B?Rk15d3p0T0dQdERZMG1SN1o0OVlHMkhHUzdNSE9OOEdscGFQY0lHQ29GbCtt?=
 =?utf-8?B?MHFJdE44K2gwVWpBbmJMU2pXRGNhWGlDUjl4dGszVC9jV0tTRlhWNWFCQ1hE?=
 =?utf-8?B?QmUyMXVjeGo4ZUluU09TMGVoZnlrMkRhVGN2bkF5eTVCN1ZHanFDNFozUGNH?=
 =?utf-8?B?ak5rVlVjckZMR2R6SjZFeDBuMlZnSEtNanJqSW9Oc1NxdUUzUUNsUXBPT2po?=
 =?utf-8?B?K3VacXNCYVhtUVI3Rm1oNXUremE5UURmRWkzdnZVeXZGNHNjVzY0bEo3S1N0?=
 =?utf-8?B?NTRrendzbjNueXMyOFBaSW1HQnA2ckZXTlZQTVhvNml0QmZSQitmUUZKa2NZ?=
 =?utf-8?B?QjZCaHVUakRENENKT0h1VThRYUZlL2VJUWJxZzhzNTUwZkI5RE94SlBLOEh3?=
 =?utf-8?B?VVFPT1BZOENkVTNoelBoSnV1SVRlQlA1Y3Y3bzgwM1BWR0hvdWFERUtucFo0?=
 =?utf-8?B?OVMvRWVsYjlSSUZZbGgxdTNOSmRZUC94Q3FSRlNFME9IMVRKTnl0ZWtYbzBz?=
 =?utf-8?B?YTBMRVkvTkt6N1pLRExUQk5WQ2VuWGxpQ0xkN0ZtZ0tnbjVSVWpSMml3aUtt?=
 =?utf-8?B?c2xic3NjYjlLWTF0QWY2T2dYdno2TllSdzJKTWNBUStQbFFlQ25nVVBnQUwz?=
 =?utf-8?B?bG8rMWJRR2lWOERRS0w2TGUxVFdEdXMvOFFBaytVVXhVUEhjZ24wZGI2TVAw?=
 =?utf-8?B?eXlreDg3M2hGVmFSZ3FBQzlObHdMaXNad3JHZGdXaEdVaVZKaTVPcjZHV1lX?=
 =?utf-8?B?ZHpUTTVXRnMvc0Y3V2dsWi9GZkNlSGZQSGJJZEVXaFZpYXpleURBOGQxbXFM?=
 =?utf-8?B?bDRVQktiN09WQlVxRGRPbVV1UUlKNE5QcHlrY29CSWRBekl2RmxiQjdkVkc1?=
 =?utf-8?B?TTBBK2MzWVNTeUVFOEZhZCtnZVhPZzJPMDc4OGlKZC9KelV5NlRRY0hHYi9S?=
 =?utf-8?B?cml5YzExMDUxWFpxTjkyVG1kMHFKbGNPdHJsd0lqTWErNXlGb2ZWQUhxakNy?=
 =?utf-8?B?UndrQmtHTWpBeit4SmM1WlBIcFk3azQ1OG8zNEgwUjVPTWZUWFB4TmcrYnBr?=
 =?utf-8?B?OFBzZDFLc2RxNVUyK2hOalMwNzNxbUtBcVU2UmE0MFZmakJpb2xZTllPdlR4?=
 =?utf-8?B?SExIUE4yS3FjWDBkNFVoRzRpbStWVnJaNVY1c2hManFoSjdxQlRyN2dtVHFW?=
 =?utf-8?B?ZG54Zm1zUzhKZ0JjTXRUNTdYbDUvWS80QzNETzBIWnM5QjJvemZFV2V6bFRF?=
 =?utf-8?B?N0dvdisrY3NsczVaeFVYWmdCT2ZuaERNSUdndy9HWVhhWkR5aEtRMDRkVUxz?=
 =?utf-8?B?dUE0ZXFyZkczZnBubmFnSkxPeUpHYS9yNXdaNElNVHNEbjBJMWVPWkl4RVpk?=
 =?utf-8?B?SHZMb2I0WWdtQWVqdldlZ1J2M3JZUnBqMk8wUXd1Mk52UjZ2L1BPMjVIV1FR?=
 =?utf-8?B?d2F0UUpXMnB3Z2lLNUJ6ZFM4VGtRY29sTmxCSXhQckpzQU9IMUtKaGswWDJm?=
 =?utf-8?B?RFZGTGxRMUlGS08rQkRXNXFoVU85NXBVU2NkTlIwa1NzeDFxNm9rK2R6SW1Q?=
 =?utf-8?B?MXV1ajE3anA3REZCMjdPLzdlamIxYnNRRjRRenA2Ulo4T2xSeGwzMllLV3Fa?=
 =?utf-8?Q?gGRdNjFGz3jpV9mGJfL0GosWB?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4a39407-1ca9-4265-d20a-08dc5a85621a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 00:13:30.4769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HmwpIFJHcpzYAry2iVqZsTd6XKOGpQe0DWzWuFS15OmewZJfBsiarxw0FKyBEAx/+TdZoCcPazdNsHJD/j7Dpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7970

From: Peng Fan <peng.fan@nxp.com>

Add basic implementation of the SCMI v3.2 pincontrol protocol.

Co-developed-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Co-developed-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/arm_scmi/Makefile    |   3 +-
 drivers/firmware/arm_scmi/driver.c    |   2 +
 drivers/firmware/arm_scmi/pinctrl.c   | 916 ++++++++++++++++++++++++++++++++++
 drivers/firmware/arm_scmi/protocols.h |   1 +
 include/linux/scmi_protocol.h         |  84 ++++
 5 files changed, 1005 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
index a7bc4796519c..fd59f58ce8a2 100644
--- a/drivers/firmware/arm_scmi/Makefile
+++ b/drivers/firmware/arm_scmi/Makefile
@@ -10,7 +10,8 @@ scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_SMC) += smc.o
 scmi-transport-$(CONFIG_ARM_SCMI_HAVE_MSG) += msg.o
 scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_VIRTIO) += virtio.o
 scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_OPTEE) += optee.o
-scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o system.o voltage.o powercap.o
+scmi-protocols-y := base.o clock.o perf.o power.o reset.o sensors.o system.o voltage.o powercap.o
+scmi-protocols-y += pinctrl.o
 scmi-module-objs := $(scmi-driver-y) $(scmi-protocols-y) $(scmi-transport-y)
 
 obj-$(CONFIG_ARM_SCMI_PROTOCOL) += scmi-core.o
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index a1e0e8fa4bb7..08ecb918e684 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -3209,6 +3209,7 @@ static int __init scmi_driver_init(void)
 	scmi_voltage_register();
 	scmi_system_register();
 	scmi_powercap_register();
+	scmi_pinctrl_register();
 
 	return platform_driver_register(&scmi_driver);
 }
@@ -3226,6 +3227,7 @@ static void __exit scmi_driver_exit(void)
 	scmi_voltage_unregister();
 	scmi_system_unregister();
 	scmi_powercap_unregister();
+	scmi_pinctrl_unregister();
 
 	scmi_transports_exit();
 
diff --git a/drivers/firmware/arm_scmi/pinctrl.c b/drivers/firmware/arm_scmi/pinctrl.c
new file mode 100644
index 000000000000..a2a7f880d6a3
--- /dev/null
+++ b/drivers/firmware/arm_scmi/pinctrl.c
@@ -0,0 +1,916 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * System Control and Management Interface (SCMI) Pinctrl Protocol
+ *
+ * Copyright (C) 2024 EPAM
+ * Copyright 2024 NXP
+ */
+
+#include <asm/byteorder.h>
+#include <linux/bits.h>
+#include <linux/bitfield.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/scmi_protocol.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/types.h>
+
+#include "common.h"
+#include "protocols.h"
+
+/* Updated only after ALL the mandatory features for that version are merged */
+#define SCMI_PROTOCOL_SUPPORTED_VERSION		0x10000
+
+#define GET_GROUPS_NR(x)	le32_get_bits((x), GENMASK(31, 16))
+#define GET_PINS_NR(x)		le32_get_bits((x), GENMASK(15, 0))
+#define GET_FUNCTIONS_NR(x)	le32_get_bits((x), GENMASK(15, 0))
+
+#define EXT_NAME_FLAG(x)	le32_get_bits((x), BIT(31))
+#define NUM_ELEMS(x)		le32_get_bits((x), GENMASK(15, 0))
+
+#define REMAINING(x)		le32_get_bits((x), GENMASK(31, 16))
+#define RETURNED(x)		le32_get_bits((x), GENMASK(11, 0))
+
+#define CONFIG_FLAG_MASK	GENMASK(19, 18)
+#define SELECTOR_MASK		GENMASK(17, 16)
+#define SKIP_CONFIGS_MASK	GENMASK(15, 8)
+#define CONFIG_TYPE_MASK	GENMASK(7, 0)
+
+enum scmi_pinctrl_protocol_cmd {
+	PINCTRL_ATTRIBUTES = 0x3,
+	PINCTRL_LIST_ASSOCIATIONS = 0x4,
+	PINCTRL_SETTINGS_GET = 0x5,
+	PINCTRL_SETTINGS_CONFIGURE = 0x6,
+	PINCTRL_REQUEST = 0x7,
+	PINCTRL_RELEASE = 0x8,
+	PINCTRL_NAME_GET = 0x9,
+	PINCTRL_SET_PERMISSIONS = 0xa,
+};
+
+struct scmi_msg_settings_conf {
+	__le32 identifier;
+	__le32 function_id;
+	__le32 attributes;
+	__le32 configs[];
+};
+
+struct scmi_msg_settings_get {
+	__le32 identifier;
+	__le32 attributes;
+};
+
+struct scmi_resp_settings_get {
+	__le32 function_selected;
+	__le32 num_configs;
+	__le32 configs[];
+};
+
+struct scmi_msg_pinctrl_protocol_attributes {
+	__le32 attributes_low;
+	__le32 attributes_high;
+};
+
+struct scmi_msg_pinctrl_attributes {
+	__le32 identifier;
+	__le32 flags;
+};
+
+struct scmi_resp_pinctrl_attributes {
+	__le32 attributes;
+	u8 name[SCMI_SHORT_NAME_MAX_SIZE];
+};
+
+struct scmi_msg_pinctrl_list_assoc {
+	__le32 identifier;
+	__le32 flags;
+	__le32 index;
+};
+
+struct scmi_resp_pinctrl_list_assoc {
+	__le32 flags;
+	__le16 array[];
+};
+
+struct scmi_msg_request {
+	__le32 identifier;
+	__le32 flags;
+};
+
+struct scmi_group_info {
+	char name[SCMI_MAX_STR_SIZE];
+	bool present;
+	u32 *group_pins;
+	u32 nr_pins;
+};
+
+struct scmi_function_info {
+	char name[SCMI_MAX_STR_SIZE];
+	bool present;
+	u32 *groups;
+	u32 nr_groups;
+};
+
+struct scmi_pin_info {
+	char name[SCMI_MAX_STR_SIZE];
+	bool present;
+};
+
+struct scmi_pinctrl_info {
+	u32 version;
+	int nr_groups;
+	int nr_functions;
+	int nr_pins;
+	struct scmi_group_info *groups;
+	struct scmi_function_info *functions;
+	struct scmi_pin_info *pins;
+};
+
+static int scmi_pinctrl_attributes_get(const struct scmi_protocol_handle *ph,
+				       struct scmi_pinctrl_info *pi)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_msg_pinctrl_protocol_attributes *attr;
+
+	ret = ph->xops->xfer_get_init(ph, PROTOCOL_ATTRIBUTES, 0, sizeof(*attr), &t);
+	if (ret)
+		return ret;
+
+	attr = t->rx.buf;
+
+	ret = ph->xops->do_xfer(ph, t);
+	if (!ret) {
+		pi->nr_functions = GET_FUNCTIONS_NR(attr->attributes_high);
+		pi->nr_groups = GET_GROUPS_NR(attr->attributes_low);
+		pi->nr_pins = GET_PINS_NR(attr->attributes_low);
+		if (pi->nr_pins == 0) {
+			dev_warn(ph->dev, "returned zero pins\n");
+			ret = -EINVAL;
+		}
+	}
+
+	ph->xops->xfer_put(ph, t);
+	return ret;
+}
+
+static int scmi_pinctrl_count_get(const struct scmi_protocol_handle *ph,
+				  enum scmi_pinctrl_selector_type type)
+{
+	struct scmi_pinctrl_info *pi = ph->get_priv(ph);
+
+	switch (type) {
+	case PIN_TYPE:
+		return pi->nr_pins;
+	case GROUP_TYPE:
+		return pi->nr_groups;
+	case FUNCTION_TYPE:
+		return pi->nr_functions;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int scmi_pinctrl_validate_id(const struct scmi_protocol_handle *ph,
+				    u32 selector,
+				    enum scmi_pinctrl_selector_type type)
+{
+	int value;
+
+	value = scmi_pinctrl_count_get(ph, type);
+	if (value < 0)
+		return value;
+
+	if (selector >= value || value == 0)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int scmi_pinctrl_attributes(const struct scmi_protocol_handle *ph,
+				   enum scmi_pinctrl_selector_type type,
+				   u32 selector, char *name,
+				   u32 *n_elems)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_msg_pinctrl_attributes *tx;
+	struct scmi_resp_pinctrl_attributes *rx;
+	bool ext_name_flag;
+
+	if (!name)
+		return -EINVAL;
+
+	ret = scmi_pinctrl_validate_id(ph, selector, type);
+	if (ret)
+		return ret;
+
+	ret = ph->xops->xfer_get_init(ph, PINCTRL_ATTRIBUTES, sizeof(*tx),
+				      sizeof(*rx), &t);
+	if (ret)
+		return ret;
+
+	tx = t->tx.buf;
+	rx = t->rx.buf;
+	tx->identifier = cpu_to_le32(selector);
+	tx->flags = cpu_to_le32(type);
+
+	ret = ph->xops->do_xfer(ph, t);
+	if (!ret) {
+		if (n_elems)
+			*n_elems = NUM_ELEMS(rx->attributes);
+
+		strscpy(name, rx->name, SCMI_SHORT_NAME_MAX_SIZE);
+
+		ext_name_flag = !!EXT_NAME_FLAG(rx->attributes);
+	}
+
+	ph->xops->xfer_put(ph, t);
+
+	if (ret)
+		return ret;
+	/*
+	 * If supported overwrite short name with the extended one;
+	 * on error just carry on and use already provided short name.
+	 */
+	if (ext_name_flag)
+		ret = ph->hops->extended_name_get(ph, PINCTRL_NAME_GET,
+						  selector, (u32 *)&type, name,
+						  SCMI_MAX_STR_SIZE);
+	return ret;
+}
+
+struct scmi_pinctrl_ipriv {
+	u32 selector;
+	enum scmi_pinctrl_selector_type type;
+	u32 *array;
+};
+
+static void iter_pinctrl_assoc_prepare_message(void *message,
+					       u32 desc_index,
+					       const void *priv)
+{
+	struct scmi_msg_pinctrl_list_assoc *msg = message;
+	const struct scmi_pinctrl_ipriv *p = priv;
+
+	msg->identifier = cpu_to_le32(p->selector);
+	msg->flags = cpu_to_le32(p->type);
+	msg->index = cpu_to_le32(desc_index);
+}
+
+static int iter_pinctrl_assoc_update_state(struct scmi_iterator_state *st,
+					   const void *response, void *priv)
+{
+	const struct scmi_resp_pinctrl_list_assoc *r = response;
+
+	st->num_returned = RETURNED(r->flags);
+	st->num_remaining = REMAINING(r->flags);
+
+	return 0;
+}
+
+static int
+iter_pinctrl_assoc_process_response(const struct scmi_protocol_handle *ph,
+				    const void *response,
+				    struct scmi_iterator_state *st, void *priv)
+{
+	const struct scmi_resp_pinctrl_list_assoc *r = response;
+	struct scmi_pinctrl_ipriv *p = priv;
+
+	p->array[st->desc_index + st->loop_idx] =
+		le16_to_cpu(r->array[st->loop_idx]);
+
+	return 0;
+}
+
+static int scmi_pinctrl_list_associations(const struct scmi_protocol_handle *ph,
+					  u32 selector,
+					  enum scmi_pinctrl_selector_type type,
+					  u16 size, u32 *array)
+{
+	int ret;
+	void *iter;
+	struct scmi_iterator_ops ops = {
+		.prepare_message = iter_pinctrl_assoc_prepare_message,
+		.update_state = iter_pinctrl_assoc_update_state,
+		.process_response = iter_pinctrl_assoc_process_response,
+	};
+	struct scmi_pinctrl_ipriv ipriv = {
+		.selector = selector,
+		.type = type,
+		.array = array,
+	};
+
+	if (!array || !size || type == PIN_TYPE)
+		return -EINVAL;
+
+	ret = scmi_pinctrl_validate_id(ph, selector, type);
+	if (ret)
+		return ret;
+
+	iter = ph->hops->iter_response_init(ph, &ops, size,
+					    PINCTRL_LIST_ASSOCIATIONS,
+					    sizeof(struct scmi_msg_pinctrl_list_assoc),
+					    &ipriv);
+	if (IS_ERR(iter))
+		return PTR_ERR(iter);
+
+	return ph->hops->iter_response_run(iter);
+}
+
+struct scmi_settings_get_ipriv {
+	u32 selector;
+	enum scmi_pinctrl_selector_type type;
+	bool get_all;
+	unsigned int *nr_configs;
+	enum scmi_pinctrl_conf_type *config_types;
+	u32 *config_values;
+};
+
+static void
+iter_pinctrl_settings_get_prepare_message(void *message, u32 desc_index,
+					  const void *priv)
+{
+	struct scmi_msg_settings_get *msg = message;
+	const struct scmi_settings_get_ipriv *p = priv;
+	u32 attributes;
+
+	attributes = FIELD_PREP(SELECTOR_MASK, p->type);
+
+	if (p->get_all) {
+		attributes |= FIELD_PREP(CONFIG_FLAG_MASK, 1) |
+			FIELD_PREP(SKIP_CONFIGS_MASK, desc_index);
+	} else {
+		attributes |= FIELD_PREP(CONFIG_TYPE_MASK, p->config_types[0]);
+	}
+
+	msg->attributes = cpu_to_le32(attributes);
+	msg->identifier = cpu_to_le32(p->selector);
+}
+
+static int
+iter_pinctrl_settings_get_update_state(struct scmi_iterator_state *st,
+				       const void *response, void *priv)
+{
+	const struct scmi_resp_settings_get *r = response;
+	struct scmi_settings_get_ipriv *p = priv;
+
+	if (p->get_all) {
+		st->num_returned = le32_get_bits(r->num_configs, GENMASK(7, 0));
+		st->num_remaining = le32_get_bits(r->num_configs, GENMASK(31, 24));
+	} else {
+		st->num_returned = 1;
+		st->num_remaining = 0;
+	}
+
+	return 0;
+}
+
+static int
+iter_pinctrl_settings_get_process_response(const struct scmi_protocol_handle *ph,
+					   const void *response,
+					   struct scmi_iterator_state *st,
+					   void *priv)
+{
+	const struct scmi_resp_settings_get *r = response;
+	struct scmi_settings_get_ipriv *p = priv;
+	u32 type = le32_get_bits(r->configs[st->loop_idx * 2], GENMASK(7, 0));
+	u32 val = le32_to_cpu(r->configs[st->loop_idx * 2 + 1]);
+
+	if (p->get_all) {
+		p->config_types[st->desc_index + st->loop_idx] = type;
+	} else {
+		if (p->config_types[0] != type)
+			return -EINVAL;
+	}
+
+	p->config_values[st->desc_index + st->loop_idx] = val;
+	++*p->nr_configs;
+
+	return 0;
+}
+
+static int
+scmi_pinctrl_settings_get(const struct scmi_protocol_handle *ph, u32 selector,
+			  enum scmi_pinctrl_selector_type type,
+			  unsigned int *nr_configs,
+			  enum scmi_pinctrl_conf_type *config_types,
+			  u32 *config_values)
+{
+	int ret;
+	void *iter;
+	unsigned int max_configs = *nr_configs;
+	struct scmi_iterator_ops ops = {
+		.prepare_message = iter_pinctrl_settings_get_prepare_message,
+		.update_state = iter_pinctrl_settings_get_update_state,
+		.process_response = iter_pinctrl_settings_get_process_response,
+	};
+	struct scmi_settings_get_ipriv ipriv = {
+		.selector = selector,
+		.type = type,
+		.get_all = (max_configs > 1),
+		.nr_configs = nr_configs,
+		.config_types = config_types,
+		.config_values = config_values,
+	};
+
+	if (!config_types || !config_values || type == FUNCTION_TYPE)
+		return -EINVAL;
+
+	ret = scmi_pinctrl_validate_id(ph, selector, type);
+	if (ret)
+		return ret;
+
+	/* Prepare to count returned configs */
+	*nr_configs = 0;
+	iter = ph->hops->iter_response_init(ph, &ops, max_configs,
+					    PINCTRL_SETTINGS_GET,
+					    sizeof(struct scmi_msg_settings_get),
+					    &ipriv);
+	if (IS_ERR(iter))
+		return PTR_ERR(iter);
+
+	return ph->hops->iter_response_run(iter);
+}
+
+static int scmi_pinctrl_settings_get_one(const struct scmi_protocol_handle *ph,
+					 u32 selector,
+					 enum scmi_pinctrl_selector_type type,
+					 enum scmi_pinctrl_conf_type config_type,
+					 u32 *config_value)
+{
+	unsigned int nr_configs = 1;
+
+	return scmi_pinctrl_settings_get(ph, selector, type, &nr_configs,
+					 &config_type, config_value);
+}
+
+static int scmi_pinctrl_settings_get_all(const struct scmi_protocol_handle *ph,
+					 u32 selector,
+					 enum scmi_pinctrl_selector_type type,
+					 unsigned int *nr_configs,
+					 enum scmi_pinctrl_conf_type *config_types,
+					 u32 *config_values)
+{
+	if (!nr_configs || *nr_configs == 0)
+		return -EINVAL;
+
+	return scmi_pinctrl_settings_get(ph, selector, type, nr_configs,
+					 config_types, config_values);
+}
+
+static int
+scmi_pinctrl_settings_conf(const struct scmi_protocol_handle *ph,
+			   u32 selector,
+			   enum scmi_pinctrl_selector_type type,
+			   u32 nr_configs,
+			   enum scmi_pinctrl_conf_type *config_type,
+			   u32 *config_value)
+{
+	struct scmi_xfer *t;
+	struct scmi_msg_settings_conf *tx;
+	u32 attributes;
+	int ret, i;
+	u32 configs_in_chunk, conf_num = 0;
+	u32 chunk;
+	int max_msg_size = ph->hops->get_max_msg_size(ph);
+
+	if (!config_type || !config_value || type == FUNCTION_TYPE)
+		return -EINVAL;
+
+	ret = scmi_pinctrl_validate_id(ph, selector, type);
+	if (ret)
+		return ret;
+
+	configs_in_chunk = (max_msg_size - sizeof(*tx)) / (sizeof(__le32) * 2);
+	while (conf_num < nr_configs) {
+		chunk = (nr_configs - conf_num > configs_in_chunk) ?
+			configs_in_chunk : nr_configs - conf_num;
+
+		ret = ph->xops->xfer_get_init(ph, PINCTRL_SETTINGS_CONFIGURE,
+					      sizeof(*tx) +
+					      chunk * 2 * sizeof(__le32), 0, &t);
+		if (ret)
+			break;
+
+		tx = t->tx.buf;
+		tx->identifier = cpu_to_le32(selector);
+		tx->function_id = cpu_to_le32(0xFFFFFFFF);
+		attributes = FIELD_PREP(GENMASK(1, 0), type) |
+			FIELD_PREP(GENMASK(9, 2), chunk);
+		tx->attributes = cpu_to_le32(attributes);
+
+		for (i = 0; i < chunk; i++) {
+			tx->configs[i * 2] =
+				cpu_to_le32(config_type[conf_num + i]);
+			tx->configs[i * 2 + 1] =
+				cpu_to_le32(config_value[conf_num + i]);
+		}
+
+		ret = ph->xops->do_xfer(ph, t);
+
+		ph->xops->xfer_put(ph, t);
+
+		if (ret)
+			break;
+
+		conf_num += chunk;
+	}
+
+	return ret;
+}
+
+static int scmi_pinctrl_function_select(const struct scmi_protocol_handle *ph,
+					u32 group,
+					enum scmi_pinctrl_selector_type type,
+					u32 function_id)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_msg_settings_conf *tx;
+	u32 attributes;
+
+	ret = scmi_pinctrl_validate_id(ph, group, type);
+	if (ret)
+		return ret;
+
+	ret = ph->xops->xfer_get_init(ph, PINCTRL_SETTINGS_CONFIGURE,
+				      sizeof(*tx), 0, &t);
+	if (ret)
+		return ret;
+
+	tx = t->tx.buf;
+	tx->identifier = cpu_to_le32(group);
+	tx->function_id = cpu_to_le32(function_id);
+	attributes = FIELD_PREP(GENMASK(1, 0), type) | BIT(10);
+	tx->attributes = cpu_to_le32(attributes);
+
+	ret = ph->xops->do_xfer(ph, t);
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int scmi_pinctrl_request_free(const struct scmi_protocol_handle *ph,
+				     u32 identifier,
+				     enum scmi_pinctrl_selector_type type,
+				     enum scmi_pinctrl_protocol_cmd cmd)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_msg_request *tx;
+
+	if (type == FUNCTION_TYPE)
+		return -EINVAL;
+
+	if (cmd != PINCTRL_REQUEST && cmd != PINCTRL_RELEASE)
+		return -EINVAL;
+
+	ret = scmi_pinctrl_validate_id(ph, identifier, type);
+	if (ret)
+		return ret;
+
+	ret = ph->xops->xfer_get_init(ph, cmd, sizeof(*tx), 0, &t);
+	if (ret)
+		return ret;
+
+	tx = t->tx.buf;
+	tx->identifier = cpu_to_le32(identifier);
+	tx->flags = cpu_to_le32(type);
+
+	ret = ph->xops->do_xfer(ph, t);
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int scmi_pinctrl_pin_request(const struct scmi_protocol_handle *ph,
+				    u32 pin)
+{
+	return scmi_pinctrl_request_free(ph, pin, PIN_TYPE, PINCTRL_REQUEST);
+}
+
+static int scmi_pinctrl_pin_free(const struct scmi_protocol_handle *ph, u32 pin)
+{
+	return scmi_pinctrl_request_free(ph, pin, PIN_TYPE, PINCTRL_RELEASE);
+}
+
+static int scmi_pinctrl_get_group_info(const struct scmi_protocol_handle *ph,
+				       u32 selector,
+				       struct scmi_group_info *group)
+{
+	int ret;
+
+	ret = scmi_pinctrl_attributes(ph, GROUP_TYPE, selector, group->name,
+				      &group->nr_pins);
+	if (ret)
+		return ret;
+
+	if (!group->nr_pins) {
+		dev_err(ph->dev, "Group %d has 0 elements", selector);
+		return -ENODATA;
+	}
+
+	group->group_pins = kmalloc_array(group->nr_pins,
+					  sizeof(*group->group_pins),
+					  GFP_KERNEL);
+	if (!group->group_pins)
+		return -ENOMEM;
+
+	ret = scmi_pinctrl_list_associations(ph, selector, GROUP_TYPE,
+					     group->nr_pins, group->group_pins);
+	if (ret) {
+		kfree(group->group_pins);
+		return ret;
+	}
+
+	group->present = true;
+	return 0;
+}
+
+static int scmi_pinctrl_get_group_name(const struct scmi_protocol_handle *ph,
+				       u32 selector, const char **name)
+{
+	struct scmi_pinctrl_info *pi = ph->get_priv(ph);
+
+	if (!name)
+		return -EINVAL;
+
+	if (selector >= pi->nr_groups || pi->nr_groups == 0)
+		return -EINVAL;
+
+	if (!pi->groups[selector].present) {
+		int ret;
+
+		ret = scmi_pinctrl_get_group_info(ph, selector,
+						  &pi->groups[selector]);
+		if (ret)
+			return ret;
+	}
+
+	*name = pi->groups[selector].name;
+
+	return 0;
+}
+
+static int scmi_pinctrl_group_pins_get(const struct scmi_protocol_handle *ph,
+				       u32 selector, const u32 **pins,
+				       u32 *nr_pins)
+{
+	struct scmi_pinctrl_info *pi = ph->get_priv(ph);
+
+	if (!pins || !nr_pins)
+		return -EINVAL;
+
+	if (selector >= pi->nr_groups || pi->nr_groups == 0)
+		return -EINVAL;
+
+	if (!pi->groups[selector].present) {
+		int ret;
+
+		ret = scmi_pinctrl_get_group_info(ph, selector,
+						  &pi->groups[selector]);
+		if (ret)
+			return ret;
+	}
+
+	*pins = pi->groups[selector].group_pins;
+	*nr_pins = pi->groups[selector].nr_pins;
+
+	return 0;
+}
+
+static int scmi_pinctrl_get_function_info(const struct scmi_protocol_handle *ph,
+					  u32 selector,
+					  struct scmi_function_info *func)
+{
+	int ret;
+
+	ret = scmi_pinctrl_attributes(ph, FUNCTION_TYPE, selector, func->name,
+				      &func->nr_groups);
+	if (ret)
+		return ret;
+
+	if (!func->nr_groups) {
+		dev_err(ph->dev, "Function %d has 0 elements", selector);
+		return -ENODATA;
+	}
+
+	func->groups = kmalloc_array(func->nr_groups, sizeof(*func->groups),
+				     GFP_KERNEL);
+	if (!func->groups)
+		return -ENOMEM;
+
+	ret = scmi_pinctrl_list_associations(ph, selector, FUNCTION_TYPE,
+					     func->nr_groups, func->groups);
+	if (ret) {
+		kfree(func->groups);
+		return ret;
+	}
+
+	func->present = true;
+	return 0;
+}
+
+static int scmi_pinctrl_get_function_name(const struct scmi_protocol_handle *ph,
+					  u32 selector, const char **name)
+{
+	struct scmi_pinctrl_info *pi = ph->get_priv(ph);
+
+	if (!name)
+		return -EINVAL;
+
+	if (selector >= pi->nr_functions || pi->nr_functions == 0)
+		return -EINVAL;
+
+	if (!pi->functions[selector].present) {
+		int ret;
+
+		ret = scmi_pinctrl_get_function_info(ph, selector,
+						     &pi->functions[selector]);
+		if (ret)
+			return ret;
+	}
+
+	*name = pi->functions[selector].name;
+	return 0;
+}
+
+static int
+scmi_pinctrl_function_groups_get(const struct scmi_protocol_handle *ph,
+				 u32 selector, u32 *nr_groups,
+				 const u32 **groups)
+{
+	struct scmi_pinctrl_info *pi = ph->get_priv(ph);
+
+	if (!groups || !nr_groups)
+		return -EINVAL;
+
+	if (selector >= pi->nr_functions || pi->nr_functions == 0)
+		return -EINVAL;
+
+	if (!pi->functions[selector].present) {
+		int ret;
+
+		ret = scmi_pinctrl_get_function_info(ph, selector,
+						     &pi->functions[selector]);
+		if (ret)
+			return ret;
+	}
+
+	*groups = pi->functions[selector].groups;
+	*nr_groups = pi->functions[selector].nr_groups;
+
+	return 0;
+}
+
+static int scmi_pinctrl_mux_set(const struct scmi_protocol_handle *ph,
+				u32 selector, u32 group)
+{
+	return scmi_pinctrl_function_select(ph, group, GROUP_TYPE, selector);
+}
+
+static int scmi_pinctrl_get_pin_info(const struct scmi_protocol_handle *ph,
+				     u32 selector, struct scmi_pin_info *pin)
+{
+	int ret;
+
+	if (!pin)
+		return -EINVAL;
+
+	ret = scmi_pinctrl_attributes(ph, PIN_TYPE, selector, pin->name, NULL);
+	if (ret)
+		return ret;
+
+	pin->present = true;
+	return 0;
+}
+
+static int scmi_pinctrl_get_pin_name(const struct scmi_protocol_handle *ph,
+				     u32 selector, const char **name)
+{
+	struct scmi_pinctrl_info *pi = ph->get_priv(ph);
+
+	if (!name)
+		return -EINVAL;
+
+	if (selector >= pi->nr_pins)
+		return -EINVAL;
+
+	if (!pi->pins[selector].present) {
+		int ret;
+
+		ret = scmi_pinctrl_get_pin_info(ph, selector, &pi->pins[selector]);
+		if (ret)
+			return ret;
+	}
+
+	*name = pi->pins[selector].name;
+
+	return 0;
+}
+
+static int scmi_pinctrl_name_get(const struct scmi_protocol_handle *ph,
+				 u32 selector,
+				 enum scmi_pinctrl_selector_type type,
+				 const char **name)
+{
+	switch (type) {
+	case PIN_TYPE:
+		return scmi_pinctrl_get_pin_name(ph, selector, name);
+	case GROUP_TYPE:
+		return scmi_pinctrl_get_group_name(ph, selector, name);
+	case FUNCTION_TYPE:
+		return scmi_pinctrl_get_function_name(ph, selector, name);
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct scmi_pinctrl_proto_ops pinctrl_proto_ops = {
+	.count_get = scmi_pinctrl_count_get,
+	.name_get = scmi_pinctrl_name_get,
+	.group_pins_get = scmi_pinctrl_group_pins_get,
+	.function_groups_get = scmi_pinctrl_function_groups_get,
+	.mux_set = scmi_pinctrl_mux_set,
+	.settings_get_one = scmi_pinctrl_settings_get_one,
+	.settings_get_all = scmi_pinctrl_settings_get_all,
+	.settings_conf = scmi_pinctrl_settings_conf,
+	.pin_request = scmi_pinctrl_pin_request,
+	.pin_free = scmi_pinctrl_pin_free,
+};
+
+static int scmi_pinctrl_protocol_init(const struct scmi_protocol_handle *ph)
+{
+	int ret;
+	u32 version;
+	struct scmi_pinctrl_info *pinfo;
+
+	ret = ph->xops->version_get(ph, &version);
+	if (ret)
+		return ret;
+
+	dev_dbg(ph->dev, "Pinctrl Version %d.%d\n",
+		PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
+
+	pinfo = devm_kzalloc(ph->dev, sizeof(*pinfo), GFP_KERNEL);
+	if (!pinfo)
+		return -ENOMEM;
+
+	ret = scmi_pinctrl_attributes_get(ph, pinfo);
+	if (ret)
+		return ret;
+
+	pinfo->pins = devm_kcalloc(ph->dev, pinfo->nr_pins,
+				   sizeof(*pinfo->pins), GFP_KERNEL);
+	if (!pinfo->pins)
+		return -ENOMEM;
+
+	pinfo->groups = devm_kcalloc(ph->dev, pinfo->nr_groups,
+				     sizeof(*pinfo->groups), GFP_KERNEL);
+	if (!pinfo->groups)
+		return -ENOMEM;
+
+	pinfo->functions = devm_kcalloc(ph->dev, pinfo->nr_functions,
+					sizeof(*pinfo->functions), GFP_KERNEL);
+	if (!pinfo->functions)
+		return -ENOMEM;
+
+	pinfo->version = version;
+
+	return ph->set_priv(ph, pinfo, version);
+}
+
+static int scmi_pinctrl_protocol_deinit(const struct scmi_protocol_handle *ph)
+{
+	int i;
+	struct scmi_pinctrl_info *pi = ph->get_priv(ph);
+
+	/* Free groups_pins allocated in scmi_pinctrl_get_group_info */
+	for (i = 0; i < pi->nr_groups; i++) {
+		if (pi->groups[i].present) {
+			kfree(pi->groups[i].group_pins);
+			pi->groups[i].present = false;
+		}
+	}
+
+	/* Free groups allocated in scmi_pinctrl_get_function_info */
+	for (i = 0; i < pi->nr_functions; i++) {
+		if (pi->functions[i].present) {
+			kfree(pi->functions[i].groups);
+			pi->functions[i].present = false;
+		}
+	}
+
+	return 0;
+}
+
+static const struct scmi_protocol scmi_pinctrl = {
+	.id = SCMI_PROTOCOL_PINCTRL,
+	.owner = THIS_MODULE,
+	.instance_init = &scmi_pinctrl_protocol_init,
+	.instance_deinit = &scmi_pinctrl_protocol_deinit,
+	.ops = &pinctrl_proto_ops,
+	.supported_version = SCMI_PROTOCOL_SUPPORTED_VERSION,
+};
+DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(pinctrl, scmi_pinctrl)
diff --git a/drivers/firmware/arm_scmi/protocols.h b/drivers/firmware/arm_scmi/protocols.h
index 3e91536a77a3..c02cbfd2bb03 100644
--- a/drivers/firmware/arm_scmi/protocols.h
+++ b/drivers/firmware/arm_scmi/protocols.h
@@ -355,6 +355,7 @@ void __exit scmi_##name##_unregister(void)			\
 DECLARE_SCMI_REGISTER_UNREGISTER(base);
 DECLARE_SCMI_REGISTER_UNREGISTER(clock);
 DECLARE_SCMI_REGISTER_UNREGISTER(perf);
+DECLARE_SCMI_REGISTER_UNREGISTER(pinctrl);
 DECLARE_SCMI_REGISTER_UNREGISTER(power);
 DECLARE_SCMI_REGISTER_UNREGISTER(reset);
 DECLARE_SCMI_REGISTER_UNREGISTER(sensors);
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index a3addb07e00a..3a9bb5b9a9e8 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -737,6 +737,89 @@ struct scmi_powercap_proto_ops {
 					  u32 *power_thresh_high);
 };
 
+enum scmi_pinctrl_selector_type {
+	PIN_TYPE = 0,
+	GROUP_TYPE,
+	FUNCTION_TYPE,
+};
+
+enum scmi_pinctrl_conf_type {
+	SCMI_PIN_DEFAULT = 0,
+	SCMI_PIN_BIAS_BUS_HOLD = 1,
+	SCMI_PIN_BIAS_DISABLE = 2,
+	SCMI_PIN_BIAS_HIGH_IMPEDANCE = 3,
+	SCMI_PIN_BIAS_PULL_UP = 4,
+	SCMI_PIN_BIAS_PULL_DEFAULT = 5,
+	SCMI_PIN_BIAS_PULL_DOWN = 6,
+	SCMI_PIN_DRIVE_OPEN_DRAIN = 7,
+	SCMI_PIN_DRIVE_OPEN_SOURCE = 8,
+	SCMI_PIN_DRIVE_PUSH_PULL = 9,
+	SCMI_PIN_DRIVE_STRENGTH = 10,
+	SCMI_PIN_INPUT_DEBOUNCE = 11,
+	SCMI_PIN_INPUT_MODE = 12,
+	SCMI_PIN_PULL_MODE = 13,
+	SCMI_PIN_INPUT_VALUE = 14,
+	SCMI_PIN_INPUT_SCHMITT = 15,
+	SCMI_PIN_LOW_POWER_MODE = 16,
+	SCMI_PIN_OUTPUT_MODE = 17,
+	SCMI_PIN_OUTPUT_VALUE = 18,
+	SCMI_PIN_POWER_SOURCE = 19,
+	SCMI_PIN_SLEW_RATE = 20,
+	SCMI_PIN_OEM_START = 192,
+	SCMI_PIN_OEM_END = 255,
+};
+
+/**
+ * struct scmi_pinctrl_proto_ops - represents the various operations provided
+ * by SCMI Pinctrl Protocol
+ *
+ * @count_get: returns count of the registered elements in given type
+ * @name_get: returns name by index of given type
+ * @group_pins_get: returns the set of pins, assigned to the specified group
+ * @function_groups_get: returns the set of groups, assigned to the specified
+ *	function
+ * @mux_set: set muxing function for groups of pins
+ * @settings_get_one: returns one configuration parameter for pin or group
+ *	specified by config_type
+ * @settings_get_all: returns all configuration parameters for pin or group
+ * @settings_conf: sets the configuration parameter for pin or group
+ * @pin_request: aquire pin before selecting mux setting
+ * @pin_free: frees pin, acquired by request_pin call
+ */
+struct scmi_pinctrl_proto_ops {
+	int (*count_get)(const struct scmi_protocol_handle *ph,
+			 enum scmi_pinctrl_selector_type type);
+	int (*name_get)(const struct scmi_protocol_handle *ph, u32 selector,
+			enum scmi_pinctrl_selector_type type,
+			const char **name);
+	int (*group_pins_get)(const struct scmi_protocol_handle *ph,
+			      u32 selector, const unsigned int **pins,
+			      unsigned int *nr_pins);
+	int (*function_groups_get)(const struct scmi_protocol_handle *ph,
+				   u32 selector, unsigned int *nr_groups,
+				   const unsigned int **groups);
+	int (*mux_set)(const struct scmi_protocol_handle *ph, u32 selector,
+		       u32 group);
+	int (*settings_get_one)(const struct scmi_protocol_handle *ph,
+				u32 selector,
+				enum scmi_pinctrl_selector_type type,
+				enum scmi_pinctrl_conf_type config_type,
+				u32 *config_value);
+	int (*settings_get_all)(const struct scmi_protocol_handle *ph,
+				u32 selector,
+				enum scmi_pinctrl_selector_type type,
+				unsigned int *nr_configs,
+				enum scmi_pinctrl_conf_type *config_types,
+				u32 *config_values);
+	int (*settings_conf)(const struct scmi_protocol_handle *ph,
+			     u32 selector, enum scmi_pinctrl_selector_type type,
+			     unsigned int nr_configs,
+			     enum scmi_pinctrl_conf_type *config_type,
+			     u32 *config_value);
+	int (*pin_request)(const struct scmi_protocol_handle *ph, u32 pin);
+	int (*pin_free)(const struct scmi_protocol_handle *ph, u32 pin);
+};
+
 /**
  * struct scmi_notify_ops  - represents notifications' operations provided by
  * SCMI core
@@ -842,6 +925,7 @@ enum scmi_std_protocol {
 	SCMI_PROTOCOL_RESET = 0x16,
 	SCMI_PROTOCOL_VOLTAGE = 0x17,
 	SCMI_PROTOCOL_POWERCAP = 0x18,
+	SCMI_PROTOCOL_PINCTRL = 0x19,
 };
 
 enum scmi_system_events {

-- 
2.37.1


