Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703727D90AB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 10:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235139AbjJ0IGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 04:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235162AbjJ0IFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 04:05:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC07610E3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 01:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698393936; x=1729929936;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QIKwvjsek1goltp4pekEjHsWHkEdQyhC55sfxHvQOc0=;
  b=VxP7xD80LSagH+xa8AqGQPbkwXRkij91UUxeFg1Yw0NxLv3wrUHJqcWR
   q69fgIB4pyGF0HnDWTWYYiRNPHq8aNvXYhKo+LBkWoE/OTAKPdfa2IGSr
   Q2K597UjmAgBSujBmFeKWnMow6D6DBpWFhL5V/CAKfvioKE4ToiXmndao
   j+9vMSD5/oAfJ6Ff/LVmNL7k64mU+R/ZHSiEE01keFdpVHIrk577UKJ3m
   y1TGEk2u0hW+l9Bq8L5a+BkGiAywtawDDl19aEv0CZCmIuyrv6vX1KFwz
   8aW3zQU7HjbDsaPov0zqoB86kLry5jlpFYnGnz5XUV+hZCvpWMp/pPhmw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="550579"
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="550579"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 01:05:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="735591"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 27 Oct 2023 01:04:40 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qwHqE-000AcN-0E;
        Fri, 27 Oct 2023 08:05:14 +0000
Date:   Fri, 27 Oct 2023 16:04:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Alexander Duyck <alexanderduyck@fb.com>
Subject: /bin/bash: line 1:   383 Segmentation fault
      LLVM_OBJCOPY="llvm-objcopy" pahole -J --btf_gen_floats -j
 --lang_exclude=rust --skip_encoding_btf_inconsistent_proto
 --btf_gen_optimized --btf_base vmlinux net/wireless/lib80211_crypt_wep.ko
Message-ID: <202310271627.PoxpstI5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3a568e3a961ba330091cd031647e4c303fa0badb
commit: 75eaf63ea7afeafd026ffef03bdc69e31f10829b net: skbuff: don't include <net/page_pool/types.h> to <linux/skbuff.h>
date:   3 months ago
config: hexagon-randconfig-r045-20220708 (https://download.01.org/0day-ci/archive/20231027/202310271627.PoxpstI5-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231027/202310271627.PoxpstI5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310271627.PoxpstI5-lkp@intel.com/

All errors (new ones prefixed by >>):

   die__process_class: tag not supported 0x21 (subrange_type)!
>> /bin/bash: line 1:   383 Segmentation fault      LLVM_OBJCOPY="llvm-objcopy" pahole -J --btf_gen_floats -j --lang_exclude=rust --skip_encoding_btf_inconsistent_proto --btf_gen_optimized --btf_base vmlinux net/wireless/lib80211_crypt_wep.ko

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
