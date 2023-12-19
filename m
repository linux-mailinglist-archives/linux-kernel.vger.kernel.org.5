Return-Path: <linux-kernel+bounces-5698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4598A818E46
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0DE3284A37
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FFC2E3E3;
	Tue, 19 Dec 2023 17:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F8xzQxWt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D447724A1A
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 17:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703007464; x=1734543464;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9QmXpqVeH06qdPO2Asj39XSPlVpXXvH3+qbxXlWJnEQ=;
  b=F8xzQxWttjf5Utxe9sy664tQaNXWHrp3+Lx6OWNvkZICjusW2k4YWkXX
   M/iF4OIcbpMX2GKX/nMfpCCk3Sr/EGHt0XF5PswiPqJ0vLyiz3hV0hPau
   Y5DiPwUTQTLgm3uYldQaeqGulUgSs/AauLDHPiB5yA+dIxITbezTxb+3l
   YRI25KsJNZlNNd1cVCCDrryofQYEtDLlguRDFTjOAiI+3IWsuoek0ACl0
   L5sDj7KfN5EA1EX2aNtJxWKFB2ickK5E0396WFjU2eincmydOgJBQfkU6
   q9vTmEHoOzhEm63OE3bstGAeWuH+emk24xRojRJ/KqhUU70SWA83cCVlU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="426828623"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="426828623"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 09:37:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="899445208"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="899445208"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 19 Dec 2023 09:37:17 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rFe1q-0005l9-2Q;
	Tue, 19 Dec 2023 17:37:14 +0000
Date: Wed, 20 Dec 2023 01:37:05 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <mario.limonciello@dell.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>
Subject: drivers/platform/x86/dell/dcdbas.c:80: warning: Function parameter
 or member 'size' not described in 'smi_data_buf_realloc'
Message-ID: <202312200110.tXx7v823-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Mario,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2cf4f94d8e8646803f8fb0facf134b0cd7fb691a
commit: f1e1ea516721d1ea0b21327ff9e6cb2c2bb86e28 platform/x86: Move all dell drivers to their own subdirectory
date:   2 years, 10 months ago
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20231220/202312200110.tXx7v823-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231220/202312200110.tXx7v823-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312200110.tXx7v823-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/platform/x86/dell/dcdbas.c:80: warning: Function parameter or member 'size' not described in 'smi_data_buf_realloc'
>> drivers/platform/x86/dell/dcdbas.c:271: warning: Function parameter or member 'smi_cmd' not described in 'dcdbas_smi_request'
>> drivers/platform/x86/dell/dcdbas.c:302: warning: Function parameter or member 'dev' not described in 'smi_request_store'
   drivers/platform/x86/dell/dcdbas.c:302: warning: Function parameter or member 'attr' not described in 'smi_request_store'
   drivers/platform/x86/dell/dcdbas.c:302: warning: Function parameter or member 'buf' not described in 'smi_request_store'
   drivers/platform/x86/dell/dcdbas.c:302: warning: Function parameter or member 'count' not described in 'smi_request_store'
   drivers/platform/x86/dell/dcdbas.c:603: warning: Function parameter or member 'nb' not described in 'dcdbas_reboot_notify'
   drivers/platform/x86/dell/dcdbas.c:603: warning: Function parameter or member 'code' not described in 'dcdbas_reboot_notify'
   drivers/platform/x86/dell/dcdbas.c:603: warning: Function parameter or member 'unused' not described in 'dcdbas_reboot_notify'


vim +80 drivers/platform/x86/dell/dcdbas.c

90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06   75  
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06   76  /**
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06   77   * smi_data_buf_realloc: grow SMI data buffer if needed
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06   78   */
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06   79  static int smi_data_buf_realloc(unsigned long size)
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  @80  {
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06   81  	void *buf;
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06   82  	dma_addr_t handle;
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06   83  
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06   84  	if (smi_data_buf_size >= size)
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06   85  		return 0;
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06   86  
12c956c4f32e087 drivers/firmware/dcdbas.c Stuart Hayes     2018-09-26   87  	if (size > max_smi_data_buf_size)
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06   88  		return -EINVAL;
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06   89  
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06   90  	/* new buffer is needed */
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06   91  	buf = dma_alloc_coherent(&dcdbas_pdev->dev, size, &handle, GFP_KERNEL);
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06   92  	if (!buf) {
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06   93  		dev_dbg(&dcdbas_pdev->dev,
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06   94  			"%s: failed to allocate memory size %lu\n",
eecd58536a97502 drivers/firmware/dcdbas.c Harvey Harrison  2008-04-29   95  			__func__, size);
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06   96  		return -ENOMEM;
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06   97  	}
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06   98  	/* memory zeroed by dma_alloc_coherent */
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06   99  
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  100  	if (smi_data_buf)
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  101  		memcpy(buf, smi_data_buf, smi_data_buf_size);
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  102  
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  103  	/* free any existing buffer */
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  104  	smi_data_buf_free();
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  105  
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  106  	/* set up new buffer for use */
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  107  	smi_data_buf = buf;
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  108  	smi_data_buf_handle = handle;
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  109  	smi_data_buf_phys_addr = (u32) virt_to_phys(buf);
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  110  	smi_data_buf_size = size;
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  111  
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  112  	dev_dbg(&dcdbas_pdev->dev, "%s: phys: %x size: %lu\n",
eecd58536a97502 drivers/firmware/dcdbas.c Harvey Harrison  2008-04-29  113  		__func__, smi_data_buf_phys_addr, smi_data_buf_size);
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  114  
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  115  	return 0;
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  116  }
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  117  
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  118  static ssize_t smi_data_buf_phys_addr_show(struct device *dev,
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  119  					   struct device_attribute *attr,
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  120  					   char *buf)
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  121  {
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  122  	return sprintf(buf, "%x\n", smi_data_buf_phys_addr);
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  123  }
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  124  
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  125  static ssize_t smi_data_buf_size_show(struct device *dev,
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  126  				      struct device_attribute *attr,
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  127  				      char *buf)
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  128  {
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  129  	return sprintf(buf, "%lu\n", smi_data_buf_size);
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  130  }
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  131  
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  132  static ssize_t smi_data_buf_size_store(struct device *dev,
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  133  				       struct device_attribute *attr,
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  134  				       const char *buf, size_t count)
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  135  {
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  136  	unsigned long buf_size;
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  137  	ssize_t ret;
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  138  
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  139  	buf_size = simple_strtoul(buf, NULL, 10);
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  140  
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  141  	/* make sure SMI data buffer is at least buf_size */
8ed965d612d9e9b drivers/firmware/dcdbas.c Arjan van de Ven 2006-03-23  142  	mutex_lock(&smi_data_lock);
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  143  	ret = smi_data_buf_realloc(buf_size);
8ed965d612d9e9b drivers/firmware/dcdbas.c Arjan van de Ven 2006-03-23  144  	mutex_unlock(&smi_data_lock);
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  145  	if (ret)
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  146  		return ret;
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  147  
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  148  	return count;
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  149  }
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  150  
2c3c8bea608866d drivers/firmware/dcdbas.c Chris Wright     2010-05-12  151  static ssize_t smi_data_read(struct file *filp, struct kobject *kobj,
91a6902958f0523 drivers/firmware/dcdbas.c Zhang Rui        2007-06-09  152  			     struct bin_attribute *bin_attr,
91a6902958f0523 drivers/firmware/dcdbas.c Zhang Rui        2007-06-09  153  			     char *buf, loff_t pos, size_t count)
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  154  {
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  155  	ssize_t ret;
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  156  
8ed965d612d9e9b drivers/firmware/dcdbas.c Arjan van de Ven 2006-03-23  157  	mutex_lock(&smi_data_lock);
abe19b7b822a8fd drivers/firmware/dcdbas.c Akinobu Mita     2008-07-25  158  	ret = memory_read_from_buffer(buf, count, &pos, smi_data_buf,
abe19b7b822a8fd drivers/firmware/dcdbas.c Akinobu Mita     2008-07-25  159  					smi_data_buf_size);
8ed965d612d9e9b drivers/firmware/dcdbas.c Arjan van de Ven 2006-03-23  160  	mutex_unlock(&smi_data_lock);
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  161  	return ret;
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  162  }
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  163  
2c3c8bea608866d drivers/firmware/dcdbas.c Chris Wright     2010-05-12  164  static ssize_t smi_data_write(struct file *filp, struct kobject *kobj,
91a6902958f0523 drivers/firmware/dcdbas.c Zhang Rui        2007-06-09  165  			      struct bin_attribute *bin_attr,
91a6902958f0523 drivers/firmware/dcdbas.c Zhang Rui        2007-06-09  166  			      char *buf, loff_t pos, size_t count)
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  167  {
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  168  	ssize_t ret;
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  169  
12c956c4f32e087 drivers/firmware/dcdbas.c Stuart Hayes     2018-09-26  170  	if ((pos + count) > max_smi_data_buf_size)
b95936cb9267e4c drivers/firmware/dcdbas.c Doug Warzecha    2006-10-19  171  		return -EINVAL;
b95936cb9267e4c drivers/firmware/dcdbas.c Doug Warzecha    2006-10-19  172  
8ed965d612d9e9b drivers/firmware/dcdbas.c Arjan van de Ven 2006-03-23  173  	mutex_lock(&smi_data_lock);
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  174  
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  175  	ret = smi_data_buf_realloc(pos + count);
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  176  	if (ret)
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  177  		goto out;
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  178  
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  179  	memcpy(smi_data_buf + pos, buf, count);
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  180  	ret = count;
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  181  out:
8ed965d612d9e9b drivers/firmware/dcdbas.c Arjan van de Ven 2006-03-23  182  	mutex_unlock(&smi_data_lock);
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  183  	return ret;
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  184  }
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  185  
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  186  static ssize_t host_control_action_show(struct device *dev,
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  187  					struct device_attribute *attr,
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  188  					char *buf)
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  189  {
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  190  	return sprintf(buf, "%u\n", host_control_action);
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  191  }
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  192  
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  193  static ssize_t host_control_action_store(struct device *dev,
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  194  					 struct device_attribute *attr,
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  195  					 const char *buf, size_t count)
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  196  {
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  197  	ssize_t ret;
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  198  
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  199  	/* make sure buffer is available for host control command */
8ed965d612d9e9b drivers/firmware/dcdbas.c Arjan van de Ven 2006-03-23  200  	mutex_lock(&smi_data_lock);
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  201  	ret = smi_data_buf_realloc(sizeof(struct apm_cmd));
8ed965d612d9e9b drivers/firmware/dcdbas.c Arjan van de Ven 2006-03-23  202  	mutex_unlock(&smi_data_lock);
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  203  	if (ret)
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  204  		return ret;
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  205  
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  206  	host_control_action = simple_strtoul(buf, NULL, 10);
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  207  	return count;
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  208  }
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  209  
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  210  static ssize_t host_control_smi_type_show(struct device *dev,
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  211  					  struct device_attribute *attr,
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  212  					  char *buf)
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  213  {
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  214  	return sprintf(buf, "%u\n", host_control_smi_type);
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  215  }
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  216  
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  217  static ssize_t host_control_smi_type_store(struct device *dev,
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  218  					   struct device_attribute *attr,
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  219  					   const char *buf, size_t count)
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  220  {
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  221  	host_control_smi_type = simple_strtoul(buf, NULL, 10);
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  222  	return count;
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  223  }
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  224  
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  225  static ssize_t host_control_on_shutdown_show(struct device *dev,
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  226  					     struct device_attribute *attr,
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  227  					     char *buf)
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  228  {
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  229  	return sprintf(buf, "%u\n", host_control_on_shutdown);
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  230  }
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  231  
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  232  static ssize_t host_control_on_shutdown_store(struct device *dev,
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  233  					      struct device_attribute *attr,
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  234  					      const char *buf, size_t count)
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  235  {
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  236  	host_control_on_shutdown = simple_strtoul(buf, NULL, 10);
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  237  	return count;
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  238  }
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  239  
e23f22b5cb9e44d drivers/firmware/dcdbas.c Juergen Gross    2016-08-29  240  static int raise_smi(void *par)
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  241  {
e23f22b5cb9e44d drivers/firmware/dcdbas.c Juergen Gross    2016-08-29  242  	struct smi_cmd *smi_cmd = par;
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  243  
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  244  	if (smp_processor_id() != 0) {
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  245  		dev_dbg(&dcdbas_pdev->dev, "%s: failed to get CPU 0\n",
eecd58536a97502 drivers/firmware/dcdbas.c Harvey Harrison  2008-04-29  246  			__func__);
e23f22b5cb9e44d drivers/firmware/dcdbas.c Juergen Gross    2016-08-29  247  		return -EBUSY;
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  248  	}
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  249  
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  250  	/* generate SMI */
dd65c736d1b5312 drivers/firmware/dcdbas.c Stuart Hayes     2011-03-02  251  	/* inb to force posted write through and make SMI happen now */
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  252  	asm volatile (
dd65c736d1b5312 drivers/firmware/dcdbas.c Stuart Hayes     2011-03-02  253  		"outb %b0,%w1\n"
dd65c736d1b5312 drivers/firmware/dcdbas.c Stuart Hayes     2011-03-02  254  		"inb %w1"
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  255  		: /* no output args */
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  256  		: "a" (smi_cmd->command_code),
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  257  		  "d" (smi_cmd->command_address),
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  258  		  "b" (smi_cmd->ebx),
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  259  		  "c" (smi_cmd->ecx)
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  260  		: "memory"
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  261  	);
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  262  
e23f22b5cb9e44d drivers/firmware/dcdbas.c Juergen Gross    2016-08-29  263  	return 0;
e23f22b5cb9e44d drivers/firmware/dcdbas.c Juergen Gross    2016-08-29  264  }
e23f22b5cb9e44d drivers/firmware/dcdbas.c Juergen Gross    2016-08-29  265  /**
e23f22b5cb9e44d drivers/firmware/dcdbas.c Juergen Gross    2016-08-29  266   * dcdbas_smi_request: generate SMI request
e23f22b5cb9e44d drivers/firmware/dcdbas.c Juergen Gross    2016-08-29  267   *
e23f22b5cb9e44d drivers/firmware/dcdbas.c Juergen Gross    2016-08-29  268   * Called with smi_data_lock.
e23f22b5cb9e44d drivers/firmware/dcdbas.c Juergen Gross    2016-08-29  269   */
e23f22b5cb9e44d drivers/firmware/dcdbas.c Juergen Gross    2016-08-29  270  int dcdbas_smi_request(struct smi_cmd *smi_cmd)
e23f22b5cb9e44d drivers/firmware/dcdbas.c Juergen Gross    2016-08-29 @271  {
e23f22b5cb9e44d drivers/firmware/dcdbas.c Juergen Gross    2016-08-29  272  	int ret;
e23f22b5cb9e44d drivers/firmware/dcdbas.c Juergen Gross    2016-08-29  273  
e23f22b5cb9e44d drivers/firmware/dcdbas.c Juergen Gross    2016-08-29  274  	if (smi_cmd->magic != SMI_CMD_MAGIC) {
e23f22b5cb9e44d drivers/firmware/dcdbas.c Juergen Gross    2016-08-29  275  		dev_info(&dcdbas_pdev->dev, "%s: invalid magic value\n",
e23f22b5cb9e44d drivers/firmware/dcdbas.c Juergen Gross    2016-08-29  276  			 __func__);
e23f22b5cb9e44d drivers/firmware/dcdbas.c Juergen Gross    2016-08-29  277  		return -EBADR;
e23f22b5cb9e44d drivers/firmware/dcdbas.c Juergen Gross    2016-08-29  278  	}
e23f22b5cb9e44d drivers/firmware/dcdbas.c Juergen Gross    2016-08-29  279  
e23f22b5cb9e44d drivers/firmware/dcdbas.c Juergen Gross    2016-08-29  280  	/* SMI requires CPU 0 */
e23f22b5cb9e44d drivers/firmware/dcdbas.c Juergen Gross    2016-08-29  281  	get_online_cpus();
e23f22b5cb9e44d drivers/firmware/dcdbas.c Juergen Gross    2016-08-29  282  	ret = smp_call_on_cpu(0, raise_smi, smi_cmd, true);
e23f22b5cb9e44d drivers/firmware/dcdbas.c Juergen Gross    2016-08-29  283  	put_online_cpus();
e23f22b5cb9e44d drivers/firmware/dcdbas.c Juergen Gross    2016-08-29  284  
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  285  	return ret;
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  286  }
90563ec4129f14d drivers/firmware/dcdbas.c Doug Warzecha    2005-09-06  287  

:::::: The code at line 80 was first introduced by commit
:::::: 90563ec4129f14d19f018240d1d3ff5c0e5e6392 [PATCH] dcdbas: add Dell Systems Management Base Driver with sysfs support

:::::: TO: Doug Warzecha <Douglas_Warzecha@dell.com>
:::::: CC: Linus Torvalds <torvalds@g5.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

