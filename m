Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEE37E6C5D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 15:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234073AbjKIOYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 09:24:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbjKIOYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 09:24:31 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CFC184
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 06:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699539869; x=1731075869;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=j2L4gW6FHHrfJJX6lwLF7Hv55vnDkDUVjbvPjCXPryE=;
  b=lx1880ZsTHtPILkJifHB4KBy0NmA3/N+p+JPAUeLBqVe5vLKSwh7cK9D
   yrZBTWI6EyxrF4vmJo7MGtrFzxhI6/X/0j50Pm4i7ooVnfhljB1xC/Odg
   Jxq6mXWCxtrSjjLo9lnWmGvt0J49hyT+8s/y/uGFmDZ/hqH3tjseC59r5
   in7dEk8vHas1MeF4HepVV0I9gcKvQYq8CfsilqZ2t3zCsuaOrZGajTrW1
   q8R8SV9+2e1e977R8SWJubWE76bvfSUE7PzsgsVR0QM4UMzLTy1Pwb2F8
   Svhz+g55LsGAjdJMriljFcoG14gglc8OzE+nL/45YbpoAVRWa15u35aMO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="3021507"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="3021507"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 06:24:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="763411301"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="763411301"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 09 Nov 2023 06:24:27 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r15xJ-0008mt-0S;
        Thu, 09 Nov 2023 14:24:25 +0000
Date:   Thu, 9 Nov 2023 22:24:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     John Johansen <john.johansen@canonical.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Georgia Garcia <georgia.garcia@canonical.com>
Subject: security/apparmor/domain.c:1314:12: sparse: sparse: symbol
 'stack_msg' was not declared. Should it be static?
Message-ID: <202311092251.TwKSNZ0u-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6bc986ab839c844e78a2333a02e55f02c9e57935
commit: 2d9da9b188b8cd3b579d7ef5ba5d334be9dd38fc apparmor: allow restricting unprivileged change_profile
date:   3 weeks ago
config: i386-randconfig-062-20231104 (https://download.01.org/0day-ci/archive/20231109/202311092251.TwKSNZ0u-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231109/202311092251.TwKSNZ0u-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311092251.TwKSNZ0u-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> security/apparmor/domain.c:1314:12: sparse: sparse: symbol 'stack_msg' was not declared. Should it be static?

vim +/stack_msg +1314 security/apparmor/domain.c

  1313	
> 1314	const char *stack_msg = "change_profile unprivileged unconfined converted to stacking";
  1315	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
