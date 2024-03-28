Return-Path: <linux-kernel+bounces-122588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F2388FA0D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBE861F2505E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636F851C5F;
	Thu, 28 Mar 2024 08:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VC+WA3m6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6262B41757;
	Thu, 28 Mar 2024 08:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711614851; cv=none; b=DgTi3z2+8Euozhhxp8ED5tvSicLZGA/gFw256OKzjjyM5TUjE9ponCQPxupqtm45qqCLCO2qhhBXr0VuuDFz/V+RpZpHoKcVoEZ2+kN9Rhs1+4ePD+Wq27KgkFhA7eKx+O3nzQ73R86jj7Fj8k6aSvmXM/Ixlc8NVtokywjYDDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711614851; c=relaxed/simple;
	bh=OC40G0SGkVpDUWU+MI8Q0vqzOKDBI+Tgu+nObT4hr7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TqY4S9Dqn19fatv/IqcXQL3rRfILuEP5SB527kCW11xHh2TH/gb/qUN31rt2oIQeAU6TCtl45Sf5wnm9MQNiu32imU8n4dcrA3FdCVf8Rfex2u2h6ymVbtoyTXFngAkBsQu6siMXHca10WWy79wGhYf6FLORVmcdEiwxScEprsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VC+WA3m6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78345C433C7;
	Thu, 28 Mar 2024 08:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711614850;
	bh=OC40G0SGkVpDUWU+MI8Q0vqzOKDBI+Tgu+nObT4hr7I=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=VC+WA3m6AeorAww6zgpsMkzLQrCeoUnutrPDnToJgqFHT8LKpqiyivDUEZktU5g4t
	 C7hUr4C29sU3X+tqhBVb8J6HeLa0r18Ml3YdNoXKM8dNA5H5fJ2EcJLsKsdKh+zbIO
	 2F9t+dua+h+tTI4tf5rPFzw6G71PFrkjz9UopYm4o6DYn2QW1tGBOdsHl8RdAw15lC
	 WxBeCT7+Laejz/vXfxFt7C9q+CFpfOfZvanZ2n1raM842vhqRrWzIgZH8nhoDOchFH
	 eIe6sTjkJItSDlyTFFOK56s+DKV87DwCP6AkseN2+vmnvN/8grsGEi3wvFG5c+vvmf
	 qWUN3Wm7GeVgQ==
Message-ID: <22594615-7929-4529-b010-ceb8d387742e@kernel.org>
Date: Thu, 28 Mar 2024 09:34:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] input/touchscreen: synaptics_tcm_oncell: add driver
To: Frieder Hannenheim <friederhannenheim@riseup.net>,
 dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240327214643.7055-1-friederhannenheim@riseup.net>
Content-Language: en-US
From: Krzysztof Kozlowski <krzk@kernel.org>
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240327214643.7055-1-friederhannenheim@riseup.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/03/2024 22:39, Frieder Hannenheim wrote:
> This is a bit of a stripped down and partially reworked driver for the
> synaptics_tcm_oncell touchscreen. I based my work off the driver in the
> LineageOS kernel found at
> https://github.com/LineageOS/android_kernel_oneplus_sm8250 branch
> lineage-20. The code was originally written by OnePlus developers but
> I'm not sure how to credit them correctly.
> 
> Currently the driver is in a pretty good shape, the only thing that is
> not working is setting a report config. To me it looks like some data is
> sent by the touchscreen firmware after setting the report config that is
> making the irq handler crash. Sadly I haven't been able to test out why.
> The driver works fine also with the default touch report config so maybe
> we can just use that and not set our own. 
> 
> Signed-off-by: Frieder Hannenheim <friederhannenheim@riseup.net>
> ---
>  .../input/touchscreen/syna,s3908.yaml         |   63 +

Please run scripts/checkpatch.pl and fix reported warnings. Then please
run `scripts/checkpatch.pl --strict` and (probably) fix more warnings.
Some warnings can be ignored, especially from --strict run, but the code
here looks like it needs a fix. Feel free to get in touch if the warning
is not clear.

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC. It might happen, that command when run on an older
kernel, gives you outdated entries. Therefore please be sure you base
your patches on recent Linux kernel.

Tools like b4 or scripts/get_maintainer.pl provide you proper list of
people, so fix your workflow. Tools might also fail if you work on some
ancient tree (don't, instead use mainline), work on fork of kernel
(don't, instead use mainline) or you ignore some maintainers (really
don't). Just use b4 and everything should be fine, although remember
about `b4 prep --auto-to-cc` if you added new patches to the patchset.

You missed at least devicetree list (maybe more), so this won't be
tested by automated tooling. Performing review on untested code might be
a waste of time, thus I will skip this patch entirely till you follow
the process allowing the patch to be tested.

Please kindly resend and include all necessary To/Cc entries.


>  drivers/input/touchscreen/Kconfig             |   11 +


(skipping untested bindings)

..

> +
> +static int syna_tcm_probe(struct i2c_client *client)
> +{
> +	struct syna_tcm_data *tcm_info;
> +	int err;
> +
> +	pr_info("starting probe for syna_tcm_oncell touchscreen");

No, drop. Drop such msgs everywhere if you have more than only here.

> +
> +	if (!i2c_check_functionality(client->adapter,
> +				     I2C_FUNC_I2C | I2C_FUNC_SMBUS_BYTE_DATA |
> +					     I2C_FUNC_SMBUS_I2C_BLOCK))
> +		return -ENODEV;
> +
> +	tcm_info = devm_kzalloc(&client->dev, sizeof(*tcm_info), GFP_KERNEL);
> +	if (!tcm_info)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(client, tcm_info);
> +	tcm_info->client = client;
> +	tcm_info->response_buf = NULL;
> +
> +	of_property_read_u32(client->dev.of_node, "max-objects",
> +			     &tcm_info->touchpanel_max_objects);
> +
> +	tcm_info->reset_gpio =
> +		gpiod_get_index(&client->dev, "reset", 0, GPIOD_OUT_HIGH);

Misaligned / wrongly wrapped. There is no wrapping of code after =.


> +
> +	tcm_info->regulators[SYNA_TCM_ONCELL_REGULATOR_VDD].supply = "vdd";
> +	tcm_info->regulators[SYNA_TCM_ONCELL_REGULATOR_VCC].supply = "vcc";
> +	err = devm_regulator_bulk_get(&client->dev,
> +				      ARRAY_SIZE(tcm_info->regulators),
> +				      tcm_info->regulators);
> +	if (err)
> +		return err;
> +
> +	// TODO: uncomment once syna_tcm_power_off is implemented
> +	// err = devm_add_action_or_reset(&client->dev, syna_tcm_oncell_power_off, tcm_info);
> +	// if (err)
> +	//     return err;

No dead code.

> +
> +	err = syna_tcm_power_on(tcm_info);
> +	if (err < 0)
> +		return err;
> +
> +	// This needs to happen before the first write to the device
> +	err = devm_request_threaded_irq(&client->dev, client->irq, NULL,
> +					syna_irq_handler,
> +					IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> +					"syna_tcm_oncell_irq", tcm_info);
> +	if (err)
> +		return err;
> +
> +	err = syna_tcm_run_application_firmware(tcm_info);
> +	if (err < 0)
> +		return err;
> +
> +	// err = syna_tcm_set_normal_report_config(tcm_info);
> +	// if (err < 0)
> +		// pr_err("syna_tcm: failed to set normal touch report config")

No dead code in the driver.

> +
> +	err = syna_tcm_get_report_config(tcm_info);
> +	if (err < 0)
> +		return err;
> +
> +	tcm_info->input = devm_input_allocate_device(&client->dev);
> +	if (!tcm_info->input)
> +		return -ENOMEM;
> +
> +	tcm_info->input->name = TOUCHPANEL_DEVICE;
> +	tcm_info->input->id.bustype = BUS_I2C;
> +
> +	input_set_abs_params(tcm_info->input, ABS_MT_POSITION_X, 0,
> +			     le2_to_uint(tcm_info->app_info.max_x), 0, 0);
> +	input_set_abs_params(tcm_info->input, ABS_MT_POSITION_Y, 0,
> +			     le2_to_uint(tcm_info->app_info.max_y), 0, 0);
> +	input_set_abs_params(tcm_info->input, ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0);
> +	input_set_abs_params(tcm_info->input, ABS_MT_TOUCH_MINOR, 0, 255, 0, 0);
> +	input_set_abs_params(tcm_info->input, ABS_MT_PRESSURE, 0, 255, 0, 0);
> +
> +	touchscreen_parse_properties(tcm_info->input, true, &tcm_info->prop);
> +
> +	err = input_mt_init_slots(tcm_info->input,
> +				  tcm_info->touchpanel_max_objects,
> +				  INPUT_MT_DIRECT);
> +	if (err)
> +		return err;
> +
> +	input_set_drvdata(tcm_info->input, tcm_info);
> +
> +	err = input_register_device(tcm_info->input);
> +	if (err)
> +		return err;
> +
> +	pr_info("syna_tcm: probe done");

No, no simple function success messages. There is already infrastructure
for this (tracing, sysfs).

> +	tcm_info->initialize_done = true;
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id syna_driver_ids[] = {
> +	{
> +		.compatible = "syna,s3908",
> +	},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, syna_driver_ids);
> +
> +static const struct i2c_device_id syna_i2c_ids[] = { { TOUCHPANEL_DEVICE, 0 },

That does not look like kernel coding style.

> +						     {} };
> +MODULE_DEVICE_TABLE(i2c, syna_i2c_ids);
> +
> +// static const struct dev_pm_ops syna_pm_ops = {
> +//     .suspend = syna_i2c_suspend,
> +//     .resume = syna_i2c_resume,
> +// };

Please do not submit dead code.


Best regards,
Krzysztof


