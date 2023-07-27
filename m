Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C947764F0A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 11:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233873AbjG0JOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 05:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234653AbjG0JNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 05:13:24 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4235144B1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 02:04:01 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-992dcae74e0so92053466b.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 02:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690448640; x=1691053440;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o+nMtMSYCB8lb+6HEt8kXyZny9RP0k44HK0QsEHwLZY=;
        b=pE8EZ7SDhjgXVr5jF35gUXQ2wZokNnxbBeLaIg4EKcIZA/Qw0vi3f9uSrRCkf0TSq6
         k1m09915OJqyPOK+QofmyBb/OAyNwQ6C0vJnpvRlq5YlMVG/yKq+klwHwfaSU0aq3r1E
         dL9Be3MA6pEAOAGZlGBHS9d7S6NT8o2IlR7irAlVRrIbcZ4GzSIWNwKzVlKeqmFbbkVc
         zda5m4HgLhKyDx4pkj8nkp66c6WHmVwn7dCjpWRtZS4Sn2hXlgVd1iK/g4OjVyGNW/z5
         pwfBKWQ58aulU9kA8N7AhzXn2wJjSyzeSEQ7BFcf23KF9vj07ZvV0zcN8cbhZ4/vKttz
         FMPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690448640; x=1691053440;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o+nMtMSYCB8lb+6HEt8kXyZny9RP0k44HK0QsEHwLZY=;
        b=QRH8OCQu6SWhNM/8MLpiE92MrRs7cMpBps1a8+2izkjeNfM+Hadoit1wYLOsQwobxF
         nQ7eiAfxk3YBO5TuAvJkDeXrR4175d/oZ0BiefvTt5ztaTEFV2dAD7e0k+bYPGwM7fzh
         m6IyWMpCfSqVwPXvqO7qOhb3hXx6Bzkdo4HONNpX3hko3+k/Z51tZUaBg7m/657sAa6M
         rpu+oMHXfDtbu47K+EfQ/4tQZJUOBg3Gy+OqvBS5Jv+dQw20CAHthVPQlwhu64NwGYAM
         pbE/ymol2EJsKAYpwu8X1Ue2DGd5XQDvuV2jtg1Nk1iS8N6WbH7x5FzwOXEAGMH2hfm2
         U+Ag==
X-Gm-Message-State: ABy/qLbXkXMsaLvCtTfKhuUHD/ZXBvvflJ2PxVnFWZtSHEhpQP72FgPV
        jc+Cm5gKeGhb1ytA1vDochifUg==
X-Google-Smtp-Source: APBJJlGIY9tfAQuvHiyq47xqAXRRoPTeBIDcdXJ0RNoK3rwr28DVCiRwAjkyyM8nY1xjrjPfECKcAg==
X-Received: by 2002:a17:907:7798:b0:99b:d580:546c with SMTP id ky24-20020a170907779800b0099bd580546cmr1811202ejc.23.1690448639710;
        Thu, 27 Jul 2023 02:03:59 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id rs5-20020a170907036500b009929d998abcsm512639ejb.209.2023.07.27.02.03.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 02:03:59 -0700 (PDT)
Message-ID: <d3c77a86-f152-cad3-6087-6167656c4c9e@linaro.org>
Date:   Thu, 27 Jul 2023 11:03:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 2/2] gpio: ds4520: Add ADI DS4520 GPIO Expander Support
Content-Language: en-US
To:     Okan Sahin <okan.sahin@analog.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230727085239.4326-1-okan.sahin@analog.com>
 <20230727085239.4326-3-okan.sahin@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230727085239.4326-3-okan.sahin@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/2023 10:52, Okan Sahin wrote:
> The DS4520 is a 9-bit nonvolatile (NV) I/O expander.
> It offers users a digitally programmable alternative
> to hardware jumpers and mechanical switches that are
> being used to control digital logic node.
> 
> Signed-off-by: Okan Sahin <okan.sahin@analog.com>

...

> +static int ds4520_gpio_probe(struct i2c_client *client)
> +{
> +	struct gpio_regmap_config config = { };
> +	struct device *dev = &client->dev;
> +	struct regmap *regmap;
> +	u32 ngpio;
> +	u32 base;
> +	int ret;
> +
> +	ret = device_property_read_u32(dev, "reg", &base);
> +	if (ret) {
> +		dev_err_probe(dev, ret,
> +			  "Missing 'reg' property.\n");
> +		return -EINVAL;

Nope.

> +	}
> +
> +	ret = device_property_read_u32(dev, "ngpios", &ngpio);
> +	if (ret) {
> +		dev_err_probe(dev, ret,
> +			  "Missing 'ngpios' property.\n");
> +		return -EINVAL;

Nope.

> +	}
> +
> +	regmap = devm_regmap_init_i2c(client, &ds4520_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		ret = PTR_ERR(regmap);
> +		dev_err_probe(dev, ret,
> +			      "Failed to allocate register map\n");
> +		return ret;

That's not correct syntax. What did you receive in previous
comments/feedback?

Best regards,
Krzysztof

