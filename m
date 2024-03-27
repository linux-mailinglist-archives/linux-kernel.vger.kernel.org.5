Return-Path: <linux-kernel+bounces-120729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E79BA88DC18
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0CF72953FF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F394F535A1;
	Wed, 27 Mar 2024 11:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbbcMSD5"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD84C3DABF3;
	Wed, 27 Mar 2024 11:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711537699; cv=none; b=Qpo6lqtZjJ+V829Zg0WZdID7szmBPy59G2RXiYqjwvQSTZMkIX7LlJdLfGD2DWH4b+r7gTk4f3GscnoTbQFly4wVkIGbVhG9WXzNhIQTRXW8b4D7MJgJ3v3KLXejNosJaFQJadCRQ2RPjB6UdsMR+TnuxX4FitwuxbGfwQBhOZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711537699; c=relaxed/simple;
	bh=yygm4eyQjYZoYbzIzaYLx0dMu2xifG7JsTbud9X5p5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ST9v5eTjnBSdtpq85xV83fr+xgnUA6ZYcJWLrUoxvCx9Nac7fzLpZ8nL0avZvjPmwlyS6qoJVJ8C/H/q+GG60xKryF3f+r1ekgSEI8Rd8JtBxp+Jei3Arw0V3VjK6IXVWNwXSH/IUOVtuCwGCdoEeXqWQMf/xlPwH14DiGmgR/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IbbcMSD5; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56bdf81706aso6978732a12.2;
        Wed, 27 Mar 2024 04:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711537696; x=1712142496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=On8wlY6OPWc3ddSd1nBCaNCKXsF3Ev3MZFqAfUa4Ga4=;
        b=IbbcMSD5kX/scDDL8khzVDSJeIiql8hwu4C0QDXGdA4WFEf0gCX+ieboC8b4G0N42P
         sY5CephI6HMZXxU9KVpsH0/tb5cqtD/jgcTbTeSN0K17QLNDZ7oDFIvUJ3xPmfNUO82t
         Q4C9SDvx+S+XPhoZcYemmF9FdPOzRC6TtJCPqB0fi4ERgGg/8B4+aAH9PVMa5OPlEUEV
         Zwrv+HGfkRTVPsIn4YWXl2kiIfhA9RmS+RKZtBl0sGFVvQIFxPzTsLY1E6Hadb/fKLPb
         66oCUZNvyp0ze47K8B6LURyECUgpr6eKVnCKiLuDT2yKe8xUU86BW9wU2FTuRPZl8/A3
         A3OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711537696; x=1712142496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=On8wlY6OPWc3ddSd1nBCaNCKXsF3Ev3MZFqAfUa4Ga4=;
        b=gUY1wzGirC8Ggyhyq00qqHFoTLHZmllq6LbUsMHhnFxxvbNGyVJgKgmFu/z6tgEg9u
         ma/x87CBFmfbeuJzU7C6dqMgJKVCCi2ioMbPKMfTc2RoxRrh+nEbkb3s1P5LPV4Qi4fO
         0cBNTty9MgqFgajl4W1FHdx8UN24C2rpCC2DAf1ynNdrtr8+gkZuyCHYbNQUv2xxGM15
         JaVqm7DXUio0u5LY598Otk4CFzpANzyVXh7hHYx7PvEXc6XJJErFnqPCYCdT9wDHiMEG
         uRIyTlXkSftlye6aJnvXCbVtn/0P028MvMAentEZZDELFGd6VJlzwEU6CQCcCOOPPwKI
         Fe5A==
X-Forwarded-Encrypted: i=1; AJvYcCWVxJg21N2LDcob/K2a9zSLgT//ocTXxlN5Od0yKwehYADZw8jOIgkPTnhf/sHsfGdSLwC3kokPIEx/fP5ZwJJNSHVfRGA+fp1JE2qfOR/fx8/xxBDbrFUx8/ajBZKmxPKtwJUlh6OVBSxhTmQjhqoLtje1RBzLYfiV3b8Vn7c9lVJFXLeNW5enKVJZi5RIG+WZWKp+LyI487zaZ1oy1jTkGVJMH8J6BQ==
X-Gm-Message-State: AOJu0YxD58/0Ilrc0xVCvyitOTSsJaDQRH2tPZd5schC/GU+B1kjdhOO
	4rumOQwgpruwCqtsBX4I3ei+iJgSVxZG41nY9Xtb/5jMGQT9SovcpftYOYRp4EYF1dQS+H0sdfs
	q6Juh2Zc9LHY8+Q8nI2QhmB5m9MU=
X-Google-Smtp-Source: AGHT+IEf/6n+lZ0mTtjfzS5th3vrR2ph//ewCRZbOW7x2QDMk1WTXYd1fuMhSa1g+UweOR/iyDJ7Y1zzAqZW4zGL3ls=
X-Received: by 2002:a17:906:114d:b0:a4d:f806:ad6e with SMTP id
 i13-20020a170906114d00b00a4df806ad6emr2534995eja.52.1711537695981; Wed, 27
 Mar 2024 04:08:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240324150107.976025-1-hpa@redhat.com> <20240324150107.976025-3-hpa@redhat.com>
 <CAHp75VdosbYNKU90QWt+6SU_i5dWC94=xZy0GXiKvoQeDF30wg@mail.gmail.com> <CAEth8oFuPTRq0z-YbMMFt=kKgre6x+bDhtpUkj2vJeK-u8O72A@mail.gmail.com>
In-Reply-To: <CAEth8oFuPTRq0z-YbMMFt=kKgre6x+bDhtpUkj2vJeK-u8O72A@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 27 Mar 2024 13:07:39 +0200
Message-ID: <CAHp75Vc6=0-eMMXYQEn9w5N09rKR9NNrqFPR8LBvZZyOiscsig@mail.gmail.com>
Subject: Re: [PATCH v5 RESEND 2/6] leds: rgb: leds-ktd202x: Get device
 properties through fwnode to support ACPI
To: Kate Hsuan <hpa@redhat.com>
Cc: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, linux-leds@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	=?UTF-8?Q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>, 
	linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 8:53=E2=80=AFAM Kate Hsuan <hpa@redhat.com> wrote:
> On Mon, Mar 25, 2024 at 3:57=E2=80=AFAM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Sun, Mar 24, 2024 at 5:02=E2=80=AFPM Kate Hsuan <hpa@redhat.com> wro=
te:

..

> > > +       .id_table =3D ktd202x_id,
> >
> > Seems to me that you may split the I=C2=B2C ID table addition into a se=
parate change.
>
> Could you please describe this more clearly? Thank you

I don't see how the introduction of the I=C2=B2C ID table is related to
this patch. If needed it can be done separately, no?

--=20
With Best Regards,
Andy Shevchenko

