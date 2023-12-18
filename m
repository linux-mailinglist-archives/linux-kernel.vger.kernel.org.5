Return-Path: <linux-kernel+bounces-3336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FD6816B29
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06E811C20990
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E054714AB6;
	Mon, 18 Dec 2023 10:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDGDJQ7o"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BDE14273;
	Mon, 18 Dec 2023 10:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-553338313a0so1126030a12.2;
        Mon, 18 Dec 2023 02:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702895317; x=1703500117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kSEEEpA3QmH0zmyWiH0Erou6SwnXpv3PhxNkzqQuhXE=;
        b=GDGDJQ7ozoiVkutkFbGC1N+x3AeN8subTawK9BGLDwpwDOgl7NAxSVSQLtjqOMooW/
         k40tZxiIaHsqNtWyQ8M3D4Ue0B1XwGvsE1UbaBzTJkH7Xn+1yLDq28N4bYUSV8KDoEwo
         0S54j8xLUza16OdSjpzZ463UePf+qPfpCB/SQs/q23T6pqCs/Lwxmwl8LlSXtQS2AX3X
         dL0lA9WbyH1baHhST7ThVzIi8njce7tXbr1g7sYoZhqtE2YURi/ILsLkMcK6i/lCctfs
         MAPD660T8beUOW3odTSQh9Y5tnsIeib9MA53Jy7tOLX7gkHUiunpAenoJUQfZ87yIwXp
         6+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702895317; x=1703500117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kSEEEpA3QmH0zmyWiH0Erou6SwnXpv3PhxNkzqQuhXE=;
        b=SNar6gcR8hRG/5lTowGqeOs94TNE3QOGVWMAyu0++65zJOyA/0K7981FaoF4QNoR0f
         J6FbkWEngUQWOaYzZ3usRQYVH51dcEbSzaQhxpYVHPDWIiWm5JLuB0lnfHh7CveikHS7
         mB9R64Meeh8b2/fPaCciakeLYaOn8VWsFuokf1/xpmn74idFjTM4TlnQkv9LLOjfkg8i
         bsMsTMTPs31MUwfU1EAOBsKugek20KxdEyQ8Rsp0gWwCSJxL9ZFLcZajISAl1svh65b7
         vI3w9AepAQizTCdNX55WGlOJqELWIhiZgRIc453s1pE2EMyfOgH4Esp+KgE3IR7g18gv
         lvUw==
X-Gm-Message-State: AOJu0YyJ06XuXMz3Wm1My9cT7DJnV0cu+wQuUqYDCWKArUedYXVzw2Yd
	lGDe9TQSYmRWNcEccPSgySk=
X-Google-Smtp-Source: AGHT+IGym/r85idGaI4CUtm7xriOTT2MfJfJJ1BTtVeSJxbjYT5+QwRjlrIFJpOEauk+dptpMdiSzQ==
X-Received: by 2002:a17:906:2b45:b0:a23:3ea9:1a68 with SMTP id b5-20020a1709062b4500b00a233ea91a68mr1014087ejg.89.1702895317247;
        Mon, 18 Dec 2023 02:28:37 -0800 (PST)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation (net-188-217-59-229.cust.vodafonedsl.it. [188.217.59.229])
        by smtp.gmail.com with ESMTPSA id a24-20020a1709064a5800b00a23699a31e8sm46204ejv.89.2023.12.18.02.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 02:28:36 -0800 (PST)
Date: Mon, 18 Dec 2023 11:28:34 +0100
From: Tommaso Merciai <tomm.merciai@gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linuxfancy@googlegroups.com, sakari.ailus@linux.intel.com,
	Martin Hecht <martin.hecht@avnet.eu>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] media: i2c: alvium: inline set_frame_interval into
 s_frame_interval
Message-ID: <ZYAe0pa/oBmw/Mis@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
References: <20231215082452.1720481-1-tomm.merciai@gmail.com>
 <20231215082452.1720481-3-tomm.merciai@gmail.com>
 <20231218025507.GI5290@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218025507.GI5290@pendragon.ideasonboard.com>

Hi Laurent,

On Mon, Dec 18, 2023 at 04:55:07AM +0200, Laurent Pinchart wrote:
> Hi Tommaso,
> 
> Thank you for the patch.
> 
> On Fri, Dec 15, 2023 at 09:24:51AM +0100, Tommaso Merciai wrote:
> > Inline alvium_s_frame_interval function into alvium_s_frame_interval.
> 
> I think you mean "alvium_set_frame_interval() function into
> alvium_s_frame_interval.()"
> 
> > This to clean the driver code.
> 
> You can describe the reason more precisely:
> 
> The alvium_set_frame_interval() is called once only, by
> alvium_s_frame_interval(). The latter is a thin wrapper around the
> former. Inline the function in its caller to make the code more
> readable.
> 
> The rest looks good to me.

Yep, thanks for the review and for fixing commit body.
I will fix that in v2.

Thanks & Regards,
Tommaso

> 
> > Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> > ---
> >  drivers/media/i2c/alvium-csi2.c | 56 ++++++++++++---------------------
> >  1 file changed, 20 insertions(+), 36 deletions(-)
> > 
> > diff --git a/drivers/media/i2c/alvium-csi2.c b/drivers/media/i2c/alvium-csi2.c
> > index c4b7851045a1..fde456357be1 100644
> > --- a/drivers/media/i2c/alvium-csi2.c
> > +++ b/drivers/media/i2c/alvium-csi2.c
> > @@ -1662,16 +1662,25 @@ static int alvium_g_frame_interval(struct v4l2_subdev *sd,
> >  	return 0;
> >  }
> >  
> > -static int alvium_set_frame_interval(struct alvium_dev *alvium,
> > -				     struct v4l2_subdev *sd,
> > -				     struct v4l2_subdev_state *sd_state,
> > -				     struct v4l2_subdev_frame_interval *fi,
> > -				     u64 *req_fr)
> > +static int alvium_s_frame_interval(struct v4l2_subdev *sd,
> > +				   struct v4l2_subdev_state *sd_state,
> > +				   struct v4l2_subdev_frame_interval *fi)
> >  {
> > +	struct alvium_dev *alvium = sd_to_alvium(sd);
> >  	struct device *dev = &alvium->i2c_client->dev;
> > -	u64 dft_fr, min_fr, max_fr;
> > +	u64 req_fr, dft_fr, min_fr, max_fr;
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
> > @@ -1686,42 +1695,17 @@ static int alvium_set_frame_interval(struct alvium_dev *alvium,
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
> > -	alvium->fr = *req_fr;
> > +	alvium->fr = req_fr;
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
> > -	u64 req_fr;
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
> > -	ret = alvium_set_frame_interval(alvium, sd, sd_state, fi, &req_fr);
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

