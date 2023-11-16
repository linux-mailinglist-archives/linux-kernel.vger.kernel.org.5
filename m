Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B307EEA13
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 00:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345591AbjKPXrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 18:47:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKPXrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 18:47:16 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C57E8E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 15:47:13 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id ada2fe7eead31-45ef8c21e8aso534041137.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 15:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700178432; x=1700783232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=itBzxpYVA8AZkGZhdmPLdRxYtlcOmy3dzDpekhNS5LI=;
        b=mKlY/IYFpC2HAImpd3oEARkcBHrZt0lewrD9+fJXhr4gJXRF95K+1JBlPmT1t5yHo8
         AgY9K1tInguhup/pJOLxW2PuFTljDnCv51B0ig+SmOsjvyj7OhJbQejSlmjo+Bjch4gW
         4NkgldZQOkF/P0918NyE8yx9D6LTQjf+bA0GYE6ZR4iRSpIuFNHfrWwmdvDcvDi9qFut
         f5UuyRnwuS+vDXGrUuKhqqZRsztPp6Q/4TYhdgv/RNfI+JWSI8pt3mL+Vw8D3CanswTz
         6e/wujlVKLRXLprA5k0vUTR3FDG8xRiWi2v6fwNlSlRdPcq7OdV+vPUPQBM2ozRUmnPA
         Rx1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700178432; x=1700783232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=itBzxpYVA8AZkGZhdmPLdRxYtlcOmy3dzDpekhNS5LI=;
        b=slEYXIbdgaArm3UC+x+hqhRHnp45XncsGT+cw6qVUJNC0Prh/hfcsIPJFjGVxftG95
         WN7zySLnqSPhCeVvFKmcck+yVXdV3eAm9Oz50xG18acL8O8bVWhu0yUTRyR+462i2l3w
         9re8NyMVea3/udIu/zNkJm9OzGERw2Unu9KZtq7Lc/m4jeRd9/qjlA4jPfxFpKzPsP+o
         GhxTVK8UGzhvp/fcm1+x01dUxlbEyqJhfrs6rXyn2jLdtcXZBbQ7ryd3XYIkii8rOo1B
         XN+Hw6aTOOlp4/ouJNWYiFt+IL7xI8A3g8jCRkLUfK//VxMXHc00ftLnH5t6UOjvrb/B
         qVQg==
X-Gm-Message-State: AOJu0YzOT7JXcT9WAni9Bscu7DsYAZWlEmJI9vxDn5KiuCR6b7+tKo84
        KnrDfW2fSsHLewLcBcSA/WcPNqlJp8Z1Km5r/e4=
X-Google-Smtp-Source: AGHT+IH4KzQlnV3KvIJLri3KzLbsD+wnGhElBTYIjI0H+UbcOHbLmLEsOmVwV/RMDeahhKGcMtMu/YvxL0TOzf6PqOY=
X-Received: by 2002:a05:6102:5f09:b0:45e:fde1:b273 with SMTP id
 ik9-20020a0561025f0900b0045efde1b273mr18038965vsb.29.1700178432072; Thu, 16
 Nov 2023 15:47:12 -0800 (PST)
MIME-Version: 1.0
References: <20231114014313.67232-1-v-songbaohua@oppo.com> <d8fd421e-00f3-453e-9665-df3fdcc239eb@redhat.com>
 <CAGsJ_4wD9Ug=CLi6Cdw3Ve5q8-1u7MmipLtEGQTfWmU9BJFJOQ@mail.gmail.com> <864489b3-5d85-4145-b5bb-5d8a74b9b92d@redhat.com>
In-Reply-To: <864489b3-5d85-4145-b5bb-5d8a74b9b92d@redhat.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Fri, 17 Nov 2023 07:47:00 +0800
Message-ID: <CAGsJ_4wsWzhosZJWegOb8ggoON3KdiH1mO-8mFZd7kWcn6diuw@mail.gmail.com>
Subject: Re: [RFC V3 PATCH] arm64: mm: swap: save and restore mte tags for
 large folios
To:     David Hildenbrand <david@redhat.com>
Cc:     steven.price@arm.com, akpm@linux-foundation.org,
        ryan.roberts@arm.com, catalin.marinas@arm.com, will@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
        shy828301@gmail.com, v-songbaohua@oppo.com,
        wangkefeng.wang@huawei.com, willy@infradead.org, xiang@kernel.org,
        ying.huang@intel.com, yuzhao@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 5:36=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 15.11.23 21:49, Barry Song wrote:
> > On Wed, Nov 15, 2023 at 11:16=E2=80=AFPM David Hildenbrand <david@redha=
t.com> wrote:
> >>
> >> On 14.11.23 02:43, Barry Song wrote:
> >>> This patch makes MTE tags saving and restoring support large folios,
> >>> then we don't need to split them into base pages for swapping out
> >>> on ARM64 SoCs with MTE.
> >>>
> >>> arch_prepare_to_swap() should take folio rather than page as paramete=
r
> >>> because we support THP swap-out as a whole.
> >>>
> >>> Meanwhile, arch_swap_restore() should use page parameter rather than
> >>> folio as swap-in always works at the granularity of base pages right
> >>> now.
> >>
> >> ... but then we always have order-0 folios and can pass a folio, or wh=
at
> >> am I missing?
> >
> > Hi David,
> > you missed the discussion here:
> >
> > https://lore.kernel.org/lkml/CAGsJ_4yXjex8txgEGt7+WMKp4uDQTn-fR06ijv4Ac=
68MkhjMDw@mail.gmail.com/
> > https://lore.kernel.org/lkml/CAGsJ_4xmBAcApyK8NgVQeX_Znp5e8D4fbbhGguOkN=
zmh1Veocg@mail.gmail.com/
>
> Okay, so you want to handle the refault-from-swapcache case where you get=
 a
> large folio.
>
> I was mislead by your "folio as swap-in always works at the granularity o=
f
> base pages right now" comment.
>
> What you actually wanted to say is "While we always swap in small folios,=
 we
> might refault large folios from the swapcache, and we only want to restor=
e
> the tags for the page of the large folio we are faulting on."
>
> But, I do if we can't simply restore the tags for the whole thing at once
> at make the interface page-free?
>
> Let me elaborate:
>
> IIRC, if we have a large folio in the swapcache, the swap entries/offset =
are
> contiguous. If you know you are faulting on page[1] of the folio with a
> given swap offset, you can calculate the swap offset for page[0] simply b=
y
> subtracting from the offset.
>
> See page_swap_entry() on how we perform this calculation.
>
>
> So you can simply pass the large folio and the swap entry corresponding
> to the first page of the large folio, and restore all tags at once.
>
> So the interface would be
>
> arch_prepare_to_swap(struct folio *folio);
> void arch_swap_restore(struct page *folio, swp_entry_t start_entry);
>
> I'm sorry if that was also already discussed.

This has been discussed. Steven, Ryan and I all don't think this is a good
option. in case we have a large folio with 16 basepages, as do_swap_page
can only map one base page for each page fault, that means we have
to restore 16(tags we restore in each page fault) * 16(the times of page fa=
ults)
for this large folio.

and still the worst thing is the page fault in the Nth PTE of large folio
might free swap entry as that swap has been in.
do_swap_page()
{
   /*
    * Remove the swap entry and conditionally try to free up the swapcache.
    * We're already holding a reference on the page but haven't mapped it
    * yet.
    */
    swap_free(entry);
}

So in the page faults other than N, I mean 0~N-1 and N+1 to 15, you might a=
ccess
a freed tag.

>
> BUT, IIRC in the context of
>
> commit cfeed8ffe55b37fa10286aaaa1369da00cb88440
> Author: David Hildenbrand <david@redhat.com>
> Date:   Mon Aug 21 18:08:46 2023 +0200
>
>      mm/swap: stop using page->private on tail pages for THP_SWAP
>
>      Patch series "mm/swap: stop using page->private on tail pages for TH=
P_SWAP
>      + cleanups".
>
>      This series stops using page->private on tail pages for THP_SWAP, re=
places
>      folio->private by folio->swap for swapcache folios, and starts using
>      "new_folio" for tail pages that we are splitting to remove the usage=
 of
>      page->private for swapcache handling completely.
>
> As long as the folio is in the swapcache, we even do have the proper
> swp_entry_t start_entry available as folio_swap_entry(folio).
>
> But now I am confused when we actually would have to pass
> "swp_entry_t start_entry". We shouldn't if the folio is in the swapcache =
...
>

Nop, hitting swapcache doesn't necessarily mean tags have been restored.
when A forks B,C,D,E,F. and A, B, C, D, E ,F share the swapslot.
as we have two chances to hit swapcache:
1. swap out, unmap has been done but folios haven't been dropped
2. swap in, shared processes allocate folios and add to swapcache

for 2, If A gets fault earlier than B, A will allocate folio and add
it to swapcache.
Then B will hit the swapcache. But If B's CPU is faster than A, B still mig=
ht
be the one mapping PTE earlier than A though A is the one which has
added the page to swapcache. we have to make sure MTE is there when
mapping is done.

> --
> Cheers,
>
> David / dhildenb
>

Thanks
Barry
