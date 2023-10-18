Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C117CDB7D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 14:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjJRMYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 08:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJRMYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 08:24:00 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E1B98;
        Wed, 18 Oct 2023 05:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1697631805; x=1698236605; i=w_armin@gmx.de;
 bh=J8inPGaENfj5AX5fHY4Qxmsj43mCVkRHpG2HGtdnvy4=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=Q1DZtg1htmxqDTd0xDWxIoK84mc+73WgLcbAbjtkktpOP3KSxZWJGng/XI/nwXtwdQR/Gtcz9iA
 x114gMZeBNdcnDV4MOGmX01rMZejgxa3h6nX78xh2MIB56iA6ip0H3effjx9X0ca5ChH7io3JnkUz
 YogWpb4ZUXVfhcyEcs+mP/D4wms9zFxoVah169eRY/AhjxtJP+vQbrfzRvQtdmm13+kIhjN5ZTXFH
 H2LuwWEwZ3Ll3+nP7voad1ujJAuXfnvzLMprrZWzmekkGwaJZP0AY1zVdWn4pxeYMcfq1ALJ8hZdi
 8rExCkIqDVANlCr2mZgGYrFdx/tAQY5vdxRQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Ma24s-1r5APB2czc-00W1vx; Wed, 18
 Oct 2023 14:23:25 +0200
Message-ID: <d5dce9f8-ae80-44c7-a45e-9b763de88095@gmx.de>
Date:   Wed, 18 Oct 2023 14:23:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] platform/x86: inspur-wmi: Add platform profile support
To:     Ai Chao <aichao@kylinos.cn>, hdegoede@redhat.com,
        ilpo.jarvinen@linux.intel.com, markgross@kernel.org
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20231018080014.536047-1-aichao@kylinos.cn>
Content-Language: en-US
From:   Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20231018080014.536047-1-aichao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:v4lnESSGBtoWPTzPJ7g7Rtdmr329i7GfxDsudlm28cPdflxsTD6
 oGF9VAIsetVuqI2N+TTV9w/Cad6MBX5W+Iw+imBF6APmgvT6SpcP1NxSKIWRH7RlTuiZH1t
 rbNNskB1iCiSOeTg6Ibzmg2D9ZuCFJRk7KhHHXvGZ3F1M03Hm0sgTNbJViunsUOQLbmeXWm
 CxWZbdsb+sajqT359yqXg==
UI-OutboundReport: notjunk:1;M01:P0:waT0Tg9z+ls=;xXKqs4tF+388e7XrABZgqTdJg7Y
 sZuV63CAu3zN+AOJ2MU2P1QUr0USZB+ZAms50w4L3xrZv2q89DMroUHRoipA7YwsJPl6FozL5
 OyvN4cd3L67kcBeTeKMYgcwqRPhQTA21ExmpLXnA8Y/igtmfzLT1syu8W+Pt/SKHDgVcFrrAg
 tuRAZsLtMrDJ0mV8RxMr245Thrn9GGZ5A1lWRxHAX4NbIZl20HUb1aSnUIXiphmIMBG8WeW6f
 +3jlUILHn7BhzssyneYce7n3AZl1PQhhGbkaw8Zm7rKsfbtYZ7j5lFRrQ+p3Xj1ND3R7fNtoD
 tJU35chZVpYPPxKi37mcljelsiFoKDhdNXgCRMAYf/I36puQjnXdK+NP6g6xoOizz108QTge8
 ZJ8QyVEuF6TQsAnLgA8GlOccuAUH14bfbzyRs0r6ca6RhnuIBuPzoLjvTi4+PuVsr3dAR4BAU
 BU/6ae+gbM0rC0JKRjuRUGv87g5nIxDE3Unw4+uEVNVCFFN4voCOc+2kcjYxVTCkUEul7mqcR
 FU/MTOM+lFEswH1rj8uWc3vSnNef32piRC/Mdl1CA30PsIO7TvddLBN7PbJoX3EaCRnGgWiAy
 X5v8Q039uhbLeMK+pX2xKTwzJOSt+u2pAU4CEvAVo+Ka1w/Lxytwyx/M+jKfEYdGCS32L/uAn
 OywXfTJD/mJa0FO37aQzJg7r9Noc4X8i3yBreWO6JcW5EchuEa2lqSKp0kqv3NZcBROrUWkdf
 4WbxkfEH4+JpsBQafE/UhtOKaEZk2hzVYfK2w6YL9wqpVbgV7JGoUq8srcoFx+Ssfa7gJAR6d
 ibpeJjhaFb4ycDaFulPd4QzAxORzyEq/ogqURKuyZt/htLUFlN+okbveaTnKDH8kzvLxFpeuA
 xRluyjzihC95giq83dxid2e+MuKRQyeufyqTzt553N6Lo+wiC2lGHGXcQXiGfF/F1FUS1MTz1
 mVRLyY1VkROrso4ZNS3TgjoV0nk=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 18.10.23 um 10:00 schrieb Ai Chao:

> Add support for Inspur platforms to used the platform profile feature.
>
> This will allow users to determine and control the platform modes
> between low-power, balanced and performance modes.
>
> change for v3
> - Remove input device
> - Using the platform profile interface
>
> change for v2
> - Remove Event GUID, remove inspur_wmi_notify and inspur_wmi_notify.
> - Add more explanation.

Please move the changelog out of the commit message, see
https://lore.kernel.org/lkml/20231007081230.3555681-1-andriy.shevchenko@li=
nux.intel.com
for an example.

> Signed-off-by: Ai Chao <aichao@kylinos.cn>
> ---
>   drivers/platform/x86/Kconfig      |  10 ++
>   drivers/platform/x86/Makefile     |   3 +
>   drivers/platform/x86/inspur-wmi.c | 215 ++++++++++++++++++++++++++++++
>   3 files changed, 228 insertions(+)
>   create mode 100644 drivers/platform/x86/inspur-wmi.c
>
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 2a1070543391..d7bd27c53751 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -988,6 +988,16 @@ config TOUCHSCREEN_DMI
>   	  the OS-image for the device. This option supplies the missing info.
>   	  Enable this for x86 tablets with Silead or Chipone touchscreens.
>
> +config INSPUR_WMI
> +	tristate "Inspur WMI platform profile driver"
> +	depends on ACPI_WMI

Please select the platform profile subsystem with "select ACPI_PLATFORM_PR=
OFILE".

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
> index 000000000000..d0c5ae2e3fcb
> --- /dev/null
> +++ b/drivers/platform/x86/inspur-wmi.c
> @@ -0,0 +1,215 @@
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
> +	else if (ret_code[0])
> +		return -EBADRQC;

That "else" is pointless due to the early return. Please move the ret_code=
[0] check
out of the else clause, like this:

if (ret < 0)
	return ret;

if (ret_code[0])
	return -EBADRQC;

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
> +	else if (ret_code[0])
> +		return -EBADRQC;

Same as above.

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
> +	platform_profile_register(&priv->handler);
> +	return 0;

I said that the surface platform profile driver was a good example _except=
_ for this
minor issue. Please return the result of platform_profile_register(), see
https://lore.kernel.org/lkml/20231014235449.288702-1-W_Armin@gmx.de for an=
 explanation.

Other than that and the remaining issues above, the driver looks good to m=
e.

Armin Wolf

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
> +MODULE_DESCRIPTION("Inspur WMI hotkeys");
> +MODULE_LICENSE("GPL");
