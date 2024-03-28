Return-Path: <linux-kernel+bounces-122209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6054688F37B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 01:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF2D81F2BD85
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 00:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A8713ACC;
	Thu, 28 Mar 2024 00:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="M7RwU+wj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WkMNxw5D"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB4D1118E;
	Thu, 28 Mar 2024 00:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711585142; cv=fail; b=mJ5HlRNAUK57hNMWeFLprg+RVkJ0WHhTmlVNf0LcuKNJwLq3W83azsLvxbMPx2fpXNkbyuMuZiVSiqwGqsWhLw9tJNyVyb51gXxKNL1x4t1WTqjO1RAaPfh1FGwEV9QjtabhiGChVJ1+wXTOYnXBG32j2IPTpiRF+p9mW0U/tk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711585142; c=relaxed/simple;
	bh=kOawVUAYvyecCcnLaSdFf7UemZ25W6z7sQBFstfnxSg=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=aKYeJJS7n/dIaCEat9tImsgW3Pl/Nj4c0CbDHq5bjtA4SOQFZn5MwbAsN41Aml+Mcl1H/6tniJFTqwhe97LT746gIEokDOAg9p0ydcq4h9jelZhTQWLk2vq93H7HoiEEt3vXQ1FT/lZFj3HleXXDXQBjYzUgXiqYIanfrccHMzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=M7RwU+wj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WkMNxw5D; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42RK96sQ026538;
	Thu, 28 Mar 2024 00:18:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : in-reply-to : message-id : references : date : content-type :
 mime-version; s=corp-2023-11-20;
 bh=onn8MoZA932yXyGMruSZHMv2e40tUJJOky6sFlAv0+4=;
 b=M7RwU+wjafwQaquZaPBhFQhBLZf61Qn4fFjxHt/+bi4etV12JlcJvx2fqFlXshp54b3u
 ZiRhQoupeKYBg5xA+93W80TSNX0jBiLiT77UflYhce3MJvkWh3w9Cv6Mtg66Rjhv2GHL
 m5mkFb5+7HXPdfkJMNJ2UnQ4p9/44MFMgbRAyh7Wi0nzjI/wGv1N3ymHYm5HzRYJwyEi
 9i/KBkAdYXtkQzqD1XkCbC1aI1czO1TPpjNsIcEcbOlsz3ybprw3s6B3KJH45Must3Ix
 wmsg7FO+5ceDkAhzSuAR7LybJkFAZVj2nZ2vR5XGPBchYurMj41fF++puGTK+a7faN2d Gg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x1ppurj5x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Mar 2024 00:18:51 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42RMSXD2014369;
	Thu, 28 Mar 2024 00:18:50 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nh9a5wu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Mar 2024 00:18:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A2+jraKE9CLjB5WU/4pMumgc+yWvoiya13nvgvFblIeXO0aA2SSF3lVvLInio8e94qyTwmqXFQ/dyLqpnLtYAFvk7H1ck9HjHy7Uhimn7U5VVVKcfYjs3gsQOaPFZD9S3bpAP7Nk9GCSY3FPhooEQ8RX8LBRaexi7wMMGvvZGd8TroKZygLDkIhMVMtJ/gVKw8QEtD4Au+SwpEyiIh+iKS/MveCb2IhdYV0s15PHDjLYBwrvmKOwTJCBZE8I9No1mCOBA9TedSZjWYdFM1KF0t85CqvdypHggadM5UsjE4iADbfMIOKa0qf1aPjEiR1nl5idRLpYY3eqYUM2tGQV9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=onn8MoZA932yXyGMruSZHMv2e40tUJJOky6sFlAv0+4=;
 b=jHKfhfS0zbkpaHlzsu0808EeMavLgxp/VqflpluDnOVfDCnidsClH5QHLU5lbWKvbsWMPZAcWnFsqSpa++2OH6fABImH3SySm1BB3l8Yw2eTgjtwfm1zVccEveLZOrmQQwc/nDkZTfR65Jmq/WKPRHuSBDJ8mtOhFwQrzv76oRSXpDgjdbPhAnCXRYZgXOG7TdTpYX06v+5wYGKPNS/2iTIeTjJO0k5iQA+4YqgVPahUQ2UQMtwKJbMuFWi5Umit3RccFZ24rQg2Qg+8CR1UM/3OqMPT2fQQsCev52Xctm5gDYQZdzRfK9IzeuJrklSJ7W5JYirkY9LVjuhBcMmOVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=onn8MoZA932yXyGMruSZHMv2e40tUJJOky6sFlAv0+4=;
 b=WkMNxw5DU5m5Ou89cqLVIoAOBnGwnGi3OlmTfyIYxMl2CuMoN4aiGBJkHIP10s0rANvKZsg0V/kWRNxa3z/Ak/9gp+vC5ce18nATaE7C/PR58HmWpwyd7T5tZCm7r5xtrMM/mZcOdRXy8HSIfscnLTM3JA1r2IQKfv7RCMQXQtI=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DM6PR10MB4186.namprd10.prod.outlook.com (2603:10b6:5:218::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 28 Mar
 2024 00:18:48 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7856:8db7:c1f6:fc59]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7856:8db7:c1f6:fc59%4]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 00:18:48 +0000
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        Igor Pylypiv
 <ipylypiv@google.com>,
        Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the scsi-mkp tree
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20240327134522.7ac4cb54@canb.auug.org.au> (Stephen Rothwell's
	message of "Wed, 27 Mar 2024 13:45:22 +1100")
Organization: Oracle Corporation
Message-ID: <yq1y1a343bu.fsf@ca-mkp.ca.oracle.com>
References: <20240327134522.7ac4cb54@canb.auug.org.au>
Date: Wed, 27 Mar 2024 20:18:46 -0400
Content-Type: text/plain
X-ClientProxiedBy: MN2PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:208:23a::35) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|DM6PR10MB4186:EE_
X-MS-Office365-Filtering-Correlation-Id: b98d3de9-5c6b-47d6-f24f-08dc4ebca344
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	HVSBiaxRubNz2oXXGE57wfCUrOdxskg+sA8ATO1o+gOVYEHSVnclhat2vY0EKX2bZKQBcXajcOO5PE5+SZK6gTc2MZVSR2kXVifgSeiKQyxrzbATeCONmawilQ36TD7ovWoFSkURwSZCTDwyw5sTKtJQCUXNfAlPpnCzbSSH/OwHQpqv8wiEm0ERxHnGCNh7ByoxMK/rFj8Ecnj0zcCPsQmCezqOQtscuRxkfx1gXDV8LuG9jD7olwBC0MIp6D4iDB8jGMV6hZFDVL7q0FB70n3AQnEYXa3JSoNPoP0ERHj8wUGrPX5RvKDHuxQtNty5QPgU0CoB8NuyjYnhP4SVcPLeFpj6uVEY8evRb5pFMNRQFS6aLY5uN4TarpHex12/WnhWuz8fgDHqDSSgyoMPNeVLcQ4tK1CICEZkhezLxHLFMXYge1wpvebmXqTI9x/Wp1S0IjDOFxk6SvuAvBAAyviXrkJw/nMthnV9EataXTXuZH9o8zRwEDnDaDtBYPyfc7ntoNrNg15rgmfO/rRbOOlzXqpSsUuldjpladST+15IL1zbXGUKKUhTLtVBrl08rijodbbul+/E7p6hx6r+2w8vgFYSRpPZxC9a5sTEm9HaHLzKy6TEubRUQzwwPiHJhFAgz8k3dYDiLcXYE6KEUddOGQaUFrUUWlVejNLRdDQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?UmhALF9Cyk+UY+FjnzJVqH3/iV2K8OJYivaBvjbJ07Dj6s3Q0+6+4b7Um7cW?=
 =?us-ascii?Q?xgDZSiZgPVCFvagHoa95tV1YsmMF+aExFwRSCnCNlLHokxFe8omCi9f+XOHF?=
 =?us-ascii?Q?6KpLdeLbsc8bCyvvRfrM9GbvdbBLexO+HYNADCkdDsi3yDbq6BFZanENKgi2?=
 =?us-ascii?Q?bfRUkT/ro9H1syAlrsi67iHGlzXgik7CvHCb1S8yS1sn/TPTNV09DWJLQaDl?=
 =?us-ascii?Q?1sgw+ZezvEG6nAhzY79/MtbCW3aULfPAJgpyEMcQW1XS6WGMR97OkiB84roX?=
 =?us-ascii?Q?f1AWnA7bbTSO1rkG/3giuzzwAme7Z4X9EfkxwvdquQdz6WeCthixpnPw3xmt?=
 =?us-ascii?Q?1RV8Kkvun1JfpTMZHiyQfN2kafDMFPpTVVcMwOmaDPb0DKTnxFiszzFPd9T5?=
 =?us-ascii?Q?Bh/LN7Cwxk9DC0eMPf1ad64JxSrLBdNTbrY7b5AuqCn/1zo7TKid+vXEApBl?=
 =?us-ascii?Q?QVasgePpfIdZRsZL8BOKJxnikGQg7QwhHG3rxJ3+o92BMd+/DfFYogPC3PKL?=
 =?us-ascii?Q?s5FJhC3bbVKbaMDHgxUAIsf7SQBhZ5tQi+e+AmOyBpICL6WGXcFWjIKlrEPd?=
 =?us-ascii?Q?5THI1Yxrt4WauVNI8gu3QKuftZrReH1jqME+TVOaIi1W+0ckIOAYbn9AY7df?=
 =?us-ascii?Q?wiEjr5QRLsDAjiWKxaZdITEFxWUWabst4Tg2mpsenOlH7+WExfSGUNx5wAm/?=
 =?us-ascii?Q?dLJFxaf9yHLFd606Sd9HRgjR17OYbX2vWvVgSLve7VzTG5tlU0qohVcU/VTm?=
 =?us-ascii?Q?yGr751Zsocw+rg/jwFKgFkgA4ZHa/0f3dCvr4H6xFc7/m8UAhbci2+lRVhyw?=
 =?us-ascii?Q?LIcPRrGR1o/fqlAOAEATiv/hDgEFDdtH8wonm8zm4jdGExy4vCBSPsMttrk/?=
 =?us-ascii?Q?kkltXgtCuG3FdsyLnYLmq22Z661RfA0Znqym2y7NYG7wk9Ryp1gtn8v2aYCx?=
 =?us-ascii?Q?Li2enVw5va+H4lVSVVthTF3pDREruVlE62uxltD3RpLv4gr5ldHW+NEw+bby?=
 =?us-ascii?Q?vZChoYL3Iya+mFpcXnrE3u11IzMwJ1FUn1mRb70rU+8UzwAolMVlsgKEfRfh?=
 =?us-ascii?Q?VwPHVkhsA4B8dyGCkfp/jRYzn11ltqquE+nyA6IDhfPTjWoQH/MWwCHuLWbw?=
 =?us-ascii?Q?RKY5ZnAQvYtxRRLzswaOLMxgt2hEnDMojxJX+M/R+rAhi5FajdVet5H1qmwa?=
 =?us-ascii?Q?ESxdP38nzeGbr72UWlQp11TeiIi7JytGNhlZHEdkAVAyAYoTSkUKEUduOskW?=
 =?us-ascii?Q?EPdyU2XcNEOD1aah9caxAjvScds1inn8+5u82mNEZDQCnCekmjXwgJPzubqg?=
 =?us-ascii?Q?uWAyU+6sFFmzf2fClkefLunc3DOMqX6UnmsXl5SjOQIPaAPL7UCq9HK90OL9?=
 =?us-ascii?Q?xbiZE2HPN/wTfHuRGV7XSoP6XMtfqtAAAtGbNp5KZxtcwF0nPjRSn9iJFGu5?=
 =?us-ascii?Q?63g/26sI6jPH3+XRTcwCjXfE0z4Uf0wipCtolr2ld5kZyqxq22wxlVFMHEct?=
 =?us-ascii?Q?rgPQ42q9uy7OjOpt4d+sLZr1aSJq4DcVHvpkVBzwFK35pEtE8kdnhB/z1d9b?=
 =?us-ascii?Q?EANSQihuvYC7oblTuFb1r0vfBYCHrYnth87cBZesR/BoTctc6fFYFTl37FI0?=
 =?us-ascii?Q?/w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	kseqG9ttO6sq5WdDxiY3AIVTJ6nvq7UhrdNcl+7qaQ+5Y1eHqTKIdeuODzrS1dRhfVyfyMQ1xxG4dr++9NeQttJNwxWfnRiG5FgtbHWK9vesPb6RCOYqBSLNH4TLdHoSYqLKZDO2V1kY3yiRb2ArVxpbipEAR7XjGmXYCQ5C9XaV1kBIoBLD2Cwuxh0nyi3leEaN8f9LzDywIWmlGxaB+9Tj/stmoEzhRuYs0hsQDd6k/G6QyzmDLQG2HyMVYY7DkjOnReWkkiRJkwQTb9PE9pA4/vFiNe6NglZdHW0xNbIan3YHw4LQb9UqVZYDDp+aCFsVap8EmQsBHDIqJ4xtYXxKOS3uTBwq436baNRSfJldqOdtlOd+RzK9M20s+1fRhqywrwRSycoLVjnf5SXD4qeofMIKFKx8ohHaPeo3Rkp0FEd/BCEfPWJwYh2R1BYtCTjt7YeMzfAQPKWLCydtLzbO+wj3MK3tDvtw+1HkwHSSbsTvw6bhMJvy7zs0vaRi9A4jPF8uHU7Nt28zlaiFdeBF85U0TYRas3wAo8KXElo295lWNb84dJ9XUmWh3E5eElF7ErpAQ2/mzM4A8Ae3ae8E16W5kQl6O3UFB9QQ1VM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b98d3de9-5c6b-47d6-f24f-08dc4ebca344
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 00:18:48.1590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0PvOH0jAx0RW9T4EJ4xcNaxzrULvFqxApEQeF5OJx/RhMeaD2eYRSpc2KCKYWYDau8xVSsXjuE/lS1F05XA2NQcqHOOwHn21rl7cVJ0Y3bU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4186
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-27_19,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 mlxscore=0 mlxlogscore=959 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403270169
X-Proofpoint-ORIG-GUID: wSkrg2P3vIHtiKHSLRV0RsXZrUbiX0zh
X-Proofpoint-GUID: wSkrg2P3vIHtiKHSLRV0RsXZrUbiX0zh


Stephen,

> Caused by commit
>
>   b4d3ddd2df75 ("scsi: libsas: Define NCQ Priority sysfs attributes for SATA devices")
>
> I have used the scsi-mkp tree from next-20240326 for today.

Should now be addressed by commit 0ff10cb7f818 ("scsi: libsas: Fix
declaration of ncq priority attributes").

-- 
Martin K. Petersen	Oracle Linux Engineering

