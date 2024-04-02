Return-Path: <linux-kernel+bounces-127893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3245289526B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B388B1F250E2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155F9757FB;
	Tue,  2 Apr 2024 12:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RjsZUGY8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C146A03F;
	Tue,  2 Apr 2024 12:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712059546; cv=none; b=LcCPiPQ+rFbhh2hOPu3jSDyVtw69yC7JsyL16BI2pGze8bKDJFGaY0ry5pHT8sW3A/iix4z3gtxilEwRj3y2xXgNiqEvZ8pbOvuR0Osstg2iI/Z3g1tUnrwfHx06hxuLiZdQullgt7a/PthMt2YBcSPYuIIQFUQ52dsCW6Gsy+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712059546; c=relaxed/simple;
	bh=MXiVFYglo9a0lD9FKrDzt81eVpAoIVBb8XbGizouSO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NK+ZlCRJlvTbB/jF5rdaKYooaggJhrvbO+mLKSQh5I3v+lfls+qTi6VPdbaflXKJH5d6W8IAclNiXXXv165L+bWwIki91Cs3Uxs3xl8jXCWDi9B/07d2Wt75zkCRHmlrWkBK5PIRqkB7WdoTNXB9Wg5I2XnGQ8I58nOMpnkMLJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RjsZUGY8; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712059544; x=1743595544;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MXiVFYglo9a0lD9FKrDzt81eVpAoIVBb8XbGizouSO8=;
  b=RjsZUGY8o6TvgsDc7NBw4opXFD1mtBi/05WbCXi9cXMp/dxR16C00aoB
   Qh/A/MTo3msHJZcwbNcCTD3lb/JOjRtP3TQUQ9fdY3aOWRpW0PPKY0Pj+
   9NQ3L1Mv1FAVQEF26CD+ELVUG+zUVcqS/GRM2wpZvxhtid3mqLVxS9SVH
   l1tOYNGRZJzNaSqWsn2p+a3vid8pmdlRCr33broGiViL9Wijxug1bC2qv
   uMMDqsok8ncst0ezHrPI7JkNxMmQ1L3Bby9icYQsHB012hodKXkoHEcoD
   B1KjskB0lnTGl3EF7LLX6ZU9j1WI5D7eRXhdGOE3OlcnZWC2xEbY6gdgc
   w==;
X-CSE-ConnectionGUID: qxYzjyWuRcSxvbrp3G4wfw==
X-CSE-MsgGUID: VgNhC7nKQ9KgmoMD467Tdg==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="11006953"
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="11006953"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 05:05:44 -0700
X-CSE-ConnectionGUID: Rac8rd8oRVaoEqPtjk3EWw==
X-CSE-MsgGUID: iPTZEnUQS1O+zDo6e91svw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="17951367"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 05:05:42 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 24C42120352;
	Tue,  2 Apr 2024 15:05:39 +0300 (EEST)
Date: Tue, 2 Apr 2024 12:05:39 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Umang Jain <umang.jain@ideasonboard.com>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: v4l2-subdev: Support enable/disable_streams for
 single-pad subdevs
Message-ID: <Zgv0k01IQOFaMdSZ@kekkonen.localdomain>
References: <20240325-single-pad-enable-streams-v1-1-142e19896a72@ideasonboard.com>
 <20240325125055.GC23988@pendragon.ideasonboard.com>
 <ZgF10EVLrfF7cl57@kekkonen.localdomain>
 <0ad9841d-bb51-4512-9388-f9ce36372677@ideasonboard.com>
 <ZgG5xt07XQ7DJ1_W@kekkonen.localdomain>
 <e497a7a2-a973-4059-8981-1ea83ea3dd30@ideasonboard.com>
 <ZgP5A0sN9FCoIoPs@kekkonen.localdomain>
 <44e3f07f-9374-414e-a6db-a744127477b1@ideasonboard.com>
 <ZgQf_LX1ohYykGjv@kekkonen.localdomain>
 <a338c5a0-3239-4fb1-9af1-a127bcef366a@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a338c5a0-3239-4fb1-9af1-a127bcef366a@ideasonboard.com>

On Wed, Mar 27, 2024 at 03:39:31PM +0200, Tomi Valkeinen wrote:
> On 27/03/2024 15:32, Sakari Ailus wrote:
> > Heissulivei,
> > 
> > On Wed, Mar 27, 2024 at 01:06:42PM +0200, Tomi Valkeinen wrote:
> > > On 27/03/2024 12:46, Sakari Ailus wrote:
> > > > Heippa,
> > > > 
> > > > On Mon, Mar 25, 2024 at 07:56:46PM +0200, Tomi Valkeinen wrote:
> > > > > On 25/03/2024 19:52, Sakari Ailus wrote:
> > > > > > Moi,
> > > > > > 
> > > > > > On Mon, Mar 25, 2024 at 03:43:01PM +0200, Tomi Valkeinen wrote:
> > > > > > > On 25/03/2024 15:02, Sakari Ailus wrote:
> > > > > > > > Moi,
> > > > > > > > 
> > > > > > > > Thanks for the patch.
> > > > > > > > 
> > > > > > > > On Mon, Mar 25, 2024 at 02:50:55PM +0200, Laurent Pinchart wrote:
> > > > > > > > > Hi Tomi,
> > > > > > > > > 
> > > > > > > > > On Mon, Mar 25, 2024 at 02:43:23PM +0200, Tomi Valkeinen wrote:
> > > > > > > > > > Currently a subdevice with a single pad, e.g. a sensor subdevice, must
> > > > > > > > > > use the v4l2_subdev_video_ops.s_stream op, instead of
> > > > > > > > > > v4l2_subdev_pad_ops.enable/disable_streams. This is because the
> > > > > > > > > > enable/disable_streams machinery requires a routing table which a subdev
> > > > > > > > > > cannot have with a single pad.
> > > > > > > > > > 
> > > > > > > > > > Implement enable/disable_streams support for these single-pad subdevices
> > > > > > > > > > by assuming an implicit stream 0 when the subdevice has only one pad.
> > > > > > > > > > 
> > > > > > > > > > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> > > > > > > > > > ---
> > > > > > > > > > Even though I did send this patch, I'm not sure if this is necessary.
> > > > > > > > > > s_stream works fine for the subdevs with a single pad. With the upcoming
> > > > > > > > > > internal pads, adding an internal pad to the subdev will create a
> > > > > > > > > > routing table, and enable/disable_streams would get "fixed" that way.
> > > > > > > > 
> > > > > > > > I'd like to get rid of a redundant way to control streaming.
> > > > > > > 
> > > > > > > We can't get rid of it anyway, can we? We're not going to convert old
> > > > > > > drivers to streams.
> > > > > > 
> > > > > > I'd expect to do that but it'd take a long time. That being said, I think
> > > > > > we need to consider devices without pads (VCMs) so it may well be this
> > > > > > would remain after all.
> > > > > > 
> > > > > > > 
> > > > > > > For new drivers, yes, we shouldn't use s_stream. But is the answer for new
> > > > > > > sensor drivers this patch, or requiring an internal pad?
> > > > > > 
> > > > > > For new drivers I'd like to see an internal pad in fact.
> > > > > > {enable,disable}_streams is still internal to the kernel.
> > > > > 
> > > > > So, you think this patch should be dropped?
> > > > 
> > > > No, no. Not all sub-device drivers with pads are camera sensor drivers. :-)
> > > 
> > > Hmm, alright. So we want to support enable/disable_streams for sub-devices
> > > with multiple source pads but no routing (so probably no sink pads)?
> > 
> > That should be allowed indeed, in order to move from s_stream() to
> > {enable,disable}_streams().
> > 
> > > 
> > > > > > > > > > So perhaps the question is, do we want to support single-pad subdevs in
> > > > > > > > > > the future, in which case something like this patch is necessary, or
> > > > > > > > > > will all modern source subdev drivers have internal pads, in which
> > > > > > > > > > case this is not needed...
> > > > > > > > > 
> > > > > > > > > I think the latter would be best. I however can't guarantee we won't
> > > > > > > > > have valid use cases for (enable|disable)_streams on single-pad subdevs
> > > > > > > > > though, so you patch could still be interesting.
> > > > > > > > 
> > > > > > > > Instead of the number of pads, could we use instead the
> > > > > > > > V4L2_SUBDEV_FL_STREAMS flag or whether g_routing op is supported to
> > > > > > > > determine the need for this?
> > > > > > > 
> > > > > > > Maybe, but are they better? Do you see some issue with checking for the
> > > > > > > number of pads? I considered a few options, but then thought that the most
> > > > > > > safest test for this case is 1) one pad 2) enable/disable_streams
> > > > > > > implemented.
> > > > > > 
> > > > > > I think I'd actually prefer {enable,disable}_streams in fact.
> > > > > 
> > > > > Hmm, sorry, now I'm confused =). What do you mean with that?
> > > > 
> > > > I'd use V4L2_SUBDEV_FL_STREAMS flag instead of the number of pads. The
> > > > number of pads is less related to routing.
> > > 
> > > Well, with one pad you cannot have routing =).
> > > 
> > > In this patch I used sd->enabled_streams to track the enabled streams, but
> > > if we need to support multiple pads, I'll have to invent something new for
> > > that.
> > 
> > What exactly do you think needs to be changed? This is just about starting
> > and stopping streaming using a different sent of callbacks, right?
> 
> The helpers track which streams are enabled, so we need some place to store
> the enabled streams.
> 
> For V4L2_SUBDEV_FL_STREAMS we have that in state->stream_configs for each
> stream. For the one-source-pad case we have a subdev wide
> sd->enabled_streams to store that. But we don't have any place at the moment
> to store if a pad is enabled.

If there are is no support for routing, isn't streaming either enabled or
disabled on all of them?

-- 
Sakari Ailus

