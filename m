Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71E0790BCC
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 14:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236809AbjICMDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 08:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjICMC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 08:02:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C7B124;
        Sun,  3 Sep 2023 05:02:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6257260FE5;
        Sun,  3 Sep 2023 12:02:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39096C433C7;
        Sun,  3 Sep 2023 12:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693742575;
        bh=IARWO2CvVToxsSCUDjp8lPSg5tlAnXweQ6KMfcoO2Zw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QiwDnxX3jVQj6X3DIqoCEAxS44BRbqmg+yb63es9GGwqrxw+Mg11jC/qEQihJkhNt
         GDszElrGBgdE7v+F2jdI9XyF7cRxObM+gwZ5gHKypbPoOBoWXyG/SkowuHxGD6oy+n
         VCj/s3xak+2tukrLUb9BX65Umz3BqSAkX3lvPSwTTSga8nRCcL21PxSvgd8dJ+cSfH
         G9koyUKNCYp+jw8jn4Uc/XhzHBYh+IX1frsYpCeCpad9ao4ScJcTivIhxZQAPtZXV2
         UETM1PjcDa7i+zupbTq+e16TLG+HVdRbaUolS7KevA4Q6nxPJK3SG/jJtCZMM3f2Y1
         L/a/W6x56+T1w==
Date:   Sun, 3 Sep 2023 13:03:23 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5p?= =?UTF-8?B?Zw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.au@gmail.com>
Subject: Re: [PATCH] iio: adc: ti-adc081c: Simplify probe()
Message-ID: <20230903130323.58281418@jic23-huawei>
In-Reply-To: <20230902162633.50546-1-biju.das.jz@bp.renesas.com>
References: <20230902162633.50546-1-biju.das.jz@bp.renesas.com>
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

On Sat,  2 Sep 2023 17:26:33 +0100
Biju Das <biju.das.jz@bp.renesas.com> wrote:

> Simpilfy probe() by replacing of_device_get_match_data() and id lookup for
> retrieving match data by using i2c_get_match_data() by making similar
> OF/I2C/ACPI match tables.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Applied to the togreg branch of iio.git and pushed out as testing
for all the normal reasons.

Thanks

Jonathan

> ---
>  drivers/iio/adc/ti-adc081c.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-adc081c.c b/drivers/iio/adc/ti-adc081c.c
> index 50c450e7a55f..6c2cb3dabbbf 100644
> --- a/drivers/iio/adc/ti-adc081c.c
> +++ b/drivers/iio/adc/ti-adc081c.c
> @@ -154,7 +154,6 @@ static void adc081c_reg_disable(void *reg)
>  
>  static int adc081c_probe(struct i2c_client *client)
>  {
> -	const struct i2c_device_id *id = i2c_client_get_device_id(client);
>  	struct iio_dev *iio;
>  	struct adc081c *adc;
>  	const struct adcxx1c_model *model;
> @@ -163,10 +162,7 @@ static int adc081c_probe(struct i2c_client *client)
>  	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA))
>  		return -EOPNOTSUPP;
>  
> -	if (dev_fwnode(&client->dev))
> -		model = device_get_match_data(&client->dev);
> -	else
> -		model = &adcxx1c_models[id->driver_data];
> +	model = i2c_get_match_data(client);
>  
>  	iio = devm_iio_device_alloc(&client->dev, sizeof(*adc));
>  	if (!iio)
> @@ -207,9 +203,9 @@ static int adc081c_probe(struct i2c_client *client)
>  }
>  
>  static const struct i2c_device_id adc081c_id[] = {
> -	{ "adc081c", ADC081C },
> -	{ "adc101c", ADC101C },
> -	{ "adc121c", ADC121C },
> +	{ "adc081c", (kernel_ulong_t)&adcxx1c_models[ADC081C] },
> +	{ "adc101c", (kernel_ulong_t)&adcxx1c_models[ADC101C] },
> +	{ "adc121c", (kernel_ulong_t)&adcxx1c_models[ADC121C] },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, adc081c_id);

