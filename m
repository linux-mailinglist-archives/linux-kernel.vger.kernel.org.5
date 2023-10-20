Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E84A7D06DE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 05:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346899AbjJTD35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 23:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235602AbjJTD3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 23:29:54 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03914D45;
        Thu, 19 Oct 2023 20:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1697772566; x=1698377366; i=w_armin@gmx.de;
        bh=ceZWL1bYh7BxO6YBbGmcHLojtXRTYGCkhNzmXOuGjw4=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
         In-Reply-To;
        b=YU8zkfzuMRGX+/b9V2SPUONyoA9vx/UEnQ+9g6jPIbaaIrI8NltP1OW8blTm/ijr
         eUmkBnhCRcrtAiXUpbRvqyyUg/S6QXX5zQbjEsUsOwBt71sPnrMJY+45uJ5Q1QNia
         dAwWyrWLHbz4DNM4Pby5wkw5+JwEBQ6A1lvgCXHWu6anRCUXqH1/3UyKTt+l5z65f
         iSRVjY07OdYAdpqz5G0UcON07r1TSMc848PKm9oJT6tUbGEzrCIlar5yqZ20/fy4h
         enp8muo5qCPdmPECCR2Uu5YZryPbUj0GJb6CasZno2Www7XE6/O7tCoR/XkuCnaHc
         K+gQF3EMKBD9fc91TA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTABT-1r5xV30yIZ-00UWnu; Fri, 20
 Oct 2023 05:29:26 +0200
Message-ID: <6a7e98bc-6b88-4921-9035-64753c74b048@gmx.de>
Date:   Fri, 20 Oct 2023 05:29:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] platform/x86: inspur-platform-profile: Add platform
 profile support
To:     Ai Chao <aichao@kylinos.cn>, hdegoede@redhat.com,
        ilpo.jarvinen@linux.intel.com, markgross@kernel.org
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20231020024007.1677962-1-aichao@kylinos.cn>
Content-Language: en-US
From:   Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20231020024007.1677962-1-aichao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tmxnr/9DA8ryTSANZ4IQXGbDadKdRP4t4dBE8bvPAE72U9NNWWN
 q1dEGobY8OFNY/PTYS+lAhMxdCYlV8meCOeWhkUDSgMidl7MNOG2LkF0n6vqra2yfts1At6
 GFGdn3rJMmkuCyZXCDhwZEEfKIN0y2sQ7JHqfWijr75JSenX/lCOoKhyzmCZd2JGtqwt63F
 nOPKB4pK/qiRuBefN8nBg==
UI-OutboundReport: notjunk:1;M01:P0:MePXsRco/Rw=;ieZeKnniVY5CbSzgBw6aAil5NU3
 wyxXycph20cblIxtA621DRlcaH3ux+BUXDpTg6FEu+GKUnLWg15PmTzK3BJk19hkQWDyomHHf
 zrA7znO6BBPjU7sW09FFzSRgpbMhmZHVmq2ep1PpEQFXQUuHecvZaNobP4E1niGR0YMcDaRbG
 Wb7ABFyiZiQvvyLZZ7wmNZ7KK6tp/zI/cfeiFAnm1S6dWbpipPLhJhaKHyF3tzLVHV/BNpXX9
 d30LHS4ekQVOMqhEUHFMJMP7pt/mwWJ9hkxVOjte3ZyY6/fNz6zr8zgqI1S8qLAmO9Ra3pV6T
 bAYTCDCjeJhpor3FfU+eyU/NicV+N/pUI3Zvgs9tlQUI9lKh5Yd9etAk5c3KAiS86jG7OEKX4
 4zwC4OSqanTN/5eOVPQtql7G6Vlqfmdei+E3hKxpinsvatJ4/OJuHM64C496FZIf3DvWivMPA
 DbBh9yh4iAfQwwCVdkGTNxkUggSuLJZVJwsCgM79hDNPeEXe1J5hAno3ZHwMN4krml0JwcP9I
 +TtbzGFF0zf8A3cLPUNR0MvOCtwXGackP655A9p/KSOR6eIkCp96V0jdJnzWXQPCyiIFB0vK6
 oVCqydnZHyET/1pya5iu6VY7+kcvo8U/QYjY90HCycmtJYkZBvL9E2Pgix8aecLPtq/6iKl57
 vnoTWlfkOMByWWAReOkzPfqUq+Yo2iV/Xrz/wU1vc2eEVdYMSVOlXU+pa3DBavDSWSvK49MuW
 iCygmulYqIjwKr9hPVVbzay8js/wkmzlhebQJnjvIQ8lPhJHPJxgVP6BEbrjiM/rKMElQS1hc
 ZUpCIEwRvTc6HIaqyTcldSAusmsSzoGeSG1LHSR3PBmgwrcrKxbTUB8WjNm+Emm2gYuagN8Ox
 jc5JG/ON2cFSkT9oIBbcpAfhztdXP5Hpv057hoG/LXU5hIrcqgrYQ+efKfcBUsf6vfNkdj8cp
 V9zW5kCIZWzap8inX29O0TWmM80=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 20.10.23 um 04:40 schrieb Ai Chao:

> Add support for Inspur platforms to used the platform profile feature.
>
> This will allow users to determine and control the platform modes
> between low-power, balanced and performance modes.
>
> Signed-off-by: Ai Chao <aichao@kylinos.cn>

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> ---
>
> v5: Rename inspur-wmi to inspur_platform_profile
> v4: Add select ACPI_PLATFORM_PROFILE
> v3: Remove input device, using the platform profile interface
> v2: Remove Event GUID, remove inspur_wmi_notify and inspur_wmi_notify.
>
>   drivers/platform/x86/Kconfig                  |  11 +
>   drivers/platform/x86/Makefile                 |   3 +
>   .../platform/x86/inspur_platform_profile.c    | 216 ++++++++++++++++++
>   3 files changed, 230 insertions(+)
>   create mode 100644 drivers/platform/x86/inspur_platform_profile.c
>
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 2a1070543391..7e69fdaccdd5 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -988,6 +988,17 @@ config TOUCHSCREEN_DMI
>   	  the OS-image for the device. This option supplies the missing info.
>   	  Enable this for x86 tablets with Silead or Chipone touchscreens.
>
> +config INSPUR_PLATFORM_PROFILE
> +	tristate "Inspur WMI platform profile driver"
> +	depends on ACPI_WMI
> +	select ACPI_PLATFORM_PROFILE
> +	help
> +	This will allow users to determine and control the platform modes
> +	between low-power, balanced and performance modes.
> +
> +	To compile this driver as a module, choose M here: the module
> +	will be called inspur-platform-profile.
> +
>   source "drivers/platform/x86/x86-android-tablets/Kconfig"
>
>   config FW_ATTR_CLASS
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefi=
le
> index b457de5abf7d..c7a18e95ad8c 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -98,6 +98,9 @@ obj-$(CONFIG_TOSHIBA_WMI)	+=3D toshiba-wmi.o
>   # before toshiba_acpi initializes
>   obj-$(CONFIG_ACPI_TOSHIBA)	+=3D toshiba_acpi.o
>
> +# Inspur
> +obj-$(CONFIG_INSPUR_PLATFORM_PROFILE)	+=3D inspur_platform_profile.o
> +
>   # Laptop drivers
>   obj-$(CONFIG_ACPI_CMPC)		+=3D classmate-laptop.o
>   obj-$(CONFIG_COMPAL_LAPTOP)	+=3D compal-laptop.o
> diff --git a/drivers/platform/x86/inspur_platform_profile.c b/drivers/pl=
atform/x86/inspur_platform_profile.c
> new file mode 100644
> index 000000000000..6e376cb6d47e
> --- /dev/null
> +++ b/drivers/platform/x86/inspur_platform_profile.c
> @@ -0,0 +1,216 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  Inspur WMI Platform Profile
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
> +		.name =3D "inspur-wmi-platform-profile",
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
> +MODULE_DESCRIPTION("Platform Profile Support for Inspur");
> +MODULE_LICENSE("GPL");
