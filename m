Return-Path: <linux-kernel+bounces-16525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB17823FAF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 963C5280C8A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B31210FB;
	Thu,  4 Jan 2024 10:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="JHeBpea3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2040.outbound.protection.outlook.com [40.107.241.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA59210F0;
	Thu,  4 Jan 2024 10:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nINRsib9L2MPioXTYgQ3D01IPczqbM8Ow5XZFNOiJ1uIbf4E8kU4GvqGMIbd5aF1hbBObVvkyFjRE2YlteqvGThGpmoKNIPnsgGTGFaxQg7xJXUtgYBswCGQL/3v7uz8R3Cs7bn/HIP6Tw2c1KxJfkbxidwg9qY+xsm4KouZLq7rp73uj8js3gUTxVS8OJloQ0eQI8ANC8kWv8AxDTpPWxTgaVoMQy4HKe0kGO8g1jKVhL8D3ncOnBTr2sI2KVGxun/bemk9kmKpjuvX6ODi2tTKazVcN9VKkEEoNu1jd01lBzVAWKhOon6v1lNZsUxYs7GK/kvvikpoPKPwQ0K12g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c8Q4gYjUQC14yC5W6QW/OwqgmYc1DkZqkRCHzTcTI5o=;
 b=AjuXufFRSuu7e6u6ptBmJT9FTpxBjAidKjWjATp+TZ0q7VQuCbseTYWNx8V31naEgnTXdM+OMixOa94L2Z2djX2hXoLh2yS3DLrewK34Xb4ATD7yD+tfkAZDpfAFd5oc0faspnspAIVDpPma7mAhkhPT30a5kRAZnOuXSzI97U2j6LX/tlyYZT/XtuQ7rB4ake6oh5Q/1Hk3PPVhKsNyrM7HiKWMOyCewE6Cq25jDh19MkiGZWn+VvtYYGtZbZXZl2N0KBPtQrgO2Gs8T9+PNxsX0z2R3yl1+/9bgvjnxLb2+bquuqy1e3wG9mf0AsVKCZHyxxSfQEmVH7O5hxlI+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c8Q4gYjUQC14yC5W6QW/OwqgmYc1DkZqkRCHzTcTI5o=;
 b=JHeBpea39DfX5S3ePeg5lWEoqT5jR+Psi3cx9tuk+zRSpbEKderZKtYqHbntyLzZhhPfWdIzSOzXoKCK5AVE7dvzV3Wf1Purq8l+lyhG6pR0uuce5c/gx7byQskmElRr8qmGx8JdTQLLF3U2+aNGvYcx3XKQaqZeI9HndlVxzjg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8847.eurprd04.prod.outlook.com (2603:10a6:102:20e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Thu, 4 Jan
 2024 10:44:51 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ff06:bbb2:c068:5fb3]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ff06:bbb2:c068:5fb3%7]) with mapi id 15.20.7135.023; Thu, 4 Jan 2024
 10:44:51 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 04 Jan 2024 18:48:45 +0800
Subject: [PATCH v2 1/6] firmware: arm_scmi: introduce helper
 get_max_msg_size
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240104-pinctrl-scmi-v2-1-a9bd86ab5a84@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704365357; l=2660;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=woqhTHJgcBsnzMOI1imkT0MV1gtJZhQATiD3eryt0aA=;
 b=AfB8YdNCCChlIE9jt/x3WRkWZBYClWR/43M40BivfVd5eUxYH4kwJIKl+zhWFGgDFwSUbVrBO
 iqScQOzNKiaB6PB/8uLdfdI6kICzQiB7/S279wJTQNvEC3Y9GxTS0dB
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
X-MS-Office365-Filtering-Correlation-Id: fa7142cd-e896-41e9-7d89-08dc0d122e18
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bSb17y8Mlj8yemrZWAdF0mc4EAfPFumNlELjS2fSAzYbPzyuZgsAW4b/F5Bpl4hAcJGEMSTMH1/S90ZQiwfUTG8h+KA8pU34Rz3BnqKVHO2+HhuI863xYAjShFqThiG5jEgSRXZtrrkj+cdob0bVk6+mtQOT12e+K5V4lylmiVtsU1KLycGE8/ABgVo1SpXfTyExtHZcqO57ApWcH57weTNNXl4RqqzRnOocBXMMfDqLjv2OcEoEeIxezauNZTblgczb6vN1OPhZ494DDeZ1gzvvYCpslravVJcWmjggJBQa+kFgO9q79AUoA4Tirmrp5flm5cI+R83hX3YZcr7gsISt8k+Wpb827hh16/Hr2WAgfFqh4VRXilbyEdSZBCjSbsKdbz0YYp4BHxqt15Rft5qrZkVJlIjKZmjE4VnmyiAmS4i0xSYZKwho/ayXf6Y8gIQIjwWcIsbSSSqpCkD/rIwyXJTMmsaXtAC0IsUTuE9kRUtZeh1CbECxrtSUTm1Y5LeXPeWUhDx/giKjqy4BNidTwfxpgkJQWY/lJZl4u1fDahkPKXe4tEoiY3p2Rv/EtRPnbd/70DSIxPN2l6/Ufl1Nk7pCkGWFNWal5LFQfR9K8Knem2oCqJNpQyZ70eitiisSEdStqFr/kZMdiAVNWA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(39860400002)(396003)(136003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(66476007)(66946007)(66556008)(6486002)(4326008)(8936002)(8676002)(26005)(54906003)(110136005)(316002)(83380400001)(6666004)(478600001)(52116002)(5660300002)(41300700001)(2906002)(7416002)(6506007)(6512007)(9686003)(38350700005)(921011)(36756003)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YzJhR0lxTUhRclpzUU1PeWZSMnd6c2ZWUGxrYzVFcy9YaWdWYVRFWTRxRzg2?=
 =?utf-8?B?SDBId2c1eEZzaUZmWThTS0lUc0JUd0d3ZlBVUTJ4ekw2eXJxN0tSVXE5cnlw?=
 =?utf-8?B?UkVkZUJYUHlmek5ROVo3Uk0xcVFVbnBkanlESGFBTGVPcFZENTJwRTVIOU0r?=
 =?utf-8?B?U1NVakN4eHhHYmdYbk9rMDcvMnJoZmozb1lBRk52Wm9VdXQwVGZTOG5SclB2?=
 =?utf-8?B?dUU2eGUvM1VhNmpPSnpJdzU3ZngxY0VscU1ONk16WmQvY0NyYy9SZ05QK2hR?=
 =?utf-8?B?S3psOVgvRlFLWjlvOVBUZ25EWldJcnp3YlBNcDJzUFZLVXRXUWs4d01zSHZF?=
 =?utf-8?B?VTUxdmRmMmt3U2pFUWw4cjh6NkpjZStIZDVJZVpuNmFuSExNOVVmTWl3Z3dF?=
 =?utf-8?B?WGIvcHhrOHJLVDNDQjJXaGNJeURpTHJxQVhoeTlCZXp4cG9BTWpWbnJJSEo4?=
 =?utf-8?B?SXUrZy9nQ3RUUXlUUVpUSm9JWktaclVsSXU5dHlHSzE4bFdMSG5mc2U1alVE?=
 =?utf-8?B?bXVWM0hBeXo4YnVmOFUxWUdlMFJtN2V0cTJyQWdGbm1rLzUxbjlTczV4U3B3?=
 =?utf-8?B?ZzB0RjJQMHFYbWpXVlB6bXBId2hQd0dGU1hLN2Y2V2p3VlRHZWRFZ3pGMXBo?=
 =?utf-8?B?TDZLVytPYVcxRkRmSXM2N1ZtUU5aVWZMTFNWOG03UFBWQ3hkbVZTSzlrSE9G?=
 =?utf-8?B?VDU4QVpUd2dNdzVpWW9ZNEFyZGdzeFhHOEJXUUxyUCttcjBZaWF0OWNSSCtM?=
 =?utf-8?B?MDZPZXUzcVRBZUZicEE1S3o3VjFraGkrRnEzYTFpWHhFMHRnRlliUERNeHJn?=
 =?utf-8?B?bmpDTWtLaThYWjVENzBPL1hCa2ovMXlZOURsaHhtVWJZMEdqVmpIeXZlSGVK?=
 =?utf-8?B?WWFISE80M2xEQ3g0T0lIejBPZ3lLUkNJUm1nUi9BY1drNXpwbCtJR2l2WEN1?=
 =?utf-8?B?NU9SQkZhOHZSK1pDVUJUOVhkaUNjZ0VEWDFoSnRnZXp3NmdtRzExZnZiaEt0?=
 =?utf-8?B?LzlML2RPT3I4aTdwQUFFdlZjR0E3OWFMZS9ENnNBdlJPTUQ0K09tbStQNzBk?=
 =?utf-8?B?WlBIcWVYL1F0WWtNL2ZoSGhiYzluQ1J4dGtJRlRHWDBrQTVwaFRWemJHNXI2?=
 =?utf-8?B?a3dsM3RxSDg4MVhuYTYwbWR4OFdGY3hOSDgxQmR6L05JKytpUHkvczhCeXc1?=
 =?utf-8?B?RSticzhSQVVjaGQ5eitmYTFDME0wOXYzQ2pLeDZvWklwTDVOSFdEbSt3MVla?=
 =?utf-8?B?alVUYzJoVWlvRFZFV3V6eXZUbGRJTGhKbXYxQlRtdTlJWDJ4dlpzckdZTURl?=
 =?utf-8?B?WlhoWlVxUWMvZERRNlorc3U4ODRaeDU5WlV6VDlLK2IzU2RHSHZ3QWNDMmlL?=
 =?utf-8?B?VHM0SG15TG9vd1lFTWNDWmExRkVGc2dLRTJXVUcvbGVBMS9aQnc5Q00yRjZ2?=
 =?utf-8?B?SFZqY1l5RDVPOVR2M1kwZE15blcwOVdsYTRoSzhYR21CS0l5d3g4SW5Udk93?=
 =?utf-8?B?ekh3T09SNjNwR29mSng3YW40c2MxalVIaCtTS3FPOG01eTEweFlYRHJpTUV0?=
 =?utf-8?B?M0Q4cURKUlRuelZpVjZSTFVDOUp0WGpEVnNxNlE3Rk5zU2xyS0tJUXZnWDBt?=
 =?utf-8?B?YmRyYTBtZGlPQ1FKR2lWOUNyNkF4VjV2RjIrRjB6bGlZVjZzakV3MWhYVGIz?=
 =?utf-8?B?aWxhaVVXQjBKYVlsK0U4QktKVFRMVzlaam81eWpkM1BsVy9qL0k2c0M0TmY1?=
 =?utf-8?B?MzJNajd2dkRNams5cXJGdTNHV1AzTHY4Vzdic1Q5RU1lNW16QjhrQzQrZWNp?=
 =?utf-8?B?eUx2eTdidStTMTlsaW0zcmFpSmIyTmJuYlVvbDBWeTduNHhJeks1TEtscm1K?=
 =?utf-8?B?K3BXWHdVV1VKT0NhVG1kSUduMjJoRXNlQVg5dDNDamR6LzdTbURhMlpwQXZ0?=
 =?utf-8?B?QlpnTUlGUUthNVpZR0d6MVRucGZMbFczdUlnRW5YUXhWSWd6K1pyNS9RNnJF?=
 =?utf-8?B?MFgyanlsM29lSy85K0ZCTkdkUkkzOVlmeHRvZ1J0bDR3YUNqMG1CSXAzYVNE?=
 =?utf-8?B?SlE5YnorYTJkdGdkVHVzTTFMUDh2VkRJUzRrYWZRR1dhV0hRa2VyVTlzS282?=
 =?utf-8?Q?q5mKZsUiu0Pzu/fR3q2elYVw7?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa7142cd-e896-41e9-7d89-08dc0d122e18
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 10:44:51.4932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2QYSMJrDSzIN6uf/s6qV2JvssjoB56WCBZS6QPTpwHn2JB5Z8lPKeMlYBWUl5ccbfP5m5foPxbhyf6tkvzRNlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8847

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
index 3ea64b22cf0d..a12afc254afa 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -1481,6 +1481,20 @@ static int scmi_common_extended_name_get(const struct scmi_protocol_handle *ph,
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
@@ -1756,6 +1770,7 @@ static void scmi_common_fastchannel_db_ring(struct scmi_fc_db_info *db)
 
 static const struct scmi_proto_helpers_ops helpers_ops = {
 	.extended_name_get = scmi_common_extended_name_get,
+	.get_max_msg_size = scmi_common_get_max_msg_size,
 	.iter_response_init = scmi_iterator_init,
 	.iter_response_run = scmi_iterator_run,
 	.fastchannel_init = scmi_common_fastchannel_init,
diff --git a/drivers/firmware/arm_scmi/protocols.h b/drivers/firmware/arm_scmi/protocols.h
index e683c26f24eb..b5c65f26207b 100644
--- a/drivers/firmware/arm_scmi/protocols.h
+++ b/drivers/firmware/arm_scmi/protocols.h
@@ -254,6 +254,7 @@ struct scmi_fc_info {
  * @fastchannel_init: A common helper used to initialize FC descriptors by
  *		      gathering FC descriptions from the SCMI platform server.
  * @fastchannel_db_ring: A common helper to ring a FC doorbell.
+ * @get_max_msg_size: A common helper to get the maximum message size.
  */
 struct scmi_proto_helpers_ops {
 	int (*extended_name_get)(const struct scmi_protocol_handle *ph,
@@ -270,6 +271,7 @@ struct scmi_proto_helpers_ops {
 				 void __iomem **p_addr,
 				 struct scmi_fc_db_info **p_db);
 	void (*fastchannel_db_ring)(struct scmi_fc_db_info *db);
+	int (*get_max_msg_size)(const struct scmi_protocol_handle *ph);
 };
 
 /**

-- 
2.37.1


