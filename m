Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF027CC31D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234970AbjJQM0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234909AbjJQMZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:25:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6E910E;
        Tue, 17 Oct 2023 05:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697545556; x=1729081556;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qzWNPz+ZBf8GlExjCnXpGycOt5NK4c0obJu1ee4oKJo=;
  b=gcTtGRdfcFOhSmRz6RIMN/da/k8M0UB3B/2X+d5m54AN7rk9q1r6uLHh
   hfZ0ZD0HpEkTuDibAEwovIw5QN6dVAo3G9NR0vHW1u3HOx3r8dL5edHy0
   2pCZ+FRrE42MMcZOMt7laq2skTZl1ofX2DNrfe1WTlK7oSM1mU6UgFqvV
   klNJ6IFmjaIASDp5UR1dWuDSlzLuLYqY8JwGCOgSWxEZXUxT6w8RUgTIA
   2Ywowfd4yeqV0h78GPWnjm2OHh62s7Nfp7C9YWybjND2+3HEmZEK/+yhk
   iWdCsC2xoWjydnkL1oHeUNCV0ssBpIlJvSm+jCci/tkDsATVtKxNkTjDX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="366029429"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="366029429"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 05:25:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="749669238"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="749669238"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 17 Oct 2023 05:25:53 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qsj8w-0009aD-2i;
        Tue, 17 Oct 2023 12:25:50 +0000
Date:   Tue, 17 Oct 2023 20:25:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Muhammad Muzammil <m.muzzammilashraf@gmail.com>,
        james.smart@broadcom.com, dick.kennedy@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Muhammad Muzammil <m.muzzammilashraf@gmail.com>
Subject: Re: [PATCH] drivers: scsi: lpfc: Fixed multiple typos in multiple
 files
Message-ID: <202310172003.DMJaJSon-lkp@intel.com>
References: <20231014115551.8607-1-m.muzzammilashraf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231014115551.8607-1-m.muzzammilashraf@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Muhammad,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mkp-scsi/for-next]
[also build test WARNING on jejb-scsi/for-next linus/master v6.6-rc6 next-20231017]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Muhammad-Muzammil/drivers-scsi-lpfc-Fixed-multiple-typos-in-multiple-files/20231017-132518
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git for-next
patch link:    https://lore.kernel.org/r/20231014115551.8607-1-m.muzzammilashraf%40gmail.com
patch subject: [PATCH] drivers: scsi: lpfc: Fixed multiple typos in multiple files
config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20231017/202310172003.DMJaJSon-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231017/202310172003.DMJaJSon-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310172003.DMJaJSon-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/scsi/lpfc/lpfc_debugfs.c: In function 'lpfc_idiag_cmd_get':
   drivers/scsi/lpfc/lpfc_debugfs.c:3155:1: error: expected expression before '.' token
    3155 | .
         | ^
>> drivers/scsi/lpfc/lpfc_debugfs.c:3150:16: warning: variable 'bsize' set but not used [-Wunused-but-set-variable]
    3150 |         size_t bsize;
         |                ^~~~~


vim +/bsize +3150 drivers/scsi/lpfc/lpfc_debugfs.c

e2a0a9d69ce224c James Smart       2008-12-04  3119  
2a622bfbe1d9566 James Smart       2011-02-16  3120  /*
86a80846a68eeb8 James Smart       2011-04-16  3121   * ---------------------------------
2a622bfbe1d9566 James Smart       2011-02-16  3122   * iDiag debugfs file access methods
86a80846a68eeb8 James Smart       2011-04-16  3123   * ---------------------------------
2a622bfbe1d9566 James Smart       2011-02-16  3124   *
86a80846a68eeb8 James Smart       2011-04-16  3125   * All access methods are through the proper SLI4 PCI function's debugfs
86a80846a68eeb8 James Smart       2011-04-16  3126   * iDiag directory:
2a622bfbe1d9566 James Smart       2011-02-16  3127   *
2a622bfbe1d9566 James Smart       2011-02-16  3128   *     /sys/kernel/debug/lpfc/fn<#>/iDiag
2a622bfbe1d9566 James Smart       2011-02-16  3129   */
2a622bfbe1d9566 James Smart       2011-02-16  3130  
2a622bfbe1d9566 James Smart       2011-02-16  3131  /**
2a622bfbe1d9566 James Smart       2011-02-16  3132   * lpfc_idiag_cmd_get - Get and parse idiag debugfs comands from user space
2a622bfbe1d9566 James Smart       2011-02-16  3133   * @buf: The pointer to the user space buffer.
2a622bfbe1d9566 James Smart       2011-02-16  3134   * @nbytes: The number of bytes in the user space buffer.
2a622bfbe1d9566 James Smart       2011-02-16  3135   * @idiag_cmd: pointer to the idiag command struct.
2a622bfbe1d9566 James Smart       2011-02-16  3136   *
2a622bfbe1d9566 James Smart       2011-02-16  3137   * This routine reads data from debugfs user space buffer and parses the
2a622bfbe1d9566 James Smart       2011-02-16  3138   * buffer for getting the idiag command and arguments. The while space in
2a622bfbe1d9566 James Smart       2011-02-16  3139   * between the set of data is used as the parsing separator.
2a622bfbe1d9566 James Smart       2011-02-16  3140   *
2a622bfbe1d9566 James Smart       2011-02-16  3141   * This routine returns 0 when successful, it returns proper error code
2a622bfbe1d9566 James Smart       2011-02-16  3142   * back to the user space in error conditions.
2a622bfbe1d9566 James Smart       2011-02-16  3143   */
2a622bfbe1d9566 James Smart       2011-02-16  3144  static int lpfc_idiag_cmd_get(const char __user *buf, size_t nbytes,
2a622bfbe1d9566 James Smart       2011-02-16  3145  			      struct lpfc_idiag_cmd *idiag_cmd)
2a622bfbe1d9566 James Smart       2011-02-16  3146  {
2a622bfbe1d9566 James Smart       2011-02-16  3147  	char mybuf[64];
2a622bfbe1d9566 James Smart       2011-02-16  3148  	char *pbuf, *step_str;
b11d48e898de3cb Stephen Boyd      2011-05-12  3149  	int i;
b11d48e898de3cb Stephen Boyd      2011-05-12 @3150  	size_t bsize;
2a622bfbe1d9566 James Smart       2011-02-16  3151  
2a622bfbe1d9566 James Smart       2011-02-16  3152  	memset(mybuf, 0, sizeof(mybuf));
2a622bfbe1d9566 James Smart       2011-02-16  3153  	memset(idiag_cmd, 0, sizeof(*idiag_cmd));
2a622bfbe1d9566 James Smart       2011-02-16  3154  	bsize = min(nbytes, (sizeof(mybuf)-1));
46758a53dff3da8 Muhammad Muzammil 2023-10-14  3155  .
2a622bfbe1d9566 James Smart       2011-02-16  3156  	if (copy_from_user(mybuf, buf, bsize))
2a622bfbe1d9566 James Smart       2011-02-16  3157  		return -EFAULT;
2a622bfbe1d9566 James Smart       2011-02-16  3158  	pbuf = &mybuf[0];
2a622bfbe1d9566 James Smart       2011-02-16  3159  	step_str = strsep(&pbuf, "\t ");
2a622bfbe1d9566 James Smart       2011-02-16  3160  
2a622bfbe1d9566 James Smart       2011-02-16  3161  	/* The opcode must present */
2a622bfbe1d9566 James Smart       2011-02-16  3162  	if (!step_str)
2a622bfbe1d9566 James Smart       2011-02-16  3163  		return -EINVAL;
2a622bfbe1d9566 James Smart       2011-02-16  3164  
2a622bfbe1d9566 James Smart       2011-02-16  3165  	idiag_cmd->opcode = simple_strtol(step_str, NULL, 0);
2a622bfbe1d9566 James Smart       2011-02-16  3166  	if (idiag_cmd->opcode == 0)
2a622bfbe1d9566 James Smart       2011-02-16  3167  		return -EINVAL;
2a622bfbe1d9566 James Smart       2011-02-16  3168  
2a622bfbe1d9566 James Smart       2011-02-16  3169  	for (i = 0; i < LPFC_IDIAG_CMD_DATA_SIZE; i++) {
2a622bfbe1d9566 James Smart       2011-02-16  3170  		step_str = strsep(&pbuf, "\t ");
2a622bfbe1d9566 James Smart       2011-02-16  3171  		if (!step_str)
86a80846a68eeb8 James Smart       2011-04-16  3172  			return i;
2a622bfbe1d9566 James Smart       2011-02-16  3173  		idiag_cmd->data[i] = simple_strtol(step_str, NULL, 0);
2a622bfbe1d9566 James Smart       2011-02-16  3174  	}
86a80846a68eeb8 James Smart       2011-04-16  3175  	return i;
2a622bfbe1d9566 James Smart       2011-02-16  3176  }
2a622bfbe1d9566 James Smart       2011-02-16  3177  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
