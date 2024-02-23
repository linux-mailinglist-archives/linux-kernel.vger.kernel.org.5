Return-Path: <linux-kernel+bounces-78209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FE0861045
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3AFE286FD8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398627AE45;
	Fri, 23 Feb 2024 11:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="V30E3W+e"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A88E78B6B;
	Fri, 23 Feb 2024 11:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708687365; cv=none; b=L3lskYPmfteIK0/LDgTcxy7gOls2U01SL8FZeZMXO9kg+DmsicsAL4w3FERMhhlpCw1TI+IHn6aa0kuYEEod+2LkSM9adaUB17D/Mqpoc7Ims46hEC9lO/YWskyuq/pnLEqGnl4QgfP49MG2ZHYR/SYH0yB9ta1+czlB8+r455c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708687365; c=relaxed/simple;
	bh=JlCjvXv1vhGyP/skKGYCXmNRqNPrHJWqMxafmlRLjxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n94JL50eveR+U213CscG4jS/8Ki9FmtCQDfneK6t5e3XsbY2+a8yjo84ggqIw7KMhL5njeh+7LXLsemoV4llBEJBVG2u1pdp+KKiEvuNE+d+T2NXgEIFxp1vwkQJCqL3uZL4AJQxQUju9181X9L6DjvxRLfJj2mpi1XBI/Gc2g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=V30E3W+e; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (89-27-53-110.bb.dnainternet.fi [89.27.53.110])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id F3E2C2E7;
	Fri, 23 Feb 2024 12:22:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1708687352;
	bh=JlCjvXv1vhGyP/skKGYCXmNRqNPrHJWqMxafmlRLjxM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V30E3W+eSPwI9/KBM4hzd8fBqQnH0AqPd5LpHGyLV+YxZ7u5njQ5dmCnZbXRDemcK
	 9ev1+S4RK88br/e0LlOwMoVSYtywLd5VA5SnEVO2FFKiBoYDH//rCnZFuDv6HWaER0
	 T5otOiUhnRP85wxfLcZS2CBSrjSxcxs8bte46Ecc=
Date: Fri, 23 Feb 2024 13:22:44 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Mikhail Rudenko <mike.rudenko@gmail.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Jacopo Mondi <jacopo@jmondi.org>,
	Tommaso Merciai <tomm.merciai@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v2 02/20] media: i2c: ov4689: Sort register definitions
 by address
Message-ID: <20240223112244.GM31348@pendragon.ideasonboard.com>
References: <20231218174042.794012-1-mike.rudenko@gmail.com>
 <20231218174042.794012-3-mike.rudenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231218174042.794012-3-mike.rudenko@gmail.com>

Hi Mikhail,

Thank you for the patch.

On Mon, Dec 18, 2023 at 08:40:23PM +0300, Mikhail Rudenko wrote:
> Put register defininitions in the order of increasing register
> address.
> 
> Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/media/i2c/ov4689.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
> index ff5213862974..1ae6d9b9c9b3 100644
> --- a/drivers/media/i2c/ov4689.c
> +++ b/drivers/media/i2c/ov4689.c
> @@ -19,15 +19,15 @@
>  #include <media/v4l2-subdev.h>
>  #include <media/v4l2-fwnode.h>
>  
> -#define CHIP_ID				0x004688
> -#define OV4689_REG_CHIP_ID		0x300a
> -
>  #define OV4689_XVCLK_FREQ		24000000
>  
>  #define OV4689_REG_CTRL_MODE		0x0100
>  #define OV4689_MODE_SW_STANDBY		0x0
>  #define OV4689_MODE_STREAMING		BIT(0)
>  
> +#define OV4689_REG_CHIP_ID		0x300a
> +#define CHIP_ID				0x004688
> +
>  #define OV4689_REG_EXPOSURE		0x3500
>  #define OV4689_EXPOSURE_MIN		4
>  #define OV4689_EXPOSURE_STEP		1
> @@ -41,12 +41,12 @@
>  #define OV4689_GAIN_STEP		1
>  #define OV4689_GAIN_DEFAULT		0x80
>  
> +#define OV4689_REG_VTS			0x380e
> +
>  #define OV4689_REG_TEST_PATTERN		0x5040
>  #define OV4689_TEST_PATTERN_ENABLE	0x80
>  #define OV4689_TEST_PATTERN_DISABLE	0x0
>  
> -#define OV4689_REG_VTS			0x380e
> -
>  #define REG_NULL			0xFFFF
>  
>  #define OV4689_REG_VALUE_08BIT		1

-- 
Regards,

Laurent Pinchart

