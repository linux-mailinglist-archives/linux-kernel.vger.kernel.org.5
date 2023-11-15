Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF337EC91C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 18:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbjKORAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 12:00:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232647AbjKORAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 12:00:08 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C265ED5A;
        Wed, 15 Nov 2023 08:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700067590; x=1731603590;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9uKcFY4QauvFYKvl+Sytq0IYlA4lqNfQ+9TYosW5GMY=;
  b=JWdTfZQthlTo4/EWoOR8WbNQBxo1JjwdH/3VO7e4Zm0qMpT4qZW8frkh
   fkjo3BNfK/p3AuW66xz5t75ZAG40x/XLlwsOd/KXbTj4Jjvu8oThMfb/u
   A4YT6y2pZOk7fZLpYQOJyi62kDg3uu5uZlLQYupMxZYy5T1wT0wAqRs65
   m23fWF4oeRqV5F3lqTXCCcZ2umNuOoCQUWuHMsRBcmsBNFlGTNXMcLVRm
   X86LZrToi8JZvCstooFwLGL/JuplLgYoknhmW+gfpjOr1uzYkaud7bXMA
   gWgCd1rojHbXRkGaKAM3q8wT5RecFDBA+3PAddODp1qSovcq65eIPOCoM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="375952888"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="375952888"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 08:59:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="6220123"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 15 Nov 2023 08:59:30 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r3JEe-0000c8-0k;
        Wed, 15 Nov 2023 16:59:28 +0000
Date:   Thu, 16 Nov 2023 00:58:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, kexec@lists.infradead.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-parisc@vger.kernel.org, Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 4/7] kexec_file, arm64: print out debugging message if
 required
Message-ID: <202311160022.QM6xJYSy-lkp@intel.com>
References: <20231114153253.241262-5-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114153253.241262-5-bhe@redhat.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baoquan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on arm64/for-next/core]
[also build test WARNING on tip/x86/core powerpc/next powerpc/fixes linus/master v6.7-rc1 next-20231115]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Baoquan-He/kexec_file-add-kexec_file-flag-to-control-debug-printing/20231114-234003
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
patch link:    https://lore.kernel.org/r/20231114153253.241262-5-bhe%40redhat.com
patch subject: [PATCH 4/7] kexec_file, arm64: print out debugging message if required
config: arm64-randconfig-001-20231115 (https://download.01.org/0day-ci/archive/20231116/202311160022.QM6xJYSy-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231116/202311160022.QM6xJYSy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311160022.QM6xJYSy-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/arm64/kernel/machine_kexec.c: In function '_kexec_image_info':
>> arch/arm64/kernel/machine_kexec.c:35:23: warning: unused variable 'i' [-Wunused-variable]
      35 |         unsigned long i;
         |                       ^


vim +/i +35 arch/arm64/kernel/machine_kexec.c

d28f6df1305a86 Geoff Levand 2016-06-23  27  
221f2c770e10d3 Geoff Levand 2016-06-23  28  /**
221f2c770e10d3 Geoff Levand 2016-06-23  29   * kexec_image_info - For debugging output.
221f2c770e10d3 Geoff Levand 2016-06-23  30   */
221f2c770e10d3 Geoff Levand 2016-06-23  31  #define kexec_image_info(_i) _kexec_image_info(__func__, __LINE__, _i)
221f2c770e10d3 Geoff Levand 2016-06-23  32  static void _kexec_image_info(const char *func, int line,
221f2c770e10d3 Geoff Levand 2016-06-23  33  	const struct kimage *kimage)
221f2c770e10d3 Geoff Levand 2016-06-23  34  {
221f2c770e10d3 Geoff Levand 2016-06-23 @35  	unsigned long i;
221f2c770e10d3 Geoff Levand 2016-06-23  36  
f24d07b8c8e272 Baoquan He   2023-11-14  37  	kexec_dprintk("%s:%d:\n", func, line);
f24d07b8c8e272 Baoquan He   2023-11-14  38  	kexec_dprintk("  kexec kimage info:\n");
f24d07b8c8e272 Baoquan He   2023-11-14  39  	kexec_dprintk("    type:        %d\n", kimage->type);
f24d07b8c8e272 Baoquan He   2023-11-14  40  	kexec_dprintk("    head:        %lx\n", kimage->head);
f24d07b8c8e272 Baoquan He   2023-11-14  41  	kexec_dprintk("    kern_reloc: %pa\n", &kimage->arch.kern_reloc);
f24d07b8c8e272 Baoquan He   2023-11-14  42  	kexec_dprintk("    el2_vectors: %pa\n", &kimage->arch.el2_vectors);
221f2c770e10d3 Geoff Levand 2016-06-23  43  }
221f2c770e10d3 Geoff Levand 2016-06-23  44  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
