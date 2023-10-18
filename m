Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51EDD7CDE2E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344825AbjJROBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344812AbjJROBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:01:02 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB7011C
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 07:00:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aGJjf73D/71CImchomrLXFCcdyYLGi6ae2YGg7/iXR3TE2DQTp5TD2+kTn1dx/o5So5ANJJ9cPFA1Ywz81U7+Ya8sK3MB1R1oI4IB6lnMChp6YKSmZGGHFiM2P/D0ilbzO7I9IC6zeq7J52QfgkwL6NbVQgWW2ISis5ZQWKEPUIgatrLjNel7BNzr/BXq1XbPPJOEyP6I1SdzLP9G829trlh6OKsxWhjk7oGpkIuZiXQbJhb4jOAkC23nV2xG5i0XIZ8XYatZylm47howlkqTAL+yb3ipdzO8jLEBOucyGH2ogOfk6+IMAJ6u0GrbzwY9H2hPVuGHn+CE9fPcDfufw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IV3CzAlgwcsjNF8fEzkzle4KRfMlTAPesjtOdNDC6B0=;
 b=TCwXTtzMvH0a5epTCgjmQsnw9bTXkbGWENdyMOTVA7ALhEd+ZPob3qwYVpntBqtXpT28BSRC4nKgGssGxfbCLPQdWP+Cxc23OjvoWFCb2E6oBLFbmxQkwfL2dDKDQtSZIU/MaIlmx9gwaiu3XWI1soBbJMGL143Rx0cKrt5oqHKD8votjYQBrN7w65sQw7ARanlr1KqydkTKdOAWgzTarhyoaYyd7XU9XOlralzTWCUyhrUVmkFpzdAd4Qeo+VMs/IoB+7xXz+LXFM789QPmu8na18nSnlsQOsh0HD0wHFC23/I0f8+XZFAGRRk2HvNdd06VQKRItreKostY0+6+Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IV3CzAlgwcsjNF8fEzkzle4KRfMlTAPesjtOdNDC6B0=;
 b=CMZby6V12MiXXJYlwCikxSVRAg8zgeqIZ5U3JXsY3R1yAOiwZd4mYqsT6WPXuygtdZeGEFZqRH3RSPbZEE8hzce6ASue49990qF4NdJYtD/wKaWDwkQ29W9bIOJsGf9wCK/E0VrgSyYyUfknD1Yz5qIeAWg4wYvGg452stbqqrp3SFypFHtG+w+CoK+EN+fcpovHQLX4Fk7XdSEJFT7R633TpPtFJL24J4iKGvKnXmKnPJQGl4FFtUgwT5mE5kHlLofVEFvpxnG27cKtHQogLCvxm4cNoilvqnYaUCmLW0tQxwnZaPK8bzDB2LcKVGdfcSBK7S64+/Tr9xeyw4tgNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 DM4PR12MB6112.namprd12.prod.outlook.com (2603:10b6:8:aa::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6886.36; Wed, 18 Oct 2023 14:00:57 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013%7]) with mapi id 15.20.6907.022; Wed, 18 Oct 2023
 14:00:54 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        hughd@google.com, vbabka@suse.cz, ying.huang@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: migrate: record the mlocked page status to remove
 unnecessary lru drain
Date:   Wed, 18 Oct 2023 10:00:52 -0400
X-Mailer: MailMate (1.14r5994)
Message-ID: <1F80D8DA-8BB5-4C7E-BC2F-030BF52931F7@nvidia.com>
In-Reply-To: <64899ad0bb78cde88b52abed1a5a5abbc9919998.1697632761.git.baolin.wang@linux.alibaba.com>
References: <64899ad0bb78cde88b52abed1a5a5abbc9919998.1697632761.git.baolin.wang@linux.alibaba.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_0FBB91F3-34A0-46A8-831F-C24D928B29B5_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR11CA0024.namprd11.prod.outlook.com
 (2603:10b6:208:23b::29) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|DM4PR12MB6112:EE_
X-MS-Office365-Filtering-Correlation-Id: e9ef8d3c-9ab1-48f0-c15e-08dbcfe2a568
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VnRf82qNh1Sm8K9QtHlSPhGaveEsku6gMAaDnhx/81FKwllchg+NMySmj5pkaf6kPqaA+LlSCJGsNgZ9PFEznydhhxw7iK+Tk/+tEKW619JiFwfqqEYInjZ9w8T/pGH6Pu6UMCC0MNS9jE+QUIBg6+qrhLngROo4kGG1uAyegReEAjCVRVc9Uq4mA/sFoktc7ieep9Xuwfisxq4VsrkXymMnvu6KXau4yIA5of2oxXEMxJYJWb+WhHU5A+NtK/f+t2lnnNgR/CJBjegzddMxSL3Ye2wvo4YWpHagSdkgJuPKuZLwhH1EwC4hRhttUANm06HFgEhEHUQoDvx1qr+/I4xXqhsKzQ/ZG5sd9I85rWXfmxdepJ8NVv0FevJuRTjg/r/Ebwtg3dW+fDSLH6bvBnYSmbGzXXbv+FMtMhy/3mdeNioMWrzcK/pb+sYlpSC0T/5Kc4imkIWPrtynqR0L1LPVHG1xPEQUqmnthcK+dsTkjIO9EEVP1jxngJI4NWcSOqAXbKc9s9QawpWHbm76nDOgg5LpoIZ4cwslM7TGn7iJsa7Evg/tskXpPaou1UKUNJ9mWOE+gOJEeHA7eY0auJ6PfLBkLBv6ycdKunZ+St2V3aGkK0fVziOnlwa3NBzA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(346002)(39860400002)(366004)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(26005)(66476007)(6916009)(316002)(8936002)(2616005)(4326008)(6512007)(83380400001)(8676002)(66946007)(66556008)(53546011)(41300700001)(6506007)(5660300002)(478600001)(6486002)(2906002)(38100700002)(33656002)(36756003)(86362001)(235185007)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vpefOmQUnmRd+pZpwZNg+HaWrP/jCjsiLur2FYejIgmtMque3g2YFOk8a/Z6?=
 =?us-ascii?Q?Co5sL3z6enQodQwtKpfAly2iGZcO6icaYqRep6J7VNrrWWK4zT25X/bUR1Ty?=
 =?us-ascii?Q?xqZFtI2ICUv5HEnf0rmf61TTZMhxm9WQQzPvORY/ETl403QaknpzOQAB0KD9?=
 =?us-ascii?Q?2wUvVLnnON+h6ofIc2/VHRoKChcdZ/6OyZ905a3YLTJagZHYvDaMvfLPu8O7?=
 =?us-ascii?Q?2E+E85q89siP9mMTE7h1vx754kKm7Jn6XiAwiPMw+8X2i0chLgEu4YTvmVQq?=
 =?us-ascii?Q?9KcK1/tBUbSvMHbaXNtMNzL0Yskjy65cRU1+Xn+jp9o8loG+mE9zJ3q0m57X?=
 =?us-ascii?Q?ZwnDd4CEeg1mzxfx1jgZhhVYt5ctozlqcG9c091W/tCeDsGurP0wAlcvtiRe?=
 =?us-ascii?Q?OnqmhCq/oyCMuLNkWJgnqy788D0896UCjses1rLHR68KDreDzK1XkWzjwyeO?=
 =?us-ascii?Q?cBSFWeHtu2kT71j5Cw30d5Jn0ZjAD/4yaurt/dSBYGjyD0p7NMo/F5FfwTi3?=
 =?us-ascii?Q?wf3Bpp8SqEQZJCbchW9FYfcAeWxhNCqMNanqVF3Uu6Mj+NoQc4YAN1vj+/99?=
 =?us-ascii?Q?cGFncyUTclf5eNRhM4IXOXgXr90SEIOgcQv1qfn/ilE1koCTa6QHQ1vG3LEY?=
 =?us-ascii?Q?FqdyA5qlRF+MihLHof+a8V3OiqLqkNLDe2lnk/YPOfuCMhU3MP0TJPMNB6z+?=
 =?us-ascii?Q?9MUxEzCOrCKkEBHoU8ikuUIQwf2oNT5adv93+3SGMp2vOLvTms3SfSREZ8gU?=
 =?us-ascii?Q?N5rHE4HJXqniXc2iuShV75qQzzPnwMt5/G7xYFJvNKmiXsBiJBMfiwv8aFJ0?=
 =?us-ascii?Q?94zQceUjdDrSVSqevUMASIrHNq1FBlZqVm2nOxKCDyEi/e6e5syOJj5VNFzB?=
 =?us-ascii?Q?Nya8wALrLiS5QOlFRfFRPHA4BaWDKdsmJQK/sjF1dRzlzHrHUVrjUhh7QkwZ?=
 =?us-ascii?Q?EK8fQiEYY+z/EYAzUKLS62+oLH+A5zSPd/P5SW7sP5UfNrM+QULcEEmDYysl?=
 =?us-ascii?Q?+QHdRo2sjOo/7W1IRNjFZbSBFQEZIxvHuLTQGVcCRpsV3Fo5cWjcKn18B0Li?=
 =?us-ascii?Q?03Op1rSgm8LygBVDH4u7OfCzUa+LeJ+h2NQAHZIHhbF18F4QOG2uufIC3WJd?=
 =?us-ascii?Q?2LXsBD2Euppi2uez6oFBjka+pgT46lkt1+WjcpnuvuCdQ5Wwu9ofodGWxKXv?=
 =?us-ascii?Q?DklHzbS5wo0hNNSedfMY5IgBYQcWFQosj33aZNP3S969S037duxGCQP7Jd29?=
 =?us-ascii?Q?jHSRd7C2mKaKDcvIgzDpua5moH087nn3u9rri/cZmrBcezHI9PLwz/7pIraB?=
 =?us-ascii?Q?1YlXp3L7hxEPLoJnVhPXLyNmT7cyAvqnairfvFoxFZ+yLOtCr65Bz3yByXXC?=
 =?us-ascii?Q?yhigiGuIVn0v8M7dHOal9+SeMcVAPtkZna56sM5EPfSz85YbTsfm0/9w/9Rv?=
 =?us-ascii?Q?oot3gNeEGgzYIsabgH1owtSKS/qQHkgm89Z0DV4wBL5yCut9ZIbgyA2OE19h?=
 =?us-ascii?Q?0YzsDoboPfQBZ3jqK6i9FOKMkyIbbzgPvPf33DVG7jP8wF4LTirsQNplban3?=
 =?us-ascii?Q?Q8720XplhBFL5rbfiF4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9ef8d3c-9ab1-48f0-c15e-08dbcfe2a568
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 14:00:54.8906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YTu+ujVXjer0bAhlIP9AIa/a3aRvZCNfN95P3SS1ex4dn8M6fUXzfkVqI3J456KL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6112
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_0FBB91F3-34A0-46A8-831F-C24D928B29B5_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 18 Oct 2023, at 9:04, Baolin Wang wrote:

> When doing compaction, I found the lru_add_drain() is an obvious hotspo=
t
> when migrating pages. The distribution of this hotspot is as follows:
>    - 18.75% compact_zone
>       - 17.39% migrate_pages
>          - 13.79% migrate_pages_batch
>             - 11.66% migrate_folio_move
>                - 7.02% lru_add_drain
>                   + 7.02% lru_add_drain_cpu
>                + 3.00% move_to_new_folio
>                  1.23% rmap_walk
>             + 1.92% migrate_folio_unmap
>          + 3.20% migrate_pages_sync
>       + 0.90% isolate_migratepages
>
> The lru_add_drain() was added by commit c3096e6782b7 ("mm/migrate:
> __unmap_and_move() push good newpage to LRU") to drain the newpage to L=
RU
> immediately, to help to build up the correct newpage->mlock_count in
> remove_migration_ptes() for mlocked pages. However, if there are no mlo=
cked
> pages are migrating, then we can avoid this lru drain operation, especa=
illy
> for the heavy concurrent scenarios.

lru_add_drain() is also used to drain pages out of folio_batch. Pages in =
folio_batch
have an additional pin to prevent migration. See folio_get(folio); in fol=
io_add_lru().

>
> So we can record the source pages' mlocked status in migrate_folio_unma=
p(),
> and only drain the lru list when the mlocked status is set in migrate_f=
olio_move().
> In addition, the page was already isolated from lru when migrating, so =
we
> check the mlocked status is stable by folio_test_mlocked() in migrate_f=
olio_unmap().
>
> After this patch, I can see the hotpot of the lru_add_drain() is gone:
>    - 9.41% migrate_pages_batch
>       - 6.15% migrate_folio_move
>          - 3.64% move_to_new_folio
>             + 1.80% migrate_folio_extra
>             + 1.70% buffer_migrate_folio
>          + 1.41% rmap_walk
>          + 0.62% folio_add_lru
>       + 3.07% migrate_folio_unmap
>
> Meanwhile, the compaction latency shows some improvements when running
> thpscale:
>                             base                   patched
> Amean     fault-both-1      1131.22 (   0.00%)     1112.55 *   1.65%*
> Amean     fault-both-3      2489.75 (   0.00%)     2324.15 *   6.65%*
> Amean     fault-both-5      3257.37 (   0.00%)     3183.18 *   2.28%*
> Amean     fault-both-7      4257.99 (   0.00%)     4079.04 *   4.20%*
> Amean     fault-both-12     6614.02 (   0.00%)     6075.60 *   8.14%*
> Amean     fault-both-18    10607.78 (   0.00%)     8978.86 *  15.36%*
> Amean     fault-both-24    14911.65 (   0.00%)    11619.55 *  22.08%*
> Amean     fault-both-30    14954.67 (   0.00%)    14925.66 *   0.19%*
> Amean     fault-both-32    16654.87 (   0.00%)    15580.31 *   6.45%*
>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  mm/migrate.c | 50 ++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 38 insertions(+), 12 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 4caf405b6504..32c96f89710f 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1027,22 +1027,32 @@ union migration_ptr {
>  	struct anon_vma *anon_vma;
>  	struct address_space *mapping;
>  };
> +
> +enum {
> +	PAGE_WAS_MAPPED =3D 1 << 0,
> +	PAGE_WAS_MLOCKED =3D 1 << 1,
> +};
> +
>  static void __migrate_folio_record(struct folio *dst,
> -				   unsigned long page_was_mapped,
> +				   unsigned long page_flags,
>  				   struct anon_vma *anon_vma)
>  {
>  	union migration_ptr ptr =3D { .anon_vma =3D anon_vma };
>  	dst->mapping =3D ptr.mapping;
> -	dst->private =3D (void *)page_was_mapped;
> +	dst->private =3D (void *)page_flags;
>  }
>
>  static void __migrate_folio_extract(struct folio *dst,
>  				   int *page_was_mappedp,
> +				   int *page_was_mlocked,
>  				   struct anon_vma **anon_vmap)
>  {
>  	union migration_ptr ptr =3D { .mapping =3D dst->mapping };
> +	unsigned long page_flags =3D (unsigned long)dst->private;
> +
>  	*anon_vmap =3D ptr.anon_vma;
> -	*page_was_mappedp =3D (unsigned long)dst->private;
> +	*page_was_mappedp =3D page_flags & PAGE_WAS_MAPPED ? 1 : 0;
> +	*page_was_mlocked =3D page_flags & PAGE_WAS_MLOCKED ? 1 : 0;
>  	dst->mapping =3D NULL;
>  	dst->private =3D NULL;
>  }
> @@ -1103,7 +1113,7 @@ static int migrate_folio_unmap(new_folio_t get_ne=
w_folio,
>  {
>  	struct folio *dst;
>  	int rc =3D -EAGAIN;
> -	int page_was_mapped =3D 0;
> +	int page_was_mapped =3D 0, page_was_mlocked =3D 0;
>  	struct anon_vma *anon_vma =3D NULL;
>  	bool is_lru =3D !__folio_test_movable(src);
>  	bool locked =3D false;
> @@ -1157,6 +1167,7 @@ static int migrate_folio_unmap(new_folio_t get_ne=
w_folio,
>  		folio_lock(src);
>  	}
>  	locked =3D true;
> +	page_was_mlocked =3D folio_test_mlocked(src);
>
>  	if (folio_test_writeback(src)) {
>  		/*
> @@ -1206,7 +1217,7 @@ static int migrate_folio_unmap(new_folio_t get_ne=
w_folio,
>  	dst_locked =3D true;
>
>  	if (unlikely(!is_lru)) {
> -		__migrate_folio_record(dst, page_was_mapped, anon_vma);
> +		__migrate_folio_record(dst, 0, anon_vma);
>  		return MIGRATEPAGE_UNMAP;
>  	}
>
> @@ -1236,7 +1247,13 @@ static int migrate_folio_unmap(new_folio_t get_n=
ew_folio,
>  	}
>
>  	if (!folio_mapped(src)) {
> -		__migrate_folio_record(dst, page_was_mapped, anon_vma);
> +		unsigned int page_flags =3D 0;
> +
> +		if (page_was_mapped)
> +			page_flags |=3D PAGE_WAS_MAPPED;
> +		if (page_was_mlocked)
> +			page_flags |=3D PAGE_WAS_MLOCKED;
> +		__migrate_folio_record(dst, page_flags, anon_vma);
>  		return MIGRATEPAGE_UNMAP;
>  	}
>
> @@ -1261,12 +1278,13 @@ static int migrate_folio_move(free_folio_t put_=
new_folio, unsigned long private,
>  			      struct list_head *ret)
>  {
>  	int rc;
> -	int page_was_mapped =3D 0;
> +	int page_was_mapped =3D 0, page_was_mlocked =3D 0;
>  	struct anon_vma *anon_vma =3D NULL;
>  	bool is_lru =3D !__folio_test_movable(src);
>  	struct list_head *prev;
>
> -	__migrate_folio_extract(dst, &page_was_mapped, &anon_vma);
> +	__migrate_folio_extract(dst, &page_was_mapped,
> +				&page_was_mlocked, &anon_vma);

It is better to read out the flag, then check page_was_mapped and page_wa=
s_mlocked
to avoid future __migrate_folio_extract() interface churns.

>  	prev =3D dst->lru.prev;
>  	list_del(&dst->lru);
>
> @@ -1287,7 +1305,7 @@ static int migrate_folio_move(free_folio_t put_ne=
w_folio, unsigned long private,
>  	 * isolated from the unevictable LRU: but this case is the easiest.
>  	 */
>  	folio_add_lru(dst);
> -	if (page_was_mapped)
> +	if (page_was_mlocked)
>  		lru_add_drain();

Like I said at the top, this would be if (page_was_mapped || page_was_mlo=
cked).

>
>  	if (page_was_mapped)
> @@ -1321,8 +1339,15 @@ static int migrate_folio_move(free_folio_t put_n=
ew_folio, unsigned long private,
>  	 * right list unless we want to retry.
>  	 */
>  	if (rc =3D=3D -EAGAIN) {
> +		unsigned int page_flags =3D 0;
> +
> +		if (page_was_mapped)
> +			page_flags |=3D PAGE_WAS_MAPPED;
> +		if (page_was_mlocked)
> +			page_flags |=3D PAGE_WAS_MLOCKED;
> +
>  		list_add(&dst->lru, prev);
> -		__migrate_folio_record(dst, page_was_mapped, anon_vma);
> +		__migrate_folio_record(dst, page_flags, anon_vma);
>  		return rc;
>  	}
>
> @@ -1799,10 +1824,11 @@ static int migrate_pages_batch(struct list_head=
 *from,
>  	dst =3D list_first_entry(&dst_folios, struct folio, lru);
>  	dst2 =3D list_next_entry(dst, lru);
>  	list_for_each_entry_safe(folio, folio2, &unmap_folios, lru) {
> -		int page_was_mapped =3D 0;
> +		int page_was_mapped =3D 0, page_was_mlocked =3D 0;
>  		struct anon_vma *anon_vma =3D NULL;
>
> -		__migrate_folio_extract(dst, &page_was_mapped, &anon_vma);
> +		__migrate_folio_extract(dst, &page_was_mapped,
> +					&page_was_mlocked, &anon_vma);
>  		migrate_folio_undo_src(folio, page_was_mapped, anon_vma,
>  				       true, ret_folios);
>  		list_del(&dst->lru);
> -- =

> 2.39.3


--
Best Regards,
Yan, Zi

--=_MailMate_0FBB91F3-34A0-46A8-831F-C24D928B29B5_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmUv5RQPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUN/cP/2sI/3iSRjtFUdDtkNU8uTHqm5UyNOV9/6cc
4UtQvlwAFqC48fwpu3VI0kEZKjMMVe8kIX1VfOzIv6MbjlavljjKnGdG/6f45KbU
YTs2HX8p46oA82yMKsEMn+cpTvXr7T35NNa8ajyvkk4Hmyy0NFftLG7kGg/Q2v9m
tJISDNJ6oMIKH3FwEfelym+IyaL3ha8xCV9d/SE7FAGRYl1we9p1wlvM5piDNNTk
JXuqCO0xkx5jBlbM4bcG70FdVrzXoFqmmXv/irsv0hfOaK7O05kvESmD79p/YhSy
+ezi6o7x+CkfvZOUIv2AvHqc3VzLKPS7DV8cAL/Tj9CqLohuTN7guQoJ6Q2bxZyf
h5okgAN5FyVLxhSJrkSQf/taTIt5E0UYuVLOzqioTdvNh/7xccYEOVnm33VzIngE
451tXsHdukOsHTCxg3DbbyQcegjEKckF8aogDaLcvWE3RnKAVmVc/5xnE/Lsb0jR
SLy83+DAz3aL7S+5xIYhPYXCgKWJOzSmrKNWW4+Dvoj7DqJcjAHcRsck2d2SJBnY
gU+y3knqYez0UB6irzc/5oGe2XtTJuKzGTIBWfoAfWLqvwly09dkGH+dVvJUsUxk
KvJ3JgV5gjxc1IWiJcDtctSQT1zd8ZZ+okJC7zx87aGQDGqT7oLbvldy3GKHmEq/
qA0HURzV
=SqBH
-----END PGP SIGNATURE-----

--=_MailMate_0FBB91F3-34A0-46A8-831F-C24D928B29B5_=--
