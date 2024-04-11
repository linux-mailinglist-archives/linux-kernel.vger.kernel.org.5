Return-Path: <linux-kernel+bounces-139961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 002388A09A0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C47A1C2137E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37F113E412;
	Thu, 11 Apr 2024 07:24:04 +0000 (UTC)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBBA13E3F8
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 07:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712820244; cv=none; b=uChOBu/S7Tltqgq0NtVp1zTHwcT8lwpSXHA1UQA6KvmWBGfcGE9GZZmg9qW8MjqLau2JT4EREMsgpC52T6qif3DuOu4cF2joqfPdSPHTmeAeVBiUDASCotUrLe0BTwHe8SCK9DI4LR9n9YHpGTI87/wux2h0NOU03f6+KGkrtzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712820244; c=relaxed/simple;
	bh=ENzsqCkEZF7w3w+dj2MlSXHDdkhowWbzZYt+sJi8kUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mK/Za6p6+258JTeabl12QD4WDv2O7XF7XXuZ2J7gztto7AuiPO2BxWTjvg13KG0V+bGUNCAAoOizZqs5yeTPTyQ/zPLMlf9mnOkpDoGNGOlge1Ur1jxotp64MAaSG/8Bwv+ujhLMaxXX700q/A43RwVHP0dVIoOrYHRJ66mcZcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-61587aa956eso71221937b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 00:24:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712820240; x=1713425040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DT9wpQertwUtJrUq+JoryAh7T5yA817K6uGSpPBNwoo=;
        b=vsKLEemDyQ0FIMOurDVLBHp52zZSqfG5QBP1CMJb+V8XYQEndI7G4WsbNUgbs67Bgj
         NobVefWIr0SD3C/PeNIpyWiO2jusSuZB0JRh0+OuAwhA5lmlnbULjYKtUPJ0STVGLpDd
         hXlrDMLCg1Cz+gtBWO4t6kAcK8AgG6e+Y4VB8QWnR9pswp4KjCHD1mzGDtKjS/fLHB4g
         cuh+THc0YQp2N9XSeOdAIWyb1M75dIMtrgjBVoL+eP/voMUtWL2kxD+g6HHt8kQ7sd+D
         5ICYbHIZ9198RaZv3Oujkk3iswXnoPQWkpsc34xbi1+CTf6P4syl1i8ZE1ND8Y6g5PsW
         sLzw==
X-Gm-Message-State: AOJu0YyyEs1gzIZPB+pVV/ssQUdmYhuVX5RYsPddiM/mMcFvqjc91YmB
	cgy6OFLkVZT+DJ9Q13AwlxwA+QYn107U533HdNHANggupjJPJMWymj4Xdwop
X-Google-Smtp-Source: AGHT+IFMZuIUyw3nCr55DwhxZVzM5Si66C68GE114CGyi+JnkDEaL9b45KHRwtt9dydPBQFttBgSWg==
X-Received: by 2002:a5b:3cd:0:b0:dc2:5553:ca12 with SMTP id t13-20020a5b03cd000000b00dc25553ca12mr4644197ybp.14.1712820240359;
        Thu, 11 Apr 2024 00:24:00 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id k12-20020a5b0a0c000000b00dcdba3056e9sm176652ybq.25.2024.04.11.00.23.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 00:23:59 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dde0b30ebe2so6425357276.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 00:23:59 -0700 (PDT)
X-Received: by 2002:a05:6902:149:b0:dcd:5e5d:4584 with SMTP id
 p9-20020a056902014900b00dcd5e5d4584mr4662119ybh.34.1712820239378; Thu, 11 Apr
 2024 00:23:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411032155.208042-1-ytcoode@gmail.com>
In-Reply-To: <20240411032155.208042-1-ytcoode@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 11 Apr 2024 09:23:47 +0200
X-Gmail-Original-Message-ID: <CAMuHMdULF9KemeFkv09s3b9T8Ka-AkC8A8-pc_FpdXnjrOjwgQ@mail.gmail.com>
Message-ID: <CAMuHMdULF9KemeFkv09s3b9T8Ka-AkC8A8-pc_FpdXnjrOjwgQ@mail.gmail.com>
Subject: Re: [PATCH] init/main.c: Fix potential static_command_line memory overflow
To: Yuntao Wang <ytcoode@gmail.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	"ndesaulniers@google.com" <ndesaulniers@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Krister Johansen <kjlx@templeofstupid.com>, 
	Arnd Bergmann <arnd@arndb.de>, Mike Rapoport <rppt@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

CC Hiramatsu-san

On Thu, Apr 11, 2024 at 5:25=E2=80=AFAM Yuntao Wang <ytcoode@gmail.com> wro=
te:
> We allocate memory of size 'xlen + strlen(boot_command_line) + 1' for
> static_command_line, but the strings copied into static_command_line are
> extra_command_line and command_line, rather than extra_command_line and
> boot_command_line.
>
> When strlen(command_line) > strlen(boot_command_line), static_command_lin=
e
> will overflow.
>
> Fixes: f5c7310ac73e ("init/main: add checks for the return value of membl=
ock_alloc*()")
> Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
> ---
>  init/main.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/init/main.c b/init/main.c
> index 2ca52474d0c3..a7b1f5f3e3b6 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -625,11 +625,13 @@ static void __init setup_command_line(char *command=
_line)
>         if (extra_init_args)
>                 ilen =3D strlen(extra_init_args) + 4; /* for " -- " */
>
> -       len =3D xlen + strlen(boot_command_line) + 1;
> +       len =3D xlen + strlen(boot_command_line) + ilen + 1;
>
> -       saved_command_line =3D memblock_alloc(len + ilen, SMP_CACHE_BYTES=
);
> +       saved_command_line =3D memblock_alloc(len, SMP_CACHE_BYTES);
>         if (!saved_command_line)
> -               panic("%s: Failed to allocate %zu bytes\n", __func__, len=
 + ilen);
> +               panic("%s: Failed to allocate %zu bytes\n", __func__, len=
);
> +
> +       len =3D xlen + strlen(command_line) + 1;
>
>         static_command_line =3D memblock_alloc(len, SMP_CACHE_BYTES);
>         if (!static_command_line)

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

