Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EACF78F211
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 19:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345297AbjHaRla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 13:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241715AbjHaRl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 13:41:28 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880A9E70;
        Thu, 31 Aug 2023 10:41:19 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1c50438636fso639583fac.1;
        Thu, 31 Aug 2023 10:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693503678; x=1694108478; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y1Hm4A+hu82yg0FaA+q1KEiS8KnUvawYYfjc7J2pynA=;
        b=kjyvTQXaco4VqyyJCS0GcF1yhRUttR+kghQplYSBMcOhU/z9+8yldDWbA7V+6VV28A
         YQxTeaWhY2+j5gQ1gJQVhm/NFbTBIXxGTNj7cYA1H6nPqpaYIXFRA1/tHeoYdG1hszo3
         /31CIYfs+G/jXU687DJyL3Qv3+KovFstr+FStAjF6vIAxXrAZj6KVc/AhAOv+kVMRNPx
         hRS4q30GCSs9dKMtBq9F3mOpwxOn5vl5O81zKSuLfsMoQ4ZPCA0Ab39QrMapeR4g/e1n
         xiTWdyPhOFw5rI/5QB5ekMj1gQRxVGPjmWrV+5sjEN0obrbVI5Q3lVf/rNlrK4XzgczB
         dTmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693503678; x=1694108478;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y1Hm4A+hu82yg0FaA+q1KEiS8KnUvawYYfjc7J2pynA=;
        b=DTrfmT3WnLHf7fK71B0aV42DZOMauHcuaUY5ufo5sspgUztpZeoz1cWdVy/dYXe04m
         vWK1ffYKxbQGh8WMyAwAaRQBBYPjNMzeSfL+YtuHWSEhH42xzm7gdhDFIeZF0E4Jg6hQ
         kAQ7GKQyJExR4xyDMvtJgZUASHkZBP4LLIDcjwiNxvlOtfwpnl1P56jsF6f1tlPzxVUQ
         wCjX/nBYsqilmhGpbJTiWePnD6NOIf4MU/D+umnBvSBFstLtI+vI2G4vi0TOlCha4WhF
         gUXRm81mgQTk/1EUuk2fUzdF1LGAZhur+RioU8E/h/iTHtJfFIwuMsFYObhBvW8ft+3K
         HwoA==
X-Gm-Message-State: AOJu0YxqlBr4VsGVETSo3RhEPFWxOEvv1Zrk3hJT9eitjSx1w2Cm752e
        fRrXpx6y9bI12mA888RwAZA=
X-Google-Smtp-Source: AGHT+IFxB9vD51gTq45OWU/xOliEhoWMLLA6GlyrrqOQT/9zoI/SzB2T7FMvqXZxkgLJp3/jq01TpA==
X-Received: by 2002:a05:6870:a50a:b0:1c0:fc08:8f91 with SMTP id o10-20020a056870a50a00b001c0fc088f91mr139233oal.40.1693503678548;
        Thu, 31 Aug 2023 10:41:18 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id gg18-20020a056638691200b0042b57bbbaf2sm526466jab.26.2023.08.31.10.41.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Aug 2023 10:41:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ca72a21b-af05-c754-99a0-34d913edf304@roeck-us.net>
Date:   Thu, 31 Aug 2023 10:41:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
References: <20230831-powerz-v2-1-5c62c53debd4@weissschuh.net>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2] hwmon: add POWER-Z driver
In-Reply-To: <20230831-powerz-v2-1-5c62c53debd4@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/23 02:58, Thomas Weißschuh wrote:
> POWER-Z is a series of devices to monitor power characteristics of USB-C
> connections and display those on a on-device display.
> Some of the devices, notably KM002C and KM003C, contain an additional
> port which exposes the measurements via USB.
> 
> This is a driver for this monitor port.
> 
> It was developed and tested with the KM003C.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
> Changes in v2:
> - fix syntax error in Kconfig
> - avoid double free of urb in case of failure
> - Link to v1: https://lore.kernel.org/r/20230831-powerz-v1-1-03979e519f52@weissschuh.net
> ---
>   MAINTAINERS            |   6 ++
>   drivers/hwmon/Kconfig  |  10 ++
>   drivers/hwmon/Makefile |   1 +
>   drivers/hwmon/powerz.c | 257 +++++++++++++++++++++++++++++++++++++++++++++++++

Documentation missing.

>   4 files changed, 274 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4e3419c04f27..12bcf14597c4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4795,6 +4795,12 @@ X:	drivers/char/ipmi/
>   X:	drivers/char/random.c
>   X:	drivers/char/tpm/
>   
> +CHARGERLAB POWER-Z HARDWARE MONITOR DRIVER
> +M:	Thomas Weißschuh <linux@weissschuh.net>
> +L:	linux-hwmon@vger.kernel.org
> +S:	Maintained
> +F:	drivers/hwmon/powerz.c
> +
>   CHECKPATCH
>   M:	Andy Whitcroft <apw@canonical.com>
>   M:	Joe Perches <joe@perches.com>
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index ec38c8892158..12af9f9cfd9f 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -839,6 +839,16 @@ config SENSORS_JC42
>   	  This driver can also be built as a module. If so, the module
>   	  will be called jc42.
>   
> +config SENSORS_POWERZ
> +	tristate "ChargerLAB POWER-Z USB-C tester"
> +	depends on USB
> +	help
> +	  If you say yes here you get support for ChargerLAB POWER-Z series of
> +	  USB-C charging testers.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called powerz.
> +
>   config SENSORS_POWR1220
>   	tristate "Lattice POWR1220 Power Monitoring"
>   	depends on I2C
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 4ac9452b5430..019189500e5d 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -176,6 +176,7 @@ obj-$(CONFIG_SENSORS_OXP) += oxp-sensors.o
>   obj-$(CONFIG_SENSORS_PC87360)	+= pc87360.o
>   obj-$(CONFIG_SENSORS_PC87427)	+= pc87427.o
>   obj-$(CONFIG_SENSORS_PCF8591)	+= pcf8591.o
> +obj-$(CONFIG_SENSORS_POWERZ)	+= powerz.o
>   obj-$(CONFIG_SENSORS_POWR1220)  += powr1220.o
>   obj-$(CONFIG_SENSORS_PWM_FAN)	+= pwm-fan.o
>   obj-$(CONFIG_SENSORS_RASPBERRYPI_HWMON)	+= raspberrypi-hwmon.o
> diff --git a/drivers/hwmon/powerz.c b/drivers/hwmon/powerz.c
> new file mode 100644
> index 000000000000..cbdbc1ce0e81
> --- /dev/null
> +++ b/drivers/hwmon/powerz.c
> @@ -0,0 +1,257 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + *  Copyright (C) 2023 Thomas Weißschuh <linux@weissschuh.net>
> + */
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/completion.h>
> +#include <linux/hwmon.h>
> +#include <linux/module.h>
> +#include <linux/usb.h>

Various include files missing. I did not check all of them, but for example
umode_t and various other types are defined in include/linux/types.h,
and struct device is declared in include/linux/device.h, both of which
should therefore be included.

The idea is not to include as little as possible, but to include everything
that is referenced in the driver. There should be no ddependency on indirect
includes.

> +
> +#define DRIVER_NAME	"powerz"
> +#define POWERZ_EP_CMD_OUT	0x01
> +#define POWERZ_EP_DATA_IN	0x81
> +
> +struct powerz_sensor_data {
> +	u8 _unknown_1[8];
> +	__le32 Vbus;

CHECK: Avoid CamelCase: <Vbus>
#160: FILE: drivers/hwmon/powerz.c:18:
+	__le32 Vbus;

Please run your patches through checkpatch --strict.

> +	__le32 Ibus;
> +	__le32 Vbus_avg;
> +	__le32 Ibus_avg;
> +	u8 _unknown_2[8];
> +	u8 temp[2];
> +	__le16 cc1;
> +	__le16 cc2;
> +	__le16 dp;
> +	__le16 dm;
> +	u8 _unknown_3[6];
> +} __packed;
> +
> +struct powerz_priv {
> +	struct device *hwmon_dev;
> +	struct usb_interface *intf;
> +};
> +
> +static const struct hwmon_channel_info * const powerz_info[] = {
> +	HWMON_CHANNEL_INFO(in,
> +			   HWMON_I_INPUT | HWMON_I_LABEL | HWMON_I_AVERAGE,
> +			   HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL),
> +	HWMON_CHANNEL_INFO(curr, HWMON_C_INPUT | HWMON_C_LABEL | HWMON_C_AVERAGE),
> +	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_LABEL),
> +	NULL
> +};
> +
> +static umode_t powerz_is_visible(const void *data, enum hwmon_sensor_types type,
> +				 u32 attr, int channel)
> +{
> +	return 0444;
> +}
> +
> +static int powerz_read_string(struct device *dev, enum hwmon_sensor_types type,
> +			      u32 attr, int channel, const char **str)
> +{
> +	if (type == hwmon_curr && attr == hwmon_curr_label)
> +		*str = "bus";
> +	else if (type == hwmon_in && attr == hwmon_in_label && channel == 0)
> +		*str = "bus";
> +	else if (type == hwmon_in && attr == hwmon_in_label && channel == 1)
> +		*str = "cc1";
> +	else if (type == hwmon_in && attr == hwmon_in_label && channel == 2)
> +		*str = "cc2";
> +	else if (type == hwmon_in && attr == hwmon_in_label && channel == 3)
> +		*str = "dp";
> +	else if (type == hwmon_in && attr == hwmon_in_label && channel == 4)
> +		*str = "dm";
> +	else if (type == hwmon_temp && attr == hwmon_temp_label)
> +		*str = "temp";
> +	else
> +		return -EINVAL;
> +
-EOPNOTSUPP, and please use nested if statement to avoid checking the same
value several times.

> +	return 0;
> +}
> +
> +struct powerz_usb_ctx {
> +	char transfer_buffer[64];
> +	struct completion completion;
> +	int status;
> +};
> +
> +static void powerz_usb_data_complete(struct urb *urb)
> +{
> +	struct powerz_usb_ctx *ctx = urb->context;
> +
> +	ctx->status = 0;
> +	complete(&ctx->completion);
> +}
> +
> +static void powerz_usb_cmd_complete(struct urb *urb)
> +{
> +	struct powerz_usb_ctx *ctx = urb->context;
> +	int ret;
> +
> +	usb_fill_bulk_urb(urb, urb->dev, usb_rcvbulkpipe(urb->dev, POWERZ_EP_DATA_IN),
> +			  ctx->transfer_buffer, sizeof(ctx->transfer_buffer),
> +			  powerz_usb_data_complete, ctx);
> +
> +	ret = usb_submit_urb(urb, GFP_ATOMIC);
> +	if (ret) {
> +		ctx->status = ret;
> +		complete(&ctx->completion);
> +	}
> +}
> +
> +static struct powerz_sensor_data *powerz_read_data(struct usb_device *udev,
> +						   struct powerz_usb_ctx *ctx)
> +{
> +	struct urb *urb;
> +	int r;
> +
> +	ctx->status = -ETIMEDOUT;
> +	init_completion(&ctx->completion);
> +
> +	urb = usb_alloc_urb(0, GFP_KERNEL);
> +	if (!urb)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ctx->transfer_buffer[0] = 0x0c;
> +	ctx->transfer_buffer[1] = 0x00;
> +	ctx->transfer_buffer[2] = 0x02;
> +	ctx->transfer_buffer[3] = 0x00;
> +
> +	usb_fill_bulk_urb(urb, udev, usb_sndbulkpipe(udev, POWERZ_EP_CMD_OUT),
> +			  ctx->transfer_buffer, 4, powerz_usb_cmd_complete, ctx);
> +	r = usb_submit_urb(urb, GFP_KERNEL);
> +	if (r) {
> +		usb_free_urb(urb);
> +		return ERR_PTR(r);
> +	}
> +
> +	if (!wait_for_completion_interruptible_timeout(&ctx->completion, msecs_to_jiffies(5))) {
> +		usb_kill_urb(urb);
> +		usb_free_urb(urb);
> +		return ERR_PTR(-EIO);
> +	}
> +
> +	if (ctx->status) {
> +		usb_free_urb(urb);
> +		return ERR_PTR(ctx->status);
> +	}
> +
> +	if (urb->actual_length < (sizeof(struct powerz_sensor_data))) {
> +		usb_free_urb(urb);
> +		return ERR_PTR(-EIO);
> +	}
> +
> +	usb_free_urb(urb);
> +	return (struct powerz_sensor_data *)(ctx->transfer_buffer);

The return pointer is always either an error or ctx->transfer_buffer,
which is known by the caller. It would be much easier to just return
an integer error code and let the caller access ctx->transfer_buffer.

With that, the code can be simplified to have something like

	if (error condition) {
		ret = error contition;
		goto error;
	...

error:
	usb_free_urb(urb);
	return ret;

which more follows kernel coding style and avoids the repeated
call to usb_free_urb().

> +}
> +
> +static int powerz_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
> +		       int channel, long *val)
> +{
> +	struct usb_interface *intf = to_usb_interface(dev->parent);
> +	struct usb_device *udev = interface_to_usbdev(intf);
> +	struct powerz_sensor_data *data;
> +	struct powerz_usb_ctx *ctx;
> +
> +	ctx = kmalloc(sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx)
> +		return -ENOMEM;
> +

I think it would be much better to allocate ctx once as part of
struct powerz_priv and keep it around. Sure, that means that this
function requires a lock, but I don't see that as problem (and who
knows how the device reacts to multiple pending usb transactions).

You'd need to allocate transfer_buffer separately because it needs to be
dma aligned, but that should not be a problem either.

> +	data = powerz_read_data(udev, ctx);
> +	if (IS_ERR(data)) {
> +		kfree(ctx);
> +		return PTR_ERR(data);
> +	}

With the above, this could be
	ret = powerz_read_data(udev, ctx);
	if (ret)
		return ret;
	data = ctx->transfer_buffer;

(with ctx replaced to use struct powerz_priv).
		
> +
> +	if (type == hwmon_curr && attr == hwmon_curr_input)
> +		*val =  ((s32)le32_to_cpu(data->Ibus)) / 1000;
> +	else if (type == hwmon_curr && attr == hwmon_curr_average)
> +		*val =  ((s32)le32_to_cpu(data->Ibus_avg)) / 1000;
> +	else if (type == hwmon_in && attr == hwmon_in_input && channel == 0)
> +		*val =  le32_to_cpu(data->Vbus) / 1000;
> +	else if (type == hwmon_in && attr == hwmon_in_average && channel == 0)
> +		*val =  le32_to_cpu(data->Vbus_avg) / 1000;
> +	else if (type == hwmon_in && attr == hwmon_in_input && channel == 1)
> +		*val =  le16_to_cpu(data->cc1) / 10;
> +	else if (type == hwmon_in && attr == hwmon_in_input && channel == 2)
> +		*val =  le16_to_cpu(data->cc2) / 10;
> +	else if (type == hwmon_in && attr == hwmon_in_input && channel == 3)
> +		*val =  le16_to_cpu(data->dp) / 10;
> +	else if (type == hwmon_in && attr == hwmon_in_input && channel == 4)
> +		*val =  le16_to_cpu(data->dm) / 10;
> +	else if (type == hwmon_temp && attr == hwmon_temp_input)
> +		*val = ((long)data->temp[1]) * 2000 + ((long)data->temp[0]) * 1000 / 128;
> +	else
> +		return -EINVAL;

-EOPNOTSUPP.

Also, please use nested if statements to avoid checking the same
value several times.

> +
> +	kfree(ctx);
> +
> +	return 0;
> +}
> +
> +static const struct hwmon_ops powerz_hwmon_ops = {
> +	.is_visible  = powerz_is_visible,
> +	.read        = powerz_read,
> +	.read_string = powerz_read_string,
> +};
> +
> +static const struct hwmon_chip_info powerz_chip_info = {
> +	.ops  = &powerz_hwmon_ops,
> +	.info = powerz_info,
> +};
> +
> +static int powerz_probe(struct usb_interface *intf, const struct usb_device_id *id)
> +{
> +	struct usb_device *udev = interface_to_usbdev(intf);
> +	struct powerz_priv *priv;
> +	struct device *parent;
> +	const char *name;
> +	int ret;
> +
> +	parent = &intf->dev;
> +
> +	priv = devm_kzalloc(parent, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	name = devm_hwmon_sanitize_name(parent, udev->product ?: DRIVER_NAME);

Why not just use DRIVER_NAME ? This would be much more consistent.

> +	priv->hwmon_dev = hwmon_device_register_with_info(parent, name,
> +							  priv,
> +							  &powerz_chip_info,
> +							  NULL);
> +	ret = PTR_ERR_OR_ZERO(priv->hwmon_dev);
> +	priv->intf = intf;

Maybe I am missing something, but I don't see this used anywhere.

> +	usb_set_intfdata(intf, priv);
> +
> +	return ret;
> +}
> +
> +static void powerz_disconnect(struct usb_interface *intf)
> +{
> +	struct powerz_priv *priv = usb_get_intfdata(intf);
> +
> +	hwmon_device_unregister(priv->hwmon_dev);

Please use devm_hwmon_device_register_with_info() to register the device.

> +}
> +
> +static const struct usb_device_id powerz_id_table[] = {
> +	{ USB_DEVICE_INTERFACE_NUMBER(0x5FC9, 0x0063, 0x00) }, /* ChargerLAB POWER-Z KM003C */
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(usb, powerz_id_table);
> +
> +static struct usb_driver powerz_driver = {
> +	.name       = DRIVER_NAME,
> +	.id_table   = powerz_id_table,
> +	.probe      = powerz_probe,
> +	.disconnect = powerz_disconnect,
> +};
> +module_usb_driver(powerz_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Thomas Weißschuh <linux@weissschuh.net>");
> +MODULE_DESCRIPTION("ChargerLAB POWER-Z USB-C tester");
> 
> ---
> base-commit: b97d64c722598ffed42ece814a2cb791336c6679
> change-id: 20230831-powerz-2ccb978a8e57
> 
> Best regards,

