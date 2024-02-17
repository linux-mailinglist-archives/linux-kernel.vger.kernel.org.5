Return-Path: <linux-kernel+bounces-69781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF1C858E7D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 10:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F3CA282D2F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 09:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2B11DDC9;
	Sat, 17 Feb 2024 09:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m1U7tP8K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0761DA20;
	Sat, 17 Feb 2024 09:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708163835; cv=none; b=UQCiUl1ui+oV0eD+fzZJDIKv4EmhbvZ/1/nCMN5BTO2JrtaQGx80150/Iyl6cAvOaF87MyUxmGupBZeqSwys/sTTtBg2qPD0lAiVVFjZmIuOQxhL75zKKrYQs8g0wxIZwPmAVkG+sAienNiT0pRxUpJrmxqItxviCOG0Wug4W8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708163835; c=relaxed/simple;
	bh=EDkMlZRBTzgmSoA8T3Q+NyJsDr+epBLEA+1LH31cuww=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SgKYCa8D8CDeOF2+mTwFpKgMDz/F74b/4u00TRum9oPxRlnNuxVrFRliCHzY36TfrtJ3OUsiyjiXXww1j5xmkC8aEcZdbYqS974MzR0Cdyn7tR6imhHEVMuxoz0AwvySR4DIz0jGP4CBrXW5EkkczCdh6FI9JyS9ADuxzYTErJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m1U7tP8K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54C75C433C7;
	Sat, 17 Feb 2024 09:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708163834;
	bh=EDkMlZRBTzgmSoA8T3Q+NyJsDr+epBLEA+1LH31cuww=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m1U7tP8KWvVXCCCFRmYrdtQ6rW9gQAqcnsTKlX/JE5zQPPIrA6Uka888RNQSvB/y8
	 bkvX+jBt8Oc/Pbp7fuDUY3RFc/rhBMauHmv0OXfvyQy9hQ4RGvuA4E9Jvt0fmtyPJk
	 uk59nBh5l/Y3tRvLsdjlfSKZAa+8WshViuAvBAv0kuJNXqPB+nE4bM9sfRBPdUrAYU
	 gSGzA1DA/UCbYMUEa2eWn16swUg5WhRWdKdckQLGYXY2CrPa0ksexosq8/UjbnHgw1
	 OMRSAzoC/bhKO/AW8mKjDLeaX8pn3gvCiDoeT3fmfxL013mWWIWUbOhN52r8spIMkQ
	 G5jWc8dtc+dNA==
Date: Sat, 17 Feb 2024 10:57:08 +0100
From: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: hverkuil@xs4all.nl, sakari.ailus@iki.fi, tfiga@chromium.org,
 m.szyprowski@samsung.com, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, nicoleotsuka@gmail.com, lgirdwood@gmail.com,
 broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v12 10/15] media: uapi: Add audio rate controls support
Message-ID: <20240217105708.53c81b04@coco.lan>
In-Reply-To: <1705581128-4604-11-git-send-email-shengjiu.wang@nxp.com>
References: <1705581128-4604-1-git-send-email-shengjiu.wang@nxp.com>
	<1705581128-4604-11-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 18 Jan 2024 20:32:03 +0800
Shengjiu Wang <shengjiu.wang@nxp.com> escreveu:

> Add V4L2_CID_M2M_AUDIO_SOURCE_RATE and V4L2_CID_M2M_AUDIO_DEST_RATE
> new IDs for rate control.
> 
> Add V4L2_CID_M2M_AUDIO_SOURCE_RATE_OFFSET and
> V4L2_CID_M2M_AUDIO_DEST_RATE_OFFSET for clock drift.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  .../media/v4l/ext-ctrls-audio-m2m.rst         | 20 +++++++++++++++++++
>  drivers/media/v4l2-core/v4l2-ctrls-defs.c     |  6 ++++++
>  include/uapi/linux/v4l2-controls.h            |  5 +++++
>  3 files changed, 31 insertions(+)
> 
> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-audio-m2m.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-audio-m2m.rst
> index 82d2ecedbfee..de579ab8fb94 100644
> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-audio-m2m.rst
> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-audio-m2m.rst
> @@ -19,3 +19,23 @@ Audio M2M Control IDs
>      The Audio M2M class descriptor. Calling
>      :ref:`VIDIOC_QUERYCTRL` for this control will
>      return a description of this control class.
> +
> +.. _v4l2-audio-asrc:
> +
> +``V4L2_CID_M2M_AUDIO_SOURCE_RATE (integer menu)``
> +    Sets the audio source sample rate, unit is Hz
> +
> +``V4L2_CID_M2M_AUDIO_DEST_RATE (integer menu)``
> +    Sets the audio destination sample rate, unit is Hz
> +
> +``V4L2_CID_M2M_AUDIO_SOURCE_RATE_OFFSET (fixed point)``
> +    Sets the offset from the audio source sample rate, unit is Hz.
> +    The offset compensates for any clock drift. The actual source audio
> +    sample rate is the ideal source audio sample rate from
> +    ``V4L2_CID_M2M_AUDIO_SOURCE_RATE`` plus this fixed point offset.
> +
> +``V4L2_CID_M2M_AUDIO_DEST_RATE_OFFSET (fixed point)``
> +    Sets the offset from the audio destination sample rate, unit is Hz.
> +    The offset compensates for any clock drift. The actual destination audio
> +    sample rate is the ideal source audio sample rate from
> +    ``V4L2_CID_M2M_AUDIO_DEST_RATE`` plus this fixed point offset.

Hmm... first of all, controls on V4L2 API can either be get or set.
So, starting the sentence with "Set" sounds an assumption that may
be wrong.

Also, I would explain a little bit more about the frequency offset values,
as clock drift adjustment on PCM streams is something that can be done
using different approaches.

I'm assuming that what you wanted here is to use it to check if the
video and audio clocks have some drift, and reducing or increasing
the audio sample rate dynamically to ensure that such drift will
stay constraint to a maximum allowed drift measured in mili or nano
seconds. So, userspace would be expected to be monitoring such drift
and increasing/decreasing the sample frequency as needed to maintain
such constraint.

Is that the way such uAPI is expected to work?

> diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> index 2a85ea3dc92f..91e1f5348c23 100644
> --- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> +++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> @@ -1245,6 +1245,8 @@ const char *v4l2_ctrl_get_name(u32 id)
>  
>  	/* Audio M2M controls */
>  	case V4L2_CID_M2M_AUDIO_CLASS:  return "Audio M2M Controls";
> +	case V4L2_CID_M2M_AUDIO_SOURCE_RATE:	return "Audio Source Sample Rate";
> +	case V4L2_CID_M2M_AUDIO_DEST_RATE:	return "Audio Destination Sample Rate";
>  	default:
>  		return NULL;
>  	}
> @@ -1606,6 +1608,10 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
>  	case V4L2_CID_COLORIMETRY_HDR10_MASTERING_DISPLAY:
>  		*type = V4L2_CTRL_TYPE_HDR10_MASTERING_DISPLAY;
>  		break;
> +	case V4L2_CID_M2M_AUDIO_SOURCE_RATE:
> +	case V4L2_CID_M2M_AUDIO_DEST_RATE:
> +		*type = V4L2_CTRL_TYPE_INTEGER_MENU;
> +		break;
>  	default:
>  		*type = V4L2_CTRL_TYPE_INTEGER;
>  		break;
> diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
> index a8b4b830c757..30129ccdc282 100644
> --- a/include/uapi/linux/v4l2-controls.h
> +++ b/include/uapi/linux/v4l2-controls.h
> @@ -3495,6 +3495,11 @@ struct v4l2_ctrl_av1_film_grain {
>  #define V4L2_CID_M2M_AUDIO_CLASS_BASE  (V4L2_CTRL_CLASS_M2M_AUDIO | 0x900)
>  #define V4L2_CID_M2M_AUDIO_CLASS       (V4L2_CTRL_CLASS_M2M_AUDIO | 1)
>  
> +#define V4L2_CID_M2M_AUDIO_SOURCE_RATE	(V4L2_CID_M2M_AUDIO_CLASS_BASE + 0)
> +#define V4L2_CID_M2M_AUDIO_DEST_RATE	(V4L2_CID_M2M_AUDIO_CLASS_BASE + 1)
> +#define V4L2_CID_M2M_AUDIO_SOURCE_RATE_OFFSET	(V4L2_CID_M2M_AUDIO_CLASS_BASE + 2)
> +#define V4L2_CID_M2M_AUDIO_DEST_RATE_OFFSET	(V4L2_CID_M2M_AUDIO_CLASS_BASE + 3)
> +
>  /* MPEG-compression definitions kept for backwards compatibility */
>  #ifndef __KERNEL__
>  #define V4L2_CTRL_CLASS_MPEG            V4L2_CTRL_CLASS_CODEC



Thanks,
Mauro

