Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9945D7A36DA
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 19:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237414AbjIQRbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 13:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237633AbjIQRbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 13:31:03 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28B312D
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 10:30:56 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-502b0d23f28so6022322e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 10:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694971855; x=1695576655; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SgdmuKIbpz+gFfxV0UYSueDkWKXzE83GuFLx8gl3zAM=;
        b=yCyK4c/GkTmHbLZSSrgiYdI3XfWTNzcUUIArLPIKz5pXfeZasarrLovnX/hTSE3/+o
         T/fDxro/noU7I+XYsGEiCsvAscMjl1D4quJMjNZQoyM0q5xGx65VhYnWpd+xK6x74WEy
         DvTwxfC2yX4p0ZiAMJWRlobHo6KYKq7QNUopa1EVBGfxylRGN0g7tLNXMez2Rrtiy7PJ
         Nq4fSDs6jkwmJwN95z8F69N2/4GNMU89Kw37ATaAAsbhz8hAMZdrA3W7AYZ6rKEXc/pe
         GeGjda3GkRho/a446hTteK3OFhgJYKCbQRr3JkLx0I3HBt/1vfPGi8ouiss9u872eLSZ
         iI3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694971855; x=1695576655;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SgdmuKIbpz+gFfxV0UYSueDkWKXzE83GuFLx8gl3zAM=;
        b=JLZ6jdT6yw2LiueCfainW84w6lekPQin4x1kk09VDiazihXcbvrE6z83ZuJckG711c
         c30vk28+c9Qzo8JKTX+iaQtnnZXhwPOHjQ1vSc5cPexfLFPdPQcqd71fOzXQkcxGF8ha
         80hEdT+0QHGCJ/aXFpoV4NEG/I7iAKvi7wLAsjyajULmvXSN8qT0PY/kKHtVPg+lu2Lb
         sFMbl9S7gDQhZOISuBjOjR5kJfGafPkj/3swsV1TYJ0MRjTW2u/d2ijsPR4qjwJ3FhUd
         mNukmm2lOeLGDzXOiXmarrUXxyxnoxqDBeTLpNbvgRCDAdWLjt2qmsR8dMvO/JFpg/ie
         XVGQ==
X-Gm-Message-State: AOJu0YyBLHHfzGS4rtBIYfijYauPbeb54ctG/gL7lBcDcf8AY4amGLEO
        wg5unyhW/qd21Q/hyiOXhyB0Ew==
X-Google-Smtp-Source: AGHT+IHiMAYhJA3KFVfQBrnhXJaEI+iFM+WRbZvD/OAAp6SUHtzAea54pd+PHetHdZOGheq5BtZAJw==
X-Received: by 2002:ac2:4831:0:b0:500:9dd4:2969 with SMTP id 17-20020ac24831000000b005009dd42969mr5011212lft.59.1694971854193;
        Sun, 17 Sep 2023 10:30:54 -0700 (PDT)
Received: from [192.168.1.77] (150-140-187-31.ftth.glasoperator.nl. [31.187.140.150])
        by smtp.gmail.com with ESMTPSA id d23-20020a1709064c5700b009920e9a3a73sm5254791ejw.115.2023.09.17.10.30.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Sep 2023 10:30:53 -0700 (PDT)
Message-ID: <384eb2c7-5aff-ef50-2f89-81cf8dd6e724@linaro.org>
Date:   Sun, 17 Sep 2023 19:30:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v5 01/15] dt-bindings: usb: tps6598x: Add tps25750
Content-Language: en-US
To:     Abdel Alkuor <alkuor@gmail.com>, heikki.krogerus@linux.intel.com,
        krzysztof.kozlowski+dt@linaro.org, bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        conor+dt@kernel.org, linux-kernel@vger.kernel.org,
        abdelalkuor@geotab.com
References: <20230917152639.21443-1-alkuor@gmail.com>
 <20230917152639.21443-2-alkuor@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230917152639.21443-2-alkuor@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/09/2023 17:26, Abdel Alkuor wrote:
> From: Abdel Alkuor <abdelalkuor@geotab.com>
> 
> TPS25750 is USB TypeC PD controller which is a subset of TPS6598x.
> 
> Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>
> ---
>  .../devicetree/bindings/usb/ti,tps6598x.yaml  | 70 +++++++++++++++++++
>  1 file changed, 70 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml b/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
> index 5497a60cddbc..e49bd92b5276 100644
> --- a/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
> +++ b/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
> @@ -20,6 +20,8 @@ properties:
>      enum:
>        - ti,tps6598x
>        - apple,cd321x
> +      - ti,tps25750
> +
>    reg:
>      maxItems: 1
>  
> @@ -32,10 +34,45 @@ properties:
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
> +  ti,patch-address:
> +    description: |
> +      One of PBMs command data field is I2C slave address
> +      which is used when writing the patch for TPS25750.
> +      The slave address can be any value except 0x00, 0x20,
> +      0x21, 0x22, and 0x23

Why this cannot be another entry in the reg?

> +    $ref: /schemas/types.yaml#/definitions/uint8
> +    minimum: 1
> +    maximum: 0x7e
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
> +      required:
> +        - ti,patch-address
> +        - connector


Why? Connector should be required or not required for both devices. What
is different between them?


Best regards,
Krzysztof

