Return-Path: <linux-kernel+bounces-149351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B90AE8A8FF6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 02:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EC4C1F221A7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 00:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B30015C9;
	Thu, 18 Apr 2024 00:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="EQmJXtT+"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E129F382
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 00:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713399832; cv=none; b=biATAhT2lB06MRfeHeXCWMI8P2sZPxoKnrx9z4GKT1226fMXDTgk9VhgqLl/tyw6OO8Lan0zTpSHPDKBTuPEaU9VXw/WUci9Hr5E5jYwpzBI7HGyuOgsioxxg+MSNijiOSKG2E4sIXk9v5IWAyV3Xu8QQ93WYCzF32DUTzKpEAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713399832; c=relaxed/simple;
	bh=8+F6PP2qvcM28ExvjGoCq9ck+Fvk40LFrhNIeFQyvd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bewnLoVzRszPf6mVjSiBVeVMXJzM+81fW5wYRqoO74ab2/4DD3ljugpvnfVR9ttjotrkBY/i809y8mIHtunO3DcOlDOptPrjMiywTFg8+ghRPLXxvkq/68kjSKzUhw+ds6GzoOqbX53nJ+a/ApDZN+OPp5ou2I2oZVv8zTjEwf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=EQmJXtT+; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51967f75729so287026e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 17:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1713399829; x=1714004629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9i9VTKXdwVrZUiFoJtRZUvp3SrFLNeCVgmhZ/CQHQQo=;
        b=EQmJXtT+38OaKNZVPehAP4pcfhVzRa8UaVwm1sbV+WFV1DbSXfgjo2SlAax21A3Laz
         itpKBsD3DbkklYVsT8uyKgBG/FVQBwlkECUT6lPG1+9CPEw6aOOEPB+zmZrspA06d7qN
         i8bywpX+VlCrkSkdZEyxrQJxutb3RmsWX0rk28k7I4j3+GKjQYHd+cI8M28DwBiIUo7A
         rLGPDzTmAeHB+MLpzIMBH5JfCgSUbnn224EAttsj3G8cetG9uAnR5gqm+KsBz/KhozbX
         ddE2Ua5HT9nykeaxAGQ6CKX4Fo7E+9Zm2w6pcZFbu8NDtZvuzR3kzcCl8uf0u7ByAgXU
         cKuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713399829; x=1714004629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9i9VTKXdwVrZUiFoJtRZUvp3SrFLNeCVgmhZ/CQHQQo=;
        b=ocrOYtPXJIsLlvLHGKD68o/w8/FYlTI8KPbtQpA2jw8V+vUmc7DLmMfU/WwSuSLESo
         I9iz8bRWzi0365W51JpZeyGWHw6+B2uU5RXDv5jt5MW5RQF4U3CKFDg8NiWqA4Y+Qx5o
         Z/rwnK3ROX95wR7nlRbokpfnKDT8rrBdTD03Ohkaux8ws0pjpiNxpuxEylbc89wo10Dl
         1oV+294sUkYU50NNG+o5fHu/zRQadEl18EhYvlIY22WY2eB2CyMQhOz535jadycYbpW1
         Z6oXMXx01XkL/7LcpsrzLrlpiDvU8xdElMfc5ZbckKXva5Z+3eQo/nctkXGzjNQRLBVG
         1Qww==
X-Forwarded-Encrypted: i=1; AJvYcCX9/C1ziP8NMeIOT8x29geWeWoY8wyE0TgVVQlblEFFYqNptqL+9OrEuzokbv5KVifPBky92XbX97XhMuH8oqDQBiuJNPAdIpPDu/hl
X-Gm-Message-State: AOJu0YzNiaVAyhdBW1eAczEUlCnbzwDu03DvFHYzB4Myct0Uk3gb/EtH
	g/sPhVH7Lbmd4Z7jBVdExRVLVTNyeFXZjWb2DyaA8jSzF3EMFeeIAQIzQARF8oEwdEu8tODkH9B
	uLNwMciccw5Hlz2jPQhuVXZEDlqD/1FC9G6X+S0pXyYyonKF1NTU=
X-Google-Smtp-Source: AGHT+IFSP7fv6n7n7EIN3wTedD5rHV4pAWwZx/vDgr9JJwfPB43rEvOuqvl3kArK2oSeRzx1fctxxl5dppJuW0GjOMk=
X-Received: by 2002:ac2:446b:0:b0:516:d4cf:f957 with SMTP id
 y11-20020ac2446b000000b00516d4cff957mr374456lfl.60.1713399828947; Wed, 17 Apr
 2024 17:23:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417230637.2592473-1-dtokazaki@google.com> <CAMRc=Mcbi8BQ-tHNs+BVjbm3aDSVY0zzOM4QfND3d2y8ryT62g@mail.gmail.com>
In-Reply-To: <CAMRc=Mcbi8BQ-tHNs+BVjbm3aDSVY0zzOM4QfND3d2y8ryT62g@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 18 Apr 2024 02:23:38 +0200
Message-ID: <CAMRc=McRiv6vtU5LySrkbfdbCaqZ2tXbHnazo4iahRS-SKAXxg@mail.gmail.com>
Subject: Re: [PATCH v1] at24: fix memory corruption race condition
To: Daniel Okazaki <dtokazaki@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel-team@android.com, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 1:59=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> On Thu, Apr 18, 2024 at 1:07=E2=80=AFAM Daniel Okazaki <dtokazaki@google.=
com> wrote:
> >
> > If the eeprom is not accessible, an nvmem device will be registered, th=
e
> > read will fail, and the device will be torn down. If another driver
> > accesses the nvmem device after the teardown, it will reference
> > invalid memory.
> >
> > Move the failure point before registering the nvmem device.
> >
> > Signed-off-by: Daniel Okazaki <dtokazaki@google.com>
> > ---
> >  drivers/misc/eeprom/at24.c | 18 +++++++++---------
> >  1 file changed, 9 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> > index 572333ead5fb..4bd4f32bcdab 100644
> > --- a/drivers/misc/eeprom/at24.c
> > +++ b/drivers/misc/eeprom/at24.c
> > @@ -758,15 +758,6 @@ static int at24_probe(struct i2c_client *client)
> >         }
> >         pm_runtime_enable(dev);
> >
> > -       at24->nvmem =3D devm_nvmem_register(dev, &nvmem_config);
> > -       if (IS_ERR(at24->nvmem)) {
> > -               pm_runtime_disable(dev);
> > -               if (!pm_runtime_status_suspended(dev))
> > -                       regulator_disable(at24->vcc_reg);
> > -               return dev_err_probe(dev, PTR_ERR(at24->nvmem),
> > -                                    "failed to register nvmem\n");
> > -       }
> > -
> >         /*
> >          * Perform a one-byte test read to verify that the chip is func=
tional,
> >          * unless powering on the device is to be avoided during probe =
(i.e.
> > @@ -782,6 +773,15 @@ static int at24_probe(struct i2c_client *client)
> >                 }
> >         }
> >
> > +       at24->nvmem =3D devm_nvmem_register(dev, &nvmem_config);
> > +       if (IS_ERR(at24->nvmem)) {
> > +               pm_runtime_disable(dev);
> > +               if (!pm_runtime_status_suspended(dev))
> > +                       regulator_disable(at24->vcc_reg);
> > +               return dev_err_probe(dev, PTR_ERR(at24->nvmem),
> > +                                    "failed to register nvmem\n");
> > +       }
> > +
> >         /* If this a SPD EEPROM, probe for DDR3 thermal sensor */
> >         if (cdata =3D=3D &at24_data_spd)
> >                 at24_probe_temp_sensor(client);
> > --
> > 2.44.0.683.g7961c838ac-goog
> >
>
> Looks good, can you add a Fixes tag?
>
> Thanks,
> Bartosz

Wait... While the patch is still correct - we shouldn't needlessly
create the nvmem device - why would anything crash? Looks like a
problem with nvmem then? How did you trigger this issue?

Bart

