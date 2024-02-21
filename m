Return-Path: <linux-kernel+bounces-74649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B50F085D73F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32225B22599
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4944C45C1C;
	Wed, 21 Feb 2024 11:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QmozKRwe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814CF4176B;
	Wed, 21 Feb 2024 11:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708515527; cv=none; b=sm6YQ9atwaNVDxCljAG3Nq8WLhQCufapOu23rdl/nUmFwo1mgs1wiVFL0E7sq8ULLBAoyTsjCaTEdgSYhOBw8utIIE6XM4dvPgVlX1WANw67gpk7obkqHO2FR6T5oSB4CmIxPWjow+moIspR0a+oKKXLalsmHlA6Dm3XvuQtqBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708515527; c=relaxed/simple;
	bh=xdNI4R/LUMaT7y3fB8rVKOoA4uG+WYub0HPf2OBgjcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iirjeq1SFn7dz+yiwU/kUpvLNiQ0OZzef9PHhZ3hIdvTwhz0UfHzUh8IUXv8O80bU1928JHdfsCgoMU3gvqd/6ijK3Z6VrjuAi66h71q0x/lHH6fqtDEcGdvMUe6/5jkpKVeBq+XHuSipLWFMSyRompnm0pSf8j/gz2XCeoJGtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QmozKRwe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F3CC433F1;
	Wed, 21 Feb 2024 11:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708515526;
	bh=xdNI4R/LUMaT7y3fB8rVKOoA4uG+WYub0HPf2OBgjcs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QmozKRwecaa1zNsQX36rVltHFrFiA93Pf5f7cUvkXCorawxiMezPx9U0wlR/PlxE1
	 XlLuXhozAcz1wjKycYYhwTTX2D9qfmTlDLsRWLArEiYgYx4coaNIL117XzczJ4fetx
	 8B+VDyE70pHDALoql3EpP5xSOGhOduvIDXvtlUDa+k4lxlHg35IBqL7JmZa84srtmm
	 2IheknnnODcaBCqBUp9V4DT24L5fyn/ICwUOqsEZLVlRhoK9v5kgD0m6Q+riLEiggN
	 D2DYlEAHJTbaUXH0+UxdLXz8MZHPnkJB8isaPkNeecc8DE88FCSOyBEjpcxBlH0Onu
	 O5dtefz0mRZZw==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d208d0b282so87131971fa.0;
        Wed, 21 Feb 2024 03:38:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU0QHlU8ZJ66fzUm3nWqDzTjiOIU4p1qtZf7D4ZQxJhMAfm0iI3Xy+ahj2KB84r8yDOa+uzidhrEYz1bMudX7SIMo5dS0uRHmYsd9trdTbx09Y5NKQpNYd53jFd5JNHuniZJTrJnXje395U
X-Gm-Message-State: AOJu0YyhYU6kkceOkx7Xbln8yaGD4adHPMSQKn0UCCs23G7UjhBeBpj8
	bc+1fr+RyHDX/7dLCS4FnjHVejG3ekHOuX3b7nBv5xx4snatwYMb8HGYNaaOWoqT1H7OcBcQto0
	emWzYy5sReIqfBQylKtcxQio0pLM=
X-Google-Smtp-Source: AGHT+IGNJDP0HHcDloPoj14KTp5eENtgej9XGqpUlKyJL224YotrIDwywNjW6rx8YXmSOMvyLeK1wUvQARFFAdUmTas=
X-Received: by 2002:a05:651c:1507:b0:2d2:4471:c9c8 with SMTP id
 e7-20020a05651c150700b002d24471c9c8mr4977958ljf.16.1708515525406; Wed, 21 Feb
 2024 03:38:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215151642.8970-1-petr.pavlu@suse.com> <CAK7LNAS=knGxd9ZRo37CaKTvjcc28bqNasx+XuqbV3S+XV=HtQ@mail.gmail.com>
 <9b067ec7-34e2-437b-a41b-319aaee4c7e6@suse.com>
In-Reply-To: <9b067ec7-34e2-437b-a41b-319aaee4c7e6@suse.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Wed, 21 Feb 2024 20:38:08 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ=iz8iY_VXmzGuU+7YPnaExm769k1BqCpSYvqSfRr=Fg@mail.gmail.com>
Message-ID: <CAK7LNAQ=iz8iY_VXmzGuU+7YPnaExm769k1BqCpSYvqSfRr=Fg@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: Use -fmin-function-alignment when available
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: nathan@kernel.org, nicolas@fjasle.eu, mark.rutland@arm.com, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 7:38=E2=80=AFPM Petr Pavlu <petr.pavlu@suse.com> wr=
ote:
>
> On 2/20/24 14:39, Masahiro Yamada wrote:
> > On Fri, Feb 16, 2024 at 12:16=E2=80=AFAM Petr Pavlu <petr.pavlu@suse.co=
m> wrote:
> >>
> >> GCC recently added option -fmin-function-alignment, which should appea=
r
> >> in GCC 14. Unlike -falign-functions, this option causes all functions =
to
> >> be aligned at the specified value, including the cold ones.
> >>
> >> Detect availability of -fmin-function-alignment and use it instead of
> >> -falign-functions when present. Introduce CC_HAS_SANE_FUNCTION_ALIGNME=
NT
> >> and make the workarounds for the broken function alignment conditional
> >> on this setting.
> >>
> >> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> >> ---
> >
> > [snip]
> >
> >> index dfb963d2f862..5a6fed4ad3df 100644
> >> --- a/kernel/exit.c
> >> +++ b/kernel/exit.c
> >> @@ -1920,7 +1920,10 @@ EXPORT_SYMBOL(thread_group_exited);
> >>   *
> >>   * See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D88345#c11
> >>   */
> >> -__weak __function_aligned void abort(void)
> >> +#ifndef CONFIG_CC_HAS_SANE_FUNCTION_ALIGNMENT
> >> +__function_aligned
> >> +#endif
> >> +__weak void abort(void)
> >>  {
> >>         BUG();
> >
> >
> >
> >
> >
> > __function_aligned is conditionally defined in
> > include/linux/compiler_types.h, and then it is
> > conditionally used in kernel/exit.c
> >
> > This is unreadable.
> >
> >
> >
> >
> > You may want to move CONFIG_CC_HAS_SANE_FUNCTION_ALIGNMENT
> > to include/linux/compiler_types.h, as this is more
> > aligned with what you did for __cold.
> >
> >
> >
> > if !defined(CONFIG_CC_HAS_SANE_FUNCTION_ALIGNMENT) && \
> >                CONFIG_FUNCTION_ALIGNMENT > 0
> > #define __function_aligned       __aligned(CONFIG_FUNCTION_ALIGNMENT)
> > #else
> > #define __function_aligned
> > #endif
> >
> >
> >
> >
> >
> > However, an even more elegant approach is to unify
> > the two #ifdef blocks because __cold and __function_aligned
> > are related to each other.
> >
> >
> >
> > #if defined(CONFIG_CC_HAS_SANE_FUNCTION_ALIGNMENT) || \
> >                  (CONFIG_FUNCTION_ALIGNMENT =3D=3D 0)
> > #define __cold                 __attribute__((__cold__))
> > #define __function_aligned
> > #else
> > #define __cold
> > #define __function_aligned     __aligned(CONFIG_FUNCTION_ALIGNMENT)
> > #endif
>
> I didn't want to make __function_aligned conditional on
> CONFIG_CC_HAS_SANE_FUNCTION_ALIGNMENT because the macro has a fairly
> general name. One could decide to mark a variable as __function_aligned
> and with the above code, it would no longer produce an expected result
> when -fmin-function-alignment is available.
>
> __function_aligned was introduced c27cd083cfb9 ("Compiler attributes:
> GCC cold function alignment workarounds") only for aligning the abort()
> function and has not been so far used anywhere else.
>
> If the above unification is preferred, I think it would be good to
> additionally rename the macro in order to prevent the mentioned misuse,
> perhaps to __force_function_alignment.
>
> #if defined(CONFIG_CC_HAS_SANE_FUNCTION_ALIGNMENT) || \
>                 (CONFIG_FUNCTION_ALIGNMENT =3D=3D 0)
> #define __cold                          __attribute__((__cold__))
> #define __force_function_alignment
> #else
> #define __cold
> #define __force_function_alignment      __aligned(CONFIG_FUNCTION_ALIGNME=
NT)
> #endif
>
> Would this be ok?





Or, you can always add __function_aligned to abort()
whether CONFIG_CC_HAS_SANE_FUNCTION_ALIGNMENT is y or n.


I think you did not need to modify kernel/exit.c









--
Best Regards
Masahiro Yamada

