Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22BEE7B122C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 07:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjI1Fhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 01:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjI1Fhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 01:37:31 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DCF122
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 22:37:29 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-532784c8770so15484689a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 22:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695879448; x=1696484248; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wmcotlRCrBk80r7OsmMGFTSrnZaiLKFO2fVbfsVUPoI=;
        b=aIeLOgQWH5bPq4m0orCEDq4XaPX3LHcKslIC7zKju9DyqlVto2HkETXJFm7wuMuxC3
         QyvTOFPQiNwbnQOUmJOeSiHuBWq//F7ZvYF/nOB2ISbskpjeSz6wuK8rEleOJb9L63k6
         QSLV41mAAm+j87r5Y8AaTqmd+HxjS1K8/kI7gqQfZhSNSOcj2b/uvPNbczdYbl8PCSDK
         Ez4TobYPvt+a2c2xPCq/wwWWa27O5U7VCobxmyVSOoCZAX6Z4fitMzJkyP5Cha7Yp/7g
         MQymMJFD3MOI0uKI7yAxfp/NEaZ92wR2Dav73cfW3wqW7dct7fDNt2o/lJDuiq9cmwr3
         on7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695879448; x=1696484248;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wmcotlRCrBk80r7OsmMGFTSrnZaiLKFO2fVbfsVUPoI=;
        b=u9v9HQeFEV6E3V4Nc7osDK22GN6BPn8HWIfdeTkeyV/EUZngaGLPKJddB66VFUFXBc
         quPpgbwRnjGLDJShnrkzZPClEpkasMPTIwRke9Ur3tyqKec2TWHGNtv/AfVTiAKAM9Tb
         DCKy8SzbG29TpCSkht0Tl6TBHrEsTJ/YnesnxXi4u0HMFXyksDJjpD2Pxr0H7m7ZyiGE
         jrFukBeU1gF5lq9ICIzQi+e/xsl2HMyBWYXWYRi8LVMYs04SXJguPt9Ca9dAefHopG7A
         lbuawKTQThD8We54RJBaZZBt5rZAVZ+d+mmJtJZ/+wyRYecJL2sfIGdgRNy/08W2xNN9
         YBkA==
X-Gm-Message-State: AOJu0YzYTXRcjwZBgfHY2W6U3fbCulxTTnItKYE0hqmzGaHWcoh2o3Fx
        u9GHV6CchezCnH8KseYRoj60Ww==
X-Google-Smtp-Source: AGHT+IHEfbd0byXhvmYaG9HXJ29xqTB3PRreLwdGTKLxr4tFg+7C9sQbPDMO/xEr9w48gPlh8Sx5OA==
X-Received: by 2002:a17:907:77c9:b0:9ae:1872:d01a with SMTP id kz9-20020a17090777c900b009ae1872d01amr230583ejc.76.1695879447172;
        Wed, 27 Sep 2023 22:37:27 -0700 (PDT)
Received: from [192.168.168.70] (host-87-4-82-94.retail.telecomitalia.it. [87.4.82.94])
        by smtp.gmail.com with ESMTPSA id s4-20020a170906168400b009ad829ed144sm10250766ejd.130.2023.09.27.22.37.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 22:37:26 -0700 (PDT)
Message-ID: <77d9306e-ac55-48ab-8751-db43fd03523d@linaro.org>
Date:   Thu, 28 Sep 2023 07:37:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 01/14] dt-bindings: usb: tps6598x: Add tps25750
Content-Language: en-US
To:     Abdel Alkuor <alkuor@gmail.com>, heikki.krogerus@linux.intel.com,
        krzysztof.kozlowski+dt@linaro.org, bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryan.eleceng@gmail.com,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Abdel Alkuor <abdelalkuor@geotab.com>
References: <20230927175348.18041-1-alkuor@gmail.com>
 <20230927175348.18041-2-alkuor@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20230927175348.18041-2-alkuor@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/09/2023 19:53, Abdel Alkuor wrote:
> From: Abdel Alkuor <abdelalkuor@geotab.com>
> 
> TPS25750 is USB TypeC PD controller which is a subset of TPS6598x.
> 
> Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>
> ---
> Changes in v7:
>   - Define reg at top-level
>   - Remove description from reg-names
> Changes in v6:
>   - Use reg property for patch address
> Changes in v5:
>   - Add tps25750 bindings
> 
>  .../devicetree/bindings/usb/ti,tps6598x.yaml  | 81 ++++++++++++++++++-
>  1 file changed, 80 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml b/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
> index 5497a60cddbc..9303d00b89de 100644
> --- a/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
> +++ b/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
> @@ -20,8 +20,18 @@ properties:
>      enum:
>        - ti,tps6598x
>        - apple,cd321x
> +      - ti,tps25750
> +
>    reg:
> -    maxItems: 1
> +    minItems: 1
> +    items:
> +      - description: main PD controller address
> +      - description: |
> +          I2C slave address field in PBMs input data
> +          which is used as the device address when writing the
> +          patch for TPS25750.
> +          The patch address can be any value except 0x00, 0x20,
> +          0x21, 0x22, and 0x23
>  
>    wakeup-source: true
>  
> @@ -32,10 +42,47 @@ properties:
>      items:
>        - const: irq
>  
> +  firmware-name:
> +    description: |
> +      Should contain the name of the default patch binary
> +      file located on the firmware search path which is
> +      used to switch the controller into APP mode.
> +      This is used when tps25750 doesn't have an EEPROM
> +      connected to it.
> +    maxItems: 1
> +
>  required:
>    - compatible
>    - reg
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: ti,tps25750
> +    then:
> +      properties:
> +        reg:
> +          maxItems: 2
> +
> +        reg-names:
> +          items:
> +            - const: main
> +            - const: patch-address

This should be at top level. I wrote it last time - do not define
properties in if:then:, but in top-level.

Best regards,
Krzysztof

