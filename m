Return-Path: <linux-kernel+bounces-159905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D588B3600
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA8BF1F226E5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B608146594;
	Fri, 26 Apr 2024 10:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="FpdTpkqu"
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F40B145348;
	Fri, 26 Apr 2024 10:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714128606; cv=pass; b=gNG/iiaZTThfurUEHbNgrsS6SxSWuyq1kxZwmefsy53DLurYeQZezJZlxtXCnH9B7WE3eP/Pqmym/5L+6kj/rwAvIM42yzG5cs5zpg02WCP3A32qqXP3YizNv2SDftDzDU5oH/UpKyNapAbMi4kSDgADUel7wxjcu8sgdL7eBbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714128606; c=relaxed/simple;
	bh=GWaq2g/xBydbPN9q+8h8xFfRgOf8B9sswxl0BgJjkVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdvZjfwYCbE46gV43Catk0f0tUoM0R1fp3TEbuORUIyJI6iLV1aC/paJUm3bJIWxqThIu6P3+YM2w5JL3wmlDGtPFsTS0XTRURw8X/FmLHTiegnYzZjJfg78Fh5fqNSS6Vabsh11VVMb9MsYY1aXmveVFPMUHscN6xmA1fMr61U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=FpdTpkqu; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from hillosipuli.retiisi.eu (80-248-247-191.cust.suomicom.net [80.248.247.191])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sailus)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4VQqHY5VpTzyRw;
	Fri, 26 Apr 2024 13:50:01 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1714128601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XFC6uXO7DD8kpivh7H6J7YSnZ1VOLVEISlEahgPLNVE=;
	b=FpdTpkquJWDKmrBJHeWlhFbZQptxWPo7F55rM/TgBwxSulmgDsCzUUd1HNDTjQoLK64tmx
	9VnhJLsD4TqG9E/NY9ATV8f97RBgpIAPKVbG/NIf+CgFLUb6lVpLG2pAOIJbmrGceF4ApL
	TsItngSB3uipVZCUwD7DPk+m88OxOfE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1714128601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XFC6uXO7DD8kpivh7H6J7YSnZ1VOLVEISlEahgPLNVE=;
	b=O9Z6E+oh13HuxWGXsVkR/V/t35lJE2aTF1Y/numuJ/KtRVxS/pykhOlJaXkkfach+Jk4xx
	OljS2azg8MR+1vgCYu1GQQs2gRtLGxq6Mj8N6UAXdWpLHYQSAdQs5wgI9S8hpKVR/LtQSt
	fPe3BOyGIqePdulXkHX6MrgnWbhGRmA=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1714128601; a=rsa-sha256; cv=none;
	b=ak4v3CveP1m9N8Wgn5kFDnv5j5LNtUQiaA1SSpg36eJplljQ55ZwA1kY+xQuenydNKY8kO
	NHCdaZ0Fwd9ynE/cOwi5cr14CCHHOchckltEHI6wAW6ltsZXPnv0+95Cym9CUFOHYX2QKA
	6oLSirzrr/DYDxb2nVF+y6S34G+r/aQ=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 08CF2634C96;
	Fri, 26 Apr 2024 13:49:59 +0300 (EEST)
Date: Fri, 26 Apr 2024 10:49:59 +0000
From: Sakari Ailus <sakari.ailus@iki.fi>
To: Tommaso Merciai <tomm.merciai@gmail.com>
Cc: martin.hecht@avnet.eu, michael.roeder@avnet.eu,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] media: i2c: alvium: Move V4L2_CID_GAIN to
 V4L2_CID_ANALOG_GAIN
Message-ID: <ZiuG1xS5umlNl7vq@valkosipuli.retiisi.eu>
References: <20240416141905.454253-1-tomm.merciai@gmail.com>
 <20240416141905.454253-6-tomm.merciai@gmail.com>
 <ZilLThyqHC2xi6tS@valkosipuli.retiisi.eu>
 <ZitTL/IhmuvwF2Qu@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
 <ZitUAsBgoxLG_vEx@valkosipuli.retiisi.eu>
 <ZitowFM86EE52IZB@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZitowFM86EE52IZB@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>

Hi Tommaso,

On Fri, Apr 26, 2024 at 10:41:36AM +0200, Tommaso Merciai wrote:
> Hi Sakari,
> 
> On Fri, Apr 26, 2024 at 07:13:06AM +0000, Sakari Ailus wrote:
> > Hi Tommaso,
> > 
> > On Fri, Apr 26, 2024 at 09:09:35AM +0200, Tommaso Merciai wrote:
> > > Hi Sakari,
> > > Thanks for your review.
> > > 
> > > On Wed, Apr 24, 2024 at 06:11:26PM +0000, Sakari Ailus wrote:
> > > > Hi Tommaso,
> > > > 
> > > > On Tue, Apr 16, 2024 at 04:19:05PM +0200, Tommaso Merciai wrote:
> > > > > Into alvium cameras REG_BCRM_GAIN_RW control the analog gain.
> > > > > Let's use the right V4L2_CID_ANALOGUE_GAIN ctrl.
> > > > > 
> > > > > Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> > > > > ---
> > > > >  drivers/media/i2c/alvium-csi2.c | 6 +++---
> > > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/media/i2c/alvium-csi2.c b/drivers/media/i2c/alvium-csi2.c
> > > > > index 30ef9b905211..56d64f27df72 100644
> > > > > --- a/drivers/media/i2c/alvium-csi2.c
> > > > > +++ b/drivers/media/i2c/alvium-csi2.c
> > > > > @@ -1993,7 +1993,7 @@ static int alvium_g_volatile_ctrl(struct v4l2_ctrl *ctrl)
> > > > >  	int val;
> > > > >  
> > > > >  	switch (ctrl->id) {
> > > > > -	case V4L2_CID_GAIN:
> > > > > +	case V4L2_CID_ANALOGUE_GAIN:
> > > > >  		val = alvium_get_gain(alvium);
> > > > >  		if (val < 0)
> > > > >  			return val;
> > > > > @@ -2025,7 +2025,7 @@ static int alvium_s_ctrl(struct v4l2_ctrl *ctrl)
> > > > >  		return 0;
> > > > >  
> > > > >  	switch (ctrl->id) {
> > > > > -	case V4L2_CID_GAIN:
> > > > > +	case V4L2_CID_ANALOGUE_GAIN:
> > > > >  		ret = alvium_set_ctrl_gain(alvium, ctrl->val);
> > > > >  		break;
> > > > >  	case V4L2_CID_AUTOGAIN:
> > > > > @@ -2154,7 +2154,7 @@ static int alvium_ctrl_init(struct alvium_dev *alvium)
> > > > >  
> > > > >  	if (alvium->avail_ft.gain) {
> > > > >  		ctrls->gain = v4l2_ctrl_new_std(hdl, ops,
> > > > > -						V4L2_CID_GAIN,
> > > > > +						V4L2_CID_ANALOGUE_GAIN,
> > > > >  						alvium->min_gain,
> > > > >  						alvium->max_gain,
> > > > >  						alvium->inc_gain,
> > > > 
> > > > This looks like a bugfix. Shouldn't it be cc'd to stable as well? A Fixes:
> > > > tag would be nice, too.
> > > 
> > > Fully agree.
> > > Plan is to add in v2 Fixes: 0a7af872915e ("media: i2c: Add support for alvium camera")
> > > like you suggest and stable@vger.kernel.org in CC.
> > 
> > Just make sure git send-email won't actually cc the patch to the stable
> > e-mail address. Cc: tag is enough. The git config option is
> > sendemail.suppresscc.
> 
> Sorry, just to clarify.
> You are suggesting just to add sendemail.suppresscc. option right?
> No cc stable@vger.kernel.org

Yes, and adding a Cc: stable@vger.kernel.org tag.

-- 
Regards,

Sakari Ailus

