Return-Path: <linux-kernel+bounces-129430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02307896ACB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 509DFB289BA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F761350D0;
	Wed,  3 Apr 2024 09:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aXtXJKrJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB58A131BDE;
	Wed,  3 Apr 2024 09:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712136606; cv=none; b=BlOm21AfH4en/njvK95gEQFBcGOFw9/V+oPeASCxVpZShnf4y7NbZNxmdLHhQjxw5FmeM6nBI5o7DNHOatZhgT9c2IVM3jA4jUgBhwtZECHeC0jUmvb2ZyjwGRBwqHvDJh3napwN7zEVaQsO8SyayJxU3+d5PCQgCpKqQ7ViRE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712136606; c=relaxed/simple;
	bh=QoKbGyy4QMxIL0KYm0lWzx3z1CfoCrAUTwjzogekqGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LCCNrvSsF+fddUIN2tO+gWjGfqDSAttc4Mi4qHYUBGlGy3UlG5FZ/llXinIvBTcWHOUQ0hwrO/F5I56robaDL1WV6ZrG6raDJkjHkFNEh0vdIuiP15FNsCKZxk6ovuHXBra6tsYSWvDjvxifdQUw9irKVYoUU2SGFceQvEPsWIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aXtXJKrJ; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712136605; x=1743672605;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QoKbGyy4QMxIL0KYm0lWzx3z1CfoCrAUTwjzogekqGI=;
  b=aXtXJKrJ3awm1V2af+9zGp5URHi8XzkefAHxGVh2oEH/zk+sDrHnGY50
   I/wYkgSoygOMictR1v4GrKNSI+w6PHQfbEMD4fgmhGAIGJ+ibVihVWxXW
   R12Opvq2FDvBeGX/wtN8z5Bsf3z9kiRUg4Kylqh9lE8eHU6NQdSZDqBo6
   FsRU1h4pxcj9rpqLmirtgtMJ12DiY6Fxpc66H9cfl0iEIrmaUOO5AvqP/
   MPYPdv2uSeZ7KZAGw2svK/jNDwsSqPs9yoBnq3/E2F3WRaiNltdclGwvM
   hxeQ8xhEo5gJPmS7ZnfnZ0tJDzhqkVWkBffzR1q3X6rkZXmrJ2UFxJIb2
   g==;
X-CSE-ConnectionGUID: q1ZIBu7NT1S6lGppqno09A==
X-CSE-MsgGUID: YLH2F+efRU6w1GdSAuthHw==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7201791"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="7201791"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 02:30:04 -0700
X-CSE-ConnectionGUID: eCij0JopReyJC0CibFVPqA==
X-CSE-MsgGUID: F8qU8OXlTR25FldlObSYuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="22854616"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 02:30:02 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id DB3D711F8DF;
	Wed,  3 Apr 2024 12:29:59 +0300 (EEST)
Date: Wed, 3 Apr 2024 09:29:59 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Umang Jain <umang.jain@ideasonboard.com>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: v4l2-subdev: Support enable/disable_streams for
 single-pad subdevs
Message-ID: <Zg0hl7JqQ1zZo-Ti@kekkonen.localdomain>
References: <ZgF10EVLrfF7cl57@kekkonen.localdomain>
 <0ad9841d-bb51-4512-9388-f9ce36372677@ideasonboard.com>
 <ZgG5xt07XQ7DJ1_W@kekkonen.localdomain>
 <e497a7a2-a973-4059-8981-1ea83ea3dd30@ideasonboard.com>
 <ZgP5A0sN9FCoIoPs@kekkonen.localdomain>
 <44e3f07f-9374-414e-a6db-a744127477b1@ideasonboard.com>
 <ZgQf_LX1ohYykGjv@kekkonen.localdomain>
 <a338c5a0-3239-4fb1-9af1-a127bcef366a@ideasonboard.com>
 <Zgv0k01IQOFaMdSZ@kekkonen.localdomain>
 <a77160ef-7586-4b9b-8013-daf0872c4ab8@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a77160ef-7586-4b9b-8013-daf0872c4ab8@ideasonboard.com>

On Wed, Apr 03, 2024 at 12:25:44PM +0300, Tomi Valkeinen wrote:
> On 02/04/2024 15:05, Sakari Ailus wrote:
> > On Wed, Mar 27, 2024 at 03:39:31PM +0200, Tomi Valkeinen wrote:
> > > On 27/03/2024 15:32, Sakari Ailus wrote:
> > > > Heissulivei,
> > > > 
> > > > On Wed, Mar 27, 2024 at 01:06:42PM +0200, Tomi Valkeinen wrote:
> > > > > On 27/03/2024 12:46, Sakari Ailus wrote:
> > > > > > Heippa,
> > > > > > 
> > > > > > On Mon, Mar 25, 2024 at 07:56:46PM +0200, Tomi Valkeinen wrote:
> > > > > > > On 25/03/2024 19:52, Sakari Ailus wrote:
> > > > > > > > Moi,
> > > > > > > > 
> > > > > > > > On Mon, Mar 25, 2024 at 03:43:01PM +0200, Tomi Valkeinen wrote:
> > > > > > > > > On 25/03/2024 15:02, Sakari Ailus wrote:
> > > > > > > > > > Moi,
> > > > > > > > > > 
> > > > > > > > > > Thanks for the patch.
> > > > > > > > > > 
> > > > > > > > > > On Mon, Mar 25, 2024 at 02:50:55PM +0200, Laurent Pinchart wrote:
> > > > > > > > > > > Hi Tomi,
> > > > > > > > > > > 
> > > > > > > > > > > On Mon, Mar 25, 2024 at 02:43:23PM +0200, Tomi Valkeinen wrote:
> > > > > > > > > > > > Currently a subdevice with a single pad, e.g. a sensor subdevice, must
> > > > > > > > > > > > use the v4l2_subdev_video_ops.s_stream op, instead of
> > > > > > > > > > > > v4l2_subdev_pad_ops.enable/disable_streams. This is because the
> > > > > > > > > > > > enable/disable_streams machinery requires a routing table which a subdev
> > > > > > > > > > > > cannot have with a single pad.
> > > > > > > > > > > > 
> > > > > > > > > > > > Implement enable/disable_streams support for these single-pad subdevices
> > > > > > > > > > > > by assuming an implicit stream 0 when the subdevice has only one pad.
> > > > > > > > > > > > 
> > > > > > > > > > > > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> > > > > > > > > > > > ---
> > > > > > > > > > > > Even though I did send this patch, I'm not sure if this is necessary.
> > > > > > > > > > > > s_stream works fine for the subdevs with a single pad. With the upcoming
> > > > > > > > > > > > internal pads, adding an internal pad to the subdev will create a
> > > > > > > > > > > > routing table, and enable/disable_streams would get "fixed" that way.
> > > > > > > > > > 
> > > > > > > > > > I'd like to get rid of a redundant way to control streaming.
> > > > > > > > > 
> > > > > > > > > We can't get rid of it anyway, can we? We're not going to convert old
> > > > > > > > > drivers to streams.
> > > > > > > > 
> > > > > > > > I'd expect to do that but it'd take a long time. That being said, I think
> > > > > > > > we need to consider devices without pads (VCMs) so it may well be this
> > > > > > > > would remain after all.
> > > > > > > > 
> > > > > > > > > 
> > > > > > > > > For new drivers, yes, we shouldn't use s_stream. But is the answer for new
> > > > > > > > > sensor drivers this patch, or requiring an internal pad?
> > > > > > > > 
> > > > > > > > For new drivers I'd like to see an internal pad in fact.
> > > > > > > > {enable,disable}_streams is still internal to the kernel.
> > > > > > > 
> > > > > > > So, you think this patch should be dropped?
> > > > > > 
> > > > > > No, no. Not all sub-device drivers with pads are camera sensor drivers. :-)
> > > > > 
> > > > > Hmm, alright. So we want to support enable/disable_streams for sub-devices
> > > > > with multiple source pads but no routing (so probably no sink pads)?
> > > > 
> > > > That should be allowed indeed, in order to move from s_stream() to
> > > > {enable,disable}_streams().
> > > > 
> > > > > 
> > > > > > > > > > > > So perhaps the question is, do we want to support single-pad subdevs in
> > > > > > > > > > > > the future, in which case something like this patch is necessary, or
> > > > > > > > > > > > will all modern source subdev drivers have internal pads, in which
> > > > > > > > > > > > case this is not needed...
> > > > > > > > > > > 
> > > > > > > > > > > I think the latter would be best. I however can't guarantee we won't
> > > > > > > > > > > have valid use cases for (enable|disable)_streams on single-pad subdevs
> > > > > > > > > > > though, so you patch could still be interesting.
> > > > > > > > > > 
> > > > > > > > > > Instead of the number of pads, could we use instead the
> > > > > > > > > > V4L2_SUBDEV_FL_STREAMS flag or whether g_routing op is supported to
> > > > > > > > > > determine the need for this?
> > > > > > > > > 
> > > > > > > > > Maybe, but are they better? Do you see some issue with checking for the
> > > > > > > > > number of pads? I considered a few options, but then thought that the most
> > > > > > > > > safest test for this case is 1) one pad 2) enable/disable_streams
> > > > > > > > > implemented.
> > > > > > > > 
> > > > > > > > I think I'd actually prefer {enable,disable}_streams in fact.
> > > > > > > 
> > > > > > > Hmm, sorry, now I'm confused =). What do you mean with that?
> > > > > > 
> > > > > > I'd use V4L2_SUBDEV_FL_STREAMS flag instead of the number of pads. The
> > > > > > number of pads is less related to routing.
> > > > > 
> > > > > Well, with one pad you cannot have routing =).
> > > > > 
> > > > > In this patch I used sd->enabled_streams to track the enabled streams, but
> > > > > if we need to support multiple pads, I'll have to invent something new for
> > > > > that.
> > > > 
> > > > What exactly do you think needs to be changed? This is just about starting
> > > > and stopping streaming using a different sent of callbacks, right?
> > > 
> > > The helpers track which streams are enabled, so we need some place to store
> > > the enabled streams.
> > > 
> > > For V4L2_SUBDEV_FL_STREAMS we have that in state->stream_configs for each
> > > stream. For the one-source-pad case we have a subdev wide
> > > sd->enabled_streams to store that. But we don't have any place at the moment
> > > to store if a pad is enabled.
> > 
> > If there are is no support for routing, isn't streaming either enabled or
> > disabled on all of them?
> 
> Hmm, no, I don't see why that would be the case. If a subdev has two source
> pads, and it gets an enable_streams() call on the first source pad, why
> would the second source pad be enabled too?

Because when there are no routes, all pads are interconnected so streaming
starts or stops on all pads at the same time?

-- 
Sakari Ailus

