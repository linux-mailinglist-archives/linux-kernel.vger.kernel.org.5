Return-Path: <linux-kernel+bounces-142680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA6A8A2EC6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A7B51F22BE6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0F362147;
	Fri, 12 Apr 2024 13:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EP2Dwzri"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1891F55E4C;
	Fri, 12 Apr 2024 13:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712927023; cv=none; b=thSRQHiHriqEZ/ZL9kSfNqZgUOCMuggxt7N1BdIe8nAoAOFnkwlG8RSVnpOotyLaSLYjkb4CFhi7+9m151GaswIQApaMT3WLJvGJww0imSM+JiC1rakk5xjJpQ95/yc6GPoNK1vbdjvI+Jm0cSWL138gj92PNdgWbvwqLxPxx1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712927023; c=relaxed/simple;
	bh=vCkHpizOxk1oGDxM8fxP7qxinTI6j9RtzAj3GndDZa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jFpZByrSvdwdSrIDbNISBueLaKJkxBwP/oy1NoiDBDsJ3ruAedQQeNH6dP/drY+EmX96/pexHm/kIVo/GsuzfnvN1N892ycaPodIzUDEtTFL5N4zW+xEpNqygJDV73ylm+D5+y7tnMchIEE+metbgOTsGl3l95dh8S8EgP0KnBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EP2Dwzri; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712927018; x=1744463018;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vCkHpizOxk1oGDxM8fxP7qxinTI6j9RtzAj3GndDZa8=;
  b=EP2DwzritExFOFCDq6DvwPI8mLuQfNoT08bu2+Xcx6LbZys5SODWh0JN
   pPsA9XjBvKv5rjNV6BwzJ/z8cX8sFFj1gMRt5NJB4LVEmSAmjwCDJ5jQK
   p9P8nQ++UF7kQTzfpkvpb8N1rhWGamAZ8ogOk7FveXjK/tOcgE6lBNFXc
   YnOOu7hnWeFqIq4LBIPVn+HxmzkLe0DX8L521tzTlLo9ehiHcPb9lYLER
   OHYR8fgEr72hinkGcWJgqwQmitunn0QXhrSe14nEIKzlMPXVBfcE51c34
   8G2fhQVpu7WqbKLZiXsezVx7X49mPXyNW/3NatTJrKSRc9v2xpWL4khmR
   Q==;
X-CSE-ConnectionGUID: grEAWrvQQWyOez51YCQhVg==
X-CSE-MsgGUID: pw9K4v1jTluTPlwZULp7Rw==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="12230264"
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="12230264"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 06:03:37 -0700
X-CSE-ConnectionGUID: Ae/EZF/1SbC9WOOGl52Rmw==
X-CSE-MsgGUID: vFYwf3fLRYGQ8pVEzMTaiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="26034729"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 06:03:36 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 3C47B120359;
	Fri, 12 Apr 2024 16:03:33 +0300 (EEST)
Date: Fri, 12 Apr 2024 13:03:33 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Umang Jain <umang.jain@ideasonboard.com>
Cc: linux-media@vger.kernel.org,
	Alexander Shiyan <eagle.alexander923@gmail.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/6] media: imx335: Parse fwnode properties
Message-ID: <ZhkxJeQSKMxj0O7b@kekkonen.localdomain>
References: <20240412122842.193713-1-umang.jain@ideasonboard.com>
 <20240412122842.193713-3-umang.jain@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412122842.193713-3-umang.jain@ideasonboard.com>

Hi Umang,

On Fri, Apr 12, 2024 at 05:58:38PM +0530, Umang Jain wrote:
> From: Kieran Bingham <kieran.bingham@ideasonboard.com>
> 
> Call the V4L2 fwnode device parser to handle controls that are
> standardised by the framework.
> 
> Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> ---
>  drivers/media/i2c/imx335.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/i2c/imx335.c b/drivers/media/i2c/imx335.c
> index c633ea1380e7..3ea9c0ebe278 100644
> --- a/drivers/media/i2c/imx335.c
> +++ b/drivers/media/i2c/imx335.c
> @@ -1227,10 +1227,12 @@ static int imx335_init_controls(struct imx335 *imx335)
>  {
>  	struct v4l2_ctrl_handler *ctrl_hdlr = &imx335->ctrl_handler;
>  	const struct imx335_mode *mode = imx335->cur_mode;
> +	struct v4l2_fwnode_device_properties props;
>  	u32 lpfr;
>  	int ret;
>  
> -	ret = v4l2_ctrl_handler_init(ctrl_hdlr, 7);
> +	/* v4l2_fwnode_device_properties can add two more controls */
> +	ret = v4l2_ctrl_handler_init(ctrl_hdlr, 9);
>  	if (ret)
>  		return ret;
>  
> @@ -1295,9 +1297,15 @@ static int imx335_init_controls(struct imx335 *imx335)
>  	if (imx335->hblank_ctrl)
>  		imx335->hblank_ctrl->flags |= V4L2_CTRL_FLAG_READ_ONLY;
>  
> -	if (ctrl_hdlr->error) {
> -		dev_err(imx335->dev, "control init failed: %d\n",
> -			ctrl_hdlr->error);
> +	ret = v4l2_fwnode_device_parse(imx335->dev, &props);
> +	if (!ret) {
> +		/* Failure sets ctrl_hdlr->error, which we check afterwards anyway */
> +		v4l2_ctrl_new_fwnode_properties(ctrl_hdlr, &imx335_ctrl_ops,
> +						&props);
> +	}
> +
> +	if (ctrl_hdlr->error || ret) {
> +		dev_err(imx335->dev, "control init failed: %d\n", ctrl_hdlr->error);

Too long line.

>  		v4l2_ctrl_handler_free(ctrl_hdlr);
>  		return ctrl_hdlr->error;

The handler may not be in error state if only v4l2_fwnode_device_parse()
failed.

Should that be something that should prevent probing a driver though, or
could it just be ignored? I.e. in that case I'd only check for handler's
error, not ret.

>  	}

-- 
Kind regards,

Sakari Ailus

