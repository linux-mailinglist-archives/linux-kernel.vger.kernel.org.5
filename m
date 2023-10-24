Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB50A7D533F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 15:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343726AbjJXNwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 09:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343672AbjJXNum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 09:50:42 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1440C2683
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 06:48:16 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-4083f613275so36978685e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 06:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698155294; x=1698760094; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o0zlICfKS9BIvwSLqYLNk0tKGQuHdKyXzE5RDB/FcwE=;
        b=Z/NrMfOzAVVvFlBN6cYI/+FOvS9iDet2yLTLejMPfXBAIdRL2r0iRgmJsYm+mKYGJX
         dYC90Rejx+nfGrj8/9FFqN9IRwdKNk7WVQsU1Lp7mZ3ocFNzfrZDvDtwdTgKeAjDY/Q6
         3aKpHC6gRZDFzrZGVTZkQVg5EzDNhewSJ2jcdGsJxw9Xh6ArUY6KJagYgb87gQFXD0Lw
         j4kF9Eg1vUTWWgRllmQz0tGt+pb3v2STEivwjb2QP+8yG/8lUDJX12uZMkoNn5rg3LZ3
         /hxm5bZSO37cSZrIO2h0QfieHLGdGuGg2Whk4UgCkPJA0+LSRAliZVh5DgE1Fc57AqN8
         WhgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698155294; x=1698760094;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o0zlICfKS9BIvwSLqYLNk0tKGQuHdKyXzE5RDB/FcwE=;
        b=AXgjmZGhBewTYSwCAsAThG9CYVm5aESQIEj/rHxHVoxn/0Q6E/8gESWwDAiZEjag/e
         6RFqG4mOqjo6xPXYGLR7Rc60/DMYxkAv9CUti+ltZWp42R3WQTUsROsRbQWtUt9oZf0Z
         s57W8+0gSzYC7UW/olSellHjJ0N3Yow/zG7XG8OhUOTtcUth/+RanMhJJtQrj4wlPVf0
         a7Fvto1C3EejobV0Q41HX/HROLKrTG5BLOkCn1i+n7D63YLNh/YqOWWwbWFUpodxD3wB
         XNnNS1jSe/Jk5OLn6YKsuuHR81yXziAWIBab6Z7465thcWEP57Gb2k9M+WUTLUWGgK9n
         /EbA==
X-Gm-Message-State: AOJu0YwGL4avXDVUt3c0PW875uyUj4HwFmfvCN8jxuCwKCPaUISKi5n7
        7qXoCUVieM7mpXpq8e2qwcgeFw==
X-Google-Smtp-Source: AGHT+IEzx4zSgbgdZJRVFVj0jmCQMoEPTeBdMoUIEF6ikOwrETN4Xn1KjrBm0vUz8Hcm7wy+EmXCrw==
X-Received: by 2002:adf:e590:0:b0:32d:8357:42dd with SMTP id l16-20020adfe590000000b0032d835742ddmr8517272wrm.68.1698155294514;
        Tue, 24 Oct 2023 06:48:14 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id y10-20020a5d470a000000b0032d9efeccd8sm9975318wrq.51.2023.10.24.06.48.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 06:48:14 -0700 (PDT)
Message-ID: <fbf4af1f-fc3a-4111-8823-424fb3eea60a@linaro.org>
Date:   Tue, 24 Oct 2023 15:48:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] dt-bindings: adis16475: Add
 'spi-cs-inactive-delay-ns' property
Content-Language: en-US
To:     Ramona Gradinariu <ramona.gradinariu@analog.com>, jic23@kernel.org,
        nuno.sa@analog.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20231023140534.704312-1-ramona.gradinariu@analog.com>
 <20231023140534.704312-3-ramona.gradinariu@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231023140534.704312-3-ramona.gradinariu@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/10/2023 16:05, Ramona Gradinariu wrote:
> The devices supported by adis16475 driver require a stall period
> between SPI transactions (during which the chip select is
> inactive), with a minimum value equal to 16 microseconds, thus
> adding 'spi-cs-inactive-delay-ns' property, which should indicate
> the stall time between consecutive SPI transactions.
> 
> Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> ---
> changes in v2:
>  - added default value
>  - updated description
>  - updated commit message
>  .../devicetree/bindings/iio/imu/adi,adis16475.yaml          | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml b/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
> index c73533c54588..135ccdd5c392 100644
> --- a/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
> +++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
> @@ -47,6 +47,12 @@ properties:
>    spi-max-frequency:
>      maximum: 2000000
> 
> +  spi-cs-inactive-delay-ns:
> +    minimum: 16000
> +    default: 16000
> +    description:
> +      Indicates the stall time between consecutive SPI transactions.

You can skip the description entirely, it is coming from
spi-peripheral-props.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

