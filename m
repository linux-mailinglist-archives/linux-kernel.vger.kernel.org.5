Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04E5808602
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235215AbjLGKFg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 7 Dec 2023 05:05:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235217AbjLGKFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 05:05:31 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9610E128
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 02:05:37 -0800 (PST)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1rBBG7-00013L-IN; Thu, 07 Dec 2023 11:05:31 +0100
Message-ID: <092107b1490b4c1b4ba5f2b60993e452c932f4a3.camel@pengutronix.de>
Subject: Re: [PATCH] drm/etnaviv: add sensitive state for
 PE_RT_ADDR_4_PIPE(3, 0|1) address
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Christian Gmeiner <christian.gmeiner@gmail.com>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Christian Gmeiner <cgmeiner@igalia.com>,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 07 Dec 2023 11:05:30 +0100
In-Reply-To: <20231207074308.393008-1-christian.gmeiner@gmail.com>
References: <20231207074308.393008-1-christian.gmeiner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, dem 07.12.2023 um 08:43 +0100 schrieb Christian Gmeiner:
> From: Christian Gmeiner <cgmeiner@igalia.com>
> 
> 0x1540 is the address of 4th render target address pair (two pixel pipes).
> 
Are there any corresponding TS states for this region?

Regards,
Lucas

> Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_cmd_parser.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_cmd_parser.c b/drivers/gpu/drm/etnaviv/etnaviv_cmd_parser.c
> index b106e8b288ad..9bf47327f436 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_cmd_parser.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_cmd_parser.c
> @@ -54,6 +54,7 @@ static const struct {
>  	ST(0x1480, 8),
>  	ST(0x1500, 8),
>  	ST(0x1520, 8),
> +	ST(0x1540, 8),
>  	ST(0x1608, 1),
>  	ST(0x1610, 1),
>  	ST(0x1658, 1),

