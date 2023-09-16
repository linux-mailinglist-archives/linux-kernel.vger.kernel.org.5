Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8D17A2BF2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 02:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238170AbjIPA0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 20:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238391AbjIPA0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 20:26:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B403C13;
        Fri, 15 Sep 2023 17:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694823889; x=1726359889;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OAJoXRpLWIJ0ZW1gEurh1Ryi/QaYjHylSLez52f4b9s=;
  b=byWDLfTScGfrUa7BZ/yQvnprpWfWbVx5uLN71vAt067HoJlOdSQVegLj
   plIAt52eTF3cXI0Q0HTHox4jZQnJWg/v0zS8K+hNL13Q9BskEYMhYetQC
   XWaF9UfPWAuWzrplPFLnJczjCADIZhYvs8HZmnQ+9Aj7wfsqGCd7A6XGP
   ouu/WKaZBGBOraJdH+OeDBY6HPPHIOU9XQZFg2Fjt0TcKYAWsQBJyDYpQ
   +UUbX2xOemo4eMlbylsZ36qvOxDFk3YDnYp9xcKhelmkwx+q97WVBIiTe
   NkJP+GE2/ruZJKiYql4NVAyVEVtytWdmsZClxpEoW0+G3WjYN4Jgs2Hxv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="379281549"
X-IronPort-AV: E=Sophos;i="6.02,150,1688454000"; 
   d="scan'208";a="379281549"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 17:22:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="745177616"
X-IronPort-AV: E=Sophos;i="6.02,150,1688454000"; 
   d="scan'208";a="745177616"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 15 Sep 2023 17:22:47 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qhJ5B-0003eC-0U;
        Sat, 16 Sep 2023 00:22:45 +0000
Date:   Sat, 16 Sep 2023 08:21:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/timerlat: Hotplug support for the user-space
 interface
Message-ID: <202309160854.SAw0rIUm-lkp@intel.com>
References: <b619d9fd08a3bb47018cf40afa95783844a3c1fd.1694789910.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b619d9fd08a3bb47018cf40afa95783844a3c1fd.1694789910.git.bristot@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.6-rc1 next-20230915]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Bristot-de-Oliveira/tracing-timerlat-Hotplug-support-for-the-user-space-interface/20230915-230157
base:   linus/master
patch link:    https://lore.kernel.org/r/b619d9fd08a3bb47018cf40afa95783844a3c1fd.1694789910.git.bristot%40kernel.org
patch subject: [PATCH] tracing/timerlat: Hotplug support for the user-space interface
config: um-randconfig-002-20230916 (https://download.01.org/0day-ci/archive/20230916/202309160854.SAw0rIUm-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230916/202309160854.SAw0rIUm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309160854.SAw0rIUm-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/trace/trace_osnoise.c:2125:13: warning: 'timerlat_rm_per_cpu_interface' defined but not used [-Wunused-function]
    2125 | static void timerlat_rm_per_cpu_interface(long cpu) {};
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> kernel/trace/trace_osnoise.c:2124:12: warning: 'timerlat_add_per_cpu_interface' defined but not used [-Wunused-function]
    2124 | static int timerlat_add_per_cpu_interface(long cpu) { return 0; };
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/timerlat_rm_per_cpu_interface +2125 kernel/trace/trace_osnoise.c

  2112	
  2113	static void timerlat_rm_per_cpu_interface(long cpu)
  2114	{
  2115		struct dentry *cpu_dir = per_cpu_ptr(&osnoise_per_cpu_dir, cpu)->root;
  2116	
  2117		if (cpu_dir) {
  2118			tracefs_remove(cpu_dir);
  2119			per_cpu_ptr(&osnoise_per_cpu_dir, cpu)->root = NULL;
  2120			per_cpu_ptr(&osnoise_per_cpu_dir, cpu)->timerlat_fd = NULL;
  2121		}
  2122	}
  2123	#else
> 2124	static int timerlat_add_per_cpu_interface(long cpu) { return 0; };
> 2125	static void timerlat_rm_per_cpu_interface(long cpu) {};
  2126	#endif
  2127	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
