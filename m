Return-Path: <linux-kernel+bounces-38256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1923283BD36
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5C0D28C37C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B9C1BDC9;
	Thu, 25 Jan 2024 09:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pLDk1JKN"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B941BF2A;
	Thu, 25 Jan 2024 09:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706174875; cv=none; b=AGtQ0xOyvbvFu8MMSdMMsIMq47AzgBCkj6BvR8nljKMdqSeraFi/wG3FvV+nrhgnufdbYkAakqiWEGDoHCyMS8RCpcmF7NHxrfYQQezEdR5XZDtXrXwHtaagN8CnzIVPc4EeS5+xPVe/4Pgi7lakEJ6PoZ6r7Ej47b5yv9a7V0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706174875; c=relaxed/simple;
	bh=2HI/3q805ve/6g1st0t9MjEBU4SWWK3qDTKGnNLjk1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WiyQjQK4MtLdTC9LjCFLZG7abM88e60vEV7PVMBxah/QgYeqTXGRpwOtOzQ2SQogT/nh31SN+CMxVtoyMFlt6d/S2Wy7pI9v9JuSgcxzcuf9xMj0NnlKd9g2/b7KaawXy88PmcH6xnd2IoPtve5zgjU83PkSXiMoX7NDFjmeMYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=pLDk1JKN; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706174872;
	bh=2HI/3q805ve/6g1st0t9MjEBU4SWWK3qDTKGnNLjk1o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pLDk1JKN8jjM9a2pnvFOSoMKotU24nw8OewtkEVURAJOUp6Pyv+mNFx7Du+Hq1sOD
	 ZGnghYgR5tEJrSIIkFeX0ohyEGtNAMlC3lFDymF9dPs3+fSeFjJueZEyKq0MHeje6M
	 4IKWSMKKV12lVqV2jU+cNBoPJnVIdw+0TcsZcFu02gfW6AhZBfq/yDk1pqLiu4tRzm
	 /YMaNDfmku4SNi+3cYRB/R/twidnI4kNqk/Qce7MNRJ366xEjY12y/4+MlmpvhODyU
	 dIcx5lpJZwwKvkV9sk+4OAuq70ZV8vX+ZEvPSLgomqbNygIqyv9pQzKa9tMAPzZTBi
	 r/dblo7nBH9sA==
Received: from [100.93.89.217] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2E88C378000B;
	Thu, 25 Jan 2024 09:27:52 +0000 (UTC)
Message-ID: <41e69449-c797-44d1-b832-d4972915bb6d@collabora.com>
Date: Thu, 25 Jan 2024 10:27:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 8/8] media: verisilicon: Support deleting buffers on
 capture queue
To: Hans Verkuil <hverkuil@xs4all.nl>, mchehab@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 kernel@collabora.com
References: <20240119094944.26763-1-benjamin.gaignard@collabora.com>
 <20240119094944.26763-9-benjamin.gaignard@collabora.com>
 <56c1410e-7a4c-4913-823d-83b8bc0ac002@xs4all.nl>
 <1cd7c504-c384-4c9c-bedd-79cd8aed8484@collabora.com>
 <7f40af24-79a8-466c-8906-7104988124fb@xs4all.nl>
Content-Language: en-US
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <7f40af24-79a8-466c-8906-7104988124fb@xs4all.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Le 24/01/2024 à 16:44, Hans Verkuil a écrit :
> On 24/01/2024 16:35, Benjamin Gaignard wrote:
>> Le 24/01/2024 à 13:52, Hans Verkuil a écrit :
>>> On 19/01/2024 10:49, Benjamin Gaignard wrote:
>>>> Allow to delete buffers on capture queue because it the one which
>>>> own the decoded buffers. After a dynamic resolution change lot of
>>>> them could remain allocated but won't be used anymore so deleting
>>>> them save memory.
>>>> Do not add this feature on output queue because the buffers are
>>>> smaller, fewer and always recycled even after a dynamic resolution
>>>> change.
>>>>
>>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>>>> ---
>>>>    drivers/media/platform/verisilicon/hantro_drv.c  | 1 +
>>>>    drivers/media/platform/verisilicon/hantro_v4l2.c | 1 +
>>>>    2 files changed, 2 insertions(+)
>>>>
>>>> diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
>>>> index db3df6cc4513..f6b0a676a740 100644
>>>> --- a/drivers/media/platform/verisilicon/hantro_drv.c
>>>> +++ b/drivers/media/platform/verisilicon/hantro_drv.c
>>>> @@ -248,6 +248,7 @@ queue_init(void *priv, struct vb2_queue *src_vq, struct vb2_queue *dst_vq)
>>>>        dst_vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY;
>>>>        dst_vq->lock = &ctx->dev->vpu_mutex;
>>>>        dst_vq->dev = ctx->dev->v4l2_dev.dev;
>>>> +    src_vq->supports_delete_bufs = true;
>>> As I mentioned, I remain unconvinced by this. It is just making the API inconsistent
>>> since if you support delete_bufs, then why support it for one queue only and not both?
>> Because the both queues don't handle the same type of data.
>> For example for a stateless decoder, for me, it makes sense to allow delete decoded frames
>> if they won't be used anymore but that won't makes sense for bitstream buffers.
> But is there any reason why you wouldn't support this feature? We support VIDIOC_CREATE_BUFS
> as well, even though most drivers do not need it, but it is cheap to add.
>
> Deleting buffers is a generic feature, and I don't see why you wouldn't just offer it
> for both queues.

You want me to remove supports_delete_bufs and V4L2_BUF_CAP_SUPPORTS_DELETE_BUFS ?
This way we can remove buffers from the both queues.
Sound good for you ?

Regards,
Benjamin

>
> Regards,
>
> 	Hans
>
>>>>          return vb2_queue_init(dst_vq);
>>>>    }
>>>> diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/media/platform/verisilicon/hantro_v4l2.c
>>>> index 941fa23c211a..34eab90e8a42 100644
>>>> --- a/drivers/media/platform/verisilicon/hantro_v4l2.c
>>>> +++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
>>>> @@ -756,6 +756,7 @@ const struct v4l2_ioctl_ops hantro_ioctl_ops = {
>>>>        .vidioc_dqbuf = v4l2_m2m_ioctl_dqbuf,
>>>>        .vidioc_prepare_buf = v4l2_m2m_ioctl_prepare_buf,
>>>>        .vidioc_create_bufs = v4l2_m2m_ioctl_create_bufs,
>>>> +    .vidioc_delete_bufs = v4l2_m2m_ioctl_delete_bufs,
>>>>        .vidioc_expbuf = v4l2_m2m_ioctl_expbuf,
>>>>          .vidioc_subscribe_event = v4l2_ctrl_subscribe_event,
>>> In my view setting vidioc_delete_bufs should enable this feature, and if
>>> for some strange reason only one queue support it, then make a wrapper
>>> callback that returns an error when used with the wrong queue.
>>>
>>> Also note that patch 6/8 never checks for q->supports_delete_bufs in
>>> vb2_core_delete_bufs(), which is wrong!
>> I will fix that in next version.
>> Regards,
>> Benjamin
>>
>>> Regards,
>>>
>>>      Hans
>>>
>

