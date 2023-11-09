Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3578D7E6A68
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 13:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjKIMSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 07:18:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjKIMSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 07:18:34 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758722702
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 04:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699532312; x=1731068312;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QNr67NOFJTWsqVJbBxekluseStnG25WOCCJrnVSzJSs=;
  b=nhd+J6DXohOdmQZld9fsKpD+03gRXmUdNFcxjMPTgw/lcLTbzax5k7t7
   CK6taAMDmvwGcsBbGUOCRucnR/URE0tbAaXI0/KxuUMRGEd/stzEGN3+k
   1hl9zRrtZn79qcFkkd498/CwYHnzbVfPIBImD0Ot5OeQ624VE7biVy8j7
   eh4doQymfJr9BpOqa+rgegFrVktNb84KcpvKvFN9qGrffvsF6O2WKar7N
   4dMsQT5snPvai7herD20Bzq2oGFmOifafNvKRbjEJQrNYcrOfOkTBY+zj
   5m9PNmXack/6sYpG5q2uyaOKEqOsXbNWymqshcE0RX0U8eDTWa7fyTzN8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="11523438"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="11523438"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 04:18:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="4708954"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 09 Nov 2023 04:18:31 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r13zQ-0008i8-2g;
        Thu, 09 Nov 2023 12:18:28 +0000
Date:   Thu, 9 Nov 2023 20:17:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     John Johansen <john.johansen@canonical.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Georgia Garcia <georgia.garcia@canonical.com>
Subject: security/apparmor/lsm.c:1893:15: sparse: sparse: symbol 'nulldfa'
 was not declared. Should it be static?
Message-ID: <202311092038.lqfYnvmf-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6bc986ab839c844e78a2333a02e55f02c9e57935
commit: 98b824ff8984fd523fc264fbb13208098ab09da3 apparmor: refcount the pdb
date:   3 weeks ago
config: i386-randconfig-062-20231104 (https://download.01.org/0day-ci/archive/20231109/202311092038.lqfYnvmf-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231109/202311092038.lqfYnvmf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311092038.lqfYnvmf-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> security/apparmor/lsm.c:1893:15: sparse: sparse: symbol 'nulldfa' was not declared. Should it be static?

vim +/nulldfa +1893 security/apparmor/lsm.c

  1889	
  1890	static char nulldfa_src[] = {
  1891		#include "nulldfa.in"
  1892	};
> 1893	struct aa_dfa *nulldfa;
  1894	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
