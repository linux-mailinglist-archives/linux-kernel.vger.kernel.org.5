Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4217CFBE3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345905AbjJSOCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345856AbjJSOCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:02:37 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51E713A;
        Thu, 19 Oct 2023 07:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1697724122; x=1698328922; i=w_armin@gmx.de;
        bh=XLz4MkuJggEFcvdCwWamftCG3XlaaH0oc/PILjfXK8A=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
         In-Reply-To;
        b=YRghujgjROHxwZrenKMdCRGbpRablV+RpQQgh675Pcg9ow1RzLzy4t9wcU9N534Z
         VqxR6DTGd16Mrl8UM5BJPVRwJSaT1ZPNZrFzJgxnPbBjHU62pWVkKzJmRzH8Xttom
         FT9eQs9q934LEi18RJoqTtwS6Pt8TxHhAzxY71Z3V36FzBzvadwSVbeULp7FrojtM
         Crv8YXS8Q3kcrynqbdpaycBOwJ19jsR03nMiAGJH0+C169ttr24kLws1eMcrJJsLi
         ZYCJ1ALtPISFPQNfBlIMn1K09KTmAHPnutVguZT8+mGBMn70KH6nBeU3jqVWSeEoL
         NUViJjVtSlBFHqLM2g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MJmKh-1rD4uh10Q5-00KBoN; Thu, 19
 Oct 2023 16:02:02 +0200
Message-ID: <5af4ecf5-1be8-4c61-b30f-f36590f51423@gmx.de>
Date:   Thu, 19 Oct 2023 16:02:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] platform/x86: inspur-wmi: Add platform profile support
To:     Ai Chao <aichao@kylinos.cn>, hdegoede@redhat.com,
        ilpo.jarvinen@linux.intel.com, markgross@kernel.org
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20231019030534.157971-1-aichao@kylinos.cn>
Content-Language: en-US
From:   Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20231019030534.157971-1-aichao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VpTXpww+60Qs8keKdCfaiTWSa9zOd0PnrssA5f4T4VtOIFFDhFb
 cGmACBTTACREt9i5rpn210nRSXYdLK8cprQft/Qwko0Y2R8zy+Q6gAqsSo+ZFDIC7cHBLFk
 fWh5oAyn/YvuPx+CuYieXxkyVIeIDuVfJL2zkZt1q+mJ7qtS7vroO4CY/NpQItwSljLU3EH
 dcUV1CmrYq9WdNHRnHDTA==
UI-OutboundReport: notjunk:1;M01:P0:5ODjVv6fxhE=;DNmBgsBOr9xmoRZ87jV6TMHclqw
 ZDt3VuS/GRUjOESMV19Ybfs8JwMfI+vDJbC2KgczBnrt3hX3HdIaqG6uuoQdnXsJvcv3AXXxc
 Y73rRvp38OG6N4bUeuIZMAS9QkXKPGRMcUDqYKC8ut5wCAP3cECjzLd5IiD1fLOq0WDyIID58
 RbML6sj9WmyJfiV15BW+dvG8LgBXrnOgbU7WwyOYvK/Nbrz63YXjJFLApPg4stYle/Hb6g0lF
 L5XNTNW0NxpXN847T9eklU+yv+elbjGdxF8nftv1FUksyp6YJW1PyYvRgq19XxPGHzckuOqL8
 TrhjxBrUPXhF+lxa2i+pDylW0yQlhhFsEybw36hF5kw4Z1psIDGicV4OY4l5pEReDlI/dWP6v
 DdN3ZSiZVGoOiB4cXgN1M8On5P5uZD8t3PDZAIj8xCdWRMmE+I5s0YSpD1w75aMZqi+Q1vsup
 rp7XVLdMVN4XFE6QpirGJwaI3dcz3+cEGH0z8Y2VV2QZx96rsgSU+fvagSdp3d6/VRu1fbja1
 /os3T/iz6ro4e3LXSXVVX2fqw0TrjISlEpHUnASnawcLneQCKLoUVvFJGbZXYqqibgRivY2xz
 NRJtEsFaNxPO3ZCXFdlzAHBOQ8+8prJNQ0NqXSvfZxle05/xJTiMYWQoSxqmhrrtrtOt3l8N/
 +zugTWmw/tj7NeodP4gBuHYNb39lt30YiKq3yJAPYntkt2/ulQgQo6aB8AlZr6TiTUldOHkbF
 SkyNDvSWwSbEjvErASs3vEBWroQi0SnO+PaBAfnibS7lBwCcvVGS5T5S4qliHstrtsTJuKZN9
 CEqyakhotns+CDEfGbwcG6EuKj8vvr+uy7YDOR6fjHvdpLmXqKsT5ELHXNH92mnq9HBiP9P2l
 pHD0cOv0aHq71jVGVYsc43Js9+58uM2q4Y9F8TvsjVFkhm6zRXk0+DsXNMwbUf315CBfUB9jT
 QuP/aQpmELDtTxnIaLD/hIQs+8A=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 19.10.23 um 05:05 schrieb Ai Chao:

> Add support for Inspur platforms to used the platform profile feature.
>
> This will allow users to determine and control the platform modes
> between low-power, balanced and performance modes.
>
> Signed-off-by: Ai Chao <aichao@kylinos.cn>
> ---
>
> v4: Add select ACPI_PLATFORM_PROFILE
> v3: Remove input device, using the platform profile interface
> v2: Remove Event GUID, remove inspur_wmi_notify and inspur_wmi_notify.
>
>   drivers/platform/x86/Kconfig      |  11 ++
>   drivers/platform/x86/Makefile     |   3 +
>   drivers/platform/x86/inspur-wmi.c | 216 ++++++++++++++++++++++++++++++
>   3 files changed, 230 insertions(+)
>   create mode 100644 drivers/platform/x86/inspur-wmi.c

I agree with Thomas Wei=C3=9Fschuh that the driver name is a bit too gener=
ic, assuming
the WMI hotkey driver will appear sometime too.
Other than that, the driver seems good.

Armin Wolf

>
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 2a1070543391..44f371876170 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -988,6 +988,17 @@ config TOUCHSCREEN_DMI
>   	  the OS-image for the device. This option supplies the missing info.
>   	  Enable this for x86 tablets with Silead or Chipone touchscreens.
>
> +config INSPUR_WMI
> +	tristate "Inspur WMI platform profile driver"
> +	depends on ACPI_WMI
> +	select ACPI_PLATFORM_PROFILE
> +	help
> +	This will allow users to determine and control the platform modes
> +	between low-power, balanced and performance modes.
> +
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
> index 000000000000..243f31dd162c
> --- /dev/null
> +++ b/drivers/platform/x86/inspur-wmi.c
> @@ -0,0 +1,216 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  Inspur WMI power mode
> + *
> + *  Copyright (C) 2018	      Ai Chao <aichao@kylinos.cn>
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/platform_profile.h>
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
> +/**
> + * Power Mode:
> + *           0x0: Balance Mode
> + *           0x1: Performance Mode
> + *           0x2: Power Saver Mode
> + */
> +enum inspur_tmp_profile {
> +	INSPUR_TMP_PROFILE_BALANCE	=3D 0,
> +	INSPUR_TMP_PROFILE_PERFORMANCE	=3D 1,
> +	INSPUR_TMP_PROFILE_POWERSAVE	=3D 2,
> +};
> +
> +struct inspur_wmi_priv {
> +	struct wmi_device *wdev;
> +	struct platform_profile_handler handler;
> +};
> +
> +static int inspur_wmi_perform_query(struct wmi_device *wdev,
> +				    enum inspur_wmi_method_ids query_id,
> +				    void *buffer, size_t insize,
> +				    size_t outsize)
> +{
> +	struct acpi_buffer output =3D { ACPI_ALLOCATE_BUFFER, NULL };
> +	struct acpi_buffer input =3D { insize, buffer};
> +	union acpi_object *obj;
> +	acpi_status status;
> +	int ret =3D 0;
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
> +	if (obj->type !=3D ACPI_TYPE_BUFFER ||
> +	    obj->buffer.length !=3D outsize) {
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
> +static int inspur_platform_profile_set(struct platform_profile_handler =
*pprof,
> +				       enum platform_profile_option profile)
> +{
> +	struct inspur_wmi_priv *priv =3D container_of(pprof, struct inspur_wmi=
_priv,
> +						    handler);
> +	u8 ret_code[4] =3D {0, 0, 0, 0};
> +	int ret;
> +
> +	switch (profile) {
> +	case PLATFORM_PROFILE_BALANCED:
> +		ret_code[0] =3D INSPUR_TMP_PROFILE_BALANCE;
> +		break;
> +	case PLATFORM_PROFILE_PERFORMANCE:
> +		ret_code[0] =3D INSPUR_TMP_PROFILE_PERFORMANCE;
> +		break;
> +	case PLATFORM_PROFILE_LOW_POWER:
> +		ret_code[0] =3D INSPUR_TMP_PROFILE_POWERSAVE;
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	ret =3D inspur_wmi_perform_query(priv->wdev, INSPUR_WMI_SET_POWERMODE,
> +				       ret_code, sizeof(ret_code),
> +				       sizeof(ret_code));
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	if (ret_code[0])
> +		return -EBADRQC;
> +
> +	return 0;
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
> +static int inspur_platform_profile_get(struct platform_profile_handler =
*pprof,
> +				       enum platform_profile_option *profile)
> +{
> +	struct inspur_wmi_priv *priv =3D container_of(pprof, struct inspur_wmi=
_priv,
> +						    handler);
> +	u8 ret_code[4] =3D {0, 0, 0, 0};
> +	int ret;
> +
> +	ret =3D inspur_wmi_perform_query(priv->wdev, INSPUR_WMI_GET_POWERMODE,
> +				       &ret_code, sizeof(ret_code),
> +				       sizeof(ret_code));
> +	if (ret < 0)
> +		return ret;
> +
> +	if (ret_code[0])
> +		return -EBADRQC;
> +
> +	switch (ret_code[1]) {
> +	case INSPUR_TMP_PROFILE_BALANCE:
> +		*profile =3D PLATFORM_PROFILE_BALANCED;
> +		break;
> +	case INSPUR_TMP_PROFILE_PERFORMANCE:
> +		*profile =3D PLATFORM_PROFILE_PERFORMANCE;
> +		break;
> +	case INSPUR_TMP_PROFILE_POWERSAVE:
> +		*profile =3D PLATFORM_PROFILE_LOW_POWER;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
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
> +	priv->handler.profile_get =3D inspur_platform_profile_get;
> +	priv->handler.profile_set =3D inspur_platform_profile_set;
> +
> +	set_bit(PLATFORM_PROFILE_LOW_POWER, priv->handler.choices);
> +	set_bit(PLATFORM_PROFILE_BALANCED, priv->handler.choices);
> +	set_bit(PLATFORM_PROFILE_PERFORMANCE, priv->handler.choices);
> +
> +	return platform_profile_register(&priv->handler);
> +}
> +
> +static void inspur_wmi_remove(struct wmi_device *wdev)
> +{
> +	platform_profile_remove();
> +}
> +
> +static const struct wmi_device_id inspur_wmi_id_table[] =3D {
> +	{ .guid_string =3D WMI_INSPUR_POWERMODE_BIOS_GUID },
> +	{  }
> +};
> +
> +MODULE_DEVICE_TABLE(wmi, inspur_wmi_id_table);
> +
> +static struct wmi_driver inspur_wmi_driver =3D {
> +	.driver =3D {
> +		.name =3D "inspur-wmi",
> +		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> +	},
> +	.id_table =3D inspur_wmi_id_table,
> +	.probe =3D inspur_wmi_probe,
> +	.remove =3D inspur_wmi_remove,
> +};
> +
> +module_wmi_driver(inspur_wmi_driver);
> +
> +MODULE_AUTHOR("Ai Chao <aichao@kylinos.cn>");
> +MODULE_DESCRIPTION("Inspur WMI Platform Profile");
> +MODULE_LICENSE("GPL");
