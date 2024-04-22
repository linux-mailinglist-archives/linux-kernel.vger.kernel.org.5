Return-Path: <linux-kernel+bounces-153673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF248AD17A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB24D1C22B0F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAC115382B;
	Mon, 22 Apr 2024 16:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1uHVpyU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3858515381E;
	Mon, 22 Apr 2024 16:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713801800; cv=none; b=XRjhw6EkRqwbaVeJjjM+Bj68lkCStzWd60HW3jSekUe6bizg6/Ivves2xMdKZIKybCCkdzwknb2Ns1kKG6bNow3TZQCOJo6EP1ApVBuA4FRt+RkroA/izWxbSztFAt2igwHWWvUODiM5ZMdN0xFYuq4uuDhkndiV0eTNlgcZfOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713801800; c=relaxed/simple;
	bh=ZJWwic3XrHjXmdZ+9q8lK0cufHqWrJSthx0d2ZJpeAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jatRIeg3fmrgZd8joRM6r02ws/dyw4EHBp/fiJBhCICEa2+gUwIar9CAOyxZqqYuY5VK6luLGvp42iCnty0Y8mE/9MkLcIWg1xGo2bdR654k/B5fHc+8snJlXn7g39TH5qMzY1269hpjoC0j/uVUCRsTYlRohczjqQNGiuBG840=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1uHVpyU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E94C113CC;
	Mon, 22 Apr 2024 16:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713801799;
	bh=ZJWwic3XrHjXmdZ+9q8lK0cufHqWrJSthx0d2ZJpeAk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=s1uHVpyUQ2UwRxxd4ouLYYS8iTrt/8TV/kbRBKV61DhfrujuIfQqKadyAR9b9Eb0M
	 N1rtVCmbgxLz74Gj1CzWT4ORqHSQwG1flMS7gUcBI4LBSwDHIqY75h0Bta4X+pDd4K
	 Qd228EawHoxi1fRhbbvmQc79kt0V82bF35yYqZS1yaZ/rgKZL6rUUVKvE9IBAY2yDd
	 0T97hMk+JDc1iWsBzKoxbpGWwY5reqf4uUbr5ByWD0pFVJ+47zbH2TCg7o8OdL5Zet
	 X1TXMRdJXlV0NYbk1pd5O+FMNpjUC853SUhiWPQH6SAi0/tPPFOVE3eZQAsI9D0yJ/
	 ofhO82gU+aHNA==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d858501412so62238571fa.0;
        Mon, 22 Apr 2024 09:03:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW5hiY1LoaeqqobN/TRiXt0yRIxnS9IKD9qINaRbCLbzjQ3RWYfP93snb/ZLqae0SGl80eeclSH+iQN/MWa0ESXM5hz6eLyPETRmJQ3
X-Gm-Message-State: AOJu0Yxi/OsXCt7folQmcKojaRvG6lAT+J9cl+cJ9vvKsPmVaXF41aNR
	MT30tSZ5cLdIEsWO3jyaeXOuoneGvNSVwthDGiuYeDS3V+zxxhRSqv0V3G5pE6tmLVvGK89xfAS
	Ofw9Z5UvFdn+JviJCMeLpdZCWPjs=
X-Google-Smtp-Source: AGHT+IFYPFwFkEPK1hqPWAvBdJKd48QuYBDy2gt+u28P4MseNLfYPM/F9hPx5+hGKgWpSo3q5S7Rmu28D+5rXK5mKwQ=
X-Received: by 2002:a2e:960d:0:b0:2d3:2ecf:c26a with SMTP id
 v13-20020a2e960d000000b002d32ecfc26amr6581548ljh.13.1713801798518; Mon, 22
 Apr 2024 09:03:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240420145303.238068-2-ardb+git@google.com>
In-Reply-To: <20240420145303.238068-2-ardb+git@google.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 23 Apr 2024 01:02:42 +0900
X-Gmail-Original-Message-ID: <CAK7LNARGZZC=5Pcy8qBpp1E94hRHHHdUu7KxVudH1iT-yugs=g@mail.gmail.com>
Message-ID: <CAK7LNARGZZC=5Pcy8qBpp1E94hRHHHdUu7KxVudH1iT-yugs=g@mail.gmail.com>
Subject: Re: [PATCH v5] kallsyms: Avoid weak references for kallsyms symbols
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	linux-kbuild@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>, 
	Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 20, 2024 at 11:53=E2=80=AFPM Ard Biesheuvel <ardb+git@google.co=
m> wrote:
>
> From: Ard Biesheuvel <ardb@kernel.org>
>
> kallsyms is a directory of all the symbols in the vmlinux binary, and so
> creating it poses somewhat of a chicken-and-egg problem, as its non-zero
> size affects the layout of the binary, and therefore the values of the
> symbols.
>
> For this reason, the kernel is linked more than once, and the first pass
> does not include any kallsyms data at all. For the linker to accept
> this, the symbol declarations describing the kallsyms metadata are
> emitted as having weak linkage, so they can remain unsatisfied. During
> the subsequent passes, the weak references are satisfied by the kallsyms
> metadata that was constructed based on information gathered from the
> preceding passes.
>
> Weak references lead to somewhat worse codegen, because taking their
> address may need to produce NULL (if the reference was unsatisfied), and
> this is not usually supported by RIP or PC relative symbol references.
>
> Given that these references are ultimately always satisfied in the final
> link, let's drop the weak annotation on the declarations, and instead,
> provide fallback definitions with weak linkage. This informs the
> compiler that ultimately, the reference will always be satisfied.
>
> While at it, drop the FRV specific annotation that these symbols reside
> in .rodata - FRV is long gone.
>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: linux-kbuild@vger.kernel.org
> Acked-by: Nick Desaulniers <ndesaulniers@google.com>
> Acked-by: Kees Cook <keescook@chromium.org>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Link: https://lore.kernel.org/all/20240415075837.2349766-5-ardb+git@googl=
e.com
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
> v5: - avoid PROVIDE() in the linker script, use weak definitions instead
>     - drop tested-by, replace reviewed-by with acked-by
>

Applied to linux-kbuild. Thanks.


--=20
Best Regards
Masahiro Yamada

