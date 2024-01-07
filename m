Return-Path: <linux-kernel+bounces-18906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 371B98264F7
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 17:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D26ED1F2243C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 16:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1EB13AC8;
	Sun,  7 Jan 2024 16:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KS9cRpZL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EE513FF2
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 16:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704643771; x=1736179771;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pbzbwueR6azseIyoosxBA8lVRb3S3TRduNcuhuZDD2U=;
  b=KS9cRpZLhhO6/clSVZ+KABKm5eq31UF0f7F3ScGWSiL5DCRjNOF6qy6x
   FPgG829OFTSfH2jhqbTYuk6mvkRMViiVAC70yoQvJRsvgkpm4TFEwV4PK
   7msB4TeEnirYTcaEXOOAgcNq4rv4ZdblUB749Hd6KoMDA5X/io3oF3sAv
   wEEeZlK0d97wWDbOl52r5l8CwcL62YSClIDvFBa/O5mM/dLAR7BsgKheJ
   XKWQ7Pr8IT+TGuI/9rXLTc7omxuvAXvGsS3LtxEYJUdkWJK/QQojsKII0
   LSIwDzWqrt2DWzAqEj4iCR8gQ9Q9C+CWyElLBOf1fddmaSQ+UxlGUkFtj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="483919016"
X-IronPort-AV: E=Sophos;i="6.04,339,1695711600"; 
   d="scan'208";a="483919016"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2024 08:09:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="810001637"
X-IronPort-AV: E=Sophos;i="6.04,339,1695711600"; 
   d="scan'208";a="810001637"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 07 Jan 2024 08:09:27 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rMViH-0003u8-1a;
	Sun, 07 Jan 2024 16:09:25 +0000
Date: Mon, 8 Jan 2024 00:08:26 +0800
From: kernel test robot <lkp@intel.com>
To: Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
	Sumit Garg <sumit.garg@linaro.org>,
	Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: include/linux/tpm.h:290:2: warning: field  within 'struct
 tpm_header' is less aligned than 'union tpm_header::(anonymous at
 include/linux/tpm.h:290:2)' and is usually due to 'struct tpm_header' being
 packed, which can lead to unaligned accesses
Message-ID: <202401072350.jkkVKE5l-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   52b1853b080a082ec3749c3a9577f6c71b1d4a90
commit: be07858fbf8115fc74528292c2ee8775fe49116f KEYS: trusted: allow use of TEE as backend without TCG_TPM support
date:   1 year, 8 months ago
config: arm-randconfig-001-20240107 (https://download.01.org/0day-ci/archive/20240107/202401072350.jkkVKE5l-lkp@intel.com/config)
compiler: clang version 18.0.0git (https://github.com/llvm/llvm-project 7e186d366d6c7def0543acc255931f617e76dff0)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240107/202401072350.jkkVKE5l-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401072350.jkkVKE5l-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from security/keys/trusted-keys/trusted_core.c:10:
   In file included from include/keys/trusted-type.h:12:
>> include/linux/tpm.h:290:2: warning: field  within 'struct tpm_header' is less aligned than 'union tpm_header::(anonymous at include/linux/tpm.h:290:2)' and is usually due to 'struct tpm_header' being packed, which can lead to unaligned accesses [-Wunaligned-access]
     290 |         union {
         |         ^
   1 warning generated.


vim +290 include/linux/tpm.h

74edff2d74c64c Sumit Garg 2019-10-16  286  
74edff2d74c64c Sumit Garg 2019-10-16  287  struct tpm_header {
74edff2d74c64c Sumit Garg 2019-10-16  288  	__be16 tag;
74edff2d74c64c Sumit Garg 2019-10-16  289  	__be32 length;
74edff2d74c64c Sumit Garg 2019-10-16 @290  	union {
74edff2d74c64c Sumit Garg 2019-10-16  291  		__be32 ordinal;
74edff2d74c64c Sumit Garg 2019-10-16  292  		__be32 return_code;
74edff2d74c64c Sumit Garg 2019-10-16  293  	};
74edff2d74c64c Sumit Garg 2019-10-16  294  } __packed;
74edff2d74c64c Sumit Garg 2019-10-16  295  

:::::: The code at line 290 was first introduced by commit
:::::: 74edff2d74c64ca5977a57efb5c238c8f5318ba9 tpm: Move tpm_buf code to include/linux/

:::::: TO: Sumit Garg <sumit.garg@linaro.org>
:::::: CC: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

