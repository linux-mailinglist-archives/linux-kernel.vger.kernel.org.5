Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04253763CA9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 18:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjGZQkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 12:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjGZQkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 12:40:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1C926AE;
        Wed, 26 Jul 2023 09:40:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03B3A61B68;
        Wed, 26 Jul 2023 16:40:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F047C433C9;
        Wed, 26 Jul 2023 16:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690389641;
        bh=xi5pkQ9Tg9na29dO/s5rHGt9JpISIfvqy22VjzX/1gA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QdpTr3VBWsh7BRv21+96+VTltIOXif1+4R+Ybp42rMF7CLq9VJfCyYHhXoZHNiaB4
         GXBVIbocKFgsA1eq6WnRYIzjweWSxxYeshz7FyDvOZxPqoLAKv33YEBFS968fVdTZP
         NhF1iCRQdoEVRp3pvCDLTAphmkMm83oOfWsky90NRQHcCDXooaxeylXqP40n3AlpOA
         qaUa3+EYQlkfdLjuNqrPNpjp0pJaY8cU1WYXP9kynym9ovQjD6wxhsMPOSmz6TrMBc
         ZCsaJmWFxb82lt34u++ew2HUAUbaT99b64iIqI8pNK5+x/Mbg+dPQOwwdBEd8+NIb6
         1DquZ87IVdCeA==
Received: (nullmailer pid 1562148 invoked by uid 1000);
        Wed, 26 Jul 2023 16:40:39 -0000
Date:   Wed, 26 Jul 2023 10:40:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Komal Bajaj <quic_kbajaj@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: nvmem: sec-qfprom: Add bindings for
 secure qfprom
Message-ID: <20230726164039.GA1558299-robh@kernel.org>
References: <20230724083849.8277-1-quic_kbajaj@quicinc.com>
 <20230724083849.8277-2-quic_kbajaj@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724083849.8277-2-quic_kbajaj@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 02:08:48PM +0530, Komal Bajaj wrote:
> This patch adds bindings for secure qfprom found in QCOM SOCs.
> Secure QFPROM driver is based on simple nvmem framework.
> 
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> ---
>  .../bindings/nvmem/qcom,sec-qfprom.yaml       | 58 +++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/qcom,sec-qfprom.yaml
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/qcom,sec-qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,sec-qfprom.yaml
> new file mode 100644
> index 000000000000..1425ced36fdf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/qcom,sec-qfprom.yaml
> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/nvmem/qcom,sec-qfprom.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Technologies Inc, Secure QFPROM Efuse
> +
> +maintainers:
> +  - Komal Bajaj <quic_kbajaj@quicinc.com>
> +
> +description: |

Don't need '|'

> +  For some of the Qualcomm SoC's, it is possible that
> +  the qfprom region is protected from non-secure access.
> +  In such situations, linux will have to use secure calls

s/linux/the OS/

> +  to read the region.

Wrap lines at 80

The wording for this is strange. Only sometimes for this binding do 
secure calls have to be used? If you are using secure calls, does that 
mean the 'reg' address is not directly accessible.

> +
> +allOf:
> +  - $ref: nvmem.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - qcom,qdu1000-sec-qfprom
> +      - const: qcom,sec-qfprom
> +
> +  reg:
> +    items:
> +      - description: The secure qfprom corrected region.
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,gcc-sc7180.h>
> +
> +    soc {
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +
> +      efuse@221c8000 {
> +        compatible = "qcom,qdu1000-sec-qfprom", "qcom,sec-qfprom";
> +        reg = <0 0x221c8000 0 0x1000>;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +
> +        multi_chan_ddr: multi-chan-ddr@12b {
> +          reg = <0x12b 0x1>;
> +          bits = <0 2>;
> +        };
> +      };
> +    };
> +
> --
> 2.40.1
> 
