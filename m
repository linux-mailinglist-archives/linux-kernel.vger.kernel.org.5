Return-Path: <linux-kernel+bounces-52800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CB0849CC7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD08B1C2522A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9312C856;
	Mon,  5 Feb 2024 14:15:30 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280D22DF87;
	Mon,  5 Feb 2024 14:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707142530; cv=none; b=e6ThGwfGebfiVNOkT47oVvwv2pPlI09UB3Z9MkvXYhJR9da4D+ie0obkQTe5laC0JaA47Kv919yUJGw+zbH19B1pqOymsyav70FbNUGYHc9J8aMikGjnGjY/TYewTXGouswKtcGA8IIOToPgVYWrLyu92/PtYoPtDPnpdGA3g4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707142530; c=relaxed/simple;
	bh=gUmWB0WUxmbFtOW6iXntjLks2xNk20WwAGRGYL9uiH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q/YdcuPA2QGK4JVGaaXJqZT3oJicRRmJv5kxndZfirnMbm+Nb4HRO9Znzxz8yRgXb0i4GDO91WP8LehLqnjqiGl6zuL59bzDxPwH1vqp6SnQXojyAKyi/0fOl/NxbKzgkaL1q+J0JqKDLqkyymHdJP1/vdfj3Epy+B/+LV8E2I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC27C433C7;
	Mon,  5 Feb 2024 14:15:28 +0000 (UTC)
Message-ID: <f9cf797b-d628-480b-bd6e-5217b111e983@xs4all.nl>
Date: Mon, 5 Feb 2024 15:15:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 6/9] media: core: Free range of buffers
Content-Language: en-US, nl
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>, mchehab@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 kernel@collabora.com
References: <20240126110141.135896-1-benjamin.gaignard@collabora.com>
 <20240126110141.135896-7-benjamin.gaignard@collabora.com>
From: Hans Verkuil <hverkuil@xs4all.nl>
Autocrypt: addr=hverkuil@xs4all.nl; keydata=
 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
In-Reply-To: <20240126110141.135896-7-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/01/2024 12:01, Benjamin Gaignard wrote:
> Improve __vb2_queue_free() and __vb2_free_mem() to free
> range of buffers and not only the last few buffers.
> Intoduce starting index to be flexible on range and change the loops

Intoduce -> Introduce

> according to this parameters.

parameters -> parameter

> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>  .../media/common/videobuf2/videobuf2-core.c   | 56 +++++++++----------
>  1 file changed, 26 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
> index 1506fbe8fc76..8486a2f2c09d 100644
> --- a/drivers/media/common/videobuf2/videobuf2-core.c
> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> @@ -540,17 +540,16 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
>  }
>  
>  /*
> - * __vb2_free_mem() - release all video buffer memory for a given queue
> + * __vb2_free_mem() - release video buffer memory for a given range of
> + * buffers in a given queue
>   */
> -static void __vb2_free_mem(struct vb2_queue *q, unsigned int buffers)
> +static void __vb2_free_mem(struct vb2_queue *q, unsigned int start, unsigned int count)
>  {
> -	unsigned int buffer;
> +	unsigned int i;
>  	struct vb2_buffer *vb;
> -	unsigned int q_num_buffers = vb2_get_num_buffers(q);
>  
> -	for (buffer = q_num_buffers - buffers; buffer < q_num_buffers;
> -	     ++buffer) {
> -		vb = vb2_get_buffer(q, buffer);
> +	for (i = start; i < start + count; i++) {
> +		vb = vb2_get_buffer(q, i);
>  		if (!vb)
>  			continue;
>  
> @@ -565,35 +564,33 @@ static void __vb2_free_mem(struct vb2_queue *q, unsigned int buffers)
>  }
>  
>  /*
> - * __vb2_queue_free() - free buffers at the end of the queue - video memory and
> + * __vb2_queue_free() - free @count buffers from @start index of the queue - video memory and
>   * related information, if no buffers are left return the queue to an
>   * uninitialized state. Might be called even if the queue has already been freed.
>   */
> -static void __vb2_queue_free(struct vb2_queue *q, unsigned int buffers)
> +static void __vb2_queue_free(struct vb2_queue *q, unsigned int start, unsigned int count)
>  {
> -	unsigned int buffer;
> -	unsigned int q_num_buffers = vb2_get_num_buffers(q);
> +	unsigned int i;
>  
>  	lockdep_assert_held(&q->mmap_lock);
>  
>  	/* Call driver-provided cleanup function for each buffer, if provided */
> -	for (buffer = q_num_buffers - buffers; buffer < q_num_buffers;
> -	     ++buffer) {
> -		struct vb2_buffer *vb = vb2_get_buffer(q, buffer);
> +	for (i = start; i < start + count; i++) {
> +		struct vb2_buffer *vb = vb2_get_buffer(q, i);
>  
>  		if (vb && vb->planes[0].mem_priv)
>  			call_void_vb_qop(vb, buf_cleanup, vb);
>  	}
>  
>  	/* Release video buffer memory */
> -	__vb2_free_mem(q, buffers);
> +	__vb2_free_mem(q, start, count);
>  
>  #ifdef CONFIG_VIDEO_ADV_DEBUG
>  	/*
>  	 * Check that all the calls were balanced during the life-time of this
>  	 * queue. If not then dump the counters to the kernel log.
>  	 */
> -	if (q_num_buffers) {
> +	if (vb2_get_num_buffers(q)) {
>  		bool unbalanced = q->cnt_start_streaming != q->cnt_stop_streaming ||
>  				  q->cnt_prepare_streaming != q->cnt_unprepare_streaming ||
>  				  q->cnt_wait_prepare != q->cnt_wait_finish;
> @@ -619,8 +616,8 @@ static void __vb2_queue_free(struct vb2_queue *q, unsigned int buffers)
>  		q->cnt_stop_streaming = 0;
>  		q->cnt_unprepare_streaming = 0;
>  	}
> -	for (buffer = 0; buffer < vb2_get_num_buffers(q); buffer++) {
> -		struct vb2_buffer *vb = vb2_get_buffer(q, buffer);
> +	for (i = start; i < start + count; i++) {
> +		struct vb2_buffer *vb = vb2_get_buffer(q, i);
>  		bool unbalanced;
>  
>  		if (!vb)
> @@ -637,7 +634,7 @@ static void __vb2_queue_free(struct vb2_queue *q, unsigned int buffers)
>  
>  		if (unbalanced) {
>  			pr_info("unbalanced counters for queue %p, buffer %d:\n",
> -				q, buffer);
> +				q, i);
>  			if (vb->cnt_buf_init != vb->cnt_buf_cleanup)
>  				pr_info("     buf_init: %u buf_cleanup: %u\n",
>  					vb->cnt_buf_init, vb->cnt_buf_cleanup);
> @@ -671,9 +668,8 @@ static void __vb2_queue_free(struct vb2_queue *q, unsigned int buffers)
>  #endif
>  
>  	/* Free vb2 buffers */
> -	for (buffer = q_num_buffers - buffers; buffer < q_num_buffers;
> -	     ++buffer) {
> -		struct vb2_buffer *vb = vb2_get_buffer(q, buffer);
> +	for (i = start; i < start + count; i++) {
> +		struct vb2_buffer *vb = vb2_get_buffer(q, i);
>  
>  		if (!vb)
>  			continue;
> @@ -713,7 +709,7 @@ EXPORT_SYMBOL(vb2_buffer_in_use);
>  static bool __buffers_in_use(struct vb2_queue *q)
>  {
>  	unsigned int buffer;
> -	for (buffer = 0; buffer < vb2_get_num_buffers(q); ++buffer) {
> +	for (buffer = 0; buffer < q->max_num_buffers; ++buffer) {
>  		struct vb2_buffer *vb = vb2_get_buffer(q, buffer);
>  
>  		if (!vb)
> @@ -899,7 +895,7 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
>  		 * queued without ever calling STREAMON.
>  		 */
>  		__vb2_queue_cancel(q);
> -		__vb2_queue_free(q, q_num_bufs);
> +		__vb2_queue_free(q, 0, q->max_num_buffers);
>  		mutex_unlock(&q->mmap_lock);
>  
>  		/*
> @@ -1002,7 +998,7 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
>  		 * from already queued buffers and it will reset q->memory to
>  		 * VB2_MEMORY_UNKNOWN.
>  		 */
> -		__vb2_queue_free(q, allocated_buffers);
> +		__vb2_queue_free(q, first_index, allocated_buffers);
>  		mutex_unlock(&q->mmap_lock);
>  		return ret;
>  	}
> @@ -1127,7 +1123,7 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
>  		 * from already queued buffers and it will reset q->memory to
>  		 * VB2_MEMORY_UNKNOWN.
>  		 */
> -		__vb2_queue_free(q, allocated_buffers);
> +		__vb2_queue_free(q, *first_index, allocated_buffers);
>  		mutex_unlock(&q->mmap_lock);
>  		return -ENOMEM;
>  	}
> @@ -1742,7 +1738,7 @@ static int vb2_start_streaming(struct vb2_queue *q)
>  		 * Forcefully reclaim buffers if the driver did not
>  		 * correctly return them to vb2.
>  		 */
> -		for (i = 0; i < vb2_get_num_buffers(q); ++i) {
> +		for (i = 0; i < q->max_num_buffers; ++i) {
>  			vb = vb2_get_buffer(q, i);
>  
>  			if (!vb)
> @@ -2148,7 +2144,7 @@ static void __vb2_queue_cancel(struct vb2_queue *q)
>  	 * to vb2 in stop_streaming().
>  	 */
>  	if (WARN_ON(atomic_read(&q->owned_by_drv_count))) {
> -		for (i = 0; i < vb2_get_num_buffers(q); i++) {
> +		for (i = 0; i < q->max_num_buffers; i++) {
>  			struct vb2_buffer *vb = vb2_get_buffer(q, i);
>  
>  			if (!vb)
> @@ -2192,7 +2188,7 @@ static void __vb2_queue_cancel(struct vb2_queue *q)
>  	 * call to __fill_user_buffer() after buf_finish(). That order can't
>  	 * be changed, so we can't move the buf_finish() to __vb2_dqbuf().
>  	 */
> -	for (i = 0; i < vb2_get_num_buffers(q); i++) {
> +	for (i = 0; i < q->max_num_buffers; i++) {
>  		struct vb2_buffer *vb;
>  		struct media_request *req;
>  
> @@ -2619,7 +2615,7 @@ void vb2_core_queue_release(struct vb2_queue *q)
>  	__vb2_cleanup_fileio(q);
>  	__vb2_queue_cancel(q);
>  	mutex_lock(&q->mmap_lock);
> -	__vb2_queue_free(q, vb2_get_num_buffers(q));
> +	__vb2_queue_free(q, 0, q->max_num_buffers);
>  	vb2_core_free_buffers_storage(q);
>  	mutex_unlock(&q->mmap_lock);
>  }

Regards,

	Hans

