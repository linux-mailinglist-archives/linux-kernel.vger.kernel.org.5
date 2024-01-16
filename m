Return-Path: <linux-kernel+bounces-27606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A55E982F2D5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 516A1B228A9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 17:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3CF1CAA1;
	Tue, 16 Jan 2024 17:03:45 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7885B1CA89;
	Tue, 16 Jan 2024 17:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705424623; cv=none; b=QABeOsPOszeuGdMEqbCEDM2INWzmUCXxAa0Zbc5MpnA86lPXRn2QrL7Q3bPe3+nCV1ibpf03tn7Y2QnuHxBzq16sPDrORdcB9HzXFRyRfBHubJFtth20bJNuqIli4Ifgqmt9CNQskfsNMIEGQseGIm8chw2zL5tU20Rh9HNP5uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705424623; c=relaxed/simple;
	bh=Iryg8KrxxgdWSHphlT7lDjJwG4k18Z9+h8+ipGqOQyM=;
	h=Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 In-Reply-To:References:Organization:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy; b=dJHW0zHsvSWM+HxqDREHP4m6UXzduwx4Pq9ikTzj68TLtc2bFz46vxrYAAkxSnHkYW+AHhu6pSROeMcop8v+K2bLf8EJQRKJIgZC/lmExFKdizR/YUSa/CA5xAn8IJixTwxSw3q23dUIkEvTJ+4+f+3bzzZBdOeqzsP2BtGZ1T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; none
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TDwJ53MYZz67FD1;
	Wed, 17 Jan 2024 01:00:53 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 7DB1B140B2F;
	Wed, 17 Jan 2024 01:03:38 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 16 Jan
 2024 17:03:38 +0000
Date: Tue, 16 Jan 2024 17:03:37 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Petar Stoykov <pd.pstoykov@gmail.com>
CC: <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Angel Iglesias
	<ang.iglesiasg@gmail.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH 2/3] iio: pressure: Add driver for Sensirion SDP500
Message-ID: <20240116170337.00003a02@Huawei.com>
In-Reply-To: <CADFWO8HOb4zY7rPsCxWe2nvrzd8FjVNw0k8=8s4yB7C_BwS0ig@mail.gmail.com>
References: <CADFWO8HOb4zY7rPsCxWe2nvrzd8FjVNw0k8=8s4yB7C_BwS0ig@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 16 Jan 2024 16:24:56 +0100
Petar Stoykov <pd.pstoykov@gmail.com> wrote:

> Sensirion SDP500 is a digital differential pressure sensor. The sensor is
> accessed over I2C.
> 
> Signed-off-by: Petar Stoykov <pd.pstoykov@gmail.com>
Hi Petar,

Welcome to IIO.

A few quick comments inline to add to Krzysztof's review

Jonathan

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
> +
> +#define sdp500_dbg(idev, fmt, ...)                    \
> +    dev_dbg(idev->dev.parent, fmt "\n", ##__VA_ARGS__)
> +
> +#define sdp500_info(idev, fmt, ...)                    \
> +    dev_info(idev->dev.parent, fmt "\n", ##__VA_ARGS__)
Agree with Krzysztof - should never wrap these up.

> +
> +struct sdp500_data {
> +    struct device *dev;
> +};
> +
> +uint8_t calculate_crc8(uint8_t *data, uint32_t len, uint8_t poly)
> +{
> +    uint8_t    count = 0;
> +    uint8_t    value = 0;
> +    uint8_t    temp = 0;
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
As pointed out in other review - should be no need to reinvent the wheel.
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

This looks wrong from my reading of the datasheet and what
the datasheet shows can be done with standard functions
that handle these corner cases for you.

> +
> +    return 0;
> +}
> +
> +static int sdp500_start_measurement(struct sdp500_data *data, const
> struct iio_dev *indio_dev)
> +{
> +    u8 txbuf = SDP500_I2C_START_MEAS;
> +
> +    return sdp500_xfer(data, &txbuf, 1, NULL, 0, indio_dev);

Just call i2c_master_send() here directly.
However this looks like 
i2c_smbus_write_byte() ?

> +}
> +
> +static const struct iio_chan_spec sdp500_channels[] = {
> +    {
> +        .type = IIO_PRESSURE,
> +        .info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),

Looks like a simple linear scale.  Would be better to make scaling
a userspace / consumer problem and provide IIO_CHAN_INFO_RAW
and IIO_CHAN_INFO_SCALE.

> +    },
> +};
> +
> +static int sdp500_read_raw(struct iio_dev *indio_dev,
> +              struct iio_chan_spec const *chan,
> +              int *val, int *val2, long mask)
> +{
> +    int ret = -EINVAL;

Rarely a good idea. Better to return this where it is
clear why this value makes sense.
> +    u8 rxbuf[SDP500_READ_SIZE];
> +    u8 rec_crc, calculated_crc;
> +    s16 dec_value;
> +    struct sdp500_data *data = iio_priv(indio_dev);
> +
> +    switch (mask) {
> +    case IIO_CHAN_INFO_PROCESSED:
> +        sdp500_xfer(data, NULL, 0, rxbuf, SDP500_READ_SIZE, indio_dev);

A zero size send is unusual. I'm not really seeing how it lines
up with the datasheet either. 
The sequence shown there looks more like an
i2c_smbus_read_i2c_block_data() call as it shows it happening
as one transaction (figure in 4.1 doesn't have a NA after the
command is sent).
https://sensirion.com/media/documents/63859DD0/6166CF0E/Sensirion_Differential_Pressure_Datasheet_SDP600Series.pdf
(also note that this appears to say the sdp600 is
covered as well)



> +        rec_crc = rxbuf[2];
> +        calculated_crc = calculate_crc8(rxbuf, SDP500_READ_SIZE - 1,
> +                        SDP500_CRC8_POLYNOMIAL);
> +        if (rec_crc != calculated_crc) {
> +            sdp500_err(indio_dev, "calculated crc = 0x%.2X but
> received 0x%.2X",
> +                calculated_crc, rec_crc);
> +            return -EIO;
> +        }
> +
> +        dec_value = ((rxbuf[0] << 8) & 0xFF00) | rxbuf[1];

Look like a get_unaligned_be16() call opencoded - use that instead
of this.


> +        sdp500_dbg(indio_dev, "dec value = %d", dec_value);
> +
> +        *val = dec_value;
> +        *val2 = SDP500_SCALE_FACTOR;
> +        ret = IIO_VAL_FRACTIONAL;
> +        break;
		return IIO_VAL_FRACTIONAL;
	default:
		return -EINVAL;
and drop the return that follows.


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
> +        return -ENOMEM;
> +    }
> +
> +    i2c_set_clientdata(client, indio_dev);

Only if you need it, which I suspect you don't once you've dropped
remove as suggested below.

> +
> +    data = iio_priv(indio_dev);
> +    data->dev = dev;
When supporting only one bus type, we tend to use i2c_client instead
to get access to that and the dev.

> +
> +    indio_dev->dev.parent = dev;

The IIO core does that for you so no need to duplicate.

> +    indio_dev->name = client->name;
Hard code the name.  What exactly goes in client->name
isn't obvious for all types of firmware etc.
This just wants to be the part number so "sdp500"

> +    indio_dev->channels = sdp500_channels;
> +    indio_dev->info = &sdp500_info;
> +    indio_dev->modes = INDIO_DIRECT_MODE;
> +    indio_dev->num_channels = ARRAY_SIZE(sdp500_channels);
> +
> +    ret = sdp500_start_measurement(data, indio_dev);
> +    if (ret) {
> +        sdp500_err(indio_dev, "Failed to start measurement");
> +        return ret;
> +    }
You will want to read back one result here as datasheet notes
first one is garbage and we want to make sure we ate it!

> +
> +    ret = iio_device_register(indio_dev);
> +    if (ret < 0) {
> +        sdp500_err(indio_dev, "Failed to register indio_dev");

spaces rather than tabs in here it seems.
Run checkpatch.pl

Also, 
		return dev_error_probe() for any error messages
in probe or functions only called from probe.
 

> +        return ret;
> +    }
> +
> +    return 0;
> +}
> +
> +static const struct i2c_device_id sdp500_id[] = {
> +    { "sdp500" },
> +    { },
No comma after 'terminating' entries like this.

> +};
> +MODULE_DEVICE_TABLE(i2c, sdp500_id);
> +
> +static void sdp500_remove(struct i2c_client *client)
> +{
> +    struct iio_dev *indio_dev = dev_get_drvdata(&client->dev);
> +
> +    iio_device_unregister(indio_dev);

As Krysztof pointed out, devm version of register will mean you don't
need this.

J

