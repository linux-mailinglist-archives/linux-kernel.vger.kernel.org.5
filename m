Return-Path: <linux-kernel+bounces-106351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04AFC87ECE3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9185E1F21B1E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D7C52F8C;
	Mon, 18 Mar 2024 15:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r3+T+c5s"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AB5374CB
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 15:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710777586; cv=none; b=CVSi2EEI9a239bBpKDJ/Jn4xLQ1LuXbqSIMSuicuh69TJIiDBhYQXolZKuGQaMooCx6Ip2LjhJkqVrfyvobB/oSPtW0dWYaReT57NSU6O2Ar5LwbJ+qN2y5H79HSzXwOcITvFVzyD6uMAq/EWY8OaMxR4EFhO3cJ4bUtu+5BZxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710777586; c=relaxed/simple;
	bh=nw/RrKP3PD936mgtSAFqxdTTI8Jq9UacWra4faXk7bE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dx1sKJQ9cxaJ04JQY65T7ILd3OMXkeZVjrXuu6GTAq2XnVkIKWODeTw56uRjJHNSpNuB884iKHHJTiv4sK2zaiv+z4z6Nuk4v8hfGUTZjxlb8O15BLUc/Jx49K/Kvo8c9HSWmsHefUU/FZUNwy1hM3K6bUrL3Qbo4gS9i1Fucm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r3+T+c5s; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <af4c9583-b9d1-4f4a-bd38-422701407105@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710777582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TE+tlz80EbRPnSuYvI664zzw4KWc4c4acmTHITxg5sM=;
	b=r3+T+c5sc1T32LvhHXsldOdpDORVxj+caQYTpWYkOlgUmuFTDtj/dONSWSLgoQrJPdri5o
	SMsARMg9Zg29bKpwFOsqJ2uObYhCxy7M2YnatDowt5kydNhxTNPtaHl8EVhjtosut75v+8
	L4Di9ki4pFIVOWSzm/9aFk10lwPkC+A=
Date: Mon, 18 Mar 2024 23:59:29 +0800
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
 <22229306-aa72-4367-b029-fbdff4410cec@linux.dev>
 <20240318155726.GE13682@pendragon.ideasonboard.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <20240318155726.GE13682@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,


On 2024/3/18 23:57, Laurent Pinchart wrote:
> On Mon, Mar 18, 2024 at 11:53:11PM +0800, Sui Jingfeng wrote:
>> On 2024/3/18 23:33, Laurent Pinchart wrote:
>>> On Sun, Mar 17, 2024 at 01:28:00AM +0800, Sui Jingfeng wrote:
>>>> To reduce boilerplate, use of_graph_get_remote_node() helper instead of
>>>> the hand-rolling code.
>>>>
>>>> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
>>>> ---
>>>>    drivers/gpu/drm/bridge/thc63lvd1024.c | 24 +++---------------------
>>>>    1 file changed, 3 insertions(+), 21 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/bridge/thc63lvd1024.c b/drivers/gpu/drm/bridge/thc63lvd1024.c
>>>> index d4c1a601bbb5..5f99f9724081 100644
>>>> --- a/drivers/gpu/drm/bridge/thc63lvd1024.c
>>>> +++ b/drivers/gpu/drm/bridge/thc63lvd1024.c
>>>> @@ -123,28 +123,10 @@ static int thc63_parse_dt(struct thc63_dev *thc63)
>>>>    	struct device_node *endpoint;
>>>>    	struct device_node *remote;
>>>>    
>>>> -	endpoint = of_graph_get_endpoint_by_regs(thc63->dev->of_node,
>>>> -						 THC63_RGB_OUT0, -1);
>>>> -	if (!endpoint) {
>>>> -		dev_err(thc63->dev, "Missing endpoint in port@%u\n",
>>>> -			THC63_RGB_OUT0);
>>>> -		return -ENODEV;
>>>> -	}
>>>> -
>>>> -	remote = of_graph_get_remote_port_parent(endpoint);
>>>> -	of_node_put(endpoint);
>>>> -	if (!remote) {
>>>> -		dev_err(thc63->dev, "Endpoint in port@%u unconnected\n",
>>>> -			THC63_RGB_OUT0);
>>>> +	remote = of_graph_get_remote_node(thc63->dev->of_node,
>>>> +					  THC63_RGB_OUT0, -1);
>>>> +	if (!remote)
>>> The old logic is equivalent to of_graph_get_remote_node(), but now the
>>> driver will fail probing without an error message. That's not very nice
>>> as it leads to difficult to debug problems. I would keep one dev_err()
>>> here:
>>>
>>> 		dev_err(thc63->dev, "No remote endpoint for port@%u\n",
>>> 			THC63_RGB_OUT0);
>>>
>>> As your patch has been merged already, would you like to post a
>>> follow-up patch to fix this ?
>> Yes, this is indeed a difference. I will post a follow-up patch to fix this.
> I'm actually build-testing a patch I already wrote :-) I'll post it in a
> moment.


OK, then.


>>>>    		return -ENODEV;
>>>> -	}
>>>> -
>>>> -	if (!of_device_is_available(remote)) {
>>>> -		dev_err(thc63->dev, "port@%u remote endpoint is disabled\n",
>>>> -			THC63_RGB_OUT0);
>>>> -		of_node_put(remote);
>>>> -		return -ENODEV;
>>>> -	}
>>>>    
>>>>    	thc63->next = of_drm_find_bridge(remote);
>>>>    	of_node_put(remote);

-- 
Best regards,
Sui


