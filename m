Return-Path: <linux-kernel+bounces-26171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B121F82DC4A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 501E01F218AE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D7617BB1;
	Mon, 15 Jan 2024 15:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZBg/EZ6P"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C3B1798A;
	Mon, 15 Jan 2024 15:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705332317;
	bh=HVjzZol2YaSQvlH2u0E4z0OgdDsSojVsQEcmojBRQKE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZBg/EZ6PRgpO7GQYZQmOaC581c1P+P7totUX4FFU+zxgZVcLPE5JSxBFK4sg5su/X
	 V1Yv2M5JSeUjb6Axet3tr085MWgjtgSFfB4NrHlFtOrwEUz5zpWP19j77/UdOqbs3r
	 7U3IqsnT4lkyrIjEsasUZ06SWHARnpD30T2AoQCalr+jxPjwtjEv//acFkzOvI0yVz
	 rXtARLOGNoMNEAInCMiWdgkMns2EgS4/arZe43m0Mxs99ftzioQOZeeKivEDVh4Kiu
	 tgRe1AroeVfy6yYR3+OmvwXbgehHQrbbaTqntahbsMHH3Q8RLWlNcjiC3zt95f2Cp8
	 SptbqVRaiLvQQ==
Received: from [100.95.196.25] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: koike)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3340337813DA;
	Mon, 15 Jan 2024 15:25:13 +0000 (UTC)
Message-ID: <933b14a9-004c-4528-a02d-f38843a7e093@collabora.com>
Date: Mon, 15 Jan 2024 12:25:13 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/ci: Add msm tests
To: Vignesh Raman <vignesh.raman@collabora.com>,
 Rob Clark <robdclark@gmail.com>
Cc: dri-devel@lists.freedesktop.org, Rob Clark <robdclark@chromium.org>,
 Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 open list <linux-kernel@vger.kernel.org>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, freedreno@lists.freedesktop.org,
 Daniel Stone <daniel@fooishbar.org>
References: <20240108195016.156583-1-robdclark@gmail.com>
 <27e64458-7cb1-99a4-f67e-60d911f28f44@collabora.com>
 <CAF6AEGvBFdXe9rHjbwWv9eLUMv2YEP7cfMoXcWgZ30Wn4LzOjw@mail.gmail.com>
 <CAF6AEGuXi1wTbE0j6FmSnqw_EVUYSdnk5WeFL6abD=zeNutPpg@mail.gmail.com>
 <33024b12-2530-3a2e-5bcf-f5a466d9a767@collabora.com>
Content-Language: en-US
From: Helen Koike <helen.koike@collabora.com>
In-Reply-To: <33024b12-2530-3a2e-5bcf-f5a466d9a767@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 15/01/2024 07:22, Vignesh Raman wrote:
> Hi Rob,
> 
> On 12/01/24 22:44, Rob Clark wrote:
>> On Fri, Jan 12, 2024 at 7:57 AM Rob Clark <robdclark@gmail.com> wrote:
>>>
>>> On Fri, Jan 12, 2024 at 3:42 AM Vignesh Raman
>>> <vignesh.raman@collabora.com> wrote:
>>>>
>>>> Hi Rob,
>>>>
>>>>
>>>> On 09/01/24 01:20, Rob Clark wrote:
>>>>> From: Rob Clark <robdclark@chromium.org>
>>>>>
>>>>> The msm tests should skip on non-msm hw, so I think it should be 
>>>>> safe to
>>>>> enable everywhere.
>>>>>
>>>>> Signed-off-by: Rob Clark <robdclark@chromium.org>

Acked-by: Helen Koike <helen.koike@collabora.com>

>>>>> ---
>>>>>    drivers/gpu/drm/ci/testlist.txt | 49 
>>>>> +++++++++++++++++++++++++++++++++
>>>>>    1 file changed, 49 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/ci/testlist.txt 
>>>>> b/drivers/gpu/drm/ci/testlist.txt
>>>>> index f82cd90372f4..eaeb751bb0ad 100644
>>>>> --- a/drivers/gpu/drm/ci/testlist.txt
>>>>> +++ b/drivers/gpu/drm/ci/testlist.txt
>>>>> @@ -2910,3 +2910,52 @@ kms_writeback@writeback-invalid-parameters
>>>>>    kms_writeback@writeback-fb-id
>>>>>    kms_writeback@writeback-check-output
>>>>>    prime_mmap_kms@buffer-sharing
>>>>> +msm_shrink@copy-gpu-sanitycheck-8
>>>>> +msm_shrink@copy-gpu-sanitycheck-32
>>>>> +msm_shrink@copy-gpu-8
>>>>> +msm_shrink@copy-gpu-32
>>>>> +msm_shrink@copy-gpu-madvise-8
>>>>> +msm_shrink@copy-gpu-madvise-32
>>>>> +msm_shrink@copy-gpu-oom-8
>>>>> +msm_shrink@copy-gpu-oom-32
>>>>> +msm_shrink@copy-mmap-sanitycheck-8
>>>>> +msm_shrink@copy-mmap-sanitycheck-32
>>>>> +msm_shrink@copy-mmap-8
>>>>> +msm_shrink@copy-mmap-32
>>>>> +msm_shrink@copy-mmap-madvise-8
>>>>> +msm_shrink@copy-mmap-madvise-32
>>>>> +msm_shrink@copy-mmap-oom-8
>>>>> +msm_shrink@copy-mmap-oom-32
>>>>> +msm_shrink@copy-mmap-dmabuf-sanitycheck-8
>>>>> +msm_shrink@copy-mmap-dmabuf-sanitycheck-32
>>>>> +msm_shrink@copy-mmap-dmabuf-8
>>>>> +msm_shrink@copy-mmap-dmabuf-32
>>>>> +msm_shrink@copy-mmap-dmabuf-madvise-8
>>>>> +msm_shrink@copy-mmap-dmabuf-madvise-32
>>>>> +msm_shrink@copy-mmap-dmabuf-oom-8
>>>>> +msm_shrink@copy-mmap-dmabuf-oom-32
>>>>> +msm_mapping@ring
>>>>> +msm_mapping@sqefw
>>>>> +msm_mapping@shadow
>>>>> +msm_submitoverhead@submitbench-10-bos
>>>>> +msm_submitoverhead@submitbench-10-bos-no-implicit-sync
>>>>> +msm_submitoverhead@submitbench-100-bos
>>>>> +msm_submitoverhead@submitbench-100-bos-no-implicit-sync
>>>>> +msm_submitoverhead@submitbench-250-bos
>>>>> +msm_submitoverhead@submitbench-250-bos-no-implicit-sync
>>>>> +msm_submitoverhead@submitbench-500-bos
>>>>> +msm_submitoverhead@submitbench-500-bos-no-implicit-sync
>>>>> +msm_submitoverhead@submitbench-1000-bos
>>>>> +msm_submitoverhead@submitbench-1000-bos-no-implicit-sync
>>>>> +msm_recovery@hangcheck
>>>>> +msm_recovery@gpu-fault
>>>>> +msm_recovery@gpu-fault-parallel
>>>>> +msm_recovery@iova-fault
>>>>> +msm_submit@empty-submit
>>>>> +msm_submit@invalid-queue-submit
>>>>> +msm_submit@invalid-flags-submit
>>>>> +msm_submit@invalid-in-fence-submit
>>>>> +msm_submit@invalid-duplicate-bo-submit
>>>>> +msm_submit@invalid-cmd-idx-submit
>>>>> +msm_submit@invalid-cmd-type-submit
>>>>> +msm_submit@valid-submit
>>>>
>>>> I tested this patch with latest drm-misc/drm-misc-next and there was
>>>> some failures seen for the newly added msm tests. I have updated the
>>>> xfails with below commit,
>>>>
>>>> https://gitlab.freedesktop.org/vigneshraman/linux/-/commit/d012893597a661d6ebbb755bf2607dfb055524a1
>>>>
>>>> I will notify the maintainers about the flaky tests, update the url in
>>>> the flakes.txt, and submit a separate patch for this change.
>>
>> Oh, you should probably move msm_mapping@* to skips on sdm845.  I had
>> a closer look at those, and they are failing due to a bootloader/fw
>> issue.  We work around this in mesa CI with these two patches:
>>
>> https://gitlab.freedesktop.org/gfx-ci/linux/-/commit/4b49f902ec6f2bb382cbbf489870573f4b43371e
>> https://gitlab.freedesktop.org/gfx-ci/linux/-/commit/38cdf4c5559771e2474ae0fecef8469f65147bc1
>>
>> But given that sdm845 is similar to sc7180 as far as kernel gpu
>> driver, it is probably just better to skip these on sdm845 (with a
>> comment referring to the hack patches we use in mesa CI)
> 
> I have sent a patch with these changes,

Thanks!

Helen

> 
> https://lore.kernel.org/dri-devel/20240115101750.27077-1-vignesh.raman@collabora.com/T/#u
> 
> Thanks.
> 
> Regards,
> Vignesh
> 

