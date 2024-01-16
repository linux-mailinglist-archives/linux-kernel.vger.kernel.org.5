Return-Path: <linux-kernel+bounces-28273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 487E982FC62
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC3011F29527
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1F12562B;
	Tue, 16 Jan 2024 20:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g7UXrsvO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D9D25625
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 20:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705438536; cv=none; b=TsxqaBG5gsz7npPA6pvtG1kmHQ1hLIVOUthj35+Hj60LBWL9pSceTMdEWTa+2cCAFy+rV60QYSZKmfIu0SmCUt0QdpNuQJnHBFEFnanEtNlQwI5PC0XoK5Yr3+sgbRB87joR3V8MOoOYnuOTXr7PHXfVTNwiZyx07lObG/Nvv+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705438536; c=relaxed/simple;
	bh=ggdGREvMxKSy4YEN8yzW1S78sK8hyZ/yugRdPc8/fs8=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition;
	b=V52mvZIqK2eSgt308iWOl793oG3CVhNbOnMQ0aG76BoBSQXZZ182Bxh1B17ohGhts62HRRG64x9O64gQV5XvKPk9kyPNByyU/O00Z7LmVxSlXTBxZBlfcNdjffuGV++/KVApp/3hHlszHnjTyiF0eloKEl8vVy/AOhAjjqIxG8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g7UXrsvO; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705438533; x=1736974533;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ggdGREvMxKSy4YEN8yzW1S78sK8hyZ/yugRdPc8/fs8=;
  b=g7UXrsvOb5LYeabqmnz/8Hivtg3EjCjcSE12/HzvOnk7+uipCLo8rT55
   BPQrOE3k1miMgRHnKmMY7TCGLBKQvedxWJZ9UI7vlySKSdVM+kjHJwXwX
   SGggFPLDUHv59o+IXypAK3RpuQ6/CS/tfdEns9A7s1JoyDJjlcM0R3UNN
   7608pIKfSdQHCJ/1+P7+Ikx7lQ2dX6gxt+gGu0Ww+yrkeTjv0JuDFT5Ym
   RYJscrFhYCItIIav/Mgmjt8MryFm278WK4Kgc8fxFMymRRKe+N4Nrcu1W
   RQfdw9IZAdD/715FIWuKolyDxOsNzhAVe3vbg1tw/4vw5xdCT1fSZDrnl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="6745032"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="6745032"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 12:55:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="907506229"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="907506229"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 16 Jan 2024 12:55:30 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rPqT2-0001Eg-0u;
	Tue, 16 Jan 2024 20:55:28 +0000
Date: Wed, 17 Jan 2024 04:55:01 +0800
From: kernel test robot <lkp@intel.com>
To: Kees Cook <keescook@chromium.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Nathan Chancellor <natechancellor@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: drivers/scsi/mpt3sas/mpt3sas_base.c:2951:54: warning: '%d' directive
 output may be truncated writing between 1 and 3 bytes into a region of size
 between 1 and 26
Message-ID: <202401170432.bbjOvVyf-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   052d534373b7ed33712a63d5e17b2b6cdbce84fd
commit: cdf8a76fda4ae3b53c5a09e5a8c79e27b7b65d68 ubsan: move cc-option tests into Kconfig
date:   3 years, 1 month ago
config: x86_64-randconfig-002-20240105 (https://download.01.org/0day-ci/archive/20240117/202401170432.bbjOvVyf-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240117/202401170432.bbjOvVyf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401170432.bbjOvVyf-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/scsi/mpt3sas/mpt3sas_base.c: In function '_base_request_irq':
>> drivers/scsi/mpt3sas/mpt3sas_base.c:2951:54: warning: '%d' directive output may be truncated writing between 1 and 3 bytes into a region of size between 1 and 26 [-Wformat-truncation=]
    2951 |   snprintf(reply_q->name, MPT_NAME_LENGTH, "%s%d-msix%d",
         |                                                      ^~
   drivers/scsi/mpt3sas/mpt3sas_base.c:2951:44: note: directive argument in the range [0, 255]
    2951 |   snprintf(reply_q->name, MPT_NAME_LENGTH, "%s%d-msix%d",
         |                                            ^~~~~~~~~~~~~
   drivers/scsi/mpt3sas/mpt3sas_base.c:2951:3: note: 'snprintf' output between 8 and 35 bytes into a destination of size 32
    2951 |   snprintf(reply_q->name, MPT_NAME_LENGTH, "%s%d-msix%d",
         |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    2952 |       ioc->driver_name, ioc->id, index);
         |       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/mpt3sas/mpt3sas_base.c: In function 'mpt3sas_base_start_watchdog':
   drivers/scsi/mpt3sas/mpt3sas_base.c:751:50: warning: '%s' directive output may be truncated writing up to 23 bytes into a region of size 15 [-Wformat-truncation=]
     751 |      sizeof(ioc->fault_reset_work_q_name), "poll_%s%d_status",
         |                                                  ^~
   drivers/scsi/mpt3sas/mpt3sas_base.c:751:44: note: directive argument in the range [0, 255]
     751 |      sizeof(ioc->fault_reset_work_q_name), "poll_%s%d_status",
         |                                            ^~~~~~~~~~~~~~~~~~
   drivers/scsi/mpt3sas/mpt3sas_base.c:750:2: note: 'snprintf' output between 14 and 39 bytes into a destination of size 20
     750 |  snprintf(ioc->fault_reset_work_q_name,
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     751 |      sizeof(ioc->fault_reset_work_q_name), "poll_%s%d_status",
         |      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     752 |      ioc->driver_name, ioc->id);
         |      ~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +2951 drivers/scsi/mpt3sas/mpt3sas_base.c

f92363d12359498 Sreekanth Reddy          2012-11-30  2925  
f92363d12359498 Sreekanth Reddy          2012-11-30  2926  /**
f92363d12359498 Sreekanth Reddy          2012-11-30  2927   * _base_request_irq - request irq
f92363d12359498 Sreekanth Reddy          2012-11-30  2928   * @ioc: per adapter object
f92363d12359498 Sreekanth Reddy          2012-11-30  2929   * @index: msix index into vector table
f92363d12359498 Sreekanth Reddy          2012-11-30  2930   *
f92363d12359498 Sreekanth Reddy          2012-11-30  2931   * Inserting respective reply_queue into the list.
f92363d12359498 Sreekanth Reddy          2012-11-30  2932   */
f92363d12359498 Sreekanth Reddy          2012-11-30  2933  static int
1d55abc0e98a0bf Hannes Reinecke          2017-02-22  2934  _base_request_irq(struct MPT3SAS_ADAPTER *ioc, u8 index)
f92363d12359498 Sreekanth Reddy          2012-11-30  2935  {
1d55abc0e98a0bf Hannes Reinecke          2017-02-22  2936  	struct pci_dev *pdev = ioc->pdev;
f92363d12359498 Sreekanth Reddy          2012-11-30  2937  	struct adapter_reply_queue *reply_q;
f92363d12359498 Sreekanth Reddy          2012-11-30  2938  	int r;
f92363d12359498 Sreekanth Reddy          2012-11-30  2939  
f92363d12359498 Sreekanth Reddy          2012-11-30  2940  	reply_q =  kzalloc(sizeof(struct adapter_reply_queue), GFP_KERNEL);
f92363d12359498 Sreekanth Reddy          2012-11-30  2941  	if (!reply_q) {
919d8a3f3fef991 Joe Perches              2018-09-17  2942  		ioc_err(ioc, "unable to allocate memory %zu!\n",
919d8a3f3fef991 Joe Perches              2018-09-17  2943  			sizeof(struct adapter_reply_queue));
f92363d12359498 Sreekanth Reddy          2012-11-30  2944  		return -ENOMEM;
f92363d12359498 Sreekanth Reddy          2012-11-30  2945  	}
f92363d12359498 Sreekanth Reddy          2012-11-30  2946  	reply_q->ioc = ioc;
f92363d12359498 Sreekanth Reddy          2012-11-30  2947  	reply_q->msix_index = index;
14b3114d940cdc4 Sreekanth Reddy          2015-01-12  2948  
f92363d12359498 Sreekanth Reddy          2012-11-30  2949  	atomic_set(&reply_q->busy, 0);
f92363d12359498 Sreekanth Reddy          2012-11-30  2950  	if (ioc->msix_enable)
f92363d12359498 Sreekanth Reddy          2012-11-30 @2951  		snprintf(reply_q->name, MPT_NAME_LENGTH, "%s%d-msix%d",
c84b06a48c4d8ac Sreekanth Reddy          2015-11-11  2952  		    ioc->driver_name, ioc->id, index);
f92363d12359498 Sreekanth Reddy          2012-11-30  2953  	else
f92363d12359498 Sreekanth Reddy          2012-11-30  2954  		snprintf(reply_q->name, MPT_NAME_LENGTH, "%s%d",
c84b06a48c4d8ac Sreekanth Reddy          2015-11-11  2955  		    ioc->driver_name, ioc->id);
1d55abc0e98a0bf Hannes Reinecke          2017-02-22  2956  	r = request_irq(pci_irq_vector(pdev, index), _base_interrupt,
1d55abc0e98a0bf Hannes Reinecke          2017-02-22  2957  			IRQF_SHARED, reply_q->name, reply_q);
f92363d12359498 Sreekanth Reddy          2012-11-30  2958  	if (r) {
fc7d510ec4c8ff8 Joe Perches              2018-09-17  2959  		pr_err("%s: unable to allocate interrupt %d!\n",
1d55abc0e98a0bf Hannes Reinecke          2017-02-22  2960  		       reply_q->name, pci_irq_vector(pdev, index));
da3cec2515f0094 Suganath prabu Subramani 2016-02-11  2961  		kfree(reply_q);
f92363d12359498 Sreekanth Reddy          2012-11-30  2962  		return -EBUSY;
f92363d12359498 Sreekanth Reddy          2012-11-30  2963  	}
f92363d12359498 Sreekanth Reddy          2012-11-30  2964  
f92363d12359498 Sreekanth Reddy          2012-11-30  2965  	INIT_LIST_HEAD(&reply_q->list);
f92363d12359498 Sreekanth Reddy          2012-11-30  2966  	list_add_tail(&reply_q->list, &ioc->reply_queue_list);
f92363d12359498 Sreekanth Reddy          2012-11-30  2967  	return 0;
f92363d12359498 Sreekanth Reddy          2012-11-30  2968  }
f92363d12359498 Sreekanth Reddy          2012-11-30  2969  

:::::: The code at line 2951 was first introduced by commit
:::::: f92363d12359498f9a9960511de1a550f0ec41c2 [SCSI] mpt3sas: add new driver supporting 12GB SAS

:::::: TO: Sreekanth Reddy <Sreekanth.Reddy@lsi.com>
:::::: CC: James Bottomley <JBottomley@Parallels.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

