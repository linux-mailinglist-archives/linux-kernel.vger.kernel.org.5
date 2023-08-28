Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7F378B4B2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 17:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbjH1Pn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 11:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbjH1PnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 11:43:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2919D;
        Mon, 28 Aug 2023 08:43:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36CB9641E8;
        Mon, 28 Aug 2023 15:43:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A5C5C433CA;
        Mon, 28 Aug 2023 15:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693237392;
        bh=l8mBaaM0TYGsK1UM6qYwETDaYnQ3tF3yQqXH6gOzhUY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZvZr7SMb2mlcEp9LwRjxXi9L36v182tEh1ALZPEzGhL1DI1Ps5MvKmIpbEz4ziNv0
         Zq+dRtBIiuJd+n05fYVBQ6fW2sAYKSWgz3juJa/cap98jplL2aBtVMzNTnHIjF8iGR
         wNTLz5GuLPU8J+SA69h+y7vtsxYyRh+v1VpdNKLJlHyNqFrHKLIDfNp26e7/Xjx9/7
         xYAWGSGNOVN5fQvpY7qm29DYJfMTsAiUmeuMbeZWAu9iwwohsTj9x5DsgNwhdhS0h3
         y2PsKJM11T8bYUNwu9xjCeYBDaeDWHHR1zEWw0m856BxiKMICiErNGNocG2oRLI+9b
         DK1mrVWJXcCBg==
Received: (nullmailer pid 607773 invoked by uid 1000);
        Mon, 28 Aug 2023 15:43:09 -0000
Date:   Mon, 28 Aug 2023 10:43:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Srinivas Goud <srinivas.goud@amd.com>
Cc:     wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        p.zabel@pengutronix.de, git@amd.com, michal.simek@amd.com,
        linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, appana.durga.rao@xilinx.com,
        naga.sureshkumar.relli@xilinx.com
Subject: Re: [PATCH v3 1/3] dt-bindings: can: xilinx_can: Add ECC property
 'xlnx,has-ecc'
Message-ID: <20230828154309.GA604444-robh@kernel.org>
References: <1693234725-3615719-1-git-send-email-srinivas.goud@amd.com>
 <1693234725-3615719-2-git-send-email-srinivas.goud@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1693234725-3615719-2-git-send-email-srinivas.goud@amd.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 08:28:43PM +0530, Srinivas Goud wrote:
> ECC feature added to Tx and Rx FIFOs for Xilinx AXI CAN Controller.
> Part of this feature configuration and counter registers added in
> IP for 1bit/2bit ECC errors.
> 
> xlnx,has-ecc is optional property and added to Xilinx AXI CAN Controller
> node if ECC block enabled in the HW
> 
> Signed-off-by: Srinivas Goud <srinivas.goud@amd.com>
> ---
> Changes in v3:
> Update commit description
> 
> Changes in v2:
> None

Doesn't apply, dependency?

> 
>  Documentation/devicetree/bindings/net/can/xilinx,can.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/can/xilinx,can.yaml b/Documentation/devicetree/bindings/net/can/xilinx,can.yaml
> index 64d57c3..c842610 100644
> --- a/Documentation/devicetree/bindings/net/can/xilinx,can.yaml
> +++ b/Documentation/devicetree/bindings/net/can/xilinx,can.yaml
> @@ -49,6 +49,10 @@ properties:
>    resets:
>      maxItems: 1
>  
> +  xlnx,has-ecc:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: CAN Tx and Rx fifo ECC enable flag (AXI CAN)

has ECC or enable ECC?

> +
>  required:
>    - compatible
>    - reg
> @@ -137,6 +141,7 @@ examples:
>          interrupts = <GIC_SPI 59 IRQ_TYPE_EDGE_RISING>;
>          tx-fifo-depth = <0x40>;
>          rx-fifo-depth = <0x40>;
> +        xlnx,has-ecc

Obviously not tested.

>      };
>  
>    - |
> -- 
> 2.1.1
> 
