Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEE77F5A98
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 09:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjKWIwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 03:52:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232766AbjKWIwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 03:52:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DE510DA
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 00:52:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95C12C433C7;
        Thu, 23 Nov 2023 08:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700729557;
        bh=47dwYDVaeiPguKuVsuNUFtUg+itamYNE9PpBeSw6eZg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Dok34HXLZ+G+3ejVRbwl/XzmczoO7tNhMDKk7chx07AehavwPSdHdoze4XWl4IYeO
         zTaYxQCuPDx29HCAUO7Pi7VF326bsjuFGukoh2/SVYaaWkK3iiD8xB+ow/5Blai+dh
         bQCnDX03T2to0gao8jfzmh3ptH7/DPsHH+geT73QX8M+A7fAD4tO9jrRVisleuU/6l
         KOi3KF0IpJJyybrFHQA/DK6pJqiBQpZ7hxSD/9+9npV9SK2t/d2GTl1lnaKQUo7WIl
         +BnSWu2ojn9Km+fhaLnEV7WbWQZBmaP6zqKZYj6/MGSW9hxYKq/1k9jCT/m+zjPeZO
         qoHFu5qF55BzA==
Date:   Thu, 23 Nov 2023 14:22:33 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Rob Herring <robh@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Jai Luthra <j-luthra@ti.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: dma: Drop undocumented examples
Message-ID: <ZV8S0WAz+NbYUc84@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122235050.2966280-1-robh@kernel.org>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-11-23, 16:50, Rob Herring wrote:
> The compatibles "ti,omap-sdma" and "ti,dra7-dma-crossbar" aren't documented
> by a schema which causes warnings:
> 
> Documentation/devicetree/bindings/dma/dma-controller.example.dtb: /example-0/dma-controller@48000000: failed to match any schema with compatible: ['ti,omap-sdma']
> Documentation/devicetree/bindings/dma/dma-router.example.dtb: /example-0/dma-router@4a002b78: failed to match any schema with compatible: ['ti,dra7-dma-crossbar']

So instead now we will have undocumented ti-omap-sdma?

Adding Peter and TI folks as well

> As no one has cared to fix them, just drop them.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/dma/dma-controller.yaml   | 15 ---------------
>  .../devicetree/bindings/dma/dma-router.yaml       | 11 -----------
>  2 files changed, 26 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/dma-controller.yaml b/Documentation/devicetree/bindings/dma/dma-controller.yaml
> index 04d150d4d15d..e6afca558c2d 100644
> --- a/Documentation/devicetree/bindings/dma/dma-controller.yaml
> +++ b/Documentation/devicetree/bindings/dma/dma-controller.yaml
> @@ -19,19 +19,4 @@ properties:
>  
>  additionalProperties: true
>  
> -examples:
> -  - |
> -    dma: dma-controller@48000000 {
> -        compatible = "ti,omap-sdma";
> -        reg = <0x48000000 0x1000>;
> -        interrupts = <0 12 0x4>,
> -                     <0 13 0x4>,
> -                     <0 14 0x4>,
> -                     <0 15 0x4>;
> -        #dma-cells = <1>;
> -        dma-channels = <32>;
> -        dma-requests = <127>;
> -        dma-channel-mask = <0xfffe>;
> -    };
> -
>  ...
> diff --git a/Documentation/devicetree/bindings/dma/dma-router.yaml b/Documentation/devicetree/bindings/dma/dma-router.yaml
> index 346fe0fa4460..5ad2febc581e 100644
> --- a/Documentation/devicetree/bindings/dma/dma-router.yaml
> +++ b/Documentation/devicetree/bindings/dma/dma-router.yaml
> @@ -40,15 +40,4 @@ required:
>  
>  additionalProperties: true
>  
> -examples:
> -  - |
> -    sdma_xbar: dma-router@4a002b78 {
> -        compatible = "ti,dra7-dma-crossbar";
> -        reg = <0x4a002b78 0xfc>;
> -        #dma-cells = <1>;
> -        dma-requests = <205>;
> -        ti,dma-safe-map = <0>;
> -        dma-masters = <&sdma>;
> -    };
> -
>  ...
> -- 
> 2.42.0

-- 
~Vinod
