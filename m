Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A2E81345E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573794AbjLNPOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:14:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235663AbjLNPOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:14:12 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E5A120
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 07:13:40 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-a1ca24776c3so146845766b.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 07:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702566819; x=1703171619; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gvtun0x8vkG6VtfItcIBsM/hEbrzkxfGGKszvTd1N68=;
        b=fQ7fs9AFf3nSYL9Ybhg0qZwdYIZSega3j8BZkNqTLiSH8UWIRfrIsdg/5UveUkPWA4
         v3SdXg79D/1TE0c6F8Hy8cnsvnJOC3kBkGbbTBuQisSlXEWFuBEjHSLfsFxFZ1Hc3A2/
         fY2VIRNi/OjqCrsHmJ/g7HEbReNP+8Ys0qzDk+mSGCpOpqssc9byqOMl2MVFkS5gl+ng
         cBPLGIhlzzbSSbUoNSWb7zVIvlmmKHgDkSWPrh4pJR1HPJRm8WjBI4nzoNkQB6Ej+lBS
         mLXsbTf3cYmOU3ZEk+v1QeOaXYCn+hxdSMz81pNIXDSvKXXS0oOzfDYvFSCNohVB+7HV
         l+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702566819; x=1703171619;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gvtun0x8vkG6VtfItcIBsM/hEbrzkxfGGKszvTd1N68=;
        b=hQeqUye0KIwySXiLsdvXyvuEiLgVzlJSGCMApaZfVZ2tO0N90Wl0gNprjlHj18jkRm
         KnNGHxKVEZBeewGd9dOM11N6HZE+9wYqEUJIdgni0gUosIpS216zsTPpyXen+gra73rG
         ytfivCK+qtmPtlCwPBBgg2FRqLQU97EsjJ8sK2wosiJMrWnZGLukP0ibJNQVusW5ZAES
         AsdlxtlYL+I08nSCgt+lO3pFAcxX6oQVHwuF6Mp3SNgQT3BnPNqCKWS1royWdjccvxQM
         DMRYDjXdiTOXhAELToZ5B3zKHpfulqSPKR9lqmwfgoPQe3m+iHgNmsPLnlEuadHxN1K6
         1Hmg==
X-Gm-Message-State: AOJu0Yy//g/YXx6clb5qgnOsNTl/Snv2xuAXtGJS7du34KlADljzTUjP
        XCceWcI53wy4q+mQC+siCNJZmg==
X-Google-Smtp-Source: AGHT+IGZlCK/VE6KO7MumtXE2h19ILCBdjwgYnwikNv8XezVz7EdnXEJNlMQPggaj5ERPCE0tHAQ8w==
X-Received: by 2002:a17:906:f142:b0:a1d:5483:d152 with SMTP id gw2-20020a170906f14200b00a1d5483d152mr9625965ejb.68.1702566819361;
        Thu, 14 Dec 2023 07:13:39 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id tp25-20020a170907c49900b00a1f7c502736sm8235915ejc.164.2023.12.14.07.13.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 07:13:38 -0800 (PST)
Message-ID: <fda32450-d83a-4ef9-bc24-1c2f8416ae45@linaro.org>
Date:   Thu, 14 Dec 2023 16:13:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: watchdog: add Marvell AC5 watchdog
Content-Language: en-US
To:     Elad Nachman <enachman@marvell.com>, wim@linux-watchdog.org,
        linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        gregory.clement@bootlin.com, chris.packham@alliedtelesis.co.nz,
        andrew@lunn.ch, fu.wei@linaro.org, Suravee.Suthikulpanit@amd.com,
        al.stone@linaro.org, timur@codeaurora.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     cyuval@marvell.com
References: <20231214150414.1849058-1-enachman@marvell.com>
 <20231214150414.1849058-2-enachman@marvell.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231214150414.1849058-2-enachman@marvell.com>
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

On 14/12/2023 16:04, Elad Nachman wrote:
> From: Elad Nachman <enachman@marvell.com>
> 
> Add definitions and examples for Marvell AC5 variant
> of the sbsa watchdog.
> Marvell variant requires more memory definitions,
> since the initialization is more complex, and involves
> several register sets.

Please wrap commit message according to Linux coding style / submission
process (neither too early nor over the limit):
https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597

> 
> Signed-off-by: Elad Nachman <enachman@marvell.com>
> ---
>  .../bindings/watchdog/arm,sbsa-gwdt.yaml      | 52 ++++++++++++++++++-
>  1 file changed, 50 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/arm,sbsa-gwdt.yaml b/Documentation/devicetree/bindings/watchdog/arm,sbsa-gwdt.yaml
> index aa804f96acba..331e9aa7c2f7 100644
> --- a/Documentation/devicetree/bindings/watchdog/arm,sbsa-gwdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/arm,sbsa-gwdt.yaml
> @@ -20,12 +20,17 @@ allOf:
>  
>  properties:
>    compatible:
> -    const: arm,sbsa-gwdt
> +    enum:
> +      - arm,sbsa-gwdt
> +      - marvell,ac5-wd
>  
>    reg:
>      items:
>        - description: Watchdog control frame
>        - description: Refresh frame
> +      - description: Marvell CPU control frame
> +      - description: Marvell Management frame
> +      - description: Marvell reset control unit frame

You just broke all the users... I doubt this was tested on ARM platforms.

>  
>    interrupts:
>      description: The Watchdog Signal 0 (WS0) SPI (Shared Peripheral Interrupt)
> @@ -39,12 +44,55 @@ required:
>  unevaluatedProperties: false
>  
>  examples:
> +  # First example is for generic ARM one
> +  # Next examples are for Marvell.

One new example could be enough... but if it differs with one property,
also not that much of benefit.

> +  # They are organized as three sets:
> +  # first set is for global watchdog, then CPU core #0 private watchdog,
> +  # and finally CPU core #1 private watchdog
> +  # Examples are given for AC5 or Ironman. For AC5X SOC, the last
> +  # reg item's low address (0x840F8000) should be replaced with 0x944F8000
>    - |
>      watchdog@2a440000 {
>          compatible = "arm,sbsa-gwdt";
>          reg = <0x2a440000 0x1000>,
> -              <0x2a450000 0x1000>;
> +              <0x2a450000 0x1000>,
> +              <0x0 0x0>,
> +              <0x0 0x0>,
> +              <0x0 0x0>;

No, drop.

>          interrupts = <0 27 4>;
>          timeout-sec = <30>;
>      };
> +  - |
> +    watchdog@80216000 {
> +        compatible = "marvell,ac5-wd";
> +        reg = <0x80216000 0x1000>,
> +              <0x80215000 0x1000>,
> +              <0x80210000 0x1000>,
> +              <0x7f900000 0x1000>,
> +              <0x840F8000 0x1000>;
> +        interrupts = <0 124 4>;

Use proper defines.

> +        timeout-sec = <30>;
> +    };
> +  - |
> +    watchdog@80212000 {

Drop example.

> +        compatible = "marvell,ac5-wd";
> +        reg = <0x80212000 0x1000>,
> +              <0x80211000 0x1000>,
> +              <0x80210000 0x1000>,
> +              <0x7f900000 0x1000>,
> +              <0x840F8000 0x1000>;
> +        interrupts = <0 122 4>;
> +        timeout-sec = <30>;
> +    };
> +  - |
> +    watchdog@80214000 {

Drop example.

Best regards,
Krzysztof

