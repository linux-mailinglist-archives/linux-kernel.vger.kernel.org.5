Return-Path: <linux-kernel+bounces-142703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E245C8A2F26
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 704F0B22E3A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBA564CF9;
	Fri, 12 Apr 2024 13:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="t+5MkzCM"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE9C64CD0;
	Fri, 12 Apr 2024 13:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712927810; cv=none; b=Qvc354iR7pBXvhoplApmlJIZBkkBZWyYB/ve1MunP5LrwH/OebC0iEzWUzi7DUgi/sZGP/sC1vXKWqOJ9yb1RIZU88zxFX/NmomcKm19MQGJGuwLEjV2HGL4y8h8pFMtnRN7MnV+YrK+MjXWJNtTL5xSKcrewgRk04BMngtaRtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712927810; c=relaxed/simple;
	bh=MaGSYA2Udrt5OpxI+Noda33oYVm+GYTXXkzp8OxlUIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bSk2C+H1GaFRUSChJRbg9V7wpOi9Tmi2MjM7NlZswwb/89geS3/YiQEc5tsslyB2SkWWeugO/fmRZMmAO0sm3HsUBR5RILzRvgKRzp+yutUrtRoZJjCrMG63evfRIo5CzPKo1lB/Fa5mcPh3UjVNaSPdroYs2ugo61esMo6kWoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=t+5MkzCM; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.1.105] (unknown [103.251.226.65])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1FCA9A12;
	Fri, 12 Apr 2024 15:16:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712927763;
	bh=MaGSYA2Udrt5OpxI+Noda33oYVm+GYTXXkzp8OxlUIs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=t+5MkzCMs5CrvGPkUIU44pXddxI4oJasu4maLhApJXGy9DfJZx23YjHrj5c6i+7Jd
	 wQKzb2ad0OH00plsFJGTwsOfdlWaacwk6O0htPjEEZ4uvwBV3HwOxJuw7ErZMxm+zz
	 Grab0Ztl3KHAKzftajg2UzGKwjm5ACvAVbLxPLx0=
Message-ID: <3092092b-5989-4a7f-8f3b-4e1bf2aed385@ideasonboard.com>
Date: Fri, 12 Apr 2024 18:46:39 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/6] media: imx335: Parse fwnode properties
Content-Language: en-US
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-media@vger.kernel.org,
 Alexander Shiyan <eagle.alexander923@gmail.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20240412122842.193713-1-umang.jain@ideasonboard.com>
 <20240412122842.193713-3-umang.jain@ideasonboard.com>
 <ZhkxJeQSKMxj0O7b@kekkonen.localdomain>
From: Umang Jain <umang.jain@ideasonboard.com>
In-Reply-To: <ZhkxJeQSKMxj0O7b@kekkonen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sakari,

On 12/04/24 6:33 pm, Sakari Ailus wrote:
> Hi Umang,
>
> On Fri, Apr 12, 2024 at 05:58:38PM +0530, Umang Jain wrote:
>> From: Kieran Bingham <kieran.bingham@ideasonboard.com>
>>
>> Call the V4L2 fwnode device parser to handle controls that are
>> standardised by the framework.
>>
>> Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
>> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
>> ---
>>   drivers/media/i2c/imx335.c | 16 ++++++++++++----
>>   1 file changed, 12 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/media/i2c/imx335.c b/drivers/media/i2c/imx335.c
>> index c633ea1380e7..3ea9c0ebe278 100644
>> --- a/drivers/media/i2c/imx335.c
>> +++ b/drivers/media/i2c/imx335.c
>> @@ -1227,10 +1227,12 @@ static int imx335_init_controls(struct imx335 *imx335)
>>   {
>>   	struct v4l2_ctrl_handler *ctrl_hdlr = &imx335->ctrl_handler;
>>   	const struct imx335_mode *mode = imx335->cur_mode;
>> +	struct v4l2_fwnode_device_properties props;
>>   	u32 lpfr;
>>   	int ret;
>>   
>> -	ret = v4l2_ctrl_handler_init(ctrl_hdlr, 7);
>> +	/* v4l2_fwnode_device_properties can add two more controls */
>> +	ret = v4l2_ctrl_handler_init(ctrl_hdlr, 9);
>>   	if (ret)
>>   		return ret;
>>   
>> @@ -1295,9 +1297,15 @@ static int imx335_init_controls(struct imx335 *imx335)
>>   	if (imx335->hblank_ctrl)
>>   		imx335->hblank_ctrl->flags |= V4L2_CTRL_FLAG_READ_ONLY;
>>   
>> -	if (ctrl_hdlr->error) {
>> -		dev_err(imx335->dev, "control init failed: %d\n",
>> -			ctrl_hdlr->error);
>> +	ret = v4l2_fwnode_device_parse(imx335->dev, &props);
>> +	if (!ret) {
>> +		/* Failure sets ctrl_hdlr->error, which we check afterwards anyway */
>> +		v4l2_ctrl_new_fwnode_properties(ctrl_hdlr, &imx335_ctrl_ops,
>> +						&props);
>> +	}
>> +
>> +	if (ctrl_hdlr->error || ret) {
>> +		dev_err(imx335->dev, "control init failed: %d\n", ctrl_hdlr->error);
> Too long line.
>
>>   		v4l2_ctrl_handler_free(ctrl_hdlr);
>>   		return ctrl_hdlr->error;
> The handler may not be in error state if only v4l2_fwnode_device_parse()
> failed.

I read some more drivers and it seems v4l2_fwnode_device_parse() can 
probably be checked at start of init_controls() and return early on 
non-zero return value.

Is that something that should be done here as well ?
>
> Should that be something that should prevent probing a driver though, or
> could it just be ignored? I.e. in that case I'd only check for handler's
> error, not ret.

So we should probably check for ret and ctrl_hdlr->error separately ?
>
>>   	}


