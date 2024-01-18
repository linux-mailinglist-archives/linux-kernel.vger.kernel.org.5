Return-Path: <linux-kernel+bounces-29619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7305B8310D7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 02:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F244828164C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 01:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B23F1C2F;
	Thu, 18 Jan 2024 01:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WqXpvRDx"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C29186C;
	Thu, 18 Jan 2024 01:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705541131; cv=none; b=cwPb4qFGeHsMEVhavM+lRX7n/BoAosZZZD0pZhCxBMkdIVIAl7VdyfU/MlMV4Slr6RvIwHLiiROJQFxh2jkQ/w4qtyZRsekefKyekcMDHo+Hpw+nYYpp61ygAYBEYOUs/6XOjgcziRBP5FcW2Ckp6rQ3pHt/YR3TYDarAjK2E/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705541131; c=relaxed/simple;
	bh=QhJc3+6KjP4KN9TP6cfW1JnVCgKGoQ3O+Dmy9ImmmDg=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=RPXzKCblwFIF+N5AAWPX9vtLaxJID2Xv005JdZXL78V7HbVC/WfQpVpHv7xL3mRpPLKehV306CySFbVqpFZc6Eed46yRFC/QRUU0rE7bKJj/jRUgCC6RTaDXQZ41HTXfrt0iqmT0eAhR/C7OBbWC40jJZB70zBwV1/gRivCQisM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WqXpvRDx; arc=none smtp.client-ip=192.55.52.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705541128; x=1737077128;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QhJc3+6KjP4KN9TP6cfW1JnVCgKGoQ3O+Dmy9ImmmDg=;
  b=WqXpvRDxLTZhimVXGHepE04zbJkqtsabZoLpyqHO+oRXDear3jAp/bgu
   1zToYQFmVSTgAqUA/QCmGqW5GWNE5KiQg/ywn4V6fXLz0dj84V3Q7SCbU
   7nbP7A6ruWvjHzBd1100nqt1voqe4lix0MnN0GiV7dg9avb99GlAvSCH6
   L4PbQI75fmgl7wo1bDt6z4j8p7PUZnRD3QAglK0ba0FlUnK6X9sdd7S2Q
   fXUkM15lM07pC/eSp2K5F3aWI6wLbnX0q6BxoCasyBmZ8g/Sb30xaES41
   JqE9Sr3XZZcGq0s7IPwlE8PnC8RpInSBIBlI1TnjPUl/8rty/li7kduOk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="486469710"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="486469710"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 17:25:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="1031501855"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="1031501855"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 17 Jan 2024 17:25:23 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rQH9l-0002U6-27;
	Thu, 18 Jan 2024 01:25:21 +0000
Date: Thu, 18 Jan 2024 09:25:04 +0800
From: kernel test robot <lkp@intel.com>
To: Zhipeng Lu <alexious@zju.edu.cn>
Cc: oe-kbuild-all@lists.linux.dev,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Sumit Saxena <sumit.saxena@broadcom.com>,
	Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
	Chandrakanth patil <chandrakanth.patil@broadcom.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: megaraid_sas: Fix a memleak in megasas_init_fw
Message-ID: <202401180914.gbhwzoJM-lkp@intel.com>
References: <20240117081314.3818871-1-alexious@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117081314.3818871-1-alexious@zju.edu.cn>

Hi Zhipeng,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jejb-scsi/for-next]
[also build test WARNING on mkp-scsi/for-next linus/master v6.7 next-20240117]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zhipeng-Lu/scsi-megaraid_sas-Fix-a-memleak-in-megasas_init_fw/20240117-162116
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git for-next
patch link:    https://lore.kernel.org/r/20240117081314.3818871-1-alexious%40zju.edu.cn
patch subject: [PATCH] scsi: megaraid_sas: Fix a memleak in megasas_init_fw
config: i386-randconfig-141-20240118 (https://download.01.org/0day-ci/archive/20240118/202401180914.gbhwzoJM-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240118/202401180914.gbhwzoJM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401180914.gbhwzoJM-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/scsi/megaraid/megaraid_sas_base.c:6019:9: warning: unused variable 'j' [-Wunused-variable]
    6019 |         int i, j, loop;
         |                ^
   1 warning generated.


vim +/j +6019 drivers/scsi/megaraid/megaraid_sas_base.c

132147d7f620ee drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6002  
cd50ba8ede5cd3 drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2010-12-21  6003  /**
cd50ba8ede5cd3 drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2010-12-21  6004   * megasas_init_fw -	Initializes the FW
cd50ba8ede5cd3 drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2010-12-21  6005   * @instance:		Adapter soft state
cd50ba8ede5cd3 drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2010-12-21  6006   *
cd50ba8ede5cd3 drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2010-12-21  6007   * This is the main function for initializing firmware
cd50ba8ede5cd3 drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2010-12-21  6008   */
cd50ba8ede5cd3 drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2010-12-21  6009  
cd50ba8ede5cd3 drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2010-12-21  6010  static int megasas_init_fw(struct megasas_instance *instance)
cd50ba8ede5cd3 drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2010-12-21  6011  {
cd50ba8ede5cd3 drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2010-12-21  6012  	u32 max_sectors_1;
15dd03811d99dc drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-02-10  6013  	u32 max_sectors_2, tmp_sectors, msix_enable;
81b7645223ea59 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2018-10-16  6014  	u32 scratch_pad_1, scratch_pad_2, scratch_pad_3, status_reg;
11f8a7b31f2140 drivers/scsi/megaraid/megaraid_sas_base.c Ben Collins                2013-09-13  6015  	resource_size_t base_addr;
9a5987101c15e5 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2019-05-07  6016  	void *base_addr_phys;
51087a8617fef1 drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@avagotech.com 2014-09-12  6017  	struct megasas_ctrl_info *ctrl_info = NULL;
cd50ba8ede5cd3 drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2010-12-21  6018  	unsigned long bar_list;
ce88418dce0b47 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2019-05-07 @6019  	int i, j, loop;
229fe47cd046ef drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2014-03-10  6020  	struct IOV_111 *iovPtr;
5a8cb85b569b23 drivers/scsi/megaraid/megaraid_sas_base.c sumit.saxena@avagotech.com 2015-10-15  6021  	struct fusion_context *fusion;
132147d7f620ee drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6022  	bool intr_coalescing;
132147d7f620ee drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6023  	unsigned int num_msix_req;
299ee42615e3f5 drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6024  	u16 lnksta, speed;
5a8cb85b569b23 drivers/scsi/megaraid/megaraid_sas_base.c sumit.saxena@avagotech.com 2015-10-15  6025  
5a8cb85b569b23 drivers/scsi/megaraid/megaraid_sas_base.c sumit.saxena@avagotech.com 2015-10-15  6026  	fusion = instance->ctrl_context;
cd50ba8ede5cd3 drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2010-12-21  6027  
cd50ba8ede5cd3 drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2010-12-21  6028  	/* Find first memory bar */
cd50ba8ede5cd3 drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2010-12-21  6029  	bar_list = pci_select_bars(instance->pdev, IORESOURCE_MEM);
51f9039ffd751d drivers/scsi/megaraid/megaraid_sas_base.c Christophe JAILLET         2016-08-21  6030  	instance->bar = find_first_bit(&bar_list, BITS_PER_LONG);
e7f851684efb33 drivers/scsi/megaraid/megaraid_sas_base.c Yinghai Lu                 2016-08-05  6031  	if (pci_request_selected_regions(instance->pdev, 1<<instance->bar,
cd50ba8ede5cd3 drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2010-12-21  6032  					 "megasas: LSI")) {
1be1825453f6d7 drivers/scsi/megaraid/megaraid_sas_base.c Bjorn Helgaas              2015-07-07  6033  		dev_printk(KERN_DEBUG, &instance->pdev->dev, "IO memory region busy!\n");
cd50ba8ede5cd3 drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2010-12-21  6034  		return -EBUSY;
cd50ba8ede5cd3 drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2010-12-21  6035  	}
cd50ba8ede5cd3 drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2010-12-21  6036  
11f8a7b31f2140 drivers/scsi/megaraid/megaraid_sas_base.c Ben Collins                2013-09-13  6037  	base_addr = pci_resource_start(instance->pdev, instance->bar);
4bdc0d676a6431 drivers/scsi/megaraid/megaraid_sas_base.c Christoph Hellwig          2020-01-06  6038  	instance->reg_set = ioremap(base_addr, 8192);
cd50ba8ede5cd3 drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2010-12-21  6039  
cd50ba8ede5cd3 drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2010-12-21  6040  	if (!instance->reg_set) {
1be1825453f6d7 drivers/scsi/megaraid/megaraid_sas_base.c Bjorn Helgaas              2015-07-07  6041  		dev_printk(KERN_DEBUG, &instance->pdev->dev, "Failed to map IO mem\n");
cd50ba8ede5cd3 drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2010-12-21  6042  		goto fail_ioremap;
cd50ba8ede5cd3 drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2010-12-21  6043  	}
cd50ba8ede5cd3 drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2010-12-21  6044  
9a5987101c15e5 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2019-05-07  6045  	base_addr_phys = &base_addr;
9a5987101c15e5 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2019-05-07  6046  	dev_printk(KERN_DEBUG, &instance->pdev->dev,
9a5987101c15e5 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2019-05-07  6047  		   "BAR:0x%lx  BAR's base_addr(phys):%pa  mapped virt_addr:0x%p\n",
9a5987101c15e5 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2019-05-07  6048  		   instance->bar, base_addr_phys, instance->reg_set);
9a5987101c15e5 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2019-05-07  6049  
e7d36b88435077 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-10-19  6050  	if (instance->adapter_type != MFI_SERIES)
9c915a8c99bce6 drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2010-12-21  6051  		instance->instancet = &megasas_instance_template_fusion;
9581ebebbe351d drivers/scsi/megaraid/megaraid_sas_base.c Sasikumar Chandrasekaran   2017-01-10  6052  	else {
9581ebebbe351d drivers/scsi/megaraid/megaraid_sas_base.c Sasikumar Chandrasekaran   2017-01-10  6053  		switch (instance->pdev->device) {
cd50ba8ede5cd3 drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2010-12-21  6054  		case PCI_DEVICE_ID_LSI_SAS1078R:
cd50ba8ede5cd3 drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2010-12-21  6055  		case PCI_DEVICE_ID_LSI_SAS1078DE:
cd50ba8ede5cd3 drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2010-12-21  6056  			instance->instancet = &megasas_instance_template_ppc;
cd50ba8ede5cd3 drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2010-12-21  6057  			break;
cd50ba8ede5cd3 drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2010-12-21  6058  		case PCI_DEVICE_ID_LSI_SAS1078GEN2:
cd50ba8ede5cd3 drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2010-12-21  6059  		case PCI_DEVICE_ID_LSI_SAS0079GEN2:
cd50ba8ede5cd3 drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2010-12-21  6060  			instance->instancet = &megasas_instance_template_gen2;
cd50ba8ede5cd3 drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2010-12-21  6061  			break;
cd50ba8ede5cd3 drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2010-12-21  6062  		case PCI_DEVICE_ID_LSI_SAS0073SKINNY:
cd50ba8ede5cd3 drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2010-12-21  6063  		case PCI_DEVICE_ID_LSI_SAS0071SKINNY:
cd50ba8ede5cd3 drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2010-12-21  6064  			instance->instancet = &megasas_instance_template_skinny;
cd50ba8ede5cd3 drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2010-12-21  6065  			break;
cd50ba8ede5cd3 drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2010-12-21  6066  		case PCI_DEVICE_ID_LSI_SAS1064R:
cd50ba8ede5cd3 drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2010-12-21  6067  		case PCI_DEVICE_ID_DELL_PERC5:
cd50ba8ede5cd3 drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2010-12-21  6068  		default:
cd50ba8ede5cd3 drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2010-12-21  6069  			instance->instancet = &megasas_instance_template_xscale;
9581ebebbe351d drivers/scsi/megaraid/megaraid_sas_base.c Sasikumar Chandrasekaran   2017-01-10  6070  			instance->pd_list_not_supported = 1;
cd50ba8ede5cd3 drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2010-12-21  6071  			break;
cd50ba8ede5cd3 drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2010-12-21  6072  		}
9581ebebbe351d drivers/scsi/megaraid/megaraid_sas_base.c Sasikumar Chandrasekaran   2017-01-10  6073  	}
cd50ba8ede5cd3 drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2010-12-21  6074  
6431f5d7c6025f drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@lsi.com       2013-07-16  6075  	if (megasas_transition_to_ready(instance, 0)) {
78409d4b47b83d drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2019-05-07  6076  		dev_info(&instance->pdev->dev,
78409d4b47b83d drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2019-05-07  6077  			 "Failed to transition controller to ready from %s!\n",
78409d4b47b83d drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2019-05-07  6078  			 __func__);
f10fb8523aeebb drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2019-05-07  6079  		if (instance->adapter_type != MFI_SERIES) {
de93b40d98ead2 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2018-10-16  6080  			status_reg = instance->instancet->read_fw_status_reg(
de516379e85f51 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2018-12-17  6081  					instance);
f10fb8523aeebb drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2019-05-07  6082  			if (status_reg & MFI_RESET_ADAPTER) {
78409d4b47b83d drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2019-05-07  6083  				if (megasas_adp_reset_wait_for_ready
78409d4b47b83d drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2019-05-07  6084  					(instance, true, 0) == FAILED)
f10fb8523aeebb drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2019-05-07  6085  					goto fail_ready_state;
f10fb8523aeebb drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2019-05-07  6086  			} else {
f10fb8523aeebb drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2019-05-07  6087  				goto fail_ready_state;
de93b40d98ead2 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2018-10-16  6088  			}
f10fb8523aeebb drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2019-05-07  6089  		} else {
6431f5d7c6025f drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@lsi.com       2013-07-16  6090  			atomic_set(&instance->fw_reset_no_pci_access, 1);
6431f5d7c6025f drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@lsi.com       2013-07-16  6091  			instance->instancet->adp_reset
6431f5d7c6025f drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@lsi.com       2013-07-16  6092  				(instance, instance->reg_set);
6431f5d7c6025f drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@lsi.com       2013-07-16  6093  			atomic_set(&instance->fw_reset_no_pci_access, 0);
6431f5d7c6025f drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@lsi.com       2013-07-16  6094  
de93b40d98ead2 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2018-10-16  6095  			/*waiting for about 30 second before retry*/
6431f5d7c6025f drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@lsi.com       2013-07-16  6096  			ssleep(30);
6431f5d7c6025f drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@lsi.com       2013-07-16  6097  
058a8facfe1ee0 drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2011-10-08  6098  			if (megasas_transition_to_ready(instance, 0))
cd50ba8ede5cd3 drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2010-12-21  6099  				goto fail_ready_state;
de93b40d98ead2 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2018-10-16  6100  		}
78409d4b47b83d drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2019-05-07  6101  
78409d4b47b83d drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2019-05-07  6102  		dev_info(&instance->pdev->dev,
78409d4b47b83d drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2019-05-07  6103  			 "FW restarted successfully from %s!\n",
78409d4b47b83d drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2019-05-07  6104  			 __func__);
6431f5d7c6025f drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@lsi.com       2013-07-16  6105  	}
cd50ba8ede5cd3 drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2010-12-21  6106  
e5d65b4b81af41 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-10-19  6107  	megasas_init_ctrl_params(instance);
e5d65b4b81af41 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-10-19  6108  
107a60dd71b5f5 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-10-19  6109  	if (megasas_set_dma_mask(instance))
e5d65b4b81af41 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-10-19  6110  		goto fail_ready_state;
e5d65b4b81af41 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-10-19  6111  
e5d65b4b81af41 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-10-19  6112  	if (megasas_alloc_ctrl_mem(instance))
e5d65b4b81af41 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-10-19  6113  		goto fail_alloc_dma_buf;
e5d65b4b81af41 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-10-19  6114  
e5d65b4b81af41 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-10-19  6115  	if (megasas_alloc_ctrl_dma_buffers(instance))
e5d65b4b81af41 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-10-19  6116  		goto fail_alloc_dma_buf;
e5d65b4b81af41 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-10-19  6117  
e5d65b4b81af41 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-10-19  6118  	fusion = instance->ctrl_context;
e5d65b4b81af41 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-10-19  6119  
630d42b70f5d5c drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2018-12-17  6120  	if (instance->adapter_type >= VENTURA_SERIES) {
81b7645223ea59 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2018-10-16  6121  		scratch_pad_2 =
272652fcbf1adf drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2018-12-17  6122  			megasas_readl(instance,
272652fcbf1adf drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2018-12-17  6123  				      &instance->reg_set->outbound_scratch_pad_2);
81b7645223ea59 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2018-10-16  6124  		instance->max_raid_mapsize = ((scratch_pad_2 >>
d889344e4e59eb drivers/scsi/megaraid/megaraid_sas_base.c Sasikumar Chandrasekaran   2017-01-10  6125  			MR_MAX_RAID_MAP_SIZE_OFFSET_SHIFT) &
d889344e4e59eb drivers/scsi/megaraid/megaraid_sas_base.c Sasikumar Chandrasekaran   2017-01-10  6126  			MR_MAX_RAID_MAP_SIZE_MASK);
d889344e4e59eb drivers/scsi/megaraid/megaraid_sas_base.c Sasikumar Chandrasekaran   2017-01-10  6127  	}
d46a3ad679c723 drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@lsi.com       2013-05-22  6128  
9ab089d30bcf09 drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-07-26  6129  	instance->enable_sdev_max_qd = enable_sdev_max_qd;
9ab089d30bcf09 drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-07-26  6130  
7fc557005c454f drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6131  	switch (instance->adapter_type) {
7fc557005c454f drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6132  	case VENTURA_SERIES:
49f2bf1071f06a drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6133  		fusion->pcie_bw_limitation = true;
7fc557005c454f drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6134  		break;
7fc557005c454f drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6135  	case AERO_SERIES:
7fc557005c454f drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6136  		fusion->r56_div_offload = true;
7fc557005c454f drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6137  		break;
7fc557005c454f drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6138  	default:
7fc557005c454f drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6139  		break;
7fc557005c454f drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6140  	}
49f2bf1071f06a drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6141  
3f1abce4aba4ce drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2011-05-11  6142  	/* Check if MSI-X is supported while in ready state */
de516379e85f51 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2018-12-17  6143  	msix_enable = (instance->instancet->read_fw_status_reg(instance) &
3f1abce4aba4ce drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2011-05-11  6144  		       0x4000000) >> 0x1a;
c8e858fe72230d drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2011-10-08  6145  	if (msix_enable && !msix_disable) {
fad119b707f8cc drivers/scsi/megaraid/megaraid_sas_base.c Hannes Reinecke            2016-12-02  6146  
272652fcbf1adf drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2018-12-17  6147  		scratch_pad_1 = megasas_readl
272652fcbf1adf drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2018-12-17  6148  			(instance, &instance->reg_set->outbound_scratch_pad_1);
c8e858fe72230d drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2011-10-08  6149  		/* Check max MSI-X vectors */
5a8cb85b569b23 drivers/scsi/megaraid/megaraid_sas_base.c sumit.saxena@avagotech.com 2015-10-15  6150  		if (fusion) {
c365178f3147f3 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-10-19  6151  			if (instance->adapter_type == THUNDERBOLT_SERIES) {
c365178f3147f3 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-10-19  6152  				/* Thunderbolt Series*/
81b7645223ea59 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2018-10-16  6153  				instance->msix_vectors = (scratch_pad_1
d46a3ad679c723 drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@lsi.com       2013-05-22  6154  					& MR_MAX_REPLY_QUEUES_OFFSET) + 1;
e29c3221334726 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2018-10-16  6155  			} else {
81b7645223ea59 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2018-10-16  6156  				instance->msix_vectors = ((scratch_pad_1
d46a3ad679c723 drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@lsi.com       2013-05-22  6157  					& MR_MAX_REPLY_QUEUES_EXT_OFFSET)
d46a3ad679c723 drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@lsi.com       2013-05-22  6158  					>> MR_MAX_REPLY_QUEUES_EXT_OFFSET_SHIFT) + 1;
e29c3221334726 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2018-10-16  6159  
e29c3221334726 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2018-10-16  6160  				/*
e29c3221334726 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2018-10-16  6161  				 * For Invader series, > 8 MSI-x vectors
e29c3221334726 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2018-10-16  6162  				 * supported by FW/HW implies combined
e29c3221334726 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2018-10-16  6163  				 * reply queue mode is enabled.
e29c3221334726 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2018-10-16  6164  				 * For Ventura series, > 16 MSI-x vectors
e29c3221334726 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2018-10-16  6165  				 * supported by FW/HW implies combined
e29c3221334726 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2018-10-16  6166  				 * reply queue mode is enabled.
e29c3221334726 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2018-10-16  6167  				 */
e29c3221334726 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2018-10-16  6168  				switch (instance->adapter_type) {
e29c3221334726 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2018-10-16  6169  				case INVADER_SERIES:
e29c3221334726 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2018-10-16  6170  					if (instance->msix_vectors > 8)
e29c3221334726 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2018-10-16  6171  						instance->msix_combined = true;
e29c3221334726 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2018-10-16  6172  					break;
154a7cde9a895d drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2018-12-17  6173  				case AERO_SERIES:
e29c3221334726 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2018-10-16  6174  				case VENTURA_SERIES:
2493c67e518c77 drivers/scsi/megaraid/megaraid_sas_base.c Sasikumar Chandrasekaran   2017-01-10  6175  					if (instance->msix_vectors > 16)
2493c67e518c77 drivers/scsi/megaraid/megaraid_sas_base.c Sasikumar Chandrasekaran   2017-01-10  6176  						instance->msix_combined = true;
e29c3221334726 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2018-10-16  6177  					break;
e29c3221334726 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2018-10-16  6178  				}
2493c67e518c77 drivers/scsi/megaraid/megaraid_sas_base.c Sasikumar Chandrasekaran   2017-01-10  6179  
179ac14291a0e1 drivers/scsi/megaraid/megaraid_sas_base.c Sumit Saxena               2016-01-28  6180  				if (rdpq_enable)
81b7645223ea59 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2018-10-16  6181  					instance->is_rdpq = (scratch_pad_1 & MR_RDPQ_MODE_OFFSET) ?
179ac14291a0e1 drivers/scsi/megaraid/megaraid_sas_base.c Sumit Saxena               2016-01-28  6182  								1 : 0;
1d15d9098ad12b drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2019-05-07  6183  
1175b88452cad2 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2019-06-28  6184  				if (instance->adapter_type >= INVADER_SERIES &&
1175b88452cad2 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2019-06-28  6185  				    !instance->msix_combined) {
1d15d9098ad12b drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2019-05-07  6186  					instance->msix_load_balance = true;
1d15d9098ad12b drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2019-05-07  6187  					instance->smp_affinity_enable = false;
1d15d9098ad12b drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2019-05-07  6188  				}
1d15d9098ad12b drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2019-05-07  6189  
d46a3ad679c723 drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@lsi.com       2013-05-22  6190  				/* Save 1-15 reply post index address to local memory
d46a3ad679c723 drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@lsi.com       2013-05-22  6191  				 * Index 0 is already saved from reg offset
d46a3ad679c723 drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@lsi.com       2013-05-22  6192  				 * MPI2_REPLY_POST_HOST_INDEX_OFFSET
d46a3ad679c723 drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@lsi.com       2013-05-22  6193  				 */
d46a3ad679c723 drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@lsi.com       2013-05-22  6194  				for (loop = 1; loop < MR_MAX_MSIX_REG_ARRAY; loop++) {
d46a3ad679c723 drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@lsi.com       2013-05-22  6195  					instance->reply_post_host_index_addr[loop] =
8a232bb39917bf drivers/scsi/megaraid/megaraid_sas_base.c Christoph Hellwig          2015-04-23  6196  						(u32 __iomem *)
8a232bb39917bf drivers/scsi/megaraid/megaraid_sas_base.c Christoph Hellwig          2015-04-23  6197  						((u8 __iomem *)instance->reg_set +
d46a3ad679c723 drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@lsi.com       2013-05-22  6198  						MPI2_SUP_REPLY_POST_HOST_INDEX_OFFSET
d46a3ad679c723 drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@lsi.com       2013-05-22  6199  						+ (loop * 0x10));
d46a3ad679c723 drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@lsi.com       2013-05-22  6200  				}
5a8cb85b569b23 drivers/scsi/megaraid/megaraid_sas_base.c sumit.saxena@avagotech.com 2015-10-15  6201  			}
ce88418dce0b47 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2019-05-07  6202  
ce88418dce0b47 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2019-05-07  6203  			dev_info(&instance->pdev->dev,
ce88418dce0b47 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2019-05-07  6204  				 "firmware supports msix\t: (%d)",
ce88418dce0b47 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2019-05-07  6205  				 instance->msix_vectors);
d46a3ad679c723 drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@lsi.com       2013-05-22  6206  			if (msix_vectors)
d46a3ad679c723 drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@lsi.com       2013-05-22  6207  				instance->msix_vectors = min(msix_vectors,
d46a3ad679c723 drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@lsi.com       2013-05-22  6208  					instance->msix_vectors);
5a8cb85b569b23 drivers/scsi/megaraid/megaraid_sas_base.c sumit.saxena@avagotech.com 2015-10-15  6209  		} else /* MFI adapters */
c8e858fe72230d drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2011-10-08  6210  			instance->msix_vectors = 1;
1d15d9098ad12b drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2019-05-07  6211  
132147d7f620ee drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6212  
132147d7f620ee drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6213  		/*
132147d7f620ee drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6214  		 * For Aero (if some conditions are met), driver will configure a
132147d7f620ee drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6215  		 * few additional reply queues with interrupt coalescing enabled.
132147d7f620ee drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6216  		 * These queues with interrupt coalescing enabled are called
132147d7f620ee drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6217  		 * High IOPS queues and rest of reply queues (based on number of
132147d7f620ee drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6218  		 * logical CPUs) are termed as Low latency queues.
132147d7f620ee drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6219  		 *
132147d7f620ee drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6220  		 * Total Number of reply queues = High IOPS queues + low latency queues
132147d7f620ee drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6221  		 *
132147d7f620ee drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6222  		 * For rest of fusion adapters, 1 additional reply queue will be
132147d7f620ee drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6223  		 * reserved for management commands, rest of reply queues
132147d7f620ee drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6224  		 * (based on number of logical CPUs) will be used for IOs and
132147d7f620ee drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6225  		 * referenced as IO queues.
132147d7f620ee drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6226  		 * Total Number of reply queues = 1 + IO queues
132147d7f620ee drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6227  		 *
132147d7f620ee drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6228  		 * MFI adapters supports single MSI-x so single reply queue
132147d7f620ee drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6229  		 * will be used for IO and management commands.
132147d7f620ee drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6230  		 */
132147d7f620ee drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6231  
132147d7f620ee drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6232  		intr_coalescing = (scratch_pad_1 & MR_INTR_COALESCING_SUPPORT_OFFSET) ?
132147d7f620ee drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6233  								true : false;
132147d7f620ee drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6234  		if (intr_coalescing &&
132147d7f620ee drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6235  			(num_online_cpus() >= MR_HIGH_IOPS_QUEUE_COUNT) &&
132147d7f620ee drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6236  			(instance->msix_vectors == MEGASAS_MAX_MSIX_QUEUES))
299ee42615e3f5 drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6237  			instance->perf_mode = MR_BALANCED_PERF_MODE;
c8e858fe72230d drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2011-10-08  6238  		else
299ee42615e3f5 drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6239  			instance->perf_mode = MR_LATENCY_PERF_MODE;
299ee42615e3f5 drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6240  
299ee42615e3f5 drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6241  
299ee42615e3f5 drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6242  		if (instance->adapter_type == AERO_SERIES) {
299ee42615e3f5 drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6243  			pcie_capability_read_word(instance->pdev, PCI_EXP_LNKSTA, &lnksta);
299ee42615e3f5 drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6244  			speed = lnksta & PCI_EXP_LNKSTA_CLS;
299ee42615e3f5 drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6245  
299ee42615e3f5 drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6246  			/*
299ee42615e3f5 drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6247  			 * For Aero, if PCIe link speed is <16 GT/s, then driver should operate
299ee42615e3f5 drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6248  			 * in latency perf mode and enable R1 PCI bandwidth algorithm
299ee42615e3f5 drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6249  			 */
299ee42615e3f5 drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6250  			if (speed < 0x4) {
299ee42615e3f5 drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6251  				instance->perf_mode = MR_LATENCY_PERF_MODE;
299ee42615e3f5 drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6252  				fusion->pcie_bw_limitation = true;
299ee42615e3f5 drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6253  			}
299ee42615e3f5 drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6254  
299ee42615e3f5 drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6255  			/*
299ee42615e3f5 drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6256  			 * Performance mode settings provided through module parameter-perf_mode will
299ee42615e3f5 drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6257  			 * take affect only for:
299ee42615e3f5 drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6258  			 * 1. Aero family of adapters.
299ee42615e3f5 drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6259  			 * 2. When user sets module parameter- perf_mode in range of 0-2.
299ee42615e3f5 drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6260  			 */
299ee42615e3f5 drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6261  			if ((perf_mode >= MR_BALANCED_PERF_MODE) &&
299ee42615e3f5 drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6262  				(perf_mode <= MR_LATENCY_PERF_MODE))
299ee42615e3f5 drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6263  				instance->perf_mode = perf_mode;
299ee42615e3f5 drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6264  			/*
299ee42615e3f5 drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6265  			 * If intr coalescing is not supported by controller FW, then IOPS
299ee42615e3f5 drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6266  			 * and Balanced modes are not feasible.
299ee42615e3f5 drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6267  			 */
299ee42615e3f5 drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6268  			if (!intr_coalescing)
299ee42615e3f5 drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6269  				instance->perf_mode = MR_LATENCY_PERF_MODE;
299ee42615e3f5 drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6270  
299ee42615e3f5 drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6271  		}
132147d7f620ee drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6272  
299ee42615e3f5 drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6273  		if (instance->perf_mode == MR_BALANCED_PERF_MODE)
132147d7f620ee drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6274  			instance->low_latency_index_start =
132147d7f620ee drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6275  				MR_HIGH_IOPS_QUEUE_COUNT;
132147d7f620ee drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6276  		else
132147d7f620ee drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6277  			instance->low_latency_index_start = 1;
132147d7f620ee drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6278  
132147d7f620ee drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6279  		num_msix_req = num_online_cpus() + instance->low_latency_index_start;
132147d7f620ee drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6280  
132147d7f620ee drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6281  		instance->msix_vectors = min(num_msix_req,
132147d7f620ee drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6282  				instance->msix_vectors);
132147d7f620ee drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6283  
132147d7f620ee drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6284  		megasas_alloc_irq_vectors(instance);
132147d7f620ee drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6285  		if (!instance->msix_vectors)
1d15d9098ad12b drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2019-05-07  6286  			instance->msix_load_balance = false;
c8e858fe72230d drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2011-10-08  6287  	}
2493c67e518c77 drivers/scsi/megaraid/megaraid_sas_base.c Sasikumar Chandrasekaran   2017-01-10  6288  	/*
2493c67e518c77 drivers/scsi/megaraid/megaraid_sas_base.c Sasikumar Chandrasekaran   2017-01-10  6289  	 * MSI-X host index 0 is common for all adapter.
2493c67e518c77 drivers/scsi/megaraid/megaraid_sas_base.c Sasikumar Chandrasekaran   2017-01-10  6290  	 * It is used for all MPT based Adapters.
2493c67e518c77 drivers/scsi/megaraid/megaraid_sas_base.c Sasikumar Chandrasekaran   2017-01-10  6291  	 */
2493c67e518c77 drivers/scsi/megaraid/megaraid_sas_base.c Sasikumar Chandrasekaran   2017-01-10  6292  	if (instance->msix_combined) {
2493c67e518c77 drivers/scsi/megaraid/megaraid_sas_base.c Sasikumar Chandrasekaran   2017-01-10  6293  		instance->reply_post_host_index_addr[0] =
2493c67e518c77 drivers/scsi/megaraid/megaraid_sas_base.c Sasikumar Chandrasekaran   2017-01-10  6294  				(u32 *)((u8 *)instance->reg_set +
2493c67e518c77 drivers/scsi/megaraid/megaraid_sas_base.c Sasikumar Chandrasekaran   2017-01-10  6295  				MPI2_SUP_REPLY_POST_HOST_INDEX_OFFSET);
2493c67e518c77 drivers/scsi/megaraid/megaraid_sas_base.c Sasikumar Chandrasekaran   2017-01-10  6296  	} else {
2493c67e518c77 drivers/scsi/megaraid/megaraid_sas_base.c Sasikumar Chandrasekaran   2017-01-10  6297  		instance->reply_post_host_index_addr[0] =
2493c67e518c77 drivers/scsi/megaraid/megaraid_sas_base.c Sasikumar Chandrasekaran   2017-01-10  6298  			(u32 *)((u8 *)instance->reg_set +
2493c67e518c77 drivers/scsi/megaraid/megaraid_sas_base.c Sasikumar Chandrasekaran   2017-01-10  6299  			MPI2_REPLY_POST_HOST_INDEX_OFFSET);
2493c67e518c77 drivers/scsi/megaraid/megaraid_sas_base.c Sasikumar Chandrasekaran   2017-01-10  6300  	}
2493c67e518c77 drivers/scsi/megaraid/megaraid_sas_base.c Sasikumar Chandrasekaran   2017-01-10  6301  
64ff64b90e62c8 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-03-10  6302  	if (!instance->msix_vectors) {
fad119b707f8cc drivers/scsi/megaraid/megaraid_sas_base.c Hannes Reinecke            2016-12-02  6303  		i = pci_alloc_irq_vectors(instance->pdev, 1, 1, PCI_IRQ_LEGACY);
fad119b707f8cc drivers/scsi/megaraid/megaraid_sas_base.c Hannes Reinecke            2016-12-02  6304  		if (i < 0)
8a25fa17b6ed6e drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2018-10-16  6305  			goto fail_init_adapter;
64ff64b90e62c8 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-03-10  6306  	}
3f1abce4aba4ce drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2011-05-11  6307  
adbe552349f2d1 drivers/scsi/megaraid/megaraid_sas_base.c Ming Lei                   2018-03-13  6308  	megasas_setup_reply_map(instance);
adbe552349f2d1 drivers/scsi/megaraid/megaraid_sas_base.c Ming Lei                   2018-03-13  6309  
d3557fc8be11d2 drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@avagotech.com 2015-04-23  6310  	dev_info(&instance->pdev->dev,
d3557fc8be11d2 drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@avagotech.com 2015-04-23  6311  		"current msix/online cpus\t: (%d/%d)\n",
d3557fc8be11d2 drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@avagotech.com 2015-04-23  6312  		instance->msix_vectors, (unsigned int)num_online_cpus());
179ac14291a0e1 drivers/scsi/megaraid/megaraid_sas_base.c Sumit Saxena               2016-01-28  6313  	dev_info(&instance->pdev->dev,
179ac14291a0e1 drivers/scsi/megaraid/megaraid_sas_base.c Sumit Saxena               2016-01-28  6314  		"RDPQ mode\t: (%s)\n", instance->is_rdpq ? "enabled" : "disabled");
d3557fc8be11d2 drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@avagotech.com 2015-04-23  6315  
91626c2701acad drivers/scsi/megaraid/megaraid_sas_base.c sumit.saxena@avagotech.com 2015-10-15  6316  	tasklet_init(&instance->isr_tasklet, instance->instancet->tasklet,
91626c2701acad drivers/scsi/megaraid/megaraid_sas_base.c sumit.saxena@avagotech.com 2015-10-15  6317  		(unsigned long)instance);
91626c2701acad drivers/scsi/megaraid/megaraid_sas_base.c sumit.saxena@avagotech.com 2015-10-15  6318  
51087a8617fef1 drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@avagotech.com 2014-09-12  6319  	/*
51087a8617fef1 drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@avagotech.com 2014-09-12  6320  	 * Below are default value for legacy Firmware.
51087a8617fef1 drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@avagotech.com 2014-09-12  6321  	 * non-fusion based controllers
51087a8617fef1 drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@avagotech.com 2014-09-12  6322  	 */
51087a8617fef1 drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@avagotech.com 2014-09-12  6323  	instance->fw_supported_vd_count = MAX_LOGICAL_DRIVES;
51087a8617fef1 drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@avagotech.com 2014-09-12  6324  	instance->fw_supported_pd_count = MAX_PHYSICAL_DEVICES;
cd50ba8ede5cd3 drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2010-12-21  6325  	/* Get operational params, sge flags, send init cmd to controller */
cd50ba8ede5cd3 drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2010-12-21  6326  	if (instance->instancet->init_adapter(instance))
eb1b12377376e4 drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2011-02-24  6327  		goto fail_init_adapter;
cd50ba8ede5cd3 drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2010-12-21  6328  
630d42b70f5d5c drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2018-12-17  6329  	if (instance->adapter_type >= VENTURA_SERIES) {
81b7645223ea59 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2018-10-16  6330  		scratch_pad_3 =
272652fcbf1adf drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2018-12-17  6331  			megasas_readl(instance,
272652fcbf1adf drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2018-12-17  6332  				      &instance->reg_set->outbound_scratch_pad_3);
81b7645223ea59 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2018-10-16  6333  		if ((scratch_pad_3 & MR_NVME_PAGE_SIZE_MASK) >=
15dd03811d99dc drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-02-10  6334  			MR_DEFAULT_NVME_PAGE_SHIFT)
15dd03811d99dc drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-02-10  6335  			instance->nvme_page_size =
81b7645223ea59 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2018-10-16  6336  				(1 << (scratch_pad_3 & MR_NVME_PAGE_SIZE_MASK));
15dd03811d99dc drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-02-10  6337  
15dd03811d99dc drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-02-10  6338  		dev_info(&instance->pdev->dev,
15dd03811d99dc drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-02-10  6339  			 "NVME page size\t: (%d)\n", instance->nvme_page_size);
15dd03811d99dc drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-02-10  6340  	}
15dd03811d99dc drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-02-10  6341  
18103efcacee05 drivers/scsi/megaraid/megaraid_sas_base.c Tomas Henzl                2016-11-01  6342  	if (instance->msix_vectors ?
18103efcacee05 drivers/scsi/megaraid/megaraid_sas_base.c Tomas Henzl                2016-11-01  6343  		megasas_setup_irqs_msix(instance, 1) :
18103efcacee05 drivers/scsi/megaraid/megaraid_sas_base.c Tomas Henzl                2016-11-01  6344  		megasas_setup_irqs_ioapic(instance))
18103efcacee05 drivers/scsi/megaraid/megaraid_sas_base.c Tomas Henzl                2016-11-01  6345  		goto fail_init_adapter;
258c3af2b93094 drivers/scsi/megaraid/megaraid_sas_base.c Tomas Henzl                2015-06-02  6346  
62a04f81e6133c drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2019-05-07  6347  	if (instance->adapter_type != MFI_SERIES)
62a04f81e6133c drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2019-05-07  6348  		megasas_setup_irq_poll(instance);
62a04f81e6133c drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2019-05-07  6349  
d3557fc8be11d2 drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@avagotech.com 2015-04-23  6350  	instance->instancet->enable_intr(instance);
cd50ba8ede5cd3 drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2010-12-21  6351  
13f307711b127d drivers/scsi/megaraid/megaraid_sas_base.c Andy Lutomirski            2016-05-03  6352  	dev_info(&instance->pdev->dev, "INIT adapter done\n");
cd50ba8ede5cd3 drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2010-12-21  6353  
3761cb4cf65ec7 drivers/scsi/megaraid/megaraid_sas_base.c sumit.saxena@avagotech.com 2015-08-31  6354  	megasas_setup_jbod_map(instance);
3761cb4cf65ec7 drivers/scsi/megaraid/megaraid_sas_base.c sumit.saxena@avagotech.com 2015-08-31  6355  
daa0681118c9f4 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2019-01-29  6356  	if (megasas_get_device_list(instance) != SUCCESS) {
daa0681118c9f4 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2019-01-29  6357  		dev_err(&instance->pdev->dev,
daa0681118c9f4 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2019-01-29  6358  			"%s: megasas_get_device_list failed\n",
daa0681118c9f4 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2019-01-29  6359  			__func__);
72bff2d1d0c9cb drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-02-10  6360  		goto fail_get_ld_pd_list;
58968fc8fbb386 drivers/scsi/megaraid/megaraid_sas_base.c Hannes Reinecke            2014-01-16  6361  	}
81e403ce3c6a34 drivers/scsi/megaraid/megaraid_sas.c      Yang, Bo                   2009-10-06  6362  
fdd84e2514b015 drivers/scsi/megaraid/megaraid_sas_base.c Sasikumar Chandrasekaran   2017-01-10  6363  	/* stream detection initialization */
630d42b70f5d5c drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2018-12-17  6364  	if (instance->adapter_type >= VENTURA_SERIES) {
fdd84e2514b015 drivers/scsi/megaraid/megaraid_sas_base.c Sasikumar Chandrasekaran   2017-01-10  6365  		fusion->stream_detect_by_ld =
6396bb221514d2 drivers/scsi/megaraid/megaraid_sas_base.c Kees Cook                  2018-06-12  6366  			kcalloc(MAX_LOGICAL_DRIVES_EXT,
6396bb221514d2 drivers/scsi/megaraid/megaraid_sas_base.c Kees Cook                  2018-06-12  6367  				sizeof(struct LD_STREAM_DETECT *),
fdd84e2514b015 drivers/scsi/megaraid/megaraid_sas_base.c Sasikumar Chandrasekaran   2017-01-10  6368  				GFP_KERNEL);
fdd84e2514b015 drivers/scsi/megaraid/megaraid_sas_base.c Sasikumar Chandrasekaran   2017-01-10  6369  		if (!fusion->stream_detect_by_ld) {
fdd84e2514b015 drivers/scsi/megaraid/megaraid_sas_base.c Sasikumar Chandrasekaran   2017-01-10  6370  			dev_err(&instance->pdev->dev,
fdd84e2514b015 drivers/scsi/megaraid/megaraid_sas_base.c Sasikumar Chandrasekaran   2017-01-10  6371  				"unable to allocate stream detection for pool of LDs\n");
fdd84e2514b015 drivers/scsi/megaraid/megaraid_sas_base.c Sasikumar Chandrasekaran   2017-01-10  6372  			goto fail_get_ld_pd_list;
fdd84e2514b015 drivers/scsi/megaraid/megaraid_sas_base.c Sasikumar Chandrasekaran   2017-01-10  6373  		}
fdd84e2514b015 drivers/scsi/megaraid/megaraid_sas_base.c Sasikumar Chandrasekaran   2017-01-10  6374  		for (i = 0; i < MAX_LOGICAL_DRIVES_EXT; ++i) {
fdd84e2514b015 drivers/scsi/megaraid/megaraid_sas_base.c Sasikumar Chandrasekaran   2017-01-10  6375  			fusion->stream_detect_by_ld[i] =
e05ee4e986d173 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2018-01-05  6376  				kzalloc(sizeof(struct LD_STREAM_DETECT),
fdd84e2514b015 drivers/scsi/megaraid/megaraid_sas_base.c Sasikumar Chandrasekaran   2017-01-10  6377  				GFP_KERNEL);
fdd84e2514b015 drivers/scsi/megaraid/megaraid_sas_base.c Sasikumar Chandrasekaran   2017-01-10  6378  			if (!fusion->stream_detect_by_ld[i]) {
fdd84e2514b015 drivers/scsi/megaraid/megaraid_sas_base.c Sasikumar Chandrasekaran   2017-01-10  6379  				dev_err(&instance->pdev->dev,
fdd84e2514b015 drivers/scsi/megaraid/megaraid_sas_base.c Sasikumar Chandrasekaran   2017-01-10  6380  					"unable to allocate stream detect by LD\n ");
f256627cc789b2 drivers/scsi/megaraid/megaraid_sas_base.c Zhipeng Lu                 2024-01-17  6381  				goto fail_alloc_stream_detect;
fdd84e2514b015 drivers/scsi/megaraid/megaraid_sas_base.c Sasikumar Chandrasekaran   2017-01-10  6382  			}
fdd84e2514b015 drivers/scsi/megaraid/megaraid_sas_base.c Sasikumar Chandrasekaran   2017-01-10  6383  			fusion->stream_detect_by_ld[i]->mru_bit_map
fdd84e2514b015 drivers/scsi/megaraid/megaraid_sas_base.c Sasikumar Chandrasekaran   2017-01-10  6384  				= MR_STREAM_BITMAP;
fdd84e2514b015 drivers/scsi/megaraid/megaraid_sas_base.c Sasikumar Chandrasekaran   2017-01-10  6385  		}
fdd84e2514b015 drivers/scsi/megaraid/megaraid_sas_base.c Sasikumar Chandrasekaran   2017-01-10  6386  	}
fdd84e2514b015 drivers/scsi/megaraid/megaraid_sas_base.c Sasikumar Chandrasekaran   2017-01-10  6387  
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  6388  	/*
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  6389  	 * Compute the max allowed sectors per IO: The controller info has two
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  6390  	 * limits on max sectors. Driver should use the minimum of these two.
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  6391  	 *
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  6392  	 * 1 << stripe_sz_ops.min = max sectors per strip
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  6393  	 *
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  6394  	 * Note that older firmwares ( < FW ver 30) didn't report information
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  6395  	 * to calculate max_sectors_1. So the number ended up as zero always.
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  6396  	 */
14faea9f7fe1e8 drivers/scsi/megaraid/megaraid_sas.c      bo yang                    2007-11-09  6397  	tmp_sectors = 0;
9ad18a9c0c972b drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-10-19  6398  	ctrl_info = instance->ctrl_info_buf;
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  6399  
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  6400  	max_sectors_1 = (1 << ctrl_info->stripe_sz_ops.min) *
94cd65ddf4d70b drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@lsi.com       2013-09-06  6401  		le16_to_cpu(ctrl_info->max_strips_per_io);
94cd65ddf4d70b drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@lsi.com       2013-09-06  6402  	max_sectors_2 = le32_to_cpu(ctrl_info->max_request_size);
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  6403  
14faea9f7fe1e8 drivers/scsi/megaraid/megaraid_sas.c      bo yang                    2007-11-09  6404  	tmp_sectors = min_t(u32, max_sectors_1, max_sectors_2);
404a8a1a891e9e drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@lsi.com       2013-05-22  6405  
8f67c8c518f324 drivers/scsi/megaraid/megaraid_sas_base.c Sumit Saxena               2016-01-28  6406  	instance->peerIsPresent = ctrl_info->cluster.peerIsPresent;
8f67c8c518f324 drivers/scsi/megaraid/megaraid_sas_base.c Sumit Saxena               2016-01-28  6407  	instance->passive = ctrl_info->cluster.passive;
8f67c8c518f324 drivers/scsi/megaraid/megaraid_sas_base.c Sumit Saxena               2016-01-28  6408  	memcpy(instance->clusterId, ctrl_info->clusterId, sizeof(instance->clusterId));
bc93d425fcb644 drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@lsi.com       2013-05-22  6409  	instance->UnevenSpanSupport =
bc93d425fcb644 drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@lsi.com       2013-05-22  6410  		ctrl_info->adapterOperations2.supportUnevenSpans;
bc93d425fcb644 drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@lsi.com       2013-05-22  6411  	if (instance->UnevenSpanSupport) {
bc93d425fcb644 drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@lsi.com       2013-05-22  6412  		struct fusion_context *fusion = instance->ctrl_context;
5f19f7c879c4aa drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2018-01-05  6413  		if (MR_ValidateMapInfo(instance, instance->map_id))
bc93d425fcb644 drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@lsi.com       2013-05-22  6414  			fusion->fast_path_io = 1;
bc93d425fcb644 drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@lsi.com       2013-05-22  6415  		else
bc93d425fcb644 drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@lsi.com       2013-05-22  6416  			fusion->fast_path_io = 0;
bc93d425fcb644 drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@lsi.com       2013-05-22  6417  
bc93d425fcb644 drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@lsi.com       2013-05-22  6418  	}
229fe47cd046ef drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2014-03-10  6419  	if (ctrl_info->host_interface.SRIOV) {
92bb6505785b63 drivers/scsi/megaraid/megaraid_sas_base.c sumit.saxena@avagotech.com 2015-08-31  6420  		instance->requestorId = ctrl_info->iov.requestorId;
92bb6505785b63 drivers/scsi/megaraid/megaraid_sas_base.c sumit.saxena@avagotech.com 2015-08-31  6421  		if (instance->pdev->device == PCI_DEVICE_ID_LSI_PLASMA) {
229fe47cd046ef drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2014-03-10  6422  			if (!ctrl_info->adapterOperations2.activePassive)
229fe47cd046ef drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2014-03-10  6423  			    instance->PlasmaFW111 = 1;
229fe47cd046ef drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2014-03-10  6424  
92bb6505785b63 drivers/scsi/megaraid/megaraid_sas_base.c sumit.saxena@avagotech.com 2015-08-31  6425  			dev_info(&instance->pdev->dev, "SR-IOV: firmware type: %s\n",
92bb6505785b63 drivers/scsi/megaraid/megaraid_sas_base.c sumit.saxena@avagotech.com 2015-08-31  6426  			    instance->PlasmaFW111 ? "1.11" : "new");
92bb6505785b63 drivers/scsi/megaraid/megaraid_sas_base.c sumit.saxena@avagotech.com 2015-08-31  6427  
92bb6505785b63 drivers/scsi/megaraid/megaraid_sas_base.c sumit.saxena@avagotech.com 2015-08-31  6428  			if (instance->PlasmaFW111) {
92bb6505785b63 drivers/scsi/megaraid/megaraid_sas_base.c sumit.saxena@avagotech.com 2015-08-31  6429  			    iovPtr = (struct IOV_111 *)
92bb6505785b63 drivers/scsi/megaraid/megaraid_sas_base.c sumit.saxena@avagotech.com 2015-08-31  6430  				((unsigned char *)ctrl_info + IOV_111_OFFSET);
229fe47cd046ef drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2014-03-10  6431  			    instance->requestorId = iovPtr->requestorId;
229fe47cd046ef drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2014-03-10  6432  			}
92bb6505785b63 drivers/scsi/megaraid/megaraid_sas_base.c sumit.saxena@avagotech.com 2015-08-31  6433  		}
92bb6505785b63 drivers/scsi/megaraid/megaraid_sas_base.c sumit.saxena@avagotech.com 2015-08-31  6434  		dev_info(&instance->pdev->dev, "SRIOV: VF requestorId %d\n",
92bb6505785b63 drivers/scsi/megaraid/megaraid_sas_base.c sumit.saxena@avagotech.com 2015-08-31  6435  			instance->requestorId);
229fe47cd046ef drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2014-03-10  6436  	}
fc62b3fc902152 drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@avagotech.com 2014-09-12  6437  
fc62b3fc902152 drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@avagotech.com 2014-09-12  6438  	instance->crash_dump_fw_support =
fc62b3fc902152 drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@avagotech.com 2014-09-12  6439  		ctrl_info->adapterOperations3.supportCrashDump;
fc62b3fc902152 drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@avagotech.com 2014-09-12  6440  	instance->crash_dump_drv_support =
fc62b3fc902152 drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@avagotech.com 2014-09-12  6441  		(instance->crash_dump_fw_support &&
fc62b3fc902152 drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@avagotech.com 2014-09-12  6442  		instance->crash_dump_buf);
d88da09a538d3a drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@avagotech.com 2015-04-23  6443  	if (instance->crash_dump_drv_support)
fc62b3fc902152 drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@avagotech.com 2014-09-12  6444  		megasas_set_crash_dump_params(instance,
fc62b3fc902152 drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@avagotech.com 2014-09-12  6445  			MR_CRASH_BUF_TURN_OFF);
fc62b3fc902152 drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@avagotech.com 2014-09-12  6446  
d88da09a538d3a drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@avagotech.com 2015-04-23  6447  	else {
fc62b3fc902152 drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@avagotech.com 2014-09-12  6448  		if (instance->crash_dump_buf)
60ee6529511601 drivers/scsi/megaraid/megaraid_sas_base.c Christoph Hellwig          2018-10-10  6449  			dma_free_coherent(&instance->pdev->dev,
fc62b3fc902152 drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@avagotech.com 2014-09-12  6450  				CRASH_DMA_BUF_SIZE,
fc62b3fc902152 drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@avagotech.com 2014-09-12  6451  				instance->crash_dump_buf,
fc62b3fc902152 drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@avagotech.com 2014-09-12  6452  				instance->crash_dump_h);
fc62b3fc902152 drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@avagotech.com 2014-09-12  6453  		instance->crash_dump_buf = NULL;
fc62b3fc902152 drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@avagotech.com 2014-09-12  6454  	}
7497cde883b184 drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@avagotech.com 2015-01-05  6455  
f0c21df6528601 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2018-10-16  6456  	if (instance->snapdump_wait_time) {
f0c21df6528601 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2018-10-16  6457  		megasas_get_snapdump_properties(instance);
f0c21df6528601 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2018-10-16  6458  		dev_info(&instance->pdev->dev, "Snap dump wait time\t: %d\n",
f0c21df6528601 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2018-10-16  6459  			 instance->snapdump_wait_time);
f0c21df6528601 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2018-10-16  6460  	}
d88da09a538d3a drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@avagotech.com 2015-04-23  6461  
d88da09a538d3a drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@avagotech.com 2015-04-23  6462  	dev_info(&instance->pdev->dev,
d88da09a538d3a drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@avagotech.com 2015-04-23  6463  		"pci id\t\t: (0x%04x)/(0x%04x)/(0x%04x)/(0x%04x)\n",
d88da09a538d3a drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@avagotech.com 2015-04-23  6464  		le16_to_cpu(ctrl_info->pci.vendor_id),
d88da09a538d3a drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@avagotech.com 2015-04-23  6465  		le16_to_cpu(ctrl_info->pci.device_id),
d88da09a538d3a drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@avagotech.com 2015-04-23  6466  		le16_to_cpu(ctrl_info->pci.sub_vendor_id),
d88da09a538d3a drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@avagotech.com 2015-04-23  6467  		le16_to_cpu(ctrl_info->pci.sub_device_id));
d88da09a538d3a drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@avagotech.com 2015-04-23  6468  	dev_info(&instance->pdev->dev, "unevenspan support	: %s\n",
d88da09a538d3a drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@avagotech.com 2015-04-23  6469  		instance->UnevenSpanSupport ? "yes" : "no");
d88da09a538d3a drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@avagotech.com 2015-04-23  6470  	dev_info(&instance->pdev->dev, "firmware crash dump	: %s\n",
d88da09a538d3a drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@avagotech.com 2015-04-23  6471  		instance->crash_dump_drv_support ? "yes" : "no");
59db5a931bbe73 drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6472  	dev_info(&instance->pdev->dev, "JBOD sequence map	: %s\n",
59db5a931bbe73 drivers/scsi/megaraid/megaraid_sas_base.c Chandrakanth Patil         2019-06-25  6473  		instance->use_seqnum_jbod_fp ? "enabled" : "disabled");
d88da09a538d3a drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@avagotech.com 2015-04-23  6474  
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  6475  	instance->max_sectors_per_req = instance->max_num_sge *
357ae967ad66e3 drivers/scsi/megaraid/megaraid_sas_base.c sumit.saxena@avagotech.com 2015-10-15  6476  						SGE_BUFFER_SIZE / 512;
14faea9f7fe1e8 drivers/scsi/megaraid/megaraid_sas.c      bo yang                    2007-11-09  6477  	if (tmp_sectors && (instance->max_sectors_per_req > tmp_sectors))
14faea9f7fe1e8 drivers/scsi/megaraid/megaraid_sas.c      bo yang                    2007-11-09  6478  		instance->max_sectors_per_req = tmp_sectors;
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  6479  
c5daa6a91984a2 drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2012-07-17  6480  	/* Check for valid throttlequeuedepth module parameter */
ae09a6c1fd4218 drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@avagotech.com 2015-01-05  6481  	if (throttlequeuedepth &&
ae09a6c1fd4218 drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@avagotech.com 2015-01-05  6482  			throttlequeuedepth <= instance->max_scsi_cmds)
c5daa6a91984a2 drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2012-07-17  6483  		instance->throttlequeuedepth = throttlequeuedepth;
ae09a6c1fd4218 drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@avagotech.com 2015-01-05  6484  	else
c5daa6a91984a2 drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2012-07-17  6485  		instance->throttlequeuedepth =
c5daa6a91984a2 drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2012-07-17  6486  				MEGASAS_THROTTLE_QUEUE_DEPTH;
c5daa6a91984a2 drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2012-07-17  6487  
e636a7a430f41e drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-08-23  6488  	if ((resetwaittime < 1) ||
e636a7a430f41e drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-08-23  6489  	    (resetwaittime > MEGASAS_RESET_WAIT_TIME))
e3d178ca773ff9 drivers/scsi/megaraid/megaraid_sas_base.c Sumit Saxena               2016-01-28  6490  		resetwaittime = MEGASAS_RESET_WAIT_TIME;
e3d178ca773ff9 drivers/scsi/megaraid/megaraid_sas_base.c Sumit Saxena               2016-01-28  6491  
e3d178ca773ff9 drivers/scsi/megaraid/megaraid_sas_base.c Sumit Saxena               2016-01-28  6492  	if ((scmd_timeout < 10) || (scmd_timeout > MEGASAS_DEFAULT_CMD_TIMEOUT))
e3d178ca773ff9 drivers/scsi/megaraid/megaraid_sas_base.c Sumit Saxena               2016-01-28  6493  		scmd_timeout = MEGASAS_DEFAULT_CMD_TIMEOUT;
ad84db2e2e1817 drivers/scsi/megaraid/megaraid_sas.c      bo yang                    2007-11-09  6494  
229fe47cd046ef drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2014-03-10  6495  	/* Launch SR-IOV heartbeat timer */
229fe47cd046ef drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2014-03-10  6496  	if (instance->requestorId) {
2e47e4e62e4033 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2018-10-16  6497  		if (!megasas_sriov_start_heartbeat(instance, 1)) {
c251a7be46b0ee drivers/scsi/megaraid/megaraid_sas_base.c Kees Cook                  2017-10-22  6498  			megasas_start_timer(instance);
2e47e4e62e4033 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2018-10-16  6499  		} else {
229fe47cd046ef drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2014-03-10  6500  			instance->skip_heartbeat_timer_del = 1;
f256627cc789b2 drivers/scsi/megaraid/megaraid_sas_base.c Zhipeng Lu                 2024-01-17  6501  			goto fail_alloc_stream_detect;
2e47e4e62e4033 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2018-10-16  6502  		}
229fe47cd046ef drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2014-03-10  6503  	}
229fe47cd046ef drivers/scsi/megaraid/megaraid_sas_base.c Adam Radford               2014-03-10  6504  
3f6194af539464 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2018-10-16  6505  	/*
3f6194af539464 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2018-10-16  6506  	 * Create and start watchdog thread which will monitor
3f6194af539464 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2018-10-16  6507  	 * controller state every 1 sec and trigger OCR when
3f6194af539464 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2018-10-16  6508  	 * it enters fault state
3f6194af539464 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2018-10-16  6509  	 */
3f6194af539464 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2018-10-16  6510  	if (instance->adapter_type != MFI_SERIES)
3f6194af539464 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2018-10-16  6511  		if (megasas_fusion_start_watchdog(instance) != SUCCESS)
3f6194af539464 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2018-10-16  6512  			goto fail_start_watchdog;
3f6194af539464 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2018-10-16  6513  
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  6514  	return 0;
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  6515  
3f6194af539464 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2018-10-16  6516  fail_start_watchdog:
3f6194af539464 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2018-10-16  6517  	if (instance->requestorId && !instance->skip_heartbeat_timer_del)
3f6194af539464 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2018-10-16  6518  		del_timer_sync(&instance->sriov_heartbeat_timer);
f256627cc789b2 drivers/scsi/megaraid/megaraid_sas_base.c Zhipeng Lu                 2024-01-17  6519  fail_alloc_stream_detect:
f256627cc789b2 drivers/scsi/megaraid/megaraid_sas_base.c Zhipeng Lu                 2024-01-17  6520  	if (instance->adapter_type >= VENTURA_SERIES) {
f256627cc789b2 drivers/scsi/megaraid/megaraid_sas_base.c Zhipeng Lu                 2024-01-17  6521  		for (i = 0; i < MAX_LOGICAL_DRIVES_EXT; ++i)
f256627cc789b2 drivers/scsi/megaraid/megaraid_sas_base.c Zhipeng Lu                 2024-01-17  6522  			kfree(fusion->stream_detect_by_ld[i]);
f256627cc789b2 drivers/scsi/megaraid/megaraid_sas_base.c Zhipeng Lu                 2024-01-17  6523  		kfree(fusion->stream_detect_by_ld);
f256627cc789b2 drivers/scsi/megaraid/megaraid_sas_base.c Zhipeng Lu                 2024-01-17  6524  		fusion->stream_detect_by_ld = NULL;
f256627cc789b2 drivers/scsi/megaraid/megaraid_sas_base.c Zhipeng Lu                 2024-01-17  6525  	}
fdd84e2514b015 drivers/scsi/megaraid/megaraid_sas_base.c Sasikumar Chandrasekaran   2017-01-10  6526  fail_get_ld_pd_list:
fdd84e2514b015 drivers/scsi/megaraid/megaraid_sas_base.c Sasikumar Chandrasekaran   2017-01-10  6527  	instance->instancet->disable_intr(instance);
fad119b707f8cc drivers/scsi/megaraid/megaraid_sas_base.c Hannes Reinecke            2016-12-02  6528  	megasas_destroy_irqs(instance);
8a25fa17b6ed6e drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2018-10-16  6529  fail_init_adapter:
d3557fc8be11d2 drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@avagotech.com 2015-04-23  6530  	if (instance->msix_vectors)
fad119b707f8cc drivers/scsi/megaraid/megaraid_sas_base.c Hannes Reinecke            2016-12-02  6531  		pci_free_irq_vectors(instance->pdev);
d3557fc8be11d2 drivers/scsi/megaraid/megaraid_sas_base.c Sumit.Saxena@avagotech.com 2015-04-23  6532  	instance->msix_vectors = 0;
e5d65b4b81af41 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-10-19  6533  fail_alloc_dma_buf:
e5d65b4b81af41 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-10-19  6534  	megasas_free_ctrl_dma_buffers(instance);
e5d65b4b81af41 drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-10-19  6535  	megasas_free_ctrl_mem(instance);
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  6536  fail_ready_state:
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  6537  	iounmap(instance->reg_set);
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  6538  
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  6539  fail_ioremap:
e7f851684efb33 drivers/scsi/megaraid/megaraid_sas_base.c Yinghai Lu                 2016-08-05  6540  	pci_release_selected_regions(instance->pdev, 1<<instance->bar);
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  6541  
72bff2d1d0c9cb drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-02-10  6542  	dev_err(&instance->pdev->dev, "Failed from %s %d\n",
72bff2d1d0c9cb drivers/scsi/megaraid/megaraid_sas_base.c Shivasharan S              2017-02-10  6543  		__func__, __LINE__);
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  6544  	return -EINVAL;
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  6545  }
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  6546  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

