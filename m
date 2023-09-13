Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3277479E7AA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 14:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234520AbjIMMLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 08:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240371AbjIMMLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 08:11:19 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC6819A8;
        Wed, 13 Sep 2023 05:11:14 -0700 (PDT)
Received: from [192.168.88.20] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 01C0DBEB;
        Wed, 13 Sep 2023 14:09:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1694606979;
        bh=UeFdlu2oKUftOF98iCKd1KzwJ9Kg3oJeD3NVvC7NQFo=;
        h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
        b=Tyz8o+uXQ2MS5aTNhKirIoFfduj3Wnc1TSOGnHE4otufVm526erBjYzW0Agk2ZFRa
         EC/SxoblTAcWOHBV5kw9P5Z39NSQfYWhpzy8hCt1abB679g4701n2iRh+gsy3tDojo
         2koZTEoM+Wm044E+ZhMZldVrNn7tEXvp9MQIKTbs=
Message-ID: <48972ab0-e4ed-11b2-31fb-ad93695a4db1@ideasonboard.com>
Date:   Wed, 13 Sep 2023 15:11:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC PATCH] drm: omapdrm: dsi: add refsel also for omap4
Content-Language: en-US
To:     Andreas Kemnade <andreas@kemnade.info>
References: <20230913065911.1551166-1-andreas@kemnade.info>
Cc:     airlied@gmail.com, daniel@ffwll.ch, u.kleine-koenig@pengutronix.de,
        arnd@arndb.de, laurent.pinchart@ideasonboard.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
        Sebastian Reichel <sre@kernel.org>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20230913065911.1551166-1-andreas@kemnade.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2023 09:59, Andreas Kemnade wrote:
> Some 3.0 source has it set behind a if (omap4).
> Maybe it is helpful maybe not, at least in the omap4460
> trm these bits are marked as reserved.
> But maybe some dsi video mode panel starts magically working.

Sorry, what does this mean? That this fixes something, or you are just 
guessing?

I'm somewhat sure that the upstream driver used to work on omap4 sdp, 
which has two DSI panels. But I can't even remember what omap4 version 
it had.

  Tomi

> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>   drivers/gpu/drm/omapdrm/dss/dsi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/dss/dsi.c
> index 60189a23506a1..e2f576cd9f63c 100644
> --- a/drivers/gpu/drm/omapdrm/dss/dsi.c
> +++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
> @@ -4505,7 +4505,7 @@ static const struct dss_pll_hw dss_omap4_dsi_pll_hw = {
>   	.has_stopmode = true,
>   	.has_freqsel = false,
>   	.has_selfreqdco = false,
> -	.has_refsel = false,
> +	.has_refsel = true,
>   };
>   
>   static const struct dss_pll_hw dss_omap5_dsi_pll_hw = {

