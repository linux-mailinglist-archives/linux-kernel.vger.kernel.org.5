Return-Path: <linux-kernel+bounces-16946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B2B82465F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B30AFB236EE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D072128E14;
	Thu,  4 Jan 2024 16:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="BZsJKt+k"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2076.outbound.protection.outlook.com [40.92.23.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FD1288CE;
	Thu,  4 Jan 2024 16:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M9FoesxjhRLMYSzHHadrBPW+S+mFJ1IWSps2is+g7b3yM1/LNrajGeUPq6Mb1Qr82MK8c3a0aml5Qppw5Aeusa/tq2h531cSSEzs7j86AWZRlbGBgrCZmxpDnSxZpAKSyVoY6R/A8AaZY9e9x7nSpLR5JOkJgCUSY9blRQtTuCa+zejEkFWzv1Pl3eiY7eTu8mvlNow7uLoOGfxcDBCapUlFDErlZYngBTSrY4298fxuUy6dCk5jiiAvDJEK/ng7wsRckpY80yhOw2csbMOngP6glBpuwD6iiUZY4AE96QkdD+l1gchgdvWXetvl1Qgg9KNQxuDBMopoHNeFHuYzrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BTWLBrb4fL4nzNjk3Tbhv6WCgSXloJeYw3KGYpXWzDY=;
 b=fxT8rdkb0aCBxRkrMBbzCTx2vQOhehe5vXUAxigYB23lqb+oNR4NpMO6vqHelRqMN799T4jDPyDHPZxWFWHNjST3CtDEoWbM5DuqY58gFAoUQ4EdMwPHXazyj/POXSQJBj1eJlCfJTHAJ/XB3xfAwLQQ4tO8EYkwAB556t+8DfmWnTu6bVZRbA4sxSZzQbSlWd0WWR6NZUwLwui7oEAeFBsrqgPam6ZnkMUxoMV+BqGhybiirPyfxREcVck/JjhvxHDaXRBH8yPH4mNvAwKStWnLsS67PEnx0SsvbbjVIPWKyfnEWJm55LkJ994zRfsEJt14SJAG0VDxfroGfeehVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTWLBrb4fL4nzNjk3Tbhv6WCgSXloJeYw3KGYpXWzDY=;
 b=BZsJKt+kADfa8MY5wfZ2mqKQ4zwI3bvS+//kdOO03uAQ8CRlziXdx8rNWYNEr1qPkAl8ASSUxK1z3AdDRpLQ+0dMTPDp+WFVz3JMhMFDKTInZJ4R388+pX01hoIWCdRDMy/DSeyzDIlCLPBbD8bqwr+aMq+f00FBfO/9scrrAKS+tqa+fFEw0obz/5sbGCzSOu3jfGmqKeDyqdFIlfCxkQXnvOnl96rl3sKaw93TzEhxZpO0QwO4EgnAnkSIZAWZoGkrRIw0DKbF5A5CVgrEzd87en8yrJz2g4Qxgai6wdIBlmqHVgWZBhI4MnP1WBYIOhQYaufGz/lG+x64fXVNyA==
Received: from PH7PR03MB7064.namprd03.prod.outlook.com (2603:10b6:510:2a5::8)
 by CO1PR03MB5906.namprd03.prod.outlook.com (2603:10b6:303:97::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 16:37:01 +0000
Received: from PH7PR03MB7064.namprd03.prod.outlook.com
 ([fe80::9ca4:4c22:a89:9a8]) by PH7PR03MB7064.namprd03.prod.outlook.com
 ([fe80::9ca4:4c22:a89:9a8%7]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 16:37:01 +0000
From: Min Li <lnimi@hotmail.com>
To: richardcochran@gmail.com,
	lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Min Li <min.li.xe@renesas.com>
Subject: [PATCH net-next v7 3/5] ptp: clockmatrix: dco input-to-output delay is 20 FOD cycles + 8ns
Date: Thu,  4 Jan 2024 11:36:39 -0500
Message-ID:
 <PH7PR03MB70646F26958F96D2229424EBA0672@PH7PR03MB7064.namprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240104163641.15893-1-lnimi@hotmail.com>
References: <20240104163641.15893-1-lnimi@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [kwEHIb6Ex7SfOdj9bFaEFur/uyAZjZLEh+Dyn8lx3Qs=]
X-ClientProxiedBy: YQZPR01CA0095.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::7) To PH7PR03MB7064.namprd03.prod.outlook.com
 (2603:10b6:510:2a5::8)
X-Microsoft-Original-Message-ID: <20240104163641.15893-3-lnimi@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7064:EE_|CO1PR03MB5906:EE_
X-MS-Office365-Filtering-Correlation-Id: 5748f0e2-282a-4397-b0bd-08dc0d436004
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jslxLt/Hjq9WkiaDh0QivVWLftFpRcBMafM4zviIVXtzMf5EzBKUx1Ris9/a/nwvKsyNVfWPMHtl0TuheaVglUFrtt0lLjFH9zBLviZVfw4F8Cv3gRj2kv+ETeRexWGUvOrkhWgsxrv2xuwqjNLkS+nghnwwNDyISooUJkr8FZOmoSKhXzxgj6wtHPbhCpzZzJFIFkUbAmzLXXGx01NlfkkOiioRmNgxA1lTXEzIgkpBev+lqHG17pYpylm9qlVqm4Mmz71Dn/IIVrZf1Lywk1zxszaZK4UyfN6K4mQr7u7q4fw4gIdbs7CI2ArZ+IZoFvgKJXx3fV1LY6hg/TbXe4nx4ZUZsUOkaU65oYZfAHjbDVkUjpZ1GAHryK5v0/Fc659oteQuSCRFaxZFcrpqSSkL/MjJO7cX0mbWyPjRMoIlmEqsAy3zk/QrdCSLGGTdUbMHlzJSMOdVeJYuGMPHrdF9ak1fntro2iIrpO/ceMp5Z44L3cGcaI2411DVbcZ6h5It22y4CgbWu/aa5S2og+OZaiRFcJ9dzt2PXql1U3B7NrlrOYO4CcW9NPzjfPqP
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i9Q+yAIwbmHRw2zFPCKUzYl02eyxoQ6WoeDpK3u4ijGKXPCzQP8cPtvkNxDO?=
 =?us-ascii?Q?trdhhdpOm4uuqjRuKCBsj1ilN3hb9IEBebk2oyu1sw1NrHDBj9cKaX75FNq6?=
 =?us-ascii?Q?6UtHtCIKwgGA4zZ2Ta1kep8acSmSxv7j3mbtYXiQeizGx7jcdRjIOUbZyHWF?=
 =?us-ascii?Q?atF9n4sCBML0Pd7IbeHpCXjxc+hJ9e0dKDMWNIMquiu2febDgpPeKMtcDyPP?=
 =?us-ascii?Q?Aj7U7UZJtrRZDpevfDG5e71EIfVjbQ4cjItEE3LJFAL8jkdL3UCO3b2Jyvg8?=
 =?us-ascii?Q?0eXHwo51CsyHSYpOgrL3zS1aZ2wCcgZbuvTZzULce2XA3jH/hZjaYDhx9MQp?=
 =?us-ascii?Q?9SbSZX3MTKcsbNiukMlFReFahTyQtu66YozK/UaPNRuUsX8tBBBNGjYrhsmQ?=
 =?us-ascii?Q?JpJlOeEbbg46zfReXZSKx8pgj75pPRyPWhoruWnfi6svc6cQQA4C6SjS3ayM?=
 =?us-ascii?Q?1g7Rv0k3CU4bPvD1W4QusyQISIiYFfnCqJ94rdf5r7YvGEDQ5b7Is0ZJQvh3?=
 =?us-ascii?Q?e3BX1nhBB61BDSiivywoFhA7cyIHKjcsBlPZ0bdn2/a9nNJ6NnpRQ4PMiTMA?=
 =?us-ascii?Q?BOAkO0AlGF3roIFxi95cpgU9vU3joypgf0hfHlBXOkOWzPAuOFotoebYcMHP?=
 =?us-ascii?Q?iShIdFydrHFGQ42gssnUdCYaRSl8wdY6D/f0bxtmuSgZSjRd/jnjeokkU/wY?=
 =?us-ascii?Q?UdlioIOlki4SIIOucjr8HYXA7VmfFmfUAFZvArMX1A4fFEGMKqRLXPWlgt36?=
 =?us-ascii?Q?f3kLf2zcVveVrgkA+GNybEtukmFSWBp2OO5SukiTA7bZ47pRz7RzQkzk8FpJ?=
 =?us-ascii?Q?RsUwakLZSkTBeJupbbomEA7n4GA4UGeZ6yp+NkUy7sAM36i/p1Qk1TTpPUsx?=
 =?us-ascii?Q?apM43idCqeplfX4mI4BC3bmooS/Us+doW6awLKcQ9ZY3lpmEtvjcyxux3RqA?=
 =?us-ascii?Q?m6uAYzLKMhflv09NdX3RGLPhttBWP1WLlPtjjElE4GiZo7I/i3aiP4cYekEQ?=
 =?us-ascii?Q?SrdR4H1+MdRM+VdmdK1POsiwUIKX/q+Zs/Y+T/dyKjqIFAV63eEpUZI76r0W?=
 =?us-ascii?Q?UjqqO+7+FNCz1xjV09haY+QKdCm3i0yXQQ5Mh+DbFXS3kZYREbEyc2K/FM9J?=
 =?us-ascii?Q?ypxl6/GV2ozKT+qmBUWI4J+ZvMqQ3vVsXpZSsPkTOr8O64Bxefnj6r7UUVx8?=
 =?us-ascii?Q?ePKcBAv23XiPyPOhIoIPNUTGkvjZ3R0gDNSBIQ=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-839f4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 5748f0e2-282a-4397-b0bd-08dc0d436004
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7064.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 16:37:01.0217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB5906

From: Min Li <min.li.xe@renesas.com>

Set dco input-to-output delay is 20 FOD cycles + 8ns

Signed-off-by: Min Li <min.li.xe@renesas.com>
---
 drivers/ptp/ptp_clockmatrix.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ptp/ptp_clockmatrix.c b/drivers/ptp/ptp_clockmatrix.c
index d069b6e451ef..21f3a2c179f5 100644
--- a/drivers/ptp/ptp_clockmatrix.c
+++ b/drivers/ptp/ptp_clockmatrix.c
@@ -2165,7 +2165,7 @@ static int configure_channel_pll(struct idtcm_channel *channel)
 
 /*
  * Compensate for the PTP DCO input-to-output delay.
- * This delay is 18 FOD cycles.
+ * This delay is 20 FOD cycles + 8ns.
  */
 static u32 idtcm_get_dco_delay(struct idtcm_channel *channel)
 {
@@ -2196,7 +2196,7 @@ static u32 idtcm_get_dco_delay(struct idtcm_channel *channel)
 	fodFreq = (u32)div_u64(m, n);
 
 	if (fodFreq >= 500000000)
-		return (u32)div_u64(18 * (u64)NSEC_PER_SEC, fodFreq);
+		return (u32)div_u64(20 * (u64)NSEC_PER_SEC, fodFreq) + 8;
 
 	return 0;
 }
-- 
2.39.2


