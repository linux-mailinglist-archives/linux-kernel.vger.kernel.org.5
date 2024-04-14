Return-Path: <linux-kernel+bounces-144047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 553FF8A413A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 10:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AB0F1F21F49
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 08:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E391225D4;
	Sun, 14 Apr 2024 08:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="tjhxku4a"
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35B721A06;
	Sun, 14 Apr 2024 08:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713083270; cv=none; b=XFmHpukFWCdUnCniOJaquzRnKfpeG0/RSvdkCiF8JYLhdKoUEsoVz3pZmm6307n7Bbs4SSH7rXP6yWGft42K9KYZKjfya7UjmUQ31O1tqpP78MDk8EwG3t2stFEadWKxCDKzLx6X+QQRHDTazkdObnp6w8u78mI7d06BXELuax0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713083270; c=relaxed/simple;
	bh=ZNy+Ta4MPqN2TVyPgKfrF+9R+orsPUZ7WfSOlxXIBR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YO9G5Ad5S824x9pWoxMPegDbQU2DdEl8UEyMoRunivL+L4aYWobFovZEIrSPirQk9lndZ0timw9jjlVzvX10fGPrE6qHy19yDG7w1mMrxpEmM++F5ssWGeyQwzlNOPJNu15ok94UQ1Nmn/rFe0iYHyK5MBZf4xP4tE8KALlBvnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=tjhxku4a; arc=none smtp.client-ip=80.12.242.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id vvC8ry1nx2EKwvvC8r61FO; Sun, 14 Apr 2024 10:26:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1713083199;
	bh=N6kt4K4X39o6KWEFDhgyAlxfWwd6wjsL+csvpVS017g=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=tjhxku4aCpQd8TAr+IdcjNdqD4iVTDQ/Q8lB+Jy8XNu/oMLoUMZk0TNWubY5O1ypz
	 KRj9vhTckLtq2u/Ve7a1zHMaGoAD0dazRl/5oTk6k/Me04gStigPK+uN85ASj9mwjC
	 PyYHr36ZAh+YuVGgVkD2j+rjhDNqJAmbuBWhRPQD79XykVrZCGM+aCZHEbjoye5DxY
	 /LtRtP4ooYOiuZrnQ/rXqrlQc7v5xcGdJ+Oa4cxAN3lkzsH6YjXEqPrZYGb0HYjmGN
	 Sd1oRdvBaUMPbb0XbDWWAb+6AyPk4EvN0nY5GSUZeWaD5hj7ofTI+ZNop9Qb6052bK
	 nZ6yMFbai/DLg==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 14 Apr 2024 10:26:39 +0200
X-ME-IP: 86.243.17.157
Message-ID: <a788ee2e-ee51-476f-8aee-aa344f221f9c@wanadoo.fr>
Date: Sun, 14 Apr 2024 10:26:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/i915/guc: Remove usage of the deprecated
 ida_simple_xx() API
To: Matthew Brost <matthew.brost@intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 intel-gfx@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <7108c1871c6cb08d403c4fa6534bc7e6de4cb23d.1705245316.git.christophe.jaillet@wanadoo.fr>
 <ZbGlqD6zyyp4DsmH@DUT025-TGLU.fm.intel.com>
Content-Language: en-MW
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <ZbGlqD6zyyp4DsmH@DUT025-TGLU.fm.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 25/01/2024 à 01:04, Matthew Brost a écrit :
> On Sun, Jan 14, 2024 at 04:15:34PM +0100, Christophe JAILLET wrote:
>> ida_alloc() and ida_free() should be preferred to the deprecated
>> ida_simple_get() and ida_simple_remove().
>>
>> Note that the upper limit of ida_simple_get() is exclusive, but the one of
>> ida_alloc_range() is inclusive. So a -1 has been added when needed.
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> Reviewed-by: Matthew Brost <matthew.brost@intel.com>

Hi,

polite reminder ;-)

CJ

> 
>> ---
>>   drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c | 13 ++++++-------
>>   1 file changed, 6 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c b/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
>> index a259f1118c5a..73ce21ddf682 100644
>> --- a/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
>> +++ b/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
>> @@ -2156,11 +2156,10 @@ static int new_guc_id(struct intel_guc *guc, struct intel_context *ce)
>>   					      order_base_2(ce->parallel.number_children
>>   							   + 1));
>>   	else
>> -		ret = ida_simple_get(&guc->submission_state.guc_ids,
>> -				     NUMBER_MULTI_LRC_GUC_ID(guc),
>> -				     guc->submission_state.num_guc_ids,
>> -				     GFP_KERNEL | __GFP_RETRY_MAYFAIL |
>> -				     __GFP_NOWARN);
>> +		ret = ida_alloc_range(&guc->submission_state.guc_ids,
>> +				      NUMBER_MULTI_LRC_GUC_ID(guc),
>> +				      guc->submission_state.num_guc_ids - 1,
>> +				      GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOWARN);
>>   	if (unlikely(ret < 0))
>>   		return ret;
>>   
>> @@ -2183,8 +2182,8 @@ static void __release_guc_id(struct intel_guc *guc, struct intel_context *ce)
>>   							   + 1));
>>   		} else {
>>   			--guc->submission_state.guc_ids_in_use;
>> -			ida_simple_remove(&guc->submission_state.guc_ids,
>> -					  ce->guc_id.id);
>> +			ida_free(&guc->submission_state.guc_ids,
>> +				 ce->guc_id.id);
>>   		}
>>   		clr_ctx_id_mapping(guc, ce->guc_id.id);
>>   		set_context_guc_id_invalid(ce);
>> -- 
>> 2.43.0
>>
> 
> 


