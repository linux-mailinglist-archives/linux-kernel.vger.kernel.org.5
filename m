Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57EE7F04D0
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 09:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjKSIau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 03:30:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKSIat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 03:30:49 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6E5E1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 00:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700382646; x=1731918646;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Df3Zre3xLHpSHfVyBQprw2bK9s+r7A7H2Tx6KckZUGQ=;
  b=Evu+Dx1CSmVOh3DmSRqHmsSXErNZk3jUvCyho9Hra53zSbkDJ4s8vEs9
   Av8hL67r4DwYG4lKaDTJDP3E+kvi+UlpVwSRo6d+n3RsP+WDhEfHE/pXs
   JcqjFLlOJLvCqtDHfHyJEU6uF7pPZndNd+Q70R5KcGhA4Q9V6p8Rp/OWR
   ZwLzS42jLA/EkeTvsaBd7bwzWSSwISvm6XeeC7XAZW689PgOssmoIM+jP
   OfzchzV5+YOtIWIme/+PLSS/HM2FgEx6MZyi+V+9+pin/6nfVWiOHR5xw
   EIyFPeouugLEuTJAbf48oQMHch9PUfvHvoaxi32MrNY/ZZI0263GJHvGr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10898"; a="13030148"
X-IronPort-AV: E=Sophos;i="6.04,210,1695711600"; 
   d="scan'208";a="13030148"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2023 00:30:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10898"; a="715937198"
X-IronPort-AV: E=Sophos;i="6.04,210,1695711600"; 
   d="scan'208";a="715937198"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 19 Nov 2023 00:30:44 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r4dCS-0004ql-2J;
        Sun, 19 Nov 2023 08:30:40 +0000
Date:   Sun, 19 Nov 2023 16:28:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: kernel/reboot.c:559: warning: Function parameter or member
 'poweroff_delay_ms' not described in 'hw_failure_emergency_poweroff'
Message-ID: <202311191617.LlfQ8ae6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matti,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   037266a5f7239ead1530266f7d7af153d2a867fa
commit: dfa19b11385d4cf8f0242fd93e2073e25183c331 reboot: Add hardware protection power-off
date:   2 years, 5 months ago
config: i386-allnoconfig (https://download.01.org/0day-ci/archive/20231119/202311191617.LlfQ8ae6-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231119/202311191617.LlfQ8ae6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311191617.LlfQ8ae6-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/reboot.c:215: warning: Function parameter or member 'cmd' not described in 'do_kernel_restart'
>> kernel/reboot.c:559: warning: Function parameter or member 'poweroff_delay_ms' not described in 'hw_failure_emergency_poweroff'


vim +559 kernel/reboot.c

   548	
   549	static DECLARE_DELAYED_WORK(hw_failure_emergency_poweroff_work,
   550				    hw_failure_emergency_poweroff_func);
   551	
   552	/**
   553	 * hw_failure_emergency_poweroff - Trigger an emergency system poweroff
   554	 *
   555	 * This may be called from any critical situation to trigger a system shutdown
   556	 * after a given period of time. If time is negative this is not scheduled.
   557	 */
   558	static void hw_failure_emergency_poweroff(int poweroff_delay_ms)
 > 559	{
   560		if (poweroff_delay_ms <= 0)
   561			return;
   562		schedule_delayed_work(&hw_failure_emergency_poweroff_work,
   563				      msecs_to_jiffies(poweroff_delay_ms));
   564	}
   565	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
