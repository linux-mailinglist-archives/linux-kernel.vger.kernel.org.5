Return-Path: <linux-kernel+bounces-52656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 795FF849B17
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC9711C20CAD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB03B2D627;
	Mon,  5 Feb 2024 12:49:08 +0000 (UTC)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BD54D9F0;
	Mon,  5 Feb 2024 12:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707137348; cv=none; b=is3KKdaJwjKrJDmF6Z3uXfNkhh+m6D3fQMWoR7sVR7h9g0DybBkSCiBKC/lWkxI/caitK4CkW/BLdv0aROVjNLUwO+XGauRDokStF6SKIl6EZ+D96YGLo24rfvRASP5sTlqlortnRbnTcfYZPlfnlV0L7/lTAk063P7iitB6r/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707137348; c=relaxed/simple;
	bh=4bokwz6jGBGKlGdnLCCGFSyuEsK1Mv6ydir3+hlmFiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NdNKGJC4n+Fi8juVwrWxxEZPL68ecpxZ4OPtAEGsQKh+tSRGCgXPdQVrX6ckBMQboeoDDnRqDM9LVbPGDc4r7pA3aXTMkLexo89nX6NFIt4yAmOCjWjzJB6gzDhJEFa6BG3N+WtnZB8xCUTzs08jx3vh+psH9NEq7NU1UzMmq2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-604059403e9so42820947b3.3;
        Mon, 05 Feb 2024 04:49:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707137344; x=1707742144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4RVwKzZH65GNl+QMR7mj3Tovr3dTIgpY6fWgtghHpZI=;
        b=Rf87MUz9u829fn+WRiC4NnMxnlIxVXwDNb8E0JGy93kP24wd8i2og0Z/Ma/AdOjq4p
         oRo6NVnpL3v4flctN2AwXexT6U8ULs7UuM6T84HOds7RItezq6qkX23aGF++5SkrNueD
         IA4NWurfJyDuqi99RP9uFp5QaDMjtxrWnRRZwdXLz9li1rhMAiewqkBnyIJBRknIJCTO
         fCdEwi5Ga3DdnYS+ROipgz60Zxl7eM/raWoFew71BOPG1vQrO4Fd7lCBVSR5CohEkr0q
         Ygi1r8uIVuf7rGNITHC0PjhRMU1l0YAj44KI7IZ5+yKVGUB2L/FFy6+/eitlGcAsqepc
         9d0A==
X-Gm-Message-State: AOJu0YwsbhJH71AHvA0UyIcXmdpKRPdKyB1Ejg4v1g6p4swc9Ry9usAh
	mHkf3otLwUuGptDgsxd8DJhEsCwN2A3fmbzVe36QE6JtLLvn4CA+cN+PIMYMIIc=
X-Google-Smtp-Source: AGHT+IF4Z8ftRAROhPU/ESDLesjR8Nf7C8Ylzy6dgFUUVFzL46mlwjRY/PGUEg8bRvgE4n2lyeCL0w==
X-Received: by 2002:a81:ac21:0:b0:603:d575:e2e8 with SMTP id k33-20020a81ac21000000b00603d575e2e8mr12238729ywh.10.1707137344369;
        Mon, 05 Feb 2024 04:49:04 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXVbmhlnCDPWMUrJA25RbYf/NGVJlrPl2sXbWDfnTVgnb3K+eBGamQO2Qo7pGa7ZxxJI8LfRd9KzA1dzjzw6Z++SBMGcoUJ6h+nhfvEWqpoC1/PRlbL8KLRaY9or9vjiobAmxiUt57zN/fCfCEL
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id t192-20020a8183c9000000b006040f99d7c2sm1973414ywf.71.2024.02.05.04.49.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 04:49:03 -0800 (PST)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6045db1b5a1so8474727b3.2;
        Mon, 05 Feb 2024 04:49:03 -0800 (PST)
X-Received: by 2002:a0d:ea85:0:b0:5ff:7cdc:404b with SMTP id
 t127-20020a0dea85000000b005ff7cdc404bmr10903850ywe.52.1707137343380; Mon, 05
 Feb 2024 04:49:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205122916.it.909-kees@kernel.org> <20240205123525.1379299-3-keescook@chromium.org>
In-Reply-To: <20240205123525.1379299-3-keescook@chromium.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 5 Feb 2024 13:48:51 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXnW0ycz4y0m6d2yb_cAB4pjLmpveVBnL4sLNATtm388A@mail.gmail.com>
Message-ID: <CAMuHMdXnW0ycz4y0m6d2yb_cAB4pjLmpveVBnL4sLNATtm388A@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] string: Allow 2-argument strscpy_pad()
To: Kees Cook <keescook@chromium.org>
Cc: Andy Shevchenko <andy@kernel.org>, linux-hardening@vger.kernel.org, 
	Richard Weinberger <richard@nod.at>, Justin Stitt <justinstitt@google.com>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jason Wang <jasowang@redhat.com>, 
	kernel test robot <lkp@intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Azeem Shaikh <azeemshaikh38@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kees,

On Mon, Feb 5, 2024 at 1:36=E2=80=AFPM Kees Cook <keescook@chromium.org> wr=
ote:
> Similar to strscpy(), update strscpy_pad()'s 3rd argument to be
> optional when the destination is a compile-time known size array.
>
> Cc: Andy Shevchenko <andy@kernel.org>
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Thanks for your patch!

> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -78,6 +78,10 @@ ssize_t sized_strscpy(char *, const char *, size_t);
>         sized_strscpy(dst, src, sizeof(dst) + __must_be_array(dst))
>  #define __strscpy1(dst, src, size)     sized_strscpy(dst, src, size)
>
> +#define __strscpy_pad0(dst, src, ...)  \
> +       sized_strscpy_pad(dst, src, sizeof(dst) + __must_be_array(dst))
> +#define __strscpy_pad1(dst, src, size) sized_strscpy_pad(dst, src, size)

(dst) etc.

> @@ -123,17 +139,8 @@ ssize_t sized_strscpy(char *, const char *, size_t);
>   * * The number of characters copied (not including the trailing %NULs)
>   * * -E2BIG if count is 0 or @src was truncated.
>   */
> -#define strscpy_pad(dest, src, count)  ({                      \
> -       char *__dst =3D (dest);                                          =
 \
> -       const char *__src =3D (src);                                     =
 \
> -       const size_t __count =3D (count);                                =
 \
> -       ssize_t __wrote;                                                \
> -                                                                       \
> -       __wrote =3D strscpy(__dst, __src, __count);                      =
 \
> -       if (__wrote >=3D 0 && __wrote < __count)                         =
 \
> -               memset(__dst + __wrote + 1, 0, __count - __wrote - 1);  \
> -       __wrote;                                                        \
> -})
> +#define strscpy_pad(dst, src, ...)     \
> +       CONCATENATE(__strscpy_pad, COUNT_ARGS(__VA_ARGS__))(dst, src, __V=
A_ARGS__)

Likewise,

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

