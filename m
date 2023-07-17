Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86B1755AD3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 07:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjGQFQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 01:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjGQFQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 01:16:01 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E27C113;
        Sun, 16 Jul 2023 22:16:00 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-577497ec6c6so36351957b3.2;
        Sun, 16 Jul 2023 22:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689570959; x=1692162959;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=16QoQmAKo2qzesmPGTwO8y2pNV60OgC3a0qEHM2+Xyc=;
        b=GTbM7bJg/Eo6bbnUwazMM2fKux4LrpSuZGiqddjB6R89x7hstmswiGAmgpkk2W7c+h
         m8lUGCk/jjZ5Yz2rVHDtGykSeAIyrKOv2yDG2R+ZqHzUZkZXSkBBOJ9Xjqf2Q201iX2s
         xErXAa8A75ndJGjo05PLvCxZyPodxQDnlrH8Uo3f/EI4vYaIzvDXXfLobZofiySTISxS
         hp7o2SRf0LZVJmCAfa73n1thA2M2vHYaTKhD7kfGxlHq0ZIoqvDAWdg5F5Et07rS0Pz8
         fS/0WbEat7lhh71b92roc3rusOMih8GuMCUqjXQzM1Vj+OBckzl8bKA5wD4+jQGNxzfR
         oZ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689570959; x=1692162959;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=16QoQmAKo2qzesmPGTwO8y2pNV60OgC3a0qEHM2+Xyc=;
        b=eteBhkZVC30Jf5Mylq8yUVXr/zo0tFfN6B/4Kyw3zk20Z1Y+WzN1Wn5/ypWXURaTRe
         H8gVZfllEr8hiS8xvOgcgZSuqT4wiJw9AfDrRQD7E1q0uzhm3rdUb3ZPhS3sXfArnNhi
         aDjWvZG8VHAJMMho8lx6BDImAcR2pXEt3JJuTt8Q3PuNJUTzvMBVFYO7rR0OLa1lks5E
         o9D5+FML4EmgttOibfE7qGo1IySNh9MoM8/bBzEURikpV/g6U35npRRn1UpQ9RODdfqX
         iHyVbFz0CkFdBzzbKYjBcJzCuoUFa6HpYy/IRGutMXpiEsQCPQIxezlt/AW1pFbnJ4Eb
         i4Mw==
X-Gm-Message-State: ABy/qLbZY6aZ3Voa6/keL3ir8gEE+hj4tpIbKT/U1JzA2j5eOhsb5UHq
        doPUct5J3eaj+uglvgyv18Y=
X-Google-Smtp-Source: APBJJlGSRXtscTMOuOTx1Fiaijx4k1r2uvLjA5KJd9+oEBO7DFRwk1Jzu67JCQgbBwIGEuUOmH1e1w==
X-Received: by 2002:a0d:f183:0:b0:562:16d7:e6eb with SMTP id a125-20020a0df183000000b0056216d7e6ebmr11297357ywf.40.1689570959207;
        Sun, 16 Jul 2023 22:15:59 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v123-20020a0dd381000000b00577269ba9e9sm3650724ywd.86.2023.07.16.22.15.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jul 2023 22:15:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <43eea233-5024-bc0a-2872-8c037ec1db67@roeck-us.net>
Date:   Sun, 16 Jul 2023 22:15:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 1/3] dt-bindings: watchdog: ti,rti-wdt: Add support for
 WDIOF_CARDRESET
Content-Language: en-US
To:     huaqian.li@siemens.com, wim@linux-watchdog.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     huaqianlee@gmail.com, nm@ti.com, vigneshr@ti.com,
        kristo@kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, jan.kiszka@siemens.com,
        baocheng.su@siemens.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>
References: <20230717040723.1306374-1-huaqian.li@siemens.com>
 <20230717040723.1306374-2-huaqian.li@siemens.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230717040723.1306374-2-huaqian.li@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/16/23 21:07, huaqian.li@siemens.com wrote:
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
> Signed-off-by: Li Hua Qian <huaqian.li@siemens.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   .../bindings/watchdog/ti,rti-wdt.yaml         | 41 +++++++++++++++++++
>   1 file changed, 41 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/ti,rti-wdt.yaml b/Documentation/devicetree/bindings/watchdog/ti,rti-wdt.yaml
> index fc553211e42d..4b66c4fcdf35 100644
> --- a/Documentation/devicetree/bindings/watchdog/ti,rti-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/ti,rti-wdt.yaml
> @@ -34,6 +34,20 @@ properties:
>     power-domains:
>       maxItems: 1
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
>   required:
>     - compatible
>     - reg
> @@ -59,3 +73,30 @@ examples:
>           assigned-clocks = <&k3_clks 252 1>;
>           assigned-clock-parents = <&k3_clks 252 5>;
>       };
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
> +    watchdog@40610000 {
> +        compatible = "ti,j7-rti-wdt";
> +        reg = <0x40610000 0x100>;
> +        clocks = <&k3_clks 135 1>;
> +        power-domains = <&k3_pds 135 TI_SCI_PD_EXCLUSIVE>;
> +        assigned-clocks = <&k3_clks 135 0>;
> +        assigned-clock-parents = <&k3_clks 135 4>;
> +        memory-region = <&wdt_reset_memory_region>;
> +    };

