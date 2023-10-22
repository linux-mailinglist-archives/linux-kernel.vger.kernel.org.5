Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC767D25CC
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 22:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbjJVURr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 16:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJVURp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 16:17:45 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C55F2;
        Sun, 22 Oct 2023 13:17:42 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id DB9A33D6;
        Sun, 22 Oct 2023 22:17:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1698005851;
        bh=ddEPPlK70H204Yy7br9DdHH0Cq7Twvu7MQBse/6FuaU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h5TcbvBjibMR0naRzrjrdlDAqSoThlYtSEuOMphlpFfQuMbes6fk80e94UBOYdeE6
         IntMxOoZBX82NPLE8eLpdNogRJE5JjbXpj/7wvXQ5/oCWjLiRBnbxbvG4vCSgmVQbs
         rDjZaniStSy6XG4s6MWhpEqbWQjAYkpjjvOZKip0=
Date:   Sun, 22 Oct 2023 23:17:48 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: dt-bindings: ti,ds90ub960: Add missing type for
 "i2c-alias"
Message-ID: <20231022201748.GA32105@pendragon.ideasonboard.com>
References: <20231020170225.3632933-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231020170225.3632933-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thank you for the patch.

On Fri, Oct 20, 2023 at 12:02:24PM -0500, Rob Herring wrote:
> Every DT property needs a type defined, but "i2c-alias" is missing any
> type definition. It's a "uint32", so add a type reference.
> 
> Fixes: 313e8b32c616 ("media: dt-bindings: media: add TI DS90UB960 FPD-Link III Deserializer")
> Signed-off-by: Rob Herring <robh@kernel.org>

This is something I should have paid more attention when reviewing the
bindings. I'll try to keep it in mind for the future.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  Documentation/devicetree/bindings/media/i2c/ti,ds90ub960.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/ti,ds90ub960.yaml b/Documentation/devicetree/bindings/media/i2c/ti,ds90ub960.yaml
> index 289737721c2c..0b71e6f911a8 100644
> --- a/Documentation/devicetree/bindings/media/i2c/ti,ds90ub960.yaml
> +++ b/Documentation/devicetree/bindings/media/i2c/ti,ds90ub960.yaml
> @@ -69,6 +69,7 @@ properties:
>              maxItems: 1
>  
>            i2c-alias:
> +            $ref: /schemas/types.yaml#/definitions/uint32
>              description:
>                The I2C address used for the serializer. Transactions to this
>                address on the I2C bus where the deserializer resides are

-- 
Regards,

Laurent Pinchart
