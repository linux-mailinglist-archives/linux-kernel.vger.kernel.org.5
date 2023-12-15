Return-Path: <linux-kernel+bounces-874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3502814756
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D78741C20B7D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D0A28E15;
	Fri, 15 Dec 2023 11:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="K59q91KX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2077.outbound.protection.outlook.com [40.107.104.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289CB25567;
	Fri, 15 Dec 2023 11:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+e+fMQ0oPEHlHSxhEGeZPw+q/r2dGEkaKcg1lOr/y8x4zLOqPCVM8huOmHyguirKvVT9Fbz4HaEeNvLIjmbsKqXvivNBfK5GYFh42KlhQhAphw44dpwYIjbKDtYgMuryhKPtuGpa74qSpKPRA/yIH/1OowH5qez8YrHCfb6NuKU7t1EboDzU7lJUJ/C078ioC+3nrvz6YZEFoBvH3p9OPCFtYBJ+3aCyUGDCkFDcSkyTk2C01B9jaQXZoRXshFP54rrRd0l101yMZOn6FctJorOgphEgaMzE5cU5mBWSpPymn7hfkPMOK8icz44cPt/djwDtaGqNt80/tvw3n+VGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cCEamUi09ubpPY5s7jSHmF6ugaLgEH+EYKTxHeEJHsU=;
 b=Od/pdyMNTkzhiM3NCZFegdPrcV0/h3OqWbrbvBgDoMZgUO4d1ff1cA9ZiMPo0rFLBISelnG01xaBh9pjl1ALTJ64lhWLl5jmgqakQvbQ4wORctVIlAZeL5pkq7YC1LrgOrl3CCLtnO4sVwqNCk3zOTw+1HDHO3Y/pGyUVlP9fpCCeCVZtVsJeCaWDVPIgLrysYkY44nkSsYj+qiNwiT3nN08e32BMHjQZEdU0J1KsTFoEUP/UwtaRuZj9sq33bQ5hVQxHfn+iI9P3Hh70SlX8zSv2HDsxGRudFH5H91ynGfigd5lhkcOZwW2KdE9DTqFXqquu3oh72603+fjXrLmAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cCEamUi09ubpPY5s7jSHmF6ugaLgEH+EYKTxHeEJHsU=;
 b=K59q91KXlZQEf0ayK2P7ZeTlaoRk66kQ8w/DNcQ7U+TJAaPq/vplNK400JLeQD4bIqXX+hM2NTQHXuj3KbU/T+FMs93CJRtLWEo7z+JqnKWNQwfm522ujxftQ0IjaW9qpv3A7hFqVqHcYrcZ3fJzgJAyMgzSyOffwcbyR8eOam8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PR3PR04MB7435.eurprd04.prod.outlook.com (2603:10a6:102:88::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 11:52:17 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ff06:bbb2:c068:5fb3]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ff06:bbb2:c068:5fb3%7]) with mapi id 15.20.7046.015; Fri, 15 Dec 2023
 11:52:17 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 15 Dec 2023 19:56:29 +0800
Subject: [PATCH 1/7] firmware: arm_scmi: introduce helper get_max_msg_size
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231215-pinctrl-scmi-v1-1-0fe35e4611f7@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702641405; l=2166;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=68MbFg0oH740yCUj6NB45LS/NxU8ZebVwrXvl332/EQ=;
 b=rrzskCAyMB+F8eM/6WfbpA2eOAllulGxE/g/2vAyu4TpqHXYsVVA+ocBmH7A3gRgTJdiwg5vQ
 vCzmSpydIZ+Cen7mdbubch4pj6n25eF4f6zdvHaTfX3YnzRZBfyf0yC
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
X-MS-Office365-Filtering-Correlation-Id: 8356d424-362d-439c-ff48-08dbfd644919
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HDYo9SIkxS+D3SgYHfWTsCXEK2Nr1aw/b1HNCjaZRaW99l/wErg61a98T+Gte7/0ojHIzLDt6gnTqP9nvhE/J9mEwExDwAa5U57VO7sG89zHKg+mQ8UbnUY4R4OzrlSgotfCt7PWMUBHZqgrXpJgNCWnTrWMfRYBYdrhTu5g4vDyXhQmzvjXw3PE3jPqfbiU5wkvaZtx5Xi4dvEAF9/kTUYV2xoDBnMuYzT+zfsSwcizgXe56It6W9GxoLmwi4Zrcq27iEJum8JqRFMO5dT71fjiFnuNG8lgooPW+uLSXeckRwQoUlcxt/AHcbGJdCB+T/DO54B/vd7bzRIsO0YoD/FAIOqkVYGGdY+Ot7JsFDwJJ0L3Em8WaKm2b87YJP/5dHrZfprx+zVKELsPkTza4OoufL3Zp9f3BZ4Kxz+/gEh0Uvy8GhONzBlZy68jMXzjKwUayhMhyzk3csG2MVm/tyzHEWCintlUT6c+tFVckOiVGJ7GYJOLFhdPemstzXjaOXFNxPQMxdxau6vU9JyBTJHaSbBLXDT2ZdHUGlIaY8bIfnOpizArl+oDFAlPAtD5toTdijwmT4ZvS1aTzM3OaQ5HabpksDoAeRd7yV2oCTLvaWPiGzGELi39it/1QTPZi+WK7lXM5u/dYII4cN/uhw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(366004)(396003)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(2906002)(86362001)(4326008)(8676002)(8936002)(5660300002)(7416002)(921008)(38350700005)(41300700001)(36756003)(478600001)(6486002)(83380400001)(26005)(6512007)(9686003)(6666004)(52116002)(6506007)(110136005)(66946007)(38100700002)(66556008)(66476007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3JMUVBPWW1uZUUvcTFkdlIyd3ZDd0ZFRG9ibUdVMUdqb3JCQ3JnOE1xUG5U?=
 =?utf-8?B?RlVYRGJGeDg3SUpMM1VMbzUwYUtwQjVTeGdpU25oTlBZaS9tdzlPQkYzVEF2?=
 =?utf-8?B?UndvSzE0SHRmZ2dxelBCVG0rRlBmOHlscXA4c0k4RFRuYWF0cUJkRjY0bzBX?=
 =?utf-8?B?UmNTUGtZTTBzRXlXRGczcGRqbHBpNHd0TDB1YjYwMDhxamQwVThZcU1jUFdX?=
 =?utf-8?B?c1FTSzZtNWxYdmJya1MxVTJxeFVnMUNWY2YzdTk0aFp0YUtyUW1pWHBObm9P?=
 =?utf-8?B?QVp0VGZXN1htWCtJdm5wcjRuOXowRUdoa1FJWngxY3k3d05tMFE3aDdwblEy?=
 =?utf-8?B?eVJMWFFnVFlnd0w3enB6T1R1Q3F2RlovNGFUVFgrbk1wcHNzUFprQm9ZVVhL?=
 =?utf-8?B?UDNxWmxyVFZ3cThYZHk1bHhodmpNSzF0RWVqd3pTNEhTMEhib0IxR3FySllr?=
 =?utf-8?B?K1VhUUdJTzNKaFNXR2ZVaXhvWGYxYjVrdVhGVkVGQ3JTazc5SDZFcWZSYXY4?=
 =?utf-8?B?OW9EWVJmajY5N0JUWERRRUo1ekZJLy93TWcwcHhkUnhNR2RGMHk1b2dYdTlY?=
 =?utf-8?B?SzluM2kvZWgybDZtQ2NkdFNTcnZocHQ5U0xRdWFZT1EreGl5RjFqZWs1MWhR?=
 =?utf-8?B?cVhyZWxlODBTbHdNMVE2T2tIOXJzSE1Td0NzTi9yK0xwYVQ1MTdoalNoUGdF?=
 =?utf-8?B?WHFuVGhibGd6WkRLQ2NYdi8xNjVkNkxmMFBNRjJSTC84Qk95WTI0bk14QktY?=
 =?utf-8?B?MElBSnNaSU1sUkNseE04cEQ3Wm82aVRWSTlGOHZXUkxDTHRiZ1B1TGxob29M?=
 =?utf-8?B?Rk9tb1pCL2dPWDBmNktRaDY1V1EwY0dJZS83VEI4cCtLVGFZK0JNbitNUkpO?=
 =?utf-8?B?a205VWwrMFRrb2dRb3IzN2ZkVDdoRzBhY1pTU2lRdG5ua21icks3Ryt6TFNy?=
 =?utf-8?B?RTVWcUdGbUh4L1NhazhRcERucXEzYXlSVW81YUdNWVloV2t5ZGlSTjdQMW5z?=
 =?utf-8?B?Rk91eHljNWgyMUNoQk9vL25Gck9mZDNjZElhMnorMExiOTVkQ2lTTWJaVk4r?=
 =?utf-8?B?OC9SUjNhTVVZUFV1eHNOa2pyQVhKcVR0UHVkY1hObGZldkpWUHFkNm9JeFJj?=
 =?utf-8?B?ZmRCQ1drQjNOVHVaRzdESUkraWJHbXJiMS8wK2NiYmZmVWRpOStIQjJWSWtx?=
 =?utf-8?B?M2NGdS9QQkhZZXRBSjhReSt2TFEzUjJkWWJoSEFRb0NoaDVKQkFwTGFUUlM5?=
 =?utf-8?B?RzRzV2psK3J4MThVMmMzbHdiTVR3VnRhUk03VElYV09BRVpQdU1oWEgrZkdE?=
 =?utf-8?B?NmJDVFFvUE5iRkVvcXN4V1BQZUV1T01XZ1JzTUZ0UUxPTWI3R21JVXR1UFAy?=
 =?utf-8?B?Z3FTSXlTc2ZmVS9Wb3NCQmxoTVRWVnhFUzVnMkM5OTdhTTVSZ3M0MWRoV001?=
 =?utf-8?B?QjlqcFk4cS83eFcrNDM0OWJpVk9QbjdURTYvWm90RVMzMDQvSjVtRFBWS2xW?=
 =?utf-8?B?d29wWWlqZFZaVmR4bjJLVjBWM0hlWkxETXNSUnBZVEJ4cmJOSXhOYTdCblRM?=
 =?utf-8?B?dkJUb3hJelVYSWh3Q1d6bEJSYTB1Rm9HRHZSeUFEL3hBdERpOXZoS3J2NWp2?=
 =?utf-8?B?amVsdFJtUEw5eHdLRTBjL3ZHZzJtRzZKYXNiS3kwRWFVU2JUVkttZDFmTkUv?=
 =?utf-8?B?eHpDY09vTGM1RTREYnJUMDVZUVR2akdZUXR1VlN5c0JORFZyUlhVanFmZlEx?=
 =?utf-8?B?U0RvbGk5V21na2VWbE4rcXZ4R0RMMWlsL1hPZTZQOVFldGxUK1ZqakJiQ1ZM?=
 =?utf-8?B?TTZkZE5LSTk0QkVoSmVRd1NxbnF1ZWRKM2h4VWxvNGxnY1dTb1Z0SG0wMHFv?=
 =?utf-8?B?bVY3UDRhOHk0Q0tJbGNqR3BzeWxtRjZ4aHYxSE80V2ZFckVZWVd4Qk5JZy9y?=
 =?utf-8?B?Tm40aVNRRDJZQ05xWHJNb2srdHJBR052S280dDVtR1NiOStiOHNvSXVrUHdB?=
 =?utf-8?B?dnd0NnZlNWQ1MjBRZkVhZnNvSSsxTjVaL0xBVmdhWXJTa3RtSklYaDJYNDFS?=
 =?utf-8?B?V0ZFYXo4NnN0akNZTXU0NWJGLzIwT09adkttKzNXaitqYmJXZ2JFV0czQWZt?=
 =?utf-8?Q?gHU3KPIdF5GWgHcqCWyUa636U?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8356d424-362d-439c-ff48-08dbfd644919
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 11:52:16.9765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l0+k/JnbLpTsUToWa1KuQqFFPNKwpmjGdyBab4nZa7ETXV9kNf05HE0iVwPx12l8Sh6Z4PtOoobx5kbZpsLo6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7435

From: Peng Fan <peng.fan@nxp.com>

When Agent sending data to SCMI server, the Agent driver could check
the size to avoid protocol buffer overflow. So introduce the helper
get_max_msg_size.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/arm_scmi/driver.c    | 15 +++++++++++++++
 drivers/firmware/arm_scmi/protocols.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index a9f70e6e58ac..b4f8f190351b 100644
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
index e683c26f24eb..08de8dc064c1 100644
--- a/drivers/firmware/arm_scmi/protocols.h
+++ b/drivers/firmware/arm_scmi/protocols.h
@@ -270,6 +270,7 @@ struct scmi_proto_helpers_ops {
 				 void __iomem **p_addr,
 				 struct scmi_fc_db_info **p_db);
 	void (*fastchannel_db_ring)(struct scmi_fc_db_info *db);
+	int (*get_max_msg_size)(const struct scmi_protocol_handle *ph);
 };
 
 /**

-- 
2.37.1


