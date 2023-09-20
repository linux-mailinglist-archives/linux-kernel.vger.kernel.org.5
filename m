Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEDC57A89A7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 18:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234781AbjITQlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 12:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234669AbjITQlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 12:41:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4682BCA
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 09:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695228085; x=1726764085;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=624sNm//FBgltBdHDHv3/pdXOCBHeESxANslKi0+4IE=;
  b=XWdScqdBIAJheqU8cVsCY5sZkmYzCKdywtKnsOe1/r4HNZuG97ktq8Ua
   ZkoXBet+1ewfmXoP+sK1GMx8KIFdAWLD8QM1Kk45ZQTO5B/XxR5gFKAAD
   TwFbl4sfMuVZsCkUlPraGaKEy0TsClY7m5c6rkTlPT8A1+6zrzE8b9mS4
   /WuVz+LiD+MyOgXbH8345c2OvpCkvplzWuzIZRKYITkJjbfNdGCevldMm
   KngJDb9jfQxVqqsyhH5hMyCV6lnuxi5WzqflDuTYGFji3upzLuNEs+AFe
   avK6GDdmRr7lxTdUi+VSSzxdgBj4i8eXeahLWHGuR3ltxgCgWaQ3/XRmf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="466584290"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="466584290"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 09:40:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="749981294"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="749981294"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 20 Sep 2023 09:40:35 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qj0Fd-0008xG-0W;
        Wed, 20 Sep 2023 16:40:33 +0000
Date:   Thu, 21 Sep 2023 00:40:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Danilo Krummrich <dakr@redhat.com>, airlied@gmail.com,
        daniel@ffwll.ch, matthew.brost@intel.com,
        thomas.hellstrom@linux.intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, boris.brezillon@collabora.com,
        christian.koenig@amd.com, faith.ekstrand@collabora.com
Cc:     oe-kbuild-all@lists.linux.dev, nouveau@lists.freedesktop.org,
        Danilo Krummrich <dakr@redhat.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH drm-misc-next v4 6/8] drm/gpuvm: add drm_gpuvm_flags to
 drm_gpuvm
Message-ID: <202309210041.Ypce0gUk-lkp@intel.com>
References: <20230920144343.64830-7-dakr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920144343.64830-7-dakr@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_FILL_THIS_FORM_SHORT
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Danilo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 1c7a387ffef894b1ab3942f0482dac7a6e0a909c]

url:    https://github.com/intel-lab-lkp/linux/commits/Danilo-Krummrich/drm-gpuvm-rename-struct-drm_gpuva_manager-to-struct-drm_gpuvm/20230920-224605
base:   1c7a387ffef894b1ab3942f0482dac7a6e0a909c
patch link:    https://lore.kernel.org/r/20230920144343.64830-7-dakr%40redhat.com
patch subject: [PATCH drm-misc-next v4 6/8] drm/gpuvm: add drm_gpuvm_flags to drm_gpuvm
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20230921/202309210041.Ypce0gUk-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230921/202309210041.Ypce0gUk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309210041.Ypce0gUk-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/drm_gpuvm.c:712: warning: Function parameter or member 'flags' not described in 'drm_gpuvm_init'


vim +712 drivers/gpu/drm/drm_gpuvm.c

e6303f323b1ad9 drivers/gpu/drm/drm_gpuva_mgr.c Danilo Krummrich 2023-07-20  689  
e6303f323b1ad9 drivers/gpu/drm/drm_gpuva_mgr.c Danilo Krummrich 2023-07-20  690  /**
06f9274d201d5d drivers/gpu/drm/drm_gpuvm.c     Danilo Krummrich 2023-09-20  691   * drm_gpuvm_init() - initialize a &drm_gpuvm
06f9274d201d5d drivers/gpu/drm/drm_gpuvm.c     Danilo Krummrich 2023-09-20  692   * @gpuvm: pointer to the &drm_gpuvm to initialize
52ef25512ca721 drivers/gpu/drm/drm_gpuvm.c     Danilo Krummrich 2023-09-20  693   * @drm: the drivers &drm_device
e6303f323b1ad9 drivers/gpu/drm/drm_gpuva_mgr.c Danilo Krummrich 2023-07-20  694   * @name: the name of the GPU VA space
e6303f323b1ad9 drivers/gpu/drm/drm_gpuva_mgr.c Danilo Krummrich 2023-07-20  695   * @start_offset: the start offset of the GPU VA space
e6303f323b1ad9 drivers/gpu/drm/drm_gpuva_mgr.c Danilo Krummrich 2023-07-20  696   * @range: the size of the GPU VA space
e6303f323b1ad9 drivers/gpu/drm/drm_gpuva_mgr.c Danilo Krummrich 2023-07-20  697   * @reserve_offset: the start of the kernel reserved GPU VA area
e6303f323b1ad9 drivers/gpu/drm/drm_gpuva_mgr.c Danilo Krummrich 2023-07-20  698   * @reserve_range: the size of the kernel reserved GPU VA area
06f9274d201d5d drivers/gpu/drm/drm_gpuvm.c     Danilo Krummrich 2023-09-20  699   * @ops: &drm_gpuvm_ops called on &drm_gpuvm_sm_map / &drm_gpuvm_sm_unmap
e6303f323b1ad9 drivers/gpu/drm/drm_gpuva_mgr.c Danilo Krummrich 2023-07-20  700   *
06f9274d201d5d drivers/gpu/drm/drm_gpuvm.c     Danilo Krummrich 2023-09-20  701   * The &drm_gpuvm must be initialized with this function before use.
e6303f323b1ad9 drivers/gpu/drm/drm_gpuva_mgr.c Danilo Krummrich 2023-07-20  702   *
06f9274d201d5d drivers/gpu/drm/drm_gpuvm.c     Danilo Krummrich 2023-09-20  703   * Note that @gpuvm must be cleared to 0 before calling this function. The given
e6303f323b1ad9 drivers/gpu/drm/drm_gpuva_mgr.c Danilo Krummrich 2023-07-20  704   * &name is expected to be managed by the surrounding driver structures.
e6303f323b1ad9 drivers/gpu/drm/drm_gpuva_mgr.c Danilo Krummrich 2023-07-20  705   */
e6303f323b1ad9 drivers/gpu/drm/drm_gpuva_mgr.c Danilo Krummrich 2023-07-20  706  void
52ef25512ca721 drivers/gpu/drm/drm_gpuvm.c     Danilo Krummrich 2023-09-20  707  drm_gpuvm_init(struct drm_gpuvm *gpuvm, struct drm_device *drm,
790facc6dac6ef drivers/gpu/drm/drm_gpuvm.c     Danilo Krummrich 2023-09-20  708  	       const char *name, enum drm_gpuva_flags flags,
e6303f323b1ad9 drivers/gpu/drm/drm_gpuva_mgr.c Danilo Krummrich 2023-07-20  709  	       u64 start_offset, u64 range,
e6303f323b1ad9 drivers/gpu/drm/drm_gpuva_mgr.c Danilo Krummrich 2023-07-20  710  	       u64 reserve_offset, u64 reserve_range,
06f9274d201d5d drivers/gpu/drm/drm_gpuvm.c     Danilo Krummrich 2023-09-20  711  	       const struct drm_gpuvm_ops *ops)
e6303f323b1ad9 drivers/gpu/drm/drm_gpuva_mgr.c Danilo Krummrich 2023-07-20 @712  {
06f9274d201d5d drivers/gpu/drm/drm_gpuvm.c     Danilo Krummrich 2023-09-20  713  	gpuvm->rb.tree = RB_ROOT_CACHED;
06f9274d201d5d drivers/gpu/drm/drm_gpuvm.c     Danilo Krummrich 2023-09-20  714  	INIT_LIST_HEAD(&gpuvm->rb.list);
e6303f323b1ad9 drivers/gpu/drm/drm_gpuva_mgr.c Danilo Krummrich 2023-07-20  715  
06f9274d201d5d drivers/gpu/drm/drm_gpuvm.c     Danilo Krummrich 2023-09-20  716  	drm_gpuvm_check_overflow(start_offset, range);
06f9274d201d5d drivers/gpu/drm/drm_gpuvm.c     Danilo Krummrich 2023-09-20  717  	gpuvm->mm_start = start_offset;
06f9274d201d5d drivers/gpu/drm/drm_gpuvm.c     Danilo Krummrich 2023-09-20  718  	gpuvm->mm_range = range;
e6303f323b1ad9 drivers/gpu/drm/drm_gpuva_mgr.c Danilo Krummrich 2023-07-20  719  
06f9274d201d5d drivers/gpu/drm/drm_gpuvm.c     Danilo Krummrich 2023-09-20  720  	gpuvm->name = name ? name : "unknown";
790facc6dac6ef drivers/gpu/drm/drm_gpuvm.c     Danilo Krummrich 2023-09-20  721  	gpuvm->flags = flags;
06f9274d201d5d drivers/gpu/drm/drm_gpuvm.c     Danilo Krummrich 2023-09-20  722  	gpuvm->ops = ops;
e6303f323b1ad9 drivers/gpu/drm/drm_gpuva_mgr.c Danilo Krummrich 2023-07-20  723  
06f9274d201d5d drivers/gpu/drm/drm_gpuvm.c     Danilo Krummrich 2023-09-20  724  	memset(&gpuvm->kernel_alloc_node, 0, sizeof(struct drm_gpuva));
e6303f323b1ad9 drivers/gpu/drm/drm_gpuva_mgr.c Danilo Krummrich 2023-07-20  725  
e6303f323b1ad9 drivers/gpu/drm/drm_gpuva_mgr.c Danilo Krummrich 2023-07-20  726  	if (reserve_range) {
06f9274d201d5d drivers/gpu/drm/drm_gpuvm.c     Danilo Krummrich 2023-09-20  727  		gpuvm->kernel_alloc_node.va.addr = reserve_offset;
06f9274d201d5d drivers/gpu/drm/drm_gpuvm.c     Danilo Krummrich 2023-09-20  728  		gpuvm->kernel_alloc_node.va.range = reserve_range;
e6303f323b1ad9 drivers/gpu/drm/drm_gpuva_mgr.c Danilo Krummrich 2023-07-20  729  
06f9274d201d5d drivers/gpu/drm/drm_gpuvm.c     Danilo Krummrich 2023-09-20  730  		if (likely(!drm_gpuvm_check_overflow(reserve_offset,
e6303f323b1ad9 drivers/gpu/drm/drm_gpuva_mgr.c Danilo Krummrich 2023-07-20  731  						     reserve_range)))
06f9274d201d5d drivers/gpu/drm/drm_gpuvm.c     Danilo Krummrich 2023-09-20  732  			__drm_gpuva_insert(gpuvm, &gpuvm->kernel_alloc_node);
e6303f323b1ad9 drivers/gpu/drm/drm_gpuva_mgr.c Danilo Krummrich 2023-07-20  733  	}
52ef25512ca721 drivers/gpu/drm/drm_gpuvm.c     Danilo Krummrich 2023-09-20  734  
52ef25512ca721 drivers/gpu/drm/drm_gpuvm.c     Danilo Krummrich 2023-09-20  735  	drm_gem_private_object_init(drm, &gpuvm->d_obj, 0);
e6303f323b1ad9 drivers/gpu/drm/drm_gpuva_mgr.c Danilo Krummrich 2023-07-20  736  }
06f9274d201d5d drivers/gpu/drm/drm_gpuvm.c     Danilo Krummrich 2023-09-20  737  EXPORT_SYMBOL_GPL(drm_gpuvm_init);
e6303f323b1ad9 drivers/gpu/drm/drm_gpuva_mgr.c Danilo Krummrich 2023-07-20  738  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
