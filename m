Return-Path: <linux-kernel+bounces-4352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F4E817BE0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 21:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6199E1C216AE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 20:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFB073478;
	Mon, 18 Dec 2023 20:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="N5Evylom";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="txfQlbv2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D670E72050
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 20:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BIHXnBY018085;
	Mon, 18 Dec 2023 20:28:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=pvS9NYpAiOu/WQGRJDc38NKAgwFpmsIhCm3zi6u8yhc=;
 b=N5EvylomGvmCNUJl4xACFWB4M1QSqdO1Zw1s741S+0AXgPE/nPLz0bEtlLb2B7HkCISQ
 CmkWEjVZxdZpxEgeoH/20nToNqDCRpOfKe/K34wDR0VpyEJUqJzzkxko8QWvcU/7bKM9
 Cfpveb4YvlO4l3mxwvxhlwA1kThOZgFNKx1ZeaixlWIoM9MYz0mWmKA4SHVFXdQZy5Gj
 dtrJXxUO1WXfK2tLeDSxSgpPy2NpU9qqyRoJ1Pauyf/cSW4pk/deDB+D3EtIV/LKdLcb
 w7P34XSUAA/0CcqlZe+czuFoANTcE4JgNBQRdZvxcCfx/LeUJ6HOBfZej4ZDxXzO42bR MQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v13guc8j3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Dec 2023 20:28:52 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BIIkcx4020999;
	Mon, 18 Dec 2023 20:28:51 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3v12b5xwwt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Dec 2023 20:28:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NNwrVmPT738OfFN+1NWGsJV+3mhrz3ZUlFhaQsUco1Qhd1KohWpr6FinBNLgXV+J7lAKHLDIt1JDcy/DFGCnDfZSPyjizgZrpQ8BUBq0MZx2OA9MLaK/KQJ4Dinnr38eE0fUpX/QnOV9wP4p0Er+0BElmYS4d7dEXVx/yCEEJihlfMCTVYJg061NQ5bZa4vnvj74RLDW2oeKqQGoO50R1MPTKNztNTOUg98u1UOq3zYpOTBvmpRDARCz05xoXN/vR3V07AvZoTvJ5YX0Jex6iGUww6xVEGwd7hGt8gATyUNFvYFSIcqjbk7PfqMqRp3U5A3i8PC+yQMp96hejLEh+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pvS9NYpAiOu/WQGRJDc38NKAgwFpmsIhCm3zi6u8yhc=;
 b=iJJDUYfWkj9A6wP4X2xvRh7O9PdqVnaiLFJ3QWZPnqtncFXFZvfAud47h0On9xC2O6eaB4EFGU+UaSNgFJSEXGzIsAAwokE1cgs2mxo0b7n3FObWz72w3Fo5IN8WasO4PrD7Zj88lkqUH6Y4r7bJgQkKwEW03ZZVOIYWMBhb/gi4vn7Z+cvjEMED0BcMxXBqDilX20951Q3dNsT1TOmFSNPpskLL9w94OwalFjeNpjEyuPgkLHCfo0r5ymmQidh7Qq1sPbHeCFmglFS3ZzIiFLMTILL2wpptyaPsn4Kmhl1iXG4N6rRVAjAW0XATsxcbCc5LXFJe8XjHSSCR6uDRjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pvS9NYpAiOu/WQGRJDc38NKAgwFpmsIhCm3zi6u8yhc=;
 b=txfQlbv2krzcaYR2NTcdrHLMRVLhfjsA6f3ZQfD9NOp0hsPvwYqR8drIZeXNNeJa9wAuqxD+/T5Zb7hnocgKTLnmQPU4LqREXj+xYe7uWaiSAtSRQ5jaqqMXQO9clnp79hIrBtb5yAAAyK0MBQ5y0G7uwTLU/33bxJOtkN8Riws=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BL3PR10MB6041.namprd10.prod.outlook.com (2603:10b6:208:3b1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Mon, 18 Dec
 2023 20:28:48 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a5de:b1cb:9ae1:d0cc]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a5de:b1cb:9ae1:d0cc%7]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 20:28:48 +0000
Date: Mon, 18 Dec 2023 15:28:45 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org
Subject: Re: [PATCH] maple_tree: Avoid checking other gaps after getting the
 largest gap
Message-ID: <20231218202845.buffbdq3vhpiv2py@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	maple-tree@lists.infradead.org
References: <20231215074632.82045-1-zhangpeng.00@bytedance.com>
 <20231218202014.mpotsekdkszasn4t@revolver>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218202014.mpotsekdkszasn4t@revolver>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT1PR01CA0125.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::34) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|BL3PR10MB6041:EE_
X-MS-Office365-Filtering-Correlation-Id: a5a49bab-4770-48c4-b739-08dc0007f080
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	k8Pu5H3or42gZjTqCZRFkvWeOp4nWnMHw9ML3OkDTXTiD6PVGLR5swQdKhs3FABstxvHR/6jUJ+hTU+f4mpAELgnkOJDC7EZle+/EQdpXAD1IYGibVwaHnLyv1okjWnNgoubgEi6otE7dOtdlzPLjFirowtEURpDvFMvWpA/VAZyCdSb/3cmDtW3rrjDv0UkZ0Bp9PCo5ahfxl7EGPeKxVMHWiMB7i2IPFcoa7HIbPcBHzw5Dv9+71VmfsypV0G10LQAdS8um2VB6uBsG568Hs9eLqA5wNBxTE7gW3plyy2KYJscGth2HIDpzLDP4mxyztB3oqmBKPo3HrYOh+l6Hh0303TpCSIFU87ICMDN6poFMX/VWKCcywd1qQCW0+8OTjRReS3RXxeBwHJELNLN9a12fkLdDIPZzVI7sK3Y8K1l3fj9jOU0qzFqjOHNyA9vh+wv38eGFUXCgedi0f99oANjEWT4UjLbsGb3yrISMwA3STTCpB4NB9MehOLTRetIUu0ZNPV3hH0n6kvD/sZlQjo03Lvafty1RATq0B9D/CIFRcd1k9Ugi53haTV9XBQ7
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(83380400001)(6506007)(9686003)(6512007)(1076003)(26005)(41300700001)(2906002)(478600001)(5660300002)(6486002)(8676002)(316002)(8936002)(6666004)(33716001)(66476007)(66556008)(66946007)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?/a5j5fUDz7SWfDzFr9gfSwG23rpUaBymy1PK1K1sot2S/xUsoA2qYi8kFzb/?=
 =?us-ascii?Q?+zI2B1tLx0FOyrdzZTrgQ5z3snNQ4eTdf8bEsdZrnlL2BINFldpR/Cwoa2OH?=
 =?us-ascii?Q?Vl0smcNQHbRTQrYB0CdP8vGz/9OsIDwFVHDjhuddzfZIjUL8VqZfeOk1Sa9C?=
 =?us-ascii?Q?gbI44pN2CCIT7lk5mPeqOYqfyqmqA3MuCvMr8E5AtElbb4+KXIZfrXGiKFbf?=
 =?us-ascii?Q?4mSv4vyqoxkAW93J8GXPziN22nfQjCxKjT0KethLCU1c8juLayjzn8Mvq/iO?=
 =?us-ascii?Q?mPKKObakxIyiAh3xU4KZy9Di1t4PcCzbeKs5osW5FTZbMp8SlJZgpMdHBnnC?=
 =?us-ascii?Q?8Z4aKlttZ+gem4pWmyH1zNfNxr+yoPgOctF4gNx2alf4rLAx0vAcfULLREZ9?=
 =?us-ascii?Q?Clf5EmUhdGwKipOZoFs4US5n5GPklPt2s6ailcH656PoS+GCcwdvYMw/jsqS?=
 =?us-ascii?Q?yh+WIDQdNnKFO9ucx6SXuNNStc6lClQv7ZiQjC3mbc+jnn6dE2IkKJEZjSLY?=
 =?us-ascii?Q?+3GRnCVPJ5OLZgmSIEe8ecyEy9fbBEQsZNLI6/pwnLtTk7sUoKs0Ijadjpn0?=
 =?us-ascii?Q?/a/Cqvz2NJMwrobvlQb0Ioe68Px7ajA26F46dxfv7jLYGtMqUK6AH01Ckqfx?=
 =?us-ascii?Q?xv4KgtNwWTfK7n2xT3+N24l/ex8nY+Zqx8AewUa7dQwf6nsrYAnmugbQPqs8?=
 =?us-ascii?Q?LyePfTTigD7SeyQ4LBO8bA1PbTclP308oaDGUFk+RHz/Y/k4l/LNCMOUIFtc?=
 =?us-ascii?Q?KDNufP8R8K93PjalBafJVFU5meZRoFNX5rlVHPgeIQ0TxII/DHKPIDsSMEEK?=
 =?us-ascii?Q?N0vktEpQGS6+k8aWdb9QtIBUfv8F9zSg90ZbwPjf0I5TRXzx18sO2MGl2GZD?=
 =?us-ascii?Q?/Q5JGDF/5hQchMEZMmCKf/4oWDFInoUejZZZbvXwch4CAdVvcL0eSR1qlUgH?=
 =?us-ascii?Q?pbjhPtRGE9QWigFwC6AXAkEbbV2G1WhASGfWhGpsjifkczzeII/HSWnDhQLc?=
 =?us-ascii?Q?g+CYWrokX9lGKLehFUe2XFu9IuLGDiIaLcKjIRt5wHwA+fm0GWSxkPLm5/cM?=
 =?us-ascii?Q?Ksl6zLapWisbNRThRM5an1+gZMCmOiVUUjKHQnqq8NVY7CuV73AlBYCBPY3Q?=
 =?us-ascii?Q?qZdy2mBq3qWXdpjtlV+5mcIDfjZnyBTA/7OSYBlZ4qocRpLko9A+kD/kilC8?=
 =?us-ascii?Q?Ot98PQOVqbFfZXYhd9xm1kE8OgRrH+/9tQSgmg9ngtoYEA2mEuSU+Yx6PIjK?=
 =?us-ascii?Q?CzB7iu9IGJjh8cvjl99y/m8tP2Fp+2upTQhSjtURREgSAukUPnW/XRxJQ9ZE?=
 =?us-ascii?Q?XnbZnvKxFRZSzDA1IwktzwJnJ8YRyYFQiCDanMpL9SI9ezGutSOOMuzXxhN5?=
 =?us-ascii?Q?DdcwljEtfeCU8PpJ2153KK7vUy2Ns5Sk5YQ9nwtgVNaiLH9HO1LRoYP72p06?=
 =?us-ascii?Q?lL0P45YLxcBLVra2GXYqWH8qOO/aISR3ENYD1qfEUGCq64thijn0V4dkyevu?=
 =?us-ascii?Q?0eYOm0BlBR4GfluQoss24V5VrKfhhSqPAdcHEqDQ6Akcd+fXHEgh3vxv32+Y?=
 =?us-ascii?Q?PzesMn7LthsZlgr0zppaWJj36mmHH9535RVH4VE1?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	OBHlwN+Hs6V6GrK984sfwKJgmgNN5OWvI2gC9CF1hiVQEB7bO/dVVZtEgwBgo4mcrusOBxisOs5diQHQIP6OOvgVzpLJTCAbNQAUpLynOw1h9a4moi4l2TC+W/oHjABiFY8bXsjGBsAsmYx+6i8H7goSDUB3yJv0Bcx1SC72cyUK1JAi9iwN9rkcNOOag87Gn1o1cKEWggUPZ0G5I1IejcpL8Vv2Fc1SBjN5kWuczfXgNR26qDJliwQu39qAWotj6L3bhq09WwjpKGPp/pLVW5ZYZWBfiJcCpFrVpd1qEzHmwaSaPJX8rdpVAQ7j/+uCieoQEEdqY3KD6LhK3Mu2MAXk44kLgKt+3whHjikHz3c7iYd8W6yAhESZ/D1Oj1Iv2K5GtSOuB+feKKw24d/W7UBNfxW8v4r37pDrlX5wnJ17Z358RxIS6KX+5pCyzb/B9BP/AUoNLAZQA3dCpEff6B/6joElfLZIKtuUe/WKWEnFKLGHhC5NdusiAt8GHkO3LHAjx5QUf9VirhNt83F7DQeQwG61A3HjisFOsSqcLtn8M1vgNU9V6jUdkyVMkpOZpstlYzkboVFKSKL/m3fbNWqc54Pu4g16bBUWtEclzHE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5a49bab-4770-48c4-b739-08dc0007f080
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 20:28:48.0270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d9RinggWibA1s0tfeY7Y0cpI6Lg116smJiZmGkFBIPh5c7UuDxlT/SkFU4qfLH88n2lkL6BjimcwH82SYsiwVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6041
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-18_13,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312180152
X-Proofpoint-ORIG-GUID: SkQ4wP_Xe86g3Vf6CN6avNIjUmVxwxDT
X-Proofpoint-GUID: SkQ4wP_Xe86g3Vf6CN6avNIjUmVxwxDT

* Liam R. Howlett <Liam.Howlett@Oracle.com> [231218 15:20]:
> * Peng Zhang <zhangpeng.00@bytedance.com> [231215 02:46]:
> > The last range stored in maple tree is typically quite large. By
> > checking if it exceeds the sum of the remaining ranges in that node, it
> > is possible to avoid checking all other gaps.
> > 
> > Running the maple tree test suite in user mode almost always results in
> > a near 100% hit rate for this optimization.
> 
> This should only be triggered for right-most nodes and root though,
> correct (mas->max  == ULONG_MAX from just before this)?
> 
> I wonder if it's worth special case checking the first gap if the node
> min is 0 as well.  Might be worth looking at, but this patch is
> certainly worth doing.

Actually, not just when the min is 0, we have a special case close to
here for slot 0 so we could just check the same sort of thing there.

> 
> > 
> > Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> 
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> 
> > ---
> >  lib/maple_tree.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> > index c9a970ea20dd..6f241bb38799 100644
> > --- a/lib/maple_tree.c
> > +++ b/lib/maple_tree.c
> > @@ -1518,6 +1518,9 @@ static unsigned long mas_leaf_max_gap(struct ma_state *mas)
> >  		gap = ULONG_MAX - pivots[max_piv];
> >  		if (gap > max_gap)
> >  			max_gap = gap;
> > +
> > +		if (max_gap > pivots[max_piv] - mas->min)
> > +			return max_gap;
> >  	}
> >  
> >  	for (; i <= max_piv; i++) {
> > -- 
> > 2.20.1
> > 

