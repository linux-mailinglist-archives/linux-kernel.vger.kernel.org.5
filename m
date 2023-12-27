Return-Path: <linux-kernel+bounces-12058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E538881EF88
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 15:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 209701C2187B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 14:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB07D4594A;
	Wed, 27 Dec 2023 14:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="QVlF2r+o"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629EC4502C
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 14:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-7cc14b91230so3578330241.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 06:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1703688405; x=1704293205; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d4Y7smc2pkp/vBMB9fXvY7F4m1V5SMuNQGmvZZc5JqI=;
        b=QVlF2r+ohzHZoMFe5gR8TKTwiO2FO0dzVtIOL3Koug4CDsIH+Cm+bxd0z2Hl3Q+Djq
         qx/2v5KDaGrxiJbOfrxXzrdWNW4n6mKWfMEczvXdecMxHfccVRKoatg959TI3fhb5VEh
         pokcvfRNSwuQpp+/Lqnq/fs2JVJU6wH/fhvBIO3syjMTg/k6naZcWGZrWvGArpmWf+U6
         PEOprLeL6sWnl6hkaZyBQKuaWna+IxoCwlqsKbj7AuvymZbBB2gd1+R4Dk+SKtA3K/Dr
         Ez9uRAk1qjTIQmcibGoPMUrapZbWK0vEZ6lld054r2JRTCw2QusNLeWC9YSiod4UkPR/
         gjCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703688405; x=1704293205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d4Y7smc2pkp/vBMB9fXvY7F4m1V5SMuNQGmvZZc5JqI=;
        b=bqjnuucGVq3Ean0fptKVun+x5TcY5c/RQNkzIVikMtkfd5dq83t8xtr0ZjrVJ+CDbe
         Txi31bHozPSuZQM1A5fVAX+VpedWoHnbIXuO7vOsAviQ42ALyd1KZarbDyBvrLZtmuY2
         hPn47kAPJHGN1bqjW6NC+LRFrnnM4Co3t7UdhDfbiFrSIH8ORyA7mQrBjWa8oW1dRfrg
         8visPzHCEZvlgv5Eo0pB246d4MOhvAmZRMEImpWWDvV5QxTfVaR/yXs5ntzxfYmX12vT
         d1Q6G7MiLzU9FSYO0dI5/owTgrEUgKNlriv8sZILfVgi5ZTrG9znxW7qaY4jgJqUb57T
         vQ+g==
X-Gm-Message-State: AOJu0YxfmCmKITt622WcDL37l9iafXwZEVTS6Ie/bUjoQcAXX4KEaXqC
	tt9TZFIlHVmMD65JQ/audp4D8AsPjKDXFOS12EDhZXyZYb4M0w==
X-Google-Smtp-Source: AGHT+IFS7xecxURZcVbt+I2hL4uy6bzPQc50FajzGNELsuDtJen9mfaWyBsIUZXoWWC8uZY2zDhd2CiNCF/4WaOtqhA=
X-Received: by 2002:a67:f543:0:b0:466:fb17:bad2 with SMTP id
 z3-20020a67f543000000b00466fb17bad2mr2641352vsn.28.1703688405139; Wed, 27 Dec
 2023 06:46:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221012040.17763-1-warthog618@gmail.com>
In-Reply-To: <20231221012040.17763-1-warthog618@gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 27 Dec 2023 15:46:34 +0100
Message-ID: <CAMRc=Mcg6sT0w4Dfn5MhWcLxUjvJV4rT-Pfoe-fYDe5JhYMpig@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] gpiolib: cdev: guard tidying
To: Kent Gibson <warthog618@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linus.walleij@linaro.org, andy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 2:20=E2=80=AFAM Kent Gibson <warthog618@gmail.com> =
wrote:
>
> This series contains some tidying up of gpiolib-cdev following the
> recent adoption of guard().
>
> The first patch is a fix to protect gpio_ioctl() from having the
> gpio chip removed while the ioctl is in progress.
>
> The next couple of patches are minor fixes inspired by recent
> submissions and reviews for gpiolib.c.
>
> Patch 2 adds a missing include.
>
> Patch 3 switches allocation of struct linereq from kzalloc() to
> kvzalloc() as it can be larger than one page - even more so after the
> recent relocation of debounce_period_us.
>
> The final two patches replace wrapper functions with guards.
>
> Patch 4 tidies up the functions that use a guard on the linereq
> config_mutex.
>
> Patch 5 tidies up the functions that use a guard on the gpio_device.
>
> Changes v1 -> v2:
>  - add patch 1 to protect gpio_ioctl() from chip removal
>  - improve commit comment (patch 3)
>  - use guard(rwsem_read) rather than rolling our own (patch 5)
>
> Cheers,
> Kent.
>
> Kent Gibson (5):
>   gpiolib: cdev: add gpio_device locking wrapper around gpio_ioctl()
>   gpiolib: cdev: include overflow.h
>   gpiolib: cdev: allocate linereq using kvzalloc()
>   gpiolib: cdev: replace locking wrappers for config_mutex with guards
>   gpiolib: cdev: replace locking wrappers for gpio_device with guards
>
>  drivers/gpio/gpiolib-cdev.c | 257 ++++++++++--------------------------
>  1 file changed, 70 insertions(+), 187 deletions(-)
>
> --
> 2.39.2
>

I applied the remaining patches, thanks.

Bart

