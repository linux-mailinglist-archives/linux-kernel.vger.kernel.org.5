Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411FA777B16
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 16:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235912AbjHJOow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 10:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235879AbjHJOou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 10:44:50 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286FF26B7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 07:44:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tl9dysw3lXPeA6zL56sWZAojDkbAy5wIVmh/Z5ScY1f4P//fxyd4stVTv5sdY5XuQ9++xd6KZatEKMqYeN+vHa1EY9grmzfN/7VA4md9VgY+hcw858DmvGFoT3o2GMHNSokOeYtIyCj0hPPeaKDwko8BkEoa4WqBwXZFJvMovqUW3x/r/EJpVXpRD829o7NTQdyQO1YGNEQ3Sj3TuRSqXUBOgftn3o+OqKP96TOVYo4RQdUZ7gVph/S5ziLPuwwwZxpm/B5q9fnOrWjqUADLRkgT7WMOdUc8nC8ajAqElBMklElQ/uLAgNvKcWRpF/624AHtwtnMBMR3qXQ3CBT3pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1jXq1+Lw0GgsOnLFVMw8o3z593F1lkNpYNqMcPD6Y4=;
 b=g4qVGCPRm5Qo1AWb1UpauQIJmNdJ/JzlS3Hb+cV+esLSlbiNIEu/3MHra3Dyqf/4xNo8+x1jrowIOUG8NiqpHu2OmwTgG4c6HAtlLebYXAPyVZqklmstFpY6bvOcQiNqycs5U22lEG0ikSzv2I8dpWvS7j3THOfBeX+bXOtTglW4qb5CkcvHsTZ7lNZqI59elcM1fre7tzTE3On96rU3Lsv+4e6YV5i+N+000xvgGVvPoKF3srPXfmmNF5cpQnjA+PwAkg2lFF9sUQBVkfm4FJcS0tJQh+UNPriGPGzUoFDxzkgCHeec0X+oaum/l+ZGmXUP6Vl/q382c75OEnhudg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1jXq1+Lw0GgsOnLFVMw8o3z593F1lkNpYNqMcPD6Y4=;
 b=orKQaISFxiTThg5D1hi+4qcQqyzZ4VP2pep9JmP3BQGgD1GUSRUItKsnBuLQ4tlpbdzNVLxrYpeY3Nb/wN0q2E6lVVRCKjYj7tN9hlmUnJPNGRRdtyRn/8z3uI8PUrNETpG1Y7LMQQgPJXQK3XJqe1HiKVxPpI5g0NXdGG7TJ1nagjHJ9jq0e0MKxEUm1Z7iMSQO7DcltPx0GC3D4tFUbP7hSgUOccI8ZTfx/ZCVtBBSz02o9ibkwp9xVGtBLd4DNrWsCCB0BY6CLO8S4roC2Yn1nd+Hfg1eMqTX1Kw0WR8G4KbwW+A4Vhnd0g/UJv7JX0Vfk58GWKoswI3NGq3dxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SA0PR12MB4509.namprd12.prod.outlook.com (2603:10b6:806:9e::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.30; Thu, 10 Aug 2023 14:44:46 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::c166:b535:d93:641e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::c166:b535:d93:641e%4]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 14:44:46 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/4] mm/mmu_gather: Store and process pages in contig
 ranges
Date:   Thu, 10 Aug 2023 10:44:43 -0400
X-Mailer: MailMate (1.14r5964)
Message-ID: <800937DA-BAD0-4C60-B155-AECCA21E955E@nvidia.com>
In-Reply-To: <20230810103332.3062143-5-ryan.roberts@arm.com>
References: <20230810103332.3062143-1-ryan.roberts@arm.com>
 <20230810103332.3062143-5-ryan.roberts@arm.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_69966ED2-8E8A-4A36-A182-AD4C008DDB29_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0223.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::18) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SA0PR12MB4509:EE_
X-MS-Office365-Filtering-Correlation-Id: d5d940e2-1f53-403d-e6a8-08db99b0575d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MKh4LS9CDDhz4DYWL7J9ATjW4Qbg7Q2IaQYxGS8rhdg69ggACGK+ALQ29nsk1Y98ETqbztkAXMs6bDhaWhyIdV2stnaiPFiFe3OdAFwuydhylx2wg/N870dZNi0yvsMPbCeHpQSgRRtelg274ED2Kk0JWNmvq+ExUQyunFPziBLZgo1gG87kiRZsEmU8bLgFIdbswVIh3Aaa+CBVZYh8OCjAKysViZ37TEN0xMlA7ddcHWGtVrlEPyFTnv34BIY0QsftnojDTtN+DAdpdTA7gfusI9X3Uz+CccUt2g/1XhaO6rG8McFFPDVPSUF4AwhZaNBvMZKOWKWqqVZdeyAh5BQBtHDkaBGQAQyQDnUqOo0Q2S3dcNYM+Sh0qZ/mSjV4TmOMG0xZJjY7o/MzccG3PdGQk6+j5agr77/voCAWrYBvfJTskhB9UOb+SALAVwyS7ppq7vxY7W/cnztJ5+Jo4bMd23gq+HPvnMRuaINBZRWK9A1UPtTzXiEgKJ45p+b6oejvSSt/H3t0lTLEoJ5SD29McCq/XrBn6DGfpoau34gT0hnhEWjiFWQUVQdBPWfRdnG76PS7OaUPYh5k1PuHjhexDBRI7BASZCrHwbKME9RYD7XduXYAWiuBh/Dob1qytgeRCJpvMT2WLOBKK9ldVOCM5oZuKMGmtNNLjI0Cr7lU8tQ6YCd5Du1zLJh5pye9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(346002)(136003)(376002)(396003)(186006)(1800799006)(451199021)(36756003)(86362001)(33656002)(66946007)(6666004)(478600001)(53546011)(66556008)(66476007)(6916009)(54906003)(26005)(6486002)(6506007)(6512007)(30864003)(2906002)(41300700001)(7416002)(316002)(4326008)(235185007)(8936002)(5660300002)(8676002)(38100700002)(83380400001)(2616005)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9AsM+KvJELcHvW/XDiYc9jKvcPP/FkMjs0W2vqR4ZnKNaOYy8G3EixlA8qnt?=
 =?us-ascii?Q?6+i5my6yawr82yXyhX4AcAinkQnLVRFAaRWC1DHTTuv+dLZcNCv0x1T1O6+1?=
 =?us-ascii?Q?1zef78ju5GXVQIrg6PWqkQ79buPMnM6PWokioBK3VJXi1YU+rRDWxN7esLIU?=
 =?us-ascii?Q?o1z3zXYHnUgPNjcp6TtPtiETFkl3CQW/seVMWCEn3fCnDYx6j6b9iVyalQZb?=
 =?us-ascii?Q?Romy1N1OlF1DiyPQL5oP34gXouND9VbX8rtpMRbxgliJJq00is6MiIRTunPo?=
 =?us-ascii?Q?ZFDu0kgE010w1AdDWBKVNGRchYXitCl9EWV9BWB7zXSxixmdTgaN13Ep8mU+?=
 =?us-ascii?Q?KuXZ4q718AxzMqFe8dDH+BI3mMYyS2ifTiQMlT2isN2vntuzKLwGWWyGAj58?=
 =?us-ascii?Q?OCWa2+pP5g49GZNTqSmYdAnBCVyxxA2aCdAAyi5K1g17+o48mGkhNfASXoLM?=
 =?us-ascii?Q?evNdHfAPMo8doVqvDdkGl61kA1dyNYumvzVd0s8h4+DBfRhpwcV/zvG6GoYL?=
 =?us-ascii?Q?qmgzmawVB1C3LF7EUeWJY1HVmQTu4T9N1+q2ZHKeFJBpsJCiPmf99mOdxR8c?=
 =?us-ascii?Q?RC8lOGn9og5PKKNaUCYhpRyy94hPjeq+ML5fXmNh3JtSThhh+1nKbQkg1+2t?=
 =?us-ascii?Q?7WtXmZtNud/6HUhFbqalD2+0UY4U5v74wEw9GR4YaNycMrfHhddNJNcyxuAr?=
 =?us-ascii?Q?cxM5bcwaOMSi+9EiKBQpmcbwddCV0ASApaFrViNKE7w0v83R8rsRWj6eh5CL?=
 =?us-ascii?Q?lgMLwAi1ZRDQfKWKfIsk1mvXv6MZUNv0cpsOTxO7NProATzMqvx8AOCrlUxN?=
 =?us-ascii?Q?AE0ijbCZ7Y56YvqP0IdF/vqibe0+W6XSdfxnrl9dbY14gjTP+i4YMtWD+470?=
 =?us-ascii?Q?N7MyDQngroIL2hvP/K9FV/iYqAubHsU/t6nHGB9p4ImBBYbHQkcBdW5L/omz?=
 =?us-ascii?Q?U+U+A7Wq3JSdOwDw1OtM7KsqAtYOVMTDOLEQ0PXQ05q5Xz9fALvyF2WdOiLi?=
 =?us-ascii?Q?orqyw5bDjMNYF8PNmewyQEP+FS8OdvQ1uE1I6KZAWjq2qamegaSAHCM3nAAo?=
 =?us-ascii?Q?tYjKD3nzP2uD0IPlEb02HiGEVw8f7hR1WVeO199POicnciN6+OqoTGTOk0EC?=
 =?us-ascii?Q?KdVlniHHvtJFzdGZuQb/w9mAHYsY9CGwNO5xTf0/3OLc8LYQfhhuqEa9Yks4?=
 =?us-ascii?Q?OdNy5Zx6uff/1Cekw7k/J7aSC6qSkW3Tkpz7ZGrGxSbR85pvkrrco2Cqk6yq?=
 =?us-ascii?Q?pliSSqoh4EociXtCZsJx0yF/6xVyxHex1mVfxqbV7OlVD9/Afb1dkEbctHuO?=
 =?us-ascii?Q?enkJm+EmuB4e7OUWd02kUJ6hMSG4XiJ/v+TdV9E6OgQtfnUwB8pT3Y6Was0+?=
 =?us-ascii?Q?LaJTFduDausBsCQ3UDB8CufiajkQl2pg35+xo9SOy7adv5jPU8/pLQEWaZpM?=
 =?us-ascii?Q?qm/1fdMm74UDH+VYrMlgqHnH+JNVx9f1U6q8dJDSkrWPvqaWxaK5XmWAkSbc?=
 =?us-ascii?Q?vbI0uiYU4s3VPlpvYnD0IaXC+1T4QQI3SI52NVH7QO8JL1TVh4ryL4V+/OzN?=
 =?us-ascii?Q?KPNQZC9k+ccetk8TKOlD+JKUIapkzRvlXOHhjBA1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5d940e2-1f53-403d-e6a8-08db99b0575d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 14:44:46.3250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tL4UMtnlFWksqTXWdrcMbY7TgKdQ07qFp4aZmEn3HrtSK2ZGIqH2u6I/DF8/+mvA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4509
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_69966ED2-8E8A-4A36-A182-AD4C008DDB29_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 10 Aug 2023, at 6:33, Ryan Roberts wrote:

> mmu_gather accumulates a set of pages into a buffer for later rmap
> removal and freeing. Page pointers were previously stored in a "linked
> list of arrays", then at flush time, each page in the buffer was remove=
d
> from the rmap, removed from the swapcache and its refcount was
> decremented; if the refcount reached 0, then it was freed.
>
> With increasing numbers of large folios (or at least contiguous parts o=
f
> large folios) mapped into userspace processes (pagecache pages for
> supporting filesystems currently, but in future also large anonymous
> folios), we can measurably improve performance of process teardown:
>
> - For rmap removal, we can batch-remove a range of pages belonging to
>   the same folio with folio_remove_rmap_range(), which is more efficien=
t
>   because atomics can be manipulated just once per range. In the common=

>   case, it also allows us to elide adding the (anon) folio to the
>   deferred split queue, only to remove it a bit later, once all pages o=
f
>   the folio have been removed fro mthe rmap.
>
> - For swapcache removal, we only need to check and remove the folio fro=
m
>   the swap cache once, rather than trying for each individual page.
>
> - For page release, we can batch-decrement the refcount for each page i=
n
>   the folio and free it if it hits zero.
>
> Change the page pointer storage format within the mmu_gather batch
> structure to store "folio_range"s; a [start, end) page pointer pair.
> This allows us to run length encode a contiguous range of pages that al=
l
> belong to the same folio. This likely allows us to improve cache
> locality a bit. But it also gives us a convenient format for
> implementing the above 3 optimizations.
>
> Of course if running on a system that does not extensively use large
> pte-mapped folios, then the RLE approach uses twice as much memory,
> because each range is 1 page long and uses 2 pointers. But performance
> measurements show no impact in terms of performance.
>
> Macro Performance Results
> -------------------------
>
> Test: Timed kernel compilation on Ampere Altra (arm64), 80 jobs
> Configs: Comparing with and without large anon folios
>
> Without large anon folios:
> | kernel           |   real-time |   kern-time |   user-time |
> |:-----------------|------------:|------------:|------------:|
> | baseline-laf-off |        0.0% |        0.0% |        0.0% |
> | mmugather-range  |       -0.3% |       -0.3% |        0.1% |
>
> With large anon folios (order-3):
> | kernel           |   real-time |   kern-time |   user-time |
> |:-----------------|------------:|------------:|------------:|
> | baseline-laf-on  |        0.0% |        0.0% |        0.0% |
> | mmugather-range  |       -0.7% |       -3.9% |       -0.1% |
>
> Test: Timed kernel compilation in VM on Apple M2 MacBook Pro, 8 jobs
> Configs: Comparing with and without large anon folios
>
> Without large anon folios:
> | kernel           |   real-time |   kern-time |   user-time |
> |:-----------------|------------:|------------:|------------:|
> | baseline-laf-off |        0.0% |        0.0% |        0.0% |
> | mmugather-range  |       -0.9% |       -2.9% |       -0.6% |
>
> With large anon folios (order-3):
> | kernel           |   real-time |   kern-time |   user-time |
> |:-----------------|------------:|------------:|------------:|
> | baseline-laf-on  |        0.0% |        0.0% |        0.0% |
> | mmugather-range  |       -0.4% |       -3.7% |       -0.2% |
>
> Micro Performance Results
> -------------------------
>
> Flame graphs for kernel compilation on Ampere Altra show reduction in
> cycles consumed by __arm64_sys_exit_group syscall:
>
>     Without large anon folios: -2%
>     With large anon folios:    -26%
>
> For the large anon folios case, it also shows a big difference in cost
> of rmap removal:
>
>    baseline: cycles in page_remove_rmap(): 24.7B
>    mmugather-range: cycles in folio_remove_rmap_range(): 5.5B
>
> Furthermore, the baseline shows 5.2B cycles used by
> deferred_split_folio() which has completely disappeared after
> applying this series.
>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  include/asm-generic/tlb.h |  7 +--
>  include/linux/mm.h        |  7 +++
>  include/linux/swap.h      |  6 +--
>  mm/mmu_gather.c           | 56 ++++++++++++++++++++----
>  mm/swap.c                 | 91 +++++++++++++++++++++++++++++++++++++++=

>  mm/swap_state.c           | 11 ++---
>  6 files changed, 158 insertions(+), 20 deletions(-)
>
> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
> index d874415aaa33..fe300a64e59d 100644
> --- a/include/asm-generic/tlb.h
> +++ b/include/asm-generic/tlb.h
> @@ -246,11 +246,11 @@ struct mmu_gather_batch {
>  	struct mmu_gather_batch	*next;
>  	unsigned int		nr;
>  	unsigned int		max;
> -	struct page		*pages[];
> +	struct folio_range	ranges[];
>  };
>
>  #define MAX_GATHER_BATCH	\
> -	((PAGE_SIZE - sizeof(struct mmu_gather_batch)) / sizeof(void *))
> +	((PAGE_SIZE - sizeof(struct mmu_gather_batch)) / sizeof(struct folio_=
range))
>
>  /*
>   * Limit the maximum number of mmu_gather batches to reduce a risk of =
soft
> @@ -342,7 +342,8 @@ struct mmu_gather {
>  #ifndef CONFIG_MMU_GATHER_NO_GATHER
>  	struct mmu_gather_batch *active;
>  	struct mmu_gather_batch	local;
> -	struct page		*__pages[MMU_GATHER_BUNDLE];
> +	struct folio_range	__ranges[MMU_GATHER_BUNDLE];
> +	struct page		*range_limit;
>  	struct mmu_gather_batch *rmap_pend;
>  	unsigned int		rmap_pend_first;
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 914e08185272..f86c905a065d 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1513,6 +1513,13 @@ static inline void folio_put_refs(struct folio *=
folio, int refs)
>  		__folio_put(folio);
>  }
>
> +struct folio_range {
> +	struct page *start;
> +	struct page *end;
> +};

I see end is used for calculating nr_pages multiple times below. Maybe ju=
st
use nr_pages instead of end here.

Also, struct page (memmap) might not be always contiguous, using struct p=
age
points to represent folio range might not give the result you want.
See nth_page() and folio_page_idx() in include/linux/mm.h.

> +
> +void folios_put_refs(struct folio_range *folios, int nr);
> +
>  /*
>   * union release_pages_arg - an array of pages or folios
>   *
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index f199df803b33..06a7cf3ad6c9 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -453,7 +453,7 @@ static inline unsigned long total_swapcache_pages(v=
oid)
>
>  extern void free_swap_cache(struct page *page);
>  extern void free_page_and_swap_cache(struct page *);
> -extern void free_pages_and_swap_cache(struct page **, int);
> +extern void free_folios_and_swap_cache(struct folio_range *, int);
>  /* linux/mm/swapfile.c */
>  extern atomic_long_t nr_swap_pages;
>  extern long total_swap_pages;
> @@ -530,8 +530,8 @@ static inline void put_swap_device(struct swap_info=
_struct *si)
>   * so leave put_page and release_pages undeclared... */
>  #define free_page_and_swap_cache(page) \
>  	put_page(page)
> -#define free_pages_and_swap_cache(pages, nr) \
> -	release_pages((pages), (nr));
> +#define free_folios_and_swap_cache(folios, nr) \
> +	folios_put_refs((folios), (nr))
>
>  /* used to sanity check ptes in zap_pte_range when CONFIG_SWAP=3D0 */
>  #define free_swap_and_cache(e) is_pfn_swap_entry(e)
> diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
> index 5d100ac85e21..fd2ea7577817 100644
> --- a/mm/mmu_gather.c
> +++ b/mm/mmu_gather.c
> @@ -22,6 +22,7 @@ static bool tlb_next_batch(struct mmu_gather *tlb)
>  	batch =3D tlb->active;
>  	if (batch->next) {
>  		tlb->active =3D batch->next;
> +		tlb->range_limit =3D NULL;
>  		return true;
>  	}
>
> @@ -39,6 +40,7 @@ static bool tlb_next_batch(struct mmu_gather *tlb)
>
>  	tlb->active->next =3D batch;
>  	tlb->active =3D batch;
> +	tlb->range_limit =3D NULL;
>
>  	return true;
>  }
> @@ -49,9 +51,11 @@ static void tlb_flush_rmap_batch(struct mmu_gather_b=
atch *batch,
>  				 struct vm_area_struct *vma)
>  {
>  	for (int i =3D first; i < batch->nr; i++) {
> -		struct page *page =3D batch->pages[i];
> +		struct folio_range *range =3D &batch->ranges[i];
> +		int nr =3D range->end - range->start;
> +		struct folio *folio =3D page_folio(range->start);
>
> -		page_remove_rmap(page, vma, false);
> +		folio_remove_rmap_range(folio, range->start, nr, vma);
>  	}
>  }
>
> @@ -75,6 +79,11 @@ void tlb_flush_rmaps(struct mmu_gather *tlb, struct =
vm_area_struct *vma)
>  	for (batch =3D batch->next; batch && batch->nr; batch =3D batch->next=
)
>  		tlb_flush_rmap_batch(batch, 0, vma);
>
> +	/*
> +	 * Move to the next range on next page insertion to prevent any futur=
e
> +	 * pages from being accumulated into the range we just did the rmap f=
or.
> +	 */
> +	tlb->range_limit =3D NULL;
>  	tlb_discard_rmaps(tlb);
>  }
>
> @@ -94,7 +103,7 @@ static void tlb_batch_pages_flush(struct mmu_gather =
*tlb)
>  	struct mmu_gather_batch *batch;
>
>  	for (batch =3D &tlb->local; batch && batch->nr; batch =3D batch->next=
) {
> -		struct page **pages =3D batch->pages;
> +		struct folio_range *ranges =3D batch->ranges;
>
>  		do {
>  			/*
> @@ -102,14 +111,15 @@ static void tlb_batch_pages_flush(struct mmu_gath=
er *tlb)
>  			 */
>  			unsigned int nr =3D min(512U, batch->nr);
>
> -			free_pages_and_swap_cache(pages, nr);
> -			pages +=3D nr;
> +			free_folios_and_swap_cache(ranges, nr);
> +			ranges +=3D nr;
>  			batch->nr -=3D nr;
>
>  			cond_resched();
>  		} while (batch->nr);
>  	}
>  	tlb->active =3D &tlb->local;
> +	tlb->range_limit =3D NULL;
>  	tlb_discard_rmaps(tlb);
>  }
>
> @@ -127,6 +137,7 @@ static void tlb_batch_list_free(struct mmu_gather *=
tlb)
>  bool __tlb_remove_page_size(struct mmu_gather *tlb, struct page *page,=
 int page_size)
>  {
>  	struct mmu_gather_batch *batch;
> +	struct folio_range *range;
>
>  	VM_BUG_ON(!tlb->end);
>
> @@ -135,11 +146,37 @@ bool __tlb_remove_page_size(struct mmu_gather *tl=
b, struct page *page, int page_
>  #endif
>
>  	batch =3D tlb->active;
> +	range =3D &batch->ranges[batch->nr - 1];
> +
> +	/*
> +	 * If there is a range being accumulated, add the page to the range i=
f
> +	 * its contiguous, else start the next range. range_limit is always N=
ULL
> +	 * when nr is 0, which protects the batch->ranges[-1] case.
> +	 */
> +	if (tlb->range_limit && page =3D=3D range->end) {
> +		range->end++;
> +	} else {
> +		struct folio *folio =3D page_folio(page);
> +
> +		range =3D &batch->ranges[batch->nr++];
> +		range->start =3D page;
> +		range->end =3D page + 1;
> +
> +		tlb->range_limit =3D &folio->page + folio_nr_pages(folio);
> +	}
> +
> +	/*
> +	 * If we have reached the end of the folio, move to the next range wh=
en
> +	 * we add the next page; Never span multiple folios in the same range=
=2E
> +	 */
> +	if (range->end =3D=3D tlb->range_limit)
> +		tlb->range_limit =3D NULL;
> +
>  	/*
> -	 * Add the page and check if we are full. If so
> -	 * force a flush.
> +	 * Check if we are full. If so force a flush. In order to ensure we
> +	 * always have a free range for the next added page, the last range i=
n a
> +	 * batch always only has a single page.
>  	 */
> -	batch->pages[batch->nr++] =3D page;
>  	if (batch->nr =3D=3D batch->max) {
>  		if (!tlb_next_batch(tlb))
>  			return true;
> @@ -318,8 +355,9 @@ static void __tlb_gather_mmu(struct mmu_gather *tlb=
, struct mm_struct *mm,
>  	tlb->need_flush_all =3D 0;
>  	tlb->local.next =3D NULL;
>  	tlb->local.nr   =3D 0;
> -	tlb->local.max  =3D ARRAY_SIZE(tlb->__pages);
> +	tlb->local.max  =3D ARRAY_SIZE(tlb->__ranges);
>  	tlb->active     =3D &tlb->local;
> +	tlb->range_limit =3D NULL;
>  	tlb->batch_count =3D 0;
>  	tlb->rmap_pend	=3D &tlb->local;
>  	tlb->rmap_pend_first =3D 0;
> diff --git a/mm/swap.c b/mm/swap.c
> index b05cce475202..e238d3623fcb 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -1041,6 +1041,97 @@ void release_pages(release_pages_arg arg, int nr=
)
>  }
>  EXPORT_SYMBOL(release_pages);
>
> +/**
> + * folios_put_refs - batched folio_put_refs()
> + * @folios: array of `struct folio_range`s to release
> + * @nr: number of folio ranges
> + *
> + * Each `struct folio_range` describes the start and end page of a ran=
ge within
> + * a folio. The folio reference count is decremented once for each pag=
e in the
> + * range. If it fell to zero, remove the page from the LRU and free it=
=2E
> + */
> +void folios_put_refs(struct folio_range *folios, int nr)
> +{
> +	int i;
> +	LIST_HEAD(pages_to_free);
> +	struct lruvec *lruvec =3D NULL;
> +	unsigned long flags =3D 0;
> +	unsigned int lock_batch;
> +
> +	for (i =3D 0; i < nr; i++) {
> +		struct folio *folio =3D page_folio(folios[i].start);
> +		int refs =3D folios[i].end - folios[i].start;
> +
> +		/*
> +		 * Make sure the IRQ-safe lock-holding time does not get
> +		 * excessive with a continuous string of pages from the
> +		 * same lruvec. The lock is held only if lruvec !=3D NULL.
> +		 */
> +		if (lruvec && ++lock_batch =3D=3D SWAP_CLUSTER_MAX) {
> +			unlock_page_lruvec_irqrestore(lruvec, flags);
> +			lruvec =3D NULL;
> +		}
> +
> +		if (is_huge_zero_page(&folio->page))
> +			continue;
> +
> +		if (folio_is_zone_device(folio)) {
> +			if (lruvec) {
> +				unlock_page_lruvec_irqrestore(lruvec, flags);
> +				lruvec =3D NULL;
> +			}
> +			if (put_devmap_managed_page(&folio->page))
> +				continue;
> +			if (folio_put_testzero(folio))
> +				free_zone_device_page(&folio->page);
> +			continue;
> +		}
> +
> +		if (!folio_ref_sub_and_test(folio, refs))
> +			continue;
> +
> +		if (folio_test_large(folio)) {
> +			if (lruvec) {
> +				unlock_page_lruvec_irqrestore(lruvec, flags);
> +				lruvec =3D NULL;
> +			}
> +			__folio_put_large(folio);
> +			continue;
> +		}
> +
> +		if (folio_test_lru(folio)) {
> +			struct lruvec *prev_lruvec =3D lruvec;
> +
> +			lruvec =3D folio_lruvec_relock_irqsave(folio, lruvec,
> +									&flags);
> +			if (prev_lruvec !=3D lruvec)
> +				lock_batch =3D 0;
> +
> +			lruvec_del_folio(lruvec, folio);
> +			__folio_clear_lru_flags(folio);
> +		}
> +
> +		/*
> +		 * In rare cases, when truncation or holepunching raced with
> +		 * munlock after VM_LOCKED was cleared, Mlocked may still be
> +		 * found set here.  This does not indicate a problem, unless
> +		 * "unevictable_pgs_cleared" appears worryingly large.
> +		 */
> +		if (unlikely(folio_test_mlocked(folio))) {
> +			__folio_clear_mlocked(folio);
> +			zone_stat_sub_folio(folio, NR_MLOCK);
> +			count_vm_event(UNEVICTABLE_PGCLEARED);
> +		}
> +
> +		list_add(&folio->lru, &pages_to_free);
> +	}
> +	if (lruvec)
> +		unlock_page_lruvec_irqrestore(lruvec, flags);
> +
> +	mem_cgroup_uncharge_list(&pages_to_free);
> +	free_unref_page_list(&pages_to_free);
> +}
> +
>  /*
>   * The folios which we're about to release may be in the deferred lru-=
addition
>   * queues.  That would prevent them from really being freed right now.=
  That's
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 73b16795b0ff..526bbd5a2ce1 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -304,15 +304,16 @@ void free_page_and_swap_cache(struct page *page)
>  }
>
>  /*
> - * Passed an array of pages, drop them all from swapcache and then rel=
ease
> - * them.  They are removed from the LRU and freed if this is their las=
t use.
> + * Passed an array of folio ranges, drop all folios from swapcache and=
 then put
> + * a folio reference for each page in the range.  They are removed fro=
m the LRU
> + * and freed if this is their last use.
>   */
> -void free_pages_and_swap_cache(struct page **pages, int nr)
> +void free_folios_and_swap_cache(struct folio_range *folios, int nr)
>  {
>  	lru_add_drain();
>  	for (int i =3D 0; i < nr; i++)
> -		free_swap_cache(pages[i]);
> -	release_pages(pages, nr);
> +		free_swap_cache(folios[i].start);
> +	folios_put_refs(folios, nr);
>  }
>
>  static inline bool swap_use_vma_readahead(void)
> -- =

> 2.25.1


--
Best Regards,
Yan, Zi

--=_MailMate_69966ED2-8E8A-4A36-A182-AD4C008DDB29_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmTU99sPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUYxcP/R3RYrsR9TzW5u1J4q0cqm9mxcJ6hefTJ4s0
u2aXQed/8aOfPosaL/mtYjyTyGueicuXgNEW0xnShSJttPY8Pi9CwqbEjyWdRxvY
SL7a36IfjJ2P+i34pPJnMEGGu/5MWaSfQy69cvUWiPGLE5KjI0H42d4PuY6AX+Z7
AJshfwVlhZDnHzdLzDF5m6by+L6ZGcF8ySjaNFLGcIbsDUmaCqqkcBBceXKU1n7r
1P/UfkNKqC0Cl1rZXxVvNfS4fMLI9qs85tddOABMUVH2i3A7e1eS4VGPzYRYcPGZ
yHg6Y0wvbRjg21Ia/FFtnwUvXmlI/MeOa/jVkGZ6zfK5POD3VJ8PAH3mN5QErqx7
TQ4Y+zDyPQxzefVtyB13qT4ovTby9AzbeX78uIR6Y1NjbP5Jqm8fqJYraiZ6sA2E
zlGcQloQOp1rMD+oBo0Jw3bZVlgK5XFRI/esaRFiwGQW1sinMUHTSU4lGcS14rmf
uSRmzOyRJsyJcqvEXAUJogQBg+bkdWqg6hASxOZIfCkMziGlvWWhmF53iCO8eXrK
U1do3LaihCB+JK9rerDnnIgbdEUasT0PR+2t5v83ev8OqAJGTTSnjkYjqtdvCIp9
pvP3IbG06I4jwpl6I7mDuYY7qcgOZ09l2ffWrL+F3oekbcRoJtevi2fcMoBtKQ5Z
BZVMCLrz
=LDDH
-----END PGP SIGNATURE-----

--=_MailMate_69966ED2-8E8A-4A36-A182-AD4C008DDB29_=--
