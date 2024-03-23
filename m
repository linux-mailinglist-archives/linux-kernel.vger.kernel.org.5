Return-Path: <linux-kernel+bounces-112462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0840D887A25
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 20:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C1B21C20C3C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 19:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1391F59149;
	Sat, 23 Mar 2024 19:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="oE4de/GV"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D829444;
	Sat, 23 Mar 2024 19:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711221249; cv=none; b=cqeUK+WkBiq18HV9001z7kzXNQWz7CwKOsvtMFmRPsCpwhPCsrw9T6Yu75jCDLftzbhmyLcwFDmAgexiLYgQh2tlNLQgS9cMdS7kmVi+KfSsXIsZ2OrjIePNMH5mGnIcgtT9Og2k2m1BuSAawqH9PirQ52KqEBP4o2EFWbe0lS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711221249; c=relaxed/simple;
	bh=xTP9wY2sncPSfZDKQ1QZmdBZenxIKnB2xGEFwjaGPf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=igHzF1JJFWUoCTH7tdoAj8JEWZ3Adgn7e07zd1m4n+qP2RFqyLYjDY7fyc7pS7Cc1t2dUkJbTmiFt9gS9bAqRFk1cLpyRNGLQm+6gDxyHDBZJw6SKopnRNgoJwwTqkpeMD/cjfn0Fwqk0y3Mawc3xsvv8oCeLdBbzGIRLSpyfI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=oE4de/GV; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1711221215; x=1711826015; i=w_armin@gmx.de;
	bh=BW5ryCBmy700x4gCM8f2fi9WBGoIo0lbw5eFnhfahaA=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=oE4de/GV1FHcL8gjB20gNJfoAWLi4ynJzqjkb8LxiJjrlZWH+uCcU4yV3l48yGOo
	 EXNh8kS6WvkBHqbebPVIG75owmYGOgMYB9kcRUlfhPhbxUml2Sqw8DCyPuqM7U8Ws
	 O9/HlfkmU1BwyTRU5HzZLN8ljUE2z3LKszt6shi3DnY14yvy/Gx0pfz6IGeTm2A9p
	 oIqnrtapk3nEY5FynaiLRz7BsTiFWpu90+KnoUnlxv2FyHYxKnRvjp3JVpIk1QQPP
	 2QpR4uuN2KR/V5C8JXVC/wqb0GN8ZBpWapYdodjUJ8iVDSfGHudJi7OeA1RzUsOpB
	 V57peX8sBDYUIiO/Mg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MatVb-1rC1241U4Z-00cPCl; Sat, 23
 Mar 2024 20:13:35 +0100
Message-ID: <7bcacae2-b61a-45ec-a6ef-ec3225081019@gmx.de>
Date: Sat, 23 Mar 2024 20:13:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] platform/x86: Add wmi driver for Casper Excalibur
 laptops
To: mustafa <mustafa.eskieksi@gmail.com>, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, jdelvare@suse.com, linux@roeck-us.net,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-hwmon@vger.kernel.org, pavel@ucw.cz, lee@kernel.org,
 linux-leds@vger.kernel.org
Cc: rishitbansal0@gmail.com
References: <20240312203128.6708-1-mustafa.eskieksi@gmail.com>
 <20240312203128.6708-2-mustafa.eskieksi@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20240312203128.6708-2-mustafa.eskieksi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:As7LmFnOVrFyjG9OcfUpNEFIqJBZj6k/xGpUHgdPST81OPg6lDM
 4ZaVUw2o23lh283OEIrXEuS/TDOtgtTbejxjuqkMNC4F2AZT9B3OCa0H5e8aI4e0YZKeHWg
 4ZgJ4WRuZGGwaeregGmwdYGjLllcBk6FVRZYypBnuB+ZJ59dod8d0mNQmxnPQ3rVaID+t6e
 xJe2gQvjCRGmbsKC+YrPA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vNS8BQ5aceY=;vPjROx8NFTK4WdXbaLkABI35bxu
 uMS78hJAcr4K0HzL3BJtyqysfU6cv6C8BZoY7/URSi9Xm0Dk+weFnAx2IAKbTp0IBSMY6dgTk
 y6ke2NkxEMjnK7C74CVXHU05JHTbLilOyx2fDGL6PalCElhtafxci3DjTZ+RQqRPUNna+QEh4
 t05xFdalstGfJoJc9ibJlsiLPpSSc5Gs2tMpScp6SW4jrUTeNhoz5qJrg/8penTKWIy/ifjgh
 eJh6suwdOfqiFtTGbq9d/cUbAEpIBb/36OlrR3BxRWvgbjMCjcKGeNlr22xqx3rgX/BbuYZRz
 hfezsgvnAuJy6Fw2iAX7IUsckhdj2Vt9Ew18qrU9ptFGdW0X1BAr50BTd4uh75FbrdaIogemz
 7QOB35a3cBuvc08/NbId48ypG/AoI/mNjL7yhtvwhPAD1oRIfkrM0zUcrbM+4Ansq4qEoCeXC
 rJ4SqQMY728uJRWJb6Cpm7nu4Ox4AC3Im5D5ns6de5OW5Zhbn3Pm6TBh2qsHmpKe9ukTO/0MB
 XCISX6oJi/R7y2Ty52ZUv88hccclxo/MyjTY4nKOYQPnv9R4364o9e875mMlhhZhBnMiga4qj
 94V6ifWVKIndxyGTlAYgzeWI5soERWI4xS+SrVapHCwzomEQJSqrALDf6o9crUxVWg0rimHMi
 USecg6vc8f4Lf5S2S6NofD9dT2ShSHYnXogCoyyI7cD8BGUx3r+XRpHsrvksirrfp0n4V9LiL
 a+miLom+W7OhHTPqV5xcaIAXX/+USw+Daf+GJ+GcEVBBmc9jqML+BJaJUDZPfHG6piJLHLHE9
 J+k3amzuSH69Ziuy4qgKHLuzQVPZnRkAeqwOrPXKJPpX4=

Am 12.03.24 um 21:31 schrieb mustafa:

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
> Changes in v4:
>    - Renamed casper_driver to casper_drv
>    - Moved all global variables to casper_drv struct. Devices access
>      casper_drv via wdev's driver_data.
>    - Removed struct led_cache, because only its u32 array was used. It i=
s
>      replaced with color_cache.
>    - Added mutex_locks in casper_set and casper_query, so they now accep=
t
>      casper_drv instead of wmi_device as argument.
>    - Changed endianess conversion in hwmon_read to something sparse does=
n't
>      complain about.
>    - Moved registrations of multicolor leds and platform profile to thei=
r
>      own functions. This makes casper_wmi_probe more readable.
>    - Added .no_singleton to wmi_device.
>    - Some minor changes.
> Changes in v3:
>    - Replaced led_control attribute with multicolor led interface.
>    - Added struct led_cache, instead of storing only last color change.
>    - Added dmi list to prevent registering platform_profile driver in mo=
dels
>      that doesn't have this feature.
>    - Added a x86_cpu_id to differentiate older laptops that are reportin=
g
>      fan speeds in big-endian. Also newer laptops have a different power
>      profile scheme. I'm using x86_cpu_id because they don't have a
>      difference in model names, only in cpu generations (the official dr=
iver
>      download page makes you select your cpu's generation too).
>    - Removed hwmon_pwm device in favor of platform_profile driver. It
>      indirectly affects fans' speed but they also affect frequency and
>      power consumption as well.
>    - Replaced handwritten masks with GENMASK equivalents.
>    - Replaced led_classdev_register with
>      devm_led_classdev_multicolor_register. This should solve the bug
>      where led_classdev remains registered even if casper_wmi_probe
>      returns -ENODEV.
>    - Removed select NEW_LEDS and LEDS_CLASS, because it creates recursiv=
e
>      dependencies.
>    - And some minor changes.
> Changes in v2:
>    - Added masks for
>    - Changed casper_set and casper_query returns Linux error code rather
>      than acpi_status.
>    - replaced complicated bit operations with FIELD_GET.
>    - Fixed some indentation and spacing.
>    - Broke fan speeds further.
>    - Moved module metadata to the end of the file.
> ---
>   MAINTAINERS                       |   6 +
>   drivers/platform/x86/Kconfig      |  14 +
>   drivers/platform/x86/Makefile     |   1 +
>   drivers/platform/x86/casper-wmi.c | 629 ++++++++++++++++++++++++++++++
>   4 files changed, 650 insertions(+)
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
> index 00000000000..72616c94860
> --- /dev/null
> +++ b/drivers/platform/x86/casper-wmi.c
> @@ -0,0 +1,629 @@
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
> +#include <linux/platform_profile.h>
> +#include <linux/led-class-multicolor.h>
> +#include <linux/types.h>
> +#include <linux/mutex_types.h>
> +#include <linux/err.h>
> +#include <linux/mutex.h>
> +#include <linux/container_of.h>
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
> +static const char * const zone_names[CASPER_LED_COUNT] =3D {
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
> +	CASPER_NEW_HIGH_PERFORMANCE	=3D 0,
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
> +struct casper_drv {
> +	struct platform_profile_handler handler;
> +	struct mutex casper_mutex;
> +	u32 color_cache[CASPER_LED_COUNT];
> +	struct led_classdev_mc *casper_kbd_mc;
> +	struct mc_subled *subleds;
> +	struct wmi_device *wdev;
> +	struct casper_quirk_entry *quirk_applied;
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
> +static int casper_set(struct casper_drv *drv, u16 a1, u8 led_id, u32 da=
ta)
> +{
> +	acpi_status ret =3D 0;
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
> +	mutex_lock(&drv->casper_mutex);
> +
> +	ret =3D wmidev_block_set(drv->wdev, 0, &input);
> +	if (ACPI_FAILURE(ret))
> +		ret =3D -EIO;
> +
> +	mutex_unlock(&drv->casper_mutex);
> +	return ret;
> +}
> +
> +static int casper_query(struct casper_drv *drv, u16 a1,
> +			struct casper_wmi_args *out)
> +{
> +	union acpi_object *obj;
> +	struct casper_wmi_args wmi_args;
> +	struct acpi_buffer input;
> +	int ret =3D 0;
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
> +	mutex_lock(&drv->casper_mutex);
> +
> +	ret =3D wmidev_block_set(drv->wdev, 0, &input);
> +	if (ACPI_FAILURE(ret)) {
> +		ret =3D -EIO;
> +		goto unlock;
> +	}
> +
> +	obj =3D wmidev_block_query(drv->wdev, 0);
> +	if (!obj) {
> +		ret =3D -EIO;
> +		goto unlock;
> +	}
> +
> +	if (obj->type !=3D ACPI_TYPE_BUFFER) { // obj will be 0x10 on failure
> +		ret =3D -EINVAL;
> +		goto freeobj;
> +	}
> +	if (obj->buffer.length !=3D sizeof(struct casper_wmi_args)) {
> +		ret =3D -EIO;
> +		goto freeobj;
> +	}
> +
> +	memcpy(out, obj->buffer.pointer, sizeof(struct casper_wmi_args));
> +
> +freeobj:
> +	kfree(obj);
> +unlock:
> +	mutex_unlock(&drv->casper_mutex);
> +	return ret;
> +}
> +
> +static enum led_brightness get_casper_brightness(struct led_classdev *l=
ed_cdev)
> +{
> +	struct casper_drv *drv =3D dev_get_drvdata(led_cdev->dev->parent);
> +	struct casper_wmi_args hardware_alpha =3D {0};
> +
> +	if (strcmp(led_cdev->name, zone_names[3]) =3D=3D 0)
> +		return FIELD_GET(CASPER_LED_ALPHA, drv->color_cache[3]);
> +
> +	casper_query(drv, CASPER_GET_HARDWAREINFO, &hardware_alpha);
> +
> +	return hardware_alpha.a6;
> +}
> +
> +static void set_casper_brightness(struct led_classdev *led_cdev,
> +				  enum led_brightness brightness)
> +{
> +	u32 bright_with_mode, bright_prep, led_data, led_data_no_alpha;
> +	struct casper_drv *drv;
> +	int ret;
> +	size_t zone;
> +	u8 zone_to_change;
> +
> +	drv =3D dev_get_drvdata(led_cdev->dev->parent);
> +
> +	for (size_t i =3D 0; i < CASPER_LED_COUNT; i++)
> +		if (strcmp(led_cdev->name, zone_names[i]) =3D=3D 0)
> +			zone =3D i;
> +	if (zone =3D=3D 3)
> +		zone_to_change =3D CASPER_CORNER_LEDS;
> +	else
> +		zone_to_change =3D zone + CASPER_KEYBOARD_LED_1;
> +
> +	led_data_no_alpha =3D drv->subleds[zone].intensity & ~CASPER_LED_ALPHA=
;
> +
> +	if ((drv->color_cache[zone] & ~CASPER_LED_ALPHA) =3D=3D led_data_no_al=
pha)
> +		bright_with_mode =3D brightness | LED_NORMAL;
> +	else
> +		bright_with_mode =3D get_casper_brightness(led_cdev) | LED_NORMAL;
> +
> +	bright_prep =3D FIELD_PREP(CASPER_LED_ALPHA, bright_with_mode);
> +	led_data =3D bright_prep | led_data_no_alpha;
> +	ret =3D casper_set(drv, CASPER_SET_LED, zone_to_change, led_data);
> +	if (ret)
> +		return;
> +
> +	drv->color_cache[zone] =3D led_data;
> +}
> +
> +static int casper_platform_profile_get(struct platform_profile_handler =
*pprof,
> +				       enum platform_profile_option *profile)
> +{
> +	struct casper_drv *drv =3D container_of(pprof, struct casper_drv,
> +					      handler);
> +	struct casper_wmi_args ret_buff =3D {0};
> +	int ret;
> +
> +	ret =3D casper_query(drv, CASPER_POWERPLAN, &ret_buff);
> +	if (ret)
> +		return ret;
> +
> +	if (drv->quirk_applied->new_power_scheme) {
> +		switch (ret_buff.a2) {
> +		case CASPER_NEW_HIGH_PERFORMANCE:
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
> +	struct casper_drv *drv =3D container_of(pprof, struct casper_drv,
> +					      handler);
> +	enum casper_power_profile_old prf_old;
> +	enum casper_power_profile_new prf_new;
> +
> +	if (drv->quirk_applied->new_power_scheme) {
> +
> +		switch (profile) {
> +		case PLATFORM_PROFILE_PERFORMANCE:
> +			prf_new =3D CASPER_NEW_HIGH_PERFORMANCE;
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
> +		return casper_set(drv, CASPER_POWERPLAN, prf_new, 0);
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
> +	return casper_set(drv, CASPER_POWERPLAN, prf_old, 0);
> +}
> +
> +static umode_t casper_wmi_hwmon_is_visible(const void *drvdata,
> +					   enum hwmon_sensor_types type,
> +					   u32 attr, int channel)
> +{
> +	return 0444;
> +}
> +
> +static int casper_wmi_hwmon_read(struct device *dev,
> +				 enum hwmon_sensor_types type, u32 attr,
> +				 int channel, long *val)
> +{
> +	struct casper_wmi_args out =3D { 0 };
> +	struct wmi_device *wdev =3D to_wmi_device(dev->parent);
> +	struct casper_drv *drv =3D dev_get_drvdata(&wdev->dev);
> +	int ret;
> +
> +	ret =3D casper_query(drv, CASPER_GET_HARDWAREINFO, &out);
> +	if (ret)
> +		return ret;
> +
> +	switch (channel) {
> +	case CASPER_FAN_CPU:
> +		if (drv->quirk_applied->big_endian_fans)
> +			*val =3D be16_to_cpu(*(__be16 *)&out.a4);
> +		else
> +			*val =3D out.a5;
> +		break;
> +	case CASPER_FAN_GPU:
> +		if (drv->quirk_applied->big_endian_fans)
> +			*val =3D be16_to_cpu(*(__be16 *)&out.a5);
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
> +static int casper_platform_profile_register(struct casper_drv *drv)
> +{
> +	drv->handler.profile_get =3D casper_platform_profile_get;
> +	drv->handler.profile_set =3D casper_platform_profile_set;
> +
> +	set_bit(PLATFORM_PROFILE_LOW_POWER, drv->handler.choices);
> +	set_bit(PLATFORM_PROFILE_BALANCED, drv->handler.choices);
> +	if (!drv->quirk_applied->new_power_scheme)
> +		set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE,
> +			drv->handler.choices);
> +	set_bit(PLATFORM_PROFILE_PERFORMANCE, drv->handler.choices);
> +
> +	return platform_profile_register(&drv->handler);
> +}
> +
> +static int casper_multicolor_register(struct casper_drv *drv)
> +{
> +	int ret;
> +
> +	drv->casper_kbd_mc =3D devm_kcalloc(&drv->wdev->dev,
> +		CASPER_LED_COUNT, sizeof(*drv->casper_kbd_mc), GFP_KERNEL);
> +
> +	drv->subleds =3D devm_kcalloc(&drv->wdev->dev,
> +		CASPER_LED_COUNT, sizeof(struct mc_subled *), GFP_KERNEL);
> +
> +	for (size_t i =3D 0; i < CASPER_LED_COUNT; i++) {
> +		drv->subleds[i] =3D (struct mc_subled) {
> +			.color_index =3D LED_COLOR_ID_RGB,
> +			.brightness =3D 2,
> +			.intensity =3D CASPER_DEFAULT_COLOR
> +		};
> +		drv->casper_kbd_mc[i] =3D (struct led_classdev_mc) {
> +			.led_cdev =3D {
> +				.name =3D zone_names[i],
> +				.brightness =3D 0,
> +				.max_brightness =3D 2,
> +				.brightness_set =3D &set_casper_brightness,
> +				.brightness_get =3D &get_casper_brightness,
> +				.color =3D LED_COLOR_ID_RGB,
> +			},
> +			.num_colors =3D 1,
> +			.subled_info =3D &drv->subleds[i]
> +		};
> +
> +		ret =3D devm_led_classdev_multicolor_register(&drv->wdev->dev,
> +						&drv->casper_kbd_mc[i]);
> +		if (ret)
> +			return -ENODEV;
> +		drv->color_cache[i] =3D CASPER_DEFAULT_COLOR;
> +	}
> +	return 0;
> +}
> +
> +static int casper_wmi_probe(struct wmi_device *wdev, const void *contex=
t)
> +{
> +	struct device *hwmon_dev;
> +	struct casper_drv *drv;
> +	const struct x86_cpu_id *gen_id;
> +	const struct dmi_system_id *dmi_id;
> +	struct casper_quirk_entry *pp_quirk;
> +	int ret;
> +
> +	drv =3D devm_kzalloc(&wdev->dev, sizeof(*drv), GFP_KERNEL);
> +	if (!drv)
> +		return -ENOMEM;
> +	mutex_init(&drv->casper_mutex);

Hi,

sorry for taking so long to respond. This mutex should also be destroyed
when an error occurs during probe.

> +
> +	drv->wdev =3D wdev;
> +	dev_set_drvdata(&wdev->dev, drv);
> +
> +	gen_id =3D x86_match_cpu(casper_gen);
> +	if (!gen_id)
> +		return -ENODEV;
> +
> +	drv->quirk_applied =3D (struct casper_quirk_entry *)gen_id->driver_dat=
a;
> +
> +	dmi_id =3D dmi_first_match(casper_quirks);
> +	if (!dmi_id)
> +		return -ENODEV;
> +
> +	pp_quirk =3D (struct casper_quirk_entry *)dmi_id->driver_data;
> +	drv->quirk_applied->no_power_profiles =3D pp_quirk->no_power_profiles;
> +
> +	ret =3D casper_multicolor_register(drv);
> +	if (ret)
> +		return ret;
> +
> +	hwmon_dev =3D devm_hwmon_device_register_with_info(&wdev->dev,
> +						"casper_wmi", wdev,
> +						&casper_wmi_hwmon_chip_info,
> +						NULL);
> +	if (IS_ERR(hwmon_dev))
> +		return PTR_ERR(hwmon_dev);
> +
> +	if (!drv->quirk_applied->no_power_profiles)
> +		return casper_platform_profile_register(drv);
> +
> +	return 0;
> +}
> +
> +static void casper_wmi_remove(struct wmi_device *wdev)
> +{
> +	struct casper_drv *drv =3D dev_get_drvdata(&wdev->dev);
> +
> +	mutex_destroy(&drv->casper_mutex);
> +	if (!drv->quirk_applied->no_power_profiles)
> +		platform_profile_remove();
> +}
> +
> +static const struct wmi_device_id casper_wmi_id_table[] =3D {
> +	{ CASPER_WMI_GUID, NULL },
> +	{ }
> +};
> +
> +static struct wmi_driver casper_drv =3D {
> +	.driver =3D {
> +		.name =3D "casper-wmi",
> +	},
> +	.id_table =3D casper_wmi_id_table,
> +	.probe =3D casper_wmi_probe,
> +	.remove =3D &casper_wmi_remove,
> +	.no_singleton =3D true,
> +};
> +
> +module_wmi_driver(casper_drv);
> +MODULE_DEVICE_TABLE(wmi, casper_wmi_id_table);

For the WMI part: Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> +
> +MODULE_AUTHOR("Mustafa Ek=C5=9Fi <mustafa.eskieksi@gmail.com>");
> +MODULE_DESCRIPTION("Casper Excalibur Laptop WMI driver");
> +MODULE_LICENSE("GPL");

