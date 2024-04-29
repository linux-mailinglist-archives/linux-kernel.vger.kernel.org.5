Return-Path: <linux-kernel+bounces-162999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6668B632E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 22:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BA1B1F22C8C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 20:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29181411D3;
	Mon, 29 Apr 2024 20:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FKzwzN+i"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8543A81728;
	Mon, 29 Apr 2024 20:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714421204; cv=none; b=P2zkBjQ41kuZ2knIxABEJ9Xdb5UP1fsiw9E5tECXXCTALEJGt/aEX/s+KcmcdJ8U7/XC0aMZRM5K67/u+2n2eyY0/vkWUaTHLr+Hakru4bViJm3in39VPipOzjjR3L/Jeuday4ZoULqJGxn+zIbGXiaBPJ1Pf2Dez5BprZyXgj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714421204; c=relaxed/simple;
	bh=tFT2yxWeXBJU5cFia5YX4Z1prR+PxGxwFNPbkm3rVJ8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=AwfW3vlZH6H14QsLOdsLpJFN+HUvfUGD2EqXOCLL/2RLuxqXcazwx5OB45tBqrURMXcCG7Id5ZAUujjdInFPEwD0CCVEK4ES1nII65hVauAArIt5/GNZvcxycNXOUcGa7iqCDUcVA+h/nTZ+10hHXU74zqLFZmCEdtAjAU8wqJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FKzwzN+i; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1714421194;
	bh=tFT2yxWeXBJU5cFia5YX4Z1prR+PxGxwFNPbkm3rVJ8=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=FKzwzN+it+I4VqojDdJXAcXiG1GpC8kJ+1Kwez5/vMlFgTCltzzFZJ1g/988c0bLy
	 OxxZ3Pqz7+Fv9yRMPVHIn6nYGOSV7YdsI4IZDLGyZpd9dv6b4skQKud7kbeq9BR6GF
	 i0aPsxMvDRrv0pWfCQAeQImqPWuOgDr51tJK5QQ+KObFFhUnKD5Apn9hx7wIjwBTsJ
	 6xw54+KZMixIrnhvnpJcx7jKCN/VOsifPFZPQHfXX7caw+xi2qozTAY/8w8QpYagJS
	 Uvrc3QLWb0tp/vZzSagTre1rp2P1SloojezY0jfFaH3wbIq0ugB00018+Zub7CDxF7
	 dw8Z9jwS3dAeQ==
Received: from [100.95.196.25] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: koike)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 30C9837821B3;
	Mon, 29 Apr 2024 20:06:30 +0000 (UTC)
Message-ID: <4ce2b55b-f2b7-4b40-a644-6ef4d89007dd@collabora.com>
Date: Mon, 29 Apr 2024 17:06:28 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm: ci: fix the xfails for apq8016
From: Helen Koike <helen.koike@collabora.com>
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
 <96624d87-2198-4176-9b98-208595380132@collabora.com>
Content-Language: en-US
In-Reply-To: <96624d87-2198-4176-9b98-208595380132@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 25/04/2024 11:01, Helen Koike wrote:
> 
> 
> On 08/04/2024 14:04, Abhinav Kumar wrote:
>> Hi Helen
>>
>> Gentle reminder on this.
>>
>> If you are okay, we can land it via msm-next tree...
>>
>> Thanks
>>
>> Abhinav
>>
>> On 4/1/2024 1:48 PM, Abhinav Kumar wrote:
>>> After IGT migrating to dynamic sub-tests, the pipe prefixes
>>> in the expected fails list are incorrect. Lets drop those
>>> to accurately match the expected fails.
>>>
>>> In addition, update the xfails list to match the current passing
>>> list. This should have ideally failed in the CI run because some
>>> tests were marked as fail even though they passed but due to the
>>> mismatch in test names, the matching didn't correctly work and was
>>> resulting in those failures not being seen.
>>>
>>> Here is the passing pipeline for apq8016 with this change:
>>>
>>> https://gitlab.freedesktop.org/drm/msm/-/jobs/57050562
>>>
>>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> I'm sorry about my delay.
> 
> Acked-by: Helen Koike <helen.koike@collabora.com>
> 
> I'm also merging it to msm-misc-next.

Applied, thanks.

Helen

> 
> Regards,
> Helen
> 
>>> ---
>>>   drivers/gpu/drm/ci/xfails/msm-apq8016-fails.txt | 13 +------------
>>>   1 file changed, 1 insertion(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/ci/xfails/msm-apq8016-fails.txt 
>>> b/drivers/gpu/drm/ci/xfails/msm-apq8016-fails.txt
>>> index 44a5c62dedad..b14d4e884971 100644
>>> --- a/drivers/gpu/drm/ci/xfails/msm-apq8016-fails.txt
>>> +++ b/drivers/gpu/drm/ci/xfails/msm-apq8016-fails.txt
>>> @@ -1,17 +1,6 @@
>>>   kms_3d,Fail
>>>   kms_addfb_basic@addfb25-bad-modifier,Fail
>>> -kms_cursor_legacy@all-pipes-forked-bo,Fail
>>> -kms_cursor_legacy@all-pipes-forked-move,Fail
>>> -kms_cursor_legacy@all-pipes-single-bo,Fail
>>> -kms_cursor_legacy@all-pipes-single-move,Fail
>>> -kms_cursor_legacy@all-pipes-torture-bo,Fail
>>> -kms_cursor_legacy@all-pipes-torture-move,Fail
>>> -kms_cursor_legacy@pipe-A-forked-bo,Fail
>>> -kms_cursor_legacy@pipe-A-forked-move,Fail
>>> -kms_cursor_legacy@pipe-A-single-bo,Fail
>>> -kms_cursor_legacy@pipe-A-single-move,Fail
>>> -kms_cursor_legacy@pipe-A-torture-bo,Fail
>>> -kms_cursor_legacy@pipe-A-torture-move,Fail
>>> +kms_cursor_legacy@torture-bo,Fail
>>>   kms_force_connector_basic@force-edid,Fail
>>>   kms_hdmi_inject@inject-4k,Fail
>>>   kms_selftest@drm_format,Timeout

