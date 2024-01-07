Return-Path: <linux-kernel+bounces-18845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF02B8263E9
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 12:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99875281F4C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 11:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D509212E57;
	Sun,  7 Jan 2024 11:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IebSmCvk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1777612B7E;
	Sun,  7 Jan 2024 11:34:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A449C433C8;
	Sun,  7 Jan 2024 11:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704627292;
	bh=q+FK+IJr5w3UyyWePtRhsxuIy+nIapv8qhRzmHldqTw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IebSmCvkoR9DivsuJc3+dTwekvt9rQ1tVb3njTCfmbsYrrOa6KMTBaVbFi65PFNOA
	 jTTD3MWo8Ogjmm9D3gr7RYLwBT6q6YchCX3darK2roEl9zwT5pPJOP2rrCc3g9GDyl
	 VK5vAAHrRdEio3BqTu8jXEZ4cH6PLV+6wbYLVm88exLU6y/5xnmxsmc8NkJ4UD75Gj
	 UNMR01ALsUkiSlTbfUN3nonPPXq4i+kqrqCnNgG9I9fUZicUbGtf8RqFILZ+28Drk1
	 8jTw/aOBmJRol1bum+HThigdns+38cOr+m13I1DG65uE9dLacSLLYIpbuNGwLo5xCE
	 BMtGxYNoe2qDA==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-205f223639fso805621fac.2;
        Sun, 07 Jan 2024 03:34:52 -0800 (PST)
X-Gm-Message-State: AOJu0Yw++QrPvpQpX82uXcNS3lRaQ0C3qIcH8x3iw1PKbKAkgy41BE3C
	G9qQ9eLevGNG3yaMDDcjyTAfK9OyL67K3CyFZnQ=
X-Google-Smtp-Source: AGHT+IEFNo/umTOKVOCwvp8VXon8yM6f5dZ8/YFlhVS2raLhwwIK7XX+vjKUUKGZhK5c4OABFLrvYqXX2vibuJQLu1E=
X-Received: by 2002:a05:6870:4f11:b0:204:1a1f:c0ff with SMTP id
 xi17-20020a0568704f1100b002041a1fc0ffmr2998188oab.38.1704627291854; Sun, 07
 Jan 2024 03:34:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103135454.376021-1-masahiroy@kernel.org> <CA+icZUX77miqFC5=iH_9e4BZw5hc1Ci8A3cHL1uGPnzHw258Hw@mail.gmail.com>
 <CAK7LNAQYQiuQ2mn=aAqOrx-xsV1hT5Q6UTkWLNkG_4E77NyEog@mail.gmail.com> <CA+icZUVyTm=xGWd77f2D8xxcsH+1rXm7YaW==u1i=MVDfZ-+TQ@mail.gmail.com>
In-Reply-To: <CA+icZUVyTm=xGWd77f2D8xxcsH+1rXm7YaW==u1i=MVDfZ-+TQ@mail.gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sun, 7 Jan 2024 20:34:15 +0900
X-Gmail-Original-Message-ID: <CAK7LNAReV3EBzAuZxAfwk5LwaYUipkyFaKz_etZfebHiq+20-w@mail.gmail.com>
Message-ID: <CAK7LNAReV3EBzAuZxAfwk5LwaYUipkyFaKz_etZfebHiq+20-w@mail.gmail.com>
Subject: Re: [PATCH] linux/export.h: remove unneeded .balign directive
To: sedat.dilek@gmail.com
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Helge Deller <deller@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 5, 2024 at 5:21=E2=80=AFPM Sedat Dilek <sedat.dilek@gmail.com> =
wrote:
>
> On Thu, Jan 4, 2024 at 3:17=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.=
org> wrote:
> >
> > On Thu, Jan 4, 2024 at 1:05=E2=80=AFAM Sedat Dilek <sedat.dilek@gmail.c=
om> wrote:
> > >
> > > Happy new 2024 Masahiro,
> > >
> > > some small nits.
> > >
> > > What about adding links to the commits...
> > >
> > > linux/export: Fix alignment for 64-bit ksymtab entries
> > > [ Upstream commit f6847807c22f6944c71c981b630b9fff30801e73 ]
> > >
> > > linux/export: Ensure natural alignment of kcrctab array
> > > [ Upstream commit 753547de0daecbdbd1af3618987ddade325d9aaa ]
> > >
> > > ^^ AFAICS in linux-stable - v6.6.10-rc1 includes both
> > > ^^ Is yours a follow-up and makes sense for linux-stable releases?
> >
> >
> > No.
> >
> > This patch is a separate clean-up, not a bug fix.
> >
> > No need for back-porting.
> >
>
> Thanks for the clarification.
>
> But it is an improvement - so no discarding at link-time means
> reduction of build-time?
> Amy numbers?


The .export_symbol is already discarded.

The alignment of discarded code is "don't care".
So, this is a code clean-up.

I do not think there is a noticeable difference
in the build speed.




See line 1005 of include/asm-generic/vmlinux.h.lds


#define COMMON_DISCARDS                                                 \
        SANITIZER_DISCARDS                                              \
        PATCHABLE_DISCARDS                                              \
        *(.discard)                                                     \
        *(.discard.*)                                                   \
        *(.export_symbol)                                               \
        *(.modinfo)                                                     \
        /* ld.bfd warns about .gnu.version* even when not emitted */    \
        *(.gnu.version*)










> >
> >
> >
> > >
> > > ...and CC Helge Deller?
> >
>
> CC in the patch - makes for me only sense if you agree on adding above
> commit-ids of Helge's work.
> I think this is good in sense of follow-able references.
>
> Best regards,
> -Sedat-
>
> >
> > You did it.
> >
> >
> > Thanks.
> >
> >
> >
> >
> >
> > > Best regards,
> > > -Sedat-
> > >
> > > Link: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git/log/?h=3Dlinux-6.6.y
> > >
> > > On Wed, Jan 3, 2024 at 2:55=E2=80=AFPM Masahiro Yamada <masahiroy@ker=
nel.org> wrote:
> > > >
> > > > The .export_symbol section is discarded by the linker script, hence
> > > > no alignment is needed. Simplify the code.
> > > >
> > > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > > ---
> > > >
> > > >  include/linux/export.h | 10 +++-------
> > > >  1 file changed, 3 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/include/linux/export.h b/include/linux/export.h
> > > > index 0bbd02fd351d..dff230bb5aca 100644
> > > > --- a/include/linux/export.h
> > > > +++ b/include/linux/export.h
> > > > @@ -15,13 +15,9 @@
> > > >   */
> > > >
> > > >  #ifdef CONFIG_64BIT
> > > > -#define __EXPORT_SYMBOL_REF(sym)                       \
> > > > -       .balign 8                               ASM_NL  \
> > > > -       .quad sym
> > > > +#define __EXPORT_SYMBOL_PTR    .quad
> > > >  #else
> > > > -#define __EXPORT_SYMBOL_REF(sym)                       \
> > > > -       .balign 4                               ASM_NL  \
> > > > -       .long sym
> > > > +#define __EXPORT_SYMBOL_PTR    .long
> > > >  #endif
> > > >
> > > >  #define ___EXPORT_SYMBOL(sym, license, ns)             \
> > > > @@ -29,7 +25,7 @@
> > > >         __export_symbol_##sym:                  ASM_NL  \
> > > >                 .asciz license                  ASM_NL  \
> > > >                 .asciz ns                       ASM_NL  \
> > > > -               __EXPORT_SYMBOL_REF(sym)        ASM_NL  \
> > > > +               __EXPORT_SYMBOL_PTR sym         ASM_NL  \
> > > >         .previous
> > > >
> > > >  #if defined(__DISABLE_EXPORTS)
> > > > --
> > > > 2.40.1
> > > >
> > > >
> > >
> >
> >
> > --
> > Best Regards
> > Masahiro Yamada



--=20
Best Regards
Masahiro Yamada

