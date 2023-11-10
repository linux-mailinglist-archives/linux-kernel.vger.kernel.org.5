Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE647E80E7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345880AbjKJSUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:20:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235598AbjKJSRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:17:18 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A929333F9D
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 04:27:40 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40839807e82so12243735e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 04:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699619259; x=1700224059; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8EJtfoWrYibrvvyf7DDtBK1pc0WtivZ03vd9ez0zk9M=;
        b=oBO+AhV7fW58gp1AEeB1eSOuO/sl7zjS14Ls5KHvlhqa2iaIEvVE8QtNr7npMto1+k
         Z00AFzS+gejahL7kSXwzVu6Gm9uejC2naTAHJY0iWxlVdCbpWy9x93j8vOaNli81hsUm
         a+g6UV+h0ocYSwtHUUgaYey5BVhPv5TvzQjZDjh7BUZtDiIaMY+9T6q/KzCeFfoRrsO5
         cRSXp/kcwBZUI/G6mQecP9L0EZal8F9KmLtH6kea8zXj78UKqOgNx8oEK+ZHTt/zwmel
         ko7kiFxR7hCuFtd40SrTQlNjJBqIGhx//vzIMO2bT1mxPqmxQR97zevDQncEAT4C+08w
         5DkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699619259; x=1700224059;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8EJtfoWrYibrvvyf7DDtBK1pc0WtivZ03vd9ez0zk9M=;
        b=RD1AMQTk26HboJbhzdON1lHV/e4stJ6k+7BsPC/E2+YR2UAZN/C7M5TBdG0DLPJHM0
         vF4OqP6BPha+lwC2W5LNRnQIVp6xKTLP5y0SFeZ+bexvay7lgYSx1b6J2mXVWl4+Y3eU
         zdEh0lrzcDwAXZ6cYxkA0/ZgHKWlf7lZ3ozpiTSWbYhNQzbZ5jbIDXGtPa1ikRc3FBjW
         CJxKt4qeb7yorFPykwuKXGUE4FN42QpiHviPYkHz2AeZJqMmgUPUIVLAOdgwJ/lVA+lx
         ND4nT0J/XjIZrzsZV2m9hVGMcqXkLGc7I0Avzw0obUbvhMR7AYLTNR6dFlla6JixoS54
         5LKA==
X-Gm-Message-State: AOJu0YyRPvPCETYt7Zn5Y0MQbIvzKaHEdzkS2QSwqSXuOBD5Y0fFESwr
        RCxyOmnasUfYCfiG3x6bLVDx2g==
X-Google-Smtp-Source: AGHT+IHhFC8+acrJ15sJ9jd+I8MBXyTvFfbwQZyiZ96JDCYY/icKa8sVEJYynTX87bbtgHzKDsC12w==
X-Received: by 2002:a05:600c:3c85:b0:401:c7ec:b930 with SMTP id bg5-20020a05600c3c8500b00401c7ecb930mr2859919wmb.10.1699619259077;
        Fri, 10 Nov 2023 04:27:39 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id d14-20020a05600c34ce00b00406443c8b4fsm5028154wmq.19.2023.11.10.04.27.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Nov 2023 04:27:38 -0800 (PST)
Message-ID: <66173ccd-4478-4622-a386-557a8d35102f@linaro.org>
Date:   Fri, 10 Nov 2023 13:27:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/4] pwm: opencores: Add PWM driver support
Content-Language: en-US
To:     William Qiu <william.qiu@starfivetech.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Hal Feng <hal.feng@starfivetech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
References: <20231110062039.103339-1-william.qiu@starfivetech.com>
 <20231110062039.103339-3-william.qiu@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231110062039.103339-3-william.qiu@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/2023 07:20, William Qiu wrote:
> Add Pulse Width Modulation driver support for OpenCores.

What is OpenCores? Why all your commit messages lack basic explanation
of the hardware you are working on?

> 


> +static const struct ocores_pwm_data jh7100_pwm_data = {
> +	.get_ch_base = starfive_jh71x0_get_ch_base,
> +};
> +
> +static const struct ocores_pwm_data jh7110_pwm_data = {
> +	.get_ch_base = starfive_jh71x0_get_ch_base,
> +};
> +
> +static const struct of_device_id ocores_pwm_of_match[] = {
> +	{ .compatible = "opencores,pwm" },
> +	{ .compatible = "starfive,jh7100-pwm", .data = &jh7100_pwm_data},
> +	{ .compatible = "starfive,jh7110-pwm", .data = &jh7110_pwm_data},

Your bindings say something entirely else.

I don't understand what is happening with this patchset.


> +	{ /* sentinel */ }
> +};

...

> +	ddata->regs = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(ddata->regs))
> +		return dev_err_probe(dev, PTR_ERR(ddata->regs),
> +				     "Unable to map IO resources\n");
> +
> +	ddata->clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(ddata->clk))
> +		return dev_err_probe(dev, PTR_ERR(ddata->clk),
> +				     "Unable to get pwm's clock\n");
> +
> +	ret = clk_prepare_enable(ddata->clk);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Clock enable failed\n");

dev_clk_get_enabled() or whatever the API is called

> +
> +	ddata->rst = devm_reset_control_get_optional_exclusive(dev, NULL);
> +	reset_control_deassert(ddata->rst);
> +
> +	ddata->clk_rate = clk_get_rate(ddata->clk);
> +	if (ddata->clk_rate <= 0)
> +		return dev_err_probe(dev, ddata->clk_rate,
> +				     "Unable to get clock's rate\n");
> +
> +	ret = devm_pwmchip_add(dev, chip);
> +	if (ret < 0) {
> +		dev_err_probe(dev, ret, "Could not register PWM chip\n");
> +		clk_disable_unprepare(ddata->clk);
> +		reset_control_assert(ddata->rst);

return dev_err_probe

> +	}
> +
> +	platform_set_drvdata(pdev, ddata);
> +
> +	return ret;
> +}
> +
> +static void ocores_pwm_remove(struct platform_device *dev)
> +{
> +	struct ocores_pwm_device *ddata = platform_get_drvdata(dev);
> +
> +	reset_control_assert(ddata->rst);
> +	clk_disable_unprepare(ddata->clk);

You have confusing order of cleanups. It's like random, once clock then
reset, in other place reset then clock.

Best regards,
Krzysztof

