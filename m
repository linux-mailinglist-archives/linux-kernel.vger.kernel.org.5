Return-Path: <linux-kernel+bounces-143147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1561A8A34FC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 19:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6861283E61
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084C414E2C5;
	Fri, 12 Apr 2024 17:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="A+J8s0Ka"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC02314C587;
	Fri, 12 Apr 2024 17:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712943716; cv=none; b=eCW6pE0CBuMREdMCzPKAULum5/s6qPXu+diQRM6ZDcoN6slPwHddlapqd66esZgSES9AYIypHThf33DK2zCRLKtS01k16WLlo/IKCYYuo0qiWdRT+rVBFQX0IDAgEfK8udQ3j6RABWfFRtP6P5N/l+m11w69/oEIMgE7t4ddfzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712943716; c=relaxed/simple;
	bh=lq6CAvGdg2Fkl3PAyGSZcvBPOat6xJoMsfeERKMfvuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X1AxWIcewL0yEnHGSbfzOTuR3MHYiAv6DbymDXMlk3aV92YWddv3qwK88LqsHRSzX81nBVLJ2QNMgYqB/XIAsSW1sRsQJIYEdWaR6ZxXnicfdinMBqspt6dfKI4sg6r7mrFO6s+zwIhTXt2t0RIt09pIA33SDsNyp4nFSg6zZaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=A+J8s0Ka; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (85-76-65-73-nat.elisa-mobile.fi [85.76.65.73])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 68A798E1;
	Fri, 12 Apr 2024 19:41:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712943669;
	bh=lq6CAvGdg2Fkl3PAyGSZcvBPOat6xJoMsfeERKMfvuQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A+J8s0Kab24QyO/W/9GIASpOo0h9l9jx9HrvD/0ygNRPDigJcQlNicmmYP5YJIfi+
	 +GUlGiujFoKMrODHwcGFcj4thyH3ZqcATJm6bB/GBS/5QW6Xfej+S8p7f5eJDvdEmk
	 uRJDFMUVwi9HwCyx6lZGMoZnZAmC6HtHH0IMEZZI=
Date: Fri, 12 Apr 2024 20:41:43 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Umang Jain <umang.jain@ideasonboard.com>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/9] media: subdev: Add checks for subdev features
Message-ID: <20240412174143.GF31122@pendragon.ideasonboard.com>
References: <20240410-enable-streams-impro-v3-0-e5e7a5da7420@ideasonboard.com>
 <20240410-enable-streams-impro-v3-3-e5e7a5da7420@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240410-enable-streams-impro-v3-3-e5e7a5da7420@ideasonboard.com>

Hi Tomi,

Thank you for the patch.

On Wed, Apr 10, 2024 at 03:35:50PM +0300, Tomi Valkeinen wrote:
> Add some checks to verify that the subdev driver implements required
> features.
> 
> A subdevice that supports streams (V4L2_SUBDEV_FL_STREAMS) must do one
> of the following:
> 
> - Implement neither .enable/disable_streams() nor .s_stream(), if the
>   subdev is part of a video driver that uses an internal method to
>   enable the subdev.
> - Implement only .enable/disable_streams(), if support for legacy
>   sink-side subdevices is not needed.
> - Implement .enable/disable_streams() and .s_stream(), if support for
>   legacy sink-side subdevices is needed.
> 
> At the moment the framework doesn't check this requirement. Add the
> check.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/media/v4l2-core/v4l2-subdev.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
> index 4a531c2b16c4..606a909cd778 100644
> --- a/drivers/media/v4l2-core/v4l2-subdev.c
> +++ b/drivers/media/v4l2-core/v4l2-subdev.c
> @@ -1533,6 +1533,33 @@ int __v4l2_subdev_init_finalize(struct v4l2_subdev *sd, const char *name,
>  				struct lock_class_key *key)
>  {
>  	struct v4l2_subdev_state *state;
> +	struct device *dev = sd->dev;
> +	bool has_disable_streams;
> +	bool has_enable_streams;
> +	bool has_s_stream;
> +
> +	/* Check that the subdevice implements the required features */
> +
> +	has_s_stream = v4l2_subdev_has_op(sd, video, s_stream);
> +	has_enable_streams = v4l2_subdev_has_op(sd, pad, enable_streams);
> +	has_disable_streams = v4l2_subdev_has_op(sd, pad, disable_streams);
> +
> +	if (has_enable_streams != has_disable_streams) {
> +		dev_err(dev,
> +			"subdev '%s' must implement both or neither of .enable_streams() and .disable_streams()\n",
> +			sd->name);
> +		return -EINVAL;
> +	}
> +
> +	if (sd->flags & V4L2_SUBDEV_FL_STREAMS) {
> +		if (has_s_stream && !has_enable_streams) {
> +			dev_err(dev,
> +				"subdev '%s' must implement .enable/disable_streams()\n",
> +				sd->name);
> +
> +			return -EINVAL;
> +		}
> +	}
>  
>  	state = __v4l2_subdev_state_alloc(sd, name, key);
>  	if (IS_ERR(state))
> 

-- 
Regards,

Laurent Pinchart

