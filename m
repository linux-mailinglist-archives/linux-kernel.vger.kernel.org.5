Return-Path: <linux-kernel+bounces-26163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F12482DC2A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8519B1C21D0B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7707417981;
	Mon, 15 Jan 2024 15:14:39 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA38C17732;
	Mon, 15 Jan 2024 15:14:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD3C3C43394;
	Mon, 15 Jan 2024 15:14:36 +0000 (UTC)
Message-ID: <bba1e67f-3ce4-4b90-b402-543faf239b3c@xs4all.nl>
Date: Mon, 15 Jan 2024 16:14:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 4/8] media: core: Add bitmap manage bufs array entries
Content-Language: en-US, nl
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>, mchehab@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 kernel@collabora.com
References: <20231215090813.15610-1-benjamin.gaignard@collabora.com>
 <20231215090813.15610-5-benjamin.gaignard@collabora.com>
 <94e9f612-5daf-414a-a8b9-26330e697884@xs4all.nl>
 <8f683397-f0e2-4701-9a4b-5b5c32d25915@collabora.com>
From: Hans Verkuil <hverkuil@xs4all.nl>
Autocrypt: addr=hverkuil@xs4all.nl; keydata=
 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
In-Reply-To: <8f683397-f0e2-4701-9a4b-5b5c32d25915@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 15/01/2024 15:51, Benjamin Gaignard wrote:
> 
> Le 15/01/2024 à 13:21, Hans Verkuil a écrit :
>> On 15/12/2023 10:08, Benjamin Gaignard wrote:
>>> Add a bitmap field to know which of bufs array entries are
>>> used or not.
>>> Remove no more used num_buffers field from queue structure.
>>> Use bitmap_find_next_zero_area() to find the first possible
>>> range when creating new buffers to fill the gaps.
>>>
>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>>> ---
>>>   .../media/common/videobuf2/videobuf2-core.c   | 37 ++++++++++++++++---
>>>   include/media/videobuf2-core.h                | 17 +++++----
>>>   2 files changed, 41 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
>>> index cd2b9e51b9b0..9509535a980c 100644
>>> --- a/drivers/media/common/videobuf2/videobuf2-core.c
>>> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
>>> @@ -421,11 +421,12 @@ static void init_buffer_cache_hints(struct vb2_queue *q, struct vb2_buffer *vb)
>>>    */
>>>   static void vb2_queue_add_buffer(struct vb2_queue *q, struct vb2_buffer *vb, unsigned int index)
>>>   {
>>> -    WARN_ON(index >= q->max_num_buffers || q->bufs[index] || vb->vb2_queue);
>>> +    WARN_ON(index >= q->max_num_buffers || test_bit(index, q->bufs_bitmap) || vb->vb2_queue);
>>>         q->bufs[index] = vb;
>>>       vb->index = index;
>>>       vb->vb2_queue = q;
>>> +    set_bit(index, q->bufs_bitmap);
>>>   }
>>>     /**
>>> @@ -434,6 +435,7 @@ static void vb2_queue_add_buffer(struct vb2_queue *q, struct vb2_buffer *vb, uns
>>>    */
>>>   static void vb2_queue_remove_buffer(struct vb2_buffer *vb)
>>>   {
>>> +    clear_bit(vb->index, vb->vb2_queue->bufs_bitmap);
>>>       vb->vb2_queue->bufs[vb->index] = NULL;
>>>       vb->vb2_queue = NULL;
>>>   }
>>> @@ -462,7 +464,8 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
>>>       num_buffers = min_t(unsigned int, num_buffers,
>>>                   q->max_num_buffers - vb2_get_num_buffers(q));
>>>   -    index = vb2_get_num_buffers(q);
>>> +    index = bitmap_find_next_zero_area(q->bufs_bitmap, q->max_num_buffers,
>>> +                       0, num_buffers, 0);
>> Shouldn't this check if this call fails to find an area of 'num_buffers' 0-bits?
>> Or, alternatively, keep reducing num_buffers until it finds a free range. I'm
>> not sure what is best.
> 
> I will add a check on the return value. If it can't allocate the requested number of buffers
> it will fail. Userspace can decide if it wants to try allocated less buffers or not.

I'm not sure if that's the right solution. Currently create_bufs (and reqbufs for that matter)
will reduce the number of requested buffers if not all can be allocated. E.g. if you
want 10 buffers, but there is memory for only 5, then it will still allocate but it
returns 'count' with value 5.

Shouldn't that happen with this as well? The documentation is quite explicit that
you might get fewer buffers than requested.

> 
>>>         *first_index = index;
>>>   @@ -664,7 +667,6 @@ static void __vb2_queue_free(struct vb2_queue *q, unsigned int buffers)
>>>           kfree(vb);
>>>       }
>>>   -    q->num_buffers -= buffers;
>>>       if (!vb2_get_num_buffers(q)) {
>>>           q->memory = VB2_MEMORY_UNKNOWN;
>>>           INIT_LIST_HEAD(&q->queued_list);
>>> @@ -882,6 +884,14 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
>>>           q->bufs = kcalloc(q->max_num_buffers, sizeof(*q->bufs), GFP_KERNEL);
>>>       if (!q->bufs)
>>>           ret = -ENOMEM;
>>> +
>>> +    if (!q->bufs_bitmap)
>>> +        q->bufs_bitmap = bitmap_zalloc(q->max_num_buffers, GFP_KERNEL);
>>> +    if (!q->bufs_bitmap) {
>>> +        ret = -ENOMEM;
>>> +        kfree(q->bufs);
>>> +        q->bufs = NULL;
>>> +    }
>>>       q->memory = memory;
>>>       mutex_unlock(&q->mmap_lock);
>>>       if (ret)
>>> @@ -951,7 +961,6 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
>>>       }
>>>         mutex_lock(&q->mmap_lock);
>>> -    q->num_buffers = allocated_buffers;
>>>         if (ret < 0) {
>>>           /*
>>> @@ -978,6 +987,10 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
>>>       mutex_lock(&q->mmap_lock);
>>>       q->memory = VB2_MEMORY_UNKNOWN;
>>>       mutex_unlock(&q->mmap_lock);
>>> +    kfree(q->bufs);
>>> +    q->bufs = NULL;
>>> +    bitmap_free(q->bufs_bitmap);
>>> +    q->bufs_bitmap = NULL;
>>>       return ret;
>>>   }
>>>   EXPORT_SYMBOL_GPL(vb2_core_reqbufs);
>>> @@ -1014,9 +1027,19 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
>>>           q->memory = memory;
>>>           if (!q->bufs)
>>>               q->bufs = kcalloc(q->max_num_buffers, sizeof(*q->bufs), GFP_KERNEL);
>>> -        if (!q->bufs)
>>> +        if (!q->bufs) {
>>>               ret = -ENOMEM;
>>> +            goto unlock;
>>> +        }
>>> +        if (!q->bufs_bitmap)
>>> +            q->bufs_bitmap = bitmap_zalloc(q->max_num_buffers, GFP_KERNEL);
>>> +        if (!q->bufs_bitmap) {
>>> +            ret = -ENOMEM;
>>> +            kfree(q->bufs);
>>> +            q->bufs = NULL;
>>> +        }
>> The same code is used in reqbufs and create_bufs, so perhaps creating a helper
>> function is better.
> 
> I will add vb2_core_allocated_queue_buffers_storage() and vb2_core_free_queue_buffers_storage().
> 
>>
>>>           mutex_unlock(&q->mmap_lock);
>>> +unlock:
>>>           if (ret)
>>>               return ret;
>>>           q->waiting_for_buffers = !q->is_output;
>>> @@ -1078,7 +1101,6 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
>>>       }
>>>         mutex_lock(&q->mmap_lock);
>>> -    q->num_buffers += allocated_buffers;
>>>         if (ret < 0) {
>>>           /*
>>> @@ -2567,6 +2589,9 @@ void vb2_core_queue_release(struct vb2_queue *q)
>>>       __vb2_queue_free(q, vb2_get_num_buffers(q));
>>>       kfree(q->bufs);
>>>       q->bufs = NULL;
>>> +    bitmap_free(q->bufs_bitmap);
>>> +    q->bufs_bitmap = NULL;
>>> +
>> And perhaps also a helper function to free the memory.
>>
>>>       mutex_unlock(&q->mmap_lock);
>>>   }
>>>   EXPORT_SYMBOL_GPL(vb2_core_queue_release);
>>> diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
>>> index 607f2ba7a905..e4c1fc7ae82f 100644
>>> --- a/include/media/videobuf2-core.h
>>> +++ b/include/media/videobuf2-core.h
>>> @@ -346,8 +346,8 @@ struct vb2_buffer {
>>>    *            describes the requested number of planes and sizes\[\]
>>>    *            contains the requested plane sizes. In this case
>>>    *            \*num_buffers are being allocated additionally to
>>> - *            q->num_buffers. If either \*num_planes or the requested
>>> - *            sizes are invalid callback must return %-EINVAL.
>>> + *            the buffers already in the queue. If either \*num_planes
>> already in the queue -> already allocated
>>
>>> + *            or the requested sizes are invalid callback must return %-EINVAL.
>>>    * @wait_prepare:    release any locks taken while calling vb2 functions;
>>>    *            it is called before an ioctl needs to wait for a new
>>>    *            buffer to arrive; required to avoid a deadlock in
>>> @@ -572,7 +572,7 @@ struct vb2_buf_ops {
>>>    * @memory:    current memory type used
>>>    * @dma_dir:    DMA mapping direction.
>>>    * @bufs:    videobuf2 buffer structures
>>> - * @num_buffers: number of allocated/used buffers
>>> + * @bufs_bitmap: bitmap tracking whether each bufs[] entry is used
>>>    * @max_num_buffers: upper limit of number of allocated/used buffers.
>>>    *             If set to 0 v4l2 core will change it VB2_MAX_FRAME
>>>    *             for backward compatibility.
>>> @@ -639,7 +639,7 @@ struct vb2_queue {
>>>       unsigned int            memory;
>>>       enum dma_data_direction        dma_dir;
>>>       struct vb2_buffer        **bufs;
>>> -    unsigned int            num_buffers;
>>> +    unsigned long            *bufs_bitmap;
>>>       unsigned int            max_num_buffers;
>>>         struct list_head        queued_list;
>>> @@ -1168,7 +1168,10 @@ static inline bool vb2_fileio_is_active(struct vb2_queue *q)
>>>    */
>>>   static inline unsigned int vb2_get_num_buffers(struct vb2_queue *q)
>>>   {
>>> -    return q->num_buffers;
>>> +    if (!q->bufs_bitmap)
>>> +        return 0;
>>> +
>>> +    return bitmap_weight(q->bufs_bitmap, q->max_num_buffers);
>> I'd invert the test:
>>
>>     if (q->bufs_bitmap)
>>         return bitmap_weight(q->bufs_bitmap, q->max_num_buffers);
>>     return 0;
>>
>> It's a little bit easier to read.
>>
>>>   }
>>>     /**
>>> @@ -1271,13 +1274,13 @@ static inline void vb2_clear_last_buffer_dequeued(struct vb2_queue *q)
>>>   static inline struct vb2_buffer *vb2_get_buffer(struct vb2_queue *q,
>>>                           unsigned int index)
>>>   {
>>> -    if (!q->bufs)
>>> +    if (!q->bufs_bitmap)
>> Can you ever have q->bufs set, but not q->bufs_bitmap?
>>
>> I think the original check is just fine.
>>
>> It is probably a good idea to perhaps clarify this in the @bufs documentation:
>> if it is non-NULL, then bufs_bitmap is also non-NULL.
>>
>> And ensure that where you allocate and assign these fields that bufs_bitmap
>> is always non-NULL when assigning q->bufs. Then it is enough to just test
>> q->bufs to be certain both bufs and bufs_bitmap are non-NULL.
> 
> I will add that in the documentation.
> 
>>
>>>           return NULL;
>>>         if (index >= q->max_num_buffers)
>>>           return NULL;
>>>   -    if (index < q->num_buffers)
>>> +    if (test_bit(index, q->bufs_bitmap))
>>>           return q->bufs[index];
>>>       return NULL;
>>>   }
>> Adding support for deleting buffers also causes a odd change in behavior
>> of CREATE_BUFS w.r.t. the index field of struct v4l2_create_buffers:
>> when adding new buffers, the index field is indeed the starting buffer index,
>> as per the documentation. But if count == 0, then the index field returns
>> the total number of allocated buffers, which is really something different.
>>
>> I think the documentation of VIDIOC_CREATE_BUFS should be updated to clearly
>> state that if count == 0, then 'index' is set to the total number of
>> allocated buffers.
>>
>> I really hate VIDIOC_CREATE_BUFS, and I do plan an RFC with a proposal for
>> an alternative API.
>>
>> Regards,
>>
>>     Hans
>>

Regards,

	Hans

