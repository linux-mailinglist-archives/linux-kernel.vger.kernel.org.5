Return-Path: <linux-kernel+bounces-5895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE2C819133
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 21:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BCF4B24C7A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 20:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB3239AC8;
	Tue, 19 Dec 2023 20:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="xoNqS7HV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C7739AC5
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 20:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6dba7e6d23bso251360a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 12:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1703016394; x=1703621194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bd0KZBzXX17A+4/4irqRuXit/iogRnCS0NnRs3EEDHo=;
        b=xoNqS7HVBdRXZpkDdhHeS691VakqGzQloHEFA4QUhOPQG1LjdS53o9yb+Zt2/geuk4
         6dWhi3A1YDNVTph2fZ+hHX2BIaP8hSw4gbfle2taDa0OWDUv6GQ84JLIK4N8wGkm2vmC
         bRP0iWYb/Wv5jrehBnHuGHw8SBd2wEhKDs0EF649czBMAMuHpDnTlibUNHaiSOa6dgJT
         KH2iZZDmYGE3arI1js9JIVN4MjnDF/O/W2WOhw5+mTDS9OHTC8L+u3vwlQ2qx6okxB/X
         Gjzjd6hoxnpki+LRaON27r4UV7PEweLJjvmGi8sYFXwui2/T86JVwY9GDP1Xk5sRWwUJ
         Jfkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703016394; x=1703621194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bd0KZBzXX17A+4/4irqRuXit/iogRnCS0NnRs3EEDHo=;
        b=p3vptE5GdgOsgcgiZJRhnohVAd2qkzPQV2HUUp2L6ICfTipxxPiSlLdEW8qpQLauRD
         3T5cztU2XS1OVTS7V4gs2+VyPE1Xfmi1nPwA7h6RIHWNBp/LQlCqg0/V8mBt+y7t/g7C
         Bzdbv32x9BE/WY7ZI6wsT6qVEIZtYd1SwNaEIiRxtwmUucxyj/WGvO72ziZNUT0QhoT7
         k1kgW49qrFvgP0miKnJPernTTcfTcnNudZl0sK+uncs+Yu7bvUdyOg76cdUqy8TN1nqj
         DYC9esNvTudWJ3Z6qkP46dE2lVXOjmuGHWKBgbQiH1R97I7BLUiS20zyDQtKARbKOYP5
         GH5A==
X-Gm-Message-State: AOJu0YwZwxDdOKSiJgLg0r4yW0mc/VWmKZP0ZLtH/uE+R8IBggHBl5Tl
	9b4lWuYBeEamkj0hLCRci1YqFOLPS58TwSGIKcRRBw==
X-Google-Smtp-Source: AGHT+IES6LrX2oJ1Fleh9OkH9OogE9k0GI4dX/Xlq4YUnHZ12ZGidqUuEuQ6tvfgcJWgRKy7QbSS7FFYO6XhIiZ4yGc=
X-Received: by 2002:a9d:7849:0:b0:6da:2ec0:c964 with SMTP id
 c9-20020a9d7849000000b006da2ec0c964mr7643237otm.8.1703016394809; Tue, 19 Dec
 2023 12:06:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219142323.28929-1-brgl@bgdev.pl> <20231219142323.28929-2-brgl@bgdev.pl>
 <ZYGxwgkngL2c5KE3@smile.fi.intel.com>
In-Reply-To: <ZYGxwgkngL2c5KE3@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 19 Dec 2023 21:06:24 +0100
Message-ID: <CAMRc=MfD4AyurZO2LkFpM_4nwJbOdPubMwCR9fkgpk87F0TyHw@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: sysfs: drop tabs from local variable declarations
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Kent Gibson <warthog618@gmail.com>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 4:07=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Dec 19, 2023 at 03:23:23PM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Older code has an annoying habit of putting tabs between the type and t=
he
> > name of the variable. This doesn't really add to readability and newer
> > code doesn't do it so make the entire file consistent.
>
> Besides similar comments as per previous patch, see below.
>
> ...
>
> > +     struct gpiod_data *data =3D dev_get_drvdata(dev);
> > +     struct gpio_desc *desc =3D data->desc;
> >       int                     status =3D 0;
> >       unsigned int            flags =3D data->irq_flags;
>
> ???
>
> ...
>
> > +     struct gpio_device *gdev;
> > +     struct gpiod_data *data;
> >       unsigned long           flags;
> >       int                     status;
> >       const char              *ioname =3D NULL;
>
> ???
>

Thanks, should have not trusted my regex blindly.

Bart

> --
> With Best Regards,
> Andy Shevchenko
>
>

