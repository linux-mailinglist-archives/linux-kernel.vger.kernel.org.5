Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7FBE782FB6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 19:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237041AbjHURyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 13:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235424AbjHURyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 13:54:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059CB127;
        Mon, 21 Aug 2023 10:54:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 815C061F9B;
        Mon, 21 Aug 2023 17:54:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B92C433C7;
        Mon, 21 Aug 2023 17:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692640458;
        bh=eULPeh9pcpIpgr9n3QKkncPC16Bdlg+o+kHreVFr5n0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BrWbWRtDp0sKSJrWAQKeLiEyMgEDfDNX+CoCjIBPnfX7kGpxJEE06KMQcoejyh4QK
         aKusKDihtP0LLZTsTTQBS2j5qoD+vPZ5+NkeV/CSllzz1eqbbRxSpaMTd0bZ6ZRFwh
         1TaxiCkDS9+9SECz+5oseNL4WIBL/+J5Tye+3JvagXwCL7J5nrw5fhIGzh4sOB8aE/
         sjkkaGyuV/BqVh2ZhVQuAcpt5D2rgOXhUqaIDOdaFiG0F0R2HKsb//iGrBV+DShDqS
         MK9qdGWdzqx78Lj4PwSgMSNxWOKEcs0MltNv1aXfl/OFH9XYSUTakgcj4rM4gtqKdd
         oD3GjxRJVZo3A==
Received: (nullmailer pid 2032613 invoked by uid 1000);
        Mon, 21 Aug 2023 17:54:16 -0000
Date:   Mon, 21 Aug 2023 12:54:16 -0500
From:   Rob Herring <robh@kernel.org>
To:     Mao Jinlong <quic_jinlmao@quicinc.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: arm: Adds CoreSight CSR hardware
 definitions
Message-ID: <20230821175416.GA2022808-robh@kernel.org>
References: <20230813151253.38128-1-quic_jinlmao@quicinc.com>
 <20230813151253.38128-3-quic_jinlmao@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230813151253.38128-3-quic_jinlmao@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 13, 2023 at 11:12:52PM +0800, Mao Jinlong wrote:
> Adds new coresight-csr.yaml file describing the bindings required
> to define csr in the device trees.

Why?

What is CSR? Control & Status Registers in my book.

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

Don't need '|'

> +  CoreSight Slave Register block hosts miscellaneous configuration registers.
> +  Those configuration registers can be used to control, various coresight
> +  configurations.

I still have no idea what this block does other than something related 
to Coresight.

> +
> +maintainers:
> +  - Mao Jinlong <quic_jinlmao@quicinc.com>
> +  - Hao Zhang <quic_hazha@quicinc.com>
> +
> +properties:
> +  $nodename:
> +    pattern: "^csr(@[0-9a-f]+)$"
> +  compatible:
> +    items:
> +      - const: qcom,coresight-csr
> +
> +  reg:
> +    minItems: 1
> +    maxItems: 2
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

Unit-addresses are typically hex.

> +    type: object
> +    description:
> +      A assocated device child node which describes the required configs
> +      between this CSR and another hardware device. This device may be ETR or
> +      TPDM device.
> +
> +    properties:
> +      reg:
> +        maxItems: 1

I don't understand what 'reg' signifies here.

> +
> +      arm,cs-dev-assoc:
> +        $ref: /schemas/types.yaml#/definitions/phandle
> +        description:
> +          defines a phandle reference to an associated CoreSight trace device.
> +          When the associated trace device is enabled, then the respective CSR
> +          will be enabled. If the associated device has not been registered
> +          then the node name will be stored as the assocated name for later
> +          resolution.

registered? Sounds like a OS detail that doesn't belong in DT.

> +
> +      qcom,cs-dev-type:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          Device type of the Assocated device. Types are in coresight-csr-dt.h.

Constraints?

> +
> +      qcom,csr-bytecntr-offset:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          The ETR irqctrl register offset. If the assocated device is ETR
> +          device and there are more than one ETR devices, this property need
> +          to be added.

You should know the register offset based on the ETR compatible.

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
> -- 
> 2.17.1
> 
