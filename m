Return-Path: <linux-kernel+bounces-23730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE5E82B0ED
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 551E51C23CE9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 14:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D730448CED;
	Thu, 11 Jan 2024 14:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kFw4PfmZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C8715E96
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 14:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704984614; x=1736520614;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=9XuexC1XqjTh3u+4RiixelWH3d7w3t5hO26lXRAs1QM=;
  b=kFw4PfmZJeP6ckO3BSBG3G3X4Iz1W7JMbSDHlZ6ao8xDRV0cgbQ0ukb9
   DM7V2a16O2BWTSzR5gBFhNsJR/U7+52vWxSmxJ0Nrc1lh+voVy0SThE7q
   TCHec9rwdoKGulrV6TuxWtIhuXOpZkghyOwHcHph7eYfnQhBYCwGbpUQz
   kR3SfNe89MxkQuncbOuPkQB0vsQ6yth3xyDe1nAu+XZ6txy8TK6QsnIb6
   CuKIvQ+RwjFceNEJenTfgkPeKjL+Z7Bx0SFmic/3xTGjS7ewEDg0HoPVJ
   o1lVMcWPo66oJdt2lIdvdxuvlSzqcazUvS5LZG+eabo7QnRKkc9kPVKer
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="397740992"
X-IronPort-AV: E=Sophos;i="6.04,186,1695711600"; 
   d="scan'208";a="397740992"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 06:50:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="775633954"
X-IronPort-AV: E=Sophos;i="6.04,186,1695711600"; 
   d="scan'208";a="775633954"
Received: from unknown (HELO localhost) ([10.237.66.162])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 06:50:09 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: chenxuebing <chenxb_99091@126.com>, daniel@ffwll.ch, airlied@gmail.com,
 mripard@kernel.org, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 chenxuebing <chenxb_99091@126.com>
Subject: Re: [PATCH] drm/edid: Clean up errors in drm_edid.h
In-Reply-To: <8734v4ur1g.fsf@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240111063921.8701-1-chenxb_99091@126.com>
 <8734v4ur1g.fsf@intel.com>
Date: Thu, 11 Jan 2024 16:50:05 +0200
Message-ID: <87r0inudpe.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 11 Jan 2024, Jani Nikula <jani.nikula@linux.intel.com> wrote:
> On Thu, 11 Jan 2024, chenxuebing <chenxb_99091@126.com> wrote:
>> Fix the following errors reported by checkpatch:
>>
>> ERROR: do not use assignment in if condition
>>
>> Signed-off-by: chenxuebing <chenxb_99091@126.com>
>
> Reviewed-by: Jani Nikula <jani.nikula@intel.com>

And pushed to drm-misc-next, thanks for the patch.

BR,
Jani.

>
>> ---
>>  drivers/gpu/drm/drm_edid.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
>> index 69c68804023f..9bcaf76f10fc 100644
>> --- a/drivers/gpu/drm/drm_edid.c
>> +++ b/drivers/gpu/drm/drm_edid.c
>> @@ -3611,7 +3611,8 @@ static bool mode_in_range(const struct drm_display_mode *mode,
>>  	if (!mode_in_vsync_range(mode, edid, t))
>>  		return false;
>>  
>> -	if ((max_clock = range_pixel_clock(edid, t)))
>> +	max_clock = range_pixel_clock(edid, t);
>> +	if (max_clock)
>>  		if (mode->clock > max_clock)
>>  			return false;

-- 
Jani Nikula, Intel

