Return-Path: <linux-kernel+bounces-304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A1A813EF8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 02:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1272E1C2205C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 01:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28325804;
	Fri, 15 Dec 2023 01:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+yPQLDG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DB636A;
	Fri, 15 Dec 2023 01:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6cea1522303so51036b3a.1;
        Thu, 14 Dec 2023 17:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702602278; x=1703207078; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Qgq8YkJxyZInk9093Uzh/x/8Usm0aC9HfAblqWVf/LM=;
        b=M+yPQLDGFPl5vx3Iq0XQDpYu+8v5Y1wavEfut8vCbrEaF8UlXiFpA/VvXnRy9JanLL
         Ary4dzzccqUS57ZknAGbhpDFVCvf4tIEu5KeNH2ijnJMnSJHfYL/0UyYDKWuDsBw4A4+
         3DDBnrajQYoVkbvEs2K/xsICV2hEUS7XmNFkqvKPZCvDUtdiMplLykujodwHvZlAAHus
         zOjToym3OYTAXObPee4nxJyv03FVdtFM07wZmDvLGPa5BodRIBgeL0kxtWRt69JDuBxG
         5jIBiYu2RBnxV7g5EdmXIUvCZwJOUDpq+bfQpqnTw1nz/t2d0RVhYHkh6NJ3F8y75K+3
         3x8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702602278; x=1703207078;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qgq8YkJxyZInk9093Uzh/x/8Usm0aC9HfAblqWVf/LM=;
        b=IJpVQz4fjgUwdLCnPtuDB4pi9Rgqdwh2Fl1VnCrlA3UwxDXCk2U+uR30VTl+NL9lxy
         3dYmvecbqU+ZGUT60SqDesBBP5c7R2gmL7/F4xpHPh4nas07GvtAoOHjGBHYR8hSOcih
         lNjwq7uTXCuE6A/nx0Dl7cf3usrP01H5UENJ44nQcp9ivij9H7/BW3Vl8KoutnsP6pfa
         5xJxELJOJ3+3lDy2tzKK8jgKXaTdVLG9UnKu7s+p2ZlMXyKUSCUrc93yHt7XH5T6vaJc
         VgQtM/o5w3VA16pUDzqONRcNCuaHdJ91xFb1cFYFRBhOFZk83HBFF2FMlbVTYoPwIZs0
         xUYQ==
X-Gm-Message-State: AOJu0Yw1X8LlMumdZAkZY1sO23lEwHbeHbtXJ52Do+U9+BNGyNd1erMZ
	BNPXzN9O+ixQRMmSRrwQXmqrWnGMuzs=
X-Google-Smtp-Source: AGHT+IGp0lSvgJkIKp8yBo/WOBAfCqpTXwPvG/+jnUzbW0VaRcB9vbemyvWgdMXvJpwVZTlGHEdefg==
X-Received: by 2002:a05:6a20:bf10:b0:18f:97c:4f62 with SMTP id gc16-20020a056a20bf1000b0018f097c4f62mr5726129pzb.110.1702602278325;
        Thu, 14 Dec 2023 17:04:38 -0800 (PST)
Received: from rigel (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id y8-20020a17090322c800b001d1ccb0ac98sm13001788plg.272.2023.12.14.17.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 17:04:37 -0800 (PST)
Date: Fri, 15 Dec 2023 09:04:33 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, linus.walleij@linaro.org
Subject: Re: [PATCH v2 2/5] gpiolib: cdev: relocate debounce_period_us from
 struct gpio_desc
Message-ID: <ZXumIX39JRpbYrbw@rigel>
References: <20231214095814.132400-1-warthog618@gmail.com>
 <20231214095814.132400-3-warthog618@gmail.com>
 <ZXsZJ9z7iln8uMf8@smile.fi.intel.com>
 <ZXsajZoQRw7HgHl1@smile.fi.intel.com>
 <ZXsp8QjxsUMPlZIR@rigel>
 <ZXswRCsT0OYwHe3N@smile.fi.intel.com>
 <CAMRc=Md55pSWwbKqxO-eHJyn1+vtLMuWmD0d1_iqFT4h7dJ4Yg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Md55pSWwbKqxO-eHJyn1+vtLMuWmD0d1_iqFT4h7dJ4Yg@mail.gmail.com>

On Thu, Dec 14, 2023 at 10:06:14PM +0100, Bartosz Golaszewski wrote:
> On Thu, Dec 14, 2023 at 5:41 PM Andy Shevchenko <andy@kernel.org> wrote:
> >
> > On Fri, Dec 15, 2023 at 12:14:41AM +0800, Kent Gibson wrote:
> > > On Thu, Dec 14, 2023 at 05:09:01PM +0200, Andy Shevchenko wrote:
> > > > On Thu, Dec 14, 2023 at 05:03:03PM +0200, Andy Shevchenko wrote:
> > > > > On Thu, Dec 14, 2023 at 05:58:11PM +0800, Kent Gibson wrote:
> >
> > ...
> >
> > > > > > +static void supinfo_init(void)
> > > > > > +{
> > > > > > +       supinfo.tree = RB_ROOT;
> > > > > > +       spin_lock_init(&supinfo.lock);
> > > > > > +}
> > > > >
> > > > > Can it be done statically?
> > > > >
> > > > > supinfo = {
> > > > >   .tree = RB_ROOT,
> > > > >   .lock = __SPIN_LOCK_UNLOCKED(supinfo.lock),
>
> Double underscore typically means it's private and shouldn't be used.
>

You mean like __assign_bit(), __set_bit(), __clear_bit() and __free() -
all used in gpiolib.c?

> > > >
> > > > I even checked the current tree, we have 32 users of this pattern in drivers/.
> > >
> > > Ah, that is what you meant.  Yeah sure can - the supinfo_init() is
> > > another hangover from when I was trying to create the supinfo per chip,
> > > but now it is a global a static initialiser makes sense.
> >
> > Yep, the DEFINE_MUTEX() / DEFINE_SPINLOCK() / etc looks better naturally
> > than above.
>
> Yeah, so maybe we should use non-struct, global variables after all.
>

Despite the 32 cases cited that already use that pattern?
9 of which use __SPIN_LOCK_UNLOCKED().
Sounds like a pretty convincing argument to use the struct ;-).

But lets keep it as kosher as possible and split out the struct :-(.

Cheers,
Kent.


