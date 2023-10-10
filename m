Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996CE7C4133
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 22:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbjJJU2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 16:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjJJU2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 16:28:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F3C94
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 13:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696969698; x=1728505698;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GPG4krj48QNW1LSVLNAZAI9rOouBbrQWlNRVreJbBy0=;
  b=ANR1vxaWXYqQdQkfSMbL3BDMgLhPyVcNoLvLIvHFjgAKWpiJ8BcIHhlI
   XyL5j6InPUiCg7cuy106ZtlI6PPolEcrByGsDnZLAW796lDaW8muuKmEc
   4dkH+LfYYSxaAJxXlYxQW2Jmi9+K7Vh3QbJN5uhDtuNuFsX8mBYPtWhMF
   Ks+NYAqsykCUSCJm6sTaaeyTu4EUEFW3zTHYfDqg1w+QGoA2HsHyJE4YA
   7uf8RvG12R8Kv4iL1ecNzDx6KRl6kvORsM7neE0X997SZyaJ9royTRZSZ
   96utNKTWM0BL2UFPvDXTTleg7IKGfiSWCxj5AKQGyCqN+WSVFA+R5YI35
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="6060624"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="6060624"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 13:28:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="844282241"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="844282241"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Oct 2023 13:28:16 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qqJKt-00015Q-1e;
        Tue, 10 Oct 2023 20:28:13 +0000
Date:   Wed, 11 Oct 2023 04:27:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ian Rogers <irogers@google.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Namhyung Kim <namhyung@kernel.org>
Subject: tools/perf/util/bpf_skel/vmlinux/vmlinux.h: warning: ignored by one
 of the .gitignore files
Message-ID: <202310110451.rvdUZJEY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1c8b86a3799f7e5be903c3f49fcdaee29fd385b5
commit: b7a2d774c9c5a9a3228c6169ecf32f05b96609cf perf build: Add ability to build with a generated vmlinux.h
date:   4 months ago
config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20231011/202310110451.rvdUZJEY-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231011/202310110451.rvdUZJEY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310110451.rvdUZJEY-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> tools/perf/util/bpf_skel/vmlinux/vmlinux.h: warning: ignored by one of the .gitignore files
   tools/testing/selftests/arm64/tags/.gitignore: warning: ignored by one of the .gitignore files
   tools/testing/selftests/arm64/tags/Makefile: warning: ignored by one of the .gitignore files
   tools/testing/selftests/arm64/tags/run_tags_test.sh: warning: ignored by one of the .gitignore files
   tools/testing/selftests/arm64/tags/tags_test.c: warning: ignored by one of the .gitignore files
   tools/testing/selftests/kvm/.gitignore: warning: ignored by one of the .gitignore files
   tools/testing/selftests/kvm/Makefile: warning: ignored by one of the .gitignore files
   tools/testing/selftests/kvm/config: warning: ignored by one of the .gitignore files
   tools/testing/selftests/kvm/settings: warning: ignored by one of the .gitignore files

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
