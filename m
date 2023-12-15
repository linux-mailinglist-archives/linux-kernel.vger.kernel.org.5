Return-Path: <linux-kernel+bounces-1544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B29EF814FE8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 19:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B2E9285551
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA6A3FB0B;
	Fri, 15 Dec 2023 18:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqoTuJU7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4494E41863;
	Fri, 15 Dec 2023 18:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a22f59c6ae6so134421666b.1;
        Fri, 15 Dec 2023 10:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702666451; x=1703271251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TsWiTsAx6rY/ivEOcOv3qrsTgsfWq4HF82+Qu3XkrJE=;
        b=gqoTuJU7ytF6MxcbsBaDXt67boDp8NFXEh4kz1O+y9fNRaCn+jJ39/aVV52R0J2Q8n
         SgDC3FdFYdM0WvowGEJelm5ESbyx5/bjLloL8QMb+ZYBdd2xvdXESfNttEEi3OHwpER+
         oP44qZuCkRUrs0hZmnIiF3q6onhG90ToclORXeX0PdpNleNLm9QtQOH7d2EB6y+DQGFz
         NcW4R/Nfe2F6Z8TdrPGNPlpaxqhkyN3qOE5AiSscqAgO8NhxE8C+UakZmlQy61Gp9GBM
         0nSLmUyPmG78PmJ9PGn5ZHapjCO8nJydPhnWtEV0jLByERiNKPS5ETaEK5ZFiWNh6xWA
         VHvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702666451; x=1703271251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TsWiTsAx6rY/ivEOcOv3qrsTgsfWq4HF82+Qu3XkrJE=;
        b=Yc5hhcBHNL2Qaa/aDJr95fSZb8/o5djptmrixZYkoifJSytzW5ChFejBTQnNmj3AOp
         OCr1taP2hOdX9UszG3cqHsHXr4cy0Pdd0ioz+Gcz26RbB5eXbmuWufamVPn9PJPBcEMH
         15F7Dn7zHGc9o06zR1L3kVWHw0UwNeiaqvuUJ09A0ZKQ+El1CzGN0rxHLY2WDLP/Gm5y
         LLvukg3RletDopfrwghErdTJ55GYqRzy+s6UfiWc6/OKlhmmwU9IL2bQJ1IgutCaHt3j
         3csMV1awqMj29grLzDOxyso9/qDvhoPe5xHXpSF6ly5nSmECSOlsM5kiYt4SSW+CTVy+
         qk7A==
X-Gm-Message-State: AOJu0YwlOi2tUDZpdAPKpo5LnW6PEqnmmPl4YPEMUKALXtwYFQFGzcrB
	OwPbX+v9k9pn3bdcCNLaObLYvciW1jtJtMa+Nfo=
X-Google-Smtp-Source: AGHT+IGTe60xMdwTz2nmsDBKL83lJlfe2F7HRxnwrlp07sDZDNOE4jdESKX05xcBbPbTErePQGJK86eA3EBbr/+QFJk=
X-Received: by 2002:a17:906:1083:b0:a19:d40a:d238 with SMTP id
 u3-20020a170906108300b00a19d40ad238mr2913096eju.260.1702666451113; Fri, 15
 Dec 2023 10:54:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214060552.2852761-1-chou.cosmo@gmail.com>
 <20231214060552.2852761-4-chou.cosmo@gmail.com> <32806071-7fc1-4f5a-a9ca-99dd9c8f3fb4@roeck-us.net>
In-Reply-To: <32806071-7fc1-4f5a-a9ca-99dd9c8f3fb4@roeck-us.net>
From: Cosmo Chou <chou.cosmo@gmail.com>
Date: Sat, 16 Dec 2023 02:53:59 +0800
Message-ID: <CAOeEDyvNqLXfeAY9D00tZttZXMoLsXuTOZu8c4sXn6dgYHTM6g@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] hwmon: Add driver for Astera Labs PT5161L retimer
To: Guenter Roeck <linux@roeck-us.net>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	jdelvare@suse.com, corbet@lwn.net, broonie@kernel.org, 
	naresh.solanki@9elements.com, vincent@vtremblay.dev, 
	patrick.rudolph@9elements.com, luca.ceresoli@bootlin.com, bhelgaas@google.com, 
	festevam@denx.de, alexander.stein@ew.tq-group.com, heiko@sntech.de, 
	jernej.skrabec@gmail.com, macromorgan@hotmail.com, forbidden405@foxmail.com, 
	sre@kernel.org, linus.walleij@linaro.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-doc@vger.kernel.org, cosmo.chou@quantatw.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 12/14/2023 12:57:10 -0800 Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 12/13/23 22:05, Cosmo Chou wrote:
> > This driver implements support for temperature monitoring of Astera Lab=
s
> > PT5161L series PCIe retimer chips.
> >
> > This driver implementation originates from the CSDK available at
> > Link: https://github.com/facebook/openbmc/tree/helium/common/recipes-li=
b/retimer-v2.14
> > The communication protocol utilized is based on the I2C/SMBus standard.
> >
> > Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>
> > ---
> >   Documentation/hwmon/index.rst   |   1 +
> >   Documentation/hwmon/pt5161l.rst |  42 +++
> >   MAINTAINERS                     |   7 +
> >   drivers/hwmon/Kconfig           |  10 +
> >   drivers/hwmon/Makefile          |   1 +
> >   drivers/hwmon/pt5161l.c         | 558 +++++++++++++++++++++++++++++++=
+
> >   6 files changed, 619 insertions(+)
> >   create mode 100644 Documentation/hwmon/pt5161l.rst
> >   create mode 100644 drivers/hwmon/pt5161l.c
> >
> > diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.=
rst
> > index 72f4e6065bae..f145652098fc 100644
> > --- a/Documentation/hwmon/index.rst
> > +++ b/Documentation/hwmon/index.rst
> > @@ -181,6 +181,7 @@ Hardware Monitoring Kernel Drivers
> >      pmbus
> >      powerz
> >      powr1220
> > +   pt5161l
> >      pxe1610
> >      pwm-fan
> >      q54sj108a2
> > diff --git a/Documentation/hwmon/pt5161l.rst b/Documentation/hwmon/pt51=
61l.rst
> > new file mode 100644
> > index 000000000000..5f4ce3b2f38d
> > --- /dev/null
> > +++ b/Documentation/hwmon/pt5161l.rst
> > @@ -0,0 +1,42 @@
> > +.. SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +Kernel driver pt5161l
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Supported chips:
> > +
> > +  * Astera Labs PT5161L
> > +
> > +    Prefix: 'pt5161l'
> > +
> > +    Addresses: I2C 0x24
> > +
> > +    Datasheet: http://www.asteralabs.com/wp-content/uploads/2021/03/As=
tera_Labs_PT5161L_Product_Brief.pdf
> > +
>
> This is not the datasheet. It is a product brief. This should truthfully =
say
> that the product datasheet is not available to the public.
>
Got it. Thanks for the advice.

> > +Authors: Cosmo Chou <cosmo.chou@quantatw.com>
> > +
> > +Description
> > +-----------
> > +
> > +This driver implements support for temperature monitoring of Astera La=
bs
> > +PT5161L series PCIe retimer chips.
> > +
> > +This driver implementation originates from the CSDK available at
> > +https://github.com/facebook/openbmc/tree/helium/common/recipes-lib/ret=
imer-v2.14
> > +The communication protocol utilized is based on the I2C/SMBus standard=
.
> > +
> > +Sysfs entries
> > +----------------
> > +
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +temp1_input      Measured temperature (in millidegrees Celsius)
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Debugfs entries
> > +----------------
> > +
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +fw_load_status   Firmware load status
> > +fw_ver           Firmware version of the retimer
> > +heartbeat_status Heartbeat status
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index e2c6187a3ac8..8def71ca2ace 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -17421,6 +17421,13 @@ F:   fs/pstore/
> >   F:  include/linux/pstore*
> >   K:  \b(pstore|ramoops)
> >
> > +PT5161L HARDWARE MONITOR DRIVER
> > +M:   Cosmo Chou <cosmo.chou@quantatw.com>
> > +L:   linux-hwmon@vger.kernel.org
> > +S:   Maintained
> > +F:   Documentation/hwmon/pt5161l.rst
> > +F:   drivers/hwmon/pt5161l.c
> > +
> >   PTP HARDWARE CLOCK SUPPORT
> >   M:  Richard Cochran <richardcochran@gmail.com>
> >   L:  netdev@vger.kernel.org
> > diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> > index cf27523eed5a..ccdbcf12aed3 100644
> > --- a/drivers/hwmon/Kconfig
> > +++ b/drivers/hwmon/Kconfig
> > @@ -1703,6 +1703,16 @@ source "drivers/hwmon/peci/Kconfig"
> >
> >   source "drivers/hwmon/pmbus/Kconfig"
> >
> > +config SENSORS_PT5161L
> > +     tristate "Astera Labs PT5161L PCIe retimer hardware monitoring"
> > +     depends on I2C
> > +     help
> > +       If you say yes here you get support for temperature monitoring
> > +       on the Astera Labs PT5161L PCIe retimer.
> > +
> > +       This driver can also be built as a module. If so, the module
> > +       will be called pt5161l.
> > +
> >   config SENSORS_PWM_FAN
> >       tristate "PWM fan"
> >       depends on (PWM && OF) || COMPILE_TEST
> > diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> > index e84bd9685b5c..4e68b808ddac 100644
> > --- a/drivers/hwmon/Makefile
> > +++ b/drivers/hwmon/Makefile
> > @@ -179,6 +179,7 @@ obj-$(CONFIG_SENSORS_PC87427)     +=3D pc87427.o
> >   obj-$(CONFIG_SENSORS_PCF8591)       +=3D pcf8591.o
> >   obj-$(CONFIG_SENSORS_POWERZ)        +=3D powerz.o
> >   obj-$(CONFIG_SENSORS_POWR1220)  +=3D powr1220.o
> > +obj-$(CONFIG_SENSORS_PT5161L)        +=3D pt5161l.o
> >   obj-$(CONFIG_SENSORS_PWM_FAN)       +=3D pwm-fan.o
> >   obj-$(CONFIG_SENSORS_RASPBERRYPI_HWMON)     +=3D raspberrypi-hwmon.o
> >   obj-$(CONFIG_SENSORS_SBTSI) +=3D sbtsi_temp.o
> > diff --git a/drivers/hwmon/pt5161l.c b/drivers/hwmon/pt5161l.c
> > new file mode 100644
> > index 000000000000..95e7fb07699c
> > --- /dev/null
> > +++ b/drivers/hwmon/pt5161l.c
> > @@ -0,0 +1,558 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +#include <linux/debugfs.h>
> > +#include <linux/err.h>
> > +#include <linux/i2c.h>
> > +#include <linux/init.h>
> > +#include <linux/hwmon.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +
> > +/* Temperature measurement constants */
> > +// Aries current average temp ADC code CSR
>
> Please decide if you want to use C++ or C comments throughout.
>
Got it, I will revise the comments.

> > +#define ARIES_CURRENT_AVG_TEMP_ADC_CSR       0x42c
> > +
> > +// Main Micro Heartbeat reg
> > +#define ARIES_MM_HEARTBEAT_ADDR      0x923
> > +
> > +/* Main SRAM */
> > +// AL Main SRAM DMEM offset (A0)
> > +#define AL_MAIN_SRAM_DMEM_OFFSET     (64 * 1024)
> > +// SRAM read command
> > +#define AL_TG_RD_LOC_IND_SRAM        0x16
> > +
> > +/* Micros */
> > +// Offset for main micro FW info
> > +#define ARIES_MAIN_MICRO_FW_INFO     (96 * 1024 - 128)
> > +
> > +/* Path Micro Members */
> > +// FW Info (Major) offset location in struct
> > +#define ARIES_MM_FW_VERSION_MAJOR    0
> > +// FW Info (Minor) offset location in struct
> > +#define ARIES_MM_FW_VERSION_MINOR    1
> > +// FW Info (Build no.) offset location in struct
> > +#define ARIES_MM_FW_VERSION_BUILD    2
> > +
> > +/* Offsets for MM assisted accesses */
> > +// Legacy Address and Data registers (using wide registers)
> > +// Reg offset to specify Address for MM assisted accesses
> > +#define ARIES_MM_ASSIST_REG_ADDR_OFFSET      0xd99
> > +
> > +/* Misc block offsets */
> > +// Device Load check register
> > +#define ARIES_CODE_LOAD_REG  0x605
> > +
> > +/* Value indicating FW was loaded properly */
> > +#define ARIES_LOAD_CODE      0xe
> > +
> > +#define ARIES_TEMP_CAL_CODE_DEFAULT  84
> > +
> > +/* Struct defining FW version loaded on an Aries device */
> > +struct pt5161l_fw_ver {
> > +     u8 major;
> > +     u8 minor;
> > +     u16 build;
> > +};
> > +
> > +/* Each client has this additional data */
> > +struct pt5161l_data {
> > +     struct i2c_client *client;
> > +     struct dentry *debugfs;
> > +     struct pt5161l_fw_ver fw_ver;
> > +     struct mutex lock;
> > +     bool pec_enable;
>
> What is the point of this variable ? It is never set.
>
> > +     bool code_load_okay; // indicate if code load reg value is expect=
ed
> > +     bool mm_heartbeat_okay; // indicate if Main Micro heartbeat is go=
od
> > +};
> > +
> > +static struct dentry *pt5161l_debugfs_dir;
> > +
> > +/*
> > + * Write multiple data bytes to Aries over I2C
> > + */
> > +static int pt5161l_write_block_data(struct pt5161l_data *data, u32 add=
ress,
> > +                                 u8 len, u8 *val)
> > +{
> > +     struct i2c_client *client =3D data->client;
> > +     int ret;
> > +     u8 remain_len =3D len;
> > +     u8 xfer_len, curr_len;
> > +     u8 buf[16];
> > +     u8 cmd =3D 0x0F; // [7]:pec_en, [6:5]:rsvd, [4:2]:func, [1]:start=
, [0]:end
> > +     u8 config =3D 0x40; // [6]:cfg_type, [4:1]:burst_len, [0]:bit16 o=
f address
> > +
> > +     if (data->pec_enable)
> > +             cmd |=3D 0x80;
> > +
>
> Too bad the datasheet isn't public. It is kind of weird to "enable" PEC t=
his
> way. How is it checked if enabled ? How does the i2c subsystem know that =
it
> is enabled, and what happens if PEC _is_ actually enabled ?
>
Checking the datasheet, the read/write used here (so called
"short format") does not use PEC. I will remove this.

> > +     while (remain_len > 0) {
> > +             if (remain_len > 4) {
> > +                     curr_len =3D 4;
> > +                     remain_len -=3D 4;
> > +             } else {
> > +                     curr_len =3D remain_len;
> > +                     remain_len =3D 0;
> > +             }
> > +
> > +             buf[0] =3D config | (curr_len - 1) << 1 | ((address >> 16=
) & 0x1);
> > +             buf[1] =3D (address >> 8) & 0xff;
> > +             buf[2] =3D address & 0xff;
> > +             memcpy(&buf[3], val, curr_len);
> > +
> > +             xfer_len =3D 3 + curr_len;
> > +             ret =3D i2c_smbus_write_block_data(client, cmd, xfer_len,=
 buf);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             val +=3D curr_len;
> > +             address +=3D curr_len;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +/*
> > + * Read multiple data bytes from Aries over I2C
> > + */
> > +static int pt5161l_read_block_data(struct pt5161l_data *data, u32 addr=
ess,
> > +                                u8 len, u8 *val)
> > +{
> > +     struct i2c_client *client =3D data->client;
> > +     int ret, tries;
> > +     u8 remain_len =3D len;
> > +     u8 curr_len;
> > +     u8 wbuf[16], rbuf[24];
> > +     u8 cmd =3D 0x08; // [7]:pec_en, [6:5]:rsvd, [4:2]:func, [1]:start=
, [0]:end
> > +     u8 config =3D 0x00; // [6]:cfg_type, [4:1]:burst_len, [0]:bit16 o=
f address
> > +
> > +     if (data->pec_enable)
> > +             cmd |=3D 0x80;
> > +
> > +     while (remain_len > 0) {
> > +             if (remain_len > 16) {
> > +                     curr_len =3D 16;
> > +                     remain_len -=3D 16;
> > +             } else {
> > +                     curr_len =3D remain_len;
> > +                     remain_len =3D 0;
> > +             }
> > +
> > +             wbuf[0] =3D config | (curr_len - 1) << 1 |
> > +                       ((address >> 16) & 0x1);
> > +             wbuf[1] =3D (address >> 8) & 0xff;
> > +             wbuf[2] =3D address & 0xff;
> > +
> > +             for (tries =3D 0; tries < 3; tries++) {
> > +                     ret =3D i2c_smbus_write_block_data(client, (cmd |=
 0x2), 3,
> > +                                                      wbuf);
> > +                     if (ret)
> > +                             return ret;
> > +
> > +                     ret =3D i2c_smbus_read_block_data(client, (cmd | =
0x1),
> > +                                                     rbuf);
> > +                     if (ret =3D=3D curr_len)
> > +                             break;
> > +             }
>
> For code like this it would be really useful to see the datasheet.
> Those transfers are pretty odd. Does the chip really not support
> standard SMBus read/write commands ?
>
hmm.. actually the "pt5161l_read_block_data" and
"pt5161l_write_block_data" wrapper the smbus block write and read.

> > +             if (tries >=3D 3)
> > +                     return -ENODATA;
>
> Is this an appropriate error ? -ENODATA means that no data was available.
> Sure, after an error no data will be available, but that doesn't really r=
eflect
> the error. Why not return the error reported by the i2c subsystem ?
>
OK. Thanks for the advice.

> > +
> > +             memcpy(val, rbuf, curr_len);
> > +             val +=3D curr_len;
> > +             address +=3D curr_len;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +/*
> > + * Read multiple (up to eight) data bytes from micro SRAM over I2C
> > + */
> > +static int
> > +pt5161l_read_block_data_main_micro_indirect(struct pt5161l_data *data,
> > +                                         u32 address, u8 len, u8 *val)
> > +{
> > +     int ret, tries;
> > +     u8 buf[8];
> > +     u8 i, status;
> > +     u32 uind_offs =3D ARIES_MM_ASSIST_REG_ADDR_OFFSET;
> > +     u32 eeprom_base, eeprom_addr;
> > +
> > +     // No multi-byte indirect support here. Hence read a byte at a ti=
me
> > +     eeprom_base =3D address - AL_MAIN_SRAM_DMEM_OFFSET;
> > +     for (i =3D 0; i < len; i++) {
> > +             eeprom_addr =3D eeprom_base + i;
> > +             buf[0] =3D eeprom_addr & 0xff;
> > +             buf[1] =3D (eeprom_addr >> 8) & 0xff;
> > +             buf[2] =3D (eeprom_addr >> 16) & 0xff;
> > +             ret =3D pt5161l_write_block_data(data, uind_offs, 3, buf)=
;
> > +             if (ret)
> > +                     return ret;
> > +
> > +             buf[0] =3D AL_TG_RD_LOC_IND_SRAM;
> > +             ret =3D pt5161l_write_block_data(data, uind_offs + 4, 1, =
buf);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             status =3D 0xff;
> > +             for (tries =3D 0; tries < 255; tries++) {
> > +                     ret =3D pt5161l_read_block_data(data, uind_offs +=
 4, 1,
> > +                                                   &status);
> > +                     if (ret)
> > +                             return ret;
> > +
> > +                     if (status =3D=3D 0)
> > +                             break;
> > +             }
> > +             if (status !=3D 0)
> > +                     return -ETIMEDOUT;
> > +
> > +             ret =3D pt5161l_read_block_data(data, uind_offs + 3, 1, b=
uf);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             val[i] =3D buf[0];
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +/*
> > + * Check firmware load status
> > + */
> > +static int pt5161l_fw_load_check(struct pt5161l_data *data)
> > +{
> > +     int ret;
> > +     u8 buf[8];
> > +
> > +     ret =3D pt5161l_read_block_data(data, ARIES_CODE_LOAD_REG, 1, buf=
);
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (buf[0] < ARIES_LOAD_CODE) {
>
>
> What if it reports, say, 0x0f or 0x55 ?
>
I just followed the CSDK behavior, and will check if it should be
exactly equal to 0xe.

> > +             dev_dbg(&data->client->dev,
> > +                     "Code Load reg unexpected. Not all modules are lo=
aded %x\n",
> > +                     buf[0]);
> > +             data->code_load_okay =3D false;
> > +     } else {
> > +             data->code_load_okay =3D true;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +/*
> > + * Check main micro heartbeat
> > + */
> > +static int pt5161l_heartbeat_check(struct pt5161l_data *data)
> > +{
> > +     int ret, tries;
> > +     u8 buf[8];
> > +     u8 heartbeat;
> > +     bool hb_changed =3D false;
> > +
> > +     ret =3D pt5161l_read_block_data(data, ARIES_MM_HEARTBEAT_ADDR, 1,=
 buf);
> > +     if (ret)
> > +             return ret;
> > +
> > +     heartbeat =3D buf[0];
> > +     for (tries =3D 0; tries < 100; tries++) {
> > +             ret =3D pt5161l_read_block_data(data, ARIES_MM_HEARTBEAT_=
ADDR, 1,
> > +                                           buf);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             if (buf[0] !=3D heartbeat) {
> > +                     hb_changed =3D true;
> > +                     break;
> > +             }
>
> This makes the code really CPU speed dependent. Is this intentional ?
>
I just followed the behavior of CSDK. I think it should be more
related to the i2c clock, the maximum is only 400KHz.

> > +     }
> > +     data->mm_heartbeat_okay =3D hb_changed;
> > +
> > +     return 0;
> > +}
> > +
> > +/*
> > + * Check the status of firmware
> > + */
> > +static int pt5161l_fwsts_check(struct pt5161l_data *data)
> > +{
> > +     int ret;
> > +     u8 buf[8];
> > +     u8 major =3D 0, minor =3D 0;
> > +     u16 build =3D 0;
> > +
> > +     ret =3D pt5161l_fw_load_check(data);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D pt5161l_heartbeat_check(data);
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (data->code_load_okay && data->mm_heartbeat_okay) {
> > +             ret =3D pt5161l_read_block_data_main_micro_indirect(
> > +                     data,
> > +                     ARIES_MAIN_MICRO_FW_INFO + ARIES_MM_FW_VERSION_MA=
JOR, 1,
> > +                     &major);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             ret =3D pt5161l_read_block_data_main_micro_indirect(
> > +                     data,
> > +                     ARIES_MAIN_MICRO_FW_INFO + ARIES_MM_FW_VERSION_MI=
NOR, 1,
> > +                     &minor);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             ret =3D pt5161l_read_block_data_main_micro_indirect(
> > +                     data,
> > +                     ARIES_MAIN_MICRO_FW_INFO + ARIES_MM_FW_VERSION_BU=
ILD, 2,
> > +                     buf);
> > +             if (ret)
> > +                     return ret;
> > +             build =3D buf[1] << 8 | buf[0];
> > +     }
> > +     data->fw_ver.major =3D major;
> > +     data->fw_ver.minor =3D minor;
> > +     data->fw_ver.build =3D build;
> > +
> > +     return 0;
> > +}
> > +
> > +static int pt5161l_read(struct device *dev, enum hwmon_sensor_types ty=
pe,
> > +                     u32 attr, int channel, long *val)
> > +{
> > +     struct pt5161l_data *data =3D dev_get_drvdata(dev);
> > +     int ret =3D 0;
> > +     u8 buf[8];
> > +     long adc_code =3D 0;
> > +
> > +     switch (attr) {
> > +     case hwmon_temp_input:
> > +             mutex_lock(&data->lock);
> > +             ret =3D pt5161l_read_block_data(
> > +                     data, ARIES_CURRENT_AVG_TEMP_ADC_CSR, 4, buf);
> > +             mutex_unlock(&data->lock);
> > +             adc_code =3D buf[3] << 24 | buf[2] << 16 | buf[1] << 8 | =
buf[0];
> > +             break;
> > +     default:
> > +             return -EOPNOTSUPP;
> > +     }
> > +     if (ret) {
> > +             dev_dbg(dev, "Read adc_code failed %d\n", ret);
> > +             return ret;
> > +     }
>
> I fail to see why it would make sense to have the error check here,
> after the potentially uninitialized content of buf[] is converted.
>
Oh, I should move this to under the "case hwmon_temp_input:"

> > +     if (adc_code =3D=3D 0 || adc_code >=3D 0x3ff) {
> > +             dev_dbg(dev, "Invalid adc_code %lx\n", adc_code);
> > +             return -ENODATA;
>
> "No data available" is not an appropriate error.
>
Is "EIO" OK? Do you have a recommended return value?

> > +     }
> > +
> > +     *val =3D 110000 +
> > +            ((adc_code - (ARIES_TEMP_CAL_CODE_DEFAULT + 250)) * -320);
> > +
> > +     return 0;
> > +}
> > +
> > +static umode_t pt5161l_is_visible(const void *data,
> > +                               enum hwmon_sensor_types type, u32 attr,
> > +                               int channel)
> > +{
> > +     switch (attr) {
> > +     case hwmon_temp_input:
> > +             return 0444;
> > +     default:
> > +             break;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct hwmon_channel_info *pt5161l_info[] =3D {
> > +     HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT),
> > +     NULL
> > +};
> > +
> > +static const struct hwmon_ops pt5161l_hwmon_ops =3D {
> > +     .is_visible =3D pt5161l_is_visible,
> > +     .read =3D pt5161l_read,
> > +};
> > +
> > +static const struct hwmon_chip_info pt5161l_chip_info =3D {
> > +     .ops =3D &pt5161l_hwmon_ops,
> > +     .info =3D pt5161l_info,
> > +};
> > +
> > +static ssize_t pt5161l_debugfs_read_fw_ver(struct file *file, char __u=
ser *buf,
> > +                                        size_t count, loff_t *ppos)
> > +{
> > +     struct pt5161l_data *data =3D file->private_data;
> > +     int ret;
> > +     char ver[32];
> > +
> > +     mutex_lock(&data->lock);
> > +     ret =3D pt5161l_fwsts_check(data);
> > +     mutex_unlock(&data->lock);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D snprintf(ver, sizeof(ver), "%u.%u.%u\n", data->fw_ver.maj=
or,
> > +                    data->fw_ver.minor, data->fw_ver.build);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     return simple_read_from_buffer(buf, count, ppos, ver, ret + 1);
> > +}
> > +
> > +static const struct file_operations pt5161l_debugfs_ops_fw_ver =3D {
> > +     .read =3D pt5161l_debugfs_read_fw_ver,
> > +     .open =3D simple_open,
> > +};
> > +
> > +static ssize_t pt5161l_debugfs_read_fw_load_sts(struct file *file,
> > +                                             char __user *buf, size_t =
count,
> > +                                             loff_t *ppos)
> > +{
> > +     struct pt5161l_data *data =3D file->private_data;
> > +     int ret;
> > +     bool status =3D false;
> > +     char health[16];
> > +
> > +     mutex_lock(&data->lock);
> > +     ret =3D pt5161l_fw_load_check(data);
> > +     mutex_unlock(&data->lock);
> > +     if (ret =3D=3D 0)
> > +             status =3D data->code_load_okay;
> > +
> > +     ret =3D snprintf(health, sizeof(health), "%s\n",
> > +                    status ? "normal" : "abnormal");
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     return simple_read_from_buffer(buf, count, ppos, health, ret + 1)=
;
> > +}
> > +
> > +static const struct file_operations pt5161l_debugfs_ops_fw_load_sts =
=3D {
> > +     .read =3D pt5161l_debugfs_read_fw_load_sts,
> > +     .open =3D simple_open,
> > +};
> > +
> > +static ssize_t pt5161l_debugfs_read_hb_sts(struct file *file, char __u=
ser *buf,
> > +                                        size_t count, loff_t *ppos)
> > +{
> > +     struct pt5161l_data *data =3D file->private_data;
> > +     int ret;
> > +     bool status =3D false;
> > +     char health[16];
> > +
> > +     mutex_lock(&data->lock);
> > +     ret =3D pt5161l_heartbeat_check(data);
> > +     mutex_unlock(&data->lock);
> > +     if (ret =3D=3D 0)
> > +             status =3D data->mm_heartbeat_okay;
> > +
> > +     ret =3D snprintf(health, sizeof(health), "%s\n",
> > +                    status ? "normal" : "abnormal");
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     return simple_read_from_buffer(buf, count, ppos, health, ret + 1)=
;
> > +}
> > +
> > +static const struct file_operations pt5161l_debugfs_ops_hb_sts =3D {
> > +     .read =3D pt5161l_debugfs_read_hb_sts,
> > +     .open =3D simple_open,
> > +};
> > +
> > +static int pt5161l_init_debugfs(struct pt5161l_data *data)
> > +{
> > +     data->debugfs =3D debugfs_create_dir(dev_name(&data->client->dev)=
,
> > +                                        pt5161l_debugfs_dir);
> > +
> > +     debugfs_create_file("fw_ver", 0444, data->debugfs, data,
> > +                         &pt5161l_debugfs_ops_fw_ver);
> > +
> > +     debugfs_create_file("fw_load_status", 0444, data->debugfs, data,
> > +                         &pt5161l_debugfs_ops_fw_load_sts);
> > +
> > +     debugfs_create_file("heartbeat_status", 0444, data->debugfs, data=
,
> > +                         &pt5161l_debugfs_ops_hb_sts);
> > +
> > +     return 0;
> > +}
> > +
> > +static int pt5161l_probe(struct i2c_client *client)
> > +{
> > +     struct device *dev =3D &client->dev;
> > +     struct device *hwmon_dev;
> > +     struct pt5161l_data *data;
> > +
> > +     data =3D devm_kzalloc(dev, sizeof(struct pt5161l_data), GFP_KERNE=
L);
> > +     if (!data)
> > +             return -ENOMEM;
> > +
> > +     data->client =3D client;
> > +     mutex_init(&data->lock);
> > +     dev_set_drvdata(dev, data);
> > +
> > +     hwmon_dev =3D devm_hwmon_device_register_with_info(
> > +             dev, client->name, data, &pt5161l_chip_info, NULL);
> > +
> > +     pt5161l_init_debugfs(data);
>
> This should still result in crashes if a device is instantiated (for exam=
ple
> with new_device) and then removed (for example with delete_device).
>
I don=E2=80=99t know much about this. I=E2=80=99ve tested it and it seems t=
o be fine.
Each device has its own debugfs files, and the debugfs files will be
removed after the device is deleted.

> > +
> > +     return PTR_ERR_OR_ZERO(hwmon_dev);
> > +}
> > +
> > +static void pt5161l_remove(struct i2c_client *client)
> > +{
> > +     struct pt5161l_data *data =3D i2c_get_clientdata(client);
> > +
> > +     debugfs_remove_recursive(data->debugfs);
> > +}
> > +
> > +static const struct of_device_id __maybe_unused pt5161l_of_match[] =3D=
 {
> > +     { .compatible =3D "asteralabs,pt5161l" },
> > +     {},
> > +};
> > +MODULE_DEVICE_TABLE(of, pt5161l_of_match);
> > +
> > +static const struct acpi_device_id pt5161l_acpi_match[] =3D {
>
> Guess the __maybe_unused applies here as well.
>
Yes. I will add this. Thanks.

> > +     { "PT5161L", 0 },
>
> Is that an official ACPI ID ? It doesn't look like one to me. ACPI IDs
> are supposed to be 8 characters long. I don't find a vendor ID for Astera=
,
> and it seems unlikely that it is "PT51". The model number is supposed
> to be a 4-digit hex string, and "61L" is neither. If it is supposed
> to be a PNP ID, that doesn't look correct either. "PT5" is not a valid
> PNP ID, and "161L" is not a valid PNP product ID.
>
I'm not entirely clear on the issue. I just refer to the "I2C serial
bus support" section of this:
https://docs.kernel.org/firmware-guide/acpi/enumeration.html

> > +     {},
> > +};
> > +MODULE_DEVICE_TABLE(acpi, pt5161l_acpi_match);
> > +
> > +static const struct i2c_device_id pt5161l_id[] =3D {
> > +     { "pt5161l", 0 },
> > +     {}
> > +};
> > +MODULE_DEVICE_TABLE(i2c, pt5161l_id);
> > +
> > +static struct i2c_driver pt5161l_driver =3D {
> > +     .class =3D I2C_CLASS_HWMON,
> > +     .driver =3D {
> > +             .name =3D "pt5161l",
> > +             .of_match_table =3D of_match_ptr(pt5161l_of_match),
> > +             .acpi_match_table =3D ACPI_PTR(pt5161l_acpi_match),
> > +     },
> > +     .probe =3D pt5161l_probe,
> > +     .remove =3D pt5161l_remove,
> > +     .id_table =3D pt5161l_id,
> > +};
> > +
> > +static int __init pt5161l_init(void)
> > +{
> > +     pt5161l_debugfs_dir =3D debugfs_create_dir("pt5161l", NULL);
> > +     return i2c_add_driver(&pt5161l_driver);
> > +}
> > +
> > +static void __exit pt5161l_exit(void)
> > +{
> > +     debugfs_remove_recursive(pt5161l_debugfs_dir);
> > +     i2c_del_driver(&pt5161l_driver);
> > +}
> > +
> > +module_init(pt5161l_init);
> > +module_exit(pt5161l_exit);
> > +
> > +MODULE_AUTHOR("Cosmo Chou <cosmo.chou@quantatw.com>");
> > +MODULE_DESCRIPTION("Hwmon driver for Astera Labs Aries PCIe retimer");
> > +MODULE_LICENSE("GPL");
>

