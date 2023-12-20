Return-Path: <linux-kernel+bounces-6859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7ECD819E99
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D496B25F09
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD2822099;
	Wed, 20 Dec 2023 12:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCnXRXY4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A7D224C8;
	Wed, 20 Dec 2023 12:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a2370535060so125235666b.1;
        Wed, 20 Dec 2023 04:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703073795; x=1703678595; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dgbdkWLMiPIzD26meL59+TkjWSddN1QUdzXBZ0iT0ZI=;
        b=OCnXRXY4vDaLnih0OJTCF7pGpWW0LRwmjErfC7qEiqweawGbg2CsWaQUZQ8dli7hsN
         daIInZPRfM/umlcYisCx281WQLgkZUbfF6NSvhK4xHc7H4KPCZ7DxKmBwyOcb/JZwdjZ
         vtMcvYgfenhgHFtJpeRjeRSRZO7ls9dsJzeP946hsHsySRu712CY6RJhP/AiHQsgXnwJ
         58e8JvZZxgo3ccalVbD3EYAAkLTmWb4KM1Ii+yZAorq+fpyzfowpRRsUBUfuaJ9Pjzwr
         jQrLDckTqZQ+T0WaKv4utceGa0SPzgtokGBk3XuyH3Dk6WbdUJ2k47EOXLzF+nGg6+yF
         8kXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703073795; x=1703678595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dgbdkWLMiPIzD26meL59+TkjWSddN1QUdzXBZ0iT0ZI=;
        b=RnnNgC1SNyhgoygd/h3Btnxhphd3SM+5t7NFoRxlCo9NMxmLq7mtjJMU4zBIqxIrOl
         oGBjT6F0wHEGmwu4d2HgVC4KD2dXWZBSExUB2PIvxsbnj9q1KhnQ3nGmBjwSm9xBvTFS
         2wXdtCDoTV+hdPjd6Iob8xlg2B1FChRRrehZVzIZGrbVDYG5SlAKNvk3hJHhhKAVYdt7
         nygi2b7+9chn8+nYOEn+rZivgioRXQHYLl39W4FyK8Rv8bYHp9cxUdT5MLXFK5+S5Eb1
         y3xctHpBLC3jqKymuNEt/MvGwpUMSfqmQruQ3oRNpMFAsyPowNlXJeeSCHl9MHt4GpwZ
         PEgA==
X-Gm-Message-State: AOJu0Yxg3q2PgjLdhXdTgbahfvWzCQxdNJYKPD+iCDDbsJ4lIPYRS2CS
	qpE6TXCyVR+Owx//aEDVK58=
X-Google-Smtp-Source: AGHT+IGhey7MZbkhg+uNa0F2dgOgAd3dSpB/Ah8taVuCWGK3QEvxZmKkIbjIQzWC7E1KGuO1kxv2nw==
X-Received: by 2002:a17:906:d0cd:b0:a23:690e:48bf with SMTP id bq13-20020a170906d0cd00b00a23690e48bfmr2507776ejb.12.1703073795216;
        Wed, 20 Dec 2023 04:03:15 -0800 (PST)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation (net-188-217-59-229.cust.vodafonedsl.it. [188.217.59.229])
        by smtp.gmail.com with ESMTPSA id tp25-20020a170907c49900b00a1f7c502736sm15298795ejc.164.2023.12.20.04.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 04:03:14 -0800 (PST)
Date: Wed, 20 Dec 2023 13:03:12 +0100
From: Tommaso Merciai <tomm.merciai@gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linuxfancy@googlegroups.com, martin.hecht@avnet.eu,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] media: i2c: alvium: removal of fr field
Message-ID: <ZYLYAMrEtCoQ940z@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
References: <20231220085609.2595732-1-tomm.merciai@gmail.com>
 <20231220085609.2595732-3-tomm.merciai@gmail.com>
 <20231220091309.GG29638@pendragon.ideasonboard.com>
 <ZYK7y/jaEZ2JHsnH@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
 <20231220100643.GJ29638@pendragon.ideasonboard.com>
 <ZYLNuw1/IJg7jrEa@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
 <20231220112902.GE25366@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220112902.GE25366@pendragon.ideasonboard.com>

On Wed, Dec 20, 2023 at 01:29:02PM +0200, Laurent Pinchart wrote:
> On Wed, Dec 20, 2023 at 12:19:23PM +0100, Tommaso Merciai wrote:
> > On Wed, Dec 20, 2023 at 12:06:43PM +0200, Laurent Pinchart wrote:
> > > On Wed, Dec 20, 2023 at 11:02:51AM +0100, Tommaso Merciai wrote:
> > > > On Wed, Dec 20, 2023 at 11:13:09AM +0200, Laurent Pinchart wrote:
> > > > > Hi Tommaso,
> > > > > 
> > > > > Thank you for the patch.
> > > > > 
> > > > > Use the imperative in the subject line:
> > > > > 
> > > > > media: i2c: alvium: Remove the fr field of the alvium_dev structure
> > > > > 
> > > > > On Wed, Dec 20, 2023 at 09:56:07AM +0100, Tommaso Merciai wrote:
> > > > > > The fr (frame rate) field of the alvium_dev structure is
> > > > > > only used to pass result from alvium_set_frame_interval() to
> > > > > > alvium_set_frame_rate() that writes this info into the hw reg.
> > > > > > Replace them with function parameter.
> > > > > 
> > > > > Replace it with a function parameter.
> > > > 
> > > > Thanks I'll fix this in v3.
> > > > 
> > > > > > 
> > > > > > Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> > > > > > ---
> > > > > >  drivers/media/i2c/alvium-csi2.c | 24 ++++++++++++------------
> > > > > >  drivers/media/i2c/alvium-csi2.h |  1 -
> > > > > >  2 files changed, 12 insertions(+), 13 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/media/i2c/alvium-csi2.c b/drivers/media/i2c/alvium-csi2.c
> > > > > > index 0dcd69bf9f92..a9ff6cc97cff 100644
> > > > > > --- a/drivers/media/i2c/alvium-csi2.c
> > > > > > +++ b/drivers/media/i2c/alvium-csi2.c
> > > > > > @@ -1185,19 +1185,19 @@ static int alvium_get_frame_interval(struct alvium_dev *alvium,
> > > > > >  	return ret;
> > > > > >  }
> > > > > >  
> > > > > > -static int alvium_set_frame_rate(struct alvium_dev *alvium)
> > > > > > +static int alvium_set_frame_rate(struct alvium_dev *alvium, u64 fr)
> > > > > >  {
> > > > > >  	struct device *dev = &alvium->i2c_client->dev;
> > > > > >  	int ret;
> > > > > >  
> > > > > >  	ret = alvium_write_hshake(alvium, REG_BCRM_ACQUISITION_FRAME_RATE_RW,
> > > > > > -				  alvium->fr);
> > > > > > +				  fr);
> > > > > >  	if (ret) {
> > > > > >  		dev_err(dev, "Fail to set frame rate lanes reg\n");
> > > > > >  		return ret;
> > > > > >  	}
> > > > > >  
> > > > > > -	dev_dbg(dev, "set frame rate: %llu us\n", alvium->fr);
> > > > > > +	dev_dbg(dev, "set frame rate: %llu us\n", fr);
> > > > > >  
> > > > > >  	return 0;
> > > > > >  }
> > > > > > @@ -1661,10 +1661,11 @@ static int alvium_g_frame_interval(struct v4l2_subdev *sd,
> > > > > >  }
> > > > > >  
> > > > > >  static int alvium_set_frame_interval(struct alvium_dev *alvium,
> > > > > > -				     struct v4l2_subdev_frame_interval *fi)
> > > > > > +				     struct v4l2_subdev_frame_interval *fi,
> > > > > > +				     u64 *req_fr)
> > > > > >  {
> > > > > >  	struct device *dev = &alvium->i2c_client->dev;
> > > > > > -	u64 req_fr, dft_fr, min_fr, max_fr;
> > > > > > +	u64 dft_fr, min_fr, max_fr;
> > > > > >  	int ret;
> > > > > >  
> > > > > >  	if (fi->interval.denominator == 0)
> > > > > > @@ -1681,13 +1682,12 @@ static int alvium_set_frame_interval(struct alvium_dev *alvium,
> > > > > >  	dev_dbg(dev, "fi->interval.denominator = %d\n",
> > > > > >  		fi->interval.denominator);
> > > > > >  
> > > > > > -	req_fr = (u64)((fi->interval.denominator * USEC_PER_SEC) /
> > > > > > +	*req_fr = (u64)((fi->interval.denominator * USEC_PER_SEC) /
> > > > > >  		       fi->interval.numerator);
> > > > > >  
> > > > > > -	if (req_fr >= max_fr && req_fr <= min_fr)
> > > > > > -		req_fr = dft_fr;
> > > > > > +	if (*req_fr >= max_fr && *req_fr <= min_fr)
> > > > > > +		*req_fr = dft_fr;
> > > > > 
> > > > > Shouldn't we clamp the value to [min, max] instead of using the default
> > > > > if it's out of range ? Something like
> > > > > 
> > > > > 	*req_fr = clamp(*req_fr, min_fr, max_fr)
> > > > > 
> > > > > This makes me realize that the current code is wrong, req_fr can't be >=
> > > > > max and <= min at the same time. You probably meant || instead of &&.
> > > > > 
> > > > > This should be fixed in a separate patch.
> > > > 
> > > > If this is ok for you, after this series I can put a patch with || fix
> > > > instead of clamping, because if we clamp dft_fr is not used any more.
> > > > After if you agree I will work on clamping.
> > > > Thanks for the catch! :)
> > > 
> > > It's fine to fix this on top of the series, but I don't see why you
> > > would need to first use ||. You can call clamp() and remove dft_fr.
> > 
> > I'm just thinking out loud eh :)
> > 
> > Maybe in the future we need to expose fr infos to the user to play with
> > that. But we are writing for now, then we can replan to readd dft_fr
> > read later.
> > 
> > I think this is what your are suggesting:
> > 
> > +++ b/drivers/media/i2c/alvium-csi2.c
> > @@ -1171,12 +1171,10 @@ static int alvium_set_bayer_pattern(struct alvium_dev *alvium,
> >  }
> > 
> >  static int alvium_get_frame_interval(struct alvium_dev *alvium,
> > -                                    u64 *dft_fr, u64 *min_fr, u64 *max_fr)
> > +                                    u64 *min_fr, u64 *max_fr)
> >  {
> >         int ret = 0;
> > 
> > -       alvium_read(alvium, REG_BCRM_ACQUISITION_FRAME_RATE_RW,
> > -                   dft_fr, &ret);
> >         alvium_read(alvium, REG_BCRM_ACQUISITION_FRAME_RATE_MIN_R,
> >                     min_fr, &ret);
> >         alvium_read(alvium, REG_BCRM_ACQUISITION_FRAME_RATE_MAX_R,
> > @@ -1647,7 +1645,7 @@ static int alvium_s_frame_interval(struct v4l2_subdev *sd,
> >  {
> >         struct alvium_dev *alvium = sd_to_alvium(sd);
> >         struct device *dev = &alvium->i2c_client->dev;
> > -       u64 req_fr, dft_fr, min_fr, max_fr;
> > +       u64 req_fr, min_fr, max_fr;
> >         struct v4l2_fract *interval;
> >         int ret;
> > 
> > @@ -1657,7 +1655,7 @@ static int alvium_s_frame_interval(struct v4l2_subdev *sd,
> >         if (fi->interval.denominator == 0)
> >                 return -EINVAL;
> > 
> > -       ret = alvium_get_frame_interval(alvium, &dft_fr, &min_fr, &max_fr);
> > +       ret = alvium_get_frame_interval(alvium, &min_fr, &max_fr);
> >         if (ret) {
> >                 dev_err(dev, "Fail to get frame interval\n");
> >                 return ret;
> > @@ -1670,9 +1668,7 @@ static int alvium_s_frame_interval(struct v4l2_subdev *sd,
> > 
> >         req_fr = (u64)((fi->interval.denominator * USEC_PER_SEC) /
> >                        fi->interval.numerator);
> > -
> > -       if (req_fr >= max_fr && req_fr <= min_fr)
> > -               req_fr = dft_fr;
> > +       req_fr = clamp(req_fr, min_fr, max_fr);
> > 
> >         interval = v4l2_subdev_state_get_interval(sd_state, 0);
> > 
> > right?
> 
> Yes this looks good to me.

Just an info.
Can I proceed to send v3 of this series and then the fix or better to
wait?

Thanks,
Tommaso


> 
> > > > > >  
> > > > > > -	alvium->fr = req_fr;
> > > > > >  	alvium->frame_interval.numerator = fi->interval.numerator;
> > > > > >  	alvium->frame_interval.denominator = fi->interval.denominator;
> > > > > >  
> > > > > > @@ -1699,6 +1699,7 @@ static int alvium_s_frame_interval(struct v4l2_subdev *sd,
> > > > > >  				   struct v4l2_subdev_frame_interval *fi)
> > > > > >  {
> > > > > >  	struct alvium_dev *alvium = sd_to_alvium(sd);
> > > > > > +	u64 req_fr = ALVIUM_DEFAULT_FR_HZ;
> > > > > 
> > > > > Do you need to initialize the variable ? It doesn't seem to be required.
> > > > 
> > > > Really not, it's just to maintain the logic of alvium->fr. I will drop
> > > > this in v3, thanks!
> > > > 
> > > > > With these small issues fixed,
> > > > > 
> > > > > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > > > 
> > > > > >  	int ret;
> > > > > >  
> > > > > >  	/*
> > > > > > @@ -1711,9 +1712,9 @@ static int alvium_s_frame_interval(struct v4l2_subdev *sd,
> > > > > >  	if (alvium->streaming)
> > > > > >  		return -EBUSY;
> > > > > >  
> > > > > > -	ret = alvium_set_frame_interval(alvium, fi);
> > > > > > +	ret = alvium_set_frame_interval(alvium, fi, &req_fr);
> > > > > >  	if (!ret)
> > > > > > -		ret = alvium_set_frame_rate(alvium);
> > > > > > +		ret = alvium_set_frame_rate(alvium, req_fr);
> > > > > >  
> > > > > >  	return ret;
> > > > > >  }
> > > > > > @@ -2273,7 +2274,6 @@ static int alvium_subdev_init(struct alvium_dev *alvium)
> > > > > >  	/* Setup initial frame interval*/
> > > > > >  	alvium->frame_interval.numerator = 1;
> > > > > >  	alvium->frame_interval.denominator = ALVIUM_DEFAULT_FR_HZ;
> > > > > > -	alvium->fr = ALVIUM_DEFAULT_FR_HZ;
> > > > > >  
> > > > > >  	/* Setup the initial mode */
> > > > > >  	alvium->mode.fmt = alvium_csi2_default_fmt;
> > > > > > diff --git a/drivers/media/i2c/alvium-csi2.h b/drivers/media/i2c/alvium-csi2.h
> > > > > > index 17f0bbbd1839..80066ac25047 100644
> > > > > > --- a/drivers/media/i2c/alvium-csi2.h
> > > > > > +++ b/drivers/media/i2c/alvium-csi2.h
> > > > > > @@ -443,7 +443,6 @@ struct alvium_dev {
> > > > > >  
> > > > > >  	struct alvium_mode mode;
> > > > > >  	struct v4l2_fract frame_interval;
> > > > > > -	u64 fr;
> > > > > >  
> > > > > >  	u8 h_sup_csi_lanes;
> > > > > >  	u64 link_freq;
> 
> -- 
> Regards,
> 
> Laurent Pinchart

