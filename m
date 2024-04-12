Return-Path: <linux-kernel+bounces-142487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 513728A2C37
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CF47283CAD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850B453E0D;
	Fri, 12 Apr 2024 10:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OkiZ8Hr2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aY2WIDwP"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C08537E6;
	Fri, 12 Apr 2024 10:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712917349; cv=fail; b=S59KaYE70giQSKE9ejmB5ebFXFishH9ylHn99H4+EvCxgbR+CszB7bwRbXvGp/oi+FWxFn15Z05Ln9v79jWESvPsZHcF2dvFcj7Gh2hRyhOH/ImDfk54y055Dvp5W32Ow2FvX1+8wBTJBPGv3wj/hTShEZS5w33FeMWKKRF0I0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712917349; c=relaxed/simple;
	bh=lV+D1Q4v1lyOQokeJce2UCJv93jd+Sbohcxbu2FRcPE=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=qbAmp1Tw5c7leiSyMyfF+z/zosqX+vYtYzKRyzyKhbfsrYvwEp3Kk9KPbC8iatlNBndq7Ku831JEC1/c2EXlM4wY/Ey9AcBfr7gbx3ISgqNtkdBE/Z2akDQ07XVlr9inrurcz1B1QU7uERzIzjotVOZ3oYpP3QxrdvM/WVcO6Fo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OkiZ8Hr2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aY2WIDwP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43C94Sl0026644;
	Fri, 12 Apr 2024 10:22:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : in-reply-to : message-id : references : date : content-type :
 mime-version; s=corp-2023-11-20;
 bh=GKI7MzWiTIc1HNm3WiBTsEdGXPwjUh3jfLx41dkh0eU=;
 b=OkiZ8Hr2Msf+PoWlzACxLTMRyrQsi/iPaTtdbQheeLxXEhXHUC6JozzYpxgE0xO4wUc8
 WLyw2aQmuvQoB9dGYt01Z7AhxbqqnZoXQwpKiqOhhSONO2jaZJ/o1BlDk9GHaLuJlYk0
 NrZbBVfmFqKdB7exHtGlF3Ri5tUL68XaguWGGfGnJ7IdVO8bi9jal6EPKQl++EMGjrBf
 Lw9K6sYw/kk+zoCZBKV2V8zFhTFlUpyajVkfvVYL+5R0Pod2NGig6+ifHyzCCdJJpSo7
 oIidBTOXyYLVV+MJltdPJw3L4Vq+BPkEZybhqRddWN7fHgxkz+9wJJWV+7VQKiiWo28/ 8A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xaxedunf2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2024 10:22:18 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43C9JUgm040131;
	Fri, 12 Apr 2024 10:22:17 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xavuh3400-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2024 10:22:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HgP75E9pHVIz5YLgUNuP54liRpaaXGPA0NnEmELxNOgBhjLKQX2CPxLdCSmMjnuiacADgQqMqdRdE75OJlOO+wyEBXbW8NYDSIW4+MtGQQefhxiUZj820vqY8+BV+OJaSLHn1GSsmzTaWYm5GKILJAq09ozWwHWx3/8bugeQV+msiJY5KPUjT+wAg1QontJBQazjsd2nhuQhXzIn29oajgaR3m/XU457ql7qr82o0FLvm46ABS8JoAIaHc3VNp2IamVHygxbqyvtPjmWOZrtRhvENUF1T8UI+ilHTLn3GXpigQxRcxEM7/r9BwplK1J62BBoExJnTgIRjoRiM3SjnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GKI7MzWiTIc1HNm3WiBTsEdGXPwjUh3jfLx41dkh0eU=;
 b=UxPC3RyUjQW0Vb/AcFn1BR4B/Slx3wXvSew1zzQlm8BiGqNUYtIoOdW4PL6A6DQe5pCIfe5d0p1L08R5QrsdppaJeOoOnrzJP30NgHhUoZQf72mFed+rarwRSG53NVDF/BNKSR3qZLWQZnXz376NJlTUWwz1N0VCfvBOY5XSv+xt3BEkSAPfTQ8JJQ/3p9E3/DDGMPxTa/iTXou7g/QZ0w77jZVYtCR4IVwM2iN5PMMFpt+GhU06jTUlw7wzfstotfoO4FzP56f4kgHL2b+1IZVYwxF9JxgvAjgCHVFFSKGYoKZeUZB/dTcAUs0JJpSuNxzQ1zEOSV33riuiYv/hhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKI7MzWiTIc1HNm3WiBTsEdGXPwjUh3jfLx41dkh0eU=;
 b=aY2WIDwPQOATh92WKDZ+j//oF4KKHZENHvgUgqpBTqvm6LmrFo487q6qeACYe+dEeJr96qiDq7OEm19jJsTzOcleimKIWWlL0FFRIUCGtKSQOUufpYlTwV5QReLGFvAxcmBJrNIP9Wd8slXgDxF/j/DFzkHkEl+BET1HbhDbAL8=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SA1PR10MB6663.namprd10.prod.outlook.com (2603:10b6:806:2ba::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 10:22:15 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7856:8db7:c1f6:fc59]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7856:8db7:c1f6:fc59%4]) with mapi id 15.20.7409.042; Fri, 12 Apr 2024
 10:22:15 +0000
To: Christoph Hellwig <hch@lst.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        "Martin K. Petersen"
 <martin.petersen@oracle.com>,
        Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the scsi-mkp tree
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20240412060911.GA32268@lst.de> (Christoph Hellwig's message of
	"Fri, 12 Apr 2024 08:09:11 +0200")
Organization: Oracle Corporation
Message-ID: <yq1zftyj33f.fsf@ca-mkp.ca.oracle.com>
References: <20240412154607.1b5096b3@canb.auug.org.au>
	<20240412060911.GA32268@lst.de>
Date: Fri, 12 Apr 2024 06:22:11 -0400
Content-Type: text/plain
X-ClientProxiedBy: LO6P265CA0014.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::12) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SA1PR10MB6663:EE_
X-MS-Office365-Filtering-Correlation-Id: 66201426-7df8-4e04-97f7-08dc5ada6c9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	k0qDWppnXLzg5M5eJZk4ENH997rqVkgEQfvG5ixu7m0fFDr3Wj37O4/KiUPpkBY9q+syCEbP8zMx5BPmRZPU380gDVgurbxLw9KJijIS+1xRo+COvb0R2XCrWeMRgGUi1q42Nt3gTQAUfSubWJAmX5tNt/GsMaE29FVi99iKSW84bgk4G8Wm/jBc/wgvYjOifMdEeeuzQxVmLDgkUQcgIbFK246LECcjO+jiF+wU9JWRLz5p0OMAev86O2JwAVqM7P8bJkT8Y/YkWqk3WDJh0ZT4r58LFdiWrdiQJc8Oalt95SWAGW+uCdNCuUB93dpw2N6c3ctkZ6pnZ/ieh27Xf2uqnWSwjKW4ch0h23VDjWiYOhqoviiVLsPM26WOGvYFVJxttzR8NNtlDOYqODoEcAR0jgwRaTrDWecAwleUoQbcc7qLvWHNvZ6K45DEB8i7Sx3Vg0FDhGmiaKf/LuHFU22lkVMY3gpXFJqMlRL+sWSMc3jfFASI9hGE9FXzagZBVzBTchxcf86eSmitc2gOsHVRT/ZasA9Fz2wi1fCJbr911xIurJ/MnV9dwqI36x9g3l5rkqBE994OagZRmdJiNO5N4aZ+HQqU7gTaI3WpTOTPT9hMTZrSWTcBQ/iP24pnQK4OqoP1Xi13YF5ywdiE+DtlNiCAhoFQfOkL1XMnO3I=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Bt3rAVT6VPAmwaCMkVRaG7lbto0Uj9rZQ4qGe+44ff3YejdeVXjT0Ns2KGzj?=
 =?us-ascii?Q?8xrkHtpVASzwwamm2HEwtHu9dcSsSDArnfQfH29DAdmiNi9/bxP+hAwRtMwM?=
 =?us-ascii?Q?1fGokOlRvZuc020SMDkRPn+1gNv99TNhUSNMSfNMfjvulfgPOikAnRlPEXPc?=
 =?us-ascii?Q?S+hRd9uRZ9p73KtUFOXKOZ0xOKPgHVU2rEmAnEwJ9XbzZ+r7y0NhuvKIWxoP?=
 =?us-ascii?Q?ekW2J/wS+SIYIKkspT1FDuj+Cj9DWfZlvILtioOzJXPaZ0sReumKfj3e9cXe?=
 =?us-ascii?Q?jd8VjLw3nZqZm/v1v/t1aMd8ZJ7MRgCZydMLCER4z0Or6WS43WNQvBzAObRH?=
 =?us-ascii?Q?tITH86p1Di5eTZNzugWja6NbOZJZF9m5x3f8LiNdf7yB1ujDBZXj7exan0oZ?=
 =?us-ascii?Q?v3I+AibSG83IHmE6wqjFmGjIT933pf5EScEXVzOTXGoFaUhci4DfaWScC0k9?=
 =?us-ascii?Q?rR5HJ9t4TTdpv+WMUXiPXptLevrElauNeHOTARz8qtGzCthccBaJFRq5xZsk?=
 =?us-ascii?Q?Yat3SXyMvbXdFM2kfRM3GVcnig4O5PP/XR0bc0YC5eoXcz9ZX0hDtEfPK06l?=
 =?us-ascii?Q?8t/gjyHmjkuIpAqTsKppfVk6T345BmAWGtjwb3Kuvg9laD1WLCEJkMmcRnrd?=
 =?us-ascii?Q?uCOav3wVSqysaLWvhTGkj7pAVP0a1LmQHMpgKvk/EhspAPHc9frk4xmVawnE?=
 =?us-ascii?Q?w960yxfkBPNyOK1iunCuEuwTx6VXKp4CbxKu0/hSFpj/fOrPtQ3IFTK8s72F?=
 =?us-ascii?Q?3yP8Ml40LDlnk6OJRCk3aKLWb5IXugngpEknBnPcczsiIHKdaWD1uck79qln?=
 =?us-ascii?Q?7hDXhTUNSlST/ReJBrsXZmNWyt5gdkMdd9hjZWj0B3AiPo+M/NiyQu6IFDQm?=
 =?us-ascii?Q?ydSQ2F8uKsucp/ZsZjQt0AccRHcTaoG+wzzALe96l6X6eXOsDVD6+fuYqYs5?=
 =?us-ascii?Q?9avKrabhNC5D/DrVbPsm444yr4VEQUnVEP7x3hGd4VYBVV2MU94mKmYsHNJo?=
 =?us-ascii?Q?QjNzLULwUnLYEE01nNKTrPo/7hvUv3ozIi6Yk3BJbLZWXGdihIOCixHpcL9U?=
 =?us-ascii?Q?r8dAcrnv4N7LNzFuR+jhHTvhyA2ndw7zU9YBnvohIhQ6KGEl4LsSQ7IapaMM?=
 =?us-ascii?Q?FGZ2sjmxwJAk7fwYuCOisem+bE4MdlF06PysNHeSAGT8zj4FJFbGhpLqz5LF?=
 =?us-ascii?Q?MdupSc7II/hJmcUeO6aPpkX7ZYzWaDIaJuNVVy5kL2bhcbk2ceqWectrJijd?=
 =?us-ascii?Q?7vhMPhVmb4g1S6iT56vy6oCN9QCgUjGEy+pDWeNr9WrSFHrcMn2kh006feld?=
 =?us-ascii?Q?yO+wF/pbjWNHvwAAQqfPR4bIjQpUBjsjbyeR/eDXKbbm5JfdhJvj2nnb5tlt?=
 =?us-ascii?Q?uKwwn0CWKauKls8OEx7Ahe/csaEZByx1FK7atALl323VcaXaIUDZk1A7kajU?=
 =?us-ascii?Q?D8RYuCvoLjDj9qtWoVSE+a9frNp7//94KJTweP5antUXmQbCw7avyJmqVpxw?=
 =?us-ascii?Q?lZVt6i2umZW8INGuDWToMDMM5yf4fFTNuGPCcKKVFY7myr+E/liQao0/ug7S?=
 =?us-ascii?Q?4sR+xzDTfeBmjWazrtTB+tL0AMtxbLR3Z/1MoxG1ZOuVvB2LC2kx1inwJdtM?=
 =?us-ascii?Q?cg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	gUY1dwyeMtm9+9JGZmD3QeHPlXfIk1JLg8qOcReNFBJBEQdOTMlE3nL5HnIqTHfDUAk/2u4qup2VnLToGy1sP9cnSqLDrWYFsQbjKzzzGwegfcirJGAboyDtxO4e+OyEJcHczRg2hERG/9LmuXXXdA1/PBhU5gOCUrgPdGS8uT7D+50t1ewyVdA6S1bJj1VdtUOMYP0r0oK7HazB1iWtn2LliJelnXtXRL+WCx48V9PSjzuc2fcWdfj6iriwh7/rR++uipQJ4+1VycHWy0p9zNeHZooRlUxhNbbUxPfEXqpXkXo0FPKnoy/BSDNBuvECU8HLnjK+ct6/5Mozs+kHOAp1fSlJE4zi8eojvE+6Ph2gFq1/LdjQOehbej9FmbmpIQm2trvizG3QrnlJXNGtw+Cbz7dLa6QnB00BKtPj6QFfNyF41Jur8tbgSHq/gWzzyW7CR5GwgEnrvCTyAaWXlkkI1VM5v2UTAWZmK8LfqN3znUtT1U6khwQQrN4SKs66kgsbOqa9g6lO+544VC3orZYRh99XoXMEt8eTXummCtM1bhn3Xta78HU3/IFFqnmJtjk74e9MYXQnJ/ww+lGoZIbnwSBka9e9x9z/IRNcCrM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66201426-7df8-4e04-97f7-08dc5ada6c9c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 10:22:15.3236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AR8sng7H3j5E849kxoTyC8M+ksT3pXxgaR/VY2nNQDPS4vMjMRb1gUE/EKnbQ1NiT25uIq/QfBp8QuZ8AGng+h3koUouEQUeusirQaD3WFc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6663
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_06,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404120074
X-Proofpoint-GUID: nndZ7EnzVjG58QZOd1neWmNm6NKX7K3E
X-Proofpoint-ORIG-GUID: nndZ7EnzVjG58QZOd1neWmNm6NKX7K3E


Christoph,

> looks like the scsi tree failed to pick up:
>
> uas: switch to using ->device_configure to configure queue limits
>
> somehow, which was the commit just before the one removing
> blk_queue_max_hw_sectors in the series.

The v3.1 patch confused both b4 and patchwork. I'll get it fixed up.

-- 
Martin K. Petersen	Oracle Linux Engineering

