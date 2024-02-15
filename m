Return-Path: <linux-kernel+bounces-66511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C062855DF3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1972B2CE25
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE6A168BA;
	Thu, 15 Feb 2024 09:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t8w8Dlyu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E7A13FFD;
	Thu, 15 Feb 2024 09:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707988683; cv=none; b=K/TBmW4y+Qbi3fJI0FtOiJJuxli/riUx6DkbNaOD6MGHNd5qzPulBrk0B1DS8HplJCRX/yDH/nxXTz3l0HxrkglLGu69+mHZbO/NQWVbNGsY0QScCK//6UgCCK7H/J+4eyg8Irenv3E0IIcKePsBn9FEpWC55T64OueFrUDpq0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707988683; c=relaxed/simple;
	bh=S/AjCC8VHzWj3sCL5RknpqlrVIJThGoN6o8cUNj0HAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oXNbun3Mw5LkIUI1Ox2q+Wv7qXLjJi9c0wns6p9UPo7mEHgrZ7TmlRoGT448j4NeCR/1eI7SPOBIR4QJMhIHjiuWZnGTiX+l2OAvdsmjT46QWpCEMbouMDGPgbuqrhBSY2cDd1QmtX0pEZuFuiuT6LyX4ANcbvFkSLvROOagc7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t8w8Dlyu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98718C43394;
	Thu, 15 Feb 2024 09:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707988682;
	bh=S/AjCC8VHzWj3sCL5RknpqlrVIJThGoN6o8cUNj0HAc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=t8w8Dlyunwadomn9EpttMUklIMkJAVSImls8uYNCN2KFOS7ng/VK2LR8RYdBlWTur
	 Z2EZoTC/fJe7fxlgMyDYV3j1EhWPAXyh1iVmxwhxMprb9MeRAJaKDhFFufyUu4nKW6
	 l76luLcslvses4IfnmeonRd01sS/sdv/DW/Q+FvQTk1AjVeHxK0Mp/DUUhVeEnrAc7
	 xBM8fW2luk8yxj+kjcbMSpDXJiip2wU+D9BAYnBZhT6/ejL/Fmo2QvRYfkhlU5u3+/
	 eDfcT3623TJuizH+FcloVUgsdE9iTY9SvPR4yq9l08URXLE7A/O9rVn/0xxI2QQaDt
	 WdsIS/nRyZiNA==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-511898b6c9eso745104e87.3;
        Thu, 15 Feb 2024 01:18:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXiRwa4MOVRg9tqJx/LKCBN+Eyy7bAMJpN348VXY7/xDbg0CKcZ3Qfxi0LFPqouAV3veW7D9dGkj0S4MXvKXLFulo6wTCixNBLK3uxvKOPnPKZOf2MH6LxtNqVYMYHQK0DwUAQVmrW+dskt
X-Gm-Message-State: AOJu0YxzxvBfJPfqTmcoiRJZQT5F0vmnKRKPVOLpzwUTocoJKWvPP9EU
	QNkDateeOAg7ySYBz6x8SkxTgXvChfk+AULztKX51VE4No0WVN/4mLWDVrPY0WlId9qIsqlsWME
	RsWSjOoqOiEYcB5e6qnXkIs7DtJE=
X-Google-Smtp-Source: AGHT+IEsMgiElptgTCNfGX2dKL2tYNf4Hhbc7w/ckQwW07j4ZbEqdCIUUZlE+vGLt1J/JAmNUWIICNnaJdmIV3XLc7I=
X-Received: by 2002:a05:6512:3c8a:b0:511:7211:2cdc with SMTP id
 h10-20020a0565123c8a00b0051172112cdcmr1182263lfv.10.1707988680836; Thu, 15
 Feb 2024 01:18:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215083225.3976252-1-arnd@kernel.org>
In-Reply-To: <20240215083225.3976252-1-arnd@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 15 Feb 2024 10:17:49 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGNdnbYVvnYFwmWMTk5rXjCeGWEEnLyXZdK=FBQGv-8dQ@mail.gmail.com>
Message-ID: <CAMj1kXGNdnbYVvnYFwmWMTk5rXjCeGWEEnLyXZdK=FBQGv-8dQ@mail.gmail.com>
Subject: Re: [PATCH] [v2] kallsyms: ignore ARMv4 thunks along with others
To: Arnd Bergmann <arnd@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	=?UTF-8?Q?Pierre=2DCl=C3=A9ment_Tosi?= <ptosi@google.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Feb 2024 at 09:32, Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> lld is now able to build ARMv4 and ARMv4T kernels, which means it can
> generate thunks for those (__ARMv4PILongThunk_*, __ARMv4PILongBXThunk_*)
> that can interfere with kallsyms table generation since they do not get
> ignore like the corresponding ARMv5+ ones are:
>
> Inconsistent kallsyms data
> Try "make KALLSYMS_EXTRA_PASS=1" as a workaround
>
> Replace the hardcoded list of thunk symbols with a more general regex that
> covers this one along with future symbols that follow the same pattern.
>
> Fixes: 5eb6e280432d ("ARM: 9289/1: Allow pre-ARMv5 builds with ld.lld 16.0.0 and newer")
> Fixes: efe6e3068067 ("kallsyms: fix nonconverging kallsyms table with lld")
> Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

> ---
> v2: use a regular expression instead of listing each one.
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

