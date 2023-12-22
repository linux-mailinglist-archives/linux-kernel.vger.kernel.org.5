Return-Path: <linux-kernel+bounces-9765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7D281CB19
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 15:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D120284EFD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 14:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366621C2BE;
	Fri, 22 Dec 2023 14:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="CRxxr7Dx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595111A598
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 14:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3bb69f38855so1305549b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 06:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1703253952; x=1703858752; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XP2AexlV3G7GLuTlAIigyiZXkG8ARUrxAREXhx19OIc=;
        b=CRxxr7Dx+KIuwH4p4SqMpnY/MmiidheA4ARwVZwM0GwJTXdErf0FyTXPZAa2gu9oCz
         Xde5WG5asDAu0+qrzElp2V3HSOwKYtkQZiaFm8HKox2tJsh8HaxTP2TbF6ljtTzoSocY
         V6zlxBYH0ZF2SQCcgb4Gh1EbaaHL+7zdzI1rFOCf+RK3cMfffNC6/KGqiPeaG4yOwdno
         9AiLvRrKyXJipiur3VKyxbpLREQij1S93xdlAykSpC4otsr/+qYqr/UriLlJvkxcHfF/
         DszXdNW4KBmfYwKLrq67IxrKNzhVT1xDp9YqyeObANbDeQmtrEE4nxfJc/BX4T5aW08C
         cfLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703253952; x=1703858752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XP2AexlV3G7GLuTlAIigyiZXkG8ARUrxAREXhx19OIc=;
        b=PntetvFzHHhDjt4oIm57Pk/TXfNbZjyFKNkEMAZ2unkNOqCPj5TYwXmH/mJhjLatqq
         d0JZ2UqdeKEQqdtp3iT0t12yd6ZA7qADDtiWruoEKTl82sn0qzIcdcbAfkK3JT2r56Kr
         ukYMg8x1ah4f/uwn7ucH0UmR6E3TNOaU6K60e6YRJXBH7xJef1O3r7L+ZfRayStxDV4k
         Ib9p51YJPMEoRiJO6OZpexOM7LAyAySnFVi8DU/jzUWrGDQfykbnHuu/AMAM6mwsIqbv
         CCoXhXxZwaKAPkbJNmKWI8cD0ZBujKEuL+CaInBm9As/BTAPIlMHPMqOPRVYt6+txSUZ
         hzcg==
X-Gm-Message-State: AOJu0YymaCEae+lJNrNjk53imZ3nL0ky3tPahHR/OjdKv6G50YGH76sD
	zMod4cdba1kHgFC1IiGv/C5AvKiGuvkj6QR6i+Ifes79Np5p1A==
X-Google-Smtp-Source: AGHT+IHqomwhF8gp66qp6LpDykubtc33/bXLehHqj7Aazh00uMJhgj0smZ5DATitoAGazHvnGxUpfFbOmRT//5j9GVI=
X-Received: by 2002:a05:6358:4291:b0:173:262:60b1 with SMTP id
 s17-20020a056358429100b00173026260b1mr1377603rwc.63.1703253952327; Fri, 22
 Dec 2023 06:05:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221012040.17763-1-warthog618@gmail.com> <20231221012040.17763-6-warthog618@gmail.com>
 <ZYReZI_TnX1MyvP7@smile.fi.intel.com> <ZYTcn-UX0TUM5P9O@rigel>
In-Reply-To: <ZYTcn-UX0TUM5P9O@rigel>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 22 Dec 2023 15:05:41 +0100
Message-ID: <CAMRc=MfNme1VavLNnX9whjgohNCs4Q5qADByX8c_tdw05UVYUA@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] gpiolib: cdev: replace locking wrappers for
 gpio_device with guards
To: Kent Gibson <warthog618@gmail.com>
Cc: andy@kernel.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linus.walleij@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 1:47=E2=80=AFAM Kent Gibson <warthog618@gmail.com> =
wrote:
>
> On Thu, Dec 21, 2023 at 05:48:52PM +0200, Andy Shevchenko wrote:
> > On Thu, Dec 21, 2023 at 09:20:40AM +0800, Kent Gibson wrote:
> > > Replace the wrapping functions that inhibit removal of the gpio chip
> >
> > GPIO
> >
>
> Bart, I don't care either way and not enough to respin a v3.
> If it bothers you could you fix it on the way in?
>

Sure!

> That is if you aren't too busy reversing xmas trees ;-).
>

Joke's on you, I actually do find them easier to read and try to use
them everywhere in new code I write. :)

Bart

> Thanks,
> Kent.
>

