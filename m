Return-Path: <linux-kernel+bounces-161456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 538018B4C34
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 16:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9ED6B21254
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 14:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C04641ABE;
	Sun, 28 Apr 2024 14:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uuJVXrFP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B1E1E89A;
	Sun, 28 Apr 2024 14:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714315535; cv=none; b=BLE9R72WegH6sGKLHyja/qByQjGf3GU+BXqjpoB/b6RrDeiscsSjkBh80giRZbpktL517PugowyS7XG1f5tNcPZLDoIjEGxUOibfmUgldFz/rjsUG3PS/vwmOICB3Wu4qwdUzDQlyZkPwzJ+n24T4WbPChpuZpX8rP6dOTWBEAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714315535; c=relaxed/simple;
	bh=g+gN/2Udrk5e1CLu+RPJHpqgPVEeynHhSphU9+n/zzA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kpo05emMy65vnrzoKAA/ynazv6iYIZVmF4Ta43zPA35Q0dwvlfg3MjXkogfTxW66D2vmOeYLl6sgnP/KqzNMvBMWKj9y3/R+V+bzJw85raX021LEtZHzb7issWtwdgtWfnJd6PrSAhDmhXB4jsYHNIHBbEBu7kswDxpmlBYKRT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uuJVXrFP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1BE5C113CC;
	Sun, 28 Apr 2024 14:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714315534;
	bh=g+gN/2Udrk5e1CLu+RPJHpqgPVEeynHhSphU9+n/zzA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uuJVXrFPEeLn4oNeeNtJkxhyKl/PN5kyuLxDIDrvtBitdsVHlZAFDLPfogFrTE+mp
	 pbFYvLaHjtiSuNO6B8sTsq5Vn8czMZujyqkhk7A+pCutwhNs3xPwfiH4eH8fLQDArw
	 tQQD1A95U2s6RrUvQOTEI4RujR3GBzH7JdQAmXFfICj6AnF9nyfMGTX/AGRz1qCRKX
	 ls9NGgDWe1FVQCW6/rbvMhA6/FAkT8xnBqZv8cZSHOQZ0HQfb6ePnWOyHeUSpNt8Nt
	 g79ZADJLaJYH9P+A1CiAYwivhBTAV9dkOsJQ2XME7jZdNI+5oMHPZ6u6x/01uLun4c
	 Nkv3jgxMDhU+g==
Date: Sun, 28 Apr 2024 15:45:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, robh@kernel.org, nuno.sa@analog.com
Subject: Re: [PATCH 7/7] drivers: iio: imu: Add support for adis1657x family
Message-ID: <20240428154523.17b27fa8@jic23-huawei>
In-Reply-To: <20240426135339.185602-8-ramona.bolboaca13@gmail.com>
References: <20240426135339.185602-1-ramona.bolboaca13@gmail.com>
	<20240426135339.185602-8-ramona.bolboaca13@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Apr 2024 16:53:39 +0300
Ramona Gradinariu <ramona.bolboaca13@gmail.com> wrote:

> Add support for ADIS1657X family devices in already exiting ADIS16475
> driver.
> 
> Signed-off-by: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
Hi Ramona,

Various comments inline,

Thanks,

Jonathan

> ---
>  drivers/iio/imu/adis16475.c | 536 +++++++++++++++++++++++++++++++++---
>  1 file changed, 499 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
> index 7cfef553f298..c759ec456258 100644
> --- a/drivers/iio/imu/adis16475.c
> +++ b/drivers/iio/imu/adis16475.c
> @@ -14,6 +14,7 @@
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/imu/adis.h>
> +#include <linux/iio/sysfs.h>
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/irq.h>
>  #include <linux/lcm.h>
> @@ -52,6 +53,8 @@
>  				FIELD_PREP(ADIS16475_MSG_CTRL_DR_POL_MASK, x)
>  #define ADIS16475_SYNC_MODE_MASK	GENMASK(4, 2)
>  #define ADIS16475_SYNC_MODE(x)		FIELD_PREP(ADIS16475_SYNC_MODE_MASK, x)
> +#define ADIS16475_SYNC_4KHZ_MASK	BIT(11)
> +#define ADIS16475_SYNC_4KHZ(x)		FIELD_PREP(ADIS16475_SYNC_4KHZ_MASK, x)
When a field doesn't exist for the original device, it's fine to name it after the
first part where it does.

#define ADIS16575_SYNC_4KHZ() etc.


>  #define ADIS16475_REG_UP_SCALE		0x62
>  #define ADIS16475_REG_DEC_RATE		0x64
>  #define ADIS16475_REG_GLOB_CMD		0x68
> @@ -66,14 +69,31 @@
>  #define ADIS16500_BURST32(x)		FIELD_PREP(ADIS16500_BURST32_MASK, x)
>  /* number of data elements in burst mode */
>  #define ADIS16475_BURST32_MAX_DATA	32
> +#define ADIS16575_BURST32_MAX_DATA	34

As below, I wonder if this is better referred to as with and without the timestamp
rather than by part number?

>  #define ADIS16475_BURST_MAX_DATA	20
>  #define ADIS16475_MAX_SCAN_DATA		20
>  /* spi max speed in brust mode */
>  #define ADIS16475_BURST_MAX_SPEED	1000000
> +#define ADIS16575_BURST_MAX_SPEED	8000000
>  #define ADIS16475_LSB_DEC_MASK		0
>  #define ADIS16475_LSB_FIR_MASK		1
>  #define ADIS16500_BURST_DATA_SEL_0_CHN_MASK	GENMASK(5, 0)
>  #define ADIS16500_BURST_DATA_SEL_1_CHN_MASK	GENMASK(12, 7)
> +#define ADIS16475_MAX_FIFO_WM		511
> +#define ADIS16475_REG_FIFO_CTRL		0x5A

Name these after first part to be added to the driver that supports this register.

> +#define ADIS16475_WM_LVL_MASK		GENMASK(15, 4)
> +#define ADIS16475_WM_LVL(x)		FIELD_PREP(ADIS16475_WM_LVL_MASK, x)
> +#define ADIS16475_WM_POL_MASK		BIT(3)
> +#define ADIS16475_WM_POL(x)		FIELD_PREP(ADIS16475_WM_POL_MASK, x)
> +#define ADIS16475_WM_EN_MASK		BIT(2)
> +#define ADIS16475_WM_EN(x)		FIELD_PREP(ADIS16475_WM_EN_MASK, x)
> +#define ADIS16475_OVERFLOW_MASK		BIT(1)
> +#define ADIS16475_STOP_ENQUEUE		FIELD_PREP(ADIS16475_OVERFLOW_MASK, 0)
> +#define ADIS16475_OVERWRITE_OLDEST	FIELD_PREP(ADIS16475_OVERFLOW_MASK, 1)
> +#define ADIS16475_FIFO_EN_MASK		BIT(0)
> +#define ADIS16475_FIFO_EN(x)		FIELD_PREP(ADIS16475_FIFO_EN_MASK, x)
> +#define ADIS16475_FIFO_FLUSH_CMD	BIT(5)
> +#define ADIS16475_REG_FIFO_CNT		0x3C


..

> @@ -437,6 +467,130 @@ static int adis16475_set_filter(struct adis16475 *st, const u32 filter)
>  	return 0;
>  }
>  
> +static ssize_t adis16475_get_fifo_enabled(struct device *dev,
> +					  struct device_attribute *attr,
> +					  char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct adis16475 *st = iio_priv(indio_dev);
> +	int ret;
> +	u16 val;
> +
> +	ret = adis_read_reg_16(&st->adis, ADIS16475_REG_FIFO_CTRL, &val);
> +	if (ret)
> +		return ret;
> +	val = FIELD_GET(ADIS16475_FIFO_EN_MASK, val);
> +
> +	return sysfs_emit(buf, "%d\n", val);

As below, might as well put the FIELD_GET() in the sysfs_emit rather than
writing the local parameter.

> +}
> +
> +static ssize_t adis16475_get_fifo_watermark(struct device *dev,
> +					    struct device_attribute *attr,
> +					    char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct adis16475 *st = iio_priv(indio_dev);
> +
Unusual to have a line break here. I'd drop it.

> +	int ret;
> +	u16 val;
> +
> +	ret = adis_read_reg_16(&st->adis, ADIS16475_REG_FIFO_CTRL, &val);
> +	if (ret)
> +		return ret;
> +	val = FIELD_GET(ADIS16475_WM_LVL_MASK, val) + 1;

Might as well put this maths inline in the sysfs_emit()

> +
> +	return sysfs_emit(buf, "%d\n", val);
> +}
> +
> +static ssize_t hwfifo_watermark_min_show(struct device *dev,
> +					 struct device_attribute *attr,
> +					 char *buf)
> +{
> +	return sysfs_emit(buf, "%s\n", "1");
> +}
> +
> +static ssize_t hwfifo_watermark_max_show(struct device *dev,
> +					 struct device_attribute *attr,
> +					 char *buf)
> +{
> +	return sysfs_emit(buf, "%s\n", __stringify(ADIS16475_MAX_FIFO_WM));
> +}
> +
> +static IIO_DEVICE_ATTR_RO(hwfifo_watermark_min, 0);
> +static IIO_DEVICE_ATTR_RO(hwfifo_watermark_max, 0);
> +static IIO_DEVICE_ATTR(hwfifo_watermark, 0444,
> +		       adis16475_get_fifo_watermark, NULL, 0);
> +static IIO_DEVICE_ATTR(hwfifo_enabled, 0444,
> +		       adis16475_get_fifo_enabled, NULL, 0);
> +
> +static const struct attribute *adis16475_fifo_attributes[] = {
> +	&iio_dev_attr_hwfifo_watermark_min.dev_attr.attr,
> +	&iio_dev_attr_hwfifo_watermark_max.dev_attr.attr,
> +	&iio_dev_attr_hwfifo_watermark.dev_attr.attr,
> +	&iio_dev_attr_hwfifo_enabled.dev_attr.attr,
> +	NULL,
No comma needed on 'null terminators' as we must never add anything after them.

> +};
> +
> +static int adis16475_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct adis16475 *st = iio_priv(indio_dev);
> +	struct adis *adis = &st->adis;
> +	u16 val;
> +
> +	val = ADIS16475_FIFO_EN(1);
> +	return adis_update_bits(adis, ADIS16475_REG_FIFO_CTRL, ADIS16475_FIFO_EN_MASK, val);

Put the value in val inline, that local variable isn't helping readability.

> +}
> +
> +static int adis16475_buffer_postdisable(struct iio_dev *indio_dev)
> +{
> +	struct adis16475 *st = iio_priv(indio_dev);
> +	struct adis *adis = &st->adis;
> +	int ret;
> +	u16 val;
> +
> +	adis_dev_lock(&st->adis);
> +
> +	val = ADIS16475_FIFO_EN(0);
> +	ret = __adis_update_bits(adis, ADIS16475_REG_FIFO_CTRL, ADIS16475_FIFO_EN_MASK, val);

As above, val isn't adding much.



> +	if (ret)
> +		goto unlock;
> +
> +	ret = __adis_write_reg_16(adis, ADIS16475_REG_GLOB_CMD,
> +				  ADIS16475_FIFO_FLUSH_CMD);
> +
> +unlock:
> +	adis_dev_unlock(&st->adis);
> +	return ret;
> +}
> +
> +static const struct iio_buffer_setup_ops adis16475_buffer_ops = {
> +	.postenable = adis16475_buffer_postenable,
> +	.postdisable = adis16475_buffer_postdisable,
> +};
> +
> +static int adis16475_set_watermark(struct iio_dev *indio_dev, unsigned int val)
> +{
> +	struct adis16475 *st  = iio_priv(indio_dev);
> +	int ret;
> +	u16 wm_lvl;
> +
> +	adis_dev_lock(&st->adis);
> +
> +	if (val > ADIS16475_MAX_FIFO_WM)
> +		val = ADIS16475_MAX_FIFO_WM;
	val = min(val, ADIS16475_MAX_FIFO_WM);

> +
> +	wm_lvl = ADIS16475_WM_LVL(val - 1);
> +	ret = __adis_update_bits(&st->adis, ADIS16475_REG_FIFO_CTRL, ADIS16475_WM_LVL_MASK, wm_lvl);
> +	if (ret)
> +		goto unlock;
> +
> +	st->fifo_watermark = val;
> +
> +unlock:
> +	adis_dev_unlock(&st->adis);
> +	return ret;
> +}
> +

>  
>  static int adis16475_update_scan_mode(struct iio_dev *indio_dev,
> @@ -1188,17 +1498,14 @@ static const struct iio_info adis16475_info = {
>  	.write_raw = &adis16475_write_raw,
>  	.update_scan_mode = adis16475_update_scan_mode,
>  	.debugfs_reg_access = adis_debugfs_reg_access,
> +	.hwfifo_set_watermark = adis16475_set_watermark,

Odd to have this for devices that don't have a watermark.  I would split
this into separate info structures to allow with fifo and without fifo.
It may make no difference in practice, but it will maintain clean separation
of the fifo support from non fifo devices.

>  };
>  
>  static bool adis16475_validate_crc(const u8 *buffer, u16 crc,
> -				   const bool burst32)
> +				   u16 burst_size, u16 start_idx)
>  {
>  	int i;
> -	/* extra 6 elements for low gyro and accel */
> -	const u16 sz = burst32 ? ADIS16475_BURST32_MAX_DATA :
> -		ADIS16475_BURST_MAX_DATA;
> -
> -	for (i = 0; i < sz - 2; i++)
> +	for (i = start_idx; i < burst_size - 2; i++)
>  		crc -= buffer[i];
>  
>  	return crc == 0;
> @@ -1226,8 +1533,11 @@ static void adis16475_burst32_check(struct adis16475 *st)
>  		 * In 32-bit mode we need extra 2 bytes for all gyro
>  		 * and accel channels.
>  		 */
> -		adis->burst_extra_len = 6 * sizeof(u16);
> -		adis->xfer[1].len += 6 * sizeof(u16);
> +		adis->burst_extra_len = (6 + !!(st->info->flags & ADIS16475_HAS_TIMESTAMP32)) *
> +					sizeof(u16);
> +		adis->xfer[1].len += (6 + !!(st->info->flags & ADIS16475_HAS_TIMESTAMP32)) *
> +				     sizeof(u16);
> +
As below, the !! is hard to read so better to have an if / else block here.

However, that second value is += adis->burst_extra_len so use that to avoid duplication.
Or set a local variable and use that to set both up.

>  		dev_dbg(&adis->spi->dev, "Enable burst32 mode, xfer:%d",
>  			adis->xfer[1].len);
>  
> @@ -1243,7 +1553,8 @@ static void adis16475_burst32_check(struct adis16475 *st)
>  
>  		/* Remove the extra bits */
>  		adis->burst_extra_len = 0;
> -		adis->xfer[1].len -= 6 * sizeof(u16);
> +		adis->xfer[1].len -= (6 + !!(st->info->flags & ADIS16475_HAS_TIMESTAMP32)) *
> +				     sizeof(u16);

I'd write this one as an if / else as the !! is hard to read.

>  		dev_dbg(&adis->spi->dev, "Disable burst32 mode, xfer:%d\n",
>  			adis->xfer[1].len);
>  	}
> @@ -1258,20 +1569,31 @@ static int adis16475_push_single_sample(struct iio_poll_func *pf)
>  	__be16 *buffer;
>  	u16 crc;
>  	bool valid;
> +	u8 crc_offset = 9;
> +	u16 burst_size = ADIS16475_BURST_MAX_DATA;
> +	u16 start_idx = (st->info->flags & ADIS16475_HAS_TIMESTAMP32) ? 2 : 0;
> +
>  	/* offset until the first element after gyro and accel */
>  	const u8 offset = st->burst32 ? 13 : 7;
>  
> +	if (st->burst32) {
> +		crc_offset = (st->info->flags & ADIS16475_HAS_TIMESTAMP32) ? 16 : 15;
> +		burst_size = (st->info->flags & ADIS16475_HAS_TIMESTAMP32) ?
> +			     ADIS16575_BURST32_MAX_DATA : ADIS16475_BURST32_MAX_DATA;

I'd rename these to reflect the flag.
ADIS16475_BURST32_MAX_DATA_NO_TS32  vs ADIS16475_BURST32_DATA_TS32
or something like that.  Picking two random part numbers won't scale long term.

> +	}
> +
>  	ret = spi_sync(adis->spi, &adis->msg);
>  	if (ret)
> -		goto check_burst32;
> +		return ret;
>  
>  	buffer = adis->buffer;
>  
> -	crc = be16_to_cpu(buffer[offset + 2]);
> -	valid = adis16475_validate_crc(adis->buffer, crc, st->burst32);
> +	crc = be16_to_cpu(buffer[crc_offset]);
> +	valid = adis16475_validate_crc(adis->buffer, crc, burst_size, start_idx);
> +

No blank line here - !valid check is closely coupled to the block above so reflect
that by not having a blank line before it.

>  	if (!valid) {
>  		dev_err(&adis->spi->dev, "Invalid crc\n");
> -		goto check_burst32;
> +		return ret;
>  	}
>  
>  	for_each_set_bit(bit, indio_dev->active_scan_mask,
> @@ -1332,22 +1654,111 @@ static int adis16475_push_single_sample(struct iio_poll_func *pf)
>  	}
>  
>  	iio_push_to_buffers_with_timestamp(indio_dev, st->data, pf->timestamp);
> -check_burst32:
> +
> +	return 0;
> +}
> +
> +static irqreturn_t adis16475_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct adis16475 *st = iio_priv(indio_dev);
> +
> +	adis16475_push_single_sample(pf);
>  	/*
>  	 * We only check the burst mode at the end of the current capture since
>  	 * it takes a full data ready cycle for the device to update the burst
>  	 * array.
>  	 */
>  	adis16475_burst32_check(st);
> -	return ret;
> +
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
>  }
>  
> -static irqreturn_t adis16475_trigger_handler(int irq, void *p)
> +static int adis16575_custom_burst_read(struct iio_poll_func *pf, u8 burst_req)
> +{
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct adis16475 *st = iio_priv(indio_dev);
> +	struct adis *adis = &st->adis;
> +	unsigned int burst_length, burst_max_length;
> +	u8 *tx;
> +
> +	burst_length = adis->data->burst_len + adis->burst_extra_len;
> +
Could be simplified as this is only used if !burst_max_len.

	if (adis->data->burst_max_len)
		burst_max_length = adis->data->burst_max_lent;
	else	
		burst_max_length = adis->data->burst_len + adis->burst_extra_len;


	
> +	if (adis->data->burst_max_len)
> +		burst_max_length = adis->data->burst_max_len;
> +	else
> +		burst_max_length = burst_length;
> +
> +	tx = adis->buffer + burst_max_length;
> +	tx[0] = ADIS_READ_REG(burst_req);
> +
> +	if (burst_req)

If !burst_req does the rest of this do anything at all?
If so flip the logic as
	if (!burst_req)
		return adis16475_push_single_sample(pf);

	the rest...
	return spi_sync(adis->spi, &adis->msg);

		

> +		return spi_sync(adis->spi, &adis->msg);
> +
> +	return adis16475_push_single_sample(pf);
> +}
> +
> +/*
> + * This handler is meant to be used for devices which support burst readings
> + * from FIFO (namely devices from adis1657x family).
> + * In order to pop the FIFO the 0x68 0x00 FIFO pop burst request has to be sent.
> + * If the previous device command was not a FIFO pop burst request, the FIFO pop
> + * burst request will simply pop the FIFO without returning valid data.
> + * For the nth consecutive burst request, the
> + * device will send the data popped with the (n-1)th consecutive burst request.
> + * In order to read the data which was popped previously, without popping the FIFO,
> + * the 0x00 0x00 burst request has to be sent.
> + * If after a 0x68 0x00 FIFO pop burst request, there is any other device access
> + * different from a 0x68 0x00 or a 0x00 0x00 burst request, the FIFO data popped
> + * previously will be lost.
> + */
> +static irqreturn_t adis16475_trigger_handler_with_fifo(int irq, void *p)
>  {
>  	struct iio_poll_func *pf = p;
>  	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct adis16475 *st = iio_priv(indio_dev);
> +	struct adis *adis = &st->adis;
> +	int ret;
> +	u16 fifo_cnt, i;
>  
> -	adis16475_push_single_sample(pf);
> +	adis_dev_lock(&st->adis);
> +
> +	ret = __adis_read_reg_16(adis, ADIS16475_REG_FIFO_CNT, &fifo_cnt);
> +	if (ret || fifo_cnt < 2)
> +		goto unlock;
I would break these conditions and add a comment on why fifo_cnt < 2 is
a reason to just return 0;

> +
> +	if (fifo_cnt > st->fifo_watermark)
> +		fifo_cnt = st->fifo_watermark;

fifo_cnt = min(fifo_cnt, st->fifo_watermark);

This confuses me though as normally overreading after a fifo watermark is
both safe and the right thing to do (as reduces chance of overflow etc).
If we need to clamp to the watermark for some reason, add a comment.

> +
> +	/*
> +	 * First burst request - FIFO pop: popped data will be returned in the
> +	 * next burst request.
> +	 */
> +	ret = adis16575_custom_burst_read(pf, adis->data->burst_reg_cmd);
> +	if (ret)
> +		goto unlock;
> +
> +	for (i = 0; i < fifo_cnt - 1; i++) {
> +		ret = adis16475_push_single_sample(pf);
> +		if (ret)
> +			goto unlock;
> +	}
> +
> +	/* FIFO read without popping */
> +	ret = adis16575_custom_burst_read(pf, 0);
> +	if (ret)
> +		goto unlock;
> +
> +unlock:
> +	/*
> +	 * We only check the burst mode at the end of the current capture since
> +	 * reading data from registers will impact the FIFO reading.
> +	 */
> +	adis16475_burst32_check(st);
> +	adis_dev_unlock(&st->adis);
>  	iio_trigger_notify_done(indio_dev->trig);
>  
>  	return IRQ_HANDLED;
> @@ -1359,6 +1770,17 @@ static int adis16475_config_sync_mode(struct adis16475 *st)
>  	struct device *dev = &st->adis.spi->dev;
>  	const struct adis16475_sync *sync;
>  	u32 sync_mode;
> +	u16 max_sample_rate =  st->info->int_clk + 100;

This changes seems unconnected to the rest.  Pull it out as a precursor patch where
you can explain why this is the right value etc.

> +	u16 val;
> +
> +	/* if available, enable 4khz internal clock */
> +	if (st->info->int_clk == 4000) {
> +		val = ADIS16475_SYNC_4KHZ(1);

Use the value inline rather than adding a local variable write.

> +		ret = __adis_update_bits(&st->adis, ADIS16475_REG_MSG_CTRL,
> +					 ADIS16475_SYNC_4KHZ_MASK, val);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	/* default to internal clk */
>  	st->clk_freq = st->info->int_clk * 1000;
> @@ -1398,10 +1820,9 @@ static int adis16475_config_sync_mode(struct adis16475 *st)
>  			/*
>  			 * In sync scaled mode, the IMU sample rate is the clk_freq * sync_scale.
>  			 * Hence, default the IMU sample rate to the highest multiple of the input
> -			 * clock lower than the IMU max sample rate. The optimal range is
> -			 * 1900-2100 sps...
> +			 * clock lower than the IMU max sample rate.
>  			 */
> -			up_scale = 2100 / st->clk_freq;
> +			up_scale = max_sample_rate / st->clk_freq;

>  
>  			ret = __adis_write_reg_16(&st->adis,
>  						  ADIS16475_REG_UP_SCALE,
> @@ -1467,7 +1888,23 @@ static int adis16475_config_irq_pin(struct adis16475 *st)
>  	 */
>  	usleep_range(250, 260);
>  
> -	return 0;
> +	/*
> +	 * If the device has FIFO support, configure the watermark polarity
> +	 * pin as well.

The pin is for polarity or the polarity is for the watermark signalling on that
pin?  I'm not seeing a datasheet yet for these parts so I couldn't check.

> +	 */
> +	if (st->info->flags & ADIS16475_HAS_FIFO) {
> +		val = ADIS16475_WM_POL(polarity);
> +		ret = adis_update_bits(&st->adis, ADIS16475_REG_FIFO_CTRL,
> +				       ADIS16475_WM_POL_MASK, val);
> +		if (ret)
> +			return ret;
> +
> +		/* Enable watermark interrupt pin. */
> +		val = ADIS16475_WM_EN(1);
> +		ret = adis_update_bits(&st->adis, ADIS16475_REG_FIFO_CTRL, ADIS16475_WM_EN_MASK, val);

Similar to below, what does val give us?  Just use the values
inline.

> +	}
> +
> +	return ret;
For general code extensibility in the long run I'd prefer you kept the form as

		ret = adis_update...
		if (ret)
			return ret;
	}
	
	return 0;


>  }
>  
>  
> @@ -1509,8 +1946,21 @@ static int adis16475_probe(struct spi_device *spi)
>  	if (ret)
>  		return ret;
>  
> -	ret = devm_adis_setup_buffer_and_trigger(&st->adis, indio_dev,
> -						 adis16475_trigger_handler);
> +	if (st->info->flags & ADIS16475_HAS_FIFO) {
> +		ret = devm_adis_setup_buffer_and_trigger_with_attrs(&st->adis, indio_dev,
> +								    adis16475_trigger_handler_with_fifo,
> +								    &adis16475_buffer_ops,
> +								    adis16475_fifo_attributes);
> +		if (ret)
> +			return ret;
> +		/* Update overflow behavior to always overwrite the oldest sample. */
> +		u16 val = ADIS16475_OVERWRITE_OLDEST;

Mostly we still don't do inline variable declaration.  So move this to top of scope.
Or better yet, just use the value inline.

> +
> +		ret = adis_update_bits(&st->adis, ADIS16475_REG_FIFO_CTRL, ADIS16475_OVERFLOW_MASK, val);
> +	} else {
> +		ret = devm_adis_setup_buffer_and_trigger(&st->adis, indio_dev,
> +							 adis16475_trigger_handler);
> +	}
>  	if (ret)
>  		return ret;
>  



