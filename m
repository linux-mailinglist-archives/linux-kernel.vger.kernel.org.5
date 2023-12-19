Return-Path: <linux-kernel+bounces-5892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BDB81912A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 21:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7941B22336
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 20:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A493987A;
	Tue, 19 Dec 2023 20:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bQG5C8GX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBD739857
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 20:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703016178; x=1734552178;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rI1h2OH9nejCjg16AutyrDTeqa3JoJesRe1s9+rWI+o=;
  b=bQG5C8GXr0C6xIgVYpvecv+e0g7t5FIapYCSIML+yH0/N/lJl3L/B/5j
   6ctw4YMgKgm9Z7t/El2b9jq+UQFG9PPdv0yW2yAswuvaBsfe+ZvRKw05x
   OEc/jC1gSrUtJrgrSroXkQY0jh/WdFaUder0SnxfxUfAsL7kuMOxEty+i
   cv877LOqV25EIXbB279FOyYmqX3cJRdP+ZuaF25h5bWrufJJDSZ1yQrvN
   Bjyxfbf6l/5YE7fXT0nUTtoRDrevZSXbzUgJNrrO7//KeDRRE9rYiyrGL
   q/46clBkOPMEX/Hq93Nvoht5nKjz+nf27yOM1ftJI9tjHtd8/nrkwoN5Y
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="375204782"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="375204782"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 12:02:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="17716750"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 19 Dec 2023 12:02:56 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rFgIo-0005td-0d;
	Tue, 19 Dec 2023 20:02:54 +0000
Date: Wed, 20 Dec 2023 04:02:21 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <mario.limonciello@dell.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>
Subject: drivers/platform/x86/dell/dcdbas.c:302: warning: Function parameter
 or member 'attr' not described in 'smi_request_store'
Message-ID: <202312200424.T2sWsOXz-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2cf4f94d8e8646803f8fb0facf134b0cd7fb691a
commit: f1e1ea516721d1ea0b21327ff9e6cb2c2bb86e28 platform/x86: Move all dell drivers to their own subdirectory
date:   2 years, 10 months ago
config: i386-randconfig-014-20231101 (https://download.01.org/0day-ci/archive/20231220/202312200424.T2sWsOXz-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231220/202312200424.T2sWsOXz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312200424.T2sWsOXz-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/platform/x86/dell/dcdbas.c:80: warning: Function parameter or member 'size' not described in 'smi_data_buf_realloc'
   drivers/platform/x86/dell/dcdbas.c:271: warning: Function parameter or member 'smi_cmd' not described in 'dcdbas_smi_request'
   drivers/platform/x86/dell/dcdbas.c:302: warning: Function parameter or member 'dev' not described in 'smi_request_store'
>> drivers/platform/x86/dell/dcdbas.c:302: warning: Function parameter or member 'attr' not described in 'smi_request_store'
>> drivers/platform/x86/dell/dcdbas.c:302: warning: Function parameter or member 'buf' not described in 'smi_request_store'
>> drivers/platform/x86/dell/dcdbas.c:302: warning: Function parameter or member 'count' not described in 'smi_request_store'
>> drivers/platform/x86/dell/dcdbas.c:603: warning: Function parameter or member 'nb' not described in 'dcdbas_reboot_notify'
>> drivers/platform/x86/dell/dcdbas.c:603: warning: Function parameter or member 'code' not described in 'dcdbas_reboot_notify'
>> drivers/platform/x86/dell/dcdbas.c:603: warning: Function parameter or member 'unused' not described in 'dcdbas_reboot_notify'


vim +302 drivers/platform/x86/dell/dcdbas.c

90563ec4129f14 drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  287  
90563ec4129f14 drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  288  /**
90563ec4129f14 drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  289   * smi_request_store:
90563ec4129f14 drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  290   *
90563ec4129f14 drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  291   * The valid values are:
90563ec4129f14 drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  292   * 0: zero SMI data buffer
90563ec4129f14 drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  293   * 1: generate calling interface SMI
90563ec4129f14 drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  294   * 2: generate raw SMI
90563ec4129f14 drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  295   *
90563ec4129f14 drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  296   * User application writes smi_cmd to smi_data before telling driver
90563ec4129f14 drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  297   * to generate SMI.
90563ec4129f14 drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  298   */
90563ec4129f14 drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  299  static ssize_t smi_request_store(struct device *dev,
90563ec4129f14 drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  300  				 struct device_attribute *attr,
90563ec4129f14 drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  301  				 const char *buf, size_t count)
90563ec4129f14 drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06 @302  {
90563ec4129f14 drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  303  	struct smi_cmd *smi_cmd;
90563ec4129f14 drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  304  	unsigned long val = simple_strtoul(buf, NULL, 10);
90563ec4129f14 drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  305  	ssize_t ret;
90563ec4129f14 drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  306  
8ed965d612d9e9 drivers/firmware/dcdbas.c Arjan van de Ven 2006-03-23  307  	mutex_lock(&smi_data_lock);
90563ec4129f14 drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  308  
90563ec4129f14 drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  309  	if (smi_data_buf_size < sizeof(struct smi_cmd)) {
90563ec4129f14 drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  310  		ret = -ENODEV;
90563ec4129f14 drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  311  		goto out;
90563ec4129f14 drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  312  	}
90563ec4129f14 drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  313  	smi_cmd = (struct smi_cmd *)smi_data_buf;
90563ec4129f14 drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  314  
90563ec4129f14 drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  315  	switch (val) {
90563ec4129f14 drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  316  	case 2:
90563ec4129f14 drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  317  		/* Raw SMI */
3cab7fd964916a drivers/firmware/dcdbas.c Matthew Garrett  2009-01-07  318  		ret = dcdbas_smi_request(smi_cmd);
90563ec4129f14 drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  319  		if (!ret)
90563ec4129f14 drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  320  			ret = count;
90563ec4129f14 drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  321  		break;
90563ec4129f14 drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  322  	case 1:
12c956c4f32e08 drivers/firmware/dcdbas.c Stuart Hayes     2018-09-26  323  		/*
12c956c4f32e08 drivers/firmware/dcdbas.c Stuart Hayes     2018-09-26  324  		 * Calling Interface SMI
12c956c4f32e08 drivers/firmware/dcdbas.c Stuart Hayes     2018-09-26  325  		 *
12c956c4f32e08 drivers/firmware/dcdbas.c Stuart Hayes     2018-09-26  326  		 * Provide physical address of command buffer field within
12c956c4f32e08 drivers/firmware/dcdbas.c Stuart Hayes     2018-09-26  327  		 * the struct smi_cmd to BIOS.
12c956c4f32e08 drivers/firmware/dcdbas.c Stuart Hayes     2018-09-26  328  		 *
12c956c4f32e08 drivers/firmware/dcdbas.c Stuart Hayes     2018-09-26  329  		 * Because the address that smi_cmd (smi_data_buf) points to
12c956c4f32e08 drivers/firmware/dcdbas.c Stuart Hayes     2018-09-26  330  		 * will be from memremap() of a non-memory address if WSMT
12c956c4f32e08 drivers/firmware/dcdbas.c Stuart Hayes     2018-09-26  331  		 * is present, we can't use virt_to_phys() on smi_cmd, so
12c956c4f32e08 drivers/firmware/dcdbas.c Stuart Hayes     2018-09-26  332  		 * we have to use the physical address that was saved when
12c956c4f32e08 drivers/firmware/dcdbas.c Stuart Hayes     2018-09-26  333  		 * the virtual address for smi_cmd was received.
12c956c4f32e08 drivers/firmware/dcdbas.c Stuart Hayes     2018-09-26  334  		 */
12c956c4f32e08 drivers/firmware/dcdbas.c Stuart Hayes     2018-09-26  335  		smi_cmd->ebx = smi_data_buf_phys_addr +
12c956c4f32e08 drivers/firmware/dcdbas.c Stuart Hayes     2018-09-26  336  				offsetof(struct smi_cmd, command_buffer);
3cab7fd964916a drivers/firmware/dcdbas.c Matthew Garrett  2009-01-07  337  		ret = dcdbas_smi_request(smi_cmd);
90563ec4129f14 drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  338  		if (!ret)
90563ec4129f14 drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  339  			ret = count;
90563ec4129f14 drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  340  		break;
90563ec4129f14 drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  341  	case 0:
90563ec4129f14 drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  342  		memset(smi_data_buf, 0, smi_data_buf_size);
90563ec4129f14 drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  343  		ret = count;
90563ec4129f14 drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  344  		break;
90563ec4129f14 drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  345  	default:
90563ec4129f14 drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  346  		ret = -EINVAL;
90563ec4129f14 drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  347  		break;
90563ec4129f14 drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  348  	}
90563ec4129f14 drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  349  
90563ec4129f14 drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  350  out:
8ed965d612d9e9 drivers/firmware/dcdbas.c Arjan van de Ven 2006-03-23  351  	mutex_unlock(&smi_data_lock);
90563ec4129f14 drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  352  	return ret;
90563ec4129f14 drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  353  }
3cab7fd964916a drivers/firmware/dcdbas.c Matthew Garrett  2009-01-07  354  EXPORT_SYMBOL(dcdbas_smi_request);
90563ec4129f14 drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  355  

:::::: The code at line 302 was first introduced by commit
:::::: 90563ec4129f14d19f018240d1d3ff5c0e5e6392 [PATCH] dcdbas: add Dell Systems Management Base Driver with sysfs support

:::::: TO: Doug Warzecha <Douglas_Warzecha@dell.com>
:::::: CC: Linus Torvalds <torvalds@g5.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

