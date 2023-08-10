Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFEC777024
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 08:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbjHJGRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 02:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjHJGRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 02:17:15 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90AFDA6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 23:17:13 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-523476e868dso627643a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 23:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691648232; x=1692253032;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lf7MUwtQSYoSziIqO/LEqDEzuuUibdtAfSye9h1PoUI=;
        b=MiRLqH5zRpQ2CxQQCiKc0iFTQSW99OHXSSWkSG8EU7li0bCz/ik/Pfnj1E7qyaBXaw
         KbXPps6ltWnHKOq6+Bi7CLYLDBVZmlIijGzN/Cl5KPADgIMG6Hqhlsqvrlecjbdpln/Z
         Ad7QsWr5ZIpi0ZrSROfUfrwrligNoy1jm2V0MzCPyM91Y4MFgQGo6z6NU7MIxKo7QJok
         2C9jOM9W5BShPWxqFW7/zxQ8+3kVrq675QnEsiDVI3AJYKbQRoIrYUFFhvxGvsWLXGcS
         XDVtIZkoLdGjjLX0QMIVomAfQFOYNrmJJsWTk4xfIWtcQbbF2WMKtggKi0+ZjWK2mFyQ
         IwhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691648232; x=1692253032;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lf7MUwtQSYoSziIqO/LEqDEzuuUibdtAfSye9h1PoUI=;
        b=KtS4WQdIC1Oi+WeR8o0HRknmQQs+QxD9OBXLC8p/vhHdbeFqZeXoAqELrE35DDsI2C
         hZhKcmPQEQg5Inaq3t+u+nG9H/HJFxMOWrSKMbzBLNIVDU6fgm3pWAPBmyTCrOOGK7Mu
         wxgpF0gd4tNODpddjGdW8/WLiLLJdZrLV26xUzrRmmNeP4lDj4yrnqJPAg/IcQ2J/jYE
         lgekaxdEu7oolEIjykP8Gd5CAmwOBR/DYA7/138IOl5hdQehHVHZo7FcsljHfyH6YLiy
         cvL0iDJv3IDAzRiC2TD5WaogS5V8vjfKFcgAa5JzIkgTPi3C3wWUeU5QdhoWvpLFzRPe
         03gg==
X-Gm-Message-State: AOJu0Yz5G+F2aLpo4AOnXZkcyrMmafClXe2xtoNbBNzCa6AD4P/K4dOl
        2qHAgpDlf7/1CoWZk0vmB5Ur7A==
X-Google-Smtp-Source: AGHT+IEtUBDhZmyWwvKFX0NSIzadbGkypyNjmi89znYMOc3SB125UDs4hLiZCUstgcABlUAneUl2sA==
X-Received: by 2002:a17:906:74c2:b0:98e:933:2909 with SMTP id z2-20020a17090674c200b0098e09332909mr1431616ejl.22.1691648232043;
        Wed, 09 Aug 2023 23:17:12 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id lf6-20020a170906ae4600b0099cf840527csm455247ejb.153.2023.08.09.23.17.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 23:17:11 -0700 (PDT)
Message-ID: <d1b9e063-54df-2dae-1487-c7c932fda145@linaro.org>
Date:   Thu, 10 Aug 2023 08:17:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 2/2] Input: cs40l50 - Initial support for Cirrus Logic
 CS40L50
Content-Language: en-US
To:     James Ogletree <james.ogletree@cirrus.com>,
        dmitry.torokhov@gmail.com
Cc:     Fred Treven <fred.treven@cirrus.com>,
        Ben Bright <ben.bright@cirrus.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Jeff LaBundy <jeff@labundy.com>, Joel Stanley <joel@jms.id.au>,
        Arnd Bergmann <arnd@arndb.de>, Jacky Bai <ping.bai@nxp.com>,
        Jean Delvare <jdelvare@suse.de>,
        Eddie James <eajames@linux.ibm.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        patches@cirrus.com, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230809191032.820271-1-james.ogletree@cirrus.com>
 <20230809191032.820271-3-james.ogletree@cirrus.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230809191032.820271-3-james.ogletree@cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/2023 21:10, James Ogletree wrote:
> Introduce support for Cirrus Logic Device CS40L50: a
> haptics driver with waveform memory DSP and closed-loop
> algorithms.
> 
> Signed-off-by: James Ogletree <james.ogletree@cirrus.com>

...

> +
> +static int cs40l50_cs_dsp_init(struct cs40l50_private *cs40l50)
> +{
> +	cs40l50->dsp.num = 1;
> +	cs40l50->dsp.type = WMFW_HALO;
> +	cs40l50->dsp.dev = cs40l50->dev;
> +	cs40l50->dsp.regmap = cs40l50->regmap;
> +	cs40l50->dsp.base = CS40L50_DSP1_CORE_BASE;
> +	cs40l50->dsp.base_sysinfo = CS40L50_DSP1_SYS_INFO_ID;
> +	cs40l50->dsp.mem = cs40l50_dsp_regions;
> +	cs40l50->dsp.num_mems = ARRAY_SIZE(cs40l50_dsp_regions);
> +	cs40l50->dsp.lock_regions = 0xFFFFFFFF;
> +	cs40l50->dsp.no_core_startstop = true;
> +	cs40l50->dsp.client_ops = &cs40l50_cs_dsp_client_ops;
> +
> +	return cs_dsp_halo_init(&cs40l50->dsp);
> +}
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
> +	if (error)
> +		return dev_err_probe(cs40l50->dev, error, "Failed to request supplies\n");
> +
> +	error = regulator_bulk_enable(ARRAY_SIZE(cs40l50_supplies), cs40l50_supplies);
> +	if (error)
> +		return dev_err_probe(cs40l50->dev, error, "Failed to enable supplies\n");
> +
> +	cs40l50->reset_gpio = devm_gpiod_get_optional(cs40l50->dev, "reset", GPIOD_OUT_HIGH);

None of the lines above or below seem to be wrapped according to Linux
coding style (80).

> +	if (IS_ERR(cs40l50->reset_gpio)) {
> +		error = PTR_ERR(cs40l50->reset_gpio);
> +		goto err;

Why do you disable IRQ now?

I asked to test this. Your entire cleanup path is:
1. not tested.
2. buggy.
3. done differently than Linux style. Use proper cleanup calls and
multiple goto labels.

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

Nothing improved here. Don't send new version immediately after
responding to my comment, but allow discussion.

Best regards,
Krzysztof

