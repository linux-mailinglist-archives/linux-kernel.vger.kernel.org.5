Return-Path: <linux-kernel+bounces-37264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F4F83AD78
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C93DB26A2E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B8F7E563;
	Wed, 24 Jan 2024 15:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="5nryEXkh"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195167CF2A;
	Wed, 24 Jan 2024 15:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706110512; cv=none; b=q9xjYgA7rR/BAZxSgqa1VWSsSdl6bG5Ppvx5CIjPsHRuU8gZ6j1r5D/b+z18f0ecENimZuEBBUCVwriadJ/kPIq7oAaE+dbh7z5VLhsKzY1i7V5TTBB+CVa72o81/orkj9B4YMUlQM68MbCbSOTdiCMa8LF78vstlM1lZk6JdA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706110512; c=relaxed/simple;
	bh=1n/NxKQml1amnnNYNgpDg8GxNn5nVch+HSLWTgKzXSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gt2wQuzEW+EBYLSSdZRQoTzuAUi0z6eHi/7yxZeejYjOCdxtPLw6t8WofSyMlAKAU7Vz8PhQck6SM9X318qr4QVS2OvOjju1AKfSxt139+9u0XXX1hyCKzCKRv1QfgC54q0tFVA18eYsKuA1s2dG01jTbKD3XEWWl2Nv/ZGGxiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=5nryEXkh; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706110509;
	bh=1n/NxKQml1amnnNYNgpDg8GxNn5nVch+HSLWTgKzXSk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=5nryEXkhPKQIuc7IYLidpWzp7H9Y31L9hNXzOH3fzKOfbdBUL40lyuvXAqqtSOk3T
	 V6eM++a7QuoGx2uejGJx5xhW59SmswdV0f8wuS+Ds2twLUhgAXU29v3DZ6Sf/4wt9h
	 gL01Y0SyFuadbDtAakpIGoCj61LDsaUMyjcvmb6wvV0gNEUaG7v0qLXFO7LU/XPZ3H
	 1j+2Q6+OLe3I/PVHawpzeYkZ0E+emvse3aK4u3c2ZTi/r8EfX9/JW9/bcw1culgpRA
	 KbmRAufsg8n76YwBnhizBq8bGqQhSSzKQtzuye/3e+MEDxi50iZG2uoolzunoy8vq6
	 YfkY0f4lNWfsA==
Received: from [100.93.89.217] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0511637811D2;
	Wed, 24 Jan 2024 15:35:08 +0000 (UTC)
Message-ID: <1cd7c504-c384-4c9c-bedd-79cd8aed8484@collabora.com>
Date: Wed, 24 Jan 2024 16:35:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 8/8] media: verisilicon: Support deleting buffers on
 capture queue
Content-Language: en-US
To: Hans Verkuil <hverkuil@xs4all.nl>, mchehab@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 kernel@collabora.com
References: <20240119094944.26763-1-benjamin.gaignard@collabora.com>
 <20240119094944.26763-9-benjamin.gaignard@collabora.com>
 <56c1410e-7a4c-4913-823d-83b8bc0ac002@xs4all.nl>
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <56c1410e-7a4c-4913-823d-83b8bc0ac002@xs4all.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Le 24/01/2024 à 13:52, Hans Verkuil a écrit :
> On 19/01/2024 10:49, Benjamin Gaignard wrote:
>> Allow to delete buffers on capture queue because it the one which
>> own the decoded buffers. After a dynamic resolution change lot of
>> them could remain allocated but won't be used anymore so deleting
>> them save memory.
>> Do not add this feature on output queue because the buffers are
>> smaller, fewer and always recycled even after a dynamic resolution
>> change.
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>> ---
>>   drivers/media/platform/verisilicon/hantro_drv.c  | 1 +
>>   drivers/media/platform/verisilicon/hantro_v4l2.c | 1 +
>>   2 files changed, 2 insertions(+)
>>
>> diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
>> index db3df6cc4513..f6b0a676a740 100644
>> --- a/drivers/media/platform/verisilicon/hantro_drv.c
>> +++ b/drivers/media/platform/verisilicon/hantro_drv.c
>> @@ -248,6 +248,7 @@ queue_init(void *priv, struct vb2_queue *src_vq, struct vb2_queue *dst_vq)
>>   	dst_vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY;
>>   	dst_vq->lock = &ctx->dev->vpu_mutex;
>>   	dst_vq->dev = ctx->dev->v4l2_dev.dev;
>> +	src_vq->supports_delete_bufs = true;
> As I mentioned, I remain unconvinced by this. It is just making the API inconsistent
> since if you support delete_bufs, then why support it for one queue only and not both?

Because the both queues don't handle the same type of data.
For example for a stateless decoder, for me, it makes sense to allow delete decoded frames
if they won't be used anymore but that won't makes sense for bitstream buffers.

>
>>   
>>   	return vb2_queue_init(dst_vq);
>>   }
>> diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/media/platform/verisilicon/hantro_v4l2.c
>> index 941fa23c211a..34eab90e8a42 100644
>> --- a/drivers/media/platform/verisilicon/hantro_v4l2.c
>> +++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
>> @@ -756,6 +756,7 @@ const struct v4l2_ioctl_ops hantro_ioctl_ops = {
>>   	.vidioc_dqbuf = v4l2_m2m_ioctl_dqbuf,
>>   	.vidioc_prepare_buf = v4l2_m2m_ioctl_prepare_buf,
>>   	.vidioc_create_bufs = v4l2_m2m_ioctl_create_bufs,
>> +	.vidioc_delete_bufs = v4l2_m2m_ioctl_delete_bufs,
>>   	.vidioc_expbuf = v4l2_m2m_ioctl_expbuf,
>>   
>>   	.vidioc_subscribe_event = v4l2_ctrl_subscribe_event,
> In my view setting vidioc_delete_bufs should enable this feature, and if
> for some strange reason only one queue support it, then make a wrapper
> callback that returns an error when used with the wrong queue.
>
> Also note that patch 6/8 never checks for q->supports_delete_bufs in
> vb2_core_delete_bufs(), which is wrong!

I will fix that in next version.
Regards,
Benjamin

>
> Regards,
>
> 	Hans
>

