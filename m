Return-Path: <linux-kernel+bounces-18610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 260DD825FFF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 15:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E51A1C2137B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 14:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034AB79FF;
	Sat,  6 Jan 2024 14:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="SGutDUBq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2076.outbound.protection.outlook.com [40.107.247.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835E079EC
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 14:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AN7b1Rf99SmZdklUyuW+eP+zeggkweX4Dx5RR+ntDC0N2g5jF9pk9AkRimD+jhIvCmA0pNlrbbvHMdd1dkkfGpCjIG2ZjvdEAk2abzU0xtG1x2z+/uUHePL8PgHS63rffSvZ3j4xfS0crrI6k6GL62F5PGkHjuLv9V6MkyiLdMw3RNQL9cJ6+4ECK+4VjDkSJd1EE7XcgVxHOlHeHUIfb8lS0Hl/l2hnH1WaAtKJcEWcwnm9SdEU759SiaXvPmNwPn9R6XwJel8/ybuWJxnXodTIeoyVIjgbLH7QV6RYI5UDh2d5GayrkcjMgBT8WYWPkT8rYaKPBjpIiDIvClgjyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2J/ppFX0x3roEZmXCNhC744X5VAT72SLLNjPUe/BnI=;
 b=EwVQ9uPxPliXxrkSk0hCd0PENBSUu/iiaBZIk3r4a/zufT0AWp5LHI8M6+KK2ENJzqFpkn7JTeGlBnCKKoql/a2+t7JrpJPSbeRAJrdTlRaVMkNONP/WagkfDuGiMpQEuNap0yAzIFpaC3tTm8VjQK8xAHAt15GfIHGutoEqV3rbwvVH7yUKV/Kkn/Dk35fwYYtUaDHvnLSL63tFLPUgAIhLl3qG88BzM9FLgYr7FafwlXvsN0VGIU1aI3mZ2hmu1W4/0fdPIoOtu94bpWZ2V7kD37nvCNhFmPzuP/vOuf31ighFxDvpEihHqFlzzUvzRVASVeWPkXmBKFoHBcf1Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2J/ppFX0x3roEZmXCNhC744X5VAT72SLLNjPUe/BnI=;
 b=SGutDUBqST3bMyrATzYwlTnqzwPjkkLvYodbyKP5/DdT9TyvDZavMopkcLZhvjTH0Yl4BmiJ+cEjAxStzwPjue8Lr+vtk88D+Ox5hR1uerExdYhXUfmbS4URXPzBB/fjbqp8MHaa8yPJTjZOJouZu32GFVLTavmK7xcbffFbv5A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by AM7PR04MB7175.eurprd04.prod.outlook.com (2603:10a6:20b:111::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14; Sat, 6 Jan
 2024 14:56:36 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d%6]) with mapi id 15.20.7159.018; Sat, 6 Jan 2024
 14:56:36 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Sat, 06 Jan 2024 15:56:33 +0100
Subject: [PATCH] phy: armada-38x: add mux value for gbe port 0 on serdes 0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240106-fix-a38x-comphy-sd0-gbe0-v1-1-c7fd87272050@solid-run.com>
X-B4-Tracking: v=1; b=H4sIACBqmWUC/x2MSQqAMAwAvyI5G0ir1OUr4sHWqDm40IJUpH+3e
 ByYmRcCe+EAffGC51uCnEcGVRbgtulYGWXODJp0TYoMLhJxqtqI7tyv7cEwE66WCUlb0xrllq6
 pIOeX5+z+62FM6QNStixqagAAAA==
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>
Cc: rmk@armlinux.org.uk, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR3P281CA0199.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::16) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|AM7PR04MB7175:EE_
X-MS-Office365-Filtering-Correlation-Id: b7dc262f-e956-410d-01d7-08dc0ec7ae22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uI3rSuJxjkSmuV/99CCm9ny+TEGEeMezMTUw7Ecc+uEJMYGtFLOpaYrzyTT4rp5HgxSKK5B9L+j6z8505Nf95H7Bk/ft7VHW+98e67zcm+pH5ePKTI6ts5TTqS5VqUqOc0Y5CtvbVg+aHhEQg0gubJ15O+eZOQIY8yGfjPtOy8y33v7esB9YPCf10HAugTmbKFkYC+DR/IBzz+wrjSfHVBRZhsZ/dnVF5J4QQQhRZC1dOFq7bpP1UrBtSYdedFpORTw4cJcAIN/1v3QD8Ox1WcLPqxryEKHo5TUFhMrvaRC5fNgLXEexBeitDnRYBri1tcBzBij++2Kv8qFCWO5orfK9OjQSdF7Wt+40ZciT7tWdTAwiYWujIisw4SSd0aeFIjXWv2bllztZGnI+kEQm1OfJ7RdwWzL9qEtgI1QEQdu5EDMjqt2osgleaJgftb0+hB+higsuSxHDPCt0MIbVJqqGIWuMmf3W2cgixtCA/Skkodj1LqOFECTRdwTJJ+WUuLM6JvbgtxoF3lHMECyxMF50GaDBibSecdzarHbqo4AGK93+UeOJ9gpTidv8bFOyTDyaew0qmdU+XNi1EVT5yq/q3e+bHXdyOcysJEqGuFC9ytJlPEpXXEqprAzqSkOM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(366004)(39830400003)(136003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(107886003)(26005)(38100700002)(41300700001)(8676002)(316002)(110136005)(2906002)(8936002)(6666004)(4326008)(5660300002)(66556008)(52116002)(66946007)(66476007)(6506007)(6486002)(86362001)(478600001)(2616005)(6512007)(38350700005)(83380400001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2tOZ0tDd3czOE9NbzB1bTgrNGs1bkk1MjNJOEJqU0VLYjFLNlNodkRaNWhH?=
 =?utf-8?B?bURPTHFHNU95ZWJIVFZQY2dvOWRQQ3JiZHlVdVJqaU8vVVZUa3AzcXBQSnlW?=
 =?utf-8?B?VEJFdG4yeXFvQzd3aFJEWWxOZXVtQUNTanJvTGNsdUtGdUtEZi9CQ1Z6anpY?=
 =?utf-8?B?WUZJTXZyN3YzNjBkOEhJUFBoR3VRbU4yQXF2MnVkN3J6QzFBZnRGVlRRalQ5?=
 =?utf-8?B?N3duc285L2xMZm9NUDdHY1dKWmt3R2JuOHlpdjc1cU4rTUh0NUZMejc3MnJV?=
 =?utf-8?B?YnJaRDFNNzUwQzF6UHRSNjZUZXBMSFhDM3RkK0NKdjJ1UllJTURWSDlZR2c2?=
 =?utf-8?B?WklJa0VCS0k1aDAvc1NZZmFiSDdiV2F4RFc0Vlg2cEh3R0V4MDdETFVjQ1Iz?=
 =?utf-8?B?NjJVekgzSEpoMHVZYWkrbExQNldmblMzc0ZSOFg2MWtWQVB5bGlmODJVNHA5?=
 =?utf-8?B?MVBHRjkzeTN1aW45WlYvekZGZzZVK3JHQmFhbDFrQXNHK2cwdzFZVXdlTU5F?=
 =?utf-8?B?VDJaRTZJd0RaUUhpUG1uZXpGaUFjenRHbjRIU2xLRzJzWTZVVHBVWDNvYXda?=
 =?utf-8?B?cXpwS1pRbHNnQ1h2Z3EzRnF4aG5nUmlNK29xYXI1K3hUUmszeFFHNEptL3ll?=
 =?utf-8?B?dnZWb0NiNG5scU5KZ25PL1Uxb1l3enU1NzlSTDY4VjZ6Wk5qTWptcGNMQ0dC?=
 =?utf-8?B?TzNaRHNOd1NtSjluek0wTTVMcjhtbW9ZSnRUNE1JRm1EdXI0Sk1Id2ppalNq?=
 =?utf-8?B?K25qdHJTUkZ3dG5mQlgzeEVxUDd5NWIvQ1UzWDUwZDNadWdLbEp3THBtVUJO?=
 =?utf-8?B?dDhrUHc2VEd2UjVLVmN2SEpMVmVSZ1VkNFhkeU1wK0RTQVNEcDAwaFAyV2pw?=
 =?utf-8?B?RVU5Ym5oT0Vua3pUL01CVU9YQW5zTjhRWXE4dk9zRVpKL1V1SEZCOXdnVVk2?=
 =?utf-8?B?cDRJM0lCME5SaUpjcjkyOEwzeTJMa08yeXhqS3VVZ0xmYTN5ZE44bFRyWXlG?=
 =?utf-8?B?ekJvL0syODZNUlJ5WVdXczRFZkMrNUdKaHFCOGxDZ3lYci8wVWhGWHJVTW9v?=
 =?utf-8?B?MkN0VjYrdWt0T29xNWh2QWJBZUc1WTRWRTNXS2pFUkVLQzVEVStiWFF6YnJo?=
 =?utf-8?B?TkJxNjh0UklhT096Y25ydkdNNCtOV1ZHMTNobUdlOFZsYTIySXNadHl4NDBa?=
 =?utf-8?B?Vm1WcFgxaG05WEZUWXlnSExJMXVsRklLNktrU2ZRcjd5K2ZXSjRlUlZhcjRD?=
 =?utf-8?B?Zlo0RVcyL2IyaE9EcVJkSlNZR3BMclJOZ0JjREUrbUx0TXlXQlhycEhzc2xy?=
 =?utf-8?B?U2xmM21Vb2puL2QrbFlDRUI1aW9WeXpmU2cvVG42S3U0VXRyTHdNR252Vkhs?=
 =?utf-8?B?WFZ4QlZDbXpscFJNeGVuNWQ0a1p5QUYyVVd0R3dSUmMrR0kzVTVhckZ2QzBT?=
 =?utf-8?B?Q2dlTXFhQWFmZnNtQVRLdW5MR1BnbFdFdnk1cmhMb1BMd09QOFZ6YmJuL0Mz?=
 =?utf-8?B?Zk4vR2xMVlN0d3puaVB3NmtmdDVBcSsxSFBLbWhydmNPS2p5OXk3SzZZMHpR?=
 =?utf-8?B?Und1ZHJzZVpVeW9nWVlLV1ZVRktmMVE5WjZ6RmJsWk9XbmpCVmZjWE5FZmZs?=
 =?utf-8?B?Nkx6WkEwQTg2a0RzVk1YZmJqeWlkU05IdzRWQmdOS1JEajNkbFg1NVloZDRD?=
 =?utf-8?B?UytwTURob2VwaVdmc2w5T3hoMms4Tko0b042N3pMQ2tDWURQU2k5NDg5aWRj?=
 =?utf-8?B?TVdWR0hhS2V1TTI1SnJwNGdVdS9WN0hMbnRHbVpVV3ZpTVhjTGtRZUFhZUk5?=
 =?utf-8?B?dFAxTUs1eTZ5MU54MHBDcS9WVmtDNlRpMlBuRzNMbDJFdVB3REVmenM1YUJB?=
 =?utf-8?B?ZWJPdU5oMXRNNVZxT0t1YlBkUVFOeXgvRmtza1c2a20rZE03dnNjejlZREY1?=
 =?utf-8?B?NVNVTkF0a3UvK0tNampzRDRwSmhtTkxkRU9GV2UzOTNiVk8rc3JBUlZaNFp3?=
 =?utf-8?B?cE1PanY3TDkxa0JmQnVzSkVRbngrZGZqdlpEZHQydmowL0VGSHhJSm1oTVNl?=
 =?utf-8?B?TmhRWW5BeENlcE9DaHFrbStyVWFEajViRWxQZXVKWXZ4YXd6SFJwVk5SUEgw?=
 =?utf-8?Q?DEdsxAO+o1sDVJN0nmRutm4S0?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7dc262f-e956-410d-01d7-08dc0ec7ae22
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2024 14:56:36.4376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aIlakZv0ukjiCKAGxOzJZnvhumcm7yNEKqJM5kHR7n2BqsS705tjrksRFU1LZAizlrMnioadyHPuBZ81DNJEpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7175

Armada 38x supports 3 functions on serdes #0:
- pcie port 0
- sata port 0
- gbe port 0

Add missing entry for gbe port 0 on serdes 0 to the gbe_mux array.

Because this array looks obscure to new readers, also add a comment
explaining the meaning of rows, columns and values.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 drivers/phy/marvell/phy-armada38x-comphy.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/marvell/phy-armada38x-comphy.c b/drivers/phy/marvell/phy-armada38x-comphy.c
index b7d99861526a..d3259984ee8e 100644
--- a/drivers/phy/marvell/phy-armada38x-comphy.c
+++ b/drivers/phy/marvell/phy-armada38x-comphy.c
@@ -47,8 +47,13 @@ struct a38x_comphy {
 	struct a38x_comphy_lane lane[MAX_A38X_COMPHY];
 };
 
+/*
+ * Map serdes lanes and gbe ports to serdes mux configuration values:
+ * row index = serdes lane,
+ * column index = gbe port number.
+ */
 static const u8 gbe_mux[MAX_A38X_COMPHY][MAX_A38X_PORTS] = {
-	{ 0, 0, 0 },
+	{ 3, 0, 0 },
 	{ 4, 5, 0 },
 	{ 0, 4, 0 },
 	{ 0, 0, 4 },

---
base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
change-id: 20240106-fix-a38x-comphy-sd0-gbe0-02b6861cf973

Sincerely,
-- 
Josua Mayer <josua@solid-run.com>


