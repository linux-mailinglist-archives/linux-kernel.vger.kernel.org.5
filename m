Return-Path: <linux-kernel+bounces-159618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A46A8B3124
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36395283DE3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 07:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9725813C3D1;
	Fri, 26 Apr 2024 07:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="qVJjDIg3"
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E8513B787;
	Fri, 26 Apr 2024 07:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714115592; cv=pass; b=PjprR0IQ8IV5VIaZzyy42JET3UlDb1obakf/geqwkLOVyFvjTZQTgTcJIcct+wa8FfYFKpOn57DQuBGN5acb27cbNbDtCoigWF10TfI6ERUXf/5ZTzRmdNq4XlqMQRWAG/UeNsLlce/e4I5TW928A4SWAom9PvzkNbUAq8S62jg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714115592; c=relaxed/simple;
	bh=cafSks1k89IN6rokLafePAbd3MXzKl3T+33eU3ZDGyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ANX7pkEi6q+TfYAvLezcQnJ/1oKhf/zlhg2E/ykRLT/NvDXRU0gfWhX4vtBSSr07RLc+h1Yvc6nEhQe4s8O4uUBp+fBSR50LlDB61cN9AaT6D81TKO+bzGvGc2ciRroisGnp5oB/rdeGX1W4e+iQ6L17MJmJ6GLMvdmkQ/VRjhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=qVJjDIg3; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from hillosipuli.retiisi.eu (2a00-1190-d1dd-0-c641-1eff-feae-163c.v6.cust.suomicom.net [IPv6:2a00:1190:d1dd:0:c641:1eff:feae:163c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sailus)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4VQkTH19lCz49Pxk;
	Fri, 26 Apr 2024 10:13:07 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1714115587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=53jluzU89EQBBFVoMObpH5Ps1oIGuKHOf1ADfGhaN5M=;
	b=qVJjDIg3HZ5rc2ntHDEOWPR6nFXmt4VEgT6cnUgCHNJaDeRer1p/3czSXvk2KCcQ9KLmF3
	ieaXJhKYx3f6csVcdPOM5eDEq7fLJtGW1moqysdEbDIAYV5ZazqYAnMg4JIzlU2KefG1WE
	iTzPH8fi3RIeC9CU3IwjCCTkqZT9189lrUcyX8SQCBmE9qF9SWaSPHJTTFyF0HEh9PPibS
	3A7rWHChghbr8f0Xvx5qU4GPHMDp37v5dOshr8u/UEnWIic7DvZwoxGupwUNZWNnpWOMxy
	1TpZanEEimMcXdA6PLkhdcYWWdlAXS9Zz/L7aOf4rCrne9lAydBDVu1XcConAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1714115587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=53jluzU89EQBBFVoMObpH5Ps1oIGuKHOf1ADfGhaN5M=;
	b=iyF3vdeF//2nEC10LW4R9knRl8kytK4DrLG7dpbzami/Ygu1zsbtPL+uK95p8hmg5Uqo7h
	uwOe2E3Z1MFOMRvmI7KZc37is8qtubYpfO6S7F/6RwwWgOKS+W8wWSpeVcaCAthLfFmYSo
	Ev+awxmFECPTNeXSD9rRoK8sEvCkG9pj5ZTNpbvOnISOEKjZ+OGnOWSaZo0CT8OL0f91FR
	aIGgLCIdPc/t7Rhv9rzoBm775jA/oqYhLFac5kHYqHcWYMCv9HgghJKio3snMoS7wWWZ0c
	Ipr5ew2OoqtgQ+OZR1n2c+Gu2BUGhHI3mKcJWm4nuVYB2k5UVK2TKQ+DX572Nw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1714115587; a=rsa-sha256;
	cv=none;
	b=cCzT4XqLKaLDDaxQA6f7EWIRqBe7ydRrvYr9KRcu0uYZrhKsWoqVHIkLOo20KjJ+Ytqwpj
	RuBKSD34X4AUQqlQt2It7roM0YsS8+aGQdeAXnJkBFS8gAUuzi95anC9KB0lV7Y1rQNv7b
	s+4LWHMGVfeEAI8f4tifAeI0vSg/R6EHPfWFq1nXT6eEYt/2NaOrgyakctZ5gbY3F/j5gP
	PxleIZzo5XBFV1LflrsLcBEfauLF7bcKN+tBXn1B1xWbyASx0qqXK8X8T61tNNgN8FXmFh
	qI3r+yG5hcFwlnUYo1fMFSQFm0QIIyUp2FWemwJeWBddNGRhA1/czzdd/RsjOA==
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hillosipuli.retiisi.eu (Postfix) with ESMTPS id CA1C6634C93;
	Fri, 26 Apr 2024 10:13:06 +0300 (EEST)
Date: Fri, 26 Apr 2024 07:13:06 +0000
From: Sakari Ailus <sakari.ailus@iki.fi>
To: Tommaso Merciai <tomm.merciai@gmail.com>
Cc: martin.hecht@avnet.eu, michael.roeder@avnet.eu,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] media: i2c: alvium: Move V4L2_CID_GAIN to
 V4L2_CID_ANALOG_GAIN
Message-ID: <ZitUAsBgoxLG_vEx@valkosipuli.retiisi.eu>
References: <20240416141905.454253-1-tomm.merciai@gmail.com>
 <20240416141905.454253-6-tomm.merciai@gmail.com>
 <ZilLThyqHC2xi6tS@valkosipuli.retiisi.eu>
 <ZitTL/IhmuvwF2Qu@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZitTL/IhmuvwF2Qu@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>

Hi Tommaso,

On Fri, Apr 26, 2024 at 09:09:35AM +0200, Tommaso Merciai wrote:
> Hi Sakari,
> Thanks for your review.
> 
> On Wed, Apr 24, 2024 at 06:11:26PM +0000, Sakari Ailus wrote:
> > Hi Tommaso,
> > 
> > On Tue, Apr 16, 2024 at 04:19:05PM +0200, Tommaso Merciai wrote:
> > > Into alvium cameras REG_BCRM_GAIN_RW control the analog gain.
> > > Let's use the right V4L2_CID_ANALOGUE_GAIN ctrl.
> > > 
> > > Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> > > ---
> > >  drivers/media/i2c/alvium-csi2.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/media/i2c/alvium-csi2.c b/drivers/media/i2c/alvium-csi2.c
> > > index 30ef9b905211..56d64f27df72 100644
> > > --- a/drivers/media/i2c/alvium-csi2.c
> > > +++ b/drivers/media/i2c/alvium-csi2.c
> > > @@ -1993,7 +1993,7 @@ static int alvium_g_volatile_ctrl(struct v4l2_ctrl *ctrl)
> > >  	int val;
> > >  
> > >  	switch (ctrl->id) {
> > > -	case V4L2_CID_GAIN:
> > > +	case V4L2_CID_ANALOGUE_GAIN:
> > >  		val = alvium_get_gain(alvium);
> > >  		if (val < 0)
> > >  			return val;
> > > @@ -2025,7 +2025,7 @@ static int alvium_s_ctrl(struct v4l2_ctrl *ctrl)
> > >  		return 0;
> > >  
> > >  	switch (ctrl->id) {
> > > -	case V4L2_CID_GAIN:
> > > +	case V4L2_CID_ANALOGUE_GAIN:
> > >  		ret = alvium_set_ctrl_gain(alvium, ctrl->val);
> > >  		break;
> > >  	case V4L2_CID_AUTOGAIN:
> > > @@ -2154,7 +2154,7 @@ static int alvium_ctrl_init(struct alvium_dev *alvium)
> > >  
> > >  	if (alvium->avail_ft.gain) {
> > >  		ctrls->gain = v4l2_ctrl_new_std(hdl, ops,
> > > -						V4L2_CID_GAIN,
> > > +						V4L2_CID_ANALOGUE_GAIN,
> > >  						alvium->min_gain,
> > >  						alvium->max_gain,
> > >  						alvium->inc_gain,
> > 
> > This looks like a bugfix. Shouldn't it be cc'd to stable as well? A Fixes:
> > tag would be nice, too.
> 
> Fully agree.
> Plan is to add in v2 Fixes: 0a7af872915e ("media: i2c: Add support for alvium camera")
> like you suggest and stable@vger.kernel.org in CC.

Just make sure git send-email won't actually cc the patch to the stable
e-mail address. Cc: tag is enough. The git config option is
sendemail.suppresscc.

-- 
Regards,

Sakari Ailus

