Return-Path: <linux-kernel+bounces-138213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B99E89EE2C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA164285395
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755931553BB;
	Wed, 10 Apr 2024 09:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hFx8RxOY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E078D19BA6;
	Wed, 10 Apr 2024 09:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712740061; cv=none; b=L+C7hOnreyUsB598ckGys+8mVBkwA5eYFYrU6viyRJtJySa47L0pUAZwyW/x7VYTrjG2fMr5822NnZ7reJHd+AQU7X+I/YA5YLu5nvCDynFbOiCemTqZliq8fVOJyhoz0pLYQ+fsxa2IUHU4frNeZwdMufZuZr/YeXJHaXn56Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712740061; c=relaxed/simple;
	bh=V+liulKAtSoyNMjfM1JBqrUTw3SMU8b19KrXLY09SMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9q909c6goAq+iB9dE8yoE/7e9HLuRxIDo4pozZjwULDkpF21Gg2Vx4ysyJAIcYo52qpxslnFNw5+RFzhXWC2X2EjKQzBDq59nG8ya/zz5op02RgLOWVy52rK/M060o2fdU6YhGz/e7vGM8g/ed44pT99c/GatojCBIqO4CfQbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hFx8RxOY; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712740060; x=1744276060;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V+liulKAtSoyNMjfM1JBqrUTw3SMU8b19KrXLY09SMo=;
  b=hFx8RxOYZeZr7FShUMy2NDGPqBR8j5YHklr2pLXF62aj/jeCZzclYGZP
   G5FxKn97ZC7gomjpEy9SN/lBG59OHMjn4pxPZ014wF4Tg3yc4jFDGq1fT
   bWJV+o0WVPsszGiZ4DjN4Z/Q3vdvUFDr8bBJrGH0c/skD/ZhHGv+OBAgM
   nLVQ/GgriinN8yNIKOUxShcjjFpq3EM4EBubHwCIyTxoD7jnxefrQan7Y
   gZ8EUoSfDvO56HGDbeVwZxH/m0Yr8lJzNpnp9ssA+a1rRcMI9QDxnl/Vs
   2vpaz9iu1EZFTjIm9fe0w7seB96UZCb+aLw4fUqe8T8j57iXYFexsXpvK
   A==;
X-CSE-ConnectionGUID: x10F2hVcSGG5Gw53Ydb84w==
X-CSE-MsgGUID: 265CPGygQwuWgykrZgTtxA==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="7948567"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="7948567"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 02:07:39 -0700
X-CSE-ConnectionGUID: UXF2mQdURRiCTuaMhqsM4A==
X-CSE-MsgGUID: uA0ST9FTTee0gRBBRInCJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="51720328"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 02:07:37 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id EC23E11FC46;
	Wed, 10 Apr 2024 12:07:34 +0300 (EEST)
Date: Wed, 10 Apr 2024 09:07:34 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Umang Jain <umang.jain@ideasonboard.com>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	hdegoede@redhat.com
Subject: Re: [PATCH v2 1/9] media: subdev: Add privacy led helpers
Message-ID: <ZhZW1hiv9X7JCQ7O@kekkonen.localdomain>
References: <20240405-enable-streams-impro-v2-0-22bca967665d@ideasonboard.com>
 <20240405-enable-streams-impro-v2-1-22bca967665d@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405-enable-streams-impro-v2-1-22bca967665d@ideasonboard.com>

Moi,

On Fri, Apr 05, 2024 at 12:14:19PM +0300, Tomi Valkeinen wrote:
> Add helper functions to enable and disable the privacy led. This moves
> the #if from the call site to the privacy led functions, and makes
> adding privacy led support to v4l2_subdev_enable/disable_streams()
> cleaner.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  drivers/media/v4l2-core/v4l2-subdev.c | 31 ++++++++++++++++++++++---------
>  1 file changed, 22 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
> index 4c6198c48dd6..942c7a644033 100644
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
> +
>  static inline int check_which(u32 which)
>  {
>  	if (which != V4L2_SUBDEV_FORMAT_TRY &&
> @@ -412,15 +429,11 @@ static int call_s_stream(struct v4l2_subdev *sd, int enable)
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
> +	if (enable)
> +		v4l2_subdev_enable_privacy_led(sd);
> +	else
> +		v4l2_subdev_disable_privacy_led(sd);
> +
>  	ret = sd->ops->video->s_stream(sd, enable);

I see that you're only making changes before the s_stream call which also
reveals a bug here: if streaming on fails, the LED will remain lit. It
should be fixed before this set.

I cc'd Hans de Goede.

>  
>  	if (!enable && ret < 0) {
> 

-- 
Kind regards,

Sakari Ailus

