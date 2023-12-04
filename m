Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6CC580388A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 16:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234347AbjLDPTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 10:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbjLDPTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 10:19:09 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EB9B0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 07:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701703157; x=1733239157;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=R0TMt2Y5t96psHwjnCsUQ65s7N0OV5YOT7ck89D9SCk=;
  b=gW7SzY1b426B4wb5fAu882dBEve/GLHEwENVWwrbxDYfkyQdXBWWjG3h
   dpw3iG29mhmoTqEof8Om5wO8n1UtNJZS1ocndYJ+Cwda4IfCl122NoVA5
   Ctx9Cd+rtnpa03QKjUZ1ED74MCLpoeBg08ddQBRLFAEbg56xMgmrIMsuH
   8LSrwYJaNn3YEOkXvJb4ygPGYVhPQEA7DPw6dpb0iUUvzIEgzJep5Gnhn
   Sh0tKejIcxga/J8lU4RewJXINyz8Mvz9Mx0i9o9J1idWZqqRqMKAWbqH3
   hnZXvx4I/BzQnbpQc4GYsxMOxFsFyL3EgBH1ijHoA3gB5VIDkjkOYfde/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="801137"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="801137"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 07:19:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="861405028"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="861405028"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Dec 2023 07:19:13 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rAAj1-0007q3-1j;
        Mon, 04 Dec 2023 15:19:11 +0000
Date:   Mon, 4 Dec 2023 23:18:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arch/m68k/sun3/sun3ints.c:33:13: sparse: sparse: cast truncates bits
 from constant value (ffffff7f becomes 7f)
Message-ID: <202312042236.D0RviSfe-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   33cc938e65a98f1d29d0a18403dbbee050dcad9a
commit: 72e70a0e7ac7c422843eb8bbf192e820e9ccd24d m68k: sun3: Change led_pattern[] to unsigned char
date:   8 weeks ago
config: m68k-randconfig-r133-20231117 (https://download.01.org/0day-ci/archive/20231204/202312042236.D0RviSfe-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231204/202312042236.D0RviSfe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312042236.D0RviSfe-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   arch/m68k/sun3/sun3ints.c: note: in included file (through include/linux/mmzone.h, include/linux/topology.h, include/linux/irq.h, ...):
   include/linux/page-flags.h:242:46: sparse: sparse: self-comparison always evaluates to false
>> arch/m68k/sun3/sun3ints.c:33:13: sparse: sparse: cast truncates bits from constant value (ffffff7f becomes 7f)

vim +33 arch/m68k/sun3/sun3ints.c

    31	
    32	static unsigned char led_pattern[8] = {
  > 33		(u8)~(0x80), (u8)~(0x01),
    34		(u8)~(0x40), (u8)~(0x02),
    35		(u8)~(0x20), (u8)~(0x04),
    36		(u8)~(0x10), (u8)~(0x08)
    37	};
    38	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
