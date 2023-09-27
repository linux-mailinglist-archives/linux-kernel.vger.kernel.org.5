Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D098D7AFA73
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 07:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjI0F4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 01:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjI0Fzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 01:55:37 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2518ACE6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 22:55:28 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c60f1a2652so46940995ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 22:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695794127; x=1696398927; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UDdxAX+6EGxF98Tw1oipTJCX/gpQ0Z0ZG7J5LXuEM4A=;
        b=jluFgXaYh8ZbqqzrRr7HW8aZySoDI9jFr19CWNKB3Z5dooV/kWXS/W+UZ4p2ut0pfd
         dESpoN/nrzCUnlLwPT8h9Zz7x/92U0JJnDGb42oa84V7LBnTh4BWkqDaPGSZyGnOuaev
         Uyrkgeli6s3JQCviWiFzmkkCX7K92Dzs8+2TiW1GW9gvVHvg4vHPZBAChh7ioiL/+t04
         ++bg02u86ao89Iw0F0KcwMv102SO7wxY9rSrGWerMIJWQ+UqaxZyE6KwQnpNOLEYPRNq
         B1utpTVoGalNIAqqyqiz5CvyW3JhTTNIxM6U96+Lt2oi58MRoR7gsgJ5R8qr1drgPJQr
         8HKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695794127; x=1696398927;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UDdxAX+6EGxF98Tw1oipTJCX/gpQ0Z0ZG7J5LXuEM4A=;
        b=U+lDohp7FG8ov8dpchPlH1jS+GFeuLb05L2+TQGbkJFQ3VdMS/v8A4zRu1LQt5n7Q/
         nBIDri0kfnfqwThI+F1ol5fzRPJMui01AJlSgQZfbIfS/d0fwRXL5rmoSiMu794bb6Ly
         EWqh/drDZtI6hftZtAbj6jYN1aMEWr0Ih6akzSHhVVBpW+pfeMO9n3KMtEP8i05a/szy
         5LFyjp78AGFNqz3mS4LfrCGZp5h/nYtgOdP85ntpKHozoMvSMzTM1P3DKLTacOYnPkdS
         9ZFT0LItbq19Y/flmGeHghLFW4E0NozZTr6J0MvGbA9Va3Te1bnUVvdh8tMQtdgRLr6q
         gm6g==
X-Gm-Message-State: AOJu0YwwIo/52WBv2h7VauJAiMFLHydWb7O/0DV8SNf+bL+vp24llPsu
        FdVtSIuRPep1AgCDtp7VFOhzHGXf1nZhFw==
X-Google-Smtp-Source: AGHT+IG1eELcL8K7bZFHqpNwGF+DIknyCy6Q+fcG9+LKT1fA5boXbHxTHgSzt1VV/cwAA9n00xHR8A==
X-Received: by 2002:a17:902:e74c:b0:1bc:56c3:ebb6 with SMTP id p12-20020a170902e74c00b001bc56c3ebb6mr1999600plf.8.1695794127256;
        Tue, 26 Sep 2023 22:55:27 -0700 (PDT)
Received: from [172.22.12.30] ([123.51.235.123])
        by smtp.gmail.com with ESMTPSA id jw1-20020a170903278100b001c452f827casm12180864plb.257.2023.09.26.22.55.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 22:55:26 -0700 (PDT)
Message-ID: <34b47613-bbe8-37eb-27a4-dbf65e2dbee8@gmail.com>
Date:   Wed, 27 Sep 2023 13:55:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: [PATCH 4/4] mfd: eiois200: Add EIO-IS200 Series EC Core Driver
Content-Language: en-US
To:     Lee Jones <lee@kernel.org>
Cc:     wenkai.chung@advantech.com.tw, Susi.Driver@advantech.com,
        linux-kernel@vger.kernel.org
References: <20230907031320.6814-1-advantech.susiteam@gmail.com>
 <20230907031320.6814-5-advantech.susiteam@gmail.com>
 <20230920111329.GD13143@google.com>
From:   Wenkai <advantech.susiteam@gmail.com>
In-Reply-To: <20230920111329.GD13143@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jones,

Great news! My patch is finally on lore. Now I can track its progress.
It's been quite a journey.

The EIOIS200 is a custom EC for Advantech, originally designed the
Power Management Channel (PMC) only for power management. We extended
it to control all devices on the EC. This EC is a quite slow MCU, but
still monitors crucial parameters like voltage, temperature, and smart
fan, the PMC commands has varying response times, but it has proved
highly stable in industrial usage.

So, we recommend not loading the modules if the users doesn't intend to
use these devices. Load these modules only before accessing the devices.
This is why we've designed it to be compiled as a module by default and
cannot be built-in.

I've made modifications based on your suggestions. Please point out any
further errors. Thank you.

Lee Jones 於 9/20/2023 7:13 PM 寫道:
 >
 > On Thu, 07 Sep 2023, advantech.susiteam@gmail.com wrote:
 >
 > > From: Wenkai <advantech.susiteam@gmail.com>
 > >
 > > This patch introduces the Advantech EIO-IS200 Series EC Core Driver.
 > > The EIO-IS200 combines hardware functionality with firmware
 > > capabilities to provide key features through a dedicated Power
 > > Management Channel (PMC).
 > >
 > > Key Features:
 > > - Implements the core EIO-IS200 IC driver that serves as the
 > >   interface to the IC's firmware and hardware functions.
 > > - Contains low-level functions for accessing the IC's Power
 > >   Management Channel (PMC).
 > > - Manages PMC command execution, PMC buffer handling, and
 > >   communication.
 > > - Expose a regmap and a mutex for low-level access.
 > > - Activates support for GPIO, I2C, Hwmon, and Watchdog functionalities
 > >   of the EIO-IS200 IC.
 > > - Provides various sysfs attributes to expose information about the
 > >   EC chip, firmware, and motherboard.
 > > - Includes a timeout parameter to allow modification of the default
 > >   PMC command timeout value, which is particularly useful when
 > >   dealing with an extremely slow-responding device.
 > >
 > > Signed-off-by: Wenkai <advantech.susiteam@gmail.com>
 > > ---
 > >  drivers/mfd/eiois200_core.c | 590 ++++++++++++++++++++++++++++++++++++
 >
 > Please organise patches by functionality, not file.
 >
 > Each of the patches in this series are worthless without the others.

I understand.
But, I am currently unsure of how to organize these patches. But I'll
give it a try.

 >
 > Have you run static analysis on this?
 >
 > What about checkpatch.pl?

Those already passed the checkpatch.pl checks.

I just used "sparse" for static code analysis and received two warnings
you had pointed out below.

 >
 > >  1 file changed, 590 insertions(+)
 > >  create mode 100644 drivers/mfd/eiois200_core.c
 > >
 > > diff --git a/drivers/mfd/eiois200_core.c b/drivers/mfd/eiois200_core.c
 > > new file mode 100644
 > > index 000000000000..7459dee1ed53
 > > --- /dev/null
 > > +++ b/drivers/mfd/eiois200_core.c
 > > @@ -0,0 +1,590 @@
 > > +// SPDX-License-Identifier: GPL-2.0-only
 > > +/*
 > > + * Advantech EIO-IS200 Series EC base Driver
 > > + *
 > > + * This driver provides an interface to access the EIO-IS200 Series EC
 > > + * firmware via its own Power Management Channel (PMC) for subdrivers:
 > > + *
 > > + * - Watchdog: drivers/watchdog/eiois200_wdt
 > > + * - GPIO: drivers/gpio/gpio_eiois200
 > > + * - Hwmon: drivers/hwmon/eiois200_hwmon
 > > + * - I2C: drivers/i2c/busses/i2c_eiois200
 > > + * - Thermal: drivers/thermal/eiois200_thermal
 >
 > None of these exist.  I would remove these completely. They will be
 > highly susceptible to bit-rot.

Understand. I'll submit them on sub-drivers upstream one by one. Is that 
correct?

 >
 > > + * A system may have one or two independent EIO-IS200s.
 > > + *
 > > + * Copyright (C) 2023 Advantech Co., Ltd.
 > > + * Author: wenkai.chung <wenkai.chung@advantech.com.tw>
 >
 > Is the name on your government ID "wenkai.chung"?

No, my government ID name is 'WEN-KAI CHUNG', 'wenkai.chung' is my
Advantech ID.

Should I use 'Wenkai <advantech.susiteam@gmail.com', or are there other
rules I should follow?

 > > + */
 > > +
 > > +#include <linux/delay.h>
 > > +#include <linux/isa.h>
 > > +#include <linux/mfd/core.h>
 > > +#include <linux/mutex.h>
 > > +#include <linux/time.h>
 > > +#include <linux/uaccess.h>
 > > +
 > > +#include "eiois200.h"
 > > +
 > > +#define TIMEOUT_MAX  (10 * 1000 * 1000)
 >
 > There are helpers to convert between time bases.  Please use them.

Did you mean I should write like this?

     #define TIMEOUT_MAX     (10 * USEC_PER_SEC)

 >
 > Where do these values come from?

Typically, the response time for PMC commands falls within the range of
200 microseconds to 2 milliseconds, with occasional commands requiring
up to 5 milliseconds. However, when the EC (Embedded Controller)
accesses external, exceptionally slow devices, the response time can
approach one second.

To account for this variability, we have defined a valid timeout range
of 200 microseconds to 10 seconds for PMC commands. To date, we have not
encountered any applications that necessitate timeouts beyond this
range. Any PMC command's timeout value exceeding this range will
immediate return error without executing the PMC command.

 >
 > > +#define TIMEOUT_MIN  200
 > > +
 > > +static uint timeout = 5000;
 >
 > Why 5000?

I think you mentioned that the code needs more explanation.
I modified the code below. Is that OK?

     #define TIMEOUT_MAX     (10 * USEC_PER_SEC)
     #define TIMEOUT_MIN    200
     #define DEFAULT_TIMEOUT 5000

     /**
     * Timeout: Default timeout in microseconds when a PMC command's
     * timeout is unspecified. PMC command responses typically range
     * from 200us to 2ms. 5ms is quite a safe value for timeout. In
     * In some cases, responses are longer. In such situations, please
     * adding the timeout parameter loading related sub-drivers or
     * this core driver (not recommended).
     */
     static uint timeout = DEFAULT_TIMEOUT;
     module_param(timeout, uint, 0444);
     MODULE_PARM_DESC(timeout,
              "Default PMC command timeout in usec.\n");

 >
 > > +module_param(timeout, uint, 0664);
 > > +MODULE_PARM_DESC(timeout,
 > > +              "Default PMC command timeout in usec.\n");
 >
 > How useful is it to override this on the commandline, really?

You are right. I modified it as below:

     static uint timeout = DEFAULT_TIMEOUT;
     module_param(timeout, uint, 0444);
     MODULE_PARM_DESC(timeout,
              "Default PMC command timeout in usec.\n");

 >
 > > +struct eiois200_dev_port {
 > > +     u16 idx;
 > > +     u16 data;
 >
 > 2 of the worst variable names of all time.
 >
 > Please ensure variable names describe their purpose.

Alright, I'll make the following changes. Is that okay?

     struct eiois200_dev_port {
         u16 idx_port;
         u16 data_port;
     };

 >
 > > +};
 > > +
 > > +struct eiois200_dev_port pnp_port[] = {
 > > +     { .idx = EIOIS200_PNP_INDEX,     .data = EIOIS200_PNP_DATA     },
 > > +     { .idx = EIOIS200_SUB_PNP_INDEX, .data = EIOIS200_SUB_PNP_DATA },
 > > +};
 > > +
 > > +static struct eiois200_dev *eiois200_dev;
 > > +static struct regmap *regmap_is200;
 >
 > Avoid globals at all (most, many ...) costs.

I am sorry about that. I'll be more cautious.

 >
 > > +static struct mfd_cell susi_mfd_devs[] = {
 > > +     { .name = "eiois200_wdt"     },
 > > +     { .name = "gpio_eiois200"    },
 > > +     { .name = "eiois200_hwmon"   },
 > > +     { .name = "eiois200_i2c"     },
 > > +     { .name = "eiois200_thermal" },
 > > +};

Should I remove these, too?

 > > +
 > > +struct regmap_range is200_range[] = {
 > > +      regmap_reg_range(EIOIS200_PNP_INDEX, EIOIS200_PNP_DATA),
 > > +      regmap_reg_range(EIOIS200_SUB_PNP_INDEX, EIOIS200_SUB_PNP_DATA),
 > > +      regmap_reg_range(EIOIS200_PMC_PORT,  EIOIS200_PMC_PORT + 0x0F),
 > > +      regmap_reg_range(EIOIS200_PMC_PORT_SUB, 
  EIOIS200_PMC_PORT_SUB + 0x0F),
 > > +};
 > > +
 > > +static const struct regmap_access_table volatile_regs = {
 > > +     .yes_ranges   = is200_range,
 > > +     .n_yes_ranges = ARRAY_SIZE(is200_range),
 > > +};
 > > +
 > > +static const struct regmap_config pnp_regmap_config = {
 > > +     .name           = "eiois200-gpio",
 > > +     .reg_bits       = 16,
 > > +     .val_bits       = 8,
 > > +     .volatile_table = &volatile_regs,
 > > +     .io_port        = true,
 > > +};
 > > +
 > > +/* Following are EIO-IS200 pnp io port access functions */
 >
 > "IO"
 >
 > Probably "PNP" too.

OK! I'll fix this and others below.

 >
 > > +static int is200_pnp_read(struct eiois200_dev_port *port, u8 idx)
 > > +{
 > > +     int val;
 > > +
 > > +     if (regmap_write(regmap_is200, port->idx, idx))
 > > +             pr_err("Error port write 0x%X\n", port->idx);
 >
 > Why pr_err()?  You should have a 'dev' pointer.  So use dev_err().

OK! I'll fix all others, too.

And I'll remove the definition on 'eiois200.h'.
This definition makes pr_xxx messages look like dev_xxx.

     #ifdef pr_fmt
     #undef pr_fmt
     #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
     #endif

 >
 > > +     if (regmap_read(regmap_is200, port->data, &val))
 > > +             pr_err("Error port read 0x%X\n", port->data);
 > > +
 > > +     return val;
 > > +}
 > > +
 > > +static void is200_pnp_write(struct eiois200_dev_port *port, u8 
idx, u8 data)
 > > +{
 > > +     if (regmap_write(regmap_is200, port->idx, idx) ||
 > > +         regmap_write(regmap_is200, port->data, data))
 > > +             pr_err("Error port write 0x%X %X\n",
 > > +                    port->idx, port->data);
 > > +}
 > > +
 > > +static void is200_pnp_enter(struct eiois200_dev_port *port)
 > > +{
 > > +     if (regmap_write(regmap_is200, port->idx, 
EIOIS200_EXT_MODE_ENTER) ||
 > > +         regmap_write(regmap_is200, port->idx, 
EIOIS200_EXT_MODE_ENTER))
 >
 > How are these 2 calls any different to each other?

Hardware specifications require two consecutive 0x87 commands to unlock it.
Did you mean I should add comments like below?

     static void is200_pnp_enter(struct eiois200_dev_port *port)
     {
         /* Write 0x87 to index port twice to unlock IO port */
         if (regmap_write(regmap_is200, port->idx_port, 
EIOIS200_EXT_MODE_ENTER) ||
             regmap_write(regmap_is200, port->idx_port, 
EIOIS200_EXT_MODE_ENTER))
             pr_err("Error port write 0x%X\n", port->idx_port);
     }

     static void is200_pnp_leave(struct eiois200_dev_port *port)
     {
         /* Write 0xAA to index port once to lock IO port */
         if (regmap_write(regmap_is200, port->idx_port, 
EIOIS200_EXT_MODE_EXIT))
             pr_err("Error port write 0x%X\n", port->idx_port);
     }

 >
 > > +             pr_err("Error port write 0x%X\n", port->idx);
 >
 > Return error?

No, it doesn't return an error.
If an error occurs, it won't retrieve the correct content.
Which can result in a failed initialization.
This was tested locally, and it made the probe procedure stop.

 >
 > > +}
 > > +
 > > +static void is200_pnp_leave(struct eiois200_dev_port *port)
 > > +{
 > > +     if (regmap_write(regmap_is200, port->idx, 
EIOIS200_EXT_MODE_EXIT))
 > > +             pr_err("Error port write 0x%X\n", port->idx);
 >
 > Return error?

Like above. No return error.

 >
 > > +}
 > > +
 > > +/* Following are EIO-IS200 io port access functions for pmc command */
 > > +static int pmc_write_data(int id, u8 value, u16 timeout)
 > > +{
 > > +     int ret;
 > > +
 > > +     if (WAIT_IBF(id, timeout))
 > > +             return -ETIME;
 >
 > What's happening here?

As the definition on eiois200.h I separately patched.

     enum eiois200_pmc_wait {
         PMC_WAIT_INPUT,
         PMC_WAIT_OUTPUT,
     };

     /**
      * eiois200_core_pmc_wait - Wait for input / output buffer to be ready
      * @id:        0 for main chip, 1 for sub chip.
      * @wait:    %PMC_WAIT_INPUT or %PMC_WAIT_OUTPUT.
      *        %PMC_WAIT_INPUT for waiting input buffer data ready.
      *        %PMC_WAIT_OUTPUT for waiting output buffer empty.
      * @timeout:    The timeout value. 0 means use the default value.
      */
     int eiois200_core_pmc_wait(int id, enum eiois200_pmc_wait wait, 
uint timeout);

     #define WAIT_IBF(id, timeout)    eiois200_core_pmc_wait(id, 
PMC_WAIT_INPUT, timeout)
     #define WAIT_OBF(id, timeout)    eiois200_core_pmc_wait(id, 
PMC_WAIT_OUTPUT, timeout)

It waits for the buffer to be ready.
Or, do you mean that I should add some comments?

     /* Wait til the input port clear for write */
     if (WAIT_IBF(id, timeout))
         return -ETIME;

     /* Write one byte of data to the port */
     ret = regmap_write(regmap_is200, eiois200_dev->pmc[id].data, value);
     if (ret)
         pr_err("Error PMC write %X:%X\n",
                eiois200_dev->pmc[id].data, value);

 >
 > > +     ret = regmap_write(regmap_is200, eiois200_dev->pmc[id].data, 
value);
 > > +     if (ret)
 > > +             pr_err("Error pmc write %X:%X\n",
 > > +                    eiois200_dev->pmc[id].data, value);
 > > +
 > > +     return ret;
 > > +}
 > > +
 > > +static int pmc_write_cmd(int id, u8 value, u16 timeout)
 > > +{
 > > +     int ret;
 > > +
 > > +     if (WAIT_IBF(id, timeout))
 > > +             return -ETIME;
 > > +
 > > +     ret = regmap_write(regmap_is200, eiois200_dev->pmc[id].cmd, 
value);
 > > +     if (ret)
 > > +             pr_err("Error pmc write %X:%X\n",
 > > +                    eiois200_dev->pmc[id].data, value);
 > > +
 > > +     return ret;
 > > +}
 > > +
 > > +static int pmc_read_data(int id, u8 *value, u16 timeout)
 > > +{
 > > +     int val, ret;
 > > +
 > > +     if (WAIT_OBF(id, timeout))
 > > +             return -ETIME;
 > > +
 > > +     ret = regmap_read(regmap_is200, eiois200_dev->pmc[id].data, 
&val);
 > > +     if (ret)
 > > +             pr_err("Error pmc read %X\n", 
eiois200_dev->pmc[id].data);
 > > +     else
 > > +             *value = val & 0xFF;
 > > +
 > > +     return ret;
 > > +}
 > > +
 > > +static int pmc_read_status(int id)
 > > +{
 > > +     int val;
 > > +
 > > +     if (regmap_read(regmap_is200, eiois200_dev->pmc[id].data, 
&val)) {
 > > +             pr_err("Error pmc read %X\n", 
eiois200_dev->pmc[id].data);
 > > +             return 0;
 >
 > You've just filed and yet you are returning success?

This function returns 0 on error. I'll add comments as below:

     /**
      * pmc_read_status - Read the PMC's current status
      * @id:        0 for main chip, 1 for sub chip.
      * Returns:    The current status read from the PMC, or return 0 on 
error.
     */

 >
 > > +     }
 > > +
 > > +     return val;
 > > +}
 > > +
 > > +static void pmc_clear(int id)
 > > +{
 > > +     int val;
 > > +
 > > +     /* Check if input buffer blocked */
 > > +     if ((pmc_read_status(id) & EIOIS200_PMC_STATUS_IBF) == 0)
 > > +             return;
 > > +
 > > +     /* Read out previous garbage */
 > > +     if (regmap_read(regmap_is200, eiois200_dev->pmc[id].data, &val))
 > > +             pr_err("Error pmc clear\n");
 > > +
 > > +     usleep_range(10, 100);
 > > +}
 > > +
 > > +/**
 > > + * eiois200_core_pmc_wait - Wait for input / output buffer to be 
ready.
 > > + * @id:                      0 for main chip, 1 for sub chip.
 > > + * @wait:            %PMC_WAIT_INPUT or %PMC_WAIT_OUTPUT.
 > > + *                   %PMC_WAIT_INPUT for waiting input buffer data 
ready.
 > > + *                   %PMC_WAIT_OUTPUT for waiting output buffer empty.
 > > + * max_duration:     The timeout value in usec.
 > > + */
 > > +int eiois200_core_pmc_wait(int id,
 > > +                        enum eiois200_pmc_wait wait,
 > > +                        uint max_duration)
 > > +{
 > > +     u32     cnt = 0;
 > > +     uint    val;
 > > +     int     ret;
 > > +     int     new_timeout = max_duration ? max_duration : timeout;
 > > +     ktime_t time_end    = ktime_add_us(ktime_get(), new_timeout);
 >
 > Remove all of this type of lining up.

Got it, Changes it as below:

     int ret;
     uint val;
     u32 cnt = 0;
     int new_timeout = max_duration ? max_duration : timeout;
     ktime_t time_end = ktime_add_us(ktime_get(), new_timeout);

 >
 > > +
 > > +     if (new_timeout > TIMEOUT_MAX ||
 > > +         new_timeout < TIMEOUT_MIN) {
 >
 > Why the '\n' here?

Got it, I'll change it as below:

     if (new_timeout < TIMEOUT_MIN || new_timeout > TIMEOUT_MAX) {

 >
 > > +             pr_err("Error timeout value: %dus\nTimeout value 
should between %d and %d\n",
 >
 > Avoid line breaks in error messages.

Like above. I removed '\n'.

     if (new_timeout < TIMEOUT_MIN || new_timeout > TIMEOUT_MAX) {
         dev_err(dev,
             "Error timeout value: %dus. Timeout value should between %d 
and %ld\n",
             new_timeout, TIMEOUT_MIN, TIMEOUT_MAX);
         return -ETIME;
     }

 >
 > > +                    new_timeout, TIMEOUT_MIN, TIMEOUT_MAX);
 > > +             return -ETIME;
 > > +     }
 > > +
 > > +     do {
 > > +             ret = regmap_read(regmap_is200,
 > > + eiois200_dev->pmc[id].status,
 > > +                               &val);
 > > +             if (ret)
 > > +                     return ret;
 > > +
 > > +             if (wait == PMC_WAIT_INPUT) {
 > > +                     if ((val & EIOIS200_PMC_STATUS_IBF) == 0)
 > > +                             return 0;
 > > +             } else {
 > > +                     if ((val & EIOIS200_PMC_STATUS_OBF) != 0)
 > > +                             return 0;
 > > +             }
 > > +
 > > +             /* Incremental delay */
 > > +             fsleep(cnt++ * 10);
 > > +
 > > +     } while (ktime_before(ktime_get(), time_end));
 > > +
 > > +     return -ETIME;
 > > +}
 > > +EXPORT_SYMBOL_GPL(eiois200_core_pmc_wait);
 > > +
 > > +/**
 > > + * eiois200_core_pmc_operation - Execute a pmc command
 >
 > "PMC"

Okay, I'll fix this and all others.

 >
 > > + * @op:              Pointer to an pmc command.
 > > + */
 > > +int eiois200_core_pmc_operation(struct _pmc_op *op)
 > > +{
 > > +     u8      i;
 > > +     int     ret;
 > > +     bool    read_cmd = op->cmd & 0x01;
 > > +     ktime_t t = ktime_get();
 > > +
 > > +     mutex_lock(&eiois200_dev->mutex);
 > > +
 > > +     pmc_clear(op->chip);
 > > +
 > > +     ret = pmc_write_cmd(op->chip, op->cmd, op->timeout);
 > > +     if (ret)
 > > +             goto err;
 > > +
 > > +     ret = pmc_write_data(op->chip, op->control, op->timeout);
 > > +     if (ret)
 > > +             goto err;
 > > +
 > > +     ret = pmc_write_data(op->chip, op->device_id, op->timeout);
 > > +     if (ret)
 > > +             goto err;
 > > +
 > > +     ret = pmc_write_data(op->chip, op->size, op->timeout);
 > > +     if (ret)
 > > +             goto err;
 > > +
 > > +     for (i = 0 ; i < op->size ; i++) {
 >
 > Remove the spaces before the ';'s.

Okay, I'll fix this and all others, too.

 >
 > > +             if (read_cmd)
 > > +                     ret = pmc_read_data(op->chip, 
&op->payload[i], op->timeout);
 > > +             else
 > > +                     ret = pmc_write_data(op->chip, 
op->payload[i], op->timeout);
 > > +
 > > +             if (ret)
 > > +                     goto err;
 > > +     }
 > > +
 > > +     mutex_unlock(&eiois200_dev->mutex);
 > > +
 > > +     return 0;
 > > +
 > > +err:
 > > +     mutex_unlock(&eiois200_dev->mutex);
 > > +
 > > +     pr_err("PMC error duration:%lldus\n",
 > > +            ktime_to_us(ktime_sub(ktime_get(), t)));
 >
 > Why the line wrap.

Did you mean that as below?

     pr_err("PMC error duration:%lldus", 
ktime_to_us(ktime_sub(ktime_get(), t)));

 >
 > > +     pr_err(".cmd=0x%02X, .ctrl=0x%02X .id=0x%02X, .size=0x%02X 
.data=0x%02X%02X\n",
 > > +            op->cmd, op->control, op->device_id,
 > > +            op->size, op->payload[0], op->payload[1]);
 >
 > Are these prints actually useful?
 >
 > I'd suggest that they are debug prints at best.

Yes, I believe this information is helpful.
But, I hope this error message will never be shown on production release.

PMC commands should always succeed,
and their failure indicates a significant issue that requires attention.
The most common reason for failure is insufficient timeout value,
but it could also signify more severe underlying problems.

 >
 > > +     return ret;
 > > +}
 > > +EXPORT_SYMBOL_GPL(eiois200_core_pmc_operation);
 > > +
 > > +static int get_pmc_port(struct device *dev, int id, struct 
eiois200_dev_port *port)
 > > +{
 > > +     struct _pmc_port *pmc = &eiois200_dev->pmc[id];
 >
 > What's with the '_'?
 >
 > This usually means that it's internal and should not be used.

You are right. I'll fix all others, include the header, and the sub-drivers.

 >
 > > +     is200_pnp_enter(port);
 > > +
 > > +     /* Switch to PMC device page */
 > > +     is200_pnp_write(port, EIOIS200_LDN, EIOIS200_LDN_PMC1);
 > > +
 > > +     /* Active this device */
 > > +     is200_pnp_write(port, EIOIS200_LDAR, EIOIS200_LDAR_LDACT);
 > > +
 > > +     /* Get PMC cmd and data port */
 > > +     pmc->data  = is200_pnp_read(port, EIOIS200_IOBA0H) << 8;
 > > +     pmc->data |= is200_pnp_read(port, EIOIS200_IOBA0L);
 > > +     pmc->cmd   = is200_pnp_read(port, EIOIS200_IOBA1H) << 8;
 > > +     pmc->cmd  |= is200_pnp_read(port, EIOIS200_IOBA1L);
 > > +
 > > +     /* Disable IRQ */
 > > +     is200_pnp_write(port, EIOIS200_IRQCTRL, 0);
 > > +
 > > +     is200_pnp_leave(port);
 > > +
 > > +     /* Make sure IO ports are not occupied */
 > > +     if (!devm_request_region(dev, pmc->data, 2, KBUILD_MODNAME)) {
 > > +             dev_err(dev, "Request region %X error\n", pmc->data);
 > > +             return -EBUSY;
 > > +     }
 > > +
 > > +     return 0;
 > > +}
 > > +
 > > +static int eiois200_exist(struct device *dev)
 > > +{
 > > +     u16  chip_id = 0;
 > > +     u8   tmp = 0;
 > > +     int  i = 0;
 > > +     int  ret = -ENOMEM;
 > > +     char chip[][8] = { "First",  "Second" };
 > > +
 > > +     for (i = 0 ; i < ARRAY_SIZE(pnp_port) ; i++) {
 >
 > Should 'i' be 'port' here?

I think using 'chip' would be better.
Here 0 for the first chip, and 1 for the second chip.
I modified the code below. Is this okay?

     int  chip = 0;
     int  ret = -ENOMEM;

     for (chip = 0; chip < ARRAY_SIZE(pnp_port); chip++) {
         struct eiois200_dev_port *port = pnp_port + chip;

 >
 > > +             struct eiois200_dev_port *port = pnp_port + i;
 > > +
 > > +             if (!devm_request_region(dev,
 > > +                                      pnp_port[i].idx,
 > > +                                      2,
 >
 > What's 2?  This should probably be defined.

Yes, It is confusing. Is the following code okay?

if (!devm_request_region(dev,
              pnp_port[chip].idx_port,
              pnp_port[chip].data_port -
              pnp_port[chip].idx_port,
              KBUILD_MODNAME))

 >
 > > +                                      KBUILD_MODNAME))
 > > +                     continue;
 > > +
 > > +             is200_pnp_enter(port);
 > > +
 > > +             chip_id  = is200_pnp_read(port, EIOIS200_CHIPID1) << 8;
 > > +             chip_id |= is200_pnp_read(port, EIOIS200_CHIPID2);
 > > +
 > > +             if (chip_id != EIOIS200_CHIPID &&
 > > +                 chip_id != EIO201_211_CHIPID)
 > > +                     continue;
 > > +
 > > +             /* Turn on the enable flag */
 > > +             tmp = is200_pnp_read(port, EIOIS200_SIOCTRL);
 > > +             tmp |= EIOIS200_SIOCTRL_SIOEN;
 > > +             is200_pnp_write(port, EIOIS200_SIOCTRL, tmp);
 > > +
 > > +             is200_pnp_leave(port);
 > > +
 > > +             ret = get_pmc_port(dev, i, port);
 > > +             if (ret)
 > > +                     return ret;
 > > +
 > > +             eiois200_dev->flag |= i == 0 ?  EIOIS200_F_CHIP_EXIST :
 >
 > This logic either needs improving or commented on.

Is this okay?

     if (chip == 0)
         eiois200_dev->flag |= EIOIS200_F_CHIP_EXIST;
     else
         eiois200_dev->flag |= EIOIS200_F_SUB_CHIP_EXIST;

 >
 > > + EIOIS200_F_SUB_CHIP_EXIST;
 > > +
 > > +             pr_info("%s chip detected: %04X\n", chip[i], chip_id);
 >
 > We can almost certainly do without these in production code.

Yes, I'll remove it.

 >
 > > +     }
 > > +
 > > +     return ret;
 > > +}
 > > +
 > > +/* read information about acpi stored in EC */
 >
 > Please use prober grammar.
 >
 > "Read ACPI information stored in the EC"

Okay.

     /**
      * acpiram_access - Read ACPI information stored in the EC
      * @dev:    The device structure pointer.
      * @offset:    The offset of information.
      * Returns:    The value read from the PMC, or 0 if there was an error.
      */
     static uint8_t acpiram_access(struct device *dev, uint8_t offset)

 >
 > > +static uint8_t acpiram_access(uint8_t offset)
 > > +{
 > > +     u8  val;
 > > +     int ret;
 > > +
 > > +     mutex_lock(&eiois200_dev->mutex);
 > > +
 > > +     pmc_clear(0);
 > > +
 > > +     ret = pmc_write_cmd(0, EIOIS200_PMC_CMD_ACPIRAM_READ, 0);
 >
 > All of the magic numbers in this function need to be defined.

The chip id = 0 means the first chip.
The timeout = 0 means not specified timeout, Use default value.

The code modified as below:

     int timeout = 0;

     /* We only store information only on primary EC */
     int chip = 0;

     mutex_lock(&eiois200_dev->mutex);

     pmc_clear(dev, chip);

     ret = pmc_write_cmd(dev, chip, EIOIS200_PMC_CMD_ACPIRAM_READ, timeout);
     if (ret)
         goto err;

 >
 > > +     if (ret)
 > > +             goto err;
 > > +
 > > +     ret = pmc_write_data(0, offset, 0);
 > > +     if (ret)
 > > +             goto err;
 > > +
 > > +     ret = pmc_write_data(0, 1, 0);
 > > +     if (ret)
 > > +             goto err;
 > > +
 > > +     ret = pmc_read_data(0, &val, 0);
 > > +     if (ret)
 > > +             goto err;
 > > +
 > > +err:
 > > +     mutex_unlock(&eiois200_dev->mutex);
 > > +     return ret ? 0 : val;
 >
 > If it fails, you return success?

It returns 0 on error, or returns the value read.
Maybe I should add the comment below.

     /**
      * acpiram_access - Read ACPI information stored in the EC
      * @offset:    The offset of information.
      * Returns:    The value read from the PMC, or 0 if there was an error.
     */
     static uint8_t acpiram_access(uint8_t offset)

 >
 > > +}
 > > +
 > > +static int firmware_code_base(struct device *dev)
 > > +{
 > > +     u8 ic_vendor, ic_code, code_base;
 > > +
 > > +     ic_vendor = acpiram_access(EIOIS200_ACPIRAM_ICVENDOR);
 > > +     ic_code   = acpiram_access(EIOIS200_ACPIRAM_ICCODE);
 > > +     code_base = acpiram_access(EIOIS200_ACPIRAM_CODEBASE);
 > > +
 > > +     if (ic_vendor != 'R')
 > > +             return -ENODEV;
 > > +
 > > +     if (ic_code != EIOIS200_ICCODE &&
 > > +         ic_code != EIO201_ICCODE   &&
 > > +         ic_code != EIO211_ICCODE)
 > > +             goto err;
 > > +
 > > +     if (code_base == 0x80) {
 >
 > No magic numbers please.

Sorry, I'll fix these and others.

 >
 > > +             eiois200_dev->flag |= EIOIS200_F_NEW_CODE_BASE;
 > > +             return 0;
 > > +     }
 > > +
 > > +     if (code_base == 0 && (ic_code != EIO201_ICCODE &&
 > > +                            ic_code != EIO211_ICCODE)) {
 > > +             pr_info("Old code base not supported, yet.");
 > > +             return -ENODEV;
 > > +     }
 > > +
 > > + err:
 > > +     dev_err(dev,
 > > +             "Codebase check fail:\n"
 > > +             "ic_vendor: 0x%X  ,ic_code : 0x%X ,code_base : 0x%X\n",
 > > +             ic_vendor, ic_code, code_base);
 >
 > These are really ugly prints.
 >
 > Also, they should not contain new lines.

Sorry, Is following better, or any advice?

     /* Codebase error. This should only happen on firmware error. */
     dev_err(dev, "Codebase check fail: vendor: 0x%X, code: 0x%X, base: 
0x%X\n",
         ic_vendor, ic_code, code_base);

Normally, here should not be called. Only on firmware error.

 >
 > > +     return -ENODEV;
 > > +}
 > > +
 > > +int eiois200_probe(struct device *dev, unsigned int id)
 >
 > .probe() usually goes near the bottom.

Got it.

 >
 > > +{
 > > +     int  ret = 0;
 > > +     void __iomem *iomem;
 >
 > Swap these over.

Okay.

 >
 > > +     iomem = devm_ioport_map(dev, 0, EIOIS200_SUB_PNP_DATA + 1);
 > > +     if (!iomem)
 > > +             return -ENOMEM;
 > > +
 > > +     regmap_is200 = devm_regmap_init_mmio(dev, iomem, 
&pnp_regmap_config);
 > > +     if (!regmap_is200)
 > > +             return -ENOMEM;
 > > +
 > > +     eiois200_dev = devm_kzalloc(dev,
 > > +                                 sizeof(struct eiois200_dev),
 >
 > sizeof(*eiois200_dev)

Got it.

     eiois200_dev = devm_kzalloc(dev,
                     sizeof(*eiois200_dev),
                     GFP_KERNEL);

 >
 > > +                                 GFP_KERNEL);
 > > +     if (!eiois200_dev)
 > > +             return -ENOMEM;
 > > +
 > > +     mutex_init(&eiois200_dev->mutex);
 > > +
 > > +     if (eiois200_exist(dev))
 > > +             return -ENODEV;
 > > +
 > > +     if (firmware_code_base(dev)) {
 > > +             dev_err(dev, "Chip code base check fail\n");
 > > +             return -EIO;
 > > +     }
 > > +
 > > +     dev_set_drvdata(dev, eiois200_dev);
 >
 > What data have you stored in eiois200_dev?

Maybe I should change the name 'eiois200_exist' to be 'eiois200_init'.
And this function and firmware_code_base will fill the 'eiois200_dev'
structure.
The structure defined in eiois200.h:

     #define EIOIS200_EC_NUM    2

     ...

     struct eiois200_dev {
         u32 flag;

         struct _pmc_port  pmc[EIOIS200_EC_NUM];

         struct mutex mutex; /* Protects PMC command access */
     };

 >
 > > +     ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE, 
susi_mfd_devs,
 > > +  ARRAY_SIZE(susi_mfd_devs),
 > > +                                NULL, 0, NULL);
 > > +     if (ret)
 > > +             dev_err(dev, "Cannot register child devices (error = 
%d)\n", ret);
 > > +
 > > +     pr_info("%s started", KBUILD_MODNAME);
 >
 > These prints are not useful, please remove them.

Yes, I removed it.

 >
 > > +
 > > +     return 0;
 > > +}
 > > +
 > > +struct {
 > > +     char name[32];
 > > +     int  cmd;
 > > +     int  ctrl;
 > > +     int  size;
 > > +} attrs[] = {
 > > +     { "board_name",         0x53, 0x10, 16 },
 > > +     { "board_serial",       0x53, 0x1F, 16 },
 > > +     { "board_manufacturer", 0x53, 0x11, 16 },
 > > +     { "board_id",           0x53, 0x1E,  4 },
 > > +     { "firmware_version",   0x53, 0x22, 16 },
 > > +     { "firmware_build",     0x53, 0x23, 26 },
 > > +     { "firmware_date",      0x53, 0x24, 16 },
 > > +     { "chip_id",            0x53, 0x12, 12 },
 > > +     { "chip_detect",        0x53, 0x15, 12 },
 > > +     { "platform_type",      0x53, 0x13, 16 },
 > > +     { "platform_revision",  0x53, 0x14,  4 },
 > > +     { "eapi_version",       0x53, 0x30,  4 },
 > > +     { "eapi_id",            0x53, 0x31,  4 },
 > > +     { "boot_count",         0x55, 0x10,  4 },
 > > +     { "powerup_hour",       0x55, 0x11,  4 },
 > > +};
 > > +
 > > +static ssize_t info_show(struct device *dev,
 > > +                      struct device_attribute *attr, char *buf)
 >
 > SYSFS handling usually goes near the top.

Got it, I'll move it up.

 >
 > > +{
 > > +     uint i;
 > > +
 > > +     for (i = 0 ; i < ARRAY_SIZE(attrs) ; i++)
 > > +             if (!strcmp(attr->attr.name, attrs[i].name)) {
 > > +                     int ret;
 > > +                     char str[32] = "";
 > > +                     struct _pmc_op op = {
 > > +                             .cmd     = attrs[i].cmd,
 > > +                             .control = attrs[i].ctrl,
 > > +                             .payload = (u8 *)str,
 > > +                             .size    = attrs[i].size,
 > > +                     };
 > > +
 > > +                     ret = eiois200_core_pmc_operation(&op);
 > > +                     if (ret)
 > > +                             return ret;
 > > +
 > > +                     if (attrs[i].size == 4)
 > > +                             return sysfs_emit(buf, "%X\n", *(u32 
*)str);
 > > +                     else
 > > +                             return sysfs_emit(buf, "%s\n", str);
 > > +             }
 > > +
 > > +     return -EINVAL;
 > > +}
 > > +
 > > +static DEVICE_ATTR(board_name,               0444, info_show, NULL);
 > > +static DEVICE_ATTR(board_serial,     0444, info_show, NULL);
 > > +static DEVICE_ATTR(board_manufacturer,       0444, info_show, NULL);
 > > +static DEVICE_ATTR(firmware_version, 0444, info_show, NULL);
 > > +static DEVICE_ATTR(firmware_build,   0444, info_show, NULL);
 > > +static DEVICE_ATTR(firmware_date,    0444, info_show, NULL);
 > > +static DEVICE_ATTR(chip_id,          0444, info_show, NULL);
 > > +static DEVICE_ATTR(chip_detect,              0444, info_show, NULL);
 > > +static DEVICE_ATTR(platform_type,    0444, info_show, NULL);
 > > +static DEVICE_ATTR(platform_revision,        0444, info_show, NULL);
 > > +static DEVICE_ATTR(board_id,         0444, info_show, NULL);
 > > +static DEVICE_ATTR(eapi_version,     0444, info_show, NULL);
 > > +static DEVICE_ATTR(eapi_id,          0444, info_show, NULL);
 > > +static DEVICE_ATTR(boot_count,               0444, info_show, NULL);
 > > +static DEVICE_ATTR(powerup_hour,     0444, info_show, NULL);
 > > +
 > > +static struct attribute *pmc_attrs[] = {
 > > +     &dev_attr_board_name.attr,
 > > +     &dev_attr_board_serial.attr,
 > > +     &dev_attr_board_manufacturer.attr,
 > > +     &dev_attr_firmware_version.attr,
 > > +     &dev_attr_firmware_build.attr,
 > > +     &dev_attr_firmware_date.attr,
 > > +     &dev_attr_chip_id.attr,
 > > +     &dev_attr_chip_detect.attr,
 > > +     &dev_attr_platform_type.attr,
 > > +     &dev_attr_platform_revision.attr,
 > > +     &dev_attr_board_id.attr,
 > > +     &dev_attr_eapi_version.attr,
 > > +     &dev_attr_eapi_id.attr,
 > > +     &dev_attr_boot_count.attr,
 > > +     &dev_attr_powerup_hour.attr,
 > > +     NULL
 > > +};
 > > +
 > > +static const struct attribute_group attr_group = {
 > > +     .attrs = pmc_attrs,
 > > +};
 > > +
 > > +static const struct attribute_group *attr_groups[] = {
 > > +     &attr_group,
 > > +     NULL
 > > +};
 >
 > Pretty sure there are helper MACROS for this.

Yes, there are. Is the following okay?

     #define PMC_DEVICE_ATTR_RO(_name) \
     static ssize_t _name##_show(struct device *dev, struct 
device_attribute *attr, char *buf) \
     { \
         return info_show(dev, attr, buf);\
     } \
     static DEVICE_ATTR_RO(_name)

     PMC_DEVICE_ATTR_RO(board_name);
     PMC_DEVICE_ATTR_RO(board_serial);
     PMC_DEVICE_ATTR_RO(board_manufacturer);
     PMC_DEVICE_ATTR_RO(firmware_version);
     PMC_DEVICE_ATTR_RO(firmware_build);
     PMC_DEVICE_ATTR_RO(firmware_date);
     PMC_DEVICE_ATTR_RO(chip_id);
     PMC_DEVICE_ATTR_RO(chip_detect);
     PMC_DEVICE_ATTR_RO(platform_type);
     PMC_DEVICE_ATTR_RO(platform_revision);
     PMC_DEVICE_ATTR_RO(board_id);
     PMC_DEVICE_ATTR_RO(eapi_version);
     PMC_DEVICE_ATTR_RO(eapi_id);
     PMC_DEVICE_ATTR_RO(boot_count);
     PMC_DEVICE_ATTR_RO(powerup_hour);

     static struct attribute *pmc_attrs[] = {
         &dev_attr_board_name.attr,
         &dev_attr_board_serial.attr,
         &dev_attr_board_manufacturer.attr,
         &dev_attr_firmware_version.attr,
         &dev_attr_firmware_build.attr,
         &dev_attr_firmware_date.attr,
         &dev_attr_chip_id.attr,
         &dev_attr_chip_detect.attr,
         &dev_attr_platform_type.attr,
         &dev_attr_platform_revision.attr,
         &dev_attr_board_id.attr,
         &dev_attr_eapi_version.attr,
         &dev_attr_eapi_id.attr,
         &dev_attr_boot_count.attr,
         &dev_attr_powerup_hour.attr,
         NULL
     };

     ATTRIBUTE_GROUPS(pmc);

 >
 > > +static struct isa_driver eiois200_driver = {
 > > +     .probe    = eiois200_probe,
 > > +
 > > +     .driver = {
 > > +             .owner = THIS_MODULE,
 >
 > Are you sure the class doesn't do this for you?

You are right. I'll remove it.

 >
 > > +             .name  = KBUILD_MODNAME,
 >
 > Use a proper string.

Is the following acceptable?

     static struct isa_driver eiois200_driver = {
         .probe    = eiois200_probe,

         .driver = {
             .name = "eiois200_core",
             .dev_groups = pmc_groups,
         },
     };
     module_isa_driver(eiois200_driver, 1);

 >
 > > +             .dev_groups = attr_groups,
 > > +     },
 > > +};
 > > +
 > > +module_isa_driver(eiois200_driver, 1);
 > > +
 > > +MODULE_AUTHOR("susi.driver <susi.driver@advantech.com.tw>");
 >
 > This does not match the credentials above.

You are right. I should use 'Wenkai <advantech.susiteam@gmail.com>', Right?

 >
 > > +MODULE_DESCRIPTION("Advantech EIO-IS200 series EC core driver");
 > > +MODULE_LICENSE("GPL v2");
 > > --
 > > 2.34.1
 > >
 >
 > --
 > Lee Jones [李琼斯]
