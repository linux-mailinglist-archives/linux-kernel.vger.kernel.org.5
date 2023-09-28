Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB967B1C05
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 14:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbjI1MSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 08:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbjI1MSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 08:18:41 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF1E139;
        Thu, 28 Sep 2023 05:18:38 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-3511d2f6130so35691845ab.1;
        Thu, 28 Sep 2023 05:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695903517; x=1696508317; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yEyfhkOj8h/97/XN2KL1IbjqMcJwrA80q5fpC/mUjuE=;
        b=ISGllCVlUHfwgdMqw/d7ORJt/ETwX+z8PncpRKVOTfkwIFUEMhWQlWheHnuv//j5Nj
         RPye9Raw0REiiqnp1dD9J55lJzuy/X+X+SVD5JCouU3PP02GAsVDTC/gjcSsOppAMfyj
         qx8B8sCT+Qu50RB9vTNx+LZfRcCBypGw3gdmNbvFvMeY9350qraLVUkNXogM/QIxvswT
         paHm7MSO/H9VnoaYD2493MwYnlwpxSfchwVAelLq5ghEmjz9KbUWP8jLafKAuq5BAKb8
         LPI6LGtGXHtcUI3BQQAcRYRlNOXTzPgfPdboE7OBKGyLFofia/rD07jVCJY3+X5n+RB3
         kmiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695903517; x=1696508317;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yEyfhkOj8h/97/XN2KL1IbjqMcJwrA80q5fpC/mUjuE=;
        b=IQ3DFAW3SVsdELgRuQQH93e+sIs4WAi+bPnpfw8OD5+jq1zkDsU/tKrk/Lbvy6SNsV
         xr65FzI3BSl7AlmTTRn8U/BZVDnWaImcytU1s1RdotCx907BNuDxFXg7L1udlzIQVBYZ
         RavATt7Gn3zOl1PpMk0Hx6binHN+MMnBIW0crx0TooYBKs6+D7kJXefXT0U+2O0ZP7pd
         hnar3bY80Z1TRD6MKcJMUajcGn3RENJD4gYHd8qNzqaMC1Cr8dLps7BcxOoBV7xbwR1J
         nZdMynu2PFuVR22IeOEHzx7W3sIyyR7vuM1fIcldqcVN9H27TdQhzyjWHqYRbFOlF0dS
         3cMQ==
X-Gm-Message-State: AOJu0YzMPr0eTYAATIvbdKFYOP8acUnqUCD8i5trlUSBZeKgQhqf5PF6
        Ds0JY6ezSHpODaGSeGuydUk=
X-Google-Smtp-Source: AGHT+IF3nqq1PAaFLuyXqfJepKZWVFAs3quq0YsGTw5SVfQxhPr2LD7unUz7nfem8yXCjQKfwDqmug==
X-Received: by 2002:a92:cda4:0:b0:351:1d2f:5f99 with SMTP id g4-20020a92cda4000000b003511d2f5f99mr1255219ild.26.1695903517559;
        Thu, 28 Sep 2023 05:18:37 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s12-20020a92cc0c000000b0034e1092bccfsm1469817ilp.80.2023.09.28.05.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 05:18:37 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 28 Sep 2023 05:18:35 -0700
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
Subject: Re: [PATCH 2/2] drivers: hwmon: ltc2991: add driver support
Message-ID: <32517aec-4ba7-4812-aacf-97c19d260c2b@roeck-us.net>
References: <20230926140544.80934-1-antoniu.miclaus@analog.com>
 <20230926140544.80934-2-antoniu.miclaus@analog.com>
 <8c8b5a788089a169a47b9fa10048cf17d2085df4.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8c8b5a788089a169a47b9fa10048cf17d2085df4.camel@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 09:37:16AM +0200, Nuno Sá wrote:
> Hi Antoniu,
> 
> some comments from me...
> 
> On Tue, 2023-09-26 at 17:05 +0300, Antoniu Miclaus wrote:
> > Add support for LTC2991 Octal I2C Voltage, Current, and Temperature
> > Monitor.
> > 
> > The LTC2991 is used to monitor system temperatures, voltages and
> > currents. Through the I 2C serial interface, theeight monitors can
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
> >  drivers/hwmon/ltc2991.c         | 490 ++++++++++++++++++++++++++++++++
> >  6 files changed, 554 insertions(+)
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
> > +supply voltages and can be paired for differential measurements of current sense
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
> > +         supports a combination of voltage, current and temperature monitoring.
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
> > index 000000000000..51a60ca8c24e
> > --- /dev/null
> > +++ b/drivers/hwmon/ltc2991.c
> > @@ -0,0 +1,490 @@
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
> > +       u32                     r_sense_mohm[LTC2991_MAX_CHANNEL];
> > +       bool                    temp_en[LTC2991_MAX_CHANNEL];
> > +};
> > +
> > +static int ltc2991_read_reg(struct ltc2991_state *st, u8 addr, u8 reg_len,
> > +                           int *val)
> > +{
> > +       u8 regvals[2];
> > +       int ret;
> > +       int i;
> > +
> > +       ret = regmap_bulk_read(st->regmap, addr, regvals, reg_len);
> > +       if (ret)
> > +               return ret;
> > +
> > +       *val = 0;
> > +       for (i = 0; i < reg_len; i++)
> > +               *val |= regvals[reg_len - i - 1] << (i * 8);
> 
> Hmm this does not look good :)... You should use proper __be annotations and API...
> 
> > +
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
> > +static int ltc2991_read_in(struct device *dev, u32 attr, int channel, long *val)
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
> > +                                / st->r_sense_mohm[channel];
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
> you could just return...
> > +               break;
> > +       default:
> > +               return -EOPNOTSUPP;
> > +       }
> > +
> > +       return ltc2991_get_curr(st, reg, channel, val);
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
> 
> nit: you could just return in each of the statements...
> 
> > +               break;
> > +       default:
> > +               return -EOPNOTSUPP;
> > +       }
> > +
> > +       return ltc2991_get_temp(st, reg, channel, val);
> > +}
> > +
> > +static int ltc2991_read(struct device *dev, enum hwmon_sensor_types type, u32
> > attr, int channel,
> > +                       long *val)
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
> > +static umode_t ltc2991_is_visible(const void *data, enum hwmon_sensor_types type,
> > u32 attr,
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
> > +                       if (st->r_sense_mohm[channel])
> > +                               return 0444;
> 
> Is this is a real usecase? I mean, not having a rsense? If not, I would just make the
> property mandatory...
> 

It doesn't make sense. There should be a default if the property
isn't there, and a property value of 0 should not be accepted.

However, I think the chip only monitors current or voltage or temperature
on each channel, so something is wrong anyway. Figure 1 in the datasheet
shows this pretty well: It consumes all input pins and has
one current sensor, three voltage sensors, two external temperature sensors,
and the internal temperature sensor. That makes a total of 7 sensors,
not all the sensors enabled here. Essentially,

- If voltages are differential, only every other voltage is enabled
- If temperature sensors are enabled, the corresponding output pins
  do not monitor voltage or current
- current channels are only enabled if differential voltage measurement
  is enabled (or, in other words, enabling a current sensor disables
  the second associated voltage sensor)

This must all be reflected here, and the existence of a current sense
resistor should not be the deciding factor to determine if current
sensing is enabled on a set of input pins. That should be explicit.

Per datasheet, chip default is that all channels are configured to
report voltages. Either that or, much better, the current chip configuration
should be the default if there is no devicetree data (because that enables
systems where defaults are set by the rom monitor or bios, and it enables
module test code).

Guenter
