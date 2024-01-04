Return-Path: <linux-kernel+bounces-16462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 519BA823EE2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 681BB1C21700
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 09:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B1C208D7;
	Thu,  4 Jan 2024 09:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fuSQWVYZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40008208C4
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 09:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704361602; x=1735897602;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zjFzDPZ+I/8lkVMdUy+0kR97ysRI0cnj/ys1pCXJ2PM=;
  b=fuSQWVYZ+Uyl1ab/vAjD8P94QfqxV8Ma/PDecsHNre+ijRv6CxkGRR9F
   NmkGb3HiUNzMaTKLRwZEZkJPOx91BStYsADg8ev9HjsJeybVJZEAmUUUb
   xM3F1EWqQIsBSWkX7QyE9aDZHecp/RrlUCyXYFbAwkQMyRl6Og6fFErFv
   zb6pqr81KehnpzGvthMTF1mFqCny3b8VXMy19VtVwFzdNKPmkBU/L6tz+
   Rp00c1SYux6+ZZBRXT/6uxLXHKR+Rpe3kMNEQ2Fq5huFqPXtsZ2FmtShL
   w/aBHjJ7qOEr3b1jbZ74yqid5wxFcjVN1oKeNIK0oB92ixk5i/dwTaKET
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="394358260"
X-IronPort-AV: E=Sophos;i="6.04,330,1695711600"; 
   d="scan'208";a="394358260"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 01:46:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,330,1695711600"; 
   d="scan'208";a="28720975"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 04 Jan 2024 01:46:40 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rLKJ9-000N8i-2J;
	Thu, 04 Jan 2024 09:46:36 +0000
Date: Thu, 4 Jan 2024 17:46:14 +0800
From: kernel test robot <lkp@intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: drivers/pci/pcie/../pci.h:325:17: sparse: sparse: cast from
 restricted pci_channel_state_t
Message-ID: <202401041727.wUVRqGHn-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ac865f00af293d081356bec56eea90815094a60e
commit: 74ff8864cc842be994853095dba6db48e716400a PCI: hotplug: Allow marking devices as disconnected during bind/unbind
date:   11 months ago
config: mips-randconfig-r036-20230725 (https://download.01.org/0day-ci/archive/20240104/202401041727.wUVRqGHn-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20240104/202401041727.wUVRqGHn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401041727.wUVRqGHn-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/pci/pcie/err.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, ...):
   include/linux/page-flags.h:246:46: sparse: sparse: self-comparison always evaluates to false
   drivers/pci/pcie/err.c: note: in included file:
>> drivers/pci/pcie/../pci.h:325:17: sparse: sparse: cast from restricted pci_channel_state_t
>> drivers/pci/pcie/../pci.h:325:17: sparse: sparse: cast to restricted pci_channel_state_t
   drivers/pci/pcie/../pci.h:328:23: sparse: sparse: cast from restricted pci_channel_state_t
   drivers/pci/pcie/../pci.h:328:23: sparse: sparse: cast from restricted pci_channel_state_t
   drivers/pci/pcie/../pci.h:328:23: sparse: sparse: cast to restricted pci_channel_state_t
   drivers/pci/pcie/../pci.h:332:23: sparse: sparse: cast from restricted pci_channel_state_t
   drivers/pci/pcie/../pci.h:332:23: sparse: sparse: cast from restricted pci_channel_state_t
   drivers/pci/pcie/../pci.h:332:23: sparse: sparse: cast to restricted pci_channel_state_t
>> drivers/pci/pcie/../pci.h:325:17: sparse: sparse: cast to restricted pci_channel_state_t
   drivers/pci/pcie/../pci.h:328:23: sparse: sparse: cast to restricted pci_channel_state_t
   drivers/pci/pcie/../pci.h:332:23: sparse: sparse: cast to restricted pci_channel_state_t

vim +325 drivers/pci/pcie/../pci.h

   306	
   307	/**
   308	 * pci_dev_set_io_state - Set the new error state if possible.
   309	 *
   310	 * @dev: PCI device to set new error_state
   311	 * @new: the state we want dev to be in
   312	 *
   313	 * If the device is experiencing perm_failure, it has to remain in that state.
   314	 * Any other transition is allowed.
   315	 *
   316	 * Returns true if state has been changed to the requested state.
   317	 */
   318	static inline bool pci_dev_set_io_state(struct pci_dev *dev,
   319						pci_channel_state_t new)
   320	{
   321		pci_channel_state_t old;
   322	
   323		switch (new) {
   324		case pci_channel_io_perm_failure:
 > 325			xchg(&dev->error_state, pci_channel_io_perm_failure);
   326			return true;
   327		case pci_channel_io_frozen:
   328			old = cmpxchg(&dev->error_state, pci_channel_io_normal,
   329				      pci_channel_io_frozen);
   330			return old != pci_channel_io_perm_failure;
   331		case pci_channel_io_normal:
   332			old = cmpxchg(&dev->error_state, pci_channel_io_frozen,
   333				      pci_channel_io_normal);
   334			return old != pci_channel_io_perm_failure;
   335		default:
   336			return false;
   337		}
   338	}
   339	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

