Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55157767074
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 17:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237135AbjG1PYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 11:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237343AbjG1PYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 11:24:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 17FE94487
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 08:24:01 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E45BF2F4;
        Fri, 28 Jul 2023 08:24:43 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.89.82])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 54A1C3F67D;
        Fri, 28 Jul 2023 08:23:59 -0700 (PDT)
Date:   Fri, 28 Jul 2023 16:23:56 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Gowthami Thiagarajan <gthiagarajan@marvell.com>
Cc:     will@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, sgoutham@marvell.com,
        bbhushan2@marvell.com, gcherian@marvell.com, lcherian@marvell.com
Subject: Re: [PATCH 2/6] dt-bindings: perf: marvell: Add YAML schemas for
 Marvell PEM pmu
Message-ID: <ZMPdjIUJqJwcX22a@FVFF77S0Q05N>
References: <20230630120351.1143773-1-gthiagarajan@marvell.com>
 <20230630120351.1143773-3-gthiagarajan@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630120351.1143773-3-gthiagarajan@marvell.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 05:33:47PM +0530, Gowthami Thiagarajan wrote:
> Add device tree bindings for Marvell PEM performance monitor unit
> 
> Signed-off-by: Gowthami Thiagarajan <gthiagarajan@marvell.com>
> Signed-off-by: Linu Cherian <lcherian@marvell.com>

As Krzysztof mentioned, the device tree list (and the DT bindings maintainers)
haven't been Cc'd, so this cannot be acked.

When resending, please CC the devicetree list, Rob, and Conor:

[mark@lakrids:~/src/linux]% ./scripts/get_maintainer.pl -f Documentation/devicetree/bindings/perf
Will Deacon <will@kernel.org> (maintainer:ARM PMU PROFILING AND DEBUGGING)
Mark Rutland <mark.rutland@arm.com> (maintainer:ARM PMU PROFILING AND DEBUGGING)
Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
Conor Dooley <conor+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
linux-arm-kernel@lists.infradead.org (moderated list:ARM PMU PROFILING AND DEBUGGING)
devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
linux-kernel@vger.kernel.org (open list)

Thanks,
Mark.

> ---
>  .../bindings/perf/marvell-odyssey-pem.yaml    | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/perf/marvell-odyssey-pem.yaml
> 
> diff --git a/Documentation/devicetree/bindings/perf/marvell-odyssey-pem.yaml b/Documentation/devicetree/bindings/perf/marvell-odyssey-pem.yaml
> new file mode 100644
> index 000000000000..6af201fbccd8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/perf/marvell-odyssey-pem.yaml
> @@ -0,0 +1,38 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/perf/marvell-odyssey-pem.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Marvell Odyssey PCIe interface performance monitor
> +
> +maintainers:
> +  - Linu Cherian <lcherian@marvell.com>
> +  - Gowthami Thiagarajan <gthiagarajan@marvell.com>
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - marvell,pem-pmu
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    bus {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        pmu@8e0000005000 {
> +            compatible = "marvell,pem-pmu";
> +            reg = <0x8E00 0x00005000 0x0 0x3000>;
> +        };
> +    };
> -- 
> 2.25.1
> 
> 
