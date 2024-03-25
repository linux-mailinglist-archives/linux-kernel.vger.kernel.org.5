Return-Path: <linux-kernel+bounces-117087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA0888ABCD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4634BA48FB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8FD131747;
	Mon, 25 Mar 2024 13:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dV8t9WSv"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2B284D1B
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 13:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711372072; cv=none; b=GfGlMXcTfk0Bu17MHyzeQbimCQbJWWlDQ1Z89gFqVf5TZ7e0GJWuoKDbYp5TAeRjE6CoTvr2Y30wHyvyK2m3E8j2aYKSPEFu5EcBqEF13SyFZ11cZCYfNfQBEGjLc/DuruR2yHYlpyyWNjnPrlqgZNKvigrWjalBRhqGC53BRHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711372072; c=relaxed/simple;
	bh=U9O7+ZqD+2fD0l3G8D/pX/GvM4FGztjDRut/f5Cvyc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nSHcty2i/6nUfT0VklaQBM0rds3pa5scY0A2dZ/ru1XFajHp0/OPtC32qy5d1IX9Gec31vNxi0Ck427ZT8eXtX5A5OwoImPip9z2ZlgQkpzAasltNtZFX7LabAWMQ/4kTHTuXP8n5vRr6tUi63mwnOBs9+kO0/tbgll1T8vLFTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dV8t9WSv; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711372069;
	bh=U9O7+ZqD+2fD0l3G8D/pX/GvM4FGztjDRut/f5Cvyc4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dV8t9WSvWBKo1C1B67HZ5sd3Mg8kjoo9GpROBXVRYajSE/Vf9bFjeHtvRgaq3PHeR
	 yV19mZbZrSkJx1/IHJ9Zs2AGcGICB9m8rCUWEUIDTgtWlkvHP39/fhGR8FqP+L9kFa
	 WGH/kSUgAtq8Wt0Cd33tAk41LMDc2+dkiM1A+uGTwWmH6TgUViOIHAlCu2VIuA/Ifo
	 WLrU+5hKJgcRjrPScruHtX9PSnVn1tCRpVRoNvErpmWc8Gng6MKoL4/QhmTFafKRGs
	 etf6+9u4VWYxv7ITxn6mXbh2gUYp6wzAnPl1WtaUyOsLF/SQCGCCpHv6auFDgIk0eM
	 XDnBdXTuNz7TA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D6451378209A;
	Mon, 25 Mar 2024 13:07:48 +0000 (UTC)
Message-ID: <8f815a5c-e891-468f-8e8a-1ad9cee7a36f@collabora.com>
Date: Mon, 25 Mar 2024 14:07:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panfrost: fix power transition timeout warnings
To: Christian Hewitt <christianshewitt@gmail.com>,
 Steven Price <steven.price@arm.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>
References: <20240322164525.2617508-1-christianshewitt@gmail.com>
 <bad16bba-5469-4f20-bf23-7f3c2953edc5@arm.com>
 <620A6EF4-4361-4B5F-889B-268091FB72D9@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <620A6EF4-4361-4B5F-889B-268091FB72D9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 25/03/24 12:36, Christian Hewitt ha scritto:
>> On 25 Mar 2024, at 2:28 pm, Steven Price <steven.price@arm.com> wrote:
>>
>> On 22/03/2024 16:45, Christian Hewitt wrote:
>>> Increase the timeout value to prevent system logs on Amlogic boards flooding
>>> with power transition warnings:
>>>
>>> [   13.047638] panfrost ffe40000.gpu: shader power transition timeout
>>> [   13.048674] panfrost ffe40000.gpu: l2 power transition timeout
>>> [   13.937324] panfrost ffe40000.gpu: shader power transition timeout
>>> [   13.938351] panfrost ffe40000.gpu: l2 power transition timeout
>>> ...
>>> [39829.506904] panfrost ffe40000.gpu: shader power transition timeout
>>> [39829.507938] panfrost ffe40000.gpu: l2 power transition timeout
>>> [39949.508369] panfrost ffe40000.gpu: shader power transition timeout
>>> [39949.509405] panfrost ffe40000.gpu: l2 power transition timeout
>>>
>>> The 2000 value has been found through trial and error testing with devices
>>> using G52 and G31 GPUs.
>>
>> How close to 2ms did you need in your trial and error testing? I'm
>> wondering if we should increase it further in case this might still
>> trigger occasionally?
> 
> I backed it off progressively but still saw occasional messages at 1.6ms
> so padded it a little with 2ms, and those systems haven’t shown errors
> since so I currently see it as a ’safe’ value. The one possible wildcard
> is testing with older T820/T628 boards; but that needs to wait until I’m
> back home from a long trip and able to test them. The possible theory
> being that older/slower systems might require more time. Worst case I’ll
> have to send another change.
> 
>> kbase seems to have a 5s (5000ms!) timeout before it will actually
>> complain. But equally it doesn't busy wait on the registers in the same
>> way as panfrost, so the impact to the rest of the system of a long wait
>> is less.
>>
>> But 2ms doesn't sound an unreasonable timeout so:
>>
>> Reviewed-by: Steven Price <steven.price@arm.com>
>>
>>> Fixes: 22aa1a209018 ("drm/panfrost: Really power off GPU cores in panfrost_gpu_power_off()")
>>> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>> ---
>>> drivers/gpu/drm/panfrost/panfrost_gpu.c | 6 +++---
>>> 1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.c b/drivers/gpu/drm/panfrost/panfrost_gpu.c
>>> index 9063ce254642..fd8e44992184 100644
>>> --- a/drivers/gpu/drm/panfrost/panfrost_gpu.c
>>> +++ b/drivers/gpu/drm/panfrost/panfrost_gpu.c
>>> @@ -441,19 +441,19 @@ void panfrost_gpu_power_off(struct panfrost_device *pfdev)
>>>
>>> gpu_write(pfdev, SHADER_PWROFF_LO, pfdev->features.shader_present);
>>> ret = readl_relaxed_poll_timeout(pfdev->iomem + SHADER_PWRTRANS_LO,
>>> -  val, !val, 1, 1000);
>>> +  val, !val, 1, 2000);
>>> if (ret)
>>> dev_err(pfdev->dev, "shader power transition timeout");
>>>
>>> gpu_write(pfdev, TILER_PWROFF_LO, pfdev->features.tiler_present);
>>> ret = readl_relaxed_poll_timeout(pfdev->iomem + TILER_PWRTRANS_LO,
>>> -  val, !val, 1, 1000);
>>> +  val, !val, 1, 2000);
>>> if (ret)
>>> dev_err(pfdev->dev, "tiler power transition timeout");
>>
>> As Angelo points out the tiler probably doesn't need such a long
>> timeout, but I can't see the harm in consistency so I'm happy with this
>> change. If my memory of the hardware is correct then the tiler power off
>> actually does very little and so I wouldn't expect it to take very long.
> 
> I’ve seen tiler timeouts once I think and thus included it, but not since
> the values were increased. As long as it’s acceptable I won’t over-think
> it but if more testing is needed I can look at it more.
> 

Thanks for clarifying.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


