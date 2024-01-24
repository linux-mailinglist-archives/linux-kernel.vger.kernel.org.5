Return-Path: <linux-kernel+bounces-36868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD0283A7E1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A5D1B21220
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AE21B27D;
	Wed, 24 Jan 2024 11:31:30 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61BD1B274;
	Wed, 24 Jan 2024 11:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706095889; cv=none; b=gddQEXbwT4iw7+KwpF6ql1DQVMLVMAuTxTaIYN2Q1CLeZvlZxQs2fePMyDpegZJ91eTX1+DzgK73agl6iVWKIfvMZVPnXZR+1lQeUFktI9byLHg6MOY1KPuBjqgMx2zXRcuyCT5oBRw7WySZ5WSHd5+NRw7xVPTm7XoFmDU1pXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706095889; c=relaxed/simple;
	bh=YM+pwVYzlyAQYJ3JpZPE2nv1mlIQqlIEfzNo0unMESg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=teYb92aMCyEyOu4WWVKQ2CXGOIrU7z9TUDuhZ6cYFRPdf3qMAcuskthxTpJj+RFg0LRG9K45f3CILBVg5kK7jV680TSRaR3WKFjjCMw6h9fkG+3e2J1+A6bcKOkDhhCR7a64zb3Q9GyGqmOsm8kJZeZW/oDOQZ2lmeJYiO0B348=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32BF5C433C7;
	Wed, 24 Jan 2024 11:31:28 +0000 (UTC)
Message-ID: <fd48f1ea-edf0-4ba4-9dc7-357fbcc79c15@xs4all.nl>
Date: Wed, 24 Jan 2024 12:31:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 1/8] videobuf2: Add min_reqbufs_allocation field to
 vb2_queue structure
Content-Language: en-US, nl
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>, mchehab@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 kernel@collabora.com
References: <20240119094944.26763-1-benjamin.gaignard@collabora.com>
 <20240119094944.26763-2-benjamin.gaignard@collabora.com>
From: Hans Verkuil <hverkuil@xs4all.nl>
Autocrypt: addr=hverkuil@xs4all.nl; keydata=
 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
In-Reply-To: <20240119094944.26763-2-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The language needs tightening up a bit:

On 19/01/2024 10:49, Benjamin Gaignard wrote:
> Add 'min_reqbufs_allocation' field in vb2_queue structure so drivers

in -> in the

> can specificy the minimum number of buffers to allocate when calling

specificy -> specify

> VIDIOC_REQBUFS.
> When initializing the queue, v4l2 core makes sure that the following
> constraint are respected:

constraint -> constraints

> - minimum number of buffers to allocate should be at least 2 because

minimum -> the minimum
should -> must

> one buffer is used by the hardware and other processed by userspace.

and other -> while the other is being

> - if a minimum number of buffers before start streaming is specify
> the minimum number of buffers to allocate should be min_queued_buffers
> + 1 to keep one buffer available for userspace.

Replace this with:

- if the driver needs 'min_queued_buffers' in the queue before calling
start_streaming(), then the minimum requirement is 'min_queued_buffers + 1'
to keep at least one buffer available for userspace.

> 
> Simplify __vb2_init_fileio() by using 'min_reqbufs_allocation' directly
> to avoid duplicating the minimum number of buffers to allocate computation.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
> version 17:
> - rewrite commit message.
> - simplify __vb2_init_fileio() code.
> - rewrite documentation
> 
>  .../media/common/videobuf2/videobuf2-core.c   | 37 +++++++++++--------
>  include/media/videobuf2-core.h                | 15 +++++++-
>  2 files changed, 36 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
> index b6bf8f232f48..d74e93d00f58 100644
> --- a/drivers/media/common/videobuf2/videobuf2-core.c
> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> @@ -865,7 +865,7 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
>  	/*
>  	 * Make sure the requested values and current defaults are sane.
>  	 */
> -	num_buffers = max_t(unsigned int, *count, q->min_queued_buffers);
> +	num_buffers = max_t(unsigned int, *count, q->min_reqbufs_allocation);
>  	num_buffers = min_t(unsigned int, num_buffers, q->max_num_buffers);
>  	memset(q->alloc_devs, 0, sizeof(q->alloc_devs));
>  	/*
> @@ -917,7 +917,7 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
>  	 * There is no point in continuing if we can't allocate the minimum
>  	 * number of buffers needed by this vb2_queue.
>  	 */
> -	if (allocated_buffers < q->min_queued_buffers)
> +	if (allocated_buffers < q->min_reqbufs_allocation)
>  		ret = -ENOMEM;
>  
>  	/*
> @@ -2521,6 +2521,24 @@ int vb2_core_queue_init(struct vb2_queue *q)
>  	if (WARN_ON(q->supports_requests && q->min_queued_buffers))
>  		return -EINVAL;
>  
> +	/*
> +	 * The minimum requirement should really be 2: one buffer is used

should really be -> is

> +	 * by the hardware and one other processed by userspace.

and one other -> while the other is being

> +	 */
> +	if (q->min_reqbufs_allocation < 2)
> +		q->min_reqbufs_allocation = 2;
> +
> +	/*
> +	 * If the driver needs 'min_queued_buffers' before start streaming

before -> in the queue before calling
start streaming -> calling start_streaming(),

> +	 * then the minimum requirement is min_queued_buffers + 1 to keep

Add quotes around 'min_queued_buffers + 1'

> +	 * at least one buffer available for userspace
> +	 */
> +	if (q->min_reqbufs_allocation < q->min_queued_buffers + 1)
> +		q->min_reqbufs_allocation = q->min_queued_buffers + 1;
> +
> +	if (WARN_ON(q->min_reqbufs_allocation > q->max_num_buffers))
> +		return -EINVAL;
> +
>  	INIT_LIST_HEAD(&q->queued_list);
>  	INIT_LIST_HEAD(&q->done_list);
>  	spin_lock_init(&q->done_lock);
> @@ -2713,7 +2731,6 @@ static int __vb2_init_fileio(struct vb2_queue *q, int read)
>  	struct vb2_fileio_data *fileio;
>  	struct vb2_buffer *vb;
>  	int i, ret;
> -	unsigned int count = 0;
>  
>  	/*
>  	 * Sanity check
> @@ -2734,18 +2751,8 @@ static int __vb2_init_fileio(struct vb2_queue *q, int read)
>  	if (q->streaming || vb2_get_num_buffers(q) > 0)
>  		return -EBUSY;
>  
> -	/*
> -	 * Start with q->min_queued_buffers + 1, driver can increase it in
> -	 * queue_setup()
> -	 *
> -	 * 'min_queued_buffers' buffers need to be queued up before you
> -	 * can start streaming, plus 1 for userspace (or in this case,
> -	 * kernelspace) processing.
> -	 */
> -	count = max(2, q->min_queued_buffers + 1);
> -
>  	dprintk(q, 3, "setting up file io: mode %s, count %d, read_once %d, write_immediately %d\n",
> -		(read) ? "read" : "write", count, q->fileio_read_once,
> +		(read) ? "read" : "write", q->min_reqbufs_allocation, q->fileio_read_once,
>  		q->fileio_write_immediately);
>  
>  	fileio = kzalloc(sizeof(*fileio), GFP_KERNEL);
> @@ -2759,7 +2766,7 @@ static int __vb2_init_fileio(struct vb2_queue *q, int read)
>  	 * Request buffers and use MMAP type to force driver
>  	 * to allocate buffers by itself.
>  	 */
> -	fileio->count = count;
> +	fileio->count = q->min_reqbufs_allocation;
>  	fileio->memory = VB2_MEMORY_MMAP;
>  	fileio->type = q->type;
>  	q->fileio = fileio;
> diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
> index 56719a26a46c..fe3423ff3807 100644
> --- a/include/media/videobuf2-core.h
> +++ b/include/media/videobuf2-core.h
> @@ -550,9 +550,21 @@ struct vb2_buf_ops {
>   *		@start_streaming can be called. Used when a DMA engine
>   *		cannot be started unless at least this number of buffers
>   *		have been queued into the driver.
> - *		VIDIOC_REQBUFS will ensure at least @min_queued_buffers
> + *		VIDIOC_REQBUFS will ensure at least @min_queued_buffers + 1
>   *		buffers will be allocated. Note that VIDIOC_CREATE_BUFS will not
>   *		modify the requested buffer count.
> + * @min_reqbufs_allocation: the minimum number of buffers to be allocated when
> + *		calling VIDIOC_REQBUFS. Note that VIDIOC_CREATE_BUFS will *not*
> + *		modify the requested buffer count and does not use this field.
> + *		Drivers can set this if there has to be a certain number of
> + *		buffers available for the hardware to work effectively.
> + *		This allows calling VIDIOC_REQBUFS with a buffer count of 1 and
> + *		it will be automatically adjusted to a workable	buffer count.
> + *		If set, then @min_reqbufs_allocation must be larger than
> + *		@min_queued_buffers + 1.
> + *		If this field is > 3, then it is highly recommended that the
> + *		driver implements the V4L2_CID_MIN_BUFFERS_FOR_CAPTURE/OUTPUT
> + *		control.
>   */
>  /*
>   * Private elements (won't appear at the uAPI book):
> @@ -618,6 +630,7 @@ struct vb2_queue {
>  	u32				timestamp_flags;
>  	gfp_t				gfp_flags;
>  	u32				min_queued_buffers;
> +	u32				min_reqbufs_allocation;
>  
>  	struct device			*alloc_devs[VB2_MAX_PLANES];
>  


