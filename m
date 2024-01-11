Return-Path: <linux-kernel+bounces-23360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4783782AB96
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4F152840CC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D65514F95;
	Thu, 11 Jan 2024 10:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BUF/gbU8"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2041.outbound.protection.outlook.com [40.107.14.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A2E14F77;
	Thu, 11 Jan 2024 10:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WQFGYfmis2os9dCgJU3rgzQUphy5fOQ1is5yBCZ2J3Y2KyUpz/BV7SRWmB5VIzya4/zIXeoRs+Ekz8gTq1TwSjuJ2t0i8irTmDTx2dCuFeCzdFP+DAiu9l7Th3nBqUFv0TVlSlku+uLFXsFmLZvAqytZx0PQJQIdeNOMmzbtQFluBcglFpdbJUH0k0UL4V3Bzip0JOaRPxhCgnSjIRNkDAk7KphK9M+xMlEorLaT6BsUvXijnrplME+CNX+s9UGdhUi0DhbXrU9D6OQgX42aEQKVw9kMEvBUExMcu2Xpn7yZ/ffmfihG5jMBHuwN5gBrZxfCAtiQbRADDkXCuEPiIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R+UOmuq+dXxEMBTg9eyqsqDZtdAlik+J3SWCbQ0MQFM=;
 b=STaJiFAIULYUL+ebbpRXsRIsSzyS5+MF3/ZlaeL9UCG9U8aA4YMeMy8YwOLcQGRuKne8hf1OZ6eV/w3ShsWHlEEqHHBWVWYpkSJ7XxxivjS1XQW6FRnavZQVF8eLViDl5X+KCD/gh0d8OiOKpovAcugoxmTiU490RqP+VbfITebWzbJvt2HMjsJxte133Tl7d/ey8RPXXIRID+ykc1Lf6PnLp7napUE7pBvzi8sw4S4qxdgcuCS5GXXk+dksKh1eZh/XRmVnrnS98koGTbyvxU2A5+DE+zSpgoKzALqvd6DqPaYW/RIX5tViO8jJvdrNGXUOV4Bp6tpjPeJjUWCdBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+UOmuq+dXxEMBTg9eyqsqDZtdAlik+J3SWCbQ0MQFM=;
 b=BUF/gbU8hMXRzQuBRY5o00nNJ+7oNa1baGR+TwHAvpRgfOZwRQ/h4P0COwqQFBKw/jQVqvwxP3vkFhV23KfzEZxcJCmWaSvuiUKqQ3mq1N5RvNHrZC5nG0CGFEXPnPNa21mmSET4tGz4/1R/51YMRY2j+SdVGRRlSMWexF7f3oE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by AS8PR04MB8197.eurprd04.prod.outlook.com (2603:10a6:20b:3fd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Thu, 11 Jan
 2024 10:06:53 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::748a:98f4:59fa:f206]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::748a:98f4:59fa:f206%7]) with mapi id 15.20.7181.015; Thu, 11 Jan 2024
 10:06:53 +0000
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
Subject: [PATCH v1] Bluetooth: btnxpuart: Disable Power Save feature on startup
Date: Thu, 11 Jan 2024 13:36:42 +0530
Message-Id: <20240111080642.270123-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P251CA0002.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::7) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|AS8PR04MB8197:EE_
X-MS-Office365-Filtering-Correlation-Id: bf3ef3f6-e6a0-4c0b-68ab-08dc128d08f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dEbg7M4DrEKu/3K04j6yacUXjrNxJtlCqY4wXI6T4vm2R+kkUyVUj5Ah2iwpLIJYbIWBATSuql7Zuv/Cki54gZVSjlgFQqXrz6nYpLpbW6p6E4yIwfcxA+gUborztrn8yRwZFKsgJuEraRlLAoStUlKmzYlS39FxBYgiUeTPX+bLuRqrvA1hvnT+ORwoWhjsvk+WVIZtcTC+VI/he2wt7jxjVE3gNPeDtqZTG5nJlUW/w/QEWJGavVCHl6JYRZ7KNFsulDy6dKc5KnOR8+Loc8QlSfCSvJmbT1AHFmWzjUILhSNeLk9elBHk9PiudNVpj63N/frYxRwTrlSbc0aMTaWK5bWC/SES5Lok3Ie9L5xBdDtP2jDUq4H2HJjJDb7eqlRuhL/GaWitA+O8QPqOBUdcVfoCUuc1CrM+S7tetK7l4BwUB5RaBY2WnlRhZtl3ikHhlbeDPKnu6y6MUThmL011nNjCADU7eI3SfMg3w9pspQSinLp29P+zT8hZfQChHRJFeYeQr4t18CLW1ds+MSl1gM2PH83OpUnaDJiTTmfsMRhJva64Vq9F69bCW9TqRDlrFJw6qpEpTrignSuKiK/HGTdtb36iJgVDOjUacHE18F3L2chcUrV76CjkoJVK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(376002)(136003)(39860400002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(66556008)(66946007)(66476007)(316002)(478600001)(6506007)(52116002)(6666004)(26005)(4326008)(2616005)(1076003)(6486002)(2906002)(5660300002)(83380400001)(6512007)(8676002)(8936002)(38100700002)(41300700001)(38350700005)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5xHdIZy4FTraxRi6GtcmpWwyHwZbhYW/yx8BLA0oldWxRdqEAkCFR3gGqo33?=
 =?us-ascii?Q?J7vJImWdmbznk/2nUpAWnFN6DTw+pMmTt1OZ/bEBTFObMtUWB6vBC9DXrxXR?=
 =?us-ascii?Q?Qs04DMjQ5q2HlCID5oHH2Xl8IurPLko4t+Zjyg2qAsSbsHR6DCmEhpsL29jp?=
 =?us-ascii?Q?PDsQT+MRUaI8Og/zGz2HWqpm2lbHAqCzz9xdL4HbmCrFajwTpTYysqCql0Ws?=
 =?us-ascii?Q?Wdfnz4r1W/5JiNWfe6W8gSqY3R9RX5YUXrKg+t4P5sx4+F/4KoebzBuU9Z+2?=
 =?us-ascii?Q?URnhwv13Nw1WtCC0QPaZ2R3SE3MIOXw0spgs+lnUhEahTHhaihE9rsmCbrdY?=
 =?us-ascii?Q?nkEKlwfw+sBcwNowmBRfkMZoHtch7E0y3/LTyb08OfMDQFoMhVDn/Xi7eetR?=
 =?us-ascii?Q?Ry2BGUsKQxK0DrYlvnRhERaoap0bMptvMt4wWBaZDkjD9sMjvhzN26sA7NP+?=
 =?us-ascii?Q?WUk7WfaxnbFTf+it174s4FcHR0l95w+IL46IS2r1/cVSdFxv9nIEYxd6zcXo?=
 =?us-ascii?Q?a+D1pq40gNLbAvSF20+EMhn17Bhb/0tEcKCIJIN36P+CKjk5Wj8Gn1IL1CIo?=
 =?us-ascii?Q?Uc7BTdShWg1j4woyzJHFJ8RGz0cZSnckfQX5oubeEumhRhEnWPZBJGtdmZbx?=
 =?us-ascii?Q?zdSbvHU2n/15FiWrC4wZaBoV0EYeII46AQ1uCI2iQbDnG46dKJwQx0wDxbrU?=
 =?us-ascii?Q?5qYhcmxkNErX3zYW5aim6CysqNFiT5L9+MjQbYaRARXwxd6RD4tLlgdclkl9?=
 =?us-ascii?Q?LEgtWTCRsd1wpWlpj7xPNHi5FKLx0Ea3Nvguqa50gkhmTs/yD67mDMHVJxdX?=
 =?us-ascii?Q?XPbu76gGKbuT2xEGlwcYc7AkxyyMBFLDSYa/DYb9i4Cux2jTa0NhoEDbWtyk?=
 =?us-ascii?Q?IgKUMT/Wiu/gmfehqnZWWhYzHN8ONfLNwzM5rVkGnRXpa8lLC5F3jxYm0hI6?=
 =?us-ascii?Q?wqHarhs5IdH5ZoFPu91WOMw2uOAiwPivDyKRH4OLF4GHajJn0eM3KEeu2gBO?=
 =?us-ascii?Q?RfLimrfT8DwEPst+V5f9tjUSTkvm/PsLJFidZi5eLY1utG5RpZDrkFtyTjnS?=
 =?us-ascii?Q?JuZcupz2mB6sZjwMUnR8KGbShaADC8ooxycZ5otd/Gmpyyax3YArNmKivUFx?=
 =?us-ascii?Q?Ikie+HoiN3a3AqNV4y+pNtL+C1pHeEqQ1bS2Um6a2mJ78v0yxgIlD0zW/eqn?=
 =?us-ascii?Q?b6pkzFahYAC+1VvFKrbe78i6BMBfNCE1ursJQYEyhimHCDs7zQYXn2PAEF3q?=
 =?us-ascii?Q?vy+5sESpKH3tM1ofpHdMddZbF6+w0UJf86HchCpUFvY44BjwWFm7j6U0Iafl?=
 =?us-ascii?Q?5eqaO2rz8oeUtdY5AJe0FwK4OPLN9x8luW/DjkGXlDwQqVlTWhHpN7Qup+pe?=
 =?us-ascii?Q?WrQ9HSk1iENUBgMMp+MqjKPczzRacfNLiQRY9vOhl9V/y1DpvEwlu2d3YRVB?=
 =?us-ascii?Q?4Im24MHNsm1G7PwQgpesXDeImK+KZa7CBWFJHFmd9oGapFObceGWXTqHEThs?=
 =?us-ascii?Q?+3bvY/S85mbik7OC+OS4JuL0g8h1OasUkz3g980qLBJmBfDmKWuotsXSsBdN?=
 =?us-ascii?Q?YOLuzdCsGmVqYuGFOFJUmmcjM3LSZvikAlti3RpYpRLv9w/ZKtJj769quILt?=
 =?us-ascii?Q?GQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf3ef3f6-e6a0-4c0b-68ab-08dc128d08f0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 10:06:53.2962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YHXgjnAqZAdv7Wodh+Go6C3wq2U9hqaOcvq9kAZtufkzaBfR1CnSqaQfMrE6hXZbDlNe0eC8WLJbyh9tU6cL3k/nf4sOQFBAA1t1amZSpl4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8197

This sets the default power save mode setting to enabled.
The power save feature is now stable and stress test issues,
such as the TX timeout error, has been resolved.
With this setting, the driver will send the vendor command
to FW at startup, to enable power save feature.
User can disable this feature using the following vendor
command:
hcitool cmd 3f 23 03 00 00 (HCI_NXP_AUTO_SLEEP_MODE)

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
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


