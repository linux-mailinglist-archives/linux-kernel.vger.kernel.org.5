Return-Path: <linux-kernel+bounces-131484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DA089887E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E91481C219FE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22F7126F14;
	Thu,  4 Apr 2024 13:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="UlX11CBc"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB2DEDF;
	Thu,  4 Apr 2024 13:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712235992; cv=none; b=s/pmHtz+Tz1eZnUGOiuAtMdmVpBuhvp7vdrJ8BleC2vYhjgYr0ahOzbAuRzsz4MW5Eu7aA/J/Ir2uDHtqkwSnNPfIrp0+MF/BC3IzcThCn46RR9uVpyDPQDEfn0SB1Ru1aJ+iT48OjgVqgzkP8SRFqXZV0Lw+u2cBMz/40I9hDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712235992; c=relaxed/simple;
	bh=ZRsavzhW10pJrzrIUzatwiLvBsHnlXzVm/wUUnMRN8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fuu76ut5T3naMTRCYMSzyrOjmcnU3fxbda7rU42V6ELoVwnzl3zAc0xq36dmNqjI6f7cpv9Wm1W1dIQFrPe6hApn65bCtrOAeJ/2jXqTMotuK6bH6DjyljukNPccp93rJO+wZU28ueBaJNiWB+uCUX+oP+nKrHVqSYZ0AB45XQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=UlX11CBc; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id E5B0912D;
	Thu,  4 Apr 2024 15:05:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712235951;
	bh=ZRsavzhW10pJrzrIUzatwiLvBsHnlXzVm/wUUnMRN8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UlX11CBc1gZDcf8RyVMYTVH+zpGpFg/BlCrFMB3qErusgym895IY9Ls6BV36uw43b
	 XN8hcj8iUhC9ElrDFdjq16mrb0PIUvW6njvQEyfyQEkXvQP/HwJbeBq3BlYGMDz6ek
	 A8lxkyyOsa/16fQT0dhWjJ0Jc/NAvGuVlQzk0ReY=
Date: Thu, 4 Apr 2024 16:06:17 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Umang Jain <umang.jain@ideasonboard.com>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] media: subdev: Improve
 v4l2_subdev_enable/disable_streams_fallback
Message-ID: <20240404130617.GR23803@pendragon.ideasonboard.com>
References: <20240404-enable-streams-impro-v1-0-1017a35bbe07@ideasonboard.com>
 <20240404-enable-streams-impro-v1-3-1017a35bbe07@ideasonboard.com>
 <Zg6anfpQt80gSKjN@kekkonen.localdomain>
 <a5ea5844-a7ba-408b-8007-2000dc94be24@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a5ea5844-a7ba-408b-8007-2000dc94be24@ideasonboard.com>

On Thu, Apr 04, 2024 at 03:38:45PM +0300, Tomi Valkeinen wrote:
> On 04/04/2024 15:18, Sakari Ailus wrote:
> > On Thu, Apr 04, 2024 at 01:50:02PM +0300, Tomi Valkeinen wrote:
> >> v4l2_subdev_enable/disable_streams_fallback() supports falling back to
> >> .s_stream() for subdevs with a single source pad. It also tracks the
> >> enabled streams for that one pad in the sd->enabled_streams field.
> >>
> >> Tracking the enabled streams with sd->enabled_streams does not make
> >> sense, as with .s_stream() there can only be a single stream per pad.
> >> Thus, as the v4l2_subdev_enable/disable_streams_fallback() only supports
> >> a single source pad, all we really need is a boolean which tells whether
> >> streaming has been enabled on this pad or not.
> >>
> >> However, as we only need a true/false state for a pad (instead of
> >> tracking which streams have been enabled for a pad), we can easily
> >> extend the fallback mechanism to support multiple source pads as we only
> >> need to keep track of which pads have been enabled.
> >>
> >> Change the sd->enabled_streams field to sd->enabled_pads, which is a
> >> 64-bit bitmask tracking the enabled source pads. With this change we can
> >> remove the restriction that
> >> v4l2_subdev_enable/disable_streams_fallback() only supports a single
> >> soruce pad.

s/soruce/source/

> >>
> >> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> >> ---
> >>   drivers/media/v4l2-core/v4l2-subdev.c | 68 ++++++++++++++++++++---------------
> >>   include/media/v4l2-subdev.h           |  9 +++--
> >>   2 files changed, 44 insertions(+), 33 deletions(-)
> >>
> >> diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
> >> index 3b3310bce5d4..91298bb84e6b 100644
> >> --- a/drivers/media/v4l2-core/v4l2-subdev.c
> >> +++ b/drivers/media/v4l2-core/v4l2-subdev.c
> >> @@ -2090,37 +2090,43 @@ static int v4l2_subdev_enable_streams_fallback(struct v4l2_subdev *sd, u32 pad,
> >>   					       u64 streams_mask)
> >>   {
> >>   	struct device *dev = sd->entity.graph_obj.mdev->dev;
> >> -	unsigned int i;
> >>   	int ret;
> >>   
> >>   	/*
> >>   	 * The subdev doesn't implement pad-based stream enable, fall back
> >> -	 * on the .s_stream() operation. This can only be done for subdevs that
> >> -	 * have a single source pad, as sd->enabled_streams is global to the
> >> -	 * subdev.
> >> +	 * on the .s_stream() operation.

While at it, s/on/to/

Same below.

> >>   	 */
> >>   	if (!(sd->entity.pads[pad].flags & MEDIA_PAD_FL_SOURCE))
> >>   		return -EOPNOTSUPP;
> >>   
> >> -	for (i = 0; i < sd->entity.num_pads; ++i) {
> >> -		if (i != pad && sd->entity.pads[i].flags & MEDIA_PAD_FL_SOURCE)
> >> -			return -EOPNOTSUPP;
> >> -	}
> >> +	/*
> >> +	 * .s_stream() means there is no streams support, so only allowed stream
> >> +	 * is the imlicit stream 0.

s/imlicit/implicit/

Same below.

> >> +	 */
> >> +	if (streams_mask != BIT_ULL(0))
> >> +		return -EOPNOTSUPP;
> >> +
> >> +	/*
> >> +	 * We use a 64-bit bitmask for tracking enabled pads, so only subdevices
> >> +	 * with 64 pads or less can be supported.
> >> +	 */
> >> +	if (pad >= sizeof(sd->enabled_pads) * 8)
> > 
> > s/8/BITS_PER_BYTE/
> > 
> >> +		return -EOPNOTSUPP;
> >>   
> >> -	if (sd->enabled_streams & streams_mask) {
> >> -		dev_dbg(dev, "set of streams %#llx already enabled on %s:%u\n",
> >> -			streams_mask, sd->entity.name, pad);
> >> +	if (sd->enabled_pads & BIT_ULL(pad)) {
> >> +		dev_dbg(dev, "pad %u already enabled on %s\n",
> >> +			pad, sd->entity.name);
> >>   		return -EALREADY;
> >>   	}
> >>   
> >> -	/* Start streaming when the first streams are enabled. */
> >> -	if (!sd->enabled_streams) {
> >> +	/* Start streaming when the first pad is enabled. */
> >> +	if (!sd->enabled_pads) {
> >>   		ret = v4l2_subdev_call(sd, video, s_stream, 1);
> >>   		if (ret)
> >>   			return ret;
> >>   	}
> >>   
> >> -	sd->enabled_streams |= streams_mask;
> >> +	sd->enabled_pads |= BIT_ULL(pad);
> >>   
> >>   	return 0;
> >>   }
> >> @@ -2207,37 +2213,43 @@ static int v4l2_subdev_disable_streams_fallback(struct v4l2_subdev *sd, u32 pad,
> >>   						u64 streams_mask)
> >>   {
> >>   	struct device *dev = sd->entity.graph_obj.mdev->dev;
> >> -	unsigned int i;
> >>   	int ret;
> >>   
> >>   	/*
> >> -	 * If the subdev doesn't implement pad-based stream enable, fall  back
> >> -	 * on the .s_stream() operation. This can only be done for subdevs that
> >> -	 * have a single source pad, as sd->enabled_streams is global to the
> >> -	 * subdev.
> >> +	 * If the subdev doesn't implement pad-based stream enable, fall back
> >> +	 * on the .s_stream() operation.
> >>   	 */
> >>   	if (!(sd->entity.pads[pad].flags & MEDIA_PAD_FL_SOURCE))
> >>   		return -EOPNOTSUPP;
> >>   
> >> -	for (i = 0; i < sd->entity.num_pads; ++i) {
> >> -		if (i != pad && sd->entity.pads[i].flags & MEDIA_PAD_FL_SOURCE)
> >> -			return -EOPNOTSUPP;
> >> -	}
> >> +	/*
> >> +	 * .s_stream() means there is no streams support, so only allowed stream
> >> +	 * is the imlicit stream 0.
> >> +	 */
> >> +	if (streams_mask != BIT_ULL(0))
> >> +		return -EOPNOTSUPP;
> >> +
> >> +	/*
> >> +	 * We use a 64-bit bitmask for tracking enabled pads, so only subdevices
> >> +	 * with 64 pads or less can be supported.
> >> +	 */
> >> +	if (pad >= sizeof(sd->enabled_pads) * 8)
> > 
> > Ditto.
> > 
> > How much of the code of the two functions is the same? Could some of this
> > be put to a common function both would call? They look (almost) exactly the
> > same.
> 
> v4l2_subdev_enable_streams_fallback and v4l2_subdev_enable_streams? They 
> have similar parts, but I don't right away see how combining them or 
> making some common functions would help.

You could move the three checks to a
v4l2_subdev_streams_fallback_check() function (bikeshedding the name is
allowed).

> >> +		return -EOPNOTSUPP;
> >>   
> >> -	if ((sd->enabled_streams & streams_mask) != streams_mask) {
> >> -		dev_dbg(dev, "set of streams %#llx already disabled on %s:%u\n",
> >> -			streams_mask, sd->entity.name, pad);
> >> +	if ((sd->enabled_pads & BIT_ULL(pad)) != BIT_ULL(pad)) {

	if (!(sd->enabled_pads & BIT_ULL(pad))) {

> >> +		dev_dbg(dev, "pad %u already disabled on %s\n",
> >> +			pad, sd->entity.name);
> >>   		return -EALREADY;
> >>   	}
> >>   
> >>   	/* Stop streaming when the last streams are disabled. */
> >> -	if (!(sd->enabled_streams & ~streams_mask)) {
> >> +	if (!(sd->enabled_pads & ~BIT_ULL(pad))) {
> >>   		ret = v4l2_subdev_call(sd, video, s_stream, 0);
> >>   		if (ret)
> >>   			return ret;
> >>   	}
> >>   
> >> -	sd->enabled_streams &= ~streams_mask;
> >> +	sd->enabled_pads &= ~BIT_ULL(pad);
> >>   
> >>   	return 0;
> >>   }
> >> diff --git a/include/media/v4l2-subdev.h b/include/media/v4l2-subdev.h
> >> index 8bd1e3c96d2b..7077aec3176c 100644
> >> --- a/include/media/v4l2-subdev.h
> >> +++ b/include/media/v4l2-subdev.h
> >> @@ -1039,10 +1039,9 @@ struct v4l2_subdev_platform_data {
> >>    * @active_state: Active state for the subdev (NULL for subdevs tracking the
> >>    *		  state internally). Initialized by calling
> >>    *		  v4l2_subdev_init_finalize().
> >> - * @enabled_streams: Bitmask of enabled streams used by
> >> - *		     v4l2_subdev_enable_streams() and
> >> - *		     v4l2_subdev_disable_streams() helper functions for fallback
> >> - *		     cases.
> >> + * @enabled_pads: Bitmask of enabled pads used by v4l2_subdev_enable_streams()
> >> + *		  and v4l2_subdev_disable_streams() helper functions for
> >> + *		  fallback cases.
> >>    * @streaming_enabled: Tracks whether streaming has been enabled with s_stream.
> >>    *
> >>    * Each instance of a subdev driver should create this struct, either
> >> @@ -1091,7 +1090,7 @@ struct v4l2_subdev {
> >>   	 * doesn't support it.
> >>   	 */
> >>   	struct v4l2_subdev_state *active_state;
> >> -	u64 enabled_streams;
> >> +	u64 enabled_pads;
> >>   	bool streaming_enabled;
> >>   };
> >>   

-- 
Regards,

Laurent Pinchart

