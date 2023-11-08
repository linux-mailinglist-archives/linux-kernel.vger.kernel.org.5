Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331427E5342
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 11:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344068AbjKHKYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 05:24:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235217AbjKHKYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 05:24:51 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9A11BD5
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 02:24:49 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6ce2cf67be2so4029552a34.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 02:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699439088; x=1700043888; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dSHpWDlAyfJyOGsIApYR9Ror/UYeRgH6DP/oCc5ghJA=;
        b=BKMspyipgJKmLoER2rKfLHudRcuAxqHGUF/smrf7LZ2KyV+h20O0S424sZzcBIFJHV
         Jpct3u636qWvb4L81m+xSidS6nXiarbyQYmaRNXdNqbdn6jdQ4nd7Ry2NBKbUDENspFg
         qQ4g+8nmPPRCNL0pu/pYmZu3lFeCEe8yKEOF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699439088; x=1700043888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dSHpWDlAyfJyOGsIApYR9Ror/UYeRgH6DP/oCc5ghJA=;
        b=tex4rdhqdvXt5NJdY6fJxNeNsCf0RuNzf0kk94OTyjHUHhupM2lNHg1XbwmRlxsxHI
         ImHNNdWfB+/R/td24wo2j7NcwX1SXqdVb7HLP6cxVzfq1+ODgO4SGRztAOf/VLUVJx8l
         tMNRndd+s+6jUgxiKRjSpXDr1DqZrtfxsmeUm5kkajych6mzj7YKmMtH6K+Gs3zP/e3i
         1h8pZQ2oiXedry6ACPmKK9zTo8g9O7XQ0kF4rKD1YIhpaIyhe0eisorvJ71nbk6KK3T3
         pBOOQ7mJrMgt9mu8whHr2lT0qcB2dJKA6zu3zj3xZmSUsS3DDliLGM6Xuya4CkfJvQzd
         P81w==
X-Gm-Message-State: AOJu0Yw1K5zsBr/+q/r1PmxFYcF5EOfUUz6RUi7fZIbaqVKdJlrL23i+
        UjhJAXxSXFR/wMB+i/X+WQw6wk+eYPumbTion6WOcw==
X-Google-Smtp-Source: AGHT+IFC4arPwc7Ao+r49qVHskOHs0pQDlbxHhN99WlxfDDWkvA/EGgTU6FSwYze80/m+Anmlsedpg==
X-Received: by 2002:a9d:5e13:0:b0:6c6:18c7:7ca2 with SMTP id d19-20020a9d5e13000000b006c618c77ca2mr1574486oti.12.1699439088694;
        Wed, 08 Nov 2023 02:24:48 -0800 (PST)
Received: from chromium.org (0.223.81.34.bc.googleusercontent.com. [34.81.223.0])
        by smtp.gmail.com with ESMTPSA id 83-20020a630256000000b005aa800c149bsm2838329pgc.39.2023.11.08.02.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 02:24:48 -0800 (PST)
Date:   Wed, 8 Nov 2023 10:24:44 +0000
From:   Tomasz Figa <tfiga@chromium.org>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     mchehab@kernel.org, m.szyprowski@samsung.com, ming.qian@nxp.com,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, hverkuil-cisco@xs4all.nl,
        nicolas.dufresne@collabora.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        kernel@collabora.com
Subject: Re: [PATCH v14.1] media: videobuf2: Be more flexible on the number
 of queue stored buffers
Message-ID: <20231108102444.4yp7y7mgsociy725@chromium.org>
References: <20231106143940.324020-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106143940.324020-1-benjamin.gaignard@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 03:39:40PM +0100, Benjamin Gaignard wrote:
> Add 'max_num_buffers' field in vb2_queue struct to let drivers decide
> how many buffers could be stored in a queue.
> This require 'bufs' array to be allocated at queue init time and freed
> when releasing the queue.
> By default VB2_MAX_FRAME remains the limit.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> ---
> version 14.1:
> - Do not change the number of freed buffers in vb2_core_queue_release().
> 
>  .../media/common/videobuf2/videobuf2-core.c   | 39 +++++++++++++++----
>  .../media/common/videobuf2/videobuf2-v4l2.c   |  6 +--
>  include/media/videobuf2-core.h                | 10 ++++-
>  3 files changed, 43 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
> index c5c5ae4d213d..5711c6a130fd 100644
> --- a/drivers/media/common/videobuf2/videobuf2-core.c
> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> @@ -416,7 +416,7 @@ static void init_buffer_cache_hints(struct vb2_queue *q, struct vb2_buffer *vb)
>   */
>  static void vb2_queue_add_buffer(struct vb2_queue *q, struct vb2_buffer *vb, unsigned int index)
>  {
> -	WARN_ON(index >= VB2_MAX_FRAME || q->bufs[index]);
> +	WARN_ON(index >= q->max_num_buffers || q->bufs[index]);
>  
>  	q->bufs[index] = vb;
>  	vb->index = index;
> @@ -449,9 +449,9 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
>  	struct vb2_buffer *vb;
>  	int ret;
>  
> -	/* Ensure that q->num_buffers+num_buffers is below VB2_MAX_FRAME */
> +	/* Ensure that the number of already queue + num_buffers is below q->max_num_buffers */

Perhaps "the number of buffers already in the queue"?

>  	num_buffers = min_t(unsigned int, num_buffers,
> -			    VB2_MAX_FRAME - q_num_buffers);
> +			    q->max_num_buffers - q_num_buffers);
>  
>  	for (buffer = 0; buffer < num_buffers; ++buffer) {
>  		/* Allocate vb2 buffer structures */
> @@ -813,7 +813,7 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
>  	unsigned plane_sizes[VB2_MAX_PLANES] = { };
>  	bool non_coherent_mem = flags & V4L2_MEMORY_FLAG_NON_COHERENT;
>  	unsigned int i;
> -	int ret;
> +	int ret = 0;
>  
>  	if (q->streaming) {
>  		dprintk(q, 1, "streaming active\n");
> @@ -857,17 +857,22 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
>  	/*
>  	 * Make sure the requested values and current defaults are sane.
>  	 */
> -	WARN_ON(q->min_buffers_needed > VB2_MAX_FRAME);

Do we really want to remove this warning completely?

>  	num_buffers = max_t(unsigned int, *count, q->min_buffers_needed);
> -	num_buffers = min_t(unsigned int, num_buffers, VB2_MAX_FRAME);
> +	num_buffers = min_t(unsigned int, num_buffers, q->max_num_buffers);
>  	memset(q->alloc_devs, 0, sizeof(q->alloc_devs));
>  	/*
>  	 * Set this now to ensure that drivers see the correct q->memory value
>  	 * in the queue_setup op.
>  	 */
>  	mutex_lock(&q->mmap_lock);
> +	if (!q->bufs)
> +		q->bufs = kcalloc(q->max_num_buffers, sizeof(*q->bufs), GFP_KERNEL);

Shouldn't this happen in core code rather than the v4l2-specific ioctl
helper? Since we just allocate the maximum possible size, then maybe
vb2_core_queue_init()?

> +	if (!q->bufs)
> +		ret = -ENOMEM;
>  	q->memory = memory;
>  	mutex_unlock(&q->mmap_lock);
> +	if (ret)
> +		return ret;
>  	set_queue_coherency(q, non_coherent_mem);
>  
>  	/*
> @@ -976,7 +981,7 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
>  	bool no_previous_buffers = !q_num_bufs;
>  	int ret = 0;
>  
> -	if (q_num_bufs == VB2_MAX_FRAME) {
> +	if (q->num_buffers == q->max_num_buffers) {
>  		dprintk(q, 1, "maximum number of buffers already allocated\n");
>  		return -ENOBUFS;
>  	}
> @@ -993,7 +998,13 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
>  		 */
>  		mutex_lock(&q->mmap_lock);
>  		q->memory = memory;
> +		if (!q->bufs)
> +			q->bufs = kcalloc(q->max_num_buffers, sizeof(*q->bufs), GFP_KERNEL);

Ditto.

> +		if (!q->bufs)
> +			ret = -ENOMEM;
>  		mutex_unlock(&q->mmap_lock);
> +		if (ret)
> +			return ret;
>  		q->waiting_for_buffers = !q->is_output;
>  		set_queue_coherency(q, non_coherent_mem);
>  	} else {
> @@ -1005,7 +1016,7 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
>  			return -EINVAL;
>  	}
>  
> -	num_buffers = min(*count, VB2_MAX_FRAME - q_num_bufs);
> +	num_buffers = min(*count, q->max_num_buffers - q_num_bufs);
>  
>  	if (requested_planes && requested_sizes) {
>  		num_planes = requested_planes;
> @@ -2465,6 +2476,12 @@ int vb2_core_queue_init(struct vb2_queue *q)
>  	/*
>  	 * Sanity check
>  	 */
> +	if (!q->max_num_buffers)
> +		q->max_num_buffers = VB2_MAX_FRAME;

Can we add a comment here to explain that this is for backwards
compatibility with drivers which don't support more buffers?

Actually, we should probably document in kerneldoc for vb2_queue that 0 is
an allowed and special value.

> +
> +	/* The maximum is limited by offset cookie encoding pattern */
> +	q->max_num_buffers = min_t(unsigned int, q->max_num_buffers, MAX_BUFFER_INDEX);
> +
>  	if (WARN_ON(!q)			  ||
>  	    WARN_ON(!q->ops)		  ||
>  	    WARN_ON(!q->mem_ops)	  ||
> @@ -2474,6 +2491,10 @@ int vb2_core_queue_init(struct vb2_queue *q)
>  	    WARN_ON(!q->ops->buf_queue))
>  		return -EINVAL;
>  
> +	if (WARN_ON(q->max_num_buffers > MAX_BUFFER_INDEX) ||

Hmm, how is this possible?

> +	    WARN_ON(q->min_buffers_needed > q->max_num_buffers))
> +		return -EINVAL;

I have a loose recollection that it's allowed for a driver to change this
value depending on the configuration. You may want to double check if any
driver doesn't do so already if we want to disallow that. (and also
document that it's not allowed)

> +
>  	if (WARN_ON(q->requires_requests && !q->supports_requests))
>  		return -EINVAL;
>  
> @@ -2520,6 +2541,8 @@ void vb2_core_queue_release(struct vb2_queue *q)
>  	__vb2_queue_cancel(q);
>  	mutex_lock(&q->mmap_lock);
>  	__vb2_queue_free(q, vb2_get_num_buffers(q));
> +	kfree(q->bufs);
> +	q->bufs = NULL;
>  	q->num_buffers = 0;
>  	mutex_unlock(&q->mmap_lock);
>  }
> diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
> index 7d798fb15c0b..f3cf4b235c1f 100644
> --- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
> +++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
> @@ -627,7 +627,7 @@ struct vb2_buffer *vb2_find_buffer(struct vb2_queue *q, u64 timestamp)
>  	 * This loop doesn't scale if there is a really large number of buffers.
>  	 * Maybe something more efficient will be needed in this case.
>  	 */
> -	for (i = 0; i < vb2_get_num_buffers(q); i++) {
> +	for (i = 0; i < q->max_num_buffers; i++) {
>  		vb2 = vb2_get_buffer(q, i);
>  
>  		if (!vb2)
> @@ -1142,7 +1142,7 @@ int _vb2_fop_release(struct file *file, struct mutex *lock)
>  
>  	if (lock)
>  		mutex_lock(lock);
> -	if (file->private_data == vdev->queue->owner) {
> +	if (!vdev->queue->owner || file->private_data == vdev->queue->owner) {
>  		vb2_queue_release(vdev->queue);
>  		vdev->queue->owner = NULL;
>  	}
> @@ -1270,7 +1270,7 @@ void vb2_video_unregister_device(struct video_device *vdev)
>  	 */
>  	get_device(&vdev->dev);
>  	video_unregister_device(vdev);
> -	if (vdev->queue && vdev->queue->owner) {
> +	if (vdev->queue) {
>  		struct mutex *lock = vdev->queue->lock ?
>  			vdev->queue->lock : vdev->lock;
>  
> diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
> index 8f9d9e4af5b1..e77a397195f2 100644
> --- a/include/media/videobuf2-core.h
> +++ b/include/media/videobuf2-core.h
> @@ -558,6 +558,7 @@ struct vb2_buf_ops {
>   * @dma_dir:	DMA mapping direction.
>   * @bufs:	videobuf2 buffer structures
>   * @num_buffers: number of allocated/used buffers
> + * @max_num_buffers: upper limit of number of allocated/used buffers
>   * @queued_list: list of buffers currently queued from userspace
>   * @queued_count: number of buffers queued and ready for streaming.
>   * @owned_by_drv_count: number of buffers owned by the driver
> @@ -619,8 +620,9 @@ struct vb2_queue {
>  	struct mutex			mmap_lock;
>  	unsigned int			memory;
>  	enum dma_data_direction		dma_dir;
> -	struct vb2_buffer		*bufs[VB2_MAX_FRAME];
> +	struct vb2_buffer		**bufs;
>  	unsigned int			num_buffers;
> +	unsigned int			max_num_buffers;
>  
>  	struct list_head		queued_list;
>  	unsigned int			queued_count;
> @@ -1248,6 +1250,12 @@ static inline void vb2_clear_last_buffer_dequeued(struct vb2_queue *q)
>  static inline struct vb2_buffer *vb2_get_buffer(struct vb2_queue *q,
>  						unsigned int index)
>  {
> +	if (!q->bufs)
> +		return NULL;
> +
> +	if (index >= q->max_num_buffers)

Wouldn't this be already prevented by the condition below?

> +		return NULL;
> +
>  	if (index < q->num_buffers)
>  		return q->bufs[index];
>  	return NULL;
> -- 
> 2.39.2
> 

Best regards,
Tomasz
