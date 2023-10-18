Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D687CDD39
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 15:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344683AbjJRN2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 09:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344678AbjJRN16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 09:27:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FBAB0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 06:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697635672; x=1729171672;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=jWE9LqZwlxBknmsbqjvsaewYAymHDx6S2uw5KhF4qDc=;
  b=fCIDuyzDec3HpVjBUH8qfnmUdJ92FwOmlmlow+7h5CpwsOw8ups9qMuf
   HHxHegoUx7RxykI6xRlJRZx2Ss9djs2e/F4Jg7drRaJdroUb9DJpZgCiL
   9yNUx5JI+wkdUyOn7pscsYcAmA/6c32u6X8Kh8lC06vHWmv77doYfqVj7
   5u8U2vXETs0cJV92BCoMxYC+ZBBf1uGVHfqJweE5PRhnkmMAC7YtGlqws
   C2f5wMwPVcimoPbAvPV5mlYEAchfy9QeC+F60hRxspVqKrYgZAi/v/ieU
   BaYfevSQd4j6ThTvJORLTCnZTd/o2BbHOF6jq9MAnQYYk6tMKk3nzBbTb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="417125403"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="417125403"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 06:27:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="1003810878"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="1003810878"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 18 Oct 2023 06:27:51 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qt6aT-0000Pu-0R;
        Wed, 18 Oct 2023 13:27:49 +0000
Date:   Wed, 18 Oct 2023 21:27:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Danilo Krummrich <dakr@redhat.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dave Airlie <airlied@redhat.com>
Subject: drivers/gpu/drm/nouveau/nouveau_gem.c:195:16: warning: array
 subscript 0 is outside array bounds of 'struct nouveau_vmm[0]'
Message-ID: <202310182119.dZjSbqjD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Danilo,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   06dc10eae55b5ceabfef287a7e5f16ceea204aa0
commit: b88baab828713ce0b49b185444b2ee83bed373a8 drm/nouveau: implement new VM_BIND uAPI
date:   3 months ago
config: arm64-randconfig-004-20231018 (https://download.01.org/0day-ci/archive/20231018/202310182119.dZjSbqjD-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231018/202310182119.dZjSbqjD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310182119.dZjSbqjD-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/nouveau/nouveau_gem.c: In function 'nouveau_gem_object_close':
>> drivers/gpu/drm/nouveau/nouveau_gem.c:195:16: warning: array subscript 0 is outside array bounds of 'struct nouveau_vmm[0]' [-Warray-bounds=]
     195 |         if (vmm->vmm.object.oclass < NVIF_CLASS_VMM_NV50)
         |                ^~
   cc1: note: source object is likely at address zero
>> drivers/gpu/drm/nouveau/nouveau_gem.c:195:16: warning: array subscript 0 is outside array bounds of 'struct nouveau_vmm[0]' [-Warray-bounds=]
   cc1: note: source object is likely at address zero
>> drivers/gpu/drm/nouveau/nouveau_gem.c:195:16: warning: array subscript 0 is outside array bounds of 'struct nouveau_vmm[0]' [-Warray-bounds=]
   cc1: note: source object is likely at address zero
   cc1: note: source object is likely at address zero


vim +195 drivers/gpu/drm/nouveau/nouveau_gem.c

c4c7044ffc1ba9 Ben Skeggs       2013-05-07  183  
639212d0115726 Ben Skeggs       2011-06-03  184  void
639212d0115726 Ben Skeggs       2011-06-03  185  nouveau_gem_object_close(struct drm_gem_object *gem, struct drm_file *file_priv)
639212d0115726 Ben Skeggs       2011-06-03  186  {
ebb945a94bba2c Ben Skeggs       2012-07-20  187  	struct nouveau_cli *cli = nouveau_cli(file_priv);
2fd3db6f145705 Ben Skeggs       2011-06-07  188  	struct nouveau_bo *nvbo = nouveau_gem_object(gem);
5cc8d536c21a17 Ben Skeggs       2014-12-11  189  	struct nouveau_drm *drm = nouveau_bdev(nvbo->bo.bdev);
5cc8d536c21a17 Ben Skeggs       2014-12-11  190  	struct device *dev = drm->dev->dev;
7b05a7c0c9ca6e Danilo Krummrich 2023-08-04  191  	struct nouveau_vmm *vmm = nouveau_cli_vmm(cli);
24e8375b1bfdf7 Ben Skeggs       2017-11-01  192  	struct nouveau_vma *vma;
2fd3db6f145705 Ben Skeggs       2011-06-07  193  	int ret;
639212d0115726 Ben Skeggs       2011-06-03  194  
bfe91afaca5925 Ben Skeggs       2019-02-19 @195  	if (vmm->vmm.object.oclass < NVIF_CLASS_VMM_NV50)
639212d0115726 Ben Skeggs       2011-06-03  196  		return;
2fd3db6f145705 Ben Skeggs       2011-06-07  197  
b88baab828713c Danilo Krummrich 2023-08-04  198  	if (nouveau_cli_uvmm(cli))
b88baab828713c Danilo Krummrich 2023-08-04  199  		return;
b88baab828713c Danilo Krummrich 2023-08-04  200  
dfd5e50ea43ca4 Christian König  2016-04-06  201  	ret = ttm_bo_reserve(&nvbo->bo, false, false, NULL);
2fd3db6f145705 Ben Skeggs       2011-06-07  202  	if (ret)
2fd3db6f145705 Ben Skeggs       2011-06-07  203  		return;
2fd3db6f145705 Ben Skeggs       2011-06-07  204  
bfe91afaca5925 Ben Skeggs       2019-02-19  205  	vma = nouveau_vma_find(nvbo, vmm);
2fd3db6f145705 Ben Skeggs       2011-06-07  206  	if (vma) {
24e8375b1bfdf7 Ben Skeggs       2017-11-01  207  		if (--vma->refs == 0) {
5cc8d536c21a17 Ben Skeggs       2014-12-11  208  			ret = pm_runtime_get_sync(dev);
5cc8d536c21a17 Ben Skeggs       2014-12-11  209  			if (!WARN_ON(ret < 0 && ret != -EACCES)) {
c4c7044ffc1ba9 Ben Skeggs       2013-05-07  210  				nouveau_gem_object_unmap(nvbo, vma);
5cc8d536c21a17 Ben Skeggs       2014-12-11  211  				pm_runtime_mark_last_busy(dev);
5cc8d536c21a17 Ben Skeggs       2014-12-11  212  			}
d3faddc7dcd326 Dinghao Liu      2020-05-20  213  			pm_runtime_put_autosuspend(dev);
5cc8d536c21a17 Ben Skeggs       2014-12-11  214  		}
2fd3db6f145705 Ben Skeggs       2011-06-07  215  	}
2fd3db6f145705 Ben Skeggs       2011-06-07  216  	ttm_bo_unreserve(&nvbo->bo);
639212d0115726 Ben Skeggs       2011-06-03  217  }
639212d0115726 Ben Skeggs       2011-06-03  218  

:::::: The code at line 195 was first introduced by commit
:::::: bfe91afaca59251fbf5d62143fdd8f740b551302 drm/nouveau: prepare for enabling svm with existing userspace interfaces

:::::: TO: Ben Skeggs <bskeggs@redhat.com>
:::::: CC: Ben Skeggs <bskeggs@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
