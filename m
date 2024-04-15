Return-Path: <linux-kernel+bounces-144650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE168A48CB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A777628236E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76AC224DC;
	Mon, 15 Apr 2024 07:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="luW4KWpA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A9920DD3;
	Mon, 15 Apr 2024 07:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713165349; cv=none; b=Oy5V190DowNRnqRNCzreuJZIahiGY8Mh0L7ZOLaoYHYDx44op5WF0lGWjoYc7anMguMdwdjbP+9yEiXHLQpoqWcgaBaiFfnmfJRrE3k9cfqxqXS2s4eA3GLoLyzdAXFCBBOhGZmywCZS1wDrP2sES1u9qhnnuhDKK2mxu7tlgis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713165349; c=relaxed/simple;
	bh=6cH2Uu4HCsDWucsxgs3vSFvjIgYCW2Exz0TqF+z3wAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P0sdvdWw16DTY5x5aFA6vYKjxQpWDh2N5XawIyUB/rchxy/DlYx7nARUj02XkU7ATmPadsM847xkrKJI/J7nXmWLOtsAcLY82iC7RE7wEWEw2c4erkgTnru5SIS/V9zyBQCyXBG1heBUPnGBT6rzQ6rr7vFgFjwjpuK7ofZICw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=luW4KWpA; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713165348; x=1744701348;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6cH2Uu4HCsDWucsxgs3vSFvjIgYCW2Exz0TqF+z3wAE=;
  b=luW4KWpAqIfECmKpcpMJ4rRhEQwV1bwWOcFN/6CHuvYBq8wXyKh8cCRG
   1uhW/as7WgjC0ynd7IHs6DwqbBEYUglvtIRWZ+ZsGyAMwRnzkD3uLVFGk
   qvH/OZ8fEiT1mDl3CrFG1n5qkn2VYzyt8MC5CttnWGXZdYe/hmu1/gRj+
   AW433Y1PV8iv6UN0ROnsMW/u2QLM4ZJATS81LTifVReiHmHD0IGI72I9N
   GxRkeNz3keVGpNyLbdsbpGxvjkxWd/W/VGv++EGeFcx2pancdq7rvEMtq
   Qgt2oJgB10uvsGyOKoNgxwCAZx0NEAWB44/COHa1UK3r5oo6CVkha0/Nq
   g==;
X-CSE-ConnectionGUID: eQPiDdHMSV+82qZjSo987A==
X-CSE-MsgGUID: AJU4H9m0T8iIpbLBrccAbg==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="8405338"
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="8405338"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 00:15:48 -0700
X-CSE-ConnectionGUID: bvtdr4X8T0OxFWnTbU1k8Q==
X-CSE-MsgGUID: tmq31PqqTP+FCGYAutUjug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="22398955"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 00:15:45 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 8F7DF11F8AF;
	Mon, 15 Apr 2024 10:15:42 +0300 (EEST)
Date: Mon, 15 Apr 2024 07:15:42 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-media@vger.kernel.org, tomi.valkeinen@ideasonboard.com,
	Hans de Goede <hdegoede@redhat.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Umang Jain <umang.jain@ideasonboard.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] media: v4l: Don't turn on privacy LED if streamon
 fails
Message-ID: <ZhzUHs7lpdeMa22l@kekkonen.localdomain>
References: <20240410114712.661186-1-sakari.ailus@linux.intel.com>
 <20240412174621.GA5444@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412174621.GA5444@pendragon.ideasonboard.com>

Hi Laurent,

On Fri, Apr 12, 2024 at 08:46:21PM +0300, Laurent Pinchart wrote:
> Hi Sakari,
> 
> Thank you for the patch.
> 
> On Wed, Apr 10, 2024 at 02:47:12PM +0300, Sakari Ailus wrote:
> > Turn on the privacy LED only if streamon succeeds. This can be done after
> > enabling streaming on the sensor.
> > 
> > Fixes: b6e10ff6c23d ("media: v4l2-core: Make the v4l2-core code enable/disable the privacy LED if present")
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > ---
> >  drivers/media/v4l2-core/v4l2-subdev.c | 22 ++++++++++++----------
> >  1 file changed, 12 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
> > index 4c6198c48dd6..012b757eac9f 100644
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
> > @@ -428,9 +419,20 @@ static int call_s_stream(struct v4l2_subdev *sd, int enable)
> >  		ret = 0;
> >  	}
> >  
> > -	if (!ret)
> > +	if (!ret) {
> >  		sd->enabled_streams = enable ? BIT(0) : 0;
> >  
> > +#if IS_REACHABLE(CONFIG_LEDS_CLASS)
> > +		if (!IS_ERR_OR_NULL(sd->privacy_led)) {
> > +			if (enable)
> > +				led_set_brightness(sd->privacy_led,
> > +						   sd->privacy_led->max_brightness);
> > +			else
> > +				led_set_brightness(sd->privacy_led, 0);
> > +		}
> > +#endif
> 
> This means that the LED will be turned slightly after the camera is
> enabled. I don't think it's an issue in practice. Another possibly more

That's what I'd think as well. Typically even the exposure time is much,
much longer than what it takes to get here.

> important concern is that we should maybe check the return value of
> led_set_brightness(), and fail .s_stream() when we can't enable the
> privacy LED at stream on time. In that case, it would be best to keep
> turning the privacy LED on before calling .s_stream(). It should still
> be turned off only after calling .s_stream() though.

The return type of led_set_brightness() is void. Maybe because a large
majority is GPIO-controlled?

-- 
Regards,

Sakari Ailus

