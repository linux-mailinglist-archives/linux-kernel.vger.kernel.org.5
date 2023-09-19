Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93887A6A6F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 20:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbjISSJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 14:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbjISSJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 14:09:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45BCA6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 11:09:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 307F6C433C8;
        Tue, 19 Sep 2023 18:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695146952;
        bh=NiQhEzZ16sAKsbZx0nSfSfGM+Oqurfn7GL5Vpupl3ME=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qMh1x1eWX1dPxF/rQjU9qyK5jvupSZnFN5lJhRo5QZcgCNgl9DRLJebEn0oTxgxKR
         6hXm+2Vc4GYKV/b3pcEnNDV7vj7XItmLzQH0Z0Wyswr6f2TSEH5l/khhE/dPQciCUF
         ha7lAs49r0QPgsLJspD5OKPANA7YmKJuzBQQ8vp2bY/6wBNG9uimXqXNOPDXwAe1AO
         QGVNfqG68EIyQvEZlC/Gr5vTWv/WqmIHQNYM0rOfI8mBc6zyI5oRGv12W6RqjXCljJ
         8QSSln7LWmvK+RoftT023Y5CexORitN9iJ2EWYgtfLxPtC1D8CapUTzc9iAfoiJCYR
         jaXie/FMK4iwg==
Received: (nullmailer pid 4169551 invoked by uid 1000);
        Tue, 19 Sep 2023 18:09:09 -0000
Date:   Tue, 19 Sep 2023 13:09:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: mediatek,net: add
 phandles for SerDes on MT7988
Message-ID: <20230919180909.GA4151534-robh@kernel.org>
References: <cover.1695058909.git.daniel@makrotopia.org>
 <35c12a115893d324db16ec6983afb5f1951fd4c9.1695058909.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35c12a115893d324db16ec6983afb5f1951fd4c9.1695058909.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 11:26:34PM +0100, Daniel Golle wrote:
> Add several phandles needed for Ethernet SerDes interfaces on the
> MediaTek MT7988 SoC.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  .../devicetree/bindings/net/mediatek,net.yaml | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/mediatek,net.yaml b/Documentation/devicetree/bindings/net/mediatek,net.yaml
> index e74502a0afe86..78219158b96af 100644
> --- a/Documentation/devicetree/bindings/net/mediatek,net.yaml
> +++ b/Documentation/devicetree/bindings/net/mediatek,net.yaml
> @@ -385,6 +385,34 @@ allOf:
>            minItems: 2
>            maxItems: 2
>  
> +        mediatek,toprgu:
> +          $ref: /schemas/types.yaml#/definitions/phandle
> +          description:
> +            Phandle to the syscon representing the reset controller.

Use the reset binding

> +
> +        mediatek,usxgmiisys:
> +          $ref: /schemas/types.yaml#/definitions/phandle-array
> +          minItems: 2
> +          maxItems: 2
> +          items:
> +            maxItems: 1
> +          description:
> +            A list of phandle to the syscon node referencing the USXGMII PCS.

Use the PCS binding

> +
> +        mediatek,xfi-pextp:
> +          $ref: /schemas/types.yaml#/definitions/phandle-array
> +          minItems: 2
> +          maxItems: 2
> +          items:
> +            maxItems: 1
> +          description:
> +            A list of phandle to the syscon node that handles the 10GE SerDes PHY.

Use the phy binding (phys, not phy-handle for ethernet PHY).

> +
> +        mediatek,xfi-pll:
> +          $ref: /schemas/types.yaml#/definitions/phandle
> +          description:
> +            Phandle to the syscon node handling the 10GE SerDes clock setup.

Use the clock binding


> +
>  patternProperties:
>    "^mac@[0-1]$":
>      type: object
> -- 
> 2.42.0
