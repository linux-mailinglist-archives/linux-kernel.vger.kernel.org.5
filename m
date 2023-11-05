Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DADD67E15D6
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 19:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjKESaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 13:30:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjKESaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 13:30:15 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C7DE1
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 10:30:12 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9c603e2354fso745586466b.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Nov 2023 10:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699209011; x=1699813811; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1JgzTXBbhRyisUO6sPY7HiShCzr7lEBz4B4CkSwt2k0=;
        b=Bq1183+eJP6JJKDUq0XJmnzL1PtRLN1MyuKMBHe1t2QIONm4xCZedEYg6BMQ7Oask6
         jqczEO9eR5NkGBxImM3PEUow1s76T4lm9IiWqkDuSmKiswYxREpRIIjEEjVtSxgDeknA
         kCETBQWPek2ZPcaNjhn0r58Ft32JpCWgDA5fOAUX86WAogoqxJZMvfbIlIXFDBHgTQPH
         g5gd6m6xEp+EkF93+NvdV3+1O2kOWyEE6HtKYZRPJh9fx9u81FqWvju39VpDaDfWwXM8
         dS1sZIOfvhwUWcOYXtyzLXAQHmy0ne8vmL10f8XCzttxuOZwhUXU9NKKa6vKEfgNDzP9
         HHew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699209011; x=1699813811;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1JgzTXBbhRyisUO6sPY7HiShCzr7lEBz4B4CkSwt2k0=;
        b=sDLba3UjGZL+fPsWAU+lDW85U3YzOh2yEaSuJU0W1+YR1J+j3MPQSuGN+1XURJzeRk
         JNn08MmhxE1GCvOLCDQuyx2qwidC1XEDZuNf3uGBxdm4T/a5DikRpQ3kSQDqo2jD8jbr
         xvGcdbxkl9TTzyvnaZtT8RR8apBNJi7VFMoV/EpSxNro6+s0Hvf8uuymfVrLsplAd/ue
         r17tgMekOcqZn7nocnzsvTmyAKprGqO5gOeb3HtutSknrIHwbxt90QJiwEUpmcVWBiiX
         39DhV5IZXrWs4osXmW3mCOFC/Qnzi8h+BRutSAcCXJsPmOESQFj+46Xk3StNvSHJmZRg
         CAwQ==
X-Gm-Message-State: AOJu0YweITrvdclZ2iXM0hDW0SNLCU+umMlMqcJILPToh4+GGuLnGrki
        SfB/jfULkhlTKz4aT6FogtzEJA==
X-Google-Smtp-Source: AGHT+IH4Mi6VdRFQSZCrtAado1C9bPxDJGo6dDICGD5mb7WYKphowKb3Z3RDANWw6ekwGhlIqknMqA==
X-Received: by 2002:a17:906:b84a:b0:9ad:cbc0:9f47 with SMTP id ga10-20020a170906b84a00b009adcbc09f47mr6362645ejb.12.1699209010855;
        Sun, 05 Nov 2023 10:30:10 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id fx2-20020a170906b74200b0099bd7b26639sm3291367ejb.6.2023.11.05.10.30.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Nov 2023 10:30:10 -0800 (PST)
Message-ID: <894de0ea-d532-4bf3-88ae-91c766e703c5@linaro.org>
Date:   Sun, 5 Nov 2023 19:30:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: watchdog: nxp,pnx4008-wdt: convert txt to
 yaml
Content-Language: en-US
To:     Nik Bune <n2h9z4@gmail.com>, wim@linux-watchdog.org,
        linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        skhan@linuxfoundation.org, stigge@antcom.de
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231104182813.80055-1-n2h9z4@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231104182813.80055-1-n2h9z4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/11/2023 19:28, Nik Bune wrote:
> Convert txt file to yaml. Add maintainers from git blame. 
> 
> Signed-off-by: Nik Bune <n2h9z4@gmail.com>

Thank you for your patch. There is something to discuss/improve - few nits.


> ---
>  .../bindings/watchdog/nxp,pnx4008-wdt.yaml    | 34 +++++++++++++++++++
>  .../bindings/watchdog/pnx4008-wdt.txt         | 17 ----------
>  2 files changed, 34 insertions(+), 17 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/nxp,pnx4008-wdt.yaml
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/pnx4008-wdt.txt
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/nxp,pnx4008-wdt.yaml b/Documentation/devicetree/bindings/watchdog/nxp,pnx4008-wdt.yaml
> new file mode 100644
> index 000000000000..86b691a339b5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/nxp,pnx4008-wdt.yaml
> @@ -0,0 +1,34 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/watchdog/nxp,pnx4008-wdt.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP PNX watchdog timer
> +
> +allOf:
> +  - $ref: watchdog.yaml#

Put allOf: after maintainers: block. I know that many files do not
follow this convention...

> +
> +maintainers:
> +  - Roland Stigge <stigge@antcom.de>
> +
> +properties:
> +  compatible:
> +    const: nxp,pnx4008-wdt
> +
> +  reg:
> +    maxItems: 1
> +
> +unevaluatedProperties: false

And this goes after required: block.

> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    watchdog@4003c000 {
> +        compatible = "nxp,pnx4008-wdt";
> +        reg = <0x4003C000 0x1000>;

Lower-case hex please.

> +        timeout-sec = <10>;
> +    };


Best regards,
Krzysztof

