Return-Path: <linux-kernel+bounces-112675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3CD887CD3
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 14:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4A19281274
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 13:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898EB17BD6;
	Sun, 24 Mar 2024 13:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XjLKRn1x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0E91772D;
	Sun, 24 Mar 2024 13:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711285876; cv=none; b=qE7/D0fYCNNzGwIeAFzPTPIT44R9TYd12sPFqHy0auS97En+2Hv3nOAL6BC/Ws9duuWmXvhzVhGTpVTvGnAv1HRBdgU16dNRpu1CG9jCr/WGfeKQi7glifAjSu4RuhywcV6EBN0weq0GJzUjUaOibbsx0OZe8K1Fusca2hXHXfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711285876; c=relaxed/simple;
	bh=Mrhs9/64lK3MIk0Y2r222aZ7KcyPKnhX4bA5v7W7xec=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tOLs2KPMjtiRr+dBIeM5yHT8UdBZf4PKIz/NXu7fXFO64ADISzEYcPFr2P3G7yreh05kZbMxKWCYUuFIGdmqEV2Nyw/tBMruqg9ydA0374L2FGFe+YKgldCMOrCjfN/i4Avr++ZCb13EgwSWLFWYoRCUguxtZ0R6Bd4qsXonnhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XjLKRn1x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0B4AC433F1;
	Sun, 24 Mar 2024 13:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711285876;
	bh=Mrhs9/64lK3MIk0Y2r222aZ7KcyPKnhX4bA5v7W7xec=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XjLKRn1xrTDLsZ7nqB7UHhmIy25hy9QM3bZUTY8hJnt0+Jn/obTvwV80qwr38sHsk
	 UIrkAmBql5fCmJmt4UQ3UP2hqEB9o2GPp/NvxA/Th7GYBuztNr+zGd2jhp8G5VVqQ+
	 C0QR/VQ8L5GBdQ5lDiAYtHro1RGHHNpTG0n/Q6dQBXrKBbsmo7YnQ6Mp5ix7goHD3r
	 aWsVfMyzr84Dz60q+/SHxdzuTzL54PbteCQ962OVn9gogRARmxcEa+r9gMb9XBasOx
	 iwSLrfJf5Y7X8GyioyvGbP/3XqnFRSSd7EHN968L7k0dHY5dpKuhAM4bR5am5hH39w
	 zXomcL3C3bPWw==
Date: Sun, 24 Mar 2024 13:10:59 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Julien Stephan <jstephan@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel test robot
 <lkp@intel.com>
Subject: Re: [PATCH v5 7/7] iio: adc: ad7380: add support for ad738x-4 4
 channels variants
Message-ID: <20240324131059.77fa8e68@jic23-huawei>
In-Reply-To: <20240319-adding-new-ad738x-driver-v5-7-ce7df004ceb3@baylibre.com>
References: <20240319-adding-new-ad738x-driver-v5-0-ce7df004ceb3@baylibre.com>
	<20240319-adding-new-ad738x-driver-v5-7-ce7df004ceb3@baylibre.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Mar 2024 11:11:28 +0100
Julien Stephan <jstephan@baylibre.com> wrote:

> Add support for ad7380/1/2/3-4 parts which are 4 channels
> variants from ad7380/1/2/3
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
This and other patches I didn't comment on all look good to me.
So just those minor few bits and bobs for v6 and I'll pick this up
if nothing else comes in.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad7380.c | 75 +++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 74 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
> index 3aca41ce9a14..cf9d2ace5f20 100644
> --- a/drivers/iio/adc/ad7380.c
> +++ b/drivers/iio/adc/ad7380.c
> @@ -8,6 +8,9 @@
>   * Datasheets of supported parts:
>   * ad7380/1 : https://www.analog.com/media/en/technical-documentation/data-sheets/AD7380-7381.pdf
>   * ad7383/4 : https://www.analog.com/media/en/technical-documentation/data-sheets/ad7383-7384.pdf
> + * ad7380-4 : https://www.analog.com/media/en/technical-documentation/data-sheets/ad7380-4.pdf
> + * ad7381-4 : https://www.analog.com/media/en/technical-documentation/data-sheets/ad7381-4.pdf
> + * ad7383/4-4 : https://www.analog.com/media/en/technical-documentation/data-sheets/ad7383-4-ad7384-4.pdf
>   */
>  
>  #include <linux/bitfield.h>
> @@ -29,7 +32,7 @@
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/iio/triggered_buffer.h>
>  
> -#define MAX_NUM_CHANNELS		2
> +#define MAX_NUM_CHANNELS		4
>  /* 2.5V internal reference voltage */
>  #define AD7380_INTERNAL_REF_MV		2500
>  
> @@ -106,27 +109,53 @@ static const struct iio_chan_spec name[] = {		\
>  	IIO_CHAN_SOFT_TIMESTAMP(2),			\
>  }
>  
> +#define DEFINE_AD7380_4_CHANNEL(name, bits, diff)	\
> +static const struct iio_chan_spec name[] = {		\
> +	AD7380_CHANNEL(0, bits, diff),			\
> +	AD7380_CHANNEL(1, bits, diff),			\
> +	AD7380_CHANNEL(2, bits, diff),			\
> +	AD7380_CHANNEL(3, bits, diff),			\
> +	IIO_CHAN_SOFT_TIMESTAMP(4),			\
> +}
> +
>  /* fully differential */
>  DEFINE_AD7380_2_CHANNEL(ad7380_channels, 16, 1);
>  DEFINE_AD7380_2_CHANNEL(ad7381_channels, 14, 1);
> +DEFINE_AD7380_4_CHANNEL(ad7380_4_channels, 16, 1);
> +DEFINE_AD7380_4_CHANNEL(ad7381_4_channels, 14, 1);
>  /* pseudo differential */
>  DEFINE_AD7380_2_CHANNEL(ad7383_channels, 16, 0);
>  DEFINE_AD7380_2_CHANNEL(ad7384_channels, 14, 0);
> +DEFINE_AD7380_4_CHANNEL(ad7383_4_channels, 16, 0);
> +DEFINE_AD7380_4_CHANNEL(ad7384_4_channels, 14, 0);
>  
>  static const char * const ad7380_2_channel_vcm_supplies[] = {
>  	"aina", "ainb",
>  };
>  
> +static const char * const ad7380_4_channel_vcm_supplies[] = {
> +	"aina", "ainb", "ainc", "aind",
> +};
> +
>  /* Since this is simultaneous sampling, we don't allow individual channels. */
>  static const unsigned long ad7380_2_channel_scan_masks[] = {
>  	GENMASK(1, 0),
>  	0
>  };
>  
> +static const unsigned long ad7380_4_channel_scan_masks[] = {
> +	GENMASK(3, 0),
> +	0
> +};
> +
>  static const struct ad7380_timing_specs ad7380_timing = {
>  	.t_csh_ns = 10,
>  };
>  
> +static const struct ad7380_timing_specs ad7380_4_timing = {
> +	.t_csh_ns = 20,
> +};
> +
>  static const struct ad7380_chip_info ad7380_chip_info = {
>  	.name = "ad7380",
>  	.channels = ad7380_channels,
> @@ -163,6 +192,42 @@ static const struct ad7380_chip_info ad7384_chip_info = {
>  	.timing_specs = &ad7380_timing,
>  };
>  
> +static const struct ad7380_chip_info ad7380_4_chip_info = {
> +	.name = "ad7380-4",
> +	.channels = ad7380_4_channels,
> +	.num_channels = ARRAY_SIZE(ad7380_4_channels),
> +	.available_scan_masks = ad7380_4_channel_scan_masks,
> +	.timing_specs = &ad7380_4_timing,
> +};
> +
> +static const struct ad7380_chip_info ad7381_4_chip_info = {
> +	.name = "ad7381-4",
> +	.channels = ad7381_4_channels,
> +	.num_channels = ARRAY_SIZE(ad7381_4_channels),
> +	.available_scan_masks = ad7380_4_channel_scan_masks,
> +	.timing_specs = &ad7380_4_timing,
> +};
> +
> +static const struct ad7380_chip_info ad7383_4_chip_info = {
> +	.name = "ad7383-4",
> +	.channels = ad7383_4_channels,
> +	.num_channels = ARRAY_SIZE(ad7383_4_channels),
> +	.vcm_supplies = ad7380_4_channel_vcm_supplies,
> +	.num_vcm_supplies = ARRAY_SIZE(ad7380_4_channel_vcm_supplies),
> +	.available_scan_masks = ad7380_4_channel_scan_masks,
> +	.timing_specs = &ad7380_4_timing,
> +};
> +
> +static const struct ad7380_chip_info ad7384_4_chip_info = {
> +	.name = "ad7384-4",
> +	.channels = ad7384_4_channels,
> +	.num_channels = ARRAY_SIZE(ad7384_4_channels),
> +	.vcm_supplies = ad7380_4_channel_vcm_supplies,
> +	.num_vcm_supplies = ARRAY_SIZE(ad7380_4_channel_vcm_supplies),
> +	.available_scan_masks = ad7380_4_channel_scan_masks,
> +	.timing_specs = &ad7380_4_timing,
> +};
> +
>  struct ad7380_state {
>  	const struct ad7380_chip_info *chip_info;
>  	struct spi_device *spi;
> @@ -514,6 +579,10 @@ static const struct of_device_id ad7380_of_match_table[] = {
>  	{ .compatible = "adi,ad7381", .data = &ad7381_chip_info },
>  	{ .compatible = "adi,ad7383", .data = &ad7383_chip_info },
>  	{ .compatible = "adi,ad7384", .data = &ad7384_chip_info },
> +	{ .compatible = "adi,ad7380-4", .data = &ad7380_4_chip_info },
> +	{ .compatible = "adi,ad7381-4", .data = &ad7381_4_chip_info },
> +	{ .compatible = "adi,ad7383-4", .data = &ad7383_4_chip_info },
> +	{ .compatible = "adi,ad7384-4", .data = &ad7384_4_chip_info },
>  	{ }
>  };
>  
> @@ -522,6 +591,10 @@ static const struct spi_device_id ad7380_id_table[] = {
>  	{ "ad7381", (kernel_ulong_t)&ad7381_chip_info },
>  	{ "ad7383", (kernel_ulong_t)&ad7383_chip_info },
>  	{ "ad7384", (kernel_ulong_t)&ad7384_chip_info },
> +	{ "ad7380-4", (kernel_ulong_t)&ad7380_4_chip_info },
> +	{ "ad7381-4", (kernel_ulong_t)&ad7381_4_chip_info },
> +	{ "ad7383-4", (kernel_ulong_t)&ad7383_4_chip_info },
> +	{ "ad7384-4", (kernel_ulong_t)&ad7384_4_chip_info },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(spi, ad7380_id_table);
> 


