Return-Path: <linux-kernel+bounces-27012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FAD82E923
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 06:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD5031F23A2D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 05:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701918495;
	Tue, 16 Jan 2024 05:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EWw1sbzb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B971097B
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 05:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705382262; x=1736918262;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SgKiKbs4LMIuNGhYx1gn6EfRcrjIfKvNEf77nrfFNgM=;
  b=EWw1sbzbC+sKgz0RBHlWaSOOyCTULlvKFDlpoR/3yWWxxC93QbXlIbL9
   w5vbgKucCAMT1615w9Q0TZmO/bdVz0XzXvr1KfcuQsIEN9+ybEOrEew86
   kjRQtX1IuygJkqr7Z1E4z0+a3emqfBoVt5N9ofT36WZ9qq1mdsAxVYeV9
   Xfv/GNKimqKmPk1veaRyx92nrZMbDAGcmIy/Bi4LxBOHnW7jXBJI+fzTv
   IRj3bNXPMKaEzRIL6iG8I+PaIHnx9u2zERGGnQcUI3Y0O/OeeBbOOcTzh
   P6mgZNqFut/6AuDKqqTADcVo2oOfRLjxWsBI5r6uzI4L01ie5WJJrOQ8B
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="6852922"
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; 
   d="scan'208";a="6852922"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 21:17:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="957025011"
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; 
   d="scan'208";a="957025011"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 15 Jan 2024 21:17:39 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rPbpQ-00003y-2R;
	Tue, 16 Jan 2024 05:17:36 +0000
Date: Tue, 16 Jan 2024 13:17:07 +0800
From: kernel test robot <lkp@intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/base/regmap/regmap-raw-ram.c:24:24: sparse: sparse: cast to
 restricted __be16
Message-ID: <202401161310.c6pnGfTT-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   052d534373b7ed33712a63d5e17b2b6cdbce84fd
commit: 65dd2f671875b1d97b6fa9bcf7677f5e1c55f776 regmap: Provide a ram backed regmap with raw support
date:   7 months ago
config: x86_64-randconfig-123-20240106 (https://download.01.org/0day-ci/archive/20240116/202401161310.c6pnGfTT-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240116/202401161310.c6pnGfTT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401161310.c6pnGfTT-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/base/regmap/regmap-raw-ram.c:24:24: sparse: sparse: cast to restricted __be16
>> drivers/base/regmap/regmap-raw-ram.c:26:24: sparse: sparse: cast to restricted __le16

vim +24 drivers/base/regmap/regmap-raw-ram.c

    18	
    19	static unsigned int decode_reg(enum regmap_endian endian, const void *reg)
    20	{
    21		const u16 *r = reg;
    22	
    23		if (endian == REGMAP_ENDIAN_BIG)
  > 24			return be16_to_cpu(*r);
    25		else
  > 26			return le16_to_cpu(*r);
    27	}
    28	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

