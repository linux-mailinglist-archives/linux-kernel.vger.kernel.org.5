Return-Path: <linux-kernel+bounces-40836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBFD83E6BF
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EBDA1F2A1FB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7703758204;
	Fri, 26 Jan 2024 23:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fSQZbxo/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19221EF1D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 23:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706311038; cv=none; b=SusvH3qqu6nK+Fp5FUTwzAVr/CfyGGYDFUAupZJ3YbYfJlE4RPjpYol0bRiKgkz0x/Z4Y2qcWkfTnU191VX4w286SK/SY8FTS2ylLj7eGUHCGMNFe32HWL8kuyBQere66fQ5pkSzbQn9Ni6RvglaJ1sUT2ciJOquELF824+bV2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706311038; c=relaxed/simple;
	bh=B2vG1UI0l03TA0AWgSx2zlP14++axiH1rOWXKCM+7Dk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BIQU3dXYePENohkiw8TbCUD61CiKyHDrbhsidzqy6la5KwmbQOnd5wzAted574kCvfg2hCXGUfuZWJlAQ1wtiaaGhSPDBRKyDRS9H2LEM9xbkcvuTT3VANRgqCx4m+P8WWekP0W8LLPbbBX8zJEYNUFn/tFN9QcZxkq09XglSB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fSQZbxo/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23171C43390
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 23:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706311038;
	bh=B2vG1UI0l03TA0AWgSx2zlP14++axiH1rOWXKCM+7Dk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fSQZbxo/d2KbI8bBxuqv2ryLtLeJ8pF1rcvm9E7IjkhQYEm+9aOPHxPWSEMZPF46M
	 0zyIfs/Qle8c6CP9+B+00MGvhn4q3Ad0Axf2wURkqVHP9I9EnIT/Ne7e95Ogp/VK9A
	 F3Y5rp97EMahvgIruqP+GQR2DD1ZXOuDS0oDFwCRjFVN4uKK1dycNX26w/Xv1DcFWG
	 J54PqvhzgTvtmKhMFBU5ckvlFq2V8/kpSYLcRLbPl1NB4bmlR4w/yNsXbnaT3hkZ8w
	 9oD3Y4LwfacfWrp2KQMpW0tzGBmL/oDMjTztcMSFSi4Tt8vd0ttifixH8y4emf+owP
	 yi3qnZIGrGBRA==
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-362cfc3b858so268315ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 15:17:18 -0800 (PST)
X-Gm-Message-State: AOJu0YzxsXuGMQyf+7WsXbUmecv2TNkGFtDYf66YPANxnonEofwZzVYd
	m5cJnpSEo4G0Lg/T81deOikvVsLdGo6AKY2I4cxSwL4rfE7FnogEJlrPex9JOAE4cmYKYxuZEuP
	vwVfqRM8y9BWsi8skqXGSCRA2sRIycbmHYKQ7
X-Google-Smtp-Source: AGHT+IG08OQ4U5HYbY79Lo4OxzWbXa/w0tvFzb4wDDflJcOxhg1jpMa6kuct8IdHffcT/tY01ol4CiUEE/Fw8U6EvBs=
X-Received: by 2002:a05:6e02:509:b0:35f:e8a1:2b16 with SMTP id
 d9-20020a056e02050900b0035fe8a12b16mr536371ils.17.1706311037507; Fri, 26 Jan
 2024 15:17:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025144546.577640-1-ryan.roberts@arm.com> <20240118111036.72641-1-21cnbao@gmail.com>
 <20240118111036.72641-3-21cnbao@gmail.com>
In-Reply-To: <20240118111036.72641-3-21cnbao@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 26 Jan 2024 15:17:06 -0800
X-Gmail-Original-Message-ID: <CAF8kJuOPXyAxmmh9QO1SdU=8GWtMhPjaWgGtQ8gvnNyfbSZbig@mail.gmail.com>
Message-ID: <CAF8kJuOPXyAxmmh9QO1SdU=8GWtMhPjaWgGtQ8gvnNyfbSZbig@mail.gmail.com>
Subject: Re: [PATCH RFC 2/6] mm: swap: introduce swap_nr_free() for batched swap_free()
To: Barry Song <21cnbao@gmail.com>
Cc: ryan.roberts@arm.com, akpm@linux-foundation.org, david@redhat.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, mhocko@suse.com, 
	shy828301@gmail.com, wangkefeng.wang@huawei.com, willy@infradead.org, 
	xiang@kernel.org, ying.huang@intel.com, yuzhao@google.com, surenb@google.com, 
	steven.price@arm.com, Chuanhua Han <hanchuanhua@oppo.com>, 
	Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 3:11=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> From: Chuanhua Han <hanchuanhua@oppo.com>
>
> While swapping in a large folio, we need to free swaps related to the who=
le
> folio. To avoid frequently acquiring and releasing swap locks, it is bett=
er
> to introduce an API for batched free.
>
> Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
> Co-developed-by: Barry Song <v-songbaohua@oppo.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  include/linux/swap.h |  6 ++++++
>  mm/swapfile.c        | 29 +++++++++++++++++++++++++++++
>  2 files changed, 35 insertions(+)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 4db00ddad261..31a4ee2dcd1c 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -478,6 +478,7 @@ extern void swap_shmem_alloc(swp_entry_t);
>  extern int swap_duplicate(swp_entry_t);
>  extern int swapcache_prepare(swp_entry_t);
>  extern void swap_free(swp_entry_t);
> +extern void swap_nr_free(swp_entry_t entry, int nr_pages);
>  extern void swapcache_free_entries(swp_entry_t *entries, int n);
>  extern int free_swap_and_cache(swp_entry_t);
>  int swap_type_of(dev_t device, sector_t offset);
> @@ -553,6 +554,11 @@ static inline void swap_free(swp_entry_t swp)
>  {
>  }
>
> +void swap_nr_free(swp_entry_t entry, int nr_pages)
> +{
> +
> +}
> +
>  static inline void put_swap_folio(struct folio *folio, swp_entry_t swp)
>  {
>  }
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 556ff7347d5f..6321bda96b77 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1335,6 +1335,35 @@ void swap_free(swp_entry_t entry)
>                 __swap_entry_free(p, entry);
>  }
>
> +void swap_nr_free(swp_entry_t entry, int nr_pages)
> +{
> +       int i;
> +       struct swap_cluster_info *ci;
> +       struct swap_info_struct *p;
> +       unsigned type =3D swp_type(entry);
> +       unsigned long offset =3D swp_offset(entry);
> +       DECLARE_BITMAP(usage, SWAPFILE_CLUSTER) =3D { 0 };
> +
> +       VM_BUG_ON(offset % SWAPFILE_CLUSTER + nr_pages > SWAPFILE_CLUSTER=
);

BUG_ON here seems a bit too developer originated. Maybe warn once and
roll back to free one by one?

How big is your typical SWAPFILE_CUSTER and nr_pages typically in arm?

I ask this question because nr_ppages > 64, that is a totally
different game, we can completely  bypass the swap cache slots.

> +
> +       if (nr_pages =3D=3D 1) {
> +               swap_free(entry);
> +               return;
> +       }
> +
> +       p =3D _swap_info_get(entry);
> +
> +       ci =3D lock_cluster(p, offset);
> +       for (i =3D 0; i < nr_pages; i++) {
> +               if (__swap_entry_free_locked(p, offset + i, 1))
> +                       __bitmap_set(usage, i, 1);
> +       }
> +       unlock_cluster(ci);
> +
> +       for_each_clear_bit(i, usage, nr_pages)
> +               free_swap_slot(swp_entry(type, offset + i));

Notice that free_swap_slot() internal has per CPU cache batching as
well. Every free_swap_slot will get some per_cpu swap slot cache and
cache->lock. There is double batching here.
If the typical batch size here is bigger than 64 entries, we can go
directly to batching swap_entry_free and avoid the free_swap_slot()
batching altogether. Unlike free_swap_slot_entries(), here swap slots
are all from one swap device, there is no need to sort and group the
swap slot by swap devices.

Chris


Chris

> +}
> +
>  /*
>   * Called after dropping swapcache to decrease refcnt to swap entries.
>   */
> --
> 2.34.1
>
>

