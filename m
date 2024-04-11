Return-Path: <linux-kernel+bounces-139761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F37258A0767
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9AD32882FC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 04:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B5413C693;
	Thu, 11 Apr 2024 04:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="AQKOBFDJ"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660EB62144;
	Thu, 11 Apr 2024 04:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712811530; cv=none; b=tLS+12dYEJ9slPxh2/8EzjcfcvknXVgqHNh1kSNZfetj516nwRH27wBzWit2ODOoPMv03By0fUYNcFLDEYsuM6eDJVayyu2q9cxRY4Ib5mvTXKgrRcp6o5Cf5Y424KEeH+P4uxlC6HMWqeV8q0JN83ZvDcGlw2D+gMHaVd4zW5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712811530; c=relaxed/simple;
	bh=EjDggh6AstRW3Y352ldWmTo6dk9/oyp3mFoHJ4SikHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G7OPCidD9FJAO7KGs3H6AX4bakdCkYdWXguh5A9FI2t9PZe+shwVBHXfOceDN6bKuRqzFgYiVWFkxqzc5+p9SNirAzaTWPk46Aboa6vQ/nZTwW1xKisGvc4uvsqmvyXDI6OijVkdK8q/tU9Yn2lLKRHHSxz7f03RGzb/b2OLQ8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=AQKOBFDJ; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.1.108] (unknown [103.86.18.224])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id D89D3B0E;
	Thu, 11 Apr 2024 06:58:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712811484;
	bh=EjDggh6AstRW3Y352ldWmTo6dk9/oyp3mFoHJ4SikHU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AQKOBFDJQyWGwa94uDmWn61B90jlGoVej/aOCtrOwgUOihm+ICl3zj5T5nSeudkow
	 IpEagUo/OJ7OXqBlEaHyLkVQ54b1zVcH5T8H05Ualh5y6v570wKvfN466mJGSZXlDW
	 lq0HSnzzL4aIMGTe4tnCAjWJxkf3OVwVbPg4McmQ=
Message-ID: <aa2e421d-c862-4ba7-a270-e2198418d230@ideasonboard.com>
Date: Thu, 11 Apr 2024 10:28:39 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/9] media: subdev: Support privacy led in
 v4l2_subdev_enable/disable_streams()
Content-Language: en-US
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil
 <hverkuil@xs4all.nl>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240410-enable-streams-impro-v3-0-e5e7a5da7420@ideasonboard.com>
 <20240410-enable-streams-impro-v3-7-e5e7a5da7420@ideasonboard.com>
From: Umang Jain <umang.jain@ideasonboard.com>
In-Reply-To: <20240410-enable-streams-impro-v3-7-e5e7a5da7420@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Tomi,

Thank you for the patch.

On 10/04/24 6:05 pm, Tomi Valkeinen wrote:
> We support camera privacy leds with the .s_stream, in call_s_stream, but
> we don't have that support when the subdevice implements
> .enable/disable_streams.
>
> Add the support by enabling the led when the first stream for a
> subdevice is enabled, and disabling the led then the last stream is
> disabled.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

Reviewed-by: Umang Jain <umang.jain@ideasonboard.com>

> ---
>   drivers/media/v4l2-core/v4l2-subdev.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
> index 20b5a00cbeeb..f44aaa4e1fab 100644
> --- a/drivers/media/v4l2-core/v4l2-subdev.c
> +++ b/drivers/media/v4l2-core/v4l2-subdev.c
> @@ -2150,6 +2150,7 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
>   {
>   	struct device *dev = sd->entity.graph_obj.mdev->dev;
>   	struct v4l2_subdev_state *state;
> +	bool already_streaming;
>   	u64 found_streams = 0;
>   	unsigned int i;
>   	int ret;
> @@ -2198,6 +2199,8 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
>   
>   	dev_dbg(dev, "enable streams %u:%#llx\n", pad, streams_mask);
>   
> +	already_streaming = v4l2_subdev_is_streaming(sd);
> +
>   	/* Call the .enable_streams() operation. */
>   	ret = v4l2_subdev_call(sd, pad, enable_streams, state, pad,
>   			       streams_mask);
> @@ -2216,6 +2219,9 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
>   			cfg->enabled = true;
>   	}
>   
> +	if (!already_streaming)
> +		v4l2_subdev_enable_privacy_led(sd);
> +
>   done:
>   	v4l2_subdev_unlock_state(state);
>   
> @@ -2340,6 +2346,9 @@ int v4l2_subdev_disable_streams(struct v4l2_subdev *sd, u32 pad,
>   	}
>   
>   done:
> +	if (!v4l2_subdev_is_streaming(sd))
> +		v4l2_subdev_disable_privacy_led(sd);
> +
>   	v4l2_subdev_unlock_state(state);
>   
>   	return ret;
>


