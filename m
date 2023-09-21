Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F927AA533
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 00:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjIUWmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 18:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjIUWmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 18:42:42 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9136F91
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 15:42:35 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38LIsTkd005949;
        Thu, 21 Sep 2023 22:42:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=96ZCWnTlzagJIs+YO30TUgyvple5RxCW56s+Lg7ZJRY=;
 b=Cd3u9RIV/IEUjzy/0sYZ/m3YbVXPMLOYcDXvfVlAW5MSXdGL6DcivHv9fQERv+m+hMDN
 pTv9GhJUg3X/++tUO4jmPUePClepI//z2TszmWMQlgeBvbxlx0034BOhLOUMkMRDBE8S
 W6hXH9cVvP0Htb5E6IjUCoxn0lOf/m/SHMsvro1xFH7WkeLwuQLYmeWT8x5PtPRrNPZS
 qw05NmO2UpEnaJZiEy0QiZNuOAZdZ8uAZcTXd5PKJwV8YMdWHgh9hB+7v6vAvnaJnP8U
 eVo/dyG2clmx7JTRt5+VwLSyZRGf5tLfvh8n9UMhwPecC6+DTkhheUY5jmf6YefCI7N4 pw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t8tsv0f30-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Sep 2023 22:42:07 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38LKGkbt000872;
        Thu, 21 Sep 2023 22:42:06 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2047.outbound.protection.outlook.com [104.47.51.47])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t8u2n0d9y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Sep 2023 22:42:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aaarj3aiq2rMKEj55sIxLjaYbeiiz55Le/cI4WH3Qlv0yMwq7gvcVvELYjyyWn3Zk4WKp1nt6b+0zWMByQIMU8Q9H31ZV+8VWlOeQ5el9B7ZIgeXSwxQa6Obb8Vx20jiP/StEtM7d3kkfMFbvnPnrK19Urql7pdLpnFNBvw9kf9Vfh0OoRgc8X+3xCyhQC/Gc7h63c1U/Bf3hPAgd0BEaxmaxIg4xBDt3EjG7NOdGKacbeGZ/yyzZG//rqT941dBhLHBtD0hdv2FNrlTlMc0ku5ma7OBN1oYB+FvsKwApaPi6FO5wvNegMBWh8Wg72yFXxYJNT1ky2uZYI4KM2icJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96ZCWnTlzagJIs+YO30TUgyvple5RxCW56s+Lg7ZJRY=;
 b=nnjWHeqqUTueRNus+Io55+o3wMFRyp5ixjXjRhtbrWoglEhpODzB/LmLanpgzEUPxo/Hrfi+UT3wXGWREobliYeBqItrt7zdW7GhQrnHm/z+s0sSBU6nY/xN+cjhwVXwmB78ZIVsNNeNHosMNVkCQ9vCMUDJ4q9o0lG0WjPTH+DHOYtCX6gRTB1XVoAI6ocRyO4V2VgDTH7RQfbyDsjme/8Vh7jG361vD3kQ4YL3MKNh8gVSESkPuxpVcjNmV6/FjlbBdc6BTsPCoSxxp9ksXYpjz9u7iQudu+TgaIezaI2UtrXzaGHI12jYYb4PJDBorh+Lj/HGyI/+kzODyyQe1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96ZCWnTlzagJIs+YO30TUgyvple5RxCW56s+Lg7ZJRY=;
 b=jz6vVgrp94AcnneMBXz+iEqBsOT80Tw0gAypi4m42fc/ghF5zqUigj+h0WcufaZnYdrqAs7lEYC4709jyQJlyyXztM1fOu8ah2N9xml2O0xbI+Je30Tu+a0dPPIQA/qo4KdUeUQBnXbpkWvEK/znNTG0wqQp1ZcSJGTmzWNROxM=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CY8PR10MB6801.namprd10.prod.outlook.com (2603:10b6:930:98::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Thu, 21 Sep
 2023 22:42:03 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%5]) with mapi id 15.20.6792.026; Thu, 21 Sep 2023
 22:42:03 +0000
Date:   Thu, 21 Sep 2023 15:42:01 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     riel@surriel.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        muchun.song@linux.dev, leit@meta.com
Subject: Re: [PATCH 1/2] hugetlbfs: extend hugetlb_vma_lock to private VMAs
Message-ID: <20230921224201.GB21193@monkey>
References: <20230920021811.3095089-1-riel@surriel.com>
 <20230920021811.3095089-2-riel@surriel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920021811.3095089-2-riel@surriel.com>
X-ClientProxiedBy: BYAPR21CA0013.namprd21.prod.outlook.com
 (2603:10b6:a03:114::23) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CY8PR10MB6801:EE_
X-MS-Office365-Filtering-Correlation-Id: af657992-6c80-4a78-1066-08dbbaf3f97c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: chBrfa67wxwnf8neP6C34W+yOQLv5pHC6MPvTJ0iy71BWDTRBdhfn0fMj6y85a4SwxajYGBR3GGCaXTTdFm1/FVtxZofgr2AvZpY4f4t0vL0iGFkRvaG25ieGryMZhYnx0mQg0B3cwu8dAcX6WQBdlNL2ZklhjwtlTFCgfEXo181wJRfFWvfS0+PfSpFjsLXJkA3f08js3F/EJB7X+lPKmxJ2eyorBJdrPBUSGw4LaikpTBorxnxJ+W3fru4ET6XKt9AsNxqFWcVni/FmjJyAu97Pefr7NP15Q8vOQDOtTjiwnyeERcTT0CVpZkl+MqDqIWPB2UH94tfGIxmsqCJkIgrT2Xszzp0GLsPxPxTgIemcquJf7G9KFWNoXz4YE4eOk5qqD7RcXkOwMrvpahOpB4yzzPRmT17sdNVh/GJRH8JxWk/gtWQgiev/Dkh3/LT3e5MmZzQnNzU0L5Thsg5Hu9ToQwPhLlhK0JC18jRGwP6EsirAgW+8MO4bL+REgBu2+MDzfPVtwFVrbko0Eh/35wit6gF97Hjyk8zSnpB3t8F8th8G8Nvl6kNNn1LZtPOJ40mOm8YeL4RewIFgIwKXFn94ofd7UnmrEOnDXJRUqM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(136003)(376002)(346002)(396003)(366004)(451199024)(186009)(1800799009)(1076003)(8676002)(44832011)(8936002)(5660300002)(4326008)(6506007)(53546011)(6512007)(9686003)(26005)(6486002)(83380400001)(316002)(6916009)(66946007)(66556008)(66476007)(41300700001)(86362001)(33716001)(33656002)(478600001)(966005)(2906002)(38100700002)(505234007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nZXChnYaLlh+nL0GyviPTu9GoDNrDZUsYu2ypKnzaGoBKq8hKHhnoinqeywQ?=
 =?us-ascii?Q?KcAkkBYifVGlZMWr/+Tli21Q845ki5TTxHZeVM3TEc1C9FCw3CPXpWU9inAo?=
 =?us-ascii?Q?yNJ5Blg9nxWhzVBQYQw0u/PMjz6BjgjlS8qzkPlPCMycODO9EE6RkYlxdw+d?=
 =?us-ascii?Q?uwrTJAYmIWe/64GzwzK3B8Ei9Tt+LMaX2dA7vHoUY1JlZCuCaHIBHvSQNBQK?=
 =?us-ascii?Q?feFKmuYB98oxyTSu2rdbZkkRWXKFpLV6kfKBtXdqQ7BoPbW/J8jPeFgrJvoN?=
 =?us-ascii?Q?x7twiJldIczae76i2IY7ympQgH48DxRcWy129TII2+hdWcinixVB/B83/S1M?=
 =?us-ascii?Q?pHXZlSd+sCcFlrw483AVt+gPAYUki3aF+6erUNa/YqscI1egkJSfF/sWIzYG?=
 =?us-ascii?Q?cTQqHjikkIQJzwUs50Qu+0oWNSC6MfrO1Ve1trkL3shXZ6IXRrp8AjGngjzZ?=
 =?us-ascii?Q?ufC7d2cFZedcxzIUVk1eAtMYmRBmQRdDL7ekPcbm0ypw0pKE5F6MJpM4ex+/?=
 =?us-ascii?Q?NieqdiK1Btv8gA/yxvc0QuMhRJZBd8RwHFJ5onvaqzdgWgXwpJe7Jzpj+wq9?=
 =?us-ascii?Q?IexWuFEWnhQRKfS/t3l8ZvRxqAEXekLviLSMrCEPtkYoCZM1ogzyjflovs6q?=
 =?us-ascii?Q?hw5dki3fNOOs35sVJJDhD42TNnWvk4n15g9DD8po/Vn483qAp6/XaBmXfctB?=
 =?us-ascii?Q?3y69uJHQunE/EPLBB+PzMpCL0UXaGQkPwiOAKxD1fS9d/M4nTH65KASnM+Kl?=
 =?us-ascii?Q?JRYfNJVAuk5O3dN12AmMBbHvksqiMlKSgzhxNVpGsTOcCA/ZxQ2AHQWHnkVK?=
 =?us-ascii?Q?k9izsJnbasp+DoYyRx5H43pdKFtzALf925d8EtmJey9GYSlehMPe7o2swigB?=
 =?us-ascii?Q?iElwIIm1CL6WOdDYJRxi75hwEAtmHz4OkQbf6eJREvxS+T2oHBJCv36ORbhP?=
 =?us-ascii?Q?nyfY+Iw8cpWHeBdlyFNeggGz8S4oZ3gycmlzwsYvJG0z8z459/hvHhfHbUnd?=
 =?us-ascii?Q?11HWertnlo0hfkad07LOeBMb2s30HtN3Amvl7nMmwVdSCZSqti35fUWyFsLm?=
 =?us-ascii?Q?QnRULedsg7PxvPAJGgBZRERgsNXXOCUFY3gk5esoN8LoGjZHygJDq4Fjp/RW?=
 =?us-ascii?Q?njyw4wXSSUoh49eEu/1f68K3XFlNtuEBH9CPx71VMt/f3AC06yyqjXGT4+w3?=
 =?us-ascii?Q?F19Pzt1VsButVfYJpCzs2ji7CtqZMlqjaz2/r9tF+kPNLPcOa5DywWCMvgLo?=
 =?us-ascii?Q?xJWC5LIgw/R7qvQ6BRIvbeghMSePW5xfdta4a4UKqUAAMiinFtXcXLOkY8CH?=
 =?us-ascii?Q?r62zRaDcU8rBx9I1H6KezpP8ZqN3gAlgbx5FS/yc86HorrX0MBJFejwZ01gY?=
 =?us-ascii?Q?+WOf9I8TIN6iLvh3eUrI/Ie9AQwzhi4jAGdOWkC6H1R0mU3Ff3L1tfQx95bO?=
 =?us-ascii?Q?3P/2RocB/xCumk8M9BQPHteSjTyIUktGjnMzJgWVVqoAsd+p8I/DndPbxDl8?=
 =?us-ascii?Q?4+6W6dyZkAajRqnRWjLP0eyhhi6I2ao3h47jKsV7xtgCi7XhZxJPUsdLSfEf?=
 =?us-ascii?Q?4dASJTg7O8numArGkfdh72D+ClCH7w3JvNHZUuqzYtyi00z4oyGUlk0j5D/w?=
 =?us-ascii?Q?Mw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: q70Ebb6nNAg+wP78MSE7bWou4DgqRgOoiD1A7n54fTPHiDd7sbEeVpkXv0XJVaK3zj+7krGxavMo8OYkM1wW/Yso05hi4wQyBkOD72eXFfRdISvz2/UR0Ce1In2uiowpnCW8Kk1cIKcRWy+/nFn5QrxgyFJB8v52C5R3eXcgl7ruufCFRz9MCoJXXK4NQmKSSd7pWVUzlgX69F8Nzdf8/u5jF3hIhsJHmoKKFzcnesgKAKmwk4bLyzo4v94/A5j5d2Mg9kgZJnaOGl1UCRWtZUod2LTYHDwM8LzlOgRG0PvD/GU9R1N+bMC4O+2R7MkYu2jBjgWLazCFYpfQo/KdN4eyuVBp/TUoNtb9B+G34rWEvNiyl4N81DwE0tW3wGEEp+W1jxnrRk3zs08KNmjqzICYQUU1ZMUyeF5Z3uxi4Ho2L6l9DxTffkdzPx7kCNcaDdxI2tUAKtyJaVHOidYoDvBV1QHCDG2+VBW/gArcqZNQBUF0e54eac+gAHwK5zE52s8anyOwx5eZ8EySK7bj2LP8YCZx1kg26J6nklbxjDTxwuqVaYtJPV+Tyf5sV6P6ddvhDivAI7hBPnil0/SIOO/jGkror/hzAWMSk225HJpLXsP42KPn6r0sCczPtkbuSn9uzy7d/CXVDsEL2Rm56zhdD02ogavye9VLODT5wfxT/0F0RDMx2fToptQNmBOfTn1jLlz0xf85v5CuHTUswmXo3eJJR4Sc1wiEBzX8fbpZimTLQbjJBX/JfGfh2hLni/XXoG+r40OtMdUTy6ZixJXguKDkT1aV2Cs4gpLGNqFZH1NXp7eegOPw/rExUuXw0cj6rA38zA76T3If4SVhiA/9QmKWz2FsngHKKhcIZsG+rtzeq+aXkX1Nv4k18WgdxzizHZggaEXaqokXJUR7cuEOp+4UQTFzDZGhYsp8s+g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af657992-6c80-4a78-1066-08dbbaf3f97c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 22:42:03.1467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WIPnQQ2CDfQS/NI/WVhRQI6DCGK0HH6evOGDWykLzZmERDLigsMEEfJgYg0XxvwWwVB6pTbTHWvW5Qvu7IjFMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6801
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-21_19,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxlogscore=547 phishscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309210196
X-Proofpoint-ORIG-GUID: ASZXSnr9ihbqI_kWMu3eT0Vb5XXlGYOq
X-Proofpoint-GUID: ASZXSnr9ihbqI_kWMu3eT0Vb5XXlGYOq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/19/23 22:16, riel@surriel.com wrote:
> From: Rik van Riel <riel@surriel.com>
> 
> Extend the locking scheme used to protect shared hugetlb mappings
> from truncate vs page fault races, in order to protect private
> hugetlb mappings (with resv_map) against MADV_DONTNEED.
> 
> Add a read-write semaphore to the resv_map data structure, and
> use that from the hugetlb_vma_(un)lock_* functions, in preparation
> for closing the race between MADV_DONTNEED and page faults.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>
> ---
>  include/linux/hugetlb.h |  6 ++++++
>  mm/hugetlb.c            | 36 ++++++++++++++++++++++++++++++++----
>  2 files changed, 38 insertions(+), 4 deletions(-)

This looks straight forward.

However, I ran just this patch through libhugetlbfs test suite and it hung on
misaligned_offset (2M: 32).
https://github.com/libhugetlbfs/libhugetlbfs/blob/master/tests/misaligned_offset.c

Added lock/semaphore debugging to the kernel and got:
[   38.094690] =========================
[   38.095517] WARNING: held lock freed!
[   38.096350] 6.6.0-rc2-next-20230921-dirty #4 Not tainted
[   38.097556] -------------------------
[   38.098439] mlock/1002 is freeing memory ffff8881eff8dc00-ffff8881eff8ddff, with a lock still held there!
[   38.100550] ffff8881eff8dce8 (&resv_map->rw_sema){++++}-{3:3}, at: __unmap_hugepage_range_final+0x29/0x120
[   38.103564] 2 locks held by mlock/1002:
[   38.104552]  #0: ffff8881effa42a0 (&mm->mmap_lock){++++}-{3:3}, at: do_vmi_align_munmap+0x5c6/0x650
[   38.106611]  #1: ffff8881eff8dce8 (&resv_map->rw_sema){++++}-{3:3}, at: __unmap_hugepage_range_final+0x29/0x120
[   38.108827] 
[   38.108827] stack backtrace:
[   38.109929] CPU: 0 PID: 1002 Comm: mlock Not tainted 6.6.0-rc2-next-20230921-dirty #4
[   38.111812] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc37 04/01/2014
[   38.113784] Call Trace:
[   38.114456]  <TASK>
[   38.115066]  dump_stack_lvl+0x57/0x90
[   38.116001]  debug_check_no_locks_freed+0x137/0x170
[   38.117193]  ? remove_vma+0x28/0x70
[   38.118088]  __kmem_cache_free+0x8f/0x2b0
[   38.119080]  remove_vma+0x28/0x70
[   38.119960]  do_vmi_align_munmap+0x3b1/0x650
[   38.121051]  do_vmi_munmap+0xc9/0x1a0
[   38.122006]  __vm_munmap+0xa4/0x190
[   38.122931]  __ia32_sys_munmap+0x15/0x20
[   38.123926]  __do_fast_syscall_32+0x68/0x100
[   38.125031]  do_fast_syscall_32+0x2f/0x70
[   38.126060]  entry_SYSENTER_compat_after_hwframe+0x7b/0x8d
[   38.127366] RIP: 0023:0xf7f05579
[   38.128198] Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
[   38.132534] RSP: 002b:00000000fffa877c EFLAGS: 00000286 ORIG_RAX: 000000000000005b
[   38.135703] RAX: ffffffffffffffda RBX: 00000000f7a00000 RCX: 0000000000200000
[   38.137323] RDX: 00000000f7a00000 RSI: 0000000000200000 RDI: 0000000000000003
[   38.138965] RBP: 0000000000000002 R08: 0000000000000000 R09: 0000000000000000
[   38.140574] R10: 0000000000000000 R11: 0000000000000286 R12: 0000000000000000
[   38.142191] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   38.143865]  </TASK>

Something is not quite right.  If you do not get to it first, I will take a
look as time permits.
-- 
Mike Kravetz
