Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 549D079E094
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 09:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238533AbjIMHPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 03:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238367AbjIMHPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 03:15:45 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C3D171727;
        Wed, 13 Sep 2023 00:15:41 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id E0BB78088;
        Wed, 13 Sep 2023 07:15:40 +0000 (UTC)
Date:   Wed, 13 Sep 2023 10:15:39 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Andreas Kemnade <andreas@kemnade.info>,
        Sebastian Reichel <sre@kernel.org>
Cc:     tomi.valkeinen@ideasonboard.com, airlied@gmail.com,
        daniel@ffwll.ch, u.kleine-koenig@pengutronix.de, arnd@arndb.de,
        laurent.pinchart@ideasonboard.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [RFC PATCH] drm: omapdrm: dsi: add refsel also for omap4
Message-ID: <20230913071539.GD5285@atomide.com>
References: <20230913065911.1551166-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913065911.1551166-1-andreas@kemnade.info>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andreas Kemnade <andreas@kemnade.info> [230913 06:59]:
> Some 3.0 source has it set behind a if (omap4).
> Maybe it is helpful maybe not, at least in the omap4460
> trm these bits are marked as reserved.
> But maybe some dsi video mode panel starts magically working.

Interesting. So Andreas mentioned that dsi video mode works on omap5
but not on omap4. Adding Sebastian to the list too.

Regards,

Tony

> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  drivers/gpu/drm/omapdrm/dss/dsi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/dss/dsi.c
> index 60189a23506a1..e2f576cd9f63c 100644
> --- a/drivers/gpu/drm/omapdrm/dss/dsi.c
> +++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
> @@ -4505,7 +4505,7 @@ static const struct dss_pll_hw dss_omap4_dsi_pll_hw = {
>  	.has_stopmode = true,
>  	.has_freqsel = false,
>  	.has_selfreqdco = false,
> -	.has_refsel = false,
> +	.has_refsel = true,
>  };
>  
>  static const struct dss_pll_hw dss_omap5_dsi_pll_hw = {
> -- 
> 2.39.2
> 
