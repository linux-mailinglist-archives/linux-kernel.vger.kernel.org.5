Return-Path: <linux-kernel+bounces-96926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BB587633E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A57021F22704
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F6C56443;
	Fri,  8 Mar 2024 11:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjZNPKT7"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCA63C24;
	Fri,  8 Mar 2024 11:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709897112; cv=none; b=m1MXiTrcDz+UTh4HP3RvLVchsIdZXWn3ceaBtmoerbXJw38RM0DGSh/FKows3g+xnIiCTTmLWSmD+xWniqqga5zwruKPJ48o8RnZtweQyaRJ4oSchJaO6FzCqVsbUnx1d6nJ+P1OQYR+6h1Xr0HpUV5H1MdyvcAtwEU7oIvw2i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709897112; c=relaxed/simple;
	bh=o2hNrgL13/sLtHdBP4TmsgTiEkFTQ3vVc2NOhew4J4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PqVztLJ4wEYHjaTboAXzqDiNFxoXzlXpe1j+uvTzibeLtw7b+K0Yx17z9d4C+GHkCwHw+yYCIsHeNlzg0XbuUNJe/FH2TDsndKZ9+a5VhPQ7FzBC7HDiyZj89wbC1DKcgvEg5+WkL3uUg5joPe1VJJpt/GZdxQayml123376Op8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fjZNPKT7; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d2ab9c5e83so17952701fa.2;
        Fri, 08 Mar 2024 03:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709897108; x=1710501908; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sZEG5PQAxEQMJdi4y7r2f556cfCDtnRfMruM9cmX0as=;
        b=fjZNPKT7Ps2YmPxxkCl7XBDrBQzcguq6Bq1Ur+hp9z5ymZU3/YVrUiA7OvbYPQZhsx
         y1gJ6gVuJG7tYtTdM4ylND8BpptPadhpjIIk7BVMnxcwgK52R4+SH/bqxPhFwrH/c/S6
         sF5bvoDzYFpALvnsmUAQzhLKdllhH7q3/lIV+djqEkk28hREuhOu3fzi27+FZi+Wm1HU
         1xe+rr+OGIhHR54Esq/3OBRMS3JrfuDcIq1LfrguHWgZo/UjVDURC7DQ8D6OzLWHmRq1
         uH3GlDuoC+JYOTlgFDZfmzoRgResAHLC62hMVmpel4Gc2CqnU8jfshSMTaDSr1HpyHmL
         zFXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709897108; x=1710501908;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sZEG5PQAxEQMJdi4y7r2f556cfCDtnRfMruM9cmX0as=;
        b=P8D8C3Qko+lVbZPUTK4bax+YrYDdTVQcVJ90+zoH/VcXjMpTMIBllHaR+xaOiu338x
         HaWdQrV55froQ0VmDl1RRN5mRilRXwdFqgXXz9IfUW/Mp1C0taJFiwd82EfgVRAAe/7Q
         EXLazLwv0R46jXQyQb+c/sPc+T1uvUkavf7MKT0H9jABDwp83ynzdOYk58v3TuYKIBmA
         0xHgSELIQLe0OP/3oEiy6AtF6DcGgwB2JY44VQmQc5lcPgtFM1Ff7XdJm+Jw+j1gp6CP
         NpWsB9mSXIJPgAOdkcmeyF6qEFYDGPGLyUvwmTkDj/0P+YBpivwQ+b4vRw6gvsWZQOrA
         19/w==
X-Forwarded-Encrypted: i=1; AJvYcCXempQs7L/LRqBzZJrO1SwpZ0+lKsC7PDd9rMdRLh80zaxtApIKwmGQ9YICSplIA1f9PFBYXxc7OcZzTIzBe6n0ymdhc0ejZbLRP1z2
X-Gm-Message-State: AOJu0YxgHwQERKjsWAFSOfIkEEyKf93J6YgiFkdlg1s2/6fEdpv2hmBr
	MpK9Nx/vMhhnN4Brv3hRrirwGW3J5MIUgy7Fm5AQvmdEJERL0lb+vhuoLUFGlck=
X-Google-Smtp-Source: AGHT+IEeplHr/QBHhr5GpCgqcEdkoivlC4i/RyyWQPsFh/o5fRlVuchcWc0P9iwLjjrdnMRGr0l85g==
X-Received: by 2002:a2e:8945:0:b0:2d2:4160:bb73 with SMTP id b5-20020a2e8945000000b002d24160bb73mr3674359ljk.3.1709897107640;
        Fri, 08 Mar 2024 03:25:07 -0800 (PST)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation (net-188-217-49-82.cust.vodafonedsl.it. [188.217.49.82])
        by smtp.gmail.com with ESMTPSA id b20-20020a0564021f1400b00567fa27e75fsm2415001edb.32.2024.03.08.03.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 03:25:07 -0800 (PST)
Date: Fri, 8 Mar 2024 12:25:05 +0100
From: Tommaso Merciai <tomm.merciai@gmail.com>
To: Umang Jain <umang.jain@ideasonboard.com>
Cc: linux-media@vger.kernel.org,
	Alexander Shiyan <eagle.alexander923@gmail.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	open list <linux-kernel@vger.kernel.org>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH v2 6/6] media: imx335: Limit analogue gain value
Message-ID: <Zer1kQvdA+Nf9KG1@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
References: <20240308083312.90279-1-umang.jain@ideasonboard.com>
 <20240308083312.90279-7-umang.jain@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308083312.90279-7-umang.jain@ideasonboard.com>

Hi Umang,

On Fri, Mar 08, 2024 at 02:03:12PM +0530, Umang Jain wrote:
> The sensor gain (both analog and digital) are controlled by a
> single gain value where:
> - 0dB to 30dB correspond to analog gain
> - 30.3dB to 72dB correspond to digital gain
>   (with 0.3dB step)
> 
> Hence, limit the analogue gain value to 100.
> For digital gain, support can be added later if needed.
> 
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
> ---
>  drivers/media/i2c/imx335.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/i2c/imx335.c b/drivers/media/i2c/imx335.c
> index 85cb53e3d5d4..cc59f446cd09 100644
> --- a/drivers/media/i2c/imx335.c
> +++ b/drivers/media/i2c/imx335.c
> @@ -53,7 +53,7 @@
>  /* Analog gain control */
>  #define IMX335_REG_AGAIN		CCI_REG8(0x30e8)
>  #define IMX335_AGAIN_MIN		0
> -#define IMX335_AGAIN_MAX		240
> +#define IMX335_AGAIN_MAX		100
>  #define IMX335_AGAIN_STEP		1
>  #define IMX335_AGAIN_DEFAULT		0
>  
> @@ -1174,6 +1174,14 @@ static int imx335_init_controls(struct imx335 *imx335)
>  					     IMX335_EXPOSURE_STEP,
>  					     IMX335_EXPOSURE_DEFAULT);
>  
> +	/*
> +	 * The sensor has an analog gain and a digital gain, both controlled
> +	 * through a single gain value, expressed in 0.3dB increments. Values
> +	 * from 0.0dB (0) to 30.0dB (100) apply analog gain only, higher values
> +	 * up to 72.0dB (240) add further digital gain. Limit the range to
> +	 * analog gain only, support for digital gain can be added separately
> +	 * if needed.
> +	 */
>  	imx335->again_ctrl = v4l2_ctrl_new_std(ctrl_hdlr,
>  					       &imx335_ctrl_ops,
>  					       V4L2_CID_ANALOGUE_GAIN,
> -- 
> 2.43.0
> 
> 

Unfortunately I don't have the datasheet of this sensor but the logic
behind this patch looks good to me. :)

Btw I check the datasheet of IMX323LQN-C and the gain controll logic
it's pretty similar except for the values in dB (different sensor).
Hope this help.

Reviewed-by: Tommaso Merciai <tomm.merciai@gmail.com>

Thanks & Regards,
Tommaso




