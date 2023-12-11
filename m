Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1B780C03B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 05:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjLKEEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 23:04:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjLKEEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 23:04:48 -0500
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2341ED
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 20:04:50 -0800 (PST)
Received: by mail-vk1-xa2d.google.com with SMTP id 71dfb90a1353d-4b2ceee07e5so2307238e0c.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 20:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702267490; x=1702872290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRqbtjk8rq4zydD2Xsjk5a3+pHw9ItIcSF2MB1yehQo=;
        b=VaDRWRM1KRnktwFxZ92SGWHc1wbhGhcnjpbwvr7zS/PYf7hQmZDMYJBrBxhQ4eVjnA
         Q+c2MzggIH/mQZjlACA44bUtyaF2Fd2UijObUiaGn0cfrabnnsoeH7776n8Xgitmi1yY
         yjxFOAmF5tRy3PfE+F2GcW7IlBjeQdWuhMuwuIp3C33DpBBBGJiiYMoQ6zPce2JeeAaB
         trzubaUeLVF7btf1C6JnWpEiFKOGS9XLFm+btbsaj6YpJ0LgWiubuabKMyNLHJXnPux4
         vx0wSYQPT9j+ECQZ/fRwvyVnjJKc8Dhw82g/lYSA61ce8PUrx2nAlKy5Czg24W3W5u4b
         GQpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702267490; x=1702872290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VRqbtjk8rq4zydD2Xsjk5a3+pHw9ItIcSF2MB1yehQo=;
        b=rdmRQpr+/3Nbcr2BkIGiVFNt2yOVQYtxyQAaeeh/uL94Rc/3qH4vtoylYmpna9jTPn
         iMxLgfmVlxRr2x+WG3e/IU44ZBd1JGwh6nagc5nxHTkHY8PVi6DPbFn5IsdpO09xA+S4
         z7ucPgm1wwf8wBluflTvGB9aYyiF8NQpmgGCP01UOM6wAt8vC3dzJsqM+/u2oktd2vYi
         GttOUMSX/EpJVgktFnDywKk0/K8E64iKPgFsYk2XsjiRAjkCHuYio26XI7P0hVog+Hqp
         DDy6FRBjanqykELIyXHGHPHlUj7MeV/5xqV9JVNbYZed8508/Skza8F2wJwsZmpYHw2G
         xxcw==
X-Gm-Message-State: AOJu0YwAOGOnkGVMnobqpNktVmqdwr7yveN4lcdqdrMhWclwzRglfe+z
        MQXg9Q9g0F7XU9kbCY8jSVVingz1Ssw6p3SlTeyCXA==
X-Google-Smtp-Source: AGHT+IGAfd74P9yx0nc2KiABSnElGYTnepENJsYtWliZ+g0y9LWw0IHdbTNPBs473It21Lgw8vWq6UsEAVUukNqm/hI=
X-Received: by 2002:a05:6122:18aa:b0:496:80b6:2fd1 with SMTP id
 bi42-20020a05612218aa00b0049680b62fd1mr2519624vkb.5.1702267489809; Sun, 10
 Dec 2023 20:04:49 -0800 (PST)
MIME-Version: 1.0
References: <20231208005250.2910004-1-almasrymina@google.com>
 <20231208005250.2910004-10-almasrymina@google.com> <32211cbf-3a4e-8a86-6214-4304ddb18a98@huawei.com>
 <CAHS8izOQcuLPwvDff96fuNB7r6EU9OWt3ShueQp=u7wat3L5LA@mail.gmail.com>
 <92e30bd9-6df4-b72f-7bcd-f4fe5670eba2@huawei.com> <CAHS8izPEFsqw50qgM+sPot6XVvOExpd+DrwrmPSR3zsWGLysRw@mail.gmail.com>
In-Reply-To: <CAHS8izPEFsqw50qgM+sPot6XVvOExpd+DrwrmPSR3zsWGLysRw@mail.gmail.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Sun, 10 Dec 2023 20:04:36 -0800
Message-ID: <CAHS8izN6Cbjy0FCYhJyNsP396XfgJ_nTFXWuHb5QWNct=PifAg@mail.gmail.com>
Subject: Re: [net-next v1 09/16] page_pool: device memory support
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     Shailend Chand <shailend@google.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        bpf@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jeroen de Borst <jeroendb@google.com>,
        Praveen Kaligineedi <pkaligineedi@google.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Ahern <dsahern@kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Harshitha Ramamurthy <hramamurthy@google.com>,
        Shakeel Butt <shakeelb@google.com>
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

On Sun, Dec 10, 2023 at 6:26=E2=80=AFPM Mina Almasry <almasrymina@google.co=
m> wrote:
>
> On Sun, Dec 10, 2023 at 6:04=E2=80=AFPM Yunsheng Lin <linyunsheng@huawei.=
com> wrote:
> >
> > On 2023/12/9 0:05, Mina Almasry wrote:
> > > On Fri, Dec 8, 2023 at 1:30=E2=80=AFAM Yunsheng Lin <linyunsheng@huaw=
ei.com> wrote:
> > >>
> > >>
> > >> As mentioned before, it seems we need to have the above checking eve=
ry
> > >> time we need to do some per-page handling in page_pool core, is ther=
e
> > >> a plan in your mind how to remove those kind of checking in the futu=
re?
> > >>
> > >
> > > I see 2 ways to remove the checking, both infeasible:
> > >
> > > 1. Allocate a wrapper struct that pulls out all the fields the page p=
ool needs:
> > >
> > > struct netmem {
> > >         /* common fields */
> > >         refcount_t refcount;
> > >         bool is_pfmemalloc;
> > >         int nid;
> > >         ...
> > >         union {
> > >                 struct dmabuf_genpool_chunk_owner *owner;
> > >                 struct page * page;
> > >         };
> > > };
> > >
> > > The page pool can then not care if the underlying memory is iov or
> > > page. However this introduces significant memory bloat as this struct
> > > needs to be allocated for each page or ppiov, which I imagine is not
> > > acceptable for the upside of removing a few static_branch'd if
> > > statements with no performance cost.
> > >
> > > 2. Create a unified struct for page and dmabuf memory, which the mm
> > > folks have repeatedly nacked, and I imagine will repeatedly nack in
> > > the future.
> > >
> > > So I imagine the special handling of ppiov in some form is critical
> > > and the checking may not be removable.
> >
> > If the above is true, perhaps devmem is not really supposed to be inter=
gated
> > into page_pool.
> >
> > Adding a checking for every per-page handling in page_pool core is just=
 too
> > hacky to be really considerred a longterm solution.
> >
>
> The only other option is to implement another page_pool for ppiov and
> have the driver create page_pool or ppiov_pool depending on the state
> of the netdev_rx_queue (or some helper in the net stack to do that for
> the driver). This introduces some code duplication. The ppiov_pool &
> page_pool would look similar in implementation.
>
> But this was all discussed in detail in RFC v2 and the last response I
> heard from Jesper was in favor if this approach, if I understand
> correctly:
>
> https://lore.kernel.org/netdev/7aedc5d5-0daf-63be-21bc-3b724cc1cab9@redha=
t.com/
>
> Would love to have the maintainer weigh in here.
>

I should note we may be able to remove some of the checking, but maybe not =
all.

- Checks that disable page fragging for ppiov can be removed once
ppiov has frag support (in this series or follow up).

- If we use page->pp_frag_count (or page->pp_ref_count) for
refcounting ppiov, we can remove the if checking in the refcounting.

- We may be able to store the dma_addr of the ppiov in page->dma_addr,
but I'm unsure if that actually works, because the dma_buf dmaddr is
dma_addr_t (u32 or u64), but page->dma_addr is unsigned long (4 bytes
I think). But if it works for pages I may be able to make it work for
ppiov as well.

- Checks that obtain the page->pp can work with ppiov if we align the
offset of page->pp and ppiov->pp.

- Checks around page->pp_magic can be removed if we also have offset
aligned ppiov->pp_magic.

Sadly I don't see us removing the checking for these other cases:

- page_is_pfmemalloc(): I'm not allowed to pass a non-struct page into
that helper.

- page_to_nid(): I'm not allowed to pass a non-struct page into that helper=
.

- page_pool_free_va(): ppiov have no va.

- page_pool_sync_for_dev/page_pool_dma_map: ppiov backed by dma-buf
fundamentally can't get mapped again.

Are the removal (or future removal) of these checks enough to resolve this?

> > It is somewhat ironical that devmem is using static_branch to alliviate=
 the
> > performance impact for normal memory at the possible cost of performanc=
e
> > degradation for devmem, does it not defeat some purpose of intergating =
devmem
> > to page_pool?
> >
>
> I don't see the issue. The static branch sets the non-ppiov path as
> default if no memory providers are in use, and flips it when they are,
> making the default branch prediction ideal in both cases.
>
> > >
> > >> Even though a static_branch check is added in page_is_page_pool_iov(=
), it
> > >> does not make much sense that a core has tow different 'struct' for =
its
> > >> most basic data.
> > >>
> > >> IMHO, the ppiov for dmabuf is forced fitting into page_pool without =
much
> > >> design consideration at this point.
> > >>
> > > ...
> > >>
> > >> For now, the above may work for the the rx part as it seems that you=
 are
> > >> only enabling rx for dmabuf for now.
> > >>
> > >> What is the plan to enable tx for dmabuf? If it is also intergrated =
into
> > >> page_pool? There was a attempt to enable page_pool for tx, Eric seem=
ed to
> > >> have some comment about this:
> > >> https://lkml.kernel.org/netdev/2cf4b672-d7dc-db3d-ce90-15b4e91c4005@=
huawei.com/T/#mb6ab62dc22f38ec621d516259c56dd66353e24a2
> > >>
> > >> If tx is not intergrated into page_pool, do we need to create a new =
layer for
> > >> the tx dmabuf?
> > >>
> > >
> > > I imagine the TX path will reuse page_pool_iov, page_pool_iov_*()
> > > helpers, and page_pool_page_*() helpers, but will not need any core
> > > page_pool changes. This is because the TX path will have to piggyback
> >
> > We may need another bit/flags checking to demux between page_pool owned
> > devmem and non-page_pool owned devmem.
> >
>
> The way I'm imagining the support, I don't see the need for such
> flags. We'd be re-using generic helpers like
> page_pool_iov_get_dma_address() and what not that don't need that
> checking.
>
> > Also calling page_pool_*() on non-page_pool owned devmem is confusing
> > enough that we may need a thin layer handling non-page_pool owned devme=
m
> > in the end.
> >
>
> The page_pool_page* & page_pool_iov* functions can be renamed if
> confusing. I would think that's no issue (note that the page_pool_*
> functions need not be called for TX path).
>
> > > on MSG_ZEROCOPY (devmem is not copyable), so no memory allocation fro=
m
> > > the page_pool (or otherwise) is needed or possible. RFCv1 had a TX
> > > implementation based on dmabuf pages without page_pool involvement, I
> > > imagine I'll do something similar.
> > It would be good to have a tx implementation for the next version, so
> > that we can have a whole picture of devmem.
> >
> > >
>
>
>
> --
> Thanks,
> Mina



--
Thanks,
Mina
