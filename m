Return-Path: <linux-kernel+bounces-107015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A56D887F6C2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 444A81F22181
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 05:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B50446CF;
	Tue, 19 Mar 2024 05:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="tUB3kP8o"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA5A40871;
	Tue, 19 Mar 2024 05:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710826430; cv=none; b=Rf5bsro/4Dz4T9XI7ar1JN+lb58UFrKlC/bmSSvJIfNgnEmkwTiNyaX6yy29WBSVHRK9CjCBA18qn089SWiDjb3tJs9xr9Q3WBMZ9DyJ2IOS5PwWt7DMc7ZaTSzage/G+ghYx3vMPRhuAk2wwrjaiEG/juw73Etk0rBLl0P1UHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710826430; c=relaxed/simple;
	bh=hCDPkxTHGQvH545yk0oqwcxu6hu8OpzaJxwRoWq28dw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gXzfH7kMWxRjT35BjlgBIPjo6mzERdtXhPa/EOOoq8vFzvdG7owGcOMbTAabW6e4SJEXZCZ4VjzIpELLuMQeTLPXH6JoIVWpDC4792gzsCSLkFdsJSyNqp7RtIXNjTcJZ88SoMuBDcqXDrDdpHch9wST4/rfPBWhgzgRrMUnscg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=tUB3kP8o; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.1.105] (unknown [103.86.18.138])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id D13DABB2;
	Tue, 19 Mar 2024 06:33:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1710826396;
	bh=hCDPkxTHGQvH545yk0oqwcxu6hu8OpzaJxwRoWq28dw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tUB3kP8ooFzLUJp5PVdQZaVmcckNaFyO3mHENmJd0B73CvFKbJMQxa0NYk9S5uDgE
	 hoWnArFLcbqDE/gcAUcG3JeGgcvXEuFC4cmr6mFb2x6kGQs3CuAZnkwYKqaqfjIFVb
	 7b4slumxNc0oawcY4UX0pTpe3cytnTIvaL3q1vmc=
Message-ID: <64594704-4d2b-416f-952a-e6ff45828e35@ideasonboard.com>
Date: Tue, 19 Mar 2024 11:03:35 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] media: imx335: Parse fwnode properties
Content-Language: en-US
To: Tommaso Merciai <tomm.merciai@gmail.com>
Cc: linux-media@vger.kernel.org,
 Alexander Shiyan <eagle.alexander923@gmail.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 open list <linux-kernel@vger.kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>
References: <20240308083312.90279-1-umang.jain@ideasonboard.com>
 <20240308083312.90279-3-umang.jain@ideasonboard.com>
 <Zeru90ETVmNP6ehn@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
From: Umang Jain <umang.jain@ideasonboard.com>
In-Reply-To: <Zeru90ETVmNP6ehn@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Tommaso,

On 08/03/24 4:26 pm, Tommaso Merciai wrote:
> Hi Umang, Kieram,
>
> On Fri, Mar 08, 2024 at 02:03:08PM +0530, Umang Jain wrote:
>> From: Kieran Bingham <kieran.bingham@ideasonboard.com>
>>
>> Call the V4L2 fwnode device parser to handle controls that are
>> standardised by the framework.
>>
>> Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
>> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
>> ---
>>   drivers/media/i2c/imx335.c | 13 ++++++++++++-
>>   1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/media/i2c/imx335.c b/drivers/media/i2c/imx335.c
>> index 7162b0a3cef3..819ab3a6c5fc 100644
>> --- a/drivers/media/i2c/imx335.c
>> +++ b/drivers/media/i2c/imx335.c
>> @@ -1225,10 +1225,12 @@ static int imx335_init_controls(struct imx335 *imx335)
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
>> @@ -1300,6 +1302,15 @@ static int imx335_init_controls(struct imx335 *imx335)
>>   		return ctrl_hdlr->error;
>>   	}
>>   
>> +	ret = v4l2_fwnode_device_parse(imx335->dev, &props);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = v4l2_ctrl_new_fwnode_properties(ctrl_hdlr, &imx335_ctrl_ops,
>> +					      &props);
>> +	if (ret)
>> +		return ret;
>> +
>>   	imx335->sd.ctrl_handler = ctrl_hdlr;
>>   
>>   	return 0;
> Just a doubt on my side.
> We don't need an error path to free ctrl_hdlr?
> Or I'm missing something?

No, you are right.

We need to free the ctrl_hdlr on error patch.
>
> Something similar:
>
> ret = v4l2_fwnode_device_parse(imx335->dev, &props);
> if (ret)
> 	goto free_ctrls;
>
> ret = v4l2_ctrl_new_fwnode_properties(ctrl_hdlr, &imx335_ctrl_ops,
> 	                              &props);
> if (ret)
> 	return ret;
>
> free_ctrls:
> 	v4l2_ctrl_handler_free(hdl);
> 	return ret;
>
> Thanks & Regards,
> Tommaso
>
>> -- 
>> 2.43.0
>>
>>


