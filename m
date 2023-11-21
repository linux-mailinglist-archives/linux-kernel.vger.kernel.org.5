Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5287F290B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 10:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbjKUJfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 04:35:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbjKUJfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 04:35:11 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09A7C1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 01:35:06 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-4083dbc43cfso19965755e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 01:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700559305; x=1701164105; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z8ygufI8trnFCuYYah7mlMCmLjI9OPWqU3S0PdqkpwY=;
        b=TUuqQNn+L58yeXxGhOl/fAk1fOmIoZog+Lb/250fii/b++kPGW4TWqlL378sUUUe7a
         y1ezjyD1BltuxVTI5zfQcnPjWZ8dPl3YSTde9n/+0RQ1Z8pHnWKdnmY5hYUsGy12uMTF
         apYwZ0H0tGLe7zqff7ASoOF4llrWG03QPhcGTIZUNPDWAuVUEi4OHeHxHECweqoCEght
         qtU3k9YiPQGIpsJ7PD3U1z+w7kbCkIKwqWqfym0tO5kbLU+scAodaY9ZODE+D0Z7F/Ax
         9FP27tldNqfXvpjqeLdFJQ6DgQaHBH9MXYvW9T9oe/lwLw6xcMnahTra4tCpiS2yt0oL
         GjNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700559305; x=1701164105;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z8ygufI8trnFCuYYah7mlMCmLjI9OPWqU3S0PdqkpwY=;
        b=ZExJWWugHb1GxN2hvXb0vU6ZVWEn/iGvrs6TrE2yueu8DAkMINdfPKvaJhIeCtXaWI
         ayQ9RBpApl2hGmS1dv4L8MgexnAvIv1NglyAWRzU/E16LYmlZX5Dqm65cIyy7qnGbyVg
         op9snKCrEVUW2IksrG3X7t2qQ54Ci0q1PJvV5lBlgxkQsoHbHEtrLqmGSJeqBsDnPBG9
         k4i/d9RDJhfmX9SNJc7lxbzABvbOicUYdwX66O1MaG8S6vzVpLfJUx3GsD3Q7j1Zfvxt
         ft3iaw5WVbyutp+poUJoxxlYhdYMFT/mNT3F5ZxFGUjLXx0fp1GZ02hl+ziTUhoUZf/x
         kUmw==
X-Gm-Message-State: AOJu0Yz2EoFLvYUz1jMyEAkciG3s8+eBjFGVf8fjgdJfxPuSeQLChIQG
        q8y7Ewpgq3E3pQ9laBrGkEdVGQ==
X-Google-Smtp-Source: AGHT+IGkkjpD4LRddPS6Kmt0PBxAXab+YqOHesqf2qjwpt6ODoEw/H9YBbq5rwMCu+bn33lJ3HfqPQ==
X-Received: by 2002:a05:600c:19d4:b0:40b:2aa9:21dd with SMTP id u20-20020a05600c19d400b0040b2aa921ddmr660590wmq.4.1700559304278;
        Tue, 21 Nov 2023 01:35:04 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.11])
        by smtp.gmail.com with ESMTPSA id f16-20020a05600c155000b003fe1fe56202sm16589517wmg.33.2023.11.21.01.35.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 01:35:03 -0800 (PST)
Message-ID: <dde59498-440d-4faf-b878-2090342b52da@linaro.org>
Date:   Tue, 21 Nov 2023 10:35:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7][4/4] dt-bindings: mmc: Add dt-bindings for realtek mmc
 driver
Content-Language: en-US
To:     Jyan Chou <jyanchou@realtek.com>, ulf.hansson@linaro.org,
        adrian.hunter@intel.com, jh80.chung@samsung.com,
        riteshh@codeaurora.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     conor+dt@kernel.org, asutoshd@codeaurora.org,
        p.zabel@pengutronix.de, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, briannorris@chromium.org, doug@schmorgal.com,
        tonyhuang.sunplus@gmail.com, abel.vesa@linaro.org,
        william.qiu@starfivetech.com
References: <20231121091101.5540-1-jyanchou@realtek.com>
 <20231121091101.5540-5-jyanchou@realtek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231121091101.5540-5-jyanchou@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/2023 10:11, Jyan Chou wrote:
> Document the device-tree bindings for Realtek SoCs mmc driver.

This is a friendly reminder during the review process.

It seems my or other reviewer's previous comments were not fully
addressed. Maybe the feedback got lost between the quotes, maybe you
just forgot to apply it. Please go back to the previous discussion and
either implement all requested changes or keep discussing them.

Thank you.

Additionally:

A nit, subject: drop second/last, redundant "bindings for". The
"dt-bindings" prefix is already stating that these are bindings.

> 
> Signed-off-by: Jyan Chou <jyanchou@realtek.com>
> 
> ---
> v6 -> v7:
> - Drop reset-names and realtek,m2tmx since it is not needed in our driver.
> 
> v5 -> v6:
> - Drop the incorrect, generic compatible and modify it to specific.
> - Drop useless properties.

I asked which ones. I still do not see that information here.


> - Modify bindings to make DTS and driver match.
> 
> v4 -> v5:
> - Remove unused property, e.g.,cqe, resets, clock-freq-min-max.
> - Fix indentation.
> 

...

> +
> +maintainers:
> +  - Jyan Chou <jyanchou@realtek.com>
> +
> +allOf:
> +  - $ref: synopsys-dw-mshc-common.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - realtek,rtd1325-dw-cqe-emmc
> +      - realtek,rtd1319-dw-cqe-emmc
> +      - realtek,rtd1315e-dw-cqe-emmc
> +      - realtek,rtd1619b-dw-cqe-emmc

That's not what is present in your driver. Why other compatibles are not
there? What do you want to express here?

> +
> +  reg:
> +    items:
> +      - description: emmc base address
> +      - description: cqhci base address
> +
> +  reg-names:
> +    items:
> +      - const: emmc
> +      - const: cqhci
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 4
> +
> +  clock-names:
> +    items:
> +      - const: biu
> +      - const: ciu
> +      - const: vp0
> +      - const: vp1
> +
> +  resets:
> +    maxItems: 1
> +
> +  pinctrl-0:
> +    description:
> +      should contain default/high speed pin ctrl.
> +    maxItems: 1
> +
> +  pinctrl-1:
> +    description:
> +      should contain sdr50 pin ctrl.
> +    maxItems: 1
> +
> +  pinctrl-2:
> +    description:
> +      should contain ddr50 mode pin ctrl.
> +    maxItems: 1
> +
> +  pinctrl-3:
> +    description:
> +      should contain hs200 speed pin ctrl.
> +    maxItems: 1
> +
> +  pinctrl-4:
> +    description:
> +      should contain hs400 speed pin ctrl.
> +    maxItems: 1
> +
> +  pinctrl-5:
> +    description:
> +      should contain tune0 pin ctrl.
> +    maxItems: 1
> +
> +  pinctrl-6:
> +    description:
> +      should contain tune1 pin ctrl.
> +    maxItems: 1
> +
> +  pinctrl-7:
> +    description:
> +      should contain tune2 pin ctrl.
> +    maxItems: 1
> +
> +  pinctrl-8:
> +    description:
> +      should contain tune3 pin ctrl.
> +    maxItems: 1
> +
> +  pinctrl-9:
> +    description:
> +      should contain tune4 pin ctrl.
> +    maxItems: 1
> +
> +  pinctrl-names:
> +    maxItems: 10
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - vmmc-supply
> +  - pinctrl-names
> +  - pinctrl-0
> +  - pinctrl-1
> +  - pinctrl-3
> +  - pinctrl-4
> +  - pinctrl-5
> +  - pinctrl-6
> +  - pinctrl-7
> +  - pinctrl-8
> +  - pinctrl-9
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    emmc: mmc@12000 {
> +      compatible = "realtek,rtd1315e-dw-cqe-emmc";
> +      reg = <0x00012000 0x00600>,
> +            <0x00012180 0x00060>;
> +      reg-names = "emmc", "cqhci";
> +      interrupts = <0 42 4>;

Use proper interrupt defines instead of raw values.

> +      clocks = <&cc 22>, <&cc 26>, <&cc 121>, <&cc 122>;
> +      clock-names = "biu", "ciu", "vp0", "vp1";

Where is the DTS implementing this binding?

I said it once:

> I asked you to test the bindings. This also means that you must test
> your DTS against bindings. Your bindings, DTS and driver do not match,
> therefore let's be a bit more clear:
>
> NAK, till you upstream your DTS.

I still do not see DTS anywhere. Please link it.

Best regards,
Krzysztof

