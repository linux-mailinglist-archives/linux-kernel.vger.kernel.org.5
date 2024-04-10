Return-Path: <linux-kernel+bounces-138297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5970389EF6D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8808C1C21F1B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729BA158207;
	Wed, 10 Apr 2024 10:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N7eCHR7B"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79B3156861;
	Wed, 10 Apr 2024 10:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712743512; cv=none; b=mO+ta8eVEvpz8W6ssNmDiv2qmacRAbYFa6TQLT0Q9zYyLE9nW7AfhPeD88lsq5cLQB9PNxJ3jhJm7ybm+rgtBGpZaqJejyXc1PB0IRi4p/FBh6p5bQQ1Q1w+6cbmzVkdQarX9mFl6OXCCfqJv6WWjalgDmcDC55mthhI8Q5RaVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712743512; c=relaxed/simple;
	bh=aCOEQD5HoFwyvxMVyRIMD1XvJRwuaLgi7aqiKKGZ72M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RrULmYbbl8VLqQB9o96gErlMEf9ytN+ehcnzA5DuIb8eR0TIc4TNxZo7B/NsEliKCsVNsFU/NLVQErMyov7R/czdFtxMvs/IkWQXe7KLml5TXiqutcsaLPdo74sl0Y6dZsqFkIat964s5xYL/1yn+65RoWXpNN+0uNnhwsSsk6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N7eCHR7B; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712743511; x=1744279511;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aCOEQD5HoFwyvxMVyRIMD1XvJRwuaLgi7aqiKKGZ72M=;
  b=N7eCHR7BeRRU4bRG04OKA3U8VXaCmtCSTnidiNKvDte7RBbEjgtuC1qi
   A26Z5gGRFrUSA3FBQFUZ8/bxmwManxQhvs8D6xlj2NRYam0QUoH8kG3zm
   78XfcmPSoGLb7BynTK/BhePbYyMnf1KodT3i59bWXvpdmBzRKRg7m4TOr
   gJjrbbwZJrlQ/qbNsSYCBS4pOPvHOFOV9jOhwUIOsMV5x34CtF3XfS4lE
   EiirlBvzh/2z4s6AzzO6SBkqQLazcyznxvHevOOjCfLOv54p/KA8ULoXk
   0feWvvSu+KUGjWwnZFmA35Cq7XNGtFDAADE6x9Bq/wVtLgZ86+qEbdAHL
   A==;
X-CSE-ConnectionGUID: hKRuXGspTIawgDzag2ldyA==
X-CSE-MsgGUID: 1kiPoE3kRxmN9jQSI2hk/A==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="7954235"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="7954235"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 03:05:10 -0700
X-CSE-ConnectionGUID: NXe6mQrYS1GaUMYPi6ORfA==
X-CSE-MsgGUID: oxWyHfUmQgyKyEf8g7IBeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="57951394"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 03:05:09 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id CBC5211FC46;
	Wed, 10 Apr 2024 13:05:05 +0300 (EEST)
Date: Wed, 10 Apr 2024 10:05:05 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Umang Jain <umang.jain@ideasonboard.com>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/9] media: subdev: Fix use of sd->enabled_streams in
 call_s_stream()
Message-ID: <ZhZkURwXETI9URKy@kekkonen.localdomain>
References: <20240405-enable-streams-impro-v2-0-22bca967665d@ideasonboard.com>
 <20240405-enable-streams-impro-v2-4-22bca967665d@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405-enable-streams-impro-v2-4-22bca967665d@ideasonboard.com>

Moi,

On Fri, Apr 05, 2024 at 12:14:22PM +0300, Tomi Valkeinen wrote:
> call_s_stream() uses sd->enabled_streams to track whether streaming has
> already been enabled. However,
> v4l2_subdev_enable/disable_streams_fallback(), which was the original
> user of this field, already uses it, and
> v4l2_subdev_enable/disable_streams_fallback() will call call_s_stream().
> 
> This leads to a conflict as both functions set the field. Afaics, both
> functions set the field to the same value, so it won't cause a runtime
> bug, but it's still wrong and if we, e.g., change how
> v4l2_subdev_enable/disable_streams_fallback() operates we might easily
> cause bugs.
> 
> Fix this by adding a new field, 'streaming_enabled', for
> call_s_stream().
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  drivers/media/v4l2-core/v4l2-subdev.c | 8 ++------
>  include/media/v4l2-subdev.h           | 3 +++
>  2 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
> index a15a41576918..94483b238f2a 100644
> --- a/drivers/media/v4l2-core/v4l2-subdev.c
> +++ b/drivers/media/v4l2-core/v4l2-subdev.c
> @@ -421,12 +421,8 @@ static int call_s_stream(struct v4l2_subdev *sd, int enable)
>  	 * The .s_stream() operation must never be called to start or stop an
>  	 * already started or stopped subdev. Catch offenders but don't return
>  	 * an error yet to avoid regressions.
> -	 *
> -	 * As .s_stream() is mutually exclusive with the .enable_streams() and
> -	 * .disable_streams() operation, we can use the enabled_streams field
> -	 * to store the subdev streaming state.
>  	 */
> -	if (WARN_ON(!!sd->enabled_streams == !!enable))
> +	if (WARN_ON(!!sd->streaming_enabled == !!enable))

A single ! is enough on both sides.

>  		return 0;
>  
>  	if (enable)
> @@ -442,7 +438,7 @@ static int call_s_stream(struct v4l2_subdev *sd, int enable)
>  	}
>  
>  	if (!ret)
> -		sd->enabled_streams = enable ? BIT(0) : 0;
> +		sd->streaming_enabled = !!enable;

No need for !! unless you think it needs to be very loud. Casting a
non-boolean value to boolean results in true if it's non-zero.

>  
>  	return ret;
>  }
> diff --git a/include/media/v4l2-subdev.h b/include/media/v4l2-subdev.h
> index a9e6b8146279..f55d03e0acc1 100644
> --- a/include/media/v4l2-subdev.h
> +++ b/include/media/v4l2-subdev.h
> @@ -1043,6 +1043,8 @@ struct v4l2_subdev_platform_data {
>   *		     v4l2_subdev_enable_streams() and
>   *		     v4l2_subdev_disable_streams() helper functions for fallback
>   *		     cases.
> + * @streaming_enabled: Tracks whether streaming has been enabled with s_stream.
> + *                     This is only for call_s_stream() internal use.
>   *
>   * Each instance of a subdev driver should create this struct, either
>   * stand-alone or embedded in a larger struct.
> @@ -1091,6 +1093,7 @@ struct v4l2_subdev {
>  	 */
>  	struct v4l2_subdev_state *active_state;
>  	u64 enabled_streams;
> +	bool streaming_enabled;
>  };
>  
>  
> 

-- 
Terveisin,

Sakari Ailus

