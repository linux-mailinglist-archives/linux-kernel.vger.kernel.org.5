Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4003E7B55E3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 17:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237837AbjJBOge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 10:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237799AbjJBOg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 10:36:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86B2AD
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 07:36:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 114F3C433C7;
        Mon,  2 Oct 2023 14:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696257381;
        bh=N0bjWFh/ivsmoCYQtXEL5H33a73c76bfBhkj9oFwP9U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rXmIWfER8Fxc/ipUxtpCtDviSFoTG9oiaZjA5WmwM+EiknGI/Gq9SUqummvXw0G0X
         QqAgoHdb2pHvwo8MbTxAF3ag2DJyW8fnZtXjV9hlYuZJ9BmW735ny3ngZLhgkdBj4L
         wqdytAXfpe9d1KfWejOaN1xrhs2cO3mhRH2TGI65AaYp6caL0Gu653xFHj0IOvJzG6
         2JdIwBgWlumVgcSXJZZYFfl6i/WXeQSdGkZsf+SnAwZ3S6xYIRnAMAGQeMxkReWO1X
         9qgj2HstuQpxJniKTVrZnBaU3F8FnkNLyxwd9UBD9TGQC/JX5HWSmmdoFMgjTZK7V7
         UeGSe4NGjC8/A==
Received: (nullmailer pid 1674615 invoked by uid 1000);
        Mon, 02 Oct 2023 14:36:19 -0000
Date:   Mon, 2 Oct 2023 09:36:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: phy: Convert PXA1928 USB/HSIC PHY to DT
 schema
Message-ID: <20231002143619.GA1651295-robh@kernel.org>
References: <20231001-pxa1928-usb-yaml-v1-1-9309a8c0c03f@skole.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231001-pxa1928-usb-yaml-v1-1-9309a8c0c03f@skole.hr>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 01, 2023 at 03:05:43PM +0200, Duje Mihanović wrote:
> Convert the binding for the Marvell PXA1928 USB and HSIC PHYs from TXT
> to DT schema.
> 
> Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
> ---
>  .../bindings/phy/marvell,pxa1928-hsic-phy.yaml     | 37 +++++++++++++++++
>  .../bindings/phy/marvell,pxa1928-usb-phy.yaml      | 46 ++++++++++++++++++++++
>  .../devicetree/bindings/phy/pxa1928-usb-phy.txt    | 18 ---------
>  3 files changed, 83 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/marvell,pxa1928-hsic-phy.yaml b/Documentation/devicetree/bindings/phy/marvell,pxa1928-hsic-phy.yaml
> new file mode 100644
> index 000000000000..a477afd11329
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/marvell,pxa1928-hsic-phy.yaml
> @@ -0,0 +1,37 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/marvell,pxa1928-hsic-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Marvell PXA1928 HSIC PHY
> +
> +maintainers:
> +  - devicetree@vger.kernel.org

No, should be someone with hardware or familar with it. I added this, 
but no longer have h/w or documentation. IMO, it should probably be 
removed.

The schemas are the same, so they could just be 1 document.

> +
> +properties:
> +  $nodename:
> +    pattern: '^phy@[a-f0-9]+$'
> +
> +  compatible:
> +    const: "marvell,pxa1928-hsic-phy"

Don't need quotes.

> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  '#phy-cells':
> +    const: 0
> +
> +  resets:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - '#phy-cells'
> +
> +additionalProperties: false
> diff --git a/Documentation/devicetree/bindings/phy/marvell,pxa1928-usb-phy.yaml b/Documentation/devicetree/bindings/phy/marvell,pxa1928-usb-phy.yaml
> new file mode 100644
> index 000000000000..4ae9201767ed
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/marvell,pxa1928-usb-phy.yaml
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/marvell,pxa1928-usb-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Marvell PXA1928 USB PHY
> +
> +maintainers:
> +  - devicetree@vger.kernel.org
> +
> +properties:
> +  $nodename:
> +    pattern: '^phy@[a-f0-9]+$'
> +
> +  compatible:
> +    const: "marvell,pxa1928-usb-phy"
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  '#phy-cells':
> +    const: 0
> +
> +  resets:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - '#phy-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    phy@7000 {
> +      compatible = "marvell,pxa1928-usb-phy";
> +      reg = <0x7000 0xe0>;
> +      clocks = <&apmu_clocks PXA1928_CLK_USB>;
> +      #phy-cells = <0>;
> +    };
> diff --git a/Documentation/devicetree/bindings/phy/pxa1928-usb-phy.txt b/Documentation/devicetree/bindings/phy/pxa1928-usb-phy.txt
> deleted file mode 100644
> index da94426aa694..000000000000
> --- a/Documentation/devicetree/bindings/phy/pxa1928-usb-phy.txt
> +++ /dev/null
> @@ -1,18 +0,0 @@
> -* Marvell PXA1928 USB and HSIC PHYs
> -
> -Required properties:
> -- compatible: "marvell,pxa1928-usb-phy" or "marvell,pxa1928-hsic-phy"
> -- reg: base address and length of the registers
> -- clocks - A single clock. From common clock binding.
> -- #phys-cells: should be 0. From common phy binding.
> -- resets: reference to the reset controller
> -
> -Example:
> -
> -	usbphy: phy@7000 {
> -		compatible = "marvell,pxa1928-usb-phy";
> -		reg = <0x7000 0xe0>;
> -		clocks = <&apmu_clocks PXA1928_CLK_USB>;
> -		#phy-cells = <0>;
> -	};
> -
> 
> ---
> base-commit: 6465e260f48790807eef06b583b38ca9789b6072
> change-id: 20231001-pxa1928-usb-yaml-809564082241
> 
> Best regards,
> -- 
> Duje Mihanović <duje.mihanovic@skole.hr>
> 
> 
