Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51CB97CB7A8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 02:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbjJQAxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 20:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233549AbjJQAxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 20:53:15 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE87A7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 17:53:13 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39GKOBrv017725;
        Tue, 17 Oct 2023 00:52:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=xUtRM4/izF+de6aMo44VqIvJ+1fKh8kmOR+7FEwga7k=;
 b=Ihfiv5YhwusNOuXOmWTQM4osksmKzP/MpbgaXkGBBOf5vlzITCRe09RVdAg59vIGkxij
 9gJbt5rIfwYyK7Ud+Fd4DPlh0cNho62D6AyLYXg8NiUojUNJe0AdXYkoWH6r/4lIjm19
 4TizXWCTjpbP20w23T4XN0Ak3TrUwH0IkoCSNrQE9EHQYgLRDX5t2oj0FW2n8eHa09sn
 q9a2oSqFYsYLQCYER9qhdfosrjzZeUAlTV5Ryvwa4m0WKfljjrCuWGMO+oWValJKfQru
 V8QhPmgNUnI0HTceuwnoOGJZAmYdFsYz4d8IQcTVDp0kzIz6A1tO1uNx2aJYdFA9nHsC 3g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqk1cv04e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Oct 2023 00:52:41 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39GMVu3n009788;
        Tue, 17 Oct 2023 00:52:40 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3trg0m3v77-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Oct 2023 00:52:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OW+JxA6KtCrOakvot1iybE8JIoUI7DhsgiD4VA2962QLX2KSO5S67rLWzgoWNrVKqXgOel/T9aO1iKnYXFlSQpSEK/KdW5gw8K9WsIAJxZdQK0AI1d9iVKzEoDLjUAubfiD+sfiZzlpJwmF4uK+008SZHTMgf1XcG07yVz7iJl3VeuRDghytIYPWkWhv5CS+ame4Ke1QytKY4QEbHqTXWjKHYZ1/uTJu2CFIn2vjEgwbaTPbj7CVRNDIVwmFAlVqOzOCRlQ9a0xJRRRGTfz69kv9fVk40ckQPXw5EEkH1R5JYF0HCos6uqh7f0MKW3oMFYIcZPdYRmlh3FzQqMKxvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xUtRM4/izF+de6aMo44VqIvJ+1fKh8kmOR+7FEwga7k=;
 b=fkNzKrKgR5TDK3yy5M8zBv8zSzLTMcMcVXLfcLV22Fc/OypKvlhLHHHWOgVZ0FptBSc/CbzBkvy4xskAQZpYdOfh9paL3JEqP8XeY2Deh1qWZU34SN1NWc22NLA1fbyOFAhyc0zcZwmImKMhr/OC3qS5pXHYXkm4AVL/vIfPlRxZ8+N+NTR0y7QcqIqsxJzDRu4fPGI/B6qBnQx+0h1by+iRHWWiMch0T7D1m9ah4pNBAbqjXv+2Oyi5vHBUTl3vPmhYQ0D36jDeFPMdX8KY+ZTS1J8Co2ROlHUqw6c0RC942B245HnGFfA9RJWK4N5EeOJQ+/CkVvSZN2brIDHgJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUtRM4/izF+de6aMo44VqIvJ+1fKh8kmOR+7FEwga7k=;
 b=behhk2gFRHTS9+HIkvtrPDHx50VgT0VGjM/qDi+F1p1HCA0k9uo/SfHcTZMhEscuoHS8xGhGVKCW3I+zfitmXeYa60DhqFahcg5q14xH5aFEft2V2cucANjngx/B21m2CC2r9Q3GMSz32DVHM/2vcY8JLSje3uQG81PG0Pviq+4=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DS7PR10MB5085.namprd10.prod.outlook.com (2603:10b6:5:38c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 00:52:39 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2%6]) with mapi id 15.20.6863.032; Tue, 17 Oct 2023
 00:52:38 +0000
Date:   Mon, 16 Oct 2023 17:52:36 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     riel@surriel.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        muchun.song@linux.dev, leit@meta.com, willy@infradead.org,
        Ray Fucillo <Ray.Fucillo@intersystems.com>,
        Jacklin Kotikian <Jacklin.Kotikian@intersystems.com>
Subject: Re: [PATCH 4/4] hugetlbfs: replace hugetlb_vma_lock with
 invalidate_lock
Message-ID: <20231017005236.GA236970@monkey>
References: <20231006040020.3677377-1-riel@surriel.com>
 <20231006040020.3677377-5-riel@surriel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006040020.3677377-5-riel@surriel.com>
X-ClientProxiedBy: MW3PR06CA0004.namprd06.prod.outlook.com
 (2603:10b6:303:2a::9) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DS7PR10MB5085:EE_
X-MS-Office365-Filtering-Correlation-Id: 2987dd48-d764-480c-60ed-08dbceab5c49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BjMpiPnNAY/LosrX2fuj1q9h/QWM926Vu4pJP6bTJyDj9JMMzT3kmKhZp0ntnNLw/DbJ+QNnkCG+GVa9Djbjyb4coVGlZQXTv7TDGXrvgIlqt4N9P/KHSzEi9ZZvIAwPW8kA5R/aD1HLEr/YTLlPJYbBpFLSQ2dqXKHoBYb79BmLEViwooUuA0wgTVlhDIjcNcqOz4ssRrMOHmQWw5O6+Q+Enc6OJpQ6LOMER7/RWcfBFuLdZkh4vGMhGHEDxlbI2Rnk2tbs64POkF0kbBeMJ63z5L0TVXUk9KQEwtKkNMvPBQUdwvnFPgBnO9Y3UAXDuU4AbShv9kBuU7c86hfs3cMkm3WCVjk01WSLFxW1cTTEUhpyyQeyVZ8e8G12NOvhCYHtwxXjME2LMI7WcJI1xK6/YE3PSnd/0AvtbNoiiQfoGESF7T0yF3N0zV8+b05pKgwVKIdAvwJtTuk06Jn1JjQfsmR4ray2MDaIk9bDOsUAeLIovHJVepydLSG+O25RE+cpf3+R8id4TEEs7zQkf/P0lNlHGSJ4MS3q95tbtcM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(366004)(136003)(376002)(39860400002)(346002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(33716001)(316002)(86362001)(38100700002)(5660300002)(33656002)(2906002)(44832011)(41300700001)(6506007)(66946007)(478600001)(66556008)(966005)(6486002)(8936002)(83380400001)(4326008)(8676002)(7416002)(1076003)(26005)(6512007)(53546011)(6916009)(9686003)(54906003)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SK4EpSIAPpHn5C2j0z4GMRt6kdpjLKvA03RMtyD12Rf2ueBVea6QGXqCI8JP?=
 =?us-ascii?Q?5j8ybvIQG+6wlUzOHLIH1HwI7o9vIrvgYHIWtqVmUWFVu2olOj6EmJtj2/ZE?=
 =?us-ascii?Q?3oPjOfQd5glDvokHwCMgvlLkRP6+NbTISv/lve1WzRhERbNENDkQO+NT5AQv?=
 =?us-ascii?Q?4HTAL629hra5vbQwdhsa0JQaFgdJOy036ZaO6wHLtjgp+4UTUkn+HJiLXn4m?=
 =?us-ascii?Q?suu/w7mAA0cvx59VV0J/NhUFmqZ5A52A0lS1aZiQd4mjzb7VhopTxH/GlnqE?=
 =?us-ascii?Q?mYSUFWBmucI9V4ciuLZAvx7XNe0PGLEZs+ZxZApgd5ppX31p12/auUJdfpsC?=
 =?us-ascii?Q?MTnA+TQ4IvMajqbtCjZXqeOJ2krhjMZ7Gop+9L6RnFyyV0U/M0SwoVSxeG4r?=
 =?us-ascii?Q?Owt+ZN4u2QmBlRjrpSe1W6yVFgk3Zg8FU52fbtX03jArN/Jk5kYvsDys37Jz?=
 =?us-ascii?Q?U/I5I6drGSsRGlKMMr2HDQSjq4pWtmCMwSFARLTcwQ0v06qNZtQA9zBrFC1E?=
 =?us-ascii?Q?IA0criZJdY5MuIjTxJ75GefMdXXyIpWOuJ2zElzxGS+QrbJOzdUGQSpgjW+X?=
 =?us-ascii?Q?OOYTQ0hlU/x2TmuJTuUTN+NKTuyFKJJFvNOyaUhatcvB0TYcUH6eB/WuVycW?=
 =?us-ascii?Q?RndjBy/yoqIqGnZ7OKP+7OTxSnLlk4FI6CCsYr1tZRHwWZlEtKTQu7+y8+LC?=
 =?us-ascii?Q?t7sv2FhmTZl72qPnD/jsVwiSwA7ESAr+sjCx+ea5NRnGh+dNb7Kxd69ZD+P8?=
 =?us-ascii?Q?RHt84KsT6pHODIseE3OGJRrGGIF9psJrfSw+R/Ab0jWlXkI8XtDVEiYui0eo?=
 =?us-ascii?Q?kDnrTl+6TrjsXWzRqyny2IG+qAvrfYJVHhGYolHfLlPnfpscDObxD/hvvFlw?=
 =?us-ascii?Q?DXUCJiVXwF4bHahkrN5N13glhYSwT9PjA9XXb9B55/mE+ibXy3PSLvDe6sSx?=
 =?us-ascii?Q?cYiB43PM3JpQ5IC8RwxpeN9UEzY3w/0NKv3FT+JMmA/8eqC/rMvXLfRLBc4h?=
 =?us-ascii?Q?OQqOcNRBIeOg27ax+as4VJbJxtVoEoqLHfnmovkvd1aazADSixSYAFRoSVVq?=
 =?us-ascii?Q?jrIesY3+0JyjiEwW5rD/Vcx2EEw+TrXaFYzQnAUEqtVkm5PaY8qRIYNl1gXL?=
 =?us-ascii?Q?gij4OgRpjtgWqAGNmDTbVB04M03wbRfOrXLIRqr1qhbb0M4FlzRIaJlcqgE1?=
 =?us-ascii?Q?uz6ZVy400/d40w44THU0bVt70OHJVm1IMYMzboxJvKswW7G5PMmcKm4GRr/6?=
 =?us-ascii?Q?kDxqi5Uzm2O4OgEtRMo+ysP3r8Y1FJcqfjw7aUuRqiRemuqoxWMNxLvjbOe3?=
 =?us-ascii?Q?P2xt2MdHQ1TYljh4rI38O5eW5a5tRmI4VU/ZJL+PFf/25IdoWSBasboNKJaZ?=
 =?us-ascii?Q?24C3Ucj2pGD4FfHnLSpSHnWapyUOgTIiSpAUGRBZUAXY3XxVG+tV8xfR+R8S?=
 =?us-ascii?Q?HyvB2ZZ/7M7lqWjxthq/7fjZbjDje0175eWVs1BO04h988GA5fmWrHeY4OKN?=
 =?us-ascii?Q?8MsXYeyxHtqnhCQhri6l0uiRS6P7LaqKnK8kPkEWRh3JaBliDJtk8QaYlUiC?=
 =?us-ascii?Q?y6yEinYU6hAWtAssY+J4EhKg5MwZA5zueh4CyYLS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?ul2zzVNVBzyU5JEuMPSTbJdIcH6XhCIMnX7l88UVXDUwIdSERG7et12scA9y?=
 =?us-ascii?Q?fJd59jdpFALJJ68+B91/xnSV/yxOL2stQP+0a5RVlBCY3ZU2GZ6NRhKvky+j?=
 =?us-ascii?Q?DL0N+90aP033/U2SIFhGZOyVJYJqnIStowyUD27wlbwZc7myh5YvZzlgIQ3I?=
 =?us-ascii?Q?DV6TB528KtRzqQ6TC4whPYocvZfyFjFfVjBWxeMsoPIMGEW8xAoYXl+w5ZcC?=
 =?us-ascii?Q?Ld4es8cNLuD9cIaUuOoWvZUiOmhtw7pQmlZ+MaJTOkfgtTtseJfLFp7ojOzZ?=
 =?us-ascii?Q?aK7AEKQUtvBDfAUUi34GGGTKOHHkoLCEZztvibVpuf4fvTq9JX1T2m9jvItG?=
 =?us-ascii?Q?ieAIAgOXsBM3s2qwvIU4Z9xA4mvjaSaTwwPGHpPurkSqZiVTc9s0w1aW1M/F?=
 =?us-ascii?Q?gXIH3jBLj5ebAL24HUU8J1fj72Cyqqj/b0kIdr28F2/nPdRTzkE5AUt6BOjD?=
 =?us-ascii?Q?pIjVMM99RtYwr3tOEHpsGWQ7nAs/SCMhrR5J0MCDYzUPzeALZDsWXlBmYmKr?=
 =?us-ascii?Q?FepaL5+38Y9Aq4HCf7wmT0TO3nyXgrL5cjSLs88/zxPzmhNVCOvDON1Yz9na?=
 =?us-ascii?Q?dEiMbLsh2DPQh88wv29p4iGjjcmt3/XnskErVwP+ijopENBYXZ/AaoP3jJcW?=
 =?us-ascii?Q?3tAw5J7+TDCLNxqN6XBuPdAogNj1lk2Ofn3YHnHx0ihPKH+DKseBAH+OD+v+?=
 =?us-ascii?Q?OODUp5MhXs2GSmQeeieayPr455aqF2qSK+WvbNuQFZrJ0iE/zKskq5qJqZYu?=
 =?us-ascii?Q?ltVoYevPD7eFlmW7cMnw3c7vOFXn0jFJSirGFmvRrKWel69Nd7aST85DBfAf?=
 =?us-ascii?Q?QSDiKtlUnjR4zg/t3tgkgPPv2ihTNm8UfW254aocYKJWUbhIu6DJWYW1X/d7?=
 =?us-ascii?Q?bOaE+ILyxpyy3O4bTunsQayNPZhJ5eTjKHazNbboMbsd1rQrSXGzsXExBTdQ?=
 =?us-ascii?Q?/9d9GnJr9wsBPll/rbBUXb5l9WOtqwdkJE0YvqcmUr4DPlLnfBfxykPqBdVh?=
 =?us-ascii?Q?mFbD/OZZf5o/aMgCslbvZpaFGg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2987dd48-d764-480c-60ed-08dbceab5c49
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 00:52:38.8829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fSwckSYzqdJZ02raO3w/6OvlI0breVBSFdn5mdjkA6aU29dIIneOg2YeMk+bTKbxmU+gT682gu+cFOsyzlYbfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5085
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_13,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=10 phishscore=0 spamscore=10
 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=10 mlxlogscore=94
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310170005
X-Proofpoint-GUID: X4REdvEhR5kiNjAxL9vDYXV8j-RjcVU2
X-Proofpoint-ORIG-GUID: X4REdvEhR5kiNjAxL9vDYXV8j-RjcVU2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/23 23:59, riel@surriel.com wrote:
> From: Rik van Riel <riel@surriel.com>
> 
> Replace the custom hugetlbfs VMA locking code with the recently
> introduced invalidate_lock. This greatly simplifies things.
> 
> However, this is a large enough change that it should probably go in
> separately from the other changes.
> 
> Another question is whether this simplification hurts scalability
> for certain workloads.

Finally got around to running some performance tests on this.

As a reminder, the hugetlb specific vma lock was introduced as a result
of this report:
https://lore.kernel.org/linux-mm/43faf292-245b-5db5-cce9-369d8fb6bd21@infradead.org/

I do not have access to the database or applications to recreate the issues
originally reported.  However, while working the issue I did use a
simulated workload that showed the regression and improvements moving to a
vma specific lock.  Here is part of the commit log describing the testing
when the vma lock was introduced.


"The recent regression report [1] notes page fault and fork latency of
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
simultaneously."

Ray Fucillo (on Cc) verified the performance regression was removed when
the vma lock was introduced.

I have run the same benchmark on this patch.

test            instances       before			after
--------------------------------------------------------------------------
faults per sec  1		385135			386253
faults per sec  24		 95922			 75665
forks per sec   1		  3392			  3207
forks per sec   24		   683			   704
Combined faults 24		 76004			 30407
Combined forks  24		   241			   278

The Combined faults number drops by over 50%.  This is not nearly as dramatic
as the changes originally seen.  However, I do expect that there will be
a noticeable performance regression.  Ray may be able to help running real
workloads on real applications and database.

I suggest we hold off on adding this change until further, more real world
analysis can be performed.  The simplification of the code is nice, but I
would hate to regress any workloads.
-- 
Mike Kravetz
