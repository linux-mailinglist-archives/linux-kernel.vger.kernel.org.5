Return-Path: <linux-kernel+bounces-46176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF044843BD4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3C761C268CD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9AB69979;
	Wed, 31 Jan 2024 10:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="oBwNzubw"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1345069965;
	Wed, 31 Jan 2024 10:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706695569; cv=none; b=ljw2aQygXmmm2DBmwYBEb4E17HsDavGF51ZYaZcMfoVoQu892Uf4Js6iYzpVyPtR7JpQEKcO2IYYuUpT2WRRBDuIqOvYdHXLL+l7jGRv9LmRfaUx2U7Xu2p2+aJq5dM6XyuiU7d/UzCip9te8O6cF4FKmCyI+CK9QXoYl9XCSLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706695569; c=relaxed/simple;
	bh=MpuQqnLF66XI0eqOhn7879yMmtGSB4qkaz4eLFpnWNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ofElpx38vXAQeIMd009cW+/IT849TMioRcarGi+Htd5lR5arE3TONWZkNPvhiaffXtrdGdAkjjABSikaHYtsi3p0TI2QanVNaQAsnYDUaicJBBSozhVyP58H/dhVFp1tdM5h1gcbiljK5iRzij7ej30X455gE8ifmOTeGWEmZMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=oBwNzubw; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706695564;
	bh=MpuQqnLF66XI0eqOhn7879yMmtGSB4qkaz4eLFpnWNI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oBwNzubwdByfMM9ploFOJwWUN1AX2JRpDfKwiJbAekj0zUFGyyImFp9BGFYRBNGOV
	 rUUhHLuYi6XAijR9gUSEDw8hq9dC4ekpDmef3HUYuYSLu9EF2G4oSw/HhPvgPyBpgJ
	 bwoOAYsO/zEJiBcUwgU+mipPHkNSKU96rL1pQH01xhzdspIUF26CAGScoGXnMGUQVk
	 GE38JnW8kxLlqB/cfq9PmrkONyIburVaF5xkq2Tq3ywUVEBN9xj51quLuLLjqX2ZXe
	 hb++P2PIDL8FOP8FUUzh/1SJBBhT9hAL8+jEmIJlTZ9ye+PeY52AvSHVE2Ecgrum+x
	 tjsgc8P1mstUw==
Received: from [100.93.89.217] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B5BCA37811CF;
	Wed, 31 Jan 2024 10:06:03 +0000 (UTC)
Message-ID: <6a31726b-1e91-46b1-889c-4f643c759afb@collabora.com>
Date: Wed, 31 Jan 2024 11:06:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RCF 1/2] media: videodev2: Add V4L2_FMT_FLAG_ALL_FORMATS flag
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>, mchehab@kernel.org,
 p.zabel@pengutronix.de, hverkuil-cisco@xs4all.nl
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, kernel@collabora.com
References: <20240111160721.50020-1-benjamin.gaignard@collabora.com>
 <20240111160721.50020-2-benjamin.gaignard@collabora.com>
 <cc3944167e6b98470befd575520adb50cb8a45fa.camel@collabora.com>
Content-Language: en-US
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <cc3944167e6b98470befd575520adb50cb8a45fa.camel@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Le 17/01/2024 à 20:41, Nicolas Dufresne a écrit :
> Le jeudi 11 janvier 2024 à 17:07 +0100, Benjamin Gaignard a écrit :
>> Add new flag to allow enumerate all pixels formats when
>> calling VIDIOC_ENUM_FMT ioctl.
>> When this flag is set drivers must ignore the configuration
>> and return the hardware supported pixel formats for the specified queue.
>> This will permit to discover which pixels formats are supported
>> without setting codec-specific information so userland can more easily
>> knows if the driver suit well to what it needs.
>> The main target are stateless decoders so update the documentation
>> about how use this flag.
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>> ---
>>   .../userspace-api/media/v4l/dev-stateless-decoder.rst         | 3 +++
>>   Documentation/userspace-api/media/v4l/vidioc-enum-fmt.rst     | 4 ++++
>>   Documentation/userspace-api/media/videodev2.h.rst.exceptions  | 1 +
>>   drivers/media/v4l2-core/v4l2-ioctl.c                          | 2 +-
>>   include/uapi/linux/videodev2.h                                | 1 +
>>   5 files changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/userspace-api/media/v4l/dev-stateless-decoder.rst b/Documentation/userspace-api/media/v4l/dev-stateless-decoder.rst
>> index 35ed05f2695e..b7b650f1a18f 100644
>> --- a/Documentation/userspace-api/media/v4l/dev-stateless-decoder.rst
>> +++ b/Documentation/userspace-api/media/v4l/dev-stateless-decoder.rst
>> @@ -58,6 +58,9 @@ Querying capabilities
>>        default values for these controls being used, and a returned set of formats
>>        that may not be usable for the media the client is trying to decode.
>>   
>> +   * If ``V4L2_FMT_FLAG_ALL_FORMATS`` flag is set the driver must enumerate
>> +     all the supported formats without taking care of codec-dependent controls.
>> +
>>   3. The client may use :c:func:`VIDIOC_ENUM_FRAMESIZES` to detect supported
>>      resolutions for a given format, passing desired pixel format in
>>      :c:type:`v4l2_frmsizeenum`'s ``pixel_format``.
>> diff --git a/Documentation/userspace-api/media/v4l/vidioc-enum-fmt.rst b/Documentation/userspace-api/media/v4l/vidioc-enum-fmt.rst
>> index 000c154b0f98..db8bc8e29a91 100644
>> --- a/Documentation/userspace-api/media/v4l/vidioc-enum-fmt.rst
>> +++ b/Documentation/userspace-api/media/v4l/vidioc-enum-fmt.rst
>> @@ -227,6 +227,10 @@ the ``mbus_code`` field is handled differently:
>>   	The application can ask to configure the quantization of the capture
>>   	device when calling the :ref:`VIDIOC_S_FMT <VIDIOC_G_FMT>` ioctl with
>>   	:ref:`V4L2_PIX_FMT_FLAG_SET_CSC <v4l2-pix-fmt-flag-set-csc>` set.
>> +    * - ``V4L2_FMT_FLAG_ALL_FORMATS``
>> +      - 0x0200
>> +      - Set by userland application to enumerate all possible pixels formats
>> +        without taking care of the current configuration.
> This is a bit ambiguous regarding if OUTPUT queue FMT is ignored or not. From
> our chat, it is ignored in this implementation. Such if I use MTK VCODEC as an
> example, using that feature would return:

I will reword it for next version, but yes the goal of this flag is to enumerate
all pixels formats without taking care of any queue configuration.

>
> - MM21
> - MT2T
> - MT2R
>
> At high level, the use case is to find an easy way to combine the per codec
> profile information and the pixel format, since userspace can only use e.g.
> 10bit capability if it knows the associated pixel formats. This implementation
> is already useful in my opinion, I'll try and draft a GStreamer change to use
> it, as I think it will better support the idea. But it has come ceavats.
>
> Notably, if you had a userland that implement MT2T (VP9/AV1/HEVC) but not MT2R
> (H264), it would not have an easy API to figure-out. It would still have to
> resort into enumerating formats for each possible codec and codec specific
> compound control configuration.
>
> An alternative is to make this enumerate "all" for the configure OUTPUT format.
> This increase the precision, while still allowing generic code to be used. In
> pseudo code that would be like:
>
> for output formats
>    S_FMT(OUTPUT)
>
>    for ALL capture formats
>      store(format)
>
> Where right now we have do do:
>
>
> for output formats
>    S_FMT(OUTPUT)
>
>    S_CTRL(codec_specific_ctl_config_1)
>    for capture formats
>      store(format)
>
>
>    S_CTRL(codec_specific_ctl_config_n)
>    for capture format
>      store(format)
>    
>    ...
>
>    S_CTRL(codec_specific_ctl_config_n)
>    for capture formats
>      store(format)
>
> Where each config would demote a specific feature, like 10bit, 422, 444, film-
> grain (posprocessing affect output formats). The posprocessing remains a bit
> hard to figure-out in both cases though. But in practice, if I use Hantro AV1
> decoder as an example, I'd get something like:
>
>    NV15_4L4
>    P010
>
> Where NV15_4L4 is not available with filmgrain filter, but P010 is always
> available. For my GStreamer use case (template caps) this wouldn't be a problem,
> P010 is a well supported format and I strictly need a superset of the supported
> formats.
>
> What I'd really gain is that I don't have to do complicated enumeration logic
> per codec features.
>
> Nicolas
>
> p.s. It would be logical to update dev-stateless-decoder doc, to mention this
> enumeration option. Currently it says:
>
>
>     To enumerate the set of supported raw formats, the client calls
>     VIDIOC_ENUM_FMT() on the CAPTURE queue.
>     
>        *    The driver must return only the formats supported for the format
>        currently active on the OUTPUT queue.
>     
>        *    Depending on the currently set OUTPUT format, the set of supported
>        raw formats may depend on the value of some codec-dependent controls. The
>        client is responsible for making sure that these controls are set before
>        querying the CAPTURE queue. Failure to do so will result in the default
>        values for these controls being used, and a returned set of formats that
>        may not be usable for the media the client is trying to decode.

I have done it, look at the top of this patch.

>
>
>>   
>>   Return Value
>>   ============
>> diff --git a/Documentation/userspace-api/media/videodev2.h.rst.exceptions b/Documentation/userspace-api/media/videodev2.h.rst.exceptions
>> index 3e58aac4ef0b..42d9075b7fc2 100644
>> --- a/Documentation/userspace-api/media/videodev2.h.rst.exceptions
>> +++ b/Documentation/userspace-api/media/videodev2.h.rst.exceptions
>> @@ -215,6 +215,7 @@ replace define V4L2_FMT_FLAG_CSC_XFER_FUNC fmtdesc-flags
>>   replace define V4L2_FMT_FLAG_CSC_YCBCR_ENC fmtdesc-flags
>>   replace define V4L2_FMT_FLAG_CSC_HSV_ENC fmtdesc-flags
>>   replace define V4L2_FMT_FLAG_CSC_QUANTIZATION fmtdesc-flags
>> +replace define V4L2_FMT_FLAG_ALL_FORMATS fmtdesc-flags
>>   
>>   # V4L2 timecode types
>>   replace define V4L2_TC_TYPE_24FPS timecode-type
>> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
>> index 33076af4dfdb..22a93d074a5b 100644
>> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
>> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
>> @@ -1544,7 +1544,7 @@ static int v4l_enum_fmt(const struct v4l2_ioctl_ops *ops,
>>   		p->mbus_code = 0;
>>   
>>   	mbus_code = p->mbus_code;
>> -	memset_after(p, 0, type);
>> +	memset_after(p, 0, flags);
> In other similar places, we still clear the flags, and only keep the allowed
> bits. Maybe we should do this here too to avoid accidental flags going through ?
>
> That should maybe be under some capability flag, so that userland knows if the
> driver did implement that feature or not. If the driver didn't set that flag, we
> can then clear it so that userlands not checking that flag would at least get an
> enumeration response without it.

I will do that in next version.

Regards,
Benjamin

>
>>   	p->mbus_code = mbus_code;
>>   
>>   	switch (p->type) {
>> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
>> index 68e7ac178cc2..82d8c8a7fb7f 100644
>> --- a/include/uapi/linux/videodev2.h
>> +++ b/include/uapi/linux/videodev2.h
>> @@ -869,6 +869,7 @@ struct v4l2_fmtdesc {
>>   #define V4L2_FMT_FLAG_CSC_YCBCR_ENC		0x0080
>>   #define V4L2_FMT_FLAG_CSC_HSV_ENC		V4L2_FMT_FLAG_CSC_YCBCR_ENC
>>   #define V4L2_FMT_FLAG_CSC_QUANTIZATION		0x0100
>> +#define V4L2_FMT_FLAG_ALL_FORMATS		0x0200
>>   
>>   	/* Frame Size and frame rate enumeration */
>>   /*
>

