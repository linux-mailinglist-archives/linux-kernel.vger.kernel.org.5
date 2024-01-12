Return-Path: <linux-kernel+bounces-24792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 545B182C2A2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 16:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47CEBB239A1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 15:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28486EB70;
	Fri, 12 Jan 2024 15:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oBvr6vkO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669CE6EB49
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 15:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705072661; x=1736608661;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=D9C510WNU5d4w7UxKVNoZXKZjwNy6NLOkMCSWBm+IHk=;
  b=oBvr6vkODJI1sfQGjOJHBezT5VqvXRy3c3P1HnEOjjO4QHt7NSQKSXeZ
   AN2U6ajWYwag62MWtEYY/TDkJZMpJyIscPVAxLzZZo4UjjziFAnBWOtqN
   X9oU2NbiasVlp7Yypvzdnb0/SU37GvEK3wKTu7TSQAZikkKU8JYpRvTNw
   pqE0HOO10UKahic269AtvvthGjaT+x03gL2a4zRZ3FqYJSOdPPmQsC0uB
   rfffevVWV3QGoF0k6FOjbv8y4JvQWJpxQ330+i/tLZJ1RIiamGCDywGYy
   criCjc7hVcePHVEIrw52174uq4J8+Rr4vgHVbxzmATf02yeGpZ2YmH7Wv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="6557020"
X-IronPort-AV: E=Sophos;i="6.04,189,1695711600"; 
   d="scan'208";a="6557020"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 07:17:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="786372788"
X-IronPort-AV: E=Sophos;i="6.04,189,1695711600"; 
   d="scan'208";a="786372788"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 12 Jan 2024 07:17:39 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rOJHt-0009ba-0M;
	Fri, 12 Jan 2024 15:17:37 +0000
Date: Fri, 12 Jan 2024 23:16:51 +0800
From: kernel test robot <lkp@intel.com>
To: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: drivers/scsi/mpt3sas/mpt3sas_base.c:3135:49: warning: '-mq-poll'
 directive output may be truncated writing 8 bytes into a region of size
 between 6 and 31
Message-ID: <202401122336.ZuzNmzYi-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   70d201a40823acba23899342d62bc2644051ad2e
commit: 432bc7caef4eaacc1101ee2569bb870bdfeed7ce scsi: mpt3sas: Add io_uring iopoll support
date:   2 years, 5 months ago
config: x86_64-randconfig-002-20240105 (https://download.01.org/0day-ci/archive/20240112/202401122336.ZuzNmzYi-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240112/202401122336.ZuzNmzYi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401122336.ZuzNmzYi-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/scsi/mpt3sas/mpt3sas_base.c: In function '_base_request_irq':
   drivers/scsi/mpt3sas/mpt3sas_base.c:3144:54: warning: '%d' directive output may be truncated writing between 1 and 3 bytes into a region of size between 1 and 26 [-Wformat-truncation=]
    3144 |   snprintf(reply_q->name, MPT_NAME_LENGTH, "%s%d-msix%d",
         |                                                      ^~
   drivers/scsi/mpt3sas/mpt3sas_base.c:3144:44: note: directive argument in the range [0, 255]
    3144 |   snprintf(reply_q->name, MPT_NAME_LENGTH, "%s%d-msix%d",
         |                                            ^~~~~~~~~~~~~
   drivers/scsi/mpt3sas/mpt3sas_base.c:3144:3: note: 'snprintf' output between 8 and 35 bytes into a destination of size 32
    3144 |   snprintf(reply_q->name, MPT_NAME_LENGTH, "%s%d-msix%d",
         |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    3145 |       ioc->driver_name, ioc->id, index);
         |       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/scsi/mpt3sas/mpt3sas_base.c:3135:49: warning: '-mq-poll' directive output may be truncated writing 8 bytes into a region of size between 6 and 31 [-Wformat-truncation=]
    3135 |   snprintf(reply_q->name, MPT_NAME_LENGTH, "%s%d-mq-poll%d",
         |                                                 ^~~~~~~~
   drivers/scsi/mpt3sas/mpt3sas_base.c:3135:44: note: directive argument in the range [-255, 255]
    3135 |   snprintf(reply_q->name, MPT_NAME_LENGTH, "%s%d-mq-poll%d",
         |                                            ^~~~~~~~~~~~~~~~
   drivers/scsi/mpt3sas/mpt3sas_base.c:3135:3: note: 'snprintf' output between 11 and 39 bytes into a destination of size 32
    3135 |   snprintf(reply_q->name, MPT_NAME_LENGTH, "%s%d-mq-poll%d",
         |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    3136 |       ioc->driver_name, ioc->id, qid);
         |       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/mpt3sas/mpt3sas_base.c: In function 'mpt3sas_base_start_watchdog':
   drivers/scsi/mpt3sas/mpt3sas_base.c:831:50: warning: '%s' directive output may be truncated writing up to 23 bytes into a region of size 15 [-Wformat-truncation=]
     831 |      sizeof(ioc->fault_reset_work_q_name), "poll_%s%d_status",
         |                                                  ^~
   drivers/scsi/mpt3sas/mpt3sas_base.c:831:44: note: directive argument in the range [0, 255]
     831 |      sizeof(ioc->fault_reset_work_q_name), "poll_%s%d_status",
         |                                            ^~~~~~~~~~~~~~~~~~
   drivers/scsi/mpt3sas/mpt3sas_base.c:830:2: note: 'snprintf' output between 14 and 39 bytes into a destination of size 20
     830 |  snprintf(ioc->fault_reset_work_q_name,
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     831 |      sizeof(ioc->fault_reset_work_q_name), "poll_%s%d_status",
         |      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     832 |      ioc->driver_name, ioc->id);
         |      ~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +3135 drivers/scsi/mpt3sas/mpt3sas_base.c

  3107	
  3108	/**
  3109	 * _base_request_irq - request irq
  3110	 * @ioc: per adapter object
  3111	 * @index: msix index into vector table
  3112	 *
  3113	 * Inserting respective reply_queue into the list.
  3114	 */
  3115	static int
  3116	_base_request_irq(struct MPT3SAS_ADAPTER *ioc, u8 index)
  3117	{
  3118		struct pci_dev *pdev = ioc->pdev;
  3119		struct adapter_reply_queue *reply_q;
  3120		int r, qid;
  3121	
  3122		reply_q =  kzalloc(sizeof(struct adapter_reply_queue), GFP_KERNEL);
  3123		if (!reply_q) {
  3124			ioc_err(ioc, "unable to allocate memory %zu!\n",
  3125				sizeof(struct adapter_reply_queue));
  3126			return -ENOMEM;
  3127		}
  3128		reply_q->ioc = ioc;
  3129		reply_q->msix_index = index;
  3130	
  3131		atomic_set(&reply_q->busy, 0);
  3132	
  3133		if (index >= ioc->iopoll_q_start_index) {
  3134			qid = index - ioc->iopoll_q_start_index;
> 3135			snprintf(reply_q->name, MPT_NAME_LENGTH, "%s%d-mq-poll%d",
  3136			    ioc->driver_name, ioc->id, qid);
  3137			reply_q->is_iouring_poll_q = 1;
  3138			ioc->io_uring_poll_queues[qid].reply_q = reply_q;
  3139			goto out;
  3140		}
  3141	
  3142	
  3143		if (ioc->msix_enable)
  3144			snprintf(reply_q->name, MPT_NAME_LENGTH, "%s%d-msix%d",
  3145			    ioc->driver_name, ioc->id, index);
  3146		else
  3147			snprintf(reply_q->name, MPT_NAME_LENGTH, "%s%d",
  3148			    ioc->driver_name, ioc->id);
  3149		r = request_irq(pci_irq_vector(pdev, index), _base_interrupt,
  3150				IRQF_SHARED, reply_q->name, reply_q);
  3151		if (r) {
  3152			pr_err("%s: unable to allocate interrupt %d!\n",
  3153			       reply_q->name, pci_irq_vector(pdev, index));
  3154			kfree(reply_q);
  3155			return -EBUSY;
  3156		}
  3157	out:
  3158		INIT_LIST_HEAD(&reply_q->list);
  3159		list_add_tail(&reply_q->list, &ioc->reply_queue_list);
  3160		return 0;
  3161	}
  3162	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

