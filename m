Return-Path: <linux-kernel+bounces-21996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 241818297A2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFB11289D2D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F078D3FE2F;
	Wed, 10 Jan 2024 10:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dnVn92wl"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11231481A2
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 10:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704882456; x=1736418456;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=w3UfH/E0Wkb7H3FEj0d6n/toU9zc9ZUDXjEFbTfBd1c=;
  b=dnVn92wlDaXddk4SkVqbdA8Mw6JyWkcKiOtv1O0z743UN5p9IJ2cP8kn
   S6zSDf6W9hbDxcrsdsABaOT1QgOR4FJqkjvxThWI3zD5XAscsqLb2o424
   JK10IlTCMWS8HdbYXGWg4Tmd/sif1tM3kdvgkLWFNMvSEb3EpBAMBVt1E
   lcmNWsWDxgVbeq+oSVNhxNoRj8BKBbj1eRfUWCp8d+lxY9QmdubaGVUdO
   l2panYU5GCUC+xzVJ82lF9LLg/AI3GrB+34+IXuo9H9tX9OeKNq/j8ult
   0mV8XYTQA9lAy/Y3kGSveYITkXkGTeN0O3Dz/+uWsK2sk0bkxe85jOjgY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="5841546"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="5841546"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 02:27:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="872579009"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="872579009"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Jan 2024 02:27:33 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rNVo3-0006sg-1i;
	Wed, 10 Jan 2024 10:27:31 +0000
Date: Wed, 10 Jan 2024 18:27:31 +0800
From: kernel test robot <lkp@intel.com>
To: Tejas Joglekar <Tejas.Joglekar@synopsys.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: drivers/usb/host/xhci.c:1414: warning: Function parameter or member
 'desc' not described in 'xhci_get_endpoint_index'
Message-ID: <202401101820.I1t9z9cv-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ab27740f76654ed58dd32ac0ba0031c18a6dea3b
commit: 2017a1e58472a27e532b9644b4a61dfe18f6baac usb: xhci: Use temporary buffer to consolidate SG
date:   3 years, 1 month ago
config: x86_64-buildonly-randconfig-006-20240105 (https://download.01.org/0day-ci/archive/20240110/202401101820.I1t9z9cv-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240110/202401101820.I1t9z9cv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401101820.I1t9z9cv-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/usb/host/xhci.c:1414: warning: Function parameter or member 'desc' not described in 'xhci_get_endpoint_index'


vim +1414 drivers/usb/host/xhci.c

2017a1e58472a2 drivers/usb/host/xhci.c     Tejas Joglekar 2020-12-08  1402  
2017a1e58472a2 drivers/usb/host/xhci.c     Tejas Joglekar 2020-12-08  1403  /**
d0e96f5a71a032 drivers/usb/host/xhci-hcd.c Sarah Sharp    2009-04-27  1404   * xhci_get_endpoint_index - Used for passing endpoint bitmasks between the core and
d0e96f5a71a032 drivers/usb/host/xhci-hcd.c Sarah Sharp    2009-04-27  1405   * HCDs.  Find the index for an endpoint given its descriptor.  Use the return
d0e96f5a71a032 drivers/usb/host/xhci-hcd.c Sarah Sharp    2009-04-27  1406   * value to right shift 1 for the bitmask.
d0e96f5a71a032 drivers/usb/host/xhci-hcd.c Sarah Sharp    2009-04-27  1407   *
d0e96f5a71a032 drivers/usb/host/xhci-hcd.c Sarah Sharp    2009-04-27  1408   * Index  = (epnum * 2) + direction - 1,
d0e96f5a71a032 drivers/usb/host/xhci-hcd.c Sarah Sharp    2009-04-27  1409   * where direction = 0 for OUT, 1 for IN.
d0e96f5a71a032 drivers/usb/host/xhci-hcd.c Sarah Sharp    2009-04-27  1410   * For control endpoints, the IN index is used (OUT index is unused), so
d0e96f5a71a032 drivers/usb/host/xhci-hcd.c Sarah Sharp    2009-04-27  1411   * index = (epnum * 2) + direction - 1 = (epnum * 2) + 1 - 1 = (epnum * 2)
d0e96f5a71a032 drivers/usb/host/xhci-hcd.c Sarah Sharp    2009-04-27  1412   */
d0e96f5a71a032 drivers/usb/host/xhci-hcd.c Sarah Sharp    2009-04-27  1413  unsigned int xhci_get_endpoint_index(struct usb_endpoint_descriptor *desc)
d0e96f5a71a032 drivers/usb/host/xhci-hcd.c Sarah Sharp    2009-04-27 @1414  {
d0e96f5a71a032 drivers/usb/host/xhci-hcd.c Sarah Sharp    2009-04-27  1415  	unsigned int index;
d0e96f5a71a032 drivers/usb/host/xhci-hcd.c Sarah Sharp    2009-04-27  1416  	if (usb_endpoint_xfer_control(desc))
d0e96f5a71a032 drivers/usb/host/xhci-hcd.c Sarah Sharp    2009-04-27  1417  		index = (unsigned int) (usb_endpoint_num(desc)*2);
d0e96f5a71a032 drivers/usb/host/xhci-hcd.c Sarah Sharp    2009-04-27  1418  	else
d0e96f5a71a032 drivers/usb/host/xhci-hcd.c Sarah Sharp    2009-04-27  1419  		index = (unsigned int) (usb_endpoint_num(desc)*2) +
d0e96f5a71a032 drivers/usb/host/xhci-hcd.c Sarah Sharp    2009-04-27  1420  			(usb_endpoint_dir_in(desc) ? 1 : 0) - 1;
d0e96f5a71a032 drivers/usb/host/xhci-hcd.c Sarah Sharp    2009-04-27  1421  	return index;
d0e96f5a71a032 drivers/usb/host/xhci-hcd.c Sarah Sharp    2009-04-27  1422  }
d0e96f5a71a032 drivers/usb/host/xhci-hcd.c Sarah Sharp    2009-04-27  1423  

:::::: The code at line 1414 was first introduced by commit
:::::: d0e96f5a71a032ced0c35f521c1cbd67e816922a USB: xhci: Control transfer support.

:::::: TO: Sarah Sharp <sarah.a.sharp@linux.intel.com>
:::::: CC: Greg Kroah-Hartman <gregkh@suse.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

