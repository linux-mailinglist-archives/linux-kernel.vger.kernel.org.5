Return-Path: <linux-kernel+bounces-95587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E34874FD8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5E40B23C91
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F38412C52D;
	Thu,  7 Mar 2024 13:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="EpJtF5QZ"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CA812B169
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 13:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709817698; cv=none; b=FOhxsMRZcV6TViLWPCuUlRE+Hx0wi87fT3+3wgc9GieUYQPz81gPQszTqQp+59OO1OGzSXawGgU3dlI2+kn1W0zbw2NL5TZ+v9/1qAV+7vbYadVcAE4sF0FHNFuYGWPwbvJz2KlKvUGhfZixhgYEbpYF8uF3aW1M2+pLFPIJy64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709817698; c=relaxed/simple;
	bh=aGenckXGkrmLwEafuy5dZPtP7xfD+h/1iwwhHPnePH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hbkKmsNMI6mrG5nPBaKZnlSIoMzQo5O2AOPoubK8T/zkYUt63idFvS8HSreEGzaR6m7PySzuAbTSukfR7skWMAbkpdqO/XfHm2XMlh1QgMQ6f0bD+MT6mn5M1bLbzX2+RZuM9jN5aPEk/QSs4a6rTqbkYxwAcvYriSGGSfkQrXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=EpJtF5QZ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709817695;
	bh=aGenckXGkrmLwEafuy5dZPtP7xfD+h/1iwwhHPnePH4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EpJtF5QZFsd8vbZLtmFfgtRzkemMIYvCzLDRjJ9XAoAxJ9FeX9aTBKtG5bvOnfOYd
	 +a+lSfyq2wdERSUAyA4Lfjmy6KPOMJsqdCD2Puri4cGGgQsECN0rcEmjQ9XkwOpvEk
	 Nhc0syu31FVtQOlaSNQOMxaQo2tuXD8CX01FlaUfsZjmwM5LACErlTaX95v6fRyNje
	 V1z6LoIRcJVd7omI0gXXhs8PZbTB4FuRo6mC5P0jmHbfgqNpESsa+NtOJyWRMjKh8P
	 XLBAqR1bAnIWgEfQvZPMvHkm7GBabmnsfxmLC4FhlzMxCEic0eG6YeL45P/aU305VX
	 Fsoy5dzKKALdg==
Received: from [100.95.196.25] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: koike)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5AE2C3780B5F;
	Thu,  7 Mar 2024 13:21:30 +0000 (UTC)
Message-ID: <a8ae3ca9-67d5-4d83-90e8-2777862473d7@collabora.com>
Date: Thu, 7 Mar 2024 10:21:27 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/ci: update device type for volteer devices
Content-Language: en-US
To: Vignesh Raman <vignesh.raman@collabora.com>,
 dri-devel@lists.freedesktop.org
Cc: daniels@collabora.com, airlied@gmail.com, daniel@ffwll.ch,
 david.heidelberg@collabora.com, sergi.blanch.torne@collabora.com,
 guilherme.gallo@collabora.com, robdclark@gmail.com,
 jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
 rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
 intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240307021841.100561-1-vignesh.raman@collabora.com>
From: Helen Koike <helen.koike@collabora.com>
In-Reply-To: <20240307021841.100561-1-vignesh.raman@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 06/03/2024 23:18, Vignesh Raman wrote:
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
> Fixes: 0119c894ab0d ("drm: Add initial ci/ subdirectory")
> Reviewed-by: David Heidelberg <david.heidelberg@collabora.com>
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>

Acked-by: Helen Koike <helen.koike@collabora.com>

Thanks
Helen

> ---
> 
> v2:
>    - Add fixes tag so change gets propagated to stable.
>      https://gitlab.freedesktop.org/vigneshraman/linux/-/pipelines/1119672
> 
> v3:
>    - Fix checkpatch warning.
>      Please use correct Fixes: style 'Fixes: <12 chars of sha1> ("<title line>")'
> 
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

