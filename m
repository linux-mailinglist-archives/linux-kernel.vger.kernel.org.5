Return-Path: <linux-kernel+bounces-2390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBF2815C24
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 23:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECB1F283495
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 22:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B02636AF8;
	Sat, 16 Dec 2023 22:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hSbIkrTW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477B81EB25;
	Sat, 16 Dec 2023 22:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702766107; x=1734302107;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PKAg3YpsoXOf+xOOFWRygZBV1PZFjvxNCldytcqfINk=;
  b=hSbIkrTW4NEU8WjjMh23ob/GhTirRW+XxGbp0ekuom3yMxYICRpvoC0r
   ISPMWBYiIR00j9EdtrcKq6LM0u6wcm8vM/egTYbfmV8fXusGe/bIw+4ag
   4Ows1GkRxLLqUzgJjphAwts3UlmUBpWSp1ScAz2HsS5fTWcF0dTEZax3O
   an5d6pylOLrNzBSqFqOlpFH3kf1bS7D6NEnsaag9w8mpao65MNFL82ZQo
   ykHemhAgYnLn1lwFlfsbX2q3SUwlPQM+ex/YQvtt4nnOy5mYIxCCHxyqR
   J8x/2Pi93y676cCFKo6+leDabTlXoPeAGbr01NuD63k0TfyNAJ61b9Exy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10926"; a="395127323"
X-IronPort-AV: E=Sophos;i="6.04,282,1695711600"; 
   d="scan'208";a="395127323"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2023 14:35:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10926"; a="768395271"
X-IronPort-AV: E=Sophos;i="6.04,282,1695711600"; 
   d="scan'208";a="768395271"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 16 Dec 2023 14:35:02 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEdFL-0002Hl-3D;
	Sat, 16 Dec 2023 22:35:00 +0000
Date: Sun, 17 Dec 2023 06:34:58 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Marangi <ansuelsmth@gmail.com>, Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Li Zetao <lizetao1@huawei.com>, linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org
Subject: Re: [PATCH v3 1/2] leds: trigger: netdev: display only supported
 link speed attribute
Message-ID: <202312170610.BnWo2SnP-lkp@intel.com>
References: <20231214122041.17439-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214122041.17439-1-ansuelsmth@gmail.com>

Hi Christian,

kernel test robot noticed the following build errors:

[auto build test ERROR on lee-leds/for-leds-next]
[cannot apply to net-next/main net/main linus/master v6.7-rc5 next-20231215]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Marangi/docs-ABI-sysfs-class-led-trigger-netdev-Document-now-hidable-link_/20231214-202215
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git for-leds-next
patch link:    https://lore.kernel.org/r/20231214122041.17439-1-ansuelsmth%40gmail.com
patch subject: [PATCH v3 1/2] leds: trigger: netdev: display only supported link speed attribute
config: i386-buildonly-randconfig-002-20231217 (https://download.01.org/0day-ci/archive/20231217/202312170610.BnWo2SnP-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231217/202312170610.BnWo2SnP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312170610.BnWo2SnP-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: phy_speeds
   >>> referenced by ledtrig-netdev.c
   >>>               drivers/leds/trigger/ledtrig-netdev.o:(netdev_trig_notify) in archive vmlinux.a
   >>> referenced by ledtrig-netdev.c
   >>>               drivers/leds/trigger/ledtrig-netdev.o:(netdev_trig_notify) in archive vmlinux.a
   >>> referenced by ledtrig-netdev.c
   >>>               drivers/leds/trigger/ledtrig-netdev.o:(set_device_name) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

