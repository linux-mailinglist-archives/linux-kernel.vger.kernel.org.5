Return-Path: <linux-kernel+bounces-152228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BD98ABB05
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 12:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 668E41C20DBA
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 10:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C1917BCB;
	Sat, 20 Apr 2024 10:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JzQO7oCf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01476DDD9;
	Sat, 20 Apr 2024 10:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713609470; cv=none; b=nlUNSuMRkNkL4izlgJEu6TElxR4GlgZig2qGXxmeJqoyQNeHXboNnjen7i0Ly/dE8J67uNodiLkhZA7nSmCcD5SN7wgohxDLULsyHYPpJv1agiWl/ogq1SgpohCQOY1CeM6FROAXXsMhX7luTsCmz4UOL1ZYTbzYLcFC3eUhcnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713609470; c=relaxed/simple;
	bh=AWWnGCFul/pC2L5x8W6zIHyOcOqWuxYQknuDJWxOi4o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nM95wiJheSoA/x9J28IPC26e/NCZdVNBFdo3BMIHSNfGbPnATbxsZiqFRapHXe/lIA3jSW+wvsLzfy+B3h3A1vYlk9jU+/dkL5isUUUKeBd5fp7UU9U4r6IfaB+4t9b+ddBaYVqiUlfTtGkURFRxqgndn1zHkp4rp7JcAXlx83w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JzQO7oCf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C42C3C072AA;
	Sat, 20 Apr 2024 10:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713609469;
	bh=AWWnGCFul/pC2L5x8W6zIHyOcOqWuxYQknuDJWxOi4o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JzQO7oCfQoHa/pdUDQtQlSx3PZWapgTCuDPNkJgfEr1igGlT90iBZF677gaKaKY3e
	 3q7Sle9j4UgiQO5zW7e97Jd+uHpx51riQJ7qLMkLyUc4dWnJedXSWa2TvTFiJjwn9F
	 zHE0lKKKJH/bEMAx5q502lrj8wNYRm/Kl1kycGlNPvkza4naAdHd8yW9pEfZUptb2n
	 ZEL3XQkjkWwDvBCGcqDzJMRIpa2hpKrBP3vU5jePgH8MJySBNmDYtse6PEz4BmiuX0
	 kYRlUH+6Fi48DQtBGLIqbjOOeM9KppsPG/2X4X4ToVYf8HXM4itqjw4nI47W0281RY
	 rvlphHpE2tWGQ==
Date: Sat, 20 Apr 2024 11:37:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: michael.hennerich@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 alexandru.tachici@analog.com, lars@metafoo.de, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 lgirdwood@gmail.com, broonie@kernel.org, andy@kernel.org,
 nuno.sa@analog.com, marcelo.schmitt@analog.com, bigunclemax@gmail.com,
 dlechner@baylibre.com, okan.sahin@analog.com, fr0st61te@gmail.com,
 alisa.roman@analog.com, marcus.folkesson@gmail.com, schnelle@linux.ibm.com,
 liambeguin@gmail.com
Subject: Re: [PATCH v6 1/5] iio: adc: ad7192: Use standard attribute
Message-ID: <20240420113734.65de0fa0@jic23-huawei>
In-Reply-To: <20240417170054.140587-2-alisa.roman@analog.com>
References: <20240417170054.140587-1-alisa.roman@analog.com>
	<20240417170054.140587-2-alisa.roman@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Apr 2024 20:00:50 +0300
Alisa-Dariana Roman <alisadariana@gmail.com> wrote:

> Replace custom attribute filter_low_pass_3db_frequency_available with
> standard attribute.
> 
> Store the available values in ad7192_state struct.
> 
> The function that used to compute those values replaced by
> ad7192_update_filter_freq_avail().
> 
> Function ad7192_show_filter_avail() is no longer needed.
> 
> Note that the initial available values are hardcoded.
> 
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
> Reviewed-by: David Lechner <dlechner@baylibre.com>

Locking comment inline.  Note that I'm fairly sure there is an existing
bug because the 3db filter write isn't protecting st->conf.

I only noticed this because I was checking you'd fixed the locking issue
noted by David in v5.

Jonathan

> ---
>  drivers/iio/adc/ad7192.c | 67 ++++++++++++++++++----------------------
>  1 file changed, 30 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> index 7bcc7e2aa2a2..fe8dbb68a8ba 100644
> --- a/drivers/iio/adc/ad7192.c
> +++ b/drivers/iio/adc/ad7192.c
> @@ -190,6 +190,7 @@ struct ad7192_state {
>  	u32				mode;
>  	u32				conf;
>  	u32				scale_avail[8][2];
> +	u32				filter_freq_avail[4][2];
>  	u32				oversampling_ratio_avail[4];
>  	u8				gpocon;
>  	u8				clock_sel;
> @@ -473,6 +474,16 @@ static int ad7192_setup(struct iio_dev *indio_dev, struct device *dev)
>  	st->oversampling_ratio_avail[2] = 8;
>  	st->oversampling_ratio_avail[3] = 16;
>  
> +	st->filter_freq_avail[0][0] = 600;
> +	st->filter_freq_avail[1][0] = 800;
> +	st->filter_freq_avail[2][0] = 2300;
> +	st->filter_freq_avail[3][0] = 2720;
> +
> +	st->filter_freq_avail[0][1] = 1000;
> +	st->filter_freq_avail[1][1] = 1000;
> +	st->filter_freq_avail[2][1] = 1000;
> +	st->filter_freq_avail[3][1] = 1000;
> +
>  	return 0;
>  }
>  
> @@ -586,48 +597,24 @@ static int ad7192_get_f_adc(struct ad7192_state *st)
>  				 f_order * FIELD_GET(AD7192_MODE_RATE_MASK, st->mode));
>  }
>  
> -static void ad7192_get_available_filter_freq(struct ad7192_state *st,
> -						    int *freq)
> +static void ad7192_update_filter_freq_avail(struct ad7192_state *st)
>  {
>  	unsigned int fadc;
>  
>  	/* Formulas for filter at page 25 of the datasheet */
>  	fadc = ad7192_compute_f_adc(st, false, true);
> -	freq[0] = DIV_ROUND_CLOSEST(fadc * 240, 1024);
> +	st->filter_freq_avail[0][0] = DIV_ROUND_CLOSEST(fadc * 240, 1024);
>  
>  	fadc = ad7192_compute_f_adc(st, true, true);
> -	freq[1] = DIV_ROUND_CLOSEST(fadc * 240, 1024);
> +	st->filter_freq_avail[1][0] = DIV_ROUND_CLOSEST(fadc * 240, 1024);
>  
>  	fadc = ad7192_compute_f_adc(st, false, false);
> -	freq[2] = DIV_ROUND_CLOSEST(fadc * 230, 1024);
> +	st->filter_freq_avail[2][0] = DIV_ROUND_CLOSEST(fadc * 230, 1024);
>  
>  	fadc = ad7192_compute_f_adc(st, true, false);
> -	freq[3] = DIV_ROUND_CLOSEST(fadc * 272, 1024);
> +	st->filter_freq_avail[3][0] = DIV_ROUND_CLOSEST(fadc * 272, 1024);
>  }
>  
> -static ssize_t ad7192_show_filter_avail(struct device *dev,
> -					struct device_attribute *attr,
> -					char *buf)
> -{
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ad7192_state *st = iio_priv(indio_dev);
> -	unsigned int freq_avail[4], i;
> -	size_t len = 0;
> -
> -	ad7192_get_available_filter_freq(st, freq_avail);
> -
> -	for (i = 0; i < ARRAY_SIZE(freq_avail); i++)
> -		len += sysfs_emit_at(buf, len, "%d.%03d ", freq_avail[i] / 1000,
> -				     freq_avail[i] % 1000);
> -
> -	buf[len - 1] = '\n';
> -
> -	return len;
> -}
> -
> -static IIO_DEVICE_ATTR(filter_low_pass_3db_frequency_available,
> -		       0444, ad7192_show_filter_avail, NULL, 0);
> -
>  static IIO_DEVICE_ATTR(bridge_switch_en, 0644,
>  		       ad7192_show_bridge_switch, ad7192_set,
>  		       AD7192_REG_GPOCON);
> @@ -637,7 +624,6 @@ static IIO_DEVICE_ATTR(ac_excitation_en, 0644,
>  		       AD7192_REG_CONF);
>  
>  static struct attribute *ad7192_attributes[] = {
> -	&iio_dev_attr_filter_low_pass_3db_frequency_available.dev_attr.attr,
>  	&iio_dev_attr_bridge_switch_en.dev_attr.attr,
>  	NULL
>  };
> @@ -647,7 +633,6 @@ static const struct attribute_group ad7192_attribute_group = {
>  };
>  
>  static struct attribute *ad7195_attributes[] = {
> -	&iio_dev_attr_filter_low_pass_3db_frequency_available.dev_attr.attr,
>  	&iio_dev_attr_bridge_switch_en.dev_attr.attr,
>  	&iio_dev_attr_ac_excitation_en.dev_attr.attr,
>  	NULL
> @@ -665,17 +650,15 @@ static unsigned int ad7192_get_temp_scale(bool unipolar)
>  static int ad7192_set_3db_filter_freq(struct ad7192_state *st,
>  				      int val, int val2)
>  {
> -	int freq_avail[4], i, ret, freq;
> +	int i, ret, freq;
>  	unsigned int diff_new, diff_old;
>  	int idx = 0;
>  
>  	diff_old = U32_MAX;
>  	freq = val * 1000 + val2;
>  
> -	ad7192_get_available_filter_freq(st, freq_avail);
> -
> -	for (i = 0; i < ARRAY_SIZE(freq_avail); i++) {
> -		diff_new = abs(freq - freq_avail[i]);
> +	for (i = 0; i < ARRAY_SIZE(st->filter_freq_avail); i++) {
> +		diff_new = abs(freq - st->filter_freq_avail[i][0]);
>  		if (diff_new < diff_old) {
>  			diff_old = diff_new;
>  			idx = i;
> @@ -826,6 +809,7 @@ static int ad7192_write_raw(struct iio_dev *indio_dev,
>  		st->mode &= ~AD7192_MODE_RATE_MASK;
>  		st->mode |= FIELD_PREP(AD7192_MODE_RATE_MASK, div);
>  		ad_sd_write_reg(&st->sd, AD7192_REG_MODE, 3, st->mode);
> +		ad7192_update_filter_freq_avail(st);

This now needs to take the mutex.
There are a bunch of writes in this update function and in theory it two
sysfs writes could occur at the same time hitting this path and the one below
resulting in an inconsistent set of values ending up in 
st->filter_freq_avail[x]

Would be a minor effect and is pretty unlikely but might as well close it
down.

Note that I'm fairly sure the update of the 3db filter frequency is already
capable of corrupting st->conf because it doesn't take the mutex.

With that in mind, I'd suggestion moving the mutex outside the switch statement.




>  		break;
>  	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
>  		ret = ad7192_set_3db_filter_freq(st, val, val2 / 1000);
> @@ -845,6 +829,7 @@ static int ad7192_write_raw(struct iio_dev *indio_dev,
>  						3, st->mode);
>  				break;
>  			}
> +		ad7192_update_filter_freq_avail(st);
>  		mutex_unlock(&st->lock);
>  		break;
>  	default:
> @@ -888,6 +873,12 @@ static int ad7192_read_avail(struct iio_dev *indio_dev,
>  		/* Values are stored in a 2D matrix  */
>  		*length = ARRAY_SIZE(st->scale_avail) * 2;
>  
> +		return IIO_AVAIL_LIST;
> +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +		*vals = (int *)st->filter_freq_avail;
> +		*type = IIO_VAL_FRACTIONAL;
> +		*length = ARRAY_SIZE(st->filter_freq_avail) * 2;
> +
>  		return IIO_AVAIL_LIST;
>  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
>  		*vals = (int *)st->oversampling_ratio_avail;
> @@ -956,7 +947,9 @@ static const struct iio_info ad7195_info = {
>  			BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) | \
>  			(_mask_all), \
>  		.info_mask_shared_by_type_available = (_mask_type_av), \
> -		.info_mask_shared_by_all_available = (_mask_all_av), \
> +		.info_mask_shared_by_all_available = \
> +			BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) | \
> +			(_mask_all_av), \
>  		.ext_info = (_ext_info), \
>  		.scan_index = (_si), \
>  		.scan_type = { \


