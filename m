Return-Path: <linux-kernel+bounces-12009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A18581EECF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 13:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28E99283257
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 12:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED4644C69;
	Wed, 27 Dec 2023 12:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="L0ekbM4a"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02olkn2067.outbound.protection.outlook.com [40.92.44.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5993D45024;
	Wed, 27 Dec 2023 12:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U7kYHfcCCCk9NBVSQS7WDEQapeXpSiCpGfgb4RCaEh0xV6/YyqRrenin2hnw06QGKdVJ40fWj8b/Be3hwIj/jf9Xf/QMy2M9piFmre+bla/7ZYtOQkRoHtBkAIVIwCFYyV2rmCX0htHBNehCMVCr2FybjD+nor17bzH831QBTD2kFEdJ8Y3kOipBczFi5bv/33zZwZjhEd91tyeL++CvjQwzy4dDgMB+zkeVh4hDpqPbn5ehpiWX7HR8Kzn3HDSx/7FAeMjSTexKx6lpazt38nf3VzEhpureNFcQiEjxcLDMc6gtpCgp4fkMbD1cooCdEsBtEW3X+IVeBlwPGaDbxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8WKmhN3oaum3h6LjZNz9y6Z8Qcj6KEDtaGLhzDG39to=;
 b=oPsrWjk/j1Ewc9eBP13EVwtF/H6b6CppMZ8M5uJYQMVZKJ+fJG7lEvzil7dhrjofugKofTip2AEXsGK5mBTuQ1wzFrhIbxd6O7EHDW3M2MV/nb0vvC4+PVsHvNoRtQOvqTRcDESOm6pKTovngW8OrY37/cKI2m9zsaOyyN+KtVV2uam2YEUAKFc9tj65QHkpR3L6JcX7F0lFrow3sS6s2TqOFJFpGQajxMCVjXTtOfb0b92p4py0oDhbENy6GWEzvJ6AetYEvxruXm71fjbWer2Fcq6TVTDFRl/fILSBTsYp+PFccdbyXrmc/nRr9CMY1tADhEHOAAVvE6qNSc/YcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WKmhN3oaum3h6LjZNz9y6Z8Qcj6KEDtaGLhzDG39to=;
 b=L0ekbM4avvAerkWF5nHE9yZ4+ZuyOZZPSDK1JosL0DgtWTsu5CLpx1g/KWqTVR2Ad9cUm3/6GUnrZo0bet5Avekn+/926Os9DTxYLEwNTHrd+++VUwwg7gcuswLfFVHUu05UuE7ZQ8gqMfZC6iICZYbux2fbT26svdyklQGLOOzD6PGyrtf/JijrKufjgu002iZ+MFNrjatcGsfiAHGTQy0eGsFwPz1W0KS3futJa+q+3b7GfrQRmQrfN87eB85njipv0ZBv3KPfAMEnIhSD0EQ4oWmmXlHn/84l+qjGTuv/6aOL+sVsZ61myZwjZfrjyRhFVTZmLqkGheB30Y6THA==
Received: from MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1e1::10)
 by SJ2PR84MB3537.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:569::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.19; Wed, 27 Dec
 2023 12:31:39 +0000
Received: from MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6761:2623:329a:27d6]) by MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6761:2623:329a:27d6%4]) with mapi id 15.20.7113.027; Wed, 27 Dec 2023
 12:31:39 +0000
From: Youling Tang <youling.tang@outlook.com>
To: Huacai Chen <chenhuacai@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: WANG Xuerui <kernel@xen0n.name>,
	Baoquan He <bhe@redhat.com>,
	loongarch@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH v2 2/2] docs: kdump: Update the crashkernel description for LoongArch
Date: Wed, 27 Dec 2023 20:24:53 +0800
Message-ID:
 <MW4PR84MB31451636462DB3F4FAEA3C8E819FA@MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20231227122453.8108-1-youling.tang@outlook.com>
References: <20231227122453.8108-1-youling.tang@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [f0nd0XLLkSjQ3RafDmSuUUnnZ76rGGWvuhAJk5TQJIg=]
X-ClientProxiedBy: SI2P153CA0001.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::7)
 To MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1e1::10)
X-Microsoft-Original-Message-ID:
 <20231227122453.8108-2-youling.tang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR84MB3145:EE_|SJ2PR84MB3537:EE_
X-MS-Office365-Filtering-Correlation-Id: c78d6f71-e142-4c09-3715-08dc06d7c5ce
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yf53k3uOw4szmkcMbX5CFp8Wv9065HJILz8TbbOyCJRvgZIx/n0WK8sv93ZrOHw02xFi7NhoyU10qX6hhZbHiHPBcA2GINZPjMYwFPuCGNgKgXyt2Az+kD29VVNWfiJ8UKAHMUFSV2mqwHDMJK1EgxNn8S6bpN+flba/g5TgDjDtDIIp6dgIOh+oVZklrE3OGWRs7wL+Cs/HN17xrb6+uAZbast5QwPUg005+2nNWvd1lhHU5ay0LMpIKETcuE+zXFKIv8ptvl+stzMdtO635/c8c3TuY2bG32X7sMyifZULGXUYBwTFwVWs6Tc74SbNemEKSMEEsLbt2VyDpGpIk3YeNBPsBNCaGZx9NK+okjNaej/WpPSfJPrnuh+Y5CXnVJQdS+FPEy7yJ/6gePunAERiLXmjflIho4xPDc2ma6ghyZQrNnuHcyXuHdR53Vvm9as9O6eFlzg8KAkv7skC8K15hlHdlMWy8ZRLbu6HI23qblj9dzVR7oPUFEVW6HHTPZDAG3jL2LYUjTEEWDcvnsdbfg5emGwlmWIsOXWm4RyAGPdSG86ha2o3Dl77v5kQ
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?URw4ATaiS0EV2eomLohqho0xpWrsbpUz6FL1aY+Tf/oWQidMOHooW0be2KDK?=
 =?us-ascii?Q?MUhUoc3cvw7UGUGggR8KU4h6WMIO6MiUweA62t+180dn1SfxUOxD0thbgxrZ?=
 =?us-ascii?Q?GdhV5gwxyvSrXNBh+cuDgNZEdpPzbygHzPZ6G9h8K5L48228ZaaM0dqoudPd?=
 =?us-ascii?Q?IW3FuSQeclsVtlpcMO9DXGHY919OdVmTiN+R9vevwTnbXGvus3YGTO3PsSsB?=
 =?us-ascii?Q?P0xIGUQ7kn7ts7BW29UUcI1FLQAt9KlKq39zmwucNCjiQYJX8kEIfHzVC9S+?=
 =?us-ascii?Q?KrGrTprZmcDBJb+H7RShJFCIo9XtVfX0lqZ7AxXY2JwwgP7f4hmLApvicOxI?=
 =?us-ascii?Q?DLQ/oTkDfa5oxeKiCz7cMxyWt3+y3e7OmtfiwbzaL2K0xOjDB4DByILR1K3F?=
 =?us-ascii?Q?iHBGz/LhUJI0ciJ5R7dz7CqCg1MEWrfo6avO5jNgXcOXpOK3UD4BsjomdOg/?=
 =?us-ascii?Q?sNCWFTTygzFJqdPHLrI3PeLAuBk0BemQBujybkaC1OWRSuoBsAStpa5R3dVR?=
 =?us-ascii?Q?hvfU79SuN+0b09N03osksl7z6N/pSjtJaJEvnHOvCAw5vB3vBZZBlXsIRamw?=
 =?us-ascii?Q?Aj5fdRAdoAk0KQJ9c6UPBhcCXRIZxBcmi6lHAUNV2bb0J4KUNuXrE8tdVkYp?=
 =?us-ascii?Q?5cg7jH6syo1fSvqKuHKubPILvlLqkrokN1JA5d2ZvKAYj7gc2bfz0XqXMYRD?=
 =?us-ascii?Q?+4mcXTmig36WWVmnWw+AZuOPwi+q6XSOrGSWig7zbuEqxLkITMWWuhNlkKfm?=
 =?us-ascii?Q?JfHHu2dVz4sFBhlCyh8QnBQiinsMZ2Qzev9xkMOWvDbhvaeSVBpIbQHYWh31?=
 =?us-ascii?Q?T/wsGIAxBT0b97Qio8xRmshNGZMgOAwPQ7qa7ck/g9bjgWBDcNvmt/WDGXa9?=
 =?us-ascii?Q?pvEWMBM1I0O1GYfmdlzG4zT3MoMnD2VZKe1AxCDVniOX0eRo/y/NlCJGIsD4?=
 =?us-ascii?Q?9NiqWQxccogVBILU4Pe18P99t0AZeXro4qM0lOM24FMQOI/bLEBKNvpOff50?=
 =?us-ascii?Q?pwMtt4+Mb1zAYVqppuS+llxHRVv+8hwAfwOGcktO+/lZNKMewDL+ugE4tRkh?=
 =?us-ascii?Q?8uqYbpPvfuI94vX75W5xCWez9OF2RGJrIpvEahQ35/nPf6PfZP0KJYTbYBlL?=
 =?us-ascii?Q?nkapoS/0B0dENR+sx/9y8b+aCkg3RS1N8iQ4HLss5TVqqxhDGZPGeNBv4HUL?=
 =?us-ascii?Q?BRtQfH5mKrvV6LB08Pv8N7I6lu5lDBTAatJyIgp3VA14ILJIj6Psqh0nwrM?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c78d6f71-e142-4c09-3715-08dc06d7c5ce
X-MS-Exchange-CrossTenant-AuthSource: MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2023 12:31:38.9742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR84MB3537

From: Youling Tang <tangyouling@kylinos.cn>

Now "crashkernel=" parameter on LoongArch has been updated to support
crashkernel=X,[high,low].

Here update the parameter description accordingly.

Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 .../admin-guide/kernel-parameters.txt         | 24 ++++++++++---------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 65731b060e3f..f2633dd87a97 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -877,9 +877,9 @@
 			memory region [offset, offset + size] for that kernel
 			image. If '@offset' is omitted, then a suitable offset
 			is selected automatically.
-			[KNL, X86-64, ARM64, RISCV] Select a region under 4G first, and
-			fall back to reserve region above 4G when '@offset'
-			hasn't been specified.
+			[KNL, X86-64, ARM64, RISCV, LoongArch] Select a region
+			under 4G first, and fall back to reserve region above
+			4G when '@offset' hasn't been specified.
 			See Documentation/admin-guide/kdump/kdump.rst for further details.
 
 	crashkernel=range1:size1[,range2:size2,...][@offset]
@@ -890,25 +890,27 @@
 			Documentation/admin-guide/kdump/kdump.rst for an example.
 
 	crashkernel=size[KMG],high
-			[KNL, X86-64, ARM64, RISCV] range could be above 4G.
+			[KNL, X86-64, ARM64, RISCV, LoongArch] range could be
+			above 4G.
 			Allow kernel to allocate physical memory region from top,
 			so could be above 4G if system have more than 4G ram
 			installed. Otherwise memory region will be allocated
 			below 4G, if available.
 			It will be ignored if crashkernel=X is specified.
 	crashkernel=size[KMG],low
-			[KNL, X86-64, ARM64, RISCV] range under 4G. When crashkernel=X,high
-			is passed, kernel could allocate physical memory region
-			above 4G, that cause second kernel crash on system
-			that require some amount of low memory, e.g. swiotlb
-			requires at least 64M+32K low memory, also enough extra
-			low memory is needed to make sure DMA buffers for 32-bit
-			devices won't run out. Kernel would try to allocate
+			[KNL, X86-64, ARM64, RISCV, LoongArch] range under 4G.
+			When crashkernel=X,high is passed, kernel could allocate
+			physical memory region above 4G, that cause second kernel
+			crash on system that require some amount of low memory,
+			e.g. swiotlb requires at least 64M+32K low memory, also
+			enough extra low memory is needed to make sure DMA buffers
+			for 32-bit devices won't run out. Kernel would try to allocate
 			default	size of memory below 4G automatically. The default
 			size is	platform dependent.
 			  --> x86: max(swiotlb_size_or_default() + 8MiB, 256MiB)
 			  --> arm64: 128MiB
 			  --> riscv: 128MiB
+			  --> loongarch: 128MiB
 			This one lets the user specify own low range under 4G
 			for second kernel instead.
 			0: to disable low allocation.
-- 
2.40.0


