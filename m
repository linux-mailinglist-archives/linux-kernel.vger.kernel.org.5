Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0987FC183
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345909AbjK1O6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345857AbjK1O6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:58:48 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A23410C;
        Tue, 28 Nov 2023 06:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701183535; x=1732719535;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MmtHq2AXw3e0z60hXa4rJ0joKeClbwyrFO4/JVmK7So=;
  b=den1FrdvHvwJ1TmR4oA8E/48cIcrozJlqjewdrru04uweIIkljWdZn9m
   YsaxSs4PnzvMPH7HfprbqxTPMVyjhqSMlmRMwQCvsxVqWs1avM/+/eJNW
   jsjUCc58mlbwNiIsJtzAcnS6EZHXcdO0BIuNbYVP/mujo7OImevdAqQSh
   ff3aCHTenIiXAppeRW+z0eSe8+YCL5LKww5dDjEQ3MzFPQ45ViKHRcjg7
   NTaPrc62Gi8DwwJ6ssMhIwD3POS5dqWN7u+aOSziAh9Zpdh0+TOYoc6iK
   8m80dmGbM8gzerlodiDQtYpHtKhjgPiSrxvLWThsK+tQIeeIm03TNX01R
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="459442641"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="459442641"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 06:58:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="9971128"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 28 Nov 2023 06:58:48 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r7zXy-0007eq-14;
        Tue, 28 Nov 2023 14:58:46 +0000
Date:   Tue, 28 Nov 2023 22:57:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Maxime Ripard <mripard@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Emma Anholt <emma@anholt.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Sandy Huang <hjc@rock-chips.com>,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Hans Verkuil <hverkuil@xs4all.nl>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev,
        Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH v4 03/45] drm/tests: Add helper to create mock plane
Message-ID: <202311282223.mefGp1S5-lkp@intel.com>
References: <20231128-kms-hdmi-connector-state-v4-3-c7602158306e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128-kms-hdmi-connector-state-v4-3-c7602158306e@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-misc/drm-misc-next]
[also build test WARNING on sunxi/sunxi/for-next drm/drm-next linus/master v6.7-rc3 next-20231128]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Maxime-Ripard/drm-tests-helpers-Add-atomic-helpers/20231128-193409
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20231128-kms-hdmi-connector-state-v4-3-c7602158306e%40kernel.org
patch subject: [PATCH v4 03/45] drm/tests: Add helper to create mock plane
config: i386-buildonly-randconfig-002-20231128 (https://download.01.org/0day-ci/archive/20231128/202311282223.mefGp1S5-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231128/202311282223.mefGp1S5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311282223.mefGp1S5-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/tests/drm_kunit_helpers.c:290: warning: Function parameter or member 'num_formats' not described in 'drm_kunit_helper_create_primary_plane'
>> drivers/gpu/drm/tests/drm_kunit_helpers.c:290: warning: Excess function parameter 'format_count' description in 'drm_kunit_helper_create_primary_plane'


vim +290 drivers/gpu/drm/tests/drm_kunit_helpers.c

   257	
   258	/**
   259	 * drm_kunit_helper_create_primary_plane - Creates a mock primary plane for a KUnit test
   260	 * @test: The test context object
   261	 * @drm: The device to alloc the plane for
   262	 * @funcs: Callbacks for the new plane. Optional.
   263	 * @helper_funcs: Helpers callbacks for the new plane. Optional.
   264	 * @formats: array of supported formats (DRM_FORMAT\_\*). Optional.
   265	 * @format_count: number of elements in @formats
   266	 * @modifiers: array of struct drm_format modifiers terminated by
   267	 *             DRM_FORMAT_MOD_INVALID. Optional.
   268	 *
   269	 * This allocates and initializes a mock struct &drm_plane meant to be
   270	 * part of a mock device for a KUnit test.
   271	 *
   272	 * Resources will be cleaned up automatically.
   273	 *
   274	 * @funcs will default to the default helpers implementations.
   275	 * @helper_funcs will default to an empty implementation. @formats will
   276	 * default to XRGB8888 only. @modifiers will default to a linear
   277	 * modifier only.
   278	 *
   279	 * Returns:
   280	 * A pointer to the new plane, or an ERR_PTR() otherwise.
   281	 */
   282	struct drm_plane *
   283	drm_kunit_helper_create_primary_plane(struct kunit *test,
   284					      struct drm_device *drm,
   285					      const struct drm_plane_funcs *funcs,
   286					      const struct drm_plane_helper_funcs *helper_funcs,
   287					      const uint32_t *formats,
   288					      unsigned int num_formats,
   289					      const uint64_t *modifiers)
 > 290	{
   291		struct drm_plane *plane;
   292	
   293		if (!funcs)
   294			funcs = &default_plane_funcs;
   295	
   296		if (!helper_funcs)
   297			helper_funcs = &default_plane_helper_funcs;
   298	
   299		if (!formats || !num_formats) {
   300			formats = default_plane_formats;
   301			num_formats = ARRAY_SIZE(default_plane_formats);
   302		}
   303	
   304		if (!modifiers)
   305			modifiers = default_plane_modifiers;
   306	
   307		plane = __drmm_universal_plane_alloc(drm,
   308						     sizeof(struct drm_plane), 0,
   309						     0,
   310						     funcs,
   311						     formats,
   312						     num_formats,
   313						     default_plane_modifiers,
   314						     DRM_PLANE_TYPE_PRIMARY,
   315						     NULL);
   316		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, plane);
   317	
   318		drm_plane_helper_add(plane, helper_funcs);
   319	
   320		return plane;
   321	}
   322	EXPORT_SYMBOL_GPL(drm_kunit_helper_create_primary_plane);
   323	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
