Return-Path: <linux-kernel+bounces-21672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1688292A0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 04:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB082289483
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 03:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C833234;
	Wed, 10 Jan 2024 03:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XV6ANEau"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCE6210B
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 03:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704855982; x=1736391982;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZewTevJw56ig0XC0uD4jZoysKT9xWByRTaoA4LMz9rg=;
  b=XV6ANEauco2YgQqr8zfOx1jHeM/5aOyxpybhu79Roo4a/aTm17UVJ1Au
   5M7ubTxQEGwkmHftCPNtTcPQTp/fKAPfVG9yD3aJ1VJTcrNKuRNzWfKqN
   JvOSqKc9NKNBhJbnDvOn0b78/UfuooysYutJm3MViwi4gU35RrqEUj1BH
   R4saLu4+tPeW5fqb7pINYQQmLliGogb9MjCL4AdW9j5LNrTySQOeu0/rX
   F6ertpUTa7Gxk3RMQ6sATum6AmpYUfLIwjc/Ea4QkXbfhuD+muzibHcRz
   vXF34w2N3pbrFaKQbgljOLMTGpT0+14MrwJibQ8uwhHGe/DBUZe+cORWt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="429579934"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="429579934"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 19:06:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="816196509"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="816196509"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 09 Jan 2024 19:06:18 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rNOv2-0006WU-1J;
	Wed, 10 Jan 2024 03:06:16 +0000
Date: Wed, 10 Jan 2024 11:06:04 +0800
From: kernel test robot <lkp@intel.com>
To: Brian King <brking@linux.vnet.ibm.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	John Garry <john.g.garry@oracle.com>
Subject: drivers/scsi/ipr.c:5430:6: warning: variable 'ioasc' set but not used
Message-ID: <202401101004.fcxlPdWI-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Brian,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ab27740f76654ed58dd32ac0ba0031c18a6dea3b
commit: 65a15d6560dff065339f6cac91de4beded60fe3f scsi: ipr: Remove SATA support
date:   9 months ago
config: i386-buildonly-randconfig-002-20240107 (https://download.01.org/0day-ci/archive/20240110/202401101004.fcxlPdWI-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240110/202401101004.fcxlPdWI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401101004.fcxlPdWI-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/scsi/ipr.c:1104:15: warning: variable 'proto' set but not used [-Wunused-but-set-variable]
    1104 |         unsigned int proto;
         |                      ^
   drivers/scsi/ipr.c:1261:15: warning: variable 'proto' set but not used [-Wunused-but-set-variable]
    1261 |         unsigned int proto;
         |                      ^
   drivers/scsi/ipr.c:4417:29: warning: variable 'res' set but not used [-Wunused-but-set-variable]
    4417 |         struct ipr_resource_entry *res;
         |                                    ^
>> drivers/scsi/ipr.c:5430:6: warning: variable 'ioasc' set but not used [-Wunused-but-set-variable]
    5430 |         u32 ioasc;
         |             ^
   4 warnings generated.


vim +/ioasc +5430 drivers/scsi/ipr.c

3feeb89d40cc0ab Wayne Boyer                 2009-10-20  5426  
b53d124a154d002 wenxiong@linux.vnet.ibm.com 2013-01-11  5427  static int ipr_process_hrrq(struct ipr_hrr_queue *hrr_queue, int budget,
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5428  						struct list_head *doneq)
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5429  {
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11 @5430  	u32 ioasc;
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5431  	u16 cmd_index;
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5432  	struct ipr_cmnd *ipr_cmd;
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5433  	struct ipr_ioa_cfg *ioa_cfg = hrr_queue->ioa_cfg;
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5434  	int num_hrrq = 0;
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5435  
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5436  	/* If interrupts are disabled, ignore the interrupt */
56d6aa33d3f6847 wenxiong@linux.vnet.ibm.com 2013-01-11  5437  	if (!hrr_queue->allow_interrupts)
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5438  		return 0;
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5439  
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5440  	while ((be32_to_cpu(*hrr_queue->hrrq_curr) & IPR_HRRQ_TOGGLE_BIT) ==
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5441  	       hrr_queue->toggle_bit) {
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5442  
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5443  		cmd_index = (be32_to_cpu(*hrr_queue->hrrq_curr) &
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5444  			     IPR_HRRQ_REQ_RESP_HANDLE_MASK) >>
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5445  			     IPR_HRRQ_REQ_RESP_HANDLE_SHIFT;
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5446  
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5447  		if (unlikely(cmd_index > hrr_queue->max_cmd_id ||
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5448  			     cmd_index < hrr_queue->min_cmd_id)) {
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5449  			ipr_isr_eh(ioa_cfg,
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5450  				"Invalid response handle from IOA: ",
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5451  				cmd_index);
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5452  			break;
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5453  		}
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5454  
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5455  		ipr_cmd = ioa_cfg->ipr_cmnd_list[cmd_index];
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5456  		ioasc = be32_to_cpu(ipr_cmd->s.ioasa.hdr.ioasc);
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5457  
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5458  		ipr_trc_hook(ipr_cmd, IPR_TRACE_FINISH, ioasc);
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5459  
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5460  		list_move_tail(&ipr_cmd->queue, doneq);
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5461  
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5462  		if (hrr_queue->hrrq_curr < hrr_queue->hrrq_end) {
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5463  			hrr_queue->hrrq_curr++;
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5464  		} else {
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5465  			hrr_queue->hrrq_curr = hrr_queue->hrrq_start;
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5466  			hrr_queue->toggle_bit ^= 1u;
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5467  		}
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5468  		num_hrrq++;
b53d124a154d002 wenxiong@linux.vnet.ibm.com 2013-01-11  5469  		if (budget > 0 && num_hrrq >= budget)
b53d124a154d002 wenxiong@linux.vnet.ibm.com 2013-01-11  5470  			break;
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5471  	}
b53d124a154d002 wenxiong@linux.vnet.ibm.com 2013-01-11  5472  
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5473  	return num_hrrq;
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5474  }
b53d124a154d002 wenxiong@linux.vnet.ibm.com 2013-01-11  5475  

:::::: The code at line 5430 was first introduced by commit
:::::: 05a6538a9a204999e0c0f7faee00b81b334f4fc7 [SCSI] ipr: Add support for MSI-X and distributed completion

:::::: TO: wenxiong@linux.vnet.ibm.com <wenxiong@linux.vnet.ibm.com>
:::::: CC: James Bottomley <JBottomley@Parallels.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

