Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F81777D9F9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 07:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241976AbjHPFuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 01:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241977AbjHPFuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 01:50:01 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82292121
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 22:49:58 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fe4ad22eb0so60114505e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 22:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692164997; x=1692769797;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nNLXsr0s7fN2vlJ7WgYIOrcnNSUa7Trbr0KkmJHmt7s=;
        b=qm3yLkh+uRHSbw1CsM/joxqElIjw9A01Uz6Qr2C/8I/Xq/J3BA7U2giBTHlRoVkGUA
         2i48OuqkAJGDAj00lxzJ0RwCmrhEcfCIdCvTi7MI0/ajm8l46gjnMDRedJ9O69LrjNpT
         n/fvKA7tM3Hy952JPAdjvmNFuqpGghfE41h3Jgg1QT63mMFBjgLIgbvRVj/FpSmLFOOp
         5VR/LAsZrhFfg4iuCizpOKnC6+/WOKjOxp1MtI8hTTlyqZfaXfUBilvRuJ/ngnd3JoI8
         LB6RYrZ5tD0aQ1Oc8kp0GPVe5CCOo2hxOaEMFUT4HrjHRW/PxElPwv9RT5wYLcFwWrhO
         ruiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692164997; x=1692769797;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nNLXsr0s7fN2vlJ7WgYIOrcnNSUa7Trbr0KkmJHmt7s=;
        b=T3Yyo5AuQRLl2IN8e6MxzGkNlyRwwa5z3IWR9Q9cUN4AcjWubJLI2Fo8PqulnmXUb6
         iSiZRKo4yMtIbKqJr4aUFd1XLL7tlqI+J07W7GXJJw3IGBvVo97n4GEHLTBdgKMSGFGM
         RT04ORnnto16Hl3zh5BF7E6MsXOu+8dbS6XHg2GwoDMHxSTUBdYkNNxVjX8ho05cAVw+
         MCkg6j+HMy2A52PAQemygh/69ln+0WYB6Rh7JXqwWw0n/7Sp3B7l7poPaN3XSuo16ZmN
         GAG8s1jsdi2ju4X3uU5B47xGlyRcMybFvhD0gH2vSJd/TwVMYIspdknb5xMK0MsxuuwI
         m8Fw==
X-Gm-Message-State: AOJu0Yxx1p2Zeq4oa4q9IIDf/qG0GR4tixzMayE4QZKXP9071vPThAnc
        Au5iaiWuVe6yoM/2fR0RqqMpLA==
X-Google-Smtp-Source: AGHT+IFgMLoHjX9wzBsnMWhZJ5I9/F308mdxifLMSuc7TlZn3OvjiN/RgU0eCPD+auDnRUr8HUlmxw==
X-Received: by 2002:a05:600c:378b:b0:3fe:2120:a87a with SMTP id o11-20020a05600c378b00b003fe2120a87amr556303wmr.37.1692164997355;
        Tue, 15 Aug 2023 22:49:57 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id y9-20020a1c4b09000000b003fe1cac37d8sm22535591wma.11.2023.08.15.22.49.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 22:49:56 -0700 (PDT)
Message-ID: <f4f6baa5-37af-f971-6c05-1070ee66501e@linaro.org>
Date:   Wed, 16 Aug 2023 07:49:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/4] dt-bindings: clock: qcom: Add ECPRICC clocks for
 QDU1000 and QRU1000
Content-Language: en-US
To:     Imran Shaik <quic_imrashai@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Taniya Das <quic_tdas@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>
References: <20230808051407.647395-1-quic_imrashai@quicinc.com>
 <20230808051407.647395-2-quic_imrashai@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230808051407.647395-2-quic_imrashai@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/2023 07:14, Imran Shaik wrote:
> Add device tree bindings for qcom ecpri clock controller on QDU1000 and
> QRU1000 SoCs.
> 
> Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
> ---
>  .../bindings/clock/qcom,qdu1000-ecpricc.yaml  |  68 +++++++
>  .../dt-bindings/clock/qcom,qdu1000-ecpricc.h  | 192 ++++++++++++++++++
>  2 files changed, 260 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,qdu1000-ecpricc.yaml
>  create mode 100644 include/dt-bindings/clock/qcom,qdu1000-ecpricc.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,qdu1000-ecpricc.yaml b/Documentation/devicetree/bindings/clock/qcom,qdu1000-ecpricc.yaml
> new file mode 100644
> index 000000000000..db54052bf360
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,qdu1000-ecpricc.yaml
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/qcom,qdu1000-ecpricc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm ECPRI Clock & Reset Controller for QDU1000 and QRU1000
> +
> +maintainers:
> +  - Taniya Das <quic_tdas@quicinc.com>
> +  - Imran Shaik <quic_imrashai@quicinc.com>
> +
> +description: |
> +  Qualcomm ecpri clock control module which supports the clocks, resets
> +  on QDU1000 and QRU1000
> +
> +  See also:: include/dt-bindings/clock/qcom,qdu1000-ecpricc.h
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,qdu1000-ecpricc
> +
> +  clocks:
> +    items:
> +      - description: Board XO source
> +      - description: GPLL0 source from GCC
> +      - description: GPLL1 source from GCC
> +      - description: GPLL2 source from GCC
> +      - description: GPLL3 source from GCC
> +      - description: GPLL4 source from GCC
> +      - description: GPLL5 source from GCC
> +
> +  '#clock-cells':
> +    const: 1
> +
> +  '#reset-cells':
> +    const: 1
> +
> +  reg:
> +    maxItems: 1

Keep the same order as in required: below.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

