Return-Path: <linux-kernel+bounces-56393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C493084C99E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9F461C25A03
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2151A1B5BF;
	Wed,  7 Feb 2024 11:32:51 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733DC1B295;
	Wed,  7 Feb 2024 11:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707305570; cv=none; b=GutbZXjCad7Ll++M/gsqVZdntoUX6fczSO09jS2hDChFL82+6qwQaflEXiMJcLPmX7dn7S8KlMMu6/XCnfSP4QNKiDFFk8npGfQEyDeCTvR5zrdErwmvMeqBRJnTFcCPERiPSboaU63iQFO02XM1qp2enbVmVWOD/Ow0NxDHuHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707305570; c=relaxed/simple;
	bh=WkXdBZMgvymp13PrfFULoKdqHyQQgJ8yxdPfTokMK+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iR34ndc1hWypLCGbKHvG5PEpiFBKtUot5MIIMnPx1wxtmhp5ybhKVW9rcJI6aq9RAFhFC2JDKm8oLw3bBbLJYc4fNbX4xcwJzCqDhFiMhMwH+5XEoz+gzFTyFpwZEC1n/yzb0zwJzzLiXQ75qKhRIWLXYvwJbpxddvOtni25VZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EA83C433F1;
	Wed,  7 Feb 2024 11:32:48 +0000 (UTC)
Message-ID: <0916816d-a417-420c-b8f9-26b210bd6add@xs4all.nl>
Date: Wed, 7 Feb 2024 12:32:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 0/9] Add DELETE_BUF ioctl
Content-Language: en-US, nl
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>, mchehab@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 kernel@collabora.com
References: <20240206080219.11951-1-benjamin.gaignard@collabora.com>
 <dcafb602-228f-439f-99d2-010d26a23ad1@xs4all.nl>
 <63a46881-7fe8-4858-b0f7-cde33ffc7ea6@xs4all.nl>
 <9fda7e17-42e8-4b2e-8daf-f0e556934356@collabora.com>
From: Hans Verkuil <hverkuil@xs4all.nl>
Autocrypt: addr=hverkuil@xs4all.nl; keydata=
 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
In-Reply-To: <9fda7e17-42e8-4b2e-8daf-f0e556934356@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 07/02/2024 12:25, Benjamin Gaignard wrote:
> 
> Le 07/02/2024 à 11:28, Hans Verkuil a écrit :
>> On 06/02/2024 09:58, Hans Verkuil wrote:
>>> On 06/02/2024 09:02, Benjamin Gaignard wrote:
>>>> Unlike when resolution change on keyframes, dynamic resolution change
>>>> on inter frames doesn't allow to do a stream off/on sequence because
>>>> it is need to keep all previous references alive to decode inter frames.
>>>> This constraint have two main problems:
>>>> - more memory consumption.
>>>> - more buffers in use.
>>>> To solve these issue this series introduce DELETE_BUFS ioctl and remove
>>>> the 32 buffers limit per queue.
>>> This v19 looks good. There are three outstanding issues that I need to take a
>>> look at:
>>>
>>> 1) Can we still signal support for DELETE_BUFS in the V4L2_BUF_CAP_ caps?
>>>     It would be nice to have, but I'm not sure if and how that can be done.
>>>
>>> 2) I want to take another look at providing a next version of the VIDIOC_CREATE_BUFS
>>>     ioctl and how that would possibly influence the design of DELETE_BUFS.
>>>     Just to make sure we're not blocking anything or making life harder.
>> So I just tried creating a new version of the VIDIOC_CREATE_BUFS ioctl
>> that is greatly simplified. This just updates the header, no real code yet:
>>
>> Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
>> ---
>> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
>> index 03443833aaaa..a7398e4c85e7 100644
>> --- a/include/uapi/linux/videodev2.h
>> +++ b/include/uapi/linux/videodev2.h
>> @@ -2624,6 +2624,39 @@ struct v4l2_create_buffers {
>>       __u32            reserved[5];
>>   };
>>
>> +/**
>> + * struct v4l2_create_buffers_v2 - VIDIOC_CREATE_BUFFERS argument
>> + * @type:    enum v4l2_buf_type
>> + * @memory:    enum v4l2_memory; buffer memory type
>> + * @count:    entry: number of requested buffers,
>> + *        return: number of created buffers
>> + * @num_planes:    requested number of planes for each buffer
>> + * @sizes:    requested plane sizes for each buffer
>> + * @start_index:on return, index of the first created buffer
>> + * @total_count:on return, the total number of allocated buffers
>> + * @capabilities: capabilities of this buffer type.
>> + * @flags:    additional buffer management attributes (ignored unless the
>> + *        queue has V4L2_BUF_CAP_SUPPORTS_MMAP_CACHE_HINTS capability
>> + *        and configured for MMAP streaming I/O).
>> + * @max_num_buffers: if V4L2_BUF_CAP_SUPPORTS_MAX_NUM_BUFFERS capability flag is set
>> + *        this field indicate the maximum possible number of buffers
>> + *        for this queue.
>> + * @reserved:    future extensions
>> + */
>> +struct v4l2_create_buffers_v2 {
>> +    __u32            type;
>> +    __u32            memory;
>> +    __u32            count;
>> +    __u32            num_planes;
>> +    __u32            size[VIDEO_MAX_PLANES];
>> +    __u32            start_index;
>> +    __u32            total_count;
>> +    __u32            capabilities;
>> +    __u32            flags;
>> +    __u32            max_num_buffers;
>> +    __u32            reserved[7];
>> +};
>> +
>>   /**
>>    * struct v4l2_delete_buffers - VIDIOC_DELETE_BUFS argument
>>    * @index:    the first buffer to be deleted
>> @@ -2738,6 +2771,7 @@ struct v4l2_delete_buffers {
>>
>>   #define VIDIOC_QUERY_EXT_CTRL    _IOWR('V', 103, struct v4l2_query_ext_ctrl)
>>   #define VIDIOC_DELETE_BUFS    _IOWR('V', 104, struct v4l2_delete_buffers)
>> +#define VIDIOC_CREATE_BUFFERS    _IOWR('V', 105, struct v4l2_create_buffers_v2)
>>
>>
>>   /* Reminder: when adding new ioctls please add support for them to
>>
>>
>> Sadly, struct v4l2_create_buffers was already used for the existing
>> VIDIOC_CREATE_BUFS (I wish it was called v4l2_create_bufs...), so I did
>> have to add a _v2 suffix. Compared to the old struct it just moves the
>> type, num_planes and sizes from v4l2_format into the new struct and drops
>> the format field. Note that those fields are the only v4l2_format fields
>> that VIDIOC_CREATE_BUFS used, so getting rid of the format makes live
>> much easier. I also renamed 'index' to 'start_index' and added a new 'total_count'
>> field to report the total number of buffers.
>>
>> The reason for adding 'total_count' is that VIDIOC_CREATE_BUFS with
>> count == 0 would report the total number of buffers in the 'index' field,
>> which was rather odd. Adding a specific field for this purpose is nicer.
>>
>> One thing that might impact your series is the name of the ioctls.
>>
>> We have:
>>
>> VIDIOC_CREATE_BUFS/v4l2_create_buffers
>> VIDIOC_DELETE_BUFS/v4l2_delete_buffers
>> VIDIOC_CREATE_BUFFERS/v4l2_create_buffers_v2 (TBD)
>>
>> I'm wondering if VIDIOC_DELETE_BUFS should be renamed to
>> VIDIOC_DELETE_BUFFERS, that would make it more consistent with
>> the proposed VIDIOC_CREATE_BUFFERS.
>>
>> Alternatively, instead of calling it VIDIOC_CREATE_BUFFERS we
>> might call it VIDIOC_CREATE_BUFS_V2.
>>
>> Or perhaps some other naming convention?
> 
> Maybe VIDIOC_NEW_BUFS/v4l2_new_buffers ?
> 
> I will wait until naming convention is fixed before send v20.

How about VIDIOC_ADD_BUFS/REMOVE_BUFS?

And struct v4l2_add_bufs/v4l2_remove_bufs.

One thing that I always found debatable about the names CREATE and DELETE
is that it suggests that buffer memory is also created and deleted. While
true for MMAP, that's not the case for DMABUF and USERPTR.

Regards,

	Hans

> 
> Regards,
> Benjamin
> 
>>
>> Ideas are welcome.
>>
>> Regards,
>>
>>     Hans
>>


