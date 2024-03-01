Return-Path: <linux-kernel+bounces-87961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFEE86DB84
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 07:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE9EFB21BAB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 06:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0F067E63;
	Fri,  1 Mar 2024 06:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="pac3JJdo"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D7D67C4D
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 06:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709274872; cv=none; b=HT9NFWMfSB5sL2NZUiikewL8Y315DQonvr9BQ3iUj6VlX5LJYAZFOcN8qYEU2FVtQRs+zU5fYZZvB7Y1R3ACQj2M5uFNdlQUT6U9oIzhx6eNHmmlNH2vT6ni6uR8qDynbwsEgN8p99TdUe1U0GvcHp5EVCoLn0ygUXhRYZO8dx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709274872; c=relaxed/simple;
	bh=SmdKxeIixIsAU0Agzo28Zt1EVfMxmohDwoG9rgI9Tf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W+OAEBbpMZjLz2hTHRi8wGzFsRKxOwVzR+BejpYA/L4UWDPLHFIZhb31OAuh6vz6A3tQnCq2Bb56YgyI4FOtZJPrP3Ti87PH7ewg3B+84VzWELBngJoetmeFLkNLqX9C+P9QwKflehWhYs3s/4G1g215arN2Sz9MGF/ZgvL5y1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=pac3JJdo; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (89-27-53-110.bb.dnainternet.fi [89.27.53.110])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7CD8D899;
	Fri,  1 Mar 2024 07:34:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1709274854;
	bh=SmdKxeIixIsAU0Agzo28Zt1EVfMxmohDwoG9rgI9Tf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pac3JJdoVeVMXCMqjgYq+cC4iQ50HdypMFlLzAlmNCG5D6fdnKMBMkkO0Tfs6LfHx
	 7kmQjPrOxANvmFFCdcZqHetxKvt9rCWvWdpvJaXptcZmRhL73spTZwRaceDqP3XOPY
	 hTDFj4MG0ONIdOkReqUW7IRlAG23dMyEj4DutZtc=
Date: Fri, 1 Mar 2024 08:34:31 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	owen <qwt9588@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
	Marek Vasut <marex@denx.de>,
	Adrien Grassein <adrien.grassein@gmail.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Vinay Simha BN <simhavcs@gmail.com>,
	Christopher Vollo <chris@renewoutreach.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
	kernel@collabora.com, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 0/9] drm: Switch from dev_err to dev_err_probe for
 missing DSI host error path
Message-ID: <20240301063431.GM30889@pendragon.ideasonboard.com>
References: <20240229-anx7625-defer-log-no-dsi-host-v2-0-00506941049a@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240229-anx7625-defer-log-no-dsi-host-v2-0-00506941049a@collabora.com>

Hi Nícolas,

On Thu, Feb 29, 2024 at 07:12:06PM -0500, Nícolas F. R. A. Prado wrote:
> This series changes every occurence of the following pattern: 
> 
> 	dsi_host = of_find_mipi_dsi_host_by_node(dsi);
> 	if (!dsi_host) {
> 		dev_err(dev, "failed to find dsi host\n");
> 		return -EPROBE_DEFER;
> 	}
> 
> into
> 
> 	dsi_host = of_find_mipi_dsi_host_by_node(dsi);
> 	if (!dsi_host)
> 		return dev_err_probe(dev, -EPROBE_DEFER, "failed to find dsi host\n");
> 
> This registers the defer probe reason (so it can later be printed by the
> driver core or checked on demand through the devices_deferred file in
> debugfs) and prevents errors to be spammed in the kernel log every time
> the driver retries to probe, unnecessarily alerting userspace about
> something that is a normal part of the boot process.

The idea is good, but I have a small issue with patches 1/9 to 7/9. They
all patch a function that is called by the probe function. Calling
dev_err_probe() in such functions is error-prone. I had to manually
check when reviewing the patches that those functions were indeed called
at probe time, and not through other code paths, and I also had to check
that no callers were using dev_err_probe() in the error handling path,
as that would have overridden the error message.

Would there be a way to move the dev_err_probe() to the top-level ? I
understand it's not always possible or convenient, but if it was doable
in at least some of the drivers, I think it would be better. I'll let
you be the judge.

> I have omitted a Fixes: tag in the last patch, for the truly-nt35597
> panel, because it predates the dev_err_probe() helper.
> 
> Changes in v2:
> - Added patches 2 onwards to fix all occurences of this pattern instead
>   of just for the anx7625 driver
> - Link to v1: https://lore.kernel.org/r/20240226-anx7625-defer-log-no-dsi-host-v1-1-242b1af31884@collabora.com
> 
> ---
> Nícolas F. R. A. Prado (9):
>       drm/bridge: anx7625: Don't log an error when DSI host can't be found
>       drm/bridge: icn6211: Don't log an error when DSI host can't be found
>       drm/bridge: lt8912b: Don't log an error when DSI host can't be found
>       drm/bridge: lt9611: Don't log an error when DSI host can't be found
>       drm/bridge: lt9611uxc: Don't log an error when DSI host can't be found
>       drm/bridge: tc358775: Don't log an error when DSI host can't be found
>       drm/bridge: dpc3433: Don't log an error when DSI host can't be found
>       drm/panel: novatek-nt35950: Don't log an error when DSI host can't be found
>       drm/panel: truly-nt35597: Don't log an error when DSI host can't be found
> 
>  drivers/gpu/drm/bridge/analogix/anx7625.c     |  6 ++----
>  drivers/gpu/drm/bridge/chipone-icn6211.c      |  6 ++----
>  drivers/gpu/drm/bridge/lontium-lt8912b.c      |  6 ++----
>  drivers/gpu/drm/bridge/lontium-lt9611.c       |  6 ++----
>  drivers/gpu/drm/bridge/lontium-lt9611uxc.c    |  6 ++----
>  drivers/gpu/drm/bridge/tc358775.c             |  6 ++----
>  drivers/gpu/drm/bridge/ti-dlpc3433.c          | 17 +++++++++--------
>  drivers/gpu/drm/panel/panel-novatek-nt35950.c |  6 ++----
>  drivers/gpu/drm/panel/panel-truly-nt35597.c   |  6 ++----
>  9 files changed, 25 insertions(+), 40 deletions(-)
> ---
> base-commit: 2ae0a045e6814c8c1d676d6153c605a65746aa29
> change-id: 20240226-anx7625-defer-log-no-dsi-host-c3f9ccbcb287

-- 
Regards,

Laurent Pinchart

