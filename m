Return-Path: <linux-kernel+bounces-94037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 444D28738E4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEF872832EF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC661332B1;
	Wed,  6 Mar 2024 14:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pK81bOb2"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7838F132483
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 14:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709735022; cv=none; b=qdgb1mD2L2ibogkL06dXjt7+eOZY0IkAffDyBAn2GIFXklUY8puVAzLzVchtv0HdFre054eH226cqqRWGXI2dTTjNczOcfK1Eim5oDUmQQ1LAIUBv98ykL9UnzFRcxLkwKVnTdSdAA/rXKwA9kEFQfuJ2J0FVuOozqz34cDcaD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709735022; c=relaxed/simple;
	bh=wWtAyzQ2eyj1PNsc5Aylj7VkYcp64jWdRu1hy0W+UZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c07t1ixzYtCNwPah0CK1PMSjmfp2GpxBrRcumvvmenyKPsl6rTIwItTeVW3t2WD/sVEhzH/ubRNC5EfCdfMNgVJJe0gNwg/su9Z3RzwfZTtn/Am81JNyIwBArf/asp6cl4u7J1u9ZYOxTyD2SgAmVUTgPK59tAmKUcYLuC2mijE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pK81bOb2; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5135e8262e4so791167e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 06:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709735018; x=1710339818; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FWpAe22ZCtZ5eNl+BAwXkR2RWIIxHugyeXcFlN6Srtw=;
        b=pK81bOb2telD5nOir3KEUOzsJLnDI59javgao0O8wA0IQ702uHPL2ibrymCmJUlITO
         VDQHxM8VLjUDTNNQazVe3sTZAwKRNAC24n+2u+bw14LpF9yb8PMEtpV9Nt9+T1U6Yt+u
         NBW24drxqFzRL4+Vtq5X1KrOXloSOtR/vMH1fecBMCOqvjeJSxYraFthDFYsNACPawWG
         faJ+o9n0T+REGxIvdds/C+fLwNzVk4dtkJp0cf2FfbolYBMkfzSVY15M9+MMJBWByrWf
         F+sKlQEfuCVBDNiOe2kTPn6dMCbgxleYX3b3uUW9+YRgode6TmwTWWM0nq4mtkKSRV7c
         c8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709735018; x=1710339818;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FWpAe22ZCtZ5eNl+BAwXkR2RWIIxHugyeXcFlN6Srtw=;
        b=REGaYzDzbpfXA1hhnNJbXSdpMQy51lbmnIBnYY9nGkK9kGBgomCJqfi7bmg3kA2o44
         CWhoGurD/DxQeWdxRU9b2WbfWlSaoscDE2tZNT8PN2BqRbgwWcqFV1cRkN7bf0FpDGM1
         k0lNlGeeGkwzOLtihrmVqQqqrjqbOyGVCJRanJ60Ov1I7+hTmIOmUMKRnTSXmGY3VSnj
         qGZDEJD1SWK2P9BdQJB22MXkHrJwApnC+3ixFeNs5NdBD3INt+LdhQpmUZxXxjhWuVr9
         sEmxeMMi4y3+H+WGoAkaSjgBaUBX36ZFT4N3m1bROycwySOZp+uKAgO+2zu892a9oZBn
         1leA==
X-Forwarded-Encrypted: i=1; AJvYcCXU+ySf02KC/ehcK7Jvg6+vq1a90pSnDAZREFkaIXZCHj2lizej4WOjfhBgW/mTRxutZBLDyky779kmFlWWpXQ8pHqqrCrQ06LPfyf8
X-Gm-Message-State: AOJu0Ywa53jjcjfdQIE3et77Iiug+L5mGBFlfMBeZ/95Y5zKkREimvYZ
	f0Ct/CUR6HIRzItUmXMrxOQsaqVhos+mESiCMiAUPuk8i34QryGUKuZQBkmepF8=
X-Google-Smtp-Source: AGHT+IFEPqlIv/3Y/Zi3m//vC0Az3HmKtpwp8kiu+mg/iRghQHpj3gg8+eWTlQn1ycox43TLImj/XQ==
X-Received: by 2002:a19:3846:0:b0:513:3e1a:75af with SMTP id d6-20020a193846000000b005133e1a75afmr2876327lfj.16.1709735018288;
        Wed, 06 Mar 2024 06:23:38 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id t16-20020a05600c451000b00412ee12d4absm4838035wmo.31.2024.03.06.06.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 06:23:38 -0800 (PST)
Date: Wed, 6 Mar 2024 17:23:34 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Changhuang Liang <changhuang.liang@starfivetech.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Jack Zhu <jack.zhu@starfivetech.com>, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v1 2/7] staging: media: starfive: Add raw pad for ISP
Message-ID: <4d54e516-448a-47ce-abcd-e705896935a7@moroto.mountain>
References: <20240306093334.9321-1-changhuang.liang@starfivetech.com>
 <20240306093334.9321-3-changhuang.liang@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306093334.9321-3-changhuang.liang@starfivetech.com>

On Wed, Mar 06, 2024 at 01:33:29AM -0800, Changhuang Liang wrote:
> Add raw pad for ISP, it supported the conversion of RAW10 into RAW12.
> 

To be honest, I don't understand what "it supported the conversion of
RAW10 into RAW12" means.  I don't think that this patch has any impact
on user space but I'm not 100% sure.

A lot of this patch is just reformating stuff and it would be easier to
review if the reformating were separated into a separate patch.

patch 2: Clean pad selection in isp_try_format()

The code to select isp_dev->formats[] is overly complicated.  We can
just use the "pad" as the index.  This will making adding new pads
easier in future patches.  No functional change.

patch 3: Add raw pad for ISP

> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> ---
>  .../staging/media/starfive/camss/stf-isp.c    | 26 ++++++++++++-------
>  .../staging/media/starfive/camss/stf-isp.h    |  1 +
>  2 files changed, 17 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/staging/media/starfive/camss/stf-isp.c b/drivers/staging/media/starfive/camss/stf-isp.c
> index a5573abe0d7b..6bab0ac23120 100644
> --- a/drivers/staging/media/starfive/camss/stf-isp.c
> +++ b/drivers/staging/media/starfive/camss/stf-isp.c
> @@ -10,9 +10,6 @@
>  
>  #include "stf-camss.h"
>  
> -#define SINK_FORMATS_INDEX	0
> -#define SOURCE_FORMATS_INDEX	1
> -

This is cleanup.  patch 2.

>  static int isp_set_selection(struct v4l2_subdev *sd,
>  			     struct v4l2_subdev_state *state,
>  			     struct v4l2_subdev_selection *sel);
> @@ -28,9 +25,17 @@ static const struct stf_isp_format isp_formats_source[] = {
>  	{ MEDIA_BUS_FMT_YUYV8_1_5X8, 8 },
>  };
>  
> +static const struct stf_isp_format isp_formats_source_raw[] = {
> +	{ MEDIA_BUS_FMT_SRGGB12_1X12, 12 },
> +	{ MEDIA_BUS_FMT_SGRBG12_1X12, 12 },
> +	{ MEDIA_BUS_FMT_SGBRG12_1X12, 12 },
> +	{ MEDIA_BUS_FMT_SBGGR12_1X12, 12 },
> +};
> +

patch 3.

>  static const struct stf_isp_format_table isp_formats_st7110[] = {
>  	{ isp_formats_sink, ARRAY_SIZE(isp_formats_sink) },
>  	{ isp_formats_source, ARRAY_SIZE(isp_formats_source) },
> +	{ isp_formats_source_raw, ARRAY_SIZE(isp_formats_source_raw) },
>  };

patch 3.

>  
>  static const struct stf_isp_format *
> @@ -113,10 +118,7 @@ static void isp_try_format(struct stf_isp_dev *isp_dev,
>  		return;
>  	}
>  
> -	if (pad == STF_ISP_PAD_SINK)
> -		formats = &isp_dev->formats[SINK_FORMATS_INDEX];
> -	else if (pad == STF_ISP_PAD_SRC)
> -		formats = &isp_dev->formats[SOURCE_FORMATS_INDEX];
> +	formats = &isp_dev->formats[pad];

patch 2.

>  
>  	fmt->width = clamp_t(u32, fmt->width, STFCAMSS_FRAME_MIN_WIDTH,
>  			     STFCAMSS_FRAME_MAX_WIDTH);
> @@ -142,7 +144,7 @@ static int isp_enum_mbus_code(struct v4l2_subdev *sd,
>  		if (code->index >= ARRAY_SIZE(isp_formats_sink))
>  			return -EINVAL;
>  
> -		formats = &isp_dev->formats[SINK_FORMATS_INDEX];
> +		formats = &isp_dev->formats[code->pad];


patch 2.


>  		code->code = formats->fmts[code->index].code;
>  	} else {
>  		struct v4l2_mbus_framefmt *sink_fmt;
> @@ -281,8 +283,11 @@ static int isp_set_selection(struct v4l2_subdev *sd,
>  		crop.target = V4L2_SEL_TGT_CROP;
>  		crop.r = *rect;
>  		isp_set_selection(sd, state, &crop);
> +
> +		crop.pad = STF_ISP_PAD_SRC_RAW;
> +		isp_set_selection(sd, state, &crop);

patch 3.

>  	} else if (sel->target == V4L2_SEL_TGT_CROP &&
> -		   sel->pad == STF_ISP_PAD_SRC) {
> +		   (sel->pad == STF_ISP_PAD_SRC || sel->pad == STF_ISP_PAD_SRC_RAW)) {

patch 3.

>  		struct v4l2_subdev_format fmt = { 0 };
>  
>  		rect = v4l2_subdev_state_get_crop(state, sel->pad);
> @@ -294,7 +299,7 @@ static int isp_set_selection(struct v4l2_subdev *sd,
>  
>  		/* Reset source pad format width and height */
>  		fmt.which = sel->which;
> -		fmt.pad = STF_ISP_PAD_SRC;
> +		fmt.pad = sel->pad;

patch 2.

>  		fmt.format.width = rect->width;
>  		fmt.format.height = rect->height;
>  		isp_set_format(sd, state, &fmt);
> @@ -361,6 +366,7 @@ int stf_isp_register(struct stf_isp_dev *isp_dev, struct v4l2_device *v4l2_dev)
>  
>  	pads[STF_ISP_PAD_SINK].flags = MEDIA_PAD_FL_SINK;
>  	pads[STF_ISP_PAD_SRC].flags = MEDIA_PAD_FL_SOURCE;
> +	pads[STF_ISP_PAD_SRC_RAW].flags = MEDIA_PAD_FL_SOURCE;

patch 3.

>  
>  	sd->entity.function = MEDIA_ENT_F_PROC_VIDEO_ISP;
>  	sd->entity.ops = &isp_media_ops;
> diff --git a/drivers/staging/media/starfive/camss/stf-isp.h b/drivers/staging/media/starfive/camss/stf-isp.h
> index 07d6c2758253..4fc5cfac115c 100644
> --- a/drivers/staging/media/starfive/camss/stf-isp.h
> +++ b/drivers/staging/media/starfive/camss/stf-isp.h
> @@ -393,6 +393,7 @@
>  enum stf_isp_pad_id {
>  	STF_ISP_PAD_SINK = 0,
>  	STF_ISP_PAD_SRC,
> +	STF_ISP_PAD_SRC_RAW,

patch 3.

>  	STF_ISP_PAD_MAX
>  };

regards,
dan carpenter


