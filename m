Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419707A5423
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 22:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjIRUaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 16:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjIRUaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 16:30:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535A18F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 13:29:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E767C433C7;
        Mon, 18 Sep 2023 20:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695068994;
        bh=RQUlDwkha5Sj8e9teHemf6VSIjaIGbIuFWE9vk0iWlU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uCzW6D1x/Y7q1cYGyDSizob45IJop6qiLZU0lvL7zyHPyQgpnCwZ71Yk8JdkiDR8+
         gzIUTMx6RP8cx7F9xQRmJOV5oFIBuaM2LDGCGHzaF+jkK9lIXyIqCrc3qtNDOfdW+E
         iHP1EdYfrVZeN5j0EpGs3egt/UowxfsNhGXxht7L0qV/Fz7f6zzDcdjW1bUZUnRAzT
         TmXdKKlPzc1j5ZN0AFuJOB++bnjHC5PbeuZolKX1tRTkxydHT4y5NeuoQTEwEa4pdw
         Lx9XA2p3NApWtYPWdrRMHNfiq70mH6iq4glmVp5UeHaagdY+TeoCHpk6kae4QcF0Z3
         nylVsTKXgreoQ==
Received: (nullmailer pid 1722890 invoked by uid 1000);
        Mon, 18 Sep 2023 20:29:51 -0000
Date:   Mon, 18 Sep 2023 15:29:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>,
        Daniel Golle <daniel@makrotopia.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next 2/2] dt-bindings: net: mediatek,net: move
 mediatek,mt7621-eth to another schema
Message-ID: <20230918202951.GA1712467-robh@kernel.org>
References: <20230917124723.143202-1-arinc.unal@arinc9.com>
 <20230917124723.143202-2-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230917124723.143202-2-arinc.unal@arinc9.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 17, 2023 at 03:47:23PM +0300, Arınç ÜNAL wrote:
> The bindings for mediatek,mt7621-eth contradict with some of the rules on
> the top level schema of mediatek,net.yaml:
> - resets must be two items. resets with "maxItems: 3" at the top level
>   implies "minItems: 3" and cannot be overriden under a subschema.
> - reset-names items must be "fe" and "eth". reset-names items defined on
>   the top level schema cannot be overridden under a subschema.

Why not? You can shuffle things around. Though at some point it is worth 
splitting the schemas.

> 
> Therefore, move mediatek,mt7621-eth to another schema. Fix the order of
> clock-names items. Do not define the properties that don't apply to this
> hardware. Require more properties. Add an example.
> 
> Fixes: 1cbf487d7d3a ("dt-bindings: net: mediatek,net: add missing mediatek,mt7621-eth")
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
>  .../bindings/net/mediatek,mt7621-eth.yaml     | 143 ++++++++++++++++++
>  .../devicetree/bindings/net/mediatek,net.yaml |  27 ----
>  2 files changed, 143 insertions(+), 27 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/mediatek,mt7621-eth.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/mediatek,mt7621-eth.yaml b/Documentation/devicetree/bindings/net/mediatek,mt7621-eth.yaml
> new file mode 100644
> index 000000000000..4f39d7124693
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/mediatek,mt7621-eth.yaml
> @@ -0,0 +1,143 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/mediatek,mt7621-eth.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek MT7621 Frame Engine Ethernet controller
> +
> +maintainers:
> +  - Arınç ÜNAL <arinc.unal@arinc9.com>
> +
> +description:
> +  The frame engine ethernet controller can be found on MediaTek MT7621 SoC. This
> +  SoC has got dual GMAC ports.
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt7621-eth
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 2
> +
> +  clock-names:
> +    items:
> +      - const: fe
> +      - const: ethif
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 2
> +
> +  reset-names:
> +    items:
> +      - const: fe
> +      - const: eth
> +
> +  mediatek,ethsys:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the syscon node that handles the port setup.
> +
> +  mdio-bus:
> +    $ref: mdio.yaml#
> +    unevaluatedProperties: false
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +patternProperties:
> +  "^mac@[0-1]$":
> +    type: object
> +    unevaluatedProperties: false
> +    allOf:

Don't need allOf.

> +      - $ref: ethernet-controller.yaml#
> +    description:
> +      Ethernet MAC node
> +    properties:
> +      compatible:
> +        const: mediatek,eth-mac
> +
> +      reg:
> +        maxItems: 1
> +
> +    required:
> +      - reg
> +      - compatible

Now all the child nodes (at least) are duplicated. If you don't want to 
further extend the if/then schemas (it's a judgement call when splitting 
makes sense), then I'd suggest you move what is common to a separate 
schema file and then $ref it in this file and the original schema.

Rob
