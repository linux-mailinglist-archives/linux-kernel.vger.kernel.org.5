Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4707618EF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 14:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbjGYMyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 08:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjGYMyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 08:54:19 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9210D13D;
        Tue, 25 Jul 2023 05:54:16 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2224F5AA;
        Tue, 25 Jul 2023 14:53:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1690289596;
        bh=sHVHC32Eq+o4pz/bcsB3AZfAlK7INmtSF+Efqz7jrE8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ITdjyrV69ebKHddVL2xbV8gnlcGzkjtfcOHuIASMPR8HZc8sk9bUI787SAPOzibvY
         K2gw+/CLFeCfmBYl+GthQWxLV/YckQ4wiS1jjTyaPsuDCev3/w33/Zdo7aSqFrAWEu
         zWnpDr1fy0/W+2yQ9VJ7CbSQ5axtHSKAqodYbZOg=
Date:   Tue, 25 Jul 2023 15:54:22 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, dan.scally@ideasonboard.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/4] dt-bindings: arm: Add Polyhex DEBIX SOM A based
 boards
Message-ID: <20230725125422.GD21640@pendragon.ideasonboard.com>
References: <20230717165127.2882535-1-m.felsch@pengutronix.de>
 <20230717165127.2882535-3-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230717165127.2882535-3-m.felsch@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

Thank you for the patch.

On Mon, Jul 17, 2023 at 06:51:26PM +0200, Marco Felsch wrote:
> Add devicetree bindings for i.MX8MP based DEBIX SOM A and SOM A I/O
> baseboard:
>   - https://debix.io/hardware/debix-som-a.html
>   - https://debix.io/hardware/debix-som-a-io-board.html
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> Changelog:
> 
> v2:
> - drop to generic polyhex,imx8mp-debix binding
> 
>  Documentation/devicetree/bindings/arm/fsl.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index b29974e3c30b3..a810749f352de 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -1060,6 +1060,13 @@ properties:
>              deprecated: true
>            - const: fsl,imx8mp
>  
> +      - description: Polyhex DEBIX i.MX8MP SOM A based boards
> +        items:
> +          - enum:
> +              - polyhex,imx8mp-debix-som-a-bmb-08   # Polyhex Debix SOM A on SOM A I/O board
> +          - const: polyhex,imx8mp-debix-som-a       # Polyhex Debix SOM A
> +          - const: fsl,imx8mp
> +
>        - description: Toradex Boards with Verdin iMX8M Plus Modules
>          items:
>            - enum:

-- 
Regards,

Laurent Pinchart
