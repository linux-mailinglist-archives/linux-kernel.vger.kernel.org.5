Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1155C7A1C5D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 12:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbjIOKgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 06:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbjIOKgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 06:36:13 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4822A1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 03:36:07 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9ada2e6e75fso264006366b.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 03:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694774166; x=1695378966; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YOGuQvyKIEvGatIdgqwwx1vnmFxyP0QzDb7QKoox0rU=;
        b=KNW3zmZj4hD//4GOVtgSBq9/ON/12lATBn4v7X+qDLZNpbBS9ILJA7AKfYlYGQrZUT
         Zn2MUSJxIMkUyxp7tMs0MjMICJ15iGhgJAvKSJgKC7HhrN6kxLT0qTrnTrr+qkheYbZw
         XT8uKLgqZ2yiy96Isoki+I/H0IoFG1CoWDypvZwTEVNQLw2A2i9VXM21C1nVOU5XAs6l
         DnkOc+PdvTkULUg5oOEdyjxAob2lJjvCUgW//83MN4NsQSNm9xqcQdY3EsbK+MBx8iKU
         //vONQUxhODriVqVjeY7XZcl25tMAkFFIKmT9H63gOFxBz9WY/ntha+aMFeWyp4UH/Bi
         YeJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694774166; x=1695378966;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YOGuQvyKIEvGatIdgqwwx1vnmFxyP0QzDb7QKoox0rU=;
        b=hQwShuK/KfazFs4kYhqHq16GBrMsU2ktkcjJ07b0a2uP/+YzGm4Rubjw9ANcDq0mdD
         WHK9Rab6gySwwR//Cq8hCdQasORo6DfNiSzHJwnt2PC3NDrTVPk9eg+tuwe44jo+Zy2P
         JqF3nzI8fSjNAbHqUUjIHR9/alHv9TQN3Mbfrn+fvd1KZoz1XhixQ4NVYcxI7YGneCr9
         n9KMUvwGmxS55sPisGFYlAu0MqvFcomwDy8CJCwAiikgseodnZ5GTeoD2bqPw9gEz5vD
         VLA/DJu3AcqDD2rhK6fucremW1t1dalvdhAv8OJcgK8gpW+FCeSNyyWzH4CqVhInMqCo
         tRoA==
X-Gm-Message-State: AOJu0Yz0yZgDrKvi5aVEpjAKLlUD3+x4xbM20OhIZ4z1iMyj3UTx7UnF
        bg2jXWDHvuZ0UE+Dbqzw1Zd/kw==
X-Google-Smtp-Source: AGHT+IGS0jKR8/GziN8CPYCaB+oKHmwOUHJOR8LOLDNfKE1g71vzGMk2ygtAxDqrZgORxBrUTqjoxg==
X-Received: by 2002:a17:906:3019:b0:9a9:f14f:7e3b with SMTP id 25-20020a170906301900b009a9f14f7e3bmr1169368ejz.16.1694774166327;
        Fri, 15 Sep 2023 03:36:06 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id z15-20020a17090655cf00b00997d7aa59fasm2274540ejp.14.2023.09.15.03.36.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 03:36:05 -0700 (PDT)
Message-ID: <aa15d41e-c05b-7fc5-77fb-9416f4f190b5@linaro.org>
Date:   Fri, 15 Sep 2023 12:36:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v4 03/42] dt-bindings: clock: Add Cirrus EP93xx
Content-Language: en-US
To:     nikita.shubin@maquefel.me,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
References: <20230915-ep93xx-v4-0-a1d779dcec10@maquefel.me>
 <20230915-ep93xx-v4-3-a1d779dcec10@maquefel.me>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230915-ep93xx-v4-3-a1d779dcec10@maquefel.me>
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

On 15/09/2023 10:10, Nikita Shubin via B4 Relay wrote:
> From: Nikita Shubin <nikita.shubin@maquefel.me>
> 

Thank you for your patch. There is something to discuss/improve.


> diff --git a/include/dt-bindings/clock/cirrus,ep9301-clk.h b/include/dt-bindings/clock/cirrus,ep9301-clk.h
> new file mode 100644
> index 000000000000..3cd053c0fdea
> --- /dev/null
> +++ b/include/dt-bindings/clock/cirrus,ep9301-clk.h
> @@ -0,0 +1,41 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> +#ifndef DT_BINDINGS_CIRRUS_EP93XX_CLOCK_H
> +#define DT_BINDINGS_CIRRUS_EP93XX_CLOCK_H
> +
> +#define EP93XX_CLK_UART1	0
> +#define EP93XX_CLK_UART2	1
> +#define EP93XX_CLK_UART3	2
> +
> +#define EP93XX_CLK_ADC		3
> +#define EP93XX_CLK_ADC_EN	4
> +
> +#define EP93XX_CLK_KEYPAD   5

Wrong indentation - use tab instead of spaces, just like in other places.

> +
> +#define EP93XX_CLK_VIDEO	6
> +
> +#define EP93XX_CLK_I2S_MCLK	7
> +#define EP93XX_CLK_I2S_SCLK	8
> +#define EP93XX_CLK_I2S_LRCLK	9
> +
> +#define EP93XX_CLK_UART		10
> +#define EP93XX_CLK_SPI		11
> +#define EP93XX_CLK_PWM		12
> +#define EP93XX_CLK_USB		13
> +
> +#define EP93XX_CLK_M2M0		14
> +#define EP93XX_CLK_M2M1		15
> +
> +#define EP93XX_CLK_M2P0		16
> +#define EP93XX_CLK_M2P1		17
> +#define EP93XX_CLK_M2P2		18
> +#define EP93XX_CLK_M2P3		19
> +#define EP93XX_CLK_M2P4		20
> +#define EP93XX_CLK_M2P5		21
> +#define EP93XX_CLK_M2P6		22
> +#define EP93XX_CLK_M2P7		23
> +#define EP93XX_CLK_M2P8		24
> +#define EP93XX_CLK_M2P9		25
> +
> +#define EP93XX_CLK_END      26

Here as well... except I propose to drop it. Number of clocks should not
be part of bindings, because then you cannot grow it.

With indentation fixed and CLK_END dropped:


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

