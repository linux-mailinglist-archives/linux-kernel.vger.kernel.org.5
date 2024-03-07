Return-Path: <linux-kernel+bounces-94798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6645E87455B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 01:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A5351C20FB7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 00:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBACC4A21;
	Thu,  7 Mar 2024 00:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LshMCD47"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6093A4689;
	Thu,  7 Mar 2024 00:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709772916; cv=none; b=YgJBtpxuu6BMQyM0ph2lDGzc31ScNNVZzQhZPquEbG8hdaBNnmJ0mTOHrZUDKh0Wh+kaXKZcZy3WdHWhTUTHrP41pZMiguffM8HDSl5SGi9P+DPYPR8feJCA+IxxQ6WyYWwATmh1WyxmM4g47wvKGmLfGcsh4mGPDg/otC/elaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709772916; c=relaxed/simple;
	bh=MZWeknNV/AwCdX1jR/E1aRttDA5Dv7xAaogyiOmrr0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KWX9sWLPAphGKliGb3MnPJzCCYcftgB0pzkNbzoS0xze2ubKpgMfGWq2Y2LIV9d91158fcZ43+ChMm3vGSybd1yrk7tu9z1FMxX7nvrwocGxAAB2n2gBbdUvlHp48Y3cNP6DBR7fmPFzkuoVTD1ywO8zqIDZ69iHW42gn5tu21g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LshMCD47; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-365145ef32fso772845ab.1;
        Wed, 06 Mar 2024 16:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709772913; x=1710377713; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DAHe8fDY3ZMByPdDsZ8n5wvnpHMA8C8o1UVgw8bB+io=;
        b=LshMCD47TocAIz9Itj8TVXNlpFyOOP8kY13+gaxA42i2lm7sRtWSG7vbZBJUfLPA8c
         WXNFFGyRIc+ZF+V2I5kOFnudEUZmnizF4w9cEAwVJ5hf3wbL7DN9gplNoCOKvVszWluZ
         SkLrCRaOjKzQK6IkWPLR2vEEUn+hZjeOGQx7gvFtVC7KaGbQWn2JdMcOiOt2FmZZeCz4
         KCXyxZso6hkb22fgtTHrGfFdlPN0GSmrHnHU3ciM5OXLuv2CrcUFHPqdZD+brbYdtyaM
         YkwwJ/Mng/dKX7CwT78lYoLSknd8tdQJqLSGSKBXkMYaFpi54bSg0EEiSoJEA4+sau4T
         +8ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709772913; x=1710377713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DAHe8fDY3ZMByPdDsZ8n5wvnpHMA8C8o1UVgw8bB+io=;
        b=rTVMauND3ojR0BV6AHQkSQk/IugC9mg5GnUotC/btC9iWUveaumgT211gIxJn6kSZe
         5/U2U3fTY5X77e2fbXLF0pKFP2WaqrxeYmQKb71vI1j8hopcooWCL4mEMp/ftg5ORsXc
         5A9mlky4G4Nx2vWbs1KQrTo++Uhmdc2VUBInQ4PQN7089ykd86irrjDsF9Yv4TZoo5YJ
         NBORc7BmoOy988NPQA24PMt1NqtSG+vANLtMAeBcJAzDksgyzF+WWCMqdt4NNDQXkEgm
         TjMnlIEdUZFFzLTc7FAzji5hK+eihKE7hGctpSJgBz7rsCu9YEZ10TGwR/UseEjZi+ei
         8jRg==
X-Forwarded-Encrypted: i=1; AJvYcCVepG5baiJQC84uQA4xkp2S/lSQfb6sEAbc39qXx2L5nKlrxNmD6+QlW+NiBIIEO6eg9NwhIT9r1UaslTIIpUfX0IqGWyI/wPbwNsNKcMa3HbbceTs++85W5pUMNNBgxmNIGCwVSHmR9997fr6PRV4YoMQdxCJbdhQZZxQjicmmlhdKudE9jYaQsvHZvhzJFRy7q7MAXIHh33X6/5oPK5VY
X-Gm-Message-State: AOJu0YzwxzfbjKlkLlKivrLTUdvnYG+1gf5TdZWi3GEjcwlBdbc/pZW7
	L7WSeRrRwKzc/lqZbscZN3OP4ghDXpCpIOX1F7LmxctdT3UpTWSYYRGnpMk1ewQF6MjsLDmw1XV
	tzCHfyDNFFh3ajPL9v805epWCvPA=
X-Google-Smtp-Source: AGHT+IFhRcePuXr51fFOSJaO94Wyf7r3N6D4M8eoRd5tYx5wU1KSS9KCQz44ejZldzzZ4tJBuaPrZ9hUwosOQqedQwg=
X-Received: by 2002:a92:c24e:0:b0:365:c1fc:dc07 with SMTP id
 k14-20020a92c24e000000b00365c1fcdc07mr19874608ilo.0.1709772913357; Wed, 06
 Mar 2024 16:55:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227005606.1107203-1-kcfeng0@nuvoton.com> <20240227005606.1107203-4-kcfeng0@nuvoton.com>
 <62f38808-7d5f-4466-a65e-b6a64b2e7c01@molgen.mpg.de>
In-Reply-To: <62f38808-7d5f-4466-a65e-b6a64b2e7c01@molgen.mpg.de>
From: Ban Feng <baneric926@gmail.com>
Date: Thu, 7 Mar 2024 08:55:01 +0800
Message-ID: <CALz278YmJTFBj57nm6fbfLjcJcjiDg=ToOeb+mSSwSgRNTJkew@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] hwmon: Driver for Nuvoton NCT7363Y
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, corbet@lwn.net, 
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, kcfeng0@nuvoton.com, 
	kwliu@nuvoton.com, openbmc@lists.ozlabs.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, DELPHINE_CHIU@wiwynn.com, 
	naresh.solanki@9elements.com, billy_tsai@aspeedtech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Wed, Feb 28, 2024 at 3:57=E2=80=AFPM Paul Menzel <pmenzel@molgen.mpg.de>=
 wrote:
>
> Dear Ban,
>
>
> Thank you for your patch. Some minor things from my side.
>
>
> Am 27.02.24 um 01:56 schrieb baneric926@gmail.com:
> > From: Ban Feng <kcfeng0@nuvoton.com>
> >
> > NCT7363Y is an I2C based hardware monitoring chip from Nuvoton.
>
> Please reference the datasheet.
>
> Could you please give a high level description of the driver design?
>
> I=E2=80=99d also add a verb (in imperative mood) to the commit message su=
mmary,
> so it=E2=80=99s a statement:
>
> Add driver for I2C chip Nuvoton NCT7363Y

ok, I'll add some reviews to describe this chip for pwm and fan in v5.

>
> > Signed-off-by: Ban Feng <kcfeng0@nuvoton.com>
> > ---
> >   Documentation/hwmon/index.rst   |   1 +
> >   Documentation/hwmon/nct7363.rst |  33 +++
> >   MAINTAINERS                     |   2 +
> >   drivers/hwmon/Kconfig           |  11 +
> >   drivers/hwmon/Makefile          |   1 +
> >   drivers/hwmon/nct7363.c         | 412 +++++++++++++++++++++++++++++++=
+
> >   6 files changed, 460 insertions(+)
> >   create mode 100644 Documentation/hwmon/nct7363.rst
> >   create mode 100644 drivers/hwmon/nct7363.c
> >
> > diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.=
rst
> > index c7ed1f73ac06..302f954b45be 100644
> > --- a/Documentation/hwmon/index.rst
> > +++ b/Documentation/hwmon/index.rst
> > @@ -165,6 +165,7 @@ Hardware Monitoring Kernel Drivers
> >      mp5990
> >      nct6683
> >      nct6775
> > +   nct7363
> >      nct7802
> >      nct7904
> >      npcm750-pwm-fan
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
>
> fan controller

ok, fix in v5

>
> > +FAN input monitors, and up to 16 independent PWM output with SMBus int=
erface.
>
> output*s*

ok, fix in v5

>
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
>
> In the diff view this does not align with the =E2=80=9Choles=E2=80=9D.

ok, fix in v5

>
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 7b1efefed7c4..7ca66b713e30 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -15089,6 +15089,8 @@ M:    Ban Feng <kcfeng0@nuvoton.com>
> >   L:  linux-hwmon@vger.kernel.org
> >   S:  Maintained
> >   F:  Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.yaml
> > +F:   Documentation/hwmon/nct7363.rst
> > +F:   drivers/hwmon/nct7363.c
> >
> >   NETDEVSIM
> >   M:  Jakub Kicinski <kuba@kernel.org>
> > diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> > index a608264da87d..a297b5409b04 100644
> > --- a/drivers/hwmon/Kconfig
> > +++ b/drivers/hwmon/Kconfig
> > @@ -1616,6 +1616,17 @@ config SENSORS_NCT6775_I2C
> >         This driver can also be built as a module. If so, the module
> >         will be called nct6775-i2c.
> >
> > +config SENSORS_NCT7363
> > +     tristate "Nuvoton NCT7363Y"
> > +     depends on I2C
> > +     select REGMAP_I2C
> > +     help
> > +       If you say yes here you get support for the Nuvoton NCT7363Y,
>
> The comma is not needed.

ok, fix in v5

>
> > +       hardware monitoring chip.
> > +
> > +       This driver can also be built as a module. If so, the module
> > +       will be called nct7363.
> > +
> >   config SENSORS_NCT7802
> >       tristate "Nuvoton NCT7802Y"
> >       depends on I2C
> > diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> > index 47be39af5c03..d5e7531204df 100644
> > --- a/drivers/hwmon/Makefile
> > +++ b/drivers/hwmon/Makefile
> > @@ -167,6 +167,7 @@ obj-$(CONFIG_SENSORS_NCT6775_CORE) +=3D nct6775-cor=
e.o
> >   nct6775-objs                        :=3D nct6775-platform.o
> >   obj-$(CONFIG_SENSORS_NCT6775)       +=3D nct6775.o
> >   obj-$(CONFIG_SENSORS_NCT6775_I2C) +=3D nct6775-i2c.o
> > +obj-$(CONFIG_SENSORS_NCT7363)        +=3D nct7363.o
> >   obj-$(CONFIG_SENSORS_NCT7802)       +=3D nct7802.o
> >   obj-$(CONFIG_SENSORS_NCT7904)       +=3D nct7904.o
> >   obj-$(CONFIG_SENSORS_NPCM7XX)       +=3D npcm750-pwm-fan.o
> > diff --git a/drivers/hwmon/nct7363.c b/drivers/hwmon/nct7363.c
> > new file mode 100644
> > index 000000000000..c79d3ca4f111
> > --- /dev/null
> > +++ b/drivers/hwmon/nct7363.c
> > @@ -0,0 +1,412 @@
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
> > +#define NCT7363_REG_FANINX_HVAL(x)   (0x48 + ((x) * 2))
> > +#define NCT7363_REG_FANINX_LVAL(x)   (0x49 + ((x) * 2))
> > +#define NCT7363_REG_FSCPXDUTY(x)     (0x90 + ((x) * 2))
> > +
> > +#define PWM_SEL(x)                   (BIT(0) << (((x) % 4) * 2))
> > +#define FANIN_SEL(x)                 (BIT(1) << (((x) % 4) * 2))
> > +
> > +#define NCT7363_FANINX_LVAL_MASK     GENMASK(4, 0)
> > +#define NCT7363_FANIN_MASK           GENMASK(12, 0)
> > +
> > +#define NCT7363_PWM_COUNT            16
> > +
> > +static inline unsigned long FAN_FROM_REG(u16 val)
> > +{
> > +     /* In case fan is stopped or divide by 0 */
> > +     if (val =3D=3D NCT7363_FANIN_MASK || val =3D=3D 0)
>
> The comment seems redundant. Maybe also apply the mask to `val` and
> check the result.
>
> > +             return  0;
> > +
> > +     return (1350000UL / val);
>
> Why does the mask not to be applied to `val`?
>

The combination of the fan count value is given by FANINx_HVAL 8-bit
register (fan count value[12:5]) and FANINx_LVAL 8-bit register (fan
count value[4:0], [7:5] is reserved and the default value is 0).
Therefore, I don't apply NCT7363_FANIN_MASK to val. And there are two
values we need to consider, 0x0000 and 0xff1f. 0x0000 means FANINx
monitoring is disabled, and 0xff1f means FANINx monitoring is enabled
but doesn't connect to the fan.

> > +}
> > +
> > +static const struct of_device_id nct7363_of_match[] =3D {
> > +     { .compatible =3D "nuvoton,nct7363" },
> > +     { },
> > +};
> > +MODULE_DEVICE_TABLE(of, nct7363_of_match);
> > +
> > +struct nct7363_data {
> > +     struct regmap           *regmap;
> > +     struct mutex            lock; /* protect register access */
> > +
> > +     u16                     fanin_mask;
> > +     u16                     pwm_mask;
> > +};
> > +
> > +static int nct7363_read_fan(struct device *dev, u32 attr, int channel,
> > +                         long *val)
> > +{
> > +     struct nct7363_data *data =3D dev_get_drvdata(dev);
> > +     unsigned int hi, lo;
> > +     u16 cnt, rpm;
> > +     int ret =3D 0;
> > +
> > +     switch (attr) {
> > +     case hwmon_fan_input:
> > +             /*
> > +              * High-byte register should be read first to latch
> > +              * synchronous low-byte value
> > +              */
> > +             ret =3D regmap_read(data->regmap,
> > +                               NCT7363_REG_FANINX_HVAL(channel), &hi);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             ret =3D regmap_read(data->regmap,
> > +                     NCT7363_REG_FANINX_LVAL(channel), &lo);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             cnt =3D (hi << 5) | (lo & NCT7363_FANINX_LVAL_MASK);
> > +             rpm =3D FAN_FROM_REG(cnt);
> > +             *val =3D (long)rpm;
>
> Could `FAN_FROM_REG()` return long, so the cast here is not needed?

ok, fix in v5

>
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
> > +             if (data->fanin_mask & BIT(channel))
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
> > +     struct nct7363_data *data =3D dev_get_drvdata(dev);
> > +     unsigned int regval;
> > +     u16 ret;
> > +
> > +     switch (attr) {
> > +     case hwmon_pwm_input:
> > +             ret =3D regmap_read(data->regmap,
> > +                               NCT7363_REG_FSCPXDUTY(channel), &regval=
);
>
>      int regmap_read(struct regmap *map, unsigned int reg, unsigned int
> val);
>
> So `ret` should be `int`?

ok, fix in v5

Thanks,
Ban

>
>
> Kind regards,
>
> Paul
>
>
> > +             if (ret)
> > +                     return ret;
> > +
> > +             *val =3D (long)regval;
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
> > +     struct nct7363_data *data =3D dev_get_drvdata(dev);
> > +     int ret;
> > +
> > +     switch (attr) {
> > +     case hwmon_pwm_input:
> > +             if (val < 0 || val > 255)
> > +                     return -EINVAL;
> > +
> > +             mutex_lock(&data->lock);
> > +             ret =3D regmap_write(data->regmap,
> > +                                NCT7363_REG_FSCPXDUTY(channel), val);
> > +             mutex_unlock(&data->lock);
> > +
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
> > +             if (data->pwm_mask & BIT(channel))
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
> > +static int nct7363_init_chip(struct nct7363_data *data)
> > +{
> > +     u8 i, gpio0_3 =3D 0, gpio4_7 =3D 0, gpio10_13 =3D 0, gpio14_17 =
=3D 0;
> > +     int ret;
> > +
> > +     for (i =3D 0; i < NCT7363_PWM_COUNT; i++) {
> > +             if (i < 4) {
> > +                     if (data->pwm_mask & BIT(i))
> > +                             gpio0_3 |=3D PWM_SEL(i);
> > +                     if (data->fanin_mask & BIT(i))
> > +                             gpio10_13 |=3D FANIN_SEL(i);
> > +             } else if (i < 8) {
> > +                     if (data->pwm_mask & BIT(i))
> > +                             gpio4_7 |=3D PWM_SEL(i);
> > +                     if (data->fanin_mask & BIT(i))
> > +                             gpio14_17 |=3D FANIN_SEL(i);
> > +             } else if (i < 12) {
> > +                     if (data->pwm_mask & BIT(i))
> > +                             gpio10_13 |=3D PWM_SEL(i);
> > +                     if (data->fanin_mask & BIT(i))
> > +                             gpio0_3 |=3D FANIN_SEL(i);
> > +             } else {
> > +                     if (data->pwm_mask & BIT(i))
> > +                             gpio14_17 |=3D PWM_SEL(i);
> > +                     if (data->fanin_mask & BIT(i))
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
> > +     mutex_init(&data->lock);
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
> > +};
> > +
> > +module_i2c_driver(nct7363_driver);
> > +
> > +MODULE_AUTHOR("CW Ho <cwho@nuvoton.com>");
> > +MODULE_AUTHOR("Ban Feng <kcfeng0@nuvoton.com>");
> > +MODULE_DESCRIPTION("NCT7363 Hardware Monitoring Driver");
> > +MODULE_LICENSE("GPL");

