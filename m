Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3100480DF5F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 00:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345366AbjLKXRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 18:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345318AbjLKXRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 18:17:09 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE12C4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 15:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702336635; x=1733872635;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Dw4kMtShdbPzytYgQyl6erVQMS9zXDuMSrQXIkHimtc=;
  b=JQkIAhdZvY9MpcpJnJZ70CHTwNMTv6zMYkvAnHAHOf9hGTc7xPVnklGB
   AKMgq1PhTBm7cxa+6TNXiMKdiR0jt//xZJT7DviVAghTT23PhwBPkkJ0k
   SiT3eDws17XvxEahxPwh387z6/8TyelJOUBV13CKvxXZ4pVf7doWcKxlu
   qMbC09KAs2pFzSdqvwM/DJj5wG4NUkQ9DIfXVXu27MO4sZdniS6ZnJE5L
   qzlVzymtV4M6jGI/h9/9uLY323MDXtvcZKtgSQ9r0dz129X0Dl3JKXIZI
   YgDsFACdeUW4RZmViFZi4rp7UdzOmOvsHT/rzpj7H9KCtNCHoIaoH+ohB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="374230383"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="374230383"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 15:17:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="21273187"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 11 Dec 2023 15:17:12 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rCpWO-000IYf-09;
        Mon, 11 Dec 2023 23:17:08 +0000
Date:   Tue, 12 Dec 2023 07:16:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Carpenter <error27@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Luca Abeni <luca.abeni@santannapisa.it>
Subject: drivers/firmware/dmi_scan.c:145:13: sparse: sparse: incorrect type
 in assignment (different address spaces)
Message-ID: <202312120718.oZqe253R-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a39b6ac3781d46ba18193c9dbb2110f31e9bffe9
commit: aa5222e92f8000ed3c1c38dddf11c83222aadfb3 sched/deadline: Don't use dubious signed bitfields
date:   6 years ago
config: arm64-randconfig-r121-20231116 (https://download.01.org/0day-ci/archive/20231212/202312120718.oZqe253R-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231212/202312120718.oZqe253R-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312120718.oZqe253R-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/firmware/dmi_scan.c:145:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [usertype] *buf @@     got void [noderef] __iomem * @@
   drivers/firmware/dmi_scan.c:145:13: sparse:     expected unsigned char [usertype] *buf
   drivers/firmware/dmi_scan.c:145:13: sparse:     got void [noderef] __iomem *
>> drivers/firmware/dmi_scan.c:153:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned char [usertype] *buf @@
   drivers/firmware/dmi_scan.c:153:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/firmware/dmi_scan.c:153:9: sparse:     got unsigned char [usertype] *buf
>> drivers/firmware/dmi_scan.c:736:19: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [usertype] *dmi_table @@     got void [noderef] __iomem * @@
   drivers/firmware/dmi_scan.c:736:19: sparse:     expected unsigned char [usertype] *dmi_table
   drivers/firmware/dmi_scan.c:736:19: sparse:     got void [noderef] __iomem *
>> drivers/firmware/dmi_scan.c:755:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned char [usertype] *dmi_table @@
   drivers/firmware/dmi_scan.c:755:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/firmware/dmi_scan.c:755:9: sparse:     got unsigned char [usertype] *dmi_table
   drivers/firmware/dmi_scan.c:1031:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [usertype] *buf @@     got void [noderef] __iomem * @@
   drivers/firmware/dmi_scan.c:1031:13: sparse:     expected unsigned char [usertype] *buf
   drivers/firmware/dmi_scan.c:1031:13: sparse:     got void [noderef] __iomem *
   drivers/firmware/dmi_scan.c:1037:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned char [usertype] *buf @@
   drivers/firmware/dmi_scan.c:1037:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/firmware/dmi_scan.c:1037:9: sparse:     got unsigned char [usertype] *buf

vim +145 drivers/firmware/dmi_scan.c

7fce084a0b3e2b drivers/firmware/dmi_scan.c Jean Delvare    2007-11-03  138  
e7a19c5624c66a drivers/firmware/dmi_scan.c Jean Delvare    2009-03-30  139  static int __init dmi_walk_early(void (*decode)(const struct dmi_header *,
e7a19c5624c66a drivers/firmware/dmi_scan.c Jean Delvare    2009-03-30  140  		void *))
7fce084a0b3e2b drivers/firmware/dmi_scan.c Jean Delvare    2007-11-03  141  {
7fce084a0b3e2b drivers/firmware/dmi_scan.c Jean Delvare    2007-11-03  142  	u8 *buf;
6e0ad59e3d838a drivers/firmware/dmi_scan.c Jean Delvare    2015-06-25  143  	u32 orig_dmi_len = dmi_len;
7fce084a0b3e2b drivers/firmware/dmi_scan.c Jean Delvare    2007-11-03  144  
6e0ad59e3d838a drivers/firmware/dmi_scan.c Jean Delvare    2015-06-25 @145  	buf = dmi_early_remap(dmi_base, orig_dmi_len);
7fce084a0b3e2b drivers/firmware/dmi_scan.c Jean Delvare    2007-11-03  146  	if (buf == NULL)
c926820085437a drivers/firmware/dmi_scan.c Andy Lutomirski 2017-06-15  147  		return -ENOMEM;
7fce084a0b3e2b drivers/firmware/dmi_scan.c Jean Delvare    2007-11-03  148  
eb4c5ea50e60aa drivers/firmware/dmi_scan.c Ivan Khoronzhuk 2015-06-25  149  	dmi_decode_table(buf, decode, NULL);
7fce084a0b3e2b drivers/firmware/dmi_scan.c Jean Delvare    2007-11-03  150  
d114a333874725 drivers/firmware/dmi_scan.c Tony Luck       2012-07-20  151  	add_device_randomness(buf, dmi_len);
d114a333874725 drivers/firmware/dmi_scan.c Tony Luck       2012-07-20  152  
6e0ad59e3d838a drivers/firmware/dmi_scan.c Jean Delvare    2015-06-25 @153  	dmi_early_unmap(buf, orig_dmi_len);
^1da177e4c3f41 arch/i386/kernel/dmi_scan.c Linus Torvalds  2005-04-16  154  	return 0;
^1da177e4c3f41 arch/i386/kernel/dmi_scan.c Linus Torvalds  2005-04-16  155  }
^1da177e4c3f41 arch/i386/kernel/dmi_scan.c Linus Torvalds  2005-04-16  156  

:::::: The code at line 145 was first introduced by commit
:::::: 6e0ad59e3d838a2887e7aa657baee5896030d009 firmware: dmi_scan: Trim DMI table length before exporting it

:::::: TO: Jean Delvare <jdelvare@suse.de>
:::::: CC: Jean Delvare <jdelvare@suse.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
