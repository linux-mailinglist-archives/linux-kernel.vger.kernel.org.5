Return-Path: <linux-kernel+bounces-154889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 408A58AE289
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5B421F2136D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31FE6311D;
	Tue, 23 Apr 2024 10:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Of692+7M"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A353018645
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 10:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713869094; cv=none; b=Pi2z+jFb9uTnXeKQQRuYB7IeNeYs/hApfPkNwJdcqn1GwYQQJzHK0Rq4t0yCTv45mk0cjGUffiQo1P74cIP+gg7h1FJpGH7nXBRp6SMe3gGwPimJFCUayK5lcSMNUoIY5Zj9Cvn7alEgsptrr3cN4mw/uoGM9rCY4+beXVtZhKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713869094; c=relaxed/simple;
	bh=Epn0gV+Gzq6v5eisv+70hPPOCD6XUu7r1FmGbG5g33w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JhgVmk/9mWpUe3SpF0BpuCbImHXelyKbhK8sXjuFXlnJ0HyTRgE22ohrlb1ZnYdimVwlzFU0N68PzEQMToETefcdmXzghf5ATqgZdbneqYgxVrFEvlUEJbD5W99u85T9DF7vKOtVjMDKomcThWWK3MvGNr+pd/NEZUzNaRTM/7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Of692+7M; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <648e60f1-780a-428c-93b3-89d9804d6686@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713869090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ztCEKPNLsAhDNa+3tby/q1A4DTNLcwwQxYAdaRONIA=;
	b=Of692+7MYKXBtw91S+Zo6Acvkq4slm+qJ2Baenc1LkWUHctmkwg6iBOsGdWOvR1nmxv3aJ
	4zVAZtdd2+TnO4VqsifAHydhdYtvT2mSxfayCfgxHW7ZhWP3ogbTJyI+iP2kREJUUIRaPM
	YqlEip/h4vuFooFYWchjwYKb3pM/Du0=
Date: Tue, 23 Apr 2024 18:44:40 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 9/9] drm/bridge: tfp410: Add platform module alias
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Phong LE <ple@baylibre.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240422191903.255642-1-sui.jingfeng@linux.dev>
 <20240422191903.255642-10-sui.jingfeng@linux.dev>
 <050ff49d-516c-41fc-a205-4c259384058f@kernel.org>
 <08e81099-77d6-4d6d-9e7b-b086c17818c9@linux.dev>
 <e41e7916-14aa-4128-9ef1-42736ad9a581@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <e41e7916-14aa-4128-9ef1-42736ad9a581@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 2024/4/23 18:20, Krzysztof Kozlowski wrote:
> On 23/04/2024 12:12, Sui Jingfeng wrote:
>> Hi,
>>
>> On 2024/4/23 16:05, Krzysztof Kozlowski wrote:
>>> On 22/04/2024 21:19, Sui Jingfeng wrote:
>>>> Otherwise when compiled as module, this driver will not be probed on
>>>> non-DT environment. This is a fundamential step to make this driver
>>>> truely OF-independent.
>>> NAK.
>>
>> :( ...
>>
>>
>>> You should not need MODULE_ALIAS() in normal cases. If you need it,
>>> usually it means your device ID table is wrong (e.g. misses either
>>> entries or MODULE_DEVICE_TABLE()). MODULE_ALIAS() is not a substitute
>>> for incomplete ID table.
>>
>> I think I could give you a reason.
>>
>> 1) When compile this driver into linux kernel
>>
>> This driver will be probed if we create a platform device manually with the name "tfp410".
> Then do not create devices manually. This is not y2000 to use board files.


Not exactly, creating devices manually can be modern and fancy approach.
Complex driver need to create devices manually to paper over the issue(-EPROBE_DEFER)
raised with cross drivers subsystem design. Or for the purpose of better modularization.
See etnaviv, vkms, efifb, aux-bridge, aux-bus, ect.

OK, I know what you means here.

>> This is also true for the display-connector driver(drivers/gpu/drm/bridge/display-connector.c),
>> see patch 0005 of this series  and the simple-bridge driver(drivers/gpu/drm/bridge/simple-bridge.c)
>> see patch 0003 of this series.
> They have the same problem.
>
>> 2) But when compile this driver as module, creating a platform device manually with the same name
>> *won't* make those platform driver probed. I think, this is *inconsistent behavior*. Therefore, I
>> add MODULE_ALIAS() to keep the behavior consistent. That is, a driver, should be able to be probed
>> regardless it is compile as a kernel module or it is built into the kernel.
>>
> That's obvious. Please focus on the actual issue here.
>
>>> Just check your aliases and look what is there. You already have
>>> i2c:tfp410 alias.
>> Right, but the i2c:tfp410 alias only guarantee the driver can be probed successfully
>> when tfp410 working as I2C slave. tfp410 can also works as a transparent bridge.
> So which bus or driver instantiates the device? What use case is this?
>
>>
>>>    If you need platform one, for some reason, explain
>>> what is your matching path and add appropriate ID table. With that
>>> explanation, of course.
>> When tfp410 works as a transparent bridge. The device itself is just a platform device.
>> similar with the display-connector.c and simple-bridge.c.
>>
>> It is not discoverable by the system on non-DT environment, this is the root problem.
>> I said the various display bridges drivers are fully DT dependent, Dimtry didn't agree!
>>
>> He said "I can not agree here. It doesn't depend on DT." and then asks me to developing
>> some other solution witch could preserve code sharing. So here it is.
>
> You wrote long message without actually reading my answer early. I
> already gave you the solution. Address that one.

Use MODULE_DEVICE_TABLE() instead? OK, I understand then. Thanks a lot 
for the education.


> Best regards,
> Krzysztof
>
-- 
Best regards,
Sui


