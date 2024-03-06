Return-Path: <linux-kernel+bounces-94323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89983873D43
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45D04283181
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB51513BAE7;
	Wed,  6 Mar 2024 17:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="SBSOOvRU"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A6313A87A;
	Wed,  6 Mar 2024 17:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709745490; cv=none; b=LTfdH6TtDZWGLY4+X69YUaab2RX+pxBj3aDL6b7sFPSEXYskT2ZdKknFC/tPFZTNqhiX8MZ1d/GoU/AW9xiYQI4D3MrNG7EXUdDC0ESqJsyj0QoANsYaPP9MxPKOPixq6v1q9B0hZqJQZUPFE9V7F+U7t/cvfE76JiMP+VQilwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709745490; c=relaxed/simple;
	bh=w9iPnR7GWwEoE2fTw+KjdzvpR/9v7gTsbQkxCb4xwmU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lk4LxmX5RUdLeAaeOFMW3aTnlO38lbv+R4RIOX0/gZ+8JcAxdERTvNsMSJVmjaT4gYmR371e8hJZ12fzbpOZKxZc7qfQH/4KKAW2eRLy3E7yQB8vGept/+Z6t6yfP5+/QodhFfewn7RNBmCRykmORHabpxIGxHLm9UlK5sqAHao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=SBSOOvRU; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.1.102] (unknown [103.251.226.70])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 131D8552;
	Wed,  6 Mar 2024 18:17:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1709745469;
	bh=w9iPnR7GWwEoE2fTw+KjdzvpR/9v7gTsbQkxCb4xwmU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SBSOOvRUUVVrj1Spyr/HMVEGX7ro2CMBw6grU1kZfLq/047jxWUshy4+PvlFu4ULW
	 DFcrSPaX/IkFxY5DBL0P2bc66cDCVEAmjUfw6sncRSu2/heOJsEPUZbE0USFBRswzU
	 UeGYv7Nt/m4a+HrcV5eih6GBWBsrsMb6ZYKgWDIE=
Message-ID: <c7abfe94-5cf4-4490-854d-7a1a8c653820@ideasonboard.com>
Date: Wed, 6 Mar 2024 22:47:56 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] media: imx335: Fix active area height discrepency
Content-Language: en-US
To: Kieran Bingham <kieran.bingham@ideasonboard.com>,
 linux-media@vger.kernel.org
Cc: Alexander Shiyan <eagle.alexander923@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20240306081038.212412-1-umang.jain@ideasonboard.com>
 <20240306081038.212412-5-umang.jain@ideasonboard.com>
 <170974471357.362031.9683522744235199514@ping.linuxembedded.co.uk>
From: Umang Jain <umang.jain@ideasonboard.com>
In-Reply-To: <170974471357.362031.9683522744235199514@ping.linuxembedded.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Kieran,

On 06/03/24 10:35 pm, Kieran Bingham wrote:
> Quoting Umang Jain (2024-03-06 08:10:37)
>> The imx335 reports a recommended pixel area of - 2592x1944.
>> The driver supported mode however limits it to height=1940.
> Hrm, I think I would convert widths and sizes to decimal as a patch
> before this patch so the effect is clearer in this diff.
>
>> Fix the height discrepency by correctly the value of height
>> (with updates to vblank and mode registers).
>>
>> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
>> ---
>>   drivers/media/i2c/imx335.c | 18 +++++++++---------
>>   1 file changed, 9 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/media/i2c/imx335.c b/drivers/media/i2c/imx335.c
>> index 6ea09933e47b..c00e0c2be3f3 100644
>> --- a/drivers/media/i2c/imx335.c
>> +++ b/drivers/media/i2c/imx335.c
>> @@ -246,13 +246,13 @@ static const int imx335_tpg_val[] = {
>>   };
>>   
>>   /* Sensor mode registers */
>> -static const struct cci_reg_sequence mode_2592x1940_regs[] = {
>> +static const struct cci_reg_sequence mode_2592x1944_regs[] = {
>>          {IMX335_REG_MODE_SELECT, 0x01},
>>          {IMX335_REG_MASTER_MODE, 0x00},
>> -       {IMX335_REG_WINMODE, 0x04},
>> -       {IMX335_REG_HTRIMMING_START, 0x0180},
>> +       {IMX335_REG_WINMODE, 0x00},
> What's the distinction of the winmode here. What is 0x04 vs 0x00?
>
> Is this something that could be a defined value? Or is that not worth
> the effort?

It can be split out as a define in later parts if we introduce more 
modes. currently this change fixes the sensor to be in 'all-pixel scan 
mode' hence you see the change in value of WINMODE.
>
>> +       {IMX335_REG_HTRIMMING_START, 0x30},
> HTRIMMING_START has moved a lot more than I would expect there.
> Is there a visual impact of any concern here?

Value as per mentioned in the datasheet
>
>>          {IMX335_REG_HNUM, 0x0a20},
>> -       {IMX335_REG_Y_OUT_SIZE, 0x0794},
>> +       {IMX335_REG_Y_OUT_SIZE, 0x0798},
> This bit looks expected ;-)
>
>>          {IMX335_REG_VCROP_POS, 0x00b0},
>>          {IMX335_REG_VCROP_SIZE, 0x0f58},
> 0x0f58 = 3928. Does that correspond to anything on the pixel array size?
> We're modifying the vertical size, so I'm curious if the 'vcrop' is or
> should be impacted?

Probably I have not named this correctly, as VCROP_

This register (0x3076) is denotes the size of cropping rectangle
Named as 'AREA3_WIDTH_1' with explaination 'cropping size designation 
(Vertical direction)'

The value 0x0f58 is as per mentioned in the datasheet. I don't find any 
relation except 3928 is twice the IMX335_NATIVE_HEIGHT
>
>>          {IMX335_REG_OPB_SIZE_V, 0x00},
>> @@ -403,14 +403,14 @@ static const u32 imx335_mbus_codes[] = {
>>   /* Supported sensor mode configurations */
>>   static const struct imx335_mode supported_mode = {
>>          .width = 2592,
>> -       .height = 1940,
>> +       .height = 1944,
>>          .hblank = 342,
>> -       .vblank = 2560,
>> -       .vblank_min = 2560,
>> +       .vblank = 2556,
>> +       .vblank_min = 2556,
>>          .vblank_max = 133060,
>>          .reg_list = {
>> -               .num_of_regs = ARRAY_SIZE(mode_2592x1940_regs),
>> -               .regs = mode_2592x1940_regs,
>> +               .num_of_regs = ARRAY_SIZE(mode_2592x1944_regs),
>> +               .regs = mode_2592x1944_regs,
>>          },
>>   };
>>   
>> -- 
>> 2.43.0
>>


