Return-Path: <linux-kernel+bounces-18554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51906825F3C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 11:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD8A61F22944
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 10:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708AB6FA4;
	Sat,  6 Jan 2024 10:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E4Oqoovo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8AB6AA3
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 10:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704537445; x=1736073445;
  h=date:from:cc:subject:message-id:mime-version;
  bh=a/lr4XlLWhoYcg5llzX65/RUGeaFKV+dNYep7WC2tAs=;
  b=E4Oqoovo60owEWXpRKNCLJsSdmqhGmqWLnmyfuZ0WC5M+gwPba+Nklib
   UgFGd81jy+jOFKTYXMIEjVrHtq0yk/rFPAgwOWzJ/rIfNbtwXvxPfstYz
   brsDX4psRNegUWcd5gJkYX+XkUdLlVb3YjbcMf6EDsltTHZzp20hfizu1
   ehWOK2x7Y+SStvIYhzrmuSnoouXr7NocaLHf+Q/J/rqyDDVPNbrCblQGU
   824X+QthXs7CCh2JTRBjCZnrUng33alQEAVBl+gHFrwDjh24KNuwYbmSx
   G5r1zgzbPkjNCUbjNig2ckXQW2G4Kj57fO9V/8PYXO9CZZLyZxrvR8S9p
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="400406159"
X-IronPort-AV: E=Sophos;i="6.04,336,1695711600"; 
   d="scan'208";a="400406159"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2024 02:37:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="809774404"
X-IronPort-AV: E=Sophos;i="6.04,336,1695711600"; 
   d="scan'208";a="809774404"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 06 Jan 2024 02:37:23 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rM43N-0002M6-1o;
	Sat, 06 Jan 2024 10:37:21 +0000
Date: Sat, 6 Jan 2024 18:36:48 +0800
From: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/comedi/drivers/tests/../ni_stc.h:1140:35: warning:
 'range_ni_E_ao_ext' defined but not used
Message-ID: <202401061842.LfwqRo6V-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Greg,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   95c8a35f1c017327eab3b6a2ff5c04255737c856
commit: 8ffdff6a8cfbdc174a3a390b6f825a277b5bb895 staging: comedi: move out of staging directory
date:   2 years, 9 months ago
config: x86_64-randconfig-005-20240105 (https://download.01.org/0day-ci/archive/20240106/202401061842.LfwqRo6V-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240106/202401061842.LfwqRo6V-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401061842.LfwqRo6V-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/comedi/drivers/tests/ni_routes_test.c:23:0:
>> drivers/comedi/drivers/tests/../ni_stc.h:1140:35: warning: 'range_ni_E_ao_ext' defined but not used [-Wunused-const-variable=]
    static const struct comedi_lrange range_ni_E_ao_ext;
                                      ^~~~~~~~~~~~~~~~~


vim +/range_ni_E_ao_ext +1140 drivers/comedi/drivers/tests/../ni_stc.h

a8b774308dd803 drivers/staging/comedi/drivers/ni_stc.h David Schleef     2009-02-12  1139  
35bb871663ddb0 drivers/staging/comedi/drivers/ni_stc.h H Hartley Sweeten 2015-05-01 @1140  static const struct comedi_lrange range_ni_E_ao_ext;
35bb871663ddb0 drivers/staging/comedi/drivers/ni_stc.h H Hartley Sweeten 2015-05-01  1141  

:::::: The code at line 1140 was first introduced by commit
:::::: 35bb871663ddb06df9d601b32deac5f4f06b65b4 staging: comedi: ni_stc.h: final cleanup

:::::: TO: H Hartley Sweeten <hsweeten@visionengravers.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

