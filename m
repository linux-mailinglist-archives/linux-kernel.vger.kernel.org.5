Return-Path: <linux-kernel+bounces-14505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FE7821E0B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 15:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C89E283861
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E0512E56;
	Tue,  2 Jan 2024 14:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ioPL8PoF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE3D125D2
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 14:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704206938; x=1735742938;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=V51w5K1EQfkD+FE5AxSfH4Xycasu1bgRbde+rYFFCpc=;
  b=ioPL8PoFA8ax63ldzFSh8GYySPHOt0Ut1zeq6aFVGt8VF3G2UnccTLRA
   ZqOQU8gD3ddJPOVtIL5KbX3TOQtn+A5NTv0kUtl02STqqEGSAKgGv0nmD
   L0LJddL454G6zU8djiMvopWTv1QohM7FdK0d9zlmQDvssYkEO7MFc3rac
   t0Y40m9gOHDMbakwwH0tF3THFouPuRydZaEZXXJGViEbNrTwtRdZPShs8
   h6dRdwxFfHGRks1SrmxCWkKd/Ug7TGi8pkEndHPIOphjQpNwlZYluKfPV
   asXwdtPhD7pQwy5Vh3eVUCVWbb3HNi6AYwtSjmJseOqr7aGBaJsKLqpJz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="4223299"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="4223299"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 06:48:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="952942909"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="952942909"
Received: from dmaryin-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.35.224])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 06:48:53 -0800
From: Jani Nikula <jani.nikula@intel.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 linux-kernel@vger.kernel.org
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>, Daniel Vetter
 <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2] drm/debugfs: drop unneeded DEBUG_FS guard
In-Reply-To: <20231223183301.78332-1-dario.binacchi@amarulasolutions.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20231223183301.78332-1-dario.binacchi@amarulasolutions.com>
Date: Tue, 02 Jan 2024 16:48:42 +0200
Message-ID: <87sf3f23lh.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, 23 Dec 2023, Dario Binacchi <dario.binacchi@amarulasolutions.com> wrote:
> The Makefile enables/disables the file compilation depending on
> CONFIG_DEBUG_FS.
>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> Reviewed-by: Jani Nikula <jani.nikula@intel.com>

Thanks for the patch, pushed to drm-misc-next.

BR,
Jani.

>
> ---
>
> Changes in v2:
> - Add 'Reviewed-by' tag of Jani Nikula
>
>  drivers/gpu/drm/drm_debugfs.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_debugfs.c b/drivers/gpu/drm/drm_debugfs.c
> index f291fb4b359f..f80d9cf3e71a 100644
> --- a/drivers/gpu/drm/drm_debugfs.c
> +++ b/drivers/gpu/drm/drm_debugfs.c
> @@ -45,8 +45,6 @@
>  #include "drm_crtc_internal.h"
>  #include "drm_internal.h"
>  
> -#if defined(CONFIG_DEBUG_FS)
> -
>  /***************************************************
>   * Initialization, etc.
>   **************************************************/
> @@ -588,5 +586,3 @@ void drm_debugfs_crtc_remove(struct drm_crtc *crtc)
>  	debugfs_remove_recursive(crtc->debugfs_entry);
>  	crtc->debugfs_entry = NULL;
>  }
> -
> -#endif /* CONFIG_DEBUG_FS */

-- 
Jani Nikula, Intel

