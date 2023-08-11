Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F5B7797C1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 21:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236736AbjHKT1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 15:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236088AbjHKT1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 15:27:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D0330DB;
        Fri, 11 Aug 2023 12:27:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4F3567963;
        Fri, 11 Aug 2023 19:27:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A385C433C8;
        Fri, 11 Aug 2023 19:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691782069;
        bh=DobAbm1IHae1StSaGpB4TPZBLLSgCPyIvioYYdeqsmU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VpwXSIe7nulyV9vgDfTveSjjWq2qTS0ZtuZ/N1hA2TEiXx0bAPBWvKm6At3Iy4PVC
         WnmhTBqNo6ittuaRwmcBriqG8eUTPMng2xDoYwYKO17NCphwFLHVjlU67HvoQufPJy
         OxYYpCHj1bNQWT2eFZBu1Nq0pDY00uI+snsKZHhQWGKbcHxzPmUBSSClXjMj/82ubN
         CUOjckWF+rNK16TEOXNeZxngfxM6UrA1ocymhZlo6qDLpeusQFekt1eKzfD6Kiegyh
         n7+0oIhDqc6GxhASIj150LhCeu6ALNk6Du4F2EDLJl/ElPM6PcY0g+MN53v67+rQQE
         6EqmuqNfAmu2Q==
Received: (nullmailer pid 3990588 invoked by uid 1000);
        Fri, 11 Aug 2023 19:27:47 -0000
Date:   Fri, 11 Aug 2023 13:27:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Raphael Gallais-Pou <rgallaispou@gmail.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?iso-8859-1?Q?Rapha=EBl?= Gallais-Pou 
        <raphael.gallais.pou@gmail.com>
Subject: Re: [PATCH] dt-bindings: phy: st: convert phy-stih407-usb to DT
 schema
Message-ID: <20230811192747.GA3978164-robh@kernel.org>
References: <20230801205510.15713-1-rgallaispou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230801205510.15713-1-rgallaispou@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 10:55:10PM +0200, Raphael Gallais-Pou wrote:
> From: Raphaël Gallais-Pou <raphael.gallais.pou@gmail.com>
> 
> Convert the st,stih407-usb2-phy binding to DT schema format.
> 
> Signed-off-by: Raphaël Gallais-Pou <raphael.gallais.pou@gmail.com>
> ---
>  .../bindings/phy/phy-stih407-usb.txt          | 24 -------
>  .../bindings/phy/st,stih407-usb2-phy.yaml     | 63 +++++++++++++++++++
>  2 files changed, 63 insertions(+), 24 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/phy/phy-stih407-usb.txt
>  create mode 100644 Documentation/devicetree/bindings/phy/st,stih407-usb2-phy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-stih407-usb.txt b/Documentation/devicetree/bindings/phy/phy-stih407-usb.txt
> deleted file mode 100644
> index 35f03df00130..000000000000
> --- a/Documentation/devicetree/bindings/phy/phy-stih407-usb.txt
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -ST STiH407 USB PHY controller
> -
> -This file documents the dt bindings for the usb picoPHY driver which is the PHY for both USB2 and USB3
> -host controllers (when controlling usb2/1.1 devices) available on STiH407 SoC family from STMicroelectronics.
> -
> -Required properties:
> -- compatible		: should be "st,stih407-usb2-phy"
> -- st,syscfg		: phandle of sysconfig bank plus integer array containing phyparam and phyctrl register offsets
> -- resets		: list of phandle and reset specifier pairs. There should be two entries, one
> -			  for the whole phy and one for the port
> -- reset-names		: list of reset signal names. Should be "global" and "port"
> -See: Documentation/devicetree/bindings/reset/st,stih407-powerdown.yaml
> -See: Documentation/devicetree/bindings/reset/reset.txt
> -
> -Example:
> -
> -usb2_picophy0: usbpicophy@f8 {
> -	compatible	= "st,stih407-usb2-phy";
> -	#phy-cells	= <0>;
> -	st,syscfg	= <&syscfg_core 0x100 0xf4>;
> -	resets		= <&softreset STIH407_PICOPHY_SOFTRESET>,
> -			  <&picophyreset STIH407_PICOPHY0_RESET>;
> -	reset-names	= "global", "port";
> -};
> diff --git a/Documentation/devicetree/bindings/phy/st,stih407-usb2-phy.yaml b/Documentation/devicetree/bindings/phy/st,stih407-usb2-phy.yaml
> new file mode 100644
> index 000000000000..1f66ceddbf81
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/st,stih407-usb2-phy.yaml
> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/st,stih407-usb2-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: STMicroelectronics STiH407 USB PHY controller
> +
> +maintainers:
> +  - Patrice Chotard <patrice.chotard@foss.st.com>
> +
> +description:
> +  The USB picoPHY driver is the PHY for both USB2 and USB3 host controllers
> +  (when controlling usb2/1.1 devices) available on STiH407 SoC family from
> +  STMicroelectronics.
> +
> +properties:
> +  compatible:
> +    const: st,stih407-usb2-phy
> +
> +  st,syscfg:
> +    description: Phandle to the syscfg bank
> +    $ref: "/schemas/types.yaml#/definitions/uint32-array"

Drop quotes

The correct type is 'phandle-array' which is really a matrix, so you 
need:

items:
  - items: 
      - description: ...
      - description: ...
      - description: ...

> +    items:
> +      - description: phandle to syscfg
> +      - description: phyparam register offset
> +      - description: phyctrl register offset
> +
> +  resets:
> +    items:
> +      - description: Phandle and reset specifier pair for the whole phy.
> +      - description: Phandle and reset specifier pair for the port.
> +
> +  reset-names:
> +    description: List of reset signal names.
> +    items:
> +      - const: "global"
> +      - const: "port"

Drop quotes

> +
> +  "#phy-cells":
> +    const: 0
> +
> +required:
> +  - compatible
> +  - st,syscfg
> +  - resets
> +  - reset-names
> +  - "#phy-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/reset/stih407-resets.h>
> +    usb2_picophy0: usbpicophy {
> +    	compatible	= "st,stih407-usb2-phy";
> +    	#phy-cells	= <0>;
> +    	st,syscfg	= <&syscfg_core 0x100 0xf4>;
> +    	resets		= <&softreset STIH407_PICOPHY_SOFTRESET>,
> +    			  <&picophyreset STIH407_PICOPHY0_RESET>;
> +    	reset-names	= "global", "port";

Mixed spaces and tabs.

> +    };
> +...
> -- 
> 2.41.0
> 
