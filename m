Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE5F7BBD5F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 18:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbjJFQ6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 12:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232912AbjJFQ6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 12:58:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2362FBF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 09:58:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E76DDC433C8;
        Fri,  6 Oct 2023 16:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696611501;
        bh=iVc5ncutti07i299unS9e4aBYDPYiKeh0xWAD/nJg+I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P080P8RwpkFq/3cYtN9/2Bgq3epTiSizjGICcW6rb4MM1j4YlBtZjaxuY8T6Pq1Sg
         k+e0QouM67rmzIUS1usTeBsGjqi3ccy+DmB9EV+sfvc00GvvNEUyDCPvoeclnykoWZ
         eDFRaGGXBZCVu3bcdKuBPDQMK9ZEM2ADLj67o0LW+VY79G0KlYvJUwb4GLyFV8amiM
         o05vTUU4cqenrymPf//CbBe8p8FfWoEi9QOZnW7jl54DadSzRrLtwZ1pdmM7GGAlH+
         CuAryxOtFuKptclCp+0JjZ6h1pQrtOXEQjSGm3bQRoThYKlA+84+vrJl+ZBhvRaK4H
         ee7rEFuPelJmg==
Received: (nullmailer pid 4068792 invoked by uid 1000);
        Fri, 06 Oct 2023 16:58:19 -0000
Date:   Fri, 6 Oct 2023 11:58:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     niravkumar.l.rabara@intel.com
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: mtd: cadence: convert
 cadence-nand-controller.txt to yaml
Message-ID: <20231006165819.GA4066666-robh@kernel.org>
References: <20231005051548.55122-1-niravkumar.l.rabara@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005051548.55122-1-niravkumar.l.rabara@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 01:15:48PM +0800, niravkumar.l.rabara@intel.com wrote:
> From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> 
> Convert cadence-nand-controller.txt to yaml format.
> Update cadence-nand-controller.txt to cadence,nand.yaml in MAINTAINER file.
> 
> Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> ---
>  .../devicetree/bindings/mtd/cadence,nand.yaml | 73 +++++++++++++++++++

Filename matching compatible.

>  .../bindings/mtd/cadence-nand-controller.txt  | 53 --------------
>  MAINTAINERS                                   |  2 +-
>  3 files changed, 74 insertions(+), 54 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mtd/cadence,nand.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mtd/cadence-nand-controller.txt
> 
> diff --git a/Documentation/devicetree/bindings/mtd/cadence,nand.yaml b/Documentation/devicetree/bindings/mtd/cadence,nand.yaml
> new file mode 100644
> index 000000000000..781812ac702f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/cadence,nand.yaml
> @@ -0,0 +1,73 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mtd/cadence,nand.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cadence NAND controller
> +
> +maintainers:
> +  - Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> +
> +allOf:
> +  - $ref: nand-controller.yaml
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: cdns,hp-nfc
> +
> +  reg:
> +    items:
> +      - description: Address and length of the controller register set
> +      - description: Address and length of the Slave DMA data port
> +
> +  reg-names:
> +    items:
> +      - const: reg
> +      - const: sdma
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  dmas:
> +    maxItems: 1
> +
> +  cdns,board-delay-ps:
> +    description: |
> +      Estimated Board delay. The value includes the total round trip
> +      delay for the signals and is used for deciding on values associated
> +      with data read capture. The example formula for SDR mode is the
> +      following.
> +      board delay = RE#PAD delay + PCB trace to device + PCB trace from device
> +      + DQ PAD delay
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - clocks
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +      nand-controller@10b80000 {
> +        compatible = "cdns,hp-nfc";
> +        reg = <0x10b80000 0x10000>,
> +            <0x10840000 0x10000>;
> +        reg-names = "reg", "sdma";
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        interrupts = <0 97 4>;
> +        clocks = <&nf_clk>;
> +        cdns,board-delay-ps = <4830>;
> +
> +        nand@0 {
> +            reg = <0>;
> +        };
> +      };
> diff --git a/Documentation/devicetree/bindings/mtd/cadence-nand-controller.txt b/Documentation/devicetree/bindings/mtd/cadence-nand-controller.txt
> deleted file mode 100644
> index d2eada5044b2..000000000000
> --- a/Documentation/devicetree/bindings/mtd/cadence-nand-controller.txt
> +++ /dev/null
> @@ -1,53 +0,0 @@
> -* Cadence NAND controller
> -
> -Required properties:
> -  - compatible : "cdns,hp-nfc"
> -  - reg : Contains two entries, each of which is a tuple consisting of a
> -	  physical address and length. The first entry is the address and
> -	  length of the controller register set. The second entry is the
> -	  address and length of the Slave DMA data port.
> -  - reg-names: should contain "reg" and "sdma"
> -  - #address-cells: should be 1. The cell encodes the chip select connection.
> -  - #size-cells : should be 0.
> -  - interrupts : The interrupt number.
> -  - clocks: phandle of the controller core clock (nf_clk).
> -
> -Optional properties:
> -  - dmas: shall reference DMA channel associated to the NAND controller
> -  - cdns,board-delay-ps : Estimated Board delay. The value includes the total
> -    round trip delay for the signals and is used for deciding on values
> -    associated with data read capture. The example formula for SDR mode is
> -    the following:
> -    board delay = RE#PAD delay + PCB trace to device + PCB trace from device
> -    + DQ PAD delay
> -
> -Child nodes represent the available NAND chips.
> -
> -Required properties of NAND chips:
> -  - reg: shall contain the native Chip Select ids from 0 to max supported by
> -    the cadence nand flash controller
> -
> -See Documentation/devicetree/bindings/mtd/nand-controller.yaml for more details on
> -generic bindings.
> -
> -Example:
> -
> -nand_controller: nand-controller@60000000 {
> -	  compatible = "cdns,hp-nfc";
> -	  #address-cells = <1>;
> -	  #size-cells = <0>;
> -	  reg = <0x60000000 0x10000>, <0x80000000 0x10000>;
> -	  reg-names = "reg", "sdma";
> -	  clocks = <&nf_clk>;
> -	  cdns,board-delay-ps = <4830>;
> -	  interrupts = <2 0>;
> -	  nand@0 {
> -	      reg = <0>;
> -	      label = "nand-1";
> -	  };
> -	  nand@1 {
> -	      reg = <1>;
> -	      label = "nand-2";
> -	  };
> -
> -};
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 90f13281d297..502963390646 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4474,7 +4474,7 @@ F:	drivers/media/platform/cadence/cdns-csi2*
>  CADENCE NAND DRIVER
>  L:	linux-mtd@lists.infradead.org
>  S:	Orphan
> -F:	Documentation/devicetree/bindings/mtd/cadence-nand-controller.txt
> +F:	Documentation/devicetree/bindings/mtd/cadence,nand.yaml
>  F:	drivers/mtd/nand/raw/cadence-nand-controller.c
>  
>  CADENCE USB3 DRD IP DRIVER
> -- 
> 2.25.1
> 
