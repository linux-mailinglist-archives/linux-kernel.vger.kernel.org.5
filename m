Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13E6779B78
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 01:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237267AbjHKXkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 19:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237254AbjHKXkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 19:40:15 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC271702
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 16:40:14 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37BNLA2Y032590;
        Fri, 11 Aug 2023 23:39:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=g4HEh0k/hkgK/pk1yOYsdN0Il2eAJvAm3cM5BwbfQw0=;
 b=O+keQr0dcuf3hOBxl3ut7dwDywM2HLLPG5RPDXe9cmBHgqkka4hRQ9ZLS3ZivVWoRmZy
 WHaAb/+zNubaF4thnX/p5Udq7ZPeV99IvXx3OZrU9OdyiD+apN7i/DbusyInARULP05o
 l28EL7CymR2v7C2zjId6KNAq++ZcvUd6aQ7uniVYJfcxjXBqaVHUBFhW/axLszOgO7qd
 dJXzXFdaHol3RZ3D8RQmhWX//8XGefR6jaiv8EDDM4CII70z2FDBPh8Ks7BYfJuugpoy
 aJiOwzO/90LS6nF6XHEZc/zdpdBpKHVs2DZdVVBdPk+d+OJW+qX8B4X2ydpHZxHKhY2s Rw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sd8y6t1wr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Aug 2023 23:39:46 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37BMuj0e009667;
        Fri, 11 Aug 2023 23:39:46 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cvgxrxh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Aug 2023 23:39:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cKiTfhlisFoKOxDQGVewhAAdk68/kHJIDc4aqp/Wi1H12VSSokLnPwhtAiq/RyPu8zUssck02yESI3WQK8GOlG2h8l9vf5wxty1E4Cn5mvXLBLaNzBK2PaPIJb5QputFbtMSXRySaGg3hbkxKH1+PPUs6X4coeJmdlCNTXHiny05XVxf47gsi1oMVBViCkK2lwoPwUjLnNtBpEEUp0dFeg3kuBJSWk1EjAmllwpXFfScX4jbIKLjF9qKI1vRADeGgxbbjUpGb78apyExxrq0jyUeMa3n4yt1ITRZiWm9V9rvgbzTPFg+iSwai8JT2KVUckHGKkmAtu+JEftdkzODRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g4HEh0k/hkgK/pk1yOYsdN0Il2eAJvAm3cM5BwbfQw0=;
 b=E547EcsUp7z+4lrjWiuZD3zlt6s9Sa7B4Mn4o3aWQaZ2JCLQDus8HNp22VbcdPXJFYpNO485D/9S6Qr2tmASAvp+Hk1kvTYXkgPuSgTsO9VDYCfxGj9eJGZwpK6IiuesrdvrYMof/gKFTPVGVaJGfaAqIngATEqiHJTcangjQS0q5FF+YMK98LQDbT372vNiMeQxmCNWvZnXum6yrhkrnBTSqZlSiHJpgYaqH406gcW5/Vpsi8cdhzGnrh3863ApiC8Xg4CWE8k76IRLuT6g7tleoFZ32QovAw9zfdu9KVTFAc4EP97XWBIH3ZdPKUGCWDbFdGUpCuTo4MtFbS7tMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4HEh0k/hkgK/pk1yOYsdN0Il2eAJvAm3cM5BwbfQw0=;
 b=j4m94pkop3K8CzGWvO//a5a5YMeb3VrcaRQ7JsT7WJjnlD1jLwuc1Z5C36bC/KLAGRfPM9Mtze6PVN9gv5mRHj3yHCyWcD7d0uc19eQMX+la5YwMOxFvBANekDofNzTNIWmHHATrEP1wuDcpt645ocD+52c4LUqkRZ/3XGVWKZQ=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SA1PR10MB7790.namprd10.prod.outlook.com (2603:10b6:806:3b1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 23:39:43 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::92ea:33e7:fb66:c937]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::92ea:33e7:fb66:c937%7]) with mapi id 15.20.6678.020; Fri, 11 Aug 2023
 23:39:43 +0000
Date:   Fri, 11 Aug 2023 16:39:39 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        willy@infradead.org
Subject: Re: [PATCH v3] mm/filemap: change ->index to PAGE_SIZE for hugetlb
 pages
Message-ID: <20230811233939.GA105247@monkey>
References: <20230803174817.320816-1-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803174817.320816-1-sidhartha.kumar@oracle.com>
X-ClientProxiedBy: MW4PR03CA0295.namprd03.prod.outlook.com
 (2603:10b6:303:b5::30) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SA1PR10MB7790:EE_
X-MS-Office365-Filtering-Correlation-Id: 13d080a4-21b8-4a65-befa-08db9ac43cbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jskVf3lrpmr+qbCF7Ts+Wype1iZANKJZUMY+loZFV+UhEEkVdJa7M+wlWssflBF+lSDXTpae/NikwXqP6v0AXvi+zsfqUdQmiyNjdfYOpC2YQcF6Q1tAEr95007qE1RHwU98+Z0iqWZI3x2Y9Mzgpame1gbpvlmPnEP+1DdMWullUQmUWEJzT3AWSzlWsWtbbNlFZyQksXjVH0/mTilPUpbCI06aIw4BmIRfOnEqCRkZH5GYBdye48/MT97GijMkS8KsBayUl4458eGSvBjq1eFa7ePR8Lr4xYUCwDCCSo2FJyEYGlvlNIGaEC9a3QXvQ8DR9B4cZoaLa1BWJLcuprxY+Z8y5O7QJXlqkm4Wxx8lZPf73V4Yw90H7bt0AKLvAwZgXf0VNxi/J8ibHaCh15+q5JsU4bVcAchbOKf2ICj/nVs9ez5fGJRy/N+46up9KYc3YmbOuwXqM7YbRdkE9Y667iRLCRIMyfsFlpNuaEiL/z197xAcBeONDBFejplvm14VwrDdBsP6GMz7d04QPueICnH6rgE9p1QtU0mS8k/W5sgIZxJATJ/JKPtvu1Asfakz5tLTWvtpb5XmctUYAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(366004)(346002)(136003)(376002)(396003)(1800799006)(186006)(451199021)(86362001)(33656002)(66946007)(6512007)(1076003)(478600001)(6666004)(66556008)(53546011)(26005)(66476007)(6506007)(6486002)(9686003)(2906002)(316002)(41300700001)(33716001)(44832011)(4326008)(6636002)(5660300002)(8936002)(6862004)(8676002)(38100700002)(83380400001)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5CCxUk6xkrlQ/XnMHTnDUM5leCZ/zK6tZ7KSCEvY0Z7HdUjI0PszspC9/hnk?=
 =?us-ascii?Q?cCN5WcbLJn70KusJ7P4r5iJ/NqjlZeTWzJI0/uZvgewIRuiVIaqMHzyyklxz?=
 =?us-ascii?Q?gCNrQdh2ct+3EyCVNBcQOKgwEvxJGkA/3f9OxhJiZPyK6BvTqRPObp35CDrY?=
 =?us-ascii?Q?OKtaIScpeqwPR+cf+2wxM7E1oN/6zzfxYjKW9YKiEjc3PKHT5oQxXK676c7i?=
 =?us-ascii?Q?aQHEeLDL0/yv8hWzY5/dPhhmEa55SSEjMaku1UOuqccCGgeKTZkykjzI/if/?=
 =?us-ascii?Q?L9GPhIR0/yIkuLl15dwB+YvBlKjTPO1WUoKVxY2mR0DWQqLsICNzzBeiEVc7?=
 =?us-ascii?Q?fceFJrmDKroqaQNN23LYaUg+L3J48dpfuageB+GU/cL1tnW+u1AZZ5c1jBAj?=
 =?us-ascii?Q?9xGuOFeXkGABH+RKB2kdq+dFlYTieanqcHDIPyyYsTwKTc9VthE31i8EWSrf?=
 =?us-ascii?Q?82gdthD/eXUKEuemBlsvz4ECFuiaPdpiU07uS1zXaxhSy/Zvi9T3vcMeeVod?=
 =?us-ascii?Q?3UtumfFcWWI3C8visnfEjLi0PEId/3+9k4YSM9ZsFBlSg6mSizknnqNAXgY7?=
 =?us-ascii?Q?gVC+XD3MtVSxgBdSGrgawIgsYynuNVrilKD30/58V/OeWTxCGviw+HmmMiC0?=
 =?us-ascii?Q?YYa1BcDcVDW/gLsKBzWOK9AoUPWH6BgPP54ndFD+gKp5mQ3YppbAGGFIuw2N?=
 =?us-ascii?Q?jGANtbrOyrXrnqOkh4F0o8c4f6gahwawgySrK03hjjHUGbFusDtrcqCb+vtg?=
 =?us-ascii?Q?i35PtzIdbyyrMsJH41X4TUM1l1xPXzXQj931a297bXPa80cA7ILUTrW/ae1V?=
 =?us-ascii?Q?z4QWcYA1gF7jOUKB0hg8lbHgQNSv8viutGwx9Vx4GsY9sOt2wQidzWePl4MF?=
 =?us-ascii?Q?B1VHPnr57V7fzq89A+t4mDilKPHLJgXxlP2IDEtd5UmhjSzyPt0jSDKLTybo?=
 =?us-ascii?Q?5/2DxtbhD0YKma/LPd0CFwM37KCWEkbkiRa/Vk7qzloqM7RHOeRHZmEYcLK6?=
 =?us-ascii?Q?S1aytCpqo0ZT8hqH2RPkFVvQBw3WpE7KTCtAys5d6yRVu0lrLPXySCdv1vdR?=
 =?us-ascii?Q?x1ym4yz+EO/9CPsyhOiIXvAzvDy9ajQ+ejxejpY6yf+jI0nPnXzDvCNwx+Jq?=
 =?us-ascii?Q?baxs+JZkXlco4e2toUVm7V8ARWrxce8YlcIWyooK8xW3+NITv9dX6k/Zo0tE?=
 =?us-ascii?Q?eYsngmodGwzjMnzQphLZlWgHgavBHO+Tn/kR1Ee0SCYuCEtLUqd/FmNeIf7H?=
 =?us-ascii?Q?6StMA3v4xwkyrd6jMcAO8r7ixuTGPGNeLjCciTyyOTO3Htq8G2JA+zD3rApt?=
 =?us-ascii?Q?cBTJM40CM0lVJfMS82tjCymVn+lQudctnmCi/ooien0PsQTatFacESrWow+B?=
 =?us-ascii?Q?Y8/9YMrITHjGuB/bClWri6YIf+H2aUkc5OGgoeFhUpM2ZYjYxrjXKlbIYroN?=
 =?us-ascii?Q?LTUXuehovsjgVFQCfAycNLFFfNoD9MWtM5F5NKh3VVdCCll4Cx0fsrRn/4Y8?=
 =?us-ascii?Q?zsNev82prrgZWb8icuMfIvr1k6wpvTq7i7dDiGpNQVPWudEy3xmqDC4HyJ4y?=
 =?us-ascii?Q?Y6/FoevghFPlXl1juoqQMYvOdobP35Q59KxnsJxXw1eVsOyQtSD4imDAujZG?=
 =?us-ascii?Q?fQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7I38cU8lsTAfffygXmaIfoTeNzY2xZK3tcCAENJ1gOLL+S7BCXjKTJziMt43ooARVtnCTa3tTHaRfqHHz0Uh6ZBX5xwyY0m5d90QB7++eY6j8E9FhtYvfakPHkjZ8qxWiCos5Rlk32DsSg2FZNJKpxFY3GRUnsILy8dy5fY1WIT3xsa7d+Svd8IOXZHI0vtccPm6boHdzlVX+BePCopz1usR+TjnqNexyCtf5LLbiU0wH1slLeAYUzL9CI9n9Z8OW5+bOFf9FhHK5DNOerotZlJb4jW+SjV1ExVM/e8gds90ysGkNqhxE4zWfqOYT+FSLivWOhOu5BbW/n4JA2Ri92DuvJTzJ9m2i6qLyH2NWPhY6FYAjS9JoAVWOthYrj6SmaW8+IZkGu09xSa7bnhyXNZintDiUbOIGHLPs7dYIQVZQO9qdDiEtvf1RIVI5+Cm6466buDOAgpOYG2SctwzajYFD5KWbjXl7bVbCKmkQwBOf71/9ERe7oiG4hDjK6gzOXoNow4gLyUkQ/5e8N0zl+n6CbMVYJ7khr0vE/FP/9W8lKQ74FnvqNZnVAf0Z7KDClxzMmZJ3R6VNqPZ9CZCdwOoy/fMPZ1qxPsjSoQHuFFi6bws3C9E1BFfzUXGuYFTPWFqcIc+AUdjYB4sudBdsB4qELR41KXkhlqWApzGU16fmARzWNz1/CWnFoxSxd5QS+oapcwFBwhaf5wt/ie9+c7lmT990kU+5i4sq7YmE4jFTYNv34vBcsBRjv+SDilgBSTEY6fFn+Er1FyT/ddi/wWqxVQ1vGtjVNp1AImpJ6G80JUnYKJXu4tBQ1PpFxB/snMfrucJFj+yO8M+Pam1z9BW47qLvtv+cbZc+PZZY18aPbtlh92+QkcShorWw4w2h0jvr7Jz4ZRDUONShehVhaZMgbaGtUMLpun843cRHzw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13d080a4-21b8-4a65-befa-08db9ac43cbc
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 23:39:43.0292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: arszE4iAYjvlmDFNQuenkVxaXlHBuF4gZ7YbsZuJy/xIkCO03JN5hidlZ7sv7DoqBLyBC3gmie7fXmk0rUtMWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7790
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-11_15,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308110215
X-Proofpoint-ORIG-GUID: 6GRZTKra86-oehBP6u7UtwwEQ_pTW_Gk
X-Proofpoint-GUID: 6GRZTKra86-oehBP6u7UtwwEQ_pTW_Gk
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/23 12:48, Sidhartha Kumar wrote:
> v2 -> v3
> 	- gather performance data per Mike Kravetz
> 	- remove start variable in remove_inode_hugepages() per Mike Kravetz
> 	- remove hugetlb special case within folio_file_page()
> 
> 
> ========================= PERFORMANCE ======================================
> 
> Perf was used to check the performance differences after the patch. Overall
> the performance is similar to mainline with a very small larger overhead that
> occurs in __filemap_add_folio() and hugetlb_add_to_page_cache(). This is because
> of the larger overhead that occurs in xa_load() and xa_store() as the
> xarray is now using more entriese to store hugetlb folios in the page cache.
> 
> aarch64:
> 	workload - fallocate a 700GB file backed by huge pages 
> 	
> 	6.5-rc3 + this patch:
> 		2MB Page Size:
> 			--100.00%--__arm64_sys_fallocate
>                           ksys_fallocate
>                           vfs_fallocate
>                           hugetlbfs_fallocate
>                           |          
>                           |--95.04%--__pi_clear_page
>                           |          
>                           |--3.57%--clear_huge_page
>                           |          |          
>                           |          |--2.63%--rcu_all_qs
>                           |          |          
>                           |           --0.91%--__cond_resched
>                           |          
>                            --0.67%--__cond_resched
> 			0.17%     0.00%             0  fallocate  [kernel.vmlinux]       [k] hugetlb_add_to_page_cache
>      			0.14%     0.10%            11  fallocate  [kernel.vmlinux]       [k] __filemap_add_folio

Thanks for getting the performance data!
I think someone may have already mentioned that this should be part of
the actual commit message.  And, when moved to the actual commit
message you might not want to include the data where there were no perf
samples in the page cache related code (1GB pages).

Any operation where we add a hugetlb page to the cache is going to be
immediately preceded by clearing the page (as in fallocate or a fault),
or writing to the page (as in userfaultfd).  Therefore, the difference
in page cache handling is going to be mostly in the noise.  This is more
so with larger huge page sizes such as 1G.

> 	6.5-rc3
> 		2MB Page Size:
> 		        --100.00%--__arm64_sys_fallocate
>                           ksys_fallocate
>                           vfs_fallocate
>                           hugetlbfs_fallocate
>                           |          
>                           |--94.91%--__pi_clear_page
>                           |          
>                           |--4.11%--clear_huge_page
>                           |          |          
>                           |          |--3.00%--rcu_all_qs
>                           |          |          
>                           |           --1.10%--__cond_resched
>                           |          
>                            --0.59%--__cond_resched
> 			0.08%     0.01%             1  fallocate  [kernel.kallsyms]  [k] hugetlb_add_to_page_cache
>      			0.05%     0.03%             3  fallocate  [kernel.kallsyms]  [k] __filemap_add_folio
> 
> x86
> 	workload - fallocate a 100GB file backed by huge pages 
> 	
> 	6.5-rc3 + this patch:
> 		2MB Page Size:
> 			0.04%     0.04%             1  fallocate  [kernel.kallsyms]     [k] xa_load
> 			0.04%     0.00%             0  fallocate  [kernel.kallsyms]     [k] hugetlb_add_to_page_cache
> 			0.04%     0.00%             0  fallocate  [kernel.kallsyms]     [k] __filemap_add_folio
> 			0.04%     0.00%             0  fallocate  [kernel.kallsyms]     [k] xas_store
> 		
> 	6.5-rc3
> 		2MB Page Size:
> 			0.03%     0.03%             1  fallocate  [kernel.kallsyms]  [k] __filemap_add_folio

What would be helpful is to include the real (user perceived) times with
and without your changes.  I expect these to be essentially the same.
What I want to avoid is introducing any user perceived slowdowns when
doing something like adding 1TB of hugetlb pages to the cache.  I am
aware that this may be done as part of an application (DB) startup.

> rebased on mm-unstable 08/02/23
> 
> 
> [1]: https://lore.kernel.org/linux-mm/20230519220142.212051-1-sidhartha.kumar@oracle.com/T/
> [2]: https://lore.kernel.org/lkml/20230609194947.37196-1-sidhartha.kumar@oracle.com/
> [3]: https://lore.kernel.org/lkml/ZLtVlJA+V2+2yjxc@casper.infradead.org/T/
> 
>  fs/hugetlbfs/inode.c    | 15 ++++++++-------
>  include/linux/hugetlb.h | 12 ++++++++++++
>  include/linux/pagemap.h | 29 ++---------------------------
>  mm/filemap.c            | 36 +++++++++++-------------------------
>  mm/hugetlb.c            | 11 ++++++-----
>  5 files changed, 39 insertions(+), 64 deletions(-)

There has been some code churn since the rebase, so you will need to rebase
again.  Besides that, the code looks good to me.
-- 
Mike Kravetz
