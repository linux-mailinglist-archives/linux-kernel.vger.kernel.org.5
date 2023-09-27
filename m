Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9CB7B090A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbjI0PjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbjI0Phx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:37:53 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471A21722;
        Wed, 27 Sep 2023 08:36:49 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-5041335fb9cso18385625e87.0;
        Wed, 27 Sep 2023 08:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695829007; x=1696433807; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:to:content-language
         :references:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ffEWQtMwlyKXyuJe449HLxuPGShQkJVuIYKtCPmrqmU=;
        b=M1FV7wZ/hh3cAL+FKx0QYbay3nfCCK/Vx1joI8jHyt/Hnu+tk4/gLclOl6A1tyxKDT
         UcQ3J9qac0kdXj8RSX3wn/WBtyWNtco4KE+tRDw1ezmIEfoYmCxKyNI0WbnKPDa/VzOQ
         uwmHOyYgxh8kRxY9pk8Netw4weI1YoFK/Hut3xMLqXOd7KNXW0xtAoyaoINSUF+S9Fuj
         Z4CGbHywK5lY2nycfjBwABrsdmi1vZjfGVK5DhqQQNbx1en6ylbUanZ8zRgvld56SnHi
         6rk0RlD8nIrcq4VmfA0QOvrG6l8xEIBhEGxGp+nS4UxogsPupo4CMgJlxpBI0VrMAfIz
         oGFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695829007; x=1696433807;
        h=content-transfer-encoding:in-reply-to:cc:to:content-language
         :references:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ffEWQtMwlyKXyuJe449HLxuPGShQkJVuIYKtCPmrqmU=;
        b=A5vMfYjza5RjiOUGteBi+bW0ztc5CKJRvqiTRbdbELBeJZFKsZfoT+ZUpXZ3wmc+wh
         Po15K/I20QSJZSxjH2l6l6P8qSOqWq46+WtptXgy+WJqXm4djaZTSapSZDki0luPgMAH
         jjCNyr/2ZLwfjC2G51AQuprc4fYNlZFvQ6woxGX1y2i/NW6ODj3Il4kQxJWposG3FRwc
         RE6jiQKQwzYWig8GC3znVBPYwK2eplrfZwtvChvCKehBCK78EImiH387wUSMt9EsAPHQ
         UlsiknaxTZzcSWwHl2JUHjvgvKm9VLZKfJ8ugbYvSKe4v96+o4tMOq0XsTZPfO3dMAI3
         A0Xw==
X-Gm-Message-State: AOJu0Yy40nyPc8bGCLoquB5uCqrzDlzZK/iJErBAPFCwSpAgUt+04iX7
        g8z2Idbavj9GfQ9Vp47qaqQ=
X-Google-Smtp-Source: AGHT+IEUA9IT+/K09thYk5Vq/TGFnfiutOra1ZSaKmzMcgnyeBUDgm882lAsH2ZYvmu90PcjEKFAHg==
X-Received: by 2002:a05:6512:138e:b0:503:60f:1c48 with SMTP id fc14-20020a056512138e00b00503060f1c48mr2357165lfb.19.1695829006864;
        Wed, 27 Sep 2023 08:36:46 -0700 (PDT)
Received: from [192.168.1.8] ([37.55.203.63])
        by smtp.gmail.com with ESMTPSA id a10-20020a19f80a000000b0050318721b62sm2685538lff.6.2023.09.27.08.36.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 08:36:46 -0700 (PDT)
Message-ID: <72e02837-9a82-4007-8ba2-fa05f3c17670@gmail.com>
Date:   Wed, 27 Sep 2023 18:36:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Markuss Broks <markuss.broks@gmail.com>
Subject: Re: [PATCH 1/2] input: generalize the Imagis touchscreen driver
References: <7b9864bf-2aa6-4510-ad98-276fbfaadc30@gmail.com>
Content-Language: en-US
To:     Karel Balej <balejk@matfyz.cz>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jeff LaBundy <jeff@labundy.com>, linmengbo0689@protonmail.com
In-Reply-To: <7b9864bf-2aa6-4510-ad98-276fbfaadc30@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Karel,

On 9/26/23 20:35, Karel Balej wrote:
> This driver should work with other Imagis ICs of the IST30**C series.
> Make that more apparent.

To be fair, this driver should work with all Imagis3 chips, which could 
be a better name for it. However, I agree with Jeff here: the driver 
doesn't necessarily need renaming.

>
> Co-developed-by: Duje Mihanović<duje.mihanovic@skole.hr>
> Signed-off-by: Duje Mihanović<duje.mihanovic@skole.hr>
> Signed-off-by: Karel Balej<balejk@matfyz.cz>
> ---
>   ...gis,ist3038c.yaml => imagis,ist30xxc.yaml} |  2 +-
>   MAINTAINERS                                   |  2 +-
>   drivers/input/touchscreen/Kconfig             |  4 +-
>   drivers/input/touchscreen/imagis.c            | 86 +++++++++++--------
>   4 files changed, 52 insertions(+), 42 deletions(-)
>   rename Documentation/devicetree/bindings/input/touchscreen/{imagis,ist3038c.yaml => imagis,ist30xxc.yaml} (99%)
>
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml b/Documentation/devicetree/bindings/input/touchscreen/imagis,ist30xxc.yaml
> similarity index 99%
> rename from Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
> rename to Documentation/devicetree/bindings/input/touchscreen/imagis,ist30xxc.yaml
> index 0d6b033fd5fb..09bf3a6acc5e 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
> +++ b/Documentation/devicetree/bindings/input/touchscreen/imagis,ist30xxc.yaml
> @@ -1,7 +1,7 @@
>   # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>   %YAML 1.2
>   ---
> -$id:http://devicetree.org/schemas/input/touchscreen/imagis,ist3038c.yaml#
> +$id:http://devicetree.org/schemas/input/touchscreen/imagis,ist30xxc.yaml#
>   $schema:http://devicetree.org/meta-schemas/core.yaml#
>   
>   title: Imagis IST30XXC family touchscreen controller
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b19995690904..b23e76418d94 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10209,7 +10209,7 @@ F:	drivers/usb/atm/ueagle-atm.c
>   IMAGIS TOUCHSCREEN DRIVER
>   M:	Markuss Broks<markuss.broks@gmail.com>
>   S:	Maintained
> -F:	Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
> +F:	Documentation/devicetree/bindings/input/touchscreen/imagis,ist30xxc.yaml
>   F:	drivers/input/touchscreen/imagis.c
>   
>   IMGTEC ASCII LCD DRIVER
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index e3e2324547b9..45503aa2653e 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -665,10 +665,10 @@ config TOUCHSCREEN_NOVATEK_NVT_TS
>   	  module will be called novatek-nvt-ts.
>   
>   config TOUCHSCREEN_IMAGIS
> -	tristate "Imagis touchscreen support"
> +	tristate "Imagis IST30XXC touchscreen support"
>   	depends on I2C
>   	help
> -	  Say Y here if you have an Imagis IST30xxC touchscreen.
> +	  Say Y here if you have an Imagis IST30XXC touchscreen.
>   	  If unsure, say N.
>   
>   	  To compile this driver as a module, choose M here: the
> diff --git a/drivers/input/touchscreen/imagis.c b/drivers/input/touchscreen/imagis.c
> index 07111ca24455..4456f1b4d527 100644
> --- a/drivers/input/touchscreen/imagis.c
> +++ b/drivers/input/touchscreen/imagis.c
> @@ -11,25 +11,26 @@
>   #include <linux/property.h>
>   #include <linux/regulator/consumer.h>
>   
> -#define IST3038C_HIB_ACCESS		(0x800B << 16)
> -#define IST3038C_DIRECT_ACCESS		BIT(31)
> -#define IST3038C_REG_CHIPID		0x40001000
> -#define IST3038C_REG_HIB_BASE		0x30000100
> -#define IST3038C_REG_TOUCH_STATUS	(IST3038C_REG_HIB_BASE | IST3038C_HIB_ACCESS)
> -#define IST3038C_REG_TOUCH_COORD	(IST3038C_REG_HIB_BASE | IST3038C_HIB_ACCESS | 0x8)
> -#define IST3038C_REG_INTR_MESSAGE	(IST3038C_REG_HIB_BASE | IST3038C_HIB_ACCESS | 0x4)
> +#define IST30XXC_HIB_ACCESS		(0x800B << 16)
> +#define IST30XXC_DIRECT_ACCESS		BIT(31)
> +#define IST30XXC_REG_CHIPID		0x40001000
> +#define IST30XXC_REG_HIB_BASE		0x30000100
> +#define IST30XXC_REG_TOUCH_STATUS	(IST30XXC_REG_HIB_BASE | IST30XXC_HIB_ACCESS)
> +#define IST30XXC_REG_TOUCH_COORD	(IST30XXC_REG_HIB_BASE | IST30XXC_HIB_ACCESS | 0x8)
> +#define IST30XXC_REG_INTR_MESSAGE	(IST30XXC_REG_HIB_BASE | IST30XXC_HIB_ACCESS | 0x4)
> +#define IST30XXC_CHIP_ON_DELAY_MS	60
> +#define IST30XXC_I2C_RETRY_COUNT	3
> +#define IST30XXC_MAX_FINGER_NUM		10
> +#define IST30XXC_X_MASK			GENMASK(23, 12)
> +#define IST30XXC_X_SHIFT		12
> +#define IST30XXC_Y_MASK			GENMASK(11, 0)
> +#define IST30XXC_AREA_MASK		GENMASK(27, 24)
> +#define IST30XXC_AREA_SHIFT		24
> +#define IST30XXC_FINGER_COUNT_MASK	GENMASK(15, 12)
> +#define IST30XXC_FINGER_COUNT_SHIFT	12
> +#define IST30XXC_FINGER_STATUS_MASK	GENMASK(9, 0)
> +
>   #define IST3038C_WHOAMI			0x38c
> -#define IST3038C_CHIP_ON_DELAY_MS	60
> -#define IST3038C_I2C_RETRY_COUNT	3
> -#define IST3038C_MAX_FINGER_NUM		10
> -#define IST3038C_X_MASK			GENMASK(23, 12)
> -#define IST3038C_X_SHIFT		12
> -#define IST3038C_Y_MASK			GENMASK(11, 0)
> -#define IST3038C_AREA_MASK		GENMASK(27, 24)
> -#define IST3038C_AREA_SHIFT		24
> -#define IST3038C_FINGER_COUNT_MASK	GENMASK(15, 12)
> -#define IST3038C_FINGER_COUNT_SHIFT	12
> -#define IST3038C_FINGER_STATUS_MASK	GENMASK(9, 0)
>   
>   struct imagis_ts {
>   	struct i2c_client *client;
> @@ -57,7 +58,7 @@ static int imagis_i2c_read_reg(struct imagis_ts *ts,
>   		},
>   	};
>   	int ret, error;
> -	int retry = IST3038C_I2C_RETRY_COUNT;
> +	int retry = IST30XXC_I2C_RETRY_COUNT;
>   
>   	/* Retry in case the controller fails to respond */
>   	do {
> @@ -84,7 +85,7 @@ static irqreturn_t imagis_interrupt(int irq, void *dev_id)
>   	int i;
>   	int error;
>   
> -	error = imagis_i2c_read_reg(ts, IST3038C_REG_INTR_MESSAGE,
> +	error = imagis_i2c_read_reg(ts, IST30XXC_REG_INTR_MESSAGE,
>   				    &intr_message);
>   	if (error) {
>   		dev_err(&ts->client->dev,
> @@ -92,20 +93,20 @@ static irqreturn_t imagis_interrupt(int irq, void *dev_id)
>   		goto out;
>   	}
>   
> -	finger_count = (intr_message & IST3038C_FINGER_COUNT_MASK) >>
> -				IST3038C_FINGER_COUNT_SHIFT;
> -	if (finger_count > IST3038C_MAX_FINGER_NUM) {
> +	finger_count = (intr_message & IST30XXC_FINGER_COUNT_MASK) >>
> +				IST30XXC_FINGER_COUNT_SHIFT;
> +	if (finger_count > IST30XXC_MAX_FINGER_NUM) {
>   		dev_err(&ts->client->dev,
>   			"finger count %d is more than maximum supported\n",
>   			finger_count);
>   		goto out;
>   	}
>   
> -	finger_pressed = intr_message & IST3038C_FINGER_STATUS_MASK;
> +	finger_pressed = intr_message & IST30XXC_FINGER_STATUS_MASK;
>   
>   	for (i = 0; i < finger_count; i++) {
>   		error = imagis_i2c_read_reg(ts,
> -					    IST3038C_REG_TOUCH_COORD + (i * 4),
> +					    IST30XXC_REG_TOUCH_COORD + (i * 4),
>   					    &finger_status);
>   		if (error) {
>   			dev_err(&ts->client->dev,
> @@ -118,12 +119,12 @@ static irqreturn_t imagis_interrupt(int irq, void *dev_id)
>   		input_mt_report_slot_state(ts->input_dev, MT_TOOL_FINGER,
>   					   finger_pressed & BIT(i));
>   		touchscreen_report_pos(ts->input_dev, &ts->prop,
> -				       (finger_status & IST3038C_X_MASK) >>
> -						IST3038C_X_SHIFT,
> -				       finger_status & IST3038C_Y_MASK, 1);
> +				       (finger_status & IST30XXC_X_MASK) >>
> +						IST30XXC_X_SHIFT,
> +				       finger_status & IST30XXC_Y_MASK, 1);
>   		input_report_abs(ts->input_dev, ABS_MT_TOUCH_MAJOR,
> -				 (finger_status & IST3038C_AREA_MASK) >>
> -					IST3038C_AREA_SHIFT);
> +				 (finger_status & IST30XXC_AREA_MASK) >>
> +					IST30XXC_AREA_SHIFT);
>   	}
>   
>   	input_mt_sync_frame(ts->input_dev);
> @@ -148,7 +149,7 @@ static int imagis_power_on(struct imagis_ts *ts)
>   	if (error)
>   		return error;
>   
> -	msleep(IST3038C_CHIP_ON_DELAY_MS);
> +	msleep(IST30XXC_CHIP_ON_DELAY_MS);
>   
>   	return 0;
>   }
> @@ -220,7 +221,7 @@ static int imagis_init_input_dev(struct imagis_ts *ts)
>   	}
>   
>   	error = input_mt_init_slots(input_dev,
> -				    IST3038C_MAX_FINGER_NUM,
> +				    IST30XXC_MAX_FINGER_NUM,
>   				    INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);
>   	if (error) {
>   		dev_err(&ts->client->dev,
> @@ -253,7 +254,7 @@ static int imagis_probe(struct i2c_client *i2c)
>   {
>   	struct device *dev = &i2c->dev;
>   	struct imagis_ts *ts;
> -	int chip_id, error;
> +	int chip_id, dt_chip_id, error;
>   
>   	ts = devm_kzalloc(dev, sizeof(*ts), GFP_KERNEL);
>   	if (!ts)
> @@ -261,6 +262,8 @@ static int imagis_probe(struct i2c_client *i2c)
>   
>   	ts->client = i2c;
>   
> +	dt_chip_id = (int)(uintptr_t)device_get_match_data(&i2c->dev);
> +
>   	error = imagis_init_regulators(ts);
>   	if (error) {
>   		dev_err(dev, "regulator init error: %d\n", error);
> @@ -280,15 +283,15 @@ static int imagis_probe(struct i2c_client *i2c)
>   	}
>   
>   	error = imagis_i2c_read_reg(ts,
> -			IST3038C_REG_CHIPID | IST3038C_DIRECT_ACCESS,
> +			IST30XXC_REG_CHIPID | IST30XXC_DIRECT_ACCESS,
>   			&chip_id);
>   	if (error) {
>   		dev_err(dev, "chip ID read failure: %d\n", error);
>   		return error;
>   	}
>   
> -	if (chip_id != IST3038C_WHOAMI) {
> -		dev_err(dev, "unknown chip ID: 0x%x\n", chip_id);
> +	if (chip_id != dt_chip_id) {
> +		dev_err(dev, "unknown or misconfigured chip ID: 0x%x\n", chip_id);
>   		return -EINVAL;
>   	}
>   
> @@ -345,12 +348,18 @@ static DEFINE_SIMPLE_DEV_PM_OPS(imagis_pm_ops, imagis_suspend, imagis_resume);
>   
>   #ifdef CONFIG_OF
>   static const struct of_device_id imagis_of_match[] = {
> -	{ .compatible = "imagis,ist3038c", },
> +	{ .compatible = "imagis,ist3038c", .data = (void *)IST3038C_WHOAMI, },
>   	{ },
>   };
>   MODULE_DEVICE_TABLE(of, imagis_of_match);
>   #endif
>   
> +static const struct i2c_device_id imagis_ts_i2c_id[] = {
> +	{ "ist3038c", IST3038C_WHOAMI, },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(i2c, imagis_ts_i2c_id);
> +
>   static struct i2c_driver imagis_ts_driver = {
>   	.driver = {
>   		.name = "imagis-touchscreen", @@ -358,10 +367,11 @@ static struct i2c_driver imagis_ts_driver = { 
> .of_match_table = of_match_ptr(imagis_of_match), }, .probe = 
> imagis_probe, + .id_table = imagis_ts_i2c_id, }; 
> module_i2c_driver(imagis_ts_driver); -MODULE_DESCRIPTION("Imagis IST3038C Touchscreen Driver");
> +MODULE_DESCRIPTION("Imagis IST30XXC Touchscreen Driver");
>   MODULE_AUTHOR("Markuss Broks<markuss.broks@gmail.com>");
>   MODULE_LICENSE("GPL");

Additionally, there used to be my series [1] that generalized the 
driver, but it never got applied. I will re-send it. It introduces 
`struct imagis_properties`, which contains register addresses for the 
registers that we use to read the touch input. In your specific case, I 
believe it should be:

static const struct imagis_properties imagis_3032c_data =
{
	.interrupt_msg_cmd = IST3038C_REG_INTR_MESSAGE,
	.touch_coord_cmd = IST3038C_REG_TOUCH_COORD,
	.whoami_cmd = IST3038C_REG_CHIPID,
	.whoami_val = IST3032C_WHOAMI, /* change it to your whoami */
};


As for the voltage set, I believe this does not belong in a kernel 
driver. You should set it in device-tree with `regulator-max-microvolt` 
and `regulator-min-microvolt`.


Yours,

- Markuss


[1]: 
https://lore.kernel.org/lkml/20220504152406.8730-1-markuss.broks@gmail.com/

