Return-Path: <linux-kernel+bounces-6695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A79819C3D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BA781C25932
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641AB2030B;
	Wed, 20 Dec 2023 10:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="CIHyIoDN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA4B2030C;
	Wed, 20 Dec 2023 10:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id E5FBB833;
	Wed, 20 Dec 2023 11:05:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1703066747;
	bh=/p097dBmZUfcAFQdNpNSImp1bcsBgLB7HROBHOtk7PA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CIHyIoDNY8WoQk7ugFASa9IlmVcq+04mBMP8pYl5xCVz/Ij3yrw6iAH6PPflq03VF
	 0OXh09wB6DXXqe+O2fmeUHL0PQ30XQvq4Dxe6K+8u8nHaUUP3dhxGmQMOBWb4XU9ig
	 yxBaMBT/50ow93Axs9G3SlYGHFsdEZ6bfMrpyugI=
Date: Wed, 20 Dec 2023 12:06:43 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Tommaso Merciai <tomm.merciai@gmail.com>
Cc: linuxfancy@googlegroups.com, martin.hecht@avnet.eu,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] media: i2c: alvium: removal of fr field
Message-ID: <20231220100643.GJ29638@pendragon.ideasonboard.com>
References: <20231220085609.2595732-1-tomm.merciai@gmail.com>
 <20231220085609.2595732-3-tomm.merciai@gmail.com>
 <20231220091309.GG29638@pendragon.ideasonboard.com>
 <ZYK7y/jaEZ2JHsnH@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZYK7y/jaEZ2JHsnH@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>

On Wed, Dec 20, 2023 at 11:02:51AM +0100, Tommaso Merciai wrote:
> Hi Laurent,
> Thanks for your review.
> 
> On Wed, Dec 20, 2023 at 11:13:09AM +0200, Laurent Pinchart wrote:
> > Hi Tommaso,
> > 
> > Thank you for the patch.
> > 
> > Use the imperative in the subject line:
> > 
> > media: i2c: alvium: Remove the fr field of the alvium_dev structure
> > 
> > On Wed, Dec 20, 2023 at 09:56:07AM +0100, Tommaso Merciai wrote:
> > > The fr (frame rate) field of the alvium_dev structure is
> > > only used to pass result from alvium_set_frame_interval() to
> > > alvium_set_frame_rate() that writes this info into the hw reg.
> > > Replace them with function parameter.
> > 
> > Replace it with a function parameter.
> 
> Thanks I'll fix this in v3.
> 
> > 
> > > 
> > > Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> > > ---
> > >  drivers/media/i2c/alvium-csi2.c | 24 ++++++++++++------------
> > >  drivers/media/i2c/alvium-csi2.h |  1 -
> > >  2 files changed, 12 insertions(+), 13 deletions(-)
> > > 
> > > diff --git a/drivers/media/i2c/alvium-csi2.c b/drivers/media/i2c/alvium-csi2.c
> > > index 0dcd69bf9f92..a9ff6cc97cff 100644
> > > --- a/drivers/media/i2c/alvium-csi2.c
> > > +++ b/drivers/media/i2c/alvium-csi2.c
> > > @@ -1185,19 +1185,19 @@ static int alvium_get_frame_interval(struct alvium_dev *alvium,
> > >  	return ret;
> > >  }
> > >  
> > > -static int alvium_set_frame_rate(struct alvium_dev *alvium)
> > > +static int alvium_set_frame_rate(struct alvium_dev *alvium, u64 fr)
> > >  {
> > >  	struct device *dev = &alvium->i2c_client->dev;
> > >  	int ret;
> > >  
> > >  	ret = alvium_write_hshake(alvium, REG_BCRM_ACQUISITION_FRAME_RATE_RW,
> > > -				  alvium->fr);
> > > +				  fr);
> > >  	if (ret) {
> > >  		dev_err(dev, "Fail to set frame rate lanes reg\n");
> > >  		return ret;
> > >  	}
> > >  
> > > -	dev_dbg(dev, "set frame rate: %llu us\n", alvium->fr);
> > > +	dev_dbg(dev, "set frame rate: %llu us\n", fr);
> > >  
> > >  	return 0;
> > >  }
> > > @@ -1661,10 +1661,11 @@ static int alvium_g_frame_interval(struct v4l2_subdev *sd,
> > >  }
> > >  
> > >  static int alvium_set_frame_interval(struct alvium_dev *alvium,
> > > -				     struct v4l2_subdev_frame_interval *fi)
> > > +				     struct v4l2_subdev_frame_interval *fi,
> > > +				     u64 *req_fr)
> > >  {
> > >  	struct device *dev = &alvium->i2c_client->dev;
> > > -	u64 req_fr, dft_fr, min_fr, max_fr;
> > > +	u64 dft_fr, min_fr, max_fr;
> > >  	int ret;
> > >  
> > >  	if (fi->interval.denominator == 0)
> > > @@ -1681,13 +1682,12 @@ static int alvium_set_frame_interval(struct alvium_dev *alvium,
> > >  	dev_dbg(dev, "fi->interval.denominator = %d\n",
> > >  		fi->interval.denominator);
> > >  
> > > -	req_fr = (u64)((fi->interval.denominator * USEC_PER_SEC) /
> > > +	*req_fr = (u64)((fi->interval.denominator * USEC_PER_SEC) /
> > >  		       fi->interval.numerator);
> > >  
> > > -	if (req_fr >= max_fr && req_fr <= min_fr)
> > > -		req_fr = dft_fr;
> > > +	if (*req_fr >= max_fr && *req_fr <= min_fr)
> > > +		*req_fr = dft_fr;
> > 
> > Shouldn't we clamp the value to [min, max] instead of using the default
> > if it's out of range ? Something like
> > 
> > 	*req_fr = clamp(*req_fr, min_fr, max_fr)
> > 
> > This makes me realize that the current code is wrong, req_fr can't be >=
> > max and <= min at the same time. You probably meant || instead of &&.
> > 
> > This should be fixed in a separate patch.
> 
> If this is ok for you, after this series I can put a patch with || fix
> instead of clamping, because if we clamp dft_fr is not used any more.
> After if you agree I will work on clamping.
> Thanks for the catch! :)

It's fine to fix this on top of the series, but I don't see why you
would need to first use ||. You can call clamp() and remove dft_fr.

> > >  
> > > -	alvium->fr = req_fr;
> > >  	alvium->frame_interval.numerator = fi->interval.numerator;
> > >  	alvium->frame_interval.denominator = fi->interval.denominator;
> > >  
> > > @@ -1699,6 +1699,7 @@ static int alvium_s_frame_interval(struct v4l2_subdev *sd,
> > >  				   struct v4l2_subdev_frame_interval *fi)
> > >  {
> > >  	struct alvium_dev *alvium = sd_to_alvium(sd);
> > > +	u64 req_fr = ALVIUM_DEFAULT_FR_HZ;
> > 
> > Do you need to initialize the variable ? It doesn't seem to be required.
> 
> Really not, it's just to maintain the logic of alvium->fr. I will drop
> this in v3, thanks!
> 
> > With these small issues fixed,
> > 
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > 
> > >  	int ret;
> > >  
> > >  	/*
> > > @@ -1711,9 +1712,9 @@ static int alvium_s_frame_interval(struct v4l2_subdev *sd,
> > >  	if (alvium->streaming)
> > >  		return -EBUSY;
> > >  
> > > -	ret = alvium_set_frame_interval(alvium, fi);
> > > +	ret = alvium_set_frame_interval(alvium, fi, &req_fr);
> > >  	if (!ret)
> > > -		ret = alvium_set_frame_rate(alvium);
> > > +		ret = alvium_set_frame_rate(alvium, req_fr);
> > >  
> > >  	return ret;
> > >  }
> > > @@ -2273,7 +2274,6 @@ static int alvium_subdev_init(struct alvium_dev *alvium)
> > >  	/* Setup initial frame interval*/
> > >  	alvium->frame_interval.numerator = 1;
> > >  	alvium->frame_interval.denominator = ALVIUM_DEFAULT_FR_HZ;
> > > -	alvium->fr = ALVIUM_DEFAULT_FR_HZ;
> > >  
> > >  	/* Setup the initial mode */
> > >  	alvium->mode.fmt = alvium_csi2_default_fmt;
> > > diff --git a/drivers/media/i2c/alvium-csi2.h b/drivers/media/i2c/alvium-csi2.h
> > > index 17f0bbbd1839..80066ac25047 100644
> > > --- a/drivers/media/i2c/alvium-csi2.h
> > > +++ b/drivers/media/i2c/alvium-csi2.h
> > > @@ -443,7 +443,6 @@ struct alvium_dev {
> > >  
> > >  	struct alvium_mode mode;
> > >  	struct v4l2_fract frame_interval;
> > > -	u64 fr;
> > >  
> > >  	u8 h_sup_csi_lanes;
> > >  	u64 link_freq;

-- 
Regards,

Laurent Pinchart

