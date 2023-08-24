Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5E878775E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 20:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242930AbjHXSAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 14:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242927AbjHXSAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 14:00:17 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB52A1BDA
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 11:00:14 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2bcbfb3705dso907981fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 11:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692900013; x=1693504813;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lYZHcTxXJHw9OYewCuzi+dT0UT4wAivZqPO8LL7yT7c=;
        b=eJyNiyNrxnw0ZpyiLywcITK2ybOydZF57sSmn7fFg/959UQkofQ4WxmIx1UfiY1sXT
         gJEyfq1kjtyhghx6UnNofjxLH09lFty6XK9Y7NQ/9jeowJ/SfNwzmF4WFTkTixnFusR9
         Fd8vpwY2SVDRe2fFTJfHInT3yn4kUAKJQKz+RoD7GflnEvzxphiLG78ay70uBUIBvAts
         E+lDnGAHg7hS5JQjkDj638rrZp05i7MJfIIZS1ECkZFKEPpEUkeyA0JkjMH8SQ9MYaVD
         f7ex0iNkUHaZmJbVSJMO9XwCT0f+WtM3duuux6Ccoi69KQ9NX/dAV4MXmYqeDnxqHbjI
         nDaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692900013; x=1693504813;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lYZHcTxXJHw9OYewCuzi+dT0UT4wAivZqPO8LL7yT7c=;
        b=N76VNah1bA+FDYTU3Y/PqvuPUawX28F08w46JUV7FCyWQno4+DR0Zsy0QcmyF9dzRh
         fu2lOOUitmInjgwXYYRyVghQoQNwmHYSm9YEO19IRvdd6N6dfNYfTcWEbiVtWC/RPYVa
         SZmq0bTRLz8WQVxHiNk2qLt8aFissRfFKdwTuCPGngjOUirKQPdunnAFclZIiaW6LtgY
         i24e1KtcFRix83VDgjKkzQ+6ceve3vP3ok0J8hzBAl+IZo925lZtqghPL/QTPsHQDxv2
         SKu1oGP8SpXa07kxu/LSJBZ+mLhzSQjgnPmyBTDhhhLHRXQ4uhAtq4H/sP/BPHfto9Rj
         VbwQ==
X-Gm-Message-State: AOJu0YwxditgQWbpvAhqvbMvE6jK727NVElCl2cnTqWM6Fm59yW1nnAY
        PB2UDFr2DvwfHwX3bqweBuJ6CQ==
X-Google-Smtp-Source: AGHT+IEb2yGbD4ShdZJbcfScmIownd+9qb8OVdLPR3mLqMhdsnU9wekaLls6Fasjtq9uj9pAmH1JwA==
X-Received: by 2002:a2e:b681:0:b0:2b9:c4f6:fdd with SMTP id l1-20020a2eb681000000b002b9c4f60fddmr12100794ljo.14.1692900012927;
        Thu, 24 Aug 2023 11:00:12 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id h17-20020a17090634d100b00993cc1242d4sm11173176ejb.151.2023.08.24.11.00.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 11:00:12 -0700 (PDT)
Message-ID: <fe4a3bf9-2260-fb41-a20b-2bf05b6c02e9@linaro.org>
Date:   Thu, 24 Aug 2023 20:00:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/3] iio: adc: add ltc2309 support
Content-Language: en-US
To:     Liam Beguin <liambeguin@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230824-ltc2309-v1-0-b87b4eb8030c@gmail.com>
 <20230824-ltc2309-v1-1-b87b4eb8030c@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230824-ltc2309-v1-1-b87b4eb8030c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/08/2023 18:55, Liam Beguin wrote:
> The LTC2309 is an 8-Channel, 12-Bit SAR ADC with an I2C Interface.
> 
> This implements support for all single-ended and differential channels,
> in unipolar mode only.
> 
> Signed-off-by: Liam Beguin <liambeguin@gmail.com>
> ---
>  drivers/iio/adc/Kconfig   |  10 ++
>  drivers/iio/adc/Makefile  |   1 +
>  drivers/iio/adc/ltc2309.c | 232 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 243 insertions(+)
> 



> +static int ltc2309_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan, int *val,
> +			    int *val2, long mask)
> +{
> +	struct ltc2309 *ltc2309 = iio_priv(indio_dev);
> +	u16 buf;
> +	int ret;
> +	u8 din;
> +
> +	mutex_lock(&ltc2309->lock);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		din = FIELD_PREP(LTC2309_DIN_CH_MASK, chan->address & 0x0f) |
> +			FIELD_PREP(LTC2309_DIN_UNI, 1) |
> +			FIELD_PREP(LTC2309_DIN_SLEEP, 0);
> +
> +		ret = i2c_smbus_write_byte(ltc2309->client, din);
> +		if (ret < 0) {
> +			dev_err(ltc2309->dev, "i2c command failed: %pe\n",
> +				ERR_PTR(ret));
> +			goto out;
> +		}
> +
> +		ret = i2c_master_recv(ltc2309->client, (char *)&buf, 2);
> +		if (ret < 0) {
> +			dev_err(ltc2309->dev, "i2c read failed: %pe\n",
> +				ERR_PTR(ret));
> +			goto out;
> +		}
> +
> +		*val = be16_to_cpu(buf) >> 4;
> +
> +		ret = IIO_VAL_INT;
> +		break;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = ltc2309->vref_mv;
> +		*val2 = LTC2309_ADC_RESOLUTION;
> +		ret = IIO_VAL_FRACTIONAL_LOG2;

Why this case is in critical section?

> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +out:
> +	mutex_unlock(&ltc2309->lock);
> +	return ret;
> +}
> +
> +static const struct iio_info ltc2309_info = {
> +	.read_raw = ltc2309_read_raw,
> +};
> +
> +static int ltc2309_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *id)
> +{
> +	struct iio_dev *indio_dev;
> +	struct ltc2309 *ltc2309;
> +	int ret = 0;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*ltc2309));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(client, indio_dev);
> +
> +	ltc2309 = iio_priv(indio_dev);
> +	ltc2309->dev = &indio_dev->dev;
> +	ltc2309->client = client;
> +	ltc2309->vref_mv = 4096; /* Default to the internal ref */
> +
> +	indio_dev->name = DRIVER_NAME;
> +	indio_dev->dev.parent = &client->dev;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = ltc2309_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(ltc2309_channels);
> +	indio_dev->info = &ltc2309_info;
> +
> +	ltc2309->refcomp = devm_regulator_get_optional(&client->dev, "refcomp");
> +	if (!IS_ERR_OR_NULL(ltc2309->refcomp)) {
> +		ret = regulator_enable(ltc2309->refcomp);
> +		if (ret) {
> +			dev_err(ltc2309->dev, "failed to enable REFCOMP\n");
> +			return ret;
> +		}
> +
> +		ret = regulator_get_voltage(ltc2309->refcomp);
> +		if (ret < 0)

You have unbalanced regulator. Same in all further error paths.

> +			return ret;
> +
> +		ltc2309->vref_mv = ret / 1000;
> +		if (ret)
> +			return ret;
> +	}
> +
> +	mutex_init(&ltc2309->lock);
> +
> +	return devm_iio_device_register(&client->dev, indio_dev);
> +}
> +


Best regards,
Krzysztof

