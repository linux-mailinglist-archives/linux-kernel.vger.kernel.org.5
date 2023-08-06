Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0880771557
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 15:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjHFNk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 09:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjHFNk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 09:40:57 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CF2A9;
        Sun,  6 Aug 2023 06:40:53 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99bc9e3cbf1so780384966b.0;
        Sun, 06 Aug 2023 06:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691329252; x=1691934052;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fU+KPSMF0wLESp4p8P4jvhJTfFBp1WYvnj+Ct4KwVLA=;
        b=TTOe/udkl54PiRYY0YOnLJPVGnBUdQFAFT8j1LYZqFtez/a3Fz5jAD3htIyUC28Nq5
         9dXvP3ITUDzbAQ4klubOAzfYIXZvnNfgOFQq1kkMV2ja3c306vjFXWJro8BProihS8xX
         IaSETbSZXLJZHF56pE6DjhEJHTDS4agel975om2vEqz3yG7Ro0Mr/41q6ZlsDZB4wSL4
         oE8L5Vf6LW1+VZR7xvZZ+lZQYqgr79ca/rUQLsmh8swQ7d+zen89KnBpvQIQgQWLZEiq
         C19CgVxGpZtLMYPbFwvcO0xrgyv4FDY7VdUp+hcsaSUu6/aFzBq+bMsRb5e53JITkFjc
         1V2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691329252; x=1691934052;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fU+KPSMF0wLESp4p8P4jvhJTfFBp1WYvnj+Ct4KwVLA=;
        b=cQx5di415X7CjGgnmJH2sChS7j3+rCtHWXjcXhqRaFcCr4viYFcXRCoV9rKXHyhyPD
         FKLyokGPclH1gzZTIh8k9Q7drqpg/JxjbqQDClQzB8np8/mw6UPY6p1+uJhtmpH+bp6d
         B7loEp2mWFZ5WGTkFJa+CXmXJ0p9lx/EJ/JKQFUq5DXMgXpRbxBeCbJz2FooLnz+mU9R
         s6eRh6g6tL5al+vSPsvlIrFSxHVnwWjRPXqZkTiKn5JMVn58tL3Cv3HAouoLHX1iifBB
         ucMHwpQ80Qm77kiQNeRIWJ/9HsAOvTPl7ulyWNaZjn112SdBO+QGpdcNCnPen+X46hq6
         W4hw==
X-Gm-Message-State: AOJu0YztNTzH9clWj+dh7Z164T4OF4JCEPtqICMOp2A4VE5OTWaoiIIf
        stDP/ftbMKNr9VMDkHV00TV1SIYfpsyc2w==
X-Google-Smtp-Source: AGHT+IGwFORKJYi3uARuhyJDcjA26nrtRcAUbPKoHvU0Zg71xUzoAqQTmnQ4pgCnjep/SYBAUX/GvA==
X-Received: by 2002:a17:906:74d2:b0:99c:602b:6a6d with SMTP id z18-20020a17090674d200b0099c602b6a6dmr6352950ejl.11.1691329251683;
        Sun, 06 Aug 2023 06:40:51 -0700 (PDT)
Received: from [192.168.4.4] (host-79-26-241-62.retail.telecomitalia.it. [79.26.241.62])
        by smtp.gmail.com with ESMTPSA id lf13-20020a170906ae4d00b0099cc402d3ddsm1580338ejb.202.2023.08.06.06.40.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Aug 2023 06:40:51 -0700 (PDT)
Message-ID: <75d97d40-767e-53b2-d3dd-5695ae7ac392@gmail.com>
Date:   Sun, 6 Aug 2023 15:40:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 2/2] iio: add MCP4728 I2C DAC driver
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1691066050.git.andrea.collamati@gmail.com>
 <a0933003ed3c855f9d80d6ce0a40add2b6f0ba36.1691066050.git.andrea.collamati@gmail.com>
 <20230805192859.116421bc@jic23-huawei>
From:   Andrea Collamati <andrea.collamati@gmail.com>
In-Reply-To: <20230805192859.116421bc@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

I tested the driver and I didn't find any issue.

These are the tests I performed:

Test Configuration:
SW:
git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
commit: ee812337ee74cc403b4fbd85840dbe1b21d9a60f

HW:
- Aster board from Toradex hosting imx7d processor
- Adafruit MCP4728 https://www.adafruit.com/product/4470

TEST:

Probe Test                                OK
#> insmod mcp4728.ko

Read Scales                                OK
~# cat /sys/devices/platform/soc/30800000.bus/30a50000.i2c/i2c-3/3-0064/iio:device1/out_voltage_scale_available
0.805664 0.500000 1.000000

Write DAC CH0                            OK
#>iio_attr -c mcp4728 voltage0 scale    1.000000
#>iio_attr -c mcp4728 voltage0 raw         750
Voltage Monitor Reading:                749 mV

Write DAC CH1                            OK
#>iio_attr -c mcp4728 voltage1 scale    0.5
#>iio_attr -c mcp4728 voltage1 raw        750
Voltage Monitor Reading:                378 mV

Write DAC CH2                            OK
#>iio_attr -c mcp4728 voltage2 scale    0.805664
#>iio_attr -c mcp4728 voltage2 raw        750
Voltage Monitor Reading:                603 mV ~ 750*0.805664 ~ 604 mV

Write DAC CH3                            OK
#>iio_attr -c mcp4728 voltage3 scale    1.000000
#>iio_attr -c mcp4728 voltage3 raw        350
Voltage Monitor Reading:                354 mV

Store EEPROM                            OK
#>echo y > /sys/devices/platform/soc/30800000.bus/30a50000.i2c/i2c-3/3-0064/iio:device1/store_eeprom
#>power cycle board
Voltage Monitor Reading CH0                749 mV
Voltage Monitor Reading CH1                378 mV
Voltage Monitor Reading CH2                605 mV
Voltage Monitor Reading CH3                355 mV

Power Down CH0
#>iio_attr -c mcp4728 voltage0 powerdown_mode 1kohm_to_gnd
#>iio_attr -c mcp4728 voltage0 powerdown 1
Voltage Monitor Reading CH0                 0 mV

Power Down CH1
#>iio_attr -c mcp4728 voltage1 powerdown_mode 1kohm_to_gnd
#>iio_attr -c mcp4728 voltage1 powerdown 1
Voltage Monitor Reading CH1                 0 mV

Power Down CH2
#>iio_attr -c mcp4728 voltage2 powerdown_mode 1kohm_to_gnd
#>iio_attr -c mcp4728 voltage2 powerdown 1
Voltage Monitor Reading CH2                 0 mV

Power Down CH3
#>iio_attr -c mcp4728 voltage3 powerdown_mode 1kohm_to_gnd
#>iio_attr -c mcp4728 voltage3 powerdown 1
Voltage Monitor Reading CH3                 0 mV


Regards

        Andrea

On 8/5/23 20:28, Jonathan Cameron wrote:
> On Thu,  3 Aug 2023 14:56:35 +0200
> Andrea Collamati <andrea.collamati@gmail.com> wrote:
>
>> MCP4728 is a 12-bit quad channel DAC with I2C interface.
>>
>> support for:
>>  * per-channel gain
>>  * per-channel power state
>>  * per-channel power down mode control
>>  * per-channel vref selection internal/vdd
>>  * store current state to on-chip EEPROM
>>
>> Signed-off-by: Andrea Collamati <andrea.collamati@gmail.com>
> Hi Andrea,
>
> On this final read through I noticed a few minor things. Rather than
> get you to do a v5 I've made the changes whilst applying. Please
> take a sanity check at
> https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/log/?h=testing
> to make sure I didn't break anything and let me know if I did!
>
> Applied with the below mentioned changes to the togreg branch of iio.git
> which is initially pushed out as testing to let 0-day poke at it and see
> if it can find any problems.
>
> Thanks,
>
> Jonathan
>
>> diff --git a/drivers/iio/dac/mcp4728.c b/drivers/iio/dac/mcp4728.c
>> new file mode 100644
>> index 000000000000..ba3eab349b0a
>> --- /dev/null
>> +++ b/drivers/iio/dac/mcp4728.c
>> @@ -0,0 +1,626 @@
> ...
>
>
>
>> +
>> +static int mcp4728_set_scale(int channel, struct mcp4728_data *data, int val,
>> +			     int val2)
>> +{
>> +	int scale = mcp4728_find_matching_scale(data, val, val2);
>> +
>> +	if (scale < 0)
>> +		return scale;
>> +
>> +	switch (scale) {
>> +	case MCP4728_SCALE_VDD:
>> +		data->chdata[channel].ref_mode = MCP4728_VREF_EXTERNAL_VDD;
>> +		break;
>> +	case MCP4728_SCALE_VINT_NO_GAIN:
>> +		data->chdata[channel].ref_mode = MCP4728_VREF_INTERNAL_2048mV;
>> +		data->chdata[channel].g_mode   = MCP4728_GAIN_X1;
>> +		break;
>> +	case MCP4728_SCALE_VINT_GAIN_X2:
>> +		data->chdata[channel].ref_mode = MCP4728_VREF_INTERNAL_2048mV;
>> +		data->chdata[channel].g_mode   = MCP4728_GAIN_X2;
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +	return 0;
> return instead of breaking above as nothing to be done after the switch.
> Side effect of that is this return 0 not needed.
>
>> +}
> ...
>
>> +static int mcp4728_write_raw(struct iio_dev *indio_dev,
>> +			     struct iio_chan_spec const *chan, int val,
>> +			     int val2, long mask)
>> +{
>> +	struct mcp4728_data *data = iio_priv(indio_dev);
>> +	int ret;
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_RAW:
>> +		if (val < 0 || val > GENMASK(MCP4728_RESOLUTION - 1, 0))
>> +			return -EINVAL;
>> +		data->chdata[chan->channel].dac_value = val;
>> +		ret = mcp4728_program_channel_cfg(chan->channel, indio_dev);
>> +		break;
> Direct returns preferred if no cleanup to do.
>
>> +	case IIO_CHAN_INFO_SCALE:
>> +		ret = mcp4728_set_scale(chan->channel, data, val, val2);
>> +		if (ret)
>> +			break;
>> +
>> +		ret = mcp4728_program_channel_cfg(chan->channel, indio_dev);
>> +		break;
>> +	default:
>> +		ret = -EINVAL;
>> +		break;
>> +	}
>> +
>> +	return ret;
>> +}
>
>
>> +static int mcp4728_init_channels_data(struct mcp4728_data *data)
>> +{
>> +	u8 inbuf[MCP4728_READ_RESPONSE_LEN];
>> +	int ret;
>> +	unsigned int i;
>> +
>> +	ret = i2c_master_recv(data->client, inbuf, MCP4728_READ_RESPONSE_LEN);
>> +	if (ret < 0) {
>> +		dev_err(&data->client->dev,
>> +			"failed to read mcp4728 conf. Err=%d\n", ret);
>> +		return ret;
> As this is only called from probe, we should still use dev_err_probe() in here
> as mentioned below.
>
>
>> +	} else if (ret != MCP4728_READ_RESPONSE_LEN) {
>> +		dev_err(&data->client->dev,
>> +			"failed to read mcp4728 conf. Wrong Response Len ret=%d\n",
>> +			ret);
>> +		return -EIO;
>> +	}
>> +
>> +	for (i = 0; i < MCP4728_N_CHANNELS; i++) {
>> +		struct mcp4728_channel_data *ch = &data->chdata[i];
>> +		u8 r2				= inbuf[i * 6 + 1];
>> +		u8 r3				= inbuf[i * 6 + 2];
>> +
>> +		ch->dac_value = FIELD_GET(MCP4728_DAC_H_MASK, r2) << 8 |
>> +				FIELD_GET(MCP4728_DAC_L_MASK, r3);
>> +		ch->ref_mode = FIELD_GET(MCP4728_VREF_MASK, r2);
>> +		ch->pd_mode  = FIELD_GET(MCP4728_PDMODE_MASK, r2);
>> +		ch->g_mode   = FIELD_GET(MCP4728_GAIN_MASK, r2);
>> +	}
>> +
>> +	return 0;
>> +}
> ...
>
>> +static int mcp4728_probe(struct i2c_client *client)
>> +{
>> +	const struct i2c_device_id *id = i2c_client_get_device_id(client);
>> +	struct mcp4728_data *data;
>> +	struct iio_dev *indio_dev;
>> +	int err;
>> +
>> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>> +	if (!indio_dev)
>> +		return -ENOMEM;
>> +
>> +	data = iio_priv(indio_dev);
>> +	i2c_set_clientdata(client, indio_dev);
>> +	data->client = client;
>> +
>> +	data->vdd_reg = devm_regulator_get(&client->dev, "vdd");
>> +	if (IS_ERR(data->vdd_reg))
>> +		return PTR_ERR(data->vdd_reg);
>> +
>> +	err = regulator_enable(data->vdd_reg);
>> +	if (err)
>> +		return err;
>> +
>> +	err = devm_add_action_or_reset(&client->dev, mcp4728_reg_disable,
>> +				       data->vdd_reg);
>> +	if (err)
>> +		return err;
>> +
>> +	/* MCP4728 has internal EEPROM that save each channel boot configuration.
> Trivial but comment syntax in IIO (there are some differences in a few other subsystems)
> is
> 	/*
> 	 * MCP...
>
>> +	 * It means that device configuration is unknown to the driver at kernel boot.
>> +	 * mcp4728_init_channels_data reads back DAC settings and stores them in data
>> +	 * structure.
>> +	 */
>> +	err = mcp4728_init_channels_data(data);
>> +	if (err) {
> I'd missed this previously but dev_err_probe() has several advantages in that
> it handles deferring neatly and also ends up with less code.
>
>> +		dev_err(&client->dev,
>> +			"failed to read mcp4728 current configuration\n");
>> +		return err;
>> +	}
>> +
>> +	err = mcp4728_init_scales_avail(data);
>> +	if (err) {
>> +		dev_err(&client->dev, "failed to init scales\n");
>> +		return err;
>> +	}
>> +
>> +	indio_dev->name		= id->name;
>> +	indio_dev->info		= &mcp4728_info;
>> +	indio_dev->channels	= mcp4728_channels;
>> +	indio_dev->num_channels = MCP4728_N_CHANNELS;
>> +	indio_dev->modes	= INDIO_DIRECT_MODE;
>> +
>> +	return devm_iio_device_register(&client->dev, indio_dev);
>> +}
