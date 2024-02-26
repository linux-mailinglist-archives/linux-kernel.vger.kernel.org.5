Return-Path: <linux-kernel+bounces-82114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D6F867F76
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10F0A1C28CA1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C231612E1F5;
	Mon, 26 Feb 2024 18:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jY18fYh2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="L4GuXSVQ"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61451292FF
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 18:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708970458; cv=fail; b=ODxdMhq3H+ALLXW1t24DuHu3I9YIeTx8JhoCXsPu0tYVV1APK5g2b6a1njTj9LTCLMKTHL2ZjpJd3FR5D+bc5TLSUGcmUNlTPlcVMTmFXSmwLSmzdERxT8hm4I56eGEYEnft8uNO61QfxydmgwYOMXqf3q2UpKKtg9T5nFioJqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708970458; c=relaxed/simple;
	bh=vJVdLe28lDQiadDFXR3y8B75ViYkuyVefubOWjPhb8k=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VHbbGjIWoflhMCiX+LQcEItfDn5CjG2TIs2K9BhiQq50jThZ7n6gffpaB7jQK5MPiUqemUg/Er9KRJmjQilZ62Y88ElNfzqoKVheWEQaoLo2ZP/34N3DbcRhQY5XMuZZ04om1L7vnstw4eiMJIUgeCmV5dh6STU1bpU/shQWr0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jY18fYh2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=L4GuXSVQ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41QGmiJ8027972;
	Mon, 26 Feb 2024 18:00:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2023-11-20; bh=rKVGzEDSRaPwlKKl5kASJXuQiKkkliJgqrs8FAK7A6c=;
 b=jY18fYh2s7bwexqNjdL+r/MDVnLTcXrpPzIvsig7FKxn5vtxUtjSR4+v3qVi7Uk1gSZb
 1xNqqPnKyenkt9UFxX0oOsdGR9hn8aRIJEtJsmmCS5lWTIV1Sn5aRoRDYJ0hds5Ri0t4
 4rHwxw2XwdYc5ghXORRcvKIxT9mRWT2/xK02iXYBb9n1XLWw/tzZ/X7RR0kA0DYvizTj
 S1Q7DekvKMYuvFMEHddvWeQBzQOnKiKNVGP4q6GquVvKhWjevt9NKJSz0ZNtNeiJLOgB
 270WFUEcwZWUyfAZ7qXmZKP7KD6XyE1j0Mb+80TSiH0QRWAv9TS9GAQmQ3R9aWmX4j4d 9A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf6vdw9de-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Feb 2024 18:00:40 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41QH64F4025727;
	Mon, 26 Feb 2024 18:00:40 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6wce7fj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Feb 2024 18:00:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CFMrzb/cZ3SxDMs2DtS5h1/RbgzUb9NThtfcldMF/QOmDZ6jSB2iKhJ01MNpNd4z6VyRpsIS/2Oy28+qGfYJjnxYDDFW5ClGY5CvWT3EvDo33gRzFkzkQ31BGHtcIbahkWMc9GWi4gwhxO/lN3VTJE7PUPOfaYybvbsQ3G9Nk3gPLAhe+4U3vk6Tm/KQJkPvreayVrOMsko2WTizivq0xTLh9q2bBXUu+qq2DTrEQuCzYOB90CZbnfAuqoKDgMGqD73VGilqOYJPSsD93zSRkHOxpVml+KpDplR12XUGXwSk2XQTIDayWorG1/DX45LougKd+xCTUS44EBVMDPuPsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rKVGzEDSRaPwlKKl5kASJXuQiKkkliJgqrs8FAK7A6c=;
 b=IqGkAZNRM/+oF9X5pIWD0FzKcZFnIdeM+LIJZ8FUMaCCEGMLNhEGD6ITssAu0+lJf8+0Yg9jA2l/54gyqOqXUzLwof1oe3k882P0p539kEyUiaIiuwVhlJl7Sqq7JtyYEwEASMLSbMj8ePukvaTDdIXSOg5Fkc6ON9sy6pJMa1JetWkZxUT4ks10raIoqo8kY/48Stu2pILb4Z1XBgXQcWmyl8iC82+Q4awKvBXSceVZOe8Ddre/sMnEmThrlfKZwixyavSACmWcB9D2bzXVU9mQUSf0r3e+F/LDJ/Pt597XpIYPCCfbZSjOqth3/oTo03y2hx2yJLMmZXPkMksO7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rKVGzEDSRaPwlKKl5kASJXuQiKkkliJgqrs8FAK7A6c=;
 b=L4GuXSVQQsSKcc0NZNY/hUbVcKcUDSk0Eq01Va/zVLdVTo0x5mzRRaxrF7u2Whyz6bDoO4w1i8OghPysWw1BDNeJkknPUSRox5KKy6bciZEc8vxAGOGESUx06i6QpuVjBNPYxtaOexE74jzeomg5Yk6rJIgZvWGK3vtvRNSrYQQ=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SJ0PR10MB4781.namprd10.prod.outlook.com (2603:10b6:a03:2d0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Mon, 26 Feb
 2024 18:00:37 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606%4]) with mapi id 15.20.7316.034; Mon, 26 Feb 2024
 18:00:37 +0000
Date: Mon, 26 Feb 2024 13:00:36 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Helge Deller <deller@gmx.de>
Cc: Yajun Deng <yajun.deng@linux.dev>, akpm@linux-foundation.org,
        vbabka@suse.cz, lstoakes@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/mmap: convert all mas except mas_detach to vma
 iterator
Message-ID: <20240226180036.dwchqlq45p4zdz34@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Helge Deller <deller@gmx.de>, Yajun Deng <yajun.deng@linux.dev>,
	akpm@linux-foundation.org, vbabka@suse.cz, lstoakes@gmail.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226061624.860382-1-yajun.deng@linux.dev>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT1PR01CA0056.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::25) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SJ0PR10MB4781:EE_
X-MS-Office365-Filtering-Correlation-Id: 79a76f8a-9b32-46e8-1231-08dc36f4d644
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	/h72lu8ydDLFGd618q3raPX+aJdC4hUx6x3427PjTPZ8pi/kh91h8+dWrRRqMSFixdVlPHTTOIjWGlouo0JwQvlJ3+wIPbzpCAWvEAHZ1DWjQlBIj2/TKdbqJhEB4SobxOSqptuToZHBRGSObUGrIs0hwPucSMfF3fpavdSS24xMbPMHbl9b7rNlDi4+cN6YvyCLNGoX/Z4DoVvObeAAQvFxoWPtrBA0O5PRnAjQQjVOJMVfZ+0226SUwmYuYYv5elF2q7+xhhO2g9i/JJSTBTmAX0AHP94n4MpSKNF6NEMEBFYvF7DqndTCstfwuLQ5qYT3PdLbXSNPng07NJaC2zdgZtpU9xAm1+tfqaCJCdHtgORyFkxAaxwesiGRwHXYxUqNJi5CGZ8wQUy/Onn+YYDjNEM5t95WxZ8fEcWkSkhRoZXsdvD9xDx6cy2/2K0GxluPIba+TnqYe6Ww1k1ztzrwdYgS8Si0htPxJNtJDwchxhFOVKMw1ijosFrJ0JBeyOeWKzc08ghipfPo4C0kndLwM/+rF5DBMsLJrVHdg2SoiqC3YeM5Lf5ZbBVMe/FWEAR7Ny2h5i14UwzyT80o0AlGPugdngvEkOKtPHXXxrersGSqq5++69BN8S2UMQRz
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?wj/ha0VdJOjbwkCHVHXCyp4Arxqdl+bzegVC9ZSBgCKUKcZux+uv4gmxJh+Z?=
 =?us-ascii?Q?2hluxeDGauK9kwsFeesKNdXMDhU4hRI47xnTBcjBjl8fsfxoSN1ke1aSy9w9?=
 =?us-ascii?Q?30NQrhea23/yBt+TBzL2x6FgkzjodTyejkQYpQv3FyH16HogNT0tsbU0G/71?=
 =?us-ascii?Q?REfxSjKJG8I3zwZi1nWoMbrUVOhVUwU/p+PwD5Se2+d1wY2WRUU1AaKXGK8a?=
 =?us-ascii?Q?nv5eAw7gGOhwylANntHz3tw5MHKIKyK7EB6OCzCA/IdQlT0mNQ2QKcGYKoVr?=
 =?us-ascii?Q?L6H2fUOzt+LfWTdc2z6zkVhpPNOT5kPSH9n9WaPfLblsVhxmVZSxlVFTe04Y?=
 =?us-ascii?Q?+g97KU/BQH0AvuDQP27hHzW2T3lxblfVjIajIflW72Oo2S9vPuwliIth1V2C?=
 =?us-ascii?Q?veU5AaXgpbrRrrro4hc0oq3iIiEG99x8bnRLDt0wbFj14b6a51gQLQ0AB/QH?=
 =?us-ascii?Q?KdkwvPhG+kRRN3u8aWt4nAQ0Un39vqHjo/tggFAIQ9UG0cmU2LwcqLkJXue9?=
 =?us-ascii?Q?8c5kt1JZnKyRTCrGO17dhBxJf64eATPhEjiHhrhurAch/X7km24alA5qKJXD?=
 =?us-ascii?Q?r1f9nSPokDkMxE4hCN4xwAJHpD58c5hn188DPEiN/yXXWcofPhSWq+WhRdtl?=
 =?us-ascii?Q?MHuvvdjLYNOJ+7CvBldJHuObbkYl6zYu2a43a4Tjms+SJk5n4Qid2j3NMYlL?=
 =?us-ascii?Q?PDhnZppH7E7iEG67O7VHEnCH3MyVwj3AxIKlTBQfySwwEZdSBthUG2RBsGPW?=
 =?us-ascii?Q?at31Ef0dUlRNc43bZkTQflTeRLuC9Fa5630vydYYHfE8/T4cJPc764QCboDR?=
 =?us-ascii?Q?wGt5trqk/BVqRokabh5z8r/KIwkYBQNBSlJZ5xoKfLagf5U9Fv9QDVNcAn0M?=
 =?us-ascii?Q?+1yIxBUypeqqJ3Hw6vXDWEs/s4KbNPM1vqiVIQ0ewYL/NQDnKVI1lpr4bPJl?=
 =?us-ascii?Q?5zX2ItlIFQDs6JBkcYPuxKVqd5wAdpGSuoeqmGdoD0okkLX+6Tniks7jBhBp?=
 =?us-ascii?Q?VnMj4gRPx1oMsayPhJ+WDQKDt69RE6D05mYxkTUB0n/KY2L4eno2asOA3JGh?=
 =?us-ascii?Q?b2W6ScQNLAsGeQfhDcY31Ie6HNl2SFbb1YjR7ms7z7dVxq33U56+zUSyhLEx?=
 =?us-ascii?Q?CRJIh0cfxWkugjA39PpL3Z1RZBVbd7kOFJzNwjr+UYXF4ol3+YTqZsHJCzuF?=
 =?us-ascii?Q?zwmLhQOPoGK1NaT+xXAmcg7JcNdhQZbStqH7z036mkZQjaoSw1LvreJEIEME?=
 =?us-ascii?Q?7nhb1gVuA3r7IFoZ2+l/J5S7EshLqiK41krX4r9kgSEgBinVdJ7oQ2FY8iVV?=
 =?us-ascii?Q?P9MRP4JEqA3hoGkPF1n4vpZ9sw25YrgBL2fzvU7HpoTSKkMZIWa1+9m/rDxw?=
 =?us-ascii?Q?+AA0fONMz9CQmjLYZ3Jo+aS8N0SvxvkvB/L4Oi+M6DT06HI/9FneEqVC3mKj?=
 =?us-ascii?Q?+IRV94Dm5/d2TCDgTZlMisP5I5fdd5nW7xd9r7AHjD2SBs4zxBFfD6iKYUvv?=
 =?us-ascii?Q?C6v+MkG7Y5K1F8IgB/TbWFxb2SlCC8r25IRqdiK5RvQ+F/lMtX2eR4Gp6qKy?=
 =?us-ascii?Q?Twix7haxl/sBdHBDvTc54P5VgZbzzxaIBm6vyLNL?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	veOtryGQUSdrvMleo1eWrwwi50yCFnHlqjLENDdBkB/Wg9jyPCPxQunIsGjSTSBBFDyZFpdjLDv7I/u7NT7J3i3/UZJP7wvgi8D3fq94daObGDk3t8XnKnYH8HJTCv8cGRmy2QEKfc8VCgAm6/nwYWcSiOcK2uhsSGJxGM4EE3giph0Fy4ZGJRhDu1dHw8MMPkFp9+5mNzduxrwBTPwzwG5RiHjY/vXmn6QHQ99szbiPgr6IltdoekS8opcVEpl7Ygo++zFJdVSngrhS5463iutLgNRwVQx+FZ4njHEGnSCNFPPJDzWWmA8f/cqB8pgPCCF01ldcpsRY3lul6RsZJvU0qSVvDIoDJIyRCdnJaQZTKFX+cIxaCrZ/XKs5Fcd915+6T3cfvI8aSH36HaGOYbfEUqEa4LE3+3k04UXShodNhZ8zuqi6RrcCCIF/sZ8l18owuVAWea1G7zvH6K6C9go5DbaVnk3lr6xNZwUYslQ5e14pqgnCC82Nj9CWtr1IjPfNfubfbjBYirWNl9salYv4qXLLb+fDgl605nSreQUdTc0SaquoQpUBNiVT63kMPJOAjSjZDhttyARci5T1eUZDaZTD3hcryYrzn5qwC78=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79a76f8a-9b32-46e8-1231-08dc36f4d644
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 18:00:37.5687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vgY9Rg95nvLBPqJ1kEtGIUIR7NX4FfdIc22Te6VfSAPpfeGAWHISWsqmnCYj0frWnCLo8hxW3k0Q+42w0Vn7Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4781
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=724 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402260137
X-Proofpoint-ORIG-GUID: TEle2rIskqqJyzbxfCHPBCMsn_JFHJqt
X-Proofpoint-GUID: TEle2rIskqqJyzbxfCHPBCMsn_JFHJqt

> There are two types of iterators mas and vmi in the current code. If the
> maple tree comes from the mm struct, we can use the vma iterator. Avoid
> using mas directly as possible.
> 

Helge,

Yajun has changed code that affects parisc with this patch, which hasn't
been tested.



* Yajun Deng <yajun.deng@linux.dev> [240226 01:16]:
> Keep using mas for the mt_detach tree, since it doesn't come from the mm
> struct.
> 
> Remove as many mas uses as feasible, but we will still have a few that
> must be passed through in unmap_vmas() and free_pgtables().
> 
> Also introduce vma_iter_reset, vma_iter_{prev, next}_range_limit and
> vma_iter_area_{lowest, highest} helper functions for using vma interator.
> 
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> ---
> v2: Add vma_iter_reset() and vma_iter_{prev, next}_range_limit() helper functions.
> v1: https://lore.kernel.org/all/9f76ce23-67b1-ccbe-a722-1db0e8f0a408@linux.dev/
> ---

..

>  
> @@ -1975,7 +1974,7 @@ static int expand_upwards(struct vm_area_struct *vma, unsigned long address)
>  	struct vm_area_struct *next;
>  	unsigned long gap_addr;
>  	int error = 0;
> -	MA_STATE(mas, &mm->mm_mt, vma->vm_start, address);
> +	VMA_ITERATOR(vmi, mm, vma->vm_start);
>  
>  	if (!(vma->vm_flags & VM_GROWSUP))
>  		return -EFAULT;
> @@ -2001,15 +2000,15 @@ static int expand_upwards(struct vm_area_struct *vma, unsigned long address)
>  	}
>  
>  	if (next)
> -		mas_prev_range(&mas, address);
> +		vma_iter_prev_range_limit(&vmi, address);
>  
> -	__mas_set_range(&mas, vma->vm_start, address - 1);
> -	if (mas_preallocate(&mas, vma, GFP_KERNEL))
> +	vma_iter_config(&vmi, vma->vm_start, address);
> +	if (vma_iter_prealloc(&vmi, vma))
>  		return -ENOMEM;
>  
>  	/* We must make sure the anon_vma is allocated. */
>  	if (unlikely(anon_vma_prepare(vma))) {
> -		mas_destroy(&mas);
> +		vma_iter_free(&vmi);
>  		return -ENOMEM;
>  	}
>  
> @@ -2049,7 +2048,7 @@ static int expand_upwards(struct vm_area_struct *vma, unsigned long address)
>  				anon_vma_interval_tree_pre_update_vma(vma);
>  				vma->vm_end = address;
>  				/* Overwrite old entry in mtree. */
> -				mas_store_prealloc(&mas, vma);
> +				vma_iter_store(&vmi, vma);
>  				anon_vma_interval_tree_post_update_vma(vma);
>  				spin_unlock(&mm->page_table_lock);
>  
> @@ -2058,7 +2057,7 @@ static int expand_upwards(struct vm_area_struct *vma, unsigned long address)
>  		}
>  	}
>  	anon_vma_unlock_write(vma->anon_vma);
> -	mas_destroy(&mas);
> +	vma_iter_free(&vmi);
>  	validate_mm(mm);
>  	return error;
>  }

Can you make sure that the expand_upwards() still functions on parisc?

Thanks,
Liam
..

