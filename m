Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547EF803D40
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 19:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbjLDSiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 13:38:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjLDSiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 13:38:05 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1986FA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 10:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701715091; x=1733251091;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zQo8GjEv9bEuzHJxmKY65GuqHagVCFJmulczEw1i9CQ=;
  b=aRjoTfmSCD14gmzx/nh4GuYDOa9YBKvQ+QafFvzwsnAO+RTNg9TSQ7rM
   EVQH5sY7y9LPqP7Ls4XsocOnSAjJUSMJzahOxekQq+5bd+DRlYMMp9K77
   bKS78RCUMGVybVBUCYuNJdhq2XtJoTe3dmcr4JEWnqQaZpXCsq4NHnWQv
   mW5T0tiIb07183IWsyFZ2GL0aLrN7qPwcfUbKaEOZEQiQFIftpg9SuF3d
   C90qQ4wPiRzO28LXksmYkG8jGFJq1jpslrPyCZJ64w8tTq+x48sAFNJx4
   XhQqVVAvETa3Yk6il1k4k0GJxBmlivAxVARAPsAldVhSzXtsZ1nXqFu/o
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="397674934"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="397674934"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 10:38:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="774343916"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="774343916"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 04 Dec 2023 10:38:08 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rADpV-000804-2q;
        Mon, 04 Dec 2023 18:38:05 +0000
Date:   Tue, 5 Dec 2023 02:37:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        suzuki.poulose@arm.com
Cc:     oe-kbuild-all@lists.linux.dev, James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2] coresight: Make current W=1 warnings default
Message-ID: <202312050158.FKpxuafP-lkp@intel.com>
References: <20231115162834.355598-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115162834.355598-1-james.clark@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

kernel test robot noticed the following build warnings:

[auto build test WARNING on atorgue-stm32/stm32-next]
[also build test WARNING on linus/master v6.7-rc4 next-20231204]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/James-Clark/coresight-Make-current-W-1-warnings-default/20231116-004818
base:   https://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git stm32-next
patch link:    https://lore.kernel.org/r/20231115162834.355598-1-james.clark%40arm.com
patch subject: [PATCH v2] coresight: Make current W=1 warnings default
config: arm-randconfig-r131-20231117 (https://download.01.org/0day-ci/archive/20231205/202312050158.FKpxuafP-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231205/202312050158.FKpxuafP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312050158.FKpxuafP-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/hwtracing/coresight/coresight-etb10.c:840:17: sparse: sparse: Using plain integer as NULL pointer
   drivers/hwtracing/coresight/coresight-etb10.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, ...):
   include/linux/page-flags.h:242:46: sparse: sparse: self-comparison always evaluates to false
--
>> drivers/hwtracing/coresight/coresight-funnel.c:395:17: sparse: sparse: Using plain integer as NULL pointer
   drivers/hwtracing/coresight/coresight-funnel.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/slab.h, ...):
   include/linux/page-flags.h:242:46: sparse: sparse: self-comparison always evaluates to false
--
>> drivers/hwtracing/coresight/coresight-tpdm.c:242:17: sparse: sparse: Using plain integer as NULL pointer
   drivers/hwtracing/coresight/coresight-tpdm.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, ...):
   include/linux/page-flags.h:242:46: sparse: sparse: self-comparison always evaluates to false

vim +840 drivers/hwtracing/coresight/coresight-etb10.c

   834	
   835	static const struct amba_id etb_ids[] = {
   836		{
   837			.id	= 0x000bb907,
   838			.mask	= 0x000fffff,
   839		},
 > 840		{ 0, 0, 0 },
   841	};
   842	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
