Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C42575E199
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 13:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjGWLYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 07:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjGWLYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 07:24:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130141AD;
        Sun, 23 Jul 2023 04:24:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1C5B60C81;
        Sun, 23 Jul 2023 11:24:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E405C433C8;
        Sun, 23 Jul 2023 11:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690111448;
        bh=22RHarx/As4wnIsJKNvcFLjt6RcLAE88avggr8K+qJE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=V+TAGnDgXYhFuU7/81H7Nlg/xdZpGFBWlptxq5aIicfpEcjhwE2X5yKMFC1c9c0gV
         uUSEs8TKooeN9c6Nh+XLM0k0TC1ZqERRJ6Or+s2tDrtnGah6d+70Dwd3m/u2HFig6O
         y7aa9ipy7gFuhe5N0q1PW/slmWNm5HcUUMjeqxXJqhbwHrSJ69NBXeovEql2MDQU3i
         OBDFJp2c+Nw9IA/Q4Bp7OOJoHU5F2XXoVrkhSXYMuzKOJhbTeJp4Z9gljhVUsBQ1Ua
         o2IpLZDiP4BcztGxJ4/JL5Lo8iZ9Z3ep9YrUGMNR4LYNv5XlylaeWs/KWup7l3shOP
         UId8r2nSThkRQ==
Date:   Sun, 23 Jul 2023 12:24:07 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Kim Seer Paller <kimseer.paller@analog.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: amplifiers: ad8366: add support for HMC792A
 Attenuator
Message-ID: <20230723122407.56c8352a@jic23-huawei>
In-Reply-To: <20230721121038.183404-1-kimseer.paller@analog.com>
References: <20230721121038.183404-1-kimseer.paller@analog.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jul 2023 20:10:38 +0800
Kim Seer Paller <kimseer.paller@analog.com> wrote:

> This change adds support for the HMC792A Digital Attenuator. The
> HMC792A is a broadband 6-bit GaAs MMIC Digital Attenuator operating
> from DC to 6.0 GHz with 15.75 dB attenuation control range in 0.25 dB steps.
> 
> Datasheet link:
>   https://www.analog.com/media/en/technical-documentation/data-sheets/hmc792a.pdf
Should be part of the tag block as
Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/hmc792a.pdf

I tidied that up whilst applying.

Applied to the togreg branch of iio.git and pushed out as testing for
all the normal reasons.

Thanks,

Jonathan

> 
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> ---
>  drivers/iio/amplifiers/Kconfig  |  1 +
>  drivers/iio/amplifiers/ad8366.c | 15 +++++++++++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/drivers/iio/amplifiers/Kconfig b/drivers/iio/amplifiers/Kconfig
> index f217a2a1e..b54fe0173 100644
> --- a/drivers/iio/amplifiers/Kconfig
> +++ b/drivers/iio/amplifiers/Kconfig
> @@ -18,6 +18,7 @@ config AD8366
>  	    AD8366 Dual-Digital Variable Gain Amplifier (VGA)
>  	    ADA4961 BiCMOS RF Digital Gain Amplifier (DGA)
>  	    ADL5240 Digitally controlled variable gain amplifier (VGA)
> +	    HMC792A 0.25 dB LSB GaAs MMIC 6-Bit Digital Attenuator
>  	    HMC1119 0.25 dB LSB, 7-Bit, Silicon Digital Attenuator
>  
>  	  To compile this driver as a module, choose M here: the
> diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
> index 8d8c8ea94..31564afb1 100644
> --- a/drivers/iio/amplifiers/ad8366.c
> +++ b/drivers/iio/amplifiers/ad8366.c
> @@ -5,6 +5,7 @@
>   *   AD8366 Dual-Digital Variable Gain Amplifier (VGA)
>   *   ADA4961 BiCMOS RF Digital Gain Amplifier (DGA)
>   *   ADL5240 Digitally controlled variable gain amplifier (VGA)
> + *   HMC792A 0.25 dB LSB GaAs MMIC 6-Bit Digital Attenuator
>   *   HMC1119 0.25 dB LSB, 7-Bit, Silicon Digital Attenuator
>   *
>   * Copyright 2012-2019 Analog Devices Inc.
> @@ -28,6 +29,7 @@ enum ad8366_type {
>  	ID_AD8366,
>  	ID_ADA4961,
>  	ID_ADL5240,
> +	ID_HMC792,
>  	ID_HMC1119,
>  };
>  
> @@ -64,6 +66,10 @@ static struct ad8366_info ad8366_infos[] = {
>  		.gain_min = -11500,
>  		.gain_max = 20000,
>  	},
> +	[ID_HMC792] = {
> +		.gain_min = -15750,
> +		.gain_max = 0,
> +	},
>  	[ID_HMC1119] = {
>  		.gain_min = -31750,
>  		.gain_max = 0,
> @@ -90,6 +96,7 @@ static int ad8366_write(struct iio_dev *indio_dev,
>  	case ID_ADL5240:
>  		st->data[0] = (ch_a & 0x3F);
>  		break;
> +	case ID_HMC792:
>  	case ID_HMC1119:
>  		st->data[0] = ch_a;
>  		break;
> @@ -127,6 +134,9 @@ static int ad8366_read_raw(struct iio_dev *indio_dev,
>  		case ID_ADL5240:
>  			gain = 20000 - 31500 + code * 500;
>  			break;
> +		case ID_HMC792:
> +			gain = -1 * code * 500;
> +			break;
>  		case ID_HMC1119:
>  			gain = -1 * code * 250;
>  			break;
> @@ -176,6 +186,9 @@ static int ad8366_write_raw(struct iio_dev *indio_dev,
>  	case ID_ADL5240:
>  		code = ((gain - 500 - 20000) / 500) & 0x3F;
>  		break;
> +	case ID_HMC792:
> +		code = (abs(gain) / 500) & 0x3F;
> +		break;
>  	case ID_HMC1119:
>  		code = (abs(gain) / 250) & 0x7F;
>  		break;
> @@ -261,6 +274,7 @@ static int ad8366_probe(struct spi_device *spi)
>  		break;
>  	case ID_ADA4961:
>  	case ID_ADL5240:
> +	case ID_HMC792:
>  	case ID_HMC1119:
>  		st->reset_gpio = devm_gpiod_get_optional(&spi->dev, "reset", GPIOD_OUT_HIGH);
>  		if (IS_ERR(st->reset_gpio)) {
> @@ -314,6 +328,7 @@ static const struct spi_device_id ad8366_id[] = {
>  	{"ad8366",  ID_AD8366},
>  	{"ada4961", ID_ADA4961},
>  	{"adl5240", ID_ADL5240},
> +	{"hmc792a", ID_HMC792},
>  	{"hmc1119", ID_HMC1119},
>  	{}
>  };
> 
> base-commit: f7e3a1bafdea735050dfde00523cf505dc7fd309

