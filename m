Return-Path: <linux-kernel+bounces-2658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B1D81600F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 15:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 198CD2825B9
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 14:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7169A44C87;
	Sun, 17 Dec 2023 14:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyiUnJlk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50BC44C7A;
	Sun, 17 Dec 2023 14:59:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0671C433C8;
	Sun, 17 Dec 2023 14:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702825177;
	bh=KJ4jcR9KJKoqL94EuxV/7oCHCcyH7Qh+A7npvwuaOP8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hyiUnJlk1C7X/unySOxsuQM4FWJ+ylJlNpP4HllkdWFIVEF9rww3mSdT/jxuQWeeu
	 Qz7QaWe6G/8FQx7XV+iYqUnGud1cKG4LvlLjE7Kf6QXeeXAzZkL7wFHbrxVZsaCe9N
	 PvIMCSZHG1tzB2iGRkgem2waa7G/7ty2nAxjLWWgZPrs0oH9UfLnEzZDoHxhVG/NDu
	 odDrF9Hz0hflQCfKW7xhGNwK2UXHgvG5Vg4pzWnu7OxLFelEx/3MCvZG0U1DETRHeV
	 ZO9pcD/txZ5q1ZBfuyFIwO3LzYBsTtUAEBKNKwqf98tFrysQ72RRy4k1DLPLN88ZGY
	 6g8X/lD6d3rgQ==
Date: Sun, 17 Dec 2023 14:59:19 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <apw@canonical.com>, <joe@perches.com>, <dwaipayanray1@gmail.com>,
 <lukas.bulwahn@gmail.com>, <paul.cercueil@analog.com>,
 <Michael.Hennerich@analog.com>, <lars@metafoo.de>, <robh+dt@kernel.org>,
 <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
 <dan.carpenter@linaro.org>, <dlechner@baylibre.com>,
 <marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 05/15] iio: adc: ad7091r: Move generic AD7091R code
 to base driver and header file
Message-ID: <20231217145919.0af52cb2@jic23-huawei>
In-Reply-To: <6cab8108613aec0707c02587f5f6b9396fbd9831.1702746240.git.marcelo.schmitt1@gmail.com>
References: <cover.1702746240.git.marcelo.schmitt1@gmail.com>
	<6cab8108613aec0707c02587f5f6b9396fbd9831.1702746240.git.marcelo.schmitt1@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 16 Dec 2023 14:47:25 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> Some code generic to AD7091R devices such as channel definitions and
> event spec structs were in the AD7091R-5 driver.
> There was also some generic register definitions declared in the base
> driver which would make more sense to be in the header file.
> The device state struct will be needed for the ad7091r8 driver in a
> follow up patch so that ought to be moved to the header file as well.
> Lastly, a couple of regmap callback functions are also capable of
> abstracting characteristics of different AD7091R devices and those are
> now being exported to IIO_AD7091R name space.
> 
> Move AD7091R generic code either to the base driver or to the header
> file so both the ad7091r5 and the ad7091r8 driver can use those
> declaration in follow up patches.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Hi Marcelo

I'm going to stop here as can't apply next patch because of build warnings
and this one is hard to justify without the rest of the series.

So please just include this patch onwards in v5.

This looks fine to me btw.  I'll just comment on patches where I have
anything to add. If not they look fine.

Jonathan

> ---
>  drivers/iio/adc/ad7091r-base.c | 46 +++++++++++++++++-----------------
>  drivers/iio/adc/ad7091r-base.h | 42 ++++++++++++++++++++++++++++++-
>  drivers/iio/adc/ad7091r5.c     | 39 +++-------------------------
>  3 files changed, 68 insertions(+), 59 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7091r-base.c b/drivers/iio/adc/ad7091r-base.c
> index d3d287d3b953..0d1f544de07a 100644
> --- a/drivers/iio/adc/ad7091r-base.c
> +++ b/drivers/iio/adc/ad7091r-base.c
> @@ -15,14 +15,6 @@
>  
>  #include "ad7091r-base.h"
>  
> -#define AD7091R_REG_RESULT  0
> -#define AD7091R_REG_CHANNEL 1
> -#define AD7091R_REG_CONF    2
> -#define AD7091R_REG_ALERT   3
> -#define AD7091R_REG_CH_LOW_LIMIT(ch) ((ch) * 3 + 4)
> -#define AD7091R_REG_CH_HIGH_LIMIT(ch) ((ch) * 3 + 5)
> -#define AD7091R_REG_CH_HYSTERESIS(ch) ((ch) * 3 + 6)
> -
>  /* AD7091R_REG_RESULT */
>  #define AD7091R_REG_RESULT_CH_ID(x)	    (((x) >> 13) & 0x3)
>  #define AD7091R_REG_RESULT_CONV_RESULT(x)   ((x) & 0xfff)
> @@ -35,20 +27,26 @@
>  #define AD7091R_REG_CONF_MODE_MASK  \
>  	(AD7091R_REG_CONF_AUTO | AD7091R_REG_CONF_CMD)
>  
> -enum ad7091r_mode {
> -	AD7091R_MODE_SAMPLE,
> -	AD7091R_MODE_COMMAND,
> -	AD7091R_MODE_AUTOCYCLE,
> -};
> -
> -struct ad7091r_state {
> -	struct device *dev;
> -	struct regmap *map;
> -	struct regulator *vref;
> -	const struct ad7091r_chip_info *chip_info;
> -	enum ad7091r_mode mode;
> -	struct mutex lock; /*lock to prevent concurent reads */
> +const struct iio_event_spec ad7091r_events[] = {
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_RISING,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
> +				 BIT(IIO_EV_INFO_ENABLE),
> +	},
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_FALLING,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
> +				 BIT(IIO_EV_INFO_ENABLE),
> +	},
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_EITHER,
> +		.mask_separate = BIT(IIO_EV_INFO_HYSTERESIS),
> +	},
>  };
> +EXPORT_SYMBOL_NS_GPL(ad7091r_events, IIO_AD7091R);
>  
>  static int ad7091r_set_mode(struct ad7091r_state *st, enum ad7091r_mode mode)
>  {
> @@ -269,7 +267,7 @@ int ad7091r_probe(struct device *dev, const char *name,
>  }
>  EXPORT_SYMBOL_NS_GPL(ad7091r_probe, IIO_AD7091R);
>  
> -static bool ad7091r_writeable_reg(struct device *dev, unsigned int reg)
> +bool ad7091r_writeable_reg(struct device *dev, unsigned int reg)
>  {
>  	switch (reg) {
>  	case AD7091R_REG_RESULT:
> @@ -279,8 +277,9 @@ static bool ad7091r_writeable_reg(struct device *dev, unsigned int reg)
>  		return true;
>  	}
>  }
> +EXPORT_SYMBOL_NS_GPL(ad7091r_writeable_reg, IIO_AD7091R);
>  
> -static bool ad7091r_volatile_reg(struct device *dev, unsigned int reg)
> +bool ad7091r_volatile_reg(struct device *dev, unsigned int reg)
>  {
>  	switch (reg) {
>  	case AD7091R_REG_RESULT:
> @@ -290,6 +289,7 @@ static bool ad7091r_volatile_reg(struct device *dev, unsigned int reg)
>  		return false;
>  	}
>  }
> +EXPORT_SYMBOL_NS_GPL(ad7091r_volatile_reg, IIO_AD7091R);
>  
>  const struct regmap_config ad7091r_regmap_config = {
>  	.reg_bits = 8,
> diff --git a/drivers/iio/adc/ad7091r-base.h b/drivers/iio/adc/ad7091r-base.h
> index 509748aef9b1..1d30eeb46bcc 100644
> --- a/drivers/iio/adc/ad7091r-base.h
> +++ b/drivers/iio/adc/ad7091r-base.h
> @@ -8,8 +8,43 @@
>  #ifndef __DRIVERS_IIO_ADC_AD7091R_BASE_H__
>  #define __DRIVERS_IIO_ADC_AD7091R_BASE_H__
>  
> +#define AD7091R_REG_RESULT  0
> +#define AD7091R_REG_CHANNEL 1
> +#define AD7091R_REG_CONF    2
> +#define AD7091R_REG_ALERT   3
> +
> +#define AD7091R_REG_CH_LOW_LIMIT(ch) ((ch) * 3 + 4)
> +#define AD7091R_REG_CH_HIGH_LIMIT(ch) ((ch) * 3 + 5)
> +#define AD7091R_REG_CH_HYSTERESIS(ch) ((ch) * 3 + 6)
> +
> +#define AD7091R_CHANNEL(idx, bits, ev, num_ev) {			\
> +	.type = IIO_VOLTAGE,						\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
> +	.indexed = 1,							\
> +	.channel = idx,							\
> +	.event_spec = ev,						\
> +	.num_event_specs = num_ev,					\
> +	.scan_type.storagebits = 16,					\
> +	.scan_type.realbits = bits,					\
> +}
> +
>  struct device;
> -struct ad7091r_state;
> +
> +enum ad7091r_mode {
> +	AD7091R_MODE_SAMPLE,
> +	AD7091R_MODE_COMMAND,
> +	AD7091R_MODE_AUTOCYCLE,
> +};
> +
> +struct ad7091r_state {
> +	struct device *dev;
> +	struct regmap *map;
> +	struct regulator *vref;
> +	const struct ad7091r_chip_info *chip_info;
> +	enum ad7091r_mode mode;
> +	struct mutex lock; /*lock to prevent concurent reads */
> +};
>  
>  struct ad7091r_chip_info {
>  	unsigned int num_channels;
> @@ -17,10 +52,15 @@ struct ad7091r_chip_info {
>  	unsigned int vref_mV;
>  };
>  
> +extern const struct iio_event_spec ad7091r_events[3];
> +
>  extern const struct regmap_config ad7091r_regmap_config;
>  
>  int ad7091r_probe(struct device *dev, const char *name,
>  		const struct ad7091r_chip_info *chip_info,
>  		struct regmap *map, int irq);
>  
> +bool ad7091r_volatile_reg(struct device *dev, unsigned int reg);
> +bool ad7091r_writeable_reg(struct device *dev, unsigned int reg);
> +
>  #endif /* __DRIVERS_IIO_ADC_AD7091R_BASE_H__ */
> diff --git a/drivers/iio/adc/ad7091r5.c b/drivers/iio/adc/ad7091r5.c
> index 2f048527b7b7..9d3ccfca94ec 100644
> --- a/drivers/iio/adc/ad7091r5.c
> +++ b/drivers/iio/adc/ad7091r5.c
> @@ -12,42 +12,11 @@
>  
>  #include "ad7091r-base.h"
>  
> -static const struct iio_event_spec ad7091r5_events[] = {
> -	{
> -		.type = IIO_EV_TYPE_THRESH,
> -		.dir = IIO_EV_DIR_RISING,
> -		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
> -				 BIT(IIO_EV_INFO_ENABLE),
> -	},
> -	{
> -		.type = IIO_EV_TYPE_THRESH,
> -		.dir = IIO_EV_DIR_FALLING,
> -		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
> -				 BIT(IIO_EV_INFO_ENABLE),
> -	},
> -	{
> -		.type = IIO_EV_TYPE_THRESH,
> -		.dir = IIO_EV_DIR_EITHER,
> -		.mask_separate = BIT(IIO_EV_INFO_HYSTERESIS),
> -	},
> -};
> -
> -#define AD7091R_CHANNEL(idx, bits, ev, num_ev) { \
> -	.type = IIO_VOLTAGE, \
> -	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
> -	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
> -	.indexed = 1, \
> -	.channel = idx, \
> -	.event_spec = ev, \
> -	.num_event_specs = num_ev, \
> -	.scan_type.storagebits = 16, \
> -	.scan_type.realbits = bits, \
> -}
>  static const struct iio_chan_spec ad7091r5_channels_irq[] = {
> -	AD7091R_CHANNEL(0, 12, ad7091r5_events, ARRAY_SIZE(ad7091r5_events)),
> -	AD7091R_CHANNEL(1, 12, ad7091r5_events, ARRAY_SIZE(ad7091r5_events)),
> -	AD7091R_CHANNEL(2, 12, ad7091r5_events, ARRAY_SIZE(ad7091r5_events)),
> -	AD7091R_CHANNEL(3, 12, ad7091r5_events, ARRAY_SIZE(ad7091r5_events)),
> +	AD7091R_CHANNEL(0, 12, ad7091r_events, ARRAY_SIZE(ad7091r_events)),
> +	AD7091R_CHANNEL(1, 12, ad7091r_events, ARRAY_SIZE(ad7091r_events)),
> +	AD7091R_CHANNEL(2, 12, ad7091r_events, ARRAY_SIZE(ad7091r_events)),
> +	AD7091R_CHANNEL(3, 12, ad7091r_events, ARRAY_SIZE(ad7091r_events)),
>  };
>  
>  static const struct iio_chan_spec ad7091r5_channels_noirq[] = {


