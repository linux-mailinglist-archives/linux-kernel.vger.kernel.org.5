Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B3D7BFD34
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 15:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbjJJNV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 09:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbjJJNVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 09:21:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3989991;
        Tue, 10 Oct 2023 06:21:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E8C8C433C7;
        Tue, 10 Oct 2023 13:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696944113;
        bh=CgSS8Lt/YFvUeBBHoPK36uAJxFiiRquBNnr5VmqVfMQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hijm2yozjMDOmRdLMLGdqw/D23+voz/gLKCJ1kdZdcELcII+FlkURluz8un56uk95
         WvFD362ukK7KpNIl7GWnKnNWDam6vYT9S+owWZjCqkI4RYOPdtDjhZdnAO+6LYK2oy
         NYJY8LQtj1L1l+w7e7bfji474lIQ9EXIn4LOaEW/eQbzQfBQVn60k32Pdcn+7qAQlX
         NfW0iesmLNMC0e5EMItHAbJcyr7c/zaAuGDRZNoBWRo+jYkGnqnMEyiBrTn1qx+OQY
         6hGROv3vYL7SFa8SWiSKiL0Q0g5XdTGYmcUyZyjZm8Py+ZkUlvxNMTGQDi7pZR93NB
         ls2v8+WQvhy3g==
Received: (nullmailer pid 620779 invoked by uid 1000);
        Tue, 10 Oct 2023 13:21:51 -0000
Date:   Tue, 10 Oct 2023 08:21:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Chuan Liu <chuan.liu@amlogic.com>
Subject: Re: [PATCH V2 1/4] dt-bindings: clock: add Amlogic C3 PLL clock
 controller bindings
Message-ID: <20231010132151.GA557938-robh@kernel.org>
References: <20231010062917.3624223-1-xianwei.zhao@amlogic.com>
 <20231010062917.3624223-2-xianwei.zhao@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010062917.3624223-2-xianwei.zhao@amlogic.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 02:29:14PM +0800, Xianwei Zhao wrote:
> Add the C3 PLL clock controller dt-bindings for Amlogic C3 SoC family
> 
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
> V1 -> V2: Fix errors when check dtbinding use "make dt_binding_check"

Your patches aren't bisectable. It's fine if you want to combine patch 1 
and 2 into 1 patch. Or just use the raw numbers here instead of the 
header.

> ---
>  .../bindings/clock/amlogic,c3-pll-clkc.yaml   | 59 +++++++++++++++++++
>  .../dt-bindings/clock/amlogic,c3-pll-clkc.h   | 42 +++++++++++++
>  2 files changed, 101 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml
>  create mode 100644 include/dt-bindings/clock/amlogic,c3-pll-clkc.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml
> new file mode 100644
> index 000000000000..a646992917b7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2022-2023 Amlogic, Inc. All rights reserved
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/amlogic,c3-pll-clkc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Amlogic C3 serials PLL Clock Controller

s/serials/Serials/

> +
> +maintainers:
> +  - Chuan Liu <chuan.liu@amlogic.com>
> +
> +properties:
> +  compatible:
> +    const: amlogic,c3-pll-clkc
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 1
> +    items:
> +      - description: input pll_in
> +      - description: input mclk_pll_in
> +
> +  clock-names:
> +    minItems: 1
> +    items:
> +      - const: pll_in
> +      - const: mclk_pll_in
> +
> +  "#clock-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - "#clock-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/amlogic,c3-peripherals-clkc.h>
> +    apb {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        clkc_pll: clock-controller@8000 {

Drop unused labels.

> +          compatible = "amlogic,c3-pll-clkc";

Your indentation is not consistent.

> +          reg = <0x0 0x8000 0x0 0x1a4>;
> +          clocks = <&clkc_periphs CLKID_PLL_IN>,
> +                   <&clkc_periphs CLKID_MCLK_PLL_IN>;
> +          clock-names = "pll_in", "mclk_pll_in";
> +          #clock-cells = <1>;
> +        };
> +    };
> diff --git a/include/dt-bindings/clock/amlogic,c3-pll-clkc.h b/include/dt-bindings/clock/amlogic,c3-pll-clkc.h
> new file mode 100644
> index 000000000000..aa731e8fae29
> --- /dev/null
> +++ b/include/dt-bindings/clock/amlogic,c3-pll-clkc.h
> @@ -0,0 +1,42 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
> +/*
> + * Copyright (c) 2023 Amlogic, Inc. All rights reserved.
> + * Author: Chuan Liu <chuan.liu@amlogic.com>
> + */
> +
> +#ifndef _DT_BINDINGS_CLOCK_AMLOGIC_C3_PLL_CLKC_H
> +#define _DT_BINDINGS_CLOCK_AMLOGIC_C3_PLL_CLKC_H
> +
> +#define CLKID_FIXED_PLL_DCO			0
> +#define CLKID_FIXED_PLL				1
> +#define CLKID_FCLK_DIV40_DIV			2
> +#define CLKID_FCLK_DIV40			3
> +#define CLKID_FCLK_DIV2_DIV			4
> +#define CLKID_FCLK_DIV2				5
> +#define CLKID_FCLK_DIV2P5_DIV			6
> +#define CLKID_FCLK_DIV2P5			7
> +#define CLKID_FCLK_DIV3_DIV			8
> +#define CLKID_FCLK_DIV3				9
> +#define CLKID_FCLK_DIV4_DIV			10
> +#define CLKID_FCLK_DIV4				11
> +#define CLKID_FCLK_DIV5_DIV			12
> +#define CLKID_FCLK_DIV5				13
> +#define CLKID_FCLK_DIV7_DIV			14
> +#define CLKID_FCLK_DIV7				15
> +#define CLKID_GP0_PLL_DCO			16
> +#define CLKID_GP0_PLL				17
> +#define CLKID_HIFI_PLL_DCO			18
> +#define CLKID_HIFI_PLL				19
> +#define CLKID_MCLK_PLL_DCO			20
> +#define CLKID_MCLK_PLL				21
> +#define CLKID_MCLK_PLL_CLK			22
> +#define CLKID_MCLK0_SEL				23
> +#define CLKID_MCLK0_SEL_OUT			24
> +#define CLKID_MCLK0_DIV				25
> +#define CLKID_MCLK0				26
> +#define CLKID_MCLK1_SEL				27
> +#define CLKID_MCLK1_SEL_OUT			28
> +#define CLKID_MCLK1_DIV				29
> +#define CLKID_MCLK1				30
> +
> +#endif  /* _DT_BINDINGS_CLOCK_AMLOGIC_C3_PLL_CLKC_H */
> 
> base-commit: 57b55c76aaf1ba50ecc6dcee5cd6843dc4d85239
> -- 
> 2.37.1
> 
