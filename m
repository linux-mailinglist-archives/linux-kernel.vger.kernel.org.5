Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F1E78F4CC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 23:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344465AbjHaVsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 17:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjHaVsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 17:48:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E101107;
        Thu, 31 Aug 2023 14:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693518491; x=1725054491;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fyKHqNX+S6iP8eJGiKl0nPLQVuYd6Rt+T7dYwQh+bq8=;
  b=dlBxphxWQoso1uW5Rq8PkdNBLZ1WgfG0tmuXh+IaSZAyasVPg5M+trYW
   h6t1x94jCzbCBZngV//W372aIRC8EAm8lxQThpGwG9l7WIZijzfybSKSw
   bHVdEKqCZITgqeONLg8npzsgUQTIIuGRZTeNOS5pDenZ/EpUPY9638Jpf
   pOn+uk3Bf6WdSWLz2Ay7HnlIwDeHYr/UfGO8onVXMIOezaH43F1PyouUF
   EzL5qkoYia841IiXzh33+d+uTM6bqAlvBWU+hHA8LkUOC2UHOlGvdUj/N
   joOUuL3MPZ0SWpS+ouVH2/tdaKWDk8aFre7TADdzKS1SVHr2MCcwPHzaJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="374978750"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="374978750"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 14:48:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="805191163"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="805191163"
Received: from lkp-server01.sh.intel.com (HELO 5d8055a4f6aa) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 31 Aug 2023 14:48:09 -0700
Received: from kbuild by 5d8055a4f6aa with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qbpWJ-0000ZX-0L;
        Thu, 31 Aug 2023 21:48:07 +0000
Date:   Fri, 1 Sep 2023 05:47:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Koba Ko <koba.ko@canonical.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] ata: libata: add workaround to flip LPM during
 suspend/resume
Message-ID: <202309010504.kO8lW46F-lkp@intel.com>
References: <20230831190828.1171119-1-koba.ko@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831190828.1171119-1-koba.ko@canonical.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Koba,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.5 next-20230831]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Koba-Ko/ata-libata-add-workaround-to-flip-LPM-during-suspend-resume/20230901-030957
base:   linus/master
patch link:    https://lore.kernel.org/r/20230831190828.1171119-1-koba.ko%40canonical.com
patch subject: [PATCH] ata: libata: add workaround to flip LPM during suspend/resume
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20230901/202309010504.kO8lW46F-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230901/202309010504.kO8lW46F-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309010504.kO8lW46F-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/ata/ahci.c:98:12: warning: 'ahci_intel_port_suspend' declared 'static' but never defined [-Wunused-function]
      98 | static int ahci_intel_port_suspend(struct ata_port *ap, pm_message_t mesg);
         |            ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/ata/ahci.c:99:12: warning: 'ahci_intel_port_resume' declared 'static' but never defined [-Wunused-function]
      99 | static int ahci_intel_port_resume(struct ata_port *ap);
         |            ^~~~~~~~~~~~~~~~~~~~~~


vim +98 drivers/ata/ahci.c

    82	
    83	static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent);
    84	static void ahci_remove_one(struct pci_dev *dev);
    85	static void ahci_shutdown_one(struct pci_dev *dev);
    86	static void ahci_intel_pcs_quirk(struct pci_dev *pdev, struct ahci_host_priv *hpriv);
    87	static int ahci_vt8251_hardreset(struct ata_link *link, unsigned int *class,
    88					 unsigned long deadline);
    89	static int ahci_avn_hardreset(struct ata_link *link, unsigned int *class,
    90				      unsigned long deadline);
    91	static void ahci_mcp89_apple_enable(struct pci_dev *pdev);
    92	static bool is_mcp89_apple(struct pci_dev *pdev);
    93	static int ahci_p5wdh_hardreset(struct ata_link *link, unsigned int *class,
    94					unsigned long deadline);
    95	#ifdef CONFIG_PM
    96	static int ahci_pci_device_runtime_suspend(struct device *dev);
    97	static int ahci_pci_device_runtime_resume(struct device *dev);
  > 98	static int ahci_intel_port_suspend(struct ata_port *ap, pm_message_t mesg);
  > 99	static int ahci_intel_port_resume(struct ata_port *ap);
   100	#ifdef CONFIG_PM_SLEEP
   101	static int ahci_pci_device_suspend(struct device *dev);
   102	static int ahci_pci_device_resume(struct device *dev);
   103	#endif
   104	#endif /* CONFIG_PM */
   105	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
