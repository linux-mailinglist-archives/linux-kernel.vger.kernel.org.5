Return-Path: <linux-kernel+bounces-6878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 836BF819EC9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B628E1C228AE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0300924A16;
	Wed, 20 Dec 2023 12:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MvNF/c5l"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2879C2511E;
	Wed, 20 Dec 2023 12:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-28a5d0ebf1fso521822a91.0;
        Wed, 20 Dec 2023 04:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703074416; x=1703679216; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lkbaWKNWG4TQluqIF/XAJ7K7LvKr8qSqNHNv/8QuIYM=;
        b=MvNF/c5lcZ4VU4OH0qSk8YM6k7lLbnIk5pdhTeBaJItw5nl1Hc3I8N4wGn+HvmNZhc
         MiAyjg/uxtCIzwU48NadTq7+1xh5R5JpDp/NX18N3QlfUOR4mUH6u1mk9FHT0SapeCOt
         cfbAipWWkS2OO1NnBmWeam3vSYBGLTbNBa16nT6eymD7JcVLRqTNqp7FG7S+HlAfMK8u
         zHnxg9FGpTpbdS8xL97lSEqKj47FaTVGit6pTRKJHocDPzhf9I/25shpWTjjzrwPXY+8
         IqHeRToiuVfb5OpD2FLfDG6xXTs0k2bqb6lXuolA8VINgbabIdJQF4tYNYtzVDwtsQ9a
         WUvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703074416; x=1703679216;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lkbaWKNWG4TQluqIF/XAJ7K7LvKr8qSqNHNv/8QuIYM=;
        b=tPbKnB83rjYkhxlftjI23g5tqcJiLyiwp3boeCCrv4tJXGdRqOQ7VoFTDb+obzNtUC
         1dVgmvpTPv345zKiIabddL7c+tOeA5wLZ3GuUoXlh5CnZ8u8eoxGOlwTAIVfgGFpMC02
         fmGER1R6qSt4nOP6qQWiAZm3fWg/o47PqZTdKYgNRJYbVlBO0bYzJaMkFGfTzS9aDhHT
         N07a79gQP3lM9JwfjZswsFGwTYTKehC7S3sHz5KzYHSEZtfusBcdop8RuvyQhhH7lTwZ
         q5rvJQStptbxaUzAQqyy76gC4R9u3NV7kI9EmnpJU3phogi72DQ0E3bGM0d174KhKisk
         MoAw==
X-Gm-Message-State: AOJu0YyH2QiEVnuVC4L4YBvxpv///mdw8B3rqWLHKEySKNvbUAA9b/Nq
	DCr81vf6SDk8eBTqHrwy+jU=
X-Google-Smtp-Source: AGHT+IES1mpG4Qe2wBWXtmr4NcORcJtEtICofgfzJ5NZzKIOvuVmES7rjyL6i1Y6bi2PbffYeNyPdw==
X-Received: by 2002:a17:90a:f293:b0:28b:d2fa:1725 with SMTP id fs19-20020a17090af29300b0028bd2fa1725mr1334548pjb.43.1703074416316;
        Wed, 20 Dec 2023 04:13:36 -0800 (PST)
Received: from rigel (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id n14-20020a17090a2fce00b0028ad32914basm3398249pjm.41.2023.12.20.04.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 04:13:36 -0800 (PST)
Date: Wed, 20 Dec 2023 20:13:31 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, andy@kernel.org
Subject: Re: [PATCH 4/4] gpiolib: cdev: replace locking wrappers for
 gpio_device with guards
Message-ID: <ZYLaayENrvL1Nh6H@rigel>
References: <20231220015106.16732-1-warthog618@gmail.com>
 <20231220015106.16732-5-warthog618@gmail.com>
 <CACRpkdZ5HzOxtbexQNE-A-bKhiUW1nHjvJQA_CCnmVXf+R6dbg@mail.gmail.com>
 <CAMRc=MfvKzOxPrmz1wmgWMwYUbNhWAjqoKOmcaggQntcDprLmQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MfvKzOxPrmz1wmgWMwYUbNhWAjqoKOmcaggQntcDprLmQ@mail.gmail.com>

On Wed, Dec 20, 2023 at 01:05:35PM +0100, Bartosz Golaszewski wrote:
> On Wed, Dec 20, 2023 at 12:56 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> >
> > (+PeterZ)
> >
> > On Wed, Dec 20, 2023 at 2:52 AM Kent Gibson <warthog618@gmail.com> wrote:
> >
> > > Replace the wrapping functions that inhibit removal of the gpio_device
> > > with equivalent guard macros.
> > >
> > > Signed-off-by: Kent Gibson <warthog618@gmail.com>
> > (...)
> > > +DEFINE_CLASS(_read_sem_guard,
> > > +            struct rw_semaphore *,
> > > +            up_read(_T),
> > > +            ({
> > > +               down_read(sem);
> > > +               sem;
> > > +            }),
> > > +            struct rw_semaphore *sem);
> >
> > Isn't this so generic that it should be in <linux/cleanup.h>?
> >
> > Otherwise all the patches look good to me.
> >
>
> We already have this:
>
> DEFINE_GUARD(rwsem_read, struct rw_semaphore *, down_read(_T), up_read(_T))
> DEFINE_GUARD(rwsem_write, struct rw_semaphore *, down_write(_T), up_write(_T))
>
> DEFINE_FREE(up_read, struct rw_semaphore *, if (_T) up_read(_T))
> DEFINE_FREE(up_write, struct rw_semaphore *, if (_T) up_write(_T))
>

Ah - in rwsem.h - I missed that.

> This can surely be used here, right?
>

Don't see why not.

I would still like to move the gpio_device specific macros to gpiolib.h,
as they apply to the struct gpio_device defined there.
The naming probably needs some reworking, so open to suggestions on
that.

Cheers,
Kent.

