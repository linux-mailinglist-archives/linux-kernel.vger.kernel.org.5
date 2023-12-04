Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9382F802FED
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 11:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234818AbjLDKPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 05:15:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbjLDKPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 05:15:40 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61AEACC
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 02:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701684946; x=1733220946;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=3LL6k+xYYDgowjrfDhwIvyPlTGYLhMGk56IZFFTZXgI=;
  b=WEQlUnOWQLhArpNQY8FNYGmpqVWgJ/kvFsmOYm4L3zxxrmL2+XIn8KJ+
   2HAtuT19BREnFU9IidvmnwhHrXaqEMxu/FsnJ9hkOPgH1r5ptPBvpqrWY
   bBR72HflNa16Zerfqp/drX/SgouddqztmhjUFxs8kEy/T67s5Ydnhl54u
   3aq7/jXn60SjhpJ2dxEqjB+lpi/OWEhrWwXmP9HeT9AfJWBqX30wK+TQK
   Oq95OuxvkDrtTe8AM9u4dwY/yNX7Diwa/T0DVFqol00pUa2VwdPHiRofy
   EDQzODAFdoHQ55BGQNVUz6H7k/ejHasrt8HJBuAUUwYUX+SFEehN3wYzT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="390871261"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="390871261"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 02:15:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="861329877"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="861329877"
Received: from shahmoha-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.45.180])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 02:15:42 -0800
From:   Jani Nikula <jani.nikula@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] drm/i915/display: Don't use "proxy" headers
In-Reply-To: <20231129140129.699767-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20231129140129.699767-1-andriy.shevchenko@linux.intel.com>
Date:   Mon, 04 Dec 2023 12:15:39 +0200
Message-ID: <87r0k22rzo.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2023, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wr=
ote:
> The driver uses math.h and not util_macros.h.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks, pushed to drm-intel-next.

BR,
Jani.

> ---
>  drivers/gpu/drm/i915/display/intel_snps_phy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_snps_phy.c b/drivers/gpu/=
drm/i915/display/intel_snps_phy.c
> index ce5a73a4cc89..bc61e736f9b3 100644
> --- a/drivers/gpu/drm/i915/display/intel_snps_phy.c
> +++ b/drivers/gpu/drm/i915/display/intel_snps_phy.c
> @@ -3,7 +3,7 @@
>   * Copyright =C2=A9 2019 Intel Corporation
>   */
>=20=20
> -#include <linux/util_macros.h>
> +#include <linux/math.h>
>=20=20
>  #include "i915_reg.h"
>  #include "intel_ddi.h"

--=20
Jani Nikula, Intel
