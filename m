Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C057BF7BD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 11:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjJJJpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 05:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjJJJpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 05:45:23 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7FE93;
        Tue, 10 Oct 2023 02:45:19 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c189dabcc3so64531641fa.1;
        Tue, 10 Oct 2023 02:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696931117; x=1697535917; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l/qBEDnL1u2dQTbFvw89P6kT4AtOIC2NsWDvt/lq/VU=;
        b=GxS7HhknCZyyD9+0gOdv3e60OK2bwzwsZvXcD9dNV6PS+EFdKjtoaTWr8fUywLVLCs
         6bkkzb+VRSKgu1QknQjB+PS3K2Ca7nF5VTKhFIH4vrlSuYK7U+K2daOE6bdejveCUBCm
         S1xzaPrvJAeG/kJU6x6IPluUHZzeWwcW7BHbj5lpxkeSrSuWz+BdHRDBOVbavZVXWW4X
         iIg3eFXbuC/poB51F5BRmGS9uWYiRq1jXQavn3WDqmal2v+mznFyc7YZLXGivPxx+jPM
         eMW7o+k2S1JehL4i4BON8Xy0JBdNG6uMyBllKbMixnhNyCmhwxsu9YFdrAAP6rrZfDVL
         qhoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696931117; x=1697535917;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l/qBEDnL1u2dQTbFvw89P6kT4AtOIC2NsWDvt/lq/VU=;
        b=IohlslcuSt+wDAR9RccNE96VURxTL5txVivqa2sw6MfUkywTPr4vCIZZbIDP6QdBBV
         AuvdYANybJUFrMMdMXKuP8PyGb0M9MsW9ec9QVcpdntv44eAGItVCNrk8JZ9Ioocw4bz
         5F4foKKAM2lOmp2xyVCtvcbTbQiQhgROF8EltgO4xOcgxxtXD5nfye5kyV4/1tqiVz84
         b2+s43gR7ZT5VxdPcLrMzAt5vuHW2phl13KCryWssidO2KKToRXHPN87N5kwhEuVoQQV
         Uy9UHCndB3K1dN+t++Np/BkeImp3wlRcWa6GUlqd0qmBWpJhzm+5sdTEIi53/mk+UuFR
         H/pg==
X-Gm-Message-State: AOJu0Yy32uyVQ/vHj9lnzZrSM1IbXpnKnIZ9CChHDFD2uiSD7OGPHqPx
        cutGIZBAU6iqqhWF/lieOAE=
X-Google-Smtp-Source: AGHT+IGURrCq9x7WCrBfQMb8RbXjeUXmsx6TKHE9oCtovGBEdCzvj5Gy1hwvHFblJg3zgcGo8vPCxQ==
X-Received: by 2002:ac2:4c46:0:b0:500:b56d:e11a with SMTP id o6-20020ac24c46000000b00500b56de11amr16807742lfk.43.1696931117005;
        Tue, 10 Oct 2023 02:45:17 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f8:1500::7? (dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::7])
        by smtp.gmail.com with ESMTPSA id k15-20020a0565123d8f00b00500b561285bsm1612452lfv.292.2023.10.10.02.45.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 02:45:16 -0700 (PDT)
Message-ID: <ae210957-4a72-24b3-2f11-8d5824041e85@gmail.com>
Date:   Tue, 10 Oct 2023 12:45:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US, en-GB
To:     Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Gazzillo <paul@pgazz.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>
References: <20231008154857.24162-1-subhajit.ghosh@tweaklogic.com>
 <20231008154857.24162-3-subhajit.ghosh@tweaklogic.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH 2/2] iio: light: Add support for APDS9306 Light Sensor
In-Reply-To: <20231008154857.24162-3-subhajit.ghosh@tweaklogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/8/23 18:48, Subhajit Ghosh wrote:
> Driver support for Avago (Broadcom) APDS9306
> Ambient Light Sensor with als and clear channels.
> This driver exposes raw values for both the channels and
> processed(lux) values for the als channel.
> Support for both with or without hardware interrupt
> configurations are provided.
> 
> Datasheet at https://docs.broadcom.com/doc/AV02-4755EN
> 
> Signed-off-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>

Hi Subhajit,

To my eyes this driver looks nice. Just spotted two minor things.

> ---
>   drivers/iio/light/Kconfig    |   12 +
>   drivers/iio/light/Makefile   |    1 +
>   drivers/iio/light/apds9306.c | 1381 ++++++++++++++++++++++++++++++++++
>   3 files changed, 1394 insertions(+)
>   create mode 100644 drivers/iio/light/apds9306.c
> 
...

> +
> +static int apds9306_intg_time_set(struct apds9306_data *data, int val2)
> +{
> +	struct device *dev = data->dev;
> +	int ret, intg_old, gain_old, gain_new, gain_new_closest;
> +	bool ok;
> +
> +	if (!iio_gts_valid_time(&data->gts, val2)) {
> +		dev_err(dev, "Unsupported integration time %u\n", val2);
> +		return ret;
> +	}
> +
> +	intg_old = iio_gts_find_int_time_by_sel(&data->gts,
> +						data->intg_time_idx);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (intg_old == val2)
> +		return 0;
> +
> +	gain_old = iio_gts_find_gain_by_sel(&data->gts, data->gain_idx);
> +	if (gain_old < 0)
> +		return gain_old;
> +
> +	ret = iio_gts_find_new_gain_by_old_gain_time(&data->gts, gain_old,
> +				intg_old, val2, &gain_new);
> +	if (gain_new < 0) {
> +		dev_err(dev, "Unsupported gain with time\n");
> +		return gain_new;
> +	}
> +
> +	gain_new_closest = iio_find_closest_gain_low(&data->gts, gain_new, &ok);
> +	if (gain_new_closest < 0) {
> +		gain_new_closest = iio_gts_get_min_gain(&data->gts);
> +		if (gain_new_closest < 0)
> +			return gain_new_closest < 0;

Returning the truth value on purpose? :)

> +	}
> +	if (!ok)
> +		dev_dbg(dev, "Unable to find optimum gain, setting minimum");
> +
> +	ret = iio_gts_find_sel_by_int_time(&data->gts, val2);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = apds9306_intg_time_set_hw(data, ret);
> +	if (ret)
> +		return ret;
> +
> +	ret = iio_gts_find_sel_by_gain(&data->gts, gain_new_closest);
> +	if (ret < 0)
> +		return ret;
> +
> +	return apds9306_gain_set_hw(data, ret);
> +}

...

> +static int get_device_id_lux_per_count(struct apds9306_data *data)
> +{
> +	int ret, part_id;
> +
> +	ret = regmap_read(data->regmap, APDS9306_PART_ID, &part_id);
> +	if (ret)
> +		return ret;
> +
> +	if (part_id == apds9306_part_id_nlux_per_count[0].part_id)
> +		data->nlux_per_count =
> +			apds9306_part_id_nlux_per_count[0].nlux_per_count;
> +	else if (part_id == apds9306_part_id_nlux_per_count[1].part_id)
> +		data->nlux_per_count =
> +			apds9306_part_id_nlux_per_count[1].nlux_per_count;
> +	else
> +		return -ENXIO;

I think we should be able to differentiate between the IC variants by DT 
compatible. (Commented that on bindings patch). Not sure if we need to 
support cases where the sensor is instantiated without device-tree. I am 
not super happy when code requires the part-id to be known if we have 
separate compatibles for variants. Can we in dt-case just print a 
warning if the part-ID is not what we expect - and proceed assuming the 
nlux_per_count based on the DT information? (Sometimes we see new 
variants with same part-IDs - or many part-IDs with no SW changes 
needed. Hence maintaining the part-ID lists may be tedious). This is 
just some pondering though, no strong requirements from my side

> +
> +	return 0;
> +}
> +

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

