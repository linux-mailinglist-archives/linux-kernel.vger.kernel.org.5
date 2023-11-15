Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0817ECAFC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 20:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjKOTFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 14:05:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbjKOTFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 14:05:49 -0500
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D4CC7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 11:05:45 -0800 (PST)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1f066fc2a28so4243014fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 11:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700075145; x=1700679945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l7gRaeRzzj5lepzboTcMyTTCMCWwZvb+WSwh0pgbFKk=;
        b=3w5V52YbhWpqjGI1CHJjdmMt3ESVLgEIKGa2sQaNfghpcM5vhoygLAcfzKHQoMskZE
         wG4XONGuZ9w3R/xtCg7lvELJWMV2cBEQ3I7XhOJ9N8LHXTEPM4fvp9ZBaL5Aed/AqRm6
         lbdekoncENSXzZ3a7PwBCtxicOcZAIwFfgIEQMLAS2p5r9HinhFjqBMCyb496CsSPZ0a
         ZGwA4+Prep55aH/3ri1HBQctTWAbpFIRLJqmNmnZbgu3YwDA0GfnoyjLnRiGDd27KhPD
         Gm5RSwlH90e9Em/BJYA6ImL7Tg7iBhhWHEDSVPQyEY8XTh1vf7PZ5/tSKLWmBVDqR9qq
         pxAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700075145; x=1700679945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l7gRaeRzzj5lepzboTcMyTTCMCWwZvb+WSwh0pgbFKk=;
        b=xGLSH6iqd4qAST+XkJSSu01i6cBvVbMbQHojRMmzcx2rrjjsf+ytTOLWRpbZrauaH/
         dVoIrk3w/R+Vz36F3+nyxD98IZvg9i8sn7sm7oeBpiaVhlK1KL5QM99m5VCTOZZ/ailB
         /GDpgjS4R3FywrEIoJjiac93eWSEhGtKZG2Lmwaaa7JroPx64TAhg57DZ48iZ9gSKD0s
         +953smB9zjYLMjBLPpK367UupRRm2XJCgvuJz7UjyqpsCj+FETIYe2RfbtOLp/MaZHs+
         OQzXxSAytkrSWYuyfJ8w2UpWQbtKCoMNGRaK06t13cpe9YxI+asq+0hxv2hnCA/MvWhM
         G3UA==
X-Gm-Message-State: AOJu0YzIopQO9taNTTZECi7f6giX6a6l0417buC7w18bfi6Po9QCURxC
        C+oATYVIRELXnjTFsvd10kphu2UWgUZtUlmmD5j+LA==
X-Google-Smtp-Source: AGHT+IEmiHDmukUy44qSaauIGSOmkgreUYLdvuvHAAxPw4sFcrapHVFXkOuqhXEPJWEdff7gyyJkd0rYC19zIOUvO9A=
X-Received: by 2002:a05:6358:713:b0:16b:f554:f359 with SMTP id
 e19-20020a056358071300b0016bf554f359mr6881080rwj.7.1700075144624; Wed, 15 Nov
 2023 11:05:44 -0800 (PST)
MIME-Version: 1.0
References: <20231113130041.58124-1-linyunsheng@huawei.com>
 <20231113130041.58124-4-linyunsheng@huawei.com> <CAHS8izMjmj0DRT_vjzVq5HMQyXtZdVK=o4OP0gzbaN=aJdQ3ig@mail.gmail.com>
 <20231113180554.1d1c6b1a@kernel.org> <0c39bd57-5d67-3255-9da2-3f3194ee5a66@huawei.com>
 <CAHS8izNxkqiNbTA1y+BjQPAber4Dks3zVFNYo4Bnwc=0JLustA@mail.gmail.com>
 <fa5d2f4c-5ccc-e23e-1926-2d7625b66b91@huawei.com> <CAHS8izMj_89dMVaMr73r1-3Kewgc1YL3A1mjvixoax2War8kUg@mail.gmail.com>
 <3ff54a20-7e5f-562a-ca2e-b078cc4b4120@huawei.com> <6553954141762_1245c529423@willemb.c.googlers.com.notmuch>
 <8b7d25eb-1f10-3e37-8753-92b42da3fb34@huawei.com> <CAHS8izOBe2X3iPHmvc7JQGiawgm7Gyxov8xq62SShUTXDRguFw@mail.gmail.com>
In-Reply-To: <CAHS8izOBe2X3iPHmvc7JQGiawgm7Gyxov8xq62SShUTXDRguFw@mail.gmail.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Wed, 15 Nov 2023 11:05:31 -0800
Message-ID: <CAHS8izO8bJSpD9ziNQHxpraLsUc8JnazgLA5=ziDBtzriRSQHA@mail.gmail.com>
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 10:07=E2=80=AFAM Mina Almasry <almasrymina@google.c=
om> wrote:
>
> On Wed, Nov 15, 2023 at 1:29=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.=
com> wrote:
> >
> > On 2023/11/14 23:41, Willem de Bruijn wrote:
> > >>
> > >> I am not sure dma-buf maintainer's concern is still there with this =
patchset.
> > >>
> > >> Whatever name you calling it for the struct, however you arrange eac=
h field
> > >> in the struct, some metadata is always needed for dmabuf to intergra=
te into
> > >> page pool.
> > >>
> > >> If the above is true, why not utilize the 'struct page' to have more=
 unified
> > >> handling?
> > >
> > > My understanding is that there is a general preference to simplify st=
ruct
> > > page, and at the least not move in the other direction by overloading=
 the
> > > struct in new ways.
> >
> > As my understanding, the new struct is just mirroring the struct page p=
ool
> > is already using, see:
> > https://elixir.free-electrons.com/linux/v6.7-rc1/source/include/linux/m=
m_types.h#L119
> >
> > If there is simplifying to the struct page_pool is using, I think the n=
ew
> > stuct the devmem memory provider is using can adjust accordingly.
> >
> > As a matter of fact, I think the way 'struct page' for devmem is decoup=
led
> > from mm subsystem may provide a way to simplify or decoupled the alread=
y
> > existing 'struct page' used in netstack from mm subsystem, before this
> > patchset, it seems we have the below types of 'struct page':
> > 1. page allocated in the netstack using page pool.
> > 2. page allocated in the netstack using buddy allocator.
> > 3. page allocated in other subsystem and passed to the netstack, such a=
s
> >    zcopy or spliced page?
> >
> > If we can decouple 'struct page' for devmem from mm subsystem, we may b=
e able
> > to decouple the above 'struct page' from mm subsystem one by one.
> >
> > >
> > > If using struct page for something that is not memory, there is ZONE_=
DEVICE.
> > > But using that correctly is non-trivial:
> > >
> > > https://lore.kernel.org/all/ZKyZBbKEpmkFkpWV@ziepe.ca/
> > >
> > > Since all we need is a handle that does not leave the network stack,
> > > a network specific struct like page_pool_iov entirely avoids this iss=
ue.
> >
> > Yes, I am agree about the network specific struct.
> > I am wondering if we can make the struct more generic if we want to
> > intergrate it into page_pool and use it in net stack.
> >
> > > RFC v3 seems like a good simplification over RFC v1 in that regard to=
 me.
> > > I was also pleasantly surprised how minimal the change to the users o=
f
> > > skb_frag_t actually proved to be.
> >
> > Yes, I am agreed about that too. Maybe we can make it simpler by using
> > a more abstract struct as page_pool, and utilize some features of
> > page_pool too.
> >
> > For example, from the page_pool doc, page_pool have fast cache and
> > ptr-ring cache as below, but if napi_frag_unref() call
> > page_pool_page_put_many() and return the dmabuf chunk directly to
> > gen_pool in the memory provider, then it seems we are bypassing the
> > below caches in the page_pool.
> >
>
> I think you're just misunderstanding the code. The page recycling
> works with my patchset. napi_frag_unref() calls napi_pp_put_page() if
> recycle =3D=3D true, and that works the same with devmem as with regular
> pages.
>
> If recycle =3D=3D false, we call page_pool_page_put_many() which will cal=
l
> put_page() for regular pages and page_pool_iov_put_many() for devmem
> pages. So, the memory recycling works exactly the same as before with
> devmem as with regular pages. In my tests I do see the devmem being
> recycled correctly. We are not bypassing any caches.
>
>

Ah, taking a closer look here, the devmem recycling works for me but I
think that's a side effect to the fact that the page_pool support I
implemented with GVE is unusual. I currently allocate pages from the
page_pool but do not set skb_mark_for_recycle(). The page recycling
still happens when GVE is done with the page and calls
page_pool_put_full_pgae(), as that eventually checks the refcount on
the devmem and recycles it.

I will fix up the GVE to call skb_mark_for_recycle() and ensure the
napi_pp_put_page() path recycles the devmem or page correctly in the
next version.

> >     +------------------+
> >     |       Driver     |
> >     +------------------+
> >             ^
> >             |
> >             |
> >             |
> >             v
> >     +--------------------------------------------+
> >     |                request memory              |
> >     +--------------------------------------------+
> >         ^                                  ^
> >         |                                  |
> >         | Pool empty                       | Pool has entries
> >         |                                  |
> >         v                                  v
> >     +-----------------------+     +------------------------+
> >     | alloc (and map) pages |     |  get page from cache   |
> >     +-----------------------+     +------------------------+
> >                                     ^                    ^
> >                                     |                    |
> >                                     | cache available    | No entries, =
refill
> >                                     |                    | from ptr-rin=
g
> >                                     |                    |
> >                                     v                    v
> >                           +-----------------+     +------------------+
> >                           |   Fast cache    |     |  ptr-ring cache  |
> >                           +-----------------+     +------------------+
> >
> >
> > >
> > > .
> > >
>
>
>
> --
> Thanks,
> Mina



--=20
Thanks,
Mina
