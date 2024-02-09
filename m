Return-Path: <linux-kernel+bounces-59715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9026C84FAD9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B10601C26DDF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788B37BAF6;
	Fri,  9 Feb 2024 17:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KSFwMuaN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="O3sMTjUi"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6099669971
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 17:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707499073; cv=fail; b=usVO0fpafHDWyusRVJPyYMEblPpxESja5HbUsz/pqJLfpQQCdDenjwnGrjge5meRmxiOmufpsiPlBTwYbRhCcM3W7zuiQxMSXaZkMr9VYqNHuQyPDOA6NCTEGPjoiocq4p0igO3ZpEke6cJekvMYtDMHbbdlOeJVy7egiWvJXs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707499073; c=relaxed/simple;
	bh=PIcOcByiOJ8APBViHYttakw1VZNKK8XpPFFvCyJtpBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lxW4hL3POUPvJn8xa8tNcd+aWR5Z/JZ8ecWL0ebNeffMikxM76dsmVAuIF6Kjm7pRkLM853gFYqJImZw5x2feRuwtlWwGnRs5jBvNVYTeDByfOWUagK5blpGgVwfZWLCg/Itx2EIubmh7cRAEpdc+3B0mg/BsPI4qFkeBVLU3J8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KSFwMuaN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=O3sMTjUi; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 419H4Kil011139;
	Fri, 9 Feb 2024 17:17:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=mo456TaxBxdIckvbg/DIVjF6qc9a45xu8uNAvhcVhug=;
 b=KSFwMuaNLPmXt2y9+029jb4FC21gitocIw07NnwZJN+BMtRp7yTc7X6AmjQex7H19fkN
 Mg5N3PvHLa0DbRg06ur47xvppOMsHQuuUvV+586P89P5jCUykLpq3hD4XLtlyasOw1br
 TriGzUlFvy7B1wxn9+P5lgvKee26yP5kicGCX/OfMsEEBKBw8f6rBQOE2hYRNb9sBK2i
 fnMjuiVPZ8zyyPhX+3bwFS6uaX/J7d632MNB1XVwh0SQYEKuSjMbOm/cgzNJjhJYdAEi
 oWeAi2OI0+QSe4uebb6w6VON64NZqBK0YmJzmJFys/OzylvXUlcZtGYG6pZJmzkrfjyo kQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1dcbqs0a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Feb 2024 17:17:23 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 419Ga2eA038406;
	Fri, 9 Feb 2024 17:17:23 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bxcdwuu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Feb 2024 17:17:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nhjf7ExtRsrpBYts9XJRK97nmMlaLOnTjhsLiUjjzPgOc7QcyYlDBr4LlOJAtyVX2DG7AXhfIKBR+6UpZJWlfhCO8+TkQpbcqdZyXhjtpIU2BCQYZGiOtMhoNRK6UB3DHnuOiDzqAk8XC9rb2MGggtauUG2EPHgB2xiMhv/SKVVfgf3008JXT0BayS8ZxIMMOhCbGEOzkBKG+5SY5JFvKsT3vat7bi8Nlss+9oxhPrPPDp3XKLqSV8cBc31H0PAnFlIaOlKjBvj6DMrkCTJjkFqz735+mR+GjSCQFW5/+rc3mRFp6/ffb3hq/j7DXTpEIyrLoIMFu2TQuiv1V19f/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mo456TaxBxdIckvbg/DIVjF6qc9a45xu8uNAvhcVhug=;
 b=AYZ4LZAt39AvgUaa/qy+pKyQnrlqNUUSZN9IPVadG38uYLGyaoTYyPcwoB2aAuKXoYwshVix0+sZwVfDrsTm1j6pFeWBRsD2SpBDs2Ui8FvpBbdGA6gu2rrnzz9ywvlWSqKy8hMopDrIZv7Bpoon5dZFQEj7QKgg8T/niu7U1SDHZ75jgnYksOFqQVNXdn13dVdtCO7ocq7detwTCDK6IZjuUCxFLpFh822GGtDkcBc4lsP+KBKxARIFZTtLYdeuwDcqTMRVfNsnyd2RQYydVOkfu2rHbbwWUJ3Aj1XOucyxKvGNfaBTtooW3gIfyxiFTdLLnd2ZCwOdVqbeX6tmvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mo456TaxBxdIckvbg/DIVjF6qc9a45xu8uNAvhcVhug=;
 b=O3sMTjUiLuiHqDm5WIeVmjlHaTCfsrR6/20+HqmjR0d1LUVXVRMJQTCRKvWCquy93aTeQTWNGEGpwVFbTRGgg1xcZJhyaMcflgVuinqa1boaKEkq3x3MgyfeNpqpiDkeUfyp2MryBy+J9G5PTIdHKQr7y+wf2u1PGl5A4peAtqA=
Received: from SA1PR10MB5711.namprd10.prod.outlook.com (2603:10b6:806:23e::20)
 by SA1PR10MB6320.namprd10.prod.outlook.com (2603:10b6:806:253::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.39; Fri, 9 Feb
 2024 17:17:20 +0000
Received: from SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::16e6:c4e2:745:a0ec]) by SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::16e6:c4e2:745:a0ec%4]) with mapi id 15.20.7249.035; Fri, 9 Feb 2024
 17:17:19 +0000
Date: Fri, 9 Feb 2024 12:17:15 -0500
From: Daniel Jordan <daniel.m.jordan@oracle.com>
To: Jane Chu <jane.chu@oracle.com>
Cc: Muchun Song <muchun.song@linux.dev>, Gang Li <gang.li@linux.dev>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, ligang.bdlg@bytedance.com,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: Re: Re: [PATCH v5 7/7] hugetlb: parallelize 1G hugetlb initialization
Message-ID: <j7xb7m5cy374ngbdm23rvryq6vy6jxtewtu3abjeidhho4bly7@t3aawaeybxlk>
References: <20240126152411.1238072-1-gang.li@linux.dev>
 <20240126152411.1238072-8-gang.li@linux.dev>
 <f8c89a25-e7f2-4f3c-a99a-a1945e18e026@linux.dev>
 <277e0eed-918f-414f-b19d-219bd155ac14@linux.dev>
 <6A148F29-68B2-4365-872C-E6AB599C55F6@linux.dev>
 <3a8ae9f0-6250-4a53-bee4-4765024c8992@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a8ae9f0-6250-4a53-bee4-4765024c8992@oracle.com>
X-ClientProxiedBy: BL0PR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:208:91::13) To SA1PR10MB5711.namprd10.prod.outlook.com
 (2603:10b6:806:23e::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5711:EE_|SA1PR10MB6320:EE_
X-MS-Office365-Filtering-Correlation-Id: 895573e6-41cc-45ac-cf26-08dc2992f8d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	UDycr0W9tl1T9FKeS5dF3VO1E9Adx9SXaxumKFQ/Z723bZHiu5bM0CnArLJymlaVfpEJaS/S0I0jJweyZRahA0hNyYinyJJC32dLoHKe1qEhDKmEgjAZpXer7OSfmXX8ylJW1eZvq/69RUwGA5kNDTtSoxAjHk8YvPK7ihmGZebLH2eKU0kUu1uQ9hJhILyb0C3KEAJLbxwpyumWGVZeoGwouZbaaejH+zxPQk/uxjqTG1/JQxUBi6SnYkUW80nc+PoF8MoXS+ysKtQ+4dfrnfOsWJAvNoBWYE2RTry57L1WNSmjXU0r1Biy1Omk0gOkbaztaksDTc9W+RKzEbB8pAoE/hVj3wrx/m8t1zi4TSYYWCskrVknVJWFRqKYDYkFSqPDj/4IZE7+GBIO1W0VWMfW21mCdKKLAb2cV3MFw5A8WyWr/7ItQtq29ALE6dNGu7czHfDuP6ad2n87RJIIzSxdg/NUR5MKNZCcZGrzcM2DsYkNSi+l0pIZdrO+w7IZnkvc3PBYBUc5bOTf8+lRYQ/r5sqOqP9q76fhqgl8SR8IsVS8/XKl+qwpfd1gHtIy
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5711.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(39860400002)(376002)(346002)(366004)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(6486002)(478600001)(53546011)(6512007)(41300700001)(33716001)(8676002)(8936002)(4326008)(6862004)(66476007)(7416002)(5660300002)(2906002)(66946007)(54906003)(66556008)(6666004)(6506007)(9686003)(6636002)(316002)(83380400001)(26005)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Ps3+XG4C+DyXCno2dSUbv70jzAidGwd1bu5kaLrGfZqOD+BAnV0/kVdoQ4Vl?=
 =?us-ascii?Q?ely/yLYcTA6GKrmsec1t0AzUX3/3mgblj8RbftSZFr4tCAfiZsorjJ4jzULU?=
 =?us-ascii?Q?Y64BoUjI1LvouwJ1hZECMbD3dCHIPfvPT3i6UqO+GF/h+d07DGsvKYycaq3V?=
 =?us-ascii?Q?GidN8QWp3cXQObRqImkV8cxgtRxvD7rBYcMWE1eEACE8zGCyWbU/MOxyJyB1?=
 =?us-ascii?Q?nanzkIQHmCmSFzvFbUXHup2MqW66/Ia2xitJrq1/f5plsKW6mvgv6SW8wJCk?=
 =?us-ascii?Q?JNrRSdQ8Z1z9o0A6bIgMqUdoeLmEcdpTs17fMUB6UOtUpuFIw0PuhrML+MkN?=
 =?us-ascii?Q?FK89K+kU8TUhzFlvv87EmFexUApRPzKocvd3w2SVPDzA3AH8y6SbFmLVEdBq?=
 =?us-ascii?Q?cJDIW2zvgVxrvCP2r9DyStZEszIBc4giPtHuEjJ/OZo9y/ulN7x9Bq/Q/RfS?=
 =?us-ascii?Q?SZXdwSMwxaiZ/1sTXA4kI5aG/hzLxCodcY89tsu9arIzulSvHFbfqRiWNll2?=
 =?us-ascii?Q?VmM2QmjNA5MwjI1H9VLuNl5PbRo+VPECQqd460EcYCIglLNwSQQlLtdvqH3m?=
 =?us-ascii?Q?Qjt3+qMr95N0AgwZCUFQ+TafkGvTqkV65IuXnwpFerjVABSUpPnBHKdSZZi6?=
 =?us-ascii?Q?7BuY/VN+KawzF+uiEh3myL98tKX3xW/mIeLSnk5PVzGP8aKP2DFWhyNBFy2W?=
 =?us-ascii?Q?NrfYTnAgbLQC6B2u8aoLWXMAf9lr5x5BZXwI16g3MkpVrM/SjGCdcRSpgKPN?=
 =?us-ascii?Q?iNNfz6R+SQ3ChXgSUhJlSpOHA9bg/yjqCmP+5i1RnbXYNCYEensMgi90vPN/?=
 =?us-ascii?Q?fxx0ufLfD6UiDoLDdE/XoUcxziOXvwJUQzVqMJz7SNxxwWqMUGD8RRWU6vGP?=
 =?us-ascii?Q?atALHyTnMWUPJCj8oMg+oEu7S3L856900cT0CK1kPzIqxeyVY4jdVjXhvztx?=
 =?us-ascii?Q?T8vSDpZzgHiiEpPMDHQZNpwiDf7wjcUhNTNUJSxpwhdGAz6oe2O9QSXwafIQ?=
 =?us-ascii?Q?Nbzdkl70C9vSqtkehiYE1ywoBGKinp05PAIcBK0rtjWOgqXW9b/7eKOuAPyI?=
 =?us-ascii?Q?sn9FTtmPq+oRgMWAek0Putg/3Q67AaZSvI3ycWgDwpiRTagULG2hhSqfY6tp?=
 =?us-ascii?Q?YWUA/MFZtO0anSFRUafGAwwpxgXQG9PrN+7aMCkG3bkiKyNdj0X2E5Kl41r/?=
 =?us-ascii?Q?YX2upPt1c+BRbH6kfNwfL2YrR1F0+hdGRWEXwM6wJjcfIyN5d+czVupAfnQI?=
 =?us-ascii?Q?Wx5a2USAnaePlC1S/hxBYBuLGCoalPD6hLuCdiApHOb4hSQc5zo/ZZ5Xh+Bc?=
 =?us-ascii?Q?cNPobvs+GufNOkNifM9e3grYvJkdElnnOdK4rYGDW29G8MgwKqfaoYfn+FQ+?=
 =?us-ascii?Q?cgxsJ2zHFyM7ZUn/a/BqKP9nl6RzJpJtUtD/cIo/WDIcGUmbepiZpZdRXZlm?=
 =?us-ascii?Q?5DZDErkJKkBF3oBwXHuNpAKtnZS1vRgk5C28mPNYDPACOPFcCauInOSPsXP4?=
 =?us-ascii?Q?LNwSJtm6ollVcjz3OYxbByDt1T7bhAQF4tU12Vhqm9M2wybW5lhH21p5WaIO?=
 =?us-ascii?Q?Kl4AwMxPuUoKbmJBmKCyvEvNqYi4yUrPrjmPH9q0KSXieq+morbrLIDd6jce?=
 =?us-ascii?Q?Gw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	4+DoAk1iR8FFLV2jRbuB3Icty+Y1FC8SJIeC21HaN6t8at0F3uRSKiquaBZK/DJA+5lgHQUvzE+lnO2U+Bzu9rr5MxBvDvG/Rxy2uIBpS6CZtJg/X1oFrW6eEcUvD49uMRihANI1s978eOijhj7XjcJ6YX8MmCSAX6zpO+YN9Dqc6tXAb/+veCjM3uUE9R+vYqTJl+UxemAd/AHNtbKsm8p97MWSZhW62lvA9+tkOcdVRPtE21/pyERKEvj0kHkHjvh+P2HMxc3j6Vg6pAbxl8DGuFR3PgWvM5hkhB1Uxf3w9DWyxo1en/oQ3HP+7+rLV2UZjE5ijd6sKl8UN+2whHLHQOTmQW0opUugKvUEntUBggZ2ezUxYuE3selkiq1Flex3KEs+uIUOzFPdUs3CAgMIyV/Vd6K7pIbrpus4FRTKb4rmSzYvca3lJHtntyr/NR0uZ3biUjtm7sYlTuolkXNbMSb2Jhd51vCXO8pWzhrHqlkf62UAh5ykxpWcE6GL26oMuXURMqR0OeXGmVDaR5Ryw6fs0/51HE8ogw4m/UIV81Z7yCtP5ADNHQD899qMD4MzhfyRjaX2TsAjhkP7tsF33HY2BdGBl6PL6UN7GBA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 895573e6-41cc-45ac-cf26-08dc2992f8d0
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5711.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 17:17:19.8753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W5IdPoPrHpfhQrLAYQV/HNdmdpmblL2s+wk43XJpkMvqudxBZZpce3LfmFeRaW4e1/bQY9VaE6oZiMyMi7NIQZAhyQoAqECYF/NDwvLppxA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6320
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-09_14,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402090124
X-Proofpoint-GUID: VF4kpZCHgumZSQMiVzdDo68nxR0Cqjp5
X-Proofpoint-ORIG-GUID: VF4kpZCHgumZSQMiVzdDo68nxR0Cqjp5

On Tue, Feb 06, 2024 at 05:53:04PM -0800, Jane Chu wrote:
> Add Daniel Jordan.

Thanks, Jane.

I'm adding Steffen too, and please cc padata maintainers on future
patches.  MAINTAINERS has linux-crypto too under padata, but for changes
to just padata_do_multithreaded that's probably not necessary.

> On 2/5/2024 1:09 AM, Muchun Song wrote:
> > > On Feb 5, 2024, at 16:26, Gang Li <gang.li@linux.dev> wrote:
> > > On 2024/2/5 15:28, Muchun Song wrote:
> > > > On 2024/1/26 23:24, Gang Li wrote:
> > > > > -static void __init gather_bootmem_prealloc(void)
> > > > > +static void __init gather_bootmem_prealloc_node(unsigned long start, unsigned long end, void *arg)
> > > > > +
> > > > >    {
> > > > > +    int nid = start;
> > > > Sorry for so late to notice an issue here. I have seen a comment from
> > > > PADATA, whcih says:
> > > >      @max_threads: Max threads to use for the job, actual number may be less
> > > >                    depending on task size and minimum chunk size.
> > > > PADATA will not guarantee gather_bootmem_prealloc_node() will be called
> > > > ->max_threads times (You have initialized it to the number of NUMA nodes in
> > > > gather_bootmem_prealloc). Therefore, we should add a loop here to initialize
> > > > multiple nodes, namely (@end - @start) here. Otherwise, we will miss
> > > > initializing some nodes.
> > > > Thanks.
> > > > 
> > > In padata_do_multithreaded:
> > > 
> > > ```
> > > /* Ensure at least one thread when size < min_chunk. */
> > > nworks = max(job->size / max(job->min_chunk, job->align), 1ul);
> > > nworks = min(nworks, job->max_threads);
> > > 
> > > ps.nworks      = padata_work_alloc_mt(nworks, &ps, &works);
> > > ```
> > > 
> > > So we have works <= max_threads, but >= size/min_chunk.
> > Given a 4-node system, the current implementation will schedule
> > 4 threads to call gather_bootmem_prealloc() respectively, and
> > there is no problems here. But what if PADATA schedules 2
> > threads and each thread aims to handle 2 nodes? I think
> > it is possible for PADATA in the future, because it does not
> > break any semantics exposed to users. The comment about @min_chunk:
> > 
> > 	The minimum chunk size in job-specific units. This
> > 	allows the client to communicate the minimum amount
> > 	of work that's appropriate for one worker thread to
> > 	do at once.
> > 
> > It only defines the minimum chunk size but not maximum size,
> > so it is possible to let each ->thread_fn handle multiple
> > minimum chunk size. Right? Therefore, I am not concerned

Right.  The core issue is that gather_bootmem_prealloc_node() doesn't
look at @end, but padata expects that each call of the thread function
covers the start/end range that's passed.  I understand that this
happens to work today with how padata calculates nworks, but it seems
better to honor the expectation, so I agree with Muchun's suggestion a
few messages ago to loop over the range.


I hope to look at the rest of the series and that standalone Kconfig
patch after about a week, there isn't time before that.

