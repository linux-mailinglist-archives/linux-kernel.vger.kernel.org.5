Return-Path: <linux-kernel+bounces-17578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D67EB824FB1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 09:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE75D1C22B47
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 08:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF7920DD1;
	Fri,  5 Jan 2024 08:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6ZLNsgF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B6020DC8;
	Fri,  5 Jan 2024 08:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50e80d40a41so1596265e87.1;
        Fri, 05 Jan 2024 00:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704442894; x=1705047694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6VQ6j0LINTXUCaF6pqicbZbvJ/sJcDPd8VasoZJ96ws=;
        b=L6ZLNsgFM78s7igRXguErFzof063CSdlaW+2XOo9+n1U/utC8VCOtHnT4tKUiIYefa
         vAowkiGxuSZ543SjgfAiGVJ8tk8/ESemcVsuRufFJ28U3Zwb06GpHuz+iNW5xKAFVA7g
         3/7kfI44/zmdXfwTFtCrAN55mBYfHqUEHuKyQdCX0ny64RgXMv+a0lEMKytqTXIlOX2F
         xN5/8zE+IESSnFCFjQ8vzn/iGKNyqQeeeIBwFp4tAujIUcHroiyiwDpmM51oQLgyccJd
         xAZbSD3Xfu8LXdBdd5VE+dzl8vm0Bhrry1xUrEtuTr8ELVM83AfaTEHfIhVWt0eGeIzM
         6RMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704442894; x=1705047694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6VQ6j0LINTXUCaF6pqicbZbvJ/sJcDPd8VasoZJ96ws=;
        b=qDy47S05gxOoA4e2VkhShoipNH21DxRko7wP5nQVd2gnQwQOdYfZ0VrbL4d56CPAq2
         9fkeNUVjg9XbDY2Ut29k2SDPDscjAsVEV4sIMGThp5L8Ubbazo45Ypv5PhrMM8hMewqN
         140xPgLlfYmsMn5YMUjJ/Ueu79GXvIPoPUXnzi6WrK3l4F4jh+z34BgOKi+oyAihTMNg
         /XqL91z01JPzOXeFT2Dtp75CVGeAeraWqgSg41+wirihMfXpbLhftExodpNu7MFDoYw0
         SsVYzkL93V4g+47aY0IoRccYmxepNMYXePsA7DL2ea9yc3QDuNmGDSE5QZyMJpa65iCl
         Qu5g==
X-Gm-Message-State: AOJu0YwM2DxGqNZ8xoILR3HVbrsyhSaz/3cm8Yx4ujo4NqUHubOqIugT
	n2gzZ3RfNKL+wTuj1CeTmNoHGnV6AdiEfg5bbfk=
X-Google-Smtp-Source: AGHT+IH8cMooyWbuT5XYhNukp6rn5Lnribp/maHa6v1qFOLP7A02fkFEYCAmEJXHZyO9F/a6DxCKKw8zwVmgxWrConM=
X-Received: by 2002:a05:6512:15b:b0:50e:a859:1421 with SMTP id
 m27-20020a056512015b00b0050ea8591421mr843213lfo.9.1704442894057; Fri, 05 Jan
 2024 00:21:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103135454.376021-1-masahiroy@kernel.org> <CA+icZUX77miqFC5=iH_9e4BZw5hc1Ci8A3cHL1uGPnzHw258Hw@mail.gmail.com>
 <CAK7LNAQYQiuQ2mn=aAqOrx-xsV1hT5Q6UTkWLNkG_4E77NyEog@mail.gmail.com>
In-Reply-To: <CAK7LNAQYQiuQ2mn=aAqOrx-xsV1hT5Q6UTkWLNkG_4E77NyEog@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Fri, 5 Jan 2024 09:20:57 +0100
Message-ID: <CA+icZUVyTm=xGWd77f2D8xxcsH+1rXm7YaW==u1i=MVDfZ-+TQ@mail.gmail.com>
Subject: Re: [PATCH] linux/export.h: remove unneeded .balign directive
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Helge Deller <deller@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 3:17=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.or=
g> wrote:
>
> On Thu, Jan 4, 2024 at 1:05=E2=80=AFAM Sedat Dilek <sedat.dilek@gmail.com=
> wrote:
> >
> > Happy new 2024 Masahiro,
> >
> > some small nits.
> >
> > What about adding links to the commits...
> >
> > linux/export: Fix alignment for 64-bit ksymtab entries
> > [ Upstream commit f6847807c22f6944c71c981b630b9fff30801e73 ]
> >
> > linux/export: Ensure natural alignment of kcrctab array
> > [ Upstream commit 753547de0daecbdbd1af3618987ddade325d9aaa ]
> >
> > ^^ AFAICS in linux-stable - v6.6.10-rc1 includes both
> > ^^ Is yours a follow-up and makes sense for linux-stable releases?
>
>
> No.
>
> This patch is a separate clean-up, not a bug fix.
>
> No need for back-porting.
>

Thanks for the clarification.

But it is an improvement - so no discarding at link-time means
reduction of build-time?
Amy numbers?

>
>
>
> >
> > ...and CC Helge Deller?
>

CC in the patch - makes for me only sense if you agree on adding above
commit-ids of Helge's work.
I think this is good in sense of follow-able references.

Best regards,
-Sedat-

>
> You did it.
>
>
> Thanks.
>
>
>
>
>
> > Best regards,
> > -Sedat-
> >
> > Link: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git/log/?h=3Dlinux-6.6.y
> >
> > On Wed, Jan 3, 2024 at 2:55=E2=80=AFPM Masahiro Yamada <masahiroy@kerne=
l.org> wrote:
> > >
> > > The .export_symbol section is discarded by the linker script, hence
> > > no alignment is needed. Simplify the code.
> > >
> > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > ---
> > >
> > >  include/linux/export.h | 10 +++-------
> > >  1 file changed, 3 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/include/linux/export.h b/include/linux/export.h
> > > index 0bbd02fd351d..dff230bb5aca 100644
> > > --- a/include/linux/export.h
> > > +++ b/include/linux/export.h
> > > @@ -15,13 +15,9 @@
> > >   */
> > >
> > >  #ifdef CONFIG_64BIT
> > > -#define __EXPORT_SYMBOL_REF(sym)                       \
> > > -       .balign 8                               ASM_NL  \
> > > -       .quad sym
> > > +#define __EXPORT_SYMBOL_PTR    .quad
> > >  #else
> > > -#define __EXPORT_SYMBOL_REF(sym)                       \
> > > -       .balign 4                               ASM_NL  \
> > > -       .long sym
> > > +#define __EXPORT_SYMBOL_PTR    .long
> > >  #endif
> > >
> > >  #define ___EXPORT_SYMBOL(sym, license, ns)             \
> > > @@ -29,7 +25,7 @@
> > >         __export_symbol_##sym:                  ASM_NL  \
> > >                 .asciz license                  ASM_NL  \
> > >                 .asciz ns                       ASM_NL  \
> > > -               __EXPORT_SYMBOL_REF(sym)        ASM_NL  \
> > > +               __EXPORT_SYMBOL_PTR sym         ASM_NL  \
> > >         .previous
> > >
> > >  #if defined(__DISABLE_EXPORTS)
> > > --
> > > 2.40.1
> > >
> > >
> >
>
>
> --
> Best Regards
> Masahiro Yamada

