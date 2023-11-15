Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0E47ECA54
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 19:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbjKOSSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 13:18:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjKOSSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 13:18:03 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5474A189
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 10:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700072278; x=1731608278;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+XH8BxAoExbk0BWokhZe+Xm/PWN3ufcVo32dt0k9emA=;
  b=V8TtTaDnnTYyr1td9lQvuaIJbFuBixlRZIlWmvH/JFmvlVR4r1Wak0Ea
   laUFBXpGHnLgbqwcK5U8LPvb8vDOFvsdT7KtSi5Y5RI++AO3BYORXYqEv
   aqsJMMBPK5NNxKideEewWcZjOgw2vGG/SetnIwWIgoDgO/w2T5b+XXO84
   79KTPDkqudzmMx6f0lHcLq0yR6JzskqoD2Me9HuvDO4vpbpO99m7KxYT3
   kE7fxQH+qxMtgB0jM/rEzgBsjiJOcnSe4NyYoWixTPewvuLx94ExPER5q
   01rrV1rurrsVOu5qNaWPw3zLHdUF7lTOeTDS0yrefsXj9qG8GpPDGj/6Y
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="370275599"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="370275599"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 10:17:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="908849441"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="908849441"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 15 Nov 2023 10:17:57 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r3KSY-0000hM-21;
        Wed, 15 Nov 2023 18:17:54 +0000
Date:   Thu, 16 Nov 2023 02:17:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: kernel/trace/pid_list.c:154: warning: Function parameter or member
 'pid_list' not described in 'trace_pid_list_free'
Message-ID: <202311160229.EVnWvmJ9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c42d9eeef8e5ba9292eda36fd8e3c11f35ee065c
commit: 6954e415264eeb5ee6be0d22d789ad12c995ee64 tracing: Place trace_pid_list logic into abstract functions
date:   2 years, 1 month ago
config: x86_64-randconfig-x012-20230629 (https://download.01.org/0day-ci/archive/20231116/202311160229.EVnWvmJ9-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231116/202311160229.EVnWvmJ9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311160229.EVnWvmJ9-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/trace/pid_list.c:154: warning: Function parameter or member 'pid_list' not described in 'trace_pid_list_free'


vim +154 kernel/trace/pid_list.c

   147	
   148	/**
   149	 * trace_pid_list_free - Frees an allocated pid_list.
   150	 *
   151	 * Frees the memory for a pid_list that was allocated.
   152	 */
   153	void trace_pid_list_free(struct trace_pid_list *pid_list)
 > 154	{

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
