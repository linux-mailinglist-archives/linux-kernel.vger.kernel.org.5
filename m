Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C334078BFD6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 10:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbjH2IC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 04:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233956AbjH2ICO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 04:02:14 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66EC9124
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 01:02:08 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9a58dbd5daeso395579866b.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 01:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693296127; x=1693900927;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3ffv5qw/6jxHEizOlIzxqYRFHwCAgzFtDLHEMCrXrHo=;
        b=BbMLPYtBom3oXw6zYv3nACWBOPYGb6pGAlI/z0dXUofyBMSzlBFQx2AOiVZ0+33whA
         6C3a9pEQb3as0eF0AmRL8UYKmQF3pewBAZayZ/fkMwBOEEq4qE4Y20ofk9pO1KJsf6k/
         a/7z+Ah2zYwh3U0mnYMWyMbj+7lsVBdO100oQqxTvzi5GmJ9Mw1yLOFL5LxFMxg3854j
         AlllGlwipBSrpsfoO4FvR28l8IDscpfRfLScEdNdi3QK0XCJT+N0opd9izN3G1GYz34T
         3CcjZrzGmfp/oe+TPU/MswLbOqMc8dpCEpqiVpC0EdWm3HyLLoDYRb3PNkNnFvhsGTpo
         GrQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693296127; x=1693900927;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ffv5qw/6jxHEizOlIzxqYRFHwCAgzFtDLHEMCrXrHo=;
        b=cf/FQmRbM2mdOX5MVsDp8/O22mJzLnkY3HmcsqBC2ZIB3blE/Y/u21rxXxQc9nQB3D
         Tmefpro9cle6B9wS63JBS7S7KQtYh0UjydlfOYM2VTPWRIhiNt9zNrTwdmyhno0Hw/PC
         NYnrioEItnpKTmeVz2Cnkue2q/x87Gvr1pIKCm8a2SK2IdgmcNtBorSpjl4NIZr3SpSn
         7jI22FzzwwcAIdLnobX35NXZh+lO4A2dlydKZa8DmxOyEbOBv3JJhxARoXsMMCLNYvI3
         pPDvJZy6rfk865WOv8NU7D690hBj0Q5XtOFOA2kZ343xhUaG4GVpUtqzVM/uPtoKwxyq
         balg==
X-Gm-Message-State: AOJu0YwImHhLfs1mf0g3ZUqucXtoZh2yC1/K/nzBd4RvQr3jOoIhZgqE
        4/h8ylQcW478xr37LwhkctqBZw==
X-Google-Smtp-Source: AGHT+IFqEpbqllRr9CmppqIvv8zyZ4jAIDeUvqKWTsD0QK0EcQXaJCfzI0u6bX/7CG2STBh5BqFSKg==
X-Received: by 2002:a17:906:d14d:b0:9a5:8eab:49da with SMTP id br13-20020a170906d14d00b009a58eab49damr6813967ejb.19.1693296126878;
        Tue, 29 Aug 2023 01:02:06 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.196])
        by smtp.gmail.com with ESMTPSA id u4-20020a170906108400b0099d798a6bb5sm5640390eju.67.2023.08.29.01.02.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 01:02:06 -0700 (PDT)
Message-ID: <9b69a4a6-b011-f0e8-217f-5f91d9a00382@linaro.org>
Date:   Tue, 29 Aug 2023 10:02:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 05/11] dt-bindings: document the Qualcomm TEE Shared
 Memory Bridge
Content-Language: en-US
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     kernel@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230828192507.117334-1-bartosz.golaszewski@linaro.org>
 <20230828192507.117334-6-bartosz.golaszewski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230828192507.117334-6-bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/08/2023 21:25, Bartosz Golaszewski wrote:
> Add Device Tree bindings for Qualcomm TEE Shared Memory Brige - a
> mechanism that allows sharing memory buffers between trustzone and the
> kernel.

Subject prefix:
dt-bindings: firmware:



> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  .../bindings/firmware/qcom,shm-bridge.yaml    | 36 +++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/firmware/qcom,shm-bridge.yaml
> 
> diff --git a/Documentation/devicetree/bindings/firmware/qcom,shm-bridge.yaml b/Documentation/devicetree/bindings/firmware/qcom,shm-bridge.yaml
> new file mode 100644
> index 000000000000..f660962b7b86
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/firmware/qcom,shm-bridge.yaml
> @@ -0,0 +1,36 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/firmware/qcom,shm-bridge.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: QCOM Shared Memory Bridge
> +
> +description: |

Do not need '|' unless you need to preserve formatting.

> +  Qualcomm TEE Shared Memory Bridge allows sharing limited areas of kernel's
> +  virtual memory with the trustzone in order to avoid mapping the entire RAM.
> +
> +maintainers:
> +  - Bjorn Andersson <andersson@kernel.org>
> +  - Konrad Dybcio <konrad.dybcio@linaro.org>
> +  - Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - qcom,shm-bridge-sa8775p
> +          - qcom,shm-bridge-sm8150
> +          - qcom,shm-bridge-sm8450
> +      - const: qcom,shm-bridge
> +

Looks quite empty... Why this cannot be part of qcom,scm? IOW, why do
you need new binding if you do not have any resources here and the block
is essentially feature of qcom,scm firmware?

> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    firmware {
> +         compatible = "qcom,shm-bridge-sa8775p", "qcom,shm-bridge";

Use 4 spaces for example indentation.

> +    };

Best regards,
Krzysztof

