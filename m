Return-Path: <linux-kernel+bounces-95-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 949B9813C18
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C772B1C20C5A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 20:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC2F6E2A6;
	Thu, 14 Dec 2023 20:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QY2qj9TL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C176DD13
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 20:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702587257; x=1734123257;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5RFrTiDkgQjFafKopHq8ArNGfJEb513KvmN0cOMPiFk=;
  b=QY2qj9TLvILRHh+f4a6uogQAuLgNHtqLgconcVi81xghXsgkg8Z+myR8
   N2ZJkTT3diwbi63o1o5GNHUVYKbweELjprWcFf0Q+oLquwgLIOK9hEPTg
   kllHQPE8Hi+VEvr1zEncqJKXnhVBESrz3MVA6/DLQBKyL0pXq4UxZmG/m
   zs/wgbHDxowrIgW8Ns87Qw4Z64hRvtpP2CEHbNDMVuQc/qroL68qEj88c
   3rz/Unkq2lEfVDs92/9BeHrowGTlrcvt9IkIwas6712/67Ck61GBIA6LL
   EDCQfEcvEyLqJ/E4snpQvcPMwaapPIff9ky0A4080FUOeD7+2gzooTpMM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="13876901"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="13876901"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 12:54:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="947719009"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="947719009"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 14 Dec 2023 12:54:13 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rDsih-000Mbh-1T;
	Thu, 14 Dec 2023 20:54:11 +0000
Date: Fri, 15 Dec 2023 04:53:19 +0800
From: kernel test robot <lkp@intel.com>
To: Kees Cook <keescook@chromium.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Peter Oberparleiter <oberpar@linux.ibm.com>
Subject: kernel/gcov/fs.c:103: warning: Excess struct member 'buffer'
 description in 'gcov_iterator'
Message-ID: <202312150432.oBngC94A-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5bd7ef53ffe5ca580e93e74eb8c81ed191ddc4bd
commit: fbd126f5a658b92c7f6af986a6d89cf5e5693268 gcov: annotate struct gcov_iterator with __counted_by
date:   8 weeks ago
config: i386-buildonly-randconfig-001-20231214 (https://download.01.org/0day-ci/archive/20231215/202312150432.oBngC94A-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231215/202312150432.oBngC94A-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312150432.oBngC94A-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/gcov/fs.c:103: warning: Excess struct member 'buffer' description in 'gcov_iterator'


vim +103 kernel/gcov/fs.c

7a1d55b987dfcb Johannes Berg 2021-05-06   90  
7a1d55b987dfcb Johannes Berg 2021-05-06   91  /**
7a1d55b987dfcb Johannes Berg 2021-05-06   92   * struct gcov_iterator - specifies current file position in logical records
7a1d55b987dfcb Johannes Berg 2021-05-06   93   * @info: associated profiling data
7a1d55b987dfcb Johannes Berg 2021-05-06   94   * @buffer: buffer containing file data
7a1d55b987dfcb Johannes Berg 2021-05-06   95   * @size: size of buffer
7a1d55b987dfcb Johannes Berg 2021-05-06   96   * @pos: current position in file
7a1d55b987dfcb Johannes Berg 2021-05-06   97   */
7a1d55b987dfcb Johannes Berg 2021-05-06   98  struct gcov_iterator {
7a1d55b987dfcb Johannes Berg 2021-05-06   99  	struct gcov_info *info;
7a1d55b987dfcb Johannes Berg 2021-05-06  100  	size_t size;
7a1d55b987dfcb Johannes Berg 2021-05-06  101  	loff_t pos;
fbd126f5a658b9 Kees Cook     2023-09-22  102  	char buffer[] __counted_by(size);
7a1d55b987dfcb Johannes Berg 2021-05-06 @103  };
7a1d55b987dfcb Johannes Berg 2021-05-06  104  

:::::: The code at line 103 was first introduced by commit
:::::: 7a1d55b987dfcbddecdb67eecc76fe555d4348ba gcov: combine common code

:::::: TO: Johannes Berg <johannes.berg@intel.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

