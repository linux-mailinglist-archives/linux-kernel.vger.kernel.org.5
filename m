Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E817B7823B6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 08:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbjHUG3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 02:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjHUG3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 02:29:15 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E303FA2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 23:29:13 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99bc9e3cbf1so616401166b.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 23:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692599352; x=1693204152;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+jqHn5WqQaJCtg0AUJN1FB+zw67/mJle7arazhBOmko=;
        b=uBhtrmUWcQZYqn4uY2bSvQU2eud7UeI4VaPCawfTs8lFgDgS4S6oPVwHPGi/J9JSi9
         Cg8t2/x3c9XBn7O2ZyzPmAa24lRvVSS56PbNRD8WZZy6uXNC7vSRqI/mEFUQYiFtw82n
         QaAe6CwzMeadrUWLErPi90FmPSizT7npPdN807HHxfQ0ETTTy/8g2I0+rE9upci26NjO
         4q9QkuIwRxz6Wf4VpZ+NqpPEaIE/xpwICIzuQ+c7zIu8BvbwwJUpJzvP2hsEvDYbkObr
         Vqnwj0FO0s8LL4qTBPyGsn0llyb/7JC1OBKfQGzlOZVvhLQ41PJlUlyAHlhXi5L8SuyF
         ExTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692599352; x=1693204152;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+jqHn5WqQaJCtg0AUJN1FB+zw67/mJle7arazhBOmko=;
        b=f35KJjYaYt55yK+Tf19ej2Wq25gqTAgiIza6Veo38K1rLyBBBvdyu2/LIzVsa6GRTP
         /ZKR36LEoP9kVpkdsDSeMrekkY8XAAsiAlzKi7WHN/ThqOjGgM1fUkRzRPJy4uiiRzo7
         IibzgMjKm+jBpx3OEgRBHPw/ag53g4nCjas/HOiwXy7ypACylZU8CsmBc9Tl7AjN1DO6
         FOsF1FUdDU1YbrwLuj9GkWZRd2wuy1iv1AA/TWF06vtsQqPUQy0nKFn8bh5lHX5LU4aT
         GUBiQY48mhxMROukm1+y39DV2+4Aq9TdZwB2l9CElfyKmEu+JVcCHGHNhkoYn5MDRM6b
         GYpw==
X-Gm-Message-State: AOJu0YyQANGHSDwk+cXM7N1pyaPDq2FFYcN8luzhPVSSfkPFeSnVyXP/
        i2ph1tM+rhfLeEgP0+wZZW9BLQ==
X-Google-Smtp-Source: AGHT+IHd6+ypVwsYhxnMdbL1UGq6ySkQpWZQ9iHuM8cgfdj0lw84KWdQOHSNV2yTMAzl8mMt2IyJ8A==
X-Received: by 2002:a17:907:9483:b0:99d:f274:316e with SMTP id dm3-20020a170907948300b0099df274316emr5384047ejc.2.1692599352343;
        Sun, 20 Aug 2023 23:29:12 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id kj20-20020a170907765400b0099cc402d3ddsm5836644ejc.202.2023.08.20.23.29.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Aug 2023 23:29:11 -0700 (PDT)
Message-ID: <946ef7a0-a60b-b6ab-69f8-b169343f36f9@linaro.org>
Date:   Mon, 21 Aug 2023 08:29:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net-next 2/3] dt-bindings: net: add T-HEAD dwmac support
Content-Language: en-US
To:     Jisheng Zhang <jszhang@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20230820120213.2054-1-jszhang@kernel.org>
 <20230820120213.2054-3-jszhang@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230820120213.2054-3-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/08/2023 14:02, Jisheng Zhang wrote:
> Add documentation to describe T-HEAD dwmac.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---

Thank you for your patch. There is something to discuss/improve.

> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/thead,dwmac.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: T-HEAD DWMAC glue layer

Describe/name rather the actual device, not some layer.

> +
> +maintainers:
> +  - Jisheng Zhang <jszhang@kernel.org>
> +
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - thead,th1520-dwmac
> +  required:
> +    - compatible
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - thead,th1520-dwmac
> +      - const: snps,dwmac-3.70a
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: GMAC main clock
> +      - description: AXI clock
> +
> +  clock-names:
> +    items:
> +      - const: stmmaceth
> +      - const: axi

Isn't basically axi clock a pclk? You should rather use the names from
snps,dwmac

> +
> +  thead,gmacapb:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      The phandle to the syscon node that control ethernet
> +      interface and timing delay.
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - interrupts
> +  - interrupt-names
> +  - phy-mode
> +  - thead,gmacapb

Best regards,
Krzysztof

