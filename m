Return-Path: <linux-kernel+bounces-135230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AC089BD6B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 100041F22FC3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A8A5FB8F;
	Mon,  8 Apr 2024 10:40:54 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCF55F86E;
	Mon,  8 Apr 2024 10:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712572852; cv=none; b=sn3rA31KXM0GeOfoBACHpJcdpHfFOC7FwQn7dXQqc4CoNdR/6eGUXzDDbWkGHjqRb/LuFEch7XukP6nGhf1LCGzmTdN8GvU3HMBKY+s0RvBMeZlBDLr4CrUrPQKLVHn9rN0eqls5EY3EH07ems7uM7Hegf3Bq/1Jr2I0TnRICek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712572852; c=relaxed/simple;
	bh=AUnoZlZP4UVCpbPXu2xme8aw/f8y8Wd2Vl12uD+FeMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GTG5YCR1VaRxrGGrEvKXw1vcRF9ijccTfyAB4X/4KF4EqSF1fuNBlrCZz3oQ7uN8pwsh8UBLA1xzEoCCUsSg7bBHWdCV70jW3HyCVYT3deA9UEZ/ZPxSY453YmxnqGc4862mRiHFFABjv/OZLXSVh6qnJOCHBS/QyZEn0eEYPE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2533AC433F1;
	Mon,  8 Apr 2024 10:40:50 +0000 (UTC)
Message-ID: <719603d4-cbc7-44e0-a216-0a9b652e96b3@xs4all.nl>
Date: Mon, 8 Apr 2024 12:40:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] media: mgb4: Add support for V4L2_CAP_TIMEPERFRAME
Content-Language: en-US, nl
To: tumic@gpxsee.org, Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Martin_T=C5=AFma?= <martin.tuma@digiteqautomotive.com>
References: <20240322151005.3499-1-tumic@gpxsee.org>
 <20240322151005.3499-3-tumic@gpxsee.org>
From: Hans Verkuil <hverkuil@xs4all.nl>
Autocrypt: addr=hverkuil@xs4all.nl; keydata=
 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
In-Reply-To: <20240322151005.3499-3-tumic@gpxsee.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 22/03/2024 16:10, tumic@gpxsee.org wrote:
> From: Martin Tůma <martin.tuma@digiteqautomotive.com>
> 
> Recent mgb4 firmwares have support for setting a variable framerate independent
> of the signal framerate. Add/fix (the mgb4 driver already did promote
> V4L2_CAP_TIMEPERFRAME, but it didn't work) support for V4L2_CAP_TIMEPERFRAME to
> the driver to enable this feature.

Both the subject line and commit message talk about V4L2_CAP_TIMEPERFRAME,
but most of the code is about adding dv_timings support. There is a mismatch
there.

And what do you mean with "variable framerate independent of the signal framerate"?

Does that mean that the firmware will skip or repeat frames depending on the
selected framerate?

While I do have a few comments below, I will postpone further review until
I have a clearer understanding of what the actual feature is that you are
implementing.

> 
> Signed-off-by: Martin Tůma <martin.tuma@digiteqautomotive.com>
> ---
>  drivers/media/pci/mgb4/mgb4_core.c      |   2 +-
>  drivers/media/pci/mgb4/mgb4_core.h      |   2 +
>  drivers/media/pci/mgb4/mgb4_io.h        |  24 ++-
>  drivers/media/pci/mgb4/mgb4_sysfs_out.c |   4 +-
>  drivers/media/pci/mgb4/mgb4_vin.c       |  89 ++++++++---
>  drivers/media/pci/mgb4/mgb4_vin.h       |   3 +-
>  drivers/media/pci/mgb4/mgb4_vout.c      | 196 +++++++++++++++++++++++-
>  drivers/media/pci/mgb4/mgb4_vout.h      |   3 +-
>  8 files changed, 287 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/media/pci/mgb4/mgb4_core.c b/drivers/media/pci/mgb4/mgb4_core.c
> index 5bfb8a06202e..9c6294009069 100644
> --- a/drivers/media/pci/mgb4/mgb4_core.c
> +++ b/drivers/media/pci/mgb4/mgb4_core.c
> @@ -302,7 +302,7 @@ static int init_i2c(struct mgb4_dev *mgbdev)
>  	/* create dummy clock required by the xiic-i2c adapter */
>  	snprintf(clk_name, sizeof(clk_name), "xiic-i2c.%d", id);
>  	mgbdev->i2c_clk = clk_hw_register_fixed_rate(NULL, clk_name, NULL,
> -						     0, 125000000);
> +						     0, MGB4_HW_FREQ);
>  	if (IS_ERR(mgbdev->i2c_clk)) {
>  		dev_err(dev, "failed to register I2C clock\n");
>  		return PTR_ERR(mgbdev->i2c_clk);
> diff --git a/drivers/media/pci/mgb4/mgb4_core.h b/drivers/media/pci/mgb4/mgb4_core.h
> index 2a946e46aec1..b52cd67270b5 100644
> --- a/drivers/media/pci/mgb4/mgb4_core.h
> +++ b/drivers/media/pci/mgb4/mgb4_core.h
> @@ -13,6 +13,8 @@
>  #include <linux/dmaengine.h>
>  #include "mgb4_regs.h"
>  
> +#define MGB4_HW_FREQ 125000000
> +
>  #define MGB4_VIN_DEVICES  2
>  #define MGB4_VOUT_DEVICES 2
>  
> diff --git a/drivers/media/pci/mgb4/mgb4_io.h b/drivers/media/pci/mgb4/mgb4_io.h
> index 204613a6685c..dd8696d7df31 100644
> --- a/drivers/media/pci/mgb4/mgb4_io.h
> +++ b/drivers/media/pci/mgb4/mgb4_io.h
> @@ -7,11 +7,9 @@
>  #ifndef __MGB4_IO_H__
>  #define __MGB4_IO_H__
>  
> +#include <linux/math64.h>
>  #include <media/v4l2-dev.h>
> -
> -#define MGB4_DEFAULT_WIDTH     1280
> -#define MGB4_DEFAULT_HEIGHT    640
> -#define MGB4_DEFAULT_PERIOD    (125000000 / 60)
> +#include "mgb4_core.h"
>  
>  /* Register access error indication */
>  #define MGB4_ERR_NO_REG        0xFFFFFFFE
> @@ -20,6 +18,9 @@
>  #define MGB4_ERR_QUEUE_EMPTY   0xFFFFFFFC
>  #define MGB4_ERR_QUEUE_FULL    0xFFFFFFFB
>  
> +#define MGB4_PERIOD(numerator, denominator) \
> +	((u32)div_u64((MGB4_HW_FREQ * (u64)(numerator)), (denominator)))
> +
>  struct mgb4_frame_buffer {
>  	struct vb2_v4l2_buffer vb;
>  	struct list_head list;
> @@ -30,11 +31,24 @@ static inline struct mgb4_frame_buffer *to_frame_buffer(struct vb2_v4l2_buffer *
>  	return container_of(vbuf, struct mgb4_frame_buffer, vb);
>  }
>  
> -static inline bool has_yuv(struct mgb4_regs *video)
> +static inline bool has_yuv_and_timeperframe(struct mgb4_regs *video)
>  {
>  	u32 status = mgb4_read_reg(video, 0xD0);
>  
>  	return (status & (1U << 8));
>  }
>  
> +#define has_yuv(video) has_yuv_and_timeperframe(video)
> +#define has_timeperframe(video) has_yuv_and_timeperframe(video)
> +
> +static inline u32 pixel_size(struct v4l2_dv_timings *timings)
> +{
> +	struct v4l2_bt_timings *bt = &timings->bt;
> +
> +	u32 height = bt->height + bt->vfrontporch + bt->vsync + bt->vbackporch;
> +	u32 width = bt->width + bt->hfrontporch + bt->hsync + bt->hbackporch;

You can use V4L2_DV_BT_FRAME_WIDTH and V4L2_DV_BT_FRAME_HEIGHT here.

> +
> +	return width * height;
> +}
> +
>  #endif
> diff --git a/drivers/media/pci/mgb4/mgb4_sysfs_out.c b/drivers/media/pci/mgb4/mgb4_sysfs_out.c
> index 9f6e81c57726..f67ff2a48329 100644
> --- a/drivers/media/pci/mgb4/mgb4_sysfs_out.c
> +++ b/drivers/media/pci/mgb4/mgb4_sysfs_out.c
> @@ -231,7 +231,7 @@ static ssize_t frame_rate_show(struct device *dev,
>  	u32 period = mgb4_read_reg(&voutdev->mgbdev->video,
>  				   voutdev->config->regs.frame_period);
>  
> -	return sprintf(buf, "%u\n", 125000000 / period);
> +	return sprintf(buf, "%u\n", MGB4_HW_FREQ / period);
>  }
>  
>  /*
> @@ -252,7 +252,7 @@ static ssize_t frame_rate_store(struct device *dev,
>  		return ret;
>  
>  	mgb4_write_reg(&voutdev->mgbdev->video,
> -		       voutdev->config->regs.frame_period, 125000000 / val);
> +		       voutdev->config->regs.frame_period, MGB4_HW_FREQ / val);
>  
>  	return count;
>  }
> diff --git a/drivers/media/pci/mgb4/mgb4_vin.c b/drivers/media/pci/mgb4/mgb4_vin.c
> index 19692e4dfb59..560c94d21924 100644
> --- a/drivers/media/pci/mgb4/mgb4_vin.c
> +++ b/drivers/media/pci/mgb4/mgb4_vin.c
> @@ -34,8 +34,8 @@ ATTRIBUTE_GROUPS(mgb4_fpdl3_in);
>  ATTRIBUTE_GROUPS(mgb4_gmsl_in);
>  
>  static const struct mgb4_vin_config vin_cfg[] = {
> -	{0, 0, 0, 6, {0x10, 0x00, 0x04, 0x08, 0x1C, 0x14, 0x18, 0x20, 0x24, 0x28}},
> -	{1, 1, 1, 7, {0x40, 0x30, 0x34, 0x38, 0x4C, 0x44, 0x48, 0x50, 0x54, 0x58}}
> +	{0, 0, 0, 6, {0x10, 0x00, 0x04, 0x08, 0x1C, 0x14, 0x18, 0x20, 0x24, 0x28, 0xE8}},
> +	{1, 1, 1, 7, {0x40, 0x30, 0x34, 0x38, 0x4C, 0x44, 0x48, 0x50, 0x54, 0x58, 0xEC}}
>  };
>  
>  static const struct i2c_board_info fpdl3_deser_info[] = {
> @@ -387,6 +387,7 @@ static int vidioc_enum_frameintervals(struct file *file, void *priv,

Why exactly did this driver support enum_frameintervals again?
Was that due to historical reasons? Normally drivers that use the dv_timings API
do not support this ioctl. It is really meant for sensors with discrete frameintervals.

>  {
>  	struct mgb4_vin_dev *vindev = video_drvdata(file);
>  	struct mgb4_regs *video = &vindev->mgbdev->video;
> +	struct v4l2_dv_timings timings;
>  
>  	if (ival->index != 0)
>  		return -EINVAL;
> @@ -397,12 +398,15 @@ static int vidioc_enum_frameintervals(struct file *file, void *priv,
>  	    ival->height != vindev->timings.bt.height)
>  		return -EINVAL;
>  
> -	ival->type = V4L2_FRMIVAL_TYPE_CONTINUOUS;
> -	ival->stepwise.min.denominator = 60;
> -	ival->stepwise.min.numerator = 1;
> -	ival->stepwise.max.denominator = 1;
> -	ival->stepwise.max.numerator = 1;
> -	ival->stepwise.step = ival->stepwise.max;
> +	get_timings(vindev, &timings);
> +
> +	ival->type = V4L2_FRMIVAL_TYPE_STEPWISE;
> +	ival->stepwise.max.denominator = MGB4_HW_FREQ;
> +	ival->stepwise.max.numerator = 0xFFFFFFFF;

That's a max frame interval of 2062 ms, is that really realistic?

> +	ival->stepwise.min.denominator = timings.bt.pixelclock;
> +	ival->stepwise.min.numerator = pixel_size(&timings);
> +	ival->stepwise.step.denominator = MGB4_HW_FREQ;
> +	ival->stepwise.step.numerator = 1;
>  
>  	return 0;
>  }

Regards,

	Hans

> @@ -570,27 +574,66 @@ static int vidioc_g_input(struct file *file, void *priv, unsigned int *i)
>  	return 0;
>  }
>  
> -static int vidioc_parm(struct file *file, void *priv,
> -		       struct v4l2_streamparm *parm)
> +static int vidioc_g_parm(struct file *file, void *priv,
> +			 struct v4l2_streamparm *parm)
>  {
>  	struct mgb4_vin_dev *vindev = video_drvdata(file);
>  	struct mgb4_regs *video = &vindev->mgbdev->video;
> -	const struct mgb4_vin_regs *regs = &vindev->config->regs;
> -	struct v4l2_fract timeperframe = {
> -		.numerator = mgb4_read_reg(video, regs->frame_period),
> -		.denominator = 125000000,
> -	};
> +	struct v4l2_fract *tpf = &parm->parm.output.timeperframe;
> +	struct v4l2_dv_timings timings;
> +	u32 timer;
>  
>  	if (parm->type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
>  		return -EINVAL;
>  
>  	parm->parm.capture.readbuffers = 2;
> -	parm->parm.capture.capability = V4L2_CAP_TIMEPERFRAME;
> -	parm->parm.capture.timeperframe = timeperframe;
> +
> +	if (has_timeperframe(video)) {
> +		timer = mgb4_read_reg(video, vindev->config->regs.timer);
> +		if (timer < 0xFFFF) {
> +			get_timings(vindev, &timings);
> +			tpf->numerator = pixel_size(&timings);
> +			tpf->denominator = timings.bt.pixelclock;
> +		} else {
> +			tpf->numerator = timer;
> +			tpf->denominator = MGB4_HW_FREQ;
> +		}
> +
> +		parm->parm.output.capability = V4L2_CAP_TIMEPERFRAME;
> +	}
>  
>  	return 0;
>  }
>  
> +static int vidioc_s_parm(struct file *file, void *priv,
> +			 struct v4l2_streamparm *parm)
> +{
> +	struct mgb4_vin_dev *vindev = video_drvdata(file);
> +	struct mgb4_regs *video = &vindev->mgbdev->video;
> +	struct v4l2_fract *tpf = &parm->parm.output.timeperframe;
> +	struct v4l2_dv_timings timings;
> +	u32 period, timer;
> +
> +	if (parm->type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
> +		return -EINVAL;
> +
> +	if (has_timeperframe(video)) {
> +		timer = tpf->denominator ?
> +			MGB4_PERIOD(tpf->numerator, tpf->denominator) : 0;
> +		if (timer) {
> +			get_timings(vindev, &timings);
> +			period = MGB4_PERIOD(pixel_size(&timings),
> +					     timings.bt.pixelclock);
> +			if (timer < period)
> +				timer = 0;
> +		}
> +
> +		mgb4_write_reg(video, vindev->config->regs.timer, timer);
> +	}
> +
> +	return vidioc_g_parm(file, priv, parm);
> +}
> +
>  static int vidioc_s_dv_timings(struct file *file, void *fh,
>  			       struct v4l2_dv_timings *timings)
>  {
> @@ -674,8 +717,8 @@ static const struct v4l2_ioctl_ops video_ioctl_ops = {
>  	.vidioc_expbuf = vb2_ioctl_expbuf,
>  	.vidioc_streamon = vb2_ioctl_streamon,
>  	.vidioc_streamoff = vb2_ioctl_streamoff,
> -	.vidioc_g_parm = vidioc_parm,
> -	.vidioc_s_parm = vidioc_parm,
> +	.vidioc_g_parm = vidioc_g_parm,
> +	.vidioc_s_parm = vidioc_s_parm,
>  	.vidioc_dv_timings_cap = vidioc_dv_timings_cap,
>  	.vidioc_enum_dv_timings = vidioc_enum_dv_timings,
>  	.vidioc_g_dv_timings = vidioc_g_dv_timings,
> @@ -858,10 +901,16 @@ static void debugfs_init(struct mgb4_vin_dev *vindev)
>  	vindev->regs[7].offset = vindev->config->regs.signal2;
>  	vindev->regs[8].name = "PADDING_PIXELS";
>  	vindev->regs[8].offset = vindev->config->regs.padding;
> +	if (has_timeperframe(video)) {
> +		vindev->regs[9].name = "TIMER";
> +		vindev->regs[9].offset = vindev->config->regs.timer;
> +		vindev->regset.nregs = 10;
> +	} else {
> +		vindev->regset.nregs = 9;
> +	}
>  
>  	vindev->regset.base = video->membase;
>  	vindev->regset.regs = vindev->regs;
> -	vindev->regset.nregs = ARRAY_SIZE(vindev->regs);
>  
>  	debugfs_create_regset32("registers", 0444, vindev->debugfs,
>  				&vindev->regset);
> diff --git a/drivers/media/pci/mgb4/mgb4_vin.h b/drivers/media/pci/mgb4/mgb4_vin.h
> index 0249b400ad4d..9693bd0ce180 100644
> --- a/drivers/media/pci/mgb4/mgb4_vin.h
> +++ b/drivers/media/pci/mgb4/mgb4_vin.h
> @@ -25,6 +25,7 @@ struct mgb4_vin_regs {
>  	u32 signal;
>  	u32 signal2;
>  	u32 padding;
> +	u32 timer;
>  };
>  
>  struct mgb4_vin_config {
> @@ -59,7 +60,7 @@ struct mgb4_vin_dev {
>  #ifdef CONFIG_DEBUG_FS
>  	struct dentry *debugfs;
>  	struct debugfs_regset32 regset;
> -	struct debugfs_reg32 regs[9];
> +	struct debugfs_reg32 regs[sizeof(struct mgb4_vin_regs) / 4];
>  #endif
>  };
>  
> diff --git a/drivers/media/pci/mgb4/mgb4_vout.c b/drivers/media/pci/mgb4/mgb4_vout.c
> index 243fbeaaceb9..a6b55669f0a8 100644
> --- a/drivers/media/pci/mgb4/mgb4_vout.c
> +++ b/drivers/media/pci/mgb4/mgb4_vout.c
> @@ -16,6 +16,7 @@
>  #include <media/v4l2-ioctl.h>
>  #include <media/videobuf2-v4l2.h>
>  #include <media/videobuf2-dma-sg.h>
> +#include <media/v4l2-dv-timings.h>
>  #include "mgb4_core.h"
>  #include "mgb4_dma.h"
>  #include "mgb4_sysfs.h"
> @@ -23,12 +24,16 @@
>  #include "mgb4_cmt.h"
>  #include "mgb4_vout.h"
>  
> +#define DEFAULT_WIDTH     1280
> +#define DEFAULT_HEIGHT    640
> +#define DEFAULT_PERIOD    (MGB4_HW_FREQ / 60)
> +
>  ATTRIBUTE_GROUPS(mgb4_fpdl3_out);
>  ATTRIBUTE_GROUPS(mgb4_gmsl_out);
>  
>  static const struct mgb4_vout_config vout_cfg[] = {
> -	{0, 0, 8, {0x78, 0x60, 0x64, 0x68, 0x74, 0x6C, 0x70, 0x7c}},
> -	{1, 1, 9, {0x98, 0x80, 0x84, 0x88, 0x94, 0x8c, 0x90, 0x9c}}
> +	{0, 0, 8, {0x78, 0x60, 0x64, 0x68, 0x74, 0x6C, 0x70, 0x7C, 0xE0}},
> +	{1, 1, 9, {0x98, 0x80, 0x84, 0x88, 0x94, 0x8C, 0x90, 0x9C, 0xE4}}
>  };
>  
>  static const struct i2c_board_info fpdl3_ser_info[] = {
> @@ -40,6 +45,49 @@ static const struct mgb4_i2c_kv fpdl3_i2c[] = {
>  	{0x05, 0xFF, 0x04}, {0x06, 0xFF, 0x01}, {0xC2, 0xFF, 0x80}
>  };
>  
> +static const struct v4l2_dv_timings_cap video_timings_cap = {
> +	.type = V4L2_DV_BT_656_1120,
> +	.bt = {
> +		.min_width = 320,
> +		.max_width = 4096,
> +		.min_height = 240,
> +		.max_height = 2160,
> +		.min_pixelclock = 1843200, /* 320 x 240 x 24Hz */
> +		.max_pixelclock = 530841600, /* 4096 x 2160 x 60Hz */
> +		.standards = V4L2_DV_BT_STD_CEA861 | V4L2_DV_BT_STD_DMT |
> +			V4L2_DV_BT_STD_CVT | V4L2_DV_BT_STD_GTF,
> +		.capabilities = V4L2_DV_BT_CAP_PROGRESSIVE |
> +			V4L2_DV_BT_CAP_CUSTOM,
> +	},
> +};
> +
> +static void get_timings(struct mgb4_vout_dev *voutdev,
> +			struct v4l2_dv_timings *timings)
> +{
> +	struct mgb4_regs *video = &voutdev->mgbdev->video;
> +	const struct mgb4_vout_regs *regs = &voutdev->config->regs;
> +
> +	u32 hsync = mgb4_read_reg(video, regs->hsync);
> +	u32 vsync = mgb4_read_reg(video, regs->vsync);
> +	u32 resolution = mgb4_read_reg(video, regs->resolution);
> +
> +	memset(timings, 0, sizeof(*timings));
> +	timings->type = V4L2_DV_BT_656_1120;
> +	timings->bt.width = resolution >> 16;
> +	timings->bt.height = resolution & 0xFFFF;
> +	if (hsync & (1U << 31))
> +		timings->bt.polarities |= V4L2_DV_HSYNC_POS_POL;
> +	if (vsync & (1U << 31))
> +		timings->bt.polarities |= V4L2_DV_VSYNC_POS_POL;
> +	timings->bt.pixelclock = voutdev->freq * 1000;
> +	timings->bt.hsync = (hsync & 0x00FF0000) >> 16;
> +	timings->bt.vsync = (vsync & 0x00FF0000) >> 16;
> +	timings->bt.hbackporch = (hsync & 0x0000FF00) >> 8;
> +	timings->bt.hfrontporch = hsync & 0x000000FF;
> +	timings->bt.vbackporch = (vsync & 0x0000FF00) >> 8;
> +	timings->bt.vfrontporch = vsync & 0x000000FF;
> +}
> +
>  static void return_all_buffers(struct mgb4_vout_dev *voutdev,
>  			       enum vb2_buffer_state state)
>  {
> @@ -345,11 +393,134 @@ static int vidioc_enum_output(struct file *file, void *priv,
>  		return -EINVAL;
>  
>  	out->type = V4L2_OUTPUT_TYPE_ANALOG;
> +	out->capabilities = V4L2_OUT_CAP_DV_TIMINGS;
>  	strscpy(out->name, "MGB4", sizeof(out->name));
>  
>  	return 0;
>  }
>  
> +static int vidioc_enum_frameintervals(struct file *file, void *priv,
> +				      struct v4l2_frmivalenum *ival)
> +{
> +	struct mgb4_vout_dev *voutdev = video_drvdata(file);
> +	struct mgb4_regs *video = &voutdev->mgbdev->video;
> +	struct v4l2_dv_timings timings;
> +
> +	if (ival->index != 0)
> +		return -EINVAL;
> +	if (!(ival->pixel_format == V4L2_PIX_FMT_ABGR32 ||
> +	      ((has_yuv(video) && ival->pixel_format == V4L2_PIX_FMT_YUYV))))
> +		return -EINVAL;
> +	if (ival->width != voutdev->width || ival->height != voutdev->height)
> +		return -EINVAL;
> +
> +	get_timings(voutdev, &timings);
> +
> +	ival->type = V4L2_FRMIVAL_TYPE_STEPWISE;
> +	ival->stepwise.max.denominator = MGB4_HW_FREQ;
> +	ival->stepwise.max.numerator = 0xFFFFFFFF;
> +	ival->stepwise.min.denominator = timings.bt.pixelclock;
> +	ival->stepwise.min.numerator = pixel_size(&timings);
> +	ival->stepwise.step.denominator = MGB4_HW_FREQ;
> +	ival->stepwise.step.numerator = 1;
> +
> +	return 0;
> +}
> +
> +static int vidioc_g_parm(struct file *file, void *priv,
> +			 struct v4l2_streamparm *parm)
> +{
> +	struct mgb4_vout_dev *voutdev = video_drvdata(file);
> +	struct mgb4_regs *video = &voutdev->mgbdev->video;
> +	struct v4l2_fract *tpf = &parm->parm.output.timeperframe;
> +	struct v4l2_dv_timings timings;
> +	u32 timer;
> +
> +	if (parm->type != V4L2_BUF_TYPE_VIDEO_OUTPUT)
> +		return -EINVAL;
> +
> +	parm->parm.output.writebuffers = 2;
> +
> +	if (has_timeperframe(video)) {
> +		timer = mgb4_read_reg(video, voutdev->config->regs.timer);
> +		if (timer < 0xFFFF) {
> +			get_timings(voutdev, &timings);
> +			tpf->numerator = pixel_size(&timings);
> +			tpf->denominator = timings.bt.pixelclock;
> +		} else {
> +			tpf->numerator = timer;
> +			tpf->denominator = MGB4_HW_FREQ;
> +		}
> +
> +		parm->parm.output.capability = V4L2_CAP_TIMEPERFRAME;
> +	}
> +
> +	return 0;
> +}
> +
> +static int vidioc_s_parm(struct file *file, void *priv,
> +			 struct v4l2_streamparm *parm)
> +{
> +	struct mgb4_vout_dev *voutdev = video_drvdata(file);
> +	struct mgb4_regs *video = &voutdev->mgbdev->video;
> +	struct v4l2_fract *tpf = &parm->parm.output.timeperframe;
> +	struct v4l2_dv_timings timings;
> +	u32 timer, period;
> +
> +	if (parm->type != V4L2_BUF_TYPE_VIDEO_OUTPUT)
> +		return -EINVAL;
> +
> +	if (has_timeperframe(video)) {
> +		timer = tpf->denominator ?
> +			MGB4_PERIOD(tpf->numerator, tpf->denominator) : 0;
> +		if (timer) {
> +			get_timings(voutdev, &timings);
> +			period = MGB4_PERIOD(pixel_size(&timings),
> +					     timings.bt.pixelclock);
> +			if (timer < period)
> +				timer = 0;
> +		}
> +
> +		mgb4_write_reg(video, voutdev->config->regs.timer, timer);
> +	}
> +
> +	return vidioc_g_parm(file, priv, parm);
> +}
> +
> +static int vidioc_g_dv_timings(struct file *file, void *fh,
> +			       struct v4l2_dv_timings *timings)
> +{
> +	struct mgb4_vout_dev *voutdev = video_drvdata(file);
> +
> +	get_timings(voutdev, timings);
> +
> +	return 0;
> +}
> +
> +static int vidioc_s_dv_timings(struct file *file, void *fh,
> +			       struct v4l2_dv_timings *timings)
> +{
> +	struct mgb4_vout_dev *voutdev = video_drvdata(file);
> +
> +	get_timings(voutdev, timings);
> +
> +	return 0;
> +}
> +
> +static int vidioc_enum_dv_timings(struct file *file, void *fh,
> +				  struct v4l2_enum_dv_timings *timings)
> +{
> +	return v4l2_enum_dv_timings_cap(timings, &video_timings_cap, NULL, NULL);
> +}
> +
> +static int vidioc_dv_timings_cap(struct file *file, void *fh,
> +				 struct v4l2_dv_timings_cap *cap)
> +{
> +	*cap = video_timings_cap;
> +
> +	return 0;
> +}
> +
>  static const struct v4l2_ioctl_ops video_ioctl_ops = {
>  	.vidioc_querycap = vidioc_querycap,
>  	.vidioc_enum_fmt_vid_out = vidioc_enum_fmt,
> @@ -357,8 +528,15 @@ static const struct v4l2_ioctl_ops video_ioctl_ops = {
>  	.vidioc_s_fmt_vid_out = vidioc_s_fmt,
>  	.vidioc_g_fmt_vid_out = vidioc_g_fmt,
>  	.vidioc_enum_output = vidioc_enum_output,
> +	.vidioc_enum_frameintervals = vidioc_enum_frameintervals,
>  	.vidioc_g_output = vidioc_g_output,
>  	.vidioc_s_output = vidioc_s_output,
> +	.vidioc_g_parm = vidioc_g_parm,
> +	.vidioc_s_parm = vidioc_s_parm,
> +	.vidioc_dv_timings_cap = vidioc_dv_timings_cap,
> +	.vidioc_enum_dv_timings = vidioc_enum_dv_timings,
> +	.vidioc_g_dv_timings = vidioc_g_dv_timings,
> +	.vidioc_s_dv_timings = vidioc_s_dv_timings,
>  	.vidioc_reqbufs = vb2_ioctl_reqbufs,
>  	.vidioc_create_bufs = vb2_ioctl_create_bufs,
>  	.vidioc_prepare_buf = vb2_ioctl_prepare_buf,
> @@ -501,10 +679,10 @@ static void fpga_init(struct mgb4_vout_dev *voutdev)
>  
>  	mgb4_write_reg(video, regs->config, 0x00000011);
>  	mgb4_write_reg(video, regs->resolution,
> -		       (MGB4_DEFAULT_WIDTH << 16) | MGB4_DEFAULT_HEIGHT);
> +		       (DEFAULT_WIDTH << 16) | DEFAULT_HEIGHT);
>  	mgb4_write_reg(video, regs->hsync, 0x00102020);
>  	mgb4_write_reg(video, regs->vsync, 0x40020202);
> -	mgb4_write_reg(video, regs->frame_period, MGB4_DEFAULT_PERIOD);
> +	mgb4_write_reg(video, regs->frame_period, DEFAULT_PERIOD);
>  	mgb4_write_reg(video, regs->padding, 0x00000000);
>  
>  	voutdev->freq = mgb4_cmt_set_vout_freq(voutdev, 70000 >> 1) << 1;
> @@ -535,12 +713,18 @@ static void debugfs_init(struct mgb4_vout_dev *voutdev)
>  	voutdev->regs[4].offset = voutdev->config->regs.vsync;
>  	voutdev->regs[5].name = "FRAME_PERIOD";
>  	voutdev->regs[5].offset = voutdev->config->regs.frame_period;
> -	voutdev->regs[6].name = "PADDING";
> +	voutdev->regs[6].name = "PADDING_PIXELS";
>  	voutdev->regs[6].offset = voutdev->config->regs.padding;
> +	if (has_timeperframe(video)) {
> +		voutdev->regs[7].name = "TIMER";
> +		voutdev->regs[7].offset = voutdev->config->regs.timer;
> +		voutdev->regset.nregs = 8;
> +	} else {
> +		voutdev->regset.nregs = 7;
> +	}
>  
>  	voutdev->regset.base = video->membase;
>  	voutdev->regset.regs = voutdev->regs;
> -	voutdev->regset.nregs = ARRAY_SIZE(voutdev->regs);
>  
>  	debugfs_create_regset32("registers", 0444, voutdev->debugfs,
>  				&voutdev->regset);
> diff --git a/drivers/media/pci/mgb4/mgb4_vout.h b/drivers/media/pci/mgb4/mgb4_vout.h
> index b163dee711fd..ab9b58b1deb7 100644
> --- a/drivers/media/pci/mgb4/mgb4_vout.h
> +++ b/drivers/media/pci/mgb4/mgb4_vout.h
> @@ -23,6 +23,7 @@ struct mgb4_vout_regs {
>  	u32 hsync;
>  	u32 vsync;
>  	u32 padding;
> +	u32 timer;
>  };
>  
>  struct mgb4_vout_config {
> @@ -55,7 +56,7 @@ struct mgb4_vout_dev {
>  #ifdef CONFIG_DEBUG_FS
>  	struct dentry *debugfs;
>  	struct debugfs_regset32 regset;
> -	struct debugfs_reg32 regs[7];
> +	struct debugfs_reg32 regs[sizeof(struct mgb4_vout_regs) / 4];
>  #endif
>  };
>  


