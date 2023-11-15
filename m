Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A907ECA53
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 19:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjKOSSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 13:18:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjKOSSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 13:18:03 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C85318A
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 10:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700072278; x=1731608278;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tliLex30bPeRg8YZMNzNKhvYm2dourmm+z0S+mJLwEI=;
  b=aFUdtXz2v8RSiWjV7P1yftT15KI4cnamYtlShFbq+s6iQzUxZBwgMk1J
   m5CXKL7+RcKvKzz8lrbqtxs4LTDfLqgpP3oUlYKbMITeEVEfBtrGz2nuK
   Mebiw7FpLVJIDlcGKqigq/pBKqW5Pf0KxNODAHsJKIvb/245CqJgfhsOo
   d1ddmKHx3XaG8RKTozkRgRp01rgvJL0eJVxDTExGinNsjB7jmVMak/nDU
   6fneBYrAOcI3lk22nbcThlB8TVxpxZUBfIlFl+AWVMBu7UGN+o5NDjcL+
   6p0W2ZwVO5nvnqthkHtCg3KOah0lPkkN6Jri/q0AB4A9Me6+UKGxb5rvd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="4007100"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="4007100"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 10:17:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="882463316"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="882463316"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 15 Nov 2023 10:17:56 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r3KSY-0000hS-2C;
        Wed, 15 Nov 2023 18:17:54 +0000
Date:   Thu, 16 Nov 2023 02:17:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
Subject: lib/iov_iter.c:27:40: sparse: sparse: incorrect type in argument 1
 (different address spaces)
Message-ID: <202311160203.T48OaruS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c42d9eeef8e5ba9292eda36fd8e3c11f35ee065c
commit: f1982740f5e77090bde41a9b84e257d69ec46598 iov_iter: Convert iterate*() to inline funcs
date:   7 weeks ago
config: csky-randconfig-r111-20231115 (https://download.01.org/0day-ci/archive/20231116/202311160203.T48OaruS-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231116/202311160203.T48OaruS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311160203.T48OaruS-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> lib/iov_iter.c:27:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *iter_to @@
   lib/iov_iter.c:27:40: sparse:     expected void *to
   lib/iov_iter.c:27:40: sparse:     got void [noderef] __user *iter_to
   lib/iov_iter.c:57:46: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void [noderef] __user *iter_from @@
   lib/iov_iter.c:57:46: sparse:     expected void const *from
   lib/iov_iter.c:57:46: sparse:     got void [noderef] __user *iter_from
   lib/iov_iter.c: note: in included file (through include/linux/sched/task.h, include/linux/sched/signal.h, include/linux/rcuwait.h, ...):
   include/linux/uaccess.h:87:38: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   include/linux/uaccess.h:87:38: sparse:     expected void const *from
   include/linux/uaccess.h:87:38: sparse:     got void const [noderef] __user *from
   lib/iov_iter.c: note: in included file:
   include/net/checksum.h:33:39: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected restricted __wsum [usertype] sum @@     got unsigned int @@
   include/net/checksum.h:33:39: sparse:     expected restricted __wsum [usertype] sum
   include/net/checksum.h:33:39: sparse:     got unsigned int
   include/net/checksum.h:41:45: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected restricted __wsum [usertype] sum @@     got unsigned int @@
   include/net/checksum.h:41:45: sparse:     expected restricted __wsum [usertype] sum
   include/net/checksum.h:41:45: sparse:     got unsigned int

vim +27 lib/iov_iter.c

    17	
    18	static __always_inline
    19	size_t copy_to_user_iter(void __user *iter_to, size_t progress,
    20				 size_t len, void *from, void *priv2)
    21	{
    22		if (should_fail_usercopy())
    23			return len;
    24		if (access_ok(iter_to, len)) {
    25			from += progress;
    26			instrument_copy_to_user(iter_to, from, len);
  > 27			len = raw_copy_to_user(iter_to, from, len);
    28		}
    29		return len;
    30	}
    31	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
