Return-Path: <linux-kernel+bounces-2450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 479A0815D53
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 04:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A02A1C21739
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 03:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E9D139B;
	Sun, 17 Dec 2023 03:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WAnxbK/G"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B758ED8;
	Sun, 17 Dec 2023 03:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702784482; x=1734320482;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HIJ42y95u2T2fGlqS6b5WZJhajVO2Bqgecuh49Ux0bQ=;
  b=WAnxbK/G/cfzvJWNOmH4rX0graHdnMmjU+Tp7Sc1eQVhBysXUSG696A+
   VJKIA7eme0CJJGZoVKpTxJHzQ3a7fCgGQbccW3G7DS51QuKjCP7Y6lo9y
   Z8zV4ketSPJKznWLCYNiRtSIDT07ivh8ctEE4UdNJpTJSp0sio+RyvxiI
   ND4h/QDUPTx8QTymJqALO4kYZILwe3cKWrU55NLb9RDVDaAqiq2xHPGg0
   tH1CbglDBnxzQKCYE2nTNU4Knf+k7zA4MICeULMWxGOEfpNmUm0+nIQKP
   1N3Gx8CiwYjyI/T3qWGcbJw1PAN1AYZVtX4aZWIKpw/QxTuygMJd4ghK8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10926"; a="14084164"
X-IronPort-AV: E=Sophos;i="6.04,282,1695711600"; 
   d="scan'208";a="14084164"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2023 19:41:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10926"; a="751371940"
X-IronPort-AV: E=Sophos;i="6.04,282,1695711600"; 
   d="scan'208";a="751371940"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 16 Dec 2023 19:41:17 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEi1i-0002aa-2D;
	Sun, 17 Dec 2023 03:41:14 +0000
Date: Sun, 17 Dec 2023 11:41:03 +0800
From: kernel test robot <lkp@intel.com>
To: Chunyan Zhang <chunyan.zhang@unisoc.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] arm64: dts: sprd: Add support for Unisoc's UMS9620
Message-ID: <202312171120.HfHwFDeV-lkp@intel.com>
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
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20231217/202312171120.HfHwFDeV-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231217/202312171120.HfHwFDeV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312171120.HfHwFDeV-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/arm64/boot/dts/sprd/ums9620-2h10.dts:10:
>> arch/arm64/boot/dts/sprd/ums9620.dtsi:8:10: fatal error: 'dt-bindings/clock/sprd,ums9620-clk.h' file not found
       8 | #include <dt-bindings/clock/sprd,ums9620-clk.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +8 arch/arm64/boot/dts/sprd/ums9620.dtsi

   > 8	#include <dt-bindings/clock/sprd,ums9620-clk.h>
     9	#include <dt-bindings/interrupt-controller/arm-gic.h>
    10	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

