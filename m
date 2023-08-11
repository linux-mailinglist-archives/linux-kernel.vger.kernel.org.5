Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3817E77950D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 18:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbjHKQsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 12:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbjHKQsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 12:48:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8458530DC;
        Fri, 11 Aug 2023 09:48:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2403A676DF;
        Fri, 11 Aug 2023 16:48:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E8DEC433C7;
        Fri, 11 Aug 2023 16:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691772496;
        bh=KzFHKr9MAG4cRxqw6+oOVqIj3TjCZi/Mt8+ddzP0RN4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lcFEWmORaSkaOsCLUN45RHKj/fkSQh4On/A8jl0bo7IWR7uG/0Ycm7+xHTT5A17MV
         9wbqAovUecnii/ugE3DCeRAP3yU3WJqZZe7iC28WiRoIAOX7yGTV2OjqLgb2d0m0DI
         D+XncoQjvAJJTrOJyhWfO20qA2iKgr/wbopfKRIo1oVFpPmIpf8kheNz7p4urMdoqO
         fCvwqIIg3fbPfciRRCKfLamU9fqtLuOaTTxUnipTt0rJdrqYM4WJytFbGrkaErisDW
         ODChx+zHHNnnUPTfe00HY1nazP3zyDwj1nc07ILA+y2GpFLmy3kwXj79eIk9sIvPsR
         Uq3fyNHTetwEg==
Received: (nullmailer pid 3592093 invoked by uid 1000);
        Fri, 11 Aug 2023 16:48:14 -0000
Date:   Fri, 11 Aug 2023 10:48:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/7] dt-bindings: interconnect: qcom: Introduce
 qcom,rpm-common
Message-ID: <20230811164814.GA3587580-robh@kernel.org>
References: <20230721-topic-icc_bindings-v2-0-e33d5acbf3bd@linaro.org>
 <20230721-topic-icc_bindings-v2-1-e33d5acbf3bd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721-topic-icc_bindings-v2-1-e33d5acbf3bd@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 04:06:27PM +0200, Konrad Dybcio wrote:
> The current RPM interconnect bindings are messy. Start cleaning them
> up with a common include.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../bindings/interconnect/qcom,qcm2290.yaml        | 18 +++++++-------
>  .../bindings/interconnect/qcom,rpm-common.yaml     | 28 ++++++++++++++++++++++
>  2 files changed, 36 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,qcm2290.yaml b/Documentation/devicetree/bindings/interconnect/qcom,qcm2290.yaml
> index f65a2fe846de..df89f390a9b0 100644
> --- a/Documentation/devicetree/bindings/interconnect/qcom,qcm2290.yaml
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,qcm2290.yaml
> @@ -13,6 +13,9 @@ description: |
>    The Qualcomm QCM2290 interconnect providers support adjusting the
>    bandwidth requirements between the various NoC fabrics.
>  
> +allOf:
> +  - $ref: qcom,rpm-common.yaml#
> +
>  properties:
>    reg:
>      maxItems: 1
> @@ -23,9 +26,6 @@ properties:
>        - qcom,qcm2290-cnoc
>        - qcom,qcm2290-snoc
>  
> -  '#interconnect-cells':
> -    const: 1
> -
>    clock-names:
>      items:
>        - const: bus
> @@ -44,6 +44,9 @@ patternProperties:
>        The interconnect providers do not have a separate QoS register space,
>        but share parent's space.
>  
> +    allOf:
> +      - $ref: qcom,rpm-common.yaml#
> +
>      properties:
>        compatible:
>          enum:
> @@ -51,9 +54,6 @@ patternProperties:
>            - qcom,qcm2290-mmrt-virt
>            - qcom,qcm2290-mmnrt-virt
>  
> -      '#interconnect-cells':
> -        const: 1
> -
>        clock-names:
>          items:
>            - const: bus
> @@ -66,20 +66,18 @@ patternProperties:
>  
>      required:
>        - compatible
> -      - '#interconnect-cells'
>        - clock-names
>        - clocks
>  
> -    additionalProperties: false
> +    unevaluatedProperties: false
>  
>  required:
>    - compatible
>    - reg
> -  - '#interconnect-cells'
>    - clock-names
>    - clocks
>  
> -additionalProperties: false
> +unevaluatedProperties: false
>  
>  examples:
>    - |
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpm-common.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpm-common.yaml
> new file mode 100644
> index 000000000000..1ea52b091609
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,rpm-common.yaml
> @@ -0,0 +1,28 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interconnect/qcom,rpm-common.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm RPMh Network-On-Chip Interconnect
> +
> +maintainers:
> +  - Konrad Dybcio <konradybcio@kernel.org>
> +
> +description:
> +  RPM interconnect providers support for managing system bandwidth requirements
> +  through manual requests based on either predefined values or as indicated by
> +  the bus monitor hardware. Each provider node represents a NoC bus master,
> +  driven by a dedicated clock source.
> +
> +properties:
> +  '#interconnect-cells':
> +    oneOf:
> +      - const: 2
> +      - const: 1
> +        deprecated: true

I think this is kind of questionable for a single property. Do you 
plan to add more properties here? Also, if you add a new user of this 
schema, then it's going to allow the deprecated case when it could just 
start with 2 only.

Rob
