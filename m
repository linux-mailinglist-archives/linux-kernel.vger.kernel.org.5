Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C8D782E48
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 18:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236585AbjHUQXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 12:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236522AbjHUQXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:23:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B94AED
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 09:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692634981; x=1724170981;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=O0pNsFU/G/Clw2QlAdEPiWlO2xLuv7a/zk/i6lTE4bM=;
  b=joh0joWFabNha1H8mySzllMht8hNNng2Aj1xgTywTlNqUVito1/+u0M1
   nn8s/r+T3XjvIeI+grTNiPQpiYC5e/OybqrN/k34TdIu7zPGLsLF9HWis
   8EHiheQVuBjbwSMeQEAdgDjRPwXawALr2d7WzIUaIpephEF61xYNmEzuz
   J8EY44E85oanj7vOVLpIZhzKrqWYzX2cDmgbh/LavfldvHc8Vyc7O9Md2
   zoCS5mQD/uUT6G4hTRIlCEyPlHMnEq81wneBkO8VXrfDgFlFiwangWXCD
   QED5QdAGY0B5uhdEKHOFpSCrY0EUyqTG62psoqcZR4ysMmgqdLqi/GsYh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="440015443"
X-IronPort-AV: E=Sophos;i="6.01,190,1684825200"; 
   d="scan'208";a="440015443"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 09:22:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="735879957"
X-IronPort-AV: E=Sophos;i="6.01,190,1684825200"; 
   d="scan'208";a="735879957"
Received: from hpabst-mobl.ger.corp.intel.com (HELO localhost) ([10.252.54.190])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 09:22:07 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     "Ricardo B. Marliere" <rbmarliere@gmail.com>,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        tvrtko.ursulin@linux.intel.com, airlied@gmail.com, daniel@ffwll.ch,
        daniele.ceraolospurio@intel.com, John.C.Harrison@Intel.com,
        alan.previn.teres.alexis@intel.com,
        harshit.m.mogalapalli@oracle.com, michal.wajdeczko@intel.com,
        gregkh@linuxfoundation.org
Cc:     "Ricardo B. Marliere" <rbmarliere@gmail.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH] gpu: drm: i915: fix documentation style
In-Reply-To: <20230821150241.40047-1-rbmarliere@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230821150241.40047-1-rbmarliere@gmail.com>
Date:   Mon, 21 Aug 2023 19:22:04 +0300
Message-ID: <87il9874cz.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Aug 2023, "Ricardo B. Marliere" <rbmarliere@gmail.com> wrote:
> This patch fixes the following sphinx warnings in the htmldocs make target:
>
> Documentation/gpu/i915:546: ./drivers/gpu/drm/i915/gt/uc/intel_huc.c:29: ERROR: Unexpected indentation.
> Documentation/gpu/i915:546: ./drivers/gpu/drm/i915/gt/uc/intel_huc.c:30: WARNING: Block quote ends without a blank line; unexpected unindent.
> Documentation/gpu/i915:546: ./drivers/gpu/drm/i915/gt/uc/intel_huc.c:35: WARNING: Bullet list ends without a blank line; unexpected unindent.
>
> Signed-off-by: Ricardo B. Marliere <rbmarliere@gmail.com>

Already fixed by commit 175b036472f6 ("drm/i915: fix Sphinx indentation
warning") in drm-next.

BR,
Jani.

> ---
>  drivers/gpu/drm/i915/gt/uc/intel_huc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/i915/gt/uc/intel_huc.c b/drivers/gpu/drm/i915/gt/uc/intel_huc.c
> index ddd146265beb..fa70defcb5b2 100644
> --- a/drivers/gpu/drm/i915/gt/uc/intel_huc.c
> +++ b/drivers/gpu/drm/i915/gt/uc/intel_huc.c
> @@ -26,6 +26,7 @@
>   * The kernel driver is only responsible for loading the HuC firmware and
>   * triggering its security authentication. This is done differently depending
>   * on the platform:
> + *
>   * - older platforms (from Gen9 to most Gen12s): the load is performed via DMA
>   *   and the authentication via GuC
>   * - DG2: load and authentication are both performed via GSC.
> @@ -33,6 +34,7 @@
>   *   not-DG2 older platforms), while the authentication is done in 2-steps,
>   *   a first auth for clear-media workloads via GuC and a second one for all
>   *   workloads via GSC.
> + *
>   * On platforms where the GuC does the authentication, to correctly do so the
>   * HuC binary must be loaded before the GuC one.
>   * Loading the HuC is optional; however, not using the HuC might negatively

-- 
Jani Nikula, Intel Open Source Graphics Center
