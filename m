Return-Path: <linux-kernel+bounces-164236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 038B18B7B39
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 224451C21C8A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AB2140E26;
	Tue, 30 Apr 2024 15:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7ap4PR8"
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D50152799;
	Tue, 30 Apr 2024 15:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714489883; cv=none; b=FWvR+v9glBHcaizCRm8SrtK/M5BMvNUIWmWgHkxM+9RBMITvDE3FfKRXcq38qARbvn0psU1h2ye0KllhWQKXX5I8FCnAnXh04wtxr5hauasiEvQRun/QomPnwcCLJPs45IlNK5aGmrDL/X+hoQNrr19tZxWEvf/WrUAEKrPR4nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714489883; c=relaxed/simple;
	bh=ZYJ4Kdmyy9Bj2FLmpJC2MBjj32MDW7XutVEHMfZA5Ho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MPXBt+TZChyBY+KrQD5OLhBzbrJqjiHmdVRXKALvuvtVHMclwaY1NuG6g95P8FKN4usOsKFKnVth4iOhuesuK7KGdMzMBDZVpRIXaghYWKrBnEEL3+F06kCn5lC27qjPLgPUJGnrpRszAEVfDNrd9Q+VB7DZDvWX1fJhNLoUiZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G7ap4PR8; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-41ba1ba55ebso30064965e9.1;
        Tue, 30 Apr 2024 08:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714489880; x=1715094680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r1QXlIa6RVHK/gyB7VpsJjXDv0UGdUixpU1dPTdCVNs=;
        b=G7ap4PR8T513yK/fnwz2usaSAojZSHrYm8OnSdjQ+eu0abbZrQUK8ajVddmLnDTG1t
         EjrzJmKh4XkNyWTG/21OQnohKh2kYenYjvszhCeyDTHbYx8uLSipoyYY1rnI1ILLboRf
         Xi7GYigZf2GVt39NcbNXTk52QEBaMGZKuikexalGl+t68kv/rabckRGwAW9BQX2N54Tc
         b7NBzGnr62UeuG3yq03h7FYHztxwqNp02i6ndIQ6DnzMRwy5qw6ceG0cUV1hJucCNkRO
         qqJWKm+F0lEtDujtoWuGWQa66KjNDBITF40EXxDswYKNV054xnHvbWA45cHTh+nLkPlC
         OlXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714489880; x=1715094680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r1QXlIa6RVHK/gyB7VpsJjXDv0UGdUixpU1dPTdCVNs=;
        b=YxqX2sQMASEEYVW5Lf2TJr6pzA08KQQDkHztLr99r9BGFnutZMyhUGTs2E3HE6gYbY
         kMg8XE5HrE4nJdglRlAWTUvAUfVxMkUKVVs6cIM18rmlFUfFal9NnT8s9kQMwkJBbUGy
         0/LRj3lm21SQkxW1YDqKXfCgIgqD2wiX9TEM5End4Y5NKTgGleYrlkCSvSXPXiqYrjXj
         XJ+hgvxw2CcLO0Jbc1PKqrzgIydW1LYfXG0oJW2SUiOlRYvRW5ebG4UkBZqzN2WCiySK
         Y6UEzPiWfpN0G8oFlPs4iOWKFG9eIhSwas+EiWjSV8+qL3H9TIOvha9+IIjTUVg3+NYF
         UuXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkyiSkYYtnpsS6bJonsevTZ36Xe616d6CR+IZkVBYN3R6wHm85xhlN57uGwPudS17ol0NereuuB/ujQnW71XR5xwU7iogvkKVEdPx7o65H0+kDgXqYCAMCbpMjnow4GO2msOBRkUEzpQ==
X-Gm-Message-State: AOJu0YyxCD0Mctx4c4X9SoPdqlP4UzKUDHrxlZt7a+YaFTsC/a1yqBZK
	gRMHrUeoc/ab5MHVFsTbcqZL3K18R0IPe/9mqc0zYZnlj6fiZDkblwLknrac8C0GztRKvGunz5K
	h3D1NN2bMyiLoKy4DiWNBSuiHs9T2mPQPr1o=
X-Google-Smtp-Source: AGHT+IH/+RC7ELmpx3U+lWweAKgqWIrMLes3YcGNL4w7+mTr6mNn8e52uTxZmsMTvmj+J5XJEOFwNtA/EZ+4xw3CCL8=
X-Received: by 2002:a05:600c:3d86:b0:41b:f534:2381 with SMTP id
 bi6-20020a05600c3d8600b0041bf5342381mr8094180wmb.25.1714489879532; Tue, 30
 Apr 2024 08:11:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADFWO8HOb4zY7rPsCxWe2nvrzd8FjVNw0k8=8s4yB7C_BwS0ig@mail.gmail.com>
 <20240116170337.00003a02@Huawei.com>
In-Reply-To: <20240116170337.00003a02@Huawei.com>
From: Petar Stoykov <pd.pstoykov@gmail.com>
Date: Tue, 30 Apr 2024 17:11:08 +0200
Message-ID: <CADFWO8EF0WxAV=k-ZAJ1McmaYv4SD5G+O4FhoMDsVQaRqe6sdg@mail.gmail.com>
Subject: Re: [PATCH 2/3] iio: pressure: Add driver for Sensirion SDP500
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Angel Iglesias <ang.iglesiasg@gmail.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 6:03=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Tue, 16 Jan 2024 16:24:56 +0100
> Petar Stoykov <pd.pstoykov@gmail.com> wrote:
>
> > Sensirion SDP500 is a digital differential pressure sensor. The sensor =
is
> > accessed over I2C.
> >
> > Signed-off-by: Petar Stoykov <pd.pstoykov@gmail.com>
> Hi Petar,
>
> Welcome to IIO.
>
> A few quick comments inline to add to Krzysztof's review
>
> Jonathan
>
> > diff --git a/drivers/iio/pressure/sdp500.c b/drivers/iio/pressure/sdp50=
0.c
> > new file mode 100644
> > index 000000000000..bc492ef3ef3e
> > --- /dev/null
> > +++ b/drivers/iio/pressure/sdp500.c
> > @@ -0,0 +1,201 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +#include <linux/i2c.h>
> > +#include <linux/iio/iio.h>
> > +
> > +#define SDP500_CRC8_POLYNOMIAL  0x31   // x8 + x5 + x4 + 1 (normalized=
 to 0x31)
> > +#define SDP500_READ_SIZE        3
> > +
> > +#define SDP500_SCALE_FACTOR 60
> > +
> > +#define SDP500_I2C_START_MEAS 0xF1
> > +
> > +#define sdp500_err(idev, fmt, ...)                    \
> > +    dev_err(idev->dev.parent, fmt "\n", ##__VA_ARGS__)
> > +
> > +#define sdp500_dbg(idev, fmt, ...)                    \
> > +    dev_dbg(idev->dev.parent, fmt "\n", ##__VA_ARGS__)
> > +
> > +#define sdp500_info(idev, fmt, ...)                    \
> > +    dev_info(idev->dev.parent, fmt "\n", ##__VA_ARGS__)
> Agree with Krzysztof - should never wrap these up.
>
> > +
> > +struct sdp500_data {
> > +    struct device *dev;
> > +};
> > +
> > +uint8_t calculate_crc8(uint8_t *data, uint32_t len, uint8_t poly)
> > +{
> > +    uint8_t    count =3D 0;
> > +    uint8_t    value =3D 0;
> > +    uint8_t    temp =3D 0;
> > +
> > +    while (len--) {
> > +        temp =3D *(data);
> > +        data++;
> > +        value ^=3D temp;
> > +        for (count =3D 0; count < BITS_PER_BYTE; count++) {
> > +            if (value & 0x80)
> > +                value =3D (value << 1) ^ poly;
> > +            else
> > +                value =3D value << 1;
> > +        }
> > +    }
> As pointed out in other review - should be no need to reinvent the wheel.
> > +
> > +    return value;
> > +}
> > +
> > +static int sdp500_xfer(struct sdp500_data *data, u8 *txbuf, size_t txs=
ize,
> > +              u8 *rxbuf, size_t rxsize, const struct iio_dev *indio_de=
v)
> > +{
> > +    struct i2c_client *client =3D to_i2c_client(data->dev);
> > +    int ret;
> > +
> > +    ret =3D i2c_master_send(client, txbuf, txsize);
> > +    if (ret < 0) {
> > +        sdp500_err(indio_dev, "Failed to send data");
> > +        return ret;
> > +    }
> > +    if (ret !=3D txsize) {
> > +        sdp500_err(indio_dev, "Data is sent wrongly");
> > +        return -EIO;
> > +    }
> > +
> > +    if (!rxsize)
> > +        return 0;
> > +
> > +    ret =3D i2c_master_recv(client, rxbuf, rxsize);
> > +    if (ret < 0) {
> > +        sdp500_err(indio_dev, "Failed to receive data");
> > +        return ret;
> > +    }
> > +    if (ret !=3D rxsize) {
> > +        sdp500_err(indio_dev, "Data is received wrongly");
> > +        return -EIO;
> > +    }
>
> This looks wrong from my reading of the datasheet and what
> the datasheet shows can be done with standard functions
> that handle these corner cases for you.
>
> > +
> > +    return 0;
> > +}
> > +
> > +static int sdp500_start_measurement(struct sdp500_data *data, const
> > struct iio_dev *indio_dev)
> > +{
> > +    u8 txbuf =3D SDP500_I2C_START_MEAS;
> > +
> > +    return sdp500_xfer(data, &txbuf, 1, NULL, 0, indio_dev);
>
> Just call i2c_master_send() here directly.
> However this looks like
> i2c_smbus_write_byte() ?
>
> > +}
> > +
> > +static const struct iio_chan_spec sdp500_channels[] =3D {
> > +    {
> > +        .type =3D IIO_PRESSURE,
> > +        .info_mask_separate =3D BIT(IIO_CHAN_INFO_PROCESSED),
>
> Looks like a simple linear scale.  Would be better to make scaling
> a userspace / consumer problem and provide IIO_CHAN_INFO_RAW
> and IIO_CHAN_INFO_SCALE.

I prefer returning the pressure directly because there is no other calculat=
ion
that the user of this driver can do. If they make the calculation different=
ly
then their pressure value would be wrong.

>
> > +    },
> > +};
> > +
> > +static int sdp500_read_raw(struct iio_dev *indio_dev,
> > +              struct iio_chan_spec const *chan,
> > +              int *val, int *val2, long mask)
> > +{
> > +    int ret =3D -EINVAL;
>
> Rarely a good idea. Better to return this where it is
> clear why this value makes sense.
> > +    u8 rxbuf[SDP500_READ_SIZE];
> > +    u8 rec_crc, calculated_crc;
> > +    s16 dec_value;
> > +    struct sdp500_data *data =3D iio_priv(indio_dev);
> > +
> > +    switch (mask) {
> > +    case IIO_CHAN_INFO_PROCESSED:
> > +        sdp500_xfer(data, NULL, 0, rxbuf, SDP500_READ_SIZE, indio_dev)=
;
>
> A zero size send is unusual. I'm not really seeing how it lines
> up with the datasheet either.
> The sequence shown there looks more like an
> i2c_smbus_read_i2c_block_data() call as it shows it happening
> as one transaction (figure in 4.1 doesn't have a NA after the
> command is sent).
> https://sensirion.com/media/documents/63859DD0/6166CF0E/Sensirion_Differe=
ntial_Pressure_Datasheet_SDP600Series.pdf
> (also note that this appears to say the sdp600 is
> covered as well)
>
>
>
> > +        rec_crc =3D rxbuf[2];
> > +        calculated_crc =3D calculate_crc8(rxbuf, SDP500_READ_SIZE - 1,
> > +                        SDP500_CRC8_POLYNOMIAL);
> > +        if (rec_crc !=3D calculated_crc) {
> > +            sdp500_err(indio_dev, "calculated crc =3D 0x%.2X but
> > received 0x%.2X",
> > +                calculated_crc, rec_crc);
> > +            return -EIO;
> > +        }
> > +
> > +        dec_value =3D ((rxbuf[0] << 8) & 0xFF00) | rxbuf[1];
>
> Look like a get_unaligned_be16() call opencoded - use that instead
> of this.
>
>
> > +        sdp500_dbg(indio_dev, "dec value =3D %d", dec_value);
> > +
> > +        *val =3D dec_value;
> > +        *val2 =3D SDP500_SCALE_FACTOR;
> > +        ret =3D IIO_VAL_FRACTIONAL;
> > +        break;
>                 return IIO_VAL_FRACTIONAL;
>         default:
>                 return -EINVAL;
> and drop the return that follows.
>
>
> > +    }
> > +    return ret;
> > +}
> > +
> > +static const struct iio_info sdp500_info =3D {
> > +    .read_raw =3D &sdp500_read_raw,
> > +};
> > +
> > +static int sdp500_probe(struct i2c_client *client)
> > +{
> > +    struct iio_dev *indio_dev;
> > +    struct sdp500_data *data;
> > +    struct device *dev =3D &client->dev;
> > +    int ret;
> > +
> > +    indio_dev =3D devm_iio_device_alloc(dev, sizeof(*data));
> > +    if (!indio_dev) {
> > +        dev_err(dev->parent, "Failed to allocate iio device\n");
> > +        return -ENOMEM;
> > +    }
> > +
> > +    i2c_set_clientdata(client, indio_dev);
>
> Only if you need it, which I suspect you don't once you've dropped
> remove as suggested below.
>
> > +
> > +    data =3D iio_priv(indio_dev);
> > +    data->dev =3D dev;
> When supporting only one bus type, we tend to use i2c_client instead
> to get access to that and the dev.
>
> > +
> > +    indio_dev->dev.parent =3D dev;
>
> The IIO core does that for you so no need to duplicate.
>
> > +    indio_dev->name =3D client->name;
> Hard code the name.  What exactly goes in client->name
> isn't obvious for all types of firmware etc.
> This just wants to be the part number so "sdp500"
>
> > +    indio_dev->channels =3D sdp500_channels;
> > +    indio_dev->info =3D &sdp500_info;
> > +    indio_dev->modes =3D INDIO_DIRECT_MODE;
> > +    indio_dev->num_channels =3D ARRAY_SIZE(sdp500_channels);
> > +
> > +    ret =3D sdp500_start_measurement(data, indio_dev);
> > +    if (ret) {
> > +        sdp500_err(indio_dev, "Failed to start measurement");
> > +        return ret;
> > +    }
> You will want to read back one result here as datasheet notes
> first one is garbage and we want to make sure we ate it!
>
> > +
> > +    ret =3D iio_device_register(indio_dev);
> > +    if (ret < 0) {
> > +        sdp500_err(indio_dev, "Failed to register indio_dev");
>
> spaces rather than tabs in here it seems.
> Run checkpatch.pl

I did that before sending the patches and there were no issues.
I still have the patch files and there are no spaces. Who knows what happen=
ed.

>
> Also,
>                 return dev_error_probe() for any error messages
> in probe or functions only called from probe.
>
>
> > +        return ret;
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +static const struct i2c_device_id sdp500_id[] =3D {
> > +    { "sdp500" },
> > +    { },
> No comma after 'terminating' entries like this.
>
> > +};
> > +MODULE_DEVICE_TABLE(i2c, sdp500_id);
> > +
> > +static void sdp500_remove(struct i2c_client *client)
> > +{
> > +    struct iio_dev *indio_dev =3D dev_get_drvdata(&client->dev);
> > +
> > +    iio_device_unregister(indio_dev);
>
> As Krysztof pointed out, devm version of register will mean you don't
> need this.
>
> J

Sorry for the slow reply, I finally found some time to continue this task.
Thank you for the clear review. I didn't know many of the existing function=
s
that you suggested. I updated the driver with them and it looks nicer now.

