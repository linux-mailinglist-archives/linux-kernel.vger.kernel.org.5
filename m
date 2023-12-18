Return-Path: <linux-kernel+bounces-3329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86AEB816B10
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E2BD2833B3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2B614A99;
	Mon, 18 Dec 2023 10:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9oxPUn+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE178182A4;
	Mon, 18 Dec 2023 10:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-54bf9a54fe3so3440933a12.3;
        Mon, 18 Dec 2023 02:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702895221; x=1703500021; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8sRNZCx3Fepkk/1p+2V5Nj6L+xJzRr/Wtz906o7085o=;
        b=d9oxPUn+h5PSx98ZZoHK0ilk5f/jw4fsEJpa8bX2FfnTx2KT12sEfz8kZcbO4zjwyc
         Ouwcc3WMY2bs3OLBXVKLnlTe8Tnjoo125JOLi1ImlbYKaMJEPgjd137awuBgdFPRGPjb
         XQ19weST/GJwE5sS0s7sfuyObGwyfMSJWqyDGFVXMSveDlzu2UgPmRzEhYc3za1mhAzn
         I6pgOr5Yvmk2st6OIw6UHyDIdOiYWnb4KfcNY7Nkgb+jVuWp9t8qube5veILi6NZ174A
         ahC3FJIBQH8h3TkBlJ9vemCCMkgIZAZpMxl5e6g8GG0dfPGQA23u9oiw+gMAKmIC5qPA
         6mNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702895221; x=1703500021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8sRNZCx3Fepkk/1p+2V5Nj6L+xJzRr/Wtz906o7085o=;
        b=R9IM8wxjXJSeCmnfsgH87FhlZD14GCJ+za7Oce93G4SyoiJw1zNEQXfWes3UPBEfeA
         qcx+8Tv+ppS87KO22D85mwK0a5Eko0lvr1SBr1GOOJ6KwEhA+dZYEj5WhINbpTnQwVb2
         WPT3h5hnQH/xYoDv++S9WWSRbUhkBcTZmyz86TZdFfGFtBTwbrMajYKx+3DiJERgQ9KV
         YLLE93zhYxjB2uXZTPMXcrre7O9GwHkd+3GoYfTPmuAVvS1st+RdAdvZ9fn+8y/Fivte
         /rT51ZuZiARFqZWLIBXl3NbbxA2D7tqlMsdgU7pPzkioYU2R5E2c7rSgatStAM0uXYMX
         6UZw==
X-Gm-Message-State: AOJu0YwIvfPHlsYB78EdJf78JVdAROMG2bfIPqJNemBA2qkKqLciDUJI
	C2SbDtYKebb+EGTznJg/Hy0=
X-Google-Smtp-Source: AGHT+IEkTx7EHKlSteq88pnqILHeDAl6HejLs+ZNVsHSL1QYZBen2E4N7XQ0FVKejjE+xHT0D/tiUA==
X-Received: by 2002:a50:c34c:0:b0:553:74b4:5ad5 with SMTP id q12-20020a50c34c000000b0055374b45ad5mr169126edb.31.1702895220922;
        Mon, 18 Dec 2023 02:27:00 -0800 (PST)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation (net-188-217-59-229.cust.vodafonedsl.it. [188.217.59.229])
        by smtp.gmail.com with ESMTPSA id ef13-20020a05640228cd00b00552d45bd8e7sm3023687edb.77.2023.12.18.02.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 02:27:00 -0800 (PST)
Date: Mon, 18 Dec 2023 11:26:58 +0100
From: Tommaso Merciai <tomm.merciai@gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linuxfancy@googlegroups.com, sakari.ailus@linux.intel.com,
	Martin Hecht <martin.hecht@avnet.eu>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] media: i2c: alvium: removal of dft_fr, min_fr and
 max_fr
Message-ID: <ZYAecvgGSZ99GlHk@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
References: <20231215082452.1720481-1-tomm.merciai@gmail.com>
 <20231215082452.1720481-2-tomm.merciai@gmail.com>
 <20231218025044.GH5290@pendragon.ideasonboard.com>
 <20231218025430.GA9012@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218025430.GA9012@pendragon.ideasonboard.com>

Hi Laurent,
Thanks for your review.

On Mon, Dec 18, 2023 at 04:54:30AM +0200, Laurent Pinchart wrote:
> On Mon, Dec 18, 2023 at 04:50:46AM +0200, Laurent Pinchart wrote:
> > Hi Tommaso,
> > 
> > Thank you for the patch.
> > 
> > On Fri, Dec 15, 2023 at 09:24:50AM +0100, Tommaso Merciai wrote:
> > > Remove driver private data dft_fr, min_fr and max_fr.
> > > Those are used only in alvium_set_frame_interval function.
> > > Use local ones instead.
> > 
> > The fields are used to pass data from alvium_get_frame_interval() to its
> > caller, not just in alvium_get_frame_interval(). You can write
> > 
> > The dft_fr, min_fr and max_fr fields of the alvium_dev structure are
> > only used to pass results from alvium_get_frame_interval() to its
> > caller. Replace them with function parameters.

Thanks for the hint.

> > 
> > > Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> > > ---
> > >  drivers/media/i2c/alvium-csi2.c | 45 +++++++++++++++------------------
> > >  drivers/media/i2c/alvium-csi2.h |  3 ---
> > >  2 files changed, 21 insertions(+), 27 deletions(-)
> > > 
> > > diff --git a/drivers/media/i2c/alvium-csi2.c b/drivers/media/i2c/alvium-csi2.c
> > > index 34ff7fad3877..c4b7851045a1 100644
> > > --- a/drivers/media/i2c/alvium-csi2.c
> > > +++ b/drivers/media/i2c/alvium-csi2.c
> > > @@ -1170,40 +1170,36 @@ static int alvium_set_bayer_pattern(struct alvium_dev *alvium,
> > >  	return 0;
> > >  }
> > >  
> > > -static int alvium_get_frame_interval(struct alvium_dev *alvium)
> > > +static int alvium_get_frame_interval(struct alvium_dev *alvium,
> > > +				     u64 *dft_fr, u64 *min_fr, u64 *max_fr)
> > >  {
> > > -	u64 dft_fr, min_fr, max_fr;
> > >  	int ret = 0;
> > >  
> > >  	alvium_read(alvium, REG_BCRM_ACQUISITION_FRAME_RATE_RW,
> > > -		    &dft_fr, &ret);
> > > +		    dft_fr, &ret);
> > >  	alvium_read(alvium, REG_BCRM_ACQUISITION_FRAME_RATE_MIN_R,
> > > -		    &min_fr, &ret);
> > > +		    min_fr, &ret);
> > >  	alvium_read(alvium, REG_BCRM_ACQUISITION_FRAME_RATE_MAX_R,
> > > -		    &max_fr, &ret);
> > > +		    max_fr, &ret);
> > >  	if (ret)
> > >  		return ret;
> > 
> > You can just
> > 
> > 	return ret;

I'll do this in v2, thanks.

> > 
> > >  
> > > -	alvium->dft_fr = dft_fr;
> > > -	alvium->min_fr = min_fr;
> > > -	alvium->max_fr = max_fr;
> > > -
> > >  	return 0;
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
> > 
> > This is unrelated to the commit message. Please split handling of the fr
> > field to a separate patch. One change, one patch.

Right..

> > 
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
> > > @@ -1667,36 +1663,36 @@ static int alvium_g_frame_interval(struct v4l2_subdev *sd,
> > >  }
> > >  
> > >  static int alvium_set_frame_interval(struct alvium_dev *alvium,
> > > -				     struct v4l2_subdev_frame_interval *fi)
> > > +				     struct v4l2_subdev *sd,
> > > +				     struct v4l2_subdev_state *sd_state,
> 
> This is also unrelated to this patch.
> 
> > > +				     struct v4l2_subdev_frame_interval *fi,
> > > +				     u64 *req_fr)
> > >  {
> > >  	struct device *dev = &alvium->i2c_client->dev;
> > > -	u64 req_fr, min_fr, max_fr;
> > > +	u64 dft_fr, min_fr, max_fr;
> > >  	int ret;
> > >  
> > >  	if (fi->interval.denominator == 0)
> > >  		return -EINVAL;
> > >  
> > > -	ret = alvium_get_frame_interval(alvium);
> > > +	ret = alvium_get_frame_interval(alvium, &dft_fr, &min_fr, &max_fr);
> > >  	if (ret) {
> > >  		dev_err(dev, "Fail to get frame interval\n");
> > >  		return ret;
> > >  	}
> > >  
> > > -	min_fr = alvium->min_fr;
> > > -	max_fr = alvium->max_fr;
> > > -
> > >  	dev_dbg(dev, "fi->interval.numerator = %d\n",
> > >  		fi->interval.numerator);
> > >  	dev_dbg(dev, "fi->interval.denominator = %d\n",
> > >  		fi->interval.denominator);
> > >  
> > > -	req_fr = (u64)((fi->interval.denominator * USEC_PER_SEC) /
> > > +	*req_fr = (u64)((fi->interval.denominator * USEC_PER_SEC) /
> > >  		       fi->interval.numerator);
> > >  
> > > -	if (req_fr >= max_fr && req_fr <= min_fr)
> > > -		req_fr = alvium->dft_fr;
> > > +	if (*req_fr >= max_fr && *req_fr <= min_fr)
> > > +		*req_fr = dft_fr;
> > >  
> > > -	alvium->fr = req_fr;
> > > +	alvium->fr = *req_fr;
> > >  	alvium->frame_interval.numerator = fi->interval.numerator;
> > >  	alvium->frame_interval.denominator = fi->interval.denominator;
> > >  
> > > @@ -1708,6 +1704,7 @@ static int alvium_s_frame_interval(struct v4l2_subdev *sd,
> > >  				   struct v4l2_subdev_frame_interval *fi)
> > >  {
> > >  	struct alvium_dev *alvium = sd_to_alvium(sd);
> > > +	u64 req_fr;
> > >  	int ret;
> > >  
> > >  	/*
> > > @@ -1720,9 +1717,9 @@ static int alvium_s_frame_interval(struct v4l2_subdev *sd,
> > >  	if (alvium->streaming)
> > >  		return -EBUSY;
> > >  
> > > -	ret = alvium_set_frame_interval(alvium, fi);
> > > +	ret = alvium_set_frame_interval(alvium, sd, sd_state, fi, &req_fr);
> > >  	if (!ret)
> > > -		ret = alvium_set_frame_rate(alvium);
> > > +		ret = alvium_set_frame_rate(alvium, req_fr);
> > >  
> > >  	return ret;
> > >  }
> > > diff --git a/drivers/media/i2c/alvium-csi2.h b/drivers/media/i2c/alvium-csi2.h
> > > index 8b554bffdc39..a6529b28e7dd 100644
> > > --- a/drivers/media/i2c/alvium-csi2.h
> > > +++ b/drivers/media/i2c/alvium-csi2.h
> > > @@ -443,9 +443,6 @@ struct alvium_dev {
> > >  
> > >  	struct alvium_mode mode;
> > >  	struct v4l2_fract frame_interval;
> > > -	u64 dft_fr;
> > > -	u64 min_fr;
> > > -	u64 max_fr;
> > >  	u64 fr;
> > >  
> > >  	u8 h_sup_csi_lanes;

Plan for v2 is splitting this series
into another patch as you suggest:

media: i2c: alvium: removal of dft_fr, min_fr and max_fr
+ media: i2c: alvium: removal of fr field
media: i2c: alvium: store frame interval in subdev state
media: i2c: alvium: inline set_frame_interval into s_frame_interval

Thanks & Regards,
Tommaso


> 
> -- 
> Regards,
> 
> Laurent Pinchart

