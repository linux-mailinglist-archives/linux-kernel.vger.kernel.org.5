Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A827E3027
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 23:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbjKFWtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 17:49:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233217AbjKFWti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 17:49:38 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB159D6E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 14:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699310975; x=1730846975;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EMLgOROeCF2utULDNO+8pR4x0ROBK/cUmYyQmhkf/eA=;
  b=iiR6FsOykRCEESwKi5NSyymdg8wKJg/sIctGx4KdLnDYjhvdaABDzC/s
   KZGM7RAUN46P/rqVyr1jsJSqf55+5E0YeJAk6isNYGLjefpk6SHypaoDj
   FTaSBJPZpqDKrzNh3J29351dN4eLx0gHKBYubCDmV6uPjzwKvpdZYBcjn
   Ln2yXqm2M0wnDXwwSHAAkHmrFf5R/xRH/i0GgHALEc5gTWNUQ7LbV5mn0
   4F+WSVhuOVqQwSqk5aAo35KtFbSv6L3vLPNeFrKrF/+3G1VcSMDzDLoT7
   OiOGRlAnOt87B/N67Cv59uRkm89r+2qvbOzBCDvlcZI0lNexs/ACEws/k
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="8019291"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="8019291"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 14:49:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="935934774"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="935934774"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 06 Nov 2023 14:49:32 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r08PS-0006mi-0X;
        Mon, 06 Nov 2023 22:49:30 +0000
Date:   Tue, 7 Nov 2023 06:47:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sreekanth Reddy <sreekanth.reddy@avagotech.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>
Subject: drivers/scsi/mpt3sas/mpt3sas_base.c:1648:61: warning: '%d' directive
 output may be truncated writing between 1 and 3 bytes into a region of size
 between 1 and 32
Message-ID: <202311070619.k72DqC4f-lkp@intel.com>
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

Hi Sreekanth,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d2f51b3516dade79269ff45eae2a7668ae711b25
commit: d357e84d65dfcdb502fdb1aaab2873a82a828db5 mpt3sas: Define 'hba_mpi_version_belonged' IOC variable
date:   8 years ago
config: x86_64-buildonly-randconfig-006-20230911 (https://download.01.org/0day-ci/archive/20231107/202311070619.k72DqC4f-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231107/202311070619.k72DqC4f-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311070619.k72DqC4f-lkp@intel.com/

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
   drivers/scsi/mpt3sas/mpt3sas_base.c: In function '_base_assign_reply_queues':
   drivers/scsi/mpt3sas/mpt3sas_base.c:1713:57: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
    1713 |                             ioc->name, reply_q->vector));
         |                                                         ^
   drivers/scsi/mpt3sas/mpt3sas_base.c: At top level:
   drivers/scsi/mpt3sas/mpt3sas_base.c:1820:1: warning: no previous declaration for 'mpt3sas_base_unmap_resources' [-Wmissing-declarations]
    1820 | mpt3sas_base_unmap_resources(struct MPT3SAS_ADAPTER *ioc)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/mpt3sas/mpt3sas_base.c: In function '_base_display_ioc_capabilities':
   drivers/scsi/mpt3sas/mpt3sas_base.c:2477:36: warning: pointer targets in passing argument 2 of 'strncpy' differ in signedness [-Wpointer-sign]
    2477 |         strncpy(desc, ioc->manu_pg0.ChipName, 16);
         |                       ~~~~~~~~~~~~~^~~~~~~~~
         |                                    |
         |                                    U8 * {aka unsigned char *}
   In file included from include/linux/bitmap.h:8,
                    from include/linux/cpumask.h:11,
                    from arch/x86/include/asm/cpumask.h:4,
                    from arch/x86/include/asm/msr.h:10,
                    from arch/x86/include/asm/processor.h:20,
                    from arch/x86/include/asm/thread_info.h:52,
                    from include/linux/thread_info.h:54,
                    from arch/x86/include/asm/preempt.h:6,
                    from include/linux/preempt.h:64,
                    from include/linux/spinlock.h:50,
                    from include/linux/seqlock.h:35,
                    from include/linux/time.h:5,
                    from include/linux/stat.h:18,
                    from include/linux/module.h:10:
   include/linux/string.h:23:30: note: expected 'const char *' but argument is of type 'U8 *' {aka 'unsigned char *'}
      23 | extern char * strncpy(char *,const char *, __kernel_size_t);
         |                              ^~~~~~~~~~~~
   drivers/scsi/mpt3sas/mpt3sas_base.c: In function '_base_handshake_req_reply_wait':
   drivers/scsi/mpt3sas/mpt3sas_base.c:3503:13: warning: variable 'dummy' set but not used [-Wunused-but-set-variable]
    3503 |         u16 dummy;
         |             ^~~~~
   drivers/scsi/mpt3sas/mpt3sas_base.c: In function 'mpt3sas_base_sas_iounit_control':
   drivers/scsi/mpt3sas/mpt3sas_base.c:3628:23: warning: variable 'timeleft' set but not used [-Wunused-but-set-variable]
    3628 |         unsigned long timeleft;
         |                       ^~~~~~~~
   drivers/scsi/mpt3sas/mpt3sas_base.c: In function 'mpt3sas_base_scsi_enclosure_processor':
   drivers/scsi/mpt3sas/mpt3sas_base.c:3732:23: warning: variable 'timeleft' set but not used [-Wunused-but-set-variable]
    3732 |         unsigned long timeleft;
         |                       ^~~~~~~~
   drivers/scsi/mpt3sas/mpt3sas_base.c: In function '_base_send_port_enable':
   drivers/scsi/mpt3sas/mpt3sas_base.c:4174:23: warning: variable 'timeleft' set but not used [-Wunused-but-set-variable]
    4174 |         unsigned long timeleft;
         |                       ^~~~~~~~
   drivers/scsi/mpt3sas/mpt3sas_base.c: In function '_base_event_notification':
   drivers/scsi/mpt3sas/mpt3sas_base.c:4399:42: warning: suggest braces around empty body in an 'else' statement [-Wempty-body]
    4399 |                     ioc->name, __func__));
         |                                          ^
   drivers/scsi/mpt3sas/mpt3sas_base.c:4355:23: warning: variable 'timeleft' set but not used [-Wunused-but-set-variable]
    4355 |         unsigned long timeleft;
         |                       ^~~~~~~~
   drivers/scsi/mpt3sas/mpt3sas_base.c: In function '_base_request_irq':
>> drivers/scsi/mpt3sas/mpt3sas_base.c:1648:61: warning: '%d' directive output may be truncated writing between 1 and 3 bytes into a region of size between 1 and 32 [-Wformat-truncation=]
    1648 |                 snprintf(reply_q->name, MPT_NAME_LENGTH, "%s%d",
         |                                                             ^~
   drivers/scsi/mpt3sas/mpt3sas_base.c:1648:58: note: directive argument in the range [0, 255]
    1648 |                 snprintf(reply_q->name, MPT_NAME_LENGTH, "%s%d",
         |                                                          ^~~~~~
   drivers/scsi/mpt3sas/mpt3sas_base.c:1648:17: note: 'snprintf' output between 2 and 35 bytes into a destination of size 32
    1648 |                 snprintf(reply_q->name, MPT_NAME_LENGTH, "%s%d",
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1649 |                     driver_name, ioc->id);
         |                     ~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/mpt3sas/mpt3sas_base.c:1645:61: warning: '%d' directive output may be truncated writing between 1 and 3 bytes into a region of size between 1 and 32 [-Wformat-truncation=]
    1645 |                 snprintf(reply_q->name, MPT_NAME_LENGTH, "%s%d-msix%d",
         |                                                             ^~
   drivers/scsi/mpt3sas/mpt3sas_base.c:1645:58: note: directive argument in the range [0, 255]
    1645 |                 snprintf(reply_q->name, MPT_NAME_LENGTH, "%s%d-msix%d",
         |                                                          ^~~~~~~~~~~~~
   drivers/scsi/mpt3sas/mpt3sas_base.c:1645:58: note: directive argument in the range [0, 254]
   drivers/scsi/mpt3sas/mpt3sas_base.c:1645:17: note: 'snprintf' output between 8 and 43 bytes into a destination of size 32
    1645 |                 snprintf(reply_q->name, MPT_NAME_LENGTH, "%s%d-msix%d",
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1646 |                     driver_name, ioc->id, index);
         |                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +1648 drivers/scsi/mpt3sas/mpt3sas_base.c

f92363d1235949 Sreekanth Reddy 2012-11-30  1614  
f92363d1235949 Sreekanth Reddy 2012-11-30  1615  /**
f92363d1235949 Sreekanth Reddy 2012-11-30  1616   * _base_request_irq - request irq
f92363d1235949 Sreekanth Reddy 2012-11-30  1617   * @ioc: per adapter object
f92363d1235949 Sreekanth Reddy 2012-11-30  1618   * @index: msix index into vector table
f92363d1235949 Sreekanth Reddy 2012-11-30  1619   * @vector: irq vector
f92363d1235949 Sreekanth Reddy 2012-11-30  1620   *
f92363d1235949 Sreekanth Reddy 2012-11-30  1621   * Inserting respective reply_queue into the list.
f92363d1235949 Sreekanth Reddy 2012-11-30  1622   */
f92363d1235949 Sreekanth Reddy 2012-11-30  1623  static int
f92363d1235949 Sreekanth Reddy 2012-11-30  1624  _base_request_irq(struct MPT3SAS_ADAPTER *ioc, u8 index, u32 vector)
f92363d1235949 Sreekanth Reddy 2012-11-30  1625  {
f92363d1235949 Sreekanth Reddy 2012-11-30  1626  	struct adapter_reply_queue *reply_q;
f92363d1235949 Sreekanth Reddy 2012-11-30  1627  	int r;
f92363d1235949 Sreekanth Reddy 2012-11-30  1628  
f92363d1235949 Sreekanth Reddy 2012-11-30  1629  	reply_q =  kzalloc(sizeof(struct adapter_reply_queue), GFP_KERNEL);
f92363d1235949 Sreekanth Reddy 2012-11-30  1630  	if (!reply_q) {
f92363d1235949 Sreekanth Reddy 2012-11-30  1631  		pr_err(MPT3SAS_FMT "unable to allocate memory %d!\n",
f92363d1235949 Sreekanth Reddy 2012-11-30  1632  		    ioc->name, (int)sizeof(struct adapter_reply_queue));
f92363d1235949 Sreekanth Reddy 2012-11-30  1633  		return -ENOMEM;
f92363d1235949 Sreekanth Reddy 2012-11-30  1634  	}
f92363d1235949 Sreekanth Reddy 2012-11-30  1635  	reply_q->ioc = ioc;
f92363d1235949 Sreekanth Reddy 2012-11-30  1636  	reply_q->msix_index = index;
f92363d1235949 Sreekanth Reddy 2012-11-30  1637  	reply_q->vector = vector;
14b3114d940cdc Sreekanth Reddy 2015-01-12  1638  
14b3114d940cdc Sreekanth Reddy 2015-01-12  1639  	if (!alloc_cpumask_var(&reply_q->affinity_hint, GFP_KERNEL))
14b3114d940cdc Sreekanth Reddy 2015-01-12  1640  		return -ENOMEM;
14b3114d940cdc Sreekanth Reddy 2015-01-12  1641  	cpumask_clear(reply_q->affinity_hint);
14b3114d940cdc Sreekanth Reddy 2015-01-12  1642  
f92363d1235949 Sreekanth Reddy 2012-11-30  1643  	atomic_set(&reply_q->busy, 0);
f92363d1235949 Sreekanth Reddy 2012-11-30  1644  	if (ioc->msix_enable)
f92363d1235949 Sreekanth Reddy 2012-11-30  1645  		snprintf(reply_q->name, MPT_NAME_LENGTH, "%s%d-msix%d",
d357e84d65dfcd Sreekanth Reddy 2015-11-11  1646  		    driver_name, ioc->id, index);
f92363d1235949 Sreekanth Reddy 2012-11-30  1647  	else
f92363d1235949 Sreekanth Reddy 2012-11-30 @1648  		snprintf(reply_q->name, MPT_NAME_LENGTH, "%s%d",
d357e84d65dfcd Sreekanth Reddy 2015-11-11  1649  		    driver_name, ioc->id);
f92363d1235949 Sreekanth Reddy 2012-11-30  1650  	r = request_irq(vector, _base_interrupt, IRQF_SHARED, reply_q->name,
f92363d1235949 Sreekanth Reddy 2012-11-30  1651  	    reply_q);
f92363d1235949 Sreekanth Reddy 2012-11-30  1652  	if (r) {
f92363d1235949 Sreekanth Reddy 2012-11-30  1653  		pr_err(MPT3SAS_FMT "unable to allocate interrupt %d!\n",
f92363d1235949 Sreekanth Reddy 2012-11-30  1654  		    reply_q->name, vector);
f92363d1235949 Sreekanth Reddy 2012-11-30  1655  		kfree(reply_q);
f92363d1235949 Sreekanth Reddy 2012-11-30  1656  		return -EBUSY;
f92363d1235949 Sreekanth Reddy 2012-11-30  1657  	}
f92363d1235949 Sreekanth Reddy 2012-11-30  1658  
f92363d1235949 Sreekanth Reddy 2012-11-30  1659  	INIT_LIST_HEAD(&reply_q->list);
f92363d1235949 Sreekanth Reddy 2012-11-30  1660  	list_add_tail(&reply_q->list, &ioc->reply_queue_list);
f92363d1235949 Sreekanth Reddy 2012-11-30  1661  	return 0;
f92363d1235949 Sreekanth Reddy 2012-11-30  1662  }
f92363d1235949 Sreekanth Reddy 2012-11-30  1663  

:::::: The code at line 1648 was first introduced by commit
:::::: f92363d12359498f9a9960511de1a550f0ec41c2 [SCSI] mpt3sas: add new driver supporting 12GB SAS

:::::: TO: Sreekanth Reddy <Sreekanth.Reddy@lsi.com>
:::::: CC: James Bottomley <JBottomley@Parallels.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
