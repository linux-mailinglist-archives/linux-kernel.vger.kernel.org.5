Return-Path: <linux-kernel+bounces-111654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A186886F1A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94048B20BCB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D17A4AED9;
	Fri, 22 Mar 2024 14:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CLZ5Sshn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PqtE6Ije"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E49481D1
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 14:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711119240; cv=fail; b=C5Pd4tRJkqrajCufiAoPMETfSU/z0TmluOHGLkEg8x53wJGpo7XOwuPK9BOeuJ2euPsYmEumVOa7413J65MEGVTmv4xzd4FikmWfzlwX/TrvLiTbIWsJl/XoOR7Hnyye1S1XxW5i4cXlRfhDg2puhWrYAl34cfZlNeT4Lkw76Xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711119240; c=relaxed/simple;
	bh=OWOLxcEHByr8hERbcNz6RoChcCkhjBBSWxVNbQfitlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uKsUDQ/oYvGTfWjEr7OoRt+Ckj3natM1hHEg2A+6sbvolIsXCcRWKLYfhZRhRFqBXqsCeMl8LO+VkEyeEkkxcygXIxCo8hLDWwqIhLgskI/TKzezmB5YUgiwAP4/Ihq5GkZde8Q7JXD8xEBhVaj2hCfIHGJEC0L5BixBdOZTzZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CLZ5Sshn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PqtE6Ije; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42MDJxlR005455;
	Fri, 22 Mar 2024 14:53:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=8VTsA5S5R4YmrPPGZmUFJ2Ui0d1cOKAfu3VD16h1BUE=;
 b=CLZ5Sshn3MPMMMiGUL2ijiI5J0NN+e5BhmKB+8glbrziWKvUvoX2ty+U7rk3KOp3jgtO
 uJyzvQVvJXdAANVrPirP6c4Nu7N1S6+WuqnlNKhrGekS69mtj3mAiCf3GWQakJgPDpGF
 ZNBCEtTW//e1wUBi3+PnivQD/RdSPTG+0Cq1mHWydbCxsGIzAhQolDcjskbXc4BZwA3I
 9RJ89jJ7n4Vy1S/dexTPZHqEL3z0rZo44CQlSAG+I8+6pG5MzQLDeKj9D7+Q84KAPjbh
 veSOTE9HzQUH9fV9v1sRRpUE15A0DRhzjCbT3xr/5KnD0qjJGWJh4h3LlHryr8JM/E1f Xg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x0wvqs8ru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Mar 2024 14:53:39 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42MDcWTe011043;
	Fri, 22 Mar 2024 14:53:38 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x0wvfbrsn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Mar 2024 14:53:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LtrNQ3bo7xBWm0qQZ86UiSUdkmMsmxJCoULclls4vYt+yUnnGkTHSB6/ZnOGweBjBPzubpqu1ojAiZBncWBtXkKQv3/wtOHThne15RjcT8akiFSCNkrBEnY/p4ewJMPq+BKSEf2p1CNxDK61WX6UUlHikW+YXoi4+dGYMJ/0Hc7/67EyvHxJUhg0B1rkJ5HtuOu1RgZm2XyEpj/DYld+KgeUVYC9yH+sGSUOfB9V7wnuaYqb+JX33EhUOXM9UbVRrWJGrWKHAfMr/31UTTz3o/QSt0MTYN0q9huyfFlfhogyoNw0qTc5ndHgF4irMG8CwuL+WDmAzHf2rUKvX0qU6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8VTsA5S5R4YmrPPGZmUFJ2Ui0d1cOKAfu3VD16h1BUE=;
 b=COfIE9m07v5Z8C+fVH4Vrcucn4E3oc3GcifOSzGbuuWSkYCib68DlOQ9s60DnOOpCrEl/3g2aB5pKLC66qi/YuU4NO0ZE0fuNXpg/HXVOOq2sKa1sSrKQhYMxssBKSYBBhFuE//+jJLjyVLcKtu79ND8t4YBGML5aIzga0gyd9tfJlJfPkp1whozxaTuT6X1aSuCC1lPII/fI6F4/4nGRK9qKIuCe739UJ+AYH7lVxd1XaW+mw8899rlrUlVlSjyNdLt6nLLQpGyBOwzURPK9cNr4wLOqsk8QdR/c+sFlstLOBEAplEE6bjcqkS3pxrxKU+k4d97PwFOKeO12F1M7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8VTsA5S5R4YmrPPGZmUFJ2Ui0d1cOKAfu3VD16h1BUE=;
 b=PqtE6Ijew8IrLOPtIOQkcW8ELRJysKBL/oce2BjGxhtHC2HvZmh60Ik20sSLf0S61wfs0mpTSpNap8YeNxgTAIzjUrMfsPXqLNvq5wC7FxT9Uc3nhmuFPvxSvvIa1xsY5k10E4HUrO315XZ555ZO0vBkdm/pKIQVN/6E9dP3AKU=
Received: from CH2PR10MB4309.namprd10.prod.outlook.com (2603:10b6:610:ae::12)
 by IA1PR10MB6856.namprd10.prod.outlook.com (2603:10b6:208:423::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 14:53:35 +0000
Received: from CH2PR10MB4309.namprd10.prod.outlook.com
 ([fe80::8fb1:eca1:f8bf:3a8e]) by CH2PR10MB4309.namprd10.prod.outlook.com
 ([fe80::8fb1:eca1:f8bf:3a8e%6]) with mapi id 15.20.7409.023; Fri, 22 Mar 2024
 14:53:35 +0000
Date: Fri, 22 Mar 2024 09:53:30 -0500
From: Aron Silverton <aron.silverton@oracle.com>
To: David Ahern <dsahern@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
        Leonid Bloch <lbloch@nvidia.com>, Itay Avraham <itayavr@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
        linux-kernel@vger.kernel.org,
        Andy Gospodarek <andrew.gospodarek@broadcom.com>
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Message-ID: <6lakj6lxlxhdgrewodvj3xh6sxn3d36t5dab6najzyti2navx3@wrge7cyfk6nq>
References: <20240207072435.14182-1-saeed@kernel.org>
 <Zcx53N8lQjkpEu94@infradead.org>
 <ZczntnbWpxUFLxjp@C02YVCJELVCG.dhcp.broadcom.net>
 <20240214175735.GG1088888@nvidia.com>
 <20240304160237.GA2909161@nvidia.com>
 <9cc7127f-8674-43bc-b4d7-b1c4c2d96fed@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cc7127f-8674-43bc-b4d7-b1c4c2d96fed@kernel.org>
X-ClientProxiedBy: PH8PR07CA0005.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::29) To CH2PR10MB4309.namprd10.prod.outlook.com
 (2603:10b6:610:ae::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4309:EE_|IA1PR10MB6856:EE_
X-MS-Office365-Filtering-Correlation-Id: ec111d6b-eb13-485f-4d96-08dc4a7fd95d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	1nPUFXlG1ARgKI7uTQJua/PcrndjMWbuxJk+dQTldjDwjpH+HkV97VUose6+rCc7kDSNs43RKawbcp+EgA4WvSrJqpiYx6MxyMpTAgf3vw3VgRwanCh3Fyot82u4X3y0TAhwuc8jwqC4JsWFGLOGSG4YMe2mLaj6hikKMwPjvdLzBD+9S25Ei+TWZHPCpaCUDjY+jwwI/hSJrx9iuFkCMBsbKQ15WBHnu7y0Azw0AYu4tjYwotyY8i0xCjnaNIMBcM44E1MVtyg+k5oc2900iTqxLeITxELhM3A5ngzOupapuxahF7uOIbzYFC9zX4eKyh1e5iyE9bjVEdl4cw8Tyrav7DTEiIov5H6ftj4Q3HCssKifWvGdR3s1zLKXvvKCZTjbdbyeSVSJ88FNy+d6tPLBfqL/XqjcLueWxAwZvw3xe6tyF0jKXO4hGswuHegqWcO/AWZZKB5N3sMkcs053DrfdB3ucqHURX3USqP8nL/KeA7Tl2BuuqCYZPhB/PfQu7pPWxzvoeOUL4dWt2gJ6oxF6lVeNm+k4uvnZfguknffqw6+dnNT7NmphZBEb5SAWd6mPH/WjEnNTw8vMO45qoLgwAMVJjmYAPHq8P4e+E+IT/59gPRMUaFX/Hv/x9ElnMwe8qA0yAzkL7uUbZsBk/USLSrI2sJrFdCGInU38tQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4309.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?97ALkckbUk5enmQwliz9ectr3bruUgghpwV+TcejXax78tg+23pnYKiFZLMl?=
 =?us-ascii?Q?qb9nKl+NFlZnfXpJKAiV6n8QjfwgZmOo7002KS3vS8qvvppv5RlDzTZ2aFTi?=
 =?us-ascii?Q?kh4hTDYG7bzXf3KyldwtXaZMvo7uhC5Lt424RpRe40wueb+7+V9nlEDVfsfc?=
 =?us-ascii?Q?Nu4sogQ/zBqxCtpCOC7g7HaD9l9xQbbJc/YNK+6Ay5+KGjgVUd7EQIWbAOpF?=
 =?us-ascii?Q?GQc79lsme5HbNaEcHph1PhNp3Ip4x6YavJX/yG0nkPkedVyJQHKSgxb1C+Q6?=
 =?us-ascii?Q?HvtcJKlzSUC6yhZcj9qyC7zAbsKu7iM4gXN1mT4eIcVupkC19JJRxxz0V990?=
 =?us-ascii?Q?L/MkuzunWNTTjhjhu25c+3tlaiRFD43eyInN3Yr1C99QJ3rBjDN4vRwcWbKM?=
 =?us-ascii?Q?ADWXu1qxKKrA8aaksWm2GHRiuw0dJUubsXqdWInDrw4ktmCmy77o2sIMNDb7?=
 =?us-ascii?Q?Hb7e/VfF0n+KL43/WloZTLYmW1RyKH75nlR7QVmX+uWapss907x6rTzBzzqS?=
 =?us-ascii?Q?6Xd2FdKdl3ilnIVDHBuhfQDzdd2GeEmJf1DGvvDfX4rDzlN737p0NGjPD38L?=
 =?us-ascii?Q?lfwVcvDhtUU5bevtg5QWkHnusW+8vQMSCgMe3VrJpJXVeRf7S5Pzm+8l/znc?=
 =?us-ascii?Q?5K3smG+WMPLSD01epRGnSCcoIthzP8ITBDgJUvMqd6akMdMp3KfUfGWX6Mz5?=
 =?us-ascii?Q?1/uDAGaC5WkCJW4pp1hNBe33SiAWjwyGJjeyUyp6BEUjoZumWHuxlGKyV6wX?=
 =?us-ascii?Q?Zsw4ePh8XNWVquQPH5NBuAmfDx2XoU/OgCjegtT/cpsFE1n4owR/641xVumE?=
 =?us-ascii?Q?FTPZoVHg9OyGMTsmEcDzoA6RnBbwPWr7F9ZVe/lNfR3qv41BrLZ66ZuBQH64?=
 =?us-ascii?Q?uzO4uWK3ZyexOUPu+rUCYdAYrAdlV6A80uWwhk2EgcVrQ1s5n+fDqx+om+by?=
 =?us-ascii?Q?3w8Mjh1z0sg3qCs6FVf5CaL48X38KRwWYj4PSiOjs2f+A52KDblMtZ97K7QS?=
 =?us-ascii?Q?hzi+S6PFCXjiW8/t07KDugoXfOurfTBaNtpT+in0oIQVAiONF6wASU5TKmSx?=
 =?us-ascii?Q?DlXrDtukax4ckeT76xhOk+t/BRuT54HjiOUhSSHAUCOsSSTJFVS4jFu/3la0?=
 =?us-ascii?Q?8uj0vL1g5kQs6at79Ksn+3LHwU+0KUv6Rv7c34SXYtDpFkjjTKEdg6RkAKGe?=
 =?us-ascii?Q?p9BtbrFUGOmKSof/QRQRLv8Q6uF6qisE2OwVEQKef5TLYydm6Wch43mKiSIY?=
 =?us-ascii?Q?fgDfZQPlnRRKC9bncwamyUJYhaBZejiEZIAk8kp6x9v7hmzLtOc/bheWAlfL?=
 =?us-ascii?Q?fF01uY14AsCx1VSwNryc8AUkR00RsK01FOME57HLViHprVvNqg0PPkMo2DcJ?=
 =?us-ascii?Q?D77HMIfxF7M71LZh44A/2L0V/3s4epZ1JWe72Rmw0DnFFIRYjDRGRTZ0aRQF?=
 =?us-ascii?Q?Un03EumwyPL8WNAs0Vy24IHnESNDeIj266z40g4I+NKOMb+9Ek8A5KwiUgyK?=
 =?us-ascii?Q?2Nt/tdhFNfLccUQpW0JbU1Rv7OLmraGyadLyygH+UdnT0YJ4JN+S/mGXgIYh?=
 =?us-ascii?Q?4JQ47VM+5wn/OJuf6SMAIju3KYD922u6r7zfQa7XAN2r68+aVGpPhUMgucKU?=
 =?us-ascii?Q?Ew=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	sEUYz/1BppjpjBgQqNlR0PwHk0NjAt59wS45DRfgr4ALSgNBm5cZXYRj03F1NQ41P497XxI+ZGvj+Os/VR+djzXu2DSW7q9e5bJE4qc9/7tg5hIDMItMfjgKSx01biVeic+q2AI+k1BzCQ3sgXnehDgVpymKH2Xocxxws1Ys6/3wZNT2Kl7Kqa3Fn2nS4fGyEHg8DtlQAC0KGORoY/qImpJXm56GGc4pDVZv4Wq//VRo+Us7y/d2bVyDoae7u9bI6l8M4jJwkiQ/F6/OoMc2ELJwViAkKfDFQjjEsBL6rkJOLqv8CV7/SHprvZ1MeFS7dABlRFi2eHuapF28sctUmC6291XmIeW56W/K000dcy03GRhV/Erb1hFqtslrHyAp+9ckJuQpdKlhJ4+BEbJhh9sgDiAioXgBXednwpTSDouZQmWHlQmft8kYf8Xx7BKIw7EwgGz06QUTmfX+qTqMPCjFJE+UlYr1fbI71/d1rhUsRYLL8nEPG5NDqUYoupY1fZwvvbv11hcUHl6Ev9SAX40BVtNInoeGLBnu0/+TltgQcL4d4lRhKC/p7G+mQgovgtZDApaHNiP0kPa27KqXNszBSr1lXMEck2ziAo6w1/8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec111d6b-eb13-485f-4d96-08dc4a7fd95d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4309.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 14:53:35.0723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PYOAevzLukKnBr1j2mM/xfktrLkWczKMF2feMgrDH7RMYKbAyzWJzueGClh2T0xmf3YYYQ4805TIw+LmuzH16QZ/Q7IZOeFxhTRa4MTq/KY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6856
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-22_08,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403220106
X-Proofpoint-ORIG-GUID: CNRmEETifKlSvyyeeQrte7PlmZ48pe8O
X-Proofpoint-GUID: CNRmEETifKlSvyyeeQrte7PlmZ48pe8O

On Thu, Mar 21, 2024 at 09:23:28PM -0600, David Ahern wrote:
> On 3/4/24 9:02 AM, Jason Gunthorpe wrote:
> > On Wed, Feb 14, 2024 at 01:57:35PM -0400, Jason Gunthorpe wrote:
> > 
> >> I also like this, I don't want the outcome of this discussion to be
> >> that only mlx5ctl gets merged. I want all the HW that has this problem
> >> to have support in the mainline kernel.
> > 
> > To this end here is my proposal to move forward with a new
> > mini-subsystem to provide rules for this common approach. Get the
> > existing tools out of hacky unstructured direct hardware access via
> > /sys/XX and into a formalized lockdown compatible system. I've talked
> > to enough people now to think we have a critical mass.
> > 
> 
> It has been almost 3 weeks and no response (to this and other proposals
> in this thread). I have been around Linux long enough to know that
> silence is not acceptance.
> 
> To me, this seems like a sane start for a new subsystem addressing
> challenges with complex, modern devices. To that end:
> 
> Acked-by: David Ahern <dsahern@kernel.org>

+1. We look forward to helping with the development and testing
in any way that we can.

Jason, thank you for creating this proposal and apologies for not
responding on-list sooner.

Aron

