Return-Path: <linux-kernel+bounces-157446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 055198B11C1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 290101C22973
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C997C16DEAD;
	Wed, 24 Apr 2024 18:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="vXQA+5zB"
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096BC15CD6E;
	Wed, 24 Apr 2024 18:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713982292; cv=pass; b=UFXwW4avlwlCnO07LRJzKLNDiGBmE07ekivP0BWyiYB4UhrZZl3BK8WHHcm5BbEnKN/L7Ze0Rl87mD2eLBxILciQx+4jDopMJCvpHIK5Bf9zE+iNVyb8ZzoUKcJrtcwSsydqsuGKh0T3Wt8ehmDCPYVe3VI+28efDVbafzq18kE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713982292; c=relaxed/simple;
	bh=YuMPaHPqNibZHA6Se9urO80Bt5thoeq1ER3Z0HIzVDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lybbVETXu7LnDsd8Z67H9ocHdUgPYK3HiuEUDFDxgIdMg/7gnfbh8PXIocE/42Q6b/2rsW0341QFaKRJOm8KrXm1QDTyOa2D7XyI4Eo4fxOQeyu0f1N11pHykRqC28GxWAcMsAuPASzVLYdWad49K4j5/sXGihKAGfMotTIR43o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=vXQA+5zB; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from hillosipuli.retiisi.eu (2a00-1190-d1dd-0-c641-1eff-feae-163c.v6.cust.suomicom.net [IPv6:2a00:1190:d1dd:0:c641:1eff:feae:163c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sailus)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4VPn9q1LKPzywx;
	Wed, 24 Apr 2024 21:11:27 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1713982287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UYtJCoxUGrL5giyoGkeYRn8AtzfAZ7rSg46L8FTXQ44=;
	b=vXQA+5zBkl/r6GR/v7HgzZwT9Ro/+40D0FyrqhVyeRobvm4RbGLAlIrz7eMaKKBzaBwia5
	iJNOuW174lsP6bsOd7w3Ous2TEdAH1O8Srny54/lsVx07HLgixSyK12kwI/8FajkeGj4BQ
	jF0stFe3pk4Ym8va40eFaqeM4UvexLU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1713982287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UYtJCoxUGrL5giyoGkeYRn8AtzfAZ7rSg46L8FTXQ44=;
	b=Geutcv6EildU8AKd6jXWRyQGv6L2aDJKAmY0lkCgWaCGKJ6HRilWtwJ2geBk/OeGDnkyGC
	M7Le/EI9tFiTAoo2U8WjBra3vfcyctq1SuCgz2TrEnc6MgdXuu6lah7bNKtb4YO9fQlD9d
	PbaxwP6NvXm0WPLoZ/plDXgR+LMtKlY=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1713982287; a=rsa-sha256; cv=none;
	b=KpgHdFI2QsgC08Hmvu7f1UZn+PesOLluWmGjx0qX/VTrn5Y00ajPmg3H4AVLhLQJXggTO7
	B9WLtzxAPFIbtiyFwooRG1h++1Ub34sCOPLJj4x1CxHFWvxz+LlV90nbIPFRjrez1fsxYW
	/6HK5tqOLpMVZbSRcUCn2YPGHnh8q4U=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 06042634C96;
	Wed, 24 Apr 2024 21:11:27 +0300 (EEST)
Date: Wed, 24 Apr 2024 18:11:26 +0000
From: Sakari Ailus <sakari.ailus@iki.fi>
To: Tommaso Merciai <tomm.merciai@gmail.com>
Cc: martin.hecht@avnet.eu, michael.roeder@avnet.eu,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] media: i2c: alvium: Move V4L2_CID_GAIN to
 V4L2_CID_ANALOG_GAIN
Message-ID: <ZilLThyqHC2xi6tS@valkosipuli.retiisi.eu>
References: <20240416141905.454253-1-tomm.merciai@gmail.com>
 <20240416141905.454253-6-tomm.merciai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416141905.454253-6-tomm.merciai@gmail.com>

Hi Tommaso,

On Tue, Apr 16, 2024 at 04:19:05PM +0200, Tommaso Merciai wrote:
> Into alvium cameras REG_BCRM_GAIN_RW control the analog gain.
> Let's use the right V4L2_CID_ANALOGUE_GAIN ctrl.
> 
> Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> ---
>  drivers/media/i2c/alvium-csi2.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/i2c/alvium-csi2.c b/drivers/media/i2c/alvium-csi2.c
> index 30ef9b905211..56d64f27df72 100644
> --- a/drivers/media/i2c/alvium-csi2.c
> +++ b/drivers/media/i2c/alvium-csi2.c
> @@ -1993,7 +1993,7 @@ static int alvium_g_volatile_ctrl(struct v4l2_ctrl *ctrl)
>  	int val;
>  
>  	switch (ctrl->id) {
> -	case V4L2_CID_GAIN:
> +	case V4L2_CID_ANALOGUE_GAIN:
>  		val = alvium_get_gain(alvium);
>  		if (val < 0)
>  			return val;
> @@ -2025,7 +2025,7 @@ static int alvium_s_ctrl(struct v4l2_ctrl *ctrl)
>  		return 0;
>  
>  	switch (ctrl->id) {
> -	case V4L2_CID_GAIN:
> +	case V4L2_CID_ANALOGUE_GAIN:
>  		ret = alvium_set_ctrl_gain(alvium, ctrl->val);
>  		break;
>  	case V4L2_CID_AUTOGAIN:
> @@ -2154,7 +2154,7 @@ static int alvium_ctrl_init(struct alvium_dev *alvium)
>  
>  	if (alvium->avail_ft.gain) {
>  		ctrls->gain = v4l2_ctrl_new_std(hdl, ops,
> -						V4L2_CID_GAIN,
> +						V4L2_CID_ANALOGUE_GAIN,
>  						alvium->min_gain,
>  						alvium->max_gain,
>  						alvium->inc_gain,

This looks like a bugfix. Shouldn't it be cc'd to stable as well? A Fixes:
tag would be nice, too.

-- 
Regards,

Sakari Ailus

