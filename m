Return-Path: <linux-kernel+bounces-48718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A52D7846036
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C46D51C243EF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531155A4E0;
	Thu,  1 Feb 2024 18:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="l4Q1wIE0"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159BA84FB2
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 18:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706813006; cv=none; b=sJboRbVImG+5xJZbBWKA39seT2fqste6S4pSUqbq3oMHGH5bZbNqtm0QD5pOH8LjzV7Ye85Wsc08qf7q4GFQQVn/+tYgOAGXYJlUx6ob3steon/EpJUP5RXvvsfdJzr/DASnjjKr/U6eF4pwr4LUgijO0X6RcxmWSgXapPQV+wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706813006; c=relaxed/simple;
	bh=Wl1KrAyc7xaIE7vwdtrrQD1qSVs19T7oekxP6ciJbic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u8bjqOm88lUUYKVEJA0HHqUnMBrgACrmSmx0yvLkxTberG9STMTP9+iP1Zc9yua8dmomyQQjh6EQdvgaFOQfSfV8xylIuwSmVQfzggl1mtSDM8Ah8oNPI6CRVK++RizMXt75CoTZ/CTL4a1oLPeNdvckj5P4aZWaQxNah8YBLOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=l4Q1wIE0; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Ex/8JouqRMpIKRvJ6xx0/vd1ATPxG3ZxEx1H8eQh0+c=; b=l4Q1wIE0JWRulV/Ug7r3ssNTto
	53QQtjPCW7I09vWPRH6O803wXDqSmNmxocukZu6wLEPByeSsZl026MFHqtC1kBO2SsH97JfSFf24e
	LwfeSJnZCBYc5u4pmYCtJSW4bq2k/sapgdaCe1LDpyZnDVzWo7jpV3Md9A/djQ/JLQYoF4pJVm3hl
	wJlqLMX3D5c5G8P7ctORhHtbgV0pBItHcbH2X3zHKx3DfmlLKwPC8Xuh1w86dJ19DQ4xLGQN1h6OF
	JTj0QkZgaIwKQsgIoIvWEDwITncgDjEuzBSFAEplLC9LclLCWwO5tNt4hHNZWC9yyAFt3jwMR/Qu0
	TAUvOXIw==;
Received: from [189.110.59.13] (helo=[192.168.1.111])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1rVc1X-00Cgwx-SA; Thu, 01 Feb 2024 19:42:56 +0100
Message-ID: <a382b75d-4254-419c-aab5-a01eed845df1@igalia.com>
Date: Thu, 1 Feb 2024 15:42:49 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] drm/atomic: Allow drivers to write their own plane
 check for async flips
To: Pekka Paalanen <pekka.paalanen@haloniitty.fi>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
 alexander.deucher@amd.com, christian.koenig@amd.com,
 Simon Ser <contact@emersion.fr>, daniel@ffwll.ch,
 Daniel Stone <daniel@fooishbar.org>, =?UTF-8?B?J01hcmVrIE9sxaHDoWsn?=
 <maraeo@gmail.com>, Dave Airlie <airlied@gmail.com>,
 ville.syrjala@linux.intel.com, Xaver Hugl <xaver.hugl@gmail.com>,
 Joshua Ashton <joshua@froggi.es>, =?UTF-8?Q?Michel_D=C3=A4nzer?=
 <michel.daenzer@mailbox.org>
References: <20240128212515.630345-1-andrealmeid@igalia.com>
 <20240128212515.630345-2-andrealmeid@igalia.com>
 <20240129104934.0b887ec7@eldfell>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20240129104934.0b887ec7@eldfell>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Pekka,

Em 29/01/2024 05:49, Pekka Paalanen escreveu:
> On Sun, 28 Jan 2024 18:25:13 -0300
> André Almeida <andrealmeid@igalia.com> wrote:
> 
>> Some hardware are more flexible on what they can flip asynchronously, so
>> rework the plane check so drivers can implement their own check, lifting
>> up some of the restrictions.
>>
>> Signed-off-by: André Almeida <andrealmeid@igalia.com>
>> ---
>> v3: no changes
>>
>>   drivers/gpu/drm/drm_atomic_uapi.c | 62 ++++++++++++++++++++++---------
>>   include/drm/drm_atomic_uapi.h     | 12 ++++++
>>   include/drm/drm_plane.h           |  5 +++
>>   3 files changed, 62 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
>> index aee4a65d4959..6d5b9fec90c7 100644
>> --- a/drivers/gpu/drm/drm_atomic_uapi.c
>> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
>> @@ -620,7 +620,7 @@ static int drm_atomic_plane_set_property(struct drm_plane *plane,
>>   	return 0;
>>   }
>>   
>> -static int
>> +int
>>   drm_atomic_plane_get_property(struct drm_plane *plane,
>>   		const struct drm_plane_state *state,
>>   		struct drm_property *property, uint64_t *val)
>> @@ -683,6 +683,7 @@ drm_atomic_plane_get_property(struct drm_plane *plane,
>>   
>>   	return 0;
>>   }
>> +EXPORT_SYMBOL(drm_atomic_plane_get_property);
>>   
>>   static int drm_atomic_set_writeback_fb_for_connector(
>>   		struct drm_connector_state *conn_state,
>> @@ -1026,18 +1027,54 @@ int drm_atomic_connector_commit_dpms(struct drm_atomic_state *state,
>>   	return ret;
>>   }
>>   
>> -static int drm_atomic_check_prop_changes(int ret, uint64_t old_val, uint64_t prop_value,
>> +int drm_atomic_check_prop_changes(int ret, uint64_t old_val, uint64_t prop_value,
> 
> Hi,
> 
> should the word "async" be somewhere in the function name?
> 
>>   					 struct drm_property *prop)
>>   {
>>   	if (ret != 0 || old_val != prop_value) {
>>   		drm_dbg_atomic(prop->dev,
>> -			       "[PROP:%d:%s] No prop can be changed during async flip\n",
>> +			       "[PROP:%d:%s] This prop cannot be changed during async flip\n",
>>   			       prop->base.id, prop->name);
>>   		return -EINVAL;
>>   	}
>>   
>>   	return 0;
>>   }
>> +EXPORT_SYMBOL(drm_atomic_check_prop_changes);
>> +
>> +/* plane changes may have exceptions, so we have a special function for them */
>> +static int drm_atomic_check_plane_changes(struct drm_property *prop,
>> +					  struct drm_plane *plane,
>> +					  struct drm_plane_state *plane_state,
>> +					  struct drm_mode_object *obj,
>> +					  u64 prop_value, u64 old_val)
>> +{
>> +	struct drm_mode_config *config = &plane->dev->mode_config;
>> +	int ret;
>> +
>> +	if (plane->funcs->check_async_props)
>> +		return plane->funcs->check_async_props(prop, plane, plane_state,
>> +							     obj, prop_value, old_val);
> 
> Is it really ok to allow drivers to opt-in to also *reject* the FB_ID
> and IN_FENCE_FD props on async commits?
> 
> Either intentionally or by accident.
> 

Right, perhaps I should write this function in a way that you can only 
lift restrictions, and not add new ones.

>> +
>> +	/*
>> +	 * if you are trying to change something other than the FB ID, your
>> +	 * change will be either rejected or ignored, so we can stop the check
>> +	 * here
>> +	 */
>> +	if (prop != config->prop_fb_id) {
>> +		ret = drm_atomic_plane_get_property(plane, plane_state,
>> +						    prop, &old_val);
>> +		return drm_atomic_check_prop_changes(ret, old_val, prop_value, prop);
> 
> When I first read this code, it seemed to say: "If the prop is not
> FB_ID, then do the usual prop change checking that happens on all
> changes, not only async.". Reading this patch a few more times over, I
> finally realized drm_atomic_check_prop_changes() is about async
> specifically.
> 

I see that the lack of the async word is giving some confusion, so I'll 
add it to the functions.

Thanks,
	André

>> +	}
>> +
>> +	if (plane_state->plane->type != DRM_PLANE_TYPE_PRIMARY) {
>> +		drm_dbg_atomic(prop->dev,
>> +			       "[OBJECT:%d] Only primary planes can be changed during async flip\n",
>> +			       obj->id);
>> +		return -EINVAL;
>> +	}
>> +
>> +	return 0;
>> +}
>>   
>>   int drm_atomic_set_property(struct drm_atomic_state *state,
>>   			    struct drm_file *file_priv,
>> @@ -1100,7 +1137,6 @@ int drm_atomic_set_property(struct drm_atomic_state *state,
>>   	case DRM_MODE_OBJECT_PLANE: {
>>   		struct drm_plane *plane = obj_to_plane(obj);
>>   		struct drm_plane_state *plane_state;
>> -		struct drm_mode_config *config = &plane->dev->mode_config;
>>   
>>   		plane_state = drm_atomic_get_plane_state(state, plane);
>>   		if (IS_ERR(plane_state)) {
>> @@ -1108,19 +1144,11 @@ int drm_atomic_set_property(struct drm_atomic_state *state,
>>   			break;
>>   		}
>>   
>> -		if (async_flip && prop != config->prop_fb_id) {
>> -			ret = drm_atomic_plane_get_property(plane, plane_state,
>> -							    prop, &old_val);
>> -			ret = drm_atomic_check_prop_changes(ret, old_val, prop_value, prop);
>> -			break;
>> -		}
>> -
>> -		if (async_flip && plane_state->plane->type != DRM_PLANE_TYPE_PRIMARY) {
>> -			drm_dbg_atomic(prop->dev,
>> -				       "[OBJECT:%d] Only primary planes can be changed during async flip\n",
>> -				       obj->id);
>> -			ret = -EINVAL;
>> -			break;
>> +		if (async_flip) {
>> +			ret = drm_atomic_check_plane_changes(prop, plane, plane_state,
> 
> Should there be "async" somewhere in the name of
> drm_atomic_check_plane_changes()?
> 
> 
> Thanks,
> pq
> 
>> +							     obj, prop_value, old_val);
>> +			if (ret)
>> +				break;
>>   		}
>>   
>>   		ret = drm_atomic_plane_set_property(plane,
>> diff --git a/include/drm/drm_atomic_uapi.h b/include/drm/drm_atomic_uapi.h
>> index 4c6d39d7bdb2..d65fa8fbbca0 100644
>> --- a/include/drm/drm_atomic_uapi.h
>> +++ b/include/drm/drm_atomic_uapi.h
>> @@ -29,6 +29,8 @@
>>   #ifndef DRM_ATOMIC_UAPI_H_
>>   #define DRM_ATOMIC_UAPI_H_
>>   
>> +#include <linux/types.h>
>> +
>>   struct drm_crtc_state;
>>   struct drm_display_mode;
>>   struct drm_property_blob;
>> @@ -37,6 +39,9 @@ struct drm_crtc;
>>   struct drm_connector_state;
>>   struct dma_fence;
>>   struct drm_framebuffer;
>> +struct drm_mode_object;
>> +struct drm_property;
>> +struct drm_plane;
>>   
>>   int __must_check
>>   drm_atomic_set_mode_for_crtc(struct drm_crtc_state *state,
>> @@ -53,4 +58,11 @@ int __must_check
>>   drm_atomic_set_crtc_for_connector(struct drm_connector_state *conn_state,
>>   				  struct drm_crtc *crtc);
>>   
>> +int drm_atomic_plane_get_property(struct drm_plane *plane,
>> +				  const struct drm_plane_state *state,
>> +				  struct drm_property *property, uint64_t *val);
>> +
>> +int drm_atomic_check_prop_changes(int ret, uint64_t old_val, uint64_t prop_value,
>> +				  struct drm_property *prop);
>> +
>>   #endif
>> diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
>> index c6565a6f9324..73dac8d76831 100644
>> --- a/include/drm/drm_plane.h
>> +++ b/include/drm/drm_plane.h
>> @@ -540,6 +540,11 @@ struct drm_plane_funcs {
>>   	 */
>>   	bool (*format_mod_supported)(struct drm_plane *plane, uint32_t format,
>>   				     uint64_t modifier);
>> +
>> +	int (*check_async_props)(struct drm_property *prop, struct drm_plane *plane,
>> +				 struct drm_plane_state *plane_state,
>> +				 struct drm_mode_object *obj,
>> +				 u64 prop_value, u64 old_val);
>>   };
>>   
>>   /**
> 

