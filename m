Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE337F0F54
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 10:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbjKTJrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 04:47:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbjKTJrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 04:47:43 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33489A7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 01:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700473660; x=1732009660;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6s4aw/Qth2eVOxbcVqrXfUl6il4NKHU5Z308nwfa2H0=;
  b=SEODkJ0qBiq8rY/EEVs+9jnMBSOOQpG8iy4HlAXfpUtbpCWx7XuBJuHA
   n0bSjtZUUfAGxMbAaRREHHX8gBL7hNUeHnjTfaCngJ3wL1s/qNYSUEYMF
   M+i099KEjGShyRFNKeNgPuXtuy7QePbx+HkNXet4jw9/Jvg/t7uZWhiKI
   p8cAH6kepuvTurQslsOhV1GGecRd9QjtFT+pWyeYsppjEXLQyS/AYRuKV
   AX/d8HqNe31v03qOR6HhkzNOBvU/ZtcHSrxQ32z0h5T6QUsh4d5Z9CBGq
   r00BQI61JZ4c4nTlWLm6Q/7qWqSbq0yf04qQypvwcyaKi4TbujxzZF9Z2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="388727240"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="388727240"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 01:47:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="939760776"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="939760776"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 20 Nov 2023 01:47:37 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r50sR-0006IM-25;
        Mon, 20 Nov 2023 09:47:35 +0000
Date:   Mon, 20 Nov 2023 17:47:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marco Elver <elver@google.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: drivers/char/tpm/tpm_ibmvtpm.c:126:9: sparse: sparse: incorrect type
 in argument 1 (different address spaces)
Message-ID: <202311201751.e7jX5wti-lkp@intel.com>
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
head:   98b1cc82c4affc16f5598d4fa14b1858671b2263
commit: 90db9dbedd26ce029f3a0f8d2cbd3a142f452408 kasan, powerpc: don't rename memintrinsics if compiler adds prefixes
date:   8 months ago
config: powerpc64-randconfig-r112-20231120 (https://download.01.org/0day-ci/archive/20231120/202311201751.e7jX5wti-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20231120/202311201751.e7jX5wti-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311201751.e7jX5wti-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/char/tpm/tpm_ibmvtpm.c:125:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/tpm/tpm_ibmvtpm.c:125:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/tpm/tpm_ibmvtpm.c:125:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/char/tpm/tpm_ibmvtpm.c:126:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *rtce_buf @@
   drivers/char/tpm/tpm_ibmvtpm.c:126:9: sparse:     expected void const *
   drivers/char/tpm/tpm_ibmvtpm.c:126:9: sparse:     got void [noderef] __iomem *rtce_buf
>> drivers/char/tpm/tpm_ibmvtpm.c:126:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *rtce_buf @@
   drivers/char/tpm/tpm_ibmvtpm.c:126:9: sparse:     expected void const *
   drivers/char/tpm/tpm_ibmvtpm.c:126:9: sparse:     got void [noderef] __iomem *rtce_buf
>> drivers/char/tpm/tpm_ibmvtpm.c:126:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *p @@     got void [noderef] __iomem *rtce_buf @@
   drivers/char/tpm/tpm_ibmvtpm.c:126:9: sparse:     expected void *p
   drivers/char/tpm/tpm_ibmvtpm.c:126:9: sparse:     got void [noderef] __iomem *rtce_buf
   drivers/char/tpm/tpm_ibmvtpm.c:229:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/tpm/tpm_ibmvtpm.c:229:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/tpm/tpm_ibmvtpm.c:229:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/tpm/tpm_ibmvtpm.c:366:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *objp @@     got void [noderef] __iomem *rtce_buf @@
   drivers/char/tpm/tpm_ibmvtpm.c:366:30: sparse:     expected void const *objp
   drivers/char/tpm/tpm_ibmvtpm.c:366:30: sparse:     got void [noderef] __iomem *rtce_buf
   drivers/char/tpm/tpm_ibmvtpm.c:525:43: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *rtce_buf @@     got void * @@
   drivers/char/tpm/tpm_ibmvtpm.c:525:43: sparse:     expected void [noderef] __iomem *rtce_buf
   drivers/char/tpm/tpm_ibmvtpm.c:525:43: sparse:     got void *
   drivers/char/tpm/tpm_ibmvtpm.c:532:52: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *ptr @@     got void [noderef] __iomem *rtce_buf @@
   drivers/char/tpm/tpm_ibmvtpm.c:532:52: sparse:     expected void *ptr
   drivers/char/tpm/tpm_ibmvtpm.c:532:52: sparse:     got void [noderef] __iomem *rtce_buf
   drivers/char/tpm/tpm_ibmvtpm.c:538:46: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *objp @@     got void [noderef] __iomem *rtce_buf @@
   drivers/char/tpm/tpm_ibmvtpm.c:538:46: sparse:     expected void const *objp
   drivers/char/tpm/tpm_ibmvtpm.c:538:46: sparse:     got void [noderef] __iomem *rtce_buf

vim +126 drivers/char/tpm/tpm_ibmvtpm.c

132f7629474424 Ashley Lai        2012-08-22   94  
132f7629474424 Ashley Lai        2012-08-22   95  /**
132f7629474424 Ashley Lai        2012-08-22   96   * tpm_ibmvtpm_recv - Receive data after send
93c12f293f8798 Winkler, Tomas    2016-11-23   97   *
132f7629474424 Ashley Lai        2012-08-22   98   * @chip:	tpm chip struct
132f7629474424 Ashley Lai        2012-08-22   99   * @buf:	buffer to read
93c12f293f8798 Winkler, Tomas    2016-11-23  100   * @count:	size of buffer
132f7629474424 Ashley Lai        2012-08-22  101   *
93c12f293f8798 Winkler, Tomas    2016-11-23  102   * Return:
132f7629474424 Ashley Lai        2012-08-22  103   *	Number of bytes read
132f7629474424 Ashley Lai        2012-08-22  104   */
132f7629474424 Ashley Lai        2012-08-22  105  static int tpm_ibmvtpm_recv(struct tpm_chip *chip, u8 *buf, size_t count)
132f7629474424 Ashley Lai        2012-08-22  106  {
9e0d39d8a6a0a8 Christophe Ricard 2016-03-31  107  	struct ibmvtpm_dev *ibmvtpm = dev_get_drvdata(&chip->dev);
132f7629474424 Ashley Lai        2012-08-22  108  	u16 len;
132f7629474424 Ashley Lai        2012-08-22  109  
132f7629474424 Ashley Lai        2012-08-22  110  	if (!ibmvtpm->rtce_buf) {
132f7629474424 Ashley Lai        2012-08-22  111  		dev_err(ibmvtpm->dev, "ibmvtpm device is not ready\n");
132f7629474424 Ashley Lai        2012-08-22  112  		return 0;
132f7629474424 Ashley Lai        2012-08-22  113  	}
132f7629474424 Ashley Lai        2012-08-22  114  
b5666502700855 Ashley Lai        2012-09-12  115  	len = ibmvtpm->res_len;
132f7629474424 Ashley Lai        2012-08-22  116  
b5666502700855 Ashley Lai        2012-09-12  117  	if (count < len) {
132f7629474424 Ashley Lai        2012-08-22  118  		dev_err(ibmvtpm->dev,
37ab03414829e5 Jason Gunthorpe   2013-09-14  119  			"Invalid size in recv: count=%zd, crq_size=%d\n",
b5666502700855 Ashley Lai        2012-09-12  120  			count, len);
132f7629474424 Ashley Lai        2012-08-22  121  		return -EIO;
132f7629474424 Ashley Lai        2012-08-22  122  	}
132f7629474424 Ashley Lai        2012-08-22  123  
132f7629474424 Ashley Lai        2012-08-22  124  	spin_lock(&ibmvtpm->rtce_lock);
b5666502700855 Ashley Lai        2012-09-12  125  	memcpy((void *)buf, (void *)ibmvtpm->rtce_buf, len);
b5666502700855 Ashley Lai        2012-09-12 @126  	memset(ibmvtpm->rtce_buf, 0, len);
b5666502700855 Ashley Lai        2012-09-12  127  	ibmvtpm->res_len = 0;
132f7629474424 Ashley Lai        2012-08-22  128  	spin_unlock(&ibmvtpm->rtce_lock);
132f7629474424 Ashley Lai        2012-08-22  129  	return len;
132f7629474424 Ashley Lai        2012-08-22  130  }
132f7629474424 Ashley Lai        2012-08-22  131  

:::::: The code at line 126 was first introduced by commit
:::::: b5666502700855a1eb1a15482005b22478b9460e drivers/char/tpm: remove tasklet and cleanup

:::::: TO: Ashley Lai <adlai@linux.vnet.ibm.com>
:::::: CC: Kent Yoder <key@linux.vnet.ibm.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
