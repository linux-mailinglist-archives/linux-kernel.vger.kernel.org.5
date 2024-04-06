Return-Path: <linux-kernel+bounces-133743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC2E89A7FD
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 02:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C954EB21C16
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 00:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7970811CA9;
	Sat,  6 Apr 2024 00:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SaHwjaLh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sWOwA0rK"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C11CEEB2;
	Sat,  6 Apr 2024 00:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712364814; cv=fail; b=t5oFgQoOsNyX7Qw0lvsWCDjVqBFNGLcHsW5Dus/Oej1PTjsUfH321I+zZjv6xhm48kHWEZFfdVeKoJWxR3bJN5xEdBeknsX9YT6TkUOBqZg6+yRAG34vbLGZFsrrO4dvtuyl7YzkS9T8DPwz3rVhlA0EjLdUuHBhQZUMitfLTxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712364814; c=relaxed/simple;
	bh=FOylfqPMGqLZM/uBkh+IhauucbHpTtnE+W6KT1WxGaA=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=HPF0yHuKUiii7bP1fepBb++MyWUas/MDe++MfgJzVoTxX7Hn9zG3u5NywXjoCdP8i8aQy0LHh+mbWf4YqxHtHCoXTvUmULSW+PC5TG/Bqn05RNCOS4zXuQI2eijQPak6Co7KDfl4dECQRCmcdhh/IqodCqLXkcJFrpzG/CwKoTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SaHwjaLh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sWOwA0rK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4360iriQ004670;
	Sat, 6 Apr 2024 00:53:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : in-reply-to : message-id : references : date : content-type :
 mime-version; s=corp-2023-11-20;
 bh=giv6VHLh/HJLW8aE9pQtbNfdsNqczuNPBLitTuo9WQM=;
 b=SaHwjaLhZw86TsU8snqS82KsQDeLs68id9WXST23Bc0lphhYycXnBdd1zskqNglnmjat
 GVwtvU2FXnsQuXtAb3PR+obLb0BTiKTDITqpYGWmzGNg2W4ZPtWGKmy+EZTmxDNPYBDO
 Gi2/SQ4qd4QRnhHnOclCCHVZBC65Cild1LLOVhFKEvD/qIakUFYuPuEzNRKBSAaKdM7E
 0ytuzD2UeECgEmQ8e9+ir8JsxD3CFTjGTyOgrxoPQqHMNdd3W6aiEbr+jumGgMTpS4IX
 i/OqmVxuvpMeerNK5PZ+Ql4Of4KDlbUPYHsiRVGwIym87Dxq27SPS/Fp75qk2+2vTaZL Zg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x9en94mn8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 06 Apr 2024 00:53:28 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 435Lmdp4031239;
	Sat, 6 Apr 2024 00:53:27 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x9emyrkrn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 06 Apr 2024 00:53:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CnCpkB9HqdxfiRwxZcJRBf59GsUA8lgNInbR45671nzIxKuUDyOBzTPr/5la2uArxvkhZHtqfDEcKRujhCkZWCzbt0v8R1o9c2bRT35TZ8HDJzFsmflE+K4uUuEgMpMoRvFhzIX0uC+3Ddnwo/be8kl4GlARt8WQ2dHCZ3+3XljFlFtBpSTo7NpK9/X9tx25erR9djsNuqNYd/aZgi/5hVnB2FFgPPy8zJp1YSAnCTdQL5+/LyPNqcaXFMCn87AraAMYAYHRWZBY3TTW+mDvPzmxUXZmEYZBBF2nskF6K+DysBqdZSWS0nla0/GBUcmfjAdF1wZpDoF2WnttsiMZAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=giv6VHLh/HJLW8aE9pQtbNfdsNqczuNPBLitTuo9WQM=;
 b=Xxa09HfjaDZQxBCZkRmSnHzqRmHEg0D2jxKDWbFZqIvtg6HnRlVvfMOOMtWd+qWSOC6gEUdPrj4GJ/3cP4YhcCAA3t1drfDPzzPVkj6+iZIXkVTVPeowhLtuAy+z5ZZrirzT+gzj1M1Bd1r+un2/RtUYHlESC6M1Mrufsrpwb+GxiwXYGDVAfbWf1wytx8BOD97OEmVr82LRhhXvmUSiQYxdnKchztLRD3tV1B+o1FBQuKlvU8BqISXWagG/xTxMYhOl6RMaqzXJEeyb+7hjapx06GV0E928+Z4Zyoup4LvplL79s93V54vPHt2PpIGKK0GpmzUpdNH310Y8slYkXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=giv6VHLh/HJLW8aE9pQtbNfdsNqczuNPBLitTuo9WQM=;
 b=sWOwA0rKzDmMF3hUomjMRtgFxTrD5aMLYTPhOUMkVTRBtQQ+WdmsSrmfyAHjcxcIM8+BjOHZTx0XFHNDRMkjKjMyWdXNZi7Zn/ifOz2MyXk1TjJ6WDG9Nvq/8OHqfpkjdvg+0uydlYIuYsR3aGbb1WqoY7c1g0TZBARcyxyapR8=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DM6PR10MB4268.namprd10.prod.outlook.com (2603:10b6:5:220::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sat, 6 Apr
 2024 00:53:15 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7856:8db7:c1f6:fc59]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7856:8db7:c1f6:fc59%4]) with mapi id 15.20.7409.042; Sat, 6 Apr 2024
 00:53:15 +0000
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen"
 <martin.petersen@oracle.com>,
        Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] scsi: csiostor: drop driver owner assignment
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20240327174921.519830-1-krzysztof.kozlowski@linaro.org>
	(Krzysztof Kozlowski's message of "Wed, 27 Mar 2024 18:49:20 +0100")
Organization: Oracle Corporation
Message-ID: <yq1h6gfs45n.fsf@ca-mkp.ca.oracle.com>
References: <20240327174921.519830-1-krzysztof.kozlowski@linaro.org>
Date: Fri, 05 Apr 2024 20:53:13 -0400
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0357.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::32) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|DM6PR10MB4268:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	pdsKzLu863iA8u9GqSKKG8FubNbCp9N0mrUyLoQPd5LsskOR9s3dpUwPlpZC2Dn6IdzbXcX2p3zRKLcJ80bH32S1ZLhoTXCviqoDEmzrSqXHjCdV5ZozwV8wwQsUFyU+fsrNqXMV0sE88bIQalgypOuTuTxBJ7X2DsgTD3P+nsAIHm5Yv0Zzi4J3TN/wqCXej43TzUPwY0JcQCVHneFkHWVX4UohhK17BxP/ByrN21HlI1rKfqqIbz8HdL/+9J7qQwQb1AyoRbohWM76l9fpSx1h+j5Tcf5HuZ/zRnAgvzpOe59ELZP3XngNsvhP1Nc01r6AhpoxpOGDPofcHVHCWPpVERbWOUp1R4B8C3H7Hbp6aGf9WBhiuxl+nFwvhglvOygtS+VlcSTQr9K6B17jxJHjwryBQgFmx2OJNRbzfKNE4rPV4L/jNOZURURVBHEci9KlKwtLkZwpe1relA17OWgWom3a5XAs1ac+qjXY8IPjNECnZ2rmEziCFoh5bYSJE351cEVj5Zv5B/jUX0TCdWrnNzQ98X/l+9TOunZFZ7UoEkaDSXFMxznY0K/0pF6olyomEuR7Aa9zdEPiDm609VtD76soYT0z6+K8vYB4EChKjDx7CA35/tOweGVY7Vph1DpX69a+pgJFHmuDmP1vFQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?be8qZYKgCK51rQYHW/yigpBNkskZ1D1UuMfyhMK7LQWscncm5Tcw7ovezk9W?=
 =?us-ascii?Q?ZfMCsDKdnzfY7av7qABNyyMuHTAMnPSVV+s0xQOsDyUL4hKWdgLRUPha8LMj?=
 =?us-ascii?Q?vR8TfTBQEQfzD7S78+bp2ouR2Dm3W2dl0+M5OpL6UAqjbUkfUE640ZEfAB39?=
 =?us-ascii?Q?/fHmxrdnRng2F/H8m6XNsY3JHJtAa52eSCsCLNSLrW///6qMnU7mEtdz2xov?=
 =?us-ascii?Q?+FnB2eSagyU6M8kTnbRPpuosBrt7OkpsK7sgCva47AshWQLaj5yV6S1uMrz2?=
 =?us-ascii?Q?KxQ2YgEDCMI2Vqvr3dd2CXtO1+N1rq/NomlOphxqS6Psk4PcwsO2ekzNKFpl?=
 =?us-ascii?Q?3DdcXiZ9w/r+Qhdkmb8WQFBYmWlBwwkbVKqmuwIFerLk5p6vpjpYdk7V902P?=
 =?us-ascii?Q?sr9LamZqKLXFZKptRVoKlmvn5WLj45dmz/rCAhq8DU9xoWqNV5lfRQL6tAt3?=
 =?us-ascii?Q?6FPE8Nxu7UCqYNFv7twPpKhFJKV45/SHNj6yu2xCJBS9DxlFPojX74BZ1LOt?=
 =?us-ascii?Q?SAk3V4gDRSgMGBHU6WUvrfbzapkXyPTNx3iGSFfKiecSlXjzq4l+dS0W4GvQ?=
 =?us-ascii?Q?00/I7vEs00rqGpXuuLATEFyDjw1uK9bCPRC9XMKtvdB3fOu3GoEsvbMeR/lI?=
 =?us-ascii?Q?sVH0Kq1b8vC540+FwUOfPvi5jvQeu2dl4qnKFS1icft8o63u+I1FOGjISHGR?=
 =?us-ascii?Q?9AWu4q+MR06+K97NLNJPGd2BcG5rRQWk8VeWVTo6y0To2bt2MfL/LAEryqoi?=
 =?us-ascii?Q?4JinOBXcsE5ks6PRrAJFgGIMGBYU4eCjYVJyiR7IgPq3nkTwvCQmC9nfyoN1?=
 =?us-ascii?Q?biZFvWxL/tLghkCRy6MgV4pITpBGhReb4kcrftSEfBd5t5rnUk1EyxD/IuxX?=
 =?us-ascii?Q?AEm6CE+10eYfce3vHgotjxMC3g1lUlIUrJPtfhRNmQFGskw2rXNmbIL7J5Z/?=
 =?us-ascii?Q?K2gCnphLD2IsHzxeL3mpamIzW4EP+0Q1jR9fm+BdxSWACYtrHv6K4H9J91MX?=
 =?us-ascii?Q?fhpStYL7aMqGd9282dmMa76RnDeCgDrz2rTL6vqnVa+rmlQhWqhALm+YFxJF?=
 =?us-ascii?Q?Ib8vEP22N7aNJTrPQaVowSUIewRhfPDPJrJ84sh1RiqxzcMWt1cAe84m62iw?=
 =?us-ascii?Q?aOP1qabMezddfbtO3Ou2ISxqYKlj/VwxKyRW1zm0OmDI9RubqfhiV83I0wxC?=
 =?us-ascii?Q?9UcaRVYDHTzGJhGwXijjIrRa7RpZQTMiWfTL9zblK+bUWL4N4doogaG+hwcL?=
 =?us-ascii?Q?x4mBNDuidlzrG3j/vnFSIwNurhVPpNY4h0Qo4UDJpr5WI+SKBlYzE0zlXXSx?=
 =?us-ascii?Q?LzZkg+Ak0CjflEqTvR6W+rlm4WfNT4ddRPd4IuZfn5aHdkQnC5plp16Bjp8e?=
 =?us-ascii?Q?x2z0wPHQG8YnSKnUZQHYuvwMW5i9e6FZtRgnSFQpaIVLkxN9AMkveRfRot4v?=
 =?us-ascii?Q?5dwISuMUW/A4cJKyEDfpF0ulvUf3CypXErArQSDBbaQ5PXampFsZA7/f0m53?=
 =?us-ascii?Q?KjsNB323kIqi2ySzty4SvizNJMV+YZ6e0pkugFg8YwGy+AeW4Z7Va7nX/2xe?=
 =?us-ascii?Q?2HC6i4QzYWZSKqD8zXs/SD/7rvrE6ktpyH/gMccRVpvqS+S12WcTR8cfViVC?=
 =?us-ascii?Q?rw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	c9hd3aFpzD4B3gmhobF7jzzO4qeZVqY2P1Dxfc7WqK6P3q5ZkgCgIoJu3E8sUP31UXK3h/zAiyGkcN0fykXVT0z1fiPJnFvLl70JSawQfKTsScnjVvAKpXJWN0ciPuwRFBgLpsqLRYrPYCyyL7C/7nm6g8ASPKHhFyib123w+tPotbj1223k38DjRLTaIyNJ5e3y2tVSWVPXSEmuCbq/K0qjcHg1/7znd3vEv2cs8aabzVQ8kHsUD6PnNrSRk4EgIlht+RRRTcho5Dz9UCIsaqqoaZEMtGXdlNFlqUKQWKQL7GiZK250PrLjZaUK/pWPDpqBP3oCv5NLWgxMfCxtNt4jxfpUWlHYzVeWH3bpxhMKMensTKf8H/n0yxMNM2cK4x1/eogv0RFQeBF068zQ2jCcfozV1tCZv1zgCt0nTRKyolpPhHnVbQQPxILeAsuIRaboHLrt6bDiHfP6L6uUXFbaq5bm0+5RXQaTByLMmbvQjkSnhoXHWNcGSqxESonSN/cz6Nc4/TB1ZHd3WSbObWlP68jkSyGz+bmlM15UU7pZxWEUKpdUIYGVKa94l4scf1biDYnUuWIkVqi1V0WLdK5I9Du6aNMYzFHE6518ljA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7ec4b32-5c01-4f32-35d0-08dc55d3f164
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2024 00:53:15.7864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iWzQXpZN/IGxW7DRppM9YZetqlQnnOsr8lzAt2GonLwypM57sxKcVyY1ITKT7hNxHnxJTQk5SHo86s54h7WAuSfHbWFVyQVAwo5dkEdPULc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4268
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_31,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 mlxscore=0 adultscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404060005
X-Proofpoint-GUID: 3a-mJPODExSztC6G7WVQyNzDzPh5iW2F
X-Proofpoint-ORIG-GUID: 3a-mJPODExSztC6G7WVQyNzDzPh5iW2F


Krzysztof,

> PCI core in pci_register_driver() already sets the .owner, so driver
> does not need to.

Applied to 6.10/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

