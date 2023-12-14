Return-Path: <linux-kernel+bounces-99-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D8B813C2B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7FFF1C21BD0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 20:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856446A359;
	Thu, 14 Dec 2023 20:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kg840nMc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97346A327;
	Thu, 14 Dec 2023 20:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d351cb8b82so12721145ad.3;
        Thu, 14 Dec 2023 12:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702587434; x=1703192234; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=0bl0BDka16rF1KS07CbpjvOHtTWbPOB8yzaw2t9ApIc=;
        b=Kg840nMc8g8O02ouwfKspz4MR709/w3n/9m6RJkvqMwdwa9B6eA8ssVh6ReaRwgHMY
         ICh+T2TKrg0Grb6jkvETqt3HA6ZzOdbRXLUHgStBibn39+TUXKDyKwOGOXBWuMVeG3ax
         0VnfMJlG+2MHr2T+t6cegxHpWLgaDMtiRbnv3i0kIDVFTJA0R9cYrzM7N3HkHPFuFs4c
         bVwC0sj+OZyepn+Gos1/ncSes20dJK22/fmIjW9prPH9z7YJwx0lQdFGY/F+Co5oOaGc
         WKg0hbjln3mMSvixfQHDeq1sPrSmiMa7TvCVoK1bVwNuof4utzH4zJGEqFii1/u+tcKK
         XZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702587434; x=1703192234;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0bl0BDka16rF1KS07CbpjvOHtTWbPOB8yzaw2t9ApIc=;
        b=uyRXU4qSF55y0uFK59+qyRqg6Cv96nlWC/Fr3F+Qk5JXNxOBckpV4vECWQBJyH1il6
         daw5Fl1ORBKRrJtT0lP35zA709CDYHg0GZP4WBdXodG+PipmTfi8V9avJdhdcRu6EPUZ
         L1BqQ4o6B+jMm6nRQ4ki9pCgdlxfMWM6V3BwmdRbu1HrfoeR+MPM/2615mZo8CNkZe90
         85+5LaUhOdeH8qgWwaoHMWPSiq41KfxBxFO0DA8qJe61czVPsR1gCYMgsNjEDqeRRa+V
         vbEsk3z1K1k5/H+PKORAxE2ghdmMrHTxYG9zYUjmTdO/OU2aPM2zYjFmi2C8rTTG7v1T
         wIfA==
X-Gm-Message-State: AOJu0Yx/BHShPJtMYtMNnzZT80Mzcef41W0N3v6d5so1tHraQZO1UK7p
	6LTJN5Alm5Uzm/Bg69lqmIs=
X-Google-Smtp-Source: AGHT+IHFeqNTMR2/YGQqXpf+BNT+F4tNqlIwRvoSfW/sYeWY79m/lQ+2LAT9+nSJ6tOvT2Sr/YLKFw==
X-Received: by 2002:a17:903:2344:b0:1d0:76f4:e41b with SMTP id c4-20020a170903234400b001d076f4e41bmr6076157plh.45.1702587433682;
        Thu, 14 Dec 2023 12:57:13 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g13-20020a170902d5cd00b001d1d6f6b67dsm12870034plh.147.2023.12.14.12.57.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 12:57:12 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <32806071-7fc1-4f5a-a9ca-99dd9c8f3fb4@roeck-us.net>
Date: Thu, 14 Dec 2023 12:57:10 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] hwmon: Add driver for Astera Labs PT5161L retimer
Content-Language: en-US
To: Cosmo Chou <chou.cosmo@gmail.com>, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, jdelvare@suse.com,
 corbet@lwn.net, broonie@kernel.org, naresh.solanki@9elements.com,
 vincent@vtremblay.dev, patrick.rudolph@9elements.com,
 luca.ceresoli@bootlin.com, bhelgaas@google.com, festevam@denx.de,
 alexander.stein@ew.tq-group.com, heiko@sntech.de, jernej.skrabec@gmail.com,
 macromorgan@hotmail.com, forbidden405@foxmail.com, sre@kernel.org,
 linus.walleij@linaro.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 cosmo.chou@quantatw.com
References: <20231214060552.2852761-1-chou.cosmo@gmail.com>
 <20231214060552.2852761-4-chou.cosmo@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAlVcphcFCRmg06EACgkQyx8mb86fmYFg0RAA
 nzXJzuPkLJaOmSIzPAqqnutACchT/meCOgMEpS5oLf6xn5ySZkl23OxuhpMZTVX+49c9pvBx
 hpvl5bCWFu5qC1jC2eWRYU+aZZE4sxMaAGeWenQJsiG9lP8wkfCJP3ockNu0ZXXAXwIbY1O1
 c+l11zQkZw89zNgWgKobKzrDMBFOYtAh0pAInZ9TSn7oA4Ctejouo5wUugmk8MrDtUVXmEA9
 7f9fgKYSwl/H7dfKKsS1bDOpyJlqhEAH94BHJdK/b1tzwJCFAXFhMlmlbYEk8kWjcxQgDWMu
 GAthQzSuAyhqyZwFcOlMCNbAcTSQawSo3B9yM9mHJne5RrAbVz4TWLnEaX8gA5xK3uCNCeyI
 sqYuzA4OzcMwnnTASvzsGZoYHTFP3DQwf2nzxD6yBGCfwNGIYfS0i8YN8XcBgEcDFMWpOQhT
 Pu3HeztMnF3HXrc0t7e5rDW9zCh3k2PA6D2NV4fews9KDFhLlTfCVzf0PS1dRVVWM+4jVl6l
 HRIAgWp+2/f8dx5vPc4Ycp4IsZN0l1h9uT7qm1KTwz+sSl1zOqKD/BpfGNZfLRRxrXthvvY8
 BltcuZ4+PGFTcRkMytUbMDFMF9Cjd2W9dXD35PEtvj8wnEyzIos8bbgtLrGTv/SYhmPpahJA
 l8hPhYvmAvpOmusUUyB30StsHIU2LLccUPPOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAlVcpi8FCRmg08MACgkQyx8mb86fmYHNRQ/+
 J0OZsBYP4leJvQF8lx9zif+v4ZY/6C9tTcUv/KNAE5leyrD4IKbnV4PnbrVhjq861it/zRQW
 cFpWQszZyWRwNPWUUz7ejmm9lAwPbr8xWT4qMSA43VKQ7ZCeTQJ4TC8kjqtcbw41SjkjrcTG
 wF52zFO4bOWyovVAPncvV9eGA/vtnd3xEZXQiSt91kBSqK28yjxAqK/c3G6i7IX2rg6pzgqh
 hiH3/1qM2M/LSuqAv0Rwrt/k+pZXE+B4Ud42hwmMr0TfhNxG+X7YKvjKC+SjPjqp0CaztQ0H
 nsDLSLElVROxCd9m8CAUuHplgmR3seYCOrT4jriMFBtKNPtj2EE4DNV4s7k0Zy+6iRQ8G8ng
 QjsSqYJx8iAR8JRB7Gm2rQOMv8lSRdjva++GT0VLXtHULdlzg8VjDnFZ3lfz5PWEOeIMk7Rj
 trjv82EZtrhLuLjHRCaG50OOm0hwPSk1J64R8O3HjSLdertmw7eyAYOo4RuWJguYMg5DRnBk
 WkRwrSuCn7UG+qVWZeKEsFKFOkynOs3pVbcbq1pxbhk3TRWCGRU5JolI4ohy/7JV1TVbjiDI
 HP/aVnm6NC8of26P40Pg8EdAhajZnHHjA7FrJXsy3cyIGqvg9os4rNkUWmrCfLLsZDHD8FnU
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20231214060552.2852761-4-chou.cosmo@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/13/23 22:05, Cosmo Chou wrote:
> This driver implements support for temperature monitoring of Astera Labs
> PT5161L series PCIe retimer chips.
> 
> This driver implementation originates from the CSDK available at
> Link: https://github.com/facebook/openbmc/tree/helium/common/recipes-lib/retimer-v2.14
> The communication protocol utilized is based on the I2C/SMBus standard.
> 
> Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>
> ---
>   Documentation/hwmon/index.rst   |   1 +
>   Documentation/hwmon/pt5161l.rst |  42 +++
>   MAINTAINERS                     |   7 +
>   drivers/hwmon/Kconfig           |  10 +
>   drivers/hwmon/Makefile          |   1 +
>   drivers/hwmon/pt5161l.c         | 558 ++++++++++++++++++++++++++++++++
>   6 files changed, 619 insertions(+)
>   create mode 100644 Documentation/hwmon/pt5161l.rst
>   create mode 100644 drivers/hwmon/pt5161l.c
> 
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index 72f4e6065bae..f145652098fc 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -181,6 +181,7 @@ Hardware Monitoring Kernel Drivers
>      pmbus
>      powerz
>      powr1220
> +   pt5161l
>      pxe1610
>      pwm-fan
>      q54sj108a2
> diff --git a/Documentation/hwmon/pt5161l.rst b/Documentation/hwmon/pt5161l.rst
> new file mode 100644
> index 000000000000..5f4ce3b2f38d
> --- /dev/null
> +++ b/Documentation/hwmon/pt5161l.rst
> @@ -0,0 +1,42 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +Kernel driver pt5161l
> +=====================
> +
> +Supported chips:
> +
> +  * Astera Labs PT5161L
> +
> +    Prefix: 'pt5161l'
> +
> +    Addresses: I2C 0x24
> +
> +    Datasheet: http://www.asteralabs.com/wp-content/uploads/2021/03/Astera_Labs_PT5161L_Product_Brief.pdf
> +

This is not the datasheet. It is a product brief. This should truthfully say
that the product datasheet is not available to the public.

> +Authors: Cosmo Chou <cosmo.chou@quantatw.com>
> +
> +Description
> +-----------
> +
> +This driver implements support for temperature monitoring of Astera Labs
> +PT5161L series PCIe retimer chips.
> +
> +This driver implementation originates from the CSDK available at
> +https://github.com/facebook/openbmc/tree/helium/common/recipes-lib/retimer-v2.14
> +The communication protocol utilized is based on the I2C/SMBus standard.
> +
> +Sysfs entries
> +----------------
> +
> +================ ==============================================
> +temp1_input      Measured temperature (in millidegrees Celsius)
> +================ ==============================================
> +
> +Debugfs entries
> +----------------
> +
> +================ ===============================
> +fw_load_status   Firmware load status
> +fw_ver           Firmware version of the retimer
> +heartbeat_status Heartbeat status
> +================ ===============================
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e2c6187a3ac8..8def71ca2ace 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17421,6 +17421,13 @@ F:	fs/pstore/
>   F:	include/linux/pstore*
>   K:	\b(pstore|ramoops)
>   
> +PT5161L HARDWARE MONITOR DRIVER
> +M:	Cosmo Chou <cosmo.chou@quantatw.com>
> +L:	linux-hwmon@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/hwmon/pt5161l.rst
> +F:	drivers/hwmon/pt5161l.c
> +
>   PTP HARDWARE CLOCK SUPPORT
>   M:	Richard Cochran <richardcochran@gmail.com>
>   L:	netdev@vger.kernel.org
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index cf27523eed5a..ccdbcf12aed3 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1703,6 +1703,16 @@ source "drivers/hwmon/peci/Kconfig"
>   
>   source "drivers/hwmon/pmbus/Kconfig"
>   
> +config SENSORS_PT5161L
> +	tristate "Astera Labs PT5161L PCIe retimer hardware monitoring"
> +	depends on I2C
> +	help
> +	  If you say yes here you get support for temperature monitoring
> +	  on the Astera Labs PT5161L PCIe retimer.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called pt5161l.
> +
>   config SENSORS_PWM_FAN
>   	tristate "PWM fan"
>   	depends on (PWM && OF) || COMPILE_TEST
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index e84bd9685b5c..4e68b808ddac 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -179,6 +179,7 @@ obj-$(CONFIG_SENSORS_PC87427)	+= pc87427.o
>   obj-$(CONFIG_SENSORS_PCF8591)	+= pcf8591.o
>   obj-$(CONFIG_SENSORS_POWERZ)	+= powerz.o
>   obj-$(CONFIG_SENSORS_POWR1220)  += powr1220.o
> +obj-$(CONFIG_SENSORS_PT5161L)	+= pt5161l.o
>   obj-$(CONFIG_SENSORS_PWM_FAN)	+= pwm-fan.o
>   obj-$(CONFIG_SENSORS_RASPBERRYPI_HWMON)	+= raspberrypi-hwmon.o
>   obj-$(CONFIG_SENSORS_SBTSI)	+= sbtsi_temp.o
> diff --git a/drivers/hwmon/pt5161l.c b/drivers/hwmon/pt5161l.c
> new file mode 100644
> index 000000000000..95e7fb07699c
> --- /dev/null
> +++ b/drivers/hwmon/pt5161l.c
> @@ -0,0 +1,558 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#include <linux/debugfs.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/hwmon.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +
> +/* Temperature measurement constants */
> +// Aries current average temp ADC code CSR

Please decide if you want to use C++ or C comments throughout.

> +#define ARIES_CURRENT_AVG_TEMP_ADC_CSR	0x42c
> +
> +// Main Micro Heartbeat reg
> +#define ARIES_MM_HEARTBEAT_ADDR	0x923
> +
> +/* Main SRAM */
> +// AL Main SRAM DMEM offset (A0)
> +#define AL_MAIN_SRAM_DMEM_OFFSET	(64 * 1024)
> +// SRAM read command
> +#define AL_TG_RD_LOC_IND_SRAM	0x16
> +
> +/* Micros */
> +// Offset for main micro FW info
> +#define ARIES_MAIN_MICRO_FW_INFO	(96 * 1024 - 128)
> +
> +/* Path Micro Members */
> +// FW Info (Major) offset location in struct
> +#define ARIES_MM_FW_VERSION_MAJOR	0
> +// FW Info (Minor) offset location in struct
> +#define ARIES_MM_FW_VERSION_MINOR	1
> +// FW Info (Build no.) offset location in struct
> +#define ARIES_MM_FW_VERSION_BUILD	2
> +
> +/* Offsets for MM assisted accesses */
> +// Legacy Address and Data registers (using wide registers)
> +// Reg offset to specify Address for MM assisted accesses
> +#define ARIES_MM_ASSIST_REG_ADDR_OFFSET	0xd99
> +
> +/* Misc block offsets */
> +// Device Load check register
> +#define ARIES_CODE_LOAD_REG	0x605
> +
> +/* Value indicating FW was loaded properly */
> +#define ARIES_LOAD_CODE	0xe
> +
> +#define ARIES_TEMP_CAL_CODE_DEFAULT	84
> +
> +/* Struct defining FW version loaded on an Aries device */
> +struct pt5161l_fw_ver {
> +	u8 major;
> +	u8 minor;
> +	u16 build;
> +};
> +
> +/* Each client has this additional data */
> +struct pt5161l_data {
> +	struct i2c_client *client;
> +	struct dentry *debugfs;
> +	struct pt5161l_fw_ver fw_ver;
> +	struct mutex lock;
> +	bool pec_enable;

What is the point of this variable ? It is never set.

> +	bool code_load_okay; // indicate if code load reg value is expected
> +	bool mm_heartbeat_okay; // indicate if Main Micro heartbeat is good
> +};
> +
> +static struct dentry *pt5161l_debugfs_dir;
> +
> +/*
> + * Write multiple data bytes to Aries over I2C
> + */
> +static int pt5161l_write_block_data(struct pt5161l_data *data, u32 address,
> +				    u8 len, u8 *val)
> +{
> +	struct i2c_client *client = data->client;
> +	int ret;
> +	u8 remain_len = len;
> +	u8 xfer_len, curr_len;
> +	u8 buf[16];
> +	u8 cmd = 0x0F; // [7]:pec_en, [6:5]:rsvd, [4:2]:func, [1]:start, [0]:end
> +	u8 config = 0x40; // [6]:cfg_type, [4:1]:burst_len, [0]:bit16 of address
> +
> +	if (data->pec_enable)
> +		cmd |= 0x80;
> +

Too bad the datasheet isn't public. It is kind of weird to "enable" PEC this
way. How is it checked if enabled ? How does the i2c subsystem know that it
is enabled, and what happens if PEC _is_ actually enabled ?

> +	while (remain_len > 0) {
> +		if (remain_len > 4) {
> +			curr_len = 4;
> +			remain_len -= 4;
> +		} else {
> +			curr_len = remain_len;
> +			remain_len = 0;
> +		}
> +
> +		buf[0] = config | (curr_len - 1) << 1 | ((address >> 16) & 0x1);
> +		buf[1] = (address >> 8) & 0xff;
> +		buf[2] = address & 0xff;
> +		memcpy(&buf[3], val, curr_len);
> +
> +		xfer_len = 3 + curr_len;
> +		ret = i2c_smbus_write_block_data(client, cmd, xfer_len, buf);
> +		if (ret)
> +			return ret;
> +
> +		val += curr_len;
> +		address += curr_len;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Read multiple data bytes from Aries over I2C
> + */
> +static int pt5161l_read_block_data(struct pt5161l_data *data, u32 address,
> +				   u8 len, u8 *val)
> +{
> +	struct i2c_client *client = data->client;
> +	int ret, tries;
> +	u8 remain_len = len;
> +	u8 curr_len;
> +	u8 wbuf[16], rbuf[24];
> +	u8 cmd = 0x08; // [7]:pec_en, [6:5]:rsvd, [4:2]:func, [1]:start, [0]:end
> +	u8 config = 0x00; // [6]:cfg_type, [4:1]:burst_len, [0]:bit16 of address
> +
> +	if (data->pec_enable)
> +		cmd |= 0x80;
> +
> +	while (remain_len > 0) {
> +		if (remain_len > 16) {
> +			curr_len = 16;
> +			remain_len -= 16;
> +		} else {
> +			curr_len = remain_len;
> +			remain_len = 0;
> +		}
> +
> +		wbuf[0] = config | (curr_len - 1) << 1 |
> +			  ((address >> 16) & 0x1);
> +		wbuf[1] = (address >> 8) & 0xff;
> +		wbuf[2] = address & 0xff;
> +
> +		for (tries = 0; tries < 3; tries++) {
> +			ret = i2c_smbus_write_block_data(client, (cmd | 0x2), 3,
> +							 wbuf);
> +			if (ret)
> +				return ret;
> +
> +			ret = i2c_smbus_read_block_data(client, (cmd | 0x1),
> +							rbuf);
> +			if (ret == curr_len)
> +				break;
> +		}

For code like this it would be really useful to see the datasheet.
Those transfers are pretty odd. Does the chip really not support
standard SMBus read/write commands ?

> +		if (tries >= 3)
> +			return -ENODATA;

Is this an appropriate error ? -ENODATA means that no data was available.
Sure, after an error no data will be available, but that doesn't really reflect
the error. Why not return the error reported by the i2c subsystem ?

> +
> +		memcpy(val, rbuf, curr_len);
> +		val += curr_len;
> +		address += curr_len;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Read multiple (up to eight) data bytes from micro SRAM over I2C
> + */
> +static int
> +pt5161l_read_block_data_main_micro_indirect(struct pt5161l_data *data,
> +					    u32 address, u8 len, u8 *val)
> +{
> +	int ret, tries;
> +	u8 buf[8];
> +	u8 i, status;
> +	u32 uind_offs = ARIES_MM_ASSIST_REG_ADDR_OFFSET;
> +	u32 eeprom_base, eeprom_addr;
> +
> +	// No multi-byte indirect support here. Hence read a byte at a time
> +	eeprom_base = address - AL_MAIN_SRAM_DMEM_OFFSET;
> +	for (i = 0; i < len; i++) {
> +		eeprom_addr = eeprom_base + i;
> +		buf[0] = eeprom_addr & 0xff;
> +		buf[1] = (eeprom_addr >> 8) & 0xff;
> +		buf[2] = (eeprom_addr >> 16) & 0xff;
> +		ret = pt5161l_write_block_data(data, uind_offs, 3, buf);
> +		if (ret)
> +			return ret;
> +
> +		buf[0] = AL_TG_RD_LOC_IND_SRAM;
> +		ret = pt5161l_write_block_data(data, uind_offs + 4, 1, buf);
> +		if (ret)
> +			return ret;
> +
> +		status = 0xff;
> +		for (tries = 0; tries < 255; tries++) {
> +			ret = pt5161l_read_block_data(data, uind_offs + 4, 1,
> +						      &status);
> +			if (ret)
> +				return ret;
> +
> +			if (status == 0)
> +				break;
> +		}
> +		if (status != 0)
> +			return -ETIMEDOUT;
> +
> +		ret = pt5161l_read_block_data(data, uind_offs + 3, 1, buf);
> +		if (ret)
> +			return ret;
> +
> +		val[i] = buf[0];
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Check firmware load status
> + */
> +static int pt5161l_fw_load_check(struct pt5161l_data *data)
> +{
> +	int ret;
> +	u8 buf[8];
> +
> +	ret = pt5161l_read_block_data(data, ARIES_CODE_LOAD_REG, 1, buf);
> +	if (ret)
> +		return ret;
> +
> +	if (buf[0] < ARIES_LOAD_CODE) {


What if it reports, say, 0x0f or 0x55 ?

> +		dev_dbg(&data->client->dev,
> +			"Code Load reg unexpected. Not all modules are loaded %x\n",
> +			buf[0]);
> +		data->code_load_okay = false;
> +	} else {
> +		data->code_load_okay = true;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Check main micro heartbeat
> + */
> +static int pt5161l_heartbeat_check(struct pt5161l_data *data)
> +{
> +	int ret, tries;
> +	u8 buf[8];
> +	u8 heartbeat;
> +	bool hb_changed = false;
> +
> +	ret = pt5161l_read_block_data(data, ARIES_MM_HEARTBEAT_ADDR, 1, buf);
> +	if (ret)
> +		return ret;
> +
> +	heartbeat = buf[0];
> +	for (tries = 0; tries < 100; tries++) {
> +		ret = pt5161l_read_block_data(data, ARIES_MM_HEARTBEAT_ADDR, 1,
> +					      buf);
> +		if (ret)
> +			return ret;
> +
> +		if (buf[0] != heartbeat) {
> +			hb_changed = true;
> +			break;
> +		}

This makes the code really CPU speed dependent. Is this intentional ?

> +	}
> +	data->mm_heartbeat_okay = hb_changed;
> +
> +	return 0;
> +}
> +
> +/*
> + * Check the status of firmware
> + */
> +static int pt5161l_fwsts_check(struct pt5161l_data *data)
> +{
> +	int ret;
> +	u8 buf[8];
> +	u8 major = 0, minor = 0;
> +	u16 build = 0;
> +
> +	ret = pt5161l_fw_load_check(data);
> +	if (ret)
> +		return ret;
> +
> +	ret = pt5161l_heartbeat_check(data);
> +	if (ret)
> +		return ret;
> +
> +	if (data->code_load_okay && data->mm_heartbeat_okay) {
> +		ret = pt5161l_read_block_data_main_micro_indirect(
> +			data,
> +			ARIES_MAIN_MICRO_FW_INFO + ARIES_MM_FW_VERSION_MAJOR, 1,
> +			&major);
> +		if (ret)
> +			return ret;
> +
> +		ret = pt5161l_read_block_data_main_micro_indirect(
> +			data,
> +			ARIES_MAIN_MICRO_FW_INFO + ARIES_MM_FW_VERSION_MINOR, 1,
> +			&minor);
> +		if (ret)
> +			return ret;
> +
> +		ret = pt5161l_read_block_data_main_micro_indirect(
> +			data,
> +			ARIES_MAIN_MICRO_FW_INFO + ARIES_MM_FW_VERSION_BUILD, 2,
> +			buf);
> +		if (ret)
> +			return ret;
> +		build = buf[1] << 8 | buf[0];
> +	}
> +	data->fw_ver.major = major;
> +	data->fw_ver.minor = minor;
> +	data->fw_ver.build = build;
> +
> +	return 0;
> +}
> +
> +static int pt5161l_read(struct device *dev, enum hwmon_sensor_types type,
> +			u32 attr, int channel, long *val)
> +{
> +	struct pt5161l_data *data = dev_get_drvdata(dev);
> +	int ret = 0;
> +	u8 buf[8];
> +	long adc_code = 0;
> +
> +	switch (attr) {
> +	case hwmon_temp_input:
> +		mutex_lock(&data->lock);
> +		ret = pt5161l_read_block_data(
> +			data, ARIES_CURRENT_AVG_TEMP_ADC_CSR, 4, buf);
> +		mutex_unlock(&data->lock);
> +		adc_code = buf[3] << 24 | buf[2] << 16 | buf[1] << 8 | buf[0];
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +	if (ret) {
> +		dev_dbg(dev, "Read adc_code failed %d\n", ret);
> +		return ret;
> +	}

I fail to see why it would make sense to have the error check here,
after the potentially uninitialized content of buf[] is converted.

> +	if (adc_code == 0 || adc_code >= 0x3ff) {
> +		dev_dbg(dev, "Invalid adc_code %lx\n", adc_code);
> +		return -ENODATA;

"No data available" is not an appropriate error.

> +	}
> +
> +	*val = 110000 +
> +	       ((adc_code - (ARIES_TEMP_CAL_CODE_DEFAULT + 250)) * -320);
> +
> +	return 0;
> +}
> +
> +static umode_t pt5161l_is_visible(const void *data,
> +				  enum hwmon_sensor_types type, u32 attr,
> +				  int channel)
> +{
> +	switch (attr) {
> +	case hwmon_temp_input:
> +		return 0444;
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct hwmon_channel_info *pt5161l_info[] = {
> +	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT),
> +	NULL
> +};
> +
> +static const struct hwmon_ops pt5161l_hwmon_ops = {
> +	.is_visible = pt5161l_is_visible,
> +	.read = pt5161l_read,
> +};
> +
> +static const struct hwmon_chip_info pt5161l_chip_info = {
> +	.ops = &pt5161l_hwmon_ops,
> +	.info = pt5161l_info,
> +};
> +
> +static ssize_t pt5161l_debugfs_read_fw_ver(struct file *file, char __user *buf,
> +					   size_t count, loff_t *ppos)
> +{
> +	struct pt5161l_data *data = file->private_data;
> +	int ret;
> +	char ver[32];
> +
> +	mutex_lock(&data->lock);
> +	ret = pt5161l_fwsts_check(data);
> +	mutex_unlock(&data->lock);
> +	if (ret)
> +		return ret;
> +
> +	ret = snprintf(ver, sizeof(ver), "%u.%u.%u\n", data->fw_ver.major,
> +		       data->fw_ver.minor, data->fw_ver.build);
> +	if (ret < 0)
> +		return ret;
> +
> +	return simple_read_from_buffer(buf, count, ppos, ver, ret + 1);
> +}
> +
> +static const struct file_operations pt5161l_debugfs_ops_fw_ver = {
> +	.read = pt5161l_debugfs_read_fw_ver,
> +	.open = simple_open,
> +};
> +
> +static ssize_t pt5161l_debugfs_read_fw_load_sts(struct file *file,
> +						char __user *buf, size_t count,
> +						loff_t *ppos)
> +{
> +	struct pt5161l_data *data = file->private_data;
> +	int ret;
> +	bool status = false;
> +	char health[16];
> +
> +	mutex_lock(&data->lock);
> +	ret = pt5161l_fw_load_check(data);
> +	mutex_unlock(&data->lock);
> +	if (ret == 0)
> +		status = data->code_load_okay;
> +
> +	ret = snprintf(health, sizeof(health), "%s\n",
> +		       status ? "normal" : "abnormal");
> +	if (ret < 0)
> +		return ret;
> +
> +	return simple_read_from_buffer(buf, count, ppos, health, ret + 1);
> +}
> +
> +static const struct file_operations pt5161l_debugfs_ops_fw_load_sts = {
> +	.read = pt5161l_debugfs_read_fw_load_sts,
> +	.open = simple_open,
> +};
> +
> +static ssize_t pt5161l_debugfs_read_hb_sts(struct file *file, char __user *buf,
> +					   size_t count, loff_t *ppos)
> +{
> +	struct pt5161l_data *data = file->private_data;
> +	int ret;
> +	bool status = false;
> +	char health[16];
> +
> +	mutex_lock(&data->lock);
> +	ret = pt5161l_heartbeat_check(data);
> +	mutex_unlock(&data->lock);
> +	if (ret == 0)
> +		status = data->mm_heartbeat_okay;
> +
> +	ret = snprintf(health, sizeof(health), "%s\n",
> +		       status ? "normal" : "abnormal");
> +	if (ret < 0)
> +		return ret;
> +
> +	return simple_read_from_buffer(buf, count, ppos, health, ret + 1);
> +}
> +
> +static const struct file_operations pt5161l_debugfs_ops_hb_sts = {
> +	.read = pt5161l_debugfs_read_hb_sts,
> +	.open = simple_open,
> +};
> +
> +static int pt5161l_init_debugfs(struct pt5161l_data *data)
> +{
> +	data->debugfs = debugfs_create_dir(dev_name(&data->client->dev),
> +					   pt5161l_debugfs_dir);
> +
> +	debugfs_create_file("fw_ver", 0444, data->debugfs, data,
> +			    &pt5161l_debugfs_ops_fw_ver);
> +
> +	debugfs_create_file("fw_load_status", 0444, data->debugfs, data,
> +			    &pt5161l_debugfs_ops_fw_load_sts);
> +
> +	debugfs_create_file("heartbeat_status", 0444, data->debugfs, data,
> +			    &pt5161l_debugfs_ops_hb_sts);
> +
> +	return 0;
> +}
> +
> +static int pt5161l_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct device *hwmon_dev;
> +	struct pt5161l_data *data;
> +
> +	data = devm_kzalloc(dev, sizeof(struct pt5161l_data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->client = client;
> +	mutex_init(&data->lock);
> +	dev_set_drvdata(dev, data);
> +
> +	hwmon_dev = devm_hwmon_device_register_with_info(
> +		dev, client->name, data, &pt5161l_chip_info, NULL);
> +
> +	pt5161l_init_debugfs(data);

This should still result in crashes if a device is instantiated (for example
with new_device) and then removed (for example with delete_device).

> +
> +	return PTR_ERR_OR_ZERO(hwmon_dev);
> +}
> +
> +static void pt5161l_remove(struct i2c_client *client)
> +{
> +	struct pt5161l_data *data = i2c_get_clientdata(client);
> +
> +	debugfs_remove_recursive(data->debugfs);
> +}
> +
> +static const struct of_device_id __maybe_unused pt5161l_of_match[] = {
> +	{ .compatible = "asteralabs,pt5161l" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, pt5161l_of_match);
> +
> +static const struct acpi_device_id pt5161l_acpi_match[] = {

Guess the __maybe_unused applies here as well.

> +	{ "PT5161L", 0 },

Is that an official ACPI ID ? It doesn't look like one to me. ACPI IDs
are supposed to be 8 characters long. I don't find a vendor ID for Astera,
and it seems unlikely that it is "PT51". The model number is supposed
to be a 4-digit hex string, and "61L" is neither. If it is supposed
to be a PNP ID, that doesn't look correct either. "PT5" is not a valid
PNP ID, and "161L" is not a valid PNP product ID.

> +	{},
> +};
> +MODULE_DEVICE_TABLE(acpi, pt5161l_acpi_match);
> +
> +static const struct i2c_device_id pt5161l_id[] = {
> +	{ "pt5161l", 0 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, pt5161l_id);
> +
> +static struct i2c_driver pt5161l_driver = {
> +	.class = I2C_CLASS_HWMON,
> +	.driver = {
> +		.name = "pt5161l",
> +		.of_match_table = of_match_ptr(pt5161l_of_match),
> +		.acpi_match_table = ACPI_PTR(pt5161l_acpi_match),
> +	},
> +	.probe = pt5161l_probe,
> +	.remove = pt5161l_remove,
> +	.id_table = pt5161l_id,
> +};
> +
> +static int __init pt5161l_init(void)
> +{
> +	pt5161l_debugfs_dir = debugfs_create_dir("pt5161l", NULL);
> +	return i2c_add_driver(&pt5161l_driver);
> +}
> +
> +static void __exit pt5161l_exit(void)
> +{
> +	debugfs_remove_recursive(pt5161l_debugfs_dir);
> +	i2c_del_driver(&pt5161l_driver);
> +}
> +
> +module_init(pt5161l_init);
> +module_exit(pt5161l_exit);
> +
> +MODULE_AUTHOR("Cosmo Chou <cosmo.chou@quantatw.com>");
> +MODULE_DESCRIPTION("Hwmon driver for Astera Labs Aries PCIe retimer");
> +MODULE_LICENSE("GPL");


