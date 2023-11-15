Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC847ECA3F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 19:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjKOSH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 13:07:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjKOSH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 13:07:27 -0500
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6641A4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 10:07:23 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id ada2fe7eead31-45f3b583ce9so707514137.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 10:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700071643; x=1700676443; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=237jqdz3sNQ/lMkcIJ++z3uG+l/JTotWsahyw09GVyw=;
        b=Q9mSL6RObvk6NyMJ1igdQ8hfCosR6lmrelkQbqqR+H+GnmVt59tRWJw+AjOk0PR/Pz
         D6wVNaD7HHExG9FLMFuxKw2ciFODZyAGHVgdOw/97eG3koqiQnvz+zxmnEbliXMXekub
         y59fkRzHXu5tm+oHa0gMKewrmCAxTcM+uqST3xDY/8zc32h5IOazcIJlwx0R3zXJcODO
         1thEyHdOuEGc4HYsx9Wrub9C5Jw9noT49u0nZwC/ngaF9aZzVjFbIMxioWk09SE0lTgz
         Y2Rvb4onBis5vLb1e2tIPxbOanq/IjLJ2SfL4fxyz/6CvkvfkCWHtd1lkUyuIgAVJa9T
         MxpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700071643; x=1700676443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=237jqdz3sNQ/lMkcIJ++z3uG+l/JTotWsahyw09GVyw=;
        b=AghWmVZCQ/mTv+2D+43ahXJtfR5kXU+SrSbnRC9UItLF4IV7NdbilCOo7Oq59qkhKz
         UvimMGKtxzuZWa9Ux0gQPiKDGG81LDYDug6IpPgMi00zSDgAKsXgjid9HN0WAFFzfUbP
         n6x4aawCNDlSrtkKsanpaX9psLzQ6iSjor+MIPk8Wxmp7d0fS4tq8UkoZ7FajWGOVTkA
         t9KzziqYAf6ytLCwgE5XzcE0U313FfSL5u1H8UUUESW/HqHXhK+I4Jqo0XeqSOfrnR9H
         CS+eLHDKbfiT9KGlVIHjS2R6Tmq0WZZdyjmMr5Z47RskUJlGnFzhPoV0IfaPWnBZt0ca
         2Zrg==
X-Gm-Message-State: AOJu0YymHbuTr2T1+X9fqXqQU1tZNUKhhwzUD6/W6SlB3rIXXyAPoFmb
        3hJzSSMS5X4XXrA7f4+sXEuVEE+oPgUslbYeI6Zx2w==
X-Google-Smtp-Source: AGHT+IG8CUZxP+tWJWjpLoHj4LC1OTaS/XqIvVoVoDj81d6WPEvc60nVIzPKPJjPrVoQRYOjBqsIakFeKXa7RcJYk5g=
X-Received: by 2002:a05:6102:5c5:b0:452:6d82:56e3 with SMTP id
 v5-20020a05610205c500b004526d8256e3mr4378226vsf.6.1700071642710; Wed, 15 Nov
 2023 10:07:22 -0800 (PST)
MIME-Version: 1.0
References: <20231113130041.58124-1-linyunsheng@huawei.com>
 <20231113130041.58124-4-linyunsheng@huawei.com> <CAHS8izMjmj0DRT_vjzVq5HMQyXtZdVK=o4OP0gzbaN=aJdQ3ig@mail.gmail.com>
 <20231113180554.1d1c6b1a@kernel.org> <0c39bd57-5d67-3255-9da2-3f3194ee5a66@huawei.com>
 <CAHS8izNxkqiNbTA1y+BjQPAber4Dks3zVFNYo4Bnwc=0JLustA@mail.gmail.com>
 <fa5d2f4c-5ccc-e23e-1926-2d7625b66b91@huawei.com> <CAHS8izMj_89dMVaMr73r1-3Kewgc1YL3A1mjvixoax2War8kUg@mail.gmail.com>
 <3ff54a20-7e5f-562a-ca2e-b078cc4b4120@huawei.com> <6553954141762_1245c529423@willemb.c.googlers.com.notmuch>
 <8b7d25eb-1f10-3e37-8753-92b42da3fb34@huawei.com>
In-Reply-To: <8b7d25eb-1f10-3e37-8753-92b42da3fb34@huawei.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Wed, 15 Nov 2023 10:07:11 -0800
Message-ID: <CAHS8izOBe2X3iPHmvc7JQGiawgm7Gyxov8xq62SShUTXDRguFw@mail.gmail.com>
Subject: Re: [PATCH RFC 3/8] memory-provider: dmabuf devmem memory provider
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
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

On Wed, Nov 15, 2023 at 1:29=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2023/11/14 23:41, Willem de Bruijn wrote:
> >>
> >> I am not sure dma-buf maintainer's concern is still there with this pa=
tchset.
> >>
> >> Whatever name you calling it for the struct, however you arrange each =
field
> >> in the struct, some metadata is always needed for dmabuf to intergrate=
 into
> >> page pool.
> >>
> >> If the above is true, why not utilize the 'struct page' to have more u=
nified
> >> handling?
> >
> > My understanding is that there is a general preference to simplify stru=
ct
> > page, and at the least not move in the other direction by overloading t=
he
> > struct in new ways.
>
> As my understanding, the new struct is just mirroring the struct page poo=
l
> is already using, see:
> https://elixir.free-electrons.com/linux/v6.7-rc1/source/include/linux/mm_=
types.h#L119
>
> If there is simplifying to the struct page_pool is using, I think the new
> stuct the devmem memory provider is using can adjust accordingly.
>
> As a matter of fact, I think the way 'struct page' for devmem is decouple=
d
> from mm subsystem may provide a way to simplify or decoupled the already
> existing 'struct page' used in netstack from mm subsystem, before this
> patchset, it seems we have the below types of 'struct page':
> 1. page allocated in the netstack using page pool.
> 2. page allocated in the netstack using buddy allocator.
> 3. page allocated in other subsystem and passed to the netstack, such as
>    zcopy or spliced page?
>
> If we can decouple 'struct page' for devmem from mm subsystem, we may be =
able
> to decouple the above 'struct page' from mm subsystem one by one.
>
> >
> > If using struct page for something that is not memory, there is ZONE_DE=
VICE.
> > But using that correctly is non-trivial:
> >
> > https://lore.kernel.org/all/ZKyZBbKEpmkFkpWV@ziepe.ca/
> >
> > Since all we need is a handle that does not leave the network stack,
> > a network specific struct like page_pool_iov entirely avoids this issue=
.
>
> Yes, I am agree about the network specific struct.
> I am wondering if we can make the struct more generic if we want to
> intergrate it into page_pool and use it in net stack.
>
> > RFC v3 seems like a good simplification over RFC v1 in that regard to m=
e.
> > I was also pleasantly surprised how minimal the change to the users of
> > skb_frag_t actually proved to be.
>
> Yes, I am agreed about that too. Maybe we can make it simpler by using
> a more abstract struct as page_pool, and utilize some features of
> page_pool too.
>
> For example, from the page_pool doc, page_pool have fast cache and
> ptr-ring cache as below, but if napi_frag_unref() call
> page_pool_page_put_many() and return the dmabuf chunk directly to
> gen_pool in the memory provider, then it seems we are bypassing the
> below caches in the page_pool.
>

I think you're just misunderstanding the code. The page recycling
works with my patchset. napi_frag_unref() calls napi_pp_put_page() if
recycle =3D=3D true, and that works the same with devmem as with regular
pages.

If recycle =3D=3D false, we call page_pool_page_put_many() which will call
put_page() for regular pages and page_pool_iov_put_many() for devmem
pages. So, the memory recycling works exactly the same as before with
devmem as with regular pages. In my tests I do see the devmem being
recycled correctly. We are not bypassing any caches.


>     +------------------+
>     |       Driver     |
>     +------------------+
>             ^
>             |
>             |
>             |
>             v
>     +--------------------------------------------+
>     |                request memory              |
>     +--------------------------------------------+
>         ^                                  ^
>         |                                  |
>         | Pool empty                       | Pool has entries
>         |                                  |
>         v                                  v
>     +-----------------------+     +------------------------+
>     | alloc (and map) pages |     |  get page from cache   |
>     +-----------------------+     +------------------------+
>                                     ^                    ^
>                                     |                    |
>                                     | cache available    | No entries, re=
fill
>                                     |                    | from ptr-ring
>                                     |                    |
>                                     v                    v
>                           +-----------------+     +------------------+
>                           |   Fast cache    |     |  ptr-ring cache  |
>                           +-----------------+     +------------------+
>
>
> >
> > .
> >



--=20
Thanks,
Mina
