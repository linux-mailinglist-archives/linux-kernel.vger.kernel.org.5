Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CE179DF89
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 07:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236623AbjIMFuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 01:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbjIMFuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 01:50:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85328172A
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 22:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694584205; x=1726120205;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RtN0inprACrBGB3TzfvZhkNX3htDZ9aMSFqyFgjn4RY=;
  b=gxrvidql1Bui1AMBLq6J4vN0CeovNtN0S5k+dNzXwueBqOe8R+ZGO3zH
   Z/15COQ6Q5JaPnpxF4njIsgyXm/00+dwZBGMn9JLyvBfBPM6yv6CYfKRx
   Cni0blPMbJqbuv9Ob0hfmRpKlKWgadzvzSXzX84lR0HmVw4IXoan6mqtc
   v9CTMY1/E39O8HIwZe2VK0a3XzsQn5YjxakFFSZq+wBu7iRN3occFNrYk
   N2RGFzA4gNldcKiYYwKMXhcesuLF7y72leda4+2RSB8ZzEPSxVY5R45fQ
   idFm2vrBy83Om5lRi8JSViHI5HIh4Ix5ZfmjY7GDiR7QYGVAQ5HvZ1W9e
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="464940878"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="464940878"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 22:50:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="867639475"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="867639475"
Received: from lkp-server02.sh.intel.com (HELO cf13c67269a2) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 12 Sep 2023 22:50:03 -0700
Received: from kbuild by cf13c67269a2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qgIlE-00005t-2i;
        Wed, 13 Sep 2023 05:50:00 +0000
Date:   Wed, 13 Sep 2023 13:49:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: ERROR: start_text address is c000000000000700, should be
 c000000000000100
Message-ID: <202309131336.uIwzjLmq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3669558bdf354cd352be955ef2764cde6a9bf5ec
commit: 5750121ae7382ebac8d47ce6d68012d6cd1d7926 kbuild: list sub-directories in ./Kbuild
date:   12 months ago
config: powerpc64-randconfig-r006-20230913 (https://download.01.org/0day-ci/archive/20230913/202309131336.uIwzjLmq-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230913/202309131336.uIwzjLmq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309131336.uIwzjLmq-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ERROR: start_text address is c000000000000700, should be c000000000000100
   ERROR: try to enable LD_HEAD_STUB_CATCH config option
   ERROR: see comments in arch/powerpc/tools/head_check.sh

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
