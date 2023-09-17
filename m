Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F697A3428
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 09:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbjIQHwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 03:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233892AbjIQHwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 03:52:40 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261A4191
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 00:52:35 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99bf3f59905so458575066b.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 00:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694937153; x=1695541953; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nWdqqGRpAgOkTLyvsD05R8Bq7nexhnixhUs0t/ev9zM=;
        b=mYVyrYoMDtr1+kRawR6eJW+4S6ugehukaOOk8gP9zVuoIdpdZn+EzTXinQq5Tf72VR
         ieYSbBHZpYrDz2KThSCb7l+E59cJz4qBaO48Y80gTDTkVvmiA3u5WNXdo3JjTPSLahLr
         7iJFhB3LADSQ7m3vUJNn2E+U8Y+Xy+XgH133cFW20cAcQcHqCHlxZt78uow4ZfxcSzAD
         QacLfU7SrMVo6ZVFyLBpDWO1VWLSyXucQzbCY5YqIKyDiH4NxMhppEOiiEDcnaVzzGBG
         QylDlGdvJZVzYdSh1HPwEOfkcIx4ARoD25ccSOX0ML7ZC1pfVHCJmfjda9maodPxvE3X
         75SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694937153; x=1695541953;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWdqqGRpAgOkTLyvsD05R8Bq7nexhnixhUs0t/ev9zM=;
        b=IBeAgawF4kPT8PsIFrYcKEpGdcsrVgyn4rtXiu5DqGSsR/7u3rp/V25NMQWZKTmzyA
         gTDL+JlWNgWR+rKzlM1r5iPTbREZsR88NZYp1Vj2H0ViH0iRjYm6A/OTssa36hsZDG+9
         ZIQd5cs+WeX6fO8puGD+MnE2ywIc0KgFmbcIbS/tMy9rQrjqbVRqa+10Ugkm0UDX6Gz3
         aW1bcYytnlwGmx6gdC+xqw/9AKPMYzHSofnecD/2bCjSJFwIr0F4xTpcoGN+u334mFLW
         Dl5gYvchJnVUloRfug7ZO84fR5DOitG9P5T2EOmomR+mAid3QLGesNiDPk11P3U6UsHD
         XmcQ==
X-Gm-Message-State: AOJu0YzPjp4jr2Q9usP+8ajlk5cz0jo8SivxR5GzIzoM/HApLlBLUCDr
        ae9JY8g5UIjDrYvuSrDoUtJMcg==
X-Google-Smtp-Source: AGHT+IF5RIVwt4hk66LUepLEOgIR+mheKG73oWYXEJom7gBEA9V47ZkZ9eeF3807hhnrMrtacAD7Sw==
X-Received: by 2002:a17:906:1c:b0:9ad:e0cc:902a with SMTP id 28-20020a170906001c00b009ade0cc902amr4173352eja.56.1694937153483;
        Sun, 17 Sep 2023 00:52:33 -0700 (PDT)
Received: from [192.168.1.77] (150-140-187-31.ftth.glasoperator.nl. [31.187.140.150])
        by smtp.gmail.com with ESMTPSA id jl6-20020a17090775c600b009ade1a4f795sm2372439ejc.168.2023.09.17.00.52.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Sep 2023 00:52:32 -0700 (PDT)
Message-ID: <7ec16938-53fa-24dc-8443-ed6428697558@linaro.org>
Date:   Sun, 17 Sep 2023 09:52:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 2/6] dt-bindings: gpio: vf610: correct i.MX8ULP and
 i.MX93
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
References: <20230916-vf610-gpio-v2-0-40823da788d7@nxp.com>
 <20230916-vf610-gpio-v2-2-40823da788d7@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230916-vf610-gpio-v2-2-40823da788d7@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/09/2023 04:03, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX8ULP and i.MX93 actually has two interrupts for each gpio
> controller, one for Trustzone non-secure world, one for secure world.
> 
> And they has one register based, not two as i.MX7ULP or VF610.
> 
> Although the Linux Kernel driver gpio-vf610.c could work with
> fsl,imx7ulp-gpio compatible, it is based on some tricks did in
> device tree with some offset added to base address.
> 
> So actually i.MX8ULP/i.MX93 is not compatible with i.MX7ULP.
> 
> Last, i.MX93 is directly derived from i.MX8ULP, so make i.MX93 GPIO
> compatible with i.MX8ULP
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../devicetree/bindings/gpio/gpio-vf610.yaml       | 41 +++++++++++++++++++---
>  1 file changed, 37 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml b/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml
> index 59427d97adf5..8c1f87a1a393 100644
> --- a/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml
> +++ b/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml
> @@ -20,6 +20,7 @@ description: |
>  properties:
>    compatible:
>      oneOf:
> +      - const: fsl,imx8ulp-gpio
>        - const: fsl,vf610-gpio
>        - items:
>            - const: fsl,imx7ulp-gpio
> @@ -27,16 +28,21 @@ properties:
>        - items:
>            - enum:
>                - fsl,imx93-gpio
> -              - fsl,imx8ulp-gpio
> -          - const: fsl,imx7ulp-gpio
> +          - const: fsl,imx8ulp-gpio
>  
>    reg:
>      description: The first reg tuple represents the PORT module, the second tuple
>        represents the GPIO module.
> -    maxItems: 2
> +    items:
> +      - description: PORT register base address
> +      - description: GPIO register base address
> +    minItems: 1
>  
>    interrupts:
> -    maxItems: 1
> +    items:
> +      - description: GPIO Trustzone non-secure interrupt number
> +      - description: GPIO Trustzone secure interrupt number
> +    minItems: 1
>  
>    interrupt-controller: true
>  
> @@ -78,6 +84,33 @@ required:
>    - "#gpio-cells"
>    - gpio-controller
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - fsl,vf610-gpio
> +              - fsl,imx7ulp-gpio
> +    then:
> +      properties:
> +        interrupts:
> +          items:
> +            - description: GPIO interrupt number

So this is different than first interrupt mentioned in top-level?


> +        reg:
> +          items:
> +            - description: PORT register base address
> +            - description: GPIO register base address

You have the description in top-level, no need to repeat it. Just
minItems: 2... although it depends whether top-level property will stay.


> +    else:
> +      properties:
> +        interrupts:
> +          items:
> +            - description: GPIO Trustzone non-secure interrupt number
> +            - description: GPIO Trustzone secure interrupt number
> +        reg:
> +          items:
> +            - description: GPIO register base address

So the first entry is different between variants? Then top-level should
be just min/maxItems.

> +
>  additionalProperties: false
>  
>  examples:
> 

Best regards,
Krzysztof

