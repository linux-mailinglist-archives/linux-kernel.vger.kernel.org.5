Return-Path: <linux-kernel+bounces-7733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 082CD81AC64
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 02:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8174C1F23A86
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 01:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F09A23D9;
	Thu, 21 Dec 2023 01:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NEDEVnMZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2079.outbound.protection.outlook.com [40.107.8.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4C6184C;
	Thu, 21 Dec 2023 01:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8FTGfVU/AjFoeNoWQ3flzLdlbAuIfxjpvtP6C3wE/W2LhPfd4j1uyA1Wn3UGLmFITlu4KX4ga44zwNNfgybU0z3n6o++h9ZU9xmxvmXpcacCrwhZPBbdQfggqfB/HnwVr0UvfWOzQwfDIV06HorIssMR+gjkcRaHJWP/E41IXInRYK0cACoGukaLiWVY+6BYYWec+zdol9TRmZunFpG/nTPT4snRhIiHzQ/YjNf6uQVL8wjkSByLeHLW5XBoRPpwsSRqlm+N7DY+DQx3vAS3x1vsVoGIDidzGqrkGF0oq6HvS8rfdXmhKMQo7GUJziRRTDOYuW1m74jwrWJPSAzRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uKudgzDyEN0SHJhiq9UuhDS3i4B7jAKsqGj7ubi5gdw=;
 b=GQrSa05IlUDhRZ7VNCrHw9/+9gWwqdHdvoh3WxVszE04RWfMPTYbmJqLC+RElml0BN6+ogZJMNnTwrMKB13k2BQRUZkZWonrPjl8UxvSCVCdeaKJPwVF0z7BKUTXTQrYNgd69bqeYHwAedJDYE/NPpIUHaZQIGuXFlli8yN2HIsr7hp4svQbOJe6ZYd4kt7r77nIKB5y+PYhtqUCylUtpRAPtf6FooD2xOJkdEpjGlIsNHuBsFZ9mxTVyqS0ujre4PiyRZzO43xwdFFzIw5Wvaou0vsunhdzOmoG9odyDrqqVU88lM/r8xvfU8uT6CG9OhBoZ8n0cha1+DQFdc/IMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uKudgzDyEN0SHJhiq9UuhDS3i4B7jAKsqGj7ubi5gdw=;
 b=NEDEVnMZhQ7fMKAntrH1W1xfJQEfdo6hRYpDvfNe1WrHA99sAuRZKSzefNdFAl1f1EmaqxAXGYcKVYfP1z09kvARVNxJciBFgW4mMTExdpmSKHL7lRQvs4G8ipBj1qtfrxHtgl8bm5EroGo1796lQVVJCSc5EB2NWbSuKNo7wvc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9636.eurprd04.prod.outlook.com (2603:10a6:10:320::21)
 by AS8PR04MB7943.eurprd04.prod.outlook.com (2603:10a6:20b:2a1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Thu, 21 Dec
 2023 01:55:48 +0000
Received: from DU0PR04MB9636.eurprd04.prod.outlook.com
 ([fe80::1f29:340e:75ac:d14a]) by DU0PR04MB9636.eurprd04.prod.outlook.com
 ([fe80::1f29:340e:75ac:d14a%7]) with mapi id 15.20.7113.016; Thu, 21 Dec 2023
 01:55:48 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	kvalo@kernel.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>,
	stable@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <error27@gmail.com>
Subject: [PATCH v2] wifi: mwifiex: fix uninitialized firmware_stat
Date: Thu, 21 Dec 2023 09:55:11 +0800
Message-Id: <20231221015511.1032128-1-yu-hao.lin@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0190.apcprd04.prod.outlook.com
 (2603:1096:4:14::28) To DU0PR04MB9636.eurprd04.prod.outlook.com
 (2603:10a6:10:320::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9636:EE_|AS8PR04MB7943:EE_
X-MS-Office365-Filtering-Correlation-Id: 01cb0b67-3520-44ea-cdad-08dc01c7f3c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xZOMFbXDCZAKr5y8AkTSln/vpQpND1bT63YcY4n/lWjCd3FDxbQ4rcsj1kTYceHaeZLpqSPNfZ4NFduVhW3hI7M/DTzAjgu+MwTEVoTorg5mPFkg8NmvxOrUZAvJKnIKHJ6SKhPL4KH2DI0rU1cXqj4YzmRynrpcX/3KTrYbf1fmYk3rxev3i+3N2uzkJancQekrZfh2AOhB6iRoRVforHDW5+ZNQNHruMZ8tIoy92VnCv2XVkSKUWKwtZ6WLy9fwD6Ld+Fe15SxKsKtjab6NaFoCmYxZu4FgasruF9QzV+EYqdZtyHsusPAjyo30F2Xt9iZBiTTdwnpNuawKJZHpQTYZ1ZiofpII3d1/KhvuIyUHTZr5gL8olwJWJHCpq10Fg/zsVkBpaEWwOmD8DREnrDPjnFaNg/HT93dhpVUIzkvLmcajLIQfckFVD7SxjczIFNDwBrv7oYJobQFZKwOuu0AFnvzM5T1VvK06/WnOh3Vzn97GTsnLURl8/fHF293T0SvQV6O74AhPkxnE9Rhjl8BmbcORhUPcUvMtD31M+UhpW65ysfCu6w6Tn5Uhrzckk+QzwVNEr4Do7YrSMDxCeNZLGiM3D7GiunhOUigsuA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9636.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(396003)(136003)(39860400002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(41300700001)(6666004)(6506007)(86362001)(52116002)(26005)(1076003)(478600001)(2616005)(6512007)(8936002)(38350700005)(2906002)(36756003)(5660300002)(8676002)(4326008)(6486002)(966005)(83380400001)(6916009)(66946007)(316002)(66476007)(54906003)(66556008)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q3lZfLtO6VoZg+olfaMLLJdkzd2yCcKplUeq8awdJJfLmNfTdUTsWHoLdowf?=
 =?us-ascii?Q?IvFZ//4JWyoAv3HqZ7o9u2LiPbTaF3jgVAjbl2URJdpnxDPJYz6ldem+6BXm?=
 =?us-ascii?Q?q9IgMAOxrzIyHRJHW9dQP2XV+VD1GJrurH6y06a30+GXq3ylqaM6i1WscB4Z?=
 =?us-ascii?Q?hBd+QcbGMSDc3kITsnAY2cbw1poXia0WBbfebbfGgAK74DCcJuSv+1wsyffW?=
 =?us-ascii?Q?M3aaHP9JDxROSjFWlyKvl09Odroz5+iO8L/63GuhhCSwY96uCZ+T2qbHt2dv?=
 =?us-ascii?Q?RLOGKxg4yYfIatdKqGtxbKOEbAnTaE/MNw5G00FDSPMYJXO9Q4VxeKpiTkeF?=
 =?us-ascii?Q?1iUC0WCaNEpZNvpvd5J045qxTP88bvpFB3L1PI8apCbpFW1P+0zW9tgNvu47?=
 =?us-ascii?Q?NtxtGTZrj0zMYkk/JHVRx/dmEfXLpGEozdl46fOyfAIqlK8/E9owZEwNVSQT?=
 =?us-ascii?Q?1m0WWxKx9TwnVChzK729ZGDfqj1uFTfb5+GLOyHm7Wqb6kkDgfKvUH2wxVMT?=
 =?us-ascii?Q?Hk4qTVhGG2cDDTBB/RwibXqpRjI2h1Rjgh2NHbDBuUQPaNWZZgLYT2wGXTSS?=
 =?us-ascii?Q?p+iR1DW0q3K+2gUYZ7hjQAtQmQfLURvK1DjL0/beJvIXG0ZWKxReQkn0sPd2?=
 =?us-ascii?Q?WMbkwckmIdlC2zx9WyRGbXSoJJp/gYrtCI2TWHRRpKumpPJ0MKDCSSh9KT7B?=
 =?us-ascii?Q?rp71IHyd/F63iKXHyOqB6trnhs6N62/8fUEQhVH6GdrPjuCj+fiIeZjHlffH?=
 =?us-ascii?Q?D7JC8uDtA99BsRcJSF5KAbPmVPexkAMeyVr4+8vw3FLUAtH6WCbjRuWCc63i?=
 =?us-ascii?Q?xZ/p1WzzxJ3+GQsJM03NB4xJy83WgvyS5pjiYGxnoLZuY6p1Fk0GwvYmELqh?=
 =?us-ascii?Q?8tbVUgF7ijtv+LWxTxdwsLqJNtIrkJExaeCK6E4axJf1QQmLhd6IuRW0bM13?=
 =?us-ascii?Q?V8p6pL7banGHO7lP0V0igSk7Oer1qG1Fvaw6qqcKoL7ofqeXdQVQCmpq9CDc?=
 =?us-ascii?Q?LKZazB8iplyCDP1lXLAtEKN5DEU8HF9YDvsjNOt91Ypjfit6xaYJWdc1ph67?=
 =?us-ascii?Q?wiMVfZNTbMXop38T5m81bIqMPShZcji7rxeUlbdbKAgJAI4mAZ6LEgPNg0se?=
 =?us-ascii?Q?93sLADe+crNN+gSw5FYknyOLBe92FgzqXiWI91fOFQa1XJLUJEDMNjNVK9uj?=
 =?us-ascii?Q?hCNxlKOB1npske7ZMSos5k1yjzKVOa3VvToLofTsQp/aIY5kkrLTBxSYN73S?=
 =?us-ascii?Q?FfOFq8z8jlbk/ZvbO13LRG5Qgb6dK7qzpcJpnMSbarRGj2dFPbLE4X078gck?=
 =?us-ascii?Q?SSVEnMQ1icY5wwmUldDk/MmbEahU5PHuBucqB3F+wq6BP5O+NiiQLMsUfY8i?=
 =?us-ascii?Q?lQkX/+6yBDoxEbLWM12tImH6FnDaZMGuZqi4JrvOHKGc9xTr4FxsmbfRczPM?=
 =?us-ascii?Q?+Sau4gtw3cxeYPXXxXDhS++dMU4vhUdHY9x2Ol1ipvoSSJ5n1uCZslUTa/H0?=
 =?us-ascii?Q?IaZknky1T1kMfJy4Egk6e6xhZ8X7R4yJU6uMM/CAOuWKoZdaVCAzyB1MClnp?=
 =?us-ascii?Q?XGXOK1fL9TzGuxlU78mbsbO89Tuy1mcNxlKbEB47?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01cb0b67-3520-44ea-cdad-08dc01c7f3c6
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9636.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 01:55:48.2938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1CydgajJnE0KN023wN/gUL7cvzhzREXgDFyDYuInoGe88q+UDE5P2fSIKcWQGNTvEylYyUIFHn3FqHXs3Q4IWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7943

Variable firmware_stat is possible to be used without initialization.

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
Fixes: 1c5d463c0770 ("wifi: mwifiex: add extra delay for firmware ready")
Cc: stable@vger.kernel.org
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/202312192236.ZflaWYCw-lkp@intel.com/

---

v2:
   - corrected spelling error: possilbe -> possible.
---
 drivers/net/wireless/marvell/mwifiex/sdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.c b/drivers/net/wireless/marvell/mwifiex/sdio.c
index ef3e68d1059c..75f53c2f1e1f 100644
--- a/drivers/net/wireless/marvell/mwifiex/sdio.c
+++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
@@ -779,7 +779,7 @@ static int mwifiex_check_fw_status(struct mwifiex_adapter *adapter,
 {
 	struct sdio_mmc_card *card = adapter->card;
 	int ret = 0;
-	u16 firmware_stat;
+	u16 firmware_stat = 0;
 	u32 tries;
 
 	for (tries = 0; tries < poll_num; tries++) {

base-commit: 783004b6dbda2cfe9a552a4cc9c1d168a2068f6c
prerequisite-patch-id: ee10b03f813ab1e72d05c59aef4e07a26afdf678
-- 
2.25.1


