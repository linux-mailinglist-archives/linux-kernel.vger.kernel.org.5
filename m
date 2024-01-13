Return-Path: <linux-kernel+bounces-25152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CDC82C89D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 02:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99033B24371
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 01:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7DE14001;
	Sat, 13 Jan 2024 01:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D3Pu4PuP"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2170C199AA;
	Sat, 13 Jan 2024 01:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705108654; x=1736644654;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E438uW/rLScP3NrrSZ/+vU2ZbR/Hk3/BAayHZre5Mjg=;
  b=D3Pu4PuPrTly6TDwFNVNo4Gn0oOucpdB+PKluoGmmYHm7BXXa4dY/Irt
   wG2Tu0HA7M4bn6V6/+GPq4Zh+sm7nuzJvYxzEar34/NlHzf0j/Cltiyaj
   L+4tTc8/iHp9+K8ZF0L5ZX0gIGRhdTFP6ZdO1/qlJidEijbog60biFzdk
   v1LJjjTRwAJI1mkhmZjoU6hkmhSNaw9ntWg9n2kbjpvA+yINd/VuLNR9D
   v5TOqop4wBl5CaUv2ywqVKzbCpkbiTkjz+R0Jk/VZrSD5CWJYtyQpbEhs
   iRhw/k6g51kSOxnCvkenNSoaC0V4/CLlhkj+Wdy1jcC7zJJr4SX9liMqb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="389777274"
X-IronPort-AV: E=Sophos;i="6.04,191,1695711600"; 
   d="scan'208";a="389777274"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 17:17:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="1030096755"
X-IronPort-AV: E=Sophos;i="6.04,191,1695711600"; 
   d="scan'208";a="1030096755"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 12 Jan 2024 17:17:29 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rOSeM-0009xP-0b;
	Sat, 13 Jan 2024 01:17:26 +0000
Date: Sat, 13 Jan 2024 09:17:05 +0800
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
Cc: oe-kbuild-all@lists.linux.dev,
	Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
	Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
	openbmc@lists.ozlabs.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] ARM64: dts: nuvoton: Add initial yosemitev4
 device tree
Message-ID: <202401130946.VGBtdkKu-lkp@intel.com>
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
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20240113/202401130946.VGBtdkKu-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240113/202401130946.VGBtdkKu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401130946.VGBtdkKu-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-yosemite4.dts:6:10: fatal error: nuvoton-npcm845-pincfg-evb.dtsi: No such file or directory
       6 | #include "nuvoton-npcm845-pincfg-evb.dtsi"
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.


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

