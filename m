Return-Path: <linux-kernel+bounces-51533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6691848C42
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 09:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50A88B249AB
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 08:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AED14AA0;
	Sun,  4 Feb 2024 08:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="pjT/nKXn"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5137514275;
	Sun,  4 Feb 2024 08:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707036462; cv=none; b=sLh90RsYAtOPXROGVc4z6a4K6G/E+p6oVltx+Ewru+AFqDPirnBicyxk2qFvDr8oAMHQjXvWfOB2VFKdQDx3d4q6niosr4AXLGQWDGsJpbtP8EDPy9AHz7Ua9r5vwFNwJ4FeZdyA8+zht8PUeJwdNX2CbBjcaLHaBfyhDRJ7fzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707036462; c=relaxed/simple;
	bh=aMQ/B7x9B9Pfpeyfedj+KUwS04B0TqLnOD5kM/m24u0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=akChcDlEDsJcAIviBPkMAetA7pH0zSzFjA++YEMZkJxOUqL1N+dUZ5MUQok7ylzf6BO0DKTe92huevvKtuqDIx6OS0pHovhlp4CnP4hYmgMb4XzZlXbQ3zju8XR3iAUNWeBeMEdziQfD5IwoDNPaTVInWEK9CzbOKFUsN5P2wac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=pjT/nKXn; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (unknown [109.128.141.99])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0B5DE720;
	Sun,  4 Feb 2024 09:46:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1707036378;
	bh=aMQ/B7x9B9Pfpeyfedj+KUwS04B0TqLnOD5kM/m24u0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pjT/nKXnbJjNiASQ2yUf7IgXh6jBcMXaGX0bRwdfPvsVxZPXNjtj247WzAr6neblX
	 PMaA61IFAVGh/NV/GmH9zNm3MVClDuoak/Py0D4uGYEHtI47wE4AFnfPWbEnjf4cvl
	 ZbYytrUwp8M1Jo7zYy/EwPti2NE0GK5WfaCzCrRg=
Date: Sun, 4 Feb 2024 10:47:40 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] media: cec: make cec_bus_type const
Message-ID: <20240204084740.GF3094@pendragon.ideasonboard.com>
References: <20240203-bus_cleanup-media-v1-0-33e8feeab912@marliere.net>
 <20240203-bus_cleanup-media-v1-1-33e8feeab912@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240203-bus_cleanup-media-v1-1-33e8feeab912@marliere.net>

Hi Ricardo,

Thank you for the patch.

On Sat, Feb 03, 2024 at 12:31:26PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the cec_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Hans, I assume you'll pick this patch. Could you also pick 2/2 from the
series ?

> ---
>  drivers/media/cec/core/cec-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/cec/core/cec-core.c b/drivers/media/cec/core/cec-core.c
> index 7e153c5cad04..5a54db839e5d 100644
> --- a/drivers/media/cec/core/cec-core.c
> +++ b/drivers/media/cec/core/cec-core.c
> @@ -93,7 +93,7 @@ static void cec_devnode_release(struct device *cd)
>  	cec_delete_adapter(to_cec_adapter(devnode));
>  }
>  
> -static struct bus_type cec_bus_type = {
> +static const struct bus_type cec_bus_type = {
>  	.name = CEC_NAME,
>  };
>  

-- 
Regards,

Laurent Pinchart

