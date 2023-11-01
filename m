Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100F87DE205
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 15:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbjKANyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 09:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKANyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 09:54:50 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30782C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 06:54:46 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3220D8D;
        Wed,  1 Nov 2023 14:54:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1698846868;
        bh=yNCpCVMpfXI7srTI32VeMvlAPheYtU2vtm2As3cwhGM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EsLGcTKLxRxpRkjwtTkDsVh+TeiHlD3YKH5pNQybBr2tvQ3A5XaY/KTXqja5EWjN4
         1CGLjD3mFP93vw0qs2ZjO6Se4psS7yDrn3Zq2xqhXbNkMHE2HecAZxrvfvUWTHIk8N
         cz/bEvLdVlUz6LOeY8gxeaCixiVne+I74KfWYW3M=
Date:   Wed, 1 Nov 2023 15:54:51 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     Aradhya Bhatia <a-bhatia1@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/10] drm/tidss: Drop useless variable init
Message-ID: <20231101135451.GS12764@pendragon.ideasonboard.com>
References: <20231101-tidss-probe-v1-0-45149e0f9415@ideasonboard.com>
 <20231101-tidss-probe-v1-3-45149e0f9415@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231101-tidss-probe-v1-3-45149e0f9415@ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomi,

Thank you for the patch.

On Wed, Nov 01, 2023 at 11:17:40AM +0200, Tomi Valkeinen wrote:
> No need to initialize the ret to 0 in dispc_softreset().
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/tidss/tidss_dispc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
> index 9d9dee7abaef..ad7999434299 100644
> --- a/drivers/gpu/drm/tidss/tidss_dispc.c
> +++ b/drivers/gpu/drm/tidss/tidss_dispc.c
> @@ -2705,7 +2705,7 @@ static void dispc_init_errata(struct dispc_device *dispc)
>  static void dispc_softreset(struct dispc_device *dispc)
>  {
>  	u32 val;
> -	int ret = 0;
> +	int ret;
>  
>  	/* Soft reset */
>  	REG_FLD_MOD(dispc, DSS_SYSCONFIG, 1, 1, 1);
> 

-- 
Regards,

Laurent Pinchart
