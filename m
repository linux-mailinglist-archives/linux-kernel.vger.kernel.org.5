Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F857ED8B1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 01:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344097AbjKPAvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 19:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235054AbjKPAvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 19:51:41 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4C01B9;
        Wed, 15 Nov 2023 16:51:36 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 99697B9A;
        Thu, 16 Nov 2023 01:51:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1700095868;
        bh=18xXfXfw+tBl0xHCFm3jGrfNhRXP3Rv8yr93gRiQOkg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EDptMfqEsX+ghwRRlb6ihCUitYmpgij7FW5JBZjiU6pVDw20fKVzzuNyQeEzZMQWf
         b14MmvoDtbjd+x8cWB78ZbxSgvmWBAcxBld64GMs11Q8mjAucfdSLQE5jicpeTueJZ
         XH+awjkdPx0Z+oueccl59BgpJnACFgJprXOSZz7I=
Date:   Thu, 16 Nov 2023 02:51:40 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Mehdi Djait <mehdi.djait@bootlin.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, alexandre.belloni@bootlin.com,
        paul.kocialkowski@bootlin.com, dafna@fastmail.com,
        helen.koike@collabora.com, heiko@sntech.de,
        paul.elder@ideasonboard.com
Subject: Re: [PATCH] media: dt-bindings: media: rkisp1: Fix the port
 description for the parallel interface
Message-ID: <20231116005140.GB21041@pendragon.ideasonboard.com>
References: <20231115164407.99876-1-mehdi.djait@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231115164407.99876-1-mehdi.djait@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mehdi,

Thank you for the patch.

On Wed, Nov 15, 2023 at 05:44:07PM +0100, Mehdi Djait wrote:
> The bus-type belongs to the endpoint's properties and should therefore
> be moved.
> 
> Fixes: 6a0eaa25bf36 ("media: dt-bindings: media: rkisp1: Add port for parallel interface")
> Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>

Good catch.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  .../devicetree/bindings/media/rockchip-isp1.yaml      | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/rockchip-isp1.yaml b/Documentation/devicetree/bindings/media/rockchip-isp1.yaml
> index e466dff8286d..afcaa427d48b 100644
> --- a/Documentation/devicetree/bindings/media/rockchip-isp1.yaml
> +++ b/Documentation/devicetree/bindings/media/rockchip-isp1.yaml
> @@ -90,15 +90,16 @@ properties:
>          description: connection point for input on the parallel interface
>  
>          properties:
> -          bus-type:
> -            enum: [5, 6]
> -
>            endpoint:
>              $ref: video-interfaces.yaml#
>              unevaluatedProperties: false
>  
> -        required:
> -          - bus-type
> +            properties:
> +              bus-type:
> +                enum: [5, 6]
> +
> +            required:
> +              - bus-type
>  
>      anyOf:
>        - required:

-- 
Regards,

Laurent Pinchart
