Return-Path: <linux-kernel+bounces-66537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51547855E0E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45CE71C219DF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026B71BC4F;
	Thu, 15 Feb 2024 09:27:22 +0000 (UTC)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2961BC35;
	Thu, 15 Feb 2024 09:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707989241; cv=none; b=vCwl1uRuA35ZKk7sdbtvwIHo+7ZiFcDyu0YqSofnJgIHU1Nyh3NrUUymdBJDGWVVMQKjIAiy+iji3v4i4u1KRYmvNYffdcomn7fkD58vJdSk51ea2zMd8GMOVqIapdBPAhwAtOMAXIBy4s1PzSc9ddIyKn/C5jdVTY6xmzLLFZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707989241; c=relaxed/simple;
	bh=ZUcLHYNpUiDKrpNj9+y0zczkb5SP8NlP42MPxxVUZ6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dQeJ4kULab/ziaZqxaJ9AwXzFoEgk7ti6LxA8Os/uY2ItFH8zWP3u3QLuPne33RC/VHxcSrG3nfpSkGRMivLL51TvlLAtJ64DfjxxxMr/30BOS6hf7nYXLSFb1k4ubToiWce8hLLRiKo8V3uCFGOWN36iQ5XZ/JdWF97AtPDSlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dcc86086c9fso554084276.3;
        Thu, 15 Feb 2024 01:27:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707989238; x=1708594038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SthXbFy+KxgPDEkeyocrq0QfsfwLFwxMJP4nhWF6Ybs=;
        b=gTFgMKHorHXXvHlZauuzv4MJaU0Tcps4hzb0WVgSSSti37WmsUCyu8L5yTn/AKpR+Y
         Ii3cQgbR2QUC/aJvbx6c+cAFKDXdE7C5+CfEeD6MtH8BY6D248jOg8YZUawXQ98EfI7Y
         hqBJmyt/PbFGX/kCNXGl+szAPy4FWWgLWiTZfErhFuXC5hkspIaeqn/sJGBB/D0i+8IA
         kQuh621aXwS42ZhSGDuXpw//RnGJxY/YFiY9vcGjxLvpwoPFDuv4DFXgkGJIRK4T9C7P
         MeqprydWFHtcoHdkN2xlnY+qoHct7C8F9ScYtkMjng5WmFuHDipKhQR8RYBGUCu3zrx5
         vAHA==
X-Forwarded-Encrypted: i=1; AJvYcCWyeOtLr6A6IoL2QzIerI134SQ1sevNIyfzG+AaZqPzsDZ7l5f8X9hwlXxpfWlUhakH5d5S3fnlqExTUNI6XNpcXsLhFE+XEDIH1/MWtv5WlhZkVi4Q0tRzRIii0pdLr1Bil5wE6G2w9CpXOQJHj4bsmg/Xk0RbISenakAdTJT7xgl+m3gXeqxr7fpiE6B03cYtdtsHzUIjNsdwWRPhNMDaX3H7+f/fsQ==
X-Gm-Message-State: AOJu0YzvhWQVgipR2rC4AClIptOccU0vvlb2HJQxLQYzECMMq73j8l2U
	+XCE9IHyqF1LH6BP1RU4ajAxC7d2RGLTcioHfbATxVDpp4FFqeO8qvFVMV5XPUM=
X-Google-Smtp-Source: AGHT+IGfiytTwkISGkkedJ/iRyUN7d27qYpA/KIW1Xb7v8o+d0hFaS/jDh+nGe4xXaQHm2r20Kx9Kw==
X-Received: by 2002:a05:6902:4f1:b0:dc2:398b:fa08 with SMTP id w17-20020a05690204f100b00dc2398bfa08mr1252436ybs.31.1707989237810;
        Thu, 15 Feb 2024 01:27:17 -0800 (PST)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id d11-20020a5b060b000000b00dc74efa1bb4sm122407ybq.13.2024.02.15.01.27.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 01:27:17 -0800 (PST)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dcc86086c9fso554058276.3;
        Thu, 15 Feb 2024 01:27:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXtNd+lyDqpUYgsnlJ4oHAiRM85H0PAy39PPHLV5TcVfg8Rxtc0NM5Z2YOzaMPmDEdMQJk8pSa3K4HBIWtNR9WxFCBuabsljjXpkFs7VOwwO3vAleUbzGqIkEYjDnKc9REfRLkbWvJikBwg9XBVGsP8ryuyH5ac05qiHfxpc+u/gEzl+4Wh+hLnrVn2HQpOkH3w4nA216KX9HQxrRBBtwPhnPR4FUR55g==
X-Received: by 2002:a25:949:0:b0:dcc:54d0:85e2 with SMTP id
 u9-20020a250949000000b00dcc54d085e2mr1069659ybm.24.1707989236875; Thu, 15 Feb
 2024 01:27:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208135629.2840932-1-claudiu.beznea.uj@bp.renesas.com>
 <20240208135629.2840932-2-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdUG595o8u1kgqW6DxfvBuzKuOPv7XkJhg_GQmnbRui8Tw@mail.gmail.com>
 <2dab40a5-1e9b-4396-ad97-b2a810ff703d@tuxon.dev> <cdaffd20-1df4-4f73-ba96-9625e0749269@tuxon.dev>
In-Reply-To: <cdaffd20-1df4-4f73-ba96-9625e0749269@tuxon.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 15 Feb 2024 10:27:04 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXc1_P_9o4aMqZU2e2Rsa5B6TfPLv1oXp_sOzSNQPHn2w@mail.gmail.com>
Message-ID: <CAMuHMdXc1_P_9o4aMqZU2e2Rsa5B6TfPLv1oXp_sOzSNQPHn2w@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl: renesas: rzg2l: Add suspend/resume support
To: claudiu beznea <claudiu.beznea@tuxon.dev>
Cc: magnus.damm@gmail.com, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, linus.walleij@linaro.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Claudiu,

On Thu, Feb 15, 2024 at 10:15=E2=80=AFAM claudiu beznea
<claudiu.beznea@tuxon.dev> wrote:
> On 12.02.2024 17:35, claudiu beznea wrote:
> >>>  static const u16 available_ps[] =3D { 1800, 2500, 3300 };
> >>> @@ -1880,6 +1938,19 @@ static void rzg2l_gpio_irq_print_chip(struct i=
rq_data *data, struct seq_file *p)
> >>>         seq_printf(p, dev_name(gc->parent));
> >>>  }
> >>>
> >>> +static int rzg2l_gpio_irq_set_wake(struct irq_data *data, unsigned i=
nt on)
> >>> +{
> >>> +       struct gpio_chip *gc =3D irq_data_get_irq_chip_data(data);
> >>> +       struct rzg2l_pinctrl *pctrl =3D container_of(gc, struct rzg2l=
_pinctrl, gpio_chip);
> >>> +
> >> I think you also have to call irq_set_irq_wake(pctrl->hwirq[...]) here=
.
> >> Cfr. drivers/gpio/gpio-rcar.c (which is simpler, as it has a single in=
terrupt
> >> parent, instead of a parent irq_domain with multiple interrupts).
> > I had it in my initial implementation (done long time ago) but I don't
> > remember why I removed it. I'll re-add it anyway.
>
> I did some investigation on this. It seems adding irq_set_irq_wake() is n=
ot
> necessary as the pinctrl has no virq requested on behalf of itself.
>
> With this irqchip hierarchy (pinctrl-rzg2l -> irq-renesas-rzg2l -> gic) i=
f
> an IRQ consumer, e.g., the gpio-keys, request an interrupt then it may ca=
ll
> irq_set_irq_wake(virq) (gpio-keys does that).
>
> irq_set_irq_wake(virq) is forwarded to pinctrl as follows:
>
> irq_set_irq_wake(virq, on) ->
>     set_irq_wake_real(virq, ono) ->
>         rzg2l_gpio_irq_set_wake(irq, on)
>
> As the irq_set_irq_wake() gets a virq as argument and as we have no virq
> requested by pinctrl driver there is no need to call irq_set_irq_wake(), =
as
> of my investigation. Calling it with hwirq will return with -22 and calli=
ng
> it with virq received as argument leads to deadlock (as it's the same vir=
q
> that consumer already is configuring with irq_set_irq_wake()) due the
> following line from irq_set_irq_wake():
>
> struct irq_desc *desc =3D irq_get_desc_buslock(irq, &flags,
> IRQ_GET_DESC_CHECK_GLOBAL);
>
> What we can do is to forward irq_set_wake() to the parent IRQ chip
> (irq-renesas-rzg2l) with irq_chip_set_wake_parent() to let him set its
> wakeup_path, if any. But, at the moment the irq-renesas-rzg2l has
> IRQCHIP_SKIP_SET_WAKE thus the irq_chip_set_wake_parent() does nothing (b=
ut
> it can be updated for that). Now I remember that irq_chip_set_wake_parent=
()
> is what I've called in my initial implementation and removed it due to
> IRQCHIP_SKIP_SET_WAKE.
>
> Please let me know if you are OK to add irq_chip_set_wake_parent() and
> update the irq-renesas-rzg2l driver.

I think calling irq_chip_set_wake_parent() regardless is a good thing
to do.  Whether the irq-renesas-rzg2l needs an update for wake-up
handling, I don't know (and that is orthogonal to the above).

If you haven't already done so, you may want to browse the wake-related
git history of e.g. drivers/gpio/gpio-rcar.c.

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

