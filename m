Return-Path: <linux-kernel+bounces-159185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B368B2A67
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 23:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88D251F22927
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 21:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6E415533B;
	Thu, 25 Apr 2024 21:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="gBC71TeA"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D662414F9ED;
	Thu, 25 Apr 2024 21:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714079268; cv=none; b=LO/mE80FN9a3jZIxkpOX2UsHqNRpApgnsODY9LoP3Z/VrIMznYIk0GbOeiBjjkmXTU9hS5ycOEuOAejK5wkHJKg2ji65mF55Wr/CdBs5PbhYog57kdlrFIf5cB5M4U/9TpmXtMk9TwOIuhkNHgQzznqw1poseirUfFoKd1MxK2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714079268; c=relaxed/simple;
	bh=fNHD5/z9tsH+1kMTTiFfSiy3i3GZ8DqNyGrfC/OJUdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X5qUEJk6w1NJYp4iaVHJifoF3qNi3dx/V6VonF8lyR1eyVNRrY1irH2tsuXMc89+bsUwh8TWmFJK+bof3jD50v63g3n2CNIGz5lVPpxTOb1/LUSrKpfZabhpBOi3EGKoTUqDo44YHl1L2JxdDACPJxELYtqplmIlQ9lI2ogHx8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=gBC71TeA; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1714079249; x=1714684049; i=w_armin@gmx.de;
	bh=UnMXSkrNN4/pE2DpRg/rewlu1JJCmYcj/fYtcqtUDbE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=gBC71TeAYfq/wRDcnKsPt8/kV6Vw8PQTuKwiIOzZ++XcisI3B9enNuM3BDf+Tixm
	 idpfKnuxiwN1DBnnNdy2I7TRkJOWJBDkefmIoS5Nc7g8ODyZnBqrW29WwlcTwuOPI
	 4VCfvcdoCzQ6G9YjfOqDXUkr3oPt/biKZ/qII70Fnlsvqbl8Tu9DNB8bpHoVN2LkE
	 aT7WWFkWlwiGkhcMavV3sMRLo0TSUyWs0Iqr2pcslEnfE9gH4QpKV3qEeFnh78DXn
	 eM6uPANG7U5EWRL/GGfp06mhyg9EGLvrMLSFpkiXoxDbbtXY1jrtXrvNgS4WNwEWB
	 VBsaHoZe9ZzkfhTamA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MVeI2-1s9xhd0g32-00RPXI; Thu, 25
 Apr 2024 23:07:29 +0200
Message-ID: <7a215986-4702-443a-9e1d-a2fb1172276a@gmx.de>
Date: Thu, 25 Apr 2024 23:07:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: dell-laptop: Implement platform_profile
To: Lyndon Sanche <lsanche@lyndeno.ca>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, =?UTF-8?Q?Pali_Roh=C3=A1r?=
 <pali@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dell.Client.Kernel@dell.com
References: <20240425172758.67831-1-lsanche@lyndeno.ca>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20240425172758.67831-1-lsanche@lyndeno.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:72g8WantXvKJlC8MAAtqYdoe4QCNhC7sbqRMMVu5asvtHcnVJrz
 6VEfNpSTmB0+gQc+ubjzYJJwrNOjKATGmeiXSusvQVgxko3vLCLPQ/lSfAS7jv1853cZlWg
 y1VkXXyLNVC3iEfPz9Bp7oqTnn6geZTxmYyI9gRcvh5bcE2t3PHuX78kmSDhY6gvwd93kmo
 NLsxM5QzTKVqjtnUYP3MQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YGZVRjVDvxI=;4BUIvtPHMGhiuQGXtrps9VlL/x8
 5C7ZH6dePrg6VPqREvl07ic1Bc4qVcEbwB/M/S/BhQDzRWm/wdkUqqjeJjAkpz74a6bZyarNW
 C3y/wQYW+LbYLlL+9iojAvBYAeYPrWgNvZ8fOH8o1RAorU+zlpxh44nm1fY09ENLiju97kde9
 fR4EFbUkFP207oEAcAR0cIhM3eHIQjFHqHPKHsp7TMofklJDBR2snyF1cOfAtTRF9yXQN47+5
 MyPrbeeUWFdp3ptxf9h77YXSVI9nsqhWzpEreZGTPSN4dlNjXAAOuaff/0tzvTvs8u7NDoWpq
 8uDbISlOUQp0aaVMRYx315SaAXAuF/z/Uvi9eIjpwDUhP7aiP8je+DxD0MZ6RzgwJ2vrQD1Bf
 mQt2vwCEsHKktQDOAKH/pCAMmaPvYmz+k/9wcZ2axxypIPzc8PDzyiLhAyXIKH9Sums3jBpDw
 Rt99f68aR1MQXcIyoSDTLdyWCO2hj5cRX2AXJS1a1nd91W9toC/8nGORZtaxrQ5cc0FN//iRJ
 tETCzQfynjpu4MWi+P8AO+cWTfJ5K593UtW9vY68GWgmt4eut4K62tDFngV97VOiS1yy765EN
 mkdOMcFKDFO4DIlyrSuaIeHOrE+GMRCmwfomxvv/vVavt4cnm3P4Rn1qA9kberH2hNggxvik5
 kRY1PXNQhUnL2w3p2VUdauH1G69OVquOq4g/RhZJXcDcrcGq6E8uN6eJQ8QvsCjBiIu1LFvVD
 zk/cYv2YoUmDyUVn0JPx9fWk1Gchkpugm0bdc8lTa7Xg/oVcdfEMgR2FVCz2gTpmGlj+R8JEN
 hhFGpH3A8uz85bb4pYPnXqgKy9nYUpWoyv5u+CI7f4tQs=

Am 25.04.24 um 19:27 schrieb Lyndon Sanche:

> Some Dell laptops support configuration of preset
> fan modes through smbios tables.
>
> If the platform supports these fan modes, set up
> platform_profile to change these modes. If not
> supported, skip enabling platform_profile.
>
> Signed-off-by: Lyndon Sanche <lsanche@lyndeno.ca>
> ---
>   drivers/platform/x86/dell/dell-laptop.c | 220 ++++++++++++++++++++++++
>   drivers/platform/x86/dell/dell-smbios.h |   1 +
>   2 files changed, 221 insertions(+)
>
> diff --git a/drivers/platform/x86/dell/dell-laptop.c b/drivers/platform/=
x86/dell/dell-laptop.c
> index 42f7de2b4522..7f9c4e0e5ef5 100644
> --- a/drivers/platform/x86/dell/dell-laptop.c
> +++ b/drivers/platform/x86/dell/dell-laptop.c
> @@ -27,6 +27,7 @@
>   #include <linux/i8042.h>
>   #include <linux/debugfs.h>
>   #include <linux/seq_file.h>
> +#include <linux/platform_profile.h>
>   #include <acpi/video.h>
>   #include "dell-rbtn.h"
>   #include "dell-smbios.h"
> @@ -95,10 +96,18 @@ static struct backlight_device *dell_backlight_devic=
e;
>   static struct rfkill *wifi_rfkill;
>   static struct rfkill *bluetooth_rfkill;
>   static struct rfkill *wwan_rfkill;
> +static struct platform_profile_handler *thermal_handler;
>   static bool force_rfkill;
>   static bool micmute_led_registered;
>   static bool mute_led_registered;
>
> +enum thermal_mode_bits {
> +	DELL_BALANCED =3D 0,
> +	DELL_COOL_BOTTOM =3D 1,
> +	DELL_QUIET =3D 2,
> +	DELL_PERFORMANCE =3D 3,
> +};
> +
>   module_param(force_rfkill, bool, 0444);
>   MODULE_PARM_DESC(force_rfkill, "enable rfkill on non whitelisted model=
s");
>
> @@ -2199,6 +2208,211 @@ static int mute_led_set(struct led_classdev *led=
_cdev,
>   	return 0;
>   }
>
> +// Derived from smbios-thermal-ctl
> +//
> +// cbClass 17
> +// cbSelect 19
> +// User Selectable Thermal Tables(USTT)
> +// cbArg1 determines the function to be performed
> +// cbArg1 0x0 =3D Get Thermal Information
> +//  cbRES1         Standard return codes (0, -1, -2)
> +//  cbRES2, byte 0  Bitmap of supported thermal modes. A mode is suppor=
ted if its bit is set to 1
> +//     Bit 0 Balanced
> +//     Bit 1 Cool Bottom
> +//     Bit 2 Quiet
> +//     Bit 3 Performance
> +//  cbRES2, byte 1 Bitmap of supported Active Acoustic Controller (AAC)=
 modes. Each mode
> +//                 corresponds to the supported thermal modes in byte 0=
 A mode is supported if
> +//                 its bit is set to 1.
> +//     Bit 0 AAC (Balanced)
> +//     Bit 1 AAC (Cool Bottom
> +//     Bit 2 AAC (Quiet)
> +//     Bit 3 AAC (Performance)
> +//  cbRes3, byte 0 Current Thermal Mode
> +//     Bit 0 Balanced
> +//     Bit 1 Cool Bottom
> +//     Bit 2 Quiet
> +//     Bit 3 Performanc
> +//  cbRes3, byte 1  AAC Configuration type
> +//          0       Global (AAC enable/disable applies to all supported=
 USTT modes)
> +//          1       USTT mode specific
> +//  cbRes3, byte 2  Current Active Acoustic Controller (AAC) Mode
> +//     If AAC Configuration Type is Global,
> +//          0       AAC mode disabled
> +//          1       AAC mode enabled
> +//     If AAC Configuration Type is USTT mode specific (multiple bits m=
ay be set),
> +//          Bit 0 AAC (Balanced)
> +//          Bit 1 AAC (Cool Bottom
> +//          Bit 2 AAC (Quiet)
> +//          Bit 3 AAC (Performance)
> +//  cbRes3, byte 3  Current Fan Failure Mode
> +//     Bit 0 Minimal Fan Failure (at least one fan has failed, one fan =
working)
> +//     Bit 1 Catastrophic Fan Failure (all fans have failed)
> +//  cbArg1 0x1   (Set Thermal Information), both desired thermal mode a=
nd
> +//               desired AAC mode shall be applied
> +//  cbArg2, byte 0  Desired Thermal Mode to set (only one bit may be se=
t for this parameter)
> +//     Bit 0 Balanced
> +//     Bit 1 Cool Bottom
> +//     Bit 2 Quiet
> +//     Bit 3 Performance
> +//  cbArg2, byte 1  Desired Active Acoustic Controller (AAC) Mode to se=
t
> +//     If AAC Configuration Type is Global,
> +//         0  AAC mode disabled
> +//         1  AAC mode enabled
> +//
> +//     If AAC Configuration Type is USTT mode specific (multiple bits m=
ay be set for this parameter),

Hi,

checkpatch reports: WARNING: line length of 101 exceeds 100 columns

> +//         Bit 0 AAC (Balanced)
> +//         Bit 1 AAC (Cool Bottom
> +//         Bit 2 AAC (Quiet)
> +//         Bit 3 AAC (Performance)
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
> +	if ((state >> DELL_BALANCED) & 1)
> +		return DELL_BALANCED;
> +	else if ((state >> DELL_COOL_BOTTOM) & 1)
> +		return DELL_COOL_BOTTOM;
> +	else if ((state >> DELL_QUIET) & 1)
> +		return DELL_QUIET;
> +	else if ((state >> DELL_PERFORMANCE) & 1)
> +		return DELL_PERFORMANCE;
> +	else
> +		return 0;

This would return DELL_BALANCED if no option is set. Please return an appr=
opriate error code.

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
> +	*supported_bits =3D buffer.output[1] & 0xF;
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
> +	*acc_mode =3D ((buffer.output[3] >> 8) & 0xFF);
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
> +	dell_fill_request(&buffer, 0x1, (acc_mode << 8) | BIT(state), 0, 0);
> +	ret =3D dell_send_request(&buffer, CLASS_INFO, SELECT_THERMAL_MANAGEME=
NT);
> +	return ret;
> +}
> +
> +static int thermal_platform_profile_set(struct platform_profile_handler=
 *pprof,
> +					enum platform_profile_option profile)
> +{
> +	int ret;
> +
> +	switch (profile) {
> +	case PLATFORM_PROFILE_BALANCED:
> +		ret =3D thermal_set_mode(DELL_BALANCED);
> +		break;

Maybe using "return thermal_set_mode()" would be better in this cases.

> +	case PLATFORM_PROFILE_PERFORMANCE:
> +		ret =3D thermal_set_mode(DELL_PERFORMANCE);
> +		break;
> +	case PLATFORM_PROFILE_QUIET:
> +		ret =3D thermal_set_mode(DELL_QUIET);
> +		break;
> +	case PLATFORM_PROFILE_COOL:
> +		ret =3D thermal_set_mode(DELL_COOL_BOTTOM);
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return ret;
> +}
> +
> +static int thermal_platform_profile_get(struct platform_profile_handler=
 *pprof,
> +					enum platform_profile_option *profile)
> +{
> +	switch (thermal_get_mode()) {

Please check if thermal_get_mode() returned an error code and return it in=
 this case.

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
> +int thermal_init(void)
> +{
> +	int ret;
> +	int supported_modes;
> +
> +	ret =3D thermal_get_supported_modes(&supported_modes);
> +
> +	if (ret !=3D 0 || supported_modes =3D=3D 0)
> +		return -ENXIO;
> +
> +	thermal_handler =3D kzalloc(sizeof(*thermal_handler), GFP_KERNEL);
> +	if (!thermal_handler)
> +		return -ENOMEM;
> +	thermal_handler->profile_get =3D thermal_platform_profile_get;
> +	thermal_handler->profile_set =3D thermal_platform_profile_set;
> +
> +	if ((supported_modes >> DELL_QUIET) & 1)
> +		set_bit(PLATFORM_PROFILE_QUIET, thermal_handler->choices);
> +	if ((supported_modes >> DELL_COOL_BOTTOM) & 1)
> +		set_bit(PLATFORM_PROFILE_COOL, thermal_handler->choices);
> +	if ((supported_modes >> DELL_BALANCED) & 1)
> +		set_bit(PLATFORM_PROFILE_BALANCED, thermal_handler->choices);
> +	if ((supported_modes >> DELL_PERFORMANCE) & 1)
> +		set_bit(PLATFORM_PROFILE_PERFORMANCE, thermal_handler->choices);
> +
> +	platform_profile_register(thermal_handler);
> +
> +	return 0;

Please check the return value of platform_profile_register() and return th=
e error if this function fails,
see commit fe0e04cf66a1 ("platform/surface: platform_profile: Propagate er=
ror if profile registration fails")
for an explanation.

> +}
> +
> +void thermal_cleanup(void)
> +{
> +	platform_profile_remove();
> +	kfree(thermal_handler);
> +}
> +
>   static struct led_classdev mute_led_cdev =3D {
>   	.name =3D "platform::mute",
>   	.max_brightness =3D 1,
> @@ -2266,6 +2480,11 @@ static int __init dell_init(void)
>   		mute_led_registered =3D true;
>   	}
>
> +	// Do not fail module if thermal modes not supported,
> +	// just skip
> +	if (thermal_init() !=3D 0)
> +		pr_warn("Unable to setup platform_profile, skipping");
> +
>   	if (acpi_video_get_backlight_type() !=3D acpi_backlight_vendor)
>   		return 0;
>
> @@ -2344,6 +2563,7 @@ static void __exit dell_exit(void)
>   		platform_device_unregister(platform_device);
>   		platform_driver_unregister(&platform_driver);
>   	}
> +	thermal_cleanup();

Should only be called when thermal_init() was successful.

Thanks,
Armin Wolf

>   }
>
>   /* dell-rbtn.c driver export functions which will not work correctly (=
and could
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

