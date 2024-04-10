Return-Path: <linux-kernel+bounces-138414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D592C89F0EE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12F8B1C20C81
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BA615991C;
	Wed, 10 Apr 2024 11:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hkEshHke"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC80159574;
	Wed, 10 Apr 2024 11:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712748715; cv=none; b=mz/X+ypYBwFDnYfOnUCjtrSaHuycXHXYFeQmnCP1TWDJhTwgcLWBmXSwfsKUqg1ve9wfWxH0sWutNbw9NmxYNe7TDh8jvrazj6SXsrwFZHPLlUQgjTRipLJ5pIV039/d4EJtvPGvETF/sSeINU7CjqzhExx7LqZEsxZ+ftZ8yrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712748715; c=relaxed/simple;
	bh=5sSQ86qr8d5vM2cW2QvQ3quhmmC9GGv+5QhAl43SbTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l2X2uuZAvVNJhqdwpKvqh7vNceTItGJ93UpQMeHvdooDit8ZHcWN+pgPG3vVapL7xR5+AsRonF6WnLe0rvVHBWoBZ7NXQiEvknbo4iAI59GwPGFk5q8Km/wyn9pejC/if2mDsIjr+3kYSrz+ExHfKITarG0fp1awQbC+RorAFUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hkEshHke; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712748714; x=1744284714;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5sSQ86qr8d5vM2cW2QvQ3quhmmC9GGv+5QhAl43SbTY=;
  b=hkEshHkeYuJTEL4C6X6ak1saD0WpQlYJuV7mqj2uEGw6buti+fOUnScR
   ANLdbUUZMGnKHVnFpsJ5/I6DKvTkC2UY7evve97Y1ilvLSvmQz3j9wO0s
   Px83On0Grkx5Q2TeMFWDndDr2lICI3H9IzaU63aKLvq6S7eRNare1OIrp
   jcfwlvuuFcsjl9zmHkyQU8VriTuFtJO6X049rl7Ula5EyAp5WcSCQ6ZZb
   3dOV6stCwSK7vRWxMrAEPUT2ABjXStmA6Zmyq+XxHZ74an7O/0JAjf0i4
   FeCHShdEF5czRvYLwnw+IBB30F+l4AQRI7KVbvQt6pLau/eKmLFfI0GCw
   g==;
X-CSE-ConnectionGUID: 3ZixcB7rSiWpNOOAo369zw==
X-CSE-MsgGUID: R69Onw9kQh++THZju+ydGQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="18668597"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="18668597"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 04:31:54 -0700
X-CSE-ConnectionGUID: Hz3adGCaRVSLRuhTqToDeg==
X-CSE-MsgGUID: w3u/QF3gThSnmezPLT7KMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="20959292"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 04:31:51 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 088221203E6;
	Wed, 10 Apr 2024 14:31:48 +0300 (EEST)
Date: Wed, 10 Apr 2024 11:31:47 +0000
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
Message-ID: <ZhZ4o_B99V1trEE2@kekkonen.localdomain>
References: <20240410100301.658824-1-sakari.ailus@linux.intel.com>
 <50457efb-f145-4eac-a625-28e3bfc8a7af@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50457efb-f145-4eac-a625-28e3bfc8a7af@redhat.com>

Hi Hans,

Thanks for the review.

On Wed, Apr 10, 2024 at 12:12:33PM +0200, Hans de Goede wrote:
> Hi Sakari,
> 
> Thank you for fixing this.
> 
> On 4/10/24 12:03 PM, Sakari Ailus wrote:
> > Turn on the privacy LED only if streamon succeeds. This can be done after
> > enabling streaming on the sensor.
> > 
> > Fixes: b6e10ff6c23d ("media: v4l2-core: Make the v4l2-core code enable/disable the privacy LED if present")
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > ---
> >  drivers/media/v4l2-core/v4l2-subdev.c | 19 ++++++++++---------
> >  1 file changed, 10 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
> > index 4c6198c48dd6..acb7c3003ab6 100644
> > --- a/drivers/media/v4l2-core/v4l2-subdev.c
> > +++ b/drivers/media/v4l2-core/v4l2-subdev.c
> > @@ -412,15 +412,6 @@ static int call_s_stream(struct v4l2_subdev *sd, int enable)
> >  	if (WARN_ON(!!sd->enabled_streams == !!enable))
> >  		return 0;
> >  
> > -#if IS_REACHABLE(CONFIG_LEDS_CLASS)
> > -	if (!IS_ERR_OR_NULL(sd->privacy_led)) {
> > -		if (enable)
> > -			led_set_brightness(sd->privacy_led,
> > -					   sd->privacy_led->max_brightness);
> > -		else
> > -			led_set_brightness(sd->privacy_led, 0);
> > -	}
> > -#endif
> >  	ret = sd->ops->video->s_stream(sd, enable);
> >  
> >  	if (!enable && ret < 0) {
> > @@ -431,6 +422,16 @@ static int call_s_stream(struct v4l2_subdev *sd, int enable)
> >  	if (!ret)
> >  		sd->enabled_streams = enable ? BIT(0) : 0;
> >  
> > +#if IS_REACHABLE(CONFIG_LEDS_CLASS)
> > +	if (!IS_ERR_OR_NULL(sd->privacy_led) && !(enable && ret < 0)) {
> 
> There already is a:
> 
> 	if (!enable && ret < 0)
> 		ret = 0;
> 
> block above to ignore stream-off errors, so you can just test for:
> 
> 	if (!ret && !IS_ERR_OR_NULL(sd->privacy_led)) {
> 		...
> 	}
> 
> And then you can move the whole block to inside the existing:
> 
> 	if (!ret)
> 		sd->enabled_streams = enable ? BIT(0) : 0;
> 
> block, so you get something like this:
> 
> 	if (!ret) {
> 		sd->enabled_streams = enable ? BIT(0) : 0;
> #if IS_REACHABLE(CONFIG_LEDS_CLASS)
> 		if (!IS_ERR_OR_NULL(sd->privacy_led)) {
> 			if (enable)
> 				led_set_brightness(sd->privacy_led,
> 						   sd->privacy_led->max_brightness);
> 			else
> 				led_set_brightness(sd->privacy_led, 0);
> 		}
> #endif
> 	}

Seems reasonable, I'll send v2.

> 
> Which then cleans up nicely by Tomi's patch
> introducing the privacy LED helper functions,
> to something like this:
> 
> 	if (!ret {
> 		if (enable) {
> 			sd->enabled_streams = BIT(0);
> 			v4l2_subdev_enable_privacy_led(sd);
> 		} else {
> 			sd->enabled_streams = 0;
> 			v4l2_subdev_disable_privacy_led(sd);
> 		}
> 	}
> 

-- 
Kind regards,

Sakari Ailus

