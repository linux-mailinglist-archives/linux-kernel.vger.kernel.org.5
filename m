Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBFA7751F1A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 12:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbjGMKjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 06:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234164AbjGMKjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 06:39:19 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B7D1FC0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 03:39:18 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-666eb03457cso342542b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 03:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689244757; x=1691836757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1RMUdRrYgBqgRdaOkRVx+gnbgFUNeS+s8UkiVmpAYVw=;
        b=AMcR2tawYF7YHC3lExbXpSpIvXV7FEabeMgTGBRQhbvUaU8z8T3ybhrx+5IU2jSWja
         VbnD5H9UPRmICfffgdQL4r4K2ngA9Rf6CbopwpfiTC/xO3rGxn2DV1bgzc9lIKHD034i
         pGODfKic4v/r0oSrreLN4s3PbcS5q1dvIu32o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689244757; x=1691836757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1RMUdRrYgBqgRdaOkRVx+gnbgFUNeS+s8UkiVmpAYVw=;
        b=ZwYvVmPAW/16cOqbII61REWrVCedISEtf8TtN5vUZx2cC+GQPPBB6Z2xThGunGIWVh
         WPjPmAzKY1Im3GLclQy+CzMTW/0VBSuOfotxvHqFwSBrLr2vI2haMF4q3QujcQ3BYgfA
         GScyLuIFISzE5U+fVa2r6Yo2SB7wWnFI78XqOHMK1vXrkTPsdyAsdTxWwfJxSH6tDUhU
         g8ppazyeXDkzIX+exIs2vuw1vZp99dYCaCPfNL9gsFe/qItcrh/O/MD2M/V0SDcSWkAt
         b6z2GTX9jzKyBk7jOUIti/ipqGe36yxPmePqi7rMvp6l4yquO00+yMHnTXClF6H/TSNu
         17eA==
X-Gm-Message-State: ABy/qLZtTXjB8NCqiL4UDA48N0jR4l/mdhkVkxeVFQEcfXp9q5ewT38z
        WWAZGMzjcLoCQZ3jLmKFytS1CGQS83Gdc8WIe4gTlFu7
X-Google-Smtp-Source: APBJJlGfYB8jCZQ4kYstrs+JEJ8tsTxcaqIq9sCmzpr7ZDgXZaRgds32Y6fBxMHNTEbTdym0bmt6zg==
X-Received: by 2002:a05:6a00:189c:b0:63d:3339:e967 with SMTP id x28-20020a056a00189c00b0063d3339e967mr890139pfh.19.1689244757497;
        Thu, 13 Jul 2023 03:39:17 -0700 (PDT)
Received: from chromium.org (0.223.81.34.bc.googleusercontent.com. [34.81.223.0])
        by smtp.gmail.com with ESMTPSA id bt19-20020a632913000000b0054ff075fb31sm5196261pgb.42.2023.07.13.03.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 03:39:16 -0700 (PDT)
Date:   Thu, 13 Jul 2023 10:39:12 +0000
From:   Tomasz Figa <tfiga@chromium.org>
To:     ayaka <ayaka@soulik.info>
Cc:     linux-media@vger.kernel.org, randy.li@synaptics.com,
        Brian.Starkey@arm.com, boris.brezillon@collabora.com,
        frkoenig@chromium.org, hans.verkuil@cisco.com, hiroh@chromium.org,
        hverkuil@xs4all.nl, kernel@collabora.com,
        laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, narmstrong@baylibre.com, nicolas@ndufresne.ca,
        sakari.ailus@iki.fi, stanimir.varbanov@linaro.org,
        Helen Koike <helen.koike@collabora.com>
Subject: Re: [PATCH v7 2/9] media: vivid: Convert to v4l2_ext_pix_format
Message-ID: <20230713103912.favcnhqwjkzvsa6b@chromium.org>
References: <20230206043308.28365-1-ayaka@soulik.info>
 <20230206043308.28365-3-ayaka@soulik.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206043308.28365-3-ayaka@soulik.info>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 12:33:01PM +0800, ayaka wrote:
> From: Helen Koike <helen.koike@collabora.com>
> 
> Simplify Multi/Single planer API handling by converting to v4l2_ext_pix_format.
> 
> Duplicate v4l2_ioctl_ops for touch devices. This is done to force the
> framework to use the ext hooks when the classic Api is used from
> userspace in Vid devices, and to keep touch devices with classic hook.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Helen Koike <helen.koike@collabora.com>
> ---
> Changes in v7:
> - Force the userspace using the new APIs to operate non-touch drivers.

The primary objective of Linux development is not to break the
userspace. We can't just remove the old API, especially not from
existing drivers.

[snip]
>  int vivid_try_fmt_vid_cap(struct file *file, void *priv,
> -			struct v4l2_format *f)
> +			  struct v4l2_ext_pix_format *f)
>  {
> -	struct v4l2_pix_format_mplane *mp = &f->fmt.pix_mp;
> -	struct v4l2_plane_pix_format *pfmt = mp->plane_fmt;
>  	struct vivid_dev *dev = video_drvdata(file);
> +	struct v4l2_plane_pix_format *pfmt = f->plane_fmt;
>  	const struct vivid_fmt *fmt;
>  	unsigned bytesperline, max_bpl;
>  	unsigned factor = 1;
>  	unsigned w, h;
>  	unsigned p;
> -	bool user_set_csc = !!(mp->flags & V4L2_PIX_FMT_FLAG_SET_CSC);

Why is this condition being removed?

Best regards,
Tomasz

>  
> -	fmt = vivid_get_format(dev, mp->pixelformat);
> +	fmt = vivid_get_format(dev, f->pixelformat);
>  	if (!fmt) {
>  		dprintk(dev, 1, "Fourcc format (0x%08x) unknown.\n",
> -			mp->pixelformat);
> -		mp->pixelformat = V4L2_PIX_FMT_YUYV;
> -		fmt = vivid_get_format(dev, mp->pixelformat);
> +			f->pixelformat);
> +		f->pixelformat = V4L2_PIX_FMT_YUYV;
> +		fmt = vivid_get_format(dev, f->pixelformat);
>  	}
>  
> -	mp->field = vivid_field_cap(dev, mp->field);
> +	f->field = vivid_field_cap(dev, f->field);
>  	if (vivid_is_webcam(dev)) {
>  		const struct v4l2_frmsize_discrete *sz =
>  			v4l2_find_nearest_size(webcam_sizes,
>  					       VIVID_WEBCAM_SIZES, width,
> -					       height, mp->width, mp->height);
> +					       height, f->width, f->height);
>  
>  		w = sz->width;
>  		h = sz->height;
> @@ -604,14 +603,14 @@ int vivid_try_fmt_vid_cap(struct file *file, void *priv,
>  		w = dev->src_rect.width;
>  		h = dev->src_rect.height;
>  	}
> -	if (V4L2_FIELD_HAS_T_OR_B(mp->field))
> +	if (V4L2_FIELD_HAS_T_OR_B(f->field))
>  		factor = 2;
>  	if (vivid_is_webcam(dev) ||
>  	    (!dev->has_scaler_cap && !dev->has_crop_cap && !dev->has_compose_cap)) {
> -		mp->width = w;
> -		mp->height = h / factor;
> +		f->width = w;
> +		f->height = h / factor;
>  	} else {
> -		struct v4l2_rect r = { 0, 0, mp->width, mp->height * factor };
> +		struct v4l2_rect r = { 0, 0, f->width, f->height * factor };
>  
>  		v4l2_rect_set_min_size(&r, &vivid_min_rect);
>  		v4l2_rect_set_max_size(&r, &vivid_max_rect);
> @@ -624,16 +623,15 @@ int vivid_try_fmt_vid_cap(struct file *file, void *priv,
>  		} else if (!dev->has_scaler_cap && !dev->has_crop_cap) {
>  			v4l2_rect_set_min_size(&r, &dev->src_rect);
>  		}
> -		mp->width = r.width;
> -		mp->height = r.height / factor;
> +		f->width = r.width;
> +		f->height = r.height / factor;
>  	}
>  
>  	/* This driver supports custom bytesperline values */
>  
> -	mp->num_planes = fmt->buffers;
>  	for (p = 0; p < fmt->buffers; p++) {
>  		/* Calculate the minimum supported bytesperline value */
> -		bytesperline = (mp->width * fmt->bit_depth[p]) >> 3;
> +		bytesperline = (f->width * fmt->bit_depth[p]) >> 3;
>  		/* Calculate the maximum supported bytesperline value */
>  		max_bpl = (MAX_ZOOM * MAX_WIDTH * fmt->bit_depth[p]) >> 3;
>  
> @@ -642,48 +640,49 @@ int vivid_try_fmt_vid_cap(struct file *file, void *priv,
>  		if (pfmt[p].bytesperline < bytesperline)
>  			pfmt[p].bytesperline = bytesperline;
>  
> -		pfmt[p].sizeimage = (pfmt[p].bytesperline * mp->height) /
> +		pfmt[p].sizeimage = (pfmt[p].bytesperline * f->height) /
>  				fmt->vdownsampling[p] + fmt->data_offset[p];
> -
> -		memset(pfmt[p].reserved, 0, sizeof(pfmt[p].reserved));
>  	}
> +
> +	if (p < VIDEO_MAX_PLANES)
> +		pfmt[p].sizeimage = 0;
> +
>  	for (p = fmt->buffers; p < fmt->planes; p++)
> -		pfmt[0].sizeimage += (pfmt[0].bytesperline * mp->height *
> +		pfmt[0].sizeimage += (pfmt[0].bytesperline * f->height *
>  			(fmt->bit_depth[p] / fmt->vdownsampling[p])) /
>  			(fmt->bit_depth[0] / fmt->vdownsampling[0]);
>  
> -	if (!user_set_csc || !v4l2_is_colorspace_valid(mp->colorspace))
> -		mp->colorspace = vivid_colorspace_cap(dev);
> +	if (!v4l2_is_colorspace_valid(f->colorspace))
> +		f->colorspace = vivid_colorspace_cap(dev);
>  
> -	if (!user_set_csc || !v4l2_is_xfer_func_valid(mp->xfer_func))
> -		mp->xfer_func = vivid_xfer_func_cap(dev);
> +	if (!v4l2_is_xfer_func_valid(f->xfer_func))
> +		f->xfer_func = vivid_xfer_func_cap(dev);
>  
>  	if (fmt->color_enc == TGP_COLOR_ENC_HSV) {
> -		if (!user_set_csc || !v4l2_is_hsv_enc_valid(mp->hsv_enc))
> -			mp->hsv_enc = vivid_hsv_enc_cap(dev);
> +		if (!v4l2_is_hsv_enc_valid(f->hsv_enc))
> +			f->hsv_enc = vivid_hsv_enc_cap(dev);
>  	} else if (fmt->color_enc == TGP_COLOR_ENC_YCBCR) {
> -		if (!user_set_csc || !v4l2_is_ycbcr_enc_valid(mp->ycbcr_enc))
> -			mp->ycbcr_enc = vivid_ycbcr_enc_cap(dev);
> +		if (!v4l2_is_ycbcr_enc_valid(f->ycbcr_enc))
> +			f->ycbcr_enc = vivid_ycbcr_enc_cap(dev);
>  	} else {
> -		mp->ycbcr_enc = vivid_ycbcr_enc_cap(dev);
> +		f->ycbcr_enc = vivid_ycbcr_enc_cap(dev);
>  	}
>  
>  	if (fmt->color_enc == TGP_COLOR_ENC_YCBCR ||
>  	    fmt->color_enc == TGP_COLOR_ENC_RGB) {
> -		if (!user_set_csc || !v4l2_is_quant_valid(mp->quantization))
> -			mp->quantization = vivid_quantization_cap(dev);
> +		if (!v4l2_is_quant_valid(f->quantization))
> +			f->quantization = vivid_quantization_cap(dev);
>  	} else {
> -		mp->quantization = vivid_quantization_cap(dev);
> +		f->quantization = vivid_quantization_cap(dev);
>  	}
>  
> -	memset(mp->reserved, 0, sizeof(mp->reserved));
> +	memset(f->reserved, 0, sizeof(f->reserved));
>  	return 0;
>  }
[snip]
