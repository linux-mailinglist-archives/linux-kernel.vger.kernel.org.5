Return-Path: <linux-kernel+bounces-138418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B01789F0F9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF9FC1F241BB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F83715ADBD;
	Wed, 10 Apr 2024 11:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QZZl6Ra4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B7015991C;
	Wed, 10 Apr 2024 11:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712748924; cv=none; b=PjUIAb5qFZDfAnHKRW8Gi/j4McgWoGc3jVPGDWOjACxy8nTJq/WAsRbcEtlkQ29L1VhQ8xikLK8jEPO15eKAm5CxqpkQeB3DOQYe9yElFb4eXEumuC1+JEnCLSJCALVig2u50pnYXWdUKTr7iqu/y8MunFmf1qely8841l5sskA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712748924; c=relaxed/simple;
	bh=WAPU6TZq94HOOrduRuV0iJLOXnqI/oChsgFnm0w5Lpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MynsS8eHF6pEzSeHQuAVvJx1GW0pCOx53OtJZYa/8F9o9bTqqVxhQwkUMg85GLTfnT9+yWELYNpBQM80uvH4J1DdzVwa+T5b8TgTAVWu4aG71YPYw1zpS7vTRqs+9Wo1PWyLdf37d4pvDjEZjncOpe6QVkDUNzE19oi/jlW3aXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QZZl6Ra4; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712748923; x=1744284923;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WAPU6TZq94HOOrduRuV0iJLOXnqI/oChsgFnm0w5Lpk=;
  b=QZZl6Ra4oG2a12vRN+IBiEkUAZy7GzxIggX0+2QPq8Zo9p9waZHMFnws
   JP+vVO+LobQQAf8nuoYrLuijtILwvJmxnA2sWTsF49CZ48IpGB2fL+nvq
   S++fsvSO1po7AuJfFfdiylpsJCHF+XueRyPZvcUoZx/q6l3u1Ktycqxxq
   fQInLL6itwLNr9Bh07PPSR7P+/XHm3g6y/8zX992MpstN7qaQVjiEQv4o
   xesSWiSNdiI4XuJ1E1aXZrvrRNY0u2MDVyaapD0P21W/6JqY/T9T/EOJv
   eWZB4gur7rdTxymwxno0gu58UEBRx5KS26xmqtdZHPx4qmp1UvGbDrboO
   g==;
X-CSE-ConnectionGUID: YPftoa8CT+OCGnXkArxrBA==
X-CSE-MsgGUID: Ojx0L/DuQCSh7gdeYvQYCA==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="25546973"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="25546973"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 04:35:22 -0700
X-CSE-ConnectionGUID: 4nFa3ea5SeqBf/jYwJ/3rg==
X-CSE-MsgGUID: FugMJMziSXO9/htfTrxK+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="20549649"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 04:35:21 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id D76D11203E6;
	Wed, 10 Apr 2024 14:35:17 +0300 (EEST)
Date: Wed, 10 Apr 2024 11:35:17 +0000
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
Message-ID: <ZhZ5dZ68CM5IBMtW@kekkonen.localdomain>
References: <20240410100301.658824-1-sakari.ailus@linux.intel.com>
 <50457efb-f145-4eac-a625-28e3bfc8a7af@redhat.com>
 <ZhZ4o_B99V1trEE2@kekkonen.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhZ4o_B99V1trEE2@kekkonen.localdomain>

On Wed, Apr 10, 2024 at 11:31:48AM +0000, Sakari Ailus wrote:
> Hi Hans,
> 
> Thanks for the review.
> 
> On Wed, Apr 10, 2024 at 12:12:33PM +0200, Hans de Goede wrote:
> > Hi Sakari,
> > 
> > Thank you for fixing this.
> > 
> > On 4/10/24 12:03 PM, Sakari Ailus wrote:
> > > Turn on the privacy LED only if streamon succeeds. This can be done after
> > > enabling streaming on the sensor.
> > > 
> > > Fixes: b6e10ff6c23d ("media: v4l2-core: Make the v4l2-core code enable/disable the privacy LED if present")
> > > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > ---
> > >  drivers/media/v4l2-core/v4l2-subdev.c | 19 ++++++++++---------
> > >  1 file changed, 10 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
> > > index 4c6198c48dd6..acb7c3003ab6 100644
> > > --- a/drivers/media/v4l2-core/v4l2-subdev.c
> > > +++ b/drivers/media/v4l2-core/v4l2-subdev.c
> > > @@ -412,15 +412,6 @@ static int call_s_stream(struct v4l2_subdev *sd, int enable)
> > >  	if (WARN_ON(!!sd->enabled_streams == !!enable))
> > >  		return 0;
> > >  
> > > -#if IS_REACHABLE(CONFIG_LEDS_CLASS)
> > > -	if (!IS_ERR_OR_NULL(sd->privacy_led)) {
> > > -		if (enable)
> > > -			led_set_brightness(sd->privacy_led,
> > > -					   sd->privacy_led->max_brightness);
> > > -		else
> > > -			led_set_brightness(sd->privacy_led, 0);
> > > -	}
> > > -#endif
> > >  	ret = sd->ops->video->s_stream(sd, enable);
> > >  
> > >  	if (!enable && ret < 0) {
> > > @@ -431,6 +422,16 @@ static int call_s_stream(struct v4l2_subdev *sd, int enable)
> > >  	if (!ret)
> > >  		sd->enabled_streams = enable ? BIT(0) : 0;
> > >  
> > > +#if IS_REACHABLE(CONFIG_LEDS_CLASS)
> > > +	if (!IS_ERR_OR_NULL(sd->privacy_led) && !(enable && ret < 0)) {
> > 
> > There already is a:
> > 
> > 	if (!enable && ret < 0)
> > 		ret = 0;
> > 
> > block above to ignore stream-off errors, so you can just test for:
> > 
> > 	if (!ret && !IS_ERR_OR_NULL(sd->privacy_led)) {
> > 		...
> > 	}
> > 
> > And then you can move the whole block to inside the existing:
> > 
> > 	if (!ret)
> > 		sd->enabled_streams = enable ? BIT(0) : 0;
> > 
> > block, so you get something like this:
> > 
> > 	if (!ret) {
> > 		sd->enabled_streams = enable ? BIT(0) : 0;
> > #if IS_REACHABLE(CONFIG_LEDS_CLASS)
> > 		if (!IS_ERR_OR_NULL(sd->privacy_led)) {
> > 			if (enable)
> > 				led_set_brightness(sd->privacy_led,
> > 						   sd->privacy_led->max_brightness);
> > 			else
> > 				led_set_brightness(sd->privacy_led, 0);
> > 		}
> > #endif
> > 	}
> 
> Seems reasonable, I'll send v2.

I was a bit too fast to hit y. ret will be non-zero if streamon fails
(enable non-zero), in which case the LED needs to be turned off. So you
can't have !ret condition for all LED control.

> 
> > 
> > Which then cleans up nicely by Tomi's patch
> > introducing the privacy LED helper functions,
> > to something like this:
> > 
> > 	if (!ret {
> > 		if (enable) {
> > 			sd->enabled_streams = BIT(0);
> > 			v4l2_subdev_enable_privacy_led(sd);
> > 		} else {
> > 			sd->enabled_streams = 0;
> > 			v4l2_subdev_disable_privacy_led(sd);
> > 		}
> > 	}
> > 
> 

-- 
Sakari Ailus

