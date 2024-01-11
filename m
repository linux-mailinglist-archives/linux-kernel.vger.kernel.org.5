Return-Path: <linux-kernel+bounces-23567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2402D82AE7C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B244284047
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5FA156FD;
	Thu, 11 Jan 2024 12:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IHesj43X"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2084.outbound.protection.outlook.com [40.107.21.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B3B15AC0;
	Thu, 11 Jan 2024 12:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fu11iy7oXTVgnuowQac0mZ1fJb1KW5Mnrne7eP+Hu/42/CpGNImVkza71IUQyOhFul6SWVNnAFZGChDUACCK94oYoHYPzkNSgC+QWTMA23JB273RB62rk8IvbYuQss/hZOiKEt1mKEQKHjwhfOAkQvUaLlJlbbTe8jHiEFzvNrx8g284hlbTOEQTu1leV8cNUD1xoYv77TZrG/sQbI2kpOeLmKSgEfTt8GZQ+SZE8mYKKmRzeDV9ZPgz6e33q8/b70jAj9JQSO49myARQb9REd8EOxycx/OqmQlwGVPy6I0zk/8gZdQbpTMW0oOMXUK/C03yvpRIJ3fLHtj7B1TdMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G/nWN7XPM8jgUPBcCZtG5OmYiBD48zD2gTuvoHsdoGs=;
 b=RhGt5VmagH6NJ4SesO9EMlVY/u5/+p4PVrWKSKl+2TMRTbp3X9IzQYVln9KxFX00yM+rgg8Hi9wfAQAYGGtFA0ba5OVq13A1kHqRO2OU7lB6vXnQC90Z8EOmN31GxNRdYm/WznvA9Sow1AYsDFuvukA6a0PSGNuRhJ11t9s+B7Ggssve/2PpbBjejqE/TM6hYWtPnzXxCHY8URtFHMpQBKkX9/WBBHIVBC7Hbgo9eV0zH9Vww/yRtar0gq0nrEL5yUK2mGhYBGB6seO2APc1b3IkD5X+595sthQo0dfbCQlrWEs6Dwah4UlxkTASVoYMmbtucWFQLCOOIgT8TJtNSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/nWN7XPM8jgUPBcCZtG5OmYiBD48zD2gTuvoHsdoGs=;
 b=IHesj43XdIlT03asgjs03HAfxyxJbUH0KrFoMhSWRsoHykJqoyOwMaSHUgFNaq5kJrZQH6HYX2RDO4LA7/SC64I9IkVROkFW7OhPKMJlZ8qtPBgph3qWuQdr5OGPZURD1xs3pi4wSFIznMpkrtAkI0RiyFEI/gVJEzx85E9AJ0U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by PAXPR04MB8407.eurprd04.prod.outlook.com (2603:10a6:102:1c7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Thu, 11 Jan
 2024 12:11:33 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::748a:98f4:59fa:f206]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::748a:98f4:59fa:f206%7]) with mapi id 15.20.7181.015; Thu, 11 Jan 2024
 12:11:33 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com
Cc: amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sherry.sun@nxp.com,
	rohit.fule@nxp.com
Subject: [PATCH v2] Bluetooth: btnxpuart: Enable Power Save feature on startup
Date: Thu, 11 Jan 2024 15:41:35 +0530
Message-Id: <20240111101135.272065-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P193CA0021.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::26) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|PAXPR04MB8407:EE_
X-MS-Office365-Filtering-Correlation-Id: 307db95e-350b-4339-05d2-08dc129e7357
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZE7fkIlvMIzPi5IW2gCd9z+9RI0AYb59ADjKaXUzmwLmI0sAqZE3XET7wQMSB8AFXuYeTH6XpKdOXZFCc6fEvn+/zRtg9afhCRMfio4Uf2bvZaeVnQ90lAdCebF3JttKbI8Ae84e+vTpUafCJmJNfvg8XOfFckT/o+Fff8vvAi/Ir5plOJYYZ2wVNEC5cwHKAojZKq5rhlnVxXANYQI+WihcNDQ3iWCXwhxlUl6aqZ34aLiiL4aum9PW7pW+Z9nz5jlULhTM1qa7Y9wBa7BghpN2xomVAnPx6iZI/JyuLnoAXNfdvnuSpaVCMRMt0+QxNHMJj4KROD/WS8Kt2bF73XPD73y9Fq2RShOYiOtqLT990C9F21u9HUH0KyvLovntoNLhPAKlO7HgiaGvi3uk4nE4IkXBR+wkPmOXLB17wqmKqzzC+KkNK6eHjvYGxbdkqltoNxJ1D+XgSlMq/uR6FdlkGT73jXcD3r2S4p3Plq/CtGg6HXYRzBiW9KZmlfujZhz0oD/9jiqs+1OOX+7UTS1OTJvuciK82NxB+36Pt1z3424SZKa1rFFhrp0t4nH4u3W60YK14F7IZ2d3xvkS9DxbhInDbTsGBty13PCMyuCNnwDWr2TKq0ufbG7rytBG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(39860400002)(346002)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(36756003)(4326008)(5660300002)(1076003)(26005)(2616005)(8936002)(8676002)(41300700001)(2906002)(478600001)(86362001)(38100700002)(6486002)(6506007)(6512007)(316002)(66476007)(66556008)(66946007)(38350700005)(83380400001)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0gkgG/cY6RIti7IbCj//FNCMNNxkb+8z8GSMlq2ocxU5kntQ4CSwKaOSzWQp?=
 =?us-ascii?Q?YD2JJBWtJ9Td8SkU1ufb8wtip5ENnQPrXyUUokOVPJqnmRz7LTp3H49yPKRq?=
 =?us-ascii?Q?imvl++3AK37Ia9ZNZ0qpPMlR5WUANHJTyDXR3ZvveVauiaepH1rCnx4wUWUv?=
 =?us-ascii?Q?fJGf1NFD9b8xInfp+W2v2DVWzACddyvjog+zEb0fSoJk9pBJXKI6a+3R7LYi?=
 =?us-ascii?Q?xS4Fq+rM8huCHt6hYHQp+reaoWS+rJtsbZTaJ+ajzbDvJxEHWiWPMlEtk42Q?=
 =?us-ascii?Q?GUw2diK37QR6gRXLCOyScgPFsrQLbeiXhJEDPWGJ+gRm1dVKtnheMEH+vN1t?=
 =?us-ascii?Q?qzL+1s/iG3GgDw4uTpzdqlUs3/80O6y9uB9+TlurIQZhrd7khxpSU0At+Huc?=
 =?us-ascii?Q?Wbq3lfWIlz+cTTt8es9n7RHpEvbnRmzmE2e/J+UaZYHuZVGVJ88NIV1BBI0N?=
 =?us-ascii?Q?9LpRmyGIqDdHgQOs/sWdFDFDGG4TqYWoDNvlqflxsKg4jg0DJt+HYByHvGA3?=
 =?us-ascii?Q?hAF30ONNcW/bVECoM73stWIox2pC24FXrO24MdN+PP0/WAwEJKGt6zOrVjW7?=
 =?us-ascii?Q?u0QlHRyQNEp5mHgOGPp/Y/65q2DD9b79GZrAEtpj6mprOBKPMKsO8OF2E/pp?=
 =?us-ascii?Q?EoPMeBO//avyhSSbYB/ZkiKpRCurvUCUQaQpIhrEL/SkZlW+iyRHlXOpQFJV?=
 =?us-ascii?Q?DqmJcgBQlbM05VhBWVmfcyCg9pYgWK2ayxZL69cwI9PdpKlO0YLVeeyfrFD6?=
 =?us-ascii?Q?tVrFKCJJnvl1QkO3bVMqB+LPRYx3NKJTkRecdXWbFIqjzZWDuEjjy57QDOe8?=
 =?us-ascii?Q?bpmUvq2FqsMHqwBiCq+CV8oyhVs3nLkX/MX7Vu5HZo4PiZBYqLDT1TB/T9pq?=
 =?us-ascii?Q?PB/JgvMoFoBrEfP4D/QAOAqenMecY22qrRFxq60xBOXSpWGdpmKdgkErreo3?=
 =?us-ascii?Q?lKqCaDN8d6Vc+/JxtqEkPj6L+VNN3Bkpdsii2wXD2MnSkpn4v+j+TSw1ze8v?=
 =?us-ascii?Q?jtbKBPeI0xASN3zX0zkiE4Lra5yqjfaSF6qbvnhWWayvnljvefkLbyBfUfJM?=
 =?us-ascii?Q?ccP9optBe1UXisIoMVbOnjzbd0qeR8N8rLdcLkpmBkMp7z5LGy0H/XBJpBiL?=
 =?us-ascii?Q?Q4ndnSe0srci8ZsitRGwlxlGuuUFgud2EU7dCG5939ulkIEf1c4mcER5WMEJ?=
 =?us-ascii?Q?LXmd7c2TwZaY38/wM7nM7CD6/kpMzy9gxQb8UQ6305H6YKXSYrdUddUcIGVt?=
 =?us-ascii?Q?OtRaYIfPzEGmRroOQB1EyxjCDrF8adKcNc4QX6pwQWTAjnGDoLu+0U9T3F4R?=
 =?us-ascii?Q?2mdkpzYIqeA9aPL6cRI4VwD38OJO7oSka/GSzakCgmQu3LdWGlGf9jSaXZQ6?=
 =?us-ascii?Q?DPjH8Sn+YOCsRyyhEzn641S8A/yMoXDiRM84QCldMwoGFmOykQFiizuJXJbL?=
 =?us-ascii?Q?FV7fnDHC/9u1kxGsJ8CYpl5rbuZFc7zNKHVTaDBqLcFxDs0YlJfH3VekRlw7?=
 =?us-ascii?Q?hFHjSgUC0qYIlteUwfTJGVMsL1mDWU1vMt6X+rB9cGDPhnFrtO1lde4x+aKj?=
 =?us-ascii?Q?XoHbUQnimzgKtjom4OJnIv+zChSVThU8t3YJonGUQ3Cyoc/lXNLFHWUTjwv0?=
 =?us-ascii?Q?wg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 307db95e-350b-4339-05d2-08dc129e7357
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 12:11:33.2024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dKoT49hYxzFdv6kf7hpO+8rYY/ddhjwQ0Gudh4Zi1EuYehtEqLuK+9/YggwnYRi7QnMJj15JGo5OmAppKUt+jlvg2y0fg1tMUCJLoHpv6yQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8407

This sets the default power save mode setting to enabled.

The power save feature is now stable and stress test issues, such as the
TX timeout error, have been resolved.
commit c7ee0bc8db32 ("Bluetooth: btnxpuart: Resolve TX timeout error in
power save stress test")

With this setting, the driver will send the vendor command to FW at
startup, to enable power save feature.

User can disable this feature using the following vendor
command:
hcitool cmd 3f 23 03 00 00 (HCI_NXP_AUTO_SLEEP_MODE)

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
v2: Corrected subject line. Added commit reference. (Paul Menzel)
 drivers/bluetooth/btnxpuart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 7f88b6f52f26..42e929f0d141 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -281,7 +281,7 @@ static u8 crc8_table[CRC8_TABLE_SIZE];
 
 /* Default configurations */
 #define DEFAULT_H2C_WAKEUP_MODE	WAKEUP_METHOD_BREAK
-#define DEFAULT_PS_MODE		PS_MODE_DISABLE
+#define DEFAULT_PS_MODE		PS_MODE_ENABLE
 #define FW_INIT_BAUDRATE	HCI_NXP_PRI_BAUDRATE
 
 static struct sk_buff *nxp_drv_send_cmd(struct hci_dev *hdev, u16 opcode,
-- 
2.34.1


