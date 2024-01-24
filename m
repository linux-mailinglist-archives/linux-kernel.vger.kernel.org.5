Return-Path: <linux-kernel+bounces-36910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B8883A88D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F5621F22B86
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865AC60876;
	Wed, 24 Jan 2024 11:52:08 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE44B60875;
	Wed, 24 Jan 2024 11:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706097127; cv=none; b=Pi3qrX69ALtOhC4eIb3vhFgCu1vJU79GRGLy9qMQqDpiCZ2eSyntCou0/v+iHAuB4/IwmlJHYoLES8O9ao+atQ5LfKPdprcXlEnNaoVx9Nxed+UpgfhKAF57hh6BBaG6UipsmnBOC9vqkBWu1BPmNzprBce6Ul6jalmtLkdiQYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706097127; c=relaxed/simple;
	bh=pvR9oQOQ76EoDEesEru8z4GxRRCBTyZSbUiK68aYisM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q1CoSBlwqzS+vCUM0J9ZpfQwlQwNBI0riw8J89QJ0snmWjgGe34FbcPgHJzP5IxE4VmQlfcUInsp2wrd8ksIZEbpxfWa805m4U83LffX7KNGjFgebMLLOt38TF/EhzN9H8VcoWME8JVfm62v3jBqr8Woj9OVdRogU8N5pgf6Plw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0412FC43390;
	Wed, 24 Jan 2024 11:52:05 +0000 (UTC)
Message-ID: <fad5413f-b37f-4ce9-b93b-d8c8a6247e23@xs4all.nl>
Date: Wed, 24 Jan 2024 12:52:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 4/8] media: core: Add bitmap manage bufs array entries
Content-Language: en-US, nl
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>, mchehab@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 kernel@collabora.com
References: <20240119094944.26763-1-benjamin.gaignard@collabora.com>
 <20240119094944.26763-5-benjamin.gaignard@collabora.com>
From: Hans Verkuil <hverkuil@xs4all.nl>
Autocrypt: addr=hverkuil@xs4all.nl; keydata=
 xsFNBFQ84W0BEAC7EF1iL4s3tY8cRTVkJT/297h0Hz0ypA+ByVM4CdU9sN6ua/YoFlr9k0K4
 BFUlg7JzJoUuRbKxkYb8mmqOe722j7N3HO8+ofnio5cAP5W0WwDpM0kM84BeHU0aPSTsWiGR
 yw55SOK2JBSq7hueotWLfJLobMWhQii0Zd83hGT9SIt9uHaHjgwmtTH7MSTIiaY6N14nw2Ud
 C6Uykc1va0Wqqc2ov5ihgk/2k2SKa02ookQI3e79laOrbZl5BOXNKR9LguuOZdX4XYR3Zi6/
 BsJ7pVCK9xkiVf8svlEl94IHb+sa1KrlgGv3fn5xgzDw8Z222TfFceDL/2EzUyTdWc4GaPMC
 E/c1B4UOle6ZHg02+I8tZicjzj5+yffv1lB5A1btG+AmoZrgf0X2O1B96fqgHx8w9PIpVERN
 YsmkfxvhfP3MO3oHh8UY1OLKdlKamMneCLk2up1Zlli347KMjHAVjBAiy8qOguKF9k7HOjif
 JCLYTkggrRiEiE1xg4tblBNj8WGyKH+u/hwwwBqCd/Px2HvhAsJQ7DwuuB3vBAp845BJYUU3
 06kRihFqbO0vEt4QmcQDcbWINeZ2zX5TK7QQ91ldHdqJn6MhXulPKcM8tCkdD8YNXXKyKqNl
 UVqXnarz8m2JCbHgjEkUlAJCNd6m3pfESLZwSWsLYL49R5yxIwARAQABzSFIYW5zIFZlcmt1
 aWwgPGh2ZXJrdWlsQHhzNGFsbC5ubD7CwZUEEwECACgFAlQ84W0CGwMFCRLMAwAGCwkIBwMC
 BhUIAgkKCwQWAgMBAh4BAheAACEJEL0tYUhmFDtMFiEEBSzee8IVBTtonxvKvS1hSGYUO0wT
 7w//frEmPBAwu3OdvAk9VDkH7X+7RcFpiuUcJxs3Xl6jpaA+SdwtZra6W1uMrs2RW8eXXiq/
 80HXJtYnal1Y8MKUBoUVhT/+5+KcMyfVQK3VFRHnNxCmC9HZV+qdyxAGwIscUd4hSlweuU6L
 6tI7Dls6NzKRSTFbbGNZCRgl8OrF01TBH+CZrcFIoDgpcJA5Pw84mxo+wd2BZjPA4TNyq1od
 +slSRbDqFug1EqQaMVtUOdgaUgdlmjV0+GfBHoyCGedDE0knv+tRb8v5gNgv7M3hJO3Nrl+O
 OJVoiW0G6OWVyq92NNCKJeDy8XCB1yHCKpBd4evO2bkJNV9xcgHtLrVqozqxZAiCRKN1elWF
 1fyG8KNquqItYedUr+wZZacqW+uzpVr9pZmUqpVCk9s92fzTzDZcGAxnyqkaO2QTgdhPJT2m
 wpG2UwIKzzi13tmwakY7OAbXm76bGWVZCO3QTHVnNV8ku9wgeMc/ZGSLUT8hMDZlwEsW7u/D
 qt+NlTKiOIQsSW7u7h3SFm7sMQo03X/taK9PJhS2BhhgnXg8mOa6U+yNaJy+eU0Lf5hEUiDC
 vDOI5x++LD3pdrJVr/6ZB0Qg3/YzZ0dk+phQ+KlP6HyeO4LG662toMbFbeLcBjcC/ceEclII
 90QNEFSZKM6NVloM+NaZRYVO3ApxWkFu+1mrVTXOwU0EVDzhbQEQANzLiI6gHkIhBQKeQaYs
 p2SSqF9c++9LOy5x6nbQ4s0X3oTKaMGfBZuiKkkU6NnHCSa0Az5ScRWLaRGu1PzjgcVwzl5O
 sDawR1BtOG/XoPRNB2351PRp++W8TWo2viYYY0uJHKFHML+ku9q0P+NkdTzFGJLP+hn7x0RT
 DMbhKTHO3H2xJz5TXNE9zTJuIfGAz3ShDpijvzYieY330BzZYfpgvCllDVM5E4XgfF4F/N90
 wWKu50fMA01ufwu+99GEwTFVG2az5T9SXd7vfSgRSkzXy7hcnxj4IhOfM6Ts85/BjMeIpeqy
 TDdsuetBgX9DMMWxMWl7BLeiMzMGrfkJ4tvlof0sVjurXibTibZyfyGR2ricg8iTbHyFaAzX
 2uFVoZaPxrp7udDfQ96sfz0hesF9Zi8d7NnNnMYbUmUtaS083L/l2EDKvCIkhSjd48XF+aO8
 VhrCfbXWpGRaLcY/gxi2TXRYG9xCa7PINgz9SyO34sL6TeFPSZn4bPQV5O1j85Dj4jBecB1k
 z2arzwlWWKMZUbR04HTeAuuvYvCKEMnfW3ABzdonh70QdqJbpQGfAF2p4/iCETKWuqefiOYn
 pR8PqoQA1DYv3t7y9DIN5Jw/8Oj5wOeEybw6vTMB0rrnx+JaXvxeHSlFzHiD6il/ChDDkJ9J
 /ejCHUQIl40wLSDRABEBAAHCwXwEGAECAA8FAlQ84W0CGwwFCRLMAwAAIQkQvS1hSGYUO0wW
 IQQFLN57whUFO2ifG8q9LWFIZhQ7TA1WD/9yxJvQrpf6LcNrr8uMlQWCg2iz2q1LGt1Itkuu
 KaavEF9nqHmoqhSfZeAIKAPn6xuYbGxXDrpN7dXCOH92fscLodZqZtK5FtbLvO572EPfxneY
 UT7JzDc/5LT9cFFugTMOhq1BG62vUm/F6V91+unyp4dRlyryAeqEuISykhvjZCVHk/woaMZv
 c1Dm4Uvkv0Ilelt3Pb9J7zhcx6sm5T7v16VceF96jG61bnJ2GFS+QZerZp3PY27XgtPxRxYj
 AmFUeF486PHx/2Yi4u1rQpIpC5inPxIgR1+ZFvQrAV36SvLFfuMhyCAxV6WBlQc85ArOiQZB
 Wm7L0repwr7zEJFEkdy8C81WRhMdPvHkAIh3RoY1SGcdB7rB3wCzfYkAuCBqaF7Zgfw8xkad
 KEiQTexRbM1sc/I8ACpla3N26SfQwrfg6V7TIoweP0RwDrcf5PVvwSWsRQp2LxFCkwnCXOra
 gYmkrmv0duG1FStpY+IIQn1TOkuXrciTVfZY1cZD0aVxwlxXBnUNZZNslldvXFtndxR0SFat
 sflovhDxKyhFwXOP0Rv8H378/+14TaykknRBIKEc0+lcr+EMOSUR5eg4aURb8Gc3Uc7fgQ6q
 UssTXzHPyj1hAyDpfu8DzAwlh4kKFTodxSsKAjI45SLjadSc94/5Gy8645Y1KgBzBPTH7Q==
In-Reply-To: <20240119094944.26763-5-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/01/2024 10:49, Benjamin Gaignard wrote:
> Add a bitmap field to know which of bufs array entries are
> used or not.
> Remove no more used num_buffers field from queue structure.
> Use bitmap_find_next_zero_area() to find the first possible
> range when creating new buffers to fill the gaps.
> If no suitable range is found try to allocate less buffers
> than requested.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
> version 17:
> - allow to allocate less buffers than requested in __vb2_queue_alloc()
>   when using bitmap.
> - add vb2_core_allocated_queue_buffers_storage() and
>   vb2_core_free_queue_buffers_storage() to avoid duplicate code.
>  .../media/common/videobuf2/videobuf2-core.c   | 71 ++++++++++++++-----
>  include/media/videobuf2-core.h                | 18 +++--
>  2 files changed, 64 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
> index fd5ac2845018..45cbdfaf72b5 100644
> --- a/drivers/media/common/videobuf2/videobuf2-core.c
> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> @@ -421,11 +421,12 @@ static void init_buffer_cache_hints(struct vb2_queue *q, struct vb2_buffer *vb)
>   */
>  static void vb2_queue_add_buffer(struct vb2_queue *q, struct vb2_buffer *vb, unsigned int index)
>  {
> -	WARN_ON(index >= q->max_num_buffers || q->bufs[index] || vb->vb2_queue);
> +	WARN_ON(index >= q->max_num_buffers || test_bit(index, q->bufs_bitmap) || vb->vb2_queue);
>  
>  	q->bufs[index] = vb;
>  	vb->index = index;
>  	vb->vb2_queue = q;
> +	set_bit(index, q->bufs_bitmap);
>  }
>  
>  /**
> @@ -434,6 +435,7 @@ static void vb2_queue_add_buffer(struct vb2_queue *q, struct vb2_buffer *vb, uns
>   */
>  static void vb2_queue_remove_buffer(struct vb2_buffer *vb)
>  {
> +	clear_bit(vb->index, vb->vb2_queue->bufs_bitmap);
>  	vb->vb2_queue->bufs[vb->index] = NULL;
>  	vb->vb2_queue = NULL;
>  }
> @@ -452,9 +454,9 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
>  			     const unsigned int plane_sizes[VB2_MAX_PLANES],
>  			     unsigned int *first_index)
>  {
> -	unsigned int q_num_buffers = vb2_get_num_buffers(q);
>  	unsigned int buffer, plane;
>  	struct vb2_buffer *vb;
> +	unsigned long index = 0;

0 -> q->max_num_buffers

This ensure an error occurs in case num_buffers == 0 (which it should never
be, but you never know) with the 'while' code suggested below.

>  	int ret;
>  
>  	/*
> @@ -462,9 +464,25 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
>  	 * in the queue is below q->max_num_buffers
>  	 */
>  	num_buffers = min_t(unsigned int, num_buffers,
> -			    q->max_num_buffers - q_num_buffers);
> +			    q->max_num_buffers - vb2_get_num_buffers(q));
> +
> +again:
> +	index = bitmap_find_next_zero_area(q->bufs_bitmap, q->max_num_buffers,
> +					   0, num_buffers, 0);
> +
> +	/* Try to find free space for less buffers */
> +	if (index >= q->max_num_buffers && num_buffers) {
> +		num_buffers--;
> +		goto again;
> +	}

Hmm, this is really just a:

	while (num_buffers) {
		index = bitmap_find_next_zero_area(q->bufs_bitmap, q->max_num_buffers,
						   0, num_buffers, 0);

		if (index < q->max_num_buffers)
			break;
		/* Try to find free space for less buffers */
		num_buffers--;
	}

This avoids the ugly goto.

>  
> -	*first_index = q_num_buffers;
> +	/* If there is no space left to allocate buffers return 0 to indicate the error */
> +	if (index >= q->max_num_buffers) {
> +		*first_index = 0;
> +		return 0;
> +	}
> +
> +	*first_index = index;
>  
>  	for (buffer = 0; buffer < num_buffers; ++buffer) {
>  		/* Allocate vb2 buffer structures */
> @@ -484,7 +502,7 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
>  			vb->planes[plane].min_length = plane_sizes[plane];
>  		}
>  
> -		vb2_queue_add_buffer(q, vb, q_num_buffers + buffer);
> +		vb2_queue_add_buffer(q, vb, index++);
>  		call_void_bufop(q, init_buffer, vb);
>  
>  		/* Allocate video buffer memory for the MMAP type */
> @@ -664,7 +682,6 @@ static void __vb2_queue_free(struct vb2_queue *q, unsigned int buffers)
>  		kfree(vb);
>  	}
>  
> -	q->num_buffers -= buffers;
>  	if (!vb2_get_num_buffers(q)) {
>  		q->memory = VB2_MEMORY_UNKNOWN;
>  		INIT_LIST_HEAD(&q->queued_list);
> @@ -818,6 +835,32 @@ static bool verify_coherency_flags(struct vb2_queue *q, bool non_coherent_mem)
>  	return true;
>  }
>  
> +static int vb2_core_allocated_queue_buffers_storage(struct vb2_queue *q)

I think vb2_core_allocate_buffers_storage is a better name.

> +{
> +	if (!q->bufs)
> +		q->bufs = kcalloc(q->max_num_buffers, sizeof(*q->bufs), GFP_KERNEL);
> +	if (!q->bufs)
> +		return -ENOMEM;
> +
> +	if (!q->bufs_bitmap)
> +		q->bufs_bitmap = bitmap_zalloc(q->max_num_buffers, GFP_KERNEL);
> +	if (!q->bufs_bitmap) {
> +		kfree(q->bufs);
> +		q->bufs = NULL;
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +static void vb2_core_free_queue_buffers_storage(struct vb2_queue *q)

Drop the "_queue" part here as well.

> +{
> +	kfree(q->bufs);
> +	q->bufs = NULL;
> +	bitmap_free(q->bufs_bitmap);
> +	q->bufs_bitmap = NULL;
> +}
> +
>  int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
>  		     unsigned int flags, unsigned int *count)
>  {
> @@ -878,10 +921,7 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
>  	 * in the queue_setup op.
>  	 */
>  	mutex_lock(&q->mmap_lock);
> -	if (!q->bufs)
> -		q->bufs = kcalloc(q->max_num_buffers, sizeof(*q->bufs), GFP_KERNEL);
> -	if (!q->bufs)
> -		ret = -ENOMEM;
> +	ret = vb2_core_allocated_queue_buffers_storage(q);
>  	q->memory = memory;
>  	mutex_unlock(&q->mmap_lock);
>  	if (ret)
> @@ -953,7 +993,6 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
>  	}
>  
>  	mutex_lock(&q->mmap_lock);
> -	q->num_buffers = allocated_buffers;
>  
>  	if (ret < 0) {
>  		/*
> @@ -980,6 +1019,7 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
>  	mutex_lock(&q->mmap_lock);
>  	q->memory = VB2_MEMORY_UNKNOWN;
>  	mutex_unlock(&q->mmap_lock);
> +	vb2_core_free_queue_buffers_storage(q);
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(vb2_core_reqbufs);
> @@ -1013,11 +1053,8 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
>  		 * value in the queue_setup op.
>  		 */
>  		mutex_lock(&q->mmap_lock);
> +		ret = vb2_core_allocated_queue_buffers_storage(q);
>  		q->memory = memory;
> -		if (!q->bufs)
> -			q->bufs = kcalloc(q->max_num_buffers, sizeof(*q->bufs), GFP_KERNEL);
> -		if (!q->bufs)
> -			ret = -ENOMEM;
>  		mutex_unlock(&q->mmap_lock);
>  		if (ret)
>  			return ret;
> @@ -1080,7 +1117,6 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
>  	}
>  
>  	mutex_lock(&q->mmap_lock);
> -	q->num_buffers += allocated_buffers;
>  
>  	if (ret < 0) {
>  		/*
> @@ -2579,8 +2615,7 @@ void vb2_core_queue_release(struct vb2_queue *q)
>  	__vb2_queue_cancel(q);
>  	mutex_lock(&q->mmap_lock);
>  	__vb2_queue_free(q, vb2_get_num_buffers(q));
> -	kfree(q->bufs);
> -	q->bufs = NULL;
> +	vb2_core_free_queue_buffers_storage(q);
>  	mutex_unlock(&q->mmap_lock);
>  }
>  EXPORT_SYMBOL_GPL(vb2_core_queue_release);
> diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
> index e29ff77814d3..8647eee348bd 100644
> --- a/include/media/videobuf2-core.h
> +++ b/include/media/videobuf2-core.h
> @@ -346,8 +346,8 @@ struct vb2_buffer {
>   *			describes the requested number of planes and sizes\[\]
>   *			contains the requested plane sizes. In this case
>   *			\*num_buffers are being allocated additionally to
> - *			q->num_buffers. If either \*num_planes or the requested
> - *			sizes are invalid callback must return %-EINVAL.
> + *			the buffers already allocated. If either \*num_planes
> + *			or the requested sizes are invalid callback must return %-EINVAL.
>   * @wait_prepare:	release any locks taken while calling vb2 functions;
>   *			it is called before an ioctl needs to wait for a new
>   *			buffer to arrive; required to avoid a deadlock in
> @@ -571,8 +571,9 @@ struct vb2_buf_ops {
>   * @mmap_lock:	private mutex used when buffers are allocated/freed/mmapped
>   * @memory:	current memory type used
>   * @dma_dir:	DMA mapping direction.
> - * @bufs:	videobuf2 buffer structures
> - * @num_buffers: number of allocated/used buffers
> + * @bufs:	videobuf2 buffer structures. If it is non-NULL then
> + *		bufs_bitmap is also non-NULL.
> + * @bufs_bitmap: bitmap tracking whether each bufs[] entry is used
>   * @max_num_buffers: upper limit of number of allocated/used buffers.
>   *		     If set to 0 v4l2 core will change it VB2_MAX_FRAME
>   *		     for backward compatibility.
> @@ -639,7 +640,7 @@ struct vb2_queue {
>  	unsigned int			memory;
>  	enum dma_data_direction		dma_dir;
>  	struct vb2_buffer		**bufs;
> -	unsigned int			num_buffers;
> +	unsigned long			*bufs_bitmap;
>  	unsigned int			max_num_buffers;
>  
>  	struct list_head		queued_list;
> @@ -1168,7 +1169,10 @@ static inline bool vb2_fileio_is_active(struct vb2_queue *q)
>   */
>  static inline unsigned int vb2_get_num_buffers(struct vb2_queue *q)
>  {
> -	return q->num_buffers;
> +	if (q->bufs_bitmap)
> +		return bitmap_weight(q->bufs_bitmap, q->max_num_buffers);
> +
> +	return 0;
>  }
>  
>  /**
> @@ -1277,7 +1281,7 @@ static inline struct vb2_buffer *vb2_get_buffer(struct vb2_queue *q,
>  	if (index >= q->max_num_buffers)
>  		return NULL;
>  
> -	if (index < q->num_buffers)
> +	if (test_bit(index, q->bufs_bitmap))
>  		return q->bufs[index];
>  	return NULL;
>  }

Regards,

	Hans

