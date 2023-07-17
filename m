Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E69F755BDB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 08:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjGQGiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 02:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjGQGiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 02:38:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A3F93;
        Sun, 16 Jul 2023 23:38:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 275CB60F5D;
        Mon, 17 Jul 2023 06:38:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE6BBC433C7;
        Mon, 17 Jul 2023 06:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689575888;
        bh=C3jRACdteb4/FJI80ETxr0hg06nuLiMOWlWqtcyyR88=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=qbSlPk4UFm5zuVpO6zjcXmheQkuQ7VBPv8x/2t6tJ8kndEi0RTVBQ9fyb1O99+wz7
         8nN0z7eObRyzLX0L8+YcmlRr4zmRj4EltFwAgcvI2ipxWoNH2FZxKIKE1q2rZ6h4BZ
         wVhDwDoasBXGpf24aIYMKUyjRi8T0Zx4KRSiXVjHOld5DOfugrt+46f5gtBU4MEyLo
         CIUsNLCDqAHbnZPvIYs5rKdt4foNDRJvfOZSFd4LIdsSicTDpj6elb6H1qqltTRKYm
         TIH8ItBJj/r8+aKyhX9BSvYBa5MlMADs4sAfn6rXFkIRqaabAMtGZUZDaSCxM14rfQ
         svcAFm0OYIpWg==
Message-ID: <bd3890e4-3880-b292-5b9f-e9443185681c@kernel.org>
Date:   Mon, 17 Jul 2023 08:38:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/2] iio: add mcp4728 I2C DAC driver
Content-Language: en-US
To:     Andrea Collamati <andrea.collamati@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        Angelo Dureghello <angelo.dureghello@timesys.com>,
        Fabio Estevam <festevam@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1689541455.git.andrea.collamati@gmail.com>
 <75145a12-a85e-e553-d32f-3212357c4a7e@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <75145a12-a85e-e553-d32f-3212357c4a7e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/07/2023 23:26, Andrea Collamati wrote:
> mcp4728 is a 12-bit quad channel DAC with I2C interface.
> 
> support for:
>   * per-channel gain
>   * per-channel power state
>   * per-channel power down mode control
>   * per-channel vref selection internal/vdd
>   * store current state to on-chip EEPROM
> 
> Signed-off-by: Andrea Collamati <andrea.collamati@gmail.com>
> ---

What changed? Are you saying you ignored entire review you got?

>  drivers/iio/dac/Kconfig   |  12 +
>  drivers/iio/dac/Makefile  |   1 +
>  drivers/iio/dac/mcp4728.c | 635 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 648 insertions(+)
>  create mode 100644 drivers/iio/dac/mcp4728.c
> 
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index 3acd9c3f388e..fa1516f6a285 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -389,6 +389,18 @@ config MCP4725
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called mcp4725.
>  
> +config MCP4728
> +	tristate "MCP4728 DAC driver"
> +	depends on I2C
> +	help
> +	  Say Y here if you want to build a driver for the Microchip
> +	  MCP4728 quad channel, 12-bit digital-to-analog converter (DAC)
> +	  with I2C interface.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called mcp4728.
> +
> +

Why two blank lines?

>  config MCP4922
>  	tristate "MCP4902, MCP4912, MCP4922 DAC driver"
>  	depends on SPI
> diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
> index addd97a78838..5b2bac900d5a 100644

...

> +
> +static void mcp4728_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct mcp4728_data *data = iio_priv(indio_dev);
> +
> +	iio_device_unregister(indio_dev);
> +	regulator_disable(data->vdd_reg);
> +}
> +
> +static const struct i2c_device_id mcp4728_id[] = { { "mcp4728", MCP4728 }, {} };
> +MODULE_DEVICE_TABLE(i2c, mcp4728_id);

Yeah, my feedback was ignored.

That's not how it works. Anyway, I doubt that it should be a new driver.

If Jonathan agrees to have new/duplicated drivers, then fine with me,
but then don't ignore the comments. Instead:

It seems my previous comments were not fully addressed. Maybe my
feedback got lost between the quotes, maybe you just forgot to apply it.
Please go back to the previous discussion and either implement all
requested changes or keep discussing them.

Best regards,
Krzysztof

