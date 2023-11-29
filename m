Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3205A7FDD53
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 17:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbjK2Qi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 11:38:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbjK2QiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 11:38:16 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4979F172C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 08:37:56 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40b54261524so6636465e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 08:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1701275875; x=1701880675; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=FWyzIycAhixRpcgq6BG+vxReDnTGBpSHfPY7iVZZqyo=;
        b=jqn7BXIEMQoBUSApFhSdFzn9YVDSAoKtxRK+C1QP1PeygirJit9HbSuJTSjl+42K85
         CyNUkhF1SVIpBbd2ftORV7d2e4ijAH8zENh24+9jrUjy83l8kuAyvYoT7q94PETP0JsG
         rcSBc9LdObN+2IHicPWfEGXbVn6vc5cnU7K9bU6xrz1IMdb9gzeO2SzJLZ4iGme6PObt
         miG5xdAHvWn8Qkm7EYgpPCs3Rjt4YSuLzLutEibzzfj1nHvXdRUHm2s+pHlsX9+u4t7P
         p9xdIpaMvsjm2MtzcY9ezT1CycGVpqAEDjpGzYAW5txg4XIqQKXawR/EVCpooPLIqM7/
         68mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701275875; x=1701880675;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FWyzIycAhixRpcgq6BG+vxReDnTGBpSHfPY7iVZZqyo=;
        b=bjF9G07RKE2NvuLQiLOaELttk5Sk5//9OzyNnEgzl8xFx4AKEV8MJUqfEQQXfylqij
         Aos7gEGT0nSYZkGIfgWelUvF4h33PUmyNMe1oHAx0PlMQXeHM2UDL0lWK7HMSac2CbJC
         XfbIZyOIbtmc1CNQROP1k5DcwPwFefRKMxp9LQ1R5Npbj8KEF/liTzqq/YguEpecoGLn
         11QwdHv+FdbGGepg4gBJhlgPRZlpBkiSWspquFaV0cHNcFsHYllT1aJgoG851hBNIJkW
         Fv3QXDvofwApoQCTGaLiY9LnwN8Q/nf1z4mLAeu+JbV66dop+49QTZGVQULjfksb30kH
         8gxQ==
X-Gm-Message-State: AOJu0YwF9nMAG3e9X8WeiAEHn00E0R13b7RYLxUEUc0cq+cpZaOCK61L
        z9+/WH8LadfcJLpMl1oi/GlQyg==
X-Google-Smtp-Source: AGHT+IGPzQLHnNMiY0pGKwSqoSExLd5uE8iP+sPsfVle142Jbb03oHPeUBOVT+9ytx/MlONjkBmq2Q==
X-Received: by 2002:a05:600c:4fc5:b0:402:ea96:c09a with SMTP id o5-20020a05600c4fc500b00402ea96c09amr14591359wmq.16.1701275874667;
        Wed, 29 Nov 2023 08:37:54 -0800 (PST)
Received: from localhost ([2a01:e0a:3c5:5fb1:1885:1b93:1f61:bf1b])
        by smtp.gmail.com with ESMTPSA id u19-20020a05600c139300b0040b540ff0a5sm2430843wmf.19.2023.11.29.08.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 08:37:54 -0800 (PST)
References: <20231129134004.3642121-1-jbrunet@baylibre.com>
 <20231129134004.3642121-3-jbrunet@baylibre.com>
 <8e78be99-3d4d-4f79-9791-404e60bcb67c@linaro.org>
User-agent: mu4e 1.10.8; emacs 29.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     neil.armstrong@linaro.org
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org,
        JunYi Zhao <junyi.zhao@amlogic.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3 2/4] dt-bindings: pwm: amlogic: add new compatible
 for meson8 pwm type
Date:   Wed, 29 Nov 2023 17:26:35 +0100
In-reply-to: <8e78be99-3d4d-4f79-9791-404e60bcb67c@linaro.org>
Message-ID: <1jfs0ojz1a.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed 29 Nov 2023 at 17:20, Neil Armstrong <neil.armstrong@linaro.org> wrote:

> Hi,
>
> On 29/11/2023 14:39, Jerome Brunet wrote:
>> Add a new compatible for the pwm found in the meson8 to sm1 Amlogic SoCs,
>> dealing with clocks differently. This does not enable new HW. It is meant
>> to fix a bad DT ABI for the currently supported HW.
>> The original clock bindings describe which input the PWM channel
>> multiplexer should pick among its possible parents, which are
>> hard-coded in the driver. As such, it is a setting tied to the driver
>> implementation and does not describe the HW.
>> The new bindings introduce here describe the clocks input of the PWM
>> block
>> as they exist.
>> The old compatible is deprecated but kept to maintain ABI compatibility.
>> The SoC specific compatibles introduced match the SoC families supported
>> by the original bindings.
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>>   .../devicetree/bindings/pwm/pwm-amlogic.yaml  | 52 ++++++++++++++++---
>>   1 file changed, 46 insertions(+), 6 deletions(-)
>> diff --git a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
>> b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
>> index 387976ed36d5..eece390114a3 100644
>> --- a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
>> +++ b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
>> @@ -21,23 +21,35 @@ properties:
>>             - amlogic,meson-g12a-ee-pwm
>>             - amlogic,meson-g12a-ao-pwm-ab
>>             - amlogic,meson-g12a-ao-pwm-cd
>> -          - amlogic,meson-s4-pwm
>> +        deprecated: true
>>         - items:
>>             - const: amlogic,meson-gx-pwm
>>             - const: amlogic,meson-gxbb-pwm
>> +        deprecated: true
>>         - items:
>>             - const: amlogic,meson-gx-ao-pwm
>>             - const: amlogic,meson-gxbb-ao-pwm
>> +        deprecated: true
>>         - items:
>>             - const: amlogic,meson8-pwm
>>             - const: amlogic,meson8b-pwm
>> +        deprecated: true
>
> I think deprecated should be moved in a third patch

The complain on v2 was that it was not clear the new binding was making
the old one obsolete. It looked to me that the deprecation old bindings
needed to go together with the introduction of the new.

I don't mind one way or the other

Is there a rule somewhere about this ?

>
>> +      - const: amlogic,meson8-pwm-v2
>> +      - items:
>> +          - enum:
>> +              - amlogic,meson8b-pwm-v2
>> +              - amlogic,meson-gxbb-pwm-v2
>> +              - amlogic,meson-axg-pwm-v2
>> +              - amlogic,meson-g12-pwm-v2
>> +          - const: amlogic,meson8-pwm-v2
>> +      - const: amlogic,meson-s4-pwm
>>       reg:
>>       maxItems: 1
>>       clocks:
>>       minItems: 1
>> -    maxItems: 2
>> +    maxItems: 4
>>       clock-names:
>>       minItems: 1
>> @@ -58,7 +70,6 @@ allOf:
>>           compatible:
>>             contains:
>>               enum:
>> -              - amlogic,meson8-pwm
>>                 - amlogic,meson8b-pwm
>>                 - amlogic,meson-gxbb-pwm
>>                 - amlogic,meson-gxbb-ao-pwm
>> @@ -67,14 +78,15 @@ allOf:
>>                 - amlogic,meson-g12a-ee-pwm
>>                 - amlogic,meson-g12a-ao-pwm-ab
>>                 - amlogic,meson-g12a-ao-pwm-cd
>> -              - amlogic,meson-gx-pwm
>> -              - amlogic,meson-gx-ao-pwm
>
> I don't understand why those entries are removed

It's a mistake. It should not have been added to begin with in
the first patch. "amlogic,meson-gx-*" must go along with
"amlogic,meson-gxbb-*" so it matches correctly without it.

I'll fix it

>
>>       then:
>> -      # Historic bindings tied to the driver implementation
>> +      # Obsolete historic bindings tied to the driver implementation
>>         # The clocks provided here are meant to be matched with the input
>>         # known (hard-coded) in the driver and used to select pwm clock
>>         # source. Currently, the linux driver ignores this.
>> +      # This is kept to maintain ABI backward compatibility.
>
> Same here, this should go in a third patch
>
>>         properties:
>> +        clocks:
>> +          maxItems: 2
>>           clock-names:
>>             oneOf:
>>               - items:
>> @@ -83,6 +95,27 @@ allOf:
>>                   - const: clkin0
>>                   - const: clkin1
>>   +  # Newer binding where clock describe the actual clock inputs of the
>> pwm
>> +  # block. These are necessary but some inputs may be grounded.
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - amlogic,meson8-pwm-v2
>> +    then:
>> +      properties:
>> +        clocks:
>> +          minItems: 1
>> +          items:
>> +            - description: input clock 0 of the pwm block
>> +            - description: input clock 1 of the pwm block
>> +            - description: input clock 2 of the pwm block
>> +            - description: input clock 3 of the pwm block
>> +        clock-names: false
>> +      required:
>> +        - clocks
>> +
>>     # Newer IP block take a single input per channel, instead of 4 inputs
>>     # for both channels
>>     - if:
>> @@ -112,6 +145,13 @@ examples:
>>         clock-names = "clkin0", "clkin1";
>>         #pwm-cells = <3>;
>>       };
>> +  - |
>> +    pwm@2000 {
>> +      compatible = "amlogic,meson8-pwm-v2";
>> +      reg = <0x1000 0x10>;
>> +      clocks = <&xtal>, <0>, <&fdiv4>, <&fdiv5>;
>> +      #pwm-cells = <3>;
>> +    };
>>     - |
>>       pwm@1000 {
>>         compatible = "amlogic,meson-s4-pwm";
>
> Neil


-- 
Jerome
