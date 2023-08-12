Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92DB0779F01
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 12:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbjHLK2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 06:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjHLK2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 06:28:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D750935AC
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 03:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691836052; x=1723372052;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=A8GEGbiPLdALZV2Smdzky+ph/86krYV09WRHGvddmto=;
  b=N/RkibiKfTkjmP5iK74YaPUnymd+fMx+eLlIb7ta8VENZrwIcwoGkabB
   RPNze+ZLAnIVRZmdmh0Eb/gtVFbpiihIpzhR7gpdjJ5XbyUJ/e6qA9Uo9
   135J0+epvlzEX5JCQXIjNkcj633ukGYCHwfN1luVUWiqvaSfQ6vj8fvCj
   4aQMQZqRdjv30v7t8wWMYd+xFZZBMTTmAqt1j7qGRnjkEl2dA2AlOld2J
   dPhxCHAKow6SlL6DiPuA8zS5zKSLV4FSKLPEAn+OXDrytxB50dXBdlLaG
   hsnPnV1+UFbwla+ryZ/1CcG2bUcmVCOBRpIwCIm+yqANAlEyatAVUecUU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="371824623"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="371824623"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2023 03:27:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="736015247"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="736015247"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 12 Aug 2023 03:27:12 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qUlpv-0008V8-0E;
        Sat, 12 Aug 2023 10:27:11 +0000
Date:   Sat, 12 Aug 2023 18:26:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Cannot find symbol for section 4: .text.phys_mem_access_prot_allowed.
Message-ID: <202308121810.APAJIBxn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f8de32cc060ba3f63171aaa0e8764d22d8c37978
commit: 99b619b37ae151dc0fcdffcae48b5a5ad90ebde8 mips: provide unxlate_dev_mem_ptr() in asm/io.h
date:   9 weeks ago
config: mips-randconfig-r014-20230811 (https://download.01.org/0day-ci/archive/20230812/202308121810.APAJIBxn-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230812/202308121810.APAJIBxn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308121810.APAJIBxn-lkp@intel.com/

All errors (new ones prefixed by >>):

>> Cannot find symbol for section 4: .text.phys_mem_access_prot_allowed.
   drivers/char/mem.o: failed

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
