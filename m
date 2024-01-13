Return-Path: <linux-kernel+bounces-25245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC06382CB57
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 10:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17816283512
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 09:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508E411190;
	Sat, 13 Jan 2024 09:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pH6+cONu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C4B15BD;
	Sat, 13 Jan 2024 09:58:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C1DBC433C7;
	Sat, 13 Jan 2024 09:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705139902;
	bh=FfxGNilRrWVWSgO9NIzqF6+pAz99j8vZeiAam+1t2cQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pH6+cONuPR1UUdPeEz4KrGgqpDVqyZVmGvT/KsRlvKTIVMJw9LSxRB9BkOXGJOFYf
	 BPn6EMtWeEFulOBSd3f8MG6pqwqvlk6c3CnTHJQmYOBodgFRId9kqzgSemzb059sPe
	 I5T47a1wdImvd7ZQy0t0f8ZTyaqAfrOaXh74dBV9VIk+ueZUAZBDaP9Srd96jkHSOh
	 z6d66bgsJGtu2OI30WxUOZacWIcI/k/YE9OKAAjA/Hikmj1YWk4vMs7HMCY3VshKeL
	 8mhuP1RQNCENgNP+daFdY057gV5lo2tut45ti7YtENPFoC7+2vlvVGd7fOj56382nl
	 azl7cG4DVDyjg==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-595b3644acbso3478582eaf.1;
        Sat, 13 Jan 2024 01:58:22 -0800 (PST)
X-Gm-Message-State: AOJu0YzIianEmpRHy7jxoC0A5XmQFjc6M0surRB1ulU/UvgsVuRwj6HD
	nvusaQ8v34YZKrHFuX1eRh46YQBW8DnZ86t3yQY=
X-Google-Smtp-Source: AGHT+IE1zNVfRyZXDjtOGlgSbTOnebJDrwvdklW58RioZiUXyKLrfSiZNygDH+VTpnbQ97TSIfDDXK2iUoj5GQfpPpU=
X-Received: by 2002:a05:6870:de12:b0:206:ad36:5a46 with SMTP id
 qg18-20020a056870de1200b00206ad365a46mr1284007oab.9.1705139901720; Sat, 13
 Jan 2024 01:58:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110165339.GA3105@dev-arch.thelio-3990X>
In-Reply-To: <20240110165339.GA3105@dev-arch.thelio-3990X>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sat, 13 Jan 2024 18:57:45 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT1GBr1pKRuJp2YKZdQQ_TDSKdbHojbPtBvt7cRQdCReg@mail.gmail.com>
Message-ID: <CAK7LNAT1GBr1pKRuJp2YKZdQQ_TDSKdbHojbPtBvt7cRQdCReg@mail.gmail.com>
Subject: Re: [RFC] Bumping the minimum supported version of LLVM to 13.0.1
To: Nathan Chancellor <nathan@kernel.org>
Cc: llvm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 1:53=E2=80=AFAM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> Hi all,
>
> It has been some time since we have bumped the minimum supported version
> of LLVM for building the kernel, the last time being commit df05c0e9496c
> ("Documentation: Raise the minimum supported version of LLVM to 11.0.0")
> in November of 2021. While I think we have done a pretty good job around
> supporting the current range of LLVM versions, it may be worth
> considering bumping the minimum supported version to 13.0.1 for a few
> reasons:
>
> 1. It would immediately resolve the massive build breakage with LLVM 11
>    in -next:
>
>    https://github.com/ClangBuiltLinux/linux/issues/1958#issuecomment-1836=
559075
>
> 2. It would immediately save us almost 1300 builds per week with our
>    current CI matrix, as we would be able to drop mainline and -next,
>    which are our most frequently built trees.
>
> 3. It allows us to drop a good number of Kconfig and source workarounds.
>    I have included a sample diff below.
>
> The downside of upgrading the minimum version is leaving distributions
> that have an older clang version behind. However, based on examining
> Docker images for the currently supported versions of the big
> distributions, I do not believe this upgrade should impact distribution
> support too much.
>
>     archlinux:latest              clang version 16.0.6
>     debian:oldoldstable-slim      clang version 7.0.1-8+deb10u2 (tags/REL=
EASE_701/final)
>     debian:oldstable-slim         Debian clang version 11.0.1-2
>     debian:stable-slim            Debian clang version 14.0.6
>     debian:testing-slim           Debian clang version 16.0.6 (19)
>     debian:unstable-slim          Debian clang version 16.0.6 (19)
>     fedora:38                     clang version 16.0.6 (Fedora 16.0.6-3.f=
c38)
>     fedora:latest                 clang version 17.0.6 (Fedora 17.0.6-1.f=
c39)
>     fedora:rawhide                clang version 17.0.6 (Fedora 17.0.6-1.f=
c40)
>     opensuse/leap:latest          clang version 15.0.7
>     opensuse/tumbleweed:latest    clang version 17.0.6
>     ubuntu:focal                  clang version 10.0.0-4ubuntu1
>     ubuntu:latest                 Ubuntu clang version 14.0.0-1ubuntu1.1
>     ubuntu:rolling                Ubuntu clang version 16.0.6 (15)
>     ubuntu:devel                  Ubuntu clang version 17.0.6 (3)
>
> As we can see, the only distribution in that list that would be impacted
> by this change would be Debian Bullseye (oldstable), as its clang
> version in the default repositories is 11.0.1. Other distributions that
> have a clang older than 11.0.1 already cannot build the upstream kernel.
> In Debian's case, access to newer versions of LLVM is relatively simple
> because of https://apt.llvm.org. There is also the kernel.org LLVM
> toolchains I publish: https://mirrors.edge.kernel.org/pub/tools/llvm/
>
> Thoughts or concerns?



No objection from me.


>
> I have posted this on GitHub as well in case people want to chime in
> there instead of here for some reason:
>
> https://github.com/ClangBuiltLinux/linux/issues/1975
>
> Cheers,
> Nathan
>
> diff --git a/Makefile b/Makefile
> index f1b2fd977275..32f42f4470ec 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -948,15 +948,6 @@ CC_FLAGS_LTO       +=3D -fvisibility=3Dhidden
>  # Limit inlining across translation units to reduce binary size
>  KBUILD_LDFLAGS +=3D -mllvm -import-instr-limit=3D5
>
> -# Check for frame size exceeding threshold during prolog/epilog insertio=
n
> -# when using lld < 13.0.0.
> -ifneq ($(CONFIG_FRAME_WARN),0)
> -ifeq ($(call test-lt, $(CONFIG_LLD_VERSION), 130000),y)
> -KBUILD_LDFLAGS +=3D -plugin-opt=3D-warn-stack-size=3D$(CONFIG_FRAME_WARN=
)
> -endif
> -endif
> -endif
> -

The last 'endif' should be kept.








--
Best Regards
Masahiro Yamada

