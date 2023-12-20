Return-Path: <linux-kernel+bounces-6863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF53B819EA2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DC801F21DE9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C75521A1B;
	Wed, 20 Dec 2023 12:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="xkfVg7Lu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF26D21A17
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 12:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4b6c2480cccso399496e0c.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 04:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1703073947; x=1703678747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1O3fH5F/2k+zvACiQXlK4EHQyie/8D92M+3sR3gcN0=;
        b=xkfVg7LuXGJaPY91v+8pVfbfNOsr1J94uVy8hNkGk/6SCCg1mPjfGDrUXowPp45JY+
         Ee5tH7vlLMPbm9VuNsaM+sItusNrb8Hlo1DEdsWcYzZp5mSHEm2m+O8ROWMHzANLjlb6
         94Zq69H0lRXPSpRuuXbThgY0owCsbvm4qU8eu/bZHME/JLTMVlUuVQYYUrX58vpBW+Sv
         J46N9+unW777fWWwyUUncAoXR+KOzhtxY4HpW7JiiUjxp1QzEPCJJ81RTe8HisklmQjA
         xN3cFIxiPL+8KyNQGIsrTFdp8RpPkHmMKlUFgNSCwKYFEaMU1/I5aaCWB+QNdMTtX1tT
         pWOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703073947; x=1703678747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k1O3fH5F/2k+zvACiQXlK4EHQyie/8D92M+3sR3gcN0=;
        b=flCrWLUkGe5ObzbVxrWFQ3l33Ox1z3OKDgoyUXqHNVu7NSbv3YV5nK+sN8vbjCXLt4
         0JVY9P4Fduoshy62FvQLWSblaOI6zOEwtkgLzFpYQDgQXPgZrJCCnUdEQTUFS5W7uLYO
         LBYtsl2i+Y5WHIJmjGA05IeD9ngx9F99tv9WA4pgMXkbenr8BHl+kr9eglUF+mJGlSHA
         jqnNiBtZ7LVuRtkzipfKCF+E4+M+3qAQtFWGXEqfnRLr26a3AYu8Y2Uj/iVdIyuEeC2o
         uoY84ma+eD08meGDM5MzgwEv0pWWysn3p4B2S5vsdZOKhBwXuon2PI91SfPzUk5zM5ev
         +q9g==
X-Gm-Message-State: AOJu0YwvZmOmtzxupGwCw0mA5pMO+h4EXRuh/F7HPlqf43dfaw/T6eJZ
	zn9fD6yD73IRoHZgEYTtrFc8FyyMTI5WLsClhHB3pg==
X-Google-Smtp-Source: AGHT+IHaJaqNQUtVkuvmHQaGhi5+CV9lQS360jN6U7r7hosI3GXZMcjkl8ZNQhlDNP67k+/WQccYLEqspxkr1pZk65Q=
X-Received: by 2002:a05:6122:3881:b0:4b6:df02:52e with SMTP id
 eo1-20020a056122388100b004b6df02052emr2057183vkb.7.1703073946946; Wed, 20 Dec
 2023 04:05:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220015106.16732-1-warthog618@gmail.com> <20231220015106.16732-5-warthog618@gmail.com>
 <CACRpkdZ5HzOxtbexQNE-A-bKhiUW1nHjvJQA_CCnmVXf+R6dbg@mail.gmail.com>
In-Reply-To: <CACRpkdZ5HzOxtbexQNE-A-bKhiUW1nHjvJQA_CCnmVXf+R6dbg@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 20 Dec 2023 13:05:35 +0100
Message-ID: <CAMRc=MfvKzOxPrmz1wmgWMwYUbNhWAjqoKOmcaggQntcDprLmQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] gpiolib: cdev: replace locking wrappers for
 gpio_device with guards
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Kent Gibson <warthog618@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, andy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 12:56=E2=80=AFPM Linus Walleij <linus.walleij@linar=
o.org> wrote:
>
> (+PeterZ)
>
> On Wed, Dec 20, 2023 at 2:52=E2=80=AFAM Kent Gibson <warthog618@gmail.com=
> wrote:
>
> > Replace the wrapping functions that inhibit removal of the gpio_device
> > with equivalent guard macros.
> >
> > Signed-off-by: Kent Gibson <warthog618@gmail.com>
> (...)
> > +DEFINE_CLASS(_read_sem_guard,
> > +            struct rw_semaphore *,
> > +            up_read(_T),
> > +            ({
> > +               down_read(sem);
> > +               sem;
> > +            }),
> > +            struct rw_semaphore *sem);
>
> Isn't this so generic that it should be in <linux/cleanup.h>?
>
> Otherwise all the patches look good to me.
>

We already have this:

DEFINE_GUARD(rwsem_read, struct rw_semaphore *, down_read(_T), up_read(_T))
DEFINE_GUARD(rwsem_write, struct rw_semaphore *, down_write(_T), up_write(_=
T))

DEFINE_FREE(up_read, struct rw_semaphore *, if (_T) up_read(_T))
DEFINE_FREE(up_write, struct rw_semaphore *, if (_T) up_write(_T))

This can surely be used here, right?

Bart

> Yours,
> Linus Walleij

