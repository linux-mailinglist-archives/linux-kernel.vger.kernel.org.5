Return-Path: <linux-kernel+bounces-154619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5208ADE7C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CBBA1C22135
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 07:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F128B4B5CD;
	Tue, 23 Apr 2024 07:45:21 +0000 (UTC)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB2247A5D;
	Tue, 23 Apr 2024 07:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713858321; cv=none; b=IV/YGt1NFlLTq5VF3f2CZRtTIbMYnpWqIkPqH0b89WARVq8mcRWEDS7pRZRWh1k0O6TyRXm88GgcNREj9nxPT67zULSXXcUrdmB9T7mZg98Mw/B0AZK7Yez+wDVsHrY8p6e7kqi+5BwqsBBtYV2W8mWPSOTDhNX+Hs65zv+rrlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713858321; c=relaxed/simple;
	bh=YlWrafYSsryw1WA2DVps2oKJSLldPSuYQXcKQNCFzkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sv9ulGix9IUiRGLbjP+9gJG3VGbGPJqAvbQ6mGNii8h+ItvxjBmHlXjgRkRi39Y91dXM8k/X+SI9P+K6avalXJiKE8czcE4aBYebgKyXt83mJx5gx4QFISyogFDK2mtTVDx4L8f5/SJtgXA8nez2MvizCNVqEkk3p8wAjf4qnAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-61816fc256dso46471307b3.0;
        Tue, 23 Apr 2024 00:45:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713858318; x=1714463118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KQC2VjoXZNyCZnymCSQfxQVu+Uovh24ltYsvubEZVx0=;
        b=QNKQn4AAhlAqJGIRLmeIQo4MrUfiMAOInIOfivUAtupgRirRJAV8fRs5bCAmkWKXzF
         k3K3QxOrk0sGpejGZkCF8/h1ZaZqCz+22UcS30ZdfIT0LZj1g4LHgAGOnBrARgygmtWX
         AhF449hkoReLTfHBbfJCfTvfKg3IxrFvRVuXfSu7E1D7RMNTPJb3duRaOzjwdkKAZCGm
         cr2VoUdOALfcv9E2OL9q/DpaSOtuB9VnR6AVz+pHoHaOQJF/kSP09DSKyQRCNmvxyAqJ
         uJXrLrCZBfDisUe57mDIdMgsJ8y5xpg7CTzZBVRK1UrCb3R2ln1ZVjOLznZ5mcEN6jBF
         RtGw==
X-Forwarded-Encrypted: i=1; AJvYcCUvc725/RgZeuOKefGqn1NbWf1KFNajzKBP4ed7EFqypjnnYLH8U5xSfrk8HLHBMmcOGj/GDN7KbaFHIjCqHlg2v2//joGp0oWDkbR5+G+4l1lej7gU1XcuqPkwhEaDSYm+S+Foc+TlTIMRTo8jIlj2Rvir33sBKfSrVunqKN+lSkulc4o=
X-Gm-Message-State: AOJu0YwAQWd29RJvfvL7GNWY/t77gw8CUU/yo5RY/Oa+u0MLRCB6BzZT
	a0Jk/FKF+RlYq/ruwEk6//9KwocPPyEFaVNtoEryB/+0Q97pIw/r01sv3W6v
X-Google-Smtp-Source: AGHT+IHnOT9odmIj3TVq8cnVLg6puOJjxn7GuhCpsCQafwSoInzGdx8fIa2ITxbbZtjVedu729lgVQ==
X-Received: by 2002:a05:690c:c8e:b0:618:8b6c:6c1b with SMTP id cm14-20020a05690c0c8e00b006188b6c6c1bmr13028736ywb.4.1713858318219;
        Tue, 23 Apr 2024 00:45:18 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id df8-20020a05690c0f8800b0061ab3ff3f22sm2344729ywb.82.2024.04.23.00.45.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 00:45:18 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-de45dba15feso5399051276.3;
        Tue, 23 Apr 2024 00:45:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXw6s27rCsvCgD7+O/prEhxTBuhAHFEEwNhzxCLXtVQbbe0Xqi5jerC4U9owPEuVgWPXtHs0YJdMtvwr3R7CCoFJnI2o8IPJf8vdZXLr8BxIBqxFVKX8wUOOX2FogpZe7ZUQpH6SWapvYxMYG2ssrNN05b38o13/D1qb8PcKu7F9A+xMYQ=
X-Received: by 2002:a25:ae61:0:b0:dd1:3cc1:5352 with SMTP id
 g33-20020a25ae61000000b00dd13cc15352mr12105050ybe.15.1713858317795; Tue, 23
 Apr 2024 00:45:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422111123.1622967-1-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdUXRx1-95PD_WG4X=y4UefYXzTqm7T2mi+di+ZdKGUXYA@mail.gmail.com> <DU0PR04MB9417D8D052B09BC9FA58826B88112@DU0PR04MB9417.eurprd04.prod.outlook.com>
In-Reply-To: <DU0PR04MB9417D8D052B09BC9FA58826B88112@DU0PR04MB9417.eurprd04.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 23 Apr 2024 09:45:05 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWvACWWSJUsaT9FYVN=VCzAjJpxmJJpK1h3CA_gbWKVsQ@mail.gmail.com>
Message-ID: <CAMuHMdWvACWWSJUsaT9FYVN=VCzAjJpxmJJpK1h3CA_gbWKVsQ@mail.gmail.com>
Subject: Re: [PATCH] serial: sh-sci: Call device_set_wakeup_path() for serial console
To: Peng Fan <peng.fan@nxp.com>
Cc: Claudiu <claudiu.beznea@tuxon.dev>, 
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jirislaby@kernel.org" <jirislaby@kernel.org>, 
	"ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peng,

On Tue, Apr 23, 2024 at 9:35=E2=80=AFAM Peng Fan <peng.fan@nxp.com> wrote:
> > Subject: Re: [PATCH] serial: sh-sci: Call device_set_wakeup_path() for =
serial
> > console
> > CC Peng
>
> Thanks for Ccing me, but I am not familiar with sh-sci driver (:

But you are with the IMX pmdomain driver, so please read on ;-)

> > On Mon, Apr 22, 2024 at 1:11=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.d=
ev>
> > wrote:
> > > From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > >
> > > In case the SCI is used as a UART console, no_console_suspend is
> > > available in bootargs and SCI is part of a software-controlled power
> > > domain we need to call device_set_wakeup_path(). This lets the power
> > > domain core code knows that this domain should not be powered off
> > > durring system suspend. Otherwise, the SCI power domain is turned off=
,
> > > nothing is printed while suspending and the suspend/resume process is
> > > blocked. This was detected on the RZ/G3S SoC while adding support for
> > > power domains.
> > >
> > > Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

> > > --- a/drivers/tty/serial/sh-sci.c
> > > +++ b/drivers/tty/serial/sh-sci.c
> > > @@ -3441,8 +3441,12 @@ static __maybe_unused int sci_suspend(struct
> > > device *dev)  {
> > >         struct sci_port *sport =3D dev_get_drvdata(dev);
> > >
> > > -       if (sport)
> > > +       if (sport) {
> > > +               if (uart_console(&sport->port) && !console_suspend_en=
abled)
> > > +                       device_set_wakeup_path(dev);
> >
> > device_set_awake_path(), as of commit 10bb4e4ab7dd3898 ("PM: sleep:
> > Add helpers to allow a device to remain powered-on") in v6.6 (although =
I'm
> > still a bit puzzled about the difference).
> >
> > > +
> > >                 uart_suspend_port(&sci_uart_driver, &sport->port);
> >
> > I think it would be better to make this more general, and move the call=
 to the
> > existing console_suspend_enabled handling in uart_suspend_port().
> >
> > > +       }
> > >
> > >         return 0;
> > >  }
> >
> > If this works, we can remove the console_suspend_enabled handling from
> > drivers/pmdomain/renesas/rmobile-sysc.c, and revert commit
> > 309864dcf92b76fc ("genpd: imx: scu-pd: do not power off console if
> > no_console_suspend").

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

