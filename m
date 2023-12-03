Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F322802145
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 07:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjLCGcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 01:32:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbjLCGbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 01:31:44 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0650DEB
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 22:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701585110; x=1733121110;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fKojD+begd9fNLiV+pruerl7tyA7hg+P7ZFniOQjnzY=;
  b=BNxqbNk5UV02Eaj1WdGL4ntP/JKC75PWoXQi5vX6yaJVToWSKKqZL9Wv
   cMiVQ9AhrgBpI5FvqzseqVZV6p94f3rAA6dK+2PsutsNJ7v++Fp5PhYYp
   YqYT0AUcG2MrXt9dZQlgt1ZOW4/3+KySZ5SzEZ0Q99/NdHgKjqbgbv035
   +xGXbgJNctErGRwJ94H9z54AEwmq1kVEhe6+U3q9CLxH1mEqXOOhrsbYN
   pOdZBHZkzcEG1lqTc/Ljk1eN69psL2tHXQksjZ8/a98rQSFQ3crQHeF2U
   Zk9nqXYXPHr0c91s6K3cnd5taksIftWDoXVAH85hdfRxr8oMQo9VqTK3u
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="6942693"
X-IronPort-AV: E=Sophos;i="6.04,246,1695711600"; 
   d="scan'208";a="6942693"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2023 22:31:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="893652740"
X-IronPort-AV: E=Sophos;i="6.04,246,1695711600"; 
   d="scan'208";a="893652740"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 02 Dec 2023 22:31:46 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r9g12-0006Kc-04;
        Sun, 03 Dec 2023 06:31:44 +0000
Date:   Sun, 3 Dec 2023 14:31:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ben Skeggs <bskeggs@redhat.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Lyude Paul <lyude@redhat.com>
Subject: drivers/gpu/drm/nouveau/nvkm/subdev/top/ga100.c:82 ga100_top_parse()
 warn: inconsistent indenting
Message-ID: <202312030044.q1SxyCnu-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   815fb87b753055df2d9e50f6cd80eb10235fe3e9
commit: eec3f6dfedc0b8c5aef7619667dee61a77a37e35 drm/nouveau/top: parse device topology right after devinit
date:   1 year, 1 month ago
config: i386-randconfig-141-20231105 (https://download.01.org/0day-ci/archive/20231203/202312030044.q1SxyCnu-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231203/202312030044.q1SxyCnu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312030044.q1SxyCnu-lkp@intel.com/

smatch warnings:
drivers/gpu/drm/nouveau/nvkm/subdev/top/ga100.c:82 ga100_top_parse() warn: inconsistent indenting

vim +82 drivers/gpu/drm/nouveau/nvkm/subdev/top/ga100.c

f6df392dddbb9e Ben Skeggs 2021-02-08  23  
f6df392dddbb9e Ben Skeggs 2021-02-08  24  static int
eec3f6dfedc0b8 Ben Skeggs 2022-06-01  25  ga100_top_parse(struct nvkm_top *top)
f6df392dddbb9e Ben Skeggs 2021-02-08  26  {
f6df392dddbb9e Ben Skeggs 2021-02-08  27  	struct nvkm_subdev *subdev = &top->subdev;
f6df392dddbb9e Ben Skeggs 2021-02-08  28  	struct nvkm_device *device = subdev->device;
f6df392dddbb9e Ben Skeggs 2021-02-08  29  	struct nvkm_top_device *info = NULL;
f6df392dddbb9e Ben Skeggs 2021-02-08  30  	u32 data, type, inst;
f6df392dddbb9e Ben Skeggs 2021-02-08  31  	int i, n, size = nvkm_rd32(device, 0x0224fc) >> 20;
f6df392dddbb9e Ben Skeggs 2021-02-08  32  
f6df392dddbb9e Ben Skeggs 2021-02-08  33  	for (i = 0, n = 0; i < size; i++) {
f6df392dddbb9e Ben Skeggs 2021-02-08  34  		if (!info) {
f6df392dddbb9e Ben Skeggs 2021-02-08  35  			if (!(info = nvkm_top_device_new(top)))
f6df392dddbb9e Ben Skeggs 2021-02-08  36  				return -ENOMEM;
f6df392dddbb9e Ben Skeggs 2021-02-08  37  			type = ~0;
f6df392dddbb9e Ben Skeggs 2021-02-08  38  			inst = 0;
f6df392dddbb9e Ben Skeggs 2021-02-08  39  		}
f6df392dddbb9e Ben Skeggs 2021-02-08  40  
f6df392dddbb9e Ben Skeggs 2021-02-08  41  		data = nvkm_rd32(device, 0x022800 + (i * 0x04));
f6df392dddbb9e Ben Skeggs 2021-02-08  42  		nvkm_trace(subdev, "%02x: %08x\n", i, data);
f6df392dddbb9e Ben Skeggs 2021-02-08  43  		if (!data && n == 0)
f6df392dddbb9e Ben Skeggs 2021-02-08  44  			continue;
f6df392dddbb9e Ben Skeggs 2021-02-08  45  
f6df392dddbb9e Ben Skeggs 2021-02-08  46  		switch (n++) {
f6df392dddbb9e Ben Skeggs 2021-02-08  47  		case 0:
f6df392dddbb9e Ben Skeggs 2021-02-08  48  			type	      = (data & 0x3f000000) >> 24;
f6df392dddbb9e Ben Skeggs 2021-02-08  49  			inst	      = (data & 0x000f0000) >> 16;
f6df392dddbb9e Ben Skeggs 2021-02-08  50  			info->fault   = (data & 0x0000007f);
f6df392dddbb9e Ben Skeggs 2021-02-08  51  			break;
f6df392dddbb9e Ben Skeggs 2021-02-08  52  		case 1:
f6df392dddbb9e Ben Skeggs 2021-02-08  53  			info->addr    = (data & 0x00fff000);
f6df392dddbb9e Ben Skeggs 2021-02-08  54  			info->reset   = (data & 0x0000001f);
f6df392dddbb9e Ben Skeggs 2021-02-08  55  			break;
f6df392dddbb9e Ben Skeggs 2021-02-08  56  		case 2:
49b2dfc0818268 Ben Skeggs 2021-09-17  57  			info->runlist = (data & 0x00fffc00);
f6df392dddbb9e Ben Skeggs 2021-02-08  58  			info->engine  = (data & 0x00000003);
f6df392dddbb9e Ben Skeggs 2021-02-08  59  			break;
f6df392dddbb9e Ben Skeggs 2021-02-08  60  		default:
f6df392dddbb9e Ben Skeggs 2021-02-08  61  			break;
f6df392dddbb9e Ben Skeggs 2021-02-08  62  		}
f6df392dddbb9e Ben Skeggs 2021-02-08  63  
f6df392dddbb9e Ben Skeggs 2021-02-08  64  		if (data & 0x80000000)
f6df392dddbb9e Ben Skeggs 2021-02-08  65  			continue;
f6df392dddbb9e Ben Skeggs 2021-02-08  66  		n = 0;
f6df392dddbb9e Ben Skeggs 2021-02-08  67  
f6df392dddbb9e Ben Skeggs 2021-02-08  68  		/* Translate engine type to NVKM engine identifier. */
f6df392dddbb9e Ben Skeggs 2021-02-08  69  #define I_(T,I) do { info->type = (T); info->inst = (I); } while(0)
f6df392dddbb9e Ben Skeggs 2021-02-08  70  #define O_(T,I) do { WARN_ON(inst); I_(T, I); } while (0)
f6df392dddbb9e Ben Skeggs 2021-02-08  71  		switch (type) {
f6df392dddbb9e Ben Skeggs 2021-02-08  72  		case 0x00000000: O_(NVKM_ENGINE_GR    ,    0); break;
f6df392dddbb9e Ben Skeggs 2021-02-08  73  		case 0x0000000d: O_(NVKM_ENGINE_SEC2  ,    0); break;
f6df392dddbb9e Ben Skeggs 2021-02-08  74  		case 0x0000000e: I_(NVKM_ENGINE_NVENC , inst); break;
f6df392dddbb9e Ben Skeggs 2021-02-08  75  		case 0x00000010: I_(NVKM_ENGINE_NVDEC , inst); break;
f6df392dddbb9e Ben Skeggs 2021-02-08  76  		case 0x00000012: I_(NVKM_SUBDEV_IOCTRL, inst); break;
f6df392dddbb9e Ben Skeggs 2021-02-08  77  		case 0x00000013: I_(NVKM_ENGINE_CE    , inst); break;
f6df392dddbb9e Ben Skeggs 2021-02-08  78  		case 0x00000014: O_(NVKM_SUBDEV_GSP   ,    0); break;
f6df392dddbb9e Ben Skeggs 2021-02-08  79  		case 0x00000015: O_(NVKM_ENGINE_NVJPG ,    0); break;
f6df392dddbb9e Ben Skeggs 2021-02-08  80  		case 0x00000016: O_(NVKM_ENGINE_OFA   ,    0); break;
f6df392dddbb9e Ben Skeggs 2021-02-08  81  		case 0x00000017: O_(NVKM_SUBDEV_FLA   ,    0); break;
f6df392dddbb9e Ben Skeggs 2021-02-08 @82  			break;
f6df392dddbb9e Ben Skeggs 2021-02-08  83  		default:
f6df392dddbb9e Ben Skeggs 2021-02-08  84  			break;
f6df392dddbb9e Ben Skeggs 2021-02-08  85  		}
f6df392dddbb9e Ben Skeggs 2021-02-08  86  
f6df392dddbb9e Ben Skeggs 2021-02-08  87  		nvkm_debug(subdev, "%02x.%d (%8s): addr %06x fault %2d "
49b2dfc0818268 Ben Skeggs 2021-09-17  88  				   "runlist %6x engine %2d reset %2d\n", type, inst,
f6df392dddbb9e Ben Skeggs 2021-02-08  89  			   info->type == NVKM_SUBDEV_NR ? "????????" : nvkm_subdev_type[info->type],
49b2dfc0818268 Ben Skeggs 2021-09-17  90  			   info->addr, info->fault, info->runlist < 0 ? 0 : info->runlist,
49b2dfc0818268 Ben Skeggs 2021-09-17  91  			   info->engine, info->reset);
f6df392dddbb9e Ben Skeggs 2021-02-08  92  		info = NULL;
f6df392dddbb9e Ben Skeggs 2021-02-08  93  	}
f6df392dddbb9e Ben Skeggs 2021-02-08  94  
f6df392dddbb9e Ben Skeggs 2021-02-08  95  	return 0;
f6df392dddbb9e Ben Skeggs 2021-02-08  96  }
f6df392dddbb9e Ben Skeggs 2021-02-08  97  

:::::: The code at line 82 was first introduced by commit
:::::: f6df392dddbb9e637b785e7e3d9337a74923dc10 drm/nouveau/top/ga100: initial support

:::::: TO: Ben Skeggs <bskeggs@redhat.com>
:::::: CC: Ben Skeggs <bskeggs@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
