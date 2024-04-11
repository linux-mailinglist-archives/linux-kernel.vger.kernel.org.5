Return-Path: <linux-kernel+bounces-139803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1FB8A07E1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35C1A287745
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E4213CA89;
	Thu, 11 Apr 2024 05:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="NUBl8/f0"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A841FBB;
	Thu, 11 Apr 2024 05:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712814276; cv=none; b=UiKcGtTJApJNoeGlTwglnq55d5uoNUY9HtphdFAMrb2vWFsrR58ZC6zkF3Maor68mBO9MDZ+FaxDNh/6w86SsE/3Cs4zlxvEpUWXfQc2//cjEWLRwWM8ktfdh0gOuakTboa6zmWwPHoh0Y2xjd8RvSiNFl86MG3fbM+CeEyiWFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712814276; c=relaxed/simple;
	bh=4tfxVRoFzIvBRtdMejGqFz2YybrjlHKfyPcyxEGWSBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W0TdiRJqr0gqi5ubEhpcc4A/xNYxLbR3r+/1EiDkyEZOWn0vKfiHoSJhfIR3IkHV6VVMawV4Fe2vyKAOwxXvHgBEuYK6eCDgWmsPfNh34Tbe7QsE9cavhn0oWDjbBIHt+K8mFD6JZkDeTYSZA2lPnr6SjSJINGSGTAinCVjP8x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=NUBl8/f0; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.1.108] (unknown [103.86.18.224])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9B529E1;
	Thu, 11 Apr 2024 07:43:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712814230;
	bh=4tfxVRoFzIvBRtdMejGqFz2YybrjlHKfyPcyxEGWSBI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NUBl8/f0WhTZigNSoGHzJHqkoQX1WPZdob/GeqBUNcuVkT1OZO2fSJEAPxZkIxDPd
	 9Do0yDsrzPv86xFTjRERMRleZE+ciizO6uSLhD10T12GoQs/as3POTx/Fsz/fsNx73
	 1fZKQ76g5N15u7arUV6HsFZlg8VcXegJkQE1bJH4=
Message-ID: <e7b07a8c-d56f-486f-9c5e-d0450288a1a3@ideasonboard.com>
Date: Thu, 11 Apr 2024 11:14:26 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] media: v4l: Don't turn on privacy LED if streamon
 fails
Content-Language: en-US
To: Sakari Ailus <sakari.ailus@linux.intel.com>, linux-media@vger.kernel.org
Cc: tomi.valkeinen@ideasonboard.com,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil
 <hverkuil@xs4all.nl>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
References: <20240410114712.661186-1-sakari.ailus@linux.intel.com>
 <d330e0fa-fc50-4920-9000-c6343f5f101b@redhat.com>
From: Umang Jain <umang.jain@ideasonboard.com>
In-Reply-To: <d330e0fa-fc50-4920-9000-c6343f5f101b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sakari,

Thank you for the patch

On 10/04/24 5:18 pm, Hans de Goede wrote:
> Hi,
>
> On 4/10/24 1:47 PM, Sakari Ailus wrote:
>> Turn on the privacy LED only if streamon succeeds. This can be done after
>> enabling streaming on the sensor.
>>
>> Fixes: b6e10ff6c23d ("media: v4l2-core: Make the v4l2-core code enable/disable the privacy LED if present")
>> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Thanks, patch looks good to me:

Looks good to me too
>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Reviewed-by: Umang Jain <umang.jain@ideasonboard.com>

>
> Regards,
>
> Hans
>
>
>
>> ---
>>   drivers/media/v4l2-core/v4l2-subdev.c | 22 ++++++++++++----------
>>   1 file changed, 12 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
>> index 4c6198c48dd6..012b757eac9f 100644
>> --- a/drivers/media/v4l2-core/v4l2-subdev.c
>> +++ b/drivers/media/v4l2-core/v4l2-subdev.c
>> @@ -412,15 +412,6 @@ static int call_s_stream(struct v4l2_subdev *sd, int enable)
>>   	if (WARN_ON(!!sd->enabled_streams == !!enable))
>>   		return 0;
>>   
>> -#if IS_REACHABLE(CONFIG_LEDS_CLASS)
>> -	if (!IS_ERR_OR_NULL(sd->privacy_led)) {
>> -		if (enable)
>> -			led_set_brightness(sd->privacy_led,
>> -					   sd->privacy_led->max_brightness);
>> -		else
>> -			led_set_brightness(sd->privacy_led, 0);
>> -	}
>> -#endif
>>   	ret = sd->ops->video->s_stream(sd, enable);
>>   
>>   	if (!enable && ret < 0) {
>> @@ -428,9 +419,20 @@ static int call_s_stream(struct v4l2_subdev *sd, int enable)
>>   		ret = 0;
>>   	}
>>   
>> -	if (!ret)
>> +	if (!ret) {
>>   		sd->enabled_streams = enable ? BIT(0) : 0;
>>   
>> +#if IS_REACHABLE(CONFIG_LEDS_CLASS)
>> +		if (!IS_ERR_OR_NULL(sd->privacy_led)) {
>> +			if (enable)
>> +				led_set_brightness(sd->privacy_led,
>> +						   sd->privacy_led->max_brightness);
>> +			else
>> +				led_set_brightness(sd->privacy_led, 0);
>> +		}
>> +#endif
>> +	}
>> +
>>   	return ret;
>>   }
>>   


