Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8B37B4B16
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 07:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235426AbjJBFXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 01:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjJBFXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 01:23:47 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631D8C9
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 22:23:44 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3924OqgI018763;
        Mon, 2 Oct 2023 05:23:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=vZNB9GpbkqxbOvlCqw3JTsFkLP6jy2uwLvRDGawjJl8=;
 b=jrDq5Dn1/rpelNtDHHsYxH0FmoBsEK/tyHOPL/QjfsBT3Ce9FoDu1lbkTy4BjveMNp9I
 wx/OdpGEePwNeP+yP8Y6SW/VgreyL93Czuw9H4Y+VewLJsEMRzhxgHA6LWlZtPq/QvPr
 kepy3nKyH13AGF2OKS2JRGhn9TH5EktxNS2N8aByRMBK3mrDwpz31X4J0kJstX3Yutog
 Xc6S+AGaBLGua/TRfchqJm8AWXvYGk03HZcI31bMYYleSK4mnWJlj7rsdFCjl9BnRdge
 akS4BZaWST1Pd00UEI7BwD2cgHmLwAmX/HJY3j8ZKSFU5hFapPyTtXVRvMq14hirBFOd eA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tea921t3a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Oct 2023 05:23:20 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39238sLI027257;
        Mon, 2 Oct 2023 05:23:19 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2042.outbound.protection.outlook.com [104.47.73.42])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tea4448u4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Oct 2023 05:23:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MYqh+lrKV/DdNwozDMGbPezg00qhnkurnaCMhmNBclg1hyFgez+eise5kYkOYYO7cYUKe5+8NPU7zWJOTINrbXCsSpbaYgLFfcSesRRq3XdDOSR7HnZx+9bSUJ+X4D3t8wLLU3CZWWsKkxI15mfMQdHQUlnTpn6KF4lwg3XOp6J999qsi36EvrJ6ylcDQsZEni81WUgxhNuspXwrjZklqfrERPLd6y/VDzmoY6ehQgoD92c2m+57akJU7YS5KPGkQ0BFPTUbZIrNvEIXG5CDSoorO2re5NG5A9UKbBW6azXWfgBfUJwAq+eQNGOqWrovgiOUFAWS/Kh+7LT9MuYOXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZNB9GpbkqxbOvlCqw3JTsFkLP6jy2uwLvRDGawjJl8=;
 b=gzBunbTkIuo+t7SvRka7QIxglAGi9Ppsya+oJG4621o8PZpLZE+MpPyTpUPSPNaMUl6d2rd5oB7uqGZ3WIFpolUzqM6yfQMoocMqJHZR8SkAq/HVtD2bf5LsTE8n6x9GO2ur4Vn1jVkP5NkscVAI54WObK+P87AZvWl8yosnDkHkOvehjppr+Ln6JQTB1L2JvPBxvdrIcOyGwjY53BrJy+3YXyJjvtAQemxFnFpGTLs8S24zgkr7LmyY+a2m+pvz11qf4zX+KrourmBNpuE7CriYfSWuj67gz6001R3+tCKIaLKffUdXSt3ELhB5jXcvvhSmSFpwqr40IM2WvEuFGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZNB9GpbkqxbOvlCqw3JTsFkLP6jy2uwLvRDGawjJl8=;
 b=G1PaH5DWtQ6uBG7pj9hfjOHC+eb309j2nAp+R3GEPwE0HW8WZjkJ6muAP5XbD6FMJDwvUFfx6xWGKeXaxwW7S7TDp4ZBTN79zoGjjjy1axu2bXMA3FW9iCtSYCz8cFt1wai3qUi5UgRRJCkXS84SsogBn/RRG4bti+fRhPQtXYU=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MW4PR10MB6369.namprd10.prod.outlook.com (2603:10b6:303:1ec::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Mon, 2 Oct
 2023 05:22:49 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::94a0:adfb:6474:63bf]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::94a0:adfb:6474:63bf%6]) with mapi id 15.20.6838.030; Mon, 2 Oct 2023
 05:22:49 +0000
Date:   Sun, 1 Oct 2023 22:22:42 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     riel@surriel.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        muchun.song@linux.dev, leit@meta.com, willy@infradead.org
Subject: Re: [PATCH 3/3] hugetlbfs: replace hugetlb_vma_lock with
 invalidate_lock
Message-ID: <20231002052242.GA103993@monkey>
References: <20231001005659.2185316-1-riel@surriel.com>
 <20231001005659.2185316-4-riel@surriel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231001005659.2185316-4-riel@surriel.com>
X-ClientProxiedBy: MW2PR16CA0001.namprd16.prod.outlook.com (2603:10b6:907::14)
 To BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|MW4PR10MB6369:EE_
X-MS-Office365-Filtering-Correlation-Id: 29c98788-5a77-453f-b5a7-08dbc3079c19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BS/uAtHliew2Hg+gXhA33ODekit49k65oSA8b7lWszLtb/z3CeTRLeqmldDmeSRqIlq6dum1qb29wYjUk+boA2BD2P3g6ohQpdQRVQIB2XMCuJ3B3YFHguVTS7EPTXVrZOGI12Z18UaVDJIdGMvIUsJLbAwHsCAccn0hrOCC/r+8f2WEB0L1qmc9D1eEUoE03FskDH+bG4q+sIVgG0KP4rkz+oQzZuf8s+pHiaMtfqcq4MFJfLvY8mknxD5KnjXzqEnccLp5yQ+b6PfFSEn8n01a2br/BsUaZAcwleYWbj0fBPpzRH0dY3GOZhtgOKP2U4lpIMAetT6q+CDJdwQ9EgRXUhnPyj2oyx32/k7TGFjCMyG+NRarpttHyJDUVw44H1gOK+Xi58Prz2C0W/1qwW7BDQQVRkAcAihWUSyqOcexLmBTIAH2eHZjUWs4eSL8SEuJqcMpe1x7yMAaGpjs8Xjuo0wEpAIhci4hs+0S58bFdgdy3pzZEsMhdGkY3Y2wrDylc9evbfvAeKmdsCdzZE0uh3EH7HU/q60e0IcaTCcw0Yw10JQVEry7gDUde4kK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(346002)(376002)(39860400002)(366004)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(26005)(53546011)(5660300002)(44832011)(6506007)(2906002)(478600001)(33656002)(6486002)(6666004)(86362001)(66946007)(66476007)(66556008)(6916009)(38100700002)(316002)(8676002)(8936002)(6512007)(9686003)(1076003)(4326008)(41300700001)(83380400001)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0jTSB2v8Od7oy5Ky9Ppbq3WwcPZGndO3MCd23WyulYQFjoJfmtLQmT6Xhwat?=
 =?us-ascii?Q?LVNScly5YVRMtVKUF2159pZ5m5VQToS0WWtiJMP4ncMNhVpAM8NcrTWybeMw?=
 =?us-ascii?Q?hlXK8EghWeSiFhrqKX6FZrxi4ugN9hePNrJn/Yv79mIC4H3R08pqSNw6Ruyb?=
 =?us-ascii?Q?n4uo3VcAz+dBk2+1nZ4YHV0XhFpYEoeEIv6ohlYTmtz7VTvXs21gHnFLzrTS?=
 =?us-ascii?Q?OsUPJtEeHGC39+CBirgKBtkAmw4SXdA3GLvczZDA+erXqNgKPP+EYumMQxe8?=
 =?us-ascii?Q?ggBf2NifPooWKP7s2umPQkNGa1eBSOmtoQXt7SWYUXE4YlTjKaXadv/4r1+a?=
 =?us-ascii?Q?bEEhxouHRrUeTqhcRxJv+WSfNwPR+xhgO0RqKYAWJKJIwbwKmTxNTYZg9Q2n?=
 =?us-ascii?Q?AnhJqFJgc5G9I1ZSKoWysujlOjrNIc2Wt3+wMwLIxgoRpHIOHtj/wIQ2Zoj8?=
 =?us-ascii?Q?0mm7/sDl/Ez1OWj7ZmJkbdyyHZikLCoGOAuzxRajr69km0VK81vHIhV+LYY0?=
 =?us-ascii?Q?FKq0c4uhCdo78uFZo6yseG+nor+xrX4hmoTHnIt6qSxvFQlIyiPn4JPYcV3K?=
 =?us-ascii?Q?TFpnTvbVLxrZFzuK3qdnHeY8XInIvOmVDemour5dD3m2wE/6WjpJeFFHOwSZ?=
 =?us-ascii?Q?CWZKokx8X7BG01FZ3viwbPHQm4Ow6piu/O8zHi5ugU3e/fQk6ffGKgdW6oJ7?=
 =?us-ascii?Q?DgoIWYbf1BtFFHxZtCKKRzCAnm7H/tOidh08xEAo1roLFVpJyJ5XzP59hGym?=
 =?us-ascii?Q?Uchyi6IvRnUc9oJUf2kCGv1ultiYeRluVzIjQOfR38RCj/G5/3DLvHIO6ros?=
 =?us-ascii?Q?6Xh2wFMUVN0frPEsQV9PYBW/4efGaEwVzuMHtTLKAPBQcpnY4oGKk+g50Q0W?=
 =?us-ascii?Q?rD+nftznBs1SsvAAB2eTkDm5EcR9O7i5nJDKNV3DgCfeWG/JD04U86ANYfn5?=
 =?us-ascii?Q?q5juIKgqxWNitDxpLA2Prrgh6+BMqfNMalwC+1i6MCaeokUy9yuYO3shCcRJ?=
 =?us-ascii?Q?dAW5LS99djYYD5ckdsycA5JsbXlS/glW3wdha1nKdDmCqMbMonOTc9CfA5/g?=
 =?us-ascii?Q?L3T9umjK+xibenoRYXHxYbDi54kXg1o41GfM2CbV+clw6+OpFX5BWGn9UZ5o?=
 =?us-ascii?Q?NqyysEGTV1XOwITNQ+ZBc4neIhRmWHWfGZq80+78qrQNlY8udJP7Im7CMETe?=
 =?us-ascii?Q?3uH3XwDB5C5v3oFL1dO/kdtQPsuc0KRBi9UHXv+V/tJvcynsZmGVjPLrCt6K?=
 =?us-ascii?Q?ie9hfrGQeay00WicqbSfXs7pZtTHkHarojagxLYqgG7G5sojrecMjxr7na3x?=
 =?us-ascii?Q?tQUke2iXZHxIu+PE86WqyLrbHrcI+lrdD03+XNMKpbxqCAc08KyPYjYIU0rS?=
 =?us-ascii?Q?CdGcaZPrKJ3qA4IrfLAPq+2MeN0QOSdqgl7TFWX6GK5oBYeYOOdL6Tz9ut2b?=
 =?us-ascii?Q?FSYRRCPD+puszHHqImfYbeQH1mCBV/gguSAwiIBKn0msHCRaNJw0IpZfoViT?=
 =?us-ascii?Q?2yjRavjTjdYXaP+Xo7rlSeHo30tyneplzpz1xFdbWS40GGjPFh0X6+MZxtay?=
 =?us-ascii?Q?7aVMQBBgyUM+M9/BXUHkipfGc5asSSIO/Vifn4xG?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?32gtp8bDKtmIz7gX7fQOiBBWg2LtX7hS9U5N5cx2s5Df8ab1dXOj3P4UA7y3?=
 =?us-ascii?Q?aPjW3gGjuwifLh7iuuiu+YGkHS9CQ/Bo1abaUe3b4kQVYsGoiQ0SFDdo3WWv?=
 =?us-ascii?Q?ktoNemsC5Chhv3u3gAqIMUQqN5J17QSsyH0qH7vJ39xX69p61MC/kvhM7UQR?=
 =?us-ascii?Q?DRb66nbrtWhK1RKJLYAC+7GuiRP78sY/AdC/KCmbZg/HJTXGCv+FIKYcbcwt?=
 =?us-ascii?Q?7RMaVOP4EfF/D/c6iAj/H71sytydgOKFwr5BwENFWzqUQMl1eNtXldPjvKzL?=
 =?us-ascii?Q?Nzi+pxYn9PlwBQ43TFKgxS7BXVsAbON9RA+yiHYI5GchuMJbAYwp9HnrN+qF?=
 =?us-ascii?Q?mFcqzoqOYXrQi3qSMsNQpZea2ihed2z+9+106EXKU2Y38Uq6fEUlUEUxsJ+j?=
 =?us-ascii?Q?5+gMqmBkyxqNEr5p3b3vd+M0qEoUvoIFLMp2kgKx/hf4lzFUBBFTVgQ6/Q+w?=
 =?us-ascii?Q?IWkVmPPtleThBGnTIjIHZMyD+Pif4llnvRzWJPjTxBKx5LvXUnD3wSa/OYjx?=
 =?us-ascii?Q?vyvEVPP0kurKONx0XT3KAdLfGvpE4+w9VfZIVEdNQSr9hTGN0A0Ngaz6UWbc?=
 =?us-ascii?Q?59c7w4Lc94qCz7ETs1rkN+3clkuwY8y1yeXUYPOeF+OcdN1MG79XgOGdna6j?=
 =?us-ascii?Q?d6XCE7tVlnqW9O67iB4Ocxa61e1mYtEyw4OMR5spJOTqxCYSSiZZy2ixrz8x?=
 =?us-ascii?Q?lIykcUN2rOzF0HKyuhayDwT32aPZuuJJMPibtn1pKQEaqQrit8A49VFbnz+O?=
 =?us-ascii?Q?fzvO4LR75O0NFr3VVMyHuup/HPj1H6Z/vJycCEoUuHgiCiqzYbU6spttk81U?=
 =?us-ascii?Q?+qgvpbhTXrs7S89eKfGaFcnsaGjWPrxYsXxUNhiVyCoiD9q1CgmVj78tvoxm?=
 =?us-ascii?Q?AuWbbtfkBfXn13pGfQnBwQ4a+NAS1DoCTZZRYkGE+jju6Yoq4yobzArxPn7L?=
 =?us-ascii?Q?r4vfEp2L+SLSmFrHyAJTfg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29c98788-5a77-453f-b5a7-08dbc3079c19
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 05:22:48.7365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GdR05mQNoYC+oAsbkRzGEjemHmUoyWvDEnCSdXPIxViLV3dwKcyXvuleZuiOHmT/9RSra0hVYZcmapxQnA67KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6369
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-01_21,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=609 mlxscore=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310020042
X-Proofpoint-GUID: SPVQEJsZo7DASeVV8q2BAhDAAw8BakxD
X-Proofpoint-ORIG-GUID: SPVQEJsZo7DASeVV8q2BAhDAAw8BakxD
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/30/23 20:55, riel@surriel.com wrote:
> From: Rik van Riel <riel@surriel.com>
> 
> Replace the custom hugetlbfs VMA locking code with the recently
> introduced invalidate_lock. This greatly simplifies things.
> 
> However, this is a large enough change that it should probably go in
> separately from the other changes.
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Rik van Riel <riel@surriel.com>
> ---
>  fs/hugetlbfs/inode.c    |  68 +-----------
>  include/linux/fs.h      |   6 ++
>  include/linux/hugetlb.h |  21 +---
>  mm/hugetlb.c            | 227 ++++------------------------------------
>  4 files changed, 32 insertions(+), 290 deletions(-)

As noted elsewhere, there are issues with patch 2 of this series, and the
complete series does not pass libhugetlbfs tests.  However, there were
questions about the performance characteristics of replacing hugetlb vma
lock with the invalidate_lock.

This is from commit 188a39725ad7 describing the performance gains from
the hugetlb vma lock.

    The recent regression report [1] notes page fault and fork latency of
    shared hugetlb mappings.  To measure this, I created two simple programs:
    1) map a shared hugetlb area, write fault all pages, unmap area
       Do this in a continuous loop to measure faults per second
    2) map a shared hugetlb area, write fault a few pages, fork and exit
       Do this in a continuous loop to measure forks per second
    These programs were run on a 48 CPU VM with 320GB memory.  The shared
    mapping size was 250GB.  For comparison, a single instance of the program
    was run.  Then, multiple instances were run in parallel to introduce
    lock contention.  Changing the locking scheme results in a significant
    performance benefit.
    
    test            instances       unmodified      revert          vma
    --------------------------------------------------------------------------
    faults per sec  1               393043          395680          389932
    faults per sec  24               71405           81191           79048
    forks per sec   1                 2802            2747            2725
    forks per sec   24                 439             536             500
    Combined faults 24                1621           68070           53662
    Combined forks  24                 358              67             142
    
    Combined test is when running both faulting program and forking program
    simultaneously.

This series was 'stable enough' to run the test, although I did see some
bad PMD state warnings and threw out those runs.  Here are the results:

test            instances       next-20230925	next-20230925+series
--------------------------------------------------------------------------
faults per sec  1               382994		386884
faults per sec  24               97959		 75427
forks per sec   1                 3105		  3148
forks per sec   24                 693		   715
Combined faults 24               74506		 31648
Combined forks  24                 233		   282
    
The significant measurement is 'Combined faults 24'.  There is a 50+% drop,
which is better than I expected.  It might be interesting to fix up all
issues in the series and rerun these tests?

Do note that the performance issue was originally reported as an issue
with a database using hugetlbfs (not my employer).  I did not have access
to the actual DB to recreate issue.  However, the user verified that changes
in the 'Combined faults 24' measurement reflected changes in their DB
performance.
-- 
Mike Kravetz
