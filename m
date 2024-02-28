Return-Path: <linux-kernel+bounces-85722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AD086B9E1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 22:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44C7728C669
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 21:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A062572917;
	Wed, 28 Feb 2024 21:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="HnUDOSYg"
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B5A70030
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 21:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709155701; cv=none; b=bfqUv1qyPvicZRIgDhQP3+Vn4QBfCFJNWc0356fJ4NC/c1YkSCOZcH018Vk+0Dkz7cW6QvMQzvUhDkTzgsoSMYkuIzhfes+3AasBriRCYGIautapwwcFBRX1bX/u/KrR9/wcgTA+TN+lAjJ72wIIBGdXF/wNnwp6vNY7RtMlcZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709155701; c=relaxed/simple;
	bh=Vf0do4mWmyzl8Py+ttYn8ggj8OVTVR5qdBW3AzesKNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sMweog9f06tsw8PbtItTYUudTZ/gnPFGcaOm7j+4oZeJL1XNJJKCTCgEVPIhunrUBABsqWDFZYZjOpkdhKUwAqRkwOpibAUI/72QsxV1zl2mVSCCy+zG55BZz89SwxI3GpXcBMkVId+kLRxQDgoqUFbcp3bHb1M8uzbU89S0als=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=HnUDOSYg; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4caabc3f941so725899e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 13:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1709155699; x=1709760499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P37DoC18sNGnImdksJqYN4+snHz4hsIQQAlSBf7O+w0=;
        b=HnUDOSYgwp2qUVKlB6E9QRUAjkHJQxi9z2LNB4bEeyDRwbCsgQN8DfSokI5/v6/2CU
         fefT2y5KSNyjrcawd82zzt2x9Ouqz/DM3WxUgEASe9dCsjn0r1ax2L3wijFrfUqLhc1s
         83fPTG5OmZuQGbtsVd+4MMGEzLrkNwfpOU7jmaPN82lVEvAvvXYU1npgKELYVho4Gtov
         ghowXnanRoWqUcorfz+atlQ/T4h12MM3tl5UtXHgcbSk24UCcHV2foO+ZBbfbzfQS5vD
         M8dMavfxqA3xFAnD5p/p3Kx1QImcly+G+R912j4Jh68vWfoCk66emRIUl7AwVku+p+lD
         aLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709155699; x=1709760499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P37DoC18sNGnImdksJqYN4+snHz4hsIQQAlSBf7O+w0=;
        b=Hq3bKTKrMU54MbV0jqhMEqwuVtoa71tAoFresp8kX+5Zhif/CEyJE+SnELxqNhnUVr
         XX/OKak11U9f9C8V14BcKh2cS+sNJF+XTl7+73vtfiSd+FBw/Ax/Pr5MlunPD4ElBw+f
         j06Lgnj/OKhH6dNczn/D46XRx7fXJdvRt/D7C3riTxyOq/NnvMjf2KX1ZloIPrPTtePQ
         VAaU8YUINc0yl3Xn9hhtYK6JuKrbVTKKFdSeaTrRW10WnmY4rHq0g2UlQCh6yzT8hOSp
         sEtLoWlGYWPEwoA5zywFAQ++NHEp77z3Ji1FDwJzsJK4WGS37VuiHBGw43GWx3AVOOfj
         oMbg==
X-Forwarded-Encrypted: i=1; AJvYcCUEkMDtWFtnYU36ItZq2tW/Wbl3zWChpyD1TCW/y/SzeLE6IIw9rLhKpAFKwV3zfRcx0SVtq4QHG7XUwh+mwbHE9NLZxqGEUQCyhux7
X-Gm-Message-State: AOJu0Yxuvy355Uc4tPoCaJIYSwug6/2nFw+xOz74Xn+9xpDPJ7D0x+9S
	L/LWNpmlmIeTFMItEumfLwBYH6tYFpqHkpyGdRU5jcI46kNLaMXZi9MU+eq7wn8lvbpAwFZSPRb
	q8j4aDkHDtqBVPyqVwuBQY2WYRvZfmyP3S7Vk1w==
X-Google-Smtp-Source: AGHT+IFQ8d10DnLbr45njbzPMBBRyKRbmpCeLUJYbzk8tW1MlnCX8W5wV56Kff7cnWjI+7dxb7hh1ZtoRVhOrJxf+4k=
X-Received: by 2002:a05:6122:2891:b0:4cf:da07:fb01 with SMTP id
 fl17-20020a056122289100b004cfda07fb01mr617399vkb.8.1709155698890; Wed, 28 Feb
 2024 13:28:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223065254.3795204-1-swboyd@chromium.org> <Zd-CJHkCHpuIEnWh@smile.fi.intel.com>
In-Reply-To: <Zd-CJHkCHpuIEnWh@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 28 Feb 2024 22:28:07 +0100
Message-ID: <CAMRc=Mdapd2jTACGqm-ujZrAunRmNeJ8_3+bpsN4ieCre52yrg@mail.gmail.com>
Subject: Re: [PATCH v2] gpiolib: Pass consumer device through to core in devm_fwnode_gpiod_get_index()
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Stephen Boyd <swboyd@chromium.org>, Linus Walleij <linus.walleij@linaro.org>, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	linux-gpio@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 7:57=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Thu, Feb 22, 2024 at 10:52:53PM -0800, Stephen Boyd wrote:
> > This devm API takes a consumer device as an argument to setup the devm
> > action, but throws it away when calling further into gpiolib. This lead=
s
> > to odd debug messages like this:
> >
> >  (NULL device *): using DT '/gpio-keys/switch-pen-insert' for '(null)' =
GPIO lookup
> >
> > Let's pass the consumer device down, by directly calling what
> > fwnode_gpiod_get_index() calls but pass the device used for devm. This
> > changes the message to look like this instead:
> >
> >  gpio-keys gpio-keys: using DT '/gpio-keys/switch-pen-insert' for '(nul=
l)' GPIO lookup
> >
> > Note that callers of fwnode_gpiod_get_index() will still see the NULL
> > device pointer debug message, but there's not much we can do about that
> > because the API doesn't take a struct device.
>
> Have you seen this?
> https://lore.kernel.org/r/20231019173457.2445119-1-andriy.shevchenko@linu=
x.intel.com

Clearly yes as I queued the first one in that series. The rest did not
make its way upstream for whatever reason. What is your point? You
want to respin it?

Bart

