Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039CD7DF858
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 18:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377124AbjKBRIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 13:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235577AbjKBRIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 13:08:11 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80673184;
        Thu,  2 Nov 2023 10:08:05 -0700 (PDT)
Received: from localhost (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dbrouwer)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3150B6601711;
        Thu,  2 Nov 2023 17:08:03 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698944883;
        bh=HxO1+U33MO4A8FHmVRIQuTTtZl2QLDqDP44tUmlEqLg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X/cjBjLWdF2rvfRRwrSOh4XeD8IkoYQ3GQEEXemVEdjGkJBf0801QkQRy177yhwyF
         mtOBmmTwzHCdrWIew0+Fj2tHD7vKFaaof8dPy5Ro9QXGR4sO2/3iI6RQFT1ozMd2Ve
         a/s7lWBzTyjnuojkQVgIdMfFy5jmK4n+3OlrIZNOtqqNuuXFRvjaQxmK/8E4yT22ck
         kS5LSFm/RwkD+UIcSOo3KULkhtmBMaziHpxlgG3LSeOXDSEi9luUVNk4Y7prJlqwL7
         QFAlMw5Zz3YRC7Ncu1Z55g20bjtjxCqF6hw+qUPiNi9QKSiVO41muOswBrmYf8pY6v
         adn7Luw0ekCzw==
Date:   Thu, 2 Nov 2023 10:07:59 -0700
From:   Deborah Brouwer <deborah.brouwer@collabora.com>
To:     Ivan Bornyakov <brnkv.i1@gmail.com>
Cc:     Sebastian Fricke <sebastian.fricke@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jackson Lee <jackson.lee@chipsnmedia.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Nas Chung <nas.chung@chipsnmedia.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-media@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>,
        linux-kernel@vger.kernel.org,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        kernel@collabora.com, Robert Beckett <bob.beckett@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Darren Etheridge <detheridge@ti.com>
Subject: Re: [PATCH v13 5/8] media: chips-media: wave5: Add the v4l2 layer
Message-ID: <ZUPXb10lU8UZHVQz@mz550>
References: <20230929-wave5_v13_media_master-v13-5-5ac60ccbf2ce@collabora.com>
 <20231017221359.20164-1-brnkv.i1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231017221359.20164-1-brnkv.i1@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 01:13:52AM +0300, Ivan Bornyakov wrote:
> Hi!

Hi Ivan,

> 
> On Thu, 12 Oct 2023 13:01:03 +0200, Sebastian Fricke wrote:
> > Add the decoder and encoder implementing the v4l2
> > API. This patch also adds the Makefile and the VIDEO_WAVE_VPU config
> > 
> > Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
> > Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> > Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
> > Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
> > Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
> > Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
> > ---
> >  drivers/media/platform/chips-media/Kconfig         |    1 +
> >  drivers/media/platform/chips-media/Makefile        |    1 +
> >  drivers/media/platform/chips-media/wave5/Kconfig   |   12 +
> >  drivers/media/platform/chips-media/wave5/Makefile  |   10 +
> >  .../platform/chips-media/wave5/wave5-helper.c      |  213 +++
> >  .../platform/chips-media/wave5/wave5-helper.h      |   31 +
> >  .../platform/chips-media/wave5/wave5-vpu-dec.c     | 1953 ++++++++++++++++++++
> >  .../platform/chips-media/wave5/wave5-vpu-enc.c     | 1794 ++++++++++++++++++
> >  .../media/platform/chips-media/wave5/wave5-vpu.c   |  291 +++
> >  .../media/platform/chips-media/wave5/wave5-vpu.h   |   83 +
> >  .../platform/chips-media/wave5/wave5-vpuapi.h      |    2 -
> >  11 files changed, 4389 insertions(+), 2 deletions(-)
> 
> [...]
> 
> > diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> > new file mode 100644
> > index 000000000000..74d1fae64fa4
> > --- /dev/null
> > +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> 
> [...]
> 
> > +static int wave5_vpu_dec_queue_setup(struct vb2_queue *q, unsigned int *num_buffers,
> > +				     unsigned int *num_planes, unsigned int sizes[],
> > +				     struct device *alloc_devs[])
> > +{
> > +	struct vpu_instance *inst = vb2_get_drv_priv(q);
> > +	struct v4l2_pix_format_mplane inst_format =
> > +		(q->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) ? inst->src_fmt : inst->dst_fmt;
> > +	unsigned int i;
> > +
> > +	dev_dbg(inst->dev->dev, "%s: num_buffers: %u | num_planes: %u | type: %u\n", __func__,
> > +		*num_buffers, *num_planes, q->type);
> > +
> > +	/* the CREATE_BUFS case */
> > +	if (*num_planes) {
> > +		if (inst_format.num_planes != *num_planes)
> > +			return -EINVAL;
> > +
> > +		for (i = 0; i < *num_planes; i++) {
> > +			if (sizes[i] < inst_format.plane_fmt[i].sizeimage)
> > +				return -EINVAL;
> > +		}
> > +	/* the REQBUFS case */
> > +	} else {
> > +		*num_planes = inst_format.num_planes;
> > +
> > +		if (q->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
> > +			sizes[0] = inst_format.plane_fmt[0].sizeimage;
> > +			dev_dbg(inst->dev->dev, "%s: size[0]: %u\n", __func__, sizes[0]);
> > +		} else if (*num_planes == 1) {
> 
> I think, you should also set *num_buffers to be inst->fbc_buf_count for
> V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE, like this:
> 
> 		} else if (q->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) {
> 			if (*num_buffers < inst->fbc_buf_count)
> 				*num_buffers = inst->fbc_buf_count;
> 
> 			switch (*num_planes) {
> 			case 1:
> 				...
> 			case 2:
> 				...
> 			case 3:
> 				...
> 			}
> 		}

I was able to reproduce this issue by requesting a small number of buffers
on the CAPTURE queue that was less than inst→fbc_buf_count. When this happens,
wave5_vpu_dec_job_ready() fails here:
(v4l2_m2m_num_dst_bufs_ready(m2m_ctx) < (inst->fbc_buf_count - 1)

I also tested your suggestion to set the *num_buffers to  inst→fbc_buf_count
in queue_setup() and it seems to be working well, thanks for this.

I've been working on ways to improve testing for stateful decoders so
I'm curious how you found this issue?

With fluster tests that we use, gstreamer seems to be calculating correct number of
CAPTURE buffers to request, so we wouldn't see this.

> 
> The reason for that is if fbc_buf_count is greater than initial num_buffers,
> wave5_vpu_dec_job_ready() wouldn't allow to invoke wave5_vpu_dec_device_run()
> 
> Here is a part of the log of described situation:
> 
>   vdec 20410000.wave515: Switch state from NONE to OPEN.
>   [...]
>   vdec 20410000.wave515: wave5_vpu_dec_init_seq: init seq sent (queue 1 : 1)
>   vdec 20410000.wave515: wave5_vpu_dec_get_seq_info: init seq complete (queue 0 : 0)
>   [...]
>   vdec 20410000.wave515: handle_dynamic_resolution_change: width: 4112 height: 3008 profile: 1 | minbuffer: 6
>   ^^^^^^^^ note that minbuffer is 6
> 
>   vdec 20410000.wave515: Switch state from OPEN to INIT_SEQ.
>   [...]
>   vdec 20410000.wave515: decoder command: 1
>   [...]
>   vdec 20410000.wave515: wave5_vpu_dec_queue_setup: num_buffers: 4 | num_planes: 0 | type: 9
>   ^^^^^^^^ note that num_buffers is 4
> 
>   vdec 20410000.wave515: wave5_vpu_dec_queue_setup: size[0]: 18625536
>   vdec 20410000.wave515: CAPTURE queue must be streaming to queue jobs!
>   vdec 20410000.wave515: CAPTURE queue must be streaming to queue jobs!
>   vdec 20410000.wave515: CAPTURE queue must be streaming to queue jobs!
>   vdec 20410000.wave515: CAPTURE queue must be streaming to queue jobs!
>   vdec 20410000.wave515: wave5_vpu_dec_buf_queue: type:    9 index:    0 size: ([0]=18625536, [1]=   0, [2]=   0)
>   vdec 20410000.wave515: wave5_vpu_dec_buf_queue: type:    9 index:    1 size: ([0]=18625536, [1]=   0, [2]=   0)
>   vdec 20410000.wave515: wave5_vpu_dec_buf_queue: type:    9 index:    2 size: ([0]=18625536, [1]=   0, [2]=   0)
>   vdec 20410000.wave515: wave5_vpu_dec_buf_queue: type:    9 index:    3 size: ([0]=18625536, [1]=   0, [2]=   0)
>   vdec 20410000.wave515: wave5_vpu_dec_start_streaming: type: 9
>   vdec 20410000.wave515: No capture buffer ready to decode!
>   ^^^^^^^^ here v4l2_m2m_num_dst_bufs_ready(m2m_ctx) < (inst->fbc_buf_count - 1), namely 4 < 6
>   
>   vdec 20410000.wave515: wave5_vpu_dec_stop_streaming: type: 9
>   vdec 20410000.wave515: streamoff_capture: Setting display flag of buf index: 0, fail: -22
>   vdec 20410000.wave515: streamoff_capture: Setting display flag of buf index: 1, fail: -22
>   vdec 20410000.wave515: streamoff_capture: Setting display flag of buf index: 2, fail: -22
>   vdec 20410000.wave515: streamoff_capture: Setting display flag of buf index: 3, fail: -22
>   [...]
>   vdec 20410000.wave515: wave5_vpu_dec_close: dec_finish_seq complete
> 
> Altering num_buffers solves the issue for me.
> 
> > +			if (inst->output_format == FORMAT_422)
> > +				sizes[0] = inst_format.width * inst_format.height * 2;
> > +			else
> > +				sizes[0] = inst_format.width * inst_format.height * 3 / 2;
> > +			dev_dbg(inst->dev->dev, "%s: size[0]: %u\n", __func__, sizes[0]);
> > +		} else if (*num_planes == 2) {
> > +			sizes[0] = inst_format.width * inst_format.height;
> > +			if (inst->output_format == FORMAT_422)
> > +				sizes[1] = inst_format.width * inst_format.height;
> > +			else
> > +				sizes[1] = inst_format.width * inst_format.height / 2;
> > +			dev_dbg(inst->dev->dev, "%s: size[0]: %u | size[1]: %u\n",
> > +				__func__, sizes[0], sizes[1]);
> > +		} else if (*num_planes == 3) {
> > +			sizes[0] = inst_format.width * inst_format.height;
> > +			if (inst->output_format == FORMAT_422) {
> > +				sizes[1] = inst_format.width * inst_format.height / 2;
> > +				sizes[2] = inst_format.width * inst_format.height / 2;
> > +			} else {
> > +				sizes[1] = inst_format.width * inst_format.height / 4;
> > +				sizes[2] = inst_format.width * inst_format.height / 4;
> > +			}
> > +			dev_dbg(inst->dev->dev, "%s: size[0]: %u | size[1]: %u | size[2]: %u\n",
> > +				__func__, sizes[0], sizes[1], sizes[2]);
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> 
> BTW I'm currently tinkering with your patchset on another C&M IP and would be
> gratefull if you Cc me in the future versions of the patchset, if any.

Yes, sorry for missing you on v13, thanks for taking the time to review.

Deborah

> 
> Thanks.
