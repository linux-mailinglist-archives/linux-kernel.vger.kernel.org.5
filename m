Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECF975AD0B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 13:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjGTLek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 07:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjGTLei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 07:34:38 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A629123
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 04:34:37 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-4819122cc5bso281628e0c.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 04:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689852876; x=1690457676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IMMjhtcZTStjbNkvTZf4V2jHayFRPXrALrjnBQhdN3U=;
        b=IQjVkdRjot0p6iU2O93sdpl5WsD07G0JoXcTDPwCvwZawrpSIgK6GbmsUu+hIwBw7v
         zZnKxhU5lobVBBONJ5XhAUz9xd6uN7x+Qs7EKRm/ZHkvfyU9zExVEBl1AKabDcFfFtU/
         NRXb2ZmtHRx53MvP/nT0tJOjO6/BCJKSG8Mc5HjdNHl8HWN+mnExYxkHxsGxQbMzb1y7
         ZXkMU/+osHcyHbhVxJj51fGY2qkaQ0nRGWw6iJU4q0RJcx7rAjXXg0b3/C5bIz1ErhfE
         2XhzyoQbJZ9SAZYsK2UnnvqrmFp/QkHN0p2NyVELICmYM58Gs7EO9kH2Eko4GcICxm3+
         EWUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689852876; x=1690457676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IMMjhtcZTStjbNkvTZf4V2jHayFRPXrALrjnBQhdN3U=;
        b=jmCPkIks/bc9t9oQ8sJVkLk5UKTdHvH9ak3oHcwRw2nYINbGYAL1E4LlJ3CBoGs1aw
         mPJL0UM2ihVNaHGtRAh9z3PtkIq4qN6+m0djHUapIfqVIOlTCeFESsklfZAFBnYPqWGz
         KVKWAzXliOZeAKA2Z9TYzbNf86tv9ywhyYgI66NBM6/FVnISrSt4fHa2vwzrxTKuz+jJ
         ZO+F9AJXYQxVEqMZXhLpKD0o4ZEoofvK/cIuCVzlNs4XGC7h5Yr1OmY/E3h1KCqSbpul
         g4JgWnZndG/gphB64M6BH+LlG2HPBB3P36VgggR5qmpYxf5ftZ0Mh760H92T8n89DdVC
         tP5g==
X-Gm-Message-State: ABy/qLbUIpjWAh61q5s95cpIEQcgN0J6mRNIOJIo069RoB74/H6wLsox
        8hTWlanG1feE/5piMhyMT3rT2dCA58oF/J0Y568=
X-Google-Smtp-Source: APBJJlHQZWdyDX+cuJcWzU4zzOtZAXTvX0zMkPY+ZyBRdv+6TV8SR7VOluZg8jnNjpBCibtg8sh2KTv1Lu6BivJkJco=
X-Received: by 2002:a1f:5e09:0:b0:461:98db:89a3 with SMTP id
 s9-20020a1f5e09000000b0046198db89a3mr3894740vkb.9.1689852876366; Thu, 20 Jul
 2023 04:34:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230713042037.980211-1-42.hyeyoo@gmail.com> <20230720071826.GE955071@google.com>
 <CAJD7tka2b-VsLJRrwfdbFAwvfKV+sHvNyRBJsG+81EmQ-=MkyA@mail.gmail.com>
In-Reply-To: <CAJD7tka2b-VsLJRrwfdbFAwvfKV+sHvNyRBJsG+81EmQ-=MkyA@mail.gmail.com>
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date:   Thu, 20 Jul 2023 20:34:25 +0900
Message-ID: <CAB=+i9QUNVbc+pEZD5vG_DUTcLrco5JNOrkkRDdcAfj08u7vVA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/21] mm/zsmalloc: Split zsdesc from struct page
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 4:55=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Thu, Jul 20, 2023 at 12:18=E2=80=AFAM Sergey Senozhatsky
> <senozhatsky@chromium.org> wrote:
> >
> > On (23/07/13 13:20), Hyeonggon Yoo wrote:
> > > The purpose of this series is to define own memory descriptor for zsm=
alloc,
> > > instead of re-using various fields of struct page. This is a part of =
the
> > > effort to reduce the size of struct page to unsigned long and enable
> > > dynamic allocation of memory descriptors.
> > >
> > > While [1] outlines this ultimate objective, the current use of struct=
 page
> > > is highly dependent on its definition, making it challenging to separ=
ately
> > > allocate memory descriptors.
> >
> > I glanced through the series and it all looks pretty straight forward t=
o
> > me. I'll have a closer look. And we definitely need Minchan to ACK it.
> >
> > > Therefore, this series introduces new descriptor for zsmalloc, called
> > > zsdesc. It overlays struct page for now, but will eventually be alloc=
ated
> > > independently in the future.
> >
> > So I don't expect zsmalloc memory usage increase. On one hand for each
> > physical page that zspage consists of we will allocate zsdesc (extra by=
tes),
> > but at the same time struct page gets slimmer. So we should be even, or
> > am I wrong?
>
> Well, it depends. Here is my understanding (which may be completely wrong=
):
>
> The end goal would be to have an 8-byte memdesc for each order-0 page,
> and then allocate a specialized struct per-folio according to the use
> case. In this case, we would have a memdesc and a zsdesc for each
> order-0 page. If sizeof(zsdesc) is 64 bytes (on 64-bit), then it's a
> net loss. The savings only start kicking in with higher order folios.
> As of now, zsmalloc only uses order-0 pages as far as I can tell, so
> the usage would increase if I understand correctly.

I partially agree with you that the point of memdesc stuff is
allocating a use-case specific
descriptor per folio. but I thought the primary gain from memdesc was
from anon and file pages
(where high order pages are more usable), rather than zsmalloc.

And I believe enabling a memory descriptor per folio would be
impossible (or inefficient)
if zsmalloc and other subsystems are using struct page in the current
way (or please tell me I'm wrong?)

So I expect the primary gain would be from high-order anon/file folios,
while this series is a prerequisite for them to work sanely.

> It seems to me though the sizeof(zsdesc) is actually 56 bytes (on
> 64-bit), so sizeof(zsdesc) + sizeof(memdesc) would be equal to the
> current size of struct page. If that's true, then there is no loss,

Yeah, zsdesc would be 56 bytes on 64 bit CPUs as memcg_data field is
not used in zsmalloc.
More fields in the current struct page might not be needed in the
future, although it's hard to say at the moment.
but it's not a loss.

> and there's potential gain if we start using higher order folios in
> zsmalloc in the future.

AFAICS zsmalloc should work even when the system memory is fragmented,
so we may implement fallback allocation (as currently discussed in
large anon folios thread).

It might work, but IMHO the purpose of this series is to enable memdesc
for large anon/file folios, rather than seeing a large gain in zsmalloc its=
elf.
(But even in zsmalloc, it's not a loss)

> (That is of course unless we want to maintain cache line alignment for
> the zsdescs, then we might end up using 64 bytes anyway).

we already don't require cache line alignment for struct page. the current
alignment requirement is due to SLUB's cmpxchg128 operation, not cache
line alignment.

I might be wrong in some aspects, so please tell me if I am.
And thank you and Sergey for taking a look at this!
--
Hyeonggon
