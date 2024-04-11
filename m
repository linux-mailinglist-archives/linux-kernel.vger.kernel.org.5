Return-Path: <linux-kernel+bounces-139751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 189428A073B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 758DE28A108
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 04:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028A713C3D3;
	Thu, 11 Apr 2024 04:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="LLyhnz9W"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1B613C820;
	Thu, 11 Apr 2024 04:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712810624; cv=none; b=SL9IEwFcucjyR+UYQRY0aTuPdQjR1DmUtno0YV5jrv7hrEkuyNvg3tkqDVPWYkI+lVOMVcr1OfK+m7L7FM2ApCRqb3VmlQFO4brp83R96oPp0pDYzjxFxd7ruVrphXfgZuVhWmzN2YEiSDRyYeU2AekcOStzzPjPDdJfbVzhSOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712810624; c=relaxed/simple;
	bh=48UFNtne3m7G9f+x+tumOnAQ7TezLIxv0PZfozWYpl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VwppuvGs9lMg1P1OoCPgKANtpB/PAYO0/F2vS0FnyE+9YgkEx+g4uvPu2IrcPUXKsKTux4GMLg7heOdfbaoS0KYBlbJ76cvQA5yKAjdlgbE4O0OVATVL4xb4Tfi6l0IuiYXB6Lon4I3zMBqgr5GdbGf6MlH6wtrjbqDMQn025I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=LLyhnz9W; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.1.108] (unknown [103.86.18.224])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 51FEFB0B;
	Thu, 11 Apr 2024 06:42:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712810578;
	bh=48UFNtne3m7G9f+x+tumOnAQ7TezLIxv0PZfozWYpl8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LLyhnz9W2S8GC0hTbvXCaadtTAUja3834zeTecpVSzRbrDXGdv4+K8BzPhYHKTHGx
	 DhU+P1rE1rOO1h7jCf4O+j+0TgrUzwKSzkVDwGIUXc4gBDEakKydKiiuZpOcqvE5TL
	 Su7mj39s28QAtmjQHeaL7J+w1fo+IMOHZsf6TnLs=
Message-ID: <8871079e-79b4-49f1-9435-52c27ea07b65@ideasonboard.com>
Date: Thu, 11 Apr 2024 10:13:39 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/9] media: subdev: Use v4l2_subdev_has_op() in
 v4l2_subdev_enable/disable_streams()
Content-Language: en-US
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil
 <hverkuil@xs4all.nl>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240410-enable-streams-impro-v3-0-e5e7a5da7420@ideasonboard.com>
 <20240410-enable-streams-impro-v3-2-e5e7a5da7420@ideasonboard.com>
From: Umang Jain <umang.jain@ideasonboard.com>
In-Reply-To: <20240410-enable-streams-impro-v3-2-e5e7a5da7420@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Tomi,

Thank you for the patch.

On 10/04/24 6:05 pm, Tomi Valkeinen wrote:
> Use v4l2_subdev_has_op() in v4l2_subdev_enable/disable_streams().
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

Reviewed-by: Umang Jain <umang.jain@ideasonboard.com>

> ---
>   drivers/media/v4l2-core/v4l2-subdev.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
> index 13957543d153..4a531c2b16c4 100644
> --- a/drivers/media/v4l2-core/v4l2-subdev.c
> +++ b/drivers/media/v4l2-core/v4l2-subdev.c
> @@ -2133,7 +2133,7 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
>   		return 0;
>   
>   	/* Fallback on .s_stream() if .enable_streams() isn't available. */
> -	if (!sd->ops->pad || !sd->ops->pad->enable_streams)
> +	if (!v4l2_subdev_has_op(sd, pad, enable_streams))
>   		return v4l2_subdev_enable_streams_fallback(sd, pad,
>   							   streams_mask);
>   
> @@ -2250,7 +2250,7 @@ int v4l2_subdev_disable_streams(struct v4l2_subdev *sd, u32 pad,
>   		return 0;
>   
>   	/* Fallback on .s_stream() if .disable_streams() isn't available. */
> -	if (!sd->ops->pad || !sd->ops->pad->disable_streams)
> +	if (!v4l2_subdev_has_op(sd, pad, disable_streams))
>   		return v4l2_subdev_disable_streams_fallback(sd, pad,
>   							    streams_mask);
>   
>


