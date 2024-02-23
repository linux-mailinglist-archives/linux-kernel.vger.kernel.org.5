Return-Path: <linux-kernel+bounces-78541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E258B8614B9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 114131C2326B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F661522E;
	Fri, 23 Feb 2024 14:50:30 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E1B81ADC;
	Fri, 23 Feb 2024 14:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708699829; cv=none; b=MtanigDnTCI6jtC9OrkTCKPHz8ez8luqYaMiMXiX3c3MSO1Y17Q8xPsEflej//dugn4jeAdCkUr6g+T9majaniU69a4WRx2DFIHWDQ+q+2qnN5AGMtOd6udDgQgK5WoZ8v/1pkC/KXYMqnpd5za3CjeKBqtivvhz5zB6rUFXCHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708699829; c=relaxed/simple;
	bh=y/xMkowkVU92Au7jJv7FnwhVo3frwEfU+BIxoVpgQNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XPgp7Sw0krrYSfRJn5igc1ZQkhYJna6S2Ly0EgshmuzPI9pOpPyEIX95KhWGDeWDDG0umZKxKHicgK0q/QrOGprYtwUlVugfipky1B3suhlzia5zdbqeWZI7khjgB5DaEXcpX45zER3hJZC2HITCKAKAh9rYgOat4C2ln/At9p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7432FC433C7;
	Fri, 23 Feb 2024 14:50:26 +0000 (UTC)
Message-ID: <fdd67bc5-53aa-425b-8b8e-a34c3aa9c96e@xs4all.nl>
Date: Fri, 23 Feb 2024 15:50:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 08/15] media: uapi: Define audio sample format fourcc
 type
Content-Language: en-US, nl
To: Shengjiu Wang <shengjiu.wang@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Shengjiu Wang <shengjiu.wang@nxp.com>, sakari.ailus@iki.fi,
 tfiga@chromium.org, m.szyprowski@samsung.com, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
 nicoleotsuka@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org
References: <1705581128-4604-1-git-send-email-shengjiu.wang@nxp.com>
 <1705581128-4604-9-git-send-email-shengjiu.wang@nxp.com>
 <20240217101926.3f1d2452@coco.lan>
 <CAA+D8APD+zL0xYkf6FxPNfM3Y3O8+PhT7WEXO7XCLAmBjoMmUA@mail.gmail.com>
 <20240219135618.5c557e66@coco.lan>
 <e98a23c6-a35d-422b-be8a-1179392215c1@xs4all.nl>
 <CAA+D8AN1KEjmb7f5dzMn1EV=UB5QqA4q__y2mTOW8-CH_7gchQ@mail.gmail.com>
From: Hans Verkuil <hverkuil@xs4all.nl>
Autocrypt: addr=hverkuil@xs4all.nl; keydata=
 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
In-Reply-To: <CAA+D8AN1KEjmb7f5dzMn1EV=UB5QqA4q__y2mTOW8-CH_7gchQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 22/02/2024 04:50, Shengjiu Wang wrote:
> On Wed, Feb 21, 2024 at 7:10 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>>
>> On 19/02/2024 13:56, Mauro Carvalho Chehab wrote:
>>> Em Mon, 19 Feb 2024 12:05:02 +0800
>>> Shengjiu Wang <shengjiu.wang@gmail.com> escreveu:
>>>
>>>> Hi Mauro
>>>>
>>>> On Sat, Feb 17, 2024 at 5:19 PM Mauro Carvalho Chehab
>>>> <mchehab@kernel.org> wrote:
>>>>>
>>>>> Em Thu, 18 Jan 2024 20:32:01 +0800
>>>>> Shengjiu Wang <shengjiu.wang@nxp.com> escreveu:
>>>>>
>>>>>> The audio sample format definition is from alsa,
>>>>>> the header file is include/uapi/sound/asound.h, but
>>>>>> don't include this header file directly, because in
>>>>>> user space, there is another copy in alsa-lib.
>>>>>> There will be conflict in userspace for include
>>>>>> videodev2.h & asound.h and asoundlib.h
>>>>>>
>>>>>> Here still use the fourcc format.
>>>>>>
>>>>>> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
>>>>>> ---
>>>>>>  .../userspace-api/media/v4l/pixfmt-audio.rst  | 87 +++++++++++++++++++
>>>>>>  .../userspace-api/media/v4l/pixfmt.rst        |  1 +
>>>>>>  drivers/media/v4l2-core/v4l2-ioctl.c          | 13 +++
>>>>>>  include/uapi/linux/videodev2.h                | 23 +++++
>>>>>>  4 files changed, 124 insertions(+)
>>>>>>  create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-audio.rst
>>>>>>
>>>>>> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-audio.rst b/Documentation/userspace-api/media/v4l/pixfmt-audio.rst
>>>>>> new file mode 100644
>>>>>> index 000000000000..04b4a7fbd8f4
>>>>>> --- /dev/null
>>>>>> +++ b/Documentation/userspace-api/media/v4l/pixfmt-audio.rst
>>>>>> @@ -0,0 +1,87 @@
>>>>>> +.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
>>>>>> +
>>>>>> +.. _pixfmt-audio:
>>>>>> +
>>>>>> +*************
>>>>>> +Audio Formats
>>>>>> +*************
>>>>>> +
>>>>>> +These formats are used for :ref:`audiomem2mem` interface only.
>>>>>> +
>>>>>> +.. tabularcolumns:: |p{5.8cm}|p{1.2cm}|p{10.3cm}|
>>>>>> +
>>>>>> +.. cssclass:: longtable
>>>>>> +
>>>>>> +.. flat-table:: Audio Format
>>>>>> +    :header-rows:  1
>>>>>> +    :stub-columns: 0
>>>>>> +    :widths:       3 1 4
>>>>>> +
>>>>>> +    * - Identifier
>>>>>> +      - Code
>>>>>> +      - Details
>>>>>> +    * .. _V4L2-AUDIO-FMT-S8:
>>>>>> +
>>>>>> +      - ``V4L2_AUDIO_FMT_S8``
>>>>>> +      - 'S8'
>>>>>> +      - Corresponds to SNDRV_PCM_FORMAT_S8 in ALSA
>>>>>> +    * .. _V4L2-AUDIO-FMT-S16-LE:
>>>>>
>>>>> Hmm... why can't we just use SNDRV_*_FORMAT_*? Those are already part of
>>>>> an uAPI header. No need to add any abstraction here and/or redefine
>>>>> what is there already at include/uapi/sound/asound.h.
>>>>>
>>>> Actually I try to avoid including the include/uapi/sound/asound.h.
>>>> Because in user space, there is another copy in alsa-lib (asoundlib.h).
>>>> There will be conflict in userspace when including videodev2.h and
>>>> asoundlib.h.
>>>
>>> Well, alsasoundlib.h seems to be using the same definitions:
>>>       https://github.com/michaelwu/alsa-lib/blob/master/include/pcm.h
>>>
>>> So, I can't see what would be the actual issue, as both userspace library
>>> and ALSA internal headers use the same magic numbers.
>>>
>>> You can still do things like:
>>>
>>>       #ifdef __KERNEL__
>>>       #  include <sound/asound.h>
>>>       #else
>>>       #  include <asoundlib.h>
>>>       #endif
>>>
>>> To avoid such kind of conflicts, if you need to have it included on
>>> some header file. Yet, I can't see why you would need that.
>>>
>>> IMO, at uAPI headers, you just need to declare the uAPI audiofmt field
>>> to be either __u32 or __u64, pointing it to where this value comes from
>>> (on both userspace and Kernelspace. E. g.:
>>>
>>> /**
>>>  * struct v4l2_audio_format - audio data format definition
>>>  * @audioformat:
>>>  *    an integer number matching the fields inside
>>>  *    enum snd_pcm_format_t (e. g. `SNDRV_PCM_FORMAT_*`), as defined
>>>  *    in include/uapi/sound/asound.h and
>>>  *      https://www.alsa-project.org/alsa-doc/alsa-lib/group___p_c_m.html#gaa14b7f26877a812acbb39811364177f8.
>>>  * @channels:         channel numbers
>>>  * @buffersize:               maximum size in bytes required for data
>>>  */
>>> struct v4l2_audio_format {
>>>       __u32                           audioformat;
>>>       __u32                           channels;
>>>       __u32                           buffersize;
>>> } __attribute__ ((packed));
>>>
>>> Then, at documentation you just need to point to where the
>>> possible values for SNDRV_PCM_FORMAT_ are defined. No need to
>>> document them one by one.
>>>
>>> With such definition, you'll only need to include sound/asound.h
>>> within the kAPI scope.
>>>
>>>>
>>>> And in the V4l framework, the fourcc type is commonly used in other
>>>> cases (video, radio, touch, meta....), to avoid changing common code
>>>> a lot, so I think using fourcc definition for audio may be simpler.
>>>
>>> Those are real video streams (or a video-related streams, in the case
>>> of metadata) where fourcc is widely used. There, it makes sense.
>>> However, ALSA format definitions are already being used for a long time.
>>> There's no sense on trying to reinvent it - or having an abstract layer
>>> to convert from/to fourcc <==> enum snd_pcm_format_t. Just use what is
>>> there already.
>>
>> The problem is that within V4L2 we use fourcc consistently to describe a
>> format, including in VIDIOC_ENUM_FMT. And the expectation is that the fourcc
>> can be printed to a human readable string (there is even a printk format for
>> that these days).
>>
>> But the pcm values are all small integers (and can even be 0!), and
>> printing the fourcc will give garbage. It doesn't work well at all
>> with the V4L2 API. But by having a straightforward conversion between the
>> pcm identifier and a fourcc it was really easy to deal with this.
>>
>> There might even be applications today that call VIDIOC_ENUM_FMT to see
>> what is supported and fail if it is not a proper fourcc is returned.
>>
>> It will certainly report nonsense in v4l_print_fmtdesc() (v4l2-ioctl.c).
>>
>> One of the early versions of this patch series did precisely what you request,
>> but it just doesn't work well within the V4L2 uAPI.
>>
> 
> Thanks all.
> 
> So can I reach the conclusion below?
> 1. Keep using the fourcc definition for v4l2_audio_format.audioformat.
> 2. Keep the name V4L2_BUF_TYPE_AUDIO_CAPTURE and
>     V4L2_BUF_TYPE_AUDIO_OUTPUT.
> 3. Fix Documentation/userspace-api/media/v4l/dev-audio-mem2mem.rst
>     to change 'pixelformat' to 'audioformat'.
> 4. Update Documentation/userspace-api/media/v4l/ext-ctrls-audio-m2m.rst
>     to add more description for clock drift.

Yes, let's go with that.

Regards,

	Hans

> 
> Best Regards
> Shengjiu Wang
> 
>> Regards,
>>
>>         Hans
>>
>>>
>>> Thanks,
>>> Mauro
>>


