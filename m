Return-Path: <linux-kernel+bounces-138426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3125789F111
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC172289278
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D98C15ADBD;
	Wed, 10 Apr 2024 11:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Om2nAfmu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F6315ADA2;
	Wed, 10 Apr 2024 11:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712749386; cv=none; b=LgE/Vj/CVEN3/GKzeA1GEy8wv26pCsx4NuMaDVvbQsrna27uehPQ7FUimN20fEK9VczOTDUL4nw0RSjG64V9+d26LLoGlvI4VZjf5J7T0lZDMh+nCmPsfNIzvw8hwfRjPHgvoMEdO5igExS0Zxw9oRjH+LnIxZH6+uc9rRFrwi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712749386; c=relaxed/simple;
	bh=bYu+Cly443oGonfr4CYOHk3rbzOX79VqYDY6zRONtuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V2OBRoXyl0BkpwuiQFuxtoj5VB0os0FvCCg7ewc40vIBphUjuhL4QjwQNSjWlYlYTyMHQMFajSUq2M/urXD8rEYNJzfZXO6Dbt7ZiAcj3A58YW9bEMnjBmAVBhMtwX4H0JdekplRX3mAe9QQUrrEFhcBZ71xo0T6TOC9fR3/dZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Om2nAfmu; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712749385; x=1744285385;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bYu+Cly443oGonfr4CYOHk3rbzOX79VqYDY6zRONtuc=;
  b=Om2nAfmuZVlKKS+rxFFQfWBGEDRdFHD60NKBCGt6iVJXGJ1RqyCTSpad
   aPSJ4QIfZluCtIc/uuSpPexkiewLz0T2zcjpSYm5rOInyuBy1AWvdrbsf
   DSENJbSToBof9mSOQ3cDloseVXMW8cb8aGJnCNCuO5ZvRLJxxwDcX9vik
   xvdYepUi/ko1fIFJYqs7v52QR4wmIMH2eM5CVs32Ztpu2Yf2RIagXBN0Q
   IWO7v6vAKOOslkgyzssaDSKxxpxN8x8jJQ+02MzKcJnfSnVVcUbkjJxFs
   tB+hcRyVImJyNl7VBnBH0H5/3hH60NqtqVzAe1ZMDLltAaGj4BP8FaTs7
   A==;
X-CSE-ConnectionGUID: tJExrTZ2RxqOR1+U49glHA==
X-CSE-MsgGUID: Mcce60TzRqyi203cDUzP8A==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="18669800"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="18669800"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 04:43:04 -0700
X-CSE-ConnectionGUID: uc9i5EdfQaa6LY8+Fc0X1Q==
X-CSE-MsgGUID: DDoWaDriQjaYTz8GKWVESg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="20597813"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 04:43:02 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id DDD231203E6;
	Wed, 10 Apr 2024 14:42:59 +0300 (EEST)
Date: Wed, 10 Apr 2024 11:42:59 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-media@vger.kernel.org, tomi.valkeinen@ideasonboard.com,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Umang Jain <umang.jain@ideasonboard.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] media: v4l: Don't turn on privacy LED if streamon
 fails
Message-ID: <ZhZ7Q0Vi4z8l3sx7@kekkonen.localdomain>
References: <20240410100301.658824-1-sakari.ailus@linux.intel.com>
 <50457efb-f145-4eac-a625-28e3bfc8a7af@redhat.com>
 <ZhZ4o_B99V1trEE2@kekkonen.localdomain>
 <ZhZ5dZ68CM5IBMtW@kekkonen.localdomain>
 <b4960c23-4354-427b-8201-6b7531f1343e@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4960c23-4354-427b-8201-6b7531f1343e@redhat.com>

On Wed, Apr 10, 2024 at 01:37:13PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 4/10/24 1:35 PM, Sakari Ailus wrote:
> > On Wed, Apr 10, 2024 at 11:31:48AM +0000, Sakari Ailus wrote:
> >> Hi Hans,
> >>
> >> Thanks for the review.
> >>
> >> On Wed, Apr 10, 2024 at 12:12:33PM +0200, Hans de Goede wrote:
> >>> Hi Sakari,
> >>>
> >>> Thank you for fixing this.
> >>>
> >>> On 4/10/24 12:03 PM, Sakari Ailus wrote:
> >>>> Turn on the privacy LED only if streamon succeeds. This can be done after
> >>>> enabling streaming on the sensor.
> >>>>
> >>>> Fixes: b6e10ff6c23d ("media: v4l2-core: Make the v4l2-core code enable/disable the privacy LED if present")
> >>>> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> >>>> ---
> >>>>  drivers/media/v4l2-core/v4l2-subdev.c | 19 ++++++++++---------
> >>>>  1 file changed, 10 insertions(+), 9 deletions(-)
> >>>>
> >>>> diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
> >>>> index 4c6198c48dd6..acb7c3003ab6 100644
> >>>> --- a/drivers/media/v4l2-core/v4l2-subdev.c
> >>>> +++ b/drivers/media/v4l2-core/v4l2-subdev.c
> >>>> @@ -412,15 +412,6 @@ static int call_s_stream(struct v4l2_subdev *sd, int enable)
> >>>>  	if (WARN_ON(!!sd->enabled_streams == !!enable))
> >>>>  		return 0;
> >>>>  
> >>>> -#if IS_REACHABLE(CONFIG_LEDS_CLASS)
> >>>> -	if (!IS_ERR_OR_NULL(sd->privacy_led)) {
> >>>> -		if (enable)
> >>>> -			led_set_brightness(sd->privacy_led,
> >>>> -					   sd->privacy_led->max_brightness);
> >>>> -		else
> >>>> -			led_set_brightness(sd->privacy_led, 0);
> >>>> -	}
> >>>> -#endif
> >>>>  	ret = sd->ops->video->s_stream(sd, enable);
> >>>>  
> >>>>  	if (!enable && ret < 0) {
> >>>> @@ -431,6 +422,16 @@ static int call_s_stream(struct v4l2_subdev *sd, int enable)
> >>>>  	if (!ret)
> >>>>  		sd->enabled_streams = enable ? BIT(0) : 0;
> >>>>  
> >>>> +#if IS_REACHABLE(CONFIG_LEDS_CLASS)
> >>>> +	if (!IS_ERR_OR_NULL(sd->privacy_led) && !(enable && ret < 0)) {
> >>>
> >>> There already is a:
> >>>
> >>> 	if (!enable && ret < 0)
> >>> 		ret = 0;
> >>>
> >>> block above to ignore stream-off errors, so you can just test for:
> >>>
> >>> 	if (!ret && !IS_ERR_OR_NULL(sd->privacy_led)) {
> >>> 		...
> >>> 	}
> >>>
> >>> And then you can move the whole block to inside the existing:
> >>>
> >>> 	if (!ret)
> >>> 		sd->enabled_streams = enable ? BIT(0) : 0;
> >>>
> >>> block, so you get something like this:
> >>>
> >>> 	if (!ret) {
> >>> 		sd->enabled_streams = enable ? BIT(0) : 0;
> >>> #if IS_REACHABLE(CONFIG_LEDS_CLASS)
> >>> 		if (!IS_ERR_OR_NULL(sd->privacy_led)) {
> >>> 			if (enable)
> >>> 				led_set_brightness(sd->privacy_led,
> >>> 						   sd->privacy_led->max_brightness);
> >>> 			else
> >>> 				led_set_brightness(sd->privacy_led, 0);
> >>> 		}
> >>> #endif
> >>> 	}
> >>
> >> Seems reasonable, I'll send v2.
> > 
> > I was a bit too fast to hit y. ret will be non-zero if streamon fails
> > (enable non-zero), in which case the LED needs to be turned off. So you
> > can't have !ret condition for all LED control.
> 
> But if stream-on fails then AFAICT the LED was never turned on in the first
> place. stream on / off calls must always be balanced, right ?
> 
> IOW stream-on is not supposed to get called if the device is already
> streaming and if the device is not already streaming then the LED will
> already be off.

Ah, right. I missed that part. I'll send v2 after all. :-)

-- 
Sakari Ailus

