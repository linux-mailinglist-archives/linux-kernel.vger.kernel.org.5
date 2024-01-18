Return-Path: <linux-kernel+bounces-29665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD183831175
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 03:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B155A1C2244A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 02:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580AF566D;
	Thu, 18 Jan 2024 02:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="l5iFaVOy"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2013.outbound.protection.outlook.com [40.92.40.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD8AA41;
	Thu, 18 Jan 2024 02:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705545353; cv=fail; b=N1jwIQirJYLNx5gF7ri3hOMmDEr6RMD0QSYwxQD8zWwqVuMg6Qp7/Gr+KvGTJz1qoPDr3N5uxfSnQMqNqAiIKBKlwiHEB5xGzdhDpvQs8Naqiqk3wcwYrKEflIGfNcwg2RJyLvE2hAUUwOy9ZsBw6acG42fLkthMDCYm5x7+nA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705545353; c=relaxed/simple;
	bh=c6yxwPPG7wnZcgsDwM+aYKHX5h8J9UEVBG8asntiZjw=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 Content-Transfer-Encoding:Content-Type:X-TMN:X-ClientProxiedBy:
	 X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=nyWKqwp1L5uqOG2dxp/8Eo9CXT7/YHDVkSBf3gkhfMnp2C9pG7tDgIbhjP1oXuF8vsUpuRgEDUR8ZkPVnPRPnfnQgbdSXDSUJ4uOCEO2syjkZ6W1hDXzy++LuhbdWa1YESNUz3fkzT49Cl5zOstR8ho2y+LRvwWbOwcF5XPwO7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=l5iFaVOy; arc=fail smtp.client-ip=40.92.40.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8acNQwXLUtRYsEAQ47PUTJ4FmTHdQZPDEBzETXThnFW/WFFWYUex8FhoE3jkzKyOmUAglhY4lUjDi+wyhRdj3lxmGeYnYxwnDe5wnLSPdQobGRXiNtG84uHT7OlKu6IJBJKmeMe9FbVv2P3Uk4SJ141vmOgv80TjdtkzcFJxlKkJig0xVYBM1nU9PYSqsGsXM76B2fmnglbqpruGPy6Wm2PAxCOO1tIcVYxxM4Ic1lWvw0aWn6pvYXdo6GQCWbnQWqVX1lfQC9eL60VI5KiCNOhk52o2SqbI8F4Y5H3yv8PZG/m8R/cgj7JUvVrqHzIm1E4Dvxp7LBAiCPQd7h5PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a94PkpXNSUiteGKAQ8Qo4hKlmojZWaDiFof0ibNkViU=;
 b=ODtnP/iAgnPMqvE3BK48SG0Z/hHMjVP+vERTaaubBHyHOGvrm8fpLC/7NV6Ub8VMNbZVhkPaNNzGmLVW1AektLDa22sINqyKALaSBLoWcy55ATaVq4it2tE6K5XPZF9psgE5auS8X1zI/SNAu1V62ycURAuapzzai9zuvFUMAnDWTaH4LTYeceMfhuvmky4BDEARcnDRHRIBvXHizcy8DZZ7XUmOIMn1Tjiouwx6doNPH39znVkiP0nqBmrA2iZbzrzrUmtBiighT4J679XrjDaeyKQY9qfWQ15Rd0wMJUV1aaS9NWUzDOxWiLPpePPO40ben1aeM5rXRF5DyZyg4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a94PkpXNSUiteGKAQ8Qo4hKlmojZWaDiFof0ibNkViU=;
 b=l5iFaVOyO/Gio9wM5tZi9BMibSxMEzvBWFWFJB4sRwJaBl3Bj4OIz1GM2WZR6gn/Tci/N+E4aBe37iD6sb1b6jrky7OaCiu31bGwdy9A3oFQ2iBGU4MxYRkDMJkgK6lNUauFbkMdj9FI0bSIHiXiPoOx9ZIyCZyftyaxqsBPm4tsrQWLGC2nQoVWJkvqCzeJnCG8Qtt6KiTRsll6ndIpr68ujJfRx1E9REkLKus91cfZSWpLtNiMeGr0uT+6/+dwoKKqce1HgiHqACiReT8mvV4MWFay+UoLCtUP3TzQmcv8T5r9qyWXzOeCvniZ1j1Tb6P4u5m6n+zZeeCgcR8ipA==
Received: from PH7PR20MB5925.namprd20.prod.outlook.com (2603:10b6:510:27f::21)
 by SN7PR20MB3632.namprd20.prod.outlook.com (2603:10b6:806:100::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Thu, 18 Jan
 2024 02:35:49 +0000
Received: from PH7PR20MB5925.namprd20.prod.outlook.com
 ([fe80::e1de:29a8:e090:5b7b]) by PH7PR20MB5925.namprd20.prod.outlook.com
 ([fe80::e1de:29a8:e090:5b7b%4]) with mapi id 15.20.7202.020; Thu, 18 Jan 2024
 02:35:49 +0000
From: Fullway Wang <fullwaywang@outlook.com>
To: tiffany.lin@mediatek.com,
	andrew-ct.chen@mediatek.com,
	yunfei.dong@mediatek.com
Cc: fullwaywang@tencent.com,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fullway Wang <fullwaywang@outlook.com>
Subject: [PATCH] media: mtk-vcodec: potential null pointer deference in SCP
Date: Thu, 18 Jan 2024 10:35:06 +0800
Message-ID:
 <PH7PR20MB5925094DAE3FD750C7E39E01BF712@PH7PR20MB5925.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [JzHoJx8fWssohCEankRxf52fbzHIc2EH]
X-ClientProxiedBy: SG2PR01CA0176.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::32) To PH7PR20MB5925.namprd20.prod.outlook.com
 (2603:10b6:510:27f::21)
X-Microsoft-Original-Message-ID:
 <20240118023506.93419-1-fullwaywang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR20MB5925:EE_|SN7PR20MB3632:EE_
X-MS-Office365-Filtering-Correlation-Id: 23da0804-5649-4b15-1ef5-08dc17ce2ebd
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nmoz+yhThhW0LqvaE5+DWyqJEL9gW8Dq7xbdRbUl4V8zULkVX201XqwwneVhV+BIg5upzZEqZCYujkSa0ZYncnr+KH2fYKjBm7jQMqdG9ZSoN7+1qtG6wGX8ZdkvmNPf380ornJ4NISn91dLS57jtt6rl523pzqOMrvOl43i1ULRP9+tNqBmY1qQQf1TPs0jNn67tQOXl8zDDZHQq7cw8okGwFsQkKDRtjhmm4L8gctB2T/d/16g4tx5WL1rEA8DxMwqgRPFE8Ro5eI893USIdHH8fFSR4zG7TG7+85hIn/MSSVI1Qxu1Qt5hwocE9RQCHxVry48SA4J+lSm5OZIB4aalDfPhf0XjIuZpLo4J8fC6T5eQHEx3Ctay4P1dvdN2bm4qbK7yy71wVUvN9/mXm4fAUd7iDRjibLZ7ENkVk6UFVDSw+tvWFgLbzsxlXmyZ863/vqsDIi6F95n/yg/wQxcMR0/vgfXEr1XSOshQWO1tFpKgszM8/B2uRqWaNTlHn7VV4IQyCr0c/Xqwprlb+GPGQwFuz30Ck8LyJdWA9bbh6hTbA4LlIVEriU4kILgWEaTypy3PwWioPtqkzBdSKip0RPgGcAKmx6fjHAKACye6es95b8Kw2YNx4p65V+q
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?njQURJhj1WNoYRcExiKpYYed92a1s2nHDRL0TchmnNIIz2eL71aqBmJvhoTy?=
 =?us-ascii?Q?WDq/p+6TtAdJsQ81+EhFqTcKBOV69y7x/JGleUlcbUne1OWMlGPlhaMVicmu?=
 =?us-ascii?Q?D6ihjkt1BCXeY9CkzjiJs/1sVeBnvZDmIiERe5eWsaBgtf8ZdzWTp5lvTN2n?=
 =?us-ascii?Q?Yqlq1fHvvs3uEvq158GXhtZPFph3LrdlrJZolRgK1nIoA83vl4TK2JinK4DH?=
 =?us-ascii?Q?ZCh7tT3ObxH7INRVOSJ8LdkenY0pg7hn7fUXhzrYKtsJKZ8paFkBywoFKwFu?=
 =?us-ascii?Q?8e8NulTrZo7ofO9mRh8dANLrIYUnsakXXC0OhATo3Nc9bNE3Zyh3iwsvrj0c?=
 =?us-ascii?Q?aa845cwQacYQP2UfnIdIg1SkkkaF8GC1wDrtwwndSg9menck4iTU1ogHNgP5?=
 =?us-ascii?Q?SZgce7vERGECSzhFY8kjfMVs8qn3OxOFL7ChWuKRN0fEaR53mXNGe7j3Fjzx?=
 =?us-ascii?Q?Y4PsyB+hFIo+9nrQcQZTZmLIEnFH7m1Ytk/8bg+NXOl+GNC1WN2SMbW5imNp?=
 =?us-ascii?Q?Rm2IUpFB8fudcj7paI1/aImeqJpDp48aJ6PhS+R4QNYXekpTtW2BQuFZZAQx?=
 =?us-ascii?Q?W0iEk3aLUeDUEqo9IQsh89oPmgzu+AbIwlA/4iHtbAzUyPOfHd1EFGMMbxZU?=
 =?us-ascii?Q?ftEOfJYY5gkLFnuGVzTFloW+KpMKqZnBCyAzpVWCJPhN7z2wl3xaBtQYAG9r?=
 =?us-ascii?Q?zwJlzA2AsGEzGwTGIh6IxFF/nH4ovgdxGSkgQfjKuvh1vImSNNJCOsy4HTrF?=
 =?us-ascii?Q?4+JZhrJgT2sx+FH7U78Y8NftmJJqcviq90qPj7cxdCIArGIS1JAJlcRPz0Eh?=
 =?us-ascii?Q?+gC5eVenKOvKAMTIALQfV/0r0SE+1cJ6ugpMDx3EoF+1fx9UrDCEQvxyXXQ5?=
 =?us-ascii?Q?/IlGDiRdxqXFmAKX84XTEoLQuy1cdPIjtTx03jlmD+BKTJ/Vr0K0w4IGy1/m?=
 =?us-ascii?Q?swwuqSobKQ3bDYLbyS9RiN1ha9cgEe1RA6Qt6aS1/fPHwOQcyAc2KyQudLvg?=
 =?us-ascii?Q?Mgs/VCj7UYIAPgVQC9U7mrGBRhPsfDI7w9+iEyEYQQ/zUgawPgT8ImlhBX6Z?=
 =?us-ascii?Q?rp9pP4ZRkYLHZyIv7Jmc65rrZevU5Y31IP4gyNSq6Qhn0AZgHkQma14nh62M?=
 =?us-ascii?Q?9BxSDdwRv5izSCxntmJfptVigluOKR5iCCiLP2VSdqkrWOgOOtinVw44/oPE?=
 =?us-ascii?Q?Zza5QMiFyRCFrAUMJCdFZRYuK5cfXgnL1nnZ2xQ4gRhazETxQ2ZO2BwBJQA?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23da0804-5649-4b15-1ef5-08dc17ce2ebd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR20MB5925.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 02:35:49.8719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR20MB3632

The return value of devm_kzalloc() needs to be checked to avoid
NULL pointer deference. This is similar to CVE-2022-3113.

Signed-off-by: Fullway Wang <fullwaywang@outlook.com>
---
 .../media/platform/mediatek/vcodec/common/mtk_vcodec_fw_scp.c   | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_scp.c b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_scp.c
index 6bbe55de6ce9..ff23b225db70 100644
--- a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_scp.c
+++ b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_scp.c
@@ -79,6 +79,8 @@ struct mtk_vcodec_fw *mtk_vcodec_fw_scp_init(void *priv, enum mtk_vcodec_fw_use
 	}
 
 	fw = devm_kzalloc(&plat_dev->dev, sizeof(*fw), GFP_KERNEL);
+	if (!fw)
+		return ERR_PTR(-ENOMEM);
 	fw->type = SCP;
 	fw->ops = &mtk_vcodec_rproc_msg;
 	fw->scp = scp;
-- 
2.39.3 (Apple Git-145)


