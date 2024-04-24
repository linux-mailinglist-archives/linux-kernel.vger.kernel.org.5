Return-Path: <linux-kernel+bounces-157006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E98688B0B7D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6F40B283F2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B03915D5C3;
	Wed, 24 Apr 2024 13:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="V3VlPNq9"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA0615CD51;
	Wed, 24 Apr 2024 13:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713966621; cv=none; b=QAMXHMjG/e1pv4vMNHxQo33Hc1T2uGQ5OmA/uduHrJudodcvRE5JVB0uHJD9OePw7yDk0HpHrk9vkKRxkd4exiaPoqotX5IPOuI4kmY1sMqh8ZZOnPEZLyJN70aYVcX+WK+cjr5BNmmiY5leX9JUhD06edGHQM2Ty5PG6d/3s74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713966621; c=relaxed/simple;
	bh=q/ExYKiFEVjwmIVjlK9eTcgI5PfKZml0hLK7Keoic9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HVEviR3OfFKY4yWyHlCT/hUXlfRKP7SoY5IaWwZxCThDM0caXHOMS3pos64WdSCmqKefzuCKz4aQXKOV0coOuPH9mRpBgj4TBm3dSVGL885B5jRHBwFZnCs47Hpn8kzj913dNU+euWt+xZfgDq7Y442UPcYyqmM6Lkpkm+MaVr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=V3VlPNq9; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.88.20] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id C04CEB1;
	Wed, 24 Apr 2024 15:49:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1713966565;
	bh=q/ExYKiFEVjwmIVjlK9eTcgI5PfKZml0hLK7Keoic9A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=V3VlPNq9EIaDrItMBVEWs7vMifV8cFm5j+0ptQU7R4HqWZAGPvQH/gjGVkeHgN+Fy
	 cEHUXVmN4rSOtVbUsloNS4ezhdqc2Suw9qB3eC683NN9jDYGtTkWV74tmhVxrmCdMW
	 4fj+6t2YZX68LvuzAZGWbTuGHz+d//D6bHZe5Hn8=
Message-ID: <552f33b1-02b5-4fc4-98d2-15da4ddf136a@ideasonboard.com>
Date: Wed, 24 Apr 2024 16:50:14 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/10] media: subdev: Support single-stream case in
 v4l2_subdev_enable/disable_streams()
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Hans Verkuil <hverkuil@xs4all.nl>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Umang Jain <umang.jain@ideasonboard.com>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240416-enable-streams-impro-v5-0-bd5fcea49388@ideasonboard.com>
 <20240416-enable-streams-impro-v5-9-bd5fcea49388@ideasonboard.com>
 <20240419153603.GE12651@pendragon.ideasonboard.com>
 <7ed5e8cf-2bcc-4d4c-a1dc-17592b5909c0@ideasonboard.com>
 <20240424130922.GG18608@pendragon.ideasonboard.com>
 <6e2eeba1-236f-481e-9e35-460f26549698@ideasonboard.com>
 <20240424131733.GH18608@pendragon.ideasonboard.com>
Content-Language: en-US
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Autocrypt: addr=tomi.valkeinen@ideasonboard.com; keydata=
 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
In-Reply-To: <20240424131733.GH18608@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/04/2024 16:17, Laurent Pinchart wrote:
> On Wed, Apr 24, 2024 at 04:11:36PM +0300, Tomi Valkeinen wrote:
>> On 24/04/2024 16:09, Laurent Pinchart wrote:
>>> On Wed, Apr 24, 2024 at 04:05:31PM +0300, Tomi Valkeinen wrote:
>>>> On 19/04/2024 18:36, Laurent Pinchart wrote:
>>>>> On Tue, Apr 16, 2024 at 04:55:12PM +0300, Tomi Valkeinen wrote:
>>>>>> At the moment the v4l2_subdev_enable/disable_streams() functions call
>>>>>> fallback helpers to handle the case where the subdev only implements
>>>>>> .s_stream(), and the main function handles the case where the subdev
>>>>>> implements streams (V4L2_SUBDEV_FL_STREAMS, which implies
>>>>>> .enable/disable_streams()).
>>>>>>
>>>>>> What is missing is support for subdevs which do not implement streams
>>>>>> support, but do implement .enable/disable_streams(). Example cases of
>>>>>> these subdevices are single-stream cameras, where using
>>>>>> .enable/disable_streams() is not required but helps us remove the users
>>>>>> of the legacy .s_stream(), and subdevices with multiple source pads (but
>>>>>> single stream per pad), where .enable/disable_streams() allows the
>>>>>> subdevice to control the enable/disable state per pad.
>>>>>>
>>>>>> The two single-streams cases (.s_stream() and .enable/disable_streams())
>>>>>> are very similar, and with small changes we can change the
>>>>>> v4l2_subdev_enable/disable_streams() functions to support all three
>>>>>> cases, without needing separate fallback functions.
>>>>>>
>>>>>> A few potentially problematic details, though:
>>>>>>
>>>>>> - For the single-streams cases we use sd->enabled_pads field, which
>>>>>>      limits the number of pads for the subdevice to 64. For simplicity I
>>>>>>      added the check for this limitation to the beginning of the function,
>>>>>>      and it also applies to the streams case.
>>>>>>
>>>>>> - The fallback functions only allowed the target pad to be a source pad.
>>>>>>      It is not very clear to me why this check was needed, but it was not
>>>>>>      needed in the streams case. However, I doubt the
>>>>>>      v4l2_subdev_enable/disable_streams() code has ever been tested with
>>>>>>      sink pads, so to be on the safe side, I added the same check
>>>>>>      to the v4l2_subdev_enable/disable_streams() functions.
>>>>>>
>>>>>
>>>>> Now that v4l2_subdev_enable_streams() is usable by (almost) every
>>>>> driver, should we update documentation to indicate that manual calls to
>>>>> .s_stream() should be avoided ?
>>>>
>>>> How about:
>>>>
>>>> diff --git a/include/media/v4l2-subdev.h b/include/media/v4l2-subdev.h
>>>> index dabe1b5dfe4a..f52bb790773c 100644
>>>> --- a/include/media/v4l2-subdev.h
>>>> +++ b/include/media/v4l2-subdev.h
>>>> @@ -450,6 +450,11 @@ enum v4l2_subdev_pre_streamon_flags {
>>>>     *     already started or stopped subdev. Also see call_s_stream wrapper in
>>>>     *     v4l2-subdev.c.
>>>>     *
>>>> + *     New drivers should instead implement &v4l2_subdev_pad_ops.enable_streams
>>>> + *     and &v4l2_subdev_pad_ops.disable_streams operations, and use
>>>> + *     v4l2_subdev_s_stream_helper for the &v4l2_subdev_video_ops.s_stream
>>>> + *     operation to support legacy users.A
>>>> + *
>>>
>>> Add
>>>
>>>    *	Drivers should also not call the .s_stream() subdev operation directly,
>>>    *	but use the v4l2_subdev_enable_streams() and
>>>    *	v4l2_subdev_disable_streams() helpers.
>>>
>>>>     * @g_pixelaspect: callback to return the pixelaspect ratio.
>>>>     *
>>>>     * @s_dv_timings: Set custom dv timings in the sub device. This is used
>>>>
>>>>
>>>> Although now that I think about it, can we "ever" get rid of s_stream?
>>>> enable_streams is only usable if the subdev has pads.
>>>
>>> Do we have pad-less subdevs that can stream ?
>>
>> Probably not, but isn't s_stream used to enable any type of subdev? Or
>> is there a different op to power on padless subdevs?
> 
> .s_stream() is supposed to start/stop streaming, and you can't really
> have streams without pads, as they have to come from/go somewhere.

Ok. I was under the impression that .s_stream() is also used to enable 
non-streaming subdevs when the pipeline's streaming is started. If 
that's not the case, I'll update the doc.

  Tomi

>>>> If that's the
>>>> case, the text above should probably clarify when one should continue
>>>> using s_stream.
>>>>
>>>>>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>>>>>> ---
>>>>>>     drivers/media/v4l2-core/v4l2-subdev.c | 187 ++++++++++++++--------------------
>>>>>>     1 file changed, 79 insertions(+), 108 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
>>>>>> index e45fd42da1e3..10406acfb9d0 100644
>>>>>> --- a/drivers/media/v4l2-core/v4l2-subdev.c
>>>>>> +++ b/drivers/media/v4l2-core/v4l2-subdev.c
>>>>>> @@ -2106,6 +2106,13 @@ static void v4l2_subdev_collect_streams(struct v4l2_subdev *sd,
>>>>>>     					u64 *found_streams,
>>>>>>     					u64 *enabled_streams)
>>>>>>     {
>>>>>> +	if (!(sd->flags & V4L2_SUBDEV_FL_STREAMS)) {
>>>>>> +		*found_streams = BIT_ULL(0);
>>>>>> +		*enabled_streams =
>>>>>> +			(sd->enabled_pads & BIT_ULL(pad)) ? BIT_ULL(0) : 0;
>>>>>> +		return;
>>>>>> +	}
>>>>>> +
>>>>>>     	*found_streams = 0;
>>>>>>     	*enabled_streams = 0;
>>>>>>     
>>>>>> @@ -2127,6 +2134,14 @@ static void v4l2_subdev_set_streams_enabled(struct v4l2_subdev *sd,
>>>>>>     					    u32 pad, u64 streams_mask,
>>>>>>     					    bool enabled)
>>>>>>     {
>>>>>> +	if (!(sd->flags & V4L2_SUBDEV_FL_STREAMS)) {
>>>>>> +		if (enabled)
>>>>>> +			sd->enabled_pads |= BIT_ULL(pad);
>>>>>> +		else
>>>>>> +			sd->enabled_pads &= ~BIT_ULL(pad);
>>>>>> +		return;
>>>>>> +	}
>>>>>> +
>>>>>>     	for (unsigned int i = 0; i < state->stream_configs.num_configs; ++i) {
>>>>>>     		struct v4l2_subdev_stream_config *cfg =
>>>>>>     			&state->stream_configs.configs[i];
>>>>>> @@ -2136,51 +2151,6 @@ static void v4l2_subdev_set_streams_enabled(struct v4l2_subdev *sd,
>>>>>>     	}
>>>>>>     }
>>>>>>     
>>>>>> -static int v4l2_subdev_enable_streams_fallback(struct v4l2_subdev *sd, u32 pad,
>>>>>> -					       u64 streams_mask)
>>>>>> -{
>>>>>> -	struct device *dev = sd->entity.graph_obj.mdev->dev;
>>>>>> -	int ret;
>>>>>> -
>>>>>> -	/*
>>>>>> -	 * The subdev doesn't implement pad-based stream enable, fall back
>>>>>> -	 * to the .s_stream() operation.
>>>>>> -	 */
>>>>>> -	if (!(sd->entity.pads[pad].flags & MEDIA_PAD_FL_SOURCE))
>>>>>> -		return -EOPNOTSUPP;
>>>>>> -
>>>>>> -	/*
>>>>>> -	 * .s_stream() means there is no streams support, so the only allowed
>>>>>> -	 * stream is the implicit stream 0.
>>>>>> -	 */
>>>>>> -	if (streams_mask != BIT_ULL(0))
>>>>>> -		return -EOPNOTSUPP;
>>>>>> -
>>>>>> -	/*
>>>>>> -	 * We use a 64-bit bitmask for tracking enabled pads, so only subdevices
>>>>>> -	 * with 64 pads or less can be supported.
>>>>>> -	 */
>>>>>> -	if (pad >= sizeof(sd->enabled_pads) * BITS_PER_BYTE)
>>>>>> -		return -EOPNOTSUPP;
>>>>>> -
>>>>>> -	if (sd->enabled_pads & BIT_ULL(pad)) {
>>>>>> -		dev_dbg(dev, "pad %u already enabled on %s\n",
>>>>>> -			pad, sd->entity.name);
>>>>>> -		return -EALREADY;
>>>>>> -	}
>>>>>> -
>>>>>> -	/* Start streaming when the first pad is enabled. */
>>>>>> -	if (!sd->enabled_pads) {
>>>>>> -		ret = v4l2_subdev_call(sd, video, s_stream, 1);
>>>>>> -		if (ret)
>>>>>> -			return ret;
>>>>>> -	}
>>>>>> -
>>>>>> -	sd->enabled_pads |= BIT_ULL(pad);
>>>>>> -
>>>>>> -	return 0;
>>>>>> -}
>>>>>> -
>>>>>>     int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
>>>>>>     			       u64 streams_mask)
>>>>>>     {
>>>>>> @@ -2189,21 +2159,33 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
>>>>>>     	bool already_streaming;
>>>>>>     	u64 enabled_streams;
>>>>>>     	u64 found_streams;
>>>>>> +	bool use_s_stream;
>>>>>>     	int ret;
>>>>>>     
>>>>>>     	/* A few basic sanity checks first. */
>>>>>>     	if (pad >= sd->entity.num_pads)
>>>>>>     		return -EINVAL;
>>>>>>     
>>>>>> +	if (!(sd->entity.pads[pad].flags & MEDIA_PAD_FL_SOURCE))
>>>>>> +		return -EOPNOTSUPP;
>>>>>> +
>>>>>> +	/*
>>>>>> +	 * We use a 64-bit bitmask for tracking enabled pads, so only subdevices
>>>>>> +	 * with 64 pads or less can be supported.
>>>>>> +	 */
>>>>>> +	if (pad >= sizeof(sd->enabled_pads) * BITS_PER_BYTE)
>>>>>> +		return -EOPNOTSUPP;
>>>>>> +
>>>>>>     	if (!streams_mask)
>>>>>>     		return 0;
>>>>>>     
>>>>>>     	/* Fallback on .s_stream() if .enable_streams() isn't available. */
>>>>>> -	if (!v4l2_subdev_has_op(sd, pad, enable_streams))
>>>>>> -		return v4l2_subdev_enable_streams_fallback(sd, pad,
>>>>>> -							   streams_mask);
>>>>>> +	use_s_stream = !v4l2_subdev_has_op(sd, pad, enable_streams);
>>>>>>     
>>>>>> -	state = v4l2_subdev_lock_and_get_active_state(sd);
>>>>>> +	if (!use_s_stream)
>>>>>> +		state = v4l2_subdev_lock_and_get_active_state(sd);
>>>>>> +	else
>>>>>> +		state = NULL;
>>>>>>     
>>>>>>     	/*
>>>>>>     	 * Verify that the requested streams exist and that they are not
>>>>>> @@ -2231,9 +2213,18 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
>>>>>>     
>>>>>>     	already_streaming = v4l2_subdev_is_streaming(sd);
>>>>>>     
>>>>>> -	/* Call the .enable_streams() operation. */
>>>>>> -	ret = v4l2_subdev_call(sd, pad, enable_streams, state, pad,
>>>>>> -			       streams_mask);
>>>>>> +	if (!use_s_stream) {
>>>>>> +		/* Call the .enable_streams() operation. */
>>>>>> +		ret = v4l2_subdev_call(sd, pad, enable_streams, state, pad,
>>>>>> +				       streams_mask);
>>>>>> +	} else {
>>>>>> +		/* Start streaming when the first pad is enabled. */
>>>>>> +		if (!already_streaming)
>>>>>> +			ret = v4l2_subdev_call(sd, video, s_stream, 1);
>>>>>> +		else
>>>>>> +			ret = 0;
>>>>>> +	}
>>>>>> +
>>>>>>     	if (ret) {
>>>>>>     		dev_dbg(dev, "enable streams %u:%#llx failed: %d\n", pad,
>>>>>>     			streams_mask, ret);
>>>>>> @@ -2243,34 +2234,32 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
>>>>>>     	/* Mark the streams as enabled. */
>>>>>>     	v4l2_subdev_set_streams_enabled(sd, state, pad, streams_mask, true);
>>>>>
>>>>> state gets set to a non-null value above if the subdev has an
>>>>> enable_streams operation, while in v4l2_subdev_set_streams_enabled(),
>>>>
>>>> That's not quite true, v4l2_subdev_lock_and_get_active_state() returns
>>>> NULL if there's no state. If the driver has .enable_streams but no
>>>> subdev-state, we'll have NULL state. But is that a driver bug? Probably,
>>>> although I'm not quite sure. Whereas V4L2_SUBDEV_FL_STREAMS without
>>>> state is a driver bug.
>>>>
>>>>> you use it if the V4L2_SUBDEV_FL_STREAMS flag is set. The second
>>>>> condition is a subset of the first one, so it should be safe now, but I
>>>>> wonder if we're at risk of crashes in the future when reworking the
>>>>> code. I'm probably worrying needlessly.
>>>>
>>>> I agree that this is a bit messy. We have multiple different scenarios
>>>> which we handle in the same functions, and it's somewhat unclear what
>>>> op/state/flag combinations the drivers are allowed to have and what not.
>>>>
>>>> I could add a !state check here, and then use sd->enabled_pads. But that
>>>> doesn't feel correct, and I think it's just better to crash and then fix
>>>> it if we end up there.
>>>>
>>>>>>     
>>>>>> -	if (!already_streaming)
>>>>>> +	if (!use_s_stream && !already_streaming)
>>>>>>     		v4l2_subdev_enable_privacy_led(sd);
>>>>>
>>>>> Once everybody switches to v4l2_subdev_enable_streams() (am I dreaming?)
>>>>> we should move LED handling from the .s_stream() wrapper to here for the
>>>>> fallback case too. How about a TODO comment ?
>>>>
>>>> Let's get back to this after we figure out if s_stream can ever be removed.
>>>>
>>>>>>     
>>>>>>     done:
>>>>>> -	v4l2_subdev_unlock_state(state);
>>>>>> +	if (!use_s_stream)
>>>>>
>>>>> 	if (state)
>>>>>
>>>>> would be better I think.
>>>>
>>>> We get the state and state lock if (!use_s_stream), so I think it makes
>>>> sense to use the same condition when unlocking to be symmetric. I'm sure
>>>> I can be convinced to use if (state) too, though =).
>>>>
>>>>>> +		v4l2_subdev_unlock_state(state);
>>>>>>     
>>>>>>     	return ret;
>>>>>>     }
>>>>>>     EXPORT_SYMBOL_GPL(v4l2_subdev_enable_streams);
>>>>>>     
>>>>>> -static int v4l2_subdev_disable_streams_fallback(struct v4l2_subdev *sd, u32 pad,
>>>>>> -						u64 streams_mask)
>>>>>> +int v4l2_subdev_disable_streams(struct v4l2_subdev *sd, u32 pad,
>>>>>> +				u64 streams_mask)
>>>>>>     {
>>>>>>     	struct device *dev = sd->entity.graph_obj.mdev->dev;
>>>>>> +	struct v4l2_subdev_state *state;
>>>>>> +	u64 enabled_streams;
>>>>>> +	u64 found_streams;
>>>>>> +	bool use_s_stream;
>>>>>>     	int ret;
>>>>>>     
>>>>>> -	/*
>>>>>> -	 * If the subdev doesn't implement pad-based stream enable, fall back
>>>>>> -	 * to the .s_stream() operation.
>>>>>> -	 */
>>>>>> -	if (!(sd->entity.pads[pad].flags & MEDIA_PAD_FL_SOURCE))
>>>>>> -		return -EOPNOTSUPP;
>>>>>> +	/* A few basic sanity checks first. */
>>>>>> +	if (pad >= sd->entity.num_pads)
>>>>>> +		return -EINVAL;
>>>>>>     
>>>>>> -	/*
>>>>>> -	 * .s_stream() means there is no streams support, so the only allowed
>>>>>> -	 * stream is the implicit stream 0.
>>>>>> -	 */
>>>>>> -	if (streams_mask != BIT_ULL(0))
>>>>>> +	if (!(sd->entity.pads[pad].flags & MEDIA_PAD_FL_SOURCE))
>>>>>>     		return -EOPNOTSUPP;
>>>>>>     
>>>>>>     	/*
>>>>>> @@ -2280,46 +2269,16 @@ static int v4l2_subdev_disable_streams_fallback(struct v4l2_subdev *sd, u32 pad,
>>>>>>     	if (pad >= sizeof(sd->enabled_pads) * BITS_PER_BYTE)
>>>>>>     		return -EOPNOTSUPP;
>>>>>>     
>>>>>> -	if (!(sd->enabled_pads & BIT_ULL(pad))) {
>>>>>> -		dev_dbg(dev, "pad %u already disabled on %s\n",
>>>>>> -			pad, sd->entity.name);
>>>>>> -		return -EALREADY;
>>>>>> -	}
>>>>>> -
>>>>>> -	/* Stop streaming when the last streams are disabled. */
>>>>>> -	if (!(sd->enabled_pads & ~BIT_ULL(pad))) {
>>>>>> -		ret = v4l2_subdev_call(sd, video, s_stream, 0);
>>>>>> -		if (ret)
>>>>>> -			return ret;
>>>>>> -	}
>>>>>> -
>>>>>> -	sd->enabled_pads &= ~BIT_ULL(pad);
>>>>>> -
>>>>>> -	return 0;
>>>>>> -}
>>>>>> -
>>>>>> -int v4l2_subdev_disable_streams(struct v4l2_subdev *sd, u32 pad,
>>>>>> -				u64 streams_mask)
>>>>>> -{
>>>>>> -	struct device *dev = sd->entity.graph_obj.mdev->dev;
>>>>>> -	struct v4l2_subdev_state *state;
>>>>>> -	u64 enabled_streams;
>>>>>> -	u64 found_streams;
>>>>>> -	int ret;
>>>>>> -
>>>>>> -	/* A few basic sanity checks first. */
>>>>>> -	if (pad >= sd->entity.num_pads)
>>>>>> -		return -EINVAL;
>>>>>> -
>>>>>>     	if (!streams_mask)
>>>>>>     		return 0;
>>>>>>     
>>>>>>     	/* Fallback on .s_stream() if .disable_streams() isn't available. */
>>>>>> -	if (!v4l2_subdev_has_op(sd, pad, disable_streams))
>>>>>> -		return v4l2_subdev_disable_streams_fallback(sd, pad,
>>>>>> -							    streams_mask);
>>>>>> +	use_s_stream = !v4l2_subdev_has_op(sd, pad, disable_streams);
>>>>>>     
>>>>>> -	state = v4l2_subdev_lock_and_get_active_state(sd);
>>>>>> +	if (!use_s_stream)
>>>>>> +		state = v4l2_subdev_lock_and_get_active_state(sd);
>>>>>> +	else
>>>>>> +		state = NULL;
>>>>>>     
>>>>>>     	/*
>>>>>>     	 * Verify that the requested streams exist and that they are not
>>>>>> @@ -2345,9 +2304,19 @@ int v4l2_subdev_disable_streams(struct v4l2_subdev *sd, u32 pad,
>>>>>>     
>>>>>>     	dev_dbg(dev, "disable streams %u:%#llx\n", pad, streams_mask);
>>>>>>     
>>>>>> -	/* Call the .disable_streams() operation. */
>>>>>> -	ret = v4l2_subdev_call(sd, pad, disable_streams, state, pad,
>>>>>> -			       streams_mask);
>>>>>> +	if (!use_s_stream) {
>>>>>> +		/* Call the .disable_streams() operation. */
>>>>>> +		ret = v4l2_subdev_call(sd, pad, disable_streams, state, pad,
>>>>>> +				       streams_mask);
>>>>>> +	} else {
>>>>>> +		/* Stop streaming when the last streams are disabled. */
>>>>>> +
>>>>>> +		if (!(sd->enabled_pads & ~BIT_ULL(pad)))
>>>>>> +			ret = v4l2_subdev_call(sd, video, s_stream, 0);
>>>>>> +		else
>>>>>> +			ret = 0;
>>>>>> +	}
>>>>>> +
>>>>>>     	if (ret) {
>>>>>>     		dev_dbg(dev, "disable streams %u:%#llx failed: %d\n", pad,
>>>>>>     			streams_mask, ret);
>>>>>> @@ -2357,10 +2326,12 @@ int v4l2_subdev_disable_streams(struct v4l2_subdev *sd, u32 pad,
>>>>>>     	v4l2_subdev_set_streams_enabled(sd, state, pad, streams_mask, false);
>>>>>>     
>>>>>>     done:
>>>>>> -	if (!v4l2_subdev_is_streaming(sd))
>>>>>> -		v4l2_subdev_disable_privacy_led(sd);
>>>>>> +	if (!use_s_stream) {
>>>>>> +		if (!v4l2_subdev_is_streaming(sd))
>>>>>> +			v4l2_subdev_disable_privacy_led(sd);
>>>>>
>>>>> Do we want to disable the privacy LED on failure in all cases, in
>>>>> particular when the .s_stream() or .disable_streams() operations are not
>>>>> even called ?
>>>>>
>>>>> And now that I wrote that, I realize the !v4l2_subdev_is_streaming()
>>>>> condition will not be true if the operations failed, so it should be
>>>>> fine.
>>>>>
>>>>> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>>>>>
>>>>>>     
>>>>>> -	v4l2_subdev_unlock_state(state);
>>>>>> +		v4l2_subdev_unlock_state(state);
>>>>>> +	}
>>>>>>     
>>>>>>     	return ret;
>>>>>>     }
>>>>>>
> 


