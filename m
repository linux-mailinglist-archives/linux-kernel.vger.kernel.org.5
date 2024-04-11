Return-Path: <linux-kernel+bounces-140307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 653438A1283
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0F4CB20E31
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E46C147C6E;
	Thu, 11 Apr 2024 11:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="tOZmC2K6"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FE913BACD;
	Thu, 11 Apr 2024 11:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712833663; cv=none; b=OBbffduSHMg41y6FSlAyXG0oOfySsSZvwwkYYqedNTRnQ8r4ljEB0PYHu5b6L+saZaa3DBsNV6YgXCULEwETH3oBahdI4HWRtgzga0LHW+cD1BNzO59Sg9IhyowPuG9TXX1giNUt91kMUA21B/WsBWGRPv7HFdbNdb6QNVFMbU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712833663; c=relaxed/simple;
	bh=h5OuDJgtEbFe3q4KYIRW7uepFv0Ks/6P0z4RdrDMBlQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=riieUWdpgWyznH9PgTvvkCWmxgvYS5lBuN57Y7YaEVzDd+IUUM1pB8w09qO4ZXLpuv1K2snFyle1KfPjkHs23FoGWZBtUuhDSxTgDQGNaRQoEyCUU2fqnyo5oFhrZO+JE5CGbwkPs+GVz05jjUfsxsYZHPOVzEEaJdU4NHhZERI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=tOZmC2K6; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.88.20] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id C1EF223F;
	Thu, 11 Apr 2024 13:06:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712833616;
	bh=h5OuDJgtEbFe3q4KYIRW7uepFv0Ks/6P0z4RdrDMBlQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tOZmC2K67N+xbU4PgLIrLYYH/7GlB5P2y+9RFj90nXXGsXE+Q973ZgseFp//PHWIT
	 N+gtxsFgcKRPuRJ4nilKg3/WgPzXqSahLUc8EJwLToCizHgPOlm1G+CjPvwXB4q7S6
	 IcPzX42CrDSKUqrHPm6MHvyzx3xh+jAn+dAep69A=
Message-ID: <72940e89-0384-4fd3-8a10-42d6db44fdf0@ideasonboard.com>
Date: Thu, 11 Apr 2024 14:07:34 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 9/9] media: subdev: Support single-stream case in
 v4l2_subdev_enable/disable_streams()
To: Umang Jain <umang.jain@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil
 <hverkuil@xs4all.nl>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>
References: <20240410-enable-streams-impro-v3-0-e5e7a5da7420@ideasonboard.com>
 <20240410-enable-streams-impro-v3-9-e5e7a5da7420@ideasonboard.com>
 <f8e293b7-6a06-4477-9c7e-d1b83163f8e1@ideasonboard.com>
Content-Language: en-US
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Autocrypt: addr=tomi.valkeinen@ideasonboard.com; keydata=
 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
In-Reply-To: <f8e293b7-6a06-4477-9c7e-d1b83163f8e1@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/04/2024 14:02, Umang Jain wrote:
> Hi Tomi,
> 
> On 10/04/24 6:05 pm, Tomi Valkeinen wrote:
>> At the moment the v4l2_subdev_enable/disable_streams() functions call
>> fallback helpers to handle the case where the subdev only implements
>> .s_stream(), and the main function handles the case where the subdev
>> implements streams (V4L2_SUBDEV_FL_STREAMS, which implies
>> .enable/disable_streams()).
>>
>> What is missing is support for subdevs which do not implement streams
>> support, but do implement .enable/disable_streams(). Example cases of
>> these subdevices are single-stream cameras, where using
>> .enable/disable_streams() is not required but helps us remove the users
>> of the legacy .s_stream(), and subdevices with multiple source pads (but
>> single stream per pad), where .enable/disable_streams() allows the
>> subdevice to control the enable/disable state per pad.
>>
>> The two single-streams cases (.s_stream() and .enable/disable_streams())
>> are very similar, and with small changes we can change the
>> v4l2_subdev_enable/disable_streams() functions to support all three
>> cases, without needing separate fallback functions.
>>
>> A few potentially problematic details, though:
> 
> Does this mean the patch needs to be worked upon more ?

I don't see the two issues below as blockers.

> I quickly tested the series by applying it locally with my use case of 
> IMX283 .enable/disable streams and s_stream as the helper function and 
> it seems I am still seeing the same behaviour as before (i.e. not being 
> streamed) and have to carry the workaround as mentioned in [1] **NOTE**

Ok... Then something bugs here, as it is supposed to fix the problem. 
Can you trace the code a bit to see where it goes wrong?

The execution should go to the "if (!(sd->flags & 
V4L2_SUBDEV_FL_STREAMS))" blocks in v4l2_subdev_collect_streams() and 
v4l2_subdev_set_streams_enabled(),

  Tomi

> 
> [1] 
> https://lore.kernel.org/linux-media/20240313070705.91140-1-umang.jain@ideasonboard.com/
> 
>>
>> - For the single-streams cases we use sd->enabled_pads field, which
>>    limits the number of pads for the subdevice to 64. For simplicity I
>>    added the check for this limitation to the beginning of the function,
>>    and it also applies to the streams case.
>>
>> - The fallback functions only allowed the target pad to be a source pad.
>>    It is not very clear to me why this check was needed, but it was not
>>    needed in the streams case. However, I doubt the
>>    v4l2_subdev_enable/disable_streams() code has ever been tested with
>>    sink pads, so to be on the safe side, I added the same check
>>    to the v4l2_subdev_enable/disable_streams() functions.
>>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>> ---
>>   drivers/media/v4l2-core/v4l2-subdev.c | 187 
>> ++++++++++++++--------------------
>>   1 file changed, 79 insertions(+), 108 deletions(-)
>>
>> diff --git a/drivers/media/v4l2-core/v4l2-subdev.c 
>> b/drivers/media/v4l2-core/v4l2-subdev.c
>> index 0d376d72ecc7..4a73886741f9 100644
>> --- a/drivers/media/v4l2-core/v4l2-subdev.c
>> +++ b/drivers/media/v4l2-core/v4l2-subdev.c
>> @@ -2106,6 +2106,13 @@ static void v4l2_subdev_collect_streams(struct 
>> v4l2_subdev *sd,
>>                       u64 *found_streams,
>>                       u64 *enabled_streams)
>>   {
>> +    if (!(sd->flags & V4L2_SUBDEV_FL_STREAMS)) {
>> +        *found_streams = BIT_ULL(0);
>> +        if (sd->enabled_pads & BIT_ULL(pad))
>> +            *enabled_streams = BIT_ULL(0);
>> +        return;
>> +    }
>> +
>>       *found_streams = 0;
>>       *enabled_streams = 0;
>> @@ -2127,6 +2134,14 @@ static void 
>> v4l2_subdev_set_streams_enabled(struct v4l2_subdev *sd,
>>                           u32 pad, u64 streams_mask,
>>                           bool enabled)
>>   {
>> +    if (!(sd->flags & V4L2_SUBDEV_FL_STREAMS)) {
>> +        if (enabled)
>> +            sd->enabled_pads |= BIT_ULL(pad);
>> +        else
>> +            sd->enabled_pads &= ~BIT_ULL(pad);
>> +        return;
>> +    }
>> +
>>       for (unsigned int i = 0; i < state->stream_configs.num_configs; 
>> ++i) {
>>           struct v4l2_subdev_stream_config *cfg =
>>               &state->stream_configs.configs[i];
>> @@ -2136,51 +2151,6 @@ static void 
>> v4l2_subdev_set_streams_enabled(struct v4l2_subdev *sd,
>>       }
>>   }
>> -static int v4l2_subdev_enable_streams_fallback(struct v4l2_subdev 
>> *sd, u32 pad,
>> -                           u64 streams_mask)
>> -{
>> -    struct device *dev = sd->entity.graph_obj.mdev->dev;
>> -    int ret;
>> -
>> -    /*
>> -     * The subdev doesn't implement pad-based stream enable, fall back
>> -     * to the .s_stream() operation.
>> -     */
>> -    if (!(sd->entity.pads[pad].flags & MEDIA_PAD_FL_SOURCE))
>> -        return -EOPNOTSUPP;
>> -
>> -    /*
>> -     * .s_stream() means there is no streams support, so only allowed 
>> stream
>> -     * is the implicit stream 0.
>> -     */
>> -    if (streams_mask != BIT_ULL(0))
>> -        return -EOPNOTSUPP;
>> -
>> -    /*
>> -     * We use a 64-bit bitmask for tracking enabled pads, so only 
>> subdevices
>> -     * with 64 pads or less can be supported.
>> -     */
>> -    if (pad >= sizeof(sd->enabled_pads) * BITS_PER_BYTE)
>> -        return -EOPNOTSUPP;
>> -
>> -    if (sd->enabled_pads & BIT_ULL(pad)) {
>> -        dev_dbg(dev, "pad %u already enabled on %s\n",
>> -            pad, sd->entity.name);
>> -        return -EALREADY;
>> -    }
>> -
>> -    /* Start streaming when the first pad is enabled. */
>> -    if (!sd->enabled_pads) {
>> -        ret = v4l2_subdev_call(sd, video, s_stream, 1);
>> -        if (ret)
>> -            return ret;
>> -    }
>> -
>> -    sd->enabled_pads |= BIT_ULL(pad);
>> -
>> -    return 0;
>> -}
>> -
>>   int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
>>                      u64 streams_mask)
>>   {
>> @@ -2189,21 +2159,33 @@ int v4l2_subdev_enable_streams(struct 
>> v4l2_subdev *sd, u32 pad,
>>       bool already_streaming;
>>       u64 enabled_streams;
>>       u64 found_streams;
>> +    bool use_s_stream;
>>       int ret;
>>       /* A few basic sanity checks first. */
>>       if (pad >= sd->entity.num_pads)
>>           return -EINVAL;
>> +    if (!(sd->entity.pads[pad].flags & MEDIA_PAD_FL_SOURCE))
>> +        return -EOPNOTSUPP;
>> +
>> +    /*
>> +     * We use a 64-bit bitmask for tracking enabled pads, so only 
>> subdevices
>> +     * with 64 pads or less can be supported.
>> +     */
>> +    if (pad >= sizeof(sd->enabled_pads) * BITS_PER_BYTE)
>> +        return -EOPNOTSUPP;
>> +
>>       if (!streams_mask)
>>           return 0;
>>       /* Fallback on .s_stream() if .enable_streams() isn't available. */
>> -    if (!v4l2_subdev_has_op(sd, pad, enable_streams))
>> -        return v4l2_subdev_enable_streams_fallback(sd, pad,
>> -                               streams_mask);
>> +    use_s_stream = !v4l2_subdev_has_op(sd, pad, enable_streams);
>> -    state = v4l2_subdev_lock_and_get_active_state(sd);
>> +    if (!use_s_stream)
>> +        state = v4l2_subdev_lock_and_get_active_state(sd);
>> +    else
>> +        state = NULL;
>>       /*
>>        * Verify that the requested streams exist and that they are not
>> @@ -2231,9 +2213,18 @@ int v4l2_subdev_enable_streams(struct 
>> v4l2_subdev *sd, u32 pad,
>>       already_streaming = v4l2_subdev_is_streaming(sd);
>> -    /* Call the .enable_streams() operation. */
>> -    ret = v4l2_subdev_call(sd, pad, enable_streams, state, pad,
>> -                   streams_mask);
>> +    if (!use_s_stream) {
>> +        /* Call the .enable_streams() operation. */
>> +        ret = v4l2_subdev_call(sd, pad, enable_streams, state, pad,
>> +                       streams_mask);
>> +    } else {
>> +        /* Start streaming when the first pad is enabled. */
>> +        if (!already_streaming)
>> +            ret = v4l2_subdev_call(sd, video, s_stream, 1);
>> +        else
>> +            ret = 0;
>> +    }
>> +
>>       if (ret) {
>>           dev_dbg(dev, "enable streams %u:%#llx failed: %d\n", pad,
>>               streams_mask, ret);
>> @@ -2243,34 +2234,32 @@ int v4l2_subdev_enable_streams(struct 
>> v4l2_subdev *sd, u32 pad,
>>       /* Mark the streams as enabled. */
>>       v4l2_subdev_set_streams_enabled(sd, state, pad, streams_mask, 
>> true);
>> -    if (!already_streaming)
>> +    if (!use_s_stream && !already_streaming)
>>           v4l2_subdev_enable_privacy_led(sd);
>>   done:
>> -    v4l2_subdev_unlock_state(state);
>> +    if (!use_s_stream)
>> +        v4l2_subdev_unlock_state(state);
>>       return ret;
>>   }
>>   EXPORT_SYMBOL_GPL(v4l2_subdev_enable_streams);
>> -static int v4l2_subdev_disable_streams_fallback(struct v4l2_subdev 
>> *sd, u32 pad,
>> -                        u64 streams_mask)
>> +int v4l2_subdev_disable_streams(struct v4l2_subdev *sd, u32 pad,
>> +                u64 streams_mask)
>>   {
>>       struct device *dev = sd->entity.graph_obj.mdev->dev;
>> +    struct v4l2_subdev_state *state;
>> +    u64 enabled_streams;
>> +    u64 found_streams;
>> +    bool use_s_stream;
>>       int ret;
>> -    /*
>> -     * If the subdev doesn't implement pad-based stream enable, fall 
>> back
>> -     * to the .s_stream() operation.
>> -     */
>> -    if (!(sd->entity.pads[pad].flags & MEDIA_PAD_FL_SOURCE))
>> -        return -EOPNOTSUPP;
>> +    /* A few basic sanity checks first. */
>> +    if (pad >= sd->entity.num_pads)
>> +        return -EINVAL;
>> -    /*
>> -     * .s_stream() means there is no streams support, so only allowed 
>> stream
>> -     * is the implicit stream 0.
>> -     */
>> -    if (streams_mask != BIT_ULL(0))
>> +    if (!(sd->entity.pads[pad].flags & MEDIA_PAD_FL_SOURCE))
>>           return -EOPNOTSUPP;
>>       /*
>> @@ -2280,46 +2269,16 @@ static int 
>> v4l2_subdev_disable_streams_fallback(struct v4l2_subdev *sd, u32 pad,
>>       if (pad >= sizeof(sd->enabled_pads) * BITS_PER_BYTE)
>>           return -EOPNOTSUPP;
>> -    if (!(sd->enabled_pads & BIT_ULL(pad))) {
>> -        dev_dbg(dev, "pad %u already disabled on %s\n",
>> -            pad, sd->entity.name);
>> -        return -EALREADY;
>> -    }
>> -
>> -    /* Stop streaming when the last streams are disabled. */
>> -    if (!(sd->enabled_pads & ~BIT_ULL(pad))) {
>> -        ret = v4l2_subdev_call(sd, video, s_stream, 0);
>> -        if (ret)
>> -            return ret;
>> -    }
>> -
>> -    sd->enabled_pads &= ~BIT_ULL(pad);
>> -
>> -    return 0;
>> -}
>> -
>> -int v4l2_subdev_disable_streams(struct v4l2_subdev *sd, u32 pad,
>> -                u64 streams_mask)
>> -{
>> -    struct device *dev = sd->entity.graph_obj.mdev->dev;
>> -    struct v4l2_subdev_state *state;
>> -    u64 enabled_streams;
>> -    u64 found_streams;
>> -    int ret;
>> -
>> -    /* A few basic sanity checks first. */
>> -    if (pad >= sd->entity.num_pads)
>> -        return -EINVAL;
>> -
>>       if (!streams_mask)
>>           return 0;
>>       /* Fallback on .s_stream() if .disable_streams() isn't 
>> available. */
>> -    if (!v4l2_subdev_has_op(sd, pad, disable_streams))
>> -        return v4l2_subdev_disable_streams_fallback(sd, pad,
>> -                                streams_mask);
>> +    use_s_stream = !v4l2_subdev_has_op(sd, pad, disable_streams);
>> -    state = v4l2_subdev_lock_and_get_active_state(sd);
>> +    if (!use_s_stream)
>> +        state = v4l2_subdev_lock_and_get_active_state(sd);
>> +    else
>> +        state = NULL;
>>       /*
>>        * Verify that the requested streams exist and that they are not
>> @@ -2345,9 +2304,19 @@ int v4l2_subdev_disable_streams(struct 
>> v4l2_subdev *sd, u32 pad,
>>       dev_dbg(dev, "disable streams %u:%#llx\n", pad, streams_mask);
>> -    /* Call the .disable_streams() operation. */
>> -    ret = v4l2_subdev_call(sd, pad, disable_streams, state, pad,
>> -                   streams_mask);
>> +    if (!use_s_stream) {
>> +        /* Call the .disable_streams() operation. */
>> +        ret = v4l2_subdev_call(sd, pad, disable_streams, state, pad,
>> +                       streams_mask);
>> +    } else {
>> +        /* Stop streaming when the last streams are disabled. */
>> +
>> +        if (!(sd->enabled_pads & ~BIT_ULL(pad)))
>> +            ret = v4l2_subdev_call(sd, video, s_stream, 0);
>> +        else
>> +            ret = 0;
>> +    }
>> +
>>       if (ret) {
>>           dev_dbg(dev, "disable streams %u:%#llx failed: %d\n", pad,
>>               streams_mask, ret);
>> @@ -2357,10 +2326,12 @@ int v4l2_subdev_disable_streams(struct 
>> v4l2_subdev *sd, u32 pad,
>>       v4l2_subdev_set_streams_enabled(sd, state, pad, streams_mask, 
>> false);
>>   done:
>> -    if (!v4l2_subdev_is_streaming(sd))
>> -        v4l2_subdev_disable_privacy_led(sd);
>> +    if (!use_s_stream) {
>> +        if (!v4l2_subdev_is_streaming(sd))
>> +            v4l2_subdev_disable_privacy_led(sd);
>> -    v4l2_subdev_unlock_state(state);
>> +        v4l2_subdev_unlock_state(state);
>> +    }
>>       return ret;
>>   }
>>
> 


