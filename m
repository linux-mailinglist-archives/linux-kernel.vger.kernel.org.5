Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF3A7EE954
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 23:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjKPWgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 17:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKPWgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 17:36:10 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF33127;
        Thu, 16 Nov 2023 14:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700174167; x=1731710167;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PCo7Q6PwYdHeBIXeCSZfw9NiH4RVxY6/REL0RfEZyvU=;
  b=bbEIPMSNVYwGxPxMGK9CuKBihlX+X/8RAPHFrarE54YVtHvcO8vNzqc5
   5ngAl0Gh7K58a0GpRk5MbFc7Z3f91jpl35SZVn93Y44YQuaQtthA+Vy9R
   hpMQj+VeOJUzB9g+ergi1Go+hrdCYS1JGM0sp2kEB5pfSvyS+ufAIwbPl
   M4AppyDdLO4F0bg2EZszHMyY2kPmgdSD/KSdD49YLrLSWoHSdpaaLWjID
   gIyp/BaPGD+jLVBMfxfraoEiLD2uehJykDbHa469Gx37vLRzxZMx8bZOb
   p6+kUxZD4qIJ17blXvAPq+Q5lU4+mUHlEaQLzYdcNRTPU5oRn035oJlhw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="4323650"
X-IronPort-AV: E=Sophos;i="6.04,205,1695711600"; 
   d="scan'208";a="4323650"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 14:36:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="938977790"
X-IronPort-AV: E=Sophos;i="6.04,205,1695711600"; 
   d="scan'208";a="938977790"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 16 Nov 2023 14:36:00 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r3kxp-00026s-2X;
        Thu, 16 Nov 2023 22:35:57 +0000
Date:   Fri, 17 Nov 2023 06:35:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yi-De Wu <yi-de.wu@mediatek.com>,
        Yingshiuan Pan <yingshiuan.pan@mediatek.com>,
        Ze-Yu Wang <ze-yu.wang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     oe-kbuild-all@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        David Bradil <dbrazdil@google.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Jade Shih <jades.shih@mediatek.com>,
        Ivan Tseng <ivan.tseng@mediatek.com>,
        My Chuang <my.chuang@mediatek.com>,
        Shawn Hsiao <shawn.hsiao@mediatek.com>,
        PeiLun Suei <peilun.suei@mediatek.com>,
        Liju Chen <liju-clr.chen@mediatek.com>,
        Willix Yeh <chi-shen.yeh@mediatek.com>,
        Kevenny Hsieh <kevenny.hsieh@mediatek.com>
Subject: Re: [PATCH v7 03/16] virt: geniezone: Add GenieZone hypervisor driver
Message-ID: <202311170638.aouOEHi7-lkp@intel.com>
References: <20231116152756.4250-4-yi-de.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116152756.4250-4-yi-de.wu@mediatek.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yi-De,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.7-rc1 next-20231116]
[cannot apply to arm64/for-next/core robh/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yi-De-Wu/docs-geniezone-Introduce-GenieZone-hypervisor/20231116-233442
base:   linus/master
patch link:    https://lore.kernel.org/r/20231116152756.4250-4-yi-de.wu%40mediatek.com
patch subject: [PATCH v7 03/16] virt: geniezone: Add GenieZone hypervisor driver
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20231117/202311170638.aouOEHi7-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231117/202311170638.aouOEHi7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311170638.aouOEHi7-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/arm64/geniezone/vm.c:25: warning: Function parameter or member 'a0' not described in 'gzvm_hypcall_wrapper'
>> arch/arm64/geniezone/vm.c:25: warning: Function parameter or member 'a1' not described in 'gzvm_hypcall_wrapper'
>> arch/arm64/geniezone/vm.c:25: warning: Function parameter or member 'a2' not described in 'gzvm_hypcall_wrapper'
>> arch/arm64/geniezone/vm.c:25: warning: Function parameter or member 'a3' not described in 'gzvm_hypcall_wrapper'
>> arch/arm64/geniezone/vm.c:25: warning: Function parameter or member 'a4' not described in 'gzvm_hypcall_wrapper'
>> arch/arm64/geniezone/vm.c:25: warning: Function parameter or member 'a5' not described in 'gzvm_hypcall_wrapper'
>> arch/arm64/geniezone/vm.c:25: warning: Function parameter or member 'a6' not described in 'gzvm_hypcall_wrapper'
>> arch/arm64/geniezone/vm.c:25: warning: Function parameter or member 'a7' not described in 'gzvm_hypcall_wrapper'


vim +25 arch/arm64/geniezone/vm.c

    12	
    13	/**
    14	 * gzvm_hypcall_wrapper() - the wrapper for hvc calls
    15	 * @a0-a7: arguments passed in registers 0 to 7
    16	 * @res: result values from registers 0 to 3
    17	 *
    18	 * Return: The wrapper helps caller to convert geniezone errno to Linux errno.
    19	 */
    20	int gzvm_hypcall_wrapper(unsigned long a0, unsigned long a1,
    21				 unsigned long a2, unsigned long a3,
    22				 unsigned long a4, unsigned long a5,
    23				 unsigned long a6, unsigned long a7,
    24				 struct arm_smccc_res *res)
  > 25	{
    26		arm_smccc_hvc(a0, a1, a2, a3, a4, a5, a6, a7, res);
    27		return gzvm_err_to_errno(res->a0);
    28	}
    29	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
