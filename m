Return-Path: <linux-kernel+bounces-25201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC7F82CA2E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 07:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8038D1C2265E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 06:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1603134DD;
	Sat, 13 Jan 2024 06:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WKF91vYX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3FCFBE1;
	Sat, 13 Jan 2024 06:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705126240; x=1736662240;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Eld4MoQpbkUQ2AJhP3wOklAVBHkSsTYQWgcDlJwGMEo=;
  b=WKF91vYXXfBwK7dbFj69h2eyzfTvOslUEiN6TPU1o5wYsr+iiyNSV2C5
   L2H8FIkpyOCWJDw2PHP7ZljqJYxctinILX3rVo4TELvpYc/7htNYXGuls
   s04sz0ro6RnbODD/xSCgE+HzZTSuckwlDk3z7rK9FwvZiBptv/pr5bwqT
   wrPc6BuXkgTcl1yC5hivmjRVPG49foMBW3Ocgs58kgx0Oq+Q7Vck2eXBr
   ppKlu0uQWcvOEla8NZP3FEafyOxxIyFf5QxF8oaHoD5WDb5xa9SLv4GZp
   zxjhAVBfW/uA/dZGUTHc2IZaj9oRmtYzdI3ZGQB1KuIB29IPcyS3m6Ks4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="6074976"
X-IronPort-AV: E=Sophos;i="6.04,191,1695711600"; 
   d="scan'208";a="6074976"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 22:10:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="783260272"
X-IronPort-AV: E=Sophos;i="6.04,191,1695711600"; 
   d="scan'208";a="783260272"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 12 Jan 2024 22:10:35 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rOXE0-000A9q-1g;
	Sat, 13 Jan 2024 06:10:32 +0000
Date: Sat, 13 Jan 2024 14:10:02 +0800
From: kernel test robot <lkp@intel.com>
To: Catalin Popescu <catalin.popescu@leica-geosystems.com>,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, afd@ti.com,
	andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Catalin Popescu <catalin.popescu@leica-geosystems.com>
Subject: Re: [PATCH 1/3] dt-bindings: net: dp83826: add ti,cfg-dac-minus
 binding
Message-ID: <202401131320.WhWHSzeD-lkp@intel.com>
References: <20240111161927.3689084-1-catalin.popescu@leica-geosystems.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111161927.3689084-1-catalin.popescu@leica-geosystems.com>

Hi Catalin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on net-next/main net/main linus/master v6.7 next-20240112]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Catalin-Popescu/dt-bindings-net-dp83826-add-ti-cfg-dac-plus-binding/20240112-002701
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20240111161927.3689084-1-catalin.popescu%40leica-geosystems.com
patch subject: [PATCH 1/3] dt-bindings: net: dp83826: add ti,cfg-dac-minus binding
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240113/202401131320.WhWHSzeD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401131320.WhWHSzeD-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
>> Documentation/devicetree/bindings/net/ti,dp83822.yaml: ti,cfg-dac-minus: missing type definition
   Documentation/devicetree/bindings/net/snps,dwmac.yaml: mac-mode: missing type definition

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

