Return-Path: <linux-kernel+bounces-90443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5898C86FF3A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A89B1C20FA3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1084037157;
	Mon,  4 Mar 2024 10:40:11 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7597376ED
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 10:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709548810; cv=none; b=Pd5IssqhVBQ/AQ+k1u8wuRZfMzelq+1zef7YTcRhNDy+3Cg65Ma/XCww01Za332hqJxfHyWpPoxBndTX/tNm90AnZVysrwG+Y5E1X2hRtTjN5SBs/HA2G4AHrgdbvLElDXgqtb1DBRIYJG0IBQ6893ItXA1sJhCDpISq9Bbr1h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709548810; c=relaxed/simple;
	bh=kfBtYh4drUMQ3asFQT8eQUUnA6GyJDKrGF4zgKn3+ZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gQzl4Pazmt+1jIKXz1wdfcKMlyweCTogQoUxvRMIg/qpk0N8yAfq5NPEAp7GFFIksbfHrWUjPLbYrbsDn7cuSsZm73Fbfp8mZ35/4c0xTjOUJ0waVrHkbrogCbjmJK3umXVHOpsrYFXIjYmD4j8AkL2Kc0aW/2ud0kx9DBk/qCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1rh5jp-0005kV-8r; Mon, 04 Mar 2024 11:40:05 +0100
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1rh5jl-004Kjc-W0; Mon, 04 Mar 2024 11:40:02 +0100
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1rh5jl-001rVn-2t;
	Mon, 04 Mar 2024 11:40:01 +0100
Date: Mon, 4 Mar 2024 11:40:01 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Andy Yan <andyshrk@163.com>
Cc: heiko@sntech.de, hjc@rock-chips.com, dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH] drm/rockchip: vop2: Remove AR30 and AB30 format support
Message-ID: <ZeWlAWLvlW3NdKS_@pengutronix.de>
References: <20240304100952.3592984-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304100952.3592984-1-andyshrk@163.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2024 at 06:09:52PM +0800, Andy Yan wrote:
> From: Andy Yan <andy.yan@rock-chips.com>
> 
> The Alpha blending for 30 bit RGB/BGR are not
> functioning properly for rk3568/rk3588, so remove
> it from the format list.
> 
> Fixes: bfd8a5c228fa ("drm/rockchip: vop2: Add more supported 10bit formats")
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> ---

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

> 
>  drivers/gpu/drm/rockchip/rockchip_vop2_reg.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
> index 48170694ac6b..18efb3fe1c00 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
> @@ -17,9 +17,7 @@
>  
>  static const uint32_t formats_cluster[] = {
>  	DRM_FORMAT_XRGB2101010,
> -	DRM_FORMAT_ARGB2101010,
>  	DRM_FORMAT_XBGR2101010,
> -	DRM_FORMAT_ABGR2101010,
>  	DRM_FORMAT_XRGB8888,
>  	DRM_FORMAT_ARGB8888,
>  	DRM_FORMAT_XBGR8888,
> -- 
> 2.34.1
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

