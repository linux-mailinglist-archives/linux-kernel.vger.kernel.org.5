Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0CC578DEE3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236182AbjH3TRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343999AbjH3Ry2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 13:54:28 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE2B193
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 10:54:23 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37UH038D000381;
        Wed, 30 Aug 2023 17:53:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=D0LrdN0tChad4xAkcBWuKXpX+t1Gj2l95BU4G6GaT7I=;
 b=cedplXK5OWKyKIbkaNZfG4X/d40cJiDfRIcXKod3/CqLtRoE8ahT4T1pOylH/3uI2DNf
 XDqo3OrJH0fHSS9ivcT0rDJn7D0X/1Bth+ACHeeTRBLaYcZLSDHuVS4TOimwcppSrG/0
 Hwc9YupfLkXHUwMwWRNcBR5wHE0EqW7eFKfS6p0Q4H4nMTwmqPDfjzRF2NpWLK0OSGKx
 GTMVg+TST3II7XJ2P3pOPozk5a2wTTAHOkQj3/OpxcP66QYBPgnb+byXe69l7OE56mH0
 yQ26ddOhJQRp2W/KRIiBDeENwixnqvRSBSuhor10hepLYWkG5H1Bj+4ZK1CE9W/ItkZO jw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9gcqxt8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Aug 2023 17:53:30 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37UGlcRR024320;
        Wed, 30 Aug 2023 17:53:29 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sr6dpv52f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Aug 2023 17:53:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=endTbrwCQf9kjmRSSLnkNisZwak9Nhq6WPt9rA31CBebd2JwQG5EETTYs53ErcmD6oUfBqAgu/XGBqDoEEm51j+11CJBpoAi05oNgD0T7sc4/PmjYhUVyRwjILlCCyo1/OZRKBH5shQgZSt+buWKqWkSk0axj9VAAcVvV1dLkDmqgB/fmFbDbiEzkhe8rHIqsAuVpX5iyxwSFJJM6uVRGNro0i8TnhlHgFYyIIY+xRSEZmJC5RAgFBWad891mjohhfmbLmIaFR0Aw4xx5BtlUuVRgZndNZ2torIVTW/RJTtgoz6umn68Zs8tF8kKpSLEKPqHwAnwfq1CrjvHmrismg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UpOHnHZlOSeYnMZ3m8jL3k0CsQgCfjUIil7u29Hl/O4=;
 b=XZvUOCT8gs9otZNpoqAkWUtmUfl5H9W/LOwQxpd6SPEUD1L46yaPgDyMJ764/qF4zeetHuU48crwvm4YW4502f0PR2A1FgzUXP/dkaHMsnYEFiiZ6FHonZ24kGgTcg1sra5zlvDRTmA3Gtso86DxXgZh0BQSfa6Ve9DT1i/PpirgnNkyQUA2s+w6FH0t2gyPYxKB/nDxucnx3KWXUX0XLZjUazYIfS8hI40SQsP/Xc643Y7VYcpMCWK+g7EyZ51Z+NsZG4PWULLcF+4QleUoLxirIi5VfH2AVoJGXZuS25ST8MlAtrgdSNW3430Oz2547xBF+G9uHDIAsSZqCUkrwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UpOHnHZlOSeYnMZ3m8jL3k0CsQgCfjUIil7u29Hl/O4=;
 b=HNfcsXRn8kZC1PFm+A+PfOqbY2s4d8mCVQQJ8pYmSYJVS5ahJqSo9Duius79pkAeXDqwJuIvglNWJOkurI4ru7HevXojWEI9rPFLYwx4r9CXdXUtlUbuxcazBmI8nR2ikUUNeEjQSFmv9B6qjzYWihw3Y3SUEqbHAcGBfUJ4uWw=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CYYPR10MB7571.namprd10.prod.outlook.com (2603:10b6:930:cb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Wed, 30 Aug
 2023 17:53:27 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58d8:cf97:ae4b:1715]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58d8:cf97:ae4b:1715%3]) with mapi id 15.20.6745.020; Wed, 30 Aug 2023
 17:53:27 +0000
Date:   Wed, 30 Aug 2023 10:53:23 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Muchun Song <muchun.song@linux.dev>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/12] hugetlb: perform vmemmap restoration on a list of
 pages
Message-ID: <20230830175323.GA55006@monkey>
References: <20230825190436.55045-1-mike.kravetz@oracle.com>
 <20230825190436.55045-8-mike.kravetz@oracle.com>
 <c8feb986-ae60-4d21-cc09-4afe49240710@linux.dev>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c8feb986-ae60-4d21-cc09-4afe49240710@linux.dev>
X-ClientProxiedBy: MW4P222CA0023.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::28) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CYYPR10MB7571:EE_
X-MS-Office365-Filtering-Correlation-Id: 01dd6383-26fc-4f1e-81b2-08dba982032d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7LqzmJwPGt26etXAwKO/tueowhBmeoJdyd4Wlcw/FX257XDxCs7TeZNmwK4d+C6Hl5nlaLabru3UdEEET6/J3ZUUW3bLeJhhY7hZ2ilzwaAwOH9W7aam2MJehi1/JDMzfqOPEX9OefGoyfAv3twgcADvRs3RIcXK7nkiZVAPGieffG9E6knYDL9bBLIqnu84Wnu3PSYvlaun+9uNz2JYWwVPaab9Q6s/qE53/C6xR3uQTJtXlb18Xy5brEy7HnT4F7DKOLZ9Ju/bohiG1BcpRWZMi5HVi69GIGljF2fIaTCzzj4EMVv83eT9NR1QIyljqyTRaGpUg7Tr3Bvn1tNVj9IcM587iopYxcHl6HTWyEc89o5yeiTWmfKwrEbXkk4Y0HXSqg+uRiAlyJ7Mr1gPUHxCEOpAYZIXR/b+5C91UaAtdqu2fS0TOBOpmW5LKRkc5PF989m5JZN4ssyv7ZEVi8VZUcK46xy5CLXPwzkPty5COj9ZpXc0BC1fHi+bVBEtIIVUz6AYeOpkPkNr4284hoFP6icrfkm8cCqBfCp+V1mOTWGCgjpFL0NQtMBz4kKH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(39860400002)(376002)(346002)(366004)(396003)(186009)(1800799009)(451199024)(6512007)(33656002)(9686003)(53546011)(44832011)(6486002)(6506007)(316002)(5660300002)(1076003)(26005)(41300700001)(33716001)(6916009)(66946007)(54906003)(66556008)(66476007)(38100700002)(6666004)(4326008)(8936002)(8676002)(478600001)(83380400001)(86362001)(2906002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?dv9EOYgD6YfOhEbYHWIXSkQ32FbdB92CPfIg8H2v+ltQb/NUKdlQtHAHUl?=
 =?iso-8859-1?Q?fLigTYv2TvoxX7D7hNrFkCZfzgtI1ZOwO94DhH1Dm5Tseha/uZCTVDp54c?=
 =?iso-8859-1?Q?whaPprcJ8jXvDzcVHFAPVv+UmUNxd3Z+KPlZMkdnXJmhthfuU8hr5GS+fs?=
 =?iso-8859-1?Q?7IPDMdzczCNWXf1LyLpI8adDMakHr5aeQTENzYU8c4mSrsJ8gROBau1luM?=
 =?iso-8859-1?Q?0iySxDZw1PIGtbyXcmsXUAjYJmkFpcg3nzMs2+5i9bCuj3wKTHTOtgl84x?=
 =?iso-8859-1?Q?5N7anufnq0iS/0pPV5K28Hq04BSe2Qq0kIx8b8ZfSbwPitYSSYcE6Za1gy?=
 =?iso-8859-1?Q?CTtMA/hfFdVJmJS0sF9ZhO9tmkM2tQvxZqiqlV705atv8iMT0e3qSSJwyx?=
 =?iso-8859-1?Q?x6CGZ2vKrhKtE/NEhWkVe9Tvs0mhT3ykmsVSkkeFmUXGr6A2HUuMAjaoyL?=
 =?iso-8859-1?Q?BDzxze6g8mN6er4aT5f3JjMhNggsOBdGrhpGPOayDnswxvZ6TEmP+mUmIp?=
 =?iso-8859-1?Q?apLAdLhtkqFCIVZGPK5cbNYgEfhrIf4SBgEdabNtLq+t/Y5rygbyNjb0Og?=
 =?iso-8859-1?Q?1jdmvxM6cIxc5vQUvERGm6SoumQ90zNhIJZ4B8HsK4vO+yAY7dxdM1H4dg?=
 =?iso-8859-1?Q?LpWOSzZj9fT6Ka6BxccWIVzhLL7XxmqVpstIwDxaBtPt2ljjCyWS5U8JcX?=
 =?iso-8859-1?Q?FmcipsTaZzT+DCH9LTJrIVzG7tQJPaJhc+dQWhn4y1C07UyC0d4eRzzowE?=
 =?iso-8859-1?Q?edT+9M1NPFI6mhMQi6J12gjDLdwfiXROiIj53InGTl/bEqRA/NW8DEc80D?=
 =?iso-8859-1?Q?XbSJ+1lLj501Vcf+eEvWxGG/SuNJqBI4+J5PG402o4ifbRNP7Ieoxm7wgT?=
 =?iso-8859-1?Q?P5GhJZBePu9hmYhy6SktmAKa+bQHdZ9os2p3RBLy+seKQfSVirT1thpTzH?=
 =?iso-8859-1?Q?aCbuDDebzK1eFYzJBQ1eSkABNWcRXP13R5CODz5efFQCwmOUR5oHtbHeY6?=
 =?iso-8859-1?Q?lABFW72AQHIafNJXcPc9LObGa/xUsNeT174pbhDcPN7TxNty24Xb5HUTI2?=
 =?iso-8859-1?Q?TOwWjRKYehB4yneGUuNYXkvKbyD32iGJYXGPsMHuQiykX+wO8PUCHLlLbP?=
 =?iso-8859-1?Q?gWdUhUyUUwVEOC9JfK4zvUy/6Iny5WzOHzoUjHWY7jLFGbYgn8eKo7J9Mi?=
 =?iso-8859-1?Q?+9atjlDukbrziMOtouUDrbpm5GBTxAumynWK7swoo+NVz1e7LZF46XzGxk?=
 =?iso-8859-1?Q?oLc0Nsm2HhhFXtz4qH4S6YlaNJ9YzUFQcaBVc4+UNEf4ub+/V9GTWE52AW?=
 =?iso-8859-1?Q?9rvOhaNBZ3Cj/kOgVdKIVYA3venp31sKQ/3uFys/u0aTKpe4jbpQ9wRPWy?=
 =?iso-8859-1?Q?ZwaHJY9bM+Qgih6ZzZRyXM5KPQnp5fUV/EqmuX0fjTU/v+/iUiiUrKG9KS?=
 =?iso-8859-1?Q?W0AstZfTbqUpSky7hJa0rWDmZKNydNQcDyNiItoR5Zq9Ja3uqSMcDbtf7I?=
 =?iso-8859-1?Q?NWG7BflL9/Ai2r4IqY6KA2RATx9HvOF6982NQIVyzxqKGyLLG+tVTUQ/se?=
 =?iso-8859-1?Q?9yl8kV/43BCc9vextXq6pTOE8nBo2o1HF5jJXrds1OA22HAP69on9rKlsr?=
 =?iso-8859-1?Q?IfbJRFWhHz0bDLX4pOvWbLf/drjjV3PHJR?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-8859-1?Q?WCiyYF1s9mCFh2yW0WyrTq21KrLcGECZ1Vb8j8WomU2hNoMARBDM2rwbLw?=
 =?iso-8859-1?Q?TKJHVCmZP/mDBEXDnE5TN1C/u6WMeC1bJMushici+VJntuIThZ4NSMBQNE?=
 =?iso-8859-1?Q?m9n3yJh24qEj04UBw3IevcNt6O4KGcm1OSVjiXfvjJj6qjJnm3Jd4uNs9B?=
 =?iso-8859-1?Q?RM079GUcxsjY3g5ZNnt6HrnaxzXVntWNt+9YTRqLrazi6/efBATzsCNXuv?=
 =?iso-8859-1?Q?IIxKbnYaUFtJ4o7PEgHf3QFa1eZUoWEqGIGF3M5YCx+NU1t78the5VefHg?=
 =?iso-8859-1?Q?NUw07oZSkt5Jkc5odwEVYwDpL2UP1J9r50tQY+yJ/PF7R6BEVKJZzeTClu?=
 =?iso-8859-1?Q?VGt5WJ38LfUwNQXSBE4CAOfdMZlCQCfAZdsq6G+V9OXL/QNMSpw3ltYbMb?=
 =?iso-8859-1?Q?jg7NxAP2twOOITxxSzLCykDBlFF5Q+NzJtlFpYmUCdTCMOyN+9zIaI6PIw?=
 =?iso-8859-1?Q?BtGZ/Nhfn0cIq2WRFEMoFNYjw9yraNhwz8gN0bsm4dsL9Ii0b3slWXGuoz?=
 =?iso-8859-1?Q?5/57IpNEAaWSoqq/fL4V+LNKks+Sv/Q5uiwon6ytG+zs2ibX4jHNXpjI2G?=
 =?iso-8859-1?Q?vQZoFGbmBSiT1iXmf4OLFKo6FnfAIwRJdnyLjbTvYj1UiYWdjD/YMPB2Eo?=
 =?iso-8859-1?Q?gIH7tssVOilLY7Zc/Gy3rGZJPMXanqnOgTSV9l2iazIQX+ZM/cRir+CtmG?=
 =?iso-8859-1?Q?EujYSdRW3ZKhZkNSfLC3cNeaCqf+rCJ5BrJuu1U+CLBaWP5V8Fxh6/oeGw?=
 =?iso-8859-1?Q?eSQcHHRT1eDKWMK4452Qe8ab/fKfBCH7tnlkTTS/yjUcyzk7rkkkwlPSRb?=
 =?iso-8859-1?Q?MF9kYgobk/TYdQt32PB/zGZ+t7b6vqIdwtHGMqRWsunqFryfQFiMBvLHJ6?=
 =?iso-8859-1?Q?6MPn4uBPgsnOsrMaCis1T5KDQMErGts56QsZjq9+DmF/dVAXZsDrC2xnnh?=
 =?iso-8859-1?Q?J+0tbtMgsyF99aqLv2UekQKaitUhBbLJ/BQmdIX5uDnp2y34vyt1qA48fa?=
 =?iso-8859-1?Q?RNnFrbxJbVdO/VoojS2fni8H7FDa36SUcXLHYR8fu0kUk//07Jfv/zoxIe?=
 =?iso-8859-1?Q?TGJIqVsnZef9JQydqL2qMTtrHBYZ6qmc+7CrDMv637vREoP1T0fjJ5mwJQ?=
 =?iso-8859-1?Q?NNrdZuuWoAToKc2SKQyp0ijjTQE6HuRCmPTTbwqpf9xU3kmUxO?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01dd6383-26fc-4f1e-81b2-08dba982032d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 17:53:26.9663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5BinTlgT3g2shHB0Ekqu13BEsM3F/5WFEPQKjpqt4ms4dOg2Y3XLpMrjnvQ05mHS2i+3yeSuyrKjoAAE2R4g6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7571
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-30_15,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308300165
X-Proofpoint-ORIG-GUID: YpgwyuBck6T5MY2CQWbS-FgO7EekzMos
X-Proofpoint-GUID: YpgwyuBck6T5MY2CQWbS-FgO7EekzMos
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/30/23 16:33, Muchun Song wrote:
> 
> 
> On 2023/8/26 03:04, Mike Kravetz wrote:
> > When removing hugetlb pages from the pool, we first create a list
> > of removed pages and then free those pages back to low level allocators.
> > Part of the 'freeing process' is to restore vmemmap for all base pages
> > if necessary.  Pass this list of pages to a new routine
> > hugetlb_vmemmap_restore_folios() so that vmemmap restoration can be
> > performed in bulk.
> > 
> > Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> > ---
> >   mm/hugetlb.c         | 3 +++
> >   mm/hugetlb_vmemmap.c | 8 ++++++++
> >   mm/hugetlb_vmemmap.h | 6 ++++++
> >   3 files changed, 17 insertions(+)
> > 
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 3133dbd89696..1bde5e234d5c 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -1833,6 +1833,9 @@ static void update_and_free_pages_bulk(struct hstate *h, struct list_head *list)
> >   {
> >   	struct folio *folio, *t_folio;
> > +	/* First restore vmemmap for all pages on list. */
> > +	hugetlb_vmemmap_restore_folios(h, list);
> > +
> >   	list_for_each_entry_safe(folio, t_folio, list, lru) {
> >   		update_and_free_hugetlb_folio(h, folio, false);
> >   		cond_resched();
> > diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> > index 147018a504a6..d5e6b6c76dce 100644
> > --- a/mm/hugetlb_vmemmap.c
> > +++ b/mm/hugetlb_vmemmap.c
> > @@ -479,6 +479,14 @@ int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
> >   	return ret;
> >   }
> 
> Because it is a void function, I'd like to add a comment here like:
> 
>     This function only tries to restore a list of folios' vmemmap pages and
>     does not guarantee that the restoration will succeed after it returns.

Will do.  Thanks!

-- 
Mike Kravetz
