Return-Path: <linux-kernel+bounces-143184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C244F8A3573
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B87A11C20DBC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C490C14EC4C;
	Fri, 12 Apr 2024 18:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="a4qF07Hq"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B43C14E2E1;
	Fri, 12 Apr 2024 18:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712945772; cv=none; b=B3fJByjNqXyM9WLFu043dPNsgdlU9HNC6cHAtkU7K15hVU+Txtjc+0s9PH+D+1rVSpg5sLld+uh2VI9eNNxIWwEQHf2PlmjfdnWjT98vsY/gCjxzODw/KiMUYMOkJNTD6hHXuZVKJaMLK2XD1bXKIbwGXvcRS7o0mM9MhyP2alY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712945772; c=relaxed/simple;
	bh=dZ7DBLOplA06T/PhVO+GGVrNbWcG7Pg5wgdv1SwGr5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3HeGaH+1BQE3A5CWz22/DbV2GkPTftAOTogZX67XnCUN6wuu3DkN/Mbp2e7cmuZVLxF0tkskzhXzQGkuSGUYWxUk5RNmXndB3Aow1eSfpxg0oGskwM+IYO78RlfxJxsjvffAohegQhfswxt3sQRzrPSTJgCSmsxxogGzXv1MWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=a4qF07Hq; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (85-76-65-73-nat.elisa-mobile.fi [85.76.65.73])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 989029D5;
	Fri, 12 Apr 2024 20:15:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712945725;
	bh=dZ7DBLOplA06T/PhVO+GGVrNbWcG7Pg5wgdv1SwGr5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a4qF07Hqp6QbxF+DdKNbg7E7ucc1k7j8PMU8AdrQ8GEeUczRxaDedLhQMG2y08F50
	 FWldRDtmW6vvKRgbBXSETpbhvAKPXyH/1WW6fVTfaoC8z2Gn6iAJrjueZ0BJVcmNxY
	 WUZ6FCLszKLkFKtJrEfOwLzKrieVVIwpV546YvmA=
Date: Fri, 12 Apr 2024 21:15:58 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Umang Jain <umang.jain@ideasonboard.com>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/9] media: subdev: Add v4l2_subdev_is_streaming()
Message-ID: <20240412181558.GI31122@pendragon.ideasonboard.com>
References: <20240410-enable-streams-impro-v3-0-e5e7a5da7420@ideasonboard.com>
 <20240410-enable-streams-impro-v3-6-e5e7a5da7420@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240410-enable-streams-impro-v3-6-e5e7a5da7420@ideasonboard.com>

Hi Tomi,

Thank you for the patch.

On Wed, Apr 10, 2024 at 03:35:53PM +0300, Tomi Valkeinen wrote:
> Add a helper function which returns whether the subdevice is streaming,
> i.e. if .s_stream or .enable_streams has been called successfully.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  drivers/media/v4l2-core/v4l2-subdev.c | 25 +++++++++++++++++++++++++
>  include/media/v4l2-subdev.h           | 13 +++++++++++++
>  2 files changed, 38 insertions(+)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
> index 3d2c9c224b8f..20b5a00cbeeb 100644
> --- a/drivers/media/v4l2-core/v4l2-subdev.c
> +++ b/drivers/media/v4l2-core/v4l2-subdev.c
> @@ -2419,6 +2419,31 @@ void v4l2_subdev_notify_event(struct v4l2_subdev *sd,
>  }
>  EXPORT_SYMBOL_GPL(v4l2_subdev_notify_event);
>  
> +bool v4l2_subdev_is_streaming(struct v4l2_subdev *sd)
> +{
> +	struct v4l2_subdev_state *state;
> +
> +	if (!v4l2_subdev_has_op(sd, pad, enable_streams))
> +		return sd->streaming_enabled;
> +
> +	state = v4l2_subdev_get_locked_active_state(sd);
> +
> +	if (!(sd->flags & V4L2_SUBDEV_FL_STREAMS))
> +		return !!sd->enabled_pads;

I think this can be moved above the
v4l2_subdev_get_locked_active_state() call.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Any plan to convert drivers to this ?

> +
> +	for (unsigned int i = 0; i < state->stream_configs.num_configs; ++i) {
> +		const struct v4l2_subdev_stream_config *cfg;
> +
> +		cfg = &state->stream_configs.configs[i];
> +
> +		if (cfg->enabled)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(v4l2_subdev_is_streaming);
> +
>  int v4l2_subdev_get_privacy_led(struct v4l2_subdev *sd)
>  {
>  #if IS_REACHABLE(CONFIG_LEDS_CLASS)
> diff --git a/include/media/v4l2-subdev.h b/include/media/v4l2-subdev.h
> index d6867511e9cf..270a4dfa5663 100644
> --- a/include/media/v4l2-subdev.h
> +++ b/include/media/v4l2-subdev.h
> @@ -1914,4 +1914,17 @@ extern const struct v4l2_subdev_ops v4l2_subdev_call_wrappers;
>  void v4l2_subdev_notify_event(struct v4l2_subdev *sd,
>  			      const struct v4l2_event *ev);
>  
> +/**
> + * v4l2_subdev_is_streaming() - Returns if the subdevice is streaming
> + * @sd: The subdevice
> + *
> + * v4l2_subdev_is_streaming() tells if the subdevice is currently streaming.
> + * "Streaming" here means whether .s_stream() or .enable_streams() has been
> + * successfully called, and the streaming has not yet been disabled.
> + *
> + * If the subdevice implements .enable_streams() this function must be called
> + * while holding the active state lock.
> + */
> +bool v4l2_subdev_is_streaming(struct v4l2_subdev *sd);
> +
>  #endif /* _V4L2_SUBDEV_H */
> 

-- 
Regards,

Laurent Pinchart

