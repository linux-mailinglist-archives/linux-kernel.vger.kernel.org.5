Return-Path: <linux-kernel+bounces-86805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA4F86CB05
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 482F91F24149
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B78B1361A2;
	Thu, 29 Feb 2024 14:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UbpswQrQ"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FCB12CDB5
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 14:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709215792; cv=none; b=n+gwQtt6iGwOuOASqAis2O6TwD52d7WUl7MCCbdcM128ez12A/dhF0yTMS4rbK/1TXUrcQc24RsKCu7EaHoRLQ3n0zm6U7fCQlHxMLSGM16H/vWbqe9Mi2iWlxOhvaAUBWiK5aJI2el2yeUeAuImnkH7dRiois9D1jpaMctBlvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709215792; c=relaxed/simple;
	bh=FfSK2O6AD7KY0hux96ScCqsOqRO0Lz59WLNhTVBBAX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U6cii4xL/o4peBUZ+ELTl/Vk2JTWEt3f5XKn6wo+BqxiYRVZlzFPJGlMqapkdC/4eKRI36PEPe9subF9gyEJHo9k6SQZNTis1XJt0+v+lpDZItqHg4nUlw0vz/0Zi7tqwWfA3OK9YLnfEfwwx2BljeT6LF2qS1/nf54UUKUsN+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UbpswQrQ; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dc6d8bd618eso1070330276.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 06:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709215790; x=1709820590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dCZRQgUhxexQivOL6D8EzXJinIW1HUKm7gk/Fi/ZAso=;
        b=UbpswQrQD5aXRXXxF1efPXyJt6eOWM8CbtcS8UOSnOtx9hIRSB4+0orQvuZdaNghK0
         CyZuj6K9XwyLVs4cOKWF9cg7MnWc7+hs6ISzbWH4gUBkKGMj+zSslJumthhPO0YaUWop
         FqQKB9TKe2b/b0gMytIjIcyrjeyqZmCwxBTa5YQ8vQjjwqDTsqlfGMljPLGzR7peAz7F
         an2Z7ZwJqfSQeDnudlufA2xNUkjWHi2ok6gPYki8ZVpJ/hGnlqBMixXLdcT/xuQgccPh
         gf8Xywg5A3wwbEpnGOuQglinpP8q8zNBkGx9l7OkJm2H/BJgd5dOzRPl4cjjjP5vNowV
         WRwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709215790; x=1709820590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dCZRQgUhxexQivOL6D8EzXJinIW1HUKm7gk/Fi/ZAso=;
        b=PF6mEPQeOk3JpK598vBPTEGa8wQFJ0Gp8iLW9Uhws0PmOAv2Lj90+0Gh38lHuPMsnn
         KhC6zLwiRBLyiQnkkC1SrC7x7jTnVzIKmLHWDHkTDnvpdJiy4GOseT5H156oxBK25jiS
         jKfhSFrdfLYChPLe9RZaIT6Xf8EFuIabB4xSLQ4ZcP3SWk/Nzr2VM2akqQEQnrgLDBIH
         kfVi92XD/afmxbBrolTY9CnOGrZby5lmYKkZqsQ/pxc2HIsnfxDijMVytu5X6V0kZ9Z8
         RIGqn94rYrMlKDloIsxZduByZWcM5Rs76Jd39oBD5f2s1FZQi6ANbPgXCDe48o1TZHoM
         sRhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUA/BIeTZ6wSSio5mr+8RzQvR5R55vPkBOM5/BJkzk8qn1AUGFnWzesq19jwN76oIv5LJrIZTKgk6fNtRYa8crP+5XUs+ZWwgmVoFwN
X-Gm-Message-State: AOJu0YzTtJIljr5efCzQPJjWq0pAe+4pxqcVdSMHaQtQHSZgTmrfkf3Z
	dDemPQUNRmm5itm0uJ2V4Ymc5uAlDb3nvxNDWlExQsb+uwbOR6ZSLaBKgkViRgEmrn/SEg4bJmS
	JAn82lZXJC28kzlJFokXoHjtD1BKLkP0VblgQYA==
X-Google-Smtp-Source: AGHT+IHNgoJmgHsMUF2LzOKVbicw/p7qtuBgSNpCiAWzz5wuihdd+re/N+5enHodlGjTgoW6XhfhWCHitLhvTrQi/zQ=
X-Received: by 2002:a25:83c1:0:b0:dcf:2cfe:c82e with SMTP id
 v1-20020a2583c1000000b00dcf2cfec82emr2263734ybm.55.1709215789903; Thu, 29 Feb
 2024 06:09:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227113426.253232-1-herve.codina@bootlin.com> <CAMRc=MeSMTnPUYGyJir4fc=6=Gnw_MVP9wfEKMQ6Ck33FYCrRA@mail.gmail.com>
In-Reply-To: <CAMRc=MeSMTnPUYGyJir4fc=6=Gnw_MVP9wfEKMQ6Ck33FYCrRA@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 29 Feb 2024 15:09:38 +0100
Message-ID: <CACRpkdZbGUd-u3ZcmmK1POSEq8z9J1aDhbGPAbcR6guKuEpEFQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] gpio-cdev: Release IRQ used by gpio-cdev on gpio
 chip removal
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Herve Codina <herve.codina@bootlin.com>, Kent Gibson <warthog618@gmail.com>, 
	Saravana Kannan <saravanak@google.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 8:31=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
> On Tue, Feb 27, 2024 at 12:34=E2=80=AFPM Herve Codina <herve.codina@bootl=
in.com> wrote:

> > Herve Codina (2):
> >   gpiolib: call gcdev_unregister() sooner in the removal operations
> >   gpiolib: cdev: release IRQs when the gpio chip device is removed
(...)
> Sorry but this is just papering over the real issue. I'd say NAK for
> now as I'd really prefer to get to the root of the problem and fix it
> for all GPIO interrupt users.
>
> Kent, Linus: what do you think?

I'm not sure. What does "all GPIO interrupt users" mean in this context?

If you mean "also the kernel-internal" (such as some random driver
having performed gpiod_to_irq() and requested it or, taken it from a
phandle in the device tree) then I think these are slightly semantically
different.

The big difference is that users of the cdev are *expected* to *crash*
sometimes, releasing the file handle and then this cleanup needs to
happen. Also cdev is more likely to be used for hotplugged/unplugged
GPIOs.

The kernel-internal users are *not* expected to crash, but to clean up
their usage the right way. Also they are predominantly if not exclusively
used for fixed GPIOs such as those on an SoC that do not hot-unplug
and go away randomly.

Use case 1: you run gpio-mon on a random GPIO with IRQ on a board.
It is using a SoC-native GPIO. Suddenly gpio-mon crashes because
of OOM or whatever and releases the filehandle on the way down.
What to do?

Use case 2: you plug in a USB dongle with GPIOs on. Start gpio-mon
on one of the pins. Unplug the dongle. Then it is fair that the cdev cleans
up the irq, because I don't see any way that a kernel driver would
request any of these GPIOs (but I'm more uncertain here).

I just think it is necessary to think about the big picture here.

Yours,
Linus Walleij

