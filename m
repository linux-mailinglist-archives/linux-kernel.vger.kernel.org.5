Return-Path: <linux-kernel+bounces-67009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DE98564BB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 281B71C2198C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB8C131738;
	Thu, 15 Feb 2024 13:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mskv9eTc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486A912FF7C;
	Thu, 15 Feb 2024 13:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708004769; cv=none; b=sT7RY7+6UaFkpPBkJ4SZE3glnuIZck2/zqIheWWvM3e2rIdFXBS2/nijgqNiwRaX6yQ+wZpTCy/FQ+h2wrSX59g5/upasNwZg+J8rKnsYENtDolyQJeiuCqLHPTxms/xeUuhoq/wf9uG/6b7L2JZOJVA0UhaHXqnaxmu/py3/QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708004769; c=relaxed/simple;
	bh=tc6ZrK/KriUkgV0fybz4vanC+BFX+YBBDvRESkhsuEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tuFu05c7C1JNg1iz3gPTmIYoiLE/cxfm3m3Dod1BtQ9ksWMlkwqml0qUjT69nPrDUU6NdL9zKY5RxnTMY0xQiRdwytu/lbt4vhQdkgnjPp2D3ksJGwhhABrsdtWgd/joxoDsPz4C/9HxlO8VZDdigGwCKvimvlBdqZ6eJa9Tiuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mskv9eTc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C7BC43399;
	Thu, 15 Feb 2024 13:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708004768;
	bh=tc6ZrK/KriUkgV0fybz4vanC+BFX+YBBDvRESkhsuEE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Mskv9eTczjjVvBSTcV32dwmQDpz1jSjDKs+RSc2Tepb3xeH9YSYxjgB7wlbjuXFb2
	 PX+5USWY2GK977aktlf1LIbfaT0rl7XJSrqB1JNeL2VgHBUwoeY/BL8Pp5auecZ/iC
	 cHoKpWKTAIxFSm+9fvmdv2KiihTkjdjE1Kw2ZU0UQtu2JHE556EN9WeaPz/mcuNWwK
	 P341aCtLytsNTVoNGJVEfQR3KA79j9WZ4xSZTx7fYiEHjMBeb8bB1mzyUjnHBjouzr
	 /xFzvhghcypoKp9ZrYsUXLVBaCOvBGgn+3DF2lYdo4xdgaRxGE0pmPtn7jOdViOuOM
	 k59t69Dd7I+Kw==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d0fd07ba8bso10001871fa.1;
        Thu, 15 Feb 2024 05:46:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV9BDzdJ7n5Zc7jEGTVWXQfsxIPOPyNBl8TiumsiHoAJcfcFmEnV9yld3xV8+JmiLkuUEZAsuXPWL/fIrbLzKssW2vBlSJgLV0kVIEGJ13F0D3/6habD6wGD8h4DzDtlYRpgXdQ0VaKEgzQ
X-Gm-Message-State: AOJu0YxGV99tLGgk5JCU5fmg3Qn5BHgzQd/yPAj2S3GMc4lgCaKOaqOP
	o7T1oPIpkT9ViNohoBDPcJwRwk5Etr9mTcb9pDkZkCdrbheo4xuCMjOU036bxWVUUTMDoFKI0J9
	QKGFrcXXh7jsRjDCEwm4m3JaZVO4=
X-Google-Smtp-Source: AGHT+IEPDgTVfE6n8NuJZecywYO55DsL8PoqcSUsAtURCL2uPlCNBearznnL+sdeqWtx7qqdi0aPwyxFBNhRobFnbpw=
X-Received: by 2002:a2e:9793:0:b0:2d0:ce22:516d with SMTP id
 y19-20020a2e9793000000b002d0ce22516dmr1499072lji.3.1708004767409; Thu, 15 Feb
 2024 05:46:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215083225.3976252-1-arnd@kernel.org>
In-Reply-To: <20240215083225.3976252-1-arnd@kernel.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Thu, 15 Feb 2024 22:45:31 +0900
X-Gmail-Original-Message-ID: <CAK7LNASK7xVc7nEF8wQ-ETwbpr1=UbmPWZbu9acBTXPtKkonmQ@mail.gmail.com>
Message-ID: <CAK7LNASK7xVc7nEF8wQ-ETwbpr1=UbmPWZbu9acBTXPtKkonmQ@mail.gmail.com>
Subject: Re: [PATCH] [v2] kallsyms: ignore ARMv4 thunks along with others
To: Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	=?UTF-8?Q?Pierre=2DCl=C3=A9ment_Tosi?= <ptosi@google.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Ard Biesheuvel <ardb@kernel.org>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 5:32=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> lld is now able to build ARMv4 and ARMv4T kernels, which means it can
> generate thunks for those (__ARMv4PILongThunk_*, __ARMv4PILongBXThunk_*)
> that can interfere with kallsyms table generation since they do not get
> ignore like the corresponding ARMv5+ ones are:
>
> Inconsistent kallsyms data
> Try "make KALLSYMS_EXTRA_PASS=3D1" as a workaround
>
> Replace the hardcoded list of thunk symbols with a more general regex tha=
t
> covers this one along with future symbols that follow the same pattern.
>
> Fixes: 5eb6e280432d ("ARM: 9289/1: Allow pre-ARMv5 builds with ld.lld 16.=
0.0 and newer")
> Fixes: efe6e3068067 ("kallsyms: fix nonconverging kallsyms table with lld=
")
> Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: use a regular expression instead of listing each one.


Applied to linux-kbuild/fixes.

Thanks.



> ---
>  scripts/mksysmap | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
>
> diff --git a/scripts/mksysmap b/scripts/mksysmap
> index 9ba1c9da0a40..57ff5656d566 100755
> --- a/scripts/mksysmap
> +++ b/scripts/mksysmap
> @@ -48,17 +48,8 @@ ${NM} -n ${1} | sed >${2} -e "
>  / __kvm_nvhe_\\$/d
>  / __kvm_nvhe_\.L/d
>
> -# arm64 lld
> -/ __AArch64ADRPThunk_/d
> -
> -# arm lld
> -/ __ARMV5PILongThunk_/d
> -/ __ARMV7PILongThunk_/d
> -/ __ThumbV7PILongThunk_/d
> -
> -# mips lld
> -/ __LA25Thunk_/d
> -/ __microLA25Thunk_/d
> +# lld arm/aarch64/mips thunks
> +/ __[[:alnum:]]*Thunk_/d
>
>  # CFI type identifiers
>  / __kcfi_typeid_/d
> --
> 2.39.2
>
>


--=20
Best Regards
Masahiro Yamada

