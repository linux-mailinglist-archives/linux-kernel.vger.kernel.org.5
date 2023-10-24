Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1E1F7D5ACE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 20:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344129AbjJXSmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 14:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344024AbjJXSmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 14:42:53 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886C010D0;
        Tue, 24 Oct 2023 11:42:51 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1e5bc692721so3122505fac.0;
        Tue, 24 Oct 2023 11:42:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698172971; x=1698777771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e7tCIB9BylheYtMG7rMe1KZx7kNN6oaCCoyrHFzcP3w=;
        b=WEeRrWQ1hKrYVce1JRJpJZBNVmCAnoAGas+mr07qDA0Fo1oBAWvWcswX4p80Z7lzqV
         6TSJIHeFE2aUS9NGAf0tdPuwDOeX2+S+ynPaHUeBZWyZjDH/SrpfM5F/v7i55MGt8GvV
         Vbero89zGdYid3bmGAoucnzcdGId7jxq08ih0j11h9fliTSO58zFFeGN7ctVALs4GcOM
         ZNh8FFC13In6fsUKmcArB9QCK8TgFsF4t9u5850bTmd/8c8boIRLn05zXtwDil2L5Vhe
         Xi0KjCZBF3m1Zhvz3GyijCaykHVxWXoPGHq9uebjKEGjxc8FlSEZEAi4TPSaRMDMFjIE
         LGzg==
X-Gm-Message-State: AOJu0YxHld/ZaZfOSp2FJV408CamJebegO0W4xF/mdk1hNaHBoJ4sQkH
        a4jZPXOsHHlan/rD/JNTHg==
X-Google-Smtp-Source: AGHT+IEwPD0r1BvSI+qia1MrYQNuHfFhmEEtqVIVoIHZoqHIvOzwAF1Y9oJIQUNl++IgJf0l1aNg1g==
X-Received: by 2002:a05:6870:b90a:b0:1ea:4dc8:a17 with SMTP id gx10-20020a056870b90a00b001ea4dc80a17mr13544728oab.28.1698172970721;
        Tue, 24 Oct 2023 11:42:50 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id sc17-20020a056871221100b001e0fd4c9b9asm2303077oab.6.2023.10.24.11.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 11:42:50 -0700 (PDT)
Received: (nullmailer pid 263045 invoked by uid 1000);
        Tue, 24 Oct 2023 18:42:48 -0000
Date:   Tue, 24 Oct 2023 13:42:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     Georgi Djakov <quic_c_gdjako@quicinc.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        devicetree@vger.kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_cgoldswo@quicinc.com,
        quic_sukadev@quicinc.com, quic_pdaly@quicinc.com,
        quic_sudaraja@quicinc.com, djakov@kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: iommu: Add Translation Buffer Unit
 bindings
Message-ID: <20231024184248.GA252155-robh@kernel.org>
References: <20231019021923.13939-1-quic_c_gdjako@quicinc.com>
 <20231019021923.13939-2-quic_c_gdjako@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019021923.13939-2-quic_c_gdjako@quicinc.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 07:19:18PM -0700, Georgi Djakov wrote:
> The "apps_smmu" on the Qualcomm sdm845 platform is an implementation
> of the ARM SMMU-500, that consists of a single TCU (Translation Control
> Unit) and multiple TBUs (Translation Buffer Units). The TCU is already
> being described in the ARM SMMU DT schema. Add also bindings for the
> TBUs so that we can describe their properties.

Arm SMMU-500 is an implementation, too. Is QCom's a modified 
implementation or you are just the first to want to control TBU 
resources?

You need to split this into what could be any SMMU-500 implementation 
and what is truly QCom specific (i.e. modified). Unlike some licensed IP 
that's a free-for-all on DT resources, Arm IP has public specs so we 
don't have to guess.

> In this DT schema, the TBUs are modelled as a child devices of the TCU
> and each of them is described with it's own resources such as clocks,
> power domains, interconnects etc.
> 
> Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
> ---
>  .../devicetree/bindings/iommu/arm,smmu.yaml   | 13 ++++
>  .../bindings/iommu/qcom,qsmmuv500-tbu.yaml    | 67 +++++++++++++++++++
>  2 files changed, 80 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iommu/qcom,qsmmuv500-tbu.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> index cf29ab10501c..afc323b4bbc5 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> @@ -230,6 +230,19 @@ properties:
>        enabled for any given device.
>      $ref: /schemas/types.yaml#/definitions/phandle
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

Generic SMMU binding includes something QCom specific. That's not right.


> +    description: The SMMU may include Translation Buffer Units (TBU) as subnodes
> +
>  required:
>    - compatible
>    - reg
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
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,qsmmuv500-tbu
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
> +    tbu@150e1000 {
> +        compatible = "qcom,qsmmuv500-tbu";
> +        reg = <0x150e1000 0x1000>;
> +        reg-names = "base";
> +        clocks = <&gcc GCC_AGGRE_NOC_PCIE_TBU_CLK>;
> +        power-domains = <&gcc HLOS1_VOTE_AGGRE_NOC_MMU_PCIE_TBU_GDSC>;
> +        interconnects = <&system_noc MASTER_GNOC_SNOC 0 &config_noc SLAVE_IMEM_CFG 0>;
> +        qcom,stream-id-range = <0x1c00 0x400>;
> +    };
> +
> +...
