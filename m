Return-Path: <linux-kernel+bounces-75621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC7485EC13
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF5FB1F24726
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507BF81750;
	Wed, 21 Feb 2024 22:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3Y88hpO"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AD03B2AD;
	Wed, 21 Feb 2024 22:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708556112; cv=none; b=TI9XtIHPdVtTCB7mVsNI/n3XlyK2gsskLHj5HCTCaMIePztRkIKdPNGajq+Ozh1u+ZHH7OQUjbeOm3poQNEovOgSp1ZkehPV7fp8IYfXNOeiTwk/jAro+JKeLrl/o/Jcp+orD4dxHiIrx+Lp0K6bGYoXaYdpcoG6dOIfgE1U47g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708556112; c=relaxed/simple;
	bh=WBhScTVcWgTF5n7+GZjUT+MuddAiwE1gR7nX3o2GBmU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qeg0EVBeXC98EGQdltWhU778ZTMKyJXxhcOFz3lf3wUAJVmZE7jNG8fz/5TPsLzC1cIMd1jHV+z+mH76hPt1mPNjdaWa3N2kAznHIVa0s2xCIn6ZRcdvm1u/6Nnwrop9KQsVIdXL7JQGDZJ3tQV+Lt/gvb3FT716ugJYW5HZz3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3Y88hpO; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2997c5fe6abso883820a91.1;
        Wed, 21 Feb 2024 14:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708556109; x=1709160909; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=7rwmodBfxYiy17gUU45H7KHIT1wScHcDfBe/9mMA44k=;
        b=A3Y88hpOJzxP6QqWgJEg4hpa4xmeQqXzqsCBbsz4s3mGtCxsVuhL+YB8IihOvcTHlz
         Vtx1WYXe+UFmy2Q+lZqUQ4T2ynpcxy3GxNw85qFaFWN3vFbjKXrdBQGNOEhdzN3OP48U
         YYIY16EuyY066G1xFe4YvVHx2Gcjfwa+fmquJ0SLwQQpR2ouO43hgBWyk0DMXZJK3zoR
         pQtxOHZK4S/teEBeHJ19LxPvBiEunsynDoJJrl9soHNc6WWdLjV41akrkxaCEtUa1B1a
         wy2fCPgBfARMuvSalj9+31mowJjysnxnBNVQ3pI1RzLVKpiLan62Du+BJobW2tUWYTgd
         y6Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708556109; x=1709160909;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7rwmodBfxYiy17gUU45H7KHIT1wScHcDfBe/9mMA44k=;
        b=AEA3+54p7DC4rG3NKyd5Ka34otdfTp3yzRnR2ieWwprrw9zU1bRUptp85nJP/CYezs
         RM/AXyGRU3KVgDIDp5J8mhC6Q8ZjjFLWC1kwZkNYZ/WVzx6u8oqAWAgWFVoOCFhonAQH
         7SZQqXyRwEZjC8tLprbwt79Ci083ZiwEgvuhKefoOPwLhycwrs+vrpONoPlXwaVF6nwC
         8b5u0iW+Pyvmtfxc0SDB/tcsefyP2NxbDeT+5ZXCf0Jk1wsxYKgiGHMKBFEL3AxAnrem
         psPIVNAh8knxpxkMXuf5gHoijPraoBDhmtkjlNUHefA5hVKwH4X2QBfWI1jU+ZTUYRRC
         Hl3w==
X-Forwarded-Encrypted: i=1; AJvYcCXPpa3AnLZ/Wkez/ZmRWxol7pis8RsxvIGBlHhPcyM6UPXOfJMKBowWuHdIT2E5UALSRUKL98eZQZFSAmbtBV2QdaxXZRXPniUuxH/sB57AT3RM/MLV5PC0Z5Q32YE+tXoW1jJ2qfBjX9xvRcc2iLymQYyruXGW0UB+lIS3wmMfXzQioSlea0gJd0jPZFyg
X-Gm-Message-State: AOJu0Yz1Pkl+VXabvLjnHczitVhrJJ+ZT8A6qmQ9Qfp8qg3GNtOwayMP
	tQEUg/hvrvsJ2Ii+8IKzuUGtYYxGaIC9vEAhsacmlb1IlTh9DMdT
X-Google-Smtp-Source: AGHT+IG3SLb2WGBg3Rr+szKxu6dFc8v5xn3HjWturR4i2E0POc/UdzX64khru8ftoYfDovHc8Kg5wg==
X-Received: by 2002:a17:90b:4f83:b0:29a:20cf:2f5a with SMTP id qe3-20020a17090b4f8300b0029a20cf2f5amr2649387pjb.26.1708556108745;
        Wed, 21 Feb 2024 14:55:08 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id sx15-20020a17090b2ccf00b00296f3401cabsm2400141pjb.41.2024.02.21.14.55.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 14:55:07 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <042951f1-200f-4d89-b968-ea68c52ea607@roeck-us.net>
Date: Wed, 21 Feb 2024 14:55:06 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Add wmi driver support for Casper Excalibur laptops.
Content-Language: en-US
To: =?UTF-8?Q?Mustafa_Ek=C5=9Fi?= <mustafa.eskieksi@gmail.com>,
 hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-hwmon@vger.kernel.org
Cc: jdelvare@suse.com
References: <20240221221549.640515-1-mustafa.eskieksi@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240221221549.640515-1-mustafa.eskieksi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/21/24 14:15, Mustafa Ekşi wrote:
> Signed-off-by: Mustafa Ekşi <mustafa.eskieksi@gmail.com>
> ---
>   MAINTAINERS                       |   6 +
>   drivers/platform/x86/Kconfig      |  14 ++
>   drivers/platform/x86/Makefile     |   1 +
>   drivers/platform/x86/casper-wmi.c | 344 ++++++++++++++++++++++++++++++
>   4 files changed, 365 insertions(+)
>   create mode 100644 drivers/platform/x86/casper-wmi.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9ed4d386853..d0142a75d2c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4723,6 +4723,12 @@ S:	Maintained
>   W:	https://wireless.wiki.kernel.org/en/users/Drivers/carl9170
>   F:	drivers/net/wireless/ath/carl9170/
>   
> +CASPER EXCALIBUR WMI DRIVER
> +M:	Mustafa Ekşi <mustafa.eskieksi@gmail.com>
> +L:	platform-driver-x86@vger.kernel.org
> +S:	Maintained
> +F:	drivers/platform/x86/casper-wmi.c
> +
>   CAVIUM I2C DRIVER
>   M:	Robert Richter <rric@kernel.org>
>   S:	Odd Fixes
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index bdd302274b9..ebef9c9dfb6 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1127,6 +1127,20 @@ config SEL3350_PLATFORM
>   	  To compile this driver as a module, choose M here: the module
>   	  will be called sel3350-platform.
>   
> +config CASPER_WMI
> +	tristate "Casper Excalibur Laptop WMI driver"
> +	depends on ACPI_WMI
> +	depends on HWMON
> +	select NEW_LEDS
> +	select LEDS_CLASS
> +	help
> +	  Say Y here if you want to support WMI-based fan speed reporting,
> +	  power management and keyboard backlight support on Casper Excalibur
> +	  Laptops.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called casper-wmi.
> +
>   endif # X86_PLATFORM_DEVICES
>   
>   config P2SB
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index 1de432e8861..4b527dd44ad 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_MXM_WMI)			+= mxm-wmi.o
>   obj-$(CONFIG_NVIDIA_WMI_EC_BACKLIGHT)	+= nvidia-wmi-ec-backlight.o
>   obj-$(CONFIG_XIAOMI_WMI)		+= xiaomi-wmi.o
>   obj-$(CONFIG_GIGABYTE_WMI)		+= gigabyte-wmi.o
> +obj-$(CONFIG_CASPER_WMI)		+= casper-wmi.o
>   
>   # Acer
>   obj-$(CONFIG_ACERHDF)		+= acerhdf.o
> diff --git a/drivers/platform/x86/casper-wmi.c b/drivers/platform/x86/casper-wmi.c
> new file mode 100644
> index 00000000000..aae08202b19
> --- /dev/null
> +++ b/drivers/platform/x86/casper-wmi.c
> @@ -0,0 +1,344 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#include <linux/acpi.h>
> +#include <linux/leds.h>
> +#include <linux/slab.h>
> +#include <linux/module.h>
> +#include <linux/wmi.h>
> +#include <linux/device.h>
> +#include <linux/dev_printk.h>
> +#include <linux/hwmon.h>
> +#include <linux/sysfs.h>
> +#include <linux/types.h>
> +#include <linux/dmi.h>
> +#include <acpi/acexcep.h>
> +
> +MODULE_AUTHOR("Mustafa Ekşi <mustafa.eskieksi@gmail.com>");
> +MODULE_DESCRIPTION("Casper Excalibur Laptop WMI driver");
> +MODULE_LICENSE("GPL");
> +
> +#define CASPER_WMI_GUID "644C5791-B7B0-4123-A90B-E93876E0DAAD"
> +
> +#define CASPER_READ 0xfa00
> +#define CASPER_WRITE 0xfb00
> +#define CASPER_GET_HARDWAREINFO 0x0200
> +#define CASPER_SET_LED 0x0100
> +#define CASPER_POWERPLAN 0x0300
> +
> +#define CASPER_KEYBOARD_LED_1 0x03
> +#define CASPER_KEYBOARD_LED_2 0x04
> +#define CASPER_KEYBOARD_LED_3 0x05
> +#define CASPER_ALL_KEYBOARD_LEDS 0x06
> +#define CASPER_CORNER_LEDS 0x07
> +
> +struct casper_wmi_args {
> +	u16 a0, a1;
> +	u32 a2, a3, a4, a5, a6, a7, a8;
> +};
> +
> +static u32 casper_last_color;
> +static u8 casper_last_led;
> +
> +static acpi_status casper_set(struct wmi_device *wdev, u16 a1, u8 led_id,
> +			      u32 data)
> +{
> +	struct casper_wmi_args wmi_args = {
> +		.a0 = CASPER_WRITE,
> +		.a1 = a1,
> +		.a2 = led_id,
> +		.a3 = data
> +	};
> +	struct acpi_buffer input = {
> +		(acpi_size) sizeof(struct casper_wmi_args),
> +		&wmi_args
> +	};
> +	return wmidev_block_set(wdev, 0, &input);
> +}
> +
> +static ssize_t led_control_show(struct device *dev, struct device_attribute
> +				*attr, char *buf)
> +{
> +	return sprintf("%u%08x\n", buf, casper_last_led,
> +		       casper_last_color);
> +}
> +
> +
> +// input is formatted as "IMARRGGBB", I: led_id, M: mode, A: brightness, ...
> +static ssize_t led_control_store(struct device *dev, struct device_attribute
> +				 *attr, const char *buf, size_t count)
> +{
> +	u64 tmp;
> +	int ret;
> +
> +	ret = kstrtou64(buf, 16, &tmp);

What exatly is the point of u64 and kstrtou64() ?

> +
> +	if (ret)
> +		return ret;
> +
> +	u8 led_id = (tmp >> (8 * 4))&0xFF;

This will result in interesting LED IDs based on u64 input. To me it looks
very much like a poor random number generator. Does this follow wome kind
of LED subsystem API ?

> +
> +	ret =
> +	    casper_set(to_wmi_device(dev->parent), CASPER_SET_LED, led_id,
> +		       (u32) tmp
> +	    );

Odd line breaks. Does this pass checkpatch ?

> +	if (ACPI_FAILURE(ret)) {
> +		dev_err(dev, "casper-wmi ACPI status: %d\n", ret);
> +		return ret;

The function return code is supposed to be a Linux error code.
As for the functions below, I would reject this patch due to its
logging noise.

> +	}
> +	if (led_id != CASPER_CORNER_LEDS) {
> +		casper_last_color = (u32) tmp;
> +		casper_last_led = led_id;
> +	}
> +	return count;
> +}
> +
> +static DEVICE_ATTR_RW(led_control);
> +
> +static struct attribute *casper_kbd_led_attrs[] = {
> +	&dev_attr_led_control.attr,
> +	NULL,
> +};
> +
> +ATTRIBUTE_GROUPS(casper_kbd_led);
> +
> +static void set_casper_backlight_brightness(struct led_classdev *led_cdev,
> +					    enum led_brightness brightness)
> +{
> +	// Setting any of the keyboard leds' brightness sets brightness of all
> +	acpi_status ret =
> +	    casper_set(to_wmi_device(led_cdev->dev->parent), CASPER_SET_LED,
> +		       CASPER_KEYBOARD_LED_1,
> +		       (casper_last_color & 0xF0FFFFFF) |
> +		       (((u32) brightness) << 24)
> +	    );
> +
> +	if (ret != 0)
> +		dev_err(led_cdev->dev,
> +			"Couldn't set brightness acpi status: %d\n", ret);
> +}
> +
> +static enum led_brightness get_casper_backlight_brightness(struct led_classdev
> +							   *led_cdev)
> +{
> +	return (casper_last_color&0x0F000000)>>24;
> +}
> +
> +static struct led_classdev casper_kbd_led = {
> +	.name = "casper::kbd_backlight",
> +	.brightness = 0,
> +	.brightness_set = set_casper_backlight_brightness,
> +	.brightness_get = get_casper_backlight_brightness,
> +	.max_brightness = 2,
> +	.groups = casper_kbd_led_groups,
> +};
> +
> +static acpi_status casper_query(struct wmi_device *wdev, u16 a1,
> +				struct casper_wmi_args *out)
> +{
> +	struct casper_wmi_args wmi_args = {
> +		.a0 = CASPER_READ,
> +		.a1 = a1
> +	};
> +	struct acpi_buffer input = {
> +		(acpi_size) sizeof(struct casper_wmi_args),
> +		&wmi_args
> +	};
> +
> +	acpi_status ret = wmidev_block_set(wdev, 0, &input);
> +
> +	if (ACPI_FAILURE(ret)) {
> +		dev_err(&wdev->dev,
> +			"Could not query acpi status: %u", ret);

This code generates _way_ too much logging noise for my liking.

> +		return ret;

Is there any value in having this function return acpi error
codes instead of Linux error codes ?

> +	}
> +
> +	union acpi_object *obj = wmidev_block_query(wdev, 0);
> +
> +	if (obj == NULL) {
> +		dev_err(&wdev->dev,
> +			"Could not query hardware information");
> +		return AE_ERROR;
> +	}
> +	if (obj->type != ACPI_TYPE_BUFFER) {
> +		dev_err(&wdev->dev, "Return type is not a buffer");
> +		return AE_TYPE;
> +	}
> +
> +	if (obj->buffer.length != 32) {
> +		dev_err(&wdev->dev, "Return buffer is not long enough");
> +		return AE_ERROR;
> +	}
> +	memcpy(out, obj->buffer.pointer, 32);
> +	kfree(obj);
> +	return ret;
> +}
> +
> +static umode_t casper_wmi_hwmon_is_visible(const void *drvdata,
> +					   enum hwmon_sensor_types type,
> +					   u32 attr, int channel)
> +{
> +	switch (type) {
> +	case hwmon_fan:
> +		return 0444;
> +	case hwmon_pwm:
> +		return 0644;
> +	default:
> +		return 0;
> +	}
> +	return 0;
> +}
> +
> +static int casper_wmi_hwmon_read(struct device *dev,
> +				 enum hwmon_sensor_types type, u32 attr,
> +				 int channel, long *val)
> +{
> +	struct casper_wmi_args out = { 0 };
> +
> +	switch (type) {
> +	case hwmon_fan:
> +		acpi_status ret = casper_query(to_wmi_device(dev->parent),
> +					       CASPER_GET_HARDWAREINFO, &out);
> +
> +		if (ACPI_FAILURE(ret))
> +			return ret;

This function is expected to return a Linux error code, not an acpi error code.

Also, if CASPER_GET_HARDWAREINFO is not always available, the attributes
needing it should not be created in the first place.

> +
> +		if (channel == 0) { // CPU fan
> +			u32 cpu_fanspeed = out.a4;
> +
> +			cpu_fanspeed <<= 8;
> +			cpu_fanspeed += out.a4 >> 8;
> +			*val = (long) cpu_fanspeed;
> +		} else if (channel == 1) { // GPU fan
> +			u32 gpu_fanspeed = out.a5;
> +
> +			gpu_fanspeed <<= 8;
> +			gpu_fanspeed += out.a5 >> 8;

I don't know what this is supposed to be doing, but it will return
odd values. For example, if out.a5 is 0xabcd, the returned value
will be 0xabcdab. That seems to be unlikely I suspect this is supposed
to be
			*val = ((out.a5 & 0xff) << 8) | ((out.a5 >> 8) & 0xff);
but I am not even sure about that because a5 is u32 and the above would suggest
a 16-bit unsigned short in big endian format. Please check return values
and implement any necessary endiannes conversion correctly.

> +			*val = (long) gpu_fanspeed;

FWIW, those type casts are unnecessary.

> +		}
> +		return 0;
> +	case hwmon_pwm:
> +		casper_query(to_wmi_device(dev->parent), CASPER_POWERPLAN,
> +			     &out);

Why no error check here ?

> +		if (channel == 0)
> +			*val = (long)out.a2;
> +		else
> +			return -EOPNOTSUPP;

The coonditional and else case is unnecessary since only
a single pwm channel is declared.

> +		return 0;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
> +static int casper_wmi_hwmon_read_string(struct device *dev,
> +					enum hwmon_sensor_types type, u32 attr,
> +					int channel, const char **str)
> +{
> +	switch (type) {
> +	case hwmon_fan:
> +		switch (channel) {
> +		case 0:
> +			*str = "cpu_fan_speed";
> +			break;
> +		case 1:
> +			*str = "gpu_fan_speed";
> +			break;
> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +	return 0;
> +}
> +
> +static int casper_wmi_hwmon_write(struct device *dev,
> +				  enum hwmon_sensor_types type, u32 attr,
> +				  int channel, long val)
> +{
> +	acpi_status ret;
> +
> +	switch (type) {
> +	case hwmon_pwm:
> +		if (channel != 0)
> +			return -EOPNOTSUPP;

This is unnecessary. Only a single pwm channel is declared,
so channel will never be != 0.

> +		ret =
> +		    casper_set(to_wmi_device(dev->parent), CASPER_POWERPLAN,
> +			       val, 0);
> +
The first line split is unnecessary.

> +		if (ACPI_FAILURE(ret)) {
> +			dev_err(dev, "Couldn't set power plan, acpi_status: %d",
> +				ret);

Drivers should not generate such logging noise, even more so after user input.
Also, the valid range (0..255) should be checked before trying to set it.

> +			return -EINVAL;
> +		}
> +		return 0;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static const struct hwmon_ops casper_wmi_hwmon_ops = {
> +	.is_visible = &casper_wmi_hwmon_is_visible,
> +	.read = &casper_wmi_hwmon_read,
> +	.read_string = &casper_wmi_hwmon_read_string,
> +	.write = &casper_wmi_hwmon_write
> +};
> +
> +static const struct hwmon_channel_info *const casper_wmi_hwmon_info[] = {
> +	HWMON_CHANNEL_INFO(fan,
> +			   HWMON_F_INPUT | HWMON_F_LABEL,
> +			   HWMON_F_INPUT | HWMON_F_LABEL),
> +	HWMON_CHANNEL_INFO(pwm, HWMON_PWM_MODE),
> +	NULL
> +};
> +
> +static const struct hwmon_chip_info casper_wmi_hwmon_chip_info = {
> +	.ops = &casper_wmi_hwmon_ops,
> +	.info = casper_wmi_hwmon_info,
> +};
> +
> +static int casper_wmi_probe(struct wmi_device *wdev, const void *context)
> +{
> +	struct device *hwmon_dev;
> +
> +	// All Casper Excalibur Laptops use this GUID
> +	if (!wmi_has_guid(CASPER_WMI_GUID))
> +		return -ENODEV;
> +
How would the device ever be instantiated with a different GUID,
making this check necessary ?

> +	hwmon_dev =
> +	    devm_hwmon_device_register_with_info(&wdev->dev, "casper_wmi", wdev,
> +						 &casper_wmi_hwmon_chip_info,
> +						 NULL);
> +
> +	acpi_status result = led_classdev_register(&wdev->dev, &casper_kbd_led);
> +
> +	if (result != 0)
> +		return -ENODEV;
> +
> +	return PTR_ERR_OR_ZERO(hwmon_dev);

This would leave the LED device registered if instantiating the hwmon device
failed. However, the probe function would return an error, meaning the driver
core will believe that instantiation failed. Is that intentional ? I am quite
sure that this would result in interesting crashes.

> +	}
> +
> +static void casper_wmi_remove(struct wmi_device *wdev)
> +{
> +	led_classdev_unregister(&casper_kbd_led);
> +}
> +
> +static const struct wmi_device_id casper_wmi_id_table[] = {
> +	{ CASPER_WMI_GUID, NULL },
> +	{ }
> +};
> +
> +static struct wmi_driver casper_wmi_driver = {
> +	.driver = {
> +		   .name = "casper-wmi",
> +		    },
> +	.id_table = casper_wmi_id_table,
> +	.probe = casper_wmi_probe,
> +	.remove = &casper_wmi_remove
> +};
> +
> +module_wmi_driver(casper_wmi_driver);
> +
> +MODULE_DEVICE_TABLE(wmi, casper_wmi_id_table);


