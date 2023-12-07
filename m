Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5188085FC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378715AbjLGKJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 05:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbjLGKJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 05:09:36 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D25A4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 02:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701943782; x=1733479782;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=stqB4Md+ZZOYLCgF6qapx4pmRrG6lHUghmboWy8jyL4=;
  b=nXDrK/ZffGtlFrRQSDToBFvoH6v7MXYWLzrOro7xKYBi0s6FKVAv7wGn
   M6QC01Nn+t26CNgR9Zz4VXaEq6gxCK8LCj6uWQip9/q5hVPz8fJFC/aEL
   TwKMNk6qTvLbPnciNWdT/mb9/a73NeswRIjIhmNE+J+rirrGwyLBuC6s/
   MAIauDWN+VvSVqXO4/t+fcefkoJlRzcfZCnIoIaJK40fv/pTtl4dIh7Ax
   w8koCdCaJz0/bM/QDTMQ/+SnPIBNFG3aVtC5Wp0L3zt8xHIgy08jAMhlo
   OOUUW8V1EIxlapzlkNmbYuk2xYj1m+NK4JWUf6g7w5r3z08aUlgExt17E
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="1313255"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="1313255"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 02:09:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="800685910"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="800685910"
Received: from mrehana-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.62.169])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 02:09:39 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>
Subject: Re: [PATCH] drm/debugfs: drop unneeded DEBUG_FS guard
In-Reply-To: <20231206150201.669055-1-dario.binacchi@amarulasolutions.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20231206150201.669055-1-dario.binacchi@amarulasolutions.com>
Date:   Thu, 07 Dec 2023 12:09:36 +0200
Message-ID: <87cyvi1fz3.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Dec 2023, Dario Binacchi <dario.binacchi@amarulasolutions.com> wrote:
> The Makefile enables/disables the file compilation depending on
> CONFIG_DEBUG_FS.
>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

> ---
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
