Return-Path: <linux-kernel+bounces-127451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 000E9894B8F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 08:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A850328120F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 06:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CDF2BCF6;
	Tue,  2 Apr 2024 06:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="txDJvUuo"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CAD2B9BD
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 06:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712039927; cv=none; b=M1CkWIIMEaDxXArZZFTvX0wYnRvBwBDOVyyT/e7sj5W2rhVYpego04NnoBK/QwFMmwvbSo2e9lUFy14ThGsFW5wu7OI8irShQSqwfgT9ZzzZsJs1wwck2fasn59wYtm246VmO1GslYdWfS8jq3wtU53z0EDClT1OezC/RV4N+Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712039927; c=relaxed/simple;
	bh=qJ2dEukUQYHmEsmyw7ZbHI+ur/eWAO9V0o+2VTjVyKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mzNeBfvqYnT4YCYsDd+1wJD+dFdLNo2j6QWXQ6kd+cAolKuzm3jPN+/WoqHr2+DPtgpC0x9plINgRaMs3geOFg+7WyP+xLlMTm9xHfzZzEWiRMlUfpDHvyEDrqiwwXVqsztrcZzdAElDjFe8yCmHWYmv5B78dxb8F5gSumYfSXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=txDJvUuo; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712039917;
	bh=qJ2dEukUQYHmEsmyw7ZbHI+ur/eWAO9V0o+2VTjVyKc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=txDJvUuo77oktz3jmtd4lM0A60gu44Qfn+EdrSsVl2vZAMFCKl38AIQ1VOQlhmv/E
	 tFRlfqiGYTZE57dpvnEpyDHFxaMq0ZRRuC4TG4rpMAbtwBY3ztzCR8BdyyL3zpEyyy
	 lnxJ3Gsr2XSmpOgUnKTceku5iUpbG5pdWn2pTeEysWe/Io8SMnjdlXfvsEEDCG4lyA
	 P0L4HpM59sWUDQDYHoRYeA4Da/SqPgkfTkHqNHD4jXBi9NQHSG3bpruiljKcHk1V3j
	 V7DlJi1wO5HnLdXlfbG5fpNtxMOpK/im+J7NvCG0QzU9ypIsiqjClQwV6xaKMhwnOT
	 cyiR2dBIIlQwQ==
Received: from [100.66.96.193] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6E60837803EE;
	Tue,  2 Apr 2024 06:38:33 +0000 (UTC)
Message-ID: <d21abe07-074b-4158-a544-d2f50d0bdeac@collabora.com>
Date: Tue, 2 Apr 2024 12:08:31 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/10] drm/ci: rockchip: Add job to test panfrost GPU
 driver
Content-Language: en-US
To: Helen Koike <helen.koike@collabora.com>, dri-devel@lists.freedesktop.org
Cc: daniels@collabora.com, airlied@gmail.com, daniel@ffwll.ch,
 emma@anholt.net, robdclark@gmail.com, david.heidelberg@collabora.com,
 guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com,
 hamohammed.sa@gmail.com, rodrigosiqueiramelo@gmail.com,
 melissa.srw@gmail.com, mairacanal@riseup.net, mcanal@igalia.com,
 linux-mediatek@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240401061235.192713-1-vignesh.raman@collabora.com>
 <20240401061235.192713-10-vignesh.raman@collabora.com>
 <17c5f479-8d25-411a-816f-506320359ab5@collabora.com>
From: Vignesh Raman <vignesh.raman@collabora.com>
In-Reply-To: <17c5f479-8d25-411a-816f-506320359ab5@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Helen,

On 01/04/24 22:13, Helen Koike wrote:
> 
> 
> On 01/04/2024 03:12, Vignesh Raman wrote:
>> For rockchip rk3288 and rk3399, the GPU driver is panfrost.
>> So add support in drm-ci to test panfrost driver for rockchip
>> SOC and update xfails. Skip KMS tests for panfrost driver
>> since it is not a not a KMS driver and skip driver-specific tests.
>>
>> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> 
> Btw, just a nit, I would squash this with the previous commit, so we 
> don't have a point in history with panfrost tests, than without them, 
> than with them again. But with or without this change:
> 
> Acked-by: Helen Koike <helen.koike@collabora.com>

Maybe I will move the skipping kms tests and other driver specific tests 
  to the previous commit.

Regards,
Vignesh

> 
> Thanks
> Helen
> 
>> ---
>>
>> v2:
>>    - Add panfrost GPU jobs for rockchip SOC with new xfails.
>>
>> v3:
>>    - Skip KMS tests for panfrost driver since it is not a not
>>      a KMS driver and update xfails. Add the job name in GPU_VERSION
>>      and use it for xfail file names instead of using DRIVER_NAME.
>>
>> v4:
>>    - Remove the gpu suffix in job and rename xfails accordingly.
>>
>> v5:
>>    - Skip driver-specific tests.
>>
>> ---
>>   drivers/gpu/drm/ci/test.yml                         | 10 ++++++++++
>>   drivers/gpu/drm/ci/xfails/panfrost-rk3288-fails.txt |  1 +
>>   drivers/gpu/drm/ci/xfails/panfrost-rk3288-skips.txt |  8 ++++++++
>>   drivers/gpu/drm/ci/xfails/panfrost-rk3399-fails.txt |  1 +
>>   drivers/gpu/drm/ci/xfails/panfrost-rk3399-skips.txt |  8 ++++++++
>>   5 files changed, 28 insertions(+)
>>   create mode 100644 drivers/gpu/drm/ci/xfails/panfrost-rk3288-fails.txt
>>   create mode 100644 drivers/gpu/drm/ci/xfails/panfrost-rk3288-skips.txt
>>   create mode 100644 drivers/gpu/drm/ci/xfails/panfrost-rk3399-fails.txt
>>   create mode 100644 drivers/gpu/drm/ci/xfails/panfrost-rk3399-skips.txt
>>
>> diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
>> index 96b299c32c07..8c90ae5a51e6 100644
>> --- a/drivers/gpu/drm/ci/test.yml
>> +++ b/drivers/gpu/drm/ci/test.yml
>> @@ -191,11 +191,21 @@ rockchip:rk3288:
>>       - .rk3288
>>       - .rockchip-display
>> +panfrost:rk3288:
>> +  extends:
>> +    - .rk3288
>> +    - .panfrost-gpu
>> +
>>   rockchip:rk3399:
>>     extends:
>>       - .rk3399
>>       - .rockchip-display
>> +panfrost:rk3399:
>> +  extends:
>> +    - .rk3399
>> +    - .panfrost-gpu
>> +
>>   .i915:
>>     extends:
>>       - .lava-igt:x86_64
>> diff --git a/drivers/gpu/drm/ci/xfails/panfrost-rk3288-fails.txt 
>> b/drivers/gpu/drm/ci/xfails/panfrost-rk3288-fails.txt
>> new file mode 100644
>> index 000000000000..abd35a8ef6f4
>> --- /dev/null
>> +++ b/drivers/gpu/drm/ci/xfails/panfrost-rk3288-fails.txt
>> @@ -0,0 +1 @@
>> +panfrost_prime@gem-prime-import,Crash
>> diff --git a/drivers/gpu/drm/ci/xfails/panfrost-rk3288-skips.txt 
>> b/drivers/gpu/drm/ci/xfails/panfrost-rk3288-skips.txt
>> new file mode 100644
>> index 000000000000..41a846a59644
>> --- /dev/null
>> +++ b/drivers/gpu/drm/ci/xfails/panfrost-rk3288-skips.txt
>> @@ -0,0 +1,8 @@
>> +# Panfrost is not a KMS driver, so skip the KMS tests
>> +kms_.*
>> +
>> +# Skip driver specific tests
>> +msm_.*
>> +^amdgpu.*
>> +v3d_.*
>> +vc4_.*
>> diff --git a/drivers/gpu/drm/ci/xfails/panfrost-rk3399-fails.txt 
>> b/drivers/gpu/drm/ci/xfails/panfrost-rk3399-fails.txt
>> new file mode 100644
>> index 000000000000..6f5e760d5ec0
>> --- /dev/null
>> +++ b/drivers/gpu/drm/ci/xfails/panfrost-rk3399-fails.txt
>> @@ -0,0 +1 @@
>> +panfrost_prime@gem-prime-import,Fail
>> diff --git a/drivers/gpu/drm/ci/xfails/panfrost-rk3399-skips.txt 
>> b/drivers/gpu/drm/ci/xfails/panfrost-rk3399-skips.txt
>> new file mode 100644
>> index 000000000000..41a846a59644
>> --- /dev/null
>> +++ b/drivers/gpu/drm/ci/xfails/panfrost-rk3399-skips.txt
>> @@ -0,0 +1,8 @@
>> +# Panfrost is not a KMS driver, so skip the KMS tests
>> +kms_.*
>> +
>> +# Skip driver specific tests
>> +msm_.*
>> +^amdgpu.*
>> +v3d_.*
>> +vc4_.*

