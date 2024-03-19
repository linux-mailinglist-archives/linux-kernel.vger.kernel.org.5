Return-Path: <linux-kernel+bounces-107219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D33F87F96D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F4AC1F22741
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930A87BAFE;
	Tue, 19 Mar 2024 08:21:37 +0000 (UTC)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584995916D;
	Tue, 19 Mar 2024 08:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710836497; cv=none; b=QxqtB1rpF7DMurhOWlQ4Cd2tmwb0bjvNJkspS2nDF2rsTMo9gr3c5jq5ss+s84A0ga0MJ6BxwikZ5ri0UNSNwQYTlakqrQXcgfZArxGHU/MAE7OMNQUxlmcywEvYNhclh7utkVgzzAYW7cAq37kl6ByDlAbsc7B6uhk7gqRPZns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710836497; c=relaxed/simple;
	bh=1l+VsDLetr19MqFbcaBSq5IeLD1NWkokl+Ro9XgvyMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UFiRYVrJDuVtWkuPcfX+oU6y1MzvcoAeZNag4X5ONICPKzh5arQXQ5rvvzwQCN4xsXi027mJqFktMfUwFDO6bs2CKj3uMpAbEX56RAmM0xfcvMY+ATrnZ7D9IT86VIFgeKhDsSf69lQMWrgAP750IjdadImDqom4n7GlXT79Qjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-609fb0450d8so55705947b3.0;
        Tue, 19 Mar 2024 01:21:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710836494; x=1711441294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sk6uoSSGwlcUK6y2ntn66lixyi761tGP06lmI4gJ/mE=;
        b=WY7wiYr6FB1X2gKhM+LxjJSXrQU6RoUuMU1PnQYRLyCEqeMUZvKxsde9YNy6A6tMhq
         g0cAKoAC3aMuoS47vhbumLOXzpYYgccKWLRvOSG7LsdFgllMJp7DqR1jPPcMN/KzChAh
         gQR7nIsZh3mbfJk+2yWMq3/KSD6cynnnf082lmFNA0cPXJm72seus6QtxG7mwKVA/tsK
         Tz+uUEhiqc7Mz7Sv6XwVJSgSsEQIKBv+DUQUXt+OU31jsoyg55np5CEL05jzsI6UbVRE
         tpp5bA/bKD1kYIQEv1MehBE22otKB9QsZEHc+w590Kr9ifVSjzld1rtlJd3eiDJtIIjV
         W4+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUIow7+fTqvaGD9GmJmUTCqsoylyn2MJwvaMBh0/wQclBjfpTWqtGRqu68k6ZM4wVk2pevuaiSVojlkMHzWCJy4f1mrGbtpbUyLsmF5LYnRmugKrQyKOV3hVEUdGn2/Q3pMZaC7d3IdODKYK6Akk5SmNPn3Nciib3i9GLzB270YscCWPl2ib8HWqXem3mWTV4BoGVxWZYVvRDVW11nXIHECasZ5R+du4GZ2
X-Gm-Message-State: AOJu0YxQM24v1uD7kiuzjUSmTW8qtcTU07T4GixWHJ3gP6BJKittGPCF
	XzeGElbdQC3YE3rjGOHuRPlFbmCoR4KarUjQOh/FZ3KD0PDq78yR6VwjPY6kauY=
X-Google-Smtp-Source: AGHT+IGbqEnN9U4PLxGxrJsILv2O2f+wvA0LyA3SOdihrpg449tLji2C99MseNcFTbS1lty6KtkVmA==
X-Received: by 2002:a81:7185:0:b0:609:fd5f:bcf4 with SMTP id m127-20020a817185000000b00609fd5fbcf4mr2023577ywc.24.1710836494019;
        Tue, 19 Mar 2024 01:21:34 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id b12-20020a0dd90c000000b0060a5795fde5sm2301743ywe.98.2024.03.19.01.21.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 01:21:20 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-60a057b6601so51932617b3.2;
        Tue, 19 Mar 2024 01:21:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWCDfms/3cKzJVDkg72tA4hNxeb9UNnMp/pdek+CGyJGk+jN2rE9OO3EN9glDcxBFQOVh5hQhd2ZgUqnt5C5KzHeXWRKLi1fmhT1Utk/1h+2UoBd7VRfGVT9v8HiiPsstWdVjXhkbVe/2ZlT0y5YCmHl0NFDmAsfyMbe07P5D6CJLK8+rAvNAyvqucFMJAtszICfqDxaOUXR+ItD4qszJjlsJrId9GyeVN2
X-Received: by 2002:a25:e089:0:b0:dc6:c617:7ca with SMTP id
 x131-20020a25e089000000b00dc6c61707camr1281456ybg.29.1710836480016; Tue, 19
 Mar 2024 01:21:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318172102.45549-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20240318172102.45549-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240318172102.45549-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 19 Mar 2024 09:21:08 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVR=t+QW+kqh3HswJ_8T2Dos381VL8vJvdqiC4RZDRRZw@mail.gmail.com>
Message-ID: <CAMuHMdVR=t+QW+kqh3HswJ_8T2Dos381VL8vJvdqiC4RZDRRZw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] serial: sh-sci: Add support for RZ/V2H(P) SoC
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Prabhakar,

On Mon, Mar 18, 2024 at 6:22=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail.c=
om> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Add serial support for RZ/V2H(P) SoC with earlycon.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v2 - > v3
> - new patch

Thanks for your patch!

> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -290,7 +290,7 @@ static const struct sci_port_params sci_port_params[S=
CIx_NR_REGTYPES] =3D {
>         },
>
>         /*
> -        * The "SCIFA" that is in RZ/A2, RZ/G2L and RZ/T.
> +        * The "SCIFA" that is in RZ/A2, RZ/G2L, RZ/T and RZ/V2H.
>          * It looks like a normal SCIF with FIFO data, but with a
>          * compressed address space. Also, the break out of interrupts
>          * are different: ERI/BRI, RXI, TXI, TEI, DRI.

and RZ/V2H has more interrupts than RZ/A1, RZ/G2L and RZ/T...

In addition, RZ/V2H does not support synchronous mode (does not matter
for the driver) and modem control signals.

Currently, sci_init_pins() does write ones to the SCPTR bits that are
reserved and marked as "write zero" on RZ/V2H. I am not sure how bad
that is.  You could avoid that by adding a check for .hasrtscts, but
that may have impact on other SoCs/boards, where currently e.g. RTS#
is always programmed for output and active low...

So if you really need to avoid writing to these bits, the only safe
way may be to add a new SCIF type.  But perhaps I'm over-cautious? ;-)

> @@ -3224,6 +3224,10 @@ static const struct of_device_id of_sci_match[] __=
maybe_unused =3D {
>                 .compatible =3D "renesas,scif-r9a07g044",
>                 .data =3D SCI_OF_DATA(PORT_SCIF, SCIx_RZ_SCIFA_REGTYPE),
>         },
> +       {
> +               .compatible =3D "renesas,scif-r9a09g057",
> +               .data =3D SCI_OF_DATA(PORT_SCIF, SCIx_RZ_SCIFA_REGTYPE),
> +       },
>         /* Family-specific types */
>         {
>                 .compatible =3D "renesas,rcar-gen1-scif",
> @@ -3554,6 +3558,7 @@ OF_EARLYCON_DECLARE(sci, "renesas,sci", sci_early_c=
onsole_setup);
>  OF_EARLYCON_DECLARE(scif, "renesas,scif", scif_early_console_setup);
>  OF_EARLYCON_DECLARE(scif, "renesas,scif-r7s9210", rzscifa_early_console_=
setup);
>  OF_EARLYCON_DECLARE(scif, "renesas,scif-r9a07g044", rzscifa_early_consol=
e_setup);
> +OF_EARLYCON_DECLARE(scif, "renesas,scif-r9a09g057", rzscifa_early_consol=
e_setup);
>  OF_EARLYCON_DECLARE(scifa, "renesas,scifa", scifa_early_console_setup);
>  OF_EARLYCON_DECLARE(scifb, "renesas,scifb", scifb_early_console_setup);
>  OF_EARLYCON_DECLARE(hscif, "renesas,hscif", hscif_early_console_setup);

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

