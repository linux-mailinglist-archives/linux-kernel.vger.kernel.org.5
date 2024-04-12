Return-Path: <linux-kernel+bounces-143142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FC98A34EF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 19:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CA3B1F2255E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366DA14D718;
	Fri, 12 Apr 2024 17:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="t/+RsAga"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACA984A35;
	Fri, 12 Apr 2024 17:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712943434; cv=none; b=RwePFv+tHZ1w/EbrZk8Mv0HYok7ADuPQ2wFszejrZXkiYMzMlqrNPOZP1Z+5pCVwOnyUjuPsfkrZFsCNL6WzKRCctaWRXZWiD6Huc/SJbsPIS8Gl2zoyFJ3gzZ1Rl8hIVSE0/v7wt/mW6ZG3Ue3ML7WsF/ALyCfLvQ8Y6m5zI5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712943434; c=relaxed/simple;
	bh=APF0aubO8YssKD8RnDBCjKq+iGiGF8bWVPwzW+1Ns/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kgwZx/CT/FToHtxkEgXHH9X4KIbPzwotbd0/0n4oD5zVAre75ouALU4MLJEcUPxcCUIpbDSGjmJUnhxH1kFnH7P7HU6IdmC7Lr1Kp4VXEdJU7p5QppuRzJqBJLgis/rPOb4zfLBsM3MghBjloHgyrwloB5Qd1sPHo13fOwoatS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=t/+RsAga; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (85-76-65-73-nat.elisa-mobile.fi [85.76.65.73])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 07FDC8E1;
	Fri, 12 Apr 2024 19:36:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712943386;
	bh=APF0aubO8YssKD8RnDBCjKq+iGiGF8bWVPwzW+1Ns/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t/+RsAgatWa7CiLsGuSqSzAAmrZ1Y6zn17AeJr3XHnMLPfkuCdTX2oncpfh2lTmtA
	 60+6DLuZVPn4suoAWxLaUYpntPEbCue6n00ksUO5RU02xPyNbjje9eagQoRJq8K+qF
	 QR9eCPSqUtRwT7P7ZX9M99WA6FWpy2Xg+R5bHHt8=
Date: Fri, 12 Apr 2024 20:36:59 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Umang Jain <umang.jain@ideasonboard.com>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/9] media: subdev: Add privacy led helpers
Message-ID: <20240412173659.GD31122@pendragon.ideasonboard.com>
References: <20240410-enable-streams-impro-v3-0-e5e7a5da7420@ideasonboard.com>
 <20240410-enable-streams-impro-v3-1-e5e7a5da7420@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240410-enable-streams-impro-v3-1-e5e7a5da7420@ideasonboard.com>

Hi Tomi,

Thank you for the patch.

On Wed, Apr 10, 2024 at 03:35:48PM +0300, Tomi Valkeinen wrote:
> Add helper functions to enable and disable the privacy led. This moves
> the #if from the call site to the privacy led functions, and makes
> adding privacy led support to v4l2_subdev_enable/disable_streams()
> cleaner.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  drivers/media/v4l2-core/v4l2-subdev.c | 30 +++++++++++++++++++++---------
>  1 file changed, 21 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
> index 012b757eac9f..13957543d153 100644
> --- a/drivers/media/v4l2-core/v4l2-subdev.c
> +++ b/drivers/media/v4l2-core/v4l2-subdev.c
> @@ -148,6 +148,23 @@ static int subdev_close(struct file *file)
>  }
>  #endif /* CONFIG_VIDEO_V4L2_SUBDEV_API */
>  
> +static void v4l2_subdev_enable_privacy_led(struct v4l2_subdev *sd)
> +{
> +#if IS_REACHABLE(CONFIG_LEDS_CLASS)
> +	if (!IS_ERR_OR_NULL(sd->privacy_led))
> +		led_set_brightness(sd->privacy_led,
> +				   sd->privacy_led->max_brightness);
> +#endif
> +}
> +
> +static void v4l2_subdev_disable_privacy_led(struct v4l2_subdev *sd)
> +{
> +#if IS_REACHABLE(CONFIG_LEDS_CLASS)
> +	if (!IS_ERR_OR_NULL(sd->privacy_led))
> +		led_set_brightness(sd->privacy_led, 0);
> +#endif
> +}

I would have written this as

#if IS_REACHABLE(CONFIG_LEDS_CLASS)
static void v4l2_subdev_enable_privacy_led(struct v4l2_subdev *sd)
{
	if (!IS_ERR_OR_NULL(sd->privacy_led))
		led_set_brightness(sd->privacy_led,
				   sd->privacy_led->max_brightness);
}

static void v4l2_subdev_disable_privacy_led(struct v4l2_subdev *sd)
{
	if (!IS_ERR_OR_NULL(sd->privacy_led))
		led_set_brightness(sd->privacy_led, 0);
}
#else
static inline void v4l2_subdev_enable_privacy_led(struct v4l2_subdev *sd)
{
}

static inline void v4l2_subdev_disable_privacy_led(struct v4l2_subdev *sd)
{
}
#endif /* CONFIG_LEDS_CLASS */

to avoid multipe #if but that likely makes no difference in the
generated code. Either way,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +
>  static inline int check_which(u32 which)
>  {
>  	if (which != V4L2_SUBDEV_FORMAT_TRY &&
> @@ -422,15 +439,10 @@ static int call_s_stream(struct v4l2_subdev *sd, int enable)
>  	if (!ret) {
>  		sd->enabled_streams = enable ? BIT(0) : 0;
>  
> -#if IS_REACHABLE(CONFIG_LEDS_CLASS)
> -		if (!IS_ERR_OR_NULL(sd->privacy_led)) {
> -			if (enable)
> -				led_set_brightness(sd->privacy_led,
> -						   sd->privacy_led->max_brightness);
> -			else
> -				led_set_brightness(sd->privacy_led, 0);
> -		}
> -#endif
> +		if (enable)
> +			v4l2_subdev_enable_privacy_led(sd);
> +		else
> +			v4l2_subdev_disable_privacy_led(sd);
>  	}
>  
>  	return ret;
> 

-- 
Regards,

Laurent Pinchart

