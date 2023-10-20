Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE93F7D19AA
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 01:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjJTXlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 19:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjJTXln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 19:41:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39B1D6C
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 16:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697845297; x=1729381297;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=me/PE+wvYNkVkWV/yp7pgx864wr2JK22f0xEIPW4/i8=;
  b=IPNdQ9I0PhiXfxtxA0oElzL57Z9k9EhgtCJhtoachYVJ3fVx8G3NDTac
   NIbGLxwquIrRXIV1fTVwMz5hRFwdy9ZOcneYKQ8BFp4MsXUYPWknkNSpL
   QKY2c23cFLG7FwixOgr+PcFs1XKELu5pp/dKupVQM1kh+MDnuj+speERf
   DuTyiegv1t0uo0E0cbOBx849MC2CsA9hsnuRYGUozy7jEs5WKyrZSymcn
   6e8kbAjDpQZ27FYVvyQeukT12bGbE0WPfF8LS4eWO0nuu6oiDzr5Ftg93
   OwYdn6qkLDsLZg6jBRvJMQulE7TI//LA1WBGLbXBnEkUHMB6Jgv2ehSy6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="383800365"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="383800365"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 16:41:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="786931201"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="786931201"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 20 Oct 2023 16:41:35 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qtz7V-00047C-0s;
        Fri, 20 Oct 2023 23:41:33 +0000
Date:   Sat, 21 Oct 2023 07:40:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Le Ma <le.ma@amd.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c:326:40: warning: '%d'
 directive writing between 1 and 10 bytes into a region of size between 0 and
 8
Message-ID: <202310210731.mugeov4Z-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f74e3ea3ba9cdef948999c29c1c9793ea26787b4
commit: def799c6596d078112095c24c25e162cb5102d90 drm/amdgpu: add multi-xcc support to amdgpu_gfx interfaces (v4)
date:   6 months ago
config: x86_64-randconfig-x051-20230809 (https://download.01.org/0day-ci/archive/20231021/202310210731.mugeov4Z-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231021/202310210731.mugeov4Z-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310210731.mugeov4Z-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c: In function 'amdgpu_gfx_mqd_sw_fini':
   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c:451:16: warning: variable 'j' set but not used [-Wunused-but-set-variable]
     451 |         int i, j;
         |                ^
   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c: In function 'amdgpu_gfx_disable_kcq':
   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c:486:13: warning: variable 'j' set but not used [-Wunused-but-set-variable]
     486 |         int j;
         |             ^
   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c: In function 'amdgpu_gfx_enable_kcq':
   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c:529:19: warning: variable 'j' set but not used [-Wunused-but-set-variable]
     529 |         int r, i, j;
         |                   ^
   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c: In function 'amdgpu_gfx_kiq_init_ring':
>> drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c:326:40: warning: '%d' directive writing between 1 and 10 bytes into a region of size between 0 and 8 [-Wformat-overflow=]
     326 |         sprintf(ring->name, "kiq_%d.%d.%d.%d", xcc_id, ring->me, ring->pipe, ring->queue);
         |                                        ^~
   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c:326:29: note: directive argument in the range [0, 2147483647]
     326 |         sprintf(ring->name, "kiq_%d.%d.%d.%d", xcc_id, ring->me, ring->pipe, ring->queue);
         |                             ^~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c:326:9: note: 'sprintf' output between 12 and 41 bytes into a destination of size 16
     326 |         sprintf(ring->name, "kiq_%d.%d.%d.%d", xcc_id, ring->me, ring->pipe, ring->queue);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +326 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c

   303	
   304	int amdgpu_gfx_kiq_init_ring(struct amdgpu_device *adev,
   305				     struct amdgpu_ring *ring,
   306				     struct amdgpu_irq_src *irq, int xcc_id)
   307	{
   308		struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_id];
   309		int r = 0;
   310	
   311		spin_lock_init(&kiq->ring_lock);
   312	
   313		ring->adev = NULL;
   314		ring->ring_obj = NULL;
   315		ring->use_doorbell = true;
   316		ring->doorbell_index = adev->doorbell_index.kiq;
   317		ring->xcc_id = xcc_id;
   318		ring->vm_hub = AMDGPU_GFXHUB_0;
   319	
   320		r = amdgpu_gfx_kiq_acquire(adev, ring, xcc_id);
   321		if (r)
   322			return r;
   323	
   324		ring->eop_gpu_addr = kiq->eop_gpu_addr;
   325		ring->no_scheduler = true;
 > 326		sprintf(ring->name, "kiq_%d.%d.%d.%d", xcc_id, ring->me, ring->pipe, ring->queue);
   327		r = amdgpu_ring_init(adev, ring, 1024, irq, AMDGPU_CP_KIQ_IRQ_DRIVER0,
   328				     AMDGPU_RING_PRIO_DEFAULT, NULL);
   329		if (r)
   330			dev_warn(adev->dev, "(%d) failed to init kiq ring\n", r);
   331	
   332		return r;
   333	}
   334	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
