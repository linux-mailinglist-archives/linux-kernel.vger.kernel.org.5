Return-Path: <linux-kernel+bounces-20105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 147EB827953
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 21:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 085C01C212BF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 20:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0C45577A;
	Mon,  8 Jan 2024 20:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sacmy2fi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340C355E50;
	Mon,  8 Jan 2024 20:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704746815; x=1736282815;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ysxA/zp0hOOuWwajvTnchvlZ9+DORxFTUedJeEkkADQ=;
  b=Sacmy2fivxBIZDU1UXb1e1TWl08KScxegUMq5oIk8q4BBNkmg/5yPIrt
   UfJjVQ+nsTJ3gD9eMpv+MYBIz0iWRWS33ze9bZcbV9RAMOMA5FTmAbpnl
   BRt77Mi7Odi5FTVDzsx3F6ypFlhslYSjbKLC/lMNblebPnlBGkOjt6pw2
   uakQb5Wh2lMf9XlP2LrqxJzNEJbWxfg6a/VWGh12c8zz2sk4+iZP6i8o/
   ZOdtfdkWIWqIVFelP/exXC9oVzNHBbByOYroOZNrJxFnUMaIuNKvAYS/i
   QBXgQFd+TRvdcTzMVILIBezaLeHzgOQkD173hz2dJZjyey+ebWMRDQS8o
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="5085374"
X-IronPort-AV: E=Sophos;i="6.04,180,1695711600"; 
   d="scan'208";a="5085374"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 12:46:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="781543260"
X-IronPort-AV: E=Sophos;i="6.04,180,1695711600"; 
   d="scan'208";a="781543260"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga002.jf.intel.com with ESMTP; 08 Jan 2024 12:46:50 -0800
Received: from [10.249.149.159] (mwajdecz-MOBL.ger.corp.intel.com [10.249.149.159])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 6E90728165;
	Mon,  8 Jan 2024 20:46:49 +0000 (GMT)
Message-ID: <84a5c289-e2f6-4e30-a093-5a1c5b335057@intel.com>
Date: Mon, 8 Jan 2024 21:46:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/xe: clean up type of GUC_HXG_MSG_0_ORIGIN
Content-Language: en-US
To: Lucas De Marchi <lucas.demarchi@intel.com>,
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, intel-xe@lists.freedesktop.org
References: <ec22d742-632b-426a-ac86-62641a38c907@moroto.mountain>
 <e5g3qkwvc3sjfpxcdvn43fiwbxthpblqgg2getxpbkd6g4lp5k@pgfm75tsg7wz>
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
In-Reply-To: <e5g3qkwvc3sjfpxcdvn43fiwbxthpblqgg2getxpbkd6g4lp5k@pgfm75tsg7wz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 08.01.2024 15:07, Lucas De Marchi wrote:
> On Mon, Jan 08, 2024 at 12:05:57PM +0300, Dan Carpenter wrote:
>> The GUC_HXG_MSG_0_ORIGIN definition should be unsigned.  Currently it is
>> defined as INT_MIN.  This doesn't cause a problem currently but it's
>> still worth cleaning up.
>>
>> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> 
> it seems there are a few more places to change to follow what was done
> in commit 962bd34bb457 ("drm/i915/uc: Fix undefined behavior due to
> shift overflowing the constant").
> 
> +Michal
> 
> Could we eventually share these abi includes with i915 so we don't
> keep fixing the same thing in 2 places?

it should be possible and I guess we should plan for that while
discussing all this new xe driver...

anyway, what about creating new intel/ folder under drm/ ?

 - drm/intel/include/abi
        guc_actions_abi.h
        guc_klvs_abi.h
        ...

the only question would be what prefix should be used for macros:
just GUC_ or INTEL_GUC_ or XE_GUC_ ?

then we can also think of creating library with common helpers for GuC
(for encoding/decoding HXG messages, preparing ADS, reading logs, etc)

btw, we can also consider sharing register definitions:

 - drm/intel/include/regs
        xe_engine_regs.h
        xe_gt_regs.h
        xe_regs_defs.h

Michal

> 
> Lucas De Marchi
> 
>> ---
>> drivers/gpu/drm/xe/abi/guc_messages_abi.h | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/xe/abi/guc_messages_abi.h
>> b/drivers/gpu/drm/xe/abi/guc_messages_abi.h
>> index 3d199016cf88..c04606872e48 100644
>> --- a/drivers/gpu/drm/xe/abi/guc_messages_abi.h
>> +++ b/drivers/gpu/drm/xe/abi/guc_messages_abi.h
>> @@ -40,7 +40,7 @@
>>  */
>>
>> #define GUC_HXG_MSG_MIN_LEN            1u
>> -#define GUC_HXG_MSG_0_ORIGIN            (0x1 << 31)
>> +#define GUC_HXG_MSG_0_ORIGIN            (0x1U << 31)
>> #define   GUC_HXG_ORIGIN_HOST            0u
>> #define   GUC_HXG_ORIGIN_GUC            1u
>> #define GUC_HXG_MSG_0_TYPE            (0x7 << 28)
>> -- 
>> 2.42.0
>>

