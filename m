Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0667DEBB7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 05:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348446AbjKBEPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 00:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348417AbjKBEPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 00:15:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC3EE7
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 21:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698898533; x=1730434533;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pW7IEzkHLClJbmSBnBXg6mayrfNDlf19EbAfy1ucljc=;
  b=klaXcZ5pKJPOtqad6FY/FByqrc0zktJH7/i60IfmAaJmLaNqiBqGoUDm
   t/8z0ZxrWxF30td3Z1Cv3ltTK/VBKpxxz0flu5G7i8cmUWWklkbzgCgdr
   VBgYhrXfL1zaKE0zaA6LPSSizUJYQNf/CnMnxuRHNYorr73zOZzpz6Rxh
   TwCqo8CO6DFK1uWWkPJddAjr2sq1gzO3bKqGH/gprPUkLq547y1rTc4sK
   J+AkLHmDdRoZs1yYhaAABiXtORZ9hI0S3X+ZC2pmfXASZRhyAIRm9a6hZ
   GsVrynory/Ukdppd0Ck17FDrAxq5vj3nO15CgyOITN94vxcdMO4JwkbrP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="452930171"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; 
   d="scan'208";a="452930171"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 21:15:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; 
   d="scan'208";a="2404053"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 01 Nov 2023 21:15:29 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qyP79-00016M-1Q;
        Thu, 02 Nov 2023 04:15:27 +0000
Date:   Thu, 2 Nov 2023 12:14:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] drm/panel-edp: Choose correct preferred mode
Message-ID: <202311021208.ekIThlkq-lkp@intel.com>
References: <20231101212604.1636517-4-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101212604.1636517-4-hsinyi@chromium.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hsin-Yi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-misc/drm-misc-next]
[cannot apply to linus/master v6.6 next-20231101]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hsin-Yi-Wang/drm-panel-edp-Add-several-generic-edp-panels/20231102-053007
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20231101212604.1636517-4-hsinyi%40chromium.org
patch subject: [PATCH 3/3] drm/panel-edp: Choose correct preferred mode
config: arc-randconfig-001-20231102 (https://download.01.org/0day-ci/archive/20231102/202311021208.ekIThlkq-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231102/202311021208.ekIThlkq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311021208.ekIThlkq-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/drm_modes.c:1944: warning: expecting prototype for drm_mode_unset_preferred(). Prototype was for drm_mode_unset_preferred_modes() instead


vim +1944 drivers/gpu/drm/drm_modes.c

  1935	
  1936	/**
  1937	 * drm_mode_unset_preferred - clear the preferred status on existing modes.
  1938	 * @connector: the connector to update
  1939	 *
  1940	 * Walk the mode list for connector, clearing the preferred status on existing
  1941	 * modes.
  1942	 */
  1943	void drm_mode_unset_preferred_modes(struct drm_connector *connector)
> 1944	{
  1945		struct drm_display_mode *cur_mode;
  1946	
  1947		list_for_each_entry(cur_mode, &connector->probed_modes, head)
  1948			cur_mode->type &= ~DRM_MODE_TYPE_PREFERRED;
  1949	}
  1950	EXPORT_SYMBOL_GPL(drm_mode_unset_preferred_modes);
  1951	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
