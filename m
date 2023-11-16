Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129817EE04E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 13:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345219AbjKPMBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 07:01:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345125AbjKPMBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 07:01:31 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A2D1A8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 04:01:27 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-6711dd6595fso3760506d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 04:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700136087; x=1700740887; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RYTyb4AVOppxRC2VD0OH7VueF4AOCkDb3X77oQ0LuQI=;
        b=MtVVRnX72funWISMFOFXAu00iT73wBtmo3VeYih35nzPc0n0DKybwCKRvK8EXj65mM
         lNu2MlpyOEnpVrNTNTAAJSTCNKGqByK7mdAxx39E92uBxD98i1rdeHAYLxwD+xv4naBD
         /DPYQmZXEj/0d6/NrsVjzndRtMCMgFRVzwUYKkofc5kbNpz7I3qlYCxx/fWsxf60jUOk
         bVnkLipyqYchN0wYmQAGZbxSpjwhGQf/Z3MUk+5x3LWVAcnS/pY2qhkrfqK+H0uSBIAf
         gZjan4Fi6AzXfDIrXc6eVOnLwVFe2hIsenX30J6hey72ld/pBrIuJ4fEcj1f1CCs9L8i
         qWQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700136087; x=1700740887;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RYTyb4AVOppxRC2VD0OH7VueF4AOCkDb3X77oQ0LuQI=;
        b=c4P+adbQsZruXABuOXvj8gyjXhFACsmCCTQ7NW1bykngLF++xvDukJgXdcg52os6jk
         B5p/Yq95yFhG2Mo6H2V4ZK5jwwBbGz4olHl+62LqF6b2VMo6kO6SyVGgaqehP+fLEScG
         DZ64KkiJvXA1KOzxfSDj7HP/6VcI0SM6J9/iQn/GGYz1EuiABERc8y96j65AxZfW6HqI
         yIdi6w1J5Ti6wkkSn2V7S5VohepGsAg5hkoxZrIxBafLxd3bzqtDFVWksct2zkj+VO7b
         +gTxBayKOee0pZKMwMlehXv4I02nDkzvYunYUQY6PkzMZ6oX6rH6Erz+Ui/KFJjN1J3b
         T/5A==
X-Gm-Message-State: AOJu0YyJLNwo/5GbSwNupMkNCyOnr7yMPOHReI/JDxdDWPL/2wfLOHmc
        JcLPAjrMbq1+F86/1nxZYh1EHG2Ntf82xUgY7wY=
X-Google-Smtp-Source: AGHT+IEoR0LOdhqX9a0a+yUyJ0j+OgWZC/UuYaQoUUdquoW41c946yz8ZlWuHnCM6+aSIZJsa9u3SA==
X-Received: by 2002:ad4:598f:0:b0:677:a1a2:1cae with SMTP id ek15-20020ad4598f000000b00677a1a21caemr7558602qvb.37.1700136086930;
        Thu, 16 Nov 2023 04:01:26 -0800 (PST)
Received: from [192.168.212.13] ([12.191.197.195])
        by smtp.gmail.com with ESMTPSA id n18-20020a0cfbd2000000b00641899958efsm1324437qvp.130.2023.11.16.04.01.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 04:01:26 -0800 (PST)
Message-ID: <87e9b938-bb72-41a1-a54d-deed543077eb@linaro.org>
Date:   Thu, 16 Nov 2023 13:01:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: gpio: realtek: Add realtek,rtd-gpio
Content-Language: en-US
To:     Tzuyi Chang <tychang@realtek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231116111441.2339-1-tychang@realtek.com>
 <20231116111441.2339-2-tychang@realtek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231116111441.2339-2-tychang@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/2023 12:14, Tzuyi Chang wrote:
> Add the device tree bindings for the Realtek DHC(Digital Home Center)
> RTD SoCs GPIO controllers.
> 
> Signed-off-by: Tzuyi Chang <tychang@realtek.com>
> ---
> v1 to v2 change:
>     1. Add description for DHC RTD SoCs.
>     2. Revise the compatible names.
>     3. Add descriptions for reg and interrupts properties.
> ---
>  .../bindings/gpio/realtek,rtd-gpio.yaml       | 74 +++++++++++++++++++
>  1 file changed, 74 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/realtek,rtd-gpio.yaml
> 
> diff --git a/Documentation/devicetree/bindings/gpio/realtek,rtd-gpio.yaml b/Documentation/devicetree/bindings/gpio/realtek,rtd-gpio.yaml
> new file mode 100644
> index 000000000000..11c8278801c3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/realtek,rtd-gpio.yaml
> @@ -0,0 +1,74 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2023 Realtek Semiconductor Corporation
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/gpio/realtek,rtd-gpio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Realtek DHC GPIO controller
> +
> +maintainers:
> +  - Tzuyi Chang <tychang@realtek.com>
> +
> +description:
> +  The GPIO controller is designed for the Realtek DHC (Digital Home Center)
> +  RTD SoC family, which are high-definition media processor SoCs.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:

Drop items.

> +          - enum:
> +              - realtek,rtd1295-misc-gpio
> +              - realtek,rtd1295-iso-gpio
> +              - realtek,rtd1395-iso-gpio
> +              - realtek,rtd1619-iso-gpio
> +      - items:
> +          - enum:
> +              - realtek,rtd1319-iso-gpio
> +              - realtek,rtd1619b-iso-gpio
> +              - realtek,rtd1319d-iso-gpio
> +              - realtek,rtd1315e-iso-gpio
> +          - const: realtek,rtd-gpio

Either you use generic compatible for everything or not. Other variants
do not use generic compatible, so neither should these. Use SoC-specific
compatible as fallback.

I asked you to to drop this compatible. I could not be more specific, so
you just ignored this remark.

So again: what is "rtd"? Why it does not appear anywhere in description
or title? No, drop it.


Best regards,
Krzysztof

