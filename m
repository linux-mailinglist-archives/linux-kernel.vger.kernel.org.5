Return-Path: <linux-kernel+bounces-28871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F07D830401
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 751ED1C23F88
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468771CFB9;
	Wed, 17 Jan 2024 10:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="tMgwAN0X"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0542E1C688
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 10:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705489106; cv=none; b=a+n/66jI/1b3QsS4ELLYYfbu7lwp4Mi+bHwcaR3K/3PvO4deMJmkRaTP1lLtvIhSM6acOV5GBICS7kESRaFGpsDSIzY89XXfvR9zvHfyeWtfi3NOlVvlYEwM64TJwZ6TUAsVe48PhTaIzQ52dHPBmK0E9mmT8gOMI+yid9LsUqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705489106; c=relaxed/simple;
	bh=/7lI1B2ezdJpZing7eGVqikWQmFS6qFYXxnwlupy290=;
	h=DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding; b=kPLJAlPMI7DT9Jq0HZHim9TABOBTgZMG2Heom4vLOUfRH+n2Ydcmp5extjSAQrV5/o4UF3FTGU2bER4lwTsS3hTK76DiPoDVFLJDrzpHizNLaPCT9dt4mK8jROIoygFmO0/43cA4Vx/Mo3g+GpljAE3rBZrTmwLOJzVr9/U7Hm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=tMgwAN0X; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705489103;
	bh=/7lI1B2ezdJpZing7eGVqikWQmFS6qFYXxnwlupy290=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=tMgwAN0XVR4clizkCEDnib7CoFsCa0hRMJsErRaVWDzYjzOc+/kEVeArCbv4OAkss
	 rpyyvEjyWbQ5q58V+e3HDrUPMAEkws77pSqguHFBDQveJf1dSibyrnCo59m3br4vcf
	 7beOB9K/TZmZ/TC9vg3/ObJJLIC7uujE4Rg9LGOz3TUcDF3zfm+iUq19+MqwxEBdWZ
	 oLAqi4Z4U/tKm4Mfnny72PK7fsdzOhqzZlFxfGG0FH/ORgLOAdcz3xYiWkwut99mwI
	 sxf+GwNw8OwGDAXsh5Sua/04RN8TS6Ojh7Ezb8MgD6GO1Td9kkHR/CPk7C21yRtRC0
	 94/E4NOFiPHJg==
Received: from [100.66.96.193] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4285F3782021;
	Wed, 17 Jan 2024 10:58:17 +0000 (UTC)
Message-ID: <7f123e16-54d7-e25e-63ae-cf6efc31d136@collabora.com>
Date: Wed, 17 Jan 2024 16:28:15 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 0/8] drm/ci: Add support for GPU and display testing
To: Daniel Stone <daniel@fooishbar.org>,
 Helen Koike <helen.koike@collabora.com>, Dave Airlie <airlied@gmail.com>,
 Sima Vetter <daniel@ffwll.ch>, Daniel Stone <daniels@collabora.com>,
 Emma Anholt <emma@anholt.net>,
 linux-rockchip <linux-rockchip@lists.infradead.org>,
 guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 David Heidelberg <david.heidelberg@collabora.com>,
 Rob Clark <robdclark@gmail.com>, linux-mediatek@lists.infradead.org,
 linux-amlogic@lists.infradead.org
References: <20231220121110.1441160-1-vignesh.raman@collabora.com>
 <CAPj87rOMPioOK0r74vcnVkXusm6Nah6KNUWyxYgpVLdkMNtW2g@mail.gmail.com>
 <ad7cbd59-5264-96e8-5e9b-aafde8028e41@collabora.com>
 <CAPj87rPRRfJmxTev50YqxBizyvzCUhCiymoV_bdqsZ-zvcREfA@mail.gmail.com>
Content-Language: en-US
From: Vignesh Raman <vignesh.raman@collabora.com>
In-Reply-To: <CAPj87rPRRfJmxTev50YqxBizyvzCUhCiymoV_bdqsZ-zvcREfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Daniel,

On 11/01/24 23:41, Daniel Stone wrote:
> Hi Vignesh,
> 
> On Wed, 10 Jan 2024 at 10:47, Vignesh Raman <vignesh.raman@collabora.com> wrote:
>> On 09/01/24 19:08, Daniel Stone wrote:
>>> A better sequencing would be something like:
>>>     1. add ANX7625 config
>>>     2. refactor _existing_ MTK display jobs to use YAML includes, change
>>> the existing job name, and rename the existing xfail set, remove
>>> IGT_FORCE_DRIVER from the script since it's now set by the job
>>>     3. add MTK Panfrost+PVR GPU jobs with new xfails, add xfail entry to
>>> MAINTAINERS
>>>     4+5: same as 2+3 but for Amlogic
>>>     6+7: same as 2+3 but for Rockchip
>>>
>>> Then the separate rename/update xfail commits just disappear, as does
>>> the removal of IGT_FORCE_DRIVER, because it's just done incrementally
>>> as part of the commits which change the related functionality. It's
>>> extremely important that every change can work standalone, instead of
>>> introducing intermediate breakage which is only fixed in later commits
>>> in the series.
>>
>> Thank you for reviewing the patches. I agree, will follow this sequence
>> and send a v2 version.
> 
> Alongside Rob's patch to add msm-specific tests to the runlist, we'd
> need to add the Panfrost-specific tests. Whilst we're here, we might
> as well add the vc4/v3d/etnaviv/lima tests so they can use it in
> future.
> 
> Panfrost should also skip kms_.* tests - since it's not a KMS driver,
> it can't run the KMS tests, so there's no point in trying.

I will add these tests and update skips file. Sorry missed this before 
sending v2. I'm rechecking the xfails for the v2 series and will send
v3 with these changes. Thanks.

Regards,
Vignesh

