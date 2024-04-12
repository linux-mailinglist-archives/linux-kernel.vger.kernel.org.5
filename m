Return-Path: <linux-kernel+bounces-142438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3038A2B90
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F08911C213EB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B103552F68;
	Fri, 12 Apr 2024 09:49:45 +0000 (UTC)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B7250A72;
	Fri, 12 Apr 2024 09:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712915385; cv=none; b=GLC8Rqus6Kh2eAvuNirNSZ3HWhWeNyFLvvl+j85m9fGsUIvEBTx5wJlf9+ccwh+mcYco6otyMdWvwrWnZQZIABtYGtI54XIeXQYWPG9jrKfU8oePl4lgdmcSpNrarJdoldWeEdI2akzmJg965ioLexiLO9CQ4TzrpbDXl5kvANI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712915385; c=relaxed/simple;
	bh=4iuNWafAlVs0tPagV0be6kkFa8S/7vwzAZ9Y+vk2LHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DlTyKIxSlqWWeQ+ECBh+U5NH6vEK4x2I9HWzRV84bD7z5wl9i6MA21yr04McjF7Bq2BqrBoXXI4Las/DbGEjQxBX+nPmAx2p9aGmiWmBtucExGWaO/6v+Xddfw4SXRcXAHGhBqjdXMZg7J02yjf196wVGqajze0ypyzHXI+ZQIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-61587aa956eso6434907b3.1;
        Fri, 12 Apr 2024 02:49:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712915381; x=1713520181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g071JfuzkspXN8Ky7aeHt1Bp1fvOqTz6KNtYmN0i74Q=;
        b=eaoUrID5x57MaxnN/mczipqqMmekH5GmbB+h0FFpsIC9+v+edaOBYeDphYCXyMGrKc
         hqOPKnDAMJInNDu3Imo4pKw3NV16Qi0uhNR2MajQ+i97IoeKq6J5hj1cAD2SdrIHJ+jw
         JUhQBNOQbuVEEYEsUFUUO7Rg0J6ti2B/GNHUSwS5Ukd3iVUU7/ZhshKAS5WvcKG8kBnw
         UL4AOFdS9TIBflArYzZJklRIUZcRMj9SX21kRiqBjToo7Q8fW4N3lY2ZQ9ush6gMiPnR
         44tRtwmcUD+keHKfRK0/f1wmDQKdayMmIh/aBSFleT2gzUfqF08zREIvd3bRPIooyUUj
         QRyg==
X-Forwarded-Encrypted: i=1; AJvYcCWKsc7/0UcEfJUXY86/L0WnvJXLMF2tbkfm2pztxa7aTRtzaGz72WzVyZP6IgagL91JVeqQyerG+ljHBrcR6BIbs+4JxzC2Dt29IB3k1FV300Q8uLI4+aCIvZkhwwiSG9HH3ci8eSylBocT46jI2+lave3K9EDkFfOTIw10/0xt1KY9piowvpSlLcZa
X-Gm-Message-State: AOJu0Yyzy8ns+F68d6tZbZEzfv48iQ04iR99XBhbLDGx+sJ5WOFFeEGs
	d3J3kf4quFrWRY+ofDE0e52Um8nuQ8s/36ADMevLOV0oOnFdMAgd6h5hBG29
X-Google-Smtp-Source: AGHT+IHH0DD6pWyRCcphZOOck+1WdcFb3irGMhGdXDdwk7m879xl27vjmxxFkOomAb1dmE72Fplzqg==
X-Received: by 2002:a81:4054:0:b0:609:af49:7995 with SMTP id m20-20020a814054000000b00609af497995mr1634669ywn.50.1712915381301;
        Fri, 12 Apr 2024 02:49:41 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id a134-20020a0dd88c000000b00614605317dfsm748023ywe.50.2024.04.12.02.49.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 02:49:41 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-617e6c873f3so7387277b3.2;
        Fri, 12 Apr 2024 02:49:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVs8WvliMGKxk2mJq5jPqLPI/BA2Cb0m0eCwiy1XQuWPUjZIQhzszMd+pg2c5LCJjOnjvxxHHyWdweDC36efCNPeXDeLRI995eWzUpiSp5EiG7MndxTF7tSEtYSZuhtmiCgnK/JzmAtzemW4Ef2BbtVSRH14rEw/7yyreDn66NImqI3jxhfo4YAMZsE
X-Received: by 2002:a25:8483:0:b0:dce:9c23:eafc with SMTP id
 v3-20020a258483000000b00dce9c23eafcmr2032749ybk.1.1712915380781; Fri, 12 Apr
 2024 02:49:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318143149.2468349-1-claudiu.beznea.uj@bp.renesas.com> <CAMuHMdVwK6CRZyRMuS1mw7EXEb-fqtWOAdG6HmX-v+HTvhPV5g@mail.gmail.com>
In-Reply-To: <CAMuHMdVwK6CRZyRMuS1mw7EXEb-fqtWOAdG6HmX-v+HTvhPV5g@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 12 Apr 2024 11:49:28 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWznK8S8=38zCfJM6x9QkSKERXraLqrY4nEeWBUxRavQg@mail.gmail.com>
Message-ID: <CAMuHMdWznK8S8=38zCfJM6x9QkSKERXraLqrY4nEeWBUxRavQg@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: renesas: rzg2l: Execute atomically the
 interrupt configuration
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: linus.walleij@linaro.org, linux-renesas-soc@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 11:12=E2=80=AFAM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Mon, Mar 18, 2024 at 3:31=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev=
> wrote:
> > From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >
> > Lockdep detects a possible deadlock as listed below. This is because it
> > detects the IA55 interrupt controller .irq_eoi() API is called from
> > interrupt context while configuration-specific API (e.g., .irq_enable()=
)
> > could be called from process context on resume path (by calling
> > rzg2l_gpio_irq_restore()). To avoid this, protect the call of
> > rzg2l_gpio_irq_enable() with spin_lock_irqsave()/spin_unlock_irqrestore=
().
> > With this the same approach that is available in __setup_irq() is mimic=
ked
> > to pinctrl IRQ resume function.
> >
> > Below is the lockdep report:
>
> [...]
>
> > Fixes: 254203f9a94c ("pinctrl: renesas: rzg2l: Add suspend/resume suppo=
rt")
> > Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > ---
> >
> > Changes in v2:
> > - used raw_spin_lock_irqsave()/raw_spin_unlock_irqrestore()
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> i.e. will queue in renesas-pinctrl for v6.10.

I have promoted this to a fix for v6.9.

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

