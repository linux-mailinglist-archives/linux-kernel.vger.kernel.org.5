Return-Path: <linux-kernel+bounces-65941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3B1855412
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 21:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5829928BB77
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 20:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE101DDC1;
	Wed, 14 Feb 2024 20:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HtxsjtZw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1A013EFEF;
	Wed, 14 Feb 2024 20:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707942890; cv=none; b=SLEYpp27jwIwiSzPGAVU7HojnwnYXNC0SMdjnaSvXEYjuiBsQm5A/V8nTV+OzOtsCIpuIG6ye3mLLbM6+LF6kfAz5QnSzDtMOmkojut2iI33J/FKebX3kDtt5VlBTVrKXUgdH7qFzVXvg2eUHRNwm6tHbqOKax9CgqAKXYAUte0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707942890; c=relaxed/simple;
	bh=P2kJjSkr/XSrVwwzMl6mGCzNNt+BYcXwxik+kURqUJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ac5N3dC1QRe44j3XZv+61TPvPGMoyXPPYwsVq3hpzos4tnWYfp56VH/WHdNwXfoeO03bObqZx/0ghAWaPU+p5XinVMBvTOBgtc8HHVzsuixAF6zEMr81I+8yp7FcMxYt/3pCRyocyRbBw6i+Sr/TBXWXTshfVPnWnadtfbrJozE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HtxsjtZw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2797BC43399;
	Wed, 14 Feb 2024 20:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707942890;
	bh=P2kJjSkr/XSrVwwzMl6mGCzNNt+BYcXwxik+kURqUJU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HtxsjtZwVDTUpryvb2ETyAmr8hTrT94vKnK8XGAqonwRGyEQzzOt+Z7YY28oOxeTs
	 ndW4p3ncVAr07JnhSNi9FZYK6e+gJ8Vrpcg6qlGdRytfvQAFHiBJd+9got8uecWOS3
	 eLGZ1bDKog6Yj6UDo7KL8JxV9Sg1pCs7muJtFNma60XizjIbhyyaVr1qT9onkdPcWU
	 K7SrL9/IoRhnDj3tuMY6esVR1//PNU4+LNafDTyqsjz4tw/Anv/GfKSiAbqWHjTX9r
	 91ExN/BcN3B3nrOlOqNGYSjWwIWZTDjj5NCVBL03AwMWvb0TZ7+GAYa9vBCXilTZ70
	 Iq2YmNBdOkOmg==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d0c9967fdcso13752821fa.0;
        Wed, 14 Feb 2024 12:34:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUu/JaWIe060gGvetzUMMowICoI84KkNHGg9MlzaMiHCfXorHAvFnH71Bljd2bMFoqn+19S74z+FfS0hzo2cGMXDiewbfxdEqrhQkJik6X+XshDlpQ7GSUP/DIXewKlTESpVjwO7SA+DMxe
X-Gm-Message-State: AOJu0Yy/VewsLqfMQRVXRDytWblQDxNyaDEzCbHJ4Mi349GrKbxw0sze
	jYhd51pMEhm6M/d7MbLIf1G4gfChOI+ZkrWRY+SvlHDvHQ48+t3mmdTAb7uN63WAV7h5vMwM0oS
	qtcHY9+D5OBM6gUSNbYpknJ9rLZ4=
X-Google-Smtp-Source: AGHT+IGANuMGyrc8fuWek/gTc/bPksLylBWE+5+N0djMLAKcOlhM9fQDGDr+ZLG5VnSKsYRhnjnnQ8AT3uQOc/+dbKQ=
X-Received: by 2002:a05:6512:14e:b0:511:8e03:e0ba with SMTP id
 m14-20020a056512014e00b005118e03e0bamr1007802lfo.7.1707942888576; Wed, 14 Feb
 2024 12:34:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214181942.3562473-1-arnd@kernel.org>
In-Reply-To: <20240214181942.3562473-1-arnd@kernel.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Thu, 15 Feb 2024 05:34:11 +0900
X-Gmail-Original-Message-ID: <CAK7LNASQUhJGSdQiyEpc5Rpuk_hJwSCu=W=4JkL-Et_giFNvPg@mail.gmail.com>
Message-ID: <CAK7LNASQUhJGSdQiyEpc5Rpuk_hJwSCu=W=4JkL-Et_giFNvPg@mail.gmail.com>
Subject: Re: [PATCH] kallsyms: ignore ARMv4 thunks along with others
To: Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	=?UTF-8?Q?Pierre=2DCl=C3=A9ment_Tosi?= <ptosi@google.com>, 
	Ard Biesheuvel <ardb@kernel.org>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 3:19=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> lld is now able to build ARMv4 and ARMv4T kernels, which means it can gen=
erate
> thunks for those that can interfere with kallsyms table generation since
> they do not get ignore like the corresponding ARMv5+ ones are:
>
> Inconsistent kallsyms data
> Try "make KALLSYMS_EXTRA_PASS=3D1" as a workaround
>
> Add the missing symbols to the list of ignored symbol prefixes.
>
> Fixes: 5eb6e280432d ("ARM: 9289/1: Allow pre-ARMv5 builds with ld.lld 16.=
0.0 and newer")
> Fixes: efe6e3068067 ("kallsyms: fix nonconverging kallsyms table with lld=
")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  scripts/mksysmap | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/scripts/mksysmap b/scripts/mksysmap
> index 9ba1c9da0a40..c809bf592790 100755
> --- a/scripts/mksysmap
> +++ b/scripts/mksysmap
> @@ -52,6 +52,8 @@ ${NM} -n ${1} | sed >${2} -e "
>  / __AArch64ADRPThunk_/d
>
>  # arm lld
> +/ __ARMv4PILongThunk_/d
> +/ __ARMv4PILongBXThunk_/d
>  / __ARMV5PILongThunk_/d
>  / __ARMV7PILongThunk_/d
>  / __ThumbV7PILongThunk_/d
> --
> 2.39.2
>



If this is a recurring problem,
maybe is it better to use a regular expression?


Remove these lines:

# arm64 lld
/ __AArch64ADRPThunk_/d

# arm lld
/ __ARMV5PILongThunk_/d
/ __ARMV7PILongThunk_/d
/ __ThumbV7PILongThunk_/d

# mips lld
/ __LA25Thunk_/d
/ __microLA25Thunk_/d





Add this:

# lld
/ __[^[:space:]]*Thunk_/d





This pattern is only used in tooling,
but never in the kernel space.



$ git grep '__[^[:space:]]*Thunk_'
scripts/mksysmap:/ __AArch64ADRPThunk_/d
scripts/mksysmap:/ __ARMV5PILongThunk_/d
scripts/mksysmap:/ __ARMV7PILongThunk_/d
scripts/mksysmap:/ __ThumbV7PILongThunk_/d
scripts/mksysmap:/ __LA25Thunk_/d
scripts/mksysmap:/ __microLA25Thunk_/d
tools/perf/tests/vmlinux-kallsyms.c:            "__AArch64ADRPThunk_",
 /* arm64 lld */
tools/perf/tests/vmlinux-kallsyms.c:            "__ARMV5PILongThunk_",
 /* arm lld */
tools/perf/tests/vmlinux-kallsyms.c:            "__ARMV7PILongThunk_",
tools/perf/tests/vmlinux-kallsyms.c:            "__ThumbV7PILongThunk_",
tools/perf/tests/vmlinux-kallsyms.c:            "__LA25Thunk_",
 /* mips lld */
tools/perf/tests/vmlinux-kallsyms.c:            "__microLA25Thunk_",












--=20
Best Regards
Masahiro Yamada

