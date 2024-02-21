Return-Path: <linux-kernel+bounces-73904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE1985CD73
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 02:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0BE31F23D08
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 01:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4E94697;
	Wed, 21 Feb 2024 01:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D56DSnxZ"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C76717D5;
	Wed, 21 Feb 2024 01:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708478808; cv=none; b=Tq7FV2+9qqazFVIoSSwH3w4FLKT8v0QKxhGhNgUTMh2Sznx8xeoP34bkZKMW1yFwqdksQ/Ev+4v1tO+erTzNwtJcJ2LtcEMrhR77yzn+C4a99WLlmqVlfgiEMbSecFceZ5vCJG9lgsk/agHsr1YHYGEu57MdZvtgKrtllgiT21I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708478808; c=relaxed/simple;
	bh=Vl2NjPEcAdbdvbbQkxEQ85JPTRdZ2uCfo8M5sNDED8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oq1XyUWrStlhOW4RCbl4MAXaZFBsFMYyYgPAchnV12VJc8IFH+Z66K1DDQcbW8E12QLV3bkXaEAz2tWfpkzDjcJody5ZS3+hHIBfGgruPhuW3x9rH7muu6F6ze26k/1CVadnaGMgNvnar76syE2P8h3z7KoENLuYtUIrA93KE3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D56DSnxZ; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7c4949a366fso241717539f.1;
        Tue, 20 Feb 2024 17:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708478805; x=1709083605; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zxR4qekCYnGcVEwiDwCLbQ4qTT1N4pNXMG7tg+5kIPM=;
        b=D56DSnxZuyS6ERJ8Vz1eo0GilgGvAbiqOhCuZpIUX0oTJ+JQqqcWeasauim/rtCxvH
         sy3Svh9HxwkmUwZbvAHwZNLxNX4yvrvPEQUUGDUU2mZdSNO0AzdVgm2k/AA0tsYkhTlU
         DnvMO3L+nb5YQ8dz+66q35W6rxRm/NRv6ObutCCuAkpGmJoxu77dOUkZmXlFU4n1aqwy
         HVo0ca+j9hSsz5HrT+mWpDOO7OHPyAzUnCFM+e/ip42qj9vbqhTDKl7hUzYirotBTdAx
         8/IlbYAO6ng6Y3n3gs2OI8X17psBhYLnUtc2GySh1h+jd00jEPa4fbB7CIqzsGRWDFdW
         AUjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708478805; x=1709083605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zxR4qekCYnGcVEwiDwCLbQ4qTT1N4pNXMG7tg+5kIPM=;
        b=w0RoIB+uUqqL2e19mNrAKeSdyLz5kG4Wez+b/A6f2IJl0Ei7IbAurQ3mvw5kZ0JC8Y
         NMWKv0i3VS8x0MuqNN8BC+h5LjPu3m3XKjmuH6I09sCH2bxdASvpAFSZJRBoprw1wRkT
         ugx6uWYuz228LxSz3f2LQJid9TqmsJFhPhUkvnN65jsYNMsdiu5NgJfdqlaFMEuPrDgF
         r6TuSybSWUIaGOn+8olP/mO/MyPGhdIFOYW/QAx6/cG+b6eFpkN0rJXcSUHJUBhdLRmo
         8OkZZaSatXETeyzDVM1xFL1S8tQZXsaz+ezvJimGcFJvjbg+SE9f5Z2JFLMJhiXuMmzs
         rU9g==
X-Forwarded-Encrypted: i=1; AJvYcCWU+2mAAEVBIC3C0W39E8JCRpHNF4c+po3nzenxDNGlUOpArVtw6DT9U/MzGeUfUcsJ7wK81m3DcalwfiMlCJkVmn3eg1CtjPt8yl2rekuRw0vFEC9qjSHV7gv0nq1n+uCtVGqaiD6xfO02kHAYtr2yv42UO3aud93NYSu57VsCsnEh1wWjgRHp5o2C5Wgvj92MX4J2hMIcMjUWHI9+RCeG
X-Gm-Message-State: AOJu0YwNUre0sgjftZl4ClYfY6uyiah+pwioMV1cx5H7XaFZ1BLl5gvV
	XjJ2Ttzno966UYeEJLSOMW/lEabgxBSHDvBgo9u3W8gnbaPrY1SEQbqUziJTvomkJoSixyU28YR
	9x9tD4d8ezLNNis5l10Wl+OAmMd8=
X-Google-Smtp-Source: AGHT+IGlE9OmlvHmkV4Eb5Z2ToCJxfBMaml7tkCm3cO50yB2pF0spb6ZVMo+N9gPUV23oAeh5TOA9vxtZco17kdQXvo=
X-Received: by 2002:a92:d6c2:0:b0:364:21b4:f59a with SMTP id
 z2-20020a92d6c2000000b0036421b4f59amr15865366ilp.14.1708478805102; Tue, 20
 Feb 2024 17:26:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231222013352.3873689-1-kcfeng0@nuvoton.com> <20231222013352.3873689-4-kcfeng0@nuvoton.com>
 <4ba56d33-cc58-44e1-9f2e-9fa7865e4537@roeck-us.net>
In-Reply-To: <4ba56d33-cc58-44e1-9f2e-9fa7865e4537@roeck-us.net>
From: Ban Feng <baneric926@gmail.com>
Date: Wed, 21 Feb 2024 09:26:34 +0800
Message-ID: <CALz278bNWxgVZz7mjtsiQz+aU837+eNsebbJM6M07S0_CQgx4Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] hwmon: Driver for Nuvoton NCT7363Y
To: Guenter Roeck <linux@roeck-us.net>
Cc: jdelvare@suse.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, corbet@lwn.net, linux-hwmon@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, openbmc@lists.ozlabs.org, kwliu@nuvoton.com, 
	kcfeng0@nuvoton.com, DELPHINE_CHIU@wiwynn.com, Bonnie_Lo@wiwynn.com, 
	naresh.solanki@9elements.com, billy_tsai@aspeedtech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

On Sat, Feb 3, 2024 at 11:06=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> On Fri, Dec 22, 2023 at 09:33:52AM +0800, baneric926@gmail.com wrote:
> > From: Ban Feng <kcfeng0@nuvoton.com>
> >
> > NCT7363Y is an I2C based hardware monitoring chip from Nuvoton.
> >
> > Signed-off-by: Ban Feng <kcfeng0@nuvoton.com>
>
> Sorry for the late reply. I was waiting for the fan schema to be accepted=
,
> but it looks like that may take more time.
>
> Please fix the various issues reported by checkpatch --strict.
> Additional comments inline.

ok, fix in v4

>
> > ---
> >  Documentation/hwmon/index.rst   |   1 +
> >  Documentation/hwmon/nct7363.rst |  33 ++
> >  MAINTAINERS                     |   2 +
> >  drivers/hwmon/Kconfig           |  11 +
> >  drivers/hwmon/Makefile          |   1 +
> >  drivers/hwmon/nct7363.c         | 515 ++++++++++++++++++++++++++++++++
> >  6 files changed, 563 insertions(+)
> >  create mode 100644 Documentation/hwmon/nct7363.rst
> >  create mode 100644 drivers/hwmon/nct7363.c
> >
> > diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.=
rst
> > index 72f4e6065bae..178d3cae95de 100644
> > --- a/Documentation/hwmon/index.rst
> > +++ b/Documentation/hwmon/index.rst
> > @@ -161,6 +161,7 @@ Hardware Monitoring Kernel Drivers
> >     mp5023
> >     nct6683
> >     nct6775
> > +   nct7363
> >     nct7802
> >     nct7904
> >     npcm750-pwm-fan
> > diff --git a/Documentation/hwmon/nct7363.rst b/Documentation/hwmon/nct7=
363.rst
> > new file mode 100644
> > index 000000000000..89699c95aa4b
> > --- /dev/null
> > +++ b/Documentation/hwmon/nct7363.rst
> > @@ -0,0 +1,33 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +Kernel driver nct7363
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Supported chip:
> > +
> > +  * Nuvoton NCT7363Y
> > +
> > +    Prefix: nct7363
> > +
> > +    Addresses: I2C 0x20, 0x21, 0x22, 0x23
> > +
> > +Author: Ban Feng <kcfeng0@nuvoton.com>
> > +
> > +
> > +Description
> > +-----------
> > +
> > +The NCT7363Y is a Fan controller which provides up to 16 independent
> > +FAN input monitors, and up to 16 independent PWM output with SMBus int=
erface.
> > +
> > +
> > +Sysfs entries
> > +-------------
> > +
> > +Currently, the driver supports the following features:
> > +
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > +fanX_input           provide current fan rotation value in RPM
> > +
> > +pwmX                 get or set PWM fan control value.
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 53cfcc629aa1..e39c4fc01a3b 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -14842,6 +14842,8 @@ M:    Ban Feng <kcfeng0@nuvoton.com>
> >  L:   linux-hwmon@vger.kernel.org
> >  S:   Maintained
> >  F:   Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.yaml
> > +F:   Documentation/hwmon/nct7363.rst
> > +F:   drivers/hwmon/nct7363.c
> >
> >  NETDEVSIM
> >  M:   Jakub Kicinski <kuba@kernel.org>
> > diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> > index cf27523eed5a..a0229851fc64 100644
> > --- a/drivers/hwmon/Kconfig
> > +++ b/drivers/hwmon/Kconfig
> > @@ -1605,6 +1605,17 @@ config SENSORS_NCT6775_I2C
> >         This driver can also be built as a module. If so, the module
> >         will be called nct6775-i2c.
> >
> > +config SENSORS_NCT7363
> > +     tristate "Nuvoton NCT7363Y"
> > +     depends on I2C
> > +     select REGMAP_I2C
> > +     help
> > +       If you say yes here you get support for the Nuvoton NCT7363Y,
> > +       hardware monitoring chip.
> > +
> > +       This driver can also be built as a module. If so, the module
> > +       will be called nct7363.
> > +
> >  config SENSORS_NCT7802
> >       tristate "Nuvoton NCT7802Y"
> >       depends on I2C
> > diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> > index e84bd9685b5c..dd794aa06209 100644
> > --- a/drivers/hwmon/Makefile
> > +++ b/drivers/hwmon/Makefile
> > @@ -166,6 +166,7 @@ obj-$(CONFIG_SENSORS_NCT6775_CORE) +=3D nct6775-cor=
e.o
> >  nct6775-objs                 :=3D nct6775-platform.o
> >  obj-$(CONFIG_SENSORS_NCT6775)        +=3D nct6775.o
> >  obj-$(CONFIG_SENSORS_NCT6775_I2C) +=3D nct6775-i2c.o
> > +obj-$(CONFIG_SENSORS_NCT7363)        +=3D nct7363.o
> >  obj-$(CONFIG_SENSORS_NCT7802)        +=3D nct7802.o
> >  obj-$(CONFIG_SENSORS_NCT7904)        +=3D nct7904.o
> >  obj-$(CONFIG_SENSORS_NPCM7XX)        +=3D npcm750-pwm-fan.o
> > diff --git a/drivers/hwmon/nct7363.c b/drivers/hwmon/nct7363.c
> > new file mode 100644
> > index 000000000000..1bf6e83afd7f
> > --- /dev/null
> > +++ b/drivers/hwmon/nct7363.c
> > @@ -0,0 +1,515 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (c) 2023 Nuvoton Technology corporation.
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/bits.h>
> > +#include <linux/err.h>
> > +#include <linux/hwmon.h>
> > +#include <linux/hwmon-sysfs.h>
> > +#include <linux/i2c.h>
> > +#include <linux/jiffies.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/regmap.h>
> > +#include <linux/slab.h>
> > +
> > +#define NCT7363_REG_GPIO_0_3         0x20
> > +#define NCT7363_REG_GPIO_4_7         0x21
> > +#define NCT7363_REG_GPIO_10_13               0x22
> > +#define NCT7363_REG_GPIO_14_17               0x23
> > +#define NCT7363_REG_PWMEN_0_7                0x38
> > +#define NCT7363_REG_PWMEN_8_15               0x39
> > +#define NCT7363_REG_FANINEN_0_7              0x41
> > +#define NCT7363_REG_FANINEN_8_15     0x42
> > +#define NCT7363_REG_FANINx_HVAL(x)   (0x48 + ((x) * 2))
> > +#define NCT7363_REG_FANINx_LVAL(x)   (0x49 + ((x) * 2))
> > +#define NCT7363_REG_FSCPxDUTY(x)     (0x90 + ((x) * 2))
> > +#define NCT7363_REG_VENDOR_ID                0xFD
> > +#define NCT7363_REG_CHIP_ID          0xFE
> > +#define NCT7363_REG_DEVICE_ID                0xFF
> > +
> > +#define NUVOTON_ID                   0x49
> > +#define CHIP_ID                              0x19
> > +#define DEVICE_ID                    0x88
> > +
> > +#define PWM_SEL(x)                   (BIT(0) << ((x % 4) * 2))
> > +#define FANIN_SEL(x)                 (BIT(1) << ((x % 4) * 2))
>
> (x). checkpatch -strict does report this.

ok, fix in v4

>
> > +#define BIT_CHECK(x)                 (BIT(0) << x)
>
> This is identical to BIT(x) so I really don't get the point.

ok, fix in v4
>
> > +
> > +#define NCT7363_FANINx_LVAL_MASK     GENMASK(4, 0)
>
> No CamelCase defines or variables, please.

ok, fix in v4

>
> > +#define NCT7363_FANIN_MASK           GENMASK(12, 0)
> > +
> > +#define NCT7363_PWM_COUNT            16
> > +#define NCT7363_FANIN_COUNT          16
> > +
> > +#define REFRESH_INTERVAL             (2 * HZ)
> > +
> > +static inline unsigned long FAN_FROM_REG(u16 val)
> > +{
> > +     if ((val >=3D NCT7363_FANIN_MASK) || (val =3D=3D 0))
>
> Unnecessary () as reported by checkpatch.

ok, fix in v4

>
> Too bad the datasheet isn't public. It would be useful to know what
> it means if the upper bits are set. Unconditionally reporting a fan
> speed of 0 if any of the bits are set seems excessive unless there
> is a good reason for it. If those bits indicate fan faults,
> it might make sense to implement respective attributes.
>
> [ Why do you keep this chip and NCT7362Y so secretive ? ]

It's only a double check for the bit range from 0 to 12.
I'll consider if this is still needed after dropping the local caching.

>
> > +             return  0;
> > +
> > +     return (1350000UL / val);
> > +}
> > +
> > +static const unsigned short normal_i2c[] =3D {
> > +     0x20, 0x21, 0x22, 0x23, I2C_CLIENT_END
> > +};
> > +
> > +enum chips { nct7363 };
>
> Unnecessary. If there are plans for this driver to support more chips
> in the future, the enum can be added at that time. Yes, I can see in
> Nuvoton's 2024 product selection document that there is a NCT7362Y
> with the same number of fan and pwm channels, but that doesn't help
> if the chips are kept under wrap.

so far only focus on NCT7363Y, I'll fix in v4

>
> Searching for the chips on the internet, I am reminded of
> https://lore.kernel.org/lkml/20230607101827.8544-4-zev@bewilderbeest.net/=
T/
> which introduces a quite similar driver with more functionality for NCT73=
62Y.
> That submission even mentions a NCT7360 with 8 channels. Quite frankly
> I am inclined to reject both drivers (not that I ever got an update for
> the NCT7362Y driver, but anyway) until I get a better understanding
> of the similarities and differences between NCT7362Y and NCT7363Y.
> Please consider sending me datasheets for those chips.

Sure, I'll send the relevant datasheet to you.

>
> > +
> > +static const struct i2c_device_id nct7363_id[] =3D {
> > +     { "nct7363", nct7363 },
> > +     { }
> > +};
> > +MODULE_DEVICE_TABLE(i2c, nct7363_id);
> > +
> > +static const struct of_device_id nct7363_of_match[] =3D {
> > +     { .compatible =3D "nuvoton,nct7363", .data =3D (void *)nct7363 },
> > +     { },
> > +};
> > +MODULE_DEVICE_TABLE(of, nct7363_of_match);
> > +
> > +struct nct7363_data {
> > +     struct regmap           *regmap;
> > +     struct mutex            update_lock;
> > +     bool                    valid;
> > +     unsigned long           last_updated; /* In jiffies */
> > +
> > +     u16                     fanin_mask;
> > +     u16                     fan[NCT7363_FANIN_COUNT];
> > +     u16                     pwm_mask;
> > +     u8                      pwm[NCT7363_PWM_COUNT];
> > +};
> > +
> > +static struct nct7363_data *nct7363_update_device(struct device *dev)
>
> Personally I recommend to drop all local caching and just read values
> through regmap as requested.

ok, fix in v4

>
> > +{
> > +     struct nct7363_data *data =3D dev_get_drvdata(dev);
> > +     unsigned int hi, lo, regval;
> > +     int i, ret =3D 0;
> > +
> > +     mutex_lock(&data->update_lock);
> > +
> > +     if (!(time_after(jiffies, data->last_updated + REFRESH_INTERVAL)
> > +           || !data->valid))
> > +             goto no_sensor_update;
> > +
> > +     for (i =3D 0; i < ARRAY_SIZE(data->fan); i++) {
> > +             if (!(data->fanin_mask & BIT_CHECK(i)))
> > +                     continue;
> > +
> > +             /*
> > +              * High-byte register should be read first to latch
> > +              * synchronous low-byte value
> > +              */
> > +             ret =3D regmap_read(data->regmap,
> > +                               NCT7363_REG_FANINx_HVAL(i), &hi);
> > +             if (ret)
> > +                     goto error;
> > +
> > +             ret =3D regmap_read(data->regmap,
> > +                               NCT7363_REG_FANINx_LVAL(i), &lo);
> > +             if (ret)
> > +                     goto error;
> > +
> > +             data->fan[i] =3D (hi << 5) | (lo & NCT7363_FANINx_LVAL_MA=
SK);
> > +     }
> > +
> > +     for (i =3D 0; i < ARRAY_SIZE(data->pwm); i++) {
> > +             if (!(data->pwm_mask & BIT_CHECK(i)))
> > +                     continue;
> > +
> > +             ret =3D regmap_read(data->regmap,
> > +                               NCT7363_REG_FSCPxDUTY(i), &regval);
> > +             if (ret)
> > +                     goto error;
> > +
> > +             data->pwm[i] =3D regval;
> > +     }
> > +
> > +     data->last_updated =3D jiffies;
> > +     data->valid =3D true;
> > +
> > +error:
> > +     if (ret)
> > +             data =3D ERR_PTR(ret);
> > +
> > +no_sensor_update:
> > +     mutex_unlock(&data->update_lock);
> > +
> > +     return data;
> > +}
> > +
> > +static int nct7363_read_fan(struct device *dev, u32 attr, int channel,
> > +                         long *val)
> > +{
> > +     struct nct7363_data *data =3D nct7363_update_device(dev);
> > +     u16 cnt, rpm;
> > +
> > +     if (IS_ERR(data))
> > +             return PTR_ERR(data);
> > +
> > +     switch (attr) {
> > +     case hwmon_fan_input:
> > +             cnt =3D data->fan[channel] & NCT7363_FANIN_MASK;
> > +             rpm =3D FAN_FROM_REG(cnt);
> > +             *val =3D (long)rpm;
> > +             return 0;
> > +     default:
> > +             return -EOPNOTSUPP;
> > +     }
> > +}
> > +
> > +static umode_t nct7363_fan_is_visible(const void *_data, u32 attr, int=
 channel)
> > +{
> > +     const struct nct7363_data *data =3D _data;
> > +
> > +     switch (attr) {
> > +     case hwmon_fan_input:
> > +             if (data->fanin_mask & BIT_CHECK(channel))
> > +                     return 0444;
> > +             break;
> > +     default:
> > +             break;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int nct7363_read_pwm(struct device *dev, u32 attr, int channel,
> > +                         long *val)
> > +{
> > +     struct nct7363_data *data =3D nct7363_update_device(dev);
> > +     u16 ret;
> > +
> > +     if (IS_ERR(data))
> > +             return PTR_ERR(data);
> > +
> > +     switch (attr) {
> > +     case hwmon_pwm_input:
> > +             ret =3D data->pwm[channel];
> > +             *val =3D (long)ret;
> > +             return 0;
> > +     default:
> > +             return -EOPNOTSUPP;
> > +     }
> > +}
> > +
> > +static int nct7363_write_pwm(struct device *dev, u32 attr, int channel=
,
> > +                          long val)
> > +{
> > +     struct nct7363_data *data =3D nct7363_update_device(dev);
> > +     int ret;
> > +
> > +     if (IS_ERR(data))
> > +             return PTR_ERR(data);
> > +
> > +     switch (attr) {
> > +     case hwmon_pwm_input:
> > +             if (val < 0 || val > 255)
> > +                     return -EINVAL;
> > +             mutex_lock(&data->update_lock);
> > +             ret =3D regmap_write(data->regmap,
> > +                                NCT7363_REG_FSCPxDUTY(channel), val);
> > +             if (ret =3D=3D 0)
> > +                     data->pwm[channel] =3D val;
> > +             mutex_unlock(&data->update_lock);
> > +             return ret;
> > +
> > +     default:
> > +             return -EOPNOTSUPP;
> > +     }
> > +}
> > +
> > +static umode_t nct7363_pwm_is_visible(const void *_data, u32 attr, int=
 channel)
> > +{
> > +     const struct nct7363_data *data =3D _data;
> > +
> > +     switch (attr) {
> > +     case hwmon_pwm_input:
> > +             if (data->pwm_mask & BIT_CHECK(channel))
> > +                     return 0644;
> > +             break;
> > +     default:
> > +             break;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int nct7363_read(struct device *dev, enum hwmon_sensor_types ty=
pe,
> > +                     u32 attr, int channel, long *val)
> > +{
> > +     switch (type) {
> > +     case hwmon_fan:
> > +             return nct7363_read_fan(dev, attr, channel, val);
> > +     case hwmon_pwm:
> > +             return nct7363_read_pwm(dev, attr, channel, val);
> > +     default:
> > +             return -EOPNOTSUPP;
> > +     }
> > +}
> > +
> > +static int nct7363_write(struct device *dev, enum hwmon_sensor_types t=
ype,
> > +                      u32 attr, int channel, long val)
> > +{
> > +     switch (type) {
> > +     case hwmon_pwm:
> > +             return nct7363_write_pwm(dev, attr, channel, val);
> > +     default:
> > +             return -EOPNOTSUPP;
> > +     }
> > +}
> > +
> > +static umode_t nct7363_is_visible(const void *data,
> > +                               enum hwmon_sensor_types type,
> > +                               u32 attr, int channel)
> > +{
> > +     switch (type) {
> > +     case hwmon_fan:
> > +             return nct7363_fan_is_visible(data, attr, channel);
> > +     case hwmon_pwm:
> > +             return nct7363_pwm_is_visible(data, attr, channel);
> > +     default:
> > +             return 0;
> > +     }
> > +}
> > +
> > +static const struct hwmon_channel_info *nct7363_info[] =3D {
> > +     HWMON_CHANNEL_INFO(fan,
> > +                        HWMON_F_INPUT,
> > +                        HWMON_F_INPUT,
> > +                        HWMON_F_INPUT,
> > +                        HWMON_F_INPUT,
> > +                        HWMON_F_INPUT,
> > +                        HWMON_F_INPUT,
> > +                        HWMON_F_INPUT,
> > +                        HWMON_F_INPUT,
> > +                        HWMON_F_INPUT,
> > +                        HWMON_F_INPUT,
> > +                        HWMON_F_INPUT,
> > +                        HWMON_F_INPUT,
> > +                        HWMON_F_INPUT,
> > +                        HWMON_F_INPUT,
> > +                        HWMON_F_INPUT,
> > +                        HWMON_F_INPUT),
> > +     HWMON_CHANNEL_INFO(pwm,
> > +                        HWMON_PWM_INPUT,
> > +                        HWMON_PWM_INPUT,
> > +                        HWMON_PWM_INPUT,
> > +                        HWMON_PWM_INPUT,
> > +                        HWMON_PWM_INPUT,
> > +                        HWMON_PWM_INPUT,
> > +                        HWMON_PWM_INPUT,
> > +                        HWMON_PWM_INPUT,
> > +                        HWMON_PWM_INPUT,
> > +                        HWMON_PWM_INPUT,
> > +                        HWMON_PWM_INPUT,
> > +                        HWMON_PWM_INPUT,
> > +                        HWMON_PWM_INPUT,
> > +                        HWMON_PWM_INPUT,
> > +                        HWMON_PWM_INPUT,
> > +                        HWMON_PWM_INPUT),
> > +     NULL
> > +};
> > +
> > +static const struct hwmon_ops nct7363_hwmon_ops =3D {
> > +     .is_visible =3D nct7363_is_visible,
> > +     .read =3D nct7363_read,
> > +     .write =3D nct7363_write,
> > +};
> > +
> > +static const struct hwmon_chip_info nct7363_chip_info =3D {
> > +     .ops =3D &nct7363_hwmon_ops,
> > +     .info =3D nct7363_info,
> > +};
> > +
> > +/* Return 0 if detection is successful, -ENODEV otherwise */
> > +static int nct7363_detect(struct i2c_client *client,
> > +                       struct i2c_board_info *info)
> > +{
> > +     struct i2c_adapter *adapter =3D client->adapter;
> > +     int vendor, chip, device;
> > +
> > +     if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
> > +             return -ENODEV;
> > +
> > +     vendor =3D i2c_smbus_read_byte_data(client, NCT7363_REG_VENDOR_ID=
);
> > +     if (vendor !=3D NUVOTON_ID)
> > +             return -ENODEV;
> > +
> > +     chip =3D i2c_smbus_read_byte_data(client, NCT7363_REG_CHIP_ID);
> > +     if (chip !=3D CHIP_ID)
> > +             return -ENODEV;
> > +
> > +     device =3D i2c_smbus_read_byte_data(client, NCT7363_REG_DEVICE_ID=
);
> > +     if (device !=3D DEVICE_ID)
> > +             return -ENODEV;
> > +
> > +     strscpy(info->type, "nct7363", I2C_NAME_SIZE);
> > +
> > +     return 0;
> > +}
>
> Chip auto-detection is undesirable for new drivers since it increases
> boot time. Please consider dropping this if it is not really needed
> for some actual use case.

ok, fix in v4

>
> > +
> > +static int nct7363_init_chip(struct nct7363_data *data)
> > +{
> > +     u8 i, gpio0_3 =3D 0, gpio4_7 =3D 0, gpio10_13 =3D 0, gpio14_17 =
=3D 0;
> > +     int ret;
> > +
> > +     for (i =3D 0; i < NCT7363_PWM_COUNT; i++) {
> > +             if (i < 4) {
> > +                     if (data->pwm_mask & BIT_CHECK(i))
> > +                             gpio0_3 |=3D PWM_SEL(i);
> > +                     if (data->fanin_mask & BIT_CHECK(i))
> > +                             gpio10_13 |=3D FANIN_SEL(i);
> > +             } else if (i < 8) {
> > +                     if (data->pwm_mask & BIT_CHECK(i))
> > +                             gpio4_7 |=3D PWM_SEL(i);
> > +                     if (data->fanin_mask & BIT_CHECK(i))
> > +                             gpio14_17 |=3D FANIN_SEL(i);
> > +             } else if (i < 12) {
> > +                     if (data->pwm_mask & BIT_CHECK(i))
> > +                             gpio10_13 |=3D PWM_SEL(i);
> > +                     if (data->fanin_mask & BIT_CHECK(i))
> > +                             gpio0_3 |=3D FANIN_SEL(i);
> > +             } else {
> > +                     if (data->pwm_mask & BIT_CHECK(i))
> > +                             gpio14_17 |=3D PWM_SEL(i);
> > +                     if (data->fanin_mask & BIT_CHECK(i))
> > +                             gpio4_7 |=3D FANIN_SEL(i);
> > +             }
> > +     }
> > +
> > +     /* Pin Function Configuration */
> > +     ret =3D regmap_write(data->regmap, NCT7363_REG_GPIO_0_3, gpio0_3)=
;
> > +     if (ret < 0)
> > +             return ret;
> > +     ret =3D regmap_write(data->regmap, NCT7363_REG_GPIO_4_7, gpio4_7)=
;
> > +     if (ret < 0)
> > +             return ret;
> > +     ret =3D regmap_write(data->regmap, NCT7363_REG_GPIO_10_13, gpio10=
_13);
> > +     if (ret < 0)
> > +             return ret;
> > +     ret =3D regmap_write(data->regmap, NCT7363_REG_GPIO_14_17, gpio14=
_17);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     /* PWM and FANIN Monitoring Enable */
> > +     ret =3D regmap_write(data->regmap, NCT7363_REG_PWMEN_0_7,
> > +                        data->pwm_mask & 0xff);
> > +     if (ret < 0)
> > +             return ret;
> > +     ret =3D regmap_write(data->regmap, NCT7363_REG_PWMEN_8_15,
> > +                        (data->pwm_mask >> 8) & 0xff);
> > +     if (ret < 0)
> > +             return ret;
> > +     ret =3D regmap_write(data->regmap, NCT7363_REG_FANINEN_0_7,
> > +                        data->fanin_mask & 0xff);
> > +     if (ret < 0)
> > +             return ret;
> > +     ret =3D regmap_write(data->regmap, NCT7363_REG_FANINEN_8_15,
> > +                        (data->fanin_mask >> 8) & 0xff);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     return 0;
> > +}
> > +
> > +static int nct7363_present_pwm_fanin(struct device *dev,
> > +                                  struct device_node *child,
> > +                                  struct nct7363_data *data)
> > +{
> > +     struct of_phandle_args args;
> > +     int ret, fanin_cnt;
> > +     u8 *fanin_ch;
> > +     u8 ch, index;
> > +
> > +     ret =3D of_parse_phandle_with_args(child, "pwms", "#pwm-cells",
> > +                                      0, &args);
> > +     if (ret)
> > +             return ret;
> > +
> > +     data->pwm_mask |=3D BIT(args.args[0]);
> > +
> > +     fanin_cnt =3D of_property_count_u8_elems(child, "tach-ch");
> > +     if (fanin_cnt < 1)
> > +             return -EINVAL;
> > +
> > +     fanin_ch =3D devm_kcalloc(dev, fanin_cnt, sizeof(*fanin_ch), GFP_=
KERNEL);
> > +     if (!fanin_ch)
> > +             return -ENOMEM;
> > +
> > +     ret =3D of_property_read_u8_array(child, "tach-ch", fanin_ch, fan=
in_cnt);
> > +     if (ret)
> > +             return ret;
> > +
> > +     for (ch =3D 0; ch < fanin_cnt; ch++) {
> > +             index =3D fanin_ch[ch];
> > +             data->fanin_mask |=3D BIT(index);
> > +     }
> > +
> > +     return 0;
> > +}
>
> I didn't check if this aligns with the fan bindings schema. Unfortunately
> the dt maintainer's reviewed-by: tag got lost with
> https://patchwork.kernel.org/project/linux-hwmon/patch/20231222013352.387=
3689-2-kcfeng0@nuvoton.com/
>
> o we can not really move forward until that is resolved.

ok, I'll keep monitoring the fan binding schema.

Thanks,
Ban

>
> > +
> > +static const struct regmap_config nct7363_regmap_config =3D {
> > +     .reg_bits =3D 8,
> > +     .val_bits =3D 8,
> > +};
> > +
> > +static int nct7363_probe(struct i2c_client *client)
> > +{
> > +     struct device *dev =3D &client->dev;
> > +     struct device_node *child;
> > +     struct nct7363_data *data;
> > +     struct device *hwmon_dev;
> > +     int ret;
> > +
> > +     data =3D devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> > +     if (!data)
> > +             return -ENOMEM;
> > +
> > +     data->regmap =3D devm_regmap_init_i2c(client, &nct7363_regmap_con=
fig);
> > +     if (IS_ERR(data->regmap))
> > +             return PTR_ERR(data->regmap);
> > +
> > +     mutex_init(&data->update_lock);
> > +
> > +     for_each_child_of_node(dev->of_node, child) {
> > +             ret =3D nct7363_present_pwm_fanin(dev, child, data);
> > +             if (ret) {
> > +                     of_node_put(child);
> > +                     return ret;
> > +             }
> > +     }
> > +
> > +     /* Initialize the chip */
> > +     ret =3D nct7363_init_chip(data);
> > +     if (ret)
> > +             return ret;
> > +
> > +     hwmon_dev =3D
> > +             devm_hwmon_device_register_with_info(dev, client->name, d=
ata,
> > +                                                  &nct7363_chip_info, =
NULL);
> > +     return PTR_ERR_OR_ZERO(hwmon_dev);
> > +}
> > +
> > +static struct i2c_driver nct7363_driver =3D {
> > +     .class =3D I2C_CLASS_HWMON,
> > +     .driver =3D {
> > +             .name =3D "nct7363",
> > +             .of_match_table =3D nct7363_of_match,
> > +     },
> > +     .probe =3D nct7363_probe,
> > +     .id_table =3D nct7363_id,
> > +     .detect =3D nct7363_detect,
> > +     .address_list =3D normal_i2c,
> > +};
> > +
> > +module_i2c_driver(nct7363_driver);
> > +
> > +MODULE_AUTHOR("CW Ho <cwho@nuvoton.com>");
> > +MODULE_AUTHOR("Ban Feng <kcfeng0@nuvoton.com>");
> > +MODULE_DESCRIPTION("NCT7363 Hardware Monitoring Driver");
> > +MODULE_LICENSE("GPL");

