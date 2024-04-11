Return-Path: <linux-kernel+bounces-139749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 875068A0738
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14E3DB249EB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 04:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085F713BC10;
	Thu, 11 Apr 2024 04:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="br35mjHm"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0275CBD;
	Thu, 11 Apr 2024 04:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712810603; cv=none; b=E8m6DQOnW2St8qDFfby25L6ygOEb/rrWZn8BYIbtUy+0pLN/hNWuRMG7pxK5kvjCOABugVN6PwE5JzJTP4WXwcT08Jfb6up2KF4omFIv8dlS89A7KSJI3I8j/HMfluykc+M0kUUGWKvwqTCmraq85nMzdGItf4AVmK67OfE1nxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712810603; c=relaxed/simple;
	bh=viThAdV3OPPJVFejWkza8XXjfECvpU7zIB9jJLJnF5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nq+15Vxz61S52MlamngE5L1Eahjnyu98c6E26boDFpgu7DCJ+sZX3RhS8xuNQDzCypvNed3/LTWky8j4PPUpVLnNWPq8MDAdHRzNNGiF8710NYWWXrzB0W7ueWeW5YxRklK6p9Rvh2t7eHZIWxOpuOBaZCTKq2JXVvwXuhdqmZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=br35mjHm; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.1.108] (unknown [103.86.18.224])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6253AB0B;
	Thu, 11 Apr 2024 06:42:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712810557;
	bh=viThAdV3OPPJVFejWkza8XXjfECvpU7zIB9jJLJnF5w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=br35mjHm0wQbEHWIw5bHGIekX6E/FnruQRyAco0DjajUX54TjIg3Tf2riGxTYy01N
	 ZUqBXNw/s1ndgqCJooubzhg7h4Nda3CBHUzhADpYm5I1mlpUKv2QyMWurDNql0uzqJ
	 ZkJfcGlVNwLVJllAlY447C0b9RKHQ1c6++AfRXo0=
Message-ID: <27b8fbb5-9427-4f81-9adb-6acc51ee77e7@ideasonboard.com>
Date: Thu, 11 Apr 2024 10:13:12 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/9] media: subdev: Add privacy led helpers
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil
 <hverkuil@xs4all.nl>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240410-enable-streams-impro-v3-0-e5e7a5da7420@ideasonboard.com>
 <20240410-enable-streams-impro-v3-1-e5e7a5da7420@ideasonboard.com>
Content-Language: en-US
From: Umang Jain <umang.jain@ideasonboard.com>
In-Reply-To: <20240410-enable-streams-impro-v3-1-e5e7a5da7420@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Tomi,

Thank you for the patch.

On 10/04/24 6:05 pm, Tomi Valkeinen wrote:
> Add helper functions to enable and disable the privacy led. This moves
> the #if from the call site to the privacy led functions, and makes
> adding privacy led support to v4l2_subdev_enable/disable_streams()
> cleaner.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

Reviewed-by: Umang Jain <umang.jain@ideasonboard.com>

> ---
>   drivers/media/v4l2-core/v4l2-subdev.c | 30 +++++++++++++++++++++---------
>   1 file changed, 21 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
> index 012b757eac9f..13957543d153 100644
> --- a/drivers/media/v4l2-core/v4l2-subdev.c
> +++ b/drivers/media/v4l2-core/v4l2-subdev.c
> @@ -148,6 +148,23 @@ static int subdev_close(struct file *file)
>   }
>   #endif /* CONFIG_VIDEO_V4L2_SUBDEV_API */
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
>   static inline int check_which(u32 which)
>   {
>   	if (which != V4L2_SUBDEV_FORMAT_TRY &&
> @@ -422,15 +439,10 @@ static int call_s_stream(struct v4l2_subdev *sd, int enable)
>   	if (!ret) {
>   		sd->enabled_streams = enable ? BIT(0) : 0;
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
>   	}
>   
>   	return ret;
>


