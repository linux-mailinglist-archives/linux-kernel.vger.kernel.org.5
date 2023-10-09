Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F63E7BE6AD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 18:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377681AbjJIQiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 12:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377292AbjJIQip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 12:38:45 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB7E92
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 09:38:41 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d9191f0d94cso4863465276.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 09:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696869520; x=1697474320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPRLnB9E2KfYaMl2sp5JLUKvJ7e5aml1QARCewdKbIk=;
        b=v5XCJCq3ay94BF9jo3BBL8AifWD+rKVGUIFjE7/fzaKmB0cHQhHrGlTwE5uII7ZQ+I
         XtWb6cMr/hpJEw14GDcFLumg+u375c2pAxjDQuMXi2ndqCfujLBI2J12NUr7+pETImsK
         NTzVXalNeiRV/mIMgWB3sXqEzdHl0XayRAQJhQD8NCnxtx2VlqtNXJWEeDCeWGP9AE+N
         iLxRHEgnQgxwXGdnLXFontFJ+rodQcNvMqkkG6izfnfl56/hivRH8remmTDjzPc2R7tx
         HRIGMBEe8U07Wnqdn94+8HkP2FTjsEml/f1/1Z1sT5m8zia9YMBLSL0hEFtaXwSeKlwJ
         WYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696869520; x=1697474320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qPRLnB9E2KfYaMl2sp5JLUKvJ7e5aml1QARCewdKbIk=;
        b=HMks/e0WfL4877NVy+k+/UuJ5hl39Ns/JqAkI9XC07QYvXoQuh0YvSi2bofr7huTOs
         FByHL+b/AgAQhlmX2GW5te+Z6Pj8H1gTlJmoAe79wtcDB4w1KUQVw8wV2vbHtBc81619
         oERUNLe8T1Ay0flced5TvLOL1qbWaBXJbOGPQiP8Ol865Dq7Z+6QvOllSj+R+2kXhtVW
         0u7g/c7D3EVycWrtkF6oYTtJ4F16goftSIQnfaRbfUwepFSMpJ6oz9ZhCBkh91Jj6woA
         tLb9BQvQqWtbazYYjFCazAoEJG2t1HpVXZmd0AVEXao0OMeugUNYJ9Emu7hXvRF4Kitt
         ivNQ==
X-Gm-Message-State: AOJu0YwoyCqZWoKC1thlY6LcQQmEZMkHYRrIa1l91K5qz4xlk+hWt8bw
        WfKFMzlNSzgCx6fLzhrh86hmTentutA2EBRYGm8Bnw==
X-Google-Smtp-Source: AGHT+IGuhvBy0ei52T7glUHeYwnR/RqI5BuSWk8hPjOM0lhhVoLeMLSZZoXWzvke1rhQOdwpyELj0u2mLAd1UO6ZgEc=
X-Received: by 2002:a25:fb03:0:b0:d7f:1bd7:c83c with SMTP id
 j3-20020a25fb03000000b00d7f1bd7c83cmr13836426ybe.13.1696869520268; Mon, 09
 Oct 2023 09:38:40 -0700 (PDT)
MIME-Version: 1.0
References: <20231002142949.235104-1-david@redhat.com> <20231002142949.235104-4-david@redhat.com>
 <CAJuCfpHKPDzy0Z4a_rm8K=xnNBD9T+Y-cXCBYmQDG+3xinzuOQ@mail.gmail.com> <4bf9f174-2d0e-554a-c01f-7188ccde0f3f@redhat.com>
In-Reply-To: <4bf9f174-2d0e-554a-c01f-7188ccde0f3f@redhat.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 9 Oct 2023 09:38:29 -0700
Message-ID: <CAJuCfpFB=gCuFfMxyiOsxJ2-=rqSPSbj3-0DZK3awHJ9TpajtA@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] memory: move exclusivity detection in do_wp_page()
 into wp_can_reuse_anon_folio()
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 9, 2023 at 3:03=E2=80=AFAM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 03.10.23 19:05, Suren Baghdasaryan wrote:
> > On Mon, Oct 2, 2023 at 7:29=E2=80=AFAM David Hildenbrand <david@redhat.=
com> wrote:
> >>
> >> Let's clean up do_wp_page() a bit, removing two labels and making it
> >> a easier to read.
> >>
> >> wp_can_reuse_anon_folio() now only operates on the whole folio. Move t=
he
> >> SetPageAnonExclusive() out into do_wp_page(). No need to do this under
> >> page lock -- the page table lock is sufficient.
> >>
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> >> ---
> >>   mm/memory.c | 88 +++++++++++++++++++++++++++------------------------=
--
> >>   1 file changed, 45 insertions(+), 43 deletions(-)
> >>
> >> diff --git a/mm/memory.c b/mm/memory.c
> >> index 1f0e3317cbdd..512f6f05620e 100644
> >> --- a/mm/memory.c
> >> +++ b/mm/memory.c
> >> @@ -3358,6 +3358,44 @@ static vm_fault_t wp_page_shared(struct vm_faul=
t *vmf, struct folio *folio)
> >>          return ret;
> >>   }
> >>
>
> Sorry for the late response.
>
> >> +static bool wp_can_reuse_anon_folio(struct folio *folio,
> >> +                                   struct vm_area_struct *vma)
> >
> > Since this function is calling folio_move_anon_rmap(), I would suggest
> > changing its name to wp_reuse_anon_folio(). This would clarify that
>
> folio_move_anon_rmap() is *not* the reuse part, it's just an rmap
> optimization. You could remove the call here and the whole thing would
> still work :) In fact, we can call folio_move_anon_rmap() whenever we
> sure the folio belongs to a single VMA only and we're holding the page
> lock. ... but we cannot always reuse a folio in that case because there
> might be GUP references from another process.
>
> Reuse is
> * Setting PageAnonExclusive
> * Write fault: wunprotect the page -> wp_page_reuse()

Ok, fair enough. It's not the reuse, only a preparation step. My
concern is that wp_can_reuse_anon_folio() with a bool being returned
looks like a function that only checks for a possibility of an
operation while it's doing more than that. However I don't have a
really good suggestion to improve the naming, so treat it as a nitpick
and feel free to ignore.

>
> I went a bit back and forth while cleaning that function up, but calling
> it wp_reuse_anon_folio() would end up being confusing with
> wp_page_reuse() called afterwards [we should probably rename that one to
> wp_page_wunprotect() independently]. So I prefer to leave the actual
> (sub)page reuse part in the caller.
>
> > it's actually doing that operation instead of just checking if it's
> > possible. That would also let us keep unconditional
> > SetPageAnonExclusive() in it and do that under folio lock like it used
> > to do (keeping rules simple). Other than that, it looks good to me.
>
> I really want to avoid passing a "struct page" to that function; once
> we're dealing with PTE-mapped THP, the page might actually be a tail
> page of the folio.

Oh, I didn't realize that vmf->page and folio->page might differ in
here. Ok, sounds reasonable.
Thanks,
Suren.

>
> Thanks!
>
> --
> Cheers,
>
> David / dhildenb
>
