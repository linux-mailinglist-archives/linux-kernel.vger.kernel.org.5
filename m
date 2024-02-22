Return-Path: <linux-kernel+bounces-76539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A4E85F892
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A96C0282E7D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F95F12E1CF;
	Thu, 22 Feb 2024 12:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JUcp/G69";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KRA1tYXf"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3EE3EA68;
	Thu, 22 Feb 2024 12:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708606034; cv=fail; b=dX0+lY2xTMFL/4y/WJAlskXcCj6ItU3OumnWuIFbRPubXDQLRL9Hwh/pBz3rIcG2ePNeR7azkOfBs+LRSKiErF84G3ar2BQ1nKfvOi80ML7Mq0OS60eXc2e/G2vxbxUHrqPd06KZYMDqAwFbbaQHDKJr0TG6XBVpqh+xVGH0oXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708606034; c=relaxed/simple;
	bh=sTdXTFWeH5AQlggooKS8JYzoIUX8iSszOpfdN4vx/Ws=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ZdRfX+Ju93wcjpL6DtMdfBFcIXPE9GfEGdvIk/0OMT28IW8bId1JfZqletOGQjJ0q2zwpTTiIMKIqE9C7wDWxlpuP3KfKbAjLx3+a5lTcC/xcZ/Ti3ONXYRXgWs8xLmlq3WwWhDSLBmbA0uisiuybgMyeVrbE/M4Pu2X5Q3AWyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JUcp/G69; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KRA1tYXf; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41MB80fs030976;
	Thu, 22 Feb 2024 12:47:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=bW61A8EXdGnam/UbwgAENByW+hI2gOaiitIFVvos42Q=;
 b=JUcp/G69At84iZ5fQ+2tFo1g25xH3UyFkjEkDS4VyAmUdsZUqd+5zzeQUnZOap9xthV3
 Z4hxMT7E08IDdcVn89Utobf4qmM3PhZOKA6fN+CTSccgxEv6pf0vZ6qARcBpkB5ln4Y+
 AF+UG+LKqVDWfASjqBFvjmgmLvIj8v+bIeKHk1ZcTUDwIwIj85lyJE013foOZSlFFFHT
 tSr8kCVcjXqp/hj2JG540bbDymkUXTRuzSfh1Dp+1Pqjx/7y+SVc90HxYIqOciYF252K
 ZHY9iwHodhRfQo0oCo4gKLqOdG+kH8ed3ibJPEqaRrQnOfOBZNn0vLfTjnQt+40V6khO xw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wanbvmfyp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Feb 2024 12:47:05 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41MB6Ru0022545;
	Thu, 22 Feb 2024 12:47:04 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wak8ahssp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Feb 2024 12:47:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQWkdp7iO/3kB7esX19IQNtW8PFZ1XlCUJ3dQOMr4I5wEiidsq8R+eAEcQUhkzgXm0seisYWVD2cVf1/WaymPKab4+NoAx8fuXNAfs8plUwxphacwqwKoi/cVy5NW16g+Yzm4eyHT9Dzy5gW8Aw5GyJKIwi2VoxMQt0VRQMZFAJNinjFEuzyY6lgPHMCsDxsj7sfca9xmZPh85ukritc4hh7WGx2xxFqqmfsvoOrRIlkgq0KUgxu/PY1p0g3qWW62O7oGIExtD0+j/XklrrfiFflLzPEmTADx3nSsR+lUv10q6fBdouGIlfaeZfH5xn3zvQRBZnRiCmc7PIzqYk6RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bW61A8EXdGnam/UbwgAENByW+hI2gOaiitIFVvos42Q=;
 b=gPP79tAgVp7A7qWeiBQ8913AEiexOtXfmR56pAMJB+E6fIygWs6D/CmMj/38ikSfAPSguosLkkEoUEj3xpmzy+ekTHlah8BmmTRwkzku+yNWAy3qPFWWDXIHnS3a5UxlgC1F4idjR/YLR10r7EcUnExPkCj1wUApOmZcWyBH0fdBYy0jcWnjKb3x/g5L5HgN84yeuVUT1jKtRGAhfDbZaNdINnCugX4DtCARKQYsEd3qQr17Zfpe/H3Vsj+c32wATlZ+qspyqVxZ8w88QR3ce1oJyf9GwRDkiTNysQCzHzFjFfT8DNLbv5VpCwvxAlZFVO3WPrEeyJzPSec5zvXR2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bW61A8EXdGnam/UbwgAENByW+hI2gOaiitIFVvos42Q=;
 b=KRA1tYXfGc6dgAw4jrj0HqYd1+ArK4W8GFUK213NaJvoAGD4rbDaQEmg2T80sDqb2NEZIt+1NDXeU4CDj1QnG8IJZLYiwW/pC/mnWKoZ34QEiOrD80CsVhKtyWQ9RQur1eq5iEIRSRJvUJ5Fm8Hxf2+o1o8BJEQ/aGUOxDzWY38=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB7344.namprd10.prod.outlook.com (2603:10b6:8:fe::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Thu, 22 Feb
 2024 12:47:01 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4%4]) with mapi id 15.20.7316.018; Thu, 22 Feb 2024
 12:47:01 +0000
From: John Garry <john.g.garry@oracle.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH] tracing: Use init_utsname()->release
Date: Thu, 22 Feb 2024 12:46:39 +0000
Message-Id: <20240222124639.65629-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR13CA0031.namprd13.prod.outlook.com
 (2603:10b6:208:160::44) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB7344:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ddf2a6f-e6e5-409f-a42f-08dc33a45d83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	piCtQJxjrDqoSbhXPehvearcjGLE++kU0X/gyEyG5jsLzHEcCiEvbTenQj06aYJOop0hhWIxVm9oGld5d6uGZY42SmryH9gF/qUg+knsXevbe7yiq8R4+uRqaV+mnxUCdO8U5acqkJo/+geZ3gmV0akx6zNbHSfu/m2bsvNsceOxPItMlbu4O455qDoFbQI9yJjKWnVjrLiZhdlyh0DlJIIiWbkgF1qEko2fUFu8JGvnv/uACuBMAMZB4ebFAjpgPoAVN751moJ2VC0HbubFrXdS/COZxa86B+tJ9LprlqjWR0XQbwp0evF2wQEOMDniuKGrUwbfdwtRraqK1nukjKhhyi3R4wmwQz6NegoQ50WGEHWaMRr2uEsGMaBDzgB9CHxbjyhe7cAyV97PgM7B7HJryHKk68TmsT2X2/gDqcwnRapNlLcPYyhjVGqGvtnVSnUDOL9qJg7o6VuyOxO55DGsxVMiGnu1c8Yb1MDEYC27RtQokkdNeugZXN1mWWUUxyi7f/V98a0GifBxS6fLatJo1o5k4h4PBoEVG3fsI0M=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?BGFye7P2oNcQIwsfNC3TdXvqo7swLh1b/FJcwCdDDyT4OYhFp4J/CIxvRDGk?=
 =?us-ascii?Q?vfLb3bKkEW+IE7ZujlnYYDd/9dj4Xe3dnbOFE23X9Pw07c7DvuonJ+lrDAzv?=
 =?us-ascii?Q?9ij6nyp1WKuBkqVhfqTW5q7p3xXO3AkgsM4CrN5NRw21ofxjzCgA3RjAekMJ?=
 =?us-ascii?Q?os7sLIgiY1UUgSuVSD28kbyIclCubNr5/n6lEPqO+rrleEjvw4veMxXZBBO6?=
 =?us-ascii?Q?ocHhy7J+h26QUNftxapZHYhOboXkIhfsrZKha2xL1hW8EDlewg6uEvRYF285?=
 =?us-ascii?Q?PlJ1vZgeNB4u+Pjiam1J4LSc93se53muXv7bzpsz4A889PzseK87+sFnUowi?=
 =?us-ascii?Q?bmt1izNu4BcxqqwRXdPSHCH1iRBArwh1XdVy6t/mMk/yrYoA+wytb4kx2iDv?=
 =?us-ascii?Q?8e4lyCckBpphN6beAxz60ZhoHzEIi84lM1bkg4N8BtH/IJ8r0IVzfvbMsAYk?=
 =?us-ascii?Q?dLfCyHSw5bZFiKZ8hNs3FxgpyabWJijcF2mK38kxhMCBYjwDmkN/Q1u4u5Hu?=
 =?us-ascii?Q?eWSCCkZrrhYg5lBm4LsoNa7RZAp6tAtE/KNO6PTWQHXxBIBe8kxH8bSqMvE9?=
 =?us-ascii?Q?M8kZnUZy++D6vzci/I9yxKWZYUmnPKDkItBx6sLBDkxO5EOVFs8HlnljqTbS?=
 =?us-ascii?Q?pCl8Z4kToImd815yrqmEIiSO2LF5t5iGsWtGIju/5JM0K+iIlM0q7iPaTj+6?=
 =?us-ascii?Q?6CKt6xznS8+wSgjvi02JVq3xfgP9nyuT6Y4a6KBCmCd0NYUMFdKtVR3A14py?=
 =?us-ascii?Q?VgwlZAUfH4euvb8eVhye61nvCRjDpMKSTRiWFfFncFfgntcMOAFkASMibFTk?=
 =?us-ascii?Q?hvgKAEMcIvDNH8lwiGqNzvcbWuxh1QPSsJtCEJ1uUqqMeEWifzi8a9uTbtyu?=
 =?us-ascii?Q?0JEZdq/lhKKjYg2L/xq7Sf+pix8vqF55hDnYcjLxrpA4lrrpnhtYt+yPFx8D?=
 =?us-ascii?Q?wIDALZ1XT9vf/lOvPb2fkZUhq9wQ51k9BaAxcrcRkgg65VLRm2rq3JeFSkF5?=
 =?us-ascii?Q?PMzK/+tQj/a1PMqNAeNtV+DpkG2k52s8A/lpm8jXsfA10PEdU0Vq9QD4Ggsi?=
 =?us-ascii?Q?VPg1s5LA7p07eAt3ZAjVZ8+8EiBw1Po1NByyzZ1l3RiPjc4XiWlxIRPBk6r5?=
 =?us-ascii?Q?Z2IOq6aqqLzmpFrsxUC/qZI3bEYsQ6+4hQaYgxcgiRk+DoRmZbLlxRNonnLo?=
 =?us-ascii?Q?sHXdN5DMwL1NJKveT0Gj71UfIgkTh58SjhY9L4LHxGOym6aV2Yp9YdP1Kvem?=
 =?us-ascii?Q?uKEDmm+lgPv6Tva8MKN1idKcDaRw+paHDucgNC8YmyTyD7ckofqqYBnaUsIB?=
 =?us-ascii?Q?AL/YQphM89gUjyNV4aRf8Mm4+XHs8VeuPugasaxsVUGNtfKYQvDCj3HpAX3j?=
 =?us-ascii?Q?fpu4bxE8yvi4JuZ852baAkSmb/rmu3nzff5sbqEnEDNUuyG4HoD+qpTl70PO?=
 =?us-ascii?Q?jWehOG2tI9AjG5vI516EBpgBHRhxepLN4l+ai+ZvHMfvdtT/u981Uoq08xhL?=
 =?us-ascii?Q?116zTyKNf7BOOyyDkuLMl5liakDN3WuFZH3eKAMTIUJlZujfICVq42ECXUuW?=
 =?us-ascii?Q?0NQl/e5LFO4no+QezIzIlFBT1nGnfIh5MjtGf7m0i4qJtUuW/5+V/HpgAvbt?=
 =?us-ascii?Q?RQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	F5R7gvhfMDh6131q6pGelumM/tOfNaAV0bdHlyEBl+L06RHHQe6aCTwyyFU5G144ddKLnTijRsuQi6lBc5w0kieQ+t4cFCi9CpUIg4wAGWNpj9MIKplYij+2lEbG977BNcrPpsQx8lfuI6ia/pegqx3YU+NQ4m+mFmd/IknOtnznLFkDNX9pC0+q7ZgAXrmiRnKcZYS7ogtNDa3WP6/N4Bpbfp9dSX9IAFcfQPbV+fv3SGlvnhtG+yMbyMoKmXPK5QeXtsE5nB6UirM2fLw/WLyyJ7/PxxmOkUF+paXT6tA3pWCeFyvu00LmV4c3qArZFLp5B/Tgif+Dmbnt7fkNIDivEaPMF21Hso5CoUJIKtZ5ccQZnno0pofLcRI8mUrmneMv6uN8+E7pO9ozZf8jXJwNW3Z5+d893xxLxLBp2PrvE+khUT0zl+wpjMIyhdISfnZYMWAtp6bnKHxnFeue7MhhQMxaksuxtyu5ZQWPk11DSaRAbia+e3D9jGCbcWi7nfGPrN/ntrmUcNU+x0hF8cVOuS1b63e/4NJSw7zvQs795UgPqpMQTMjerlD8zz5JvG6/mQ7PaO84wS7vzOnE02w8vzMH2mdpp0dNkG+0NJ4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ddf2a6f-e6e5-409f-a42f-08dc33a45d83
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 12:47:01.7016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cCA+PebGhyJmBeYiBfg/5XS2q/QZZ5RnLT4t2j7CO198bVSv/rIh4dzz4ZGnAZigKawZGdh4+/n4+4+5SXM5ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7344
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_10,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402220102
X-Proofpoint-GUID: luCA6W6I-xr2ya8OfLSaUx2VAXm6fwQQ
X-Proofpoint-ORIG-GUID: luCA6W6I-xr2ya8OfLSaUx2VAXm6fwQQ

Instead of using UTS_RELEASE, use init_utsname()->release, which means that
we don't need to rebuild the code just for the git head commit changing.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
I originally sent an RFC using new string uts_release, but that
string is not needed as we can use init_utsname()->release instead.

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 8198bfc54b58..1416bf72f3f4 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -13,7 +13,7 @@
  *  Copyright (C) 2004 Nadia Yvette Chambers
  */
 #include <linux/ring_buffer.h>
-#include <generated/utsrelease.h>
+#include <linux/utsname.h>
 #include <linux/stacktrace.h>
 #include <linux/writeback.h>
 #include <linux/kallsyms.h>
@@ -4368,7 +4368,7 @@ print_trace_header(struct seq_file *m, struct trace_iterator *iter)
 	get_total_entries(buf, &total, &entries);
 
 	seq_printf(m, "# %s latency trace v1.1.5 on %s\n",
-		   name, UTS_RELEASE);
+		   name, init_utsname()->release);
 	seq_puts(m, "# -----------------------------------"
 		 "---------------------------------\n");
 	seq_printf(m, "# latency: %lu us, #%lu/%lu, CPU#%d |"
-- 
2.31.1


