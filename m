Return-Path: <linux-kernel+bounces-77674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 866B98608C2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 03:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA8201C210E5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 02:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26439BE5A;
	Fri, 23 Feb 2024 02:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AP0b/B6y";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fHYGt5lC"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CC98F47;
	Fri, 23 Feb 2024 02:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708654680; cv=fail; b=GPrT/7VC9hvIGSCDM6kzembK+WODJypg6XhN5k2vvsO3oRhAdTdevhrNel/0Rydk1Fl/gNlNL7uUo/LJyEicZHNsuKAafPwjenXqdKPeOvGmKLKKsQ+ZjAjZTs7srBEb9dPvPQVsYxB64w4fTPqgLgFQs1a/oknbCaYk/5NeuJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708654680; c=relaxed/simple;
	bh=NdoacOWOs4LvWn5WykeJWsXTb7frKyKREHiKczp3VEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K1YN9McGDVVdX4137U4/g5keFCdw7T2U+B5bQAUzcA14dCd+y3n80o0LH1scXUTz92/GsjuEIoDPVNA2WB6HWwA73eLYHVrNhQPb46mlwe9lyPEpDO8xOpoHNsHzYjfyLTqFRIsF1w4ufVJ4ZUAvjgwY4GoByLVFwO+cDCQrxsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AP0b/B6y; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fHYGt5lC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41MIQSch027794;
	Fri, 23 Feb 2024 02:17:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=Hh0Xh74qE8TjXCoMeEttjCC2nFaYTNyOG921Ub4m8Ss=;
 b=AP0b/B6ySIqYYjvNL2RBDiybhTXnqahNgTYlQiwgv3OFeSlssjHv9x+RPrYvYC4sYEJC
 pqfPPQI+ZimR6cRXX18elcmQdeEBrCze1RXVWTVurQHTVPo3mL+OptpfiXS4XBZ1iUV3
 4u5l0Aq7MgjrRuh+Ve9GUplaxpnwevaYliXLseUkLIHrXHDXfjbikRN23E2cRyRo4tfg
 cmXs1vTMqc1RjtbFDFw9iDuwGuvPcGvY0ugjIU3+cV0/KfKNFQXSBTnzOQA5iovQfgM3
 e9bWy1C4oEQj0X07TxMGvE5vHBzP8LYPIdzlDUU8oUuF1VTRWDK3Mlx1u5a+YSG/fSDC vw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wamdu66pq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 02:17:49 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41N26evW037693;
	Fri, 23 Feb 2024 02:17:48 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak8bggcg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 02:17:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ubd/WHIKIoNqRjUqxjlz7Eo/1FE/DE1sRBMjlMhBLYGYc9Vy4fzLTdCAFH3a/3Ma3cMd8d9QYDE6vFkE8GQb1xuTzhhD3D7WhdamJg0lRsecH6tn0eIKsVJiRIyeDEzq3tMQRHa8lagItw3uenGskCF4IBOnlWhDMGCbe2fb/LhzTf/ZJR9PgFMYXBYi8Jwvw0bqI9+y1DrP6vp4ps9irfxxunTv0Gw9j1I9p5sWrsxqzeb2lFP+Im2BzlklvdAGwRw6oZBnUmo341mIZM5xSDiELbnaQgnWS1e+uDbd3+JtFF3o6e84CwwAEOGfOxAcwiDxw22s837ppOdv3ocReA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hh0Xh74qE8TjXCoMeEttjCC2nFaYTNyOG921Ub4m8Ss=;
 b=a8m7LyyzjEgzpC1D1bNhecxiOeRMVlYl0fu4VUke5p32NR+v++fsgcodZqSOZWBPBqBK6DXxNZHnf979hS1LiCEQ9k5J+n/Sryr6zNt+Z1EOoTpKJMsZzJbqbWUm0c0eh3k4nBtP+FTKtDJslHw10hMZJKRfpoQsZLzZNkrL5CODJkArMYGbr4RYSDj9sL9JRHxKeEjmTf6OCox411eB28+k34KW72X6tfq0TFcO4ABKxztk2CiTelBuPda2ROtmRmm/fD2FRjXzTg58GgoKc4Btq7WGIdfIQkfm4YxSXyA0GyQUTK19w2/d+8PbQkRt8N69fF12zJTxD9stPZk+TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hh0Xh74qE8TjXCoMeEttjCC2nFaYTNyOG921Ub4m8Ss=;
 b=fHYGt5lCMT3g+vYBhXcLUyAIN/X0VYHX9AbMfLgNwaN8T/h6JHMsoTrAVR2LTjJeeVEtPFAdX97T9cT6nABywd42WnruBjq/3gGUmgiN9mEhAjplnvO8FPwtA/LbBzz5thCjZlndkEycCysqt38LYbw7RA70KUG+MN5/cIsCqjM=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CH0PR10MB5225.namprd10.prod.outlook.com (2603:10b6:610:c5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 02:17:47 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606%4]) with mapi id 15.20.7316.018; Fri, 23 Feb 2024
 02:17:46 +0000
Date: Thu, 22 Feb 2024 21:17:44 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm, mmap: fix vma_merge() case 7 with vma_ops->close
Message-ID: <20240223021744.pbb7vtpsksvvg7mt@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>, stable@vger.kernel.org
References: <20240222215930.14637-2-vbabka@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222215930.14637-2-vbabka@suse.cz>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4P288CA0073.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::10) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CH0PR10MB5225:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f4bf68c-416f-40c7-7a12-08dc3415a027
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	4WFBG0DKfvrwSjcDKpxmnqH7d75BtMWuuhHB9QWIAVgkg/pYL3HpIQgu7ofsobdIfg1XdSnKhegeThfYFAUU688Dm6CqO/ovMwHL7H07pMnRFUhK1+zRDGwNX0EXOE6Ka5sPQxcGLTDDVLrP3PobM0wKoruXkhBkylegMu9P1FTRlWJn+9m1zow7Z4SfG763QKAKwuaZljp5feI1w6p3hYIKYu6ofQuYtLYX/RLw6gnL1Kmj7rk+nNM9aYT4GlpCbtrrWmEgizLB+qk6pDVQXiT8tEwlbYvn7DpmSuSXT42IZcznXZrmZd1G5Ndv5e+U3+OrmG5b0nV/0XFz7B2wKEr6SfPnbV+ew/djJKVZ2Qm/2KyXBroTl5Si4RXh33lve4DIjL93tXca2wdnvvW0AvtesV8z9jeiOrA2PafGtkTImm4C563Qth2mxaHNoEiqumDSgAB3x18FxcXWHL97IxYuIcUJ1E55zoqAzsZjMJkXBL2XVfm4xbGu/tGqf5kqj3dDL26sghpqBEHVc7MX8VJEP1vNVTOjosNJnU+6kUg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?nyJJBQBmqCLVm8sdVJHaJPPMKEsyw/gy8/Nfg1ym4mHdsDog5s4FcKqA263A?=
 =?us-ascii?Q?ov2MEgubKEJdt7WIoRca+oNm+dZmwf+OuAV8nHNPgj5SfVKJ5HFPb5bC052B?=
 =?us-ascii?Q?ME0egp3yldM/vlXzxI8PjnEME3tdCQIOhVd+dY0V9UWUP1BMTiW1e1TY2Jfq?=
 =?us-ascii?Q?kDpZzOUdSUJZcnQgnZk0NlPRaFDnZsUSsX8bhviFVWo3DY6TlrKeZuFTbtpk?=
 =?us-ascii?Q?mcKFpI2H4It/4SyfnnsXpl87dToEwwvWCZdAkHXAU4NtjRN12z4neOIeet82?=
 =?us-ascii?Q?/PXHGZGquyP9x3RStollSZmoeKfGlFIJ7kZFtnheEIT8wXbqE3GCi4lPfTPi?=
 =?us-ascii?Q?Ccu+x6YeRrAIbwEpmYPv/hSRpstAWWfGX5SMp1ckV6qfdQpNNN17DJgX7SGB?=
 =?us-ascii?Q?QEjvdPpt6dBi3AG21AarGQqxXgA+ewgdi3Bj9UrbhUU0CvxgSd6a9exuy67g?=
 =?us-ascii?Q?ezItrXweBqipTVU8oHLCj2N5hcPwutuLF7zEm0cHlGQ/oqg9riNNNhLfAJbU?=
 =?us-ascii?Q?weu894DRiSdOV/06/+AtyZhHHQPyQJMrsgtLeCfOIBa8CT0Ej29f4n6mSqDv?=
 =?us-ascii?Q?Gld1xVUWNKdbT5c4uMXQ/+G1t8haRjnAvVE5nHuHjiAW6ejZXQzyHT55fHdE?=
 =?us-ascii?Q?xq5CppA4E50GpJNGsy3keJ8ssFXNN90IioFlsTe4J6yWnPskyKrPw1xMZ74L?=
 =?us-ascii?Q?yA41KEmxqNAy6ioTGfOXSu0zej4HFjs8O/V96/ckO4cTA2UKictv+4/7j6Jg?=
 =?us-ascii?Q?mMQdHyKjMpOxeIzaReeFP+iVEhYHna6lqHSAGh9b8IX4ysY4f7phKnsL2bm0?=
 =?us-ascii?Q?dAJeXt1ZvTCSlNHdfQf8LbmF4WWsK8ENysaLl73eRmnexFwWe9oTeevbG9v3?=
 =?us-ascii?Q?Ym37sMHA+celCTl18azL8LUFkyMFEAkS+xQApRSrnxmX/dO3AMKyF/rDq8pi?=
 =?us-ascii?Q?Yp1QqwXy9ohKSMQ8hM28PtiAS/qkD6m/EkES1znVISDaqtvVDo+01WvsXsEm?=
 =?us-ascii?Q?mnEJuGbJVxjluB9A89iA+4OAawXTW5b+1MmRZW9492HN0b0iv0RmOstHCFdj?=
 =?us-ascii?Q?op2Zo+g4JzPmdyHOLnROvVJJ/hv0XEhHHpqEJ/HF1zJGVkpDHVX8d4VJstby?=
 =?us-ascii?Q?HdZFIeBF6t4S38sPRuHd/UYKdKcmBRQ0lVMlsf09dJ8MbsYZiqFcsxh/ksj4?=
 =?us-ascii?Q?DqVqu44C0x64Im+qkoqs0wG7jgT0hBn7Gfn1CeKv0CozXUDqDf5qwvyjBP9v?=
 =?us-ascii?Q?T4Od4YW/MfSsOn81rpo5F77cIlYEarFCVGTAPoy1T2gRomMpzLzbjZMSe7zs?=
 =?us-ascii?Q?ZCDKfO/7lgz2iX/MrkjS31I2RH1UOzr0OO0WWD3VnMVMo87wi0UMaqLgd0c4?=
 =?us-ascii?Q?2NqYM366tDdfX7OxziORSrtretD6XWClXcr0itaCOt3Jb86BhjKLJKsvobUo?=
 =?us-ascii?Q?3sRbKmo9x3+Hxu97GykJJUJ0VkKi9uNHfz/xEqHUEzKrczOrFk+r2JX2kLyX?=
 =?us-ascii?Q?y5TN/av2leL6PtK5RpTSVxOMcHISBAPAOJ5452tQFWIP6uqHFVZ7bkyjrq9Q?=
 =?us-ascii?Q?16S7dCPPy+R5XPIhux5Sq0numKufMXB8sWZHxxRt?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ZYJ8KaEM+lTvBms4ds/DC2GzAKu1oTlDnLESo4uVL8DPQ/EEFbZHDzgvsss6au2VbwTxvx8QNQ2qV5RuIMnxBEbLRTRmo2U6kcmeXuxs+LBGSd+XJnmNvJPOZdARjkfa7sf1kybZowOcOGlhw2iw3nICwKwkiGhRuO/k3ebgWF1Iv7xslWbfD2iMWfn2ElqOZB9oOpxwL4r3D1IdEKxKnf3IpXCIJ8ppDwjMbzPEWi/UgtaofxdHUOhk5jGkIXVzjwgb7rqmMClUh9M2FyLuv6VAyBn6H2mLkU+ojbtiF7xQqcjito/ok6gJ2zIzAoJ5WL1Z7r7uxiDA31tAeadQYeSgdBu/X3U8XBOhF0KB9G0YdGXKHKsJXw2x7VNqqrVDulbzz1N8KYByRq0voMlNUjQDJxqK4dq3is97cQgGfOkucIHMTyw+MzpGKXyegtoXQZfAnzFUiD5tr/oQ48Y8b+tJcIVyUtnSFjC4KaO5TUUPy53zhDtAYqikA4gzTMNcc7HXViaIT8paZWK/M2V0BkPq1ISlNXJMSACztg4zjTgih51d4vZE6oQaJrWX8Me64CyttHlec3Y3pw4dqMDmh9fWKAH5u5rKz5ABLOid7Cc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f4bf68c-416f-40c7-7a12-08dc3415a027
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 02:17:46.7567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I8ZQJQ5QXu0st7DNlTDUaa92kxqK87VZJxanOWFC4XaFJLjBLsGpD3dJktaLNEmuazCULj5yHBh7GWmVQR87TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5225
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=813
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402230003
X-Proofpoint-GUID: JHV3euj1UJh-jEhafVS2Dm9DmohLYD1_
X-Proofpoint-ORIG-GUID: JHV3euj1UJh-jEhafVS2Dm9DmohLYD1_

* Vlastimil Babka <vbabka@suse.cz> [240222 16:59]:
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
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> Reported-by: Michal Hocko <mhocko@suse.com>
> Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
> Cc: Lorenzo Stoakes <lstoakes@gmail.com>
> Cc: <stable@vger.kernel.org>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
> v2: deduplicate code, per Lorenzo
>  mm/mmap.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index d89770eaab6b..3281287771c9 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -954,13 +954,21 @@ static struct vm_area_struct
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
>  				remove = curr;
>  			} else {			/* case 5 */
>  				adjust = curr;
>  				adj_start = (end - curr->vm_start);
>  			}
> +			if (!err)
> +				err = dup_anon_vma(prev, curr, &anon_dup);
>  		}
>  	} else { /* merge_next */
>  		vma_start_write(next);
> -- 
> 2.43.1
> 

