Return-Path: <linux-kernel+bounces-143153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE858A3519
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 19:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACE91B2205E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD5514E2E1;
	Fri, 12 Apr 2024 17:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="RNadb4L/"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA8384A35;
	Fri, 12 Apr 2024 17:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712943995; cv=none; b=FbFi2j7d8GkOD5Pxy3q0K/KQh+u98nLwqevPQBCnPzTpv4Q/XOPAkITYEzK/u/oQ9Zh3V5jXdim+4u0PuQH2IVSL9vqbwj2zthww9rO4n/a3087W5G8BF03B8Vt+IcXt760FdP3dvDGjVRv73h3wkgZNwrM7AB+goAL9gBIKntc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712943995; c=relaxed/simple;
	bh=yk3dJwZYho2TmdvCH1G6eTKYmUXBHIbNMDu93HdHWE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hBpNIbVv+zM/wpZNHC0MvIrQrZR4Fnre6FW7m/e10mdCuibGs5ChXnCn51zCoZ7qNzAeD6O5jaWwNS0+HwDfBy7V4TW2FPZo+DS+LH1vxGcZs5GVRAtM2EK17Ea9WI8RsCS4rlQfMw3vTx+kx2nIdT2UtA3sbDBfaEdeVYeqUrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=RNadb4L/; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (85-76-65-73-nat.elisa-mobile.fi [85.76.65.73])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6627B8E1;
	Fri, 12 Apr 2024 19:45:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712943948;
	bh=yk3dJwZYho2TmdvCH1G6eTKYmUXBHIbNMDu93HdHWE0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RNadb4L/SonvbAnjPwqdbHUP6X9zsaOqS4dyvqX3J+kWjmJ32wsCBYgr7n2Oo9HJc
	 0jH8zUEBeWANuuAPR1gdwl4rUBSbL0od6/yyS47GvpRme2JDC8PosJeddMf+VpoMCH
	 O/ShOX6bJbTIG15SPTQi6t3MBaYB9zenWXd8qpqE=
Date: Fri, 12 Apr 2024 20:46:21 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-media@vger.kernel.org, tomi.valkeinen@ideasonboard.com,
	Hans de Goede <hdegoede@redhat.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Umang Jain <umang.jain@ideasonboard.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] media: v4l: Don't turn on privacy LED if streamon
 fails
Message-ID: <20240412174621.GA5444@pendragon.ideasonboard.com>
References: <20240410114712.661186-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240410114712.661186-1-sakari.ailus@linux.intel.com>

Hi Sakari,

Thank you for the patch.

On Wed, Apr 10, 2024 at 02:47:12PM +0300, Sakari Ailus wrote:
> Turn on the privacy LED only if streamon succeeds. This can be done after
> enabling streaming on the sensor.
> 
> Fixes: b6e10ff6c23d ("media: v4l2-core: Make the v4l2-core code enable/disable the privacy LED if present")
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/media/v4l2-core/v4l2-subdev.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
> index 4c6198c48dd6..012b757eac9f 100644
> --- a/drivers/media/v4l2-core/v4l2-subdev.c
> +++ b/drivers/media/v4l2-core/v4l2-subdev.c
> @@ -412,15 +412,6 @@ static int call_s_stream(struct v4l2_subdev *sd, int enable)
>  	if (WARN_ON(!!sd->enabled_streams == !!enable))
>  		return 0;
>  
> -#if IS_REACHABLE(CONFIG_LEDS_CLASS)
> -	if (!IS_ERR_OR_NULL(sd->privacy_led)) {
> -		if (enable)
> -			led_set_brightness(sd->privacy_led,
> -					   sd->privacy_led->max_brightness);
> -		else
> -			led_set_brightness(sd->privacy_led, 0);
> -	}
> -#endif
>  	ret = sd->ops->video->s_stream(sd, enable);
>  
>  	if (!enable && ret < 0) {
> @@ -428,9 +419,20 @@ static int call_s_stream(struct v4l2_subdev *sd, int enable)
>  		ret = 0;
>  	}
>  
> -	if (!ret)
> +	if (!ret) {
>  		sd->enabled_streams = enable ? BIT(0) : 0;
>  
> +#if IS_REACHABLE(CONFIG_LEDS_CLASS)
> +		if (!IS_ERR_OR_NULL(sd->privacy_led)) {
> +			if (enable)
> +				led_set_brightness(sd->privacy_led,
> +						   sd->privacy_led->max_brightness);
> +			else
> +				led_set_brightness(sd->privacy_led, 0);
> +		}
> +#endif

This means that the LED will be turned slightly after the camera is
enabled. I don't think it's an issue in practice. Another possibly more
important concern is that we should maybe check the return value of
led_set_brightness(), and fail .s_stream() when we can't enable the
privacy LED at stream on time. In that case, it would be best to keep
turning the privacy LED on before calling .s_stream(). It should still
be turned off only after calling .s_stream() though.

> +	}
> +
>  	return ret;
>  }
>  

-- 
Regards,

Laurent Pinchart

