Return-Path: <linux-kernel+bounces-876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CD081475E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C55CFB22AD7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9299B2D78D;
	Fri, 15 Dec 2023 11:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="OZg2jsXi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2065.outbound.protection.outlook.com [40.107.104.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7662D61E;
	Fri, 15 Dec 2023 11:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iQUkcpncIJaTS7w9Z4OqbGSYYLgjFNp0h8KS8KdEvKiAZLf1JlMB0oEKo8qPMxhEyMI13/iKRObitdK15uEAN/o675xyfTZvJcu1np4jeHkJAEhUfOSe1Qr1JBzHZoQGmallAcq3f1XMUTKs4EhEKcevxDkJAAz6Au84aljuZfQQLEKaPrOtS+ytqdtA6/bms2sN02jwxzBJPqWrJoyH3EmU59BGDpHDRjfAp/NKvr6pcxI5Ke/XdZT/0+PdgnUNMkMrV1LhlUUH4yagE+WaOoyZ5MVdpyEAKIKtnyaFpb1/lsbGijuQufhWlul8rb8qVXLZeIcAmKMCVieEYAINNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CCB9GqT9L+fZJ0Zywsd9Jf44DP6UKAAsJwON0p3ppcA=;
 b=Ho718PEzie6tNYBFESjJuwVYu/OXKSarM/WapXiyBznTverfIu+S2Ul5fv/or29h15uKj3srbCxWAw5+659fbXC0AjiGismHcV6AwGDC+LzX4wt4RhOLODz8ByZ3EUo00vgiiXxyU0EofLRQSyfzKxEh+B4WELZodjhTPIVyBBTdSNjp21aAc+U1zpW31TL4itNU46DTsFHdR8mkFVpKXEv7k1VhHR5Y0+LaFxtnbUmgDjOSofjpmP//r5b9oQyrbQT8+MITg7iXdFiVcxAvj+mafTH/Tf/QOGCvYsFFSSZquAkQJGYjVHBDsFK9q+KgoShFmKYVIWrdBoE+Fv0IrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CCB9GqT9L+fZJ0Zywsd9Jf44DP6UKAAsJwON0p3ppcA=;
 b=OZg2jsXiPLOKUrWBz3ECSl/HXg6bEwIyJ7IO3ePgiMn9WlVU+KbweJs6+tAmxbwEFDvyD1yOMmn5wJjxLjvUnnYCbb75WVYkyXNSV3NQWujDf2r3BgmsddQCaUfuynjXOD+P2Vw/QPk2tTAUu+9hN0fZOatYSq7ZKSlVotvo4Ls=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PR3PR04MB7435.eurprd04.prod.outlook.com (2603:10a6:102:88::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 11:52:27 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ff06:bbb2:c068:5fb3]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ff06:bbb2:c068:5fb3%7]) with mapi id 15.20.7046.015; Fri, 15 Dec 2023
 11:52:27 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 15 Dec 2023 19:56:31 +0800
Subject: [PATCH 3/7] firmware: arm_scmi: bus: iterate the id_table
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231215-pinctrl-scmi-v1-3-0fe35e4611f7@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702641405; l=1116;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=FRGxInB0b3KsSvsP0EAYnn4A4HfxHZyqmybMfTc2pqo=;
 b=08yi4PqS38l04uzUotv/HklHNJ5aXPKqCbaoSd3nOAZP9IaUiSURvnfL3v1k40inaoR86gsw8
 Z63wwtifZ+7CfUStb0X39byjCJ8/T08jQ2/SM16XAijV2fvTpkC4I82
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
X-MS-Office365-Filtering-Correlation-Id: b64403a2-b8a8-480d-0f46-08dbfd644f17
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8/t5kQU3wGa38FmqBSI2rgRSEdF+zXACu7e9O4a0q6wAhCu32pMyk23hAIxgZX6smVtYuHqVUsyCD4wUy82gKZ2UOs/2oqq+H7EemAHTwNAgtrds734K3p3DZyTRGEqj78JKhccYMrYgsz/vSTM0OWdXSD8lAjmkJcE20sUcdzDoInPtP1X7ew80NT3FL827n1fBhxF2p2Yn8mLOgG6U8uEpWerR4J82BeGKy1hw2dZvNQuVbftWDEX44aGfYTLvS6yq12UxJPXumy7JHcYd0PJT/kRZxOEX2AkZ5O+vouig0vILEM0W1sKwXYDeq1OsIExC9E/YSWyO2jdyIDqhaIvI3URreBEsjG2GHzd52WapepC81XoW2pEa2kS70FMMV8iqqsDPV4zFrFFfrIf+9zIHWxHOstYTo3lTC2I/Yz4saTFWimSvLKmOX3x+tEnUYvkNlDgXdYMJscUe+atjj41FxWjuewDHCPoIwi9P5sfub+PZzcZpZVo1SYZI9y2h3sMGd+of5kylWPpaoIWdzSg4Axezmt5Qmqz+Gh5owWC17YyFcNZ2DvwmJCdjzPsd+RZFSJ8NzXLK/CFXc4ZzBoA5Al+bZW0pkujUAtIxb/mJcmooH514n8RTQwobHfT2VsBfV10TmG5p7n+5247gfw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(366004)(396003)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(2906002)(86362001)(4326008)(8676002)(8936002)(5660300002)(7416002)(921008)(38350700005)(41300700001)(36756003)(478600001)(6486002)(83380400001)(26005)(6512007)(9686003)(6666004)(52116002)(6506007)(110136005)(66946007)(38100700002)(66556008)(66476007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFRwL0NLQlM3eTBkaEtINHI5NTNkeDR4bC9GRVdnM3hGY3U0d2Jsc0ZRWVJh?=
 =?utf-8?B?ZjVmeVBISmFwRVhVVGZKaC9oNXpEZGFoTGhqL3pQZ1JWNTFhc0VrRHNSNlFt?=
 =?utf-8?B?czJrVHRiZFhVZmJCQTIwQzRpemYzdTkzaDhZTWpEbkF5akRvTkJZalYvNGdj?=
 =?utf-8?B?cXpUL0h5eGtOY3oxcWpBL0g5OWhCYlZBNFIvdEdXZ1VZR3NnZ2sxcHlvaWpN?=
 =?utf-8?B?UGQ5d0NlYWRIVmtqYkwvUnBELzBhc0pHcUxVcGIzWVFOM2cxL2dRMWl4UzJC?=
 =?utf-8?B?R1RuNXJXZHFyTmpaak1KNW5GQXk4ZVQzSmQ4ODQ2dEZBY0Rpc0ExOVFJYWNI?=
 =?utf-8?B?eE5CZlY3dWdPTndFTkNISHFVRW9lalhmbllRaGU1MUxEOVpxaVF4U0x6VWZ2?=
 =?utf-8?B?MC9KRUd3ZEtnNHJGUTRRMXIrekVwUC9GcWpHenVxbzhRblEzT0RWVUdJaXBH?=
 =?utf-8?B?UjFUdTh2bU1RSDREYmpSS25VbUhqTE5IZXBxaHc5blJpUUliTkZ2MHZLakZi?=
 =?utf-8?B?TEJnUjJWdGNBRVhJTXYvaG5tZk9rcklUODZMS1U0QWlKamhrcENxVGtnMHlU?=
 =?utf-8?B?cHpIZnZueTh3bkx5QWdrT3FjYVNIemkvQUV4MXdVV1Q0MlZmNHhNR0VpVmVB?=
 =?utf-8?B?UzFSQjlOQ2M2SUdua0g0K011dURCMlRpem9aRUttbytRN1FxVGFKSWhOUlpV?=
 =?utf-8?B?VGx6a205dk9NWDVJbmFMVWxYSlFLVW5QWU1wL0JGUHVXR1dBbVdrZmFSQ1FL?=
 =?utf-8?B?OXRSd2RFbk0vM2lBbkdKS2VGT3M4VEFVRTVVWm1iSHpVak1WWWdKYVRacE5Y?=
 =?utf-8?B?ei9UakExQUhJem1EYk9BRVJOSjUwYlRVaGV5WFE3d3dqN1NwT2hVSzVlWXVz?=
 =?utf-8?B?dHRNNXJEek9hdU9VRHB3VlZYQTEycDFuSkxUYVBSTlpZTVFGeE93bVQ1M3dI?=
 =?utf-8?B?MFEwb1A0VUdaY1Z2QnNaZFhjM0EzbUlnVkFodEJRTWM3MHMrS0VHTDJWdVl0?=
 =?utf-8?B?b3A1N3kyTnlIdVdEM1FhT1QzcFU5Yk1JVlZmSzhLUnhYSEtUMGh2Q3hNd0NB?=
 =?utf-8?B?S2dyZ3NKNm5Lay9EM05DN3F4Nm5UUG5SOFl2T1Q4c3hka0NOeFZpK0ZLRkxJ?=
 =?utf-8?B?dlc0b3BneHFSNWIxNFBBZFFEQVZUZm42bjc1SVNKZzFIeEJPUVQ3bTNZSk5I?=
 =?utf-8?B?SnFOQ3UwSWpvTk1yNlU1aFVscithQ1BvRlNoVjc3RWxXb3pSYm9JQXNoUnZZ?=
 =?utf-8?B?UERsMnBwODF3SkZZWDcrZGNuV05Sc2ZFRWUvbnRDQjRUVG9zMitqVEcvY1VE?=
 =?utf-8?B?bFRDak5xYUg5R1FtaHFteGp3TTFQaXRuUkhJdFl1QWZjdWt0U2FKekY0MHJX?=
 =?utf-8?B?cmRUZDhMdXByekdIZTVCZVlvd1hObTkwMFZvQkFNeGs0MnBleitDRm95MGRO?=
 =?utf-8?B?TjBFeWkxN1pTNlp3TFZpWXpNd3hJa3RVR0s1dVJXeGJNZFRablNqTmcxdWNH?=
 =?utf-8?B?QVdpR3U2YWtLaHNxNDNDUzc2TWlTNVYvbmlVMmZ5WVdaWmxPdjE5eG5NMm1l?=
 =?utf-8?B?SkV6UWNrM3ViWXNraTYrSEpSWEJLU0RSc204VHVaK3lqOUpuSEwwVCtoUGQ4?=
 =?utf-8?B?bTZWdjJSWkhJYkY5ajVLekNaT1Mwa1IyVG56VjVYWVZId2JRd3VGNHAvSmVV?=
 =?utf-8?B?UWNIdzN4K05zQjBsdnlqT1ZUSTlWVzZVRFdQTk52TXY5aDlrVTJiZm5xMmhF?=
 =?utf-8?B?enZtTU5SaGFHdW9INy9GM0hXdU1UYzdSY1ZDcFhYRGQ0ODBEaC9WWUNxT01F?=
 =?utf-8?B?SWUxZktVdXQ0djk2L1RoTm82bUIwcGZCNTc0SDJ5MmpwMGVJSmVISlZ1Ti90?=
 =?utf-8?B?OU41bkZ2amxXMXB1RkFsR2dWbXdoNlpCUENmVWVNZm5QTDl3Mk1lVndBRHlF?=
 =?utf-8?B?UkNkditSajBNU0JKQjlHSi9QY2tYZnc1SHdOZ3pGSFNEcjJtSEM4UEM0bDhF?=
 =?utf-8?B?RTNYU0craW9xYkJSR244ejFGeStWZUhWSkErMDZIbFVvL3VwTWRnZ2tYd005?=
 =?utf-8?B?bEZCdE9sMGl4T0tKNDYwUDNxUFE2T25adURBcGcwTWV5Z2xxNlMrNFRGaFdV?=
 =?utf-8?Q?DbWB4lRvrH/hiefuG3+jtzvxG?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b64403a2-b8a8-480d-0f46-08dbfd644f17
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 11:52:27.0020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kp8AQTttAWOcsAcXXK9czwgED3CudeWUr4nhsDE7BxCjl+lRETPlU2aLnYld1cQMv3zpsaMCsDVOjMNjyUx59Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7435

From: Peng Fan <peng.fan@nxp.com>

There maybe more entries in driver->id_table, just like platform
driver of_match_table. So iterate the id_table, not only use the 1st
entry.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/arm_scmi/bus.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
index c999edd18cd3..aeb7da841b9d 100644
--- a/drivers/firmware/arm_scmi/bus.c
+++ b/drivers/firmware/arm_scmi/bus.c
@@ -282,14 +282,18 @@ EXPORT_SYMBOL_GPL(scmi_bus_type);
 int scmi_driver_register(struct scmi_driver *driver, struct module *owner,
 			 const char *mod_name)
 {
+	const struct scmi_device_id *id_table = driver->id_table;
 	int retval;
 
 	if (!driver->probe)
 		return -EINVAL;
 
-	retval = scmi_protocol_device_request(driver->id_table);
-	if (retval)
-		return retval;
+	while (id_table->name) {
+		retval = scmi_protocol_device_request(id_table);
+		if (retval)
+			return retval;
+		id_table++;
+	}
 
 	driver->driver.bus = &scmi_bus_type;
 	driver->driver.name = driver->name;

-- 
2.37.1


