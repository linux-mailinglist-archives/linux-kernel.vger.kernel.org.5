Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E2478B738
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 20:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbjH1S0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 14:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbjH1S0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 14:26:12 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA8813D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 11:26:08 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37SHxAsK020137;
        Mon, 28 Aug 2023 18:25:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=RW85S7wTLvXVWWKIpquu28OC6mMCOSuKnqoeH/1FPJg=;
 b=mnFIBs5DoLjopQCEnv/oQKBUIZmeB8cBiI6TVEZkVQ6bLUAY4peX5lIwzh/+iTcicjOb
 RPJW1rBmZ+VkN8xwFVurrJMXzJSAyc6Kh1iasl78dxBTpWU8nqE1ON6VSZs7KxUEHxKC
 uqLQsKFtkEl2zN2KLz+5hZPeyMj2F2I3jBnCj80TsjGhflgKQ4uIvMeWLrsCdFhUPV16
 VeJNOZgs5f46J10uQLmNKyXHCyhqefvTZPMOBBdYYqphO4hz8gW/Y6IFK5IlVGCEHMXb
 UkAxteRr5ppHnxz6xSsxamuDwWPqUBtFj6qnV5zR/H2YUITE0kSQ7CBuUheay72Kmx6A GQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9gcka6s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Aug 2023 18:25:43 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37SHxqAO020087;
        Mon, 28 Aug 2023 18:25:42 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sr6dm2a31-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Aug 2023 18:25:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KHw9s5WFLIWu4YNKjabudh47Q8TyA0ipNm2lWqaY4+J13kbUm1wyIVluxwC5+XxKgAls/1bwQE27U2Hdf3CxwuimFOn3mOrq1KEnNi/nwoiFbuJxgU0rOWSoM1CRjZJqbOSr5ZeBghMRB3ZvThPj16yER9gQTQ361Uey6ThP9vxt3u6/kHGp1FoCRDG1qTdSVWuHECmO8udfRwNJ5wlh7rP4uH6H4l7vL5tpQ4tJsjctthnAPVWlmqDW11CaQAeQ5zQ5TmSvlfbKBqZ9ScBF7dFYw1snsH5xnTNnqT/Z66EntY4g9oZU3+QKpwepuRBRNrGLtk66RyaHg1sJ4AJdYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RW85S7wTLvXVWWKIpquu28OC6mMCOSuKnqoeH/1FPJg=;
 b=UcUZxwvNX7Zj3X1kNR6pTxkw7JsyYn1Jl6CQyMBvXbUR9j4bF4QrrSmoAgSNRl7qjSM90sHqwGivNlVFraL4H992AUYOQjcDNy4xB8kByexgy6uHUEsbHSwACL2RtgAwtqS3dczymvQ1EHOf3X5zTCOLCjqAjU0P+KgK+LqteJ3imhictRUh6Gdb6wluaBPfn5gtTLxPObGMUfoK8qe8BF/MjbijEtD7FL/F8nCdsON1JIgbTMGGGhgUx/fszqIZUMaiq8HyGCC35vUok0C98faZxhXsK3PmpD+R8JogxWBCmoVzVCVotWiRBQDZOH2cMLeyx3C9De4FneXq+IyrxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RW85S7wTLvXVWWKIpquu28OC6mMCOSuKnqoeH/1FPJg=;
 b=bVKtc4Hk7HYfId6b0A3WBnQWMblDr3XKHyis0ihchpariZOs7JeSa/uNkrS3fN5lIy4obdw7uYuDIseHlC5UqHirQdexDsnAuDecFkKDWz2yNtnfEwX0V/LW7pOnpcDxo4kMPjDwg4Mv6TVrXLviRJ3DRU1uBPnCziT/93CVIcw=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SA0PR10MB6425.namprd10.prod.outlook.com (2603:10b6:806:2c0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 18:25:40 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::92ea:33e7:fb66:c937]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::92ea:33e7:fb66:c937%7]) with mapi id 15.20.6699.035; Mon, 28 Aug 2023
 18:25:39 +0000
Date:   Mon, 28 Aug 2023 11:25:35 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Muchun Song <muchun.song@linux.dev>
Cc:     Usama Arif <usama.arif@bytedance.com>,
        Linux-MM <linux-mm@kvack.org>, Mike Rapoport <rppt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        fam.zheng@bytedance.com, liangma@liangbit.com,
        punit.agrawal@bytedance.com
Subject: Re: [v3 1/4] mm: hugetlb_vmemmap: Use nid of the head page to
 reallocate it
Message-ID: <20230828182535.GB3290@monkey>
References: <20230825111836.1715308-1-usama.arif@bytedance.com>
 <20230825111836.1715308-2-usama.arif@bytedance.com>
 <4BE9BCF9-AD29-484B-BBB0-3709B77E2236@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4BE9BCF9-AD29-484B-BBB0-3709B77E2236@linux.dev>
X-ClientProxiedBy: MW4PR03CA0247.namprd03.prod.outlook.com
 (2603:10b6:303:b4::12) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SA0PR10MB6425:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b7a0cbf-499a-4219-e3d2-08dba7f42dbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cXmn9RQ2Q+8VS/3P1uB5N3cPUj8acdHkOKarwc9WwwLB2HxvI/on0DhPtePX05+iE6HF0Q1EtsoM8osOS5IR/Qr/KV7wsDBs1HpBF1aOqgMjI3/dFG66SerbbKkfMqTUy0eckewBTHCGEdiDagC211fJW2Z/h7EzKcEosbyypxCMTI1mmJn9tY+RkXLe/n+1NO54ikzsiK0UlgRv4Z4Qv4fRthJpWIfkqzpWZyEk4lnPgdJlxbMbd5FKkqLA6xlvS3aw60UctGNm+w1/RnBojkMnqGDbjWQUbCA+HueGCHpr94dlPAmNXcjzGQlRHZRqH1XrEjuJNkn/8xZ4adkWf3g1nrKi6l3u4LwEn1rWqZ4CS36/Skj6Mp073HbOX+/p5xLkjbbv6gzWMb2/dUmthZSjDHaWWZ7IENzZQR5YG1XH4byaju7/VvjHncEr9SUunRNEMijKiGW+ZFFxRcvDYubk2fr8B+YTOdRmO5pltlYEGbwr68dlXyjoJhw9QGQnmcFgrdaLy2fCCLpm/t/Ro5wTKH87WIn3LkpBtNCsL/crK89E3rZgGid7ls9EgTC+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(346002)(366004)(396003)(39860400002)(376002)(186009)(1800799009)(451199024)(41300700001)(26005)(38100700002)(33716001)(86362001)(6666004)(478600001)(1076003)(6512007)(9686003)(6486002)(6506007)(53546011)(4744005)(54906003)(2906002)(6916009)(316002)(66476007)(33656002)(66556008)(66946007)(5660300002)(8676002)(4326008)(8936002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WUdIJFQFUuwvELAUk16Zhb055osV80dD0xkwvQp+4EPH79Ai1owmcqXIuC4m?=
 =?us-ascii?Q?rNVxUoksCmI3cJdUV9lYQMsSoOObOO/PeZeRSEWsUy0woGhfmTwfLaMQS0kk?=
 =?us-ascii?Q?xA254smrZ6QEVAHWQSnKvAgNlZkJB+3OJKQYQiBMbhpOwPHnaZ8JaQ6hdZZv?=
 =?us-ascii?Q?eoUnHDykqFnSJC9oRu7WbR4J6itj3uvlKoMjqg88JVTVz3S4uYR9F6NLzGaR?=
 =?us-ascii?Q?C2f+vK0fTndDHprmn9rG37AX17rnieeKK6mzGy+Awt7gFODCK9n8mKAHKHsp?=
 =?us-ascii?Q?u9paju+673LUrxCvyCFXiQDtZHqeugKeZK/qAG87BD7NH4m9k4v7k1WlnCZU?=
 =?us-ascii?Q?AnQtsNrTOjd+TViFX7uDbln/m2lstxRYEdw9h2Ep06uVVpvRWKMFD5MOVRhw?=
 =?us-ascii?Q?xvYembaaym2nWHFccswr3l4ofYoZQgxFDuGPVf61XBHoYF1bmExh0APeAqBP?=
 =?us-ascii?Q?Y9hGLA9MiIElheMmH1/4Q8v9eGRKXcO2HvvLOBCWZH9mlCa8iKkMe8r4AZDk?=
 =?us-ascii?Q?hibBkCm0JJCup9F2fEb2hY+uY9qamWDWx5ZJpwnUCvFHilw2zzUGg9DOMvch?=
 =?us-ascii?Q?TVsVsuby0aVrEHEVTBSkDmhWrUys1UvrmAKUZ+iWDFPiwFMb8hlDyrMYxSkX?=
 =?us-ascii?Q?zrCtgpcAnIRPbb1X+6jcB9hC/liyfSSYMW6tm+WchP3WFwlZetSuX0dlTU3I?=
 =?us-ascii?Q?FEak27017v6gjpIm46n5h72JT7wHKNAfYn4veuZ9GWDYGDPszmNcHnJBgDXb?=
 =?us-ascii?Q?fBNrKMzj0lYHS+yExtz5yUQOk7rLD0EWQBHsGjPIBbgST3gKNQPpg0tn4Y3R?=
 =?us-ascii?Q?z/EDGxKW8Exh1qlzPjHdUT55uTyJmj89yjJb/Ww96Frer57IHnKx8gxStmRw?=
 =?us-ascii?Q?1LinWLQRuoTpeUj/Dvr8GJ6OEgKwGAZDEz3wNqLKLQp3mHuqidbXaMNv/tVs?=
 =?us-ascii?Q?kWH2rdvTus/xQ7dAFUu5OhrsZMbP9XjXCwsHzcy4mocogQONhpKF/94Jo5VM?=
 =?us-ascii?Q?24FnA4VQwQeSUlIsvzq3+ghO1G+4h3x6dTmL2O7DUdEsa1GvGOjxfNzcWj9y?=
 =?us-ascii?Q?Wjq2+SqxeApdSMP/UQGntptCkoBHSXgVGA/QvDlPtqEkiyAw5lwCRhAeSGJU?=
 =?us-ascii?Q?1I29B8+WktOIV/fuKNkgR/DfAfyGYYWH4WAQAJWP9UPkckvQKA2d+FK4PM1r?=
 =?us-ascii?Q?UNuhijus85cxXCFbSPL1qqe5TVAdIE55bUA4NS/0Vy8g7RWHSnngZwmXGPhe?=
 =?us-ascii?Q?T9GkDFf1pnAlwfVCZ7nH03Fchz3Dw81y5vH4w8A8Sk8p0UCb8cwvS/sEDpBy?=
 =?us-ascii?Q?KpBI2h6NfXJcH/9qEGjbEPgVkZVSZgYYQrUUAk1opl14l5CO6/MoPeHicVHs?=
 =?us-ascii?Q?oIKhG2YMZDZNiI4sRcqfG9E8gLK55PaNhy5Kvg7nxBNVgp6WKI4K/I/nrPyA?=
 =?us-ascii?Q?7bIeHkWn5UjFHAMk0uZeKCx/e57S2zkelgYssFWa/uMAx6x8MztuStHLhAET?=
 =?us-ascii?Q?coyV4a5lvnFq+YL0PFciQt+HV5EUusEdZWjxA9rnTrWyUC8a13C3ZezV0+mJ?=
 =?us-ascii?Q?LHItYRMNhgdVJISbTJLAUVe2JCfcmzej3Q54Zm2jxDVvTJlrIyt6dNis2iWh?=
 =?us-ascii?Q?6g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1EwKZJRCv6eFl1IX7u9jAU9SXuQ/VkaxARqHAQAFzVXqW7SuxC5s377sAxxISoU6VMb+ytn5EgJ1vS5nazOd1wv1XDGFY5sGQqBmvXAu/6vDLRngiYLHdOfjG9/XQR7PAlPmSqmY6tWnAP8cUY4kGzZ4Kw1zjAmpwk2zwzPprjQIe2m8524JP4L7G1apmg59/e8ky3yFqsBMEJvNzKgcnC/KdZWrMyLezD2udi9OFFz9FLPx3E9b+WP1UYx/VyIguq8YW7EHFdXX3vGIuDwXpwNX+SHkniekjKJKwLJImMmTD4IYkPmBAwuB4mfbC05MZI+UkTkOrmpn7bsh5fifnZ3oOUPnTUnm8XzarcwCyrQhuc+O8n/hahxUk/jqMwXwVs7BeGY+uTlBx38Q+L2U0DXvDF7D6KCsX8P7F8qtyY7/maPhOFRAj/5CLfrB88bgpxWnQcV3PVBJM8xXAzuw8u4zuRbYZZBWJ0ul7LbbIMmkjSU7YMm14HKm60PtW9iEDlvIA1AtOOjB8ltQwBaaYdy2QoX5Llvfugkla24rQkT6ZC9cBYRLmLIO85BEeH31aBjbMGQKV4gGH7Lg1Qf68OF2IXRbbSbv1TDRLxPBsGu/eMHwvD2pFBCOdJBK+tqy/06gcNfFcFT6XkyLBKAjJOnzRO4VwnwyhSD6pOVaxMtAPCR6S5qcFjuoOzMSmnDpbzR9dM+VHmn+ydgGrVs8jh/s83W6pXwy1QISGW5aaKisDdRegHFg7eraXKdI6qD6F1NruHqvlRbkzUTye/jFJX1tdd8ga0nUVb4EYXoIMpOhBcGkbBWvu5DrtmwrczISkEryy7E/p/Q2b9IfRE0ChgHFq5ZtHRcIb1GT93dS6FVAEF2CDUYwwJ4/uol9NVhAJWtHwUxldRsX6d8kIeHt0Y/y7T2HnUkXavWwDtyNpU4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b7a0cbf-499a-4219-e3d2-08dba7f42dbe
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 18:25:39.8900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ml3KZ3o96kJ8yW83CuHoCX0PrnliQ5RCBSYxOhN8X/Z69DfbgBI/8Gi2ui2q3ocOU037SI4wVkhvx1/9eVlR5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR10MB6425
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_15,2023-08-28_04,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=936 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308280161
X-Proofpoint-ORIG-GUID: BPhYPRreuV-tR8S5Z43nQWZH-ZccIFKD
X-Proofpoint-GUID: BPhYPRreuV-tR8S5Z43nQWZH-ZccIFKD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/28/23 15:15, Muchun Song wrote:
> 
> 
> > On Aug 25, 2023, at 19:18, Usama Arif <usama.arif@bytedance.com> wrote:
> > 
> > If tail page prep and initialization is skipped, then the "start"
> > page will not contain the correct nid. Use the nid from first
> > vmemap page.
> > 
> > Signed-off-by: Usama Arif <usama.arif@bytedance.com>
> 
> Make sense even if without your optimization. Because the nid is
> used for allocation for "reuse" page, it really should be extracted
> from "reuse" page instead of "start" page.
> 
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Agree that using reuse is better than start here.  However, IIUC there is no
way start and reuse could be on different nodes today.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
