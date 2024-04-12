Return-Path: <linux-kernel+bounces-143189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 345DC8A3580
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B66EDB236D7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0D214EC61;
	Fri, 12 Apr 2024 18:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Advlw1M3"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBA914D44F;
	Fri, 12 Apr 2024 18:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712946044; cv=none; b=JFZGpkdO7gdOnAk4lpKkImBIR/sZOJ0zZAbPaiqUtu3pflHZk5MZImzSrh0Wx8hpW4+8be4dODfe8Oo9N65j7w7xP5lTbRH9Q6iJ5GBvRbcHpatbFG0L7yD2zf9gkuBE4IG6jw4kjwQEwT/8VBProDV4JfzF8fO30c3pC8VQR/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712946044; c=relaxed/simple;
	bh=BLnTy3ivk+xXDmUktJ4bE7E0wMv/VeVf/0tsKf09FTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3yL+3EqTXXN04KNiiQB3vVH6Ar7GEpL/kx5fSsxdZ7Pv1XKs41jXDRTdHzv7BRyXDvH44WzwYPM5fOE7WcNF2iQbiHU9GGr0JjvO/FTISQXE0RX0hexe8wEVYYwJ46VhOXs9GC6A7atXli72XDkBjkvs0gBveT2NAXAwSmrE50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Advlw1M3; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (85-76-65-73-nat.elisa-mobile.fi [85.76.65.73])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id A68479D5;
	Fri, 12 Apr 2024 20:19:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712945997;
	bh=BLnTy3ivk+xXDmUktJ4bE7E0wMv/VeVf/0tsKf09FTw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Advlw1M3BukmOQ7nreH/3SpMmc5/XRtzQq/ROLUAfjnAFTvlnRh45X8qv0W8JZIj1
	 05v43vDot6S3/16S33DHZaSdu6shN0VZ5Of6o65HyJCVtS4LFv/EWr/0No3LKyHAsT
	 I5wriTZzWQK2W3NLOFClnjVGHiy7Zn8TqMKyHtvE=
Date: Fri, 12 Apr 2024 21:20:26 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Umang Jain <umang.jain@ideasonboard.com>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/9] media: subdev: Support privacy led in
 v4l2_subdev_enable/disable_streams()
Message-ID: <20240412182026.GJ31122@pendragon.ideasonboard.com>
References: <20240410-enable-streams-impro-v3-0-e5e7a5da7420@ideasonboard.com>
 <20240410-enable-streams-impro-v3-7-e5e7a5da7420@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240410-enable-streams-impro-v3-7-e5e7a5da7420@ideasonboard.com>

Hi Tomi,

Thank you for the patch.

On Wed, Apr 10, 2024 at 03:35:54PM +0300, Tomi Valkeinen wrote:
> We support camera privacy leds with the .s_stream, in call_s_stream, but

s/the .s_stream/the .s_stream() operation/

> we don't have that support when the subdevice implements
> .enable/disable_streams.
> 
> Add the support by enabling the led when the first stream for a
> subdevice is enabled, and disabling the led then the last stream is
> disabled.

I wonder if that will always be the correct constraint for all devices,
but I suppose we can worry about it later.

> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  drivers/media/v4l2-core/v4l2-subdev.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
> index 20b5a00cbeeb..f44aaa4e1fab 100644
> --- a/drivers/media/v4l2-core/v4l2-subdev.c
> +++ b/drivers/media/v4l2-core/v4l2-subdev.c
> @@ -2150,6 +2150,7 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
>  {
>  	struct device *dev = sd->entity.graph_obj.mdev->dev;
>  	struct v4l2_subdev_state *state;
> +	bool already_streaming;
>  	u64 found_streams = 0;
>  	unsigned int i;
>  	int ret;
> @@ -2198,6 +2199,8 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
>  
>  	dev_dbg(dev, "enable streams %u:%#llx\n", pad, streams_mask);
>  
> +	already_streaming = v4l2_subdev_is_streaming(sd);
> +
>  	/* Call the .enable_streams() operation. */
>  	ret = v4l2_subdev_call(sd, pad, enable_streams, state, pad,
>  			       streams_mask);
> @@ -2216,6 +2219,9 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
>  			cfg->enabled = true;
>  	}
>  
> +	if (!already_streaming)
> +		v4l2_subdev_enable_privacy_led(sd);
> +
>  done:
>  	v4l2_subdev_unlock_state(state);
>  
> @@ -2340,6 +2346,9 @@ int v4l2_subdev_disable_streams(struct v4l2_subdev *sd, u32 pad,
>  	}
>  
>  done:
> +	if (!v4l2_subdev_is_streaming(sd))

Wouldn't it be more efficient to check this while looping over the
stream configs in the loop just above ? Same for
v4l2_subdev_enable_streams().

> +		v4l2_subdev_disable_privacy_led(sd);
> +
>  	v4l2_subdev_unlock_state(state);
>  
>  	return ret;
> 

-- 
Regards,

Laurent Pinchart

