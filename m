Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8ADC78E6FD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 09:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236347AbjHaHN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 03:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244528AbjHaHNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 03:13:25 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36362CD6;
        Thu, 31 Aug 2023 00:13:19 -0700 (PDT)
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 58E87836;
        Thu, 31 Aug 2023 09:11:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1693465913;
        bh=eWvI9XuuHEwFgOsSGQ/WEcOhDhVjNa8y7Y5Ie0Lx9Gw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h7p95+vmq6/RjUgHQRz6pzBv9+nKeM5DVOqRJZcIKtYZfwz83YJnvXiYqX9ocdeFP
         hS0zQVTdACL1LIA13F0sbn874oJAwFRaNOsPuujTT9ezGzKJj2ut4gcsgTG7LsuFVP
         WTgwUWh4XcyAShJhdZP5bnyy56nvJ5NoKtABZxUE=
Date:   Thu, 31 Aug 2023 10:13:26 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: Re: [PATCH] media: i2c: max9286: Remove an incorrect
 fwnode_handle_put() call
Message-ID: <20230831071326.GB2698@pendragon.ideasonboard.com>
References: <26387273c902ce938a25647b6ccd9b8584284096.1693428894.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <26387273c902ce938a25647b6ccd9b8584284096.1693428894.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

Thank you for the patch.

On Wed, Aug 30, 2023 at 10:57:36PM +0200, Christophe JAILLET wrote:
> The commit in Fixes has removed an fwnode_handle_put() call in the error
> handling path of max9286_v4l2_register().
> 
> Remove the same call from max9286_v4l2_unregister().
> 
> Fixes: 1029939b3782 ("media: v4l: async: Simplify async sub-device fwnode matching")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
>  drivers/media/i2c/max9286.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/media/i2c/max9286.c b/drivers/media/i2c/max9286.c
> index f27a69b1b727..fc1cf196ef01 100644
> --- a/drivers/media/i2c/max9286.c
> +++ b/drivers/media/i2c/max9286.c
> @@ -1110,7 +1110,6 @@ static int max9286_v4l2_register(struct max9286_priv *priv)
>  
>  static void max9286_v4l2_unregister(struct max9286_priv *priv)
>  {
> -	fwnode_handle_put(priv->sd.fwnode);
>  	v4l2_ctrl_handler_free(&priv->ctrls);
>  	v4l2_async_unregister_subdev(&priv->sd);
>  	max9286_v4l2_notifier_unregister(priv);

-- 
Regards,

Laurent Pinchart
