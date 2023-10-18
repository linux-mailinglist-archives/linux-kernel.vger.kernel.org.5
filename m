Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D547CE02A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235344AbjJROiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235178AbjJROhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:37:47 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3501C1733;
        Wed, 18 Oct 2023 07:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1697639776; x=1698244576; i=w_armin@gmx.de;
 bh=5pqqWh4ZfBgHGygFfC0tANO58OsoMGGYFc57UxQqDGk=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=OtR9BKvxalYGz16ki2a6goUHpWRzNxkl4ZwTtXdpIBCZoy6UxZGh2NG3VMUvPbbvDieaShwOBFz
 XAauwXOVR7MpSQoX5962PvcHpHOGWDinpEaeZnB64PvurOJY4CdHyphqsRybEvcNtkVWaGroT+kRm
 /Fv5b36Cf765ybIPcwuyUzugMQsx72oH6fjteXextwtII7jHJk5XQlmxNVen5SNFshCRxttbdLGTc
 AupscC3i6N8HH/ggYapOux1Sx6NFmgxaiB4X1yuCBGUeo0KhMJcYjBrQBoVbes/aUyCobadVP/Yp2
 RSMM86k745zeO2PcaaagdohX10UytJzrlNTA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MNKlu-1rCJTO395O-00Onl0; Wed, 18
 Oct 2023 16:36:16 +0200
Message-ID: <7dd892f9-c193-40e8-9041-daefd6383674@gmx.de>
Date:   Wed, 18 Oct 2023 16:36:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] platform/x86: inspur-wmi: Add platform profile support
To:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
        Ai Chao <aichao@kylinos.cn>
Cc:     hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
        markgross@kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
References: <20231018080014.536047-1-aichao@kylinos.cn>
 <1d2e147d-8d93-4467-ac7c-199bfd887348@t-8ch.de>
Content-Language: en-US
From:   Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <1d2e147d-8d93-4467-ac7c-199bfd887348@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BBM93MqXxughSEy3y9am+doNb3mmRDe20+gZtHnaFi7iUW1o+5Y
 VK0MJZwNs9DFRK7feLwhcJkFj6vS9MZk5IsvKy0ouWj5rma0j8dtRM1XsgusS7uUoKmpqq5
 ZtiLvKFIoxAfPjJV8/ELqDDIsXeBH7fc4/8vh+DmBxfKwNczyn5yCTD7O53RHYRd/Fucj+4
 ueG8hC73K6BDNcSnYyDJQ==
UI-OutboundReport: notjunk:1;M01:P0:Xuk7LvM6HCU=;Nc0+6E+Cx3HQSTFwRWDCoCLI0jC
 NvkOnSE73DBjVKho4TefHOKXqWGmrk7SMngwGmOn0ugCT+qEMXZTYwrePwcQbzw9qJNV8tbk1
 fb3BS9+LvY5f5zk26vljkzfnm90ptmbo+gDGP51sG2Lg1ot9zDOrjauEGUSoxTSuVFno/GisJ
 ciHycBP2wxjs8DBiVSuRuVzdh2tbq8869qQq6/5KqhR1ohBigXKO66cC5jz6Wm3RvwfuAzE/j
 u3xfoOrUu/aNB08TYNZELRxMb1Jj6Ki9yg8CIKGjfyX0vOXuSP7iqdqiyuIww+y9v3y56IiGr
 BOEGIJ0QMHPuwZ0TzcVZW7Gi5pdW6ZcLFf7m3H3eZCfJfzhZjOR+gdqo9k175YwgzSNZyY5e4
 9yonJgX1pO2lnFqFAjkwPdn3IGc88tNFHcR/2aY4Mg7GDdsWsu0Pas5B8yiwJWMh6gjMazB9L
 6T81JbUlvjUgRwqdaK/TYR/2FJ33aWmHzAYohHShwct2BA1fVFJxkcxldmPdPda6nekqQCVOY
 8kjUKtt/qTVgJjNwpQrSyKtyEGRk9y1Lr50lz9tE09DBSCRwxPry1eJ9Ho2xIjFQBmNGRNg5v
 P/qdA+VF38Dap9Kh/Sr9EMbpVB1yH9L+0BwnSKe8zafS7ZpgJjSsgtOGDY4VMRwff9K/zjVNk
 xBS3X2glJP1iQt4n5HO7eThu0fpYEO9hwXAg1dejY+u6f10D9MDZAqsWa96Fxe30lEzA+e/Oj
 98+BfYH9zVZ8jLhXHwNKRo7/v1NbYK2vQpF2vFWiM0bwViNbkwPUzt/e4FXZk8YSceA0pjsET
 4DURrQybZmhTYth1kPuovTNKd5ypJ+VxP1I1t4Dz0onN/4imGwzcmnYrYugR8F1qcDCkgCfx5
 302BsF8f9kzivMwqMJJLzxgSmoJ5fXjLnNQxK+/04CwypGvSYltiganFvMBdVc9ScbNkoWp2u
 hzHeGzma4lWizoOl6vcjWjxup2g=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 18.10.23 um 15:38 schrieb Thomas Wei=C3=9Fschuh:

> On 2023-10-18 16:00:14+0800, Ai Chao wrote:
>> Add support for Inspur platforms to used the platform profile feature.
>>
>> This will allow users to determine and control the platform modes
>> between low-power, balanced and performance modes.
>>
>> change for v3
>> - Remove input device
>> - Using the platform profile interface
>>
>> change for v2
>> - Remove Event GUID, remove inspur_wmi_notify and inspur_wmi_notify.
>> - Add more explanation.
>>
>> Signed-off-by: Ai Chao <aichao@kylinos.cn>
>> ---
>>   drivers/platform/x86/Kconfig      |  10 ++
>>   drivers/platform/x86/Makefile     |   3 +
>>   drivers/platform/x86/inspur-wmi.c | 215 +++++++++++++++++++++++++++++=
+
>>   3 files changed, 228 insertions(+)
>>   create mode 100644 drivers/platform/x86/inspur-wmi.c
>>
>> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfi=
g
>> index 2a1070543391..d7bd27c53751 100644
>> --- a/drivers/platform/x86/Kconfig
>> +++ b/drivers/platform/x86/Kconfig
>> @@ -988,6 +988,16 @@ config TOUCHSCREEN_DMI
>>   	  the OS-image for the device. This option supplies the missing info=
.
>>   	  Enable this for x86 tablets with Silead or Chipone touchscreens.
>>
>> +config INSPUR_WMI
>> +	tristate "Inspur WMI platform profile driver"
>> +	depends on ACPI_WMI
>> +	help
>> +	This will allow users to determine and control the platform modes
>> +	between low-power, balanced and performance modes.
>> +
>> +	To compile this driver as a module, choose M here: the module
>> +	will be called inspur-wmi.
>> +
>>   source "drivers/platform/x86/x86-android-tablets/Kconfig"
>>
>>   config FW_ATTR_CLASS
>> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makef=
ile
>> index b457de5abf7d..9285c252757e 100644
>> --- a/drivers/platform/x86/Makefile
>> +++ b/drivers/platform/x86/Makefile
>> @@ -98,6 +98,9 @@ obj-$(CONFIG_TOSHIBA_WMI)	+=3D toshiba-wmi.o
>>   # before toshiba_acpi initializes
>>   obj-$(CONFIG_ACPI_TOSHIBA)	+=3D toshiba_acpi.o
>>
>> +# Inspur
>> +obj-$(CONFIG_INSPUR_WMI)	+=3D inspur-wmi.o
>> +
>>   # Laptop drivers
>>   obj-$(CONFIG_ACPI_CMPC)		+=3D classmate-laptop.o
>>   obj-$(CONFIG_COMPAL_LAPTOP)	+=3D compal-laptop.o
>> diff --git a/drivers/platform/x86/inspur-wmi.c b/drivers/platform/x86/i=
nspur-wmi.c
>> new file mode 100644
>> index 000000000000..d0c5ae2e3fcb
>> --- /dev/null
>> +++ b/drivers/platform/x86/inspur-wmi.c
>> @@ -0,0 +1,215 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + *  Inspur WMI power mode
>> + *
>> + *  Copyright (C) 2018	      Ai Chao <aichao@kylinos.cn>
>> + */
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/device.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_profile.h>
>> +#include <linux/wmi.h>
>> +
>> +#define WMI_INSPUR_POWERMODE_BIOS_GUID "596C31E3-332D-43C9-AEE9-585493=
284F5D"
>> +
>> +enum inspur_wmi_method_ids {
>> +	INSPUR_WMI_GET_POWERMODE =3D 0x02,
>> +	INSPUR_WMI_SET_POWERMODE =3D 0x03,
>> +};
>> +
>> +/**
>> + * Power Mode:
>> + *           0x0: Balance Mode
>> + *           0x1: Performance Mode
>> + *           0x2: Power Saver Mode
>> + */
>> +enum inspur_tmp_profile {
>> +	INSPUR_TMP_PROFILE_BALANCE	=3D 0,
>> +	INSPUR_TMP_PROFILE_PERFORMANCE	=3D 1,
>> +	INSPUR_TMP_PROFILE_POWERSAVE	=3D 2,
>> +};
>> +
>> +struct inspur_wmi_priv {
>> +	struct wmi_device *wdev;
>> +	struct platform_profile_handler handler;
>> +};
>> +
>> +static int inspur_wmi_perform_query(struct wmi_device *wdev,
>> +				    enum inspur_wmi_method_ids query_id,
>> +				    void *buffer, size_t insize,
>> +				    size_t outsize)
>> +{
>> +	struct acpi_buffer output =3D { ACPI_ALLOCATE_BUFFER, NULL };
>> +	struct acpi_buffer input =3D { insize, buffer};
>> +	union acpi_object *obj;
>> +	acpi_status status;
>> +	int ret =3D 0;
>> +
>> +	status =3D wmidev_evaluate_method(wdev, 0, query_id, &input, &output)=
;
>> +	if (ACPI_FAILURE(status)) {
>> +		dev_err(&wdev->dev, "EC Powermode control failed: %s\n",
>> +			acpi_format_exception(status));
>> +		return -EIO;
>> +	}
>> +
>> +	obj =3D output.pointer;
>> +	if (!obj)
>> +		return -EINVAL;
>> +
>> +	if (obj->type !=3D ACPI_TYPE_BUFFER ||
>> +	    obj->buffer.length !=3D outsize) {
>> +		ret =3D -EINVAL;
>> +		goto out_free;
>> +	}
>> +
>> +	memcpy(buffer, obj->buffer.pointer, obj->buffer.length);
>> +
>> +out_free:
>> +	kfree(obj);
>> +	return ret;
>> +}
>> +
>> +/**
>> + * Set Power Mode to EC RAM. If Power Mode value greater than 0x3,
>> + * return error
>> + * Method ID: 0x3
>> + * Arg: 4 Bytes
>> + * Byte [0]: Power Mode:
>> + *         0x0: Balance Mode
>> + *         0x1: Performance Mode
>> + *         0x2: Power Saver Mode
>> + * Return Value: 4 Bytes
>> + * Byte [0]: Return Code
>> + *         0x0: No Error
>> + *         0x1: Error
>> + */
>> +static int inspur_platform_profile_set(struct platform_profile_handler=
 *pprof,
>> +				       enum platform_profile_option profile)
>> +{
>> +	struct inspur_wmi_priv *priv =3D container_of(pprof, struct inspur_wm=
i_priv,
>> +						    handler);
>> +	u8 ret_code[4] =3D {0, 0, 0, 0};
>> +	int ret;
>> +
>> +	switch (profile) {
>> +	case PLATFORM_PROFILE_BALANCED:
>> +		ret_code[0] =3D INSPUR_TMP_PROFILE_BALANCE;
>> +		break;
>> +	case PLATFORM_PROFILE_PERFORMANCE:
>> +		ret_code[0] =3D INSPUR_TMP_PROFILE_PERFORMANCE;
>> +		break;
>> +	case PLATFORM_PROFILE_LOW_POWER:
>> +		ret_code[0] =3D INSPUR_TMP_PROFILE_POWERSAVE;
>> +		break;
>> +	default:
>> +		return -EOPNOTSUPP;
>> +	}
>> +
>> +	ret =3D inspur_wmi_perform_query(priv->wdev, INSPUR_WMI_SET_POWERMODE=
,
>> +				       ret_code, sizeof(ret_code),
>> +				       sizeof(ret_code));
>> +
>> +	if (ret < 0)
>> +		return ret;
>> +	else if (ret_code[0])
>> +		return -EBADRQC;
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * Get Power Mode from EC RAM, If Power Mode value greater than 0x3,
>> + * return error
>> + * Method ID: 0x2
>> + * Return Value: 4 Bytes
>> + * Byte [0]: Return Code
>> + *         0x0: No Error
>> + *         0x1: Error
>> + * Byte [1]: Power Mode
>> + *         0x0: Balance Mode
>> + *         0x1: Performance Mode
>> + *         0x2: Power Saver Mode
>> + */
>> +static int inspur_platform_profile_get(struct platform_profile_handler=
 *pprof,
>> +				       enum platform_profile_option *profile)
>> +{
>> +	struct inspur_wmi_priv *priv =3D container_of(pprof, struct inspur_wm=
i_priv,
>> +						    handler);
>> +	u8 ret_code[4] =3D {0, 0, 0, 0};
>> +	int ret;
>> +
>> +	ret =3D inspur_wmi_perform_query(priv->wdev, INSPUR_WMI_GET_POWERMODE=
,
>> +				       &ret_code, sizeof(ret_code),
>> +				       sizeof(ret_code));
>> +	if (ret < 0)
>> +		return ret;
>> +	else if (ret_code[0])
>> +		return -EBADRQC;
>> +
>> +	switch (ret_code[1]) {
>> +	case INSPUR_TMP_PROFILE_BALANCE:
>> +		*profile =3D PLATFORM_PROFILE_BALANCED;
>> +		break;
>> +	case INSPUR_TMP_PROFILE_PERFORMANCE:
>> +		*profile =3D PLATFORM_PROFILE_PERFORMANCE;
>> +		break;
>> +	case INSPUR_TMP_PROFILE_POWERSAVE:
>> +		*profile =3D PLATFORM_PROFILE_LOW_POWER;
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int inspur_wmi_probe(struct wmi_device *wdev, const void *conte=
xt)
>> +{
>> +	struct inspur_wmi_priv *priv;
>> +
>> +	priv =3D devm_kzalloc(&wdev->dev, sizeof(*priv), GFP_KERNEL);
>> +	if (!priv)
>> +		return -ENOMEM;
>> +
>> +	priv->wdev =3D wdev;
>> +	dev_set_drvdata(&wdev->dev, priv);
>> +
>> +	priv->handler.profile_get =3D inspur_platform_profile_get;
>> +	priv->handler.profile_set =3D inspur_platform_profile_set;
>> +
>> +	set_bit(PLATFORM_PROFILE_LOW_POWER, priv->handler.choices);
>> +	set_bit(PLATFORM_PROFILE_BALANCED, priv->handler.choices);
>> +	set_bit(PLATFORM_PROFILE_PERFORMANCE, priv->handler.choices);
>> +
>> +	platform_profile_register(&priv->handler);
>> +	return 0;
>> +}
>> +
>> +static void inspur_wmi_remove(struct wmi_device *wdev)
>> +{
>> +	platform_profile_remove();
>> +}
>> +
>> +static const struct wmi_device_id inspur_wmi_id_table[] =3D {
>> +	{ .guid_string =3D WMI_INSPUR_POWERMODE_BIOS_GUID },
>> +	{  }
>> +};
>> +
>> +MODULE_DEVICE_TABLE(wmi, inspur_wmi_id_table);
>> +
>> +static struct wmi_driver inspur_wmi_driver =3D {
>> +	.driver =3D {
>> +		.name =3D "inspur-wmi",
>> +		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> Seems unnecessary.
> The docs say this should be used for "slow" devices.
> But the probe function here doesn't really do anything.

The reason why i prefer drivers to enable asynchronous probing is that
without enabling it by default, asynchronous probing wont have any chance
of becoming the default someday.

Additionally, the WMI core might call some ACPI methods when probing an
WMI device, and those can be quite slow. By enabling asynchronous probing,
we avoid any slowdowns in such a case.

Armin Wolf

>> +	},
>> +	.id_table =3D inspur_wmi_id_table,
>> +	.probe =3D inspur_wmi_probe,
>> +	.remove =3D inspur_wmi_remove,
>> +};
>> +
>> +module_wmi_driver(inspur_wmi_driver);
>> +
>> +MODULE_AUTHOR("Ai Chao <aichao@kylinos.cn>");
>> +MODULE_DESCRIPTION("Inspur WMI hotkeys");
> There is no more hotkey functionality left.
> Kconfig says "Inspur WMI platform profile driver",
> should also be used here.
>
> If you are also going to submit the hotkey driver it may make sense to
> call this one inspur-wmi-platform-profile, or something similar unique.
>
>> +MODULE_LICENSE("GPL");
>> --
>> 2.25.1
>>
