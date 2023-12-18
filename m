Return-Path: <linux-kernel+bounces-3465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0D6816CB8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93BA6B22BD1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D434B1BDE7;
	Mon, 18 Dec 2023 11:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0Rzc4w+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECDE1BDDD;
	Mon, 18 Dec 2023 11:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a233354c74aso261657766b.1;
        Mon, 18 Dec 2023 03:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702899595; x=1703504395; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zcH0UIlZ9wGt+bB5pfsqVhB/iCTXynYZe0CCzCtVeWE=;
        b=K0Rzc4w++NvpR2SUDCasEZRgttaV2KCnGlZoRN8Js0cuyoDlLaoF8lCcm7lVJL/NIR
         p1UaewW6NyOrGkqJlufSP/xqubZk3obkxLq1sYoJFq2MZ7i1Pa6FWJSr8Y5Em2kU+9bh
         0tK6WRqVnl48uPS9meve+8MuSiHL0vWJv586Fsi+9GjeUyQWbfgSXLRkKSDZKLhp9Qhf
         hRHq7uBh/m+Y6N7Ld2dd5hA5vS608UN5aHlTDaVJhk/abWelkDLJDrSX0n4ZbMXEAG8/
         iJMElI919qyG6udNDkphRIOV+JjA78kDNJm/+M7CQYBcQs8VR2sTa3PuoCNIZrFR9Csa
         ybOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702899595; x=1703504395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zcH0UIlZ9wGt+bB5pfsqVhB/iCTXynYZe0CCzCtVeWE=;
        b=uIAhfTwjDq5shCy8jGgVaJN/swcWl+MqdnzTlvcQpO68WQG4vRyk3Q7xn9o0ngoVky
         kZ/zWHzEMUGkRCTC9PG9TWjW89oCjjZ495P15bhTaZA2q+AfV3KI38EZnlwfguhzaJDF
         rd43q3yiMQQRBETErmr+VjzdimkTqV2SqJjG1RUVJ0B82MsvB8j9pcJ5YJnEvOVxp09f
         +JMWB0ot32otbiWKZyO+Yh7VlqiFdLwyu+KTalRa0cmnI7gAadEwz8MZe//OK7fZepQa
         bXKsGuZH0o5XuWe6GZYA6gGOFn0Jd0+UtD0FgAuTTGg4InYl/ObLpjXVq4xShDYHXxt2
         hhdw==
X-Gm-Message-State: AOJu0Yx8987uo7WVUQEkN7eEkzucdTu6Y/ecyShbWDoUff5TNtsJ8HPq
	CWU6+HHzuO2VRqQnaiIntuQ=
X-Google-Smtp-Source: AGHT+IE7U9fV+RiDZTTEgZ9X1IIYI4BfahVLE+bQJjBadXhpoz8iEknnmreo+OAtK84Axb16JbXDGg==
X-Received: by 2002:a17:906:af04:b0:a22:e827:fb7b with SMTP id lx4-20020a170906af0400b00a22e827fb7bmr10693418ejb.23.1702899595444;
        Mon, 18 Dec 2023 03:39:55 -0800 (PST)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation (net-188-217-59-229.cust.vodafonedsl.it. [188.217.59.229])
        by smtp.gmail.com with ESMTPSA id vs6-20020a170907a58600b00a1fa6a70b8dsm10410753ejc.133.2023.12.18.03.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 03:39:55 -0800 (PST)
Date: Mon, 18 Dec 2023 12:39:53 +0100
From: Tommaso Merciai <tomm.merciai@gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linuxfancy@googlegroups.com, sakari.ailus@linux.intel.com,
	Martin Hecht <martin.hecht@avnet.eu>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] media: i2c: alvium: store frame interval in subdev
 state
Message-ID: <ZYAvifztnTGoQB51@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
References: <20231215082452.1720481-1-tomm.merciai@gmail.com>
 <20231215082452.1720481-4-tomm.merciai@gmail.com>
 <20231218025905.GJ5290@pendragon.ideasonboard.com>
 <ZYAfThT/mHdzGdAh@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
 <20231218110331.GQ5290@pendragon.ideasonboard.com>
 <ZYAqyOEfKp/oiqs9@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
 <20231218113618.GA21105@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218113618.GA21105@pendragon.ideasonboard.com>

On Mon, Dec 18, 2023 at 01:36:18PM +0200, Laurent Pinchart wrote:
> On Mon, Dec 18, 2023 at 12:19:36PM +0100, Tommaso Merciai wrote:
> > On Mon, Dec 18, 2023 at 01:03:31PM +0200, Laurent Pinchart wrote:
> > > On Mon, Dec 18, 2023 at 11:30:38AM +0100, Tommaso Merciai wrote:
> > > > On Mon, Dec 18, 2023 at 04:59:05AM +0200, Laurent Pinchart wrote:
> > > > > On Fri, Dec 15, 2023 at 09:24:52AM +0100, Tommaso Merciai wrote:
> > > > > > Use the newly added storage for frame interval in the subdev state to
> > > > > > simplify the driver.
> > > > > > 
> > > > > > Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> > > > > > ---
> > > > > >  drivers/media/i2c/alvium-csi2.c | 40 ++++++++++-----------------------
> > > > > >  drivers/media/i2c/alvium-csi2.h |  2 --
> > > > > >  2 files changed, 12 insertions(+), 30 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/media/i2c/alvium-csi2.c b/drivers/media/i2c/alvium-csi2.c
> > > > > > index fde456357be1..81f683b3c849 100644
> > > > > > --- a/drivers/media/i2c/alvium-csi2.c
> > > > > > +++ b/drivers/media/i2c/alvium-csi2.c
> > > > > > @@ -1643,25 +1643,6 @@ static int alvium_hw_init(struct alvium_dev *alvium)
> > > > > >  }
> > > > > >  
> > > > > >  /* --------------- Subdev Operations --------------- */
> > > > > > -
> > > > > > -static int alvium_g_frame_interval(struct v4l2_subdev *sd,
> > > > > > -				   struct v4l2_subdev_state *sd_state,
> > > > > > -				   struct v4l2_subdev_frame_interval *fi)
> > > > > > -{
> > > > > > -	struct alvium_dev *alvium = sd_to_alvium(sd);
> > > > > > -
> > > > > > -	/*
> > > > > > -	 * FIXME: Implement support for V4L2_SUBDEV_FORMAT_TRY, using the V4L2
> > > > > > -	 * subdev active state API.
> > > > > > -	 */
> > > > > > -	if (fi->which != V4L2_SUBDEV_FORMAT_ACTIVE)
> > > > > > -		return -EINVAL;
> > > > > > -
> > > > > > -	fi->interval = alvium->frame_interval;
> > > > > > -
> > > > > > -	return 0;
> > > > > > -}
> > > > > > -
> > > > > >  static int alvium_s_frame_interval(struct v4l2_subdev *sd,
> > > > > >  				   struct v4l2_subdev_state *sd_state,
> > > > > >  				   struct v4l2_subdev_frame_interval *fi)
> > > > > > @@ -1669,6 +1650,7 @@ static int alvium_s_frame_interval(struct v4l2_subdev *sd,
> > > > > >  	struct alvium_dev *alvium = sd_to_alvium(sd);
> > > > > >  	struct device *dev = &alvium->i2c_client->dev;
> > > > > >  	u64 req_fr, dft_fr, min_fr, max_fr;
> > > > > > +	struct v4l2_fract *interval;
> > > > > >  	int ret;
> > > > > >  
> > > > > >  	/*
> > > > > 
> > > > > You should drop the FIXME comment here and the ACTIVE check...
> > > > 
> > > > Oks, thanks.
> > > > 
> > > > > 
> > > > > > @@ -1701,9 +1683,10 @@ static int alvium_s_frame_interval(struct v4l2_subdev *sd,
> > > > > >  	if (req_fr >= max_fr && req_fr <= min_fr)
> > > > > >  		req_fr = dft_fr;
> > > > > >  
> > > > > > -	alvium->fr = req_fr;
> > > > > > -	alvium->frame_interval.numerator = fi->interval.numerator;
> > > > > > -	alvium->frame_interval.denominator = fi->interval.denominator;
> > > > > > +	interval = v4l2_subdev_state_get_interval(sd_state, 0);
> > > > > > +
> > > > > > +	interval->numerator = fi->interval.numerator;
> > > > > > +	interval->denominator = fi->interval.denominator;
> > > > > >  
> > > > > 
> > > > > ... and here only call alvium_set_frame_rate() for the ACTIVE frame
> > > > > interval.
> > > > 
> > > > I don't completely got this comment, can you give me more details about
> > > > please. Thanks in advance!
> > > 
> > > alvium_s_frame_interval() can be called both for the TRY and ACTIVE
> > > status. The hardware registers should be written only for the ACTIVE
> > > state.
> > 
> > Do you think could be sufficient an if check like this?
> > 
> > -	return alvium_set_frame_rate(alvium, req_fr);
> > +	if (fi->which == V4L2_SUBDEV_FORMAT_ACTIVE)
> > +		return alvium_set_frame_rate(alvium, req_fr);
> > +
> > +	return ret;
> 
> That's the idea, yes. The "return ret" can become "return 0". Or you
> could write
> 
> 	if (fi->which != V4L2_SUBDEV_FORMAT_ACTIVE)
> 		return 0;
> 
> 	return alvium_set_frame_rate(alvium, req_fr);
> 
> >  }

(This is my personal idea eh :) )

Maybe better:

	if (fi->which == V4L2_SUBDEV_FORMAT_ACTIVE)
		ret = alvium_set_frame_rate(alvium, req_fr);

	return ret;

What do you think?

Regards,
Tommaso

> > 
> > > > > > @@ -1853,6 +1836,7 @@ static int alvium_init_state(struct v4l2_subdev *sd,
> > > > > >  {
> > > > > >  	struct alvium_dev *alvium = sd_to_alvium(sd);
> > > > > >  	struct alvium_mode *mode = &alvium->mode;
> > > > > > +	struct v4l2_fract *interval;
> > > > > >  	struct v4l2_subdev_format sd_fmt = {
> > > > > >  		.which = V4L2_SUBDEV_FORMAT_TRY,
> > > > > >  		.format = alvium_csi2_default_fmt,
> > > > > > @@ -1870,6 +1854,11 @@ static int alvium_init_state(struct v4l2_subdev *sd,
> > > > > >  	*v4l2_subdev_state_get_crop(state, 0) = sd_crop.rect;
> > > > > >  	*v4l2_subdev_state_get_format(state, 0) = sd_fmt.format;
> > > > > >  
> > > > > > +	/* Setup initial frame interval*/
> > > > > > +	interval = v4l2_subdev_state_get_interval(state, 0);
> > > > > > +	interval->numerator = 1;
> > > > > > +	interval->denominator = ALVIUM_DEFAULT_FR_HZ;
> > > > > > +
> > > > > >  	return 0;
> > > > > >  }
> > > > > >  
> > > > > > @@ -2239,7 +2228,7 @@ static const struct v4l2_subdev_pad_ops alvium_pad_ops = {
> > > > > >  	.set_fmt = alvium_set_fmt,
> > > > > >  	.get_selection = alvium_get_selection,
> > > > > >  	.set_selection = alvium_set_selection,
> > > > > > -	.get_frame_interval = alvium_g_frame_interval,
> > > > > > +	.get_frame_interval = v4l2_subdev_get_frame_interval,
> > > > > >  	.set_frame_interval = alvium_s_frame_interval,
> > > > > >  };
> > > > > >  
> > > > > > @@ -2260,11 +2249,6 @@ static int alvium_subdev_init(struct alvium_dev *alvium)
> > > > > >  	struct v4l2_subdev *sd = &alvium->sd;
> > > > > >  	int ret;
> > > > > >  
> > > > > > -	/* Setup initial frame interval*/
> > > > > > -	alvium->frame_interval.numerator = 1;
> > > > > > -	alvium->frame_interval.denominator = ALVIUM_DEFAULT_FR_HZ;
> > > > > > -	alvium->fr = ALVIUM_DEFAULT_FR_HZ;
> > > > > > -
> > > > > >  	/* Setup the initial mode */
> > > > > >  	alvium->mode.fmt = alvium_csi2_default_fmt;
> > > > > >  	alvium->mode.width = alvium_csi2_default_fmt.width;
> > > > > > diff --git a/drivers/media/i2c/alvium-csi2.h b/drivers/media/i2c/alvium-csi2.h
> > > > > > index a6529b28e7dd..f5e26257b042 100644
> > > > > > --- a/drivers/media/i2c/alvium-csi2.h
> > > > > > +++ b/drivers/media/i2c/alvium-csi2.h
> > > > > > @@ -442,8 +442,6 @@ struct alvium_dev {
> > > > > >  	s32 inc_sharp;
> > > > > >  
> > > > > >  	struct alvium_mode mode;
> > > > > > -	struct v4l2_fract frame_interval;
> > > > > > -	u64 fr;
> > > > > 
> > > > > The fr field should have been removed by a previous patch (the one that
> > > > > will go between 1/3 an 2/3, see my review of 1/3) as shown by the fact
> > > > > that this patch only removes two locations where the field is set but
> > > > > none where it's read.
> > > > > 
> > > > > >  
> > > > > >  	u8 h_sup_csi_lanes;
> > > > > >  	u64 link_freq;
> 
> -- 
> Regards,
> 
> Laurent Pinchart

