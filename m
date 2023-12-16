Return-Path: <linux-kernel+bounces-2117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A2F815816
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 07:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F3F5B24519
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 06:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8DC18032;
	Sat, 16 Dec 2023 06:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="L2TWhCIY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2046.outbound.protection.outlook.com [40.92.41.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1674917988
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 06:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IUEoRxK/cyZSJlVSZcbLwEpfuvplOsKQfTdBgBe3ooapCE1jxcm/qd9Gxpa6bDflfDeysdR483K8eunBaf0Ua2QEDjZkvS3ib1rO03jpUhcecxCRDHJjroVOqFCP0woGNqAbkd9dexHQQJp8nI0WmQsu9ZT1GIrRNvDNl6x33zmW6GFJvqvqhgJ0LHxevqZPww3cYzga2j2OeYmz06SLwtCQJ4hsiGadrv5uTEeUNdvdMLEd/c2N/z9zJZwqP/3DNbWFOIfCSY7x/CE1+ezHZ/8FoOnRer426KJDCaizGwHvq2n8djFvcUjO6p43WcOiyafq0zOP6LygvZ4t6C4ACg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U6tFmfaHgHWt/aRpl7eujbZdSG8CgkdHR+eCB8LKf8o=;
 b=bBQRHjSErDexgGwOcEDUEBJok/UTjGsGdICyP5qfHlYmidALSLjm2W4fRgs2FWCjgcJjKN+lTi4l/2kFg8Z2Y6nxJNrdZDQ/QKVQzqTRlt0k3WnwMYUhv0fSSYpZ1eXo4oYng51F7pV6ZLeVE3GBvcA1D6YwyJtOFb1NSVdbxQRmHcMsLCtA+njLOmgKiX24syAimi3p01YcfBUm8BwTHhUCShemvPIhF2MQOdag4fGAC6Ml+wX17sN5Bwv/YElltrtdtWDpXrIIVrJPVfD+iLvcqf2uV+XQJ9b4nRjTnRm8e/xOruA2hWB9vzjuhMWVMjLhQybstOhYlNIJvHa9Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U6tFmfaHgHWt/aRpl7eujbZdSG8CgkdHR+eCB8LKf8o=;
 b=L2TWhCIY+xlSGUoJZV/LxiM/4JL1XI5McNfMj1bdSlED0JzcfLOO+4LEdQYzwHVSMgu28OtQ51YpUQzeyU9sgArZT1xWDEzjdKkGV+sGAE94aAl23D4n+N7++YRulH+heIgAZQKE/wvtHpUGjW9dnh087gPMHreDBGfhpoyHBrj5bfs/z3mXm3DBTplOIRoFmJWeY3sEJK0E9iRWHCBEyF7h7xIzaasOIXe3Gw35v+WZvsg/hUni4cRfaoA4MXniPpEn092zXoJ9TJtDhSyUM8DcVJrQzJoG57vwN5cjMnT4u1XVUVGWp81D6+SoMJlr6HeP7jYWIqf8Pb3iJMU6yQ==
Received: from MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1e1::10)
 by SJ0PR84MB3287.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:434::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.35; Sat, 16 Dec
 2023 06:48:06 +0000
Received: from MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6761:2623:329a:27d6]) by MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6761:2623:329a:27d6%4]) with mapi id 15.20.7091.030; Sat, 16 Dec 2023
 06:48:06 +0000
From: Youling Tang <youling.tang@outlook.com>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH] checkstack: Add loongarch support for scripts/checkstack.pl
Date: Sat, 16 Dec 2023 14:40:54 +0800
Message-ID:
 <MW4PR84MB314514273F0B7DBCC5E35A978192A@MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.40.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [4a3FGo5Nwu10CDZchNzmeJZlFLEruf1uAK8N7+27Vrg=]
X-ClientProxiedBy: SG2PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:3:17::28) To MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM
 (2603:10b6:303:1e1::10)
X-Microsoft-Original-Message-ID:
 <20231216064054.24621-1-youling.tang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR84MB3145:EE_|SJ0PR84MB3287:EE_
X-MS-Office365-Filtering-Correlation-Id: b468aaac-32f0-45d8-4a3f-08dbfe02f4f0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wSEw7rC2yGqZJGcOI2dVT9DNZ9d+SwUqJ65D9/DE7fg5XIsVRqhfLcuMeYvjJZNbXnZjJHzuRdINin5BVEDboK4UggBMGpxKYINJ9OdDhSoPdnotFr6WfFUhZqMqsOtbTcqgSHYbHgHhTZ+XxWbm7qUorSdkxUxGOHStG/UXQuSblKubXNKaEjhlnQwF5rxTDfkW9Uoy+K2JR7KzsHDeZ4JLp24x1H8yLYsOeC7y1vTREJX4PbbovVp4+sXptXl1lHixWuXjsHKSnNh0U5iPWUGFXXQAWPVf6i9omJsH/7s6dowUHTn9uNZAvurSn3lRlT/D6/orSlnifHYir+a1Aij4fuOu0SJE2sQMwROV4HSXKZ9KqdDSubqeFDcs2JPk1JxzCy70nQkrAlGt2qQQz5qkS/OMxeqYGE94q6kBsGcuAG2BISKxHpDM+pI6+XbXIL0bk+3gK/A83drBc/XbBLpnyCCWPN1HI2XLGu1W7jpyrufnsZGDL/oZ2onCllQL55CLpj69w0yyHhovgVmMf4v0l+2PfQa9fnO1zDNd2krRyyCFvUfRFeNmJbDvpa/W
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AvH6TUeFtNGjvBN7lpYys9SZL2yV1lPn5NQIxf0TS2Nq50vulzuwX4EYknf3?=
 =?us-ascii?Q?2vyBE9o0c9dUYLJO0iEs9IpHf6scxLxcXpXr9uqsbFcseP+hZAFwg/awxB2h?=
 =?us-ascii?Q?4hDJef5jgt/6f8EciJSn8r3QtEfbI7iz4C0tWBkPj/EGj3wAC+w2FdXsnC50?=
 =?us-ascii?Q?xM3Rpv38ul/ACOq+qkSKU4VeM5SfZwZk2Hn2BwHFMLXU/ggmf2H9Xg8sAtLU?=
 =?us-ascii?Q?IwLv3l8Xm/pGlBUGBcVUNecKz2vSA2NtVuulOTfpBNGeadcfo+iXtOgOf+sO?=
 =?us-ascii?Q?usNwEpNIkaGpSBX8iQW47fSFUV28rj+SvJCYa9B5vji7RbTKLOTGFTMrVNKF?=
 =?us-ascii?Q?F159OWZYtGxOJXaRjz8e6xY8M3UHA3o+uP3G1TrkFN3w9K6h9zCHR847bnV2?=
 =?us-ascii?Q?RoOQg0tvPETmqQfCsEPAJuRkb3LJJnSyABSa0wKS3Zlojk9xK4Mf0rgX4u7D?=
 =?us-ascii?Q?OnjTWZf+fs/ntQBNjwCqaeENGIuKpU8LEPtKIFk6+ceYvDNLwOznw4iAYS//?=
 =?us-ascii?Q?h1iCrUYLOePtxdtePhGbjAYrqNdUSvvWO0lbkJQIMVd739MBRzWCc9J2pzGG?=
 =?us-ascii?Q?S5zFyKHWs7XFuZII+fnZeDF/IV5Hk1zNK4gpZpnCnV69I8H2/C797Pl60lc9?=
 =?us-ascii?Q?yGKxQ7cUsiyc0flzdRQIh5YY8E6aGiU95+cl+aTIRvkhnyKu6QNVDnP3JmQK?=
 =?us-ascii?Q?YRzV3RQhIGAr4Q9uuVffWlaTqmZxE90kke8Ghz87CCr4FbtF+m8m8p/8w+0m?=
 =?us-ascii?Q?N73l7MCZ5EY4mQddgVQEF1pPXloQHH5f/mHYs3kUjwOvJNFYx+gC9lBZ6x6M?=
 =?us-ascii?Q?o6tFJvO/GCo7iRdhhxaiiUohYYVYMLO/RFr5nU4UW1T+CqxaMhu+EPVe0YEM?=
 =?us-ascii?Q?ZEZWCrdYtjsgUj2TQWz8Zw2viCBVXt10aW5VSCf44NvxNrLCggiEFLXH0snK?=
 =?us-ascii?Q?DvSjFQQjm4CatgP8Zzr+HzEaCQo1PRaUbAmGHk6/2FHUzClnMMiDcjY6rmm6?=
 =?us-ascii?Q?Xz+dQ2qwLXWs1y9sxqOeLDW7OmvgE6cIMF4azZdPwsnDa205TTKOyMvld+TL?=
 =?us-ascii?Q?jYU6ZuLCkv/5gcxKksFbrLSo6efQqyR3UyS/wVRaONZDr1KScAHrJNSW/BPQ?=
 =?us-ascii?Q?9Ekl5gwOiiaCJI2DNlP1WR9PgzAEOzGg9MWNNYA2pYuCgL3hqf3fwCVFl26f?=
 =?us-ascii?Q?4aQmPgbqPFdk9R73TX5zCBDRxhLf7M7eRUF3xbDPJ3g6NEf7WSVddRG1G3Q?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b468aaac-32f0-45d8-4a3f-08dbfe02f4f0
X-MS-Exchange-CrossTenant-AuthSource: MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2023 06:48:06.0130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR84MB3287

From: Youling Tang <tangyouling@kylinos.cn>

scripts/checkstack.pl lacks support for the loongarch architecture. Add
support to detect "addi.{w,d} $sp, $sp, -FRAME_SIZE" stack frame generation
instruction.

Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 scripts/checkstack.pl | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/checkstack.pl b/scripts/checkstack.pl
index f27d552aec43..e9d01b999b74 100755
--- a/scripts/checkstack.pl
+++ b/scripts/checkstack.pl
@@ -16,6 +16,7 @@
 #	sparc port by Martin Habets <errandir_news@mph.eclipse.co.uk>
 #	ppc64le port by Breno Leitao <leitao@debian.org>
 #	riscv port by Wadim Mueller <wafgo01@gmail.com>
+#	loongarch port by Youling Tang <tangyouling@kylinos.cn>
 #
 #	Usage:
 #	objdump -d vmlinux | scripts/checkstack.pl [arch]
@@ -104,6 +105,9 @@ my (@stack, $re, $dre, $sub, $x, $xs, $funcre, $min_stack);
 	} elsif ($arch =~ /^riscv(64)?$/) {
 		#ffffffff8036e868:	c2010113          	addi	sp,sp,-992
 		$re = qr/.*addi.*sp,sp,-(([0-9]{2}|[3-9])[0-9]{2})/o;
+	} elsif ($arch =~ /^loongarch(32|64)?$/) {
+		#9000000000224708:	02ff4063		addi.d  $sp, $sp, -48(0xfd0)
+		$re = qr/.*addi\..*sp, .*sp, -([0-9]{1,8}).*/o;
 	} else {
 		print("wrong or unknown architecture \"$arch\"\n");
 		exit
-- 
2.40.0


