Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2DE7AD7E1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 14:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbjIYMVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 08:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjIYMVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 08:21:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667B0103;
        Mon, 25 Sep 2023 05:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695644454; x=1727180454;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DuowFPWx8WzqGKtlSQ1LLSC/9eNAA11N0z3LCFyNJPw=;
  b=ff+IftKAhdGpIZBjye12W7HsazMjN6ZE/3buBQWYO5jQxeTvk3Iy6cr0
   wAK4IFydmdybFdzSbZ0t9BJNqnL2+xTE+WsDnKrAmtrkDHd3pqc90JqOM
   kCJPZHcaUy07RSEQvzUj7pOekdfdMcZk67ceczGmpkaS4X0XA8WHL2eUU
   qDcyISSgBwAeGXf9329VpNbM9VzbgicITJ3efoQZOji2BOqNJjb2KLRTN
   7MVCsdJeyv8iQrNM/tfpba72A8qwDUUZDDE5iXXAGchiAh1xFk/9RIaC5
   kusFKfhog2H7DwqWJ+KHAe3bHIohQyMnPT6ycTZqZ2J+nSZH/y+b379Cj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="383996632"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="383996632"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 05:20:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="748329775"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="748329775"
Received: from nurqayrx-mobl2.gar.corp.intel.com (HELO intel.com) ([10.213.34.118])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 05:20:19 -0700
Date:   Mon, 25 Sep 2023 14:20:13 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     David Airlie <airlied@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        John Harrison <john.c.harrison@intel.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Matthew Brost <matthew.brost@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Emma Anholt <emma@anholt.net>, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-15?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Kevin Wang <kevin1.wang@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Zack Rusin <zackr@vmware.com>,
        VMware Graphics Reviewers 
        <linux-graphics-maintainer@vmware.com>,
        Melissa Wen <mwen@igalia.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Le Ma <le.ma@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>,
        Yifan Zhang <yifan1.zhang@amd.com>,
        Prike Liang <Prike.Liang@amd.com>, Lang Yu <Lang.Yu@amd.com>,
        Tejas Upadhyay <tejas.upadhyay@intel.com>,
        Nirmoy Das <nirmoy.das@intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        nouveau@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 3/9] drm/i915/selftests: Annotate struct perf_series with
 __counted_by
Message-ID: <ZRF6/VBgVvgl6lpn@ashyti-mobl2.lan>
References: <20230922173110.work.084-kees@kernel.org>
 <20230922173216.3823169-3-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922173216.3823169-3-keescook@chromium.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

On Fri, Sep 22, 2023 at 10:32:08AM -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct perf_series.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: John Harrison <john.c.harrison@Intel.com>
> Cc: Andi Shyti <andi.shyti@linux.intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: intel-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com> 

Thanks,
Andi
