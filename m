Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11A3783608
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 00:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbjHUW7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 18:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjHUW7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 18:59:30 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F613130
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 15:59:26 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso2767505a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 15:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692658765; x=1693263565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+LmedZxDfFGgAEEh0N7SyrX0MHcYG3rwrJniXF4d67g=;
        b=eAssCcwvnR59Mdn/XnFl+9hml/3sYg1/nXIMKd5HvTDTQT2HgLEXDS8EfzdwKmDDkM
         93SdAsxCVbQGDP8MDryGRQym73gIkLi3phZjnhYlDuN78xxdIktZGm6eaiVQ98AYLmVP
         C2UWBhaTl6cMt0V0ysuNaFL9CLHqsqmsAwSkb6Zn56viJE+q+MXDDmy74Y4pvK/c6vih
         omz3rqM9jp5LdGcKbx7PeFPC3ECewo6bP5YsGd9wh6Z6n9RwK39MIQrCc9rAU2xZDyZU
         7Nh4f2mzLoEygimbRZIGPmAsiWcWXV2eb5y78NFH4PZkbFIEbvanqqZKBXvK7rQ9arN3
         PadA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692658765; x=1693263565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+LmedZxDfFGgAEEh0N7SyrX0MHcYG3rwrJniXF4d67g=;
        b=iBV7ldZyQQhZTeW2vYzGxXMNciZM9DyrbvX9Mk8X9lBbUnFDEotsewpT+EloPjo/3z
         N4xqXNlcZLjSVCHZbNlh6aUp/okXOHezJGp2C7dJW121VJPjQ7plrM5IJdin7nbYJxP2
         ZmI+P20hOCi0vSThmz7WusivBvY/jsz0dKN2jRYgbeu6pd9ZmpldHftPHfnUFHYb4MlB
         pxMMFv2nA5+f0D5WoYJFLGY7XpGOk9HFGeW+/DAawIueYHvlvs7TVv/hpS/P3l+D/0cU
         e4gxbkqtOzr4Py4TQEavBexjzzPycy5Wbkgt25uM/pJkQY9cXV2hngI3lso2BPpXc16a
         XN4A==
X-Gm-Message-State: AOJu0Yz6LW4dlZKzonOoSiJeLWMi42tPqUtH3yuCZF1cCf+w+l68bunP
        u9OaEHpUyDpCUqakGy39YD4cjXwXUemGZ5MFpPQ=
X-Google-Smtp-Source: AGHT+IHVwUnwQEF4T0pfm18ovL3KnLP73yi7xxCws64T6jqYm+O3bm+xt3N/R3/tjhZb8ISX+EDqX+l4Bpv3LipsS2E=
X-Received: by 2002:a17:90a:6941:b0:25b:c454:a366 with SMTP id
 j1-20020a17090a694100b0025bc454a366mr7506521pjm.5.1692658765445; Mon, 21 Aug
 2023 15:59:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230812210053.2325091-1-zokeefe@google.com> <PUZP153MB06358FF02518EF3B279F5DD4BE16A@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
 <CAAa6QmSrwe2m4MjS9mGO+DeGNGSv=B2uZ72EAxnZk2jsDh39rQ@mail.gmail.com>
 <ZNp7JDaPhT3Se4de@casper.infradead.org> <CAAa6QmSN4NhaDL0DQsRd-F8HTnCCjq1ULRNk88LAA9gVbDXE4g@mail.gmail.com>
 <ZNrh6w9ICu4rMrhV@casper.infradead.org> <PUZP153MB063529C4869A7A666C275B23BE15A@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
 <CAAa6QmRrnRHEEQMMYe20GLXj7g+LVVHVRAKUdSLy=jUW=khb2A@mail.gmail.com>
 <CAHbLzko_xLiqkNgjA7DhVFBSW6qJdAwgfk557YKV+ZpwS2x16w@mail.gmail.com>
 <CAAa6QmSxab2-m-RopQtZnBpxTLX25K=KZE+EPmA+wWb_yTqf0Q@mail.gmail.com>
 <CAHbLzko1J9ds_JfZe83JwEx=395sPExB7mQ0faju6OSaQ2tmnQ@mail.gmail.com> <CAAa6QmRLkh-g4ge4D9nQge=wHFwTz8CKB7AsjcJ9akDV8d0Z_A@mail.gmail.com>
In-Reply-To: <CAAa6QmRLkh-g4ge4D9nQge=wHFwTz8CKB7AsjcJ9akDV8d0Z_A@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 21 Aug 2023 15:59:13 -0700
Message-ID: <CAHbLzkp6BW5sHiG5aFkOz0yq-5ZvbE0AhFYN4YEN4Mkx0koZeQ@mail.gmail.com>
Subject: Re: [EXTERNAL] [PATCH] mm/thp: fix "mm: thp: kill __transhuge_page_enabled()"
To:     "Zach O'Keefe" <zokeefe@google.com>
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 8:09=E2=80=AFAM Zach O'Keefe <zokeefe@google.com> w=
rote:
>
> On Fri, Aug 18, 2023 at 2:21=E2=80=AFPM Yang Shi <shy828301@gmail.com> wr=
ote:
> >
> > On Thu, Aug 17, 2023 at 11:29=E2=80=AFAM Zach O'Keefe <zokeefe@google.c=
om> wrote:
> > >
> > > On Thu, Aug 17, 2023 at 10:47=E2=80=AFAM Yang Shi <shy828301@gmail.co=
m> wrote:
> > > >
> > > > On Wed, Aug 16, 2023 at 2:48=E2=80=AFPM Zach O'Keefe <zokeefe@googl=
e.com> wrote:
> > > > >
> > > > > > We have a out of tree driver that maps huge pages through a fil=
e handle and
> > > > > > relies on -> huge_fault. It used to work in 5.19 kernels but 6.=
1 changed this
> > > > > > behaviour.
> > > > > >
> > > > > > I don=E2=80=99t think reverting the earlier behaviour of fault_=
path for huge pages should
> > > > > > impact kernel negatively.
> > > > > >
> > > > > > Do you think we can restore this earlier behaviour of kernel to=
 allow page fault
> > > > > > for huge pages via ->huge_fault.
> > > > >
> > > > > That seems reasonable to me. I think using the existence of a
> > > > > ->huge_fault() handler as a predicate to return "true" makes sens=
e to
> > > > > me. The "normal" flow for file-backed memory along fault path sti=
ll
> > > > > needs to return "false", so that we correctly fallback to ->fault=
()
> > > > > handler. Unless there are objections, I can do that in a v2.
> > > >
> > > > Sorry for chiming in late. I'm just back from vacation and trying t=
o catch up...
> > > >
> > > > IIUC the out-of-tree driver tries to allocate huge page and install
> > > > PMD mapping via huge_fault() handler, but the cleanup of
> > > > hugepage_vma_check() prevents this due to the check to
> > > > VM_NO_KHUGEPAGED?
> > > >
> > > > So you would like to check whether a huge_fault() handler existed
> > > > instead of vma_is_dax()?
> > >
> > > Sorry for the multiple threads here. There are two problems: (a) the
> > > VM_NO_KHUGEPAGED check along fault path, and (b) we don't give
> > > ->huge_fault() a fair shake, if it exists, along fault path. The
> > > current code assumes vma_is_dax() iff ->huge_fault() exists.
> > >
> > > (a) is easy enough to fix. For (b), I'm currently looking at the
> > > possibility of not worrying about ->huge_fault() in
> > > hugepage_vma_check(), and just letting create_huge_pud() /
> > > create_huge_pmd() check and fallback as necessary. I think we'll need
> > > the explicit DAX check still, since we want to keep khugepaged and
> > > MADV_COLLAPSE away, and the presence / absence of ->huge_fault() isn'=
t
> > > enough to know that (well.. today it kind of is, but we shouldn't
> > > depend on it).
> >
> > You meant something like:
> >
> > if (vma->vm_ops->huge_fault) {
> >     if (vma_is_dax(vma))
> >         return in_pf;
> >
> >     /Fall through */
> > }
>
> I don't think this will work for Saurabh's case, since IIUC, they
> aren't using dax, but are using VM_HUGEPAGE|VM_MIXEDMAP, faulted in
> using ->huge_fault()
>
> The old (v5.19) fault path looked like:
>
> static inline bool transhuge_vma_enabled(struct vm_area_struct *vma,
>                                           unsigned long vm_flags)
> {
>         /* Explicitly disabled through madvise. */
>         if ((vm_flags & VM_NOHUGEPAGE) ||
>             test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
>                 return false;
>         return true;
> }
>
> /*
>  * to be used on vmas which are known to support THP.
>  * Use transparent_hugepage_active otherwise
>  */
> static inline bool __transparent_hugepage_enabled(struct vm_area_struct *=
vma)
> {
>
>         /*
>          * If the hardware/firmware marked hugepage support disabled.
>          */
>         if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_NEVER=
_DAX))
>                 return false;
>
>         if (!transhuge_vma_enabled(vma, vma->vm_flags))
>                 return false;
>
>         if (vma_is_temporary_stack(vma))
>                 return false;
>
>         if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_FLAG)=
)
>                 return true;
>
>         if (vma_is_dax(vma))
>                 return true;
>
>         if (transparent_hugepage_flags &
>                                 (1 << TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG)=
)
>                 return !!(vma->vm_flags & VM_HUGEPAGE);
>
>         return false;
> }
>
> For non-anonymous, the next check (in create_huge_*) would be for that
> ->huge_fault handler, falling back as necessary if it didn't exist.

Yeah, you are right. I just replied to your v2 patch.

>
> The patch I sent out last week[1] somewhat restores this logic -- the
> only difference being we do the check for ->huge_fault in
> hugepage_vma_check() as well. This is so smaps can surface this
> possibility with some accuracy. I just realized it will erroneously
> return "true" for the collapse path, however..
>
> Maybe Matthew was right about unifying everything here :P That's 2
> mistakes I've made in trying to fix this issue (but maybe that's just
> me).

IMHO, no rush on fixing it.

>
> [1] https://lore.kernel.org/linux-mm/20230818211533.2523697-1-zokeefe@goo=
gle.com/
