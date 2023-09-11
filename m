Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0679879A0FC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 03:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbjIKBed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 21:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbjIKBec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 21:34:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67757122
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 18:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694396068; x=1725932068;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OJJFXSprj4HDI5e719avf/BQ8FAvbjbx/aGJgWPLDXk=;
  b=aFIyMtwRfR+0aAkob0dFgWAhcVPTIdgv/Ei0YrFrxB8Gb5+MrtfOkVhF
   cW1YilZSeTyP7aVJ4vWHjgqCmWQgqE/fDeQudGwPbC9WuVEKc4XxA4ZpP
   MOu7wngdlAGqb0t5CoaL7LgJuPMExxTun0pt6A9jROs37XITxTPuz3tLO
   slNTBYx2C49DHueyKSO+RWqofjspveLkbfc7tb0rRZU31ShqPd5WOHly+
   3CVXDL0wq0cNRetHdm4BhyaD2UrwxsgK4O7aK2ZdIspOgeXnvsme3Zo/y
   uG+0tnlciH3GchaOdvylziVMmDf4pvHVAVhXWS32ywXGA9xssdmVOaFQv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="358274281"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="358274281"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2023 18:34:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="866757301"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="866757301"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 10 Sep 2023 18:34:25 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qfVol-0005et-0V;
        Mon, 11 Sep 2023 01:34:23 +0000
Date:   Mon, 11 Sep 2023 09:33:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yi Liu <yi.l.liu@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: include/linux/vfio.h:294:35: error: weak declaration of
 'vfio_file_iommu_group' being applied to a already existing, static
 definition
Message-ID: <202309110914.QLH0LU6L-lkp@intel.com>
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
head:   0bb80ecc33a8fb5a682236443c1e740d5c917d1d
commit: c1cce6d079b875396c9a7c6838fc5b024758e540 vfio: Compile vfio_group infrastructure optionally
date:   7 weeks ago
config: powerpc64-randconfig-r025-20210929 (https://download.01.org/0day-ci/archive/20230911/202309110914.QLH0LU6L-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230911/202309110914.QLH0LU6L-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309110914.QLH0LU6L-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/powerpc/kvm/../../../virt/kvm/vfio.c:17:
   include/linux/vfio.h: In function 'kvm_vfio_file_iommu_group':
>> include/linux/vfio.h:294:35: error: weak declaration of 'vfio_file_iommu_group' being applied to a already existing, static definition
     294 | static inline struct iommu_group *vfio_file_iommu_group(struct file *file)
         |                                   ^~~~~~~~~~~~~~~~~~~~~


vim +/vfio_file_iommu_group +294 include/linux/vfio.h

   274	
   275	int vfio_assign_device_set(struct vfio_device *device, void *set_id);
   276	unsigned int vfio_device_set_open_count(struct vfio_device_set *dev_set);
   277	struct vfio_device *
   278	vfio_find_device_in_devset(struct vfio_device_set *dev_set,
   279				   struct device *dev);
   280	
   281	int vfio_mig_get_next_state(struct vfio_device *device,
   282				    enum vfio_device_mig_state cur_fsm,
   283				    enum vfio_device_mig_state new_fsm,
   284				    enum vfio_device_mig_state *next_fsm);
   285	
   286	/*
   287	 * External user API
   288	 */
   289	#if IS_ENABLED(CONFIG_VFIO_GROUP)
   290	struct iommu_group *vfio_file_iommu_group(struct file *file);
   291	bool vfio_file_is_group(struct file *file);
   292	bool vfio_file_has_dev(struct file *file, struct vfio_device *device);
   293	#else
 > 294	static inline struct iommu_group *vfio_file_iommu_group(struct file *file)
   295	{
   296		return NULL;
   297	}
   298	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
