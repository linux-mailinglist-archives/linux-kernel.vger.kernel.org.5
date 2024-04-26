Return-Path: <linux-kernel+bounces-159615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C6A8B3112
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A0EE281DDE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 07:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDB413B5B3;
	Fri, 26 Apr 2024 07:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACnLLeMy"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2244EACD;
	Fri, 26 Apr 2024 07:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714115381; cv=none; b=I7oBv1N7OcR3NFQk9nM8BhcLYcWC26lVbl4tNvIJR8KsHhLmFO67jRSESpl0kVoDHrExt5McpQerPrOHen/9Ak8ECgiVKSh+D9MCyHp1zCJg+2UoFF/ruHr0lVOsJAMIDH4hnKywxhGgQmDe7MsZ9QvM5ryD6GOLXdpl13LO4BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714115381; c=relaxed/simple;
	bh=Ycd2cCLgPz1pH9qCQxn4ztVUA8S4xuxAJxFsTwrlXoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cPct0BzNLDMw9jCP1/4BMJWNMNAHkWFMjNG2SwGR83rKCJmeGBN5VPXOe38leWE86ORXlKf5jrGlmyRakzCuIWEwXXvYINvyuXGC+92WnRZw2/ttl7E5T8sCiyBzSKF8za8WmGSX2FKJwGdwF7vAFh2i3BihC8SJnguuOKaFBBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ACnLLeMy; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2db2f6cb312so27447181fa.2;
        Fri, 26 Apr 2024 00:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714115378; x=1714720178; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0F+t/Bluy971mogDLeY9/r7RK+Wj9dTJdXW7NW3kLfE=;
        b=ACnLLeMyWmiNoG2+e+7CwPrMeXL7akkXXKMFq1ewWhLDX4KN69h24W9Z773pNAY1f1
         ltJfCTGOSe3pKjqAahx/QuDSCKS2ZoMjVCKU2cCRe7a8c6wRspysTxMCBxRAgAXPSTyq
         ICFP7faQJgTKU9Ci149QmmVfTPleJo3E56eLbETj5N+U1Fxj9DQqOglzaNdDDUZsw6RV
         NjQz51LoQYAaK7uLBUwOLYaLckKP45EfID6n7z97cG72mQekT6EsriiVnVKhdKU+oxIj
         hRa4cvfB2nt2d3GEX+1fDV+DX86ll52mUPIxLyvl2G+IFBWBUt2kUYca1V7BkVDuTkxV
         Tsjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714115378; x=1714720178;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0F+t/Bluy971mogDLeY9/r7RK+Wj9dTJdXW7NW3kLfE=;
        b=cFDCKRsbAoJI2uLpSZ+6BC/pJpwuBhuXgnVD8/VV1XVTsMOUXVqCAjJlPP1ls2iJLC
         UfzvUIPCqNhniWppZl79Zs5znUj4I5OxwF6+Z84ohY4h1MzFFQa4W2+qduQaedg7CDb+
         dp8ylkE5Yc8KBLUaE8TjLVvmIVb5PX7IdmJ0WYxKe1gPBh6cdn2FMlK1+BuwsZNgJ1dy
         HV27gBNwzw9wM0dQbyPmgj7LHe95+j/KwsqXRJmdUrzYiSxLHnrUIcr2TxETKTjf2UEQ
         6WbjgYsf4CYb8x9RnXSOw/G1Ni9vMrxcfW8U5Do4zXezr6J1Qb7Qdxe0PgFp80SFq0+0
         Httg==
X-Forwarded-Encrypted: i=1; AJvYcCUUhPwHI9DNbpfeQ8T08dEM64hw4qNYFGaypdvvXOeywLyQycJLVsUJ8LCfeiQX4goxrfNLEYejyMO2V17jKZ37CW9GTjjkTq4JX1dzA+sv8o+q8rT3NiZKbrVV5xkIdn4sngr4mxPzQm8=
X-Gm-Message-State: AOJu0YwMTn34P1G+hUk3atUiK3eyOsqZN19zcs/C3lwgHZboLHtRtJvs
	QLLJIFKsAglcDzCkbJOhP9bd4hy1+ig/PJeSoafHs4xACMEbRXIVph7tVg==
X-Google-Smtp-Source: AGHT+IG++BZdkPuuy++Kj9NrA45PS/qD3oTdm9J2bGG08eURhC4RNuB4qkXhRCpTfvxUuOO7e86FRw==
X-Received: by 2002:a05:651c:b0b:b0:2d4:6893:24e1 with SMTP id b11-20020a05651c0b0b00b002d4689324e1mr1292135ljr.50.1714115377629;
        Fri, 26 Apr 2024 00:09:37 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation (net-2-39-143-74.cust.vodafonedsl.it. [2.39.143.74])
        by smtp.gmail.com with ESMTPSA id ld11-20020a170906f94b00b00a55adcf48a2sm6435403ejb.50.2024.04.26.00.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 00:09:37 -0700 (PDT)
Date: Fri, 26 Apr 2024 09:09:35 +0200
From: Tommaso Merciai <tomm.merciai@gmail.com>
To: Sakari Ailus <sakari.ailus@iki.fi>
Cc: martin.hecht@avnet.eu, michael.roeder@avnet.eu,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] media: i2c: alvium: Move V4L2_CID_GAIN to
 V4L2_CID_ANALOG_GAIN
Message-ID: <ZitTL/IhmuvwF2Qu@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
References: <20240416141905.454253-1-tomm.merciai@gmail.com>
 <20240416141905.454253-6-tomm.merciai@gmail.com>
 <ZilLThyqHC2xi6tS@valkosipuli.retiisi.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZilLThyqHC2xi6tS@valkosipuli.retiisi.eu>

Hi Sakari,
Thanks for your review.

On Wed, Apr 24, 2024 at 06:11:26PM +0000, Sakari Ailus wrote:
> Hi Tommaso,
> 
> On Tue, Apr 16, 2024 at 04:19:05PM +0200, Tommaso Merciai wrote:
> > Into alvium cameras REG_BCRM_GAIN_RW control the analog gain.
> > Let's use the right V4L2_CID_ANALOGUE_GAIN ctrl.
> > 
> > Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> > ---
> >  drivers/media/i2c/alvium-csi2.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/media/i2c/alvium-csi2.c b/drivers/media/i2c/alvium-csi2.c
> > index 30ef9b905211..56d64f27df72 100644
> > --- a/drivers/media/i2c/alvium-csi2.c
> > +++ b/drivers/media/i2c/alvium-csi2.c
> > @@ -1993,7 +1993,7 @@ static int alvium_g_volatile_ctrl(struct v4l2_ctrl *ctrl)
> >  	int val;
> >  
> >  	switch (ctrl->id) {
> > -	case V4L2_CID_GAIN:
> > +	case V4L2_CID_ANALOGUE_GAIN:
> >  		val = alvium_get_gain(alvium);
> >  		if (val < 0)
> >  			return val;
> > @@ -2025,7 +2025,7 @@ static int alvium_s_ctrl(struct v4l2_ctrl *ctrl)
> >  		return 0;
> >  
> >  	switch (ctrl->id) {
> > -	case V4L2_CID_GAIN:
> > +	case V4L2_CID_ANALOGUE_GAIN:
> >  		ret = alvium_set_ctrl_gain(alvium, ctrl->val);
> >  		break;
> >  	case V4L2_CID_AUTOGAIN:
> > @@ -2154,7 +2154,7 @@ static int alvium_ctrl_init(struct alvium_dev *alvium)
> >  
> >  	if (alvium->avail_ft.gain) {
> >  		ctrls->gain = v4l2_ctrl_new_std(hdl, ops,
> > -						V4L2_CID_GAIN,
> > +						V4L2_CID_ANALOGUE_GAIN,
> >  						alvium->min_gain,
> >  						alvium->max_gain,
> >  						alvium->inc_gain,
> 
> This looks like a bugfix. Shouldn't it be cc'd to stable as well? A Fixes:
> tag would be nice, too.

Fully agree.
Plan is to add in v2 Fixes: 0a7af872915e ("media: i2c: Add support for alvium camera")
like you suggest and stable@vger.kernel.org in CC.

Thanks & Regards,
Tommaso

> 
> -- 
> Regards,
> 
> Sakari Ailus

