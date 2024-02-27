Return-Path: <linux-kernel+bounces-84050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C654286A1AC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85006291D9F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 21:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D17914830F;
	Tue, 27 Feb 2024 21:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hjdJrH2n";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tGzRkvab"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F68A4DA0C
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 21:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709069237; cv=fail; b=cVgY02OB7vHBdsC9Id9m6lPRIsWlbTdmZjRb095AFcPV/ClEOEjO4REJGlMoA11Tl6KnVP0ITigLG9XO/jB+8eiApQAfPaRoaVanD//i71w9bZ9LpD0yPO9bf/b0nLWeG8mwzIS27g/USj/3/R00TsqHp9ZdvB82o7/JEC1nKPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709069237; c=relaxed/simple;
	bh=f/RHzN87XE+4qTYW3TRUzE/g/m4ir3zv6IyKewOGS9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=umrtdRNUzjRd8WKgV+q+foKk2zcSDE/AF5F1d+DtcjlRMSfRKsl/T+hFcYqh0nnkPeQc3zafZJnKAMwj4l1DB1gJP98TSvVnTXmknlz+UvbDXRWTQfiB9hR1Ez18jRQeAjwsnomP1hrbZ+/M/X7Xu7pIALcb5G7mfHuTAs2GQzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hjdJrH2n; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tGzRkvab; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41RKJZh7020580;
	Tue, 27 Feb 2024 21:26:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=Hea20h7qhnI1NZEd8D6dowDhq4RlRDv2OkDxJ4DO8ew=;
 b=hjdJrH2ngcHYLUozauCPFlTuTdiltN47o/77Ooi+v2dXFBjw2V+p0QjA4CZ/pBCaIlpx
 K8ZvCBeCU6zyK9+/V1y34D2NNixgc8a/pCehmxqx/T+C/DOzUjP2Gc6sZ2BPxB7906iw
 0l/UsZmxhgDsy2gcS0k8kNwgqMrk4tRaLUf0OXKlSA2QXiKaz/hepErnk3ptRiEowD0/
 sPMwjVe/t2yeYfYLgT2fiPky1+jU/Kouhqi5kl5AJt2cYYIhK0F0AaE3/WIDyQk8cpxj
 rbxHi4Q5vmakeTLHqd0cN+Kv28Cl9NlnMeHsph17nmKUovd15kaBQ3SpdU3CNSApz4TC Ig== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf90v8esg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Feb 2024 21:26:46 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41RKU7p2019175;
	Tue, 27 Feb 2024 21:26:45 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wgbdkr145-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Feb 2024 21:26:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=btGz0ohSlWtI+MLOQz4rs79od3pk5EInpWSY88Cm98RirD/1+HveTDlJNgnrxSprokF5vk5yCZYH1CS7o09TVt2aOQEQoDLbO7lzzs18ohx+8x7LK5nHZ/PBcaqrAjAHEaQ6x6JmeqXodAQWH5Yy0dzu4HSgSYqDLTMW9Mx6WSQrC3ezLHlC1G6Y4p1lrfk29/K6TTrtapK6p3AGExBXUZ0s/9PizfilbW/nKbmu10AfODBIk7PtsHfQdKpPAeA7Wx7j/qIBHpB7UdlauLrWW5BaNgxfa8m7S1Z1MuQNZexgob3Z0Nosk8E+MbsarN1Bs4qqV7eM6BWDi01VMtOpTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hea20h7qhnI1NZEd8D6dowDhq4RlRDv2OkDxJ4DO8ew=;
 b=m5OLSk4DJ2tOWa6HbAlk5tlylfaUlsY1YTB1G0skP0ov/m403a1Vz+b1XX5azE2fJ6vBXX9YoH142YvGjlTWbVJ11ksDl4bG6PtGUG8Ika3+mHjUdL7lHg7n3CJCkbbwl2boWQ8DGf7EWSUigKrpnZZb9efLV0PDFErFh/5HZMuclHoZQFD900Rd3bgbkCIpUyq9ywfK9anusVnSxdQ2B5WFWp+TGAC9UtaEFxtcQljjWTAqoUx68o4kgJOa89R8JSN57T3cWMLcPm5yfqQdw9DfDL3wKGsUVFTPhXPjJvbXi7t2aV5NVJkXmFzFzKOb4pmGTcORRIwGhmf2IS6IOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hea20h7qhnI1NZEd8D6dowDhq4RlRDv2OkDxJ4DO8ew=;
 b=tGzRkvab8yaIJy/Bjz+bMpUp+kCkV0RFTC8QHcuwTYUQ848hyB9S8TNM6wP9S1jB/fjVQtIVM+c9sveZWle59GROCSMgBAcbCx38OL8n/M9TqNVd85IlzhVYZnSgTuJAQxWJZl1psA+erjfoFnHT5DA2CayS1Okwj1nZz48yU8c=
Received: from SA1PR10MB5711.namprd10.prod.outlook.com (2603:10b6:806:23e::20)
 by BLAPR10MB4961.namprd10.prod.outlook.com (2603:10b6:208:332::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Tue, 27 Feb
 2024 21:26:42 +0000
Received: from SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::16e6:c4e2:745:a0ec]) by SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::16e6:c4e2:745:a0ec%4]) with mapi id 15.20.7292.036; Tue, 27 Feb 2024
 21:26:42 +0000
Date: Tue, 27 Feb 2024 16:26:39 -0500
From: Daniel Jordan <daniel.m.jordan@oracle.com>
To: Gang Li <gang.li@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Jane Chu <jane.chu@oracle.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ligang.bdlg@bytedance.com
Subject: Re: [PATCH v6 5/8] padata: downgrade padata_do_multithreaded to
 serial execution for non-SMP
Message-ID: <e44cv3c7lafc2a5p4wkhxjaipq4hgclzuceignzzp37kl4l2pj@t7bgio7s7p4q>
References: <20240222140422.393911-1-gang.li@linux.dev>
 <20240222140422.393911-6-gang.li@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222140422.393911-6-gang.li@linux.dev>
X-ClientProxiedBy: BLAPR03CA0051.namprd03.prod.outlook.com
 (2603:10b6:208:32d::26) To SA1PR10MB5711.namprd10.prod.outlook.com
 (2603:10b6:806:23e::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5711:EE_|BLAPR10MB4961:EE_
X-MS-Office365-Filtering-Correlation-Id: fe05a9f5-28b2-4757-4b6b-08dc37daca8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	NXxku/ClqERppJrNCOZEsHHnS/IoRMaiyDwmEoDmUF/z8fr6C8gGJirpTGyS1ruBEyD25hsHZG2KvHDzHRBwB2xuIsbmPcPyIcHV4aF+Ds5SPv0pD51VPTT0WRMap7lWgcSJTMNzYpOq5rHufO06XfbG7kIEm5uQEi2LmEQ+sHGxapzELDAo2+GrHcSvVjKIKbCmZB/sT4Qs3+Jm00tdxqfYXNZ15hTD+GC6QzIFqCb0WsLoOuc01e4u6bD7425feoOS7URHnxpVCnc18r8xrjWv1OYdPCCMoDm0iH1UuMii8nLY5fTcpKmzN/oZIVhS/jR68s4afnrOL3RguSt4JvDSq6pVjnhSLR6FY6SYXT2ukhM9PidLYkax5XW6+fT+tG3GgInFxG7m74a0o4MfBuW49TexGm2ZX8JYucC/ioqjY0g4Xsza7y4YYhsX/rwqV7GnrtwR+B4AVFQO4gh3wCSQQdMW6mPU06OlwRY4FvgnzPJT5qrdgiGQul0YNZCiMTLWXaRFFOzYcQZ0Fwk+9PFs/dN+2wXFm3bX8ith0l6r4QbUaK/TZcY9gtQVRF7eXHvMh3/7+d9jlbGsycQ+2dT149yLipw3eNjNM47SAJFiTQC/3vql3cPbw0Zqd6yxyPhVZ0yoAEWYl+/kJmQEPg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5711.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?vihJOUquaBpNexnrF3Zipa8IDEP4WOwNjrEci9yKOjy5FbRgsiKczj5APh8J?=
 =?us-ascii?Q?ZHzCdcqHnXN9p0l4moA/WRssUQRYZAQ7eqvfnc8a5kgMY5hgVfQGp1u455EZ?=
 =?us-ascii?Q?5A0WSTqraX78JXV8tOYkVfHUkN6b1WCbFKG4QOr30zH9ESrPFiLqoilI05fv?=
 =?us-ascii?Q?cOiZiYwo/y0qcHTHjuptfXkKoqwPbIqIY8JXo+vj1tdiEUcCNAYGq77PoaOb?=
 =?us-ascii?Q?cjYvXsm7KKnNfH6snbS6jX11Bh1ABbdRz00SNf6ABz6dF1vNXY/JnldUAxbK?=
 =?us-ascii?Q?WGE/dcAlcyD3zkyrkjluzZ5054GZVyC8Sx6CUyfiJ300lrQYSUnlh5Z/pnTw?=
 =?us-ascii?Q?a4AtrxnyWBApVHhkfDQh5C8FqS5ixNSug0fCuTaCGxIJrAvohxAD5ztKzYLD?=
 =?us-ascii?Q?223M5zM45tu2TtpGt6jK90LaFRXptH2enDmpuUZ6AI2k7cSMcvvK7iqqI1+0?=
 =?us-ascii?Q?zW31DQFwjRwvaImxL4/31YW9P1qxC9FZTSZnxLOgrrwo0SIVbESJB4MeW7BU?=
 =?us-ascii?Q?9zWVdJR1ZwPsoGnp7RCSEoR5G47B3UAyV/YCbSvJPAekRqKDhBj8jnaKoNsk?=
 =?us-ascii?Q?vLQfIVAK8IC2dAfRV41FPtyPNbDRnaUXq05EatPmTBuCEUtfxLMWfz3Zdub1?=
 =?us-ascii?Q?836GbwYzu2bC8gDPZMeM/LV5+RVZKbENiCWwssz9+cVDuXfdaY/xRmtooZpS?=
 =?us-ascii?Q?MnD927r7IqVIhVzSSoQnkxlOjK7+Usb1qikPtP3c+DY8QTsBYEewUXmcR+ec?=
 =?us-ascii?Q?aQwrh/78dpCrtsaVXxXGUOKkJ2c0Dy2dRGtsrOHPiwoDF9q/i5juraG8H2Rq?=
 =?us-ascii?Q?QjQnbLFJHvTLDDezd5sL1y48o+4SatXBQrNtYmxQG2lYEB/U3fBdVNChNKRT?=
 =?us-ascii?Q?gmPM1dyyyf+O/KmPa4jiXtrvdjRRplcd/JUrJe76hy/l4buMSP9toePsWaM8?=
 =?us-ascii?Q?BGjwvIVayIKoc6rCBzxZ1wzGMpDDwG/3dHwNOQ8iqt/aWyTjlDMQqu/OJ39h?=
 =?us-ascii?Q?MYaH/6WYqfXtVvxUKHAvUnJhvguaO6fiRDpSmL5m3i/tpOh/rfVVd+7OtOv1?=
 =?us-ascii?Q?okXeWmZIJuw+0Qo2eIj8TRPd3xLYAKdBV4Re7T8gcae9ktpzWE4dqKQh5tbA?=
 =?us-ascii?Q?WZtnncYeF59QfDxuzxdFwHwPvaB+kpkxB0M957gsH9jSHiNr14OvafqgWTDy?=
 =?us-ascii?Q?rTwnbQpi9CkebRNbQsvcqKocTOxeDZC7kQnvzt+ARi371tJzAEm9vDEGXkd/?=
 =?us-ascii?Q?6Nzrx8n62Tk/xu8T6mitQyrwOMaqOlMfkfvT6cJR/OGjVcVTXnInjo24HPUj?=
 =?us-ascii?Q?APbuDCQw/tVCGFAyafZO89a5+DiEUBZAPa3pgC7iMdxpqR4wuKXnvJ8CMcy3?=
 =?us-ascii?Q?/1ZG3VpwcVtjoLVUiTI1TGMJkXSTSb+FWbMdKzuvEiwzj8dY7uP/65bEydy8?=
 =?us-ascii?Q?TIjBO8Vskv56eiMvYQQnOmoCZgDPHGC2/7pp3VndEqJ7BpF1VqGCyIiOKSru?=
 =?us-ascii?Q?TzM7HBLYlifwnT6VKSqjZ08ydUeYx1AkKkNOoItxGSCQSh7QR3pUUiVvNniX?=
 =?us-ascii?Q?MNGtzY3tiFPZ3NzvRGpi+fBuqIMrfkFZHhEgVbux0q1kizc0kIVfuLCdubZ/?=
 =?us-ascii?Q?UQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	LbCkmUoXJcGQ6l+U869htG8SiGKNlhI73SIfJ54D/MGcn7tb0yyVnNBzSKF0oegFXDMBRTEdP4AvOGGmuA8OFqoKd9tKHgEa4Wbc9+4fiBkxwo3est+SSYblYRNEIPeJqqeteARIj+a4bR46Gb8pChVtGhr/qI7+WlYYIrefyB2BgEVH8E+oCAlilYGd+A6IDZJXyVAX78wiU8L6zHrm77UTd63CIVtNUMRsBdl3AR5Q6VZx+jSDI98AZSaMcS992L9UP+8B/khQknEedqJ1rhYaPkuhEW5ofoJxIiCtHb1059cLN7WqnjMtw925nkHK0d/tFYzm0g5jzdSdBbM1NEGDBNANXf+B9Rvbt+dIrk3pAZ5AFn+wolYKJXAtmhpyHAxSs3ZpOH9TKhHRcSjla9CVawWjE/IrJu3bd/w4o0TENOz4jzuhljc5KWy6fD8bZB6re6XjQwXs13Z1WX/N9gXITc/JL9aH0n/6uLUwSzPl+nbGWX4kvc9jfmUx6zEREcSTGOf9DVz7GV0w3OSB65yAW3Sdb8nylzhBkYCpEuOXDzmV3oqN4LlkVNzuoA/fa4E3X24cWH7bDzchm8Z/YZBkg0MARE4ujyiKWfgAETQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe05a9f5-28b2-4757-4b6b-08dc37daca8d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5711.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 21:26:42.1958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iyOG72du24LNyq7qP2FevwV2iLsdt1gaOJmZ2qa7ZcBuaMdw3c6mlfCCUJMgFkFi5BYFu+6nYdHNg3ewatkcxK4zq54S3CVhXSRxVlOK67A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4961
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-27_09,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402270164
X-Proofpoint-GUID: ILH-E7pJbBaIXxcYh0IZd9xbmaeKLwmd
X-Proofpoint-ORIG-GUID: ILH-E7pJbBaIXxcYh0IZd9xbmaeKLwmd

On Thu, Feb 22, 2024 at 10:04:18PM +0800, Gang Li wrote:
> hugetlb parallelization depends on PADATA, and PADATA depends on SMP.
> 
> PADATA consists of two distinct functionality: One part is
> padata_do_multithreaded which disregards order and simply divides
> tasks into several groups for parallel execution. Hugetlb
> init parallelization depends on padata_do_multithreaded.
> 
> The other part is composed of a set of APIs that, while handling data in
> an out-of-order parallel manner, can eventually return the data with
> ordered sequence. Currently Only `crypto/pcrypt.c` use them.
> 
> All users of PADATA of non-SMP case currently only use
> padata_do_multithreaded. It is easy to implement a serial one in
> include/linux/padata.h. And it is not necessary to implement another
> functionality unless the only user of crypto/pcrypt.c does not depend on
> SMP in the future.
> 
> Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
> Tested-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  include/linux/padata.h | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/padata.h b/include/linux/padata.h
> index 8f418711351bc..0146daf344306 100644
> --- a/include/linux/padata.h
> +++ b/include/linux/padata.h
> @@ -180,10 +180,6 @@ struct padata_instance {
>  
>  #ifdef CONFIG_PADATA
>  extern void __init padata_init(void);
> -#else
> -static inline void __init padata_init(void) {}
> -#endif
> -
>  extern struct padata_instance *padata_alloc(const char *name);
>  extern void padata_free(struct padata_instance *pinst);
>  extern struct padata_shell *padata_alloc_shell(struct padata_instance *pinst);
> @@ -194,4 +190,12 @@ extern void padata_do_serial(struct padata_priv *padata);
>  extern void __init padata_do_multithreaded(struct padata_mt_job *job);
>  extern int padata_set_cpumask(struct padata_instance *pinst, int cpumask_type,
>  			      cpumask_var_t cpumask);
> +#else
> +static inline void __init padata_init(void) {}
> +static inline void __init padata_do_multithreaded(struct padata_mt_job *job)
> +{

An early return here for zero-sized jobs is consistent with the
CONFIG_PADATA version and avoids hugetlb_pages_alloc_boot taking a lock
and flushing the tlb when there's no work to do.

With that,

Acked-by: Daniel Jordan <daniel.m.jordan@oracle.com>

> +	job->thread_fn(job->start, job->start + job->size, job->fn_arg);
> +}
> +#endif
> +
>  #endif
> -- 
> 2.20.1
> 

