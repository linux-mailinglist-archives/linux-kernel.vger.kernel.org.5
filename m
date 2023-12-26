Return-Path: <linux-kernel+bounces-11379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D86181E558
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 06:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24B2B281EF8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 05:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1684BA90;
	Tue, 26 Dec 2023 05:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GDdulIet"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A79D4B5C1
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 05:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703570207; x=1735106207;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1HHODoJLDGgClCZEYNcjY0OHgtEKrG3SAXnDAkTiUiI=;
  b=GDdulIetfK7WDcuaNT6PIgiSlTmQrFXJbssTlAPzblPeflssjsterXFr
   qa7oz7UuZOC17HXTVyXwS/J4z9p3UGmbYNJaY0j2pCc6MdoOBKBS/WekP
   szbnQH58448w0YaeaezPPZla+G4f7bpjwokN7HXjOnCt9RMve+u37uNZg
   kQSlS6Xv3ui8ZTU/qnLCDu+C438cgildtBKrWqUHy98nOkNWkmGeI9WvN
   qluyWSEj+jZ5H9Z+vUCVkABDnkKZXWKckasU2Yvr4/98pinV0RILXY9ZW
   Mtg5xTH8ETgBNlfX0P1wX3FJ6+aJ+sOuWIQuuzcIVHVP2SHcTbkV0IKey
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="3407623"
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="3407623"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2023 21:56:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="19578555"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 25 Dec 2023 21:56:45 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rI0Qk-000E7M-2s;
	Tue, 26 Dec 2023 05:56:42 +0000
Date: Tue, 26 Dec 2023 13:56:23 +0800
From: kernel test robot <lkp@intel.com>
To: Dragan Cvetic <dragan.cvetic@xilinx.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Derek Kiernan <derek.kiernan@xilinx.com>
Subject: drivers/misc/xilinx_sdfec.c:92:57: warning: '%d' directive output
 may be truncated writing between 1 and 10 bytes into a region of size 6
Message-ID: <202312261345.5icSobz6-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fbafc3e621c3f4ded43720fdb1d6ce1728ec664e
commit: 76d83e1c32334a793e50de6f955c2eefcc60bb8e misc: xilinx-sdfec: add core driver
date:   4 years, 6 months ago
config: sparc64-randconfig-r025-20230806 (https://download.01.org/0day-ci/archive/20231226/202312261345.5icSobz6-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20231226/202312261345.5icSobz6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312261345.5icSobz6-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/misc/xilinx_sdfec.c: In function 'xsdfec_probe':
>> drivers/misc/xilinx_sdfec.c:92:57: warning: '%d' directive output may be truncated writing between 1 and 10 bytes into a region of size 6 [-Wformat-truncation=]
      92 |         snprintf(xsdfec->dev_name, DEV_NAME_LEN, "xsdfec%d", xsdfec->dev_id);
         |                                                         ^~
   drivers/misc/xilinx_sdfec.c:92:50: note: directive argument in the range [0, 2147483647]
      92 |         snprintf(xsdfec->dev_name, DEV_NAME_LEN, "xsdfec%d", xsdfec->dev_id);
         |                                                  ^~~~~~~~~~
   drivers/misc/xilinx_sdfec.c:92:9: note: 'snprintf' output between 8 and 17 bytes into a destination of size 12
      92 |         snprintf(xsdfec->dev_name, DEV_NAME_LEN, "xsdfec%d", xsdfec->dev_id);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for COMPAT_BINFMT_ELF
   Depends on [n]: COMPAT [=y] && BINFMT_ELF [=n]
   Selected by [y]:
   - COMPAT [=y] && SPARC64 [=y]


vim +92 drivers/misc/xilinx_sdfec.c

    59	
    60	static int xsdfec_probe(struct platform_device *pdev)
    61	{
    62		struct xsdfec_dev *xsdfec;
    63		struct device *dev;
    64		struct resource *res;
    65		int err;
    66	
    67		xsdfec = devm_kzalloc(&pdev->dev, sizeof(*xsdfec), GFP_KERNEL);
    68		if (!xsdfec)
    69			return -ENOMEM;
    70	
    71		xsdfec->dev = &pdev->dev;
    72		spin_lock_init(&xsdfec->error_data_lock);
    73	
    74		dev = xsdfec->dev;
    75		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
    76		xsdfec->regs = devm_ioremap_resource(dev, res);
    77		if (IS_ERR(xsdfec->regs)) {
    78			err = PTR_ERR(xsdfec->regs);
    79			return err;
    80		}
    81	
    82		/* Save driver private data */
    83		platform_set_drvdata(pdev, xsdfec);
    84	
    85		mutex_lock(&dev_idr_lock);
    86		err = idr_alloc(&dev_idr, xsdfec->dev_name, 0, 0, GFP_KERNEL);
    87		mutex_unlock(&dev_idr_lock);
    88		if (err < 0)
    89			goto err_xsddev_idr;
    90		xsdfec->dev_id = err;
    91	
  > 92		snprintf(xsdfec->dev_name, DEV_NAME_LEN, "xsdfec%d", xsdfec->dev_id);
    93		xsdfec->miscdev.minor = MISC_DYNAMIC_MINOR;
    94		xsdfec->miscdev.name = xsdfec->dev_name;
    95		xsdfec->miscdev.fops = &xsdfec_fops;
    96		xsdfec->miscdev.parent = dev;
    97		err = misc_register(&xsdfec->miscdev);
    98		if (err) {
    99			dev_err(dev, "error:%d. Unable to register device", err);
   100			return err;
   101		}
   102		return 0;
   103	
   104	err_xsddev_idr:
   105		xsdfec_idr_remove(xsdfec);
   106	
   107		return err;
   108	}
   109	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

