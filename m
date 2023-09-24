Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04F87AC6B7
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 08:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjIXGMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 02:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXGL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 02:11:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E05101;
        Sat, 23 Sep 2023 23:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695535913; x=1727071913;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Am/C7rcrG3whSnD6O+2kBFSeQ5loFPvQ7ufrZXfmhzg=;
  b=K0vDoSLIA71ShvLeBY6rnO5VUoeBQgMyDGxTDjIrDL1oSFrtzrNaIh0U
   +p1WLKf6S2NtV0WUBYUGAF+7VBXAlB1WOPY1JbkGGLJ7DH+GQN667Q7m1
   +na6nxuFh6ZePSIqHg2dc6ci50MOp1vmxpkfeiASCuS+3xQB2f6GlpHj+
   JCrjsS4vLYGkoj7qY//mp89PouWk+PKFTytuacTto02b2qrNB8zkgScYc
   FXr77kPYvHyvf5OMsOEyZV7UvfM5CQrDAOYw1ftd8KzKmLTO+l75AXZeI
   wjcihCCRa+1cQMwyKxcOyMlSDOzcMMXQ6vQjqNmCruuolvwDbrL68Z+Vy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10842"; a="371397983"
X-IronPort-AV: E=Sophos;i="6.03,171,1694761200"; 
   d="scan'208";a="371397983"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2023 23:11:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10842"; a="995002189"
X-IronPort-AV: E=Sophos;i="6.03,171,1694761200"; 
   d="scan'208";a="995002189"
Received: from lkp-server02.sh.intel.com (HELO 493f6c7fed5d) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 23 Sep 2023 23:11:49 -0700
Received: from kbuild by 493f6c7fed5d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qkILL-0003JF-21;
        Sun, 24 Sep 2023 06:11:47 +0000
Date:   Sun, 24 Sep 2023 14:11:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     ching Huang <ching2048@areca.com.tw>, martin.petersen@oracle.com,
        James.Bottomley@hansenpartnership.com, linux-scsi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH V2 1/3] scsi: arcmsr: support Areca ARC-1688 Raid
 controller
Message-ID: <202309241359.nvcTUvcu-lkp@intel.com>
References: <bc855b702c8a2fbb7d3ffff69f65b6ce89c9042c.camel@areca.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc855b702c8a2fbb7d3ffff69f65b6ce89c9042c.camel@areca.com.tw>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ching,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mkp-scsi/for-next]
[also build test WARNING on jejb-scsi/for-next linus/master v6.6-rc2 next-20230921]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/ching-Huang/scsi-arcmsr-support-Areca-ARC-1688-Raid-controller/20230922-170045
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git for-next
patch link:    https://lore.kernel.org/r/bc855b702c8a2fbb7d3ffff69f65b6ce89c9042c.camel%40areca.com.tw
patch subject: [PATCH V2 1/3] scsi: arcmsr: support Areca ARC-1688 Raid controller
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20230924/202309241359.nvcTUvcu-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230924/202309241359.nvcTUvcu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309241359.nvcTUvcu-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/scsi/arcmsr/arcmsr_hba.c: In function 'arcmsr_free_ccb_pool':
>> drivers/scsi/arcmsr/arcmsr_hba.c:2094:53: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    2094 |                                 pXorPhys->xorPhys = (dma_addr_t)NULL;
         |                                                     ^


vim +2094 drivers/scsi/arcmsr/arcmsr_hba.c

  2077	
  2078	static void arcmsr_free_ccb_pool(struct AdapterControlBlock *acb)
  2079	{
  2080		if (acb->xor_mega) {
  2081			struct Xor_sg *pXorPhys;
  2082			void **pXorVirt;
  2083			int i;
  2084	
  2085			pXorPhys = (struct Xor_sg *)(acb->xorVirt +
  2086				sizeof(struct HostRamBuf));
  2087			pXorVirt = (void **)((unsigned long)acb->xorVirt +
  2088				(unsigned long)acb->xorVirtOffset);
  2089			for (i = 0; i < acb->xor_mega; i++) {
  2090				if (pXorPhys->xorPhys) {
  2091					dma_free_coherent(&acb->pdev->dev,
  2092						ARCMSR_XOR_SEG_SIZE,
  2093						*pXorVirt, pXorPhys->xorPhys);
> 2094					pXorPhys->xorPhys = (dma_addr_t)NULL;
  2095					*pXorVirt = NULL;
  2096				}
  2097				pXorPhys++;
  2098				pXorVirt++;
  2099			}
  2100			dma_free_coherent(&acb->pdev->dev, acb->init2cfg_size,
  2101				acb->xorVirt, acb->xorPhys);
  2102		}
  2103		dma_free_coherent(&acb->pdev->dev, acb->uncache_size, acb->dma_coherent, acb->dma_coherent_handle);
  2104	}
  2105	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
