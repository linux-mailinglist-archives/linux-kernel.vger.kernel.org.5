Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E925175972D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 15:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjGSNjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 09:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjGSNjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 09:39:18 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F886125;
        Wed, 19 Jul 2023 06:39:17 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-ca3cc52ee62so6870968276.0;
        Wed, 19 Jul 2023 06:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689773956; x=1692365956;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=jZ5K61F6a7AKTldC1p6SBNbi49OgtsHCzv2LF9V4rb8=;
        b=agQfAwysSTY1MY8BWJ0h/AtkQhAu3cCddqkw6tjOojM+RzHhP2iWoF4zO7FsWlR93I
         nUGdwi/N8gANt0QTXAtjIrsG9woVG8bHd6CAaW9zRef0pJ/REb5eWoKhJBvWJEdWqBhH
         /M9SNrH0zZ0gejYvor0SMEcnaEYfSkXYJQkWxHzqhLUCccYl+Gx5Ozyd6kPAVm+MYGcy
         /3K9TCNXrWgXC8VzGjR9VEzBFHKJPLZrCxDb9/eVag5h+KvT6PQQsGTZ7sZtFHZphYRS
         HuaA1tapsfD4QFej0iv+pehDAhn3glD+YdbHHCFDFO0ayjwU7vkgOOJGphDT5TrGFGCz
         1HqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689773956; x=1692365956;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jZ5K61F6a7AKTldC1p6SBNbi49OgtsHCzv2LF9V4rb8=;
        b=RXuPbqVTlWMX29pH0e3PQtHYNS4xuTkR1sGU7mma3QPAdSrvH3Mni7UyiFgXTf5ij/
         Y9PsuXua3pVtMD8oVkIlfLws+g2GTa2U8c8oR0nmk3RWF0CrxqmQXBCGNeBCvq2u58L1
         Upu2vGRyzXtAlTg/VOWqEYAU2GlIZktCnDkyv+3il0QPSmCNoA7jURAQGKrOtULFmbv3
         ZtZKMTiNUJI8mW/qZcczp6D+FC+MqhyrRSAnKGCwk8jYyXSXW+2M1Hhx/3sFCf83i/an
         +hkK5CGeztn8Wr9hk2j/1HyjLAhiXBsu3C7Q+DngEljSh0qVeipK0PUCFWMLTejtVS3N
         6fqA==
X-Gm-Message-State: ABy/qLbohM82NdbQ1gZwu+5NTNk9059Q8pmE7whdOr3ME26p95t5lIZg
        v55WxVVTmZOkh4xqp3SkznLvA51HLVE=
X-Google-Smtp-Source: APBJJlEx4fF+xaYr4ybS9oQhKi3+26k9uPx9jx7imge+wmioLNROAJtPmdIhDGTmRtgkWudwlutdbQ==
X-Received: by 2002:a5b:60e:0:b0:cad:8d36:2a34 with SMTP id d14-20020a5b060e000000b00cad8d362a34mr2461824ybq.49.1689773956507;
        Wed, 19 Jul 2023 06:39:16 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 133-20020a250b8b000000b00cecd504e708sm632701ybl.35.2023.07.19.06.39.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 06:39:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e9a7c5e0-2ac8-3a73-e473-5c68bdbb16bd@roeck-us.net>
Date:   Wed, 19 Jul 2023 06:39:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 1/3] dt-bindings: watchdog: ti,rti-wdt: Add support for
 WDIOF_CARDRESET
Content-Language: en-US
To:     huaqian.li@siemens.com, wim@linux-watchdog.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     huaqianlee@gmail.com, nm@ti.com, vigneshr@ti.com,
        kristo@kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, jan.kiszka@siemens.com,
        baocheng.su@siemens.com
References: <20230718021007.1338761-1-huaqian.li@siemens.com>
 <20230718021007.1338761-2-huaqian.li@siemens.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230718021007.1338761-2-huaqian.li@siemens.com>
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

On 7/17/23 19:10, huaqian.li@siemens.com wrote:
> From: Li Hua Qian <huaqian.li@siemens.com>
> 
> TI RTI (Real Time Interrupt) Watchdog doesn't support to record the
> watchdog cause. Add a reserved memory to know the last reboot was caused
> by the watchdog card. In the reserved memory, some specific info will be
> saved to indicate whether the watchdog reset was triggered in last
> boot.
> 
> Signed-off-by: Li Hua Qian <huaqian.li@siemens.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   .../bindings/watchdog/ti,rti-wdt.yaml         | 28 ++++++++++++++++++-
>   1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/ti,rti-wdt.yaml b/Documentation/devicetree/bindings/watchdog/ti,rti-wdt.yaml
> index fc553211e42d..9d847e4b7278 100644
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
> +      refer to example.
> +
>   required:
>     - compatible
>     - reg
> @@ -47,7 +61,18 @@ examples:
>       /*
>        * RTI WDT in main domain on J721e SoC. Assigned clocks are used to
>        * select the source clock for the watchdog, forcing it to tick with
> -     * a 32kHz clock in this case.
> +     * a 32kHz clock in this case. Add a reserved memory(optional) to keep
> +     * the watchdog reset cause persistent, which was be written in 12 bytes
> +     * starting from 0xa2200000 by RTI Watchdog Firmware, then make it
> +     * possible to get watchdog reset cause in driver.
> +     *
> +     * Reserved memory should be defined as follows:
> +     * reserved-memory {
> +     *     wdt_reset_memory_region: wdt-memory@a2200000 {
> +     *         reg = <0x00 0xa2200000 0x00 0x1000>;
> +     *         no-map;
> +     *     };
> +     * }
>        */
>       #include <dt-bindings/soc/ti,sci_pm_domain.h>
>   
> @@ -58,4 +83,5 @@ examples:
>           power-domains = <&k3_pds 252 TI_SCI_PD_EXCLUSIVE>;
>           assigned-clocks = <&k3_clks 252 1>;
>           assigned-clock-parents = <&k3_clks 252 5>;
> +        memory-region = <&wdt_reset_memory_region>;
>       };

