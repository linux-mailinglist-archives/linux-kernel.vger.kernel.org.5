Return-Path: <linux-kernel+bounces-56385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D88FF84C98B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C2981F25200
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A231AADB;
	Wed,  7 Feb 2024 11:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PjisdU24"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F59E182A7;
	Wed,  7 Feb 2024 11:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707304971; cv=none; b=Vf0i35u3WH1U0llJcEfIsILDPtGc/sI2CEhpqovZu/M2MCekAxHZjjaNxvwdcUEh+7s433oK2cyNGnmVNQnaqp64WRI/7w54/05oJY0u9CyFhWnGdruoRfTCrwMWv5vK0tqhJsoxuc/jO/EBVKKpVq899gFv+AB3Uir7QdgWtmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707304971; c=relaxed/simple;
	bh=J35yOnxIj4zbmc/I04JW3XLI50tfpHXJ5MOqLVr19xM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q19nUYFQpO6fCUG95ytE2LxGdz/uVuKi/jR8rpAgcDNG7ZRK0BcTFlUa20+QZc7KBftN+AW4o/p5GYqmksqF2LrfNfSQEoKXDBQqgpwfoIiFZcVk/gzDTIL1ISgd1PDl1n16/57mADHwZUu9WUGf8dfMF9pdfl/sG5Ow36G2zD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PjisdU24; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707304967;
	bh=J35yOnxIj4zbmc/I04JW3XLI50tfpHXJ5MOqLVr19xM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PjisdU24hA0DWwqpNNg2aWhO7kUIgqelgh//n/DDdqu1CwcBrGC0Riu5+sfaUJuCZ
	 Q+zmazaUVCRXHsR/8DvLl2Lb5nZp/IiKAEx6UeDxg2VVo1UwncCxdU7l64pRnBR8Fi
	 JnsHi2fP1tqJ+VxVKGq+zTu1WAE7vC8/ZyilOxPajgv52W6vDqmvsQE4jxuhcZCmqy
	 5NvkfQlAQb0v0Qrn+OnCyOOGymlyc24xRcwNNl/P3hbaihnQIRWiPpKMHd8+0050pS
	 egPYP8vcoyJzietLM6+ht3+5efft5EwrH5cKIjq8za1zmpjKu6eoiAVz+GlgByIYcA
	 M9JLSvVa6/WpA==
Received: from [100.93.89.217] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1AC353782069;
	Wed,  7 Feb 2024 11:22:47 +0000 (UTC)
Message-ID: <c2c63cfd-4f43-4ecc-8258-1ba91ac39412@collabora.com>
Date: Wed, 7 Feb 2024 12:22:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 0/9] Add DELETE_BUF ioctl
Content-Language: en-US
To: Hans Verkuil <hverkuil@xs4all.nl>, mchehab@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 kernel@collabora.com
References: <20240206080219.11951-1-benjamin.gaignard@collabora.com>
 <dcafb602-228f-439f-99d2-010d26a23ad1@xs4all.nl>
 <67823e2e-9d60-4c08-bdd1-c974aaf96a93@xs4all.nl>
 <e7420a20-b17d-493e-9b3c-bbb9314d7025@collabora.com>
 <c2bbab59-1b07-4a3c-985c-be01836af756@xs4all.nl>
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <c2bbab59-1b07-4a3c-985c-be01836af756@xs4all.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Le 07/02/2024 à 12:20, Hans Verkuil a écrit :
> On 07/02/2024 12:15, Benjamin Gaignard wrote:
>> Le 07/02/2024 à 10:12, Hans Verkuil a écrit :
>>> Hi Benjamin,
>>>
>>> On 06/02/2024 09:58, Hans Verkuil wrote:
>>>> On 06/02/2024 09:02, Benjamin Gaignard wrote:
>>>>> Unlike when resolution change on keyframes, dynamic resolution change
>>>>> on inter frames doesn't allow to do a stream off/on sequence because
>>>>> it is need to keep all previous references alive to decode inter frames.
>>>>> This constraint have two main problems:
>>>>> - more memory consumption.
>>>>> - more buffers in use.
>>>>> To solve these issue this series introduce DELETE_BUFS ioctl and remove
>>>>> the 32 buffers limit per queue.
>>>> This v19 looks good. There are three outstanding issues that I need to take a
>>>> look at:
>>>>
>>>> 1) Can we still signal support for DELETE_BUFS in the V4L2_BUF_CAP_ caps?
>>>>      It would be nice to have, but I'm not sure if and how that can be done.
>>> So, I came up with the following patch to add back the V4L2_BUF_CAP_SUPPORTS_DELETE_BUFS
>>> capability. If the DELETE_BUFS ioctl is valid, then it sets this capability
>>> before calling vidioc_reqbufs or vidioc_create_bufs. So right now it will set
>>> this for any queue. If we ever want to disable this for a specific queue, then
>>> either the driver has to override these two ops and clear the flag, or a new
>>> vb2_queue flag (e.g. disable_delete_bufs) is added and vb2_set_flags_and_caps()
>>> will clear that capability based on that flag.
>>>
>>> In any case, for now just set it for both queues by default.
>>>
>>> If you agree that this is a good way to proceed, then can you incorporate this
>>> into a v20? You can add the documentation for this cap from the v17 version.
>> Do you want it to be a separate patch or included in the patch introducing DELETE_BUFS ioctl ?
> Up to you, whatever makes the most sense.

I will include it in DELETE_BUFS patch because it is strongly related to it.

Regards,
Benjamin

>
> Regards,
>
> 	Hans
>
>>> Regards,
>>>
>>>      Hans
>>>
>>> Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
>>> ---
>>> diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
>>> index 8e437104f9c1..64f2d662d068 100644
>>> --- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
>>> +++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
>>> @@ -685,7 +685,7 @@ static void vb2_set_flags_and_caps(struct vb2_queue *q, u32 memory,
>>>            *flags &= V4L2_MEMORY_FLAG_NON_COHERENT;
>>>        }
>>>
>>> -    *caps = V4L2_BUF_CAP_SUPPORTS_ORPHANED_BUFS;
>>> +    *caps |= V4L2_BUF_CAP_SUPPORTS_ORPHANED_BUFS;
>>>        if (q->io_modes & VB2_MMAP)
>>>            *caps |= V4L2_BUF_CAP_SUPPORTS_MMAP;
>>>        if (q->io_modes & VB2_USERPTR)
>>> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
>>> index a172d33edd19..45bc705e171e 100644
>>> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
>>> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
>>> @@ -2100,6 +2100,7 @@ static int v4l_overlay(const struct v4l2_ioctl_ops *ops,
>>>    static int v4l_reqbufs(const struct v4l2_ioctl_ops *ops,
>>>                    struct file *file, void *fh, void *arg)
>>>    {
>>> +    struct video_device *vfd = video_devdata(file);
>>>        struct v4l2_requestbuffers *p = arg;
>>>        int ret = check_fmt(file, p->type);
>>>
>>> @@ -2108,6 +2109,9 @@ static int v4l_reqbufs(const struct v4l2_ioctl_ops *ops,
>>>
>>>        memset_after(p, 0, flags);
>>>
>>> +    if (is_valid_ioctl(vfd, VIDIOC_DELETE_BUFS))
>>> +        p->capabilities = V4L2_BUF_CAP_SUPPORTS_DELETE_BUFS;
>>> +
>>>        return ops->vidioc_reqbufs(file, fh, p);
>>>    }
>>>
>>> @@ -2141,6 +2145,7 @@ static int v4l_dqbuf(const struct v4l2_ioctl_ops *ops,
>>>    static int v4l_create_bufs(const struct v4l2_ioctl_ops *ops,
>>>                    struct file *file, void *fh, void *arg)
>>>    {
>>> +    struct video_device *vfd = video_devdata(file);
>>>        struct v4l2_create_buffers *create = arg;
>>>        int ret = check_fmt(file, create->format.type);
>>>
>>> @@ -2151,6 +2156,9 @@ static int v4l_create_bufs(const struct v4l2_ioctl_ops *ops,
>>>
>>>        v4l_sanitize_format(&create->format);
>>>
>>> +    if (is_valid_ioctl(vfd, VIDIOC_DELETE_BUFS))
>>> +        create->capabilities = V4L2_BUF_CAP_SUPPORTS_DELETE_BUFS;
>>> +
>>>        ret = ops->vidioc_create_bufs(file, fh, create);
>>>
>>>        if (create->format.type == V4L2_BUF_TYPE_VIDEO_CAPTURE ||
>>> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
>>> index 03443833aaaa..da307f46f903 100644
>>> --- a/include/uapi/linux/videodev2.h
>>> +++ b/include/uapi/linux/videodev2.h
>>> @@ -1036,6 +1036,7 @@ struct v4l2_requestbuffers {
>>>    #define V4L2_BUF_CAP_SUPPORTS_M2M_HOLD_CAPTURE_BUF    (1 << 5)
>>>    #define V4L2_BUF_CAP_SUPPORTS_MMAP_CACHE_HINTS        (1 << 6)
>>>    #define V4L2_BUF_CAP_SUPPORTS_MAX_NUM_BUFFERS        (1 << 7)
>>> +#define V4L2_BUF_CAP_SUPPORTS_DELETE_BUFS        (1 << 8)
>>>
>>>    /**
>>>     * struct v4l2_plane - plane info for multi-planar buffers
>>>
>>>
>>>

