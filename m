Return-Path: <linux-kernel+bounces-20282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E39827CD5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 03:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A50BB1C233B1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 02:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C153F28E8;
	Tue,  9 Jan 2024 02:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="WVg8wjOn"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2113.outbound.protection.outlook.com [40.107.215.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897F02115;
	Tue,  9 Jan 2024 02:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ijPcpDbGAkCchFSXwZ3/ifxul8guAYZGsHEJCUkXNVDWH5ez/3pmv6cvnoWeKPiBfOlCVez7TBU6c546kuP05aRS2dpaNNYFr2T4DSADHpd9iQmE2kLBX/ITXW3VBWfJy+P94PfK7xIASQLuOpUR8jGYBI3YfXluFSaqKamU0K1DrRrd0oP5CzSLIzRFR2J+v873AmxufZ4G3WvsniAPZM1d4p3kf1uuZhtQPQo5BjSdLNAGx+7AP5CKmL1q2XDNBNNOZW+7QS4BZ0rSY5lCuaej+wLYDElWdvFi/YM2GqgBc+dIaX/raNIugDbIkZqDBMwk0SnxDjF4oKcR9kguDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c13Kn9NTAc0JAoLfoSC3Bmm4oe6v0ejTngOWKVXpul8=;
 b=Wk2N2lSXIVCxZrX6wfe5MgmLPfRBLICUFtOFDZ1eYQ7P8nZD9SsibLt3Rmzit5+UCuUSav8IIaCD9C9FzU/ftZuZ5GvIoTk/+FkrSjeKeBfagNMc6vNcW68FdoTWMFpjpv2Ivxw69R1OqhImjtvlh+oivmuQQQJ2BUp/TMKqSeKsoDJ4BWmObefJGg6eEWK8LgC9Q57ms+BG4z8TkPNAJ+e9zqd3P4Z2R9SfqEHRJLsb0/VNOa/XAlfRSaOmGgHFi4+u14ZaeWBWWX5y3QuYOre9eAm1+S1AI5DjT9ay8pUCVoWx8rX93WCHoGpEEkR9nvcySK1L/rRezdw4NvxQbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c13Kn9NTAc0JAoLfoSC3Bmm4oe6v0ejTngOWKVXpul8=;
 b=WVg8wjOnD2G1gYR1gLN+087FyGad8lLyHvv7b+AGEJoIHs10lXG01Sm6dMLA/b3PVVOGkTXkoKHSBgCnNKVr1389zYQVG8sIdZBnS1Vpnz4FfUhM/RCglTJeBpiG13gpFysbAgSysmk/dWA904w/VRr95HZUcqib93Y7hYcbOPQMz9HGgn3proMK18KqpE+Dw3pTheW0wSDei1hNbmQpVe8EN08x2gKqw6fQ37vxqWAKd+lEwe4+QVXbHy3+zNdYScH1PTjtUnL20BHaYY7fS+v2Auvyj845fAkYv+EB4QauM8q3xyr2uLKOyDWSjHw7AZ4QyZZs6EUDlJghkpf3ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 KL1PR0601MB3940.apcprd06.prod.outlook.com (2603:1096:820:2a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 02:19:50 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f3c:e509:94c2:122d]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f3c:e509:94c2:122d%7]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 02:19:50 +0000
From: Minjie Du <duminjie@vivo.com>
To: Tom Zanussi <tom.zanussi@linux.intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org (open list:INTEL IAA CRYPTO DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: opensource.kernel@vivo.com,
	Minjie Du <duminjie@vivo.com>
Subject: [PATCH v1] crypto: iaa - Remove unnecessary debugfs_create_dir() error check in iaa_crypto_debugfs_init()
Date: Tue,  9 Jan 2024 10:19:14 +0800
Message-Id: <20240109021916.20960-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0167.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::23) To SG2PR06MB5288.apcprd06.prod.outlook.com
 (2603:1096:4:1dc::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5288:EE_|KL1PR0601MB3940:EE_
X-MS-Office365-Filtering-Correlation-Id: e2c2cf28-e5b6-4d60-089b-08dc10b97515
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	G1Io6tZYaMAJaBRVZ4ilIJGsDuHJxSi46mZEuunY6fApcfjG4NsozXWiq2ByA8jEAm6eLd43RVU2LzYF/MIv3Oe5O7O8I9xiSAchoHlJI4GOQ9+J6e5l03Bb28tPj+/8zKpFfxoi2oQMA+c0g8zt9JpLmSLKjK2oVHLSOuhoFmWhIVL8iMdevYYHeGm/Q5MKxI6hCxRTSvXLp9GkYPyWfFduJdsE1pEz/TAKq7YS32Fg86l6gH76+yT5+XERh03R+Nv+zSFWpgbuBvYexwp4g8UrcTDDYKhiONsOaeFx1Vx1lbmuu/2zEgzMrBJxo5VWb4J6H/02mv1o4Jhuo1UT8NK1oxYDpSlh+71D4YL0TWgFIdzKcJOIbOOZTDJ9EcguDDD0UrcN9fz7xJEqYr45dm3rxfTeF+ktxRB0pGBNogtoWPKnZXNMzTKvd6pXkK+xTGca5eSvL4nu6yPJh1mRVJ9D7YJB2xh5JjpjRSS1qnymT26poUSmDFmg1xSO4H6CIBZmcszOfUuA5xIiN79F96IlX1S4h9DpzPi8QBc8UOOHpqgi60l3AuIrkk7LhboDnu8kYE8cdEdw3uOi7bWITSo1UV5ZZcQnW7rE4gqUj5ZAIosfyuJA8XNcIkQsumBI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(136003)(39860400002)(346002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(6506007)(52116002)(478600001)(6512007)(38350700005)(107886003)(2616005)(6486002)(1076003)(83380400001)(26005)(66556008)(66946007)(66476007)(36756003)(8676002)(8936002)(6666004)(110136005)(316002)(4326008)(4744005)(38100700002)(2906002)(5660300002)(86362001)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CiE6ucgcoCvobhtpNGW2wq4eGCmqYr0UXFj5BEFECVxRG3tx2MQFTXEna2fW?=
 =?us-ascii?Q?eOvbWRUXC1hbFy3L4XrGGZe3+JhJ+RQuMKnnkGK6Uvo2LiK9Q+7cux283/d3?=
 =?us-ascii?Q?KEJjEAX86hQlu6pf1r/goPiT4pwUc0oU1oq3jFnjQsyp1UI9qHQn7YAZyi/d?=
 =?us-ascii?Q?JQ9h31wlcsyTvIKRvZu+tc28HFJccbmr2Ijw+AqjnXz2aGIZSJ7uweIBwTYj?=
 =?us-ascii?Q?KHS9TfQM72O7qOUvieIBPIj+CtKmSDZ3RGaGWyMdKAw05najOp6skLYaXRSv?=
 =?us-ascii?Q?mZ/HJrsWayEDDtxUxeKIFRDE8jV8enVzPf1qS6aq2ah+QAYqN36FBtyN8XXy?=
 =?us-ascii?Q?7Bd0L/ku3EeFN9yA+Qi1kmxApekFR0WZoiVFfQ5tHIZzQlIg+dVnaHVS0gXx?=
 =?us-ascii?Q?o+kIAQQp2Q7kbY/29/vXSvTbUD/cL9eiKJ21wrAi64Y34bcHpgZXliUR6G6/?=
 =?us-ascii?Q?F/jbFoOqm5MPMONXMhu9zTObroZ/RohWX86jJkPeVPIfLOpdMOx92aOO2A0U?=
 =?us-ascii?Q?Z6/f6yr/i/hOobd2VQeM2BrALGyOWmE9F/6V4WjSz+aRSbOZNd9O2e+cirNq?=
 =?us-ascii?Q?PHOszl5ZJ/w6qTPQw612n31BLCb71qGNY6S2pyra1CEcYXEh4H8wzWb0plm0?=
 =?us-ascii?Q?kIU9sjqTaGOjyPxKwf3y2he7Y+7GsYgDxSRWUj81wqGKUOwkuGDFrtMnpQzb?=
 =?us-ascii?Q?JB2ovfWE/Hkjl7fOlPUt2p9F9pHPwiQNpI8ukLX0qFlug2gFeN0iebmT4bSd?=
 =?us-ascii?Q?RVQxVWU/m6o28iL6rWQ3Su/Y6otup+pvZV0DyMp1g4Y/bc2/twk6GmtOjmWh?=
 =?us-ascii?Q?PClp3HN7tJ5usM5R64igJbq2vZfvpamCoTp51BpxcL4izEfHHiHBiPAkd/mB?=
 =?us-ascii?Q?EOkkY5CdTkg6CSE/eoT+XD5qQ5MevtN0eSEkAOekmtxFXV84bDUgV67iD7Yt?=
 =?us-ascii?Q?zXD02NUEBUcUWXSLRiOqebUbEID6nu9rS7n2MOLoHjUyZuQun/UmMM5tAkEv?=
 =?us-ascii?Q?XmLKtfPO40jaR108rnaBP7AdO/UopohP4NgDy38o52pEApVJCPt717ew4fnW?=
 =?us-ascii?Q?luPjbw84zRmZbD/q3M0y+Lao6NtlfnEl70ZfnBEAD61GN+nDP7Zpg0aIrXuZ?=
 =?us-ascii?Q?wKLE8JGwVrmteOInxs2UT6GcxNtxT30hx9ik0IhyQjxNIcetbnoB3SJR1928?=
 =?us-ascii?Q?Oie7PqqeW4NMRa0nsV42zpjxMo9oWaMD1tx7PUTPHoK5Uua2YetBlJuKVsln?=
 =?us-ascii?Q?RjGLvsJkegZdGMji86u52HRnx6vSA9wD3BOvaK2bN6klC09R6tXmUV4OijL6?=
 =?us-ascii?Q?e64fhbSd3kij50I5xELeQXuwGFUsq7CJEeMmFO070S1pZ7gBaehcvmmcaNnO?=
 =?us-ascii?Q?KHsrNA5o6lfQcZTXkj1WxZk7NzjxYiJ7XoDvfdFJoi7Hku5IPfXC8FdHNSGi?=
 =?us-ascii?Q?4mv4P5Emk7/3lXJoSA/5gXnjgnI4dPmljmeRcR5ayixxfglB3uHCiAdqqkdj?=
 =?us-ascii?Q?mImj7zoNMq7Uso83YWqtfSjwRKZMXl0+AJgKqQ8J7rTUVpMfXuXqKSuM+gSk?=
 =?us-ascii?Q?OzO14Jb4YK0yQh46rvwORg0j5WFAh8v7euVuGKWD?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2c2cf28-e5b6-4d60-089b-08dc10b97515
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 02:19:50.1055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gKhcZmh/NgXh2J1cbNLepX/g6KElvGvApOetgS+wBRDn0YUjvKnxyznt/ate1uFobBpHiTcoA1frQIwROOnPTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB3940

This patch removes the debugfs_create_dir() error checking in
iaa_crypto_debugfs_init(). Because the debugfs_create_dir() is developed
in a way that the caller can safely handle the errors that
occur during the creation of DebugFS nodes.

Signed-off-by: Minjie Du <duminjie@vivo.com>
---
 drivers/crypto/intel/iaa/iaa_crypto_stats.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/crypto/intel/iaa/iaa_crypto_stats.c b/drivers/crypto/intel/iaa/iaa_crypto_stats.c
index 2e3b7b73af20..cbf87d0effe3 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_stats.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_stats.c
@@ -275,8 +275,6 @@ int __init iaa_crypto_debugfs_init(void)
 		return -ENODEV;
 
 	iaa_crypto_debugfs_root = debugfs_create_dir("iaa_crypto", NULL);
-	if (!iaa_crypto_debugfs_root)
-		return -ENOMEM;
 
 	debugfs_create_u64("max_comp_delay_ns", 0644,
 			   iaa_crypto_debugfs_root, &max_comp_delay_ns);
-- 
2.39.0


