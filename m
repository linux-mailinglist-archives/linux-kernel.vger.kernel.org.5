Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354B37839B6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 08:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbjHVGEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 02:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjHVGEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 02:04:44 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41749186
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 23:04:41 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99cce6f7de2so551555266b.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 23:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692684280; x=1693289080;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C3aWA1jtQ3ekjqLkSXHoeqbDYDQZG5PYeCTI0ujmipE=;
        b=y4C2X+SsvjepV4ge15y35NSFMDWBeSiNTt0+AHmsPCzXgF04nCuWhoBdcJGUOAuSHb
         +1GQ3uVuRXIjN7BhDK+HXCbbnG4Husp/jlTg9DFI3pJSW0tiKacU79idb8InnmbUv8XV
         dYdFgdkn27EHnllI+Tm8B0YprU8Zy9/2lnUMoTV9HvspLQ97yDuNwtj6zM5B5eIUBEs3
         GZ7aTdBiT2F1vW2Tw7SjZ+DMMFygPuzm84GacIsuJSEAQv6uMUtY3Awt79Zo2bC4z9fG
         BQ67xeAKHd/0reQp2r/4L6KSt4DuY9CDhXFIRBkPerubVixgwbb/kzXxlqWUf/V7fDNh
         YC6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692684280; x=1693289080;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C3aWA1jtQ3ekjqLkSXHoeqbDYDQZG5PYeCTI0ujmipE=;
        b=GUow01HEb7QZ75P88HiM9bqoV0wIvEYNgvOXhZOGy3y1uqGWEQho3GH1+88RfWDplL
         AZdmmDVf6687quIUs+0pVvMZXTPsDbVal3Ig9hM/Q/tdv/GHpRM+pPcOghmSxt0kEvKB
         sVdVj9lX/qExeUTvVdm+PE7biHvEELYLJVSaBjq4/g2ufkyz7EPf5UIWH4/VNQLsbYYC
         HzClivz6w8jDCCL/1M7anoIejUiS5DGNkZMshvx5WyuhJPad+rVq1xulg0+9TOs11eT8
         eLCDvYIyTE9pHQzU5hwDHwZyjOPRJD+IgF2ArcS8IJndHPXHNUyJxerPIK7WFBQDEp+0
         vymw==
X-Gm-Message-State: AOJu0Yweg6VTcWT3u5c0GnMkkuaSsJ2ABT+ZGjITleJiJ4GMPT+MnLfm
        nrLJiRKS1rU5OhNo8CsZWzs9Fw==
X-Google-Smtp-Source: AGHT+IGwTAFZN57WbIIvRgAX4lgW31qSiyruvaXkXryqzj8k10mR/AG4zrjU24SlgJ3PO2XtYltQpw==
X-Received: by 2002:a17:906:3287:b0:992:a836:a194 with SMTP id 7-20020a170906328700b00992a836a194mr6405065ejw.59.1692684279572;
        Mon, 21 Aug 2023 23:04:39 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id lo8-20020a170906fa0800b009929ab17bdfsm7558296ejb.168.2023.08.21.23.04.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 23:04:39 -0700 (PDT)
Message-ID: <e2a0c77d-cb48-9348-672a-6adaae38df3c@linaro.org>
Date:   Tue, 22 Aug 2023 08:04:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 2/3] dt-bindings: arm: Adds CoreSight CSR hardware
 definitions
Content-Language: en-US
To:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>
References: <20230813151253.38128-1-quic_jinlmao@quicinc.com>
 <20230813151253.38128-3-quic_jinlmao@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230813151253.38128-3-quic_jinlmao@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/08/2023 17:12, Mao Jinlong wrote:
> Adds new coresight-csr.yaml file describing the bindings required
> to define csr in the device trees.
> 
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>  .../bindings/arm/qcom,coresight-csr.yaml      | 130 ++++++++++++++++++
>  MAINTAINERS                                   |   2 +-
>  include/dt-bindings/arm/coresight-csr-dt.h    |  12 ++
>  3 files changed, 143 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/qcom,coresight-csr.yaml
>  create mode 100644 include/dt-bindings/arm/coresight-csr-dt.h
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-csr.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-csr.yaml
> new file mode 100644
> index 000000000000..de4baa335fdb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/qcom,coresight-csr.yaml
> @@ -0,0 +1,130 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/qcom,coresight-csr.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: CoreSight Slave Register - CSR
> +
> +description: |
> +  CoreSight Slave Register block hosts miscellaneous configuration registers.
> +  Those configuration registers can be used to control, various coresight
> +  configurations.
> +
> +maintainers:
> +  - Mao Jinlong <quic_jinlmao@quicinc.com>
> +  - Hao Zhang <quic_hazha@quicinc.com>
> +
> +properties:
> +  $nodename:
> +    pattern: "^csr(@[0-9a-f]+)$"

Blank line. Or even drop the nodename, we do not enforce names in the
individual bindings and I do not get why "csr" should be a recommended
name. It's not really generic, but specific.

> +  compatible:
> +    items:
> +      - const: qcom,coresight-csr
> +
> +  reg:
> +    minItems: 1
> +    maxItems: 2

Why is this flexible? One device has only one register layout... or you
want to say that compatible is not specific but generic?

Anyway, items needs to be described.

> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: apb_pclk
> +
> +  # size cells and address cells required if assoc_device node present.
> +  "#size-cells":
> +    const: 0
> +
> +  "#address-cells":
> +    const: 1
> +
> +patternProperties:
> +  '^assoc_device@([0-9]+)$':

No underscores.

Aren't you now creating duplicated nodes for devices? ETRs for example
have their device nodes, right? So here you would be creating second
one? If that's the case, then it looks wrong.

> +    type: object
> +    description:
> +      A assocated device child node which describes the required configs
> +      between this CSR and another hardware device. This device may be ETR or
> +      TPDM device.
> +
> +    properties:
> +      reg:
> +        maxItems: 1
> +
> +      arm,cs-dev-assoc:
> +        $ref: /schemas/types.yaml#/definitions/phandle
> +        description:
> +          defines a phandle reference to an associated CoreSight trace device.
> +          When the associated trace device is enabled, then the respective CSR
> +          will be enabled. If the associated device has not been registered
> +          then the node name will be stored as the assocated name for later
> +          resolution.
> +
> +      qcom,cs-dev-type:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          Device type of the Assocated device. Types are in coresight-csr-dt.h.
> +
> +      qcom,csr-bytecntr-offset:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          The ETR irqctrl register offset. If the assocated device is ETR
> +          device and there are more than one ETR devices, this property need
> +          to be added.
> +
> +      interrupts:
> +        minItems: 1
> +
> +      interrupt-names:
> +        minItems: 1
> +
> +    required:
> +      - reg
> +      - qcom,cs-dev-type
> +      - qcom,cs-dev-assoc
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  # minimum CSR definition.
> +  - |
> +    csr@10001000 {
> +      compatible = "qcom,coresight-csr";
> +      reg = <0 0x10001000 0 0x1000>;
> +
> +      clocks = <&aoss_qmp>;
> +      clock-names = "apb_pclk";
> +    };
> +  # Assocated with ETR device
> +  - |
> +    #include <dt-bindings/arm/coresight-csr-dt.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    csr@10001000 {
> +      compatible = "qcom,coresight-csr";
> +      reg = <0 0x10001000 0 0x1000>;
> +
> +      clocks = <&aoss_qmp>;
> +      clock-names = "apb_pclk";
> +
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      assoc_device@0 {
> +        reg = <0>;
> +        qcom,cs-dev-type = <CSR_ASSOC_DEV_ETR>;
> +        qcom,cs-dev-assoc = <&tmc_etr>;
> +        qcom,csr-bytecntr-offset = <0x6c>;
> +        interrupts = <GIC_SPI 270 IRQ_TYPE_EDGE_RISING>;
> +        interrupt-names = "byte-cntr-irq";
> +      };
> +    };
> +...
> +
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d516295978a4..3ed81a8fd1d0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2042,7 +2042,7 @@ F:	Documentation/devicetree/bindings/arm/arm,trace-buffer-extension.yaml
>  F:	Documentation/devicetree/bindings/arm/qcom,coresight-*.yaml
>  F:	Documentation/trace/coresight/*
>  F:	drivers/hwtracing/coresight/*
> -F:	include/dt-bindings/arm/coresight-cti-dt.h
> +F:	include/dt-bindings/arm/coresight-*.h
>  F:	include/linux/coresight*
>  F:	samples/coresight/*
>  F:	tools/perf/arch/arm/util/auxtrace.c
> diff --git a/include/dt-bindings/arm/coresight-csr-dt.h b/include/dt-bindings/arm/coresight-csr-dt.h
> new file mode 100644
> index 000000000000..804b9bbeb2bd
> --- /dev/null
> +++ b/include/dt-bindings/arm/coresight-csr-dt.h

Use the same naming pattern as for bindings, so qcom,coresight-csr if it
is qcom, or arm,coresight-csr if it is ARM. DT is for sure redundant.

> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
> +/*
> + * This header provides constants for the defined device
> + * types on CoreSight CSR.
> + */
> +
> +#ifndef _DT_BINDINGS_ARM_CORESIGHT_CSR_DT_H
> +#define _DT_BINDINGS_ARM_CORESIGHT_CSR_DT_H
> +
> +#define CSR_ASSOC_DEV_ETR	1
> +
> +#endif /*_DT_BINDINGS_ARM_CORESIGHT_CSR_DT_H */

Best regards,
Krzysztof

