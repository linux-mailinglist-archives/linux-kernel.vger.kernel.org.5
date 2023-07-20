Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9632375A615
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 08:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjGTGOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 02:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjGTGOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 02:14:15 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2938919B2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 23:14:14 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fdd14c1fbfso625988e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 23:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689833652; x=1692425652;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bn97h2kPeQxT2teRaIaG8kcjL4C15rmESxQkplgMClw=;
        b=iJjCCMAu3M3Y1cXnn/JZjkast6keMe+JztLfl7uNLYGkMnR9+kQq/d16CmMsim6LW3
         RbzgItDYJ2aOhPxhudZrEKSwS9MxQniVmWwC3jQTeQZN3pPg1XVqJtfNaBMHmvxz3Rf3
         K6L1PT6kH4S4dqrZLXs9n1Uk/La4L8hqgiZXCLNHYR6TdzEwO3+zrGaX9YYJR+9IWJS5
         TY3smnS0FdUHGkuIaEa3ztjGgG6sS5ZonPfnhxQrejgdy4iDNYMCeY2IdNUSHNx+Eghx
         +K6aPDSIg/TWybF1N3tPD7fvcFhNtvw/1fEMf4EonREJryaR1/QmMkxJjnoZWaoEmP+2
         Wk7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689833652; x=1692425652;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bn97h2kPeQxT2teRaIaG8kcjL4C15rmESxQkplgMClw=;
        b=PP5sOJ0A3EDmvFT3VbI4ATzTG3/4SYE54jx398O3Sh61BO4p6X5/rFkJQ/sPEiwR4O
         IOj7dD6XIThQ5CbrXD1bky5fT3OWZTMHZCOO22aRq57oMmtkNjbYNOGAwP57DvVv4unt
         thPkDvEKPSYLchfgiOLVZkCTX3Cl/S4w2xyQl1ZNBy9bFztb4SO9qavbd5muC+Gp14xl
         X0jt2aPl2jyRnsZmNFaLQIeY920UbOCONrwpoSipL2ivY6Sp/uMWmK4p/iHc4zvdvc+F
         e07mbeZS224rwt1y6NRhNlZXQIcDJQxEbMvMttvd5ROhBBKQwkz7AudLuXb3Lv4EGJTC
         Ptnw==
X-Gm-Message-State: ABy/qLbV8eyldzolGsM/8dGutg9Vz6RY1qoSDtXLkO8SFyyXfinHx0DM
        /bUqhk4+BxYb4fHnOOc+cizbzA==
X-Google-Smtp-Source: APBJJlFftkJ/9ysNAfpj91FCxFppSG3ujXVEDRddCe52HcrVa2MoP1OZryfU9E/eqZg4FlZX/zO3+w==
X-Received: by 2002:ac2:4bd2:0:b0:4fd:d0d5:8771 with SMTP id o18-20020ac24bd2000000b004fdd0d58771mr1823130lfq.18.1689833652341;
        Wed, 19 Jul 2023 23:14:12 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id e19-20020a05600c219300b003fbe791a0e8sm388889wme.0.2023.07.19.23.14.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 23:14:11 -0700 (PDT)
Message-ID: <5f867f68-4ad6-11c7-5c1f-f568889b0ddf@linaro.org>
Date:   Thu, 20 Jul 2023 08:14:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/3] rtc: Add driver for nuvoton ma35d1 rtc controller
Content-Language: en-US
To:     Jacky Huang <ychuang570808@gmail.com>, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        soc@kernel.org, mjchen@nuvoton.com, schung@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
References: <20230720012826.430026-1-ychuang570808@gmail.com>
 <20230720012826.430026-4-ychuang570808@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230720012826.430026-4-ychuang570808@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/07/2023 03:28, Jacky Huang wrote:
> From: Jacky Huang <ychuang3@nuvoton.com>
> 
> The ma35d1 rtc controller provides real-time and calendar messaging
> capabilities. It supports programmable time tick and alarm match
> interrupts. The time and calendar messages are expressed in BCD format.
> This driver supports the built-in rtc controller of the ma35d1. It
> enables setting and reading the rtc time and configuring and reading
> the rtc alarm.
> 

...

> +static int ma35d1_rtc_probe(struct platform_device *pdev)
> +{
> +	struct ma35_rtc *ma35_rtc;
> +	struct clk *clk;
> +	u32 regval;
> +	int err;
> +
> +	ma35_rtc = devm_kzalloc(&pdev->dev, sizeof(struct ma35_rtc),

sizeof(*)

> +								GFP_KERNEL);
> +	if (!ma35_rtc)
> +		return -ENOMEM;
> +
> +	ma35_rtc->rtc_reg = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(ma35_rtc->rtc_reg))
> +		return PTR_ERR(ma35_rtc->rtc_reg);
> +
> +	clk = of_clk_get(pdev->dev.of_node, 0);
> +	if (IS_ERR(clk)) {
> +		err = PTR_ERR(clk);
> +		dev_err(&pdev->dev, "failed to get core clk: %d\n", err);
> +		return -ENOENT;

return dev_err_probe

> +	}
> +	err = clk_prepare_enable(clk);
> +	if (err)
> +		return -ENOENT;
> +
> +	platform_set_drvdata(pdev, ma35_rtc);
> +
> +	ma35_rtc->rtcdev = devm_rtc_device_register(&pdev->dev, pdev->name,
> +						    &ma35d1_rtc_ops, THIS_MODULE);
> +	if (IS_ERR(ma35_rtc->rtcdev)) {
> +		dev_err(&pdev->dev, "rtc device register failed\n");
> +		return PTR_ERR(ma35_rtc->rtcdev);
> +	}
> +
> +	err = ma35d1_rtc_init(ma35_rtc, RTC_INIT_TIMEOUT);
> +	if (err)
> +		return err;
> +
> +	regval = rtc_reg_read(ma35_rtc, MA35_REG_RTC_CLKFMT);
> +	regval |= RTC_CLKFMT_24HEN;
> +	rtc_reg_write(ma35_rtc, MA35_REG_RTC_CLKFMT, regval);
> +
> +	ma35_rtc->irq_num = platform_get_irq(pdev, 0);
> +
> +	if (devm_request_irq(&pdev->dev, ma35_rtc->irq_num, ma35d1_rtc_interrupt,
> +			     IRQF_NO_SUSPEND, "ma35d1rtc", ma35_rtc)) {
> +		dev_err(&pdev->dev, "ma35d1 RTC request irq failed\n");
> +		return -EBUSY;

return dev_err_probe

> +	}
> +
> +	regval = rtc_reg_read(ma35_rtc, MA35_REG_RTC_INTEN);
> +	regval |= RTC_INTEN_TICKIEN;
> +	rtc_reg_write(ma35_rtc, MA35_REG_RTC_INTEN, regval);
> +
> +	device_init_wakeup(&pdev->dev, true);
> +
> +	return 0;
> +}
> +
> +static int __exit ma35d1_rtc_remove(struct platform_device *pdev)

It's not an exit.

> +{
> +	device_init_wakeup(&pdev->dev, false);
> +
> +	platform_set_drvdata(pdev, NULL);

Just drop remove. You don't do anything useful here.


> +
> +	return 0;
> +}
> +
> +static int ma35d1_rtc_suspend(struct platform_device *pdev, pm_message_t state)
> +{
> +	struct ma35_rtc *ma35_rtc = platform_get_drvdata(pdev);
> +	u32 regval;
> +
> +	if (device_may_wakeup(&pdev->dev))
> +		enable_irq_wake(ma35_rtc->irq_num);
> +
> +	regval = rtc_reg_read(ma35_rtc, MA35_REG_RTC_INTEN);
> +	regval &= ~RTC_INTEN_TICKIEN;
> +	rtc_reg_write(ma35_rtc, MA35_REG_RTC_INTEN, regval);
> +
> +	return 0;
> +}
> +
> +static int ma35d1_rtc_resume(struct platform_device *pdev)
> +{
> +	struct ma35_rtc *ma35_rtc = platform_get_drvdata(pdev);
> +	u32 regval;
> +
> +	if (device_may_wakeup(&pdev->dev))
> +		disable_irq_wake(ma35_rtc->irq_num);
> +
> +	regval = rtc_reg_read(ma35_rtc, MA35_REG_RTC_INTEN);
> +	regval |= RTC_INTEN_TICKIEN;
> +	rtc_reg_write(ma35_rtc, MA35_REG_RTC_INTEN, regval);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id ma35d1_rtc_of_match[] = {
> +	{ .compatible = "nuvoton,ma35d1-rtc", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, ma35d1_rtc_of_match);
> +
> +static struct platform_driver ma35d1_rtc_driver = {
> +	.remove     = __exit_p(ma35d1_rtc_remove),
> +	.suspend    = ma35d1_rtc_suspend,
> +	.resume     = ma35d1_rtc_resume,
> +	.probe      = ma35d1_rtc_probe,
> +	.driver		= {
> +		.name	= "rtc-ma35d1",
> +		.owner	= THIS_MODULE,

??? No.

> +		.of_match_table = of_match_ptr(ma35d1_rtc_of_match),

Drop of_match_ptr. Didn't you get such comment before? Your other
submission also had the same bug...

Actually, most of these comments you already received for your other
drivers, so it would be great if we did not have to repeat it for every
new driver from you.

Best regards,
Krzysztof

