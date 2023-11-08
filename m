Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583B57E543E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 11:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344688AbjKHKqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 05:46:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344687AbjKHKqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 05:46:10 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942781BF6
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 02:44:44 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6b89ab5ddb7so6936880b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 02:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699440284; x=1700045084; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gKTyWokpX5cgue49QDtZFQPjUpwVAu8TbIboU5lRKS0=;
        b=QN7qWsTUCLuv2mb9MZds0fFM3GEB87l8mGOk+Pmc3zWMZcDFPwJNlapjPEgyQ/1Llf
         KGTIQ9BDQqTO/PztuDKjG77xoQoQ6P+pQEkCY8OojWfc1cCVwjdsfoA5zs6DPTdWOIAR
         N5TkXxe/qKJicNQIQnNbQ601auELYBC7OaB8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699440284; x=1700045084;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gKTyWokpX5cgue49QDtZFQPjUpwVAu8TbIboU5lRKS0=;
        b=gjkBo2qy3iM4nisCaLAiENUYMk/FXBpR1rqrxZXgzBphayCH7caUd7OdA56a3RZzva
         6tzqrbaK6h7txOQqI5nbrOtYc7yGG6KcSGJNd8gUUqnzLDCM/g4XzPbZ3tob3NUKpdX/
         Z4lNWi2asAYeYgH1PR2MaUS+ZcuPQXBK0DJrSBkP5evTkoEqUrfH3gBuq68oMdp9Z7IZ
         y2XXaZCGrdDYOMUfyGsvziVvLEoSClVP/4E70XSXFmwqyH63naPJM5HDi+HNdgzuHJ2e
         VL7JEtmqhrKeMWCeVmyL8sBJxmy5Ggzt/EXkaExnxHehudYkWXyYdnUI7XGpr9vDHjXK
         VVog==
X-Gm-Message-State: AOJu0Yz1dEJW2x1/ahs8SoPZfymt9bn1SiQuGgtaHmjQVqadhxirwHqR
        klcpUDSxRz5+XQqw3LWu4p61Vw==
X-Google-Smtp-Source: AGHT+IEzqy1BibD2RC0l4kCSPsKsVPKvQCQxco2ue8t7SCmmOXz1P0lkP95g4IaHmCfbUqjrwn7xKw==
X-Received: by 2002:a05:6a20:7f97:b0:14c:daa9:5e22 with SMTP id d23-20020a056a207f9700b0014cdaa95e22mr1989536pzj.45.1699440283822;
        Wed, 08 Nov 2023 02:44:43 -0800 (PST)
Received: from chromium.org (0.223.81.34.bc.googleusercontent.com. [34.81.223.0])
        by smtp.gmail.com with ESMTPSA id w12-20020a170902e88c00b001bb3beb2bc6sm1450272plg.65.2023.11.08.02.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 02:44:43 -0800 (PST)
Date:   Wed, 8 Nov 2023 10:44:39 +0000
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
Subject: Re: [PATCH v14 52/56] media: core: Add bitmap manage bufs array
 entries
Message-ID: <20231108104439.oxpbbd2yro7u57t4@chromium.org>
References: <20231031163104.112469-1-benjamin.gaignard@collabora.com>
 <20231031163104.112469-53-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031163104.112469-53-benjamin.gaignard@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 05:31:00PM +0100, Benjamin Gaignard wrote:
> Add a bitmap field to know which of bufs array entries are
> used or not.
> Remove no more used num_buffers field from queue structure.
> Use bitmap_find_next_zero_area() to find the first possible
> range when creating new buffers to fill the gaps.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>  .../media/common/videobuf2/videobuf2-core.c   | 42 +++++++++++++++----
>  include/media/videobuf2-core.h                | 15 ++++---
>  2 files changed, 42 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
> index 2c8cf479a962..6e88406fcae9 100644
> --- a/drivers/media/common/videobuf2/videobuf2-core.c
> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> @@ -416,11 +416,12 @@ static void init_buffer_cache_hints(struct vb2_queue *q, struct vb2_buffer *vb)
>   */
>  static void vb2_queue_add_buffer(struct vb2_queue *q, struct vb2_buffer *vb, unsigned int index)
>  {
> -	WARN_ON(index >= q->max_num_buffers || q->bufs[index]);
> +	WARN_ON(index >= q->max_num_buffers || test_bit(index, q->bufs_bitmap));
>  
>  	q->bufs[index] = vb;
>  	vb->index = index;
>  	vb->vb2_queue = q;
> +	set_bit(index, q->bufs_bitmap);
>  }
>  
>  /**
> @@ -429,6 +430,7 @@ static void vb2_queue_add_buffer(struct vb2_queue *q, struct vb2_buffer *vb, uns
>   */
>  static void vb2_queue_remove_buffer(struct vb2_buffer *vb)
>  {
> +	clear_bit(vb->index, vb->vb2_queue->bufs_bitmap);
>  	vb->vb2_queue->bufs[vb->index] = NULL;
>  	vb->vb2_queue = NULL;
>  }
> @@ -450,11 +452,12 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
>  	unsigned long index;
>  	int ret;
>  
> -	/* Ensure that the number of already queue + num_buffers is below q->max_num_buffers */
> +	/* Ensure that vb2_get_num_buffers(q) + num_buffers is no more than q->max_num_buffers */
>  	num_buffers = min_t(unsigned int, num_buffers,
>  			    q->max_num_buffers - vb2_get_num_buffers(q));
>  
> -	index = vb2_get_num_buffers(q);
> +	index = bitmap_find_next_zero_area(q->bufs_bitmap, q->max_num_buffers,
> +					   0, num_buffers, 0);
>  
>  	*first_index = index;
>  
> @@ -656,7 +659,6 @@ static void __vb2_queue_free(struct vb2_queue *q, unsigned int buffers)
>  		kfree(vb);
>  	}
>  
> -	q->num_buffers -= buffers;
>  	if (!vb2_get_num_buffers(q)) {
>  		q->memory = VB2_MEMORY_UNKNOWN;
>  		INIT_LIST_HEAD(&q->queued_list);
> @@ -874,6 +876,14 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
>  		q->bufs = kcalloc(q->max_num_buffers, sizeof(*q->bufs), GFP_KERNEL);
>  	if (!q->bufs)
>  		ret = -ENOMEM;
> +
> +	if (!q->bufs_bitmap)
> +		q->bufs_bitmap = bitmap_zalloc(q->max_num_buffers, GFP_KERNEL);
> +	if (!q->bufs_bitmap) {
> +		ret = -ENOMEM;
> +		kfree(q->bufs);
> +		q->bufs = NULL;
> +	}
>  	q->memory = memory;
>  	mutex_unlock(&q->mmap_lock);
>  	if (ret)
> @@ -943,7 +953,6 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
>  	}
>  
>  	mutex_lock(&q->mmap_lock);
> -	q->num_buffers = allocated_buffers;
>  
>  	if (ret < 0) {
>  		/*
> @@ -970,6 +979,10 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
>  	mutex_lock(&q->mmap_lock);
>  	q->memory = VB2_MEMORY_UNKNOWN;
>  	mutex_unlock(&q->mmap_lock);
> +	kfree(q->bufs);
> +	q->bufs = NULL;
> +	bitmap_free(q->bufs_bitmap);
> +	q->bufs_bitmap = NULL;
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(vb2_core_reqbufs);
> @@ -1006,9 +1019,19 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
>  		q->memory = memory;
>  		if (!q->bufs)
>  			q->bufs = kcalloc(q->max_num_buffers, sizeof(*q->bufs), GFP_KERNEL);
> -		if (!q->bufs)
> +		if (!q->bufs) {
>  			ret = -ENOMEM;
> +			goto unlock;
> +		}
> +		if (!q->bufs_bitmap)
> +			q->bufs_bitmap = bitmap_zalloc(q->max_num_buffers, GFP_KERNEL);

Same as with the kcalloc(). Why not just allocate this in the core code,
e.g. vb2_core_queue_init()?

Actually, is it because we want to avoid allocating
resources early, before the need to actually use the vb2 queue?
If so, could this go to some other core function that runs later, e.g. __vb2_queue_alloc()?

> +		if (!q->bufs_bitmap) {
> +			ret = -ENOMEM;
> +			kfree(q->bufs);
> +			q->bufs = NULL;
> +		}
>  		mutex_unlock(&q->mmap_lock);
> +unlock:
>  		if (ret)
>  			return ret;
>  		q->waiting_for_buffers = !q->is_output;
> @@ -1070,7 +1093,6 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
>  	}
>  
>  	mutex_lock(&q->mmap_lock);
> -	q->num_buffers += allocated_buffers;
>  
>  	if (ret < 0) {
>  		/*
> @@ -2549,7 +2571,9 @@ void vb2_core_queue_release(struct vb2_queue *q)
>  	__vb2_queue_free(q, q->max_num_buffers);
>  	kfree(q->bufs);
>  	q->bufs = NULL;
> -	q->num_buffers = 0;
> +	bitmap_free(q->bufs_bitmap);
> +	q->bufs_bitmap = NULL;
> +
>  	mutex_unlock(&q->mmap_lock);
>  }
>  EXPORT_SYMBOL_GPL(vb2_core_queue_release);
> @@ -2904,7 +2928,7 @@ static size_t __vb2_perform_fileio(struct vb2_queue *q, char __user *data, size_
>  	 * Check if we need to dequeue the buffer.
>  	 */
>  	index = fileio->cur_index;
> -	if (index >= q->num_buffers) {
> +	if (!test_bit(index, q->bufs_bitmap)) {

I don't like this low level manipulation of queue internals here (after all
the work other patches did to use helpers). Why not just keep
vb2_get_num_buffers() here?

>  		struct vb2_buffer *b;
>  
>  		/*
> diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
> index 6986ff4b77cd..288477075a0e 100644
> --- a/include/media/videobuf2-core.h
> +++ b/include/media/videobuf2-core.h
> @@ -346,7 +346,7 @@ struct vb2_buffer {
>   *			describes the requested number of planes and sizes\[\]
>   *			contains the requested plane sizes. In this case
>   *			\*num_buffers are being allocated additionally to
> - *			q->num_buffers. If either \*num_planes or the requested
> + *			queue buffers. If either \*num_planes or the requested

Perhaps "the buffers already in the queue"?

>   *			sizes are invalid callback must return %-EINVAL.
>   * @wait_prepare:	release any locks taken while calling vb2 functions;
>   *			it is called before an ioctl needs to wait for a new
> @@ -557,7 +557,7 @@ struct vb2_buf_ops {
>   * @memory:	current memory type used
>   * @dma_dir:	DMA mapping direction.
>   * @bufs:	videobuf2 buffer structures
> - * @num_buffers: number of allocated/used buffers
> + * @bufs_bitmap: bitmap to manage bufs entries.

Perhaps "bitmap tracking whether each bufs[] entry is used"?

>   * @max_num_buffers: upper limit of number of allocated/used buffers
>   * @queued_list: list of buffers currently queued from userspace
>   * @queued_count: number of buffers queued and ready for streaming.
> @@ -621,7 +621,7 @@ struct vb2_queue {
>  	unsigned int			memory;
>  	enum dma_data_direction		dma_dir;
>  	struct vb2_buffer		**bufs;
> -	unsigned int			num_buffers;
> +	unsigned long			*bufs_bitmap;
>  	unsigned int			max_num_buffers;
>  
>  	struct list_head		queued_list;
> @@ -1150,7 +1150,10 @@ static inline bool vb2_fileio_is_active(struct vb2_queue *q)
>   */
>  static inline unsigned int vb2_get_num_buffers(struct vb2_queue *q)
>  {
> -	return q->num_buffers;
> +	if (!q->bufs_bitmap)
> +		return 0;
> +
> +	return bitmap_weight(q->bufs_bitmap, q->max_num_buffers);

Hmm, could we just cache the number of buffers we have, so that we don't
have to go over the entire bitmap every time? (Basically just keep the
code that we had for handling q->num_buffers before this patch.)

>  }
>  
>  /**
> @@ -1253,13 +1256,13 @@ static inline void vb2_clear_last_buffer_dequeued(struct vb2_queue *q)
>  static inline struct vb2_buffer *vb2_get_buffer(struct vb2_queue *q,
>  						unsigned int index)
>  {
> -	if (!q->bufs)
> +	if (!q->bufs_bitmap)
>  		return NULL;
>  
>  	if (index >= q->max_num_buffers)
>  		return NULL;
>  
> -	if (index < q->num_buffers)
> +	if (test_bit(index, q->bufs_bitmap))

Aha, I see why we need the extra condition above now. Perhaps it should've
been added in this patch instead?

>  		return q->bufs[index];
>  	return NULL;
>  }
> -- 
> 2.39.2
> 

Best regards,
Tomasz
