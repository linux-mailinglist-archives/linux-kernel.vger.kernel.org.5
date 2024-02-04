Return-Path: <linux-kernel+bounces-51532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D02D3848C40
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 09:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BCB4282225
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 08:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F7314A8F;
	Sun,  4 Feb 2024 08:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Qm3xI9KP"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F8914275;
	Sun,  4 Feb 2024 08:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707036434; cv=none; b=ag00qJnSnz2NnMnFrYn9cENypeEAb5d/q1NXLKlGvJuU/+VqHf/cVbw8dINlVH8Gy03b4LgC/VKuW8d8O8bWShD8LwiIMSvjx3N8fiK33or5ZeaJ6pfM0jQxumNBfyOWqQJjNW9Ins6An5JdUCBHyCg7PZFB+yRqZ5BvqPEQCWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707036434; c=relaxed/simple;
	bh=RUA9DVZTSMUYUSqiFziWdhCqEzBXnuZwYGQG1Psuc2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3fmIhX/WriKjx/pWHBmF6ilN9aXW6KlhGJaw6ySO9xR0DLXc4bfDzg7bzdcO+vYVgzaUwabT9HWV5J9IcPPrwJfiSBEehkv/hZ8mCYc5UrYe7ZqlWARWwb/XVPHQV/2Y8GSUNbPL0YgKJhlhz9Z4C30KABZpVN4EJyQfV0atKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Qm3xI9KP; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (unknown [109.128.141.99])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 62F02B3;
	Sun,  4 Feb 2024 09:45:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1707036349;
	bh=RUA9DVZTSMUYUSqiFziWdhCqEzBXnuZwYGQG1Psuc2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qm3xI9KPWatgZx9Vfp2ZGTt2BbrLo7KFQl25FZXXnR39FSUXqShk9f4xgiozv93GZ
	 Y0wdCQWEq8aqKnau6t0WFypndsdujMXuVmjEwb3r3SxAFrhWY+OvHoxwImOwwE3o7O
	 kyxBTFzbCzY4XLFdY6fIGuLunLLEA89SVbWzqVyY=
Date: Sun, 4 Feb 2024 10:47:12 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] media: media-devnode: make media_bus_type const
Message-ID: <20240204084712.GE3094@pendragon.ideasonboard.com>
References: <20240203-bus_cleanup-media-v1-0-33e8feeab912@marliere.net>
 <20240203-bus_cleanup-media-v1-2-33e8feeab912@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240203-bus_cleanup-media-v1-2-33e8feeab912@marliere.net>

Hi Ricardo,

Thank you for the patch.

On Sat, Feb 03, 2024 at 12:31:27PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the media_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
>  drivers/media/mc/mc-devnode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/mc/mc-devnode.c b/drivers/media/mc/mc-devnode.c
> index 680fbb3a9340..90646805bd81 100644
> --- a/drivers/media/mc/mc-devnode.c
> +++ b/drivers/media/mc/mc-devnode.c
> @@ -63,7 +63,7 @@ static void media_devnode_release(struct device *cd)
>  	pr_debug("%s: Media Devnode Deallocated\n", __func__);
>  }
>  
> -static struct bus_type media_bus_type = {
> +static const struct bus_type media_bus_type = {
>  	.name = MEDIA_NAME,
>  };
>  
> 

-- 
Regards,

Laurent Pinchart

