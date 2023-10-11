Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8445C7C4783
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 03:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344727AbjJKBww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 21:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344725AbjJKBwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 21:52:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0FB94
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 18:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696989168; x=1728525168;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KCEdcreh/HF6DZ4WqO2jFJUfTma581oIRBIKEzUEwJo=;
  b=WF6yGSsfeiSysZkGpI0uJpfhPDpLxpiGsd/zD5UzUSdlgambKBKF4o7v
   t3zc/g7FKXbL1Jcxl3nczjnsHLiY2T9iSd6gjBRdTvlsWXlua2rN0RKIi
   olnv7jhbSh5H15m/H7kuhYoXdUCFS/hGzFP53No7O+PhSXpvBHcOYdsIh
   AQoQ8LDMVHC+b7rNQnOceS0h0U56XG9jqZrox2IOHLxcRANDYLxlyD966
   nQZhy6+PCWlXOsKInQ+DLr2vYR0EzZkCSp9sxJei63ZwkCzTlBupa0thm
   WG0fv3WX7JCPMABG8gq/P0z4Ro/ezSM65y5U6mHajfkKaU3WF+kIF1FF3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="6118474"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="6118474"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 18:52:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="788805376"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="788805376"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 10 Oct 2023 18:52:46 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qqOOx-0001X3-32;
        Wed, 11 Oct 2023 01:52:43 +0000
Date:   Wed, 11 Oct 2023 09:52:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: kernel/reboot.c:559: warning: Function parameter or member
 'poweroff_delay_ms' not described in 'hw_failure_emergency_poweroff'
Message-ID: <202310110952.0PSEypq4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matti,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1c8b86a3799f7e5be903c3f49fcdaee29fd385b5
commit: dfa19b11385d4cf8f0242fd93e2073e25183c331 reboot: Add hardware protection power-off
date:   2 years, 4 months ago
config: csky-allnoconfig (https://download.01.org/0day-ci/archive/20231011/202310110952.0PSEypq4-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231011/202310110952.0PSEypq4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310110952.0PSEypq4-lkp@intel.com/

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
