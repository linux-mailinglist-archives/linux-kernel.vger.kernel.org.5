Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07A0793A10
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 12:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238116AbjIFKmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 06:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjIFKmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 06:42:49 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91757E73
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 03:42:45 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99c1c66876aso515413866b.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 03:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693996964; x=1694601764; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eO5wMu98pG36tlzNwqD46Jc2RmjnNtEapWMKukOamV8=;
        b=ipf4dUHvbmgiS7z9f8Mlr4iOhLIsagGKUwaWxeQFVv2erbVKEmmmwJ1GyHlvQIhiZN
         xN9nOA2n8hqwbFshiBOe8kOorYSVn5tGZGUJlyIBddNKsR4C89/vGj89/9KqSjh0qdat
         UAffT83yEpGvY44bxygDNgYPBdWygj9FmPCZxUjQAE5rSy0vp9/TcMVogwNOOnehzh+K
         R6XbUGHy1GS99ohVJ/025zuz4M87bs8yIyjapoUOWcLZW8ZOgMmeRxsWPtYty5nSAqa2
         PW/dkq9OcBadv0xnd9BmhjoGvTo/sxm3yoUsSAisXWV7EC7cv1gPzjydI38XHe4d/571
         tztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693996964; x=1694601764;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eO5wMu98pG36tlzNwqD46Jc2RmjnNtEapWMKukOamV8=;
        b=WWChq7Mw0Hd1Tu5iqF9//GFzcCc3vVFKcJXjkxEgQ5RMCmBkOaVKg9jQQzY3oZB6P6
         qwaYhFNclKAhgcufANBU/Vxmk2wasu7n/f4P+I7RY+85MaeGqNBMHLtWAhbgufOQMwhV
         cTPohDkoR12Gr8IQ2TAI3RotplRUO5/mBx1qCNqt4ZDJO+hPv5et8oCflPU1lk3wMKdU
         eIVCzSKrx50pEZb3g++MOxbRwxIkukbYmDtEjhskuPh6WqjYJ8aVvJIP0uhscszI0hvr
         ks68qAyNVpDooz47W8WvG+0k9z8YYlgP6Q8ORrTbIIZ41oKSptQYVyb8FGYru3sSoMhV
         YptA==
X-Gm-Message-State: AOJu0YyJjT5e68nm4ycHO7BaksHcD7VGaBLJ8o0e6CUET7wT/4NZ+A9o
        CFX8ZHMKqK4TapIxcwiE4pjP5g==
X-Google-Smtp-Source: AGHT+IHzRpu9vaazq4OQ0fvnAeUpDMKnozi+4O/OgApO0oxQ1a0GAmIoAgrCOSntQcZNm4cOSnkszw==
X-Received: by 2002:a17:906:217:b0:9a1:f21e:cdff with SMTP id 23-20020a170906021700b009a1f21ecdffmr2136635ejd.23.1693996964049;
        Wed, 06 Sep 2023 03:42:44 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id cf20-20020a170906b2d400b00988dbbd1f7esm8764168ejb.213.2023.09.06.03.42.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 03:42:43 -0700 (PDT)
Message-ID: <bb0548ed-e88c-bd21-caeb-1b767259b0ad@linaro.org>
Date:   Wed, 6 Sep 2023 12:42:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] dt-bindings: rtc: mcp795: convert to YAML
Content-Language: en-US
To:     Javier Carrasco <javier.carrasco.cruz@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Bartczak <emilbart@gmail.com>,
        Josef Gajdusek <atx@atx.name>
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230906-topic-rtc_mcp795_yaml-v1-1-de75c377b5b0@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230906-topic-rtc_mcp795_yaml-v1-1-de75c377b5b0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/2023 12:23, Javier Carrasco wrote:
> Convert the MCP795 bindings from text to YAML format to support bindings
> validation.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
> YAML is the preferred format for dt-bindings, which allows validation.
> ---
>  .../devicetree/bindings/rtc/maxim,mcp795.txt       | 11 -------
>  .../devicetree/bindings/rtc/maxim,mcp795.yaml      | 35 ++++++++++++++++++++++
>  2 files changed, 35 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/maxim,mcp795.txt b/Documentation/devicetree/bindings/rtc/maxim,mcp795.txt
> deleted file mode 100644
> index a59fdd8c236d..000000000000
> --- a/Documentation/devicetree/bindings/rtc/maxim,mcp795.txt
> +++ /dev/null
> @@ -1,11 +0,0 @@
> -* Maxim MCP795		SPI Serial Real-Time Clock
> -
> -Required properties:
> -- compatible: Should contain "maxim,mcp795".
> -- reg: SPI address for chip
> -
> -Example:
> -	mcp795: rtc@0 {
> -		compatible = "maxim,mcp795";
> -		reg = <0>;
> -	};
> diff --git a/Documentation/devicetree/bindings/rtc/maxim,mcp795.yaml b/Documentation/devicetree/bindings/rtc/maxim,mcp795.yaml
> new file mode 100644
> index 000000000000..77e465747d43
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/maxim,mcp795.yaml
> @@ -0,0 +1,35 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/rtc/maxim,mcp795.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim MCP795 SPI Serial Real Time Clock
> +
> +allOf:
> +  - $ref: rtc.yaml#

Nit: By convention, this goes after maintainers/description.

> +
> +maintainers:
> +  - Josef Gajdusek <atx@atx.name>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - maxim,mcp795
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false

This should be unevaluatedProperties:false, so you allow other common
RTC properties. But then, it is even smaller than trivial RTC devices, so:
1. What about interrupts? No interrupt line?
2. If there is interrupt line, just add it to trivial-rtc. Otherwise,
it's fine here with changes above.

Best regards,
Krzysztof

