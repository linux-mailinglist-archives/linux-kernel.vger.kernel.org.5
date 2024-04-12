Return-Path: <linux-kernel+bounces-141886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 428988A24AA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 06:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7385A1C22F50
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 04:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51775182B1;
	Fri, 12 Apr 2024 04:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="SFaiuDo5"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C0117C64;
	Fri, 12 Apr 2024 04:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712894559; cv=none; b=UOhErSY8x/TbNnClFUaJZvRAK2GAtmMc/cef30jG/DGZeQjB53dlPjmG9HgCtirT0F6MGfzP/P9hdrPQB/QSUjeQkqsJqX4pNN3c/p3SEzTz1lHVwDlhM2E02ollg1cY6KEiBIOlUrEjm8UUzkMAvgfIjyrbFGirVcfK+L/eSOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712894559; c=relaxed/simple;
	bh=+tS0uyXk06urImoDsYh/SXAFdUaHawJMOLbptlv7mN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h/Vlf1Fm1b1hsD4hZdZdrE0QjoxhMtX2660/cB3hkvMMuzj/OT/xiW+q4QFByWZdIS+Ard7KubwjbKtKtHQl/qHctidAEC+46lGffXWr/0RcFwm+tXeUB2CWh8y5wnOHTNEVFj4Iw02zFkycokuxK8uHdAZNjZGrV2OEquSQe7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=SFaiuDo5; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.1.105] (unknown [103.251.226.65])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 89A8B9D5;
	Fri, 12 Apr 2024 06:01:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712894507;
	bh=+tS0uyXk06urImoDsYh/SXAFdUaHawJMOLbptlv7mN0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SFaiuDo5jeeUt9tebvUiWArj2R6ZZWVt78u/C2RSWGAzxf6HS7OQ52x3fwD/Pf7Bo
	 +RN/BHe5fY+q3Mi6tkfEEOM2Fvy6NTWjjK1FEQPB7Ok/YmexHCWngx3UV/5ipPeRQ7
	 bR108NYPeSHTthtQWsPVqFMUnQz57MGJHuo0lxE0=
Message-ID: <f47337f7-50be-4e00-9fe6-1814bd162a53@ideasonboard.com>
Date: Fri, 12 Apr 2024 09:32:22 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/9] media: subdev: Add v4l2_subdev_is_streaming()
Content-Language: en-US
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil
 <hverkuil@xs4all.nl>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240410-enable-streams-impro-v3-0-e5e7a5da7420@ideasonboard.com>
 <20240410-enable-streams-impro-v3-6-e5e7a5da7420@ideasonboard.com>
From: Umang Jain <umang.jain@ideasonboard.com>
In-Reply-To: <20240410-enable-streams-impro-v3-6-e5e7a5da7420@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Tomi,

Thank you for the patch

On 10/04/24 6:05 pm, Tomi Valkeinen wrote:
> Add a helper function which returns whether the subdevice is streaming,
> i.e. if .s_stream or .enable_streams has been called successfully.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>   drivers/media/v4l2-core/v4l2-subdev.c | 25 +++++++++++++++++++++++++
>   include/media/v4l2-subdev.h           | 13 +++++++++++++
>   2 files changed, 38 insertions(+)
>
> diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
> index 3d2c9c224b8f..20b5a00cbeeb 100644
> --- a/drivers/media/v4l2-core/v4l2-subdev.c
> +++ b/drivers/media/v4l2-core/v4l2-subdev.c
> @@ -2419,6 +2419,31 @@ void v4l2_subdev_notify_event(struct v4l2_subdev *sd,
>   }
>   EXPORT_SYMBOL_GPL(v4l2_subdev_notify_event);
>   
> +bool v4l2_subdev_is_streaming(struct v4l2_subdev *sd)
> +{
> +	struct v4l2_subdev_state *state;
> +
> +	if (!v4l2_subdev_has_op(sd, pad, enable_streams))
> +		return sd->streaming_enabled;

With this field named s_stream_enabled as per the comment in one of the 
previous patch,

Reviewed-by: Umang Jain <umang.jain@ideasonboard.com>



> +
> +	state = v4l2_subdev_get_locked_active_state(sd);
> +
> +	if (!(sd->flags & V4L2_SUBDEV_FL_STREAMS))
> +		return !!sd->enabled_pads;
> +
> +	for (unsigned int i = 0; i < state->stream_configs.num_configs; ++i) {
> +		const struct v4l2_subdev_stream_config *cfg;
> +
> +		cfg = &state->stream_configs.configs[i];
> +
> +		if (cfg->enabled)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(v4l2_subdev_is_streaming);
> +
>   int v4l2_subdev_get_privacy_led(struct v4l2_subdev *sd)
>   {
>   #if IS_REACHABLE(CONFIG_LEDS_CLASS)
> diff --git a/include/media/v4l2-subdev.h b/include/media/v4l2-subdev.h
> index d6867511e9cf..270a4dfa5663 100644
> --- a/include/media/v4l2-subdev.h
> +++ b/include/media/v4l2-subdev.h
> @@ -1914,4 +1914,17 @@ extern const struct v4l2_subdev_ops v4l2_subdev_call_wrappers;
>   void v4l2_subdev_notify_event(struct v4l2_subdev *sd,
>   			      const struct v4l2_event *ev);
>   
> +/**
> + * v4l2_subdev_is_streaming() - Returns if the subdevice is streaming
> + * @sd: The subdevice
> + *
> + * v4l2_subdev_is_streaming() tells if the subdevice is currently streaming.
> + * "Streaming" here means whether .s_stream() or .enable_streams() has been
> + * successfully called, and the streaming has not yet been disabled.
> + *
> + * If the subdevice implements .enable_streams() this function must be called
> + * while holding the active state lock.
> + */
> +bool v4l2_subdev_is_streaming(struct v4l2_subdev *sd);
> +
>   #endif /* _V4L2_SUBDEV_H */
>


