Return-Path: <linux-kernel+bounces-16760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F5E824370
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 554E8287A21
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BE9224EC;
	Thu,  4 Jan 2024 14:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o7T2ghRX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66030224E7;
	Thu,  4 Jan 2024 14:17:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD257C433C7;
	Thu,  4 Jan 2024 14:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704377832;
	bh=eQ7aDWTSRpaN+U/7sf3RyfPIiHHdFRSmH7Oa7qM8a5c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=o7T2ghRXw4rIv6huLtcx/MZoqwwUm6YGdTYWQ2RNBxdKD2k+P0vW+o7u4s2IOa+6c
	 KKtJrVgACx9in0+Co4If06+MeRNB3rhg9oqeQ/O+613ifpEbxTGJ2QY1HEUE4xWBGL
	 t1elNAfzSdA2gsywtHizw91x2fVBEMcIRnWVO+hEk+kvxiO1lIdtadvqL07rM1mpYd
	 tjnAPs3QvdEeXFB2MVeWwx0P3rbuFTdpNPxrkeZetxFsMsyPTmSDYOdPIHvQLnWc2v
	 O+6e6W1N1eXr+12pPGExAgMcHtZoEvRnnCTG4/OeawcMGNRtyx/WOL0TR63QcuhE11
	 2YDqVIdar7VoA==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2043e721daaso279002fac.2;
        Thu, 04 Jan 2024 06:17:12 -0800 (PST)
X-Gm-Message-State: AOJu0YwudgSZM0fCY4hKVTdk0z4X8+xs0TL4BQwcaZRfOZYzVLTzTYGV
	7A8x8p52wNRu+nEcR3wY1Y0o7BFcaDEZnGWw9WA=
X-Google-Smtp-Source: AGHT+IFNnanMPL/0Df4b9PcVGoF9nPV9liwJQBoRre85bCGoux+sgtqfnrWAYCXOUVSJm+tl3SFJz6Zhji3hH8YZLwM=
X-Received: by 2002:a05:6870:5390:b0:205:c845:7e24 with SMTP id
 h16-20020a056870539000b00205c8457e24mr472050oan.0.1704377832206; Thu, 04 Jan
 2024 06:17:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103135454.376021-1-masahiroy@kernel.org> <CA+icZUX77miqFC5=iH_9e4BZw5hc1Ci8A3cHL1uGPnzHw258Hw@mail.gmail.com>
In-Reply-To: <CA+icZUX77miqFC5=iH_9e4BZw5hc1Ci8A3cHL1uGPnzHw258Hw@mail.gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Thu, 4 Jan 2024 23:16:36 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQYQiuQ2mn=aAqOrx-xsV1hT5Q6UTkWLNkG_4E77NyEog@mail.gmail.com>
Message-ID: <CAK7LNAQYQiuQ2mn=aAqOrx-xsV1hT5Q6UTkWLNkG_4E77NyEog@mail.gmail.com>
Subject: Re: [PATCH] linux/export.h: remove unneeded .balign directive
To: sedat.dilek@gmail.com
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Helge Deller <deller@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 1:05=E2=80=AFAM Sedat Dilek <sedat.dilek@gmail.com> =
wrote:
>
> Happy new 2024 Masahiro,
>
> some small nits.
>
> What about adding links to the commits...
>
> linux/export: Fix alignment for 64-bit ksymtab entries
> [ Upstream commit f6847807c22f6944c71c981b630b9fff30801e73 ]
>
> linux/export: Ensure natural alignment of kcrctab array
> [ Upstream commit 753547de0daecbdbd1af3618987ddade325d9aaa ]
>
> ^^ AFAICS in linux-stable - v6.6.10-rc1 includes both
> ^^ Is yours a follow-up and makes sense for linux-stable releases?


No.

This patch is a separate clean-up, not a bug fix.

No need for back-porting.




>
> ...and CC Helge Deller?


You did it.


Thanks.





> Best regards,
> -Sedat-
>
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git/log/?h=3Dlinux-6.6.y
>
> On Wed, Jan 3, 2024 at 2:55=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.=
org> wrote:
> >
> > The .export_symbol section is discarded by the linker script, hence
> > no alignment is needed. Simplify the code.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  include/linux/export.h | 10 +++-------
> >  1 file changed, 3 insertions(+), 7 deletions(-)
> >
> > diff --git a/include/linux/export.h b/include/linux/export.h
> > index 0bbd02fd351d..dff230bb5aca 100644
> > --- a/include/linux/export.h
> > +++ b/include/linux/export.h
> > @@ -15,13 +15,9 @@
> >   */
> >
> >  #ifdef CONFIG_64BIT
> > -#define __EXPORT_SYMBOL_REF(sym)                       \
> > -       .balign 8                               ASM_NL  \
> > -       .quad sym
> > +#define __EXPORT_SYMBOL_PTR    .quad
> >  #else
> > -#define __EXPORT_SYMBOL_REF(sym)                       \
> > -       .balign 4                               ASM_NL  \
> > -       .long sym
> > +#define __EXPORT_SYMBOL_PTR    .long
> >  #endif
> >
> >  #define ___EXPORT_SYMBOL(sym, license, ns)             \
> > @@ -29,7 +25,7 @@
> >         __export_symbol_##sym:                  ASM_NL  \
> >                 .asciz license                  ASM_NL  \
> >                 .asciz ns                       ASM_NL  \
> > -               __EXPORT_SYMBOL_REF(sym)        ASM_NL  \
> > +               __EXPORT_SYMBOL_PTR sym         ASM_NL  \
> >         .previous
> >
> >  #if defined(__DISABLE_EXPORTS)
> > --
> > 2.40.1
> >
> >
>


--=20
Best Regards
Masahiro Yamada

