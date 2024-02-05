Return-Path: <linux-kernel+bounces-52822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A4E849D0D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 851D01C248E8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CC12C1A3;
	Mon,  5 Feb 2024 14:28:21 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B4D2C183;
	Mon,  5 Feb 2024 14:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707143300; cv=none; b=CEBcswOUYawP79kTRo7hZxhb6Wro9Y3991K5EB+QmktfIzppw9gEakHDie/NA8HAbwTpB1nJeUyrF/7n2txkmazDCFzYuubyvC2LTS/3j02FAmP8eS7e8TX8fuU3E/4fCLfNI/ISvoYFZs334bnpviEzxIqNh8jwZFb2eLs7jPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707143300; c=relaxed/simple;
	bh=vVn5to0qBCqDZdmR9TIm7gUCg/zmiTRpqN5I4fXA9sQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dNHuIwXhsk5nGk3qnSfP+FEkdtsSReNrdCqpAqjVQx0my4bwSyVfCwi1QVbONyqhtgFgcIQ6G3UaiqmhSaxj7l4Wooc14LmJbK/Eaou1AefCN0KnW6yeatzGvDy0IWj4IM299uFlFe2XuXmBGh4EnYxsoGwED6PXHHiaXgoqxf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 433F7C433F1;
	Mon,  5 Feb 2024 14:28:19 +0000 (UTC)
Message-ID: <3b921ffd-d9a7-4f60-aeff-b7c865be9e89@xs4all.nl>
Date: Mon, 5 Feb 2024 15:28:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 7/9] media: v4l2: Add DELETE_BUFS ioctl
Content-Language: en-US, nl
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>, mchehab@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 kernel@collabora.com
References: <20240126110141.135896-1-benjamin.gaignard@collabora.com>
 <20240126110141.135896-8-benjamin.gaignard@collabora.com>
From: Hans Verkuil <hverkuil@xs4all.nl>
Autocrypt: addr=hverkuil@xs4all.nl; keydata=
 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
In-Reply-To: <20240126110141.135896-8-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/01/2024 12:01, Benjamin Gaignard wrote:
> VIDIOC_DELETE_BUFS ioctl allows to delete buffers from a queue.
> The number of buffers to delete in given by count field of
> struct v4l2_delete_buffers and the range start at the index
> specified in the same structure.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
> version 18:
> - remove per queue capability flag.
> - rework v4l_delete_bufs() to check if VIDIOC_CREATE_BUFS is enabled
>   and if vidioc_delete_bufs pointer is valid.
> - update documentation.
> 
>  .../userspace-api/media/v4l/user-func.rst     |  1 +
>  .../media/v4l/vidioc-delete-bufs.rst          | 78 +++++++++++++++++++
>  .../media/common/videobuf2/videobuf2-core.c   | 38 +++++++++
>  .../media/common/videobuf2/videobuf2-v4l2.c   | 12 +++
>  drivers/media/v4l2-core/v4l2-dev.c            |  1 +
>  drivers/media/v4l2-core/v4l2-ioctl.c          | 28 +++++++
>  include/media/v4l2-ioctl.h                    |  4 +
>  include/media/videobuf2-core.h                | 10 +++
>  include/media/videobuf2-v4l2.h                |  2 +
>  include/uapi/linux/videodev2.h                | 16 ++++
>  10 files changed, 190 insertions(+)
>  create mode 100644 Documentation/userspace-api/media/v4l/vidioc-delete-bufs.rst
> 
> diff --git a/Documentation/userspace-api/media/v4l/user-func.rst b/Documentation/userspace-api/media/v4l/user-func.rst
> index 15ff0bf7bbe6..3fd567695477 100644
> --- a/Documentation/userspace-api/media/v4l/user-func.rst
> +++ b/Documentation/userspace-api/media/v4l/user-func.rst
> @@ -17,6 +17,7 @@ Function Reference
>      vidioc-dbg-g-chip-info
>      vidioc-dbg-g-register
>      vidioc-decoder-cmd
> +    vidioc-delete-bufs
>      vidioc-dqevent
>      vidioc-dv-timings-cap
>      vidioc-encoder-cmd
> diff --git a/Documentation/userspace-api/media/v4l/vidioc-delete-bufs.rst b/Documentation/userspace-api/media/v4l/vidioc-delete-bufs.rst
> new file mode 100644
> index 000000000000..eb235d1750c8
> --- /dev/null
> +++ b/Documentation/userspace-api/media/v4l/vidioc-delete-bufs.rst
> @@ -0,0 +1,78 @@
> +.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
> +.. c:namespace:: V4L
> +
> +.. _VIDIOC_DELETE_BUFS:
> +
> +************************
> +ioctl VIDIOC_DELETE_BUFS
> +************************
> +
> +Name
> +====
> +
> +VIDIOC_DELETE_BUFS - Deletes buffers from a queue
> +
> +Synopsis
> +========
> +
> +.. c:macro:: VIDIOC_DELETE_BUFs

VIDIOC_DELETE_BUFs -> VIDIOC_DELETE_BUFS

> +
> +``int ioctl(int fd, VIDIOC_DELETE_BUFs, struct v4l2_delete_buffers *argp)``

Ditto.

> +
> +Arguments
> +=========
> +
> +``fd``
> +    File descriptor returned by :c:func:`open()`.
> +
> +``argp``
> +    Pointer to struct :c:type:`v4l2_delete_buffers`.
> +
> +Description
> +===========
> +
> +Applications can optionally call the :ref:`VIDIOC_DELETE_BUFS` ioctl to
> +delete buffers from a queue.
> +:ref:`VIDIOC_CREATE_BUFS` ioctl support is mandatory to enable :ref:`VIDIOC_DELETE_BUFS`.
> +
> +.. c:type:: v4l2_delete_buffers
> +
> +.. tabularcolumns:: |p{4.4cm}|p{4.4cm}|p{8.5cm}|
> +
> +.. flat-table:: struct v4l2_delete_buffers
> +    :header-rows:  0
> +    :stub-columns: 0
> +    :widths:       1 1 2
> +
> +    * - __u32
> +      - ``index``
> +      - The starting buffer index to delete.
> +    * - __u32
> +      - ``count``
> +      - The number of buffers to be deleted with indices 'index' until 'index + count - 1'.
> +        All buffers in this range must be valid and in DEQUEUED state.
> +        If count is set to 0 :ref:`VIDIOC_DELETE_BUFS` will do nothing and return 0.
> +    * - __u32
> +      - ``type``
> +      - Type of the stream or buffers, this is the same as the struct
> +	:c:type:`v4l2_format` ``type`` field. See
> +	:c:type:`v4l2_buf_type` for valid values.
> +    * - __u32
> +      - ``reserved``\ [13]
> +      - A place holder for future extensions. Drivers and applications
> +	must set the array to zero.
> +
> +Return Value
> +============
> +
> +On success 0 is returned, on error -1 and the ``errno`` variable is set
> +appropriately. The generic error codes are described at the
> +:ref:`Generic Error Codes <gen-errors>` chapter.
> +
> +EBUSY
> +    File I/O is in progress.
> +    Any buffer in range ``index`` to ``index + count - 1`` is not in

Any buffer in range -> One or more of the buffers in the range
is -> are

> +    DEQUEUED state.
> +
> +EINVAL
> +    Any buffer in range ``index`` to ``index + count - 1`` doesn't exist in the queue.

Any buffer in range -> One or more of the buffers in the range
doesn't exist in the queue -> do not exist

> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
> index 8486a2f2c09d..6ca0e949dc27 100644
> --- a/drivers/media/common/videobuf2/videobuf2-core.c
> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> @@ -1692,6 +1692,44 @@ int vb2_core_prepare_buf(struct vb2_queue *q, struct vb2_buffer *vb, void *pb)
>  }
>  EXPORT_SYMBOL_GPL(vb2_core_prepare_buf);
>  
> +int vb2_core_delete_bufs(struct vb2_queue *q, unsigned int start, unsigned int count)
> +{
> +	unsigned int i, ret = 0;
> +	unsigned int q_num_bufs = vb2_get_num_buffers(q);
> +
> +	if (count == 0)
> +		return 0;
> +
> +	if (count > q_num_bufs)
> +		return -EINVAL;
> +
> +	if (start > q->max_num_buffers - count)
> +		return -EINVAL;
> +
> +	mutex_lock(&q->mmap_lock);
> +
> +	/* Check that all buffers in the range exist */
> +	for (i = start; i < start + count; i++) {
> +		struct vb2_buffer *vb = vb2_get_buffer(q, i);
> +
> +		if (!vb) {
> +			ret = -EINVAL;
> +			goto unlock;
> +		}
> +		if (vb->state != VB2_BUF_STATE_DEQUEUED) {
> +			ret = -EBUSY;
> +			goto unlock;
> +		}
> +	}
> +	__vb2_queue_free(q, start, count);
> +	dprintk(q, 2, "%u buffers deleted\n", count);
> +
> +unlock:
> +	mutex_unlock(&q->mmap_lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(vb2_core_delete_bufs);
> +
>  /*
>   * vb2_start_streaming() - Attempt to start streaming.
>   * @q:		videobuf2 queue
> diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
> index 03e8080a68a8..8e437104f9c1 100644
> --- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
> +++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
> @@ -1001,6 +1001,18 @@ EXPORT_SYMBOL_GPL(vb2_poll);
>  
>  /* vb2 ioctl helpers */
>  
> +int vb2_ioctl_delete_bufs(struct file *file, void *priv,
> +			  struct v4l2_delete_buffers *d)
> +{
> +	struct video_device *vdev = video_devdata(file);
> +
> +	if (vb2_queue_is_busy(vdev->queue, file))
> +		return -EBUSY;
> +
> +	return vb2_core_delete_bufs(vdev->queue, d->index, d->count);
> +}
> +EXPORT_SYMBOL_GPL(vb2_ioctl_delete_bufs);
> +
>  int vb2_ioctl_reqbufs(struct file *file, void *priv,
>  			  struct v4l2_requestbuffers *p)
>  {
> diff --git a/drivers/media/v4l2-core/v4l2-dev.c b/drivers/media/v4l2-core/v4l2-dev.c
> index d13954bd31fd..e764af2e29ff 100644
> --- a/drivers/media/v4l2-core/v4l2-dev.c
> +++ b/drivers/media/v4l2-core/v4l2-dev.c
> @@ -722,6 +722,7 @@ static void determine_valid_ioctls(struct video_device *vdev)
>  		SET_VALID_IOCTL(ops, VIDIOC_PREPARE_BUF, vidioc_prepare_buf);
>  		SET_VALID_IOCTL(ops, VIDIOC_STREAMON, vidioc_streamon);
>  		SET_VALID_IOCTL(ops, VIDIOC_STREAMOFF, vidioc_streamoff);
> +		SET_VALID_IOCTL(ops, VIDIOC_DELETE_BUFS, vidioc_delete_bufs);

I think this is a much better place to disable DELETE_BUFS if CREATE_BUFS
is missing. Just check for the presence of create_bufs before enabling
delete_bufs.

>  	}
>  
>  	if (is_vid || is_vbi || is_meta) {
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
> index 33076af4dfdb..2162de908afa 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -489,6 +489,14 @@ static void v4l_print_create_buffers(const void *arg, bool write_only)
>  	v4l_print_format(&p->format, write_only);
>  }
>  
> +static void v4l_print_delete_buffers(const void *arg, bool write_only)
> +{
> +	const struct v4l2_delete_buffers *p = arg;
> +
> +	pr_cont("type=%s, index=%u, count=%u\n",
> +		prt_names(p->type, v4l2_type_names), p->index, p->count);
> +}
> +
>  static void v4l_print_streamparm(const void *arg, bool write_only)
>  {
>  	const struct v4l2_streamparm *p = arg;
> @@ -2161,6 +2169,25 @@ static int v4l_prepare_buf(const struct v4l2_ioctl_ops *ops,
>  	return ret ? ret : ops->vidioc_prepare_buf(file, fh, b);
>  }
>  
> +static int v4l_delete_bufs(const struct v4l2_ioctl_ops *ops,
> +			   struct file *file, void *fh, void *arg)
> +{
> +	struct v4l2_delete_buffers *delete = arg;
> +	int ret = check_fmt(file, delete->type);
> +
> +	if (ret)
> +		return ret;
> +
> +	/* VIDIOC_CREATE_BUFS support is mandatory */
> +	if (!ops->vidioc_create_bufs)
> +		return -ENOTTY;
> +

Then this check can be dropped.

> +	if (ops->vidioc_delete_bufs)
> +		return ops->vidioc_delete_bufs(file, fh, delete);
> +
> +	return -ENOTTY;
> +}
> +
>  static int v4l_g_parm(const struct v4l2_ioctl_ops *ops,
>  				struct file *file, void *fh, void *arg)
>  {
> @@ -2910,6 +2937,7 @@ static const struct v4l2_ioctl_info v4l2_ioctls[] = {
>  	IOCTL_INFO(VIDIOC_ENUM_FREQ_BANDS, v4l_enum_freq_bands, v4l_print_freq_band, 0),
>  	IOCTL_INFO(VIDIOC_DBG_G_CHIP_INFO, v4l_dbg_g_chip_info, v4l_print_dbg_chip_info, INFO_FL_CLEAR(v4l2_dbg_chip_info, match)),
>  	IOCTL_INFO(VIDIOC_QUERY_EXT_CTRL, v4l_query_ext_ctrl, v4l_print_query_ext_ctrl, INFO_FL_CTRL | INFO_FL_CLEAR(v4l2_query_ext_ctrl, id)),
> +	IOCTL_INFO(VIDIOC_DELETE_BUFS, v4l_delete_bufs, v4l_print_delete_buffers, INFO_FL_PRIO | INFO_FL_QUEUE | INFO_FL_CLEAR(v4l2_delete_buffers, type)),
>  };
>  #define V4L2_IOCTLS ARRAY_SIZE(v4l2_ioctls)
>  
> diff --git a/include/media/v4l2-ioctl.h b/include/media/v4l2-ioctl.h
> index edb733f21604..55afbde54211 100644
> --- a/include/media/v4l2-ioctl.h
> +++ b/include/media/v4l2-ioctl.h
> @@ -163,6 +163,8 @@ struct v4l2_fh;
>   *	:ref:`VIDIOC_CREATE_BUFS <vidioc_create_bufs>` ioctl
>   * @vidioc_prepare_buf: pointer to the function that implements
>   *	:ref:`VIDIOC_PREPARE_BUF <vidioc_prepare_buf>` ioctl
> + * @vidioc_delete_bufs: pointer to the function that implements
> + *	:ref:`VIDIOC_DELETE_BUFS <vidioc_delete_bufs>` ioctl
>   * @vidioc_overlay: pointer to the function that implements
>   *	:ref:`VIDIOC_OVERLAY <vidioc_overlay>` ioctl
>   * @vidioc_g_fbuf: pointer to the function that implements
> @@ -422,6 +424,8 @@ struct v4l2_ioctl_ops {
>  				  struct v4l2_create_buffers *b);
>  	int (*vidioc_prepare_buf)(struct file *file, void *fh,
>  				  struct v4l2_buffer *b);
> +	int (*vidioc_delete_bufs)(struct file *file, void *fh,
> +				  struct v4l2_delete_buffers *d);
>  
>  	int (*vidioc_overlay)(struct file *file, void *fh, unsigned int i);
>  	int (*vidioc_g_fbuf)(struct file *file, void *fh,
> diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
> index 88e35a3b7730..0d17e5605c09 100644
> --- a/include/media/videobuf2-core.h
> +++ b/include/media/videobuf2-core.h
> @@ -867,6 +867,16 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
>   */
>  int vb2_core_prepare_buf(struct vb2_queue *q, struct vb2_buffer *vb, void *pb);
>  
> +/**
> + * vb2_core_delete_bufs() -
> + * @q:		pointer to &struct vb2_queue with videobuf2 queue.
> + * @start:	first index of the range of buffers to delete.
> + * @count:	number of buffers to delete.
> + *
> + *  Return: returns zero on success; an error code otherwise.
> + */
> +int vb2_core_delete_bufs(struct vb2_queue *q, unsigned int start, unsigned int count);
> +
>  /**
>   * vb2_core_qbuf() - Queue a buffer from userspace
>   *
> diff --git a/include/media/videobuf2-v4l2.h b/include/media/videobuf2-v4l2.h
> index 5a845887850b..ddc08623606c 100644
> --- a/include/media/videobuf2-v4l2.h
> +++ b/include/media/videobuf2-v4l2.h
> @@ -334,6 +334,8 @@ int vb2_ioctl_streamon(struct file *file, void *priv, enum v4l2_buf_type i);
>  int vb2_ioctl_streamoff(struct file *file, void *priv, enum v4l2_buf_type i);
>  int vb2_ioctl_expbuf(struct file *file, void *priv,
>  	struct v4l2_exportbuffer *p);
> +int vb2_ioctl_delete_bufs(struct file *file, void *priv,
> +			  struct v4l2_delete_buffers *p);
>  
>  /* struct v4l2_file_operations helpers */
>  
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> index 68e7ac178cc2..47fdd17babbb 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -2624,6 +2624,20 @@ struct v4l2_create_buffers {
>  	__u32			reserved[5];
>  };
>  
> +/**
> + * struct v4l2_delete_buffers - VIDIOC_DELETE_BUFS argument
> + * @index:	the first buffer to be deleted
> + * @count:	number of buffers to delete
> + * @type:	enum v4l2_buf_type
> + * @reserved:	future extensions
> + */
> +struct v4l2_delete_buffers {
> +	__u32			index;
> +	__u32			count;
> +	__u32			type;
> +	__u32			reserved[13];
> +};
> +
>  /*
>   *	I O C T L   C O D E S   F O R   V I D E O   D E V I C E S
>   *
> @@ -2723,6 +2737,8 @@ struct v4l2_create_buffers {
>  #define VIDIOC_DBG_G_CHIP_INFO  _IOWR('V', 102, struct v4l2_dbg_chip_info)
>  
>  #define VIDIOC_QUERY_EXT_CTRL	_IOWR('V', 103, struct v4l2_query_ext_ctrl)
> +#define VIDIOC_DELETE_BUFS	_IOWR('V', 104, struct v4l2_delete_buffers)
> +
>  
>  /* Reminder: when adding new ioctls please add support for them to
>     drivers/media/v4l2-core/v4l2-compat-ioctl32.c as well! */

Regards,

	Hans

