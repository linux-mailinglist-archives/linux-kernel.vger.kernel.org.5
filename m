Return-Path: <linux-kernel+bounces-43772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 512638418BC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2CD72849F8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C6E364B1;
	Tue, 30 Jan 2024 02:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="YwBT5ePn"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A616364A1;
	Tue, 30 Jan 2024 02:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706580191; cv=none; b=P9X4bQC5ByVTlE18U4FbFMV1XJYtwJbIEMy1RNAEH5CFOKSGE0+f3Ufh5VLGvuD6aI+CisoCpbApFByNlaX2Tbs/jNpKUjoplBjhsYku2G8BxiYFPA4YpCZqbEdwx8Fi3aMEC4zJIhOL19vaBi4LgHSsMVWcCZQAAk3uihjXDmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706580191; c=relaxed/simple;
	bh=Zxize6MwWsvIVjrOsAPOOYpEQj3Tt6iR4kx7UibsFBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IXnD6udtToSPptSHhkz2Xbn6IoTN0QH2VEu7SeOmDoHV2+kEZtLSxa57fodTgudpsK8NDlq03sTfieQc/bzIY7Wg6AutKSC9orSb9nPn3M4kAOpDZWbL0pko7z4rl1ZtnBvx7rFi5b5TvpNTm0YGmXuTaiJbq/1XlzP2GmX3z8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=YwBT5ePn; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1706580131; x=1707184931; i=w_armin@gmx.de;
	bh=Zxize6MwWsvIVjrOsAPOOYpEQj3Tt6iR4kx7UibsFBs=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=YwBT5ePnxQwsy/+x4FkyxGwjfb2pHKUIFUKeMHhmcpO2n6MyBecIbshcRvIbB+cL
	 Q2VH10tucuEDIm9WJEYDP+tTxfGz2CnDprLTjNCaefMAUIX3b8YqKp/oiedGt/zpO
	 P7nyDPRyWAlbs4XKh9ijcVqp3lmnurkr3ktVslpyQhw0IJRFZwmOQEmNQqt+Z3r0K
	 g7ssh8Wt9/idJYpJ6UPyXEp6d1MGABL4FS30yMMVIV7sp875pijyytLchHfp92p6S
	 vJ++WlvByfroo9Xa/ZBgtF6Gp3AmD9kMmRh/btSnEq1QYFp2N71O/oZ5/nci9EnaG
	 T1dS4/8oW67d1dgHCQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.35] ([91.137.126.34]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N2V0B-1r440i2pkF-013vuB; Tue, 30
 Jan 2024 03:02:11 +0100
Message-ID: <fabf391c-933c-4a7b-a23c-d361ad3d7cc0@gmx.de>
Date: Tue, 30 Jan 2024 03:02:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2] platform/x86/fujitsu-laptop: Add battery charge
 control support
To: Szilard Fabian <szfabian@bluemarch.art>, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, jwoithe@just42.net,
 hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com
References: <20240129163502.161409-2-szfabian@bluemarch.art>
 <20240129175714.164326-2-szfabian@bluemarch.art>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20240129175714.164326-2-szfabian@bluemarch.art>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KZm0EGG8+/DE4MIPVf22w5ipQ30Io/qYOl/sVQpyfnltb86YIG0
 sn/1EcjUJ3JdzdvhHnLSbsXjPMwlSluORw9F5BhCdntNl/AwImQWDN5zLmEUyaD73CeUgYM
 2aklcRKf333X6NqJLDtiB72OukgANdhFZN02jbChg9gXRKN4KbQxJOfDs41EicNsEcF6+0T
 gsDDj7V/8WYaEuz/Opv5Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:W88KII8sWAI=;l0dMNUJjAicsIRMxYpHiBeUe7HF
 dA4nkncqNmy2OS3q8XjJ8IoJNzOtDtFoomCdMjZOKhdi7ohr1/mLjMni27ilGKEX3dZo0wpcJ
 SCkThL+0gfvSt1yM/S1p2kmF+uarhgbWCtYudPTZihxFEK6fonmB7X++v05a0jGLKAd7OOu7M
 nx7AuPAwx1IPy7adOwblm8YytSd/YmK1U17qd29ZkfleOXwV+LCrtGbe8/HmfaYgcCaUnIggk
 Yxf5+EcpD4+Tn+nVEMazlJttHqxAvXMd98EdjyUKeqO+ixp3F9oYubqyWqevtw+40XwSDe7wX
 DamMeheIlv3kPrzSKyiW27qeax/3FM4qEqSklgRfyr0xqoS98Yr5a75IbTyVaHFQoUib0zOqn
 lnzU5fd3vvWUVOpP7tgl6c8jSLQyle283fBciDXs+bkJvY04vj1hjgdzOSiQyl40ViAVjXiyA
 NNZbyaQJOGj9t9Tk04tdsqEqzgThlP7qBRIKf3dQZAnMtc5lPTMPYP452CBHgXE7j3DdUUCRh
 u3xSHZZxFnupx0Qr5sxmDgqYbf61xqKg0dltX76q9MZqyO2SxFT1Ks5SCFyfUzjhLE7CV/iD0
 mx6gK7IxsgQQ2RpY1Edekp4xnBxcA66xi3ElidIBq4YX2SAMoKTqtt1LMPOxz2Acnp2P4rfee
 RTtFk8XTN573g2QylCjEYmlXuHKap0DUnT3b1fGX1WbetoGb2HkmGZMTEECNYoGKYpWtK/5Q7
 5TygFFqhxax3brStEUyQpm9g/iCJtu5/8ba4uW3EGaCv9KlrEXzUNcLlaHJ52dVOjRpxBapnm
 K4apI5Fb5s4BgYdkKtS/aOP2kmXxi1jrLzEdf/Fxs5prQBEyB7cUGWA8F3alDkrjzJItehQJa
 iK1M3BUnsTdliaaCgUyz7m9DFf1wLk1SD6eAeLdwzPIGYcufrPWkeevQ9P6VqVC7WLMnB1MkH
 RCYLlHishjffp9dve2CMp9n8WV4=

Am 29.01.24 um 19:00 schrieb Szilard Fabian:

> This patch adds battery charge control support on Fujitsu notebooks
> via the S006 method of the FUJ02E3 ACPI device. With this method it's
> possible to set charge_control_end_threshold between 50 and 100%.
>
> Tested on Lifebook E5411 and Lifebook U728. Sadly I can't test this
> patch on a dual battery one, but I didn't find any clue about
> independent battery charge control on dual battery Fujitsu notebooks
> either. And by that I mean checking the DSDT table of various Lifebook
> notebooks and reverse engineering FUJ02E3.dll.
>
> Signed-off-by: Szilard Fabian <szfabian@bluemarch.art>
> ---
> v2:
> Forgot to sign-off the original commit. Fixed, sorry for the
> inconvenience.
> ---
>   drivers/platform/x86/fujitsu-laptop.c | 95 +++++++++++++++++++++++++++
>   1 file changed, 95 insertions(+)
>
> diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x8=
6/fujitsu-laptop.c
> index 085e044e888e..bf3df74e4d63 100644
> --- a/drivers/platform/x86/fujitsu-laptop.c
> +++ b/drivers/platform/x86/fujitsu-laptop.c
> @@ -49,6 +49,8 @@
>   #include <linux/kfifo.h>
>   #include <linux/leds.h>
>   #include <linux/platform_device.h>
> +#include <linux/power_supply.h>
> +#include <acpi/battery.h>
>   #include <acpi/video.h>
>
>   #define FUJITSU_DRIVER_VERSION		"0.6.0"
> @@ -97,6 +99,10 @@
>   #define BACKLIGHT_OFF			(BIT(0) | BIT(1))
>   #define BACKLIGHT_ON			0
>
> +/* FUNC interface - battery control interface */
> +#define FUNC_S006_METHOD		0x1006
> +#define CHARGE_CONTROL_RW		0x21
> +
>   /* Scancodes read from the GIRB register */
>   #define KEY1_CODE			0x410
>   #define KEY2_CODE			0x411
> @@ -164,6 +170,91 @@ static int call_fext_func(struct acpi_device *devic=
e,
>   	return value;
>   }
>
> +/* Battery charge control code */
> +
> +static ssize_t charge_control_end_threshold_store(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf, size_t count)
> +{
> +	int value, ret;
> +
> +	ret =3D kstrtouint(buf, 10, &value);
> +	if (ret)
> +		return ret;
> +
> +	if (value < 50 || value > 100)
> +		return -EINVAL;
> +
> +	int cc_end_value, s006_cc_return;
> +
> +	cc_end_value =3D value * 0x100 + 0x20;
> +	s006_cc_return =3D call_fext_func(fext, FUNC_S006_METHOD,
> +					CHARGE_CONTROL_RW, cc_end_value, 0x0);

Hi,

Error handling is missing for call_fext_func(), as it can return an negati=
ve error code.

> +
> +	/*
> +	 * The S006 0x21 method returns 0x00 in case the provided value
> +	 * is invalid.
> +	 */
> +	if (s006_cc_return =3D=3D 0x00)
> +		return -EINVAL;
> +
> +	return count;
> +}
> +
> +static ssize_t charge_control_end_threshold_show(struct device *dev,
> +				struct device_attribute *attr,
> +				char *buf)
> +{
> +	int status;
> +	status =3D call_fext_func(fext, FUNC_S006_METHOD,
> +				CHARGE_CONTROL_RW, 0x21, 0x0);

Same as above.

> +
> +	return sprintf(buf, "%d\n", status);
> +}
> +
> +static DEVICE_ATTR_RW(charge_control_end_threshold);
> +
> +/* ACPI battery hook */
> +
> +static int fujitsu_battery_add(struct power_supply *battery,
> +			       struct acpi_battery_hook *hook)
> +{
> +	/* Check if there is an existing FUJ02E3 ACPI device. */
> +	if (fext =3D=3D NULL)
> +		return -ENODEV;

Can you put the struct acpi_battery_hook into the struct fujitsu_laptop
and then use container_of() to retrieve the ACPI device from there?
The dell-wmi-ddv driver does something similar.

This would guarantee that the battery hook always accesses the correct ACP=
I device
and you could drop this check.

> +
> +	/*
> +	 * Check if the S006 0x21 method exists by trying to get the current
> +	 * battery charge limit.
> +	 */
> +	int s006_cc_return;
> +	s006_cc_return =3D call_fext_func(fext, FUNC_S006_METHOD,
> +					CHARGE_CONTROL_RW, 0x21, 0x0);
> +	if (s006_cc_return =3D=3D UNSUPPORTED_CMD)
> +		return -ENODEV;

Maybe this check should be done once during probe?

> +
> +	if (device_create_file(&battery->dev,
> +			       &dev_attr_charge_control_end_threshold))
> +		return -ENODEV;
> +
> +	return 0;

Better to just return the result of device_create_file() here.

Thanks,
Armin Wolf

> +}
> +
> +static int fujitsu_battery_remove(struct power_supply *battery,
> +				  struct acpi_battery_hook *hook)
> +{
> +	device_remove_file(&battery->dev,
> +			   &dev_attr_charge_control_end_threshold);
> +
> +	return 0;
> +}
> +
> +static struct acpi_battery_hook battery_hook =3D {
> +	.add_battery =3D fujitsu_battery_add,
> +	.remove_battery =3D fujitsu_battery_remove,
> +	.name =3D "Fujitsu Battery Extension",
> +};
> +
>   /* Hardware access for LCD brightness control */
>
>   static int set_lcd_level(struct acpi_device *device, int level)
> @@ -839,6 +930,8 @@ static int acpi_fujitsu_laptop_add(struct acpi_devic=
e *device)
>   	if (ret)
>   		goto err_free_fifo;
>
> +	battery_hook_register(&battery_hook);
> +
>   	return 0;
>
>   err_free_fifo:
> @@ -851,6 +944,8 @@ static void acpi_fujitsu_laptop_remove(struct acpi_d=
evice *device)
>   {
>   	struct fujitsu_laptop *priv =3D acpi_driver_data(device);
>
> +	battery_hook_unregister(&battery_hook);
> +
>   	fujitsu_laptop_platform_remove(device);
>
>   	kfifo_free(&priv->fifo);

