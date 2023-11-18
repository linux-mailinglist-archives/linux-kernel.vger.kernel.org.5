Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768757F02DE
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 21:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjKRUTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 15:19:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjKRUTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 15:19:51 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EC0192
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 12:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700338787; x=1731874787;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=f11rQibK464FXhCjUj1JZhQmkBMtmhBbqxL9WP7GZWk=;
  b=Ss8XxGmwo/7iXABnEvWWLEfRsVHY5UbSW6mM7mbGuAL1TEmYYQ7MQ9hK
   sH+sppBpnopFrLvXpP/CW1Ceku+n4R6LV1DQk70zfF7lDXqnS6FJ1x5f2
   9Ny+VniyvkoYSb5RuLnwcVev3IR4Uxwlswn535tzk7umT7lD5lQMTiQBI
   NidyHyVl/0tJt/B3luApJCd96BgRK6PmQQC/lD4MXtg5hgNPc7rqRGGlr
   XD98r35P1w8l7czUphnDRQtyTNLTaQslKKzLH69h5i3DO1ciA0cLXEUqv
   8Pfdcuy91jhvcKUWudsaz2O1qvq7Fac26tZOM1xsBjuNBFT+m4v+lfqq/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10898"; a="10115286"
X-IronPort-AV: E=Sophos;i="6.04,209,1695711600"; 
   d="scan'208";a="10115286"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2023 12:19:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10898"; a="889555331"
X-IronPort-AV: E=Sophos;i="6.04,209,1695711600"; 
   d="scan'208";a="889555331"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 18 Nov 2023 12:19:44 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r4Rn3-0004Fn-1S;
        Sat, 18 Nov 2023 20:19:41 +0000
Date:   Sun, 19 Nov 2023 04:18:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sreekanth Reddy <sreekanth.reddy@avagotech.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
Subject: drivers/scsi/mpt3sas/mpt3sas_base.c:257:57: warning: '%s' directive
 output may be truncated writing up to 31 bytes into a region of size 15
Message-ID: <202311190448.wkvrT5iZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   05aa69b096a089dc85391e36ccdce76961694e22
commit: c84b06a48c4d8ac8270624453132f3fa1a4a0f9d mpt3sas: Single driver module which supports both SAS 2.0 & SAS 3.0 HBAs
date:   8 years ago
config: x86_64-randconfig-r021-20230729 (https://download.01.org/0day-ci/archive/20231119/202311190448.wkvrT5iZ-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231119/202311190448.wkvrT5iZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311190448.wkvrT5iZ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/kobject.h:21,
                    from include/linux/module.h:17,
                    from drivers/scsi/mpt3sas/mpt3sas_base.c:47:
   include/linux/sysfs.h: In function 'sysfs_get_dirent':
   include/linux/sysfs.h:496:44: warning: pointer targets in passing argument 2 of 'kernfs_find_and_get' differ in signedness [-Wpointer-sign]
     496 |         return kernfs_find_and_get(parent, name);
         |                                            ^~~~
         |                                            |
         |                                            const unsigned char *
   In file included from include/linux/sysfs.h:15:
   include/linux/kernfs.h:428:57: note: expected 'const char *' but argument is of type 'const unsigned char *'
     428 | kernfs_find_and_get(struct kernfs_node *kn, const char *name)
         |                                             ~~~~~~~~~~~~^~~~
   drivers/scsi/mpt3sas/mpt3sas_base.c: In function '_base_display_event_data':
   drivers/scsi/mpt3sas/mpt3sas_base.c:610:17: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
     610 |                 if (event_data->DiscoveryStatus)
         |                 ^~
   In file included from include/linux/kernel.h:13,
                    from drivers/scsi/mpt3sas/mpt3sas_base.c:46:
   include/linux/printk.h:259:9: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
     259 |         printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   drivers/scsi/mpt3sas/mpt3sas_base.c:613:25: note: in expansion of macro 'pr_info'
     613 |                         pr_info("\n");
         |                         ^~~~~~~
   drivers/scsi/mpt3sas/mpt3sas_base.c: At top level:
   drivers/scsi/mpt3sas/mpt3sas_base.c:2013:1: warning: no previous declaration for 'mpt3sas_base_unmap_resources' [-Wmissing-declarations]
    2013 | mpt3sas_base_unmap_resources(struct MPT3SAS_ADAPTER *ioc)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/mpt3sas/mpt3sas_base.c: In function '_base_display_ioc_capabilities':
   drivers/scsi/mpt3sas/mpt3sas_base.c:2789:36: warning: pointer targets in passing argument 2 of 'strncpy' differ in signedness [-Wpointer-sign]
    2789 |         strncpy(desc, ioc->manu_pg0.ChipName, 16);
         |                       ~~~~~~~~~~~~~^~~~~~~~~
         |                                    |
         |                                    U8 * {aka unsigned char *}
   In file included from include/linux/dynamic_debug.h:111,
                    from include/linux/printk.h:277:
   include/linux/string.h:23:30: note: expected 'const char *' but argument is of type 'U8 *' {aka 'unsigned char *'}
      23 | extern char * strncpy(char *,const char *, __kernel_size_t);
         |                              ^~~~~~~~~~~~
   drivers/scsi/mpt3sas/mpt3sas_base.c: In function '_base_handshake_req_reply_wait':
   drivers/scsi/mpt3sas/mpt3sas_base.c:3819:13: warning: variable 'dummy' set but not used [-Wunused-but-set-variable]
    3819 |         u16 dummy;
         |             ^~~~~
   drivers/scsi/mpt3sas/mpt3sas_base.c: In function 'mpt3sas_base_sas_iounit_control':
   drivers/scsi/mpt3sas/mpt3sas_base.c:3944:23: warning: variable 'timeleft' set but not used [-Wunused-but-set-variable]
    3944 |         unsigned long timeleft;
         |                       ^~~~~~~~
   drivers/scsi/mpt3sas/mpt3sas_base.c: In function 'mpt3sas_base_scsi_enclosure_processor':
   drivers/scsi/mpt3sas/mpt3sas_base.c:4048:23: warning: variable 'timeleft' set but not used [-Wunused-but-set-variable]
    4048 |         unsigned long timeleft;
         |                       ^~~~~~~~
   drivers/scsi/mpt3sas/mpt3sas_base.c: In function '_base_send_port_enable':
   drivers/scsi/mpt3sas/mpt3sas_base.c:4490:23: warning: variable 'timeleft' set but not used [-Wunused-but-set-variable]
    4490 |         unsigned long timeleft;
         |                       ^~~~~~~~
   drivers/scsi/mpt3sas/mpt3sas_base.c: In function '_base_event_notification':
   drivers/scsi/mpt3sas/mpt3sas_base.c:4671:23: warning: variable 'timeleft' set but not used [-Wunused-but-set-variable]
    4671 |         unsigned long timeleft;
         |                       ^~~~~~~~
   drivers/scsi/mpt3sas/mpt3sas_base.c: In function '_base_display_OEMs_branding':
   drivers/scsi/mpt3sas/mpt3sas_base.c:2530:25: warning: this statement may fall through [-Wimplicit-fallthrough=]
    2530 |                         switch (ioc->pdev->subsystem_device) {
         |                         ^~~~~~
   drivers/scsi/mpt3sas/mpt3sas_base.c:2549:17: note: here
    2549 |                 case MPI2_MFGPAGE_DEVID_SAS2308_2:
         |                 ^~~~
   drivers/scsi/mpt3sas/mpt3sas_base.c:2550:25: warning: this statement may fall through [-Wimplicit-fallthrough=]
    2550 |                         switch (ioc->pdev->subsystem_device) {
         |                         ^~~~~~
   drivers/scsi/mpt3sas/mpt3sas_base.c:2585:17: note: here
    2585 |                 case MPI25_MFGPAGE_DEVID_SAS3008:
         |                 ^~~~
   drivers/scsi/mpt3sas/mpt3sas_base.c:2728:25: warning: this statement may fall through [-Wimplicit-fallthrough=]
    2728 |                         switch (ioc->pdev->subsystem_device) {
         |                         ^~~~~~
   drivers/scsi/mpt3sas/mpt3sas_base.c:2739:17: note: here
    2739 |                 case MPI2_MFGPAGE_DEVID_SAS2308_2:
         |                 ^~~~
   drivers/scsi/mpt3sas/mpt3sas_base.c:2740:25: warning: this statement may fall through [-Wimplicit-fallthrough=]
    2740 |                         switch (ioc->pdev->subsystem_device) {
         |                         ^~~~~~
   drivers/scsi/mpt3sas/mpt3sas_base.c:2763:17: note: here
    2763 |                 default:
         |                 ^~~~~~~
   drivers/scsi/mpt3sas/mpt3sas_base.c: In function 'mpt3sas_base_start_watchdog':
>> drivers/scsi/mpt3sas/mpt3sas_base.c:257:57: warning: '%s' directive output may be truncated writing up to 31 bytes into a region of size 15 [-Wformat-truncation=]
     257 |             sizeof(ioc->fault_reset_work_q_name), "poll_%s%d_status",
         |                                                         ^~
   drivers/scsi/mpt3sas/mpt3sas_base.c:257:51: note: directive argument in the range [0, 255]
     257 |             sizeof(ioc->fault_reset_work_q_name), "poll_%s%d_status",
         |                                                   ^~~~~~~~~~~~~~~~~~
   drivers/scsi/mpt3sas/mpt3sas_base.c:256:9: note: 'snprintf' output between 14 and 47 bytes into a destination of size 20
     256 |         snprintf(ioc->fault_reset_work_q_name,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     257 |             sizeof(ioc->fault_reset_work_q_name), "poll_%s%d_status",
         |             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     258 |             ioc->driver_name, ioc->id);
         |             ~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/mpt3sas/mpt3sas_base.c: In function 'mpt3sas_base_map_resources':
   drivers/scsi/mpt3sas/mpt3sas_base.c:1841:61: warning: '%d' directive output may be truncated writing between 1 and 3 bytes into a region of size between 1 and 32 [-Wformat-truncation=]
    1841 |                 snprintf(reply_q->name, MPT_NAME_LENGTH, "%s%d",
         |                                                             ^~
   In function '_base_request_irq',
       inlined from '_base_enable_msix' at drivers/scsi/mpt3sas/mpt3sas_base.c:2003:6,
       inlined from 'mpt3sas_base_map_resources' at drivers/scsi/mpt3sas/mpt3sas_base.c:2124:6:
   drivers/scsi/mpt3sas/mpt3sas_base.c:1841:58: note: directive argument in the range [0, 255]
    1841 |                 snprintf(reply_q->name, MPT_NAME_LENGTH, "%s%d",
         |                                                          ^~~~~~
   drivers/scsi/mpt3sas/mpt3sas_base.c:1841:17: note: 'snprintf' output between 2 and 35 bytes into a destination of size 32
    1841 |                 snprintf(reply_q->name, MPT_NAME_LENGTH, "%s%d",
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1842 |                     ioc->driver_name, ioc->id);
         |                     ~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/mpt3sas/mpt3sas_base.c: In function 'mpt3sas_base_map_resources':
   drivers/scsi/mpt3sas/mpt3sas_base.c:1838:61: warning: '%d' directive output may be truncated writing between 1 and 3 bytes into a region of size between 1 and 32 [-Wformat-truncation=]
    1838 |                 snprintf(reply_q->name, MPT_NAME_LENGTH, "%s%d-msix%d",
         |                                                             ^~
   In function '_base_request_irq',
       inlined from '_base_enable_msix' at drivers/scsi/mpt3sas/mpt3sas_base.c:2003:6,
       inlined from 'mpt3sas_base_map_resources' at drivers/scsi/mpt3sas/mpt3sas_base.c:2124:6:
   drivers/scsi/mpt3sas/mpt3sas_base.c:1838:58: note: directive argument in the range [0, 255]
    1838 |                 snprintf(reply_q->name, MPT_NAME_LENGTH, "%s%d-msix%d",
         |                                                          ^~~~~~~~~~~~~
   drivers/scsi/mpt3sas/mpt3sas_base.c:1838:17: note: 'snprintf' output between 8 and 41 bytes into a destination of size 32
    1838 |                 snprintf(reply_q->name, MPT_NAME_LENGTH, "%s%d-msix%d",
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1839 |                     ioc->driver_name, ioc->id, index);
         |                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/mpt3sas/mpt3sas_base.c:104: warning: Function parameter or member 'val' not described in '_scsih_set_fwfault_debug'
   drivers/scsi/mpt3sas/mpt3sas_base.c:104: warning: Function parameter or member 'kp' not described in '_scsih_set_fwfault_debug'
   drivers/scsi/mpt3sas/mpt3sas_base.c:928: warning: Excess function parameter 'r' description in '_base_interrupt'
   drivers/scsi/mpt3sas/mpt3sas_base.c:2397: warning: Excess function parameter 'ioc' description in '_base_writeq'
   drivers/scsi/mpt3sas/mpt3sas_base.c:3594: warning: Function parameter or member 'ioc' not described in '_base_wait_on_iocstate'
   drivers/scsi/mpt3sas/mpt3sas_base.c:3628: warning: expecting prototype for _base_wait_for_doorbell_int(). Prototype was for _base_diag_reset() instead
   drivers/scsi/mpt3sas/mpt3sas_base.c:4138: warning: Function parameter or member 'port' not described in '_base_get_port_facts'
   drivers/scsi/mpt3sas/mpt3sas_base.c:4730: warning: Function parameter or member 'event_type' not described in 'mpt3sas_base_validate_event_type'
   drivers/scsi/mpt3sas/mpt3sas_base.c:4730: warning: Excess function parameter 'event' description in 'mpt3sas_base_validate_event_type'


vim +257 drivers/scsi/mpt3sas/mpt3sas_base.c

   237	
   238	/**
   239	 * mpt3sas_base_start_watchdog - start the fault_reset_work_q
   240	 * @ioc: per adapter object
   241	 * Context: sleep.
   242	 *
   243	 * Return nothing.
   244	 */
   245	void
   246	mpt3sas_base_start_watchdog(struct MPT3SAS_ADAPTER *ioc)
   247	{
   248		unsigned long	 flags;
   249	
   250		if (ioc->fault_reset_work_q)
   251			return;
   252	
   253		/* initialize fault polling */
   254	
   255		INIT_DELAYED_WORK(&ioc->fault_reset_work, _base_fault_reset_work);
   256		snprintf(ioc->fault_reset_work_q_name,
 > 257		    sizeof(ioc->fault_reset_work_q_name), "poll_%s%d_status",
   258		    ioc->driver_name, ioc->id);
   259		ioc->fault_reset_work_q =
   260			create_singlethread_workqueue(ioc->fault_reset_work_q_name);
   261		if (!ioc->fault_reset_work_q) {
   262			pr_err(MPT3SAS_FMT "%s: failed (line=%d)\n",
   263			    ioc->name, __func__, __LINE__);
   264				return;
   265		}
   266		spin_lock_irqsave(&ioc->ioc_reset_in_progress_lock, flags);
   267		if (ioc->fault_reset_work_q)
   268			queue_delayed_work(ioc->fault_reset_work_q,
   269			    &ioc->fault_reset_work,
   270			    msecs_to_jiffies(FAULT_POLLING_INTERVAL));
   271		spin_unlock_irqrestore(&ioc->ioc_reset_in_progress_lock, flags);
   272	}
   273	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
