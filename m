Return-Path: <linux-kernel+bounces-72511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2183585B47F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC97A1F21511
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE3D5C5FC;
	Tue, 20 Feb 2024 08:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dD7hcwNW"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C365C04C
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 08:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708416437; cv=none; b=Yv/kON9zoy8AzU8aNr//eiYB+aK+qB8A2S/1Qkw5JnJh8v8fAuK25SSGlADr5ZuBFjf6JZxXQ2ymco0aNq5+Q8yTzGKNbl9YHheYNxOvZghlA8QRa9nbo+MmKd6u1ushrfcCqiiM5m+WQPHjYGNSyJizgIvShJ0kdQes2x2eqV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708416437; c=relaxed/simple;
	bh=awT0zTo78ApZAKonWlAU5EVPZWIHDSpLrfEEEfQsDEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=olmvpeHwGtOuXV33MJ3YutiP02CNLCBgo/aND9nsGsJpPoAsBEcbtdBJXqd4aCJg/kcyzvCicEdC7WPaTQTDm2rblkWeCwe03/+HTPJiorADwIiDIIbz+FpkVcPCwmd7Wh6/bVQ8CHmRaw4BdWz7RXrOFFT60ZLNsNlN/1H96ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dD7hcwNW; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dcc6fc978ddso4178448276.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 00:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708416434; x=1709021234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=awT0zTo78ApZAKonWlAU5EVPZWIHDSpLrfEEEfQsDEk=;
        b=dD7hcwNWXJ2cGycOPtjBPwQuJ/2M5NhcvRJYvnPy5wBdtAGbHtreN47OB6JuDI0U6I
         a/+fh/jDenLkJb3GEU+KC+NM7LFDroyYh1eLUNkMPS9wVXmT8O6J65aIbXdMHc8EvZBI
         F7ZQZjtyqPg9fD+H/iwKCb19PH1kPRLCKQo00uG76bK6VUB44Pfd6+NJdwjnAWm/6nGP
         zh6rT20V4kU0w+O4n0ZAS4tuDqePlGizHCSjMLsiipqffNp70it/teKeBS2XhjYeJeJL
         684O+g9p93uA2ld79sfdgCt7g2Ej/DI55jpbbgefV1XApgztbz3C5V377jkhQc4oQAu5
         7qfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708416434; x=1709021234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=awT0zTo78ApZAKonWlAU5EVPZWIHDSpLrfEEEfQsDEk=;
        b=kkRAA7cpkrMsxxsQPFVthSqax3cGiFwGO5t3UxkyYcB7+Dz1uHg+nIcC6S8QWtmvxz
         q0Ehyn+CcUogwRai7W6QnCrfY9E8ZfhjF2hMyZp1OsL40ip7CtIJ0eXPHgUjpZ5cAt/3
         MFNEj3vC01phVuWLIasybB80uFEFJx2d9SU6m2dTS8RKDj4WDomAIt9YwaJGsxLo1C5q
         i6SKRdRZF/O/VDMARLtiEGXo6y4TgUUeAVWYmdWbDRlkD9Efkf0XcdgBZ1BzZdJtoEH0
         BDSMtR/7RqnMt0aSxIL7AwbPqNGpOnCmDBCAPyDI8b/rihOBdwN3u3BuXR2usYoOJ7Bj
         F+ig==
X-Forwarded-Encrypted: i=1; AJvYcCVsLv8JFo9OzYD7Wa+HMfYjB5Szf8XS9ZdP0tt4i7gnvcKLAI255NrKI6jte5szQIKMGM8VUUqOrvZrgAllz8v0ldMQ1t3L1lFm+PB5
X-Gm-Message-State: AOJu0Yy1x9mSoanti1mTSwaWfVy+1+2RB7IyJft+bY8G6umCshAtj25C
	jAV77ELIjBNmD3foquZe/jvyWkcPn3LW/aQn0kXPzQSFoS5Wn2KrZkAvDJO9ORwQq/+fVTCziVS
	FlXYH0FJBBT5jSPwS0IkZtWtGj3fG3cvBXSpHeA==
X-Google-Smtp-Source: AGHT+IGHpSsMIuEotxmsPqtQrf1oD0WZ/UCXgvkP+pOGh/bZIF0X9vZSLoc/4KAh0bvAGCVpcXQldb9yUsn24UnzWZQ=
X-Received: by 2002:a25:bc4d:0:b0:dc6:de93:7929 with SMTP id
 d13-20020a25bc4d000000b00dc6de937929mr11460135ybk.26.1708416433908; Tue, 20
 Feb 2024 00:07:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214-mbly-gpio-v1-0-f88c0ccf372b@bootlin.com>
 <20240214-mbly-gpio-v1-16-f88c0ccf372b@bootlin.com> <CAMRc=MdFBFFTYKHgDfOieNZJ+-x7ZZMiYty6buOp2J=eFUjt0Q@mail.gmail.com>
In-Reply-To: <CAMRc=MdFBFFTYKHgDfOieNZJ+-x7ZZMiYty6buOp2J=eFUjt0Q@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 20 Feb 2024 09:07:02 +0100
Message-ID: <CACRpkdZ5qJY6qQRaq=4y3yf1_ppNMDo5EfDPV_fuCHMe+C+tnQ@mail.gmail.com>
Subject: Re: [PATCH 16/23] gpio: nomadik: support shared GPIO IRQs
To: Bartosz Golaszewski <brgl@bgdev.pl>, Thomas Gleixner <tglx@linutronix.de>, 
	Grygorii Strashko <grygorii.strashko@ti.com>
Cc: =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mips@vger.kernel.org, Gregory CLEMENT <gregory.clement@bootlin.com>, 
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 4:48=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
> On Wed, Feb 14, 2024 at 5:24=E2=80=AFPM Th=C3=A9o Lebrun <theo.lebrun@boo=
tlin.com> wrote:
> >
> > Support a single IRQs used by multiple GPIO banks. Change the IRQ
> > handler type from a chained handler (as used by gpiolib
> > for ->parent_handler) to a threaded IRQ.
> >
> > Use a fake raw spinlock to ensure generic_handle_irq() is called in a
> > no-irq context. See Documentation/driver-api/gpio/driver.rst, "CHAINED
> > CASCADED GPIO IRQCHIPS" for additional information.
> >
>
> Any reason for not using preempt_disable()?

I think this needs to be discussed with tglx if Grygorii is not available.

Yours,
Linus Walleij

