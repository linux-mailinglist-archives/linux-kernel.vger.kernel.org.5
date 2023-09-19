Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2827A6D79
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 23:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbjISVyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 17:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjISVyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 17:54:52 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8E1BA
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 14:54:46 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38JKgfvG020132;
        Tue, 19 Sep 2023 21:53:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=vfHpm6LSA77NNR5sqAu7Rk69af0JpVWTULaAR66KnR4=;
 b=LrI4ReQGXSf1/XdjmZ7ccf/fIMwIZHV/n9IPMRvt3CwQioVuNNfTqB42Zokco5N6fzyr
 2twMkq1rCjNj3V1/lVsv4pIK1LnE/j47z8D4UEHhuKHVlg8Qzz+7dNsgJ3GlyHFjW8O/
 IG+OIgsBK5mcVwS2EcZDep5O4/Uc1A4t4Syo+89U8eaR2gj/wAk/X381uFYGXVqOxrk4
 4/HzHbqNUahxe2ZYzkxS8Mwr5gvmw7XpVZblNQffShJ2YrQu0QGlAaIVDxfZws5K9u5N
 3B7QocWN6++qqs/WPkfEz7fDiWcWzcJaN+JHTYt362B61c1OsZNEpdOoFdJ9E73GYlTQ rg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t539cp343-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Sep 2023 21:53:58 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38JLKKNK030994;
        Tue, 19 Sep 2023 21:53:57 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t52t68v0f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Sep 2023 21:53:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VhHMdr4TsDuUe7X2v+h2NhlEwFcKcc47lzpBXaf5l6uUgJw5mIi02AB6xsuucoLf+MdyCBIyHbFaTdgXUZ45y4CcA7vCbmKoTXcYRlwdMtJvXJ8RCME729KKtzwFVh8jqxNfr5NJcLOrYTSPWz0qztV9wtNBoDgPSEKeU2HChs/xFjVGfFdU9ONKNTmCpY1Egc5K29LQhqYG/vXQi6l/oQlPaKTRLdxc2RWEFYeOMy7hPvFXqnxh9tMjVCFkliF4xOh5JykRkLDHxv61XDKuMVgx/TB/66OeBkjjNNrmoXBLDY9t7HWEk2Nwbq3mz4/0XUI7hBy2JoLgjcsEwb0avw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uhCgks7lmr8v2eLw4u7g8/+pzUkxccpg0KI+uVhJ0k8=;
 b=mnRkGaR0yf1RbgQgI1NnYyS0629IwIMeFtTIq3Q8KAkubc7HeJZ4saWsN7jGuk3n6X9eRsD2rrEZFor11oOdN66xQlfLgYJ7oNjiyxe2xm0wpyYoF0kQPq/ktP4dHDD38vyw/pjgwY01oD6OqzN3J6sW2JpOWOO+MrtHWeMyoilkkz5sfsum5X9VifHVvf7ytDgToBG7zKTDVlAgHlFqT8Jo8hnDPqpAYumCXq4ir+MLa8VlhczjO9Et4D11RAr9MS0iyXRvMMoga28bbBKi2VGueIYT5yjNqRBjuX8l+Vq6tWowOk/WNFeAs7X9rpYEwmDtwhAglcSyQB6aXcN6gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uhCgks7lmr8v2eLw4u7g8/+pzUkxccpg0KI+uVhJ0k8=;
 b=ZkKWUtaZxY/TTkLUWxT7LqZJS94+VwAUByKTTOtrCoXJcpGCsf0QGZk8pB+DO4cBZl/uMtd8d5MrffSwxZUh6/t2LJhoHBH9SrgoS/HL2XLLQojCQLM56Jz8OMBBYY3FHgRnH0Lpf/l1vi9EfCSvEG2Lav4UB39hGOCPfPXiqfw=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DS7PR10MB4974.namprd10.prod.outlook.com (2603:10b6:5:3a0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.29; Tue, 19 Sep
 2023 21:53:55 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%5]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 21:53:55 +0000
Date:   Tue, 19 Sep 2023 14:53:51 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Muchun Song <muchun.song@linux.dev>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Barry Song <21cnbao@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v4 8/8] hugetlb: batch TLB flushes when restoring vmemmap
Message-ID: <20230919215351.GD425719@monkey>
References: <20230918230202.254631-1-mike.kravetz@oracle.com>
 <20230918230202.254631-9-mike.kravetz@oracle.com>
 <1ffd72f1-7345-1d31-ea6f-77bec83cb570@linux.dev>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1ffd72f1-7345-1d31-ea6f-77bec83cb570@linux.dev>
X-ClientProxiedBy: MW3PR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:303:2b::7) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DS7PR10MB4974:EE_
X-MS-Office365-Filtering-Correlation-Id: 07cb8896-9d5c-47a1-c426-08dbb95aeb41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A8uF4KWB6EQgxw9I24aJRO9BWjJN6TfdMJ/xL54J5+Moi4vnfFax9+PdMTtBDH5uy2RTSp2Jfh+zFN6JoMzaRWje8bfYVR8NoqFNFBioz6e2MHJr+GjfKJJL76CupU1HtZfReZDs3qdXg8QUaY8I6VxsXboJTEeRmIbeRb85wNiIEoyrB0WZb12cFWqvqOpa/wUk21FkdfWPunFSVhDfOWzUYXzYp7F6nMZY5gNNGuah0xmoMwhtBn1bqdrDl0b2KuO13YP28CVDd/4//mEWV01YMF0rc6GRQBevjJ8ITHxCkFQH5mDGSgXzuzVPiBDlhyDXdrnTL6iQMb5xxAAbY4IY9vdDUCp/IecltRqGWsIsKZW7KhfnqlRiaSISYnrKa97mTrMv52teK/88mPAd++bEa8nsG7zQHEqTMepYGGvvJREx/UiuHkLpgVnlD+mp1otaeVA7aTcoDJP9Hpm/s794LBsFVnF1Ted6jr/z/YKurqY2KKUqgPWdzjNB9YPgrxoV5IdKwH/rXkXOsYTVzKCeeF0qxd9OFT9UkpLLFOcFcK++1Kd8d4YtC25I2qal
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(366004)(136003)(346002)(376002)(396003)(451199024)(1800799009)(186009)(26005)(33656002)(4326008)(8936002)(1076003)(8676002)(83380400001)(7416002)(2906002)(44832011)(5660300002)(86362001)(6512007)(6666004)(6506007)(6486002)(53546011)(9686003)(38100700002)(33716001)(41300700001)(66946007)(66556008)(316002)(478600001)(54906003)(66476007)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?NqUBlRd8G2qa/JRCxenOVcTLdI7K593ZXRP/cg8s44ZjkpqL7yJ4rjkZwE?=
 =?iso-8859-1?Q?vcXZfDnEY8tJIiNoU7RlhDH7gSXbg1OzemOblyJCqTvoXvTcrjElKel/ak?=
 =?iso-8859-1?Q?3C5wObDvqDqYqWsBKnpxCI4pcNzNJ/MUyMk/IHxj/5/xb3m3rEqgV2DT7d?=
 =?iso-8859-1?Q?3cRS9EWfcyaMUsc+Gnjp5Kxy5fOdeZR+evTr7HxIA9+opLI48xP8f2wAWB?=
 =?iso-8859-1?Q?ZQV64ReB/8tK7GcnyiVugGq1w4TjGom9Hc9C6P8AUjkHIP3lk4YWRaV/dD?=
 =?iso-8859-1?Q?lFrcvVN4kXEEdFEHd1tMNCJU0pWTluPqBb+7ISKp9IrAIsKCG1eJz0e6bW?=
 =?iso-8859-1?Q?bj4QlPiyGeDL7TNoVj4XriD0tqTW8AhP1rULA6pF5lKHgGekIrsd8NY0Aa?=
 =?iso-8859-1?Q?Jq13dWUPvNqwhd7FgqrvRUZZ3K04I0xo9hDHGeBAZ9Oksha/deVIAem6UH?=
 =?iso-8859-1?Q?tuV9NvPAX/S2ajiBBsYcjtoUR9Q1Ir6dLbx2RlCUu4c5672W91925vuS6K?=
 =?iso-8859-1?Q?6R+MUNcsigW9o2eQxj9tn1R5yf8JfNurZXkOBCoz/qX9b0UmweFKRiz1KN?=
 =?iso-8859-1?Q?HMyfArfFNdvPThj+P6CSl0zEw+FU2V4O7lg2Ww1mU4db7FGBulIqCN8Mbg?=
 =?iso-8859-1?Q?ibaKq1yw9fl7aoojnFitWxjU/xdP7nYDD8HP197dr+me+K7pN4qpxuXIFb?=
 =?iso-8859-1?Q?AFp1mzURJMhjcSdl6/V7h2GcgGr1SAb4cu2YXWKeY9gNJPt3Iam01hlObJ?=
 =?iso-8859-1?Q?TJQQc4lsnC7EJyrQ/uBFY+APMGG8Xj3+j47hPAO0tOMAZBphSbu28f4qjg?=
 =?iso-8859-1?Q?55z+a78aEyiYGQ1YNnF6PQOtFXFlBRCZ5BpVmKk38PMOgWVmNob9O1Bx44?=
 =?iso-8859-1?Q?9RT+iKGrrOC0EnY3zrBQ5tEz1vBYIYzQAtDVk5nHChWH/+2MEjSRzC1hbb?=
 =?iso-8859-1?Q?rwpjXj9zXDSXVRCg1gNfIY1XOVi4B+ZmgZgcvDyjDo/vM5OGo877YS1HKp?=
 =?iso-8859-1?Q?QlXWUUh4VlmtulCES4glQn8WJc4CUAUwdzw7FYSfQQTL2v1T2MQHSyDlBQ?=
 =?iso-8859-1?Q?QTIQDHUBzsVPnnb/qtF76Tmy6docWr89inUdRDP2Sedk3vt1brLD8s0KSu?=
 =?iso-8859-1?Q?dPHRqb41zA7KK03aJPosRRN6y+ps8uPXg1FGy6ek12Gb2jrgPxzmor65Dv?=
 =?iso-8859-1?Q?YHLAJ0x5fg1Wd66BzZIu0fFBM3QPkBdEdJlFZ7jObFk355xy3WIOwqI6J+?=
 =?iso-8859-1?Q?ECJ1OTiZH3/ZLCT2udJgo3SQsqC6hUee+AK88OjxOQXIT6ArQB4N/MBjo/?=
 =?iso-8859-1?Q?oWfYEy2d+ntKLu6BtjLnuHNEiElNqtDwablR+ifPTAs/oiCbq8/XmGjX2s?=
 =?iso-8859-1?Q?KGRsMuk6KQpv/lRZwNrZIiIBR5axkCIl6X/cGWzjwhwJ8e0zwZPcqoHSOu?=
 =?iso-8859-1?Q?p96/n4DRQAYx7xKBHHsl6p+qf8RHtqCCDoViRB7Etneo0LxRloFggWyvj+?=
 =?iso-8859-1?Q?CLq0YmwpBHg5FmHxr2adbV6Kq6esIAJFEvXCp0Ahpser0gzgF3SyC7Mdwi?=
 =?iso-8859-1?Q?A6hQ6sXHhYNToqwdMVzYaIK1ZxQdPaLbxem2gE3viihNG+2CcqJqEi4C6w?=
 =?iso-8859-1?Q?+y5iWs7byhM3sX9TliTlPhLbXD9CEMxYoMD9qXZ3G0iz6fsHBl9XBdIQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-8859-1?Q?KLwi6S8CxKCsZSUMnzMQwNje3lS8tcpbbSofFu2tmbWyylBpqsaF6Z8rDB?=
 =?iso-8859-1?Q?O5zGM4UOP0SzMs57sGmRZyDbh1wk9lmUHCwKOzL8r/poS+neHWW1Rdsigf?=
 =?iso-8859-1?Q?UwgyKWSzY6VLSTjT0CGiUxaZOsbMp+Q4e2dVTfFDzLNI6B7s5b0zGRN/tv?=
 =?iso-8859-1?Q?LrP0KO/PmjCc/Hls1+f9MuikSMLghErQy28xgPgvcnnC86pGGDoEB8Ni3I?=
 =?iso-8859-1?Q?a/+VwhV32g8zXHPsO7G5JfkdzH21U96GZ+PuzkxsHefZLCGK0t9we48kUK?=
 =?iso-8859-1?Q?fGWERyMhTslPnvZ63j6o7go3RNzethprnBuaNoWTWog8kISHQu6jpnQtju?=
 =?iso-8859-1?Q?sGnOCRv7Ven+6rAerkPFEPrsS+fX7rlCvBqkXVyQSdrAslosQTMWcO1Shv?=
 =?iso-8859-1?Q?QP+n6iONviin5+AHaH8fJek+MYQnC/B3EOsrrS82/u06fkACUEPSZgk8aP?=
 =?iso-8859-1?Q?+jGRlQp1juGwMmMmeIrl/FMAyVaHxvXVZDy3REDD5rGUiT/YlCsltKQC+S?=
 =?iso-8859-1?Q?1jW7INoZanLcBmMi+PmCf4zV6reJ++xDk5apXUE4+kNHulFzlw8Y33TvQA?=
 =?iso-8859-1?Q?tMJE+ReM2KWyRXXoeZHsIgcvqpmJ0F2AygxW9dg+uPiCg5IRJoU6oB/qI4?=
 =?iso-8859-1?Q?W48YQczVJQPTPCFGv38KhqskbTWZ4/7uRgSo4ucGnpDLyfDZgt3iBkQJfP?=
 =?iso-8859-1?Q?9Zub6OQLZCTYXhQFOcgSSzP8TIalIXRPccOLSB6c2ddIdWWpzkkbHiOxXf?=
 =?iso-8859-1?Q?7QgtUO641VCEJ8r7YKKvhtOO1Oxei0xtsc0I8VN8+Hh63gUfMl+RZgAW3d?=
 =?iso-8859-1?Q?ss5CcFEd1kpnEsnILvz2F5BLTyOQSxK3CASaqGpTTXkJx22vTILW+VQaIc?=
 =?iso-8859-1?Q?kxmk0XaymoSSjrTOTIsz8OLmDOrsvCvk3O2Jy8qAE3OFaPUM+l05I/usI6?=
 =?iso-8859-1?Q?PiYqxe/w9A18m1fdHrdRMvY1i/PwO7zRHah0DNcchnMzfnLH+82ostXAFV?=
 =?iso-8859-1?Q?5fnI3w7FNj44SmpdWFJ5JSCRhpgL6YfYW/Zj2IHnonkrvQnEKgBVVtWPO4?=
 =?iso-8859-1?Q?BY0I3jt9V3ktSpBQh9HRl+8U6HjbFEbA3oGU5Nmie1/SLz0Wa/c9R/lzAb?=
 =?iso-8859-1?Q?/ENMQwR/xgpHRCJVii8CH5VJUculq83GO2oMt4NP7CPxm8oEzG?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07cb8896-9d5c-47a1-c426-08dbb95aeb41
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 21:53:54.9571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xyfbnn+8ykgMi9xQZrdPIs/lRayUhkV64XCcFERHmZdtgHDHgUuP8y+bLvaETOV2pSYodo89l/DCAyNYII3mzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4974
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_12,2023-09-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309190187
X-Proofpoint-ORIG-GUID: gBwb0hgVtCE9Z3WrqRhYWZzgyKSFPmIH
X-Proofpoint-GUID: gBwb0hgVtCE9Z3WrqRhYWZzgyKSFPmIH
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/19/23 14:48, Muchun Song wrote:
> 
> 
> On 2023/9/19 07:02, Mike Kravetz wrote:
> > Update the internal hugetlb restore vmemmap code path such that TLB
> > flushing can be batched.  Use the existing mechanism of passing the
> > VMEMMAP_REMAP_NO_TLB_FLUSH flag to indicate flushing should not be
> > performed for individual pages.  The routine hugetlb_vmemmap_restore_folios
> > is the only user of this new mechanism, and it will perform a global
> > flush after all vmemmap is restored.
> > 
> > Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> > Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> > ---
> >   mm/hugetlb_vmemmap.c | 39 ++++++++++++++++++++++++---------------
> >   1 file changed, 24 insertions(+), 15 deletions(-)
> > 
> > diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> > index a6c356acb1fc..ae2229f19158 100644
> > --- a/mm/hugetlb_vmemmap.c
> > +++ b/mm/hugetlb_vmemmap.c
> > @@ -460,18 +460,19 @@ static int alloc_vmemmap_page_list(unsigned long start, unsigned long end,
> >    * @end:	end address of the vmemmap virtual address range that we want to
> >    *		remap.
> >    * @reuse:	reuse address.
> > + * @flags:	modify behavior for bulk operations
> 
> Please keep the comment consistent with vmemmap_remap_split(), which says:
> "@flags:    modifications to vmemmap_remap_walk flags".

Thanks, will change in next version.
-- 
Mike Kravetz
