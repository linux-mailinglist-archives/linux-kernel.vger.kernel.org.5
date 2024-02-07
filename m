Return-Path: <linux-kernel+bounces-56388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EED84C990
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0A351F25200
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DC31AADB;
	Wed,  7 Feb 2024 11:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dA/fmEQG"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D3617C65;
	Wed,  7 Feb 2024 11:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707305112; cv=none; b=HekQpp732kIrN/8fDlJvw1pOJwkFPFDRgxA2NuxKDRsH1ssJ97kU8Edw0WtHp8Guo9HjbBI5HgjW+uB8Yz9kTBzoh5a5Zbs8ir81QSShDyG1vXXq6nZoklNekwiDhb7wLpnwmRpyCdC3HOCRh3tDyhx25Y3CqbR+23JhnZG/ZvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707305112; c=relaxed/simple;
	bh=FPBuznEEEVUrobBekXZ2+ABmMXNzXIUpNcpdsZQpR6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WFfVem8olhUpW/WUMMycwvPYfG+Bepu3snuw/IUxfWE1gIblv4W00hkzb46xYt8IJIWIWrHi7Y2cDDPURIk1xLWcr39hT1gT4rT3u5Jx34XPJoVqZquIVLwk2iHDQclpqmyY84bx3h2SxDpbK7zhy9LbXOauoY64Uunclcqt4Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dA/fmEQG; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707305109;
	bh=FPBuznEEEVUrobBekXZ2+ABmMXNzXIUpNcpdsZQpR6Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dA/fmEQGXyarKiz0ia1We2nHVpCQTCp/Dniaomtt30Q8TWe3Nbd8+VTAY9eNwEfss
	 2+icFQErNiLhkvyC95NxPLgnuTlyzxpJIPtS7YzokEIdZ+cGo7JdBrlhV+VvgDCBN6
	 KGnuRLOHxlBIO14HeH0HuUHqsBo4bUaPaZhOMdCYD/IdZgppVUU1AVg+u6hHVglZoY
	 SUHwMOI2aipM3yMvRpcHI/3y6i/AtbSK4kuR8uaW2qZmSTiqlWvhRNTZ67x0X3yrkL
	 Z+ysc5eZsDwq7OKRFII3b/nmnIGVe+MZuU8PnSwbzEPVVQQx9FNkdGorl9gGZ73OoV
	 CRohK2M64ozbg==
Received: from [100.93.89.217] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4890B378203B;
	Wed,  7 Feb 2024 11:25:09 +0000 (UTC)
Message-ID: <9fda7e17-42e8-4b2e-8daf-f0e556934356@collabora.com>
Date: Wed, 7 Feb 2024 12:25:08 +0100
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
 <63a46881-7fe8-4858-b0f7-cde33ffc7ea6@xs4all.nl>
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <63a46881-7fe8-4858-b0f7-cde33ffc7ea6@xs4all.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Le 07/02/2024 à 11:28, Hans Verkuil a écrit :
> On 06/02/2024 09:58, Hans Verkuil wrote:
>> On 06/02/2024 09:02, Benjamin Gaignard wrote:
>>> Unlike when resolution change on keyframes, dynamic resolution change
>>> on inter frames doesn't allow to do a stream off/on sequence because
>>> it is need to keep all previous references alive to decode inter frames.
>>> This constraint have two main problems:
>>> - more memory consumption.
>>> - more buffers in use.
>>> To solve these issue this series introduce DELETE_BUFS ioctl and remove
>>> the 32 buffers limit per queue.
>> This v19 looks good. There are three outstanding issues that I need to take a
>> look at:
>>
>> 1) Can we still signal support for DELETE_BUFS in the V4L2_BUF_CAP_ caps?
>>     It would be nice to have, but I'm not sure if and how that can be done.
>>
>> 2) I want to take another look at providing a next version of the VIDIOC_CREATE_BUFS
>>     ioctl and how that would possibly influence the design of DELETE_BUFS.
>>     Just to make sure we're not blocking anything or making life harder.
> So I just tried creating a new version of the VIDIOC_CREATE_BUFS ioctl
> that is greatly simplified. This just updates the header, no real code yet:
>
> Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> ---
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> index 03443833aaaa..a7398e4c85e7 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -2624,6 +2624,39 @@ struct v4l2_create_buffers {
>   	__u32			reserved[5];
>   };
>
> +/**
> + * struct v4l2_create_buffers_v2 - VIDIOC_CREATE_BUFFERS argument
> + * @type:	enum v4l2_buf_type
> + * @memory:	enum v4l2_memory; buffer memory type
> + * @count:	entry: number of requested buffers,
> + *		return: number of created buffers
> + * @num_planes:	requested number of planes for each buffer
> + * @sizes:	requested plane sizes for each buffer
> + * @start_index:on return, index of the first created buffer
> + * @total_count:on return, the total number of allocated buffers
> + * @capabilities: capabilities of this buffer type.
> + * @flags:	additional buffer management attributes (ignored unless the
> + *		queue has V4L2_BUF_CAP_SUPPORTS_MMAP_CACHE_HINTS capability
> + *		and configured for MMAP streaming I/O).
> + * @max_num_buffers: if V4L2_BUF_CAP_SUPPORTS_MAX_NUM_BUFFERS capability flag is set
> + *		this field indicate the maximum possible number of buffers
> + *		for this queue.
> + * @reserved:	future extensions
> + */
> +struct v4l2_create_buffers_v2 {
> +	__u32			type;
> +	__u32			memory;
> +	__u32			count;
> +	__u32			num_planes;
> +	__u32			size[VIDEO_MAX_PLANES];
> +	__u32			start_index;
> +	__u32			total_count;
> +	__u32			capabilities;
> +	__u32			flags;
> +	__u32			max_num_buffers;
> +	__u32			reserved[7];
> +};
> +
>   /**
>    * struct v4l2_delete_buffers - VIDIOC_DELETE_BUFS argument
>    * @index:	the first buffer to be deleted
> @@ -2738,6 +2771,7 @@ struct v4l2_delete_buffers {
>
>   #define VIDIOC_QUERY_EXT_CTRL	_IOWR('V', 103, struct v4l2_query_ext_ctrl)
>   #define VIDIOC_DELETE_BUFS	_IOWR('V', 104, struct v4l2_delete_buffers)
> +#define VIDIOC_CREATE_BUFFERS	_IOWR('V', 105, struct v4l2_create_buffers_v2)
>
>
>   /* Reminder: when adding new ioctls please add support for them to
>
>
> Sadly, struct v4l2_create_buffers was already used for the existing
> VIDIOC_CREATE_BUFS (I wish it was called v4l2_create_bufs...), so I did
> have to add a _v2 suffix. Compared to the old struct it just moves the
> type, num_planes and sizes from v4l2_format into the new struct and drops
> the format field. Note that those fields are the only v4l2_format fields
> that VIDIOC_CREATE_BUFS used, so getting rid of the format makes live
> much easier. I also renamed 'index' to 'start_index' and added a new 'total_count'
> field to report the total number of buffers.
>
> The reason for adding 'total_count' is that VIDIOC_CREATE_BUFS with
> count == 0 would report the total number of buffers in the 'index' field,
> which was rather odd. Adding a specific field for this purpose is nicer.
>
> One thing that might impact your series is the name of the ioctls.
>
> We have:
>
> VIDIOC_CREATE_BUFS/v4l2_create_buffers
> VIDIOC_DELETE_BUFS/v4l2_delete_buffers
> VIDIOC_CREATE_BUFFERS/v4l2_create_buffers_v2 (TBD)
>
> I'm wondering if VIDIOC_DELETE_BUFS should be renamed to
> VIDIOC_DELETE_BUFFERS, that would make it more consistent with
> the proposed VIDIOC_CREATE_BUFFERS.
>
> Alternatively, instead of calling it VIDIOC_CREATE_BUFFERS we
> might call it VIDIOC_CREATE_BUFS_V2.
>
> Or perhaps some other naming convention?

Maybe VIDIOC_NEW_BUFS/v4l2_new_buffers ?

I will wait until naming convention is fixed before send v20.

Regards,
Benjamin

>
> Ideas are welcome.
>
> Regards,
>
> 	Hans
>

