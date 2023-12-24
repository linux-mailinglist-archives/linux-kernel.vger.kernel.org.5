Return-Path: <linux-kernel+bounces-10733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3C881DB0F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 16:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC5BE1C20F79
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 15:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB856FB3;
	Sun, 24 Dec 2023 15:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Kwg0wfts"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2084.outbound.protection.outlook.com [40.107.20.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B81610D;
	Sun, 24 Dec 2023 15:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SRXFw9IPx3a4wJxvGwD1oliOcrgf8dlUBehwU9r1sUjLZZYh0krg/ZRjAcbfM8wCv6dQGJZCS/nn49YZlqvgk7TItNt+B7EcSdHLajVRCdhtTil2Emp+y6DNlAeUtzWyvRQ3OhdhvqAUFBTY/voXVSrgFjmg4qoMA+W+S0OU4wcMUZl2QDoaBb+vjBbGESle81ZUOdCnfwazebJixz6RNliw/EX5kgA4jdRaUgRnrb3aYh1Lt62sHq8q4Vaf5DRCmWgdjqQSM77gyeu7KV0cGHBhrTYyC7d2glOwOD6FzuoGoh/L+SPml70i1B3E2O5+d2UTK91qy2A93UW2fIMtrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zn656wf7jWRtMbaJ0yciWoaFHp398qLzkH39Y1NJk/4=;
 b=DTM5DGEV2tkKHlRqB7yjlfAvUCBTf5mFyq6/4GmdeLMokcCX/n/fsXOJzGxdvEoWfdE8mBJOtG5i+Z7CTrIYsHTW6XzJGY0CS8r3ZRPDDa2K6RzsNsxGRsUmzh2kEr4XTIB3jtOo9NMG5JmXrBz4OYKtYIQ0WVT/Wk+i0AZLVnjKUtp4YvlA83O6stfmy6iZqjD4IkqyfxH/yH0CGb0cXRXqExgg7q+ZXkNcytC/iUFdIqhgQ/QZv+Em+e1AZeUmx1AbosuNzGm8Fewm79dkd/2s8sIHNqAHtxYmxrpRSl6JC9cArtTZAt/jWU/ftGTtEJ8UGN0KH8PemtpcpRUk+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zn656wf7jWRtMbaJ0yciWoaFHp398qLzkH39Y1NJk/4=;
 b=Kwg0wftscqtc71b/AGuLNbaSUwg7WKUnYpdvvPIFYwRKvAePwcyhBiLURCCPiYHucnlFxA08h1xBMKWrYM9bHl6QhE09/BTPMllmZiJg3FzW2SVnajCxHNPHvPJzL7vBZIRRtJCkn/J6YLBulGCrYXyh88IFDZkBzIk3cVwuBf8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DBAPR04MB7285.eurprd04.prod.outlook.com (2603:10a6:10:1ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.24; Sun, 24 Dec
 2023 15:38:34 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.026; Sun, 24 Dec 2023
 15:38:33 +0000
From: Frank Li <Frank.Li@nxp.com>
To: cugyly@163.com
Cc: Frank.Li@nxp.com,
	a-govindraju@ti.com,
	gregkh@linuxfoundation.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	pawell@cadence.com,
	peter.chen@kernel.org,
	rogerq@kernel.org
Subject: [PATCH v2 0/4] usb: cdns3: usb uvc iso transfer fix
Date: Sun, 24 Dec 2023 10:38:12 -0500
Message-Id: <20231224153816.1664687-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0058.namprd11.prod.outlook.com
 (2603:10b6:a03:80::35) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DBAPR04MB7285:EE_
X-MS-Office365-Filtering-Correlation-Id: 00ddd024-24ef-4122-b2af-08dc04966336
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LwSF1GBeYwVHRlEmGazblcWv42DrtLXl9839kpDnM27Fhvxs0AeuZH3pmGKevCAN75o2pFHzD+bSQVusJipj31w/VOS6QJCnAvqat49OcDIlGSOAoLTMYwrifkxEIDfDtP63ewCMHlAJqYbUfLiPt0JLmyL0hh/vFPV8FqJfIlPItE99GXKOezq7fAQTtGIcjap4/GC6sJ7ZY78XRbTOJQA5LOcUOeVSZPVbJmc71qzXIY1WeXMKw4P/zZJIRXI2SCMYA67yUpaWLT4Oc7UCQrIhZIfMRBlAL7+5YJcse3qJCvclOqrq50TgcqGsoFK4oJbnaKojFMdXAp6KhJTTeBZd4ogbO8aNRtnB1GxFK8hqpe8OPRkFFrRPnZX1oriXo9ybakPn0t/M39tY4tReL+b30ze1yeHEksCydPeLJzkQXTBOeXovNjHUNF8GuchGOSid6FIh7BqRfd9rotd58uZHcoPsfaOvmm55dooGuOPO2RhSw34TPCVQAJODdrWxim7FBVTnKXY7nRUrIl8NrjMVClKS85s0jr295yrmqeHJpPxkSmrznd6TY7oFocOM0B9eaaorTCkq0/nTRLnWF2HYhawZxqCss1olTQRmoncLUrEMlNAzE3CTR4qKC7FZNZoOqwQ6OBfCYP01dUVp8g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(376002)(366004)(39850400004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(66556008)(66476007)(66946007)(38100700002)(6916009)(316002)(2616005)(1076003)(26005)(4326008)(8936002)(8676002)(478600001)(6486002)(83380400001)(41300700001)(52116002)(2906002)(6506007)(6666004)(6512007)(36756003)(86362001)(38350700005)(5660300002)(1491003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RV5+YNCMOB3qE8DZ+yrt8H3XUiNLX6b4UfhjzXUyqI009r9sKPJw8oK0gkSl?=
 =?us-ascii?Q?dKIerafq9YVCdp4jkbRjRmHR/1hsUPMM2kKy4KcSYeJKsObBu4c6mcU3zJTj?=
 =?us-ascii?Q?NNYPi2WueCbLbU7vfXO8AoWVHFAt2Tv3bzegrxnkH9fP7Q4nWDWdhy7VxfMX?=
 =?us-ascii?Q?DtGHqEl4CyRTI5nxS5X8nJYg0x+vGSAk2q2wzu+P0QUhRQMyuGH5awC5ZBdV?=
 =?us-ascii?Q?5nezGnjpSFDPWDGT10s1EbO0GjPA5eJ2ZYzOYlSGF7yQtTWz1nCD9sGrwxpU?=
 =?us-ascii?Q?K35YPp67Xqs/eRiwRSYKJylf9VmJGDdwTlw8wfPl3SkhZ5UtDxMUBnzFyewH?=
 =?us-ascii?Q?JwQ3yzI0Inp1bqYL3XXyFInXOvBaKRWePE2KanAUlNqRsv/Tn1TJkYJfH9MA?=
 =?us-ascii?Q?nrKuRk4K/hlpUF7VdjmmBB3UTi6cgomCTyi1P7NCYXjl426lyBgFVJa0naSJ?=
 =?us-ascii?Q?s7Iok1l8qhpvkwdzhhw++5ycRYVCk3IGhVXSrKZnYcZCPpnrx7CGt3R19bvM?=
 =?us-ascii?Q?iqWw/s0xqr/rIwzqQQH2jTS0lD9KNbTMv8FmKFfsZR70F9Wd1TIDOvDMdKFe?=
 =?us-ascii?Q?Wrmk4gOhgCNgr0W8294Au1YAnYoGSPXJm0xnWoQXgseNPunb9ymQWepDmXhE?=
 =?us-ascii?Q?Y+yfD0cYzw7ZNQPVk+6Zjk/BiGJ2NRqfdz0EfBfXaaUpWPdP94psWuq46oLU?=
 =?us-ascii?Q?hnO1nwOU/cKkeiFpIlDkdh0dwFLeHDCutV6zBfSLRmDy8WRBLYqkIgGyaoo2?=
 =?us-ascii?Q?032WPsI2lbeHb2Bc/zm5rG2Kb2NlS9mhu3B90BPP3dgG8oc5fFBHgkE+4OAG?=
 =?us-ascii?Q?ciNfS4FuUu7vu7kMcVLHgBLfUQiQJNlKgC8PRFUnfG5yYSplN+dd5lddBtc/?=
 =?us-ascii?Q?u8USiHT4ogvBfpws9jGEUP9iBoJnQDrXAJA2WdGO+0MB9nYZ11j4HHwzcAiY?=
 =?us-ascii?Q?yCS6HlV5oqDX1NVdDDtXWdHAxdmGZiB78FPU8RZIrvwASzAIYSnyVDqjg8Am?=
 =?us-ascii?Q?91P+c9exq1kxLTe1x5ydKBSfBE4NVg0+F/KKwuW1rjbJjBXCkcyy/90d0iqU?=
 =?us-ascii?Q?P+C9RGgwvM4Q4P59rmKukQedj0AWa3CZKIGoFzu0XkpDrUoPoTWuVM8138rf?=
 =?us-ascii?Q?NbHbDsLNiJkjKNgqKDEXvd0JGYZ6aRGOE8qq9+TMrbzFMkuzV0bcbdYMuRwP?=
 =?us-ascii?Q?IdWQrTjJnmJ9RAtQAqHJuB8zbsWENZTM3hy69l71OkSK+IPDGsP+ljY6Zqjt?=
 =?us-ascii?Q?ncIpBx+O9LawCaVQNJ4Fe4MJuDjd/NCB2bKwBsd9qg+XkPKYMYvWsx0Shz70?=
 =?us-ascii?Q?yTnhvD4Rwc7Wy3TulmyJ7cC50FRW31OO9dCNcOydI1vRClD1VohOvEd2jJna?=
 =?us-ascii?Q?Mp///c+ArYxaVjWm8HOJSR2X9QKvDX+aBNOE5MraopuFBLWPjUUKwLTaQYxo?=
 =?us-ascii?Q?HLy9E+LicF8F6qvihjk38+AwIgv6EfT76/BQlss38kQr3Kg7Yzi+H6dDml6/?=
 =?us-ascii?Q?9cbW67l7n2wMTCScT0mDWh7+4w3BLVyf+ivx98F6h/dmPcZ8dA0D8SISmXAA?=
 =?us-ascii?Q?Z4DGio16X4Muj0hxuOw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00ddd024-24ef-4122-b2af-08dc04966336
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2023 15:38:33.8507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xI/OnEkr2WndQJdZ8g3lWq5T/J+GjBTKikiftf5dIfxQRUUy8snRcP3MSEjw3TZlffaLYow7Gbbo1A2b+uSe0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7285

Fix UVC ISO transfer since enable sg.

The basic there are 4 major problems.

Problem 1:
	Previous code have not conside sg enable case at all for ISO transfer.
A typcial UVC package is
	UVC Header: 8bytes
	UVC DATA: P(1K,2K... 3K) - 8
     So need prepare two TRB for this TD transfer.
	CHAIN TRB
	DATA TRB.

	Hardware will fetch it when get every SOF regardless IN token. So
driver have to dupicate it to interval.
	for example, if interval is 4.  driver need duplcate 4 times

        [CHIAN TRB] [DATA TRB]
	[CHIAN TRB] [DATA TRB]
	[CHIAN TRB] [DATA TRB]
	[CHIAN TRB] [DATA TRB]

	Hardware have limitation,  LINK have to be first one when
ISO transfer.  another words, the below pattern is *invalidate*
	[CHIAN TRB] [LINK TRB] [DATA TRB]

	So need insert some DUMMY LINK TRB when close to end of TRB list.

Problem 2:
	When mult and wMaxburst is not zero, EP hardware config need match
EP descriptor, otherwise some data will be lost. for example: if mult is 2
at EP descipor, but hardware EP_CFG is 0, only 1 package will be transfer.
If 2k data lost every 3k data.

Problem 3:
	Look like hardware have not fixed cross 4k bound problem at 8QXP
for ISO transfer. If dma buffer + length cross 4k bound,  DMA will fetch
wrong data

Problem 4:
	Latest f_uvc.c pass full speed descriptor, so missed mult and
wMaxBurst information, so cdns3 check_config() have not reserve enough
internal FIFO memory to ISO endponit.

Linux and ardroid UVC test passed. NCM/masstorage test passed.

Change from v1 to v2.
-Add comment at f_uvc.c

Please more detail for each patches.

Frank Li (4):
  usb: cdns3: fix uvc failure work since sg support enabled
  usb: cdns3: fix iso transfer error when mult is not zero
  usb: cdns3: Fix uvc fail when DMA cross 4k boundery since sg  enabled
  Revert "usb: gadget: f_uvc: change endpoint allocation in
    uvc_function_bind()"

 drivers/usb/cdns3/cdns3-gadget.c    | 142 +++++++++++++++++++++-------
 drivers/usb/cdns3/cdns3-gadget.h    |   3 +
 drivers/usb/gadget/function/f_uvc.c |  18 +++-
 3 files changed, 127 insertions(+), 36 deletions(-)

-- 
2.34.1


