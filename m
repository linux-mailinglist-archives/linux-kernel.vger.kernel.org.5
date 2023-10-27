Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B687D9060
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 09:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345406AbjJ0HxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 03:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjJ0HxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 03:53:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B613710A
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 00:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698393197; x=1729929197;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P/yOqQ4Cd/IlUFgO4FrmjKk2i17lrW5rDm0XHBj/QHI=;
  b=T3rruu2kUUhIDbRZ2gLoG7ID46b3LA/HKdhWuESDnVV1u7mE8/Rcybo3
   JBmibdRHiIx6OJfzzscR71wUbVUZJ5EU7fUXGwruO2z8wnJK6CvQK5OMB
   Gi35fVzNFE3BqTwtfSfHDH+PcZk0C1UmyaBCHW8+8JfhFmpVKC1MzNQBL
   LA9buGb63UpqkRZOr9xS/L62UBbcBatZTYwQ2sGBwsDcoHthVbj1mbiK2
   TaPCCCReLT0jZsTxRvNnDiiIR3DsWbmvU5oFGO3iyCIjFPZ8TsywPvW+3
   wQBNw95o/7XGevxEfVs0DgJ2krvfKMAofa0o+7fzlK0buUFvYo8fGqIys
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="391602946"
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="391602946"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 00:53:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="753034176"
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="753034176"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 27 Oct 2023 00:53:15 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qwHeb-000Abj-1H;
        Fri, 27 Oct 2023 07:53:13 +0000
Date:   Fri, 27 Oct 2023 15:53:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] Fix: rseq uapi: Adapt header includes to follow glibc
 header changes
Message-ID: <202310271556.LunB8KLv-lkp@intel.com>
References: <20231025214811.2066376-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025214811.2066376-1-mathieu.desnoyers@efficios.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.6-rc7 next-20231026]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mathieu-Desnoyers/Fix-rseq-uapi-Adapt-header-includes-to-follow-glibc-header-changes/20231026-054939
base:   linus/master
patch link:    https://lore.kernel.org/r/20231025214811.2066376-1-mathieu.desnoyers%40efficios.com
patch subject: [PATCH] Fix: rseq uapi: Adapt header includes to follow glibc header changes
config: i386-randconfig-001-20231026 (https://download.01.org/0day-ci/archive/20231027/202310271556.LunB8KLv-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231027/202310271556.LunB8KLv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310271556.LunB8KLv-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> usr/include/linux/rseq.h:14: include of <linux/types.h> is preferred over <asm/types.h>
>> usr/include/linux/rseq.h:47: found __[us]{8,16,32,64} type without #include <linux/types.h>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
