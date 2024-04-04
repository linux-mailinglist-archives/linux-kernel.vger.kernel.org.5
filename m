Return-Path: <linux-kernel+bounces-131410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C53689875E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6AF5B212FA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F6B12A173;
	Thu,  4 Apr 2024 12:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VhWhRSF4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D18A1292F8;
	Thu,  4 Apr 2024 12:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712233440; cv=none; b=sfKgMxFsFb0ho99tQb3CFdxWUkyqn6unWXMK5y776C7+FPhoDeFq+R/bHc3NjntBpqTvRj4f4bI+DdmaH1Ys4I0v+R/mgtDvuuE0MoBFfkD80Vfr/N1awuFXFbkeLIbPAK58Vx9HybnRKu8K8sg2GK4V2rpEOoteIrY97o3o2Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712233440; c=relaxed/simple;
	bh=KnqkCZZxEC8uS/Ao+n5Ee2O7zuea/twrqNzDm4+8APY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dFXcEETp0p6WJTqRxbByPIPtXgb+wOYXiszEF+18ytDfmaIm+fd6Kl8XuC1dKRxKV8vqnhzE+p+D3E2BmzQXhtCZezvclWHyX9n3drEMgHu3TIRQmPnUebsHIKHwjrrxtPyL0QeBIHXcOJaVxwdPNoflClrXXYtGGcK9SznjJC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VhWhRSF4; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712233436; x=1743769436;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KnqkCZZxEC8uS/Ao+n5Ee2O7zuea/twrqNzDm4+8APY=;
  b=VhWhRSF46TcT4zDY1n1TzqjT/li+ztTozGid/FChOF8PyEUtBWa9bHg2
   QeDbhpFkaOohcaI5Z3NNLeEhEzVkeT+cgrn9ah4u+OkXEjUXgJ7OO/pOU
   bgPhA9qeK95bhWOLjcBZtg+1/MtlQ5kWi30HOB9+2XF/jXY+wCM4uS/sz
   dC9uZCZD1WVt/et7tw+/CJA++eyBEco+ghROawJCSD7TGUK5S2d6djcHi
   2Y4H/2Ct6s7fCehQbzEvj/if+UwiW/CKZlhLYxJpCbH3bd+yby9+BPumg
   CqNgpMneCu8Tqxt+8ky+fxufOCf+KxVOwty1yKRO+xoxemfcUVpJpF26s
   A==;
X-CSE-ConnectionGUID: I7pJ65guTn2BsGF8mC4xlg==
X-CSE-MsgGUID: 38zkMPpwQZi+kMm1/M0yXw==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="7618767"
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="7618767"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 05:18:43 -0700
X-CSE-ConnectionGUID: YIABzNY1QySeA69ilqqoKg==
X-CSE-MsgGUID: ZJ60WyGVQ3madHQa637Olg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="23457504"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 05:18:40 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 33E2411F819;
	Thu,  4 Apr 2024 15:18:37 +0300 (EEST)
Date: Thu, 4 Apr 2024 12:18:37 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Umang Jain <umang.jain@ideasonboard.com>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] media: subdev: Improve
 v4l2_subdev_enable/disable_streams_fallback
Message-ID: <Zg6anfpQt80gSKjN@kekkonen.localdomain>
References: <20240404-enable-streams-impro-v1-0-1017a35bbe07@ideasonboard.com>
 <20240404-enable-streams-impro-v1-3-1017a35bbe07@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404-enable-streams-impro-v1-3-1017a35bbe07@ideasonboard.com>

Moi,

Thanks for the patch.

On Thu, Apr 04, 2024 at 01:50:02PM +0300, Tomi Valkeinen wrote:
> v4l2_subdev_enable/disable_streams_fallback() supports falling back to
> .s_stream() for subdevs with a single source pad. It also tracks the
> enabled streams for that one pad in the sd->enabled_streams field.
> 
> Tracking the enabled streams with sd->enabled_streams does not make
> sense, as with .s_stream() there can only be a single stream per pad.
> Thus, as the v4l2_subdev_enable/disable_streams_fallback() only supports
> a single source pad, all we really need is a boolean which tells whether
> streaming has been enabled on this pad or not.
> 
> However, as we only need a true/false state for a pad (instead of
> tracking which streams have been enabled for a pad), we can easily
> extend the fallback mechanism to support multiple source pads as we only
> need to keep track of which pads have been enabled.
> 
> Change the sd->enabled_streams field to sd->enabled_pads, which is a
> 64-bit bitmask tracking the enabled source pads. With this change we can
> remove the restriction that
> v4l2_subdev_enable/disable_streams_fallback() only supports a single
> soruce pad.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  drivers/media/v4l2-core/v4l2-subdev.c | 68 ++++++++++++++++++++---------------
>  include/media/v4l2-subdev.h           |  9 +++--
>  2 files changed, 44 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
> index 3b3310bce5d4..91298bb84e6b 100644
> --- a/drivers/media/v4l2-core/v4l2-subdev.c
> +++ b/drivers/media/v4l2-core/v4l2-subdev.c
> @@ -2090,37 +2090,43 @@ static int v4l2_subdev_enable_streams_fallback(struct v4l2_subdev *sd, u32 pad,
>  					       u64 streams_mask)
>  {
>  	struct device *dev = sd->entity.graph_obj.mdev->dev;
> -	unsigned int i;
>  	int ret;
>  
>  	/*
>  	 * The subdev doesn't implement pad-based stream enable, fall back
> -	 * on the .s_stream() operation. This can only be done for subdevs that
> -	 * have a single source pad, as sd->enabled_streams is global to the
> -	 * subdev.
> +	 * on the .s_stream() operation.
>  	 */
>  	if (!(sd->entity.pads[pad].flags & MEDIA_PAD_FL_SOURCE))
>  		return -EOPNOTSUPP;
>  
> -	for (i = 0; i < sd->entity.num_pads; ++i) {
> -		if (i != pad && sd->entity.pads[i].flags & MEDIA_PAD_FL_SOURCE)
> -			return -EOPNOTSUPP;
> -	}
> +	/*
> +	 * .s_stream() means there is no streams support, so only allowed stream
> +	 * is the imlicit stream 0.
> +	 */
> +	if (streams_mask != BIT_ULL(0))
> +		return -EOPNOTSUPP;
> +
> +	/*
> +	 * We use a 64-bit bitmask for tracking enabled pads, so only subdevices
> +	 * with 64 pads or less can be supported.
> +	 */
> +	if (pad >= sizeof(sd->enabled_pads) * 8)

s/8/BITS_PER_BYTE/

> +		return -EOPNOTSUPP;
>  
> -	if (sd->enabled_streams & streams_mask) {
> -		dev_dbg(dev, "set of streams %#llx already enabled on %s:%u\n",
> -			streams_mask, sd->entity.name, pad);
> +	if (sd->enabled_pads & BIT_ULL(pad)) {
> +		dev_dbg(dev, "pad %u already enabled on %s\n",
> +			pad, sd->entity.name);
>  		return -EALREADY;
>  	}
>  
> -	/* Start streaming when the first streams are enabled. */
> -	if (!sd->enabled_streams) {
> +	/* Start streaming when the first pad is enabled. */
> +	if (!sd->enabled_pads) {
>  		ret = v4l2_subdev_call(sd, video, s_stream, 1);
>  		if (ret)
>  			return ret;
>  	}
>  
> -	sd->enabled_streams |= streams_mask;
> +	sd->enabled_pads |= BIT_ULL(pad);
>  
>  	return 0;
>  }
> @@ -2207,37 +2213,43 @@ static int v4l2_subdev_disable_streams_fallback(struct v4l2_subdev *sd, u32 pad,
>  						u64 streams_mask)
>  {
>  	struct device *dev = sd->entity.graph_obj.mdev->dev;
> -	unsigned int i;
>  	int ret;
>  
>  	/*
> -	 * If the subdev doesn't implement pad-based stream enable, fall  back
> -	 * on the .s_stream() operation. This can only be done for subdevs that
> -	 * have a single source pad, as sd->enabled_streams is global to the
> -	 * subdev.
> +	 * If the subdev doesn't implement pad-based stream enable, fall back
> +	 * on the .s_stream() operation.
>  	 */
>  	if (!(sd->entity.pads[pad].flags & MEDIA_PAD_FL_SOURCE))
>  		return -EOPNOTSUPP;
>  
> -	for (i = 0; i < sd->entity.num_pads; ++i) {
> -		if (i != pad && sd->entity.pads[i].flags & MEDIA_PAD_FL_SOURCE)
> -			return -EOPNOTSUPP;
> -	}
> +	/*
> +	 * .s_stream() means there is no streams support, so only allowed stream
> +	 * is the imlicit stream 0.
> +	 */
> +	if (streams_mask != BIT_ULL(0))
> +		return -EOPNOTSUPP;
> +
> +	/*
> +	 * We use a 64-bit bitmask for tracking enabled pads, so only subdevices
> +	 * with 64 pads or less can be supported.
> +	 */
> +	if (pad >= sizeof(sd->enabled_pads) * 8)

Ditto.

How much of the code of the two functions is the same? Could some of this
be put to a common function both would call? They look (almost) exactly the
same.

> +		return -EOPNOTSUPP;
>  
> -	if ((sd->enabled_streams & streams_mask) != streams_mask) {
> -		dev_dbg(dev, "set of streams %#llx already disabled on %s:%u\n",
> -			streams_mask, sd->entity.name, pad);
> +	if ((sd->enabled_pads & BIT_ULL(pad)) != BIT_ULL(pad)) {
> +		dev_dbg(dev, "pad %u already disabled on %s\n",
> +			pad, sd->entity.name);
>  		return -EALREADY;
>  	}
>  
>  	/* Stop streaming when the last streams are disabled. */
> -	if (!(sd->enabled_streams & ~streams_mask)) {
> +	if (!(sd->enabled_pads & ~BIT_ULL(pad))) {
>  		ret = v4l2_subdev_call(sd, video, s_stream, 0);
>  		if (ret)
>  			return ret;
>  	}
>  
> -	sd->enabled_streams &= ~streams_mask;
> +	sd->enabled_pads &= ~BIT_ULL(pad);
>  
>  	return 0;
>  }
> diff --git a/include/media/v4l2-subdev.h b/include/media/v4l2-subdev.h
> index 8bd1e3c96d2b..7077aec3176c 100644
> --- a/include/media/v4l2-subdev.h
> +++ b/include/media/v4l2-subdev.h
> @@ -1039,10 +1039,9 @@ struct v4l2_subdev_platform_data {
>   * @active_state: Active state for the subdev (NULL for subdevs tracking the
>   *		  state internally). Initialized by calling
>   *		  v4l2_subdev_init_finalize().
> - * @enabled_streams: Bitmask of enabled streams used by
> - *		     v4l2_subdev_enable_streams() and
> - *		     v4l2_subdev_disable_streams() helper functions for fallback
> - *		     cases.
> + * @enabled_pads: Bitmask of enabled pads used by v4l2_subdev_enable_streams()
> + *		  and v4l2_subdev_disable_streams() helper functions for
> + *		  fallback cases.
>   * @streaming_enabled: Tracks whether streaming has been enabled with s_stream.
>   *
>   * Each instance of a subdev driver should create this struct, either
> @@ -1091,7 +1090,7 @@ struct v4l2_subdev {
>  	 * doesn't support it.
>  	 */
>  	struct v4l2_subdev_state *active_state;
> -	u64 enabled_streams;
> +	u64 enabled_pads;
>  	bool streaming_enabled;
>  };
>  
> 

-- 
Kind regards,

Sakari Ailus

