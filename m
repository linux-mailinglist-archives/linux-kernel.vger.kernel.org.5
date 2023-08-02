Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4364776D8A4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 22:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbjHBUYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 16:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232493AbjHBUYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 16:24:38 -0400
Received: from mgamail.intel.com (unknown [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F583586
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 13:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691007838; x=1722543838;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wNJE+tHOkA2JBFbffGog0gKl+eASCvV9DEWQPDfL5Iw=;
  b=DJBm5jqbp3wzHbbjA992e5AzgQriKgsO9xVMYR9k/iHOybqhsc6j/aeN
   nckHBsiCGmxEMbuqLDZ/0eMRqjaRVZtNX+QxX1KhlOnrbaBhBFPTQ+ycq
   mrDmGM63hiG0GxvvyKu5/AMEEm3M9K23V/OmsU+KYqicViMR7clGBBDCU
   OwNrbrPd6m1foLj9H1rlB2rGpUVLErnv959OOL3EIzS/0KfMG2+AIDZS8
   2EdqZxoFFhuh9LAvgzpHzrAzVfBrAc0FHd+nY7+bDccjK7ha+jlYCNUB+
   smOCR6jJMom/sU/f4D5UVy/jA3NDcrloKOvRIktWjaaqyX1FnX42Fn0Kn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="436007942"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; 
   d="scan'208";a="436007942"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 13:23:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="975808122"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; 
   d="scan'208";a="975808122"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 02 Aug 2023 13:23:26 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qRINQ-0001Sh-31;
        Wed, 02 Aug 2023 20:23:24 +0000
Date:   Thu, 3 Aug 2023 04:23:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>, perex@perex.cz,
        tiwai@suse.com, pierre-louis.bossart@linux.intel.com,
        zhangyiqun@phytium.com.cn, peter.ujfalusi@linux.intel.com,
        broonie@kernel.org, chenhuacai@kernel.org,
        cezary.rojewski@intel.com, siyanteng@loongson.cn,
        amadeuszx.slawinski@linux.intel.com, evan.quan@amd.com,
        jasontao@glenfly.com, kai.vehmanen@linux.intel.com,
        ranjani.sridharan@linux.intel.com, mkumard@nvidia.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, CobeChen@zhaoxin.com,
        TimGuo@zhaoxin.com, LeoLiu-oc@zhaoxin.com
Subject: Re: [PATCH] ALSA: hda: Zhaoxin: Add HDAC PCI IDs and HDMI Codec
 Vendor IDs
Message-ID: <202308030402.Y1yMDGnZ-lkp@intel.com>
References: <20230731055932.4336-1-TonyWWang-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731055932.4336-1-TonyWWang-oc@zhaoxin.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tiwai-sound/for-next]
[also build test WARNING on next-20230802]
[cannot apply to tiwai-sound/for-linus linus/master v6.5-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tony-W-Wang-oc/ALSA-hda-Zhaoxin-Add-HDAC-PCI-IDs-and-HDMI-Codec-Vendor-IDs/20230731-140118
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-next
patch link:    https://lore.kernel.org/r/20230731055932.4336-1-TonyWWang-oc%40zhaoxin.com
patch subject: [PATCH] ALSA: hda: Zhaoxin: Add HDAC PCI IDs and HDMI Codec Vendor IDs
config: nios2-randconfig-r093-20230730 (https://download.01.org/0day-ci/archive/20230803/202308030402.Y1yMDGnZ-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230803/202308030402.Y1yMDGnZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308030402.Y1yMDGnZ-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> sound/pci/hda/hda_controller.c:1051:38: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pci/hda/hda_controller.c:1051:66: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got char * @@
   sound/pci/hda/hda_controller.c:1051:66: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/hda/hda_controller.c:1051:66: sparse:     got char *
   sound/pci/hda/hda_controller.c:1053:44: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/hda/hda_controller.c:1053:72: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got char * @@
   sound/pci/hda/hda_controller.c:1053:72: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/hda/hda_controller.c:1053:72: sparse:     got char *

vim +/__iomem +1051 sound/pci/hda/hda_controller.c

  1046	
  1047	static void azx_rirb_zxdelay(struct azx *chip, int enable)
  1048	{
  1049		if (chip->remap_diu_addr) {
  1050			if (!enable)
> 1051				writel(0x0, (char *)chip->remap_diu_addr + 0x490a8);
  1052			else
  1053				writel(0x1000000, (char *)chip->remap_diu_addr + 0x490a8);
  1054		}
  1055	}
  1056	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
