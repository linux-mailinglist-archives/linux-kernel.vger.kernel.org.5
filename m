Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A990B7C5615
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 16:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346363AbjJKOAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 10:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235038AbjJKOAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 10:00:52 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BCCCC;
        Wed, 11 Oct 2023 07:00:49 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id a1e0cc1a2514c-7b0e19acda7so2309385241.0;
        Wed, 11 Oct 2023 07:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697032848; x=1697637648; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jH+6qqEgcwxKza9DimoGyjycvj1e7w580IlbqcddsQA=;
        b=RWOOoRA3Dd6Z3HJJnsO9b1o5+P7R7zj6Z4DZo4k8mt6TwW1ISRNmHG4yIigGWbJpVm
         aKi+ocYHLfEep1UtFjllY8qrbLSj2T+euGVHsoknHRSMisVa8fONlRHtisGhKImK8bh5
         Jian/fdWRgqVO3//WsWEV/MtdDGPwrz3tMbvLPmFj0NDW9nkPRwxCAqCXVN2WY8Q73pi
         /65d8lHp9J/rrD7vz5jwL2EqUNwRZSPLmOx1NFVOsYgYRk9FZ2H0ZsyqgWLODswloctT
         NZ5W5hMlOsoJz7je2Fj/PS/YCRI9j6J06xaNEgjea5P1V9XrbrqnNkLtOcev9yq/m5lk
         AR1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697032848; x=1697637648;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jH+6qqEgcwxKza9DimoGyjycvj1e7w580IlbqcddsQA=;
        b=hJU3N6zUz2YD1q2GUOer8u2www+heKwzRW3IjuGrAZKSEwWNEuNs8IgwK8lxE3cNZM
         ThbR2OdD5Niq0vz3yo69nQFE3hfQssx66R15ikHB4FB2lYl/neOxQfSuwUSVXasoArrj
         OPVhf/m/K6sowOfoXT4RrkoMpYBw+Z23a4ZAd+sDErISG7EcX72R9nf20vhJ/PNmsr9C
         1IVvJQWcT3Fnkkn/TQ49IrTqTfrYQv7Zyfq2f0BIduDQsqW42CLTXU+35lksPwx39f8L
         xXmpBba220x+b14f2/u/07kkkPRY6ppkUHOdx3UUx2xPC0noa4nPW9ub+dz0mssud7Rh
         EKug==
X-Gm-Message-State: AOJu0YyIcBvEZGUrjFqgAhgpMeEh4aNTttvlMsltzlHg4BBRfd1BgeP8
        s13re8kykO9rQrmjGPFMOik=
X-Google-Smtp-Source: AGHT+IGKGXODPKTYjLPOFbHpRj41XVgwE9uyALWiIHjTX5S/NrN7c2WJLIwtpa1SS00e5e2AKRfuFQ==
X-Received: by 2002:a67:fd49:0:b0:452:4fcb:cd2a with SMTP id g9-20020a67fd49000000b004524fcbcd2amr18305893vsr.10.1697032848018;
        Wed, 11 Oct 2023 07:00:48 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q24-20020ab054d8000000b0079a1018d185sm864523uaa.31.2023.10.11.07.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 07:00:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 11 Oct 2023 07:00:44 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc:     Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 2/2] drivers: hwmon: ltc2991: add driver support
Message-ID: <1f3bc281-9bb3-4a56-8791-773e2e762513@roeck-us.net>
References: <20231003080059.8041-1-antoniu.miclaus@analog.com>
 <20231003080059.8041-2-antoniu.miclaus@analog.com>
 <1e6ee7f6733d621a9be7fd94d48e41ca76c05a3c.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1e6ee7f6733d621a9be7fd94d48e41ca76c05a3c.camel@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 10:44:44AM +0200, Nuno Sá wrote:
> Hi Antoniu,
> 
> A few more comments from me. But essentially, I think you should revisit V1 and
> Guenter's comments. I'm fairly sure you are still missing his main points...
>  
Yes. And there is no change log either.

Guenter

> On Tue, 2023-10-03 at 11:00 +0300, Antoniu Miclaus wrote:
> > Add support for LTC2991 Octal I2C Voltage, Current, and Temperature
> > Monitor.
> > 
> > The LTC2991 is used to monitor system temperatures, voltages and
> > currents. Through the I2C serial interface, the eight monitors can
> > individually measure supply voltages and can be paired for
> > differential measurements of current sense resistors or temperature
> > sensing transistors. Additional measurements include internal
> > temperature and internal VCC.
> > 
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > ---
> >  Documentation/hwmon/index.rst   |   1 +
> >  Documentation/hwmon/ltc2991.rst |  43 +++
> >  MAINTAINERS                     |   8 +
> >  drivers/hwmon/Kconfig           |  11 +
> >  drivers/hwmon/Makefile          |   1 +
> >  drivers/hwmon/ltc2991.c         | 479 ++++++++++++++++++++++++++++++++
> >  6 files changed, 543 insertions(+)
> >  create mode 100644 Documentation/hwmon/ltc2991.rst
> >  create mode 100644 drivers/hwmon/ltc2991.c
> > 
> > diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> > index 88dadea85cfc..0ec96abe3f7d 100644
> > --- a/Documentation/hwmon/index.rst
> > +++ b/Documentation/hwmon/index.rst
> > @@ -121,6 +121,7 @@ Hardware Monitoring Kernel Drivers
> >     ltc2947
> >     ltc2978
> >     ltc2990
> > +   ltc2991
> >     ltc3815
> >     ltc4151
> >     ltc4215
> > diff --git a/Documentation/hwmon/ltc2991.rst b/Documentation/hwmon/ltc2991.rst
> > new file mode 100644
> > index 000000000000..9ab29dd85012
> > --- /dev/null
> > +++ b/Documentation/hwmon/ltc2991.rst
> > @@ -0,0 +1,43 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +Kernel driver ltc2991
> > +=====================
> > +
> > +Supported chips:
> > +
> > +  * Analog Devices LTC2991
> > +
> > +    Prefix: 'ltc2991'
> > +
> > +    Addresses scanned: I2C 0x48 - 0x4f
> > +
> > +    Datasheet:
> > https://www.analog.com/media/en/technical-documentation/data-sheets/2991ff.pdf
> > +
> > +Authors:
> > +
> > +  - Antoniu Miclaus <antoniu.miclaus@analog.com>
> > +
> > +
> > +Description
> > +-----------
> > +
> > +This driver supports hardware monitoring for Analog Devices LTC2991 Octal I2C
> > +Voltage, Current and Temperature Monitor.
> > +
> > +The LTC2991 is used to monitor system temperatures, voltages and currents.
> > +Through the I2C serial interface, the eight monitors can individually measure
> > +supply voltages and can be paired for differential measurements of current
> > sense
> > +resistors or temperature sensing transistors. Additional measurements include
> > +internal temperatureand internal VCC.
> > +
> > +
> > +sysfs-Interface
> > +-------------
> > +
> > +The following attributes are supported. Limits are read-only.
> > +
> > +=============== =================
> > +inX_input:      voltage input
> > +currX_input:    current input
> > +tempX_input:    temperature input
> > +=============== =================
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index b19995690904..98dd8a8e1f84 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -12451,6 +12451,14 @@ F:     drivers/hwmon/ltc2947-i2c.c
> >  F:     drivers/hwmon/ltc2947-spi.c
> >  F:     drivers/hwmon/ltc2947.h
> >  
> > +LTC2991 HARDWARE MONITOR DRIVER
> > +M:     Antoniu Miclaus <antoniu.miclaus@analog.com>
> > +L:     linux-hwmon@vger.kernel.org
> > +S:     Supported
> > +W:     https://ez.analog.com/linux-software-drivers
> > +F:     Documentation/devicetree/bindings/hwmon/adi,ltc2991.yaml
> > +F:     drivers/hwmon/ltc2991.c
> > +
> >  LTC2983 IIO TEMPERATURE DRIVER
> >  M:     Nuno Sá <nuno.sa@analog.com>
> >  L:     linux-iio@vger.kernel.org
> > diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> > index ec38c8892158..818a67328fcd 100644
> > --- a/drivers/hwmon/Kconfig
> > +++ b/drivers/hwmon/Kconfig
> > @@ -932,6 +932,17 @@ config SENSORS_LTC2990
> >           This driver can also be built as a module. If so, the module will
> >           be called ltc2990.
> >  
> > +config SENSORS_LTC2991
> > +       tristate "Analog Devices LTC2991"
> > +       depends on I2C
> > +       help
> > +         If you say yes here you get support for Analog Devices LTC2991
> > +         Octal I2C Voltage, Current, and Temperature Monitor. The LTC2991
> > +         supports a combination of voltage, current and temperature
> > monitoring.
> > +
> > +         This driver can also be built as a module. If so, the module will
> > +         be called ltc2991.
> > +
> >  config SENSORS_LTC2992
> >         tristate "Linear Technology LTC2992"
> >         depends on I2C
> > diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> > index 4ac9452b5430..f324d057535a 100644
> > --- a/drivers/hwmon/Makefile
> > +++ b/drivers/hwmon/Makefile
> > @@ -127,6 +127,7 @@ obj-$(CONFIG_SENSORS_LTC2947)       += ltc2947-core.o
> >  obj-$(CONFIG_SENSORS_LTC2947_I2C) += ltc2947-i2c.o
> >  obj-$(CONFIG_SENSORS_LTC2947_SPI) += ltc2947-spi.o
> >  obj-$(CONFIG_SENSORS_LTC2990)  += ltc2990.o
> > +obj-$(CONFIG_SENSORS_LTC2991)  += ltc2991.o
> >  obj-$(CONFIG_SENSORS_LTC2992)  += ltc2992.o
> >  obj-$(CONFIG_SENSORS_LTC4151)  += ltc4151.o
> >  obj-$(CONFIG_SENSORS_LTC4215)  += ltc4215.o
> > diff --git a/drivers/hwmon/ltc2991.c b/drivers/hwmon/ltc2991.c
> > new file mode 100644
> > index 000000000000..b5333c25cb31
> > --- /dev/null
> > +++ b/drivers/hwmon/ltc2991.c
> > @@ -0,0 +1,479 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2023 Analog Devices, Inc.
> > + * Author: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > + */
> > +
> > +#include <linux/bitops.h>
> > +#include <linux/err.h>
> > +#include <linux/hwmon.h>
> > +#include <linux/hwmon-sysfs.h>
> > +#include <linux/i2c.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/property.h>
> > +#include <linux/regmap.h>
> > +#include <linux/regulator/consumer.h>
> > +
> > +#include <asm/unaligned.h>
> > +
> > +#define LTC2991_STATUS_LOW             0x00
> > +#define LTC2991_CH_EN_TRIGGER          0x01
> > +#define LTC2991_V1_V4_CTRL             0x06
> > +#define LTC2991_V5_V8_CTRL             0x07
> > +#define LTC2991_PWM_TH_LSB_T_INT       0x08
> > +#define LTC2991_PWM_TH_MSB             0x09
> > +#define LTC2991_CHANNEL_V_MSB(x)       (0x0A + ((x) * 2))
> > +#define LTC2991_CHANNEL_T_MSB(x)       (0x0A + ((x) * 4))
> > +#define LTC2991_CHANNEL_C_MSB(x)       (0x0C + ((x) * 4))
> > +#define LTC2991_T_INT_MSB              0x1A
> > +#define LTC2991_VCC_MSB                        0x1C
> > +
> > +#define LTC2991_V7_V8_EN               BIT(7)
> > +#define LTC2991_V5_V6_EN               BIT(6)
> > +#define LTC2991_V3_V4_EN               BIT(5)
> > +#define LTC2991_V1_V2_EN               BIT(4)
> > +#define LTC2991_T_INT_VCC_EN           BIT(3)
> > +
> > +#define LTC2991_V3_V4_FILT_EN          BIT(7)
> > +#define LTC2991_V3_V4_TEMP_EN          BIT(5)
> > +#define LTC2991_V3_V4_DIFF_EN          BIT(4)
> > +#define LTC2991_V1_V2_FILT_EN          BIT(3)
> > +#define LTC2991_V1_V2_TEMP_EN          BIT(1)
> > +#define LTC2991_V1_V2_DIFF_EN          BIT(0)
> > +
> > +#define LTC2991_V7_V8_FILT_EN          BIT(7)
> > +#define LTC2991_V7_V8_TEMP_EN          BIT(5)
> > +#define LTC2991_V7_V8_DIFF_EN          BIT(4)
> > +#define LTC2991_V5_V6_FILT_EN          BIT(7)
> > +#define LTC2991_V5_V6_TEMP_EN          BIT(5)
> > +#define LTC2991_V5_V6_DIFF_EN          BIT(4)
> > +
> > +#define LTC2991_REPEAT_ACQ_EN          BIT(4)
> > +#define LTC2991_T_INT_FILT_EN          BIT(3)
> > +
> > +#define LTC2991_MAX_CHANNEL            4
> > +#define LTC2991_T_INT_CH_NR            4
> > +#define LTC2991_VCC_CH_NR              0
> > +
> > +static const char *const label_voltages[] = {
> > +       "vcc",
> > +       "voltage1",
> > +       "voltage2",
> > +       "voltage3",
> > +       "voltage4",
> > +       "voltage5",
> > +       "voltage6",
> > +       "voltage7",
> > +       "voltage8"
> > +};
> > +
> > +static const char *const label_temp[] = {
> > +       "t1",
> > +       "t2",
> > +       "t3",
> > +       "t4",
> > +       "t_int"
> > +};
> > +
> > +static const char *const label_curr[] = {
> > +       "v1-v2",
> > +       "v3-v4",
> > +       "v5-v6",
> > +       "v7-v8"
> > +};
> > +
> > +struct ltc2991_state {
> > +       struct i2c_client       *client;
> > +       struct regmap           *regmap;
> > +       u32                     r_sense_uohm[LTC2991_MAX_CHANNEL];
> > +       bool                    temp_en[LTC2991_MAX_CHANNEL];
> > +};
> > +
> > +static int ltc2991_read_reg(struct ltc2991_state *st, u8 addr, u8 reg_len,
> > +                           int *val)
> > +{
> > +       u8 regvals[2];
> > +       int ret;
> > +
> > +       if (reg_len > 2 || !reg_len)
> > +               return -EINVAL;
> > +
> 
> IMO, this is too much checking... It's an internal API, just make sure to
> properly call it ;).
> 
> > +       ret = regmap_bulk_read(st->regmap, addr, regvals, reg_len);
> > +       if (ret)
> > +               return ret;
> > +
> > +       if (reg_len == 2)
> > +               *val = get_unaligned_be16(&regvals[0]);
> > +       else
> > +               *val = regvals[0];
> 
> not what I had in mind. Having unaligned access is overkill when you can go with
> typical __be16 + __be16_to_cpu(). If I'm not missing anything, you just have to
> shift out the LSB in case of 1byte registers. Alternatively, before the bulk()
> call you can:
> 
> if (reg_len < 2)
>     return regmap_read();
> 
> and then just assume 2 byte reads...
> 
> > +       return 0;
> > +}
> > +
> > +static int ltc2991_get_voltage(struct ltc2991_state *st, u32 reg, long *val)
> > +{
> > +       int reg_val, ret, offset = 0;
> > +
> > +       ret = ltc2991_read_reg(st, reg, 2, &reg_val);
> > +       if (ret)
> > +               return ret;
> > +
> > +       if (reg == LTC2991_VCC_MSB)
> > +               /* Vcc 2.5V offset */
> > +               offset = 2500;
> > +
> > +       /* Vx, 305.18uV/LSB */
> > +       *val = DIV_ROUND_CLOSEST(sign_extend32(reg_val, 14) * 30518,
> > +                                1000 * 100) + offset;
> > +
> > +       return 0;
> > +}
> > +
> > +static int ltc2991_read_in(struct device *dev, u32 attr, int channel, long
> > *val)
> > +{
> > +       struct ltc2991_state *st = dev_get_drvdata(dev);
> > +       u32 reg;
> > +
> > +       switch (attr) {
> > +       case hwmon_in_input:
> > +               if (channel == LTC2991_VCC_CH_NR)
> > +                       reg = LTC2991_VCC_MSB;
> > +               else
> > +                       reg = LTC2991_CHANNEL_V_MSB(channel - 1);
> > +               break;
> > +       default:
> > +               return -EOPNOTSUPP;
> > +       }
> > +
> > +       return ltc2991_get_voltage(st, reg, val);
> > +}
> > +
> > +static int ltc2991_get_curr(struct ltc2991_state *st, u32 reg, int channel,
> > +                           long *val)
> > +{
> > +       int reg_val, ret;
> > +
> > +       ret = ltc2991_read_reg(st, reg, 2, &reg_val);
> > +       if (ret)
> > +               return ret;
> > +
> > +       /* Vx-Vy, 19.075uV/LSB */
> > +       *val = DIV_ROUND_CLOSEST(sign_extend32(reg_val, 14) * 19075, 1000)
> > +                                / (st->r_sense_uohm[channel] / 1000);
> > +
> > +       return 0;
> > +}
> > +
> > +static int ltc2991_read_curr(struct device *dev, u32 attr, int channel,
> > +                            long *val)
> > +{
> > +       struct ltc2991_state *st = dev_get_drvdata(dev);
> > +       u32 reg;
> > +
> > +       switch (attr) {
> > +       case hwmon_curr_input:
> > +               reg = LTC2991_CHANNEL_C_MSB(channel);
> > +               return ltc2991_get_curr(st, reg, channel, val);
> > +       default:
> > +               return -EOPNOTSUPP;
> > +       }
> > +}
> > +
> > +static int ltc2991_get_temp(struct ltc2991_state *st, u32 reg, int channel,
> > +                           long *val)
> > +{
> > +       int reg_val, ret;
> > +
> > +       ret = ltc2991_read_reg(st, reg, 2, &reg_val);
> > +       if (ret)
> > +               return ret;
> > +
> > +       /* Temp LSB = 0.0625 Degrees */
> > +       *val = DIV_ROUND_CLOSEST(sign_extend32(reg_val, 12) * 1000, 16);
> > +
> > +       return 0;
> > +}
> > +
> > +static int ltc2991_read_temp(struct device *dev, u32 attr, int channel,
> > +                            long *val)
> > +{
> > +       struct ltc2991_state *st = dev_get_drvdata(dev);
> > +       u32 reg;
> > +
> > +       switch (attr) {
> > +       case hwmon_temp_input:
> > +               if (channel == LTC2991_T_INT_CH_NR)
> > +                       reg = LTC2991_T_INT_MSB;
> > +               else
> > +                       reg = LTC2991_CHANNEL_T_MSB(channel);
> > +
> > +               return ltc2991_get_temp(st, reg, channel, val);
> > +       default:
> > +               return -EOPNOTSUPP;
> > +       }
> > +}
> > +
> > +static int ltc2991_read(struct device *dev, enum hwmon_sensor_types type,
> > +                       u32 attr, int channel, long *val)
> > +{
> > +       switch (type) {
> > +       case hwmon_in:
> > +               return ltc2991_read_in(dev, attr, channel, val);
> > +       case hwmon_curr:
> > +               return ltc2991_read_curr(dev, attr, channel, val);
> > +       case hwmon_temp:
> > +               return ltc2991_read_temp(dev, attr, channel, val);
> > +       default:
> > +               return -EOPNOTSUPP;
> > +       }
> > +}
> > +
> > +static umode_t ltc2991_is_visible(const void *data,
> > +                                 enum hwmon_sensor_types type, u32 attr,
> > +                                 int channel)
> > +{
> > +       const struct ltc2991_state *st = data;
> > +
> > +       switch (type) {
> > +       case hwmon_in:
> > +               switch (attr) {
> > +               case hwmon_in_input:
> > +               case hwmon_in_label:
> > +                       return 0444;
> > +               }
> > +               break;
> > +       case hwmon_curr:
> > +               switch (attr) {
> > +               case hwmon_curr_input:
> > +               case hwmon_curr_label:
> > +                       if (st->r_sense_uohm[channel])
> > +                               return 0444;
> > +                       break;
> > +               }
> 
> This is what I was speaking about... You should go read again v1 an try to
> understand the points made or continue the discussion.
> 
> I didn't looked at the datasheet but what I understood from Guenter is that each
> channel can only be a specific type of sensor and you should be explicit about
> that (not using rsense as the deciding factor). Thus, your bindings should
> likely be refactored so you have a property that explicitly "defines" a channel
> (not forgetting to handle things like differential channels and overlaps etc...)
> and then you need to reflect the ABI according to what sensors OF/ACPI have
> defined.
> 
> This looks a bit like the ltc2983 [1] I upstreamed where most of the fun was in 
> defining the channels (and maybe that one was actually an hwmon driver but what
> did I know back then :))
> 
> Also important is that in absence of OF/ACPI, you should read whatever
> configuration is the device holding so, once again, you export the correct ABI.
> But in this case, I'm not really sure what would be a sane (if there's one) for
> rsense in case of a current sensor.
> 
> Hopefully I got it right...
> 
> > +               break;
> > +       case hwmon_temp:
> > +               switch (attr) {
> > +               case hwmon_temp_input:
> > +               case hwmon_temp_label:
> > +                       if (st->temp_en[channel] ||
> > +                           channel == LTC2991_T_INT_CH_NR)
> > +                               return 0444;
> > +                       break;
> > +               }
> > +               break;
> > +       default:
> > +               break;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int ltc2991_read_string(struct device *dev, enum hwmon_sensor_types
> > type,
> > +                              u32 attr, int channel, const char **str)
> > +{
> > +       switch (type) {
> > +       case hwmon_temp:
> > +               *str = label_temp[channel];
> > +               break;
> > +       case hwmon_curr:
> > +               *str = label_curr[channel];
> > +               break;
> > +       case hwmon_in:
> > +               *str = label_voltages[channel];
> > +               break;
> > +       default:
> > +               return -EOPNOTSUPP;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static const struct hwmon_ops ltc2991_hwmon_ops = {
> > +       .is_visible = ltc2991_is_visible,
> > +       .read = ltc2991_read,
> > +       .read_string = ltc2991_read_string,
> > +};
> > +
> > +static const struct hwmon_channel_info *ltc2991_info[] = {
> > +       HWMON_CHANNEL_INFO(temp,
> > +                          HWMON_T_INPUT | HWMON_T_LABEL,
> > +                          HWMON_T_INPUT | HWMON_T_LABEL,
> > +                          HWMON_T_INPUT | HWMON_T_LABEL,
> > +                          HWMON_T_INPUT | HWMON_T_LABEL,
> > +                          HWMON_T_INPUT | HWMON_T_LABEL
> > +                          ),
> > +       HWMON_CHANNEL_INFO(curr,
> > +                          HWMON_C_INPUT | HWMON_C_LABEL,
> > +                          HWMON_C_INPUT | HWMON_C_LABEL,
> > +                          HWMON_C_INPUT | HWMON_C_LABEL,
> > +                          HWMON_C_INPUT | HWMON_C_LABEL
> > +                          ),
> > +       HWMON_CHANNEL_INFO(in,
> > +                          HWMON_I_INPUT | HWMON_I_LABEL,
> > +                          HWMON_I_INPUT | HWMON_I_LABEL,
> > +                          HWMON_I_INPUT | HWMON_I_LABEL,
> > +                          HWMON_I_INPUT | HWMON_I_LABEL,
> > +                          HWMON_I_INPUT | HWMON_I_LABEL,
> > +                          HWMON_I_INPUT | HWMON_I_LABEL,
> > +                          HWMON_I_INPUT | HWMON_I_LABEL,
> > +                          HWMON_I_INPUT | HWMON_I_LABEL,
> > +                          HWMON_I_INPUT | HWMON_I_LABEL
> > +                          ),
> > +       NULL
> > +};
> > +
> > +static const struct hwmon_chip_info ltc2991_chip_info = {
> > +       .ops = &ltc2991_hwmon_ops,
> > +       .info = ltc2991_info,
> > +};
> > +
> > +static const struct regmap_config ltc2991_regmap_config = {
> > +       .reg_bits = 8,
> > +       .val_bits = 8,
> > +       .max_register = 0x1D,
> > +};
> > +
> > +static int ltc2991_init(struct ltc2991_state *st)
> > +{
> > +       struct fwnode_handle *child;
> > +       int ret;
> > +       u32 val, addr;
> > +       u8 v5_v8_reg_data = 0, v1_v4_reg_data = 0;
> > +
> > +       ret = devm_regulator_get_enable(&st->client->dev, "vcc");
> > +       if (ret)
> > +               return dev_err_probe(&st->client->dev, ret,
> > +                                    "failed to enable regulator\n");
> > +
> > +       device_for_each_child_node(&st->client->dev, child) {
> > +               ret = fwnode_property_read_u32(child, "reg", &addr);
> > +               if (ret < 0) {
> > +                       fwnode_handle_put(child);
> > +                       return ret;
> > +               }
> > +
> > +               if (addr > 3) {
> > +                       fwnode_handle_put(child);
> > +                       return -EINVAL;
> > +               }
> > +
> > +               ret = fwnode_property_read_u32(child, "shunt-resistor-micro-
> > ohms", &val);
> > +               if (!ret) {
> > +                       st->r_sense_uohm[addr] = val;
> 
> This still allows 0 as a valid value which would lead to a divide by 0
> exception...
> 
> [1]: https://elixir.bootlin.com/linux/v6.6-rc5/source/drivers/iio/temperature/ltc2983.c#L1371
> 
> - Nuno Sá
> 
