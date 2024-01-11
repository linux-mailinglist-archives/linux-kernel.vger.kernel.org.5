Return-Path: <linux-kernel+bounces-23347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F2E82AB6E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E89FB21FC0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991F3125B5;
	Thu, 11 Jan 2024 09:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZA+PisjR"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7160811194
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 09:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704967134; x=1736503134;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=eAPK3YkWDsGD+tLUM4iln5sX6YLes8N2a44CKmlPzg4=;
  b=ZA+PisjRu/7t9DX/HSFVjD+wgo/u8/njBd52GCzo3QCou4kwEv7I2PK6
   Zz9n7Cbtgvnhyed5K1ly9c+rUL1YNWTkuqLOVsjHvPPiUNE6dUh2WdO6n
   pI8GGytVXpc1uRxoCnUkAhkXH7wIG5yqZHLQe0ohhDgyQ0ydcL2RhL5a8
   YWddUSHtsr809Dw9AVECbLwXdpPcFbe8MasZNjvFo/7VCc+zmJ735tsAN
   SeR35EMEgGCLD6Dvotag1rOMIybdiFvfJ5NXwPjFQ0CTHsdiuKDFzpVnf
   k5UsTFra6SzvzWfNl4wkdQd35ANUXRz7u0kCxqzC0RCfzROpesa0dunYB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="463087931"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="463087931"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 01:58:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="925949261"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="925949261"
Received: from gaertgee-mobl.ger.corp.intel.com (HELO localhost) ([10.252.54.206])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 01:58:49 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: chenxuebing <chenxb_99091@126.com>, airlied@gmail.com,
 tzimmermann@suse.de, daniel@ffwll.ch, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 chenxuebing <chenxb_99091@126.com>
Subject: Re: [PATCH] drm: Clean up errors in drm_dp_helper.h
In-Reply-To: <20240111064400.8878-1-chenxb_99091@126.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240111064400.8878-1-chenxb_99091@126.com>
Date: Thu, 11 Jan 2024 11:58:47 +0200
Message-ID: <878r4wur6w.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 11 Jan 2024, chenxuebing <chenxb_99091@126.com> wrote:
> Fix the following errors reported by checkpatch:
>
> ERROR: space prohibited before open square bracket '['

Nah, checkpatch just isn't clever enough to realize it's within a macro.

BR,
Jani.

>
> Signed-off-by: chenxuebing <chenxb_99091@126.com>
> ---
>  drivers/gpu/drm/display/drm_dp_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
> index b1ca3a1100da..2704bf703040 100644
> --- a/drivers/gpu/drm/display/drm_dp_helper.c
> +++ b/drivers/gpu/drm/display/drm_dp_helper.c
> @@ -2133,7 +2133,7 @@ void drm_dp_aux_unregister(struct drm_dp_aux *aux)
>  }
>  EXPORT_SYMBOL(drm_dp_aux_unregister);
>  
> -#define PSR_SETUP_TIME(x) [DP_PSR_SETUP_TIME_ ## x >> DP_PSR_SETUP_TIME_SHIFT] = (x)
> +#define PSR_SETUP_TIME(x)[DP_PSR_SETUP_TIME_ ## x >> DP_PSR_SETUP_TIME_SHIFT] = (x)
>  
>  /**
>   * drm_dp_psr_setup_time() - PSR setup in time usec

-- 
Jani Nikula, Intel

