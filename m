Return-Path: <linux-kernel+bounces-3340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DB1816B34
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C29231F21099
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91500156F6;
	Mon, 18 Dec 2023 10:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJ/OMq5X"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA1F1798D;
	Mon, 18 Dec 2023 10:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50e24e92432so2150149e87.2;
        Mon, 18 Dec 2023 02:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702895441; x=1703500241; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Aiz0j8cbo1CCozyapL+hFUZuXzwFd58t//LIhv+x7l4=;
        b=gJ/OMq5XFwg/Dctgxrrw6zpRe4iYwqJFC610ieJaEN6U/TC5zgAXRkPDvMqXSEAeY3
         Smwu230Zl0M/2sWUX1GO1cpCbx39M3bQRU4fNwqclYRn2mTy1CbnCNcFOwPv9NBfxuKK
         qnLFF4vrlNJFuH1s9OJkh5zaCtqGJkwX9FL1Y+ZOhwS5OdGufj+GonrUP9hYVIE9Obbm
         S7DtKE66y3wZgPggAP8YCGF5TUS4N9pEm5KLSq/P4JN5pNxCCexU5gKEHyki/03lt2cG
         PCMDacWqHrww9/or2L4VD7/GcwgzzpiL+J1b4dgEkKf912TxrO6CpWTxqN9TZWD/56se
         oblg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702895441; x=1703500241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aiz0j8cbo1CCozyapL+hFUZuXzwFd58t//LIhv+x7l4=;
        b=afCdZ181HYgD6Te/CSEeBFgNATaSNHeYmNcYYmHYvX9sWIspSAbTWkreb2mqCZ/8Cn
         M24KSRxvMlay4zCTfIzbWNN5v1ioyJTVTSI/rB1PnMph3Ty7vokzmlMyyUF3FeeNExFS
         ib8yawyAPgrX0gkt6R+oKKhC3jmmNMbSUANJatLB9hFVQnoOd/LATR5/NdQdAoWEtZiM
         WbGw9wpfVK2LvuzpvaLEjK9Qw3HyjOTf14HMnzmQVrfBO6auoiyCf/UXukWXxzIwZY1t
         KKNec1UWX/48fC1s3ArFtXXUq+gcdhtNNcz9epFfACUnjOhi1+bZBNqfRUK4pr4f/xRV
         t36w==
X-Gm-Message-State: AOJu0YyT2RBgUS3tHcyVNW9rYu/nRdPo7KL9b36+8IHbgYJK8ZhjSIgY
	nT1UclVJIaU2EpU8OriO0Z9ZH90JDCY=
X-Google-Smtp-Source: AGHT+IGfxTN99C2b5MUZgCQmtVr0mOJBFW8V7duIsjNl2KAMemmyDy2255gKyCn8N5P2J9Q7jYwKSQ==
X-Received: by 2002:a05:6512:4023:b0:50e:2494:d315 with SMTP id br35-20020a056512402300b0050e2494d315mr2309427lfb.126.1702895441064;
        Mon, 18 Dec 2023 02:30:41 -0800 (PST)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation (net-188-217-59-229.cust.vodafonedsl.it. [188.217.59.229])
        by smtp.gmail.com with ESMTPSA id l12-20020a50cbcc000000b0054b53aacd86sm10205954edi.65.2023.12.18.02.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 02:30:40 -0800 (PST)
Date: Mon, 18 Dec 2023 11:30:38 +0100
From: Tommaso Merciai <tomm.merciai@gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linuxfancy@googlegroups.com, sakari.ailus@linux.intel.com,
	Martin Hecht <martin.hecht@avnet.eu>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] media: i2c: alvium: store frame interval in subdev
 state
Message-ID: <ZYAfThT/mHdzGdAh@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
References: <20231215082452.1720481-1-tomm.merciai@gmail.com>
 <20231215082452.1720481-4-tomm.merciai@gmail.com>
 <20231218025905.GJ5290@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218025905.GJ5290@pendragon.ideasonboard.com>

Hi Laurent,

On Mon, Dec 18, 2023 at 04:59:05AM +0200, Laurent Pinchart wrote:
> Hi Tommaso,
> 
> Thank you for the patch.
> 
> On Fri, Dec 15, 2023 at 09:24:52AM +0100, Tommaso Merciai wrote:
> > Use the newly added storage for frame interval in the subdev state to
> > simplify the driver.
> > 
> > Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> > ---
> >  drivers/media/i2c/alvium-csi2.c | 40 ++++++++++-----------------------
> >  drivers/media/i2c/alvium-csi2.h |  2 --
> >  2 files changed, 12 insertions(+), 30 deletions(-)
> > 
> > diff --git a/drivers/media/i2c/alvium-csi2.c b/drivers/media/i2c/alvium-csi2.c
> > index fde456357be1..81f683b3c849 100644
> > --- a/drivers/media/i2c/alvium-csi2.c
> > +++ b/drivers/media/i2c/alvium-csi2.c
> > @@ -1643,25 +1643,6 @@ static int alvium_hw_init(struct alvium_dev *alvium)
> >  }
> >  
> >  /* --------------- Subdev Operations --------------- */
> > -
> > -static int alvium_g_frame_interval(struct v4l2_subdev *sd,
> > -				   struct v4l2_subdev_state *sd_state,
> > -				   struct v4l2_subdev_frame_interval *fi)
> > -{
> > -	struct alvium_dev *alvium = sd_to_alvium(sd);
> > -
> > -	/*
> > -	 * FIXME: Implement support for V4L2_SUBDEV_FORMAT_TRY, using the V4L2
> > -	 * subdev active state API.
> > -	 */
> > -	if (fi->which != V4L2_SUBDEV_FORMAT_ACTIVE)
> > -		return -EINVAL;
> > -
> > -	fi->interval = alvium->frame_interval;
> > -
> > -	return 0;
> > -}
> > -
> >  static int alvium_s_frame_interval(struct v4l2_subdev *sd,
> >  				   struct v4l2_subdev_state *sd_state,
> >  				   struct v4l2_subdev_frame_interval *fi)
> > @@ -1669,6 +1650,7 @@ static int alvium_s_frame_interval(struct v4l2_subdev *sd,
> >  	struct alvium_dev *alvium = sd_to_alvium(sd);
> >  	struct device *dev = &alvium->i2c_client->dev;
> >  	u64 req_fr, dft_fr, min_fr, max_fr;
> > +	struct v4l2_fract *interval;
> >  	int ret;
> >  
> >  	/*
> 
> You should drop the FIXME comment here and the ACTIVE check...

Oks, thanks.

> 
> > @@ -1701,9 +1683,10 @@ static int alvium_s_frame_interval(struct v4l2_subdev *sd,
> >  	if (req_fr >= max_fr && req_fr <= min_fr)
> >  		req_fr = dft_fr;
> >  
> > -	alvium->fr = req_fr;
> > -	alvium->frame_interval.numerator = fi->interval.numerator;
> > -	alvium->frame_interval.denominator = fi->interval.denominator;
> > +	interval = v4l2_subdev_state_get_interval(sd_state, 0);
> > +
> > +	interval->numerator = fi->interval.numerator;
> > +	interval->denominator = fi->interval.denominator;
> >  
> 
> 
> ... and here only call alvium_set_frame_rate() for the ACTIVE frame
> interval.

I don't completely got this comment, can you give me more details about
please. Thanks in advance!

Regards,
Tommaso

> 
> >  	return alvium_set_frame_rate(alvium, req_fr);
> >  }
> > @@ -1853,6 +1836,7 @@ static int alvium_init_state(struct v4l2_subdev *sd,
> >  {
> >  	struct alvium_dev *alvium = sd_to_alvium(sd);
> >  	struct alvium_mode *mode = &alvium->mode;
> > +	struct v4l2_fract *interval;
> >  	struct v4l2_subdev_format sd_fmt = {
> >  		.which = V4L2_SUBDEV_FORMAT_TRY,
> >  		.format = alvium_csi2_default_fmt,
> > @@ -1870,6 +1854,11 @@ static int alvium_init_state(struct v4l2_subdev *sd,
> >  	*v4l2_subdev_state_get_crop(state, 0) = sd_crop.rect;
> >  	*v4l2_subdev_state_get_format(state, 0) = sd_fmt.format;
> >  
> > +	/* Setup initial frame interval*/
> > +	interval = v4l2_subdev_state_get_interval(state, 0);
> > +	interval->numerator = 1;
> > +	interval->denominator = ALVIUM_DEFAULT_FR_HZ;
> > +
> >  	return 0;
> >  }
> >  
> > @@ -2239,7 +2228,7 @@ static const struct v4l2_subdev_pad_ops alvium_pad_ops = {
> >  	.set_fmt = alvium_set_fmt,
> >  	.get_selection = alvium_get_selection,
> >  	.set_selection = alvium_set_selection,
> > -	.get_frame_interval = alvium_g_frame_interval,
> > +	.get_frame_interval = v4l2_subdev_get_frame_interval,
> >  	.set_frame_interval = alvium_s_frame_interval,
> >  };
> >  
> > @@ -2260,11 +2249,6 @@ static int alvium_subdev_init(struct alvium_dev *alvium)
> >  	struct v4l2_subdev *sd = &alvium->sd;
> >  	int ret;
> >  
> > -	/* Setup initial frame interval*/
> > -	alvium->frame_interval.numerator = 1;
> > -	alvium->frame_interval.denominator = ALVIUM_DEFAULT_FR_HZ;
> > -	alvium->fr = ALVIUM_DEFAULT_FR_HZ;
> > -
> >  	/* Setup the initial mode */
> >  	alvium->mode.fmt = alvium_csi2_default_fmt;
> >  	alvium->mode.width = alvium_csi2_default_fmt.width;
> > diff --git a/drivers/media/i2c/alvium-csi2.h b/drivers/media/i2c/alvium-csi2.h
> > index a6529b28e7dd..f5e26257b042 100644
> > --- a/drivers/media/i2c/alvium-csi2.h
> > +++ b/drivers/media/i2c/alvium-csi2.h
> > @@ -442,8 +442,6 @@ struct alvium_dev {
> >  	s32 inc_sharp;
> >  
> >  	struct alvium_mode mode;
> > -	struct v4l2_fract frame_interval;
> > -	u64 fr;
> 
> The fr field should have been removed by a previous patch (the one that
> will go between 1/3 an 2/3, see my review of 1/3) as shown by the fact
> that this patch only removes two locations where the field is set but
> none where it's read.
> 
> >  
> >  	u8 h_sup_csi_lanes;
> >  	u64 link_freq;
> 
> -- 
> Regards,
> 
> Laurent Pinchart

