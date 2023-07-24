Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E4775FC05
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 18:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbjGXQ0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 12:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjGXQ0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 12:26:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D084BFF;
        Mon, 24 Jul 2023 09:26:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 603B961261;
        Mon, 24 Jul 2023 16:26:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 804F9C433C8;
        Mon, 24 Jul 2023 16:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690216000;
        bh=NnhraS8BL5Ulb0entmVSGXe3OMU1B/0GaHabwEyEAqU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BO7H22sbEac8N0hk1Xfc94utPCZxOSeEAM9ndel6gZBAiG60AnLS8mftvn57mQXzc
         yc4oE1Y51O8MxBEN2ArPLcNQoaV2p4e/4K+7LGmv+wX1G9cdba/+z6xshhHEUPvn0o
         kPITafT4aArXOv8nOhPO2Tjyp0irsZkovf+dkQNATOlxJFNQAoFPQ/2hjJN3noLMW0
         ysMf+5w4wZoFK3qqc7wtnwyuPAyQ/jOBT3IYOucfZigRbGBX/BuOvCbp19lQyiNjk/
         k5ExV/uCqu9c+SFVjLhrZyvMESYWMbPFghVc1coNq3aWPmEl7OkulX5nvLSFsgUDkc
         HxRs5zjTRBQGQ==
Received: (nullmailer pid 3786398 invoked by uid 1000);
        Mon, 24 Jul 2023 16:26:38 -0000
Date:   Mon, 24 Jul 2023 10:26:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jagan Sridharan <badhri@google.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Min Guo <min.guo@mediatek.com>,
        Gene Chen <gene_chen@richtek.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: usb: add missing unevaluatedProperties on
 USB connector
Message-ID: <20230724162638.GA3784203-robh@kernel.org>
References: <20230723071105.40157-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230723071105.40157-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 23, 2023 at 09:11:05AM +0200, Krzysztof Kozlowski wrote:
> The usb-connector.yaml schema allows any additional properties, thus its
> usage should finish with unevaluatedProperties: false.

Is it problematic if usb-connector.yaml is restricted?

> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/usb/maxim,max33359.yaml       | 1 +
>  Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml | 1 +
>  Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml        | 1 +
>  Documentation/devicetree/bindings/usb/mediatek,musb.yaml        | 1 +
>  Documentation/devicetree/bindings/usb/richtek,rt1711h.yaml      | 1 +
>  Documentation/devicetree/bindings/usb/richtek,rt1719.yaml       | 1 +
>  6 files changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/maxim,max33359.yaml b/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
> index 276bf7554215..45e093978b82 100644
> --- a/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
> +++ b/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
> @@ -25,6 +25,7 @@ properties:
>    connector:
>      type: object
>      $ref: ../connector/usb-connector.yaml#
> +    unevaluatedProperties: false
>      description:
>        Properties for usb c connector.
>  
> diff --git a/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml b/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml
> index 053264e60583..42b9d3a35c67 100644
> --- a/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml
> +++ b/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml
> @@ -29,6 +29,7 @@ properties:
>    connector:
>      type: object
>      $ref: ../connector/usb-connector.yaml#
> +    unevaluatedProperties: false
>      description:
>        Properties for usb c connector.
>  
> diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
> index a59d91243ac8..7eb880e4a270 100644
> --- a/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
> +++ b/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
> @@ -144,6 +144,7 @@ properties:
>  
>    connector:
>      $ref: /schemas/connector/usb-connector.yaml#
> +    unevaluatedProperties: false
>      description:
>        Connector for dual role switch, especially for "gpio-usb-b-connector"
>      type: object
> diff --git a/Documentation/devicetree/bindings/usb/mediatek,musb.yaml b/Documentation/devicetree/bindings/usb/mediatek,musb.yaml
> index a39d38db7714..924f74d45baa 100644
> --- a/Documentation/devicetree/bindings/usb/mediatek,musb.yaml
> +++ b/Documentation/devicetree/bindings/usb/mediatek,musb.yaml
> @@ -66,6 +66,7 @@ properties:
>      $ref: /schemas/connector/usb-connector.yaml#
>      description: Connector for dual role switch
>      type: object
> +    unevaluatedProperties: false
>  
>  dependencies:
>    usb-role-switch: [ connector ]
> diff --git a/Documentation/devicetree/bindings/usb/richtek,rt1711h.yaml b/Documentation/devicetree/bindings/usb/richtek,rt1711h.yaml
> index 8da4d2ad1a91..980235e27a7f 100644
> --- a/Documentation/devicetree/bindings/usb/richtek,rt1711h.yaml
> +++ b/Documentation/devicetree/bindings/usb/richtek,rt1711h.yaml
> @@ -36,6 +36,7 @@ properties:
>    connector:
>      type: object
>      $ref: /schemas/connector/usb-connector.yaml#
> +    unevaluatedProperties: false
>      description:
>        Properties for usb c connector.
>  
> diff --git a/Documentation/devicetree/bindings/usb/richtek,rt1719.yaml b/Documentation/devicetree/bindings/usb/richtek,rt1719.yaml
> index 4ced2f68e2a9..27978580b234 100644
> --- a/Documentation/devicetree/bindings/usb/richtek,rt1719.yaml
> +++ b/Documentation/devicetree/bindings/usb/richtek,rt1719.yaml
> @@ -34,6 +34,7 @@ properties:
>    connector:
>      type: object
>      $ref: ../connector/usb-connector.yaml#
> +    unevaluatedProperties: false
>      description:
>        Properties for usb c connector.
>  
> -- 
> 2.34.1
> 
