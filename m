Return-Path: <linux-kernel+bounces-106339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B4787ECB6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52487280DC8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C7D52F84;
	Mon, 18 Mar 2024 15:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gwRvodGd"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4403252F6D
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 15:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710777207; cv=none; b=Bq9YQeg+odfy5j7VOWt2zqy2GwN+42wvWVYuJ5XsFfXbx0A52sxUGuBcbfETV4eglnoWZRU51i/TYQd8NWRaW+kotHpkba/Jtp1Kz4T/W4d/HhOTW/aWhSM7LLq/LPHQd0cyoDvCESCSRd2yht2B2qFqGH9Fm0S9DcCJforzjPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710777207; c=relaxed/simple;
	bh=z0wJ+k9rqzFqZleSpK4pYoTZqFsI54pQOlfGa1XA+Hg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WWylkO0egbQQZdvvyMDNi5w/c+9plIMiUgzB57Cq+xFkydiJ+RdE7lBKJF+MYw/6PiJFQ4qlHUCCZucK/VQ4/zGpx7EWjLkbicn8xhNLjqqYcpczmHS1xOu0JyjKnxXGEMpM4umlw+mnp53qCuCqFWTRiXddRL/GpVSymxBLvGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gwRvodGd; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <22229306-aa72-4367-b029-fbdff4410cec@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710777203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u2fhW2XsomTNdCpefo2Y8uVowFyGOPa7DoCroUYHuXk=;
	b=gwRvodGdcbILQ+b8YI+F3em9ZFo2G15b7eb75ycddqP88fLN0j4PuBzDMVddeCxSFlOgBX
	59nwzRSYzIUUUXINo27wZ4D6Fklty9A/hp9VIh3/zpz9Q8x5BQ54iBnLb7QBB5rYlH1uV7
	SReV9oeTK+U/JfWA8bBdR+cVOi/RL0Y=
Date: Mon, 18 Mar 2024 23:53:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] drm: bridge: thc63lvd1024: Switch to use
 of_graph_get_remote_node()
Content-Language: en-US
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240316172800.1168390-1-sui.jingfeng@linux.dev>
 <20240318153326.GD13682@pendragon.ideasonboard.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <20240318153326.GD13682@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,


On 2024/3/18 23:33, Laurent Pinchart wrote:
> Hi Sui,
>
> Thank you for the patch.
>
> On Sun, Mar 17, 2024 at 01:28:00AM +0800, Sui Jingfeng wrote:
>> To reduce boilerplate, use of_graph_get_remote_node() helper instead of
>> the hand-rolling code.
>>
>> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
>> ---
>>   drivers/gpu/drm/bridge/thc63lvd1024.c | 24 +++---------------------
>>   1 file changed, 3 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/thc63lvd1024.c b/drivers/gpu/drm/bridge/thc63lvd1024.c
>> index d4c1a601bbb5..5f99f9724081 100644
>> --- a/drivers/gpu/drm/bridge/thc63lvd1024.c
>> +++ b/drivers/gpu/drm/bridge/thc63lvd1024.c
>> @@ -123,28 +123,10 @@ static int thc63_parse_dt(struct thc63_dev *thc63)
>>   	struct device_node *endpoint;
>>   	struct device_node *remote;
>>   
>> -	endpoint = of_graph_get_endpoint_by_regs(thc63->dev->of_node,
>> -						 THC63_RGB_OUT0, -1);
>> -	if (!endpoint) {
>> -		dev_err(thc63->dev, "Missing endpoint in port@%u\n",
>> -			THC63_RGB_OUT0);
>> -		return -ENODEV;
>> -	}
>> -
>> -	remote = of_graph_get_remote_port_parent(endpoint);
>> -	of_node_put(endpoint);
>> -	if (!remote) {
>> -		dev_err(thc63->dev, "Endpoint in port@%u unconnected\n",
>> -			THC63_RGB_OUT0);
>> +	remote = of_graph_get_remote_node(thc63->dev->of_node,
>> +					  THC63_RGB_OUT0, -1);
>> +	if (!remote)
> The old logic is equivalent to of_graph_get_remote_node(), but now the
> driver will fail probing without an error message. That's not very nice
> as it leads to difficult to debug problems. I would keep one dev_err()
> here:
>
> 		dev_err(thc63->dev, "No remote endpoint for port@%u\n",
> 			THC63_RGB_OUT0);
>
> As your patch has been merged already, would you like to post a
> follow-up patch to fix this ?


Yes, this is indeed a difference. I will post a follow-up patch to fix this.


>>   		return -ENODEV;
>> -	}
>> -
>> -	if (!of_device_is_available(remote)) {
>> -		dev_err(thc63->dev, "port@%u remote endpoint is disabled\n",
>> -			THC63_RGB_OUT0);
>> -		of_node_put(remote);
>> -		return -ENODEV;
>> -	}
>>   
>>   	thc63->next = of_drm_find_bridge(remote);
>>   	of_node_put(remote);

-- 
Best regards,
Sui


