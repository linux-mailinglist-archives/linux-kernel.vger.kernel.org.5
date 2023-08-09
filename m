Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD3677531C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 08:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjHIGrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 02:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbjHIGrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 02:47:17 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB2310CF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 23:47:16 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99bed101b70so915894166b.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 23:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691563635; x=1692168435;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+MtZc2heVIWbXbNWpa/Si+kE6sYMT+Tukei7xEg5+rk=;
        b=AKyvjX3wA3c6lvFb/ywbQVHN7qVEsv8W7MPoel2fHLosX2l5rLnGaA5J6CcOU0Qy/F
         5GRpTZxtNgneAoDENny+aoA/3HzsYIbLHZSN8ZA+Z4EL6jqGO1aOodysNLH72f/k3/ad
         8zYutNMa+ixfTLVpIVlEDj1iIHLmhySw0l42pirts6FcOs4L4yimxHfHb1z8Kh/nbDlE
         t8JfIP/wEEjI/RPUfHYUyqJbv6uIJJNSp/7GDdHF/3yF4Zvgymg4hWfV2ozglisZMAKf
         E0gQEMa6ZSHu2OeChafWy2a0ng0U+p5vaireRSlJZ1DOFSUb0H1wnD2kEbPoKz/IeAnZ
         MfyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691563635; x=1692168435;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+MtZc2heVIWbXbNWpa/Si+kE6sYMT+Tukei7xEg5+rk=;
        b=W8IWxhEhcaF1hxIheQYirKk9u5o0dDzAVYAO13VeujNfhqvA6PwO22E+LIq7VuozSM
         vLoJINdfYBTHFAGIjlU4ysD26vW488ck0uDpPGyrswrIaRQq5NfjfxoWb11bUJ6dqRYZ
         0Nv0Sq87y0CrSkq+bUZh+aIgGUMnpDEF0JWPl4M+LwOv/U+UJl4RRl6F2hgJnqPLhQjQ
         dexx7dln1y4zfy3MXJRoYsVyLmkBQvPJCc+X4WrIJq+duHcei1PwqJw5BIzl5uYQI7oW
         VnmLu7ekb+NylwxP7cQX0/QnSKN0Q0o2XwHfuCroFB2z1wSTV01fxv4QoRaEimtpT0Da
         G7gA==
X-Gm-Message-State: AOJu0YyLQX2elOKg7XwBWquRto4O6t9xVCJPvCrDgn2reZypYsjUQ4PV
        +4iz4J+nhGk1aB+Q+5qbRe10Aw==
X-Google-Smtp-Source: AGHT+IEjApZFphBKxhRxKAreuKoB66ieF8S0BI+QBoeQ6XFCS4XpbGF/e9PZKPovDuufqz0Mu2f9hQ==
X-Received: by 2002:a17:907:a041:b0:993:f12a:39ce with SMTP id gz1-20020a170907a04100b00993f12a39cemr1366049ejc.15.1691563634928;
        Tue, 08 Aug 2023 23:47:14 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id x14-20020a1709064bce00b0098f33157e7dsm7562999ejv.82.2023.08.08.23.47.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 23:47:14 -0700 (PDT)
Message-ID: <065fbe51-928c-4728-efc2-bde87cd48cb3@linaro.org>
Date:   Wed, 9 Aug 2023 08:47:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 2/2] Input: cs40l50 - Initial support for Cirrus Logic
 CS40L50
Content-Language: en-US
To:     James Ogletree <james.ogletree@cirrus.com>,
        dmitry.torokhov@gmail.com
Cc:     Fred Treven <fred.treven@cirrus.com>,
        Ben Bright <ben.bright@cirrus.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Peng Fan <peng.fan@nxp.com>, Jean Delvare <jdelvare@suse.de>,
        Jeff LaBundy <jeff@labundy.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Eddie James <eajames@linux.ibm.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Jerome Neanne <jneanne@baylibre.com>, patches@cirrus.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230808172511.665787-1-james.ogletree@cirrus.com>
 <20230808172511.665787-2-james.ogletree@cirrus.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230808172511.665787-2-james.ogletree@cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/2023 19:25, James Ogletree wrote:
> Introduce support for Cirrus Logic Device CS40L50: a
> haptics driver with waveform memory DSP and closed-loop
> algorithms.
> 
> Change-Id: I468e8f726e81072ebea19b2dfbe23ca775fedc97

Please run scripts/checkpatch.pl and fix reported warnings. Some
warnings can be ignored, but the code here looks like it needs a fix.
Feel free to get in touch if the warning is not clear.

> Signed-off-by: James Ogletree <james.ogletree@cirrus.com>
> ---
>  MAINTAINERS                      |    2 +
>  drivers/input/misc/Kconfig       |   33 +
>  drivers/input/misc/Makefile      |    3 +
>  drivers/input/misc/cs40l50-i2c.c |   67 ++
>  drivers/input/misc/cs40l50-spi.c |   67 ++
>  drivers/input/misc/cs40l50.c     | 1013 ++++++++++++++++++++++++++++++
>  include/linux/input/cs40l50.h    |  321 ++++++++++
>  7 files changed, 1506 insertions(+)
>  create mode 100644 drivers/input/misc/cs40l50-i2c.c
>  create mode 100644 drivers/input/misc/cs40l50-spi.c
>  create mode 100644 drivers/input/misc/cs40l50.c
>  create mode 100644 include/linux/input/cs40l50.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 016e5ff3b831..f1d913166166 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2089,6 +2089,8 @@ L:	patches@Qopensource.cirrus.com
>  S:	Supported
>  T:	git https://github.com/CirrusLogic/linux-drivers.git
>  F:	Documentation/devicetree/bindings/input/cirrus,cs40l50.yaml
> +F:	drivers/input/misc/cs40l*
> +F:	include/linux/input/cs40l*
>  
>  ARM/CLKDEV SUPPORT
>  M:	Russell King <linux@armlinux.org.uk>
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index c47eecc6f83b..fa0bdd23f87d 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -140,6 +140,39 @@ config INPUT_BMA150
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called bma150.
>  
> +config INPUT_CS40L50
> +	tristate "Cirrus Logic CS40L50 Haptic Driver support"
> +	select CS_DSP
> +	select REGMAP_IRQ
> +	help
> +	  Say Y here to enable support for CS40L50 boosted haptic
> +	  driver.
> +
> +	  To compile the driver as a module choose M here: the module
> +	  will be called cs40l50_core.
> +
> +config INPUT_CS40L50_I2C
> +	tristate "Support I2C bus connection"
> +	depends on INPUT_CS40L50 && I2C
> +	select REGMAP_I2C
> +	help
> +	  Say Y here if you have Cirrus Logic's CS40L50 connected
> +	  to an I2C bus.
> +
> +	  To compile the driver as a module choose M here: the
> +	  module will be called cs40l50_i2c
> +
> +config INPUT_CS40L50_SPI
> +	tristate "Support SPI bus connection"
> +	depends on INPUT_CS40L50 && SPI
> +	select REGMAP_SPI
> +	help
> +	  Say Y here if you have Cirrus Logic's CS40L50 connected
> +	  to a SPI bus.
> +
> +	  To compile the driver as a module choose M here: the
> +	  module will be called cs40l50_spi.
> +
>  config INPUT_E3X0_BUTTON
>  	tristate "NI Ettus Research USRP E3xx Button support."
>  	default n
> diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
> index 04296a4abe8e..77f34a33c364 100644
> --- a/drivers/input/misc/Makefile
> +++ b/drivers/input/misc/Makefile
> @@ -28,6 +28,9 @@ obj-$(CONFIG_INPUT_CMA3000)		+= cma3000_d0x.o
>  obj-$(CONFIG_INPUT_CMA3000_I2C)		+= cma3000_d0x_i2c.o
>  obj-$(CONFIG_INPUT_COBALT_BTNS)		+= cobalt_btns.o
>  obj-$(CONFIG_INPUT_CPCAP_PWRBUTTON)	+= cpcap-pwrbutton.o
> +obj-$(CONFIG_INPUT_CS40L50)		+= cs40l50.o
> +obj-$(CONFIG_INPUT_CS40L50_I2C)		+= cs40l50-i2c.o
> +obj-$(CONFIG_INPUT_CS40L50_SPI)		+= cs40l50-spi.o
>  obj-$(CONFIG_INPUT_DA7280_HAPTICS)	+= da7280.o
>  obj-$(CONFIG_INPUT_DA9052_ONKEY)	+= da9052_onkey.o
>  obj-$(CONFIG_INPUT_DA9055_ONKEY)	+= da9055_onkey.o
> diff --git a/drivers/input/misc/cs40l50-i2c.c b/drivers/input/misc/cs40l50-i2c.c
> new file mode 100644
> index 000000000000..bab07debdaa9
> --- /dev/null
> +++ b/drivers/input/misc/cs40l50-i2c.c
> @@ -0,0 +1,67 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * CS40L50 Advanced Haptic Driver with Waveform Memory DSP
> + * and Closed-Loop Algorithms
> + *
> + * Copyright 2023 Cirrus Logic, Inc.
> + *
> + */
> +#include <linux/i2c.h>
> +#include <linux/input/cs40l50.h>
> +
> +static const struct i2c_device_id cs40l50_id_i2c[] = {
> +	{"cs40l50", 0},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, cs40l50_id_i2c);
> +
> +static const struct of_device_id cs40l50_of_match[] = {
> +	{ .compatible = "cirrus,cs40l50" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, cs40l50_of_match);
> +
> +static int cs40l50_i2c_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct cs40l50_private *cs40l50;
> +
> +	cs40l50 = devm_kzalloc(dev, sizeof(struct cs40l50_private), GFP_KERNEL);

sizeof(*)

> +	if (!cs40l50)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(client, cs40l50);
> +
> +	cs40l50->regmap = devm_regmap_init_i2c(client, &cs40l50_regmap);
> +	if (IS_ERR(cs40l50->regmap))
> +		return dev_err_probe(cs40l50->dev, PTR_ERR(cs40l50->regmap),
> +				"Failed to initialize register map\n");
> +
> +	cs40l50->dev = dev;
> +	cs40l50->irq = client->irq;
> +
> +	return cs40l50_probe(cs40l50);
> +}
> +
> +static void cs40l50_i2c_remove(struct i2c_client *client)
> +{
> +	struct cs40l50_private *cs40l50 = i2c_get_clientdata(client);
> +
> +	cs40l50_remove(cs40l50);
> +}
> +
> +static struct i2c_driver cs40l50_i2c_driver = {
> +	.driver = {
> +		.name = "cs40l50",
> +		.of_match_table = cs40l50_of_match,
> +	},
> +	.id_table = cs40l50_id_i2c,
> +	.probe_new = cs40l50_i2c_probe,
> +	.remove = cs40l50_i2c_remove,
> +};
> +
> +module_i2c_driver(cs40l50_i2c_driver);
> +
> +MODULE_DESCRIPTION("CS40L50 I2C Driver");
> +MODULE_AUTHOR("James Ogletree, Cirrus Logic Inc. <james.ogletree@cirrus.com>");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/input/misc/cs40l50-spi.c b/drivers/input/misc/cs40l50-spi.c
> new file mode 100644
> index 000000000000..dbaa185b6bbd
> --- /dev/null
> +++ b/drivers/input/misc/cs40l50-spi.c
> @@ -0,0 +1,67 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * CS40L50 Advanced Haptic Driver with Waveform Memory DSP
> + * and Closed-Loop Algorithms
> + *
> + * Copyright 2023 Cirrus Logic, Inc.
> + *
> + */
> +#include <linux/spi/spi.h>
> +#include <linux/input/cs40l50.h>
> +
> +static const struct spi_device_id cs40l50_id_spi[] = {
> +	{"cs40l50", 0},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(spi, cs40l50_id_spi);
> +
> +static const struct of_device_id cs40l50_of_match[] = {
> +	{ .compatible = "cirrus,cs40l50" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, cs40l50_of_match);
> +
> +static int cs40l50_spi_probe(struct spi_device *spi)
> +{
> +	struct cs40l50_private *cs40l50;
> +	struct device *dev = &spi->dev;
> +
> +	cs40l50 = devm_kzalloc(dev, sizeof(struct cs40l50_private), GFP_KERNEL);

sizeof(*)
In all other places as well.


...


> +
> +int cs40l50_probe(struct cs40l50_private *cs40l50)
> +{
> +	int error, i, irq;
> +	u32 val;
> +
> +	mutex_init(&cs40l50->lock);
> +
> +	error = devm_regulator_bulk_get(cs40l50->dev, ARRAY_SIZE(cs40l50_supplies),
> +			cs40l50_supplies);
> +	if (error) {
> +		dev_err(cs40l50->dev, "Failed to request supplies\n");

dev_err_probe

> +		goto err;

So you call cs40l50_remove() here? Are you sure you tested this path?

> +	}
> +
> +	error = regulator_bulk_enable(ARRAY_SIZE(cs40l50_supplies), cs40l50_supplies);
> +	if (error) {
> +		dev_err(cs40l50->dev, "Failed to enable supplies\n");

This for sure is wrong. Why do you disable regulators when enabling them
failed?

> +		goto err;
> +	}
> +
> +	cs40l50->reset_gpio = devm_gpiod_get_optional(cs40l50->dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(cs40l50->reset_gpio)) {
> +		error = PTR_ERR(cs40l50->reset_gpio);
> +		goto err;
> +	}
> +
> +	usleep_range(CS40L50_MIN_RESET_PULSE_WIDTH_US, CS40L50_MIN_RESET_PULSE_WIDTH_US + 100);
> +
> +	gpiod_set_value_cansleep(cs40l50->reset_gpio, 0);
> +
> +	usleep_range(CS40L50_CP_READY_DELAY_US, CS40L50_CP_READY_DELAY_US + 1000);
> +
> +	for (i = 0; i < CS40L50_DSP_TIMEOUT_COUNT; i++) {
> +		error = cs40l50_dsp_read(cs40l50, CS40L50_DSP1_HALO_STATE, &val);
> +		if (!error && val < 0xFFFF && val >= CS40L50_HALO_STATE_BOOT_DONE)
> +			break;
> +
> +		usleep_range(CS40L50_DSP_POLL_US, CS40L50_DSP_POLL_US + 100);
> +	}
> +
> +	if (i == CS40L50_DSP_TIMEOUT_COUNT) {
> +		dev_err(cs40l50->dev, "Firmware boot failed: %d, halo state = %#x\n", error, val);
> +		goto err;
> +	}
> +
> +	cs40l50->vibe_workqueue = alloc_ordered_workqueue("cs40l50_workqueue", WQ_HIGHPRI);
> +	if (!cs40l50->vibe_workqueue) {
> +		error = -ENOMEM;
> +		goto err;
> +	}
> +
> +	INIT_WORK(&cs40l50->vibe_start_work, cs40l50_vibe_start_worker);
> +	INIT_WORK(&cs40l50->vibe_stop_work, cs40l50_vibe_stop_worker);
> +
> +	error = cs40l50_cs_dsp_init(cs40l50);
> +	if (error)
> +		goto err;
> +
> +	error = cs40l50_input_init(cs40l50);
> +	if (error)
> +		goto err;
> +
> +	error = cs40l50_patch_firmware(cs40l50);
> +	if (error)
> +		goto err;
> +
> +	error = cs40l50_pseq_init(cs40l50);
> +	if (error)
> +		goto err;
> +
> +	error = cs40l50_config_bst(cs40l50);
> +	if (error)
> +		goto err;
> +
> +	error = devm_regmap_add_irq_chip(cs40l50->dev, cs40l50->regmap, cs40l50->irq,
> +			IRQF_ONESHOT | IRQF_SHARED | IRQF_TRIGGER_LOW, 0, &cs40l50_regmap_irq_chip,
> +			&cs40l50->irq_data);
> +	if (error) {
> +		dev_err(cs40l50->dev, "Failed to register IRQ chip: %d\n", error);
> +		goto err;
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(cs40l50_irqs); i++) {
> +		irq = regmap_irq_get_virq(cs40l50->irq_data, cs40l50_irqs[i].irq);
> +		if (irq < 0) {
> +			dev_err(cs40l50->dev, "Failed to get %s\n", cs40l50_irqs[i].name);
> +			error = irq;
> +			goto err;
> +		}
> +
> +		error = devm_request_threaded_irq(cs40l50->dev, irq, NULL, cs40l50_irqs[i].handler,
> +				IRQF_ONESHOT | IRQF_SHARED | IRQF_TRIGGER_LOW,
> +						cs40l50_irqs[i].name, cs40l50);
> +		if (error) {
> +			dev_err(cs40l50->dev, "Failed to request IRQ %s: %d\n",
> +					cs40l50_irqs[i].name, error);
> +			goto err;
> +		}
> +	}
> +
> +	return 0;
> +
> +err:
> +	cs40l50_remove(cs40l50);
> +
> +	return error;
> +}
> +EXPORT_SYMBOL_GPL(cs40l50_probe);
> +
> +int cs40l50_remove(struct cs40l50_private *cs40l50)
> +{
> +	disable_irq(cs40l50->irq);
> +
> +	if (cs40l50->dsp.booted)
> +		cs_dsp_power_down(&cs40l50->dsp);
> +	if (&cs40l50->dsp)
> +		cs_dsp_remove(&cs40l50->dsp);
> +
> +	if (cs40l50->vibe_workqueue) {
> +		flush_workqueue(cs40l50->vibe_workqueue);
> +		destroy_workqueue(cs40l50->vibe_workqueue);
> +	}
> +
> +	gpiod_set_value_cansleep(cs40l50->reset_gpio, 1);
> +	regulator_bulk_disable(ARRAY_SIZE(cs40l50_supplies), cs40l50_supplies);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(cs40l50_remove);
> +
> +MODULE_DESCRIPTION("CS40L50 Advanced Haptic Driver");
> +MODULE_AUTHOR("James Ogletree, Cirrus Logic Inc. <james.ogletree@cirrus.com>");
> +MODULE_LICENSE("GPL");

I don't think this is a module.

Best regards,
Krzysztof

