Return-Path: <linux-kernel+bounces-54520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7707884B035
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E06151F265CC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E3212C541;
	Tue,  6 Feb 2024 08:43:27 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C383612C55C;
	Tue,  6 Feb 2024 08:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707209006; cv=none; b=kuhrf5w9teDdHTCajL9m7854lMT7aplIIROXXZm+ru+IBJU7Wt/PNooBtDAvRe0x2oWPPDkzrBOKdtBSBu3IV8pJ66QzT7xavJBwzf3jsqWA/fW0GdT5rH95XPjwG8DAjYj+u2shljQPcTZ4wSToIelYJK9jCeOyO+9NrkSHHrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707209006; c=relaxed/simple;
	bh=XR9woyvyvAvsz9+sI2jnlhYiYEIwwwgqIjlmNK9XGkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U5zWFcXcCMQ1A5XUai/sCFPOSpDxyNeuE2jQ9vMxUGwE1D1+0uZvJEAHpOqHtAI0BHDMxzYRG+UHlTwopMvOpuc354+K5P5MreN+cFarzNmYnESZWaHZwz5xMy0yhocZwEgyM5nQ4krJ5K0KQd5wcPrujykJTvhZEIqMG10ltUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35992C433F1;
	Tue,  6 Feb 2024 08:43:25 +0000 (UTC)
Message-ID: <c7ddcc17-b739-4b1e-bb03-e21036716089@xs4all.nl>
Date: Tue, 6 Feb 2024 09:43:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 1/9] media: videobuf2: Update vb2_is_busy() logic
Content-Language: en-US, nl
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>, mchehab@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 kernel@collabora.com
References: <20240206080219.11951-1-benjamin.gaignard@collabora.com>
 <20240206080219.11951-2-benjamin.gaignard@collabora.com>
From: Hans Verkuil <hverkuil@xs4all.nl>
Autocrypt: addr=hverkuil@xs4all.nl; keydata=
 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
In-Reply-To: <20240206080219.11951-2-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/02/2024 09:02, Benjamin Gaignard wrote:
> Do not rely on the number of allocated buffers to know if the
> queue is busy but on a flag set when at least buffer has been allocated

You missed one change: least buffer -> least one buffer

Can you post a v19.1 for just this patch with that typo fixed? It's a
rather important typo.

Regards,

	Hans

> by REQBUFS or CREATE_BUFS ioctl.
> The flag is reset when REQBUFS is called with count = 0 or the file
> handle is closed.
> This is needed because delete buffers feature will be able to remove
> all the buffers from a queue while streaming so relying on the number
> of allocated buffers in the queue won't be possible.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
> version 19:
> - Add q->is_busy = 0 in vb2_core_queue_release()
> - Fix q->is_busy usage in vb2_core_reqbufs()
> - Reword commit message.
> 
>  drivers/media/common/videobuf2/videobuf2-core.c | 4 ++++
>  include/media/videobuf2-core.h                  | 4 +++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
> index b6bf8f232f48..d8b3c04cb3b5 100644
> --- a/drivers/media/common/videobuf2/videobuf2-core.c
> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> @@ -854,6 +854,7 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
>  		__vb2_queue_free(q, q_num_bufs);
>  		mutex_unlock(&q->mmap_lock);
>  
> +		q->is_busy = 0;
>  		/*
>  		 * In case of REQBUFS(0) return immediately without calling
>  		 * driver's queue_setup() callback and allocating resources.
> @@ -966,6 +967,7 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
>  	 */
>  	*count = allocated_buffers;
>  	q->waiting_for_buffers = !q->is_output;
> +	q->is_busy = 1;
>  
>  	return 0;
>  
> @@ -1091,6 +1093,7 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
>  	 * to the userspace.
>  	 */
>  	*count = allocated_buffers;
> +	q->is_busy = 1;
>  
>  	return 0;
>  
> @@ -2555,6 +2558,7 @@ void vb2_core_queue_release(struct vb2_queue *q)
>  	__vb2_queue_free(q, vb2_get_num_buffers(q));
>  	kfree(q->bufs);
>  	q->bufs = NULL;
> +	q->is_busy = 0;
>  	mutex_unlock(&q->mmap_lock);
>  }
>  EXPORT_SYMBOL_GPL(vb2_core_queue_release);
> diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
> index 56719a26a46c..b317286a7b08 100644
> --- a/include/media/videobuf2-core.h
> +++ b/include/media/videobuf2-core.h
> @@ -579,6 +579,7 @@ struct vb2_buf_ops {
>   *		called since poll() needs to return %EPOLLERR in that situation.
>   * @is_multiplanar: set if buffer type is multiplanar
>   * @is_output:	set if buffer type is output
> + * @is_busy:	set if at least one buffer has been allocated at some time.
>   * @copy_timestamp: set if vb2-core should set timestamps
>   * @last_buffer_dequeued: used in poll() and DQBUF to immediately return if the
>   *		last decoded buffer was already dequeued. Set for capture queues
> @@ -644,6 +645,7 @@ struct vb2_queue {
>  	unsigned int			waiting_in_dqbuf:1;
>  	unsigned int			is_multiplanar:1;
>  	unsigned int			is_output:1;
> +	unsigned int			is_busy:1;
>  	unsigned int			copy_timestamp:1;
>  	unsigned int			last_buffer_dequeued:1;
>  
> @@ -1163,7 +1165,7 @@ static inline unsigned int vb2_get_num_buffers(struct vb2_queue *q)
>   */
>  static inline bool vb2_is_busy(struct vb2_queue *q)
>  {
> -	return vb2_get_num_buffers(q) > 0;
> +	return !!q->is_busy;
>  }
>  
>  /**


