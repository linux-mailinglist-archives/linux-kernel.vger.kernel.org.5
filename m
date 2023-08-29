Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1952378C9A9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 18:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237472AbjH2Q3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 12:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237520AbjH2Q23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 12:28:29 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EC61BF
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 09:28:18 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-401da71b83cso5161035e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 09:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693326496; x=1693931296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rpqa6ldHA7+s03xx4g9dxalk6uI6N/wZjkRdFsn+Mzw=;
        b=KnmcT3f4tVKSrqfCvp4riPVv63u5NlCU3AyN1khUxhpySjV3IVDDE8W8eXge76a1Pm
         6VXcNXVjPqGvzFLXTz4QGSyIEDIxaoFhfQnu4PI3ARFdL/0WRG0jhFZFmBJMLPQ2vSjr
         LQCWdLnf6nwhPF+of9zRRtocUu0UFOxOvGuXEH7OBbyeySBhlt5UHHL2KtjVzJAO3a2d
         yJF7/gCM+5/wsTGoLIJpXiLKLd3cWEKGizMSL/lHcTQNPp3IPRSb84ov3vojrJtscU7p
         gIUKBC0l79dwzNOcRYsvkdkJ4/0Afkni/8BwNud1r1hZdVVotmJuz96XZya/IfZ/9m7F
         Scfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693326496; x=1693931296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rpqa6ldHA7+s03xx4g9dxalk6uI6N/wZjkRdFsn+Mzw=;
        b=HupZiXyuQPgi2/Kb2XMnQzOANABy1hei5FP815HXSOiGkFmcpNfYiDjXmM1CCNdIC1
         CqTUqQLObQ2xEf2X9vREeU8c8t2UovSOBv00s18aCjxiMNR6BV+GZ5TU4WqKfSU3OwPg
         XuLL8BG41Yaz3SMPp0SCU1zAMWtnBSjRBEQFArR+93iEJw8Mq0Y7TtUJMcxOBVbeFZvg
         BwTvo9FFdF7/Xvpm0qZcwh0Mme2Ko0EtqV8ndbZFbWLN2eg677bpJnUFLRuek2LyuEIA
         Z5aLkDJElj8UNzt7+jVkZlW6YFh2Xh5mMTTLTRrZkFArMh5c4bJlO4nvcSuL5WmZv2Pl
         ospw==
X-Gm-Message-State: AOJu0YyS6t0NgbaiijsaDRB7nkNmTcHrWs3rmXedeY/wUMseJ5jxQoVm
        fXn4pY2iatgBbNWFo45Ke0msPA==
X-Google-Smtp-Source: AGHT+IEfJSUBL42nyBdyLW7ZL/n8wPUN1nrSlKl/LyAkDJ2R2cEWy2EjLFUTZblF2ciDwd/UsdyPjQ==
X-Received: by 2002:a7b:cbcd:0:b0:3fe:25b3:951d with SMTP id n13-20020a7bcbcd000000b003fe25b3951dmr21965260wmi.5.1693326496479;
        Tue, 29 Aug 2023 09:28:16 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id k8-20020a7bc408000000b003fe23b10fdfsm17577866wmi.36.2023.08.29.09.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 09:28:16 -0700 (PDT)
Date:   Tue, 29 Aug 2023 17:28:14 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] backlight: mp3309c: Add support for MPS MP3309C
Message-ID: <20230829162814.GA56339@aspen.lan>
References: <20230829101546.483189-1-f.suligoi@asem.it>
 <20230829101546.483189-2-f.suligoi@asem.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829101546.483189-2-f.suligoi@asem.it>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 12:15:46PM +0200, Flavio Suligoi wrote:
> The Monolithic Power (MPS) MP3309C is a WLED step-up converter, featuring a
> programmable switching frequency to optimize efficiency.
> The brightness can be controlled either by I2C commands (called "analog"
> mode) or by a PWM input signal (PWM mode).
> This driver supports both modes.
>
> For DT configuration details, please refer to:
> - Documentation/devicetree/bindings/leds/backlight/mps,mp3309c.yaml
>
> The datasheet is available at:
> - https://www.monolithicpower.com/en/mp3309c.html
>
> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>

> diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
> index 51387b1ef012..65d0ac9f611d 100644
> --- a/drivers/video/backlight/Kconfig
> +++ b/drivers/video/backlight/Kconfig
> @@ -389,6 +389,19 @@ config BACKLIGHT_LM3639
>  	help
>  	  This supports TI LM3639 Backlight + 1.5A Flash LED Driver
>
> +config BACKLIGHT_MP3309C
> +	tristate "Backlight Driver for MPS MP3309C"
> +	depends on I2C
> +	select REGMAP_I2C
> +	select NEW_LEDS
> +	select LEDS_CLASS

This doesn't seem right.

Shouldn't PWM and GPIOLIB be listed here? Why are NEW_LEDS and
LEDS_CLASS needed?

> +	help
> +	  This supports MPS MP3309C backlight WLED Driver in both PWM and
> +	  analog/I2C dimming modes.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called mp3309c_bl.
> +
>  config BACKLIGHT_LP855X
>  	tristate "Backlight driver for TI LP855X"
>  	depends on I2C && PWM

> +static int mp3309c_bl_update_status(struct backlight_device *bl)
> +{
> +	struct mp3309c_chip *chip = bl_get_data(bl);
> +	int brightness = backlight_get_brightness(bl);
> +	struct pwm_state pwmstate;
> +	unsigned int analog_val, bits_val;
> +	int i, ret;
> +
> +	if (chip->pdata->dimming_mode == DIMMING_PWM) {
> +		/*
> +		 * PWM dimming mode
> +		 */
> +		pwm_init_state(chip->pwmd, &pwmstate);
> +		pwm_set_relative_duty_cycle(&pwmstate, brightness,
> +					    chip->pdata->max_brightness);
> +		pwmstate.enabled = true;
> +		ret = pwm_apply_state(chip->pwmd, &pwmstate);
> +		if (ret)
> +			return ret;
> +	} else {
> +		/*
> +		 * Analog dimming mode by I2C commands
> +		 *
> +		 * The 5 bits of the dimming analog value D4..D0 is allocated
> +		 * in the I2C register #0, in the following way:
> +		 *
> +		 *     +--+--+--+--+--+--+--+--+
> +		 *     |EN|D0|D1|D2|D3|D4|XX|XX|
> +		 *     +--+--+--+--+--+--+--+--+
> +		 */
> +		analog_val = DIV_ROUND_UP(ANALOG_MAX_VAL * brightness,
> +					  chip->pdata->max_brightness);
> +		bits_val = 0;
> +		for (i = 0; i <= 5; i++)
> +			bits_val += ((analog_val >> i) & 0x01) << (6 - i);
> +		ret = regmap_update_bits(chip->regmap, REG_I2C_0,
> +					 ANALOG_REG_MASK, bits_val);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (brightness > 0) {
> +		switch (chip->pdata->status) {
> +		case FIRST_POWER_ON:
> +			/*
> +			 * Only for the first time, wait for the optional
> +			 * switch-on delay and then enable the device.
> +			 * Otherwise enable the backlight immediately.
> +			 */
> +			schedule_delayed_work(&chip->enable_work,
> +					      msecs_to_jiffies(chip->pdata->switch_on_delay_ms));

Delaying this work makes no sense to me, especially when it is only
going to happen at initial power on.

If you are (ab)using this property to try and sequence the backlight
power-on with display initialization then this is not the way to do it.
Normally backlight drivers that support sequencing versus the panel
work by having a backlight property set on the panel linking it to the
backlight. When the panel is ready this power status of the backlight
will be updated accordingly.

All the backlight driver need do is make sure that is the initial
power status is "powerdown" on systems when the link is present (e.g.
leave the backlight off and wait to be told the display has settled).


> +			/*
> +			 * Optional external device GPIO reset, with
> +			 * delay pulse length
> +			 */
> +			if (chip->pdata->reset_pulse_enable)
> +				schedule_delayed_work(&chip->reset_gpio_work,
> +						      msecs_to_jiffies(chip->pdata->reset_on_delay_ms));

Similarly I don't understand what this property is for. A backlight is
directly perceivable by the user. There is nothing downstream of a
light that needs to be reset!

What is this used for?


Daniel.
