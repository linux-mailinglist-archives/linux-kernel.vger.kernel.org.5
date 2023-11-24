Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C3C7F726B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 12:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345742AbjKXLIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 06:08:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345395AbjKXLIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 06:08:19 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F9AD5A
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 03:08:24 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6ce2ea3a944so1109316a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 03:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google; t=1700824103; x=1701428903; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NWJZ8vONLcSAJ3G4cErxj72gCXIFVoONPFfM9X+giv8=;
        b=bg06DIJRs8OJFLQeDDm1KKvYhiuGEKjFZG6DVle/1pjcVbFUpcSepTptSNrX/ignLf
         +vL+2P4ZG3jEhvSPpwChVO/AbQTR6JP2t2Xql3Xaz5oc8Ve8Ji46WaxInTKNFkJWM2qw
         QpQvR0Dx1Tax2cid8Ka2i4PyXgfJTUjopNQqgrfZrt1L3YfKgGQOUt5C8RiU0de4+eEt
         F+Og8Sjx9CE2qFaYewYTiKQgxFmFM/i3lcreurxLPvkYdSJXZKmcK7PFvFFYdq3V93aM
         EKHh4TaXY01xzrkgF8IZTxRLW86T5YjKezGDCZzcqjeFa9e1zISROxKiDhSYpR2vqyrr
         bLNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700824103; x=1701428903;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NWJZ8vONLcSAJ3G4cErxj72gCXIFVoONPFfM9X+giv8=;
        b=Kg6c/72lMIxGBSjA/5Y1qvMPOvDHIgGJaX/GLTmKAdcHz4TD4jxuXy3UKrz/fh/Hbt
         IcGjh6o4yhzg/0u5ojIW4bMC8aJLqhgB9CIKJCtvgt1OusxOp/qAvyqc70gtG/GrKg3D
         IXvePot29kSSeunu2zKyCocrmt/1PPyog3TJqJbuc2UmD2C9y5kXGngDnr93bew3w3US
         kVpCKK0Pd2h8StKbl5ePaN5LywNcgc3TjcG/khFg3O2UjPWJP2o1zCtdHNRH3G8OMoN1
         7Gjd/cUaABvtT04ZErZP2TLLejlcMw39mOWWmEpMCvoanuDsMJ57+r3EgMibIN7JBrPx
         D9Dw==
X-Gm-Message-State: AOJu0YyUDo9rosuI6fquaB0EM5qBnZ+8NITvreHxPkRUofIIqveYQJV4
        VmpdEYTf5mWAxKsLyo+wBIeP06BsojyZN/r4PA8ccw==
X-Google-Smtp-Source: AGHT+IGtDqJ8WmNg2weOU2NYFLICDF2tpOxqSCwpYNUOyngyl0wOFncI2eFNajZioTs0xDKrsG4mgcONeZpdX2IheCc=
X-Received: by 2002:a05:6871:7292:b0:1fa:cbf:88a3 with SMTP id
 mm18-20020a056871729200b001fa0cbf88a3mr355910oac.26.1700824103535; Fri, 24
 Nov 2023 03:08:23 -0800 (PST)
MIME-Version: 1.0
References: <20231124105116.5764-1-kimseer.paller@analog.com> <20231124105116.5764-2-kimseer.paller@analog.com>
In-Reply-To: <20231124105116.5764-2-kimseer.paller@analog.com>
From:   Crt Mori <cmo@melexis.com>
Date:   Fri, 24 Nov 2023 12:07:47 +0100
Message-ID: <CAKv63us8-R4ezWQMCobOshhDepsMRs-59th2ohkTdt2jcAaZBw@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] iio: frequency: admfm2000: New driver
To:     Kim Seer Paller <kimseer.paller@analog.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Crt Mori<cmo@melexis.com>

On Fri, 24 Nov 2023 at 11:51, Kim Seer Paller <kimseer.paller@analog.com> wrote:
>
> Dual microwave down converter module with input RF and LO frequency
> ranges from 0.5 to 32 GHz and an output IF frequency range from 0.1 to
> 8 GHz. It consists of a LNA, mixer, IF filter, DSA, and IF amplifier
> for each down conversion path.
>
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> ---
> V4 -> V5: Added missing return -ENODEV in setup function. Reordered variable
>           declarations in probe function.
> V1 -> V4: No changes.
>
>  MAINTAINERS                       |   1 +
>  drivers/iio/frequency/Kconfig     |  10 +
>  drivers/iio/frequency/Makefile    |   1 +
>  drivers/iio/frequency/admfm2000.c | 310 ++++++++++++++++++++++++++++++
>  4 files changed, 322 insertions(+)
>  create mode 100644 drivers/iio/frequency/admfm2000.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f1692ec68..d8630e490 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1253,6 +1253,7 @@ L:        linux-iio@vger.kernel.org
>  S:     Supported
>  W:     https://ez.analog.com/linux-software-drivers
>  F:     Documentation/devicetree/bindings/iio/frequency/adi,admfm2000.yaml
> +F:     drivers/iio/frequency/admfm2000.c
>
>  ANALOG DEVICES INC ADMV1013 DRIVER
>  M:     Antoniu Miclaus <antoniu.miclaus@analog.com>
> diff --git a/drivers/iio/frequency/Kconfig b/drivers/iio/frequency/Kconfig
> index 9e85dfa58..c455be7d4 100644
> --- a/drivers/iio/frequency/Kconfig
> +++ b/drivers/iio/frequency/Kconfig
> @@ -60,6 +60,16 @@ config ADF4377
>           To compile this driver as a module, choose M here: the
>           module will be called adf4377.
>
> +config ADMFM2000
> +       tristate "Analog Devices ADMFM2000 Dual Microwave Down Converter"
> +       depends on GPIOLIB
> +       help
> +         Say yes here to build support for Analog Devices ADMFM2000 Dual
> +         Microwave Down Converter.
> +
> +         To compile this driver as a module, choose M here: the
> +         module will be called admfm2000.
> +
>  config ADMV1013
>         tristate "Analog Devices ADMV1013 Microwave Upconverter"
>         depends on SPI && COMMON_CLK
> diff --git a/drivers/iio/frequency/Makefile b/drivers/iio/frequency/Makefile
> index b616c29b4..70d0e0b70 100644
> --- a/drivers/iio/frequency/Makefile
> +++ b/drivers/iio/frequency/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_AD9523) += ad9523.o
>  obj-$(CONFIG_ADF4350) += adf4350.o
>  obj-$(CONFIG_ADF4371) += adf4371.o
>  obj-$(CONFIG_ADF4377) += adf4377.o
> +obj-$(CONFIG_ADMFM2000) += admfm2000.o
>  obj-$(CONFIG_ADMV1013) += admv1013.o
>  obj-$(CONFIG_ADMV1014) += admv1014.o
>  obj-$(CONFIG_ADMV4420) += admv4420.o
> diff --git a/drivers/iio/frequency/admfm2000.c b/drivers/iio/frequency/admfm2000.c
> new file mode 100644
> index 000000000..351fb9044
> --- /dev/null
> +++ b/drivers/iio/frequency/admfm2000.c
> @@ -0,0 +1,310 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ADMFM2000 Dual Microwave Down Converter
> + *
> + * Copyright 2023 Analog Devices Inc.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
> +
> +#define ADMFM2000_MIXER_MODE           0
> +#define ADMFM2000_DIRECT_IF_MODE       1
> +#define ADMF20000_DSA_GPIOS            5
> +#define ADMF20000_MODE_GPIOS           2
> +#define ADMF20000_MAX_GAIN             0
> +#define ADMF20000_MIN_GAIN             -31000
> +#define ADMF20000_DEFAULT_GAIN         -0x20
> +
> +struct admfm2000_state {
> +       struct mutex                    lock; /* protect sensor state */
> +       struct gpio_descs               *sw_ch[2];
> +       struct gpio_descs               *dsa_gpios[2];
> +       u32                             gain[2];
> +};
> +
> +static int admfm2000_mode(struct iio_dev *indio_dev, u32 reg, u32 mode)
> +{
> +       struct admfm2000_state *st = iio_priv(indio_dev);
> +       DECLARE_BITMAP(values, 2);
> +
> +       switch (mode) {
> +       case ADMFM2000_MIXER_MODE:
> +               values[0] = (reg == 0) ? 1 : 2;
> +               gpiod_set_array_value_cansleep(st->sw_ch[reg]->ndescs,
> +                                              st->sw_ch[reg]->desc,
> +                                              NULL, values);
> +               break;
> +       case ADMFM2000_DIRECT_IF_MODE:
> +               values[0] = (reg == 0) ? 2 : 1;
> +               gpiod_set_array_value_cansleep(st->sw_ch[reg]->ndescs,
> +                                              st->sw_ch[reg]->desc,
> +                                              NULL, values);
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
> +static int admfm2000_attenuation(struct iio_dev *indio_dev, u32 chan,
> +                                u32 value)
> +{
> +       struct admfm2000_state *st = iio_priv(indio_dev);
> +       DECLARE_BITMAP(values, BITS_PER_TYPE(value));
> +
> +       values[0] = value;
> +
> +       gpiod_set_array_value_cansleep(st->dsa_gpios[chan]->ndescs,
> +                                      st->dsa_gpios[chan]->desc,
> +                                      NULL, values);
> +       return 0;
> +}
> +
> +static int admfm2000_read_raw(struct iio_dev *indio_dev,
> +                             struct iio_chan_spec const *chan, int *val,
> +                             int *val2, long mask)
> +{
> +       struct admfm2000_state *st = iio_priv(indio_dev);
> +       int gain;
> +
> +       switch (mask) {
> +       case IIO_CHAN_INFO_HARDWAREGAIN:
> +               mutex_lock(&st->lock);
> +               gain = ~(st->gain[chan->channel]) * -1000;
> +               *val = gain / 1000;
> +               *val2 = (gain % 1000) * 1000;
> +               mutex_unlock(&st->lock);
> +
> +               return  IIO_VAL_INT_PLUS_MICRO_DB;
> +       default:
> +               return -EINVAL;
> +       }
> +}
> +
> +static int admfm2000_write_raw(struct iio_dev *indio_dev,
> +                            struct iio_chan_spec const *chan, int val,
> +                            int val2, long mask)
> +{
> +       struct admfm2000_state *st = iio_priv(indio_dev);
> +       int gain, ret;
> +
> +       if (val < 0)
> +               gain = (val * 1000) - (val2 / 1000);
> +       else
> +               gain = (val * 1000) + (val2 / 1000);
> +
> +       if (gain > ADMF20000_MAX_GAIN || gain < ADMF20000_MIN_GAIN)
> +               return -EINVAL;
> +
> +       switch (mask) {
> +       case IIO_CHAN_INFO_HARDWAREGAIN:
> +               mutex_lock(&st->lock);
> +               st->gain[chan->channel] = ~((abs(gain) / 1000) & 0x1F);
> +
> +               ret = admfm2000_attenuation(indio_dev, chan->channel,
> +                                           st->gain[chan->channel]);
> +
> +               mutex_unlock(&st->lock);
> +               if (ret)
> +                       return ret;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
> +static int admfm2000_write_raw_get_fmt(struct iio_dev *indio_dev,
> +                                      struct iio_chan_spec const *chan,
> +                                      long mask)
> +{
> +       switch (mask) {
> +       case IIO_CHAN_INFO_HARDWAREGAIN:
> +               return IIO_VAL_INT_PLUS_MICRO_DB;
> +       default:
> +               return -EINVAL;
> +       }
> +}
> +
> +static const struct iio_info admfm2000_info = {
> +       .read_raw = &admfm2000_read_raw,
> +       .write_raw = &admfm2000_write_raw,
> +       .write_raw_get_fmt = &admfm2000_write_raw_get_fmt,
> +};
> +
> +#define ADMFM2000_CHAN(_channel) {                                     \
> +       .type = IIO_VOLTAGE,                                            \
> +       .output = 1,                                                    \
> +       .indexed = 1,                                                   \
> +       .channel = _channel,                                            \
> +       .info_mask_separate = BIT(IIO_CHAN_INFO_HARDWAREGAIN),          \
> +}
> +
> +static const struct iio_chan_spec admfm2000_channels[] = {
> +       ADMFM2000_CHAN(0),
> +       ADMFM2000_CHAN(1),
> +};
> +
> +static int admfm2000_channel_config(struct admfm2000_state *st,
> +                                   struct iio_dev *indio_dev)
> +{
> +       struct platform_device *pdev = to_platform_device(indio_dev->dev.parent);
> +       struct device *dev = &pdev->dev;
> +       struct fwnode_handle *child;
> +       u32 reg, mode;
> +       int ret;
> +
> +       device_for_each_child_node(dev, child) {
> +               ret = fwnode_property_read_u32(child, "reg", &reg);
> +               if (ret) {
> +                       fwnode_handle_put(child);
> +                       return dev_err_probe(dev, ret,
> +                                            "Failed to get reg property\n");
> +               }
> +
> +               if (reg >= indio_dev->num_channels) {
> +                       fwnode_handle_put(child);
> +                       return dev_err_probe(dev, -EINVAL, "reg bigger than: %d\n",
> +                                            indio_dev->num_channels);
> +               }
> +
> +               ret = fwnode_property_read_u32(child, "adi,mode", &mode);
> +               if (ret) {
> +                       fwnode_handle_put(child);
> +                       return dev_err_probe(dev, ret,
> +                                            "Failed to get mode property\n");
> +               }
> +
> +               if (mode >= 2) {
> +                       fwnode_handle_put(child);
> +                       return dev_err_probe(dev, -EINVAL, "mode bigger than: 1\n");
> +               }
> +
> +               ret = admfm2000_mode(indio_dev, reg, mode);
> +               if (ret) {
> +                       fwnode_handle_put(child);
> +                       return ret;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +static int admfm2000_setup(struct admfm2000_state *st,
> +                          struct iio_dev *indio_dev)
> +{
> +       struct platform_device *pdev = to_platform_device(indio_dev->dev.parent);
> +       struct device *dev = &pdev->dev;
> +
> +       st->sw_ch[0] = devm_gpiod_get_array(dev, "switch1", GPIOD_OUT_LOW);
> +       if (IS_ERR(st->sw_ch[0]))
> +               return dev_err_probe(dev, PTR_ERR(st->sw_ch[0]),
> +                                    "Failed to get gpios\n");
> +
> +       if (st->sw_ch[0]->ndescs != ADMF20000_MODE_GPIOS) {
> +               dev_err_probe(dev, -ENODEV, "%d GPIOs needed to operate\n",
> +                             ADMF20000_MODE_GPIOS);
> +               return -ENODEV;
> +       }
> +
> +       st->sw_ch[1] = devm_gpiod_get_array(dev, "switch2", GPIOD_OUT_LOW);
> +       if (IS_ERR(st->sw_ch[1]))
> +               return dev_err_probe(dev, PTR_ERR(st->sw_ch[1]),
> +                                    "Failed to get gpios\n");
> +
> +       if (st->sw_ch[1]->ndescs != ADMF20000_MODE_GPIOS) {
> +               dev_err_probe(dev, -ENODEV, "%d GPIOs needed to operate\n",
> +                             ADMF20000_MODE_GPIOS);
> +               return -ENODEV;
> +       }
> +
> +       st->dsa_gpios[0] = devm_gpiod_get_array(dev, "attenuation1",
> +                                               GPIOD_OUT_LOW);
> +       if (IS_ERR(st->dsa_gpios[0]))
> +               return dev_err_probe(dev, PTR_ERR(st->dsa_gpios[0]),
> +                                    "Failed to get gpios\n");
> +
> +       if (st->dsa_gpios[0]->ndescs != ADMF20000_DSA_GPIOS) {
> +               dev_err_probe(dev, -ENODEV, "%d GPIOs needed to operate\n",
> +                             ADMF20000_DSA_GPIOS);
> +               return -ENODEV;
> +       }
> +
> +       st->dsa_gpios[1] = devm_gpiod_get_array(dev, "attenuation2",
> +                                               GPIOD_OUT_LOW);
> +       if (IS_ERR(st->dsa_gpios[1]))
> +               return dev_err_probe(dev, PTR_ERR(st->dsa_gpios[1]),
> +                                    "Failed to get gpios\n");
> +
> +       if (st->dsa_gpios[1]->ndescs != ADMF20000_DSA_GPIOS) {
> +               dev_err_probe(dev, -ENODEV, "%d GPIOs needed to operate\n",
> +                             ADMF20000_DSA_GPIOS);
> +               return -ENODEV;
> +       }
> +
> +       return 0;
> +}
> +
> +static int admfm2000_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct admfm2000_state *st;
> +       struct iio_dev *indio_dev;
> +       int ret;
> +
> +       indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +       if (!indio_dev)
> +               return -ENOMEM;
> +
> +       st = iio_priv(indio_dev);
> +
> +       indio_dev->name = "admfm2000";
> +       indio_dev->num_channels = ARRAY_SIZE(admfm2000_channels);
> +       indio_dev->channels = admfm2000_channels;
> +       indio_dev->info = &admfm2000_info;
> +       indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +       st->gain[0] = ADMF20000_DEFAULT_GAIN;
> +       st->gain[1] = ADMF20000_DEFAULT_GAIN;
> +
> +       mutex_init(&st->lock);
> +
> +       ret = admfm2000_setup(st, indio_dev);
> +       if (ret)
> +               return ret;
> +
> +       ret = admfm2000_channel_config(st, indio_dev);
> +       if (ret)
> +               return ret;
> +
> +       return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static const struct of_device_id admfm2000_of_match[] = {
> +       { .compatible = "adi,admfm2000" },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, admfm2000_of_match);
> +
> +static struct platform_driver admfm2000_driver = {
> +       .driver = {
> +               .name = "admfm2000",
> +               .of_match_table = admfm2000_of_match,
> +       },
> +       .probe = admfm2000_probe,
> +};
> +module_platform_driver(admfm2000_driver);
> +
> +MODULE_AUTHOR("Kim Seer Paller <kimseer.paller@analog.com>");
> +MODULE_DESCRIPTION("ADMFM2000 Dual Microwave Down Converter");
> +MODULE_LICENSE("GPL");
> --
> 2.34.1
>
