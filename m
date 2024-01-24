Return-Path: <linux-kernel+bounces-37280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD9183ADAF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F20DF1F2966B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B157C0B3;
	Wed, 24 Jan 2024 15:46:19 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2797A73A;
	Wed, 24 Jan 2024 15:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706111178; cv=none; b=DwR1+uJw1UIuhzNU34WIcje04mu5b7v0X8ukhzMMyzNQXJlstxwpEhRNEtAg8kGJKtSizTAdThcvLcmJ9vKNM7XxatD8r2VmpjpMAu7x8qsvZkXw/hOdIIqwn6w0Z4WwUkYbp69/mvkjgHN3oKFzDTzrjJKCtBnGCl33mS17So8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706111178; c=relaxed/simple;
	bh=vJesdi7ca74BPdLuqPw2Sjr91+X8YILlJiDBJaMnBa4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lCdWVtgjm5b04OHEFrbSpCkzl0zCZTqH6HufDl0fdvvdkwXlAHzy+EJfsBcMAHov+/UAkfd3+joEzWA+sKd+D+lqKKzyZVKjcIrxeKvExlLTr34p0skWP25+nFckFJE6BbhklU4XVmBPWObMZLNxIiSbkz5a3e5U8k2mzDugv2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B5FEC433C7;
	Wed, 24 Jan 2024 15:46:17 +0000 (UTC)
Message-ID: <3f2d211c-2f7b-43be-89c3-a5afcb211a06@xs4all.nl>
Date: Wed, 24 Jan 2024 16:46:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 6/8] media: v4l2: Add DELETE_BUFS ioctl
Content-Language: en-US, nl
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>, mchehab@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 kernel@collabora.com
References: <20240119094944.26763-1-benjamin.gaignard@collabora.com>
 <20240119094944.26763-7-benjamin.gaignard@collabora.com>
 <8a19487d-e903-4961-b56b-42079c9362b3@xs4all.nl>
 <81d8f73a-9a9c-445d-a6f5-e1358bf945a6@collabora.com>
From: Hans Verkuil <hverkuil@xs4all.nl>
Autocrypt: addr=hverkuil@xs4all.nl; keydata=
 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
In-Reply-To: <81d8f73a-9a9c-445d-a6f5-e1358bf945a6@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 24/01/2024 16:35, Benjamin Gaignard wrote:
> 
> Le 24/01/2024 à 13:33, Hans Verkuil a écrit :
>> On 19/01/2024 10:49, Benjamin Gaignard wrote:
>>> VIDIOC_DELETE_BUFS ioctl allows to delete buffers from a queue.
>>> The number of buffers to delete in given by count field of
>>> struct v4l2_delete_buffers and the range start at the index
>>> specified in the same structure.
>>>
>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>>> ---
>>> version 17:
>>> - rework DELETE_BUFS documentation
>>>
>>>   .../userspace-api/media/v4l/user-func.rst     |  1 +
>>>   .../media/v4l/vidioc-delete-bufs.rst          | 80 +++++++++++++++++++
>>>   .../media/v4l/vidioc-reqbufs.rst              |  1 +
>>>   .../media/common/videobuf2/videobuf2-core.c   | 42 ++++++++++
>>>   .../media/common/videobuf2/videobuf2-v4l2.c   | 20 +++++
>>>   drivers/media/v4l2-core/v4l2-dev.c            |  1 +
>>>   drivers/media/v4l2-core/v4l2-ioctl.c          | 20 +++++
>>>   include/media/v4l2-ioctl.h                    |  4 +
>>>   include/media/videobuf2-core.h                | 12 +++
>>>   include/media/videobuf2-v4l2.h                | 13 +++
>>>   include/uapi/linux/videodev2.h                | 17 ++++
>>>   11 files changed, 211 insertions(+)
>>>   create mode 100644 Documentation/userspace-api/media/v4l/vidioc-delete-bufs.rst
>>>
>>> diff --git a/Documentation/userspace-api/media/v4l/user-func.rst b/Documentation/userspace-api/media/v4l/user-func.rst
>>> index 15ff0bf7bbe6..3fd567695477 100644
>>> --- a/Documentation/userspace-api/media/v4l/user-func.rst
>>> +++ b/Documentation/userspace-api/media/v4l/user-func.rst
>>> @@ -17,6 +17,7 @@ Function Reference
>>>       vidioc-dbg-g-chip-info
>>>       vidioc-dbg-g-register
>>>       vidioc-decoder-cmd
>>> +    vidioc-delete-bufs
>>>       vidioc-dqevent
>>>       vidioc-dv-timings-cap
>>>       vidioc-encoder-cmd
>>> diff --git a/Documentation/userspace-api/media/v4l/vidioc-delete-bufs.rst b/Documentation/userspace-api/media/v4l/vidioc-delete-bufs.rst
>>> new file mode 100644
>>> index 000000000000..d409063ceb3f
>>> --- /dev/null
>>> +++ b/Documentation/userspace-api/media/v4l/vidioc-delete-bufs.rst
>>> @@ -0,0 +1,80 @@
>>> +.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
>>> +.. c:namespace:: V4L
>>> +
>>> +.. _VIDIOC_DELETE_BUFS:
>>> +
>>> +************************
>>> +ioctl VIDIOC_DELETE_BUFS
>>> +************************
>>> +
>>> +Name
>>> +====
>>> +
>>> +VIDIOC_DELETE_BUFS - Deletes buffers from a queue
>>> +
>>> +Synopsis
>>> +========
>>> +
>>> +.. c:macro:: VIDIOC_DELETE_BUFs
>>> +
>>> +``int ioctl(int fd, VIDIOC_DELETE_BUFs, struct v4l2_delete_buffers *argp)``
>>> +
>>> +Arguments
>>> +=========
>>> +
>>> +``fd``
>>> +    File descriptor returned by :c:func:`open()`.
>>> +
>>> +``argp``
>>> +    Pointer to struct :c:type:`v4l2_delete_buffers`.
>>> +
>>> +Description
>>> +===========
>>> +
>>> +Applications can optionally call the :ref:`VIDIOC_DELETE_BUFS` ioctl to
>>> +delete buffers from a queue.
>>> +This ioctl is available if the ``V4L2_BUF_CAP_SUPPORTS_DELETE_BUFS`` capability
>>> +is set on the queue when :c:func:`VIDIOC_REQBUFS` or :c:func:`VIDIOC_CREATE_BUFS`
>>> +are invoked.
>>> +
>>> +.. c:type:: v4l2_delete_buffers
>>> +
>>> +.. tabularcolumns:: |p{4.4cm}|p{4.4cm}|p{8.5cm}|
>>> +
>>> +.. flat-table:: struct v4l2_delete_buffers
>>> +    :header-rows:  0
>>> +    :stub-columns: 0
>>> +    :widths:       1 1 2
>>> +
>>> +    * - __u32
>>> +      - ``index``
>>> +      - The starting buffer index to delete.
>>> +    * - __u32
>>> +      - ``count``
>>> +      - The number of buffers to be deleted with indices 'index' until 'index + count - 1'.
>>> +        All buffers in this range must be valid and in DEQUEUED state.
>>> +        If count is set to 0 :ref:`VIDIOC_DELETE_BUFS` will do nothing and return 0.
>>> +    * - __u32
>>> +      - ``type``
>>> +      - Type of the stream or buffers, this is the same as the struct
>>> +    :c:type:`v4l2_format` ``type`` field. See
>>> +    :c:type:`v4l2_buf_type` for valid values.
>>> +    * - __u32
>>> +      - ``reserved``\ [13]
>>> +      - A place holder for future extensions. Drivers and applications
>>> +    must set the array to zero.
>>> +
>>> +Return Value
>>> +============
>>> +
>>> +On success 0 is returned, on error -1 and the ``errno`` variable is set
>>> +appropriately. The generic error codes are described at the
>>> +:ref:`Generic Error Codes <gen-errors>` chapter.
>>> +
>>> +EBUSY
>>> +    File I/O is in progress.
>>> +    Any buffer in range ``index`` to ``index + count - 1`` is not in
>>> +    DEQUEUED state.
>>> +
>>> +EINVAL
>>> +    Any buffer in range ``index`` to ``index + count - 1`` doesn't exist in the queue.
>>> diff --git a/Documentation/userspace-api/media/v4l/vidioc-reqbufs.rst b/Documentation/userspace-api/media/v4l/vidioc-reqbufs.rst
>>> index 0b3a41a45d05..14d4a49c2945 100644
>>> --- a/Documentation/userspace-api/media/v4l/vidioc-reqbufs.rst
>>> +++ b/Documentation/userspace-api/media/v4l/vidioc-reqbufs.rst
>>> @@ -121,6 +121,7 @@ aborting or finishing any DMA in progress, an implicit
>>>   .. _V4L2-BUF-CAP-SUPPORTS-M2M-HOLD-CAPTURE-BUF:
>>>   .. _V4L2-BUF-CAP-SUPPORTS-MMAP-CACHE-HINTS:
>>>   .. _V4L2-BUF-CAP-SUPPORTS-MAX-NUM-BUFFERS:
>>> +.. _V4L2-BUF-CAP-SUPPORTS-DELETE-BUFS:
>>>     .. raw:: latex
>>>   diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
>>> index 010505ed92e8..99e631233a54 100644
>>> --- a/drivers/media/common/videobuf2/videobuf2-core.c
>>> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
>>> @@ -1688,6 +1688,48 @@ int vb2_core_prepare_buf(struct vb2_queue *q, struct vb2_buffer *vb, void *pb)
>>>   }
>>>   EXPORT_SYMBOL_GPL(vb2_core_prepare_buf);
>>>   +int vb2_core_delete_bufs(struct vb2_queue *q, unsigned int start, unsigned int count)
>>> +{
>>> +    unsigned int i, ret = 0;
>>> +    unsigned int q_num_bufs = vb2_get_num_buffers(q);
>>> +
>>> +    if (count == 0)
>>> +        return 0;
>>> +
>>> +    if (count > q_num_bufs)
>>> +        return -EINVAL;
>>> +
>>> +    if (start + count > q->max_num_buffers)
>> Change this to:
>>
>>     if (start > q->max_num_buffers - count)
>>
>> This avoids the corner case where 'start + count' overflows the unsigned int.
>>
>>> +        return -EINVAL;
>>> +
>>> +    /* If streaming keep at least min_queued_buffers + 1 buffers */
>>> +    if (q->streaming && (q_num_bufs - count < q->min_queued_buffers + 1))
>>> +        return -EINVAL;
>> I would drop this. This will be caught automatically by the next check
>> since if a driver needs q->min_queued_buffers to start the DMA, then
>> once the DMA stated there will always be that amount of buffers in a
>> non-DEQUEUED state.
>>
>>> +
>>> +    mutex_lock(&q->mmap_lock);
>>> +
>>> +    /* Check that all buffers in the range exist */
>>> +    for (i = start; i < start + count; i++) {
>>> +        struct vb2_buffer *vb = vb2_get_buffer(q, i);
>>> +
>>> +        if (!vb) {
>>> +            ret = -EINVAL;
>>> +            goto unlock;
>>> +        }
>>> +        if (vb->state != VB2_BUF_STATE_DEQUEUED) {
>>> +            ret = -EBUSY;
>>> +            goto unlock;
>>> +        }
>>> +    }
>>> +    __vb2_queue_free(q, start, count);
>>> +    dprintk(q, 2, "%u buffers deleted\n", count);
>>> +
>>> +unlock:
>>> +    mutex_unlock(&q->mmap_lock);
>>> +    return ret;
>>> +}
>>> +EXPORT_SYMBOL_GPL(vb2_core_delete_bufs);
>> There is one specific corner case here that needs attention: if ALL buffers
>> are deleted (something that is possible if STREAMON was called, but no
>> buffers are queued), then vb2_is_busy will suddenly return false.
>>
>> This can have all sorts of subtle consequences since it is now possible
>> to, for example, change the format.
>>
>> There are two options here:
>>
>> 1) vb2_is_busy() shouldn't check if there are buffers allocated, instead it
>>     should check if buffers were allocated at least once. So calling REQBUFS
>>     or CREATE_BUFS for the first time will set a flag to 1, until you call
>>     REQBUFS with count 0, or close the filehandle. Deleting all buffers with
>>     DELETE_BUFS will not change that.
> 
> I will go for this option and add a patch at the beginning of the series.
> 
>>
>> 2) We treat deleting all buffers with DELETE_BUFS the same as calling REQBUFS(0),
>>     in which case the code above needs to change.
>>
>> I lean towards option 1. My reasoning is that REQBUFS does an implicit STREAMOFF,
>> and DELETE_BUFS does not and I do not think DELETE_BUFS should allow vb2_is_busy()
>> to become false. It would still be nice if it can delete all buffers, but we
>> would have to check if there are no other places where the number of allocated
>> buffers is checked, when perhaps it really should use vb2_is_busy() instead.
>>
>>> +
>>>   /*
>>>    * vb2_start_streaming() - Attempt to start streaming.
>>>    * @q:        videobuf2 queue
>>> diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
>>> index 03e8080a68a8..626b5283dfdb 100644
>>> --- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
>>> +++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
>>> @@ -698,6 +698,8 @@ static void vb2_set_flags_and_caps(struct vb2_queue *q, u32 memory,
>>>           *caps |= V4L2_BUF_CAP_SUPPORTS_MMAP_CACHE_HINTS;
>>>       if (q->supports_requests)
>>>           *caps |= V4L2_BUF_CAP_SUPPORTS_REQUESTS;
>>> +    if (q->supports_delete_bufs)
>>> +        *caps |= V4L2_BUF_CAP_SUPPORTS_DELETE_BUFS;
>>>       if (max_num_bufs) {
>>>           *max_num_bufs = q->max_num_buffers;
>>>           *caps |= V4L2_BUF_CAP_SUPPORTS_MAX_NUM_BUFFERS;
>>> @@ -743,6 +745,12 @@ int vb2_prepare_buf(struct vb2_queue *q, struct media_device *mdev,
>>>   }
>>>   EXPORT_SYMBOL_GPL(vb2_prepare_buf);
>>>   +int vb2_delete_bufs(struct vb2_queue *q, struct v4l2_delete_buffers *d)
>>> +{
>>> +    return vb2_core_delete_bufs(q, d->index, d->count);
>>> +}
>>> +EXPORT_SYMBOL_GPL(vb2_delete_bufs);
>>> +
>> I would not add this. Drivers that want to support this should implement
>> vb2_ioctl_delete_bufs(). Eventually I want to get away from these non-vb2_ioctl_
>> functions.
> 
> I need it for v4l2_m2m_ioctl_delete_bufs() implementation because the targeted
> queue depends of the context.

I would prefer that v4l2_m2m_ioctl_delete_bufs() calls vb2_core_delete_bufs()
directly. vb2_delete_bufs is really just a wrapper around that anyway.

Regards,

	Hans

