Return-Path: <linux-kernel+bounces-70970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98892859ED1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38B51B2213E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0362A21A1C;
	Mon, 19 Feb 2024 08:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="c1+wIJB9"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922292135A
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 08:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708332770; cv=none; b=JbtjnCDfGsf/gLRfdvvv09VHV/jw1DZMuJ/CrndtdJC8xGtgwxU3bLwtDD1eItzW/zZZPTdIoLhkBqJN8VD8cnzgwac1hNhV9jtoquE+gyOi9YCGu3VLEuL/dHXCGbNxAn/+kKroFZyylqn8hR414+imv4KYqTN2lgADSCrw4ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708332770; c=relaxed/simple;
	bh=4X90vGi+S3GMD8xcunMsqdnSAQ5bq0oM8thgSR31da0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qcsMEETYk1v+XKtXwut48daXOAIA1EuekcA6qOAOoqmYXFzktjsX1kqG8HY2i08DHM/0w5ucKnfqOy4+ZudGSIqYeMRcQgdSDmZdCjk1/4vjyu0rBuh0yV7j1C/vnxIiE+K7r2v/haGpilwKHpYvGlC3+t2onOZMtjqoZrtWg7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=c1+wIJB9; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708332766;
	bh=4X90vGi+S3GMD8xcunMsqdnSAQ5bq0oM8thgSR31da0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=c1+wIJB9dLAkFFYkLTsVtGo2Or1NO0CJwUEHlS8GwLHyT9hnJGRE9px9PHnthYq2a
	 XOuT1I79SybuczGIRRiJu2VegJUKqo/qpckhL+4Ze4fpu1PXiL2ypsMASzj/9A8bER
	 p3K3LddVkPhsm0xRfNmPDd+eEH3qf1Wbzd8JTRYey0LxDZ7KU8oo8qzlQwNXdroJpA
	 gjt2OFWM1ENlTG/ggT6h+l+aOQh3k1vUlLnz6BE6cQrcxF02ufERfuW7qjETqRAJFy
	 /dDV501hps75ck2b29IKbXCk82qu1Ju7gla2X3XGfYbMibxVhoQuj4f7VaW0ENycD3
	 sDWRU+FszXeWA==
Received: from [100.66.96.193] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D764D37820BF;
	Mon, 19 Feb 2024 08:52:43 +0000 (UTC)
Message-ID: <e1f56317-b70d-0b81-75f0-fef50616e026@collabora.com>
Date: Mon, 19 Feb 2024 14:22:41 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 9/9] drm/ci: uprev IGT and update testlist
Content-Language: en-US
To: =?UTF-8?Q?Ma=c3=adra_Canal?= <mcanal@igalia.com>,
 dri-devel@lists.freedesktop.org
Cc: linux-rockchip@lists.infradead.org, guilherme.gallo@collabora.com,
 sergi.blanch.torne@collabora.com, linux-kernel@vger.kernel.org,
 david.heidelberg@collabora.com, helen.koike@collabora.com,
 linux-mediatek@lists.infradead.org, amd-gfx@lists.freedesktop.org,
 daniel@ffwll.ch, linux-amlogic@lists.infradead.org, airlied@gmail.com
References: <20240130150340.687871-1-vignesh.raman@collabora.com>
 <20240130150340.687871-10-vignesh.raman@collabora.com>
 <26f6426d-dcb6-4b14-b031-368b2248e9e7@igalia.com>
 <799653a3-e079-4e17-9d68-c0e384a216b0@igalia.com>
From: Vignesh Raman <vignesh.raman@collabora.com>
In-Reply-To: <799653a3-e079-4e17-9d68-c0e384a216b0@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Maíra,

On 10/02/24 23:50, Maíra Canal wrote:
> On 2/10/24 15:17, Maíra Canal wrote:
>> On 1/30/24 12:03, Vignesh Raman wrote:
>>> Uprev IGT and add amd, v3d, vc4 and vgem specific
>>> tests to testlist. Have testlist.txt per driver
>>> and include a base testlist so that the driver
>>> specific tests will run only on those hardware.
>>>
>>> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
>>> ---
>>>
>>> v3:
>>>    - New patch in series to uprev IGT and update testlist.
>>>
>>> ---
>>>   drivers/gpu/drm/ci/gitlab-ci.yml              |   2 +-
>>>   drivers/gpu/drm/ci/igt_runner.sh              |  12 +-
>>>   drivers/gpu/drm/ci/testlist-amdgpu.txt        | 151 ++++++++++++++++++
>>>   drivers/gpu/drm/ci/testlist-msm.txt           |  50 ++++++
>>>   drivers/gpu/drm/ci/testlist-panfrost.txt      |  17 ++
>>>   drivers/gpu/drm/ci/testlist-v3d.txt           |  73 +++++++++
>>>   drivers/gpu/drm/ci/testlist-vc4.txt           |  49 ++++++
>>>   drivers/gpu/drm/ci/testlist.txt               | 100 ++++--------
>>>   .../gpu/drm/ci/xfails/amdgpu-stoney-fails.txt |  24 ++-
>>>   .../drm/ci/xfails/amdgpu-stoney-flakes.txt    |   9 +-
>>>   .../gpu/drm/ci/xfails/amdgpu-stoney-skips.txt |  10 +-
>>>   11 files changed, 427 insertions(+), 70 deletions(-)
>>>   create mode 100644 drivers/gpu/drm/ci/testlist-amdgpu.txt
>>>   create mode 100644 drivers/gpu/drm/ci/testlist-msm.txt
>>>   create mode 100644 drivers/gpu/drm/ci/testlist-panfrost.txt
>>>   create mode 100644 drivers/gpu/drm/ci/testlist-v3d.txt
>>>   create mode 100644 drivers/gpu/drm/ci/testlist-vc4.txt
>>>
>>> diff --git a/drivers/gpu/drm/ci/gitlab-ci.yml 
>>> b/drivers/gpu/drm/ci/gitlab-ci.yml
>>> index bc8cb3420476..e2b021616a8e 100644
>>> --- a/drivers/gpu/drm/ci/gitlab-ci.yml
>>> +++ b/drivers/gpu/drm/ci/gitlab-ci.yml
>>> @@ -5,7 +5,7 @@ variables:
>>>     UPSTREAM_REPO: git://anongit.freedesktop.org/drm/drm
>>>     TARGET_BRANCH: drm-next
>>> -  IGT_VERSION: d2af13d9f5be5ce23d996e4afd3e45990f5ab977
>>> +  IGT_VERSION: b0cc8160ebdc87ce08b7fd83bb3c99ff7a4d8610
>>>     DEQP_RUNNER_GIT_URL: 
>>> https://gitlab.freedesktop.org/anholt/deqp-runner.git
>>>     DEQP_RUNNER_GIT_TAG: v0.15.0
>>> diff --git a/drivers/gpu/drm/ci/igt_runner.sh 
>>> b/drivers/gpu/drm/ci/igt_runner.sh
>>> index f001e015d135..2fd09b9b7cf6 100755
>>> --- a/drivers/gpu/drm/ci/igt_runner.sh
>>> +++ b/drivers/gpu/drm/ci/igt_runner.sh
>>> @@ -64,10 +64,20 @@ if ! grep -q "core_getversion" 
>>> /install/testlist.txt; then
>>>   fi
>>>   set +e
>>> +if [ "$DRIVER_NAME" = "amdgpu" ]; then
>>> +    TEST_LIST="/install/testlist-amdgpu.txt"
>>> +elif [ "$DRIVER_NAME" = "msm" ]; then
>>> +    TEST_LIST="/install/testlist-msm.txt"
>>> +elif [ "$DRIVER_NAME" = "panfrost" ]; then
>>> +    TEST_LIST="/install/testlist-panfrost.txt"
>>> +else
>>> +    TEST_LIST="/install/testlist.txt"
>>> +fi
>>> +
>>
>> Isn't V3D and VC4 testlists missing?

Yes. We need to add ci jobs to test v3d/vc4. The initial idea was just 
to split the testlist per driver and add vc4/v3d tests so that it can be 
used in future. I will add the jobs as part of v4.

>> It would be nice if you could provide us a link to a working pipeline.

Will provide the working pipeline link in next series.

>> Also, if possible, I would like to be CCed on the next version of this
>> patch, as I have interest in the V3D/VC4 tests.

Sure, will do.

> Ah, one thing: it would be nice to add the testlists to the MAINTAINERS
> file. This way, maintainers can keep track of any changes.

Yes, will add the testlists to MAINTAINERS file.

Thanks for the review and feedback.

Regards,
Vignesh

