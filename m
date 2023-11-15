Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA027EC9DD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 18:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjKORo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 12:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjKORoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 12:44:55 -0500
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD1C83
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:44:52 -0800 (PST)
Received: by mail-ua1-x92f.google.com with SMTP id a1e0cc1a2514c-7ba45fc8619so2776079241.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700070291; x=1700675091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yA0mSDgxgLYHALoqWknT9J7D4wZ2ecpGCOc3KqqrcZQ=;
        b=SwhCU04BPZ9EP8tQWeVlrXnomNWBQTJLe4hTlLdwyFmJFWlfGTS+3/zZTXJBEhH8VE
         Nc/UVDhLDpLC/Lu4a6fmgiUVgWKKjH1wq0ipjlHsleiEnJORdw3Nwgj7j+ubCPVV0wwh
         2qGmfoScdW5A2Q2zJwmFhe+s4uJYOHM+CUUZRUPWQB/FDjLSLOoANFAeSUk6Z8TKl6pP
         3ufDsMIOLxtG5a6aHgAxRNLLI2mCdgKa614ZZjo5geUtStfOoO+7YiLqo5Az4u3xI23A
         AU4PPvG1KSmQueLkjhwncmlNXafL0PZ/Ee4VpsJ5tyv564vCujoFg1HlzjSQBFlGCs4E
         ElDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700070291; x=1700675091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yA0mSDgxgLYHALoqWknT9J7D4wZ2ecpGCOc3KqqrcZQ=;
        b=MBQo7QqbKpHuj5iJAbKVf0UkyG+X5Ap6OLK5O4fy1rPc39IuJc3LTdf/X5pnB0JWIh
         WhEo2NCMp6h3lomX/wP5lDjGDCsfAqX+IZrVF3IPJc9uqT7VFpV4W3R/VdU90H2GXE7/
         gZh2nxkZRLAUsjofLqK1Z4gGeob3/9wfLA1W4jQ+32iBUf5r4nHvuqcTWlJ3epWoYd7z
         Vlmbv/DFI+vzOrkYia38mdHbyhLYLGz+obI/L2vlG40CfEiManTXPcl7XC73o17HC8JT
         5an/uM7lUQibgkN+5ZMn/SL5Mi6jlTq8KIA21eQwKCSuh5ZseP/8o8eXcEWzGZzUfyyn
         Jilg==
X-Gm-Message-State: AOJu0YyQ3j3b2qr6OdPQcgVGFQ4ilAZsS3vu0eDSk35Zy9+yfjzZbmEw
        8cu+VrKmXbYxvdHl5fz3KOerN00xWkLOE58FPIzLaDB04jfMgKK+YZI=
X-Google-Smtp-Source: AGHT+IGCeekYmgCpDMKNfje7s/UUbIYwx3KAkOWA4nSYbX+koWgmhlu9SKjkYgbwCqGGk4LNHymbvB4ZbInN8ydoQiM=
X-Received: by 2002:a05:6122:922:b0:4ac:462b:7417 with SMTP id
 j34-20020a056122092200b004ac462b7417mr14917004vka.8.1700070290777; Wed, 15
 Nov 2023 09:44:50 -0800 (PST)
MIME-Version: 1.0
References: <20231113130041.58124-1-linyunsheng@huawei.com>
 <20231113130041.58124-4-linyunsheng@huawei.com> <CAHS8izMjmj0DRT_vjzVq5HMQyXtZdVK=o4OP0gzbaN=aJdQ3ig@mail.gmail.com>
 <20231113180554.1d1c6b1a@kernel.org> <0c39bd57-5d67-3255-9da2-3f3194ee5a66@huawei.com>
 <CAHS8izNxkqiNbTA1y+BjQPAber4Dks3zVFNYo4Bnwc=0JLustA@mail.gmail.com>
 <ZVNzS2EA4zQRwIQ7@nvidia.com> <ed875644-95e8-629a-4c28-bf42329efa56@huawei.com>
In-Reply-To: <ed875644-95e8-629a-4c28-bf42329efa56@huawei.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Wed, 15 Nov 2023 09:44:37 -0800
Message-ID: <CAHS8izMR-FrTtCty8v29atAMor5FmzV_Ogk85H=gqGaJNvJnuA@mail.gmail.com>
Subject: Re: [PATCH RFC 3/8] memory-provider: dmabuf devmem memory provider
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
        davem@davemloft.net, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>,
        Kaiyuan Zhang <kaiyuanz@google.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Eric Dumazet <edumazet@google.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 1:21=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2023/11/14 21:16, Jason Gunthorpe wrote:
> > On Tue, Nov 14, 2023 at 04:21:26AM -0800, Mina Almasry wrote:
> >
> >> Actually because you put the 'strtuct page for devmem' in
> >> skb->bv_frag, the net stack will grab the 'struct page' for devmem
> >> using skb_frag_page() then call things like page_address(), kmap,
> >> get_page, put_page, etc, etc, etc.
> >
> > Yikes, please no. If net has its own struct page look alike it has to
> > stay entirely inside net. A non-mm owned struct page should not be
> > passed into mm calls. It is just way too hacky to be seriously
> > considered :(
>
> Yes, that is something this patchset is trying to do, defining its own
> struct page look alike for page pool to support devmem.
>
> struct page for devmem will not be called into the mm subsystem, so most
> of the mm calls is avoided by calling into the devmem memory provider'
> ops instead of calling mm calls.
>
> As far as I see for now, only page_ref_count(), page_is_pfmemalloc() and
> PageTail() is called for devmem page, which should be easy to ensure that
> those call for devmem page is consistent with the struct page owned by mm=
.

I'm not sure this is true. These 3 calls are just the calls you're
aware of. In your proposal you're casting mirror pages into page* and
releasing them into the net stack. You need to scrub the entire net
stack for mm calls, i.e. all driver code and all skb_frag_page() call
sites. Of the top of my head, the driver is probably calling
page_address() and illegal_highdma() is calling PageHighMem(). TCP
zerocopy receive is calling vm_insert_pages().

> I am not sure if we can use some kind of compile/runtime checking to ensu=
re
> those kinds of consistency?
>
> >
> >>> I would expect net stack, page pool, driver still see the 'struct pag=
e',
> >>> only memory provider see the specific struct for itself, for the abov=
e,
> >>> devmem memory provider sees the 'struct page_pool_iov'.
> >>>
> >>> The reason I still expect driver to see the 'struct page' is that dri=
ver
> >>> will still need to support normal memory besides devmem.
> >
> > I wouldn't say this approach is unreasonable, but it does have to be
> > done carefully to isolate the mm. Keeping the struct page in the API
> > is going to make this very hard.
>
> I would expect that most of the isolation is done in page pool, as far as
> I can see:
>
> 1. For control part: the driver may need to tell the page pool which memo=
ry
>                      provider it want to use. Or the administrator specif=
ies
>                      which memory provider to use by some netlink-based c=
md.
>
> 2. For data part: I am thinking that driver should only call page_pool_al=
loc(),
>                   page_pool_free() and page_pool_get_dma_addr related fun=
ction.
>
> Of course the driver may need to be aware of that if it can call kmap() o=
r
> page_address() on the page returned from page_pool_alloc(), and maybe tel=
l
> net stack that those pages is not kmap()'able and page_address()'able.
>
> >
> > Jason
> > .
> >



--=20
Thanks,
Mina
