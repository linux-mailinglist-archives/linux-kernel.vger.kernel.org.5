Return-Path: <linux-kernel+bounces-35464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D65E9839192
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64DB61F29234
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8595C5FF;
	Tue, 23 Jan 2024 14:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZUFmurbW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JYQNgpVy"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB904878F
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 14:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706020823; cv=fail; b=Odi4uFWV8FXtBN0zelDfKsZUccsn+DddTtVL+V3d+83A/wSfPuNlVPiybcNbbc7VAljwun/s7Ri0fkroF9kFLyQ5WbGENLs8ZVrhdQAMi5cIH2dJSPLBBMSK3hp9D6Bh4Fp3esXFK/Me2hBmS/GYWWaksAf/oNTkAW9O5ElRJO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706020823; c=relaxed/simple;
	bh=Up48GYwAHHrXFXhvn2iGWz5lCPn7QP/7LDDp0PGTf2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iWk+kOUoppqvXQLFZyzfJPEQewEkuyma2WREnCwGvIfEJVFrRYL12JXX64V6J1pZddHZbyvsemgTUeCXLx1+gq3wokCuM88wP911J0L0Eqa2O3eblIWl275wicSBqycWvai7jb83Frr4Iv7sLviB/xYv9JtgKuPl+rPXwR6qQ4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZUFmurbW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JYQNgpVy; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40NE4SDS003173;
	Tue, 23 Jan 2024 14:40:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=8OZehOmSwLD9+OvHVIHwy7gpIAA4BgqXzZpDTSlkaLc=;
 b=ZUFmurbW/OnLj3PFXAlG5rnxT3KesWLzgyYonMldXm0c5qJHGla5OR01Z3HIoWhUFa1k
 okxyoThT/1fBl9bDMEWgYGHRO15wL7gKD82wIwIoyhCAn2phDC1nve6M8rDFWig9/4zC
 nsMprGyB6vHfCCFgi+3oFmOZ+9VbW9DBXlo43FEAVA4igdDUsS6YNO9HlEawgDUj7VAW
 YEaAA71i3+ir3OCVguwxt/5AUc2Orq599LT76Pd+RvRl3FC6CZYVBa58pgrBnvo4x+Ec
 Wt2lMcvH0isUeBbrD5unO7isyHrOAtL7K52/Sx6HIHEMmp491sGrKqFbZy1NDeKSSirV YA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7abxdw4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jan 2024 14:40:08 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40NDpuUR016327;
	Tue, 23 Jan 2024 14:40:07 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs32qwbfd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jan 2024 14:40:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aZfa2DzBRcY92Ydlp19o9Q60KmYOWfpP57xr1F6HGtL2UR3SjMy1y0cUhLTFzCEizxssPbyKwN8cIHltXqX/n5C5PgnBhshM4tH56reC33NzcOAC1AJFkxoDMR5CKjwaCYrKx8iDEG08eo75eJNHvSwY3/SvCawlZ+Alxpn/ZZ458YGHTTmTeAWH0aJDJgbNKwK6+80Y8uB5NFbWFLVtB34TBA9hURPhmQ0clMeqtchsf2k8DC4j76k1drE3r1C1k5LmFY1Z0baIL/wewe9KhTws/JO1nn98ipFp9svs5HryMwTNwFXoaEhOMXYAM73UAQI0UTfa9bkuZldrHm8Xrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8OZehOmSwLD9+OvHVIHwy7gpIAA4BgqXzZpDTSlkaLc=;
 b=W/QLZAT6Cet80/NGSJqcceGkeX8NI0zPKwQ61C8F456P3RBS/SesrhI2fCnHwg1LB5fJk3hbvO1gLYnowYho5dLVm6fIF0OfDz6Zraq7soyeqqPeZWH5jvdzzuf63AVUOObT/44KT/bMVi54ZJ5Tvm5pJw01/xc1Xwc76Zy2Gw4bDBOR5BCibreCMLm+SIFO2XlaQ1bA32B0ipubvpvJscx+rXaBYJWbSjGKWcCPBeIjx+8FqhWv4ZGQh9t6xNSvqYVXRlzY40e4ZdTE/Uf3cgLCaQjSis3NH4JyYcmi+bfEK29MUyj6NWTtOLtBuZQ1mIvdLDD5jbdbYgpXkkkSGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8OZehOmSwLD9+OvHVIHwy7gpIAA4BgqXzZpDTSlkaLc=;
 b=JYQNgpVyOZOEc5EeRJu5YC/YrbSgRNoOLoICta1AS/Tg1nTq8N8BwuK9+BxH2WHXCGugHduFLZyJ/RyqVwdzCgITDAds7d6ucBGn1/omrqopKt+VslrK2zbN4KyfhWWXiOpBKXphuPaNa+PPA9f3dW23zEiyvydRUDv9cgxH+Tg=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by DM4PR10MB6133.namprd10.prod.outlook.com (2603:10b6:8:b4::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.34; Tue, 23 Jan 2024 14:40:00 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606%4]) with mapi id 15.20.7228.022; Tue, 23 Jan 2024
 14:39:59 +0000
Date: Tue, 23 Jan 2024 09:39:57 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mmap: introduce vma_range_init()
Message-ID: <20240123143957.ce6h5cqx6yusds5w@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Yajun Deng <yajun.deng@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
References: <20240111021526.3461825-1-yajun.deng@linux.dev>
 <20240122220031.pwiravglee7o7k34@revolver>
 <20240122154031.b710f834b14d9027176f439a@linux-foundation.org>
 <20240123001830.glqdmrv2qc56zfpc@revolver>
 <2a1d6a9b-f486-44c8-6d1d-e6bab4dc3ced@linux.dev>
 <20240123031906.pwbjuzdpl6hqiptj@revolver>
 <11da8b32-9946-9f7c-95fe-f6254b4f6e99@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11da8b32-9946-9f7c-95fe-f6254b4f6e99@linux.dev>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0047.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::26) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|DM4PR10MB6133:EE_
X-MS-Office365-Filtering-Correlation-Id: 2314e11e-6836-4cec-ab03-08dc1c212cc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	6+206T6Y6BtKL6jJi1Mp09egFINVfxyPxym+YhWS/ImRjC5ouv1KyO0DNBvBVKZNfx3nx8ddGykvVtt/VtfmjS+/MCRF3eVDlDW4oIuW1joJoXmTqjnQuVvXma172obl/Gc5buApHBlUBfaRgGQDulbVWsi44p9l5lYDTujlIOFEdSy5keBZujCBof/nlwhWZV41zf/vwsXYY9MZJz/bqCksjQqPC+hrvm11YciRY9umstLgP2phauBlXFneZf1jLVQuDF6dAZkDH3xlOAOAaSk9ei46EuHRznaD0gmWIps2d+f+5QSzGUM3fwCpufXnGUJLKglWhNfE9LQ96ds+1Rb/8lxe2IO5hIRfnj73d5U1f4tYbQYs5w82a73aJ0EcDq8V3XN3msQBx6duJCNI1HNbepZVMKHbpDG90A0TtY5c1uxdvIdsWk4JcJbeqZl5JQAasGC0j7T9xGxYOXkbSArfPsEem4mgVtvTsnheUpGb3CVFP3GZnkxctmPWxqKO0FPBzm2BcsueGYDu5nYgvl12uhO56GekItYYlba0abAlw0RNPg6/qbzWDQydGmdW
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(39860400002)(136003)(366004)(346002)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(478600001)(6486002)(1076003)(8936002)(5660300002)(4326008)(8676002)(2906002)(26005)(83380400001)(38100700002)(86362001)(9686003)(33716001)(6506007)(6916009)(6512007)(66476007)(53546011)(41300700001)(66556008)(316002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?fm2rjZfqY+C32cvd5Aet9Ay0RYgHAFGhKidMvny0Md3vG+b/doI4LmWzShRX?=
 =?us-ascii?Q?DWZcvK6myHZ4oLRZ3xAxVpvHIVjuccrPKjCVoo52vxeXGqH2UtWFI1hOBZ3c?=
 =?us-ascii?Q?QFxv4RJM+ns5j44QbG1XKD8vf9D2wBHuc9YYcjJxupzBfkiz0h/gw92Lfhea?=
 =?us-ascii?Q?Um3Pk5xmTwyLYB80ZMhmfqa+lyIACpjbG0qzxV0uCpdzHpwZ/pmHLwU2VOh1?=
 =?us-ascii?Q?6FbhFWue8kdeoG923ov+Ut1WusIqueZTpCnBdDt0+q61ysoOASYIkA666OhW?=
 =?us-ascii?Q?fkJ42hHR+413/cmsaaXIH9zXiwnpjxEdd+lqCov85ZOJh874RQq2SfUJceT8?=
 =?us-ascii?Q?MTFLtenIwaoZ742m2+B7RRXiR+eI3HCzAW15DADG+ZfhT5DaR23kP5sdkmu0?=
 =?us-ascii?Q?3XHfEJ5HEJg92prH0FLDnySZcMyAEdoSSl4VV6MyM9bMpqW78zZou4XhiyoQ?=
 =?us-ascii?Q?wXFVndLjEyGSwI2wLOOxwCM014WfCmcHiliovdVIge3f85GSrPJgLd5h46LZ?=
 =?us-ascii?Q?+O0uEG5co+NF1wbmTEl5XhnIl8ecRJHL6tu4dQgCb5VqS2NPj6pn/4FYsIyW?=
 =?us-ascii?Q?HWFCkrOXP93twjRSnPf1mIpZnoiQ5A4MANVAoD55Rj+zaCZDBvdXjxLonef0?=
 =?us-ascii?Q?7ouLZnN8c9N5rPEpCE1N/lIT3RhJINvQtkEBfsTFZoh5XGRjAMtMQui3Pk91?=
 =?us-ascii?Q?am78yO0t/9TT8vd0w2vFC/h2NAltdeUpdV+0IblrTqjPRU3eyFgR6Ehc6B3A?=
 =?us-ascii?Q?k7Vc/R/8P3lRy4SpgAIcyHE9HGPHkbgwzgWjjKDPsgRsXYiMYoMy4Qswoxux?=
 =?us-ascii?Q?8yDJ529F+zFH9kw0EW8LXMyufDg6dKnWMMZpfMzuQpMcto69UIMyd8n9ZvBD?=
 =?us-ascii?Q?mcGT8VozhARj0qHNFwKO8GTMkkIqRrZSejCDfq0AgYRqjVVmXtYwkcup8arL?=
 =?us-ascii?Q?vcoRZpZHzX13ixPLgIG0XsEyzl4rEaJjADgx8DrIia8WIaBfKglSvBx4B6SX?=
 =?us-ascii?Q?Vo47YqHLoLAfYgg2GBk2vf3AWmcu0whyYsubTGwHr/iaZ/Ep0KA9hP31XoE7?=
 =?us-ascii?Q?YGPGymqds7vw/ZjSEfxhSwRjWPTroQPbwos9tEnlpik9jJlSGk5aMCQskctr?=
 =?us-ascii?Q?KmeoG6ozJbkvgFOzErR5lHjWlYla0rtVE/QCRXV/4PPmOdHYyn9jHk+/2wT7?=
 =?us-ascii?Q?NyO6RfrZtvDMnnso+MV5qCaAB0qhvU4BC8b51t06wEV//AN/Z+mJ57DjabTu?=
 =?us-ascii?Q?ZSONt1IostnzX2m+8AIAgs/rykUhA9fN6m3V5TCN5m/lnyfs0vTEzVMcEX/z?=
 =?us-ascii?Q?FPoGzCYT3nn1yT6HqpGnJGPp/WW4xGed1Fp9LDPKgcz9B/ieOPQpIuBYIy1S?=
 =?us-ascii?Q?nvBBgqbEzowr3t36ztsJ3RlQutXke9EaCh3rEoXGapLx57Nb1SapVjt6rQ8R?=
 =?us-ascii?Q?gNeO3aZFW+feE/IoAkt2KRN+res/QM28+GAO4TtBV9ZYBWfkQALwBC3Q0HhB?=
 =?us-ascii?Q?Nk8zrbqrWsGvdOf9PHzWppfX2X/NMHxZZ43P3CD9T655ImXbeUoK+enOjTX4?=
 =?us-ascii?Q?l7jELPqu0ul5mfQJdXyU3ylD7amyAfCGPeWyH27L?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	wgP5VdNj0RjoxgX8Vlr88r56+7SCHAr27Othy/X6ko2dDqhsMAiohJvWxBsGbgDjYi6kFGQrEOLxsn94qtRI+zdlkuECg9lZS6wJlsN1y8i06RXTMBxUaf1xJimBgkbq3aspawPI1rldN8uSP49vQWBB/ZQVva4oerRQ7BHx7NM7rhAJB5W7fSCtXFIJTh7Jkow4yj5F9KShFNOB5MGnzPiQ/yoQ3H4d6JIB/aL+WhqS2PMNSwKhY1rq/7BtHNK72Zblm2FJgmwzCZFuPV8lL7aaEpaKC6dSsa/SEGOpSNr7rtsgVlAMG9apoVryhh65FY0y7bzpGoXg50wfrzluJbi9sTwlEjJDLnGSdkAQHyXVl9+NwF6FQe0vtwRgAD7fxQ19yPaqyykI8OLI20In1XkhhOBvbd9vGYrnNXVRxeQHipUta/38f7ygTVnPJhQgKMbJcGS9qxPyfTO7I5+/W7LcpZRaQX/6mSOcJc/kugD6hMDJaVidjpJ48+Zif7O4JcRswEHcSBulDrn3iCZjNg4Q/z88CCTRaXfzVwhkY7yCvEKqj+k+ou5oCifVDTAYVa4DzSJRi7nQSha4i2UYicSCpp7oXnkttmszFHlFDiM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2314e11e-6836-4cec-ab03-08dc1c212cc8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 14:39:59.2226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4XYtRHGIUfw4LW4O7AEI6ayZdcZfErV53Ksr7Mawr6RIlMBcuwE2e2fOAeNmQdABYgfjmfHBVU45CM1iPRJ01w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6133
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_06,2024-01-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401230106
X-Proofpoint-GUID: GRPgeYTcvUxgn9DQSqIo6Z-2tl7rUD5O
X-Proofpoint-ORIG-GUID: GRPgeYTcvUxgn9DQSqIo6Z-2tl7rUD5O

* Yajun Deng <yajun.deng@linux.dev> [240122 22:41]:
> 
> On 2024/1/23 11:19, Liam R. Howlett wrote:
> > * Yajun Deng <yajun.deng@linux.dev> [240122 21:23]:
> > > On 2024/1/23 08:18, Liam R. Howlett wrote:
> > > > * Andrew Morton <akpm@linux-foundation.org> [240122 18:40]:
> > > > > On Mon, 22 Jan 2024 17:00:31 -0500 "Liam R. Howlett" <Liam.Howlett@Oracle.com> wrote:
> > > > > 
> > > > > > * Yajun Deng <yajun.deng@linux.dev> [240110 21:15]:
> > > > > > > There is a lot of code needs to set the range of vma, introduce
> > > > > > > vma_range_init() to initialize the range of vma.
> > > > > > > 
> > > > > > > Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> > > > > > > ---
> > > > > > >    include/linux/mm.h |  9 +++++++++
> > > > > > >    mm/mmap.c          | 29 +++++++----------------------
> > > > > > >    2 files changed, 16 insertions(+), 22 deletions(-)
> > > > > > This isn't a whole lot of code, are there others?  We're losing code
> > > > > > clarity in favour of saving 6 lines?
> > > > > > 
> > > > > Oh.  I thought it was a nice cleanup which made things more clear.
> > > > I'm not totally against it; that's why I suggested the changes below. I
> > > > think a name change would go a long way for clarity. It's not as much as
> > > > I though it would be though.
> > > > 
> > > > > > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > > > > > index f5a97dec5169..abb4534be3cc 100644
> > > > > > > --- a/include/linux/mm.h
> > > > > > > +++ b/include/linux/mm.h
> > > > > > > @@ -3516,6 +3516,15 @@ static inline bool range_in_vma(struct vm_area_struct *vma,
> > > > > > >    	return (vma && vma->vm_start <= start && end <= vma->vm_end);
> > > > > > >    }
> > > > > > > +static inline void vma_range_init(struct vm_area_struct *vma,
> > > > > > Any reason this can't be in mm/internal.h ?
> > > > > That would be good.
> > > > One other thing, do we trust this to be inlined correctly by the
> > > > compiler or should this be __always_inline?  I'd expect it to be okay as
> > > > it is, but I've been proven wrong in a perf trace before..
> > > > 
> > > Okay, I would take __always_inline and put it in mm/internal.h in v2.
> > I'm not confident in this suggestion as the rest.
> > Please rename the function when you move it.
> 
> inline is a suggestion, __always_inline is mandatory.
> I think __always_inline is better if we're demanding.
> 
> > > > > > vma_range_set(), vma_set_range(), or just vma_range() might be a better
> > > > > > name?  My thinking is that some of these are actually modifying the vma
> > > > > > and not just initializing it, right?
> > > > > I'd vote for vma_set_range().
> >                        ^  This part, use vma_set_range() please.
> 
> Okay.
> 
> 
> By the way, I sent another patch with ("mm/mmap: simplify vma_merge()")
> subject a few days ago.
> 
> Please comment if you would like.

Oh, okay.

Can you please Cc people on these?  I almost missed this one and I know
several other people will be interested in the vma_merge() patch
changes. 

