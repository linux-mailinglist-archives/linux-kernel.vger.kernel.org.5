Return-Path: <linux-kernel+bounces-6693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64ED0819C28
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2510B28884A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D60D210EA;
	Wed, 20 Dec 2023 10:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQLC9OH+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B90C37168;
	Wed, 20 Dec 2023 10:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a234938c7f3so420645166b.2;
        Wed, 20 Dec 2023 02:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703066666; x=1703671466; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xo74soNljverk8yFjfcngHp54jiGSyRdl/CMYKZLSI8=;
        b=aQLC9OH+rmRK3yvB90n18Lo3q5J1EDZCWEcclbtchgEHqJLdZPv8l/8YCESNIhLs26
         kCnmfalR0o8LaCbp5XmcpJ1uATRjFgTtyDAKjfYH0xZPjopsY7A2950zdIvQ7t8rjrx+
         eKQqjWmlD5BdQb3iyAEkY+GRQJ+6a4tlfnW/Y/+v7r8U52VD210D5xjg3zIjbmEdBLdF
         RFFcJ4/+yEZr4vDmqdNdu9F5TJkMiROse1kqizVq+vYdv4iFzqvTJ7wQ7XnVINmmUt3e
         0nMH1WLQJ432frMyNLhAVZaMkYfdqfMNI3Wu0c4MwUkdt3anGyBQIt0q3E1CgLgvBA6b
         Qg1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703066666; x=1703671466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xo74soNljverk8yFjfcngHp54jiGSyRdl/CMYKZLSI8=;
        b=wImb69MGnokPNFnTYHA+Vokx3wpLwWiJ4VRfIDWeO2lqbAGBBll5ZU/qwkn1jQhSCo
         ZteVSyUYS2oFvyuDbaf4f4iIsZAepenEs8CcGJy1TlD3vZ0OR6LiGSGh6XkNrHU8WcEW
         I+1lZVgbgEXIuxbNUprNwD2d9eVoquHKY0bjnlOc8og9d+xHT3hcbRRgnH87J8OLOQ3g
         HyusORSchqhllZw9yr0m48+/H72mkKLFjrLYaaeuuFfqoeB+BgLhdxJ+Gl6G2Z083NyG
         QaYU/KRkJtJKvnrDU1kg7aEAXBpbjHj27noz9/ggXJmDl/O3q0D/oCQ0oEmikv8L4Ee8
         Gx1Q==
X-Gm-Message-State: AOJu0YyXE+rKKudkGCy+1hlx3wcOmk/hKD9S90lZzAN6rNHENKaJjIVR
	lOtDPLGgjqkJs4+PLhT3F3Y=
X-Google-Smtp-Source: AGHT+IGp97+TDVdFU4Qtm6hQG4zmUJjYn5JikcWIlc9ztFcaY2M0fuGNgAmeK59IbJwRVfq7eEJnWg==
X-Received: by 2002:a17:906:b74c:b0:a23:6276:b196 with SMTP id fx12-20020a170906b74c00b00a236276b196mr1900677ejb.63.1703066665629;
        Wed, 20 Dec 2023 02:04:25 -0800 (PST)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation (net-188-217-59-229.cust.vodafonedsl.it. [188.217.59.229])
        by smtp.gmail.com with ESMTPSA id n11-20020a17090673cb00b00a268b2ed7a9sm881590ejl.184.2023.12.20.02.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 02:04:25 -0800 (PST)
Date: Wed, 20 Dec 2023 11:04:23 +0100
From: Tommaso Merciai <tomm.merciai@gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linuxfancy@googlegroups.com, martin.hecht@avnet.eu,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] media: i2c: alvium: inline set_frame_interval
 into s_frame_interval
Message-ID: <ZYK8J9ahkngbI5py@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
References: <20231220085609.2595732-1-tomm.merciai@gmail.com>
 <20231220085609.2595732-4-tomm.merciai@gmail.com>
 <20231220091413.GH29638@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220091413.GH29638@pendragon.ideasonboard.com>

Hi Laurent,
Thanks for your review.

On Wed, Dec 20, 2023 at 11:14:13AM +0200, Laurent Pinchart wrote:
> Hi Tommaso,
> 
> Thank you for the patch.
> 
> On Wed, Dec 20, 2023 at 09:56:08AM +0100, Tommaso Merciai wrote:
> > Inline alvium_set_frame_interval() into alvium_s_frame_interval().
> > The alvium_set_frame_interval() is called once only, by
> > alvium_s_frame_interval(). The latter is a thin wrapper around the
> > former. Inline the function in its caller to make the code more
> > readable.
> > 
> > Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> > ---
> > Changes Since v1:
> >  - Now this commit is the 3/4 of the series
> >  - Fixed commit body as suggested by LPinchart
> > 
> >  drivers/media/i2c/alvium-csi2.c | 51 ++++++++++++---------------------
> >  1 file changed, 19 insertions(+), 32 deletions(-)
> > 
> > diff --git a/drivers/media/i2c/alvium-csi2.c b/drivers/media/i2c/alvium-csi2.c
> > index a9ff6cc97cff..b234d74454bf 100644
> > --- a/drivers/media/i2c/alvium-csi2.c
> > +++ b/drivers/media/i2c/alvium-csi2.c
> > @@ -1660,14 +1660,26 @@ static int alvium_g_frame_interval(struct v4l2_subdev *sd,
> >  	return 0;
> >  }
> >  
> > -static int alvium_set_frame_interval(struct alvium_dev *alvium,
> > -				     struct v4l2_subdev_frame_interval *fi,
> > -				     u64 *req_fr)
> > +static int alvium_s_frame_interval(struct v4l2_subdev *sd,
> > +				   struct v4l2_subdev_state *sd_state,
> > +				   struct v4l2_subdev_frame_interval *fi)
> >  {
> > +	struct alvium_dev *alvium = sd_to_alvium(sd);
> >  	struct device *dev = &alvium->i2c_client->dev;
> > +	u64 req_fr = ALVIUM_DEFAULT_FR_HZ;
> 
> No need to initialize the variable. With this fixed,

Perfect, thanks I will drop this in v3.

Regards,
Tommaso

> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> >  	u64 dft_fr, min_fr, max_fr;
> >  	int ret;
> >  
> > +	/*
> > +	 * FIXME: Implement support for V4L2_SUBDEV_FORMAT_TRY, using the V4L2
> > +	 * subdev active state API.
> > +	 */
> > +	if (fi->which != V4L2_SUBDEV_FORMAT_ACTIVE)
> > +		return -EINVAL;
> > +
> > +	if (alvium->streaming)
> > +		return -EBUSY;
> > +
> >  	if (fi->interval.denominator == 0)
> >  		return -EINVAL;
> >  
> > @@ -1682,41 +1694,16 @@ static int alvium_set_frame_interval(struct alvium_dev *alvium,
> >  	dev_dbg(dev, "fi->interval.denominator = %d\n",
> >  		fi->interval.denominator);
> >  
> > -	*req_fr = (u64)((fi->interval.denominator * USEC_PER_SEC) /
> > +	req_fr = (u64)((fi->interval.denominator * USEC_PER_SEC) /
> >  		       fi->interval.numerator);
> >  
> > -	if (*req_fr >= max_fr && *req_fr <= min_fr)
> > -		*req_fr = dft_fr;
> > +	if (req_fr >= max_fr && req_fr <= min_fr)
> > +		req_fr = dft_fr;
> >  
> >  	alvium->frame_interval.numerator = fi->interval.numerator;
> >  	alvium->frame_interval.denominator = fi->interval.denominator;
> >  
> > -	return 0;
> > -}
> > -
> > -static int alvium_s_frame_interval(struct v4l2_subdev *sd,
> > -				   struct v4l2_subdev_state *sd_state,
> > -				   struct v4l2_subdev_frame_interval *fi)
> > -{
> > -	struct alvium_dev *alvium = sd_to_alvium(sd);
> > -	u64 req_fr = ALVIUM_DEFAULT_FR_HZ;
> > -	int ret;
> > -
> > -	/*
> > -	 * FIXME: Implement support for V4L2_SUBDEV_FORMAT_TRY, using the V4L2
> > -	 * subdev active state API.
> > -	 */
> > -	if (fi->which != V4L2_SUBDEV_FORMAT_ACTIVE)
> > -		return -EINVAL;
> > -
> > -	if (alvium->streaming)
> > -		return -EBUSY;
> > -
> > -	ret = alvium_set_frame_interval(alvium, fi, &req_fr);
> > -	if (!ret)
> > -		ret = alvium_set_frame_rate(alvium, req_fr);
> > -
> > -	return ret;
> > +	return alvium_set_frame_rate(alvium, req_fr);
> >  }
> >  
> >  static int alvium_enum_mbus_code(struct v4l2_subdev *sd,
> 
> -- 
> Regards,
> 
> Laurent Pinchart

