Return-Path: <linux-kernel+bounces-4436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49138817D13
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 23:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9D101F21F27
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 22:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FDC74E01;
	Mon, 18 Dec 2023 22:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jBwsrhjU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A18D740B0
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 22:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702936944; x=1734472944;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/ZUA6UXCPBEuMtS5q5bfk/WmO/rGvpCr2EjyKhA7Biw=;
  b=jBwsrhjU9nFv3GhgIRbH5TLzsqL5UCEx8VwRV1rC2SRoOLmwfumSU9fh
   a6KvsObcvcOryQuVAin2zKmiy7YBsoVPmj7G+71GpxKOoA+W9FzksUMjk
   se5uapW7PRJyO9Wfe5CQ/vyTkgVu3qYOK3uCO5Qf0MiYjLVzvDTosgs89
   RkkhIPFrAXic4A5hZpU46jy0NQ1Ymku89WOyQ60hO0ADabv8smzJxisul
   wq4X2ePmMG+qv8OzJc6bB5DQ5OmAefHSbtAOTeWPvFzh+3UO/9b6CpXTT
   gOF5krdLEoTzzCuVn2FW8a9ejBeSokZp3fXm1ePRwtxNOZ9cMOvJ/HBqj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="2790636"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="2790636"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 14:02:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="725488195"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="725488195"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 18 Dec 2023 14:02:21 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rFLgp-0004aB-02;
	Mon, 18 Dec 2023 22:02:19 +0000
Date: Tue, 19 Dec 2023 06:01:31 +0800
From: kernel test robot <lkp@intel.com>
To: Heiko Stuebner <heiko.stuebner@vrull.eu>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: drivers/scsi/qedi/qedi_debugfs.c:109:45: sparse: sparse: incorrect
 type in argument 2 (different address spaces)
Message-ID: <202312190535.sXcZRYU4-lkp@intel.com>
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
commit: 56e0790c7f9e59ba6a0f4b59981d1d6fbf43efb0 RISC-V: add infrastructure to allow different str* implementations
date:   11 months ago
config: riscv-randconfig-r133-20231218 (https://download.01.org/0day-ci/archive/20231219/202312190535.sXcZRYU4-lkp@intel.com/config)
compiler: clang version 18.0.0git (https://github.com/llvm/llvm-project 5ac12951b4e9bbfcc5791282d0961ec2b65575e9)
reproduce: (https://download.01.org/0day-ci/archive/20231219/202312190535.sXcZRYU4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312190535.sXcZRYU4-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   WARNING: invalid argument to '-march': '_zicbom_zihintpause'
>> drivers/scsi/qedi/qedi_debugfs.c:109:45: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected char const *ct @@     got char const [noderef] __user *buffer @@
   drivers/scsi/qedi/qedi_debugfs.c:109:45: sparse:     expected char const *ct
   drivers/scsi/qedi/qedi_debugfs.c:109:45: sparse:     got char const [noderef] __user *buffer
   drivers/scsi/qedi/qedi_debugfs.c:128:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected char *buf @@     got char [noderef] __user *buffer @@
   drivers/scsi/qedi/qedi_debugfs.c:128:23: sparse:     expected char *buf
   drivers/scsi/qedi/qedi_debugfs.c:128:23: sparse:     got char [noderef] __user *buffer
   drivers/scsi/qedi/qedi_debugfs.c:154:41: sparse: sparse: restricted __le16 degrades to integer

vim +109 drivers/scsi/qedi/qedi_debugfs.c

ace7f46ba5fde72 Manish Rangankar   2016-12-01   13  
bd571195c9535c0 Arnd Bergmann      2017-03-02  @14  int qedi_do_not_recover;
ace7f46ba5fde72 Manish Rangankar   2016-12-01   15  static struct dentry *qedi_dbg_root;
ace7f46ba5fde72 Manish Rangankar   2016-12-01   16  
ace7f46ba5fde72 Manish Rangankar   2016-12-01   17  void
ace7f46ba5fde72 Manish Rangankar   2016-12-01   18  qedi_dbg_host_init(struct qedi_dbg_ctx *qedi,
779936faf4f1210 Arnd Bergmann      2018-02-02   19  		   const struct qedi_debugfs_ops *dops,
ace7f46ba5fde72 Manish Rangankar   2016-12-01   20  		   const struct file_operations *fops)
ace7f46ba5fde72 Manish Rangankar   2016-12-01   21  {
ace7f46ba5fde72 Manish Rangankar   2016-12-01   22  	char host_dirname[32];
ace7f46ba5fde72 Manish Rangankar   2016-12-01   23  
ace7f46ba5fde72 Manish Rangankar   2016-12-01   24  	sprintf(host_dirname, "host%u", qedi->host_no);
ace7f46ba5fde72 Manish Rangankar   2016-12-01   25  	qedi->bdf_dentry = debugfs_create_dir(host_dirname, qedi_dbg_root);
ace7f46ba5fde72 Manish Rangankar   2016-12-01   26  
ace7f46ba5fde72 Manish Rangankar   2016-12-01   27  	while (dops) {
ace7f46ba5fde72 Manish Rangankar   2016-12-01   28  		if (!(dops->name))
ace7f46ba5fde72 Manish Rangankar   2016-12-01   29  			break;
ace7f46ba5fde72 Manish Rangankar   2016-12-01   30  
26febfb38c7d679 Greg Kroah-Hartman 2019-01-22   31  		debugfs_create_file(dops->name, 0600, qedi->bdf_dentry, qedi,
ace7f46ba5fde72 Manish Rangankar   2016-12-01   32  				    fops);
ace7f46ba5fde72 Manish Rangankar   2016-12-01   33  		dops++;
ace7f46ba5fde72 Manish Rangankar   2016-12-01   34  		fops++;
ace7f46ba5fde72 Manish Rangankar   2016-12-01   35  	}
ace7f46ba5fde72 Manish Rangankar   2016-12-01   36  }
ace7f46ba5fde72 Manish Rangankar   2016-12-01   37  
ace7f46ba5fde72 Manish Rangankar   2016-12-01   38  void
ace7f46ba5fde72 Manish Rangankar   2016-12-01   39  qedi_dbg_host_exit(struct qedi_dbg_ctx *qedi)
ace7f46ba5fde72 Manish Rangankar   2016-12-01   40  {
ace7f46ba5fde72 Manish Rangankar   2016-12-01   41  	debugfs_remove_recursive(qedi->bdf_dentry);
ace7f46ba5fde72 Manish Rangankar   2016-12-01   42  	qedi->bdf_dentry = NULL;
ace7f46ba5fde72 Manish Rangankar   2016-12-01   43  }
ace7f46ba5fde72 Manish Rangankar   2016-12-01   44  
ace7f46ba5fde72 Manish Rangankar   2016-12-01   45  void
ace7f46ba5fde72 Manish Rangankar   2016-12-01   46  qedi_dbg_init(char *drv_name)
ace7f46ba5fde72 Manish Rangankar   2016-12-01   47  {
ace7f46ba5fde72 Manish Rangankar   2016-12-01   48  	qedi_dbg_root = debugfs_create_dir(drv_name, NULL);
ace7f46ba5fde72 Manish Rangankar   2016-12-01   49  }
ace7f46ba5fde72 Manish Rangankar   2016-12-01   50  
ace7f46ba5fde72 Manish Rangankar   2016-12-01   51  void
ace7f46ba5fde72 Manish Rangankar   2016-12-01   52  qedi_dbg_exit(void)
ace7f46ba5fde72 Manish Rangankar   2016-12-01   53  {
ace7f46ba5fde72 Manish Rangankar   2016-12-01   54  	debugfs_remove_recursive(qedi_dbg_root);
ace7f46ba5fde72 Manish Rangankar   2016-12-01   55  	qedi_dbg_root = NULL;
ace7f46ba5fde72 Manish Rangankar   2016-12-01   56  }
ace7f46ba5fde72 Manish Rangankar   2016-12-01   57  
ace7f46ba5fde72 Manish Rangankar   2016-12-01   58  static ssize_t
ace7f46ba5fde72 Manish Rangankar   2016-12-01   59  qedi_dbg_do_not_recover_enable(struct qedi_dbg_ctx *qedi_dbg)
ace7f46ba5fde72 Manish Rangankar   2016-12-01   60  {
bd571195c9535c0 Arnd Bergmann      2017-03-02   61  	if (!qedi_do_not_recover)
bd571195c9535c0 Arnd Bergmann      2017-03-02   62  		qedi_do_not_recover = 1;
ace7f46ba5fde72 Manish Rangankar   2016-12-01   63  
ace7f46ba5fde72 Manish Rangankar   2016-12-01   64  	QEDI_INFO(qedi_dbg, QEDI_LOG_DEBUGFS, "do_not_recover=%d\n",
bd571195c9535c0 Arnd Bergmann      2017-03-02   65  		  qedi_do_not_recover);
ace7f46ba5fde72 Manish Rangankar   2016-12-01   66  	return 0;
ace7f46ba5fde72 Manish Rangankar   2016-12-01   67  }
ace7f46ba5fde72 Manish Rangankar   2016-12-01   68  
ace7f46ba5fde72 Manish Rangankar   2016-12-01   69  static ssize_t
ace7f46ba5fde72 Manish Rangankar   2016-12-01   70  qedi_dbg_do_not_recover_disable(struct qedi_dbg_ctx *qedi_dbg)
ace7f46ba5fde72 Manish Rangankar   2016-12-01   71  {
bd571195c9535c0 Arnd Bergmann      2017-03-02   72  	if (qedi_do_not_recover)
bd571195c9535c0 Arnd Bergmann      2017-03-02   73  		qedi_do_not_recover = 0;
ace7f46ba5fde72 Manish Rangankar   2016-12-01   74  
ace7f46ba5fde72 Manish Rangankar   2016-12-01   75  	QEDI_INFO(qedi_dbg, QEDI_LOG_DEBUGFS, "do_not_recover=%d\n",
bd571195c9535c0 Arnd Bergmann      2017-03-02   76  		  qedi_do_not_recover);
ace7f46ba5fde72 Manish Rangankar   2016-12-01   77  	return 0;
ace7f46ba5fde72 Manish Rangankar   2016-12-01   78  }
ace7f46ba5fde72 Manish Rangankar   2016-12-01   79  
ace7f46ba5fde72 Manish Rangankar   2016-12-01   80  static struct qedi_list_of_funcs qedi_dbg_do_not_recover_ops[] = {
ace7f46ba5fde72 Manish Rangankar   2016-12-01   81  	{ "enable", qedi_dbg_do_not_recover_enable },
ace7f46ba5fde72 Manish Rangankar   2016-12-01   82  	{ "disable", qedi_dbg_do_not_recover_disable },
ace7f46ba5fde72 Manish Rangankar   2016-12-01   83  	{ NULL, NULL }
ace7f46ba5fde72 Manish Rangankar   2016-12-01   84  };
ace7f46ba5fde72 Manish Rangankar   2016-12-01   85  
779936faf4f1210 Arnd Bergmann      2018-02-02   86  const struct qedi_debugfs_ops qedi_debugfs_ops[] = {
ace7f46ba5fde72 Manish Rangankar   2016-12-01   87  	{ "gbl_ctx", NULL },
ace7f46ba5fde72 Manish Rangankar   2016-12-01   88  	{ "do_not_recover", qedi_dbg_do_not_recover_ops},
ace7f46ba5fde72 Manish Rangankar   2016-12-01   89  	{ "io_trace", NULL },
ace7f46ba5fde72 Manish Rangankar   2016-12-01   90  	{ NULL, NULL }
ace7f46ba5fde72 Manish Rangankar   2016-12-01   91  };
ace7f46ba5fde72 Manish Rangankar   2016-12-01   92  
ace7f46ba5fde72 Manish Rangankar   2016-12-01   93  static ssize_t
ace7f46ba5fde72 Manish Rangankar   2016-12-01   94  qedi_dbg_do_not_recover_cmd_write(struct file *filp, const char __user *buffer,
ace7f46ba5fde72 Manish Rangankar   2016-12-01   95  				  size_t count, loff_t *ppos)
ace7f46ba5fde72 Manish Rangankar   2016-12-01   96  {
ace7f46ba5fde72 Manish Rangankar   2016-12-01   97  	size_t cnt = 0;
ace7f46ba5fde72 Manish Rangankar   2016-12-01   98  	struct qedi_dbg_ctx *qedi_dbg =
ace7f46ba5fde72 Manish Rangankar   2016-12-01   99  			(struct qedi_dbg_ctx *)filp->private_data;
ace7f46ba5fde72 Manish Rangankar   2016-12-01  100  	struct qedi_list_of_funcs *lof = qedi_dbg_do_not_recover_ops;
ace7f46ba5fde72 Manish Rangankar   2016-12-01  101  
ace7f46ba5fde72 Manish Rangankar   2016-12-01  102  	if (*ppos)
ace7f46ba5fde72 Manish Rangankar   2016-12-01  103  		return 0;
ace7f46ba5fde72 Manish Rangankar   2016-12-01  104  
ace7f46ba5fde72 Manish Rangankar   2016-12-01  105  	while (lof) {
ace7f46ba5fde72 Manish Rangankar   2016-12-01  106  		if (!(lof->oper_str))
ace7f46ba5fde72 Manish Rangankar   2016-12-01  107  			break;
ace7f46ba5fde72 Manish Rangankar   2016-12-01  108  
ace7f46ba5fde72 Manish Rangankar   2016-12-01 @109  		if (!strncmp(lof->oper_str, buffer, strlen(lof->oper_str))) {
ace7f46ba5fde72 Manish Rangankar   2016-12-01  110  			cnt = lof->oper_func(qedi_dbg);
ace7f46ba5fde72 Manish Rangankar   2016-12-01  111  			break;
ace7f46ba5fde72 Manish Rangankar   2016-12-01  112  		}
ace7f46ba5fde72 Manish Rangankar   2016-12-01  113  
ace7f46ba5fde72 Manish Rangankar   2016-12-01  114  		lof++;
ace7f46ba5fde72 Manish Rangankar   2016-12-01  115  	}
ace7f46ba5fde72 Manish Rangankar   2016-12-01  116  	return (count - cnt);
ace7f46ba5fde72 Manish Rangankar   2016-12-01  117  }
ace7f46ba5fde72 Manish Rangankar   2016-12-01  118  

:::::: The code at line 109 was first introduced by commit
:::::: ace7f46ba5fde7273207c7122b0650ceb72510e0 scsi: qedi: Add QLogic FastLinQ offload iSCSI driver framework.

:::::: TO: Manish Rangankar <manish.rangankar@cavium.com>
:::::: CC: Martin K. Petersen <martin.petersen@oracle.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

