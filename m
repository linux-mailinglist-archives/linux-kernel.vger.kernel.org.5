Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24DF37B6BD0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 16:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240141AbjJCOhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240044AbjJCOhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:37:08 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8EBB9E
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 07:37:01 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-2792d70ae25so681617a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 07:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696343821; x=1696948621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QwnD3WaCB3QuXIpXLWOOv1IEIdb1g/OoCibdXrPuBk8=;
        b=dNva37YW8U4foWo+vopooRL70icAkZ89oEvjSsKMikmb+qW/0i5TIMx8lm/JO8PW1B
         FNc92oPyOGdCIq8rjT0txV0MfFkG/NDyrnWL4h0NLgAvJ+p4hvQ7DfXDkMEOLYpzAsdg
         LG7pL3IGRUKRmGOEwnijg7TNgO/Lph5o7G1UdBrh/ORg5bapzqzrMEgh/5aa8ZIpugOm
         cRhs/U+cEuHw9L4YGhurWwdHgYykz7sqHWfLZv4azHgJ1+SUEdPSLnq3kJEz6xIMYA7K
         k/1ly+YEAQ0s2/xhh0Cbf8tYAGO7TZmmS2SZJL/XqMX796Pn0qSvDqqEzC3uUILR9sYv
         7QWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696343821; x=1696948621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QwnD3WaCB3QuXIpXLWOOv1IEIdb1g/OoCibdXrPuBk8=;
        b=VhpHiAxR2tTrswDzYqo4OvYMhPIEinKgJmPNc/ziVSJbqHsRX0/7XGffeGut+VA/N6
         wZ2pIQe82cvAGX1LL/w0bFlab9k5ZVbKfYImm4GGuSG7zxwOxP0UiL6KeMP/XOSQ3JWr
         RllgLYrgnqUlHbVPSDUBBZ9TKd49OEYrrLHNAhOjjAWrg7TAM7SsW8obzUBrf3otQH1w
         mkM32inatVE8N0xz6fC/FVYSQHk4NwT3mw1F9jNkYBg2Rgz5RnEAAJmAV6FWTBs+tenN
         FtQPD2A29SWtl2AZwMJ7UsqQ45G83bGHpSKDOSp3SNDdILyoGf9eyZHJ6+SjbkXBsjs6
         RY4w==
X-Gm-Message-State: AOJu0YwxXAJygGcCk8oLDUxZByytzJGECDByV8Pa0O8zsteXOVKy/KGQ
        a4FGEZS9ozp51RsT9LA+xeR5g0csKV2YlAXv6s7OSA==
X-Google-Smtp-Source: AGHT+IGiDfRi3zRUWIaM35PLLvi2ytA0RVCDjq/ooBLCufAar5Q4KtbXSga6DuCy8BSbgHGhQqkWi2J/5SUbCQWB0aE=
X-Received: by 2002:a17:90a:ce92:b0:26d:4ab3:fe11 with SMTP id
 g18-20020a17090ace9200b0026d4ab3fe11mr10925628pju.24.1696343821063; Tue, 03
 Oct 2023 07:37:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230929-hib_zero_bitmap_fix-v1-1-6cfdcb785250@quicinc.com>
 <CADyq12znHG_VPLVxSe+2ofX-WR1Uha2hu1MhoUAquMnoD_oP0w@mail.gmail.com>
 <CADyq12x1wZb0Yt3sXR21pQSagT7tGvFmXTBaoeNXkOjPi5-Rnw@mail.gmail.com> <e75a57a9-c9df-4dd5-a109-9ae8c49fb3ae@quicinc.com>
In-Reply-To: <e75a57a9-c9df-4dd5-a109-9ae8c49fb3ae@quicinc.com>
From:   Brian Geffon <bgeffon@google.com>
Date:   Tue, 3 Oct 2023 10:36:25 -0400
Message-ID: <CADyq12wmda6B1pJvOVhM4=VLwun9n4ef232td70-uGz435SSvg@mail.gmail.com>
Subject: Re: [PATCH] PM: hibernate: Fix a bug in copying the zero bitmap to
 safe pages
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        kernel@quicinc.com,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 2, 2023 at 11:05=E2=80=AFPM Pavan Kondeti <quic_pkondeti@quicin=
c.com> wrote:
>
> On Mon, Oct 02, 2023 at 02:34:20PM -0400, Brian Geffon wrote:
> > On Mon, Oct 2, 2023 at 1:56=E2=80=AFPM Brian Geffon <bgeffon@google.com=
> wrote:
> > >
> > > On Fri, Sep 29, 2023 at 1:31=E2=80=AFPM Pavankumar Kondeti
> > > <quic_pkondeti@quicinc.com> wrote:
> > > >
> > > > The following crash is observed 100% of the time during resume from
> > > > the hibernation on a x86 QEMU system.
> > > >
> > > > [   12.931887]  ? __die_body+0x1a/0x60
> > > > [   12.932324]  ? page_fault_oops+0x156/0x420
> > > > [   12.932824]  ? search_exception_tables+0x37/0x50
> > > > [   12.933389]  ? fixup_exception+0x21/0x300
> > > > [   12.933889]  ? exc_page_fault+0x69/0x150
> > > > [   12.934371]  ? asm_exc_page_fault+0x26/0x30
> > > > [   12.934869]  ? get_buffer.constprop.0+0xac/0x100
> > > > [   12.935428]  snapshot_write_next+0x7c/0x9f0
> > > > [   12.935929]  ? submit_bio_noacct_nocheck+0x2c2/0x370
> > > > [   12.936530]  ? submit_bio_noacct+0x44/0x2c0
> > > > [   12.937035]  ? hib_submit_io+0xa5/0x110
> > > > [   12.937501]  load_image+0x83/0x1a0
> > > > [   12.937919]  swsusp_read+0x17f/0x1d0
> > > > [   12.938355]  ? create_basic_memory_bitmaps+0x1b7/0x240
> > > > [   12.938967]  load_image_and_restore+0x45/0xc0
> > > > [   12.939494]  software_resume+0x13c/0x180
> > > > [   12.939994]  resume_store+0xa3/0x1d0
> > > >
> > > > The commit being fixed introduced a bug in copying the zero bitmap
> > > > to safe pages. A temporary bitmap is allocated in prepare_image()
> > > > to make a copy of zero bitmap after the unsafe pages are marked.
> > > > Freeing this temporary bitmap later results in an inconsistent stat=
e
> > > > of unsafe pages. Since free bit is left as is for this temporary bi=
tmap
> > > > after free, these pages are treated as unsafe pages when they are
> > > > allocated again. This results in incorrect calculation of the numbe=
r
> > > > of pages pre-allocated for the image.
> > > >
> > > > nr_pages =3D (nr_zero_pages + nr_copy_pages) - nr_highmem - allocat=
ed_unsafe_pages;
> > > >
> > > > The allocate_unsafe_pages is estimated to be higher than the actual
> > > > which results in running short of pages in safe_pages_list. Hence t=
he
> > > > crash is observed in get_buffer() due to NULL pointer access of
> > > > safe_pages_list.
> > >
> > > After reading through the code, perhaps I'm missing something, I'm no=
t
> > > sure that this is really fixing the problem.
> > >
> > > It seems like the problem would be that memory_bm_create() results in
> > > calls to get_image_page() w/ safe_needed =3D PG_ANY =3D=3D 0, meaning=
 that
> > > get_image_page() will not touch allocated_unsafe_pages and instead
> > > will mark the page as in use by setting it in the forbidden_pages_map
> > > and the free_pages_map simultaneously. The problem is that the
> > > free_pages_map was already populated by the call to mark_unsafe_pages=
,
> > > meaning that if we allocated a safe page in get_image_page() we just
> > > set the free bit when it otherwise should not be set.
> > >
> > > When the page is later free'd via the call to memory_bm_free(&tmp,
> > > PG_UNSAFE_KEEP), it results in calls to free_image_page() w/
> > > clear_page_nosave =3D PG_UNSAFE_KEEP =3D=3D 0. This means that we do =
not
> > > touch the free_pages_map because we don't call
> > > swsusp_unset_page_free().
> > >
> > > With all that being said it seems like the correct way to deal with
> > > that would be to do:
> > >    error =3D memory_bm_create(&tmp, GFP_ATOMIC, PG_SAFE);
> > > Here we know that the pages were not in the free_pages_map initially.
> > >
> > > Followed by freeing it as:
> > >     memory_bm_free(&tmp, PG_UNSAFE_CLEAR);
> > > And here we know that swsusp_unset_page_free() will be called making
> > > sure the page is not in the free_pages_map afterwards.
> > >
> > > And that should result in an unchanged free_pages_map. Does that make
> > > sense? Please correct me if I'm misunderstanding something.
> > >
>
> Thanks for your review. Appreciate the detailed summary.
>
> >
> > To restate this another way, if I'm reading it correctly, I think the
> > outcome is actually nearly the same, the difference is, when
> > allocating the bitmap before w/ PG_ANY we're setting bits in the
> > free_page_list which will be unset a few lines later in the call to
> > mark_unsafe_pages(), and then we won't touch the free_pages_list
> > during the memory_bm_free() because it's called with PG_UNSAFE_KEEP.
> >
>
> The current patch and your suggestion both gives the same effect like
> you said. Since it is a temporary buffer to hold the zero bit map page, I
> did not allocate safe pages. Allocating safe pages means a bit more
> work. In this case this it is not completely throw away work but
> re-ordering the call seems to be simple here. Pls let me know if you
> want to me incorporate your suggestion.

My personal opinion is that PG_SAFE makes a bit more sense, it's not
really wasted work as any pages which are not safe end up being added
to the allocated_unsafe_pages pool.

>
> Thanks,
> Pavan
