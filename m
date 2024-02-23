Return-Path: <linux-kernel+bounces-77609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA8286080C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 02:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4277A1C21A46
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 01:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8E9B67F;
	Fri, 23 Feb 2024 01:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lhySqXsM"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2058.outbound.protection.outlook.com [40.107.21.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52C6AD58;
	Fri, 23 Feb 2024 01:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708650530; cv=fail; b=fpLTEws2vxdF3yHT59E81EWOIx1hZ9GCcmD3qVchbXxuv2kKC5EN/ZCa19ef6quN5AdolN70WohHfJ3N9DOUTZrkJSO2v/jXunZjh+8eSNzeh3AQkmuORl/2eaAeItgQHlYc6bkZ2f2rnyQvLjiFt2iEDPYjcDkKW1P619R2zYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708650530; c=relaxed/simple;
	bh=LIbiOyIEb5ksMqwfw+ihfUycxea+JF7Ac2NBrH72rjM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=GsrWvd/Jm9xx/g7Gik5vzaEM6tY8IiibG6/w8z0H2LVNAI/gJ2GLjiA2FbAbYyPPB0YD17w/m+yP0+xkczJ+OCMQ/NzRpPtDQtKwdISsjxLitcH/Fnz9t1yfd/tAcVWfmMx0sAo0kjz+iL1jlURYUVZmDOA5f2IKGLTU2AxowRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=lhySqXsM; arc=fail smtp.client-ip=40.107.21.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AqZBRfHh6k/5/3+S2XrijHRVS9HO0K8Ec8JCptOUHc64ayjechybcPQ8QpIWos5NHGjMZ78qoPA4PWVPC2IGCFiA5Ahizn+C+XKx9/Kpesm2OID6nIgPbpTRFi2QlJKBNojaTqY7Vbs9Mp/JT+8LhtNHbKTF28V1tDRx1pW5xNTKmVOaCRmD6mzpXitSdBwtG+pqei879frACSJAKzPLNxDu4mx3Omy7VPlK0isnj9YaybWvQiGY5dUuJZF2+V9TRrfo2OwUlMqwkLBlevp1pETB8+6KDIuqL0wufDJ5wqe057XA+hwafMMeZ/nzMQtUtCKINJ4TBxRodQSlqyhfCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cCcalEI+UIRZcakIjpwOIHhvXPGL1GR96ZhZnkDLELk=;
 b=DX0cTB41zDjXgWsxsuc17R29Ip9nYdgnp5bQzaixWuxlDTS3Jxrwy3Z8QBTEsT186IPtWSe9JLMIwkzuV44Swqra1S1aGsdHClREouuapGcDwDk8oWbcddfJ4h7ze4hP8yZxyEYqbad+r0H6sWVJGz0wYn0d0wllT8l4Kl7XI2Djiaa9MzK02gKnqbhH2a16n7eWcQiw/hUcld90jLqKERx/d0oS1sicR6rzLYHoHATkRvg+yFf5Owql89bW6QUG77bE3exYOgUlKx9D3RxK79bIHqCoD05dsrUi5pE0fEeG9BGeCE8DzIWmUYlXRJzlHBWpw3DL8zG6o1slSoHehw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cCcalEI+UIRZcakIjpwOIHhvXPGL1GR96ZhZnkDLELk=;
 b=lhySqXsMmLIFmwoW4Qo08eGea1YDkwFiNujyQxvK0tLMPNCaFpVsfxea595lhRAX5eKKcodvIbY6ykoHlJbVSIyi6BowrvxcIiruinI8BaBxKN0ujIkvUtvtbdGJiXTV/SPwyQ0cfk1aBp5df/96sJYwuZZW1TntDLLTljRvztQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8418.eurprd04.prod.outlook.com (2603:10a6:20b:3fa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 01:08:44 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::4ac3:3559:4200:38e1]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::4ac3:3559:4200:38e1%4]) with mapi id 15.20.7292.036; Fri, 23 Feb 2024
 01:08:44 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 23 Feb 2024 09:16:38 +0800
Subject: [PATCH v4 1/4] firmware: arm_scmi: introduce helper
 get_max_msg_size
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-pinctrl-scmi-v4-1-10eb5a379274@nxp.com>
References: <20240223-pinctrl-scmi-v4-0-10eb5a379274@nxp.com>
In-Reply-To: <20240223-pinctrl-scmi-v4-0-10eb5a379274@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708651021; l=2659;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=DBKFhaPpqrkJGCSTluDmc3QczHu1uAahbhhYhwpdRZI=;
 b=91F9bSboHX82fJggsXBcephRnZfsy9xqMLcMwDkRWe9p/LgccbEnm89/ki47oFaXfZ/Z10JfZ
 sm8rLjDrHieAYi11be0EZxS+PIW+YcvdRZ+y2I9kgTGmPNDEunemqbB
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR04CA0009.apcprd04.prod.outlook.com
 (2603:1096:4:197::8) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8418:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e783a9f-5006-48a3-eaa3-08dc340bfb3f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hsnAbMRsZYxqXIyAllcuNfIq/DpXvWptDvayfCLJB/ibsWyZhlHXYNsJjrrM5LIREVfObd0XrIBCjF3vt3oawMnDtazgq8KzT9Ag5pvvs3HRQ6ebokJpnw2RnrkZepy6cPjVPiiAYnXLfUfy6UKwHj0984YfdOlgX2XGzgeL2tdonFSeOEjyD5MoUnlO/UUFmxaXzyxoDRgV/3JEUuAWiei2MMaSeh+isvcptXJSczg+uAzMCqDWuNIKKOF/+7YUWj7sM6CSUZadPWybgAqMLJBATDPxtfbzLULxOPyBYNoo/aBQlSQtgPM6PCt5M2oRS4ZFzNQnokrJEHjhjYDkIwI0FOpWJ6pPlEf0xNUpwZ3/E3P1nNQNM1Qjy4JvcmOGtS6UoajJYoHNtLnXgGu+gjG6U1ysW89OyAqfyLll0s8y+YIAAzOw+o2RrWCnrpJSPq/lNWvG5VH6vATiWTQRLLFhAwVko2pQsSqAeTQuqPZ4ajPbgYEj+VrShNYS1zpxHOVySD9E6virX74uqzcatqUxplbEl6pMW+86vdz5qeGaKxZ+L0j6IuDKoYQaA8RH0qlzhsd19/2TDriQI6nSZ0HCIUyJTTslpI1fqIuIsyIBWZC+WXXLRa3VTTHHKrg7dCtg3AMGRZZrtfrxgC0eXQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZXFXSmNCUGZ1MFkvY3VLaExaelhTQ3N3WkVRY2M3czRCamR5TkVrVi8vd1d6?=
 =?utf-8?B?L2IzU0xMaEZUZ0VGT01INnFqSUJBaVFGR2pTOStQQ3B4bW5Db0NOTFZXbUlZ?=
 =?utf-8?B?N092NUQyYVFDUHNsRVRTdHFCd2tMdkk1ZkFDNDNYR2xDSzE0VGgyQ3Y3MFh5?=
 =?utf-8?B?clFDWDZvbTI1VTFSd3FHNit5WlhlR01Oa3FFZi9pNUszWGMxY3lSUEJCcWZh?=
 =?utf-8?B?aFBINGtmVlpLS3NvME1acDFUdXB5KzBBMDlWVVkrakt3RFI3SDBiTENsbnJs?=
 =?utf-8?B?U3FEU1l1NWFTUXhFSzYxVldXZVEwQ2s0b0l0S2xicTZmQlc1YmdYQk4wenhF?=
 =?utf-8?B?L2ozWFNlSXlDQXFJV0duTkRUcElYdCtDcC85ZW9aMk9GVkdOTXB2TjkydURq?=
 =?utf-8?B?cWxsZjZZYkpnYjRwRnZBZ05qK2xzUVNxcnJGUlBITkxRc0NQTlB4eEdETUlh?=
 =?utf-8?B?dWZnaEt5ZjByUGc5TjJnSmh0eGRLRTFuRDNMOFVzS3pQTDBqNlM3WnZTWndQ?=
 =?utf-8?B?cnY5UFVwMUdMbWdJTGIrNkQ1NnRmdk1SWlJVL1hmMnNIYWxlNE9rZU5vcXRM?=
 =?utf-8?B?VytScWxVN2tYTWtGUEc5bDlmSWlNU0ZRcnRmRkUvdlBhVEladHpnWVRSeGFZ?=
 =?utf-8?B?Y3pRT2YwYURNN09GaUhUMnQrdDFBRUlNQXVmSmM4TWl1L3JDbzhGOTVEdmJt?=
 =?utf-8?B?SHRsUThDWkNyZlQxdHV0WHB4ZFlXSk9TUWRIeG5HYlUxY0JOc0FsVnhMUFZJ?=
 =?utf-8?B?b1Noa3Z1Q0diaFo2azd2ajVkaFdDSktqbjNicVdiZFRLQi9lblZSUVFUWlRY?=
 =?utf-8?B?Q0pGZkVIa2FoWE1Pb05iQTZVaEp5akxKYlFLRDZzcVkrZ0EwZ2RLU0xGc3ZB?=
 =?utf-8?B?bmd6bldNQUtpK3dIaGtXQnBoUFp2dGJZbk5Gcm5sNnpBcC95TEJQTDRnY2FH?=
 =?utf-8?B?a0o5WWxyQmpnb3A0Rmd6SjEwZmF5VXl5VG51S3o5N3FJemVRNXpjSW02b2Jl?=
 =?utf-8?B?ZHZVNVdpVVhnak5tR1U5Z0VnOTRESXNFQUVCTGFmSnhPazg4SFcwWFFYbVhX?=
 =?utf-8?B?RnJjWHpkS2d3T2lJRnYrRmw3TWg1KzdtNG1ETU15akw2WDFPcThROVpib0NF?=
 =?utf-8?B?VGlpQ3lEeVV1Z2ptSXdlT0pzY3V6akhUbU1seUhYMVJ0VUtPQkJud3VwUER1?=
 =?utf-8?B?aldtL1ZoQ1BEQ1VMSHRtakdwLzV3cDB4elpSZFZsbmVsSXoxUkNRQ0JRSlhO?=
 =?utf-8?B?MHFlZ093cnVMak1sSHU5Zk1wUWlKYTd2dE1oMHFSenp3VVkrd0M2ampBc0tL?=
 =?utf-8?B?ZU5wa2Q3by93eUFudUZmZHF1RjlnTktnTjNTN2VUL1FMeDJFZGl0WEJqZGxF?=
 =?utf-8?B?S0QwNFUybVhkSFFzSmwvRlBMODR5NVoydlFiTnNuUXVhc0c5bmIxTHhYWnJp?=
 =?utf-8?B?MnRadi9TRmxXZUhGNFB1WjFId2V3SlpZakpGUVNaSFBwVnlXU0JKK01pWitP?=
 =?utf-8?B?MmxxaXJ5ZTdldjlLNTBoQ0k3UUkvN2kzUGpUbW9EbnI2QUgzMXVzNUtEdnNU?=
 =?utf-8?B?OVI4WWMyajVJU2xTOExDbmxpNUQwdTB2ZnhHb3lGWm1jN1BsdWdXUGdrSlRt?=
 =?utf-8?B?QXVXWEhUNm84OFN1VitLdkFqTkxjSnFlMTlWZ0M1bGpDTmhRVk53Ykk5UnZH?=
 =?utf-8?B?em12M2k0K0poUmpzUFNmNGx2OTMvZUFDeUdldHMzVTMrUnQ3RFgzVklqRGh1?=
 =?utf-8?B?c3BKb2FSVHhRNENWdEpmd09WN3NkUEl0WUJ5ZnYzdk0zUEFYYnYwQkNWU0VQ?=
 =?utf-8?B?NklDcG4vYmNLZTQxQlVKank2NTcxUlRrY3pqYlJXOTRkb0xpUWNPcjM0ZWc0?=
 =?utf-8?B?UHQzVDcwdytadjhnSFFrRVRGMGhZaXR2SDkyd1JIZ0QvcFRvM2dpMHgzVzRP?=
 =?utf-8?B?NENpNU9UUVB3c0hxNWxxQ200SnJZL2kxcXhXdlhjUm4ya1czaSswMWsrRHhj?=
 =?utf-8?B?UndJWmVLT1FZcUg2b0tmSXEySEZrV3pjMmF3UndoRmoxZUpRcDVNSkdSUWR5?=
 =?utf-8?B?OUJPNmpsSVh5b3JlSW4wMHVDY1ZKMzJWUndRN1o1WlN2MDJIcWk1R0pRR1JM?=
 =?utf-8?Q?DtEM7Do0q/rn2W/x56bG/tIup?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e783a9f-5006-48a3-eaa3-08dc340bfb3f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 01:08:44.5884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sFYsbZSxKxWIk4SlX2VLM+STEVNlB0Cck4OV7pzvSKDILg9hKHYwsVOyt1pyN2XhCBb7VZwtZM3NxHlU51kOqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8418

From: Peng Fan <peng.fan@nxp.com>

When Agent sending data to SCMI server, the Agent driver could check
the size to avoid protocol buffer overflow. So introduce the helper
get_max_msg_size.

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/arm_scmi/driver.c    | 15 +++++++++++++++
 drivers/firmware/arm_scmi/protocols.h |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 34d77802c990..6f059a585896 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -1488,6 +1488,20 @@ static int scmi_common_extended_name_get(const struct scmi_protocol_handle *ph,
 	return ret;
 }
 
+/**
+ * scmi_common_get_max_msg_size  - Get maximum message size
+ * @ph: A protocol handle reference.
+ *
+ * Return: Maximum message size for the current protocol.
+ */
+static int scmi_common_get_max_msg_size(const struct scmi_protocol_handle *ph)
+{
+	const struct scmi_protocol_instance *pi = ph_to_pi(ph);
+	struct scmi_info *info = handle_to_scmi_info(pi->handle);
+
+	return info->desc->max_msg_size;
+}
+
 /**
  * struct scmi_iterator  - Iterator descriptor
  * @msg: A reference to the message TX buffer; filled by @prepare_message with
@@ -1796,6 +1810,7 @@ static int scmi_protocol_msg_check(const struct scmi_protocol_handle *ph,
 
 static const struct scmi_proto_helpers_ops helpers_ops = {
 	.extended_name_get = scmi_common_extended_name_get,
+	.get_max_msg_size = scmi_common_get_max_msg_size,
 	.iter_response_init = scmi_iterator_init,
 	.iter_response_run = scmi_iterator_run,
 	.protocol_msg_check = scmi_protocol_msg_check,
diff --git a/drivers/firmware/arm_scmi/protocols.h b/drivers/firmware/arm_scmi/protocols.h
index 693019fff0f6..9c8edb1aa901 100644
--- a/drivers/firmware/arm_scmi/protocols.h
+++ b/drivers/firmware/arm_scmi/protocols.h
@@ -257,6 +257,7 @@ struct scmi_fc_info {
  * @fastchannel_init: A common helper used to initialize FC descriptors by
  *		      gathering FC descriptions from the SCMI platform server.
  * @fastchannel_db_ring: A common helper to ring a FC doorbell.
+ * @get_max_msg_size: A common helper to get the maximum message size.
  */
 struct scmi_proto_helpers_ops {
 	int (*extended_name_get)(const struct scmi_protocol_handle *ph,
@@ -275,6 +276,7 @@ struct scmi_proto_helpers_ops {
 				 void __iomem **p_addr,
 				 struct scmi_fc_db_info **p_db);
 	void (*fastchannel_db_ring)(struct scmi_fc_db_info *db);
+	int (*get_max_msg_size)(const struct scmi_protocol_handle *ph);
 };
 
 /**

-- 
2.37.1


