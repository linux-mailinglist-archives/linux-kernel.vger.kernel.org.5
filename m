Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4847CB8D1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 04:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbjJQC7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 22:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJQC7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 22:59:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4CB8F
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 19:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697511589; x=1729047589;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=s/sfhtGoO4KxlkQ1AHNgt1Mjea4LMBP+q+rgAq4vifI=;
  b=RBaU6UjB35VwYk23TxKRLfLggO9TTDF8uI4HCccuLc9zqdNKL3vPTfL7
   Jcs4E1Sl3LFd793QwCff5hyKjd4uCCOMVwk7lMMVv/lLu0sM7p+f+9SK7
   gkHC7nAJhj6jzU1/1bvhF+fuzmrRIQuLyWkWp5drqI6TtuxKpNzsCXlZP
   qfcCvJuW5gK16eWZN1OV8xDgtCm9cFl9Kwa1DawpT0cM74mSjrw4lbHaW
   HZjhKXnzPpf1YCIJfC160b4Y8y5hhelxZJnKxIHMSBVyLkdox5qIEffH/
   Yt2jCIDCvS5EgIaw8DZGuGELx/juJ+UYVq6fJgZa3BF6/TzAd24ZljiNf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="7252115"
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="7252115"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 19:59:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="821794626"
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="821794626"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 16 Oct 2023 19:59:47 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qsaJ7-0008tt-1b;
        Tue, 17 Oct 2023 02:59:45 +0000
Date:   Tue, 17 Oct 2023 10:58:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arch/x86/kernel/cpu/bugs.c:64:9: sparse: sparse: incorrect type in
 initializer (different address spaces)
Message-ID: <202310171043.kUlpXIoN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   58720809f52779dc0f08e53e54b014209d13eebb
commit: 481461f5109919babbb393d6f68002936b8e2493 linux/export.h: make <linux/export.h> independent of CONFIG_MODULES
date:   3 months ago
config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20231017/202310171043.kUlpXIoN-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231017/202310171043.kUlpXIoN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310171043.kUlpXIoN-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/x86/kernel/cpu/bugs.c:64:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long long * @@
   arch/x86/kernel/cpu/bugs.c:64:9: sparse:     expected void const [noderef] __percpu *__vpp_verify
   arch/x86/kernel/cpu/bugs.c:64:9: sparse:     got unsigned long long *
   arch/x86/kernel/cpu/bugs.c:74:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long long * @@
   arch/x86/kernel/cpu/bugs.c:74:13: sparse:     expected void const [noderef] __percpu *__vpp_verify
   arch/x86/kernel/cpu/bugs.c:74:13: sparse:     got unsigned long long *
   arch/x86/kernel/cpu/bugs.c:77:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long long * @@
   arch/x86/kernel/cpu/bugs.c:77:9: sparse:     expected void const [noderef] __percpu *__vpp_verify
   arch/x86/kernel/cpu/bugs.c:77:9: sparse:     got unsigned long long *
   arch/x86/kernel/cpu/bugs.c:89:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long long * @@
   arch/x86/kernel/cpu/bugs.c:89:16: sparse:     expected void const [noderef] __percpu *__vpp_verify
   arch/x86/kernel/cpu/bugs.c:89:16: sparse:     got unsigned long long *

vim +64 arch/x86/kernel/cpu/bugs.c

1b86883ccb8d5d Konrad Rzeszutek Wilk 2018-04-25  60  
66065157420c5b Pawan Gupta           2022-11-30  61  /* Update SPEC_CTRL MSR and its cached copy unconditionally */
66065157420c5b Pawan Gupta           2022-11-30  62  static void update_spec_ctrl(u64 val)
66065157420c5b Pawan Gupta           2022-11-30  63  {
66065157420c5b Pawan Gupta           2022-11-30 @64  	this_cpu_write(x86_spec_ctrl_current, val);
66065157420c5b Pawan Gupta           2022-11-30  65  	wrmsrl(MSR_IA32_SPEC_CTRL, val);
66065157420c5b Pawan Gupta           2022-11-30  66  }
66065157420c5b Pawan Gupta           2022-11-30  67  

:::::: The code at line 64 was first introduced by commit
:::::: 66065157420c5b9b3f078f43d313c153e1ff7f83 x86/bugs: Make sure MSR_SPEC_CTRL is updated properly upon resume from S3

:::::: TO: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
