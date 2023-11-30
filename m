Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C44E7FF085
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 14:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345659AbjK3Npl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 08:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345533AbjK3Npk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 08:45:40 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C00C4;
        Thu, 30 Nov 2023 05:45:46 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8C80155;
        Thu, 30 Nov 2023 14:45:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1701351907;
        bh=XHpARKgcvdjeAqbtIxtvOde4zZgRWl+NFysb0Gz1TpI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ox4zOnnGPuQWmJwVUbeyvRZWzI2YNcP8mXjBQ9GlN7B45LOxdmpB75fncpTJzv6X4
         bUnOrXo9MY1a/MkSyXx2fijg8PJv1AEHuNurpX+O9OyUP5kVscyupg3kUkZg+ZH2Vr
         /n+g0BvDG8wle0BfT+1NOcUcdBfw/HkJg85dFsNM=
Date:   Thu, 30 Nov 2023 15:45:50 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Paul Elder <paul.elder@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        kieran.bingham@ideasonboard.com, tomi.valkeinen@ideasonboard.com,
        umang.jain@ideasonboard.com, Dafna Hirschfeld <dafna@fastmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] media: rkisp1: regs: Consolidate MI interrupt wrap
 fields
Message-ID: <20231130134550.GN8402@pendragon.ideasonboard.com>
References: <20231129092956.250129-1-paul.elder@ideasonboard.com>
 <20231129092956.250129-2-paul.elder@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231129092956.250129-2-paul.elder@ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

Thank you for the patch.

On Wed, Nov 29, 2023 at 06:29:54PM +0900, Paul Elder wrote:
> Consolidate the wraparound fields in the memory interface interrupt
> status registers, so that it can be more succinctly expressed by taking
> the stream ID (main or self) as a parameter.
> 
> Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/media/platform/rockchip/rkisp1/rkisp1-regs.h | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-regs.h b/drivers/media/platform/rockchip/rkisp1/rkisp1-regs.h
> index 350f452e676f..bea69a0d766a 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-regs.h
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-regs.h
> @@ -172,12 +172,9 @@
>  #define RKISP1_CIF_MI_FRAME(stream)			BIT((stream)->id)
>  #define RKISP1_CIF_MI_MBLK_LINE				BIT(2)
>  #define RKISP1_CIF_MI_FILL_MP_Y				BIT(3)
> -#define RKISP1_CIF_MI_WRAP_MP_Y				BIT(4)
> -#define RKISP1_CIF_MI_WRAP_MP_CB			BIT(5)
> -#define RKISP1_CIF_MI_WRAP_MP_CR			BIT(6)
> -#define RKISP1_CIF_MI_WRAP_SP_Y				BIT(7)
> -#define RKISP1_CIF_MI_WRAP_SP_CB			BIT(8)
> -#define RKISP1_CIF_MI_WRAP_SP_CR			BIT(9)
> +#define RKISP1_CIF_MI_WRAP_Y(stream)			BIT(4 + (stream)->id * 3)
> +#define RKISP1_CIF_MI_WRAP_CB(stream)			BIT(5 + (stream)->id * 3)
> +#define RKISP1_CIF_MI_WRAP_CR(stream)			BIT(6 + (stream)->id * 3)
>  #define RKISP1_CIF_MI_DMA_READY				BIT(11)
>  
>  /* MI_STATUS */

-- 
Regards,

Laurent Pinchart
