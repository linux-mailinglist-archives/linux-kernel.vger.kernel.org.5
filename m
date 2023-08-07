Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1FA771ACF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 08:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjHGGxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 02:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbjHGGxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 02:53:01 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6951BDF
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 23:52:37 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b9cdbf682eso63568191fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 06 Aug 2023 23:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691391131; x=1691995931;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8IF0yzc6AQ9CBWm+WqCwLb44jaEvchA3XftCWbCQ9L4=;
        b=IfRIAHWGdjLxmsV0rmnZyf1fOg8WbNu+ehKL82gk425VAwtIEAIINC4zB4q7Jb+dzr
         p9b/gbxhTtIX9WvRBLx5J0gqFffnZUNnEiYLaT0P07NiI87qqxlIfjIeKCs7mFMI3J30
         tfbKVHhRs+ltj78Y/kvblNAusfd+1GzAvHUIiHGkYHLnUoFrUdygK/H+zGdVxuuQ9LUd
         zN+OkffDfzKtlDkgwRwuDWBru+bive5yqnfsciRIB7QOAeYLDZTebey+EB3Qonju3iVu
         WeGPP7ImXtyJ7iSbqe4aMi4xr/fDFQV2hqN0q6N0IajkntePqwvJO+JdRqQxrLu21zj9
         rguQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691391131; x=1691995931;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8IF0yzc6AQ9CBWm+WqCwLb44jaEvchA3XftCWbCQ9L4=;
        b=hva8KDok1GyunSsxJaa/yHlQB0Bl//hF2UFQo+cREGHDitteLt4tm6yQ+A2CCug948
         Aj2Iu83s4dq8adPcAykxOjjNxHjT1+LZJ8mOoSFQ8jf1PthgFsKcJg+NBhIoe9w+yB5p
         gEeSJXQ33oQHr+H2zQyYxmt6l5Ltifsvr+k6GYaCVWxCWnSnzdfk1hKmZ6xtZcr6kzg+
         67ZR61F7bQ2DronAnmh7tehBnUkeeQVRqyrjfZrDp2ab5WYNUbcPoDnCPfv1UgOfDGQh
         hGNTjDaN+XxyYW1mB6j2C1uZmsc5FS85uk9bjipgAAGWbl5TPK9ICiNPY2s28UxtaIFB
         q18Q==
X-Gm-Message-State: AOJu0YxXxSoABsFGjfrCTtreY5t+pymyD5gSkMlDNAu8syuD1qyU8mD9
        IhfQLS803FEDk2ZOctf5euHxww==
X-Google-Smtp-Source: AGHT+IGqjo6zmRgY8j0C8XXJLbmy3JnrMpqbfOBeiwcg7iAa1v/qGTulOKuyVucOW2ba5x7xXnmTAQ==
X-Received: by 2002:a2e:6a0e:0:b0:2b9:e831:f165 with SMTP id f14-20020a2e6a0e000000b002b9e831f165mr5522024ljc.42.1691391131429;
        Sun, 06 Aug 2023 23:52:11 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id s9-20020a170906354900b0099b7276235esm4787000eja.93.2023.08.06.23.52.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Aug 2023 23:52:11 -0700 (PDT)
Message-ID: <ef996a7e-6eba-4366-c3ea-0d08f2768e98@linaro.org>
Date:   Mon, 7 Aug 2023 08:52:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 2/3] dt-bindings: clock: add qca8386/qca8084 clock and
 reset definitions
Content-Language: en-US
To:     Luo Jie <quic_luoj@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        p.zabel@pengutronix.de
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_srichara@quicinc.com
References: <20230801085352.22873-1-quic_luoj@quicinc.com>
 <20230801085352.22873-3-quic_luoj@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230801085352.22873-3-quic_luoj@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/08/2023 10:53, Luo Jie wrote:
> QCA8386/QCA8084 includes the clock & reset controller that is
> accessed by MDIO bus. Two work modes are supported, qca8386 works
> as switch mode, qca8084 works as PHY mode.
> 
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> ---
>  .../bindings/clock/qcom,nsscc-qca8k.yaml      |  59 ++++++++++
>  include/dt-bindings/clock/qcom,nsscc-qca8k.h  | 102 ++++++++++++++++++
>  include/dt-bindings/reset/qcom,nsscc-qca8k.h  |  76 +++++++++++++
>  3 files changed, 237 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,nsscc-qca8k.yaml
>  create mode 100644 include/dt-bindings/clock/qcom,nsscc-qca8k.h
>  create mode 100644 include/dt-bindings/reset/qcom,nsscc-qca8k.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,nsscc-qca8k.yaml b/Documentation/devicetree/bindings/clock/qcom,nsscc-qca8k.yaml
> new file mode 100644
> index 000000000000..8fb77156070c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,nsscc-qca8k.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/qcom,nsscc-qca8k.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm NSS Clock & Reset Controller on QCA8386/QCA8084
> +
> +maintainers:
> +  - Luo Jie <quic_luoj@quicinc.com>
> +
> +description: |
> +  Qualcomm NSS clock control module provides the clocks and resets
> +  on QCA8386(switch mode)/QCA8084(PHY mode)
> +
> +  See also::
> +    include/dt-bindings/clock/qcom,nsscc-qca8k.h
> +    include/dt-bindings/reset/qcom,nsscc-qca8k.h
> +
> +properties:
> +  compatible:
> +    const: qcom,nsscc-qca8k

SoC name is before IP block names. See:
Documentation/devicetree/bindings/arm/qcom-soc.yaml

qca8k is not SoC specific. I don't know what you are documenting here,
but if this is a SoC, then follow SoC rules.

If this is not SoC, it confuses me a bit to use GCC binding.

Anyway, this was not tested, as pointed out by bot... Please test the
code before sending.

Best regards,
Krzysztof

