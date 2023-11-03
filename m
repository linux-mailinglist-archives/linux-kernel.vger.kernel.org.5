Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEAA67E0AE6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 23:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbjKCWBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 18:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjKCWBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 18:01:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DFEA2
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 15:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699048858; x=1730584858;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cwS3JKDa4hP3hoRLv+DbIRI3lugnTW+baL64q1eqxyw=;
  b=EvfoXqYhVs6FVoRfPtlFs+EY88eMkGirSVpN0neEBkYg2uOJ3ju2Xny0
   /6N87w8dWQ5NP0ImPkAEXIVuQYxY0n0IoyrekbJkV1UbJBhpuABQ/vYhJ
   y/HzozfWSXmGyJoAOKCrd4QAbbgKFew6fAi65ogC6FJkLcauIbfZYz3S3
   NRL4f5PswjN/XcSsc9QjAKrXXCcandfb9K6epnWeYHL+EmNGKJ/f6Phye
   pdBy7ZNlHcqmo5TtCm+ySfW5ImJmu740KT/FF7SxAgGEHTOCUqRFZbUgH
   od8KX/d7gKQsnjVPNmDM7AD0WiKz1Bl4NPb7+edGpirjxHWzZFJr9n65F
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="387918182"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="387918182"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 15:00:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="765385308"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="765385308"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 03 Nov 2023 15:00:57 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qz2Dn-0002z0-0X;
        Fri, 03 Nov 2023 22:00:55 +0000
Date:   Sat, 4 Nov 2023 05:59:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     John Johansen <john.johansen@canonical.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Georgia Garcia <georgia.garcia@canonical.com>
Subject: security/apparmor/task.c:290: warning: Function parameter or member
 'tracee_cred' not described in 'aa_may_ptrace'
Message-ID: <202311040508.AUhi04RY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e392ea4d4d00880bf94550151b1ace4f88a4b17a
commit: 90c436a64a6e20482a9a613c47eb4af2e8a5328e apparmor: pass cred through to audit info.
date:   2 weeks ago
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20231104/202311040508.AUhi04RY-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231104/202311040508.AUhi04RY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311040508.AUhi04RY-lkp@intel.com/

All warnings (new ones prefixed by >>):

   security/apparmor/task.c:290: warning: Function parameter or member 'tracer_cred' not described in 'aa_may_ptrace'
>> security/apparmor/task.c:290: warning: Function parameter or member 'tracee_cred' not described in 'aa_may_ptrace'


vim +290 security/apparmor/task.c

eac931254d99c5 John Johansen 2021-11-22  278  
eac931254d99c5 John Johansen 2021-11-22  279  /**
eac931254d99c5 John Johansen 2021-11-22  280   * aa_may_ptrace - test if tracer task can trace the tracee
eac931254d99c5 John Johansen 2021-11-22  281   * @tracer: label of the task doing the tracing  (NOT NULL)
eac931254d99c5 John Johansen 2021-11-22  282   * @tracee: task label to be traced
eac931254d99c5 John Johansen 2021-11-22  283   * @request: permission request
eac931254d99c5 John Johansen 2021-11-22  284   *
eac931254d99c5 John Johansen 2021-11-22  285   * Returns: %0 else error code if permission denied or error
eac931254d99c5 John Johansen 2021-11-22  286   */
90c436a64a6e20 John Johansen 2022-09-19  287  int aa_may_ptrace(const struct cred *tracer_cred, struct aa_label *tracer,
90c436a64a6e20 John Johansen 2022-09-19  288  		  const struct cred *tracee_cred, struct aa_label *tracee,
eac931254d99c5 John Johansen 2021-11-22  289  		  u32 request)
eac931254d99c5 John Johansen 2021-11-22 @290  {

:::::: The code at line 290 was first introduced by commit
:::::: eac931254d99c5aeb12ace02366dd338c4371164 apparmor: move ptrace mediation to more logical task.{h,c}

:::::: TO: John Johansen <john.johansen@canonical.com>
:::::: CC: John Johansen <john.johansen@canonical.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
