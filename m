Return-Path: <linux-kernel+bounces-146878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8B98A6C44
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99F4F2826E1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693D412C498;
	Tue, 16 Apr 2024 13:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="TSaeTHjp"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F8312AADC;
	Tue, 16 Apr 2024 13:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713274142; cv=none; b=L3nsMkn6oQ5uvc9aRuZo7/HhoYLekq6nkL2HNuT5v0yGu6dREpybRrwAIumWTXNz7Y4Urqf9kDLE7KDnen4oXJ5xivOv0UxHmnRJ53eRDXQdri7OnKU7Tk4uwz72/jl83wplffiJDBsoG5bMeB49NF9CisAFG1zKANpjyrqfOVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713274142; c=relaxed/simple;
	bh=n8uAzu0fhjDkoEFhJa32or/1KBqUpuWXqGojl6rSobU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y+gIzNxALy90nCVeFo7MkaM/4JewBaq5Ph2WbXosTrYq4hBYc9t/07WKK6ZZocY1+zfZZ7uUcitkmPdsFTWDNZQwul9u0mvUlKku0diJTu5za3/UxOkhWnkRthtRimPVwyl1lmLjmtA6LlrrwtIXK0vYZ1DazST50z9IYIXpfzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=TSaeTHjp; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.1.105] (unknown [103.251.226.7])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 45190DFB;
	Tue, 16 Apr 2024 15:28:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1713274092;
	bh=n8uAzu0fhjDkoEFhJa32or/1KBqUpuWXqGojl6rSobU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TSaeTHjp78FW/oI1sULfK4N2T4YxjndlfP4ZpCABqls7bpYSegOKqEvui7ZgbyQqi
	 AxLmi6Fby0iSq2SwxqCDe0iwezbAVdB/S9BmuKGTR/Q/LzURQmFQgcRaGx3NCt7jqP
	 EtfkTi5Ee2n3Ub8npzfE0cMr+cuTQhW1bTtJlYh8=
Message-ID: <92279ce6-e410-40f2-bc6d-ad842aa9e106@ideasonboard.com>
Date: Tue, 16 Apr 2024 18:58:51 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/10] media: subdev: Support non-routing subdevs in
 v4l2_subdev_s_stream_helper()
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil
 <hverkuil@xs4all.nl>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>
References: <20240416-enable-streams-impro-v4-0-1d370c9c2b6d@ideasonboard.com>
 <20240416-enable-streams-impro-v4-10-1d370c9c2b6d@ideasonboard.com>
 <271933b0-7ac1-4fdf-b66a-0ed860a1ec8f@ideasonboard.com>
Content-Language: en-US
From: Umang Jain <umang.jain@ideasonboard.com>
In-Reply-To: <271933b0-7ac1-4fdf-b66a-0ed860a1ec8f@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Tomi

On 16/04/24 4:13 pm, Tomi Valkeinen wrote:
> Hi,
>
> On 16/04/2024 13:40, Tomi Valkeinen wrote:
>> At the moment v4l2_subdev_s_stream_helper() only works for subdevices
>> that support routing. As enable/disable_streams now also works for
>> subdevices without routing, improve v4l2_subdev_s_stream_helper() to do
>> the same.
>
> I forgot to mention, I have not tested this patch as I don't have a HW 
> setup. And, of course, I now see that it has a bug. The BIT_ULL(1) 
> should be BIT_ULL(0).
>
> Umang, can you try a fixed one on your side? If it works, I'll send a v5.

This doesn't work. Streaming fails as :

[  132.108845] rkisp1 32e10000.isp: streams 0xffff8000801fef88 already 
enabled on imx283 1-001a:0
[  133.140906] rkisp1 32e10000.isp: streams 0xffff8000801fef88 already 
enabled on imx283 1-001a:0

With locally applied:

diff --git a/drivers/media/v4l2-core/v4l2-subdev.c 
b/drivers/media/v4l2-core/v4l2-subdev.c
index 04d85b5f23f5..4684e4e1984c 100644
--- a/drivers/media/v4l2-core/v4l2-subdev.c
+++ b/drivers/media/v4l2-core/v4l2-subdev.c
@@ -2203,7 +2203,7 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev 
*sd, u32 pad,
         }

         if (enabled_streams) {
-               dev_dbg(dev, "streams 0x%llx already enabled on %s:%u\n",
+               dev_err(dev, "streams 0x%llx already enabled on %s:%u\n",
                         enabled_streams, sd->entity.name, pad);
                 ret = -EINVAL;
                 goto done;
@@ -2376,7 +2376,7 @@ int v4l2_subdev_s_stream_helper(struct v4l2_subdev 
*sd, int enable)
                  * For non-streams subdevices, there's a single 
implicit stream
                  * per pad.
                  */
-               source_mask = BIT_ULL(1);
+               source_mask = BIT_ULL(0);
         }

>
>  Tomi
>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>> ---
>>   drivers/media/v4l2-core/v4l2-subdev.c | 23 ++++++++++++++++-------
>>   1 file changed, 16 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/media/v4l2-core/v4l2-subdev.c 
>> b/drivers/media/v4l2-core/v4l2-subdev.c
>> index 1c6b305839a1..83ebcde54a34 100644
>> --- a/drivers/media/v4l2-core/v4l2-subdev.c
>> +++ b/drivers/media/v4l2-core/v4l2-subdev.c
>> @@ -2360,15 +2360,24 @@ int v4l2_subdev_s_stream_helper(struct 
>> v4l2_subdev *sd, int enable)
>>       if (WARN_ON(pad_index == -1))
>>           return -EINVAL;
>>   -    /*
>> -     * As there's a single source pad, just collect all the source 
>> streams.
>> -     */
>> -    state = v4l2_subdev_lock_and_get_active_state(sd);
>> +    if (sd->flags & V4L2_SUBDEV_FL_STREAMS) {
>> +        /*
>> +         * As there's a single source pad, just collect all the source
>> +         * streams.
>> +         */
>> +        state = v4l2_subdev_lock_and_get_active_state(sd);
>>   -    for_each_active_route(&state->routing, route)
>> -        source_mask |= BIT_ULL(route->source_stream);
>> +        for_each_active_route(&state->routing, route)
>> +            source_mask |= BIT_ULL(route->source_stream);
>>   -    v4l2_subdev_unlock_state(state);
>> +        v4l2_subdev_unlock_state(state);
>> +    } else {
>> +        /*
>> +         * For non-streams subdevices, there's a single implicit stream
>> +         * per pad.
>> +         */
>> +        source_mask = BIT_ULL(1);
>> +    }
>>         if (enable)
>>           return v4l2_subdev_enable_streams(sd, pad_index, source_mask);
>>
>


