Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2377EAFBE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 13:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbjKNMVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 07:21:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbjKNMVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 07:21:44 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25D2D1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 04:21:40 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id ada2fe7eead31-45d8c405696so1981529137.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 04:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699964500; x=1700569300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7rB/rX7UtaFpyUffk9v/aC4bo/cSeZRZqRPvQXU+ii4=;
        b=RzDdaCIrrEQFTNYqm9vP0XVvrltW2psmt0183H4aVzZSkvEUNeXtpW21q4rBMqNgLw
         i1oglvZeAx8NjJSjyVG67yG2IJdZIt5DE1gVkX1WPstlOFP0Np7vQ49mt9LJslFjBXSc
         YZF/9OaZu5lNHaN/WcANhIHSIRnOXuaQeBLUUDaVM2611cLtjgFmes7YZssFhXBMsdnC
         SpUzY5TkVmH1PTx8oJMX1NIZ4XsfEZk9VPifmbaX11FqLI03HMxeApt1xFw0ospZ7hPJ
         WWjV1r9nvmSClml0A/O6aqlm1tsQZ5Gs1OcWCLooIEGpl1Azc/tsAAZ6uJsR44SzrvyE
         N9IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699964500; x=1700569300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7rB/rX7UtaFpyUffk9v/aC4bo/cSeZRZqRPvQXU+ii4=;
        b=nBNLpF+Ab9GHW20ENuZm25+hX07C7tk9xuZTpg9fRO/577pNqff0hI41QksEqW6cbO
         MAJnsefKd2akF2bwq3gNpGfHM7+ekfHwGKM34nGNZYKmv7M4M1uH3NhCDQ4S4ES//QjR
         A1Gfa62l+QbI6GbaS1AEeeO0d/o4XFyxoyBYnxNM2wMi04dY+I3Vy5LZV1FMd96VDnYN
         ch3h9FnIaolkWOCrUjaybUXe1kK89KFFrwA2SuBgz7X1hrJ+EbzHBu9e81UgHYNji446
         Kx4CxgMDSpFoPbIWsSpUwYhlZAaD2TNQv4o3lB2j44Cl8rnx0XAwev8kO1kMpCUmxEQH
         P+4g==
X-Gm-Message-State: AOJu0YwUz15ZKOnL7of3BQo+HsUqOyLyMNJHdJsJ60M0lhixATFdvL7E
        jWZHqbonJc5fwCkidX7wW/UUjWWQOu9cG7ZoJ2/Kfg==
X-Google-Smtp-Source: AGHT+IGc1Ov9oNbuvwvh4LdxXUNBo/5A+bmcIQaRqmSXDOC/iNxjkaUqIkEq8ZfknmFTAIOaX2mUNtHflVlsKzJ2EtE=
X-Received: by 2002:a67:e10d:0:b0:45f:68cb:d55d with SMTP id
 d13-20020a67e10d000000b0045f68cbd55dmr8102580vsl.15.1699964499870; Tue, 14
 Nov 2023 04:21:39 -0800 (PST)
MIME-Version: 1.0
References: <20231113130041.58124-1-linyunsheng@huawei.com>
 <20231113130041.58124-4-linyunsheng@huawei.com> <CAHS8izMjmj0DRT_vjzVq5HMQyXtZdVK=o4OP0gzbaN=aJdQ3ig@mail.gmail.com>
 <20231113180554.1d1c6b1a@kernel.org> <0c39bd57-5d67-3255-9da2-3f3194ee5a66@huawei.com>
In-Reply-To: <0c39bd57-5d67-3255-9da2-3f3194ee5a66@huawei.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Tue, 14 Nov 2023 04:21:26 -0800
Message-ID: <CAHS8izNxkqiNbTA1y+BjQPAber4Dks3zVFNYo4Bnwc=0JLustA@mail.gmail.com>
Subject: Re: [PATCH RFC 3/8] memory-provider: dmabuf devmem memory provider
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>,
        Kaiyuan Zhang <kaiyuanz@google.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Eric Dumazet <edumazet@google.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 12:23=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.c=
om> wrote:
>
> +cc Christian, Jason and Willy
>
> On 2023/11/14 7:05, Jakub Kicinski wrote:
> > On Mon, 13 Nov 2023 05:42:16 -0800 Mina Almasry wrote:
> >> You're doing exactly what I think you're doing, and what was nacked in=
 RFC v1.
> >>
> >> You've converted 'struct page_pool_iov' to essentially become a
> >> duplicate of 'struct page'. Then, you're casting page_pool_iov* into
> >> struct page* in mp_dmabuf_devmem_alloc_pages(), then, you're calling
> >> mm APIs like page_ref_*() on the page_pool_iov* because you've fooled
> >> the mm stack into thinking dma-buf memory is a struct page.
>
> Yes, something like above, but I am not sure about the 'fooled the mm
> stack into thinking dma-buf memory is a struct page' part, because:
> 1. We never let the 'struct page' for devmem leaking out of net stacking
>    through the 'not kmap()able and not readable' checking in your patchse=
t.

RFC never used dma-buf pages outside the net stack, so that is the same.

You are not able to get rid of the 'net kmap()able and not readable'
checking with this approach, because dma-buf memory is fundamentally
unkmapable and unreadable. This approach would still need
skb_frags_not_readable checks in net stack, so that is also the same.

> 2. We inititiate page->_refcount for devmem to one and it remains as one,
>    we will never call page_ref_inc()/page_ref_dec()/get_page()/put_page()=
,
>    instead, we use page pool's pp_frag_count to do reference counting for
>    devmem page in patch 6.
>

I'm not sure that moves the needle in terms of allowing dma-buf
memory to look like struct pages.

> >>
> >> RFC v1 was almost exactly the same, except instead of creating a
> >> duplicate definition of struct page, it just allocated 'struct page'
> >> instead of allocating another struct that is identical to struct page
> >> and casting it into struct page.
>
> Perhaps it is more accurate to say this is something between RFC v1 and
> RFC v3, in order to decouple 'struct page' for devmem from mm subsystem,
> but still have most unified handling for both normal memory and devmem
> in page pool and net stack.
>
> The main difference between this patchset and RFC v1:
> 1. The mm subsystem is not supposed to see the 'struct page' for devmem
>    in this patchset, I guess we could say it is decoupled from the mm
>    subsystem even though we still call PageTail()/page_ref_count()/
>    page_is_pfmemalloc() on 'struct page' for devmem.
>

In this patchset you pretty much allocate a struct page for your
dma-buf memory, and then cast it into a struct page, so all the mm
calls in page_pool.c are seeing a struct page when it's really dma-buf
memory.

'even though we still call
PageTail()/page_ref_count()/page_is_pfmemalloc() on 'struct page' for
devmem' is basically making dma-buf memory look like struct pages.

Actually because you put the 'strtuct page for devmem' in
skb->bv_frag, the net stack will grab the 'struct page' for devmem
using skb_frag_page() then call things like page_address(), kmap,
get_page, put_page, etc, etc, etc.

> The main difference between this patchset and RFC v3:
> 1. It reuses the 'struct page' to have more unified handling between
>    normal page and devmem page for net stack.

This is what was nacked in RFC v1.

> 2. It relies on the page->pp_frag_count to do reference counting.
>

I don't see you change any of the page_ref_* calls in page_pool.c, for
example this one:

https://elixir.bootlin.com/linux/latest/source/net/core/page_pool.c#L601

So the reference the page_pool is seeing is actually page->_refcount,
not page->pp_frag_count? I'm confused here. Is this a bug in the
patchset?

> >>
> >> I don't think what you're doing here reverses the nacks I got in RFC
> >> v1. You also did not CC any dma-buf or mm people on this proposal that
> >> would bring up these concerns again.
> >
> > Right, but the mirror struct has some appeal to a non-mm person like
> > myself. The problem IIUC is that this patch is the wrong way around, we
> > should be converting everyone who can deal with non-host mem to struct
> > page_pool_iov. Using page_address() on ppiov which hns3 seems to do in
> > this series does not compute for me.
>
> The hacking use of ppiov in hns3 is only used to do the some prototype
> testing, so ignore it.
>
> >
> > Then we can turn the existing non-iov helpers to be a thin wrapper with
> > just a cast from struct page to struct page_pool_iov, and a call of the
> > iov helper. Again - never cast the other way around.
>
> I am agreed that a cast from struct page to struct page_pool_iov is allow=
ed,
> but a cast from struct page_pool_iov to struct page is not allowed if I a=
m
> understanding you correctly.
>
> Before we can also completely decouple 'struct page' allocated using budd=
y
> allocator directly from mm subsystem in netstack, below is what I have in
> mind in order to support different memory provider.
>
>                                 +--------------+
>                                 |   Netstack   |
>                                 |'struct page' |
>                                 +--------------+
>                                         ^
>                                         |
>                                         |
>                                         v
>                               +---------------------+
> +----------------------+      |                     |      +-------------=
--+
> |      devmem MP       |<---->|     Page pool       |----->|    **** MP  =
  |
> |'struct page_pool_iov'|      |   'struct page'     |      |'struct **_io=
v'|
> +----------------------+      |                     |      +-------------=
--+
>                               +---------------------+
>                                         ^
>                                         |
>                                         |
>                                         v
>                                 +---------------+
>                                 |    Driver     |
>                                 | 'struct page' |
>                                 +---------------+
>
> I would expect net stack, page pool, driver still see the 'struct page',
> only memory provider see the specific struct for itself, for the above,
> devmem memory provider sees the 'struct page_pool_iov'.
>
> The reason I still expect driver to see the 'struct page' is that driver
> will still need to support normal memory besides devmem.
>
> >
> > Also I think this conversion can be done completely separately from the
> > mem provider changes. Just add struct page_pool_iov and start using it.
>
> I am not sure I understand what does "Just add struct page_pool_iov and
> start using it" mean yet.
>
> >
> > Does that make more sense?
> >
> > .
> >



--
Thanks,
Mina
