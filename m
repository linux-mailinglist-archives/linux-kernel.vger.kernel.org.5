Return-Path: <linux-kernel+bounces-98305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A7387782C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 20:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CE13281756
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 19:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3176A39FE9;
	Sun, 10 Mar 2024 19:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="TiphUcjf"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6D13987B;
	Sun, 10 Mar 2024 19:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710098269; cv=none; b=gGR7+tYWMUEDe2RdVmqOvJxvkwEyZxZudQIpKnQeS3e/Vmf5AzlhVHddKYGBf3K50y6OS6RlyMAezcr/Kky7jDjYknTNA3KeWphf1zBVUBva3LkoqRsR3C2oOBUlgLOGx4s8+leBZzQYnHVYKAUnO1+GhIBOCAPCVcC49qjeoa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710098269; c=relaxed/simple;
	bh=JBq75a19YZSEl5ql86tBp95TUMqa3HwtYLppIQRisTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KZ5Tv9pFlmy0un+gx5VHCWYwhDXG3cCZH41Bwpc62HfBFf4xpBrwVV8dbOW48A25ryxotgiSJ5NABCRH3GlCSsGo6Ww6HbuMRv3JI+ZxoFygITIx/fs4/qm5iPNRxZWvBRb+t137AgXZYUwUp5ws6U/f2qJ20wDDWO9hSwo2gsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=TiphUcjf; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1710098235; x=1710703035; i=w_armin@gmx.de;
	bh=JBq75a19YZSEl5ql86tBp95TUMqa3HwtYLppIQRisTA=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=TiphUcjfCDJOlwsiWgeVzEIA/4e443J6lzOeQoRyrJqPyyBBuiU3cGDRMQxV8svn
	 PzrQDGNLYD0L6rxx/rPhU7OQ+5x0MkjVo8MlmIjTwWuYxj+8G/D2pucUbbgZG2CoS
	 UWSr+50VHKnkWdJgTy5/iGu0i0b8EF1OJglKyyyiGS70snsdIlWS0FiQ6HJfhtkeJ
	 WjtzyVJZksKWPmMu0/LVLivOTwMbhgQNcCJ5emm+99MoE27qCGwTH0fumXgF++Ywt
	 lGEUIFkv+xi7hZ4kEdyM/YEp0NMzCQNZJxu6hE04Ucxig3YqG/bT7ObVkwMP0KTFp
	 nKZGIDus9fPG3JXiXQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYvY8-1rNWDj2cnA-00UoT1; Sun, 10
 Mar 2024 20:17:15 +0100
Message-ID: <bf9318bf-72b9-4e71-b37a-767e3e51432e@gmx.de>
Date: Sun, 10 Mar 2024 20:17:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] platform/x86: Add wmi driver for Casper Excalibur
 laptops
To: mustafa <mustafa.eskieksi@gmail.com>, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, jdelvare@suse.com, linux@roeck-us.net,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-hwmon@vger.kernel.org, pavel@ucw.cz, lee@kernel.org,
 linux-leds@vger.kernel.org
Cc: rishitbansal0@gmail.com
References: <20240310181429.59451-1-mustafa.eskieksi@gmail.com>
 <20240310181429.59451-2-mustafa.eskieksi@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20240310181429.59451-2-mustafa.eskieksi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:l5lsbwdloy6dCI1bQeMAR2nYxxgm8nO87b5gqZZ69eJXf1dAniq
 uFXNOt9+u6opul9V4QV+tWtcUXu6IMEGcM8nlJ657gq6YuduOdY6fJvpE6Ly76E3R8DB/RB
 aJqogtqxQk+7lZI0MBKC4k19UWewwv49m7SOTJXMoaMJZcXTyNtDevLm5VaDjbp/P1CGr5X
 zgftGA4fP0pe48evq3ldw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bdcQlmHVZ/w=;H1/nqtGO2gvUvqxVigV1NI5afDd
 RkpUtMXY/phCw30KL8b8rEX/m9EVt5dIg1GFkXcDb4DFi3QEuI93tJe3LUtJ+LKE8mUHMDjKl
 8SlhZFW5r59eYrQ8+1cD+WheoHNzOthtddKft58z7ecY8eg3oLdyYhQ/w10XSqS1DnnDbfSVT
 BVguZ8fmL6XZDqa9hftdwuCV6UwuYb5qCZif9T3/ZlHy3LoKqgxa+C2XnWg56/jbyMorfCLEt
 tV6rL/vws+d67STlwQgsX9ipIJ+OWwVoLRwegUSu/37i8AgWaV+YSaNlLuWvcTIhk4fVz70LR
 sfH0uMKtThSgIEsxwoWX/piMP0BCan8m/R0LZVG3FPLM4emc1T/1EKNuIAAMrlfezPIXVH09E
 ccI6CiV0nyx0GiVzvNbUfDnWLfM32hCg4TzciSzKoPr+87QLs2/3SSONCitTYMA2koSpyeb/y
 rJte9y0EbiLJGnysHTP8Tqm7+iQtgYRYL/nhEq7t1akulH4QM+mQXbQ5nYUR1F0XzG+6T1v6o
 DX2w8Ep8UUDoOqMgndSnPf7tkWxG0expDKZHJklohGUQ2fI2oMwTmWkCYzm5hSrzLfJisAlio
 N11tmhM7h1S7L8XazBqXE2W/h4TzzUtDFppl2/opdqaHsT3bHSIG1NFvZDOWEyD1aIUJ/oG9g
 qCh0peaw1TE/H0yk1Y2R7NIZiknO9j3QCB84gS1tSpcsHvy/9Z0ULnU7teipHtB9W0khu5NJk
 ksTcogsIw33Yr5Cw0bZyY4BoOCIHfTzEZPuUGQnXOguerO2g4OzIO9IjRrQyqbRe8IqMoyRY5
 S5mfudvfcWuMkGQ5JCP/JFczyJr8KYmOIDTd6RKU+6J4I=

Am 10.03.24 um 19:14 schrieb mustafa:

> From: Mustafa Ek=C5=9Fi <mustafa.eskieksi@gmail.com>
>
> This wmi driver supports Casper Excalibur laptops' changing keyboard
> backlight, reading fan speeds and changing power profiles. Multicolor
> led device is used for backlight, platform_profile for power management
> and hwmon for fan speeds. It supports both old (10th gen or older) and
> new (11th gen or newer) laptops. It uses x86_match_cpu to check if the
> laptop is old or new.
> This driver's Multicolor keyboard backlight API is very similar to Rishi=
t
> Bansal's proposed API.
>
> Signed-off-by: Mustafa Ek=C5=9Fi <mustafa.eskieksi@gmail.com>
> ---
> Changes in v3:
>   - Replaced led_control attribute with multicolor led interface.
>   - Added struct led_cache, instead of storing only last color change.
>   - Added dmi list to prevent registering platform_profile driver in mod=
els
>     that doesn't have this feature.
>   - Added a x86_cpu_id to differentiate older laptops that are reporting
>     fan speeds in big-endian. Also newer laptops have a different power
>     profile scheme. I'm using x86_cpu_id because they don't have a
>     difference in model names, only in cpu generations (the official dri=
ver
>     download page makes you select your cpu's generation too).
>   - Removed hwmon_pwm device in favor of platform_profile driver. It
>     indirectly affects fans' speed but they also affect frequency and
>     power consumption as well.
>   - Replaced handwritten masks with GENMASK equivalents.
>   - Replaced led_classdev_register with
>     devm_led_classdev_multicolor_register. This should solve the bug
>     where led_classdev remains registered even if casper_wmi_probe
>     returns -ENODEV.
>   - Removed select NEW_LEDS and LEDS_CLASS, because it creates recursive
>     dependencies.
>   - And some minor changes.
> Changes in v2:
>   - Added masks for
>   - Changed casper_set and casper_query returns Linux error code rather =
than
>     acpi_status.
>   - replaced complicated bit operations with FIELD_GET.
>   - Fixed some indentation and spacing.
>   - Broke fan speeds further.
>   - Moved module metadata to the end of the file.
> ---
>   MAINTAINERS                       |   6 +
>   drivers/platform/x86/Kconfig      |  14 +
>   drivers/platform/x86/Makefile     |   1 +
>   drivers/platform/x86/casper-wmi.c | 639 ++++++++++++++++++++++++++++++
>   4 files changed, 660 insertions(+)
>   create mode 100644 drivers/platform/x86/casper-wmi.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1aabf1c15bb..e4cb770c990 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4724,6 +4724,12 @@ S:	Maintained
>   W:	https://wireless.wiki.kernel.org/en/users/Drivers/carl9170
>   F:	drivers/net/wireless/ath/carl9170/
>
> +CASPER EXCALIBUR WMI DRIVER
> +M:	Mustafa Ek=C5=9Fi <mustafa.eskieksi@gmail.com>
> +L:	platform-driver-x86@vger.kernel.org
> +S:	Maintained
> +F:	drivers/platform/x86/casper-wmi.c
> +
>   CAVIUM I2C DRIVER
>   M:	Robert Richter <rric@kernel.org>
>   S:	Odd Fixes
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index bdd302274b9..4f951bcac1a 100644
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
> +	depends on LEDS_CLASS_MULTICOLOR
> +	select ACPI_PLATFORM_PROFILE
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
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefi=
le
> index 1de432e8861..4b527dd44ad 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_MXM_WMI)			+=3D mxm-wmi.o
>   obj-$(CONFIG_NVIDIA_WMI_EC_BACKLIGHT)	+=3D nvidia-wmi-ec-backlight.o
>   obj-$(CONFIG_XIAOMI_WMI)		+=3D xiaomi-wmi.o
>   obj-$(CONFIG_GIGABYTE_WMI)		+=3D gigabyte-wmi.o
> +obj-$(CONFIG_CASPER_WMI)		+=3D casper-wmi.o
>
>   # Acer
>   obj-$(CONFIG_ACERHDF)		+=3D acerhdf.o
> diff --git a/drivers/platform/x86/casper-wmi.c b/drivers/platform/x86/ca=
sper-wmi.c
> new file mode 100644
> index 00000000000..80e1e2b16fb
> --- /dev/null
> +++ b/drivers/platform/x86/casper-wmi.c
> @@ -0,0 +1,639 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +#include <linux/module.h>
> +#include <linux/bits.h>
> +#include <linux/bitops.h>
> +#include <linux/acpi.h>
> +#include <linux/leds.h>
> +#include <linux/slab.h>
> +#include <linux/wmi.h>
> +#include <linux/device.h>
> +#include <linux/hwmon.h>
> +#include <linux/sysfs.h>
> +#include <linux/types.h>
> +#include <acpi/acexcep.h>
> +#include <linux/bitfield.h>
> +#include <linux/sysfs.h>
> +#include <linux/platform_profile.h>
> +#include <linux/led-class-multicolor.h>
> +
> +#include <linux/dmi.h>
> +#include <asm/cpu_device_id.h>
> +#include <asm/intel-family.h>
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
> +#define CASPER_LED_COUNT 4
> +
> +const char * const zone_names[CASPER_LED_COUNT] =3D {
> +	"casper::kbd_zoned_backlight-right",
> +	"casper::kbd_zoned_backlight-middle",
> +	"casper::kbd_zoned_backlight-left",
> +	"casper::kbd_zoned_backlight-corners",
> +};
> +
> +#define CASPER_LED_ALPHA GENMASK(31, 24)
> +#define CASPER_LED_RED	 GENMASK(23, 16)
> +#define CASPER_LED_GREEN GENMASK(15, 8)
> +#define CASPER_LED_BLUE  GENMASK(7, 0)
> +#define CASPER_DEFAULT_COLOR (CASPER_LED_RED | CASPER_LED_GREEN | \
> +			      CASPER_LED_BLUE)
> +#define CASPER_FAN_CPU 0
> +#define CASPER_FAN_GPU 1
> +
> +enum casper_power_profile_old {
> +	CASPER_HIGH_PERFORMANCE =3D 1,
> +	CASPER_GAMING		=3D 2,
> +	CASPER_TEXT_MODE	=3D 3,
> +	CASPER_POWERSAVE	=3D 4
> +};
> +
> +enum casper_power_profile_new {
> +	CASPER_NEW_HIGH_PEROFRMANCE	=3D 0,
> +	CASPER_NEW_GAMING		=3D 1,
> +	CASPER_NEW_AUDIO		=3D 2
> +};
> +
> +struct casper_quirk_entry {
> +	bool big_endian_fans;
> +	bool no_power_profiles;
> +	bool new_power_scheme;
> +};
> +
> +struct casper_wmi_driver {
> +	struct wmi_device *wdev;
> +	struct platform_profile_handler handler;
> +};
> +
> +struct casper_wmi_args {
> +	u16 a0, a1;
> +	u32 a2, a3, a4, a5, a6, a7, a8;
> +};
> +
> +enum casper_led_mode {
> +	LED_NORMAL =3D 0x10,
> +	LED_BLINK =3D 0x20,
> +	LED_FADE =3D 0x30,
> +	LED_HEARTBEAT =3D 0x40,
> +	LED_REPEAT =3D 0x50,
> +	LED_RANDOM =3D 0x60
> +};
> +
> +struct casper_led_cache {
> +	u32 colors[CASPER_LED_COUNT];
> +	u8 last_keyboard_led;
> +};
> +
> +static struct casper_led_cache led_cache =3D {
> +	.colors =3D {
> +		CASPER_DEFAULT_COLOR, CASPER_DEFAULT_COLOR,
> +		CASPER_DEFAULT_COLOR, CASPER_DEFAULT_COLOR,
> +	},
> +	.last_keyboard_led =3D CASPER_ALL_KEYBOARD_LEDS,
> +};
> +
> +static struct casper_quirk_entry *quirk_applied;
> +static struct led_classdev_mc *casper_kbd_mcled_info;

Hi,

those global variables are initialized inside the probe() callback of the =
WMI driver,
so there are going to be issues when this driver is going to be instantiat=
ed multiple times.

Please move those global variables into a private driver struct using the =
state container pattern:
https://www.kernel.org/doc/html/latest/driver-api/driver-model/design-patt=
erns.html

Maybe you can keep the variables associated with quirk handling global and=
 instead do the DMI matching
inside the modules init function before registering the WMI driver (this w=
ould replace module_wmi_driver()).

> +
> +static struct mc_subled casper_kbd_mcled_sub[CASPER_LED_COUNT][1] =3D {
> +	{
> +		{
> +			.color_index =3D LED_COLOR_ID_RGB,
> +			.brightness =3D 2,
> +			.intensity =3D CASPER_DEFAULT_COLOR
> +		}
> +	},
> +	{
> +		{
> +			.color_index =3D LED_COLOR_ID_RGB,
> +			.brightness =3D 2,
> +			.intensity =3D CASPER_DEFAULT_COLOR
> +		}
> +	},
> +	{
> +		{
> +			.color_index =3D LED_COLOR_ID_RGB,
> +			.brightness =3D 2,
> +			.intensity =3D CASPER_DEFAULT_COLOR
> +		}
> +	},
> +	{
> +		{
> +			.color_index =3D LED_COLOR_ID_RGB,
> +			.brightness =3D 2,
> +			.intensity =3D CASPER_DEFAULT_COLOR
> +		}
> +	},
> +};
> +
> +static int casper_set(struct wmi_device *wdev, u16 a1, u8 led_id, u32 d=
ata)
> +{
> +	acpi_status ret;
> +	struct casper_wmi_args wmi_args;
> +	struct acpi_buffer input;
> +
> +	wmi_args =3D (struct casper_wmi_args) {
> +		.a0 =3D CASPER_WRITE,
> +		.a1 =3D a1,
> +		.a2 =3D led_id,
> +		.a3 =3D data
> +	};
> +
> +	input =3D (struct acpi_buffer) {
> +		(acpi_size) sizeof(struct casper_wmi_args),
> +		&wmi_args
> +	};
> +
> +	ret =3D wmidev_block_set(wdev, 0, &input);
> +	if (ACPI_FAILURE(ret))
> +		return -EINVAL;

I think -EIO would be more suitable.

> +
> +	return 0;
> +}
> +
> +static int casper_query(struct wmi_device *wdev, u16 a1,
> +			struct casper_wmi_args *out)
> +{
> +	union acpi_object *obj;
> +	struct casper_wmi_args wmi_args;
> +	struct acpi_buffer input;
> +	int ret;
> +
> +	wmi_args =3D (struct casper_wmi_args) {
> +		.a0 =3D CASPER_READ,
> +		.a1 =3D a1
> +	};
> +	input =3D (struct acpi_buffer) {
> +		(acpi_size) sizeof(struct casper_wmi_args),
> +		&wmi_args
> +	};
> +
> +	ret =3D wmidev_block_set(wdev, 0, &input);
> +	if (ACPI_FAILURE(ret))
> +		return -EIO;
> +
> +	obj =3D wmidev_block_query(wdev, 0);
> +	if (IS_ERR_OR_NULL(obj))
> +		return -EIO;

You only need to check for NULL. Also you maybe should protect accesses li=
ke these with a
mutex, as otherwise two queries running simultaneously could overwrite the=
mselves.

> +
> +	if (obj->type !=3D ACPI_TYPE_BUFFER) { // obj will be 0x10 on failure
> +		ret =3D -EINVAL;
> +		goto out;
> +	}
> +	if (obj->buffer.length !=3D sizeof(struct casper_wmi_args)) {
> +		ret =3D -EIO;
> +		goto out;
> +	}
> +
> +	memcpy(out, obj->buffer.pointer, sizeof(struct casper_wmi_args));
> +
> +out:
> +	kfree(obj);
> +	return ret;
> +}
> +
> +static enum led_brightness get_casper_brightness(struct led_classdev *l=
ed_cdev)
> +{
> +	struct wmi_device *wdev =3D to_wmi_device(led_cdev->dev->parent);
> +	struct casper_wmi_args hardware_alpha =3D {0};
> +
> +	if (strcmp(led_cdev->name, zone_names[3]) =3D=3D 0)
> +		return FIELD_GET(CASPER_LED_ALPHA, led_cache.colors[3]);
> +
> +	casper_query(wdev, CASPER_GET_HARDWAREINFO, &hardware_alpha);
> +
> +	return hardware_alpha.a6;
> +}
> +
> +static void set_casper_brightness(struct led_classdev *led_cdev,
> +				  enum led_brightness brightness)
> +{
> +	u32 bright_with_mode, bright_prep, led_data, led_data_no_alpha;
> +	struct wmi_device *wdev =3D to_wmi_device(led_cdev->dev->parent);
> +	int ret;
> +	size_t zone;
> +	u8 zone_to_change;
> +
> +	for (size_t i =3D 0; i < CASPER_LED_COUNT; i++)
> +		if (strcmp(led_cdev->name, zone_names[i]) =3D=3D 0)
> +			zone =3D i;
> +
> +	if (zone =3D=3D 3)
> +		zone_to_change =3D CASPER_CORNER_LEDS;
> +	else
> +		zone_to_change =3D zone + CASPER_KEYBOARD_LED_1;
> +
> +	led_data_no_alpha =3D casper_kbd_mcled_info[zone].subled_info[0].inten=
sity
> +			    & ~CASPER_LED_ALPHA;
> +	if ((led_cache.colors[zone] & ~CASPER_LED_ALPHA) =3D=3D led_data_no_al=
pha)
> +		bright_with_mode =3D brightness | LED_NORMAL;
> +	else
> +		bright_with_mode =3D get_casper_brightness(led_cdev) | LED_NORMAL;
> +
> +	bright_prep =3D FIELD_PREP(CASPER_LED_ALPHA, bright_with_mode);
> +	led_data =3D bright_prep | led_data_no_alpha;
> +	ret =3D casper_set(wdev, CASPER_SET_LED, zone_to_change, led_data);
> +	if (ret)
> +		return;
> +
> +	led_cache.colors[zone] =3D led_data;
> +}
> +
> +static int casper_platform_profile_get(struct platform_profile_handler =
*pprof,
> +				       enum platform_profile_option *profile)
> +{
> +	struct casper_wmi_driver *drv =3D container_of(pprof,
> +						     struct casper_wmi_driver,
> +						     handler);
> +	struct casper_wmi_args ret_buff =3D {0};
> +	int ret;
> +
> +	ret =3D casper_query(drv->wdev, CASPER_POWERPLAN, &ret_buff);
> +	if (ret)
> +		return ret;
> +
> +	if (quirk_applied->new_power_scheme) {
> +		switch (ret_buff.a2) {
> +		case CASPER_NEW_HIGH_PEROFRMANCE:
> +			*profile =3D PLATFORM_PROFILE_PERFORMANCE;
> +			break;
> +		case CASPER_NEW_GAMING:
> +			*profile =3D PLATFORM_PROFILE_BALANCED;
> +			break;
> +		case CASPER_NEW_AUDIO:
> +			*profile =3D PLATFORM_PROFILE_LOW_POWER;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		return 0;
> +	}
> +
> +	switch (ret_buff.a2) {
> +	case CASPER_HIGH_PERFORMANCE:
> +		*profile =3D PLATFORM_PROFILE_PERFORMANCE;
> +		break;
> +	case CASPER_GAMING:
> +		*profile =3D PLATFORM_PROFILE_BALANCED_PERFORMANCE;
> +		break;
> +	case CASPER_TEXT_MODE:
> +		*profile =3D PLATFORM_PROFILE_BALANCED;
> +		break;
> +	case CASPER_POWERSAVE:
> +		*profile =3D PLATFORM_PROFILE_LOW_POWER;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int casper_platform_profile_set(struct platform_profile_handler =
*pprof,
> +				       enum platform_profile_option profile)
> +{
> +	struct casper_wmi_driver *drv =3D container_of(pprof,
> +						     struct casper_wmi_driver,
> +						     handler);
> +	enum casper_power_profile_old prf_old;
> +	enum casper_power_profile_new prf_new;
> +
> +	if (quirk_applied->new_power_scheme) {
> +
> +		switch (profile) {
> +		case PLATFORM_PROFILE_PERFORMANCE:
> +			prf_new =3D CASPER_NEW_HIGH_PEROFRMANCE;
> +			break;
> +		case PLATFORM_PROFILE_BALANCED:
> +			prf_new =3D CASPER_NEW_GAMING;
> +			break;
> +		case PLATFORM_PROFILE_LOW_POWER:
> +			prf_new =3D CASPER_NEW_AUDIO;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +
> +		return casper_set(drv->wdev, CASPER_POWERPLAN, prf_new, 0);
> +	}
> +
> +	switch (profile) {
> +	case PLATFORM_PROFILE_PERFORMANCE:
> +		prf_old =3D CASPER_HIGH_PERFORMANCE;
> +		break;
> +	case PLATFORM_PROFILE_BALANCED_PERFORMANCE:
> +		prf_old =3D CASPER_GAMING;
> +		break;
> +	case PLATFORM_PROFILE_BALANCED:
> +		prf_old =3D CASPER_TEXT_MODE;
> +		break;
> +	case PLATFORM_PROFILE_LOW_POWER:
> +		prf_old =3D CASPER_POWERSAVE;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return casper_set(drv->wdev, CASPER_POWERPLAN, prf_old, 0);
> +}
> +
> +static umode_t casper_wmi_hwmon_is_visible(const void *drvdata,
> +					   enum hwmon_sensor_types type,
> +					   u32 attr, int channel)
> +{
> +	if (type =3D=3D hwmon_fan)
> +		return 0444;
> +
> +	return 0;

Since you only support fan sensors, you can just return 0444;

> +}
> +
> +static int casper_wmi_hwmon_read(struct device *dev,
> +				 enum hwmon_sensor_types type, u32 attr,
> +				 int channel, long *val)
> +{
> +	struct casper_wmi_args out =3D { 0 };
> +	struct wmi_device *wdev =3D to_wmi_device(dev->parent);
> +	int ret;
> +
> +	if (type !=3D hwmon_fan)
> +		return -EOPNOTSUPP;

See above.

> +
> +	ret =3D casper_query(wdev, CASPER_GET_HARDWAREINFO, &out);
> +	if (ret)
> +		return ret;
> +
> +	switch (channel) {
> +	case CASPER_FAN_CPU:
> +		if (quirk_applied->big_endian_fans)
> +			*val =3D be16_to_cpu((u16) out.a4);
> +		else
> +			*val =3D out.a5;
> +		break;
> +	case CASPER_FAN_GPU:
> +		if (quirk_applied->big_endian_fans)
> +			*val =3D be16_to_cpu((u16) out.a5);
> +		else
> +			*val =3D out.a5;
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int casper_wmi_hwmon_read_string(struct device *dev,
> +					enum hwmon_sensor_types type, u32 attr,
> +					int channel, const char **str)
> +{
> +	if (type !=3D hwmon_fan)
> +		return -EOPNOTSUPP;

See above.

> +
> +	switch (channel) {
> +	case CASPER_FAN_CPU:
> +		*str =3D "cpu_fan_speed";
> +		break;
> +	case CASPER_FAN_GPU:
> +		*str =3D "gpu_fan_speed";
> +		break;
> +	}
> +	return 0;
> +}
> +
> +static const struct hwmon_ops casper_wmi_hwmon_ops =3D {
> +	.is_visible =3D &casper_wmi_hwmon_is_visible,
> +	.read =3D &casper_wmi_hwmon_read,
> +	.read_string =3D &casper_wmi_hwmon_read_string,
> +};
> +
> +static const struct hwmon_channel_info *const casper_wmi_hwmon_info[] =
=3D {
> +	HWMON_CHANNEL_INFO(fan,
> +			   HWMON_F_INPUT | HWMON_F_LABEL,
> +			   HWMON_F_INPUT | HWMON_F_LABEL),
> +	NULL
> +};
> +
> +static const struct hwmon_chip_info casper_wmi_hwmon_chip_info =3D {
> +	.ops =3D &casper_wmi_hwmon_ops,
> +	.info =3D casper_wmi_hwmon_info,
> +};
> +
> +static struct casper_quirk_entry gen_older_than_11 =3D {
> +	.big_endian_fans =3D true,
> +	.new_power_scheme =3D false
> +};
> +
> +static struct casper_quirk_entry gen_newer_than_11 =3D {
> +	.big_endian_fans =3D false,
> +	.new_power_scheme =3D true
> +};
> +
> +static const struct x86_cpu_id casper_gen[] =3D {
> +	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE, &gen_older_than_11),
> +	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE, &gen_older_than_11),
> +	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE, &gen_newer_than_11),
> +	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE, &gen_newer_than_11),
> +	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE, &gen_newer_than_11),
> +	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE, &gen_newer_than_11),
> +	{}
> +};
> +
> +/*
> + * These quirks don't get stored in quirk_applied.
> + */
> +static struct casper_quirk_entry quirk_no_power_profile =3D {
> +	.no_power_profiles =3D true
> +};
> +
> +static struct casper_quirk_entry quirk_has_power_profile =3D {
> +	.no_power_profiles =3D false
> +};
> +
> +static const struct dmi_system_id casper_quirks[] =3D {
> +	{
> +		.ident =3D "CASPER EXCALIBUR G650",
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR,
> +				  "CASPER BILGISAYAR SISTEMLERI"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "EXCALIBUR G650")
> +		},
> +		.driver_data =3D &quirk_no_power_profile
> +	},
> +	{
> +		.ident =3D "CASPER EXCALIBUR G670",
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR,
> +				  "CASPER BILGISAYAR SISTEMLERI"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "EXCALIBUR G670")
> +		},
> +		.driver_data =3D &quirk_no_power_profile
> +	},
> +	{
> +		.ident =3D "CASPER EXCALIBUR G750",
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR,
> +				  "CASPER BILGISAYAR SISTEMLERI"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "EXCALIBUR G750")
> +		},
> +		.driver_data =3D &quirk_no_power_profile
> +	},
> +	{
> +		.ident =3D "CASPER EXCALIBUR G770",
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR,
> +				  "CASPER BILGISAYAR SISTEMLERI"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "EXCALIBUR G770")
> +		},
> +		.driver_data =3D &quirk_has_power_profile
> +	},
> +	{
> +		.ident =3D "CASPER EXCALIBUR G780",
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR,
> +				  "CASPER BILGISAYAR SISTEMLERI"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "EXCALIBUR G780")
> +		},
> +		.driver_data =3D &quirk_has_power_profile
> +	},
> +	{
> +		.ident =3D "CASPER EXCALIBUR G870",
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR,
> +				  "CASPER BILGISAYAR SISTEMLERI"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "EXCALIBUR G870")
> +		},
> +		.driver_data =3D &quirk_has_power_profile
> +	},
> +	{
> +		.ident =3D "CASPER EXCALIBUR G900",
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR,
> +				  "CASPER BILGISAYAR SISTEMLERI"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "EXCALIBUR G900")
> +		},
> +		.driver_data =3D &quirk_has_power_profile
> +	},
> +	{
> +		.ident =3D "CASPER EXCALIBUR G911",
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR,
> +				  "CASPER BILGISAYAR SISTEMLERI"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "EXCALIBUR G911")
> +		},
> +		.driver_data =3D &quirk_has_power_profile
> +	},
> +	{ }
> +};
> +
> +static int casper_wmi_probe(struct wmi_device *wdev, const void *contex=
t)
> +{
> +	struct device *hwmon_dev;
> +	struct casper_wmi_driver *drv;
> +	const struct x86_cpu_id *gen_id;
> +	const struct dmi_system_id *dmi_id;
> +	int ret;
> +
> +	gen_id =3D x86_match_cpu(casper_gen);
> +	if (!gen_id)
> +		return -ENODEV;
> +
> +	quirk_applied =3D (struct casper_quirk_entry *) gen_id->driver_data;
> +
> +	dmi_id =3D dmi_first_match(casper_quirks);
> +	if (!dmi_id)
> +		return -ENODEV;
> +
> +	quirk_applied->no_power_profiles =3D ((struct casper_quirk_entry *)
> +		dmi_id->driver_data)->no_power_profiles;
> +
> +	casper_kbd_mcled_info =3D devm_kzalloc(&wdev->dev,
> +		sizeof(*casper_kbd_mcled_info)*CASPER_LED_COUNT, GFP_KERNEL);
> +	if (casper_kbd_mcled_info =3D=3D NULL)
> +		return -ENOMEM;
> +
> +	for (size_t i =3D 0; i < CASPER_LED_COUNT; i++) {
> +		casper_kbd_mcled_info[i] =3D (struct led_classdev_mc) {
> +			.led_cdev =3D {
> +				.name =3D zone_names[i],
> +				.brightness =3D 0,
> +				.max_brightness =3D 2,
> +				.brightness_set =3D &set_casper_brightness,
> +				.brightness_get =3D &get_casper_brightness,
> +				.color =3D LED_COLOR_ID_RGB,
> +			},
> +			.num_colors =3D ARRAY_SIZE(casper_kbd_mcled_sub[i]),
> +			.subled_info =3D casper_kbd_mcled_sub[i]
> +		};
> +
> +		ret =3D devm_led_classdev_multicolor_register(&wdev->dev,
> +						&casper_kbd_mcled_info[i]);
> +		if (ret)
> +			return -ENODEV;
> +	}
> +
> +	hwmon_dev =3D devm_hwmon_device_register_with_info(&wdev->dev,
> +						"casper_wmi", wdev,
> +						&casper_wmi_hwmon_chip_info,
> +						NULL);
> +	if (IS_ERR_OR_NULL(hwmon_dev))
> +		return -ENODEV;

Please return the error code contained inside the pointer. Also you only n=
eed
to check for IS_ERR().

> +
> +	if (!quirk_applied->no_power_profiles) {
> +		drv =3D devm_kzalloc(&wdev->dev, sizeof(*drv), GFP_KERNEL);
> +		if (drv =3D=3D NULL)

if (!drv)

> +			return -ENOMEM;
> +		drv->wdev =3D wdev;
> +		dev_set_drvdata(&wdev->dev, drv);
> +
> +		drv->handler.profile_get =3D casper_platform_profile_get;
> +		drv->handler.profile_set =3D casper_platform_profile_set;
> +
> +		set_bit(PLATFORM_PROFILE_LOW_POWER, drv->handler.choices);
> +		set_bit(PLATFORM_PROFILE_BALANCED, drv->handler.choices);
> +		if (!quirk_applied->new_power_scheme)
> +			set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE,
> +				drv->handler.choices);
> +		set_bit(PLATFORM_PROFILE_PERFORMANCE, drv->handler.choices);
> +
> +		ret =3D platform_profile_register(&drv->handler);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void casper_wmi_remove(struct wmi_device *wdev)
> +{
> +	if (!quirk_applied->no_power_profiles)
> +		platform_profile_remove();
> +}
> +
> +static const struct wmi_device_id casper_wmi_id_table[] =3D {
> +	{ CASPER_WMI_GUID, NULL },
> +	{ }
> +};
> +
> +static struct wmi_driver casper_wmi_driver =3D {
> +	.driver =3D {
> +		   .name =3D "casper-wmi",
> +		    },
> +	.id_table =3D casper_wmi_id_table,
> +	.probe =3D casper_wmi_probe,
> +	.remove =3D &casper_wmi_remove,

Please set the .no_singleton flag to true to indicate that your WMI driver=
 can be
instantiated multiple times. Otherwise i cannot accept this driver.

Thanks,
Armin Wolf

> +};
> +
> +module_wmi_driver(casper_wmi_driver);
> +MODULE_DEVICE_TABLE(wmi, casper_wmi_id_table);
> +
> +MODULE_AUTHOR("Mustafa Ek=C5=9Fi <mustafa.eskieksi@gmail.com>");
> +MODULE_DESCRIPTION("Casper Excalibur Laptop WMI driver");
> +MODULE_LICENSE("GPL");

