Return-Path: <linux-kernel+bounces-29759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CCD831306
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1815A1F2610B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 07:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B48B664;
	Thu, 18 Jan 2024 07:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="DPQ7ciQh"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2023.outbound.protection.outlook.com [40.92.18.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C140B645
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 07:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.18.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705562071; cv=fail; b=IO8hD9mmkukxv5dyDq2X/OhRGEI3iJNGBgsiDos8HYrC+oHD+OjBKj5DX0c1UFxgtacFrQXTqfD9D6nA35UsRUcdT5TNC+DxzfAU1wkw8Jswv8TA3Iq9ZgqY/1ylKLy71HV8y2by7EsAK8VNjtBBpMiPYy0KfOFwhCao8KJeiIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705562071; c=relaxed/simple;
	bh=mphpj2wYNrHD3zLCRiIrg52ueEbp5cCq1OBQfAjFn+8=;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=ivlR28ZlOB+OAWBqnVmg4TpU8QdHeeKMPYYY7FfKUI8kHhFjC/+6TmUYibxtvDfgQfRjOHVB4TIAGVDTsPuj8ggC4U9HZ4q+y/zGU9L4ESCkOy66bIymMWlTpMS+b3Ba6E912YEwWFXjyDqF13yOeynfyCxQx5LR70UK4rfFCPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=DPQ7ciQh; arc=fail smtp.client-ip=40.92.18.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZTF+hf1Mg5JMpo7InfKkEIEA6I5dL8fzlZ7P5iL0SdLHaa1UkR3hiJUfIKUisPQV4F/XGgbqXYSOm2kqgp8RjRRf2yrrMrkLXnThZrOrn+DFnEV8BPEn41OTyhAiT9hRgMlFwMNKSu9T346+snvWUfNOGJ9/DA1d4JAhcJYpNmpxdQa+Fwd/f/NrSEg7eOv6aR6Uxi3fo7A6hmv4mZ6Vfm5bjwEt7F6V0g5cxYVjW5GRUNrhXtMWURYQzz4lO4IdoRq2tUwThyxikngJM/D7tvHkUPQjr49i/cHTA4LU/QC5KiZrM++9q77f8oFcEReinQY7TD2cm4BIPNM06sdj0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gHw+Kw/auugY0ikSMQAJjsiuqnpX8mJAT7nZ3pfhlNo=;
 b=iugcHdzBwaEmfdZkMWxWIz67jLdqEA0Fa0BrM3VUuKgHPwVZSoTRnzt17cDCdD58oWUIhzLZQeB7bqkNuC3Fr3BpDbp8GrxZcb4H81Wy6tciJdodE95o14zzfYjRcTvZj2b6S/w7+8zRJD8NU1xb1BzdSHfPgEUKYyFIwux/od8yyhVtguUcnvagHN4SGB+nuevDGm6Dmw/dtuFycTo5LAWlZ053KvbLCGeLu2dNZO0dp/YFiO7qsGCC8tT4OsB48wMCbAZ2sGyWW85qBl7hnhBiC3S6fHAgTataQK01Bbk1/Q9pirAgks2gYZLYlYhNh24xje/4b8Rhax9A0pQ8AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHw+Kw/auugY0ikSMQAJjsiuqnpX8mJAT7nZ3pfhlNo=;
 b=DPQ7ciQhmQuxveYnwHYpt7R1TOTosYI9rn0QEkQKXsVDnE6ZCcVz32KhIY3lA0z1/Kwq3I1fK8TZLeIdHx15fw3HJQubNJK+C4y1JnzyupHbZ6zcnCK3PaVa+OJaUC4kjSNKjBOGXf6x/2gYIIr++l1E5rja04mnZysOW1Jn2TYWLz2XWb5c7J3N/+O54FA8fY+t+LUouVEY5PF1exUSqm9ekhFZGIc8Oy+gJ9N7A4SyhOKGIZo3DDuUS4786PxHCxpJegzJLslwLKTECgnnRcBG0NaAUq6jQSyebKnvpOF//vWHAbGQ/mLJ5IoNfvhRsccNQDsfgnIDhLZw+m5Bzw==
Received: from PH7PR20MB5925.namprd20.prod.outlook.com (2603:10b6:510:27f::21)
 by BLAPR20MB4113.namprd20.prod.outlook.com (2603:10b6:208:307::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Thu, 18 Jan
 2024 07:14:27 +0000
Received: from PH7PR20MB5925.namprd20.prod.outlook.com
 ([fe80::e1de:29a8:e090:5b7b]) by PH7PR20MB5925.namprd20.prod.outlook.com
 ([fe80::e1de:29a8:e090:5b7b%4]) with mapi id 15.20.7202.020; Thu, 18 Jan 2024
 07:14:27 +0000
From: Fullway Wang <fullwaywang@outlook.com>
To: jannh@google.com,
	akpm@linux-foundation.org
Cc: dhowells@redhat.com,
	linux-kernel@vger.kernel.org,
	fullwaywang@tencent.com,
	Fullway Wang <fullwaywang@outlook.com>
Subject: [PATCH] fs: romfs: Fix potential uninitialized memory leak
Date: Thu, 18 Jan 2024 15:14:12 +0800
Message-ID:
 <PH7PR20MB5925B0893BC44476B0D2E993BF712@PH7PR20MB5925.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [+aKcFUWo19KTl/UNn2hRXKjJ4PmJAJhCaipX2+Bv1m4=]
X-ClientProxiedBy: SG2PR02CA0106.apcprd02.prod.outlook.com
 (2603:1096:4:92::22) To PH7PR20MB5925.namprd20.prod.outlook.com
 (2603:10b6:510:27f::21)
X-Microsoft-Original-Message-ID:
 <20240118071412.31942-1-fullwaywang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR20MB5925:EE_|BLAPR20MB4113:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a67b8ad-5870-4c19-097b-08dc17f51b1c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3OMTjOU0bpv1eWbWoewPPsjlf1sKEYmv2v026EcAUKHrVGt1e89lISDS7v7uW2MmQKmin598Z1dbHRXxEbeJMh8lWfuwxY/2tTGK5okn3otJfTLp2B5ez+0A1ZPdF/aL7aJmXz+GwSNI8p7arJlFf3cdVtSH5YbIFtU8FDFo5xjSI0YyKdLO+vHo9GQinDxQBUVbTwlOP7oNv0WX38E1hqDLO684ZVqHzdFvcqQRhJCT3iAYqvQ59R/QU0u+josqeD2cyR3wM0nccJ1lobPhRAFK1t8vgPYHy12byWn3gv5oL+5yUXSBuTySzPajSE50QeK9uZTdVnziQp+kJiDQBQL9EFPHk/6gXFsoCav4W4xtGa9e4KM88FBeZKzwJFj9T1mFQvMoydEfMZBokyf8UA67xZ2FjIktzjkqhHVwz3aQAqRqt7zCzFd/VnUUFNo9hROUmQnVSOn/zcoHHOYHsr057OSoYyKvvfCMOx46FWBH8T4YVqU5mqRL+Ss5Ofkb2KhYB7dwdS9RviYtm+Q3twthwvzCrwGvCE/OOeQet/5cV0t2qXNRh8QbDGiPWxbPGq/akhf+mlRaZNGlzHCqwU3xTXCO0xX8OIZs4PUsgF5jXzBdoTfnbqJmIbsRZFPE
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zdKKnB7/6zxVqoMXTPbfbg/y4hVeOy352MrrFETDE7uVF1OQ1YdlOpctb1Nx?=
 =?us-ascii?Q?TMCunMsUkTLL3sGu1WbP6TAC+oc3/TFC5SBmcsFJwR3v+gMq4GMWNlTzJZjK?=
 =?us-ascii?Q?mvcTgCGwIInSxfGKSndbfKPDygijZ95msQhffvIJE5qh4e3WTlpet9umVX6Z?=
 =?us-ascii?Q?hBoHhlwJDmFtBbR6z6Biu98CMhov5gM4qyR4GYP/KlIjyfDt1WJzKHF1eXU9?=
 =?us-ascii?Q?NFqqKbcBGZa6cGDWIRxn9PqxrWnEegr8k5ATsqzoyFnohHQTbPKzyHSn9EPF?=
 =?us-ascii?Q?1JKKmGKWQqBTS/q63gHI1EqqpraQMUXawq/97QnNYfkmBtiQByKuDipUs5ov?=
 =?us-ascii?Q?qCbAqxaymgmXK/ktQlF687HZ0l8UUis6fX5xa95AcP3gvMmVbFjOKQdtonRw?=
 =?us-ascii?Q?xxX9VrRyv7MkzjvBkWq2WJYK3TsSYgd+sRq0n4PtYwN1zEptaqrXFhP4fVqS?=
 =?us-ascii?Q?LeyG63OL8qPeGbQl+Wk3ioIM06i6LvXLVrm4kYNhx3vUjdGnzVNq647w7qZu?=
 =?us-ascii?Q?kjWxuLkr8Apn6pgj4QxDz2RD/onDUwJYzb0bcoE7LisBKHKgBuzcwHjygKT/?=
 =?us-ascii?Q?GHgmOnram5mZOUzrzTNPgdkFXBaDzQFbl9O5bI3KA/8cBBcj/OZtK58rN5gK?=
 =?us-ascii?Q?uIPCqB4ub3lPM8sUN7eaW5HkYzlPQ0Y9jHRvhSP839x7bioBumxyyjE7m0iL?=
 =?us-ascii?Q?WFNw547UMt+fgAKXTzAem7+Xv9OQknK9X8KMh/eu4cLAj8zeEK2tmOlXrUlB?=
 =?us-ascii?Q?npdE32o5PV4WPd4DnLE9W7l0OZnJCNqizYyfrkuZ1vnU2u1ePp6o88lOW3Jw?=
 =?us-ascii?Q?jzTnqKgC6MekAZsdQe4eeNCQkYC0PSbvaFe3fQUJ8dawmxePQSD+54hmDtuW?=
 =?us-ascii?Q?82V4Parcy76f+GLa+Mpo5w623N5iIazMCQdcbYHmFXOCwjcVvFkWqXBsZ+2k?=
 =?us-ascii?Q?4kCh1x2uO3NGVQjQo8RgKruT7WaTbkqJ2HbWLLn8KPojDkybJnN50Ydnh2LF?=
 =?us-ascii?Q?b1bSBekDQuINKvJvt23DTjoIjXWmrW0cHdyD2AGH2ybG1mD3Kkn5x4OMgkKS?=
 =?us-ascii?Q?hSNuItBJZGB8Y1+71aJkqOcSMwYLTYSBazGNVplj9rP5yoZSsezlv6+F8/oI?=
 =?us-ascii?Q?yJUsDJIKu144NqywUYod+omOaPp6QLywuppEkjO4i8MwuLYuYcjcWMocJPya?=
 =?us-ascii?Q?S1gwIlDvNrkgcTdz4mnezfZDpfmMUFO8Ni5rVCvyJmt5wIM9Tsxo5vKeca0?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a67b8ad-5870-4c19-097b-08dc17f51b1c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR20MB5925.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 07:14:27.1913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR20MB4113

romfs_dev_read() fetches a caller-supplied number of bytes from the
backing device in an all-or-nothing manner.

Commit bcf85fc fixed CVE-2020-29371, which exposed the bug when
the requested length crossed the filesystem size limit, the number
of bytes to requested was truncated. However, in romfs_readdir()
in super.c, the requested number is firstly truncated with
romfs_dev_strnlen() then passed to romfs_dev_read(), leaving
the bug exploitable still.

Fix this by returning an error code instead of changing the length
in romfs_dev_strnlen() when the read might go beyond the end of
the filesystem.

Signed-off-by: Fullway Wang <fullwaywang@outlook.com>
---
 fs/romfs/storage.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/romfs/storage.c b/fs/romfs/storage.c
index b57b3ffcbc32..e0e4ecca4e65 100644
--- a/fs/romfs/storage.c
+++ b/fs/romfs/storage.c
@@ -240,10 +240,8 @@ ssize_t romfs_dev_strnlen(struct super_block *sb,
 	size_t limit;
 
 	limit = romfs_maxsize(sb);
-	if (pos >= limit)
+	if (pos >= limit || buflen > limit - pos)
 		return -EIO;
-	if (maxlen > limit - pos)
-		maxlen = limit - pos;
 
 #ifdef CONFIG_ROMFS_ON_MTD
 	if (sb->s_mtd)
-- 
2.39.3 (Apple Git-145)


