Return-Path: <linux-kernel+bounces-111308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFC6886A7C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2664B2821DD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4633B788;
	Fri, 22 Mar 2024 10:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2g8VMCz"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F351B27A
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 10:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711103867; cv=none; b=ePwctp7YuST91O8zcb+09qqAxrGYvlCFljQrtj4/g8rpkeCy5kgXlM7BJp6xq8KAqg7ywo39YiBf5Qes4+fmZybontc3d/5N5e0vWvwMWqz9wdQb2JyEBpMYCY5+yWABhXXcarpg8VR2YiruKr/IyVaPoEPqLqUOteKE2QqdPAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711103867; c=relaxed/simple;
	bh=YmMmzTP5sEliQAuVtL+b69GSSc0NChxk6+wzqofcPa0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=piSuULARw+Az4+kUyNSTOPXTPcITwNkhEavY9/ZaixmUm8eEGWtM55JHe0ct6nplZEvcuxWz9AR8yKDAbJe+wtinajsR8jhO6vhFwWvSWD6dDh+VBpHXxcJvRvJK7yYGEezsIo/QNr0CSMmE1mEPcUY91g5BuMSFft8YThe+eo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e2g8VMCz; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d6a1af9c07so25066161fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 03:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711103863; x=1711708663; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ujeXQVZlqkAEO2jQ0BQIGNpnRJc8dlqa+QZaizT8Zl8=;
        b=e2g8VMCzheB60EdlO+BKXO8FEhEtPiIuM3U0cgSnKXtvo+AfSBeq8s8BqCTvPcpwHH
         0hh4J+J3P8UIVWXPTn68Ier4q+Bjj2HFfWH00OrXXgib2rArw2QWeDZLS5H237GdQMwJ
         jugWDiOHCUSQ76naT3qsZpPh6lsgAh3qrGu35XxVQRpkqy4hLUvpweY1kp5qq4xglnc8
         fx/8rQ/QSDIiKbqDB76mSbJXpd6yHalzdM7M9uJ8o0N8pcPpxTI4dfpimGNT+A7MAVSM
         QDwa+g/MigTY8E1xOUN+4KwZ2is3rOhAiZZfzxWeyYApBIEOAZV5RK8U1akUfzc/Qbn+
         GpkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711103863; x=1711708663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ujeXQVZlqkAEO2jQ0BQIGNpnRJc8dlqa+QZaizT8Zl8=;
        b=HrIp48/tcmcYixKkZhsGLJ2Hx/jgGEdXOFhD4AEVkYDfpGYDqUkserZCLH2XxR2Swf
         79Nux1RIeoBUs1UiX/O4Y4gACrfmlN/CzWP8GJiqDjGKdb8tTkzbh4jheN8AFIwaUa20
         d2NAypXpla539TsaW8WLSNmXdcwijdsemu7I5hrnc6E/7TgnffqRCf2j+Rc0y5tXLA4w
         B3WGTdnt9Yt97O9KPYv+pcAAwaaFx6asLNTDEOGS6+LZ5P5iG+EQrQQQu4Fp91PrzI0a
         GsruSj24FKR4rIhO0FpRcpQs866OkttY+AxR3rBCVKIvWCm6hkgyCGSTz/iuJOq3uYkG
         7hyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUH/+cKFS5ZLeKA8uUGW3SIkZYGSHiOCj3ERohkEf2snOR7agkT67apCqztMWaobgyrsMHNP/OIlGa1XC0AJBuUuNRA2tgppTlIbLs+
X-Gm-Message-State: AOJu0YzPKlCb1mfatwxEI522SQlM3hLb7IpImO7c74Ocu/YPpoX6DLCz
	RDnrq/geImss5eVo/6WAhsxv5jo6wX+rb3oUZS2t9NNB+KgyCrXxPeB32HB8biHlaUaDou1nMyU
	zhnj4AChHOxXf0tkkNeEfa1JtcH1W7i/4gh9aUg==
X-Google-Smtp-Source: AGHT+IGsDAX6ze46fTACf+vr28aDtyjTiuo4JLI8NCBouzRLbljjL4OOYrYNNjzfjqSc7ezXQr9eV5pJJ+RprlKEARY=
X-Received: by 2002:a2e:6e11:0:b0:2d2:af88:8947 with SMTP id
 j17-20020a2e6e11000000b002d2af888947mr1357524ljc.15.1711103863181; Fri, 22
 Mar 2024 03:37:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314165715.31831-1-adobriyan@gmail.com>
In-Reply-To: <20240314165715.31831-1-adobriyan@gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Fri, 22 Mar 2024 11:37:31 +0100
Message-ID: <CAFULd4YrDiu7zUdZXRkLNiN=6zC4hPWchymrbMA=ag3qG+OarA@mail.gmail.com>
Subject: Re: [PATCH 1/1] x86_64: cleanup memset16(), memset32(), memset64()
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, linux-kernel@vger.kernel.org, 
	hpa@zytor.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 11:05=E2=80=AFAM Alexey Dobriyan <adobriyan@gmail.c=
om> wrote:
>
> * use "+" constraint modifier,
>   simplify inputs and output lists,
>   delete dummy variables with meaningless names,
>
>   "&" only makes sense in complex assembly creating constraints on
>   intermediate registers. But 1 instruction assemblies don't have
>   inner body so to speak.
>
> * write "rep stos*" on one line:
>   Rep prefix is integral part of x86 instruction. I'm not sure why
>   people separate "rep" with newline or semicolon pretending rep is
>   separate instruction. It is not and never was.

The reason for this was that some archaic assemblers rejected "rep
insn" on one line. I have checked that the minimum required
binutils-2.25 assembles this without problems.

> * use __auto_type for maximum copy pasta experience,
>
> * reformat a bit to make everything looks nicer.
>
> Note that "memory" clobber is too much if "n" is known at compile time.
> However,
>
>         "=3Dm" (*(T(*)[n])s)
>
> doesn't work because -Wvla even if "n" is compile time constant:
>
>         if (BCP(n)) {
>                 rep stos
>                 : "=3Dm" (*(T(*)[n])s)
>         } else {
>                 rep stosw
>                 : "memory"
>         }
>
> The above doesn't work.
>
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

Reviewed-by: Uros Bizjak <ubizjak@gmail.com>

> ---
>  arch/x86/include/asm/string_64.h | 45 +++++++++++++++++---------------
>  1 file changed, 24 insertions(+), 21 deletions(-)
>
> diff --git a/arch/x86/include/asm/string_64.h b/arch/x86/include/asm/stri=
ng_64.h
> index 857d364b9888..9d0b324eab21 100644
> --- a/arch/x86/include/asm/string_64.h
> +++ b/arch/x86/include/asm/string_64.h
> @@ -30,37 +30,40 @@ void *__memset(void *s, int c, size_t n);
>  #define __HAVE_ARCH_MEMSET16
>  static inline void *memset16(uint16_t *s, uint16_t v, size_t n)
>  {
> -       long d0, d1;
> -       asm volatile("rep\n\t"
> -                    "stosw"
> -                    : "=3D&c" (d0), "=3D&D" (d1)
> -                    : "a" (v), "1" (s), "0" (n)
> -                    : "memory");
> -       return s;
> +       const __auto_type s0 =3D s;
> +       asm volatile (
> +               "rep stosw"
> +               : "+D" (s), "+c" (n)
> +               : "a" (v)
> +               : "memory"
> +       );
> +       return s0;
>  }
>
>  #define __HAVE_ARCH_MEMSET32
>  static inline void *memset32(uint32_t *s, uint32_t v, size_t n)
>  {
> -       long d0, d1;
> -       asm volatile("rep\n\t"
> -                    "stosl"
> -                    : "=3D&c" (d0), "=3D&D" (d1)
> -                    : "a" (v), "1" (s), "0" (n)
> -                    : "memory");
> -       return s;
> +       const __auto_type s0 =3D s;
> +       asm volatile (
> +               "rep stosl"
> +               : "+D" (s), "+c" (n)
> +               : "a" (v)
> +               : "memory"
> +       );
> +       return s0;
>  }
>
>  #define __HAVE_ARCH_MEMSET64
>  static inline void *memset64(uint64_t *s, uint64_t v, size_t n)
>  {
> -       long d0, d1;
> -       asm volatile("rep\n\t"
> -                    "stosq"
> -                    : "=3D&c" (d0), "=3D&D" (d1)
> -                    : "a" (v), "1" (s), "0" (n)
> -                    : "memory");
> -       return s;
> +       const __auto_type s0 =3D s;
> +       asm volatile (
> +               "rep stosq"
> +               : "+D" (s), "+c" (n)
> +               : "a" (v)
> +               : "memory"
> +       );
> +       return s0;
>  }
>  #endif
>
> --
> 2.43.2
>

