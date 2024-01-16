Return-Path: <linux-kernel+bounces-27522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE27582F189
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 16:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C501D1C23613
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 15:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F4B1C29E;
	Tue, 16 Jan 2024 15:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I3nKi4lL"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8E51C6B4
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 15:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a29058bb2ceso1060829466b.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 07:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705419053; x=1706023853; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EbzIVaYaEJ5SWavDcHCxKGfea/F5k+gN6HpNmraJ9/Y=;
        b=I3nKi4lL2JDxmzJYxGKi6e8Z9cgcEFNbqg5vZwB76THZlMXO0UZ5dmypzcCC0eYQvj
         BmhaVIHx2eH5s/mhjvfzQqTLMjbUEgL/QCdy0HJCz7blSka1JTx8nymoe/po3ymlFSJB
         ToL0flzmqmtWSrWQTXIqDTZnquAi+FTB6K21A4rUYLC/+aRc/iCN8IqFhV57Gm7+gRtk
         JLq0w1KWZkfnvPSwZzNw6DF2smYaeSNnMwEIOKrrxQx/qiuDUdMA6LEjeMN049AeIShX
         iJiuJqlI8bYNOrZ+BRkKbblfL2QHitVF491ZQNRkJCz1ChthRIeCsZ6xpb4lmu9RDl34
         oPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705419053; x=1706023853;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EbzIVaYaEJ5SWavDcHCxKGfea/F5k+gN6HpNmraJ9/Y=;
        b=UtTrQdHqrhW3s4v13I9LqRAGrzzalTKNc7wc19PEbO4BMhULCpSz326+ExgfmPNMSP
         0eW2xl3lTJAqw/2zjWBfhYEUHk0bjGksAcsFG7QEqzi9kr/lS6KUSCjc0XT/29ZTmaL+
         WcoNbfbMPu4PvYcOQ09Yf77yMq+XiDnorTHAB8EoCdOeTBzZAWfh6M6sH8mo5dA+t176
         wL1olMswW9cgFWEIure4gvqQ32Vnb1VY1aH+3BsmdsHoJ9X2EBIaoU9BijHyakIQFMJL
         2pfg1rGGqkIkbdicB+JRNli/99dMlxVg39fXLQT7e4kXQykypGzaMbgZcSIu5U/IMqAY
         HAVg==
X-Gm-Message-State: AOJu0YxDvdlJosVPz4OC1jm24Qygk0xAwcfamxrw7NSv0zKaHEXvOPVf
	3aznjkwiLCSyvKZrOg8vK1DwS0AsGbM5Cw==
X-Google-Smtp-Source: AGHT+IEy2Wv8uv7pwg1lEUjw5aZ2TXHN+V8rUUEmTOgZIXH0NKvsp9UN3D0q7SWEiyehqzH88DEcwg==
X-Received: by 2002:a17:906:f0d3:b0:a28:d16d:5aab with SMTP id dk19-20020a170906f0d300b00a28d16d5aabmr2507615ejb.157.1705419053616;
        Tue, 16 Jan 2024 07:30:53 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id qo11-20020a170907874b00b00a2ce46a27besm5078908ejc.190.2024.01.16.07.30.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 07:30:53 -0800 (PST)
Message-ID: <fd8a8f09-7661-42c2-ace6-0a0e4845184d@linaro.org>
Date: Tue, 16 Jan 2024 16:30:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] iio: pressure: Add driver for Sensirion SDP500
Content-Language: en-US
To: Petar Stoykov <pd.pstoykov@gmail.com>, linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Angel Iglesias <ang.iglesiasg@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <CADFWO8HOb4zY7rPsCxWe2nvrzd8FjVNw0k8=8s4yB7C_BwS0ig@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CADFWO8HOb4zY7rPsCxWe2nvrzd8FjVNw0k8=8s4yB7C_BwS0ig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/01/2024 16:24, Petar Stoykov wrote:
> Sensirion SDP500 is a digital differential pressure sensor. The sensor is
> accessed over I2C.
> 

>      tristate "STMicroelectronics pressure sensor Driver"
>      depends on (I2C || SPI_MASTER) && SYSFS
> diff --git a/drivers/iio/pressure/Makefile b/drivers/iio/pressure/Makefile
> index 436aec7e65f3..489ef7b7befa 100644
> --- a/drivers/iio/pressure/Makefile
> +++ b/drivers/iio/pressure/Makefile
> @@ -25,6 +25,7 @@ obj-$(CONFIG_MS5611) += ms5611_core.o
>  obj-$(CONFIG_MS5611_I2C) += ms5611_i2c.o
>  obj-$(CONFIG_MS5611_SPI) += ms5611_spi.o
>  obj-$(CONFIG_MS5637) += ms5637.o
> +obj-$(CONFIG_SDP500) += sdp500.o
>  obj-$(CONFIG_IIO_ST_PRESS) += st_pressure.o
>  st_pressure-y := st_pressure_core.o
>  st_pressure-$(CONFIG_IIO_BUFFER) += st_pressure_buffer.o
> diff --git a/drivers/iio/pressure/sdp500.c b/drivers/iio/pressure/sdp500.c
> new file mode 100644
> index 000000000000..bc492ef3ef3e
> --- /dev/null
> +++ b/drivers/iio/pressure/sdp500.c
> @@ -0,0 +1,201 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +
> +#define SDP500_CRC8_POLYNOMIAL  0x31   // x8 + x5 + x4 + 1 (normalized to 0x31)
> +#define SDP500_READ_SIZE        3
> +
> +#define SDP500_SCALE_FACTOR 60
> +
> +#define SDP500_I2C_START_MEAS 0xF1
> +
> +#define sdp500_err(idev, fmt, ...)                    \
> +    dev_err(idev->dev.parent, fmt "\n", ##__VA_ARGS__)

Nope, drop

> +
> +#define sdp500_dbg(idev, fmt, ...)                    \
> +    dev_dbg(idev->dev.parent, fmt "\n", ##__VA_ARGS__)
> +
> +#define sdp500_info(idev, fmt, ...)                    \
> +    dev_info(idev->dev.parent, fmt "\n", ##__VA_ARGS__)

Drop all three.

> +
> +struct sdp500_data {
> +    struct device *dev;
> +};
> +
> +uint8_t calculate_crc8(uint8_t *data, uint32_t len, uint8_t poly)

Why this is not static?


> +{
> +    uint8_t    count = 0;
> +    uint8_t    value = 0;
> +    uint8_t    temp = 0;

Weird indentation.

You should not implement your own CRC functions. Don't we have CRC8 in
the kernel?

> +
> +    while (len--) {
> +        temp = *(data);
> +        data++;
> +        value ^= temp;
> +        for (count = 0; count < BITS_PER_BYTE; count++) {
> +            if (value & 0x80)
> +                value = (value << 1) ^ poly;
> +            else
> +                value = value << 1;
> +        }
> +    }
> +
> +    return value;
> +}
> +
> +static int sdp500_xfer(struct sdp500_data *data, u8 *txbuf, size_t txsize,
> +              u8 *rxbuf, size_t rxsize, const struct iio_dev *indio_dev)
> +{
> +    struct i2c_client *client = to_i2c_client(data->dev);
> +    int ret;
> +
> +    ret = i2c_master_send(client, txbuf, txsize);
> +    if (ret < 0) {
> +        sdp500_err(indio_dev, "Failed to send data");
> +        return ret;
> +    }
> +    if (ret != txsize) {
> +        sdp500_err(indio_dev, "Data is sent wrongly");
> +        return -EIO;
> +    }
> +
> +    if (!rxsize)
> +        return 0;
> +
> +    ret = i2c_master_recv(client, rxbuf, rxsize);
> +    if (ret < 0) {
> +        sdp500_err(indio_dev, "Failed to receive data");
> +        return ret;
> +    }
> +    if (ret != rxsize) {
> +        sdp500_err(indio_dev, "Data is received wrongly");
> +        return -EIO;
> +    }
> +
> +    return 0;
> +}
> +
> +static int sdp500_start_measurement(struct sdp500_data *data, const
> struct iio_dev *indio_dev)


Your patchset is corrupted.

> +{
> +    u8 txbuf = SDP500_I2C_START_MEAS;
> +
> +    return sdp500_xfer(data, &txbuf, 1, NULL, 0, indio_dev);
> +}
> +
> +static const struct iio_chan_spec sdp500_channels[] = {
> +    {
> +        .type = IIO_PRESSURE,
> +        .info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> +    },
> +};
> +
> +static int sdp500_read_raw(struct iio_dev *indio_dev,
> +              struct iio_chan_spec const *chan,
> +              int *val, int *val2, long mask)
> +{
> +    int ret = -EINVAL;
> +    u8 rxbuf[SDP500_READ_SIZE];
> +    u8 rec_crc, calculated_crc;
> +    s16 dec_value;
> +    struct sdp500_data *data = iio_priv(indio_dev);
> +
> +    switch (mask) {
> +    case IIO_CHAN_INFO_PROCESSED:
> +        sdp500_xfer(data, NULL, 0, rxbuf, SDP500_READ_SIZE, indio_dev);
> +        rec_crc = rxbuf[2];
> +        calculated_crc = calculate_crc8(rxbuf, SDP500_READ_SIZE - 1,
> +                        SDP500_CRC8_POLYNOMIAL);
> +        if (rec_crc != calculated_crc) {
> +            sdp500_err(indio_dev, "calculated crc = 0x%.2X but
> received 0x%.2X",
> +                calculated_crc, rec_crc);

Your patchset is corrupted.

> +            return -EIO;
> +        }
> +
> +        dec_value = ((rxbuf[0] << 8) & 0xFF00) | rxbuf[1];
> +        sdp500_dbg(indio_dev, "dec value = %d", dec_value);
> +
> +        *val = dec_value;
> +        *val2 = SDP500_SCALE_FACTOR;
> +        ret = IIO_VAL_FRACTIONAL;
> +        break;
> +    }
> +    return ret;
> +}
> +
> +static const struct iio_info sdp500_info = {
> +    .read_raw = &sdp500_read_raw,
> +};
> +
> +static int sdp500_probe(struct i2c_client *client)
> +{
> +    struct iio_dev *indio_dev;
> +    struct sdp500_data *data;
> +    struct device *dev = &client->dev;
> +    int ret;
> +
> +    indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +    if (!indio_dev) {
> +        dev_err(dev->parent, "Failed to allocate iio device\n");

No printing on ENOMEM. Run coccinelle/coccicheck on your patchset. There
is no code in kernel doing this, so please take existing code as base
for your driver, instead of upstreaming ancient out-of-tree poor code.

> +        return -ENOMEM;
> +    }
> +
> +    i2c_set_clientdata(client, indio_dev);
> +
> +    data = iio_priv(indio_dev);
> +    data->dev = dev;
> +
> +    indio_dev->dev.parent = dev;
> +    indio_dev->name = client->name;
> +    indio_dev->channels = sdp500_channels;
> +    indio_dev->info = &sdp500_info;
> +    indio_dev->modes = INDIO_DIRECT_MODE;
> +    indio_dev->num_channels = ARRAY_SIZE(sdp500_channels);
> +
> +    ret = sdp500_start_measurement(data, indio_dev);
> +    if (ret) {
> +        sdp500_err(indio_dev, "Failed to start measurement");

You must use dev_err, not own print methods.

> +        return ret;
> +    }
> +
> +    ret = iio_device_register(indio_dev);

Why not devm?

> +    if (ret < 0) {
> +        sdp500_err(indio_dev, "Failed to register indio_dev");

dev_err

> +        return ret;
> +    }
> +
> +    return 0;
> +}
> +
> +static const struct i2c_device_id sdp500_id[] = {
> +    { "sdp500" },
> +    { },
> +};
> +MODULE_DEVICE_TABLE(i2c, sdp500_id);
> +
> +static void sdp500_remove(struct i2c_client *client)
> +{
> +    struct iio_dev *indio_dev = dev_get_drvdata(&client->dev);
> +
> +    iio_device_unregister(indio_dev);
> +}
> +
> +static const struct of_device_id sdp500_of_match[] = {
> +    { .compatible = "sensirion,sdp500" },
> +    { }
> +};
> +MODULE_DEVICE_TABLE(of, sdp500_of_match);
> +
> +static struct i2c_driver sdp500_driver = {
> +    .driver = {
> +        .name    = "sensirion,sdp500",
> +        .of_match_table = sdp500_of_match,
> +    },
> +    .probe        = sdp500_probe,
> +    .remove        = sdp500_remove,

Some random wrapping here..

Best regards,
Krzysztof


