Return-Path: <linux-kernel+bounces-146913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FE28A6CD8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67FC21C22780
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B53912D74D;
	Tue, 16 Apr 2024 13:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Cve7WFws"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC53712CD8B;
	Tue, 16 Apr 2024 13:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713275511; cv=none; b=NWMmUl4SPVj35PE0XlO6TyJl3HPtHxGUN2gp13bFGpIyrRoZ8BP+JJIcjQ2SvK1KluGYnr4riXVp4maj6CEbBpMGsZ/zCNyyN3bEFMp2XrnoC+n/g+Vi/oVWocQ5osHNrY8UX7cMm6eJIoLn2T5CagyGrfMXSmyhtPww4ifwWvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713275511; c=relaxed/simple;
	bh=V8DvUts8+fVL/4ImWpzh5z7jBIet9GW4KGTbqdDcYUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lhl6Y+Md2Sh3dJ7ZPan+GgBW4q/7Nd/JAL0jV/VxWJCMF1vuVpMug5rHG6VE+/iL/5WMsdr2ftcBxCzhbv5UHd191nL8rCClM7wD5KgUyIvl4djocv5jzAxLzi4q7f9zdUWXvvV4bhOYk4WhmyC4pTPajzcVrxzIEkvImBxWEds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Cve7WFws; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.1.105] (unknown [103.251.226.7])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id E64B1DFB;
	Tue, 16 Apr 2024 15:50:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1713275462;
	bh=V8DvUts8+fVL/4ImWpzh5z7jBIet9GW4KGTbqdDcYUU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Cve7WFwsD3By9GF0K34xz1PxzH8oi4lwOot3//vjZ5mnjW7m/SfEfkhYIhf7jBxPV
	 aInL8uapii8m5v1Gw8uNxnRVczJIoOO0wVPrYEwJOvBTOfVihTBwBb9HK9DCqgcUoo
	 /oYkNGoJRmbEX4k2ZlXX+tlQ0AzUytct7LhlISHA=
Message-ID: <b45228dd-5b8e-49da-bb0e-63349f0f065e@ideasonboard.com>
Date: Tue, 16 Apr 2024 19:21:41 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/10] media: subdev: Support non-routing subdevs in
 v4l2_subdev_s_stream_helper()
Content-Language: en-US
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil
 <hverkuil@xs4all.nl>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>
References: <20240416-enable-streams-impro-v4-0-1d370c9c2b6d@ideasonboard.com>
 <20240416-enable-streams-impro-v4-10-1d370c9c2b6d@ideasonboard.com>
 <271933b0-7ac1-4fdf-b66a-0ed860a1ec8f@ideasonboard.com>
 <92279ce6-e410-40f2-bc6d-ad842aa9e106@ideasonboard.com>
 <7b9be1a1-3775-4299-88f0-640be53a1acf@ideasonboard.com>
From: Umang Jain <umang.jain@ideasonboard.com>
In-Reply-To: <7b9be1a1-3775-4299-88f0-640be53a1acf@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Tomi,

On 16/04/24 7:14 pm, Tomi Valkeinen wrote:
> On 16/04/2024 16:28, Umang Jain wrote:
>> Hi Tomi
>>
>> On 16/04/24 4:13 pm, Tomi Valkeinen wrote:
>>> Hi,
>>>
>>> On 16/04/2024 13:40, Tomi Valkeinen wrote:
>>>> At the moment v4l2_subdev_s_stream_helper() only works for subdevices
>>>> that support routing. As enable/disable_streams now also works for
>>>> subdevices without routing, improve v4l2_subdev_s_stream_helper() 
>>>> to do
>>>> the same.
>>>
>>> I forgot to mention, I have not tested this patch as I don't have a 
>>> HW setup. And, of course, I now see that it has a bug. The 
>>> BIT_ULL(1) should be BIT_ULL(0).
>>>
>>> Umang, can you try a fixed one on your side? If it works, I'll send 
>>> a v5.
>>
>> This doesn't work. Streaming fails as :
>>
>> [  132.108845] rkisp1 32e10000.isp: streams 0xffff8000801fef88 
>> already enabled on imx283 1-001a:0
>> [  133.140906] rkisp1 32e10000.isp: streams 0xffff8000801fef88 
>> already enabled on imx283 1-001a:0
>
> Indeed, there's a bug in v4l2_subdev_collect_streams() too:
>
> @@ -2108,8 +2108,8 @@ static void v4l2_subdev_collect_streams(struct 
> v4l2_subdev *sd,
>  {
>         if (!(sd->flags & V4L2_SUBDEV_FL_STREAMS)) {
>                 *found_streams = BIT_ULL(0);
> -               if (sd->enabled_pads & BIT_ULL(pad))
> -                       *enabled_streams = BIT_ULL(0);
> +               *enabled_streams =
> +                       (sd->enabled_pads & BIT_ULL(pad)) ? BIT_ULL(0) 
> : 0;
>                 return;
>         }
>
>  Tomi

Yep, works now \o/

Locally applied:

diff --git a/drivers/media/v4l2-core/v4l2-subdev.c 
b/drivers/media/v4l2-core/v4l2-subdev.c
index 04d85b5f23f5..8c591309df24 100644
--- a/drivers/media/v4l2-core/v4l2-subdev.c
+++ b/drivers/media/v4l2-core/v4l2-subdev.c
@@ -2108,6 +2108,8 @@ static void v4l2_subdev_collect_streams(struct 
v4l2_subdev *sd,
  {
         if (!(sd->flags & V4L2_SUBDEV_FL_STREAMS)) {
                 *found_streams = BIT_ULL(0);
+               *enabled_streams =
+                       (sd->enabled_pads & BIT_ULL(pad)) ? BIT_ULL(0) : 0;
                 if (sd->enabled_pads & BIT_ULL(pad))
                         *enabled_streams = BIT_ULL(0);
                 return;
@@ -2203,7 +2205,7 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev 
*sd, u32 pad,
         }

         if (enabled_streams) {
-               dev_dbg(dev, "streams 0x%llx already enabled on %s:%u\n",
+               dev_err(dev, "streams 0x%llx already enabled on %s:%u\n",
                         enabled_streams, sd->entity.name, pad);
                 ret = -EINVAL;
                 goto done;
@@ -2376,7 +2378,7 @@ int v4l2_subdev_s_stream_helper(struct v4l2_subdev 
*sd, int enable)
                  * For non-streams subdevices, there's a single 
implicit stream
                  * per pad.
                  */
-               source_mask = BIT_ULL(1);
+               source_mask = BIT_ULL(0);
         }

I will provide a Tested-by in v5.
>
>>
>> With locally applied:
>>
>> diff --git a/drivers/media/v4l2-core/v4l2-subdev.c 
>> b/drivers/media/v4l2-core/v4l2-subdev.c
>> index 04d85b5f23f5..4684e4e1984c 100644
>> --- a/drivers/media/v4l2-core/v4l2-subdev.c
>> +++ b/drivers/media/v4l2-core/v4l2-subdev.c
>> @@ -2203,7 +2203,7 @@ int v4l2_subdev_enable_streams(struct 
>> v4l2_subdev *sd, u32 pad,
>>          }
>>
>>          if (enabled_streams) {
>> -               dev_dbg(dev, "streams 0x%llx already enabled on 
>> %s:%u\n",
>> +               dev_err(dev, "streams 0x%llx already enabled on 
>> %s:%u\n",
>>                          enabled_streams, sd->entity.name, pad);
>>                  ret = -EINVAL;
>>                  goto done;
>> @@ -2376,7 +2376,7 @@ int v4l2_subdev_s_stream_helper(struct 
>> v4l2_subdev *sd, int enable)
>>                   * For non-streams subdevices, there's a single 
>> implicit stream
>>                   * per pad.
>>                   */
>> -               source_mask = BIT_ULL(1);
>> +               source_mask = BIT_ULL(0);
>>          }
>>
>>>
>>>  Tomi
>>>
>>>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>>>> ---
>>>>   drivers/media/v4l2-core/v4l2-subdev.c | 23 ++++++++++++++++-------
>>>>   1 file changed, 16 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/drivers/media/v4l2-core/v4l2-subdev.c 
>>>> b/drivers/media/v4l2-core/v4l2-subdev.c
>>>> index 1c6b305839a1..83ebcde54a34 100644
>>>> --- a/drivers/media/v4l2-core/v4l2-subdev.c
>>>> +++ b/drivers/media/v4l2-core/v4l2-subdev.c
>>>> @@ -2360,15 +2360,24 @@ int v4l2_subdev_s_stream_helper(struct 
>>>> v4l2_subdev *sd, int enable)
>>>>       if (WARN_ON(pad_index == -1))
>>>>           return -EINVAL;
>>>>   -    /*
>>>> -     * As there's a single source pad, just collect all the source 
>>>> streams.
>>>> -     */
>>>> -    state = v4l2_subdev_lock_and_get_active_state(sd);
>>>> +    if (sd->flags & V4L2_SUBDEV_FL_STREAMS) {
>>>> +        /*
>>>> +         * As there's a single source pad, just collect all the 
>>>> source
>>>> +         * streams.
>>>> +         */
>>>> +        state = v4l2_subdev_lock_and_get_active_state(sd);
>>>>   -    for_each_active_route(&state->routing, route)
>>>> -        source_mask |= BIT_ULL(route->source_stream);
>>>> +        for_each_active_route(&state->routing, route)
>>>> +            source_mask |= BIT_ULL(route->source_stream);
>>>>   -    v4l2_subdev_unlock_state(state);
>>>> +        v4l2_subdev_unlock_state(state);
>>>> +    } else {
>>>> +        /*
>>>> +         * For non-streams subdevices, there's a single implicit 
>>>> stream
>>>> +         * per pad.
>>>> +         */
>>>> +        source_mask = BIT_ULL(1);
>>>> +    }
>>>>         if (enable)
>>>>           return v4l2_subdev_enable_streams(sd, pad_index, 
>>>> source_mask);
>>>>
>>>
>>
>


