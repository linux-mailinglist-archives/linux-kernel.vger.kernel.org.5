Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCEE80BCD1
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 20:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbjLJTyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 14:54:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjLJTy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 14:54:29 -0500
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52F1EB;
        Sun, 10 Dec 2023 11:54:35 -0800 (PST)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1fadb9ac169so2542210fac.0;
        Sun, 10 Dec 2023 11:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702238075; x=1702842875; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UPp4yKEaAWdytVTqUpZr+pPVhI0zoTY0pxI9MBYHNxA=;
        b=cyzNBQbyZrUyy/jPAYG1G/+wpPgoEodDF+H2CeUVuf0cIVfgkiM0Flz5U9CtbpsgRh
         kEljBUL6rSlLW6mgkW5tQCZZqrOY+flkoTwq9rKlAeCA/7Z+j1tJ/TH0sHnRE+HlAdEl
         WYwel8OXijEokQYQ0NblwET5+QpFpD/bAMN//d7fDh3Qp3b7Wr/5UnOm0RDvHDhtUAS9
         R132j5TAHayPmRACBl5x5oX8Yr29AS/5SE0mJrena/PyfXVjsz1DQKK/9m7uJXKg07Y/
         MWdYOfIrqq7c8ebaXIGFBn+cEF3D6FRfhP3VaKjKu3VtmZbrXKtu98q/kuCaUSc19FQG
         0HtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702238075; x=1702842875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UPp4yKEaAWdytVTqUpZr+pPVhI0zoTY0pxI9MBYHNxA=;
        b=Im0Zt1ctgYi0SDDAl91EedECXjKRlHbzhlU5NSsXFqO8gDjZ8MRio/cbY0fd2WzsBw
         Gf51Hjp9zLv/0621Okw8gVz4zV2m8C+fqlSishzFJDBjoO+cNnTBZK+v2pkGp1YreBk8
         t0nDEXGdJsGBEZJlBtFLZi/Q7gNaBZqWYm2ZDwJDfTzIUZHV39j+qbPQ1UdYeulKPha1
         LJkVorp2cOM2UiyTxmQaV2mZpiF2BdFr7irfu584RvmbF1/ZQ9EWgjKSxrLDPVauBghf
         Jf3OmSbhf3dzJOcmInc/0+6d4+JU2TkX/WHIVFQwVQdt2oF5vMoqXr1wQ80VKE8+2Bgw
         Oy8Q==
X-Gm-Message-State: AOJu0YwlnAvgCicL3Mlu03mYSCZ52NfXAQHlD3PJd07KM7eESLkg5qlm
        rH6xTJu/2Ltvffb++M7h03w=
X-Google-Smtp-Source: AGHT+IG3bEQ3kHwnZsuIXhLrD5c8QYSu3vSfsvw6JhgAbiTRiQR+noKaum9eawl0qytFWUfr5r3TkQ==
X-Received: by 2002:a05:6870:c093:b0:1fb:75a:6d23 with SMTP id c19-20020a056870c09300b001fb075a6d23mr3904651oad.74.1702238075055;
        Sun, 10 Dec 2023 11:54:35 -0800 (PST)
Received: from localhost ([2804:30c:95c:8600:5b2d:e35b:5f45:dc84])
        by smtp.gmail.com with ESMTPSA id f1-20020a6547c1000000b005c68da96d7dsm4285330pgs.38.2023.12.10.11.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 11:54:34 -0800 (PST)
Date:   Sun, 10 Dec 2023 16:54:21 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Marcelo Schmitt <marcelo.schmitt@analog.com>, apw@canonical.com,
        joe@perches.com, dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
        paul.cercueil@analog.com, Michael.Hennerich@analog.com,
        lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        dan.carpenter@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 12/13] iio: adc: Add support for AD7091R-8
Message-ID: <ZXYXbYyb6sYbJQqE@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1701971344.git.marcelo.schmitt1@gmail.com>
 <0dd8b9682728b07a30877fcb37335b5055d046ff.1701971344.git.marcelo.schmitt1@gmail.com>
 <20231210123343.2695a9dc@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231210123343.2695a9dc@jic23-huawei>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

Thank you for all comments to this set.
Will do the changes and send v4.

Thanks,
Marcelo

On 12/10, Jonathan Cameron wrote:
> On Thu, 7 Dec 2023 15:42:56 -0300
> Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:
> 
> > Add support for Analog Devices AD7091R-2, AD7091R-4, and AD7091R-8
> > low power 12-Bit SAR ADCs with SPI interface.
> > Extend ad7091r-base driver so it can be used by the AD7091R-8 driver.
> > 
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> 
> A few trivial things inline.
> Otherwise looks pretty good to me.
> 
> Jonathan
> > diff --git a/drivers/iio/adc/ad7091r8.c b/drivers/iio/adc/ad7091r8.c
> > new file mode 100644
> > index 000000000000..8dc0f784913b
> > --- /dev/null
> > +++ b/drivers/iio/adc/ad7091r8.c
> > @@ -0,0 +1,261 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Analog Devices AD7091R8 12-bit SAR ADC driver
> > + *
> > + * Copyright 2023 Analog Devices Inc.
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/module.h>
> > +#include <linux/regmap.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/spi/spi.h>
> > +
> > +#include "ad7091r-base.h"
> > +
> > +#define AD7091R8_REG_ADDR_MSK				GENMASK(15, 11)
> > +#define AD7091R8_RD_WR_FLAG_MSK				BIT(10)
> > +#define AD7091R8_REG_DATA_MSK				GENMASK(9, 0)
> > +
> > +#define AD7091R2_DEV_NAME				"ad7091r-2"
> > +#define AD7091R4_DEV_NAME				"ad7091r-4"
> > +#define AD7091R8_DEV_NAME				"ad7091r-8"
> Not seeing any advantage in these macros.  It will be more readable to just
> have the strings inline where the macros are currently used.
> 
> > +static int ad7091r8_gpio_setup(struct ad7091r_state *st)
> > +{
> > +	st->convst_gpio = devm_gpiod_get(st->dev, "adi,conversion-start",
> > +					 GPIOD_OUT_LOW);
> > +	if (IS_ERR(st->convst_gpio))
> > +		return dev_err_probe(st->dev, PTR_ERR(st->convst_gpio),
> > +				     "Error getting convst GPIO\n");
> > +
> > +	st->reset_gpio =  devm_gpiod_get_optional(st->dev, "reset",
> > +						  GPIOD_OUT_HIGH);
> > +	if (IS_ERR(st->reset_gpio))
> > +		return PTR_ERR(st->reset_gpio);
> Maybe a dev_err_probe() here as well both for consistency and for the
> debug info that gets stashed if it's EPROBE_DEFER
> > +
> > +	if (st->reset_gpio) {
> > +		fsleep(20);
> > +		gpiod_set_value_cansleep(st->reset_gpio, 0);
> > +	}
> > +
> > +	return 0;
> > +}
> 
> > +
> > +static struct ad7091r_init_info ad7091r2_init_info = {
> > +	.info_no_irq = AD7091R_SPI_CHIP_INFO(2),
> > +	.regmap_config = &ad7091r2_reg_conf,
> > +	.ad7091r_regmap_init = &ad7091r8_regmap_init,
> > +	.ad7091r_setup = &ad7091r8_gpio_setup
> > +};
> > +
> > +static struct ad7091r_init_info ad7091r4_init_info = {
> > +	.irq_info = AD7091R_SPI_CHIP_INFO_IRQ(4),
> > +	.info_no_irq = AD7091R_SPI_CHIP_INFO(4),
> > +	.regmap_config = &ad7091r4_reg_conf,
> > +	.ad7091r_regmap_init = &ad7091r8_regmap_init,
> > +	.ad7091r_setup = &ad7091r8_gpio_setup
> > +};
> > +
> > +static struct ad7091r_init_info ad7091r8_init_info = {
> > +	.irq_info = AD7091R_SPI_CHIP_INFO_IRQ(8),
> > +	.info_no_irq = AD7091R_SPI_CHIP_INFO(8),
> > +	.regmap_config = &ad7091r8_reg_conf,
> > +	.ad7091r_regmap_init = &ad7091r8_regmap_init,
> > +	.ad7091r_setup = &ad7091r8_gpio_setup
> > +};
> > +
> > +static int ad7091r8_spi_probe(struct spi_device *spi)
> > +{
> > +	const struct spi_device_id *id = spi_get_device_id(spi);
> > +	const struct ad7091r_init_info *init_info;
> > +
> > +	init_info = spi_get_device_match_data(spi);
> > +	if (!init_info)
> > +		return -EINVAL;
> > +
> > +	return ad7091r_probe(&spi->dev, id->name, init_info, NULL, spi->irq);
> id->name isn't generally a good idea because we end up with lots of odd corner
> cases if the of_device_id and spi_device_id tables get out of sync - which
> can happen if fallback compatibles get used.
> 
> Normal way round this is just put the naming of the device in the
> info structure.  Costs a little storage, but makes the code simpler
> and less probe to odd corner cases.  Also, I think you already have it
> in there!
> 
> > +}
> > +
> > +static const struct of_device_id ad7091r8_of_match[] = {
> > +	{ .compatible = "adi,ad7091r2", .data = &ad7091r2_init_info },
> > +	{ .compatible = "adi,ad7091r4", .data = &ad7091r4_init_info },
> > +	{ .compatible = "adi,ad7091r8", .data = &ad7091r8_init_info },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, ad7091r8_of_match);
> > +
> > +static const struct spi_device_id ad7091r8_spi_id[] = {
> > +	{ "ad7091r2", (kernel_ulong_t)&ad7091r2_init_info },
> > +	{ "ad7091r4", (kernel_ulong_t)&ad7091r4_init_info },
> > +	{ "ad7091r8", (kernel_ulong_t)&ad7091r8_init_info },
> > +	{}
> Trivial but be consistent on spacing for these terminators.  I like a space, so
> { } but I don't mind if an author prefers {} as long as they are consistent!
> 
> > +};
> > +MODULE_DEVICE_TABLE(spi, ad7091r8_spi_id);
> 
