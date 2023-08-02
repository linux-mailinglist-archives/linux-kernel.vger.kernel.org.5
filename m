Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8CF876C334
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 04:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjHBC51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 22:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbjHBC5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 22:57:24 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFA42733;
        Tue,  1 Aug 2023 19:57:11 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id A451824E29F;
        Wed,  2 Aug 2023 10:57:04 +0800 (CST)
Received: from EXMBX073.cuchost.com (172.16.6.83) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 2 Aug
 2023 10:57:04 +0800
Received: from [192.168.1.218] (180.164.60.184) by EXMBX073.cuchost.com
 (172.16.6.83) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 2 Aug
 2023 10:57:03 +0800
Message-ID: <3206c2c5-cbba-6316-07c5-5fdcff88add8@starfivetech.com>
Date:   Wed, 2 Aug 2023 10:57:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 4/6] media: starfive: camss: Add video driver
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        <bryan.odonoghue@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <changhuang.liang@starfivetech.com>
References: <20230619112838.19797-1-jack.zhu@starfivetech.com>
 <20230619112838.19797-5-jack.zhu@starfivetech.com>
 <20230727152528.GI25174@pendragon.ideasonboard.com>
From:   Jack Zhu <jack.zhu@starfivetech.com>
In-Reply-To: <20230727152528.GI25174@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [180.164.60.184]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX073.cuchost.com
 (172.16.6.83)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

Thank you for your comments.

On 2023/7/27 23:25, Laurent Pinchart wrote:
> Hi Jack,
> 
> Thank you for the patch.
> 
> On Mon, Jun 19, 2023 at 07:28:36PM +0800, Jack Zhu wrote:
>> Add video driver for StarFive Camera Subsystem.
>> 
>> Signed-off-by: Jack Zhu <jack.zhu@starfivetech.com>
>> ---
>>  .../media/platform/starfive/camss/Makefile    |   4 +-
>>  .../media/platform/starfive/camss/stf_video.c | 724 ++++++++++++++++++
>>  .../media/platform/starfive/camss/stf_video.h |  92 +++
>>  3 files changed, 819 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/media/platform/starfive/camss/stf_video.c
>>  create mode 100644 drivers/media/platform/starfive/camss/stf_video.h
>> 
>> diff --git a/drivers/media/platform/starfive/camss/Makefile b/drivers/media/platform/starfive/camss/Makefile
>> index d56ddd078a71..eb457917a914 100644
>> --- a/drivers/media/platform/starfive/camss/Makefile
>> +++ b/drivers/media/platform/starfive/camss/Makefile
>> @@ -3,6 +3,8 @@
>>  # Makefile for StarFive Camera Subsystem driver
>>  #
>>  
>> -starfive-camss-objs += stf_camss.o
>> +starfive-camss-objs += \
>> +		stf_camss.o \
>> +		stf_video.o
>>  
>>  obj-$(CONFIG_VIDEO_STARFIVE_CAMSS) += starfive-camss.o
>> diff --git a/drivers/media/platform/starfive/camss/stf_video.c b/drivers/media/platform/starfive/camss/stf_video.c
>> new file mode 100644
>> index 000000000000..2e6472fe51c6
>> --- /dev/null
>> +++ b/drivers/media/platform/starfive/camss/stf_video.c
>> @@ -0,0 +1,724 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * stf_video.c
>> + *
>> + * StarFive Camera Subsystem - V4L2 device node
>> + *
>> + * Copyright (C) 2021-2023 StarFive Technology Co., Ltd.
>> + */
>> +
>> +#include <linux/pm_runtime.h>
>> +#include <media/v4l2-ctrls.h>
>> +#include <media/v4l2-event.h>
>> +#include <media/v4l2-mc.h>
>> +#include <media/videobuf2-dma-contig.h>
>> +
>> +#include "stf_camss.h"
>> +#include "stf_video.h"
>> +
>> +static const struct stfcamss_format_info formats_pix_wr[] = {
>> +	{
>> +		.code = MEDIA_BUS_FMT_SRGGB10_1X10,
>> +		.pixelformat = V4L2_PIX_FMT_SRGGB10,
>> +		.planes = 1,
>> +		.vsub = { 1 },
>> +		.bpp = 10,
>> +	},
>> +	{
>> +		.code = MEDIA_BUS_FMT_SGRBG10_1X10,
>> +		.pixelformat = V4L2_PIX_FMT_SGRBG10,
>> +		.planes = 1,
>> +		.vsub = { 1 },
>> +		.bpp = 10,
>> +	},
>> +	{
>> +		.code = MEDIA_BUS_FMT_SGBRG10_1X10,
>> +		.pixelformat = V4L2_PIX_FMT_SGBRG10,
>> +		.planes = 1,
>> +		.vsub = { 1 },
>> +		.bpp = 10,
>> +	},
>> +	{
>> +		.code = MEDIA_BUS_FMT_SBGGR10_1X10,
>> +		.pixelformat = V4L2_PIX_FMT_SBGGR10,
>> +		.planes = 1,
>> +		.vsub = { 1 },
>> +		.bpp = 10,
>> +	},
>> +};
>> +
>> +static const struct stfcamss_format_info formats_pix_isp[] = {
>> +	{
>> +		.code = MEDIA_BUS_FMT_Y12_1X12,
>> +		.pixelformat = V4L2_PIX_FMT_NV12,
>> +		.planes = 2,
>> +		.vsub = { 1, 2 },
>> +		.bpp = 8,
>> +	},
>> +};
>> +
>> +/* -----------------------------------------------------------------------------
>> + * Helper functions
>> + */
>> +
>> +static int video_find_format(u32 code, u32 pixelformat,
>> +			     struct stfcamss_video *video)
>> +{
>> +	unsigned int i;
>> +
>> +	for (i = 0; i < video->nformats; ++i) {
>> +		if (video->formats[i].code == code &&
>> +		    video->formats[i].pixelformat == pixelformat)
>> +			return i;
>> +	}
>> +
>> +	for (i = 0; i < video->nformats; ++i)
>> +		if (video->formats[i].code == code)
>> +			return i;
>> +
>> +	for (i = 0; i < video->nformats; ++i)
>> +		if (video->formats[i].pixelformat == pixelformat)
>> +			return i;
>> +
> 
> This looks weird, I don't think it does what you expect below. I think
> you can drop the function, and instead use video_get_pfmt_by_mcode() to
> convert the mbus code to a pixel format, and compare it to the active
> pixel format in video_check_format().
> 
>> +	return -EINVAL;
>> +}
>> +
>> +static int __video_try_fmt(struct stfcamss_video *video, struct v4l2_format *f)
>> +{
>> +	struct v4l2_pix_format *pix;
>> +	const struct stfcamss_format_info *fi;
>> +	u32 width, height;
>> +	u32 bpl;
>> +	unsigned int i;
>> +
>> +	pix = &f->fmt.pix;
> 
> You can initialize pix when declaring it.
> 
>> +
>> +	for (i = 0; i < video->nformats; i++)
>> +		if (pix->pixelformat == video->formats[i].pixelformat)
>> +			break;
>> +
> 
> 	for (i = 0; i < video->nformats; i++) {
> 		if (pix->pixelformat == video->formats[i].pixelformat)
> 			break;
> 	}
> 
> But a helper function that looks up a format by pixelformat, similar to
> video_get_pfmt_by_mcode(), would be useful. I think I would make all
> those helpers return a const struct stfcamss_format_info pointer instead
> of an index.
> 
>> +	if (i == video->nformats)
>> +		i = 0; /* default format */
>> +
>> +	fi = &video->formats[i];
>> +	width = pix->width;
>> +	height = pix->height;
>> +
>> +	memset(pix, 0, sizeof(*pix));
>> +
>> +	pix->pixelformat = fi->pixelformat;
>> +	pix->width = clamp_t(u32, width, STFCAMSS_FRAME_MIN_WIDTH,
>> +			     STFCAMSS_FRAME_MAX_WIDTH);
>> +	pix->height = clamp_t(u32, height, STFCAMSS_FRAME_MIN_HEIGHT,
>> +			      STFCAMSS_FRAME_MAX_HEIGHT);
>> +	bpl = pix->width * fi->bpp / 8;
>> +	bpl = ALIGN(bpl, video->bpl_alignment);
>> +	pix->bytesperline = bpl;
> 
> Does the hardware support configuring the stride ?
> 

The hardware does not support.

>> +
>> +	for (i = 0; i < fi->planes; ++i)
>> +		pix->sizeimage += bpl * pix->height / fi->vsub[i];
>> +
>> +	pix->field = V4L2_FIELD_NONE;
>> +	pix->colorspace = V4L2_COLORSPACE_SRGB;
>> +	pix->flags = 0;
>> +	pix->ycbcr_enc =
>> +		V4L2_MAP_YCBCR_ENC_DEFAULT(pix->colorspace);
>> +	pix->quantization = V4L2_MAP_QUANTIZATION_DEFAULT(true,
>> +							  pix->colorspace,
>> +							  pix->ycbcr_enc);
>> +	pix->xfer_func = V4L2_MAP_XFER_FUNC_DEFAULT(pix->colorspace);
> 
> This doesn't seem right for the processed output.
> 
>> +
>> +	return 0;
>> +}
>> +
>> +static int stf_video_init_format(struct stfcamss_video *video)
>> +{
>> +	int ret;
>> +	struct v4l2_format format = {
>> +		.type = video->type,
>> +		.fmt.pix = {
>> +			.width = 1920,
>> +			.height = 1080,
>> +			.pixelformat = V4L2_PIX_FMT_RGB565,
> 
> That format doesn't seem supported, let's pick V4L2_PIX_FMT_NV12.
> 
>> +		},
>> +	};
>> +
>> +	ret = __video_try_fmt(video, &format);
>> +
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	video->active_fmt = format;
>> +
>> +	return 0;
>> +}
>> +
>> +/* -----------------------------------------------------------------------------
>> + * Video queue operations
>> + */
>> +
>> +static int video_queue_setup(struct vb2_queue *q,
>> +			     unsigned int *num_buffers,
>> +			     unsigned int *num_planes,
>> +			     unsigned int sizes[],
>> +			     struct device *alloc_devs[])
>> +{
>> +	struct stfcamss_video *video = vb2_get_drv_priv(q);
>> +	const struct v4l2_pix_format *format = &video->active_fmt.fmt.pix;
>> +
>> +	if (*num_planes) {
>> +		if (*num_planes != 1)
>> +			return -EINVAL;
>> +
>> +		if (sizes[0] < format->sizeimage)
>> +			return -EINVAL;
>> +	}
>> +
>> +	*num_planes = 1;
>> +	sizes[0] = format->sizeimage;
>> +	if (!sizes[0])
>> +		dev_err(video->stfcamss->dev,
>> +			"%s: error size is zero!!!\n", __func__);
> 
> Shouldn't you return an error ? Also, use dev_dbg(), printing an error
> message based on a condition that can easily be triggered by
> unpriviledge userspace opens the door to applications flooding the
> kernel log.
> 
>> +
>> +	dev_dbg(video->stfcamss->dev, "planes = %d, size = %d\n",
>> +		*num_planes, sizes[0]);
>> +
>> +	return 0;
>> +}
>> +
>> +static int video_buf_init(struct vb2_buffer *vb)
>> +{
>> +	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
>> +	struct stfcamss_video *video = vb2_get_drv_priv(vb->vb2_queue);
>> +	struct stfcamss_buffer *buffer =
>> +		container_of(vbuf, struct stfcamss_buffer, vb);
> 
> A static inline to_stfcamss_buffer() function that wraps the
> container_of() would be nice. You can use it below too.
> 
>> +	const struct v4l2_pix_format *fmt = &video->active_fmt.fmt.pix;
>> +	dma_addr_t *paddr;
>> +
>> +	paddr = vb2_plane_cookie(vb, 0);
>> +	buffer->addr[0] = *paddr;
>> +
>> +	if (fmt->pixelformat == V4L2_PIX_FMT_NV12 ||
>> +	    fmt->pixelformat == V4L2_PIX_FMT_NV21 ||
>> +	    fmt->pixelformat == V4L2_PIX_FMT_NV16 ||
>> +	    fmt->pixelformat == V4L2_PIX_FMT_NV61)
> 
> Only V4L2_PIX_FMT_NV12 is listed in formats_pix_isp. Does the hardware
> support the other formats ? If so, it would be nice to support them
> already.
> 
>> +		buffer->addr[1] =
>> +			buffer->addr[0] + fmt->bytesperline * fmt->height;
> 
> As the hardware supports non-contiguous planes, you should use the
> MPLANE API (V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) and support the NV*M
> formats in addition to the NV* formats.
> 
>> +
>> +	return 0;
>> +}
>> +
>> +static int video_buf_prepare(struct vb2_buffer *vb)
>> +{
>> +	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
>> +	struct stfcamss_video *video = vb2_get_drv_priv(vb->vb2_queue);
>> +	const struct v4l2_pix_format *fmt = &video->active_fmt.fmt.pix;
>> +
>> +	if (fmt->sizeimage > vb2_plane_size(vb, 0)) {
>> +		dev_err(video->stfcamss->dev,
> 
> dev_dbg() here too.
> 
>> +			"sizeimage = %d, plane size = %d\n",
>> +			fmt->sizeimage, (unsigned int)vb2_plane_size(vb, 0));
> 
> Both are unsigned, use %u instead of %d.
> 
>> +		return -EINVAL;
>> +	}
>> +	vb2_set_plane_payload(vb, 0, fmt->sizeimage);
>> +
>> +	vbuf->field = V4L2_FIELD_NONE;
>> +
>> +	return 0;
>> +}
>> +
>> +static void video_buf_queue(struct vb2_buffer *vb)
>> +{
>> +	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
>> +	struct stfcamss_video *video = vb2_get_drv_priv(vb->vb2_queue);
>> +	struct stfcamss_buffer *buffer =
>> +		container_of(vbuf, struct stfcamss_buffer, vb);
>> +
>> +	video->ops->queue_buffer(video, buffer);
>> +}
>> +
>> +/*
>> + * video_mbus_to_pix - Convert v4l2_mbus_framefmt to v4l2_pix_format
>> + * @mbus: v4l2_mbus_framefmt format (input)
>> + * @pix: v4l2_pix_format_mplane format (output)
>> + * @f: a pointer to formats array element to be used for the conversion
>> + * @alignment: bytesperline alignment value
>> + *
>> + * Fill the output pix structure with information from the input mbus format.
>> + *
>> + * Return 0 on success or a negative error code otherwise
>> + */
>> +static int video_mbus_to_pix(const struct v4l2_mbus_framefmt *mbus,
>> +			     struct v4l2_pix_format *pix,
>> +			     const struct stfcamss_format_info *f,
>> +			     unsigned int alignment)
>> +{
>> +	u32 bytesperline;
>> +	unsigned int i;
>> +
>> +	memset(pix, 0, sizeof(*pix));
>> +	v4l2_fill_pix_format(pix, mbus);
>> +	pix->pixelformat = f->pixelformat;
>> +	bytesperline = pix->width * f->bpp / 8;
>> +	bytesperline = ALIGN(bytesperline, alignment);
>> +	pix->bytesperline = bytesperline;
>> +
>> +	for (i = 0; i < f->planes; ++i)
>> +		pix->sizeimage += bytesperline * pix->height / f->vsub[i];
> 
> This function is used for validation of the format only, the
> bytesperline and sizeimage values are never used. You can simplify the
> driver by dropping the function and comparing the width, height and
> field of the subdev and video device from the v4l2_mbus_framefmt and
> v4l2_pix_format respectively in video_check_format().
> video_get_subdev_format() will then take a v4l2_mbus_framefmt pointer,
> not a v4l2_pix_format.
> 
> The format match check still needs conversion of the 
> 
> To check the format, you need to convert the mbus code from the subdev
> to a pixel format using the 
> 
>> +
>> +	return 0;
>> +}
>> +
>> +static struct v4l2_subdev *video_remote_subdev(struct stfcamss_video *video,
>> +					       u32 *pad)
>> +{
>> +	struct media_pad *remote;
>> +
>> +	remote = media_pad_remote_pad_first(&video->pad);
>> +
>> +	if (!remote || !is_media_entity_v4l2_subdev(remote->entity))
>> +		return NULL;
>> +
>> +	if (pad)
>> +		*pad = remote->index;
>> +
>> +	return media_entity_to_v4l2_subdev(remote->entity);
> 
> As the connected subdev is always the same (the CSI-2 RX for the raw
> capture video device and the ISP for the processed capture video
> device), I would store a pointer to the connected subdev in the
> stfcamss_video structure at registration time. You can pass the pointer
> to the stf_video_register() function.
> 

As the hardware also supports the dvp interface, I think the current
function implementation should be flexible and easy to expand later.

>> +}
>> +
>> +static int video_get_subdev_format(struct stfcamss_video *video,
>> +				   struct v4l2_format *format)
>> +{
>> +	struct v4l2_pix_format *pix = &video->active_fmt.fmt.pix;
>> +	struct v4l2_subdev_format fmt;
>> +	struct v4l2_subdev *subdev;
>> +	u32 pixelformat;
>> +	u32 pad;
>> +	int ret;
>> +
>> +	subdev = video_remote_subdev(video, &pad);
>> +	if (!subdev)
>> +		return -EPIPE;
>> +
>> +	fmt.pad = pad;
>> +	fmt.which = V4L2_SUBDEV_FORMAT_ACTIVE;
>> +
>> +	ret = v4l2_subdev_call(subdev, pad, get_fmt, NULL, &fmt);
> 
> Use v4l2_subdev_call_state_active() to support the subdev state API.
> 
>> +	if (ret)
>> +		return ret;
>> +
>> +	pixelformat = pix->pixelformat;
>> +	ret = video_find_format(fmt.format.code, pixelformat, video);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	format->type = video->type;
>> +
>> +	return video_mbus_to_pix(&fmt.format, &format->fmt.pix,
>> +				 &video->formats[ret], video->bpl_alignment);
>> +}
>> +

Regards,

Jack Zhu
