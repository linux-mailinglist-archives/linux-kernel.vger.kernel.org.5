Return-Path: <linux-kernel+bounces-140385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2578A139B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 565A41C210B2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8534614A4D6;
	Thu, 11 Apr 2024 11:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="NzJpf0hU"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C13E145358;
	Thu, 11 Apr 2024 11:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712836441; cv=none; b=iUAgYMPKnUFdn9DnOiKXfLEEAdBhA5+16pG10Rq29UuIXhYvGCq+ocX3Dkz0ynwq8gKOge6cf+joP2/zQkMju8ExnMYQcvdCqWfQU2lUsBJI1SJrjsJqjlSFt54Md57gsA+E7TEyuBS3hWzJjhq58nPvLSOEWxj/o7xcYY3NfSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712836441; c=relaxed/simple;
	bh=GA6HGw4J8/cU3TuHTgNeLPLqVHoeB4Kgjas5t6oCUBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Am8QbVYCuxQC0IxcZOYPODVwGZIkN93KGJHlKead0v4m1tXXFJUwLLiXGUY94lYhJUwpKwVlD3LZPe3fZ+9WCPD4qN8oeIFma7JVYKKRK11s9qhxyZm6wdTHn/MlGYgNZz1ypqbz9PjZiZKkvs17hEj01m2S7sqjYw2FiHtv3YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=NzJpf0hU; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.88.20] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1EA2A23F;
	Thu, 11 Apr 2024 13:53:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712836395;
	bh=GA6HGw4J8/cU3TuHTgNeLPLqVHoeB4Kgjas5t6oCUBY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NzJpf0hULZgn01vA3eHX4sSoBVKUWOJ8f6hInH19PbXJZp0zgfQSffIBekzxrxHpD
	 /QrQIMlnyxeUDoPHxyxyfhMlVw4VfcMQ+tEdLpI5HSl02yp993ROm+ntPIX5XkfBSt
	 Dg57sCTwAPiBLPxudrURA+m/iugTgyk0GtejF8qc=
Message-ID: <da30ee6a-d8b1-44ad-8a29-fc9ac84aba9d@ideasonboard.com>
Date: Thu, 11 Apr 2024 14:53:55 +0300
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
 <72940e89-0384-4fd3-8a10-42d6db44fdf0@ideasonboard.com>
 <155bb2c2-21b9-48d5-9615-7a44d4b6a590@ideasonboard.com>
Content-Language: en-US
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Autocrypt: addr=tomi.valkeinen@ideasonboard.com; keydata=
 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
In-Reply-To: <155bb2c2-21b9-48d5-9615-7a44d4b6a590@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/04/2024 14:48, Umang Jain wrote:
> Hi Tomi,
> 
> On 11/04/24 4:37 pm, Tomi Valkeinen wrote:
>> On 11/04/2024 14:02, Umang Jain wrote:
>>> Hi Tomi,
>>>
>>> On 10/04/24 6:05 pm, Tomi Valkeinen wrote:
>>>> At the moment the v4l2_subdev_enable/disable_streams() functions call
>>>> fallback helpers to handle the case where the subdev only implements
>>>> .s_stream(), and the main function handles the case where the subdev
>>>> implements streams (V4L2_SUBDEV_FL_STREAMS, which implies
>>>> .enable/disable_streams()).
>>>>
>>>> What is missing is support for subdevs which do not implement streams
>>>> support, but do implement .enable/disable_streams(). Example cases of
>>>> these subdevices are single-stream cameras, where using
>>>> .enable/disable_streams() is not required but helps us remove the users
>>>> of the legacy .s_stream(), and subdevices with multiple source pads 
>>>> (but
>>>> single stream per pad), where .enable/disable_streams() allows the
>>>> subdevice to control the enable/disable state per pad.
>>>>
>>>> The two single-streams cases (.s_stream() and 
>>>> .enable/disable_streams())
>>>> are very similar, and with small changes we can change the
>>>> v4l2_subdev_enable/disable_streams() functions to support all three
>>>> cases, without needing separate fallback functions.
>>>>
>>>> A few potentially problematic details, though:
>>>
>>> Does this mean the patch needs to be worked upon more ?
>>
>> I don't see the two issues below as blockers.
>>
>>> I quickly tested the series by applying it locally with my use case 
>>> of IMX283 .enable/disable streams and s_stream as the helper function 
>>> and it seems I am still seeing the same behaviour as before (i.e. not 
>>> being streamed) and have to carry the workaround as mentioned in [1] 
>>> **NOTE**
>>
>> Ok... Then something bugs here, as it is supposed to fix the problem. 
>> Can you trace the code a bit to see where it goes wrong?
>>
>> The execution should go to the "if (!(sd->flags & 
>> V4L2_SUBDEV_FL_STREAMS))" blocks in v4l2_subdev_collect_streams() and 
>> v4l2_subdev_set_streams_enabled(),
> 
> The execution is not reaching in v4l2_subdev_collect streams() even, it 
> returns at
> 
>      if (!streams_mask)
>                  return 0;
> 
> in v4l2_subdev_enable_streams()
> 
> Refer to : https://paste.debian.net/1313760/
> 
> My tree is based on v6.8 currently, but the series applies cleanly, so I 
> have not introduced any  rebase artifacts. If you think, v6.8 might be 
> causing issues, I'll then try to test on RPi 5 with the latest media 
> tree perhaps.

So who is calling the v4l2_subdev_enable_streams? I presume it comes 
from v4l2_subdev_s_stream_helper(), in other words the sink side in your 
pipeline is using legacy s_stream?

Indeed, that helper still needs work. It needs to detect if there's no 
routing, and use the implicit stream 0. I missed that one.

  Tomi


