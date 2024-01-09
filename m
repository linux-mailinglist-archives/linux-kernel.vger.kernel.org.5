Return-Path: <linux-kernel+bounces-21130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE48828A68
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 17:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10C0E288AE3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 16:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D823A8F1;
	Tue,  9 Jan 2024 16:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fgLBbaMx"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F309364B7;
	Tue,  9 Jan 2024 16:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704818874; x=1736354874;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gaEKgeWzK9tycqPLAAm+RoBb74b0rOVzaME1Qb2Pfjw=;
  b=fgLBbaMxEqecKZlvyoeE5A/iBhnYyS1HqD+nzBO/fe5snmQ8clhbn4Zd
   rqo9XMjWoh0C/YNgYd1y2uCJ54JgFJ5Y7+gfWrzJdSDn6NERhLcUWsqbP
   K24oWSV8ERKAYq7dLlJKTp2cDt8yPHPWRSBg1l4TyVQ407LKCUUq8A/0G
   AiG9BXxo9LAYcoikHbrsAYQKWAuYCENES/o8IjbiokRRDHiTK3EpvhAI5
   EklDY1+aRb7R4NtDM8ANEHukhpPdf3s+nPumfd4YYD1VxHP2S5kiqOAie
   yPdZGa2uWaTOahs5oY0mJQ2oPcKxZjJz6xOFu1rSfGVCMLjJvwuxzUtQg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="388696403"
X-IronPort-AV: E=Sophos;i="6.04,183,1695711600"; 
   d="scan'208";a="388696403"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 08:47:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="852253484"
X-IronPort-AV: E=Sophos;i="6.04,183,1695711600"; 
   d="scan'208";a="852253484"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga004.fm.intel.com with ESMTP; 09 Jan 2024 08:47:41 -0800
Received: from [10.249.150.124] (mwajdecz-MOBL.ger.corp.intel.com [10.249.150.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id C8648C8375;
	Tue,  9 Jan 2024 16:47:36 +0000 (GMT)
Message-ID: <b48eb9f7-3986-4021-baef-35443c0294d4@intel.com>
Date: Tue, 9 Jan 2024 17:47:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/xe: clean up type of GUC_HXG_MSG_0_ORIGIN
Content-Language: en-US
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, intel-xe@lists.freedesktop.org
References: <ec22d742-632b-426a-ac86-62641a38c907@moroto.mountain>
 <e5g3qkwvc3sjfpxcdvn43fiwbxthpblqgg2getxpbkd6g4lp5k@pgfm75tsg7wz>
 <84a5c289-e2f6-4e30-a093-5a1c5b335057@intel.com>
 <7vb3ql7z5dac3kwo7nhibh5al7wemt45ibzuyk4bpyzpltzjml@go7rtyq4m6hq>
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
In-Reply-To: <7vb3ql7z5dac3kwo7nhibh5al7wemt45ibzuyk4bpyzpltzjml@go7rtyq4m6hq>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 08.01.2024 22:24, Lucas De Marchi wrote:
> On Mon, Jan 08, 2024 at 09:46:47PM +0100, Michal Wajdeczko wrote:
>>
>>
>> On 08.01.2024 15:07, Lucas De Marchi wrote:
>>> On Mon, Jan 08, 2024 at 12:05:57PM +0300, Dan Carpenter wrote:
>>>> The GUC_HXG_MSG_0_ORIGIN definition should be unsigned.  Currently
>>>> it is
>>>> defined as INT_MIN.  This doesn't cause a problem currently but it's
>>>> still worth cleaning up.
>>>>
>>>> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
>>>
>>> it seems there are a few more places to change to follow what was done
>>> in commit 962bd34bb457 ("drm/i915/uc: Fix undefined behavior due to
>>> shift overflowing the constant").
>>>
>>> +Michal
>>>
>>> Could we eventually share these abi includes with i915 so we don't
>>> keep fixing the same thing in 2 places?
>>
>> it should be possible and I guess we should plan for that while
>> discussing all this new xe driver...
>>
>> anyway, what about creating new intel/ folder under drm/ ?
> 
> include/drm/intel/?

maybe, but then we will be limited to pure definitions/inlines, while I
hope we could separate more GuC firmware specific, but still driver
agnostic, code and place it under drivers/gpu/drm/intel/

drivers/gpu/drm/intel/
   include/
      abi/
         guc_actions_abi.h
         guc_errors_abi.h
         guc_klvs_abi.h
   guc/
      guc_hxg_helpers.c
      guc_log_helpers.c

note that AMD has its definitions in drm/amd/include/ not under include/

> 
>>
>> - drm/intel/include/abi
>>        guc_actions_abi.h
>>        guc_klvs_abi.h
>>        ...
>>
>> the only question would be what prefix should be used for macros:
>> just GUC_ or INTEL_GUC_ or XE_GUC_ ?
> 
> if using a intel/ dir, probably better with INTEL_ prefix
> 
>>
>> then we can also think of creating library with common helpers for GuC
>> (for encoding/decoding HXG messages, preparing ADS, reading logs, etc)
> 
> with the other differences we have, I don't see much benefit,
> particularly as it won't change for i915 wrt supported platforms.

we are still using unified firmware versions across different platforms,
so any newer firmware version drops could still be beneficial for the
i915 and those legacy platforms

> 
>>
>> btw, we can also consider sharing register definitions:
>>
>> - drm/intel/include/regs
>>        xe_engine_regs.h
>>        xe_gt_regs.h
>>        xe_regs_defs.h
> 
> same as above, I don't think it's worth it as xe will keep adding to it
> and it doesn't care for all the previous platforms. For those files we
> may eventually autogen them like done by mesa.

autogen sounds promising, so lets wait and once this will happen we can
abandon xe/regs

> 
> Lucas De Marchi
> 
>>
>> Michal
>>
>>>
>>> Lucas De Marchi
>>>
>>>> ---
>>>> drivers/gpu/drm/xe/abi/guc_messages_abi.h | 2 +-
>>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/xe/abi/guc_messages_abi.h
>>>> b/drivers/gpu/drm/xe/abi/guc_messages_abi.h
>>>> index 3d199016cf88..c04606872e48 100644
>>>> --- a/drivers/gpu/drm/xe/abi/guc_messages_abi.h
>>>> +++ b/drivers/gpu/drm/xe/abi/guc_messages_abi.h
>>>> @@ -40,7 +40,7 @@
>>>>  */
>>>>
>>>> #define GUC_HXG_MSG_MIN_LEN            1u
>>>> -#define GUC_HXG_MSG_0_ORIGIN            (0x1 << 31)
>>>> +#define GUC_HXG_MSG_0_ORIGIN            (0x1U << 31)
>>>> #define   GUC_HXG_ORIGIN_HOST            0u
>>>> #define   GUC_HXG_ORIGIN_GUC            1u
>>>> #define GUC_HXG_MSG_0_TYPE            (0x7 << 28)
>>>> -- 
>>>> 2.42.0
>>>>

