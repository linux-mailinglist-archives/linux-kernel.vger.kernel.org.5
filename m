Return-Path: <linux-kernel+bounces-104377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9125687CD01
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 13:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C282E1C2199B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEDB1C280;
	Fri, 15 Mar 2024 12:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="myQxTOcD"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5C7635
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 12:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710504131; cv=none; b=jPg8rr+jO1tup+HAFb0EpiaC/81ROrYiFs+/1qOA2hqoW5paMSVMegp8r0f5aYsXbxZ848MeaJbr7MP5/dpnLMkX/teJFYLzMgpvLhlJltiAQcS1+/QG8pFEU9PAHas1Me0lhTOQ/ag1tXqtIvFOyt8l7CxAeBsDRkXK56JPfbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710504131; c=relaxed/simple;
	bh=OtLFV54AJAjMDblqkVAwHk31mrIpvs9hCe+qbqa6st0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bDpvCQCas4xGQ1zM2INcl9zRdkNN1RAoNbRyd/E0+jw77IRxE3zhHMKKfSoulgdCfQEueKz7/C8P0ugVP16Rex1AdjLe+zDcNTqOjJp2cU+OWTIRWzkm6BeT2IStZCJ8LLEAe2jtoBnVwsWvzTDNw3ENpOfHOfIs7O7D2mNE86E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=myQxTOcD; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710504128;
	bh=OtLFV54AJAjMDblqkVAwHk31mrIpvs9hCe+qbqa6st0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=myQxTOcD/FfQvyq0VJdG+KHbNtlK3TN0MTbM8M44bMsJlsgbinPJEXz/jCWDRL1PU
	 focHWdjD9QDjGIRpQlNqFI4k/lVmGIBS+tRV5APngLHW82Pm9fhgbQMS2tOD6AE1pP
	 seN2B4/Cjq8eBc1W+Tc2pyNrC1APKfg6fyc2T7DYFkszdbQ9ljIFzQ3HWz3nzkRRe+
	 Oujf/PSTY0GzSDFXArl60Jk6NGqWm0KxhzG/aZ+Rv6ZEj8OaSu2ygJGpHgTqH17nBr
	 qSsf9upQs/hcuTx8BR7SDwnR4Q0A1Wsq9pjKB2euYnAayAr4ueIxmQFsK0pnLm8XEa
	 YbQtABFGH5NQQ==
Received: from [100.95.196.25] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: koike)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D34E2378105A;
	Fri, 15 Mar 2024 12:02:02 +0000 (UTC)
Message-ID: <aba60de7-63a2-4009-bdfd-4d86cec464be@collabora.com>
Date: Fri, 15 Mar 2024 09:02:02 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/11] drm/ci: rockchip: Refactor existing rockchip
 jobs
Content-Language: en-US
To: Vignesh Raman <vignesh.raman@collabora.com>,
 dri-devel@lists.freedesktop.org
Cc: daniels@collabora.com, airlied@gmail.com, daniel@ffwll.ch,
 emma@anholt.net, robdclark@gmail.com, david.heidelberg@collabora.com,
 guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com,
 hamohammed.sa@gmail.com, rodrigosiqueiramelo@gmail.com,
 melissa.srw@gmail.com, mairacanal@riseup.net, mcanal@igalia.com,
 linux-mediatek@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240306030649.60269-1-vignesh.raman@collabora.com>
 <20240306030649.60269-10-vignesh.raman@collabora.com>
 <098d2345-df99-4ad2-bc1c-9641662ed9bd@collabora.com>
 <f53c716d-6d11-13f6-0ecf-ec02f4debcfa@collabora.com>
From: Helen Koike <helen.koike@collabora.com>
In-Reply-To: <f53c716d-6d11-13f6-0ecf-ec02f4debcfa@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 15/03/2024 08:18, Vignesh Raman wrote:
> Hi Helen,
> 
> On 07/03/24 19:32, Helen Koike wrote:
>>
>>
>> On 06/03/2024 00:06, Vignesh Raman wrote:
>>> For rockchip rk3288 and rk3399, the display driver is rockchip.
>>> Currently, in drm-ci for rockchip, only the display driver is
>>> tested. Refactor the existing rockchip jobs so that gpu driver
>>> testing jobs can be added later and update xfails accordingly.
>>>
>>> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
>>> ---
>>>
>>> v2:
>>>    - Refactor the patch to rename job to indicate display driver 
>>> testing,
>>>      rename the existing xfail files.
>>>
>>> v3:
>>>    - Add the job name in GPU_VERSION and use it for xfail file names
>>>      instead of using DRIVER_NAME. Also update xfails.
>>>
>>> v4:
>>>    - Remove the display suffix in job and rename xfails accordingly.
>>>      Remove the change adding job name in GPU_VERSION.
>>>
>>> ---
>>>   drivers/gpu/drm/ci/test.yml                   | 36 ++++++++----
>>>   .../drm/ci/xfails/rockchip-rk3288-fails.txt   | 58 ++++++-------------
>>>   .../drm/ci/xfails/rockchip-rk3288-flakes.txt  | 20 +++++++
>>>   .../drm/ci/xfails/rockchip-rk3288-skips.txt   | 54 ++---------------
>>>   .../drm/ci/xfails/rockchip-rk3399-fails.txt   | 38 ++++++------
>>>   .../drm/ci/xfails/rockchip-rk3399-flakes.txt  | 28 +++++++--
>>>   .../drm/ci/xfails/rockchip-rk3399-skips.txt   |  5 +-
>>>   7 files changed, 110 insertions(+), 129 deletions(-)
>>>   create mode 100644 
>>> drivers/gpu/drm/ci/xfails/rockchip-rk3288-flakes.txt
>>>
>>> diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
>>> index 6ae6398b3d88..831e580e6dfd 100644
>>> --- a/drivers/gpu/drm/ci/test.yml
>>> +++ b/drivers/gpu/drm/ci/test.yml
>>> @@ -153,33 +153,45 @@ msm:sdm845:
>>>     script:
>>>       - ./install/bare-metal/cros-servo.sh
>>> -rockchip:rk3288:
>>> -  extends:
>>> -    - .lava-igt:arm32
>>> +.rockchip:
>>>     stage: rockchip
>>>     variables:
>>> -    DRIVER_NAME: rockchip
>>
>> Looks like it make sense to keep DRIVER_NAME here, no?
>>
>>> -    DEVICE_TYPE: rk3288-veyron-jaq
>>>       DTB: ${DEVICE_TYPE}
>>>       BOOT_METHOD: depthcharge
>>> +
>>> +.rk3288:
>>> +  extends:
>>> +    - .lava-igt:arm32
>>> +    - .rockchip
>>
>> Maybe, instead of extending .rockchip here, make .rockchip tied to the 
>> DRIVER_NAME and .rk3288 tied to the GPU_VERSION, and on 
>> rockchip:rk3288 you can extend both .rockchip and .rk3288, what do you 
>> think?
>> So rockchip:rk3399 you can extend .rockchip and .rk3399.
>>
>> and in the panfrost one you can have a .panfrost (that can extend 
>> .rockchip if they are the same definition).
>>
>> I feel it becomes less confusing, what do you think?
>>
>> I would even add some prefix or suffix to make it less confusing, like 
>> .driver-rockchip and .gpu-rk3288 for instance, making it a bit more 
>> intuitive and helping our future selves :)
> 
> Thanks for the suggestion. This can be done. Should we do it only
> for rockchip jobs or others also (meson, mediatek) ?

I guess we could keep the same patter for all the make sense.

Helen

> 
>>
>>> +  variables:
>>> +    DEVICE_TYPE: rk3288-veyron-jaq
>>>       KERNEL_IMAGE_TYPE: "zimage"
>>> -    GPU_VERSION: rk3288
>>
>> Looks like it make sense to keep GPU_VERSION here, no? Same comment 
>> for .rk3399.
> Yes, will fix this.
> 
> Regards,
> Vignesh

