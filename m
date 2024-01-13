Return-Path: <linux-kernel+bounces-25261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5444F82CBD3
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 11:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 034C21F213F0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 10:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBEF17BD0;
	Sat, 13 Jan 2024 10:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RhtHFoH8"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CB817BDC;
	Sat, 13 Jan 2024 10:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705141728; x=1736677728;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NcXtWDYE1l26Z+EO8wj7DrnFq2sZpKD4cbxy9EEC3xA=;
  b=RhtHFoH8DcwDTq09x0yPKz/UCDo6AyLjxL+/zl2kHfVdoksBspB4IqGw
   8jWLgUEAuBPv3uUPh+J7vLtFb80NPD7d9oUuDFMbTict0g1lFCtQuEdNN
   wTWza/D72VIB+dpuJZnxTYEHT6qpd14uyarIJIqmmdHJOwXddBr61dutk
   8IB9Czk/pQg/CWZAcG3WDTfUZgQOR3NGaYhWWQweYvigRJ7Mk2dAhgGHp
   gLLXX58aOZCyubSxBCk3AnmsGi8SOp5wjN6ysrcrRm8FxMwnt+Ycv02FL
   s7SyqfErFBMzYwBsqGNVSrdCMxX8MVT1vMXsOqd9MmhO3Trrvg4ztJ63J
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="399047114"
X-IronPort-AV: E=Sophos;i="6.04,192,1695711600"; 
   d="scan'208";a="399047114"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2024 02:28:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,192,1695711600"; 
   d="scan'208";a="25272553"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 13 Jan 2024 02:28:44 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rObFp-000ALu-25;
	Sat, 13 Jan 2024 10:28:41 +0000
Date: Sat, 13 Jan 2024 18:27:58 +0800
From: kernel test robot <lkp@intel.com>
To: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>, patrick@stwcx.xyz,
	Avi Fishman <avifishman70@gmail.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Tali Perry <tali.perry1@gmail.com>,
	Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>,
	Benjamin Fair <benjaminfair@google.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
	Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
	openbmc@lists.ozlabs.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] ARM64: dts: nuvoton: Add initial yosemitev4
 device tree
Message-ID: <202401131809.AEhtmGWi-lkp@intel.com>
References: <20240112013654.1424451-3-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240112013654.1424451-3-Delphine_CC_Chiu@wiwynn.com>

Hi Delphine,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v6.7 next-20240112]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Delphine-CC-Chiu/dt-bindings-arm-nuvoton-add-Facebook-Yosemite-4-board/20240112-094033
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20240112013654.1424451-3-Delphine_CC_Chiu%40wiwynn.com
patch subject: [PATCH v1 2/2] ARM64: dts: nuvoton: Add initial yosemitev4 device tree
config: arm64-randconfig-003-20240112 (https://download.01.org/0day-ci/archive/20240113/202401131809.AEhtmGWi-lkp@intel.com/config)
compiler: clang version 18.0.0git (https://github.com/llvm/llvm-project 9bde5becb44ea071f5e1fa1f5d4071dc8788b18c)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240113/202401131809.AEhtmGWi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401131809.AEhtmGWi-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-yosemite4.dts:6:10: fatal error: 'nuvoton-npcm845-pincfg-evb.dtsi' file not found
       6 | #include "nuvoton-npcm845-pincfg-evb.dtsi"
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +6 arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-yosemite4.dts

     3	
     4	/dts-v1/;
     5	#include "nuvoton-npcm845.dtsi"
   > 6	#include "nuvoton-npcm845-pincfg-evb.dtsi"
     7	#include <dt-bindings/i2c/i2c.h>
     8	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

