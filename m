Return-Path: <linux-kernel+bounces-139792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A749D8A07C9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D9931F253BC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB49F13C9C7;
	Thu, 11 Apr 2024 05:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="gETIcwS7"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549D813B7AA;
	Thu, 11 Apr 2024 05:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712813698; cv=none; b=rgQJV/gqyFRKVewrc7ef9lg8Szpy3FHtDwJw9OuN1am87qSwAjYPFC/LuDx4p9/Gz9PlzR2DVDAev0BxMcwVh5Aqf2oXuHHbgwFrZgVMPueasttDKGBsP8obX9fWC3V9HPXvsEkUP4A8cjB8f53wjtmfQCisouFF8voZCpmqu9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712813698; c=relaxed/simple;
	bh=YZ7Giok5JN6R5bpF506pLqpTxbEu6Kz+yRugyUgyUpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WxdBEmcbGPA42g7dTAEHPa/NLJroKfdq6QjOhnuU0qPQGzbir8aMQs61/Jr+GJvXEDJmPSII9TW85VqxG1phrskgPSp9zU1bPVTFIKdsnKpwEv65pF7OtgruBEOadeu9xZOcbohWvaT+0hCgCZPOIMYHupHXErbEdjNVezcbGdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=gETIcwS7; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.1.108] (unknown [103.86.18.224])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id D5594E1;
	Thu, 11 Apr 2024 07:34:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712813652;
	bh=YZ7Giok5JN6R5bpF506pLqpTxbEu6Kz+yRugyUgyUpA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gETIcwS7cuAoyT9gLx+IT+h3ZPAFjifl8I3yYbv2F/Z0JFKdA3Va3UkGCgAdZWOG+
	 l/ex/2OvOc482/mP+srMYm6KALPugS5uyYAwN4TorgRV6oRL+X1T45FxFbPky6wuRK
	 cX1BYt8i/ZnJFE2aO1ucI+c2SUnup3Kbb5cCaIrg=
Message-ID: <397c3723-2100-4717-9206-d53e71eae885@ideasonboard.com>
Date: Thu, 11 Apr 2024 11:04:47 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/9] media: subdev: Add checks for subdev features
Content-Language: en-US
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil
 <hverkuil@xs4all.nl>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240410-enable-streams-impro-v3-0-e5e7a5da7420@ideasonboard.com>
 <20240410-enable-streams-impro-v3-3-e5e7a5da7420@ideasonboard.com>
From: Umang Jain <umang.jain@ideasonboard.com>
In-Reply-To: <20240410-enable-streams-impro-v3-3-e5e7a5da7420@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Tomi,

On 10/04/24 6:05 pm, Tomi Valkeinen wrote:
> Add some checks to verify that the subdev driver implements required
> features.
>
> A subdevice that supports streams (V4L2_SUBDEV_FL_STREAMS) must do one
> of the following:
>
> - Implement neither .enable/disable_streams() nor .s_stream(), if the
>    subdev is part of a video driver that uses an internal method to
>    enable the subdev.
> - Implement only .enable/disable_streams(), if support for legacy
>    sink-side subdevices is not needed.
> - Implement .enable/disable_streams() and .s_stream(), if support for
>    legacy sink-side subdevices is needed.
>
> At the moment the framework doesn't check this requirement. Add the
> check.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

The code looks aligned with the restrictions mentioned in the commit 
message.

Only one question in case 3), does the .s_stream() needs to be helper 
function I think, can we (or do we) need to check that as well?

Reviewed-by: Umang Jain <umang.jain@ideasonboard.com>

> ---
>   drivers/media/v4l2-core/v4l2-subdev.c | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
>
> diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
> index 4a531c2b16c4..606a909cd778 100644
> --- a/drivers/media/v4l2-core/v4l2-subdev.c
> +++ b/drivers/media/v4l2-core/v4l2-subdev.c
> @@ -1533,6 +1533,33 @@ int __v4l2_subdev_init_finalize(struct v4l2_subdev *sd, const char *name,
>   				struct lock_class_key *key)
>   {
>   	struct v4l2_subdev_state *state;
> +	struct device *dev = sd->dev;
> +	bool has_disable_streams;
> +	bool has_enable_streams;
> +	bool has_s_stream;
> +
> +	/* Check that the subdevice implements the required features */
> +
> +	has_s_stream = v4l2_subdev_has_op(sd, video, s_stream);
> +	has_enable_streams = v4l2_subdev_has_op(sd, pad, enable_streams);
> +	has_disable_streams = v4l2_subdev_has_op(sd, pad, disable_streams);
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
> +			dev_err(dev,
> +				"subdev '%s' must implement .enable/disable_streams()\n",
> +				sd->name);
> +
> +			return -EINVAL;
> +		}
> +	}
>   
>   	state = __v4l2_subdev_state_alloc(sd, name, key);
>   	if (IS_ERR(state))
>


