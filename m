Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69AA7B489D
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 18:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235211AbjJAQ2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 12:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235093AbjJAQ2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 12:28:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608D594
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 09:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696177701; x=1727713701;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=z3LmYLHiVQAB7n3rcPvH/hmrYyZ01zrLbQR69f/25YE=;
  b=VVaO5Q7Cbw9DHv/Em3qwo3/BzoKQyyESKjXTjd6eTStCIv3kygDE5yQ8
   LvtrWOYLyJz0uMdynJ2uYdt7toDq/w0u2UFzIsPAbRbBQdjEDEEV9puFs
   SKpupa0UTj3O3mJyqkmU3XCiUhzqtTYW6hYEkTsIMdeLu/uVO/mp0hQMC
   UTU7Lk83+vVYxe2sj0KjkjfLcYAlhltKXhHm9Vy1bCQke6jlxpT8Hj3Kt
   Kp8+3lNOqN99CWNGE04WKDugQoSUum7fyi3oG0IXdjG0N/7OFBegCBhJR
   bMjwcWH4EDoCXxLZ5m/SRkoCrhaqBfH9ms0BeQCLJ+1p9jvO1e6fiGd0L
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="382446807"
X-IronPort-AV: E=Sophos;i="6.03,191,1694761200"; 
   d="scan'208";a="382446807"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2023 09:28:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,191,1694761200"; 
   d="scan'208";a="1312113"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 01 Oct 2023 09:27:41 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qmzIn-0005Ej-0F;
        Sun, 01 Oct 2023 16:28:17 +0000
Date:   Mon, 2 Oct 2023 00:28:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rohan McLure <rmclure@linux.ibm.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: drivers/message/fusion/mptctl.c:1498:9: warning: 'strncpy' specified
 bound 12 equals destination size
Message-ID: <202310020020.1lO8acXY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rohan,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e402b08634b398e9feb94902c7adcf05bb8ba47d
commit: 6f0926c00565a91f3bd7ca1aa05db307daed5e0f powerpc/kcsan: Add KCSAN Support
date:   8 months ago
config: powerpc64-randconfig-003-20231001 (https://download.01.org/0day-ci/archive/20231002/202310020020.1lO8acXY-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231002/202310020020.1lO8acXY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310020020.1lO8acXY-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In function 'mptctl_readtest',
       inlined from '__mptctl_ioctl' at drivers/message/fusion/mptctl.c:659:10:
>> drivers/message/fusion/mptctl.c:1498:9: warning: 'strncpy' specified bound 12 equals destination size [-Wstringop-truncation]
    1498 |         strncpy (karg.product, ioc->prod_name, MPT_PRODUCT_LENGTH);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/strncpy +1498 drivers/message/fusion/mptctl.c

^1da177e4c3f41 Linus Torvalds  2005-04-16  1463  
^1da177e4c3f41 Linus Torvalds  2005-04-16  1464  /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
^1da177e4c3f41 Linus Torvalds  2005-04-16  1465  /* MPT IOCTL Test function.
^1da177e4c3f41 Linus Torvalds  2005-04-16  1466   *
^1da177e4c3f41 Linus Torvalds  2005-04-16  1467   * Outputs:	None.
^1da177e4c3f41 Linus Torvalds  2005-04-16  1468   * Return:	0 if successful
^1da177e4c3f41 Linus Torvalds  2005-04-16  1469   *		-EFAULT if data unavailable
^1da177e4c3f41 Linus Torvalds  2005-04-16  1470   *		-ENODEV  if no such device/adapter
^1da177e4c3f41 Linus Torvalds  2005-04-16  1471   */
^1da177e4c3f41 Linus Torvalds  2005-04-16  1472  static int
28d76df18f0ad5 Dan Carpenter   2020-01-14  1473  mptctl_readtest (MPT_ADAPTER *ioc, unsigned long arg)
^1da177e4c3f41 Linus Torvalds  2005-04-16  1474  {
^1da177e4c3f41 Linus Torvalds  2005-04-16  1475  	struct mpt_ioctl_test __user *uarg = (void __user *) arg;
^1da177e4c3f41 Linus Torvalds  2005-04-16  1476  	struct mpt_ioctl_test	 karg;
^1da177e4c3f41 Linus Torvalds  2005-04-16  1477  
^1da177e4c3f41 Linus Torvalds  2005-04-16  1478  	if (copy_from_user(&karg, uarg, sizeof(struct mpt_ioctl_test))) {
29dd3609f2fc70 Eric Moore      2007-09-14  1479  		printk(KERN_ERR MYNAM "%s@%d::mptctl_readtest - "
^1da177e4c3f41 Linus Torvalds  2005-04-16  1480  			"Unable to read in mpt_ioctl_test struct @ %p\n",
^1da177e4c3f41 Linus Torvalds  2005-04-16  1481  				__FILE__, __LINE__, uarg);
^1da177e4c3f41 Linus Torvalds  2005-04-16  1482  		return -EFAULT;
^1da177e4c3f41 Linus Torvalds  2005-04-16  1483  	}
^1da177e4c3f41 Linus Torvalds  2005-04-16  1484  
09120a8cd38dbd Prakash, Sathya 2007-07-24  1485  	dctlprintk(ioc, printk(MYIOC_s_DEBUG_FMT "mptctl_readtest called.\n",
09120a8cd38dbd Prakash, Sathya 2007-07-24  1486  	    ioc->name));
^1da177e4c3f41 Linus Torvalds  2005-04-16  1487  	/* Fill in the data and return the structure to the calling
^1da177e4c3f41 Linus Torvalds  2005-04-16  1488  	 * program
^1da177e4c3f41 Linus Torvalds  2005-04-16  1489  	 */
^1da177e4c3f41 Linus Torvalds  2005-04-16  1490  
^1da177e4c3f41 Linus Torvalds  2005-04-16  1491  #ifdef MFCNT
^1da177e4c3f41 Linus Torvalds  2005-04-16  1492  	karg.chip_type = ioc->mfcnt;
^1da177e4c3f41 Linus Torvalds  2005-04-16  1493  #else
^1da177e4c3f41 Linus Torvalds  2005-04-16  1494  	karg.chip_type = ioc->pcidev->device;
^1da177e4c3f41 Linus Torvalds  2005-04-16  1495  #endif
^1da177e4c3f41 Linus Torvalds  2005-04-16  1496  	strncpy (karg.name, ioc->name, MPT_MAX_NAME);
^1da177e4c3f41 Linus Torvalds  2005-04-16  1497  	karg.name[MPT_MAX_NAME-1]='\0';
^1da177e4c3f41 Linus Torvalds  2005-04-16 @1498  	strncpy (karg.product, ioc->prod_name, MPT_PRODUCT_LENGTH);
^1da177e4c3f41 Linus Torvalds  2005-04-16  1499  	karg.product[MPT_PRODUCT_LENGTH-1]='\0';
^1da177e4c3f41 Linus Torvalds  2005-04-16  1500  
^1da177e4c3f41 Linus Torvalds  2005-04-16  1501  	/* Copy the data from kernel memory to user memory
^1da177e4c3f41 Linus Torvalds  2005-04-16  1502  	 */
^1da177e4c3f41 Linus Torvalds  2005-04-16  1503  	if (copy_to_user((char __user *)arg, &karg, sizeof(struct mpt_ioctl_test))) {
29dd3609f2fc70 Eric Moore      2007-09-14  1504  		printk(MYIOC_s_ERR_FMT "%s@%d::mptctl_readtest - "
^1da177e4c3f41 Linus Torvalds  2005-04-16  1505  			"Unable to write out mpt_ioctl_test struct @ %p\n",
29dd3609f2fc70 Eric Moore      2007-09-14  1506  			ioc->name, __FILE__, __LINE__, uarg);
^1da177e4c3f41 Linus Torvalds  2005-04-16  1507  		return -EFAULT;
^1da177e4c3f41 Linus Torvalds  2005-04-16  1508  	}
^1da177e4c3f41 Linus Torvalds  2005-04-16  1509  
^1da177e4c3f41 Linus Torvalds  2005-04-16  1510  	return 0;
^1da177e4c3f41 Linus Torvalds  2005-04-16  1511  }
^1da177e4c3f41 Linus Torvalds  2005-04-16  1512  

:::::: The code at line 1498 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
