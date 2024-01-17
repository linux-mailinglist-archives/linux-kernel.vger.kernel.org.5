Return-Path: <linux-kernel+bounces-29077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B528307F2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 505CC1C24E41
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A4B208B6;
	Wed, 17 Jan 2024 14:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ZAvP4Nrg"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168B3208A6
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 14:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705501459; cv=none; b=Icx2Q0SsxZfK+oslRBHB+2BSyEhFvKfeSZvAvTLJOKCYoOcOtmlJAqsOBESpJi22oSaOj5xOhvP+HoWAhTXp43iEh3lOcUgMvc94Pn/ukmSr7rjt0LztxEX/Ed+R30zSwxCcCzBMjmwoORBtRXP835VVfZysN6o2f/QmtkwUzf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705501459; c=relaxed/simple;
	bh=Mp3GlUUoo01KnvzhVZ4uGnXB45N7hYQAgn8WLuIHFWg=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=B/yPBpGwC9Ln9LfEdp00Gyfj0wsVVFPL6QNMelKHsh1wBiPgzJHK7LuAD4Z+got9m7tBjFdjy1VblsEQJsQFsq4o8sDlSYgJsnXUJ/Zcw7k+rZ0rMK59btxsvpSQF2kvkkilNxd6lTLnLaJul7SH9Na9W741Pcp82KVIkNgtd0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=ZAvP4Nrg; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (89-27-53-110.bb.dnainternet.fi [89.27.53.110])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id DF5547EC;
	Wed, 17 Jan 2024 15:23:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1705501387;
	bh=Mp3GlUUoo01KnvzhVZ4uGnXB45N7hYQAgn8WLuIHFWg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZAvP4NrgylHtA2g5djrWcEdwtXZB1cAqCj2R2E7ke3jj3Dlehc6XREpG7y/5a8tt1
	 Lm6f64tQwV6VvzBEbU4yLB918ZJ5ZMDLJZWF6s8R47G9/eht7tNlOhCP4d8Cz4Qmua
	 XuKtSf7xgV1mM+h2vZG345z8Yy80X9J20pTZGLx4=
Date: Wed, 17 Jan 2024 16:24:20 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Anatoliy Klymenko <anatoliy.klymenko@amd.com>,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
	michal.simek@amd.com, dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] drm: xlnx: zynqmp_dpsub: Make drm bridge discoverable
Message-ID: <20240117142420.GE17920@pendragon.ideasonboard.com>
References: <20240112234222.913138-1-anatoliy.klymenko@amd.com>
 <20240112234222.913138-2-anatoliy.klymenko@amd.com>
 <98a9f4f1-dd55-47c3-bb1b-07e201b299cd@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <98a9f4f1-dd55-47c3-bb1b-07e201b299cd@ideasonboard.com>

On Wed, Jan 17, 2024 at 04:06:31PM +0200, Tomi Valkeinen wrote:
> On 13/01/2024 01:42, Anatoliy Klymenko wrote:
> > Assign device of node to bridge prior registering it. This will
> > make said bridge discoverable by separate crtc driver.
> 
> I think a few words on why this is needed (and why it wasn't needed 
> before) would be nice.
> 
> Other than that:
> 
> Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

Agreed. With a better commit message,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> > Signed-off-by: Anatoliy Klymenko <anatoliy.klymenko@amd.com>
> > ---
> >   drivers/gpu/drm/xlnx/zynqmp_dp.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> > index a0606fab0e22..d60b7431603f 100644
> > --- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
> > +++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> > @@ -1721,6 +1721,7 @@ int zynqmp_dp_probe(struct zynqmp_dpsub *dpsub)
> >   	bridge->ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID
> >   		    | DRM_BRIDGE_OP_HPD;
> >   	bridge->type = DRM_MODE_CONNECTOR_DisplayPort;
> > +	bridge->of_node = dp->dev->of_node;
> >   	dpsub->bridge = bridge;
> >   
> >   	/*

-- 
Regards,

Laurent Pinchart

