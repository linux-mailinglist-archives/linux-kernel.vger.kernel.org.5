Return-Path: <linux-kernel+bounces-104330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC5287CC3A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F39701F21849
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FB71B298;
	Fri, 15 Mar 2024 11:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MsfFOs2Z"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BA41B295
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 11:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710501843; cv=none; b=t2e8T6vPP4sG6OQxBppN5Hw6dl1oI5Ls8MvAFreHP8HNh53DrMlC6f8cKXv0jsGHGPyPvAupWHrOrbADrMkF64JzCw4XD+4JLbLlmY8dXHUc7fzDEeoCzq3YSEKmVhNDYhgIIIKfBIC5T+ix7616mZWv/M8+0dvn5BPZfHY0JQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710501843; c=relaxed/simple;
	bh=uABvPXOqq/Tla+Cl257JwPcyrRf1VhVmEZ2NakP1f7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=htzBpw63izXJVTInVM9XmllTpEd6GnQ3s1X72JjV9JKyxxK90+Jwvbs1cVCFqYV/vUM9tgaNad9YW14y/1rrlqOYrgMN9UgNn9RlGSnUxqb4alWYyokqhazZ3Mr9RX3eZ77PH+01SAQtk+Ow5shYLngZVGp+X71nlm0paGh8Krs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MsfFOs2Z; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710501840;
	bh=uABvPXOqq/Tla+Cl257JwPcyrRf1VhVmEZ2NakP1f7Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MsfFOs2ZYu+BQgQDviu0tZEHVVU8he4yCSLf2PFK5ZcEkAh9y/w+V0kUvefrTlE+i
	 BVQO+/8MmT/ZloAKZNC9kOl74Ju83Uk9kybn/K8qLVeA2yu8NI7/3IVTB1E14OMBGt
	 FefOx23cfRZ1N095xm64zGX3ddp6IBx6j1MSebmoYWc1SKYt1T6izxYd2QuVNrk3JV
	 Kblz3U7J4V9jPqFD9czrxC8wJkOP9ltogw5DLsG64OPzF/HEyM/qEWGUQyqB1Pgok/
	 N9iXEeK15XZ7mmQibOUFVX66F18q1/X6yQMV5orY/j9oz7xsdZM53cW2Rj3qXnfbLS
	 FWtHAJlrROiXg==
Received: from [100.66.96.193] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D1575378105A;
	Fri, 15 Mar 2024 11:23:56 +0000 (UTC)
Message-ID: <1cbe364d-465a-ccba-a446-5f98b9e0efc4@collabora.com>
Date: Fri, 15 Mar 2024 16:53:55 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 00/11] drm/ci: Add support for GPU and display testing
Content-Language: en-US
To: Helen Koike <helen.koike@collabora.com>, dri-devel@lists.freedesktop.org
Cc: daniels@collabora.com, airlied@gmail.com, daniel@ffwll.ch,
 emma@anholt.net, robdclark@gmail.com, david.heidelberg@collabora.com,
 guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com,
 hamohammed.sa@gmail.com, rodrigosiqueiramelo@gmail.com,
 melissa.srw@gmail.com, mairacanal@riseup.net, mcanal@igalia.com,
 linux-mediatek@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240306030649.60269-1-vignesh.raman@collabora.com>
 <5559672d-4f62-4ad1-95b7-94f69b8bb9ac@collabora.com>
From: Vignesh Raman <vignesh.raman@collabora.com>
In-Reply-To: <5559672d-4f62-4ad1-95b7-94f69b8bb9ac@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Helen,

On 07/03/24 19:32, Helen Koike wrote:
> 
> 
> On 06/03/2024 00:06, Vignesh Raman wrote:
>> Some ARM SOCs have a separate display controller and GPU, each with
>> different drivers. For mediatek mt8173, the GPU driver is powervr,
>> and the display driver is mediatek. In the case of mediatek mt8183,
>> the GPU driver is panfrost, and the display driver is mediatek.
>> With rockchip rk3288/rk3399, the GPU driver is panfrost, while the
>> display driver is rockchip. For amlogic meson, the GPU driver is
>> panfrost, and the display driver is meson.
>>
>> IGT tests run various tests with different xfails and can test both
>> GPU devices and KMS/display devices. Currently, in drm-ci for MediaTek,
>> Rockchip, and Amlogic Meson platforms, only the GPU driver is tested.
>> This leads to incomplete coverage since the display is never tested on
>> these platforms. This commit series adds support in drm-ci to run tests
>> for both GPU and display drivers for MediaTek, Rockchip, and Amlogic
>> Meson platforms.
>>
>> Uprev mesa and IGT in drm-ci and add amd, v3d, vc4 and vgem specific
>> tests to testlist. Have testlist.txt per driver and include a base
>> testlist so that the driver specific tests will run only on those 
>> hardware
>> and add testlists to the MAINTAINERS file.
>>
>> This series also includes patch to add vkms testing to drm-ci.
>>
>> Working pipeline link,
>> https://gitlab.freedesktop.org/vigneshraman/linux/-/pipelines/1119859
> 
> Hi Vignesh, thanks for this patchset.
> 
> Just to confirm, the new convention is:
> 
> stages are named per DRIVER_NAME

Yes correct.

> jobs are named DRIVER_NAME:GPU_VERSION

Yes

> xfails files and testlist files are named DRIVER_NAME-<xfails-suffix>.txt

Base testlist is named as testlist.txt
driver specific testlist is named as testlist-$DRIVER_NAME.txt

xfails files are named as $DRIVER_NAME-$GPU_VERSION-<xfails-suffix>.txt 
(mediatek-mt8183-fails.txt)

> 
> Looks good.
> 
> I just have some minor comments/questions in the series, please check.

Will address those and send v5.

Regards,
Vignesh


