Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07FC87BA22B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjJEPSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233137AbjJEPRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:17:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F17B6C9;
        Thu,  5 Oct 2023 07:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696517044; x=1728053044;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=cwMMzUWf9bNC4gOrY9JBethMndsYDf5WuH5DgSe2mv4=;
  b=gW/jr232bjhbJkxIJWS+E18VY4lRLfXBIcnbXxbhXkxBCDjzzSRmvy99
   B52LibcF/gL6OFXzsPa+6Wu+XpjThe8/xCDwaucHSiOSARqgobtk9i9+1
   KHn9ja2gvjeCFZWvVHiGjIv1G2fGtr5kadcepfra0X7m6lLBD0y74yMxd
   F+xiJu1sr0ihWzA7KgATk0G5NrbaTQ1srVo0ogc2m0O3NkfHskdDDHrCJ
   nUt+TtLs/Kn449w20jNjQmxJbn8twnvk3taEjpqNskXDtxI/UXtfG/Mj8
   Q1fShUnR7IChNA1JVr/cFXH4vyv//STH/3ddBhq6lI6ix8/FWYwpvW2W3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="363797254"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="363797254"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 07:41:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="745471600"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="745471600"
Received: from jnikula-mobl4.fi.intel.com (HELO localhost) ([10.237.66.162])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 07:41:32 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Dave Airlie <airlied@redhat.com>
Cc:     Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Matt Roper <matthew.d.roper@intel.com>
Subject: Re: linux-next: manual merge of the drm-intel tree with the drm tree
In-Reply-To: <20231003110957.34fc9483@canb.auug.org.au>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20231003110957.34fc9483@canb.auug.org.au>
Date:   Thu, 05 Oct 2023 17:41:28 +0300
Message-ID: <87zg0xb087.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Oct 2023, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi all,
>
> Today's linux-next merge of the drm-intel tree got a conflict in:
>
>   drivers/gpu/drm/i915/i915_drv.h
>
> between commits:
>
>   c9517783060a ("drm/i915/dg2: Drop Wa_16011777198")
>   5a213086a025 ("drm/i915: Eliminate IS_MTL_GRAPHICS_STEP")
>   81af8abe6513 ("drm/i915: Eliminate IS_MTL_MEDIA_STEP")
>
> from the drm tree and commits:
>
>   e50086f3d313 ("drm/i915/dg2: Drop pre-production display workarounds")
>   213454b3af2e ("drm/i915: Eliminate IS_MTL_DISPLAY_STEP")
>
> from the drm-intel tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Should be fixed now.

BR,
Jani.


-- 
Jani Nikula, Intel
