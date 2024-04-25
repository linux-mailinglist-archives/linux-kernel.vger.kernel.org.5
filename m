Return-Path: <linux-kernel+bounces-158426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D87C68B1FEC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15D2E1C219C7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E654A84E1F;
	Thu, 25 Apr 2024 11:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="MT8pirri"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579C82B9CE;
	Thu, 25 Apr 2024 11:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714043352; cv=none; b=PF8BDNWZAw3ohvrEFwABgAznjecjuQxDYkLEDHxnaRTcxD++O1AJOagOCJBePpFebcAkqcVryj8r9+/Z/EkoCZhMBUSz515XEWtXaT8dHt8Zbm+Ej5QbbWiZ2PY3MwAbDO5NuWggaqPTntZyrCd9kjy8sLN2Fhavy0hfyqWjOTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714043352; c=relaxed/simple;
	bh=dTaJEQ+NtzwKV82cVUF7/ztO3B+FWC/WviT61IAiBWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rKy3UEldf4oR5AIWsQoNRI4NSPzBWb1foi7Z8Fkpc7mGfiS6XGC+qukcBxhece7XnGxfJWnf7f9R89Om5T0cUoudpRKf57uoJ3Z8/EfiTesY2GIfQLcG9Hb4TdCx8Jk5kh73w2w/QWGceulPbgJStj2hFNmCJ7OchHp20X5RY04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=MT8pirri; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 720E4B0B;
	Thu, 25 Apr 2024 13:08:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1714043289;
	bh=dTaJEQ+NtzwKV82cVUF7/ztO3B+FWC/WviT61IAiBWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MT8pirriMjMgfBbCmgfgzPDxFg+HHyJRcApG7Z2v6qWU3SjpGcymaHW3Y7jfURqh+
	 Tlu1HsZPoBe9qT0t9f+peITvgh/GW8eASp/JAzHBrUofLrekibpvhaNMVBN1H+wvgk
	 xtvirfntHoUicdEcYcPZophCtiobY83GNLloqlTg=
Date: Thu, 25 Apr 2024 14:08:54 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Umang Jain <umang.jain@ideasonboard.com>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 11/11] media: subdev: Improve s_stream documentation
Message-ID: <20240425110854.GA28454@pendragon.ideasonboard.com>
References: <20240424-enable-streams-impro-v6-0-5fb14c20147d@ideasonboard.com>
 <20240424-enable-streams-impro-v6-11-5fb14c20147d@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240424-enable-streams-impro-v6-11-5fb14c20147d@ideasonboard.com>

Hi Tomi,

Thank you for the patch.

On Wed, Apr 24, 2024 at 06:39:14PM +0300, Tomi Valkeinen wrote:
> Now that enable/disable_streams operations are available for
> single-stream subdevices too, there's no reason to use the old s_stream
> operation on new drivers. Extend the documentation reflecting this.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  include/media/v4l2-subdev.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/include/media/v4l2-subdev.h b/include/media/v4l2-subdev.h
> index 14a3c91cce93..99564a2ef71c 100644
> --- a/include/media/v4l2-subdev.h
> +++ b/include/media/v4l2-subdev.h
> @@ -450,6 +450,15 @@ enum v4l2_subdev_pre_streamon_flags {
>   *	already started or stopped subdev. Also see call_s_stream wrapper in
>   *	v4l2-subdev.c.
>   *
> + *	New drivers should instead implement &v4l2_subdev_pad_ops.enable_streams
> + *	and &v4l2_subdev_pad_ops.disable_streams operations, and use
> + *	v4l2_subdev_s_stream_helper for the &v4l2_subdev_video_ops.s_stream
> + *	operation to support legacy users.
> + *
> + *	Drivers should also not call the .s_stream() subdev operation directly,
> + *	but use the v4l2_subdev_enable_streams() and
> + *	v4l2_subdev_disable_streams() helpers.
> + *
>   * @g_pixelaspect: callback to return the pixelaspect ratio.
>   *
>   * @s_rx_buffer: set a host allocated memory buffer for the subdev. The subdev

-- 
Regards,

Laurent Pinchart

