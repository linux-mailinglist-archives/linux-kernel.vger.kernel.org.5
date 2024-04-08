Return-Path: <linux-kernel+bounces-135188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0610E89BC74
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71DD01F22A13
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0F4524D9;
	Mon,  8 Apr 2024 09:58:17 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B992E4D110;
	Mon,  8 Apr 2024 09:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712570296; cv=none; b=IxsGtBw1+ftWhn7JCyWpJx77O33pspB/zxnR3gwIPeJ1EjtyPV/vbVUV8DZ6wCj0bEemLn2DdLsj2qf8BnuoEoHVNXYs68AVUatXEUeHUuGLusNd/+dESJ/fgw39a6FoBfXrYKTLoQ6uBt+IX+bSljzQEtINBtdWcvB2sI6/5vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712570296; c=relaxed/simple;
	bh=PDS8X9Y65r/Q+pj1LaSGsu/RIPAG3KpYpYjUQaGRiKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X5AtTVfq9DNEy8/IGWEfMzJqZHfT0BjhgdaRJ0okC/hNEZXlJLxRQL3piDqe2Xs5HEMCYO4wH9MFSylbjuuwII/lvavu7ASlHsIVFiZY3HPW2n89XmrlXoVRGSZTd3t2tZFSFLvAZw9vrLhgixYY9u59ja/7doCbnPsIsqcGAbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11720C433C7;
	Mon,  8 Apr 2024 09:58:14 +0000 (UTC)
Message-ID: <7bd3e051-418b-4b4a-ba57-644f829604c7@xs4all.nl>
Date: Mon, 8 Apr 2024 11:58:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] media: mgb4: Add support for YUV image formats
Content-Language: en-US, nl
To: tumic@gpxsee.org, Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Martin_T=C5=AFma?= <martin.tuma@digiteqautomotive.com>
References: <20240322151005.3499-1-tumic@gpxsee.org>
 <20240322151005.3499-2-tumic@gpxsee.org>
From: Hans Verkuil <hverkuil@xs4all.nl>
Autocrypt: addr=hverkuil@xs4all.nl; keydata=
 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
In-Reply-To: <20240322151005.3499-2-tumic@gpxsee.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Martin,

Just a few small comments:

On 22/03/2024 16:10, tumic@gpxsee.org wrote:
> From: Martin Tůma <martin.tuma@digiteqautomotive.com>
> 
> Recent mgb4 firmwares support YUV in addition to the RGB image format. Enable
> YUV in the driver when the FW supports it.
> 
> Signed-off-by: Martin Tůma <martin.tuma@digiteqautomotive.com>
> ---
>  drivers/media/pci/mgb4/mgb4_io.h   |   7 ++
>  drivers/media/pci/mgb4/mgb4_vin.c  | 116 ++++++++++++++++++++++++-----
>  drivers/media/pci/mgb4/mgb4_vout.c | 116 ++++++++++++++++++++++++-----
>  3 files changed, 203 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/media/pci/mgb4/mgb4_io.h b/drivers/media/pci/mgb4/mgb4_io.h
> index 8698db1be4a9..204613a6685c 100644
> --- a/drivers/media/pci/mgb4/mgb4_io.h
> +++ b/drivers/media/pci/mgb4/mgb4_io.h
> @@ -30,4 +30,11 @@ static inline struct mgb4_frame_buffer *to_frame_buffer(struct vb2_v4l2_buffer *
>  	return container_of(vbuf, struct mgb4_frame_buffer, vb);
>  }
>  
> +static inline bool has_yuv(struct mgb4_regs *video)
> +{
> +	u32 status = mgb4_read_reg(video, 0xD0);
> +
> +	return (status & (1U << 8));
> +}
> +
>  #endif
> diff --git a/drivers/media/pci/mgb4/mgb4_vin.c b/drivers/media/pci/mgb4/mgb4_vin.c
> index 2cd78c539889..19692e4dfb59 100644
> --- a/drivers/media/pci/mgb4/mgb4_vin.c
> +++ b/drivers/media/pci/mgb4/mgb4_vin.c
> @@ -186,8 +186,11 @@ static int queue_setup(struct vb2_queue *q, unsigned int *nbuffers,
>  		       struct device *alloc_devs[])
>  {
>  	struct mgb4_vin_dev *vindev = vb2_get_drv_priv(q);
> +	struct mgb4_regs *video = &vindev->mgbdev->video;
> +	u32 config = mgb4_read_reg(video, vindev->config->regs.config);
> +	u32 pixelsize = (config & (1U << 16)) ? 2 : 4;
>  	unsigned int size = (vindev->timings.bt.width + vindev->padding)
> -	 * vindev->timings.bt.height * 4;
> +			    * vindev->timings.bt.height * pixelsize;
>  
>  	/*
>  	 * If I/O reconfiguration is in process, do not allow to start
> @@ -220,9 +223,12 @@ static int buffer_init(struct vb2_buffer *vb)
>  static int buffer_prepare(struct vb2_buffer *vb)
>  {
>  	struct mgb4_vin_dev *vindev = vb2_get_drv_priv(vb->vb2_queue);
> +	struct mgb4_regs *video = &vindev->mgbdev->video;
>  	struct device *dev = &vindev->mgbdev->pdev->dev;
> +	u32 config = mgb4_read_reg(video, vindev->config->regs.config);
> +	u32 pixelsize = (config & (1U << 16)) ? 2 : 4;
>  	unsigned int size = (vindev->timings.bt.width + vindev->padding)
> -	 * vindev->timings.bt.height * 4;
> +			    * vindev->timings.bt.height * pixelsize;
>  
>  	if (vb2_plane_size(vb, 0) < size) {
>  		dev_err(dev, "buffer too small (%lu < %u)\n",
> @@ -359,22 +365,33 @@ static int vidioc_querycap(struct file *file, void *priv,
>  static int vidioc_enum_fmt(struct file *file, void *priv,
>  			   struct v4l2_fmtdesc *f)
>  {
> -	if (f->index != 0)
> -		return -EINVAL;
> +	struct mgb4_vin_dev *vindev = video_drvdata(file);
> +	struct mgb4_regs *video = &vindev->mgbdev->video;
>  
> -	f->pixelformat = V4L2_PIX_FMT_ABGR32;
> +	if (f->type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
> +		return -EINVAL;

No need to test for this, it is guaranteed to be correct (the v4l2 core handles
that).

>  
> -	return 0;
> +	if (f->index == 0) {
> +		f->pixelformat = V4L2_PIX_FMT_ABGR32;
> +		return 0;
> +	} else if (f->index == 1 && has_yuv(video)) {
> +		f->pixelformat = V4L2_PIX_FMT_YUYV;
> +		return 0;
> +	} else {
> +		return -EINVAL;
> +	}
>  }
>  
>  static int vidioc_enum_frameintervals(struct file *file, void *priv,
>  				      struct v4l2_frmivalenum *ival)
>  {
>  	struct mgb4_vin_dev *vindev = video_drvdata(file);
> +	struct mgb4_regs *video = &vindev->mgbdev->video;
>  
>  	if (ival->index != 0)
>  		return -EINVAL;
> -	if (ival->pixel_format != V4L2_PIX_FMT_ABGR32)
> +	if (!(ival->pixel_format == V4L2_PIX_FMT_ABGR32 ||
> +	      ((has_yuv(video) && ival->pixel_format == V4L2_PIX_FMT_YUYV))))
>  		return -EINVAL;
>  	if (ival->width != vindev->timings.bt.width ||
>  	    ival->height != vindev->timings.bt.height)
> @@ -393,13 +410,32 @@ static int vidioc_enum_frameintervals(struct file *file, void *priv,
>  static int vidioc_g_fmt(struct file *file, void *priv, struct v4l2_format *f)
>  {
>  	struct mgb4_vin_dev *vindev = video_drvdata(file);
> +	struct mgb4_regs *video = &vindev->mgbdev->video;
> +	u32 config = mgb4_read_reg(video, vindev->config->regs.config);
> +
> +	if (f->type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
> +		return -EINVAL;

No need for this test.

>  
> -	f->fmt.pix.pixelformat = V4L2_PIX_FMT_ABGR32;
>  	f->fmt.pix.width = vindev->timings.bt.width;
>  	f->fmt.pix.height = vindev->timings.bt.height;
>  	f->fmt.pix.field = V4L2_FIELD_NONE;
> -	f->fmt.pix.colorspace = V4L2_COLORSPACE_RAW;
> -	f->fmt.pix.bytesperline = (f->fmt.pix.width + vindev->padding) * 4;
> +
> +	if (config & (1U << 16)) {
> +		f->fmt.pix.pixelformat = V4L2_PIX_FMT_YUYV;
> +		if (config & (1U << 20)) {
> +			f->fmt.pix.colorspace = V4L2_COLORSPACE_REC709;
> +		} else {
> +			if (config & (1U << 19))
> +				f->fmt.pix.colorspace = V4L2_COLORSPACE_SMPTE170M;
> +			else
> +				f->fmt.pix.colorspace = V4L2_COLORSPACE_SRGB;
> +		}
> +		f->fmt.pix.bytesperline = (f->fmt.pix.width + vindev->padding) * 2;
> +	} else {
> +		f->fmt.pix.pixelformat = V4L2_PIX_FMT_ABGR32;
> +		f->fmt.pix.colorspace = V4L2_COLORSPACE_RAW;
> +		f->fmt.pix.bytesperline = (f->fmt.pix.width + vindev->padding) * 4;
> +	}
>  	f->fmt.pix.sizeimage = f->fmt.pix.bytesperline * f->fmt.pix.height;
>  
>  	return 0;
> @@ -408,14 +444,33 @@ static int vidioc_g_fmt(struct file *file, void *priv, struct v4l2_format *f)
>  static int vidioc_try_fmt(struct file *file, void *priv, struct v4l2_format *f)
>  {
>  	struct mgb4_vin_dev *vindev = video_drvdata(file);
> +	struct mgb4_regs *video = &vindev->mgbdev->video;
> +	u32 pixelsize;
> +
> +	if (f->type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
> +		return -EINVAL;

No need for this test.

>  
> -	f->fmt.pix.pixelformat = V4L2_PIX_FMT_ABGR32;
>  	f->fmt.pix.width = vindev->timings.bt.width;
>  	f->fmt.pix.height = vindev->timings.bt.height;
>  	f->fmt.pix.field = V4L2_FIELD_NONE;
> -	f->fmt.pix.colorspace = V4L2_COLORSPACE_RAW;
> -	f->fmt.pix.bytesperline = max(f->fmt.pix.width * 4,
> -				      ALIGN_DOWN(f->fmt.pix.bytesperline, 4));
> +
> +	if (has_yuv(video) && f->fmt.pix.pixelformat == V4L2_PIX_FMT_YUYV) {
> +		pixelsize = 2;
> +		if (!(f->fmt.pix.colorspace == V4L2_COLORSPACE_REC709 ||
> +		      f->fmt.pix.colorspace == V4L2_COLORSPACE_SMPTE170M))
> +			f->fmt.pix.colorspace = V4L2_COLORSPACE_SRGB;
> +	} else {
> +		pixelsize = 4;
> +		f->fmt.pix.pixelformat = V4L2_PIX_FMT_ABGR32;
> +		f->fmt.pix.colorspace = V4L2_COLORSPACE_RAW;
> +	}
> +
> +	if (f->fmt.pix.bytesperline > f->fmt.pix.width * pixelsize
> +	    && f->fmt.pix.bytesperline < f->fmt.pix.width * pixelsize * 2)

Put the '&&' at the end of the previous line instead. checkpatch warns on this.

> +		f->fmt.pix.bytesperline = ALIGN(f->fmt.pix.bytesperline,
> +						pixelsize);
> +	else
> +		f->fmt.pix.bytesperline = f->fmt.pix.width * pixelsize;
>  	f->fmt.pix.sizeimage = f->fmt.pix.bytesperline * f->fmt.pix.height;
>  
>  	return 0;
> @@ -425,13 +480,39 @@ static int vidioc_s_fmt(struct file *file, void *priv, struct v4l2_format *f)
>  {
>  	struct mgb4_vin_dev *vindev = video_drvdata(file);
>  	struct mgb4_regs *video = &vindev->mgbdev->video;
> +	u32 config, pixelsize;
> +	int ret;
>  
>  	if (vb2_is_busy(&vindev->queue))
>  		return -EBUSY;
>  
> -	vidioc_try_fmt(file, priv, f);
> +	ret = vidioc_try_fmt(file, priv, f);
> +	if (ret < 0)
> +		return ret;

It is better to move the 'vb2_is_busy()' call to after the try_fmt.

That way, even if the vb2 is busy, the fmt is still updated by the
try_fmt call.

> +
> +	config = mgb4_read_reg(video, vindev->config->regs.config);
> +	if (f->fmt.pix.pixelformat == V4L2_PIX_FMT_YUYV) {
> +		pixelsize = 2;
> +		config |= 1U << 16;
> +
> +		if (f->fmt.pix.colorspace == V4L2_COLORSPACE_REC709) {
> +			config |= 1U << 20;
> +			config |= 1U << 19;
> +		} else if (f->fmt.pix.colorspace == V4L2_COLORSPACE_SMPTE170M) {
> +			config &= ~(1U << 20);
> +			config |= 1U << 19;
> +		} else {
> +			config &= ~(1U << 20);
> +			config &= ~(1U << 19);
> +		}
> +	} else {
> +		pixelsize = 4;
> +		config &= ~(1U << 16);
> +	}
> +	mgb4_write_reg(video, vindev->config->regs.config, config);
>  
> -	vindev->padding = (f->fmt.pix.bytesperline - (f->fmt.pix.width * 4)) / 4;
> +	vindev->padding = (f->fmt.pix.bytesperline - (f->fmt.pix.width
> +			   * pixelsize)) / pixelsize;
>  	mgb4_write_reg(video, vindev->config->regs.padding, vindev->padding);
>  	set_loopback_padding(vindev, vindev->padding);
>  
> @@ -467,7 +548,8 @@ static int vidioc_enum_framesizes(struct file *file, void *fh,
>  {
>  	struct mgb4_vin_dev *vindev = video_drvdata(file);
>  
> -	if (fsize->index != 0 || fsize->pixel_format != V4L2_PIX_FMT_ABGR32)
> +	if (fsize->index != 0 || !(fsize->pixel_format == V4L2_PIX_FMT_ABGR32 ||
> +				   fsize->pixel_format == V4L2_PIX_FMT_YUYV))
>  		return -EINVAL;
>  
>  	fsize->discrete.width = vindev->timings.bt.width;
> diff --git a/drivers/media/pci/mgb4/mgb4_vout.c b/drivers/media/pci/mgb4/mgb4_vout.c
> index 241353ee77a5..243fbeaaceb9 100644
> --- a/drivers/media/pci/mgb4/mgb4_vout.c
> +++ b/drivers/media/pci/mgb4/mgb4_vout.c
> @@ -59,7 +59,11 @@ static int queue_setup(struct vb2_queue *q, unsigned int *nbuffers,
>  		       struct device *alloc_devs[])
>  {
>  	struct mgb4_vout_dev *voutdev = vb2_get_drv_priv(q);
> -	unsigned int size;
> +	struct mgb4_regs *video = &voutdev->mgbdev->video;
> +	u32 config = mgb4_read_reg(video, voutdev->config->regs.config);
> +	u32 pixelsize = (config & (1U << 16)) ? 2 : 4;
> +	unsigned int size = (voutdev->width + voutdev->padding) * voutdev->height
> +			    * pixelsize;
>  
>  	/*
>  	 * If I/O reconfiguration is in process, do not allow to start
> @@ -69,8 +73,6 @@ static int queue_setup(struct vb2_queue *q, unsigned int *nbuffers,
>  	if (test_bit(0, &voutdev->mgbdev->io_reconfig))
>  		return -EBUSY;
>  
> -	size = (voutdev->width + voutdev->padding) * voutdev->height * 4;
> -
>  	if (*nplanes)
>  		return sizes[0] < size ? -EINVAL : 0;
>  	*nplanes = 1;
> @@ -93,9 +95,11 @@ static int buffer_prepare(struct vb2_buffer *vb)
>  {
>  	struct mgb4_vout_dev *voutdev = vb2_get_drv_priv(vb->vb2_queue);
>  	struct device *dev = &voutdev->mgbdev->pdev->dev;
> -	unsigned int size;
> -
> -	size = (voutdev->width + voutdev->padding) * voutdev->height * 4;
> +	struct mgb4_regs *video = &voutdev->mgbdev->video;
> +	u32 config = mgb4_read_reg(video, voutdev->config->regs.config);
> +	u32 pixelsize = (config & (1U << 16)) ? 2 : 4;
> +	unsigned int size = (voutdev->width + voutdev->padding) * voutdev->height
> +			    * pixelsize;
>  
>  	if (vb2_plane_size(vb, 0) < size) {
>  		dev_err(dev, "buffer too small (%lu < %u)\n",
> @@ -194,24 +198,53 @@ static int vidioc_querycap(struct file *file, void *priv,
>  static int vidioc_enum_fmt(struct file *file, void *priv,
>  			   struct v4l2_fmtdesc *f)
>  {
> -	if (f->index != 0)
> -		return -EINVAL;
> +	struct mgb4_vin_dev *voutdev = video_drvdata(file);
> +	struct mgb4_regs *video = &voutdev->mgbdev->video;
>  
> -	f->pixelformat = V4L2_PIX_FMT_ABGR32;
> +	if (f->type != V4L2_BUF_TYPE_VIDEO_OUTPUT)
> +		return -EINVAL;

Test is not needed.

>  
> -	return 0;
> +	if (f->index == 0) {
> +		f->pixelformat = V4L2_PIX_FMT_ABGR32;
> +		return 0;
> +	} else if (f->index == 1 && has_yuv(video)) {
> +		f->pixelformat = V4L2_PIX_FMT_YUYV;
> +		return 0;
> +	} else {
> +		return -EINVAL;
> +	}
>  }
>  
>  static int vidioc_g_fmt(struct file *file, void *priv, struct v4l2_format *f)
>  {
>  	struct mgb4_vout_dev *voutdev = video_drvdata(file);
> +	struct mgb4_regs *video = &voutdev->mgbdev->video;
> +	u32 config = mgb4_read_reg(video, voutdev->config->regs.config);
> +
> +	if (f->type != V4L2_BUF_TYPE_VIDEO_OUTPUT)
> +		return -EINVAL;

Ditto.

>  
> -	f->fmt.pix.pixelformat = V4L2_PIX_FMT_ABGR32;
>  	f->fmt.pix.width = voutdev->width;
>  	f->fmt.pix.height = voutdev->height;
>  	f->fmt.pix.field = V4L2_FIELD_NONE;
> -	f->fmt.pix.colorspace = V4L2_COLORSPACE_RAW;
> -	f->fmt.pix.bytesperline = (f->fmt.pix.width + voutdev->padding) * 4;
> +
> +	if (config & (1U << 16)) {
> +		f->fmt.pix.pixelformat = V4L2_PIX_FMT_YUYV;
> +		if (config & (1U << 20)) {
> +			f->fmt.pix.colorspace = V4L2_COLORSPACE_REC709;
> +		} else {
> +			if (config & (1U << 19))
> +				f->fmt.pix.colorspace = V4L2_COLORSPACE_SMPTE170M;
> +			else
> +				f->fmt.pix.colorspace = V4L2_COLORSPACE_SRGB;
> +		}
> +		f->fmt.pix.bytesperline = (f->fmt.pix.width + voutdev->padding) * 2;
> +	} else {
> +		f->fmt.pix.pixelformat = V4L2_PIX_FMT_ABGR32;
> +		f->fmt.pix.colorspace = V4L2_COLORSPACE_RAW;
> +		f->fmt.pix.bytesperline = (f->fmt.pix.width + voutdev->padding) * 4;
> +	}
> +
>  	f->fmt.pix.sizeimage = f->fmt.pix.bytesperline * f->fmt.pix.height;
>  
>  	return 0;
> @@ -220,14 +253,33 @@ static int vidioc_g_fmt(struct file *file, void *priv, struct v4l2_format *f)
>  static int vidioc_try_fmt(struct file *file, void *priv, struct v4l2_format *f)
>  {
>  	struct mgb4_vout_dev *voutdev = video_drvdata(file);
> +	struct mgb4_regs *video = &voutdev->mgbdev->video;
> +	u32 pixelsize;
> +
> +	if (f->type != V4L2_BUF_TYPE_VIDEO_OUTPUT)
> +		return -EINVAL;

Ditto.

>  
> -	f->fmt.pix.pixelformat = V4L2_PIX_FMT_ABGR32;
>  	f->fmt.pix.width = voutdev->width;
>  	f->fmt.pix.height = voutdev->height;
>  	f->fmt.pix.field = V4L2_FIELD_NONE;
> -	f->fmt.pix.colorspace = V4L2_COLORSPACE_RAW;
> -	f->fmt.pix.bytesperline = max(f->fmt.pix.width * 4,
> -				      ALIGN_DOWN(f->fmt.pix.bytesperline, 4));
> +
> +	if (has_yuv(video) && f->fmt.pix.pixelformat == V4L2_PIX_FMT_YUYV) {
> +		pixelsize = 2;
> +		if (!(f->fmt.pix.colorspace == V4L2_COLORSPACE_REC709 ||
> +		      f->fmt.pix.colorspace == V4L2_COLORSPACE_SMPTE170M))
> +			f->fmt.pix.colorspace = V4L2_COLORSPACE_SRGB;
> +	} else {
> +		pixelsize = 4;
> +		f->fmt.pix.pixelformat = V4L2_PIX_FMT_ABGR32;
> +		f->fmt.pix.colorspace = V4L2_COLORSPACE_RAW;
> +	}
> +
> +	if (f->fmt.pix.bytesperline > f->fmt.pix.width * pixelsize
> +	    && f->fmt.pix.bytesperline < f->fmt.pix.width * pixelsize * 2)

Move '&&' to the end of the previous line.

> +		f->fmt.pix.bytesperline = ALIGN(f->fmt.pix.bytesperline,
> +						pixelsize);
> +	else
> +		f->fmt.pix.bytesperline = f->fmt.pix.width * pixelsize;
>  	f->fmt.pix.sizeimage = f->fmt.pix.bytesperline * f->fmt.pix.height;
>  
>  	return 0;
> @@ -237,13 +289,39 @@ static int vidioc_s_fmt(struct file *file, void *priv, struct v4l2_format *f)
>  {
>  	struct mgb4_vout_dev *voutdev = video_drvdata(file);
>  	struct mgb4_regs *video = &voutdev->mgbdev->video;
> +	u32 config, pixelsize;
> +	int ret;
>  
>  	if (vb2_is_busy(&voutdev->queue))
>  		return -EBUSY;
>  
> -	vidioc_try_fmt(file, priv, f);
> +	ret = vidioc_try_fmt(file, priv, f);
> +	if (ret < 0)
> +		return ret;

Move vb2_is_busy call to here.

> +
> +	config = mgb4_read_reg(video, voutdev->config->regs.config);
> +	if (f->fmt.pix.pixelformat == V4L2_PIX_FMT_YUYV) {
> +		pixelsize = 2;
> +		config |= 1U << 16;
> +
> +		if (f->fmt.pix.colorspace == V4L2_COLORSPACE_REC709) {
> +			config |= 1U << 20;
> +			config |= 1U << 19;
> +		} else if (f->fmt.pix.colorspace == V4L2_COLORSPACE_SMPTE170M) {
> +			config &= ~(1U << 20);
> +			config |= 1U << 19;
> +		} else {
> +			config &= ~(1U << 20);
> +			config &= ~(1U << 19);
> +		}
> +	} else {
> +		pixelsize = 4;
> +		config &= ~(1U << 16);
> +	}
> +	mgb4_write_reg(video, voutdev->config->regs.config, config);
>  
> -	voutdev->padding = (f->fmt.pix.bytesperline - (f->fmt.pix.width * 4)) / 4;
> +	voutdev->padding = (f->fmt.pix.bytesperline - (f->fmt.pix.width
> +			    * pixelsize)) / pixelsize;
>  	mgb4_write_reg(video, voutdev->config->regs.padding, voutdev->padding);
>  
>  	return 0;

Regards,

	Hans

