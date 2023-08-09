Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFA6776C6A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 00:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbjHIWqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 18:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233350AbjHIWqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 18:46:12 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C00D2
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 15:46:11 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 379IiYoF022735;
        Wed, 9 Aug 2023 22:44:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=RDOQabH5TU1VOXhXMFtqadhgKdiIBbAUlkyutpuPWIA=;
 b=t1SfHZ6QOkpN1itfy4X31KvjTviQ57ClidBEQWMmMvf6GzMSF5Gok2g1ON2h66tmD1nY
 rvvKZ7rXZmA3UvmWBXnmKvFRC2mUhBbpaNU8wU25LDSQ44Ast07E0gKC67LDyCNamzZX
 stDHCWUbexHxfdR+ILtXZ501PT+BlKRhGhDeLrtLcMZbmnH/CRvtV1XHCrYWzW9j0f+T
 Nby+KrEL1sS2paEAH6fOPlBlFRtJYa7P/G7efYsn9YL7egRx4dvHfQ/A/jwceh/8DinS
 BmA/BfvM34lWlLCPli1j4naHNOlG1gtu8bqRiNj0/Olfd2kUIkC2mGejcWPD4j3gU6g0 Pg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s9d73hxp6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Aug 2023 22:44:31 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 379LMXe8007770;
        Wed, 9 Aug 2023 22:44:30 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cv7nrum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Aug 2023 22:44:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ArxygroxWwmgILG8JymraZJ2GpFkyMEyD7f1m0cIA8aQBQwC+8mKpuo8VFmTFk2tmeEJ2gqho26dwVSiSLp7rGYPM0Ke/t7WZLE0GGg7SU/fwVmdUtYpwGAb2COLPZo/C6VezGsLFfLQ5aHK4HM0YsAO57z8iVHdOfPu5mPbJognuuJSw5EZ9Px741axBNtqTsAyod9Vc4Df37B4u0eV+PW6oEciXORwHIY9XGuu4wd+wMs2GDYCfhDHhuMbUpy/DT5PjRoBCQotS22XDKpfr4PIR8l5xnvt1/1T7CoriUuEVJ6Nqd0PWGROiZHLS0yxgz81gegsyGu28LFxo+nj4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDOQabH5TU1VOXhXMFtqadhgKdiIBbAUlkyutpuPWIA=;
 b=S+u9vGsUcQ40tmAETNodV4NwvKMt1h4AirSQWc2iQmtNmRBGq865ki79IKOT3l+jHrldVH5LYXuURlSVQdS8/SU7X/jYzjJz+OWV0rSqn86j1yR+Bz4gc0H7gpOZGig5zhuQv/cwAhqMSk19AEN1cIq4vgnTmLTVmZvKjaFdi7/FoZC1kJiSOj13ReO3Rcm8MuGLk3wB0f9C/PHD/kVSgr7SnZOUC9SlK5QUjmGLHK16le6TFHQWFTu6zNFjoeBmfQE0sZWYl2p54i4SjPmplZ49gXQ8UUWEdWYiKheEgpiD8lm+v3Cwb9Z0g00dMUQ8UDCJbz6AR7FxzikCeip9dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDOQabH5TU1VOXhXMFtqadhgKdiIBbAUlkyutpuPWIA=;
 b=fF3VnZ5W/csC7wN+glQlqfDOqYn9sI3ul0BlvycNIFIHMj/4QG4Hzh/wBDjpcvRGXoR4XPm7SMIYXowjUW5fpUoA6ls68oI3+a+wRtUSPRdBGD0EqnY+UZ5PZi4CmY0viVmNqUM6RLyXjcf15vz28ovcsr+oymER5OVSb1t2Umc=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BN0PR10MB5096.namprd10.prod.outlook.com (2603:10b6:408:117::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Wed, 9 Aug
 2023 22:44:27 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::92ea:33e7:fb66:c937]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::92ea:33e7:fb66:c937%7]) with mapi id 15.20.6652.029; Wed, 9 Aug 2023
 22:44:27 +0000
Date:   Wed, 9 Aug 2023 15:44:24 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Zi Yan <ziy@nvidia.com>, Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Huang Ying <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 1/4] mm: migrate: use a folio in add_page_for_migration()
Message-ID: <20230809224424.GB3537@monkey>
References: <ZMpKYfNWA/jNgEuL@casper.infradead.org>
 <001ee9b0-ea25-a896-e3ae-9a9b05a46546@huawei.com>
 <ZMud3RreEpsvFKuA@casper.infradead.org>
 <fb2a22cf-14ae-3594-f5f3-8680c2100d70@huawei.com>
 <F2621E68-F36E-493C-8619-ADFE05050823@nvidia.com>
 <d184ba78-97d1-a264-fc31-87dfdbe6fdff@huawei.com>
 <de0100e4-d673-428b-8d50-11ae2b7a9641@huawei.com>
 <5BBFF5D3-3416-4C0E-9FDD-655661657D67@nvidia.com>
 <a34778cb-61dd-4853-9961-afd7568cd0f7@huawei.com>
 <20230809205316.GA3537@monkey>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809205316.GA3537@monkey>
X-ClientProxiedBy: MW3PR06CA0014.namprd06.prod.outlook.com
 (2603:10b6:303:2a::19) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|BN0PR10MB5096:EE_
X-MS-Office365-Filtering-Correlation-Id: dbcfa77f-b540-47e0-c3b8-08db992a2f91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YqPIpjtQefwOkm92AV0nErhMMa0a+J/aqZTYYRQ6Vlw/YfvISNGyxTiz9EjxbGZ8bE8+OAsvW74bLFbs84hxBCO3eb9SKXml8AdzJO/z7P7HQqu2doUQLEh0/xkueg8y0Gvdtsq2hUrhhOxMjLNLymVvpMuOTRTqRN4sCx8gN8rGa5kvmGsQDlHdn92ft12923RE2eCgydpJUWAHbOwSesVMZ9433Bie0FeLQVkNzTJzeTZiw03PEuvmIyhh5FYPFAuNiiO2MB/hTY8DMHGGohtxUAlhYehlqm7sXu8OkG7pmVzb9myieQP68iKRfxYkfsNLJhDWMRj+JJOsQU7YVajjw3KZJLeCE+0sZILC6mu/ASv2rkyYBRdv09yGhLwGLEgYkl5xdbrQvBR9u6anY0jJYNgpowDs+LAIl3CDhu5lOqhrRbxy0NbMfJo53x7fpC4xmOp73mn1TyHR2N+LoGdxUjqHsO/0Sjhqo31SvCMnk5eGnTyiLCcy7d52NUmtPn89TBfXsw3HLc6aycjaaNezuSRZdR5U9iTQi5kEwJXB958Tx5f2ZIKfl1nKquBg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(39860400002)(366004)(136003)(376002)(396003)(1800799006)(186006)(451199021)(478600001)(6486002)(6666004)(6506007)(53546011)(26005)(1076003)(38100700002)(54906003)(66556008)(66476007)(66946007)(83380400001)(9686003)(6512007)(4326008)(6916009)(44832011)(316002)(8936002)(8676002)(5660300002)(41300700001)(2906002)(86362001)(33656002)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z6sh/YgxrQwOwCgzggju/R3WJNNQWLQ0MtmN1G1T1gSdEwwjLqiH5x/wgwPE?=
 =?us-ascii?Q?APH8BBJAW0mzBEBVrV8DdVFG46Ycjv0NIYEVOUW9hxLHOp/WIPwmBx403rxM?=
 =?us-ascii?Q?nAGLDDRuM+6+fV9UdR+kMtb34Ln2lVqyR8O18F2H2z+eMOQZHX6zf9AUeutn?=
 =?us-ascii?Q?SVMRhfGrPkoIGMBQCvH6q4lzGhYA0S5Qpx/HlbmT+qxNE1pMpUkCDSgZO/jU?=
 =?us-ascii?Q?NWC6VCZFtEjWE1Pt5/WtTXESXBN+/0lxwGCF9QdBCMCZGmDBBTJSCVfRljHq?=
 =?us-ascii?Q?ZdJtDT3bsJ0aHcpegJRwEmpxrLDBdWiLKGu85Iy3R+iV+wsWVd+bqxNMKySm?=
 =?us-ascii?Q?LcL6pSyYfOsmP+qlSTLytWfblpBHyggiiGyFt6IexE4EOSA0qqyV6ABhdHRD?=
 =?us-ascii?Q?Navp3httDpBlVipu67ClBIlnQcq05T0ZfoHhz3r3kiWScCe/A+8WiidTiN5Z?=
 =?us-ascii?Q?g//KXYO0EgiYVdJYYnuA0N1wcSIoH8dPYbJyB8EDplVzq324eE82/oXvuS6g?=
 =?us-ascii?Q?oHcF7Xku0OGlFTwWiQveh8SZMK7pOFeiUGooLda/d4bRbWEzSn0gSAMPfaxb?=
 =?us-ascii?Q?fyJ0tHwdpIhJGlheDwSIP9/rIZqpP3lcAUI5xQ4dYwdC2ypf8rwUTMoF9BeM?=
 =?us-ascii?Q?b3cXevBGrE+Csj32nvhb/1jHRaDhJIFK+Fmc+uY5tl+K+CZ77BrwtbYiamBJ?=
 =?us-ascii?Q?S5zHLfeFH7v0n6Hu3kwjsTVl6zS8yDRiwHT2oUjUhhuxbKMxpEp6382s17iG?=
 =?us-ascii?Q?GaKSgKRSSABp53CYbONXvUfx4eCUrxYjCWVZxtgSTiF4sayZooBQ3WKzuNFO?=
 =?us-ascii?Q?GJR2x3B4KyFbKrO32YRJLOZuRQm7ItoDc/J1xYG1Fvqp6QwF6O0lk2FFobvO?=
 =?us-ascii?Q?Vw1SqmhkGm+7rv0A6RkkU9f45rO+GS9qVcy+1zrR8yq6rT0yvaxphxWSb62n?=
 =?us-ascii?Q?p6pRkGunIuVZaLju9AXO1Qp/2eelLSczAlxijOum4ByfHQgxxzexp8d7FnJy?=
 =?us-ascii?Q?KghOFo5hlUUsS9fiUwDm/sAaJ++jvjm7kB0Jkf17HIXAf7meI/z2DFMPtDZ7?=
 =?us-ascii?Q?CyPRbgc6wuOkKjxiz85BtyLV+ikiDsniP3Wj6q/Bd39krEo1LIJu/g97O3jQ?=
 =?us-ascii?Q?du9I4orMYqwGuBSqOzAeipx+OuxEZmU5yCe9EmickCdG4k2JTtb3DoKt0URy?=
 =?us-ascii?Q?EmmUyFGV4bbc8PcwWLAYM3zyawI5YRym1a8s8RCwT+C/8sFERJF/uBhSXj3m?=
 =?us-ascii?Q?Gp2422cC22EvF/nn0Pfm3BdEtL9aAOSGu3A33tdVUBkjKvUAN7pEzUEvsjDb?=
 =?us-ascii?Q?YAq/0EYmAkbQquJKHEfakRLGUnFx4N4yHpGhNcmkM+4j+Qo23VgNy3Fue3Pg?=
 =?us-ascii?Q?XrWZ/Y9EtpDktYTlJvr2nhHfa5Czs4RsjMtZM6/0DXlwqhklXkmqEgcIgaBY?=
 =?us-ascii?Q?UK+iRdn3RM3vZ7VTEQ460KpV1a5uxJRKYcy3YUQFNIPhUuTC6y6jOTA0OKsQ?=
 =?us-ascii?Q?fAKZAipCTNnMJORWYUZpO4FRSv0DUt4psVUvtlZE33tw7+MXQ1bZeTlFLmoA?=
 =?us-ascii?Q?r9JWibz7m2QFdn5oTXx2Ebd82muw2ZrcukDDMFH6wdyG1lztpwnPBQsmXJ4q?=
 =?us-ascii?Q?7w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?OkHCWIrdWefQP5MXh1I5q4Lh3n4AlO5gMuR85rw8qiqk/akGPJvquoeTO9E4?=
 =?us-ascii?Q?1JqqgdcIx3hX/XZEBM+b+Z4Vx5NzTwz16bEHdxPhu6wcaxuCcGPCnEBH/e6N?=
 =?us-ascii?Q?l091LcQBfOrqXdXA/qTcPlWDOv/2M5xVNjLZOsb6zSQO1eP+Rpmx7K5vbqVl?=
 =?us-ascii?Q?CLLkBe3692KBTzFEWSV8hRO8OEL3y70Qe1xPLsJDyVVrqMo0ewnqNCfgKiCN?=
 =?us-ascii?Q?6PdnompPQVqXHNFVt0RH/oJheEMhaqvxgphMmpwxq/ZAb+xCAtR3qEkWBNR8?=
 =?us-ascii?Q?fe4uEYXekrClMk9PYxpbWBusyVZ4kDs5iCnUgbAz4lN8bkdpoWPNwwL9Tscv?=
 =?us-ascii?Q?A8hgCfjd2tbMezJox6t6yAOeOW2khrN8xexFnpW1rfefKVk7nJJbcypzY+yO?=
 =?us-ascii?Q?p+cTPngr0JdxiskSgRWqLnyDjR5YUkK+D5CPvOesjDYSKqiM00gYKhaTQu64?=
 =?us-ascii?Q?I+SBJTtE9OFFMW3b0OH19Hx21zWBEC7pF/tgD1LXQlamHP1ftXyoNVYys7v/?=
 =?us-ascii?Q?t0eYFHmJ1HY+PNVv/Q07tp1dlX5Oo67UL8s1RIR/fsSA5edca5RlvnMhZxGP?=
 =?us-ascii?Q?V91MlVbD0VMoycspNM2tjeadiZd72Hd1pQAtdFUPrpVPdqpWl91W02C8uzZ6?=
 =?us-ascii?Q?btc+VLwoT7RUhXwXwevkuoukByEu8w8vR8nkHMChfxJhXl9M7m8UOa+QaniJ?=
 =?us-ascii?Q?xxyUsN+RwTM+qbT2OZnuL7ngDXzXMUK3eCpIsQc7DTsdtyX6ILqYnCSvqX0f?=
 =?us-ascii?Q?v2Xr0ckUAhH1I0LSe60yIZ72rLgJ31RM6luycCXBdpgKxcC7ahH0n2XcV8dy?=
 =?us-ascii?Q?evPLhVjsuEf0omhkzoXj+jIIGFtICWhiIiyye4t8eQ8If9DpNkajJUlV17FZ?=
 =?us-ascii?Q?k0cyY7kwTGhVNwLeLzUZHE8y4Tm0NGDtkRLAtAHzqSavqC22d1ziB6iDOuuX?=
 =?us-ascii?Q?Pv5ewZj5LtHQjOAghS39ldLOQUUlSp9NbPmvse9FocGaQMcaD96vVjRnuUr2?=
 =?us-ascii?Q?K6KcF3XYO4vHJwx5YNitG5tIkg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbcfa77f-b540-47e0-c3b8-08db992a2f91
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 22:44:27.7586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q4faGfKXssc8rI4P3iipWrOxuGTl7WSyZBPF4ZQcVD3c1UmfC22VYjZOVk9UBNM98e0MEdyz0K63aHFcvNbRmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5096
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-09_19,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 malwarescore=0 mlxlogscore=960 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308090196
X-Proofpoint-GUID: gwJEjY0dEWSeW67n4k-arPYKwhQXHcF0
X-Proofpoint-ORIG-GUID: gwJEjY0dEWSeW67n4k-arPYKwhQXHcF0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09/23 13:53, Mike Kravetz wrote:
> On 08/09/23 20:37, Kefeng Wang wrote:
> > > 
> > > Cc Mike to help us clarify the expected behavior of hugetlb.
> > > 
> > > Hi Mike, what is the expected behavior, if a user tries to use move_pages()
> > > to migrate a non head page of a hugetlb page?
> > 
> > Could you give some advise, thanks
> > 
> 
> Sorry, I was away for a while.
> 
> It seems unfortunate that move_pages says the passed user addresses
> should be aligned to page boundaries.  However, IIUC this is not checked
> or enforced.  Otherwise, passing a hugetlb page should return the same
> error.
> 
> One thought would be that hugetlb mappings should behave the same
> non-hugetlb mappings.  If passed the address of a hugetlb tail page, align
> the address to a hugetlb boundary and migrate the page.  This changes the
> existing behavior.  However, it would be hard to imagine anyone depending
> on this.
> 
> After taking a closer look at the add_page_for_migration(), it seems to
> just ignore passed tail pages and do nothing for such passed addresses.
> Correct?  Or, am I missing something?  Perhaps that is behavior we want/
> need to preserve?

My mistake, status -EACCES is returned when passing a tail page of a
hugetlb page.

Back to the question of 'What is the expected behavior if a tail page is
passed?'.  I do not think we have defined an expected behavior.  If
anything is 'expected' I would say it is -EACCES as returned today.

BTW - hugetlb pages not migrated due to passing a tail page does not
seem to contribute to a 'Positive return value' indicating the number of
non-migrated pages.
-- 
Mike Kravetz
