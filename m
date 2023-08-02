Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53CE76C233
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 03:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbjHBB0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 21:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjHBB0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 21:26:19 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AB92D55;
        Tue,  1 Aug 2023 18:26:13 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 4DE288118;
        Wed,  2 Aug 2023 09:26:12 +0800 (CST)
Received: from EXMBX073.cuchost.com (172.16.6.83) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 2 Aug
 2023 09:26:12 +0800
Received: from [192.168.1.218] (180.164.60.184) by EXMBX073.cuchost.com
 (172.16.6.83) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 2 Aug
 2023 09:26:11 +0800
Message-ID: <fd8cdd07-105e-a801-6186-d432cfaaf684@starfivetech.com>
Date:   Wed, 2 Aug 2023 09:26:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 4/6] media: starfive: camss: Add video driver
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        <bryan.odonoghue@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <changhuang.liang@starfivetech.com>
References: <20230619112838.19797-1-jack.zhu@starfivetech.com>
 <20230619112838.19797-5-jack.zhu@starfivetech.com>
 <8e381fd6-9475-88fc-9159-927f119a8b9c@xs4all.nl>
 <7c4e63e7-ce28-139f-373d-0fecca6839b9@starfivetech.com>
 <20230801184741.GB30382@pendragon.ideasonboard.com>
From:   Jack Zhu <jack.zhu@starfivetech.com>
In-Reply-To: <20230801184741.GB30382@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [180.164.60.184]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX073.cuchost.com
 (172.16.6.83)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/8/2 2:47, Laurent Pinchart wrote:
> Hi Jack,
> 
> On Tue, Aug 01, 2023 at 02:23:07PM +0800, Jack Zhu wrote:
>> On 2023/7/27 16:49, Hans Verkuil wrote:
>> > On 19/06/2023 13:28, Jack Zhu wrote:
>> >> Add video driver for StarFive Camera Subsystem.
>> >> 
>> >> Signed-off-by: Jack Zhu <jack.zhu@starfivetech.com>
>> >> ---
>> >>  .../media/platform/starfive/camss/Makefile    |   4 +-
>> >>  .../media/platform/starfive/camss/stf_video.c | 724 ++++++++++++++++++
>> >>  .../media/platform/starfive/camss/stf_video.h |  92 +++
>> >>  3 files changed, 819 insertions(+), 1 deletion(-)
>> >>  create mode 100644 drivers/media/platform/starfive/camss/stf_video.c
>> >>  create mode 100644 drivers/media/platform/starfive/camss/stf_video.h
> 
> [snip]
> 
>> >> diff --git a/drivers/media/platform/starfive/camss/stf_video.c b/drivers/media/platform/starfive/camss/stf_video.c
>> >> new file mode 100644
>> >> index 000000000000..2e6472fe51c6
>> >> --- /dev/null
>> >> +++ b/drivers/media/platform/starfive/camss/stf_video.c
>> >> @@ -0,0 +1,724 @@
> 
> [snip]
> 
>> >> +int stf_video_register(struct stfcamss_video *video,
>> >> +		       struct v4l2_device *v4l2_dev, const char *name)
>> >> +{
>> >> +	struct video_device *vdev;
>> >> +	struct vb2_queue *q;
>> >> +	struct media_pad *pad = &video->pad;
>> >> +	int ret;
>> >> +
>> >> +	vdev = &video->vdev;
>> >> +
>> >> +	mutex_init(&video->q_lock);
>> >> +
>> >> +	q = &video->vb2_q;
>> >> +	q->drv_priv = video;
>> >> +	q->mem_ops = &vb2_dma_contig_memops;
>> >> +	q->ops = &stf_video_vb2_q_ops;
>> >> +	q->type = video->type;
>> >> +	q->io_modes = VB2_DMABUF | VB2_MMAP | VB2_READ;
>> > 
>> > VB2_READ support does not generally make sense for uncompressed video since
>> > read() always requires a memcpy, and that makes it very inefficient.
>> > 
>> > It doesn't hurt though, so it is up to you whether or not you want this.
>> 
>> Yes, we would like to retain this feature to meet some possible special needs.
> 
> The issue with enabling READ support in drivers is that it encourages
> applications to do the wrong thing. If you want to keep it, I'd like to
> know what use cases you envision would strongly require it.
> 

OK, I'll drop it. Thank you!

>> >> +	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
>> >> +	q->buf_struct_size = sizeof(struct stfcamss_buffer);
>> >> +	q->dev = video->stfcamss->dev;
>> >> +	q->lock = &video->q_lock;
>> >> +	q->min_buffers_needed = STFCAMSS_MIN_BUFFERS;
>> >> +	ret = vb2_queue_init(q);
>> >> +	if (ret < 0) {
>> >> +		dev_err(video->stfcamss->dev,
>> >> +			"Failed to init vb2 queue: %d\n", ret);
>> >> +		goto err_vb2_init;
>> >> +	}
>> >> +
>> >> +	pad->flags = MEDIA_PAD_FL_SINK;
>> >> +	ret = media_entity_pads_init(&vdev->entity, 1, pad);
>> >> +	if (ret < 0) {
>> >> +		dev_err(video->stfcamss->dev,
>> >> +			"Failed to init video entity: %d\n", ret);
>> >> +		goto err_vb2_init;
>> >> +	}
>> >> +
>> >> +	mutex_init(&video->lock);
>> >> +
>> >> +	if (video->id == STF_V_LINE_WR) {
>> >> +		video->formats = formats_pix_wr;
>> >> +		video->nformats = ARRAY_SIZE(formats_pix_wr);
>> >> +		video->bpl_alignment = 8;
>> >> +	} else {
>> >> +		video->formats = formats_pix_isp;
>> >> +		video->nformats = ARRAY_SIZE(formats_pix_isp);
>> >> +		video->bpl_alignment = 1;
>> >> +	}
>> >> +
>> >> +	ret = stf_video_init_format(video);
>> >> +	if (ret < 0) {
>> >> +		dev_err(video->stfcamss->dev,
>> >> +			"Failed to init format: %d\n", ret);
>> >> +		goto err_vid_init_format;
>> >> +	}
>> >> +
>> >> +	vdev->fops = &stf_vid_fops;
>> >> +	vdev->ioctl_ops = &stf_vid_ioctl_ops;
>> >> +	vdev->device_caps = V4L2_CAP_VIDEO_CAPTURE;
>> >> +	vdev->vfl_dir = VFL_DIR_RX;
>> >> +	vdev->device_caps |= V4L2_CAP_STREAMING | V4L2_CAP_READWRITE;
>> >> +	vdev->release = stf_video_release;
>> >> +	vdev->v4l2_dev = v4l2_dev;
>> >> +	vdev->queue = &video->vb2_q;
>> >> +	vdev->lock = &video->lock;
>> >> +	strscpy(vdev->name, name, sizeof(vdev->name));
>> >> +
>> >> +	ret = video_register_device(vdev, VFL_TYPE_VIDEO, video->id);
>> >> +	if (ret < 0) {
>> >> +		dev_err(video->stfcamss->dev,
>> >> +			"Failed to register video device: %d\n", ret);
>> >> +		goto err_vid_reg;
>> >> +	}
>> >> +
>> >> +	video_set_drvdata(vdev, video);
>> >> +	return 0;
>> >> +
>> >> +err_vid_reg:
>> >> +err_vid_init_format:
>> >> +	media_entity_cleanup(&vdev->entity);
>> >> +	mutex_destroy(&video->lock);
>> >> +err_vb2_init:
>> >> +	mutex_destroy(&video->q_lock);
>> >> +	return ret;
>> >> +}
> 
> [snip]
> 
