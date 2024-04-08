Return-Path: <linux-kernel+bounces-135857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8056789CC1A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 20:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2329F1F2312B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07BB146D40;
	Mon,  8 Apr 2024 18:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="h/DtSveP"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C801448FA
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 18:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712602672; cv=none; b=lURKtYxsev6XSFmB3kyShD0ho7LozCR/YSQQoMrrpc++OgNhdpeFFQff5BCxplxIUBFrIr8G5iiciTRrm4JTf6t35SDoNjVP7EP3IKNWTEmt/rNuvG/1TCilfrG9Nxr/aU9FBJbpmrwRcwz+8hLpcIWXi3wb8E0+Tx+JGQyCKxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712602672; c=relaxed/simple;
	bh=qzMVtomWBHH/q1o9JN5nSI2Ab8UZERfcb/xKvfW9GNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KZbVa4J/vyMxIDbbSsxTGlGDYE4DNZRwM5GqRRZ9lTSUQgwja9hKK4PRacxovAlVah5J1dlDQ2m2V+xOud/1eFxBysvzj8UxP2qhz3fijBYwrRTgPiX0rWxfXS0RSKovWHQeO/x8XgOzhFiSNfo90geWn2KR9kav+xI0LjDto1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=h/DtSveP; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d886f17740so16852461fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 11:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1712602669; x=1713207469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qzMVtomWBHH/q1o9JN5nSI2Ab8UZERfcb/xKvfW9GNk=;
        b=h/DtSvePK8C31RgvULFRldIiryumbz88mvrezBNxLvUbqW8JDPh84WjSmIeXCJ5JOz
         TcC5NUG2taiz15xRljkM/2zFRuemHUIZ0lQBdbVYb7u0eRubdpYlgSDIGSW4JD9imnEe
         Jyxehwg7rJmrAxQ4J16UH8T5UAxRu4BmNlinK3OPqP7tvnClUjTCWb6Gh9Z8PC2zihoV
         FSunroSpeciaJ72P+Va33wZ3sdGv2OEHx63qvsn6Ialyd2GZjHcnYONPIDEEyzQ/08ND
         13Bci++9s9C/pAaJcGf9PRDOr6yp4R4DTWRkijBvXCxkeKgDWkXuEStD3Bs0ypDXwK9V
         YgMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712602669; x=1713207469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qzMVtomWBHH/q1o9JN5nSI2Ab8UZERfcb/xKvfW9GNk=;
        b=AsbGWdVfJTmr81l1YOHWzbbKRPDolZZ7rubn4c7BMq6BYp/7IkokcbZInFGC51qrWE
         /Po76UZWKHAabfvb043P8OCMhg6i0/hyA9A8idryNnkvQApWiMEftnajm6gAxDS4pp38
         87eHrBIrIkl75eqigTTKpOtmBzpib7jRn8zGxZo0mlEsq7J81kGsESsLb0+MY5dNNVHb
         ScYgA2YUzyYVQ8WMqPdAQYPbDKhet9S6Z0g+gtyldyQ3I+Bo6Gpff40inaykiM2qhBer
         ngC5y/Rm+yRkLKg6rK2wSCU0iL2tYKEFvs6xYjJbt+F2Cyk8vybcmzWhIQ078njg6+pn
         SN0A==
X-Forwarded-Encrypted: i=1; AJvYcCV91QM/UNks333FaH4UCNxlzkgS6mZobk4+cdn8xtUexWOaVYI11Fn4cAoEatbw0RsuchCcWJEIFik3ktw5pkR5AYWX+de7RHlxlQBn
X-Gm-Message-State: AOJu0Yw9SJwXXrAkr6LlZJWPJs6wy4RKM2voRByk+4XXMLPi10uYBSpm
	FZzuCrl9jATFeDteQzFwwP3Yj64/wHrResKLOhfWCi/EYZdCxGEvHpnmRv/Z25Dgc2klhrlVx5a
	GuAMgaJ0CcFiHA5HMV/YhXJrwlk/bNM3g/uWIhQ==
X-Google-Smtp-Source: AGHT+IG/V0WevA+gGnLBGUVboZpOtRSJTBPnNbrVTs6uKeBTGnC1leaKVEdfjKZdiI8D3lc/CAFmDjpZA1HPNLx1mCM=
X-Received: by 2002:a2e:7202:0:b0:2d8:7c80:5cb4 with SMTP id
 n2-20020a2e7202000000b002d87c805cb4mr141766ljc.11.1712602668954; Mon, 08 Apr
 2024 11:57:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227113426.253232-1-herve.codina@bootlin.com>
 <CAMRc=MeSMTnPUYGyJir4fc=6=Gnw_MVP9wfEKMQ6Ck33FYCrRA@mail.gmail.com>
 <CACRpkdZbGUd-u3ZcmmK1POSEq8z9J1aDhbGPAbcR6guKuEpEFQ@mail.gmail.com>
 <CAMRc=MeqiYZv3ViHRKKUsXTqG5Pc8Ev2jUcN=A4VuX3RU7dDtw@mail.gmail.com> <20240408152715.37948577@bootlin.com>
In-Reply-To: <20240408152715.37948577@bootlin.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 8 Apr 2024 20:57:38 +0200
Message-ID: <CAMRc=McFOe+B13Q7t1wdL3DiF21ga5+Maq59yXhZ_F7B0TKxEA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] gpio-cdev: Release IRQ used by gpio-cdev on gpio
 chip removal
To: Herve Codina <herve.codina@bootlin.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Kent Gibson <warthog618@gmail.com>, 
	Saravana Kannan <saravanak@google.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 3:27=E2=80=AFPM Herve Codina <herve.codina@bootlin.c=
om> wrote:
>
> Hi Bartosz,
>
> On Fri, 1 Mar 2024 08:21:09 +0100
> Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> ...
> >
> > I DO want to fix it, don't get me wrong. I don't want to just leave it
> > like this, especially since we've made so much progress with
> > hotpluggability recently. I just don't believe this is the right fix,
> > I will try to come up with a solution that addresses the issue
> > globally.
> >
>
> I didn't see anything but I could miss something.
> Did you move forward on this topic ?
>

No, I'm currently spending almost 100% of my GPIO time on getting the
libgpiod DBus API ready and I should send the first version by the end
of this week. After that I'll be at EOSS and then on vacation, so the
earliest I will get to working on it is early May.

If you feel like giving it another shot - go for it. I believe the
device link problem I described previously[1] must be fixed first. I
would also consider a more generic solution in the interrupt subsystem
that would make it aware that interrupt controllers may be torn down
with interrupts still requested.

As I said: I will get to it but not in the following couple weeks.

Bart

[1] https://lore.kernel.org/lkml/CAMRc=3DMf5fRWoOMsJ41vzvE=3D-vp3wi-Obw=3Dj=
5fBk3DuQaZNQP2Q@mail.gmail.com/

