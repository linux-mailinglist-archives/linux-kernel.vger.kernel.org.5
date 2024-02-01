Return-Path: <linux-kernel+bounces-48723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 258AB846043
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE9041F27F38
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCF584FAC;
	Thu,  1 Feb 2024 18:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="bxu9L7ar"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2BF8526A
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 18:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706813184; cv=none; b=M4FybKHfyXM2gc5lV+D57NZp7AxhmSxpgtSO6UHLZ1EdvgAKlhYluXQ9EKlmzfHp9gOT0g1iAW9F50uc0lblC7C9Cnc2EWFeAna8jHtiCq9AAvGvDHefjDsKSy+Rw2+PdHlt3OzfqWBYcCxskPdx6SY24gqVbwUl8KzlS4lw/bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706813184; c=relaxed/simple;
	bh=gGvQRs0uxQM5FEh/jedGHsIEoj70sxzzBDKT9DxZWR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=c9FfSerd6guUsIboYLp243HjRvtl9Z6d1gwyW/oAu7fXeV2PS92XidZPSTuZvI22/HP0aBb7aFBHoAAarNs46d5YLR4/r0H6xiSxhyxUMc65qJUHpE3uQOKU0CedlK+teu2iHWnHMFed6wE29MDTVnhZNKFHX/tR4FW0EiIMIJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=bxu9L7ar; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:Cc:
	References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
	:List-Post:List-Owner:List-Archive;
	bh=H2N1LRFRb5K1bZEyZiUexexQH3bssy46zqFCMiG0Q8c=; b=bxu9L7ar1fY4SwmcfQVQl368HJ
	JXUaJDADNMchZOlitOhwgj0SsbeVw4C7YqZXJqS2GQ/L8WHN8Gzekv/3gbGXQrrZVqePrlZPjqi/N
	WCCgRDT7Nuqwm1ZLuZ/T2aX1tRxLaxy/BEOWKtvXHNn7upW90BjIcfi4sSxi8zayXqAORtIbJQj8e
	OOH9AtLkrU3nlYrGQ1+kc62GQEn7fMhAnLp81Nc8rqEac7/nraqIZghAf4oCIkuLKo4IEyYAVFoH9
	ME/cYzNNN4D3I6T4fOBlSmUkU0xzDrlu4l4W1xBAl3KU1MJWOWBDr51fTpcmKivOfnlTQ26Z9GoNt
	jEtlNM6g==;
Received: from [189.110.59.13] (helo=[192.168.1.111])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1rVc4P-00Ch1g-G0; Thu, 01 Feb 2024 19:45:53 +0100
Message-ID: <203d7768-2e54-4d89-9a1d-ef61e6da6d89@igalia.com>
Date: Thu, 1 Feb 2024 15:45:46 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] drm/amdgpu: Implement check_async_props for planes
Content-Language: en-US
To: Daniel Vetter <daniel@ffwll.ch>
References: <20240128212515.630345-1-andrealmeid@igalia.com>
 <20240128212515.630345-4-andrealmeid@igalia.com>
 <ZbjVyI_AnTBHACT8@phenom.ffwll.local>
Cc: kernel-dev@igalia.com, Xaver Hugl <xaver.hugl@gmail.com>,
 ville.syrjala@linux.intel.com, Joshua Ashton <joshua@froggi.es>,
 Daniel Stone <daniel@fooishbar.org>, Simon Ser <contact@emersion.fr>,
 dri-devel@lists.freedesktop.org, =?UTF-8?Q?Michel_D=C3=A4nzer?=
 <michel.daenzer@mailbox.org>, amd-gfx@lists.freedesktop.org,
 Dave Airlie <airlied@gmail.com>, christian.koenig@amd.com,
 alexander.deucher@amd.com, =?UTF-8?B?J01hcmVrIE9sxaHDoWsn?=
 <maraeo@gmail.com>, Pekka Paalanen <ppaalanen@gmail.com>,
 linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <ZbjVyI_AnTBHACT8@phenom.ffwll.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Sima,

Em 30/01/2024 07:56, Daniel Vetter escreveu:
> On Sun, Jan 28, 2024 at 06:25:15PM -0300, André Almeida wrote:
>> AMD GPUs can do async flips with changes on more properties than just
>> the FB ID, so implement a custom check_async_props for AMD planes.
>>
>> Allow amdgpu to do async flips with overlay planes as well.
>>
>> Signed-off-by: André Almeida <andrealmeid@igalia.com>
>> ---
>> v3: allow overlay planes
> 
> This comment very much written with a lack of clearly better ideas, but:
> 
> Do we really need this much flexibility, especially for the first driver
> adding the first few additional properties?
> 
> A simple bool on struct drm_plane to indicate whether async flips are ok
> or not should also do this job here? Maybe a bit of work to roll that out
> to the primary planes for current drivers, but not much. And wouldn't need
> drivers to implement some very uapi-marshalling atomic code ...

Right, perhaps I can first write in the way you suggest, and later 
expand to the form I have proposed here if/when new properties arise.

> 
> Also we could probably remove the current drm_mode_config.async_flip flag
> and entirely replace it with the per-plane one.
> -Sima
>>
>>   .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 29 +++++++++++++++++++
>>   1 file changed, 29 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
>> index 116121e647ca..ed75b69636b4 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
>> @@ -25,6 +25,7 @@
>>    */
>>   
>>   #include <drm/drm_atomic_helper.h>
>> +#include <drm/drm_atomic_uapi.h>
>>   #include <drm/drm_blend.h>
>>   #include <drm/drm_gem_atomic_helper.h>
>>   #include <drm/drm_plane_helper.h>
>> @@ -1430,6 +1431,33 @@ static void amdgpu_dm_plane_drm_plane_destroy_state(struct drm_plane *plane,
>>   	drm_atomic_helper_plane_destroy_state(plane, state);
>>   }
>>   
>> +static int amdgpu_dm_plane_check_async_props(struct drm_property *prop,
>> +					  struct drm_plane *plane,
>> +					  struct drm_plane_state *plane_state,
>> +					  struct drm_mode_object *obj,
>> +					  u64 prop_value, u64 old_val)
>> +{
>> +	struct drm_mode_config *config = &plane->dev->mode_config;
>> +	int ret;
>> +
>> +	if (prop != config->prop_fb_id &&
>> +	    prop != config->prop_in_fence_fd) {
>> +		ret = drm_atomic_plane_get_property(plane, plane_state,
>> +						    prop, &old_val);
>> +		return drm_atomic_check_prop_changes(ret, old_val, prop_value, prop);
>> +	}
>> +
>> +	if (plane_state->plane->type != DRM_PLANE_TYPE_PRIMARY &&
>> +	    plane_state->plane->type != DRM_PLANE_TYPE_OVERLAY) {
>> +		drm_dbg_atomic(prop->dev,
>> +			       "[OBJECT:%d] Only primary or overlay planes can be changed during async flip\n",
>> +			       obj->id);
>> +		return -EINVAL;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   static const struct drm_plane_funcs dm_plane_funcs = {
>>   	.update_plane	= drm_atomic_helper_update_plane,
>>   	.disable_plane	= drm_atomic_helper_disable_plane,
>> @@ -1438,6 +1466,7 @@ static const struct drm_plane_funcs dm_plane_funcs = {
>>   	.atomic_duplicate_state = amdgpu_dm_plane_drm_plane_duplicate_state,
>>   	.atomic_destroy_state = amdgpu_dm_plane_drm_plane_destroy_state,
>>   	.format_mod_supported = amdgpu_dm_plane_format_mod_supported,
>> +	.check_async_props = amdgpu_dm_plane_check_async_props,
>>   };
>>   
>>   int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
>> -- 
>> 2.43.0
>>
> 

