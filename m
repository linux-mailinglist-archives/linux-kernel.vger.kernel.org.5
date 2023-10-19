Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F2C7CF64E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 13:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345292AbjJSLMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 07:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjJSLMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 07:12:08 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3090112
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 04:12:05 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c50fbc218bso81517781fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 04:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697713924; x=1698318724; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RtOBMj5NZCZ3rE38kW7IfyaEnFmC+iva60OYyJozRyc=;
        b=HC9q4g9KRXTci/2N6VeE6pmbpeeLpB7EUyt//4GaqTh/JjvSO+cA396lzB/hhJ/0sP
         epHeTPGVSPG3zGFL9ChhqOzm5BC+fm6ww3eMQ7VvRhpAI7qZl0gWVMjleJs/ygAwA17/
         NnPYnHehl8RgrvSYOsR4xy5nJp1FbUbd0n6WsP+O7EhtMU6bMIbEuz9dgjEC8yrQymS/
         T+z+u3aTSAIzqh6DgJGHFU9/hPteD5fkKZnCN5FM5H5PfI/WuCMEL+6N1k0oMyTW3uBU
         3tXEKiLQC1j9y0VlQoTZGY21YBmbjOgPnJIz/bPcEh/BRKFCwOM7KRUD5fJnRWtRofEf
         hVbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697713924; x=1698318724;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RtOBMj5NZCZ3rE38kW7IfyaEnFmC+iva60OYyJozRyc=;
        b=VMqUn+aOGSbpVBw97hVe3dy4YFmMZxofhflx1zhvm/2ssEG15N7o2uW1GkGyy/7qrq
         AeQ17HON9QRa1JmJc8eAlXLLq7RGZhtPVTgF4Q/quwpZltLpH+pyFbGzjT3bSjEInd13
         eCdVPeMEvukDzHPmYk+4KUzHWtJRpypxmyhA+8JYd/LAild4yZK0MPKYctFNDM2mbHQb
         GE2A/NTLVZ31ukBrF2Uoxhc3l83zsV25QbkjnVDfa3sjw3WjqGtn5lJfw9wUHixv0oC5
         /i1qS3ZnJc1rg2JPfZmN2FUDY1o91mfCPdAhtBC295qQzruHjANmZyzC07P1/fgkVZfI
         gpKQ==
X-Gm-Message-State: AOJu0YzaeRNekRtsjnKP+q7K4v9inAOJxD51uO5GyW8TxzTQf2Im9+aX
        vo88SDf8OBUtV85XyieGl1CaXw==
X-Google-Smtp-Source: AGHT+IGX8OcOitOpOYyprBygGim1jCB9UfYAEhRf1IOq9svY+RPykFe2aA7gU/0+po21Z8CdD+v3kA==
X-Received: by 2002:a05:651c:454:b0:2c5:cf0:74e9 with SMTP id g20-20020a05651c045400b002c50cf074e9mr1162473ljg.14.1697713923849;
        Thu, 19 Oct 2023 04:12:03 -0700 (PDT)
Received: from [172.30.205.86] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id q12-20020a05600c2e4c00b0040648217f4fsm4089784wmf.39.2023.10.19.04.12.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 04:12:03 -0700 (PDT)
Message-ID: <e084e2f4-de2c-4850-a7b7-8b3b4a50c9b5@linaro.org>
Date:   Thu, 19 Oct 2023 13:12:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] dt-bindings: iommu: Add Translation Buffer Unit
 bindings
To:     Georgi Djakov <quic_c_gdjako@quicinc.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        will@kernel.org, robin.murphy@arm.com, joro@8bytes.org
Cc:     devicetree@vger.kernel.org, andersson@kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        quic_cgoldswo@quicinc.com, quic_sukadev@quicinc.com,
        quic_pdaly@quicinc.com, quic_sudaraja@quicinc.com,
        djakov@kernel.org
References: <20231019021923.13939-1-quic_c_gdjako@quicinc.com>
 <20231019021923.13939-2-quic_c_gdjako@quicinc.com>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231019021923.13939-2-quic_c_gdjako@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/19/23 04:19, Georgi Djakov wrote:
> The "apps_smmu" on the Qualcomm sdm845 platform is an implementation
> of the ARM SMMU-500, that consists of a single TCU (Translation Control
> Unit) and multiple TBUs (Translation Buffer Units). The TCU is already
> being described in the ARM SMMU DT schema. Add also bindings for the
> TBUs so that we can describe their properties.
> 
> In this DT schema, the TBUs are modelled as a child devices of the TCU
> and each of them is described with it's own resources such as clocks,
> power domains, interconnects etc.
> 
> Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
> ---
>   .../devicetree/bindings/iommu/arm,smmu.yaml   | 13 ++++
>   .../bindings/iommu/qcom,qsmmuv500-tbu.yaml    | 67 +++++++++++++++++++
>   2 files changed, 80 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/iommu/qcom,qsmmuv500-tbu.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> index cf29ab10501c..afc323b4bbc5 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> @@ -230,6 +230,19 @@ properties:
>         enabled for any given device.
>       $ref: /schemas/types.yaml#/definitions/phandle
>   
> +  '#address-cells':
> +    const: 2
> +
> +  '#size-cells':
> +    const: 2
> +
> +  ranges: true
> +
> +patternProperties:
> +  "^tbu@[0-9a-f]+$":
> +    $ref: qcom,qsmmuv500-tbu.yaml
> +    description: The SMMU may include Translation Buffer Units (TBU) as subnodes
> +
>   required:
>     - compatible
>     - reg
> diff --git a/Documentation/devicetree/bindings/iommu/qcom,qsmmuv500-tbu.yaml b/Documentation/devicetree/bindings/iommu/qcom,qsmmuv500-tbu.yaml
> new file mode 100644
> index 000000000000..4baba7397e90
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iommu/qcom,qsmmuv500-tbu.yaml
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iommu/qcom,qsmmuv500-tbu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm TBU (Translation Buffer Unit)
> +
> +maintainers:
> +  - Georgi Djakov <quic_c_gdjako@quicinc.com>
> +
> +description:
> +  TBU nodes represent Translation Buffer Units in an ARM SMMU. Each TBU node
> +  should be a child node of the SMMU in the device tree.
description: refers to the hardware, so it should say what this IP
is, what it does and things like that

> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,qsmmuv500-tbu
Should we expect this list to grow?

> +
> +  reg:
> +    items:
> +      - description: Address and size of the TBU's register space.
> +
> +  reg-names:
> +    items:
> +      - const: base
> +
> +  clocks:
> +    maxItems: 1
> +
> +  interconnects:
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  qcom,stream-id-range:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description: Stream ID range (address and size) that is assigned by the TBU
I believe you need to size-limit this.

If it's only supposed to be a single tuple, perhaps it could be said
explicitly.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interconnects
> +  - qcom,stream-id-range
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,gcc-sdm845.h>
> +    #include <dt-bindings/interconnect/qcom,sdm845.h>
> +    #include <dt-bindings/power/qcom-rpmpd.h>
> +
> +
2 newlines seems excessive

> +    tbu@150e1000 {
> +        compatible = "qcom,qsmmuv500-tbu";
> +        reg = <0x150e1000 0x1000>;
> +        reg-names = "base";
> +        clocks = <&gcc GCC_AGGRE_NOC_PCIE_TBU_CLK>;
> +        power-domains = <&gcc HLOS1_VOTE_AGGRE_NOC_MMU_PCIE_TBU_GDSC>;
> +        interconnects = <&system_noc MASTER_GNOC_SNOC 0 &config_noc SLAVE_IMEM_CFG 0>;
> +        qcom,stream-id-range = <0x1c00 0x400>;
> +    };
I think it would be beneficial if this tbu was a child of some smmu node
like it's intended to be.

Konrad
