Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8B77A6998
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 19:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbjISR1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 13:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjISR1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 13:27:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2C29F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 10:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695144422; x=1726680422;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7TlGFJ8lA21jCNt7kH5Lh+BnqLaNdN3Dh2foCJVmesg=;
  b=LVnFQb7CTY0Bot8/RdE82KVtOTg7gEzC5+rvjB1qZhaDcLJI2/iO2ffZ
   4bSJj5+MOO5mbtsP+oUois1FZWrhGxJ8riWkIHXTx9La5teKRDHx4t4ms
   GaPHBKa9CDyMB2y7+st4QnaYdTEO5UKgwIDPshDYqey3RsDBjX3TeRmdG
   51Kdxyxr8J0mGHqFT2ta2Vzl+jUY/T32F1FfTA/S/3DrHbBvxirN2V2UM
   a2HG4s2OXAAkAv0uUeCt0VZiW+L4dX0oI9ZXsHIg9ce9l9Ouuywr0Zs7A
   mZQmAyH2nQnyfWILhIjoWLgNaaOTOPsJ7vT1R9siF9NWpEShvofsZTdXA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="359397486"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="359397486"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 10:27:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="749568488"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="749568488"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 19 Sep 2023 10:27:00 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qieV0-0007js-0p;
        Tue, 19 Sep 2023 17:26:58 +0000
Date:   Wed, 20 Sep 2023 01:26:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Raymond <draymond@foxvalley.net>, linux-kernel@vger.kernel.org,
        x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com
Cc:     oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v1] arch/x86: port I/O tracing on x86
Message-ID: <202309200145.BvT2lk7a-lkp@intel.com>
References: <14c27df7-12a3-e432-a741-17672185c092@foxvalley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14c27df7-12a3-e432-a741-17672185c092@foxvalley.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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
config: x86_64-buildonly-randconfig-004-20230919 (https://download.01.org/0day-ci/archive/20230920/202309200145.BvT2lk7a-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230920/202309200145.BvT2lk7a-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309200145.BvT2lk7a-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/x86/lib/trace_portio.c:6:6: warning: no previous declaration for 'do_trace_portio_read' [-Wmissing-declarations]
    void do_trace_portio_read(u32 value, u16 port, char width, long ip_addr)
         ^~~~~~~~~~~~~~~~~~~~
>> arch/x86/lib/trace_portio.c:13:6: warning: no previous declaration for 'do_trace_portio_write' [-Wmissing-declarations]
    void do_trace_portio_write(u32 value, u16 port, char width, long ip_addr)
         ^~~~~~~~~~~~~~~~~~~~~


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
