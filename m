Return-Path: <linux-kernel+bounces-6677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 118B7819BF6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CAC5B24408
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F3C20322;
	Wed, 20 Dec 2023 10:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCM7rQ73"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7C920300;
	Wed, 20 Dec 2023 10:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-553338313a0so4326507a12.2;
        Wed, 20 Dec 2023 02:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703066574; x=1703671374; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kfu0M4uWTXFwTI3vwajeh5o3Zd+yxSRhcHBR++GaThc=;
        b=lCM7rQ73Dvf+Ml0bIsWoZDkFskt6ucHV6sOOY3G4sdCo/CENNLM/a1GWUbFT5Hq7dV
         Pa8Hq/ruK5b2sxVoyNIjRBnbR6/9CJSNaxWX+B75xvEyakEyKIVCvG6EZTKTWsBzVBi2
         SGuVpIsn7INKKlP0PEmcdzSKjTdtDxwzOcYbgJZVBaY/0YQRpKFPnh2jlbOkj1SIs7QF
         o7k2CypYEG/pRqYtnzrRD0RH239Ny6WAds5/26Or6XImMt5890n1scrm/q4qnpi71vNW
         ICOhzmESuQ9qk9qsD35BT8XaJhJ5E1oe6UoxxpKTmM/psBsVDu7YpPU4ok0oaGICTks+
         y3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703066574; x=1703671374;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kfu0M4uWTXFwTI3vwajeh5o3Zd+yxSRhcHBR++GaThc=;
        b=aXkm9uPFMWZM8FgI4s/RUtIOmhNmxzVrxiV8Wp8RBpCx1P7JLOWANdp7cRU/gBZm7U
         oh0u/zs7JKf70WZOO2YGtwuCxuCrCv7RnaqnD17Vk45Cvt6wgXXnDr8wj6AgcjyGLqfA
         AnEwXledI410AGYXDPq+Ejvc6HaPwWBZDkgh+LcI46xqKw3fxWKFp4Lqswt4CKrkELm7
         aOLJy1hvxWHBxGhLgYtrzc8eCy3e/egsZ6uqoemfW5px+7micJ/vk3vAfY6VNGpMSUb8
         pRGmbhvav1cgrXgvB2L+KuwQPlHX9HlXTRIhJa+/tiHf/ZuSpE1X6M8tlnozmjyxMvTe
         wwbw==
X-Gm-Message-State: AOJu0YxCV9vk7YMeUpgFypLrV+PHo3pWNJ4ZJx69bfugRJ/p/8HdsWnx
	o19s+u+GGsqgK8py55lzT2eS2/176H0=
X-Google-Smtp-Source: AGHT+IFF3B7AIruRKJwSxlwY7IYqV04Xf8hAr0rl9q0r+FbP+wZb6Aj0YIkYfEccPOnPYu+ArX6wKg==
X-Received: by 2002:a50:bb44:0:b0:553:2b04:14a2 with SMTP id y62-20020a50bb44000000b005532b0414a2mr3316554ede.14.1703066573994;
        Wed, 20 Dec 2023 02:02:53 -0800 (PST)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation (net-188-217-59-229.cust.vodafonedsl.it. [188.217.59.229])
        by smtp.gmail.com with ESMTPSA id m11-20020a50cc0b000000b0054cb316499dsm12420971edi.10.2023.12.20.02.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 02:02:53 -0800 (PST)
Date: Wed, 20 Dec 2023 11:02:51 +0100
From: Tommaso Merciai <tomm.merciai@gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linuxfancy@googlegroups.com, martin.hecht@avnet.eu,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] media: i2c: alvium: removal of fr field
Message-ID: <ZYK7y/jaEZ2JHsnH@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
References: <20231220085609.2595732-1-tomm.merciai@gmail.com>
 <20231220085609.2595732-3-tomm.merciai@gmail.com>
 <20231220091309.GG29638@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220091309.GG29638@pendragon.ideasonboard.com>

Hi Laurent,
Thanks for your review.

On Wed, Dec 20, 2023 at 11:13:09AM +0200, Laurent Pinchart wrote:
> Hi Tommaso,
> 
> Thank you for the patch.
> 
> Use the imperative in the subject line:
> 
> media: i2c: alvium: Remove the fr field of the alvium_dev structure
> 
> On Wed, Dec 20, 2023 at 09:56:07AM +0100, Tommaso Merciai wrote:
> > The fr (frame rate) field of the alvium_dev structure is
> > only used to pass result from alvium_set_frame_interval() to
> > alvium_set_frame_rate() that writes this info into the hw reg.
> > Replace them with function parameter.
> 
> Replace it with a function parameter.

Thanks I'll fix this in v3.

> 
> > 
> > Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> > ---
> >  drivers/media/i2c/alvium-csi2.c | 24 ++++++++++++------------
> >  drivers/media/i2c/alvium-csi2.h |  1 -
> >  2 files changed, 12 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/media/i2c/alvium-csi2.c b/drivers/media/i2c/alvium-csi2.c
> > index 0dcd69bf9f92..a9ff6cc97cff 100644
> > --- a/drivers/media/i2c/alvium-csi2.c
> > +++ b/drivers/media/i2c/alvium-csi2.c
> > @@ -1185,19 +1185,19 @@ static int alvium_get_frame_interval(struct alvium_dev *alvium,
> >  	return ret;
> >  }
> >  
> > -static int alvium_set_frame_rate(struct alvium_dev *alvium)
> > +static int alvium_set_frame_rate(struct alvium_dev *alvium, u64 fr)
> >  {
> >  	struct device *dev = &alvium->i2c_client->dev;
> >  	int ret;
> >  
> >  	ret = alvium_write_hshake(alvium, REG_BCRM_ACQUISITION_FRAME_RATE_RW,
> > -				  alvium->fr);
> > +				  fr);
> >  	if (ret) {
> >  		dev_err(dev, "Fail to set frame rate lanes reg\n");
> >  		return ret;
> >  	}
> >  
> > -	dev_dbg(dev, "set frame rate: %llu us\n", alvium->fr);
> > +	dev_dbg(dev, "set frame rate: %llu us\n", fr);
> >  
> >  	return 0;
> >  }
> > @@ -1661,10 +1661,11 @@ static int alvium_g_frame_interval(struct v4l2_subdev *sd,
> >  }
> >  
> >  static int alvium_set_frame_interval(struct alvium_dev *alvium,
> > -				     struct v4l2_subdev_frame_interval *fi)
> > +				     struct v4l2_subdev_frame_interval *fi,
> > +				     u64 *req_fr)
> >  {
> >  	struct device *dev = &alvium->i2c_client->dev;
> > -	u64 req_fr, dft_fr, min_fr, max_fr;
> > +	u64 dft_fr, min_fr, max_fr;
> >  	int ret;
> >  
> >  	if (fi->interval.denominator == 0)
> > @@ -1681,13 +1682,12 @@ static int alvium_set_frame_interval(struct alvium_dev *alvium,
> >  	dev_dbg(dev, "fi->interval.denominator = %d\n",
> >  		fi->interval.denominator);
> >  
> > -	req_fr = (u64)((fi->interval.denominator * USEC_PER_SEC) /
> > +	*req_fr = (u64)((fi->interval.denominator * USEC_PER_SEC) /
> >  		       fi->interval.numerator);
> >  
> > -	if (req_fr >= max_fr && req_fr <= min_fr)
> > -		req_fr = dft_fr;
> > +	if (*req_fr >= max_fr && *req_fr <= min_fr)
> > +		*req_fr = dft_fr;
> 
> Shouldn't we clamp the value to [min, max] instead of using the default
> if it's out of range ? Something like
> 
> 	*req_fr = clamp(*req_fr, min_fr, max_fr)
> 
> This makes me realize that the current code is wrong, req_fr can't be >=
> max and <= min at the same time. You probably meant || instead of &&.
> 
> This should be fixed in a separate patch.

If this is ok for you, after this series I can put a patch with || fix
instead of clamping, because if we clamp dft_fr is not used any more.
After if you agree I will work on clamping.
Thanks for the catch! :)

> 
> >  
> > -	alvium->fr = req_fr;
> >  	alvium->frame_interval.numerator = fi->interval.numerator;
> >  	alvium->frame_interval.denominator = fi->interval.denominator;
> >  
> > @@ -1699,6 +1699,7 @@ static int alvium_s_frame_interval(struct v4l2_subdev *sd,
> >  				   struct v4l2_subdev_frame_interval *fi)
> >  {
> >  	struct alvium_dev *alvium = sd_to_alvium(sd);
> > +	u64 req_fr = ALVIUM_DEFAULT_FR_HZ;
> 
> Do you need to initialize the variable ? It doesn't seem to be required.

Really not, it's just to maintain the logic of alvium->fr. I will drop
this in v3, thanks!

Regards,
Tommaso


> 
> With these small issues fixed,
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> >  	int ret;
> >  
> >  	/*
> > @@ -1711,9 +1712,9 @@ static int alvium_s_frame_interval(struct v4l2_subdev *sd,
> >  	if (alvium->streaming)
> >  		return -EBUSY;
> >  
> > -	ret = alvium_set_frame_interval(alvium, fi);
> > +	ret = alvium_set_frame_interval(alvium, fi, &req_fr);
> >  	if (!ret)
> > -		ret = alvium_set_frame_rate(alvium);
> > +		ret = alvium_set_frame_rate(alvium, req_fr);
> >  
> >  	return ret;
> >  }
> > @@ -2273,7 +2274,6 @@ static int alvium_subdev_init(struct alvium_dev *alvium)
> >  	/* Setup initial frame interval*/
> >  	alvium->frame_interval.numerator = 1;
> >  	alvium->frame_interval.denominator = ALVIUM_DEFAULT_FR_HZ;
> > -	alvium->fr = ALVIUM_DEFAULT_FR_HZ;
> >  
> >  	/* Setup the initial mode */
> >  	alvium->mode.fmt = alvium_csi2_default_fmt;
> > diff --git a/drivers/media/i2c/alvium-csi2.h b/drivers/media/i2c/alvium-csi2.h
> > index 17f0bbbd1839..80066ac25047 100644
> > --- a/drivers/media/i2c/alvium-csi2.h
> > +++ b/drivers/media/i2c/alvium-csi2.h
> > @@ -443,7 +443,6 @@ struct alvium_dev {
> >  
> >  	struct alvium_mode mode;
> >  	struct v4l2_fract frame_interval;
> > -	u64 fr;
> >  
> >  	u8 h_sup_csi_lanes;
> >  	u64 link_freq;
> 
> -- 
> Regards,
> 
> Laurent Pinchart

