Return-Path: <linux-kernel+bounces-163507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD528B6C48
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 475EA1F2324C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 07:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7B040BF5;
	Tue, 30 Apr 2024 07:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VB2HrYRI"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5823FE37;
	Tue, 30 Apr 2024 07:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714463767; cv=none; b=Wv5PA38VtnKNu7nALdb7S87G4+UBisygLrrQImvLGffP+hrqGF9NCXWyuvH9FXiu4kDLGRsf0Wv/K95v7XSg0sMti69rkhxS7tf9DHYOU+MqzioF8rbw/lmWcV+G3sFTuTr5EHNvuHjjQwdVx/fn9GGN1qnuEtIABZSqR+klixY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714463767; c=relaxed/simple;
	bh=K0J8xHt/skiy/7vOnAPJgizv8vUGFgcOOConDclFOfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uFYJ2gfpEhHfDlzjoMhZGmmKrjC045DfOIl4yv0gPxPdLguwKo7SrTVrF+aA8XvlvYRxrk5WeKUQMv9KMFNPRrzdsRmRpwveQ6Dk3MgyiPmY0Ilsc++A8i3863g5k75SJCw3rdO9+O+LIzmsllwemAIXwJw+2JeSqN4IhUgDeEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VB2HrYRI; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1714463764;
	bh=K0J8xHt/skiy/7vOnAPJgizv8vUGFgcOOConDclFOfE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VB2HrYRITiQ/6AQ/RLQM/j4mHuvkHmFBIOQDhOjsNrusDRyKCBe9osDTZMguCFYnw
	 LoYuHgHAkj7gAOFmIze18vQ++Q2afegipv9S/VDN3Qz/nkTFaF45MNfvdwjmtVBXFh
	 5JHty8IepUIKbzDRuoY4A/cfXb44ZKzgJ8AvIEvKn7eZngveZc/RjxCobTnRJOLFRL
	 RhlNrp/B9d58x+LhQ5BnDsdIlDI2J6un0fzQ4HJantb/pSisFiZWWKRWznCKoN1zLv
	 4wDhF5Zvedb98D+FN+BNpx2mZ8U7TXqft75csebeuSV0B8xaVcCcFUdMK6WTLZF32+
	 mZl/ya4c9rM4Q==
Received: from [100.95.196.182] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: andrzej.p)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 890FD3781107;
	Tue, 30 Apr 2024 07:56:03 +0000 (UTC)
Message-ID: <a839b292-6776-4ecb-8d8a-a25e58816787@collabora.com>
Date: Tue, 30 Apr 2024 09:56:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] media: v4l2-ctrls: Add average qp control
To: ming qian <ming.qian@oss.nxp.com>, Ming Qian <ming.qian@nxp.com>,
 mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc: shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
 xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
 imx@lists.linux.dev, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240425065011.105915-1-ming.qian@nxp.com>
 <c9fdf07d-f434-430e-bb41-8bc8f6bf1bb8@collabora.com>
 <383b6e30-1266-4db1-9c5d-10db7ab17957@oss.nxp.com>
Content-Language: en-US
From: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
In-Reply-To: <383b6e30-1266-4db1-9c5d-10db7ab17957@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ming,

W dniu 30.04.2024 o 04:20, ming qian pisze:
> 
> Hi Andrzej,
> 
>> Hi Ming Qian,
>>
>> W dniu 25.04.2024 o 08:50, Ming Qian pisze:
>>> Add a control V4L2_CID_MPEG_VIDEO_AVERAGE_QP to report the average qp
>>> value of current encoded frame. the value applies to the last dequeued
>>> capture buffer.
>>>
>>> Signed-off-by: Ming Qian <ming.qian@nxp.com>
>>> ---
>>> v2
>>>   - improve document description according Hans's comments
>>>   - drop volatile flag
>>>
>>>   Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst | 5 +++++
>>>   drivers/media/v4l2-core/v4l2-ctrls-defs.c                 | 5 +++++
>>>   include/uapi/linux/v4l2-controls.h                        | 2 ++
>>>   3 files changed, 12 insertions(+)
>>>
>>> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst 
>>> b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>>> index 2a165ae063fb..7d82ab14b8ba 100644
>>> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>>> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>>> @@ -1653,6 +1653,11 @@ enum v4l2_mpeg_video_h264_hierarchical_coding_type -
>>>       Quantization parameter for a P frame for FWHT. Valid range: from 1
>>>       to 31.
>>> +``V4L2_CID_MPEG_VIDEO_AVERAGE_QP (integer)``
>>> +    This read-only control returns the average QP value of the currently
>>> +    encoded frame. The value applies to the last dequeued capture buffer
>>> +    (VIDIOC_DQBUF). Applicable to encoders.
>>> +
>>
>> What is the intended range of the values? And why? Is your intention to make it
>> a hardware-agnostic control or a hardware-specific control?
>>
>> Regrds,
>>
>> Andrzej
>>
> 
> The value range depends on the format,
> For H264, it's [V4L2_CID_MPEG_VIDEO_H264_MIN_QP, V4L2_CID_MPEG_VIDEO_H264_MIN_QP],
> usually this is [0, 51].
> For HEVC, it's [V4L2_CID_MPEG_VIDEO_HEVC_MIN_QP, V4L2_CID_MPEG_VIDEO_HEVC_MAX_QP],
> usually it's from 0 to 51 for 8 bit and from 0 to 63 for 10 bit.
> For H263 and MPEG4, it may be from 1 to 31.
> For VPX, it may be from 1 to 128.
> 
> I think the driver that supports this ctrl can set an appropriate value
> range based on the format it supports.
> 
> Users also need to read the value of this ctrl according to the format
> they set.

What happens if the user does not set the format or until they set it?

This looks like a contextual control, where the context is a cross
product between setting or not setting the format and which particular
format is actually set.

I don't want to voice strong opinions about whether this should or
should not be accepted, but this kind of behavior should definitely
be documented so that driver writers know how to implement this control.
Right now reading the documentation in the *.rst file as a driver writer
I would be puzzled. So, from a driver writer's perspective I'd expect
these additions to the doc:

- the range of returned values
- the expected behavior when format has not been set
- the expected behavior when no frames have been processed yet (so there's no QP
to be read back from the hardware)

Regards,

Andrzej

> 
> Best regards,
> Ming
> 
>>>   .. raw:: latex
>>>       \normalsize
>>> diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c 
>>> b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
>>> index 8696eb1cdd61..1ea52011247a 100644
>>> --- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
>>> +++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
>>> @@ -970,6 +970,7 @@ const char *v4l2_ctrl_get_name(u32 id)
>>>       case V4L2_CID_MPEG_VIDEO_LTR_COUNT:            return "LTR Count";
>>>       case V4L2_CID_MPEG_VIDEO_FRAME_LTR_INDEX:        return "Frame LTR Index";
>>>       case V4L2_CID_MPEG_VIDEO_USE_LTR_FRAMES:        return "Use LTR Frames";
>>> +    case V4L2_CID_MPEG_VIDEO_AVERAGE_QP:            return "Average QP Value";
>>>       case V4L2_CID_FWHT_I_FRAME_QP:                return "FWHT I-Frame QP 
>>> Value";
>>>       case V4L2_CID_FWHT_P_FRAME_QP:                return "FWHT P-Frame QP 
>>> Value";
>>> @@ -1507,6 +1508,10 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum 
>>> v4l2_ctrl_type *type,
>>>           *max = 0xffffffffffffLL;
>>>           *step = 1;
>>>           break;
>>> +    case V4L2_CID_MPEG_VIDEO_AVERAGE_QP:
>>> +        *type = V4L2_CTRL_TYPE_INTEGER;
>>> +        *flags |= V4L2_CTRL_FLAG_READ_ONLY;
>>> +        break;
>>>       case V4L2_CID_PIXEL_RATE:
>>>           *type = V4L2_CTRL_TYPE_INTEGER64;
>>>           *flags |= V4L2_CTRL_FLAG_READ_ONLY;
>>> diff --git a/include/uapi/linux/v4l2-controls.h 
>>> b/include/uapi/linux/v4l2-controls.h
>>> index 99c3f5e99da7..974fd254e573 100644
>>> --- a/include/uapi/linux/v4l2-controls.h
>>> +++ b/include/uapi/linux/v4l2-controls.h
>>> @@ -898,6 +898,8 @@ enum v4l2_mpeg_video_av1_level {
>>>       V4L2_MPEG_VIDEO_AV1_LEVEL_7_3 = 23
>>>   };
>>> +#define V4L2_CID_MPEG_VIDEO_AVERAGE_QP  (V4L2_CID_CODEC_BASE + 657)
>>> +
>>>   /*  MPEG-class control IDs specific to the CX2341x driver as defined by 
>>> V4L2 */
>>>   #define V4L2_CID_CODEC_CX2341X_BASE (V4L2_CTRL_CLASS_CODEC | 0x1000)
>>>   #define V4L2_CID_MPEG_CX2341X_VIDEO_SPATIAL_FILTER_MODE 
>>> (V4L2_CID_CODEC_CX2341X_BASE+0)
>>


