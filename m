Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C677ED60E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 22:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344914AbjKOVaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 16:30:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjKOVaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 16:30:01 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21FC92
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 13:29:57 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-45da75867d3so29674137.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 13:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700083797; x=1700688597; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nvwColjd0CZMsWSs31lKcrK/j6omfRcU5Ub2F8LVHb8=;
        b=l8lPqWeQTF91cVX5IG2FZxN7cHL8bmcU/ZVZm60dATwrAAMZePivoZo8T3NQuMjerq
         7GhAoMt+VIrl7tle8tdsox9Vg4ghc4a9uuwHHUarH058+SrzupIEbX0zTw77lAkNpg+b
         orXbA94FsdriMAVR8NZWZ8Jfopz07VwYbJMGbZWGXpg+Rh0balkbVkiYRl2mIf7hz629
         UTpJ0v339YGTFaMHrwnz0GSaCwhgwfIF1Nxq+ig9DAf9tU0TikxLEIGPi4YpCc5ey4Jo
         /6ARRi1htIwTTe2ObRs1flsFoaTjduIv/UVBwJ8Kspr9Jd5onRDfPdHs6HwHanoXrLqR
         yK+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700083797; x=1700688597;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nvwColjd0CZMsWSs31lKcrK/j6omfRcU5Ub2F8LVHb8=;
        b=ND12nwYo8v5W7w7eG3OPlO09+c+PMv81icxnbanL0quPSCzbgIO//nyXHgHs1AvU6W
         vafrNahrVwvfwSZs9re+fKbMcJ8so8hwhhi0bOzrBery9T5XwEId4R3HMqcwcuMHBeEw
         0kTmzdyc8zrz8QjxpljgDKuh5KYDDoOXVMEy196/GvRRaCPfm+/fDAw6OjUNEi5FeuRJ
         nL5HDL02wgQX6JGkogaanEXwRNUWhDhz3ckkgpw4HQcxDKVmiAO79L7y9FvH9zXTLxgt
         Ou+ow3T1DXXolTG1+y7cd/sC4D/oZXXz8lekIxukMqX3WrU3iNzzi+m1yqCzngVswo6A
         9wag==
X-Gm-Message-State: AOJu0YzGfJcW1ck89xMYAVU0cG68nv2hOGkK/MgRrWKfNZQT+Vsuj1MY
        G8w3oiaGRK4XF7ZCrbxYRqpMvqm3WGLngbGQnKI=
X-Google-Smtp-Source: AGHT+IFBVDh6PZcXH9v8G8FdwT9GTwpdMrkBMDicH5Zp1VA+Spg6JoCp9ZyIvbPpywauQoBL8h2WLQ==
X-Received: by 2002:a05:6102:158f:b0:45d:b6af:99ae with SMTP id g15-20020a056102158f00b0045db6af99aemr14927812vsv.35.1700083796873;
        Wed, 15 Nov 2023 13:29:56 -0800 (PST)
Received: from [172.25.83.73] ([12.186.190.2])
        by smtp.gmail.com with ESMTPSA id g9-20020ac84dc9000000b0041cb787ff41sm3793918qtw.67.2023.11.15.13.29.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 13:29:56 -0800 (PST)
Message-ID: <f24b9b2d-aeb1-47f7-bf21-4383fdcf94aa@linaro.org>
Date:   Wed, 15 Nov 2023 22:29:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] dt-bindings: i2c: add bus-reset-gpios property
Content-Language: en-US
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>, wsa@kernel.org,
        andi.shyti@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        gregory.clement@bootlin.com
Cc:     linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231115035753.925534-1-chris.packham@alliedtelesis.co.nz>
 <20231115035753.925534-2-chris.packham@alliedtelesis.co.nz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231115035753.925534-2-chris.packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/11/2023 04:57, Chris Packham wrote:
> Add bus-reset-gpios and bus-reset-duration-us properties to the binding
> description for i2c busses. These can be used to describe hardware where
> a common reset GPIO is connected to all downstream devices on and I2C
> bus. This reset will be asserted then released before the downstream
> devices on the bus are probed.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> 

...

> 
>  Documentation/devicetree/bindings/i2c/i2c.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c.txt b/Documentation/devicetree/bindings/i2c/i2c.txt
> index fc3dd7ec0445..3f95d71b9985 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c.txt
> @@ -99,6 +99,14 @@ wants to support one of the below features, it should adapt these bindings.
>  	indicates that the system is accessible via this bus as an endpoint for
>  	MCTP over I2C transport.
>  
> +- bus-reset-gpios:
> +	GPIO pin providing a common reset for all downstream devices. This GPIO
> +	will be asserted then released before the downstream devices are probed.

I initially reviewed it, but did not think enough about it. After more
consideration, I believe this is not a property of the I2C bus
controller. This is a property of each device, even if the GPIO is the same.

Linux kernel already supports shared GPIO, so you only need
enable-ref-counting on it.

Putting it into the controller bindings looks like solving OS issue with
incorrect hardware description.

Best regards,
Krzysztof

