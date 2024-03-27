Return-Path: <linux-kernel+bounces-120692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BC688DB82
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF59D1C262A7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF2450272;
	Wed, 27 Mar 2024 10:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AXRALpN2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CBA4F1E4;
	Wed, 27 Mar 2024 10:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711536394; cv=none; b=NE98hxO12mdZT5Sh3e66GxVignkcImza4Bj5pLIZzxH5oSdBP3zzIJvPi/4u3meTVSVmNJl7UbjvE/wsGxWIHoAFgpfzF/MrlyEl+afATn3I29z/Hhjw7YXGvMLso7aBXBqHUvyt2iKKcfPYj0b3JHMh0wBpD6fVvQtD2Aglv2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711536394; c=relaxed/simple;
	bh=OSEX0ZaauFn6+aQhM6O8E2hHzie5j9+agUDTBkTWpRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mBHvKJn4T4hpGHSaFgTTz7KI3TFLmswHybRiLoGBivoops5zfQ6b0UMwXGdq4hifbfszYs5HgAHg4Pvz6cOZ4OLoJ4pNFLHjJIs2WdjyijKW3sa2wYuVaDgPV5/wt5he8ksrAYhw7G9E2oHq/UFS/xAmrLUl/97fqiirc2lK6AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AXRALpN2; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711536392; x=1743072392;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OSEX0ZaauFn6+aQhM6O8E2hHzie5j9+agUDTBkTWpRg=;
  b=AXRALpN2BnPSzB43O8531YIvOeTKMJJZZdfSRkqybb46LRGccZ3K0iCP
   7cKhGFUu2lNzM5OHW1B8gglUSvWDDFKyMZdYH1MU56Wt0AD5nhlZAPjNc
   1xXUzzP3KAj+bYNcZ+EGB+OsSiJVX5i4raEXEGqD8UT3+YeCqwx7RlCqo
   StyeRwKU9KCgsB+RC9od3B5iiFbWT5ZSHn/TjsNmtHCuX4TtIh/+v/fuo
   6bnEAgfnQ0FV7EhdQdKxL+Yrdl3JICGjVJwKtaiG8egwJVQpYrn4SlQSa
   vyvERLZui7yrKRg8BtFQ388Ev5DBHURAo2pzfiFXMre0v/fpuNd52C2J3
   A==;
X-CSE-ConnectionGUID: Drmrxh+sTlmm5tMGjE6XnA==
X-CSE-MsgGUID: LlFT6kmvRkuWg+tFS1eWfg==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="6492004"
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="6492004"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 03:46:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="16316580"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 03:46:30 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 5F2BB11FB81;
	Wed, 27 Mar 2024 12:46:27 +0200 (EET)
Date: Wed, 27 Mar 2024 10:46:27 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Umang Jain <umang.jain@ideasonboard.com>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: v4l2-subdev: Support enable/disable_streams for
 single-pad subdevs
Message-ID: <ZgP5A0sN9FCoIoPs@kekkonen.localdomain>
References: <20240325-single-pad-enable-streams-v1-1-142e19896a72@ideasonboard.com>
 <20240325125055.GC23988@pendragon.ideasonboard.com>
 <ZgF10EVLrfF7cl57@kekkonen.localdomain>
 <0ad9841d-bb51-4512-9388-f9ce36372677@ideasonboard.com>
 <ZgG5xt07XQ7DJ1_W@kekkonen.localdomain>
 <e497a7a2-a973-4059-8981-1ea83ea3dd30@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e497a7a2-a973-4059-8981-1ea83ea3dd30@ideasonboard.com>

Heippa,

On Mon, Mar 25, 2024 at 07:56:46PM +0200, Tomi Valkeinen wrote:
> On 25/03/2024 19:52, Sakari Ailus wrote:
> > Moi,
> > 
> > On Mon, Mar 25, 2024 at 03:43:01PM +0200, Tomi Valkeinen wrote:
> > > On 25/03/2024 15:02, Sakari Ailus wrote:
> > > > Moi,
> > > > 
> > > > Thanks for the patch.
> > > > 
> > > > On Mon, Mar 25, 2024 at 02:50:55PM +0200, Laurent Pinchart wrote:
> > > > > Hi Tomi,
> > > > > 
> > > > > On Mon, Mar 25, 2024 at 02:43:23PM +0200, Tomi Valkeinen wrote:
> > > > > > Currently a subdevice with a single pad, e.g. a sensor subdevice, must
> > > > > > use the v4l2_subdev_video_ops.s_stream op, instead of
> > > > > > v4l2_subdev_pad_ops.enable/disable_streams. This is because the
> > > > > > enable/disable_streams machinery requires a routing table which a subdev
> > > > > > cannot have with a single pad.
> > > > > > 
> > > > > > Implement enable/disable_streams support for these single-pad subdevices
> > > > > > by assuming an implicit stream 0 when the subdevice has only one pad.
> > > > > > 
> > > > > > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> > > > > > ---
> > > > > > Even though I did send this patch, I'm not sure if this is necessary.
> > > > > > s_stream works fine for the subdevs with a single pad. With the upcoming
> > > > > > internal pads, adding an internal pad to the subdev will create a
> > > > > > routing table, and enable/disable_streams would get "fixed" that way.
> > > > 
> > > > I'd like to get rid of a redundant way to control streaming.
> > > 
> > > We can't get rid of it anyway, can we? We're not going to convert old
> > > drivers to streams.
> > 
> > I'd expect to do that but it'd take a long time. That being said, I think
> > we need to consider devices without pads (VCMs) so it may well be this
> > would remain after all.
> > 
> > > 
> > > For new drivers, yes, we shouldn't use s_stream. But is the answer for new
> > > sensor drivers this patch, or requiring an internal pad?
> > 
> > For new drivers I'd like to see an internal pad in fact.
> > {enable,disable}_streams is still internal to the kernel.
> 
> So, you think this patch should be dropped?

No, no. Not all sub-device drivers with pads are camera sensor drivers. :-)

> 
> > > > > > So perhaps the question is, do we want to support single-pad subdevs in
> > > > > > the future, in which case something like this patch is necessary, or
> > > > > > will all modern source subdev drivers have internal pads, in which
> > > > > > case this is not needed...
> > > > > 
> > > > > I think the latter would be best. I however can't guarantee we won't
> > > > > have valid use cases for (enable|disable)_streams on single-pad subdevs
> > > > > though, so you patch could still be interesting.
> > > > 
> > > > Instead of the number of pads, could we use instead the
> > > > V4L2_SUBDEV_FL_STREAMS flag or whether g_routing op is supported to
> > > > determine the need for this?
> > > 
> > > Maybe, but are they better? Do you see some issue with checking for the
> > > number of pads? I considered a few options, but then thought that the most
> > > safest test for this case is 1) one pad 2) enable/disable_streams
> > > implemented.
> > 
> > I think I'd actually prefer {enable,disable}_streams in fact.
> 
> Hmm, sorry, now I'm confused =). What do you mean with that?

I'd use V4L2_SUBDEV_FL_STREAMS flag instead of the number of pads. The
number of pads is less related to routing.

-- 
Regards,

Sakari Ailus

