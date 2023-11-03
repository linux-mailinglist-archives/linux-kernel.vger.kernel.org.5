Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0159B7E01E4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 12:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347166AbjKCKnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 06:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjKCKnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 06:43:04 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B834ED7;
        Fri,  3 Nov 2023 03:43:00 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c501bd6ff1so27055481fa.3;
        Fri, 03 Nov 2023 03:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699008179; x=1699612979; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rOiFKv22ji7PySyrKL0ewmg7pOgYyRXkIz/R1Hq2LC0=;
        b=MdH3eer/ZlscSHIKoqI8qzCfyyp2akrS293WDe2Vj27KD2Nu33gIOA0q2NEGZfatTX
         Kh6+tnHibGK62niFU7xGQ/MwUuOpqo7JaKkXLoIp8cZMxMiX22YcMV1vmotVkj9HRwQb
         Qd4v8LnxiP+GYQvkjS4E8tgc2vSXV1IPaxKosZSq3QSvoW4fntZkX9CND5sK9cGhUaTo
         peDRM3bxaQKb2rKZnFYAlL5je820dAWbgElu2dtTpjXa6BE8UdeKRn6syNe92hO4Qe7n
         1qdnD37vbAPZE/RvBBVJ5NrrGpusvg3tW+3voZEnid8gG2SExLyCMKQ96SbYqycVdKaC
         LhCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699008179; x=1699612979;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rOiFKv22ji7PySyrKL0ewmg7pOgYyRXkIz/R1Hq2LC0=;
        b=cgkoklvl05avDpybMeinUcE/A8xhggMS+OcI7TjEkYzaBGI/Zf6G6CY7Xr8vZeW7w2
         rbct2QaCqRzCR107yOCznbKqKNOTGFYqfhZYWLsTpgDeYLtOSZZBoBvBDoUSTJVnUtmZ
         vg4jnWbsNBDQxShZBRJPrmu5YmyReSRkpiRqh18tm6JoMyAAwvQaEhMnkBtMB4NxRxJ6
         DipSRMe3ZI8BsxslVXFZQmwWDjEZSauOLk+MpGkyocRV6PYuqaUvJ9GoxxsWix2q/aTy
         jz78Dp4EvMp+X5337FmP+g5OP92UUpcu+ArTjJPrMaluWMlGEvfp2d5nJuMF2Kt6LZMc
         1glQ==
X-Gm-Message-State: AOJu0YwIMVtEabO9E6XdQwO6ZKGOaOyElHaY3GxpTYvTC63gpziaJfNh
        otZ6Bi8ekKqS/yvWwGfT9oI=
X-Google-Smtp-Source: AGHT+IGbn0nx+Y009fjMnwmpnZ70XY+afYMPUz8npLOVqOYkmnqFB4avZCMRxXE0cwwlR3mofK1gwg==
X-Received: by 2002:ac2:410c:0:b0:509:4492:2a94 with SMTP id b12-20020ac2410c000000b0050944922a94mr4295780lfi.49.1699008178530;
        Fri, 03 Nov 2023 03:42:58 -0700 (PDT)
Received: from localhost.localdomain ([178.70.169.129])
        by smtp.gmail.com with ESMTPSA id o25-20020ac25e39000000b00507f7eca29asm192001lfg.68.2023.11.03.03.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 03:42:57 -0700 (PDT)
Date:   Fri, 3 Nov 2023 13:42:55 +0300
From:   Ivan Bornyakov <brnkv.i1@gmail.com>
To:     Deborah Brouwer <deborah.brouwer@collabora.com>
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
Message-ID: <d7pzf5sirz6zdx4qenzbaitalm3owkie67weqdurcx7wfisebh@fxri7a37bapj>
References: <20230929-wave5_v13_media_master-v13-5-5ac60ccbf2ce@collabora.com>
 <20231017221359.20164-1-brnkv.i1@gmail.com>
 <ZUPXb10lU8UZHVQz@mz550>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZUPXb10lU8UZHVQz@mz550>
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Deborah

On Thu, Nov 02, 2023 at 10:07:59AM -0700, Deborah Brouwer wrote:
> On Wed, Oct 18, 2023 at 01:13:52AM +0300, Ivan Bornyakov wrote:
> > Hi!
> 
> Hi Ivan,
> 
> > 
> > On Thu, 12 Oct 2023 13:01:03 +0200, Sebastian Fricke wrote:
> > > Add the decoder and encoder implementing the v4l2
> > > API. This patch also adds the Makefile and the VIDEO_WAVE_VPU config
> > > 
> > > Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
> > > Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> > > Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
> > > Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
> > > Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
> > > Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
> > > ---
> > >  drivers/media/platform/chips-media/Kconfig         |    1 +
> > >  drivers/media/platform/chips-media/Makefile        |    1 +
> > >  drivers/media/platform/chips-media/wave5/Kconfig   |   12 +
> > >  drivers/media/platform/chips-media/wave5/Makefile  |   10 +
> > >  .../platform/chips-media/wave5/wave5-helper.c      |  213 +++
> > >  .../platform/chips-media/wave5/wave5-helper.h      |   31 +
> > >  .../platform/chips-media/wave5/wave5-vpu-dec.c     | 1953 ++++++++++++++++++++
> > >  .../platform/chips-media/wave5/wave5-vpu-enc.c     | 1794 ++++++++++++++++++
> > >  .../media/platform/chips-media/wave5/wave5-vpu.c   |  291 +++
> > >  .../media/platform/chips-media/wave5/wave5-vpu.h   |   83 +
> > >  .../platform/chips-media/wave5/wave5-vpuapi.h      |    2 -
> > >  11 files changed, 4389 insertions(+), 2 deletions(-)
> > 
> > [...]
> > 
> > > diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> > > new file mode 100644
> > > index 000000000000..74d1fae64fa4
> > > --- /dev/null
> > > +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> > 
> > [...]
> > 
> > > +static int wave5_vpu_dec_queue_setup(struct vb2_queue *q, unsigned int *num_buffers,
> > > +				     unsigned int *num_planes, unsigned int sizes[],
> > > +				     struct device *alloc_devs[])
> > > +{
> > > +	struct vpu_instance *inst = vb2_get_drv_priv(q);
> > > +	struct v4l2_pix_format_mplane inst_format =
> > > +		(q->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) ? inst->src_fmt : inst->dst_fmt;
> > > +	unsigned int i;
> > > +
> > > +	dev_dbg(inst->dev->dev, "%s: num_buffers: %u | num_planes: %u | type: %u\n", __func__,
> > > +		*num_buffers, *num_planes, q->type);
> > > +
> > > +	/* the CREATE_BUFS case */
> > > +	if (*num_planes) {
> > > +		if (inst_format.num_planes != *num_planes)
> > > +			return -EINVAL;
> > > +
> > > +		for (i = 0; i < *num_planes; i++) {
> > > +			if (sizes[i] < inst_format.plane_fmt[i].sizeimage)
> > > +				return -EINVAL;
> > > +		}
> > > +	/* the REQBUFS case */
> > > +	} else {
> > > +		*num_planes = inst_format.num_planes;
> > > +
> > > +		if (q->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
> > > +			sizes[0] = inst_format.plane_fmt[0].sizeimage;
> > > +			dev_dbg(inst->dev->dev, "%s: size[0]: %u\n", __func__, sizes[0]);
> > > +		} else if (*num_planes == 1) {
> > 
> > I think, you should also set *num_buffers to be inst->fbc_buf_count for
> > V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE, like this:
> > 
> > 		} else if (q->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) {
> > 			if (*num_buffers < inst->fbc_buf_count)
> > 				*num_buffers = inst->fbc_buf_count;
> > 
> > 			switch (*num_planes) {
> > 			case 1:
> > 				...
> > 			case 2:
> > 				...
> > 			case 3:
> > 				...
> > 			}
> > 		}
> 
> I was able to reproduce this issue by requesting a small number of buffers
> on the CAPTURE queue that was less than inst→fbc_buf_count. When this happens,
> wave5_vpu_dec_job_ready() fails here:
> (v4l2_m2m_num_dst_bufs_ready(m2m_ctx) < (inst->fbc_buf_count - 1)
> 
> I also tested your suggestion to set the *num_buffers to  inst→fbc_buf_count
> in queue_setup() and it seems to be working well, thanks for this.
> 
> I've been working on ways to improve testing for stateful decoders so
> I'm curious how you found this issue?
> 
> With fluster tests that we use, gstreamer seems to be calculating correct number of
> CAPTURE buffers to request, so we wouldn't see this.
> 

I use v4l2-ctl and ffmpeg for testing the decoder.

The first time I've encountered the discussed issue was when v4l2-ctl was
able to decode one file but not the other with bigger resolution.

For v4l2-ctl command line will look like this:
v4l2-ctl --stream-from src-file.h265 --stream-to out-file.yuv --stream-mmap --stream-out-mmap

For ffmpeg command line will look like this:
ffmpeg -c:v hevc_v4l2m2m -i src-file.h265 -fps_mode passthrough out-file.yuv

Also for ffmpeg there are options -num_output_buffers and -num_capture_buffers 
to set initial numbers of buffers in OUTPUT and CAPTURE queues, by
default they are set to 20 or so.

> > 
> > The reason for that is if fbc_buf_count is greater than initial num_buffers,
> > wave5_vpu_dec_job_ready() wouldn't allow to invoke wave5_vpu_dec_device_run()
> > 
> > Here is a part of the log of described situation:
> > 
> >   vdec 20410000.wave515: Switch state from NONE to OPEN.
> >   [...]
> >   vdec 20410000.wave515: wave5_vpu_dec_init_seq: init seq sent (queue 1 : 1)
> >   vdec 20410000.wave515: wave5_vpu_dec_get_seq_info: init seq complete (queue 0 : 0)
> >   [...]
> >   vdec 20410000.wave515: handle_dynamic_resolution_change: width: 4112 height: 3008 profile: 1 | minbuffer: 6
> >   ^^^^^^^^ note that minbuffer is 6
> > 
> >   vdec 20410000.wave515: Switch state from OPEN to INIT_SEQ.
> >   [...]
> >   vdec 20410000.wave515: decoder command: 1
> >   [...]
> >   vdec 20410000.wave515: wave5_vpu_dec_queue_setup: num_buffers: 4 | num_planes: 0 | type: 9
> >   ^^^^^^^^ note that num_buffers is 4
> > 
> >   vdec 20410000.wave515: wave5_vpu_dec_queue_setup: size[0]: 18625536
> >   vdec 20410000.wave515: CAPTURE queue must be streaming to queue jobs!
> >   vdec 20410000.wave515: CAPTURE queue must be streaming to queue jobs!
> >   vdec 20410000.wave515: CAPTURE queue must be streaming to queue jobs!
> >   vdec 20410000.wave515: CAPTURE queue must be streaming to queue jobs!
> >   vdec 20410000.wave515: wave5_vpu_dec_buf_queue: type:    9 index:    0 size: ([0]=18625536, [1]=   0, [2]=   0)
> >   vdec 20410000.wave515: wave5_vpu_dec_buf_queue: type:    9 index:    1 size: ([0]=18625536, [1]=   0, [2]=   0)
> >   vdec 20410000.wave515: wave5_vpu_dec_buf_queue: type:    9 index:    2 size: ([0]=18625536, [1]=   0, [2]=   0)
> >   vdec 20410000.wave515: wave5_vpu_dec_buf_queue: type:    9 index:    3 size: ([0]=18625536, [1]=   0, [2]=   0)
> >   vdec 20410000.wave515: wave5_vpu_dec_start_streaming: type: 9
> >   vdec 20410000.wave515: No capture buffer ready to decode!
> >   ^^^^^^^^ here v4l2_m2m_num_dst_bufs_ready(m2m_ctx) < (inst->fbc_buf_count - 1), namely 4 < 6
> >   
> >   vdec 20410000.wave515: wave5_vpu_dec_stop_streaming: type: 9
> >   vdec 20410000.wave515: streamoff_capture: Setting display flag of buf index: 0, fail: -22
> >   vdec 20410000.wave515: streamoff_capture: Setting display flag of buf index: 1, fail: -22
> >   vdec 20410000.wave515: streamoff_capture: Setting display flag of buf index: 2, fail: -22
> >   vdec 20410000.wave515: streamoff_capture: Setting display flag of buf index: 3, fail: -22
> >   [...]
> >   vdec 20410000.wave515: wave5_vpu_dec_close: dec_finish_seq complete
> > 
> > Altering num_buffers solves the issue for me.
> > 
> > > +			if (inst->output_format == FORMAT_422)
> > > +				sizes[0] = inst_format.width * inst_format.height * 2;
> > > +			else
> > > +				sizes[0] = inst_format.width * inst_format.height * 3 / 2;
> > > +			dev_dbg(inst->dev->dev, "%s: size[0]: %u\n", __func__, sizes[0]);
> > > +		} else if (*num_planes == 2) {
> > > +			sizes[0] = inst_format.width * inst_format.height;
> > > +			if (inst->output_format == FORMAT_422)
> > > +				sizes[1] = inst_format.width * inst_format.height;
> > > +			else
> > > +				sizes[1] = inst_format.width * inst_format.height / 2;
> > > +			dev_dbg(inst->dev->dev, "%s: size[0]: %u | size[1]: %u\n",
> > > +				__func__, sizes[0], sizes[1]);
> > > +		} else if (*num_planes == 3) {
> > > +			sizes[0] = inst_format.width * inst_format.height;
> > > +			if (inst->output_format == FORMAT_422) {
> > > +				sizes[1] = inst_format.width * inst_format.height / 2;
> > > +				sizes[2] = inst_format.width * inst_format.height / 2;
> > > +			} else {
> > > +				sizes[1] = inst_format.width * inst_format.height / 4;
> > > +				sizes[2] = inst_format.width * inst_format.height / 4;
> > > +			}
> > > +			dev_dbg(inst->dev->dev, "%s: size[0]: %u | size[1]: %u | size[2]: %u\n",
> > > +				__func__, sizes[0], sizes[1], sizes[2]);
> > > +		}
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > 
> > BTW I'm currently tinkering with your patchset on another C&M IP and would be
> > gratefull if you Cc me in the future versions of the patchset, if any.
> 
> Yes, sorry for missing you on v13, thanks for taking the time to review.
> 
> Deborah
> 
> > 
> > Thanks.
