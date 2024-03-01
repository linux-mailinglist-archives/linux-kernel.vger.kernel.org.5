Return-Path: <linux-kernel+bounces-89158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6251386EB56
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 22:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FB751C2140E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E445823B;
	Fri,  1 Mar 2024 21:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Wvw6d+Ef"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230AC25623
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 21:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709329479; cv=none; b=bw2gmxJJf+51BhtBXIslgcJNxJxhMpva2YB+FxKuTuSQQ+UjVim7oVhx6JesdFGWapdHrthVH+2GGHV1rZHhx0weoJVJYT0uPbT3ndd38nry4JOqftScI7JHpTgVIyVgTWLSchyHyIsIIjNAxIcC4P6/6/idoCbheJSEjW/mLqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709329479; c=relaxed/simple;
	bh=2xY5RVyUcdnRzDiqOnWZP2xAM6fMoZ6RnVVMw7ZnaNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmSGpet0DcK9A5XIBxS7Ws+CUb9PM9sDW0XhH1hF1TUHbunWJc3b7Xs1JyGfTefCyVZ9NToRnt9Ph4UZ+8QdEwefm1cFwVtMK3iSyfKYue1SBBn7xbmr78fqoW+h3Ff5+HrUbpmQEI75a/9CQteBCYxd4QSMJegRJ0yqGWVAhwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Wvw6d+Ef; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (89-27-53-110.bb.dnainternet.fi [89.27.53.110])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9776B673;
	Fri,  1 Mar 2024 22:44:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1709329461;
	bh=2xY5RVyUcdnRzDiqOnWZP2xAM6fMoZ6RnVVMw7ZnaNg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wvw6d+Efg4zfPGiPhEdGGpTNTVwkssBWr7Pfr/mjCFp0adU5FNIwJf9ti6hDNGV7k
	 d6ZonBUAjGiiCSAk84BGvNuOTSsMXQtTz/X5ZB3AG8XaGC47dDxUDMQKxy4bhyOpQP
	 RT7qkhWoGTpE1wDaryq4bnW4Abc6SbIXm+MvA5vE=
Date: Fri, 1 Mar 2024 23:44:38 +0200
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
Message-ID: <20240301214438.GA11073@pendragon.ideasonboard.com>
References: <20240229-anx7625-defer-log-no-dsi-host-v2-0-00506941049a@collabora.com>
 <20240301063431.GM30889@pendragon.ideasonboard.com>
 <33209063-de58-4d53-a6e0-2d9f74052358@notapiano>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <33209063-de58-4d53-a6e0-2d9f74052358@notapiano>

On Fri, Mar 01, 2024 at 11:19:27AM -0500, Nícolas F. R. A. Prado wrote:
> On Fri, Mar 01, 2024 at 08:34:31AM +0200, Laurent Pinchart wrote:
> > Hi Nícolas,
> > 
> > On Thu, Feb 29, 2024 at 07:12:06PM -0500, Nícolas F. R. A. Prado wrote:
> > > This series changes every occurence of the following pattern: 
> > > 
> > > 	dsi_host = of_find_mipi_dsi_host_by_node(dsi);
> > > 	if (!dsi_host) {
> > > 		dev_err(dev, "failed to find dsi host\n");
> > > 		return -EPROBE_DEFER;
> > > 	}
> > > 
> > > into
> > > 
> > > 	dsi_host = of_find_mipi_dsi_host_by_node(dsi);
> > > 	if (!dsi_host)
> > > 		return dev_err_probe(dev, -EPROBE_DEFER, "failed to find dsi host\n");
> > > 
> > > This registers the defer probe reason (so it can later be printed by the
> > > driver core or checked on demand through the devices_deferred file in
> > > debugfs) and prevents errors to be spammed in the kernel log every time
> > > the driver retries to probe, unnecessarily alerting userspace about
> > > something that is a normal part of the boot process.
> > 
> > The idea is good, but I have a small issue with patches 1/9 to 7/9. They
> > all patch a function that is called by the probe function. Calling
> > dev_err_probe() in such functions is error-prone. I had to manually
> > check when reviewing the patches that those functions were indeed called
> > at probe time, and not through other code paths, and I also had to check
> > that no callers were using dev_err_probe() in the error handling path,
> > as that would have overridden the error message.
> > 
> > Would there be a way to move the dev_err_probe() to the top-level ? I
> > understand it's not always possible or convenient, but if it was doable
> > in at least some of the drivers, I think it would be better. I'll let
> > you be the judge.
> 
> Hey Laurent, thanks for the review.
> 
> I get where you're coming from, as I checked those things myself while writing
> the patch. That said, I don't think moving dev_err_probe() to the top-level is a
> good move for a few reasons:
> * Keeping the log message as close to the source of the error makes it more
>   specific, and consequently, more useful.
> * The original code already returned -EPROBE_DEFER, implying the function is
>   expected to be called only from the probe function.
> 
> With those points in mind, the only way I see to guarantee
> dev_err_probe(...,-EPROBE_DEFER...) would only be called by probe, and that the
> reason wouldn't be overriden, would be to move the entire code path of that
> function that calls into dev_err_probe() up into the probe function. But if we
> adopt this pattern consistently across the drivers in the tree, I think it would
> drastically worsen readability and cancel out the benefits.
> 
> IMO the way forward with the API we have, is to make use of warnings and static
> checkers to catch cases where dev_err_probe() is overriding a defer probe
> reason, and where it's called outside of the probe function scope.
> 
> So I'm inclined to leave the patches as they are, but am happy to discuss this
> further or other ideas.

Thanks for checking and having taken the time to explain your rationale.
For the whole series,

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

-- 
Regards,

Laurent Pinchart

