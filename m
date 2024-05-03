Return-Path: <linux-kernel+bounces-168235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F75F8BB580
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 829001C226BD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2957537E7;
	Fri,  3 May 2024 21:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="lBp2nuIt"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041C822F11;
	Fri,  3 May 2024 21:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714771203; cv=none; b=qq1cYhHOQUinrCZ7lxEHn2tCOm/x9YVtoocV5sNAs1DvufnGEAAnJ5vUyJWie64UtQLBPGfcZSGjklf7IsPiqsvR4WK4GNNjM26LXxBT7vESgyVInjv9hmOXfNfJp1jlSmTbPsbHbvO2kN4aCQla8xEwQUe2460gW/XwIuGbqJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714771203; c=relaxed/simple;
	bh=k1kMAjl+Au7ftChij9Do8MeCC9MFgpeVx8UrxUWjY+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=idhWMiGqmayJahWLkJCn/PkDxofje/DDoKNcktRRp+PeTsXAODU3tyU5z+gznFyRQc9wv7/DRShWmniGbqsjdmBJiAO8DkKls0W1Azaxoh05DGDTegcPoKAsgnDK01kqphYfQw332foEiOHx3KOhEhxs5MXeOeQAsPH1oFelFe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=lBp2nuIt; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1714771162; x=1715375962; i=w_armin@gmx.de;
	bh=3igsO4B3RuGXb/qNmwvRLDWxYoBD5hgjSRjlg9lDbZ4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=lBp2nuItpm9DZrRF1zWYcq+t57jdrWZrhtfbCNXbFS2o8754FOR3wGVA8wr7EN7y
	 srTx74Hmb60xPHjzrJ3yZnq3opI+q880oyOSz4nq4L7NLdvauB5qNLCwZjy3G8H/j
	 4WQauzBzqTsNJ2ChsZu6lcuYR1vhsJM1EOvkaha4p/mjCRJhVVNVTigUk3JrEIS4K
	 yopgEhkUa5InnbtyQifRSXtDfx/8O8451qT5OUF9EjDVqALHlTbj49OKSftAluLyP
	 YdfGAar6ua6ptdSPx28roTb1lSoY4vfI9Jv59icj20OTH6L6clmYBFCZprwFI5Frv
	 33gnVAkR9eJscs1D4w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MqJmF-1sPR2924uZ-00nNZx; Fri, 03
 May 2024 23:19:22 +0200
Message-ID: <91e3282c-8271-4c95-a57f-88cca4ba88b5@gmx.de>
Date: Fri, 3 May 2024 23:19:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] platform/x86: dell-laptop: Implement platform_profile
To: Lyndon Sanche <lsanche@lyndeno.ca>
Cc: mario.limonciello@amd.com, pali@kernel.org,
 srinivas.pandruvada@linux.intel.com, ilpo.jarvinen@linux.intel.com,
 lkp@intel.com, Hans de Goede <hdegoede@redhat.com>,
 Matthew Garrett <mjg59@srcf.ucam.org>, Jonathan Corbet <corbet@lwn.net>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Vegard Nossum <vegard.nossum@oracle.com>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dell.Client.Kernel@dell.com
References: <20240425172758.67831-1-lsanche@lyndeno.ca>
 <20240501215829.4991-2-lsanche@lyndeno.ca>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20240501215829.4991-2-lsanche@lyndeno.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4wgvLRZxIBovrLg4zCnl+vHMmxvr3JFJ/pRg9bOAJlWwWQdSnwQ
 lpg0eu4m24E34r5UZ197ueuin+FEjSbFDD9WYqJouUvggH5sdvFXrB6qKk/eZoOzHP/35+/
 vTx3tb1L87mONfJPIJF11pXg+B/DdHTaExV9naJxLGV1DJ7Ek9Poqj0rpujzJ8G/42BiCOl
 ls7Q7TwDhz4zUmcxgjRPw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:J5E0hfIENIM=;zcvvMZP4loktPgcr+0MWHmrFZD9
 V5PrxBc6hUqYG+HT1s8BFcmgHXZIAH4NAoUQoOKB92rc6mTVHPjuYITIjRLF7OdmmfikLI+Zt
 ixqGvXKxILdlr0/05959jtlF0WuHJQZkpoFYXIPLD52AJpNtRy1FU+sk+ku+Lk6hVR4u4hDI5
 SXUERtG2ltSlAsqezAzeJvf+rJ73ytHlxChepXw+v/BFHRDJyempTVJCCQHRTfQTjdHcqNMMh
 wIZhmLYzv/nCTy9p//96zBYCAc9Gr4ZAkTx/MzDaoWXkQU72RMkX01AeD6mvdb44MSLmWGIxI
 dDD2tNBwj2tzdauv+DW6XueTkOjnoXUVlomJpL9S7c1/zfN9WsYptD3rr+KQo3c0lnML1RRBe
 D/fHaUYpUi4SfYrmgMAPIziuE13U0z+RBUXxm0NigxV1ZCc2MMKa5fX+F2saXkpUnx9dzzaR4
 /5cDqDRBM1aDuBa9UmBUYEVXKgQTdlLTBe1ySk35c8Ha0v1bbr72VBDMMCovzHZmtb3eAXv2k
 HlJsdNawC9C+UGlYee800gKEaou3sm/WX/hqU6JmGppvlP6utRDFNk81n9CSb9FO2NuhCmInI
 TUSJSq7JHJbnWJeo1fr8lwiKKCadGJdZIyqvQt9UdcjNLWtGopMrMzMt8chDZjHkY7d6nER8U
 OGoCOm1nEhExwTLNRNr6M42PV/qnlvo8UAYzq/ux0yNdCYuBXG/LivpDEN/bJHED6Lxe1+KSy
 mNosvRv7OvVyF/jUXoB7FotFsXaN++BMjFWRSIhQtjjuRCOhB8aVzOyD1H9LBYAjLPseKPsG9
 N07sKMHdOz4uZq/s9RotlN1EY1S7xih0IBmHP99/bQz+I=

Am 01.05.24 um 23:58 schrieb Lyndon Sanche:

> Some Dell laptops support configuration of preset fan modes through
> smbios tables.
>
> If the platform supports these fan modes, set up platform_profile to
> change these modes. If not supported, skip enabling platform_profile.
>
> Signed-off-by: Lyndon Sanche <lsanche@lyndeno.ca>
> ---
> v5:
>   - Fix indent in smbios-thermal-ctl comment
>   - Remove linux/wmi.h include
>   - Add 'select ACPI_PLATFORM_PROFILE' to Dell KConfig
> v4:
>   - Make thermal_init and thermal_cleanup static
>   - Rearrange order of added includes, did not edit current includes
>   - Include bits.h
>   - Switch comment style
>   - Return error if platform_profile registering failed
>   - Add thermal calls to call_blacklist
>   - Align defines with tabs
>   - Correct separation of function and error handling
>   - Propagate error codes up
> v3:
>   - Convert smbios-thermal-ctl docs to multiline comment and wrap
>   - Change thermal_mode_bits enum to directly be BIT() values
> 	- Convert related code to use this
>   - Use FIELD_GET/PREP and GENNMASK for getting/setting thermal modes
> 	- Correct offset for getting current ACC mode, setting offset
> 		unchanged
>   - Check if thermal_handler is allocated before freeing and
> 	 unregistering platform_profile
> v2:
>   - Wrap smbios-thermal-ctl comment
>   - Return proper error code when invalid state returned
>   - Simplify platform_profile_get returns
>   - Propogate ENOMEM error
> ---
>   drivers/platform/x86/dell/Kconfig            |   1 +
>   drivers/platform/x86/dell/dell-laptop.c      | 238 +++++++++++++++++++
>   drivers/platform/x86/dell/dell-smbios-base.c |   1 +
>   drivers/platform/x86/dell/dell-smbios.h      |   1 +
>   4 files changed, 241 insertions(+)
>
> diff --git a/drivers/platform/x86/dell/Kconfig b/drivers/platform/x86/de=
ll/Kconfig
> index bd9f445974cc..5195ad59b44d 100644
> --- a/drivers/platform/x86/dell/Kconfig
> +++ b/drivers/platform/x86/dell/Kconfig
> @@ -57,6 +57,7 @@ config DELL_LAPTOP
>   	select POWER_SUPPLY
>   	select LEDS_CLASS
>   	select NEW_LEDS
> +	select ACPI_PLATFORM_PROFILE
>   	help
>   	This driver adds support for rfkill and backlight control to Dell
>   	laptops (except for some models covered by the Compal driver).
> diff --git a/drivers/platform/x86/dell/dell-laptop.c b/drivers/platform/=
x86/dell/dell-laptop.c
> index 42f7de2b4522..dc530a4f5047 100644
> --- a/drivers/platform/x86/dell/dell-laptop.c
> +++ b/drivers/platform/x86/dell/dell-laptop.c
> @@ -27,6 +27,9 @@
>   #include <linux/i8042.h>
>   #include <linux/debugfs.h>
>   #include <linux/seq_file.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/platform_profile.h>
>   #include <acpi/video.h>
>   #include "dell-rbtn.h"
>   #include "dell-smbios.h"
> @@ -95,6 +98,7 @@ static struct backlight_device *dell_backlight_device;
>   static struct rfkill *wifi_rfkill;
>   static struct rfkill *bluetooth_rfkill;
>   static struct rfkill *wwan_rfkill;
> +static struct platform_profile_handler *thermal_handler;
>   static bool force_rfkill;
>   static bool micmute_led_registered;
>   static bool mute_led_registered;
> @@ -2199,6 +2203,232 @@ static int mute_led_set(struct led_classdev *led=
_cdev,
>   	return 0;
>   }
>
> +/* Derived from smbios-thermal-ctl
> + *
> + * cbClass 17
> + * cbSelect 19
> + * User Selectable Thermal Tables(USTT)
> + * cbArg1 determines the function to be performed
> + * cbArg1 0x0 =3D Get Thermal Information
> + *  cbRES1         Standard return codes (0, -1, -2)
> + *  cbRES2, byte 0  Bitmap of supported thermal modes. A mode is suppor=
ted if
> + *                  its bit is set to 1
> + *     Bit 0 Balanced
> + *     Bit 1 Cool Bottom
> + *     Bit 2 Quiet
> + *     Bit 3 Performance
> + *  cbRES2, byte 1 Bitmap of supported Active Acoustic Controller (AAC)=
 modes.
> + *                 Each mode corresponds to the supported thermal modes=
 in
> + *                  byte 0. A mode is supported if its bit is set to 1.
> + *     Bit 0 AAC (Balanced)
> + *     Bit 1 AAC (Cool Bottom
> + *     Bit 2 AAC (Quiet)
> + *     Bit 3 AAC (Performance)
> + *  cbRes3, byte 0 Current Thermal Mode
> + *     Bit 0 Balanced
> + *     Bit 1 Cool Bottom
> + *     Bit 2 Quiet
> + *     Bit 3 Performanc
> + *  cbRes3, byte 1  AAC Configuration type
> + *          0       Global (AAC enable/disable applies to all supported=
 USTT modes)
> + *          1       USTT mode specific
> + *  cbRes3, byte 2  Current Active Acoustic Controller (AAC) Mode
> + *     If AAC Configuration Type is Global,
> + *          0       AAC mode disabled
> + *          1       AAC mode enabled
> + *     If AAC Configuration Type is USTT mode specific (multiple bits m=
ay be set),
> + *          Bit 0 AAC (Balanced)
> + *          Bit 1 AAC (Cool Bottom
> + *          Bit 2 AAC (Quiet)
> + *          Bit 3 AAC (Performance)
> + *  cbRes3, byte 3  Current Fan Failure Mode
> + *     Bit 0 Minimal Fan Failure (at least one fan has failed, one fan =
working)
> + *     Bit 1 Catastrophic Fan Failure (all fans have failed)
> + *
> + * cbArg1 0x1   (Set Thermal Information), both desired thermal mode an=
d
> + *               desired AAC mode shall be applied
> + * cbArg2, byte 0  Desired Thermal Mode to set
> + *                  (only one bit may be set for this parameter)
> + *     Bit 0 Balanced
> + *     Bit 1 Cool Bottom
> + *     Bit 2 Quiet
> + *     Bit 3 Performance
> + * cbArg2, byte 1  Desired Active Acoustic Controller (AAC) Mode to set
> + *     If AAC Configuration Type is Global,
> + *         0  AAC mode disabled
> + *         1  AAC mode enabled
> + *     If AAC Configuration Type is USTT mode specific
> + *     (multiple bits may be set for this parameter),
> + *         Bit 0 AAC (Balanced)
> + *         Bit 1 AAC (Cool Bottom
> + *         Bit 2 AAC (Quiet)
> + *         Bit 3 AAC (Performance)
> + */
> +
> +#define DELL_ACC_GET_FIELD		GENMASK(19, 16)
> +#define DELL_ACC_SET_FIELD		GENMASK(11, 8)
> +#define DELL_THERMAL_SUPPORTED	GENMASK(3, 0)
> +
> +enum thermal_mode_bits {
> +	DELL_BALANCED =3D BIT(0),
> +	DELL_COOL_BOTTOM =3D BIT(1),
> +	DELL_QUIET =3D BIT(2),
> +	DELL_PERFORMANCE =3D BIT(3),
> +};
> +
> +static int thermal_get_mode(void)
> +{
> +	struct calling_interface_buffer buffer;
> +	int state;
> +	int ret;
> +
> +	dell_fill_request(&buffer, 0x0, 0, 0, 0);
> +	ret =3D dell_send_request(&buffer, CLASS_INFO, SELECT_THERMAL_MANAGEME=
NT);
> +	if (ret)
> +		return ret;
> +	state =3D buffer.output[2];
> +	if (state & DELL_BALANCED)
> +		return DELL_BALANCED;
> +	else if (state & DELL_COOL_BOTTOM)
> +		return DELL_COOL_BOTTOM;
> +	else if (state & DELL_QUIET)
> +		return DELL_QUIET;
> +	else if (state & DELL_PERFORMANCE)
> +		return DELL_PERFORMANCE;
> +	else
> +		return -ENXIO;
> +}
> +
> +static int thermal_get_supported_modes(int *supported_bits)
> +{
> +	struct calling_interface_buffer buffer;
> +	int ret;
> +
> +	dell_fill_request(&buffer, 0x0, 0, 0, 0);
> +	ret =3D dell_send_request(&buffer, CLASS_INFO, SELECT_THERMAL_MANAGEME=
NT);
> +	if (ret)
> +		return ret;
> +	*supported_bits =3D FIELD_GET(DELL_THERMAL_SUPPORTED, buffer.output[1]=
);
> +	return 0;
> +}
> +
> +static int thermal_get_acc_mode(int *acc_mode)
> +{
> +	struct calling_interface_buffer buffer;
> +	int ret;
> +
> +	dell_fill_request(&buffer, 0x0, 0, 0, 0);
> +	ret =3D dell_send_request(&buffer, CLASS_INFO, SELECT_THERMAL_MANAGEME=
NT);
> +	if (ret)
> +		return ret;
> +	*acc_mode =3D FIELD_GET(DELL_ACC_GET_FIELD, buffer.output[3]);
> +	return 0;
> +}
> +
> +static int thermal_set_mode(enum thermal_mode_bits state)
> +{
> +	struct calling_interface_buffer buffer;
> +	int ret;
> +	int acc_mode;
> +
> +	ret =3D thermal_get_acc_mode(&acc_mode);
> +	if (ret)
> +		return ret;
> +
> +	dell_fill_request(&buffer, 0x1, FIELD_PREP(DELL_ACC_SET_FIELD, acc_mod=
e) | state, 0, 0);
> +	ret =3D dell_send_request(&buffer, CLASS_INFO, SELECT_THERMAL_MANAGEME=
NT);
> +	return ret;
> +}
> +
> +static int thermal_platform_profile_set(struct platform_profile_handler=
 *pprof,
> +					enum platform_profile_option profile)
> +{
> +	switch (profile) {
> +	case PLATFORM_PROFILE_BALANCED:
> +		return thermal_set_mode(DELL_BALANCED);
> +	case PLATFORM_PROFILE_PERFORMANCE:
> +		return thermal_set_mode(DELL_PERFORMANCE);
> +	case PLATFORM_PROFILE_QUIET:
> +		return thermal_set_mode(DELL_QUIET);
> +	case PLATFORM_PROFILE_COOL:
> +		return thermal_set_mode(DELL_COOL_BOTTOM);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int thermal_platform_profile_get(struct platform_profile_handler=
 *pprof,
> +					enum platform_profile_option *profile)
> +{
> +	int ret;
> +
> +	ret =3D thermal_get_mode();
> +	if (ret < 0)
> +		return ret;
> +
> +	switch (ret) {
> +	case DELL_BALANCED:
> +		*profile =3D PLATFORM_PROFILE_BALANCED;
> +		break;
> +	case DELL_PERFORMANCE:
> +		*profile =3D PLATFORM_PROFILE_PERFORMANCE;
> +		break;
> +	case DELL_COOL_BOTTOM:
> +		*profile =3D PLATFORM_PROFILE_COOL;
> +		break;
> +	case DELL_QUIET:
> +		*profile =3D PLATFORM_PROFILE_QUIET;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int thermal_init(void)
> +{
> +	int ret;
> +	int supported_modes;
> +
> +	/* If thermal modes not supported, exit without error */
> +	ret =3D thermal_get_supported_modes(&supported_modes);
> +	if (ret < 0)
> +		return ret;

Hi,

some older models might not support the USTT commands, which would prevent=
 dell-laptop
from loading on such machines.
Since dell-smbios-base already knows which commands are supported (stored =
in da_supported_commands),
maybe you can add a function for checking if a certain class of commands i=
s supported and
skip thermal_init() if the USTT commands are not supported.

Thanks,
Armin Wolf

> +	if (!supported_modes)
> +		return 0;
> +
> +	thermal_handler =3D kzalloc(sizeof(*thermal_handler), GFP_KERNEL);
> +	if (!thermal_handler)
> +		return -ENOMEM;
> +	thermal_handler->profile_get =3D thermal_platform_profile_get;
> +	thermal_handler->profile_set =3D thermal_platform_profile_set;
> +
> +	if (supported_modes & DELL_QUIET)
> +		set_bit(PLATFORM_PROFILE_QUIET, thermal_handler->choices);
> +	if (supported_modes & DELL_COOL_BOTTOM)
> +		set_bit(PLATFORM_PROFILE_COOL, thermal_handler->choices);
> +	if (supported_modes & DELL_BALANCED)
> +		set_bit(PLATFORM_PROFILE_BALANCED, thermal_handler->choices);
> +	if (supported_modes & DELL_PERFORMANCE)
> +		set_bit(PLATFORM_PROFILE_PERFORMANCE, thermal_handler->choices);
> +
> +	/* Clean up if failed */
> +	ret =3D platform_profile_register(thermal_handler);
> +	if (ret)
> +		kfree(thermal_handler);
> +
> +	return ret;
> +}
> +
> +static void thermal_cleanup(void)
> +{
> +	if (thermal_handler) {
> +		platform_profile_remove();
> +		kfree(thermal_handler);
> +	}
> +}
> +
>   static struct led_classdev mute_led_cdev =3D {
>   	.name =3D "platform::mute",
>   	.max_brightness =3D 1,
> @@ -2238,6 +2468,11 @@ static int __init dell_init(void)
>   		goto fail_rfkill;
>   	}
>
> +	/* Do not fail module if thermal modes not supported, just skip */
> +	ret =3D thermal_init();
> +	if (ret)
> +		goto fail_thermal;
> +
>   	if (quirks && quirks->touchpad_led)
>   		touchpad_led_init(&platform_device->dev);
>
> @@ -2317,6 +2552,8 @@ static int __init dell_init(void)
>   		led_classdev_unregister(&mute_led_cdev);
>   fail_led:
>   	dell_cleanup_rfkill();
> +fail_thermal:
> +	thermal_cleanup();
>   fail_rfkill:
>   	platform_device_del(platform_device);
>   fail_platform_device2:
> @@ -2344,6 +2581,7 @@ static void __exit dell_exit(void)
>   		platform_device_unregister(platform_device);
>   		platform_driver_unregister(&platform_driver);
>   	}
> +	thermal_cleanup();
>   }
>
>   /* dell-rbtn.c driver export functions which will not work correctly (=
and could
> diff --git a/drivers/platform/x86/dell/dell-smbios-base.c b/drivers/plat=
form/x86/dell/dell-smbios-base.c
> index e61bfaf8b5c4..5bc2e394dd1c 100644
> --- a/drivers/platform/x86/dell/dell-smbios-base.c
> +++ b/drivers/platform/x86/dell/dell-smbios-base.c
> @@ -71,6 +71,7 @@ static struct smbios_call call_blacklist[] =3D {
>   	/* handled by kernel: dell-laptop */
>   	{0x0000, CLASS_INFO, SELECT_RFKILL},
>   	{0x0000, CLASS_KBD_BACKLIGHT, SELECT_KBD_BACKLIGHT},
> +	{0x0000, CLASS_INFO, SELECT_THERMAL_MANAGEMENT},
>   };
>
>   struct token_range {
> diff --git a/drivers/platform/x86/dell/dell-smbios.h b/drivers/platform/=
x86/dell/dell-smbios.h
> index eb341bf000c6..585d042f1779 100644
> --- a/drivers/platform/x86/dell/dell-smbios.h
> +++ b/drivers/platform/x86/dell/dell-smbios.h
> @@ -19,6 +19,7 @@
>   /* Classes and selects used only in kernel drivers */
>   #define CLASS_KBD_BACKLIGHT 4
>   #define SELECT_KBD_BACKLIGHT 11
> +#define SELECT_THERMAL_MANAGEMENT 19
>
>   /* Tokens used in kernel drivers, any of these
>    * should be filtered from userspace access

