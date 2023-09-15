Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329637A16A9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 08:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjIOG6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 02:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjIOG6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 02:58:30 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CEF2723
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 23:57:49 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-52a49a42353so2084444a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 23:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694761067; x=1695365867; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mrvfAiSK7JccK6gs6IrA/UaK6A3zG87gl/ONIil2/b0=;
        b=nc6wOztqCVx5jBCxOXvLKPE5rUNbXbIYo47D3Mg2W4YQaFr5zwMHboksjkJm9/TdzD
         KF58M/MDrXMth4r0igll4LuUbd5HyDawzgzhANUs6dfemXrzof2ALExx5haga7ThvFsR
         2AyJeku+XCoFdL3/2w81XY+ZZrF2LwUz48CmwKQUXtSdBtp/KYPcDKvKHFapNl0DCPV+
         pHh/sTbujyPAG6/itog6gXOQ/IH09xQB9PLt5322cT3glFBGfaAI9+h438FjKXoTV+Yv
         1Z6u5qSxQFlsgdQ2470Xvc0IWJLCLoRmFnj6NCQG/kStSqPPdhEJNW1sUzMpRJYkrKeD
         kkjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694761067; x=1695365867;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mrvfAiSK7JccK6gs6IrA/UaK6A3zG87gl/ONIil2/b0=;
        b=ho3JJO+hHcyK8sWuc4a8qL08DKS48477KMJP6q244RzbxYlZdOib/9qSqtt0PGHkV6
         e4BoKSMm9+gO7b1DYH/iYj35/u7kXpGFiYk1WYjsiaP0PwrrFdw+r4JsUK5t0orgemws
         z1jfiIvEsZfaBD9GaJVx0VnI+CU+tFjSMIjtQzU9KnKJirbiws5aTMyBGQW4AFjpeP5i
         Cvt+yWkNG7o0y7oyEd9w0+GrbvLn0dj7PB+aQPiFzYvSLkJDCOjGKD/fl+utYe7gpGKZ
         aDLm+9UIssuy05jOKYU16hSHaY6QGTn/K0EvcDdl7dc1sNqnOihma/mRF+u846fkd8A2
         Zxug==
X-Gm-Message-State: AOJu0Yznwn0sL46Bq51YnYCsCQuldYDUfUVEGtUoFzH6Q9u/QmpTU/SM
        M8Zkc97zeuWB8gxfODoAeBrYPw==
X-Google-Smtp-Source: AGHT+IFDv496DEo2AdsX7GvL+J7vxIAuslRk03h6wOUukiHEPzG08G0Z5i5cZZI0zrwf/suE26aasw==
X-Received: by 2002:a17:907:1dd5:b0:9a1:bd82:de24 with SMTP id og21-20020a1709071dd500b009a1bd82de24mr598196ejc.12.1694761067550;
        Thu, 14 Sep 2023 23:57:47 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id f26-20020a170906495a00b0099d45ed589csm1964473ejt.125.2023.09.14.23.57.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 23:57:47 -0700 (PDT)
Message-ID: <6566084c-2a10-45bb-b016-b1810d137351@linaro.org>
Date:   Fri, 15 Sep 2023 08:57:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/2] usb: typec: tps6598x: add reset gpio support
Content-Language: en-US
To:     Javier Carrasco <javier.carrasco@wolfvision.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230912-topic-tps6598x_reset-v1-0-78dc0bf61790@wolfvision.net>
 <20230912-topic-tps6598x_reset-v1-1-78dc0bf61790@wolfvision.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230912-topic-tps6598x_reset-v1-1-78dc0bf61790@wolfvision.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2023 08:50, Javier Carrasco wrote:
> The TPS6598x PD controller provides an active-high hardware reset input
> that reinitializes all device settings. If it is not grounded by
> design, the driver must be able to de-assert it in order to initialize
> the device.
> 
> The PD controller is not ready for registration right after the reset
> de-assertion and a delay must be introduced in that case. According to
> TI, the delay can reach up to 1000 ms [1], which is in line with the
> experimental results obtained with a TPS65987D.
> 
> Add a GPIO descriptor for the reset signal and basic reset management
> for initialization and suspend/resume.
> 
> [1] https://e2e.ti.com/support/power-management-group/power-management/
> f/power-management-forum/1269856/tps65987d-tps65987d-reset-de-assert-
> to-normal-operation/4809389#4809389
> 
> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
> ---
>  drivers/usb/typec/tipd/core.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index 37b56ce75f39..550f5913e985 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -8,6 +8,7 @@
>  
>  #include <linux/i2c.h>
>  #include <linux/acpi.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/power_supply.h>
> @@ -43,6 +44,9 @@
>  /* TPS_REG_SYSTEM_CONF bits */
>  #define TPS_SYSCONF_PORTINFO(c)		((c) & 7)
>  
> +/* reset de-assertion to ready for operation */
> +#define SETUP_MS			1000

1 second? That's a bit a lot. Does it come from datasheet?

> +
>  enum {
>  	TPS_PORTINFO_SINK,
>  	TPS_PORTINFO_SINK_ACCESSORY,
> @@ -86,6 +90,7 @@ struct tps6598x {
>  	struct mutex lock; /* device lock */
>  	u8 i2c_protocol:1;
>  
> +	struct gpio_desc *reset;
>  	struct typec_port *port;
>  	struct typec_partner *partner;
>  	struct usb_pd_identity partner_identity;
> @@ -717,6 +722,13 @@ static int tps6598x_probe(struct i2c_client *client)
>  	mutex_init(&tps->lock);
>  	tps->dev = &client->dev;
>  
> +	tps->reset = devm_gpiod_get_optional(tps->dev, "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(tps->reset))
> +		return dev_err_probe(tps->dev, PTR_ERR(tps->reset),
> +				     "failed to get reset GPIO\n");
> +	if (tps->reset)
> +		msleep(SETUP_MS);
> +
>  	tps->regmap = devm_regmap_init_i2c(client, &tps6598x_regmap_config);
>  	if (IS_ERR(tps->regmap))
>  		return PTR_ERR(tps->regmap);
> @@ -892,6 +904,9 @@ static void tps6598x_remove(struct i2c_client *client)
>  	tps6598x_disconnect(tps, 0);
>  	typec_unregister_port(tps->port);
>  	usb_role_switch_put(tps->role_sw);
> +
> +	if (tps->reset)
> +		gpiod_set_value_cansleep(tps->reset, 1);
>  }
>  
>  static int __maybe_unused tps6598x_suspend(struct device *dev)
> @@ -902,7 +917,8 @@ static int __maybe_unused tps6598x_suspend(struct device *dev)
>  	if (tps->wakeup) {
>  		disable_irq(client->irq);
>  		enable_irq_wake(client->irq);
> -	}
> +	} else if (tps->reset)
> +		gpiod_set_value_cansleep(tps->reset, 1);

Missing {} (see Linux coding style).

>  
>  	if (!client->irq)
>  		cancel_delayed_work_sync(&tps->wq_poll);
> @@ -918,6 +934,9 @@ static int __maybe_unused tps6598x_resume(struct device *dev)
>  	if (tps->wakeup) {
>  		disable_irq_wake(client->irq);
>  		enable_irq(client->irq);
> +	} else if (tps->reset) {
> +		gpiod_set_value_cansleep(tps->reset, 0);
> +		msleep(SETUP_MS);
>  	}
>  
>  	if (!client->irq)
> 

Best regards,
Krzysztof

