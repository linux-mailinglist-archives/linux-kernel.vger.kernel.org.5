Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E827BCFA6
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 20:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344493AbjJHSlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 14:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234265AbjJHSld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 14:41:33 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3E4C6;
        Sun,  8 Oct 2023 11:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1696790472; x=1697395272; i=w_armin@gmx.de;
 bh=sz8J85AskNMinqsJofP0YVLXBsq3gB71ah+SNjP6zFo=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=VU4kWBjjS3b9mm+TWrXwGCFFzPjA4kZHUniUrWcSiO8Rn/RZc3TKyL85AQcnhjvxHAfZbFh5Cku
 kR9HLAcBpI76xghmemlm/sS24tUI3hLkC5vAzkH8VU90b7CLQqM2Al6OwMqk40fafgfHFE8uLfLPF
 8K5GdIeyxjS0hdPVZlJr2NjFixtuReteSZDjgAmuglpUzej98PvIS/o5Ut4VKQkP8NME9OTGn7TMw
 TpG+h2sVNwMxA+3X6GGO9AXZRHFWHL45lPhv/BzZlpwE5GDAPPeIdB5jFzjrwF441Mrmb1OdKHvw0
 kWyDQX6Ao2rOcYJeVHBcCf1MDBhe8t3lumoA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M26vL-1qs2cY3lgv-002Xwk; Sun, 08
 Oct 2023 20:41:11 +0200
Message-ID: <247119aa-651f-4320-8522-971e2a6e4054@gmx.de>
Date:   Sun, 8 Oct 2023 20:41:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: support to store/show powermode for Inspur
To:     Ai Chao <aichao@kylinos.cn>, hdegoede@redhat.com,
        ilpo.jarvinen@linux.intel.com, markgross@kernel.org
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20231008092149.967239-1-aichao@kylinos.cn>
Content-Language: en-US
From:   Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20231008092149.967239-1-aichao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0QOTPdnYCx06R7s7cDg1KnOXOLOPMdEerVopKQ9hgGquJqixOay
 JHkEniGar/jrvdlf8DGGmWfeo+GmxFbAkOv32wZBLtyPknRFVEjqRCHFHjNknJnBT0SA0k9
 2jgpiZYhCbcPheqshkrPJnSQMLysGIYQ/OsNJ2rtUAE8BLVzfP3S8Mu7s2alzEyUuA3dPmt
 sW5ekTTyGMv9K9ofPYL6w==
UI-OutboundReport: notjunk:1;M01:P0:2/V7JAdwNY4=;DfFvQvYoYiAb6luN5JcpTWBwBzw
 wVa02vtkhaZeZRnBtE/BcgEr4JFuL74xzfTE2Vxs+CEiax8XK+en388VwzVoxNM8j/1tOTBLa
 Zj5/k+QLF03iaZeW78B1b0iYqWBdg9H4pPHqD+D724z3BAy6bNfx4wJHHaZcOO2tblHm7/J99
 TwxX2VqZycX09+dxC39MwAW72wnSL6bJMAOvPx820ELr2PPnvr1eg43FCK4uIVlwQtCMxtU0V
 EmYf0JVmjoepwn38OB7ZuKagScha2LyKnIpGRPYjMcSvx1vptCe67Foxcwle1xg0Ia19vfKkf
 x/mNTV28g6ZAzD1pFRiZC5r5n732tUjD3w1jeDFPYvjXAMl1kzUVClm0UXwWTaaoigHf2upxl
 sPyhpO/2lXX/k2UPTnW5CZa6x8SJ6Gdb1I5M5+wuZn+kh/aE4P7QyP/Igk68tWISOMPAgUZh2
 xHvtgiTbqeG/6Zz17NXQ53yZUa/WOmcgviGPByXXp21nff/73K8dvDRnHT3sQPsc1XkByRcsX
 qRa8sDENWraFgHkpgSPeLyjcQVGEy8UDOvKrbm0caIcF5gZSNeuzsi4GNQfvqSctovxPZYdkS
 bI3H479J7EMy0Le3tGk86D0XNuPpe+oQJinFWcU9pL/dgsNp0/ZMhRqQAFxvxGs+Dr2oPYlWq
 iaZ1c2vWRhWPZvOHOTUjhPU88DV5Mzd1/eHht9uktfK8ti+ETDISEkP40tJG3gZnQN3UP84SC
 vIKSka2kMLSliW3S5pZ5uSNZO52/miEc8xTjW0BzxAu8g4M4IBHR7WmprKA6baftiJ1NME7SN
 kM7xQ7gj6Qp0/MkkZjOmXHPJkG/dOtXOsJiNjQenBVx2nbxW17LObA2plysK6gtomtlOhRQJ2
 CWWYHKpuwNZ5ReCfIk3W0+wtz/gjY77dWwDJHugrM7NRUcDySzAIW2PPjsp2ANCm3RiLlTuAW
 4e7PHP/M1Mteanxtk8L/NUCnL+8=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 08.10.23 um 11:21 schrieb Ai Chao:

> Support to store/show powermode for Inspur.
>
> Signed-off-by: Ai Chao <aichao@kylinos.cn>
> ---
>   drivers/platform/x86/Kconfig      |  11 ++
>   drivers/platform/x86/Makefile     |   3 +
>   drivers/platform/x86/inspur-wmi.c | 180 ++++++++++++++++++++++++++++++
>   3 files changed, 194 insertions(+)
>   create mode 100644 drivers/platform/x86/inspur-wmi.c
>
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 2a1070543391..9e565ee01a9f 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -988,6 +988,17 @@ config TOUCHSCREEN_DMI
>   	  the OS-image for the device. This option supplies the missing info.
>   	  Enable this for x86 tablets with Silead or Chipone touchscreens.
>
> +config INSPUR_WMI
> +	tristate "Inspur WMI hotkeys driver"
> +	depends on ACPI_WMI
> +	depends on INPUT
> +	help
> +	This driver provides support for Inspur WMI hotkeys.
> +	It's support to store/show powermode.
> +

Maybe "It supports to change the power mode."? A short explanation that th=
is power mode
does would also be helpful here.

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
> index 000000000000..6c4d722e98dc
> --- /dev/null
> +++ b/drivers/platform/x86/inspur-wmi.c
> @@ -0,0 +1,180 @@
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
> +#define WMI_INSPUR_POWERMODE_EVENT_GUID "854FA5AC-58C7-451D-AAB1-57D6F4=
E6DDD4"
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
> +};
> +
> +static int inspur_wmi_perform_query(char *guid,
> +		enum inspur_wmi_method_ids query_id,
> +		void *buffer, size_t insize, size_t outsize)
> +{
> +	union acpi_object *obj;
> +	int ret =3D 0;
> +	u32 wmi_outsize;
> +	struct acpi_buffer input =3D { insize, buffer};
> +	struct acpi_buffer output =3D { ACPI_ALLOCATE_BUFFER, NULL };
> +
> +	wmi_evaluate_method(guid, 0, query_id, &input, &output);
> +

Please use wmidev_evaluate_method() instead of the deprecated GUID-based i=
nterface.
And check the return value of this function.

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
> +
> +	wmi_outsize =3D min_t(size_t, outsize, obj->buffer.length);

Please return an error if the size of the returned buffer does not match t=
he size
requested by the caller. Otherwise the caller might process bogus values i=
f the buffer size
is smaller than requested.

> +	memcpy(buffer, obj->buffer.pointer, wmi_outsize);
> +
> +out_free:
> +	kfree(obj);
> +	return ret;
> +}
> +
> +static ssize_t powermode_store(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf, size_t count)
> +{
> +	int ret, mode;
> +
> +	ret =3D kstrtoint(buf, 0, &mode);
> +	if (ret)
> +		return ret;
> +
> +	inspur_wmi_perform_query(WMI_INSPUR_POWERMODE_BIOS_GUID,
> +			INSPUR_WMI_SET_POWERMODE,
> +			&mode, sizeof(mode), sizeof(mode));

Maybe use a fixed-width integer like u32 here? Also the return value of
inspur_wmi_perform_query() should be checked.

> +
> +	return count;
> +}
> +
> +
> +static ssize_t powermode_show(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	int mode =3D 0;
> +	u8 ret;
> +	u8 *ret_code;
> +
> +	inspur_wmi_perform_query(WMI_INSPUR_POWERMODE_BIOS_GUID,
> +			INSPUR_WMI_GET_POWERMODE,
> +			&mode, sizeof(mode), sizeof(mode));

Same as above.

> +	/*
> +	 *Byte [0]: Return code, 0x0 No error, 0x01 Error
> +	 *Byte [1]: Power Mode
> +	 */
> +	ret_code =3D (u8 *)(&mode);
> +	ret =3D ret_code[1];

Please check ret_code[0] for 0x01, and return an appropriate error code in=
 such a case.

> +
> +	return sprintf(buf, "%u\n", ret);
> +}
> +
> +DEVICE_ATTR_RW(powermode);

Please make this static.

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
> +const struct attribute_group *inspur_wmi_groups[] =3D {
> +	&inspur_wmi_group,
> +	NULL,
> +};

Same as above

> +
> +static void inspur_wmi_notify(struct wmi_device *wdev,
> +		union acpi_object *obj)
> +{
> +	//to do

Please insert something like "dev_notice(&wdev->dev, "Unknown WMI event: %=
u\n", event)" here
so people can find out the necessary hotkey events.

> +}
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
> +
> +static int inspur_wmi_probe(struct wmi_device *wdev, const void *contex=
t)
> +{
> +	struct inspur_wmi_priv *priv;
> +	int err;
> +
> +	priv =3D devm_kzalloc(&wdev->dev, sizeof(struct inspur_wmi_priv),
> +			GFP_KERNEL);

Please use "sizeof(*priv)" instead of "sizeof(struct inspur_wmi_priv)".
Also the alignment should match open parenthesis, please run "checkpatch -=
-strict".

> +	if (!priv)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(&wdev->dev, priv);
> +
> +	err =3D inspur_wmi_input_setup(wdev);
> +	return err;

The variable "err" can be omitted, just do "return inspur_wmi_input_setup(=
...)"

> +}
> +
> +static void inspur_wmi_remove(struct wmi_device *wdev)
> +{
> +	struct inspur_wmi_priv *priv =3D dev_get_drvdata(&wdev->dev);
> +
> +	input_unregister_device(priv->idev);

The kerneldoc comment for devm_input_allocate_device() says:

"Managed input devices do not need to be explicitly unregistered or freed =
as it will be done
automatically when owner device unbinds from its driver (or binding fails)=
."

Please drop inspur_wmi_remove().

> +}
> +
> +static const struct wmi_device_id inspur_wmi_id_table[] =3D {
> +	{ .guid_string =3D WMI_INSPUR_POWERMODE_EVENT_GUID },
> +	{  }
> +};

Can you share the bmof buffer describing this WMI device? Currently, both =
WMI GUIDs seem
to be independent from each other, so it would make more sense to create t=
wo separate WMI drivers.
The first driver would continue to handle the hotkey events, while the sec=
ond drivers allows to change
the power mode.

Thanks,
Armin Wolf

> +
> +static struct wmi_driver inspur_wmi_driver =3D {
> +	.driver =3D {
> +		.name =3D "inspur-wmi",
> +		.dev_groups =3D inspur_wmi_groups,
> +	},
> +	.id_table =3D inspur_wmi_id_table,
> +	.probe =3D inspur_wmi_probe,
> +	.notify =3D inspur_wmi_notify,
> +	.remove =3D inspur_wmi_remove,
> +};
> +
> +module_wmi_driver(inspur_wmi_driver);
> +
> +MODULE_DEVICE_TABLE(wmi, inspur_wmi_id_table);
> +MODULE_AUTHOR("Ai Chao <aichao@kylinos.cn>");
> +MODULE_DESCRIPTION("Inspur WMI hotkeys");
> +MODULE_LICENSE("GPL");
