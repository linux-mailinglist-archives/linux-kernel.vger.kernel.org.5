Return-Path: <linux-kernel+bounces-154844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FB18AE1DE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A842282754
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714B1605CE;
	Tue, 23 Apr 2024 10:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gx0IoUlb"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F5C57870
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 10:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713867155; cv=none; b=cUUpBSk9Y3Pd75EC8QoYRR5/EGPCys+o3sewiP5qELGr+576qPYEBe/VTpY8PCPfO7HjNE5gUhbNm/RAOgOvL+sB9oz8nB6rSJbN5N0GlGzTUWQly5RStz/sfcTQlwVj4gCRNdXWm9lPn5pmG3FtcJaNCytol/TekqIKoIKD2H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713867155; c=relaxed/simple;
	bh=rsC+CW7beNIQJk05RFqS9UOKPY52kYYhT3NixSpJRV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eNbqZ2M7MrUeZZAYSitJh0vGGAKM0k/ipo4hMG/tPXA1jJduUbzwPAER64FjMozH206M/2yfK8GMM3TXBAXb4+YEnAxD9+xtAPhtOjKx9e1LaofcMAtzEZTcLSJrcuCcofOCc+lStr5a0lFCR+wgkQj48ENJGQ3okJKMoKTf7TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gx0IoUlb; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <08e81099-77d6-4d6d-9e7b-b086c17818c9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713867150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HN/p+WditlGUuZClm6toX5fexU+Fy5ogSGpPxKBmU9M=;
	b=gx0IoUlbU8vUCPYm8K5V7+vjnSMaNPiilzGxlQunoD/Ee9c8Dwf8P87iURnWP9xAgoMKjo
	9Pmwr3lt50OBvadfVJtfIiDOfgeH4oeHZyblQhSOIgpe0kFCgCpFxghCGGW2UtjgDZSrpR
	MeR51uo3vnGo98R0LG1IfWrJPUEjjCA=
Date: Tue, 23 Apr 2024 18:12:20 +0800
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
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <050ff49d-516c-41fc-a205-4c259384058f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,

On 2024/4/23 16:05, Krzysztof Kozlowski wrote:
> On 22/04/2024 21:19, Sui Jingfeng wrote:
>> Otherwise when compiled as module, this driver will not be probed on
>> non-DT environment. This is a fundamential step to make this driver
>> truely OF-independent.
> NAK.


:( ...


>
> You should not need MODULE_ALIAS() in normal cases. If you need it,
> usually it means your device ID table is wrong (e.g. misses either
> entries or MODULE_DEVICE_TABLE()). MODULE_ALIAS() is not a substitute
> for incomplete ID table.


I think I could give you a reason.

1) When compile this driver into linux kernel

This driver will be probed if we create a platform device manually with the name "tfp410".
This is also true for the display-connector driver(drivers/gpu/drm/bridge/display-connector.c),
see patch 0005 of this series  and the simple-bridge driver(drivers/gpu/drm/bridge/simple-bridge.c)
see patch 0003 of this series.

2) But when compile this driver as module, creating a platform device manually with the same name
*won't* make those platform driver probed. I think, this is *inconsistent behavior*. Therefore, I
add MODULE_ALIAS() to keep the behavior consistent. That is, a driver, should be able to be probed
regardless it is compile as a kernel module or it is built into the kernel.


> Just check your aliases and look what is there. You already have
> i2c:tfp410 alias.

Right, but the i2c:tfp410 alias only guarantee the driver can be probed successfully
when tfp410 working as I2C slave. tfp410 can also works as a transparent bridge.


>   If you need platform one, for some reason, explain
> what is your matching path and add appropriate ID table. With that
> explanation, of course.

When tfp410 works as a transparent bridge. The device itself is just a platform device.
similar with the display-connector.c and simple-bridge.c.

It is not discoverable by the system on non-DT environment, this is the root problem.
I said the various display bridges drivers are fully DT dependent, Dimtry didn't agree!

He said "I can not agree here. It doesn't depend on DT." and then asks me to developing
some other solution witch could preserve code sharing. So here it is.


> Best regards,
> Krzysztof
>
-- 
Best regards,
Sui


