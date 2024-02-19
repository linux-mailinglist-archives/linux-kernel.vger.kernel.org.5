Return-Path: <linux-kernel+bounces-71047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97917859FDC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20310B220FA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E925F2377B;
	Mon, 19 Feb 2024 09:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="N25pmdsX"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924A422EE8
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 09:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708335583; cv=none; b=m0jNE48U4xCqPqRwlkXbhYCq92F17wmv/rXm7F85EYNZGuPCmjogzKox6qAnCWk2UceOC8Tq5rvHh5JgOwQ0CgGBojg9Uq5JKlU0IU23z5Kc8ehg/8a3hLLv5/bE4FjTYYi3sKheYHkDEcD4DcO0gEIL2TixNWVpA0rvtCTkiWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708335583; c=relaxed/simple;
	bh=eNBh5JpwUZ0+jl/Gio0qtOi4bqHTZ3A6braWYxV+N2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YAfZh4qiPbSqBk1VLFpKIpTcoZDAJhTE0qYHmvpYAmipvqxVGlATzB4W0HcLFHEjkMrybPAP0JHez/oQ1Y9fdNNMzK8J4hoVQWXd+MdKFkFrm/tiQJ5oYBUkw/3sROEqiqFLINRdtsbQPS2ml+sAzIMyZNzvibAo4unwzPPleFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=N25pmdsX; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708335579;
	bh=eNBh5JpwUZ0+jl/Gio0qtOi4bqHTZ3A6braWYxV+N2M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=N25pmdsXyywrOwI3pBlJJ9qyR2MkR8q6uB3CEdJxb22cjIEUTV3I/LsBj3+n52fsm
	 WJa1Zu7W/6w5Te2yZ3oDPsbgi6qLCuTVN6VlHN1voEp/+JOHxvd24ZA5UJyDDzsnv6
	 Wks3OSsVQItOebQ4HMoHnZUYw5dc36UsfbVewRU3xARO/xgW9NCApWwKJm49xOA5zR
	 71dN1CQjT9BRyCT+MT91hf0zmuyhOjEIliWrHS16NyE2XBJ6cwDskUyh2PtMDO7qKL
	 Xzl7p77dQahXD+X8d6BCOXdMaspzjqrOobTHhhXIZ1cjfuWWngoCf7vzSeaIH1SyOV
	 hwwazeNZPOWJQ==
Received: from [100.66.96.193] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2572237801C1;
	Mon, 19 Feb 2024 09:39:32 +0000 (UTC)
Message-ID: <2083520a-13f3-0ecd-45ce-ee4ba34d5bca@collabora.com>
Date: Mon, 19 Feb 2024 15:09:30 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 3/9] drm/ci: mediatek: Add job to test panfrost and
 powervr GPU driver
Content-Language: en-US
To: Helen Koike <helen.koike@collabora.com>, dri-devel@lists.freedesktop.org
Cc: daniel@fooishbar.org, airlied@gmail.com, daniel@ffwll.ch,
 david.heidelberg@collabora.com, guilherme.gallo@collabora.com,
 sergi.blanch.torne@collabora.com, robdclark@gmail.com,
 linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-amlogic@lists.infradead.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240130150340.687871-1-vignesh.raman@collabora.com>
 <20240130150340.687871-4-vignesh.raman@collabora.com>
 <61575073-ce37-4027-8f95-f05290cc10c4@collabora.com>
From: Vignesh Raman <vignesh.raman@collabora.com>
In-Reply-To: <61575073-ce37-4027-8f95-f05290cc10c4@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Helen,

On 09/02/24 23:51, Helen Koike wrote:
> 
> 
> On 30/01/2024 12:03, Vignesh Raman wrote:
>> For mediatek mt8173, the GPU driver is powervr and for mediatek
>> mt8183, the GPU driver is panfrost. So add support in drm-ci to
>> test panfrost and powervr GPU driver for mediatek SOCs and update
>> xfails. Powervr driver was merged in linux kernel, but there's no
>> mediatek support yet. So disable the mt8173-gpu job which uses
>> powervr driver.
>>
>> Add panfrost specific tests to testlist and skip KMS tests for
>> panfrost driver since it is not a not a KMS driver. Also update
>> the MAINTAINERS file to include xfails for panfrost driver.
>>
>> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> 
> Hi Vignesh, thanks for your work.
> 
> I'm still wondering about a few things, please check below.
> 
>> ---
>>
>> v2:
>>    - Add panfrost and PVR GPU jobs for mediatek SOC with new xfails, 
>> add xfail
>>      entry to MAINTAINERS.
> 
> Maybe we should review how the xfails failes are named. I think they 
> should start with the DRIVER_NAME instead of GPU_VERSION.
> 
> For instance, consider the following job:
> 
> mediatek:mt8183-gpu:
>    extends:
>      - .mt8183
>    variables:
>      GPU_VERSION: mediatek-mt8183-gpu
>      DRIVER_NAME: panfrost
> 
> And we have mediatek-mt8183-gpu-skips.txt
> 
> If there is an error, we want to notify the panfrost driver maintainers 
> (and maybe not the mediatek driver maintainers), so MAINTAINERS file 
> doesn't correspond to this.

Agree.

> 
> How about a naming <driver name>_<hardware/gpu>_<type: gpu/display> ?
> 
> powervr_mediatek-mt8173_gpu-skipts.txt
> mediatek_mediatek-mt8173_display-skipts.txt
> panfrost_mediatek-mt8183_gpu-skips.txt
> mediatek_mediatek-mt8183_display-skips.txt
> ...
> 
> What do you think?

Yes we can keep this naming. In this case do we still need gpu/display 
in the xfails file name?

Regards,
Vignesh

