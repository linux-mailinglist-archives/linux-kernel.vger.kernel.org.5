Return-Path: <linux-kernel+bounces-139839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1E98A0853
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60FDE2816F7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E52413CAB3;
	Thu, 11 Apr 2024 06:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="a9eKsWH2"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036DD13CA91;
	Thu, 11 Apr 2024 06:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712816302; cv=none; b=TNcOjIswjAXFIFSILGa/611HIGBeRdN52jdYSNK5bdRnZNilfipd62td+lPpcAjexNr2SueFWMMEJXPyxs1raP5Jvmwrf+PdlYRSn+5udC62+oEpz/tYlKdnKkXR69EClQ9c/+BjPewlNPSoEbVRX/fU8SzdJrOl2EBY7CpigrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712816302; c=relaxed/simple;
	bh=ZW1aGT3uhnc1jK2K8WMi9TSmoiF9Ns/S0B4BMYY9Rao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fq7k9RxW/VqqYS3XDxGHXq3T+rd1PK+Mh4Mt7PWpKhkocvwKtCZwqwbkqIqkEImWizfAzqUJEuNmU4VPoro0jYUXgOLzs5L0+ZyRXvteHVaOe3WZIQafH2UaLJ1BSUomox1ht8odyx4CypkqTBBCUslGTkHSLNA4LS02jv56xis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=a9eKsWH2; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.88.20] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5389723F;
	Thu, 11 Apr 2024 08:17:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712816256;
	bh=ZW1aGT3uhnc1jK2K8WMi9TSmoiF9Ns/S0B4BMYY9Rao=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=a9eKsWH2fHcfoLW5vgHAo3gjKNKiFJEK81szBuOFQ/0TSj+58IAT8AgUgM1pEvnmU
	 VZbMYM5XwNphpZEEwEpZ2DbnMInpxuNHD2n8eRhZUEGfy7b7q/W31PWz+DdAT48KBZ
	 6iX1xnBV+/ofO2SYRvvOyxNKN5JP5ynCv/FW9MhY=
Message-ID: <acbb93ce-33f3-4571-a5fb-ccf503924c8f@ideasonboard.com>
Date: Thu, 11 Apr 2024 09:18:15 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/9] media: subdev: Add checks for subdev features
To: Umang Jain <umang.jain@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil
 <hverkuil@xs4all.nl>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>
References: <20240410-enable-streams-impro-v3-0-e5e7a5da7420@ideasonboard.com>
 <20240410-enable-streams-impro-v3-3-e5e7a5da7420@ideasonboard.com>
 <397c3723-2100-4717-9206-d53e71eae885@ideasonboard.com>
Content-Language: en-US
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Autocrypt: addr=tomi.valkeinen@ideasonboard.com; keydata=
 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
In-Reply-To: <397c3723-2100-4717-9206-d53e71eae885@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/04/2024 08:34, Umang Jain wrote:
> Hi Tomi,
> 
> On 10/04/24 6:05 pm, Tomi Valkeinen wrote:
>> Add some checks to verify that the subdev driver implements required
>> features.
>>
>> A subdevice that supports streams (V4L2_SUBDEV_FL_STREAMS) must do one
>> of the following:
>>
>> - Implement neither .enable/disable_streams() nor .s_stream(), if the
>>    subdev is part of a video driver that uses an internal method to
>>    enable the subdev.
>> - Implement only .enable/disable_streams(), if support for legacy
>>    sink-side subdevices is not needed.
>> - Implement .enable/disable_streams() and .s_stream(), if support for
>>    legacy sink-side subdevices is needed.
>>
>> At the moment the framework doesn't check this requirement. Add the
>> check.
>>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> 
> The code looks aligned with the restrictions mentioned in the commit 
> message.
> 
> Only one question in case 3), does the .s_stream() needs to be helper 
> function I think, can we (or do we) need to check that as well?

Do you mean if in case 3, the s_stream should always be set to 
v4l2_subdev_s_stream_helper()?

I don't think so. The helper only works for subdevices with a single 
source pad. And even if the helper worked for multiple source pads, I 
don't see any specific reason to prevent the drivers from having their 
own implementation.

  Tomi

> Reviewed-by: Umang Jain <umang.jain@ideasonboard.com>
> 
>> ---
>>   drivers/media/v4l2-core/v4l2-subdev.c | 27 +++++++++++++++++++++++++++
>>   1 file changed, 27 insertions(+)
>>
>> diff --git a/drivers/media/v4l2-core/v4l2-subdev.c 
>> b/drivers/media/v4l2-core/v4l2-subdev.c
>> index 4a531c2b16c4..606a909cd778 100644
>> --- a/drivers/media/v4l2-core/v4l2-subdev.c
>> +++ b/drivers/media/v4l2-core/v4l2-subdev.c
>> @@ -1533,6 +1533,33 @@ int __v4l2_subdev_init_finalize(struct 
>> v4l2_subdev *sd, const char *name,
>>                   struct lock_class_key *key)
>>   {
>>       struct v4l2_subdev_state *state;
>> +    struct device *dev = sd->dev;
>> +    bool has_disable_streams;
>> +    bool has_enable_streams;
>> +    bool has_s_stream;
>> +
>> +    /* Check that the subdevice implements the required features */
>> +
>> +    has_s_stream = v4l2_subdev_has_op(sd, video, s_stream);
>> +    has_enable_streams = v4l2_subdev_has_op(sd, pad, enable_streams);
>> +    has_disable_streams = v4l2_subdev_has_op(sd, pad, disable_streams);
>> +
>> +    if (has_enable_streams != has_disable_streams) {
>> +        dev_err(dev,
>> +            "subdev '%s' must implement both or neither of 
>> .enable_streams() and .disable_streams()\n",
>> +            sd->name);
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (sd->flags & V4L2_SUBDEV_FL_STREAMS) {
>> +        if (has_s_stream && !has_enable_streams) {
>> +            dev_err(dev,
>> +                "subdev '%s' must implement 
>> .enable/disable_streams()\n",
>> +                sd->name);
>> +
>> +            return -EINVAL;
>> +        }
>> +    }
>>       state = __v4l2_subdev_state_alloc(sd, name, key);
>>       if (IS_ERR(state))
>>
> 


