Return-Path: <linux-kernel+bounces-146904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 784438A6CB7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CE8A28622C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED5612C534;
	Tue, 16 Apr 2024 13:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="hgUCnFOQ"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1B712882C;
	Tue, 16 Apr 2024 13:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713275064; cv=none; b=PTGEaqK1ADEV/PojYHp3c7RoheGlTyU8NNfpf6j7fQwos69EV18WzqcMoE776zHnoveBN/ZBrNHr1XuoG2xFw1rjXihbnYcl9CB+mtkp3uKPiMbqiiklT8HytaPXGISBb+/tWKQMg54npIjPflHh8xW0x8DkaboRnDoJcrnypRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713275064; c=relaxed/simple;
	bh=wLdmZxY0X+98VUnfEwczfOr5cFjyATQM4VLQNl+dRC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pnMDhO3gaPdUNsv6kYWL2X8mvSuEj0u794BvzNWTgQV3nvxJFvPGxbESkpfiRL6ouT9Tbrh9i4T4wuw99VMnNwEFa1jRWfea6MyDLZHfp+OQYt2h9XqaEjxGwRHxP3xd4yjpyKw+dP3kl+64DWLThKOaj/At98nqDq5J6VnaTl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=hgUCnFOQ; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.88.20] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 09214DFB;
	Tue, 16 Apr 2024 15:43:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1713275014;
	bh=wLdmZxY0X+98VUnfEwczfOr5cFjyATQM4VLQNl+dRC4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hgUCnFOQ0mfZ3F9TUvCYTJdrBb09vQtLYp0cUhGbvN487GOWEAAnB9pidteU6tWIW
	 ENSRKbfk0AAr3LjD7p1cbfKgpqpJyiCw3Ko2+EnI1yDTensvGyWvazkW/fW07oXFmh
	 uSHcgtbC+YaQ3OpUB2VBkRXNf9jkDtQjXT8i1Ats=
Message-ID: <7b9be1a1-3775-4299-88f0-640be53a1acf@ideasonboard.com>
Date: Tue, 16 Apr 2024 16:44:17 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/10] media: subdev: Support non-routing subdevs in
 v4l2_subdev_s_stream_helper()
To: Umang Jain <umang.jain@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil
 <hverkuil@xs4all.nl>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>
References: <20240416-enable-streams-impro-v4-0-1d370c9c2b6d@ideasonboard.com>
 <20240416-enable-streams-impro-v4-10-1d370c9c2b6d@ideasonboard.com>
 <271933b0-7ac1-4fdf-b66a-0ed860a1ec8f@ideasonboard.com>
 <92279ce6-e410-40f2-bc6d-ad842aa9e106@ideasonboard.com>
Content-Language: en-US
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Autocrypt: addr=tomi.valkeinen@ideasonboard.com; keydata=
 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
In-Reply-To: <92279ce6-e410-40f2-bc6d-ad842aa9e106@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 16/04/2024 16:28, Umang Jain wrote:
> Hi Tomi
> 
> On 16/04/24 4:13 pm, Tomi Valkeinen wrote:
>> Hi,
>>
>> On 16/04/2024 13:40, Tomi Valkeinen wrote:
>>> At the moment v4l2_subdev_s_stream_helper() only works for subdevices
>>> that support routing. As enable/disable_streams now also works for
>>> subdevices without routing, improve v4l2_subdev_s_stream_helper() to do
>>> the same.
>>
>> I forgot to mention, I have not tested this patch as I don't have a HW 
>> setup. And, of course, I now see that it has a bug. The BIT_ULL(1) 
>> should be BIT_ULL(0).
>>
>> Umang, can you try a fixed one on your side? If it works, I'll send a v5.
> 
> This doesn't work. Streaming fails as :
> 
> [  132.108845] rkisp1 32e10000.isp: streams 0xffff8000801fef88 already 
> enabled on imx283 1-001a:0
> [  133.140906] rkisp1 32e10000.isp: streams 0xffff8000801fef88 already 
> enabled on imx283 1-001a:0

Indeed, there's a bug in v4l2_subdev_collect_streams() too:

@@ -2108,8 +2108,8 @@ static void v4l2_subdev_collect_streams(struct v4l2_subdev *sd,
  {
         if (!(sd->flags & V4L2_SUBDEV_FL_STREAMS)) {
                 *found_streams = BIT_ULL(0);
-               if (sd->enabled_pads & BIT_ULL(pad))
-                       *enabled_streams = BIT_ULL(0);
+               *enabled_streams =
+                       (sd->enabled_pads & BIT_ULL(pad)) ? BIT_ULL(0) : 0;
                 return;
         }

  Tomi

> 
> With locally applied:
> 
> diff --git a/drivers/media/v4l2-core/v4l2-subdev.c 
> b/drivers/media/v4l2-core/v4l2-subdev.c
> index 04d85b5f23f5..4684e4e1984c 100644
> --- a/drivers/media/v4l2-core/v4l2-subdev.c
> +++ b/drivers/media/v4l2-core/v4l2-subdev.c
> @@ -2203,7 +2203,7 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev 
> *sd, u32 pad,
>          }
> 
>          if (enabled_streams) {
> -               dev_dbg(dev, "streams 0x%llx already enabled on %s:%u\n",
> +               dev_err(dev, "streams 0x%llx already enabled on %s:%u\n",
>                          enabled_streams, sd->entity.name, pad);
>                  ret = -EINVAL;
>                  goto done;
> @@ -2376,7 +2376,7 @@ int v4l2_subdev_s_stream_helper(struct v4l2_subdev 
> *sd, int enable)
>                   * For non-streams subdevices, there's a single 
> implicit stream
>                   * per pad.
>                   */
> -               source_mask = BIT_ULL(1);
> +               source_mask = BIT_ULL(0);
>          }
> 
>>
>>  Tomi
>>
>>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>>> ---
>>>   drivers/media/v4l2-core/v4l2-subdev.c | 23 ++++++++++++++++-------
>>>   1 file changed, 16 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/media/v4l2-core/v4l2-subdev.c 
>>> b/drivers/media/v4l2-core/v4l2-subdev.c
>>> index 1c6b305839a1..83ebcde54a34 100644
>>> --- a/drivers/media/v4l2-core/v4l2-subdev.c
>>> +++ b/drivers/media/v4l2-core/v4l2-subdev.c
>>> @@ -2360,15 +2360,24 @@ int v4l2_subdev_s_stream_helper(struct 
>>> v4l2_subdev *sd, int enable)
>>>       if (WARN_ON(pad_index == -1))
>>>           return -EINVAL;
>>>   -    /*
>>> -     * As there's a single source pad, just collect all the source 
>>> streams.
>>> -     */
>>> -    state = v4l2_subdev_lock_and_get_active_state(sd);
>>> +    if (sd->flags & V4L2_SUBDEV_FL_STREAMS) {
>>> +        /*
>>> +         * As there's a single source pad, just collect all the source
>>> +         * streams.
>>> +         */
>>> +        state = v4l2_subdev_lock_and_get_active_state(sd);
>>>   -    for_each_active_route(&state->routing, route)
>>> -        source_mask |= BIT_ULL(route->source_stream);
>>> +        for_each_active_route(&state->routing, route)
>>> +            source_mask |= BIT_ULL(route->source_stream);
>>>   -    v4l2_subdev_unlock_state(state);
>>> +        v4l2_subdev_unlock_state(state);
>>> +    } else {
>>> +        /*
>>> +         * For non-streams subdevices, there's a single implicit stream
>>> +         * per pad.
>>> +         */
>>> +        source_mask = BIT_ULL(1);
>>> +    }
>>>         if (enable)
>>>           return v4l2_subdev_enable_streams(sd, pad_index, source_mask);
>>>
>>
> 


