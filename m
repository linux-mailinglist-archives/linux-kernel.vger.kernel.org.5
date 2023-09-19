Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F41D67A6997
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 19:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbjISR1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 13:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjISR1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 13:27:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F025A6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 10:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695144423; x=1726680423;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JYtHS6/pwErt9eMHkWOA4Rpq7zWdXU9JPzjptQ4Zl+o=;
  b=PPEO4/w0koUS/XxF/tREHA/yCFsvefnzKHUFr42f9NyXuBSXu8iW7In1
   Uv4bkV8t6Y3QfJx4EIqq3gVuh/rhjqB1UOATHrBeWlY0pWukkuYfnvlbC
   ucDeEDZYjSczGO4j4WTjK3rUiOHcaH4JBDFUsC07yJyFzRt3PWuhuVIlc
   ToPg2UL9jyOqzQ4t/3h4DvhDM5Zj9Cecd/mu7727JJ5RBM+pWd0f6gkA+
   we+Lu0vMAGMphCOpBLBWu3OQ6TPzv/PkFIpUc3UO1TLpuX9UNzM0wcZtL
   DJGtZzbE/IWQue0O6OsL+61IzrcIqyDDEMbgMFRdsfcwp0An2u+jV7zx0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="410936046"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="410936046"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 10:27:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="746316071"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="746316071"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 19 Sep 2023 10:27:00 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qieV0-0007jo-0c;
        Tue, 19 Sep 2023 17:26:58 +0000
Date:   Wed, 20 Sep 2023 01:26:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Raymond <draymond@foxvalley.net>, linux-kernel@vger.kernel.org,
        x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com
Cc:     oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v1] arch/x86: port I/O tracing on x86
Message-ID: <202309200143.Me2RTikv-lkp@intel.com>
References: <14c27df7-12a3-e432-a741-17672185c092@foxvalley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14c27df7-12a3-e432-a741-17672185c092@foxvalley.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on be8b93b5cc7d533eb8c9b0590cdac055ecafe13a]

url:    https://github.com/intel-lab-lkp/linux/commits/Dan-Raymond/arch-x86-port-I-O-tracing-on-x86/20230919-015640
base:   be8b93b5cc7d533eb8c9b0590cdac055ecafe13a
patch link:    https://lore.kernel.org/r/14c27df7-12a3-e432-a741-17672185c092%40foxvalley.net
patch subject: [PATCH v1] arch/x86: port I/O tracing on x86
config: x86_64-buildonly-randconfig-001-20230919 (https://download.01.org/0day-ci/archive/20230920/202309200143.Me2RTikv-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230920/202309200143.Me2RTikv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309200143.Me2RTikv-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/x86/lib/trace_portio.c:6:6: warning: no previous prototype for 'do_trace_portio_read' [-Wmissing-prototypes]
       6 | void do_trace_portio_read(u32 value, u16 port, char width, long ip_addr)
         |      ^~~~~~~~~~~~~~~~~~~~
>> arch/x86/lib/trace_portio.c:13:6: warning: no previous prototype for 'do_trace_portio_write' [-Wmissing-prototypes]
      13 | void do_trace_portio_write(u32 value, u16 port, char width, long ip_addr)
         |      ^~~~~~~~~~~~~~~~~~~~~


vim +/do_trace_portio_read +6 arch/x86/lib/trace_portio.c

     5	
   > 6	void do_trace_portio_read(u32 value, u16 port, char width, long ip_addr)
     7	{
     8		trace_portio_read(value, port, width, ip_addr);
     9	}
    10	EXPORT_SYMBOL_GPL(do_trace_portio_read);
    11	EXPORT_TRACEPOINT_SYMBOL_GPL(portio_read);
    12	
  > 13	void do_trace_portio_write(u32 value, u16 port, char width, long ip_addr)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
