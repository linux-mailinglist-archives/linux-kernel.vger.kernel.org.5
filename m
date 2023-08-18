Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBAB7802C9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 02:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356752AbjHRAmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 20:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356755AbjHRAmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 20:42:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDA42D67
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 17:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692319324; x=1723855324;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=b00AF8wncw5hmRSIEfWdL9qxZxQfAxmAv+k1mhiZAzM=;
  b=E6D9EcxwMFK4EsQKvGPDEQwZelNHH0E1jrbeDh9E7WVmPBJQDj5NChcQ
   7uYJV6JcLwbVxc3Jj7Ug2PYWfiZC6bHeh9ZyetD+4BgH96b6IqHL0iI5c
   Hu3IKx8IK+3lYPrRvo9jNsWfX4IYIoEhyaloS7MD2nRPQXvp6b4vOrF29
   OHPExqUSodj+B2xZNjjvScN/+rnsKHaoJgQeC79WlYPASG+mp7pSmvqXg
   bRldixADTHy7qM8dZhyHpreqnmaAnl7wteUWl5EughzuWlWlF31/9OwcK
   kr+psBTpGNZiDRzFGa+ZdU5sOb5yZQHIFJbtXQzN4AmaciHo+6xFyQbK4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="375754301"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="375754301"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 17:42:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="684658458"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="684658458"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 17 Aug 2023 17:42:02 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWnYv-0001ZT-0y;
        Fri, 18 Aug 2023 00:42:01 +0000
Date:   Fri, 18 Aug 2023 08:41:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Melissa Wen <mwen@igalia.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Tales Aparecida <tales.aparecida@gmail.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Subject: htmldocs: ./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:109:
 warning: Function parameter or member 'overlap_only' not described in
 'mpcc_blnd_cfg'
Message-ID: <202308180803.QE0R3OlP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   16931859a6500d360b90aeacab3b505a3560a3ed
commit: 33fa4f1df53076d0078be091d5a88d457de54936 Documentation/gpu/amdgpu/amdgpu_dm: add DM docs for pixel blend mode
date:   1 year ago
reproduce: (https://download.01.org/0day-ci/archive/20230818/202308180803.QE0R3OlP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308180803.QE0R3OlP-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> ./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:109: warning: Function parameter or member 'overlap_only' not described in 'mpcc_blnd_cfg'
>> ./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:109: warning: Function parameter or member 'bottom_gain_mode' not described in 'mpcc_blnd_cfg'
>> ./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:109: warning: Function parameter or member 'background_color_bpc' not described in 'mpcc_blnd_cfg'
>> ./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:109: warning: Function parameter or member 'top_gain' not described in 'mpcc_blnd_cfg'
>> ./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:109: warning: Function parameter or member 'bottom_inside_gain' not described in 'mpcc_blnd_cfg'
>> ./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:109: warning: Function parameter or member 'bottom_outside_gain' not described in 'mpcc_blnd_cfg'

vim +109 ./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h

feb4a3cd8eb007f Eric Bernstein 2017-11-06   83  
43d61f6d8f4d2da Melissa Wen    2022-08-04   84  /**
43d61f6d8f4d2da Melissa Wen    2022-08-04   85   * struct mpcc_blnd_cfg - MPCC blending configuration
43d61f6d8f4d2da Melissa Wen    2022-08-04   86   *
43d61f6d8f4d2da Melissa Wen    2022-08-04   87   * @black_color: background color
43d61f6d8f4d2da Melissa Wen    2022-08-04   88   * @alpha_mode: alpha blend mode (MPCC_ALPHA_BLND_MODE)
43d61f6d8f4d2da Melissa Wen    2022-08-04   89   * @pre_multiplied_alpha: whether pixel color values were pre-multiplied by the
43d61f6d8f4d2da Melissa Wen    2022-08-04   90   * alpha channel (MPCC_ALPHA_MULTIPLIED_MODE)
43d61f6d8f4d2da Melissa Wen    2022-08-04   91   * @global_gain: used when blend mode considers both pixel alpha and plane
43d61f6d8f4d2da Melissa Wen    2022-08-04   92   * alpha value and assumes the global alpha value.
43d61f6d8f4d2da Melissa Wen    2022-08-04   93   * @global_alpha: plane alpha value
feb4a3cd8eb007f Eric Bernstein 2017-11-06   94   */
feb4a3cd8eb007f Eric Bernstein 2017-11-06   95  struct mpcc_blnd_cfg {
feb4a3cd8eb007f Eric Bernstein 2017-11-06   96  	struct tg_color black_color;	/* background color */
feb4a3cd8eb007f Eric Bernstein 2017-11-06   97  	enum mpcc_alpha_blend_mode alpha_mode;	/* alpha blend mode */
feb4a3cd8eb007f Eric Bernstein 2017-11-06   98  	bool pre_multiplied_alpha;	/* alpha pre-multiplied mode flag */
feb4a3cd8eb007f Eric Bernstein 2017-11-06   99  	int global_gain;
feb4a3cd8eb007f Eric Bernstein 2017-11-06  100  	int global_alpha;
feb4a3cd8eb007f Eric Bernstein 2017-11-06  101  	bool overlap_only;
feb4a3cd8eb007f Eric Bernstein 2017-11-06  102  
f789b0b82bf0aee Harry Wentland 2019-02-22  103  	/* MPCC top/bottom gain settings */
f789b0b82bf0aee Harry Wentland 2019-02-22  104  	int bottom_gain_mode;
f789b0b82bf0aee Harry Wentland 2019-02-22  105  	int background_color_bpc;
f789b0b82bf0aee Harry Wentland 2019-02-22  106  	int top_gain;
f789b0b82bf0aee Harry Wentland 2019-02-22  107  	int bottom_inside_gain;
f789b0b82bf0aee Harry Wentland 2019-02-22  108  	int bottom_outside_gain;
feb4a3cd8eb007f Eric Bernstein 2017-11-06 @109  };
feb4a3cd8eb007f Eric Bernstein 2017-11-06  110  

:::::: The code at line 109 was first introduced by commit
:::::: feb4a3cd8eb007f4749dc8323110f42fb4682ae0 drm/amd/display: Integrating MPC pseudocode

:::::: TO: Eric Bernstein <eric.bernstein@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
