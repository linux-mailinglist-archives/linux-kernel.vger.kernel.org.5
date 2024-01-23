Return-Path: <linux-kernel+bounces-35285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E766838EFE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C84D28D822
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0482D5F572;
	Tue, 23 Jan 2024 12:54:43 +0000 (UTC)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F37F60DD3;
	Tue, 23 Jan 2024 12:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706014482; cv=none; b=MLkGGRSCccHV095eEX5zjN+VXdWE4pk3hKGGkq9zl9Qqkt8hX6NupEIMvcKiCJwpriGyD7OjXsxyZ5egMVhHELF5O8P2J5jbE5ryWQ7bXPnGUjWxWybNGz+SO85u+5ZWl3bbhbbYXan1xDeF+7UV504+HLJV2WserIlxNFhgydI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706014482; c=relaxed/simple;
	bh=oRU/RyjFvOO7wA+Xb77PQqteNh6Vj5WDQWTQdsu1fEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ngjf3nGaAcuzkvJCeF05ipJuEVScdVXp1wweDC38+DTcec+dBB5lQDzJTWzkMHDbxeklXywchip1FR524chFx/EoEnld1StTx2hBCcUanJqDznaBvque9lBcs33ULNlpYfAuidM9+MmI2XdW3iiw2v6NgmLxnjLiA5XvA3Sxp38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5f2d4aaa2fdso43470737b3.1;
        Tue, 23 Jan 2024 04:54:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706014479; x=1706619279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sHHavJJZellzhmUqcClWUg6SvALOrX1d3Nb7eJVRrKA=;
        b=cS2X+ap9caNeyDlre7H0wuQvDZUL6Ib+Zz6paiQCXTAm59e5t2EgQK2opFHrNN+urc
         QhYLCZq8t7sRdBHBTTYmKX0DKNltMcLszg06r2ZdKbuQGhZjvsyUiuxUjqrmu6fHqx0k
         uWyCn0wE+Ry92Gr5jNM/2WaJqVQ5CK63gLLqGxd18KolRb1XkD/fjgw3PAXQO3j57AIJ
         6lVOZK/8CN1tyOX+AzeyGv9QNnZqaab4TGvbndfKyIW4GVXAV0U3IxGSyWvyNfpTG8xm
         ppRdZVVmbVghwCdrY5+SkQBI990ijQwK4+yiy+gexYXa20LGPRg8gkR0TzGDPWRuTOJ7
         DS7A==
X-Gm-Message-State: AOJu0Yzvhs675GnhF6QlkVd3dA47GHfhpsr+sK2OBvjVnDI68rugKB5s
	61kBbP+ewXNfSPn1Rf5ivoRskEtTXd670TzP9cfO1ZRCqBUjspSQH7JWbIVLqyo=
X-Google-Smtp-Source: AGHT+IG84ZHI5letcdwzAQ72lTZQvGZrDld8iaHL6ITWPTBVsl4ON0KU73TfWsNn3ysHMa835ifMqA==
X-Received: by 2002:a0d:d7c1:0:b0:5ff:9fa1:7d3 with SMTP id z184-20020a0dd7c1000000b005ff9fa107d3mr4928215ywd.67.1706014479411;
        Tue, 23 Jan 2024 04:54:39 -0800 (PST)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id x199-20020a81a0d0000000b005ff8950ed82sm3958422ywg.38.2024.01.23.04.54.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 04:54:39 -0800 (PST)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5f2d4aaa2fdso43470587b3.1;
        Tue, 23 Jan 2024 04:54:39 -0800 (PST)
X-Received: by 2002:a81:7746:0:b0:5ff:7b0c:6993 with SMTP id
 s67-20020a817746000000b005ff7b0c6993mr4569351ywc.22.1706014478941; Tue, 23
 Jan 2024 04:54:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231125163559.824210-1-masahiroy@kernel.org>
In-Reply-To: <20231125163559.824210-1-masahiroy@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 23 Jan 2024 13:54:27 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWm6u1wX7efZQf=2XUAHascps76YQac6rdnQGhc8nop_Q@mail.gmail.com>
Message-ID: <CAMuHMdWm6u1wX7efZQf=2XUAHascps76YQac6rdnQGhc8nop_Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] kconfig: remove unneeded symbol_empty variable
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>, 
	Vegard Nossum <vegard.nossum@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yamada-san,

On Sat, Nov 25, 2023 at 5:36=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
> This is used only for initializing other variables.
>
> Use the empty string "".
>
> Please note newval.tri is unused for S_INT/HEX/STRING.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Thanks for your patch, which is now commit 4e244c10eab345a7
("kconfig: remove unneeded symbol_empty variable") in v6.8-rc1.

When running "make <foo>_defconfig" with <foo>_defconfig an SMP
defconfig without explicit configuration of CONFIG_LOG_CPU_MAX_BUF_SHIFT,
the aforementioned commit causes a change in the generated .config:

-CONFIG_LOG_CPU_MAX_BUF_SHIFT=3D12
+CONFIG_LOG_CPU_MAX_BUF_SHIFT=3D0

It looks like CONFIG_BASE_SMALL=3D0 is treated as a string instead of
the integer number zero?

init/Kconfig=3Dconfig LOG_CPU_MAX_BUF_SHIFT
init/Kconfig-   int "CPU kernel log buffer size contribution (13 =3D> 8
KB, 17 =3D> 128KB)"
init/Kconfig-   depends on SMP
init/Kconfig-   range 0 21
init/Kconfig:   default 12 if !BASE_SMALL
init/Kconfig:   default 0 if BASE_SMALL

Note that reverting 4e244c10eab345a7 is not sufficient to fix the issue.
Also reverting commit 6262afa10ef7cc8f ("kconfig: default to zero if
int/hex symbol lacks default property") does fix it.

Thanks!

> --- a/scripts/kconfig/symbol.c
> +++ b/scripts/kconfig/symbol.c
> @@ -29,12 +29,6 @@ struct symbol symbol_no =3D {
>         .flags =3D SYMBOL_CONST|SYMBOL_VALID,
>  };
>
> -static struct symbol symbol_empty =3D {
> -       .name =3D "",
> -       .curr =3D { "", no },
> -       .flags =3D SYMBOL_VALID,
> -};
> -
>  struct symbol *modules_sym;
>  static tristate modules_val;
>
> @@ -346,7 +340,7 @@ void sym_calc_value(struct symbol *sym)
>         case S_INT:
>         case S_HEX:
>         case S_STRING:
> -               newval =3D symbol_empty.curr;
> +               newval.val =3D "";
>                 break;
>         case S_BOOLEAN:
>         case S_TRISTATE:
> @@ -697,13 +691,12 @@ const char *sym_get_string_default(struct symbol *s=
ym)
>  {
>         struct property *prop;
>         struct symbol *ds;
> -       const char *str;
> +       const char *str =3D "";
>         tristate val;
>
>         sym_calc_visibility(sym);
>         sym_calc_value(modules_sym);
>         val =3D symbol_no.curr.tri;
> -       str =3D symbol_empty.curr.val;
>
>         /* If symbol has a default value look it up */
>         prop =3D sym_get_default_prop(sym);

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

