Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEFB75DB59
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 11:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjGVJ1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 05:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGVJ13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 05:27:29 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8206E2D7F
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 02:27:25 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-993d1f899d7so441162666b.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 02:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690018044; x=1690622844;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ai82Wrekmosu/e1xBDYmI0QwCtbmqg3REKABzbU6LFM=;
        b=D/DtNfu6XOgJzcTudHDJQ107+DyewK2ItCpjW8zJc1RBWWUsuYBNq6fE+phHALO4Ln
         n8LrZbYkJpAZvPJbyVBV+2VT064Z98On28LzBsur8T7jLFZuvxHpeGvF1u6tbqXB93Pn
         tAh/rMOnBIqBYlekVA/NAD9ZQMX0y96ASBnuvnjHYMRRWYq748OXQMOV2rhsfR7+OSSp
         AT5MKlFba2CbwairDMHIiHJpSvmUiX+uVCfgmd7kTNyD0fpQlYrT7R1I/koqG417nyBq
         yeZ/zx4rV/DPDmDoEQ7lEiXvcJ4HH09V1yGokHWJ1ElXzHv0peHNnASayZh5v/fi5c/w
         bVEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690018044; x=1690622844;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ai82Wrekmosu/e1xBDYmI0QwCtbmqg3REKABzbU6LFM=;
        b=FXLnJcoDeDJqJg64u/dWKbOKSm1KlKIt5Os8onZTzvkdCWFUXJkRGWJ+Xmo3SRFPdH
         5k2Hds1KGv60PCUOJu+MyYaySjRtBTsLhQ6YBiY9HNOP/r547FIoUUeXxKWXr+ecJkFU
         VUAGems8ZBem7vIRkYZSiLsntclWhUV3hRalS38feelOzQ1ZvyuEhbXv2waogdG04Hxw
         l39KggWe3HmpQXP9xVsQTin9yR86tYbCqZ3PFbuiZg2X1I0+If94LQaLr9O/AqQJtIDI
         xykbzfBlTDZraBtfq08hSgLnBvGh7Enqw36DVcFVoOmI+K0Wqq/18gNmi7z/KqyZS37L
         oAHA==
X-Gm-Message-State: ABy/qLZJXLPrGfIMdiUT4QC67mUEEN40ORBpzPotpZ2emyeP9jgfQv7h
        tNlKvSbLV8bo+yYvG3EYaD1NVf3Lz+RsCxVWvAM=
X-Google-Smtp-Source: APBJJlHUtRQDwd8sM4l2X8YK6IQU8Kbe2XFpBsg4mJWZC52R65UXpZn/EJxY/cKdFj5v8qtfFw8gkw==
X-Received: by 2002:a17:907:2bfa:b0:99b:56d4:82dc with SMTP id gv58-20020a1709072bfa00b0099b56d482dcmr4005509ejc.67.1690018044023;
        Sat, 22 Jul 2023 02:27:24 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id mh3-20020a170906eb8300b00982b204678fsm3269058ejb.207.2023.07.22.02.27.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Jul 2023 02:27:23 -0700 (PDT)
Message-ID: <5266764a-4551-4117-8aa4-bd435f63f450@linaro.org>
Date:   Sat, 22 Jul 2023 11:27:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 09/10] dt-bindings: marvell: Document PXA1908 SoC
Content-Language: en-US
To:     =?UTF-8?Q?Duje_Mihanovi=c4=87?= <duje.mihanovic@skole.hr>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        afaerber@suse.com
References: <20230721210042.21535-1-duje.mihanovic@skole.hr>
 <20230721210042.21535-10-duje.mihanovic@skole.hr>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230721210042.21535-10-duje.mihanovic@skole.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/07/2023 22:37, Duje Mihanović wrote:
> Add dt bindings and documentation for Marvell PXA1908 SoC.
> 
> Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
> ---
>  .../bindings/arm/marvell/marvell,pxa1908.yaml | 33 +++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/marvell/marvell,pxa1908.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/marvell/marvell,pxa1908.yaml b/Documentation/devicetree/bindings/arm/marvell/marvell,pxa1908.yaml
> new file mode 100644
> index 000000000000..085d238129ad
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/marvell/marvell,pxa1908.yaml

I suggest having one bindings file for all pxa platforms, not per one SoC.

> @@ -0,0 +1,33 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/marvell/pxa1908.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Marvell PXA1908 Platforms
> +
> +maintainers:
> +  - Duje Mihanović <duje.mihanovic@skole.hr>
> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - samsung,coreprimevelte
> +          - const: marvell,pxa1908
> +
> +  pxa,rev-id:

Incorrect vendor prefix

> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    oneOf:

That's not oneOf, so just items:

> +      - items:
> +          - description: Board ID
> +          - description: Board revision
> +    description: |

Best regards,
Krzysztof

