Return-Path: <linux-kernel+bounces-131530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 604BE89891B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5A1DB2639F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46814128812;
	Thu,  4 Apr 2024 13:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="pfLW7yNC"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D60A128395;
	Thu,  4 Apr 2024 13:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712238469; cv=none; b=aH6NRUCBROKiXj3278mAELl0SVcb6W6s0wd3TbR6X/K/dqlSk/ahOe48RrGA+Ymr14bRmny5PgU2yW2PSlDRzzfGyDJMoFwBCZm94qDQS8EIZX10x4qxNKe54O2/326Hkk1NVh32ukUBanJh4NULKgwxrisCe8oNK4583127rbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712238469; c=relaxed/simple;
	bh=HKvOBBPTr2/gtkiED3ztL2euM0GCxjrpOgwYox+2lbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HHt0O01VAeRV3ZhNTTrQsc1NIpXg/3ASV3j3ERf3zojCCI+au4NXfQ7VXj4VnzEgvA5qpIA7uISnr2zHPcjhaZP0rq5Nbh6CiMXmW9i0OLlUEkYp2RIbqhX7uAJ+GgsbU2KooU/g/EmhjLAnwDanZ3LJiUt1xIA89Rofw90OyWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=pfLW7yNC; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.88.20] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id B5D231A2;
	Thu,  4 Apr 2024 15:47:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712238427;
	bh=HKvOBBPTr2/gtkiED3ztL2euM0GCxjrpOgwYox+2lbs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pfLW7yNCJ/5wCNj4QQsvKMnde1obWEUXCELSSpphkaLqTlDMTx3Vo2s+uPKu9Flv1
	 Q2+6QE220LcYItDRYWJIE8vIOJbZgYf3vGKyO7tC12n0+6vx3tyCu78r6qRdduUoEx
	 sfM4LwITpkRcqhSD5Bm2toFU82ig2y8q1/hrhsCc=
Message-ID: <e26e1251-de1d-4c86-9041-a5e3b2e2d765@ideasonboard.com>
Date: Thu, 4 Apr 2024 16:47:41 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] media: subdev: Improve
 v4l2_subdev_enable/disable_streams_fallback
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil
 <hverkuil@xs4all.nl>, Umang Jain <umang.jain@ideasonboard.com>,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240404-enable-streams-impro-v1-0-1017a35bbe07@ideasonboard.com>
 <20240404-enable-streams-impro-v1-3-1017a35bbe07@ideasonboard.com>
 <Zg6anfpQt80gSKjN@kekkonen.localdomain>
 <a5ea5844-a7ba-408b-8007-2000dc94be24@ideasonboard.com>
 <20240404130617.GR23803@pendragon.ideasonboard.com>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Language: en-US
Autocrypt: addr=tomi.valkeinen@ideasonboard.com; keydata=
 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
In-Reply-To: <20240404130617.GR23803@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/04/2024 16:06, Laurent Pinchart wrote:
> On Thu, Apr 04, 2024 at 03:38:45PM +0300, Tomi Valkeinen wrote:
>> On 04/04/2024 15:18, Sakari Ailus wrote:
>>> On Thu, Apr 04, 2024 at 01:50:02PM +0300, Tomi Valkeinen wrote:
>>>> v4l2_subdev_enable/disable_streams_fallback() supports falling back to
>>>> .s_stream() for subdevs with a single source pad. It also tracks the
>>>> enabled streams for that one pad in the sd->enabled_streams field.
>>>>
>>>> Tracking the enabled streams with sd->enabled_streams does not make
>>>> sense, as with .s_stream() there can only be a single stream per pad.
>>>> Thus, as the v4l2_subdev_enable/disable_streams_fallback() only supports
>>>> a single source pad, all we really need is a boolean which tells whether
>>>> streaming has been enabled on this pad or not.
>>>>
>>>> However, as we only need a true/false state for a pad (instead of
>>>> tracking which streams have been enabled for a pad), we can easily
>>>> extend the fallback mechanism to support multiple source pads as we only
>>>> need to keep track of which pads have been enabled.
>>>>
>>>> Change the sd->enabled_streams field to sd->enabled_pads, which is a
>>>> 64-bit bitmask tracking the enabled source pads. With this change we can
>>>> remove the restriction that
>>>> v4l2_subdev_enable/disable_streams_fallback() only supports a single
>>>> soruce pad.
> 
> s/soruce/source/
> 
>>>>
>>>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>>>> ---
>>>>    drivers/media/v4l2-core/v4l2-subdev.c | 68 ++++++++++++++++++++---------------
>>>>    include/media/v4l2-subdev.h           |  9 +++--
>>>>    2 files changed, 44 insertions(+), 33 deletions(-)
>>>>
>>>> diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
>>>> index 3b3310bce5d4..91298bb84e6b 100644
>>>> --- a/drivers/media/v4l2-core/v4l2-subdev.c
>>>> +++ b/drivers/media/v4l2-core/v4l2-subdev.c
>>>> @@ -2090,37 +2090,43 @@ static int v4l2_subdev_enable_streams_fallback(struct v4l2_subdev *sd, u32 pad,
>>>>    					       u64 streams_mask)
>>>>    {
>>>>    	struct device *dev = sd->entity.graph_obj.mdev->dev;
>>>> -	unsigned int i;
>>>>    	int ret;
>>>>    
>>>>    	/*
>>>>    	 * The subdev doesn't implement pad-based stream enable, fall back
>>>> -	 * on the .s_stream() operation. This can only be done for subdevs that
>>>> -	 * have a single source pad, as sd->enabled_streams is global to the
>>>> -	 * subdev.
>>>> +	 * on the .s_stream() operation.
> 
> While at it, s/on/to/

Actually, now that we support multiple pads here... Should the comment 
and the if below, checking whether the pad is a source pad, be removed? 
Is there any reason to require a source pad here (but not in the 
non-fallback case)?

  Tomi


> 
> Same below.
> 
>>>>    	 */
>>>>    	if (!(sd->entity.pads[pad].flags & MEDIA_PAD_FL_SOURCE))
>>>>    		return -EOPNOTSUPP;
>>>>    
>>>> -	for (i = 0; i < sd->entity.num_pads; ++i) {
>>>> -		if (i != pad && sd->entity.pads[i].flags & MEDIA_PAD_FL_SOURCE)
>>>> -			return -EOPNOTSUPP;
>>>> -	}
>>>> +	/*
>>>> +	 * .s_stream() means there is no streams support, so only allowed stream
>>>> +	 * is the imlicit stream 0.
> 
> s/imlicit/implicit/
> 
> Same below.
> 
>>>> +	 */
>>>> +	if (streams_mask != BIT_ULL(0))
>>>> +		return -EOPNOTSUPP;
>>>> +
>>>> +	/*
>>>> +	 * We use a 64-bit bitmask for tracking enabled pads, so only subdevices
>>>> +	 * with 64 pads or less can be supported.
>>>> +	 */
>>>> +	if (pad >= sizeof(sd->enabled_pads) * 8)
>>>
>>> s/8/BITS_PER_BYTE/
>>>
>>>> +		return -EOPNOTSUPP;
>>>>    
>>>> -	if (sd->enabled_streams & streams_mask) {
>>>> -		dev_dbg(dev, "set of streams %#llx already enabled on %s:%u\n",
>>>> -			streams_mask, sd->entity.name, pad);
>>>> +	if (sd->enabled_pads & BIT_ULL(pad)) {
>>>> +		dev_dbg(dev, "pad %u already enabled on %s\n",
>>>> +			pad, sd->entity.name);
>>>>    		return -EALREADY;
>>>>    	}
>>>>    
>>>> -	/* Start streaming when the first streams are enabled. */
>>>> -	if (!sd->enabled_streams) {
>>>> +	/* Start streaming when the first pad is enabled. */
>>>> +	if (!sd->enabled_pads) {
>>>>    		ret = v4l2_subdev_call(sd, video, s_stream, 1);
>>>>    		if (ret)
>>>>    			return ret;
>>>>    	}
>>>>    
>>>> -	sd->enabled_streams |= streams_mask;
>>>> +	sd->enabled_pads |= BIT_ULL(pad);
>>>>    
>>>>    	return 0;
>>>>    }
>>>> @@ -2207,37 +2213,43 @@ static int v4l2_subdev_disable_streams_fallback(struct v4l2_subdev *sd, u32 pad,
>>>>    						u64 streams_mask)
>>>>    {
>>>>    	struct device *dev = sd->entity.graph_obj.mdev->dev;
>>>> -	unsigned int i;
>>>>    	int ret;
>>>>    
>>>>    	/*
>>>> -	 * If the subdev doesn't implement pad-based stream enable, fall  back
>>>> -	 * on the .s_stream() operation. This can only be done for subdevs that
>>>> -	 * have a single source pad, as sd->enabled_streams is global to the
>>>> -	 * subdev.
>>>> +	 * If the subdev doesn't implement pad-based stream enable, fall back
>>>> +	 * on the .s_stream() operation.
>>>>    	 */
>>>>    	if (!(sd->entity.pads[pad].flags & MEDIA_PAD_FL_SOURCE))
>>>>    		return -EOPNOTSUPP;
>>>>    
>>>> -	for (i = 0; i < sd->entity.num_pads; ++i) {
>>>> -		if (i != pad && sd->entity.pads[i].flags & MEDIA_PAD_FL_SOURCE)
>>>> -			return -EOPNOTSUPP;
>>>> -	}
>>>> +	/*
>>>> +	 * .s_stream() means there is no streams support, so only allowed stream
>>>> +	 * is the imlicit stream 0.
>>>> +	 */
>>>> +	if (streams_mask != BIT_ULL(0))
>>>> +		return -EOPNOTSUPP;
>>>> +
>>>> +	/*
>>>> +	 * We use a 64-bit bitmask for tracking enabled pads, so only subdevices
>>>> +	 * with 64 pads or less can be supported.
>>>> +	 */
>>>> +	if (pad >= sizeof(sd->enabled_pads) * 8)
>>>
>>> Ditto.
>>>
>>> How much of the code of the two functions is the same? Could some of this
>>> be put to a common function both would call? They look (almost) exactly the
>>> same.
>>
>> v4l2_subdev_enable_streams_fallback and v4l2_subdev_enable_streams? They
>> have similar parts, but I don't right away see how combining them or
>> making some common functions would help.
> 
> You could move the three checks to a
> v4l2_subdev_streams_fallback_check() function (bikeshedding the name is
> allowed).
> 
>>>> +		return -EOPNOTSUPP;
>>>>    
>>>> -	if ((sd->enabled_streams & streams_mask) != streams_mask) {
>>>> -		dev_dbg(dev, "set of streams %#llx already disabled on %s:%u\n",
>>>> -			streams_mask, sd->entity.name, pad);
>>>> +	if ((sd->enabled_pads & BIT_ULL(pad)) != BIT_ULL(pad)) {
> 
> 	if (!(sd->enabled_pads & BIT_ULL(pad))) {
> 
>>>> +		dev_dbg(dev, "pad %u already disabled on %s\n",
>>>> +			pad, sd->entity.name);
>>>>    		return -EALREADY;
>>>>    	}
>>>>    
>>>>    	/* Stop streaming when the last streams are disabled. */
>>>> -	if (!(sd->enabled_streams & ~streams_mask)) {
>>>> +	if (!(sd->enabled_pads & ~BIT_ULL(pad))) {
>>>>    		ret = v4l2_subdev_call(sd, video, s_stream, 0);
>>>>    		if (ret)
>>>>    			return ret;
>>>>    	}
>>>>    
>>>> -	sd->enabled_streams &= ~streams_mask;
>>>> +	sd->enabled_pads &= ~BIT_ULL(pad);
>>>>    
>>>>    	return 0;
>>>>    }
>>>> diff --git a/include/media/v4l2-subdev.h b/include/media/v4l2-subdev.h
>>>> index 8bd1e3c96d2b..7077aec3176c 100644
>>>> --- a/include/media/v4l2-subdev.h
>>>> +++ b/include/media/v4l2-subdev.h
>>>> @@ -1039,10 +1039,9 @@ struct v4l2_subdev_platform_data {
>>>>     * @active_state: Active state for the subdev (NULL for subdevs tracking the
>>>>     *		  state internally). Initialized by calling
>>>>     *		  v4l2_subdev_init_finalize().
>>>> - * @enabled_streams: Bitmask of enabled streams used by
>>>> - *		     v4l2_subdev_enable_streams() and
>>>> - *		     v4l2_subdev_disable_streams() helper functions for fallback
>>>> - *		     cases.
>>>> + * @enabled_pads: Bitmask of enabled pads used by v4l2_subdev_enable_streams()
>>>> + *		  and v4l2_subdev_disable_streams() helper functions for
>>>> + *		  fallback cases.
>>>>     * @streaming_enabled: Tracks whether streaming has been enabled with s_stream.
>>>>     *
>>>>     * Each instance of a subdev driver should create this struct, either
>>>> @@ -1091,7 +1090,7 @@ struct v4l2_subdev {
>>>>    	 * doesn't support it.
>>>>    	 */
>>>>    	struct v4l2_subdev_state *active_state;
>>>> -	u64 enabled_streams;
>>>> +	u64 enabled_pads;
>>>>    	bool streaming_enabled;
>>>>    };
>>>>    
> 


