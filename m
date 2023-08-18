Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1716B781045
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 18:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378602AbjHRQYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 12:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378604AbjHRQYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 12:24:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB9930F1;
        Fri, 18 Aug 2023 09:24:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0CE4161BAF;
        Fri, 18 Aug 2023 16:24:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C03A0C433C7;
        Fri, 18 Aug 2023 16:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692375874;
        bh=c8zN6/cDpi2/K8Iq9Z859/6w6tjD9P5FH9hjNWMoWuU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ckKvDLY1C9MAW25eizZ0moFB8jVKbU7eqKX9vU0zvdZ9FleHGYv7dxEplLjyDq24y
         VE0nqgjVDtwsxoW911otfHi4x/bZSEYYCFU/ziFiMpnhOLOgX+oDigDjrPNeEwQhoZ
         zlCu7bznHzzgkk5qY6IuiCIKbhXXxmmHrTRRlrzBtjGsrXqxpCpVVMrt0e9djz7MgR
         nYxQnZo2Km1s8SZXdgRqIhN7tQjdYPBuhfFmMeCHbGqtV69Dyju8duPb5zGSbhMXbK
         tC4qc8TxB8lJ1scKC7cmzoKUDJDbIoCn9lB8kFW5LManMH/8o0SdLGbrbXI+tcrrnP
         pSqtMUA4bR9ow==
Received: (nullmailer pid 119460 invoked by uid 1000);
        Fri, 18 Aug 2023 16:24:32 -0000
Date:   Fri, 18 Aug 2023 11:24:32 -0500
From:   Rob Herring <robh@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     giometti@enneenne.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Fabio Estevam <festevam@denx.de>
Subject: Re: [PATCH] dt-bindings: pps: pps-gpio: Convert to yaml
Message-ID: <20230818162432.GA118441-robh@kernel.org>
References: <20230809110812.2058428-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809110812.2058428-1-festevam@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 08:08:12AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> Convert from pps-gpio.txt to pps-gpio.yaml to allow schema validation.
> 
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---
>  .../devicetree/bindings/pps/pps-gpio.txt      | 30 ------------
>  .../devicetree/bindings/pps/pps-gpio.yaml     | 46 +++++++++++++++++++
>  2 files changed, 46 insertions(+), 30 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pps/pps-gpio.txt
>  create mode 100644 Documentation/devicetree/bindings/pps/pps-gpio.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pps/pps-gpio.txt b/Documentation/devicetree/bindings/pps/pps-gpio.txt
> deleted file mode 100644
> index 9012a2a02e14..000000000000
> --- a/Documentation/devicetree/bindings/pps/pps-gpio.txt
> +++ /dev/null
> @@ -1,30 +0,0 @@
> -Device-Tree Bindings for a PPS Signal on GPIO
> -
> -These properties describe a PPS (pulse-per-second) signal connected to
> -a GPIO pin.
> -
> -Required properties:
> -- compatible: should be "pps-gpio"
> -- gpios: one PPS GPIO in the format described by ../gpio/gpio.txt
> -
> -Additional required properties for the PPS ECHO functionality:
> -- echo-gpios: one PPS ECHO GPIO in the format described by ../gpio/gpio.txt
> -- echo-active-ms: duration in ms of the active portion of the echo pulse
> -
> -Optional properties:
> -- assert-falling-edge: when present, assert is indicated by a falling edge
> -                       (instead of by a rising edge)
> -
> -Example:
> -	pps {
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pinctrl_pps>;
> -
> -		gpios = <&gpio1 26 GPIO_ACTIVE_HIGH>;
> -		assert-falling-edge;
> -
> -		echo-gpios = <&gpio1 27 GPIO_ACTIVE_HIGH>;
> -		echo-active-ms = <100>;
> -
> -		compatible = "pps-gpio";
> -	};
> diff --git a/Documentation/devicetree/bindings/pps/pps-gpio.yaml b/Documentation/devicetree/bindings/pps/pps-gpio.yaml
> new file mode 100644
> index 000000000000..801fd2720080
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pps/pps-gpio.yaml
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pps/pps-gpio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: PPS Signal via GPIO
> +
> +maintainers:
> +  - Fabio Estevam <festevam@gmail.com>
> +
> +properties:
> +  compatible:
> +    const: pps-gpio
> +
> +  gpios:
> +    description: The GPIO that provides the PPS signal.

maxItems: 1

> +
> +  echo-gpios:
> +    description: The GPIO that provides the PPS ECHO signal.

maxItems: 1

> +
> +  echo-active-ms:
> +    description: Duration in ms of the active portion of the echo pulse.
> +
> +  assert-falling-edge:
> +    description: Indicates a falling edge assert, when present. Rising edge if absent.

type: boolean

> +
> +required:
> +  - compatible
> +  - gpios
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +      #include <dt-bindings/gpio/gpio.h>
> +
> +      pps {
> +          compatible = "pps-gpio";
> +          pinctrl-names = "default";
> +          pinctrl-0 = <&pinctrl_pps>;
> +          gpios = <&gpio1 26 GPIO_ACTIVE_HIGH>;
> +          assert-falling-edge;
> +          echo-gpios = <&gpio1 27 GPIO_ACTIVE_HIGH>;
> +          echo-active-ms = <100>;
> +      };
> -- 
> 2.34.1
> 
