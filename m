Return-Path: <linux-kernel+bounces-26274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 834E182DDE4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 17:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD464B21A7F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15C817C66;
	Mon, 15 Jan 2024 16:50:12 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E29417BBB;
	Mon, 15 Jan 2024 16:50:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD4FCC433C7;
	Mon, 15 Jan 2024 16:50:10 +0000 (UTC)
Message-ID: <6b0e4c6b-493c-4916-ab3c-deeeb725fdec@xs4all.nl>
Date: Mon, 15 Jan 2024 17:50:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 7/8] media: v4l2: Add mem2mem helpers for DELETE_BUFS
 ioctl
Content-Language: en-US, nl
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>, mchehab@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 kernel@collabora.com
References: <20231215090813.15610-1-benjamin.gaignard@collabora.com>
 <20231215090813.15610-8-benjamin.gaignard@collabora.com>
From: Hans Verkuil <hverkuil@xs4all.nl>
Autocrypt: addr=hverkuil@xs4all.nl; keydata=
 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
In-Reply-To: <20231215090813.15610-8-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/12/2023 10:08, Benjamin Gaignard wrote:
> Create v4l2-mem2mem helpers for VIDIOC_DELETE_BUFS ioctl.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>  .../media/platform/verisilicon/hantro_drv.c   |  1 +
>  .../media/platform/verisilicon/hantro_v4l2.c  |  1 +
>  drivers/media/test-drivers/vim2m.c            |  2 ++

The driver changes should be done in a separate patch.

>  drivers/media/v4l2-core/v4l2-mem2mem.c        | 20 +++++++++++++++++++
>  include/media/v4l2-mem2mem.h                  | 12 +++++++++++
>  5 files changed, 36 insertions(+)
> 
> diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
> index db3df6cc4513..f6b0a676a740 100644
> --- a/drivers/media/platform/verisilicon/hantro_drv.c
> +++ b/drivers/media/platform/verisilicon/hantro_drv.c
> @@ -248,6 +248,7 @@ queue_init(void *priv, struct vb2_queue *src_vq, struct vb2_queue *dst_vq)
>  	dst_vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY;
>  	dst_vq->lock = &ctx->dev->vpu_mutex;
>  	dst_vq->dev = ctx->dev->v4l2_dev.dev;
> +	src_vq->supports_delete_bufs = true;

Isn't this something that can be supported for both queues?

>  
>  	return vb2_queue_init(dst_vq);
>  }
> diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/media/platform/verisilicon/hantro_v4l2.c
> index 941fa23c211a..34eab90e8a42 100644
> --- a/drivers/media/platform/verisilicon/hantro_v4l2.c
> +++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
> @@ -756,6 +756,7 @@ const struct v4l2_ioctl_ops hantro_ioctl_ops = {
>  	.vidioc_dqbuf = v4l2_m2m_ioctl_dqbuf,
>  	.vidioc_prepare_buf = v4l2_m2m_ioctl_prepare_buf,
>  	.vidioc_create_bufs = v4l2_m2m_ioctl_create_bufs,
> +	.vidioc_delete_bufs = v4l2_m2m_ioctl_delete_bufs,
>  	.vidioc_expbuf = v4l2_m2m_ioctl_expbuf,
>  
>  	.vidioc_subscribe_event = v4l2_ctrl_subscribe_event,
> diff --git a/drivers/media/test-drivers/vim2m.c b/drivers/media/test-drivers/vim2m.c
> index 3e3b424b4860..17213ce42059 100644
> --- a/drivers/media/test-drivers/vim2m.c
> +++ b/drivers/media/test-drivers/vim2m.c
> @@ -960,6 +960,7 @@ static const struct v4l2_ioctl_ops vim2m_ioctl_ops = {
>  	.vidioc_dqbuf		= v4l2_m2m_ioctl_dqbuf,
>  	.vidioc_prepare_buf	= v4l2_m2m_ioctl_prepare_buf,
>  	.vidioc_create_bufs	= v4l2_m2m_ioctl_create_bufs,
> +	.vidioc_delete_bufs	= v4l2_m2m_ioctl_delete_bufs,
>  	.vidioc_expbuf		= v4l2_m2m_ioctl_expbuf,
>  
>  	.vidioc_streamon	= v4l2_m2m_ioctl_streamon,
> @@ -1133,6 +1134,7 @@ static int queue_init(void *priv, struct vb2_queue *src_vq,
>  	dst_vq->mem_ops = &vb2_vmalloc_memops;
>  	dst_vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY;
>  	dst_vq->lock = &ctx->vb_mutex;
> +	dst_vq->supports_delete_bufs = true;

Same question.

>  
>  	return vb2_queue_init(dst_vq);
>  }
> diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l2-core/v4l2-mem2mem.c
> index 9e983176542b..dbc4711fc556 100644
> --- a/drivers/media/v4l2-core/v4l2-mem2mem.c
> +++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
> @@ -834,6 +834,17 @@ int v4l2_m2m_prepare_buf(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
>  }
>  EXPORT_SYMBOL_GPL(v4l2_m2m_prepare_buf);
>  
> +int v4l2_m2m_delete_bufs(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
> +			 struct v4l2_delete_buffers *d)
> +{
> +	struct vb2_queue *vq;
> +
> +	vq = v4l2_m2m_get_vq(m2m_ctx, d->type);

These 3 lines can be combined into one.

> +
> +	return vb2_delete_bufs(vq, d);
> +}
> +EXPORT_SYMBOL_GPL(v4l2_m2m_delete_bufs);

I'm not sure we need to export this. Drivers should really just use the
v4l2_m2m_ioctl_ variant below.

> +
>  int v4l2_m2m_create_bufs(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
>  			 struct v4l2_create_buffers *create)
>  {
> @@ -1380,6 +1391,15 @@ int v4l2_m2m_ioctl_create_bufs(struct file *file, void *priv,
>  }
>  EXPORT_SYMBOL_GPL(v4l2_m2m_ioctl_create_bufs);
>  
> +int v4l2_m2m_ioctl_delete_bufs(struct file *file, void *priv,
> +			       struct v4l2_delete_buffers *d)
> +{
> +	struct v4l2_fh *fh = file->private_data;
> +
> +	return v4l2_m2m_delete_bufs(file, fh->m2m_ctx, d);
> +}
> +EXPORT_SYMBOL_GPL(v4l2_m2m_ioctl_delete_bufs);
> +
>  int v4l2_m2m_ioctl_querybuf(struct file *file, void *priv,
>  				struct v4l2_buffer *buf)
>  {
> diff --git a/include/media/v4l2-mem2mem.h b/include/media/v4l2-mem2mem.h
> index 7f1af1f7f912..5314952ad3d5 100644
> --- a/include/media/v4l2-mem2mem.h
> +++ b/include/media/v4l2-mem2mem.h
> @@ -388,6 +388,16 @@ int v4l2_m2m_dqbuf(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
>  int v4l2_m2m_prepare_buf(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
>  			 struct v4l2_buffer *buf);
>  
> +/**
> + * v4l2_m2m_delete_bufs() - delete buffers from the queue
> + *
> + * @file: pointer to struct &file
> + * @m2m_ctx: m2m context assigned to the instance given by struct &v4l2_m2m_ctx
> + * @d: pointer to struct &v4l2_delete_buffers
> + */
> +int v4l2_m2m_delete_bufs(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
> +			 struct v4l2_delete_buffers *d);
> +
>  /**
>   * v4l2_m2m_create_bufs() - create a source or destination buffer, depending
>   * on the type
> @@ -867,6 +877,8 @@ int v4l2_m2m_ioctl_reqbufs(struct file *file, void *priv,
>  				struct v4l2_requestbuffers *rb);
>  int v4l2_m2m_ioctl_create_bufs(struct file *file, void *fh,
>  				struct v4l2_create_buffers *create);
> +int v4l2_m2m_ioctl_delete_bufs(struct file *file, void *priv,
> +			       struct v4l2_delete_buffers *d);
>  int v4l2_m2m_ioctl_querybuf(struct file *file, void *fh,
>  				struct v4l2_buffer *buf);
>  int v4l2_m2m_ioctl_expbuf(struct file *file, void *fh,

Regards,

	Hans

