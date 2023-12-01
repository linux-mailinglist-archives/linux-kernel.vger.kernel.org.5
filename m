Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B677800251
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 04:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377247AbjLADuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 22:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjLADut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 22:50:49 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BA9CA
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 19:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701402655; x=1732938655;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2/VhruWOk2iUKfGZqr/5FxPBE8hoTlTxdKpGUpBfdSw=;
  b=OcImX9pyCKYYmYWFobzAi4XbEcfR14yy/7rpJ4cjX6JzdTU2kTMWlmf9
   rkrSiQvj3vPEpmWFzkgFyMcr0pvxkGFRvLoUKCM2v00ioaNXrxakwcaLA
   Gy0u9nvCJgbazoNVPggoSEdGkLLHN3skqACrwmNtKWkfPS5J7T8b++XxW
   G3hB3pCmdfbpMUi0NcY5BkNZ+B4oee+FiKEZXxEmPrEQkuT3icMwfhEaU
   0InEc3Vs9ogjVZVO2g/7ekyLmrym4Rw0pqojWqwIoUIagn8bpoVsqcnd/
   TslPs2D58Ve3n2TtSYnVK8nTwUc+7gPApGsDuql+en4DHf5FYECxinxr0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="392299182"
X-IronPort-AV: E=Sophos;i="6.04,240,1695711600"; 
   d="scan'208";a="392299182"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 19:50:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="887478458"
X-IronPort-AV: E=Sophos;i="6.04,240,1695711600"; 
   d="scan'208";a="887478458"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 30 Nov 2023 19:50:54 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r8uY7-000351-23;
        Fri, 01 Dec 2023 03:50:46 +0000
Date:   Fri, 1 Dec 2023 11:50:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/mtd/nand/raw/sh_flctl.c:512:17: sparse: sparse: cast from
 restricted __be32
Message-ID: <202312011129.WKO5RkaC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2594faafeee2f4406ff82790604e4e3f55037d60
commit: 72c5af00272339af6bbed6fe7275cd731f57be2d mtd: rawnand: Clarify Kconfig entry MTD_NAND
date:   4 years, 7 months ago
config: arm-randconfig-r123-20231107 (https://download.01.org/0day-ci/archive/20231201/202312011129.WKO5RkaC-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231201/202312011129.WKO5RkaC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312011129.WKO5RkaC-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/mtd/nand/raw/sh_flctl.c:458:16: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/sh_flctl.c:481:26: sparse: sparse: cast to restricted __be32
   drivers/mtd/nand/raw/sh_flctl.c:496:38: sparse: sparse: cast to restricted __be32
>> drivers/mtd/nand/raw/sh_flctl.c:512:17: sparse: sparse: cast from restricted __be32
   drivers/mtd/nand/raw/sh_flctl.c:525:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long @@     got restricted __be32 [usertype] @@
   drivers/mtd/nand/raw/sh_flctl.c:525:24: sparse:     expected unsigned long
   drivers/mtd/nand/raw/sh_flctl.c:525:24: sparse:     got restricted __be32 [usertype]

vim +512 drivers/mtd/nand/raw/sh_flctl.c

6028aa01f759a1 drivers/mtd/nand/sh_flctl.c Yoshihiro Shimoda 2008-10-14  502  
e8a9d8f31c592e drivers/mtd/nand/sh_flctl.c Bastian Hecht     2012-10-19  503  static void write_fiforeg(struct sh_flctl *flctl, int rlen,
e8a9d8f31c592e drivers/mtd/nand/sh_flctl.c Bastian Hecht     2012-10-19  504  						unsigned int offset)
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c Yoshihiro Shimoda 2008-10-14  505  {
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c Yoshihiro Shimoda 2008-10-14  506  	int i, len_4align;
e8a9d8f31c592e drivers/mtd/nand/sh_flctl.c Bastian Hecht     2012-10-19  507  	unsigned long *buf = (unsigned long *)&flctl->done_buff[offset];
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c Yoshihiro Shimoda 2008-10-14  508  
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c Yoshihiro Shimoda 2008-10-14  509  	len_4align = (rlen + 3) / 4;
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c Yoshihiro Shimoda 2008-10-14  510  	for (i = 0; i < len_4align; i++) {
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c Yoshihiro Shimoda 2008-10-14  511  		wait_wfifo_ready(flctl);
e8a9d8f31c592e drivers/mtd/nand/sh_flctl.c Bastian Hecht     2012-10-19 @512  		writel(cpu_to_be32(buf[i]), FLDTFIFO(flctl));
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c Yoshihiro Shimoda 2008-10-14  513  	}
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c Yoshihiro Shimoda 2008-10-14  514  }
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c Yoshihiro Shimoda 2008-10-14  515  

:::::: The code at line 512 was first introduced by commit
:::::: e8a9d8f31c592eea89f1b0d3fd425e7a96944e88 mtd: sh_flctl: Minor cleanups

:::::: TO: Bastian Hecht <hechtb@googlemail.com>
:::::: CC: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
