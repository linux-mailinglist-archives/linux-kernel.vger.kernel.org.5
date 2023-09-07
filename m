Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA966797C0D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 20:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244761AbjIGShw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 14:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344280AbjIGShs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:37:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C571D92
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 11:37:42 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 387ITxVY001200;
        Thu, 7 Sep 2023 18:37:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=E8Cw1YIQDRgBj+Q83hG2a2ZJuUbxzlVAlK7XcwLMcnw=;
 b=tI4mJQE0KyMN5HBP3WuOdO5XiJ5atrNwaxt8NrB/6r6bCtgzIpLx9Z23hkcWekn/Kvgd
 +PV+hW01nRorJSaX9uWQil8vlIsUAU+8v1dLEFWSrSJi2wr02LsCq+Sg2UxGcxwjUuxX
 YwFIR6wwBnNQSEtXEfNXT6JJHGcvwTgmoPcPWZIpMtQay3wrfe6Or5PvpMi0o2Iad8Dm
 iOfCtRV/pogQSO5kPNbn2KNNrDS5HHKpw8U49KKFP4Y6OlBvul9ISI76eocDLXJcFInu
 1Xu6f+mlZ54/ZTmX8EllnsESY9WlqL7wM4gsCJvsRr9ubVZLqLFmWTFVACtaG2j85HnY xA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sykun80ww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Sep 2023 18:37:19 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 387HDjjs009331;
        Thu, 7 Sep 2023 18:37:18 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3syfy0av08-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Sep 2023 18:37:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FMQSzra/a3Qs1Y3eqo3V53IaH+7yySWJ0UVpncgH+mS3gtYdFPkDWymy85qnkugEYrSpo2oiPQYRj/MS2VYaNCMkBrsB2ay75QWyaj2Iu+0wEXn0cQdp1WxCTFDaEUqGdE2CsNwcZK7rW/LirytqutpllpAWPFgrwsKxmhV3cGDDxpHhFoMyZW/ybGI/DDGg8+o+lFAoqlKXYmWcaJeHXY6Nu9MlefHwoxM13qM0/qkMMB74MNS4aV3IaJIP9ACynIcTZ3Pf8ErYKS1M4zrtdAlFOAAvhLugspYvG3W8C6HtDPeMUFedwTs1vKIGdS5U4SHAUl7s8TrtPrbEI59qzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E8Cw1YIQDRgBj+Q83hG2a2ZJuUbxzlVAlK7XcwLMcnw=;
 b=oJATm94s3Lpl+h80oJV5dcPSVdikl9J0H7cdF6TMK3W+TXhAaKJTZ64gHbbsPne7oXsUjC0PKiNv8UWn8rCPdtVWSEIuz88uTIBUJKg6LAeVwY5f/iAXqkDtBVk3KMEgF63GLPp8zmpZeO5PjDdgofJzQXVqgSDyg7Fy4Cusj0AP2MHLi9IyTheXDskmbKMDrv3rr6xanTWNR9vWV27PJfCIIzt1JfUlW1CAcRQTuseT31wi0rWqg0ztHG7CYXGHRiKZeDtU3fKzapQEEVONmc7sf5gffnK5LISI5mG2wYxL5eUOyNrW5Oh5zd+6mHTbUF5jr100Pq/cJs6qUPGq8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8Cw1YIQDRgBj+Q83hG2a2ZJuUbxzlVAlK7XcwLMcnw=;
 b=Gfl6CVAEKU6JHdwAF9NIUCjDgBGQzUMkjaHscGxnv/6MtI56tfguRPFDxo7ApCH5/jaD+XvaBHHTWIX558q1iDXiYdre4x9Pv2F68bJpjvhq7UAIFl0tsPHlLeBxh10rXXwUQVAtvF98CsAJ3BSH4o7v7zxEbkQSQMAteU2nUnU=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DM4PR10MB6158.namprd10.prod.outlook.com (2603:10b6:8:b8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 18:37:16 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%4]) with mapi id 15.20.6745.035; Thu, 7 Sep 2023
 18:37:16 +0000
Date:   Thu, 7 Sep 2023 11:37:12 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Usama Arif <usama.arif@bytedance.com>
Cc:     linux-mm@kvack.org, muchun.song@linux.dev, rppt@kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        fam.zheng@bytedance.com, liangma@liangbit.com,
        punit.agrawal@bytedance.com
Subject: Re: [v4 4/4] mm: hugetlb: Skip initialization of gigantic tail
 struct pages if freed by HVO
Message-ID: <20230907183712.GB3640@monkey>
References: <20230906112605.2286994-1-usama.arif@bytedance.com>
 <20230906112605.2286994-5-usama.arif@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906112605.2286994-5-usama.arif@bytedance.com>
X-ClientProxiedBy: MW4PR03CA0212.namprd03.prod.outlook.com
 (2603:10b6:303:b9::7) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DM4PR10MB6158:EE_
X-MS-Office365-Filtering-Correlation-Id: 20dbd768-6644-4c21-10de-08dbafd17594
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LXFs3BDmw0KE6hrZvmB78untFI0kWfQwr9KzQpEJXLIgHvRKQV/Z/5lVGq1oc5gwnSs/T1ABK7v234cLhJB2il6RMMgBL9ynPWaxTX1zy7r5e273RMwv1T/fGM1zhEtmgiRto+6P609eDRPpmK/6+3oz2FkuBnLdVEsG/yRJVcNqtYghg0dLZfh2SeSLow/cj7wKl47Fld6Im0utjBz+JjVOxCmdR8zg2LuQ/SZY56/vxJJs9TQoxtJ4corb6yfZA+GBkaY68zwyEqrMziPjxwiUoS7JA8PMTb9dl8seLtPPyvGvw7x9m/VbOoXgwzvETLsP0BptciryZ8IRJ184dFOttebrmSEX61+VGhXiGA1/FZhShC40RPI9n5HYELHuFoPqLXTcwvf6JqQs07RdepdddiRjK36ZtV3sAswdSRg/8PMoR4Ljb649kGAAq15aKCeVVBLcPJ3aiSkDIdaNKMWUxrHQtgS8YAgexoejc/OFtrfAUM8R+RELV4njCsCFb+NU5jgMdZSxpbRzX2LWxXMD2D894LRR9sEOIXGPMpedWz7fRham4MTcyq0PFYxg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(136003)(346002)(366004)(376002)(396003)(186009)(1800799009)(451199024)(38100700002)(478600001)(53546011)(83380400001)(6512007)(9686003)(33716001)(6486002)(6506007)(26005)(33656002)(6666004)(1076003)(6916009)(316002)(66476007)(44832011)(2906002)(8936002)(4326008)(41300700001)(8676002)(5660300002)(86362001)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MlqHVDcgC4akoSk9bHSxqjz3VlB//FSej1ndOqfkMjJNodmMsmTTFNEUDLHW?=
 =?us-ascii?Q?UED4U/Z9Zhz4FCjFMGlcJG59+TUaZjuJ3Hlk+ucAbBoBkaB0+4SwjUMsj5AN?=
 =?us-ascii?Q?zib+79Dw5bYLsqyIcoUHRkxbw9Gbcd7Eh58lpMDyouFyzSxh7zcERQReAqNq?=
 =?us-ascii?Q?ixxPcULqerFCbrg2y2A4P8Y0/09wWCAP/H5+AsSgOM2VTb5HN1EZQ9mgJxqD?=
 =?us-ascii?Q?i742KreMmeGNV7BMabF8D53rdM4OWRCTsuHYNcQoRtOTK5LE19YwgGLIXdRd?=
 =?us-ascii?Q?ifUCA1hMfEb3uZSCyDOakp6ENrkcvVyKxFXpxiTGZDW7ZhzSvRmAVQkzSdj8?=
 =?us-ascii?Q?Mx49d/kkifr2c+XX1qAqN3dNTMI8rqjpNA5XuHog8VSZbjCJxV8+W8yq6tmh?=
 =?us-ascii?Q?VK1RkdLy+8fMFZ70tcpz8SMprG8wPp/Y5K+ZmDlj+rl0ZFXzj1xjmcpgr+Ib?=
 =?us-ascii?Q?4cEB8b4wI+w9JETRYy0crLK58VirIbw0ckI5j7STAzBpby9ovbrkGHXmQebP?=
 =?us-ascii?Q?ufLxYDS4dGw3Kn1KG9p48jiHt9y6WVaqXrqjZrDHGxgFd30eR8U3Pyb894Fc?=
 =?us-ascii?Q?xw4CgNGgjqPsssEWWNeBwCDbF0XoDaMR7ZACQW0e362Rsc8HEnUjD2rxctSW?=
 =?us-ascii?Q?L9uXgAay3v3lDOQtGBovR9qe47R7wW/DiEX5UMO1q7q0TFGfJvLnEymS5Wmv?=
 =?us-ascii?Q?pCthTRZ2ZC65miUEGxz1JMeIR22LGt7CKdrGu+jfj2Qw0fcTxVkf5ULPcDfr?=
 =?us-ascii?Q?/dO++F9wY0KvvHGgiTqs2+A8YJs4u99tqgeX9UJYiRLVOBf/5FjJuEERh8OD?=
 =?us-ascii?Q?j9fJtJvjO12otbw+ZEboExdofs7tn/K76tor24ww45w1S8LHRNlXj78G+l/k?=
 =?us-ascii?Q?8L3cqvi5cPLrFDW7OMyx2ivSRBF46P755xiq5tQ8tIMlra+ggat7LI2J3IGq?=
 =?us-ascii?Q?J/DpPI0tuolLNhKzRSgYgO6OjFHKr6R41zHC8DGPUVlp4k+MykvsFJCpOYHL?=
 =?us-ascii?Q?X0762uvbdbWAUeDmd49t8kKiHJ5LGw3T/tu5VT+JbL8q9lvdR05Gr+Gh0vpm?=
 =?us-ascii?Q?piVyE57Wvrjpra28nYG7nfHpZU9ErFkdRLuocP8/H0MLmel/ZdcfTkT/QfSP?=
 =?us-ascii?Q?EwPLZ8F7uf7KlmLtfGIPm9AEI9JayUTKzX6CLgwx2aw40QQ/ybbRKraJFDh+?=
 =?us-ascii?Q?u0wPG1tiD7Gou5GxgnOE7/upopTtmtmtpLYEHCozk5YFgNcGKNUZZ/7TbHVn?=
 =?us-ascii?Q?XyoFr2Z4kcVEyBNw/LR9aFaS0ygcGJLR9hiEo5w/jCfXBxhxmrinHCZdsHEe?=
 =?us-ascii?Q?cyK7CD1uF4i9AOvUoJ0/XfFZ5IgjkgrHBYC7c0RJL4EhNJJXceNS9MEPV49a?=
 =?us-ascii?Q?ZyHPo4CINnY057GubUAd4Z5DKkLmRlxGCOj3nETTSZjPrpX0YyttQb+k8f6/?=
 =?us-ascii?Q?PBujumzbFywsb5qKvXkRCdc7FT6W83Z+BTUCbqFf2n+3QvBoiFHd/dgvyaxC?=
 =?us-ascii?Q?4XMX0fruJxaIq8r6LTOHz7rcJZsKRoJcjWiTIFWNh8WnsGnKCOjSdG3DGbXi?=
 =?us-ascii?Q?GwRTJZPywUC230cwekG9Bp58DjtD42cYg5UMqUu0rq6R35a0Kbvc3y0PJhfu?=
 =?us-ascii?Q?Jg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: on1aUFZuXjW0oMHGaekjluyc4gMReMIPAJdW/g6JvdSxb2LeGtLUW825dOrEe6SEvcEI2GXgq16GbKMxsAfvcrmg5VIacDMSf8lYJC4vM90+BZZvTBBnW11iroTwtmVrN10gVRCLbXyyOE9kz3nIEleZG58Ukw6dA8qmy/IvoQmIjU3ilonh38q05GV0nUcjEJBvUMg/g4Ozalpe3rsKB3bWcLN2O9gvY8mYnrjOxeL5I0iLc2TnFCagVNe8Jj/Aan9B7mjdICZe4zVTWzd50ydwkcKWZMcPJytxw8gYEld9F6uRHDPyekSgB1QsL+FE0JkBsPyl7GR4qrJokxLpofjZ1XktdxjymahfA4/4B+r4YP0YkFf3gSMBC3ZTB5vF+V/aB3jtySOq6G8bwdTm1xmQ4qTQKLrIgBkJYfz0By75bRFRaGojWaom48VzCdzPLP43lIHhCbefDaGdw2F1+vYYBgA2wwQl48Lk6UrfQxTwYr8Crw8pVk/B+1h9DXp66xI6sNGNCCHiG7iaa+htFklhIuZG4g3sfAObCt3PQjpSI9CMvwkk3T1khujpNPqEL//FMHALr3mIMosVxNXzr0l13lvEgKyWYIrbi9cClT/LGh3w1PZXbpBfrEfeQxiMOtUaJFWWf8p1+rIlourz0+iP8I8YtaXO2kRLH5XuMxzNQv/gRnC5AJY454uzKv6ZfaPEAV2PTPZzZZcb7gK8SmHp7cs9TxC3++EWbDt5pHsdKQF6KbIpbmDJ9DTiRsoDkdVpd2cVXlU59Ppvf0xn58wnUxoCwC6sVmKB9Yu5pY+zqtq5bg/VTWRNk2oOqMeKMf/rStoQVcbSqYhjjfVBHhhWtckHjaYobpbTwgBnD6f9Xm2tGnPADvlKmLNr3C3+FqptG9gj1BpTqFg+gk/T3wu7W1GhIY4/mAJGc/yzN8c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20dbd768-6644-4c21-10de-08dbafd17594
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 18:37:16.0306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 64ofjp1C3UgjnEZG81bKdmYEoB3ZD4GYPWp7aFV71af2aqL4Y6P4gGLc+D9fws2Gv2zIaL90BwyfastpWivEzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6158
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-07_10,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=920
 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309070164
X-Proofpoint-ORIG-GUID: A-UTLJBgVJR22z--m02x1rt7IZl35TkD
X-Proofpoint-GUID: A-UTLJBgVJR22z--m02x1rt7IZl35TkD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/23 12:26, Usama Arif wrote:
> The new boot flow when it comes to initialization of gigantic pages
> is as follows:
> - At boot time, for a gigantic page during __alloc_bootmem_hugepage,
> the region after the first struct page is marked as noinit.
> - This results in only the first struct page to be
> initialized in reserve_bootmem_region. As the tail struct pages are
> not initialized at this point, there can be a significant saving
> in boot time if HVO succeeds later on.
> - Later on in the boot, the head page is prepped and the first
> HUGETLB_VMEMMAP_RESERVE_SIZE / sizeof(struct page) - 1 tail struct pages
> are initialized.
> - HVO is attempted. If it is not successful, then the rest of the
> tail struct pages are initialized. If it is successful, no more
> tail struct pages need to be initialized saving significant boot time.
> 
> Signed-off-by: Usama Arif <usama.arif@bytedance.com>
> ---
>  mm/hugetlb.c         | 61 +++++++++++++++++++++++++++++++++++++-------
>  mm/hugetlb_vmemmap.c |  2 +-
>  mm/hugetlb_vmemmap.h |  9 ++++---
>  mm/internal.h        |  3 +++
>  mm/mm_init.c         |  2 +-
>  5 files changed, 62 insertions(+), 15 deletions(-)

As mentioned, in general this looks good.  One small point below.

> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index c32ca241df4b..540e0386514e 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3169,6 +3169,15 @@ int __alloc_bootmem_huge_page(struct hstate *h, int nid)
>  	}
>  
>  found:
> +
> +	/*
> +	 * Only initialize the head struct page in memmap_init_reserved_pages,
> +	 * rest of the struct pages will be initialized by the HugeTLB subsystem itself.
> +	 * The head struct page is used to get folio information by the HugeTLB
> +	 * subsystem like zone id and node id.
> +	 */
> +	memblock_reserved_mark_noinit(virt_to_phys((void *)m + PAGE_SIZE),
> +		huge_page_size(h) - PAGE_SIZE);
>  	/* Put them into a private list first because mem_map is not up yet */
>  	INIT_LIST_HEAD(&m->list);
>  	list_add(&m->list, &huge_boot_pages);
> @@ -3176,6 +3185,40 @@ int __alloc_bootmem_huge_page(struct hstate *h, int nid)
>  	return 1;
>  }
>  
> +/* Initialize [start_page:end_page_number] tail struct pages of a hugepage */
> +static void __init hugetlb_folio_init_tail_vmemmap(struct folio *folio,
> +						    unsigned long start_page_number,
> +						    unsigned long end_page_number)
> +{
> +	enum zone_type zone = zone_idx(folio_zone(folio));
> +	int nid = folio_nid(folio);
> +	unsigned long head_pfn = folio_pfn(folio);
> +	unsigned long pfn, end_pfn = head_pfn + end_page_number;
> +
> +	for (pfn = head_pfn + start_page_number; pfn < end_pfn; pfn++) {
> +		struct page *page = pfn_to_page(pfn);
> +
> +		__init_single_page(page, pfn, zone, nid);
> +		prep_compound_tail((struct page *)folio, pfn - head_pfn);
> +		set_page_count(page, 0);
> +	}
> +}
> +
> +static void __init hugetlb_folio_init_vmemmap(struct folio *folio, struct hstate *h,
> +					       unsigned long nr_pages)
> +{
> +	int ret;
> +
> +	/* Prepare folio head */
> +	__folio_clear_reserved(folio);
> +	__folio_set_head(folio);
> +	ret = page_ref_freeze(&folio->page, 1);
> +	VM_BUG_ON(!ret);

In the current code, we print a warning and free the associated pages to
buddy if we ever experience an increased ref count.  The routine
hugetlb_folio_init_tail_vmemmap does not check for this.

I do not believe speculative/temporary ref counts this early in the boot
process are possible.  It would be great to get input from someone else.

When I wrote the existing code, it was fairly easy to WARN and continue
if we encountered an increased ref count.  Things would be bit more
complicated here.  So, it may not be worth the effort.
-- 
Mike Kravetz

> +	/* Initialize the necessary tail struct pages */
> +	hugetlb_folio_init_tail_vmemmap(folio, 1, nr_pages);
> +	prep_compound_head((struct page *)folio, huge_page_order(h));
> +}
> +
>  /*
>   * Put bootmem huge pages into the standard lists after mem_map is up.
>   * Note: This only applies to gigantic (order > MAX_ORDER) pages.
> @@ -3186,19 +3229,19 @@ static void __init gather_bootmem_prealloc(void)
>  
>  	list_for_each_entry(m, &huge_boot_pages, list) {
>  		struct page *page = virt_to_page(m);
> -		struct folio *folio = page_folio(page);
> +		struct folio *folio = (void *)page;
>  		struct hstate *h = m->hstate;
>  
>  		VM_BUG_ON(!hstate_is_gigantic(h));
>  		WARN_ON(folio_ref_count(folio) != 1);
> -		if (prep_compound_gigantic_folio(folio, huge_page_order(h))) {
> -			WARN_ON(folio_test_reserved(folio));
> -			prep_new_hugetlb_folio(h, folio, folio_nid(folio));
> -			free_huge_folio(folio); /* add to the hugepage allocator */
> -		} else {
> -			/* VERY unlikely inflated ref count on a tail page */
> -			free_gigantic_folio(folio, huge_page_order(h));
> -		}
> +
> +		hugetlb_folio_init_vmemmap(folio, h, HUGETLB_VMEMMAP_RESERVE_PAGES);
> +		prep_new_hugetlb_folio(h, folio, folio_nid(folio));
> +		/* If HVO fails, initialize all tail struct pages */
> +		if (!HPageVmemmapOptimized(&folio->page))
> +			hugetlb_folio_init_tail_vmemmap(folio, HUGETLB_VMEMMAP_RESERVE_PAGES,
> +							pages_per_huge_page(h));
> +		free_huge_folio(folio); /* add to the hugepage allocator */
>  
>  		/*
>  		 * We need to restore the 'stolen' pages to totalram_pages
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index 3cdb38d87a95..772a877918d7 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -589,7 +589,7 @@ static int __init hugetlb_vmemmap_init(void)
>  	const struct hstate *h;
>  
>  	/* HUGETLB_VMEMMAP_RESERVE_SIZE should cover all used struct pages */
> -	BUILD_BUG_ON(__NR_USED_SUBPAGE * sizeof(struct page) > HUGETLB_VMEMMAP_RESERVE_SIZE);
> +	BUILD_BUG_ON(__NR_USED_SUBPAGE > HUGETLB_VMEMMAP_RESERVE_PAGES);
>  
>  	for_each_hstate(h) {
>  		if (hugetlb_vmemmap_optimizable(h)) {
> diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
> index 25bd0e002431..4573899855d7 100644
> --- a/mm/hugetlb_vmemmap.h
> +++ b/mm/hugetlb_vmemmap.h
> @@ -10,15 +10,16 @@
>  #define _LINUX_HUGETLB_VMEMMAP_H
>  #include <linux/hugetlb.h>
>  
> -#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
> -int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head);
> -void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head);
> -
>  /*
>   * Reserve one vmemmap page, all vmemmap addresses are mapped to it. See
>   * Documentation/vm/vmemmap_dedup.rst.
>   */
>  #define HUGETLB_VMEMMAP_RESERVE_SIZE	PAGE_SIZE
> +#define HUGETLB_VMEMMAP_RESERVE_PAGES	(HUGETLB_VMEMMAP_RESERVE_SIZE / sizeof(struct page))
> +
> +#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
> +int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head);
> +void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head);
>  
>  static inline unsigned int hugetlb_vmemmap_size(const struct hstate *h)
>  {
> diff --git a/mm/internal.h b/mm/internal.h
> index d1d4bf4e63c0..d74061aa6de7 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1154,4 +1154,7 @@ struct vma_prepare {
>  	struct vm_area_struct *remove;
>  	struct vm_area_struct *remove2;
>  };
> +
> +void __meminit __init_single_page(struct page *page, unsigned long pfn,
> +				unsigned long zone, int nid);
>  #endif	/* __MM_INTERNAL_H */
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 50f2f34745af..fed4370b02e1 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -555,7 +555,7 @@ static void __init find_zone_movable_pfns_for_nodes(void)
>  	node_states[N_MEMORY] = saved_node_state;
>  }
>  
> -static void __meminit __init_single_page(struct page *page, unsigned long pfn,
> +void __meminit __init_single_page(struct page *page, unsigned long pfn,
>  				unsigned long zone, int nid)
>  {
>  	mm_zero_struct_page(page);
> -- 
> 2.25.1
> 
