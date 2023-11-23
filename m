Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4BB87F5D88
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 12:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344965AbjKWLOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 06:14:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344939AbjKWLOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 06:14:22 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854891AE;
        Thu, 23 Nov 2023 03:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700738070; x=1732274070;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f96XyUr097Mm9GcRMiQP6oB3PyFc743sh+fNU1O5iBY=;
  b=SH6nd9tbLVou+llhBqehsRZpAaqM6nQk1MASy9OVdBKyLAYp8VoCDkLg
   vFsYk9p2WNfWrTdE7a4/VPvNhUttjQW/pl79X/fcwwFTUrZIS9Bgn5kp7
   9EpcYBsKZvgvk+DMjTLlbT26hxudHeEM2QHKu9g7veEgekEGavdRId2UV
   HO/tkqv64ma/3YEAjfnon8hoaruw/9R22UN0V02SyGwRmT4zjgE0beck4
   fSGzUwThKq4rBToaLKHV49xD/gJ5T6QgXjimcGWuQXPVPBGfHs3ASlJZq
   wWZ5eCRyeJSbRgqEPiYw2BVUQRwBq/lhV3mJb7M0Iu6c5o/EMdgq5OQaK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="5439201"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="5439201"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 03:14:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="890762366"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="890762366"
Received: from amongesa-mobl.ger.corp.intel.com (HELO intel.com) ([10.252.57.132])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 03:14:24 -0800
Date:   Thu, 23 Nov 2023 12:14:21 +0100
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Wolfram Sang <wsa@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jani Nikula <jani.nikula@intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-i2c@vger.kernel.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@gmail.com>
Subject: Re: [Intel-gfx] [PATCH v5 15/20] drivers/gpu/drm/i915/display:
 remove I2C_CLASS_DDC support
Message-ID: <ZV80DQqQthCLMX2P@ashyti-mobl2.lan>
References: <20231123094040.592-1-hkallweit1@gmail.com>
 <20231123094040.592-16-hkallweit1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123094040.592-16-hkallweit1@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiner,

On Thu, Nov 23, 2023 at 10:40:35AM +0100, Heiner Kallweit wrote:
> After removal of the legacy EEPROM driver and I2C_CLASS_DDC support in
> olpc_dcon there's no i2c client driver left supporting I2C_CLASS_DDC.
> Class-based device auto-detection is a legacy mechanism and shouldn't
> be used in new code. So we can remove this class completely now.
> 
> Preferably this series should be applied via the i2c tree.
> 
> Acked-by: Jani Nikula <jani.nikula@intel.com>
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Thanks,
Andi
