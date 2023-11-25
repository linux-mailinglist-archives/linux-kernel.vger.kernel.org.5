Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45DE7F8CB3
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 18:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjKYRVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 12:21:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjKYRVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 12:21:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10371127
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 09:21:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 302DBC433C7;
        Sat, 25 Nov 2023 17:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700932895;
        bh=Io8wGWK+gGlHLld3dtwwXCMsjBV7UlvA/1mtFc9Febo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mbtWk4hshEnIKg5QeVoynnl1YgpQ3KkzrcdF9r3DpKGj0oP1mcEZkJwupMHvW76SM
         fplLctDha0YKhUnEsk3MYaDNZTHtyJK+0ILC26/tK2nBIikQbRX8v+zsr4AIcwIejA
         lbfC7sDhE5SjxjvvKXhN0jEOioox1hPnl8teyBkxhwmIO9JUrax3Li7G/h7jodHE9g
         CzbkhoXjBOOX51JQxlLzv0vihHlCxFHf4+d4Jsayfo1byAdDmJmRKRxj1qYCAGRbrr
         p4821X81zV4VbCwejsZZVwVSzMZSVa+DMT23YeH5wTMVDltyOr2GXN5gagk+0AAczL
         Vb6LVbxkfsL4Q==
Date:   Sat, 25 Nov 2023 17:21:25 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     mitrutzceclan <mitrutzceclan@gmail.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org,
        linux-gpio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Leonard =?UTF-8?B?R8O2aHJz?= <l.goehrs@pengutronix.de>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Haibo Chen <haibo.chen@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Ceclan Dumitru <dumitru.ceclan@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] iio: adc: ad7173: add AD7173 driver
Message-ID: <20231125172125.1b0f1ae7@jic23-huawei>
In-Reply-To: <20231123152331.5751-2-user@HYB-hhAwRlzzMZb>
References: <20231123152331.5751-1-user@HYB-hhAwRlzzMZb>
        <20231123152331.5751-2-user@HYB-hhAwRlzzMZb>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2023 17:23:22 +0200
mitrutzceclan <mitrutzceclan@gmail.com> wrote:

> From: Dumitru Ceclan <mitrutzceclan@gmail.com>
> 
> The AD7173 family offer a complete integrated Sigma-Delta ADC solution
> which can be used in high precision, low noise single channel
> applications or higher speed multiplexed applications. The Sigma-Delta
> ADC is intended primarily for measurement of signals close to DC but also
> delivers outstanding performance with input bandwidths out to ~10kHz.
> 
> 
> Reviewed-by: Michael Walle <michael@walle.cc> # for gpio-regmap
> Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>

Hi.

A few minor things from me.

thanks,

Jonathan

> new file mode 100644
> index 000000000000..ca307d406cee
> --- /dev/null
> +++ b/drivers/iio/adc/ad7173.c
> @@ -0,0 +1,962 @@

...

> +
> +static int ad7173_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val, int *val2, long info)
> +{
> +	struct ad7173_state *st = iio_priv(indio_dev);
> +	struct ad7173_channel *ch = &st->channels[chan->address];
> +	unsigned int reg;
> +	int ret;
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = ad_sigma_delta_single_conversion(indio_dev, chan, val);
> +		if (ret < 0)
> +			return ret;
> +
> +		/* disable channel after single conversion */
> +		ret = ad_sd_write_reg(&st->sd, AD7173_REG_CH(chan->address), 2, 0);
> +		if (ret < 0)
> +			return ret;
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		if (chan->type == IIO_TEMP) {
> +			*val = 250000000;
> +			*val2 = 800273203; /* (2^24 * 477) / 10 */
> +			return IIO_VAL_FRACTIONAL;
> +		} else {
> +			*val = ad7173_get_ref_voltage_milli(st, ch->cfg.ref_sel);
> +			*val2 = chan->scan_type.realbits - !!(ch->cfg.bipolar);
> +			return IIO_VAL_FRACTIONAL_LOG2;
> +		}
> +	case IIO_CHAN_INFO_OFFSET:
> +		if (chan->type == IIO_TEMP) {
> +			*val = -874379;
> +		} else {
> +			if (ch->cfg.bipolar)
> +				*val = -BIT(chan->scan_type.realbits - 1);
> +			else
> +				*val = 0;
Ideally if the channel isn't bipolar, don't expose the offset at all. Default
assumption if there is no such file is 0 offset. 
If that's fiddly to do then fine to keep the file though.

> +		}
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		reg = st->channels[chan->address].cfg.odr;
> +
> +		*val = st->info->sinc5_data_rates[reg] / MILLI;
> +		*val2 = (st->info->sinc5_data_rates[reg] % MILLI) * (MICRO/MILLI);
> +
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	}
> +	return -EINVAL;


...


> +static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
> +{
> +	struct ad7173_channel *channels_st_priv_arr, *chan_st_priv;
> +	struct ad7173_state *st = iio_priv(indio_dev);
> +	struct device *dev = indio_dev->dev.parent;
> +	struct iio_chan_spec *chan_arr, *chan;
> +	struct fwnode_handle *child;
> +	unsigned int ain[2], chan_index = 0;
> +	unsigned int num_channels;
> +	const char *ref_label;
> +	u32 ref_sel;
> +	int i, ret;
> +
> +	st->regulators[0].supply = ad7173_ref_sel_str[AD7173_SETUP_REF_SEL_EXT_REF];
> +	st->regulators[1].supply = ad7173_ref_sel_str[AD7173_SETUP_REF_SEL_EXT_REF2];
> +	st->regulators[2].supply = ad7173_ref_sel_str[AD7173_SETUP_REF_SEL_AVDD1_AVSS];
> +
> +	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(st->regulators),
> +				      st->regulators);

If only some of them are supplied, the driver works fine as long as no channel is using them?
If so should probably get the optionally then check for availability of the ones you
want.  I'm sure someone will just wire up ref.  Incidentally, ref2 isn't there for all chips
I think, so we should not get it on the ones where it can't exist.

> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get regulators\n");
> +
> +	ret = regulator_bulk_enable(ARRAY_SIZE(st->regulators), st->regulators);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable regulators\n");
> +
> +	ret = devm_add_action_or_reset(dev, ad7173_disable_regulators, st);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to add regulators disable action\n");
> +
> +	num_channels = device_get_child_node_count(dev);
> +
> +	if (st->info->has_temp)
> +		num_channels++;
> +
> +	if (num_channels == 0)
> +		return 0;

Isn't it all a bit pointless if this happens?  So maybe an error makes more sense?

> +	st->num_channels = num_channels;
> +
> +	chan_arr = devm_kcalloc(dev, sizeof(*chan_arr), num_channels, GFP_KERNEL);
> +	if (!chan_arr)
> +		return -ENOMEM;
> +
> +	channels_st_priv_arr = devm_kcalloc(dev, num_channels,
> +					    sizeof(*channels_st_priv_arr),
> +					    GFP_KERNEL);
> +	if (!channels_st_priv_arr)
> +		return -ENOMEM;
> +
> +	indio_dev->channels = chan_arr;
> +	indio_dev->num_channels = num_channels;
> +	st->channels = channels_st_priv_arr;
> +
> +	if (st->info->has_temp) {
> +		chan_arr[chan_index] = ad7173_temp_iio_channel_template;
> +		chan_st_priv = &channels_st_priv_arr[chan_index];
> +		chan_st_priv->ain =
> +			AD7173_CH_ADDRESS(chan_arr[chan_index].channel, chan_arr[chan_index].channel2);
> +		chan_st_priv->cfg.bipolar = false;
> +		chan_st_priv->cfg.input_buf = true;
> +		chan_st_priv->cfg.ref_sel = AD7173_SETUP_REF_SEL_INT_REF;
> +		st->adc_mode |= AD7173_ADC_MODE_REF_EN;
> +
> +		chan_index++;
> +	}
> +
> +	device_for_each_child_node(dev, child) {
> +		chan = &chan_arr[chan_index];
> +		chan_st_priv = &channels_st_priv_arr[chan_index];
> +		ret = fwnode_property_read_u32_array(child, "diff-channels",
> +						     ain, ARRAY_SIZE(ain));
> +		if (ret) {
> +			fwnode_handle_put(child);
> +			return ret;
> +		}
> +
> +		if (ain[0] >= st->info->num_inputs ||
> +		    ain[1] >= st->info->num_inputs) {
> +			fwnode_handle_put(child);
> +			return dev_err_probe(dev, -EINVAL,
> +				"Input pin number out of range for pair (%d %d).", ain[0], ain[1]);
> +		}
> +
> +		ref_sel = AD7173_SETUP_REF_SEL_INT_REF;
> +		ret = fwnode_property_read_string(child, "adi,reference-select", &ref_label);
> +		if (!ret) {
> +			for (i = 0; i < ARRAY_SIZE(ad7173_ref_sel_str); i++)
> +				if (strcmp(ref_label, ad7173_ref_sel_str[i]) == 0) {
> +					ref_sel = i;
> +					break;
> +				}
> +
> +			if (i == ARRAY_SIZE(ad7173_ref_sel_str))
Missing fwnode_handle_put(child). Same for other error paths in th device_for_each_child_node() 
loop. I wonder if that can get cleaned up with the cleanup.h magic.  Anyhow, that's a question
for another day.

> +				return dev_err_probe(dev, -EINVAL, "Invalid channel reference name %s", ref_label);


> +		} else if (ret != -EINVAL) {
Up to you, but you could be lazier and set ref_label = ref_sel_str[AD7173_SETUP_REF_SEL_INT_REF] before
trying to read it then don't bother handling the fwnode property read error at all
That's common practice when there is a default.

It would unnecessarily run the string match when the property wasn't there, but that's not too bad
for the code simplification it would give I think

> +			return dev_err_probe(dev, ret, "Invalid channel reference value");
> +		}
> +
> +		ret = ad7173_get_ref_voltage_milli(st, (u8)ref_sel);
> +		if (ret < 0)
> +			return dev_err_probe(dev, ret,
> +					     "Cannot use reference %u", ref_sel);
> +		if (ref_sel == AD7173_SETUP_REF_SEL_EXT_REF2 &&
> +		    st->info->id != AD7173_ID)
> +			return dev_err_probe(dev, -EINVAL, "External reference 2 is only available on ad7173-8");

Why all the way down here?  I'd do this a few lines earlier so we haven't already used the bonkers
value.

> +		if (ref_sel == AD7173_SETUP_REF_SEL_INT_REF)
> +			st->adc_mode |= AD7173_ADC_MODE_REF_EN;
> +		chan_st_priv->cfg.ref_sel = ref_sel;
> +
> +		*chan = ad7173_channel_template;
> +		chan->address = chan_index;
> +		chan->scan_index = chan_index;
> +		chan->channel = ain[0];
> +		chan->channel2 = ain[1];
> +		chan->differential = true;
> +
> +		chan_st_priv->ain = AD7173_CH_ADDRESS(ain[0], ain[1]);
> +		chan_st_priv->chan_reg = chan_index;
> +		chan_st_priv->cfg.input_buf = true;
> +		chan_st_priv->cfg.odr = 0;
> +
> +		chan_st_priv->cfg.bipolar = fwnode_property_read_bool(child, "bipolar");
> +		if (chan_st_priv->cfg.bipolar)
> +			chan->info_mask_separate |= BIT(IIO_CHAN_INFO_OFFSET);
> +
> +		chan_index++;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ad7173_probe(struct spi_device *spi)
> +{
> +	struct ad7173_state *st;
> +	struct iio_dev *indio_dev;
> +	struct device *dev = &spi->dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	st->info = device_get_match_data(dev);
> +	if (!st->info)
> +		return -ENODEV;
> +
> +	ida_init(&st->cfg_slots_status);
> +	ret = devm_add_action_or_reset(dev, ad7173_ida_destroy, st);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->name = st->info->name;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &ad7173_info;
> +
> +	spi->mode = SPI_MODE_3;
> +
> +	ad7173_sigma_delta_info.num_slots = st->info->num_configs;
> +	ret = ad_sd_init(&st->sd, indio_dev, spi, &ad7173_sigma_delta_info);
> +	if (ret)
> +		return ret;
> +
> +	spi_set_drvdata(spi, indio_dev);

Used?  I'm not immediately seeing where. If not, don't set it.

Thanks,

Jonathan
