Return-Path: <linux-kernel+bounces-159721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B47A8B3322
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 065351F214E8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 08:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA07E13A879;
	Fri, 26 Apr 2024 08:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GpOjRpag"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C76441C62;
	Fri, 26 Apr 2024 08:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714120902; cv=none; b=Ism8sonwcNzJYoCUu0XKrmLNfQyZk6Rpzgz0rPofX99ONPdeAec6z2r0c6pxULIYsLhjLT6TufWEeyoiHk2Hnf7xIfIIqy79dY7LyWHEA7Rzukcbz4eVuDxeRrfW8fdU1ws+Qgs72UIQORWmevNdaujgENDGzUmotYClewEsDc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714120902; c=relaxed/simple;
	bh=gmfMHQVu+QXaMmTfQbZlMyBhmPZ6SDodHpc9j3YOVH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RDvdXe/zRyPGpGY4NFN28LZ/1rPl22sFPRmLpCUVpvfy0nfQmLKvsblSdImrx771810/oexoK12273feU3rsLFhcfq5F+8tPRE+In35gUgNe/fdWsIH3tx3D4foeBmxdV+YByXuZT0vHRR2N+T1uFDcrU5yYvGoBtVFnpL+JKXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GpOjRpag; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56c5d05128dso1910080a12.0;
        Fri, 26 Apr 2024 01:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714120899; x=1714725699; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1GlQQDniUNI7oXCoE7vPyzC6a7LaN00a8acVhUbsE/g=;
        b=GpOjRpagKU9jNZ9b9Jn9Zv2elFhOllVwRknvQMuQUrms9lgBDXyGzV6YtrWjjlE6hO
         DqZqLkuOKKZw/gBjg6Y94KRhJEwSEc7fFTUvocSYCBeUwlqlGayop7PpRdb2vm7GpFwx
         hDrT9bVC5PGUSdm2kTsu+eF+TshTCiOxMifLHCzZZX2FE9ighr16w1xuGFW28NTpZzzF
         jpMU43e1mvZV/Ihklf52XIQXHjn41HaPHIgYn4Q5s/5oNVsAQx3q8AvhbKWLvxaIKUU7
         rVNw/y/IngSgZti/Fz16jdTdeK9/ZsHbo3SfYf+Pu93hN5ALNfODMge26/8NWq/jYesK
         1Ucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714120899; x=1714725699;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1GlQQDniUNI7oXCoE7vPyzC6a7LaN00a8acVhUbsE/g=;
        b=fmY3KsfQfZ6yH9lis8K7zrqO1vR1RZkeRJnnz3dRYTaJpqb/UzdTaMmXqNhtFgRQHV
         ykZJl2DMVGP8KUW8dg+miCCM78ytH+MS9GHLmf9OQY8l4DTMWw3HeStNIUgiHh4hak28
         ckdZTA/j3kqQBvJ5HntcF9++vEh2hCAiLqXb3u+gaYAvnv06nbNXRUw/HNyiVKpHPSWk
         J82TzJHmw7fT0h4fBMR/Mm5SLzU/Wu4L3LE9RBclfxMlwMnTf/TLopznDkMWn/caeZz6
         JwZbzImg3n2oVYpm2KhOH7iQjChwahJkVH8iNJTESQ77iOLQhRY5Lo3BrBy3uizYBcH4
         W88w==
X-Forwarded-Encrypted: i=1; AJvYcCXlJWVwHaRROD4psSPQszl7KvnsFUdJf0xB9ZUeVuxyfNxlZJKUjOtD7+2fgUa/OKAjFhyrF0pJ8gmBaVkiGwq+A1gWi/DoTOsqf3q/PqJj2hTwERoyAZ3xlWkbdfxdzLnbvc8LhXTeN8I=
X-Gm-Message-State: AOJu0YyjNs18Qd8QiBItNJbjqPUEjNxIyCm+nq4z+G08YC3kWKiGRsuL
	joY8gFk5GTgR79Dogk+KbbJlhZtKKjzLHdgLcCOv0FEqkNBhdWF2cgI19Q==
X-Google-Smtp-Source: AGHT+IEMOOI+Q6Q3cvl121aRVnp266Xak0a3L9GqUl7Yf1+4PeJnE+BW8IE0JQtN/jgwN7AfhEFxJg==
X-Received: by 2002:a50:cd15:0:b0:56e:64a:2a47 with SMTP id z21-20020a50cd15000000b0056e064a2a47mr1261278edi.42.1714120898379;
        Fri, 26 Apr 2024 01:41:38 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation (net-2-39-143-74.cust.vodafonedsl.it. [2.39.143.74])
        by smtp.gmail.com with ESMTPSA id u15-20020aa7d0cf000000b005704b18ed2fsm9770546edo.83.2024.04.26.01.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 01:41:38 -0700 (PDT)
Date: Fri, 26 Apr 2024 10:41:36 +0200
From: Tommaso Merciai <tomm.merciai@gmail.com>
To: Sakari Ailus <sakari.ailus@iki.fi>
Cc: martin.hecht@avnet.eu, michael.roeder@avnet.eu,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] media: i2c: alvium: Move V4L2_CID_GAIN to
 V4L2_CID_ANALOG_GAIN
Message-ID: <ZitowFM86EE52IZB@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
References: <20240416141905.454253-1-tomm.merciai@gmail.com>
 <20240416141905.454253-6-tomm.merciai@gmail.com>
 <ZilLThyqHC2xi6tS@valkosipuli.retiisi.eu>
 <ZitTL/IhmuvwF2Qu@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
 <ZitUAsBgoxLG_vEx@valkosipuli.retiisi.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZitUAsBgoxLG_vEx@valkosipuli.retiisi.eu>

Hi Sakari,

On Fri, Apr 26, 2024 at 07:13:06AM +0000, Sakari Ailus wrote:
> Hi Tommaso,
> 
> On Fri, Apr 26, 2024 at 09:09:35AM +0200, Tommaso Merciai wrote:
> > Hi Sakari,
> > Thanks for your review.
> > 
> > On Wed, Apr 24, 2024 at 06:11:26PM +0000, Sakari Ailus wrote:
> > > Hi Tommaso,
> > > 
> > > On Tue, Apr 16, 2024 at 04:19:05PM +0200, Tommaso Merciai wrote:
> > > > Into alvium cameras REG_BCRM_GAIN_RW control the analog gain.
> > > > Let's use the right V4L2_CID_ANALOGUE_GAIN ctrl.
> > > > 
> > > > Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> > > > ---
> > > >  drivers/media/i2c/alvium-csi2.c | 6 +++---
> > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/drivers/media/i2c/alvium-csi2.c b/drivers/media/i2c/alvium-csi2.c
> > > > index 30ef9b905211..56d64f27df72 100644
> > > > --- a/drivers/media/i2c/alvium-csi2.c
> > > > +++ b/drivers/media/i2c/alvium-csi2.c
> > > > @@ -1993,7 +1993,7 @@ static int alvium_g_volatile_ctrl(struct v4l2_ctrl *ctrl)
> > > >  	int val;
> > > >  
> > > >  	switch (ctrl->id) {
> > > > -	case V4L2_CID_GAIN:
> > > > +	case V4L2_CID_ANALOGUE_GAIN:
> > > >  		val = alvium_get_gain(alvium);
> > > >  		if (val < 0)
> > > >  			return val;
> > > > @@ -2025,7 +2025,7 @@ static int alvium_s_ctrl(struct v4l2_ctrl *ctrl)
> > > >  		return 0;
> > > >  
> > > >  	switch (ctrl->id) {
> > > > -	case V4L2_CID_GAIN:
> > > > +	case V4L2_CID_ANALOGUE_GAIN:
> > > >  		ret = alvium_set_ctrl_gain(alvium, ctrl->val);
> > > >  		break;
> > > >  	case V4L2_CID_AUTOGAIN:
> > > > @@ -2154,7 +2154,7 @@ static int alvium_ctrl_init(struct alvium_dev *alvium)
> > > >  
> > > >  	if (alvium->avail_ft.gain) {
> > > >  		ctrls->gain = v4l2_ctrl_new_std(hdl, ops,
> > > > -						V4L2_CID_GAIN,
> > > > +						V4L2_CID_ANALOGUE_GAIN,
> > > >  						alvium->min_gain,
> > > >  						alvium->max_gain,
> > > >  						alvium->inc_gain,
> > > 
> > > This looks like a bugfix. Shouldn't it be cc'd to stable as well? A Fixes:
> > > tag would be nice, too.
> > 
> > Fully agree.
> > Plan is to add in v2 Fixes: 0a7af872915e ("media: i2c: Add support for alvium camera")
> > like you suggest and stable@vger.kernel.org in CC.
> 
> Just make sure git send-email won't actually cc the patch to the stable
> e-mail address. Cc: tag is enough. The git config option is
> sendemail.suppresscc.

Sorry, just to clarify.
You are suggesting just to add sendemail.suppresscc. option right?
No cc stable@vger.kernel.org

Thanks & Regards,
Tommaso

> 
> -- 
> Regards,
> 
> Sakari Ailus

