Return-Path: <linux-kernel+bounces-152442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C11368ABE7A
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 05:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FED7B20D3E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 03:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F88D2EE;
	Sun, 21 Apr 2024 03:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h/uPVMau"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD144C8B;
	Sun, 21 Apr 2024 03:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713670399; cv=none; b=SbsTCkXtFy1M++16cq4SHLwS3BuNAZZPECzG4Y+blj81FuVje3KVH4bIN6Epn3spU4f+/oMtcnmLuC+C0es+SXCxbDcxNHhNsmAiNj9x7b66bT6Iy3ncFYOsg5lTSF7SScQLxwuuK4FvXwHCBfL+RfSZoi4LyQXugCa+jGBwYzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713670399; c=relaxed/simple;
	bh=LBIQRbltK56dYLTITMXI0bI+xyVYUlz+U20zt2FHxxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QRf9YndCEel6XwOZXDH8hla5GVpFcubwWM3n3J+pvg6eEePcpUrC85LaBiVGErU20aMp6ysmoEbu0NTk6HpB5dPh2gGDceQP7FQuejbPnFDfrg8Ev72SFgaoXsNef8QzH6/vHQqrYYs4uZdP3ARQh9Hzesyj5jFo9AfxGEWXjwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h/uPVMau; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713670394; x=1745206394;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LBIQRbltK56dYLTITMXI0bI+xyVYUlz+U20zt2FHxxc=;
  b=h/uPVMau10cK4fV7wt2+g42FAzFuNrXPgEsI8WER0toIO4f4WDH2J0GA
   xy7TPgMpNERokxzPiuclDBGsfSOvzAFf0FTl7BpAZaW+qUMVSqYyGxPzp
   O2oamEwd+Ai0vtX2zJjoOdwCJc8dUBJjASoPah1Uo/5Jtq7NNL4qT938e
   +Fq+NuQdAqELULXWPM+dewhZHBCOenDvTTl/EsHq/ypyIAsqtvwzV/hCq
   qy0STQ/FSSys99wv8fDL7lvSBDViFtgymulX/vvGjgUu2i9ogBchsJMyq
   YWvGIN9XLKnFkyWSThBzcBsvTTkQ8PFCmtRd+jNZv5UMGNm9dcJNFsmiX
   Q==;
X-CSE-ConnectionGUID: p1/iZguuSu2mKvSM4IqXaQ==
X-CSE-MsgGUID: 8CNiq9TBSJ6dSL7/J2FRig==
X-IronPort-AV: E=McAfee;i="6600,9927,11050"; a="9406041"
X-IronPort-AV: E=Sophos;i="6.07,217,1708416000"; 
   d="scan'208";a="9406041"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2024 20:33:13 -0700
X-CSE-ConnectionGUID: jcr1JPZJT4+c6ciAN+dwBA==
X-CSE-MsgGUID: PsOdNAeKRSSwrcSD91eYTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,217,1708416000"; 
   d="scan'208";a="24311007"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 20 Apr 2024 20:33:08 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ryNww-000Beu-0C;
	Sun, 21 Apr 2024 03:33:06 +0000
Date: Sun, 21 Apr 2024 11:32:58 +0800
From: kernel test robot <lkp@intel.com>
To: Inochi Amaoto <inochiama@outlook.com>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: oe-kbuild-all@lists.linux.dev, Jisheng Zhang <jszhang@kernel.org>,
	Liu Gui <kenneth.liu@sophgo.com>,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>, dlan@gentoo.org,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 2/2] phy: sophgo: Add USB 2.0 PHY driver for Sophgo
 CV18XX/SG200X
Message-ID: <202404211157.zejQ9FZ1-lkp@intel.com>
References: <IA1PR20MB4953EB2E2BF9D5F1EE30E2D4BB042@IA1PR20MB4953.namprd20.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA1PR20MB4953EB2E2BF9D5F1EE30E2D4BB042@IA1PR20MB4953.namprd20.prod.outlook.com>

Hi Inochi,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v6.9-rc4 next-20240419]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Inochi-Amaoto/dt-bindings-phy-Add-Sophgo-CV1800-USB-phy/20240412-152532
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/IA1PR20MB4953EB2E2BF9D5F1EE30E2D4BB042%40IA1PR20MB4953.namprd20.prod.outlook.com
patch subject: [PATCH 2/2] phy: sophgo: Add USB 2.0 PHY driver for Sophgo CV18XX/SG200X
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20240421/202404211157.zejQ9FZ1-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240421/202404211157.zejQ9FZ1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404211157.zejQ9FZ1-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/phy/sophgo/phy-cv1800-usb.c:20:10: fatal error: soc/sophgo/cv1800-sysctl.h: No such file or directory
      20 | #include <soc/sophgo/cv1800-sysctl.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.


vim +20 drivers/phy/sophgo/phy-cv1800-usb.c

  > 20	#include <soc/sophgo/cv1800-sysctl.h>
    21	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

