Return-Path: <linux-kernel+bounces-153335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B298C8ACCC8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 368C2B223F2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D3B7E761;
	Mon, 22 Apr 2024 12:35:06 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3CE26286
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 12:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713789306; cv=none; b=bEuvpzeiQFeZ+2M/V3PLhiiCgu81uN5lT7gWbloWykHrGGnrnWWiNPuOY7uvWrBOZWyDo44Je3cFss6JALZyrZBXfaZMBYIkSN/O+9oIxTtqSC1Twc+QJosdrvU8FRrbtL3/HUwHn4Mr0A1/nqzM8g3NTk2/lpJa15U1+zLzNXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713789306; c=relaxed/simple;
	bh=Dvbbv2Euyl1iu4XSriZ6KMne/lsk0oCWL2ADEZMNJXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fD3QATbjR9PyINuargs1Boj2IbX8o22KmMbsD64XwnMywI4uovZSWm2ZMTUNDDDB1GjyMQcevbpVvPdD/sMmB9/TW+BwB4ROFOaVovWcFdbd/vPSnkBb/VcTqBb9wESpj26vRhCfdXAf7fbmlAJ+QH4GnYj+/bgt89NX556N3r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1ryssp-0005Bq-G4; Mon, 22 Apr 2024 14:34:55 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1ryssl-00Dh4a-6t; Mon, 22 Apr 2024 14:34:51 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1ryssl-0088Ib-0N;
	Mon, 22 Apr 2024 14:34:51 +0200
Date: Mon, 22 Apr 2024 14:34:51 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Andy Yan <andyshrk@163.com>
Cc: heiko@sntech.de, tzimmermann@suse.de, mripard@kernel.org,
	hjc@rock-chips.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH 1/1] drm/rockchip: vop2: Fix the port mux of VP2
Message-ID: <ZiZZaxr1KTmWc9CM@pengutronix.de>
References: <20240422101905.32703-1-andyshrk@163.com>
 <20240422101905.32703-2-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422101905.32703-2-andyshrk@163.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2024 at 06:19:05PM +0800, Andy Yan wrote:
> From: Andy Yan <andy.yan@rock-chips.com>
> 
> The port mux of VP2 should be RK3568_OVL_PORT_SET__PORT2_MUX.
> 
> Fixes: 604be85547ce ("drm/rockchip: Add VOP2 driver")
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

> 
> ---
> 
>  drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> index 97b0ab4b6db8..1f4250de570f 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> @@ -2377,7 +2377,7 @@ static void vop2_setup_layer_mixer(struct vop2_video_port *vp)
>  		port_sel |= FIELD_PREP(RK3568_OVL_PORT_SET__PORT2_MUX,
>  			(vp2->nlayers + vp1->nlayers + vp0->nlayers - 1));
>  	else
> -		port_sel |= FIELD_PREP(RK3568_OVL_PORT_SET__PORT1_MUX, 8);
> +		port_sel |= FIELD_PREP(RK3568_OVL_PORT_SET__PORT2_MUX, 8);
>  
>  	layer_sel = vop2_readl(vop2, RK3568_OVL_LAYER_SEL);
>  
> -- 
> 2.34.1
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

