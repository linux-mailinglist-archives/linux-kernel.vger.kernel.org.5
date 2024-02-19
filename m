Return-Path: <linux-kernel+bounces-71086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 978A785A076
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F9DB28230D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DE625571;
	Mon, 19 Feb 2024 10:03:57 +0000 (UTC)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D6524B5B
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 10:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708337036; cv=none; b=urOXvUEqNc28RJ8ehKQqvGh2JyUmwCXyMiE9HVt/bv/6HrnBHkatYxZfHNwwwxDfgN0kVAwhOGvGHxtPLMyTdAKToL9F0frObkPYThzV3JOT1eBWlQQUPx8TcmZ/gqfRplZ5Ag/A3Pt+FGqEUtslSH5EXjUf0U8vtHiA+3aqNPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708337036; c=relaxed/simple;
	bh=93rSyyLAx+v2z24Dk6IhomyWwE3pWY8qHNCZVoVMURU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NHA7VoZA6yVWaEBlmIF5fKweiaAAYVdsF5E9OeEp6D2kb33y32c47J+9HXlBzDYnrR/gDeMTro4e/SydDB//JWRLsCtJZ8PASRDdjCZIpMir3Ar8svvtKw8WT3dN99JCgufsF6fWTDi4ApVoXdA9PM/souPU72iVaPwcjVbjsB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dcd94fb9e4dso4170019276.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 02:03:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708337033; x=1708941833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VV5IkoHFcPBX2CxuppX6oJjorcC+9NtTDlcFODx6elQ=;
        b=R135Ee0mAQEkCjqsobUUgLr/+Wn5M7xHYMPpijtI1AUwzIQtPpYBuWARpc/tzpu1BB
         1kk315XuTZmTttSAuBDRngnW+bOslHkhElXu+1ZCxvRYJ1oykMZUh9zbMZFtIdQb+Vfa
         MRiZwcxlmYrWJE4o/CrhPnfNxW1bxu+MQKvcsMGmM1eUusk8TqxPiScPxMBuBcKecpFK
         B1HCsCG90YouIX+U4nTK5fFQNLj2VFs2ENWmy5u2g7OthXnDP973Bi6YfejFKQUKb26q
         2/6GQFP7ombj0p/7OGVzseST4n/gOkaQryL1NUjTKG8+X2iKSk7Mw7R49oSPxfrLjAvY
         3htg==
X-Forwarded-Encrypted: i=1; AJvYcCXHfXVSEwzR0JghqoRX1vFCJRvQeuuzTFgRJbmrfmqnJswwrtJrCFsty3sM2QM4jEVHagHagc+l8hcaJPNbAcmVD32P1Afq3pA3te9O
X-Gm-Message-State: AOJu0YzaOkRIXnv+YeOt0w9pZzmHE33X+DyvD1MQ8VdsSSLA2T+e8o/K
	HkC71Yasxm0guHcEc9YyhZzCImsTPRJpknE8lMV6BkyREg4TecQlrirnX4PY13o=
X-Google-Smtp-Source: AGHT+IFnpmb0hwJRTvRJ7F4fCc1H3iyDRnzJRXDSqRspbXV0nyXtdi7IAqSUZwWyShT8EGWhsJQmOQ==
X-Received: by 2002:a25:5f4d:0:b0:dc7:4067:9f85 with SMTP id h13-20020a255f4d000000b00dc740679f85mr8736970ybm.58.1708337033141;
        Mon, 19 Feb 2024 02:03:53 -0800 (PST)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id p9-20020a257409000000b00dcdb990f93bsm1406389ybc.64.2024.02.19.02.03.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 02:03:52 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dcc80d6004bso4131277276.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 02:03:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU/zsclgYBZ8LhXq7VCXbB+6ScS8gCnQTCA4K+SLLNdfyXzXpoeIOaORrhY26ADjmtxMEYHptLNWqmozh5pKPs+hHVOjqYx1NKCEQ4S
X-Received: by 2002:a5b:e8e:0:b0:dce:2e9:a637 with SMTP id z14-20020a5b0e8e000000b00dce02e9a637mr8046146ybr.20.1708337032459;
 Mon, 19 Feb 2024 02:03:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206074552.541154-1-maskray@google.com>
In-Reply-To: <20240206074552.541154-1-maskray@google.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 19 Feb 2024 11:03:39 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVOoxVFohcwwoQtY0KgZEvbjgJJ6mib8Fabo97P0krEqw@mail.gmail.com>
Message-ID: <CAMuHMdVOoxVFohcwwoQtY0KgZEvbjgJJ6mib8Fabo97P0krEqw@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: jump_label: use constraints "Si" instead of "i"
To: Fangrui Song <maskray@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, Jisheng Zhang <jszhang@kernel.org>, 
	Dave Martin <Dave.Martin@arm.com>, Ard Biesheuvel <ardb@kernel.org>, Peter Smith <peter.smith@arm.com>, 
	llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Fangrui,

On Tue, Feb 6, 2024 at 8:46=E2=80=AFAM Fangrui Song <maskray@google.com> wr=
ote:
> The generic constraint "i" seems to be copied from x86 or arm (and with
> a redundant generic operand modifier "c"). It works with -fno-PIE but
> not with -fPIE/-fPIC in GCC's aarch64 port.

Thanks for your patch, which is now commit f9daab0ad01cf9d1 ("arm64:
jump_label: use constraints "Si" instead of "i"") in v6.8-rc5.

> The machine constraint "S", which denotes a symbol or label reference
> with a constant offset, supports PIC and has been available in GCC since
> 2012 and in Clang since 7.0. However, Clang before 19 does not support
> "S" on a symbol with a constant offset [1] (e.g.
> `static_key_false(&nf_hooks_needed[pf][hook])` in
> include/linux/netfilter.h), so we use "i" as a fallback.

https://gcc.gnu.org/releases.html says gcc-5 was released in 2015,
i.e. after 2012 ...

> Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Fangrui Song <maskray@google.com>
> Link: https://github.com/llvm/llvm-project/pull/80255 [1]
>
> ---
> Changes from
> arm64: jump_label: use constraint "S" instead of "i" (https://lore.kernel=
org/all/20240131065322.1126831-1-maskray@google.com/)
>
> * Use "Si" as Ard suggested to support Clang<19
> * Make branch a separate operand
>
> Changes from v1:
>
> * Use asmSymbolicName for readability

But it still fails on gcc-5:

    arch/arm64/include/asm/jump_label.h:25:2: error: invalid 'asm':
invalid operand
      asm goto(
      ^

http://kisskb.ellerman.id.au/kisskb/buildresult/15129281/

> --- a/arch/arm64/include/asm/jump_label.h
> +++ b/arch/arm64/include/asm/jump_label.h
> @@ -15,6 +15,10 @@
>
>  #define JUMP_LABEL_NOP_SIZE            AARCH64_INSN_SIZE
>
> +/*
> + * Prefer the constraint "S" to support PIC with GCC. Clang before 19 do=
es not
> + * support "S" on a symbol with a constant offset, so we use "i" as a fa=
llback.
> + */
>  static __always_inline bool arch_static_branch(struct static_key * const=
 key,
>                                                const bool branch)
>  {
> @@ -23,9 +27,9 @@ static __always_inline bool arch_static_branch(struct s=
tatic_key * const key,
>                  "      .pushsection    __jump_table, \"aw\"    \n\t"
>                  "      .align          3                       \n\t"
>                  "      .long           1b - ., %l[l_yes] - .   \n\t"
> -                "      .quad           %c0 - .                 \n\t"
> +                "      .quad           (%[key] - .) + %[bit0]  \n\t"
>                  "      .popsection                             \n\t"
> -                :  :  "i"(&((char *)key)[branch]) :  : l_yes);
> +                :  :  [key]"Si"(key), [bit0]"i"(branch) :  : l_yes);
>
>         return false;
>  l_yes:
> @@ -40,9 +44,9 @@ static __always_inline bool arch_static_branch_jump(str=
uct static_key * const ke
>                  "      .pushsection    __jump_table, \"aw\"    \n\t"
>                  "      .align          3                       \n\t"
>                  "      .long           1b - ., %l[l_yes] - .   \n\t"
> -                "      .quad           %c0 - .                 \n\t"
> +                "      .quad           (%[key] - .) + %[bit0]  \n\t"
>                  "      .popsection                             \n\t"
> -                :  :  "i"(&((char *)key)[branch]) :  : l_yes);
> +                :  :  [key]"Si"(key), [bit0]"i"(branch) :  : l_yes);
>
>         return false;
>  l_yes:

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

