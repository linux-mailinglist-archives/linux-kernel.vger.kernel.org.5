Return-Path: <linux-kernel+bounces-92121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA57C871B5F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 180471C2209E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889F85C057;
	Tue,  5 Mar 2024 10:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YPw2pNpI"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49085537E6
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 10:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709634102; cv=none; b=T5bQBglVsEAoyx93y4Kjt4AeUgqQG89wbVHJa52xcaf/ZG+mNjmP/NCUC9xBIWwf80Dub76xsKmwBKnfL+6J86qArqP/7hv0Fnmd+mcxVNKPgcdN5CUeAiBmuqjd7TZjtPIQEJ6PZgI7iebJrrn35KtYqOKf1/ACU69u6VTQxwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709634102; c=relaxed/simple;
	bh=nzGENR6qPVPcbYLF4x3N7tmWM6ERhotNjmvi/Zt/WQg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Q4NAqNspQnWcW/K7EPBfHNBe8GBLdpEKKrz6Q8LRa21Y4+Hf/YcL5eTcQR0DZTXZo1Q3K7fDRHhWP5VLCH1osVmOhN6z7K9bJWGrgYVmXqTxy0LSv0WoJHH8mk0cFtQIpFpYY6AOezFZPtOGSqrCjO02S2nB5xJ/8ZhaxS4/Cpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YPw2pNpI; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709634099;
	bh=nzGENR6qPVPcbYLF4x3N7tmWM6ERhotNjmvi/Zt/WQg=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=YPw2pNpIepIbB+3vJ5Z06Bdl1TptFLGJ0VsudVqJCHg30R8rbAT2F7jBIBmivp4I7
	 NFLJYQx1ERVW7s5/j0U+U5wFD3SpGmRg+Gi1fJp+5qk9BupBIhjL7tjIVAKf2x4peI
	 iqibceRInpRuLJEI8axpebcBrb8uxlaa91cWY5vUmzwZNm8cFOdUU/fN+cAUBlYZyb
	 CZIj/EliXPM6ACSl8vKwxR5qDMlZI/ESdkGimn+bcXRW0L9MOCacsCPe67nnq+Tk4P
	 tgnOx0mkgTNFgXtZyALuNGIhZThWaXb5pekq3aEcqSHmZFwj6wQnqr7a5zrA5BuO0D
	 857ea9Cb3r7DA==
Received: from [100.66.96.193] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A204E3781FEF;
	Tue,  5 Mar 2024 10:21:36 +0000 (UTC)
Message-ID: <dbaf7eee-9a54-18f4-cdd2-c782581261e8@collabora.com>
Date: Tue, 5 Mar 2024 15:51:29 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/ci: update device type for volteer devices
From: Vignesh Raman <vignesh.raman@collabora.com>
To: dri-devel@lists.freedesktop.org
Cc: daniels@collabora.com, helen.koike@collabora.com, airlied@gmail.com,
 daniel@ffwll.ch, david.heidelberg@collabora.com,
 sergi.blanch.torne@collabora.com, guilherme.gallo@collabora.com,
 robdclark@gmail.com, jani.nikula@linux.intel.com,
 joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
 tvrtko.ursulin@linux.intel.com, intel-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240305101626.36357-1-vignesh.raman@collabora.com>
Content-Language: en-US
In-Reply-To: <20240305101626.36357-1-vignesh.raman@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Below is the pipeline with the job passing,
https://gitlab.freedesktop.org/vigneshraman/linux/-/pipelines/1119672

Regards,
Vignesh

On 05/03/24 15:46, Vignesh Raman wrote:
> Volteer devices in the collabora lab are categorized under the
> asus-cx9400-volteer device type. The majority of these units
> has an Intel Core i5-1130G7 CPU, while some of them have a
> Intel Core i7-1160G7 CPU instead. So due to this difference,
> new device type template is added for the Intel Core i5-1130G7
> and i7-1160G7 variants of the Acer Chromebook Spin 514 (CP514-2H)
> volteer Chromebooks. So update the same in drm-ci.
> 
> https://gitlab.collabora.com/lava/lava/-/merge_requests/149
> 
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> ---
>   drivers/gpu/drm/ci/test.yml | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
> index 0857773e5c5f..8bc63912fddb 100644
> --- a/drivers/gpu/drm/ci/test.yml
> +++ b/drivers/gpu/drm/ci/test.yml
> @@ -252,11 +252,11 @@ i915:cml:
>   i915:tgl:
>     extends:
>       - .i915
> -  parallel: 8
> +  parallel: 5
>     variables:
> -    DEVICE_TYPE: asus-cx9400-volteer
> +    DEVICE_TYPE: acer-cp514-2h-1130g7-volteer
>       GPU_VERSION: tgl
> -    RUNNER_TAG: mesa-ci-x86-64-lava-asus-cx9400-volteer
> +    RUNNER_TAG: mesa-ci-x86-64-lava-acer-cp514-2h-1130g7-volteer
>   
>   .amdgpu:
>     extends:

