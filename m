Return-Path: <linux-kernel+bounces-3151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F34B28167F9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93C241F22C5E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB4A10971;
	Mon, 18 Dec 2023 08:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E4cb0CW1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CA4101D9
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 08:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702887762; x=1734423762;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iA1kHz4wxnmDxu+/tIS0igZWZKW3FUULHA7xFRCLjgU=;
  b=E4cb0CW1RikRfCIowNGzpETsMsFA3FhbJMZiGKchLNZyqNri2WBJjEeA
   pfpio8Ribi6kpYWQ5aMj0tT/f9WlLVXCOBOmCL7aaPM4QIBcQBaKTQvro
   SR/hqXaKWg9cbEjx65KxesCv4buTEEZYj3tKKwcGLJEsbl1hY2sJxnaQs
   xFn6tH7ERm6n8/jFcklmcSzLJnvB1LquVPwzRQwAUIp8fV/aKp+rVZ6UT
   l/6Mo5QmXK+W8j5M7itZfX+rSx/L9rg8Rw86fbWbPtVkYx5CsCvH9lyux
   akurYOjavI/v6EXsKv2OGs+eLw58czcrZ93Q1RFLMY+rlU1B2EnHXqZ2P
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="2325157"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="2325157"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 00:22:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="919175593"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="919175593"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 18 Dec 2023 00:22:40 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rF8ta-0003ul-0A;
	Mon, 18 Dec 2023 08:22:38 +0000
Date: Mon, 18 Dec 2023 16:21:53 +0800
From: kernel test robot <lkp@intel.com>
To: Yang Li <yang.lee@linux.alibaba.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Zhihao Cheng <chengzhihao1@huawei.com>
Subject: scripts/kernel-doc: fs/ubifs/file.c:1385: warning: Excess function
 parameter 'time' description in 'ubifs_update_time'
Message-ID: <202312181655.uTLcappp-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ceb6a6f023fd3e8b07761ed900352ef574010bcb
commit: 48ec6328de6c153a64474d9e5b6ec95f20f4142b ubifs: Fix some kernel-doc comments
date:   7 weeks ago
config: sh-allyesconfig (https://download.01.org/0day-ci/archive/20231218/202312181655.uTLcappp-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231218/202312181655.uTLcappp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312181655.uTLcappp-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> scripts/kernel-doc: fs/ubifs/file.c:1385: warning: Excess function parameter 'time' description in 'ubifs_update_time'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

