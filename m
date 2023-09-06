Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9926A793ADC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 13:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238125AbjIFLPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 07:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbjIFLPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 07:15:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97E2A8;
        Wed,  6 Sep 2023 04:14:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 059E0C433C8;
        Wed,  6 Sep 2023 11:14:56 +0000 (UTC)
Message-ID: <5bcdbe39-99a5-b1f8-4599-d9b042248c8c@xs4all.nl>
Date:   Wed, 6 Sep 2023 13:14:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC PATCH 2/3] media: Add Google Chameleon v3 video driver
Content-Language: en-US, nl
To:     =?UTF-8?Q?Pawe=c5=82_Anikiel?= <pan@semihalf.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Cc:     dinguyen@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        mchehab@kernel.org, upstream@semihalf.com, amstan@chromium.org,
        ribalda@chromium.org
References: <20230630144006.1513270-1-pan@semihalf.com>
 <20230630144006.1513270-3-pan@semihalf.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20230630144006.1513270-3-pan@semihalf.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/06/2023 16:40, Paweł Anikiel wrote:
> Add driver for the video system present on the Chameleon v3. It
> consists of two Intel DisplayPort DPRX IP cores and six video
> interfaces (here called "framebuffers").
> 
> Signed-off-by: Paweł Anikiel <pan@semihalf.com>
> ---
>  drivers/media/platform/Kconfig                |   1 +
>  drivers/media/platform/Makefile               |   1 +
>  drivers/media/platform/google/Kconfig         |   4 +
>  drivers/media/platform/google/Makefile        |   2 +
>  .../media/platform/google/chameleonv3/Kconfig |   9 +
>  .../platform/google/chameleonv3/Makefile      |  15 +
>  .../platform/google/chameleonv3/chv3-core.c   | 292 ++++++++++
>  .../platform/google/chameleonv3/chv3-core.h   |  17 +
>  .../platform/google/chameleonv3/chv3-fb.c     | 539 ++++++++++++++++++
>  .../platform/google/chameleonv3/chv3-fb.h     |  34 ++
>  .../platform/google/chameleonv3/dprx-aux.c    |  77 +++
>  .../platform/google/chameleonv3/dprx-dp.c     |  82 +++
>  .../platform/google/chameleonv3/dprx-dpcd.c   | 424 ++++++++++++++
>  .../platform/google/chameleonv3/dprx-dprx.c   | 262 +++++++++
>  .../platform/google/chameleonv3/dprx-edid.c   |  39 ++
>  .../platform/google/chameleonv3/dprx-i2c.c    |  41 ++
>  .../platform/google/chameleonv3/dprx-mt.c     | 184 ++++++
>  .../platform/google/chameleonv3/dprx-sbmsg.c  | 162 ++++++
>  .../media/platform/google/chameleonv3/dprx.h  | 128 +++++
>  19 files changed, 2313 insertions(+)
>  create mode 100644 drivers/media/platform/google/Kconfig
>  create mode 100644 drivers/media/platform/google/Makefile
>  create mode 100644 drivers/media/platform/google/chameleonv3/Kconfig
>  create mode 100644 drivers/media/platform/google/chameleonv3/Makefile
>  create mode 100644 drivers/media/platform/google/chameleonv3/chv3-core.c
>  create mode 100644 drivers/media/platform/google/chameleonv3/chv3-core.h
>  create mode 100644 drivers/media/platform/google/chameleonv3/chv3-fb.c
>  create mode 100644 drivers/media/platform/google/chameleonv3/chv3-fb.h
>  create mode 100644 drivers/media/platform/google/chameleonv3/dprx-aux.c
>  create mode 100644 drivers/media/platform/google/chameleonv3/dprx-dp.c
>  create mode 100644 drivers/media/platform/google/chameleonv3/dprx-dpcd.c
>  create mode 100644 drivers/media/platform/google/chameleonv3/dprx-dprx.c
>  create mode 100644 drivers/media/platform/google/chameleonv3/dprx-edid.c
>  create mode 100644 drivers/media/platform/google/chameleonv3/dprx-i2c.c
>  create mode 100644 drivers/media/platform/google/chameleonv3/dprx-mt.c
>  create mode 100644 drivers/media/platform/google/chameleonv3/dprx-sbmsg.c
>  create mode 100644 drivers/media/platform/google/chameleonv3/dprx.h
> 
> diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
> index ee579916f874..2f15336cd25e 100644
> --- a/drivers/media/platform/Kconfig
> +++ b/drivers/media/platform/Kconfig
> @@ -69,6 +69,7 @@ source "drivers/media/platform/aspeed/Kconfig"
>  source "drivers/media/platform/atmel/Kconfig"
>  source "drivers/media/platform/cadence/Kconfig"
>  source "drivers/media/platform/chips-media/Kconfig"
> +source "drivers/media/platform/google/Kconfig"
>  source "drivers/media/platform/intel/Kconfig"
>  source "drivers/media/platform/marvell/Kconfig"
>  source "drivers/media/platform/mediatek/Kconfig"
> diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Makefile
> index 5453bb868e67..db4a0fc7bfd3 100644
> --- a/drivers/media/platform/Makefile
> +++ b/drivers/media/platform/Makefile
> @@ -12,6 +12,7 @@ obj-y += aspeed/
>  obj-y += atmel/
>  obj-y += cadence/
>  obj-y += chips-media/
> +obj-y += google/
>  obj-y += intel/
>  obj-y += marvell/
>  obj-y += mediatek/
> diff --git a/drivers/media/platform/google/Kconfig b/drivers/media/platform/google/Kconfig
> new file mode 100644
> index 000000000000..8dd3a955bef8
> --- /dev/null
> +++ b/drivers/media/platform/google/Kconfig
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +source "drivers/media/platform/google/chameleonv3/Kconfig"
> +
> diff --git a/drivers/media/platform/google/Makefile b/drivers/media/platform/google/Makefile
> new file mode 100644
> index 000000000000..c971a09faeb4
> --- /dev/null
> +++ b/drivers/media/platform/google/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +obj-y += chameleonv3/
> diff --git a/drivers/media/platform/google/chameleonv3/Kconfig b/drivers/media/platform/google/chameleonv3/Kconfig
> new file mode 100644
> index 000000000000..ef5130843301
> --- /dev/null
> +++ b/drivers/media/platform/google/chameleonv3/Kconfig
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +config VIDEO_CHAMELEONV3
> +	tristate "Google Chameleon v3 video system driver"
> +	depends on V4L_PLATFORM_DRIVERS
> +	depends on VIDEO_DEV
> +	select VIDEOBUF2_DMA_CONTIG
> +	help
> +	  Enable support for the Google Chameleon v3 video system driver.

This help text could use a bit more work...

> diff --git a/drivers/media/platform/google/chameleonv3/Makefile b/drivers/media/platform/google/chameleonv3/Makefile
> new file mode 100644
> index 000000000000..d65e3c392127
> --- /dev/null
> +++ b/drivers/media/platform/google/chameleonv3/Makefile
> @@ -0,0 +1,15 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +chv3-video-objs := \
> +	chv3-core.o \
> +	chv3-fb.o \
> +	dprx-aux.o \
> +	dprx-dp.o \
> +	dprx-dpcd.o \
> +	dprx-dprx.o \
> +	dprx-edid.o \
> +	dprx-i2c.o \
> +	dprx-mt.o \
> +	dprx-sbmsg.o
> +
> +obj-$(CONFIG_VIDEO_CHAMELEONV3) += chv3-video.o
> diff --git a/drivers/media/platform/google/chameleonv3/chv3-core.c b/drivers/media/platform/google/chameleonv3/chv3-core.c
> new file mode 100644
> index 000000000000..b571c0afb8bd
> --- /dev/null
> +++ b/drivers/media/platform/google/chameleonv3/chv3-core.c
> @@ -0,0 +1,292 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Driver for Chameleon v3 framebuffer
> + *
> + * Copyright 2022 Google LLC.

2023? Or 2022-2023?

> + */
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +#include <linux/of.h>
> +
> +#include <linux/dma-mapping.h>
> +#include <linux/interrupt.h>
> +
> +#include <linux/videodev2.h>
> +#include <media/v4l2-device.h>
> +#include <media/v4l2-ioctl.h>
> +#include <media/videobuf2-dma-contig.h>
> +
> +#include "chv3-core.h"
> +
> +#define MODULE_NAME "chv3-video"

Hmm, that's a bit obscure. How about chameleonv3-video?

> +
> +static const struct chv3_fb_cfg fb0_cfg = {
> +	.reg_core = "fb0",
> +	.reg_irq = "fb0_irq",
> +	.irq = "fb0",
> +	.index = 0,
> +};
> +
> +static const struct chv3_fb_cfg fb_mst_cfg[4] = {
> +{
> +	.reg_core = "fb_mst1",
> +	.reg_irq = "fb_mst1_irq",
> +	.irq = "fb_mst1",
> +	.index = 1,
> +},
> +{
> +	.reg_core = "fb_mst2",
> +	.reg_irq = "fb_mst2_irq",
> +	.irq = "fb_mst2",
> +	.index = 2,
> +},
> +{
> +	.reg_core = "fb_mst3",
> +	.reg_irq = "fb_mst3_irq",
> +	.irq = "fb_mst3",
> +	.index = 3,
> +},
> +{
> +	.reg_core = "fb_mst4",
> +	.reg_irq = "fb_mst4_irq",
> +	.irq = "fb_mst4",
> +	.index = 4,
> +},
> +};
> +
> +static const struct chv3_fb_cfg fb_sst_cfg = {
> +	.reg_core = "fb_sst",
> +	.reg_irq = "fb_sst_irq",
> +	.irq = "fb_sst",
> +	.index = 5,
> +};
> +
> +static const struct dprx_dp_cfg dp_mst_cfg = {
> +	.reg_core = "dp_mst",
> +	.reg_irq = "dp_mst_irq",
> +	.irq = "dp_mst",
> +	.has_mst = 1,
> +	.sink_count = 4,
> +};
> +
> +static const struct dprx_dp_cfg dp_sst_cfg = {
> +	.reg_core = "dp_sst",
> +	.reg_irq = "dp_sst_irq",
> +	.irq = "dp_sst",
> +	.has_mst = 0,
> +	.sink_count = 1,
> +};
> +
> +int chv3_g_edid(struct chv3_video *video, int index, struct v4l2_edid *edid)
> +{
> +	u32 end_block = edid->start_block + edid->blocks;
> +	struct sink *sink;
> +
> +	if (index == 0 || index > 5)

You should probably use a define instead of '5'.

> +		return -ENOTTY;
> +	if (edid->pad)
> +		return -EINVAL;
> +
> +	if (1 <= index && index <= 4)
> +		sink = &video->dp_mst.sinks[index-1];
> +	else
> +		sink = &video->dp_sst.sinks[0];
> +
> +	if (edid->start_block == 0 && edid->blocks == 0) {
> +		edid->blocks = sink->blocks;
> +		return 0;
> +	}
> +
> +	if (edid->start_block > sink->blocks)
> +		return -EINVAL;
> +	if (end_block > sink->blocks) {
> +		end_block = sink->blocks;
> +		edid->blocks = end_block - edid->start_block;
> +	}
> +
> +	memcpy(edid->edid, sink->edid + edid->start_block * 128, edid->blocks * 128);
> +
> +	return 0;
> +}
> +
> +int chv3_s_edid(struct chv3_video *video, int index, struct v4l2_edid *edid)
> +{
> +	struct sink *sink;
> +
> +	if (index == 0 || index > 5)
> +		return -ENOTTY;
> +	if (edid->pad)
> +		return -EINVAL;
> +
> +	if (1 <= index && index <= 4)
> +		sink = &video->dp_mst.sinks[index-1];
> +	else
> +		sink = &video->dp_sst.sinks[0];
> +
> +	if (edid->start_block != 0)
> +		return -EINVAL;
> +	if (edid->blocks > DPRX_MAX_EDID_BLOCKS) {
> +		edid->blocks = DPRX_MAX_EDID_BLOCKS;
> +		return -E2BIG;
> +	}
> +
> +	sink->blocks = edid->blocks;
> +	memcpy(sink->edid, edid->edid, edid->blocks * 128);
> +
> +	return 0;
> +}
> +
> +
> +static ssize_t dp_hpd_show(struct device *dev, struct device_attribute *attr,
> +			   char *buf);
> +static ssize_t dp_hpd_store(struct device *dev, struct device_attribute *attr,
> +			    const char *buf, size_t count);
> +
> +static struct device_attribute dev_attr_dp0_hpd = {
> +	.attr = { .name = "hpd", .mode = 0644 },
> +	.show = dp_hpd_show,
> +	.store = dp_hpd_store,
> +};
> +
> +static struct device_attribute dev_attr_dp1_hpd = {
> +	.attr = { .name = "hpd", .mode = 0644 },
> +	.show = dp_hpd_show,
> +	.store = dp_hpd_store,
> +};
> +
> +static struct attribute *dp0_attrs[] = {
> +	&dev_attr_dp0_hpd.attr,
> +	NULL,
> +};
> +
> +static struct attribute *dp1_attrs[] = {
> +	&dev_attr_dp1_hpd.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group dp0_attr_group = {
> +	.name = "dp0",
> +	.attrs = dp0_attrs,
> +};
> +
> +static struct attribute_group dp1_attr_group = {
> +	.name = "dp1",
> +	.attrs = dp1_attrs,
> +};
> +
> +static ssize_t dp_hpd_show(struct device *dev, struct device_attribute *attr,
> +			   char *buf)
> +{
> +	struct chv3_video *video = dev_get_drvdata(dev);
> +	struct dprx_dp *dp;
> +
> +	if (attr == &dev_attr_dp0_hpd)
> +		dp = &video->dp_mst;
> +	else
> +		dp = &video->dp_sst;
> +
> +	return sprintf(buf, "%d\n", dprx_dprx_get_hpd(dp));
> +}
> +
> +static ssize_t dp_hpd_store(struct device *dev, struct device_attribute *attr,
> +			    const char *buf, size_t count)
> +{
> +	struct chv3_video *video = dev_get_drvdata(dev);
> +	struct dprx_dp *dp;
> +	unsigned long val;
> +	int res;
> +
> +	if (attr == &dev_attr_dp0_hpd)
> +		dp = &video->dp_mst;
> +	else
> +		dp = &video->dp_sst;
> +
> +	res = kstrtoul(buf, 10, &val);
> +	if (res)
> +		return res;
> +
> +	dprx_dprx_set_hpd(dp, val);
> +	return count;
> +}

My guess is that this is added to allow userspace to toggle the HPD when it
sets the EDID. But this is something the s_edid should do. Typically it will
pull the HPD low, then update the EDID and start delayed work to pull the HPD
high again after 100ms.

You might still want to keep this to do debugging, but you don't need this
for dealing with EDID changes, the driver should take care of that.

> +
> +static int chv3_video_probe(struct platform_device *pdev)
> +{
> +	struct chv3_video *video;
> +	int res;
> +	int i;
> +
> +	video = devm_kzalloc(&pdev->dev, sizeof(*video), GFP_KERNEL);
> +	if (!video)
> +		return -ENOMEM;
> +	video->dev = &pdev->dev;
> +	platform_set_drvdata(pdev, video);
> +
> +	/* register v4l2_device */
> +	res = v4l2_device_register(video->dev, &video->v4l2_dev);
> +	if (res)
> +		return res;
> +
> +	/* initialize fb devices */
> +	res = chv3_fb_register(&video->fb0, video, &fb0_cfg);
> +	if (res)
> +		return res;
> +
> +	for (i = 0; i < 4; i++) {
> +		res = chv3_fb_register(&video->fb_mst[i], video, &fb_mst_cfg[i]);
> +		if (res)
> +			return res;
> +	}
> +
> +	res = chv3_fb_register(&video->fb_sst, video, &fb_sst_cfg);
> +	if (res)
> +		return res;
> +
> +	/* initialize dp devices */
> +	res = dprx_dp_init(&video->dp_mst, video->dev, &dp_mst_cfg);
> +	if (res)
> +		return res;
> +
> +	res = dprx_dp_init(&video->dp_sst, video->dev, &dp_sst_cfg);
> +	if (res)
> +		return res;
> +
> +	/* create sysfs files */
> +	res = sysfs_create_group(&video->dev->kobj, &dp0_attr_group);
> +	if (res)
> +		return res;
> +
> +	res = sysfs_create_group(&video->dev->kobj, &dp1_attr_group);
> +	if (res)
> +		return res;
> +
> +	return 0;
> +}
> +
> +static int chv3_video_remove(struct platform_device *pdev)
> +{
> +	struct chv3_video *video = platform_get_drvdata(pdev);
> +
> +	v4l2_device_unregister(&video->v4l2_dev);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id chv3_video_match_table[] = {
> +	{ .compatible = "google,chv3-video" },

I would lean towards writing "google,chameleonv3-video" here as well.

> +	{ },
> +};
> +
> +static struct platform_driver chv3_video_platform_driver = {
> +	.probe = chv3_video_probe,
> +	.remove = chv3_video_remove,
> +	.driver = {
> +		.name = MODULE_NAME,
> +		.of_match_table = chv3_video_match_table,
> +	},
> +};
> +
> +module_platform_driver(chv3_video_platform_driver);
> +
> +MODULE_LICENSE("GPL");
> +
> diff --git a/drivers/media/platform/google/chameleonv3/chv3-core.h b/drivers/media/platform/google/chameleonv3/chv3-core.h
> new file mode 100644
> index 000000000000..9a435cba25bd
> --- /dev/null
> +++ b/drivers/media/platform/google/chameleonv3/chv3-core.h
> @@ -0,0 +1,17 @@
> +#include "chv3-fb.h"
> +#include "dprx.h"
> +
> +struct chv3_video {
> +	struct device *dev;
> +	struct v4l2_device v4l2_dev;
> +
> +	struct chv3_fb fb0;
> +	struct chv3_fb fb_mst[4];
> +	struct chv3_fb fb_sst;
> +
> +	struct dprx_dp dp_mst;
> +	struct dprx_dp dp_sst;
> +};
> +
> +int chv3_g_edid(struct chv3_video *video, int index, struct v4l2_edid *edid);
> +int chv3_s_edid(struct chv3_video *video, int index, struct v4l2_edid *edid);
> diff --git a/drivers/media/platform/google/chameleonv3/chv3-fb.c b/drivers/media/platform/google/chameleonv3/chv3-fb.c
> new file mode 100644
> index 000000000000..a9b97d637ed5
> --- /dev/null
> +++ b/drivers/media/platform/google/chameleonv3/chv3-fb.c
> @@ -0,0 +1,539 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Driver for Chameleon v3 framebuffer
> + *
> + * Copyright 2022 Google LLC.
> + */
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +#include <linux/of.h>
> +
> +#include <linux/delay.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/interrupt.h>
> +
> +#include <linux/videodev2.h>
> +#include <media/v4l2-device.h>
> +#include <media/v4l2-ioctl.h>
> +#include <media/videobuf2-dma-contig.h>
> +
> +#include "chv3-core.h"
> +
> +#define MODULE_NAME	"chv3-fb"
> +
> +#define FB_EN		0x00
> +#define FB_HEIGHT	0x04
> +#define FB_WIDTH	0x08
> +#define FB_BUFFERA	0x0c
> +#define FB_BUFFERB	0x10
> +#define FB_BUFFERSIZE	0x14
> +#define FB_RESET	0x18
> +#define FB_ERRORSTATUS	0x1c
> +#define FB_IOCOLOR	0x20
> +#define FB_IODATARATE	0x24
> +#define FB_IOPIXELMODE	0x28
> +#define FB_SYNCPOLARITY	0x2c
> +#define FB_DMAFORMAT	0x30
> +#define FB_VERSION	0x34
> +#define FB_VERSION_CURRENT	0xc0fb0001
> +#define FB_IRQ_MASK	0x8
> +#define FB_IRQ_CLR	0xc
> +#define FB_IRQ_ALL	0xf
> +#define FB_IRQ_BUFF0		(1 << 0)
> +#define FB_IRQ_BUFF1		(1 << 1)
> +#define FB_IRQ_RESOLUTION	(1 << 2)
> +#define FB_IRQ_ERROR		(1 << 3)
> +
> +struct chv3_fb_buffer {
> +	struct vb2_v4l2_buffer vb;
> +	struct list_head link;
> +};
> +
> +struct chv3_dma_format {
> +	u32 id;
> +	u32 pixfmt;
> +	int bpp;
> +};
> +
> +struct chv3_dma_format chv3_dma_formats[] = {
> +	{ 0, V4L2_PIX_FMT_RGB24 , 3 },
> +	{ 1, V4L2_PIX_FMT_RGB30U, 6 },
> +	{ 2, V4L2_PIX_FMT_RGB30L, 6 },
> +	{ 3, V4L2_PIX_FMT_RGB36U, 6 },
> +	{ 4, V4L2_PIX_FMT_RGB36L, 6 },
> +	{ 5, V4L2_PIX_FMT_RGB48 , 6 },
> +	{ 7, V4L2_PIX_FMT_BGRX32, 4 },
> +};
> +
> +static void fb_set_dma_format(struct chv3_fb *fb, struct chv3_dma_format *dmaf)
> +{
> +	writel(dmaf->id, fb->iobase + FB_DMAFORMAT);
> +	/* we need to wait one frame for the width/height to update */
> +	mdelay(50);
> +	fb->fmt.width  = readl(fb->iobase + FB_WIDTH);
> +	fb->fmt.height = readl(fb->iobase + FB_HEIGHT);
> +
> +	fb->fmt.pixelformat = dmaf->pixfmt;
> +	fb->fmt.field = V4L2_FIELD_NONE;
> +	fb->fmt.bytesperline = fb->fmt.width * dmaf->bpp;
> +	fb->fmt.sizeimage = fb->fmt.bytesperline * fb->fmt.height;
> +	fb->fmt.colorspace = V4L2_COLORSPACE_SRGB;
> +
> +	writel(fb->fmt.sizeimage, fb->iobase + FB_BUFFERSIZE);
> +}
> +
> +/* v4l2 ioctls */
> +
> +static int vidioc_querycap(struct file *file, void *data,
> +			   struct v4l2_capability *cap)
> +{
> +	strscpy(cap->driver, MODULE_NAME, sizeof(cap->driver));
> +	strscpy(cap->card, "Chameleonv3 framebuffer", sizeof(cap->card));
> +	snprintf(cap->bus_info, sizeof(cap->bus_info), "platform:%s",
> +		 MODULE_NAME);

bus_info is set automatically for platform devices, so you can drop that.

> +
> +	return 0;
> +}
> +
> +/*
> + * We can't control the resolution, we can only read what it currently is from
> + * the framebuffer. In order not to confuse the application, the resolution is
> + * saved in fb->fmt, and is only updated when the application calls open() and
> + * there are no other applications that have the file opened.
> + */

Why not use the DV_TIMINGS API?
https://linuxtv.org/downloads/v4l-dvb-apis-new/userspace-api/v4l/dv-timings.html

That's meant for e.g. HDMI capture where the resolution can change. It seems much
more appropriate for this.

> +
> +static int vidioc_g_fmt_vid_cap(struct file *file, void *data,
> +				struct v4l2_format *fmt)
> +{
> +	struct chv3_fb *fb = video_drvdata(file);
> +
> +	fmt->fmt.pix = fb->fmt;
> +	return 0;
> +}
> +
> +static int vidioc_s_fmt_vid_cap(struct file *file, void *data,
> +				struct v4l2_format *fmt)
> +{
> +	struct chv3_fb *fb = video_drvdata(file);
> +
> +	if (fmt->type == V4L2_BUF_TYPE_VIDEO_CAPTURE) {
> +		struct chv3_dma_format *dmaf;
> +
> +		for (dmaf = chv3_dma_formats; dmaf < &chv3_dma_formats[ARRAY_SIZE(chv3_dma_formats)]; dmaf++) {
> +			if (dmaf->pixfmt == fmt->fmt.pix.pixelformat) {
> +				fb_set_dma_format(fb, dmaf);
> +				break;
> +			}
> +		}
> +	}
> +
> +	fmt->fmt.pix = fb->fmt;
> +	return 0;
> +}
> +
> +static int vidioc_enum_fmt_vid_cap(struct file *file, void *data,
> +				   struct v4l2_fmtdesc *fmt)
> +{
> +	if (fmt->index >= ARRAY_SIZE(chv3_dma_formats))
> +		return -EINVAL;
> +	fmt->flags = 0;
> +	fmt->pixelformat = chv3_dma_formats[fmt->index].pixfmt;
> +	return 0;
> +}
> +
> +static int vidioc_enum_framesizes(struct file *file, void *data,
> +				  struct v4l2_frmsizeenum *frm)
> +{
> +	struct chv3_fb *fb = video_drvdata(file);
> +	struct chv3_dma_format *dmaf;
> +	bool fmt_ok = false;
> +
> +	if (frm->index != 0)
> +		return -EINVAL;
> +
> +	for (dmaf = chv3_dma_formats; dmaf < &chv3_dma_formats[ARRAY_SIZE(chv3_dma_formats)]; dmaf++) {
> +		if (dmaf->pixfmt == frm->pixel_format) {
> +			fmt_ok = true;
> +			break;
> +		}
> +	}
> +	if (!fmt_ok)
> +		return -EINVAL;
> +
> +	frm->type = V4L2_FRMSIZE_TYPE_DISCRETE;
> +	frm->discrete.width  = fb->fmt.width;
> +	frm->discrete.height = fb->fmt.height;
> +	return 0;
> +}
> +
> +static int vidioc_g_input(struct file *file, void *data, unsigned int *index)
> +{
> +	*index = 0;
> +	return 0;
> +}
> +
> +static int vidioc_s_input(struct file *file, void *data, unsigned int index)
> +{
> +	if (index != 0)
> +		return -EINVAL;
> +	return 0;
> +}
> +
> +static int vidioc_enum_input(struct file *file, void *data,
> +			     struct v4l2_input *input)
> +{
> +	if (input->index != 0)
> +		return -EINVAL;
> +	strcpy(input->name, "input0");
> +	input->type = V4L2_INPUT_TYPE_CAMERA;
> +	return 0;
> +}
> +
> +static int vidioc_g_edid(struct file *file, void *data,
> +			 struct v4l2_edid *edid)
> +{
> +	struct chv3_fb *fb = video_drvdata(file);
> +
> +	return chv3_g_edid(fb->parent, fb->index, edid);
> +}
> +
> +static int vidioc_s_edid(struct file *file, void *data,
> +			 struct v4l2_edid *edid)
> +{
> +	struct chv3_fb *fb = video_drvdata(file);
> +
> +	return chv3_s_edid(fb->parent, fb->index, edid);
> +}
> +
> +static const struct v4l2_ioctl_ops fb_v4l2_ioctl_ops = {
> +	.vidioc_querycap = vidioc_querycap,
> +
> +	.vidioc_enum_fmt_vid_cap = vidioc_enum_fmt_vid_cap,
> +	.vidioc_g_fmt_vid_cap = vidioc_g_fmt_vid_cap,
> +	.vidioc_s_fmt_vid_cap = vidioc_s_fmt_vid_cap,
> +	.vidioc_try_fmt_vid_cap = vidioc_g_fmt_vid_cap,
> +
> +	.vidioc_enum_framesizes = vidioc_enum_framesizes,
> +
> +	.vidioc_enum_input = vidioc_enum_input,
> +	.vidioc_g_input = vidioc_g_input,
> +	.vidioc_s_input = vidioc_s_input,
> +	.vidioc_g_edid = vidioc_g_edid,
> +	.vidioc_s_edid = vidioc_s_edid,
> +
> +	.vidioc_reqbufs = vb2_ioctl_reqbufs,
> +	.vidioc_create_bufs = vb2_ioctl_create_bufs,
> +	.vidioc_querybuf = vb2_ioctl_querybuf,

Add prepare_buf and expbuf as well. No need to leave those out.

> +	.vidioc_qbuf = vb2_ioctl_qbuf,
> +	.vidioc_dqbuf = vb2_ioctl_dqbuf,
> +	.vidioc_streamon = vb2_ioctl_streamon,
> +	.vidioc_streamoff = vb2_ioctl_streamoff,
> +};
> +
> +/* videobuf2 operations */
> +
> +static int fb_queue_setup(struct vb2_queue *q,
> +		       unsigned int *nbuffers, unsigned int *nplanes,
> +		       unsigned int sizes[], struct device *alloc_devs[])
> +{
> +	struct chv3_fb *fb = vb2_get_drv_priv(q);
> +
> +	if (!fb->fmt.sizeimage)
> +		return -EIO;

Hmm, V4L2 expects that there is always a valid video format, so this should
never happen. If it doesn't know the correct video format (typical for e.g.
HDMI/DP inputs), then it just defaults to something reasonable (1920x1080 or so).

> +
> +	if (*nplanes) {
> +		if (sizes[0] < fb->fmt.sizeimage)
> +			return -EINVAL;
> +		return 0;
> +	}
> +	*nplanes = 1;
> +	sizes[0] = fb->fmt.sizeimage;
> +	return 0;
> +}
> +
> +/*
> + * There are two address registers: BUFFERA and BUFFERB. The framebuffer
> + * alternates writing between them (i.e. even frames go to BUFFERA, odd
> + * ones to BUFFERB).
> + *
> + *  (buffer queue) >     QUEUED ---> QUEUED ---> QUEUED ---> ...
> + *                       BUFFERA     BUFFERB
> + *  (hw writing to this) ^
> + *                (and then to this) ^
> + *
> + * The buffer swapping happens at irq time. When an irq comes, the next
> + * frame is already assigned an address in the buffer queue. This gives
> + * the irq handler a whole frame's worth of time to update the buffer
> + * address register.
> + */
> +
> +static dma_addr_t fb_buffer_dma_addr(struct chv3_fb_buffer *buf)
> +{
> +	return vb2_dma_contig_plane_dma_addr(&buf->vb.vb2_buf, 0);
> +}
> +
> +static void fb_start_frame(struct chv3_fb *fb, struct chv3_fb_buffer *buf)
> +{
> +	fb->writing_to_a = 1;
> +	writel(fb_buffer_dma_addr(buf), fb->iobase + FB_BUFFERA);
> +	writel(1, fb->iobase + FB_EN);
> +}
> +
> +static void fb_next_frame(struct chv3_fb *fb, struct chv3_fb_buffer *buf)
> +{
> +	u32 reg = fb->writing_to_a ? FB_BUFFERB : FB_BUFFERA;
> +
> +	writel(fb_buffer_dma_addr(buf), fb->iobase + reg);
> +}
> +
> +static int fb_start_streaming(struct vb2_queue *q, unsigned int count)
> +{
> +	struct chv3_fb *fb = vb2_get_drv_priv(q);
> +	struct chv3_fb_buffer *buf;
> +	unsigned long flags;
> +
> +	fb->streaming = 1;

You can let vb2_queue keep track of the streaming state: vb2_is_streaming(q).

> +	fb->sequence = 0;
> +
> +	spin_lock_irqsave(&fb->bufs_lock, flags);
> +	buf = list_first_entry_or_null(&fb->bufs, struct chv3_fb_buffer, link);
> +	if (buf) {
> +		fb_start_frame(fb, buf);
> +		if (!list_is_last(&buf->link, &fb->bufs))
> +			fb_next_frame(fb, list_next_entry(buf, link));
> +	}
> +	spin_unlock_irqrestore(&fb->bufs_lock, flags);
> +
> +	return 0;
> +}
> +
> +static void fb_stop_streaming(struct vb2_queue *q)
> +{
> +	struct chv3_fb *fb = vb2_get_drv_priv(q);
> +	struct chv3_fb_buffer *buf;
> +	unsigned long flags;
> +
> +	fb->streaming = 0;
> +	writel(0, fb->iobase + FB_EN);
> +
> +	spin_lock_irqsave(&fb->bufs_lock, flags);
> +	list_for_each_entry(buf, &fb->bufs, link)
> +		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
> +	INIT_LIST_HEAD(&fb->bufs);
> +	spin_unlock_irqrestore(&fb->bufs_lock, flags);
> +}
> +
> +static struct chv3_fb_buffer *to_chv3_fb_buffer(struct vb2_v4l2_buffer *b)
> +{
> +	return container_of(b, struct chv3_fb_buffer, vb);
> +}
> +
> +static void fb_buf_queue(struct vb2_buffer *vb)
> +{
> +	struct chv3_fb *fb = vb2_get_drv_priv(vb->vb2_queue);
> +	struct vb2_v4l2_buffer *v4l2_buf = to_vb2_v4l2_buffer(vb);
> +	struct chv3_fb_buffer *buf = to_chv3_fb_buffer(v4l2_buf);
> +	bool first, second;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&fb->bufs_lock, flags);
> +	first = list_empty(&fb->bufs);
> +	second = list_is_singular(&fb->bufs);
> +	list_add_tail(&buf->link, &fb->bufs);
> +	if (fb->streaming) {
> +		if (first)
> +			fb_start_frame(fb, buf);
> +		else if (second)
> +			fb_next_frame(fb, buf);
> +	}
> +	spin_unlock_irqrestore(&fb->bufs_lock, flags);
> +}
> +
> +static const struct vb2_ops fb_vb2_ops = {
> +	.queue_setup = fb_queue_setup,
> +	.wait_prepare = vb2_ops_wait_prepare,
> +	.wait_finish = vb2_ops_wait_finish,
> +	.start_streaming = fb_start_streaming,
> +	.stop_streaming = fb_stop_streaming,
> +	.buf_queue = fb_buf_queue,
> +};
> +
> +/* file operations */
> +
> +static int fb_open(struct file *file)
> +{
> +	struct chv3_fb *fb = video_drvdata(file);
> +	int res;
> +
> +	mutex_lock(&fb->fb_lock);
> +	res = v4l2_fh_open(file);
> +	if (!res) {
> +		if (v4l2_fh_is_singular_file(file))
> +			fb_set_dma_format(fb, &chv3_dma_formats[0]);
> +	}
> +	mutex_unlock(&fb->fb_lock);
> +
> +	return res;
> +}
> +
> +static const struct v4l2_file_operations fb_v4l2_fops = {
> +	.owner = THIS_MODULE,
> +	.open = fb_open,
> +	.release = vb2_fop_release,
> +	.unlocked_ioctl = video_ioctl2,
> +	.mmap = vb2_fop_mmap,
> +	.poll = vb2_fop_poll,
> +};
> +
> +/* irq handling */
> +
> +static void fb_frame_irq(struct chv3_fb *fb)
> +{
> +	struct chv3_fb_buffer *buf;
> +
> +	spin_lock(&fb->bufs_lock);
> +
> +	buf = list_first_entry_or_null(&fb->bufs, struct chv3_fb_buffer, link);
> +	if (!buf)
> +		goto empty;
> +	list_del(&buf->link);
> +
> +	vb2_set_plane_payload(&buf->vb.vb2_buf, 0, fb->fmt.sizeimage);
> +	buf->vb.vb2_buf.timestamp = ktime_get_ns();
> +	buf->vb.sequence = fb->sequence++;
> +	buf->vb.field = V4L2_FIELD_NONE;
> +	vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_DONE);
> +
> +	buf = list_first_entry_or_null(&fb->bufs, struct chv3_fb_buffer, link);
> +	if (buf) {
> +		fb->writing_to_a = !fb->writing_to_a;
> +		if (!list_is_last(&buf->link, &fb->bufs))
> +			fb_next_frame(fb, list_next_entry(buf, link));
> +	} else {
> +		writel(0, fb->iobase + FB_EN);
> +	}
> +empty:
> +	spin_unlock(&fb->bufs_lock);
> +}
> +
> +static irqreturn_t fb_isr(int irq, void *data)
> +{
> +	struct chv3_fb *fb = data;
> +	unsigned int reg;
> +
> +	reg = readl(fb->iobase_irq + FB_IRQ_CLR);
> +	if (!reg)
> +		return IRQ_NONE;
> +
> +	if (reg & (FB_IRQ_BUFF0 | FB_IRQ_BUFF1))
> +		fb_frame_irq(fb);
> +	if (reg & FB_IRQ_ERROR) {
> +		dev_warn(fb->dev, "framebuffer error: 0x%x\n",
> +		       readl(fb->iobase + FB_ERRORSTATUS));
> +	}
> +
> +	writel(reg, fb->iobase_irq + FB_IRQ_CLR);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/* driver probe & remove */
> +
> +static int fb_check_version(struct chv3_fb *fb)
> +{
> +	u32 version;
> +
> +	version = readl(fb->iobase + FB_VERSION);
> +	if (version != FB_VERSION_CURRENT) {
> +		dev_warn(fb->dev,
> +			 "wrong framebuffer version: expected %x, got %x\n",
> +			 FB_VERSION_CURRENT, version);
> +		return -1;
> +	}
> +	return 0;
> +}
> +
> +int chv3_fb_register(struct chv3_fb *fb,
> +		     struct chv3_video *video,
> +		     const struct chv3_fb_cfg *cfg)
> +{
> +	struct platform_device *pdev = to_platform_device(video->dev);
> +	int res;
> +	int irq;
> +
> +	fb->dev = video->dev;
> +	fb->parent = video;
> +	fb->index = cfg->index;
> +
> +	/* map register space */
> +	fb->iobase = devm_platform_ioremap_resource_byname(pdev, cfg->reg_core);
> +	if (IS_ERR(fb->iobase))
> +		return -ENOMEM;
> +
> +	fb->iobase_irq = devm_platform_ioremap_resource_byname(pdev, cfg->reg_irq);
> +	if (IS_ERR(fb->iobase_irq))
> +		return -ENOMEM;
> +
> +	/* check hw version */
> +	if (fb_check_version(fb))
> +		return -ENODEV;
> +
> +	/* setup interrupts */
> +	irq = platform_get_irq_byname(pdev, cfg->irq);
> +	if (irq < 0)
> +		return -ENXIO;
> +	res = devm_request_irq(fb->dev, irq, fb_isr, 0, cfg->irq, fb);
> +	if (res)
> +		return res;
> +
> +	/* setup dma */
> +	dma_set_coherent_mask(fb->dev, DMA_BIT_MASK(32));
> +
> +	/* initialize vb2 queue */
> +	fb->queue.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
> +	fb->queue.io_modes = VB2_MMAP;

I strongly suggest adding VB2_DMABUF.

> +	fb->queue.dev = fb->dev;
> +	fb->queue.lock = &fb->fb_lock;
> +	fb->queue.ops = &fb_vb2_ops;
> +	fb->queue.mem_ops = &vb2_dma_contig_memops;
> +	fb->queue.drv_priv = fb;
> +	fb->queue.buf_struct_size = sizeof(struct chv3_fb_buffer);
> +	fb->queue.timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
> +	res = vb2_queue_init(&fb->queue);
> +	if (res)
> +		return res;
> +
> +	/* register video_device */
> +	strcpy(fb->vdev.name, MODULE_NAME);
> +	fb->vdev.fops = &fb_v4l2_fops;
> +	fb->vdev.ioctl_ops = &fb_v4l2_ioctl_ops;
> +	fb->vdev.lock = &fb->fb_lock;
> +	fb->vdev.release = video_device_release_empty;
> +	fb->vdev.device_caps =
> +		V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_STREAMING;
> +	fb->vdev.v4l2_dev = &video->v4l2_dev;
> +	fb->vdev.queue = &fb->queue;
> +	video_set_drvdata(&fb->vdev, fb);
> +	res = video_register_device(&fb->vdev, VFL_TYPE_VIDEO, -1);
> +	if (res)
> +		return res;
> +
> +	/* initialize rest of driver struct */
> +	INIT_LIST_HEAD(&fb->bufs);
> +	spin_lock_init(&fb->bufs_lock);
> +	mutex_init(&fb->fb_lock);
> +
> +	/* initialize hw */
> +	writel(1, fb->iobase + FB_RESET);
> +	writel(1, fb->iobase + FB_IODATARATE);
> +	writel(1, fb->iobase + FB_IOPIXELMODE);
> +	writel(FB_IRQ_BUFF0 | FB_IRQ_BUFF1 | FB_IRQ_ERROR, fb->iobase_irq + FB_IRQ_MASK);
> +
> +	return 0;
> +}
> +
> +void chv3_fb_unregister(struct chv3_fb *fb)
> +{
> +	video_unregister_device(&fb->vdev);
> +}
> diff --git a/drivers/media/platform/google/chameleonv3/chv3-fb.h b/drivers/media/platform/google/chameleonv3/chv3-fb.h
> new file mode 100644
> index 000000000000..2ece35a114df
> --- /dev/null
> +++ b/drivers/media/platform/google/chameleonv3/chv3-fb.h
> @@ -0,0 +1,34 @@
> +struct chv3_fb {
> +	struct device *dev;
> +	void __iomem *iobase;
> +	void __iomem *iobase_irq;
> +	struct chv3_video *parent;
> +	int index;
> +
> +	struct vb2_queue queue;
> +	struct video_device vdev;
> +	struct v4l2_pix_format fmt;
> +
> +	u32 sequence;
> +	bool streaming;
> +	bool writing_to_a;
> +
> +	struct list_head bufs;
> +	spinlock_t bufs_lock;
> +
> +	struct mutex fb_lock;
> +};
> +
> +struct chv3_fb_cfg {
> +	const char *reg_core;
> +	const char *reg_irq;
> +	const char *irq;
> +	int index;
> +};
> +
> +int chv3_fb_register(struct chv3_fb *fb,
> +		     struct chv3_video *video,
> +		     const struct chv3_fb_cfg *cfg);
> +
> +
> +void chv3_fb_unregister(struct chv3_fb *fb);
> diff --git a/drivers/media/platform/google/chameleonv3/dprx-aux.c b/drivers/media/platform/google/chameleonv3/dprx-aux.c
> new file mode 100644
> index 000000000000..56d82c963b4b
> --- /dev/null
> +++ b/drivers/media/platform/google/chameleonv3/dprx-aux.c
> @@ -0,0 +1,77 @@
> +#include <linux/string.h>
> +
> +#include "dprx.h"
> +
> +static void handle_i2c_read(struct dprx_dp *dp, struct aux_msg *req,
> +			    struct aux_msg *res)
> +{
> +	int r;
> +
> +	r = dprx_i2c_read(&dp->sinks[0], req->addr, res->data, req->len);
> +	if (!r) {
> +		res->cmd = AUX_ACK;
> +		res->len = req->len;
> +	} else {
> +		res->cmd = AUX_I2C_NACK;
> +		res->len = 0;
> +	}
> +}
> +
> +static void handle_i2c_write(struct dprx_dp *dp, struct aux_msg *req,
> +			     struct aux_msg *res)
> +{
> +	int r;
> +
> +	r = dprx_i2c_write(&dp->sinks[0], req->addr, req->data, req->len);
> +	if (!r)
> +		res->cmd = AUX_ACK;
> +	else
> +		res->cmd = AUX_I2C_NACK;
> +	res->len = 0;
> +}
> +
> +void dprx_aux_handle_request(struct dprx_dp *dp, struct aux_msg *req,
> +			     struct aux_msg *res)
> +{
> +	if (req->cmd & 8) {
> +		dprx_dpcd_access(dp, req, res);
> +	} else {
> +		if (req->cmd & 1)
> +			handle_i2c_read(dp, req, res);
> +		else
> +			handle_i2c_write(dp, req, res);
> +		if (!(req->cmd & 4))
> +			dp->sinks[0].segment = 0;
> +	}
> +}
> +
> +int dprx_aux_read_request(struct dprx_dp *dp, struct aux_msg *req)
> +{
> +	u8 data[20];
> +	int len;
> +
> +	len = dprx_dprx_read_aux(dp, data);
> +	if (!len)
> +		return 0;
> +
> +	req->cmd = data[0] >> 4;
> +	req->addr = (data[0] & 0xf) << 16 | data[1] << 8 | data[2];
> +	if (len < 4) {
> +		req->len = 0;
> +	} else {
> +		req->len = data[3] + 1;
> +		memcpy(req->data, &data[4], req->len);
> +	}
> +
> +	return 1;
> +}
> +
> +void dprx_aux_write_response(struct dprx_dp *dp, struct aux_msg *res)
> +{
> +	u8 data[20];
> +
> +	data[0] = res->cmd << 4;
> +	memcpy(&data[1], res->data, res->len);
> +
> +	dprx_dprx_write_aux(dp, data, res->len + 1);
> +}
> diff --git a/drivers/media/platform/google/chameleonv3/dprx-dp.c b/drivers/media/platform/google/chameleonv3/dprx-dp.c
> new file mode 100644
> index 000000000000..ede98cb610f6
> --- /dev/null
> +++ b/drivers/media/platform/google/chameleonv3/dprx-dp.c
> @@ -0,0 +1,82 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2022 Google LLC.
> + */
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +#include <linux/of.h>
> +#include <linux/interrupt.h>
> +#include <linux/delay.h>
> +#include "dprx.h"
> +
> +#define DPRX_IRQ_MASK	0x8
> +#define DPRX_IRQ_CLR	0xc
> +#define DPRX_IRQ_AUX 	0x1
> +
> +static irqreturn_t dprx_dp_isr(int irq, void *data)
> +{
> +	struct dprx_dp *dp = data;
> +	unsigned int reg;
> +	struct aux_msg request;
> +	struct aux_msg response;
> +
> +	reg = readl(dp->iobase_irq + DPRX_IRQ_CLR);
> +	if (!reg)
> +		return IRQ_NONE;
> +	if (dprx_aux_read_request(dp, &request)) {
> +		dprx_aux_handle_request(dp, &request, &response);
> +		dprx_aux_write_response(dp, &response);
> +	}
> +	writel(reg, dp->iobase_irq + DPRX_IRQ_CLR);
> +	return IRQ_HANDLED;
> +}
> +
> +static void dprx_sink_init(struct dprx_dp *dp)
> +{
> +	int i;
> +
> +	for (i = 0; i < 4; i++) {
> +		memcpy(dp->sinks[i].edid, default_edid, 128 * default_edid_blocks);
> +		dp->sinks[i].blocks = default_edid_blocks;
> +	}
> +}
> +
> +int dprx_dp_init(struct dprx_dp *dp, struct device *dev,
> +		 const struct dprx_dp_cfg *cfg)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	int irq;
> +	int res;
> +
> +	dp->dev = &pdev->dev;
> +
> +	dp->iobase = devm_platform_ioremap_resource_byname(pdev, cfg->reg_core);
> +	if (IS_ERR(dp->iobase))
> +		return PTR_ERR(dp->iobase);
> +
> +	dp->iobase_irq = devm_platform_ioremap_resource_byname(pdev, cfg->reg_irq);
> +	if (IS_ERR(dp->iobase_irq))
> +		return PTR_ERR(dp->iobase_irq);
> +
> +	irq = platform_get_irq_byname(pdev, cfg->irq);
> +	if (irq < 0)
> +		return irq;
> +
> +	res = devm_request_irq(dp->dev, irq, dprx_dp_isr, 0, cfg->irq, dp);
> +	if (res)
> +		return res;
> +
> +	writel(DPRX_IRQ_AUX, dp->iobase_irq + DPRX_IRQ_MASK);
> +
> +	dp->has_mst = cfg->has_mst;
> +	dp->sink_count = cfg->sink_count;
> +
> +	dprx_dprx_init(dp);
> +	dprx_dpcd_init(dp);
> +	dprx_sink_init(dp);
> +
> +	dprx_dprx_set_hpd(dp, 1);
> +
> +	return 0;
> +}
> diff --git a/drivers/media/platform/google/chameleonv3/dprx-dpcd.c b/drivers/media/platform/google/chameleonv3/dprx-dpcd.c
> new file mode 100644
> index 000000000000..10110cc69dc5
> --- /dev/null
> +++ b/drivers/media/platform/google/chameleonv3/dprx-dpcd.c
> @@ -0,0 +1,424 @@
> +#include <linux/string.h>
> +#include "dprx.h"
> +
> +static void dpcd_clear_vc_payload_table(struct dprx_dp *dp)
> +{
> +	memset(dp->dpcd.vc_table, 0, 64);
> +}
> +
> +static void dpcd_allocate_vc_payload(struct dprx_dp *dp, int start, int count, u8 id)
> +{
> +	if (count > 64 - start)
> +		count = 64 - start;
> +	memset(dp->dpcd.vc_table + start, id, count);
> +}
> +
> +static void dpcd_deallocate_vc_payload(struct dprx_dp *dp, int start, u8 id)
> +{
> +	int i;
> +	int to = start;
> +
> +	for (i = start; i < 64; i++) {
> +		if (dp->dpcd.vc_table[i] == id)
> +			dp->dpcd.vc_table[i] = 0;
> +		else
> +			dp->dpcd.vc_table[to++] = dp->dpcd.vc_table[i];
> +	}
> +}
> +
> +static void dpcd_handle_payload_allocate(struct dprx_dp *dp)
> +{
> +	u8 id = dp->dpcd.vc_alloc[0x0];
> +	u8 start = dp->dpcd.vc_alloc[0x1];
> +	u8 count = dp->dpcd.vc_alloc[0x2];
> +
> +	if (id == 0 && start == 0 && count == 0x3f) {
> +		dpcd_clear_vc_payload_table(dp);
> +		dprx_dprx_clear_vc_payload_table(dp);
> +	} else {
> +		if (count == 0)
> +			dpcd_deallocate_vc_payload(dp, start, id);
> +		else
> +			dpcd_allocate_vc_payload(dp, start, count, id);
> +		dprx_dprx_set_vc_payload_table(dp, dp->dpcd.vc_table, dp->vc_id);
> +	}
> +	dp->dpcd.vc_table_status |= 1 << 0;
> +}
> +
> +
> +
> +
> +
> +/* 100h */
> +static void dpcd_write_link_bw_set(struct dprx_dp *dp, u8 val)
> +{
> +	dp->dpcd.link_conf[0x0] = val;
> +	dprx_dprx_set_link_rate(dp, val);
> +}
> +
> +/* 101h */
> +static void dpcd_write_lane_count_set(struct dprx_dp *dp, u8 val)
> +{
> +	dp->dpcd.link_conf[0x1] = val;
> +	dprx_dprx_set_lane_count(dp, val & 0x1f);
> +}
> +
> +/* 102h */
> +static void dpcd_write_training_pattern_set(struct dprx_dp *dp, u8 val)
> +{
> +	dp->dpcd.link_conf[0x2] = val;
> +	dprx_dprx_set_training_pattern(dp, val & 0xf);
> +	dprx_dprx_set_scrambler(dp, !((val >> 5) & 1));
> +}
> +
> +/* 111h */
> +static void dpcd_write_mstm_ctrl(struct dprx_dp *dp, u8 *src, u32 offset, u32 count)
> +{
> +	u8 val = *src;
> +	dp->dpcd.mstm_ctrl = val;
> +	dprx_dprx_set_mst(dp, val & 1);
> +}
> +
> +/* 1c0h */
> +static void dpcd_write_payload_allocate_set(struct dprx_dp *dp, u8 val)
> +{
> +	dp->dpcd.vc_alloc[0x0] = val & 0x7f;
> +}
> +
> +/* 1c1h */
> +static void dpcd_write_payload_allocate_start_time_slot(struct dprx_dp *dp, u8 val)
> +{
> +	dp->dpcd.vc_alloc[0x1] = val & 0x3f;
> +}
> +
> +/* 1c2h */
> +static void dpcd_write_payload_allocate_time_slot_count(struct dprx_dp *dp, u8 val)
> +{
> +	dp->dpcd.vc_alloc[0x2] = val & 0x3f;
> +	dpcd_handle_payload_allocate(dp);
> +}
> +
> +/* 201h */
> +static void dpcd_write_device_service_irq_vector(struct dprx_dp *dp, u8 val)
> +{
> +	dp->dpcd.irq_vector &= ~val;
> +
> +	if (dprx_sbmsg_pending(dp)) {
> +		dp->dpcd.irq_vector |= 1 << 4;
> +		dprx_sbmsg_write(dp, dp->dpcd.down_rep, 48);
> +		dprx_dprx_pulse_hpd(dp);
> +	}
> +}
> +
> +/* 202h */
> +static u8 dpcd_read_lane01_status(struct dprx_dp *dp)
> +{
> +	int cr_lock;
> +	int sym_lock;
> +	u8 res = 0;
> +
> +	cr_lock = dprx_dprx_get_cr_lock(dp);
> +	sym_lock = dprx_dprx_get_sym_lock(dp);
> +	/* lane 0 */
> +	if (cr_lock & (1 << 0))
> +		res |= 0x1;
> +	if (sym_lock & (1 << 0))
> +		res |= 0x6;
> +	/* lane 1 */
> +	if (cr_lock & (1 << 1))
> +		res |= 0x10;
> +	if (sym_lock & (1 << 1))
> +		res |= 0x60;
> +
> +	return res;
> +}
> +
> +/* 203h */
> +static u8 dpcd_read_lane23_status(struct dprx_dp *dp)
> +{
> +	int cr_lock;
> +	int sym_lock;
> +	u8 res = 0;
> +
> +	cr_lock = dprx_dprx_get_cr_lock(dp);
> +	sym_lock = dprx_dprx_get_sym_lock(dp);
> +	/* lane 2 */
> +	if (cr_lock & (1 << 2))
> +		res |= 0x1;
> +	if (sym_lock & (1 << 2))
> +		res |= 0x6;
> +	/* lane 3 */
> +	if (cr_lock & (1 << 3))
> +		res |= 0x10;
> +	if (sym_lock & (1 << 3))
> +		res |= 0x60;
> +
> +	return res;
> +}
> +
> +/* 204h */
> +static u8 dpcd_read_lane_align_status(struct dprx_dp *dp)
> +{
> +	return dprx_dprx_get_interlane_align(dp);
> +}
> +
> +/* 205h */
> +static u8 dpcd_read_sink_status(struct dprx_dp *dp)
> +{
> +	return dprx_dprx_get_sink_status(dp);
> +}
> +
> +/* 2c0h */
> +static void dpcd_read_payload_table_update_status(struct dprx_dp *dp, u8 *dest, u32 offset, u32 count)
> +{
> +	*dest = dp->dpcd.vc_table_status;
> +	if (dprx_dprx_get_act(dp))
> +		*dest |= 1 << 1;
> +}
> +
> +/* 2c0h */
> +static void dpcd_write_payload_table_update_status(struct dprx_dp *dp, u8 *src, u32 offset, u32 count)
> +{
> +	if (*src & 0x1) {
> +		dp->dpcd.vc_table_status = 0;
> +		dprx_dprx_clear_act(dp);
> +	}
> +}
> +
> +
> +
> +
> +
> +static void dpcd_read_caps(struct dprx_dp *dp, u8 *dest, u32 offset, u32 count)
> +{
> +	memcpy(dest, dp->dpcd.caps + offset, count);
> +}
> +
> +static void dpcd_read_mstm_cap(struct dprx_dp *dp, u8 *dest, u32 offset, u32 count)
> +{
> +	*dest = dp->dpcd.mstm_cap;
> +}
> +
> +static void dpcd_read_guid(struct dprx_dp *dp, u8 *dest, u32 offset, u32 count)
> +{
> +	memcpy(dest, dp->dpcd.guid + offset, count);
> +}
> +
> +static void dpcd_write_guid(struct dprx_dp *dp, u8 *src, u32 offset, u32 count)
> +{
> +	memcpy(dp->dpcd.guid + offset, src, count);
> +}
> +
> +static void dpcd_read_link_conf(struct dprx_dp *dp, u8 *dest, u32 offset, u32 count)
> +{
> +	memcpy(dest, dp->dpcd.link_conf + offset, count);
> +}
> +
> +static void dpcd_write_link_conf(struct dprx_dp *dp, u8 *src, u32 offset, u32 count)
> +{
> +	if (offset <= 0 && 0 < offset + count)
> +		dpcd_write_link_bw_set(dp, src[0 - offset]);
> +	if (offset <= 1 && 1 < offset + count)
> +		dpcd_write_lane_count_set(dp, src[1 - offset]);
> +	if (offset <= 2 && 2 < offset + count)
> +		dpcd_write_training_pattern_set(dp, src[2 - offset]);
> +
> +	while (dprx_dprx_get_rx_busy(dp)) {}
> +}
> +
> +static void dpcd_read_mstm_ctrl(struct dprx_dp *dp, u8 *dest, u32 start, u32 count)
> +{
> +	*dest = dp->dpcd.mstm_ctrl;
> +}
> +
> +static void dpcd_read_vc_alloc(struct dprx_dp *dp, u8 *dest, u32 offset, u32 count)
> +{
> +	memcpy(dest, dp->dpcd.vc_alloc + offset, count);
> +}
> +
> +static void dpcd_write_vc_alloc(struct dprx_dp *dp, u8 *src, u32 offset, u32 count)
> +{
> +	if (offset <= 0 && 0 < offset + count)
> +		dpcd_write_payload_allocate_set(dp, src[0 - offset]);
> +	if (offset <= 1 && 1 < offset + count)
> +		dpcd_write_payload_allocate_start_time_slot(dp, src[1 - offset]);
> +	if (offset <= 2 && 2 < offset + count)
> +		dpcd_write_payload_allocate_time_slot_count(dp, src[2 - offset]);
> +}
> +
> +static void dpcd_read_sink_stat(struct dprx_dp *dp, u8 *dest, u32 offset, u32 count)
> +{
> +	if (offset <= 0 && 0 < offset + count)
> +		dest[0 - offset] = dp->dpcd.sink_count;
> +	if (offset <= 1 && 1 < offset + count)
> +		dest[1 - offset] = dp->dpcd.irq_vector;
> +}
> +
> +static void dpcd_write_sink_stat(struct dprx_dp *dp, u8 *src, u32 offset, u32 count)
> +{
> +	if (offset <= 1 && 1 < offset + count)
> +		dpcd_write_device_service_irq_vector(dp, src[1 - offset]);
> +}
> +
> +static void dpcd_read_link_stat(struct dprx_dp *dp, u8 *dest, u32 offset, u32 count)
> +{
> +	if (offset <= 0 && 0 < offset + count)
> +		dest[0 - offset] = dpcd_read_lane01_status(dp);
> +	if (offset <= 1 && 1 < offset + count)
> +		dest[1 - offset] = dpcd_read_lane23_status(dp);
> +	if (offset <= 2 && 2 < offset + count)
> +		dest[2 - offset] = dpcd_read_lane_align_status(dp);
> +	if (offset <= 3 && 3 < offset + count)
> +		dest[3 - offset] = dpcd_read_sink_status(dp);
> +	if (offset <= 4 && 4 < offset + count)
> +		dest[4 - offset] = 0x55;
> +	if (offset <= 5 && 5 < offset + count)
> +		dest[5 - offset] = 0x55;
> +}
> +
> +static void dpcd_read_vc_table(struct dprx_dp *dp, u8 *dest, u32 offset, u32 count)
> +{
> +	memcpy(dest, dp->dpcd.vc_table + offset + 1, count);
> +}
> +
> +static void dpcd_read_sink_spec(struct dprx_dp *dp, u8 *dest, u32 offset, u32 count)
> +{
> +	memcpy(dest, dp->dpcd.sink_spec + offset, count);
> +}
> +
> +static void dpcd_read_down_req(struct dprx_dp *dp, u8 *dest, u32 offset, u32 count)
> +{
> +	memcpy(dest, dp->dpcd.down_req + offset, count);
> +}
> +
> +static void dpcd_write_down_req(struct dprx_dp *dp, u8 *src, u32 offset, u32 count)
> +{
> +	memcpy(dp->dpcd.down_req + offset, src, count);
> +	/*
> +	 * The sideband message may require multiple AUX transactions to be
> +	 * fully written. Normally, the source writes the data in order,
> +	 * in blocks of 16. Unfortunately, the spec doesn't say what to
> +	 * do if the source behaves differently that that.
> +	 *
> +	 * Approach taken here: when we get a write, assume all the
> +	 * bytes before the starting address are valid, try to parse
> +	 * the message up to the last byte written in this transaction
> +	 * (if it's incomplete, nothing happens).
> +	 */
> +	dprx_sbmsg_read(dp, dp->dpcd.down_req, offset + count);
> +	if (!(dp->dpcd.irq_vector & (1 << 4)) && dprx_sbmsg_pending(dp)) {
> +		dp->dpcd.irq_vector |= 1 << 4;
> +		dprx_sbmsg_write(dp, dp->dpcd.down_rep, 48);
> +		dprx_dprx_pulse_hpd(dp);
> +	}
> +}
> +
> +static void dpcd_read_down_rep(struct dprx_dp *dp, u8 *dest, u32 offset, u32 count)
> +{
> +	memcpy(dest, dp->dpcd.down_rep + offset, count);
> +}
> +
> +struct dpcd_range {
> +	u32 start;
> +	u32 end;
> +	void (*read) (struct dprx_dp *, u8 *, u32, u32);
> +	void (*write)(struct dprx_dp *, u8 *, u32, u32);
> +};
> +
> +struct dpcd_range dpcd_ranges[] = {
> +	{ 0x00000, 0x00010, dpcd_read_caps,      NULL },
> +	{ 0x00021, 0x00022, dpcd_read_mstm_cap,  NULL },
> +	{ 0x00030, 0x00040, dpcd_read_guid,      dpcd_write_guid },
> +	{ 0x00100, 0x00103, dpcd_read_link_conf, dpcd_write_link_conf },
> +	{ 0x00111, 0x00112, dpcd_read_mstm_ctrl, dpcd_write_mstm_ctrl },
> +	{ 0x001c0, 0x001c3, dpcd_read_vc_alloc,  dpcd_write_vc_alloc },
> +	{ 0x00200, 0x00202, dpcd_read_sink_stat, dpcd_write_sink_stat },
> +	{ 0x00202, 0x00208, dpcd_read_link_stat, NULL },
> +	{ 0x002c0, 0x002c1, dpcd_read_payload_table_update_status, dpcd_write_payload_table_update_status },
> +	{ 0x002c1, 0x00300, dpcd_read_vc_table,  NULL },
> +	{ 0x00400, 0x0040c, dpcd_read_sink_spec, NULL },
> +	{ 0x01000, 0x01030, dpcd_read_down_req,  dpcd_write_down_req },
> +	{ 0x01400, 0x01430, dpcd_read_down_rep,  NULL },
> +	{ 0x02002, 0x02004, dpcd_read_sink_stat, dpcd_write_sink_stat },
> +	{ 0x0200c, 0x02010, dpcd_read_link_stat, NULL },
> +};
> +
> +void dprx_dpcd_access(struct dprx_dp *dp, struct aux_msg *req,
> +		      struct aux_msg *res)
> +{
> +	struct dpcd_range *range;
> +	struct dpcd_range *range_end = dpcd_ranges + ARRAY_SIZE(dpcd_ranges);
> +	bool read = req->cmd & 1;
> +	u32 start;
> +	u32 end;
> +	u8 *buf;
> +	u32 offset;
> +	u32 count;
> +
> +	res->cmd = AUX_ACK;
> +	if (read) {
> +		res->len = req->len;
> +		memset(res->data, 0, res->len);
> +	} else {
> +		res->len = 0;
> +	}
> +
> +	for (range = dpcd_ranges; range < range_end; range++) {
> +		if (range->end <= req->addr || req->addr + req->len <= range->start)
> +			continue;
> +		start = max(range->start, req->addr);
> +		end   = min(range->end,   req->addr + req->len);
> +		count = end - start;
> +		offset = start - range->start;
> +		if (read) {
> +			buf = res->data + (start - req->addr);
> +			range->read(dp, buf, offset, count);
> +		} else if (range->write) {
> +			buf = req->data + (start - req->addr);
> +			range->write(dp, buf, offset, count);
> +		}
> +	}
> +}
> +
> +void dprx_dpcd_init(struct dprx_dp *dp)
> +{
> +	struct dpcd_mem *dpcd = &dp->dpcd;
> +
> +	memset(dpcd, 0, sizeof(struct dpcd_mem));
> +
> +	dpcd->caps[0x0] = 0x14, // DPCD 1.4
> +	dpcd->caps[0x1] = 0x1e, // Max link rate 8.1Gbps
> +	dpcd->caps[0x2] = 0xc4, // Max lane count 4, TPS3, Enhanced frame cap
> +	dpcd->caps[0x3] = 0x81, // Down-spread, TPS4
> +	dpcd->caps[0x4] = 0x01, // 2 Reciever ports for SST (video & audio)

Reciever -> Receiver

> +	dpcd->caps[0x5] = 0x00, // no downstream ports
> +	dpcd->caps[0x6] = 0x01, // 8b/10b support
> +	dpcd->caps[0x7] = 0x80, // no downstream ports, OUI present
> +	dpcd->caps[0x8] = 0x02, // has local EDID
> +	dpcd->caps[0x9] = 0x00, // buffer size?
> +	dpcd->caps[0xa] = 0x06,
> +	dpcd->caps[0xb] = 0x00,
> +	dpcd->caps[0xc] = 0x00, // no physical i2c bus
> +	dpcd->caps[0xd] = 0x00, // reserved for eDP
> +	dpcd->caps[0xe] = 0x00, // no extended receiver capability present
> +	dpcd->caps[0xf] = 0x00, // no legacy adaptor caps
> +
> +	dpcd->mstm_cap = dp->has_mst;
> +	dpcd->sink_count = dp->has_mst ? dp->sink_count : 1;
> +
> +	dpcd->sink_spec[0x0] = 0x12;
> +	dpcd->sink_spec[0x1] = 0x34;
> +	dpcd->sink_spec[0x2] = 0x56;
> +	dpcd->sink_spec[0x3] = 'c';
> +	dpcd->sink_spec[0x4] = 'h';
> +	dpcd->sink_spec[0x5] = 'a';
> +	dpcd->sink_spec[0x6] = 'm';
> +	dpcd->sink_spec[0x7] = 'e';
> +	dpcd->sink_spec[0x8] = 'l';
> +	dpcd->sink_spec[0x9] = 0x30;
> +	dpcd->sink_spec[0xa] = 0x00;
> +	dpcd->sink_spec[0xb] = 0x00;
> +
> +	dpcd_write_link_bw_set(dp, 0x1e);
> +	dpcd_write_lane_count_set(dp, 0x04);
> +};
> diff --git a/drivers/media/platform/google/chameleonv3/dprx-dprx.c b/drivers/media/platform/google/chameleonv3/dprx-dprx.c
> new file mode 100644
> index 000000000000..7c7b196539ed
> --- /dev/null
> +++ b/drivers/media/platform/google/chameleonv3/dprx-dprx.c
> @@ -0,0 +1,262 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2022 Google LLC.
> + */
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +#include <linux/of.h>
> +#include <linux/interrupt.h>
> +#include <linux/delay.h>
> +
> +#include "dprx.h"
> +
> +#define DPRX_RX_CONTROL   0x000
> +#define DPRX_RX_STATUS    0x001
> +#define DPRX0_VBID        0x02f
> +#define DPRX_MST_CONTROL1 0x0a0
> +#define DPRX_MST_STATUS1  0x0a1
> +#define DPRX_MST_VCPTAB0  0x0a2
> +#define DPRX_AUX_CONTROL  0x100
> +#define DPRX_AUX_STATUS   0x101
> +#define DPRX_AUX_COMMAND  0x102
> +#define DPRX_AUX_HPD      0x119
> +
> +static void dp_wr(struct dprx_dp *dp, int addr, u32 val)
> +{
> +	writel(val, dp->iobase + (addr * 4));
> +}
> +
> +static u32 dp_rd(struct dprx_dp *dp, int addr)
> +{
> +	return readl(dp->iobase + (addr * 4));
> +}
> +
> +/* HPD */
> +
> +void dprx_dprx_set_hpd(struct dprx_dp *dp, int val)
> +{
> +	u32 reg;
> +
> +	reg = dp_rd(dp, DPRX_AUX_HPD);
> +	reg &= ~(1 << 11);
> +	reg |= (val & 1) << 11;
> +	dp_wr(dp, DPRX_AUX_HPD, reg);
> +}
> +
> +int dprx_dprx_get_hpd(struct dprx_dp *dp)
> +{
> +       return (dp_rd(dp, DPRX_AUX_HPD) >> 11) & 1;
> +}
> +
> +void dprx_dprx_pulse_hpd(struct dprx_dp *dp)
> +{
> +	u32 reg;
> +
> +	reg = dp_rd(dp, DPRX_AUX_HPD);
> +	reg |= 1 << 12;
> +	dp_wr(dp, DPRX_AUX_HPD, reg);
> +}
> +
> +/* Receiver Control */
> +
> +void dprx_dprx_set_link_rate(struct dprx_dp *dp, int val)
> +{
> +	u32 reg;
> +
> +	reg = dp_rd(dp, DPRX_RX_CONTROL);
> +	reg &= ~(0xff << 16);
> +	reg |= (val & 0xff) << 16;
> +	reg |= 1 << 13;
> +	dp_wr(dp, DPRX_RX_CONTROL, reg);
> +}
> +
> +void dprx_dprx_set_lane_count(struct dprx_dp *dp, int val)
> +{
> +	u32 reg;
> +
> +	reg = dp_rd(dp, DPRX_RX_CONTROL);
> +	reg &= ~0x1f;
> +	reg |= (val & 0x1f);
> +	dp_wr(dp, DPRX_RX_CONTROL, reg);
> +}
> +
> +void dprx_dprx_set_training_pattern(struct dprx_dp *dp, int val)
> +{
> +	u32 reg;
> +
> +	reg = dp_rd(dp, DPRX_RX_CONTROL);
> +	reg &= ~(0x7 << 8);
> +	reg |= (val & 0x7) << 8;
> +	dp_wr(dp, DPRX_RX_CONTROL, reg);
> +}
> +
> +void dprx_dprx_set_scrambler(struct dprx_dp *dp, int val)
> +{
> +	u32 reg;
> +
> +	reg = dp_rd(dp, DPRX_RX_CONTROL);
> +	reg &= ~(1 << 7);
> +	reg |= (~val & 1) << 7;
> +	dp_wr(dp, DPRX_RX_CONTROL, reg);
> +}
> +
> +/* Receiver Status */
> +
> +int dprx_dprx_get_cr_lock(struct dprx_dp *dp)
> +{
> +	return dp_rd(dp, DPRX_RX_STATUS) & 0xf;
> +}
> +
> +int dprx_dprx_get_sym_lock(struct dprx_dp *dp)
> +{
> +	return (dp_rd(dp, DPRX_RX_STATUS) >> 4) & 0xf;
> +}
> +
> +int dprx_dprx_get_interlane_align(struct dprx_dp *dp)
> +{
> +	return (dp_rd(dp, DPRX_RX_STATUS) >> 8) & 0x1;
> +}
> +
> +int dprx_dprx_get_sink_status(struct dprx_dp *dp)
> +{
> +	return (dp_rd(dp, DPRX0_VBID) >> 7) & 0x1;
> +}
> +
> +int dprx_dprx_get_rx_busy(struct dprx_dp *dp)
> +{
> +	return (dp_rd(dp, DPRX_RX_STATUS) >> 17) & 0x1;
> +}
> +
> +/* MST */
> +
> +void dprx_dprx_set_mst(struct dprx_dp *dp, int val)
> +{
> +	u32 reg;
> +
> +	reg = dp_rd(dp, DPRX_MST_CONTROL1);
> +	reg &= ~0x1;
> +	reg |= (val & 0x1);
> +	dp_wr(dp, DPRX_MST_CONTROL1, reg);
> +}
> +
> +void dprx_dprx_clear_vc_payload_table(struct dprx_dp *dp)
> +{
> +	u32 reg;
> +	int i;
> +
> +	for (i = 0; i < 8; i++)
> +		dp_wr(dp, DPRX_MST_VCPTAB0 + i, 0);
> +
> +	reg = dp_rd(dp, DPRX_MST_CONTROL1);
> +	reg &= ~(0xffff << 4);
> +	reg |= 1 << 31;
> +	dp_wr(dp, DPRX_MST_CONTROL1, reg);
> +}
> +
> +void dprx_dprx_set_vc_payload_table(struct dprx_dp *dp, u8 *table, u8 *id)
> +{
> +	u8 map[64];
> +	int i, j;
> +	u32 reg;
> +
> +	memset(map, 0, 64);
> +	for (i = 0; i < 4; i++) {
> +		if (id[i] != 0 && id[i] < 64)
> +			map[id[i]] = i + 1;
> +	}
> +
> +	for (i = 0; i < 8; i++) {
> +		reg = 0;
> +		for (j = 0; j < 8; j++)
> +			reg |= map[table[i*8+j]] << (j * 4);
> +		dp_wr(dp, DPRX_MST_VCPTAB0 + i, reg);
> +	}
> +
> +	reg = dp_rd(dp, DPRX_MST_CONTROL1);
> +	reg &= ~(0xffff << 4);
> +	for (i = 0; i < 4; i++)
> +		if (id[i] != 0 && id[i] < 64)
> +			reg |= (i + 1) << ((i + 1) * 4);
> +	reg |= 1 << 30;
> +	dp_wr(dp, DPRX_MST_CONTROL1, reg);
> +}
> +
> +int dprx_dprx_get_act(struct dprx_dp *dp)
> +{
> +	return (dp_rd(dp, DPRX_MST_STATUS1) >> 30) & 1;
> +}
> +
> +void dprx_dprx_clear_act(struct dprx_dp *dp)
> +{
> +	u32 reg;
> +
> +	reg = dp_rd(dp, DPRX_MST_CONTROL1);
> +	reg &= ~(1 << 30);
> +	dp_wr(dp, DPRX_MST_CONTROL1, reg);
> +}
> +
> +/* AUX CH */
> +
> +int dprx_dprx_read_aux(struct dprx_dp *dp, u8 *data)
> +{
> +	int length;
> +	u32 reg;
> +	int i;
> +
> +	/* check MSG_READY */
> +	reg = dp_rd(dp, DPRX_AUX_STATUS);
> +	if (!(reg & (1 << 31)))
> +		return 0;
> +
> +	/* read LENGTH */
> +	length = dp_rd(dp, DPRX_AUX_CONTROL) & 0x1f;
> +	if (length > 20)
> +		length = 20;
> +
> +	/* read request */
> +	for (i = 0; i < length; i++)
> +		data[i] = dp_rd(dp, DPRX_AUX_COMMAND + i);
> +
> +	return length;
> +}
> +
> +void dprx_dprx_write_aux(struct dprx_dp *dp, u8 *data, int length)
> +{
> +	u32 reg;
> +	int i;
> +
> +	/* check READY_TO_TX */
> +	reg = dp_rd(dp, DPRX_AUX_STATUS);
> +	if (!(reg & (1 << 30)))
> +		return;
> +
> +	/* write request */
> +	if (length > 17)
> +		length = 17;
> +	for (i = 0; i < length; i++)
> +		dp_wr(dp, DPRX_AUX_COMMAND + i, data[i]);
> +
> +	/* write LENGTH and TX_STROBE */
> +	reg = dp_rd(dp, DPRX_AUX_CONTROL);
> +	reg &= ~0x1f;
> +	reg |= length | (1 << 7);
> +	dp_wr(dp, DPRX_AUX_CONTROL, reg);
> +}
> +
> +/* Misc */
> +
> +void dprx_dprx_init(struct dprx_dp *dp)
> +{
> +	u32 reg;
> +
> +	/* Enable AUX_IRQ_EN */
> +	reg = dp_rd(dp, DPRX_AUX_CONTROL);
> +	reg |= 1 << 8;
> +	dp_wr(dp, DPRX_AUX_CONTROL, reg);
> +
> +	/* Set CHANNEL_CODING_SET to 8b/10b */
> +	reg = dp_rd(dp, DPRX_RX_CONTROL);
> +	reg |= 1 << 5;
> +	dp_wr(dp, DPRX_RX_CONTROL, reg);
> +}
> diff --git a/drivers/media/platform/google/chameleonv3/dprx-edid.c b/drivers/media/platform/google/chameleonv3/dprx-edid.c
> new file mode 100644
> index 000000000000..19d3a6182eeb
> --- /dev/null
> +++ b/drivers/media/platform/google/chameleonv3/dprx-edid.c
> @@ -0,0 +1,39 @@
> +#include <linux/kernel.h>
> +
> +u8 default_edid[256] = {
> +	0x00,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0x00,
> +	0x34,0xA9,0x96,0xA2,0x01,0x01,0x01,0x01,
> +	0x00,0x17,0x01,0x03,0x80,0x80,0x48,0x78,
> +	0x0A,0xDA,0xFF,0xA3,0x58,0x4A,0xA2,0x29,
> +	0x17,0x49,0x4B,0x21,0x08,0x00,0x31,0x40,
> +	0x45,0x40,0x61,0x40,0x81,0x80,0x01,0x01,
> +	0x01,0x01,0x01,0x01,0x01,0x01,0x08,0xE8,
> +	0x00,0x30,0xF2,0x70,0x5A,0x80,0xB0,0x58,
> +	0x8A,0x00,0xBA,0x88,0x21,0x00,0x00,0x1E,
> +	0x02,0x3A,0x80,0x18,0x71,0x38,0x2D,0x40,
> +	0x58,0x2C,0x45,0x00,0xBA,0x88,0x21,0x00,
> +	0x00,0x1E,0x00,0x00,0x00,0xFC,0x00,0x50,
> +	0x61,0x6E,0x61,0x73,0x6F,0x6E,0x69,0x63,
> +	0x2D,0x54,0x56,0x0A,0x00,0x00,0x00,0xFD,
> +	0x00,0x17,0x3D,0x0F,0x88,0x3C,0x00,0x0A,
> +	0x20,0x20,0x20,0x20,0x20,0x20,0x01,0xA0,
> +
> +	0x02,0x03,0x4F,0xF0,0x57,0x1F,0x10,0x14,
> +	0x05,0x20,0x21,0x22,0x13,0x04,0x12,0x03,
> +	0x16,0x07,0x60,0x61,0x5D,0x5E,0x5F,0x65,
> +	0x66,0x62,0x63,0x64,0x23,0x09,0x07,0x01,
> +	0x7E,0x03,0x0C,0x00,0x40,0x00,0xB8,0x3C,
> +	0x2F,0xC8,0x90,0x01,0x02,0x03,0x04,0x81,
> +	0x41,0x01,0x9C,0x06,0x16,0x08,0x00,0x18,
> +	0x00,0x96,0xA6,0x98,0x00,0xA8,0x00,0x67,
> +	0xD8,0x5D,0xC4,0x01,0x78,0x80,0x03,0xE2,
> +	0x00,0x4B,0xE4,0x0F,0x00,0x60,0x0C,0x56,
> +	0x5E,0x00,0xA0,0xA0,0xA0,0x29,0x50,0x30,
> +	0x20,0x35,0x00,0xBA,0x88,0x21,0x00,0x00,
> +	0x1A,0x66,0x21,0x56,0xAA,0x51,0x00,0x1E,
> +	0x30,0x46,0x8F,0x33,0x00,0xBA,0x88,0x21,
> +	0x00,0x00,0x1E,0x00,0x00,0x00,0x00,0x00,
> +	0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x5F
> +};

Running 'edid-decode -c' (git://linuxtv.org/edid-decode.git) results in a number
of warnings and failures:

----------------

edid-decode SHA: 2d44e1b01c7e 2023-03-11 18:21:51

Warnings:

Block 1, CTA-861 Extension Block:
  Video Data Block: VIC 31 is the preferred timing, overriding the first detailed timings. Is this intended?
  Video Capability Data Block: Set Selectable YCbCr Quantization to avoid interop issues.
  Add a Colorimetry Data Block with the sRGB colorimetry bit set to avoid interop issues.

Failures:

Block 0, Base EDID:
  Detailed Timing Descriptor #1: Mismatch of image size 698x392 mm vs display size 1280x720 mm.
  Detailed Timing Descriptor #2: Mismatch of image size 698x392 mm vs display size 1280x720 mm.
Block 1, CTA-861 Extension Block:
  Detailed Timing Descriptor #3: Mismatch of image size 698x392 mm vs display size 1280x720 mm.
  Detailed Timing Descriptor #4: Mismatch of image size 698x392 mm vs display size 1280x720 mm.

EDID conformity: FAIL

> +
> +u8 default_edid_blocks = 2;
> diff --git a/drivers/media/platform/google/chameleonv3/dprx-i2c.c b/drivers/media/platform/google/chameleonv3/dprx-i2c.c
> new file mode 100644
> index 000000000000..2f0faac7352b
> --- /dev/null
> +++ b/drivers/media/platform/google/chameleonv3/dprx-i2c.c
> @@ -0,0 +1,41 @@
> +#include <linux/string.h>
> +#include "dprx.h"
> +
> +int dprx_i2c_read(struct sink *sink, u8 addr, u8 *buf, int len)
> +{
> +	int offset;
> +
> +	if (addr == 0x50) {
> +		offset = sink->offset + sink->segment * 256;
> +		if (len + offset > sink->blocks * 128)
> +			return -1;
> +		memcpy(buf, sink->edid + offset, len);
> +		sink->offset += len;
> +	} else if (addr == 0x30) {
> +		if (len == 1)
> +			buf[0] = sink->segment;
> +		else if (len > 1)
> +			return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +int dprx_i2c_write(struct sink *sink, u8 addr, u8 *buf, int len)
> +{
> +	if (addr == 0x50) {
> +		if (len == 1)
> +			sink->offset = buf[0];
> +		else if (len > 1)
> +			return -1;
> +	} else if (addr == 0x30) {
> +		if (len == 1)
> +			sink->segment = buf[0];
> +		else if (len > 1)
> +			return -1;
> +	} else {
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> diff --git a/drivers/media/platform/google/chameleonv3/dprx-mt.c b/drivers/media/platform/google/chameleonv3/dprx-mt.c
> new file mode 100644
> index 000000000000..7b39b2e41d22
> --- /dev/null
> +++ b/drivers/media/platform/google/chameleonv3/dprx-mt.c
> @@ -0,0 +1,184 @@
> +#include <linux/string.h>
> +#include "dprx.h"
> +
> +#define MT_GET_MESSAGE_TRANSACTION_VERSION 0x00
> +#define MT_LINK_ADDRESS		0x01
> +#define MT_CONNECTION_STATUS_NOTIFY 0x02
> +#define MT_ENUM_PATH_RESOURCES	0x10
> +#define MT_ALLOCATE_PAYLOAD	0x11
> +#define MT_QUERY_PAYLOAD	0x12
> +#define MT_RESOURCE_STATUS_NOTIFY 0x13
> +#define MT_CLEAR_PAYLOAD_ID_TABLE 0x14
> +#define MT_REMOTE_DPCD_READ	0x20
> +#define MT_REMOTE_DPCD_WRITE	0x21
> +#define MT_REMOTE_I2C_READ	0x22
> +#define MT_REMOTE_I2C_WRITE	0x23
> +#define MT_POWER_UP_PHY		0x24
> +#define MT_POWER_DOWN_PHY	0x25
> +#define MT_SINK_EVENT_NOTIFY	0x30
> +#define MT_QUERY_STREAM_ENCRYPTION_STATUS 0x38
> +
> +#define MT_NACK 0x80
> +#define MT_BAD_PARAM 0x4
> +
> +static void execute_link_address(struct dprx_dp *dp,
> +				 struct msg_transaction *req,
> +				 struct msg_transaction *rep)
> +{
> +	int ports = dp->sink_count + 1;
> +	u8 *buf;
> +	int i;
> +
> +	rep->buf[0] = MT_LINK_ADDRESS;
> +	memcpy(rep->buf + 1, dp->dpcd.guid, 16);
> +	rep->buf[17] = ports;
> +	/* port 0 */
> +	rep->buf[18] = 0x90; /* input, source device, port 0 */
> +	rep->buf[19] = 0x40; /* no msg, connected */
> +
> +	buf = rep->buf + 20;
> +	for (i = 1; i < ports; i++) {
> +		buf[0] = 0x30 | i; /* output, sink device, port i */
> +		buf[1] = 0x40; /* no msg, connected */
> +		buf[2] = 0x00; /* DPCD 0 */
> +		memset(buf + 3, 0, 16); /* GUID */
> +		buf[19] = 0x00; /* 0 SDP streams, 0 SDP stream sinks */
> +		buf += 20;
> +	}
> +	rep->len = ports * 20;
> +}
> +
> +static void execute_enum_path_resources(struct dprx_dp *dp,
> +					struct msg_transaction *req,
> +					struct msg_transaction *rep)
> +{
> +	u8 port;
> +
> +	port = req->buf[1] >> 4;
> +
> +	dp->total_pbn = dp->dpcd.link_conf[0] *
> +			dp->dpcd.link_conf[1] * 32;
> +
> +	rep->buf[0] = MT_ENUM_PATH_RESOURCES;
> +	rep->buf[1] = port << 4;
> +	rep->buf[2] = dp->total_pbn >> 8;
> +	rep->buf[3] = dp->total_pbn & 0xff;
> +	rep->buf[4] = (dp->total_pbn - dp->sum_pbn) >> 8;
> +	rep->buf[5] = (dp->total_pbn - dp->sum_pbn) & 0xff;
> +	rep->len = 6;
> +}
> +
> +static void execute_allocate_payload(struct dprx_dp *dp,
> +				     struct msg_transaction *req,
> +				     struct msg_transaction *rep)
> +{
> +	u8 port;
> +	u8 id;
> +	u16 pbn;
> +
> +	port = req->buf[1] >> 4;
> +	id = req->buf[2] & 0x7f;
> +	pbn = req->buf[3] << 8 | req->buf[4];
> +
> +	dp->vc_id[port-1] = id;
> +
> +	rep->buf[0] = MT_ALLOCATE_PAYLOAD;
> +	rep->buf[1] = port << 4;
> +	rep->buf[2] = id;
> +	rep->buf[3] = pbn >> 8;
> +	rep->buf[4] = pbn & 0xff;
> +	rep->len = 5;
> +}
> +
> +static void execute_clear_payload_id_table(struct dprx_dp *dp,
> +					   struct msg_transaction *req,
> +					   struct msg_transaction *rep)
> +{
> +	dprx_dprx_clear_vc_payload_table(dp);
> +
> +	rep->buf[0] = MT_CLEAR_PAYLOAD_ID_TABLE;
> +	rep->len = 1;
> +}
> +
> +static void execute_remote_i2c_read(struct dprx_dp *dp,
> +				    struct msg_transaction *req,
> +				    struct msg_transaction *rep)
> +{
> +	u8 *req_buf = req->buf;
> +	struct sink *sink;
> +	u8 port;
> +	int num_write_transactions;
> +	u8 addr;
> +	int len;
> +	int i;
> +
> +	port = req_buf[1] >> 4;
> +
> +	if (port < 1 || port > dp->sink_count) {
> +		rep->buf[0] = MT_NACK | MT_REMOTE_I2C_READ;
> +		memcpy(&rep->buf[1], dp->dpcd.guid, 16);
> +		rep->buf[17] = MT_BAD_PARAM;
> +		rep->buf[18] = 0;
> +		rep->len = 18;
> +		return;
> +	}
> +
> +	sink = &dp->sinks[port-1];
> +
> +	num_write_transactions = req_buf[1] & 0x3;
> +	req_buf += 2;
> +	for (i = 0; i < num_write_transactions; i++) {
> +		addr = req_buf[0] & 0x7f;
> +		len = req_buf[1];
> +		dprx_i2c_write(sink, addr, &req_buf[2], len);
> +		req_buf += len + 3;
> +	}
> +	addr = req_buf[0] & 0x7f;
> +	len = req_buf[1];
> +
> +	rep->buf[0] = MT_REMOTE_I2C_READ;
> +	rep->buf[1] = port;
> +	rep->buf[2] = len;
> +	dprx_i2c_read(sink, addr, rep->buf + 3, len);
> +	rep->len = len + 3;
> +}
> +
> +static void execute_power_up_phy(struct dprx_dp *dp,
> +				 struct msg_transaction *req,
> +				 struct msg_transaction *rep)
> +{
> +	u8 port;
> +
> +	port = req->buf[1] >> 4;
> +
> +	rep->buf[0] = MT_POWER_UP_PHY;
> +	rep->buf[1] = port << 4;
> +	rep->len = 2;
> +}
> +
> +void dprx_mt_execute(struct dprx_dp *dp, struct msg_transaction *req,
> +		     struct msg_transaction *rep)
> +{
> +	switch (req->buf[0] & 0x7f) {
> +	case MT_LINK_ADDRESS:
> +		execute_link_address(dp, req, rep);
> +		break;
> +	case MT_ENUM_PATH_RESOURCES:
> +		execute_enum_path_resources(dp, req, rep);
> +		break;
> +	case MT_ALLOCATE_PAYLOAD:
> +		execute_allocate_payload(dp, req, rep);
> +		break;
> +	case MT_CLEAR_PAYLOAD_ID_TABLE:
> +		execute_clear_payload_id_table(dp, req, rep);
> +		break;
> +	case MT_REMOTE_I2C_READ:
> +		execute_remote_i2c_read(dp, req, rep);
> +		break;
> +	case MT_POWER_UP_PHY:
> +		execute_power_up_phy(dp, req, rep);
> +		break;
> +	default:
> +		rep->len = 0;
> +	}
> +}
> diff --git a/drivers/media/platform/google/chameleonv3/dprx-sbmsg.c b/drivers/media/platform/google/chameleonv3/dprx-sbmsg.c
> new file mode 100644
> index 000000000000..ae5db31f225a
> --- /dev/null
> +++ b/drivers/media/platform/google/chameleonv3/dprx-sbmsg.c
> @@ -0,0 +1,162 @@
> +#include <linux/string.h>
> +#include "dprx.h"
> +
> +static u8 get_hdr_crc4(const uint8_t *data, size_t num_nibbles)
> +{
> +	u8 bitmask = 0x80;
> +	u8 bitshift = 7;
> +	u8 array_index = 0;
> +	int number_of_bits = num_nibbles * 4;
> +	u8 remainder = 0;
> +
> +	while (number_of_bits != 0) {
> +		number_of_bits--;
> +		remainder <<= 1;
> +		remainder |= (data[array_index] & bitmask) >> bitshift;
> +		bitmask >>= 1;
> +		bitshift--;
> +		if (bitmask == 0) {
> +			bitmask = 0x80;
> +			bitshift = 7;
> +			array_index++;
> +		}
> +		if ((remainder & 0x10) == 0x10)
> +			remainder ^= 0x13;
> +	}
> +
> +	number_of_bits = 4;
> +	while (number_of_bits != 0) {
> +		number_of_bits--;
> +		remainder <<= 1;
> +		if ((remainder & 0x10) != 0)
> +			remainder ^= 0x13;
> +	}
> +
> +	return remainder;
> +}
> +
> +static u8 get_body_crc4(const uint8_t *data, u8 number_of_bytes)
> +{
> +	u8 bitmask = 0x80;
> +	u8 bitshift = 7;
> +	u8 array_index = 0;
> +	int number_of_bits = number_of_bytes * 8;
> +	u16 remainder = 0;
> +
> +	while (number_of_bits != 0) {
> +		number_of_bits--;
> +		remainder <<= 1;
> +		remainder |= (data[array_index] & bitmask) >> bitshift;
> +		bitmask >>= 1;
> +		bitshift--;
> +		if (bitmask == 0) {
> +			bitmask = 0x80;
> +			bitshift = 7;
> +			array_index++;
> +		}
> +		if ((remainder & 0x100) == 0x100)
> +			remainder ^= 0xd5;
> +	}
> +
> +	number_of_bits = 8;
> +	while (number_of_bits != 0) {
> +		number_of_bits--;
> +		remainder <<= 1;
> +		if ((remainder & 0x100) != 0)
> +			remainder ^= 0xd5;
> +	}
> +
> +	return remainder & 0xff;
> +}
> +
> +
> +void dprx_sbmsg_read(struct dprx_dp *dp, u8 *buf, int len)
> +{
> +	int link_count_total;
> +	int rad_len;
> +	int hdr_len;
> +	int body_len;
> +	bool start;
> +	bool end;
> +	int seq_no;
> +	struct msg_transaction *req;
> +	struct msg_transaction *rep;
> +
> +	link_count_total = buf[0] >> 4;
> +	rad_len = link_count_total / 2;
> +	hdr_len = rad_len + 3;
> +	body_len = buf[rad_len + 1] & 0x3f;
> +
> +	/* If message is incomplete, do nothing */
> +	if (hdr_len + body_len > len)
> +		return;
> +
> +	start  = (buf[rad_len + 2] >> 7) & 1;
> +	end    = (buf[rad_len + 2] >> 6) & 1;
> +	seq_no = (buf[rad_len + 2] >> 4) & 1;
> +
> +	req = &dp->mt_req[seq_no];
> +	rep = &dp->mt_rep[seq_no];
> +
> +	if (start)
> +		req->len = 0;
> +	/* TODO: check overflow */
> +	memcpy(req->buf + req->len, buf + hdr_len, body_len - 1);
> +	req->len += body_len - 1;
> +
> +	if (end) {
> +		rep->written = 0;
> +		memcpy(rep->rad, buf + 1, rad_len);
> +		rep->link_count_total = link_count_total;
> +		dprx_mt_execute(dp, req, rep);
> +	}
> +}
> +
> +void dprx_sbmsg_write(struct dprx_dp *dp, u8 *buf, int buf_len)
> +{
> +	int rad_len;
> +	int hdr_len;
> +	int body_len;
> +	bool start;
> +	bool end;
> +	u8 hdr_crc4;
> +	u8 body_crc4;
> +	struct msg_transaction *rep;
> +
> +	rep = &dp->mt_rep[dp->mt_seq_no];
> +	if (rep->len == 0) {
> +		dp->mt_seq_no ^= 1;
> +		rep = &dp->mt_rep[dp->mt_seq_no];
> +		if (rep->len == 0)
> +			return;
> +	}
> +
> +	rad_len = rep->link_count_total / 2;
> +	hdr_len = rad_len + 3;
> +	body_len = min(rep->len - rep->written + 1, buf_len - hdr_len);
> +
> +	start = (rep->written == 0);
> +	end   = (rep->written + body_len - 1 == rep->len);
> +
> +	buf[0] = rep->link_count_total << 4 | ((rep->link_count_total - 1) & 0xf);
> +	memcpy(buf + 1, rep->rad, rad_len);
> +	buf[rad_len + 1] = body_len;
> +	buf[rad_len + 2] = start << 7 | end << 6 | dp->mt_seq_no << 4;
> +	hdr_crc4 = get_hdr_crc4(buf, hdr_len * 2 - 1);
> +	buf[rad_len + 2] |= hdr_crc4;
> +	memcpy(buf + hdr_len, rep->buf + rep->written, body_len - 1);
> +	body_crc4 = get_body_crc4(buf + hdr_len, body_len - 1);
> +	buf[hdr_len + body_len - 1] = body_crc4;
> +	rep->written += body_len - 1;
> +
> +	if (end) {
> +		rep->len = 0;
> +		rep->written = 0;
> +		dp->mt_seq_no ^= 1;
> +	}
> +}
> +
> +bool dprx_sbmsg_pending(struct dprx_dp *dp)
> +{
> +	return dp->mt_rep[0].len > 0 || dp->mt_rep[1].len > 0;
> +}
> diff --git a/drivers/media/platform/google/chameleonv3/dprx.h b/drivers/media/platform/google/chameleonv3/dprx.h
> new file mode 100644
> index 000000000000..8c48b775c9bd
> --- /dev/null
> +++ b/drivers/media/platform/google/chameleonv3/dprx.h
> @@ -0,0 +1,128 @@
> +#include <linux/kernel.h>
> +
> +struct dprx_dp_cfg {
> +	const char *reg_core;
> +	const char *reg_irq;
> +	const char *irq;
> +	int has_mst;
> +	int sink_count;
> +};
> +
> +struct msg_transaction {
> +       u8 buf[256];
> +       int len;
> +       int written;
> +       u8 rad[16];
> +       int link_count_total;
> +};
> +
> +struct dpcd_mem {
> +       u8 caps[0x10];        /* 00000 - 0000f */
> +       u8 mstm_cap;          /* 00021         */
> +       u8 guid[0x10];        /* 00030 - 0003f */
> +       u8 link_conf[0x3];    /* 00100 - 00102 */
> +       u8 mstm_ctrl;         /* 00111         */
> +       u8 vc_alloc[0x3];     /* 001c0 - 001c2 */
> +       u8 sink_count;        /* 00200         */
> +       u8 irq_vector;        /* 00201         */
> +       u8 lane_align_status; /* 00204         */
> +       u8 vc_table_status;   /* 0x2c0         */
> +       u8 vc_table[0x40];    /* 002c1 - 002ff */
> +       u8 sink_spec[0xc];    /* 00400 - 0040b */
> +       u8 down_req[0x30];    /* 01000 - 01030 */
> +       u8 down_rep[0x30];    /* 01400 - 01430 */
> +};
> +
> +#define DPRX_MAX_EDID_BLOCKS 4
> +
> +struct sink {
> +       u8 edid[128 * DPRX_MAX_EDID_BLOCKS];
> +       int blocks;
> +       int offset;
> +       int segment;
> +};
> +
> +struct dprx_dp {
> +       struct device *dev;
> +       void __iomem *iobase;
> +       void __iomem *iobase_irq;
> +
> +       struct sink sinks[4];
> +       u8 vc_id[4];
> +       int sink_count;
> +       int has_mst;
> +       int total_pbn;
> +       int sum_pbn;
> +
> +       /* dpcd */
> +       struct dpcd_mem dpcd;
> +
> +       /* msg transaction */
> +       struct msg_transaction mt_req[2];
> +       struct msg_transaction mt_rep[2];
> +       bool mt_seq_no;
> +};
> +
> +int dprx_dp_init(struct dprx_dp *dp, struct device *dev,
> +		 const struct dprx_dp_cfg *cfg);
> +
> +#define AUX_ACK 0x0
> +#define AUX_I2C_NACK 0x4
> +
> +struct aux_msg {
> +	u8 cmd;
> +	u32 addr;
> +	u8 len;
> +	u8 data[16];
> +};
> +
> +/* dprx-aux.c */
> +void dprx_aux_handle_request(struct dprx_dp *dp, struct aux_msg *req,
> +			     struct aux_msg *res);
> +int dprx_aux_read_request(struct dprx_dp *dp, struct aux_msg *req);
> +void dprx_aux_write_response(struct dprx_dp *dp, struct aux_msg *res);
> +
> +/* dprx-dpcd.c */
> +void dprx_dpcd_init(struct dprx_dp *dp);
> +void dprx_dpcd_access(struct dprx_dp *dp, struct aux_msg *req,
> +		      struct aux_msg *res);
> +
> +
> +/* dprx-dprx.c */
> +void dprx_dprx_set_hpd(struct dprx_dp *dp, int val);
> +int dprx_dprx_get_hpd(struct dprx_dp *dp);
> +void dprx_dprx_pulse_hpd(struct dprx_dp *dp);
> +void dprx_dprx_set_link_rate(struct dprx_dp *dp, int val);
> +void dprx_dprx_set_lane_count(struct dprx_dp *dp, int val);
> +void dprx_dprx_set_training_pattern(struct dprx_dp *dp, int val);
> +void dprx_dprx_set_scrambler(struct dprx_dp *dp, int val);
> +int dprx_dprx_get_cr_lock(struct dprx_dp *dp);
> +int dprx_dprx_get_sym_lock(struct dprx_dp *dp);
> +int dprx_dprx_get_interlane_align(struct dprx_dp *dp);
> +int dprx_dprx_get_sink_status(struct dprx_dp *dp);
> +int dprx_dprx_get_rx_busy(struct dprx_dp *dp);
> +void dprx_dprx_set_mst(struct dprx_dp *dp, int val);
> +void dprx_dprx_clear_vc_payload_table(struct dprx_dp *dp);
> +void dprx_dprx_set_vc_payload_table(struct dprx_dp *dp, u8 *table, u8 *id);
> +int dprx_dprx_get_act(struct dprx_dp *dp);
> +void dprx_dprx_clear_act(struct dprx_dp *dp);
> +int dprx_dprx_read_aux(struct dprx_dp *dp, u8 *data);
> +void dprx_dprx_write_aux(struct dprx_dp *dp, u8 *data, int length);
> +void dprx_dprx_init(struct dprx_dp *dp);
> +
> +/* dprx-edid.c */
> +extern u8 default_edid[256];
> +extern u8 default_edid_blocks;
> +
> +/* dprx-i2c.c */
> +int dprx_i2c_read(struct sink *sink, u8 addr, u8 *buf, int len);
> +int dprx_i2c_write(struct sink *sink, u8 addr, u8 *buf, int len);
> +
> +/* dprx-mt.c */
> +void dprx_mt_execute(struct dprx_dp *dp, struct msg_transaction *req,
> +		     struct msg_transaction *rep);
> +
> +/* dprx-sbmsg.c */
> +void dprx_sbmsg_read(struct dprx_dp *dp, u8 *buf, int len);
> +void dprx_sbmsg_write(struct dprx_dp *dp, u8 *buf, int buf_len);
> +bool dprx_sbmsg_pending(struct dprx_dp *dp);

Regards,

	Hans
