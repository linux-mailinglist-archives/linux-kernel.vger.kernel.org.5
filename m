Return-Path: <linux-kernel+bounces-109875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 547898856F0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 10:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B5E3B2232D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29DB55E73;
	Thu, 21 Mar 2024 09:57:06 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489D154BF7;
	Thu, 21 Mar 2024 09:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711015026; cv=none; b=JsLJBDPV0wXBH888BD99ws9jvXlnF240Fph6ZghZYwblX0r1QFbG+hUkD61KSPfxFz45iiuw4XGbO4OPVWglPOu1ksvM1C/tWTZxX9jzTMXpDd4FtpqJ+RGnIc91uqiJh2Eb33jcxZ4611fH9FJDFhnnkAWUi/myYvtcVSR7tyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711015026; c=relaxed/simple;
	bh=8V+u0ZXoS5pUQ8DQfToMJGOVtu0WfVvN6kZ0PQShLJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T+dzwyeCrDpHrKfmYxlSPcxJNdnhg8zYib59H/w7TbBJ2DVf4rgl3qgPAq1jih5sxeW4B+gBokhe5lpGo79Wfut5PhKvlZuCUdQXuVNijFhvwtes9uMpU6YDwgaLqdbp2XWmzQWFjAzXKJdc1g2jZAYgETJdkJbajhs01zWKgf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27CC7C433F1;
	Thu, 21 Mar 2024 09:57:03 +0000 (UTC)
Message-ID: <d741106e-5bff-441a-beb3-5ef1c81d912a@xs4all.nl>
Date: Thu, 21 Mar 2024 10:57:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v1] staging: media: starfive: Renamed capture_raw to
 capture_dump
Content-Language: en-US, nl
To: Changhuang Liang <changhuang.liang@starfivetech.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Jack Zhu <jack.zhu@starfivetech.com>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
References: <20240301070025.11144-1-changhuang.liang@starfivetech.com>
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20240301070025.11144-1-changhuang.liang@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Changhuang,

On 01/03/2024 8:00 am, Changhuang Liang wrote:
> The pixel formats captured by the capture_raw video device depends on
> what pixel formats come from the source device. It is actually dump
> the source device data. So renamed it to capture_dump.

I don't think 'dump' is a great name. I think what you really want to
say is 'unprocessed'. And usually that is indeed called 'raw capture'.

> 
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> ---
>  .../admin-guide/media/starfive_camss.rst      |  2 +-
>  .../media/starfive_camss_graph.dot            |  2 +-
>  .../staging/media/starfive/camss/stf-camss.c  |  6 ++---
>  .../media/starfive/camss/stf-capture.c        | 26 +++++++++----------
>  .../staging/media/starfive/camss/stf-video.h  |  2 +-
>  5 files changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/Documentation/admin-guide/media/starfive_camss.rst b/Documentation/admin-guide/media/starfive_camss.rst
> index ca42e9447c47..c224e6123042 100644
> --- a/Documentation/admin-guide/media/starfive_camss.rst
> +++ b/Documentation/admin-guide/media/starfive_camss.rst
> @@ -60,7 +60,7 @@ The media controller pipeline graph is as follows:
> 
>  The driver has 2 video devices:
> 
> -- capture_raw: The capture device, capturing image data directly from a sensor.
> +- capture_dump: The capture device, capturing image data directly from a sensor.

So perhaps rather than renaming everything, it would be better to explain it
better here:

- capture_raw: The capture device, capturing image data directly from a sensor, bypassing
  the ISP module.

Regards,

	Hans

>  - capture_yuv: The capture device, capturing YUV frame data processed by the
>    ISP module
> 
> diff --git a/Documentation/admin-guide/media/starfive_camss_graph.dot b/Documentation/admin-guide/media/starfive_camss_graph.dot
> index 8eff1f161ac7..5e8731e27701 100644
> --- a/Documentation/admin-guide/media/starfive_camss_graph.dot
> +++ b/Documentation/admin-guide/media/starfive_camss_graph.dot
> @@ -2,7 +2,7 @@ digraph board {
>  	rankdir=TB
>  	n00000001 [label="{{<port0> 0} | stf_isp\n/dev/v4l-subdev0 | {<port1> 1}}", shape=Mrecord, style=filled, fillcolor=green]
>  	n00000001:port1 -> n00000008 [style=dashed]
> -	n00000004 [label="capture_raw\n/dev/video0", shape=box, style=filled, fillcolor=yellow]
> +	n00000004 [label="capture_dump\n/dev/video0", shape=box, style=filled, fillcolor=yellow]
>  	n00000008 [label="capture_yuv\n/dev/video1", shape=box, style=filled, fillcolor=yellow]
>  	n0000000e [label="{{<port0> 0} | cdns_csi2rx.19800000.csi-bridge\n | {<port1> 1 | <port2> 2 | <port3> 3 | <port4> 4}}", shape=Mrecord, style=filled, fillcolor=green]
>  	n0000000e:port1 -> n00000001:port0 [style=dashed]
> diff --git a/drivers/staging/media/starfive/camss/stf-camss.c b/drivers/staging/media/starfive/camss/stf-camss.c
> index a587f860101a..81fc39f20615 100644
> --- a/drivers/staging/media/starfive/camss/stf-camss.c
> +++ b/drivers/staging/media/starfive/camss/stf-camss.c
> @@ -176,7 +176,7 @@ static int stfcamss_subdev_notifier_bound(struct v4l2_async_notifier *async,
>  		container_of(asc, struct stfcamss_async_subdev, asd);
>  	enum stf_port_num port = csd->port;
>  	struct stf_isp_dev *isp_dev = &stfcamss->isp_dev;
> -	struct stf_capture *cap_raw = &stfcamss->captures[STF_CAPTURE_RAW];
> +	struct stf_capture *cap_dump = &stfcamss->captures[STF_CAPTURE_DUMP];
>  	struct media_pad *pad;
>  	int ret;
> 
> @@ -192,12 +192,12 @@ static int stfcamss_subdev_notifier_bound(struct v4l2_async_notifier *async,
>  		return ret;
> 
>  	ret = media_create_pad_link(&subdev->entity, 1,
> -				    &cap_raw->video.vdev.entity, 0, 0);
> +				    &cap_dump->video.vdev.entity, 0, 0);
>  	if (ret)
>  		return ret;
> 
>  	isp_dev->source_subdev = subdev;
> -	cap_raw->video.source_subdev = subdev;
> +	cap_dump->video.source_subdev = subdev;
> 
>  	return 0;
>  }
> diff --git a/drivers/staging/media/starfive/camss/stf-capture.c b/drivers/staging/media/starfive/camss/stf-capture.c
> index ec5169e7b391..5c91126d5132 100644
> --- a/drivers/staging/media/starfive/camss/stf-capture.c
> +++ b/drivers/staging/media/starfive/camss/stf-capture.c
> @@ -10,7 +10,7 @@
>  #include "stf-camss.h"
> 
>  static const char * const stf_cap_names[] = {
> -	"capture_raw",
> +	"capture_dump",
>  	"capture_yuv",
>  };
> 
> @@ -60,7 +60,7 @@ static inline struct stf_capture *to_stf_capture(struct stfcamss_video *video)
>  	return container_of(video, struct stf_capture, video);
>  }
> 
> -static void stf_set_raw_addr(struct stfcamss *stfcamss, dma_addr_t addr)
> +static void stf_set_dump_addr(struct stfcamss *stfcamss, dma_addr_t addr)
>  {
>  	stf_syscon_reg_write(stfcamss, VIN_START_ADDR_O, (long)addr);
>  	stf_syscon_reg_write(stfcamss, VIN_START_ADDR_N, (long)addr);
> @@ -87,8 +87,8 @@ static void stf_init_addrs(struct stfcamss_video *video)
>  	addr0 = output->buf[0]->addr[0];
>  	addr1 = output->buf[0]->addr[1];
> 
> -	if (cap->type == STF_CAPTURE_RAW)
> -		stf_set_raw_addr(video->stfcamss, addr0);
> +	if (cap->type == STF_CAPTURE_DUMP)
> +		stf_set_dump_addr(video->stfcamss, addr0);
>  	else if (cap->type == STF_CAPTURE_YUV)
>  		stf_set_yuv_addr(video->stfcamss, addr0, addr1);
>  }
> @@ -179,7 +179,7 @@ static void stf_channel_set(struct stfcamss_video *video)
>  	struct stfcamss *stfcamss = cap->video.stfcamss;
>  	u32 val;
> 
> -	if (cap->type == STF_CAPTURE_RAW) {
> +	if (cap->type == STF_CAPTURE_DUMP) {
>  		val = stf_syscon_reg_read(stfcamss, VIN_CHANNEL_SEL_EN);
>  		val &= ~U0_VIN_CHANNEL_SEL_MASK;
>  		val |= CHANNEL(0);
> @@ -219,7 +219,7 @@ static void stf_capture_start(struct stfcamss_video *video)
>  	struct stf_capture *cap = to_stf_capture(video);
> 
>  	stf_channel_set(video);
> -	if (cap->type == STF_CAPTURE_RAW) {
> +	if (cap->type == STF_CAPTURE_DUMP) {
>  		stf_wr_irq_enable(video);
>  		stf_wr_data_en(video);
>  	}
> @@ -231,7 +231,7 @@ static void stf_capture_stop(struct stfcamss_video *video)
>  {
>  	struct stf_capture *cap = to_stf_capture(video);
> 
> -	if (cap->type == STF_CAPTURE_RAW)
> +	if (cap->type == STF_CAPTURE_DUMP)
>  		stf_wr_irq_disable(video);
> 
>  	stf_cap_s_cleanup(video);
> @@ -252,7 +252,7 @@ static void stf_capture_init(struct stfcamss *stfcamss, struct stf_capture *cap)
>  	cap->video.stfcamss = stfcamss;
>  	cap->video.bpl_alignment = 16 * 8;
> 
> -	if (cap->type == STF_CAPTURE_RAW) {
> +	if (cap->type == STF_CAPTURE_DUMP) {
>  		cap->video.formats = stf_wr_fmts;
>  		cap->video.nformats = ARRAY_SIZE(stf_wr_fmts);
>  		cap->video.bpl_alignment = 8;
> @@ -437,8 +437,8 @@ static void stf_change_buffer(struct stf_v_buf *output)
>  	if (output->state == STF_OUTPUT_STOPPING) {
>  		output->last_buffer = ready_buf;
>  	} else {
> -		if (cap->type == STF_CAPTURE_RAW)
> -			stf_set_raw_addr(stfcamss, new_addr[0]);
> +		if (cap->type == STF_CAPTURE_DUMP)
> +			stf_set_dump_addr(stfcamss, new_addr[0]);
>  		else if (cap->type == STF_CAPTURE_YUV)
>  			stf_set_yuv_addr(stfcamss, new_addr[0], new_addr[1]);
> 
> @@ -452,7 +452,7 @@ static void stf_change_buffer(struct stf_v_buf *output)
>  irqreturn_t stf_wr_irq_handler(int irq, void *priv)
>  {
>  	struct stfcamss *stfcamss = priv;
> -	struct stf_capture *cap = &stfcamss->captures[STF_CAPTURE_RAW];
> +	struct stf_capture *cap = &stfcamss->captures[STF_CAPTURE_DUMP];
> 
>  	if (atomic_dec_if_positive(&cap->buffers.frame_skip) < 0) {
>  		stf_change_buffer(&cap->buffers);
> @@ -569,10 +569,10 @@ static void stf_capture_unregister_one(struct stf_capture *cap)
> 
>  void stf_capture_unregister(struct stfcamss *stfcamss)
>  {
> -	struct stf_capture *cap_raw = &stfcamss->captures[STF_CAPTURE_RAW];
> +	struct stf_capture *cap_dump = &stfcamss->captures[STF_CAPTURE_DUMP];
>  	struct stf_capture *cap_yuv = &stfcamss->captures[STF_CAPTURE_YUV];
> 
> -	stf_capture_unregister_one(cap_raw);
> +	stf_capture_unregister_one(cap_dump);
>  	stf_capture_unregister_one(cap_yuv);
>  }
> 
> diff --git a/drivers/staging/media/starfive/camss/stf-video.h b/drivers/staging/media/starfive/camss/stf-video.h
> index 8052b77e3ad8..90c73c0dee89 100644
> --- a/drivers/staging/media/starfive/camss/stf-video.h
> +++ b/drivers/staging/media/starfive/camss/stf-video.h
> @@ -35,7 +35,7 @@ enum stf_v_line_id {
>  };
> 
>  enum stf_capture_type {
> -	STF_CAPTURE_RAW = 0,
> +	STF_CAPTURE_DUMP = 0,
>  	STF_CAPTURE_YUV,
>  	STF_CAPTURE_NUM,
>  };
> --
> 2.25.1
> 


