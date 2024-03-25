Return-Path: <linux-kernel+bounces-117988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0809088B20C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFB402E525A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F425C8FC;
	Mon, 25 Mar 2024 20:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bt/l/wwZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wgdFmVof"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875FF2C87C;
	Mon, 25 Mar 2024 20:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711399990; cv=fail; b=Z8vw9NP5MPxA7lMu1kYq0WlvE0TAO28B9e6r/W0E+zhw6eoeH7z8HxytCzNpvZ7j9N+HkE/rXihaMu9B6JKrc4pqOrfh+IWNMdDzenoX4IdD24/UecDqIwwdR4SAqqjOw12XzeMoGCkmdvaZpiZNcsp/WOHI87visAPEv+Owjpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711399990; c=relaxed/simple;
	bh=YYXzAtmvkqQi5oMqOdvqtRYw7XnjEumYdPtV0hGS5nU=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=NebGJVwLhqIg4UdcodmO5WlfvJ4azCO7RSGgVFKe+Z+lgEMJfEoQt6o+cHex7n03v7CYTe+gA4YBAWKVxQBb7u5Lp/0Lxl+aMsUfc2Mwu2bCW1UGfK2HZa7DQJQJMU/ZOwkRp3nhH91pwwQCEc04UYhEWyfNkB5+sC/whNfMpk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bt/l/wwZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wgdFmVof; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42PKYZIU028456;
	Mon, 25 Mar 2024 20:53:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : in-reply-to : message-id : references : date : content-type :
 mime-version; s=corp-2023-11-20;
 bh=5iKSne9Ke+rd4u74MmTefNMYRoWlieCpnwo4FpwZV/4=;
 b=bt/l/wwZat5Hrk0xFmGufZ7GRGkMOgMgnn+dZsvhZbcNPHoTRoGpDvJWA+BzhJVWU3La
 xmpIPUf6vxyhn18uBdUalPwqby6rnfhtwLC2q8ptMDrBAFIN9q7pPrb6ErrjeaXXaOLK
 iPMf5XQ0PcUzn3OTqAet/boivZSKdN51G9LfBu8Pm9FxZmYQuhVFt39WAFkPgvI4gDSN
 fOuREGf65UlHvivBnI9yCfYDYQH5mSO/Jka4uYospbYh13jE5DKGSOcxDxGyEpgf8eAM
 g4VV7zhCHVyvZEJ5vdNZesO7CTo9u6fAN6/p+nGnDyODVKnIoMayQhCLdZbSnVVBtk/n eg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x28ct2xx8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Mar 2024 20:53:00 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42PJXU1f010607;
	Mon, 25 Mar 2024 20:52:59 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nh674n2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Mar 2024 20:52:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F0LGi09b515U11zVJm5L/kf76j6Ni+xc1gEOu9pRCNHmw5PEhxvqlzvEBQQKJFDmLaFQwOPNykIxapdY+2HDter4KoxstNeso5MyVaywktD+Bc2vScg7e9oVHaPDpSjpCJSpfNA1GpUAgCYUHXg+qt8gPtI8+UAhVmxU5qPvI5EXCNH8AcpytFLT+LCcGzBNCJyxyNPuE2jspCrZbB2M5/8BWgmCqQMZImGiOGX3aWSn/KRmXpQoSz9R0hnl6pdd0kDD8z8yUZAlPjNCFJnAN4B13A7aqnzAU/ZB7OS0pxlRkwAROEqXLAiq8zz956ndBTgypmd+QXrrpgKcOGqdwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5iKSne9Ke+rd4u74MmTefNMYRoWlieCpnwo4FpwZV/4=;
 b=H+xqItBwWj1RuMFiwUUcatW1uycHLhCw/3XHq4t64KBpLUUP14KrrI40Zbk3lpl44KzGbe/tSp0YjeUgGZPFH95LcBhcK7pDtRNqf3h+etZCRw734+iR9LVwEUC01lA+G+NXCbVexWzH6J5XNUG2hcREtHg/btk0IVkvhVL6ImHRzu14/0vKxfBPkFNJp7Vck0z2BWYtGR4NqRhAMiJJxBzHnJSj26kCrDTmgLYPqDdMcvHpXSKOab4UK04lkHnnCCh6U9kvWm9roZpqwPVg2nYuRzr1XDRnowp9eL4hFj6hShaArA+qOHOLOObxZtmhzZP69U2d9aXPzVInj5hIuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5iKSne9Ke+rd4u74MmTefNMYRoWlieCpnwo4FpwZV/4=;
 b=wgdFmVofozBVEpPBTkrP28kKNKe0A8R6cpNuAuckVQ2Taxp4QcIzKjCVINJkdQwkr8g552XUE10mQTCMqhx72y7hPzKj86wg61xoo3NmNIlPfkDjp+JpwT8itUXU4dNR2p4NDDiCVCy4biClAltl7MAa/cyb2nQXPFCvxgClavM=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BL3PR10MB6067.namprd10.prod.outlook.com (2603:10b6:208:3b6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 20:52:57 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7856:8db7:c1f6:fc59]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7856:8db7:c1f6:fc59%4]) with mapi id 15.20.7409.031; Mon, 25 Mar 2024
 20:52:56 +0000
To: Avri Altman <avri.altman@wdc.com>
Cc: "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen"
 <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>, Bean
 Huo <beanhuo@micron.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] Re-use device management code fragments
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20240309081104.5006-1-avri.altman@wdc.com> (Avri Altman's
	message of "Sat, 9 Mar 2024 10:10:58 +0200")
Organization: Oracle Corporation
Message-ID: <yq1r0fy9gpv.fsf@ca-mkp.ca.oracle.com>
References: <20240309081104.5006-1-avri.altman@wdc.com>
Date: Mon, 25 Mar 2024 16:52:54 -0400
Content-Type: text/plain
X-ClientProxiedBy: BL0PR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:208:91::22) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|BL3PR10MB6067:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	IdR3tGB9sBa6Vet2hYSpwu/Mvx5enocogZTbbnzgtOjtHoxAqyJHjFWfMopErACFWz512Y4Sy5259RsVPNyV4OdIYRBNlxlPaIdhZXyOBBQ51SKuO24+SN2LvCjfykeIwpksUdaF6u3FsBF+ux4GlGUe3U3dRD0e3/EBhFcu+K8hquWLlDdpFSQXmZU6zJ/zCmHtMGtY0FrDkEiRxwlGdRVH0Ya2R7xdezHtSWRFmi4VAVQKXz2LXiycewnkkH6sqQOGVWDN07B8RLajFsNj94xlAvzn5Vgvps1czW+8BmQtH2HcoUVtzNT5dPtvM5UmXJbmAKD9M9cnj9y6Li5vQ0d0imKt1j2MNREqu538QqI4ojd4F5s5GLFAI1ZdLSC6iwecLqvbNdLsjKp9H1WplHkePLj/XSNeDpRpuZ3cXbVDcxuCgwE6ECKI1xAGlqLaH1JylbIXqo1lAoxst+xPnVxlq+0+nskL5+EPhyKxi/pup7RQyQQx5+aN31OWT8UKgIAO51mT7rNeqpyyBIuqkbAeOdBhckX3B9uVq2GcZC2u7nxA7Dw1qEB8ADfWcx4oCYnVkGldPgy0c3MsJFi5Axv+vkUkDIZrZYbXTClD3sPnmb7BbQaU3KTzyKUtZerM6NViL6+8p/DQG+YM9qKoOfFsnCKX+RiV2WC45DCasyQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?JE4jC4TIIrowpfv6hBgsbuE5JEgZ/AB2U/oGldVxvVdXZqSLtW9jQfqT08JV?=
 =?us-ascii?Q?YXpTGBWUcrOjmG60z8G14lLe3ed1y2gzzvaU6nOjuKCwoWA8q69D+FxwMr7o?=
 =?us-ascii?Q?xaJ9U+Tv+B3lz0RgtENOVoi6AbxsvicT4SKBULqAqZitEgWxzQob/xfwXTPJ?=
 =?us-ascii?Q?qgRMOliRkqjLFgIFT9KKO68JwnNB22U8SuVelphzrtcdAJjG86Qtcu+PV79A?=
 =?us-ascii?Q?5297ALxLY3S+DEqeBBezPbP+rIu+HcnNFeEjqxAgb4KC9IrxBRg0Owha28r+?=
 =?us-ascii?Q?WBn9a2k5e+3HCpzPl3xUbxp2pDKvoUd8/xtQnMOtazl9qE0ooPm6ATAFETqZ?=
 =?us-ascii?Q?TPk1Q6SLQfWWUdsOG2xlL4t51SKuI9qhIBbbyPJQkf3EfE99hCKOvodxJzer?=
 =?us-ascii?Q?ltXxT6SpOe4SgEs4MneLUMgmlhiLSDuo9pY0Iw2FG8tBtjXcg61wUS/xKZC5?=
 =?us-ascii?Q?u/QiJAQMVwX7RTMvLQggr5oTZ0PGDFEH/UEzHPivBCKkbApuqKVLDJ5NoA1H?=
 =?us-ascii?Q?B/faDBNPaOC9piszInkJUfBR7L3Jlsp122dbf0lFyDfGYhMi5JatAitgDn+N?=
 =?us-ascii?Q?85pZpgBXfTnhTp/QfWPbYoISWIEk6Wbuk0XBxGx1TSnm6EXxBqZvUZe2S5ZT?=
 =?us-ascii?Q?xXXDWFCYbEaD11mse6s5AjZXLZy4M3XvqZVCDs7DU5mB0aPKyhZ6OQpD37Je?=
 =?us-ascii?Q?N4MWvCX5Y/bVkNAPVBRfh9lePQW0iBUr88OWQlym3yZkvqrYD0ddS2+IsBZB?=
 =?us-ascii?Q?pVHYyo88MTtZarnlPq87w5Kfj+RzSRoAt1fr9JEaAqodFrJWYNkHptE2Vlm1?=
 =?us-ascii?Q?anZe4CXuqi0SQMzoJ1tQ/NoAMWAaWpgOke7OTeCUL0LNzn70ghkiXPWEH0A9?=
 =?us-ascii?Q?xYc/LEqd2sd1M1d58GEtWYlKPWC3QVsbTOE5d9J2ZbAnZEbEvq4JX1Dz/510?=
 =?us-ascii?Q?DFZBn2sps8woAWwQOIl99mpFBy6Bj/XEPVnMoo2gZHTc+pKQtX80LemR27zK?=
 =?us-ascii?Q?xCZZtuTDJ0XBZqbe7FJ+GIAcJRGEfTQ6CSqi15XSEqzm61N7FWWA6jjx1LWH?=
 =?us-ascii?Q?/Pcvi/1pUQrloX9ruKVrAilm21UeqzUAibFbRuCw4AqdHFUdpyHt1IZFYSJm?=
 =?us-ascii?Q?3ASWGn/4qzwIcy8H7YGPLtX7dOA7MSkobW7EWl2DeB0oWidWjaQwzPdsieu6?=
 =?us-ascii?Q?Dhv4ZPT3C6AMMqKr4MNBoINBCUPWXUFe2Q9OzBPBqd6JYAcUhQGHTeSVLuXY?=
 =?us-ascii?Q?/kEtU9i4vg1ya5ki70P2gKHFwSsTrNaU3i5UpfR/M6ShjMQkZKL7uiyuD7uY?=
 =?us-ascii?Q?EMUtatiagvEeGkCnefIvQU4/YFzZhbbYWqRgqsYd5fOg2kQWu6bKXxlXv8bH?=
 =?us-ascii?Q?7EvHU4jUVUVmLBa52tlr2YPFlHEW2GwOXX87OVJ4zYCS4vVqRgLqSmjHqgPo?=
 =?us-ascii?Q?rzsBtfbrpYIF1PnlVDoChza/lzLbJIdbOilkHIFJ7fmp2mNcV7FkQbGWY/CV?=
 =?us-ascii?Q?tRDr1JcTKn+I5onePdKKc51gto4ldI6sG2XlzVLoot5FQ3MIEMfcDYJPiEs6?=
 =?us-ascii?Q?3HzxqItws1VkX4ffoX2eluuTJVWNljx3+4QMGvM8fVIOa6uiGqWjPBdyKvh8?=
 =?us-ascii?Q?og=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	j2iHTRTHFdKjue8o6/wUIlVaTE3yYAcpXsoJRHPBbYWW7Bsvjh9P5Drzmsl78hyYaPeDLEBUVDj7u1Vb1tQvak3L7Fu95baGQYpcL9lNDbLCWYI0KGDLhC8IPydPGaMKhoD0/FkOJCSFpj1I0pPsgext1wmjp1j9X5UNxZiaRnAHfazSvYtgNh1aKDpFt1c2VQjfo2QBSLGP184d/Tj9B7WHnH84/tLRXhb3Y/4qGsfPC/PV7MPjnZkjQjkgJKVNCEvWblur/SBVPosrxYFqUI9jW5llHnnBJGMQhnT3NdK+yi+mcVTqBbv2ik4pQdasvaGxloD0ifwFDJi8ScbSSgjsu9NynYJUcu/4mBQ0bnOUVtUtvsWIMXvQ2tHz7xt6bdreEBQvMSNbgX58ZegGXqkjbu/xvrfo7u1dKgOomNG70lktMxxZ1Atp2l8CKGdpgcu1pz9uGuIMZEdIbIFQPnfQ7P4Qq6r//Cx1sVBN54jvvbwEzNrRgNd/TB7q0JpSnX8MWoXVjHw7slVM9hkNOKsId3XYAaKZCcpmqCs/x2eZN+wC8gN8l0dcb0tdQ67YVlM2pU4oHfQFleFdKQyGI5WmnFBllA8pwUfs2I8L9A8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efd0aacd-414f-47e7-43c0-08dc4d0d8c64
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 20:52:56.6054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CHUJ6kEF36xEAB0oKwKsdlwcy1mIhdfQ7vuw7zMuAr3JR4VabREksBnYWc2i1H2Xe9IQq8ZuXlz+lU56pjFKs/mS+kz8Xh/xbTlo0CRrQo8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6067
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_19,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=996 phishscore=0
 bulkscore=0 spamscore=0 adultscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403250128
X-Proofpoint-GUID: h7XXSwoTFuB6ckdoWVdc7TBbER6D_0XW
X-Proofpoint-ORIG-GUID: h7XXSwoTFuB6ckdoWVdc7TBbER6D_0XW


Avri,

> Device management commands are constructed for query commands that are
> being issued by the driver, but also for raw device management
> commands originated by the bsg module, and recently, by the advanced
> rpmb handler. Thus, the same code fragments, e.g. locking, composing
> the command, composing the upiu etc., appear over and over. Remove
> those duplications. Theoretically, there should be no functional
> change.

Applied to 6.10/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

