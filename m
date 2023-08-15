Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C3A77CF7F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 17:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238254AbjHOPp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 11:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238281AbjHOPpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 11:45:42 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC3410FF;
        Tue, 15 Aug 2023 08:45:41 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-3490cce329bso12932845ab.0;
        Tue, 15 Aug 2023 08:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692114341; x=1692719141;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AolyIW6tstki/bK3nO0nCYiOm1GCDbV1AqXISy+qNQU=;
        b=KIcvToH45hj1aIzaF/gTzjl7gWRs0wm63jp3rmOWSrEHDGDEzG4tQF7dq3jxFUxn7E
         V7sLcHxZdz9oJvk/CBLEHlygyc3hmXHH+iFYaBtzOsFPSRZtVBiDrf+0KSO83ZerCdVw
         SNyjT54UbAuw90wYbNuGnRZqZ0kLqMO4g7RTFUgBdVifHCB/gzZGo74O74rVuIgDM/Gu
         69ev71trf6HdrEIMiZVtnBL/qM+S/pQ+zdCMVtKOutnu+he5MKevZh15Q1spkpVSu+zL
         Ji7xhs6HKbmm+8j1vPTfOz7V0D7/GTuJaEvxKM26P+pK895iFp9TsNek6Utk55vKXJ4q
         dTnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692114341; x=1692719141;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AolyIW6tstki/bK3nO0nCYiOm1GCDbV1AqXISy+qNQU=;
        b=MU1o/2DmxQswyHw5/QLa2kg9NiMF/OiIT6NmPAMrashjDhkaEN62yIFT/J9sCZ/e/M
         fdG/h1Q+MhDg8seBlSOhOnEmEp/SS9af8ic48axMTcjAOBwA5WZP21cSUfQ/2SsakyzO
         KlAEM3opTM03DFarDZjfBYsoqLPDgCDfDJwCg1h3J+Ny4g6RQJ1LCHGWEdjcwUx/mi2u
         iRoBJThx6/J3T2t5x0bF+pTTtQiPNWO9wOo1fMlknG9K/IC3/gIdnCD6L9V46NkjX/aT
         rjgGdGw5ZBQMr0Y7V/Ithh0k6G2UVeN39nk5OxO1udKl+H50DiQk/Y6f/SP/A5A1gBqI
         MRAg==
X-Gm-Message-State: AOJu0Yxv8CJ0VPR66RfaZCf0LxT6v94tosWlHB3zwSnFO8vao49iycjZ
        yUjwu6j4cLMMuwYU7Rg7hQ8=
X-Google-Smtp-Source: AGHT+IFcR1Ai3g2UIS6hZDhKt/nHjYejPR3RC19UI0xYRwrQUwG87hd8pgi3EjH4S+I5PMTUOzh+fw==
X-Received: by 2002:a05:6e02:1527:b0:348:7f18:68be with SMTP id i7-20020a056e02152700b003487f1868bemr3235840ilu.4.1692114340927;
        Tue, 15 Aug 2023 08:45:40 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t17-20020a02ab91000000b00430a20ce88bsm3696891jan.174.2023.08.15.08.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 08:45:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 15 Aug 2023 08:45:39 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Loic Guegan <manzerbredes@mailbox.org>
Cc:     jdelvare@suse.com, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] Adding a driver for the INA260 chip of Texas Instrument.
 It follows the hardware monitoring kernel API.
Message-ID: <2ee4bac8-8114-4c72-9b6c-6038869fb9f2@roeck-us.net>
References: <ZNtWl_Jyj2PWBYpf@lguegan-thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNtWl_Jyj2PWBYpf@lguegan-thinkpad>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 12:42:31PM +0200, Loic Guegan wrote:
> Signed-off-by: Loic Guegan <manzerbredes@mailbox.org>

Subject and description are all wrong. I would suggest to read
and understand the documentation in Documentation/process
as well as Documentation/hwmon/submitting-patches.rst
before resubmitting.

> ---
>  drivers/staging/Kconfig         |   2 +
>  drivers/staging/Makefile        |   1 +
>  drivers/staging/ina260/Kconfig  |   6 +
>  drivers/staging/ina260/Makefile |   6 +
>  drivers/staging/ina260/TODO     |   2 +
>  drivers/staging/ina260/ina260.c | 261 ++++++++++++++++++++++++++++++++

No hwmon patches in drivers/staging/, please.

>  6 files changed, 278 insertions(+)
>  create mode 100644 drivers/staging/ina260/Kconfig
>  create mode 100644 drivers/staging/ina260/Makefile
>  create mode 100644 drivers/staging/ina260/TODO
>  create mode 100755 drivers/staging/ina260/ina260.c
> 
> diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
> index f9aef39ca..e173e4353 100644
> --- a/drivers/staging/Kconfig
> +++ b/drivers/staging/Kconfig
> @@ -78,4 +78,6 @@ source "drivers/staging/qlge/Kconfig"
>  
>  source "drivers/staging/vme_user/Kconfig"
>  
> +source "drivers/staging/ina260/Kconfig"
> +
>  endif # STAGING
> diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
> index ffa70dda4..a1d7e1ddb 100644
> --- a/drivers/staging/Makefile
> +++ b/drivers/staging/Makefile
> @@ -28,3 +28,4 @@ obj-$(CONFIG_PI433)		+= pi433/
>  obj-$(CONFIG_XIL_AXIS_FIFO)	+= axis-fifo/
>  obj-$(CONFIG_FIELDBUS_DEV)     += fieldbus/
>  obj-$(CONFIG_QLGE)		+= qlge/
> +obj-$(CONFIG_INA260)		+= ina260/
> \ No newline at end of file
> diff --git a/drivers/staging/ina260/Kconfig b/drivers/staging/ina260/Kconfig
> new file mode 100644
> index 000000000..e873abc9d
> --- /dev/null
> +++ b/drivers/staging/ina260/Kconfig
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0
> +config INA260
> +	tristate "Support for INA260 Power Monitoring i2c chip"
> +	depends on I2C && REGMAP_I2C
> +	help
> +	  Support for the Texas Instrument INA260 power monitoring chip with precision integrated shunt.
> diff --git a/drivers/staging/ina260/Makefile b/drivers/staging/ina260/Makefile
> new file mode 100644
> index 000000000..d4eeba95e
> --- /dev/null
> +++ b/drivers/staging/ina260/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Makefile for the Texas Instruments INA260 drivers
> +#
> +
> +obj-$(CONFIG_INA260) += ina260.o
> diff --git a/drivers/staging/ina260/TODO b/drivers/staging/ina260/TODO
> new file mode 100644
> index 000000000..2ed5b80c3
> --- /dev/null
> +++ b/drivers/staging/ina260/TODO
> @@ -0,0 +1,2 @@
> +Created on: 15 August 2023
> +Contact: Loic GUEGAN <loic.guegan@mailbox.org>
> \ No newline at end of file
> diff --git a/drivers/staging/ina260/ina260.c b/drivers/staging/ina260/ina260.c
> new file mode 100755
> index 000000000..f827236b8
> --- /dev/null
> +++ b/drivers/staging/ina260/ina260.c
> @@ -0,0 +1,261 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Driver for Texas Instruments INA260 power monitor chip
> + * with precision integrated shunt.
> + * Datasheet: https://www.ti.com/lit/gpn/INA260
> + *
> + * Copyright (C) 2023 GUEGAN Loic <loic.guegan@mailbox.org>
> + */
> +
> +#include "linux/module.h"
> +#include "linux/uaccess.h"
> +#include "linux/i2c.h"
> +#include "linux/kobject.h"
> +#include "linux/slab.h"
> +#include "linux/kernel.h"
> +#include <linux/sysfs.h>
> +#include <linux/hwmon.h>
> +#include <linux/regmap.h>
> +
> +// INA260 registers
> +#define INA260_REG_CONFIGURATION  0x00
> +#define INA260_REG_CURRENT        0x01
> +#define INA260_REG_VOLTAGE        0x02
> +#define INA260_REG_POWER          0x03
> +#define INA260_REG_MASKENABLE     0x06
> +#define INA260_REG_ALERTLIMIT     0x07
> +#define INA260_REG_MANUFACTURER   0xFE
> +#define INA260_REG_DIE            0xFF
> +

The register map is very much identical to ina219, ina220, ina226, ina230,
and ina231, all of which are supported by drivers/hwmon/ina2xx.c.
Please consider adding support for ina260 to that driver.

Guenter
