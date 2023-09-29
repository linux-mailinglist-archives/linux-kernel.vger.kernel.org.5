Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5A27B3C88
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 00:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233517AbjI2WLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 18:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbjI2WLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 18:11:02 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0E29C
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 15:11:00 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38TKi0EJ007757;
        Fri, 29 Sep 2023 22:10:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=pckpZZJHJ3WY9OmNiTLZkT5adrP3u5nUKJf5O9hgcvM=;
 b=VxEK5a+3N2cMnLnUPRVf7HO1s3gqfNu9dO/GsPryHtezPIdwPZo413LMDyWPe97+qiBF
 X00F+XS7vLACNfeRzeHdVY8rPS6WB4x0WsqQXImer64il4WN1tdRaybKg+Engj2gEWbo
 xfYaz1+mcyKxjGOZZOvdBz9WVNXzJSJ50ABdNILEtC0Yy1UJ9SvwtdIab9NIilrrRsUp
 MDIcCyqexEbhdyDmKXQ9rqdTbySMxkE30s7RzVItMsebv0NWLcVyzF8rSLcJbqDP3PSj
 slZxlKGDqBZmgwbvonNlDgiwRlI/jpT48cExuC/m6eYmR2iHi1ELjgLn0UKlZ00Rszdk iA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9qmuqpv8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 22:10:25 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38TKMnH0008214;
        Fri, 29 Sep 2023 22:10:24 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfc2xsr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 22:10:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N4ZI4ttNBjN60ZWL5jdT/tLWHck9u1sacbfU0W2ubRwNyRxOP2lfd5IpjTvP/lDFNh5HhiADsq5Jp3x4Y5uZ5D43o7iMJkI8s7U1L6Uj5o5SL6+WORoappCGb5JrW3I9qvvV58EMwyqEjy/ADRHTn1QYdDROB8YKLk2KT09hiqT1PNgAAUgCqS2ESLZVo97JJP1IcR86j0CRB3D+qYiJnItlNsfNIbtYdBKmslzTf9UvDuf3H2l23SZ5/063cJuZ+ZbzfDNF0jUubpZSBdgnYZbFsMfpH17bnZP/X++enbkW4SpSCG+bzjFfhv/Dzq7UTiIROfAYriBj1anVnjbz6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pckpZZJHJ3WY9OmNiTLZkT5adrP3u5nUKJf5O9hgcvM=;
 b=aRokq44+WMbKBvB5tFX6K890kEMpsYQuvAaBkSQj3qpbu/1n+zfzlrWJMRnMn9BklkDdSLun6UwlyXCK35iUCoDloaMuNFjznYL8d9bbA3bKm8UkEzjj/QGaqluvOz+AnhVq01OFSGu4hnubG5BFFV/B7WJRtYFWKNV8Yv358rn7OuiR9mb1PiL1dXhcrSygzkRzrXldq8kuXUl76m4t70h1+NwRbp3BDN14pvRU5COHMXz2O/5olNHmNyPEBxVAMlo4H934EkQK2XxDK0/MW5OImy8SsIu9SYl/RjrsT/8KJm0n0TNe5GCrtKtKE9xWLH8z/D8f2JDxoAnZBOOVLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pckpZZJHJ3WY9OmNiTLZkT5adrP3u5nUKJf5O9hgcvM=;
 b=GBona9FFcOAOaxIVuEovx2aYcTpR9W9B75qGjEioM869jmp8XSgT3SUB1+gyBbtXG+fQonMhXfTw6KagsIB+Z+LhVBaLKNdLTR1mRdq6cg0vCiHHwbbfC3w4zHmXZ+Hzzv201BrEK3zoVkSlJi4RAewrGIa9vOtK45QtukkhVjw=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4574.namprd10.prod.outlook.com (2603:10b6:a03:2dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.32; Fri, 29 Sep
 2023 22:10:22 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::94a0:adfb:6474:63bf]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::94a0:adfb:6474:63bf%6]) with mapi id 15.20.6838.027; Fri, 29 Sep 2023
 22:10:22 +0000
Date:   Fri, 29 Sep 2023 15:10:18 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
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
Subject: Re: [PATCH v6 4/8] hugetlb: perform vmemmap restoration on a list of
 pages
Message-ID: <20230929221018.GB10357@monkey>
References: <20230925234837.86786-1-mike.kravetz@oracle.com>
 <20230925234837.86786-5-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925234837.86786-5-mike.kravetz@oracle.com>
X-ClientProxiedBy: MW4P223CA0016.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::21) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SJ0PR10MB4574:EE_
X-MS-Office365-Filtering-Correlation-Id: 61237f52-d27c-4006-60a7-08dbc138df66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QpeNJBTiZAQOUnrUfyoVShDsUbTYm2N8/oTq/ZBdtGZi9pJ2X8iKTt1FSPFXpNqNV1crICbKZPhCinmQwq1rvakUNhlJRaDRsdA1Gg81POyXJ2hQnwFRZYyPMcQd3ByMsFwooyDUMRYkduaCdhnt5k0TIhJ7+6wRJNnEsJxcYvjmmUtP8iFw+fZbdYp9Wh9FZThRyeeBXSeK/d2mEKnP0yb90jR9Fta4Y3dD9ftva7o7uUMYolv0d6iY+ynkwjQfmlEfwx7fDUWAwkdkvfPtuAEho7ZF+hPNDnV5E5z2E5Ou5Zq3Cihy2rjKGaskJH77c0aQQuPfwuIfDMaHBim2PeKx49/Kd6Y8seeluNd3KPD/rkd5nvfapXCklK/5mZX+B5NogkdQ4eBR004nVsbftAwMlPaGsUBkubmo++3Ks+5kpguB6Yo2CNKUIHxfz6SKiUUJ4uv0JCklpUVjZX4dSRTBzg2xY28cofHKklLkQwt6Uj18Cyz9jPtPfa+ioYjcmkGOKUU5dsMouEYqEIiCCfk7Xd1mSpX/v+yu9DyUoImSUjl/9471+F4tcT3c8YmY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(366004)(396003)(39860400002)(376002)(346002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(9686003)(1076003)(53546011)(478600001)(26005)(86362001)(33656002)(7416002)(38100700002)(83380400001)(6506007)(66556008)(2906002)(6512007)(6486002)(8676002)(6666004)(8936002)(5660300002)(44832011)(41300700001)(66476007)(316002)(4326008)(66946007)(33716001)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B843DfOevpiAV4DF1JLHR5NsjTvX0U78nwR6MBfR05theM13HLWJVINdoSgj?=
 =?us-ascii?Q?mEMCXNJtA6bC4uv0QxGDHpryeklMkdosZTbOhZ0B0ZROBt6b4E+sAddTCT2P?=
 =?us-ascii?Q?R+xodwcxuoRUmFYnLeWjv4oLQjrJ3F0wQ5aS6+UcP4KtS4DZm5RI866UgUXb?=
 =?us-ascii?Q?G6UCxPw6SB1n+WsuaEoevr8vitsyAQ1DXTqIbIyY4FjHPIrp/yLyjKIov9uD?=
 =?us-ascii?Q?54ZmgCKlf1j3/D5qz5AM4TATzuBDxbjWNDd0lxWb2eicVH7UPVZWOpEW+blk?=
 =?us-ascii?Q?51LH//i6cPvC9yXT4H/kwW3J4A/7DTw4DMQaFWzblGlGe8LlEKRjzWDndFf3?=
 =?us-ascii?Q?ieeiZQ7xW5my2JQ7juUrWvKWqjcABF5P3zMHlLVS2BSK2/3gmdsNjun3vUE1?=
 =?us-ascii?Q?MI5y5yHUH48YtNLwfloUYug9ni1hMywBR09ENfdcZJqPDN+M8cT3NFBuqQNH?=
 =?us-ascii?Q?nqHE82yAK/CTrMLtGLso/mPuj2FleRypY3giKw9RGeCKupd24Yz6N62rAiht?=
 =?us-ascii?Q?BXx8rbaK1x2p6zOvoywbTdwvT5UKpgveaMKrPmGFLh22FDuwnLUSWwGrI5C+?=
 =?us-ascii?Q?toZ0W71iP9BMWY3/xZyLFHW3XJoLGGnWRM52bRRqOFFuSrQMSHOKVnI/FRQA?=
 =?us-ascii?Q?ne+Qo9NUJlSfcb1mhE/TKpjPAHetgiZtJrI79HsXsVyW62wzOn7Hx8XJ/iwX?=
 =?us-ascii?Q?yKjo8NiTF/6K3GY2k8luXaWOnBJ1mLJiNjxERuw4Ecd5xVcZ0gn/zSsZUstN?=
 =?us-ascii?Q?11sTs7au1AdSttMfYwWz2WSvpKAOXL2rYZwGzDoRnPBa4Xxn2fXfsFsvnQ6O?=
 =?us-ascii?Q?TXt4y1RdCMLTOepBVKyM9UOPKd/mkBt20KiIa+1ilpn3R8RNmSG7Dfjq2OSU?=
 =?us-ascii?Q?N6oS6CW7Jpb0I3qy1/xz4GwgJpRFP1VgGRCQ0CywMM4p/Dwmf7fHJT53z1wv?=
 =?us-ascii?Q?W8b7DAUDQVzibQ0ZLgMtPNlbUjCWvNrdLbgfWwXE61QspPQ2grqBnkr9/fTD?=
 =?us-ascii?Q?vpQH4iHfLuL0eEBjHz8qzkLGm6f2KHLYj1lTUjpwVgPEVPUDRax2Obb6xp+b?=
 =?us-ascii?Q?R25nwcIlndKsnLOtDXptR3bEOImcEtFefKu7ZJnUIGWP9C84wCBZz9T2oXCP?=
 =?us-ascii?Q?zzFqeg/R7vqIwt3sJLrA561qWEWUdj3uFqzLlZbpuN4EaUK5cXiMzDfpc+cz?=
 =?us-ascii?Q?/z3afKHa8HoSCmkmeXU7s+5Z6Hp5yA0Ck2Zu7sj8+XdKsP3bpsHGL03GFiF1?=
 =?us-ascii?Q?4c638/K0HCJPQsQ+YP900b9WsAwlBv3sTaxMG2DNmlUc0MYNXtAi7tYLYP80?=
 =?us-ascii?Q?ms5sPNr8Qqbkf0XHgCAu7w8wDBy/02w3ERAR6DmhwJ0xVdzHlj1p6BtbnxuJ?=
 =?us-ascii?Q?D8U1qwUkroVhkCtvNcjWTZ2fETF9XKJGvyhJTvUWmVKR2yh0bygxhOPXt+eL?=
 =?us-ascii?Q?7eojrYJFrrgtIaKhWwSeKqt2m8dtIuw1/14Sw5rMpD0MC11Dp2GFaUOUP12z?=
 =?us-ascii?Q?HixEmsPjXIYGnaGpV6Hv3PLY4OfEVOXKA8suQp/oMoaIWkTgSc58M5AZeWbw?=
 =?us-ascii?Q?HChh8FNBjh2OaGNjSqRDBlOR7LdEua8tqeLzv3Wa?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?ov1iYNhj7gsLXC3i+dWAudhFLAhgBfdwA0/QOnUCOHBWVDk/HZI9ei6YzgFC?=
 =?us-ascii?Q?lQiIYBcUTcxRBoZTWVtnCptl2rpoqe2Yyrri6aSHr/Lc6YWN7F3V9oWU7kj4?=
 =?us-ascii?Q?/jB4tcFUyYfBV15NH3X0gzDAXhLpc30170BJ9/CrejC8pfTy2U4VIN30n1B4?=
 =?us-ascii?Q?E7yXyCuoDn00MXQZjuMI2n0hjWe9R3EvH47mBvjFvLMdV09TDGU7Ai11IHkk?=
 =?us-ascii?Q?3nk0otzwyxIwUp2tiHkoOn5Debl9MTl5fzd0WcLTyI2tH27pNGVKdWuAmpGm?=
 =?us-ascii?Q?LJXrqf9KPkgJokF/WV8u2AXODwJ5c9u4sOtEZXENXri//2Ok0V+mZJqD3p+1?=
 =?us-ascii?Q?Kfga+EGh2tDpGUt85qCnJO7WWj+PRC61b/ItaB3y09kOzHnifhhGMF5JBb0s?=
 =?us-ascii?Q?3xH/uKcQnQ2zBkv3GNBo5QnCVJv6sYuqLFAyx+p7E8dN7gMY3mNQCQJGJ0bQ?=
 =?us-ascii?Q?cTrEIH8/XMkRKk5xRXM6fi8P0iQRAoC60anHZ6OwGPih2s61l074kMXlPtgy?=
 =?us-ascii?Q?VepKrNniuoSuxAeP0eGhYURYgnNmVJjJdr4UHTCd68BeBsOprE+HC41DTHUU?=
 =?us-ascii?Q?Wh/Z8QRW47CXWwk1y7mSYg6ds5hA37lLUjH/mBkNcRU69+G8jU1S2REPWxEB?=
 =?us-ascii?Q?1xfJikiGeVcJAwz0e0fJBkslPKUaXzJRENxmLEa6Oq9lZhnZV9QGVbDQtIPy?=
 =?us-ascii?Q?U7s4RIr62md1mQyo09bUHvu7cynLuXaj/Y/owlUbxGRPPVt8uj0DusBZA8HH?=
 =?us-ascii?Q?YDTxS5VfkUGjebxzNnpHAhV6LpZMyQtR6gm8f/YH+A9rqFe4d/yol7JZAyD5?=
 =?us-ascii?Q?rCOxMXBFVO68pSLaLXehRME7S36XFD3DwvHqQ7k6AoyFhELcRlR/2x626GBO?=
 =?us-ascii?Q?a1rBaukoq/FhK5iOr8mZwhpZyZ8iz4LhM7X9oR+ZGhWnDpZLLpsWv2b7bSHU?=
 =?us-ascii?Q?yn+QMtKYvYLJVsDYkT+fsRdabu9MBPU/UKi0IyQ7lqf9nQ0kLygZEBG+KC8k?=
 =?us-ascii?Q?ggy7y+fECAvmLF+GMlEPU2Yuj9QyegcNvFM3ytCG7235zVq0ADUXbx6UpihW?=
 =?us-ascii?Q?YNWw5coqp7+aXVh7cKtz0FVst7VVkHeXcByBb1f0fKlTUpzwCAGm7u4ahfVM?=
 =?us-ascii?Q?4zNp7xldaZxU?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61237f52-d27c-4006-60a7-08dbc138df66
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 22:10:22.3203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3IiRFdHaas4nJm5YTEiFoG0rmOkny9WV16gDc/yej9qRj4Uql3WLH6vfwXB3RBv69cS33V3Xhcyegyn6u2Ftcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4574
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_19,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309290188
X-Proofpoint-GUID: hQEdyI7ll69F3GfDrVDDclgL3ydfTZPS
X-Proofpoint-ORIG-GUID: hQEdyI7ll69F3GfDrVDDclgL3ydfTZPS
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/25/23 16:48, Mike Kravetz wrote:
<snip>
> +static void update_and_free_pages_bulk(struct hstate *h,
> +						struct list_head *folio_list)
> +{
> +	long ret;
> +	struct folio *folio, *t_folio;
> +	LIST_HEAD(non_hvo_folios);
>  
>  	/*
> -	 * If vmemmmap allocation was performed on any folio above, take lock
> -	 * to clear destructor of all folios on list.  This avoids the need to
> -	 * lock/unlock for each individual folio.
> -	 * The assumption is vmemmap allocation was performed on all or none
> -	 * of the folios on the list.  This is true expect in VERY rare cases.
> +	 * First allocate required vmemmmap (if necessary) for all folios.
> +	 * Carefully handle errors and free up any available hugetlb pages
> +	 * in an effort to make forward progress.
>  	 */
> -	if (clear_dtor) {
> +retry:
> +	ret = hugetlb_vmemmap_restore_folios(h, folio_list, &non_hvo_folios);
> +	if (ret < 0) {
> +		bulk_vmemmap_restore_error(h, folio_list, &non_hvo_folios);
> +		goto retry;
> +	}
> +
> +	/*
> +	 * At this point, list should be empty, ret should be >= 0 and there
> +	 * should only be pages on the non_hvo_folios list.
> +	 * Do note that the non_hvo_folios list could be empty.
> +	 * Without HVO enabled, ret will be 0 and there is no need to call
> +	 * __clear_hugetlb_destructor as this was done previously.
> +	 */
> +	VM_WARN_ON(!list_empty(folio_list));
> +	VM_WARN_ON(ret < 0);
> +	if (!list_empty(&non_hvo_folios) && ret) {
>  		spin_lock_irq(&hugetlb_lock);
> -		list_for_each_entry(folio, list, lru)
> +		list_for_each_entry(folio, &non_hvo_folios, lru)
>  			__clear_hugetlb_destructor(h, folio);
>  		spin_unlock_irq(&hugetlb_lock);
>  	}
>  
> -	/*
> -	 * Free folios back to low level allocators.  vmemmap and destructors
> -	 * were taken care of above, so update_and_free_hugetlb_folio will
> -	 * not need to take hugetlb lock.
> -	 */
> -	list_for_each_entry_safe(folio, t_folio, list, lru) {
> +	list_for_each_entry_safe(folio, t_folio, &non_hvo_folios, lru) {
>  		update_and_free_hugetlb_folio(h, folio, false);
>  		cond_resched();
>  	}
<snip>
> diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
> index c512e388dbb4..0b7710f90e38 100644
> --- a/mm/hugetlb_vmemmap.h
> +++ b/mm/hugetlb_vmemmap.h
> @@ -19,6 +19,9 @@
>  
>  #ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
>  int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head);
> +long hugetlb_vmemmap_restore_folios(const struct hstate *h,
> +					struct list_head *folio_list,
> +					struct list_head *non_hvo_folios);
>  void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head);
>  void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list);
>  
> @@ -45,6 +48,13 @@ static inline int hugetlb_vmemmap_restore(const struct hstate *h, struct page *h
>  	return 0;
>  }
>  
> +static long hugetlb_vmemmap_restore_folios(const struct hstate *h,
> +					struct list_head *folio_list,
> +					struct list_head *non_hvo_folios)
> +{
> +	return 0;
> +}

update_and_free_pages_bulk depends on pages with complete vmemmap being
moved from folio_list to non_hvo_folios.  In the case where we return 0,
it expects ALL pages to be moved.  Therefore, in the case where
!CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP the stub above must perform

	list_splice_init(folio_list, non_hvo_folios);

before returning 0.

I will update and send a new version along with any changes needed to
address the arm64 boot issue reported with patch 2.
-- 
Mike Kravetz
