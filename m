Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844597944F7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 23:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244694AbjIFVNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 17:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbjIFVNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 17:13:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937E919AF
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 14:13:26 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 386Kt9c2009235;
        Wed, 6 Sep 2023 21:12:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=sVJDRPbEECk42jOj4O5tOOYC1Foj1vK2WjfUGqhOsrs=;
 b=BLLxmYMCXTTH8ntIegwSuhSiIyFPuM6zjNtrKnOR8IjjqewKRem0K9/Sr3zovwvq8WMT
 2PD7p1Bh4X1iVVCd2RaBXB3HKfitslMzszhjdPF1Bul8qpNFg/1nX2se9wLjixFOtqwu
 3Ux/zUyLFDrzunsLNrutz8FwAZ8cxyajYm261zeYjtV0HwZ+YZjPSqpIqK2dXyB6q31r
 FM0CPPACvNBKXgnX10hfInGJbLUkhUHHsZPz08Vdk3zRcuy1R9/F+qN8EJ2RtmqY0uz2
 pq/cqy5EwZO7P2+LR2CILUsxCITXYvy3cX0rpUubGYcwlRea9hgwRvZ/09UJI1++nJfn kQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sy0vj01a9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Sep 2023 21:12:40 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 386JEbNO007741;
        Wed, 6 Sep 2023 21:12:39 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3suug6uyb0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Sep 2023 21:12:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NduL2KDDHzlKm056ZdTKSfWLXpMT6E+CCJq8DfxOqQumaaY4UKFkkq8Sm8hoC06QaSq6J8WUNmKnQ2AMn0CsONeIPe9XQviT+KZJB3Gc+0GyFXqXegyxGyoDEPnGTRUx0/DRjM0Ce62e+0WuM34xTf7H5OY5uxIGuff6aFtRspiVfnFIkLKkV4XAIAPkp5mJdWW2kSN17IGZV2Nrfc876soNnEZTxkFkZDTv55+G3bo1vtlH+Clp44nkWidhfC5dqWfkYhRwhN6zz8WgmIP/PdxA8MP9u9de7Bh1g5yr503PCdZnk+G+T+rGwsKPDvyjtUmpS3hH+0mQpdO2AbjxAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sVJDRPbEECk42jOj4O5tOOYC1Foj1vK2WjfUGqhOsrs=;
 b=V5rkPQhKKGBGp5jaaACqf3m/+yDDYXCKuMZyl0IGKnGSkQPqUidUmkBGf7adhfMRAOghnZ+ieIRZdnNgAxabRKbfW3ObzFM/Ft62cJEEr3hGnxMDFBOKxwliuIlehHAZPGVDMD2IjukEexOvVfUt4JIDFRwBCQmozqU+eTPJha/Mnol0hUh8vUSMMhPzmZMJDyFL+usUqBEprIICDnCriYUu7IpCsKHrXbn+HFhxyYRQZfn0gdIqBofhV8w+LT6VG1IJdWw6QKr7JjgDAJdfHdNnR41OIZbifmlIWtwvxWRz4g47v8QkH1/GcGej+M+qYkWAekUovamGTXU5cs3jwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVJDRPbEECk42jOj4O5tOOYC1Foj1vK2WjfUGqhOsrs=;
 b=d+zKdSGDgwy5Pze+17z5AO7sYixy/8TdKW4r5DVRPRlctjgdL8kvUtwAZrbbCopVqeKX/D5N2KL6S4xLifqSdiRAWKreSsrbrmabX+6FMy0kvbWjWWNxgh/5GiULLNtOgdKX8W1ofKHZQWFdq9u7ZgHc0519VKYz8mA8bhYU0v4=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CYYPR10MB7570.namprd10.prod.outlook.com (2603:10b6:930:c0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 21:12:37 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%4]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 21:12:37 +0000
Date:   Wed, 6 Sep 2023 14:12:34 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Muchun Song <muchun.song@linux.dev>
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
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
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 07/11] hugetlb: perform vmemmap restoration on a list
 of pages
Message-ID: <20230906211234.GC3612@monkey>
References: <20230905214412.89152-1-mike.kravetz@oracle.com>
 <20230905214412.89152-8-mike.kravetz@oracle.com>
 <5e091211-9a32-8480-55fb-faff6a0fadef@linux.dev>
 <38E2F051-E00B-4104-A616-0EEB2729386F@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38E2F051-E00B-4104-A616-0EEB2729386F@linux.dev>
X-ClientProxiedBy: MW4PR03CA0187.namprd03.prod.outlook.com
 (2603:10b6:303:b8::12) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CYYPR10MB7570:EE_
X-MS-Office365-Filtering-Correlation-Id: e1bc906a-687a-4aa5-929f-08dbaf1dff22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TK2yDpf0tF1yp3SOGdbHybChrKPpH8HLkGHa8InERT2b7mXCPqX3EVfZ9aCBhFa+C6ZKGDHspy0D8uSy7vjAv8Wm9+DFhCHya2r2GDgskO+RGkCB0dVh4r9T9ee/NDTOG3kAYN7/WMf6DPORlEpza3B1aEPXqheucm+WcRp6dNGs2C0lojNqH4L9lJFiCsGIr6HqKPVXVa46ltB9lKDLMIkmopHNUxhJrgQ1k5R6LzFiY/zXqjwWH1/WPIlHUaEtm9/WuFva82JQEPve6eKUC45oN9hluhR4T9/OTfQ+t4LnphMG3Er07kv6DbYs6YN4SVg0ht22J3oA7FiEVaJ8Syi0roTi1ifsPhgWrZ/2ZdxUnHhR5lW6BmJ39FQIn3KvxVLNeaNvmazspmbv9vFTs/8glkDLmL/tn7vWNVstUMXE/LULaSffGkXXmyPuBWahTEPLMEqGpUBAu9wSEsfisxg2Dh1iHEvAO/61EgBo59dnsPY3EJRv+Mch3hEXN4L0kurboTM/zEHHFLJ/hJTPo5uRBvjvOAfC4Zi2S9qItaY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(376002)(136003)(396003)(366004)(39860400002)(1800799009)(186009)(451199024)(33716001)(4326008)(8676002)(8936002)(83380400001)(966005)(478600001)(66946007)(66556008)(6916009)(66476007)(54906003)(9686003)(6486002)(6512007)(1076003)(26005)(6506007)(6666004)(53546011)(41300700001)(2906002)(316002)(44832011)(38100700002)(5660300002)(86362001)(7416002)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Oj2oERu0kAP3qd7obuWWDP6BFtmRAzF4jpMFxHZo49BfaE/9b2rTergQcqjD?=
 =?us-ascii?Q?3slHJPsD0BOUChkywJRsE2wbGDAxYaVJsIHNOMiyv2kmR0g/T8/rdjKF4AjY?=
 =?us-ascii?Q?CSkp/BqzXoLYYySFWWxob+ESzqVukWYvV5iyY/PNWwzAe2sgZzrpvLXWrHko?=
 =?us-ascii?Q?FwTIkExi8fRnYskIaCFpahHwAuvkb9ER6+Ppfsw/vnsMsYjWNMkmhf/hO8ku?=
 =?us-ascii?Q?b/gRx/6XmyNt+g5fDAinSkeAfTuku8hpIyvGAuNTqnunKreDDEwHWdWj5g26?=
 =?us-ascii?Q?K2cTcuq8Bs7KY2lom3eAep/0A02QRRpXAPWOKs6qtvHmUePzS8K0BAjxuWDv?=
 =?us-ascii?Q?wkS7L8JQjx3wsLSNU4ijta11sokhPTMisSAl/2jIeSM8pJNj1aSqec1+wzlz?=
 =?us-ascii?Q?JL/MMQdFH6qwa1VsdJNBvvr/o22kcc3prC/RGHkgEcDGgSEPcWZP2GKO5WeZ?=
 =?us-ascii?Q?MhAQs1DFDOta2Zj1U2MrUTdhX7KSgIhaNfIw3kVpopGcZ+IpvUPPS+b/hM5k?=
 =?us-ascii?Q?mPHOVovcSbYBeRErbIZZ8lpaIUvPTY4C4Q4PU95zCIkxD48JEYDX92aX9u5l?=
 =?us-ascii?Q?5IOKEovUd+/bHyJxj6rWInurlLkzs9EIIdtQLIg58GEm80VOuHhuT12LpK1I?=
 =?us-ascii?Q?ijX1T02suW0jxI4VCcrCWX3+gfEKyevHqI6EXaXfQ4FS+K9LiQgBajPakMbm?=
 =?us-ascii?Q?FDi+p9SWBfVgrqU47BmVcjDzzN1WAH2GN7eXFphsn4SWdyxOAV8XlqXHXhs2?=
 =?us-ascii?Q?O2sW3vfFyyy9yzw3zbPvMa+1i5T9aM1dTP/CNSYEOWEdWswBC64iTV8Fcn25?=
 =?us-ascii?Q?jLFKGTEXuqwynKiXaddmFcooq1eU1lwnIDeUWn2FF585nalAR2s66xr69D+r?=
 =?us-ascii?Q?JW/GOVgua5gwCxfPkiMWHhI+nV8wmaAYcLmjt4UQ/NdsvMX2Ch55oN8klO/T?=
 =?us-ascii?Q?l/FdoAZufjDuB5GeyZPEPdLAKEgNX8LkFJYQR8C06I/kSgH+pdcobol4pBcL?=
 =?us-ascii?Q?no0Vo4W1xdBJGTPy/MawYf66yCnWMVYeJoRSlB7pjnU+GWm1veXfozKmMiiP?=
 =?us-ascii?Q?hjaOKr8B9LTGp65x5mIJJJ0VfFq9WXeZVYlp0fVrNPN0ylluH7/ItcQPCWpT?=
 =?us-ascii?Q?1MCwPKWQ4yxNIM8Pui9+3pl+W/s5rf6VJazGhw8pYjSXuakGsCkxVYGxGa3S?=
 =?us-ascii?Q?9sWWxS2MWVwor7Rv9Yb/l0ePsKyl79wWFk23drkubFMo0X3b+tBwy0AW+fWf?=
 =?us-ascii?Q?BUggkapn8nOsju4Jf0wgktu5o+Q/fgfeotrE2drgpL9iDTm91yb9ATsoafDH?=
 =?us-ascii?Q?HypHYLCIsl6bQ2vI3v4gPv8j3cgsuxESe4l/vzoGSx0RgWAU7eV/RgckcV2I?=
 =?us-ascii?Q?EBPpt3Qn2G75k4M3TcF7q59nQymixZM5RELnDBoXYKd79UYMF+yjew9nKmjT?=
 =?us-ascii?Q?p6go2sH40OpqPbVtHJkTG3hGLG8X1u3AyvDNmzl0AsspZYbtd9N/nxJEdFZl?=
 =?us-ascii?Q?33T5ayx4n4N3ggrUvn3NA33zAIv6NrYnLR9JAjsOhC2nCqcAhjfAiaFGC/45?=
 =?us-ascii?Q?uxRs1v5MYyi3TaW8lho84MaooIShV/SfSQtiDt52pcQFIVNzcQh1EHVzVDIm?=
 =?us-ascii?Q?bQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?uc2aV/GThLOUxyKlKb+xEncuIt8ardUTS8GsP47Hm9vfs2W82I3DOnt496Wq?=
 =?us-ascii?Q?S2+ePhzbHm4zkHQ8roc01JbCsqF9LdPf5CGSKETCv/7xcJ5Jb0P2jITw2uXv?=
 =?us-ascii?Q?iW7INRq71UhWCh7BlHsuF+/pCZUcRCKH6LWzLWmwOvfKVGAVPZgFIKIUH+ol?=
 =?us-ascii?Q?8KbsFaVBLnRIGuuFTt4BjY/lhA7eSfuTXJYa7YJ/Gdp/H28m6+MdbmM0249t?=
 =?us-ascii?Q?x0LuReekDN8cPQuVsHq8gvyAx2SzVfG4zmjJUdoseAVZdkbt2326kprLEhPe?=
 =?us-ascii?Q?dvAWJFSDnWyFL1hyzJU1uen0yX+jbPqh5Y+CHWyLjz5idKouUfqVe128wieT?=
 =?us-ascii?Q?OGm7JnCDGRBZAxlrjU5JRd+gu6TNWTJ+kcSefphlH/r+y919qF06KoNOJOeN?=
 =?us-ascii?Q?4+9WhGRps4Ehckuf0pZUYOjsl4MoRQByhCBYA7rEOyekSp5A0epd665YWQn2?=
 =?us-ascii?Q?ao+cdRqIpw5WkENpsDHG4f6tbI+E60kgC+64UqJZYJEarsIItX6ZfyIF5S6f?=
 =?us-ascii?Q?xDbcBRxDK4NOeW57dWPj4FDoC3rBXdTPQaxtZRTseqKaUA44KLQ5umNVimx7?=
 =?us-ascii?Q?JiEwsUu9L0eu5fd7/cnDSqugZg4MihQlOWWQig4t8F2B53tH+ic6OCfM7DxW?=
 =?us-ascii?Q?r2DlH8GrceAnSt98e05wPcIORYqfgDR2hjXXFD1u1JSiNzfSYeYa9VMB90tT?=
 =?us-ascii?Q?qa20W1nGaidkU2LhLm/qIDPP2ubRyBcRK5W2FQLat6EvIDVHrMT8k6IbXnvR?=
 =?us-ascii?Q?gwAXo2NOUtGgyRqX1CUKp0O8QTK4B58mrJ7CXKDRwQ3zUBw06vK/o5H8h1TB?=
 =?us-ascii?Q?6iwHhGPBiHujoudGVNy7hhT29xJwXq0f4il7ecjR56k299kl948fJZ/Rpx7p?=
 =?us-ascii?Q?tPFYRdBfmRONjNMjiPzQ1zEfRAp9cg4X134GBYB+8jB9yVFTpECTYUN2COw7?=
 =?us-ascii?Q?vKrW4KK8B1y2ggxbwOg94OtZU0fBI5ziRw1bKYpJ3kqXshJwbrBn6yZq2/5P?=
 =?us-ascii?Q?hf4xY+beJo0/0sLQzfySF6k9460XZvFeMxgJyWGBMTWHAuLfogIpIVBVwWGV?=
 =?us-ascii?Q?fBwkUeAp72QZsXXUT40RAUP8341POr2SYbtJzGP4r6xClBbwsnvFN4pA23Sf?=
 =?us-ascii?Q?88I8lKHUuEPG?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1bc906a-687a-4aa5-929f-08dbaf1dff22
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 21:12:37.4231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qXlDmR8a8YwXwGnAAlJCpIZ2BIvFhz9f19avv7LEESrlsF499mm9adkfv6wNGGtuBgLn62O+FS6ncwxO42xmmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7570
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_06,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309060184
X-Proofpoint-ORIG-GUID: o7Oex9AtkAG1vXc3rwj96gXdxS6utDLx
X-Proofpoint-GUID: o7Oex9AtkAG1vXc3rwj96gXdxS6utDLx
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/23 16:07, Muchun Song wrote:
> > On Sep 6, 2023, at 15:33, Muchun Song <muchun.song@linux.dev> wrote:
> > On 2023/9/6 05:44, Mike Kravetz wrote:
> >> When removing hugetlb pages from the pool, we first create a list
> >> of removed pages and then free those pages back to low level allocators.
> >> Part of the 'freeing process' is to restore vmemmap for all base pages
> >> if necessary.  Pass this list of pages to a new routine
> >> hugetlb_vmemmap_restore_folios() so that vmemmap restoration can be
> >> performed in bulk.
> >> 
> >> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> >> ---
> >>  mm/hugetlb.c         |  3 +++
> >>  mm/hugetlb_vmemmap.c | 13 +++++++++++++
> >>  mm/hugetlb_vmemmap.h |  5 +++++
> >>  3 files changed, 21 insertions(+)
> >> 
> >> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> >> index 554be94b07bd..dd2dbc256172 100644
> >> --- a/mm/hugetlb.c
> >> +++ b/mm/hugetlb.c
> >> @@ -1838,6 +1838,9 @@ static void update_and_free_pages_bulk(struct hstate *h, struct list_head *list)
> >>  {
> >>   struct folio *folio, *t_folio;
> >>  + /* First restore vmemmap for all pages on list. */
> >> + hugetlb_vmemmap_restore_folios(h, list);
> >> +
> >>   list_for_each_entry_safe(folio, t_folio, list, lru) {
> >>   update_and_free_hugetlb_folio(h, folio, false);
> >>   cond_resched();
> >> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> >> index ac5577d372fe..79de984919ef 100644
> >> --- a/mm/hugetlb_vmemmap.c
> >> +++ b/mm/hugetlb_vmemmap.c
> >> @@ -481,6 +481,19 @@ int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
> >>   return ret;
> >>  }
> >>  +/*
> >> + * This function will attempt to resore vmemmap for a list of folios.  There
> >> + * is no guarantee that restoration will be successful for all or any folios.
> >> + * This is used in bulk operations, and no feedback is given to the caller.
> >> + */
> >> +void hugetlb_vmemmap_restore_folios(const struct hstate *h, struct list_head *folio_list)
> >> +{
> >> + struct folio *folio;
> >> +
> >> + list_for_each_entry(folio, folio_list, lru)
> >> + (void)hugetlb_vmemmap_restore(h, &folio->page);
> > 
> > I am curious about the purpose of "void" here, seems it it not necessnary,
> > ritgh? We cound see so many palces where we do not add the void if the caller
> > does not care about the return value of the callee.
> 
> Another question: should we stop restoring vmemmap pages when
> hugetlb_vmemmap_restore() fails? In which case, I suspect there
> is no memory probably, there is no need to continue, right?

Recall that the list of hugetlb pages may be from multiple nodes.  My first
thought was that we should continue because memory allocation may fail on one
node but succeed on another.  However, with
https://lore.kernel.org/linux-mm/20230905031312.91929-1-yuancan@huawei.com/
memory allocation should fall back to other nodes.  So, yes I do believe it
would make sense to stop when hugetlb_vmemmap_restore returns ENOMEM as
we are unlikely to make forward progress.

Today's behavior will try to restore vmemmap for all pages.  No stopping
on error.

I have mixed thoughts on this.  Quitting on error 'seems reasonable'.
However, if we continue we 'might' be able to allocate vmemmap for one
hugetlb page.  And, if we free one hugetlb page that should provide
vmemmap for several more and we may be able to free most pages on the
list.
-- 
Mike Kravetz
