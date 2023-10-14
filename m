Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399F57C974E
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 01:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbjJNXjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 19:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjJNXji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 19:39:38 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E927A9;
        Sat, 14 Oct 2023 16:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1697326759; x=1697931559; i=w_armin@gmx.de;
 bh=l0lLG2Be63Vp+UODA2JuhJ/gylJq81V3ALg9rHeYehQ=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=okFF1wmg/N/GP7ub+OhhJvorDEE2UA6UcdVGwfpsdtCwzrGqMXJTq9FhHxzfnuSEzeoDw/fgHzy
 hM6OA85Suuj293Kt+3iNI9/eFSBvNkstygcjyFU8aTMnn3atcRmTBSJZ2q60KXR0jPm8/AVSNU3IZ
 2+aWKdqA5bWzrYJXTy72aM5DXoKFHlJHMhpkC49fdhy3s5ZQ/h819B/HqBm0w+l5/OU7Cgq4s6zc5
 zMDTUtPr/M8Za/0FBGGOk07JH2BSvrbSIDe57XkzQ+V7jxKitIHOvTvYerVKh24UgfLG9dMBxy83F
 HEa7Bmc1ivneA8IwfWMSU0xOBdina5Ma5dsg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1My36T-1rlJ601vSx-00zaZt; Sun, 15
 Oct 2023 01:39:19 +0200
Message-ID: <d3245372-0cd4-49ff-acbc-87ff156a00fc@gmx.de>
Date:   Sun, 15 Oct 2023 01:39:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] platform/x86: support to store/show powermode value
 for Inspur
To:     Ai Chao <aichao@kylinos.cn>, hdegoede@redhat.com,
        ilpo.jarvinen@linux.intel.com, markgross@kernel.org
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20231014032844.3823198-1-aichao@kylinos.cn>
Content-Language: en-US
From:   Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20231014032844.3823198-1-aichao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yhgEJJiiKpj6ehc1+zVyv6fBzpr3wxxYWYW9x1qyMMR4ID+xC3r
 9c+ojstsbFjrIP3kv3ls5iWa+08YxTOTcIwnjtCFOhgxcK3xlBLVrsEB7tLJ2cnLgOnBuPO
 FWyv4HBNmO3lY3RvG4L65aAmoXoTqii23HQG+RVaZ6WWyvMIEqY8DuD8H6THszIMoVGLPvw
 n0zvFZPqLG7Sq0k9/Ds9g==
UI-OutboundReport: notjunk:1;M01:P0:crr0p7Tctx8=;rB33qj3gOaRzI+P08nUJGdajj24
 KuelCtRftrTjkpXbaInTCMgEoyzPaViZewiqJBNjeL/W3jNynAlAEdc4sIwGCTLv8tut7/WF9
 /o+7n2MLQH9SYjKcpPc6y/jJuOwWYZlFwugXSEVPpjX15FqltyWVNbyp93ApV1F0fqYhtpRMG
 c69PDUClXajWrLmS34A7q3OcXTswOMxQXYdoYNrL7o69W37RY8Vjjwswf7ljP5ukl4Avp/dFf
 KBnPm/pyuGC+tP8tRGreTENk9EZQm1r5akZ9rxAdGKNIfwN3jplzumztLF/IXEH9SpogjBsRZ
 3TZrfxOTTINcCQMZCNOzBBI84hbxmwFww3AOWVJSkTYeNvo1QLUyWWVhrdkhLHHo5bTcy/VOL
 bP1yeuo+pphYzfOu1kC1clqAJwqMkj2mLUdNp+27BcrzvNbdc2ebw42PdohEhRr+FHl3LFhJJ
 7GYSqmbTvQN5hBzRixQUCxv6BoXWnKiVlEYzsz3HVMjogRcKuTohrtSv/eJHDnpYHoto/qWeD
 ye3ppCFncpuhPyVa00EmgzW+W0OYvwdEwWsPykRWzU1iirg1po5YuAdly12/FU70bDQA2afLK
 KJhji080iF/oCRGJdXK9DiQiTiC1cc38HI3JyQdV9gXBSCHGRYl+mR7TPELZ/sa4YlQD7Tu6K
 tCb9++TrDNDizzGRtMVrFRew6i4Qe3kDVTscQWQ294z3CtOR3qRO/7vuYKOJguZbNTXbs+E2V
 xuY0wQ0cP6ueeW6QSodiIpsK9SV78dGtBxkBRgtpAMrBXlvgfXAVT2hYasz46DqBSXoHA7xxJ
 bIytW2xEOp6gLFCS+GPQk19zhok1SAqq1VNzZ/lXFVjWshv4O243c4R5Uryv5tZ4XxQ3jhvR5
 d8qQGsEBFOxfZeBreHV/WHba5xo14An+CyO4EvogkNSDoyF7GQ0UseiZNCy46I4uphD5hmaNN
 Ib+5sq2ZV/+uX8pxODMcstyKSuI=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 14.10.23 um 05:28 schrieb Ai Chao:

> Support to store/show powermode value for Inspur by WMI interface.
> This driver provides support for Inspur WMI hotkeys. User used Fn+Q to
> change the power mode. If desktop applications receive hotkey(Fn+Q)
> event, then it get the currently power mode and change the power mode.
> The desktop applications modify brightness and cpufreq based on
> power mode.
>
> change for v2
> - Remove Event GUID, remove inspur_wmi_notify and inspur_wmi_notify.
> - Add more explanation.
>
> Signed-off-by: Ai Chao <aichao@kylinos.cn>
> ---
>   drivers/platform/x86/Kconfig      |  14 ++
>   drivers/platform/x86/Makefile     |   3 +
>   drivers/platform/x86/inspur-wmi.c | 210 ++++++++++++++++++++++++++++++
>   3 files changed, 227 insertions(+)
>   create mode 100644 drivers/platform/x86/inspur-wmi.c
>
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 2a1070543391..fa2a4335c83d 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -988,6 +988,20 @@ config TOUCHSCREEN_DMI
>   	  the OS-image for the device. This option supplies the missing info.
>   	  Enable this for x86 tablets with Silead or Chipone touchscreens.
>
> +config INSPUR_WMI
> +	tristate "Inspur WMI hotkeys driver"
> +	depends on ACPI_WMI
> +	depends on INPUT

The driver does not provide a input device anymore, please remove the
dependency on CONFIG_INPUT.

> +	help
> +	This driver provides support for Inspur WMI hotkeys.
> +	User used Fn+Q to change the power mode. If desktop applications
> +	receive hotkeys(Fn+Q) event, then it get the currently power mode
> +	and change the power mode. The desktop applications modify brightness
> +	and cpufreq based on power mode.
> +

I assume the whole hotkey stuff uses the other WMI GUID, right? In this ca=
se the
current driver should not be called "Inspur WMI hotkeys driver", since it =
does not
handle those hotkey notifications. Better call it "Inspur WMI power mode d=
river",
and remove all references to the hotkeys.

> +	To compile this driver as a module, choose M here: the module
> +	will be called inspur-wmi.
> +
>   source "drivers/platform/x86/x86-android-tablets/Kconfig"
>
>   config FW_ATTR_CLASS
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefi=
le
> index b457de5abf7d..9285c252757e 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -98,6 +98,9 @@ obj-$(CONFIG_TOSHIBA_WMI)	+=3D toshiba-wmi.o
>   # before toshiba_acpi initializes
>   obj-$(CONFIG_ACPI_TOSHIBA)	+=3D toshiba_acpi.o
>
> +# Inspur
> +obj-$(CONFIG_INSPUR_WMI)	+=3D inspur-wmi.o
> +
>   # Laptop drivers
>   obj-$(CONFIG_ACPI_CMPC)		+=3D classmate-laptop.o
>   obj-$(CONFIG_COMPAL_LAPTOP)	+=3D compal-laptop.o
> diff --git a/drivers/platform/x86/inspur-wmi.c b/drivers/platform/x86/in=
spur-wmi.c
> new file mode 100644
> index 000000000000..ef6cfd87f074
> --- /dev/null
> +++ b/drivers/platform/x86/inspur-wmi.c
> @@ -0,0 +1,210 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  Inspur WMI hotkeys
> + *
> + *  Copyright (C) 2018	      Ai Chao <aichao@kylinos.cn>
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/device.h>
> +#include <linux/input.h>
> +#include <linux/module.h>
> +#include <linux/wmi.h>
> +
> +#define WMI_INSPUR_POWERMODE_BIOS_GUID "596C31E3-332D-43C9-AEE9-5854932=
84F5D"
> +
> +enum inspur_wmi_method_ids {
> +	INSPUR_WMI_GET_POWERMODE =3D 0x02,
> +	INSPUR_WMI_SET_POWERMODE =3D 0x03,
> +};
> +
> +struct inspur_wmi_priv {
> +	struct input_dev *idev;
> +	struct wmi_device *wdev;
> +};
> +
> +static int inspur_wmi_perform_query(struct wmi_device *wdev,
> +				    enum inspur_wmi_method_ids query_id,
> +				    void *buffer, size_t insize,
> +				    size_t outsize)
> +{
> +	union acpi_object *obj;
> +	acpi_status status;
> +	int ret =3D 0;
> +	struct acpi_buffer input =3D { insize, buffer};
> +	struct acpi_buffer output =3D { ACPI_ALLOCATE_BUFFER, NULL };

Please order the variable declarations in a reverse xmas tree order,
seeDocumentation/process/maintainer-netdev.rst#Local variable ordering for
details.

> +
> +	status =3D wmidev_evaluate_method(wdev, 0, query_id, &input, &output);
> +	if (ACPI_FAILURE(status)) {
> +		dev_err(&wdev->dev, "EC Powermode control failed: %s\n",
> +			acpi_format_exception(status));
> +		return -EIO;
> +	}
> +
> +	obj =3D output.pointer;
> +	if (!obj)
> +		return -EINVAL;
> +
> +	if (obj->type !=3D ACPI_TYPE_BUFFER) {
> +		ret =3D -EINVAL;
> +		goto out_free;
> +	}
> +
> +	/* Ignore output data of zero size */
> +	if (!outsize)
> +		goto out_free;

Since all users of this functions set outsize to something greater than ze=
ro,
this check is pointless. Please remove it.

> +
> +	if (obj->buffer.length !=3D outsize) {
> +		ret =3D -EINVAL;
> +		goto out_free;
> +	}
> +
> +	memcpy(buffer, obj->buffer.pointer, obj->buffer.length);
> +
> +out_free:
> +	kfree(obj);
> +	return ret;
> +}
> +
> +/**
> + * Set Power Mode to EC RAM. If Power Mode value greater than 0x3,
> + * return error
> + * Method ID: 0x3
> + * Arg: 4 Bytes
> + * Byte [0]: Power Mode:
> + *         0x0: Balance Mode
> + *         0x1: Performance Mode
> + *         0x2: Power Saver Mode
> + * Return Value: 4 Bytes
> + * Byte [0]: Return Code
> + *         0x0: No Error
> + *         0x1: Error
> + */

Now i understand what this power mode means. Why not use the platform prof=
ile interface
for this? All tree modes (Balance, Performance, Power Saver) would perfect=
ly map to standard
platform profiles (BALANCED, PERFORMANCE, LOW_POWER), and using the platfo=
rm profile interface
would allow userspace software to control the power mode over a standard i=
nterface.

I believe drivers/platform/surface/surface_platform_profile.c is a good ex=
ample for such a driver,
_except_ that it ignores the return value of platform_profile_register().

> +static ssize_t powermode_store(struct device *dev,
> +			       struct device_attribute *attr,
> +			       const char *buf, size_t count)
> +{
> +	struct inspur_wmi_priv *priv =3D dev_get_drvdata(dev);
> +	int ret;
> +	u32 mode;

Since the buffer passed to the WMI method is structured in bytes, maybe yo=
u could use a
byte array in those cases? This would remove the need to cast "mode" to a =
"u8 *".

> +	u8 *ret_code;
> +
> +	ret =3D kstrtoint(buf, 0, &mode);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D inspur_wmi_perform_query(priv->wdev,
> +				       INSPUR_WMI_SET_POWERMODE,
> +				       &mode, sizeof(mode), sizeof(mode));
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	ret_code =3D (u8 *)(&mode);
> +	if (ret_code[0])
> +		return -EBADRQC;
> +
> +	return count;
> +}
> +
> +/**
> + * Get Power Mode from EC RAM, If Power Mode value greater than 0x3,
> + * return error
> + * Method ID: 0x2
> + * Return Value: 4 Bytes
> + * Byte [0]: Return Code
> + *         0x0: No Error
> + *         0x1: Error
> + * Byte [1]: Power Mode
> + *         0x0: Balance Mode
> + *         0x1: Performance Mode
> + *         0x2: Power Saver Mode
> + */
> +static ssize_t powermode_show(struct device *dev,
> +			      struct device_attribute *attr,
> +			      char *buf)
> +{
> +	struct inspur_wmi_priv *priv =3D dev_get_drvdata(dev);
> +	u32 mode =3D 0;

Same as above.

> +	int ret;
> +	u8 *ret_code;
> +
> +	ret =3D inspur_wmi_perform_query(priv->wdev,
> +				       INSPUR_WMI_GET_POWERMODE,
> +				       &mode, sizeof(mode), sizeof(mode));
> +	if (ret < 0)
> +		return ret;
> +
> +	ret_code =3D (u8 *)(&mode);
> +	if (ret_code[0])
> +		return -EBADRQC;
> +
> +	return sprintf(buf, "%u\n", ret_code[1]);
> +}
> +
> +static DEVICE_ATTR_RW(powermode);
> +
> +static struct attribute *inspur_wmi_attrs[] =3D {
> +	&dev_attr_powermode.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group inspur_wmi_group =3D {
> +	.attrs =3D inspur_wmi_attrs,
> +};
> +
> +static const struct attribute_group *inspur_wmi_groups[] =3D {
> +	&inspur_wmi_group,
> +	NULL,
> +};
> +
> +static int inspur_wmi_input_setup(struct wmi_device *wdev)
> +{
> +	struct inspur_wmi_priv *priv =3D dev_get_drvdata(&wdev->dev);
> +
> +	priv->idev =3D devm_input_allocate_device(&wdev->dev);
> +	if (!priv->idev)
> +		return -ENOMEM;
> +
> +	priv->idev->name =3D "Inspur WMI hotkeys";
> +	priv->idev->phys =3D "wmi/input0";
> +	priv->idev->id.bustype =3D BUS_HOST;
> +	priv->idev->dev.parent =3D &wdev->dev;
> +
> +	return input_register_device(priv->idev);
> +}

Please remove all remains of the hotkey handling.

> +
> +static int inspur_wmi_probe(struct wmi_device *wdev, const void *contex=
t)
> +{
> +	struct inspur_wmi_priv *priv;
> +
> +	priv =3D devm_kzalloc(&wdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->wdev =3D wdev;
> +	dev_set_drvdata(&wdev->dev, priv);
> +
> +	return inspur_wmi_input_setup(wdev);
> +}
> +
> +static const struct wmi_device_id inspur_wmi_id_table[] =3D {
> +	{ .guid_string =3D WMI_INSPUR_POWERMODE_BIOS_GUID },
> +	{  }
> +};
> +
> +static struct wmi_driver inspur_wmi_driver =3D {
> +	.driver =3D {
> +		.name =3D "inspur-wmi",
> +		.dev_groups =3D inspur_wmi_groups,
> +	},
> +	.id_table =3D inspur_wmi_id_table,
> +	.probe =3D inspur_wmi_probe,
> +};
> +
> +module_wmi_driver(inspur_wmi_driver);
> +
> +MODULE_DEVICE_TABLE(wmi, inspur_wmi_id_table);

Can you move this right below "inspur_wmi_id_table" please?

> +MODULE_AUTHOR("Ai Chao <aichao@kylinos.cn>");
> +MODULE_DESCRIPTION("Inspur WMI hotkeys");
> +MODULE_LICENSE("GPL");
