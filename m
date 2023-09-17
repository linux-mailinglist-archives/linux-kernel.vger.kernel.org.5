Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF457A33EF
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 08:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233729AbjIQGEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 02:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbjIQGD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 02:03:59 -0400
Received: from smtp.smtpout.orange.fr (smtp-29.smtpout.orange.fr [80.12.242.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5979185
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 23:03:52 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id hksmq6IsMiBkuhksnqfNaI; Sun, 17 Sep 2023 08:03:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1694930630;
        bh=L+fucrYvHZGTDZtgpuMyh0kVP9Gh8YSk+kaR8DcFbLY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=tREb9eM0fmJ8o3fwVwse+LA5/+eLq2t/DibFtMaWoB1iAMG43iuPjkKXfvKBYciAr
         wwSiZSIukVV8mDWI8974rTf+CKt+zyz4K1yFaMilj0DaNaFMoJJAiKyU7Qr7Gj0dio
         PA/Lv5tgGSPg3uQYPRAXRXt+NWC41pfDhV4AZELnob2rRcWQOJWdCJPCUs+SkvAvlA
         K9B87jq2dsuHhSGP3o83q3Fno9ba5nLmjtQJhdUftrQ7Y3v873PFT9mrWapjKNZ2Q2
         EsjyPukbByZmAhf4Vm8NteT7EFsQvEr2KGCv2zcf1P0rUOOJU8WDrR+n9OdV2j7JDD
         EhXsWUgAMkiiA==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 17 Sep 2023 08:03:50 +0200
X-ME-IP: 86.243.2.178
Message-ID: <abf36591-3b3c-dc47-b1aa-e574325499f4@wanadoo.fr>
Date:   Sun, 17 Sep 2023 08:03:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/2] Input: add Himax HX852x(ES) touchscreen driver
To:     stephan@gerhold.net
Cc:     conor+dt@kernel.org, devicetree@vger.kernel.org,
        dmitry.torokhov@gmail.com, jeff@labundy.com,
        jonathan.albrieux@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, rydberg@bitmath.org
References: <20230913-hx852x-v1-0-9c1ebff536eb@gerhold.net>
 <20230913-hx852x-v1-2-9c1ebff536eb@gerhold.net>
Content-Language: fr
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230913-hx852x-v1-2-9c1ebff536eb@gerhold.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 13/09/2023 à 15:25, Stephan Gerhold a écrit :
> From: Jonathan Albrieux <jonathan.albrieux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> Add a simple driver for the Himax HX852x(ES) touch panel controller,
> with support for multi-touch and capacitive touch keys.
> 
> The driver is somewhat based on sample code from Himax. However, that
> code was so extremely confusing that we spent a significant amount of
> time just trying to understand the packet format and register commands.
> In this driver they are described with clean structs and defines rather
> than lots of magic numbers and offset calculations.
> 
> Signed-off-by: Jonathan Albrieux <jonathan.albrieux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Co-developed-by: Stephan Gerhold <stephan-3XONVrnlUWDR7s880joybQ@public.gmane.org>
> Signed-off-by: Stephan Gerhold <stephan-3XONVrnlUWDR7s880joybQ@public.gmane.org>
> ---

...

> +static irqreturn_t hx852x_interrupt(int irq, void *ptr)
> +{
> +	struct hx852x *hx = ptr;
> +	int error;
> +
> +	error = hx852x_handle_events(hx);
> +	if (error) {
> +		dev_err(&hx->client->dev, "failed to handle events: %d\n", error);

Should dev_err_ratelimited() be preferred?

> +		return IRQ_NONE;
> +	}
> +
> +	return IRQ_HANDLED;
> +}

...

> +static int hx852x_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct hx852x *hx;
> +	int error, i;

Nit: err or ret is shorter and maybe more "standard".

> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C |
> +				     I2C_FUNC_SMBUS_WRITE_BYTE |
> +				     I2C_FUNC_SMBUS_WRITE_BYTE_DATA |
> +				     I2C_FUNC_SMBUS_WRITE_WORD_DATA)) {
> +		dev_err(dev, "not all i2c functionality supported\n");
> +		return -ENXIO;
> +	}
> +
> +	hx = devm_kzalloc(dev, sizeof(*hx), GFP_KERNEL);
> +	if (!hx)
> +		return -ENOMEM;
> +
> +	hx->client = client;
> +	hx->input_dev = devm_input_allocate_device(dev);
> +	if (!hx->input_dev)
> +		return -ENOMEM;
> +
> +	hx->input_dev->name = "Himax HX852x";
> +	hx->input_dev->id.bustype = BUS_I2C;
> +	hx->input_dev->open = hx852x_input_open;
> +	hx->input_dev->close = hx852x_input_close;
> +
> +	i2c_set_clientdata(client, hx);
> +	input_set_drvdata(hx->input_dev, hx);
> +
> +	hx->supplies[0].supply = "vcca";
> +	hx->supplies[1].supply = "vccd";
> +	error = devm_regulator_bulk_get(dev, ARRAY_SIZE(hx->supplies), hx->supplies);
> +	if (error < 0)
> +		return dev_err_probe(dev, error, "failed to get regulators");
> +
> +	hx->reset_gpiod = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(hx->reset_gpiod))
> +		return dev_err_probe(dev, error, "failed to get reset gpio");
> +
> +	error = devm_request_threaded_irq(dev, client->irq, NULL, hx852x_interrupt,
> +					  IRQF_ONESHOT | IRQF_NO_AUTOEN, NULL, hx);
> +	if (error) {
> +		dev_err(dev, "failed to request irq %d: %d\n", client->irq, error);

dev_err_probe() could be used to be consistent with above code.
Same for below dev_err() calls.

> +		return error;
> +	}
> +
> +	error = hx852x_read_config(hx);
> +	if (error)
> +		return error;
> +
> +	input_set_capability(hx->input_dev, EV_ABS, ABS_MT_POSITION_X);
> +	input_set_capability(hx->input_dev, EV_ABS, ABS_MT_POSITION_Y);
> +	input_set_abs_params(hx->input_dev, ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0);
> +
> +	touchscreen_parse_properties(hx->input_dev, true, &hx->props);
> +	error = hx852x_parse_properties(hx);
> +	if (error)
> +		return error;
> +
> +	hx->input_dev->keycode = hx->keycodes;
> +	hx->input_dev->keycodemax = hx->keycount;
> +	hx->input_dev->keycodesize = sizeof(hx->keycodes[0]);
> +	for (i = 0; i < hx->keycount; i++)
> +		input_set_capability(hx->input_dev, EV_KEY, hx->keycodes[i]);
> +
> +	error = input_mt_init_slots(hx->input_dev, hx->max_fingers,
> +				    INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);
> +	if (error) {
> +		dev_err(dev, "failed to init MT slots: %d\n", error);
> +		return error;
> +	}
> +
> +	error = input_register_device(hx->input_dev);
> +	if (error) {

input_mt_destroy_slots() should be called here, or in an error handling 
path below, or via a devm_add_action_or_reset().

It should also be called in a .remove function (unless 
devm_add_action_or_reset is prefered)

CJ

> +		dev_err(dev, "failed to register input device: %d\n", error);
> +		return error;
> +	}
> +
> +	return 0;
> +}

...

