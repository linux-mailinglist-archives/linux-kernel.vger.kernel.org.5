Return-Path: <linux-kernel+bounces-104239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FC087CB10
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 139AA1C210CA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730D418635;
	Fri, 15 Mar 2024 10:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFEbZAsu"
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E2118627
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 10:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710496920; cv=none; b=j6knN/r4SWJOtxmBKWXrtK6u/IuVQS/E5y8A0S939XltGbc04rwfhG8KuuGyGiF9AgKsLQ95DckI2omxWC5pYGUK6yD8MegG2bWSxoz5dtNV2Q4LG2PBL9Cpm/GhfJQ4yYMdyHyUcEtuOMgwFNbCyKX4pdiiyKBb8QGvrbTt+BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710496920; c=relaxed/simple;
	bh=XSjcrmhwIuwgg5j1No9ZTIVQAmWsDOUWFu7fFNYldxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mzVuCArzaZfZTBbs2iinhaM8MAxhIxk4OYvjIvuSzwOfqQaZHg3Bbbx2IqsTvt/qGvmFEDWVnh6hAcLJ0a6KrOCZXFqEsdeOWDIDxXXz0YEO8OrTEtFznw1HfLWs4gg3LVsu0EkTd/pOWm3Esg6Z7QV46GNjNxAZNw/lsCc55y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFEbZAsu; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4d42d18bd63so556196e0c.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 03:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710496918; x=1711101718; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oW5B6DxEkkaQLiJ4zUKDO9JEXVV6ZYR5z/sAge1VQ20=;
        b=eFEbZAsu7BTHQfgjkHfUNnkv5CcBACt9UcPOMhB+LYBX/7qkx2McwcbkVpFtuSvAyk
         TZgSYSwHwniHPGvOetsCfQuqH5dEZJXdQ0x75mwUVGZhjwzKW+TEE420wTd5WDwsdDTd
         bS6YnRbAu7NbRCP7U9m77pe9KZKr4Tp+0fcxWmRnBrqt80aGoy/duZm3x2NgR2dpIC/B
         zeI9qRSgfr5Y4dwJDTtljbjijoUJLKrIJROHAzjdY8jQsSjlEHKytjvgG/AOCxVobhTZ
         cpEVvqlaRTwAvmt4MS6ltD56nwKB1t0GPXCFObNyjWWNM01CEsxizE1f55ACxhtOCy+3
         HEFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710496918; x=1711101718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oW5B6DxEkkaQLiJ4zUKDO9JEXVV6ZYR5z/sAge1VQ20=;
        b=jK5XKMFz28UMvRmqghNcWzhyXSa4jPYg9q3mIDHJk3+1f1sTIdnf19zycP6dAkZlHJ
         PYZE+lovBAs8CYYu61eKLVpuE3WwqAVLyyBRTK3lWxNRCoe2I7UqNNbqJVnd58xMbj0e
         k/ZVrZnZXvBYLY5/5PPzeHNv4FFnTAif93ILlqsKhOHbcOgV2pHUmbJv8403ON9+DQFX
         E4li9szhsTVOcaTapHrr2ItAPsyieL6+jQO4/SQfeHyeYleeSL8UKqOvUPfyLU/uDplG
         S0J280bp7kJK2PfA15CqmYlNGkxo301zA2n+EowlxE2SqNJQjnCZVSGfwg08P8+DJzuK
         2SDw==
X-Forwarded-Encrypted: i=1; AJvYcCUDI8oOkTapPLhGtxel1Y+1VLyR+H2Ezq+VmPH1nqBdq/9tYKDJiElKafE80bXtFqXTCquLrRq62t3hwypEaf4T7ul6H4BphAzOvCTK
X-Gm-Message-State: AOJu0YzVIjfLN74M1VGhlH4LZ/8tqrN2+YQHfljuGZ9AO3TNBMYBYsCG
	65J8qWxSP1SAVlZguaMBr0ja53bBtWyVnv7KYioqNqKxxm9QFBsuiNNxfvUUBnzy/qenKW8k/tq
	fJPt5Xp41tpxLq6w+1QkG9z+lexM=
X-Google-Smtp-Source: AGHT+IEnvN8kiTCclBTIT/7XiLqTI34YVzLDPfLghUXBNqtpvqHWbScB5k87v9w6zXKxGQAU7WWOajS0yZyvg3m8Xgw=
X-Received: by 2002:a1f:eec7:0:b0:4d4:1fe2:c398 with SMTP id
 m190-20020a1feec7000000b004d41fe2c398mr3511026vkh.2.1710496917602; Fri, 15
 Mar 2024 03:01:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304081348.197341-1-21cnbao@gmail.com> <20240304081348.197341-6-21cnbao@gmail.com>
 <87wmq3yji6.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAGsJ_4x+t_X4Tn15=QPbH58e1S1FwOoM3t37T+cUE8-iKoENLw@mail.gmail.com>
 <87sf0rx3d6.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87sf0rx3d6.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 15 Mar 2024 23:01:46 +1300
Message-ID: <CAGsJ_4xna1xKz7J=MWDR3h543UvnS9v0-+ggVc5fFzpFOzfpyA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 5/5] mm: support large folios swapin as a whole
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	ryan.roberts@arm.com, chengming.zhou@linux.dev, chrisl@kernel.org, 
	david@redhat.com, hannes@cmpxchg.org, kasong@tencent.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	mhocko@suse.com, nphamcs@gmail.com, shy828301@gmail.com, steven.price@arm.com, 
	surenb@google.com, wangkefeng.wang@huawei.com, xiang@kernel.org, 
	yosryahmed@google.com, yuzhao@google.com, Chuanhua Han <hanchuanhua@oppo.com>, 
	Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 10:17=E2=80=AFPM Huang, Ying <ying.huang@intel.com>=
 wrote:
>
> Barry Song <21cnbao@gmail.com> writes:
>
> > On Fri, Mar 15, 2024 at 9:43=E2=80=AFPM Huang, Ying <ying.huang@intel.c=
om> wrote:
> >>
> >> Barry Song <21cnbao@gmail.com> writes:
> >>
> >> > From: Chuanhua Han <hanchuanhua@oppo.com>
> >> >
> >> > On an embedded system like Android, more than half of anon memory is
> >> > actually in swap devices such as zRAM. For example, while an app is
> >> > switched to background, its most memory might be swapped-out.
> >> >
> >> > Now we have mTHP features, unfortunately, if we don't support large =
folios
> >> > swap-in, once those large folios are swapped-out, we immediately los=
e the
> >> > performance gain we can get through large folios and hardware optimi=
zation
> >> > such as CONT-PTE.
> >> >
> >> > This patch brings up mTHP swap-in support. Right now, we limit mTHP =
swap-in
> >> > to those contiguous swaps which were likely swapped out from mTHP as=
 a
> >> > whole.
> >> >
> >> > Meanwhile, the current implementation only covers the SWAP_SYCHRONOU=
S
> >> > case. It doesn't support swapin_readahead as large folios yet since =
this
> >> > kind of shared memory is much less than memory mapped by single proc=
ess.
> >>
> >> In contrast, I still think that it's better to start with normal swap-=
in
> >> path, then expand to SWAP_SYCHRONOUS case.
> >
> > I'd rather try the reverse direction as non-sync anon memory is only ar=
ound
> > 3% in a phone as my observation.
>
> Phone is not the only platform that Linux is running on.

I suppose it's generally true that forked shared anonymous pages only
constitute a
small portion of all anonymous pages. The majority of anonymous pages are w=
ithin
a single process.

I agree phones are not the only platform. But Rome wasn't built in a
day. I can only get
started on a hardware which I can easily reach and have enough hardware/tes=
t
resources on it. So we may take the first step which can be applied on
a real product
and improve its performance, and step by step, we broaden it and make it
widely useful to various areas  in which I can't reach :-)

so probably we can have a sysfs "enable" entry with default "n" or
have a maximum
swap-in order as Ryan's suggestion [1] at the beginning,

"
So in the common case, swap-in will pull in the same size of folio as was
swapped-out. Is that definitely the right policy for all folio sizes? Certa=
inly
it makes sense for "small" large folios (e.g. up to 64K IMHO). But I'm not =
sure
it makes sense for 2M THP; As the size increases the chances of actually ne=
eding
all of the folio reduces so chances are we are wasting IO. There are simila=
r
arguments for CoW, where we currently copy 1 page per fault - it probably m=
akes
sense to copy the whole folio up to a certain size.
"

>
> >>
> >> In normal swap-in path, we can take advantage of swap readahead
> >> information to determine the swapped-in large folio order.  That is, i=
f
> >> the return value of swapin_nr_pages() > 1, then we can try to allocate
> >> and swapin a large folio.
> >
> > I am not quite sure we still need to depend on this. in do_anon_page,
> > we have broken the assumption and allocated a large folio directly.
>
> I don't think that we have a sophisticated policy to allocate large
> folio.  Large folio could waste memory for some workloads, so I think
> that it's a good idea to allocate large folio always.

i agree, but we still have the below check just like do_anon_page() has it,

        orders =3D thp_vma_allowable_orders(vma, vma->vm_flags, false, true=
, true,
                                          BIT(PMD_ORDER) - 1);
        orders =3D thp_vma_suitable_orders(vma, vmf->address, orders);

in do_anon_page, we don't worry about the waste so much, the same
logic also applies to do_swap_page().

>
> Readahead gives us an opportunity to play with the policy.

I feel somehow the rules of the game have changed with an upper
limit for swap-in size. for example, if the upper limit is 4 order,
it limits folio size to 64KiB which is still a proper size for ARM64
whose base page can be 64KiB.

on the other hand, while swapping out large folios, we will always
compress them as a whole(zsmalloc/zram patch will come in a
couple of days), if we choose to decompress a subpage instead of
a large folio in do_swap_page(), we might need to decompress
nr_pages times. for example,

For large folios 16*4KiB, they are saved as a large object in zsmalloc(with
the coming patch), if we swap in a small folio, we decompress the large
object; next time, we will still need to decompress a large object. so
it is more sensible to swap in a large folio if we find those
swap entries are contiguous and were allocated by a large folio swap-out.

>
> > On the other hand, compressing/decompressing large folios as a
> > whole rather than doing it one by one can save a large percent of
> > CPUs and provide a much lower compression ratio.  With a hardware
> > accelerator, this is even faster.
>
> I am not against to support large folio for compressing/decompressing.
>
> I just suggest to do that later, after we play with normal swap-in.
> SWAP_SYCHRONOUS related swap-in code is an optimization based on normal
> swap.  So, it seems natural to support large folio swap-in for normal
> swap-in firstly.

I feel like SWAP_SYCHRONOUS is a simpler case and even more "normal"
than the swapcache path since it is the majority. and on the other hand, a =
lot
of modification is required for the swapcache path. in OPPO's code[1], we d=
id
bring-up both paths, but the swapcache path is much much more complicated
than the SYNC path and hasn't really noticeable improvement.

[1] https://github.com/OnePlusOSS/android_kernel_oneplus_sm8650/tree/oneplu=
s/sm8650_u_14.0.0_oneplus12

>
> > So I'd rather more aggressively get large folios swap-in involved
> > than depending on readahead.
>
> We can take advantage of readahead algorithm in SWAP_SYCHRONOUS
> optimization too.  The sub-pages that is not accessed by page fault can
> be treated as readahead.  I think that is a better policy than
> allocating large folio always.

Considering the zsmalloc optimization, it would be a better choice to
always allocate
large folios if we find those swap entries are for a swapped-out large foli=
o. as
decompressing just once, we get all subpages.
Some hardware accelerators are even able to decompress a large folio with
multi-hardware threads, for example, 16 hardware threads can compress
each subpage of a large folio at the same time, it is just as fast as
decompressing
one subpage.

for platforms without the above optimizations, a proper upper limit
will help them
disable the large folios swap-in or decrease the impact. For example,
if the upper
limit is 0-order, we are just removing this patchset. if the upper
limit is 2 orders, we
are just like BASE_PAGE size is 16KiB.

>
> >>
> >> To do that, we need to track whether the sub-pages are accessed.  I
> >> guess we need that information for large file folio readahead too.
> >>
> >> Hi, Matthew,
> >>
> >> Can you help us on tracking whether the sub-pages of a readahead large
> >> folio has been accessed?
> >>
> >> > Right now, we are re-faulting large folios which are still in swapca=
che as a
> >> > whole, this can effectively decrease extra loops and early-exitings =
which we
> >> > have increased in arch_swap_restore() while supporting MTE restore f=
or folios
> >> > rather than page. On the other hand, it can also decrease do_swap_pa=
ge as
> >> > PTEs used to be set one by one even we hit a large folio in swapcach=
e.
> >> >
> >>
> --
> Best Regards,
> Huang, Ying

Thanks
Barry

