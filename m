Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8B180B33A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 09:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234352AbjLIICZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 03:02:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjLIICW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 03:02:22 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C4210DF;
        Sat,  9 Dec 2023 00:02:26 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40c2a444311so27408615e9.2;
        Sat, 09 Dec 2023 00:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702108944; x=1702713744; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PEaZtybaujus+RINgPJIuD2iQUOhb2y3WyOewsDk/UY=;
        b=XhbDcCxUMq/5uzslLY5Sp9eXt2Du2h3x7i2o1AAjIuXPoUqUx6tdoTBlQhMUWBpvRK
         f03VPnG6JGqCdcZittljjnfXz+Qlw3Rbdt0xPkPfgeh285MiTTnYMZq5bFdjGStP47nY
         8YAifRLIiaLcvyBkQYX33duSQ1MOUB8T8lP31wXf6Yb5PIDux3Bt/MXfTmVbCgkEVmHC
         j/n4f4H/wl5Fo5o/uKHPEWf7DV+6HirjP7VvSxkQTXNoz3oSpAbhiG7ooNGseM6CCmu7
         YrgKSb3kdCZO5FI0hNosFHu+JwKuebQl/2yFnTOk3cuL3rtKibyi6rlE+cw7pdwesD5B
         bZxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702108944; x=1702713744;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PEaZtybaujus+RINgPJIuD2iQUOhb2y3WyOewsDk/UY=;
        b=CyBNT10zCVg6yWv1E98M/VgZvNscNO7kPrpuI9SgC7n0/pziv5HX3nOLTHOaMrlQV9
         elsB0OuThl3VG1wK4NFgSbhqVG+OTnoSXokdEVicBMbsR2rclIkQLcehVOWdBE9V+6Ta
         ClNzFgg4X6KsxYJsMnEuOihb+oj3MwGQQNNYTlVrBIjqvO40DBmvnwx6krd3VifQOTcN
         oqQGv9UL4+n5pQzxvcqn2BqXSSYpOgAr1E1JTfGwVtVW9DZdJC6xtjG/VWgPZZnS0l8t
         DFOZyZScQGLk5685xtcDo/SWgjfORNXkJALXCOCXWN4o+QcJImVX2GHWvOj8Cu/hs3NW
         aRBQ==
X-Gm-Message-State: AOJu0YzpBNecPppg361si/cWSukijy1MKf4PCCeU5By4aisdoIzoQw4H
        d0JwLOsgPgnzbMX8Hl7hgUOpFOmAspWHJXir8e0=
X-Google-Smtp-Source: AGHT+IHQmSzSZhfa3MM6ymCwWB84qIhrfaTR/XVMOWOwYT+IjEDzOzKMLCFLQ0GllpZwCnhIHEH+hOxQpSMr8rJzdkE=
X-Received: by 2002:a05:600c:3b8a:b0:406:4573:81d2 with SMTP id
 n10-20020a05600c3b8a00b00406457381d2mr308188wms.39.1702108943976; Sat, 09 Dec
 2023 00:02:23 -0800 (PST)
MIME-Version: 1.0
References: <20231205074723.3546295-1-chou.cosmo@gmail.com>
 <20231205074723.3546295-4-chou.cosmo@gmail.com> <a31f5e97-968a-46ae-a378-207936f1df23@roeck-us.net>
In-Reply-To: <a31f5e97-968a-46ae-a378-207936f1df23@roeck-us.net>
From:   Cosmo Chou <chou.cosmo@gmail.com>
Date:   Sat, 9 Dec 2023 16:02:12 +0800
Message-ID: <CAOeEDyt+4GrdouY1rr7TYgwOkhg=JWz63c5WppDb55iL3GApHA@mail.gmail.com>
Subject: Re: [PATCH 3/3] hwmon: Add driver for Astera Labs PT516XX retimer
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        corbet@lwn.net, heiko@sntech.de, jernej.skrabec@gmail.com,
        macromorgan@hotmail.com, linus.walleij@linaro.org,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        cosmo.chou@quantatw.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/2023 07:55:50 -0800 Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 12/4/23 23:47, Cosmo Chou wrote:
> > This driver implements support for temperature monitoring of Astera Labs
> > PT5161L series PCIe retimer chips.
> >
> > This driver implementation originates from the CSDK available at
> > Link: https://github.com/facebook/openbmc/tree/helium/common/recipes-lib/retimer-v2.14
> > The communication protocol utilized is based on the I2C/SMBus standard.
> >
> > Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>
> > ---
> >   Documentation/hwmon/index.rst   |   1 +
> >   Documentation/hwmon/pt516xx.rst |  48 +++
> >   MAINTAINERS                     |   8 +
> >   drivers/hwmon/Kconfig           |  10 +
> >   drivers/hwmon/Makefile          |   1 +
> >   drivers/hwmon/pt516xx.c         | 648 ++++++++++++++++++++++++++++++++
> >   6 files changed, 716 insertions(+)
> >   create mode 100644 Documentation/hwmon/pt516xx.rst
> >   create mode 100644 drivers/hwmon/pt516xx.c
> >
> > diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> > index 72f4e6065bae..2c4df18db663 100644
> > --- a/Documentation/hwmon/index.rst
> > +++ b/Documentation/hwmon/index.rst
> > @@ -181,6 +181,7 @@ Hardware Monitoring Kernel Drivers
> >      pmbus
> >      powerz
> >      powr1220
> > +   pt516xx
> >      pxe1610
> >      pwm-fan
> >      q54sj108a2
> > diff --git a/Documentation/hwmon/pt516xx.rst b/Documentation/hwmon/pt516xx.rst
> > new file mode 100644
> > index 000000000000..945194f9a804
> > --- /dev/null
> > +++ b/Documentation/hwmon/pt516xx.rst
> > @@ -0,0 +1,48 @@
> > +.. SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +Kernel driver pt516xx
> > +====================
> > +
> > +Supported chips:
> > +
> > +  * Astera Labs PT5161L
> > +
> > +    Prefix: 'pt5161l'
> > +
>
> This should be the driver name and be used for function/variable prefixes.
> No idea where XX comes into play. The driver for sure won't support
> PT516[0-9][A-Z], and should not suggest that it does.
>
OK, I will correct it to pt5161l.

> > +    Addresses: I2C 0x24
> > +
> > +    Datasheet: http://www.asteralabs.com/wp-content/uploads/2021/03/Astera_Labs_PT5161L_Product_Brief.pdf
> > +
> > +Authors: Cosmo Chou <cosmo.chou@quantatw.com>
> > +
> > +Description
> > +-----------
> > +
> > +This driver implements support for temperature monitoring of Astera Labs
> > +PT5161L series PCIe retimer chips.
> > +
> > +This driver implementation originates from the CSDK available at
> > +https://github.com/facebook/openbmc/tree/helium/common/recipes-lib/retimer-v2.14
> > +The communication protocol utilized is based on the I2C/SMBus standard.
> > +
>
> That strongly suggests that the code has a copyright and license associated
> with it. None of it is mentioned here.
>
It looks like the base code (the link above) declared GPL2.0+ and Apache2.0.
There is already a declaration in the pt516xx.c: (line 1)
// SPDX-License-Identifier: GPL-2.0-or-later

Could you give some advice about adding the copyright and license? Thanks.

> > +For more detailed information and specific implementation details, it is
> > +recommended to refer to the CSDK source code available at the provided GitHub
> > +link.
> > +
>
> Linux kernel drivers should be self contained. It is fine to reference documentation,
> but not out-of-tree source code.
>
OK. I will remove this paragraph ("For more detailed information...")

> > +Sysfs entries
> > +----------------
> > +
> > +================ ==============================================
> > +temp1_input      Measured temperature (in millidegrees Celsius)
> > +================ ==============================================
> > +
> > +Debugfs entries
> > +----------------
> > +
> > +================ ====================================
> > +fw_ver           Firmware version of the retimer
> > +health           Health status (8 bits)
> > +                 [0]: Heartbeat Okay (1'b1: OK)
> > +                 [1]: Firmware loaded Okay (1'b1: OK)
>
> This is not from the chip but arbitrarily assigned. It should be
> reported in separate debugfs files (or all in a single file with
> multiple lines and human readable information).
>
OK. I will separate it to "fw_load_status" and "heartbeat_status".

> > +                 [7:2]: Reserved
> > +================ ====================================
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 788be9ab5b73..492002ffd12c 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -17482,6 +17482,14 @@ F:   fs/pstore/
> >   F:  include/linux/pstore*
> >   K:  \b(pstore|ramoops)
> >
> > +PT516XX HARDWARE MONITOR DRIVER
> > +M:   Cosmo Chou <cosmo.chou@quantatw.com>
> > +L:   linux-hwmon@vger.kernel.org
> > +S:   Maintained
> > +F:   Documentation/devicetree/bindings/hwmon/asteralabs,pt516xx.yaml
> > +F:   Documentation/hwmon/pt516xx.rst
> > +F:   drivers/hwmon/pt516xx.c
> > +
> >   PTP HARDWARE CLOCK SUPPORT
> >   M:  Richard Cochran <richardcochran@gmail.com>
> >   L:  netdev@vger.kernel.org
> > diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> > index cf27523eed5a..3965bec7774a 100644
> > --- a/drivers/hwmon/Kconfig
> > +++ b/drivers/hwmon/Kconfig
> > @@ -1703,6 +1703,16 @@ source "drivers/hwmon/peci/Kconfig"
> >
> >   source "drivers/hwmon/pmbus/Kconfig"
> >
> > +config SENSORS_PT516XX
> > +     tristate "Astera Labs PT516XX PCIe retimer hardware monitoring"
> > +     depends on I2C
> > +     help
> > +       If you say yes here you get support for temperature monitoring
> > +       on the Astera Labs PT516XX PCIe retimer.
> > +
> > +       This driver can also be built as a module. If so, the module
> > +       will be called pt516xx.
> > +
> >   config SENSORS_PWM_FAN
> >       tristate "PWM fan"
> >       depends on (PWM && OF) || COMPILE_TEST
> > diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> > index e84bd9685b5c..1942064cd4e9 100644
> > --- a/drivers/hwmon/Makefile
> > +++ b/drivers/hwmon/Makefile
> > @@ -179,6 +179,7 @@ obj-$(CONFIG_SENSORS_PC87427)     += pc87427.o
> >   obj-$(CONFIG_SENSORS_PCF8591)       += pcf8591.o
> >   obj-$(CONFIG_SENSORS_POWERZ)        += powerz.o
> >   obj-$(CONFIG_SENSORS_POWR1220)  += powr1220.o
> > +obj-$(CONFIG_SENSORS_PT516XX)        += pt516xx.o
> >   obj-$(CONFIG_SENSORS_PWM_FAN)       += pwm-fan.o
> >   obj-$(CONFIG_SENSORS_RASPBERRYPI_HWMON)     += raspberrypi-hwmon.o
> >   obj-$(CONFIG_SENSORS_SBTSI) += sbtsi_temp.o
> > diff --git a/drivers/hwmon/pt516xx.c b/drivers/hwmon/pt516xx.c
> > new file mode 100644
> > index 000000000000..824798559fe1
> > --- /dev/null
> > +++ b/drivers/hwmon/pt516xx.c
> > @@ -0,0 +1,648 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +#include <linux/debugfs.h>
> > +#include <linux/delay.h>
> > +#include <linux/err.h>
> > +#include <linux/i2c.h>
> > +#include <linux/init.h>
> > +#include <linux/hwmon.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/of_device.h>
> > +
> > +/** Main-micro-assisted access command codes */
>
> This is not a proper kernel documentation. Either case, use C style comments
> or C++ style comments, but not both.
>
Got it. I will correct the style of comments.

> > +// Wide register reads
> > +#define ARIES_MM_RD_WIDE_REG_2B 0x1d
> > +#define ARIES_MM_RD_WIDE_REG_3B 0x1e
> > +#define ARIES_MM_RD_WIDE_REG_4B 0x1f
> > +#define ARIES_MM_RD_WIDE_REG_5B 0x20
> > +// Wide register writes
> > +#define ARIES_MM_WR_WIDE_REG_2B 0x21
> > +#define ARIES_MM_WR_WIDE_REG_3B 0x22
> > +#define ARIES_MM_WR_WIDE_REG_4B 0x23
> > +#define ARIES_MM_WR_WIDE_REG_5B 0x24
>
> Please use
>
> #define<space>NAME<tab>value
>
Got it.

> throughout, please. Also, at least ARIES_MM_WR_WIDE_REG_ defines are
> not used. Please refrain from declaring unused defines.
>
Oops... I will remove the unused code.

> And where does ARIES come from ?
>
It's the SoC name of the PCIe retimer.

> > +
> > +/** Temperature measurement constants */
> > +// Aries current average temp ADC code CSR
> > +#define ARIES_CURRENT_AVG_TEMP_ADC_CSR 0x42c
> > +
> > +// Main Micro Heartbeat reg
> > +#define ARIES_MM_HEARTBEAT_ADDR 0x923
> > +
> > +/** Main SRAM */
> > +// AL Main SRAM DMEM offset (A0)
> > +#define AL_MAIN_SRAM_DMEM_OFFSET (64 * 1024)
> > +// SRAM read command
> > +#define AL_TG_RD_LOC_IND_SRAM 0x16
> > +
> > +/** Micros */
> > +// Offset for main micro FW info
> > +#define ARIES_MAIN_MICRO_FW_INFO (96 * 1024 - 128)
> > +
> > +/** Path Micro Members */
> > +// FW Info (Major) offset location in struct
> > +#define ARIES_MM_FW_VERSION_MAJOR 0
> > +// FW Info (Minor) offset location in struct
> > +#define ARIES_MM_FW_VERSION_MINOR 1
> > +// FW Info (Build no.) offset location in struct
> > +#define ARIES_MM_FW_VERSION_BUILD 2
> > +
> > +/** Offsets for MM assisted accesses */
> > +// Legacy Address and Data registers (using wide registers)
> > +// Reg offset to specify Address for MM assisted accesses
> > +#define ARIES_MM_ASSIST_REG_ADDR_OFFSET 0xd99
> > +// Reg offset to specify Command
> > +#define ARIES_MM_ASSIST_CMD_OFFSET 0xd9d
> > +
> > +// New Address and Data registers (not using wide registers)
> > +// Reg offset to MM SPARE 0 used specify Address[7:0]
> > +#define ARIES_MM_ASSIST_SPARE_0_OFFSET 0xd9f
> > +// Reg offset to MM SPARE 3 used specify Data Byte 0
> > +#define ARIES_MM_ASSIST_SPARE_3_OFFSET 0xda2
> > +
> > +/** Misc block offsets */
> > +// Device Load check register
> > +#define ARIES_CODE_LOAD_REG 0x605
> > +
> > +/** Value indicating FW was loaded properly */
> > +#define ARIES_LOAD_CODE 0xe
> > +
> > +/** EEPROM parameters */
> > +// Time delay between checking MM status of EEPROM write (microseconds)
> > +#define ARIES_MM_STATUS_TIME 5000
> > +
> > +#define ARIES_TEMP_CAL_CODE_DEFAULT 84
> > +
> > +/* Struct defining FW version loaded on an Aries device */
> > +struct pt516xx_fw_ver {
> > +     u8 major; // FW version major release value
> > +     u8 minor; // FW version minor release value
> > +     u16 build; // FW version build release value
> > +};
> > +
> > +/* Each client has this additional data */
> > +struct pt516xx_data {
> > +     struct i2c_client *client;
> > +     struct dentry *debugfs;
> > +     struct pt516xx_fw_ver fw_ver;
> > +     struct mutex lock;
> > +     bool init_done;
> > +     bool pec_enable; // Enable PEC
> > +     bool code_load_okay; // indicate if code load reg value is expected
> > +     bool mm_heartbeat_okay; // indicate if Main Micro heartbeat is good
> > +     bool mm_wide_reg_valid; // MM assisted Wide Register access
> > +     u8 temp_cal_code_avg;
> > +};
> > +
> > +static struct dentry *pt516xx_debugfs_dir;
> > +
> > +/*
> > + * Write multiple data bytes to Aries over I2C
> > + */
> > +static int pt516xx_write_block_data(struct pt516xx_data *data, u32 address,
> > +                                 u8 len, u8 *val)
> > +{
> > +     struct i2c_client *client = data->client;
> > +     int ret;
> > +     u8 remain_len = len;
> > +     u8 xfer_len, curr_len;
> > +     u8 buf[16];
> > +     u8 cmd = 0x0F; // [7]:pec_en, [6:5]:rsvd, [4:2]:func, [1]:start, [0]:end
> > +     u8 config = 0x40; // [6]:cfg_type, [4:1]:burst_len, [0]:bit16 of address
> > +
> > +     if (data->pec_enable)
> > +             cmd |= 0x80;
> > +
> > +     // If byte count is greater than 4, perform multiple iterations
>
> Most of those comments are pointless. This is obvious from the code.
>
OK. I will reduce the pointless comments.

> > +     while (remain_len > 0) {
> > +             if (remain_len > 4) {
> > +                     curr_len = 4;
> > +                     remain_len -= 4;
> > +             } else {
> > +                     curr_len = remain_len;
> > +                     remain_len = 0;
> > +             }
> > +
> > +             buf[0] = config | (curr_len - 1) << 1 | ((address >> 16) & 0x1);
> > +             buf[1] = (address >> 8) & 0xff;
> > +             buf[2] = address & 0xff;
> > +             memcpy(&buf[3], val, curr_len);
> > +
> > +             xfer_len = 3 + curr_len;
> > +             ret = i2c_smbus_write_block_data(client, cmd, xfer_len, buf);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             val += curr_len;
> > +             address += curr_len;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +/*
> > + * Read multiple data bytes from Aries over I2C
> > + */
> > +static int pt516xx_read_block_data(struct pt516xx_data *data, u32 address,
> > +                                u8 len, u8 *val)
> > +{
> > +     struct i2c_client *client = data->client;
> > +     int ret, tries;
> > +     u8 remain_len = len;
> > +     u8 curr_len;
> > +     u8 wbuf[16], rbuf[24];
> > +     u8 cmd = 0x08; // [7]:pec_en, [6:5]:rsvd, [4:2]:func, [1]:start, [0]:end
> > +     u8 config = 0x00; // [6]:cfg_type, [4:1]:burst_len, [0]:bit16 of address
> > +
> > +     if (data->pec_enable)
> > +             cmd |= 0x80;
> > +
> > +     // If byte count is greater than 16, perform multiple iterations
> > +     while (remain_len > 0) {
> > +             if (remain_len > 16) {
> > +                     curr_len = 16;
> > +                     remain_len -= 16;
> > +             } else {
> > +                     curr_len = remain_len;
> > +                     remain_len = 0;
> > +             }
> > +
> > +             wbuf[0] = config | (curr_len - 1) << 1 |
> > +                       ((address >> 16) & 0x1);
> > +             wbuf[1] = (address >> 8) & 0xff;
> > +             wbuf[2] = address & 0xff;
> > +
> > +             // Perform read operation
> > +             for (tries = 0; tries < 3; tries++) {
> > +                     ret = i2c_smbus_write_block_data(client, (cmd | 0x2), 3,
> > +                                                      wbuf);
> > +                     if (ret)
> > +                             return ret;
> > +
> > +                     ret = i2c_smbus_read_block_data(client, (cmd | 0x1),
> > +                                                     rbuf);
> > +                     if (ret == curr_len)
> > +                             break;
> > +             }
> > +             if (tries >= 3)
> > +                     return -ENODATA;
> > +
> > +             memcpy(val, rbuf, curr_len);
> > +             val += curr_len;
> > +             address += curr_len;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int pt516xx_read_wide_reg(struct pt516xx_data *data, u32 address,
> > +                              u8 width, u8 *val)
> > +{
> > +     int ret, tries;
> > +     u8 buf[8];
> > +     u8 status;
> > +
> > +     if (data->mm_wide_reg_valid) {
> > +             // Write address (3 bytes)
> > +             buf[0] = address & 0xff;
> > +             buf[1] = (address >> 8) & 0xff;
> > +             buf[2] = (address >> 16) & 0x1;
> > +             ret = pt516xx_write_block_data(
> > +                     data, ARIES_MM_ASSIST_SPARE_0_OFFSET, 3, buf);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             // Set command based on width
> > +             switch (width) {
> > +             case 2:
> > +                     buf[0] = ARIES_MM_RD_WIDE_REG_2B;
> > +                     break;
> > +             case 3:
> > +                     buf[0] = ARIES_MM_RD_WIDE_REG_3B;
> > +                     break;
> > +             case 4:
> > +                     buf[0] = ARIES_MM_RD_WIDE_REG_4B;
> > +                     break;
> > +             case 5:
> > +                     buf[0] = ARIES_MM_RD_WIDE_REG_5B;
> > +                     break;
> > +             default:
> > +                     return -EINVAL;
> > +             }
> > +             ret = pt516xx_write_block_data(data, ARIES_MM_ASSIST_CMD_OFFSET,
> > +                                            1, buf);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             // Check access status
> > +             status = 0xff;
> > +             for (tries = 0; tries < 100; tries++) {
> > +                     ret = pt516xx_read_block_data(
> > +                             data, ARIES_MM_ASSIST_CMD_OFFSET, 1, &status);
> > +                     if (ret)
> > +                             return ret;
> > +
> > +                     if (status == 0)
> > +                             break;
> > +
> > +                     usleep_range(ARIES_MM_STATUS_TIME,
> > +                                  ARIES_MM_STATUS_TIME + 1000);
> > +             }
> > +             if (status != 0)
> > +                     return -ETIMEDOUT;
> > +
> > +             // Read N bytes of data based on width
> > +             ret = pt516xx_read_block_data(
> > +                     data, ARIES_MM_ASSIST_SPARE_3_OFFSET, width, val);
> > +             if (ret)
> > +                     return ret;
> > +     } else {
> > +             return pt516xx_read_block_data(data, address, width, val);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +/*
> > + * Read multiple (up to eight) data bytes from micro SRAM over I2C
> > + */
> > +static int
> > +pt516xx_read_block_data_main_micro_indirect(struct pt516xx_data *data,
> > +                                         u32 address, u8 len, u8 *val)
> > +{
> > +     int ret, tries;
> > +     u8 buf[8];
> > +     u8 i, status;
> > +     u32 uind_offs = ARIES_MM_ASSIST_REG_ADDR_OFFSET;
> > +     u32 eeprom_base, eeprom_addr;
> > +
> > +     // No multi-byte indirect support here. Hence read a byte at a time
> > +     eeprom_base = address - AL_MAIN_SRAM_DMEM_OFFSET;
> > +     for (i = 0; i < len; i++) {
> > +             // Write eeprom addr
> > +             eeprom_addr = eeprom_base + i;
> > +             buf[0] = eeprom_addr & 0xff;
> > +             buf[1] = (eeprom_addr >> 8) & 0xff;
> > +             buf[2] = (eeprom_addr >> 16) & 0xff;
> > +             ret = pt516xx_write_block_data(data, uind_offs, 3, buf);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             // Write eeprom cmd
> > +             buf[0] = AL_TG_RD_LOC_IND_SRAM;
> > +             ret = pt516xx_write_block_data(data, uind_offs + 4, 1, buf);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             // Test successful access
> > +             status = 0xff;
> > +             for (tries = 0; tries < 255; tries++) {
> > +                     ret = pt516xx_read_block_data(data, uind_offs + 4, 1,
> > +                                                   &status);
> > +                     if (ret)
> > +                             return ret;
> > +
> > +                     if (status == 0)
> > +                             break;
> > +             }
> > +             if (status != 0)
> > +                     return -ETIMEDOUT;
> > +
> > +             ret = pt516xx_read_block_data(data, uind_offs + 3, 1, buf);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             val[i] = buf[0];
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +/*
> > + * Check the status of firmware
> > + */
> > +static int pt516xx_fwsts_check(struct pt516xx_data *data)
> > +{
> > +     int ret, tries;
> > +     u8 buf[8];
> > +     u8 heartbeat, major = 0, minor = 0;
> > +     u16 build = 0;
> > +     bool hb_changed = false;
> > +
> > +     // Read Code Load reg
> > +     ret = pt516xx_read_block_data(data, ARIES_CODE_LOAD_REG, 1, buf);
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (buf[0] < ARIES_LOAD_CODE) {
> > +             dev_warn(
> > +                     &data->client->dev,
> > +                     "Code Load reg unexpected. Not all modules are loaded %x\n",
> > +                     buf[0]);
> > +             data->code_load_okay = false;
> > +     } else {
> > +             data->code_load_okay = true;
> > +     }
> > +
> > +     // Check Main Micro heartbeat
> > +     // If heartbeat value does not change for 100 tries, no MM heartbeat
> > +     // Else heartbeat present even if one value changes
> > +     ret = pt516xx_read_block_data(data, ARIES_MM_HEARTBEAT_ADDR, 1, buf);
> > +     if (ret)
> > +             return ret;
> > +
> > +     heartbeat = buf[0];
> > +     for (tries = 0; tries < 100; tries++) {
> > +             ret = pt516xx_read_block_data(data, ARIES_MM_HEARTBEAT_ADDR, 1,
> > +                                           buf);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             if (buf[0] != heartbeat) {
> > +                     hb_changed = true;
> > +                     break;
> > +             }
> > +     }
> > +     data->mm_heartbeat_okay = hb_changed;
> > +
> > +     // Read FW version
> > +     // If heartbeat not there, set default FW values to 0.0.0
> > +     // and return success
> > +     if (data->mm_heartbeat_okay) {
> > +             // Get FW version (major)
> > +             ret = pt516xx_read_block_data_main_micro_indirect(
> > +                     data,
> > +                     ARIES_MAIN_MICRO_FW_INFO + ARIES_MM_FW_VERSION_MAJOR, 1,
> > +                     &major);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             // Get FW version (minor)
> > +             ret = pt516xx_read_block_data_main_micro_indirect(
> > +                     data,
> > +                     ARIES_MAIN_MICRO_FW_INFO + ARIES_MM_FW_VERSION_MINOR, 1,
> > +                     &minor);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             // Get FW version (build)
> > +             ret = pt516xx_read_block_data_main_micro_indirect(
> > +                     data,
> > +                     ARIES_MAIN_MICRO_FW_INFO + ARIES_MM_FW_VERSION_BUILD, 2,
> > +                     (u8 *)&build);
> > +             if (ret)
> > +                     return ret;
> > +     } else {
> > +             dev_warn(&data->client->dev, "No Main Micro Heartbeat\n");
>
> This and other messages above would create a lot of noise if persistent
> since the function is called repeatedly.
>
OK. I will reduce the debug messages or change to use dev_dbg().

> > +     }
> > +     data->fw_ver.major = major;
> > +     data->fw_ver.minor = minor;
> > +     data->fw_ver.build = build;
> > +
> > +     return 0;
> > +}
> > +
> > +static int pt516xx_fw_is_at_least(struct pt516xx_data *data, u8 major, u8 minor,
> > +                               u16 build)
> > +{
> > +     u32 ver = major << 24 | minor << 16 | build;
> > +     u32 curr_ver = data->fw_ver.major << 24 | data->fw_ver.minor << 16 |
> > +                    data->fw_ver.build;
> > +
> > +     if (curr_ver >= ver)
> > +             return true;
> > +
> > +     return false;
> > +}
> > +
> > +static int pt516xx_init_dev(struct pt516xx_data *data)
> > +{
> > +     int ret;
> > +
> > +     mutex_lock(&data->lock);
> > +     ret = pt516xx_fwsts_check(data);
> > +     mutex_unlock(&data->lock);
> > +     if (ret)
> > +             return ret;
> > +
> > +     dev_info(&data->client->dev, "fw_ver: %u.%u.%u\n", data->fw_ver.major,
> > +              data->fw_ver.minor, data->fw_ver.build);
> > +
>
> Please no such noise
>
OK.

> > +     if (pt516xx_fw_is_at_least(data, 2, 2, 0))
> > +             data->mm_wide_reg_valid = true;
> > +
> > +     data->temp_cal_code_avg = ARIES_TEMP_CAL_CODE_DEFAULT;
>
> What is the point of this ? temp_cal_code_avg will never be anything else.
>
I will change to directly use ARIES_TEMP_CAL_CODE_DEFAULT when calculating.

> > +     data->init_done = true;
> > +
> > +     return 0;
> > +}
> > +
> > +static int pt516xx_read(struct device *dev, enum hwmon_sensor_types type,
> > +                     u32 attr, int channel, long *val)
> > +{
> > +     struct pt516xx_data *data = dev_get_drvdata(dev);
> > +     int ret = 0;
> > +     long adc_code = 0;
> > +
>
> This assumes a specific endianness which isn't given. I am quite sure that the
> code as written won't work in a big endian system. Also, "long" may be 4 or 8 byte
> depending on the CPU architecture.
>
Oops, I will revise it to be compatible with the big endian system.
Using long is just to match the prototype of read(): "long *val".

> > +     if (!data->init_done) {
> > +             ret = pt516xx_init_dev(data);
> > +             if (ret) {
> > +                     dev_err(dev, "pt516xx_init_dev failed %d\n", ret);
> > +                     return ret;
> > +             }
> > +     }
>
> This is really the wrong place for this code. It should be checked and initialized
> in the probe function, and probe should bail out if it fails.
>
> Also, the only reason to call pt516xx_init_dev() seems to be to determine
> if "wide reegister access" is supported. If it isn't, pt516xx_read_block_data()
> is used. Why not call pt516xx_read_block_data() below directly and not bother
> with wide register access ?
>
Previously I followed CSDK using wide_reg to access new FW. Also tried
old FW, but old FW
only support read_block_data. After further testing with the new FW,
it also does support
read_block_data. So I will revise it to use read_block_data directly
for temperature. Thanks.

> > +
> > +     switch (attr) {
> > +     case hwmon_temp_input:
> > +             mutex_lock(&data->lock);
> > +             ret = pt516xx_read_wide_reg(data,
> > +                                         ARIES_CURRENT_AVG_TEMP_ADC_CSR, 4,
> > +                                         (u8 *)&adc_code);
> > +             mutex_unlock(&data->lock);
> > +             break;
> > +     default:
> > +             return -EOPNOTSUPP;
> > +     }
> > +     if (ret) {
> > +             dev_err(dev, "Read adc_code failed %d\n", ret);
> > +             return ret;
> > +     }
The error return has been checked here.

> > +     if (adc_code == 0 || adc_code >= 0x3ff) {
> > +             dev_err(dev, "Invalid adc_code %lx\n", adc_code);
> > +             return -EINVAL;
>
OK. I will change to use -ENODATA here.

> I guess this is supposed to cover an error return from pt516xx_read_wide_reg()
> returned an error, assuming that adc_code was not overwritten in that case.
> This is inappropriate. Error returns from pt516xx_read_wide_reg() should be
> handled explicitly (and don't indicate "Invalid argument").
>
> > +     }
> > +
>
> The above will create logging noise if the chip has a problem. Please make it dev_dbg.
>
OK.

> > +     *val = 110000 + ((adc_code - (data->temp_cal_code_avg + 250)) * -320);
> > +
> > +     return 0;
> > +}
> > +
> > +static umode_t pt516xx_is_visible(const void *data,
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
> > +static const struct hwmon_channel_info *pt516xx_info[] = {
> > +     HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT),
> > +     NULL
> > +};
> > +
> > +static const struct hwmon_ops pt516xx_hwmon_ops = {
> > +     .is_visible = pt516xx_is_visible,
> > +     .read = pt516xx_read,
> > +};
> > +
> > +static const struct hwmon_chip_info pt516xx_chip_info = {
> > +     .ops = &pt516xx_hwmon_ops,
> > +     .info = pt516xx_info,
> > +};
> > +
> > +static ssize_t pt516xx_debugfs_read_fw_ver(struct file *file, char __user *buf,
> > +                                        size_t count, loff_t *ppos)
> > +{
> > +     struct pt516xx_data *data = file->private_data;
> > +     int ret;
> > +     char ver[32];
> > +
> > +     mutex_lock(&data->lock);
> > +     ret = pt516xx_fwsts_check(data);
> > +     mutex_unlock(&data->lock);
>
> What is the point of (re-)reading the firmware version repeatedly ?
>
The PCIe retimer uses normal power rail, that is, it's turned off when
the system is powered-off.
Consider that the PCIe retimer is used on a server system, and
monitored by a BMC. (an
independent management controller, with embedded Linux) The BMC is
still working when
the system is powered-off but remains standby power rail. When the
retimer FW is updated
and reload, it can read the correct FW version.

> > +     if (ret)
> > +             return ret;
> > +
> > +     ret = snprintf(ver, sizeof(ver), "%u.%u.%u\n", data->fw_ver.major,
> > +                    data->fw_ver.minor, data->fw_ver.build);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     return simple_read_from_buffer(buf, count, ppos, ver, ret + 1);
> > +}
> > +
> > +static const struct file_operations pt516xx_debugfs_ops_fw_ver = {
> > +     .read = pt516xx_debugfs_read_fw_ver,
> > +     .open = simple_open,
> > +};
> > +
> > +static ssize_t pt516xx_debugfs_read_health(struct file *file, char __user *buf,
> > +                                        size_t count, loff_t *ppos)
> > +{
> > +     struct pt516xx_data *data = file->private_data;
> > +     int ret;
> > +     u8 status = 0;
> > +     char health[8];
> > +
> > +     mutex_lock(&data->lock);
> > +     ret = pt516xx_fwsts_check(data);
> > +     mutex_unlock(&data->lock);
> > +     if (ret == 0) {
> > +             status |= data->mm_heartbeat_okay ? 1 : 0; // bit0
> > +             status |= data->code_load_okay ? 2 : 0; // bit1
>
> Those should really be separate debugfs files.
>
OK.

> > +     }
> > +
> > +     ret = snprintf(health, sizeof(health), "0x%02x\n", status);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     return simple_read_from_buffer(buf, count, ppos, health, ret + 1);
> > +}
> > +
> > +static const struct file_operations pt516xx_debugfs_ops_health = {
> > +     .read = pt516xx_debugfs_read_health,
> > +     .open = simple_open,
> > +};
> > +
> > +static int pt516xx_init_debugfs(struct pt516xx_data *data)
> > +{
> > +     if (!pt516xx_debugfs_dir)
> > +             return -ENOENT;
> > +
>
> debugfs functions handle this situation, and return values therefore do not
> need to be checked.
>
Got it. I will remove it.

> > +     data->debugfs = debugfs_create_dir(dev_name(&data->client->dev),
> > +                                        pt516xx_debugfs_dir);
> > +     if (IS_ERR_OR_NULL(data->debugfs))
> > +             return -ENOENT;
> > +
> Again, unnecessary.
>
Got it.

> > +     debugfs_create_file("fw_ver", 0444, data->debugfs, data,
> > +                         &pt516xx_debugfs_ops_fw_ver);
> > +
> > +     debugfs_create_file("health", 0444, data->debugfs, data,
> > +                         &pt516xx_debugfs_ops_health);
> > +
> > +     return 0;
> > +}
> > +
> > +static int pt516xx_probe(struct i2c_client *client)
> > +{
> > +     struct device *dev = &client->dev;
> > +     struct device *hwmon_dev;
> > +     struct pt516xx_data *data;
> > +
> > +     data = devm_kzalloc(dev, sizeof(struct pt516xx_data), GFP_KERNEL);
> > +     if (!data)
> > +             return -ENOMEM;
> > +
> > +     data->client = client;
> > +     mutex_init(&data->lock);
> > +     pt516xx_init_dev(data);
> > +
> > +     hwmon_dev = devm_hwmon_device_register_with_info(
> > +             dev, client->name, data, &pt516xx_chip_info, NULL);
> > +
> > +     if (pt516xx_init_debugfs(data))
> > +             dev_warn(dev, "Failed to register debugfs\n");
>
> debugfs should fail silently.
>
> debugfs files are not removed if a single device is unloaded. Did you check
> what happens in this case ?
>
Oops, I will add the remove callback function to remove the debugfs files.

> > +
> > +     return PTR_ERR_OR_ZERO(hwmon_dev);
> > +}
> > +
> > +static const struct i2c_device_id pt516xx_id[] = {
> > +     { "pt5161l", 0 },
> > +     {}
> > +};
> > +MODULE_DEVICE_TABLE(i2c, pt516xx_id);
> > +
> > +static const struct of_device_id __maybe_unused pt516xx_of_match[] = {
> > +     { .compatible = "asteralabs,pt5161l" },
> > +     {},
> > +};
> > +MODULE_DEVICE_TABLE(of, pt516xx_of_match);
> > +
> > +static struct i2c_driver pt516xx_driver = {
> > +     .class = I2C_CLASS_HWMON,
> > +     .driver = {
> > +             .name = "pt516xx",
> > +             .of_match_table = of_match_ptr(pt516xx_of_match),
>
> This means the driver won't instantiate on an ACPI system if devicetree
> support is disabled. Is this intentional ?
>
OK. I will add the acpi_match_table.

> > +     },
> > +     .probe = pt516xx_probe,
> > +     .id_table = pt516xx_id,
> > +};
> > +
> > +module_i2c_driver(pt516xx_driver);
> > +
> > +static int __init pt516xx_core_init(void)
> > +{
> > +     pt516xx_debugfs_dir = debugfs_create_dir("pt516xx", NULL);
> > +     if (IS_ERR(pt516xx_debugfs_dir))
> > +             pt516xx_debugfs_dir = NULL;
> > +
> > +     return 0;
> > +}
> > +
> > +static void __exit pt516xx_core_exit(void)
> > +{
> > +     debugfs_remove_recursive(pt516xx_debugfs_dir);
> > +}
> > +
> > +module_init(pt516xx_core_init);
> > +module_exit(pt516xx_core_exit);
> > +
> > +MODULE_AUTHOR("Cosmo Chou <cosmo.chou@quantatw.com>");
> > +MODULE_DESCRIPTION("Hwmon driver for Astera Labs Aries PCIe retimer");
> > +MODULE_LICENSE("GPL");
>
