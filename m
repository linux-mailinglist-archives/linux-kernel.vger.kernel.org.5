Return-Path: <linux-kernel+bounces-105660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CF387E235
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 03:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEA752830AA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 02:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BFB1DFD1;
	Mon, 18 Mar 2024 02:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZYHQVQQ"
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EAB1DDE9
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 02:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710729701; cv=none; b=iOjj1PvkXIHu2tSjT3aTNybQD7VDMTwtUAudtgIM+Md9/yvAdUiKP6lNmLEuNUs3i8/FTGUW0lu4B2q61qQIv8kS9XS2xDUUPUPos8Q7Zxvy5Olhu6AzabT7/zb/bFkveMkxotB1f3gCt0MlmJwU+/tcqVFSbgYKPot0B8TDNfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710729701; c=relaxed/simple;
	bh=ZD/C6tyC/U/TVnLl5pA48E7TpX6cKD993jDEDp0gEMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d+vWrrvfmHBsNb2aZINTlS6ra1YgvCw3/vTDdNQFJmv5xRfFnSXCpW7ayQ/WIgpAd1DvsJlrzlMAruNt79PSISSHc+JaBMC0ZbnrKwsDcRelJSfw9G9fujXAoeR8zCHx1VgNy9lfB3KpNv9fUcduJvRF1CIRY5JmLKIFgmPokGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XZYHQVQQ; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4d43b8b258aso588815e0c.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 19:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710729698; x=1711334498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Q1ZsxcEK4oCrb2hk8jSYbnqg03nST/a1q8xFRqCISY=;
        b=XZYHQVQQvfIiFvKUjRBeZFX/D0AOthudpzaMOWwQxbqaqfPKSr6M2wyIbkyS2RHCnb
         +5T57iKbSu3ZAP1l91xwJofNyGA+7ap8DenVo1AQPdGxEYQXPXszODSr95BIDz5yEOs2
         IbtfEc6MXKjmANR0ihubY3M4SxYx9uSnO4DsTmQ5zcvgQTA9O5CtMfpt3m0Rzfs7XOfB
         gDu8vJYaWxGq4oezptbqCwSTPmYg8j83OtpGaVWHtuNzTO1sGr/avcF8ovwx+WH+wl0f
         ieBT/gojN+Rr8sSwne7gZvy+Rb5fwraBkQP8D8Rbx9bp6BYtmIeq5zha7cnKd6u1dsyn
         /Lfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710729698; x=1711334498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Q1ZsxcEK4oCrb2hk8jSYbnqg03nST/a1q8xFRqCISY=;
        b=sQnSVlUGL3zWWX7EQDH9WNDiKhi0RHZzMMF+Fgy58r8T3D5ZIHhuR+5dC9WFC7wLDQ
         T/cMyuArpjMdP6poXKYTf3sud/og8UCObqc23RWiVH/wDwJTxCfuBE5Nhioud1oRBPJ7
         iNidyd9TQxvTMqud1VPvpUA7/s1F7zfinw+AHqTPJ/RsSJXL6ziC+wC5qEXJhjIMx0aS
         qxDZ8Ck2euJAhdq3G4cKIAOApxibwjkbJ+YkEjcDgzmHCnuoiPMj9rxuS7BiE0Wu95xc
         qTdpz9hkDLGoHoly0Bz65mr5JMUZ0saKud9k93PKoUipFl9QKsqd5jSdFprgeagS2V/6
         nZtw==
X-Forwarded-Encrypted: i=1; AJvYcCWjsIqAHUMjGTfgyzhs5F2CENSBXNPwrX3BbA9IWq62Jblgox0dYjXi1Hk6ykm1aaaX9r0ss9CfXMG8JKdHlbQyznPk659SQ5Vnp4tM
X-Gm-Message-State: AOJu0YzIztchSiwAaH5KbCVUasfPb/pJ35aDksKXZ77jbcTQ5AIVUrTH
	+EFbFPu8vlZ++ZmKrhPkPV/+9eXyXDoOsc+FtwUcxSLh9bWZLi5TbAQ/IxOoUcEN1xhAPUhsXLk
	c8Qw1urybwzPxmxDRpGMBb2NNtLA=
X-Google-Smtp-Source: AGHT+IF/cfTemmJP51QzZN8AKCBvdK1MVobNPsXMTsFOmcj/sugYkGaCE47QnxDSHUbP4iVTGuS94CSnThJ7pfGSQrA=
X-Received: by 2002:a05:6122:2314:b0:4c7:b048:bb9c with SMTP id
 bq20-20020a056122231400b004c7b048bb9cmr5377724vkb.15.1710729696898; Sun, 17
 Mar 2024 19:41:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304081348.197341-1-21cnbao@gmail.com> <20240304081348.197341-6-21cnbao@gmail.com>
 <87wmq3yji6.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAGsJ_4x+t_X4Tn15=QPbH58e1S1FwOoM3t37T+cUE8-iKoENLw@mail.gmail.com>
 <87sf0rx3d6.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAGsJ_4xna1xKz7J=MWDR3h543UvnS9v0-+ggVc5fFzpFOzfpyA@mail.gmail.com>
 <87jzm0wblq.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87jzm0wblq.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 18 Mar 2024 15:41:25 +1300
Message-ID: <CAGsJ_4wTU3cmzXMCu+yQRMnEiCEUA8rO5=QQUopgG0RMnHYd5g@mail.gmail.com>
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

On Mon, Mar 18, 2024 at 2:54=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Barry Song <21cnbao@gmail.com> writes:
>
> > On Fri, Mar 15, 2024 at 10:17=E2=80=AFPM Huang, Ying <ying.huang@intel.=
com> wrote:
> >>
> >> Barry Song <21cnbao@gmail.com> writes:
> >>
> >> > On Fri, Mar 15, 2024 at 9:43=E2=80=AFPM Huang, Ying <ying.huang@inte=
l.com> wrote:
> >> >>
> >> >> Barry Song <21cnbao@gmail.com> writes:
> >> >>
> >> >> > From: Chuanhua Han <hanchuanhua@oppo.com>
> >> >> >
> >> >> > On an embedded system like Android, more than half of anon memory=
 is
> >> >> > actually in swap devices such as zRAM. For example, while an app =
is
> >> >> > switched to background, its most memory might be swapped-out.
> >> >> >
> >> >> > Now we have mTHP features, unfortunately, if we don't support lar=
ge folios
> >> >> > swap-in, once those large folios are swapped-out, we immediately =
lose the
> >> >> > performance gain we can get through large folios and hardware opt=
imization
> >> >> > such as CONT-PTE.
> >> >> >
> >> >> > This patch brings up mTHP swap-in support. Right now, we limit mT=
HP swap-in
> >> >> > to those contiguous swaps which were likely swapped out from mTHP=
 as a
> >> >> > whole.
> >> >> >
> >> >> > Meanwhile, the current implementation only covers the SWAP_SYCHRO=
NOUS
> >> >> > case. It doesn't support swapin_readahead as large folios yet sin=
ce this
> >> >> > kind of shared memory is much less than memory mapped by single p=
rocess.
> >> >>
> >> >> In contrast, I still think that it's better to start with normal sw=
ap-in
> >> >> path, then expand to SWAP_SYCHRONOUS case.
> >> >
> >> > I'd rather try the reverse direction as non-sync anon memory is only=
 around
> >> > 3% in a phone as my observation.
> >>
> >> Phone is not the only platform that Linux is running on.
> >
> > I suppose it's generally true that forked shared anonymous pages only
> > constitute a
> > small portion of all anonymous pages. The majority of anonymous pages a=
re within
> > a single process.
>
> Yes.  But IIUC, SWP_SYNCHRONOUS_IO is quite limited, they are set only
> for memory backed swap devices.

SWP_SYNCHRONOUS_IO is the most common case for embedded linux.
note almost all Android/embedded devices use zRAM rather than a disk
for swap.

And we can have an upper limit order or a new control like
/sys/kernel/mm/transparent_hugepage/hugepages-256kB/swapin
and set them default to 0 first.

>
> > I agree phones are not the only platform. But Rome wasn't built in a
> > day. I can only get
> > started on a hardware which I can easily reach and have enough hardware=
/test
> > resources on it. So we may take the first step which can be applied on
> > a real product
> > and improve its performance, and step by step, we broaden it and make i=
t
> > widely useful to various areas  in which I can't reach :-)
>
> We must guarantee the normal swap path runs correctly and has no
> performance regression when developing SWP_SYNCHRONOUS_IO optimization.
> So we have to put some effort on the normal path test anyway.
>
> > so probably we can have a sysfs "enable" entry with default "n" or
> > have a maximum
> > swap-in order as Ryan's suggestion [1] at the beginning,
> >
> > "
> > So in the common case, swap-in will pull in the same size of folio as w=
as
> > swapped-out. Is that definitely the right policy for all folio sizes? C=
ertainly
> > it makes sense for "small" large folios (e.g. up to 64K IMHO). But I'm =
not sure
> > it makes sense for 2M THP; As the size increases the chances of actuall=
y needing
> > all of the folio reduces so chances are we are wasting IO. There are si=
milar
> > arguments for CoW, where we currently copy 1 page per fault - it probab=
ly makes
> > sense to copy the whole folio up to a certain size.
> > "
> >
> >>
> >> >>
> >> >> In normal swap-in path, we can take advantage of swap readahead
> >> >> information to determine the swapped-in large folio order.  That is=
, if
> >> >> the return value of swapin_nr_pages() > 1, then we can try to alloc=
ate
> >> >> and swapin a large folio.
> >> >
> >> > I am not quite sure we still need to depend on this. in do_anon_page=
,
> >> > we have broken the assumption and allocated a large folio directly.
> >>
> >> I don't think that we have a sophisticated policy to allocate large
> >> folio.  Large folio could waste memory for some workloads, so I think
> >> that it's a good idea to allocate large folio always.
> >
> > i agree, but we still have the below check just like do_anon_page() has=
 it,
> >
> >         orders =3D thp_vma_allowable_orders(vma, vma->vm_flags, false, =
true, true,
> >                                           BIT(PMD_ORDER) - 1);
> >         orders =3D thp_vma_suitable_orders(vma, vmf->address, orders);
> >
> > in do_anon_page, we don't worry about the waste so much, the same
> > logic also applies to do_swap_page().
>
> As I said, "readahead" may help us from application/user specific
> configuration in most cases.  It can be a starting point of "using mTHP
> automatically when it helps and not cause many issues".

I'd rather start from the simpler code path and really improve  on
phones & embedded linux which our team can really reach :-)

>
> >>
> >> Readahead gives us an opportunity to play with the policy.
> >
> > I feel somehow the rules of the game have changed with an upper
> > limit for swap-in size. for example, if the upper limit is 4 order,
> > it limits folio size to 64KiB which is still a proper size for ARM64
> > whose base page can be 64KiB.
> >
> > on the other hand, while swapping out large folios, we will always
> > compress them as a whole(zsmalloc/zram patch will come in a
> > couple of days), if we choose to decompress a subpage instead of
> > a large folio in do_swap_page(), we might need to decompress
> > nr_pages times. for example,
> >
> > For large folios 16*4KiB, they are saved as a large object in zsmalloc(=
with
> > the coming patch), if we swap in a small folio, we decompress the large
> > object; next time, we will still need to decompress a large object. so
> > it is more sensible to swap in a large folio if we find those
> > swap entries are contiguous and were allocated by a large folio swap-ou=
t.
>
> I understand that there are some special requirements for ZRAM.  But I
> don't think it's a good idea to force the general code to fit the
> requirements of a specific swap device too much.  This is one of the
> reasons that I think that we should start with normal swap devices, then
> try to optimize for some specific devices.

I agree. but we are having a good start. zRAM is not a specific device,
it widely represents embedded Linux.

>
> >>
> >> > On the other hand, compressing/decompressing large folios as a
> >> > whole rather than doing it one by one can save a large percent of
> >> > CPUs and provide a much lower compression ratio.  With a hardware
> >> > accelerator, this is even faster.
> >>
> >> I am not against to support large folio for compressing/decompressing.
> >>
> >> I just suggest to do that later, after we play with normal swap-in.
> >> SWAP_SYCHRONOUS related swap-in code is an optimization based on norma=
l
> >> swap.  So, it seems natural to support large folio swap-in for normal
> >> swap-in firstly.
> >
> > I feel like SWAP_SYCHRONOUS is a simpler case and even more "normal"
> > than the swapcache path since it is the majority.
>
> I don't think so.  Most PC and server systems uses !SWAP_SYCHRONOUS
> swap devices.

The problem is that our team is all focusing on phones, we won't have
any resource
and bandwidth on PC and server. A more realistic goal is that we at
least let the
solutions benefit phones and similar embedded Linux and extend it to more a=
reas
such as PC and server.

I'd be quite happy if you or other people can join together on PC and serve=
r.

>
> > and on the other hand, a lot
> > of modification is required for the swapcache path. in OPPO's code[1], =
we did
> > bring-up both paths, but the swapcache path is much much more complicat=
ed
> > than the SYNC path and hasn't really noticeable improvement.
> >
> > [1] https://github.com/OnePlusOSS/android_kernel_oneplus_sm8650/tree/on=
eplus/sm8650_u_14.0.0_oneplus12
>
> That's great.  Please cleanup the code and post it to mailing list.  Why
> doesn't it help?  IIUC, it can optimize TLB at least.

I agree this can improve but most of the anon pages are single-process
mapped. only
quite a few pages go to the readahead code path on phones. That's why
there is no
noticeable improvement finally.

I understand all the benefits you mentioned on changing readahead, but
simply because
those kinds of pages are really really rare, so improving that path
doesn't really help
Android devices.

>
> >>
> >> > So I'd rather more aggressively get large folios swap-in involved
> >> > than depending on readahead.
> >>
> >> We can take advantage of readahead algorithm in SWAP_SYCHRONOUS
> >> optimization too.  The sub-pages that is not accessed by page fault ca=
n
> >> be treated as readahead.  I think that is a better policy than
> >> allocating large folio always.

This is always true even in do_anonymous_page(). but we don't worry that
too much as we have per-size control. overload has the chance to set its
preferences.
        /*
         * Get a list of all the (large) orders below PMD_ORDER that are en=
abled
         * for this vma. Then filter out the orders that can't be allocated=
 over
         * the faulting address and still be fully contained in the vma.
         */
        orders =3D thp_vma_allowable_orders(vma, vma->vm_flags, false, true=
, true,
                                          BIT(PMD_ORDER) - 1);
        orders =3D thp_vma_suitable_orders(vma, vmf->address, orders);

On the other hand, we are not always allocating large folios. we are alloca=
ting
large folios when the swapped-out folio was large. This is quite important =
to
an embedded linux, as swap is happening so often. more than half memory
can be in swap, if we swap-out them as a large folio, but swap them in a
small, we immediately lose all advantages such as less page faults, CONT-PT=
E
etc.

> >
> > Considering the zsmalloc optimization, it would be a better choice to
> > always allocate
> > large folios if we find those swap entries are for a swapped-out large =
folio. as
> > decompressing just once, we get all subpages.
> > Some hardware accelerators are even able to decompress a large folio wi=
th
> > multi-hardware threads, for example, 16 hardware threads can compress
> > each subpage of a large folio at the same time, it is just as fast as
> > decompressing
> > one subpage.
> >
> > for platforms without the above optimizations, a proper upper limit
> > will help them
> > disable the large folios swap-in or decrease the impact. For example,
> > if the upper
> > limit is 0-order, we are just removing this patchset. if the upper
> > limit is 2 orders, we
> > are just like BASE_PAGE size is 16KiB.
> >
> >>
> >> >>
> >> >> To do that, we need to track whether the sub-pages are accessed.  I
> >> >> guess we need that information for large file folio readahead too.
> >> >>
> >> >> Hi, Matthew,
> >> >>
> >> >> Can you help us on tracking whether the sub-pages of a readahead la=
rge
> >> >> folio has been accessed?
> >> >>
> >> >> > Right now, we are re-faulting large folios which are still in swa=
pcache as a
> >> >> > whole, this can effectively decrease extra loops and early-exitin=
gs which we
> >> >> > have increased in arch_swap_restore() while supporting MTE restor=
e for folios
> >> >> > rather than page. On the other hand, it can also decrease do_swap=
_page as
> >> >> > PTEs used to be set one by one even we hit a large folio in swapc=
ache.
> >> >> >
> >> >>
>
> --
> Best Regards,
> Huang, Ying

Thanks
Barry

