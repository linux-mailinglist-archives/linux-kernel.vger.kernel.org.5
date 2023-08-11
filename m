Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B037799D8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 23:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236620AbjHKVp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 17:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjHKVp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 17:45:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFEC2712
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 14:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691790355; x=1723326355;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VVnLf4Rv5GN0a5KasCdZ1bV4WOrPhFHkuXXwce9MMjM=;
  b=oGgfjIBo8x9yoRMIa3ONuEV+CjJGBiBi79Qk2//cImsMZj0kOYvNT0R0
   WnS6yOMyKfzF4IncdS16di9zIsWMPkwFdwPS6ctuz4cSwgAa6YrriSurF
   GDdAG4UJilgqMGN9IaOxjzFYDtf/+N8RKNTTvpPUhtuol9U5iWBtzkBTZ
   R/Fh0Q//5sdxumgqzRRp6NmumSPn8qbLbk7Pa9cYqpLa3LI5uEWQ9lf3D
   BIx5YtPy9KcGY5omU0vNaNlcYU7wap0yZMTDnTBh8fZbKyweArHJ+Ifn9
   +ItaTJQZ0iJtofStgwOH3IVibtlR8gfLRVnEyAbZVp42GX/w+9cHh3Afv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="375482458"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="375482458"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 14:45:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="1063435891"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="1063435891"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 11 Aug 2023 14:45:53 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qUZxA-00083w-1i;
        Fri, 11 Aug 2023 21:45:52 +0000
Date:   Sat, 12 Aug 2023 05:45:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Hao Luo <haoluo@google.com>
Subject: Cannot find symbol for section 8: .text.bpf_rstat_flush.
Message-ID: <202308120553.IRzzfaXL-lkp@intel.com>
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
head:   29d99aae13cf2713b85bc26a37921e231676ba48
commit: a319185be9f5ad13c2a296d448ac52ffe45d194c cgroup: bpf: enable bpf programs to integrate with rstat
date:   12 months ago
config: mips-randconfig-r014-20230811 (https://download.01.org/0day-ci/archive/20230812/202308120553.IRzzfaXL-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230812/202308120553.IRzzfaXL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308120553.IRzzfaXL-lkp@intel.com/

All errors (new ones prefixed by >>):

>> Cannot find symbol for section 8: .text.bpf_rstat_flush.
   kernel/cgroup/rstat.o: failed

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
