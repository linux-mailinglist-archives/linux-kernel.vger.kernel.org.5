Return-Path: <linux-kernel+bounces-152374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B1B8ABD12
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 22:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AB3B281769
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 20:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFB647F59;
	Sat, 20 Apr 2024 20:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CtL6aKTn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6863B1CA8F;
	Sat, 20 Apr 2024 20:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713645115; cv=none; b=o5DdgPnqGhoXpSEmtgKPnjdotXOfNxqU6PBh9UNE8px71xOuZlNZpCjpw6S7Pty/SOqWk7ZJHe9Wto47pIXWDux3hzCjXGK7EGRS1fmvAkaE8ak9j9oMm3nAhu2QE5GdjitUr6w1YHiOsWsyVeqp15rTjlx4V4vmvKwZhDuZqlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713645115; c=relaxed/simple;
	bh=p2ZIMK/k4MqAZrCR3Md+JOFS9Vv/Q9vxmsMr84nl+gc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dDBvnJdR8hLl4pWilUNb4uZBJTKAQJW4zTiS2uKr8ebgmtbwjxKAsbHA+gadsspQi4trGRB77H6N6T+JXqYv9WNswMmnw8BDpGtr2aWd3tWOnhKxIPGB6KgoA6C2pT/FYRSMyc1I8KwHnVNdiTEwooIpBo4lm2bfRn/lzpN6PEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CtL6aKTn; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713645113; x=1745181113;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p2ZIMK/k4MqAZrCR3Md+JOFS9Vv/Q9vxmsMr84nl+gc=;
  b=CtL6aKTnwoe9ZMw7LdDZegF+mP2nzsgFYsqMbMSWV6TEzWqNuVG0pL1m
   bsr1FOup+d3x0IMc7nI2Ak9CSrmcu5kZAr8AJ3joy4esZb8GRm60IdMHA
   p2IlCMPY+/yCfA1AE4QCEn4pgBLcGVFu07MKnf+7uYSZLHU0jZIVrWMtS
   5xoYsVzEjXsNC5de89Uc+q7hIaxi164UNKzFSHxKUA1PLZLINS9XFmIt7
   YrkDMf1ji5DxVI6D5FmsTUA+rkQD7/WBRDA1BELCfxG8qiv0Rom3Steu8
   62+6woVuta7dGhDChG95ibR0fPq/8d5Hjf4ic1il19iuLUmCsnmdLHtK/
   Q==;
X-CSE-ConnectionGUID: +5mai65QS2GmTKC3DvAORg==
X-CSE-MsgGUID: d/k5P9BoSLyWLSEJwpT+uA==
X-IronPort-AV: E=McAfee;i="6600,9927,11050"; a="12167729"
X-IronPort-AV: E=Sophos;i="6.07,217,1708416000"; 
   d="scan'208";a="12167729"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2024 13:31:53 -0700
X-CSE-ConnectionGUID: vdq9eBAkRCicrEhDrT2EIg==
X-CSE-MsgGUID: b5QPJxtTQ8iuDWvZLP/pUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,217,1708416000"; 
   d="scan'208";a="23625935"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 20 Apr 2024 13:31:47 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ryHNB-000BTG-0Q;
	Sat, 20 Apr 2024 20:31:45 +0000
Date: Sun, 21 Apr 2024 04:31:05 +0800
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
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Jisheng Zhang <jszhang@kernel.org>,
	Liu Gui <kenneth.liu@sophgo.com>,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>, dlan@gentoo.org,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 2/2] phy: sophgo: Add USB 2.0 PHY driver for Sophgo
 CV18XX/SG200X
Message-ID: <202404210410.QDkV5tzV-lkp@intel.com>
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
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20240421/202404210410.QDkV5tzV-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 7089c359a3845323f6f30c44a47dd901f2edfe63)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240421/202404210410.QDkV5tzV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404210410.QDkV5tzV-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/phy/sophgo/phy-cv1800-usb.c:14:
   In file included from include/linux/of_address.h:7:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/phy/sophgo/phy-cv1800-usb.c:14:
   In file included from include/linux/of_address.h:7:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/phy/sophgo/phy-cv1800-usb.c:14:
   In file included from include/linux/of_address.h:7:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   In file included from drivers/phy/sophgo/phy-cv1800-usb.c:17:
   In file included from include/linux/phy/phy.h:17:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:21:
   In file included from include/linux/mm.h:2208:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/phy/sophgo/phy-cv1800-usb.c:20:10: fatal error: 'soc/sophgo/cv1800-sysctl.h' file not found
      20 | #include <soc/sophgo/cv1800-sysctl.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   7 warnings and 1 error generated.


vim +20 drivers/phy/sophgo/phy-cv1800-usb.c

  > 20	#include <soc/sophgo/cv1800-sysctl.h>
    21	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

