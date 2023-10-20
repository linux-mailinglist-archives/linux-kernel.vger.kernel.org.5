Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0562A7D12F2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 17:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377732AbjJTPix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 11:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377651AbjJTPiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 11:38:51 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB6CB3;
        Fri, 20 Oct 2023 08:38:45 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6794C20013;
        Fri, 20 Oct 2023 15:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697816323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZvogMrtmX4zJsFjMCpeBxnegc4eL9ZjqeLDKxBNIB+M=;
        b=RAxM0ET+dLTKDW9BZE1ySUsEPtdeYS2xpmJGhiH94djkEpOJ7/G+tpgPQCIO489GRP9CC4
        5O/hS7Ga+oPOgH8C5MWL8hPWKfcNWE/J9sxnxxVSAcfcPl7kc9jA1LvlT6zq/vGrHVFA7e
        1i1q98WFNH5MqyywD4V2pNQe71x/t0TdHIUOM8ChqVaNzPu/xWP5cpgFNuOY1AFuRdM9qI
        ALt96cOfIlUmrhIrULtxccWOYRAlqt4yJ42BstRdxcBq8MAjLTq+C29fINdGExxwG7qSpo
        GvEUaO8Qfre9oyB9n/oPCwVyqB2d9I3pfBjid0MvjOV/cDKvg2uncbNQSVsw9g==
Date:   Fri, 20 Oct 2023 17:38:42 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Mehdi Djait <mehdi.djait@bootlin.com>
Cc:     mchehab@kernel.org, heiko@sntech.de, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, ezequiel@vanguardiasur.com.ar,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com, maxime.chevallier@bootlin.com
Subject: Re: [PATCH v8 2/3] media: rockchip: Add a driver for Rockhip's
 camera interface
Message-ID: <ZTKfAnvjx5tbB9ML@aptenodytes>
References: <cover.1697446303.git.mehdi.djait@bootlin.com>
 <3790470ff7606fc075ec742d43254e52dde5d120.1697446303.git.mehdi.djait@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DTNud2UJK/Bj3czp"
Content-Disposition: inline
In-Reply-To: <3790470ff7606fc075ec742d43254e52dde5d120.1697446303.git.mehdi.djait@bootlin.com>
X-GND-Sasl: paul.kocialkowski@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DTNud2UJK/Bj3czp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mehdi.

On Mon 16 Oct 23, 11:00, Mehdi Djait wrote:
> Introduce a driver for the camera interface on some Rockchip platforms.

Here is a more thorough review of the driver.

> This controller supports CSI2 and BT656 interfaces, but for
> now only the BT656 interface could be tested, hence it's the only one
> that's supported in the first version of this driver.

Please mention the fact that this driver is video node-centric and not
media controller-centric.

> This controller can be fond on PX30, RK1808, RK3128 and RK3288,

Typo: found. Also please update the list based on my previous email.

> In the BSP, this driver is known as the "cif" driver, but this was
> renamed to "vip" to better fit the controller denomination in the
> datasheet.

Please keep the cif name, as it is more representative of the unit.

> +++ b/drivers/media/platform/rockchip/vip/Kconfig
> @@ -0,0 +1,14 @@
> +config VIDEO_ROCKCHIP_VIP
> +	tristate "Rockchip VIP (Video InPut) Camera Interface"
> +	depends on VIDEO_DEV

Add a depends on V4L_PLATFORM_DRIVERS too.
Add a depends on PM && COMMON_CLK too.

> +	depends on ARCH_ROCKCHIP || COMPILE_TEST
> +	select VIDEOBUF2_DMA_SG

I don't see where scatter-gather is used in the driver. If it's not used you
should remove this.

> +	select VIDEOBUF2_DMA_CONTIG
> +	select V4L2_FWNODE

Add a select on VIDEO_V4L2_SUBDEV_API.

> +	select V4L2_MEM2MEM_DEV

I don't think this driver is using m2m so this should be removed.

> +	help
> +	  This is a v4l2 driver for Rockchip SOC Camera interface. It supports
> +	  BT.656 and CSI2 inputs.

Please correct this to clarify that it supports parallel interfaces, often
called "DVP" in rockchip terminology such as BT.656 but not CSI2.
You can mention that this is called CIF and VIP here.

Also it's pretty redundant that this is a v4l2 driver.

> +	  To compile this driver as a module choose m here : the module will
> +	  be called video_rkvip.

This is generally redundant information, you can just remove it.

> diff --git a/drivers/media/platform/rockchip/vip/Makefile b/drivers/media=
/platform/rockchip/vip/Makefile
> new file mode 100644
> index 000000000000..c239ee0bb0fe
> --- /dev/null
> +++ b/drivers/media/platform/rockchip/vip/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_VIDEO_ROCKCHIP_VIP) +=3D video_rkvip.o
> +video_rkvip-objs +=3D dev.o capture.o

That name is a bit unusual. You should call it "rockchip-cif" to be consist=
ent
with the rkisp1 and rga module names.

> diff --git a/drivers/media/platform/rockchip/vip/capture.c b/drivers/medi=
a/platform/rockchip/vip/capture.c
> new file mode 100644
> index 000000000000..e8f3480aacdb
> --- /dev/null
> +++ b/drivers/media/platform/rockchip/vip/capture.c
> @@ -0,0 +1,1210 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Rockchip VIP Camera Interface Driver
> + *
> + * Copyright (C) 2018 Rockchip Electronics Co., Ltd.
> + * Copyright (C) 2020 Maxime Chevallier <maxime.chevallier@bootlin.com>
> + * Copyright (C) 2023 Mehdi Djait <mehdi.djait@bootlin.com>
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/reset.h>
> +#include <media/v4l2-common.h>
> +#include <media/v4l2-event.h>

Not sure you need v4l2-event.h

> +#include <media/v4l2-fh.h>
> +#include <media/v4l2-fwnode.h>
> +#include <media/v4l2-ioctl.h>
> +#include <media/v4l2-mc.h>
> +#include <media/v4l2-subdev.h>
> +#include <media/videobuf2-dma-contig.h>
> +
> +#include "dev.h"
> +#include "regs.h"
> +
> +#define VIP_REQ_BUFS_MIN	3

What's the justification for 3 buffers? In a regular double-buffering mecha=
nism
it should be able to operate with just two.

> +#define VIP_MIN_WIDTH		64
> +#define VIP_MIN_HEIGHT		64
> +#define VIP_MAX_WIDTH		8192
> +#define VIP_MAX_HEIGHT		8192
> +
> +#define RK_VIP_PLANE_Y			0
> +#define RK_VIP_PLANE_CBCR		1

Keep the prefix consistent: VIP/CIF instead of RK_VIP/RK_CIF.

The same issue exists with a bunch of functions too (vip vs rk_vip) prefix
and write_vip_reg/read_vip_reg which puts the prefix in the middle.
Please go through this and make it consistent.

Also name the latter "UV" insyead of "CBCR" since CbCr is most often used in
analogue setups.

> +
> +#define VIP_FETCH_Y_LAST_LINE(VAL) ((VAL) & 0x1fff)

Seems like this should be part of the register defines.

> +static int rk_vip_init_buffers(struct rk_vip_stream *stream)
> +{
> +	struct rk_vip_device *vip_dev =3D stream->vipdev;
> +	void __iomem *base =3D vip_dev->base_addr;
> +
> +	spin_lock(&stream->vbq_lock);

You should probably irqsave/irqrestore here.

> +
> +	stream->buffs[0] =3D rk_vip_get_buffer(stream);
> +	stream->buffs[1] =3D rk_vip_get_buffer(stream);
> +
> +	if (!(stream->buffs[0]) || !(stream->buffs[1])) {
> +		spin_unlock(&stream->vbq_lock);
> +		return -EINVAL;
> +	}
> +
> +	spin_unlock(&stream->vbq_lock);
> +
> +	write_vip_reg(base, VIP_FRM0_ADDR_Y,
> +		      stream->buffs[0]->buff_addr[RK_VIP_PLANE_Y]);
> +	write_vip_reg(base, VIP_FRM0_ADDR_UV,
> +		      stream->buffs[0]->buff_addr[RK_VIP_PLANE_CBCR]);
> +
> +	write_vip_reg(base, VIP_FRM1_ADDR_Y,
> +		      stream->buffs[1]->buff_addr[RK_VIP_PLANE_Y]);
> +	write_vip_reg(base, VIP_FRM1_ADDR_UV,
> +		      stream->buffs[1]->buff_addr[RK_VIP_PLANE_CBCR]);
> +
> +	return 0;
> +}
> +
> +static void rk_vip_assign_new_buffer_pingpong(struct rk_vip_stream *stre=
am)
> +{
> +	struct rk_vip_scratch_buffer *scratch_buf =3D &stream->scratch_buf;
> +	struct rk_vip_device *vip_dev =3D stream->vipdev;
> +	struct rk_vip_buffer *buffer =3D NULL;
> +	void __iomem *base =3D vip_dev->base_addr;
> +	u32 frm_addr_y, frm_addr_uv;
> +
> +	/* Set up an empty buffer for the next frame */

Add an ending dot.

> +	spin_lock(&stream->vbq_lock);
> +
> +	buffer =3D rk_vip_get_buffer(stream);
> +
> +	stream->buffs[stream->frame_phase] =3D buffer;
> +
> +	spin_unlock(&stream->vbq_lock);
> +
> +	frm_addr_y =3D stream->frame_phase ? VIP_FRM1_ADDR_Y : VIP_FRM0_ADDR_Y;
> +	frm_addr_uv =3D stream->frame_phase ? VIP_FRM1_ADDR_UV : VIP_FRM0_ADDR_=
UV;
> +
> +	if (buffer) {
> +		write_vip_reg(base, frm_addr_y,
> +			      buffer->buff_addr[RK_VIP_PLANE_Y]);
> +		write_vip_reg(base, frm_addr_uv,
> +			      buffer->buff_addr[RK_VIP_PLANE_CBCR]);
> +	} else {
> +		write_vip_reg(base, frm_addr_y, scratch_buf->dma_addr);
> +		write_vip_reg(base, frm_addr_uv, scratch_buf->dma_addr);
> +	}

In principle you should not need a scratch buffer for this. The general the=
ory
of operation is that you only switch the active buffer when you have a new =
one
available. If userspace is too slow to requeue buffers, you just keep using
the same one (don't return it to userspace) and overwrite it.

> +static void rk_vip_stop_streaming(struct vb2_queue *queue)
> +{
> +	struct rk_vip_stream *stream =3D queue->drv_priv;
> +	struct rk_vip_device *vip_dev =3D stream->vipdev;
> +	struct rk_vip_buffer *buf;
> +	struct v4l2_subdev *sd;
> +	int ret;
> +
> +	stream->stopping =3D true;
> +	ret =3D wait_event_timeout(stream->wq_stopped,
> +				 stream->state !=3D RK_VIP_STATE_STREAMING,
> +				 msecs_to_jiffies(1000));
> +	if (!ret) {
> +		rk_vip_stream_stop(stream);
> +		stream->stopping =3D false;
> +	}
> +	pm_runtime_put(vip_dev->dev);
> +
> +	/* stop the sub device*/

First letter uppercase, dot at the end, space before the asterisk.

> +	sd =3D vip_dev->sensor.sd;
> +	v4l2_subdev_call(sd, video, s_stream, 0);

In principle you should first stop the remove subdev and then stop this
interface, not the other way round.

> +
> +	/* release buffers */

Same cosmetics.

> +	if (stream->buffs[0]) {
> +		list_add_tail(&stream->buffs[0]->queue, &stream->buf_head);
> +		stream->buffs[0] =3D NULL;
> +	}
> +
> +	if (stream->buffs[1]) {
> +		list_add_tail(&stream->buffs[1]->queue, &stream->buf_head);
> +		stream->buffs[1] =3D NULL;
> +	}

It's a bit weird to re-add these buffers to the intermediate queue just to
remove them after that. You could have a simple helper to call vb2_buffer_d=
one
=66rom a struct rk_vip_buffer argument and then pass stream->buffs[0] and
stream->buffs[1] to it...

> +	while (!list_empty(&stream->buf_head)) {
> +		buf =3D rk_vip_get_buffer(stream);
> +		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);

=2E.. as well as passing it each remaining buf here.

> +	}
> +
> +	rk_vip_destroy_scratch_buf(stream);
> +}
> +
> +static u32 rk_vip_determine_input_mode(struct rk_vip_device *vip_dev)

This is only used once so it should be inline in the calling function.

> +{
> +	v4l2_std_id std =3D vip_dev->sensor.std;
> +
> +	return (std =3D=3D V4L2_STD_NTSC) ?
> +		VIP_FORMAT_INPUT_MODE_NTSC :
> +		VIP_FORMAT_INPUT_MODE_PAL;
> +}
> +
> +static inline u32 rk_vip_scl_ctl(struct rk_vip_stream *stream)

Same comment here.

> +{
> +	u32 fmt_type =3D stream->vip_fmt_in->fmt_type;
> +
> +	return (fmt_type =3D=3D VIP_FMT_TYPE_YUV) ?
> +		VIP_SCL_CTRL_ENABLE_YUV_16BIT_BYPASS :
> +		VIP_SCL_CTRL_ENABLE_RAW_16BIT_BYPASS;
> +}
> +
> +static int rk_vip_stream_start(struct rk_vip_stream *stream)
> +{
> +	u32 val, mbus_flags, href_pol, vsync_pol,
> +	    xfer_mode =3D 0, yc_swap =3D 0, skip_top =3D 0;
> +	struct rk_vip_device *vip_dev =3D stream->vipdev;
> +	struct rk_vip_sensor_info *sensor_info;
> +	void __iomem *base =3D vip_dev->base_addr;
> +	int ret;
> +	u32 input_mode;
> +
> +	sensor_info =3D &vip_dev->sensor;
> +	stream->frame_idx =3D 0;
> +	input_mode =3D rk_vip_determine_input_mode(vip_dev);
> +
> +	mbus_flags =3D sensor_info->mbus.bus.parallel.flags;
> +	href_pol =3D (mbus_flags & V4L2_MBUS_HSYNC_ACTIVE_HIGH) ?
> +			0 : VIP_FORMAT_HSY_LOW_ACTIVE;
> +	vsync_pol =3D (mbus_flags & V4L2_MBUS_VSYNC_ACTIVE_HIGH) ?
> +			VIP_FORMAT_VSY_HIGH_ACTIVE : 0;
> +
> +	val =3D vsync_pol | href_pol | input_mode | stream->vip_fmt_out->fmt_va=
l |
> +	      stream->vip_fmt_in->dvp_fmt_val | xfer_mode | yc_swap;
> +	write_vip_reg(base, VIP_FOR, val);
> +
> +	val =3D stream->pixm.width;
> +	if (stream->vip_fmt_in->fmt_type =3D=3D VIP_FMT_TYPE_RAW)
> +		val =3D stream->pixm.width * 2;
> +
> +	write_vip_reg(base, VIP_VIR_LINE_WIDTH, val);
> +	write_vip_reg(base, VIP_SET_SIZE,
> +		      stream->pixm.width | (stream->pixm.height << 16));
> +
> +	v4l2_subdev_call(sensor_info->sd, sensor, g_skip_top_lines, &skip_top);

Check return code and act accordingly for error cases, also handle -EOPNOTS=
UPP
gracefully (fallback to skip_top =3D 0).

> +
> +	write_vip_reg(base, VIP_CROP, skip_top << VIP_CROP_Y_SHIFT);
> +	write_vip_reg(base, VIP_FRAME_STATUS, VIP_FRAME_STAT_CLS);
> +	write_vip_reg(base, VIP_INTSTAT, VIP_INTSTAT_CLS);
> +	write_vip_reg(base, VIP_SCL_CTRL, rk_vip_scl_ctl(stream));
> +
> +	ret =3D rk_vip_init_buffers(stream);
> +	if (ret)
> +		return ret;
> +
> +	write_vip_reg(base, VIP_INTEN, VIP_INTEN_FRAME_END_EN |
> +				       VIP_INTEN_LINE_ERR_EN |
> +				       VIP_INTEN_PST_INF_FRAME_END_EN);
> +
> +	write_vip_reg(base, VIP_CTRL, VIP_CTRL_AXI_BURST_16 |
> +				      VIP_CTRL_MODE_PINGPONG |
> +				      VIP_CTRL_ENABLE_CAPTURE);
> +
> +	stream->state =3D RK_VIP_STATE_STREAMING;

This variable is not needed in general, we have vb2_is_streaming to do the =
job
as well as vb2_is_busy if you need to check if some buffers are already
allocated (meaning we have already settled on a specific config).

> +
> +	return 0;
> +}
> +
> +static int rk_vip_start_streaming(struct vb2_queue *queue, unsigned int =
count)
> +{
> +	struct rk_vip_stream *stream =3D queue->drv_priv;
> +	struct rk_vip_device *vip_dev =3D stream->vipdev;
> +	struct v4l2_device *v4l2_dev =3D &vip_dev->v4l2_dev;
> +	struct v4l2_subdev *sd;
> +	int ret;
> +
> +	if (stream->state !=3D RK_VIP_STATE_READY) {

Ditto.

> +		ret =3D -EBUSY;
> +		v4l2_err(v4l2_dev, "Stream in busy state\n");
> +		goto destroy_buf;
> +	}
> +
> +	if (!vip_dev->sensor.sd) {
> +		ret =3D -EINVAL;

Probably -ENODEV instead.

> +		v4l2_err(v4l2_dev, "No sensor subdev detected\n");
> +		goto destroy_buf;
> +	}
> +
> +	ret =3D rk_vip_create_scratch_buf(stream);
> +	if (ret < 0) {
> +		v4l2_err(v4l2_dev, "Failed to create scratch_buf, %d\n", ret);
> +		goto destroy_buf;
> +	}
> +
> +	ret =3D pm_runtime_get_sync(vip_dev->dev);
> +	if (ret < 0) {
> +		v4l2_err(v4l2_dev, "Failed to get runtime pm, %d\n", ret);
> +		goto destroy_scratch_buf;
> +	}
> +
> +	/* start sub-devices */
> +	sd =3D vip_dev->sensor.sd;
> +	stream->vip_fmt_in =3D get_input_fmt(vip_dev->sensor.sd);
> +
> +	ret =3D v4l2_subdev_call(sd, video, s_stream, 1);
> +	if (ret < 0)
> +		goto runtime_put;
> +
> +	ret =3D rk_vip_stream_start(stream);
> +	if (ret < 0)
> +		goto stop_stream;

Normally you would do it the other way round: start the receiving interface
first and then start the sensor. Otherwise you cannot exclude that the first
frame will be sent while the camera interface is not yet ready. It will at =
best
be lost and might confuse the receiver hardware.

> +
> +	return 0;
> +
> +stop_stream:
> +	rk_vip_stream_stop(stream);
> +runtime_put:
> +	pm_runtime_put(vip_dev->dev);
> +destroy_scratch_buf:
> +	rk_vip_destroy_scratch_buf(stream);
> +destroy_buf:
> +	while (!list_empty(&stream->buf_head)) {
> +		struct rk_vip_buffer *buf;
> +
> +		buf =3D rk_vip_get_buffer(stream);
> +		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_QUEUED);
> +	}
> +
> +	return ret;
> +}
>
> +static int rk_vip_init_vb2_queue(struct vb2_queue *q,
> +				 struct rk_vip_stream *stream)
> +{
> +	q->type =3D V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;

You report mplane support but only support non-mplane pixel formats and ass=
ume
that only one vb2 plane is used. You can either add support for mplane form=
ats
too or report non-mplane formats but please keep both consistent.

> +	q->io_modes =3D VB2_MMAP | VB2_DMABUF;
> +	q->drv_priv =3D stream;
> +	q->ops =3D &rk_vip_vb2_ops;
> +	q->mem_ops =3D &vb2_dma_contig_memops;
> +	q->buf_struct_size =3D sizeof(struct rk_vip_buffer);
> +	q->min_buffers_needed =3D VIP_REQ_BUFS_MIN;
> +	q->timestamp_flags =3D V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
> +	q->lock =3D &stream->vlock;
> +	q->dev =3D stream->vipdev->dev;
> +
> +	return vb2_queue_init(q);
> +}
> +
> +static void rk_vip_update_pixm(struct rk_vip_stream *stream,
> +			       struct vip_output_fmt *fmt,
> +			       struct v4l2_pix_format_mplane *pixm)
> +{
> +	struct rk_vip_sensor_info *sensor_info =3D &stream->vipdev->sensor;
> +	struct v4l2_subdev_format sd_fmt;
> +	struct v4l2_rect input_rect;
> +	u32 width, height;
> +
> +	sd_fmt.which =3D V4L2_SUBDEV_FORMAT_ACTIVE;
> +	sd_fmt.pad =3D 0;
> +	v4l2_subdev_call(sensor_info->sd, pad, get_fmt, NULL, &sd_fmt);
> +
> +	input_rect.width =3D VIP_MAX_WIDTH;
> +	input_rect.height =3D VIP_MAX_HEIGHT;
> +	width =3D clamp_t(u32, sd_fmt.format.width,
> +			VIP_MIN_WIDTH, input_rect.width);
> +	height =3D clamp_t(u32, sd_fmt.format.height,
> +			 VIP_MIN_HEIGHT, input_rect.height);

I don't get the point of declaring this input_rect variable. Just use the
defines directly.

> +
> +	pixm->width =3D width;
> +	pixm->height =3D height;
> +	pixm->field =3D sd_fmt.format.field;
> +	pixm->colorspace =3D sd_fmt.format.colorspace;
> +	pixm->ycbcr_enc =3D sd_fmt.format.ycbcr_enc;
> +	pixm->quantization =3D sd_fmt.format.quantization;
> +	pixm->xfer_func =3D sd_fmt.format.xfer_func;
> +
> +	v4l2_fill_pixfmt_mp(pixm, fmt->fourcc, pixm->width, pixm->height);
> +}
> +
> +static int rk_vip_set_fmt(struct rk_vip_stream *stream,
> +			  struct v4l2_pix_format_mplane *pixm)
> +{
> +	struct rk_vip_device *vip_dev =3D stream->vipdev;
> +	struct v4l2_subdev_format sd_fmt;
> +	struct vip_output_fmt *fmt;
> +	int ret;
> +
> +	if (stream->state =3D=3D RK_VIP_STATE_STREAMING)
> +		return -EBUSY;

Same comment about using the existing helpers.

> +
> +	fmt =3D find_output_fmt(stream, pixm->pixelformat);
> +	if (!fmt)
> +		fmt =3D &out_fmts[0];
> +
> +	sd_fmt.which =3D V4L2_SUBDEV_FORMAT_ACTIVE;
> +	sd_fmt.pad =3D 0;
> +	sd_fmt.format.width =3D pixm->width;
> +	sd_fmt.format.height =3D pixm->height;

Newline here.

> +	ret =3D v4l2_subdev_call(vip_dev->sensor.sd, pad, set_fmt, NULL, &sd_fm=
t);

And newline here.

> +	rk_vip_update_pixm(stream, fmt, pixm);
> +	stream->pixm =3D *pixm;
> +	stream->vip_fmt_out =3D fmt;
> +
> +	return ret;
> +}
>
> +static int rk_vip_try_fmt_vid_cap_mplane(struct file *file, void *fh,
> +					 struct v4l2_format *f)
> +{
> +	struct rk_vip_stream *stream =3D video_drvdata(file);
> +	struct vip_output_fmt *fmt;
> +
> +	fmt =3D find_output_fmt(stream, f->fmt.pix_mp.pixelformat);
> +	if (!fmt)
> +		fmt =3D &out_fmts[0];
> +
> +	rk_vip_update_pixm(stream, fmt, &f->fmt.pix_mp);

I don't think this will work since the function will use the subdev's curre=
ntly
active format while try_fmt should be a way to check that the provided form=
at
can work. So you probably need to call teh subdev's try_fmt here.

> +
> +	return 0;
> +}
> +
> +static int rk_vip_s_std(struct file *file, void *fh, v4l2_std_id norm)
> +{
> +	struct rk_vip_stream *stream =3D video_drvdata(file);
> +	struct rk_vip_sensor_info *sensor_info =3D &stream->vipdev->sensor;
> +	int ret;
> +
> +	if (norm =3D=3D sensor_info->std)
> +		return 0;
> +
> +	if (stream->state =3D=3D RK_VIP_STATE_STREAMING)

Same comment about using the existing helper. Also you should refuse this
in case buffers are allocated, not just when streaming.

> +		return -EBUSY;
> +
> +	ret =3D v4l2_subdev_call(sensor_info->sd, video, s_std, norm);
> +	if (ret)
> +		return ret;
> +
> +	sensor_info->std =3D norm;
> +
> +	/* S_STD will update the format since that depends on the standard */

Dot at the end.

> +	rk_vip_update_pixm(stream, stream->vip_fmt_out, &stream->pixm);
> +
> +	return 0;
> +}
> +
> +static int rk_vip_s_fmt_vid_cap_mplane(struct file *file,
> +				       void *priv, struct v4l2_format *f)
> +{
> +	struct rk_vip_stream *stream =3D video_drvdata(file);
> +	int ret;
> +
> +	if (stream->state =3D=3D RK_VIP_STATE_STREAMING)
> +		return -EBUSY;

This is not enough: you must forbid changes if buffers were already allocat=
ed
(typically checked with vb2_is_busy).

> +
> +	ret =3D rk_vip_set_fmt(stream, &f->fmt.pix_mp);
> +
> +	return ret;
> +}
> +
> +static int rk_vip_enum_framesizes(struct file *file, void *fh,
> +				  struct v4l2_frmsizeenum *fsize)
> +{
> +	struct rk_vip_stream *stream =3D video_drvdata(file);
> +	struct rk_vip_device *vip_dev =3D stream->vipdev;
> +	struct v4l2_subdev_frame_size_enum fse =3D {
> +		.index =3D fsize->index,
> +		.which =3D V4L2_SUBDEV_FORMAT_ACTIVE,
> +	};
> +	struct vip_output_fmt *fmt;
> +	int ret;
> +
> +	if (!vip_dev->sensor.sd)
> +		return -EINVAL;

Probably more -ENODEV.

> +
> +	fmt =3D find_output_fmt(stream, fsize->pixel_format);
> +	if (!fmt)
> +		return -EINVAL;
> +
> +	fse.code =3D fmt->mbus;
> +
> +	ret =3D v4l2_subdev_call(vip_dev->sensor.sd, pad, enum_frame_size,
> +			       NULL, &fse);
> +	if (ret)
> +		return ret;
> +
> +	fsize->type =3D V4L2_FRMSIZE_TYPE_DISCRETE;
> +	fsize->discrete.width =3D fse.max_width;
> +	fsize->discrete.height =3D fse.max_height;
> +
> +	return 0;
> +}
> +
> +static int rk_vip_enum_frameintervals(struct file *file, void *fh,
> +				      struct v4l2_frmivalenum *fival)
> +{
> +	struct rk_vip_stream *stream =3D video_drvdata(file);
> +	struct rk_vip_device *vip_dev =3D stream->vipdev;
> +	struct v4l2_subdev_frame_interval_enum fie =3D {
> +		.index =3D fival->index,
> +		.width =3D fival->width,
> +		.height =3D fival->height,
> +		.which =3D V4L2_SUBDEV_FORMAT_ACTIVE,
> +	};
> +	struct vip_output_fmt *fmt;
> +	int ret;
> +
> +	if (!vip_dev->sensor.sd)
> +		return -EINVAL;

Probably more -ENODEV.

> +
> +	fmt =3D find_output_fmt(stream, fival->pixel_format);
> +	if (!fmt)
> +		return -EINVAL;
> +
> +	fie.code =3D fmt->mbus;
> +
> +	ret =3D v4l2_subdev_call(vip_dev->sensor.sd, pad, enum_frame_interval,
> +			       NULL, &fie);
> +	if (ret)
> +		return ret;
> +
> +	fival->type =3D V4L2_FRMSIZE_TYPE_DISCRETE;
> +	fival->discrete =3D fie.interval;
> +
> +	return 0;
> +}
> +
> +int rk_vip_register_stream_vdev(struct rk_vip_device *vip_dev)
> +{
> +	struct rk_vip_stream *stream =3D &vip_dev->stream;
> +	struct v4l2_device *v4l2_dev =3D &vip_dev->v4l2_dev;
> +	struct video_device *vdev =3D &stream->vdev;
> +	int ret;
> +
> +	strscpy(vdev->name, VIP_VIDEODEVICE_NAME, sizeof(vdev->name));
> +	mutex_init(&stream->vlock);
> +
> +	vdev->ioctl_ops =3D &rk_vip_v4l2_ioctl_ops;
> +	vdev->release =3D video_device_release_empty;
> +	vdev->fops =3D &rk_vip_fops;
> +	vdev->minor =3D -1;
> +	vdev->v4l2_dev =3D v4l2_dev;
> +	vdev->lock =3D &stream->vlock;
> +	vdev->device_caps =3D V4L2_CAP_VIDEO_CAPTURE_MPLANE |

Same comment as before about mplane support.

> +			    V4L2_CAP_STREAMING;
> +	vdev->tvnorms =3D V4L2_STD_NTSC | V4L2_STD_PAL;
> +	video_set_drvdata(vdev, stream);
> +	vdev->vfl_dir =3D VFL_DIR_RX;
> +	stream->pad.flags =3D MEDIA_PAD_FL_SINK;
> +
> +	rk_vip_init_vb2_queue(&stream->buf_queue, stream);
> +
> +	vdev->queue =3D &stream->buf_queue;
> +	strscpy(vdev->name, KBUILD_MODNAME, sizeof(vdev->name));
> +
> +	ret =3D video_register_device(vdev, VFL_TYPE_VIDEO, -1);
> +	if (ret < 0) {
> +		v4l2_err(v4l2_dev,
> +			 "video_register_device failed with error %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret =3D media_entity_pads_init(&vdev->entity, 1, &stream->pad);
> +	if (ret < 0)
> +		goto unreg;

Please intialize the pads before registering the video device.

> +
> +	return 0;
> +unreg:
> +	video_unregister_device(vdev);
> +	return ret;
> +}
> +
> +irqreturn_t rk_vip_irq_pingpong(int irq, void *ctx)
> +{
> +	struct device *dev =3D ctx;
> +	struct rk_vip_device *vip_dev =3D dev_get_drvdata(dev);
> +	struct rk_vip_stream *stream =3D &vip_dev->stream;
> +	void __iomem *base =3D vip_dev->base_addr;
> +	unsigned int intstat;
> +
> +	u32 lastline, lastpix, ctl, vip_frmst;
> +
> +	intstat =3D read_vip_reg(base, VIP_INTSTAT);
> +	vip_frmst =3D read_vip_reg(base, VIP_FRAME_STATUS);
> +	lastline =3D VIP_FETCH_Y_LAST_LINE(read_vip_reg(base, VIP_LAST_LINE));
> +	lastpix =3D  VIP_FETCH_Y_LAST_LINE(read_vip_reg(base, VIP_LAST_PIX));
> +	ctl =3D read_vip_reg(base, VIP_CTRL);
> +
> +	/* There are two irqs enabled:

Start the comment on the next line.

> +	 *  - PST_INF_FRAME_END: vip FIFO is ready,
> +	 *    this is prior to FRAME_END
> +	 *  - FRAME_END: vip has saved frame to memory,
> +	 *    a frame ready
> +	 */
> +
> +	if ((intstat & VIP_INTSTAT_PST_INF_FRAME_END)) {

No need for (( ... )).

> +		write_vip_reg(base, VIP_INTSTAT,
> +			      VIP_INTSTAT_PST_INF_FRAME_END_CLR);

Newline here.

> +		if (stream->stopping)
> +			/* To stop VIP ASAP, before FRAME_END irq */

Dot at the end.

> +			write_vip_reg(base, VIP_CTRL,
> +				      ctl & (~VIP_CTRL_ENABLE_CAPTURE));
> +	}
> +
> +	if ((intstat & VIP_INTSTAT_PRE_INF_FRAME_END))

Ditto.

> +		write_vip_reg(base, VIP_INTSTAT, VIP_INTSTAT_PRE_INF_FRAME_END);
> +
> +	if (intstat & (VIP_INTSTAT_LINE_ERR | VIP_INTSTAT_PIX_ERR)) {
> +		v4l2_err(&vip_dev->v4l2_dev, "LINE_ERR OR PIX_ERR");

Please make this a more articulate sentence.

> +		write_vip_reg(base, VIP_INTSTAT, VIP_INTSTAT_LINE_ERR |
> +						 VIP_INTSTAT_PIX_ERR);
> +		rk_vip_reset_stream(vip_dev);
> +	}
> +
> +	if ((intstat & VIP_INTSTAT_FRAME_END)) {

Dtto.

> +		struct vb2_v4l2_buffer *vb_done =3D NULL;
> +
> +		write_vip_reg(base, VIP_INTSTAT, VIP_INTSTAT_FRAME_END_CLR |
> +						 VIP_INTSTAT_LINE_END_CLR);
> +
> +		if (stream->stopping) {
> +			rk_vip_stream_stop(stream);
> +			stream->stopping =3D false;
> +			wake_up(&stream->wq_stopped);
> +			return IRQ_HANDLED;
> +		}
> +
> +		if (lastline !=3D stream->pixm.height) {
> +			v4l2_err(&vip_dev->v4l2_dev,
> +				 "Bad frame, irq:0x%x frmst:0x%x size:%dx%d\n",
> +				 intstat, vip_frmst, lastpix, lastline);

Note that you can use %#x instead of 0x%x.

> +
> +			rk_vip_reset_stream(vip_dev);
> +		}
> +
> +		if (vip_frmst & VIP_INTSTAT_F0_READY)
> +			stream->frame_phase =3D 0;
> +		else if (vip_frmst & VIP_INTSTAT_F1_READY)
> +			stream->frame_phase =3D 1;

Would be good to double-check that "ready" really means ready for the CPU s=
ide
to write to this register, not "ready" as in "hardware has just finished wr=
iting
new data to this buffer". Please add a comment to clarify how it should be
understood.

> +		else
> +			return IRQ_HANDLED;
> +
> +		if (stream->buffs[stream->frame_phase])
> +			vb_done =3D &stream->buffs[stream->frame_phase]->vb;
> +
> +		rk_vip_assign_new_buffer_pingpong(stream);
> +
> +		if (vb_done)
> +			rk_vip_vb_done(stream, vb_done);
> +
> +		stream->frame_idx++;
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> diff --git a/drivers/media/platform/rockchip/vip/dev.c b/drivers/media/pl=
atform/rockchip/vip/dev.c
> new file mode 100644
> index 000000000000..c3931e5accbd
> --- /dev/null
> +++ b/drivers/media/platform/rockchip/vip/dev.c
> @@ -0,0 +1,346 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Rockchip VIP Camera Interface Driver
> + *
> + * Copyright (C) 2018 Rockchip Electronics Co., Ltd.
> + * Copyright (C) 2020 Maxime Chevallier <maxime.chevallier@bootlin.com>
> + * Copyright (C) 2023 Mehdi Djait <mehdi.djait@bootlin.com>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_graph.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_reserved_mem.h>
> +#include <linux/reset.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/pinctrl/consumer.h>
> +#include <media/v4l2-fwnode.h>
> +
> +#include "dev.h"
> +#include "regs.h"
> +
> +#define RK_VIP_VERNO_LEN	10
> +
> +struct vip_match_data {
> +	int chip_id;
> +	const char * const *clks;
> +	const char * const *rsts;
> +	int clks_num;
> +	int rsts_num;
> +};
> +
> +static int rk_vip_create_links(struct rk_vip_device *vip_dev)

You can fold this function into the calling one since it's only used once.

> +{
> +	struct v4l2_subdev *sd =3D vip_dev->sensor.sd;
> +	int ret;
> +
> +	ret =3D media_create_pad_link(&sd->entity, 0,
> +				    &vip_dev->stream.vdev.entity, 0,
> +				    MEDIA_LNK_FL_ENABLED);
> +	if (ret) {
> +		dev_err(vip_dev->dev, "failed to create link");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int subdev_notifier_complete(struct v4l2_async_notifier *notifier)
> +{
> +	struct rk_vip_device *vip_dev;
> +	int ret;
> +
> +	vip_dev =3D container_of(notifier, struct rk_vip_device, notifier);
> +
> +	mutex_lock(&vip_dev->media_dev.graph_mutex);
> +
> +	ret =3D v4l2_device_register_subdev_nodes(&vip_dev->v4l2_dev);
> +	if (ret < 0)
> +		goto unlock;
> +
> +	ret =3D rk_vip_create_links(vip_dev);
> +	if (ret < 0)
> +		goto unlock;
> +
> +unlock:
> +	mutex_unlock(&vip_dev->media_dev.graph_mutex);
> +	return ret;
> +}
> +
> +static int vip_subdev_notifier(struct rk_vip_device *vip_dev)
> +{
> +	struct v4l2_async_notifier *ntf =3D &vip_dev->notifier;
> +	struct device *dev =3D vip_dev->dev;
> +	struct v4l2_async_connection *asd;
> +	struct v4l2_fwnode_endpoint vep =3D {
> +		.bus_type =3D V4L2_MBUS_PARALLEL,
> +	};
> +	struct fwnode_handle *ep;
> +	int ret;
> +
> +	v4l2_async_nf_init(ntf, &vip_dev->v4l2_dev);
> +
> +	ep =3D fwnode_graph_get_endpoint_by_id(dev_fwnode(dev), 0, 0,
> +					     FWNODE_GRAPH_ENDPOINT_NEXT);
> +	if (!ep)
> +		return -EINVAL;
> +
> +	ret =3D v4l2_fwnode_endpoint_parse(ep, &vep);
> +	if (ret)
> +		return ret;
> +
> +	asd =3D v4l2_async_nf_add_fwnode_remote(ntf, ep,
> +					      struct v4l2_async_connection);
> +	if (IS_ERR(asd)) {
> +		ret =3D PTR_ERR(asd);
> +		return ret;
> +	}
> +
> +	ntf->ops =3D &subdev_notifier_ops;
> +
> +	fwnode_handle_put(ep);
> +
> +	ret =3D v4l2_async_nf_register(ntf);
> +	return ret;
> +}
> +
> +static int rk_vip_register_platform_subdevs(struct rk_vip_device *vip_de=
v)

Doesn't feel necessary to have this function, just include the two calls
into the calling one.

> +{
> +	int ret;
> +
> +	ret =3D rk_vip_register_stream_vdev(vip_dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D vip_subdev_notifier(vip_dev);
> +	if (ret < 0) {
> +		v4l2_err(&vip_dev->v4l2_dev,
> +			 "Failed to register subdev notifier(%d)\n", ret);
> +		rk_vip_unregister_stream_vdev(vip_dev);
> +	}
> +
> +	return 0;
> +}
> +
> +static const char * const px30_vip_clks[] =3D {

Not sure it's really useful to have const specified twice here.

> +	"aclk",
> +	"hclk",
> +	"pclk",
> +};
> +
> +static const struct vip_match_data px30_vip_match_data =3D {
> +	.chip_id =3D CHIP_PX30_VIP,

This is not used anywhere, I think you can just get rid of it.
Feels like something remaining from the BSP code.

> +	.clks =3D px30_vip_clks,
> +	.clks_num =3D ARRAY_SIZE(px30_vip_clks),
> +};
> +
> +static const struct of_device_id rk_vip_plat_of_match[] =3D {
> +	{
> +		.compatible =3D "rockchip,px30-vip",
> +		.data =3D &px30_vip_match_data,
> +	},
> +	{},
> +};
> +
> +void rk_vip_soft_reset(struct rk_vip_device *vip_dev)
> +{
> +	reset_control_assert(vip_dev->vip_rst);
> +
> +	udelay(5);
> +
> +	reset_control_deassert(vip_dev->vip_rst);

There is a reset toggle function in the reset API. Better use it unless
you absolutely need a specific delay that's not handled by the reset contro=
ller
(in which case there should be a comment to explain it).

> +}
> +
> +static int rk_vip_get_resource(struct platform_device *pdev,
> +			       struct rk_vip_device *vip_dev)
> +{
> +	struct resource *res;
> +
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev,
> +			"Unable to allocate resources for device\n");
> +		return -ENODEV;
> +	}
> +
> +	vip_dev->base_addr =3D devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(vip_dev->base_addr))
> +		return PTR_ERR(vip_dev->base_addr);
> +
> +	return 0;
> +}
> +
> +static int rk_vip_plat_probe(struct platform_device *pdev)
> +{
> +	const struct of_device_id *match;
> +	struct device_node *node =3D pdev->dev.of_node;
> +	struct device *dev =3D &pdev->dev;
> +	struct v4l2_device *v4l2_dev;
> +	struct rk_vip_device *vip_dev;
> +	const struct vip_match_data *data;
> +	int i, ret, irq;
> +
> +	match =3D of_match_node(rk_vip_plat_of_match, node);
> +	if (!match)
> +		return -ENODEV;

Just use of_device_get_match_data to get match->data directly.

> +
> +	vip_dev =3D devm_kzalloc(dev, sizeof(*vip_dev), GFP_KERNEL);
> +	if (!vip_dev)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(dev, vip_dev);

Use platform_set_drvdata instead for good measure.

> +	vip_dev->dev =3D dev;
> +
> +	irq =3D platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +
> +	ret =3D devm_request_irq(dev, irq, rk_vip_irq_pingpong, 0,
> +			       dev_driver_string(dev), dev);
> +	if (ret < 0)

Any ret !=3D 0 is invalid, not just negative ones.

> +		return dev_err_probe(dev, ret, "request irq failed\n");
> +
> +	vip_dev->irq =3D irq;
> +	data =3D match->data;
> +	vip_dev->chip_id =3D data->chip_id;
> +
> +	ret =3D rk_vip_get_resource(pdev, vip_dev);
> +	if (ret)
> +		return ret;
> +
> +	for (i =3D 0; i < data->clks_num; i++)
> +		vip_dev->clks[i].id =3D data->clks[i];
> +
> +	vip_dev->num_clk =3D data->clks_num;

Maybe you could directly define this in the match data (and keeping it arou=
nd)
instead of making a copy. The match data is not going to change or disappea=
r.

> +
> +	ret =3D devm_clk_bulk_get(dev, vip_dev->num_clk, vip_dev->clks);
> +	if (ret)
> +		return ret;
> +
> +	vip_dev->vip_rst =3D devm_reset_control_array_get(dev, false, false);
> +	if (IS_ERR(vip_dev->vip_rst))
> +		return PTR_ERR(vip_dev->vip_rst);
> +
> +	/* Initialize the stream */

Ending dot here.

> +	rk_vip_stream_init(vip_dev);
> +	strscpy(vip_dev->media_dev.model, "rk_vip",
> +		sizeof(vip_dev->media_dev.model));
> +	vip_dev->media_dev.dev =3D &pdev->dev;
> +	v4l2_dev =3D &vip_dev->v4l2_dev;
> +	v4l2_dev->mdev =3D &vip_dev->media_dev;
> +	strscpy(v4l2_dev->name, "rk_vip", sizeof(v4l2_dev->name));

Use the same thing that you're taking for the video device.

> +
> +	ret =3D v4l2_device_register(vip_dev->dev, &vip_dev->v4l2_dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	media_device_init(&vip_dev->media_dev);
> +
> +	ret =3D media_device_register(&vip_dev->media_dev);
> +	if (ret < 0) {
> +		v4l2_err(v4l2_dev, "Failed to register media device: %d\n",
> +			 ret);

You didn't print messages for other errors before here so either do it alwa=
ys or
never, but this one call has nothing special compared to others.

> +		goto err_unreg_v4l2_dev;
> +	}
> +
> +	/* create & register platform subdev (from of_node) */

Capital letter and ending dot here. The of_node part is not relevant.

> +	ret =3D rk_vip_register_platform_subdevs(vip_dev);
> +	if (ret < 0)
> +		goto err_unreg_media_dev;
> +
> +	vip_dev->sensor.std =3D V4L2_STD_NTSC;

You can have this inside the next call.

> +	rk_vip_set_default_format(vip_dev);
> +	pm_runtime_enable(&pdev->dev);
> +
> +	return 0;
> +
> +err_unreg_media_dev:
> +	media_device_unregister(&vip_dev->media_dev);
> +err_unreg_v4l2_dev:
> +	v4l2_device_unregister(&vip_dev->v4l2_dev);
> +	return ret;
> +}
> +
> +static int rk_vip_plat_remove(struct platform_device *pdev)
> +{
> +	struct rk_vip_device *vip_dev =3D platform_get_drvdata(pdev);
> +
> +	pm_runtime_disable(&pdev->dev);
> +
> +	media_device_unregister(&vip_dev->media_dev);
> +	v4l2_device_unregister(&vip_dev->v4l2_dev);
> +	rk_vip_unregister_stream_vdev(vip_dev);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused rk_vip_runtime_suspend(struct device *dev)
> +{
> +	struct rk_vip_device *vip_dev =3D dev_get_drvdata(dev);
> +
> +	clk_bulk_disable_unprepare(vip_dev->num_clk, vip_dev->clks);
> +
> +	return pinctrl_pm_select_sleep_state(dev);
> +}
> +
> +static int __maybe_unused rk_vip_runtime_resume(struct device *dev)
> +{
> +	struct rk_vip_device *vip_dev =3D dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret =3D pinctrl_pm_select_default_state(dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	return clk_bulk_prepare_enable(vip_dev->num_clk, vip_dev->clks);
> +}
> +
> +static const struct dev_pm_ops rk_vip_plat_pm_ops =3D {
> +	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +				pm_runtime_force_resume)
> +	SET_RUNTIME_PM_OPS(rk_vip_runtime_suspend, rk_vip_runtime_resume, NULL)

You can just depend on PM and avoid these conditional macros.

> +};
> +
> +static struct platform_driver rk_vip_plat_drv =3D {
> +	.driver =3D {
> +		   .name =3D VIP_DRIVER_NAME,
> +		   .of_match_table =3D rk_vip_plat_of_match,
> +		   .pm =3D &rk_vip_plat_pm_ops,
> +	},
> +	.probe =3D rk_vip_plat_probe,
> +	.remove =3D rk_vip_plat_remove,
> +};
> +module_platform_driver(rk_vip_plat_drv);
> +
> +MODULE_AUTHOR("Rockchip Camera/ISP team");
> +MODULE_DESCRIPTION("Rockchip VIP platform driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/media/platform/rockchip/vip/dev.h b/drivers/media/pl=
atform/rockchip/vip/dev.h
> new file mode 100644
> index 000000000000..eb9cd8f20ffc
> --- /dev/null
> +++ b/drivers/media/platform/rockchip/vip/dev.h
> @@ -0,0 +1,163 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Rockchip VIP Driver
> + *
> + * Copyright (C) 2018 Rockchip Electronics Co., Ltd.
> + * Copyright (C) 2023 Mehdi Djait <mehdi.djait@bootlin.com>
> + */
> +
> +#ifndef _RK_VIP_DEV_H
> +#define _RK_VIP_DEV_H
> +
> +#include <linux/clk.h>
> +#include <linux/mutex.h>
> +#include <media/media-device.h>
> +#include <media/media-entity.h>
> +#include <media/v4l2-ctrls.h>
> +#include <media/v4l2-device.h>
> +#include <media/videobuf2-v4l2.h>
> +
> +#define VIP_DRIVER_NAME		"rk_vip"
> +#define VIP_VIDEODEVICE_NAME	"stream_vip"

Use "rockchip-cif" for both.

> +
> +#define RK_VIP_MAX_BUS_CLK	8
> +#define RK_VIP_MAX_SENSOR	2

Looks like only one is supported though.

> +#define RK_VIP_MAX_RESET	5
> +#define RK_VIP_MAX_CSI_CHANNEL	4
> +
> +#define RK_VIP_DEFAULT_WIDTH	640
> +#define RK_VIP_DEFAULT_HEIGHT	480

Should be next to the other size-related definitions.

> +
> +#define write_vip_reg(base, addr, val)  writel(val, (addr) + (base))
> +#define read_vip_reg(base, addr) readl((addr) + (base))

See comment about naming consistency in general.

> +enum rk_vip_state {
> +	RK_VIP_STATE_DISABLED,
> +	RK_VIP_STATE_READY,
> +	RK_VIP_STATE_STREAMING
> +};

I think you can get rid of this...

> +enum rk_vip_chip_id {
> +	CHIP_PX30_VIP,
> +	CHIP_RK1808_VIP,
> +	CHIP_RK3128_VIP,
> +	CHIP_RK3288_VIP
> +};

=2E.. and this.

> +
> +enum host_type_t {
> +	RK_CSI_RXHOST,
> +	RK_DSI_RXHOST
> +};

This is not used anywhere, please get rid of it.

> +
> +struct rk_vip_buffer {
> +	struct vb2_v4l2_buffer vb;
> +	struct list_head queue;
> +	union {
> +		u32 buff_addr[VIDEO_MAX_PLANES];
> +		void *vaddr[VIDEO_MAX_PLANES];
> +	};

Why the union? I think you can get rid of vaddr.

> +};
> +
> +struct rk_vip_scratch_buffer {
> +	void *vaddr;
> +	dma_addr_t dma_addr;
> +	u32 size;
> +};

Scratch buffer should not be needed.

> +struct rk_vip_stream {
> +	struct rk_vip_device		*vipdev;

Here you are tab-aligning the name of members but not in other places.
Please make this consistent (here and everywhere else in this file).

> +	enum rk_vip_state		state;
> +	bool				stopping;
> +	wait_queue_head_t		wq_stopped;
> +	int				frame_idx;
> +	int				frame_phase;
> +
> +	/* lock between irq and buf_queue */

Capital letter and ending dot.

> +	spinlock_t			vbq_lock;
> +	struct vb2_queue		buf_queue;
> +	struct list_head		buf_head;
> +	struct rk_vip_scratch_buffer	scratch_buf;
> +	struct rk_vip_buffer		*buffs[2];
> +
> +	/* vfd lock */

Ditto.

> +	struct mutex			vlock;
> +	struct video_device		vdev;
> +	struct media_pad		pad;
> +
> +	struct vip_output_fmt		*vip_fmt_out;
> +	const struct vip_input_fmt	*vip_fmt_in;
> +	struct v4l2_pix_format_mplane	pixm;
> +};
> +
> +static inline struct rk_vip_stream *to_rk_vip_stream(struct video_device=
 *vdev)
> +{
> +	return container_of(vdev, struct rk_vip_stream, vdev);
> +}
> +
> +struct rk_vip_device {
> +	struct list_head		list;
> +	struct device			*dev;
> +	int				irq;
> +	void __iomem			*base_addr;
> +	void __iomem			*csi_base;
> +	struct clk_bulk_data		clks[RK_VIP_MAX_BUS_CLK];
> +	int				num_clk;

I think we can have those in the match data directly and grab a pointer to =
it
in this structure.

> +	struct vb2_alloc_ctx		*alloc_ctx;
> +	bool				iommu_en;
> +	struct iommu_domain		*domain;

All three above are not used.

> +	struct reset_control		*vip_rst;
> +
> +	struct v4l2_device		v4l2_dev;
> +	struct media_device		media_dev;
> +	struct v4l2_ctrl_handler	ctrl_handler;

This is not used, you can get rid of it. I think we no longer expect the
video devices to provide controls when subdev nodes are available (but maybe
this is still the case for video node-centric devices, I'm not sure).

Maybe someone with more precise knowledge can answer here?

> +	struct v4l2_async_notifier	notifier;
> +	struct v4l2_async_connection	asd;
> +	struct rk_vip_sensor_info	sensor;
> +
> +	struct rk_vip_stream		stream;
> +
> +	int				chip_id;

Not used/needed.

> +};
> +
> +void rk_vip_unregister_stream_vdev(struct rk_vip_device *dev);
> +int rk_vip_register_stream_vdev(struct rk_vip_device *dev);
> +void rk_vip_stream_init(struct rk_vip_device *dev);
> +void rk_vip_set_default_format(struct rk_vip_device *dev);
> +
> +irqreturn_t rk_vip_irq_pingpong(int irq, void *ctx);
> +void rk_vip_soft_reset(struct rk_vip_device *vip_dev);
> +
> +#endif
> diff --git a/drivers/media/platform/rockchip/vip/regs.h b/drivers/media/p=
latform/rockchip/vip/regs.h
> new file mode 100644
> index 000000000000..ccf10ffbbff8
> --- /dev/null
> +++ b/drivers/media/platform/rockchip/vip/regs.h
> @@ -0,0 +1,260 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Rockchip VIP Driver
> + *
> + * Copyright (C) 2018 Rockchip Electronics Co., Ltd.
> + * Copyright (C) 2023 Mehdi Djait <mehdi.djait@bootlin.com>
> + */
> +
> +#ifndef _RK_VIP_REGS_H
> +#define _RK_VIP_REGS_H
> +
> +/* VIP Reg Offset */
> +#define VIP_CTRL				0x00
> +#define VIP_INTEN				0x04
> +#define VIP_INTSTAT				0x08
> +#define VIP_FOR					0x0c
> +#define VIP_LINE_NUM_ADDR			0x10
> +#define VIP_FRM0_ADDR_Y				0x14
> +#define VIP_FRM0_ADDR_UV			0x18
> +#define VIP_FRM1_ADDR_Y				0x1c
> +#define VIP_FRM1_ADDR_UV			0x20
> +#define VIP_VIR_LINE_WIDTH			0x24
> +#define VIP_SET_SIZE				0x28
> +#define VIP_SCM_ADDR_Y				0x2c
> +#define VIP_SCM_ADDR_U				0x30
> +#define VIP_SCM_ADDR_V				0x34
> +#define VIP_WB_UP_FILTER			0x38
> +#define VIP_WB_LOW_FILTER			0x3c
> +#define VIP_WBC_CNT				0x40
> +#define VIP_CROP				0x44
> +#define VIP_SCL_CTRL				0x48
> +#define VIP_SCL_DST				0x4c
> +#define VIP_SCL_FCT				0x50
> +#define VIP_SCL_VALID_NUM			0x54
> +#define VIP_LINE_LOOP_CTR			0x58
> +#define VIP_FRAME_STATUS			0x60
> +#define VIP_CUR_DST				0x64
> +#define VIP_LAST_LINE				0x68
> +#define VIP_LAST_PIX				0x6c
> +
> +/* RK1808 VIP CSI Registers Offset */

Get rid of RK1808, it's not supported yet and it's the weird one out there.

> +#define VIP_CSI_ID0_CTRL0			0x80
> +#define VIP_CSI_ID0_CTRL1			0x84
> +#define VIP_CSI_ID1_CTRL0			0x88
> +#define VIP_CSI_ID1_CTRL1			0x8c
> +#define VIP_CSI_ID2_CTRL0			0x90
> +#define VIP_CSI_ID2_CTRL1			0x94
> +#define VIP_CSI_ID3_CTRL0			0x98
> +#define VIP_CSI_ID3_CTRL1			0x9c
> +#define VIP_CSI_WATER_LINE			0xa0
> +#define VIP_CSI_FRM0_ADDR_Y_ID0			0xa4
> +#define VIP_CSI_FRM1_ADDR_Y_ID0			0xa8
> +#define VIP_CSI_FRM0_ADDR_UV_ID0		0xac
> +#define VIP_CSI_FRM1_ADDR_UV_ID0		0xb0
> +#define VIP_CSI_FRM0_VLW_Y_ID0			0xb4
> +#define VIP_CSI_FRM1_VLW_Y_ID0			0xb8
> +#define VIP_CSI_FRM0_VLW_UV_ID0			0xbc
> +#define VIP_CSI_FRM1_VLW_UV_ID0			0xc0
> +#define VIP_CSI_FRM0_ADDR_Y_ID1			0xc4
> +#define VIP_CSI_FRM1_ADDR_Y_ID1			0xc8
> +#define VIP_CSI_FRM0_ADDR_UV_ID1		0xcc
> +#define VIP_CSI_FRM1_ADDR_UV_ID1		0xd0
> +#define VIP_CSI_FRM0_VLW_Y_ID1			0xd4
> +#define VIP_CSI_FRM1_VLW_Y_ID1			0xd8
> +#define VIP_CSI_FRM0_VLW_UV_ID1			0xdc
> +#define VIP_CSI_FRM1_VLW_UV_ID1			0xe0
> +#define VIP_CSI_FRM0_ADDR_Y_ID2			0xe4
> +#define VIP_CSI_FRM1_ADDR_Y_ID2			0xe8
> +#define VIP_CSI_FRM0_ADDR_UV_ID2		0xec
> +#define VIP_CSI_FRM1_ADDR_UV_ID2		0xf0
> +#define VIP_CSI_FRM0_VLW_Y_ID2			0xf4
> +#define VIP_CSI_FRM1_VLW_Y_ID2			0xf8
> +#define VIP_CSI_FRM0_VLW_UV_ID2			0xfc
> +#define VIP_CSI_FRM1_VLW_UV_ID2			0x100
> +#define VIP_CSI_FRM0_ADDR_Y_ID3			0x104
> +#define VIP_CSI_FRM1_ADDR_Y_ID3			0x108
> +#define VIP_CSI_FRM0_ADDR_UV_ID3		0x10c
> +#define VIP_CSI_FRM1_ADDR_UV_ID3		0x110
> +#define VIP_CSI_FRM0_VLW_Y_ID3			0x114
> +#define VIP_CSI_FRM1_VLW_Y_ID3			0x118
> +#define VIP_CSI_FRM0_VLW_UV_ID3			0x11c
> +#define VIP_CSI_FRM1_VLW_UV_ID3			0x120
> +#define VIP_CSI_INTEN				0x124
> +#define VIP_CSI_INTSTAT				0x128
> +#define VIP_CSI_LINE_INT_NUM_ID0_1		0x12c
> +#define VIP_CSI_LINE_INT_NUM_ID2_3		0x130
> +#define VIP_CSI_LINE_CNT_ID0_1			0x134
> +#define VIP_CSI_LINE_CNT_ID2_3			0x138
> +#define VIP_CSI_ID0_CROP_START			0x13c
> +#define VIP_CSI_ID1_CROP_START			0x140
> +#define VIP_CSI_ID2_CROP_START			0x144
> +#define VIP_CSI_ID3_CROP_START			0x148
> +
> +/* The key register bit description */

This comment is not useful, remove it.

> +
> +/* VIP_CTRL Reg */

All these heading comments are not useful either.

> +#define VIP_CTRL_ENABLE_CAPTURE			BIT(0)
> +#define VIP_CTRL_MODE_PINGPONG			BIT(1)
> +#define VIP_CTRL_MODE_LINELOOP			BIT(2)
> +#define VIP_CTRL_AXI_BURST_16			(0xF << 12)

Please make sure you stay consistent with hex values: have them all lowerca=
se
and prefixed with a zero when < 0x10 (or something else you might prefer, b=
ut
keep it consistent).

> +
> +/* VIP_INTEN */
> +#define VIP_INTEN_FRAME_END_EN			BIT(0)
> +#define VIP_INTEN_LINE_ERR_EN			BIT(2)
> +#define VIP_INTEN_BUS_ERR_EN			BIT(6)
> +#define VIP_INTEN_SCL_ERR_EN			BIT(7)
> +#define VIP_INTEN_PST_INF_FRAME_END_EN		BIT(9)
> +
> +/* VIP INTSTAT */
> +#define VIP_INTSTAT_CLS				0x3FF
> +#define VIP_INTSTAT_FRAME_END			BIT(0)
> +#define VIP_INTSTAT_LINE_END			BIT(1)
> +#define VIP_INTSTAT_LINE_ERR			BIT(2)
> +#define VIP_INTSTAT_PIX_ERR			BIT(3)
> +#define VIP_INTSTAT_DFIFO_OF			BIT(5)
> +#define VIP_INTSTAT_BUS_ERR			BIT(6)
> +#define VIP_INTSTAT_PRE_INF_FRAME_END		BIT(8)
> +#define VIP_INTSTAT_PST_INF_FRAME_END		BIT(9)
> +#define VIP_INTSTAT_FRAME_END_CLR		BIT(0)
> +#define VIP_INTSTAT_LINE_END_CLR		BIT(1)
> +#define VIP_INTSTAT_LINE_ERR_CLR		BIT(2)
> +#define VIP_INTSTAT_PST_INF_FRAME_END_CLR	BIT(9)
> +#define VIP_INTSTAT_ERR				0xFC
> +
> +/* VIP_FRAME STATUS */
> +#define VIP_FRAME_STAT_CLS			0x00
> +/* write 0 to clear frame 0 */

This comment is a bit cryptic. Either improve it or remove it.

Cheers,

Paul

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--DTNud2UJK/Bj3czp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmUynwEACgkQ3cLmz3+f
v9FiwQf+Pr0KtUAiEL/8u5356iduFL8bU4vn7IrvoqfH8YDArRP4bo1E5abkBcGe
2bSMrFjG9C6FkLLyNfkKScKDNMY9WtjEXuhflRZK8X6w/UWA3TiTKVOslglnG5qa
DBW64iQ5nYP5cedeyl+3NIOrQswmQffPofnW9c3gxTYZE1HquKvfXgNWvdOjtlkS
IqOzepKSQVBDfb3JJhy15k6CvUEsTmyWFj+Q78gFQVNOwvJESGh2B2z3kDVlPrxb
+1Bds0EDYUFvXTEqMdoiqVzHmY0bj+2aRxvPPMhksBgYhwQlLlHs+DbHUyVMu/gR
zOnt3Eff6pdbZQMbFVLsNzt2YUikqw==
=Y0kR
-----END PGP SIGNATURE-----

--DTNud2UJK/Bj3czp--
