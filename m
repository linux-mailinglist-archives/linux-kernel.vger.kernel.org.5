Return-Path: <linux-kernel+bounces-8119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D49B281B25C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 127111C244C6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67AF4CB59;
	Thu, 21 Dec 2023 09:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="xVuVli6c"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68FA4CDF4
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 09:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-466cf6fab0aso53844137.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 01:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1703150774; x=1703755574; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gk+0buIHnn5B1pDfrVBgAlFPQ+p7oDkf5Qf9+5+b3Xs=;
        b=xVuVli6cVwjdD59LyTzVCoC1pYuQ6CL+1o+SD7udSoJvwfAShNtw1p5u22AGkhZRN1
         Bryhz/hpW7q9BMNccSRummkrSxKaPPMvmsuFqamCzJBgE3+SLAbd57P6eF9iPXRXq4we
         NNLIN2cGVwFx452zs2xzMST/Dxt+cdSS3Ns4fyopeSQpLb8ZOpBsoYoZnGUswWwZpq71
         k2Nw9LQ/46AWgULMPFhhUtiNefOBa6dwGphWGMVLdPg5ldZaALHVYWwJTQDEIrSQwPcd
         v3lFAYzOdnyKTxg9ZN7um2iec0TQlqHvtFlsbaMAFijzjZuPZJjyz28uvjR8mQfnFdpS
         wsSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703150774; x=1703755574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gk+0buIHnn5B1pDfrVBgAlFPQ+p7oDkf5Qf9+5+b3Xs=;
        b=kjt7Q+u/1uE8B4A820VmRQM1506adNemfl5qZXD7hDa/q2gyAib4FLxFX2H8gj69/Q
         xhyg+bQg56108/MfsCqXReU9TGMELg3svAQrHeNg2AQ68E5lI8QQ3hPBDEPVxwqJX1zN
         tqQ9+HauoIa7wF0saNsugcyl4SKMDtK/szz1meRtcLeAIiYj80v5BquoEQF1nVWN3/HS
         EkeE67pogolptt0GNzMPmiPm9K5xCxPYmfo4ax5Tat2WdmCr9aJCUFS7VyF+0b4qncL1
         R8RW6Z0j4CLKZNVb0PnwcwJRH/Y13WO7wlx4OYRYhJQL3ePZs+a2H1kHet0Qs4wNkP75
         V4HQ==
X-Gm-Message-State: AOJu0Yw0g0VXBgWe6iLDV4eBokvRlHVf4aw1dgZyevX5Mgt5KmXtqDTF
	9p2zPVlzBXr7ScKMNonEItYCiCz89UhHLf/OOOBgqA==
X-Google-Smtp-Source: AGHT+IGTihQckbMQHTNC3UcJXcLAVe6JnYF0NAspcuEnOya+pEHOGU76yy8KCiIq9oaidV2vNVq4Amrg23Je7L8rcC4=
X-Received: by 2002:a05:6102:3712:b0:466:8743:5ed5 with SMTP id
 s18-20020a056102371200b0046687435ed5mr802212vst.53.1703150774506; Thu, 21 Dec
 2023 01:26:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219201102.41639-1-brgl@bgdev.pl> <ZYL0MWAQ-frYLnZq@smile.fi.intel.com>
 <CACRpkdZB-5DN5NYJNGheDJnNWRt8x4LwgOQpL4NDyX2JSn+_9g@mail.gmail.com>
In-Reply-To: <CACRpkdZB-5DN5NYJNGheDJnNWRt8x4LwgOQpL4NDyX2JSn+_9g@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 21 Dec 2023 10:26:03 +0100
Message-ID: <CAMRc=MfLXxfzhKDc9e3jRF9mdVo=9UnC9O+i9s-uGm2pEa7vMg@mail.gmail.com>
Subject: Re: [RFC PATCH] gpiolib: remove extra_checks
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Kent Gibson <warthog618@gmail.com>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 4:28=E2=80=AFPM Linus Walleij <linus.walleij@linaro=
.org> wrote:
>
> On Wed, Dec 20, 2023 at 3:03=E2=80=AFPM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Dec 19, 2023 at 09:11:02PM +0100, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > extra_checks is only used in a few places. It also depends on
> >
> > > a non-standard DEBUG define one needs to add to the source file.
> >
> > Huh?!
> >
> > What then CONFIG_DEBUG_GPIO is about?
>
> Yeah that is some helper DBrownell added because like me he could
> never figure out how to pass -DDEBUG to a single file on the command
> line and besides gpiolib is several files. I added the same to pinctrl
> to get core debug messages.
>
> I guess Bartosz means extra_checks is =3D=3D a non-standard DEBUG
> define.
>
> Yours,
> Linus Walleij

I think this patch is still correct. Defining DEBUG makes sense to
enable dev_dbg() messages. CONFIG_DEBUG_GPIO is used by one driver to
enable code that can lead to undefined behavior (should it maybe be
#if 0?). So the Makefile bit and the Kconfig option can stay but I'd
love to see extra_checks gone.

Bart

