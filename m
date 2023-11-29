Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E53D7FD260
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjK2JXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:23:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjK2JXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:23:50 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5036A1A5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 01:23:56 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-a06e59384b6so830815766b.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 01:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701249835; x=1701854635; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/6KtSx6gUmSsayEKdH9E2Y9FJ4Si62b+TTqdgqH2Yx8=;
        b=tV8HgSpVb54LG4ia9S1dJwISYel5y9ey4gWlOxrwekayFu7tb5JdbKeBpDpedIGoRR
         hXuZMdAgsxP3vnQBq2kY/gaLWVVy37ZQuvSyhatVDLJY1flA923Y++hUaFR5U4L9LzsO
         tpxp6WLTZH3dgdYe7R1Q87JdGyiPGc3wPcKlqmhcn/9mVn0pUpCysXDCXM+SLzwl+DLM
         /gJiQ/1enEjnwxvOOCqRs/7CqUTEfWUCHnk57UTo0lS/x1eGR0DGiwScr6mmqojP5mkZ
         dnFxfRrlTV128WHemvTJtPIaM/dLw/5nXNLK1mFf8zpl1Aqhz3nWdcN4h/azHWAK+Nzt
         pcoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701249835; x=1701854635;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/6KtSx6gUmSsayEKdH9E2Y9FJ4Si62b+TTqdgqH2Yx8=;
        b=A5yxNmiHLk8rI8/70V2B6QNGY0Yx7gq6oPyW04au6PlPUslinH7xWWah7JeWqUzimz
         0XYS4+Vhq8aNPFV6lAhkGkr/Uwismo/vLIuk1jvzJ/juaxneTO5clLGBvwF3VRr56pSR
         nHYkW7gR0sLbcG2kyi3PH1mBKVD/9HFN9VhKvjryGK1ABb/mkZejBBgn9l79eS3hkShA
         xyizKdxWgo/TsyjeOJXBp9Rfjs5mB959+fu0W0qlEIrtIafT/ewOGM4HERqZh9u/tftr
         CGKgsvxMTf85nqqvnsAY5RrFtTLQjZ4EMROe3oPHjSQAlsJZYH4VcijhaqtcW6sYMDNB
         Un6Q==
X-Gm-Message-State: AOJu0Yz2DIJwHjLRA19tZTJQqH9VO+vmv1FVmfKppfur68nrrQkHnsbH
        Nv1xNaO9BXgpn/8Ig6U1qJhJnA==
X-Google-Smtp-Source: AGHT+IHx3nCrlgudLTZOjKMOpmeuHGj/BKDwzcHf0fUp4tAnU4S56VB2kbxCIryUERb9BCVyV+z4Sg==
X-Received: by 2002:a17:906:6cd:b0:9e6:59d5:80c5 with SMTP id v13-20020a17090606cd00b009e659d580c5mr13221567ejb.23.1701249834602;
        Wed, 29 Nov 2023 01:23:54 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.109])
        by smtp.gmail.com with ESMTPSA id t11-20020a170906a10b00b009ff8be60791sm7687010ejy.210.2023.11.29.01.23.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 01:23:54 -0800 (PST)
Message-ID: <c50e5224-7acd-4470-b18e-f223f150ba5b@linaro.org>
Date:   Wed, 29 Nov 2023 10:23:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: mfd: Add sony,cronos-cpld
Content-Language: en-US
To:     Shawn Anastasio <sanastasio@raptorengineering.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Georgy Yakovlev <Georgy.Yakovlev@sony.com>
Cc:     Timothy Pearson <tpearson@raptorengineering.com>
References: <cover.1701203916.git.sanastasio@raptorengineering.com>
 <27ac3bf6e5fecd62918eb096a88503a13a1f0b9c.1701203916.git.sanastasio@raptorengineering.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <27ac3bf6e5fecd62918eb096a88503a13a1f0b9c.1701203916.git.sanastasio@raptorengineering.com>
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

On 28/11/2023 22:00, Shawn Anastasio wrote:
> The Sony Cronos Platform Controller CPLD is a multi-purpose platform
> controller that provides both a watchdog timer and an LED controller for
> the Sony Interactive Entertainment Cronos x86 server platform. As both
> functions are provided by the same CPLD, a multi-function device is
> exposed as the parent of both functions.
> 
> Add a DT binding for this device.
> 
> Signed-off-by: Shawn Anastasio <sanastasio@raptorengineering.com>
> ---
> Changes in v2:
>   - Change SIE to Sony to use the already-established prefix.
>   - Clarify that Cronos is an x86 server platform in description
>   - Drop #address-cells/#size-cells
>   - Add missing additionalProperties to leds/watchdog objects
>   - Add sony,led-mask property to leds object
>   - Add sony,default-timeout property to watchdog object
>   - Update example
> 
>  .../bindings/mfd/sony,cronos-cpld.yaml        | 92 +++++++++++++++++++
>  1 file changed, 92 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/sony,cronos-cpld.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/sony,cronos-cpld.yaml b/Documentation/devicetree/bindings/mfd/sony,cronos-cpld.yaml
> new file mode 100644
> index 000000000000..df2c2e83ccb4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/sony,cronos-cpld.yaml
> @@ -0,0 +1,92 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2023 Raptor Engineering, LLC
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/sony,cronos-cpld.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sony Cronos Platform Controller CPLD multi-function device
> +
> +maintainers:
> +  - Timothy Pearson <tpearson@raptorengineering.com>
> +
> +description: |
> +  The Sony Cronos Platform Controller CPLD is a multi-purpose platform
> +  controller that provides both a watchdog timer and an LED controller for the
> +  Sony Interactive Entertainment Cronos x86 server platform. As both functions
> +  are provided by the same CPLD, a multi-function device is exposed as the
> +  parent of both functions.
> +
> +properties:
> +  compatible:
> +    const: sony,cronos-cpld
> +
> +  reg:
> +    maxItems: 1
> +
> +  leds:
> +    type: object
> +    description: Cronos Platform Status LEDs

Missing ref to LEDs common bindings.

> +
> +    properties:
> +      compatible:
> +        const: sony,cronos-leds
> +
> +      sony,led-mask:
> +        $ref: /schemas/types.yaml#/definitions/uint32

Why aren't you using LEDs bindings? A node for one property is otherwise
quite useless. I already commented on this last time.

> +        minimum: 0x0
> +        maximum: 0x7fff
> +        description: |
> +          A bitmask that specifies which LEDs are present and can be controlled
> +          by the Cronos CPLD. Bits 0-5 correspond to platform Status LEDs, bits
> +          6-10 correspond to Link LEDs, and bits 11-14 correspond to the Power
> +          State LEDs. All other bits are unused. The default value is 0x7fff
> +          (all possible LEDs enabled).
> +
> +    additionalProperties: false
> +
> +  watchdog:
> +    type: object
> +    description: Cronos Platform Watchdog Timer


> +
> +    properties:
> +      compatible:
> +        const: sony,cronos-watchdog
> +
> +      sony,default-timeout:

No, you must use existing bindings. Missing ref to watchdog and drop all
duplicated properties like this one.

> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: |
> +          The default timeout with which the watchdog timer is initialized, in
> +          seconds. Supported values are: 10, 20, 30, 40, 50, 60, 70, 80. All
> +          other values will be rounded down to the nearest supported value.  The
> +          default value is 80.
> +



Best regards,
Krzysztof

