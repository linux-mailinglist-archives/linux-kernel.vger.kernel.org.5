Return-Path: <linux-kernel+bounces-157329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E3E8B0FE0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AB771F21DC4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D360516C6A6;
	Wed, 24 Apr 2024 16:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="toQELOnD"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73E21598EA;
	Wed, 24 Apr 2024 16:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713976447; cv=none; b=Y0+M6RKPym5OCai2hQMi2tSgrna9ELOP9XmBux42Xdaj4XHmPQTCuNQIfc53tNgkAbO5NSbP5TqO4o2JiMHuC8kW27Cp2DXeddROcyBkqRre8bcmS/ica0A3ZCSCMRDdnq5aZz3h/gD7wOeVKpE6WwEfFbKGJVt3KsMQUOX63a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713976447; c=relaxed/simple;
	bh=sPxnpCDg/JQccPFyT4hEMhVpH5Dzk+4bYfHs/7rseoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AiJplY5aarDzcRZ68HC6WZ0ou6keo5eKg7ppKfaWHhMHX9DSgmYDSufSgRokH3XVdz9rYlH8T8WQtEq+X/q02gxRTASdUSzZDd3DbSJoY0AM859vbxoCG5/8LfWz0iaTzLz/zC7LTuirQfHmULfFtopM9X8mKD2Bcebokz2Lxdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=toQELOnD; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.1.106] (unknown [103.251.226.10])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0BB27674;
	Wed, 24 Apr 2024 18:33:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1713976392;
	bh=sPxnpCDg/JQccPFyT4hEMhVpH5Dzk+4bYfHs/7rseoA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=toQELOnDdFXTN2Wf0C8bfT7E7kcPmCt95AeHtn5/2+Yk1VqYc5eCp5BLjyaIQherx
	 hF6f+Yv2XuF4F29Bgmo3adCO3Btofdn86Nn/75UYV4dh6F8tWXGOYJtMjS67BRMhwT
	 hEifIngHKOyqQDNN2rOjiu3xAXn6riDVl98nfCJc=
Message-ID: <b6f031c4-818e-44de-b491-1bfebdbf9c37@ideasonboard.com>
Date: Wed, 24 Apr 2024 22:03:52 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/11] media: subdev: Improve s_stream documentation
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil
 <hverkuil@xs4all.nl>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240424-enable-streams-impro-v6-0-5fb14c20147d@ideasonboard.com>
 <20240424-enable-streams-impro-v6-11-5fb14c20147d@ideasonboard.com>
Content-Language: en-US
From: Umang Jain <umang.jain@ideasonboard.com>
In-Reply-To: <20240424-enable-streams-impro-v6-11-5fb14c20147d@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Tomi,

On 24/04/24 9:09 pm, Tomi Valkeinen wrote:
> Now that enable/disable_streams operations are available for
> single-stream subdevices too, there's no reason to use the old s_stream
> operation on new drivers. Extend the documentation reflecting this.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

Reviewed-by: Umang Jain<umang.jain@ideasonboard.com>

> ---
>   include/media/v4l2-subdev.h | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/include/media/v4l2-subdev.h b/include/media/v4l2-subdev.h
> index 14a3c91cce93..99564a2ef71c 100644
> --- a/include/media/v4l2-subdev.h
> +++ b/include/media/v4l2-subdev.h
> @@ -450,6 +450,15 @@ enum v4l2_subdev_pre_streamon_flags {
>    *	already started or stopped subdev. Also see call_s_stream wrapper in
>    *	v4l2-subdev.c.
>    *
> + *	New drivers should instead implement &v4l2_subdev_pad_ops.enable_streams
> + *	and &v4l2_subdev_pad_ops.disable_streams operations, and use
> + *	v4l2_subdev_s_stream_helper for the &v4l2_subdev_video_ops.s_stream
> + *	operation to support legacy users.
> + *
> + *	Drivers should also not call the .s_stream() subdev operation directly,
> + *	but use the v4l2_subdev_enable_streams() and
> + *	v4l2_subdev_disable_streams() helpers.
> + *
>    * @g_pixelaspect: callback to return the pixelaspect ratio.
>    *
>    * @s_rx_buffer: set a host allocated memory buffer for the subdev. The subdev
>


