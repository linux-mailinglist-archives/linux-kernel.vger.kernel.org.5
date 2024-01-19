Return-Path: <linux-kernel+bounces-30776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F8183243D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 06:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99E131F23691
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 05:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9B3D520;
	Fri, 19 Jan 2024 05:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WwgkqIFI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4DDD2E0;
	Fri, 19 Jan 2024 05:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705642224; cv=none; b=qFlIByw9bGxEPNmWu4vWBV1cq9HpcIYoxdx754cX7jI1JhH8kucAazUFkGpxWpzSma8EtgRM97KS+BCRb1jO7dfBkEz6rNB7kL4cJo7z33xVD1HKMQum7V3mRK5r6uJluwDypJ3RboP+f4NO2F/tswwaGDHJ5Rc6cf8DJ5va00s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705642224; c=relaxed/simple;
	bh=NmRW0qDTinPAXASKC503X0xzvQnEs559g0EoVJTrYj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KUWq0jpg+sb99ZYFjgyzy/ZKd8Fn6oyykGwxqLMK0QmW/bH3FHpAXACK8w92wjkjaKymBnWxb6IEppl917L/Tj0AAKu8/kefj39dSFpRPB0A9mjbKfwdhLHxseC2I9ZG6x+ERtDJjn+6gwyZjcmiS50GhaRdX/2UGoQ3S62/a4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WwgkqIFI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16C84C43394;
	Fri, 19 Jan 2024 05:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705642224;
	bh=NmRW0qDTinPAXASKC503X0xzvQnEs559g0EoVJTrYj8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WwgkqIFI+U70JnAykdVxlfjbQUC8j12NSpnOBerRAYU10+jaeBFta7iR692U+mc+L
	 j9PqZegK1rXZjJ/aufQxqltWKQ24IjKMQA18e8pwwxdAQlSbAWhCTpQdD9LNVSMtGG
	 XCSGX4xs0wpMn3yhMQw8aN5OZyDzf0cvT9ZQyLONW5xBvDgHHnupO1qMrIfd52Dyr/
	 hmtxfsfmBQdlM6KdBHt0teA1R+udgjo0Dbe4orutR8xVbcWsyOqtuoE/I+yEyzU4aa
	 cF8SO4rwn532u9UupgyJ1v6/BewaqdQbuk6uQoJk/KB0Nql6Y+C+/M4cXHh4lCedKh
	 Mbawo6Z1sihlA==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2107f19e331so297935fac.3;
        Thu, 18 Jan 2024 21:30:24 -0800 (PST)
X-Gm-Message-State: AOJu0YzDYmuGzqOstfw8Z7nH5dFX2Uc+sCALkLpwAIZEFZ3dH1xW3dU/
	Rh0HBHc8pDwefQKZf9/5VqsW5ErcOQU/YjQX0cRXLgNNyclNSLl2y91JdZ5JcB2f+Sp0UklsCKM
	JfkIfq/xGg21//xdOR4HyGjfBduQ=
X-Google-Smtp-Source: AGHT+IF4bcbwZtibywMPkrWd7UBnetAIV9iyZyPDcz2l3nUG5Rkbj9MaDaPyDoZr0dFQajOR7bSQb8PYiOr1WsClNk4=
X-Received: by 2002:a05:6870:32d2:b0:210:bd4b:5db3 with SMTP id
 r18-20020a05687032d200b00210bd4b5db3mr2223943oac.111.1705642223463; Thu, 18
 Jan 2024 21:30:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118191727.5547-1-palmer@rivosinc.com>
In-Reply-To: <20240118191727.5547-1-palmer@rivosinc.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Fri, 19 Jan 2024 14:29:47 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQvGpf7zFR49-5TwE-mknGE_Kbw3JuQ+3Qf0dp+DvmSVA@mail.gmail.com>
Message-ID: <CAK7LNAQvGpf7zFR49-5TwE-mknGE_Kbw3JuQ+3Qf0dp+DvmSVA@mail.gmail.com>
Subject: Re: [PATCH] Makefile: Add HOST_GCC_SUFFIX and CROSS_GCC_SUFFIX
To: Palmer Dabbelt <palmer@rivosinc.com>
Cc: nicolas@fjasle.eu, nathan@kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 4:20=E2=80=AFAM Palmer Dabbelt <palmer@rivosinc.com=
> wrote:
>
> From: Palmer Dabbelt <palmer@rivosinc.com>
>
> I was just trying to track down a build bug with an old toolchain.
> Turns out Ubuntu installs old GCCs as something like
> riscv64-linux-gnu-gcc-10, which is a bit clunky to point the build at
> without a way to append a suffix to CC.


You can do:

make CROSS_COMPILE=3Driscv64-linux-gnu- CC=3Driscv64-linux-gnu-gcc-10





>
> There's already LLVM_SUFFIX, but nothing similar for GCC.  I've split
> out the host and target suffixes as users probably don't have the same
> version of for both (unlike LLVM, where the cross compiler is likely to
> support the host target).
>
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
> I've only given this some very minimal testing, but it at least works
> for my simple use case.
> ---
>  Makefile | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index f1b2fd977275..36ce336cda3b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -433,8 +433,8 @@ endif
>  HOSTCC =3D $(LLVM_PREFIX)clang$(LLVM_SUFFIX)
>  HOSTCXX        =3D $(LLVM_PREFIX)clang++$(LLVM_SUFFIX)
>  else
> -HOSTCC =3D gcc
> -HOSTCXX        =3D g++
> +HOSTCC =3D gcc$(HOST_GCC_SUFFIX)
> +HOSTCXX        =3D g++$(HOST_GCC_SUFFIX)
>  endif
>  HOSTRUSTC =3D rustc
>  HOSTPKG_CONFIG =3D pkg-config
> @@ -480,7 +480,7 @@ OBJDUMP             =3D $(LLVM_PREFIX)llvm-objdump$(L=
LVM_SUFFIX)
>  READELF                =3D $(LLVM_PREFIX)llvm-readelf$(LLVM_SUFFIX)
>  STRIP          =3D $(LLVM_PREFIX)llvm-strip$(LLVM_SUFFIX)
>  else
> -CC             =3D $(CROSS_COMPILE)gcc
> +CC             =3D $(CROSS_COMPILE)gcc$(CROSS_GCC_SUFFIX)
>  LD             =3D $(CROSS_COMPILE)ld
>  AR             =3D $(CROSS_COMPILE)ar
>  NM             =3D $(CROSS_COMPILE)nm
> --
> 2.43.0
>
>


--=20
Best Regards
Masahiro Yamada

