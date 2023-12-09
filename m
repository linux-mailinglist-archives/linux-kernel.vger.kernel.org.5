Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B0C80B45E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 13:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjLIMjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 07:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLIMjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 07:39:14 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58445126
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 04:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702125560; x=1733661560;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8bN5mZF/Y2iZqgcBBIO5aud3uyZsk8ubyJKjVazPMM4=;
  b=SlDJwxo7QHdYzXjjZuOM4qr9lvsODp2xbJOqP1jzdrnPzzes3gndVkxM
   MM3LgE8wfeogHqOsBK7o3hKGUEtrIIOdrwcIfIpkPax3cWQaamt28TMyt
   MnSR0UwNH09s9z1bOdD8xKnWu3Mheawnf0B9x8n8iR1FgB3oIhBQ89egu
   sAReHG4982eVmgi7AyS2/pRZytxCVJ8C5wdQwO9BsqqX5uU2dxmRtaavo
   i6mGWn8bbi4/8CJa2/VpjSu+XEzESQZ1tmPm/Shs6nIBy4iZ8vlMH6Acc
   xECPtn2K1DwIvT2YFR+g8oefWhXXmt2Igatm/ynidBgHvQG23yDxBkOxm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="7867091"
X-IronPort-AV: E=Sophos;i="6.04,263,1695711600"; 
   d="scan'208";a="7867091"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2023 04:39:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="1019648817"
X-IronPort-AV: E=Sophos;i="6.04,263,1695711600"; 
   d="scan'208";a="1019648817"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 09 Dec 2023 04:39:17 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rBwbz-000FLz-0A;
        Sat, 09 Dec 2023 12:39:15 +0000
Date:   Sat, 9 Dec 2023 20:38:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tuan Phan <tuanphan@os.amperecomputing.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: drivers/perf/arm_dsu_pmu.c:641: warning: Function parameter or
 member 'dev' not described in 'dsu_pmu_acpi_get_cpus'
Message-ID: <202312092000.8ltwotjt-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f2e8a57ee9036c7d5443382b6c3c09b51a92ec7e
commit: 2b694fc92a34e8c8b774a17266656d72b8cd4429 perf: arm_dsu: Support DSU ACPI devices
date:   3 years, 3 months ago
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20231209/202312092000.8ltwotjt-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231209/202312092000.8ltwotjt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312092000.8ltwotjt-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/perf/arm_dsu_pmu.c:383: warning: Function parameter or member 'event' not described in 'dsu_pmu_set_event_period'
   drivers/perf/arm_dsu_pmu.c:611: warning: Function parameter or member 'dev' not described in 'dsu_pmu_dt_get_cpus'
   drivers/perf/arm_dsu_pmu.c:611: warning: Function parameter or member 'mask' not described in 'dsu_pmu_dt_get_cpus'
>> drivers/perf/arm_dsu_pmu.c:641: warning: Function parameter or member 'dev' not described in 'dsu_pmu_acpi_get_cpus'
>> drivers/perf/arm_dsu_pmu.c:641: warning: Function parameter or member 'mask' not described in 'dsu_pmu_acpi_get_cpus'


vim +641 drivers/perf/arm_dsu_pmu.c

   635	
   636	/**
   637	 * dsu_pmu_acpi_get_cpus: Get the list of CPUs in the cluster
   638	 * from ACPI.
   639	 */
   640	static int dsu_pmu_acpi_get_cpus(struct device *dev, cpumask_t *mask)
 > 641	{
   642	#ifdef CONFIG_ACPI
   643		int cpu;
   644	
   645		/*
   646		 * A dsu pmu node is inside a cluster parent node along with cpu nodes.
   647		 * We need to find out all cpus that have the same parent with this pmu.
   648		 */
   649		for_each_possible_cpu(cpu) {
   650			struct acpi_device *acpi_dev;
   651			struct device *cpu_dev = get_cpu_device(cpu);
   652	
   653			if (!cpu_dev)
   654				continue;
   655	
   656			acpi_dev = ACPI_COMPANION(cpu_dev);
   657			if (acpi_dev &&
   658				acpi_dev->parent == ACPI_COMPANION(dev)->parent)
   659				cpumask_set_cpu(cpu, mask);
   660		}
   661	#endif
   662	
   663		return 0;
   664	}
   665	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
