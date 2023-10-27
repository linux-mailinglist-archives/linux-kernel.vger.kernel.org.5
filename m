Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A967D9A3A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 15:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345949AbjJ0Nlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 09:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345688AbjJ0Nl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 09:41:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57FF1A6;
        Fri, 27 Oct 2023 06:41:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85B61C433C7;
        Fri, 27 Oct 2023 13:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698414086;
        bh=AL3A8bFN1zfoMmZfMsDpi1qxeV1lBiHx1wsVJN9VdIo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jpLAygDXnUNrH++Dpobibdj2orfeCfr77EE3/iX1VC8SH7eNbZIE5JAP+IC+Cgv0M
         G6iUq4xTR0pRUANjJ3mEzrkvpf1FG4gUw9w2DzzYWlD7P0QcCsneb2ZJxTPMfdMRmA
         dfb26dlhak1AeYbK0OFC69mvxlHXTxzg6sPe4/u5fKKzzJw+KQBBnhDiL2tqAo2fcP
         O2ndD8YcniCRxaEyixkF0mPH2P+fO60ErePd2WOW+KQ6eDpvuN1IkcsYjXclNGmp6R
         5b7MkSOtK/cECaGTl5q1OyeTx5V9uS2yI76tPtkGqXQqyUO0Z2fH5PzIuupjhSBA4L
         41VNhsZb29RUg==
Date:   Fri, 27 Oct 2023 14:41:23 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     linux-iio@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Phil Elwell <phil@raspberrypi.com>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 3/5] iio: pressure: bmp280: Rearrange vars in reverse
 xmas tree order
Message-ID: <20231027144123.4d371a33@jic23-huawei>
In-Reply-To: <bb63a996eb9c4555bf83471770f0169d2627e79c.1697994521.git.ang.iglesiasg@gmail.com>
References: <cover.1697994521.git.ang.iglesiasg@gmail.com>
        <bb63a996eb9c4555bf83471770f0169d2627e79c.1697994521.git.ang.iglesiasg@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Oct 2023 19:22:19 +0200
Angel Iglesias <ang.iglesiasg@gmail.com> wrote:

> Small cleanup reordering local variable declarations following reverse
> christmas tree convention.
> 
> Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied patches 1-3 to the togreg branch of iio.git.
I'll be rebasing that on rc1 once available.  In meantime, pushed out
as testing for 0-day to take a poke at it.

Thanks,

Jonathan

> 
> diff --git a/drivers/iio/pressure/bmp280-i2c.c b/drivers/iio/pressure/bmp280-i2c.c
> index b3e069730f97..34e3bc758493 100644
> --- a/drivers/iio/pressure/bmp280-i2c.c
> +++ b/drivers/iio/pressure/bmp280-i2c.c
> @@ -7,9 +7,9 @@
>  
>  static int bmp280_i2c_probe(struct i2c_client *client)
>  {
> -	struct regmap *regmap;
> -	const struct bmp280_chip_info *chip_info;
>  	const struct i2c_device_id *id = i2c_client_get_device_id(client);
> +	const struct bmp280_chip_info *chip_info;
> +	struct regmap *regmap;
>  
>  	chip_info = i2c_get_match_data(client);
>  
> diff --git a/drivers/iio/pressure/bmp280-spi.c b/drivers/iio/pressure/bmp280-spi.c
> index 2eed483a8cc4..433d6fac83c4 100644
> --- a/drivers/iio/pressure/bmp280-spi.c
> +++ b/drivers/iio/pressure/bmp280-spi.c
> @@ -14,8 +14,7 @@
>  static int bmp280_regmap_spi_write(void *context, const void *data,
>                                     size_t count)
>  {
> -	struct device *dev = context;
> -	struct spi_device *spi = to_spi_device(dev);
> +	struct spi_device *spi = to_spi_device(context);
>  	u8 buf[2];
>  
>  	memcpy(buf, data, 2);
> @@ -31,8 +30,7 @@ static int bmp280_regmap_spi_write(void *context, const void *data,
>  static int bmp280_regmap_spi_read(void *context, const void *reg,
>                                    size_t reg_size, void *val, size_t val_size)
>  {
> -	struct device *dev = context;
> -	struct spi_device *spi = to_spi_device(dev);
> +	struct spi_device *spi = to_spi_device(context);
>  
>  	return spi_write_then_read(spi, reg, reg_size, val, val_size);
>  }

