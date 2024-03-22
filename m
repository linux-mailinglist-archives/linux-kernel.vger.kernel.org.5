Return-Path: <linux-kernel+bounces-111387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6234886BA9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 12:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 234C11C22A90
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0C83FB28;
	Fri, 22 Mar 2024 11:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="uWYp3B0Y"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2133E47A;
	Fri, 22 Mar 2024 11:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711108575; cv=none; b=g/PVjvN9Lf21/ohvglHX26cAmZMxKnYiIM69HJFVxuydvneqvNiHwhfbG3qZBDgl5HpakCGShKlAfaCW1f/e96MgNb6OuUxjd0+Gb9Vn1aYXLOV/VYpZ1C77tNWXXH14ONJIpLDlHVnespNRkfIS9W0eX5QChaM9TEGMdpwY+7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711108575; c=relaxed/simple;
	bh=LcBseW26vuMHItV1u05U7ja/e3cowwp+u5G24qLLkyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q0SsTexK+033ziKL01Ikl7/QaUnm9shSrLeHYoMfjfpseS3G6pTbVWNvudpz/jGtuFiwcwmZm3qXAAzzz4kEmsMampEzpq+NpUuWZMR4uCVT7z6sIqsmYvdUnC9lElavSinuBn+FGHvqwCZfzh7I/7ZztkO7GSZSnvSs/gJPTYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=uWYp3B0Y; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id DF0F2BEB;
	Fri, 22 Mar 2024 12:55:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1711108542;
	bh=LcBseW26vuMHItV1u05U7ja/e3cowwp+u5G24qLLkyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uWYp3B0Y/jmLyPAnzM3Dnzbo5guROD2yakFiGALrFc2S168pdlp8cVcaTnF8ZwocW
	 9g2Vjc1IYRk4KcaDGZRwOekN2lCzb8F7BQZszCoupgv6nrlxqNwnIJjNl1mrZkxygb
	 gAgRAqQ5aLfObOafoqMcN2+FVcTvnYhEvJjt/GwU=
Date: Fri, 22 Mar 2024 13:56:06 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: uvcvideo: Explicit alignment of uvc_frame and
 uvc_format
Message-ID: <20240322115606.GA31979@pendragon.ideasonboard.com>
References: <20230501-uvc-align-v1-1-0f713e4b84c3@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230501-uvc-align-v1-1-0f713e4b84c3@chromium.org>

Hi Ricardo,

Thank you for the patch.

On Mon, May 01, 2023 at 04:49:31PM +0200, Ricardo Ribalda wrote:
> Struct uvc_frame and uvc_format are packaged together on
> streaming->formats on a sigle allocation.

s/sigle/single/

> 
> This is working fine because both structures have a field with a
> pointer, but it will stop working when the sizeof() of any of those
> structs is not a muliple of the sizeof(void*).
> 
> Make that aligment contract explicit.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
> This is better than 3 allocations, and do not have any performance
> penalty.
> ---
>  drivers/media/usb/uvc/uvcvideo.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> index 9a596c8d894a..03e8a543c8e6 100644
> --- a/drivers/media/usb/uvc/uvcvideo.h
> +++ b/drivers/media/usb/uvc/uvcvideo.h
> @@ -252,7 +252,7 @@ struct uvc_frame {
>  	u8  bFrameIntervalType;
>  	u32 dwDefaultFrameInterval;
>  	u32 *dwFrameInterval;
> -};
> +} __aligned(sizeof(void *)); /* uvc_frame is packed on streaming->formats. */

Don't we need u32 alignment here, not void * alignment, given that
uvc_frame is followed by an array of u32 ?

>  
>  struct uvc_format {
>  	u8 type;
> @@ -266,7 +266,7 @@ struct uvc_format {
>  
>  	unsigned int nframes;
>  	struct uvc_frame *frame;
> -};
> +} __aligned(sizeof(void *)); /* uvc_format is packed on streaming->formats. */

Same here, technically we need to ensure that the following uvc_frame
will be aligned. void * alignment will give us that now, but that's not
the actual constraint.

Wouldn't it be better to handle the alignment constraints explicitly
when allocating the memory ? It's not that uvc_frame and uvc_format have
intrinsic alignment constraints, the constraints are only needed because
of the way memory is allocated.

>  
>  struct uvc_streaming_header {
>  	u8 bNumFormats;
> 
> ---
> base-commit: 58390c8ce1bddb6c623f62e7ed36383e7fa5c02f
> change-id: 20230501-uvc-align-6ff202b68dab

-- 
Regards,

Laurent Pinchart

