Return-Path: <linux-kernel+bounces-77558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5ACA860778
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 01:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D42C2828CF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 00:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FCE443D;
	Fri, 23 Feb 2024 00:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ma6x9jeo"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129E063A;
	Fri, 23 Feb 2024 00:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708647208; cv=none; b=DM075wQKjM/qLAEW2cU4vCHP56DmgDVCatLwm3B0pnZEXPsOAzG5DbccKeOcCQvCebLNlwbFmqDjMN0vN5eHg3OLMSRA+APseK2LMJSQyrsvLlBmnj0SFPRlYWzAgd8eywIzhQbk/JDfs0vJL9VexRUDbOljnScFz1N/jwp/21E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708647208; c=relaxed/simple;
	bh=Ex83ZLTQLF2ZNUcOCHWSwKKS16AtQl2Y00GyXD3BGDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ibtO70bBR8Dg9xaEqj/wtiKFKFrWeRYYvCq/2uh67a4kROvUoznVxhdEwoQtiHO4TM3oVMNh7mc+YqgZrAhjZKjaO+TB3iuvyZWh9RCUmuTO+xpfKUqEXF5zPpELVoqsXqyh5KDxs1RGj9PioOmdv+1pd0/L6d20CH0N/rj77G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ma6x9jeo; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1dc09556599so3180565ad.1;
        Thu, 22 Feb 2024 16:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708647202; x=1709252002; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=L5Em3s3/q2CUyMHI5GLnC+kLTqSg16IQlFmDVQC88lk=;
        b=ma6x9jeofXkQnL0CgeRO3Q5rhprIuVzagg+bhTiJ/gGAiJ1GWVZz+tSGzKuOznDA8X
         hfmnhINgd1yijsOwSme+Oext7T5hZrmRV73KnY5a4llxgNe0sUTwC4T4PAvKQ0nDdEw7
         3+YszgW6pYVZfSqj0FRsD1jVMvmFQi6wSYmFzc93413hfWSmVyYpRlHo+rZHJ6QAH2Zq
         raFe10jxq0+f90ZtqjiyiLi66zefh96ZWX8nINN6NvFzt1+OnXB7Ynknffzf/r07Xqe8
         wyz2hFBe7ZnbL9e+mFDyCagsKj373UQSv9C9tVHhvHyqxLBhfhMuw7V3hQO0YV+PhGGN
         d2pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708647202; x=1709252002;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L5Em3s3/q2CUyMHI5GLnC+kLTqSg16IQlFmDVQC88lk=;
        b=ucl48vQd+SHW1Vioa7dbC0+xgqaJs9d/UighBx0PAf0yTpmxUwART/xy2Ox3Wz7XMp
         idWK3WvtnD1gov5HeUD3H5ixX8tMAZabX0yqMWZmPpIQ1KNngTZpZPKihyO6XGrL0D0K
         h120E+38BtOJM97KYVWycrrzLX7VdnS1D6o7fv4CjzxtTlF+9XSGx6QO9SnpRqz1zzOG
         Ai3q3CKH2lAHT6eNhMrsadJvRghcnUDrAZsrWlxrWegWYT1gsv+3jp5vVzN48cLAA+oY
         spav01+rnmGjzoaVZi+M1aXnheoXfXRqGD54kn3FT44KgY0FpxH7NJTEtQq4u6fYbjZ8
         SIJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjEIPZHmC66yVP5S1158RPG/TSywQJT3Yr4QObXqMyNrdlpX3wrqhFzDAunpZkBe3XqpkpXc9obC2z1PFkvkL/5TrjDorlvx0B26l7XoxQJdWzOrJc+Fo57wdplSdF8iPOWfwpXAxA0IaHBZrEn4WshXwPd4rRllNjL8ykKoRDIO05VA+4z/6q8IKpy7CF
X-Gm-Message-State: AOJu0YwFShQfU6gL4JK1Ziqdr4FNnlSR2DOkCu54JSGpJPZQv6XebJoS
	2yfMgOXryLA4hMWOvuV4hKD68jReqVtZs6+VXyK0Cpq+/0gER2Vq
X-Google-Smtp-Source: AGHT+IFv4LeO65EkNAqwadJ0BBErdtZpxveHyzBaHReS/tmrItYVzkCSWFZ1OSezKMDF+QAR4tGnaQ==
X-Received: by 2002:a17:902:c40d:b0:1db:ed54:a726 with SMTP id k13-20020a170902c40d00b001dbed54a726mr504391plk.63.1708647202165;
        Thu, 22 Feb 2024 16:13:22 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h7-20020a170902748700b001d9ef367c85sm10459048pll.104.2024.02.22.16.13.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 16:13:21 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <66fef2f4-2113-4b58-ad76-7d56cdc838ca@roeck-us.net>
Date: Thu, 22 Feb 2024 16:13:20 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] platform/x86: Add wmi driver for Casper Excalibur
 laptops. .....
Content-Language: en-US
To: =?UTF-8?Q?Mustafa_Ek=C5=9Fi?= <mustafa.eskieksi@gmail.com>,
 hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-hwmon@vger.kernel.org
Cc: jdelvare@suse.com, pavel@ucw.cz, lee@kernel.org
References: <20240222214815.245280-1-mustafa.eskieksi@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240222214815.245280-1-mustafa.eskieksi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/22/24 13:48, Mustafa Ekşi wrote:
> Adding wmi driver for Casper Excalibur Laptops:
> This driver implements a ledclass_dev device for keyboard backlight
> and hwmon driver to read fan speed and (also write) pwm mode. NEW_LEDS is
> selected because this driver introduces new leds, and LEDS_CLASS is selected
> because this driver implements a led class device. All of Casper Excalibur
> Laptops are supported but fan speeds has a bug for older generations.
> 

"Impressive" subject (I dropped most of it). Really, you should not do that.

> Signed-off-by: Mustafa Ekşi <mustafa.eskieksi@gmail.com>
>
[ ... ]

> +
> +static int casper_wmi_hwmon_read(struct device *dev,
> +				 enum hwmon_sensor_types type, u32 attr,
> +				 int channel, long *val)
> +{
> +	struct casper_wmi_args out = { 0 };
> +	struct wmi_device *wdev = to_wmi_device(dev->parent);
> +	int ret;
> +
> +	switch (type) {
> +	case hwmon_fan:
> +		ret = casper_query(wdev, CASPER_GET_HARDWAREINFO, &out);

Ignoring errors is unacceptable.

> +		/*
> +		 * a4 and a5 is little endian in older laptops (with 10th gen
> +		 * cpus or older) and big endian in newer ones. I don't think
> +		 * dmi has something for cpu information. Also, defining a
> +		 * dmi_list just for this seems like an overkill. This problem
> +		 * can be solved in userspace too.
> +		 */
> +		if (channel == 0) // CPU fan
> +			*val = out.a4;
> +		else if (channel == 1) // GPU fan
> +			*val = out.a5;
> +		return 0;
> +	case hwmon_pwm:
> +		ret = casper_query(wdev, CASPER_POWERPLAN, &out);
> +		if (ret) // power plan count varies generations.

That comment doesn't explain anything. If it is supposed to mean that it is
not supported on all laptop variants, the attribute should not be instantiated
in the first place. I am sure I mentioned this before.

> +			return ret;
> +		if (channel == 0)
> +			*val = out.a2;

There is only one pwm channel. Checking the channel number is pointless.


> +		return 0;
> +	default:
> +		return -ENODEV;

-EOPNOTSUPP

> +	}
> +}
> +
> +static int casper_wmi_hwmon_read_string(struct device *dev,
> +					enum hwmon_sensor_types type, u32 attr,
> +					int channel, const char **str)
> +{
> +	switch (type) {
> +	case hwmon_fan:
> +		switch (channel) {
> +		case 0:
> +			*str = "cpu_fan_speed";
> +			break;
> +		case 1:
> +			*str = "gpu_fan_speed";
> +			break;
> +		default:
> +			return -ENODEV;

-EOPNOTSUPP

> +		}
> +		break;
> +	default:
> +		return -ENODEV;
-EOPNOTSUPP

> +	}
> +	return 0;
> +}
> +
> +static int casper_wmi_hwmon_write(struct device *dev,
> +				  enum hwmon_sensor_types type, u32 attr,
> +				  int channel, long val)
> +{
> +	acpi_status ret;
> +
> +	switch (type) {
> +	case hwmon_pwm:
> +		if (val > 5 || val < 0)
> +			return -EINVAL;

pwm range, per ABI, is 0..255, not 0..5. It is expected to be normalized.

Since you are not using the standard ABI, what are the values returned
as fan speed ? Is that RPM or something else ?


> +		ret = casper_set(to_wmi_device(dev->parent),
> +				 CASPER_POWERPLAN, val, 0);
> +		if (ret)
> +			return ret;
> +		return 0;

		return ret;

> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static const struct hwmon_ops casper_wmi_hwmon_ops = {
> +	.is_visible = &casper_wmi_hwmon_is_visible,
> +	.read = &casper_wmi_hwmon_read,
> +	.read_string = &casper_wmi_hwmon_read_string,
> +	.write = &casper_wmi_hwmon_write
> +};
> +
> +static const struct hwmon_channel_info *const casper_wmi_hwmon_info[] = {
> +	HWMON_CHANNEL_INFO(fan,
> +			   HWMON_F_INPUT | HWMON_F_LABEL,
> +			   HWMON_F_INPUT | HWMON_F_LABEL),
> +	HWMON_CHANNEL_INFO(pwm, HWMON_PWM_MODE),
> +	NULL
> +};
> +
> +static const struct hwmon_chip_info casper_wmi_hwmon_chip_info = {
> +	.ops = &casper_wmi_hwmon_ops,
> +	.info = casper_wmi_hwmon_info,
> +};
> +
> +static int casper_wmi_probe(struct wmi_device *wdev, const void *context)
> +{
> +	struct device *hwmon_dev;
> +
> +	if (ACPI_FAILURE(led_classdev_register(&wdev->dev, &casper_kbd_led)))


I am quite sure that led_classdev_register() doesn't return ACPI error codes.

> +		return -ENODEV;
> +	hwmon_dev = devm_hwmon_device_register_with_info(&wdev->dev,
> +						"casper_wmi", wdev,
> +						&casper_wmi_hwmon_chip_info,
> +						NULL);
> +	return PTR_ERR_OR_ZERO(hwmon_dev);

Why use devm_hwmon_device_register_with_info() but not
devm_led_classdev_register() ?

> +}
> +
> +static void casper_wmi_remove(struct wmi_device *wdev)
> +{
> +	led_classdev_unregister(&casper_kbd_led);
> +}
> +
> +static const struct wmi_device_id casper_wmi_id_table[] = {
> +	{ CASPER_WMI_GUID, NULL },
> +	{ }
> +};
> +
> +static struct wmi_driver casper_wmi_driver = {
> +	.driver = {
> +		   .name = "casper-wmi",
> +		    },
> +	.id_table = casper_wmi_id_table,
> +	.probe = casper_wmi_probe,
> +	.remove = &casper_wmi_remove,
> +};
> +
> +module_wmi_driver(casper_wmi_driver);
> +MODULE_DEVICE_TABLE(wmi, casper_wmi_id_table);
> +
> +MODULE_AUTHOR("Mustafa Ekşi <mustafa.eskieksi@gmail.com>");
> +MODULE_DESCRIPTION("Casper Excalibur Laptop WMI driver");
> +MODULE_LICENSE("GPL");


