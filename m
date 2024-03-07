Return-Path: <linux-kernel+bounces-95061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DADD8748C3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2857B21E6A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 07:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0366310B;
	Thu,  7 Mar 2024 07:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGQFUs+L"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38275B5CD;
	Thu,  7 Mar 2024 07:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709796945; cv=none; b=eVOasqsD/nnRXjx+1CI3QQbbYkBbK5j3hAeXcRfRgmim7RQS7vMHnWXozO3SjqWv5uV5ZdulJPxnntbb2XqX6cQqeCXvMyntvWd3IM+1rx0g/Nw06z4Jaio3lv6plf0UytfIDi+FuhQJiZb2MKWex1vhXrIs31zB25MrA8I6U2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709796945; c=relaxed/simple;
	bh=AY3Ffcl9bf3nf8DvhE/HU6wQyOXgqGVp3L4C9NUUvwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OItQVNY3uleQsikqn6gk2M6NqfS5ZjVwaj5xnUyFKcZ4OG0nfe5TJ4WbGCdlKWtmhdfdm9q38QiMzfMZO8kFrS+gM/lNKE/ErCOOU6BL1qMYu4dMpitY38EQM3kEtDyD5JyvgD6dQJO54Phd+w+SWVmxw+gfdCwk6KQ/5oMIDho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MGQFUs+L; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-365337ad3e7so1647195ab.0;
        Wed, 06 Mar 2024 23:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709796943; x=1710401743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M6klZq6AmNzVM+PTbG3iiD1mw+FE3TQNzK9Dec3sUVw=;
        b=MGQFUs+LxL4MV/FQtdR6c/GKko9abeaRycVuOS1nGe+PKVAJ+IS4rAaTPnJAwscSVR
         O3KPQAbscmRIIW+wkqWLKH54wVC2xNbYinqsGBsO7bCqMydWKUxHVcbVvl7XsnL+rEgh
         MqYjZtntMlOravfTnR4geNvARZquo4Xs6ePrVwpemrA+pgJZv/9qzxSLPh6rgttEnJEN
         mmazaXwOpNfzwR7bhl0qVZ/8psq/ZBUmpPzNt/JQWYkKwBKvNdUYmaLk0Hhupwz6HcRR
         TYl6MOZKExS86jUhjLJfWnpqLleWt+Z0zr2Se/Fildc9FzL08Ksi2S7oa9NdQfjQfp5x
         Kqxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709796943; x=1710401743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M6klZq6AmNzVM+PTbG3iiD1mw+FE3TQNzK9Dec3sUVw=;
        b=qinkuDkLjWKN4jhZI6LNt4txuGrMNauJxDEmqM1pV3oGAGYRNepT3X0/EbjpxJ4TnX
         zSvapz1rsh+7bjMA+vtTK/h4qN4RjYgGy9ak76jOoeB0o9JfHAI5deQYCcoQ9ajwjVfc
         pIAvqk9hRUjZyH+IwpvxPffm0LeFKZSbCJPkT9MB4nTNnwN5iKNrTEz5l5h7V4yXjQej
         mTr8wz1XwMFTr2Dh5LvZGzErdaQHG0VRJ/6AHADn7NMak8qRY6Ru9Xi7P2YCGF3xbDnd
         zWMktLQrD7phQgSSN4rF//5NMcKVuo1NMMFSxsnrqYh8KBpMZVKGSE6ZiTVpWGAKtoG5
         TdZA==
X-Forwarded-Encrypted: i=1; AJvYcCUqieglj+0qioMnr48DMvHYTj9S9pTGyVJhj7JirYNB8We1uMoej56Ks9gFtPTjO41ZM3JGaS/c9HARiZP6xPM1ijOGxBB3SUxF4JcnVtzKp9US1VGCWg1+PXRqksIXtj4Dc4nrm3rs2WJ7LYxK6o719bO52ZniV3exIeb5VN53bu8PKVBWKTjeAqVz+/glrBHmR3Lmj+BRF5Ko7b0/04ow
X-Gm-Message-State: AOJu0YzWXIb2GbJUbP+58TijrFQsftmsZ/ssRw7ZF2FnmiJhu0UKGbcM
	JxKEXtiAdGOJQiIFNKvxBLqdUGKhY/Tb+mAs0+VBlm00LXQVi6r3NwA6mbOJ7QlUlMUjQf8/n1R
	E7sANUUZczH43CDVRlHZnwSMsXlA=
X-Google-Smtp-Source: AGHT+IGN33EUdloTeB6A/XXwtUjVayj3HyCq/K/UgigAb8TsWgLjQTuBGZUH8ioiaV618F31xgzAb4wPSjh8tkX4OP4=
X-Received: by 2002:a05:6e02:1687:b0:365:b506:509e with SMTP id
 f7-20020a056e02168700b00365b506509emr26223113ila.17.1709796942857; Wed, 06
 Mar 2024 23:35:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227005606.1107203-1-kcfeng0@nuvoton.com> <20240227005606.1107203-4-kcfeng0@nuvoton.com>
 <a90ed00c-f836-4fb6-8191-9974937e3eb7@hatter.bewilderbeest.net>
In-Reply-To: <a90ed00c-f836-4fb6-8191-9974937e3eb7@hatter.bewilderbeest.net>
From: Ban Feng <baneric926@gmail.com>
Date: Thu, 7 Mar 2024 15:35:31 +0800
Message-ID: <CALz278Zgfgob573vgWz4PgC7vb=i8xt3kC1hSjo_cQi00B0XAg@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] hwmon: Driver for Nuvoton NCT7363Y
To: Zev Weiss <zev@bewilderbeest.net>
Cc: jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, corbet@lwn.net, 
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, kcfeng0@nuvoton.com, 
	kwliu@nuvoton.com, openbmc@lists.ozlabs.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, DELPHINE_CHIU@wiwynn.com, 
	naresh.solanki@9elements.com, billy_tsai@aspeedtech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zev,

On Sat, Mar 2, 2024 at 4:19=E2=80=AFPM Zev Weiss <zev@bewilderbeest.net> wr=
ote:
>
> On Mon, Feb 26, 2024 at 04:56:06PM PST, baneric926@gmail.com wrote:
> >From: Ban Feng <kcfeng0@nuvoton.com>
> >
> >NCT7363Y is an I2C based hardware monitoring chip from Nuvoton.
> >
> >Signed-off-by: Ban Feng <kcfeng0@nuvoton.com>
> >---
> > Documentation/hwmon/index.rst   |   1 +
> > Documentation/hwmon/nct7363.rst |  33 +++
> > MAINTAINERS                     |   2 +
> > drivers/hwmon/Kconfig           |  11 +
> > drivers/hwmon/Makefile          |   1 +
> > drivers/hwmon/nct7363.c         | 412 ++++++++++++++++++++++++++++++++
> > 6 files changed, 460 insertions(+)
> > create mode 100644 Documentation/hwmon/nct7363.rst
> > create mode 100644 drivers/hwmon/nct7363.c
> >
> >diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.r=
st
> >index c7ed1f73ac06..302f954b45be 100644
> >--- a/Documentation/hwmon/index.rst
> >+++ b/Documentation/hwmon/index.rst
> >@@ -165,6 +165,7 @@ Hardware Monitoring Kernel Drivers
> >    mp5990
> >    nct6683
> >    nct6775
> >+   nct7363
> >    nct7802
> >    nct7904
> >    npcm750-pwm-fan
> >diff --git a/Documentation/hwmon/nct7363.rst b/Documentation/hwmon/nct73=
63.rst
> >new file mode 100644
> >index 000000000000..89699c95aa4b
> >--- /dev/null
> >+++ b/Documentation/hwmon/nct7363.rst
> >@@ -0,0 +1,33 @@
> >+.. SPDX-License-Identifier: GPL-2.0
> >+
> >+Kernel driver nct7363
> >+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >+
> >+Supported chip:
> >+
> >+  * Nuvoton NCT7363Y
> >+
> >+    Prefix: nct7363
> >+
> >+    Addresses: I2C 0x20, 0x21, 0x22, 0x23
> >+
> >+Author: Ban Feng <kcfeng0@nuvoton.com>
> >+
> >+
> >+Description
> >+-----------
> >+
> >+The NCT7363Y is a Fan controller which provides up to 16 independent
> >+FAN input monitors, and up to 16 independent PWM output with SMBus inte=
rface.
> >+
> >+
> >+Sysfs entries
> >+-------------
> >+
> >+Currently, the driver supports the following features:
> >+
> >+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> >+fanX_input            provide current fan rotation value in RPM
> >+
> >+pwmX                  get or set PWM fan control value.
> >+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> >diff --git a/MAINTAINERS b/MAINTAINERS
> >index 7b1efefed7c4..7ca66b713e30 100644
> >--- a/MAINTAINERS
> >+++ b/MAINTAINERS
> >@@ -15089,6 +15089,8 @@ M:     Ban Feng <kcfeng0@nuvoton.com>
> > L:    linux-hwmon@vger.kernel.org
> > S:    Maintained
> > F:    Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.yaml
> >+F:    Documentation/hwmon/nct7363.rst
> >+F:    drivers/hwmon/nct7363.c
> >
> > NETDEVSIM
> > M:    Jakub Kicinski <kuba@kernel.org>
> >diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> >index a608264da87d..a297b5409b04 100644
> >--- a/drivers/hwmon/Kconfig
> >+++ b/drivers/hwmon/Kconfig
> >@@ -1616,6 +1616,17 @@ config SENSORS_NCT6775_I2C
> >         This driver can also be built as a module. If so, the module
> >         will be called nct6775-i2c.
> >
> >+config SENSORS_NCT7363
> >+      tristate "Nuvoton NCT7363Y"
> >+      depends on I2C
> >+      select REGMAP_I2C
> >+      help
> >+        If you say yes here you get support for the Nuvoton NCT7363Y,
> >+        hardware monitoring chip.
> >+
> >+        This driver can also be built as a module. If so, the module
> >+        will be called nct7363.
> >+
> > config SENSORS_NCT7802
> >       tristate "Nuvoton NCT7802Y"
> >       depends on I2C
> >diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> >index 47be39af5c03..d5e7531204df 100644
> >--- a/drivers/hwmon/Makefile
> >+++ b/drivers/hwmon/Makefile
> >@@ -167,6 +167,7 @@ obj-$(CONFIG_SENSORS_NCT6775_CORE) +=3D nct6775-core=
o
> > nct6775-objs                  :=3D nct6775-platform.o
> > obj-$(CONFIG_SENSORS_NCT6775) +=3D nct6775.o
> > obj-$(CONFIG_SENSORS_NCT6775_I2C) +=3D nct6775-i2c.o
> >+obj-$(CONFIG_SENSORS_NCT7363) +=3D nct7363.o
> > obj-$(CONFIG_SENSORS_NCT7802) +=3D nct7802.o
> > obj-$(CONFIG_SENSORS_NCT7904) +=3D nct7904.o
> > obj-$(CONFIG_SENSORS_NPCM7XX) +=3D npcm750-pwm-fan.o
> >diff --git a/drivers/hwmon/nct7363.c b/drivers/hwmon/nct7363.c
> >new file mode 100644
> >index 000000000000..c79d3ca4f111
> >--- /dev/null
> >+++ b/drivers/hwmon/nct7363.c
> >@@ -0,0 +1,412 @@
> >+// SPDX-License-Identifier: GPL-2.0-or-later
> >+/*
> >+ * Copyright (c) 2023 Nuvoton Technology corporation.
> >+ */
> >+
> >+#include <linux/bitfield.h>
> >+#include <linux/bits.h>
> >+#include <linux/err.h>
> >+#include <linux/hwmon.h>
> >+#include <linux/hwmon-sysfs.h>
> >+#include <linux/i2c.h>
> >+#include <linux/module.h>
> >+#include <linux/mutex.h>
> >+#include <linux/regmap.h>
> >+#include <linux/slab.h>
> >+
> >+#define NCT7363_REG_GPIO_0_3          0x20
> >+#define NCT7363_REG_GPIO_4_7          0x21
> >+#define NCT7363_REG_GPIO_10_13                0x22
> >+#define NCT7363_REG_GPIO_14_17                0x23
> >+#define NCT7363_REG_PWMEN_0_7         0x38
> >+#define NCT7363_REG_PWMEN_8_15                0x39
> >+#define NCT7363_REG_FANINEN_0_7               0x41
> >+#define NCT7363_REG_FANINEN_8_15      0x42
> >+#define NCT7363_REG_FANINX_HVAL(x)    (0x48 + ((x) * 2))
> >+#define NCT7363_REG_FANINX_LVAL(x)    (0x49 + ((x) * 2))
> >+#define NCT7363_REG_FSCPXDUTY(x)      (0x90 + ((x) * 2))
> >+
> >+#define PWM_SEL(x)                    (BIT(0) << (((x) % 4) * 2))
> >+#define FANIN_SEL(x)                  (BIT(1) << (((x) % 4) * 2))
> >+
> >+#define NCT7363_FANINX_LVAL_MASK      GENMASK(4, 0)
> >+#define NCT7363_FANIN_MASK            GENMASK(12, 0)
> >+
> >+#define NCT7363_PWM_COUNT             16
> >+
> >+static inline unsigned long FAN_FROM_REG(u16 val)
> >+{
> >+      /* In case fan is stopped or divide by 0 */
> >+      if (val =3D=3D NCT7363_FANIN_MASK || val =3D=3D 0)
> >+              return  0;
> >+
> >+      return (1350000UL / val);
> >+}
> >+
> >+static const struct of_device_id nct7363_of_match[] =3D {
> >+      { .compatible =3D "nuvoton,nct7363" },
>
> As far as I can see from the code in this driver, it looks like this
> driver should also be compatible with the nct7362; shall we add the ID
> table entry for it now?  (Though I only have a datasheet for the
> nct7362, not the nct7363, so I don't know exactly how they differ.)

As far as I know, the difference between these two ICs is 0x2A~0x2C
Fading LED for 7362, and 0x2A Watchdog Timer for 7363.
In my v1 patch, I indeed add the nct7362 to the ID table, however,
this makes it more complicated and our datasheet isn't public yet.
I think maybe supporting more chips will be done in the future, but not now=
.

>
> >+      { },
> >+};
> >+MODULE_DEVICE_TABLE(of, nct7363_of_match);
> >+
> >+struct nct7363_data {
> >+      struct regmap           *regmap;
> >+      struct mutex            lock; /* protect register access */
> >+
> >+      u16                     fanin_mask;
> >+      u16                     pwm_mask;
> >+};
> >+
> >+static int nct7363_read_fan(struct device *dev, u32 attr, int channel,
> >+                          long *val)
> >+{
> >+      struct nct7363_data *data =3D dev_get_drvdata(dev);
> >+      unsigned int hi, lo;
> >+      u16 cnt, rpm;
> >+      int ret =3D 0;
> >+
> >+      switch (attr) {
> >+      case hwmon_fan_input:
> >+              /*
> >+               * High-byte register should be read first to latch
> >+               * synchronous low-byte value
> >+               */
> >+              ret =3D regmap_read(data->regmap,
> >+                                NCT7363_REG_FANINX_HVAL(channel), &hi);
> >+              if (ret)
> >+                      return ret;
> >+
> >+              ret =3D regmap_read(data->regmap,
> >+                      NCT7363_REG_FANINX_LVAL(channel), &lo);
> >+              if (ret)
> >+                      return ret;
>
> I think this pair of reads should be done under data->lock to ensure
> that the LVAL read gets the right latched value in a scenario where
> multiple threads executing this function end up with their register
> reads interleaved.

ok, fix in v5

>
> >+
> >+              cnt =3D (hi << 5) | (lo & NCT7363_FANINX_LVAL_MASK);
> >+              rpm =3D FAN_FROM_REG(cnt);
> >+              *val =3D (long)rpm;
>
> Given that rpm is assigned from an unsigned long (FAN_FROM_REG()) and
> then to a long (*val), is there any reason we want it as a u16 in
> between the two?  Or for that matter, why not just:
>
>    *val =3D FAN_FROM_REG(cnt);
>
> ?

I'll modify this to align with the style of the nct7363_read_pwm function i=
n v5.

>
> >+              return 0;
> >+      default:
> >+              return -EOPNOTSUPP;
> >+      }
> >+}
> >+
> >+static umode_t nct7363_fan_is_visible(const void *_data, u32 attr, int =
channel)
> >+{
> >+      const struct nct7363_data *data =3D _data;
> >+
> >+      switch (attr) {
> >+      case hwmon_fan_input:
> >+              if (data->fanin_mask & BIT(channel))
> >+                      return 0444;
> >+              break;
> >+      default:
> >+              break;
> >+      }
> >+
> >+      return 0;
> >+}
> >+
> >+static int nct7363_read_pwm(struct device *dev, u32 attr, int channel,
> >+                          long *val)
> >+{
> >+      struct nct7363_data *data =3D dev_get_drvdata(dev);
> >+      unsigned int regval;
> >+      u16 ret;
> >+
> >+      switch (attr) {
> >+      case hwmon_pwm_input:
> >+              ret =3D regmap_read(data->regmap,
> >+                                NCT7363_REG_FSCPXDUTY(channel), &regval=
);
> >+              if (ret)
> >+                      return ret;
> >+
> >+              *val =3D (long)regval;
> >+              return 0;
> >+      default:
> >+              return -EOPNOTSUPP;
> >+      }
> >+}
> >+
> >+static int nct7363_write_pwm(struct device *dev, u32 attr, int channel,
> >+                           long val)
> >+{
> >+      struct nct7363_data *data =3D dev_get_drvdata(dev);
> >+      int ret;
> >+
> >+      switch (attr) {
> >+      case hwmon_pwm_input:
> >+              if (val < 0 || val > 255)
> >+                      return -EINVAL;
> >+
> >+              mutex_lock(&data->lock);
> >+              ret =3D regmap_write(data->regmap,
> >+                                 NCT7363_REG_FSCPXDUTY(channel), val);
> >+              mutex_unlock(&data->lock);
>
> ...though here, I'm not sure the locking is needed -- is there something
> that necessitates it for a single register write?

ok, fix in v5

>
> >+
> >+              return ret;
> >+
> >+      default:
> >+              return -EOPNOTSUPP;
> >+      }
> >+}
> >+
> >+static umode_t nct7363_pwm_is_visible(const void *_data, u32 attr, int =
channel)
> >+{
> >+      const struct nct7363_data *data =3D _data;
> >+
> >+      switch (attr) {
> >+      case hwmon_pwm_input:
> >+              if (data->pwm_mask & BIT(channel))
> >+                      return 0644;
> >+              break;
> >+      default:
> >+              break;
> >+      }
> >+
> >+      return 0;
> >+}
> >+
> >+static int nct7363_read(struct device *dev, enum hwmon_sensor_types typ=
e,
> >+                      u32 attr, int channel, long *val)
> >+{
> >+      switch (type) {
> >+      case hwmon_fan:
> >+              return nct7363_read_fan(dev, attr, channel, val);
> >+      case hwmon_pwm:
> >+              return nct7363_read_pwm(dev, attr, channel, val);
> >+      default:
> >+              return -EOPNOTSUPP;
> >+      }
> >+}
> >+
> >+static int nct7363_write(struct device *dev, enum hwmon_sensor_types ty=
pe,
> >+                       u32 attr, int channel, long val)
> >+{
> >+      switch (type) {
> >+      case hwmon_pwm:
> >+              return nct7363_write_pwm(dev, attr, channel, val);
> >+      default:
> >+              return -EOPNOTSUPP;
> >+      }
> >+}
> >+
> >+static umode_t nct7363_is_visible(const void *data,
> >+                                enum hwmon_sensor_types type,
> >+                                u32 attr, int channel)
> >+{
> >+      switch (type) {
> >+      case hwmon_fan:
> >+              return nct7363_fan_is_visible(data, attr, channel);
> >+      case hwmon_pwm:
> >+              return nct7363_pwm_is_visible(data, attr, channel);
> >+      default:
> >+              return 0;
> >+      }
> >+}
> >+
> >+static const struct hwmon_channel_info *nct7363_info[] =3D {
> >+      HWMON_CHANNEL_INFO(fan,
> >+                         HWMON_F_INPUT,
> >+                         HWMON_F_INPUT,
> >+                         HWMON_F_INPUT,
> >+                         HWMON_F_INPUT,
> >+                         HWMON_F_INPUT,
> >+                         HWMON_F_INPUT,
> >+                         HWMON_F_INPUT,
> >+                         HWMON_F_INPUT,
> >+                         HWMON_F_INPUT,
> >+                         HWMON_F_INPUT,
> >+                         HWMON_F_INPUT,
> >+                         HWMON_F_INPUT,
> >+                         HWMON_F_INPUT,
> >+                         HWMON_F_INPUT,
> >+                         HWMON_F_INPUT,
> >+                         HWMON_F_INPUT),
> >+      HWMON_CHANNEL_INFO(pwm,
> >+                         HWMON_PWM_INPUT,
> >+                         HWMON_PWM_INPUT,
> >+                         HWMON_PWM_INPUT,
> >+                         HWMON_PWM_INPUT,
> >+                         HWMON_PWM_INPUT,
> >+                         HWMON_PWM_INPUT,
> >+                         HWMON_PWM_INPUT,
> >+                         HWMON_PWM_INPUT,
> >+                         HWMON_PWM_INPUT,
> >+                         HWMON_PWM_INPUT,
> >+                         HWMON_PWM_INPUT,
> >+                         HWMON_PWM_INPUT,
> >+                         HWMON_PWM_INPUT,
> >+                         HWMON_PWM_INPUT,
> >+                         HWMON_PWM_INPUT,
> >+                         HWMON_PWM_INPUT),
> >+      NULL
> >+};
> >+
> >+static const struct hwmon_ops nct7363_hwmon_ops =3D {
> >+      .is_visible =3D nct7363_is_visible,
> >+      .read =3D nct7363_read,
> >+      .write =3D nct7363_write,
> >+};
> >+
> >+static const struct hwmon_chip_info nct7363_chip_info =3D {
> >+      .ops =3D &nct7363_hwmon_ops,
> >+      .info =3D nct7363_info,
> >+};
> >+
> >+static int nct7363_init_chip(struct nct7363_data *data)
> >+{
> >+      u8 i, gpio0_3 =3D 0, gpio4_7 =3D 0, gpio10_13 =3D 0, gpio14_17 =
=3D 0;
> >+      int ret;
> >+
> >+      for (i =3D 0; i < NCT7363_PWM_COUNT; i++) {
> >+              if (i < 4) {
> >+                      if (data->pwm_mask & BIT(i))
> >+                              gpio0_3 |=3D PWM_SEL(i);
> >+                      if (data->fanin_mask & BIT(i))
> >+                              gpio10_13 |=3D FANIN_SEL(i);
> >+              } else if (i < 8) {
> >+                      if (data->pwm_mask & BIT(i))
> >+                              gpio4_7 |=3D PWM_SEL(i);
> >+                      if (data->fanin_mask & BIT(i))
> >+                              gpio14_17 |=3D FANIN_SEL(i);
> >+              } else if (i < 12) {
> >+                      if (data->pwm_mask & BIT(i))
> >+                              gpio10_13 |=3D PWM_SEL(i);
> >+                      if (data->fanin_mask & BIT(i))
> >+                              gpio0_3 |=3D FANIN_SEL(i);
> >+              } else {
> >+                      if (data->pwm_mask & BIT(i))
> >+                              gpio14_17 |=3D PWM_SEL(i);
> >+                      if (data->fanin_mask & BIT(i))
> >+                              gpio4_7 |=3D FANIN_SEL(i);
> >+              }
> >+      }
>
> With the caveat that I haven't actually sketched it out myself to be
> sure, might it be a bit cleaner to do this with a 4-element array
> indexed by 'i / 4' instead of a big if/else chain and a bunch of
> near-duplicated blocks?

ok, fix in v5

>
> >+
> >+      /* Pin Function Configuration */
> >+      ret =3D regmap_write(data->regmap, NCT7363_REG_GPIO_0_3, gpio0_3)=
;
> >+      if (ret < 0)
> >+              return ret;
> >+      ret =3D regmap_write(data->regmap, NCT7363_REG_GPIO_4_7, gpio4_7)=
;
> >+      if (ret < 0)
> >+              return ret;
> >+      ret =3D regmap_write(data->regmap, NCT7363_REG_GPIO_10_13, gpio10=
_13);
> >+      if (ret < 0)
> >+              return ret;
> >+      ret =3D regmap_write(data->regmap, NCT7363_REG_GPIO_14_17, gpio14=
_17);
> >+      if (ret < 0)
> >+              return ret;
> >+
> >+      /* PWM and FANIN Monitoring Enable */
> >+      ret =3D regmap_write(data->regmap, NCT7363_REG_PWMEN_0_7,
> >+                         data->pwm_mask & 0xff);
> >+      if (ret < 0)
> >+              return ret;
> >+      ret =3D regmap_write(data->regmap, NCT7363_REG_PWMEN_8_15,
> >+                         (data->pwm_mask >> 8) & 0xff);
> >+      if (ret < 0)
> >+              return ret;
> >+      ret =3D regmap_write(data->regmap, NCT7363_REG_FANINEN_0_7,
> >+                         data->fanin_mask & 0xff);
> >+      if (ret < 0)
> >+              return ret;
> >+      ret =3D regmap_write(data->regmap, NCT7363_REG_FANINEN_8_15,
> >+                         (data->fanin_mask >> 8) & 0xff);
> >+      if (ret < 0)
> >+              return ret;
> >+
> >+      return 0;
> >+}
> >+
> >+static int nct7363_present_pwm_fanin(struct device *dev,
> >+                                   struct device_node *child,
> >+                                   struct nct7363_data *data)
> >+{
> >+      struct of_phandle_args args;
> >+      int ret, fanin_cnt;
> >+      u8 *fanin_ch;
> >+      u8 ch, index;
> >+
> >+      ret =3D of_parse_phandle_with_args(child, "pwms", "#pwm-cells",
> >+                                       0, &args);
> >+      if (ret)
> >+              return ret;
> >+
> >+      data->pwm_mask |=3D BIT(args.args[0]);
>
> Perhaps we should have
>
>    if (args.args[0] >=3D NCT7363_PWM_COUNT)
>      return -EINVAL;
>
> here?

ok, fix in v5

>
> >+
> >+      fanin_cnt =3D of_property_count_u8_elems(child, "tach-ch");
> >+      if (fanin_cnt < 1)
>
> fanin_cnt < 1 || fanin_cnt >=3D NCT7363_PWM_COUNT

ok, fix in v5

>
> >+              return -EINVAL;
> >+
> >+      fanin_ch =3D devm_kcalloc(dev, fanin_cnt, sizeof(*fanin_ch), GFP_=
KERNEL);
>
> Keeping this allocation around persistently for the whole lifetime of
> the device seems unnecessary -- it's not used beyond this function,
> right?  In fact, dynamically allocating it at all seems like overkill,
> considering that in addition to being temporary, it's also got a pretty
> small upper bound on its size.  I'd think a simple
>
>    u8 fanin_ch[NCT7363_PWM_COUNT];
>
> would suffice?  (Along with the check above to ensure fanin_cnt is
> within range of course.)

ok, fix in v5

>
> >+      if (!fanin_ch)
> >+              return -ENOMEM;
> >+
> >+      ret =3D of_property_read_u8_array(child, "tach-ch", fanin_ch, fan=
in_cnt);
> >+      if (ret)
> >+              return ret;
> >+
> >+      for (ch =3D 0; ch < fanin_cnt; ch++) {
> >+              index =3D fanin_ch[ch];
>
> ...and likewise a range check here too?

ok, fix in v5

>
> >+              data->fanin_mask |=3D BIT(index);
> >+      }
> >+
>
> Should we also grab the pulses-per-revolution property here and factor
> that in in FAN_FROM_REG()?

So far our FanPoles in tachometer count calculation formula is always 4.
Therefore, I don't add the pulses-per-revolution property into FAN_FROM_REG=
().

>
> >+      return 0;
> >+}
> >+
> >+static const struct regmap_config nct7363_regmap_config =3D {
> >+      .reg_bits =3D 8,
> >+      .val_bits =3D 8,
> >+};
> >+
> >+static int nct7363_probe(struct i2c_client *client)
> >+{
> >+      struct device *dev =3D &client->dev;
> >+      struct device_node *child;
> >+      struct nct7363_data *data;
> >+      struct device *hwmon_dev;
> >+      int ret;
> >+
> >+      data =3D devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> >+      if (!data)
> >+              return -ENOMEM;
> >+
> >+      data->regmap =3D devm_regmap_init_i2c(client, &nct7363_regmap_con=
fig);
> >+      if (IS_ERR(data->regmap))
> >+              return PTR_ERR(data->regmap);
> >+
> >+      mutex_init(&data->lock);
> >+
> >+      for_each_child_of_node(dev->of_node, child) {
> >+              ret =3D nct7363_present_pwm_fanin(dev, child, data);
> >+              if (ret) {
> >+                      of_node_put(child);
> >+                      return ret;
> >+              }
> >+      }
> >+
> >+      /* Initialize the chip */
> >+      ret =3D nct7363_init_chip(data);
> >+      if (ret)
> >+              return ret;
> >+
> >+      hwmon_dev =3D
> >+              devm_hwmon_device_register_with_info(dev, client->name, d=
ata,
> >+                                                   &nct7363_chip_info, =
NULL);
> >+      return PTR_ERR_OR_ZERO(hwmon_dev);
> >+}
> >+
> >+static struct i2c_driver nct7363_driver =3D {
> >+      .class =3D I2C_CLASS_HWMON,
>
> Maybe add an i2c_device_id table to accompany the of_match table?

ok, fix in v5

Thanks,
Ban

>
> >+      .driver =3D {
> >+              .name =3D "nct7363",
> >+              .of_match_table =3D nct7363_of_match,
> >+      },
> >+      .probe =3D nct7363_probe,
> >+};
> >+
> >+module_i2c_driver(nct7363_driver);
> >+
> >+MODULE_AUTHOR("CW Ho <cwho@nuvoton.com>");
> >+MODULE_AUTHOR("Ban Feng <kcfeng0@nuvoton.com>");
> >+MODULE_DESCRIPTION("NCT7363 Hardware Monitoring Driver");
> >+MODULE_LICENSE("GPL");
> >--
> >2.34.1
> >
> >

