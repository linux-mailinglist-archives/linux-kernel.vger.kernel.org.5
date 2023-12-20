Return-Path: <linux-kernel+bounces-6808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A153819DD8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C71F61F21C3E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CC921361;
	Wed, 20 Dec 2023 11:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXvlXXqV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1212021345;
	Wed, 20 Dec 2023 11:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-54c7744a93fso6909816a12.2;
        Wed, 20 Dec 2023 03:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703071166; x=1703675966; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=53ALlqpQQBiJfMHSAH0XUy1XX9K4mSw/bFk5aEE1Ong=;
        b=mXvlXXqVKwH0k89OILyeM3LdObiCayuWQBYPeFyDAlj1bEg91FdZXcvyQe1AKCNNDu
         SyB1C4ZhpBscCU5wvx2UEP9QAtBMFDQ3Zcfnq3iUc37sjq+TL8KM0M1QS0PuE4+fi9go
         6xZyS4oPFrfIONpFxmk/J9TyEWakjByj/yAJZkyN9vflKcaluhMGdZV5x9e4YMwNdIoX
         3FOlA87xWcZV1gkw/HxcMJ/n3NMBFFAxaxBIbT/jLAo52Q4Whmu7i3HQQ6yM3dznLmD5
         0Aa+OZsZcRj/ssFQjEySMXWZFNM8TuGz53VJyfZvL/iTzxBHX4bjdVQUbm2dPHl8xfqJ
         /QpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703071166; x=1703675966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=53ALlqpQQBiJfMHSAH0XUy1XX9K4mSw/bFk5aEE1Ong=;
        b=ICyTng621Q4RKnA5PFTxfEGWrpproZfWEFW2/siknK5uK9TT+692kx+H56g4a39AKO
         C5TeEp0PAjolSvHYEpjAHanKTzMIQTIT89dzRLxyq0yEUuqSPe0iuuR6t1u9tvvGW7E8
         zMncAeOy4S8ENCS1B0KDbtJwoLGcZxlg5ndpKKSS4SfuIygqGDww2Swoef19YA3y0Ybe
         rZMeR51LStxewyQYD13pEq3pAFdUeawHlem4HEEKKQ2IVlF2XvzSC1eXFHyFFRL+o9Cg
         KRcwqv5ZBOeLlhR/cEGSd0e6QRg1KgIVcPhHuWozzL5Wlwmhg2mSnuWHCvlSRHV2kBVI
         H6DQ==
X-Gm-Message-State: AOJu0YzC+6b+b4hrMz+yicOfIMddd6j0VcY73ELpcm8TZhNizl3M8WJZ
	tcpUl0X+hhqUvS6db0hrv+s=
X-Google-Smtp-Source: AGHT+IEO9tjxM7UBMuqtKeASifmELeWwumI2TaDQVK5BwBjvkk3AyHRkAGNSkpwu0mOrPkTWfv1GUw==
X-Received: by 2002:a50:85cb:0:b0:551:9405:46a9 with SMTP id q11-20020a5085cb000000b00551940546a9mr6715587edh.30.1703071166078;
        Wed, 20 Dec 2023 03:19:26 -0800 (PST)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation (net-188-217-59-229.cust.vodafonedsl.it. [188.217.59.229])
        by smtp.gmail.com with ESMTPSA id r14-20020aa7cb8e000000b00552f2607d2asm4725986edt.96.2023.12.20.03.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 03:19:25 -0800 (PST)
Date: Wed, 20 Dec 2023 12:19:23 +0100
From: Tommaso Merciai <tomm.merciai@gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linuxfancy@googlegroups.com, martin.hecht@avnet.eu,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] media: i2c: alvium: removal of fr field
Message-ID: <ZYLNuw1/IJg7jrEa@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
References: <20231220085609.2595732-1-tomm.merciai@gmail.com>
 <20231220085609.2595732-3-tomm.merciai@gmail.com>
 <20231220091309.GG29638@pendragon.ideasonboard.com>
 <ZYK7y/jaEZ2JHsnH@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
 <20231220100643.GJ29638@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220100643.GJ29638@pendragon.ideasonboard.com>

Hi Laurent,
Thanks for your comment.

On Wed, Dec 20, 2023 at 12:06:43PM +0200, Laurent Pinchart wrote:
> On Wed, Dec 20, 2023 at 11:02:51AM +0100, Tommaso Merciai wrote:
> > Hi Laurent,
> > Thanks for your review.
> > 
> > On Wed, Dec 20, 2023 at 11:13:09AM +0200, Laurent Pinchart wrote:
> > > Hi Tommaso,
> > > 
> > > Thank you for the patch.
> > > 
> > > Use the imperative in the subject line:
> > > 
> > > media: i2c: alvium: Remove the fr field of the alvium_dev structure
> > > 
> > > On Wed, Dec 20, 2023 at 09:56:07AM +0100, Tommaso Merciai wrote:
> > > > The fr (frame rate) field of the alvium_dev structure is
> > > > only used to pass result from alvium_set_frame_interval() to
> > > > alvium_set_frame_rate() that writes this info into the hw reg.
> > > > Replace them with function parameter.
> > > 
> > > Replace it with a function parameter.
> > 
> > Thanks I'll fix this in v3.
> > 
> > > 
> > > > 
> > > > Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> > > > ---
> > > >  drivers/media/i2c/alvium-csi2.c | 24 ++++++++++++------------
> > > >  drivers/media/i2c/alvium-csi2.h |  1 -
> > > >  2 files changed, 12 insertions(+), 13 deletions(-)
> > > > 
> > > > diff --git a/drivers/media/i2c/alvium-csi2.c b/drivers/media/i2c/alvium-csi2.c
> > > > index 0dcd69bf9f92..a9ff6cc97cff 100644
> > > > --- a/drivers/media/i2c/alvium-csi2.c
> > > > +++ b/drivers/media/i2c/alvium-csi2.c
> > > > @@ -1185,19 +1185,19 @@ static int alvium_get_frame_interval(struct alvium_dev *alvium,
> > > >  	return ret;
> > > >  }
> > > >  
> > > > -static int alvium_set_frame_rate(struct alvium_dev *alvium)
> > > > +static int alvium_set_frame_rate(struct alvium_dev *alvium, u64 fr)
> > > >  {
> > > >  	struct device *dev = &alvium->i2c_client->dev;
> > > >  	int ret;
> > > >  
> > > >  	ret = alvium_write_hshake(alvium, REG_BCRM_ACQUISITION_FRAME_RATE_RW,
> > > > -				  alvium->fr);
> > > > +				  fr);
> > > >  	if (ret) {
> > > >  		dev_err(dev, "Fail to set frame rate lanes reg\n");
> > > >  		return ret;
> > > >  	}
> > > >  
> > > > -	dev_dbg(dev, "set frame rate: %llu us\n", alvium->fr);
> > > > +	dev_dbg(dev, "set frame rate: %llu us\n", fr);
> > > >  
> > > >  	return 0;
> > > >  }
> > > > @@ -1661,10 +1661,11 @@ static int alvium_g_frame_interval(struct v4l2_subdev *sd,
> > > >  }
> > > >  
> > > >  static int alvium_set_frame_interval(struct alvium_dev *alvium,
> > > > -				     struct v4l2_subdev_frame_interval *fi)
> > > > +				     struct v4l2_subdev_frame_interval *fi,
> > > > +				     u64 *req_fr)
> > > >  {
> > > >  	struct device *dev = &alvium->i2c_client->dev;
> > > > -	u64 req_fr, dft_fr, min_fr, max_fr;
> > > > +	u64 dft_fr, min_fr, max_fr;
> > > >  	int ret;
> > > >  
> > > >  	if (fi->interval.denominator == 0)
> > > > @@ -1681,13 +1682,12 @@ static int alvium_set_frame_interval(struct alvium_dev *alvium,
> > > >  	dev_dbg(dev, "fi->interval.denominator = %d\n",
> > > >  		fi->interval.denominator);
> > > >  
> > > > -	req_fr = (u64)((fi->interval.denominator * USEC_PER_SEC) /
> > > > +	*req_fr = (u64)((fi->interval.denominator * USEC_PER_SEC) /
> > > >  		       fi->interval.numerator);
> > > >  
> > > > -	if (req_fr >= max_fr && req_fr <= min_fr)
> > > > -		req_fr = dft_fr;
> > > > +	if (*req_fr >= max_fr && *req_fr <= min_fr)
> > > > +		*req_fr = dft_fr;
> > > 
> > > Shouldn't we clamp the value to [min, max] instead of using the default
> > > if it's out of range ? Something like
> > > 
> > > 	*req_fr = clamp(*req_fr, min_fr, max_fr)
> > > 
> > > This makes me realize that the current code is wrong, req_fr can't be >=
> > > max and <= min at the same time. You probably meant || instead of &&.
> > > 
> > > This should be fixed in a separate patch.
> > 
> > If this is ok for you, after this series I can put a patch with || fix
> > instead of clamping, because if we clamp dft_fr is not used any more.
> > After if you agree I will work on clamping.
> > Thanks for the catch! :)
> 
> It's fine to fix this on top of the series, but I don't see why you
> would need to first use ||. You can call clamp() and remove dft_fr.

I'm just thinking out loud eh :)

Maybe in the future we need to expose fr infos to the user to play with
that. But we are writing for now, then we can replan to readd dft_fr
read later.

I think this is what your are suggesting:

+++ b/drivers/media/i2c/alvium-csi2.c
@@ -1171,12 +1171,10 @@ static int alvium_set_bayer_pattern(struct alvium_dev *alvium,
 }

 static int alvium_get_frame_interval(struct alvium_dev *alvium,
-                                    u64 *dft_fr, u64 *min_fr, u64 *max_fr)
+                                    u64 *min_fr, u64 *max_fr)
 {
        int ret = 0;

-       alvium_read(alvium, REG_BCRM_ACQUISITION_FRAME_RATE_RW,
-                   dft_fr, &ret);
        alvium_read(alvium, REG_BCRM_ACQUISITION_FRAME_RATE_MIN_R,
                    min_fr, &ret);
        alvium_read(alvium, REG_BCRM_ACQUISITION_FRAME_RATE_MAX_R,
@@ -1647,7 +1645,7 @@ static int alvium_s_frame_interval(struct v4l2_subdev *sd,
 {
        struct alvium_dev *alvium = sd_to_alvium(sd);
        struct device *dev = &alvium->i2c_client->dev;
-       u64 req_fr, dft_fr, min_fr, max_fr;
+       u64 req_fr, min_fr, max_fr;
        struct v4l2_fract *interval;
        int ret;

@@ -1657,7 +1655,7 @@ static int alvium_s_frame_interval(struct v4l2_subdev *sd,
        if (fi->interval.denominator == 0)
                return -EINVAL;

-       ret = alvium_get_frame_interval(alvium, &dft_fr, &min_fr, &max_fr);
+       ret = alvium_get_frame_interval(alvium, &min_fr, &max_fr);
        if (ret) {
                dev_err(dev, "Fail to get frame interval\n");
                return ret;
@@ -1670,9 +1668,7 @@ static int alvium_s_frame_interval(struct v4l2_subdev *sd,

        req_fr = (u64)((fi->interval.denominator * USEC_PER_SEC) /
                       fi->interval.numerator);
-
-       if (req_fr >= max_fr && req_fr <= min_fr)
-               req_fr = dft_fr;
+       req_fr = clamp(req_fr, min_fr, max_fr);

        interval = v4l2_subdev_state_get_interval(sd_state, 0);

right?
Thanks again.

Regards,
Tommaso

> 
> > > >  
> > > > -	alvium->fr = req_fr;
> > > >  	alvium->frame_interval.numerator = fi->interval.numerator;
> > > >  	alvium->frame_interval.denominator = fi->interval.denominator;
> > > >  
> > > > @@ -1699,6 +1699,7 @@ static int alvium_s_frame_interval(struct v4l2_subdev *sd,
> > > >  				   struct v4l2_subdev_frame_interval *fi)
> > > >  {
> > > >  	struct alvium_dev *alvium = sd_to_alvium(sd);
> > > > +	u64 req_fr = ALVIUM_DEFAULT_FR_HZ;
> > > 
> > > Do you need to initialize the variable ? It doesn't seem to be required.
> > 
> > Really not, it's just to maintain the logic of alvium->fr. I will drop
> > this in v3, thanks!
> > 
> > > With these small issues fixed,
> > > 
> > > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > 
> > > >  	int ret;
> > > >  
> > > >  	/*
> > > > @@ -1711,9 +1712,9 @@ static int alvium_s_frame_interval(struct v4l2_subdev *sd,
> > > >  	if (alvium->streaming)
> > > >  		return -EBUSY;
> > > >  
> > > > -	ret = alvium_set_frame_interval(alvium, fi);
> > > > +	ret = alvium_set_frame_interval(alvium, fi, &req_fr);
> > > >  	if (!ret)
> > > > -		ret = alvium_set_frame_rate(alvium);
> > > > +		ret = alvium_set_frame_rate(alvium, req_fr);
> > > >  
> > > >  	return ret;
> > > >  }
> > > > @@ -2273,7 +2274,6 @@ static int alvium_subdev_init(struct alvium_dev *alvium)
> > > >  	/* Setup initial frame interval*/
> > > >  	alvium->frame_interval.numerator = 1;
> > > >  	alvium->frame_interval.denominator = ALVIUM_DEFAULT_FR_HZ;
> > > > -	alvium->fr = ALVIUM_DEFAULT_FR_HZ;
> > > >  
> > > >  	/* Setup the initial mode */
> > > >  	alvium->mode.fmt = alvium_csi2_default_fmt;
> > > > diff --git a/drivers/media/i2c/alvium-csi2.h b/drivers/media/i2c/alvium-csi2.h
> > > > index 17f0bbbd1839..80066ac25047 100644
> > > > --- a/drivers/media/i2c/alvium-csi2.h
> > > > +++ b/drivers/media/i2c/alvium-csi2.h
> > > > @@ -443,7 +443,6 @@ struct alvium_dev {
> > > >  
> > > >  	struct alvium_mode mode;
> > > >  	struct v4l2_fract frame_interval;
> > > > -	u64 fr;
> > > >  
> > > >  	u8 h_sup_csi_lanes;
> > > >  	u64 link_freq;
> 
> -- 
> Regards,
> 
> Laurent Pinchart

