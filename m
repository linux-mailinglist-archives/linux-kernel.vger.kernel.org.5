Return-Path: <linux-kernel+bounces-155547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4088AF3CC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D203CB23BA2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2881C13D50B;
	Tue, 23 Apr 2024 16:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUPSdfuW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A3913D2B6;
	Tue, 23 Apr 2024 16:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713889344; cv=none; b=FWJdl3H/iA1NkZFENWZE3y53zMUPmU0vyNt+hfMVlJlfyvNlTXlS8ZcOhc1NCKKrDfLQ02k7bSCXXNEspczRd7K7SEzq+ft7g3bX75D2zbg3FkNk/SngkVua6Ge2t1UKmnzkywwfvLDfe7aRSFdrrs9ZpZzcvQer5APEJ/aaSP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713889344; c=relaxed/simple;
	bh=oJzUEgPOfRz4FVU7f4MkDckgyDNtgFaj6AoyVUoITHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dKFNSyzGsvwWErxRr9g1d0UOsX/Yf2xeT0iSHGVHNC38b2SkOuoyrPuVy5vHBGL2z2QSKqxzs3TkjGURmKMZCi0APYlyiUB2jsl/jxlFh3O2qL83vc8eurgLu/sbr6ij5eLmUYHw/PqWmduHidgzl/ireLvOcKdRvR0EitXekG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LUPSdfuW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD67C32783;
	Tue, 23 Apr 2024 16:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713889344;
	bh=oJzUEgPOfRz4FVU7f4MkDckgyDNtgFaj6AoyVUoITHg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LUPSdfuWswat2YbontFlrpuaSPEp5kZTyppwr/svANpYziPuvV9/9qN/T2RaeE4vh
	 oGanM8CiaH4JeMTrw2KAtTpzUYtZB298/wq6ScbcPihG8jTIxHKMO2bfpL/9VsshmX
	 AJt43koJwYmBY1ippurWAn7CiuVrKeye7ZFUWkheGdmnSwCJcEwgb97TV8u541sx+o
	 gp4k0/eLgS1pD3/crkwg7h2cH2RSnPcPhIlEEYgZNbEHPvzfDvyK4mU/jz/vKsP1sC
	 e3fbV56QrIr/DMPDnkw0cdJVf0jo1FY55AB3nh/GA8KxkX6xLFjQjh4PYhhRYLx4KA
	 U5obh+beqlvQg==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2db6f5977e1so78363541fa.2;
        Tue, 23 Apr 2024 09:22:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXbIecXI85x+s+m1F4UjopU5zcrto7wT2VaRrUVuJFrjQ3qeMdc10f93Y/mxy9M9odFf2X3zvNcpE4Sy5YhIRF8YDHO/t8rTrfeC4ViFIRHExSYm2UT9ll5R/jBDw5TXnoD2X6KTjU+dP0G
X-Gm-Message-State: AOJu0Yx3iJeaEL/VVsr42P8AdHXjhde33Ct+vCGGsvAa71D55LiHWx3Y
	XxsRr90y+660NpoNjCUtoefz9PWS84JwIrhma+q1xDxnJZ9/udfLrByakPXl70qs1YugLl31ePG
	3ZBh+MakAKMxsCX3E1ESX9D8tAHs=
X-Google-Smtp-Source: AGHT+IGBf8KlVvlJQHwaYJUUupKtFBr3QmhzNR2Ww/+nF8KFeeWkoc3mEINyodhNlJF7QLsZGPVopJ+/t/77bNtMUuk=
X-Received: by 2002:a2e:84d5:0:b0:2d4:37ca:92d1 with SMTP id
 q21-20020a2e84d5000000b002d437ca92d1mr8064840ljh.42.1713889342313; Tue, 23
 Apr 2024 09:22:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240420145303.238068-2-ardb+git@google.com> <CAK7LNARGZZC=5Pcy8qBpp1E94hRHHHdUu7KxVudH1iT-yugs=g@mail.gmail.com>
 <9fda72fa-e5e5-4d45-b268-dd98d28fb5a1@linaro.org>
In-Reply-To: <9fda72fa-e5e5-4d45-b268-dd98d28fb5a1@linaro.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 23 Apr 2024 18:22:10 +0200
X-Gmail-Original-Message-ID: <CAMj1kXERSHjh0k9uCmYuNf31Fg79sd_6EHuS=Y_-xEdNGWeiAw@mail.gmail.com>
Message-ID: <CAMj1kXERSHjh0k9uCmYuNf31Fg79sd_6EHuS=Y_-xEdNGWeiAw@mail.gmail.com>
Subject: Re: [PATCH v5] kallsyms: Avoid weak references for kallsyms symbols
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Ard Biesheuvel <ardb+git@google.com>, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	Nick Desaulniers <ndesaulniers@google.com>, Kees Cook <keescook@chromium.org>, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Apr 2024 at 18:01, Konrad Dybcio <konrad.dybcio@linaro.org> wrot=
e:
>
>
>
> On 4/22/24 18:02, Masahiro Yamada wrote:
> > On Sat, Apr 20, 2024 at 11:53=E2=80=AFPM Ard Biesheuvel <ardb+git@googl=
e.com> wrote:
> >>
> >> From: Ard Biesheuvel <ardb@kernel.org>
> >>
> >> kallsyms is a directory of all the symbols in the vmlinux binary, and =
so
> >> creating it poses somewhat of a chicken-and-egg problem, as its non-ze=
ro
> >> size affects the layout of the binary, and therefore the values of the
> >> symbols.
> >>
> >> For this reason, the kernel is linked more than once, and the first pa=
ss
> >> does not include any kallsyms data at all. For the linker to accept
> >> this, the symbol declarations describing the kallsyms metadata are
> >> emitted as having weak linkage, so they can remain unsatisfied. During
> >> the subsequent passes, the weak references are satisfied by the kallsy=
ms
> >> metadata that was constructed based on information gathered from the
> >> preceding passes.
> >>
> >> Weak references lead to somewhat worse codegen, because taking their
> >> address may need to produce NULL (if the reference was unsatisfied), a=
nd
> >> this is not usually supported by RIP or PC relative symbol references.
> >>
> >> Given that these references are ultimately always satisfied in the fin=
al
> >> link, let's drop the weak annotation on the declarations, and instead,
> >> provide fallback definitions with weak linkage. This informs the
> >> compiler that ultimately, the reference will always be satisfied.
> >>
> >> While at it, drop the FRV specific annotation that these symbols resid=
e
> >> in .rodata - FRV is long gone.
> >>
> >> Cc: Masahiro Yamada <masahiroy@kernel.org>
> >> Cc: linux-kbuild@vger.kernel.org
> >> Acked-by: Nick Desaulniers <ndesaulniers@google.com>
> >> Acked-by: Kees Cook <keescook@chromium.org>
> >> Acked-by: Arnd Bergmann <arnd@arndb.de>
> >> Link: https://lore.kernel.org/all/20240415075837.2349766-5-ardb+git@go=
ogle.com
> >> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> >> ---
> >> v5: - avoid PROVIDE() in the linker script, use weak definitions inste=
ad
> >>      - drop tested-by, replace reviewed-by with acked-by
> >>
> >
> > Applied to linux-kbuild. Thanks.
>
> Hi, this commit seems to break call traces, resulting in output like:
>
> [    2.777006] Call trace:
> [    2.777007]  _text+0x89e7e8/0x39e0000
> [    2.777008]  _text+0x89e82c/0x39e0000
> [    2.777009]  _text+0x2b940cc/0x2bd2a90
> [    2.777011]  _text+0x2b941a4/0x2bd2a90
> [    2.777012]  _text+0x145dc/0x39e0000
> [    2.777014]  _text+0x2b51184/0x2bd2a90
> [    2.777016]  _text+0x18fc6a4/0x39e0000
> [    2.777018]  _text+0x15644/0x39e0000
> [    2.777019] ---[ end trace 0000000000000000 ]---
>

This patch triggers an issue in the compiler, which appears to perform
constant propagation on variables defined as weak, and this is
definitely a compiler bug. (A weak variable can be superseded by
another instance from a different object at link time, so the compiler
cannot make assumptions based on the version of the variable it
observes at compile time)

It has already been dropped from the kbuild tree.

