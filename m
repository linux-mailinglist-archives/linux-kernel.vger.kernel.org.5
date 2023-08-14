Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E175F77C013
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 20:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbjHNSxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 14:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbjHNSxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 14:53:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1CD0E5E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 11:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692039209; x=1723575209;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=A6/OezY9wqi1bscssQwj+0RPkna6iFRD78EKSwi+hco=;
  b=j8BHzUt3zGudQwGUBx4CxM5h/GBVIa+RQwlVx74XnI9jK2obkRFSMP7b
   KNlniONsMRHKCrfWqhT9bxm6jHKmepNG8LZZAYVrX/e0xW/t6o/Tr159I
   Fnxv0rnNXDIOrthdiZ7Y/UucVfhIGVblOGHCx0p550xxpePJ4PQpFgAH8
   Kj3R/x8r8zN2uMCTg9wA/g3xmkSIvPU0fk71WApFE+LOQ1vUt023Gz4a0
   2MoHblevFPGkMkmd9akVpDOfiAWOfLLw3oPzjpMOPqxVnT7uQqejraZAi
   7rfRlMy/mtYd985UB9toyc2eueKhPLeCnjIKYWxesi81iVWzdtloyjNOd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="351703387"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="351703387"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 11:52:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="823566681"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="823566681"
Received: from lkp-server02.sh.intel.com (HELO b5fb8d9e1ffc) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Aug 2023 11:52:39 -0700
Received: from kbuild by b5fb8d9e1ffc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qVcgA-0000M5-2W;
        Mon, 14 Aug 2023 18:52:38 +0000
Date:   Tue, 15 Aug 2023 02:51:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Borislav Petkov (AMD)" <bp@alien8.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: [tip:master 20/20] arch/x86/include/asm/microcode.h:29:20: error:
 redefinition of 'amd_check_microcode'
Message-ID: <202308150231.ThoHOoid-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
head:   d2915b8e76b3a598febd7348799d745cb741a2f5
commit: d2915b8e76b3a598febd7348799d745cb741a2f5 [20/20] Merge x86/microcode into tip/master
config: i386-debian-10.3 (https://download.01.org/0day-ci/archive/20230815/202308150231.ThoHOoid-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230815/202308150231.ThoHOoid-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308150231.ThoHOoid-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/x86/kernel/smpboot.c:80:
>> arch/x86/include/asm/microcode.h:29:20: error: redefinition of 'amd_check_microcode'
      29 | static inline void amd_check_microcode(void) {}
         |                    ^~~~~~~~~~~~~~~~~~~
   In file included from arch/x86/include/asm/cpufeature.h:5,
                    from arch/x86/include/asm/thread_info.h:53,
                    from include/linux/thread_info.h:60,
                    from arch/x86/include/asm/preempt.h:9,
                    from include/linux/preempt.h:79,
                    from include/linux/smp.h:110,
                    from arch/x86/kernel/smpboot.c:43:
   arch/x86/include/asm/processor.h:694:20: note: previous definition of 'amd_check_microcode' with type 'void(void)'
     694 | static inline void amd_check_microcode(void)            { }
         |                    ^~~~~~~~~~~~~~~~~~~


vim +/amd_check_microcode +29 arch/x86/include/asm/microcode.h

    25	
    26	#ifdef CONFIG_CPU_SUP_AMD
    27	extern void amd_check_microcode(void);
    28	#else
  > 29	static inline void amd_check_microcode(void) {}
    30	#endif
    31	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
