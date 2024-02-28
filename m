Return-Path: <linux-kernel+bounces-84459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D6E86A702
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 04:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BF7B282EA7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 03:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A437D1CFAB;
	Wed, 28 Feb 2024 03:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="ogGyeOkO"
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690D26AC2
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 03:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709089510; cv=fail; b=d2rcirHTEKXP9vmp3JCT/TP2H9gQiqJD9W+lxj7zzV+tGpUsO0TV1Qz8L9Pd4tTQXyzVT87Yu6mhn9YG/mwsYuHZDiPOceKSjVpRt0NwDQVXot1+KMgnKCmz/RRIMy+C2Anxv4/qPxUeap7/tlCfVRUGNg/tAI3jfXY1ys1xesI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709089510; c=relaxed/simple;
	bh=9aGm4WqB58s4j4+QUw8rfakB0xFZKUIViC7HDA5bhA4=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=PCChyxe8QGNa8vCG1R4/xPTqneGTJN7X7pLHTmIcN2sU5RvKI2PpQTnikmZXsImoxDr06QKtvF8nT8+SYndY3q4oo33mrr8vs+Rgn1RtFYic7Z+j7QbK9rx9gQFTHlbmerhsV7hzS/mDKrCtuhTJTsY76eatAfrnDXoZjxaYhQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=ogGyeOkO; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41S2Cp6S030930;
	Wed, 28 Feb 2024 03:04:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=PPS06212021; bh=hMHFsAAiW4Miptyx3k
	lRlNW4GOW0BBw5VNOj+T1CjkI=; b=ogGyeOkODdj5Av8WDirnRSQ54qxxzq4wV6
	KV0cRzfNqnVh0sBc3K7PEP3RLjQunCauoubPMcDbjf1ZlfHMrEjJptjcNoYG+C3K
	IsM7OjyB/d6/pu3ERqMcr2AnrRkQ0jEATZI2FYdYBzMR9yDNGct2nl1dAAepZfp2
	kYCNt6j1eIDXzQz7GSARqaYAaprOqWaMP8fCdhVzAmbMp/1SaVkwJEuR4u2OM5Md
	hkFEgabFwGMQleJbE7yUkGrDkhuk5p/LjamGYULrBz/CFX2XZm9av6kKgjtogwLI
	6hWEzaarwVAs8wohmZkmP6s7Mqbf6SRdjDjEdQozaXMsvqfJsXBg==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3wf5nx3wdj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 03:04:29 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h/4RTMK8wBiIjqSv4AiQKJOJ/JrFH7bvqTtemuZoewtBVsTNtEHdayAQTjn8VS/ZdaVGVuinBDc8nqX9AQI5vgODFAwqQ3te+MrjeTfPzgyj1bJ4dvH6eiAxBpfyZwWx/ElhUfioGRWJcjGKFZpRj6jg204yMOk7tUEZRPWI2Qo4x9IJ6d5LgAxkxsxcz6qoxkALG8k5ejQ9654XybzWIvUBy0CWwVDcHP6YsWgiNsP6r6DBL1/blEo2QPOyjfgIZGhCH1JPvYKR/UNOhOwjLAQhPCs1CzYZD7b/lbS0cshkHoXDFs4Iez+ljOR9IQQbFacqhT9w8nsDPT1qIb8b4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hMHFsAAiW4Miptyx3klRlNW4GOW0BBw5VNOj+T1CjkI=;
 b=jJtWj57jSxK3a3ViJnzeaw/j3peOsRAgW4tG2KRAOnVmd8HoztIR/ax0uojaKLEfhxjHud1CHeQ67X5Rcjfk7K+KVOvDOi1RpfAuC8NgevRF6F9p52xxkg/IFq5aSRcsatus0gp4RjlQ61gYiBAhgchJbMQz8Lm2v+DscI/nA9GFcriH6Sd15qt33XYIZ3RD4EQ8ibynOPTKtYxzxwO8+licAgToRXfsjvJ//IFm8UNElNDHlChoc5GXTI56KhTMl1TCa6WNaIE/43xhuP5D7yiqRt4ZpTl+Tfv2nToweajGvlOjaFybVbrOmT+G6mqUq9QrfsrltuzMwa27yg37gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by CH0PR11MB5266.namprd11.prod.outlook.com (2603:10b6:610:e1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25; Wed, 28 Feb
 2024 03:04:26 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::dd99:4cb:332c:944c]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::dd99:4cb:332c:944c%5]) with mapi id 15.20.7339.022; Wed, 28 Feb 2024
 03:04:26 +0000
From: Xiaolei Wang <xiaolei.wang@windriver.com>
To: cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/slab: Fix a kmemleak in kmem_cache_destroy()
Date: Wed, 28 Feb 2024 11:04:08 +0800
Message-Id: <20240228030408.2740647-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0165.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::11) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|CH0PR11MB5266:EE_
X-MS-Office365-Filtering-Correlation-Id: 032b838b-ef51-49af-e14a-08dc3809f8b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	otn+NtIqEfEHvyOW2a5zsyJIcM9NnQ2AN4k7HO9jqZlKJJyUGD0T74Vh9oJ0/kOR84wE7HzZWSoi6G+EyVnODlVFmFPCjFDSM3ezGPZBTYwVmn0ILnp6Q4LixjkRVvMp6p6SAiy2tI6hsLRNr6n2oaqfSXxOBHGnl0ghuygxlCqrwh7gNdEBShwG/au2omlMM+sa6rUoiCBZWZz0/DScDWPAMNTxtADPlxF7FMU23sCALsZXDriVE5hBuanqB3pOAjTeSwrUEA2eysLlbhe3h65CfVzNfwZTUZe40YpsZqUVQWJFNkZGV/LSh5T3gymiFTV0zPvwo1H6TFWS1HqzGGtWKqNMGGzcSUu8bUHpJNyPyvtCEwUh3wOQ8IezT259hNhq07DpPDIQw0xxGg94CrjWpz8M2g9pKuiixJ3cD//kCtLtISITNvKwb1BcQSlEXJXb235IKlnx29ttXmtGnDNheZZou/8tHp6OJXgqF9H2iNCfmFR8581vu9kXrnEjeLXzHVQMCOiOxink7QjHWtbGQ+sds6c/sqqZyoD3CXEMDLTzgItW9kAkjH5nrY7L2Vb1IGKmFAA1uUBuR92ubhZpn7UxFR+DyB3P9uMAnNXTsiFP+UqHva1ODR4p8VtpUZkYuVQlg9mSVCDDKZG39QZBml+YYqgz6z/qXnw1m71AgEjWoYQYIe/gmg/ilMFNImpa7xulQeUozIMbNd/Rg9KJnM1mtnQ0Aqp/tUOSP2U=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?/4rARi3KZ4IX+bfLn48eL37OEcAWXQXrkYEWkjQcoQjqyKJfAtNIVy3wrrr7?=
 =?us-ascii?Q?qmv8AiKzUJLKcSoLtduQiqM+if8piVqBwKuHu4ex7+Y1ux5cVMaevxpLwRa5?=
 =?us-ascii?Q?Iae/6qSDwcmZwDgZs1Y0yCDt/nOl+a4QxjypwuBfq7it6HzqY/pgRESlm14h?=
 =?us-ascii?Q?HV2+CjVu7adwqOMhRs0PF0SP1CyWKW+eivanp4KkHGm2qzUbtPeHALeT+goP?=
 =?us-ascii?Q?hlbM04oVzH3URktXLaj8wZammvMW4uuG2OD8lJ1wOMc4oJQ0z28wpZCd3BFJ?=
 =?us-ascii?Q?UItvrMRczvrHOXii20HMHdQz5nPmKVjp8cZKBI+AYjikKwEuAobZX9OrKZWa?=
 =?us-ascii?Q?7LYiQQ4GbJGVI5vEvfB/Y7eNq5rWYe60GTct+G9E3JyRsiivJxRQpD7aEJMA?=
 =?us-ascii?Q?krniXOYjVMFflN4NukRWyz/B1aucU9nwDrwHTD0OUZrMVpibRRRX+aQv6fom?=
 =?us-ascii?Q?qGZNN1WV0zCmPJ9RHEUOyZ8R1KH1SZiXJyt9dQlY5HPm26Lkei/7hA45wkwb?=
 =?us-ascii?Q?cCLnx+cgskCm5eRde5esBC7vG04YcjfS2h/FfIhwdvCXcPfJlGhcOX/6WXvv?=
 =?us-ascii?Q?oXPMBjWlHOqCVceGzESTvYCBHIWWii3bYq0m4Jb1K7CSk4XqsVUFs78lLtdQ?=
 =?us-ascii?Q?dWh84vkHeeVyU08TkDPzzyOUQIG+FkQVIXONgG/P3HbBY91Zp5o0EmK36R9K?=
 =?us-ascii?Q?uQLj0KYiewn2e57jCo+VvOsRkjrB760Ihq/90X6MXx2kvV3P7wOp9nv4TJLo?=
 =?us-ascii?Q?HA19QvHAtIo/uH9K+C7IZusqsARXANRMorNEQfBysOHsIT9rOOF3Sp0t51rF?=
 =?us-ascii?Q?KM9v31/rKKnyi2Qwqv86cN3DfdWxOkPaMGVf1zMCOsr5mCHZVMBq1tpRoFyQ?=
 =?us-ascii?Q?slKAxhrB5IIoGX8cAbNn5Pn6buUBPaQAD3Vk7YTg4ouq2tEsBOhBhG6whsn6?=
 =?us-ascii?Q?Jay8PPLJMtTKlSjka35AqXDyKR776lOHBai/zpKhe2ZxaWEoHHf398sNBNAd?=
 =?us-ascii?Q?k7PGKQKxb0+zNUKoJqqpkKxoMKFot4iyh5DWvvFMvqQ5UBf+Qfa3GNEYKkb/?=
 =?us-ascii?Q?gszFMIUKPDQfqnyemGu9L9Si3guHNmEfuTE5n0IPRbRTq7kJFeD5/g23Evlb?=
 =?us-ascii?Q?qkoIbJAK5PUt5y7B5q8fnOHdF9F122nJ/xdjGvJV+kTfxgUF4fpmlHd5D5pm?=
 =?us-ascii?Q?1VsqsAIfLqY88G/D4Fired+YcfrBli7kvBhXNkaWyCwNN51DzdjT/8bbDrgG?=
 =?us-ascii?Q?+XvmRZfGDPrm1OXOHrXBqaCPrV3OEOibO9xHU9ADEksuW+Zm2sejZXX1psry?=
 =?us-ascii?Q?xF9Ru4VDfNeQ2oSknb6JcpWPV3rV1qgJsqBy6k4r4ShFacskPcLTKT7gcSYL?=
 =?us-ascii?Q?QDA+3hCwHDGQq/wM7csZS76lNj3VxVrMKz/rlfL7SxvjEcmpjPhgmOjcTGTC?=
 =?us-ascii?Q?Rs/RkKUe7nwNbAVvg1OCEC5RepzZaC6465YHU4eRkELPEZXbmO9SuIhiR0K4?=
 =?us-ascii?Q?eafC6LDRmKmiRUurTcxJroOran7AQP2KQ2OHSl+BOdJ34WQh1yVXYj7/2FEH?=
 =?us-ascii?Q?cXpM2hwydnFslMuT5NAz96CBo80qZI13Polnie87OMTu4bdTWRC8FSdhFsXw?=
 =?us-ascii?Q?NA=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 032b838b-ef51-49af-e14a-08dc3809f8b2
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 03:04:26.0072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VZ9lQXngqPgKzfl5S+VmINkMn3pdiQrYTy3RPGT5nehKIAq7WUJttuAGY/lE33j/s9/etpwJYmQyqhcP8sniKEpTiWP/L4ejWYesdiIlW0c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5266
X-Proofpoint-GUID: K-7t6ECgYaVMtM18dQcCAE__1vepVLvd
X-Proofpoint-ORIG-GUID: K-7t6ECgYaVMtM18dQcCAE__1vepVLvd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_02,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 clxscore=1011 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402280022

For earlier kmem cache creation, slab_sysfs_init() has not been called.
Consequently, kmem_cache_destroy() cannot utilize kobj_type::release to
release the kmem_cache structure. Therefore, tweak kmem_cache_release()
to use slab_kmem_cache_release() for releasing kmem_cache when slab_state
isn't FULL. This will fixes the memory leaks like following:

unreferenced object 0xffff0000c2d87080 (size 128):
   comm "swapper/0", pid 1, jiffies 4294893428
   hex dump (first 32 bytes):
     00 00 00 00 ad 4e ad de ff ff ff ff 6b 6b 6b 6b .....N......kkkk
     ff ff ff ff ff ff ff ff b8 ab 48 89 00 80 ff ff.....H.....
   backtrace (crc 8819d0f6):
     [<ffff80008317a298>] kmemleak_alloc+0xb0/0xc4
     [<ffff8000807e553c>] kmem_cache_alloc_node+0x288/0x3a8
     [<ffff8000807e95f0>] __kmem_cache_create+0x1e4/0x64c
     [<ffff8000807216bc>] kmem_cache_create_usercopy+0x1c4/0x2cc
     [<ffff8000807217e0>] kmem_cache_create+0x1c/0x28
     [<ffff8000819f6278>] arm_v7s_alloc_pgtable+0x1c0/0x6d4
     [<ffff8000819f53a0>] alloc_io_pgtable_ops+0xe8/0x2d0
     [<ffff800084b2d2c4>] arm_v7s_do_selftests+0xe0/0x73c
     [<ffff800080016b68>] do_one_initcall+0x11c/0x7ac
     [<ffff800084a71ddc>] kernel_init_freeable+0x53c/0xbb8
     [<ffff8000831728d8>] kernel_init+0x24/0x144
     [<ffff800080018e98>] ret_from_fork+0x10/0x20

Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
---
 mm/slab_common.c | 8 ++++++--
 mm/slub.c        | 6 ++----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 238293b1dbe1..b6b35bcdd196 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -404,8 +404,12 @@ EXPORT_SYMBOL(kmem_cache_create);
  */
 static void kmem_cache_release(struct kmem_cache *s)
 {
-	sysfs_slab_unlink(s);
-	sysfs_slab_release(s);
+	if (slab_state >= FULL) {
+		sysfs_slab_unlink(s);
+		sysfs_slab_release(s);
+	} else {
+		slab_kmem_cache_release(s);
+	}
 }
 #else
 static void kmem_cache_release(struct kmem_cache *s)
diff --git a/mm/slub.c b/mm/slub.c
index 2ef88bbf56a3..9ba59d064b6d 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -6792,14 +6792,12 @@ static int sysfs_slab_add(struct kmem_cache *s)
 
 void sysfs_slab_unlink(struct kmem_cache *s)
 {
-	if (slab_state >= FULL)
-		kobject_del(&s->kobj);
+	kobject_del(&s->kobj);
 }
 
 void sysfs_slab_release(struct kmem_cache *s)
 {
-	if (slab_state >= FULL)
-		kobject_put(&s->kobj);
+	kobject_put(&s->kobj);
 }
 
 /*
-- 
2.25.1


