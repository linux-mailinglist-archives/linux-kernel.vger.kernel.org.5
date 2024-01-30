Return-Path: <linux-kernel+bounces-44430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF288421FC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5679F1F239AE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847FF664AE;
	Tue, 30 Jan 2024 10:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKsKcLpy"
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C84664A0;
	Tue, 30 Jan 2024 10:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706612007; cv=none; b=Pot0yoJVVYQJd4bHGCNyk6a1opeocJ/lcIqY9+CNZMIdk/EFfjijvSrMvBscRwrAMpyO8B0PdrZ/KIdV822mXqxzzFVyaKLh4z7AGhrk3q7jx8HMlJaEKKY7nXEnSeEgIZdkVU0lO5wkQWCKCxHf53DoRpeFPH+RDbMNgovGg10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706612007; c=relaxed/simple;
	bh=OnuVYsvU2WNhZcmPss9Ip918LCpNRJoRqA6UpHf/Lc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uM/OB4boZpeVkR1+lWB/ZPvA8Zxfil3XE6S0BmzYJ9mxJ+KuD9GxJ4QiVUvpZFBf2yfYf5zCdgc6J4kgVRH8gpKp96joo1+gk4wmdtDAkZrFccP6YqEnrOzpfpEi/L4d+KY4umccCac6nfadYiijicSemgESZmf8Y5hk7iRTpkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKsKcLpy; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-7d5bbbe57b9so947889241.3;
        Tue, 30 Jan 2024 02:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706612005; x=1707216805; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t2Wgc2ClmelSiswazxUWS0iU6q84Ug0M/jBpx2lzDSQ=;
        b=JKsKcLpyVjRLi+cLAItKbpp09kKZ63HI4B4voAHYrNGiQNbO4+yLm/Ko3KD024geeo
         0NlUenOPodSSBOPZyRu1Kw1MGZlKoHAJzzT028QbdklVOFZz25Exl78feGyxHidIgFll
         PQk3pDDFUIbCJ42Qro0TEPooX9RZDvU5WPYF6/9b//bnBdPwwmiNSU7KR5Ck1VCYXAfU
         aZ5KKPdusYGrUgSmLROymYvyQc0383CMQOUscimjH6RQxmA1SMnVs8z90arEQXE/f8si
         x6ijFlNcrsUwOe2sp/Y0AJRwqdu1JpoEJGjD7zbDNs7RWtQseDmr1cVgggRM8cQgoGsh
         gXZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706612005; x=1707216805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t2Wgc2ClmelSiswazxUWS0iU6q84Ug0M/jBpx2lzDSQ=;
        b=DEwe9PvajgiSvjqYpWcpT5pZDe2oMOz0IiCvSmNW1hS/EcaI9vnv+n076c77+E6kcy
         qbyU8uFo9W6hyjDUp7Jr4XMER5FxuRf4VTiZ5E+IZWFJ71KEezgcTcdjEwqpOw+iIq8q
         s9pJun/CJcb5sjdqldPsEVaxW5Uh7mCxh8kfY02F5dtAjC9cJCn+CT3f9kpKuckDdXNI
         j//hRdsERZw55AYK0Nq9Aq+eHCTeIBAc9Y8BMXWMzvEwsLtfAGtztskfEQDzQnZykcqq
         PGxRYmKgvZ/jcNmCUXdnS0BWeIjoVN0xBDIJFK79R+jnEn3DnpjUbVzGUIEdKTEVnZW6
         V5eg==
X-Gm-Message-State: AOJu0YyUSVvbcDNLURi6JPdI2yCRo+7e4j3cc4GGY/Wm43RDuT6U7GVg
	X01HrMEzHbVSF2wVpoodhkdpqMs/LBZSiI+9EzrTGwaAbU6ejSfhyAAg83x4z3eUpi+HLGo2yzL
	+MvaAzn7DlJFVX7VwLqmX7GhrjZw+3Ab+
X-Google-Smtp-Source: AGHT+IHgpOYGVwZC7jGnAQ5quTRMCHeTj6rwn160Ts+Wqt1/jnYyj4K3u3HJFVo+yEseFc6FkttQlfm/AvfFuGOWpDg=
X-Received: by 2002:a05:6122:d28:b0:4b6:c49a:174a with SMTP id
 az40-20020a0561220d2800b004b6c49a174amr3593381vkb.14.1706612004892; Tue, 30
 Jan 2024 02:53:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129135556.63466-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240129135556.63466-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdWbPooCMqyKjTh+uJgAqh=az0+DOQAJYKQ7cuBrxyV1-w@mail.gmail.com>
In-Reply-To: <CAMuHMdWbPooCMqyKjTh+uJgAqh=az0+DOQAJYKQ7cuBrxyV1-w@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 30 Jan 2024 10:52:54 +0000
Message-ID: <CA+V-a8ux+AfF4rTmfr448Gp_=_M2TczsZ5_j2afk9qRFs3ePGQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] pinctrl: renesas: rzg2l: Improve code for readability
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

HI Geert,

Thank you for the review.

On Tue, Jan 30, 2024 at 10:35=E2=80=AFAM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Mon, Jan 29, 2024 at 2:56=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail=
com> wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > As the RZ/G2L pinctrl driver is extensively utilized by numerous SoCs a=
nd
> > has experienced substantial growth, enhance code readability by
> > incorporating FIELD_PREP_CONST/FIELD_GET macros wherever necessary.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> i.e. will queue in renesas-pinctrl for v6.9.
>
> > --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
>
> > @@ -90,14 +93,18 @@
> >   * (b * 8) and f is the pin configuration capabilities supported.
> >   */
> >  #define RZG2L_SINGLE_PIN               BIT(31)
> > +#define RZG2L_SINGLE_PIN_INDEX_MASK    GENMASK(30, 24)
> > +#define RZG2L_SINGLE_PIN_BITS_MASK     GENMASK(22, 20)
> > +
> >  #define RZG2L_SINGLE_PIN_PACK(p, b, f) (RZG2L_SINGLE_PIN | \
> > -                                        ((p) << 24) | ((b) << 20) | (f=
))
> > -#define RZG2L_SINGLE_PIN_GET_BIT(x)    (((x) & GENMASK(22, 20)) >> 20)
> > +                                        FIELD_PREP_CONST(RZG2L_SINGLE_=
PIN_INDEX_MASK, (p)) | \
> > +                                        FIELD_PREP_CONST(RZG2L_SINGLE_=
PIN_BITS_MASK, (b)) | \
> > +                                        FIELD_PREP_CONST(PIN_CFG_MASK,=
 (f)))
> >
> > -#define RZG2L_PIN_CFG_TO_CAPS(cfg)             ((cfg) & GENMASK(19, 0)=
)
> > +#define RZG2L_PIN_CFG_TO_CAPS(cfg)             ((cfg) & PIN_CFG_MASK)
>
> Do you mind if I drop RZG2L_PIN_CFG_TO_CAPS() and replace its two
> users by FIELD_GET(PIN_CFG_MASK, *pin_data) while applying?
>
Fine by me.

Cheers,
Prabhakar

> >  #define RZG2L_PIN_CFG_TO_PORT_OFFSET(cfg)      ((cfg) & RZG2L_SINGLE_P=
IN ? \
> > -                                               (((cfg) & GENMASK(30, 2=
4)) >> 24) : \
> > -                                               (((cfg) & GENMASK(26, 2=
0)) >> 20))
> > +                                                FIELD_GET(RZG2L_SINGLE=
_PIN_INDEX_MASK, (cfg)) : \
> > +                                                FIELD_GET(PIN_CFG_PIN_=
REG_MASK, (cfg)))
> >
> >  #define P(off)                 (0x0000 + (off))
> >  #define PM(off)                        (0x0100 + (off) * 2)
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds

