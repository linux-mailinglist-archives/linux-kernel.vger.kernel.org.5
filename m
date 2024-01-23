Return-Path: <linux-kernel+bounces-35240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76557838E5E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E67191F24E13
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F68A5EE66;
	Tue, 23 Jan 2024 12:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rz/KJf5q"
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697225DF11
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 12:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706012312; cv=none; b=USPbzPPGuhx74VcVpIIeQTyxsvWTXMIhjlGq4jsll2bJfNmxRmuzFHY+fU3JlzTG4qG0gT2orlsBGaeU184kFvR14tS2w02NX2uOoG0FUoNYEQPGfQSalxLw2KKUdtLX2gNBWzCWkie9TomUjVyPpXAxMyc1fGRwXdkjKh2JmWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706012312; c=relaxed/simple;
	bh=vGdTHyxXjfiHI3G6K8/20CRZRw6/LiMwHfpC1+xKVRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U5rJ5y1qbIKLTzTMMLJliVTkcPBk74SWGerASN+ZN9wzCOnyTieZoZyGa/Imak3kNGiPqm/3DuiZOvC2na17HFEItpbf+67R0LoyWiHznPyFA9iExxDdHMKPyJ6lxjIZlZLg3imDkvvlEiAq1cDgqn/xZn5XqAyqTvOMhHaX/hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rz/KJf5q; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7f5e1c37-a637-494a-ab52-cad83095f2a6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706012307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+RO8ZCOEQWp5sHoJ0tZq1/hmNsM9aQ9KeKI5CJdul+0=;
	b=rz/KJf5qy/FCuopbgX4LHM1yr0wPGONIwaJw7xK+IKkJGAV9FHVKllK9KNUByeZWgbtyQC
	lYJNRcMSU8J2p2+21yWKKPA5Bxmqet8DA60QdXighTJJdBCoPsBzYxcMl3P65Srgizuqsx
	37d5DYun7fCiISbaJ8CsuAvJO0tzeHA=
Date: Tue, 23 Jan 2024 20:18:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 3/5] drm/bridge: simple-bridge: Allow acquiring the next
 bridge with fwnode API
Content-Language: en-US
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: David Airlie <airlied@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240122163220.110788-1-sui.jingfeng@linux.dev>
 <20240122163220.110788-4-sui.jingfeng@linux.dev>
 <20240123011859.GB22880@pendragon.ideasonboard.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <20240123011859.GB22880@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,


On 2024/1/23 09:18, Laurent Pinchart wrote:
> On Tue, Jan 23, 2024 at 12:32:18AM +0800, Sui Jingfeng wrote:
>> Which make it possible to use this driver on non-DT based systems,
>> meanwhile, made no functional changes for DT based systems.
>>
>> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
>> ---
>>   drivers/gpu/drm/bridge/simple-bridge.c | 51 ++++++++++++++++++++++----
>>   1 file changed, 44 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/simple-bridge.c b/drivers/gpu/drm/bridge/simple-bridge.c
>> index 595f672745b9..cfea5a67cc5b 100644
>> --- a/drivers/gpu/drm/bridge/simple-bridge.c
>> +++ b/drivers/gpu/drm/bridge/simple-bridge.c
>> @@ -184,6 +184,39 @@ static const void *simple_bridge_get_match_data(const struct device *dev)
>>   	return NULL;
>>   }
>>   
>> +static int simple_bridge_get_next_bridge_by_fwnode(struct device *dev,
>> +						   struct drm_bridge **next_bridge)
>> +{
>> +	struct drm_bridge *bridge;
>> +	struct fwnode_handle *ep;
>> +	struct fwnode_handle *remote;
>> +
>> +	ep = fwnode_graph_get_endpoint_by_id(dev->fwnode, 1, 0, 0);
>> +	if (!ep) {
>> +		dev_err(dev, "The endpoint is unconnected\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	remote = fwnode_graph_get_remote_port_parent(ep);
>> +	fwnode_handle_put(ep);
>> +	if (!remote) {
>> +		dev_err(dev, "No valid remote node\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	bridge = drm_bridge_find_by_fwnode(remote);
>> +	fwnode_handle_put(remote);
>> +
>> +	if (!bridge) {
>> +		dev_warn(dev, "Next bridge not found, deferring probe\n");
>> +		return -EPROBE_DEFER;
>> +	}
>> +
>> +	*next_bridge = bridge;
>> +
>> +	return 0;
>> +}
>> +
> Hmmmm yes, this convinces me further that we should switch to fwnode,
> not implement fwnode and OF side-by-side.
>

OK, I'm agree with you.


But this means that I have to make the drm_bridge_find_by_fwnode() function works
on both DT systems and non-DT systems. This is also means that we will no longer
need to call of_drm_find_bridge() function anymore. This will eventually lead to
completely remove of_drm_find_bridge()?


As far as I can see, if I follow you suggestion, drm/bridge subsystem will
encountering a *big* refactor. My 'side-by-side' approach allows co-exist.
It is not really meant to purge OF. I feel it is a little bit of aggressive.

hello Maxime, are you watching this? what do you think?


>>   static int simple_bridge_probe(struct platform_device *pdev)
>>   {
>>   	struct simple_bridge *sbridge;
>> @@ -199,14 +232,17 @@ static int simple_bridge_probe(struct platform_device *pdev)
>>   	else
>>   		sbridge->info = simple_bridge_get_match_data(&pdev->dev);
>>   
>> -	/* Get the next bridge in the pipeline. */
>> -	remote = of_graph_get_remote_node(pdev->dev.of_node, 1, -1);
>> -	if (!remote)
>> -		return -EINVAL;
>> -
>> -	sbridge->next_bridge = of_drm_find_bridge(remote);
>> -	of_node_put(remote);
>> +	if (pdev->dev.of_node) {
>> +		/* Get the next bridge in the pipeline. */
>> +		remote = of_graph_get_remote_node(pdev->dev.of_node, 1, -1);
>> +		if (!remote)
>> +			return -EINVAL;
>>   
>> +		sbridge->next_bridge = of_drm_find_bridge(remote);
>> +		of_node_put(remote);
>> +	} else {
>> +		simple_bridge_get_next_bridge_by_fwnode(&pdev->dev, &sbridge->next_bridge);
>> +	}
>>   	if (!sbridge->next_bridge) {
>>   		dev_dbg(&pdev->dev, "Next bridge not found, deferring probe\n");
>>   		return -EPROBE_DEFER;
>> @@ -231,6 +267,7 @@ static int simple_bridge_probe(struct platform_device *pdev)
>>   	/* Register the bridge. */
>>   	sbridge->bridge.funcs = &simple_bridge_bridge_funcs;
>>   	sbridge->bridge.of_node = pdev->dev.of_node;
>> +	sbridge->bridge.fwnode = pdev->dev.fwnode;
>>   	sbridge->bridge.timings = sbridge->info->timings;
>>   
>>   	drm_bridge_add(&sbridge->bridge);
>> -- 
>> 2.25.1
>>

