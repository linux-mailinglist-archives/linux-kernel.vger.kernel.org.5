Return-Path: <linux-kernel+bounces-131293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B1D8985D0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 563D4285447
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5069C823B0;
	Thu,  4 Apr 2024 11:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nv940WBb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70318004D;
	Thu,  4 Apr 2024 11:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712229181; cv=none; b=MArefy6pqcRn85JJxjn36jBd8zCkY3xbffZFoPDC4MptruIM9ryg1YVT3AnGdbuUTnmXcgcOhwUbioA68A8opuOSj40SPnVDzgNUdsZ0MTwyd0WFhUghXDjXeyl3pARhDEzYhKEmehj9Auh7Fpt2+jit0Q5Dk624+McwA3YZ9MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712229181; c=relaxed/simple;
	bh=KFRAf7adv9egbazr+liWze3HmaS3w18nIpmGl7aX3X0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQqb1pFSnP53Om7ZwwkpKNHgub3mpBlXbb6zMf/jdkTQPZZAQ6y9JwHteOuxN+vNyMGXkRJ+36QWkJfFhkFcyXz4qyB9Lzh8ARRprjsGoJdQgP4u6Se+wzgkTFIJM8eRvKSjSm9LFEMpbt2RJydKQRJhT05GnN4R2Y7N6grXGyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nv940WBb; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712229180; x=1743765180;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KFRAf7adv9egbazr+liWze3HmaS3w18nIpmGl7aX3X0=;
  b=Nv940WBbPgK9JHcs68zpIzJIKdROGE2VG4rIXgtkzcUElhAAw55OG7iN
   vEOs6fdESpYvMShYrWurlkcXsIirTPx+sDf4+nvX8qqNmRaelkcIE2cFb
   kP5wGdNyAF+KI1UlpHj23LRSiL77PocdmFB/nPyGKO3QJ1gllq9MWnHwN
   cBUekTzmEL9yTOj28N7PLEPAfK/cUtPeD0QKts550DddlMATa+649h/Sa
   qVfpmjMGFpARoZr3U7HsPt0tXDF1YiW7NRz6H/nYlBsb7rhYg40/TD2fo
   MgaGC8NWCAHgNoDd4SmdtQUGj8BJ/ap4oYKibQBcmgAOghpy6mJz5+G+u
   A==;
X-CSE-ConnectionGUID: lQ8uB05fTuq89qrVdmj3dw==
X-CSE-MsgGUID: 1PBVUUaMQ/SgpKahbHp+qg==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="11329026"
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="11329026"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 04:10:03 -0700
X-CSE-ConnectionGUID: ep56NlGqRmSyGNeepw/Rsw==
X-CSE-MsgGUID: YVi14ByXSCy2t9s85AIxOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="18721931"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 04:10:01 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 4B0B811FC1A;
	Thu,  4 Apr 2024 14:09:58 +0300 (EEST)
Date: Thu, 4 Apr 2024 11:09:58 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Umang Jain <umang.jain@ideasonboard.com>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] media: subdev: Add checks for subdev features
Message-ID: <Zg6KhifvtowlixCS@kekkonen.localdomain>
References: <20240404-enable-streams-impro-v1-0-1017a35bbe07@ideasonboard.com>
 <20240404-enable-streams-impro-v1-1-1017a35bbe07@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404-enable-streams-impro-v1-1-1017a35bbe07@ideasonboard.com>

Moi,

On Thu, Apr 04, 2024 at 01:50:00PM +0300, Tomi Valkeinen wrote:
> Add some checks to verify that the subdev driver implements required
> features.
> 
> A subdevice that supports streams (V4L2_SUBDEV_FL_STREAMS) must do one
> of the following:
> 
> - Implement neither .enable/disable_streams() nor .s_stream(), if the
>   subdev is part of a video driver that uses an internal method to
>   enable the subdev.
> - Implement only .enable/disable_streams(), if support for legacy
>   sink-side subdevices is not needed.
> - Implement .enable/disable_streams() and .s_stream(), if support for
>   legacy sink-side subdevices is needed.
> 
> At the moment the framework doesn't check this requirement. Add the
> check.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  drivers/media/v4l2-core/v4l2-subdev.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
> index 4c6198c48dd6..b90b5185e87f 100644
> --- a/drivers/media/v4l2-core/v4l2-subdev.c
> +++ b/drivers/media/v4l2-core/v4l2-subdev.c
> @@ -1519,6 +1519,33 @@ int __v4l2_subdev_init_finalize(struct v4l2_subdev *sd, const char *name,
>  				struct lock_class_key *key)
>  {
>  	struct v4l2_subdev_state *state;
> +	struct device *dev = sd->dev;
> +	bool has_disable_streams;
> +	bool has_enable_streams;
> +	bool has_s_stream;
> +
> +	/* Check that the subdevice implements the required features */
> +
> +	has_s_stream = sd->ops && sd->ops->video && sd->ops->video->s_stream;
> +	has_enable_streams = sd->ops && sd->ops->pad && sd->ops->pad->enable_streams;
> +	has_disable_streams = sd->ops && sd->ops->pad && sd->ops->pad->disable_streams;

There is v4l2_subdev_has_op(). Please also run:

	./scripts/checkpatch.pl --strict --max-line-length=80

on this.

> +
> +	if (has_enable_streams != has_disable_streams) {
> +		dev_err(dev,
> +			"subdev '%s' must implement both or neither of .enable_streams() and .disable_streams()\n",
> +			sd->name);
> +		return -EINVAL;
> +	}
> +
> +	if (sd->flags & V4L2_SUBDEV_FL_STREAMS) {
> +		if (has_s_stream && !has_enable_streams) {

Is the s_stream callback allowed to be something else than NULL or
v4l2_subdev_s_stream_helper?

> +			dev_err(dev,
> +				"subdev '%s' must implement .enable/disable_streams()\n",
> +				sd->name);
> +
> +			return -EINVAL;
> +		}
> +	}
>  
>  	state = __v4l2_subdev_state_alloc(sd, name, key);
>  	if (IS_ERR(state))
> 

-- 
Terveisin,

Sakari Ailus

