Return-Path: <linux-kernel+bounces-138309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4594289EF9F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF2732851DE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28305158A3A;
	Wed, 10 Apr 2024 10:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FfKwwXjd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D810C158204;
	Wed, 10 Apr 2024 10:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712743896; cv=none; b=sGc4RFLehVuwHMGQkv1T32l0SBI4GH3m94SO0kjwb3Et8Gq3MSrhyT55685qJeRrg+uZpmbjjMTQmVLlHN56nqrEYJpcyr9tA1aA4jjktdt/3CfraTdfnWHyRcu8j8X6nQtFZpjxSujijSptIemYBZy5/BkTsFiHzmh3jkVQiF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712743896; c=relaxed/simple;
	bh=QzeJL5gMeLtcySlknYL+kljOGPy2dP5ClNu55TRB8ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lcd4B9JFucfBKnyeGP8CxUEtfC7ZjwYhUMkJ7KJx9qWulh3MQ3rM03RXC9MWMNFDCi4ZEw9YPKO2cNDsgHhxmQGIPEfK6/SGBskV4NV86T6UodzAEqdBPfjtzzSZrezimiRSBwVNglV9wsLRy6dj1saC4pAAsCU9/OEje40Lxho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FfKwwXjd; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712743895; x=1744279895;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QzeJL5gMeLtcySlknYL+kljOGPy2dP5ClNu55TRB8ug=;
  b=FfKwwXjdmm4HiQbCNe9GgNr2PkdWSI40hSjGB0btVHRsXS35UAoIjWkC
   0WvrecgEL1X8wgfm4BJX/BT9qbdk0tfWTU/cbjweHqksT265NsXuF55oR
   rdPJJSANgtUIvW7VcHiKFHbJAaNraSZheyBJivsN+i5BHRkmEAQjTO7j2
   IMgr3Q/R0TjpxXaoUd+eqVVwQc0JUb1IDwos3lW6SmTSO/aRa9l1VaqNG
   ZjQvRqjwAM3xOnWuhTDoynYMxKqHlztjDSRwD9sQfFzZeU5gLaBB9rPMr
   6Q4NhKtVEtj+uLaCgpz2IGKKJE5m3JZb9rd96qvtq+Yl25G939pkDmqJT
   Q==;
X-CSE-ConnectionGUID: Nd0DQowhQdq+O+DW9hJ5xw==
X-CSE-MsgGUID: JI7Ua+dfRp+BBEhy2SO/6g==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="7953803"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="7953803"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 03:11:34 -0700
X-CSE-ConnectionGUID: 0xmUzNqoQTm00E91gMT8lQ==
X-CSE-MsgGUID: vtg0z1SmTBGjaRgfHcQwpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="25287426"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 03:11:32 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 0DFFB11FC46;
	Wed, 10 Apr 2024 13:11:29 +0300 (EEST)
Date: Wed, 10 Apr 2024 10:11:29 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Umang Jain <umang.jain@ideasonboard.com>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/9] media: subdev: Support privacy led in
 v4l2_subdev_enable/disable_streams()
Message-ID: <ZhZl0Se7I5eeQfW8@kekkonen.localdomain>
References: <20240405-enable-streams-impro-v2-0-22bca967665d@ideasonboard.com>
 <20240405-enable-streams-impro-v2-7-22bca967665d@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405-enable-streams-impro-v2-7-22bca967665d@ideasonboard.com>

Moi,

On Fri, Apr 05, 2024 at 12:14:25PM +0300, Tomi Valkeinen wrote:
> We support camera privacy leds with the .s_stream, in call_s_stream, but
> we don't have that support when the subdevice implements
> .enable/disable_streams.
> 
> Add the support by enabling the led when the first stream for a
> subdevice is enabled, and disabling the led then the last stream is
> disabled.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  drivers/media/v4l2-core/v4l2-subdev.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
> index b4981447961a..015f2fb423c9 100644
> --- a/drivers/media/v4l2-core/v4l2-subdev.c
> +++ b/drivers/media/v4l2-core/v4l2-subdev.c
> @@ -2149,6 +2149,7 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
>  {
>  	struct device *dev = sd->entity.graph_obj.mdev->dev;
>  	struct v4l2_subdev_state *state;
> +	bool already_streaming;
>  	u64 found_streams = 0;
>  	unsigned int i;
>  	int ret;
> @@ -2197,6 +2198,11 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
>  
>  	dev_dbg(dev, "enable streams %u:%#llx\n", pad, streams_mask);
>  
> +	already_streaming = v4l2_subdev_is_streaming(sd);
> +
> +	if (!already_streaming)
> +		v4l2_subdev_enable_privacy_led(sd);
> +
>  	/* Call the .enable_streams() operation. */
>  	ret = v4l2_subdev_call(sd, pad, enable_streams, state, pad,
>  			       streams_mask);
> @@ -2216,6 +2222,9 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
>  	}
>  
>  done:
> +	if (ret && !already_streaming)
> +		v4l2_subdev_disable_privacy_led(sd);

I think you could also lit the LED only if enabling streaming succeeds.

> +
>  	v4l2_subdev_unlock_state(state);
>  
>  	return ret;
> @@ -2339,6 +2348,9 @@ int v4l2_subdev_disable_streams(struct v4l2_subdev *sd, u32 pad,
>  	}
>  
>  done:
> +	if (!v4l2_subdev_is_streaming(sd))
> +		v4l2_subdev_disable_privacy_led(sd);
> +
>  	v4l2_subdev_unlock_state(state);
>  
>  	return ret;
> 

-- 
Terveisin,

Sakari Ailus

