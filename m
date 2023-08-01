Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0816B76AE86
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 11:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbjHAJjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 05:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbjHAJjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 05:39:16 -0400
Received: from mgamail.intel.com (unknown [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730814C18
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 02:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690882628; x=1722418628;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=cVFmk5CKy6gTo0w9aV0IK8bC22Agg5xvhy/Cu1YAVQE=;
  b=M3t69ejvNsRQSdeTGxvHXiCD+ThXlBdNlDqn9DVJdlmSH6WJGivzd6w2
   5lcRqscu4lT/xWFkVkGyiq7721lr3kwLYX6x3cp4DwBIkrBKOR5c2nTiq
   lWGnnavYbtezPQ49dGRIovFDMDsIigZvn3J2TsKxqq765mpRiC8Z2XwMK
   LntjCgu+gcySF30BD+2AzSRau9/1/HU1JQnKNGk2gOQoCD8s4KzyrqTVZ
   +qgYQS/9sOXU0yrXJnWYkB2RSA50h3fkOVV/ktkLJoEmP9nczE6P/hClB
   SkBla2Cx21Ne4KWPIfFhDqdvjbbcvREQiVoDsfDEC5iRzXGOhakv/iTnY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="368149823"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; 
   d="scan'208";a="368149823"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 02:36:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="722428493"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; 
   d="scan'208";a="722428493"
Received: from igorban-mobl1.ccr.corp.intel.com (HELO localhost) ([10.252.36.188])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 02:36:49 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Ran Sun <sunran001@208suo.com>, alexander.deucher@amd.com,
        airlied@gmail.com, daniel@ffwll.ch
Cc:     Ran Sun <sunran001@208suo.com>, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/amd: Clean up errors in processpptables.c
In-Reply-To: <20230801091425.7181-1-sunran001@208suo.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230801091425.7181-1-sunran001@208suo.com>
Date:   Tue, 01 Aug 2023 12:36:47 +0300
Message-ID: <87leevw1cg.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Aug 2023, Ran Sun <sunran001@208suo.com> wrote:
> Fix the following errors reported by checkpatch:
>
> ERROR: open brace '{' following function definitions go on the next line
> ERROR: code indent should use tabs where possible
> ERROR: space required before the open parenthesis '('

The commit message does not match the patch.

>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
> index 1866fe20f9e2..f05f011c78be 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
> @@ -676,7 +676,7 @@ static PP_StateClassificationFlags make_classification_flags(
>  static int init_non_clock_fields(struct pp_hwmgr *hwmgr,
>  						struct pp_power_state *ps,
>  							    uint8_t version,
> -			 const ATOM_PPLIB_NONCLOCK_INFO *pnon_clock_info) 
> +			 const ATOM_PPLIB_NONCLOCK_INFO *pnon_clock_info)

How about fixing *all* the style problems in the above in one go?

How about sending these fixes in a threaded series instead of filling
everyone's inboxes with individual patches? It's 30+ patches just today
already.


BR,
Jani.

>  {
>  	unsigned long rrr_index;
>  	unsigned long tmp;

-- 
Jani Nikula, Intel Open Source Graphics Center
