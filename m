Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170DF7CA1D4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 10:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjJPIkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 04:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjJPIkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 04:40:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1321C9B;
        Mon, 16 Oct 2023 01:40:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25172C433C7;
        Mon, 16 Oct 2023 08:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697445600;
        bh=rmw2Gyr5SU67GW0eQyC6iyRURFy4AfyL0xIkvkWfRY0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nNvyszDkNJr4kRPfkbDuwIZGqxPZDCQ1R3vKY3QUff4HzYB2OJrTkfRTSUurx1I0h
         ekHc7kV+qD0AI0tf0GV+b7mSBFjmVNjQghNdIgNU9N8dyb3HuKWSrvIQQPAwLf58c1
         Jt1geBvW+eMx7WECbhW6KADtZAIvaF6DsKbcJirW14AAie443WCFbDul/KxgxcpWny
         sKsxDcQwJO+nmovpC6miqrR8MmM991Dgr1L0QJGetYKvFWtnqNzTHEm7fnyKkBR9Y9
         yPBiFNE5KfZ9NjHHaIuedWaZ4tIlBSx2xtsLPmsbXcqMOMT8Er8esB1gLfbe4R/wE2
         1DyKRcoUxl6fA==
Date:   Mon, 16 Oct 2023 09:40:18 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     linux-iio@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
        linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Uwe =?UTF-8?B?S2xlaW5l?= =?UTF-8?B?LUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 3/5] iio: pressure: bmp280: Rearrange vars in reverse
 xmas tree order
Message-ID: <20231016094018.6f89eee9@jic23-huawei>
In-Reply-To: <7db5fe65a78513137206ae6b33abb1e48d356fbf.1697381932.git.ang.iglesiasg@gmail.com>
References: <cover.1697381932.git.ang.iglesiasg@gmail.com>
        <7db5fe65a78513137206ae6b33abb1e48d356fbf.1697381932.git.ang.iglesiasg@gmail.com>
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

On Sun, 15 Oct 2023 17:16:25 +0200
Angel Iglesias <ang.iglesiasg@gmail.com> wrote:

> Small cleanup reordering local variable declarations following reverse
> christmas tree convention.
> 
> Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index 6089f3f9d8f4..ea02a623bb58 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -766,8 +766,8 @@ static const struct iio_info bmp280_info = {
>  
>  static int bmp280_chip_config(struct bmp280_data *data)
>  {
> -	u8 osrs = FIELD_PREP(BMP280_OSRS_TEMP_MASK, data->oversampling_temp + 1) |
> -		  FIELD_PREP(BMP280_OSRS_PRESS_MASK, data->oversampling_press + 1);
> +	u8 osrs = FIELD_PREP(BMP280_OSRS_PRESS_MASK, data->oversampling_press + 1) |
> +		  FIELD_PREP(BMP280_OSRS_TEMP_MASK, data->oversampling_temp + 1);

For fields within a register, don't bother.
Normally the order is dictated by someone reading the fields on a datasheet.  
Feels like reorganzing them is just noise to me.

The rest look like good little tidy ups to me.

>  	int ret;
>  
>  	ret = regmap_write_bits(data->regmap, BMP280_REG_CTRL_MEAS,
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

