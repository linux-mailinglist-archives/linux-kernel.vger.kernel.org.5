Return-Path: <linux-kernel+bounces-77208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E068860213
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 667F9B2EDC7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A2814B81F;
	Thu, 22 Feb 2024 18:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Oz+HMKUk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mffmkBr0"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34542548FC;
	Thu, 22 Feb 2024 18:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708628218; cv=fail; b=eG6/VRdDAfcit+0Ve8Ghi41LsgUX4uPa6rJ0Sr4T1MxpC9OTk6tXTkBiUUlPY+IqDvzP6yawDGMVJsKuVYRTHFYpOOxS3ZuZOcBRs79kKZHhlay5H4/X1439DK9xQoEMOq4ADG2zbNMGBVT8bO3wLPDgnQGr42XztEeZ1DovSOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708628218; c=relaxed/simple;
	bh=StEVh1wuYGjkFdDZd2TcfbyTbV1QhQ8kvv4pEvjqqMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RHJfeYVB+wzS4th32JwZwByb09gFfhCXGD/iYknjYE/JOzKLM2OwPNkFbmbZcyoUMWYSIBrJQwX/YWaYhchOGpa9TJxCem2rS3MXCXRWvxa0PuyeaTZGgG23SoRI7niwd4Uo89IBirNpoIwB8AA0oZH6WMZsJUklgKPHDl6Ar9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Oz+HMKUk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mffmkBr0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41MIRQjt001388;
	Thu, 22 Feb 2024 18:56:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=qfQOrE/yly5uZkuOSsOk8FyEEdCph3APQcxeGux6xok=;
 b=Oz+HMKUk4wCh0f2u246EdBp1hqtQVGSxvUEdZmcTrkN1Ha/CybSGrppN3QDdvVuUVqyc
 7C8GDmaL/eFbh4kAAjXdg+T2/6tWlEOQ5sd3x0KP3ihLCQG+1+YQI/FUVIEP7D0EGhC3
 24bo6/+7dbUpftyYtSQ+rFIcZ/swH4nUT8+6TAJoVy1bn9khsWjVyPYLScxto+NHdC/2
 d3nvEmZPy3rZTXgpmo2gyiYHdftn/1K+Elu9DVvknmqXeboEkucK2U1xSH1yubdsuC2q
 23du6saQwmG67do8V9EnteEdrVqEnU7Dc+DWRWfOuoOmq/weWu5ub3qCLBtk8hu7t2Vp mw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wamud5mva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Feb 2024 18:56:47 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41MHVq79024592;
	Thu, 22 Feb 2024 18:56:46 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak8b3bp8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Feb 2024 18:56:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SSeOxRdLZwTi53q/410HIEXswHTvN7NucOfg7yh3r+nr3xo0rx6AZWQCW6iBhVzHf8dVHi5sp4J8pXNY4tG7vqsDhnUqtpKfuJiT+Ck9UuPfjEB851eecno5mA00dizhByUlL29LPG+6Qy1arhiotFZ6SucKSqmraTIn1mCLpqbl9m8gzbWMyQJyWplWIbTShSXuD2Dxgg7ouCDoT0nBrluRRTtsZJPFi8CInZ36kWpBAACzxmC8Xk2MFxHv5MQq0kAy3/k/qz2yKSomTO0g7DDR+lXnbKda00Gwd1IIUX1qQh9CUparT4rhnEF2kUgkXZzBhiYrbohypfb66ZoM/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qfQOrE/yly5uZkuOSsOk8FyEEdCph3APQcxeGux6xok=;
 b=f0470WVxwQpE09R9H6+k9S96JIsiL++uJBiQkrfJblwmu0OxLs4o4MOCyCUPhaI//RqFjWo2pAK9pTenqJazevSdvQ6K4aNUp46qZ54vpaz43JAxVTmKwerqDdb+pyZjDdJPhemIhAXjKD8nEFVhcriV37p1wnJ8NYsMxnWXGsR0UK6uyuifYHVxwu8cLtHZk8acq0AlpeErK+kKIpi1Pg5diJbDG8UtIAl59XrLSMzmT8JRjs6wp7lK0NXtOrx/pawnCz4ATwfuBu9zGCiPyKCLJGX0/TvTQUCI/RbFS2yOGFXwrpNedPjGmFPNs/mhjp28juagCe0Bijn/V68QCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfQOrE/yly5uZkuOSsOk8FyEEdCph3APQcxeGux6xok=;
 b=mffmkBr0mMxMZXhSHDZ6lNvSqVoyianvLMfZpe+pMHY+T/V3OFQLq45EN5EN634o540Gz77/LQkA0joXQxrObu+gKaOxXxUEvjNSpPBLWR26gisguQNlnGXeANBaZPG3PxXKLKFU3TSEk18ehV2h5xrZqf+WvX37zwhOUa9q55Y=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CO1PR10MB4676.namprd10.prod.outlook.com (2603:10b6:303:9e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Thu, 22 Feb
 2024 18:56:44 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606%4]) with mapi id 15.20.7316.018; Thu, 22 Feb 2024
 18:56:44 +0000
Date: Thu, 22 Feb 2024 13:56:42 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Lorenzo Stoakes <lstoakes@gmail.com>,
        Michal Hocko <mhocko@suse.com>, stable@vger.kernel.org
Subject: Re: [PATCH] mm, mmap: fix vma_merge() case 7 with vma_ops->close
Message-ID: <20240222185642.rmnp76oquu5wfo6c@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Lorenzo Stoakes <lstoakes@gmail.com>,
	Michal Hocko <mhocko@suse.com>, stable@vger.kernel.org
References: <20240222165549.32753-2-vbabka@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222165549.32753-2-vbabka@suse.cz>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0005.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::18) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CO1PR10MB4676:EE_
X-MS-Office365-Filtering-Correlation-Id: 265533ca-b82c-402f-314c-08dc33d80369
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Gvv5hDqpSs1t06agDSIytUbb7Cht8Nmf9FnRjOVnvIbE3uN45ZsNv/WFPwqD0ACdxLM4/OD8OqFc9aKWz7D8bUcaEf9q5/Za0FAV2wwqHVI7p+Y7HsynqjTdkZziyiTi6mwY+r2JueitSegJ5NUOLb58nbzVnvPepVJFkmRMuoBQAw7abcTCQLpvgNiuK0jyqEGPhyTD1KhIsedAcJSykf4kVsS9FXbZqEhDU+uWafNGNYTYkwWpPNRBFDEGvmh4CNCPwM8LjSaCNUDdegWSGYEYoOM9Rx17QbU32DybQjrOs6zNwE6dkvP8THdL9SfpRx63uRlOehMLGIzWQUSMkraQhRWdp06iaPqANJ04kYVK47wTdqxXFQUzhGwEYcHBhBwRH8gn4uewmmIwftkkRWQcJtqJV1Tk1j7j3MC1IrSBbjeYlPEWjFIUsoy0hEf+/vM4rf6PGLdU0RuDLf5inAaJeH9wXL+VozuFd751V8DXS5bmYz+xZd/nCA9/gLMemeNv2lGqIAjddmzkUbMztMMwc+k5w9w50/TGIX6eu90=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?faLi7znrV8zfScP8lAX/6RseQ/asCwhb2h7dr5Y1r9P/qXg92Ddy6EjIXM9h?=
 =?us-ascii?Q?tSsu8lnrSMd2QfTIgbi1yVLQwk23mEqoY0/uKCGmQXoG4bj4U+3uzsqCLZ6h?=
 =?us-ascii?Q?lBAXmnCWA/yA3thp0juOB8rNeWpLJDtERBpvWANu/HgRntuuL1kWpQIvy5qI?=
 =?us-ascii?Q?9fLhKa6BAET2RjT13faPXjsWn+Gi+YsM6Gpakork9L3GonLIEIliIGyI3t0B?=
 =?us-ascii?Q?CdN8l+VukOK/n/93hxXAWxbYlTmCH81uK/9y5wx6WrJ1bf5HShQaLmyVPljg?=
 =?us-ascii?Q?/1fEU+HfKErzmDYWpa1w759gdVegRD0L46poQSvchZNd7UP/QS9Oo+30okf/?=
 =?us-ascii?Q?IDa5Es9gFfX7eMkgAAV9go70CIB7cGxsXmWMGWDt94Tv6lbE2BLXyDvyrMGs?=
 =?us-ascii?Q?chVoQdiFZB93bs7M+VLRGnZN9sokt/bHaIeQAYlxDo2D1RXUT0/zsHS+iGAI?=
 =?us-ascii?Q?87jQqFSloXSf2Ge2k0SDSNT8fg2yorc+lRt0AxgvvDDw+654gS51buWi4EvL?=
 =?us-ascii?Q?WuPh6USUyJ85gRiENRZMor0sDOoJxme/4B7GRQ1wHYidxBU6azbh2sjd89Og?=
 =?us-ascii?Q?mSbqwAB8IQFAfFjATpx1NDBMY/lnb0XEe490nOPVRtszPJ1CJAEGhuTimT5u?=
 =?us-ascii?Q?rXNrrcOagBY8y/lclbt+royUaqby6a3zmES6SLfQcwP2d+mx9jFfjDsYnEem?=
 =?us-ascii?Q?oeDdFS3GJkJdR2vl4XTSeWCKL9hNxE8pvSopUxekvHR7hWpbVQw2L2xwFazW?=
 =?us-ascii?Q?CIn6Wc8C6DteyBcFdL7HpyADvkTxYgaqplJ2TeZdXysNF4PRpcaH7P5gzwii?=
 =?us-ascii?Q?rHvH67hR0vua5OoKeT20o6VuSPIvHe8hIQbCocv8M+D1UhqLVZ8BwWw/Yg01?=
 =?us-ascii?Q?vZR+4mZQ7TfxDhFF9W5Y3gUw3+0fNJSuwJecaWT2tLMryqvIowkyPKVHwYkN?=
 =?us-ascii?Q?50aNyCy8lE3FINTto6aDWjtFb4/cczXCopA+vCZFFx8JD09LONKyLoNo3w7P?=
 =?us-ascii?Q?kUeJ9SFAf5ycOJhOeBh9tBADPcTLMejkWL2gNREEOGYSPHpieFULiZGQsJ6N?=
 =?us-ascii?Q?n1KWdAjy5sNviP9+RN2gqRzcz00Nokim3p57cgpkIuqqct8rgHHclNZ53LSD?=
 =?us-ascii?Q?B93JvSQonFCq1dkZg/z2uyyAuhz63hJepoX4+VBBDaAZlTTfdOYilGh8l2lR?=
 =?us-ascii?Q?ORfRNYQJWdPoRX2fQnCERJdKXBp4PAq/ZuHYdx4XmeMGNFJ73PHMyQrsGWWN?=
 =?us-ascii?Q?5Hu7x5HjwFbPS52i4xqhPA7uEW2xzijSu4RyX9ULsHFrsBcwU8IuFuQHvbTH?=
 =?us-ascii?Q?B/e4PzfHw4FrozKvKK/7R5oRyoiQaJXcAZX2o3HhKXEySm9LMiU3bvt5I2PZ?=
 =?us-ascii?Q?ePSmbPC67gxXmLcwBrGPs5abj8aUgBnCf97ef4jEcck3A6HBmCQpMzL1Vm7M?=
 =?us-ascii?Q?e3ZOykmSTNSxqoXihamUSD9Asi0lxSkL9g11EmBCU24iEIEFVV94rxnVQ0u5?=
 =?us-ascii?Q?19KsjlvGwDgzx0Rla6Dk+na7iO7PgCsyr/IqPj6p+/adkq04lHgAggRhmgIe?=
 =?us-ascii?Q?oeQUDO+pz5OVbuQ5BQiTpkRnNPe8t16urBJanYBX?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	nvZBSKo5D4y2TlmkPIpHU4zlOH+GoUnv44XmqZf7pCnK1YQwZ8aKJp6/GIN5WemFHmlrqHVFWtGTnX3OUuAiI4s1llbW4kNn3bG3yB+z8uBSH0nh+0iJn5j4fuduBn/65EuTnIqyvbc0CYUFIuP/dqzO8ls3K9QEZIJM7UUbnri/J9o5z2ZbSkGNHxfEt3CEBtHDUa56yV8/jAcsn6U3qH5BabDMvkVIt08xTmjUDom2BJWBAN9P75ixX56qCOmBhqyL0Iw5xd6AS0mNSsDz/j/7eavrOFRUKVW53N/NFCw8ueZ5plEXiBCEfRequdLOIWSUmVlwt0j1+h4Cs4J3pNzG1Pw03eY3IU3Pa+TcWPtNxi89adOiTi5luvcy+B+eVa+pE104/9auT79LBPdoSPy5MeLHuT9Pga0uHdJDkWTMHSdVbA0lC54XQZJ3uewopZQxuEfAASi4krWPMtkG6swjL9Nzz3IEj2LShTMBw4n1dl6JBzxRGv50gKqbSr48VJAha9YnOdFDhN7Pn+S4K9n+oGh2yrwF+r/3rSCrquyA8c07+42UsHWMoIcaIdFkP9zM3xpDiJlfqDfP1+F9CNdeth2RhCv7ypNC2MbwX2A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 265533ca-b82c-402f-314c-08dc33d80369
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 18:56:44.5256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1nSEZKz40rXnfIXUgNtYGhsPXhmfwXxJGzIKTGTywFIXaPx5wjOaWR+pvHGnA/burThEMCDaqqEBElPhBIlN7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4676
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_14,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=593
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402220148
X-Proofpoint-GUID: sYd-KUfTA9n7eKPMJFf8gAMLC6uwCBJ-
X-Proofpoint-ORIG-GUID: sYd-KUfTA9n7eKPMJFf8gAMLC6uwCBJ-

* Vlastimil Babka <vbabka@suse.cz> [240222 11:56]:
> When debugging issues with a workload using SysV shmem, Michal Hocko has
> come up with a reproducer that shows how a series of mprotect()
> operations can result in an elevated shm_nattch and thus leak of the
> resource.
> 
> The problem is caused by wrong assumptions in vma_merge() commit
> 714965ca8252 ("mm/mmap: start distinguishing if vma can be removed in
> mergeability test"). The shmem vmas have a vma_ops->close callback
> that decrements shm_nattch, and we remove the vma without calling it.
> 
> vma_merge() has thus historically avoided merging vma's with
> vma_ops->close and commit 714965ca8252 was supposed to keep it that way.
> It relaxed the checks for vma_ops->close in can_vma_merge_after()
> assuming that it is never called on a vma that would be a candidate for
> removal. However, the vma_merge() code does also use the result of this
> check in the decision to remove a different vma in the merge case 7.
> 
> A robust solution would be to refactor vma_merge() code in a way that
> the vma_ops->close check is only done for vma's that are actually going
> to be removed, and not as part of the preliminary checks. That would
> both solve the existing bug, and also allow additional merges that the
> checks currently prevent unnecessarily in some cases.
> 
> However to fix the existing bug first with a minimized risk, and for
> easier stable backports, this patch only adds a vma_ops->close check to
> the buggy case 7 specifically. All other cases of vma removal are
> covered by the can_vma_merge_before() check that includes the test for
> vma_ops->close.
> 
> The reproducer code, adapted from Michal Hocko's code:
> 
> int main(int argc, char *argv[]) {
>   int segment_id;
>   size_t segment_size = 20 * PAGE_SIZE;
>   char * sh_mem;
>   struct shmid_ds shmid_ds;
> 
>   key_t key = 0x1234;
>   segment_id = shmget(key, segment_size,
>                       IPC_CREAT | IPC_EXCL | S_IRUSR | S_IWUSR);
>   sh_mem = (char *)shmat(segment_id, NULL, 0);
> 
>   mprotect(sh_mem + 2*PAGE_SIZE, PAGE_SIZE, PROT_NONE);
> 
>   mprotect(sh_mem + PAGE_SIZE, PAGE_SIZE, PROT_WRITE);
> 
>   mprotect(sh_mem + 2*PAGE_SIZE, PAGE_SIZE, PROT_WRITE);
> 
>   shmdt(sh_mem);
> 
>   shmctl(segment_id, IPC_STAT, &shmid_ds);
>   printf("nattch after shmdt(): %lu (expected: 0)\n", shmid_ds.shm_nattch);
> 
>   if (shmctl(segment_id, IPC_RMID, 0))
>           printf("IPCRM failed %d\n", errno);
>   return (shmid_ds.shm_nattch) ? 1 : 0;
> }
> 
> Fixes: 714965ca8252 ("mm/mmap: start distinguishing if vma can be removed in mergeability test")
> Reported-by: Michal Hocko <mhocko@suse.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/mmap.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index d89770eaab6b..a4238373ee9b 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -954,10 +954,19 @@ static struct vm_area_struct
>  	} else if (merge_prev) {			/* case 2 */
>  		if (curr) {
>  			vma_start_write(curr);
> -			err = dup_anon_vma(prev, curr, &anon_dup);
>  			if (end == curr->vm_end) {	/* case 7 */
> +				/*
> +				 * can_vma_merge_after() assumed we would not be
> +				 * removing prev vma, so it skipped the check
> +				 * for vm_ops->close, but we are removing curr
> +				 */
> +				if (curr->vm_ops && curr->vm_ops->close)
> +					err = -EINVAL;
> +				else
> +					err = dup_anon_vma(prev, curr, &anon_dup);
>  				remove = curr;

This separates the check for potentially merging previous to a later
failure case.  Would it be better to check:
	if (curr && curr->vm_ops && curr->vm_ops->close)

and not set merge_prev = true, ie we cannot merge with the predecessor?

That way we would exit as merge_prev == false.

We would have the added benefit of not having to look at merge_prev &
merge_next case with this vm_ops->close in mind (case 1 and 6).. because
I'm pretty sure we can currently get to case 6 in this way:

merge_prev = true
check for merge_next.. can_vma_merge_before(next...);
is_mergeable_vma(next.... , true);
if (true && next->vm_ops && next->vm_ops->close) /* Fine for next.. */

Remove curr by case 6 without checking curr->vm_ops &&
curr->vm_ops->close

If I am correct, then are we blaming the right commit?

Perhaps we should just fail earlier when we find a curr with the close
ops?

>  			} else {			/* case 5 */
> +				err = dup_anon_vma(prev, curr, &anon_dup);
>  				adjust = curr;
>  				adj_start = (end - curr->vm_start);
>  			}
> -- 
> 2.43.1
> 

