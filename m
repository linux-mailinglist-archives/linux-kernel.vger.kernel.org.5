Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3480679A36A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 08:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbjIKGUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 02:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjIKGUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 02:20:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3549100
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 23:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694413239; x=1725949239;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rOfZkXhFxxA8oP5KwUeDf4ofbKhzUiIEMUUjqVtj2KI=;
  b=WSm/f6T1gd5gqSJfRmuehBjMh1uw3LNjpJoNW5yaQCSMz6S40wuOHHBP
   IOHsPkiDg61qK1jKQH45gIydoYECYbgqUP8QH9fTLQT15z7ezJ9Ys5QLu
   Upo8we4XHJ9U+bPb6sc4ARzyQbXypcRdi1+p/e3P7kkJfRj5wrj+OTdpm
   XBVgBJsXOke88GyDd2TNxkqmGB2AeMCwy668lMbYno3LF/So8j20LqG3o
   UIZnRAMJIqVlsenMdzAMgJXY/klxxtMbf4/vwVGhPq0Oi6lw+RKzN+HDE
   le5WWH9CLtIcwJ5w7gWzILViNJS55B2ahSnK7I8x4v+V7uhFX5a6NZYZo
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="376920185"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="376920185"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2023 23:20:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="719891688"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="719891688"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 10 Sep 2023 23:20:37 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qfaHi-0005t6-38;
        Mon, 11 Sep 2023 06:20:34 +0000
Date:   Mon, 11 Sep 2023 14:19:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Gow <davidgow@google.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Benjamin Berg <benjamin.berg@intel.com>,
        Maxime Ripard <maxime@cerno.tech>
Subject: lib/kunit/executor_test.c:138:4: warning: cast from 'void (*)(const
 void *)' to 'kunit_action_t *' (aka 'void (*)(void *)') converts to
 incompatible function type
Message-ID: <202309111413.inYPK4PP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0bb80ecc33a8fb5a682236443c1e740d5c917d1d
commit: 00e63f8afcfc6bf93d75141c51d35e8a40e86363 kunit: executor_test: Use kunit_add_action()
date:   4 months ago
config: x86_64-randconfig-013-20230909 (https://download.01.org/0day-ci/archive/20230911/202309111413.inYPK4PP-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230911/202309111413.inYPK4PP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309111413.inYPK4PP-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from lib/kunit/executor.c:223:
>> lib/kunit/executor_test.c:138:4: warning: cast from 'void (*)(const void *)' to 'kunit_action_t *' (aka 'void (*)(void *)') converts to incompatible function type [-Wcast-function-type-strict]
                           (kunit_action_t *)kfree,
                           ^~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +138 lib/kunit/executor_test.c

   127	
   128	/* Use the resource API to register a call to kfree(to_free).
   129	 * Since we never actually use the resource, it's safe to use on const data.
   130	 */
   131	static void kfree_at_end(struct kunit *test, const void *to_free)
   132	{
   133		/* kfree() handles NULL already, but avoid allocating a no-op cleanup. */
   134		if (IS_ERR_OR_NULL(to_free))
   135			return;
   136	
   137		kunit_add_action(test,
 > 138				(kunit_action_t *)kfree,
   139				(void *)to_free);
   140	}
   141	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
