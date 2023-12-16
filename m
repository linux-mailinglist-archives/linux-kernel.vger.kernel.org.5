Return-Path: <linux-kernel+bounces-1983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7432B8156B4
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 04:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 318D5285D9C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 03:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B755538F;
	Sat, 16 Dec 2023 03:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UzR69Fbn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4A41FDA;
	Sat, 16 Dec 2023 03:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702696682; x=1734232682;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wyWUUzZO259IedYMAoIcGOmFoX5vdeINYbm46xHknGw=;
  b=UzR69FbnQWZe8la8WoiiNLC6+HPbeoaNHuQPKyqw/hsaM1wcFO4TLwel
   nvuQisy0TCO+vyHFzgiN5Dl6KM+/xLVSzSN/lpY+db92iGY4tBjjfw+JB
   Pka15SLF0XO029ha0PoWtVV03UbJVBLhTVN/0rCEIzLFjzfiEbnf0ZDJl
   Jg91hRcx1RQL5kfhsOH2vcuZUmenYC9PU+b7/6ENb3n2drz3dorzeWwBV
   Z68bCy1H86Rn5eaNsdx37DBayzI39exVnbWUKXeAHj2gevVr44751Wcf+
   Sfl5FPgX36mI/3wgNz3YRgMDr9h6C7Dnk25+oeMbZUnU46IHR+Tyhy1p+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="461812251"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="461812251"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 19:18:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="724650666"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="724650666"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 15 Dec 2023 19:17:58 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rELBc-00015w-2Q;
	Sat, 16 Dec 2023 03:17:56 +0000
Date: Sat, 16 Dec 2023 11:16:57 +0800
From: kernel test robot <lkp@intel.com>
To: Chunyan Zhang <chunyan.zhang@unisoc.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] arm64: dts: sprd: Add support for Unisoc's UMS9620
Message-ID: <202312161154.pVCPezKU-lkp@intel.com>
References: <20231215085630.984892-5-chunyan.zhang@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215085630.984892-5-chunyan.zhang@unisoc.com>

Hi Chunyan,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on lee-mfd/for-mfd-next tty/tty-next tty/tty-linus krzk/for-next krzk-mem-ctrl/for-next linus/master v6.7-rc5 next-20231215]
[cannot apply to tty/tty-testing lee-mfd/for-mfd-fixes]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chunyan-Zhang/dt-bindings-mfd-sprd-Add-support-for-UMS9620/20231215-165956
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20231215085630.984892-5-chunyan.zhang%40unisoc.com
patch subject: [PATCH 4/4] arm64: dts: sprd: Add support for Unisoc's UMS9620
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20231216/202312161154.pVCPezKU-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231216/202312161154.pVCPezKU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312161154.pVCPezKU-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/arm64/boot/dts/sprd/ums9620-2h10.dts:10:
>> arch/arm64/boot/dts/sprd/ums9620.dtsi:8:10: fatal error: dt-bindings/clock/sprd,ums9620-clk.h: No such file or directory
       8 | #include <dt-bindings/clock/sprd,ums9620-clk.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.


vim +8 arch/arm64/boot/dts/sprd/ums9620.dtsi

   > 8	#include <dt-bindings/clock/sprd,ums9620-clk.h>
     9	#include <dt-bindings/interrupt-controller/arm-gic.h>
    10	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

