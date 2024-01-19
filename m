Return-Path: <linux-kernel+bounces-30924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E35C58325F7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 09:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E97BB21526
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 08:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2161E89A;
	Fri, 19 Jan 2024 08:49:06 +0000 (UTC)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21F51DDC3;
	Fri, 19 Jan 2024 08:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705654146; cv=none; b=gUXJINSlbzaDGUUFKE7zsDcsbECzswNjaMJbHiZRgbcsbR4549ZP6mXCDiIE19xf0vUsufNYZahDDPSjPTLHB2S8GCPSfc24Wh3J7z8s3B8X5Hl4U/K6oCo6NdQ5TYFeXVX8GoRH/YLregnRZJpZEqn0M5JSqe1huoOn/FXuugw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705654146; c=relaxed/simple;
	bh=0vDqqbSPjdG8YAjX7NEPsVe2bnMz0qg8yYJ86Xx1h2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jfninPZLHvpOVSD1Wtjl6pQRXxmk05b/byZJue/f885B7kP3Fztp3AZZ2l89REP+frqI4KH89RywqbtFEJw4B+oRHWL7WdNMdRVzYbVDTKsZWOQslNz69COE3et5vlZ8+RJYs9Eje4iW4jUSNXvuYD13MjOqNcPPplOd/8gqEtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5e54d40cca2so3926497b3.3;
        Fri, 19 Jan 2024 00:49:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705654143; x=1706258943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CK5yfJWxCkl7yJu3dTmH5fov2DfpFNp25spOIpb6UyE=;
        b=bjdFgBTJ7bP49xNTb5iaQYEZtmEneqW/Zw31tGcu4accObbrs25INYIsfV4UxUGJnY
         DtKpJwL0+Zs1WTlT4Ol03vOb0vGf/Wy6V9/CtaR9GhCjttxwNPYqBlt74O4bUd5p82Gb
         CsxlyG3nzgSKFH5Ab593r60X8QRlYfkpI/uu5pk/yhKs02Wk9UWaMA9ZMD8RhCb9Q1f9
         qTTvSHZyVYTEwxGKufKS+8pV057qFzmSdAsyxftr/Fh6oDYQXiCdxsosyB3VjeVY3giH
         tSXhSjzuYQbgQ/Tqdq93Al5i0GXeGcvw5XrAJQA19eGkOfYwx0TkkPU4AWzUoj3IgGR4
         PZaw==
X-Gm-Message-State: AOJu0YzPpR7ztwzNmiHNof+RkTLPu1c+IwL0vh7dhgyDSypsmUinzUCT
	clzxOSKOv4VUmZyiRZ2vGVtGTa5g6g+qUMttXOexpAJixywu+JmISUVo7KZHiso=
X-Google-Smtp-Source: AGHT+IEdSPp9QlhDsVZ2Kz7YPEpWTnzDNk8wFqLvE9cA46lIQoKN26j5u0rM6JokUIgreOEvjUvLZg==
X-Received: by 2002:a0d:d754:0:b0:5ff:8551:ab52 with SMTP id z81-20020a0dd754000000b005ff8551ab52mr1702541ywd.46.1705654141815;
        Fri, 19 Jan 2024 00:49:01 -0800 (PST)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id x65-20020a0dd544000000b005ff7cda85c5sm1475452ywd.69.2024.01.19.00.48.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jan 2024 00:48:59 -0800 (PST)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5ff7dc53ce0so4210637b3.1;
        Fri, 19 Jan 2024 00:48:59 -0800 (PST)
X-Received: by 2002:a81:6f04:0:b0:5ff:6c4d:fe34 with SMTP id
 k4-20020a816f04000000b005ff6c4dfe34mr1648495ywc.48.1705654138786; Fri, 19 Jan
 2024 00:48:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231203192422.539300-1-yury.norov@gmail.com> <20231203193307.542794-1-yury.norov@gmail.com>
 <20231203193307.542794-34-yury.norov@gmail.com>
In-Reply-To: <20231203193307.542794-34-yury.norov@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 19 Jan 2024 09:48:47 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWHxesM-EOOMtrrw3Caz+5Wux35QiKOjvwA=vwQpRe26Q@mail.gmail.com>
Message-ID: <CAMuHMdWHxesM-EOOMtrrw3Caz+5Wux35QiKOjvwA=vwQpRe26Q@mail.gmail.com>
Subject: Re: [PATCH v2 35/35] sh: mach-x3proto: rework ilsel_enable()
To: Yury Norov <yury.norov@gmail.com>
Cc: linux-kernel@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, linux-sh@vger.kernel.org, 
	Jan Kara <jack@suse.cz>, Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>, 
	Matthew Wilcox <willy@infradead.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>, Alexey Klimov <klimov.linux@gmail.com>, 
	Bart Van Assche <bvanassche@acm.org>, Sergey Shtylyov <s.shtylyov@omp.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 3, 2023 at 8:34=E2=80=AFPM Yury Norov <yury.norov@gmail.com> wr=
ote:
> Fix opencoded find_and_set_bit(), which also suppresses potential
> KCSAN warning.
>
> CC: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Signed-off-by: Yury Norov <yury.norov@gmail.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/arch/sh/boards/mach-x3proto/ilsel.c
> +++ b/arch/sh/boards/mach-x3proto/ilsel.c
> @@ -99,8 +99,8 @@ int ilsel_enable(ilsel_source_t set)
>         }
>
>         do {
> -               bit =3D find_first_zero_bit(&ilsel_level_map, ILSEL_LEVEL=
S);
> -       } while (test_and_set_bit(bit, &ilsel_level_map));
> +               bit =3D find_and_set_bit(&ilsel_level_map, ILSEL_LEVELS);
> +       } while (bit >=3D ILSEL_LEVELS);
>
>         __ilsel_enable(set, bit);

BTW, I don't think the old code worked as intended: the first time no
free bit is found, bit would have been ILSEL_LEVELS, and
test_and_set_bit() would have returned false, thus terminating the loop,
and continuing with an out-of-range bit value?  Hence to work correctly,
bit ILSEL_LEVELS of ilsel_level_map should have been initialized to one?
Or am I missing something?

The new code does not have that issue.

Anyway, this should probably never happen in real life.

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

