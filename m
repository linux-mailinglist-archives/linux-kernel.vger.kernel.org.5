Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824DC809DDA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 09:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573382AbjLHIFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 03:05:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573333AbjLHIF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 03:05:27 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E061722
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 00:05:33 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-54f4f7e88feso450966a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 00:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702022732; x=1702627532; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1y9Kggh7VbVtRpyh5e/trCIA76Q57MkvN5BQiNr2TJ4=;
        b=C/+8d5yea6dn+tIklqkOHpicWGpZP6pic9gbKg0pc+kAwdYXH1M8wTg/4sVhzAiyJ3
         vvUkjB1z6MHvsCWlCJTH57jjMSUJ9PnEHidbFWzbAVbHq/NL/n/Si8RMtIiAV898fwbt
         ZgSB3/rVgTjIS2NQRj+s5Bs8f1V7WbM/U7mmR2ZBZhmbIYWvK8XY3m3Aay+npiIWI9Gg
         xpkr0PQy8UHjqVsEuBR0M8Lshs5tCRRQG0f5aIOsbrxMHrEmTEJupIVvYWdQz2PcI9gf
         VXnzyNWa+bT/Ug5L4EDMK8i26N6kqSUMQlsxZy2ZoWhGG9lc+Fn2f3Rw1kV22Oa6+aK4
         6odg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702022732; x=1702627532;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1y9Kggh7VbVtRpyh5e/trCIA76Q57MkvN5BQiNr2TJ4=;
        b=hlPapbpM4ABNxGTj7OYPZgMDYE+lzbhY1QmdvUvYWxfXHYEH8GZpr6sYfEWdvNutjd
         SFPMqiuRmpkfx7Yc4aYtM1XkDxLIs/wH8FA7NWodW8JpUTOvPbTuTOTmcGp70RkPBVmB
         aEmr4bGaia2xrSprkQdBvAzWOF7pDgYndPvxvo0pXrZJXRCqf9HkH55p3G9bARxgW4jq
         G3mA8i3Wd50hxhz/diQVC4C3tLS8OIYMygBRtbtGrvKS99TYF++tNA0MBunyKwPTikC2
         GObfB0c2Ui+r5SEIGeEeDgT84lPA7N4KxkoGw0ZpS6mGOuHaiesfVKB9s19b3p4BEKSE
         BfRw==
X-Gm-Message-State: AOJu0YyIVqvASyElhvrz1JUyeSYjtpSED2nhXetkWgfz0JUhC1sz+ygd
        xc0Z+qZ8QbkU8Tvz9d7HBYFuFA==
X-Google-Smtp-Source: AGHT+IG3HKLX89fuGNg/w4ynlZZXGVrSygMZ5OsptSjgsK7PUVMHlbQi7NaMj2kyepCLeG8k4fpgJA==
X-Received: by 2002:a17:906:168d:b0:a1c:dc26:5c8c with SMTP id s13-20020a170906168d00b00a1cdc265c8cmr2479389ejd.61.1702022731789;
        Fri, 08 Dec 2023 00:05:31 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id tj7-20020a170907c24700b00a1c522990ccsm699615ejc.85.2023.12.08.00.05.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Dec 2023 00:05:31 -0800 (PST)
Message-ID: <5209ef11-e2c8-4399-913e-e1e0399e295d@linaro.org>
Date:   Fri, 8 Dec 2023 09:05:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/13] dt-bindings: iio: Add AD7091R-8
Content-Language: en-US
To:     Marcelo Schmitt <marcelo.schmitt@analog.com>, apw@canonical.com,
        joe@perches.com, dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
        paul.cercueil@analog.com, Michael.Hennerich@analog.com,
        lars@metafoo.de, jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        dan.carpenter@linaro.org, marcelo.schmitt1@gmail.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1701971344.git.marcelo.schmitt1@gmail.com>
 <53d55f3195b15bd8d47387e296036730ea270770.1701971344.git.marcelo.schmitt1@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <53d55f3195b15bd8d47387e296036730ea270770.1701971344.git.marcelo.schmitt1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2023 19:42, Marcelo Schmitt wrote:
> Add device tree documentation for AD7091R-8.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

Except what David said also:

> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@0 {
> +                compatible = "adi,ad7091r8";

Use 4 spaces for example indentation.

Best regards,
Krzysztof

