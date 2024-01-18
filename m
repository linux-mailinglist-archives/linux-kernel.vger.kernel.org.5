Return-Path: <linux-kernel+bounces-29928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF4283154F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 10:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5A43282B6A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEAA21D55B;
	Thu, 18 Jan 2024 09:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O80B3/RO"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DEC1BDFC;
	Thu, 18 Jan 2024 09:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705568415; cv=none; b=Qrg9lfuZ+AEy+V9ayRjdAzqwByaoBo1sgqL3YGf83dQqvAEH/fUcgyM8lujRz15hVxoE7ROUiuweI/Swo3B+tZ74n2gdbaTRMq3JetWymO6XijwWVblhWzBB3nvfaoD0UH43sAbIzlHmuqL5BOhRdURGqk6IMoBvp+i6qwLOaPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705568415; c=relaxed/simple;
	bh=Y5c3O312N9SbXppl8hxgrI1T9xBYSTxoqkJoAgsYevY=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=tXt5FCXmvLR8CDEBi0tmPpy3iZ4Uujmy3lXAdXU2DKZmzawlb2SlOthQcFGKcss1CdOUHmUdjoic64JsHZ2iWIvM0Bip7ecgHZ26Jok7O373HDh9JtAZV89bD7IKSlMhqq1dhhR3za188CggS1pRxAxG1VkySN7tccWmbX69lgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O80B3/RO; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-559533e2503so4726524a12.1;
        Thu, 18 Jan 2024 01:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705568411; x=1706173211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2KsM8Ecei3qYCph9440/9O1dTpHBRWixGdUKkujVl64=;
        b=O80B3/RO8odvo/JvzI1QZ2m/mSTWaFlCaNp3Tbi1P7+l+cJYDH8CX94F7X4PXD4V8Y
         iCuSeZC9kTygL51CWfSUuDmu3duda5OoqAPQBG3lnXsx3S/D2OPj4QGmLfE5fpnc4NmP
         GlfjpoHvxhBbmdKAaUKdw/xYpvLmNj+WQKhd/fbFOm0FST8vZhLgt+ZsQfB2zjjpFeGC
         1qoC/79Bxk+GwJV2mKLmOnr7xbmTywQmRTrYAQ4M4b0LN7/1BqRUh25XnDHgDKHpNiac
         BS1pk9kyGAAJyzm4yn6uTbaGL+gibgCmlToIILPIN1IKvmBT8q/2+1Q4weJOqIMyRsU1
         j2Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705568411; x=1706173211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2KsM8Ecei3qYCph9440/9O1dTpHBRWixGdUKkujVl64=;
        b=Iyjz86MLRxweaCJ09F/T4q4yg265Wue1/lEVEwY11DoWVt45dw5GoicMdXfYMnntoX
         kRIKlNuHk/VD1eE/B0JTuTUQwTg+xHaeyxVMFJrvMUJumBZ6V/zEK+1Ub7C0dacvwunx
         2/Df1Ou8mvDSgTnTHsndhOA9MJ15q9V5/ILM/UWgirz2WRY2utO13DJaOmDR124Um2Zo
         O68bmdUIfxbn+RFqJecjJnBeyX7ICoxBVEo0XWhJ79zgqU/F3ognWmfVOlC/pdLzQfUv
         r66UH0AtLyW6/0tIh77MmS0O4xLBFrfhj6isPVvygutJftyKDUaPgbH3xy+uWSxyP88N
         BfUw==
X-Gm-Message-State: AOJu0Yxq1vRfWdL0S45l0Wy/7rh0IzUu9sf2wAmklYkHfiQiKSRq1n+r
	ojsT+PkgxLMxD8wsS2U1qBOnVH7v5A0TWAhLBz14eImi5sDKvDmsmLr2FaRfpoDY4e+ZpVBCMsU
	EJIukX92QsflyjflvHwL9fq1huao=
X-Google-Smtp-Source: AGHT+IFHOYN2jygcMXwIbC5+KZTfieuY5t4wVSO9sVSzq1MGnDTv9TZbfSq8+vMJSLcPjvH30DIks76ocbJIW2Bo0fs=
X-Received: by 2002:a17:907:60c9:b0:a2e:70b4:28b0 with SMTP id
 hv9-20020a17090760c900b00a2e70b428b0mr341123ejc.3.1705568411275; Thu, 18 Jan
 2024 01:00:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117223856.2303475-1-hugo@hugovil.com> <20240117223856.2303475-16-hugo@hugovil.com>
 <CAHp75Ve5PYQTRdxcffdQvYWJ-iwvfEHfMnL-vhs_mv7yg+GJ5Q@mail.gmail.com> <20240117185909.78bb633ea090f74de9f4f3b7@hugovil.com>
In-Reply-To: <20240117185909.78bb633ea090f74de9f4f3b7@hugovil.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 18 Jan 2024 10:59:34 +0200
Message-ID: <CAHp75Vc5mePmXaAbsex6=tHeLSfSj5gZiE4_DQ0-5R-4h6=U5w@mail.gmail.com>
Subject: Re: [PATCH 15/18] serial: max310x: replace ENOTSUPP with preferred
 EOPNOTSUPP (checkpatch)
To: Hugo Villeneuve <hugo@hugovil.com>, Kent Gibson <warthog618@gmail.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	cosmin.tanislav@analog.com, shc_work@mail.ru, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, Hugo Villeneuve <hvilleneuve@dimonoff.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 1:59=E2=80=AFAM Hugo Villeneuve <hugo@hugovil.com> =
wrote:
> On Thu, 18 Jan 2024 01:24:11 +0200
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Thu, Jan 18, 2024 at 12:39=E2=80=AFAM Hugo Villeneuve <hugo@hugovil.=
com> wrote:

..

> > > Fixes the following checkpatch warning:
> > >
> > >     WARNING: ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP
> >
> > NAK.
> > It's a false positive.
> >
> > > According to include/linux/errno.h, ENOTSUPP is
> > > "Defined for the NFSv3 protocol", so replace it with preferred EOPNOT=
SUPP.
> >
> > The GPIO subsystem uses this internal error code internally. User
> > space won't get it, so users may not see this one.
>
> Hi Andy,
> I will drop the patch then.
>
> What about adding a comment to prevent future fixes?
>
> -               return -ENOTSUPP;
> +               return -ENOTSUPP; /*
> +                                  * ENOTSUPP is used for backward compat=
ibility
> +                                  * with GPIO subsystem.
> +                                  */

It's kinda useless to add it to a single (GPIO) driver.
Rather it needs to be mentioned somewhere between
https://www.kernel.org/doc/html/latest/driver-api/gpio/index.html.

+Cc: Kent, Bart. It seems we have a handful of drivers violating this
(basically following what checkpatch says) and GPIO not documenting
this specific error code and its scope. Did I miss anything?


--=20
With Best Regards,
Andy Shevchenko

