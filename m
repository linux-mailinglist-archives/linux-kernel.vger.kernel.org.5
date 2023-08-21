Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D338B7835E4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 00:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbjHUWoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 18:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHUWoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 18:44:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6444F11C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 15:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692657840; x=1724193840;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=eUcLYc0J7HowPfeJ9TjzTc9ALeAmarKJjBj1No+r/5M=;
  b=dkJ53OgkMx8BUXiRTXdT3T1ZiReZc825FrcvwhI3J5prmZx5m/bbAlKZ
   reIkIAY+uOExzPeB/041SrEoQwnjmMTbcII9SeNrXN/oTlG0imMeiIjgy
   qBvNmreXuC8JPkJVRdLQinVPIxTmj87aKit4gLQvF30Svfe+wE6dpeOxF
   eJYHKuwfCO0guZhvPxkKNTU5uoulLlZgmU3aWTaX+MBTfPfSTltYtDmTf
   5mkinWS6UeonBE3onlHf0WxQVw+lPePVEA5Xuj3bj4B6cbBpA+TMe+B2T
   ippDOGIPJ9pnn2xsei/EpPlwV8WX2YowZJRQ13nUcwMVh6fR3+RqnaFAR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="358702727"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="358702727"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 15:44:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="859659922"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="859659922"
Received: from hpabst-mobl.ger.corp.intel.com (HELO localhost) ([10.252.54.190])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 15:43:55 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Nikita B <n2h9z4@gmail.com>, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        airlied@gmail.com, daniel@ffwll.ch,
        daniele.ceraolospurio@intel.com, John.C.Harrison@Intel.com,
        alan.previn.teres.alexis@intel.com, gregkh@linuxfoundation.org,
        harshit.m.mogalapalli@oracle.com, michal.wajdeczko@intel.com,
        skhan@linuxfoundation.org
Cc:     Nikita B <n2h9z4@gmail.com>, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] drivers: gpu: drm: i915: intel_huc: fix formatting
 warnings
In-Reply-To: <20230821192718.504357-1-n2h9z4@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230821192718.504357-1-n2h9z4@gmail.com>
Date:   Tue, 22 Aug 2023 01:43:52 +0300
Message-ID: <87fs4c6mon.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Aug 2023, Nikita B <n2h9z4@gmail.com> wrote:
> Fix formatting warnings when run "make htmldocs":
> ./drivers/gpu/drm/i915/gt/uc/intel_huc.c:29: WARNING: Unexpected indentation.
> ./drivers/gpu/drm/i915/gt/uc/intel_huc.c:30: WARNING: Block quote ends without a blank line; unexpected unindent.
> ./drivers/gpu/drm/i915/gt/uc/intel_huc.c:35: WARNING: Bullet list ends without a blank line; unexpected unindent.
>
> Signed-off-by: Nikita B <n2h9z4@gmail.com>

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
