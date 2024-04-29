Return-Path: <linux-kernel+bounces-162644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 788988B5E82
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CDA5B220AE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9086B83CC7;
	Mon, 29 Apr 2024 16:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lM2Okhzo"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700818289E;
	Mon, 29 Apr 2024 16:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714406562; cv=none; b=q26WlqhHjjOeUWpOhUHMGZvNFWnZIMHv8LDTunWmDXxI45/JR4XZapuQnCbTNU6Vah4KtetD6B2yIAV0sJYkqDC/tkTmv1Zp+D8gut/dhngJmQk9QT6vwSqnj05EChA1g8solqq9/8Q08s42eOo6iWZnwlHD+H8pz6UyXeYiR28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714406562; c=relaxed/simple;
	bh=20Ns4wgNAJKSSn/3JhX/2hs3/vVgUpIKj/FYouQuJuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hlFWechYao+j8ZDTKMEkx3rFGNbl1Yjt+CpAx4JgehjScfchHfB7qffWY/65WeaSpIqprV4xFVwt1KwBueqA5uIxpCsYTb1SbXdfZx9AbJK5Gq3pBAmydsH6Hdku4NgbcYYv7UXEPKOLj+XW/xqRG9ah7vpu8NK4v6uiiJUNoKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lM2Okhzo; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e4266673bbso41378305ad.2;
        Mon, 29 Apr 2024 09:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714406561; x=1715011361; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XElcZBZlENfzNj4boLjR3y7e5I4/X7cqaLkM/HBBcyc=;
        b=lM2OkhzoI1GKtUlcv2n7hVl4sCilpAE8P2J9xbsvzKGzuIKulVGJVHJUv7TIO78twW
         aiOdVVt6QNcEWpxF8BcxCVzI57dfQ2FeCe0mfWnmJlo0SxwFBYQ8KsQmclcy87ICEHrM
         7JwV+AWe0RlCUPKvX0W4vyaz9Gx2C/cTyKwDBJhr19yz3jHi91T2nUsLD7BtbTIy02+M
         EdPc0pgkzBXaqzxeRC68ECHfKRF47VVEZhVMIaNqjcLoonyiIRLU2VGmvktEguyZbmMN
         okkOEIAcntzKtI4Rtp9sA9kk2lZu2TKO20KzqqcLhwgLOIb3fO3NyctLgrjW6fgjiAFa
         02Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714406561; x=1715011361;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XElcZBZlENfzNj4boLjR3y7e5I4/X7cqaLkM/HBBcyc=;
        b=arUY89YDRQBfOQnkISpm1/z9ZBhzRX5HeosZh6zf2iUh6sOVta6DVtKxOITGDX/myr
         hQIXQQQFsIr8Dhve/ny7h8XR9x/lOAALqShxJtuaq5yfdJZxa3xkuXl/ein9+YK7P+TB
         WszerkE9NNlAMuqpaAMMmHraeosaI6Qd7d8koSAEbpFLG9hZx/dgLqFCNLz1Jrr7bu1i
         43ub/rCmHSpeJcXfgG1d96Di1iSmMehHtEFozyMwAGQCbgctZXIV+cDc4OrvDDVF8UCv
         1pctfFasiXOV1C6G1DuHCxX+I1/wSr42g8xHCw/6Om1EK8tw5PGhH2mySLpXEJ7YUkWz
         WXag==
X-Forwarded-Encrypted: i=1; AJvYcCXMyaNLmgsGVHgBHwHO/w325YTS7QmdVgd5vAOAOdHi81tnzj09aLkfN7ro8d81UkFMi1JvInl2WQUVre9wTIzL1+Ety/fZ8UdtNs3N
X-Gm-Message-State: AOJu0YxDM1UQlkLu+CyMyXNMF11K/0O1oVGCaMDXCPBrB/Fyag0+eE8X
	X8nepKDItBcjC07X/7YXWPEuTvlTrN9wkUNqK99a0Yimwcp2hDLg
X-Google-Smtp-Source: AGHT+IEmTiLTD64Ac2EM7arnV5w9aPxywPkYhj2PhF+2vVvr6wC++LqVM+oVSCMVMxR+T9W/EHlOrA==
X-Received: by 2002:a17:903:11c5:b0:1e4:362b:17d5 with SMTP id q5-20020a17090311c500b001e4362b17d5mr12287816plh.4.1714406560634;
        Mon, 29 Apr 2024 09:02:40 -0700 (PDT)
Received: from ?IPV6:2402:e280:214c:86:9744:8dfe:8ee3:9c0a? ([2402:e280:214c:86:9744:8dfe:8ee3:9c0a])
        by smtp.gmail.com with ESMTPSA id x7-20020a1709027c0700b001e2c8bc6bebsm20598614pll.81.2024.04.29.09.02.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 09:02:40 -0700 (PDT)
Message-ID: <92648cb3-5b7c-47a8-ab0e-a7a4fe5f7c27@gmail.com>
Date: Mon, 29 Apr 2024 21:32:35 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux-next] media: i2c: st-mipid02: replace of_node_put()
 with __free
To: Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
 sylvain.petinot@foss.st.com, mchehab@kernel.org,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, javier.carrasco.cruz@gmail.com,
 Julia Lawall <julia.lawall@inria.fr>
References: <20240427095643.11486-1-prosunofficial@gmail.com>
 <d2432381-827f-4825-a450-9954f8291576@foss.st.com>
Content-Language: en-US
From: R Sundar <prosunofficial@gmail.com>
In-Reply-To: <d2432381-827f-4825-a450-9954f8291576@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/04/24 14:22, Benjamin Mugnier wrote:
> Hi,
> 
> Thank you for your patch.
> 
> On 4/27/24 11:56, R Sundar wrote:
>> Use the new cleanup magic to replace of_node_put() with
>> __free(device_node) marking to auto release and to simplify the error
>> paths.
>>
>> Suggested-by: Julia Lawall <julia.lawall@inria.fr>
>> Signed-off-by: R Sundar <prosunofficial@gmail.com>
> 
> I was not aware of this kind of auto release mechanism. Thanks for
> bringing that to my eyes.
> 
> Now I looked in /drivers/media and couldn't find such structure. All
> drivers seem to follow the goto error_of_node_put style.
> As I'm unsure if we want to introduce such magic, could either Laurent
> or Sakari comment on this ?
> 
>> ---
>>   drivers/media/i2c/st-mipid02.c | 37 +++++++++-------------------------
>>   1 file changed, 9 insertions(+), 28 deletions(-)
>>
>> diff --git a/drivers/media/i2c/st-mipid02.c b/drivers/media/i2c/st-mipid02.c
>> index f250640729ca..d42a306530f3 100644
>> --- a/drivers/media/i2c/st-mipid02.c
>> +++ b/drivers/media/i2c/st-mipid02.c
>> @@ -715,31 +715,28 @@ static int mipid02_parse_rx_ep(struct mipid02_dev *bridge)
>>   	struct v4l2_fwnode_endpoint ep = { .bus_type = V4L2_MBUS_CSI2_DPHY };
>>   	struct i2c_client *client = bridge->i2c_client;
>>   	struct v4l2_async_connection *asd;
>> -	struct device_node *ep_node;
>>   	int ret;
>>   
>>   	/* parse rx (endpoint 0) */
>> -	ep_node = of_graph_get_endpoint_by_regs(bridge->i2c_client->dev.of_node,
>> -						0, 0);
>> +	struct device_node *ep_node __free(device_node) =
>> +		of_graph_get_endpoint_by_regs(bridge->i2c_client->dev.of_node, 0, 0);
>>   	if (!ep_node) {
>>   		dev_err(&client->dev, "unable to find port0 ep");
>> -		ret = -EINVAL;
>> -		goto error;
>> +		return -EINVAL;
>>   	}
>>   
>>   	ret = v4l2_fwnode_endpoint_parse(of_fwnode_handle(ep_node), &ep);
>>   	if (ret) {
>>   		dev_err(&client->dev, "Could not parse v4l2 endpoint %d\n",
>>   			ret);
>> -		goto error_of_node_put;
>> +		return ret;
>>   	}
>>   
>>   	/* do some sanity checks */
>>   	if (ep.bus.mipi_csi2.num_data_lanes > 2) {
>>   		dev_err(&client->dev, "max supported data lanes is 2 / got %d",
>>   			ep.bus.mipi_csi2.num_data_lanes);
>> -		ret = -EINVAL;
>> -		goto error_of_node_put;
>> +		return -EINVAL;
>>   	}
>>   
>>   	/* register it for later use */
>> @@ -750,7 +747,6 @@ static int mipid02_parse_rx_ep(struct mipid02_dev *bridge)
>>   	asd = v4l2_async_nf_add_fwnode_remote(&bridge->notifier,
>>   					      of_fwnode_handle(ep_node),
>>   					      struct v4l2_async_connection);
>> -	of_node_put(ep_node);
>>   
>>   	if (IS_ERR(asd)) {
>>   		dev_err(&client->dev, "fail to register asd to notifier %ld",
>> @@ -764,46 +760,31 @@ static int mipid02_parse_rx_ep(struct mipid02_dev *bridge)
>>   		v4l2_async_nf_cleanup(&bridge->notifier);
>>   
>>   	return ret;
>> -
>> -error_of_node_put:
>> -	of_node_put(ep_node);
>> -error:
>> -
>> -	return ret;
>>   }
>>   
>>   static int mipid02_parse_tx_ep(struct mipid02_dev *bridge)
>>   {
>>   	struct v4l2_fwnode_endpoint ep = { .bus_type = V4L2_MBUS_PARALLEL };
>>   	struct i2c_client *client = bridge->i2c_client;
>> -	struct device_node *ep_node;
>>   	int ret;
>>   
>>   	/* parse tx (endpoint 2) */
>> -	ep_node = of_graph_get_endpoint_by_regs(bridge->i2c_client->dev.of_node,
>> -						2, 0);
>> +	struct device_node *ep_node =
>> +		of_graph_get_endpoint_by_regs(bridge->i2c_client->dev.of_node, 2, 0);
> 
> Shouldn't there be a '__free' here too ?
> 

my Bad.
Yes, It should come here also. Thanks!!
Will update the patch.

Thanks,
Sundar



