Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771F478938C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 04:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjHZC6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 22:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjHZC6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 22:58:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D97F2102
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 19:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693018703; x=1724554703;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=V+lBY9/qBLpeF74QBZgJXO2M2WCLJYmHleiAT3ceZ3c=;
  b=iW6WmI6q9NA/qNkDTNraCR2kINmIH0r8ATx0cIolEBBw7XMktN4r93Vq
   lENkT9XgMnyEHCqfzFszg8O88JjwYVDUBfdmlsQFOAx7HguDv1nf6uOX6
   PgNABB1HkEsdm7IrEutQZso7QQwqaozCQAlMlfOSctXDUeg2BUHFlASi8
   ZiLMF5hEzcbFpfIsh6iOs9Xa6RWp9LeAfOSempSWAXCf9RUfXXzVvIGhQ
   HvHXdeiWL2SbGxb+az3/wpdze/g56I5KWKn4e/sCJNubm2hIKzSjzRTmC
   41NnE7CAYTt3ls3zCPcy8ueO5Tbay06Nkw956L8cJETNnuzCuQSxhfmf/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="354367859"
X-IronPort-AV: E=Sophos;i="6.02,202,1688454000"; 
   d="scan'208";a="354367859"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 19:58:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="881355359"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 25 Aug 2023 19:58:26 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qZjVE-0004HD-2U;
        Sat, 26 Aug 2023 02:58:20 +0000
Date:   Sat, 26 Aug 2023 10:57:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>, Fuad Tabba <tabba@google.com>
Subject: arch/arm64/kvm/hyp/nvhe/stacktrace.c:10:1: sparse: sparse: symbol
 '__pcpu_scope_overflow_stack' was not declared. Should it be static?
Message-ID: <202308261007.gkKH77GA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   382d4cd1847517ffcb1800fd462b625db7b2ebea
commit: 548ec3336f323db56260b312c232ab37285f0284 KVM: arm64: On stack overflow switch to hyp overflow_stack
date:   1 year, 1 month ago
config: arm64-randconfig-r131-20230824 (https://download.01.org/0day-ci/archive/20230826/202308261007.gkKH77GA-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230826/202308261007.gkKH77GA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308261007.gkKH77GA-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/arm64/kvm/hyp/nvhe/stacktrace.c:10:1: sparse: sparse: symbol '__pcpu_scope_overflow_stack' was not declared. Should it be static?

vim +/__pcpu_scope_overflow_stack +10 arch/arm64/kvm/hyp/nvhe/stacktrace.c

  > 10	#include <asm/percpu.h>
    11	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
