Return-Path: <linux-kernel+bounces-109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2D0813C56
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 811BE1F226A5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A6B2BCF9;
	Thu, 14 Dec 2023 21:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="e3cHDZo+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A606AB80
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 21:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2030fbc2417so2213413fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 13:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1702587987; x=1703192787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=crPiDH9/mhEOg/t9pVVthM+Ufb3xJC9KbI2h6yw2zqU=;
        b=e3cHDZo+CZZgILIpUov29tmVsHzNdfShSvlA58t67CAvzN9xoJW75dPPBArm6MT0bs
         O8z/0dQ4GC2d9vVbkOHEvOIBILID+QZ1eT/R01TsGPCreE1RZSdompqHciKpJ8OxJ2tb
         6+yrOe0Ucgy4yoLWfnX0+xZ+CtYKPcdHqCjNPcOaq/if1Gogw0L3a/A7W4+GzKR0Hdkg
         6LefQMBxBo+OVe5ihJ3HrLxa3hdQWjEienMnPr05bwSILTA+V/p4ROwwcMEBert0binZ
         ygzSyKxDZO/ZDPJCjQPVwtBtir1uqPA0fEh2lpml3MfdsVZAHTQYoYaRVNRvJ+qzLVfB
         xdDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702587987; x=1703192787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=crPiDH9/mhEOg/t9pVVthM+Ufb3xJC9KbI2h6yw2zqU=;
        b=fCqWMSCR/3E9pfraVTP6yBiYoEcxW6zJt6AMLAlDNHGDSzoiKqr/BVaGg0CzgnZ9Gb
         v5uFA+hl0TRP36YzsxcVmJToiDjJQUdFN0Si3xwE7DEtoSmQ3A0dySS5tBcEOTRwN52h
         uFKkN+LazDaMUPHSdpM7ml42HwwOOZFmR/Ckiy6UigQ5DBjRIRSFpjGjCHeAnZwLxaPF
         h3RQku2MMfT+EKAmFQZ3bgjY+c8ygjumezPrIZCdd80HN6BBXjbWlkm9PdH6lAigVqfa
         qGPyQWeAbkJybQPLW+dWmCU5p82IHPQSg+FVRoWKA1+/1zNcT3wtMVTn2rqmfWraT5a8
         dA7w==
X-Gm-Message-State: AOJu0YxxHjyqYVikmaL7pJgafqIAxcXg9fcNnjSmJYOFCrVzF3iZMzDg
	c58XMy7GkRtN6OsEc/1p4NIhoaErARWE5uUTEeEcsg==
X-Google-Smtp-Source: AGHT+IEbW/pRgBRM2Tbl0EiCqw6habcEinR3uZrs3LL79n5Z6/pJtj4vR8fP0YMhjd29+225jiSzc+QCUtTJIpFZtvo=
X-Received: by 2002:a05:6870:4707:b0:203:58cd:21c5 with SMTP id
 b7-20020a056870470700b0020358cd21c5mr1076743oaq.30.1702587987121; Thu, 14 Dec
 2023 13:06:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214095814.132400-1-warthog618@gmail.com> <20231214095814.132400-3-warthog618@gmail.com>
 <ZXsZJ9z7iln8uMf8@smile.fi.intel.com> <ZXsajZoQRw7HgHl1@smile.fi.intel.com>
 <ZXsp8QjxsUMPlZIR@rigel> <ZXswRCsT0OYwHe3N@smile.fi.intel.com>
In-Reply-To: <ZXswRCsT0OYwHe3N@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 14 Dec 2023 22:06:14 +0100
Message-ID: <CAMRc=Md55pSWwbKqxO-eHJyn1+vtLMuWmD0d1_iqFT4h7dJ4Yg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] gpiolib: cdev: relocate debounce_period_us from
 struct gpio_desc
To: Andy Shevchenko <andy@kernel.org>
Cc: Kent Gibson <warthog618@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linus.walleij@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 5:41=E2=80=AFPM Andy Shevchenko <andy@kernel.org> w=
rote:
>
> On Fri, Dec 15, 2023 at 12:14:41AM +0800, Kent Gibson wrote:
> > On Thu, Dec 14, 2023 at 05:09:01PM +0200, Andy Shevchenko wrote:
> > > On Thu, Dec 14, 2023 at 05:03:03PM +0200, Andy Shevchenko wrote:
> > > > On Thu, Dec 14, 2023 at 05:58:11PM +0800, Kent Gibson wrote:
>
> ...
>
> > > > > +static void supinfo_init(void)
> > > > > +{
> > > > > +       supinfo.tree =3D RB_ROOT;
> > > > > +       spin_lock_init(&supinfo.lock);
> > > > > +}
> > > >
> > > > Can it be done statically?
> > > >
> > > > supinfo =3D {
> > > >   .tree =3D RB_ROOT,
> > > >   .lock =3D __SPIN_LOCK_UNLOCKED(supinfo.lock),

Double underscore typically means it's private and shouldn't be used.

> > >
> > > I even checked the current tree, we have 32 users of this pattern in =
drivers/.
> >
> > Ah, that is what you meant.  Yeah sure can - the supinfo_init() is
> > another hangover from when I was trying to create the supinfo per chip,
> > but now it is a global a static initialiser makes sense.
>
> Yep, the DEFINE_MUTEX() / DEFINE_SPINLOCK() / etc looks better naturally
> than above.

Yeah, so maybe we should use non-struct, global variables after all.

Bart

>
> > And I still haven't received the email you quote there.
>
> :-( I'm not sure we will get it, it most likely that I removed it already
> and it has disappeared due to problems with email server...
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

