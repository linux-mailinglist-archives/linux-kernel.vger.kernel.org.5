Return-Path: <linux-kernel+bounces-52106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA6C84942B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 509601C22F7E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 07:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014A2BE7F;
	Mon,  5 Feb 2024 07:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="it7omR+r"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613B110A11;
	Mon,  5 Feb 2024 07:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707116669; cv=none; b=PiN1OTHYio8j200b2Nr3Cz7vgqibMgyZoFUm3DZtz70RyxYJPSsv4a8RLuhkEJbmCLkXKOH+fg73IcHOT8cIttnxx6xyNTxQTfdsyONSOHhLpgi/9Zf8FSD2WEiAdMHEuWiGmntK1ECdKWnMsQwHk6Z4s37rwdEcpHiOg/OyDek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707116669; c=relaxed/simple;
	bh=nigqDW1Y4pVV2HDFMERkTFL9NaDQ0zl9isUXagQXT+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CCZYI3p8z7eBAN/0lkxYNDW9i4CQKparGTb1g3S+kt87aR82Gkm862K6nV+xNAYlwR+xE2cZ9mC86GU5k5nbS7r2RP9hvuLDJqocEVQdT1boymD3UPVOyAJIYgsqovW8/GvrhcyLyO0v8c462yle6fmgfju55sUilphuWi86+KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=it7omR+r; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so544328466b.0;
        Sun, 04 Feb 2024 23:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707116664; x=1707721464; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AMxzOo5yMKOuxvj8IMQwn254J71dHsESJ/Rvv21GER4=;
        b=it7omR+rOkjsFv0ZBJk8uatBh/SHtT+pCMMK8vc43QOCt1ea1XVAjva9BmYWk14KdV
         23w2YIEWc8XxdUU48AnBJJs9a7q2a9rcmZQHPrLbIb1jwGLBPag1Pqa5iEZjTmiZ6dZs
         1dgZzphq0UeiwBQTeNiTim7/cRFzLZUmIiYznJBuh/x98aH/F6KUwV6gIRwyAMW4gQ9i
         5JCTpxvMjIL350hpBGY8rhmIKmi2liqGbidbHMB/eOwlUHBI4dBCunU37KmSgYCK7Qck
         sp2W3d/THvk/3whwGYo6kCv5UfcTXOXgSYf9vKAOUOrhTqQ1HMUjE5TeLXiTe3Fvgjiy
         rwjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707116664; x=1707721464;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AMxzOo5yMKOuxvj8IMQwn254J71dHsESJ/Rvv21GER4=;
        b=dFi3cM5Etd88TN0IOevH//BRVvbE4F0HD5YyaiQp+smgkFc65qsjVv/bCcAE6pBF0v
         66ymZC7RG4WxG3a34wB9HwKF5v5n/hrKVpJKutoMQRIJbdNhwqvFH2T20hphWng/C1Zm
         Qq+lvUaKWEvDEvP2SFfeGqDuWLnNpefwXB73SJRjZn5B+UBFH3I/kr5n3+kswZOS1s0v
         fELiTnCw4fRahlFQG6KvTqzPjx0nyb1bmB9yrV5TsRobOCc06fuffoOc2rtbx4NxOcuy
         2ME/1nHlxKdoPwqizn3V5dbbKLFseWkOjVE3GkTk+8UXseWXuodlQmW2+U0QcJIEBkxQ
         72Xw==
X-Gm-Message-State: AOJu0YwVdkCIi2cL2geeYtFHvmdfivtLrRj9+in+Wz+kzCEuQQgmtS/O
	Ia22s/F1IZn+ECAdTbr8m3iYba4Bw2gBV75wTyuSuInTuU+YBxk4
X-Google-Smtp-Source: AGHT+IExW9smKhY5jgIfDK7Bj7T4DH3gnhe1Ulo6AL21oEA4RDdBVFwEVKa5/Ar9dnsEKv30B2lWQA==
X-Received: by 2002:a17:906:6b92:b0:a37:7f72:574c with SMTP id l18-20020a1709066b9200b00a377f72574cmr2590046ejr.68.1707116663924;
        Sun, 04 Feb 2024 23:04:23 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW1kAKDajHLogI64prabP75Szz710xP5Tcqmu+tuQnWuTaNmCfyayjtC7/R3YxFTDHMOtudXO1X7GzGQzqKdv0qL6aRoPhvgK11aiNgMj1trDASyLIo0MdalpCK27WYTkIryt0sbarzpz/y8Rl7t2oTR1SC4prF0jh1Wcv7uRLpZbGVnFmjqrlRFtk=
Received: from debian ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id cu4-20020a170906ba8400b00a3550c56127sm3982574ejd.9.2024.02.04.23.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 23:04:23 -0800 (PST)
Date: Mon, 5 Feb 2024 08:04:21 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Li peiyu <579lpy@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: humidity: hdc3020: add threshold events support
Message-ID: <20240205070421.GA2264419@debian>
References: <20240204103710.19212-1-dima.fedrau@gmail.com>
 <20240204144347.7f0eb822@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240204144347.7f0eb822@jic23-huawei>

Am Sun, Feb 04, 2024 at 02:43:47PM +0000 schrieb Jonathan Cameron:
> On Sun,  4 Feb 2024 11:37:10 +0100
> Dimitri Fedrau <dima.fedrau@gmail.com> wrote:
> 
> > Add threshold events support for temperature and relative humidity. To
> > enable them the higher and lower threshold registers must be programmed
> > and the higher threshold must be greater then or equal to the lower
> > threshold. Otherwise the event is disabled. Invalid hysteresis values
> > are ignored by the device. There is no further configuration possible.
> > 
> > Tested by setting thresholds/hysteresis and turning the heater on/off.
> > Used iio_event_monitor in tools/iio to catch events while constantly
> > displaying temperature and humidity values.
> > Threshold and hysteresis values are cached in the driver, used i2c-tools
> > to read the threshold and hysteresis values from the device and make
> > sure cached values are consistent to values written to the device.
> > 
> > Based on Fix:
> > a69eeaad093d "iio: humidity: hdc3020: fix temperature offset" in branch
> > fixes-togreg
> Move this below the ---
> as we don't want to keep that info in the log long term.
> 
Ok.

> It's good to have it for now though as helps me know when I can apply the patch.
> 
> > 
> > Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> > ---
> > Changes in V2:
> >   - Fix alphabetical order of includes(Christophe)
> >   - Fix typo: change varibale name "HDC3020_R_R_RH_THRESH_LOW_CLR" to
> >     HDC3020_R_T_RH_THRESH_LOW_CLR to match variable name pattern
> >     (Christophe)
> >   - Add constants HDC3020_MIN_TEMP and HDC3020_MAX_TEMP for min/max
> >     threshold inputs (Christophe)
> >   - Change HDC3020_MIN_TEMP to -40, as stated in the datasheet(Javier)
> >   - Fix shadowing of global variable "hdc3020_id" in probe function,
> >     rename variable in probe function to "dev_id"(Javier)
> > ---
> >  drivers/iio/humidity/hdc3020.c | 342 +++++++++++++++++++++++++++++++++
> >  1 file changed, 342 insertions(+)
> > 
> > diff --git a/drivers/iio/humidity/hdc3020.c b/drivers/iio/humidity/hdc3020.c
> > index ed70415512f6..80cfb343c92d 100644
> > --- a/drivers/iio/humidity/hdc3020.c
> > +++ b/drivers/iio/humidity/hdc3020.c
> > @@ -14,11 +14,13 @@
> >  #include <linux/delay.h>
> >  #include <linux/i2c.h>
> >  #include <linux/init.h>
> > +#include <linux/interrupt.h>
> >  #include <linux/module.h>
> >  #include <linux/mutex.h>
> >  
> >  #include <asm/unaligned.h>
> >  
> > +#include <linux/iio/events.h>
> >  #include <linux/iio/iio.h>
> >  
> >  #define HDC3020_HEATER_CMD_MSB		0x30 /* shared by all heater commands */
> > @@ -26,21 +28,47 @@
> >  #define HDC3020_HEATER_DISABLE		0x66
> >  #define HDC3020_HEATER_CONFIG		0x6E
> >  
> > +#define HDC3020_THRESH_TEMP_MASK	GENMASK(8, 0)
> > +#define HDC3020_THRESH_TEMP_SHIFT	7
> 
> This is odd.  Normally a mask and shift pair like this is about
> a register field.  Here that's not true.  So don't use the common
> naming and instead use something like TRUNCATED_BITS.
> Define that for both fields, then use
> FIELD_PREP() to set them, even though that will meant shifting
> the humidity values down and up again by the same amount.
>
Could have done better with the naming. Will fix this.

> 
> 
> > +#define HDC3020_THRESH_HUM_MASK		GENMASK(15, 9)
> > +
> > +#define HDC3020_STATUS_T_LOW_ALERT	BIT(6)
> > +#define HDC3020_STATUS_T_HIGH_ALERT	BIT(7)
> > +#define HDC3020_STATUS_RH_LOW_ALERT	BIT(8)
> > +#define HDC3020_STATUS_RH_HIGH_ALERT	BIT(9)
> > +
> >  #define HDC3020_READ_RETRY_TIMES	10
> >  #define HDC3020_BUSY_DELAY_MS		10
> >  
> >  #define HDC3020_CRC8_POLYNOMIAL		0x31
> >  
> > +#define HDC3020_MIN_TEMP		-40
> > +#define HDC3020_MAX_TEMP		125
> > +
> >  static const u8 HDC3020_S_AUTO_10HZ_MOD0[2] = { 0x27, 0x37 };
> >  
> > +static const u8 HDC3020_S_STATUS[2] = { 0x30, 0x41 };
> > +
> >  static const u8 HDC3020_EXIT_AUTO[2] = { 0x30, 0x93 };
> >  
> > +static const u8 HDC3020_S_T_RH_THRESH_LOW[2] = { 0x61, 0x00 };
> 
> Ah. missed this in original driver, but this use of capitals for
> non #defines is really confusing and we should aim to clean that
> up.
>
Could use small letters instead.

> As I mention below, I'm unconvinced that it makes sense to handle
> these as pairs.
>
For the threshold I could convert it as it is for the heater registers:

#define HDC3020_S_T_RH_THRESH_MSB	0x61
#define HDC3020_S_T_RH_THRESH_LOW	0x00
#define HDC3020_S_T_RH_THRESH_LOW_CLR	0x0B
#define HDC3020_S_T_RH_THRESH_HIGH_CLR	0x16
#define HDC3020_S_T_RH_THRESH_HIGH	0x1D

#define HDC3020_R_T_RH_THRESH_MSB	0xE1
#define HDC3020_R_T_RH_THRESH_LOW	0x02
#define HDC3020_R_T_RH_THRESH_LOW_CLR	0x09
#define HDC3020_R_T_RH_THRESH_HIGH_CLR	0x14
#define HDC3020_R_T_RH_THRESH_HIGH	0x1F

or:

#define HDC3020_S_T_RH_THRESH_LOW       0x6100
#define HDC3020_S_T_RH_THRESH_LOW_CLR   0x610B
#define HDC3020_S_T_RH_THRESH_HIGH_CLR  0x6116
#define HDC3020_S_T_RH_THRESH_HIGH      0x611D

#define HDC3020_R_T_RH_THRESH_LOW       0x6102
#define HDC3020_R_T_RH_THRESH_LOW_CLR   0x6109
#define HDC3020_R_T_RH_THRESH_HIGH_CLR  0x6114
#define HDC3020_R_T_RH_THRESH_HIGH      0x611F

I don't know if it's a good idea, as we would need to make sure it is
big endian in the buffer. Probably with a function that handles this.
> 
> > +static const u8 HDC3020_S_T_RH_THRESH_LOW_CLR[2] = { 0x61, 0x0B };
> > +static const u8 HDC3020_S_T_RH_THRESH_HIGH_CLR[2] = { 0x61, 0x16 };
> > +static const u8 HDC3020_S_T_RH_THRESH_HIGH[2] = { 0x61, 0x1D };
> > +
> >  static const u8 HDC3020_R_T_RH_AUTO[2] = { 0xE0, 0x00 };
> >  static const u8 HDC3020_R_T_LOW_AUTO[2] = { 0xE0, 0x02 };
> >  static const u8 HDC3020_R_T_HIGH_AUTO[2] = { 0xE0, 0x03 };
> >  static const u8 HDC3020_R_RH_LOW_AUTO[2] = { 0xE0, 0x04 };
> >  static const u8 HDC3020_R_RH_HIGH_AUTO[2] = { 0xE0, 0x05 };
> >  
> > +static const u8 HDC3020_R_T_RH_THRESH_LOW[2] = { 0xE1, 0x02 };
> > +static const u8 HDC3020_R_T_RH_THRESH_LOW_CLR[2] = { 0xE1, 0x09 };
> > +static const u8 HDC3020_R_T_RH_THRESH_HIGH_CLR[2] = { 0xE1, 0x14 };
> > +static const u8 HDC3020_R_T_RH_THRESH_HIGH[2] = { 0xE1, 0x1F };
> > +
> > +static const u8 HDC3020_R_STATUS[2] = { 0xF3, 0x2D };
> > +
> >  struct hdc3020_data {
> >  	struct i2c_client *client;
> >  	/*
> > @@ -50,22 +78,54 @@ struct hdc3020_data {
> >  	 * if the device does not respond).
> >  	 */
> >  	struct mutex lock;
> > +	/*
> > +	 * Temperature and humidity thresholds are packed together into a single
> > +	 * 16 bit value. Each threshold is represented by a truncated 16 bit
> > +	 * value. The 7 MSBs of a relative humidity threshold are concatenated
> > +	 * with the 9 MSBs of a temperature threshold, where the temperature
> > +	 * threshold resides in the 7 LSBs. Due to the truncated representation,
> > +	 * there is a resolution loss of 0.5 degree celsius in temperature and a
> > +	 * 1% resolution loss in relative humidity.
> > +	 */
> > +	u16 t_rh_thresh_low;
> > +	u16 t_rh_thresh_high;
> > +	u16 t_rh_thresh_low_clr;
> > +	u16 t_rh_thresh_high_clr;
> >  };
> >  
> >  static const int hdc3020_heater_vals[] = {0, 1, 0x3FFF};
> >  
> > +static const struct iio_event_spec hdc3020_t_rh_event[] = {
> > +	{
> > +		.type = IIO_EV_TYPE_THRESH,
> > +		.dir = IIO_EV_DIR_RISING,
> > +		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
> > +		BIT(IIO_EV_INFO_HYSTERESIS),
> > +	},
> > +	{
> > +		.type = IIO_EV_TYPE_THRESH,
> > +		.dir = IIO_EV_DIR_FALLING,
> > +		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
> > +		BIT(IIO_EV_INFO_HYSTERESIS),
> > +	},
> > +};
> > +
> >  static const struct iio_chan_spec hdc3020_channels[] = {
> >  	{
> >  		.type = IIO_TEMP,
> >  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> >  		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_PEAK) |
> >  		BIT(IIO_CHAN_INFO_TROUGH) | BIT(IIO_CHAN_INFO_OFFSET),
> > +		.event_spec = hdc3020_t_rh_event,
> > +		.num_event_specs = ARRAY_SIZE(hdc3020_t_rh_event),
> >  	},
> >  	{
> >  		.type = IIO_HUMIDITYRELATIVE,
> >  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> >  		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_PEAK) |
> >  		BIT(IIO_CHAN_INFO_TROUGH),
> > +		.event_spec = hdc3020_t_rh_event,
> > +		.num_event_specs = ARRAY_SIZE(hdc3020_t_rh_event),
> >  	},
> >  	{
> >  		/*
> > @@ -389,10 +449,241 @@ static int hdc3020_write_raw(struct iio_dev *indio_dev,
> >  	return -EINVAL;
> >  }
> >  
> > +static int hdc3020_write_thresh(struct iio_dev *indio_dev,
> > +				const struct iio_chan_spec *chan,
> > +				enum iio_event_type type,
> > +				enum iio_event_direction dir,
> > +				enum iio_event_info info,
> > +				int val, int val2)
> > +{
> > +	struct hdc3020_data *data = iio_priv(indio_dev);
> > +	u16 *thresh;
> > +	u8 buf[5];
> > +	int ret;
> > +
> > +	/* Supported temperature range is from –40 to 125 degree celsius */
> > +	if (val < HDC3020_MIN_TEMP || val > HDC3020_MAX_TEMP)
> > +		return -EINVAL;
> > +
> > +	/* Select threshold and associated register */
> > +	if (info == IIO_EV_INFO_VALUE) {
> > +		if (dir == IIO_EV_DIR_RISING) {
> > +			thresh = &data->t_rh_thresh_high;
> > +			memcpy(buf, HDC3020_S_T_RH_THRESH_HIGH, 2);
> > +		} else {
> > +			thresh = &data->t_rh_thresh_low;
> > +			memcpy(buf, HDC3020_S_T_RH_THRESH_LOW, 2);
> First value of buf is always 0x61 - so just set that above
> u8 buf[5] = { 0x61, };
> and here just write buf[1] with appropriate value.
> 
Will fix it.
> > +		}
> > +	} else {
> > +		if (dir == IIO_EV_DIR_RISING) {
> > +			thresh = &data->t_rh_thresh_high_clr;
> > +			memcpy(buf, HDC3020_S_T_RH_THRESH_HIGH_CLR, 2);
> > +		} else {
> > +			thresh = &data->t_rh_thresh_low_clr;
> > +			memcpy(buf, HDC3020_S_T_RH_THRESH_LOW_CLR, 2);
> > +		}
> > +	}
> > +
> > +	guard(mutex)(&data->lock);
> > +	switch (chan->type) {
> > +	case IIO_TEMP:
> > +		/*
> > +		 * Store truncated temperature threshold into 9 LSBs while
> > +		 * keeping the old humidity threshold in the 7 MSBs.
> > +		 */
> > +		val = (((val + 45) * 65535 / 175) >> HDC3020_THRESH_TEMP_SHIFT);
> 
> This almost looks like FIELD_PREP() but is really a division then a store?
> Perhaps rename TEMP_SHIFT TEMP_TRUNCATED_BITS or something like that to avoid
> the currently confusing naming.
> 
The comment is misleading. Calculation of the temperature threshold goes first
and then the value is truncated. Will fix this.

> > +		val &= HDC3020_THRESH_TEMP_MASK;
> > +		val |= (*thresh & HDC3020_THRESH_HUM_MASK);
> > +		break;
> > +	case IIO_HUMIDITYRELATIVE:
> > +		/*
> > +		 * Store truncated humidity threshold into 7 MSBs while
> > +		 * keeping the old temperature threshold in the 9 LSBs.
> > +		 */
> > +		val = ((val * 65535 / 100) & HDC3020_THRESH_HUM_MASK);
> > +		val |= (*thresh & HDC3020_THRESH_TEMP_MASK);
> > +		break;
> > +	default:
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	put_unaligned_be16(val, &buf[2]);
> > +	buf[4] = crc8(hdc3020_crc8_table, buf + 2, 2, CRC8_INIT_VALUE);
> > +	ret = hdc3020_write_bytes(data, buf, 5);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Update threshold */
> > +	*thresh = val;
> > +
> > +	return 0;
> > +}
> > +
> > +static int _hdc3020_read_thresh(struct hdc3020_data *data,
> 
> Relationship of this function to the following one not clear from
> naming.  Rename it to make the two different cases easier to follow.
> Mind you, threshold checking isn't usually a fast path - so
> it's unusual to cache the thresholds in the driver explicitly
> (as opposed to getting them cached for free via regmap which doesn't
> add driver complexity).
>
It is left from a previous version which I didn't submit. Will fix the
naming if I need the function in the next version. I probably remove the
caching, as you already explained it adds complexity and isn't in the
fast path.

> 
> > +				enum iio_event_info info,
> > +				enum iio_event_direction dir, u16 *thresh)
> > +{
> > +	u8 crc, buf[3];
> > +	const u8 *cmd;
> > +	int ret;
> > +
> > +	if (info == IIO_EV_INFO_VALUE) {
> > +		if (dir == IIO_EV_DIR_RISING)
> 
> As you only use these in the initial readback, maybe just pass the
> cmd directly into each call.  No need to use general interfaces.
> 
Ok.
> > +			cmd = HDC3020_R_T_RH_THRESH_HIGH;
> > +		else
> > +			cmd = HDC3020_R_T_RH_THRESH_LOW;
> > +	} else {
> > +		if (dir == IIO_EV_DIR_RISING)
> > +			cmd = HDC3020_R_T_RH_THRESH_HIGH_CLR;
> > +		else
> > +			cmd = HDC3020_R_T_RH_THRESH_LOW_CLR;
> > +	}
> > +
> > +	ret = hdc3020_read_bytes(data, cmd, buf, 3);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	/* CRC check of the threshold */
> > +	crc = crc8(hdc3020_crc8_table, buf, 2, CRC8_INIT_VALUE);
> > +	if (crc != buf[2])
> > +		return -EINVAL;
> 
> > +
> > +	*thresh = get_unaligned_be16(buf);
> 
> This 3 byte read, crc check and be16 extraction is common in this diver
> maybe - just add a helper function for this rather than adding
> yet another copy of the same code?
> 
> int hdc3020_read_be16_reg(struct iio_dev *indio_dev, u8 cmd)
> {...
> 
> 	return get_unaligned_be16(buf);
> 
You are right. Will also fix this for the existing code.

> > +
> > +	return 0;
> > +}
> > +
> > +static int hdc3020_read_thresh(struct iio_dev *indio_dev,
> > +			       const struct iio_chan_spec *chan,
> > +			       enum iio_event_type type,
> > +			       enum iio_event_direction dir,
> > +			       enum iio_event_info info,
> > +			       int *val, int *val2)
> > +{
> > +	struct hdc3020_data *data = iio_priv(indio_dev);
> > +	u16 *thresh;
> > +
> > +	/* Select threshold */
> > +	if (info == IIO_EV_INFO_VALUE) {
> > +		if (dir == IIO_EV_DIR_RISING)
> > +			thresh = &data->t_rh_thresh_high;
> > +		else
> > +			thresh = &data->t_rh_thresh_low;
> > +	} else {
> > +		if (dir == IIO_EV_DIR_RISING)
> > +			thresh = &data->t_rh_thresh_high_clr;
> > +		else
> > +			thresh = &data->t_rh_thresh_low_clr;
> > +	}
> > +
> > +	guard(mutex)(&data->lock);
> 
> Why take the lock here?
> 
> you are relying on a single value that is already cached.
>
A single threshold value is used for humidity and temperature values. I
didn't see a lock in "iio_ev_value_show", so there might be some
concurrent access triggered by "in_temp_thresh_rising_value" and
"in_humidityrelative_thresh_rising_value" sysfs files which is not
secured by a mutex or similiar.

> 
> > +	switch (chan->type) {
> > +	case IIO_TEMP:
> > +		/* Get the truncated temperature threshold from 9 LSBs,
> > +		 * shift them and calculate the threshold according to the
> > +		 * formula in the datasheet.
> > +		 */
> > +		*val = ((*thresh) & HDC3020_THRESH_TEMP_MASK) <<
> > +			HDC3020_THRESH_TEMP_SHIFT;
> > +		*val = -2949075 + (175 * (*val));
> > +		*val2 = 65535;
> > +		break;
> 		return here.  Gives easier to review code as no need for
> a reader to check if anything else happens in this path.
> 
Ok.

> > +	case IIO_HUMIDITYRELATIVE:
> > +		/* Get the truncated humidity threshold from 7 MSBs, and
> > +		 * calculate the threshold according to the formula in the
> > +		 * datasheet.
> > +		 */
> > +		*val = 100 * ((*thresh) & HDC3020_THRESH_HUM_MASK);
> > +		*val2 = 65535;
> > +		break;
> return here
Ok.

> > +	default:
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	return IIO_VAL_FRACTIONAL;
> Drop this as will have returned above.
Ok.

> > +}
> 
> > +
> > +static irqreturn_t hdc3020_interrupt_handler(int irq, void *private)
> > +{
> > +	struct iio_dev *indio_dev = private;
> > +	struct hdc3020_data *data;
> > +	u16 stat;
> > +	int ret;
> > +
> > +	data = iio_priv(indio_dev);
> > +	ret = hdc3020_read_status(data, &stat);
> > +	if (ret)
> > +		return IRQ_NONE;
> Hmm. In cases where we get a read back failure on an interrupt it is always
> messy to decide if it's spurious or not.  If this actually happens you may
> find you want to return IRQ_HANDLED; even though it wasn't.
Will fix this, thanks.

> > +
> > +	if (!(stat & (HDC3020_STATUS_T_HIGH_ALERT | HDC3020_STATUS_T_LOW_ALERT |
> > +		HDC3020_STATUS_RH_HIGH_ALERT | HDC3020_STATUS_RH_LOW_ALERT)))
> > +		return IRQ_NONE;
> 
> This one is fine as you know it is spurious.
> 
> > +
> > +	if (stat & HDC3020_STATUS_T_HIGH_ALERT)
> > +		iio_push_event(indio_dev,
> > +			       IIO_MOD_EVENT_CODE(IIO_TEMP, 0,
> > +						  IIO_NO_MOD,
> > +						  IIO_EV_TYPE_THRESH,
> > +						  IIO_EV_DIR_RISING),
> > +						  iio_get_time_ns(indio_dev));
> If you happen to get more than one, you probably want the timestamp to match.
> I'd take the timestamp first into a local variable then use it in each of these.
> 
Will fix this.

> > +
> > +	if (stat & HDC3020_STATUS_T_LOW_ALERT)
> > +		iio_push_event(indio_dev,
> > +			       IIO_MOD_EVENT_CODE(IIO_TEMP, 0,
> > +						  IIO_NO_MOD,
> > +						  IIO_EV_TYPE_THRESH,
> > +						  IIO_EV_DIR_FALLING),
> > +						  iio_get_time_ns(indio_dev));
> > +
> > +	if (stat & HDC3020_STATUS_RH_HIGH_ALERT)
> > +		iio_push_event(indio_dev,
> > +			       IIO_MOD_EVENT_CODE(IIO_HUMIDITYRELATIVE, 0,
> > +						  IIO_NO_MOD,
> > +						  IIO_EV_TYPE_THRESH,
> > +						  IIO_EV_DIR_RISING),
> > +						  iio_get_time_ns(indio_dev));
> > +
> > +	if (stat & HDC3020_STATUS_RH_LOW_ALERT)
> > +		iio_push_event(indio_dev,
> > +			       IIO_MOD_EVENT_CODE(IIO_HUMIDITYRELATIVE, 0,
> > +						  IIO_NO_MOD,
> > +						  IIO_EV_TYPE_THRESH,
> > +						  IIO_EV_DIR_FALLING),
> > +						  iio_get_time_ns(indio_dev));
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> >  static const struct iio_info hdc3020_info = {
> >  	.read_raw = hdc3020_read_raw,
> >  	.write_raw = hdc3020_write_raw,
> >  	.read_avail = hdc3020_read_available,
> > +	.read_event_value = hdc3020_read_thresh,
> > +	.write_event_value = hdc3020_write_thresh,
> >  };
> >  
> >  static void hdc3020_stop(void *data)
> > @@ -402,6 +693,7 @@ static void hdc3020_stop(void *data)
> >  
> >  static int hdc3020_probe(struct i2c_client *client)
> >  {
> > +	const struct i2c_device_id *dev_id;
> >  	struct iio_dev *indio_dev;
> >  	struct hdc3020_data *data;
> >  	int ret;
> > @@ -413,6 +705,8 @@ static int hdc3020_probe(struct i2c_client *client)
> >  	if (!indio_dev)
> >  		return -ENOMEM;
> >  
> > +	dev_id = i2c_client_get_device_id(client);
> > +
> >  	data = iio_priv(indio_dev);
> >  	data->client = client;
> >  	mutex_init(&data->lock);
> > @@ -425,6 +719,54 @@ static int hdc3020_probe(struct i2c_client *client)
> >  	indio_dev->channels = hdc3020_channels;
> >  	indio_dev->num_channels = ARRAY_SIZE(hdc3020_channels);
> >  
> > +	/* Read out upper and lower thresholds and hysteresis, which can be the
> 
> As below - comment syntax wrong for IIO drivers (only net and a few other
> corners of the kernel prefer this one for historical reasons).
>
Will fix this.

> > +	 * default values or values programmed into non-volatile memory.
> > +	 */
> > +	ret = _hdc3020_read_thresh(data, IIO_EV_INFO_VALUE, IIO_EV_DIR_FALLING,
> > +				   &data->t_rh_thresh_low);
> As above, it feels to me like you can just use the registers directly into
> a be16 readback function.
> 
> 	ret = hdc3020_read_be16_reg(indio_dev, HDC3020_R_T_RH_THRESH_LOW)
> 	if (ret < 0)
> 		return ...
> 
> 	data->t_rh_thresh_low = ret;
> etc
> 
Will fix this.

> > +	if (ret)
> > +		return dev_err_probe(&client->dev, ret,
> > +				     "Unable to get low thresholds\n");
> > +
> > +	ret = _hdc3020_read_thresh(data, IIO_EV_INFO_VALUE, IIO_EV_DIR_RISING,
> > +				   &data->t_rh_thresh_high);
> > +	if (ret)
> > +		return dev_err_probe(&client->dev, ret,
> > +				     "Unable to get high thresholds\n");
> > +
> > +	ret = _hdc3020_read_thresh(data, IIO_EV_INFO_HYSTERESIS,
> > +				   IIO_EV_DIR_FALLING,
> > +				   &data->t_rh_thresh_low_clr);
> > +	if (ret)
> > +		return dev_err_probe(&client->dev, ret,
> > +				     "Unable to get low hysteresis\n");
> > +
> > +	ret = _hdc3020_read_thresh(data, IIO_EV_INFO_HYSTERESIS,
> > +				   IIO_EV_DIR_RISING,
> > +				   &data->t_rh_thresh_high_clr);
> > +	if (ret)
> > +		return dev_err_probe(&client->dev, ret,
> > +				     "Unable to get high hysteresis\n");
> > +
> > +	if (client->irq) {
> Comment syntax in IIO (and most of the kernel) is
> 		/*
> 		 * The alert....
> 
Will fix this.

> > +		/* The alert output is activated by default upon power up, hardware
> > +		 * reset, and soft reset. Clear the status register before enabling
> > +		 * the interrupt.
> That's a bit nasty. Ah well.  Ordering not critical though as you are registering
> a rising trigger.  However...
Will fix this. It makes more sense to clear the interrupt after registering the
interrupt handler.

> > +		 */
> > +		ret = hdc3020_clear_status(data);
> > +		if (ret)
> > +			return ret;
> > +
> > +		ret = devm_request_threaded_irq(&client->dev, client->irq,
> > +						NULL, hdc3020_interrupt_handler,
> > +						IRQF_TRIGGER_RISING |
> 
> These days (we got this wrong a lot in the past) we tend to leave the interrupt
> polarity to the firmware to configure (DT or similar) as people have an annoying
> habit of using not gates in interrupt wiring.   So Just pass IRQF_ONESHOT but
> make sure the DT binding example sets this right.
> 
Will fix this, thanks.

> > +						IRQF_ONESHOT,
> > +						dev_id->name, indio_dev);
> 
> dev_id->name is annoyingly unstable depending on the probe path and whether
> the various firmware match tables align perfectly with the i2c_device_id
> table. I'd just use a fixed value here for the driver in question and
> not worry about it too much.  hdc3020 is fine.  If you really care about
> it add a device specific structure and put a string for the name in there.
> That can then be referenced from all the firmware tables (safely) and
> i2c_get_match_data() used to get it from which ever one is available.
> 
Will stick to the fixed value "hdc3020". Thanks for the explanation,
didn't know it. :)
> > +		if (ret)
> > +			return dev_err_probe(&client->dev, ret,
> > +					     "Failed to request IRQ\n");
> > +	}
> > +
> >  	ret = hdc3020_write_bytes(data, HDC3020_S_AUTO_10HZ_MOD0, 2);
> >  	if (ret)
> >  		return dev_err_probe(&client->dev, ret,
> 

