Return-Path: <linux-kernel+bounces-6994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B16581A04C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FF3A1F298D3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1CE3716B;
	Wed, 20 Dec 2023 13:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdezTDQP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E4438F82;
	Wed, 20 Dec 2023 13:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-553729ee917so3997970a12.1;
        Wed, 20 Dec 2023 05:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703080376; x=1703685176; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7/yVFAelzLfm7RlheZ3fXLWmaMLPV54FlFv3c5NkxDE=;
        b=QdezTDQP6D5ZADksxQW9/TgfkUu0cwvrgK2lx9T8b33R6/nQsaUpWJ1bwG+O81lkwc
         LqucHQU7TeINFKKXHztSpRqrafgxqJNboE0PzocPXnhe/o9GXiu2it/L6fYTEu5cKerG
         3toxRs4fxOfNIzEdv9kZbfF3rZDhS0cXmr7QygGDxOLy+5adJRc6L6SJN+Eo1QHhfVo+
         3Z7xWuapbj8yFHdJhAPXMXINu1QL4ST3U9MgCDPZ1Zutbm9hITJfvYXqXKBbzKmfn+AK
         vRhHwynd2mc9V8bqyeAznaehSggoy/uK3FhK4T/ovMEqQHtG+T3OdEhuGYg2eFD7os2g
         eH2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703080376; x=1703685176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7/yVFAelzLfm7RlheZ3fXLWmaMLPV54FlFv3c5NkxDE=;
        b=o8JPLiwKQwqHzKYKQz+jjgDfwQCi3E3PsvNQtaj955OUeHcEqTq5lG5zSoUQn29Ew7
         sOyzebfMrUls0nv5zg0M04hZMPDnhYsbK95zKJD8XJA8qEfaUQV+eavOew6SL+zlBWGg
         EUUItK86KOLUC3nXxaujpKLZZ2D0JSD/yFcMRCcuweakXyO1Mqxobc/pF+Fmm+RERGE3
         luxhMujqoP22AxBG8cJ2NZ5e2Ncvpve+iUWsUdUpCCt5W+JFi1Mt+1qOr18+hqXaHsNT
         DY0Vu/UdY8MPgtbM0sEElaxK4Mcg0D5fgzd3w+S/X2PBWXb0cX+fykbVCwq5kONyhzHK
         KQHA==
X-Gm-Message-State: AOJu0YwOYi44i9fXY6MOCGnakRsL2y9k7ILHfDmQRmHfzVRBtt/awyDS
	EYLLt5XwhtvMsfp8fTBrFK4xtaWOd3A=
X-Google-Smtp-Source: AGHT+IGahSSvrBEeGsMspXvnwHfHPMXEz8TIyRGbyKW4rKC0TQ984ORU9BUwOVC2gqU3ccebSmwcww==
X-Received: by 2002:a50:9313:0:b0:553:31d5:a19 with SMTP id m19-20020a509313000000b0055331d50a19mr3210370eda.51.1703080376072;
        Wed, 20 Dec 2023 05:52:56 -0800 (PST)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation (net-188-217-59-229.cust.vodafonedsl.it. [188.217.59.229])
        by smtp.gmail.com with ESMTPSA id o11-20020a056402444b00b00552840ba274sm6252579edb.89.2023.12.20.05.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 05:52:55 -0800 (PST)
Date: Wed, 20 Dec 2023 14:52:53 +0100
From: Tommaso Merciai <tomm.merciai@gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linuxfancy@googlegroups.com, sakari.ailus@linux.intel.com,
	martin.hecht@avnet.eu, Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] media: i2c: alvium: fix req_fr check into
 alvium_s_frame_interval()
Message-ID: <ZYLxtTRQF0sWJLiu@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
References: <20231220124023.2801417-1-tomm.merciai@gmail.com>
 <20231220124023.2801417-6-tomm.merciai@gmail.com>
 <20231220130236.GN29638@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220130236.GN29638@pendragon.ideasonboard.com>

Hi Laurent,

On Wed, Dec 20, 2023 at 03:02:36PM +0200, Laurent Pinchart wrote:
> Hi Tommaso,
> 
> Thank you for the patch.
> 
> On Wed, Dec 20, 2023 at 01:40:23PM +0100, Tommaso Merciai wrote:
> > Actually req_fr check into alvium_s_frame_interval() is wrong.
> > In particular req_fr can't be >=max and <= min at the same time.
> > Fix this using clamp and remove dft_fr parameter from
> > alvium_get_frame_interval() not more used.
> 
> The commit message should have explained why clamping is better than
> picking a default value, as that's a functional change. If you propose
> an updated commit message in a reply, I think Sakari can update the
> patch when applying the series to his tree, there's no need for a v4.

What about:

Actually req_fr check into alvium_s_frame_interval() is wrong.
In particular req_fr can't be >=max and <= min at the same time.
Fix this using clamp and remove dft_fr parameter from
alvium_get_frame_interval() not more used.

Clamp function make sure that if the setted value exceeds the limits is
replaced with min_fr/max_fr instead of setting the value readed back
from the hw.

What do you think?

Thanks & Regards,
Tommaso

> 
> > Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> > ---
> >  drivers/media/i2c/alvium-csi2.c | 12 ++++--------
> >  1 file changed, 4 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/media/i2c/alvium-csi2.c b/drivers/media/i2c/alvium-csi2.c
> > index 240bf991105e..01111a00902d 100644
> > --- a/drivers/media/i2c/alvium-csi2.c
> > +++ b/drivers/media/i2c/alvium-csi2.c
> > @@ -1171,12 +1171,10 @@ static int alvium_set_bayer_pattern(struct alvium_dev *alvium,
> >  }
> >  
> >  static int alvium_get_frame_interval(struct alvium_dev *alvium,
> > -				     u64 *dft_fr, u64 *min_fr, u64 *max_fr)
> > +				     u64 *min_fr, u64 *max_fr)
> >  {
> >  	int ret = 0;
> >  
> > -	alvium_read(alvium, REG_BCRM_ACQUISITION_FRAME_RATE_RW,
> > -		    dft_fr, &ret);
> >  	alvium_read(alvium, REG_BCRM_ACQUISITION_FRAME_RATE_MIN_R,
> >  		    min_fr, &ret);
> >  	alvium_read(alvium, REG_BCRM_ACQUISITION_FRAME_RATE_MAX_R,
> > @@ -1647,7 +1645,7 @@ static int alvium_s_frame_interval(struct v4l2_subdev *sd,
> >  {
> >  	struct alvium_dev *alvium = sd_to_alvium(sd);
> >  	struct device *dev = &alvium->i2c_client->dev;
> > -	u64 req_fr, dft_fr, min_fr, max_fr;
> > +	u64 req_fr, min_fr, max_fr;
> >  	struct v4l2_fract *interval;
> >  	int ret;
> >  
> > @@ -1657,7 +1655,7 @@ static int alvium_s_frame_interval(struct v4l2_subdev *sd,
> >  	if (fi->interval.denominator == 0)
> >  		return -EINVAL;
> >  
> > -	ret = alvium_get_frame_interval(alvium, &dft_fr, &min_fr, &max_fr);
> > +	ret = alvium_get_frame_interval(alvium, &min_fr, &max_fr);
> >  	if (ret) {
> >  		dev_err(dev, "Fail to get frame interval\n");
> >  		return ret;
> > @@ -1670,9 +1668,7 @@ static int alvium_s_frame_interval(struct v4l2_subdev *sd,
> >  
> >  	req_fr = (u64)((fi->interval.denominator * USEC_PER_SEC) /
> >  		       fi->interval.numerator);
> > -
> > -	if (req_fr >= max_fr && req_fr <= min_fr)
> > -		req_fr = dft_fr;
> > +	req_fr = clamp(req_fr, min_fr, max_fr);
> >  
> >  	interval = v4l2_subdev_state_get_interval(sd_state, 0);
> >  
> 
> -- 
> Regards,
> 
> Laurent Pinchart

