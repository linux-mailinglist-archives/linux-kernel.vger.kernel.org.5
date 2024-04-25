Return-Path: <linux-kernel+bounces-158647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C278B236A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8B27B28A5B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA44B149DF6;
	Thu, 25 Apr 2024 14:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="4frgaUKc"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F9C5B201;
	Thu, 25 Apr 2024 14:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714053714; cv=none; b=dD1OAEPKv8aXZ18NYnHuucOzTcH1aV3IWs9Y7JH1xvYu9blRmSTnjXjNa1XztEApk/GQdCXzKidYZGlCMAqdz3PXIUxd4oE5uzT6zAFXl7/V7YioHNKrVNN8BPUc2Pw++Woaiet2kgLDEI1bqCsrwVJ+r/6cCn76RasgKq5PGrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714053714; c=relaxed/simple;
	bh=bTEo1oCkBfk7Xcu5w34Wr/A5wA3MyotrDp/CRfdJjXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dNs+WgXRND+8ifiWcjKUQK8pEhvHWUpHqnDCYwia81zwcfJgeX10HENgUbGHmTnGnK76wreL6pghSU0xj1PeQoqu/PV1WI+0ps/wfbgPgFV4E/qzG7SX0pEPeZA8FMgP3QrnJAf4G5vGUSvuXYxhGUUXFa49BaYLgl4bwt7TPls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=4frgaUKc; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1714053705;
	bh=bTEo1oCkBfk7Xcu5w34Wr/A5wA3MyotrDp/CRfdJjXQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=4frgaUKcwMyzUIVVe207PbMSjp/UPnr4wAkZsotbfk2MivpbAJbQDtrQKUXInTVcQ
	 mlQkFxLZ22dJkwyes3xfd8Js3HK2j6w6Y0fztZAWdJU212a/ccSTsjxJ74Xf/106sL
	 6V7LfOsn1m0/dfj7fU8nQj346/L7QiHPSiy3YzTj6Biw/WpNJiDoSIeDTX2w1b4676
	 DYyMhoKKKC2x0Is6P1JOme8u6VRSDPzsckvhQTSwQeun4EovRLY+NnOy5ZA0uFvw5h
	 7630VaJ8LMu/stpSmRftyufsuUiiZAk/V3LAgosS/EkcOf/0u4tbuDJN0l4TfYN1tI
	 tRYMdcFaNUxIQ==
Received: from [100.95.196.25] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: koike)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D490A3782153;
	Thu, 25 Apr 2024 14:01:40 +0000 (UTC)
Message-ID: <96624d87-2198-4176-9b98-208595380132@collabora.com>
Date: Thu, 25 Apr 2024 11:01:38 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm: ci: fix the xfails for apq8016
To: Abhinav Kumar <quic_abhinavk@quicinc.com>, Rob Clark
 <robdclark@gmail.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240401204859.24223-1-quic_abhinavk@quicinc.com>
 <357b6395-5fae-38c9-8b53-5edc9fcbae32@quicinc.com>
Content-Language: en-US
From: Helen Koike <helen.koike@collabora.com>
In-Reply-To: <357b6395-5fae-38c9-8b53-5edc9fcbae32@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 08/04/2024 14:04, Abhinav Kumar wrote:
> Hi Helen
> 
> Gentle reminder on this.
> 
> If you are okay, we can land it via msm-next tree...
> 
> Thanks
> 
> Abhinav
> 
> On 4/1/2024 1:48 PM, Abhinav Kumar wrote:
>> After IGT migrating to dynamic sub-tests, the pipe prefixes
>> in the expected fails list are incorrect. Lets drop those
>> to accurately match the expected fails.
>>
>> In addition, update the xfails list to match the current passing
>> list. This should have ideally failed in the CI run because some
>> tests were marked as fail even though they passed but due to the
>> mismatch in test names, the matching didn't correctly work and was
>> resulting in those failures not being seen.
>>
>> Here is the passing pipeline for apq8016 with this change:
>>
>> https://gitlab.freedesktop.org/drm/msm/-/jobs/57050562
>>
>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

I'm sorry about my delay.

Acked-by: Helen Koike <helen.koike@collabora.com>

I'm also merging it to msm-misc-next.

Regards,
Helen

>> ---
>>   drivers/gpu/drm/ci/xfails/msm-apq8016-fails.txt | 13 +------------
>>   1 file changed, 1 insertion(+), 12 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/ci/xfails/msm-apq8016-fails.txt 
>> b/drivers/gpu/drm/ci/xfails/msm-apq8016-fails.txt
>> index 44a5c62dedad..b14d4e884971 100644
>> --- a/drivers/gpu/drm/ci/xfails/msm-apq8016-fails.txt
>> +++ b/drivers/gpu/drm/ci/xfails/msm-apq8016-fails.txt
>> @@ -1,17 +1,6 @@
>>   kms_3d,Fail
>>   kms_addfb_basic@addfb25-bad-modifier,Fail
>> -kms_cursor_legacy@all-pipes-forked-bo,Fail
>> -kms_cursor_legacy@all-pipes-forked-move,Fail
>> -kms_cursor_legacy@all-pipes-single-bo,Fail
>> -kms_cursor_legacy@all-pipes-single-move,Fail
>> -kms_cursor_legacy@all-pipes-torture-bo,Fail
>> -kms_cursor_legacy@all-pipes-torture-move,Fail
>> -kms_cursor_legacy@pipe-A-forked-bo,Fail
>> -kms_cursor_legacy@pipe-A-forked-move,Fail
>> -kms_cursor_legacy@pipe-A-single-bo,Fail
>> -kms_cursor_legacy@pipe-A-single-move,Fail
>> -kms_cursor_legacy@pipe-A-torture-bo,Fail
>> -kms_cursor_legacy@pipe-A-torture-move,Fail
>> +kms_cursor_legacy@torture-bo,Fail
>>   kms_force_connector_basic@force-edid,Fail
>>   kms_hdmi_inject@inject-4k,Fail
>>   kms_selftest@drm_format,Timeout

