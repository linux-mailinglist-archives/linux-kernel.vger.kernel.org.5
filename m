Return-Path: <linux-kernel+bounces-104310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B84D887CC0C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9A4B1C22573
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0E81B5B1;
	Fri, 15 Mar 2024 11:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fIY2rkPW"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217BD18EA5
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 11:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710501182; cv=none; b=SScz+j3yOa1khyoUtLLoopq/uRBhfQuppTCSGYkoUBjyVR5vyVqNGnu/WP6lSwznQ1XyTU+YRbDlXo3rTAlFQ7j5HkGLf7lXCcgTyQsacHKBFseuHNOhI4MpWB2AssrInOSJTYaMrtyNdWhuNHKJDDfrYsb+7Ke/DbZ6WOHbTiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710501182; c=relaxed/simple;
	bh=0CXDKtVLaMZDoZYYFTaEKJbdWnIjyLWhv+rAJccVjpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V6DNpKAO8fUZOcNMAfaMaWy66uYPthJMLtoS04ZHMJafUp1v6QIKKe0Ccj2N0PKGXDlrI3pW96WuAe8baJo1a+O9Ejw8aTrp7dZNWancZz9xmTDcK9DPdqA6/A7BWIrnRspnC7WvJ4+5r6/VEdHFpflB5FrfuYWowkHIzQORD6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fIY2rkPW; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710501179;
	bh=0CXDKtVLaMZDoZYYFTaEKJbdWnIjyLWhv+rAJccVjpA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fIY2rkPWBdmvDpr0Wom4qFXXVpArrafGToPCZp2XjR+O80luPezh2WtvoB3kopjKr
	 oQM1rDX8QxVgnC0rE+1xABQXLuPNKswAqJj66NifFvNwa7+MgV8MFzCOjplUqw4rtK
	 dEcaa0n2ZT6NGPO+E+gTfBvySKTndwpcEVLH/JKUis2SjV3g5J9V77IBHmQrhpQWb+
	 mQYhWbyUb4wHLO17kp868XgQqVt09ivekV05vVdtlW0zGjNvMIUe7NyOfzj+XOCdor
	 mrCBuo4qHQPe6Dhk7W5kjWq0ieFwu5eLMYdbRxilEedc385U9pBLiK71caXIr5efUX
	 mJqVSIf0ziBLg==
Received: from [100.66.96.193] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1EF11378210F;
	Fri, 15 Mar 2024 11:12:54 +0000 (UTC)
Message-ID: <af5b6e38-306d-ae79-42af-88e6e9a32cff@collabora.com>
Date: Fri, 15 Mar 2024 16:42:52 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 03/11] drm/ci: uprev IGT and update testlist
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
 <20240306030649.60269-4-vignesh.raman@collabora.com>
 <4f927c99-9ea2-424e-85a7-bd05d0817dab@collabora.com>
From: Vignesh Raman <vignesh.raman@collabora.com>
In-Reply-To: <4f927c99-9ea2-424e-85a7-bd05d0817dab@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Helen,

On 07/03/24 19:05, Helen Koike wrote:
> 
> 
> On 06/03/2024 00:06, Vignesh Raman wrote:
>> Uprev IGT and add amd, v3d, vc4 and vgem specific
>> tests to testlist. Have testlist.txt per driver
>> and include a base testlist so that the driver
>> specific tests will run only on those hardware.
>> Also add testlists to the MAINTAINERS file.
>>
>> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
>> ---
>>
>> v3:
>>    - New patch in series to uprev IGT and update testlist.
>>
>> v4:
>>    - Add testlists to the MAINTAINERS file and remove amdgpu xfails 
>> changes.
>>
>> ---
>>   MAINTAINERS                              |  11 ++
>>   drivers/gpu/drm/ci/gitlab-ci.yml         |   2 +-
>>   drivers/gpu/drm/ci/igt_runner.sh         |  12 +-
>>   drivers/gpu/drm/ci/testlist-amdgpu.txt   | 151 +++++++++++++++++++++++
>>   drivers/gpu/drm/ci/testlist-msm.txt      |  50 ++++++++
>>   drivers/gpu/drm/ci/testlist-panfrost.txt |  17 +++
>>   drivers/gpu/drm/ci/testlist-v3d.txt      |  73 +++++++++++
>>   drivers/gpu/drm/ci/testlist-vc4.txt      |  49 ++++++++
>>   drivers/gpu/drm/ci/testlist.txt          |  84 ++++++-------
>>   9 files changed, 398 insertions(+), 51 deletions(-)
>>   create mode 100644 drivers/gpu/drm/ci/testlist-amdgpu.txt
>>   create mode 100644 drivers/gpu/drm/ci/testlist-msm.txt
>>   create mode 100644 drivers/gpu/drm/ci/testlist-panfrost.txt
>>   create mode 100644 drivers/gpu/drm/ci/testlist-v3d.txt
>>   create mode 100644 drivers/gpu/drm/ci/testlist-vc4.txt
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 3bc7e122a094..4da66ca92f1a 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1665,6 +1665,8 @@ L:    dri-devel@lists.freedesktop.org
>>   S:    Supported
>>   T:    git git://anongit.freedesktop.org/drm/drm-misc
>>   F:    Documentation/gpu/panfrost.rst
>> +F:    drivers/gpu/drm/ci/testlist-panfrost.txt
>> +F:    drivers/gpu/drm/ci/testlist.txt
> 
> I wonder if we should have both here, since the second is not used right?

Yes, we need to use both here. testlist-panfrost.txt includes 
testlist.txt. So we have moved the driver specific tests to
testlist-panfrost.txt and have a base testlist.txt.


>> diff --git a/drivers/gpu/drm/ci/igt_runner.sh 
>> b/drivers/gpu/drm/ci/igt_runner.sh
>> index f1a08b9b146f..77cd81fe6d1a 100755
>> --- a/drivers/gpu/drm/ci/igt_runner.sh
>> +++ b/drivers/gpu/drm/ci/igt_runner.sh
>> @@ -74,10 +74,20 @@ if ! grep -q "core_getversion" 
>> /install/testlist.txt; then
>>   fi
>>   set +e
>> +if [ "$DRIVER_NAME" = "amdgpu" ]; then
>> +    TEST_LIST="/install/testlist-amdgpu.txt"
>> +elif [ "$DRIVER_NAME" = "msm" ]; then
>> +    TEST_LIST="/install/testlist-msm.txt"
>> +elif [ "$DRIVER_NAME" = "panfrost" ]; then
>> +    TEST_LIST="/install/testlist-panfrost.txt"
>> +else
>> +    TEST_LIST="/install/testlist.txt"
>> +fi
> 
> Maybe simplify this with:
> 
> TEST_LIST="/install/testlist-$DRIVER_NAME.txt"
> 
> if [ ! -f "$TEST_LIST" ]; then
>      TEST_LIST="/install/testlist.txt"
> fi

Yes, this is much better. Thanks.

> 
> Another question I have: shouldn't testlist-$DRIVER_NAME.txt and 
> testlist.txt be merged? Or they are really mutually exclusive?

We have testlist-$DRIVER_NAME.txt per driver and it includes a base 
testlist.txt

Regards,
Vignesh

