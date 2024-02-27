Return-Path: <linux-kernel+bounces-82869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23639868AD5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14A491C216C1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A661130AC0;
	Tue, 27 Feb 2024 08:34:27 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF95955E71;
	Tue, 27 Feb 2024 08:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709022867; cv=none; b=aRLab2V0Q9uJkHABGph/20PxaV576xUwej9FlMHRiOhU9RgjBRDAgIHY6wERYmxXsiOA8R9NrQj62uyCxuY4oWVJ84sAqBxJTpNuWvmW2/sRSAL7GnTyP/3/38cctnd1PCiy+f2NP3d0n9rQp82NnI8Zq8imV8ETCzZOSTQaZ9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709022867; c=relaxed/simple;
	bh=utCTJOb3P+nxUodc++rYOPw2aXIo3wE3SFoyoLIYgqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SKMjptJNjhjlaHGhpBdIEcji2bdFbO7s0HZiRi4gnlG2aZEN2GBtdMTW5w83SKk7AUwUcwYYQiXHr8b2i2XsrSfKS7relqRice6MV3yXrNK8t5bSEtcshqG3VuU/lqtE4Z1WSPPdaLO4xYlH5AutKG5wVrzovxYdM98VgQQnVk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D23D9C433F1;
	Tue, 27 Feb 2024 08:34:22 +0000 (UTC)
Message-ID: <d8a6f227-4a64-4baa-adfa-cdd49be388d8@xs4all.nl>
Date: Tue, 27 Feb 2024 09:34:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 09/16] media: uapi: Define audio sample format fourcc
 type
Content-Language: en-US, nl
To: Shengjiu Wang <shengjiu.wang@gmail.com>,
 Nicolas Dufresne <nicolas@ndufresne.ca>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, sakari.ailus@iki.fi,
 tfiga@chromium.org, m.szyprowski@samsung.com, mchehab@kernel.org,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com,
 lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org
References: <1708936109-11587-1-git-send-email-shengjiu.wang@nxp.com>
 <1708936109-11587-10-git-send-email-shengjiu.wang@nxp.com>
 <71c860869caf899a72ebc547608220074c5939b1.camel@ndufresne.ca>
 <CAA+D8AMEMr_PSsfuSByxd0Sxv1zXJoQjEkJEWEpk59kmLGOD1Q@mail.gmail.com>
From: Hans Verkuil <hverkuil@xs4all.nl>
Autocrypt: addr=hverkuil@xs4all.nl; keydata=
 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
In-Reply-To: <CAA+D8AMEMr_PSsfuSByxd0Sxv1zXJoQjEkJEWEpk59kmLGOD1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 27/02/2024 04:44, Shengjiu Wang wrote:
> On Mon, Feb 26, 2024 at 9:55 PM Nicolas Dufresne <nicolas@ndufresne.ca> wrote:
>>
>> Le lundi 26 février 2024 à 16:28 +0800, Shengjiu Wang a écrit :
>>> The audio sample format definition is from alsa,
>>> the header file is include/uapi/sound/asound.h, but
>>> don't include this header file directly, because in
>>> user space, there is another copy in alsa-lib.
>>> There will be conflict in userspace for include
>>> videodev2.h & asound.h and asoundlib.h
>>>
>>> Here still use the fourcc format.
>>
>> I'd like to join Mauro's voice that duplicating the audio formats is a bad idea.
>> We have the same issues with video formats when you look at V4L2 vs DRM. You're
>> rationale is that videodev2.h will be ambiguous if it includes asound.h, but
>> looking at this change, there is no reason why you need to include asound.h in
>> videodev2.h at all. The format type can be abstracted out with a uint32 in the
>> API, and then it would be up to the users to include and use the appropriate
>> formats IDs.
>>
> 
> Resend for the plain text issue
> 
> Thanks.
> 
> There is another reason mentioned by Hans:
> 
> "
> The problem is that within V4L2 we use fourcc consistently to describe a
> format, including in VIDIOC_ENUM_FMT. And the expectation is that the fourcc
> can be printed to a human readable string (there is even a printk format for
> that these days).
> 
> But the pcm values are all small integers (and can even be 0!), and
> printing the fourcc will give garbage. It doesn't work well at all
> with the V4L2 API. But by having a straightforward conversion between the
> pcm identifier and a fourcc it was really easy to deal with this.
> 
> There might even be applications today that call VIDIOC_ENUM_FMT to see
> what is supported and fail if it is not a proper fourcc is returned.
> 
> It will certainly report nonsense in v4l_print_fmtdesc() (v4l2-ioctl.c).
> 
> One of the early versions of this patch series did precisely what you request,
> but it just doesn't work well within the V4L2 uAPI.
> "

Right, and remember that the fourcc codes are really meant to be shown as
characters. v4l2-ctl and friends all use this, and we all talk about them
as such (NV12, YUYV, etc.). If I would just stick in the standard PCM IDs,
then they would all show up as '....'.

<snip>

>>> +/*
>>> + * Audio-data formats
>>> + * All these audio formats use a fourcc starting with 'AU'
>>> + * followed by the SNDRV_PCM_FORMAT_ value from asound.h.
>>> + */
>>> +#define V4L2_AUDIO_FMT_S8                    v4l2_fourcc('A', 'U', '0', '0')
>>> +#define V4L2_AUDIO_FMT_S16_LE                        v4l2_fourcc('A', 'U', '0', '2')
>>> +#define V4L2_AUDIO_FMT_U16_LE                        v4l2_fourcc('A', 'U', '0', '4')
>>> +#define V4L2_AUDIO_FMT_S24_LE                        v4l2_fourcc('A', 'U', '0', '6')
>>> +#define V4L2_AUDIO_FMT_U24_LE                        v4l2_fourcc('A', 'U', '0', '8')
>>> +#define V4L2_AUDIO_FMT_S32_LE                        v4l2_fourcc('A', 'U', '1', '0')
>>> +#define V4L2_AUDIO_FMT_U32_LE                        v4l2_fourcc('A', 'U', '1', '2')
>>> +#define V4L2_AUDIO_FMT_FLOAT_LE                      v4l2_fourcc('A', 'U', '1', '4')
>>> +#define V4L2_AUDIO_FMT_IEC958_SUBFRAME_LE    v4l2_fourcc('A', 'U', '1', '8')
>>> +#define V4L2_AUDIO_FMT_S24_3LE                       v4l2_fourcc('A', 'U', '3', '2')
>>> +#define V4L2_AUDIO_FMT_U24_3LE                       v4l2_fourcc('A', 'U', '3', '4')
>>> +#define V4L2_AUDIO_FMT_S20_3LE                       v4l2_fourcc('A', 'U', '3', '6')
>>> +#define V4L2_AUDIO_FMT_U20_3LE                       v4l2_fourcc('A', 'U', '3', '8')
>>> +
>>> +#define v4l2_fourcc_to_audfmt(fourcc)        \
>>> +     (__force snd_pcm_format_t)(((((fourcc) >> 16) & 0xff) - '0') * 10  \
>>> +                                + ((((fourcc) >> 24) & 0xff) - '0'))
>>> +

We did add a #define to go from a fourcc to an audio format.

Would it help to add a corresponding v4l2_audfmt_to_fourcc define as well?

#define v4l2_audfmt_to_fourcc(audfmt) \
	v4l2_fourcc('A', 'U', '0' + (audfmt) / 10, '0' + (audfmt) % 10)

I would have no problem with that.

The mapping between the audio format and the fourcc is very simple, it is just
converted to something that can be safely shown as ASCII characters.

Regards,

	Hans

>>>  /* priv field value to indicates that subsequent fields are valid. */
>>>  #define V4L2_PIX_FMT_PRIV_MAGIC              0xfeedcafe
>>>
>>


