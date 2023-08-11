Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2217797C9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 21:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236842AbjHKT3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 15:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236820AbjHKT3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 15:29:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDE23580;
        Fri, 11 Aug 2023 12:29:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15A066797B;
        Fri, 11 Aug 2023 19:29:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD39DC433C7;
        Fri, 11 Aug 2023 19:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691782180;
        bh=C3b8Pt48FA8HS2uxnTsnGzXHudg/cGiI78XFQzwaeM4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KAddTeAfG/R6O6bJmcsFRrSW3LAtKFDFanW6OTR8/MQtYcdGIizSJnz6d8S+5a5m6
         E8+qkuXUzOk6YeopDMTAu/UwR0Fc6Ivv3O/Bt1dO44dLqM0ZsMqk+cI1SR+Ad8zW4U
         lDBhZTcXl3OEzNopgRbgMm9cTDa2/3I2m/JcQu1/EsWkOg8F1uqxaaC7SarZhMHaGY
         Yhf5NKJDNsjfZeQP8JjxN/SsWWX2yj/TIfp2gafQHXtrE0RW3FeZOSPq1tixiqR2xq
         LNRbJ8qf6prUqkcat3iK7zDHgtuVDcHYS/6SU65oM0QGSqhQIRXfbzyNTAiyD0KWB4
         WpQ/qTE8g/Rpg==
Received: (nullmailer pid 3992613 invoked by uid 1000);
        Fri, 11 Aug 2023 19:29:38 -0000
Date:   Fri, 11 Aug 2023 13:29:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Raphael Gallais-Pou <rgallaispou@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pwm: st: convert sti-pwm to DT schema
Message-ID: <20230811192938.GA3990758-robh@kernel.org>
References: <20230801220559.32530-1-rgallaispou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801220559.32530-1-rgallaispou@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 12:05:59AM +0200, Raphael Gallais-Pou wrote:
> Converts st,sti-pwm binding to DT schema format
> 
> Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
> ---
>  .../devicetree/bindings/pwm/pwm-st.txt        | 43 -----------
>  .../devicetree/bindings/pwm/st,sti-pwm.yaml   | 74 +++++++++++++++++++
>  2 files changed, 74 insertions(+), 43 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-st.txt
>  create mode 100644 Documentation/devicetree/bindings/pwm/st,sti-pwm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-st.txt b/Documentation/devicetree/bindings/pwm/pwm-st.txt
> deleted file mode 100644
> index 19fce774cafa..000000000000
> --- a/Documentation/devicetree/bindings/pwm/pwm-st.txt
> +++ /dev/null
> @@ -1,43 +0,0 @@
> -STMicroelectronics PWM driver bindings
> ---------------------------------------
> -
> -Required parameters:
> -- compatible :		"st,pwm"
> -- #pwm-cells : 		Number of cells used to specify a PWM. First cell
> -			specifies the per-chip index of the PWM to use and the
> -			second cell is the period in nanoseconds - fixed to 2
> -			for STiH41x.
> -- reg :			Physical base address and length of the controller's
> -			registers.
> -- pinctrl-names: 	Set to "default".
> -- pinctrl-0: 		List of phandles pointing to pin configuration nodes
> -			for PWM module.
> -			For Pinctrl properties, please refer to [1].
> -- clock-names: 		Valid entries are "pwm" and/or "capture".
> -- clocks: 		phandle of the clock used by the PWM module.
> -			For Clk properties, please refer to [2].
> -- interrupts:		IRQ for the Capture device
> -
> -Optional properties:
> -- st,pwm-num-chan:	Number of available PWM channels.  Default is 0.
> -- st,capture-num-chan:	Number of available Capture channels.  Default is 0.
> -
> -[1] Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
> -[2] Documentation/devicetree/bindings/clock/clock-bindings.txt
> -
> -Example:
> -
> -pwm1: pwm@fe510000 {
> -	compatible = "st,pwm";
> -	reg = <0xfe510000 0x68>;
> -	#pwm-cells = <2>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pinctrl_pwm1_chan0_default
> -		     &pinctrl_pwm1_chan1_default
> -		     &pinctrl_pwm1_chan2_default
> -		     &pinctrl_pwm1_chan3_default>;
> -	clocks = <&clk_sysin>;
> -	clock-names = "pwm";
> -	st,pwm-num-chan = <4>;
> -	st,capture-num-chan = <2>;
> -};
> diff --git a/Documentation/devicetree/bindings/pwm/st,sti-pwm.yaml b/Documentation/devicetree/bindings/pwm/st,sti-pwm.yaml
> new file mode 100644
> index 000000000000..8a7833e9c10c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/st,sti-pwm.yaml
> @@ -0,0 +1,74 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/st,sti-pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: STMicroelectronics STi PWM controller
> +
> +maintainers:
> +  - Patrice Chotard <patrice.chotard@foss.st.com>
> +
> +allOf:
> +  - $ref: pwm.yaml#
> +
> +properties:
> +  compatible:
> +    const: st,sti-pwm
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  pinctrl-names:
> +    const: default
> +
> +  pinctrl-0:
> +    description: Configuration for the default state.
> +
> +  clock-names:
> +    const: pwm
> +
> +  clocks:
> +    $ref: "/schemas/types.yaml#/definitions/phandle"

Drop quotes

> +
> +  st,pwm-num-chan:
> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    description: Number of available PWM channels.

Constraints?

> +
> +  st,capture-num-chan:
> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    description: Number of available Capture channels.

Constraints?

> +
> +  "#pwm-cells":
> +    const: 2
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clock-names
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    pwm1: pwm@9510000 {
> +        compatible = "st,sti-pwm";
> +        #pwm-cells = <2>;
> +        reg = <0x9510000 0x68>;
> +        interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&pinctrl_pwm1_chan0_default
> +                 &pinctrl_pwm1_chan1_default
> +                 &pinctrl_pwm1_chan2_default
> +                 &pinctrl_pwm1_chan3_default>;
> +        clock-names = "pwm";
> +        clocks = <&clk_sysin>;
> +        st,pwm-num-chan = <4>;
> +    };
> +...
> -- 
> 2.41.0
> 
