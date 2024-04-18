Return-Path: <linux-kernel+bounces-150248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA9F8A9C47
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E735B21D1C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C1A165FCC;
	Thu, 18 Apr 2024 14:07:36 +0000 (UTC)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA49E163A9B;
	Thu, 18 Apr 2024 14:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713449256; cv=none; b=p981Rkktih034qIpQ1uhXMPPxOEjneOlPQgiwobNIk2pe+5YXlWZmBq8B+HTOIX7AYmcv+Vtngw/zln4Od91QKz1hv1DnY+atgZat7P0HNLecn7D6VTFAY9SDIoPQucyd9jBW0oraagKUl7PIDTe8CkDXlUncvFnOWyUPrVO89A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713449256; c=relaxed/simple;
	bh=FJF+jvoxE49NJphdMwIbdaNcFtOd2M9yRXYXL1Nazuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m84bjTkpU3vCfSw6TvVDYnwTCgLwU5TfEbPyvln6RiHzGZ/1ehJ2Q5nIdpZBIp+Jur9vgbIl8KbpBiREUb+p7dK9HXgazD7pIhRc5FJjh5Km1tlLYwzhlJgISHHNqPRhmjdveVfk9Ju5h/JX99t8l+WQ72JybW3z3YdhZ51FobI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6150670d372so8218647b3.1;
        Thu, 18 Apr 2024 07:07:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713449248; x=1714054048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n9GRpmL+xi3CtBGop9v1/wYQ7wRylluWVZ65rgWaWfA=;
        b=ViUB4DxnOmVgomgE3eBkZCNO9+rT+rCzY7e0eXR/HOzpwB8FAnwdP1CsVgB3tsdjvJ
         bFvuklvHEXCTKRp2o1KIGFMM6kWaZnPuTNC/Y5a78cqyYQpv38abmyb1VwELnhhr8jya
         ucYFCfW/iEN8zEmV+mAucoq1fJqXxb6TtuzXrJUQ9HVklyqwFdc/LHDz2YqRnC0orDun
         IqLz8/aIJ6PqvzLfX5FBelhuHLCilotS0rPj6UjO5Q5eTmdT1owfKe9bugbRilZJ2RWH
         6PDQRq/gp94HAxH9nfN9VEOZv15Isiwdw+mPXUMWFSpuRaF+g7Fmfy5Fbd6L30kS5TrP
         5BVg==
X-Forwarded-Encrypted: i=1; AJvYcCUXOvhkDc0KO84B4gQBGWr8f7DmzGMXQ/dgLG0DluS5NmggegTcD4BtiR78Fnm6EZbtN6RDFX2/jm2VvbvWXyzNPgDYmNe7d4uez7DZ9tGb54436Ygz3sIzklogpBc5JObYRu8Mkszxyf2+TtfWCYFbR7our+pjo3D8zqvs8jtDyy3Qr4OewOP24weX
X-Gm-Message-State: AOJu0YxdEIglbNs3fui2q6rgYYX+VyFZHSz4HohLQPKnrMFt0hHfvxTF
	TscRegja0cQ+yyv3hWZvkkFQCEynH6mXSmqfL73ZFdKXeWwbqqP/OGnWfxli
X-Google-Smtp-Source: AGHT+IETZ9A5bwkSPR1uvldqDj2rqv7jLERHpIyVNrkIstnYrsKiSrT8hidyQDh8GzL/sKnPl3gWbA==
X-Received: by 2002:a05:690c:690b:b0:615:1e99:bd6e with SMTP id if11-20020a05690c690b00b006151e99bd6emr3153185ywb.35.1713449248528;
        Thu, 18 Apr 2024 07:07:28 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id i84-20020a0ddf57000000b00617cd7bd3a9sm339944ywe.109.2024.04.18.07.07.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 07:07:28 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-de45e5c3c84so968023276.1;
        Thu, 18 Apr 2024 07:07:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU+n+qCl/ULOpw+jq/x/rAdjV37Utq4YF45D7aTUXnHQxZ4EXxYA0EENS/e7LkxtBlQV7jUfiq85jExp+F4+44GUa9YolTh6ftezv55A9H04vj4e5vSWrcFIjh/ZxRQ9q0KNpAOX/bdgvsF9InYvep8KhmqKreMnE+QjG6lgtkRk6YZ6RHX89kO+k9y
X-Received: by 2002:a25:b115:0:b0:de4:5ec1:9ba2 with SMTP id
 g21-20020a25b115000000b00de45ec19ba2mr2913597ybj.27.1713449247038; Thu, 18
 Apr 2024 07:07:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320104230.446400-1-claudiu.beznea.uj@bp.renesas.com> <20240320104230.446400-3-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240320104230.446400-3-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 18 Apr 2024 16:07:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXescaJ-V0iuXsxo=X-7RYTBR1W5+EXZCw_2VPHEFGzdA@mail.gmail.com>
Message-ID: <CAMuHMdXescaJ-V0iuXsxo=X-7RYTBR1W5+EXZCw_2VPHEFGzdA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] pinctrl: renesas: rzg2l: Configure the interrupt
 type on resume
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: linus.walleij@linaro.org, tglx@linutronix.de, biju.das.jz@bp.renesas.com, 
	linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Claudiu,

On Wed, Mar 20, 2024 at 11:43=E2=80=AFAM Claudiu <claudiu.beznea@tuxon.dev>=
 wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Commit dce0919c83c3 ("irqchip/renesas-rzg2l: Do not set TIEN and TINT
> source at the same time") removed the setup of TINT from
> rzg2l_irqc_irq_enable(). To address the spourious interrupt issue the set=
up
> of TINT has been moved in rzg2l_tint_set_edge() though
> rzg2l_disable_tint_and_set_tint_source(). With this, the interrupts are
> not properly re-configured after a suspend-to-RAM cycle. To address
> this issue and avoid spurious interrupts while resumming set the
> interrupt type before enabling it.
>
> Fixes: dce0919c83c3 ("irqchip/renesas-rzg2l: Do not set TIEN and TINT sou=
rce at the same time")
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> @@ -2045,7 +2045,9 @@ static void rzg2l_gpio_irq_restore(struct rzg2l_pin=
ctrl *pctrl)
>
>         for (unsigned int i =3D 0; i < RZG2L_TINT_MAX_INTERRUPT; i++) {
>                 struct irq_data *data;
> +               unsigned long flags;
>                 unsigned int virq;
> +               int ret;
>
>                 if (!pctrl->hwirq[i])
>                         continue;
> @@ -2063,17 +2065,17 @@ static void rzg2l_gpio_irq_restore(struct rzg2l_p=
inctrl *pctrl)
>                         continue;
>                 }
>
> -               if (!irqd_irq_disabled(data)) {
> -                       unsigned long flags;
> -
> -                       /*
> -                        * This has to be atomically executed to protect =
against a concurrent
> -                        * interrupt.
> -                        */
> -                       raw_spin_lock_irqsave(&pctrl->lock.rlock, flags);
> +               /*
> +                * This has to be atomically executed to protect against =
a concurrent
> +                * interrupt.
> +                */
> +               raw_spin_lock_irqsave(&pctrl->lock.rlock, flags);
> +               ret =3D rzg2l_gpio_irq_set_type(data, irqd_get_trigger_ty=
pe(data));
> +               if (ret)
> +                       dev_crit(pctrl->dev, "Failed to set IRQ type for =
virq=3D%u\n", virq);
> +               else if (!irqd_irq_disabled(data))
>                         rzg2l_gpio_irq_enable(data);
> -                       raw_spin_unlock_irqrestore(&pctrl->lock.rlock, fl=
ags);
> -               }
> +               raw_spin_unlock_irqrestore(&pctrl->lock.rlock, flags);
>         }
>  }

LGTM, but I'd rather move the dev_crit() outside (i.e. after) the
critical section.

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

