Return-Path: <linux-kernel+bounces-6888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6531819EEF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BAC9B22DA2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3953E22327;
	Wed, 20 Dec 2023 12:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PW5gFxih"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4B92231D;
	Wed, 20 Dec 2023 12:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6d939e2f594so1228782b3a.3;
        Wed, 20 Dec 2023 04:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703075026; x=1703679826; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q1BmfOuJ/nC4azqVvfd32SdWAPJ2rXjTMAy2RPZH1F0=;
        b=PW5gFxihUMklAnwSNPumrA/hkkOvR/xZcc+aWqxscMuZ5ircGraN6mJrl5HMwjdbLw
         O1nRtNu5roxE1QnzpuyRpIxFkC9S+ib8RgKCMUUl1XwsIz1rDTuPxMXDbxrRBjzPFxEu
         e2mySmaEVDO5pi5Fx9HgnQ3bs3yu2GSsdh7DUcKTkCkVxerFXfqjtdg9+2vJ0M6Jjdyw
         GGYTF24hfyzJWRDG1073tyS78diHUwftP+oxhcr7LMsCB8fkPrB/Xg4juGHswzDj51zI
         GGv6EURQ4lrDccD4EmMRzb/V9jadsPpzWZjTSx+hs8xj42Q4L2Ikc4zajPyOAZg2UNZg
         cIJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703075026; x=1703679826;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q1BmfOuJ/nC4azqVvfd32SdWAPJ2rXjTMAy2RPZH1F0=;
        b=HGCS0zyhL0sCBI2HrguYg4lK9hbo4reanj+8cbycbWliJQNJRPv7D5mOmY9ga+XTg+
         6VL/9bi0PJDZBcWz+x5hFakTDl0/ccOV4gItSi+8kI+zkPn/3QvR1+q6QjmWR8ZY5VMe
         ikaEUYSKMxiCXca8KhCVM/6R8JKt3aM45URDB+b/AoME2USzSzeQDNAb1GZrhOeKUWPm
         o48bJXAE0nBw1YgTkEPL7VJ4VG64cfMyru2qYYD2wvlxk6kafx2VNXx4IkpUdwlEO0Jn
         0dLGbwX4ocXPkmz5qKp8z7JOVIbzioWggOXtKJ3orpfxbkq1uMArgDLU9+AjjoHJAjJ1
         ogAQ==
X-Gm-Message-State: AOJu0Yxnnreg2+ztxoHGg60nAuR9I0eKHgF68y2c4FlTM07n+QW8taRr
	eSC/EnnBN3TVKPBlnx9X+ofYCi605kI=
X-Google-Smtp-Source: AGHT+IEH0c8yEeaTJNAQIDgPycAKBmTWSkgWOaJCiaQT4KIrZQf5c7jX7ao+QHGOsvxaTyNwIfvcuQ==
X-Received: by 2002:a05:6a21:3389:b0:194:cf29:1ca0 with SMTP id yy9-20020a056a21338900b00194cf291ca0mr803645pzb.93.1703075026571;
        Wed, 20 Dec 2023 04:23:46 -0800 (PST)
Received: from rigel (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id u33-20020a17090a51a400b0028bdb4cc5basm374005pjh.0.2023.12.20.04.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 04:23:46 -0800 (PST)
Date: Wed, 20 Dec 2023 20:23:41 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, andy@kernel.org
Subject: Re: [PATCH 4/4] gpiolib: cdev: replace locking wrappers for
 gpio_device with guards
Message-ID: <ZYLczeiVDjd2cWQF@rigel>
References: <20231220015106.16732-1-warthog618@gmail.com>
 <20231220015106.16732-5-warthog618@gmail.com>
 <CACRpkdZ5HzOxtbexQNE-A-bKhiUW1nHjvJQA_CCnmVXf+R6dbg@mail.gmail.com>
 <CAMRc=MfvKzOxPrmz1wmgWMwYUbNhWAjqoKOmcaggQntcDprLmQ@mail.gmail.com>
 <ZYLaayENrvL1Nh6H@rigel>
 <CAMRc=MfyCBpZ07SYfxMtug6FVYiKA0MRgvjMTOAzKiVLGdPM+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MfyCBpZ07SYfxMtug6FVYiKA0MRgvjMTOAzKiVLGdPM+w@mail.gmail.com>

On Wed, Dec 20, 2023 at 01:16:00PM +0100, Bartosz Golaszewski wrote:
> On Wed, Dec 20, 2023 at 1:13 PM Kent Gibson <warthog618@gmail.com> wrote:
> >
> > On Wed, Dec 20, 2023 at 01:05:35PM +0100, Bartosz Golaszewski wrote:
> > > On Wed, Dec 20, 2023 at 12:56 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> > > >
> > > > (+PeterZ)
> > > >
> > > > On Wed, Dec 20, 2023 at 2:52 AM Kent Gibson <warthog618@gmail.com> wrote:
> > > >
> > > > > Replace the wrapping functions that inhibit removal of the gpio_device
> > > > > with equivalent guard macros.
> > > > >
> > > > > Signed-off-by: Kent Gibson <warthog618@gmail.com>
> > > > (...)
> > > > > +DEFINE_CLASS(_read_sem_guard,
> > > > > +            struct rw_semaphore *,
> > > > > +            up_read(_T),
> > > > > +            ({
> > > > > +               down_read(sem);
> > > > > +               sem;
> > > > > +            }),
> > > > > +            struct rw_semaphore *sem);
> > > >
> > > > Isn't this so generic that it should be in <linux/cleanup.h>?
> > > >
> > > > Otherwise all the patches look good to me.
> > > >
> > >
> > > We already have this:
> > >
> > > DEFINE_GUARD(rwsem_read, struct rw_semaphore *, down_read(_T), up_read(_T))
> > > DEFINE_GUARD(rwsem_write, struct rw_semaphore *, down_write(_T), up_write(_T))
> > >
> > > DEFINE_FREE(up_read, struct rw_semaphore *, if (_T) up_read(_T))
> > > DEFINE_FREE(up_write, struct rw_semaphore *, if (_T) up_write(_T))
> > >
> >
> > Ah - in rwsem.h - I missed that.
> >
> > > This can surely be used here, right?
> > >
> >
> > Don't see why not.
> >
> > I would still like to move the gpio_device specific macros to gpiolib.h,
> > as they apply to the struct gpio_device defined there.
>
> Which ones? Because I'd rather use guard(rwsem_read)(&gdev->sem); than
> some custom wrapper as this one's purpose is clearer.
>

It would be read and write guards for the gpio_device.
cdev would only be using the read flavour.
And possibly named something other than read/write as the purpose is to
prevent (read) or allow (write) object removal.

I though that would be clearer than having to reference gpiolib.h to see
what gdev->sem covers, and allow you to change the locking
mechanism later and not have to update cdev.

Cheers,
Kent.


