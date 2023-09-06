Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAD9793E91
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 16:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240849AbjIFORx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 10:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240669AbjIFORw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 10:17:52 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB5EE4C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 07:17:48 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-794d98181f0so155888839f.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 07:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694009868; x=1694614668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iu7OT2bcEXCIdHfig8w+3vXulx2YiGto+l76rBqKbA0=;
        b=5S/Sl04dGCLfXboHcglmDFFWfbQbw0biC9aISwBmPbJjEgH9hBwaOuPlaoxL09Fg5L
         +NEeMvYsyjTSLxxoOeofTJSOEYlkUsA7DDUvrgIyADJn/PFf/13li0qtH9RHmZ+G3VNH
         nGfwp2D1OXIdQuI+eAdoPx16De/UM3E2KNCgTVl2dSD2tO6CbwIOwCY9Ywj0Re0aE74D
         vuxY8AJy2X1WI9qKckGXobEh/6YaOAFGgRfnMDw+aRVfDH0jjXor2IPTe2kWlEwP0G1u
         UsvgXbca59aRgm61iO4iszCILGlF7sk5k+fyDOkUYVPq+VCug1BSfk58jg5HXZCMXc0l
         J69Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694009868; x=1694614668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iu7OT2bcEXCIdHfig8w+3vXulx2YiGto+l76rBqKbA0=;
        b=ktiUYgdVJDwXfbYDe2pBZKIibWasUJmhKUoSgsTSyjgQDQQCyf2FB312c9JhPIooRI
         rSFsoHfRmojgGLBjvEj8ATzEPZTWYSXnNlke+pPbgOEGpbZQor+yvgRKbU+hrq0WGJz/
         zFuOEa8TlK/wJzUjJ41zrYh8ucTGh85bAZeD2h+pOAbFVpYrQWOQF9fQd9zUZi+oXNk3
         axg8SsR5BTLhvuLHytJLOedgQg851ckM+0Uoghcshx6rd/RvONrUtArDF+j3rO26sHop
         XUjUNM985M2VpBRBax9gmj1/kGR9jtBQeG75tvOGdYTAjvW4lBI+jFwJx6VhI6AmbiPH
         GNyA==
X-Gm-Message-State: AOJu0Yy+lGogDkDhohdACa1cxmhG9Kam8dTp6pLIn4N7B/gWrzmHner2
        uQaifI3gqu6ufLVrC1GfqbEhP0wUpqZARW8H7UKRVehYq958EDbNETI=
X-Google-Smtp-Source: AGHT+IHQkboujHrOaSmdEGFmIRBPqspCZbW38QdHA2LAPUgocyuSTB4VDQ7FGTDlp2rZC7IOFjMfKv+zIM8qBv3LsDw=
X-Received: by 2002:a6b:4904:0:b0:787:4b5f:b6cf with SMTP id
 u4-20020a6b4904000000b007874b5fb6cfmr17444605iob.5.1694009868214; Wed, 06 Sep
 2023 07:17:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230831105252.1385911-1-zhaoyang.huang@unisoc.com>
 <ZPCEim0AZG5hTSYH@casper.infradead.org> <CAGWkznGAJVZtn49zNHsMAjRSfTRR707QXYY0m8Q+yABTsiig2Q@mail.gmail.com>
 <CAG_fn=VJrO3e9q0M6KA9nopqyDuRO4g7SBak6YptiEvzdE+nkA@mail.gmail.com>
 <ZPWNTiAxZZh/kzew@dhcp22.suse.cz> <CAHk-=wh2s26=Hj03cJXBWELmgCY=z5=mhTTDNVVKDAbda8g7Xw@mail.gmail.com>
 <20230904182234.GB30774@sol.localdomain>
In-Reply-To: <20230904182234.GB30774@sol.localdomain>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 6 Sep 2023 16:17:07 +0200
Message-ID: <CAG_fn=XnynfbY5pYQqJz7XAwz_fHJXmF5jNmVCrTAtgKBf1LzQ@mail.gmail.com>
Subject: Re: [PATCH] mm: make __GFP_SKIP_ZERO visible to skip zero operation
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Mateusz Guzik <mjguzik@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
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

On Mon, Sep 4, 2023 at 8:22=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> w=
rote:
>
> On Mon, Sep 04, 2023 at 10:34:25AM -0700, Linus Torvalds wrote:
> > On Mon, 4 Sept 2023 at 00:55, Michal Hocko <mhocko@suse.com> wrote:
> > >
> > >       Sooner or later this will become an
> > > unreviewable mess so the value of init_on_alloc will become very
> > > dubious.
> >
> > The value of init_on_alloc is *already* very dubious.
> >
> > Exactly because people will turn it off, because it hurts performance
> > so much - and in pointless ways.
> >
> > You do realize that distributions - well, at least Fedora - simply
> > don't turn INIT_ON_ALLOC_DEFAULT_ON on at all?
> >
> > So the current state of init_on_alloc is that nobody sane uses it. You
> > have to think you're special to enable it, because it is *so* bad.
> >
> > Security people need to realize that the primary point of computing is
> > NEVER EVER security. Security is entirely pointless without a usable
> > system.
> >
> > Unless security people realize that they are always secondary, they
> > aren't security people, they are just random wankers.
> >
> > And people who state this truism had better not get shamed for
> > standing up to stupidity.
> >
>
> Android and Ubuntu both set CONFIG_INIT_ON_ALLOC_DEFAULT_ON.  I think thi=
s makes
> it clear that the init-on-alloc feature is useful for a substantial amoun=
t of
> users even in its current form.
>
> I would caution against checking the kernel config for the distro you hap=
pen to
> be using and extrapolating that to all Linux systems.
>
> Regardless, I'm in favor of a per allocation opt-out flag like GFP_SKIP_Z=
ERO.
> There are clear cases where it makes sense, for example some places in th=
e VFS
> where the performance impact is large and the code has been carefully rev=
iewed.

What are our options to prevent this flag from spreading uncontrollably?
Would it make sense to still provide a separate API for such
allocations, so that the flag doesn't get added into some module-level
`gfp` variable?

>
> I don't really like the idea
> (https://lore.kernel.org/lkml/CAG_fn=3DUQEuvJ9WXou_sW3moHcVQZJ9NvJ5McNcsY=
E8xw_WEYGw@mail.gmail.com/)
> of making the system administrator have to opt out allocation sites indiv=
idually
> via a kernel command-line parameter.  Yes, it makes the opt out less like=
ly to
> be abused as two parties (developer and system administrator) have to con=
sent to
> each individual opt out.  So it theory it sounds good.  But I feel that d=
oesn't
> outweigh the fact that it would be complicated and hard to use.  How abou=
t just
> having two options: one to always honor GFP_SKIP_ZERO in the code and one=
 to
> always ignore it.

I am afraid we still need some level of granularity here.
E.g. we definitely want to skip initialization for kstrdup(),
kmemdup() and friends, some would say even on the systems running with
init_on_alloc=3D1.
For e.g. 3rd party driver allocations we also need an opt-out flag,
but the need for a kill switch to disable that flag is higher. On the
other hand, that kill switch does not have to disable the carefully
reviewed opt-outs in the upstream code.

Assuming that OS vendors usually control their kernel source, we can
probably distinguish between opting out the allocations done within
statically linked code and the modules, introducing the following
levels of initialization that could be controlled by init_on_alloc:
 - init_on_alloc=3D1 - initialize all allocations, like it's done currently
 - init_on_alloc=3Dexcept_static_optouts - initialize all allocations,
allow GFP_SKIP_ZERO in the statically linked code
 - init_on_alloc=3Dexcept_optouts - initialize all allocations, allow
GFP_SKIP_ZERO in the kernel and the modules
 - init_on_alloc=3D0 - do not initialize allocations by default

In this scheme, the system administrator may choose to either be
paranoid, or choose to trust just their OS vendor, or trust the driver
vendors as well.
In any case, it will be possible to dynamically pull the plug on the opt-ou=
ts.

>
> - Eric




--
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
