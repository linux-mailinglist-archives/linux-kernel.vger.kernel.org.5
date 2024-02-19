Return-Path: <linux-kernel+bounces-71351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1EC85A3D9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47939B22457
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226882E832;
	Mon, 19 Feb 2024 12:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QSMVtvfs"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D262E84F
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 12:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708347168; cv=none; b=XbiBizdvuxvOU9LN5m0W9xK+yOTZUTGuhOQDUop9iyfxWxkQnkH94J4ltKk4Man4ERpf/9eOmFu1dVIUlLVk8gIohVT6z1yclpemgz92SuZBlrWkcPdzYSEL3EQ6DdohSL/w8mZgOCg8aBqDHyrrkn885eLk8bI1gMwBBOTG4V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708347168; c=relaxed/simple;
	bh=RlJFnwC8vtKaCRSiqNBP6fs/G9L9iiOg4PIBPGdT9RU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SMCdpVA95d7KyLi39YVAcNXITEUlJsiSeBkBZDNefCBzpKyMexfSekTba7grsEottRSqhS6sLggvppDnM0+GaJeKwz9P/PWQZ/qVo9RdJrSkAc2TrtH0ZZLCoIl5DauqASe7rYHNyFcnfFpt2+0zC3JirVTtRXgDI07FEWuX1d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QSMVtvfs; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708347164;
	bh=RlJFnwC8vtKaCRSiqNBP6fs/G9L9iiOg4PIBPGdT9RU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QSMVtvfseBUsWHd8wUrB3Ibay4Sz6yDaBFlcdwRfZDu7OZb7dzMN2z0D228h83b6D
	 PpHL+rGH/nqw5fLvRNk0jDlXSVOeD+27wus48q7YrBG5qxc76/KkCQDljqy1MsDZOg
	 micgwVxeWwS1qrGtK/yRCjih5BWeqUr+rSoZhV0Z2LWmIXEhYqyR5UdWrHsBHxQ3hk
	 3f8yGFskfV80sMOw1Ns3IAE1L+6rlsI+WFiFTnx1pnW2UyOPiW5fC1axJ0Sh5/7tR5
	 dup+DkxrWG2e7wJVyBV3261jSKXDSlqC5EGojjeSlnX1DpYtub6lbmZX5ichLsNbwC
	 RYVQj6nkYBqZA==
Received: from [100.95.196.25] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: koike)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9F4A437820C1;
	Mon, 19 Feb 2024 12:52:40 +0000 (UTC)
Message-ID: <e69a275c-4415-4f0c-bae4-af8112357ef6@collabora.com>
Date: Mon, 19 Feb 2024 09:52:37 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/9] drm/ci: mediatek: Add job to test panfrost and
 powervr GPU driver
Content-Language: en-US
To: Vignesh Raman <vignesh.raman@collabora.com>,
 dri-devel@lists.freedesktop.org
Cc: daniel@fooishbar.org, airlied@gmail.com, daniel@ffwll.ch,
 david.heidelberg@collabora.com, guilherme.gallo@collabora.com,
 sergi.blanch.torne@collabora.com, robdclark@gmail.com,
 linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-amlogic@lists.infradead.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240130150340.687871-1-vignesh.raman@collabora.com>
 <20240130150340.687871-4-vignesh.raman@collabora.com>
 <61575073-ce37-4027-8f95-f05290cc10c4@collabora.com>
 <2083520a-13f3-0ecd-45ce-ee4ba34d5bca@collabora.com>
From: Helen Koike <helen.koike@collabora.com>
In-Reply-To: <2083520a-13f3-0ecd-45ce-ee4ba34d5bca@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 19/02/2024 06:39, Vignesh Raman wrote:
> Hi Helen,
> 
> On 09/02/24 23:51, Helen Koike wrote:
>>
>>
>> On 30/01/2024 12:03, Vignesh Raman wrote:
>>> For mediatek mt8173, the GPU driver is powervr and for mediatek
>>> mt8183, the GPU driver is panfrost. So add support in drm-ci to
>>> test panfrost and powervr GPU driver for mediatek SOCs and update
>>> xfails. Powervr driver was merged in linux kernel, but there's no
>>> mediatek support yet. So disable the mt8173-gpu job which uses
>>> powervr driver.
>>>
>>> Add panfrost specific tests to testlist and skip KMS tests for
>>> panfrost driver since it is not a not a KMS driver. Also update
>>> the MAINTAINERS file to include xfails for panfrost driver.
>>>
>>> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
>>
>> Hi Vignesh, thanks for your work.
>>
>> I'm still wondering about a few things, please check below.
>>
>>> ---
>>>
>>> v2:
>>>    - Add panfrost and PVR GPU jobs for mediatek SOC with new xfails, 
>>> add xfail
>>>      entry to MAINTAINERS.
>>
>> Maybe we should review how the xfails failes are named. I think they 
>> should start with the DRIVER_NAME instead of GPU_VERSION.
>>
>> For instance, consider the following job:
>>
>> mediatek:mt8183-gpu:
>>    extends:
>>      - .mt8183
>>    variables:
>>      GPU_VERSION: mediatek-mt8183-gpu
>>      DRIVER_NAME: panfrost
>>
>> And we have mediatek-mt8183-gpu-skips.txt
>>
>> If there is an error, we want to notify the panfrost driver 
>> maintainers (and maybe not the mediatek driver maintainers), so 
>> MAINTAINERS file doesn't correspond to this.
> 
> Agree.
> 
>>
>> How about a naming <driver name>_<hardware/gpu>_<type: gpu/display> ?
>>
>> powervr_mediatek-mt8173_gpu-skipts.txt
>> mediatek_mediatek-mt8173_display-skipts.txt
>> panfrost_mediatek-mt8183_gpu-skips.txt
>> mediatek_mediatek-mt8183_display-skips.txt
>> ...
>>
>> What do you think?
> 
> Yes we can keep this naming. In this case do we still need gpu/display 
> in the xfails file name?

If you think this split is not required, then I'm fine dropping it.

Regards,
Helen

> 
> Regards,
> Vignesh

