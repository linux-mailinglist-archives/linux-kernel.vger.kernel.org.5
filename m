Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134FA776C81
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 00:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbjHIW6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 18:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjHIW6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 18:58:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65406E71;
        Wed,  9 Aug 2023 15:58:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFC2364A7D;
        Wed,  9 Aug 2023 22:58:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8894DC433C8;
        Wed,  9 Aug 2023 22:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691621916;
        bh=qXAY5+ypBMRjazkxqMPSQk8aD3TC6Q1gvPIppZsbcKg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BbgfgXdsOE1QpeBsua+opVOLktDulOVKwrCaVnE+j/XlHuEqn9K5n88UcwTAUVVoo
         zgTMn+okkEpKKSl1H69pYJOdDX/wQ9vbSY7IacbVHRfTOdAPT5LTyBGIR+3ApZPm9L
         Q4/9B+zSKZWhRLNoy2P6/ah0vmGksUfy+jnyq5gBvzs8TgZGWyIEOkoj6ksJRL3TeK
         1Tjn5N5Ry4ya7sJtVj+4DHPGpT5bBRbqiD0OEqy3kgFo002Y0r+3PNHgogA3sOBAm9
         0/aIl3X9uaOoK02IgDHKgKkryfRnhcv6bhevTFS2Jq6cC2j+hKSm6iHjfl5i4QSSUq
         a2ZeUbCL1tkgw==
Received: (nullmailer pid 3162148 invoked by uid 1000);
        Wed, 09 Aug 2023 22:58:34 -0000
Date:   Wed, 9 Aug 2023 16:58:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/8] dt-bindings: mtd: add basic bindings for UBI
Message-ID: <20230809225834.GA3144140-robh@kernel.org>
References: <cover.1691510312.git.daniel@makrotopia.org>
 <094e68da59bbd9efea1469b122f34f5dcf156f0f.1691510312.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <094e68da59bbd9efea1469b122f34f5dcf156f0f.1691510312.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 05:03:19PM +0100, Daniel Golle wrote:
> Add basic bindings for UBI devices and volumes.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  .../bindings/mtd/partitions/linux,ubi.yaml    | 65 +++++++++++++++++++
>  .../bindings/mtd/partitions/ubi-volume.yaml   | 35 ++++++++++
>  2 files changed, 100 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/linux,ubi.yaml
>  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/ubi-volume.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mtd/partitions/linux,ubi.yaml b/Documentation/devicetree/bindings/mtd/partitions/linux,ubi.yaml
> new file mode 100644
> index 0000000000000..79cfa0a3eaa7d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/partitions/linux,ubi.yaml
> @@ -0,0 +1,65 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mtd/partitions/linux,ubi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Unsorted Block Images
> +
> +description: |
> +  UBI ("Unsorted Block Images") is a volume management system for raw
> +  flash devices which manages multiple logical volumes on a single
> +  physical flash device and spreads the I/O load (i.e, wear-leveling)
> +  across whole flash chip.
> +
> +maintainers:
> +  - Daniel Golle <daniel@makrotopia.org>
> +
> +allOf:
> +  - $ref: partition.yaml#
> +
> +properties:
> +  compatible:
> +    const: linux,ubi
> +
> +  volumes:
> +    type: object
> +    description: UBI Volumes
> +
> +    patternProperties:
> +      "^ubi-volume-.*$":
> +        $ref: "/schemas/mtd/partitions/ubi-volume.yaml"

Don't need quotes.

> +
> +    unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    partitions {
> +        compatible = "fixed-partitions";
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +
> +        partition@0 {
> +            reg = <0x0 0x100000>;
> +            label = "bootloader";
> +            read-only;
> +        };
> +
> +        partition@100000 {
> +            reg = <0x100000 0x1ff00000>;
> +            label = "ubi";
> +            compatible = "linux,ubi";
> +
> +            volumes {
> +                ubi-volume-caldata {
> +                    volid = <2>;
> +                    volname = "rf";
> +                };
> +            };
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/mtd/partitions/ubi-volume.yaml b/Documentation/devicetree/bindings/mtd/partitions/ubi-volume.yaml
> new file mode 100644
> index 0000000000000..c17d0caf07d97
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/partitions/ubi-volume.yaml
> @@ -0,0 +1,35 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mtd/partitions/ubi-volume.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: UBI volume
> +
> +description: |
> +  This binding describes a single UBI volume. Volumes can be matches either
> +  by their ID or their name, or both.
> +
> +maintainers:
> +  - Daniel Golle <daniel@makrotopia.org>
> +
> +properties:
> +  volid:

volume-id or ubi-vol-id.

> +    $ref: "/schemas/types.yaml#/definitions/uint32"

Drop quotes.

> +    description:
> +      Match UBI volume ID
> +
> +  volname:
> +    $ref: "/schemas/types.yaml#/definitions/string"
> +    description:
> +      Match UBI volume ID

ID? 

> +
> +anyOf:
> +  - required:
> +    - volid
> +
> +  - required:
> +    - volname
> +
> +# This is a generic file other binding inherit from and extend
> +additionalProperties: true

Where do we restrict this? You referenced it, but didn't didn't restrict 
it there (with unevaluatedProperties).

What other properties would you expect? These nodes ultimately need a 
single schema (can be multiple files with $ref's) containing all 
possible properties. Otherwise, any random property can be added 
unchecked.

Rob
