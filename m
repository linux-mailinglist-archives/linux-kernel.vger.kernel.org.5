Return-Path: <linux-kernel+bounces-13090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B88C681FF91
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 14:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B8031F22CE6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 13:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3A311703;
	Fri, 29 Dec 2023 13:03:04 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01on2055.outbound.protection.outlook.com [40.107.222.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69D0111B1;
	Fri, 29 Dec 2023 13:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M4/drzrGX7RrMrJ6SCdv3dYLLN56/um2KCQkHf7UsS0SuhzVyRkfKo54ubZTftBWAEkZd9hnBxjYvpGcukXzhEpvUXeMZEsOeJZ5Mw5QlWBLX7esSSN8qJNBb/ZzAbtTlJeXnHNpUBnSyM1BkYCx9L3xHMGmcllezDXWM6bE2onZPYf0PH3+0l3n5+BSdfRhCxUQ/j87gosG1QruM6Fs26Rwg2eFXulHPsP4u/66YSdpYtL9LCaHCc7EI6p7zkc7i+uUpY0WQdT+7sa/Ht9kOPc2zYiW2chIhkJn2hvirVOS93q9znnoqkoWN/ADaMKxJoe60CLSVHqp1keTNly6Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ab/N8jxNsQ7ZFSg74wRxqWpYKOAEQeUIizGtUunjS00=;
 b=eykpGzLC/SwSQYTB/Fwo1+uPLNOH99uj6EdTRJP8T/t/bxwfy6Eetjai4dgvMdgK/3T32vZG9AKUGKbpbeAjy+2/t3V9jRU3xfzX3Awca/iDHNPsHVQe7SZKYfjOFue/znkPkM2TKWQ0WurcMmiEZFoO8DcbkA7+6EgGtcOVHQmF6ZQMd4eQk6R/6ZTowuiIURmpSveIsNQ1qZSL45J2XXsg5DtPloRaThC14hnpzBwwsBvfUMR5XUKp6UAimDTJfONKqmYwHwLHP6G/UkAPQ9yOMgvgv5mI+Ji5X7dyQJIV4th9GZCV5gQhabW8PQLSx6OhKjokaFVMJO64n1/BiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from MA0PR01MB7145.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:31::9)
 by MAZPR01MB6989.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:50::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.21; Fri, 29 Dec
 2023 13:02:59 +0000
Received: from MA0PR01MB7145.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::eb15:266a:cd6a:e0f1]) by MA0PR01MB7145.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::eb15:266a:cd6a:e0f1%7]) with mapi id 15.20.7135.019; Fri, 29 Dec 2023
 13:02:59 +0000
From: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
To: haibo.chen@nxp.com,
	ulf.hansson@linaro.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: hardevsinh.palaniya@siliconsignals.io,
	Adrian Hunter <adrian.hunter@intel.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-mmc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: sdhci-esdhc-imx: Fix smatch errors
Date: Fri, 29 Dec 2023 18:32:07 +0530
Message-Id: <20231229130207.3539334-1-hardevsinh.palaniya@siliconsignals.io>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN3PR01CA0061.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::6) To MA0PR01MB7145.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:31::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0PR01MB7145:EE_|MAZPR01MB6989:EE_
X-MS-Office365-Filtering-Correlation-Id: 136f07e0-3394-411f-4f78-08dc086e7b38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1c9Dc/7mady7ZuKmB0oNnJ75GbSjTpxk55xqkYuSw2muEumUb6pFea64Tecy7JZPkwZqXfrGED5K/H/flQVDWtdH6XARl2UIlLa9zPzSBUPGGPpNh7tViQY3nW75nluji1ST+vqdJzI1p6hwUE8iUDkFS2USCgXaaIxsyXf9NiqhkYf57m+iK75AwFuZ8EctKVy/jd6/QtAZrXNhizr30RjUaaWzKZSbiOCNajEAsgJar+V9k5iybpH9jh79U10NMl06hs/S+95vzT+H3haDulzwFZq35mvI7mpz/1oTc0/FgbTOaJzKhCIoiNqG0XgJ882GeqR+O3T4NVJnzDe1RvPU6WE8Vqzy1CMLkRLEbR+5n3uH/b6KEBEeSXVFbeQtL7f3liBM8ipEWrvwVrrj4gxGL2geL0T53+AR9hJxhsAwsoEbXUtBToEM+Pe7Rgz8HzcdHb/c2KafPh82gPIx/ActEk0G/x9qymyLlIaDi2vqfWEfoVZImzv9DB0UrcriXKrZtTzADHekvEGWHNZrauct+dRs0meIJsNRJypjYDEK9Mxm6OxXCldII9hxNgstwz6aj7/4DAi3m9lmzYaeGbT7jiKxlo93t34b/TRwnd4Dn1IFcTEX/eBfYeDxkNrl
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0PR01MB7145.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39830400003)(346002)(366004)(136003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(6512007)(6506007)(8936002)(66556008)(66476007)(86362001)(66946007)(6666004)(478600001)(52116002)(6486002)(2616005)(1076003)(26005)(36756003)(54906003)(316002)(38350700005)(7416002)(4744005)(4326008)(5660300002)(44832011)(8676002)(2906002)(38100700002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+fq4hVbY06oE5xGVGXlDkvyGUzK3Ng12AiSDJzVc25pPzGrtHwzX7o7KtMOQ?=
 =?us-ascii?Q?M76nkkUIe50xUIkOyxBlizxWmj+rWOzC1Zt1bBxZTHGDBRSNV1ggRohDJecR?=
 =?us-ascii?Q?uIvmtfoUVyN9rh1SJKlQCpKnOnQ5NbcUZFMTHqHSTamSSJK3zp6YYQOeUdRf?=
 =?us-ascii?Q?O+hkLf7sLHnq8CDaVJMG05qYnTTCOexA/0ZO42sJ8cvsLgl6DaP4J41zbtgh?=
 =?us-ascii?Q?yqEtlCOw9gY4e6tGd+XgUResSsd/EQQZi3FBQfkZbXX2Mi2OWKFDQqC+5GnV?=
 =?us-ascii?Q?lgG1A4KjSkj9MusffjEMOMqMZr/9avWrztTaspfENoif4hn17sy9NkSLZT9j?=
 =?us-ascii?Q?aaChCRg49EmU7MsHwhg+y6bqSgWvGBNXVxnkQZUmlQP66WOw+6iJ/kJx2/aO?=
 =?us-ascii?Q?wMbb78bpJz+hMsT44Lm1tQy3rDc7r9u4NCGq3hsm+OILqtQYye65ExDpiZFD?=
 =?us-ascii?Q?ePQUNlnyeR+fQY0TaQiqJpPGJMzn4Vtwc8DhDIU8l5V1FAN4soL3teMpIb5n?=
 =?us-ascii?Q?hwpOB9mPyM6aOuvIT4R1JdI6UFNLa9LgluPMxtbFNJFbDbb9EBLnneZKbLA7?=
 =?us-ascii?Q?ZqOnkGXUOG9FiH9JjDyM/OrTMhOmkK17roh5Ws8qte2zrJmFbEiaYI3IHbAH?=
 =?us-ascii?Q?8NAbJ1p/i4RbyFyT49BQqed31DlRtpGs8kmdlYtLJBLX0OE0Va2mrF2PTRVG?=
 =?us-ascii?Q?jDA8glKp3sE3ugKoj+JC4JCKzHuIK+EmYCh07exT3QTirqd73e6QVu5RVDOa?=
 =?us-ascii?Q?PKakOALmx9nEV0jDUotxzqnioOWaVMLSfuFYkciZWepOSxbn9nsFLP92Zw1/?=
 =?us-ascii?Q?bi14bNDGr1v2wbq4dELvZDO2wsNMpV5AvDnlv14kam+exgpXKwui1FRsbCc2?=
 =?us-ascii?Q?Rowz+c+Ro56L6hm8OwPiArcHs4h/duR3426jwRLYkIeUySmHmwhk/7eVRxOU?=
 =?us-ascii?Q?tSmOsW3QgHfop7j2bOjszadFs8l44M0GwUDT8/SUQQlC+DN1JNT+nmSlYjiG?=
 =?us-ascii?Q?eCkW5n5ON7Jns03OdIDiqvczyYY7BPG5Vy3eYS7AxgFck3/qy+D3DsRois7m?=
 =?us-ascii?Q?/ueloKlb9pOGBuduPWaoDUPRqlE/Nb9YxSPHQ3MkAzJ7Cq7GS57hEfiRgXKO?=
 =?us-ascii?Q?iPq2l/H2kTkik6FJd3K3DoWfSmMcSLzN2fF6mpJVoPIcOwI5A/IeR8k1J6qT?=
 =?us-ascii?Q?youABa2RrefPlLrbIKSPhDMOPOd8tzdyClH/5ZrELQy/HYUBWjumALcjmlGl?=
 =?us-ascii?Q?TRPE5sWE47Exnk/ernO3buXrzEUlEs4W8dCAxmRPOww7NOQSI+MRrrHgbA6T?=
 =?us-ascii?Q?8Kve5R6XSVhEftGWCn0tdAlj+on0hHLKvoZ2+/93UyUvuKBDROiAP61jcYEY?=
 =?us-ascii?Q?H1Zr61+LN6t3NjMNBxdTVKY6cdlUoPXaiGu9vf+B+KPub4ly7b5wZf5oDDIP?=
 =?us-ascii?Q?MiwayYmFBjSvQ2VvnnySkqYT58NHtUkdd8h9qG1BUaHP8ADyb2t0VKS37Hfc?=
 =?us-ascii?Q?lgQk1pJ5RBfgnTKuh0U1rvcMtNdBFmbtlYx4645RvUFMJzgUqo1H5qCEKG55?=
 =?us-ascii?Q?zjq2R+oKnAsIT5BdIALVxeRGFNSIAoHUtatc6MQiS73bIGCI2nzyHBSzFxVk?=
 =?us-ascii?Q?TkRK5F/sud9LFpH55yX5RB6m8uOFC9W8RZAhqqOUrhCI?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 136f07e0-3394-411f-4f78-08dc086e7b38
X-MS-Exchange-CrossTenant-AuthSource: MA0PR01MB7145.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2023 13:02:58.8265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vLNZ4JdjqvWDRxsVAo1vGvuXR0sjjELwt9pAXKsxgMxBp93GZGbkUJdi+QH4NygySD8k2O20IyUNkcrUrcoM3T8H6Hx/M7/2R805SlrPwjU9KCErTR64eYzv2LAQMmRf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB6989

Resolve smatch errors in esdhc_executing_tuning()

esdhc_executing_tuning() error: uninitialized symbol 'target_min'
esdhc_executing_tuning() error: uninitialized symbol 'target_max'

Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 40a6e2f8145a..839b60138f04 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1166,6 +1166,8 @@ static int esdhc_executing_tuning(struct sdhci_host *host, u32 opcode)
 	min = ESDHC_TUNE_CTRL_MIN;
 	max = ESDHC_TUNE_CTRL_MIN;
 	target_win_length = 0;
+	target_min = 0;
+	target_max = 0;
 	while (max < ESDHC_TUNE_CTRL_MAX) {
 		/* find the mininum delay first which can pass tuning */
 		while (min < ESDHC_TUNE_CTRL_MAX) {
-- 
2.25.1


