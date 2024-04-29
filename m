Return-Path: <linux-kernel+bounces-162766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A688B6045
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E9AB1C22094
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5C2127B7A;
	Mon, 29 Apr 2024 17:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Lt+I7KYc"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34ED91272A7;
	Mon, 29 Apr 2024 17:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714412322; cv=none; b=KRJ2sY9THZuEczM51GWMv2593gwr6TcU+M+dDfN64L3iuYSF/QR/a09jWkDexoAYkSLknVvq1P7eBb9hZeSP7TM0p8UAR5fU7W+ksxRLhJVdJPhxaDWQ+wo45h9C0Gs0+8ZqzwE0ssp+mp5WP5q+95nSgzps4tjjBP3jYLOoxdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714412322; c=relaxed/simple;
	bh=1x9AweOCRN6wAjRzCLfOzzcJLe5L2DBnD5eJbMilD6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AM3Et8nPM3iMLPq21+l0O3+hIcHtSEc1hprLVNdhAL+sqK5SI+IAg3FOvQUzEj5Mz1O1k3aWzf4HQmXRqAUuakMv0uo01MpuAFJ6WfcQNrO+ZXFEqedlo5mFLqRWMF2q/Bn0v2Pc2hM7WZ9q1VGHQeM2Y3dOuxP+/o8HCvBPlGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Lt+I7KYc; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1714412317;
	bh=1x9AweOCRN6wAjRzCLfOzzcJLe5L2DBnD5eJbMilD6Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Lt+I7KYcV8IuzPU6PJpbH65QoqYW53dwofd8Ph0O7H1yKKXJ6Sfy+aOSOpJy2znx0
	 hjmFTaacPM1ekS2VqHO7kZ51yq0wmY1QOuZeQjfj8bmZIOkeR6ko0HiF3o+2okNgyC
	 ssveiXOsUAEiiUh32sGZancWPqxeVUjnSod91xd2dpgZWmlUeFAuXDCSa+78+X9AIT
	 CND3mxDM0DH8mPFZHJCkNa310AdGnaG4WaPVbsW69KNNOzxQMRcDi770us6fng+8Q+
	 V4YiQ3A+UhosXyk9buS9N10bHp7mLTQRv+qZzugQZwRXnkrYUGwzuuiymSh0kBWzNT
	 LqzlaM025IAEw==
Received: from [100.95.196.182] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: andrzej.p)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D485837809CE;
	Mon, 29 Apr 2024 17:38:34 +0000 (UTC)
Message-ID: <c9fdf07d-f434-430e-bb41-8bc8f6bf1bb8@collabora.com>
Date: Mon, 29 Apr 2024 19:38:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] media: v4l2-ctrls: Add average qp control
To: Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org,
 hverkuil-cisco@xs4all.nl
Cc: shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
 xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
 ming.qian@oss.nxp.com, imx@lists.linux.dev, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240425065011.105915-1-ming.qian@nxp.com>
Content-Language: en-US
From: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
In-Reply-To: <20240425065011.105915-1-ming.qian@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ming Qian,

W dniu 25.04.2024 o 08:50, Ming Qian pisze:
> Add a control V4L2_CID_MPEG_VIDEO_AVERAGE_QP to report the average qp
> value of current encoded frame. the value applies to the last dequeued
> capture buffer.
> 
> Signed-off-by: Ming Qian <ming.qian@nxp.com>
> ---
> v2
>   - improve document description according Hans's comments
>   - drop volatile flag
> 
>   Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst | 5 +++++
>   drivers/media/v4l2-core/v4l2-ctrls-defs.c                 | 5 +++++
>   include/uapi/linux/v4l2-controls.h                        | 2 ++
>   3 files changed, 12 insertions(+)
> 
> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> index 2a165ae063fb..7d82ab14b8ba 100644
> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> @@ -1653,6 +1653,11 @@ enum v4l2_mpeg_video_h264_hierarchical_coding_type -
>       Quantization parameter for a P frame for FWHT. Valid range: from 1
>       to 31.
>   
> +``V4L2_CID_MPEG_VIDEO_AVERAGE_QP (integer)``
> +    This read-only control returns the average QP value of the currently
> +    encoded frame. The value applies to the last dequeued capture buffer
> +    (VIDIOC_DQBUF). Applicable to encoders.
> +

What is the intended range of the values? And why? Is your intention to make it
a hardware-agnostic control or a hardware-specific control?

Regrds,

Andrzej

>   .. raw:: latex
>   
>       \normalsize
> diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> index 8696eb1cdd61..1ea52011247a 100644
> --- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> +++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> @@ -970,6 +970,7 @@ const char *v4l2_ctrl_get_name(u32 id)
>   	case V4L2_CID_MPEG_VIDEO_LTR_COUNT:			return "LTR Count";
>   	case V4L2_CID_MPEG_VIDEO_FRAME_LTR_INDEX:		return "Frame LTR Index";
>   	case V4L2_CID_MPEG_VIDEO_USE_LTR_FRAMES:		return "Use LTR Frames";
> +	case V4L2_CID_MPEG_VIDEO_AVERAGE_QP:			return "Average QP Value";
>   	case V4L2_CID_FWHT_I_FRAME_QP:				return "FWHT I-Frame QP Value";
>   	case V4L2_CID_FWHT_P_FRAME_QP:				return "FWHT P-Frame QP Value";
>   
> @@ -1507,6 +1508,10 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
>   		*max = 0xffffffffffffLL;
>   		*step = 1;
>   		break;
> +	case V4L2_CID_MPEG_VIDEO_AVERAGE_QP:
> +		*type = V4L2_CTRL_TYPE_INTEGER;
> +		*flags |= V4L2_CTRL_FLAG_READ_ONLY;
> +		break;
>   	case V4L2_CID_PIXEL_RATE:
>   		*type = V4L2_CTRL_TYPE_INTEGER64;
>   		*flags |= V4L2_CTRL_FLAG_READ_ONLY;
> diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
> index 99c3f5e99da7..974fd254e573 100644
> --- a/include/uapi/linux/v4l2-controls.h
> +++ b/include/uapi/linux/v4l2-controls.h
> @@ -898,6 +898,8 @@ enum v4l2_mpeg_video_av1_level {
>   	V4L2_MPEG_VIDEO_AV1_LEVEL_7_3 = 23
>   };
>   
> +#define V4L2_CID_MPEG_VIDEO_AVERAGE_QP  (V4L2_CID_CODEC_BASE + 657)
> +
>   /*  MPEG-class control IDs specific to the CX2341x driver as defined by V4L2 */
>   #define V4L2_CID_CODEC_CX2341X_BASE				(V4L2_CTRL_CLASS_CODEC | 0x1000)
>   #define V4L2_CID_MPEG_CX2341X_VIDEO_SPATIAL_FILTER_MODE		(V4L2_CID_CODEC_CX2341X_BASE+0)


