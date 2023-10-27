Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A617D97C0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 14:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345585AbjJ0MUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 08:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjJ0MUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 08:20:16 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E64FC0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 05:20:13 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-507975d34e8so2937633e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 05:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698409211; x=1699014011; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lNWeKQrm3Pv4VEOmFSW+qGUcdVGYIzaM8ErPxXFUzug=;
        b=ewEZX41M+sf+DDJ4zLYqeATdukxNb7DKvwGBdmTCi6jTcU/o4jJ9giOIK1K7dWraZ8
         i4ZgNUC5jRdTnpYV3nBUkiIZcOQQx3a4IWce2COVVVKNrvKN0ELPf3WYUtDmBSRN/kwO
         txWAbzQfHCZ9zaKkeSji3Lhygwj6F2vcM9ijIucgCDQsW7EhBnx0cdiiQFsRyExozMsn
         RPMiTe1b+yBuY34GbF57pfAfTtkb/q/54NfWU7mFCc1aJ1t0s/S6wDapJ3SDvvR/mAUd
         zWJnnrcVcTZ30uKZuOXlnSWRUo3PgBKiFKwqzn6UGe+ZPbZIBdP1uhUMAlo6EEltJ57r
         wJGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698409211; x=1699014011;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lNWeKQrm3Pv4VEOmFSW+qGUcdVGYIzaM8ErPxXFUzug=;
        b=WDAGj9JD9jiLCtHjW77bS66F76ZDVa4L/FVyqqkjC+g/Z3fiuAaf/QXiIoA05LD4EH
         xh7DFCjbHtd2u7/Ui/4yG6npLs60F+qtF+FwAs21vt6B7JuCqJ0r0UHd3+4h5KkHhtW3
         zli+kKPM6y9zWnjxFwkCkTUIQQMnEfuuaQxz5rZJ5105QCfPHBXRS1SZvtaLHg8/4XRD
         BXrcPwTXIWPMkXLKMqr/TXa4/ZSlhIYh7c9MFHm5iEF7qa2L8/gP047SLBK74hcCasWq
         5cs5kG4uRFPODPb7gHFYb1gpjKGzOEIXObI5WB8PRd1cueD1hwSPiPkeU75+veUmflGF
         bGfg==
X-Gm-Message-State: AOJu0YxEPl2SjFOl2xGIBMk4TNlaq0cWb+RVIs+FF5fEfIdmnSB1EaY2
        6TdSjOdNg6h2JeO01UnJgDJ6fg==
X-Google-Smtp-Source: AGHT+IFjosSc8YG1jOkfgyv8MjGZT4SObLRX06yPJk1Iwhv4fkBq8L+ICLUaFZ0Y92aC+Z1cchGyAA==
X-Received: by 2002:ac2:430a:0:b0:503:257a:7f5d with SMTP id l10-20020ac2430a000000b00503257a7f5dmr1481038lfh.31.1698409211446;
        Fri, 27 Oct 2023 05:20:11 -0700 (PDT)
Received: from [192.168.0.22] ([78.10.206.168])
        by smtp.gmail.com with ESMTPSA id z12-20020a19504c000000b00507b869b068sm261691lfj.302.2023.10.27.05.20.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Oct 2023 05:20:10 -0700 (PDT)
Message-ID: <42fd061d-7832-4531-bb85-eb8860c7e5e1@linaro.org>
Date:   Fri, 27 Oct 2023 14:20:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: adc: adding support for pac193x
Content-Language: en-US
To:     marius.cristea@microchip.com, jic23@kernel.org, lars@metafoo.de,
        robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231025134404.131485-1-marius.cristea@microchip.com>
 <20231025134404.131485-3-marius.cristea@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231025134404.131485-3-marius.cristea@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/10/2023 15:44, marius.cristea@microchip.com wrote:
> From: Marius Cristea <marius.cristea@microchip.com>
> 
> This is the iio driver for Microchip
> PAC193X series of Power Monitor with Accumulator chip family.
> 
> Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
> ---


...

> +
> +static ssize_t reset_accumulators_store(struct device *dev,
> +					struct device_attribute *attr,
> +					const char *buf, size_t count)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct pac1934_chip_info *info = iio_priv(indio_dev);
> +	int ret, i;
> +	u8 refresh_cmd = PAC1934_REFRESH_REG_ADDR;
> +
> +	ret = i2c_smbus_write_byte(info->client, refresh_cmd);
> +	if (ret) {
> +		dev_err(&indio_dev->dev,
> +			"%s - cannot send 0x%02X\n",
> +			__func__, refresh_cmd);
> +	}
> +
> +	for (i = 0 ; i < info->phys_channels; i++)
> +		info->chip_reg_data.energy_sec_acc[i] = 0;
> +
> +	return count;
> +}
> +
> +static IIO_DEVICE_ATTR(in_shunt_resistor_1, 0644, shunt_value_show, shunt_value_store, 0);
> +static IIO_DEVICE_ATTR(in_shunt_resistor_2, 0644, shunt_value_show, shunt_value_store, 0);
> +static IIO_DEVICE_ATTR(in_shunt_resistor_3, 0644, shunt_value_show, shunt_value_store, 0);
> +static IIO_DEVICE_ATTR(in_shunt_resistor_4, 0644, shunt_value_show, shunt_value_store, 0);
> +static IIO_DEVICE_ATTR(reset_accumulators, 0200, NULL, reset_accumulators_store, 0);
> +
> +static struct attribute *pac1934_all_attributes[] = {
> +	PAC1934_DEV_ATTR(in_shunt_resistor_1),
> +	PAC1934_DEV_ATTR(in_shunt_resistor_2),
> +	PAC1934_DEV_ATTR(in_shunt_resistor_3),
> +	PAC1934_DEV_ATTR(in_shunt_resistor_4),
> +	PAC1934_DEV_ATTR(reset_accumulators),
> +	NULL
> +};
> +
> +static int pac1934_prep_custom_attributes(struct pac1934_chip_info *info,
> +					  struct iio_dev *indio_dev)
> +{
> +	int i, j, active_channels_count = 0;
> +	struct attribute **pac1934_custom_attributes;
> +	struct attribute_group *pac1934_group;
> +	struct i2c_client *client = info->client;
> +
> +	for (i = 0 ; i < info->phys_channels; i++)
> +		if (info->active_channels[i])
> +			active_channels_count++;
> +
> +	pac1934_group = devm_kzalloc(&client->dev, sizeof(*pac1934_group), GFP_KERNEL);
> +
> +	pac1934_custom_attributes = devm_kzalloc(&client->dev,
> +						 (PAC1934_CUSTOM_ATTR_FOR_CHANNEL *
> +						 active_channels_count +
> +						 PAC1934_SHARED_DEVATTRS_COUNT)
> +						 * sizeof(*pac1934_group) + 1,
> +						 GFP_KERNEL);
> +	j = 0;
> +
> +	for (i = 0 ; i < info->phys_channels; i++) {
> +		if (info->active_channels[i]) {
> +			pac1934_custom_attributes[PAC1934_CUSTOM_ATTR_FOR_CHANNEL * j] =
> +			pac1934_all_attributes[PAC1934_CUSTOM_ATTR_FOR_CHANNEL * i];
> +			pac1934_custom_attributes[PAC1934_CUSTOM_ATTR_FOR_CHANNEL * j + 1] =
> +			pac1934_all_attributes[PAC1934_CUSTOM_ATTR_FOR_CHANNEL * i + 1];
> +			j++;
> +		}
> +	}
> +
> +	for (i = 0; i < PAC1934_SHARED_DEVATTRS_COUNT; i++)
> +		pac1934_custom_attributes[PAC1934_CUSTOM_ATTR_FOR_CHANNEL *
> +			active_channels_count + i] =
> +			pac1934_all_attributes[PAC1934_CUSTOM_ATTR_FOR_CHANNEL *
> +			info->phys_channels + i];
> +
> +	pac1934_group->attrs = pac1934_custom_attributes;
> +	info->pac1934_info.attrs = pac1934_group;
> +
> +	return 0;
> +}
> +
> +static void pac1934_remove(struct i2c_client *client)

Remove functions goes always after probe.

> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(&client->dev);
> +	struct pac1934_chip_info *info = iio_priv(indio_dev);
> +
> +	cancel_delayed_work_sync(&info->work_chip_rfsh);
> +}
> +
> +static int pac1934_probe(struct i2c_client *client)
> +{
> +	struct pac1934_chip_info *info;
> +	struct iio_dev *indio_dev;
> +	const char *name = NULL;
> +	int cnt, ret;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*info));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	info = iio_priv(indio_dev);
> +
> +	i2c_set_clientdata(client, indio_dev);
> +	info->client = client;
> +
> +	/*
> +	 * load default settings - all channels disabled,
> +	 * uni directional flow
> +	 */
> +	for (cnt = 0; cnt < PAC1934_MAX_NUM_CHANNELS; cnt++) {
> +		info->active_channels[cnt] = false;
> +		info->bi_dir[cnt] = false;
> +	}
> +
> +	info->crt_samp_spd_bitfield = PAC1934_SAMP_1024SPS;
> +
> +	ret = pac1934_chip_identify(info);
> +	if (ret)
> +		return -EINVAL;
> +
> +	if (ACPI_HANDLE(&client->dev)) {
> +		if (!info->phys_channels)
> +			/* failed to identify part number, unknown number of channels available */
> +			return -EINVAL;
> +
> +		name = pac1934_match_acpi_device(client, info);
> +	} else {
> +		name = pac1934_match_of_device(client, info);
> +	}
> +
> +	if (!name) {
> +		dev_dbg(&client->dev, "parameter parsing returned an error\n");
> +		return -EINVAL;
> +	}
> +
> +	mutex_init(&info->lock);
> +
> +	/*
> +	 * do now any chip specific initialization (e.g. read/write
> +	 * some registers), enable/disable certain channels, change the sampling
> +	 * rate to the requested value
> +	 */
> +	ret = pac1934_chip_configure(info);
> +	if (ret < 0)
> +		goto fail;

Why do you need to go to fail here? Is the work scheduled in error cases?

> +
> +	/* prepare the channel information */
> +	ret = pac1934_prep_iio_channels(info, indio_dev);
> +	if (ret < 0)
> +		goto fail;
> +
> +	ret = pac1934_prep_custom_attributes(info, indio_dev);
> +	if (ret < 0) {
> +		dev_err_probe(&indio_dev->dev, ret,
> +			      "Can't configure custom attributes for PAC1934 device\n");
> +		goto fail;
> +	}
> +
> +	info->pac1934_info.read_raw = pac1934_read_raw;
> +	info->pac1934_info.read_avail = pac1934_read_avail;
> +	info->pac1934_info.write_raw = pac1934_write_raw;
> +	info->pac1934_info.read_label = pac1934_read_label;
> +
> +	indio_dev->info = &info->pac1934_info;
> +	indio_dev->name = name;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	/*
> +	 * read whatever has been accumulated in the chip so far
> +	 * and reset the accumulators
> +	 */
> +	ret = pac1934_reg_snapshot(info, true, PAC1934_REFRESH_REG_ADDR,
> +				   PAC1934_MIN_UPDATE_WAIT_TIME_US);
> +	if (ret < 0)
> +		goto fail;
> +
> +	ret = devm_iio_device_register(&client->dev, indio_dev);
> +	if (ret < 0) {
> +		dev_err_probe(&indio_dev->dev, ret,
> +			      "Can't register IIO device\n");
> +		goto fail;
> +	}
> +
> +	return 0;
> +
> +fail:
> +	cancel_delayed_work_sync(&info->work_chip_rfsh);
> +
> +	return ret;
> +}
> +
> +static const struct i2c_device_id pac1934_id[] = {
> +	{ .name = "pac1931", .driver_data = (kernel_ulong_t)&pac1934_chip_config[PAC1931] },
> +	{ .name = "pac1932", .driver_data = (kernel_ulong_t)&pac1934_chip_config[PAC1932] },
> +	{ .name = "pac1933", .driver_data = (kernel_ulong_t)&pac1934_chip_config[PAC1933] },
> +	{ .name = "pac1934", .driver_data = (kernel_ulong_t)&pac1934_chip_config[PAC1934] },
> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, pac1934_id);
> +
> +static const struct of_device_id pac1934_of_match[] = {
> +	{
> +		.compatible = "microchip,pac1931",
> +		.data = &pac1934_chip_config[PAC1931]
> +	},
> +	{
> +		.compatible = "microchip,pac1932",
> +		.data = &pac1934_chip_config[PAC1932]
> +	},
> +	{
> +		.compatible = "microchip,pac1933",
> +		.data = &pac1934_chip_config[PAC1933]
> +	},
> +	{
> +		.compatible = "microchip,pac1934",
> +		.data = &pac1934_chip_config[PAC1934]
> +	},
> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(of, pac1934_of_match);
> +
> +/* using MCHP1930 to be compatible with WINDOWS ACPI */
> +static const struct acpi_device_id pac1934_acpi_match[] = {
> +	{"MCHP1930", 0},
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(acpi, pac1934_acpi_match);
> +
> +static struct i2c_driver pac1934_driver = {
> +	.driver	 = {
> +		.name = "pac1934",
> +		.of_match_table = pac1934_of_match,
> +		.acpi_match_table = ACPI_PTR(pac1934_acpi_match)

Drop ACPI_PTR, causes warnings.

Best regards,
Krzysztof

