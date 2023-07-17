Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1935755B3F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 08:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbjGQGNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 02:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbjGQGNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 02:13:36 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5391A4
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 23:13:34 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-992b27e1c55so542588866b.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 23:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689574413; x=1692166413;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KX0bayVx0aeOD1sEoQkoLYBCqaL+9BObNzNA02HtFVo=;
        b=T+XSj60tDa3Nd+x7EwbocVcliq3Lu2S15NHeUomZ+yOmpYLshhLT35Esp8SnFNFZWs
         sN4qkGWiPFNHwwh7fBmhN/acOwzB4IOCfR2FpaoJqBRHUMWaUMbLgQu4X1zNjqjkNDSm
         1WBWZSoG7pJy20ea1i4KbPDg7SphFiYAUc3kpgc4TVo4wJh45bn6RVEzlat8GKR42FZi
         /MX1ydKxzCUlbsaVvuqf7b6DjoBa1Pjf0ASGOewaP2o6Cq/TgqHNwHQKeuH9QgAw8J5S
         jOSstcIxJ7Ab8Z1WFKMhhkxoDdbRJCZ3htPoLb54qvZgkKicya40j8jhhAc36sBCnnpX
         C6mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689574413; x=1692166413;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KX0bayVx0aeOD1sEoQkoLYBCqaL+9BObNzNA02HtFVo=;
        b=bQ1CbmipSzAoFlrzseq1vsWSNENdCIv+xHjeX+FXJAp70OnhuF8FZojrZSeCRx4oyE
         hIBM8Y3sIDARADRoIqrJRO+3JMtqeqbFLBjhgQ0eXjvLh2+WljgUZCpp7dB4gNLHlYxv
         UhFwmPNQbKahQ4W6SOJyLFW2O3VeNpiXbuQagWmFhMlhEZRxuWzF6CQZ3y3Q9HJ053ct
         hoXGhomoiXz99092ngWanI4q8gy18eb7QkWsjdCvlKj6M8VwMnVI3lpf+f7Eo1V+FeWn
         pcCuWbRJEic9CX99wN6vGOGxIvYZaQL5wjd8hfgUCK3KpTCMfsQDywUpDlupUSgMb5tK
         lMYA==
X-Gm-Message-State: ABy/qLatODOMJ6a+Xw25M4PvtBf2oq5/Na9ZFFX71p5ZGwftaD6nDhIX
        XKfcRFH/nPt127DVOp1O1uo9zw==
X-Google-Smtp-Source: APBJJlG2+ItcbLEp/WFP4gmznNva/Yv4GGL2r7IBi57RTQLW7OnHdrD0NsDzgE1TxvbQjalRJ1Ppnw==
X-Received: by 2002:a17:907:9541:b0:978:b94e:83dd with SMTP id ex1-20020a170907954100b00978b94e83ddmr8557820ejc.75.1689574413250;
        Sun, 16 Jul 2023 23:13:33 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id n11-20020a1709061d0b00b00982cfe1fe5dsm8744799ejh.65.2023.07.16.23.13.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jul 2023 23:13:32 -0700 (PDT)
Message-ID: <57015d8a-a65a-dd2f-3260-3f78b32db884@linaro.org>
Date:   Mon, 17 Jul 2023 08:13:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 1/3] dt-bindings: watchdog: ti,rti-wdt: Add support for
 WDIOF_CARDRESET
Content-Language: en-US
To:     huaqian.li@siemens.com, wim@linux-watchdog.org, linux@roeck-us.net,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     huaqianlee@gmail.com, nm@ti.com, vigneshr@ti.com,
        kristo@kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, jan.kiszka@siemens.com,
        baocheng.su@siemens.com, Conor Dooley <conor@kernel.org>,
        Rob Herring <robh@kernel.org>
References: <20230717040723.1306374-1-huaqian.li@siemens.com>
 <20230717040723.1306374-2-huaqian.li@siemens.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230717040723.1306374-2-huaqian.li@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/07/2023 06:07, huaqian.li@siemens.com wrote:
> From: Li Hua Qian <huaqian.li@siemens.com>
> 
> TI RTI (Real Time Interrupt) Watchdog doesn't support to record the
> watchdog cause. Add a reserved memory to know the last reboot was caused
> by the watchdog card. In the reserved memory, some specific info will be
> saved to indicate whether the watchdog reset was triggered in last
> boot.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Conor Dooley <conor@kernel.org>
> Reviewed-by: Rob Herring <robh@kernel.org>

What? Where did these happened? Please provide links.

> Signed-off-by: Li Hua Qian <huaqian.li@siemens.com>
> ---
>  .../bindings/watchdog/ti,rti-wdt.yaml         | 41 +++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/ti,rti-wdt.yaml b/Documentation/devicetree/bindings/watchdog/ti,rti-wdt.yaml
> index fc553211e42d..4b66c4fcdf35 100644
> --- a/Documentation/devicetree/bindings/watchdog/ti,rti-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/ti,rti-wdt.yaml
> @@ -34,6 +34,20 @@ properties:
>    power-domains:
>      maxItems: 1
>  
> +  memory-region:
> +    maxItems: 1
> +    description:
> +      Contains the watchdog reserved memory. It is optional.
> +      In the reserved memory, the specified values, which are
> +      PON_REASON_SOF_NUM(0xBBBBCCCC), PON_REASON_MAGIC_NUM(0xDDDDDDDD),
> +      and PON_REASON_EOF_NUM(0xCCCCBBBB), are pre-stored at the first
> +      3 * 4 bytes to tell that last boot was caused by watchdog reset.
> +      Once the PON reason is captured by driver(rti_wdt.c), the driver
> +      is supposed to wipe the whole memory region. Surely, if this
> +      property is set, at least 12 bytes reserved memory starting from
> +      specific memory address(0xa220000) should be set. More please
> +      refer to Example 2.
> +
>  required:
>    - compatible
>    - reg
> @@ -59,3 +73,30 @@ examples:
>          assigned-clocks = <&k3_clks 252 1>;
>          assigned-clock-parents = <&k3_clks 252 5>;
>      };
> +
> +  - |
> +    // Example 2 (Add reserved memory for watchdog reset cause):
> +    /*
> +     * RTI WDT in main domain on J721e SoC. Assigned clocks are used to
> +     * select the source clock for the watchdog, forcing it to tick with
> +     * a 32kHz clock in this case. Add a reserved memory to keep the
> +     * watchdog reset cause persistent, which was be written in 12 bytes
> +     * starting from 0xa2200000 by RTI Watchdog Firmware.
> +     *
> +     * Reserved memory should be defined as follows:
> +     * reserved-memory {
> +     *     wdt_reset_memory_region: wdt-memory@a2200000 {
> +     *         reg = <0x00 0xa2200000 0x00 0x1000>;
> +     *         no-map;
> +     *     };
> +     * }
> +     */

Integrate it with existing binding... there is really no need for new
example for one new property.

Best regards,
Krzysztof

