Return-Path: <linux-kernel+bounces-86366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E7586C47A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DF94B23749
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB49A56B92;
	Thu, 29 Feb 2024 09:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="NRPAskIc"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4F14D9E8
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 09:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709197516; cv=none; b=RZzbCVzuykhzUr2AugHQJ38g2ifPGx5N4RRvXUGy5AE8k5EICvFoFyp9G2kDzn4cla2hyw9L+QtIS8a2W/CZO14PXBtZwEdwMYi9at/17cqK9n0WOsVblPLccF6VCT4aLYstOFaKry6PKTaIhkwGZqAPi3hMZd4TKnNX2DXU4xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709197516; c=relaxed/simple;
	bh=SSDbhD8zVZFFRcHjVzOZVaCFdEnhF7KatMVUSwcuEs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XYgWd4eWShe8nHDg5EMs6gyQjW7P9q2w+YV1/VMJDhBHA+/lBvuYG9wDaD2RE+6M0+YNWcKI6Gt5uOIlwo3dLRulbWg/8X4rUgVfG00/YougXlat9Kx7LMNOlOqS52YWi/G/H4PsSGy69+mHTdyG9KI33k3s/Z9xYj0Xmt6C3NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=NRPAskIc; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (89-27-53-110.bb.dnainternet.fi [89.27.53.110])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id B8A2AE0C;
	Thu, 29 Feb 2024 10:04:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1709197496;
	bh=SSDbhD8zVZFFRcHjVzOZVaCFdEnhF7KatMVUSwcuEs8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NRPAskIckbv4heHEGnYwiaIjFpOWFnuMb3N08l/CJLOem6W+lGSxxivE0iXPD9W7/
	 QsYT9HEo5UnaE3+jCQ8nwywG0TYBeimV5G140ttSKzQalT/9LC9mEXyjcPVlmBTAKK
	 dK7JKXyg0N/6QqeEwWj2QFhVs8pSmiV3ZCp2llkY=
Date: Thu, 29 Feb 2024 11:05:11 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Rohit Visavalia <rohit.visavalia@amd.com>,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
	michal.simek@amd.com, dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: xlnx: dp: Reset DisplayPort IP
Message-ID: <20240229090511.GG1659@pendragon.ideasonboard.com>
References: <20240216124043.1226713-1-rohit.visavalia@amd.com>
 <20240228162224.GG9863@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240228162224.GG9863@pendragon.ideasonboard.com>

Tomi, could you push this through drm-misc ?

On Wed, Feb 28, 2024 at 06:22:25PM +0200, Laurent Pinchart wrote:
> Hello Rohit,
> 
> Thank you for the patch.
> 
> On Fri, Feb 16, 2024 at 04:40:43AM -0800, Rohit Visavalia wrote:
> > Assert DisplayPort reset signal before deasserting,
> > it is to clear out any registers programmed before booting kernel.
> > 
> > Signed-off-by: Rohit Visavalia <rohit.visavalia@amd.com>
> > ---
> >  drivers/gpu/drm/xlnx/zynqmp_dp.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> > index 1846c4971fd8..5a40aa1d4283 100644
> > --- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
> > +++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> > @@ -1714,6 +1714,10 @@ int zynqmp_dp_probe(struct zynqmp_dpsub *dpsub)
> >  		goto err_free;
> >  	}
> >  
> > +	ret = zynqmp_dp_reset(dp, true);
> > +	if (ret < 0)
> > +		return ret;
> > +
> 
> This looks fine to me, so
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> However, looking at zynqmp_dp_reset(), we have
> 
> static int zynqmp_dp_reset(struct zynqmp_dp *dp, bool assert)
> {
> 	unsigned long timeout;
> 
> 	if (assert)
> 		reset_control_assert(dp->reset);
> 	else
> 		reset_control_deassert(dp->reset);
> 
> 	/* Wait for the (de)assert to complete. */
> 	timeout = jiffies + msecs_to_jiffies(RST_TIMEOUT_MS);
> 	while (!time_after_eq(jiffies, timeout)) {
> 		bool status = !!reset_control_status(dp->reset);
> 
> 		if (assert == status)
> 			return 0;
> 
> 		cpu_relax();
> 	}
> 
> 	dev_err(dp->dev, "reset %s timeout\n", assert ? "assert" : "deassert");
> 	return -ETIMEDOUT;
> }
> 
> That doesn't seem quite right. Aren't reset_control_assert() and
> reset_control_deassert() supposed to be synchronous ? If so there should
> be no need to wait, and if there's a need to wait, it could be a bug in
> the reset controller driver. This should be fixed, and then the code in
> probe could be replaced with a call to reset_control_reset().
> 
> >  	ret = zynqmp_dp_reset(dp, false);
> >  	if (ret < 0)
> >  		goto err_free;

-- 
Regards,

Laurent Pinchart

