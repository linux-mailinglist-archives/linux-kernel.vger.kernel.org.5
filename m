Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574D07A1207
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 01:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjINXxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 19:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjINXxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 19:53:06 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9EB82100
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 16:53:01 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38EKxZFk029218;
        Thu, 14 Sep 2023 23:52:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=mXxW4Wa69t45xi5wg5fqqMDZzZiCRqHaXhMIfvzQSY8=;
 b=vUrQYhrMX4I1vU1omkvakKXWKqmCqBmwnnK/lA3j2gF2RYnRhtEDs2YetxMaJa35YEK8
 9cjgRRMKbqUtebMz4bD/H6t6hFdndHRO21mLLFTqXww+dL0jjkbNlr7ILzIZMxY25tPu
 MyIbiZjT7fCh199lEs8mIcONk6sm+EO8JatUyHgCFQVrXDKBmy9vJHzfHHim3YAVpxrF
 6DLZRb07tV3UkiSWooHk2TQB9WVSlp195+qE96XBDETYvLOGwNCuxe0YBs4LgBkyjvdx
 05AP1ZWVu0tugOn9nukFTXWaZBunXStbcz58HLJfHkE9aosi5xmLrgTx5gmKUrWQNAh7 cQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7res6c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Sep 2023 23:52:44 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38EMpeWe036235;
        Thu, 14 Sep 2023 23:52:44 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f5fmn1c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Sep 2023 23:52:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Beug+nF/TkT/ege5/XWrQlbiTTyXwjKk77Ky2j0bCqWiXnaRMAE+Hlz8ZacgwrUxQDCHC0A9/rDpzI/i9LyLz1BqMEOO5AfjRwH3EVffGbBJWQrixMFDCifsmKKy2bpOeNpPeK0g7osua91Brm8sfSkzcNDrHFaVoaGCTnwjsYOr/xLUqxgHksDg3IYZGTe1E4FnY6ELTgJ0ZbHMhhnsumjp6SyZf2BrB1p14oEtut9lBKmOWR3AjK1Cc0Gl3Rf/64tAv4fhg/3uVrYPnvrQYQZYSkTnsvsQiU3uWQFP0Wsx/MsGCLi27yDBzWdNm93itjALbjNYp75H3l9nVikYoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mXxW4Wa69t45xi5wg5fqqMDZzZiCRqHaXhMIfvzQSY8=;
 b=gKcVOT8RrAK/7oQXvM66vqYK9gPPuNu4bQawU4vp9Aom7owxDza9XJC2n/QJWGRno3+mXMD5YP3G3fSoYPAu/GW2K9NwlfiXDrbT163sSrROb+ukXxIKS9ae5VyM+tiQteaur+dSQHeIJmTfG9o9RyFRYp1xN7mb6T9LvMM6pEKN/sSyEwQD7a1/Nf4MT2TyQgFxl7LvsOSYGOtTM3tECUzYhse02rGjJh8Vn8SFmO5SzpbdQDM3o7Cm/Twlu9DT8ToeFt99dPpR6o3e10seaR5DqNGSWCthOH792ip+8zBNUF/BUyW6xCOHZfSSn/fD6HeJZfleHoq2/5JWpT+uDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXxW4Wa69t45xi5wg5fqqMDZzZiCRqHaXhMIfvzQSY8=;
 b=vZIHtjmm5XvQ0jiG6/BMHpEeuR95HGCy6oUTgJicGbI4uRpXP5kzIE2RS6CpYnmueQn31fX1C+9C/fK1O2VFUd6anqzH71eTuMlOZOn6YZJKO+/fJ3M7FygAtm+PFcFwHOnkE8NNmK+XQhULSbtMuzLtrVztiGv364J2KxxrZmk=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DM6PR10MB4266.namprd10.prod.outlook.com (2603:10b6:5:210::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 23:52:41 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%5]) with mapi id 15.20.6792.020; Thu, 14 Sep 2023
 23:52:41 +0000
Date:   Thu, 14 Sep 2023 16:52:38 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 0/6] mm: page_alloc: freelist migratetype hygiene
Message-ID: <20230914235238.GB129171@monkey>
References: <20230911195023.247694-1-hannes@cmpxchg.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911195023.247694-1-hannes@cmpxchg.org>
X-ClientProxiedBy: MW4PR03CA0282.namprd03.prod.outlook.com
 (2603:10b6:303:b5::17) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DM6PR10MB4266:EE_
X-MS-Office365-Filtering-Correlation-Id: 719093d9-2de1-413f-37fa-08dbb57daed2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PX+J53ohFyWpEVR39vgQyzNwIfAWsK1L5+2ikcW1Oua3qmxP9DtTD1cZejMgdBQDpICfrBkD0+qlPWivyKfy/bflnyz0QfVqwcoyO3Z85GowdKJsIS8uW2frFD1h7HRjdl5r7PqjwSGFusmRNB4Muvv8rbZOdgHhw8bHCKTzP0hacHeDR8tFXjwlViFe+hJE11CIFhyAhAA3IZ6oBNS4SfjmHGgRZe1CG8OLAM2VBFxJhsNfJc8YHsLCrEspo6MgWsevT4fhmCFGZBI2/imfnucEEuGdwgNjLHe1/juVHAT4nw1xYWwxO8GAEXtazakhADJ0Ten884eFNcyTpMUaPIhar1qZKR0Vof6DIfPjWggx+esWybk9V4ORQu1/+BlEGtdI6tFU1LoXRLt7pX1lQGKiJ1thVp8pCK9wNSVj0s+BaPL9T7bSdNTGZKhJoQPNmFJKEeWjLFgz+pSe6uksDemVN6pWi1JLdbLjs24eEUkcMjy+q4Xnh8IuulxvUr2oiHh6CUIWTr1ymR4oexykgzaSgGqZNV+GxLnAyKm0RQFlzP1TW8BgZ0buY36mrCrB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(39860400002)(366004)(376002)(136003)(396003)(1800799009)(186009)(451199024)(6666004)(6486002)(6512007)(9686003)(26005)(1076003)(6916009)(316002)(41300700001)(66946007)(66556008)(5660300002)(44832011)(8936002)(8676002)(4326008)(54906003)(6506007)(2906002)(45080400002)(478600001)(66476007)(33656002)(33716001)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WipSrrVsedSJBZz4enLXwFFgStnnulKhF2lC6i2PGX3uQyxgx9jISh9fsQzO?=
 =?us-ascii?Q?+ftDV/pgyeRcJVtvhhVzX0ET9ZZMhSwOO9r4qiU9qh6rdyC8DU4ffFWCUHA2?=
 =?us-ascii?Q?fSCEjRZtGJcDTe3UYjkt6VpqlMJQXTkpkfpCCg/j64lWfQBCpAYQHbeeuu05?=
 =?us-ascii?Q?UwhyFia+cETufyLAWSu5PLlfD+B054VKq5gN5bPjL8rX41BZZ7M1l2ScxkDf?=
 =?us-ascii?Q?xwans6HXJRl8Luxlsje1xE3XMOr0SgWWtwb6u0HTvk7n0kM8htZYtjaq6y6Y?=
 =?us-ascii?Q?ZCB7mbPVWLpbmQQkxDjH0Qkm5iEkLdO06mKi5lHd3h0zXkUWgMYGatZcCzt9?=
 =?us-ascii?Q?Kb8NwVJujmPtf5WgUCksZqk9ELEzr0UQAK2IyvYIwwEH75bfBk83PSPSCAyD?=
 =?us-ascii?Q?sHDjccNH1fTHNH2JV0pJWOCtoVLEB2Mq4XXbglmgOlHP7FG7DrSkYXUMgPU+?=
 =?us-ascii?Q?5kk2J6889EQCq8nhjuu+ov2jZlwJytZsG1m7ahT8puovy3DzmXhlPIlBbIZC?=
 =?us-ascii?Q?w7vOuLJ8cyUPrti8Zh56ccc79unp409M6BEJBVV/Jx3jwVQO3KslFvSWgAVf?=
 =?us-ascii?Q?/R/xgwe11C6DRn3BMYjy1AlEy5MY64VGNBiQAdxz1EhBxogAe15/gb8cibHu?=
 =?us-ascii?Q?d90501B0itrDZ1cCuN9GZOq/7dkgKY0rY/DasIstFi/1Df8CkNsPDjWudpLp?=
 =?us-ascii?Q?VORUHHUPIHusz6CyRcBb2QjLPAQhv8FPhxXVOyGlCBukPBOOxXb2gw1H+8IW?=
 =?us-ascii?Q?yZ9VE4AfJD4TV/IEWh5etwRwJR83mRx+9GazdsA6MyO1NmMoXefuhm8t2xmc?=
 =?us-ascii?Q?hRVtbsRJryPGLpZGwYyIK4aNnS9R2+zZ4eT6Ae9gJ/G4dlIXsOkb2lNUW3GP?=
 =?us-ascii?Q?n+7rFqQu1TCZsSq7IRYs3jNrVoYsSaXBDcV+TZON3L4coN/QAKIK+ObezPCq?=
 =?us-ascii?Q?qm1+Jur2ie96nudF6phSma1tNwtbnBONcGrKGZdKJueKbuSgHqgdCm3RgPvb?=
 =?us-ascii?Q?rtK0K5frpax2u95oxnvc/GvDdPl58on4uzySyCH3ozL6kd/6wrfax/NMH9ar?=
 =?us-ascii?Q?7GJWFccJbAoSgTIy+u6Zs28MGUn8MgMTO4FufRP542YBrP3ze46yBilA15bD?=
 =?us-ascii?Q?lm9jAYDyKhmu0gzqFCeip/hwRATWjMMnUeZasB8rgR5387hnupyQ/j7L5Wba?=
 =?us-ascii?Q?FoJgN+kti/gZAqXuIJTDgxfx8Rw0EYXd+5shQU0GZW786tLzNGE0OICO+I78?=
 =?us-ascii?Q?7F7fHiaXjppwQass5xmxNwep93sClYrt06pWNwN8VJT99oFtz1/t4d3qr4bl?=
 =?us-ascii?Q?2ySVyjiraiZA2jve0alACcKynV1/PT3ylltqdcPkeYjPeYULD0ipx4PMlUWk?=
 =?us-ascii?Q?xI4x5ln8g3RUnrutct/INK+RtClZmNKip03nXOl5JEerWUJ+ZDmziwcf6z7x?=
 =?us-ascii?Q?IC6rCA/SFq4Rm/I47sFMhq+V+fMQOcNhl9JuNGw+6C60e160zfb3Nvf1O10l?=
 =?us-ascii?Q?M/k8B3PbOi1iWQvFdjNI/sb0dq6i6CAOcDotELoXA3fukJli8JCTVkjbBzse?=
 =?us-ascii?Q?y+FCZ5VaQyi4lNKH+KbGGURn2oeKyLtK/DOBiNMe?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?irhBr5c0757+u7kWuvwslkG3ndrHcwARO4LSRjpXCFW6gz3iDPPNTT9g0hSy?=
 =?us-ascii?Q?xt0jn2Dubjv7MPK2xqBPoTzvp20c36qFsoN4Mjj3qX8/PR0ACjpB3ON4+/5R?=
 =?us-ascii?Q?2WXrXgy/EULhOkKVbwCnVk9KJgEtcTE1y1JldEe4BLRqW4c4jVb1you2nuc/?=
 =?us-ascii?Q?ZzVcOPxX3ADEXOBTQ6f6xymG5eJzMcbjy/RiDPGzpqX6g2OTdgD1FRCxeqTA?=
 =?us-ascii?Q?R4/yNFl8/fWe14oNkgjW1DNk9hg1zw6t6rQvRtP/mxNQxxvW+YFB4wV3kIZn?=
 =?us-ascii?Q?9PSFdQXKL/JjUGXIQCSdDX2dUxbGf1nogAVLCCYxV1Ne5KtcHtG9LmsDlQ59?=
 =?us-ascii?Q?VLQaf68TIASTdxXjrwDsijlU0uWi83sDvcDFMIOgl2c+HTa1bOXoQyP4q2UK?=
 =?us-ascii?Q?LF3J4UXwvpVRQqSyMQpjnjKfnnp9nYUwEr2nPkRt0WZEABQloNK9qfYZ1rJc?=
 =?us-ascii?Q?X/gVlg0rlzCnjQOlm2RbhnaRi7pRywSY95fkyJuTdVifDfdK9nlpzm4Ha/Uz?=
 =?us-ascii?Q?owWJezZ9jvxWTPE7BhaUTENn/bnNSZlnjeSMKaDQ+6jPoVJwCMPgypwh2zrW?=
 =?us-ascii?Q?dfneU4fLP5R9jKXI2oC3nOYiCi30PR2DFIYoYoxonfb4MpV5v0V9YJJFrRi6?=
 =?us-ascii?Q?Y/5cgJa7pQnYTZWKlt67whQ0/Ae7WrN2d3Y5vdcaReppSao/Ya1hrq1cVNv4?=
 =?us-ascii?Q?XDxSH2f++kJO3kUP0zkLP0ihZMFHkfaPnvqiFc2FavbOnF6LsFGvwYpG0DKk?=
 =?us-ascii?Q?BqE98WNwIRy1QSHwLSF7KAmp6LSjOgzBOebWABeY0d4rieGIXOy8FYBGUjH1?=
 =?us-ascii?Q?4v16DuLlWFm/fc16n6AicLXNLXO2+cO69Y3RkHltZQnooHyKzaMhovRPPm5Q?=
 =?us-ascii?Q?8dJ55cyav1o45gADd0Xo0F3nUXckg3+l45lyQWv6QZDAG+8bpxDj9Tc/BzLy?=
 =?us-ascii?Q?0O0ChIpOijEj+obAIzlStDcM6/cTAPz45xwg35ihMlcSNs/QrD/IsbC4zgvD?=
 =?us-ascii?Q?gKIq?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 719093d9-2de1-413f-37fa-08dbb57daed2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 23:52:41.3171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kDARqacr2Ph87WT4Vgc/dJyJOycmBKc7KVG6h3S3FtYX09szMJxbwsEdpNSbVCdxsmqT+Z264XL/VwkBXlskiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4266
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_12,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=859 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309140208
X-Proofpoint-ORIG-GUID: LzEbCXhO1kpxlxjnTFZ-yq_P0gT4PawY
X-Proofpoint-GUID: LzEbCXhO1kpxlxjnTFZ-yq_P0gT4PawY
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In next-20230913, I started hitting the following BUG.  Seems related
to this series.  And, if series is reverted I do not see the BUG.

I can easily reproduce on a small 16G VM.  kernel command line contains
"hugetlb_free_vmemmap=on hugetlb_cma=4G".  Then run the script,
while true; do
 echo 4 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
 echo 4 > /sys/kernel/mm/hugepages/hugepages-1048576kB/demote
 echo 0 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
done

For the BUG below I believe it was the first (or second) 1G page creation from
CMA that triggered:  cma_alloc of 1G.

Sorry, have not looked deeper into the issue.

[   28.643019] page:ffffea0004fb4280 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x13ed0a
[   28.645455] flags: 0x200000000000000(node=0|zone=2)
[   28.646835] page_type: 0xffffffff()
[   28.647886] raw: 0200000000000000 dead000000000100 dead000000000122 0000000000000000
[   28.651170] raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
[   28.653124] page dumped because: VM_BUG_ON_PAGE(is_migrate_isolate(mt))
[   28.654769] ------------[ cut here ]------------
[   28.655972] kernel BUG at mm/page_alloc.c:1231!
[   28.657139] invalid opcode: 0000 [#1] PREEMPT SMP PTI
[   28.658354] CPU: 2 PID: 885 Comm: bash Not tainted 6.6.0-rc1-next-20230913+ #3
[   28.660090] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc37 04/01/2014
[   28.662054] RIP: 0010:free_pcppages_bulk+0x192/0x240
[   28.663284] Code: 22 48 89 45 08 8b 44 24 0c 41 29 44 24 04 41 29 c6 41 83 f8 05 0f 85 4c ff ff ff 48 c7 c6 20 a5 22 82 48 89 df e8 4e cf fc ff <0f> 0b 65 8b 05 41 8b d3 7e 89 c0 48 0f a3 05 fb 35 39 01 0f 83 40
[   28.667422] RSP: 0018:ffffc90003b9faf0 EFLAGS: 00010046
[   28.668643] RAX: 000000000000003b RBX: ffffea0004fb4280 RCX: 0000000000000000
[   28.670245] RDX: 0000000000000000 RSI: ffffffff8224dace RDI: 00000000ffffffff
[   28.671920] RBP: ffffea0004fb4288 R08: 0000000000009ffb R09: 00000000ffffdfff
[   28.673614] R10: 00000000ffffdfff R11: ffffffff824660c0 R12: ffff888477c30540
[   28.675213] R13: ffff888477c30550 R14: 00000000000012f5 R15: 000000000013ed0a
[   28.676832] FS:  00007f60039b9740(0000) GS:ffff888477c00000(0000) knlGS:0000000000000000
[   28.678709] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   28.680046] CR2: 00005615f9bf3048 CR3: 00000003128b6005 CR4: 0000000000370ee0
[   28.682897] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   28.684501] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   28.686098] Call Trace:
[   28.686792]  <TASK>
[   28.687414]  ? die+0x32/0x80
[   28.688197]  ? do_trap+0xd6/0x100
[   28.689069]  ? free_pcppages_bulk+0x192/0x240
[   28.690135]  ? do_error_trap+0x6a/0x90
[   28.691082]  ? free_pcppages_bulk+0x192/0x240
[   28.692187]  ? exc_invalid_op+0x49/0x60
[   28.693154]  ? free_pcppages_bulk+0x192/0x240
[   28.694225]  ? asm_exc_invalid_op+0x16/0x20
[   28.695291]  ? free_pcppages_bulk+0x192/0x240
[   28.696405]  drain_pages_zone+0x3f/0x50
[   28.697404]  __drain_all_pages+0xe2/0x1e0
[   28.698472]  alloc_contig_range+0x143/0x280
[   28.699581]  ? bitmap_find_next_zero_area_off+0x3d/0x90
[   28.700902]  cma_alloc+0x156/0x470
[   28.701852]  ? kernfs_fop_write_iter+0x160/0x1f0
[   28.703053]  alloc_fresh_hugetlb_folio+0x7e/0x270
[   28.704272]  alloc_pool_huge_page+0x7d/0x100
[   28.705448]  set_max_huge_pages+0x162/0x390
[   28.706530]  nr_hugepages_store_common+0x91/0xf0
[   28.707689]  kernfs_fop_write_iter+0x108/0x1f0
[   28.708819]  vfs_write+0x207/0x400
[   28.709743]  ksys_write+0x63/0xe0
[   28.710640]  do_syscall_64+0x37/0x90
[   28.712649]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[   28.713919] RIP: 0033:0x7f6003aade87
[   28.714879] Code: 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
[   28.719096] RSP: 002b:00007ffdfd9d2e98 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[   28.720945] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f6003aade87
[   28.722626] RDX: 0000000000000002 RSI: 00005615f9bac620 RDI: 0000000000000001
[   28.724288] RBP: 00005615f9bac620 R08: 000000000000000a R09: 00007f6003b450c0
[   28.725939] R10: 00007f6003b44fc0 R11: 0000000000000246 R12: 0000000000000002
[   28.727611] R13: 00007f6003b81520 R14: 0000000000000002 R15: 00007f6003b81720
[   28.729285]  </TASK>
[   28.729944] Modules linked in: rfkill ip6table_filter ip6_tables sunrpc snd_hda_codec_generic snd_hda_intel snd_intel_dspcfg snd_hda_codec snd_hwdep snd_hda_core snd_seq 9p snd_seq_device netfs joydev snd_pcm snd_timer 9pnet_virtio snd soundcore virtio_balloon 9pnet virtio_console virtio_net virtio_blk net_failover failover crct10dif_pclmul crc32_pclmul crc32c_intel virtio_pci ghash_clmulni_intel serio_raw virtio virtio_pci_legacy_dev virtio_pci_modern_dev virtio_ring fuse
[   28.739325] ---[ end trace 0000000000000000 ]---

-- 
Mike Kravetz
