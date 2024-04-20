Return-Path: <linux-kernel+bounces-152236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0A58ABB36
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 13:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1058B1F213A7
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 11:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A022941F;
	Sat, 20 Apr 2024 11:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UoKNOhOs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426F3205E30;
	Sat, 20 Apr 2024 11:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713610971; cv=none; b=N1n96egSUc6ilKq5T39SomJaAZcKxXjCMq/IeA4GGYU26aUr8cfFj/CJFdpiVJgVyNOaRiJGgToc9vtAQo5W/oJ+x6+WZrwcXMYgj00QTaNhe8ZdlKQnEB4+qXJjuKI1cIFRyhFt+YZ/1JtKW75cyL3O4mgaFV/V2k3kYkdfJSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713610971; c=relaxed/simple;
	bh=Bz8Fp8hN4Mlc9ZnQKuGXEkk/3st/E9Rbstg5YTsOdv8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=af58GAQ5i1GnLWnEjXwUBYz3blQh0kR9rXcUeZvyltT8H9J3Wxl7Wwvdlh8lV0IuGlcdvMwriK2Tdtj6JHIuVP82tpCSFOxavX2u1rygYm3nYkg0MHB2zt6JvdtYIBxoD6MltVD2Rp2JG0Yd4SoSl/iLsM3c50SLAH4PsuIDSOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UoKNOhOs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17CA9C072AA;
	Sat, 20 Apr 2024 11:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713610970;
	bh=Bz8Fp8hN4Mlc9ZnQKuGXEkk/3st/E9Rbstg5YTsOdv8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UoKNOhOsf0AqhmGSvpPxyL48GbB/m9Av7fdoj8f/PjgyKCzfwcWjIbRUKwMyc2wP9
	 mqywb9gYU1HDGq+ROKPNgLyft9BAcdocfsLUde8niKyueGRVjrRpFPz5EOx/zP6z3I
	 40pqs2RKkBi3ikkq3QL/s8P3jjgrQX4HsBbB90VyPQEbwYj5hwL7WxThpKEwzaNDCK
	 Ibo6XnSPzDTbxG/2iagJrE38ErBHuPboNwwzvBVFX9Q4kTCsqjY09OCLLYDHAky9EP
	 iJGy4Pk22cCs4PW64CaVbc5p55vcJV8Kxp4fmrCE6UChyIwOaz9qGilUSSuLwWzhJL
	 aHfn7HlhRSj4Q==
Date: Sat, 20 Apr 2024 12:02:35 +0100
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
Subject: Re: [PATCH v6 5/5] iio: adc: ad7192: Add AD7194 support
Message-ID: <20240420120235.63e32769@jic23-huawei>
In-Reply-To: <20240417170054.140587-6-alisa.roman@analog.com>
References: <20240417170054.140587-1-alisa.roman@analog.com>
	<20240417170054.140587-6-alisa.roman@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Apr 2024 20:00:54 +0300
Alisa-Dariana Roman <alisadariana@gmail.com> wrote:

> Unlike the other AD719Xs, AD7194 has configurable differential
> channels. The user can dynamically configure them in the devicetree.
> 
> Also modify config AD7192 description for better scaling.
> 
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>

Late feedback (sorry!) but I think we should resolve the single ended
channel description so that it sits at the same level in DT binding
as do differential channels.  Current situation just feels inconsistent.

See DT binding reply.  Should be easy to do now, and wouldn't be possible
to add later.  It would be possible to add support for moving to
per channel DT entries for a driver that previously assumed all should be
available, but we can't easily move from assuming all single ended channels
are but differential are specified by DT child nodes.

Jonathan

> diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> index 8d56cf889973..dc113405f1bc 100644
> --- a/drivers/iio/adc/ad7192.c
> +++ b/drivers/iio/adc/ad7192.c
> @@ -1,6 +1,6 @@


> +static int ad7194_parse_channels(struct iio_dev *indio_dev)
> +{
> +	struct device *dev = indio_dev->dev.parent;
> +	struct iio_chan_spec *ad7194_channels;
> +	struct fwnode_handle *child;
> +	struct iio_chan_spec ad7194_chan = AD7193_CHANNEL(0, 0, 0);
> +	struct iio_chan_spec ad7194_chan_diff = AD7193_DIFF_CHANNEL(0, 0, 0, 0);
> +	struct iio_chan_spec ad7194_chan_temp = AD719x_TEMP_CHANNEL(0, 0);
> +	struct iio_chan_spec ad7194_chan_timestamp = IIO_CHAN_SOFT_TIMESTAMP(0);
> +	unsigned int num_channels, index = 0, ain_chan;
> +	int ret;
> +
> +	num_channels = device_get_child_node_count(dev);
> +	if (num_channels > AD7194_CH_DIFF_NR_MAX)
> +		return -EINVAL;
> +
> +	num_channels += AD7194_CH_BASE_NR;
> +
> +	ad7194_channels = devm_kcalloc(dev, num_channels,
> +				       sizeof(*ad7194_channels), GFP_KERNEL);
> +	if (!ad7194_channels)
> +		return -ENOMEM;
> +
> +	indio_dev->channels = ad7194_channels;
> +	indio_dev->num_channels = num_channels;
> +
> +	device_for_each_child_node(dev, child) {
> +		*ad7194_channels = ad7194_chan_diff;
> +		ad7194_channels->scan_index = index++;
> +		ret = ad7194_parse_channel(child, ad7194_channels);
> +		if (ret) {
> +			fwnode_handle_put(child);
> +			return ret;
> +		}
> +		ad7194_channels++;
> +	}
> +
> +	*ad7194_channels = ad7194_chan_temp;
> +	ad7194_channels->scan_index = index++;
> +	ad7194_channels->address = AD7194_CH_TEMP;
> +	ad7194_channels++;
> +
> +	for (ain_chan = 1; ain_chan <= 16; ain_chan++) {

I think it's worth making these more similar to the differential channels.
Seems odd to allow DT to provide that list, but not the same for single ended.
See comment on binding.  Should be fairly easy to add now, and if we
leave it until later, there won't be a way to move this forwards because
we won't be able to tell if no single ended channels in DT means none
are relevant, or if it means the DT file predates us adding per single ended
channel description.


> +		*ad7194_channels = ad7194_chan;
> +		ad7194_channels->scan_index = index++;
> +		ad7194_channels->channel = ain_chan;
> +		ad7194_channels->address = AD7194_CH_DIFF(ain_chan, 0);
> +		ad7194_channels++;
> +	}
> +
> +	*ad7194_channels = ad7194_chan_timestamp;
> +	ad7194_channels->scan_index = index;
> +
> +	return 0;
> +}



