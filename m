Return-Path: <linux-kernel+bounces-121367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 754DE88E7BA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5F12B334D6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BD413CC52;
	Wed, 27 Mar 2024 13:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wrm9m3dJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7718212A144;
	Wed, 27 Mar 2024 13:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711546402; cv=none; b=drvwTzrqgA4rKcdOV1vyTe95xQy3PuWc6LqquoNHM07zBs9DCrA+zZfc0jkz4pm2ucZKXy3GjWYFS8QeVVUPjXYVvTzYOM+92iKBBdajauK9nPwpWSJMVBJB166LfaK/AgOKxLbJARwimVGwUmxUluN2LKSk+ByvLSc1PUXbnrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711546402; c=relaxed/simple;
	bh=ARtS+/GoVBY96qRYfTiri1+GreyI66aUneS6w1eDG9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=syj0Xo18WH1oDevfe7JYBcRNH0Vkd05Kt6omg6h1Mihc1mDxB/5Ur9vMs3/z8R/3nkCqfvXyBswR2jHEzcAScLSxO8H8kg9PrdXrTTX8c9hO1VgMF2c/WV5LM4MIZOVH527QNsXx8G7KYCGlUX9M9GsBYp3fhIhpMkdCO0r9jOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wrm9m3dJ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711546401; x=1743082401;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ARtS+/GoVBY96qRYfTiri1+GreyI66aUneS6w1eDG9M=;
  b=Wrm9m3dJM1fWXRRgTe3/z32t+8RR2RXzMRqYZ0l9SvgjhKURCMO+QzHZ
   ZXkyi1Ng6FWcWI3QMeDqZ9IvjwME/X4Flkj/F5/5yaoK+RxAD90q/6qJE
   MXcfXIZiamXMYYRcax38Npk5IIqXv7eMbgP+YfI4lmuZN1FnQvO6NmHdE
   uyp4bfNBYCUQ0CaY5hyMBBuelJcrWqBrlvhJh7Rix1P08v3gKqcLpefrV
   d7Cs6xyNw4SjjgKR+v9nSJDULar6PnPXd0NodpHpEqYejzY368+xT5G3A
   Ya4+nPWycw6haBE4wekh53oOOpr3tqA2V7F8UpgmeSgFEJ+rATtWEZBWs
   g==;
X-CSE-ConnectionGUID: P6StHuWPSnyPyBeE5LpmUw==
X-CSE-MsgGUID: XLZpTOGYTR2DeCsBLsc6pQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="10428513"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="10428513"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 06:32:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="21006970"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 06:32:47 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 6A6AD11F8EA;
	Wed, 27 Mar 2024 15:32:44 +0200 (EET)
Date: Wed, 27 Mar 2024 13:32:44 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Umang Jain <umang.jain@ideasonboard.com>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: v4l2-subdev: Support enable/disable_streams for
 single-pad subdevs
Message-ID: <ZgQf_LX1ohYykGjv@kekkonen.localdomain>
References: <20240325-single-pad-enable-streams-v1-1-142e19896a72@ideasonboard.com>
 <20240325125055.GC23988@pendragon.ideasonboard.com>
 <ZgF10EVLrfF7cl57@kekkonen.localdomain>
 <0ad9841d-bb51-4512-9388-f9ce36372677@ideasonboard.com>
 <ZgG5xt07XQ7DJ1_W@kekkonen.localdomain>
 <e497a7a2-a973-4059-8981-1ea83ea3dd30@ideasonboard.com>
 <ZgP5A0sN9FCoIoPs@kekkonen.localdomain>
 <44e3f07f-9374-414e-a6db-a744127477b1@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44e3f07f-9374-414e-a6db-a744127477b1@ideasonboard.com>

Heissulivei,

On Wed, Mar 27, 2024 at 01:06:42PM +0200, Tomi Valkeinen wrote:
> On 27/03/2024 12:46, Sakari Ailus wrote:
> > Heippa,
> > 
> > On Mon, Mar 25, 2024 at 07:56:46PM +0200, Tomi Valkeinen wrote:
> > > On 25/03/2024 19:52, Sakari Ailus wrote:
> > > > Moi,
> > > > 
> > > > On Mon, Mar 25, 2024 at 03:43:01PM +0200, Tomi Valkeinen wrote:
> > > > > On 25/03/2024 15:02, Sakari Ailus wrote:
> > > > > > Moi,
> > > > > > 
> > > > > > Thanks for the patch.
> > > > > > 
> > > > > > On Mon, Mar 25, 2024 at 02:50:55PM +0200, Laurent Pinchart wrote:
> > > > > > > Hi Tomi,
> > > > > > > 
> > > > > > > On Mon, Mar 25, 2024 at 02:43:23PM +0200, Tomi Valkeinen wrote:
> > > > > > > > Currently a subdevice with a single pad, e.g. a sensor subdevice, must
> > > > > > > > use the v4l2_subdev_video_ops.s_stream op, instead of
> > > > > > > > v4l2_subdev_pad_ops.enable/disable_streams. This is because the
> > > > > > > > enable/disable_streams machinery requires a routing table which a subdev
> > > > > > > > cannot have with a single pad.
> > > > > > > > 
> > > > > > > > Implement enable/disable_streams support for these single-pad subdevices
> > > > > > > > by assuming an implicit stream 0 when the subdevice has only one pad.
> > > > > > > > 
> > > > > > > > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> > > > > > > > ---
> > > > > > > > Even though I did send this patch, I'm not sure if this is necessary.
> > > > > > > > s_stream works fine for the subdevs with a single pad. With the upcoming
> > > > > > > > internal pads, adding an internal pad to the subdev will create a
> > > > > > > > routing table, and enable/disable_streams would get "fixed" that way.
> > > > > > 
> > > > > > I'd like to get rid of a redundant way to control streaming.
> > > > > 
> > > > > We can't get rid of it anyway, can we? We're not going to convert old
> > > > > drivers to streams.
> > > > 
> > > > I'd expect to do that but it'd take a long time. That being said, I think
> > > > we need to consider devices without pads (VCMs) so it may well be this
> > > > would remain after all.
> > > > 
> > > > > 
> > > > > For new drivers, yes, we shouldn't use s_stream. But is the answer for new
> > > > > sensor drivers this patch, or requiring an internal pad?
> > > > 
> > > > For new drivers I'd like to see an internal pad in fact.
> > > > {enable,disable}_streams is still internal to the kernel.
> > > 
> > > So, you think this patch should be dropped?
> > 
> > No, no. Not all sub-device drivers with pads are camera sensor drivers. :-)
> 
> Hmm, alright. So we want to support enable/disable_streams for sub-devices
> with multiple source pads but no routing (so probably no sink pads)?

That should be allowed indeed, in order to move from s_stream() to
{enable,disable}_streams().

> 
> > > > > > > > So perhaps the question is, do we want to support single-pad subdevs in
> > > > > > > > the future, in which case something like this patch is necessary, or
> > > > > > > > will all modern source subdev drivers have internal pads, in which
> > > > > > > > case this is not needed...
> > > > > > > 
> > > > > > > I think the latter would be best. I however can't guarantee we won't
> > > > > > > have valid use cases for (enable|disable)_streams on single-pad subdevs
> > > > > > > though, so you patch could still be interesting.
> > > > > > 
> > > > > > Instead of the number of pads, could we use instead the
> > > > > > V4L2_SUBDEV_FL_STREAMS flag or whether g_routing op is supported to
> > > > > > determine the need for this?
> > > > > 
> > > > > Maybe, but are they better? Do you see some issue with checking for the
> > > > > number of pads? I considered a few options, but then thought that the most
> > > > > safest test for this case is 1) one pad 2) enable/disable_streams
> > > > > implemented.
> > > > 
> > > > I think I'd actually prefer {enable,disable}_streams in fact.
> > > 
> > > Hmm, sorry, now I'm confused =). What do you mean with that?
> > 
> > I'd use V4L2_SUBDEV_FL_STREAMS flag instead of the number of pads. The
> > number of pads is less related to routing.
> 
> Well, with one pad you cannot have routing =).
> 
> In this patch I used sd->enabled_streams to track the enabled streams, but
> if we need to support multiple pads, I'll have to invent something new for
> that.

What exactly do you think needs to be changed? This is just about starting
and stopping streaming using a different sent of callbacks, right?

-- 
Terveisin,

Sakari Ailus

