Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2877EDFE3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 12:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344985AbjKPLbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 06:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjKPLbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 06:31:12 -0500
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974EAE0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 03:31:08 -0800 (PST)
Received: by mail-vk1-xa2c.google.com with SMTP id 71dfb90a1353d-495eb6e2b80so258032e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 03:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700134267; x=1700739067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+5ZN/4d17A7tB0MhyQTTzrWx/HMOUSq5lA4jSyJp+JY=;
        b=dLRDGWJf4zNUR4H7RfGacDCuD2S86aykgyrzMZrPGMASFO3+YE45G6STwedAvruSph
         Ingm5tX++H+YkQIOcl5Hpe9QXF5CjFajZnChinoOlxXsvs7P+E36/DyTUnJllDJs2ybr
         Ce+HBOPNNMDY75daNeP7Qo/L1Mcz0lu1x3n4dFpoW74IGJrJWuIjwXYA1Vy357tf/z8n
         8xzwdn/alFYnznKaheCNWehTq8jMG3sWWqTtM5jKBBnd0qoCAFw2DFRJuOcb9i1lLn9x
         8rs2V2MQU1RFNP45ZRtdDbQ7qeOhDWxZF7zry3hkBNWO+wdwUh4ZVqDK/EJPb9oVEF4+
         r5Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700134267; x=1700739067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+5ZN/4d17A7tB0MhyQTTzrWx/HMOUSq5lA4jSyJp+JY=;
        b=HaXPIyvFzoYay+9gU4h8g75m5LR+lImr0N6M4kQX0tD24nwOhynu7X8brXxwzd/3fG
         hOJNqslFnXfeMJ3vKgp3qt3rMFo1ZVm4Jf+9rClilwOMKBVP/HtdYSDxSyGSSAPdngay
         8alWQMCRf7j0MrSBTrPeS79wjhlsVO0byMvjGBvA1a+LV/JxKJy0g+KgCPhWybH+Pkgr
         qR5tQUljIwUPyy9XDNVc1WhlYlGx+YKWvdIYkAoDyQSmRHDjJh5rMXeOyU7YUlt/IpoO
         wpn/z9y62WSTDr2duATgZeMQxzDppMH9jdBHEDgs/zWL4DVwbJudO3EF0bAAEjjuG7Ct
         tGDQ==
X-Gm-Message-State: AOJu0Yw1+rhmwgy29Ae2YryVnxukxL1Z5NALSodiNAZHi8JytbTi724y
        nCdUeWE/e5z1YxKGFrjm3PGM0MOau4brMm6jhy5o2g==
X-Google-Smtp-Source: AGHT+IHFKFgWat9IoRWwq8su2ufFgXT3dkMF7jf+D3n8ImjCoAZTvVLo9HLgvhei72vQNdk1/LYi/TVgFGX3xOftTNk=
X-Received: by 2002:a05:6122:914:b0:4ac:b0a6:4c16 with SMTP id
 j20-20020a056122091400b004acb0a64c16mr12023352vka.10.1700134267121; Thu, 16
 Nov 2023 03:31:07 -0800 (PST)
MIME-Version: 1.0
References: <20231113130041.58124-1-linyunsheng@huawei.com>
 <20231113130041.58124-4-linyunsheng@huawei.com> <CAHS8izMjmj0DRT_vjzVq5HMQyXtZdVK=o4OP0gzbaN=aJdQ3ig@mail.gmail.com>
 <20231113180554.1d1c6b1a@kernel.org> <0c39bd57-5d67-3255-9da2-3f3194ee5a66@huawei.com>
 <CAHS8izNxkqiNbTA1y+BjQPAber4Dks3zVFNYo4Bnwc=0JLustA@mail.gmail.com>
 <fa5d2f4c-5ccc-e23e-1926-2d7625b66b91@huawei.com> <CAHS8izMj_89dMVaMr73r1-3Kewgc1YL3A1mjvixoax2War8kUg@mail.gmail.com>
 <3ff54a20-7e5f-562a-ca2e-b078cc4b4120@huawei.com> <6553954141762_1245c529423@willemb.c.googlers.com.notmuch>
 <8b7d25eb-1f10-3e37-8753-92b42da3fb34@huawei.com> <CAHS8izOBe2X3iPHmvc7JQGiawgm7Gyxov8xq62SShUTXDRguFw@mail.gmail.com>
 <CAHS8izO8bJSpD9ziNQHxpraLsUc8JnazgLA5=ziDBtzriRSQHA@mail.gmail.com> <0366d9e8-7796-b15a-d309-d2fd81f9d700@huawei.com>
In-Reply-To: <0366d9e8-7796-b15a-d309-d2fd81f9d700@huawei.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Thu, 16 Nov 2023 03:30:53 -0800
Message-ID: <CAHS8izNBq_p4otYi+RFNdRfjXvWMjYJoxYrrp24Q4gTaaRX+wQ@mail.gmail.com>
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
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 3:12=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2023/11/16 3:05, Mina Almasry wrote:
> > On Wed, Nov 15, 2023 at 10:07=E2=80=AFAM Mina Almasry <almasrymina@goog=
le.com> wrote:
> >>
> >> On Wed, Nov 15, 2023 at 1:29=E2=80=AFAM Yunsheng Lin <linyunsheng@huaw=
ei.com> wrote:
> >>>
> >>> On 2023/11/14 23:41, Willem de Bruijn wrote:
> >>>>>
> >>>>> I am not sure dma-buf maintainer's concern is still there with this=
 patchset.
> >>>>>
> >>>>> Whatever name you calling it for the struct, however you arrange ea=
ch field
> >>>>> in the struct, some metadata is always needed for dmabuf to intergr=
ate into
> >>>>> page pool.
> >>>>>
> >>>>> If the above is true, why not utilize the 'struct page' to have mor=
e unified
> >>>>> handling?
> >>>>
> >>>> My understanding is that there is a general preference to simplify s=
truct
> >>>> page, and at the least not move in the other direction by overloadin=
g the
> >>>> struct in new ways.
> >>>
> >>> As my understanding, the new struct is just mirroring the struct page=
 pool
> >>> is already using, see:
> >>> https://elixir.free-electrons.com/linux/v6.7-rc1/source/include/linux=
/mm_types.h#L119
> >>>
> >>> If there is simplifying to the struct page_pool is using, I think the=
 new
> >>> stuct the devmem memory provider is using can adjust accordingly.
> >>>
> >>> As a matter of fact, I think the way 'struct page' for devmem is deco=
upled
> >>> from mm subsystem may provide a way to simplify or decoupled the alre=
ady
> >>> existing 'struct page' used in netstack from mm subsystem, before thi=
s
> >>> patchset, it seems we have the below types of 'struct page':
> >>> 1. page allocated in the netstack using page pool.
> >>> 2. page allocated in the netstack using buddy allocator.
> >>> 3. page allocated in other subsystem and passed to the netstack, such=
 as
> >>>    zcopy or spliced page?
> >>>
> >>> If we can decouple 'struct page' for devmem from mm subsystem, we may=
 be able
> >>> to decouple the above 'struct page' from mm subsystem one by one.
> >>>
> >>>>
> >>>> If using struct page for something that is not memory, there is ZONE=
_DEVICE.
> >>>> But using that correctly is non-trivial:
> >>>>
> >>>> https://lore.kernel.org/all/ZKyZBbKEpmkFkpWV@ziepe.ca/
> >>>>
> >>>> Since all we need is a handle that does not leave the network stack,
> >>>> a network specific struct like page_pool_iov entirely avoids this is=
sue.
> >>>
> >>> Yes, I am agree about the network specific struct.
> >>> I am wondering if we can make the struct more generic if we want to
> >>> intergrate it into page_pool and use it in net stack.
> >>>
> >>>> RFC v3 seems like a good simplification over RFC v1 in that regard t=
o me.
> >>>> I was also pleasantly surprised how minimal the change to the users =
of
> >>>> skb_frag_t actually proved to be.
> >>>
> >>> Yes, I am agreed about that too. Maybe we can make it simpler by usin=
g
> >>> a more abstract struct as page_pool, and utilize some features of
> >>> page_pool too.
> >>>
> >>> For example, from the page_pool doc, page_pool have fast cache and
> >>> ptr-ring cache as below, but if napi_frag_unref() call
> >>> page_pool_page_put_many() and return the dmabuf chunk directly to
> >>> gen_pool in the memory provider, then it seems we are bypassing the
> >>> below caches in the page_pool.
> >>>
> >>
> >> I think you're just misunderstanding the code. The page recycling
> >> works with my patchset. napi_frag_unref() calls napi_pp_put_page() if
> >> recycle =3D=3D true, and that works the same with devmem as with regul=
ar
> >> pages.
> >>
> >> If recycle =3D=3D false, we call page_pool_page_put_many() which will =
call
> >> put_page() for regular pages and page_pool_iov_put_many() for devmem
> >> pages. So, the memory recycling works exactly the same as before with
> >> devmem as with regular pages. In my tests I do see the devmem being
> >> recycled correctly. We are not bypassing any caches.
> >>
> >>
> >
> > Ah, taking a closer look here, the devmem recycling works for me but I
> > think that's a side effect to the fact that the page_pool support I
> > implemented with GVE is unusual. I currently allocate pages from the
> > page_pool but do not set skb_mark_for_recycle(). The page recycling
> > still happens when GVE is done with the page and calls
> > page_pool_put_full_pgae(), as that eventually checks the refcount on
> > the devmem and recycles it.
> >
> > I will fix up the GVE to call skb_mark_for_recycle() and ensure the
> > napi_pp_put_page() path recycles the devmem or page correctly in the
> > next version.
>
> What about other features? Like dma mapping optimization and frag support
> in the page pool.
>

PP_FLAG_DMA_MAP will be supported and required in the next version per
Jakub's request.

frag support is something I disabled in the initial versions of the
patchset, but only out of convenience and to simplify the initial
implementation. At google we typically use page aligned MSS and the
frag support isn't really that useful for us. I don't see an issue
extending frag support to devmem and iovs in the future if needed.
We'd probably add the pp_frag_count field to page_pool_iov and handle
it similarly to how it's handled for pages.

> I understand that you use some trick in the gen_gool to avoid the per chu=
nk
> dma_addr storage in the 'struct page_pool_iov' and do not need frag suppo=
rt
> for now.
>
> But for other memory provider, if they need those supports, we probably n=
eed
> to extend 'struct page_pool_iov' to support those features, then we may h=
ave
> a 'struct page_pool_iov' to be looking alike to the sepcific union for pa=
ge_pool
> in 'struct page', see:
>
> https://elixir.free-electrons.com/linux/v6.7-rc1/source/include/linux/mm_=
types.h#L119
>
> We currently don't have a way to decouple the existing 'struct page' from=
 mm
> subsystem yet as my understanding, if we don't mirror the above union in =
the
> 'struct page', we may have more 'if' checking added in the future.



--=20
Thanks,
Mina
