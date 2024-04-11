Return-Path: <linux-kernel+bounces-140389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA648A13BA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D7BB1C21C11
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E5914A619;
	Thu, 11 Apr 2024 11:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="LHCNT2q6"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8519314AD31;
	Thu, 11 Apr 2024 11:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712836630; cv=none; b=s5Qj7cuTWDouysMG3+1mdCjgaTevZ5c/+31V/KtV5IaegUF4JNQEzubawb8it7qZLcoE0wJyeazoKGWvED8r1wgyUZoj6pHJT/OY5oq/nv2U9oPT20E1d9bh702y/YjcmDIl8izn4sLoPykGsLaoe3Q3uBQpUCijYuDMn8gMuqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712836630; c=relaxed/simple;
	bh=/EHMPJY0NFe5Dbv3rrgKk5uP5iHNJUMUYb7il9F09YA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kGi+SD+o9gqrtPaduNwjLfNDJaDeQaTY/ZoWqela9i0SSO1Bdbry3p4MXC3zOvQtPtS0t0oZc9u3EhA7JApNR9OF1ZzuGXVenRRfYZiDzLxJGqaYO6G13+p592l9a5ilcvOtJayk9ODDgyy5sohs3G/zY7qV3pJ49TxayLIwEbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=LHCNT2q6; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.1.105] (unknown [103.251.226.65])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3452B23F;
	Thu, 11 Apr 2024 13:56:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712836584;
	bh=/EHMPJY0NFe5Dbv3rrgKk5uP5iHNJUMUYb7il9F09YA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LHCNT2q6eGtXii1KQZgY0UgAGxIFTsB+UTyXzplj/eHAifzzXkVMkCTd967FBAuxw
	 aQHCnfAe8flZLqkWxlIn2eFYmptR4py5Qey1VMS9HG9TX0EHrMboB5Jxj1eq7RFQYg
	 1LNnkcuQ7rEq6u183bvumM9J1quhP4sz9hAexUvA=
Message-ID: <d8c3349e-4ecc-4564-aeb4-40efcae5a43e@ideasonboard.com>
Date: Thu, 11 Apr 2024 17:26:58 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 9/9] media: subdev: Support single-stream case in
 v4l2_subdev_enable/disable_streams()
Content-Language: en-US
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil
 <hverkuil@xs4all.nl>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>
References: <20240410-enable-streams-impro-v3-0-e5e7a5da7420@ideasonboard.com>
 <20240410-enable-streams-impro-v3-9-e5e7a5da7420@ideasonboard.com>
 <f8e293b7-6a06-4477-9c7e-d1b83163f8e1@ideasonboard.com>
 <72940e89-0384-4fd3-8a10-42d6db44fdf0@ideasonboard.com>
 <155bb2c2-21b9-48d5-9615-7a44d4b6a590@ideasonboard.com>
 <da30ee6a-d8b1-44ad-8a29-fc9ac84aba9d@ideasonboard.com>
From: Umang Jain <umang.jain@ideasonboard.com>
In-Reply-To: <da30ee6a-d8b1-44ad-8a29-fc9ac84aba9d@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Tomi

On 11/04/24 5:23 pm, Tomi Valkeinen wrote:
> On 11/04/2024 14:48, Umang Jain wrote:
>> Hi Tomi,
>>
>> On 11/04/24 4:37 pm, Tomi Valkeinen wrote:
>>> On 11/04/2024 14:02, Umang Jain wrote:
>>>> Hi Tomi,
>>>>
>>>> On 10/04/24 6:05 pm, Tomi Valkeinen wrote:
>>>>> At the moment the v4l2_subdev_enable/disable_streams() functions call
>>>>> fallback helpers to handle the case where the subdev only implements
>>>>> .s_stream(), and the main function handles the case where the subdev
>>>>> implements streams (V4L2_SUBDEV_FL_STREAMS, which implies
>>>>> .enable/disable_streams()).
>>>>>
>>>>> What is missing is support for subdevs which do not implement streams
>>>>> support, but do implement .enable/disable_streams(). Example cases of
>>>>> these subdevices are single-stream cameras, where using
>>>>> .enable/disable_streams() is not required but helps us remove the 
>>>>> users
>>>>> of the legacy .s_stream(), and subdevices with multiple source 
>>>>> pads (but
>>>>> single stream per pad), where .enable/disable_streams() allows the
>>>>> subdevice to control the enable/disable state per pad.
>>>>>
>>>>> The two single-streams cases (.s_stream() and 
>>>>> .enable/disable_streams())
>>>>> are very similar, and with small changes we can change the
>>>>> v4l2_subdev_enable/disable_streams() functions to support all three
>>>>> cases, without needing separate fallback functions.
>>>>>
>>>>> A few potentially problematic details, though:
>>>>
>>>> Does this mean the patch needs to be worked upon more ?
>>>
>>> I don't see the two issues below as blockers.
>>>
>>>> I quickly tested the series by applying it locally with my use case 
>>>> of IMX283 .enable/disable streams and s_stream as the helper 
>>>> function and it seems I am still seeing the same behaviour as 
>>>> before (i.e. not being streamed) and have to carry the workaround 
>>>> as mentioned in [1] **NOTE**
>>>
>>> Ok... Then something bugs here, as it is supposed to fix the 
>>> problem. Can you trace the code a bit to see where it goes wrong?
>>>
>>> The execution should go to the "if (!(sd->flags & 
>>> V4L2_SUBDEV_FL_STREAMS))" blocks in v4l2_subdev_collect_streams() 
>>> and v4l2_subdev_set_streams_enabled(),
>>
>> The execution is not reaching in v4l2_subdev_collect streams() even, 
>> it returns at
>>
>>      if (!streams_mask)
>>                  return 0;
>>
>> in v4l2_subdev_enable_streams()
>>
>> Refer to : https://paste.debian.net/1313760/
>>
>> My tree is based on v6.8 currently, but the series applies cleanly, 
>> so I have not introduced any  rebase artifacts. If you think, v6.8 
>> might be causing issues, I'll then try to test on RPi 5 with the 
>> latest media tree perhaps.
>
> So who is calling the v4l2_subdev_enable_streams? I presume it comes 
> from v4l2_subdev_s_stream_helper(), in other words the sink side in 
> your pipeline is using legacy s_stream?

Yes it comes from the helper function

static const struct v4l2_subdev_video_ops imx283_video_ops = {
         .s_stream = v4l2_subdev_s_stream_helper,
};

>
> Indeed, that helper still needs work. It needs to detect if there's no 
> routing, and use the implicit stream 0. I missed that one.

Yes, no routing in the driver.
>
>  Tomi
>


