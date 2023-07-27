Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920EC76515C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 12:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233698AbjG0Kh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 06:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbjG0Khy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 06:37:54 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3AF26A4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 03:37:51 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-98dfb3f9af6so106246066b.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 03:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690454270; x=1691059070;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mUepUY1ETJBpPCS0rz2zlbE3uVvxNdDGso2o/AQI4jo=;
        b=Tb6AZRgUS/lthT4HEjc/nP8w/VjoCG8j8LUADVxrSJcPVEqZPnZ/9sIGQ/0A65h9nf
         fFvENy5bDBFLuONVr24tJZsqt5yUbE+HpbcghUl+xy0mZCi150XvN2bM9XJn/odW2AG0
         j3oa/2NJcV+7zbi9D9022hLLvVwTb+k+FP8Y7d1+8rHVNmG6jnePGroAYH5PFViFD4wG
         zU8yvVA/1adhFiURMlP1JOBNkr2C1L1q1aFNyl1uGBmXF0Zkq4w2u3r7WOZoWBDzaU2L
         M8AMJmaxEpk8eBrzmeRKrbSgqWgE2ULn6gtBNW+cZcs/w5Fq/m2HD+Q4RAMLWSPj76OO
         jIPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690454270; x=1691059070;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mUepUY1ETJBpPCS0rz2zlbE3uVvxNdDGso2o/AQI4jo=;
        b=JSu0picCewJuRUq2nkGQYjbqrSyzxXNXDlkr1KEQy1Pa/4h36YZ2KwTpdT1BzFzfz+
         HNWCHYEYr+M4CvaqDwDAdc0bErCB7TqmZBYtfmlbC9Rm2sLvkszl2mwHTw1vqC0MQldM
         m1dpCQsth6S83XIsGCNrFAY/CkNrpdUZ+WTqAXj0KFzJXT8u6USIgJl0UuswX4eioXED
         iOJEqG+lLeaV+pCeJY4Wu3NnSFdZWrI/DTXEIlzTjjJjOrVATGvfEDqERprz0T7unO1G
         MccICGJclO9wNtLoaIL4k2pwLhoyqWzWjfyf9nG1wKp2jbPO9Kx4NBsrXRXBDejRdBhx
         az2A==
X-Gm-Message-State: ABy/qLbLj51pyE7s6QJ+AHRFJ6ckJno/CdGN4g3DXp7/29H2Xl2iYdkD
        62oj5rg7C6vsdZZRr+5MI4FGmw==
X-Google-Smtp-Source: APBJJlH7XY3+rjbYP7kE0i960l4gmZpZUAnVjWzO3suqYO8UT1jOMw/KclUI2AbLbLl2euWq4KrN7w==
X-Received: by 2002:a17:906:310d:b0:969:93f2:259a with SMTP id 13-20020a170906310d00b0096993f2259amr1581738ejx.73.1690454270359;
        Thu, 27 Jul 2023 03:37:50 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id f5-20020a1709064dc500b0098f33157e7dsm617483ejw.82.2023.07.27.03.37.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 03:37:49 -0700 (PDT)
Message-ID: <96a82a51-6e26-cee2-c095-98fac749393f@linaro.org>
Date:   Thu, 27 Jul 2023 12:37:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] dt-bindings:iio:frequency:admv1013: add vcc regs
Content-Language: en-US
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230727102309.92479-1-antoniu.miclaus@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230727102309.92479-1-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/2023 12:23, Antoniu Miclaus wrote:
> Add bindings for the VCC regulators of the ADMV1013 microware
> upconverter.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

Subject: missing spaces between prefix parts.

> ---
>  .../bindings/iio/frequency/adi,admv1013.yaml  | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml
> index fc813bcb6532..6660299ac1ad 100644
> --- a/Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml
> +++ b/Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml
> @@ -39,6 +39,46 @@ properties:
>      description:
>        Analog voltage regulator.
>  
> +  vcc-drv-supply:
> +    description:
> +      RF Driver voltage regulator.
> +
> +  vcc2-drv-supply:
> +    description:
> +      RF predriver voltage regulator.
> +
> +  vcc-vva-supply:
> +    description:
> +      VVA Control Circuit voltage regulator.
> +
> +  vcc-amp1-supply:
> +    description:
> +      RF Amplifier 1 voltage regulator.
> +
> +  vcc-amp2-supply:
> +    description:
> +      RF Amplifier 2 voltage regulator.
> +
> +  vcc-env-supply:
> +    description:
> +      Envelope Detector voltage regulator.
> +
> +  vcc-bg-supply:
> +    description:
> +      Mixer Chip Band Gap Circuit voltage regulator.
> +
> +  vcc-bg2-supply:
> +    description:
> +      VGA Chip Band Gap Circuit voltage regulator.
> +
> +  vcc-mixer-supply:
> +    description:
> +      Mixer voltage regulator.
> +
> +  vcc-quad-supply:
> +    description:
> +      Quadruppler voltage regulator.
> +

You made them required in the driver, so they should be required here as
well. They should be required anyway, because AFAIU they have to be
provided.

OTOH, this will break the ABI, so your driver might need to take them as
optional.

Best regards,
Krzysztof

