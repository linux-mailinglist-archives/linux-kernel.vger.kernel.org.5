Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2D676658A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 09:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234400AbjG1HmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 03:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234352AbjG1Hl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 03:41:59 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB72D2D51
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 00:41:57 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b9d07a8d84so4374801fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 00:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690530116; x=1691134916;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YH0GXjtaVhK/TMonu2F4Vh27btTOGldL7tUWhIb9bOw=;
        b=GuCPWiAIiVUTxHq1sCBm0TNcgNB1hUzg8FA5wayoNtyenmyCcQkTgxvdb8V3Dj5xfP
         4pORprwQ3xAKLAnCmYmQOp78yYjulcOqyQHBoXwuqGbpoBUOKDQDL1DIaF7iqGQ68fuP
         9ys860YY51xO0XH9AVUO/K7IFRn717Fdrac7sZBXpY8sID+6g/CjtAzKJObHlbcLiGXp
         txnHjVty//epw7pxugbvUFS1FtlIjW9i8ryp5JEmmamDJL08i0RxdP38ZFF0PJwvv1II
         VSFg0/SnOoH9gbM+9kVsPb9zZ3p+rMRCfeBNaRS157gOcpApxf0A4Fc/oZPfi3dABYY/
         YuPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690530116; x=1691134916;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YH0GXjtaVhK/TMonu2F4Vh27btTOGldL7tUWhIb9bOw=;
        b=QIDtkXrroC6ajCznE46m8a3CPUX7P1Jh4zGlqLwMskpnmXGWysgnksFQSmsYMUp9/e
         2DC/SvjAb4S0H4YTECfUvAL2J8+6RN/IYGRA/w9LOINScJsh10KNqxgdKwQYjnw4K71X
         4PuTFVVoeG09zOpduMVTAnaYRxUR83Qp3C1Y+JsKY//sXqpO3H6P2C8FnG3cQk7dG2h8
         +me7fxNmldbp6F2OX30WD8nSIKmf4jOEBCHwDuIWVCf75DOx3vybRVrFaKSKp9led9yx
         UomuDaEL308sGia1ChGm1nmGu2pzLrKy2SX66uYUFRxOeGj7DtGP6QYlLznemZrwwx1/
         ukmQ==
X-Gm-Message-State: ABy/qLa1Stg0d9dVijPR1tePa3rXcsBwlxMlL5rtM9NeyKgredkPOJCO
        UTIO/SCKkdfPMojOjpapDC3XDw==
X-Google-Smtp-Source: APBJJlF3Q/+Qg3SilY9zwDKIC0KKV+gjHMUyHV9eMz62tAvUfN8iw9my9w64tWBIJVFh0+mPtkNMzA==
X-Received: by 2002:a2e:95c6:0:b0:2b7:339c:f791 with SMTP id y6-20020a2e95c6000000b002b7339cf791mr1119023ljh.25.1690530115906;
        Fri, 28 Jul 2023 00:41:55 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id u22-20020a05600c211600b003fbcdba1a63sm3585055wml.12.2023.07.28.00.41.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 00:41:55 -0700 (PDT)
Message-ID: <68dbe6b1-891c-76d4-7e5f-97cb6cc81b51@linaro.org>
Date:   Fri, 28 Jul 2023 09:41:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/3] leds: Add Broadchip BCT3024 LED driver
Content-Language: en-US
To:     Matus Gajdos <matuszpd@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230727160525.23312-1-matuszpd@gmail.com>
 <20230727160525.23312-4-matuszpd@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230727160525.23312-4-matuszpd@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/2023 18:05, Matus Gajdos wrote:
> The BCT3024 chip is an I2C LED driver with independent 24 output
> channels. Each channel supports 256 levels.
> 
> Signed-off-by: Matus Gajdos <matuszpd@gmail.com>
> ---
>  drivers/leds/Kconfig        |   9 +
>  drivers/leds/Makefile       |   1 +
>  drivers/leds/leds-bct3024.c | 564 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 574 insertions(+)
>  create mode 100644 drivers/leds/leds-bct3024.c

Thank you for your patch. There is something to discuss/improve.


> 
> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index 6046dfeca16f..75059db201e2 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -135,6 +135,15 @@ config LEDS_BCM6358
>  	  This option enables support for LEDs connected to the BCM6358
>  	  LED HW controller accessed via

...

> +}
> +
> +static int bct3024_brightness_set(struct led_classdev *ldev,
> +				  enum led_brightness brightness)
> +{
> +	struct bct3024_led *led = container_of(ldev, struct bct3024_led, ldev);
> +	struct bct3024_data *priv = led->priv;
> +	struct device *dev = priv->dev;
> +	int ret;
> +	unsigned int ctrl, bright;
> +
> +	if (priv->state == BCT3024_STATE_INIT)
> +		return -EIO;
> +
> +	if (brightness == 0) {
> +		ctrl = 0x00;
> +		bright = 0;
> +	} else if (brightness < 256) {
> +		ctrl = 0x01;
> +		bright = brightness;
> +	}
> +
> +	mutex_lock(&priv->lock);

What do you protect with lock? This must be documented in lock's
definition in your struct.

> +
> +	if (bct3024_any_active(priv) && (priv->state == BCT3024_STATE_IDLE ||
> +	    priv->state == BCT3024_STATE_SHUTDOWN)) {
> +		pm_runtime_get_sync(dev);
> +		priv->state = BCT3024_STATE_ACTIVE;

I don't understand why you added state machine for handling state. You
are basically duplicating runtime PM...

> +	}
> +
> +	for (; led; led = led->next) {
> +		ret = bct3024_write(priv, BCT3024_REG_CONTROL(led->idx), ctrl);
> +		if (ret < 0)
> +			goto exit;
> +		ret = bct3024_write(priv, BCT3024_REG_BRIGHTNESS(led->idx), bright);
> +		if (ret < 0)
> +			goto exit;
> +	}
> +
> +	ret = bct3024_write(priv, BCT3024_REG_UPDATE, 0);
> +	if (ret < 0)
> +		goto exit;
> +
> +	ret = bct3024_set_shutdown_reg(priv, false);
> +	if (ret < 0)
> +		goto exit;
> +
> +	if (!ret && priv->state == BCT3024_STATE_ACTIVE) {
> +		priv->state = BCT3024_STATE_IDLE;
> +		pm_runtime_mark_last_busy(dev);
> +		pm_runtime_put_autosuspend(dev);
> +		/* Activate autosuspend */
> +		pm_runtime_idle(dev);
> +	}
> +
> +	ret = 0;
> +
> +exit:
> +	mutex_unlock(&priv->lock);
> +
> +	return ret;
> +}
> +
> +static int bct3024_setup_led(struct bct3024_data *priv, u32 reg,
> +			     struct bct3024_led **prev, struct led_init_data *idata)
> +{
> +	struct device *dev = priv->dev;
> +	struct bct3024_led *led;
> +	int ret;
> +
> +	if (reg >= BCT3024_LED_COUNT) {
> +		ret = -EINVAL;
> +		dev_err_probe(dev, ret, "invalid reg value: %u\n", reg);
> +		return ret;

That's not correct syntax.

return dev_err_probe
> +	}
> +
> +	led = &priv->leds[reg];
> +
> +	if (led->active) {
> +		ret = -EINVAL;
> +		dev_err_probe(dev, ret, "reg redeclared: %u\n", reg);
> +		return ret;

Ditto

> +	}
> +
> +	led->active = true;
> +	led->priv = priv;
> +	led->idx = reg;
> +
> +	if (!*prev) {
> +		led->ldev.max_brightness = 255;
> +		led->ldev.brightness_set_blocking = bct3024_brightness_set;
> +
> +		ret = devm_led_classdev_register_ext(dev, &led->ldev, idata);
> +		if (ret < 0) {
> +			dev_err_probe(dev, ret, "failed to register led %u\n", reg);
> +			return ret;

Ditto

> +		}
> +	} else
> +		(*prev)->next = led;
> +
> +	*prev = led;
> +
> +	return 0;
> +}
> +
> +static int bct3024_of_parse(struct i2c_client *client)
> +{
> +	struct bct3024_data *priv = i2c_get_clientdata(client);
> +	struct device *dev = priv->dev;
> +	struct device_node *np;
> +	int ret;
> +
> +	ret = of_get_child_count(dev->of_node);
> +	if (!ret || ret > ARRAY_SIZE(priv->leds)) {
> +		dev_err_probe(dev, -EINVAL, "invalid nodes count: %d\n", ret);
> +		return -EINVAL;

Ditto

> +	}
> +
> +	for_each_child_of_node(dev->of_node, np) {
> +		u32 regs[BCT3024_LED_COUNT];
> +		struct led_init_data idata = {
> +			.fwnode = of_fwnode_handle(np),
> +			.devicename = client->name,
> +		};
> +		struct bct3024_led *led;
> +		int count, i;
> +
> +		count = of_property_read_variable_u32_array(np, "reg", regs, 1,
> +							    BCT3024_LED_COUNT);
> +		if (count < 0) {
> +			ret = count;
> +			dev_err_probe(dev, ret, "failed to read node reg\n");
> +			goto fail;

Ditto

> +		}
> +
> +		for (i = 0, led = NULL; i < count; i++) {
> +			ret = bct3024_setup_led(priv, regs[i], &led, &idata);
> +			if (ret < 0)
> +				goto fail;
> +		}
> +	}
> +
> +	return 0;
> +
> +fail:
> +	of_node_put(np);
> +
> +	return ret;
> +}
> +
> +static int bct3024_i2c_probe(struct i2c_client *client)
> +{
> +	struct bct3024_data *priv;
> +	struct device *dev = &client->dev;
> +	int ret;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->dev = dev;
> +
> +	priv->supply = devm_regulator_get_optional(dev, "vdd");
> +	if (IS_ERR(priv->supply)) {
> +		ret = PTR_ERR(priv->supply);
> +		if (ret != -ENODEV) {
> +			dev_err_probe(dev, ret, "failed to get supply\n");
> +			return ret;

Ditto

> +		}
> +		priv->supply = NULL;
> +	}
> +
> +	priv->shutdown_gpiod = devm_gpiod_get_optional(dev, "shutdown", GPIOD_OUT_HIGH);
> +	if (IS_ERR(priv->shutdown_gpiod)) {
> +		ret = PTR_ERR(priv->shutdown_gpiod);
> +		dev_err_probe(dev, ret, "failed to get shutdown gpio\n");
> +		return ret;

Everywhere...

> +	}
> +
> +	priv->regmap = devm_regmap_init_i2c(client, &bct3024_regmap);
> +	if (IS_ERR(priv->regmap)) {
> +		ret = PTR_ERR(priv->regmap);
> +		return ret;


It's return PTR_ERR....

> +	}
> +
> +	mutex_init(&priv->lock);
> +	i2c_set_clientdata(client, priv);
> +
> +	pm_runtime_set_autosuspend_delay(dev, 2000);
> +	pm_runtime_use_autosuspend(dev);
> +	pm_runtime_enable(dev);
> +	if (!pm_runtime_enabled(dev)) {
> +		ret = bct3024_shutdown(priv, false);

This should go to error handling path... Although why? There was no
power on code between devm_regmap_init_i2c() and here.

> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	ret = pm_runtime_resume_and_get(dev);
> +	if (ret < 0)
> +		goto fail;
> +
> +	ret = bct3024_of_parse(client);
> +	if (ret < 0)
> +		goto fail;
> +
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);
> +
> +	return 0;
> +
> +fail:
> +	dev_err_probe(dev, ret, "probe failed\n");

No, no no. Do you see any driver doing it?

> +	if (!pm_runtime_status_suspended(dev))
> +		bct3024_shutdown(priv, 2);

Which call this is reversing? Each step in probe should have its reverse
(when applicable of course). Don't add some new unrelated reverse calls
which do not have a matching enable. If you shutdown here, I expect
there was "bct3024_powerup". Where is it? Looks like you put unrelated
code into the shutdown making it all very difficult to understand.

Where do you reverse PM runtime calls here?

> +	return ret;
> +}
> +
> +static void bct3024_i2c_remove(struct i2c_client *client)
> +{
> +	struct bct3024_data *priv = i2c_get_clientdata(client);
> +
> +	bct3024_shutdown(priv, true);
> +	pm_runtime_disable(priv->dev);
> +	mutex_destroy(&priv->lock);
> +}
> +
> +static void bct3024_i2c_shutdown(struct i2c_client *client)
> +{
> +	struct bct3024_data *priv = i2c_get_clientdata(client);
> +
> +	bct3024_shutdown(priv, true);
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int bct3024_runtime_idle(struct device *dev)
> +{
> +	struct bct3024_data *priv = dev_get_drvdata(dev);
> +
> +	dev_dbg(dev, "%s: %d\n", __func__, priv->state);

No simple debug statements for entry/exit of functions. There is
extensive trace infrastructure for all this.

> +
> +	return priv->state == BCT3024_STATE_ACTIVE ? -EBUSY : 0;
> +}
> +
> +static int bct3024_runtime_suspend(struct device *dev)
> +{
> +	struct bct3024_data *priv = dev_get_drvdata(dev);
> +
> +	dev_dbg(dev, "%s: %d\n", __func__, priv->state);

Ditto

> +
> +	switch (priv->state) {
> +	case BCT3024_STATE_INIT:
> +	case BCT3024_STATE_SHUTDOWN:
> +		return 0;
> +	default:
> +		break;
> +	}
> +
> +	return bct3024_shutdown(priv, true);
> +}
> +
> +static int bct3024_runtime_resume(struct device *dev)
> +{
> +	struct bct3024_data *priv = dev_get_drvdata(dev);
> +	int ret;
> +
> +	dev_dbg(dev, "%s: %d\n", __func__, priv->state);

Ditto

> +
> +	switch (priv->state) {
> +	case BCT3024_STATE_INIT:
> +	case BCT3024_STATE_SHUTDOWN:
> +		break;
> +	default:
> +		return 0;
> +	}
> +
> +	ret = bct3024_shutdown(priv, false);
> +	if (ret < 0)
> +		bct3024_shutdown(priv, 2);
> +
> +	return ret;
> +}
> +#endif
> +
> +static const struct dev_pm_ops bct3024_pm_ops = {
> +	SET_RUNTIME_PM_OPS(bct3024_runtime_suspend, bct3024_runtime_resume,
> +			   bct3024_runtime_idle)
> +	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
> +};
> +
> +static const struct of_device_id bct3024_of_match[] = {
> +	{ .compatible = "broadchip,bct3024" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, bct3024_of_match);
> +
> +static struct i2c_driver bct3024_driver = {
> +	.driver = {
> +		.name = "bct3024",
> +		.of_match_table = bct3024_of_match,
> +		.pm = &bct3024_pm_ops,
> +	},
> +	.probe_new = bct3024_i2c_probe,
> +	.shutdown = bct3024_i2c_shutdown,
> +	.remove = bct3024_i2c_remove,
> +};
> +
> +module_i2c_driver(bct3024_driver);
> +
> +MODULE_AUTHOR("Matus Gajdos <matuszpd@gmail.com>");
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Broadchip BCT3024 LED driver");

Best regards,
Krzysztof

