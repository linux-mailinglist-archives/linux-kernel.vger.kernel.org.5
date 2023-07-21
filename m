Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6F075D5B4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 22:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbjGUUZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 16:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbjGUUYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 16:24:50 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949313C3C
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 13:24:27 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36LEFxGv017479;
        Fri, 21 Jul 2023 20:22:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=NE78f/YXpz08BF6Qmfnunlk/cwIeJLJnTmW5hBK860o=;
 b=LpY/WrXqhhvNRAfg5lxhypl3qxVsm/M2PbkzWjZul0QopJT6KkJzD+qewa4ACh5ygPfp
 AUrhoCDA7ZFcyzLrtn+rIzdZ3E/VJ+B397bdpjsB63vs4dtYyYGXecwGpZ4KfxSkoxo5
 Ql8qFJnbr/WBSX5pvgJTeAfgoS1aNFpzhB9DYvS+q3lGKHNmqyFHR+tgMUru2+AvcIAo
 vqPqs7aSRY+9adDuqZJqjB0xRqXO4RQ/z4I8NAY1PdzJaL/hwF9Fv8HvyMncgQFn7M4V
 RmhY+vp7/tkAwG2flKLjoTsoJG24ouiZogZ5Pn0VxJxyIkOT99O/QUf3SlZvo5xBLlpN EQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run88vue0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jul 2023 20:22:56 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36LISXQt007802;
        Fri, 21 Jul 2023 20:22:55 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2175.outbound.protection.outlook.com [104.47.73.175])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhwa7pcf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jul 2023 20:22:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G0GrF3PRXsJxYy3XaJXIGozf1m4uZcHLtPcrY+OM2NWUoHOW7cwOcGvupu+gFUlDz/5jJJNqGSBV2HXGsZw3zu6+lD2uHrupC6/zj3BbFKJCTFyMY8n2TI+J8EBiryuhknA6VwBqbVJzSwmcMDVshSfXoQdbq3gIS7yIzDXdnp7iE63EZHEpiijznQCNmV+G3Wr/XyBPQPBZGYU6jKiK4WnarNT+dlDniRgoIKOI8lN2fqteWSMCM8ZCfrRw38W0lyErz76DYH2A1f0D/291zcnHeCnuBKBY4XaVqC5Op7JEFIWp/w8jsrvfJ4/80dOnDjZCWeO4RTvZkr+KFHuKuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NE78f/YXpz08BF6Qmfnunlk/cwIeJLJnTmW5hBK860o=;
 b=gyTnYNlkJlJc8oSqNVbSAhty3fJSUKNSJ+JkVAlKdvom53yqaFc6QhMdUVQmpec0oXYeYmoe4Z7NPrCHwKt+T4Aqc91YB7xot0O4MoUHI/3EkN7QoaWkBLrCd+fPCyF/pZDOXVbjbob6Y79Dyhkqa+43gFcruGNlbaHC4Ibs1TMXTRHcQP6ByBvzecfGtsIhresulLKW1TT7TklMVzRNSjv0crxBtYUNDzBpehj1ixkr/FOOFEeaDVamCMy+OhGYWMXlz8ETr9cNzJfZ6fLMQDBF3e2haQjf0YSq1fOdg/SinsOgCc2Yn/NZm97jEBlC99uxhJMGKJo5kJsTXxYbRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NE78f/YXpz08BF6Qmfnunlk/cwIeJLJnTmW5hBK860o=;
 b=DbqzxvKiQ3Ri0Rjh9NPgZZypjFLV8pHg1TnjiumGXhFI4Ps8H9/YWcWaHTbT3X66K8hMS4EYz/OA1mXUaPMvFiEOIa7FnQICP4NXVINWhTFzUvx6TXdMrbBZcc33wTf9ZuLVmbL+hICiqgNbUX+0I8VNpvVdySxh/RjjPN8gRBU=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH3PR10MB7435.namprd10.prod.outlook.com (2603:10b6:610:15c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25; Fri, 21 Jul
 2023 20:22:52 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::dcb0:4077:f404:210c]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::dcb0:4077:f404:210c%4]) with mapi id 15.20.6609.026; Fri, 21 Jul 2023
 20:22:52 +0000
Date:   Fri, 21 Jul 2023 13:22:48 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, willy@infradead.org,
        songmuchun@bytedance.com, david@redhat.com
Subject: Re: [PATCH v2 1/1] mm/filemap: remove hugetlb special casing in
 filemap.c
Message-ID: <20230721202248.GB5659@monkey>
References: <20230710230450.110064-1-sidhartha.kumar@oracle.com>
 <20230710230450.110064-2-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710230450.110064-2-sidhartha.kumar@oracle.com>
X-ClientProxiedBy: MW4PR03CA0148.namprd03.prod.outlook.com
 (2603:10b6:303:8c::33) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CH3PR10MB7435:EE_
X-MS-Office365-Filtering-Correlation-Id: fe0af17e-c3f1-4d3f-fc68-08db8a284283
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sW6HV5DvXgADrElW3bVNffmr0QZImamNAPyTEmoMG8LrPTxLJ7AZpNoAdz0Z3jOCifGKRjvR8pWTDeNfCQsPkgVICaMNnwQmQ9yP5YX0gjd5hfvIaRhyTNhvPP/xo91PoJbp+rdB4JuGQNiDBmnedcLCTDr5iamoPI1e9cP2T7Zm90fEEl9tnyohu4Vtyg/HwRW25eVhK6x+mLm5akt6kkGGohgKc6dbjnkZ2n9FlR6H0xRXF6Iz5tpsqyq4uLUCmpifeM6bseam9kcIFhfUOj5fF9DZjzf9z/fHgBGaDayZqd1MOelqQ0BgngDPOZvEzN99GuPDqmvd9RtI6GQzmZjV+qh+Hi+RFLo7wEAunGAVOiJ9sWK/1g7Hjj5a39C+HbmaXZ+l07vV8iJGBDyPjYy8WWlA0ELEqHhw1eM5npvksls537VDCXVLVa/J7AhYE7oKQHfF8kYMFzuHcr/Nh/ejBZd6CaY4MfqTATCwZuYBQvw6hpI45pBRYNVOiorPJCjd0ZGF94YSYCSsFNyn4aRXzRnLDuLOFF90c8qK8GtxBxvEnUtEwitIF/ZYfy4n
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(366004)(136003)(376002)(346002)(39860400002)(451199021)(2906002)(83380400001)(33656002)(33716001)(86362001)(38100700002)(53546011)(6506007)(1076003)(9686003)(41300700001)(6486002)(66476007)(66946007)(6636002)(4326008)(66556008)(316002)(26005)(6512007)(186003)(6666004)(8936002)(8676002)(478600001)(6862004)(5660300002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xf4Pmzz7tRgb2cZTOtdcdb2Cs/ApaGNcp0UxDcNiPfZquhqFQcPADW+sP4Nu?=
 =?us-ascii?Q?hSl5836zI1Ek4szuoReLeUWtUIRRJehToibA07lyXNeQswv0jzZei3UEL5BO?=
 =?us-ascii?Q?W1bQz6b6upjuNdXA4yT48cd0y356xcFZyVrzn6MvjeCZ+es6L0s4Cq455CzE?=
 =?us-ascii?Q?cfh9GUz/5zIw+aA/g+HteDVvroj+hou8xEVp3E3IaXnATbtOg6ciSpVqp0RR?=
 =?us-ascii?Q?7ypVLHy4JbxpXogrJJjd16VadiJefuQdzsXAnOvfurwSmsgaYZXWkNW2xOZE?=
 =?us-ascii?Q?U35f2KIJxBylat8VGZlB4eDCtgdlmcr8NQ5H0wM/yZeayPXlo+F9IBugszg7?=
 =?us-ascii?Q?D3aPnVW5LcYYAREyv39MIHY/AGh6ngx2kH/9qQuIlx3f2qdKIiALif6huy+g?=
 =?us-ascii?Q?KQEPcerPLygVp9xG9sHLqT4SuKJu8z1jLcoclFL3wpnFCfEcYoo/vUvB7diS?=
 =?us-ascii?Q?Lppk6JI4jodj/ctlMWO5URtLWmXyYJZjmSbTUCRD8dICdA+olOkKD8o5QRH3?=
 =?us-ascii?Q?RqNViJ+SBBulIvyPq7IQAx8iPxUaHl157wFOWIRdWIVBxyYPyxItjzfUcKEq?=
 =?us-ascii?Q?HwcGVy3O1tge7v1NrTxF9C0YIchzI2LIDamed6ABj3cqSr47DdDX9PB4SbqB?=
 =?us-ascii?Q?uI/OvjJLKy02QRpR2SsFdCUSwS0UFZV0z1l4O5UWgT/YPuTjFm6m3zKAWdnK?=
 =?us-ascii?Q?C7sltH+3xv4tx/lCIWjQ9BbvNn/KBHQy74xMDackHX9Dg1uHPCyJIHwyKAiH?=
 =?us-ascii?Q?S45TXQlV3rfqmRHz3odm5ceazch/5DLQ3YRie5bOIgKj+58PU/saA5+QP7nu?=
 =?us-ascii?Q?hfjS/NtVUphesbdPxoz9fcFjjOnlX/gfjvaMQypLs32mEgJf/PtX92ct2CsR?=
 =?us-ascii?Q?oVH0lONZl3koRscMEjiRxAN1lBRFZ8KZMBXRufbNHsjbyDm5flI+zqGqixA7?=
 =?us-ascii?Q?p8uUGNlR0wXHrVxsieoKpSYMUdL87Y4/IDtij0VAE6iSnBxB2bjUDVQ5l+1N?=
 =?us-ascii?Q?PEwE5lf6OGi7S88xHcqm9oCxVORCKguegROsU27F7a3cs3CEKVUBYnIlCiNi?=
 =?us-ascii?Q?g4krF5Si68Gzjv4SRimv2AxFlRz/LjsgG7ijHD1t6c/Jj9SZfxgiScty484q?=
 =?us-ascii?Q?kH9DwtLFhs8NQaA9R31BwVTtEGaKfZDRBA5+jYTXpzM/X0a/GxUH7aE/Ipm0?=
 =?us-ascii?Q?vDx5H60njEbqzSychBzPKVjjEGqcKZpU3NPA4/8lU2yz7SxjxtzIZdUCoI1w?=
 =?us-ascii?Q?xxaXbM2sTSzPI9nRKQq/2zYgStYNIHNottgMRIQHlJZd81RnKrRIRfXG8jvx?=
 =?us-ascii?Q?1Rdi9D8/EwZ8iRnEkEVBj491BElnBlX1uhNQR9PLK2l1LwjlMBm7K/2zRRK0?=
 =?us-ascii?Q?2yhD2EB3jHwpS6zb47PSK0j2fZS9yXEGXxb7b1+dNAS6nmtEN7681qkW4XS1?=
 =?us-ascii?Q?ikn2jQ2uPkmJfDRqOGPjeMvUkDezPPVUH+zk0VDgPCPx7UTmdzlLMWRwfY9c?=
 =?us-ascii?Q?dD0qP7DTr+vJpvRQuxCUGMhKUqehrVarxwmJy83oMsiNLE9ILJaV/EuQhjuB?=
 =?us-ascii?Q?IX7SkhIk9x/IK6ECm0swxBetPFEi5eCf+5LkEnQq?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?8zanmKqUeRz7dwWe64HM0HJhmrRnJC/mOd57HvC7y2CrZnzoFuTDH5ehahba?=
 =?us-ascii?Q?SH+AIoKvQSt0FR88IMFiEDhjJ3jn+0sK4PwmKveCrfGGFODmGNDUuWr48BME?=
 =?us-ascii?Q?vXAFQUhfdyTNk4XOXeT1d3TvreiXEcKYJ4m5MADa/e2tbzrifOmruhXA8g14?=
 =?us-ascii?Q?Q1bT8t93c/j+RqpcpTJ2RrJBwvQkKb9QKhSwcMclZ9QQZ+Rug/faTl2+oPGw?=
 =?us-ascii?Q?yqB0g6ta3f/wTgy4Js7Zhx1ScVYMyrvbq4ueFR1V7Umn3CfLhNMQMkwXUQTx?=
 =?us-ascii?Q?IvI/h5umARSiD+biqKRbg73ZCC5iU6bsRAb6H6GcxCt3TsFpKmPdicmY6yc6?=
 =?us-ascii?Q?FU7Q2KG3R2EqTSHVeUtNn7sWigBMvICht1xAMDwJaf+4h8MfJOQS4y/gR9Kr?=
 =?us-ascii?Q?f5dPxOyBF9G9ZkC2MterQhjKYvkcn/eS/wnz+WDKNDzA6uq+oISe1zqpfjse?=
 =?us-ascii?Q?UcfBQiniYLDomh4iHHMwdtZtygQFHTjyEnmIImEz63jQBU2Oi8dJangG4P9V?=
 =?us-ascii?Q?xVKkCvZT9pldZTcziJDNm7/7vI0IGFCCShJiDt3oWKWaeCve41+An9OTyTf1?=
 =?us-ascii?Q?/i5wl4fmY9DgCTmB5M0usGbemY5elveo5FJi0O9ZptQP/+mYgWXobkgzjldB?=
 =?us-ascii?Q?QPPeTMQrqBuZRc9hSqJda37QhscJmWAzw6EYsXYDH6Qahi9+EhFuok8Kxn4p?=
 =?us-ascii?Q?X+QwgZWx9H07lIw3rQLf+tp0m3cRDmlhAwPoYLgeCzXUx0B/74QttK5q+bLG?=
 =?us-ascii?Q?uC0oolgQjQK6SP0CsajQU3rbprjZ6IR0VITWEDFYl5JlqLH+R6TqcDXZPDgc?=
 =?us-ascii?Q?sPNT0o0ARljpqXiOBIO/W6JKUMHA2uvNAOQVsb8RpJ8wQX2tuiJ1sO++dkrS?=
 =?us-ascii?Q?QTZ14Q3xQP/JmvhvKelTGgzU2RY9jaPkbYo6bHhWP3o1FMIjKGtImLOfPfss?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe0af17e-c3f1-4d3f-fc68-08db8a284283
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 20:22:52.5989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yhIKb0r03VrE/rjxfcsH4ayy3x8PO8SDzsSmE4gJZWmIggC2mWNDNCc6BLxipuZGRfypDv4R2hurHFfxCVGoSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7435
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_12,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307210179
X-Proofpoint-GUID: MTCMWOAHAotSku4_y_DIlF5VwRDl_dEy
X-Proofpoint-ORIG-GUID: MTCMWOAHAotSku4_y_DIlF5VwRDl_dEy
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/23 16:04, Sidhartha Kumar wrote:
> Remove special cased hugetlb handling code within the page cache by
> changing the granularity of each index to the base page size rather than
> the huge page size. Adds new wrappers for hugetlb code to to interact with the
> page cache which convert to a linear index.
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>  fs/hugetlbfs/inode.c    | 10 +++++-----
>  include/linux/hugetlb.h | 12 ++++++++++++
>  include/linux/pagemap.h | 26 ++------------------------
>  mm/filemap.c            | 36 +++++++++++-------------------------
>  mm/hugetlb.c            | 11 ++++++-----
>  5 files changed, 36 insertions(+), 59 deletions(-)
> 

I still want to see a better explanation of the performance impact of
this change as previously stated.  However, I did take a closer look at
the actual code changes and could not find any issues.  One suggestion
noted below.

> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index c2b807d37f852..d78c71dacf0d4 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -663,20 +663,20 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
>  	struct hstate *h = hstate_inode(inode);
>  	struct address_space *mapping = &inode->i_data;
>  	const pgoff_t start = lstart >> huge_page_shift(h);
> -	const pgoff_t end = lend >> huge_page_shift(h);
> +	const pgoff_t end = lend >> PAGE_SHIFT;

The code is correct, but when looking at this it 'appears' wrong to have
start and end in different size units.  start is only used in the statement:

	if (truncate_op)
		(void)hugetlb_unreserve_pages(inode, start, LONG_MAX, freed);

So, to avoid confusion it might be better getting rid of start and code the
above as:

	if (truncate_op)
		(void)hugetlb_unreserve_pages(inode,
					      lstart >> huge_page_shift(h),
					      LONG_MAX, freed);

>  	struct folio_batch fbatch;
>  	pgoff_t next, index;
>  	int i, freed = 0;
>  	bool truncate_op = (lend == LLONG_MAX);
>  
>  	folio_batch_init(&fbatch);
> -	next = start;
> +	next = lstart >> PAGE_SHIFT;
>  	while (filemap_get_folios(mapping, &next, end - 1, &fbatch)) {
>  		for (i = 0; i < folio_batch_count(&fbatch); ++i) {
>  			struct folio *folio = fbatch.folios[i];
>  			u32 hash = 0;
>  
> -			index = folio->index;
> +			index = folio->index >> huge_page_order(h);
>  			hash = hugetlb_fault_mutex_hash(mapping, index);
>  			mutex_lock(&hugetlb_fault_mutex_table[hash]);
>  
-- 
Mike Kravetz
