Return-Path: <linux-kernel+bounces-3407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A7A816BE1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EA45284197
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8211A5B7;
	Mon, 18 Dec 2023 11:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="pyt7u08L"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D9A1B27D
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 11:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-7cad628ad93so803463241.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 03:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1702897565; x=1703502365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CJkI9eZLy5Bl1hohwv0qG30UnZcJHFvUX/0/eW2ATyk=;
        b=pyt7u08LQvbRcGLxQWwu8FFvIC/Ys/xd6BSruIrkvvPX7Oxih2WD4A6GsLdNM/3Lnb
         E8aeVaSCoKhHHZ8qgmGBT5j49+o5wc4ngE9kg+b9dMTrGK559lAEQe8o0pQTy7jgpMjs
         GyJoA9xoucV6Vao/zw1nT0iNRvO2kwXojit4vQfiv+jewdaFnctWT+kOdUZ0+1e8wpUQ
         MjOHHWeEKjdDYIIt+W/KlB13SS4RyfQzkmQd8FR7+38dgFZ4itJTT45ju1d+DuJD/iOy
         +OI8uRdwgrMB7HuAVzAh+O5S40bqAD7Vmro3d56qpwxC0HYlDqMldA9PuYW+GkOdRC6h
         ahFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702897565; x=1703502365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CJkI9eZLy5Bl1hohwv0qG30UnZcJHFvUX/0/eW2ATyk=;
        b=nPWi6s+MGWDbEdbRyHm6U6JIM8Fzs8NGgIA5iAntqODXpaNLlMcOf2vXOgYtQPHW5m
         lUWsm2biY/nw7ixi84D3S1PV1LvQg0YHr1oN76wC/a6jFhKzOItIeix6OQW+Onp36uVD
         onZ/oH6xGf3c69YqhyPcY+WA8SJqM+scMqpcVMrUiryLKDby7nUORprPgUr72gi5ZMIt
         ltAjYFG2glOxi+Ahu52ZWRpcrOBLfG9mVqIWNT+VIZlqj/FDjuARVSLuzsWYY9KVk07e
         gAxoCwUaJsRYY3BBRasm2pWoBpvifZJLJU1WBGnd7ScZeOvv9d0ItuzrVaUNBz1Q2/HN
         xrLw==
X-Gm-Message-State: AOJu0YyrNWVSatQA+dCQdxxHHtGxi3XNja/x0sdO1cbl5c6IQi3ID4Fn
	NHkCCxzc5bqDHy7/HUccqIWEhElIRCYDfm37xAUXGw==
X-Google-Smtp-Source: AGHT+IGamq/wFpirsF+jT1IHLMptP4YKDWihHFP7jR2k4bMeUiXvaLKIUgxSePJmUwF68KE7059YD3VbpQVg1HPDPHs=
X-Received: by 2002:a05:6122:4120:b0:4b6:b917:13a9 with SMTP id
 ce32-20020a056122412000b004b6b91713a9mr839603vkb.6.1702897565165; Mon, 18 Dec
 2023 03:06:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2023102624-moonshine-duller-3043@gregkh> <ZTpbMVSdKlOgLbwv@smile.fi.intel.com>
 <ZUPBVMdi3hcTyW2n@smile.fi.intel.com> <CAMRc=MeV9ZyOzuQFEE_duPTHYgfmr6UZU6bpjDPhrczZX4PHpg@mail.gmail.com>
 <CAMRc=MdSpk_OszeDCyA5_Sp-w=sL9DHB2gGCOFP+FCiobm2cbA@mail.gmail.com>
 <2023111513-stinky-doorframe-8cd1@gregkh> <ZXHUat2Xo1VcAxN2@smile.fi.intel.com>
 <2023121512-breeches-snaking-74ad@gregkh> <ZXxr8LD1P63k-xRV@smile.fi.intel.com>
 <CAMRc=MeBh5Uq1YTvcnGugnvOFYh+rqc7fJpZrSvfmHbwh3SKXw@mail.gmail.com> <ZYAlOpjJBuvY-wTR@smile.fi.intel.com>
In-Reply-To: <ZYAlOpjJBuvY-wTR@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 18 Dec 2023 12:05:54 +0100
Message-ID: <CAMRc=MeJgJj7ikp85vj9KMxgh6Rfx5BrCa3uq52Rj+iDFmQunQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] device property: Implement device_is_big_endian()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 11:56=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Dec 18, 2023 at 11:35:04AM +0100, Bartosz Golaszewski wrote:
> > On Fri, Dec 15, 2023 at 4:11=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Fri, Dec 15, 2023 at 03:49:38PM +0100, Greg Kroah-Hartman wrote:
> > > > On Thu, Dec 07, 2023 at 04:19:22PM +0200, Andy Shevchenko wrote:
> > > > > On Wed, Nov 15, 2023 at 03:21:29PM -0500, Greg Kroah-Hartman wrot=
e:
> > > > > > On Wed, Nov 15, 2023 at 03:58:54PM +0100, Bartosz Golaszewski w=
rote:
> > > > > > > On Fri, Nov 3, 2023 at 10:08=E2=80=AFAM Bartosz Golaszewski <=
brgl@bgdev.pl> wrote:
> > > > > > > > On Thu, Nov 2, 2023 at 4:33=E2=80=AFPM Andy Shevchenko
> > > > > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > > > > On Thu, Oct 26, 2023 at 03:27:30PM +0300, Andy Shevchenko=
 wrote:
> > > > > > > > > > On Thu, Oct 26, 2023 at 07:25:35AM +0200, Greg Kroah-Ha=
rtman wrote:
> > > > > > > > > > > On Wed, Oct 25, 2023 at 09:42:57PM +0300, Andy Shevch=
enko wrote:
>
> ...
>
> > > > > > > > > > > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.=
org>
> > > > > > > > > >
> > > > > > > > > > Thank you, Greg.
> > > > > > > > > >
> > > > > > > > > > Bart, would it be still possible to take this into next=
?
> > > > > > > > > > I would like to have at least this patch applied (with =
the first user)
> > > > > > > > > > to allow conversion of others (I have some more users o=
f new API).
> > > > > > > > >
> > > > > > > > > Okay, seems we missed v6.7 with this, can you then prepar=
e an immutable
> > > > > > > > > branch / tag with this, so other maintainers can pull in =
case it's needed?
> > > > > > > > > (I have something against tty already and perhaps somethi=
ng else, let's
> > > > > > > > >  see.)
> > > > > > > >
> > > > > > > > It arrived too late in the cycle, I needed to send my PR ea=
rlier this
> > > > > > > > time as I was OoO this week.
> > > > > > >
> > > > > > > Greg, will you take this patch through your tree and provide =
me with
> > > > > > > an immutable tag for this cycle?
> > > > > >
> > > > > > Sure, let me catch up with patches after I return from Plumbers=
 next
> > > > > > week.
> > > > >
> > > > > Hope Plumbers went well!
> > > >
> > > > Sorry for the delay, immutable tag can be found at:
> > > >       git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-c=
ore.git device_is_big_endian-6.8-rc1
> > > > for anyone to pull from now.
> > >
> > > No problem and thank you!
> > >
> > > Bart, can you pull that? Or should I to my tree and then push with ot=
her
> > > GPIO patches?
> >
> > Ugh, this is rebased on top of 6.7-rc3...
> >
> > My tree is based on rc1, if I pull it, then it'll be a mess.
>
> But v6.7-rc3 is something that is already in the upstream.
> I don't see how it can be more "mess" with this. Whatever...
>

My for-next branch is based on v6.7-rc1 (as it should IIUC) and if I
now pull Greg's tag, I will be sending rc1-rc3 stuff to Linus Torvalds
in addition to the GPIO changes for v6.8. I bet he will not appreciate
it.

Greg: Is it too late to have this rebased on top of v6.7-rc1 instead?

Bartosz

> > Andy: How badly do you want it in v6.8? Can this wait until after the
> > merge window?
>
> I waited for a cycle already with this...
>
> OTOH GPIO part is not anyhow critical from the semantic point of view.
> Since the main patch is in Greg's tree I'll survive with GPIO stuff
> going next cycle.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

